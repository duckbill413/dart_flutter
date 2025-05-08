import * as admin from "firebase-admin";
import {onDocumentCreated} from "firebase-functions/v2/firestore";


admin.initializeApp();

// Video 생성시 썸네일 생성
export const onVideoCreated = onDocumentCreated(
    {
        document: "videos/{videoId}",
        region: "asia-northeast3",
    },
    async (event) => {
        const snapshot = event.data;
        if (!snapshot) return;

        // child-process-promise 를 통해 ffmpeg 를 사용
        const spawn = require("child-process-promise").spawn;
        const video = snapshot.data();
        // ffmpeg 를 통해 썸네일 추출 및 로컬 환경에 저장
        await spawn("ffmpeg", [
            "-i",
            video.contentPath,
            "-ss",
            "00:00:01.000",
            "-vframes",
            "1",
            "-vf",
            "scale=150:-1",
            `/tmp/${snapshot.id}.jpg`,
        ]);
        // 스토리지에 로컬 환경의 썸네일 업로드
        const storage = admin.storage();
        const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
            destination: `thumbnails/${snapshot.id}.jpg`,
        });
        await file.makePublic();
        // file 의 썸네일 URL 을 이용하여 video 정보에 등록
        await snapshot.ref.update({"thumbnailPath": file.publicUrl()});

        // db 에 정보 추가
        const db = admin.firestore();
        await db.collection("users")
            .doc(video.creatorUid)
            .collection("videos")
            .doc(snapshot.id)
            .set({
                videoId: snapshot.id,
                thumbnailPath: file.publicUrl()
            });
    });

export const onLikedCreated = onDocumentCreated(
    {
        document: "likes/{likeId}",
        region: "asia-northeast3"
    },
    async (event) => {
        const snapshot = event.data;
        if (!snapshot) return;

        const db = admin.firestore();

        const [videoId, userId] = snapshot.id.split("_");
        const thumbnailPath = (await db.collection("videos").doc(videoId).get()).data()!.thumbnailPath;

        await db
            .collection("videos")
            .doc(videoId)
            .update({likes: admin.firestore.FieldValue.increment(1)});
        await db
            .collection("users")
            .doc(userId)
            .collection("likes")
            .doc(videoId)
            .set({
                thumbnailPath: thumbnailPath as String,
                videoId: videoId,
                createdAt: admin.firestore.FieldValue.serverTimestamp()
            });
    });

export const onLikedRemoved = onDocumentCreated(
    {
        document: "likes/{likeId}",
        region: "asia-northeast3"
    },
    async (event) => {
        const snapshot = event.data;
        if (!snapshot) return;

        const db = admin.firestore();
        const [videoId, userId] = snapshot.id.split("_");
        await db
            .collection("videos")
            .doc(videoId)
            .update({likes: admin.firestore.FieldValue.increment(-1)});
        await db
            .collection("users")
            .doc(userId)
            .collection("likes")
            .doc(videoId)
            .delete();
    });