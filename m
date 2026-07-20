Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB28C4451B
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 08:01:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25A044068E;
	Mon, 20 Jul 2026 10:01:10 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 6309C40689
 for <dev@dpdk.org>; Mon, 20 Jul 2026 10:01:09 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so14564915e9.1
 for <dev@dpdk.org>; Mon, 20 Jul 2026 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784534469; x=1785139269; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r5lSWGRZ6m0KqHLFn8xjA7ltEnPKMmPP75ZHIU7noFE=;
 b=SyuivdN3cBgNkLOrp31NLIfn905k+wFna1V0azYtgGzWlOfOm+CRzRi20ogrJXoAv1
 DxtdXVdV1k/b9e4T9OIy88h4CAVjl7llrX0BKhhMg4i7iZIOWPSb+VIxyoCKPAgqcICe
 GA31BPWEd8poV5lFCLW5gU3wX0r6CIN+tAPvYU2I+OtW+9MTP9M7s1dm3N9eWjo0mOLw
 Hf5qi6U0/VLtlH7vYhyZc2y+1Sl6AI19wtYTrZuIr41XcxPNCtFWEsPIlwXue0XhBK6C
 /wshQGsVrH1CZI/2A+l/8rvrLgz23ixvJUadsb5SkYOCuYWTmFNF+B3OSSvttlrd2yxm
 KjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534469; x=1785139269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r5lSWGRZ6m0KqHLFn8xjA7ltEnPKMmPP75ZHIU7noFE=;
 b=iiIbgDp2HkUGw/tXDHhWJPDGFLipxVF5ZTQ+GaniBvwfZHBF7CsX4vrVmI6QSVFW/f
 /sEHAlHP7pvsFerXXae7DE/zXGFojcAGqjTDhJZiW0sWLDi78WPe2bXbpIg2R7EINM15
 xvJBz4t+bQxR6yA+75BEZH+Qexjsvh3Lkq+rkYdc7pt/I3c+PDbOfkhU72okDKrdibJm
 7amUH3cFGXdcMsXfBxSTQpAz3OQkU7JOsHRujUg/hzJmlqoeeMhrz9J+xeqG2cd42SAh
 ROltBrSCW/ESIN00VkhF0dZKsZIf+5E6Vw0474BAr9YSdi5iwMl7QXEgg/QuZHZ/q/Wr
 W7cQ==
X-Gm-Message-State: AOJu0Ywr9Xr8269I7iv1H1/toFE+NWGfBsDsQErSfZNkxHVJDjBCuXyF
 xTZ9rltcR/NrRWg6xGMw5PcDilPofiZCB+EzbeefL0Vm+nHPTWh+nBLHr2OC6A==
X-Gm-Gg: AfdE7ckCsb24HJlfLWjMIC8s8djsgaML0amES9rOpgLbXm3wBSITrURkyCmcNa7S7Ni
 kZP9fqJpPxMXE1COVn5lW9A58Hn4HyDr2F4M0LZQkPa4F7e00g3ev+VjDT1CDDwY74sUF77yWrO
 ck3gWwegwyZ8vl21qKlNTwLJTFACEFafHnUhN0qDF8DZTMujU9G8L891iyUhSBxKPeIMWMLnvhR
 +mW8mC7hsp8qu+MA07AGrUr+jir+VzWktkM4H8OiOdMVzPFJfLEh7XxmKQ7fFcUliDj3vg1vb/c
 7EYXMIsD5U9neKbLbgfhJCtK/fH+O26Nicg5EzkHpyx7Njt026VxS3I3NBbvOUYoz03tUQHg9Yn
 N2OZajFmCnv3VULktZdFCXau09/UhhdRfxPPFbuj25xp9Y2VhVwcuM/ds7T4xowD9drAZijjuH1
 cB1sIEKH4wn8HMu/c6v1K9Haz+guXCmrIwbrH45DJy
X-Received: by 2002:a05:600c:6287:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-4954a3f3927mr139604105e9.13.1784534468438; 
 Mon, 20 Jul 2026 01:01:08 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49558cb8433sm73333775e9.2.2026.07.20.01.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:01:07 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 6/6] examples/l3fwd-power: block until Rx interrupt or exit
Date: Mon, 20 Jul 2026 10:00:35 +0200
Message-ID: <20260720080035.673782-7-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720080035.673782-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In interrupt and legacy modes an idle worker arms its Rx queues and
sleeps in rte_epoll_wait() with a 10 ms timeout. The timeout lets the
worker wake periodically to re-check the quit flag, but it also hides a
broken interrupt path: with no interrupt delivered the worker still wakes
every 10 ms and polls, so traffic keeps flowing and interrupt mode looks
like it works when it does not.

Block indefinitely instead, so only a real Rx interrupt can wake the
worker. To still stop the workers on SIGINT, add an eventfd to each
worker epoll set; the signal handler writes it to wake every worker,
which then observes the quit flag and leaves its loop. Both loops share
this sleep path, so the eventfd is created for the interrupt and legacy
modes; it is skipped in the wakeup log so it is not reported as an Rx
interrupt.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 examples/l3fwd-power/main.c | 40 +++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index c423b0dba5..73ee2d2def 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -9,6 +9,8 @@
 #include <sys/types.h>
 #include <string.h>
 #include <sys/queue.h>
+#include <sys/epoll.h>
+#include <sys/eventfd.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
@@ -143,6 +145,9 @@ static int promiscuous_on = 0;
 /* NUMA is enabled by default. */
 static int numa_on = 1;
 volatile bool quit_signal;
+/* eventfd to wake idle workers out of a blocking rte_epoll_wait() at exit */
+static int wakeup_fd = -1;
+static struct rte_epoll_event wakeup_event[RTE_MAX_LCORE];
 /* timer to update telemetry every 500ms */
 static struct rte_timer telemetry_timer;
 
@@ -420,10 +425,17 @@ static int is_done(void)
 static void
 signal_exit_now(int sigtype)
 {
+	uint64_t one = 1;
+	ssize_t nbytes;
 
-	if (sigtype == SIGINT)
+	if (sigtype == SIGINT) {
 		quit_signal = true;
-
+		/* interrupt mode only: wake a worker blocked in rte_epoll_wait() */
+		if (wakeup_fd >= 0) {
+			nbytes = write(wakeup_fd, &one, sizeof(one));
+			RTE_SET_USED(nbytes);
+		}
+	}
 }
 
 /*  Frequency scale down timer callback */
@@ -835,7 +847,7 @@ sleep_until_rx_interrupt(int num, int lcore)
 	static alignas(RTE_CACHE_LINE_SIZE) struct {
 		bool wakeup;
 	} status[RTE_MAX_LCORE];
-	struct rte_epoll_event event[num];
+	struct rte_epoll_event event[num + 1];
 	int n, i;
 	uint16_t port_id;
 	uint16_t queue_id;
@@ -847,8 +859,10 @@ sleep_until_rx_interrupt(int num, int lcore)
 				rte_lcore_id());
 	}
 
-	n = rte_epoll_wait(RTE_EPOLL_PER_THREAD, event, num, 10);
+	n = rte_epoll_wait(RTE_EPOLL_PER_THREAD, event, num + 1, -1);
 	for (i = 0; i < n; i++) {
+		if (event[i].fd == wakeup_fd)
+			continue;
 		data = event[i].epdata.data;
 		port_id = ((uintptr_t)data) >> (sizeof(uint16_t) * CHAR_BIT);
 		queue_id = ((uintptr_t)data) &
@@ -921,6 +935,7 @@ rx_intr_enable_all(struct lcore_conf *qconf)
 static int event_register(struct lcore_conf *qconf)
 {
 	struct lcore_rx_queue *rx_queue;
+	struct rte_epoll_event *wev;
 	uint16_t queueid;
 	uint16_t portid;
 	uint32_t data;
@@ -946,6 +961,16 @@ static int event_register(struct lcore_conf *qconf)
 			return ret;
 	}
 
+	/* also watch the shutdown eventfd so a blocking wait wakes at exit */
+	if (wakeup_fd >= 0) {
+		wev = &wakeup_event[rte_lcore_id()];
+		wev->epdata.event = EPOLLIN | EPOLLPRI;
+		ret = rte_epoll_ctl(RTE_EPOLL_PER_THREAD, EPOLL_CTL_ADD,
+				    wakeup_fd, wev);
+		if (ret && ret != -EEXIST)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -2989,6 +3014,13 @@ main(int argc, char **argv)
 
 	check_all_ports_link_status(enabled_port_mask);
 
+	if (app_mode == APP_MODE_LEGACY || app_mode == APP_MODE_INTERRUPT) {
+		wakeup_fd = eventfd(0, EFD_NONBLOCK);
+		if (wakeup_fd < 0)
+			rte_exit(EXIT_FAILURE, "eventfd() failed: %s\n",
+				 strerror(errno));
+	}
+
 	/* launch per-lcore init on every lcore */
 	if (app_mode == APP_MODE_LEGACY) {
 		rte_eal_mp_remote_launch(main_legacy_loop, NULL, CALL_MAIN);
-- 
2.43.0

