Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54094C79F9E
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:28:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41AA540A7F;
	Mon,  7 Sep 2026 01:28:08 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 2184F402B8
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:28:07 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso2594303a12.0
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737286;
 x=1789342086; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyrPg3wSV3cBfy11SbvwZ8mY3VtKJawpHdCxnKiUJ8c=;
 b=tsigb9X7YTk/XWEVksF359h0a8RUS/wKgcJBxKz3jcaxNbjsJS0ujhD2udZrQrVYqk
 5M/igy8p/ZWl2CtEQDyu4gF8oo5N80ZnjO7KELxUssS/t2qBnWDOsLnnazeF+PmbuzRo
 mv39D6LZACVF1OthQpY775H6FIHHvIBQ31y3fIa2e7u9pH9EMbaZCZSnehBhkljpv6OY
 TWR6llec9UwsnzVVTbJNTNEDc02K4Q2SJuGPStd2J3Qc3VRNkN8lizZ2mjIbK5+T7lhV
 ym+Dto0/OadK9echSK/NC9v1liiHtlOJqlqcrHBMfgiVTR/ETUPU3IsyB9drKpJOoxqN
 7biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737286; x=1789342086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyrPg3wSV3cBfy11SbvwZ8mY3VtKJawpHdCxnKiUJ8c=;
 b=A0Xs6zNk+DYqDqAldDNZtR+pyrW7ro4pV95hq5TnmmIATRuQ9gS+JxedNau355/pXi
 6CtB3GRlKBCaAQ6ZAEWFcEhabQSBjAx5MfppU+8TKtjKQRLBMa8vd+XI05hcf2zdbamP
 9dHXSCfsDp4L1/FA6KsJMcTLnkBS1v2FvVrF4WYtnwM6Y5dLP9P7hQJQ5ljkFXjmqUSH
 bCtv6amvyH6C48qG3uTAdAub6kb7nwOJecwX3nqE98FmDz/zir+wFMewM4VkPllX1Yws
 WgAsFDh9tqja4ASaatLm2sDOPIxwRE/TadZ9GVE0ozTk2jjpD030mQuAfUD//cajqUOR
 FUJA==
X-Gm-Message-State: AFuF++mi3So/4aEI8mjUq5d6s9R4oq0SfFGCFid4zrb4ZAscYfMhRPpe
 ko5d4xWlsnknmpIF/2UX7iW9Kam1m5BKZ7Apf5eiZBrNx75YuQZglPcuQbPW5M/uSQJGMruBD6I
 IlDSe
X-Gm-Gg: AYBFou1UZZv73+tA0iUH7Ym37G86UccnI3W4Hh3x14NMJ3xsqN5xWJ+pbSxjgAr3Zxh
 qVjVbMMRvLbr9B9mj1xHT30VRIlk8XPxvPAMMopm0t/6eYZx5TvZ4AlFFy3qVhreY97g20e6vCs
 F/+tg0Rmx2Y8K6ZEtJPdjHYM+Mq0stFRgGClwbAgeocW0n57KCfW6E2wi3VvHqOOk/jfxoIiXYJ
 xgGeBUMwZnqfiP0G2yYZThuPrIpanU3prkBkMgeXnQ2h7U4NQz6tMQ+ebT+heZGuejapcR+VsMi
 qIfyPRwTZWkfKd7pzYitXGnyTHA+zH4hmU6m05akXM/ZknMkFrwVhK3PqVjLraKWCAxAALirMnk
 df2k6Hz28wtdql2R1jZK72sx+XDx3JniygMcK193zXc3xbwFdyncSEwP8+/e7m3W6jF1Dqt4FEs
 AbGhTYEp52TNmaleNLjc2PLDXwWHTaoJzhJqeIBmlcZbjInJjopFr1SkhLodfwKGpj/JWFeCTER
 zfeqssRbtAnfI3isSUxC0j2DGk=
X-Received: by 2002:a17:90b:2751:b0:398:9bd3:d6d4 with SMTP id
 98e67ed59e1d1-39b27ec580fmr15915504a91.14.1788737286098; 
 Sun, 06 Sep 2026 16:28:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:28:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 12/13] examples/vmdq_dcb: allow exit on signal
Date: Sun,  6 Sep 2026 16:24:47 -0700
Message-ID: <20260906232716.496546-13-stephen@networkplumber.org>
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

The forwarding loop never terminated, so the application could only be
killed. There was also no wait for the worker lcores.

Add a SIGINT and SIGTERM handler that sets a flag, return from
lcore_main() when it is set, and join the workers before cleanup.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vmdq_dcb/main.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/examples/vmdq_dcb/main.c b/examples/vmdq_dcb/main.c
index d6f7b632b9..563b4f9ce1 100644
--- a/examples/vmdq_dcb/main.c
+++ b/examples/vmdq_dcb/main.c
@@ -513,6 +513,15 @@ update_mac_address(struct rte_mbuf *m, unsigned dst_port)
 	rte_ether_addr_copy(&vmdq_ports_eth_addr[dst_port], &eth->src_addr);
 }
 
+/* Set by the SIGINT and SIGTERM handler to stop the forwarding loops. */
+static volatile sig_atomic_t quit;
+
+static void
+signal_handler(__rte_unused int signum)
+{
+	quit = 1;
+}
+
 /* When we receive a HUP signal, print out our stats */
 static void
 sighup_handler(int signum)
@@ -567,7 +576,7 @@ lcore_main(void *arg)
 		return 0;
 	}
 
-	for (;;) {
+	while (!quit) {
 		struct rte_mbuf *buf[MAX_PKT_BURST];
 		const uint16_t buf_size = RTE_DIM(buf);
 		for (p = 0; p < num_ports; p++) {
@@ -598,6 +607,8 @@ lcore_main(void *arg)
 			}
 		}
 	}
+
+	return 0;
 }
 
 /*
@@ -640,6 +651,8 @@ main(int argc, char *argv[])
 	uint16_t portid;
 
 	signal(SIGHUP, sighup_handler);
+	signal(SIGINT, signal_handler);
+	signal(SIGTERM, signal_handler);
 
 	/* init EAL */
 	ret = rte_eal_init(argc, argv);
@@ -697,6 +710,11 @@ main(int argc, char *argv[])
 	/* call on main too */
 	(void) lcore_main((void*)i);
 
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		if (rte_eal_wait_lcore(lcore_id) < 0)
+			return -1;
+	}
+
 	/* clean up the EAL */
 	rte_eal_cleanup();
 
-- 
2.53.0

