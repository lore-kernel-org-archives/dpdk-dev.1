Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEDC606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=c5f7jpZB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACBE2400D7;
	Tue, 27 Oct 2026 16:07:54 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 06E5C400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 16:07:53 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2874699a91.2
 for <dev@dpdk.org>; Tue, 27 Oct 2026 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793113672;
 x=1793718472; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I65HlrSdNUFGwcI+5e1KPuUIw/ctc2fsU8/7ECHbK7U=;
 b=c5f7jpZBYkN2ZFcMXT3KyRXqTNQGd7aj36T5eNztLI++HH/fwv9FC500570A0mt6J2
 4Bd175oZ4oL35R5H4yrmfCKmzGgVxbaGE4xd0Y9y9ybu07TjJrmBGjFkTojdtbeKyQJ/
 StaJShhZFtDcBshbJFObiPvEe7Cru9mvoEDQzu60SfgrcbE4YvWh+6THuv9cigEReb3J
 sIZiesNtTMhUr2iWfQJQdQPEgZB/YFK4GQObDs87WTHPsfmJWkmZI0Z6qZO7Kqq3dldy
 O/StR7eoptBma7mWpySHU8fXW8n8Jd6NrI4aDCOwhRXWfQCZeIn3aY0z3b4iV8WrhTK7
 n0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793113672; x=1793718472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I65HlrSdNUFGwcI+5e1KPuUIw/ctc2fsU8/7ECHbK7U=;
 b=OG995s3pR2ZmQwpA8aEVkofqvqlzgX2+VDQ3ag+EelvdArijkI/8VT4OL1jpBgT2Ns
 Bbc1X3HwUGga3PZr69IaB7umkw/y57/yCgXSQ/IqJAbL7LuLAVjbDvO7sjt2Imnl86al
 8n+OclH8elMXNENqo3hB+dkZC+8rLag6zBgeZvPCBmP9CRnQ+eWvHGbcAdLbmpoXPNAp
 H8nBjNGRSqlmnsc+4lg6/wlez3OFuS0Ht4RD1Iw+9Y6lq3IkCufDM204/KADaoy5ZekZ
 H0W41R08fcEANmRIntBzCdJcMEjMGLdqpjdzw9Elv961jIU1L5iwKeG945tL4wHl7/Fx
 yfaQ==
X-Gm-Message-State: AFq9FYIv3Jh9vEG7HUjd6VHxeBPgGtIsmrwrlw7JM4s9sqyDc5gWbsnC
 PBJne0qgNFZlXrB6gpu4/2kbAz5RsLxlcol6qwBWO0GrHHvZfA52N8S/YB2OI6ARKMMfKkXd8nk
 5UDqA
X-Gm-Gg: AYBFou1DwKOPKf0KGD6z30S7U1Z3RJD22dzmTIHmQeR0OOkU0GXks2462IphHQINgKE
 +AcqKBJUDR9Suu8FR+vLhYuTFEcfNlBEjTEU7nqT6gaVgdDGCIs58WqkntjrcS1OKpN+hFkkshJ
 PBbi+KcjbZIY4fdU/bY761JY4+bSiudrbYgiNbeQx8HSKI4PIDmtz6osAhIBflHXp3JM33lQDR2
 yB+Ngy2Om+iP50DvGBqw0DHBlrlPPb+9zlbL5tOMxd+eHhdgDpwk1EYdaSRvj0PdCmcd0R5lHFR
 qYZZ5Gud+eUmZSgh1c9un5n+gN1aJd7A+n3fpjXYcbkN9QkJVRKN6Lwx7YMgbi7X6AJOiD8XAft
 /pgaoz4nEvrlic9O0wOth3NBgcbg7byrtgR2aVIQ6JCBNZO9KJ89JFiPhQ0xAIsAKBZScw0hnCX
 4IUzXAFe5LxbI0mh84OQ3iy0p5yuPqBkf8n9pmQSkcGg+Olc7Q05M8UB0wkDZUR9h4GR04pZ3Io
 1cEvuJdcbl7W/ZeZtNJOjU6IVs543wrl8hZo4II2vuNVbtUL3Mx22O9GQyIQvlh9d1bfMBt2u4v
 pDSovxVfRcqsKvgrYVE=
X-Received: by 2002:a17:90b:17c5:b0:3ac:9176:e837 with SMTP id
 98e67ed59e1d1-3adead4fa19mr8984506a91.50.1793113670651; 
 Tue, 27 Oct 2026 08:07:50 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae40427782sm4242337a91.4.2026.10.27.08.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:07:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] Revert "examples/symmetric_mp: do not print or exit in
 handler"
Date: Tue, 27 Oct 2026 08:07:48 -0700
Message-ID: <20261027150748.1170031-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

