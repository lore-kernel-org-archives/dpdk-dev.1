Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EA6606A322
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HTazhour
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97DFD40151;
	Tue, 27 Oct 2026 21:24:09 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mails.dpdk.org (Postfix) with ESMTPS id F278F400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 21:24:07 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3acd21ba21aso264322a91.1
 for <dev@dpdk.org>; Tue, 27 Oct 2026 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793132646;
 x=1793737446; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OMTunFIleMsPN8TWYoVNGkZu5jXYv4CMdaUuGsOHq/4=;
 b=HTazhour7DjBKqvHeJbeF81HETzPlxoOjY4CXK2jJ6WiPCG7deLIMpvq16hJACO0s2
 Kfp9mvTVAzNeB/Rhz8kHo8LDpqI/bMvb6JrcHy1f5aQl3ju7mYsHGZWUPptggOuNZXuK
 svdGz2mySgUzRk06SK+PSZAkZV8b2Q/squ26vLkcsAEM/+efv+v1vO3+9upAujWQ4PS8
 G4p79M9FfHtDq1jjWH1nNMUBLMz7MuKDyJbsbHZzqqHtHr5X0+HykXOy8PMcEvEqSLHe
 QsInIUOi7Lj7pNO0CCrGg1nTp0Fp2b+3bk6sAfAgpLo+AevreCYvaEJ1hBb+qV/fESao
 vF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793132646; x=1793737446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OMTunFIleMsPN8TWYoVNGkZu5jXYv4CMdaUuGsOHq/4=;
 b=xj6G56rsfHfgJyxG9Om3EDdfpOHw3yBI4ELudW+otvjuRqklblehry1Q54ZhQQWks2
 3aBGWAaHDlC7ndTM5AKKT8pOyIzIrwbdkNsSOdj3lmnzX4rC82mP+vCwRBtN2XUuxUsU
 VJULC1GWeJAzujwtLHLCPm9uL3GHwdpzVruOg03jl6+/aXLelOOvKypaofPS3rsGvgH3
 HDclZl8BnGrzfz2MtcA6bgXLZzeUzWc8VhseI1q0u9PmnD0upHJT5HIl2QL3aSf3fk5K
 6omVcYARGP9RNfpsl53knP3dBISv7kYZQkS1cHGketVTEl1YhEuBKkcJcyPx7rBo4QiS
 Qpdg==
X-Gm-Message-State: AFq9FYJZcRBDOUZ/DqVjfGeUdEX6ekBeqqmHM0tPeRwuagtoVfVXA3Eh
 rcxR6ZlnR1OAXSTx2zCfTOU1aCR2pI0lT6HMey9vu8Zg272YejmUPi6+82Bh+5V5QttFsJtAiHK
 VMh2+pc8=
X-Gm-Gg: AYBFou1Gwh+dUcBMQnuBUb93l3iosiAVmxqA8dHPCAOmCAWnsVDOJSTVCHmXUbdgiRW
 1Egf2A1IIwSC+GdZ4MYnyfoFnXiv6Eej3iGPoyAtZrRn2pW4Ox41egQSm/kyqB3wJ6krcOQIVX/
 d0SBFda4Eoklhd/r9rlutricHdUt5hc6ZZakeAFUStGy4bLCNWrtTcExQvrU/qnZyHybaI2Qp4r
 yJYcghUZriVIw4P5MOdKit/PnXMaKnZPbYcrhOi9HVY+oySBcrfhBmXrBV/nsR44sXLkDYMP5fU
 5vJ+1gDyZJ5UMui63pmaVr3wFl/rinHU1XaQ+X/080W5Npafk2F/6eJCdRy7uery+AodUgoOmHy
 FM0cIZVXkrta1f7F+zLA618O6f9LSsul13CbRelko2/aJF/TnCNmlbJ1jcxe5KPlG7j8pvVqfDo
 pMGER0xXE/w3gpDqsdivsGsAQoAnFOdDDyQZl61fHVnm3cquUlYtBeWo/+ds5FAd3JKvwu0ekBa
 n9gvuRA+AsxBKAzDuWDj3TvJC5wdNv2L3fofohD2vkChAJvmGcLt8NYPUIejVy8XrLI/PJcxB5o
 wvr86UJSWrA/TtDTQ3mrniPpC7jChuzb68aLjCYIqTvKKJRLulri+kc9PhKy9APNuJOp
X-Received: by 2002:a17:90b:2f4f:b0:3ab:f2a9:cacd with SMTP id
 98e67ed59e1d1-3ae5830812cmr133395a91.49.1793132646133; 
 Tue, 27 Oct 2026 13:24:06 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae577d42cfsm351177a91.3.2026.10.27.13.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 13:24:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] Revert "examples/symmetric_mp: do not print or exit in
 handler"
Date: Tue, 27 Oct 2026 13:23:41 -0700
Message-ID: <20261027202402.1006342-1-stephen@networkplumber.org>
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
v2 - need to mark arg unused

 examples/multi_process/symmetric_mp/main.c | 30 +++++++++-------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index e2d185ab1b..05f61abedb 100644
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
+print_stats(int signum)
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

