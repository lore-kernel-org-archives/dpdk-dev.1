Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B35C79FB7
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:05:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C239642709;
	Wed,  9 Sep 2026 17:05:06 +0200 (CEST)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by mails.dpdk.org (Postfix) with ESMTP id A8EAA41148
 for <dev@dpdk.org>; Wed,  9 Sep 2026 17:05:05 +0200 (CEST)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so2021035e9.0
 for <dev@dpdk.org>; Wed, 09 Sep 2026 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788966305; x=1789571105; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=13qdHbs0W3zxICHJSsixlbQmuurtR1eFBycOYd+FAa0=;
 b=An3a2r8Vbgw8YDLYzOKxopOhE3cbyJECyffHMgziEof4PAUuhlPChIeF6vo4DfMr8h
 cwAW7zONNXMhCmtcdJdDcJFPP5mrTU1D3Ji7dkC5rb0NzouSllnyXlxU4/jzFYwJLGki
 AkFVpceW04zowFDK8Fp7fdyajPzyHIEYSOSjkkKolzZJOHDdqbDzpGV452GoyMhmrpYr
 rU8K5OMS4TzzwMESx/Vq6l3iE72WvDSRrNfbZWqoLLz01qJFzlQVHl/Kk9DFLBNrQhNq
 cp56oBqcgzrgmOjd2Z32KnBWDkY7cvYefOThtMOyGUelbgpUy/6x6UFENeuZbumg0aOF
 2J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788966305; x=1789571105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=13qdHbs0W3zxICHJSsixlbQmuurtR1eFBycOYd+FAa0=;
 b=qi4e8T1S66I/624H6LKyMhgARN8M6t9r9f7XwzdAF1yMmCpAYaiIRlsfEGGVcloyXJ
 097V02cstpwyoYICz4SaS+1Ukl8BtTpRjyPfS2gQp36eSy3ch/nwL+6nJ4mAeCRoVusJ
 4Xtg+cVf+Jdb0P4vHpmmw8/H8S6QvwB2bh1cGvcGEwG/LUf3b7k0Cj4m/4YB4sHHIhuQ
 vsUwTLLGNcGTEcqVGgIe4Rp9/1n99ytowvQN2PpvQJqBsLU32Bb07TgSh66gzt/KFFOn
 Jg70zUGS1nNJkhKNjfOp2vDn9Z41Xp6wPlNDSzgPbbWTHYHW0qbwBLf9/K+OHOuDvDPn
 PQxw==
X-Gm-Message-State: AFuF++lFf+Kfj0LesVB+Q4rYFYEAtqvCdYoPdHHwQUpLRM4gehHGQ4zN
 dSiJ6EiUCxi5llIXfJV8rh8/3+ThYBLX/ADqvpE7pE4rP5GgQ4pcpo+xVTnX4A==
X-Gm-Gg: AYBFou39j3Jk1EmCwQT3I1iTdiFSr6hBrS4Ug8rSPrVfMmQGyKc9eSkibxjCzPpy8ia
 2t/BDxvHjU97GiWG6Xi6JDNC/Id1kqS74HeWK0VjctglQ2UqK1SjmfO/XxxDinI7JIVScQqTWlU
 M8ss/ibzn7S27bjyHnUhS3jBAQZwW773kJXYlc8wVG42g3oaK9wTkxcYMbeq1NdlbXxuxkxYSHE
 gIjSSczjUP/hsvSyTSa76PDsUIZo8qZPzzP38YCnR0ENB+1UpOXI2s/m9hGqrneU3D5L5hv/Dsh
 2/np1yf6DujvZLc4AIXZ+fA8qEYJ9vn4c4OVrWDeDr9WvC8dRCx45y8HSMSoI49G1Nru4TvEab9
 j1YmH0SwQwp8YJHFw5fPAI55hb9igmoQIQNh2bV+lMZ4EvPZKjKkGNl4VKdWy0B4q6J6RIp4B5L
 ZUexUmoIJ6fqXxikSfO8cypGT1AnDzPrb9nEa+crAG7gEdSYytppI8QnZtfPICLdqSFfBUCNqMu
 O5965JodRZD1FFwQqEh22oxlh+e/CLFeHu5OFeIhG8OzlvM/Ue0jfxYz5w/
X-Received: by 2002:a05:600c:310f:b0:499:b65d:124f with SMTP id
 5b1f17b1804b1-49d258d85b5mr16573565e9.11.1788966304873; 
 Wed, 09 Sep 2026 08:05:04 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm662325845e9.13.2026.09.09.08.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:05:04 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, anatoly.burakov@intel.com,
 sivaprasad.tummala@amd.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 6/6] examples/l3fwd-power: block until Rx interrupt or exit
Date: Wed,  9 Sep 2026 17:04:49 +0200
Message-ID: <20260909150449.856295-7-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909150449.856295-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
 <20260909150449.856295-1-maxime@leroys.fr>
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
index c1ecf118f5..5ee8e5217e 100644
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
 
@@ -421,10 +426,17 @@ static int is_done(void)
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
@@ -836,7 +848,7 @@ sleep_until_rx_interrupt(int num, int lcore)
 	static alignas(RTE_CACHE_LINE_SIZE) struct {
 		bool wakeup;
 	} status[RTE_MAX_LCORE];
-	struct rte_epoll_event event[num];
+	struct rte_epoll_event event[num + 1];
 	int n, i;
 	uint16_t port_id;
 	uint16_t queue_id;
@@ -848,8 +860,10 @@ sleep_until_rx_interrupt(int num, int lcore)
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
@@ -922,6 +936,7 @@ rx_intr_enable_all(struct lcore_conf *qconf)
 static int event_register(struct lcore_conf *qconf)
 {
 	struct lcore_rx_queue *rx_queue;
+	struct rte_epoll_event *wev;
 	uint16_t queueid;
 	uint16_t portid;
 	uint32_t data;
@@ -947,6 +962,16 @@ static int event_register(struct lcore_conf *qconf)
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
 
@@ -2992,6 +3017,13 @@ main(int argc, char **argv)
 
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

