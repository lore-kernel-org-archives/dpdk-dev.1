Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF51606A329
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G0DMha48
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52044410E6;
	Tue,  3 Nov 2026 12:59:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 476CD410E6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 12:59:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793707152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mvaRjz9/BCMABEArTFCqafHAmmhjFzCtyE9VkMeCG+k=;
 b=G0DMha48D5EOMbciOFKlCWbQFMFq35Spq2GJjMyFY4Dj/uyM4ThTJ8k7Gmlex0OjTK7RaV
 irkeQhBIrNBw/bRm1UlWJCqoy3XN1NH9o87mhJqseUZPP+frc1tXNjiAC3cxtDNUFpBymO
 jpFgtP7px5peiguRIGu/thXJ9IwVYc4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-E6JWwKmwPL-0zgGl-6kOhA-1; Tue,
 03 Nov 2026 06:59:07 -0500
X-MC-Unique: E6JWwKmwPL-0zgGl-6kOhA-1
X-Mimecast-MFC-AGG-ID: E6JWwKmwPL-0zgGl-6kOhA_1793707146
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 764031955DCF; Tue,  3 Nov 2026 11:59:06 +0000 (UTC)
Received: from ringo.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6ABCB30001A4; Tue,  3 Nov 2026 11:59:04 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH dpdk] eal: do not dispatch newly registered callbacks
Date: Tue,  3 Nov 2026 12:58:44 +0100
Message-ID: <20261103115842.1558342-3-rjarry@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JSg_3yupdeZxDMRIKzz7IuY0bKcZl0pIjKL8mtsIa0M_1793707146
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A callback may register another callback for the same interrupt handle
while it runs. This is what net/tap does when a tap interface moves to
another netns: the LSC callback unregisters itself (pending) and
registers again after the handle points to a netlink socket of the new
namespace.

Since the interrupt source lookup is now handle pointer based, the new
callback is appended to the source being dispatched. The callback loop
then invokes it in the same pass with the event reported for the old FD.
net/tap reads the new netlink FD, which has no pending data, and blocks
forever in recv(). The interrupt source stays active and any later
unregister retries on -EAGAIN indefinitely.

Only invoke callbacks which were registered before the event was
dispatched.

Fixes: c663018eb7f3 ("interrupts: do not duplicate interrupt handles")

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/eal/freebsd/eal_interrupts.c | 16 +++++++++++++++-
 lib/eal/linux/eal_interrupts.c   | 16 +++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/lib/eal/freebsd/eal_interrupts.c b/lib/eal/freebsd/eal_interrupts.c
index b29a2b174e10..f6eec2208875 100644
--- a/lib/eal/freebsd/eal_interrupts.c
+++ b/lib/eal/freebsd/eal_interrupts.c
@@ -529,8 +529,19 @@ eal_intr_process_interrupts(struct kevent *events, int nfds)
 		rte_spinlock_lock(&intr_lock);
 
 		if (call) {
+			struct rte_intr_callback *last;
+
+			/*
+			 * Only invoke the callbacks which were registered before
+			 * this event was dispatched. A callback may register a
+			 * new one (e.g. net/tap re-arming its LSC interrupt on
+			 * netns change, possibly on a different FD). It must not
+			 * receive the current event.
+			 */
+			last = TAILQ_LAST(&src->callbacks, rte_intr_cb_list);
 			/* Finally, call all callbacks. */
-			TAILQ_FOREACH(cb, &src->callbacks, next) {
+			for (cb = TAILQ_FIRST(&src->callbacks); cb != NULL; cb = next) {
+				next = TAILQ_NEXT(cb, next);
 
 				/* make a copy and unlock. */
 				active_cb = *cb;
@@ -541,6 +552,9 @@ eal_intr_process_interrupts(struct kevent *events, int nfds)
 
 				/*get the lock back. */
 				rte_spinlock_lock(&intr_lock);
+
+				if (cb == last)
+					break;
 			}
 		}
 
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index dfe1660dd016..1572e4b29df4 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -1019,9 +1019,20 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 		rte_spinlock_lock(&intr_lock);
 
 		if (call) {
+			struct rte_intr_callback *last;
+
+			/*
+			 * Only invoke the callbacks which were registered before
+			 * this event was dispatched. A callback may register a
+			 * new one (e.g. net/tap re-arming its LSC interrupt on
+			 * netns change, possibly on a different FD). It must not
+			 * receive the current event.
+			 */
+			last = TAILQ_LAST(&src->callbacks, rte_intr_cb_list);
 			active_events = epoll_to_intr_events(events[n].events);
 			/* Finally, call all callbacks. */
-			TAILQ_FOREACH(cb, &src->callbacks, next) {
+			for (cb = TAILQ_FIRST(&src->callbacks); cb != NULL; cb = next) {
+				next = TAILQ_NEXT(cb, next);
 
 				/* make a copy and unlock. */
 				active_cb = *cb;
@@ -1032,6 +1043,9 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 
 				/*get the lock back. */
 				rte_spinlock_lock(&intr_lock);
+
+				if (cb == last)
+					break;
 			}
 			active_events = 0;
 		}
-- 
2.56.0

