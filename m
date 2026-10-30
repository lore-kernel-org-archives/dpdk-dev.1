Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD285606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ericsson.com header.i=@ericsson.com header.a=rsa-sha256 header.s=selector2 header.b=Vr7sebXb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7989F40299;
	Fri, 30 Oct 2026 11:22:29 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011022.outbound.protection.outlook.com
 [40.107.130.22])
 by mails.dpdk.org (Postfix) with ESMTPS id EFB6640285;
 Fri, 30 Oct 2026 11:22:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED9GQfuznIfKhUoxcWQHeildPz9LOymSFATx+vRmpjrjvfPBP4kqyQGRmTFN7PZdbv9kNrm2bHVD+rPJBCQKduyfuHQdQ0M2q/q7xp+LW53pFeYIhdh4dzamtBz2LxxB3X5ysr4lKS912Ez1xfsdaqxcU/HcAnanDCqzVARsQJgEV09oZYNq2SYSNfV4Ts+6bu6576BWMX+WGSIzR3R0pKj2x3RtoU2IzM2wByc/JK0yFaym/78nZbIHXgIDQPeSXlNRzkNvpFnQAxzbuWphgLJ8ZxKt9AYSYqijn6s+7yXF/AfizgI0MW8s2qWTHnzIFvJQdkRm34giEXZ24jcGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCCLgn3k6NJw3ftg0LiTP4mdcB1E4zcsXseZFStaNtU=;
 b=MxC08oiib7E/6c0M+MnXrKdOBk9ErPLZnGkmdl6zej7KI8+rculBaal5d0I/SR3gqZKeWov/ki2OJhFzAMdlafAURXRUQM+Ak4foRmxsDo8wDMHMTRzs1OpsD8RsFBjeKcsUnzmPHGWr8za1m6bvo20JGvhEMMQHdl3SQYIhMJpm8+zlvCkroaMubxCcfU9W2V5gc4bMo0jzOce5VWFe6CRlbtsKIur1as32lbngnkEuEOiIWFs0RdG73G5fkPpBV2II31gqCCkHKHYCe6THLlLfNQH5l4NSSVnk5pMgR8qXmoUPWSLckJJKVw/wO1I60h61wN8L82rl1DkrOAOjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCCLgn3k6NJw3ftg0LiTP4mdcB1E4zcsXseZFStaNtU=;
 b=Vr7sebXbMQ/f6v3CVTLrfCmAPHZlWiMMSlyH0CWc/PjiHCQ/4MSQ+7vEmnrltHTgfmeDMj68gU4o/p/byKJhT7PGucwbOj1e+dsudSvmkH/Dgm14hFDa83VAHgsNBUl390IgXp2od1ANd5SKKDYJZya2Ki1ko83C3D7yFA7wQaIgDYg3ABde6VsciozzUpBoiMbf4QZbY2sOlOdJzLCw4/xvYXXMN0sxewNWlMiFE0+Y2Ps4yfs/zTesVVDD/gsGWoV8ElCBOdQ1oglxcsVtX6FYgPeGGtX+CtOQ91kVVgVijA/2il38qGR8u5z92gZsCfyMDl2ei8h30/FZ/9wOTA==
Received: from PAZP264CA0161.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::20)
 by AS8PR07MB9377.eurprd07.prod.outlook.com (2603:10a6:20b:61b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 10:22:20 +0000
Received: from MAD0EPF000008C4.eurprd05.prod.outlook.com
 (2603:10a6:102:1f9:cafe::85) by PAZP264CA0161.outlook.office365.com
 (2603:10a6:102:1f9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Fri, 30
 Oct 2026 10:22:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008C4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 10:22:20 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 11:22:20 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 2E1AA4020AAE;
 Fri, 30 Oct 2026 11:22:19 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id E77006113F8A; Fri, 30 Oct 2026 11:22:18 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Jakub Grajciar <jgrajcia@cisco.com>, Stephen Hemminger
 <stephen@networkplumber.org>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH] net/memif: fix race between interrupt thread and stop
Date: Fri, 30 Oct 2026 11:22:18 +0100
Message-ID: <20261030102218.3489371-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261029100329.3cb8fa14@phoenix.local>
References: <20261029100329.3cb8fa14@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C4:EE_|AS8PR07MB9377:EE_
X-MS-Office365-Filtering-Correlation-Id: be856492-db13-4c3d-57ff-08df366fae95
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006|5023799004|261022075727099003|261028144727099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|261022105027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: Eg4cC28QfNjxPNXfg9gYFfyvi8cEx44/Md1KkSOodTancgVodqv9VblG1BZrAyW8tuS5kgSdorCY0CIO/OJVvemsujo2kVxhoXe+ytm+iaQ2wkTOuijClX83pmsZKKNZeznCxAnNjelEEWhuxG94KQz4kDuZsxJVEPWQdcdkhO2DCvYjX9b1X3opqzUwjQ5igAfbxgaKzq/E2H7+ii1zFBSFyN5ORxBX5ffnE4py38Xr6ubp38hSvgyXP+TxaVTC3q7n7SxWgCeupHUb4sNF0Seds3Icp2cSbWzNyCdOWJGLzEv2iyO05Kz+ntKAi1nQD6A+0hfOOr3j9vnevpjysQ+mXcgq1o/JT3QVmrsN/N96S8WKcGH80MWJm5R+5/RZpT+5REvxBKB67q3SnKa1Y5xVvCiYWFbVPP1Km6d3GkYCwOxLuO7kQCL1ZQn/Y3hk1LkoC2Vsj5wd5V9Z57huPZQ1tpErKWDbJdlEZoHndZpeS/+g9SKqK0s9WlzxQ8Pj/dYf6M9kblwSgj+gbY4jD88Z3aES9K3VHpyvqeW2Pl32AO8SG9HxqtWqKh/+E/EBV518Z8aQpUPUbvw2vHt9J+n97+lLNleSclfopfe+8Bob9uTS0em6pM7RLTFRBqbV2bLIbX31C9cHVHU2zfowsS+Hxto09ix5fpamw9ajKoHjxmTq1cTU46n66C2dG2Q89Lw/DJfiyuefDss0WE2eAA==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(261022075727099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(261022105027099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k9z9nIYQ2qSkWJD5FoM/u/sPfix+N6EPnUxONOQmTYUV75k4Dzl74fOGoTUSFr3dqHSjxOOvrbyi9koamFrQFQwIC0d1ZMp/brWFt4cMkWLmYe/YRKvlGAY4PJV9IGIcCWqjfQTAzL9tUxDF2sMIkbyErQg5vH7uVQ/qt42zJM9BQgdtXnD6Ysg8H/ft3ya8F2waisniCyG/hdj1hWozSyGz51PSAIgETyeep9qlSVjNJ1N4tNkdM46icl9b3xBHVxTnMafqmhCwMVJtnc6M8QJKs5jyMqiiWO/lDfh/2GLggETVzFE4RYT2eZRZls0nU35A5mDl+HNGc1FNZSCd9ctU3Vh3H9i0bCdrp6Bh3/ht7Grow8ATXYm7ec/wOpfPslkjmv4lZQ4xHhHThPE2HOPxP4DQtj06zcEUnY9HaWyPKJbO6ppGkw9Kh9Zfu8dg
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 10:22:20.7072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be856492-db13-4c3d-57ff-08df366fae95
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9377
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The control-channel callback runs on the interrupt thread and calls
memif_disconnect() when the peer hangs up. Nothing ordered this against
an application thread stopping and closing the same port. When the peer
of a loopback pair is stopped first, the callback can still be running
memif_disconnect() while the port is closed and released, and then
dereferences dev->data which is NULL. Seen as a SIGSEGV on the interrupt
thread during memif_pmd_autotest teardown.

Detach the control channel in memif_cc_detach(), called without cc_lock:

  - take pmd->cc under cc_lock so only one caller owns it;
  - on the interrupt thread (the callback itself) defer the free to the
    pending-unregister callback, as before;
  - on an application thread wait for a running callback with
    rte_intr_callback_unregister_sync() so the device stays valid until
    it returns, then free.

memif_intr_handler() no longer disconnects a device that has already
dropped this channel: it stops polling the fd and returns, letting the
waiting application thread free the channel. Once memif_cc_detach()
returns the handler cannot run for the device, so the queue and region
teardown no longer needs cc_lock.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/memif_socket.c | 141 +++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 45 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 971964133c..56fbbae9fa 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -572,12 +572,10 @@ memif_msg_enq_connected(struct rte_eth_dev *dev)
 }
 
 static void
-memif_intr_unregister_handler(const struct rte_intr_handle *intr_handle, void *arg)
+memif_cc_free(struct memif_control_channel *cc)
 {
 	struct memif_msg_queue_elt *elt;
-	struct memif_control_channel *cc = arg;
 
-	RTE_SET_USED(intr_handle);
 	/* close control channel fd */
 	rte_intr_fd_close(cc->intr_handle);
 	/* clear message queue */
@@ -590,66 +588,98 @@ memif_intr_unregister_handler(const struct rte_intr_handle *intr_handle, void *a
 	rte_free(cc);
 }
 
-void
-memif_disconnect(struct rte_eth_dev *dev)
+/*
+ * Pending-unregister callback, run by the interrupt thread once
+ * memif_intr_handler() has returned.
+ */
+static void
+memif_intr_unregister_handler(const struct rte_intr_handle *intr_handle, void *arg)
 {
-	struct pmd_internals *pmd = dev->data->dev_private;
+	RTE_SET_USED(intr_handle);
+	memif_cc_free(arg);
+}
+
+/*
+ * Detach the control channel from the device and free it, synchronising
+ * with memif_intr_handler() which runs on the interrupt thread. Must be
+ * called WITHOUT pmd->cc_lock held (the handler takes it). On return the
+ * handler can no longer run for this device.
+ */
+static void
+memif_cc_detach(struct pmd_internals *pmd)
+{
+	struct memif_control_channel *cc;
 	struct memif_msg_queue_elt *elt, *next;
-	struct memif_queue *mq;
-	struct rte_intr_handle *ih;
-	int i;
 	int ret;
 
-	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
-	pmd->flags &= ~ETH_MEMIF_FLAG_CONNECTING;
-	pmd->flags &= ~ETH_MEMIF_FLAG_CONNECTED;
-
 	rte_spinlock_lock(&pmd->cc_lock);
-	if (pmd->cc != NULL) {
+	cc = pmd->cc;
+	pmd->cc = NULL;
+	if (cc != NULL) {
 		/* Clear control message queue (except disconnect message if any). */
-		for (elt = TAILQ_FIRST(&pmd->cc->msg_queue); elt != NULL; elt = next) {
+		for (elt = TAILQ_FIRST(&cc->msg_queue); elt != NULL; elt = next) {
 			next = TAILQ_NEXT(elt, next);
 			if (elt->msg.type != MEMIF_MSG_TYPE_DISCONNECT) {
-				TAILQ_REMOVE(&pmd->cc->msg_queue, elt, next);
+				TAILQ_REMOVE(&cc->msg_queue, elt, next);
 				rte_free(elt);
 			}
 		}
 		/* send disconnect message (if there is any in queue) */
-		memif_msg_send_from_queue(pmd->cc);
+		memif_msg_send_from_queue(cc);
+		if (TAILQ_FIRST(&cc->msg_queue) != NULL)
+			MIF_LOG(WARNING, "Unexpected message(s) in message queue.");
+	}
+	rte_spinlock_unlock(&pmd->cc_lock);
 
-		/* at this point, there should be no more messages in queue */
-		if (TAILQ_FIRST(&pmd->cc->msg_queue) != NULL) {
-			MIF_LOG(WARNING,
-				"Unexpected message(s) in message queue.");
-		}
+	if (cc == NULL)
+		return;
 
-		ih = pmd->cc->intr_handle;
-		if (rte_intr_fd_get(ih) >= 0) {
-			ret = rte_intr_callback_unregister(ih,
-							memif_intr_handler,
-							pmd->cc);
-			/*
-			 * If callback is active (disconnecting based on
-			 * received control message).
-			 */
-			if (ret == -EAGAIN) {
-				ret = rte_intr_callback_unregister_pending(ih,
-							memif_intr_handler,
-							pmd->cc,
-							memif_intr_unregister_handler);
-			} else if (ret > 0) {
-				rte_intr_fd_close(ih);
-				rte_intr_instance_free(ih);
-				rte_free(pmd->cc);
-			}
-			pmd->cc = NULL;
-			if (ret <= 0)
-				MIF_LOG(WARNING,
-					"Failed to unregister control channel callback.");
+	if (rte_thread_is_intr()) {
+		/* On the interrupt thread: cannot wait for the handler (it may
+		 * be us); hand the free to the pending-unregister callback.
+		 */
+		ret = rte_intr_callback_unregister(cc->intr_handle,
+					memif_intr_handler, cc);
+		if (ret == -EAGAIN)
+			ret = rte_intr_callback_unregister_pending(cc->intr_handle,
+					memif_intr_handler, cc,
+					memif_intr_unregister_handler);
+		else if (ret > 0)
+			memif_cc_free(cc);
+	} else {
+		/* On an application thread: wait for the handler to finish,
+		 * then free (-ENOENT: it already dropped itself).
+		 */
+		ret = rte_intr_callback_unregister_sync(cc->intr_handle,
+					memif_intr_handler, cc);
+		if (ret > 0 || ret == -ENOENT) {
+			memif_cc_free(cc);
+			ret = 1;
 		}
 	}
+	if (ret <= 0)
+		MIF_LOG(WARNING, "Failed to unregister control channel callback.");
+}
+
+void
+memif_disconnect(struct rte_eth_dev *dev)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+	struct memif_queue *mq;
+	int i;
+
+	rte_spinlock_lock(&pmd->cc_lock);
+	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+	pmd->flags &= ~ETH_MEMIF_FLAG_CONNECTING;
+	pmd->flags &= ~ETH_MEMIF_FLAG_CONNECTED;
 	rte_spinlock_unlock(&pmd->cc_lock);
 
+	/* Tear down the control channel, synchronising with the handler. */
+	memif_cc_detach(pmd);
+
+	/* The handler can no longer run for this device; free queues and
+	 * regions without cc_lock.
+	 */
 	/* unconfig interrupts */
 	for (i = 0; i < pmd->cfg.num_c2s_rings; i++) {
 		if (pmd->role == MEMIF_ROLE_CLIENT) {
@@ -868,6 +898,8 @@ static void
 memif_intr_handler(void *arg)
 {
 	struct memif_control_channel *cc = arg;
+	struct pmd_internals *pmd;
+	bool owned;
 	int ret;
 
 	ret = memif_msg_receive(cc);
@@ -898,6 +930,25 @@ memif_intr_handler(void *arg)
 		MIF_LOG(WARNING, "eth dev not allocated");
 		return;
 	}
+
+	/*
+	 * If an application thread stopped the device it already detached
+	 * this channel and waits in memif_cc_detach() for us to return. Do
+	 * not disconnect a device that no longer owns this channel; stop
+	 * polling the fd (it stays readable on EOF) and let that thread free.
+	 */
+	pmd = cc->dev->data->dev_private;
+	rte_spinlock_lock(&pmd->cc_lock);
+	owned = (pmd->cc == cc);
+	rte_spinlock_unlock(&pmd->cc_lock);
+	if (!owned) {
+		/* The waiting application thread frees the channel; just stop
+		 * polling the fd here (no free callback).
+		 */
+		rte_intr_callback_unregister_pending(cc->intr_handle,
+					memif_intr_handler, cc, NULL);
+		return;
+	}
 	memif_disconnect(cc->dev);
 }
 
-- 
2.43.7

