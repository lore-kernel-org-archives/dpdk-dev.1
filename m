Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D297606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ericsson.com header.i=@ericsson.com header.a=rsa-sha256 header.s=selector2 header.b=iV/LjOsK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E9364060F;
	Thu,  5 Nov 2026 12:21:04 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
 by mails.dpdk.org (Postfix) with ESMTPS id 41A6840296;
 Thu,  5 Nov 2026 12:21:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBiMrLryG02sguNrewyZ62da6l0ChDb0tGCOAt+rNb+2eUGsgjcbAIDTaSusExePC/KvhsHW21Qfmod6xjx+gxwBpCmPlXfKU8hdxyZRGwy4uyOQDJGNReC9ZfpgFRISyircJscDsEP+zI2huRH+B6LRrsr5Ov88zbds5K1LkQm4JIh5r5tmetFYu6UAaeOvz6GsrJCKMXm7oOqD6K8sB3vq+wuFRjNHIgZdY8+1Xjk4H5KmW9N9gvGwQImgvqEqx0tZVJ0H3pVR/K3CJ7HsW7gOoilpZlW5OKRjZWrkO5QzJbGDD4/jEqlI0lyexr/ucasm/ocgIJPAvhydjYz3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF2/RHKfszTiqWdoX0snut5q0JyJr79RoXp6cut8ox4=;
 b=dDJcG/ehRtVp+VCLrunHTYf9eSjQvwBfTJMD1eifVt6yv6kGIZnGRsEnWAPwQycfzp9nEOhJjJT9CVE9x+rg+KKPJ4m30l0x5wNl2voFVC6f8hT24gws2+F2b8Y3EZmhRBBSsDwjYLfEk66QseeE6Azf5HeZQqXd8IuaEx6CYNiORzVplO9CRXKOXl3FAgV2DgpmOvqEISUlkJ46UXO/hBrNzTtXpNpIf6YzdCo/c9iH3xoIqJrLVr2Sjju3QmZTOJ5xSjZuiqtguPgdzc09cXZ9nwI2KqrNn113+O2m9ioVrh6VejXYnUMkvRcPx5alYIiiI+1K1uUBTZsY0TU/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF2/RHKfszTiqWdoX0snut5q0JyJr79RoXp6cut8ox4=;
 b=iV/LjOsKSuUpb/tGYO4fygnlWtobTcgmKX42HhpUEhoiBj42+ZbqxdmNcINwLkvQz5QpjKFB+9ps6IbRX5SwKQelS1AaBR72DY5kPYCD2sGEjGpbQWyC2gp09L8C3BAXdVLEhzaZQr2FA0HKgGYa3VJl3IEMZ8T6et8VoQo9uPOobQ2LNcoit6dZSTXJLXlgANUl/K737bQybaFzHDj0Cg8LzXHV2CaVId6eqZqRIdi8bIyL4lyTiG6w9XjhfoebwFGCzRYmEewqIjAG1eoc4GzPg52TSSQF9ktHT8D/Mi3hfPw2Bb5M80vNb22RCHhiich2MfvHCslq1rqa+xIXyw==
Received: from DU7PR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::27) by BESPR07MB10713.eurprd07.prod.outlook.com
 (2603:10a6:b10:e8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 11:20:59 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::6) by DU7PR01CA0009.outlook.office365.com
 (2603:10a6:10:50f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:20:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 11:20:58 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 12:20:28 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 3EE184020B41;
 Thu,  5 Nov 2026 12:20:27 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 066EC609B43A; Thu,  5 Nov 2026 12:20:27 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, David Marchand
 <david.marchand@redhat.com>, Thomas Monjalon <thomas@monjalon.net>,
 <stable@dpdk.org>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v2] net/memif: redesign control channel teardown
Date: Thu, 5 Nov 2026 12:20:26 +0100
Message-ID: <20261105112026.432015-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261030102218.3489371-1-sriram.yagnaraman@ericsson.com>
References: <20261030102218.3489371-1-sriram.yagnaraman@ericsson.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|BESPR07MB10713:EE_
X-MS-Office365-Filtering-Correlation-Id: 020e7f2b-268a-40a5-b15f-08df3b2eddf2
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|5023799004|11063799006|56012099006|261021123027099003|261022105027099003|261102123227099003|261028144727099003|261021121427099003|261022075727099003|261026121527099003|261026140227099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 3Mfx1wQy1TyWMXOacqb4fWLxpLNkxE4SQxjeXtBr+RVAUQhVmFDKEEoadaCpiXnKPQ6uaaiqxPL1b9Vi8sp3Gk7MdKkCTTftCJBdrIhoLEMmjJYzMxlOYKqSs7Kuda3UoTjQMCxaw3EDGzAXklnsvbfQnqBlneAvUJw9hbTpviwCA5nDgNf/JrI8w2n41oAh5oE4MUVpvqpta6N9ATKZCe05YL3kNyN2Rm3mnPla86r/pmpmy6XrLkxYStWckFZ0DiprvH1v+8AUI5E6jQ2fsWtA/pDRX+c8oAa3M2/UK9GhnZbTIy70cf7pFFSut424UNU8g4khyNcg6A6cnUFy4Hext7g+69DxVF9qjSp2NzqLx4sSRUw0xoiJtKJy58h4SrsskuimOnTxPv0oT9JrvbvHZE9AEUvTXH+u9SByEl6qWLyikaQeqHJ1zl6RBMdkMz/6gKU6A1lpOx4YpyBkhfM0cvoBTDpEw6OfwDkEtPB9qW4v4W2Cvb/dsF22Xjz/zUVWOt+YdOCoRCth0az73e7MtbTOd/hbvXFwFl7jT1ePeQZPmdm8b6FvbZ2vOfQkz/ymnhc+rDpnWKiEokYzn3zMCSJJRAuWJCT1ErZlrlyFkMbvbXPMx9e1UTZtqKHpo8yo37yY8jmr0CRB1Q7THfYNMU3Op+soQ4Zadp5L+OQUpPQ+7zQipo3kM55XCRLMBnvwwk+i/OB64Dv1z1dpFg==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(5023799004)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261026121527099003)(261026140227099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XW86FUvJGDuBekokYGhCkF3zDlJ0WCherLOI5w1SpILnrra/OdrBW0sUPu6DDfKpEj32i15RnFYyExutylA4RdNxpvKuTl8uaZJWhefw0loyBqfCS9ow4kT/3kFMGYOANzAiNI5QLysvjoyZQzrjqSDKiRu6HnubU1NLIAf9mx9LrO3+uhNYNpdSIHD/Vfa3cQCco9araYT/cI8VZLPvZgiuTmRfS26DwS07NoARNgJmJ/equRmmyjUiJvagIhMEh16iBHQn1LBqqylhYDxCFRZuch27tWFtMdBHvMS+vHZhwmjziAeH6k9Ww+pjoQqGwAplfBDhSjGwkYG7dIYKzr4mbF3RJzZUjjG5xOa9iSpWfYUC22zE0cshUNCS8c+iOgCNwlWukQrSFiOrXu8QnWdJz9DWrGYkF2qX5Uv37aOzB0fgeURmS31Ek+g3OhMS
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:20:58.7256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020e7f2b-268a-40a5-b15f-08df3b2eddf2
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR07MB10713
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

The control channel can be torn down from two threads: the EAL interrupt
thread (memif_intr_handler on peer disconnect/error) and an application
thread (dev_stop/dev_close -> memif_disconnect). Both race to unregister
the callback and free the channel, which memif_pmd_autotest SIGSEGVs on
during EAL teardown (seen on amd64 and arm64).

Rework teardown around a single owner:

  - memif_disconnect() clears pmd->cc under cc_lock; whoever clears it
    owns the free.
  - Device teardown (link down, flags, queue eventfds, regions) moves to
    memif_disconnect_queues(), run by whichever thread owns the
    disconnect, so flag/link state is left consistent for reconnect.
  - memif_cc_release() frees the channel: unregister_pending() on the
    interrupt thread (deferred free, drops the fd from epoll after
    dispatch), unregister_sync() on an application thread.
  - memif_intr_handler() self-unregisters on disconnect so the EOF
    (level-triggered) socket fd cannot re-fire (no livelock).

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
v2:
  - Redesign rather than extend v1. v1's approach (detach + handler
    ownership re-check that returns without unregistering) could
    livelock: the EOF control socket is level-triggered, so the handler
    re-fires continuously and starves the application thread waiting in
    unregister_sync(). v2 makes the handler always self-unregister via
    unregister_pending(), removing the fd from epoll so it cannot
    re-fire.
  - Split device-level teardown (link/flags/queues/regions) into
    memif_disconnect_queues() so the handler-owned disconnect leaves the
    same consistent state as memif_disconnect(); fixes a reconnect
    regression seen while developing the single-owner model.
  - Addresses the "teardown too complex" feedback by giving the channel
    a single owner (whoever clears pmd->cc) instead of splitting the
    free across two threads.
---
 drivers/net/memif/memif_socket.c | 179 ++++++++++++++++++++++---------
 1 file changed, 126 insertions(+), 53 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 971964133c..77d3044681 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -590,67 +590,23 @@ memif_intr_unregister_handler(const struct rte_intr_handle *intr_handle, void *a
 	rte_free(cc);
 }
 
-void
-memif_disconnect(struct rte_eth_dev *dev)
+/*
+ * Device-level teardown: mark the link down, close the per-queue interrupt
+ * eventfds and release the shared-memory regions. Idempotent and independent
+ * of the control channel, so it is safe to run from whichever thread owns the
+ * disconnect.
+ */
+static void
+memif_disconnect_queues(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
-	struct memif_msg_queue_elt *elt, *next;
 	struct memif_queue *mq;
-	struct rte_intr_handle *ih;
 	int i;
-	int ret;
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 	pmd->flags &= ~ETH_MEMIF_FLAG_CONNECTING;
 	pmd->flags &= ~ETH_MEMIF_FLAG_CONNECTED;
 
-	rte_spinlock_lock(&pmd->cc_lock);
-	if (pmd->cc != NULL) {
-		/* Clear control message queue (except disconnect message if any). */
-		for (elt = TAILQ_FIRST(&pmd->cc->msg_queue); elt != NULL; elt = next) {
-			next = TAILQ_NEXT(elt, next);
-			if (elt->msg.type != MEMIF_MSG_TYPE_DISCONNECT) {
-				TAILQ_REMOVE(&pmd->cc->msg_queue, elt, next);
-				rte_free(elt);
-			}
-		}
-		/* send disconnect message (if there is any in queue) */
-		memif_msg_send_from_queue(pmd->cc);
-
-		/* at this point, there should be no more messages in queue */
-		if (TAILQ_FIRST(&pmd->cc->msg_queue) != NULL) {
-			MIF_LOG(WARNING,
-				"Unexpected message(s) in message queue.");
-		}
-
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
-		}
-	}
-	rte_spinlock_unlock(&pmd->cc_lock);
-
-	/* unconfig interrupts */
 	for (i = 0; i < pmd->cfg.num_c2s_rings; i++) {
 		if (pmd->role == MEMIF_ROLE_CLIENT) {
 			if (dev->data->tx_queues != NULL)
@@ -697,6 +653,88 @@ memif_disconnect(struct rte_eth_dev *dev)
 		(pmd->role == MEMIF_ROLE_SERVER) ? "server" : "client");
 }
 
+/*
+ * Release a control channel and free it. Exactly one thread must do this
+ * per channel: the caller that cleared pmd->cc under cc_lock owns the free.
+ *
+ * On the interrupt thread the running callback cannot be waited for (it may
+ * be us), so the free is deferred to the pending-unregister callback, which
+ * EAL runs - and which removes the fd from the epoll set - once the current
+ * dispatch finishes. The handler therefore never returns leaving its own fd
+ * registered and hot, so it cannot re-fire on a half-torn-down channel.
+ *
+ * On an application thread the handler (if any) is waited out and the channel
+ * freed directly.
+ */
+static void
+memif_cc_release(struct memif_control_channel *cc)
+{
+	struct rte_intr_handle *ih = cc->intr_handle;
+	int ret;
+
+	if (rte_intr_fd_get(ih) < 0) {
+		/* Never registered; free directly. */
+		memif_intr_unregister_handler(ih, cc);
+		return;
+	}
+
+	if (rte_thread_is_intr()) {
+		ret = rte_intr_callback_unregister_pending(ih,
+				memif_intr_handler, cc,
+				memif_intr_unregister_handler);
+		if (ret < 0)
+			MIF_LOG(WARNING,
+				"Failed to defer control channel callback unregister.");
+	} else {
+		ret = rte_intr_callback_unregister_sync(ih,
+				memif_intr_handler, cc);
+		if (ret > 0 || ret == -ENOENT)
+			memif_intr_unregister_handler(ih, cc);
+		else
+			MIF_LOG(WARNING,
+				"Failed to unregister control channel callback.");
+	}
+}
+
+void
+memif_disconnect(struct rte_eth_dev *dev)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+	struct memif_msg_queue_elt *elt, *next;
+	struct memif_control_channel *cc;
+
+	/*
+	 * Detach the control channel: whoever clears pmd->cc under the lock
+	 * becomes the single owner of the free. If it is already NULL another
+	 * thread (the interrupt handler, or a concurrent disconnect) has taken
+	 * ownership and will release it; we only do the device-level teardown.
+	 */
+	rte_spinlock_lock(&pmd->cc_lock);
+	cc = pmd->cc;
+	pmd->cc = NULL;
+	if (cc != NULL) {
+		/* Clear control message queue (except disconnect message if any). */
+		for (elt = TAILQ_FIRST(&cc->msg_queue); elt != NULL; elt = next) {
+			next = TAILQ_NEXT(elt, next);
+			if (elt->msg.type != MEMIF_MSG_TYPE_DISCONNECT) {
+				TAILQ_REMOVE(&cc->msg_queue, elt, next);
+				rte_free(elt);
+			}
+		}
+		/* send disconnect message (if there is any in queue) */
+		memif_msg_send_from_queue(cc);
+		/* at this point, there should be no more messages in queue */
+		if (TAILQ_FIRST(&cc->msg_queue) != NULL)
+			MIF_LOG(WARNING, "Unexpected message(s) in message queue.");
+	}
+	rte_spinlock_unlock(&pmd->cc_lock);
+
+	if (cc != NULL)
+		memif_cc_release(cc);
+
+	memif_disconnect_queues(dev);
+}
+
 static int
 memif_msg_receive(struct memif_control_channel *cc)
 {
@@ -868,6 +906,8 @@ static void
 memif_intr_handler(void *arg)
 {
 	struct memif_control_channel *cc = arg;
+	struct pmd_internals *pmd;
+	bool owned;
 	int ret;
 
 	ret = memif_msg_receive(cc);
@@ -898,7 +938,40 @@ memif_intr_handler(void *arg)
 		MIF_LOG(WARNING, "eth dev not allocated");
 		return;
 	}
-	memif_disconnect(cc->dev);
+
+	/*
+	 * Self-unregister first. rte_intr_callback_unregister_pending() marks
+	 * this callback for deletion once the current dispatch returns, which
+	 * removes the fd from the epoll set. This is essential: the control
+	 * socket is at EOF and level-triggered, so without removing it the
+	 * handler would be re-dispatched forever (livelock) and starve any
+	 * application thread waiting in rte_intr_callback_unregister_sync().
+	 *
+	 * Ownership of the free is decided under cc_lock: whoever clears
+	 * pmd->cc frees the channel.
+	 *   - If this handler wins, it passes memif_intr_unregister_handler as
+	 *     the pending-unregister callback so EAL frees the channel after
+	 *     the dispatch, and it runs the device teardown.
+	 *   - If an application thread already cleared pmd->cc, it owns the
+	 *     free (it waits for us via unregister_sync, then frees); this
+	 *     handler passes a NULL unregister callback and does nothing else.
+	 */
+	pmd = cc->dev->data->dev_private;
+	rte_spinlock_lock(&pmd->cc_lock);
+	owned = (pmd->cc == cc);
+	if (owned)
+		pmd->cc = NULL;
+	rte_spinlock_unlock(&pmd->cc_lock);
+
+	ret = rte_intr_callback_unregister_pending(cc->intr_handle,
+			memif_intr_handler, cc,
+			owned ? memif_intr_unregister_handler : NULL);
+	if (ret < 0)
+		MIF_LOG(WARNING,
+			"Failed to defer control channel callback unregister.");
+
+	if (owned)
+		memif_disconnect_queues(cc->dev);
 }
 
 static void
-- 
2.43.7

