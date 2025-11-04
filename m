Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E2CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 05:22:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43341402DD;
	Tue,  4 Nov 2025 06:22:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3E415402B6
 for <dev@dpdk.org>; Tue,  4 Nov 2025 06:21:58 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A3H28Et205264; Mon, 3 Nov 2025 21:21:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
 pAxaUJXj0bldLbS6wqdgTGDIeobqbPG0oZgwOVyZd8=; b=Qc+GO7gAhNY5kQcUQ
 BT0eeGSg6/ApqKutj6fafnosXYIAudRqa5psEwZcYRng3GP0PDKXNtBuK5h4Wsqb
 1QxeES3FBOCrEPeJbi8YtXObKwS0uxxl7NicxxN32iHc7NdjQRaC1OMDoHk/hQfo
 rYheaKVPP85zJh9qDYJUtEBFOhfvZnE+uVOlnMKWC5K5PEf5TUlBEijzEA/NhfOi
 /FChvZtnU2468q6UUqa6xxMgad7OEbo5DIrI2hr9jCuibLwGlw16jcJxOStkiGUU
 So3Mw7xZmG7y9jALltvYSqwi9bfwqQT+AvJVlBGjudV+rCiu7KalSWSyE9ATd12s
 E7sjQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a70ek24x3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 21:21:57 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 3 Nov 2025 21:22:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 3 Nov 2025 21:22:06 -0800
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 85F033F705A;
 Mon,  3 Nov 2025 21:21:54 -0800 (PST)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>
CC: <thomas@monjalon.net>, <vattunuru@marvell.com>
Subject: [PATCH v2 1/1] dmadev: add domain_id field to access group join API
Date: Tue, 4 Nov 2025 10:51:46 +0530
Message-ID: <20251104052146.2308361-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103102946.2204883-1-vattunuru@marvell.com>
References: <20251103102946.2204883-1-vattunuru@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LkLaCcgOj190n64Ehh_5lAKJ8eESlBcP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA0MSBTYWx0ZWRfX2wbVnJwAToXd
 TchkL2gl4GTLEjZiWAUNHfNSf77MW4ifBjBTBMOZlGBRWica8sCBujO7GWr+FBoLWv3X+TDEjIF
 XiPGSvdGWVjKSH6A+x7XNy52IOqqK0o248K1XlpyHX9xUNUmDkSdUEIelupyVDGrEZasEPYs9oz
 M3oRoGTHu0rJK9e5HhoXSDiFWVMU9+0TYx+d+BjLkmpCZUOxK5f7Sme7f+D8gVm6BC/PuTMICS1
 0ue+/RTnmtqW4JLJORIo5iCWJ00X3eMg0NR3MxjLxXxS2SOxusr5jjlj4+FU9w/apNzzN4vfQVW
 CwhD3wKWG2I6vOLvuqyb5/j1ctXRBye9eJyhWbwjCJlvhHZ0uRcSogWCLjclZR4ei3ZsTGDAHZq
 bzAIuyEIZ7utYjuGGj5vBaLPMakHzA==
X-Proofpoint-GUID: LkLaCcgOj190n64Ehh_5lAKJ8eESlBcP
X-Authority-Analysis: v=2.4 cv=N8Yk1m9B c=1 sm=1 tr=0 ts=69098d75 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=qO1uN0poEDOUG-M6EH4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
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

Add domain_id field to access group join API, which is required
to retrieve handler information associated with the specified domain.
This enhancement ensures that domain-specific context is available
during group join operations, improving flexibility and traceability
in multi-domain environments.

Patch aligns the parameters of access group create and join APIs
for consistency and clarity, also updates the dmadev.rst file with
detailed steps.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
V2 changes:
* Updated domain_id field description.
* Added more detailed steps in dmadev.rst file.

 doc/guides/prog_guide/dmadev.rst | 43 +++++++++++++++++++++-----------
 lib/dmadev/rte_dmadev.c          |  6 ++---
 lib/dmadev/rte_dmadev.h          | 12 +++++----
 lib/dmadev/rte_dmadev_pmd.h      |  4 +--
 lib/dmadev/rte_dmadev_trace.h    |  6 +++--
 5 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/doc/guides/prog_guide/dmadev.rst b/doc/guides/prog_guide/dmadev.rst
index 776a860070..1a2384eea1 100644
--- a/doc/guides/prog_guide/dmadev.rst
+++ b/doc/guides/prog_guide/dmadev.rst
@@ -177,7 +177,7 @@ the :doc:`../howto/telemetry`.
 
 
 Inter-domain DMA Transfers
-~~~~~~~~~~~~~~~~~~~~~~~~~~
+--------------------------
 
 The inter-domain DMA feature enables DMA devices to perform data transfers
 across different processes and OS domains.
@@ -201,32 +201,45 @@ can perform DMA transfers across processes or OS domains.
 Below is the API usage flow
 for setting up the access pair group for DMA between process#1 and process#2.
 
+Each process must generate a unique ``domain_id`` to represent its identity
+(e.g., a process-specific or OS-specific domain identifier).
+
 Process#1 (Group Creator)
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+* Generates a unique ``token`` that will be used to secure the access pair group.
+
+* Calls ``rte_dma_access_pair_group_create`` to establish a new access pair group.
 
-Calls ``rte_dma_access_pair_group_create`` to establish a new access pair group,
-then shares the ``group_id``, ``token`` and ``domain_id`` with Process#2 via IPC.
+* Shares the ``group_id``, ``token`` and its ``domain_id`` details with Process#2
+  via IPC or sideband communication channel.
 
 Process#2 (Group Joiner)
-^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~
 
-Receives the ``group_id`` and ``token`` from Process#1
-and calls ``rte_dma_access_pair_group_join`` to join the group.
+* Receives the ``group_id``, ``token`` and Process#1's ``domain_id``.
+
+* Passes ``group_id``, ``token`` and its own ``domain_id`` to ``rte_dma_access_pair_group_join``
+  to join the access group.
+
+* Shares its ``domain_id`` details with Process#1 via IPC or sideband communication channel.
 
 Both Processes
-^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~
+
+* Each process retrieves the ``handler`` information associated with its own or the peer's
+  ``domain_id`` using ``rte_dma_access_pair_group_handler_get``.
 
-Use ``rte_dma_access_pair_group_handler_get`` to obtain ``handler`` information
-for domains in the group.
+* Use these ``handler`` details to setup the virtual channel configuration.
 
-Perform inter-domain DMA transfers as required.
+* Perform the inter-domain DMA transfers as required.
 
 Process#2 (when finished)
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Calls ``rte_dma_access_pair_group_leave`` to exit the group.
+* Calls ``rte_dma_access_pair_group_leave`` to exit the group.
 
 Process#1 (final cleanup)
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Calls ``rte_dma_access_pair_group_destroy`` to destroy the group.
+* Calls ``rte_dma_access_pair_group_destroy`` to destroy the group.
diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index c008e829db..b75b4f9bd1 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -875,8 +875,8 @@ rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id)
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dma_access_pair_group_join, 25.11)
 int
-rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
-			       rte_dma_access_pair_group_event_cb_t cb)
+rte_dma_access_pair_group_join(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+			       int16_t group_id, rte_dma_access_pair_group_event_cb_t cb)
 {
 	struct rte_dma_info dev_info;
 	struct rte_dma_dev *dev;
@@ -899,7 +899,7 @@ rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t toke
 
 	if (*dev->dev_ops->access_pair_group_join == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->access_pair_group_join)(dev, group_id, token, cb);
+	return (*dev->dev_ops->access_pair_group_join)(dev, domain_id, token, group_id, cb);
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dma_access_pair_group_leave, 25.11)
diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 0f4f10ec12..c554c4289c 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -867,7 +867,7 @@ typedef void (*rte_dma_access_pair_group_event_cb_t)(int16_t dev_id,
  * @param dev_id
  *   Identifier of the DMA device initiating the group.
  * @param domain_id
- *   Unique identifier representing the process or OS domain.
+ *   Unique identifier representing the current process or OS domain.
  * @param token
  *   Authentication token used to establish the access group.
  * @param[out] group_id
@@ -912,10 +912,12 @@ int rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id);
  *
  * @param dev_id
  *   Identifier of the DMA device attempting to join the group.
- * @param group_id
- *   ID of the access group to join.
+ * @param domain_id
+ *   Unique identifier representing the current process or OS domain.
  * @param token
  *   Authentication token used to validate group membership.
+ * @param group_id
+ *   ID of the access group to join.
  * @param cb
  *   Callback function to be invoked when the device leaves the group
  *   or when the group is destroyed due to some exception or failure.
@@ -925,8 +927,8 @@ int rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id);
  *   negative value on failure indicating the error code.
  */
 __rte_experimental
-int rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
-				   rte_dma_access_pair_group_event_cb_t cb);
+int rte_dma_access_pair_group_join(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+				   int16_t group_id, rte_dma_access_pair_group_event_cb_t cb);
 
 /**
  * Leave an access group, removing the device's entry from the group table
diff --git a/lib/dmadev/rte_dmadev_pmd.h b/lib/dmadev/rte_dmadev_pmd.h
index 16fd625c2d..8a6b0a9c98 100644
--- a/lib/dmadev/rte_dmadev_pmd.h
+++ b/lib/dmadev/rte_dmadev_pmd.h
@@ -75,8 +75,8 @@ typedef int (*rte_dma_access_pair_group_destroy_t)(const struct rte_dma_dev *dev
 						   int16_t group_id);
 
 /** @internal Used to join an access pair group for inter-process or inter-OS DMA transfers. */
-typedef int (*rte_dma_access_pair_group_join_t)(const struct rte_dma_dev *dev, int16_t group_id,
-						rte_uuid_t token,
+typedef int (*rte_dma_access_pair_group_join_t)(const struct rte_dma_dev *dev, rte_uuid_t domain_id,
+						rte_uuid_t token, int16_t group_id,
 						rte_dma_access_pair_group_event_cb_t cb);
 
 /** @internal Used to leave an access pair group, removing the device from the group. */
diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index da80a8cb50..7ad00b5bfa 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -120,10 +120,12 @@ RTE_TRACE_POINT(
 
 RTE_TRACE_POINT(
 	rte_dma_trace_access_pair_group_join,
-	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id, rte_uuid_t token),
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+			     int16_t group_id),
 	rte_trace_point_emit_i16(dev_id);
-	rte_trace_point_emit_i16(group_id);
+	rte_trace_point_emit_u8_ptr(&domain_id[0]);
 	rte_trace_point_emit_u8_ptr(&token[0]);
+	rte_trace_point_emit_i16(group_id);
 )
 
 RTE_TRACE_POINT(
-- 
2.34.1

