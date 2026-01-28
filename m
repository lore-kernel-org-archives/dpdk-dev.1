Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA11D25B4C
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 12:21:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A73B040274;
	Wed, 28 Jan 2026 13:21:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BCEE2400D7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:21:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769602903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8eavl4Dkp9edTp43Y4Ol7aJxTYvANmjAN+IvQjAbuKo=;
 b=UJiH1lOUJSm+9wbyUWBwPFbVuoRnfovJAfILJ9APGLrxepQ0pack0zzOC5u3Zo9Kmy1mMd
 hihA2jHPnhjG6QdYCKP+HMi2ZumqFitjWAomEnqDtNryIcL2k3daSANFwS5eMtL6DCBDX0
 TX0hf5oKzYZxG8AOnMvX5+MLnJNNz24=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-zEO1BcQxM2eA05YbctCbBQ-1; Wed,
 28 Jan 2026 07:21:39 -0500
X-MC-Unique: zEO1BcQxM2eA05YbctCbBQ-1
X-Mimecast-MFC-AGG-ID: zEO1BcQxM2eA05YbctCbBQ_1769602898
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AABC180045C; Wed, 28 Jan 2026 12:21:38 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.226.123])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FECA1956095; Wed, 28 Jan 2026 12:21:35 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, Kevin Traynor <ktraynor@redhat.com>,
 stable@dpdk.org
Subject: [PATCH] eal/linux: handle epoll error conditions
Date: Wed, 28 Jan 2026 12:20:55 +0000
Message-ID: <20260128122055.192104-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M0Mg3XGZyP94az4fhMeSxZTsgZkob7_ndOSdzpL20C0_1769602898
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

Add handling for epoll error conditions EPOLLERR, EPOLLHUP and
EPOLLRDHUP. These events indicate that the interrupt file descriptor
is in an error state or there has been a hangup.

This may happen when the interrupt file descriptor is deleted or for
mlx5 devices when the device is unbound from mlx5 kernel driver or if
the device is removed by the mlx5 kernel driver as part of LAG setup.

Previously, the interrupts were being read, but the condition was not
cleared and that may lead to an interrupt continuing to fire and a
busy-loop processing it.

Now when this condition is detected, an error message is logged and the
interrupt is removed to prevent busy-looping.

Also cover the case where no bytes are read even though the epoll has
indicated there is something to read.

Bugzilla ID: 1873
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 lib/eal/linux/eal_interrupts.c | 63 ++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 9db978923a..eedc75d776 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -887,4 +887,21 @@ rte_intr_disable(const struct rte_intr_handle *intr_handle)
 }
 
+static void
+eal_intr_source_free(struct rte_intr_source *src)
+{
+	struct rte_intr_callback *cb, *next;
+
+	/* Free all callbacks */
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
@@ -918,4 +935,21 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 		}
 
+		/* Check for error conditions on the fd before processing. */
+		if (events[n].events & (EPOLLRDHUP | EPOLLERR | EPOLLHUP)) {
+			EAL_LOG(WARNING, "Disconnect condition on fd %d "
+				"(events=0x%x), removing from epoll",
+				events[n].data.fd, events[n].events);
+			/*
+			 * There is an error or a hangup. Remove the
+			 * interrupt source and return to force the wait list
+			 * to be rebuilt.
+			 */
+			TAILQ_REMOVE(&intr_sources, src, next);
+			rte_spinlock_unlock(&intr_lock);
+
+			eal_intr_source_free(src);
+			return -1;
+		}
+
 		/* mark this interrupt source as active and release the lock. */
 		src->active = 1;
@@ -957,5 +991,7 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 			 */
 			bytes_read = read(events[n].data.fd, &buf, bytes_read);
-			if (bytes_read < 0) {
+			if (bytes_read > 0) {
+				call = true;
+			} else if (bytes_read < 0) {
 				if (errno == EINTR || errno == EWOULDBLOCK)
 					continue;
@@ -965,27 +1001,16 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 					events[n].data.fd,
 					strerror(errno));
-				/*
-				 * The device is unplugged or buggy, remove
-				 * it as an interrupt source and return to
-				 * force the wait list to be rebuilt.
-				 */
+			} else { /* bytes == 0 */
+				EAL_LOG(WARNING, "Read nothing from file "
+					"descriptor %d", events[n].data.fd);
+			}
+			if (bytes_read <= 0) {
 				rte_spinlock_lock(&intr_lock);
 				TAILQ_REMOVE(&intr_sources, src, next);
 				rte_spinlock_unlock(&intr_lock);
 
-				for (cb = TAILQ_FIRST(&src->callbacks); cb;
-							cb = next) {
-					next = TAILQ_NEXT(cb, next);
-					TAILQ_REMOVE(&src->callbacks, cb, next);
-					free(cb);
-				}
-				rte_intr_instance_free(src->intr_handle);
-				free(src);
+				eal_intr_source_free(src);
 				return -1;
-			} else if (bytes_read == 0)
-				EAL_LOG(ERR, "Read nothing from file "
-					"descriptor %d", events[n].data.fd);
-			else
-				call = true;
+			}
 		}
 
-- 
2.52.0

