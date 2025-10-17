Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28EDCCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 14:07:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DC6D427D8;
	Fri, 17 Oct 2025 16:07:06 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CE02040269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 16:07:04 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GNST7w032751;
 Fri, 17 Oct 2025 07:07:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 JolAeF9H70nt9zl9b49EapGyXMBThOMNpLc5SDAERk=; b=dAJsqmIU2Almkzvsb
 Cl0N42tMiCj/K6Iyy5UEFKGuYbXYbdkEgYpcyYOcHPtyKUtSEEFv4Ej0DFE2iaMc
 HkhlAWpoehGSaEDCp/neNoRCEPwpraJQAgqZ2hxPmVA8X8VGUKOKPC9rpkusUOjg
 /+djOsWsa4lZ0U/bIvo2m1iFd9Q4SIFziNLx5qdX3/EX1ONDV97uDX3tDeRcuYcg
 AuNq7+9rA4ijLolOfclIds8l80bbcUejW+kmf20B5vbKaQzgXE8b1ZbSTcUi0wdG
 rKk73PW8HZZ5Z9wHXtidQbOgYo/CyGic8YZeYEuXONK2ZL/vc/TZVkDvSRiJm/wh
 1WkLw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49uadkhscj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 07:07:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 17 Oct 2025 07:07:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 17 Oct 2025 07:07:13 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 7FD223F70AA;
 Fri, 17 Oct 2025 07:07:00 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <anatoly.burakov@intel.com>, <kevin.laatz@intel.com>,
 <jerinj@marvell.com>, <vattunuru@marvell.com>
Subject: [PATCH v4 1/1] lib/dma: add control-plane APIs for inter-domain DMA
 transfers
Date: Fri, 17 Oct 2025 19:36:52 +0530
Message-ID: <20251017140652.3186205-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017122610.3126992-1-vattunuru@marvell.com>
References: <20251017122610.3126992-1-vattunuru@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE3NyBTYWx0ZWRfX3cVqv7GGFfh3
 VBlQksVNi+bnV4GShvNTfVlgspgwYWh9RflSeTwCXZddqLnnuptlAcAmQu2Ebj7PFud/ALU7dPw
 TpbCgHKeJjZp2kzfDQqirjE15YTNoxb4NPbmBL8UssIJM7mgWqDHbXuQRiLLermZ9Pbi3B8SbK0
 AeMLATpVQ38KGIOo2PD0SXWAQb49cYQCXf6fuu17W76843zj+Bhxj42o0zwHelCVwoXhiDMmuWI
 FXtFojE5lTpi674F1OgwOnV/Bim+6JfskfL1ItVEQCMSQOyTatcIM19fJdThim0ZJTSuETD5cPs
 xfWCi+BFz/aqm8w2wAfsA5ekMIWU++v/hlGmBEVIFrAosLz/zpYyzEeBxGpF0Lo1Xvw8m69qf/1
 lkQjqeN30d0mZiY0LObfEptvkgkx7Q==
X-Proofpoint-ORIG-GUID: qIMIzRxkFX0M0jyIRzIAlf2I8ZcThRji
X-Proofpoint-GUID: qIMIzRxkFX0M0jyIRzIAlf2I8ZcThRji
X-Authority-Analysis: v=2.4 cv=YOKSCBGx c=1 sm=1 tr=0 ts=68f24d87 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=i0EeH86SAAAA:8
 a=9CQahlRCAmgxc8T7JkEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
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

From: Vamsi Attunuru <vattunuru@marvell.com>

Secure and controlled inter-domain DMA transfers require dedicated
control-plane APIs to create and manage access groups.

DMA devices used for inter-process data transfer can be categorized as
follows:

Class A: Both endpoints require a DMA device for data transfer (e.g.,
Marvell DMA devices).
Class B: Only one endpoint requires a DMA device; the other does not.
Class C: Other device types not currently classified.

Providing a unified API for all these categories is complex, as Linux
and other operating systems do not offer native control-plane APIs for
this purpose. Therefore, DPDK can implement its own control-plane
mechanisms to support Class A, B, and C devices.

This commit introduces the necessary APIs for Class A DMA devices.
Devices can create or join access groups using token-based
authentication, ensuring that only authorized devices within the same
group can perform DMA transfers across processes or OS domains.

API Usage Flow:

Process 1 (Group Creator):
Invokes rte_dma_access_pair_group_create() to establish a new access
pair group, then shares the group_id and token with Process 2 via IPC.

Process 2 (Group Joiner):
Receives the group_id and token from Process 1 and calls
rte_dma_access_pair_group_join() to join the group.

Both Processes:
Use rte_dma_access_pair_group_handler_get() to obtain handler information
for domains in the group.
Perform DMA transfers as required.

Process 2 (when finished):
Calls rte_dma_access_pair_group_leave() to exit the group.

Process 1:
Monitors for group updates and confirms group membership as needed.

Depends-on: patch-36386 (lib/dma: introduce inter-process and inter-OS DMA)

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
V4 Changes:
* Fix minor comments in documentation.
V3 Changes:
* Add documentation to dmadev doc.
* Add common callback for group creator and joiner.
* Fix V2 review comments

 doc/guides/prog_guide/dmadev.rst |  49 +++++++++++
 lib/dmadev/rte_dmadev.c          | 138 +++++++++++++++++++++++++++++++
 lib/dmadev/rte_dmadev.h          | 137 ++++++++++++++++++++++++++++++
 lib/dmadev/rte_dmadev_pmd.h      |  29 +++++++
 lib/dmadev/rte_dmadev_trace.h    |  42 ++++++++++
 5 files changed, 395 insertions(+)

diff --git a/doc/guides/prog_guide/dmadev.rst b/doc/guides/prog_guide/dmadev.rst
index 9b497ce7bd..349ddf6d06 100644
--- a/doc/guides/prog_guide/dmadev.rst
+++ b/doc/guides/prog_guide/dmadev.rst
@@ -174,3 +174,52 @@ are shown below.
 
 For more information on how to use the Telemetry interface, see
 the :doc:`../howto/telemetry`.
+
+Inter-domain DMA Capabilities
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The inter-domain DMA feature enables DMA devices to perform data transfers
+across different processes and OS domains. This is achieved by configuring
+virtual channels (vchans) using `src_handler` and `dst_handler` fields, which
+represent the source and destination endpoints for inter-domain DMA operations.
+Handler information is exchanged between devices based on their DMA class type.
+These handler details will be exchanged based on the type of DMA devices.
+
+DMA devices used for inter-domain data transfer can be categorized as follows:
+
+Class A: Both endpoints require a DMA device for data transfer (e.g., Marvell DMA devices).
+Class B: Only one endpoint requires a DMA device; the other does not.
+Class C: Other device types not currently classified.
+
+Currently the necessary APIs for Class A DMA devices are avilable for exchanging the handler
+details. Devices can create or join access groups using token-based authentication, ensuring
+that only authorized devices within the same group can perform DMA transfers across processes
+or OS domains.
+
+API usage flow for setting up the access pair group for DMA between process#1 & process#2.
+
+Process#1 (Group Creator):
+--------------------------
+Calls ``rte_dma_access_pair_group_create`` to establish a new access pair group,
+then shares the ``group_id``, ``token`` and ``domain_id`` with Process#2 via IPC.
+
+Process#2 (Group Joiner):
+-------------------------
+Receives the ``group_id`` and ``token`` from Process#1 and calls ``rte_dma_access_pair_group_join``
+to join the group.
+
+Both Processes:
+---------------
+Use ``rte_dma_access_pair_group_handler_get`` to obtain ``handler`` information for domains
+in the group.
+
+--Perform inter-domain DMA transfers as required.
+
+Process#2 (when finished):
+--------------------------
+Calls ``rte_dma_access_pair_group_leave`` to exit the group.
+
+Process#1 (final cleanup):
+--------------------------
+Calls ``rte_dma_access_pair_group_destroy`` to destroy the group.
+
diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 30c3db3a98..cf50d7433c 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -816,6 +816,144 @@ rte_dma_vchan_status(int16_t dev_id, uint16_t vchan, enum rte_dma_vchan_status *
 	return dev->dev_ops->vchan_status(dev, vchan, status);
 }
 
+int
+rte_dma_access_pair_group_create(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+				 int16_t *group_id, rte_dma_access_pair_group_event_cb_t cb)
+{
+	struct rte_dma_info dev_info;
+	struct rte_dma_dev *dev;
+
+	if (!rte_dma_is_valid(dev_id) || group_id == NULL)
+		return -EINVAL;
+	dev = &rte_dma_devices[dev_id];
+
+	if (rte_dma_info_get(dev_id, &dev_info)) {
+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
+		return -EINVAL;
+	}
+
+	if (!((dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
+	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
+			    dev_id);
+		return -EINVAL;
+	}
+
+	if (*dev->dev_ops->access_pair_group_create == NULL)
+		return -ENOTSUP;
+	return (*dev->dev_ops->access_pair_group_create)(dev, domain_id, token, group_id, cb);
+}
+
+int
+rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id)
+{
+	struct rte_dma_info dev_info;
+	struct rte_dma_dev *dev;
+
+	if (!rte_dma_is_valid(dev_id))
+		return -EINVAL;
+	dev = &rte_dma_devices[dev_id];
+
+	if (rte_dma_info_get(dev_id, &dev_info)) {
+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
+		return -EINVAL;
+	}
+
+	if (!((dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
+	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
+			    dev_id);
+		return -EINVAL;
+	}
+
+	if (*dev->dev_ops->access_pair_group_destroy == NULL)
+		return -ENOTSUP;
+	return (*dev->dev_ops->access_pair_group_destroy)(dev, group_id);
+}
+
+int
+rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
+			       rte_dma_access_pair_group_event_cb_t cb)
+{
+	struct rte_dma_info dev_info;
+	struct rte_dma_dev *dev;
+
+	if (!rte_dma_is_valid(dev_id))
+		return -EINVAL;
+	dev = &rte_dma_devices[dev_id];
+
+	if (rte_dma_info_get(dev_id, &dev_info)) {
+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
+		return -EINVAL;
+	}
+
+	if (!((dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
+	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
+			    dev_id);
+		return -EINVAL;
+	}
+
+	if (*dev->dev_ops->access_pair_group_join == NULL)
+		return -ENOTSUP;
+	return (*dev->dev_ops->access_pair_group_join)(dev, group_id, token, cb);
+}
+
+int
+rte_dma_access_pair_group_leave(int16_t dev_id, int16_t group_id)
+{
+	struct rte_dma_info dev_info;
+	struct rte_dma_dev *dev;
+
+	if (!rte_dma_is_valid(dev_id))
+		return -EINVAL;
+	dev = &rte_dma_devices[dev_id];
+
+	if (rte_dma_info_get(dev_id, &dev_info)) {
+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
+		return -EINVAL;
+	}
+
+	if (!((dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
+	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
+			    dev_id);
+		return -EINVAL;
+	}
+
+	if (*dev->dev_ops->access_pair_group_leave == NULL)
+		return -ENOTSUP;
+	return (*dev->dev_ops->access_pair_group_leave)(dev, group_id);
+}
+
+int
+rte_dma_access_pair_group_handler_get(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
+				      uint16_t *handler)
+{
+	struct rte_dma_info dev_info;
+	struct rte_dma_dev *dev;
+
+	if (!rte_dma_is_valid(dev_id) || handler == NULL)
+		return -EINVAL;
+	dev = &rte_dma_devices[dev_id];
+
+	if (rte_dma_info_get(dev_id, &dev_info)) {
+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
+		return -EINVAL;
+	}
+
+	if (!((dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
+	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
+			    dev_id);
+		return -EINVAL;
+	}
+
+	if (*dev->dev_ops->access_pair_group_handler_get == NULL)
+		return -ENOTSUP;
+	return (*dev->dev_ops->access_pair_group_handler_get)(dev, group_id, domain_id, handler);
+}
+
 static const char *
 dma_capability_name(uint64_t capability)
 {
diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 1708311c5b..8a5d6cc4df 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -148,6 +148,7 @@
 
 #include <rte_bitops.h>
 #include <rte_common.h>
+#include <rte_uuid.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -797,6 +798,142 @@ rte_dma_vchan_status(int16_t dev_id, uint16_t vchan, enum rte_dma_vchan_status *
  */
 int rte_dma_dump(int16_t dev_id, FILE *f);
 
+/**
+ * Event types for DMA access pair group notifications.
+ *
+ * When the event type is RTE_DMA_GROUP_EVENT_MEMBER_LEFT, the handler associated
+ * with the departing member's domain is no longer valid. Inter-domain DMA operations
+ * targeting that domain should be avoided.
+ *
+ * When the event type is RTE_DMA_GROUP_EVENT_GROUP_DESTROYED, all handlers associated
+ * with the group become invalid. No further inter-domain DMA operations should be
+ * initiated using those handlers.
+ */
+enum rte_dma_access_pair_group_event_type {
+	/** A member left the group (notifies creator and joiners) */
+	RTE_DMA_GROUP_EVENT_MEMBER_LEFT,
+	/** Group was destroyed (notifies joiners) */
+	RTE_DMA_GROUP_EVENT_GROUP_DESTROYED
+};
+
+/**
+ * This callback is used to notify interested parties (either the group creator
+ * or group joiners) about significant events related to the lifecycle of a DMA
+ * access pair group.
+ *
+ * It can be registered by:
+ * - **Group creators or Group joiners** to be notified when a member leaves the group.
+ * - **Group joiners** to be notified when the group is destroyed.
+ *
+ * @param dev_id
+ *   Identifier of the DMA device.
+ * @param group_id
+ *   Identifier of the access pair group where the event occurred.
+ * @param domain_id
+ *   UUID of the domain_id associated with the event. For member leave events,
+ *   this is the domain_id of the member that left. For group destruction events,
+ *   this may refer to the domain_id of the respective member.
+ * @param event
+ *   Type of event that occurred.
+ *   @see rte_dma_access_pair_group_event_type
+ */
+typedef void (*rte_dma_access_pair_group_event_cb_t)(int16_t dev_id, int16_t group_id,
+						     rte_uuid_t domain_id,
+						     enum
+						     rte_dma_access_pair_group_event_type event);
+
+/**
+ * Create an access pair group to enable secure DMA transfers between devices across different
+ * processes or operating system domains.
+ *
+ * @param dev_id
+ *   Identifier of the DMA device initiating the group.
+ * @param domain_id
+ *   Unique identifier representing the process or OS domain.
+ * @param token
+ *   Authentication token used to establish the access group.
+ * @param[out] group_id
+ *   Pointer to store the ID of the newly created access group.
+ * @param cb
+ *   Callback function to be invoked when a member leaves the group.
+ *
+ * @return
+ *   0 on success,
+ *   negative error code on failure.
+ */
+int rte_dma_access_pair_group_create(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+				     int16_t *group_id, rte_dma_access_pair_group_event_cb_t cb);
+
+/**
+ * Destroy an access pair group if all participating devices have exited. This operation is only
+ * permitted by the device that originally created the group; attempts by other devices will result
+ * in failure.
+ *
+ * @param dev_id
+ *   Identifier of the device requesting group destruction.
+ * @param group_id
+ *   ID of the access group to be destroyed.
+ * @return
+ *   0 on success,
+ *   negative value on failure indicating the error code.
+ */
+int rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id);
+
+/**
+ * Join an existing access group to enable secure DMA transfers between devices across different
+ * processes or OS domains.
+ *
+ * @param dev_id
+ *   Identifier of the DMA device attempting to join the group.
+ * @param group_id
+ *   ID of the access group to join.
+ * @param token
+ *   Authentication token used to validate group membership.
+ * @param cb
+ *   Callback function to be invoked when the device leaves the group or when the group
+ *   is destroyed due to some exception or failure.
+ *
+ * @return
+ *   0 on success,
+ *   negative value on failure indicating the error code.
+ */
+int rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
+				   rte_dma_access_pair_group_event_cb_t cb);
+
+/**
+ * Leave an access group, removing the device's entry from the group table and disabling
+ * inter-domain DMA transfers to and from this device. This operation is not permitted for the
+ * device that originally created the group.
+ *
+ * @param dev_id
+ *   Identifier of the device requesting to leave the group.
+ * @param group_id
+ *   ID of the access group to leave.
+ * @return
+ *   0 on success,
+ *   negative value on failure indicating the error code.
+ */
+int rte_dma_access_pair_group_leave(int16_t dev_id, int16_t group_id);
+
+/**
+ * Retrieve the handler associated with a specific domain ID, which is used by the application to
+ * query source or destinationin handler to initiate inter-process or inter-OS DMA transfers.
+ *
+ * @param dev_id
+ *   Identifier of the DMA device requesting the handler.
+ * @param group_id
+ *   ID of the access group to query.
+ * @param domain_id
+ *   Unique identifier of the target process or OS domain.
+ * @param[out] handler
+ *   Pointer to store the retrieved handler value.
+ * @return
+ *   0 on success,
+ *   negative value on failure indicating the error code.
+ */
+int rte_dma_access_pair_group_handler_get(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
+					  uint16_t *handler);
+
 /**
  * DMA transfer result status code defines.
  *
diff --git a/lib/dmadev/rte_dmadev_pmd.h b/lib/dmadev/rte_dmadev_pmd.h
index 58729088ff..16fd625c2d 100644
--- a/lib/dmadev/rte_dmadev_pmd.h
+++ b/lib/dmadev/rte_dmadev_pmd.h
@@ -64,6 +64,29 @@ typedef int (*rte_dma_vchan_status_t)(const struct rte_dma_dev *dev, uint16_t vc
 /** @internal Used to dump internal information. */
 typedef int (*rte_dma_dump_t)(const struct rte_dma_dev *dev, FILE *f);
 
+/** @internal Used to create an access pair group for inter-process or inter-OS DMA transfers. */
+typedef int (*rte_dma_access_pair_group_create_t)(const struct rte_dma_dev *dev,
+						  rte_uuid_t domain_id, rte_uuid_t token,
+						  int16_t *group_id,
+						  rte_dma_access_pair_group_event_cb_t cb);
+
+/** @internal Used to destroy an access pair group when all other devices have exited. */
+typedef int (*rte_dma_access_pair_group_destroy_t)(const struct rte_dma_dev *dev,
+						   int16_t group_id);
+
+/** @internal Used to join an access pair group for inter-process or inter-OS DMA transfers. */
+typedef int (*rte_dma_access_pair_group_join_t)(const struct rte_dma_dev *dev, int16_t group_id,
+						rte_uuid_t token,
+						rte_dma_access_pair_group_event_cb_t cb);
+
+/** @internal Used to leave an access pair group, removing the device from the group. */
+typedef int (*rte_dma_access_pair_group_leave_t)(const struct rte_dma_dev *dev, int16_t group_id);
+
+/** @internal Used to retrieve handler information of the domain_id present in the group. */
+typedef int (*rte_dma_access_pair_group_handler_get_t)(const struct rte_dma_dev *dev,
+						       int16_t group_id, rte_uuid_t domain_id,
+						       uint16_t *handler);
+
 /**
  * DMA device operations function pointer table.
  *
@@ -83,6 +106,12 @@ struct rte_dma_dev_ops {
 
 	rte_dma_vchan_status_t     vchan_status;
 	rte_dma_dump_t             dev_dump;
+
+	rte_dma_access_pair_group_create_t	access_pair_group_create;
+	rte_dma_access_pair_group_destroy_t	access_pair_group_destroy;
+	rte_dma_access_pair_group_join_t	access_pair_group_join;
+	rte_dma_access_pair_group_leave_t	access_pair_group_leave;
+	rte_dma_access_pair_group_handler_get_t	access_pair_group_handler_get;
 };
 
 /**
diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index f1a178eeb5..da80a8cb50 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -101,6 +101,48 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(ret);
 )
 
+RTE_TRACE_POINT(
+	rte_dma_trace_access_pair_group_create,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+			     int16_t *group_id),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_u8_ptr(&domain_id[0]);
+	rte_trace_point_emit_u8_ptr(&token[0]);
+	rte_trace_point_emit_ptr(group_id);
+)
+
+RTE_TRACE_POINT(
+	rte_dma_trace_access_pair_group_destroy,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_i16(group_id);
+)
+
+RTE_TRACE_POINT(
+	rte_dma_trace_access_pair_group_join,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id, rte_uuid_t token),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_i16(group_id);
+	rte_trace_point_emit_u8_ptr(&token[0]);
+)
+
+RTE_TRACE_POINT(
+	rte_dma_trace_access_pair_group_leave,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_i16(group_id);
+)
+
+RTE_TRACE_POINT(
+	rte_dma_trace_access_pair_group_handler_get,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
+			     uint16_t *handler),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_i16(group_id);
+	rte_trace_point_emit_u8_ptr(&domain_id[0]);
+	rte_trace_point_emit_ptr(handler);
+)
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.34.1

