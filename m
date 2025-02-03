Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CBC02190
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:07:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41AC740A4B;
	Mon,  3 Feb 2025 05:06:56 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C28DE40696
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:06:47 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 153A72037181; Sun,  2 Feb 2025 20:06:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 153A72037181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738555607;
 bh=2fmXqIY7d9DD5WHHGxmMWwbKO6+hmuFgIZsUSG4mry0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y07Wmwsl9x9g/L7xuN+anH2GWCNLIR3QnIf4rdiwpwqK1vH8aBKXyktGZNIttxppF
 6Agx8sffeb9Q3NtrqVDrO35PcKLtB3V6T4JP6/J6Ey5ARqUTxMneOyyVYwcx5oYqAB
 ybvegbfqIhyRxFcMRPDAraXL6WS9fwivhrPcm+Ok=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com
Subject: [PATCH v19 02/27] eal/linux: remove use of VLAs
Date: Sun,  2 Feb 2025 20:06:05 -0800
Message-Id: <1738555590-12753-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
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

From: Konstantin Ananyev <konstantin.ananyev@huawei.com>

1) ./lib/eal/linux/eal_interrupts.c:1073:16
    : warning: ISO C90 forbids variable length array 'events'

MSVC does not support VLAs. Use alloca() to allocate the memory on
the stack.

2) ./lib/eal/linux/eal_interrupts.c:1319:16
    : warning: ISO C90 forbids variable length array 'evs'

make eal_epoll_wait() use a fixed size array and use it though multiple
iterations to process up to @maxevents events.
Note that technically it is not one to one replacement, as here we might
reduce number of events returned by first call to epoll_wait(..., timeout);

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/eal/linux/eal_interrupts.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 6436f796eb..23039964fc 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -34,6 +34,8 @@
 #define EAL_INTR_EPOLL_WAIT_FOREVER (-1)
 #define NB_OTHER_INTR               1
 
+#define MAX_ITER_EVNUM	RTE_EVENT_ETH_INTR_RING_SIZE
+
 static RTE_DEFINE_PER_LCORE(int, _epfd) = -1; /**< epoll fd per thread */
 
 /**
@@ -1070,7 +1072,7 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 static void
 eal_intr_handle_interrupts(int pfd, unsigned totalfds)
 {
-	struct epoll_event events[totalfds];
+	struct epoll_event *events = alloca(sizeof(struct epoll_event) * totalfds);
 	int nfds = 0;
 
 	for(;;) {
@@ -1316,8 +1318,9 @@ static int
 eal_epoll_wait(int epfd, struct rte_epoll_event *events,
 	       int maxevents, int timeout, bool interruptible)
 {
-	struct epoll_event evs[maxevents];
 	int rc;
+	uint32_t i, k, n, num;
+	struct epoll_event evs[MAX_ITER_EVNUM];
 
 	if (!events) {
 		EAL_LOG(ERR, "rte_epoll_event can't be NULL");
@@ -1328,12 +1331,31 @@ eal_epoll_wait(int epfd, struct rte_epoll_event *events,
 	if (epfd == RTE_EPOLL_PER_THREAD)
 		epfd = rte_intr_tls_epfd();
 
+	num = maxevents;
+	n = RTE_MIN(RTE_DIM(evs), num);
+
+	/* Process events in chunks of MAX_ITER_EVNUM */
+
 	while (1) {
-		rc = epoll_wait(epfd, evs, maxevents, timeout);
+		rc = epoll_wait(epfd, evs, n, timeout);
 		if (likely(rc > 0)) {
+
 			/* epoll_wait has at least one fd ready to read */
-			rc = eal_epoll_process_event(evs, rc, events);
-			break;
+			for (i = 0, k = 0; rc > 0;) {
+				k += rc;
+				rc = eal_epoll_process_event(evs, rc,
+						events + i);
+				i += rc;
+
+				/*
+				 * try to read more events that are already
+				 * available (up to maxevents in total).
+				 */
+				n = RTE_MIN(RTE_DIM(evs), num - k);
+				rc = (n == 0) ? 0 : epoll_wait(epfd, evs, n, 0);
+			}
+			return i;
+
 		} else if (rc < 0) {
 			if (errno == EINTR) {
 				if (interruptible)
-- 
2.47.2.vfs.0.1

