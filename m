Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BCE9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 14:39:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6896B4042E;
	Thu, 19 Feb 2026 15:39:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 94BB54042E
 for <dev@dpdk.org>; Thu, 19 Feb 2026 15:39:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771511950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1dyWWjwi2WOkekxGZpcTvlKAmoXVzdJ1WsfG+9KFfM=;
 b=Ik/dYKJwKDJEwb+2UYmcBbXOPajP3fN+ZpZbLIwkB28sEislJ54rIcsl/JySrBerMRJjes
 tExwxFzHJ2TsmpYa5Umj5cMwhk/BulOl4No+sO0junKz3s9N+UVsxpYNqRd4IWEOmj24VA
 /0kK9uZ1RJfCjT8MyIKrtDOCGk9MVaM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-KvblWEbeN1ev7_SESNLLfw-1; Thu,
 19 Feb 2026 09:39:06 -0500
X-MC-Unique: KvblWEbeN1ev7_SESNLLfw-1
X-Mimecast-MFC-AGG-ID: KvblWEbeN1ev7_SESNLLfw_1771511945
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EDA418004A9; Thu, 19 Feb 2026 14:39:05 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 830F73000C26; Thu, 19 Feb 2026 14:39:02 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, hkalra@marvell.com,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH v4 2/3] eal/interrupt: add interrupt event info
Date: Thu, 19 Feb 2026 14:38:51 +0000
Message-ID: <20260219143852.200722-3-ktraynor@redhat.com>
In-Reply-To: <20260219143852.200722-1-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260219143852.200722-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5rgkat96EiQ-S5Rxe23LZiZGUaNKQww4c2rfdP_WNwk_1771511945
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Add RTE_INTR_EVENT_* defines and a new API rte_intr_active_events()
in order to retrieve them.

As the events are in the context of the current interrupt,
rte_intr_active_events() must be called from the context of
an interrupt callback.

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 lib/eal/freebsd/eal_interrupts.c |  7 +++++++
 lib/eal/include/rte_interrupts.h | 23 +++++++++++++++++++++++
 lib/eal/linux/eal_interrupts.c   | 31 ++++++++++++++++++++++++++++++-
 lib/eal/windows/eal_interrupts.c |  7 +++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/lib/eal/freebsd/eal_interrupts.c b/lib/eal/freebsd/eal_interrupts.c
index 5c3ab6699e..aa0bd50009 100644
--- a/lib/eal/freebsd/eal_interrupts.c
+++ b/lib/eal/freebsd/eal_interrupts.c
@@ -769,2 +769,9 @@ int rte_thread_is_intr(void)
 	return rte_thread_equal(intr_thread, rte_thread_self());
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_intr_active_events, 26.03)
+uint32_t
+rte_intr_active_events(void)
+{
+	return 0;
+}
diff --git a/lib/eal/include/rte_interrupts.h b/lib/eal/include/rte_interrupts.h
index 1b9a0b2a78..bff4f98f85 100644
--- a/lib/eal/include/rte_interrupts.h
+++ b/lib/eal/include/rte_interrupts.h
@@ -40,4 +40,10 @@ struct rte_intr_handle;
 #define RTE_INTR_VEC_RXTX_OFFSET      1
 
+/** Interrupt event flags returned by rte_intr_active_events() */
+#define RTE_INTR_EVENT_IN    (1 << 0)  /**< Data available to read */
+#define RTE_INTR_EVENT_ERR   (1 << 1)  /**< Error condition on fd */
+#define RTE_INTR_EVENT_HUP   (1 << 2)  /**< Hang up / disconnect */
+#define RTE_INTR_EVENT_RDHUP (1 << 3)  /**< Read Hang up / disconnect */
+
 /**
  * The interrupt source type, e.g. UIO, VFIO, ALARM etc.
@@ -197,4 +203,21 @@ int rte_intr_ack(const struct rte_intr_handle *intr_handle);
 int rte_thread_is_intr(void);
 
+/**
+ * Return the event flags for the interrupt currently being processed.
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Must be called from an interrupt callback running on the EAL
+ * interrupt thread. The returned value is a bitmask of
+ * RTE_INTR_EVENT_* flags.
+ *
+ * @return
+ *   Active event flags, or 0 if not in interrupt context or
+ *   on platforms that do not support this feature.
+ */
+__rte_experimental
+uint32_t rte_intr_active_events(void);
+
 /**
  * It allocates memory for interrupt instance. API takes flag as an argument
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index f3f6bdd01d..43493aa299 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -41,4 +41,6 @@
 static RTE_DEFINE_PER_LCORE(int, _epfd) = -1; /**< epoll fd per thread */
 
+static uint32_t active_events; /**< events for active interrupt */
+
 /**
  * union for pipe fds.
@@ -887,4 +889,20 @@ rte_intr_disable(const struct rte_intr_handle *intr_handle)
 }
 
+static uint32_t
+epoll_to_intr_events(uint32_t epoll_events)
+{
+	uint32_t ev = 0;
+
+	if (epoll_events & EPOLLIN)
+		ev |= RTE_INTR_EVENT_IN;
+	if (epoll_events & EPOLLERR)
+		ev |= RTE_INTR_EVENT_ERR;
+	if (epoll_events & EPOLLHUP)
+		ev |= RTE_INTR_EVENT_HUP;
+	if (epoll_events & EPOLLRDHUP)
+		ev |= RTE_INTR_EVENT_RDHUP;
+	return ev;
+}
+
 static void
 eal_intr_source_remove_and_free(struct rte_intr_source *src)
@@ -1014,5 +1032,5 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 
 		if (call) {
-
+			active_events = epoll_to_intr_events(events[n].events);
 			/* Finally, call all callbacks. */
 			TAILQ_FOREACH(cb, &src->callbacks, next) {
@@ -1028,4 +1046,5 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 				rte_spinlock_lock(&intr_lock);
 			}
+			active_events = 0;
 		}
 		/* we done with that interrupt source, release it. */
@@ -1642,2 +1661,12 @@ int rte_thread_is_intr(void)
 	return rte_thread_equal(intr_thread, rte_thread_self());
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_intr_active_events, 26.03)
+uint32_t
+rte_intr_active_events(void)
+{
+	if (rte_thread_is_intr())
+		return active_events;
+
+	return 0;
+}
diff --git a/lib/eal/windows/eal_interrupts.c b/lib/eal/windows/eal_interrupts.c
index 5ff30c7631..1c7700eca2 100644
--- a/lib/eal/windows/eal_interrupts.c
+++ b/lib/eal/windows/eal_interrupts.c
@@ -117,4 +117,11 @@ rte_thread_is_intr(void)
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_intr_active_events, 26.03)
+uint32_t
+rte_intr_active_events(void)
+{
+	return 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_rx_ctl)
 int
-- 
2.53.0

