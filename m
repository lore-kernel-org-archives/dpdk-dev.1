Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CAD606A31B
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=uX7CnFT8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65C89402DE;
	Sun, 25 Oct 2026 18:01:01 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 6864C40150
 for <dev@dpdk.org>; Sun, 25 Oct 2026 18:00:58 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3acc96a256dso1249489a91.3
 for <dev@dpdk.org>; Sun, 25 Oct 2026 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792947657;
 x=1793552457; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XAZEZfw2uxGIxOpb9kGu1vefV1sy2X0Hnky7IwTSG4A=;
 b=uX7CnFT8cEr0kCLgo9hM71WSc1WYLyp8otoWnbQ6tyDLKoP39xLJY0fahLLKIl8Lh7
 IqN+e0bGaDDoSBnUj8VBe/uG2w78h+Fabt4wjbYXQOjI8jmhVvvPg/MMrZ/EPcHJxXEo
 nf+Ma97cZ6J+99S3BMHZ1gqCitVJAM2+C2gZUm1f3ri+1n5QcqpK5L4iMBDQ7i36us+9
 K5n4NrspxDXWamoSHLW7Bbwp67r/rq083gXT4D8JBkZ6WBC4FiM0R533EN/dwvKb5Xv+
 xWXdX7tDxnYiQqEzxkUGNiEh30c1/HcZfNZOQwRHNYjHWl1bnugPYBDAsA0zU9pHMujX
 Whtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792947657; x=1793552457;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XAZEZfw2uxGIxOpb9kGu1vefV1sy2X0Hnky7IwTSG4A=;
 b=OQ9e3513N47nmFGz/XhQjGaneEdjy3EgNwJlQfVtdNmdRJVjjILDPKfltllMuRz9IV
 aa4Mf/KDi/VM5dyfYSAZqw7NIr344cvelPMp/VBxnihTbH5h5IJ1VKmkg/+CCIIxRHNp
 PzNZiPy+SiFsxWP7x6VMJb7Q/9wGh9cY+V5I7MubVxylGwA5b26axQ/ts3nKiQdEhSqQ
 /9pi2hLMpBVE+AGO/TnjSRSwP8fBrQPkRbF3G81khHS5O8b+lPuGvKJd1I9zswJ57iN0
 u5SlK6pAIVwRkyVCRR6hWwK6BFFDxUFQIjA6Sn3LqnZ4fPvNkjcDLqOL3hiDBhquMAIA
 Mw6w==
X-Gm-Message-State: AFq9FYK2LcwV2SO5DfOCIaaeZOl8dk56kZ6OdxmoYm/CP4/+xBSM8kqY
 5gsbQRtsxCsdnWYRFa5qHGpJ6y4NvMopnMmLV+Oh4NcfdX7ARquyy5uxLJk47jXohgw=
X-Gm-Gg: AYBFou2U7qzAcjqt/7I2ZgXhBy4bei36VPgNUIyoTUnUqSfZjrZg7pSs1tVFPoIWGNi
 9gCtzpL2G4F7uqk7MmgXhYG8N7JzDj0hhpUS41EnbWFdJ732TfP/olweyZr50x+Zmy7my5aWl6Y
 tDbjprtPl9qTSyVHtXVIlVl52NlGE07GNlHHDxeYCxeR3+Sk8jM4D89XiN4jIFkbE+ztHkjOncx
 AeJPwejCtXbuf3qeHeBypmpmtfz5BVbVSUSBYfaB2633ViUhgkvOSgLLBdAK7uawtXP6QmReNeg
 2rAUofj2pZYIuYQscXtbbK06CT0veqdhqRxZbXvcMWjyzfZNd5YnBZYJqxx4j1pKAGy9MrjN03q
 0t1pr+MIXPDaXj9OgGQS3jt9H8zyByP6F7eokZu6e9us63TmU0Uwkax8eFJ2njHYYg1H4QHbzXA
 7HWx3nTf/as3WDKhnDkQA3rtRKe7UqtQfHMA/0mdxJyTrjwFwZ9k3UPb4otD14H1pUc+0jfUFlu
 cSsRqJUWthbPw+49M7VQlcvUeht2cSBUT8PHy/LXtQUIw1mqB//ckp1LntPdVE/P1vD+xWzOjAZ
 7qmzjhDaTIsuOGbgUWYbhzk=
X-Received: by 2002:a17:90b:2c87:b0:3ac:9c37:9429 with SMTP id
 98e67ed59e1d1-3adeae77068mr3908584a91.52.1792947656736; 
 Sun, 25 Oct 2026 10:00:56 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ccccf37esm894291a12.27.2026.10.25.10.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:00:56 -0700 (PDT)
Date: Sun, 25 Oct 2026 10:00:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>, <stable@dpdk.org>
Subject: Re: [PATCH v4 9/9] test/memif: add memif PMD unit test
Message-ID: <20261025100053.4d00c601@phoenix.local>
In-Reply-To: <20261016195857.3258796-10-sriram.yagnaraman@ericsson.com>
References: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
 <20261016195857.3258796-10-sriram.yagnaraman@ericsson.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 21:58:57 +0200
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> Add a memif_pmd_autotest unit test, modelled on the TAP PMD test. memif
> differs from TAP in that a port is only usable once a peer connects, so
> the test creates a server and a client memif port in the same process,
> connected over an abstract-namespace socket (the loopback setup from the
> memif documentation), and waits for the asynchronous control-channel
> handshake to bring both ports up.
>=20
> The suite checks dev_info reports the memif driver, that the pair reaches
> link up, statistics get and reset, a client-to-server loopback burst with
> payload verification on both the slow and the single-pool fast path (a
> second default-bsize pair), multi-segment loopback across a ring wrap
> with payload verification (chained-descriptor Rx and Tx), that the pair
> reconnects after a port restart, that a zero-length Tx burst is handled,
> that a configured-but-not-started port can be closed without crashing,
> and that a server stopped after start refuses a peer. It is a fast test,
> runs without hugepages and under ASan.
>=20
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> ---

This test is getting lots of CI failures.

AI says it found the answer. The analysis is likely correct, but
the fix looks awkward.

=46rom 9a0d594135e21e949e814df036d30d70ff93e45b Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sun, 25 Oct 2026 09:45:50 -0700
Subject: [PATCH] net/memif: fix race between interrupt thread and stop

memif_disconnect() can run in the interrupt thread, from the control
channel handler on peer EOF, at the same time as dev_stop/dev_close
in the application thread. When the handler is active the application
side only marks the callback pending and carries on freeing queues,
regions and finally the port. The handler then calls memif_disconnect()
on a released ethdev and crashes on dev->data.

Seen as a SIGSEGV in memif_pmd_autotest teardown, where stopping the
server makes the client channel see EOF while the test is stopping and
closing the client.

When called from an application thread, detach the channel under
cc_lock and wait for the handler with
rte_intr_callback_unregister_sync() before tearing down. The handler
drops its own callback if it finds the channel detached, otherwise
the EOF keeps the fd readable and the wait never completes. Hold
cc_lock over the queue and region teardown so the two paths cannot
run it concurrently.

Close the channel fd through its own handle when freeing it; the
handle given to the pending unregister callback is the EAL copy.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01FA4k3HfYcHiM1tu71SfXb1
---
Applies on top of "net/memif: reset FD in interrupt handle"
(v2 07/12 of David's interrupt FD series).

 drivers/net/memif/memif_socket.c | 110 +++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 36 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_soc=
ket.c
index fb639fde91..e580f97bc4 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -572,83 +572,103 @@ memif_msg_enq_connected(struct rte_eth_dev *dev)
 }
=20
 static void
-memif_intr_unregister_handler(struct rte_intr_handle *intr_handle, void *a=
rg)
+memif_cc_free(struct memif_control_channel *cc)
 {
 	struct memif_msg_queue_elt *elt;
-	struct memif_control_channel *cc =3D arg;
=20
-	/* close control channel fd */
-	rte_intr_fd_close(intr_handle);
-	/* clear message queue */
+	rte_intr_fd_close(cc->intr_handle);
 	while ((elt =3D TAILQ_FIRST(&cc->msg_queue)) !=3D NULL) {
 		TAILQ_REMOVE(&cc->msg_queue, elt, next);
 		rte_free(elt);
 	}
 	rte_intr_instance_free(cc->intr_handle);
-	/* free control channel */
 	rte_free(cc);
 }
=20
+/*
+ * Pending unregister callback, run by the interrupt thread once
+ * memif_intr_handler() has returned. The handle passed in is the
+ * EAL copy, close the fd through the control channel's own handle.
+ */
+static void
+memif_intr_unregister_handler(struct rte_intr_handle *intr_handle __rte_un=
used, void *arg)
+{
+	memif_cc_free(arg);
+}
+
 void
 memif_disconnect(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd =3D dev->data->dev_private;
 	struct memif_msg_queue_elt *elt, *next;
+	struct memif_control_channel *cc;
 	struct memif_queue *mq;
-	struct rte_intr_handle *ih;
 	int i;
 	int ret;
=20
+	rte_spinlock_lock(&pmd->cc_lock);
 	dev->data->dev_link.link_status =3D RTE_ETH_LINK_DOWN;
 	pmd->flags &=3D ~ETH_MEMIF_FLAG_CONNECTING;
 	pmd->flags &=3D ~ETH_MEMIF_FLAG_CONNECTED;
=20
-	rte_spinlock_lock(&pmd->cc_lock);
-	if (pmd->cc !=3D NULL) {
+	cc =3D pmd->cc;
+	pmd->cc =3D NULL;
+	if (cc !=3D NULL) {
 		/* Clear control message queue (except disconnect message if any). */
-		for (elt =3D TAILQ_FIRST(&pmd->cc->msg_queue); elt !=3D NULL; elt =3D ne=
xt) {
+		for (elt =3D TAILQ_FIRST(&cc->msg_queue); elt !=3D NULL; elt =3D next) {
 			next =3D TAILQ_NEXT(elt, next);
 			if (elt->msg.type !=3D MEMIF_MSG_TYPE_DISCONNECT) {
-				TAILQ_REMOVE(&pmd->cc->msg_queue, elt, next);
+				TAILQ_REMOVE(&cc->msg_queue, elt, next);
 				rte_free(elt);
 			}
 		}
 		/* send disconnect message (if there is any in queue) */
-		memif_msg_send_from_queue(pmd->cc);
+		memif_msg_send_from_queue(cc);
=20
 		/* at this point, there should be no more messages in queue */
-		if (TAILQ_FIRST(&pmd->cc->msg_queue) !=3D NULL) {
-			MIF_LOG(WARNING,
-				"Unexpected message(s) in message queue.");
-		}
+		if (TAILQ_FIRST(&cc->msg_queue) !=3D NULL)
+			MIF_LOG(WARNING, "Unexpected message(s) in message queue.");
=20
-		ih =3D pmd->cc->intr_handle;
-		if (rte_intr_fd_get(ih) >=3D 0) {
-			ret =3D rte_intr_callback_unregister(ih,
-							memif_intr_handler,
-							pmd->cc);
+		if (rte_thread_is_intr()) {
 			/*
-			 * If callback is active (disconnecting based on
-			 * received control message).
+			 * Called from the interrupt thread, possibly from
+			 * memif_intr_handler() itself: cannot wait for it.
 			 */
-			if (ret =3D=3D -EAGAIN) {
-				ret =3D rte_intr_callback_unregister_pending(ih,
-							memif_intr_handler,
-							pmd->cc,
-							memif_intr_unregister_handler);
-			} else if (ret > 0) {
-				rte_intr_fd_close(ih);
-				rte_intr_instance_free(ih);
-				rte_free(pmd->cc);
-			}
-			pmd->cc =3D NULL;
+			ret =3D rte_intr_callback_unregister(cc->intr_handle,
+							   memif_intr_handler, cc);
+			if (ret =3D=3D -EAGAIN)
+				ret =3D rte_intr_callback_unregister_pending(cc->intr_handle,
+						memif_intr_handler, cc,
+						memif_intr_unregister_handler);
+			else if (ret > 0)
+				memif_cc_free(cc);
 			if (ret <=3D 0)
-				MIF_LOG(WARNING,
-					"Failed to unregister control channel callback.");
+				MIF_LOG(WARNING, "Failed to unregister control channel callback.");
+			cc =3D NULL;
 		}
 	}
 	rte_spinlock_unlock(&pmd->cc_lock);
=20
+	if (cc !=3D NULL) {
+		/*
+		 * Called from an application thread (dev_stop/dev_close).
+		 * The interrupt thread may be running memif_intr_handler()
+		 * for this channel and about to call memif_disconnect() on
+		 * this device. Wait for it to finish before tearing down,
+		 * otherwise it races with the caller freeing the queues and
+		 * releasing the port. The lock must not be held here since
+		 * the handler takes it.
+		 */
+		ret =3D rte_intr_callback_unregister_sync(cc->intr_handle,
+							memif_intr_handler, cc);
+		/* -ENOENT: the handler saw the channel detached and dropped itself. */
+		if (ret > 0 || ret =3D=3D -ENOENT)
+			memif_cc_free(cc);
+		else
+			MIF_LOG(WARNING, "Failed to unregister control channel callback.");
+	}
+
+	rte_spinlock_lock(&pmd->cc_lock);
 	/* unconfig interrupts */
 	for (i =3D 0; i < pmd->cfg.num_c2s_rings; i++) {
 		if (pmd->role =3D=3D MEMIF_ROLE_CLIENT) {
@@ -694,6 +714,7 @@ memif_disconnect(struct rte_eth_dev *dev)
=20
 	MIF_LOG(DEBUG, "Disconnected, id: %d, role: %s.", pmd->id,
 		(pmd->role =3D=3D MEMIF_ROLE_SERVER) ? "server" : "client");
+	rte_spinlock_unlock(&pmd->cc_lock);
 }
=20
 static int
@@ -867,6 +888,8 @@ static void
 memif_intr_handler(void *arg)
 {
 	struct memif_control_channel *cc =3D arg;
+	struct pmd_internals *pmd;
+	bool owned;
 	int ret;
=20
 	ret =3D memif_msg_receive(cc);
@@ -897,6 +920,21 @@ memif_intr_handler(void *arg)
 		MIF_LOG(WARNING, "eth dev not allocated");
 		return;
 	}
+
+	pmd =3D cc->dev->data->dev_private;
+	rte_spinlock_lock(&pmd->cc_lock);
+	owned =3D (pmd->cc =3D=3D cc);
+	rte_spinlock_unlock(&pmd->cc_lock);
+	if (!owned) {
+		/*
+		 * Detached by memif_disconnect() in an application thread
+		 * which is waiting for this handler to finish and will free
+		 * the channel. Stop polling the fd, it stays readable on EOF.
+		 */
+		rte_intr_callback_unregister_pending(cc->intr_handle,
+						     memif_intr_handler, cc, NULL);
+		return;
+	}
 	memif_disconnect(cc->dev);
 }
=20
--=20
2.43.0

