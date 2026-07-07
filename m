Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270CFC43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 12:46:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E316C4068A;
	Tue,  7 Jul 2026 14:45:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 51CF740A87
 for <dev@dpdk.org>; Tue,  7 Jul 2026 14:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DA3nEML2WjJtrbclsSP6f+kkY9zG4A79g7REs/u0SA=;
 b=TkQEzO6m6HuN8mb4Ef/DWmu1G1YYlqfCd9vKuSAEYNsORJIxE5sWbwfHLson0OE8A5IuuN
 MKPri3yLsU/M7t3Xfk+2lzMOJQDB83gWxwPlx3ewQEpPatW3CLlISxRF1zyQSHLCWg3FGJ
 +iA5cBKNZcCT86uEWd3Xm3YbGVhN3ho=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-n6_EdGqkMDK5mT15Hkk-Hw-1; Tue,
 07 Jul 2026 08:45:38 -0400
X-MC-Unique: n6_EdGqkMDK5mT15Hkk-Hw-1
X-Mimecast-MFC-AGG-ID: n6_EdGqkMDK5mT15Hkk-Hw_1783428337
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5561619540C3; Tue,  7 Jul 2026 12:45:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9F9118005B5; Tue,  7 Jul 2026 12:45:34 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, david.marchand@redhat.com,
 dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com
Subject: [RFC v4 08/11] uapi: Align vduse.h for enable and suspend VDUSE
 messages
Date: Tue,  7 Jul 2026 14:45:04 +0200
Message-ID: <20260707124507.251729-9-eperezma@redhat.com>
In-Reply-To: <20260707124507.251729-1-eperezma@redhat.com>
References: <20260707124507.251729-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uiTNUgfpi9QudzBjkzlNz8ABGS3zoqN_-rjkFKjWxB0_1783428337
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

From: Maxime Coquelin <maxime.coquelin@redhat.com>

This is a prerequisite for next patches to use them.

These features are required to properly support live migration and proper
device initialization ordering.

These are not in maintainer's branch at the moment:
https://lore.kernel.org/lkml/20260310190759.1097506-1-eperezma@redhat.com
https://lore.kernel.org/lkml/20260310191019.1099757-1-eperezma@redhat.com

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 kernel/linux/uapi/linux/vduse.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/linux/uapi/linux/vduse.h b/kernel/linux/uapi/linux/vduse.h
index 361eea511c21..b7f8c04a0a44 100644
--- a/kernel/linux/uapi/linux/vduse.h
+++ b/kernel/linux/uapi/linux/vduse.h
@@ -14,6 +14,12 @@
 
 #define VDUSE_API_VERSION_1	1
 
+/* The VDUSE instance expects a request for vq ready */
+#define VDUSE_F_QUEUE_READY	0
+
+/* The VDUSE instance expects a request for suspend */
+#define VDUSE_F_SUSPEND		1
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
@@ -63,6 +69,12 @@ struct vduse_dev_config {
  */
 #define VDUSE_DESTROY_DEV	_IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_MAX])
 
+/* Get the VDUSE supported features */
+#define VDUSE_GET_FEATURES	_IOR(VDUSE_BASE, 0x04, __u64)
+
+/* Set the VDUSE features */
+#define VDUSE_SET_FEATURES	_IOW(VDUSE_BASE, 0x05, __u64)
+
 /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
 
 /**
@@ -325,6 +337,8 @@ enum vduse_req_type {
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_SET_VQ_GROUP_ASID,
+	VDUSE_SET_VQ_READY,
+	VDUSE_SUSPEND,
 };
 
 /**
@@ -372,6 +386,15 @@ struct vduse_iova_range_v2 {
 	__u32 padding;
 };
 
+/**
+ * struct vduse_vq_ready - Virtqueue ready request message
+ * @num: Virtqueue number
+ */
+struct vduse_vq_ready {
+	__u32 num;
+	__u32 ready;
+};
+
 /**
  * struct vduse_dev_request - control request
  * @type: request type
@@ -382,6 +405,7 @@ struct vduse_iova_range_v2 {
  * @iova: IOVA range for updating
  * @iova_v2: IOVA range for updating if API_VERSION >= 1
  * @vq_group_asid: ASID of a virtqueue group
+ * @vq_ready: Virtqueue ready request
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -399,6 +423,10 @@ struct vduse_dev_request {
 		 */
 		struct vduse_iova_range_v2 iova_v2;
 		struct vduse_vq_group_asid vq_group_asid;
+
+		/* Only if VDUSE_F_QUEUE_READY is negotiated */
+		struct vduse_vq_ready vq_ready;
+
 		__u32 padding[32];
 	};
 };
-- 
2.55.0

