Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6614AC79F9E
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:27:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DB5C40685;
	Mon,  7 Sep 2026 01:27:42 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id F27CD4068E
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:27:40 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso2594112a12.0
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737260;
 x=1789342060; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nyXfARlmt2ACBGr50cGVyA+lm3kCOE/9d9JNWZOBLdg=;
 b=nNofuRXyK8lupmMD90C8Oxncl1kWxuvfkD9zMHN0ttxmJ8Jg2jaKksCmJoQELbDJ1E
 UdZ63EDOkJRxrJWOJKCWH8Dm4v6/8AS7zPXMldGkm9t4YwhuQaG9fj9p5zm77rdEyW1/
 rNMCmAY7h74wv0ghQtyqVqVUm3Hg4sH+uZTGhaFk3joLv6MxW8eHLyjV+EedCRxN+OqL
 M0Qdrm6CzoKUIekMKkYKCJYpIp9L6cjo5Wcf4r0AqL4MSsm7Xulm/INm8wYZjupvZ10o
 +6BukXk6LldWx/vjQRGP5q014xvSm2sR8FhtsUCs3HsoaGVyyhjfsH36Ba9ZoZMrNgQy
 LrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737260; x=1789342060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nyXfARlmt2ACBGr50cGVyA+lm3kCOE/9d9JNWZOBLdg=;
 b=WMYYB81Dbl6SattJ0aXmbG1fRKtyHVlEli60ek5ggL+x/Q44UJZzlyk3CjLyFvZulg
 NOjqPuqmlY+eXfyKWwftHOfSQAlKoG4SvbEArUrPI0C1dEf6T1QD0kXtKyFk8OowMs8z
 WHA6QLibGyAyQTHmcBVNf/yx6vzKJVA4ixc+VpYbXJ1/ihpGXu+9BYpsIclCVtwBCspA
 X91d54I9MrL87Wpef9qWCa9R/F4twELE4Se+Cbs/AFOvIEjYjiFZjVR3XP4YelxM+Vlh
 Zw9ZFXv4J5TzTL8TrhldUxztVJsIG881jGZuZ+HNpjSq61gYj/0wY8US2/ISN5E0bCNy
 BcfA==
X-Gm-Message-State: AFuF++l1WH26IurwHlH5cEBSj57Kuad0nTJRZLBOgqK6nqh5IxDcXeYk
 0P7+V/gtSxujo5G4u46vj/epjnII1FbmuhWa1F++O5GGRAxaLOmoMEG7bAEd+y0kQi5xRX/Yl/A
 vTdPN
X-Gm-Gg: AYBFou28H/Ts3D04WXrQhnBHQgXXYWoMb3HDsf+S42WK5RogLQsQPILZVdlRzvfJMCa
 ZWoAvxjvEQine/6jtfSi1sJr4+Br6sp9BYTI22qd0i2Mu0PK8cAE7DkPUu9WEP4aYmcUMJnASN1
 M4jLInB0DybC7vOjQAKqMk3yvq1mb9h0PO933aSXVDoh7xPYqgQiJ8P/jHw2o1Jjol+jDMLMjgw
 N1aERGSk5ug4Q/NVVmunnXFUSkPzyRjd1/ZYCR3y2U6vckNg1fq5gMbTJF/gdAzi6mXvwHdMafg
 D7rNNmCSN/vfKKpohZdfRpn1xPLTowU4yA1+zBBaWq0nIiviSBt34ESVQ5ONAbWL/TQSXWy8dnE
 eaHElLE/AXC6Bki3Clh321wI3mxTfLVud48+TaPiBiPVaE3tEFOrIjzbPG3nFkUhtIAitzmmFpW
 jFjnVZxzYiQYAVru7sjb+odidz4U7RaeLwTjWwSyTUiq4+ZR2ulqrnN9Hs0F9TpgXryF8F4jzOB
 Q9/F/gcV8T7SKhRnB2mNFxGfYzCMuccq0LjkQ==
X-Received: by 2002:a17:90b:2687:b0:398:ceef:edde with SMTP id
 98e67ed59e1d1-39b27ed85eamr16040744a91.15.1788737260142; 
 Sun, 06 Sep 2026 16:27:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:27:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 04/13] examples/symmetric_mp: do not print or exit in handler
Date: Sun,  6 Sep 2026 16:24:39 -0700
Message-ID: <20260906232716.496546-5-stephen@networkplumber.org>
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

The SIGINT and SIGTERM handler called printf() and exit() which are
not async-signal-safe.

Set a flag, let the forwarding loops return, and print the stats from
main() after joining the lcores.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/multi_process/symmetric_mp/main.c | 26 ++++++++++++++++------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index 7314a9c6ea..e2d185ab1b 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -92,18 +92,25 @@ smp_usage(const char *prgname, const char *errmsg)
 }
 
 
-/* signal handler configured for SIGTERM and SIGINT to print stats on exit */
+/* Set by SIGTERM and SIGINT handler to stop the forwarding loops. */
+static volatile sig_atomic_t quit;
+
+static void
+signal_handler(__rte_unused int signum)
+{
+	quit = 1;
+}
+
 static void
-print_stats(int signum)
+print_stats(void)
 {
 	unsigned i;
-	printf("\nExiting on signal %d\n\n", signum);
+
 	for (i = 0; i < num_ports; i++){
 		const uint8_t p_num = ports[i];
 		printf("Port %u: RX - %u, TX - %u, Drop - %u\n", (unsigned)p_num,
 				pstats[p_num].rx, pstats[p_num].tx, pstats[p_num].drop);
 	}
-	exit(0);
 }
 
 /* Parse the argument given in the command line of the application */
@@ -344,7 +351,7 @@ lcore_main(void *arg __rte_unused)
 	 * queue number corresponding to our process number (not lcore id)
 	 */
 
-	for (;;) {
+	while (!quit) {
 		struct rte_mbuf *buf[PKT_BURST];
 
 		for (p = start_port; p < end_port; p++) {
@@ -364,6 +371,8 @@ lcore_main(void *arg __rte_unused)
 			}
 		}
 	}
+
+	return 0;
 }
 
 /* Check the link status of all ports in up to 9s, and print them finally */
@@ -440,8 +449,8 @@ main(int argc, char **argv)
 	struct rte_mempool *mp;
 
 	/* set up signal handlers to print stats on exit */
-	signal(SIGINT, print_stats);
-	signal(SIGTERM, print_stats);
+	signal(SIGINT, signal_handler);
+	signal(SIGTERM, signal_handler);
 
 	/* initialise the EAL for all */
 	ret = rte_eal_init(argc, argv);
@@ -484,6 +493,9 @@ main(int argc, char **argv)
 	RTE_LOG(INFO, APP, "Finished Process Init.\n");
 
 	rte_eal_mp_remote_launch(lcore_main, NULL, CALL_MAIN);
+	rte_eal_mp_wait_lcore();
+
+	print_stats();
 
 	/* clean up the EAL */
 	rte_eal_cleanup();
-- 
2.53.0

