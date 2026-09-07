Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A901C79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:05:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D2AC40B97;
	Mon,  7 Sep 2026 19:05:29 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 5218840B98
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:28 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-398c1101c1bso3560195a91.1
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800727;
 x=1789405527; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ObOgKd7a4iin2YK4bb/8rT39b1IaF6PyyWrxdJ+KGZM=;
 b=HxyRQzjftixZERZTb58NDCKjljT/SuOiWsAb57hGXuToVe2B5QyG3QhNgEXDH2oUUd
 OcNbLWLWNBGBN1FSFaqgqXGinXVrxHmy2yoTXwob37m4zLNkWsWp6Bfl8IvzQDggzjG5
 Muvji64pS6e+mr/25JtdiIXV6LaGSfdqLMy9iTFqMHoeSyXA6ho39E3vgV4kOaeM81pZ
 xCeDzLZbsw4OtCypryAPiPkA+8EUOV9oIpLtSkZSX9CTVV7240Ai0lCMaYOLjyAr2duT
 xqF2YQRtISMnPD20Bfza6t72i7GCtMYjH9gnLCJO5/foNZNQyJcGIGvCSKhMGqbL2uvz
 wEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800727; x=1789405527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ObOgKd7a4iin2YK4bb/8rT39b1IaF6PyyWrxdJ+KGZM=;
 b=AswNFDreoh+aj1bZvM62ayZtv03UqdbnL4h5+NLjpNTa+4Zqx5ZAdB/Lgz3sXLb9Cs
 vnOIIbgdVlTNY68eKT2CgqYVncgEy/NHl8bHIc0e2fhNtxnuGV8vTIPyKcNCK1xj3kmb
 NR87pfUqY8FkgdCHNQMBeBCejv2Dh5JZ6VNbcrrFHQ6p/Feh8RF8aBH+I/YEcmx308J2
 HqCcEe4BwNY/rJ6IKZg+hxR+KAwUV/7y3J+JUbEqG2VQO6v9xVAKcsNVJ+Vnh4J1RqhG
 6j9HEfWCFdaL+vwS2GobFINeYE2nehxghvQ4W6XMSZu3TyvjuFpds6CHJQAOPYIhhQ8e
 T7rw==
X-Gm-Message-State: AFuF++knca2/OvVDrEpB41B+Gf7m2YNWMjojvVy3GO/Hzo6/M3Fbdo47
 SwC9SRDuTPt02s/8K038UolbcAYhwU6mykv5AI3SlzuuyrWmbNLYh7GbfoHfEXO5PtscDZ53C3v
 Stx8x
X-Gm-Gg: AYBFou2hDplPJX1DjWqK5Ngas02XykCP2DcciBOmRuPEq+BUqW1sooMEwzrllWQfA9T
 pTSIpeKPhzAiTFliB+yPx8eBR25ApCrSbjaJIRJ/m3M+8g+70JfawgTlV85AUZlL/z5blt177cE
 dx9O+CyhDqO6BTtqVGTh1sgggMD0SzduhaozFIt7t4zWYh+jpOPPtNEX0W0P9blGWAh0ouY+Ngj
 bVKDZIOhiM47DT8WE1PGeUrCE1Gn7d6eC69hmQpAPM1UqULuZwyBy86XdWI6Au3ACLuj7oEPT3n
 9/k9ciICXo7nOlIhx2LZY+iT6/zk6upUsid0easgr84GREPksQt4/vZ+ZUA9Ct3gjEITR5VDCtm
 xLRCdr8kI/AbKJ1xRWgpMNvskau0eZRssPIau+MIRA4ZBV/yu49jr06OG7zymxDlAhvhFAvJca4
 NTNZ3tVhD3jR4Fbb6IAL7hkrSvVWRUSqGDupwmrNiStjj9ZblozJf43Kj+bn8/5sxqaF2BzP+HX
 JH7SvMBMmHo7UmLMo42XJ+vOO1wT+W9z/wXWA==
X-Received: by 2002:a17:90b:3d89:b0:396:5fce:8e24 with SMTP id
 98e67ed59e1d1-39b260d2ea8mr31830924a91.4.1788800727364; 
 Mon, 07 Sep 2026 10:05:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 06/13] examples/vhost: make signal handler safe
Date: Mon,  7 Sep 2026 10:03:24 -0700
Message-ID: <20260907170454.351647-7-stephen@networkplumber.org>
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

The SIGINT handler unregistered the vhost drivers and called exit(),
neither of which is async-signal-safe.

Set a flag, let switch_worker() return, and unregister the drivers in
main() after joining the lcores.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/vhost/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/examples/vhost/main.c b/examples/vhost/main.c
index 5978a50cfe..f768f0c5e0 100644
--- a/examples/vhost/main.c
+++ b/examples/vhost/main.c
@@ -79,6 +79,9 @@ static int dma_count;
 /* mask of enabled ports */
 static uint32_t enabled_port_mask = 0;
 
+/* Set by the SIGINT handler to stop the worker loops. */
+static volatile sig_atomic_t quit;
+
 /* Promiscuous mode */
 static uint32_t promiscuous;
 
@@ -1494,7 +1497,7 @@ switch_worker(void *arg)
 		}
 	}
 
-	while(1) {
+	while (!quit) {
 		drain_mbuf_table(tx_q);
 		drain_vhost_table();
 		/*
@@ -1872,14 +1875,10 @@ unregister_drivers(int socket_num)
 	}
 }
 
-/* When we receive a INT signal, unregister vhost driver */
 static void
 sigint_handler(__rte_unused int signum)
 {
-	/* Unregister vhost driver. */
-	unregister_drivers(nb_sockets);
-
-	exit(0);
+	quit = 1;
 }
 
 static void
@@ -2070,6 +2069,9 @@ main(int argc, char *argv[])
 	RTE_LCORE_FOREACH_WORKER(lcore_id)
 		rte_eal_wait_lcore(lcore_id);
 
+	/* Unregister vhost driver. */
+	unregister_drivers(nb_sockets);
+
 	for (i = 0; i < dma_count; i++) {
 		if (rte_vhost_async_dma_unconfigure(dmas_id[i], 0) < 0) {
 			RTE_LOG(ERR, VHOST_PORT,
-- 
2.53.0

