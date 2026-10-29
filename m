Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E63F606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dloFNJ8x
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3E0C4025A;
	Thu, 29 Oct 2026 18:03:37 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 4949240151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 18:03:37 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3ac91ac8924so1548636a91.1
 for <dev@dpdk.org>; Thu, 29 Oct 2026 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793293415;
 x=1793898215; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bnOAWS46QRDEpUNguIilf+qmA3ePrSr179G2p6EIxyg=;
 b=dloFNJ8xZocE6MiW3+GsjTBfUz9kJZrG69/3DQK/6MH78s/36sGvRCpP1Q6XARBliF
 bkUbzjTf2DI03hG7+f5lr7sSRRT5COu8oVxEYulacD1XK1aixc011AhCz9bF9W0srFC7
 NDfH1i0wP1m7DeSZ2ouyOVL/S6RWI2pvM6f7whJDcwnrYdZLp514rUhgofdcMHfMdkTB
 Xtf3RQeQ113KvmEVfurG4UqIE96dP4xc/CasAF6CiP4thb7HWuxP0MeXg0Z0gbt8pfPP
 RF6Ugf4pLm9XBhoMGZiAC27J7noN+OF49fD8uG5lEtgIVFBAG7Zb9ze9MZIOPsv431r2
 BYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293416; x=1793898216;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bnOAWS46QRDEpUNguIilf+qmA3ePrSr179G2p6EIxyg=;
 b=uGFUFaLyg9bhh3I+TBMeE9AL2PpyIGQkxrJo4ywbzFRbArF7M9J0kz/66KJxTMqwP2
 UcsFRHYu7h8+IebIXVt2eTJQ2fV1w2JnkPKWIwV9HauEfozjdh0DQiD8md3F7w4qH95u
 OtJzv2zrsJJ8k32IVrZQv6P48bKAoc7atDTJP+2vvkOp6zslk4CVdnBm84IoKK1x3joI
 77lbCSpRLSKXXjvyPqrkq3kgTDMhl7KYUD9L8/QEy9XrGbHxPGx5VvMbL+NXgq6a5rmg
 KuL+9BhnmtEXdHyOWRJuVy07E1Xbp1KCUtH1Est92fL9NoqbI1ez6RG98xrQmtoovDAh
 O9kA==
X-Gm-Message-State: AFq9FYIdDycCS6KWRFD61N+up2wS/CHLc7X9UP0hJeOoRfzbDkumurPV
 uu+fvlqY4wMpEqDqBcb6Kqsp77acbKPWryBXjhIJJann8y1x4cfuvBlWieFYyoEHqfYHnPCi4fi
 N3PzGDgs=
X-Gm-Gg: AYBFou3OoFqqiglbRHoyLViV6UlAHWha63RAHGdNLOF5cfgiTW2hdG8xbJeZrS8kQzx
 /bRBbWriVhWjVaLcrjjwpsBmxrgFr9UACklWCifS5RBNBHtf23Cwm+o9nmDlduNFBDssblWjgrN
 fPn9xrgMh/PXxBvHiYur38MKbd16TNWdI8EfTY/KgP+HKDxqYb24UfYn5Bg7VZlMCqmIHeIbdy4
 b9G1tbTpaysrbV6FIDBHs/2WfgK+fdVqJjjRrx93NZjBOxGEKtu/LuDrIVxsrq4mEworoG9hZ2M
 ywKZ1E9D/cefxkd+fi/JyIgE627mOeroAy9pNRAlFIA/sMRhvXwVCtBhIz+dOXEni8vpti77DUu
 n91VfU02D6Z4baTV/QZ/9DmHzeGbb/e8mPrurEpL92CYb3aYdUPt6L3dkgfv2S1fovSGNlaOxoE
 bGelt8ZRABY+6ZyLXYIw5vbBx5LP4jb8FnQXPoS953S5mpHFecEgMPFSQuqNwZvwqkD3s5+Saj9
 9E4yujVgEhpiMMYv7bZyZsYEDtVE0R7UyzXSJ3fJywv15sBoHLQKxb/o0X15dymphXowfZ1SyUp
 ViSDcSQwabXvs6mc6EzGQwSDfiEOsWNeu8aXBtES9UUnenXwiMjfL8/J4wV15ubB19oWQ7c=
X-Received: by 2002:a17:90a:c886:b0:3ac:9e76:aa9b with SMTP id
 98e67ed59e1d1-3ae57e2b795mr4613196a91.7.1793293415412; 
 Thu, 29 Oct 2026 10:03:35 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e7d429fsm4936310a91.2.2026.10.29.10.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:03:34 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:03:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: dev@dpdk.org
Subject: memif test failures on next-net
Message-ID: <20261029100329.3cb8fa14@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The memif autotest is failing in CI for next-net.

AI suggests that the issue is missing synchronization.
The proposed patch seems to have merge conflicts, and I can't really test it
well. Please make up something better.

Subject: [PATCH] net/memif: fix race between disconnect and control callback

The control channel callback runs on the interrupt thread and calls
memif_disconnect() when the peer hangs up. Nothing orders this against
the application stopping and closing the same port. If the peer of a
loopback pair is stopped first, the callback can still be running
memif_disconnect() when the port is closed and released, and it then
dereferences dev->data which is now NULL.

Seen as a SIGSEGV on the interrupt thread during teardown of
memif_pmd_autotest.

Take the control channel from the device under cc_lock, and release it
outside the lock. When not on the interrupt thread, wait for a running
callback with rte_intr_callback_unregister_sync() so the device stays
valid until it returns. The callback no longer disconnects a device
that has already dropped its channel, and queue and region teardown is
serialized under cc_lock.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org


---
 drivers/net/memif/memif_socket.c | 101 +++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 33 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index b47c7a3b..a7b1c45f 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -590,66 +590,86 @@ memif_intr_unregister_handler(const struct rte_intr_handle *intr_handle, void *a
 	rte_free(cc);
 }
 
+/*
+ * Detach a control channel that is no longer reachable from its device.
+ *
+ * If its callback is running on the interrupt thread, wait for it to
+ * return so that the device can be released safely by the caller.
+ * If called from that callback, defer the free until it returns.
+ */
+static void
+memif_cc_release(struct memif_control_channel *cc)
+{
+	struct rte_intr_handle *ih = cc->intr_handle;
+	int ret;
+
+	ret = rte_intr_callback_unregister(ih, memif_intr_handler, cc);
+	if (ret == -EAGAIN) {
+		if (rte_thread_is_intr()) {
+			ret = rte_intr_callback_unregister_pending(ih,
+					memif_intr_handler, cc,
+					memif_intr_unregister_handler);
+			if (ret <= 0)
+				MIF_LOG(WARNING,
+					"Failed to unregister control channel callback.");
+			return;
+		}
+		ret = rte_intr_callback_unregister_sync(ih, memif_intr_handler, cc);
+	}
+	if (ret < 0 && ret != -ENOENT && ret != -EINVAL)
+		MIF_LOG(WARNING, "Failed to unregister control channel callback.");
+
+	memif_intr_unregister_handler(ih, cc);
+}
+
 void
 memif_disconnect(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
 	struct memif_msg_queue_elt *elt, *next;
+	struct memif_control_channel *cc;
 	struct memif_queue *mq;
-	struct rte_intr_handle *ih;
 	int i;
-	int ret;
 
+	/*
+	 * Called from the application (stop/close) and from the interrupt
+	 * thread (peer hangup, bad descriptor). Take ownership of the control
+	 * channel under the lock so only one caller releases it.
+	 */
+	rte_spinlock_lock(&pmd->cc_lock);
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 	pmd->flags &= ~ETH_MEMIF_FLAG_CONNECTING;
 	pmd->flags &= ~ETH_MEMIF_FLAG_CONNECTED;
 
-	rte_spinlock_lock(&pmd->cc_lock);
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
 
 		/* at this point, there should be no more messages in queue */
-		if (TAILQ_FIRST(&pmd->cc->msg_queue) != NULL) {
+		if (TAILQ_FIRST(&cc->msg_queue) != NULL) {
 			MIF_LOG(WARNING,
 				"Unexpected message(s) in message queue.");
 		}
-
-		ih = pmd->cc->intr_handle;
-		if (rte_intr_fd_get(ih) > 0) {
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
 	}
 	rte_spinlock_unlock(&pmd->cc_lock);
 
+	/* Must not hold cc_lock here, the running callback may need it. */
+	if (cc != NULL)
+		memif_cc_release(cc);
+
+	/* Serialize teardown against a concurrent disconnect from the other thread. */
+	rte_spinlock_lock(&pmd->cc_lock);
+
 	/* unconfig interrupts */
 	for (i = 0; i < pmd->cfg.num_c2s_rings; i++) {
 		if (pmd->role == MEMIF_ROLE_CLIENT) {
@@ -686,6 +706,7 @@ memif_disconnect(struct rte_eth_dev *dev)
 
 	/* reset connection configuration */
 	memset(&pmd->run, 0, sizeof(pmd->run));
+	rte_spinlock_unlock(&pmd->cc_lock);
 
 	MIF_LOG(DEBUG, "Disconnected, id: %d, role: %s.", pmd->id,
 		(pmd->role == MEMIF_ROLE_SERVER) ? "server" : "client");
@@ -862,6 +883,8 @@ static void
 memif_intr_handler(void *arg)
 {
 	struct memif_control_channel *cc = arg;
+	struct pmd_internals *pmd;
+	bool owned;
 	int ret;
 
 	ret = memif_msg_receive(cc);
@@ -892,6 +915,18 @@ memif_intr_handler(void *arg)
 		MIF_LOG(WARNING, "eth dev not allocated");
 		return;
 	}
+
+	/*
+	 * If the device was stopped on another thread, the channel was
+	 * already taken from it and that thread is waiting for this callback
+	 * to return before releasing the channel.
+	 */
+	pmd = cc->dev->data->dev_private;
+	rte_spinlock_lock(&pmd->cc_lock);
+	owned = (pmd->cc == cc);
+	rte_spinlock_unlock(&pmd->cc_lock);
+	if (!owned)
+		return;
 	memif_disconnect(cc->dev);
 }
 
-- 
2.43.0

