Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BBBC79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:05:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D474E40A7F;
	Mon,  7 Sep 2026 19:05:15 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id B92F640A81
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:13 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-39266382df6so2858648a91.3
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800713;
 x=1789405513; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DaQ4E8rDn5FailSnVT6i7o+XO9lym8inKIDSiK/Gc+0=;
 b=Kx3anbQDwFXgFp5HwG3H8CLh4tsEF0GclLWqscO2SEYc8EqcDiwxpFGbKiqxWIzv+A
 UXJYXr9AHK5iimzj0aQcN+o8Fp7suAzEJQyqTmt9bKh2WZW459mtjmig2fNt0B3mypSl
 c54DFk9E6JAOo8OPDV7eFEnxz8tauBpPgKglSKPv8fNBF9VuDDcbibcA3OdQItqNPXpF
 goeY9kzsFPgeL8Xt6yNQ+dYVTMTUdXDg90cfq4OrwLeeTAJssz2Dhjkf2fSIQOKzqzvV
 npvHtbCVSNouJ+NhJTLCFW3hpZkpSJN1UMEWHYA6IR7DluNA+P+SqZV1VnZZGtzpusjl
 6qvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800713; x=1789405513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DaQ4E8rDn5FailSnVT6i7o+XO9lym8inKIDSiK/Gc+0=;
 b=FbfnbSxa+cnPjkVN0d9SmPcbUsUaOJDEsre5wtvgrqDOLI32g/NI+ip2y1HyK7e7H3
 hjxr8aLveSDmzpkbSxs8/3tf5ZlnjIyRTeh4j6RjW6A1nhRBL2rJlX/od3Q0bknSecPZ
 Cpq3JWaXIfA+JE/PXnT3o8Ki3063Ya8dLCaJ+xrgQjKIQP1uSt29ZbdUOBUTGurWKlRg
 3sn/eIB4EgxfCzPtOA765LjXYfCxvysKST0axZOPzQuOBowAuvethnSW0vgYVwo8jH5S
 g2SwJXASkO2kwshLIPVnIlgAIRcxKOERjzktEGBWbMCSzfQBZt5SBRwr2NOYL6zMGsXG
 WCJA==
X-Gm-Message-State: AFuF++mRX7YEO+ySwzRpvLCdO8Kt6pXeJaKORBf7Tz06TnkLm8dto/Az
 l939Qtl6JD2CHW3iadnNNahuBEt8pMUxVLWNPUJHjNy70SgqcjDohOGRmLjfcfqvHiF2xtCNpkh
 vKmUx
X-Gm-Gg: AYBFou1umcrjjvXRz4AbLIO3tzz1hZGARvy5riJ+j4oyt42p/E5GBHhUzZtXGzvijNq
 uPVXbo67PtKedae4Uf9SvwpBGzz8fmZw/GarPx4kfCM4oq4wUZ9Db3XD7BkOIM0X6Nrljioccm2
 9SUtqFaRoS9H5vL0ztbg77G1cQkgT2ZLiyHtvr0ez81UU2BPQIKMuv2ig9KcIlv41UfKCbdj660
 zI779h7h7RziXu4GbFi5VhqzrGAQwzWxBINu3vLcZmipRcROXBCJcX7n5mSo49Yrq99FdYm54F1
 FYEdsF4l2flHCUex/j4oDeefe4rq/FqgyC4Id2WteHhMPDgmVpOXPdiCyJ0Fmb54E+MKa8JNp+R
 HJ9yXD43CSMKswam5uX7Hc9UpxYdAxCOkGL8e0wmItBET0w8cVmqa+Fnl5EyCByFHte2w7EAIDN
 uSIKZLM38JoQYn1jsCic+Kp0M4Ax17Q4MtD2eJkc5pzIaA+JUcfDn1XmYW4jauOBCAfbZg9yRFD
 /ok4Pi8nNEaXQR7LVQ1S6YCevE=
X-Received: by 2002:a17:90b:33c9:b0:398:c16e:69d3 with SMTP id
 98e67ed59e1d1-39b26122fbamr33707277a91.1.1788800712675; 
 Mon, 07 Sep 2026 10:05:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Ori Kam <orika@nvidia.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v2 02/13] examples: remove printf from signal handler
Date: Mon,  7 Sep 2026 10:03:20 -0700
Message-ID: <20260907170454.351647-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907170454.351647-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
 <20260907170454.351647-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

