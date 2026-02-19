Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A35E9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 14:39:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 979834042F;
	Thu, 19 Feb 2026 15:39:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2F46A402F2
 for <dev@dpdk.org>; Thu, 19 Feb 2026 15:39:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771511946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdy8wAxDJk85W4aPv0Zsi7ATTvZ/06FSZ6l6vR8AJv4=;
 b=P8VOFzwbavjOBC9u3nuyNUyuWjuSLSqfOpVYAyBDIXtnhQ2HSFFMGHP65Mq+fF38XIBeYH
 71BHVDPBHP8+0itWwAxMJrK9/w5s4UhbT5W+dNMjiykmZf85vZpCT/r0LQ6lQ5oGY1lOTi
 biHda0ivFHVyh7Rgts30mLYbBS3RkJo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-hCr0frGYOJGEO0hsg88ZYg-1; Thu,
 19 Feb 2026 09:39:03 -0500
X-MC-Unique: hCr0frGYOJGEO0hsg88ZYg-1
X-Mimecast-MFC-AGG-ID: hCr0frGYOJGEO0hsg88ZYg_1771511942
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 026141956073; Thu, 19 Feb 2026 14:39:02 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1571E3000C26; Thu, 19 Feb 2026 14:38:58 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, hkalra@marvell.com,
 Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Subject: [PATCH v4 1/3] eal/linux: handle interrupt epoll events
Date: Thu, 19 Feb 2026 14:38:50 +0000
Message-ID: <20260219143852.200722-2-ktraynor@redhat.com>
In-Reply-To: <20260219143852.200722-1-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260219143852.200722-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7VjkynVbEAalrpaMb8d0IG7_9ciVc2VfRz90Xrk2Iuw_1771511942
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
are read outside eal should deal with disconnect/error events
appropriate to their functionality. e.g. virtio interrupt handling
has reconnect mechanisms for some cases.

Also, treat no bytes read as an error condition.

Bugzilla ID: 1873
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_interrupts.c | 72 ++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 9db978923a..f3f6bdd01d 100644
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
@@ -952,40 +974,38 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 
 		if (bytes_read > 0) {
-			/**
+			/*
+			 * Check for epoll error or disconnect events for
+			 * interrupts that are read directly in eal.
+			 */
+			if (events[n].events & (EPOLLERR | EPOLLHUP | EPOLLRDHUP)) {
+				EAL_LOG(ERR, "Disconnect condition on fd %d "
+					"(events=0x%x), removing from epoll",
+					events[n].data.fd, events[n].events);
+				eal_intr_source_remove_and_free(src);
+				return -1;
+			}
+
+			/*
 			 * read out to clear the ready-to-be-read flag
 			 * for epoll_wait.
 			 */
 			bytes_read = read(events[n].data.fd, &buf, bytes_read);
-			if (bytes_read < 0) {
+			if (bytes_read > 0) {
+				call = true;
+			} else if (bytes_read < 0) {
 				if (errno == EINTR || errno == EWOULDBLOCK)
 					continue;
 
-				EAL_LOG(ERR, "Error reading from file "
-					"descriptor %d: %s",
+				EAL_LOG(ERR, "Error reading from file descriptor %d: %s",
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
+			} else {
+				EAL_LOG(ERR, "Read nothing from file descriptor %d",
+					events[n].data.fd);
+			}
+			if (bytes_read <= 0) {
+				eal_intr_source_remove_and_free(src);
 				return -1;
-			} else if (bytes_read == 0)
-				EAL_LOG(ERR, "Read nothing from file "
-					"descriptor %d", events[n].data.fd);
-			else
-				call = true;
+			}
 		}
 
-- 
2.53.0

