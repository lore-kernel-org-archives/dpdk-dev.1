Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E741CFD4F16
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 19:17:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2BCF406FF;
	Tue, 10 Mar 2026 20:16:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F1E8740E16
 for <dev@dpdk.org>; Tue, 10 Mar 2026 20:16:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773170216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bf++UyrWQbo10bJFSoDzENRjty/Z3xGxhpMcwSgcsfM=;
 b=JkdFgmfXnJUfxij3VJRJEw+L4KdOdTgE2K9AKrm7lEQMPNqo9Xk+0l/qpLt1VBbG5FDgkY
 bpiW3tLpLqN4iWgv9Gz1wSZ3pADct/5uw9bbgF54wAhsK9c6jRaxKw+XYEFa4WsUDT8D0x
 DRpSX0vWWRtAhoDUHX9EjGUh4jVbY0w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-fv4z8SPLN8Czob99evUTuQ-1; Tue,
 10 Mar 2026 15:16:55 -0400
X-MC-Unique: fv4z8SPLN8Czob99evUTuQ-1
X-Mimecast-MFC-AGG-ID: fv4z8SPLN8Czob99evUTuQ_1773170214
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6B0E19560B7; Tue, 10 Mar 2026 19:16:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.202])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28AA81955D71; Tue, 10 Mar 2026 19:16:50 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: david.marchand@redhat.com, mst@redhat.com, chenbox@nvidia.com,
 Yongji Xie <xieyongji@bytedance.com>, jasowang@redhat.com, dev@dpdk.org
Subject: [RFC v2 01/10] uapi: align VDUSE header for ASID
Date: Tue, 10 Mar 2026 20:16:36 +0100
Message-ID: <20260310191645.1104892-2-eperezma@redhat.com>
In-Reply-To: <20260310191645.1104892-1-eperezma@redhat.com>
References: <20260310191645.1104892-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5mFqa7MmC6gqXpmFufiaWChpIckTNg5a0SOBZQWGdJc_1773170214
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

Add all the ioctls and argument struct definitions so we can call them
in next patches.

These headers are not in Linux master at the moment, but they're planned
for 7.0.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 kernel/linux/uapi/linux/vduse.h | 87 ++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 6 deletions(-)

diff --git a/kernel/linux/uapi/linux/vduse.h b/kernel/linux/uapi/linux/vduse.h
index f46269af349a..e19b3c0f51b5 100644
--- a/kernel/linux/uapi/linux/vduse.h
+++ b/kernel/linux/uapi/linux/vduse.h
@@ -10,6 +10,10 @@
 
 #define VDUSE_API_VERSION	0
 
+/* VQ groups and ASID support */
+
+#define VDUSE_API_VERSION_1	1
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
@@ -27,6 +31,8 @@
  * @features: virtio features
  * @vq_num: the number of virtqueues
  * @vq_align: the allocation alignment of virtqueue's metadata
+ * @ngroups: number of vq groups that VDUSE device declares
+ * @nas: number of address spaces that VDUSE device declares
  * @reserved: for future use, needs to be initialized to zero
  * @config_size: the size of the configuration space
  * @config: the buffer of the configuration space
@@ -41,7 +47,9 @@ struct vduse_dev_config {
 	__u64 features;
 	__u32 vq_num;
 	__u32 vq_align;
-	__u32 reserved[13];
+	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
+	__u32 nas; /* if VDUSE_API_VERSION >= 1 */
+	__u32 reserved[11];
 	__u32 config_size;
 	__u8 config[];
 };
@@ -118,14 +126,18 @@ struct vduse_config_data {
  * struct vduse_vq_config - basic configuration of a virtqueue
  * @index: virtqueue index
  * @max_size: the max size of virtqueue
- * @reserved: for future use, needs to be initialized to zero
+ * @reserved1: for future use, needs to be initialized to zero
+ * @group: virtqueue group
+ * @reserved2: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_VQ_SETUP ioctl to setup a virtqueue.
  */
 struct vduse_vq_config {
 	__u32 index;
 	__u16 max_size;
-	__u16 reserved[13];
+	__u16 reserved1;
+	__u32 group;
+	__u16 reserved2[10];
 };
 
 /*
@@ -156,6 +168,16 @@ struct vduse_vq_state_packed {
 	__u16 last_used_idx;
 };
 
+/**
+ * struct vduse_vq_group_asid - virtqueue group ASID
+ * @group: Index of the virtqueue group
+ * @asid: Address space ID of the group
+ */
+struct vduse_vq_group_asid {
+	__u32 group;
+	__u32 asid;
+};
+
 /**
  * struct vduse_vq_info - information of a virtqueue
  * @index: virtqueue index
@@ -215,6 +237,7 @@ struct vduse_vq_eventfd {
  * @uaddr: start address of userspace memory, it must be aligned to page size
  * @iova: start of the IOVA region
  * @size: size of the IOVA region
+ * @asid: Address space ID of the IOVA region
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
@@ -224,7 +247,8 @@ struct vduse_iova_umem {
 	__u64 uaddr;
 	__u64 iova;
 	__u64 size;
-	__u64 reserved[3];
+	__u32 asid;
+	__u32 reserved[5];
 };
 
 /* Register userspace memory for IOVA regions */
@@ -237,7 +261,8 @@ struct vduse_iova_umem {
  * struct vduse_iova_info - information of one IOVA region
  * @start: start of the IOVA region
  * @last: last of the IOVA region
- * @capability: capability of the IOVA regsion
+ * @capability: capability of the IOVA region
+ * @asid: Address space ID of the IOVA region, only if device API version >= 1
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
@@ -248,7 +273,8 @@ struct vduse_iova_info {
 	__u64 last;
 #define VDUSE_IOVA_CAP_UMEM (1 << 0)
 	__u64 capability;
-	__u64 reserved[3];
+	__u32 asid; /* Only if device API version >= 1 */
+	__u32 reserved[5];
 };
 
 /*
@@ -257,6 +283,32 @@ struct vduse_iova_info {
  */
 #define VDUSE_IOTLB_GET_INFO	_IOWR(VDUSE_BASE, 0x1a, struct vduse_iova_info)
 
+/**
+ * struct vduse_iotlb_entry_v2 - entry of IOTLB to describe one IOVA region
+ *
+ * @v1: the original vduse_iotlb_entry
+ * @asid: address space ID of the IOVA region
+ * @reserved: for future use, needs to be initialized to zero
+ *
+ * Structure used by VDUSE_IOTLB_GET_FD2 ioctl to find an overlapped IOVA region.
+ */
+struct vduse_iotlb_entry_v2 {
+	__u64 offset;
+	__u64 start;
+	__u64 last;
+	__u8 perm;
+	__u8 padding[7];
+	__u32 asid;
+	__u32 reserved[11];
+};
+
+/*
+ * Same as VDUSE_IOTLB_GET_FD but with vduse_iotlb_entry_v2 argument that
+ * support extra fields.
+ */
+#define VDUSE_IOTLB_GET_FD2	_IOWR(VDUSE_BASE, 0x1b, struct vduse_iotlb_entry_v2)
+
+
 /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
 
 /**
@@ -265,11 +317,14 @@ struct vduse_iova_info {
  * @VDUSE_SET_STATUS: set the device status
  * @VDUSE_UPDATE_IOTLB: Notify userspace to update the memory mapping for
  *                      specified IOVA range via VDUSE_IOTLB_GET_FD ioctl
+ * @VDUSE_SET_VQ_GROUP_ASID: Notify userspace to update the address space of a
+ *                           virtqueue group.
  */
 enum vduse_req_type {
 	VDUSE_GET_VQ_STATE,
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
+	VDUSE_SET_VQ_GROUP_ASID,
 };
 
 /**
@@ -304,6 +359,19 @@ struct vduse_iova_range {
 	__u64 last;
 };
 
+/**
+ * struct vduse_iova_range_v2 - IOVA range [start, last] if API_VERSION >= 1
+ * @start: start of the IOVA range
+ * @last: last of the IOVA range
+ * @asid: address space ID of the IOVA range
+ */
+struct vduse_iova_range_v2 {
+	__u64 start;
+	__u64 last;
+	__u32 asid;
+	__u32 padding;
+};
+
 /**
  * struct vduse_dev_request - control request
  * @type: request type
@@ -312,6 +380,8 @@ struct vduse_iova_range {
  * @vq_state: virtqueue state, only index field is available
  * @s: device status
  * @iova: IOVA range for updating
+ * @iova_v2: IOVA range for updating if API_VERSION >= 1
+ * @vq_group_asid: ASID of a virtqueue group
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -324,6 +394,11 @@ struct vduse_dev_request {
 		struct vduse_vq_state vq_state;
 		struct vduse_dev_status s;
 		struct vduse_iova_range iova;
+		/* Following members but padding exist only if vduse api
+		 * version >= 1
+		 */
+		struct vduse_iova_range_v2 iova_v2;
+		struct vduse_vq_group_asid vq_group_asid;
 		__u32 padding[32];
 	};
 };
-- 
2.53.0

