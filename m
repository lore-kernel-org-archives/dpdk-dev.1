Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB979606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hGkFZXZg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E90C940151;
	Tue, 27 Oct 2026 21:29:56 +0100 (CET)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTPS id DBD02400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 21:29:54 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so196697a12.3
 for <dev@dpdk.org>; Tue, 27 Oct 2026 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793132993;
 x=1793737793; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fKly86Iuq8V1iYxlT+hELi2gQ49t4LB27FSUNf884qQ=;
 b=hGkFZXZgy2gnbz45pn5M6LhyFBAdexGu5GfhUM2o4AsdujV2mN0YVpT782xwUV2g1L
 DbQdYw5BUtcDuAWPbvD1iptX2sKtL8LMC2OIKNlarwJkBvjuLSz49JCE/z+PvX+PIHNH
 hjcsqQ0ldFdPThODTsrx6GNvixGL6ihbX46CqE+YqBm7nRHqS/pR2z89RZYHwMy9gmna
 Jc5FfIdU+sE0Si+e7ILHIaVTqwtq5TqfazXksMFE8lBi43/UhI/1A5eupoudAbhi60uv
 az5uVDngJhgq1WEwhi3+x48DrpRozIeX76z5fF2TRM4EBGC6WTom6WHVgvKmljuSwxak
 Zftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793132993; x=1793737793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fKly86Iuq8V1iYxlT+hELi2gQ49t4LB27FSUNf884qQ=;
 b=B1N/Omevhp/tsPoeha7i+pFxi25dhsEVgqroKU2D9rRpwVsvz32PCI2CRivvB5lXXT
 /gTJfyPBuiYqeKcekfuv7fYfkO/kLIH/pihGTT/S2qkzjIi5k8bRFvMDtubMu+qK9Wm3
 AzPiRycZ9GhY92unhU5kO0EMmUm9GrkUFwvjdiSHNOMHoZ38WEVk/Vp5/N0sWj3tn9uZ
 NdlQNddrhDlKRgNQVO6AMPOtKnBLRgnJD24Bd6ri9cw/19d7n1V6BwIcp2iAJRSuq1Rh
 Ac0pthZWhVpURHLZ46fc5B0Ye9/7maOweOhZN1I3vcGm8O8hnzud9azomcAcNnbYCuWc
 cF6g==
X-Gm-Message-State: AFq9FYIQ8h/PxfkXzscxZ/x1yWUlBOd1leD+8N5trUs8ziQcz4pXy3mD
 VizvyUQuONRJU19wkWz+64Rxq5iW9hO7rNsDlBN9nzpTUc3PtR/hKJDZbaMLL8v1SX6DtsuxFyW
 Jfrb0TzY=
X-Gm-Gg: AYBFou3zSXbZQUkfco52e4T3FwORKdbOm67e/hRNMW+hxhWTuuVZ9/TmcPYu8nNk4eU
 N1JPAKoO7QzR2MDiXvw0+hsd5w0/37cx+Ws3pGdd7ZCXTOthvyLKsEOQZZR6/mMrVw+RJUiSztr
 wMKLDlySykoMriUyyN3GC6qojaIA+7OGxI5+iV5/Flk39DpvG0S4GBESKLqw0+R6iZPR3yV0exg
 HD4nOBQIXZcb0wK7+IpErw92NgF2CMA5gu/tpUW5gRa74VnK6HFYAsXxvk6uMj3bdIvkRjQ8kw3
 WwN0II0yHyQgCRmIk3cmaWz3mYP7wSZtyW02vFqUZQ6VdfhgLRyExXovSC0EWyeZn12g046NK18
 N5L29q044Tgb/LuvysuzbLXo3OQrgm50UFbvRLY88H1bkjbegl8dZtDIFMm/mYZ3rLr4cjqYB/f
 wX3jP1X+i6nlwubfGG1po7+wYHhIz1UT1Fnl3ZPxzpAtNvTDSqagt5QJoVyEry8qtqT58s2OlCo
 Y+Ts4ajSiOlgODIdD5D7+rAtTykCYHDxQKSWlRnko6e+ENOg5PGTp+EKC2mn0aW8tPU5/PzXjLv
 /8+hzrsilY3XPJsYaZifYYfyP8zXNV6Peej6ldYzUFq6Wx2DToZDNg7B8VLY3Cq89uMp
X-Received: by 2002:a05:6300:8081:b0:3e2:95fb:8d03 with SMTP id
 adf61e73a8af0-3e90242b948mr164693637.69.1793132993088; 
 Tue, 27 Oct 2026 13:29:53 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdac68402a1sm2376873a12.1.2026.10.27.13.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 13:29:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3] Revert "examples/symmetric_mp: do not print or exit in
 handler"
Date: Tue, 27 Oct 2026 13:28:59 -0700
Message-ID: <20261027202949.1034659-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027150748.1170031-1-stephen@networkplumber.org>
References: <20261027150748.1170031-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This reverts commit 9a0b3c409db1963a92d0a91868b1e45254845a8c.

With that change the primary calls rte_eal_cleanup() on SIGINT
while secondaries are still polling the shared queues, which
crashes the secondaries.

Doing shutdown correctly in a multi-process application needs
both processes to monitor each other and handle termination and
unexpected exit. That is too complex for an example; go back to
the simple exit from the signal handler.

Bugzilla ID: 2069

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v3 - need to ignore signum, send correct commit

 examples/multi_process/symmetric_mp/main.c | 30 +++++++++-------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index e2d185ab1b..0d8bf2666e 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -92,17 +92,15 @@ smp_usage(const char *prgname, const char *errmsg)
 }
 
 
-/* Set by SIGTERM and SIGINT handler to stop the forwarding loops. */
-static volatile sig_atomic_t quit;
-
-static void
-signal_handler(__rte_unused int signum)
-{
-	quit = 1;
-}
-
+/*
+ * Signal handler configured for SIGTERM and SIGINT to print stats on exit
+ *
+ * This is not safe way to exit for a real production application; it is just an example.
+ * Doing proper shutdown with primary/secondary requires process monitoring
+ * and rendezvous.
+ */
 static void
-print_stats(void)
+print_stats(int signum __rte_unused)
 {
 	unsigned i;
 
@@ -111,6 +109,7 @@ print_stats(void)
 		printf("Port %u: RX - %u, TX - %u, Drop - %u\n", (unsigned)p_num,
 				pstats[p_num].rx, pstats[p_num].tx, pstats[p_num].drop);
 	}
+	exit(0);
 }
 
 /* Parse the argument given in the command line of the application */
@@ -351,7 +350,7 @@ lcore_main(void *arg __rte_unused)
 	 * queue number corresponding to our process number (not lcore id)
 	 */
 
-	while (!quit) {
+	for (;;) {
 		struct rte_mbuf *buf[PKT_BURST];
 
 		for (p = start_port; p < end_port; p++) {
@@ -371,8 +370,6 @@ lcore_main(void *arg __rte_unused)
 			}
 		}
 	}
-
-	return 0;
 }
 
 /* Check the link status of all ports in up to 9s, and print them finally */
@@ -449,8 +446,8 @@ main(int argc, char **argv)
 	struct rte_mempool *mp;
 
 	/* set up signal handlers to print stats on exit */
-	signal(SIGINT, signal_handler);
-	signal(SIGTERM, signal_handler);
+	signal(SIGINT, print_stats);
+	signal(SIGTERM, print_stats);
 
 	/* initialise the EAL for all */
 	ret = rte_eal_init(argc, argv);
@@ -493,9 +490,6 @@ main(int argc, char **argv)
 	RTE_LOG(INFO, APP, "Finished Process Init.\n");
 
 	rte_eal_mp_remote_launch(lcore_main, NULL, CALL_MAIN);
-	rte_eal_mp_wait_lcore();
-
-	print_stats();
 
 	/* clean up the EAL */
 	rte_eal_cleanup();
-- 
2.53.0

