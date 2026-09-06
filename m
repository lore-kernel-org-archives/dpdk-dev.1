Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E710BC79F9E
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:27:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 078414064F;
	Mon,  7 Sep 2026 01:27:36 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5911F40609
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:27:35 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d5335cf904so28560795ad.2
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737254;
 x=1789342054; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bn6FBKy/Ijtv5GJdNZS8iFYIbVjP9rVqOv75VjGO5gI=;
 b=Re5/YpnmWZfU5zewyTdTOMMhYO7o1BO3PvV0Ymt+KTvpPbY9xNZvFq/i4V4Edt8yEg
 Zhs1JTQctA/HODXLg9xp2zb4DxkVhyZw6t3b7VAnT/rai3gakyTQzLdx3dQgwBpMhzeh
 QyTRchNnLXhYqzzMn5BuSrbW7vmNwjakN6DMjblmEryH1pUcf7ZuOA1fqMOsxw97FJwT
 7IPe0ECbl8VLvylFXfW73AU9/Ubtypwl9lJel5c6NfibFAid0BJGwoiTkODQ7ZjySJi/
 1dfL8q7xurABiO5lSqIWvJ/ttrFLXVwZJz5UNv6j4lU28K0sg0XoLer8xtvpfW2Nt8lS
 hqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737254; x=1789342054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bn6FBKy/Ijtv5GJdNZS8iFYIbVjP9rVqOv75VjGO5gI=;
 b=eUTiYnfENjs6vixyjBgB/XYM2MwY+mF4byMb6cnD+BGW/xlLM4D3B91mxCvIrR6DhH
 9/tvHrffYu75za+oejePs5sKMVmoSkaeSI1+MJosQbxYeuIVIJgBV8lVqr6qfBdzQWRm
 SsKLoLmTwHfCzKdwA0K0ojZoE5Xh4E9GtiXpsv/psRoAVHkWOMM+FiCqH6HoYdUNvoYp
 L0wlO2bCnOygLbSRO4N7wBr7Soxj09Z/OXEwZWcEMmTba6KlLgsWWG0kMDq89EZChZGY
 nwvuYcYS6S9euDrAAoMHIXJe47IqKZa2TcBv7dwAO/z48rKjUMr50L4TtBZhEeTXsI+3
 fuHg==
X-Gm-Message-State: AFuF++mwNOCIaRGKzoioRwVkO9sUUeAynYlTbnZWiE9oaWOBrEwE+yDj
 Zw3lK4j162ZlowQopQqsLdc5CNXZQWt/DkkP5C7X+HnVgDJnwd6RKvff9HSMqOvWrLkuYtBjJwN
 BAuWq
X-Gm-Gg: AYBFou2j2FoxKlXbSwkKBKeAMvOMDfTR4uToQnhxGGVQx4T/z6kegaLQA7tcDPxwmXm
 gY18h760v6+1hc4N63CR5kKpaEWDjQUsJqQCF/IyZTQqLOBtsbH+avujamwDa2W5E3DHLiN3dRe
 2Hb19OJXqarQFupu+92I8KL0QhOSMgfwRFloR6FA62aaXzXlj/kQbsoyDvZPEd5GWnDH+/OsNaG
 SB+MY9SP61ou/M9ei/Uz/caHMANF4NSodddiUmy/rszkxZ9qHzVqSBClruZRE3L1Wv3FNqDi+AM
 lMQ117t409QUwasG5Lr5PHnqsvnwQlbqx6XV4y3VuBcOd62XNlzivv1ZyBkZI/9u2dXkmPeWFYa
 43JCgg6HIIfmem9ooJTW3j4iQkOvNpeqj4VfhCyv3Qi+MptYKfgXaO1TSj/QT5m+NKvFWteGhQT
 /82GIJGzf+5nTauFD+PrDUnKrRFjS+MkiLWR1fBrGkEBe4tE7DkHUiLxbvFHuwLxEp6I49LL7T9
 gkoLD+vA9+tOHMlmtiLdQOXjAtVKDKOCF+R9w==
X-Received: by 2002:a17:90b:586c:b0:398:a2ed:7b5c with SMTP id
 98e67ed59e1d1-39b2623ef65mr33761009a91.24.1788737254455; 
 Sun, 06 Sep 2026 16:27:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:27:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Ori Kam <orika@nvidia.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH 02/13] examples: remove printf from signal handler
Date: Sun,  6 Sep 2026 16:24:37 -0700
Message-ID: <20260906232716.496546-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906232716.496546-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
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

Printf is not a signal safe function, remove useless printf's
that cause warnings in GCC analyzer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/distributor/main.c       | 3 +--
 examples/dma/dmafwd.c             | 2 --
 examples/eventdev_pipeline/main.c | 2 --
 examples/flow_filtering/main.c    | 5 +----
 examples/l2fwd-event/main.c       | 5 +----
 examples/l2fwd/main.c             | 5 +----
 examples/l3fwd-graph/main.c       | 5 +----
 7 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/examples/distributor/main.c b/examples/distributor/main.c
index ea44939fba..0905482cf0 100644
--- a/examples/distributor/main.c
+++ b/examples/distributor/main.c
@@ -529,9 +529,8 @@ lcore_tx(struct rte_ring *in_r)
 }
 
 static void
-int_handler(int sig_num)
+int_handler(int sig_num __rte_unused)
 {
-	printf("Exiting on signal %d\n", sig_num);
 	/* set quit flag for rx thread to exit */
 	quit_signal_rx = 1;
 }
diff --git a/examples/dma/dmafwd.c b/examples/dma/dmafwd.c
index a8ed09e6ae..8d195faddb 100644
--- a/examples/dma/dmafwd.c
+++ b/examples/dma/dmafwd.c
@@ -998,8 +998,6 @@ static void
 signal_handler(int signum)
 {
 	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\n\nSignal %d received, preparing to exit...\n",
-			signum);
 		force_quit = true;
 	} else if (signum == SIGUSR1) {
 		dmadev_dump();
diff --git a/examples/eventdev_pipeline/main.c b/examples/eventdev_pipeline/main.c
index 0c995d1a70..65e0cd437c 100644
--- a/examples/eventdev_pipeline/main.c
+++ b/examples/eventdev_pipeline/main.c
@@ -319,8 +319,6 @@ signal_handler(int signum)
 	if (fdata->done)
 		rte_exit(1, "Exiting on signal %d\n", signum);
 	if ((signum == SIGINT || signum == SIGTERM) && !once) {
-		printf("\n\nSignal %d received, preparing to exit...\n",
-				signum);
 		if (cdata.dump_dev)
 			rte_event_dev_dump(0, stdout);
 		once = 1;
diff --git a/examples/flow_filtering/main.c b/examples/flow_filtering/main.c
index f2124881a0..b4ccaacea1 100644
--- a/examples/flow_filtering/main.c
+++ b/examples/flow_filtering/main.c
@@ -266,11 +266,8 @@ init_port(void)
 static void
 signal_handler(int signum)
 {
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\n\nSignal %d received, preparing to exit...\n",
-				signum);
+	if (signum == SIGINT || signum == SIGTERM)
 		force_quit = true;
-	}
 }
 
 /* Parse the argument given in the command line of the application */
diff --git a/examples/l2fwd-event/main.c b/examples/l2fwd-event/main.c
index 2d31d4c6ad..c492c6dee0 100644
--- a/examples/l2fwd-event/main.c
+++ b/examples/l2fwd-event/main.c
@@ -582,11 +582,8 @@ static void
 signal_handler(int signum)
 {
 	struct l2fwd_resources *rsrc = l2fwd_get_rsrc();
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\n\nSignal %d received, preparing to exit...\n",
-				signum);
+	if (signum == SIGINT || signum == SIGTERM)
 		rsrc->force_quit = true;
-	}
 }
 
 int
diff --git a/examples/l2fwd/main.c b/examples/l2fwd/main.c
index 1c4a89ae90..851816423f 100644
--- a/examples/l2fwd/main.c
+++ b/examples/l2fwd/main.c
@@ -638,11 +638,8 @@ check_all_ports_link_status(uint32_t port_mask)
 static void
 signal_handler(int signum)
 {
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\n\nSignal %d received, preparing to exit...\n",
-				signum);
+	if (signum == SIGINT || signum == SIGTERM)
 		force_quit = true;
-	}
 }
 
 int
diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 5f89286dce..4fa302f5b0 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -753,11 +753,8 @@ check_all_ports_link_status(uint32_t port_mask)
 static void
 signal_handler(int signum)
 {
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\n\nSignal %d received, preparing to exit...\n",
-		       signum);
+	if (signum == SIGINT || signum == SIGTERM)
 		force_quit = true;
-	}
 }
 
 static void
-- 
2.53.0

