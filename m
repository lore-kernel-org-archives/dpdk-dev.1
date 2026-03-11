Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F2FD063C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 06:56:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80F8940E64;
	Wed, 11 Mar 2026 07:56:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7231640DD1
 for <dev@dpdk.org>; Wed, 11 Mar 2026 07:56:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773212178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DaGeHZYPu+8xydrTa2BmPe/S+SvYtHJ43iLNPQGeJPw=;
 b=Ox7A2DqpEwBxnFp3EvGAY+56JqD+ED7+xauw3TMk+H/yiALXuzll8JZGrn7sVvLwnXw8ZK
 eFB7NyGDIQtB/ZhB/HMIQ76TzaY8c7C5BGVlDYrBzMweH/ueWwCQWkq4u7vKF8Zw8sfw0T
 aqIy0jgM36/M2k4prVP/fW2F2J4LV5U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-3LtZewmoMVWuz61VNuYDUQ-1; Wed,
 11 Mar 2026 02:56:14 -0400
X-MC-Unique: 3LtZewmoMVWuz61VNuYDUQ-1
X-Mimecast-MFC-AGG-ID: 3LtZewmoMVWuz61VNuYDUQ_1773212173
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 965861956056; Wed, 11 Mar 2026 06:56:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.190])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1903E19560A6; Wed, 11 Mar 2026 06:56:10 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: chenbox@nvidia.com, jasowang@redhat.com, david.marchand@redhat.com,
 dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, mst@redhat.com
Subject: [RFC v3 08/10] uapi: Align vduse.h for enable and suspend VDUSE
 messages
Date: Wed, 11 Mar 2026 07:55:41 +0100
Message-ID: <20260311065543.1354037-9-eperezma@redhat.com>
In-Reply-To: <20260311065543.1354037-1-eperezma@redhat.com>
References: <20260311065543.1354037-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9k3PC0Z4RVT_otBVPKoJrplcVheiIeGeN4bRLtwNV2g_1773212173
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

From: Super User <root@wsfd-advnetlab45.anl.eng.rdu2.dc.redhat.com>

This is a prerequisite for next patches to use them.

These features are required to properly support live migration and proper
device initialization ordering.

These are not in maintainer's branch at the moment:
https://lore.kernel.org/lkml/20260310190759.1097506-1-eperezma@redhat.com
https://lore.kernel.org/lkml/20260310191019.1099757-1-eperezma@redhat.com

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v2: Align with latest headers where API_VERSION is not bumped.
---
 kernel/linux/uapi/linux/vduse.h | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/kernel/linux/uapi/linux/vduse.h b/kernel/linux/uapi/linux/vduse.h
index e19b3c0f51b5..2aa35299ba3a 100644
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
@@ -33,6 +39,7 @@
  * @vq_align: the allocation alignment of virtqueue's metadata
  * @ngroups: number of vq groups that VDUSE device declares
  * @nas: number of address spaces that VDUSE device declares
+ * @vduse_features: VDUSE features
  * @reserved: for future use, needs to be initialized to zero
  * @config_size: the size of the configuration space
  * @config: the buffer of the configuration space
@@ -49,7 +56,8 @@ struct vduse_dev_config {
 	__u32 vq_align;
 	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
 	__u32 nas; /* if VDUSE_API_VERSION >= 1 */
-	__u32 reserved[11];
+	__u64 vduse_features; /* if VDUSE_GET_FEATURES is not EINVAL */
+	__u32 reserved[9];
 	__u32 config_size;
 	__u8 config[];
 };
@@ -63,6 +71,9 @@ struct vduse_dev_config {
  */
 #define VDUSE_DESTROY_DEV	_IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_MAX])
 
+/* Get the VDUSE supported features */
+#define VDUSE_GET_FEATURES	_IOR(VDUSE_BASE, 0x04, __u64)
+
 /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
 
 /**
@@ -325,6 +336,8 @@ enum vduse_req_type {
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_SET_VQ_GROUP_ASID,
+	VDUSE_SET_VQ_READY,
+	VDUSE_SUSPEND,
 };
 
 /**
@@ -372,6 +385,15 @@ struct vduse_iova_range_v2 {
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
@@ -382,6 +404,7 @@ struct vduse_iova_range_v2 {
  * @iova: IOVA range for updating
  * @iova_v2: IOVA range for updating if API_VERSION >= 1
  * @vq_group_asid: ASID of a virtqueue group
+ * @vq_ready: Virtqueue ready request
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -399,6 +422,10 @@ struct vduse_dev_request {
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
2.53.0

