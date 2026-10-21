Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CAD606A324
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QjFOGnmx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96728406BA;
	Wed, 21 Oct 2026 11:23:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A9866406B6
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792574626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oynGA8XjIrNwbC3k8ZYBxceMHEGGeOCDs8rqU26FFqY=;
 b=QjFOGnmxyg10cJXr7huY5VhjDokooq67JlDzP1g5zPI7ULNtGPIfxtvjNt5oS8IhoQ3hbS
 R9m9OUuM86Cn87HGFc1/hGjABjPY6KOzV9ZmL0dqgL7FMLq1qG2SkkIQDy9UC7Q/kxjUB3
 Bh9dFZTOBH6Wrnh6xMlfqp++//RK2sw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-g1xN0QF8O8qZcA3ll00x1Q-1; Wed,
 21 Oct 2026 09:23:40 +0000
X-MC-Unique: g1xN0QF8O8qZcA3ll00x1Q-1
X-Mimecast-MFC-AGG-ID: g1xN0QF8O8qZcA3ll00x1Q_1792574619
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F15B31955F11; Wed, 21 Oct 2026 09:23:38 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8628F1800257; Wed, 21 Oct 2026 09:23:36 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/9] interrupts: do not duplicate interrupt handles
Date: Wed, 21 Oct 2026 11:23:12 +0200
Message-ID: <20261021092318.1554295-4-david.marchand@redhat.com>
In-Reply-To: <20261021092318.1554295-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qK0abqYkge1qCETMEmDeuWg6h4yN6uGcvnEHNR0_sR8_1792574619
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FD leak warnings recently added have revealed an interesting issue.

An interrupt handle is allocated and living usually in a bus device object
(or some standalone code, like the alarm code).
All the logic around the referenced FDs in this object are specific to
the callers, and those FDs must then be closed in the callers context.

On the other hand, the interrupt subsystem works with copies of interrupt
handle objects passed to it via rte_intr_callback_register/unregister.

When releasing this clone of the interrupt handle, the FDs are reported
as leaked, though there is no way for the interrupt subsystem itself to
know what to do with those FDs.

Instead of creating a clone, reference the interrupt handle directly.
The callers are responsible for unregistering those handles,
closing the FDs and freeing the handles.

This change also switches the interrupt source lookup from FD based
matching to pointer based matching.
The original FD based matching allowed different intr_handle objects
with the same FD to share an interrupt source.
However, this was problematic:
* the cloned handle stored in the source came from the first registrant,
* the ucb_fn callback would receive this clone, not the (const)
  caller's handle,
* with multiple handles for the same FD, later registrants would get
  the wrong handle in their callback,

In practice, DPDK components use one intr_handle per FD, so pointer
based matching simply enforces this existing invariant.
The interrupt dispatch code continues to use FD based matching since
epoll returns the FD, not the handle pointer.

The unregister callback (ucb_fn) signature is updated to take a const
pointer, reflecting that the interrupt subsystem no longer owns the
handle. Note that with this change, the intr_handle parameter passed
to ucb_fn is the same pointer the caller registered with, callers
can simply use their own handle from cb_arg instead.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/common/cnxk/roc_platform.h     |  1 -
 drivers/net/memif/memif_socket.c       |  5 ++--
 lib/eal/common/eal_common_interrupts.c | 26 --------------------
 lib/eal/freebsd/eal_interrupts.c       | 17 ++++---------
 lib/eal/include/rte_interrupts.h       | 17 +------------
 lib/eal/linux/eal_interrupts.c         | 33 ++++++++------------------
 7 files changed, 20 insertions(+), 80 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c02..78f9bb54aa 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -404,6 +404,7 @@ API Changes
     to invalid values instead of zero.
   * Added ``rte_intr_fd_close()`` and ``rte_intr_dev_fd_close()``
     helpers to close file descriptors and reset them to -1.
+  * ``rte_intr_unregister_callback_fn`` now receives a ``const`` interrupt handle.
 
 * mempool: When creating a mempool, the cache size can be freely specified
   (although still not exceed the number of elements),
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index aba9782023..149522608e 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -178,7 +178,6 @@ plt_thread_is_valid(plt_thread_t thr)
 #define plt_intr_type_get		rte_intr_type_get
 #define plt_intr_type_set		rte_intr_type_set
 #define plt_intr_instance_alloc		rte_intr_instance_alloc
-#define plt_intr_instance_dup		rte_intr_instance_dup
 #define plt_intr_instance_free		rte_intr_instance_free
 #define plt_intr_event_list_update	rte_intr_event_list_update
 #define plt_intr_max_intr_get		rte_intr_max_intr_get
diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 87b23aa8b4..2d16decbef 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -572,13 +572,14 @@ memif_msg_enq_connected(struct rte_eth_dev *dev)
 }
 
 static void
-memif_intr_unregister_handler(struct rte_intr_handle *intr_handle, void *arg)
+memif_intr_unregister_handler(const struct rte_intr_handle *intr_handle, void *arg)
 {
 	struct memif_msg_queue_elt *elt;
 	struct memif_control_channel *cc = arg;
 
+	RTE_SET_USED(intr_handle);
 	/* close control channel fd */
-	rte_intr_fd_close(intr_handle);
+	rte_intr_fd_close(cc->intr_handle);
 	/* clear message queue */
 	while ((elt = TAILQ_FIRST(&cc->msg_queue)) != NULL) {
 		TAILQ_REMOVE(&cc->msg_queue, elt, next);
diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index 6368ef1771..1208a2597d 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -103,32 +103,6 @@ struct rte_intr_handle *rte_intr_instance_alloc(uint32_t flags)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_instance_dup)
-struct rte_intr_handle *rte_intr_instance_dup(const struct rte_intr_handle *src)
-{
-	struct rte_intr_handle *intr_handle;
-
-	if (src == NULL) {
-		EAL_LOG(DEBUG, "Source interrupt instance unallocated");
-		rte_errno = EINVAL;
-		return NULL;
-	}
-
-	intr_handle = rte_intr_instance_alloc(src->alloc_flags);
-	if (intr_handle != NULL) {
-		intr_handle->fd = src->fd;
-		intr_handle->dev_fd = src->dev_fd;
-		intr_handle->type = src->type;
-		intr_handle->max_intr = src->max_intr;
-		intr_handle->nb_efd = src->nb_efd;
-		intr_handle->efd_counter_size = src->efd_counter_size;
-		memcpy(intr_handle->efds, src->efds, src->nb_intr);
-		memcpy(intr_handle->elist, src->elist, src->nb_intr);
-	}
-
-	return intr_handle;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_event_list_update)
 int rte_intr_event_list_update(struct rte_intr_handle *intr_handle, int size)
 {
diff --git a/lib/eal/freebsd/eal_interrupts.c b/lib/eal/freebsd/eal_interrupts.c
index bb2bc529f2..b29a2b174e 100644
--- a/lib/eal/freebsd/eal_interrupts.c
+++ b/lib/eal/freebsd/eal_interrupts.c
@@ -41,7 +41,7 @@ struct rte_intr_callback {
 
 struct rte_intr_source {
 	TAILQ_ENTRY(rte_intr_source) next;
-	struct rte_intr_handle *intr_handle; /**< interrupt handle */
+	const struct rte_intr_handle *intr_handle; /**< interrupt handle */
 	struct rte_intr_cb_list callbacks;  /**< user callbacks */
 	uint32_t active;
 };
@@ -105,7 +105,7 @@ rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 
 	/* find the source for this intr_handle */
 	TAILQ_FOREACH(src, &intr_sources, next) {
-		if (rte_intr_fd_get(src->intr_handle) == rte_intr_fd_get(intr_handle))
+		if (src->intr_handle == intr_handle)
 			break;
 	}
 
@@ -138,14 +138,7 @@ rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 				ret = -ENOMEM;
 				goto fail;
 			} else {
-				src->intr_handle = rte_intr_instance_dup(intr_handle);
-				if (src->intr_handle == NULL) {
-					EAL_LOG(ERR, "Can not create intr instance");
-					ret = -ENOMEM;
-					free(src);
-					src = NULL;
-					goto fail;
-				}
+				src->intr_handle = intr_handle;
 				TAILQ_INIT(&src->callbacks);
 				TAILQ_INSERT_TAIL(&intr_sources, src, next);
 			}
@@ -239,7 +232,7 @@ rte_intr_callback_unregister_pending(const struct rte_intr_handle *intr_handle,
 
 	/* check if the interrupt source for the fd is existent */
 	TAILQ_FOREACH(src, &intr_sources, next)
-		if (rte_intr_fd_get(src->intr_handle) == rte_intr_fd_get(intr_handle))
+		if (src->intr_handle == intr_handle)
 			break;
 
 	/* No interrupt source registered for the fd */
@@ -294,7 +287,7 @@ rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 
 	/* check if the interrupt source for the fd is existent */
 	TAILQ_FOREACH(src, &intr_sources, next)
-		if (rte_intr_fd_get(src->intr_handle) == rte_intr_fd_get(intr_handle))
+		if (src->intr_handle == intr_handle)
 			break;
 
 	/* No interrupt source registered for the fd */
diff --git a/lib/eal/include/rte_interrupts.h b/lib/eal/include/rte_interrupts.h
index d04c0c7b15..bb06180bea 100644
--- a/lib/eal/include/rte_interrupts.h
+++ b/lib/eal/include/rte_interrupts.h
@@ -70,7 +70,7 @@ typedef void (*rte_intr_callback_fn)(void *cb_arg);
  * Function to call after a callback is unregistered.
  * Can be used to close fd and free cb_arg.
  */
-typedef void (*rte_intr_unregister_callback_fn)(struct rte_intr_handle *intr_handle,
+typedef void (*rte_intr_unregister_callback_fn)(const struct rte_intr_handle *intr_handle,
 						void *cb_arg);
 
 /**
@@ -432,21 +432,6 @@ __rte_internal
 int
 rte_intr_cap_multiple(struct rte_intr_handle *intr_handle);
 
-/**
- * @internal
- * Creates a clone of src by allocating a new handle and copying src content.
- *
- * @param src
- *  Source interrupt handle to be cloned.
- *
- * @return
- *  - On success, address of interrupt handle.
- *  - On failure, NULL.
- */
-__rte_internal
-struct rte_intr_handle *
-rte_intr_instance_dup(const struct rte_intr_handle *src);
-
 /**
  * @internal
  * Set the device fd field of interrupt handle with user
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 4cfaeba7fe..dcc2c0efdb 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -78,7 +78,7 @@ struct rte_intr_callback {
 
 struct rte_intr_source {
 	TAILQ_ENTRY(rte_intr_source) next;
-	struct rte_intr_handle *intr_handle; /**< interrupt handle */
+	const struct rte_intr_handle *intr_handle; /**< interrupt handle */
 	struct rte_intr_cb_list callbacks;  /**< user callbacks */
 	uint32_t active;
 };
@@ -511,7 +511,7 @@ rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 
 	/* check if there is at least one callback registered for the fd */
 	TAILQ_FOREACH(src, &intr_sources, next) {
-		if (rte_intr_fd_get(src->intr_handle) == rte_intr_fd_get(intr_handle)) {
+		if (src->intr_handle == intr_handle) {
 			/* we had no interrupts for this */
 			if (TAILQ_EMPTY(&src->callbacks))
 				wake_thread = 1;
@@ -531,22 +531,12 @@ rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 			free(callback);
 			callback = NULL;
 		} else {
-			src->intr_handle = rte_intr_instance_dup(intr_handle);
-			if (src->intr_handle == NULL) {
-				EAL_LOG(ERR, "Can not create intr instance");
-				ret = -ENOMEM;
-				free(callback);
-				callback = NULL;
-				free(src);
-				src = NULL;
-			} else {
-				TAILQ_INIT(&src->callbacks);
-				TAILQ_INSERT_TAIL(&(src->callbacks), callback,
-						  next);
-				TAILQ_INSERT_TAIL(&intr_sources, src, next);
-				wake_thread = 1;
-				ret = 0;
-			}
+			src->intr_handle = intr_handle;
+			TAILQ_INIT(&src->callbacks);
+			TAILQ_INSERT_TAIL(&(src->callbacks), callback, next);
+			TAILQ_INSERT_TAIL(&intr_sources, src, next);
+			wake_thread = 1;
+			ret = 0;
 		}
 	}
 
@@ -584,7 +574,7 @@ rte_intr_callback_unregister_pending(const struct rte_intr_handle *intr_handle,
 
 	/* check if the interrupt source for the fd is existent */
 	TAILQ_FOREACH(src, &intr_sources, next) {
-		if (rte_intr_fd_get(src->intr_handle) == rte_intr_fd_get(intr_handle))
+		if (src->intr_handle == intr_handle)
 			break;
 	}
 
@@ -635,7 +625,7 @@ rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 
 	/* check if the interrupt source for the fd is existent */
 	TAILQ_FOREACH(src, &intr_sources, next)
-		if (rte_intr_fd_get(src->intr_handle) == rte_intr_fd_get(intr_handle))
+		if (src->intr_handle == intr_handle)
 			break;
 
 	/* No interrupt source registered for the fd */
@@ -666,7 +656,6 @@ rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 		/* all callbacks for that source are removed. */
 		if (TAILQ_EMPTY(&src->callbacks)) {
 			TAILQ_REMOVE(&intr_sources, src, next);
-			rte_intr_instance_free(src->intr_handle);
 			free(src);
 		}
 	}
@@ -922,7 +911,6 @@ eal_intr_source_remove_and_free(struct rte_intr_source *src)
 	}
 
 	/* Free the interrupt source */
-	rte_intr_instance_free(src->intr_handle);
 	free(src);
 }
 
@@ -1067,7 +1055,6 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 		/* all callbacks for that source are removed. */
 		if (TAILQ_EMPTY(&src->callbacks)) {
 			TAILQ_REMOVE(&intr_sources, src, next);
-			rte_intr_instance_free(src->intr_handle);
 			free(src);
 		}
 
-- 
2.54.0

