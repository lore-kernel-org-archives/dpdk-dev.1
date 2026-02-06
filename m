Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E1EE20B9
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 17:21:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB74B4065B;
	Fri,  6 Feb 2026 18:21:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A56D34065E
 for <dev@dpdk.org>; Fri,  6 Feb 2026 18:21:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770398485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NDozeohpy45YoDj6paylC0LgFyVEmA75EQsOeohBGsI=;
 b=hAvofykOG1xzgi9mrX0u6JorRjz6kWi5afcoFkVDRGsp5SyFjp7WNObo1XiXhwq0JKq4KH
 FUD8b8QTWqmkIWNvy89a74BKGhWPtZHOzR1jQee+Zncwml6ifcVwHL4Cu2aoI9N6wm0ikc
 AxgCG3Xl5iJR/yhnjGxCzvVALXeLS6k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-WUBLxwhYMTGQMj1EsK78vg-1; Fri,
 06 Feb 2026 12:21:23 -0500
X-MC-Unique: WUBLxwhYMTGQMj1EsK78vg-1
X-Mimecast-MFC-AGG-ID: WUBLxwhYMTGQMj1EsK78vg_1770398482
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 901C6180034A; Fri,  6 Feb 2026 17:21:22 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F38F9180035A; Fri,  6 Feb 2026 17:21:19 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, Kevin Traynor <ktraynor@redhat.com>,
 stable@dpdk.org
Subject: [PATCH v2 2/2] eal/linux: handle interrupt epoll events
Date: Fri,  6 Feb 2026 17:20:54 +0000
Message-ID: <20260206172054.273858-3-ktraynor@redhat.com>
In-Reply-To: <20260206172054.273858-1-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260206172054.273858-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jxvsaOvazudDsOTq_r8-JYZKSsWuHdm6kbljJlrJ8I8_1770398482
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

Add handling for epoll error and disconnect conditions EPOLLERR,
EPOLLHUP and EPOLLRDHUP.

These events indicate that the interrupt file descriptor is in
an error state or there has been a hangup.

Only do this for interrupts that are read in eal. Interrupts that
are read outside eal should deal with different interrupt scenarios
appropriate to their functionality. e.g. virtio interrupt handling
has reconnect mechanisms for some cases.

Also, treat no bytes read as an error condition.

Bugzilla ID: 1873
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 lib/eal/linux/eal_interrupts.c | 67 ++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 9db978923a..68ca0f929e 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -887,4 +887,26 @@ rte_intr_disable(const struct rte_intr_handle *intr_handle)
 }
 
+static void
+eal_intr_source_remove_and_free(struct rte_intr_source *src)
+{
+	struct rte_intr_callback *cb, *next;
+
+	/* Remove the interrupt source */
+	rte_spinlock_lock(&intr_lock);
+	TAILQ_REMOVE(&intr_sources, src, next);
+	rte_spinlock_unlock(&intr_lock);
+
+	/* Free callbacks */
+	for (cb = TAILQ_FIRST(&src->callbacks); cb; cb = next) {
+		next = TAILQ_NEXT(cb, next);
+		TAILQ_REMOVE(&src->callbacks, cb, next);
+		free(cb);
+	}
+
+	/* Free the interrupt source */
+	rte_intr_instance_free(src->intr_handle);
+	free(src);
+}
+
 static int
 eal_intr_process_interrupts(struct epoll_event *events, int nfds)
@@ -952,4 +974,16 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 
 		if (bytes_read > 0) {
+			/**
+			 * Check for epoll error or disconnect events for
+			 * interrupts that are read directly in eal.
+			 */
+			if (events[n].events & (EPOLLERR | EPOLLHUP | EPOLLRDHUP)) {
+				EAL_LOG(INFO, "Disconnect condition on fd %d "
+					"(events=0x%x), removing from epoll",
+					events[n].data.fd, events[n].events);
+				eal_intr_source_remove_and_free(src);
+				return -1;
+			}
+
 			/**
 			 * read out to clear the ready-to-be-read flag
@@ -957,5 +991,7 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 			 */
 			bytes_read = read(events[n].data.fd, &buf, bytes_read);
-			if (bytes_read < 0) {
+			if (bytes_read > 0) {
+				call = true;
+			} else if (bytes_read < 0) {
 				if (errno == EINTR || errno == EWOULDBLOCK)
 					continue;
@@ -965,27 +1001,12 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 					events[n].data.fd,
 					strerror(errno));
-				/*
-				 * The device is unplugged or buggy, remove
-				 * it as an interrupt source and return to
-				 * force the wait list to be rebuilt.
-				 */
-				rte_spinlock_lock(&intr_lock);
-				TAILQ_REMOVE(&intr_sources, src, next);
-				rte_spinlock_unlock(&intr_lock);
-
-				for (cb = TAILQ_FIRST(&src->callbacks); cb;
-							cb = next) {
-					next = TAILQ_NEXT(cb, next);
-					TAILQ_REMOVE(&src->callbacks, cb, next);
-					free(cb);
-				}
-				rte_intr_instance_free(src->intr_handle);
-				free(src);
-				return -1;
-			} else if (bytes_read == 0)
-				EAL_LOG(ERR, "Read nothing from file "
+			} else { /* bytes == 0 */
+				EAL_LOG(WARNING, "Read nothing from file "
 					"descriptor %d", events[n].data.fd);
-			else
-				call = true;
+			}
+			if (bytes_read <= 0) {
+				eal_intr_source_remove_and_free(src);
+				return -1;
+			}
 		}
 
-- 
2.52.0

