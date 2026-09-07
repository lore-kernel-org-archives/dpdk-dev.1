Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B49BC79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:05:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A9CD40A87;
	Mon,  7 Sep 2026 19:05:21 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 72F1040262
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:20 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d9004f39d3so45323925ad.2
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800719;
 x=1789405519; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XzkRVJZ/rkXbk1Z3eu72G8ZgToezkGaaSHmwCyEFR/A=;
 b=ygqCyZCUI21/ZZrPzhtX6/uFDYoYDO0ihGJ2EFFbfSfTYPJ1Do4ogLzuOBpm2uvxBG
 p1vvPJ/wGvRuvOeBywJB+fX4bUmRMaUdDWEw6ejlGRF81I6gqbptT++Hdr+cV7yi08M2
 M/fp0EetVg0h+ooV0eXDO8gj2RuNELlHkMUZrsUJGAQZoKc4Lto+RISJgg4NvJjVEVCe
 ODY9tDtj+CrtjG7wRDF4MeynBBRtM22O6aik4azOtrNO6N7ruh8UatwzPA6svOYghvQz
 +X6c2Frb7u38GQBscoX8a2dKl6PkYsEd9rMojASLtSbJCQhvOEf0jg15fTy2ESshq5U9
 cDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800719; x=1789405519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XzkRVJZ/rkXbk1Z3eu72G8ZgToezkGaaSHmwCyEFR/A=;
 b=XT54f7j9wKqCus+qBESn9lB78X1xDfzPAfel30RlS7MPknUm7Gyl3yl+Y4+ZteohJ8
 eTHTTwqdNaAqnXvOmSu5MYKeaE9zTj+e9eogQNlRueye+GFce4SqjnrkvDXPr4p8mrc3
 dAMiWfM2eSjMbl/kmUXDRova+hkLxSMb0kxV21bIF4fr1XGA5BThVzSeekDOGDKV2sAe
 RqaNoEZrIsyQ2k2Nhr+t7Px4gUT8LonGYev8M9ib2GI/zt/oJDT38H6rBrH43syYAb17
 Tfwk+6Pb/4bGvZG1JqRm2/C39PsxpeZhrQk7XF/doSUWX7P3egjFywI9WDNc3Mflzcnb
 p//w==
X-Gm-Message-State: AFuF++kF99GLkUrpO+fKqKB+Rv95PEDvSkjdUuNQr8m0Q+jEq3g4I/Wi
 loFkGjEuMdUXLEJL+uWI9Bk3EYaiIuJNMv1BbzchfDkpRfEBHomhJB/ggRKmczTSLPqcmk93/CI
 lW+AK
X-Gm-Gg: AYBFou14DkcxlHe08qSHx8V6EAAp1GJsvusisMETexDy3wcIkrl7opDmRYwwhfU0Drb
 Duk+WEdLqIz/uNozH3HEnvEXl5bEcf2/jswwNX3FcG1pM38eUVj56CWa44dhxVvdUSOfPhVWB4a
 NlmFfzAcNS/CfZcAUDfqbdrjuN6gSXmY9rXFXkctJpNAGXadGYfYy+mzICK1FhmbxgExe2JSpFg
 3+xn0p59caw3ruoRNbOorhoi1uN13B9qy/EFlo1GMQdIHOdF4dp9PcxKLOrD587kAP+D8eeJJxl
 CsnbbsE3ngM31gSTOd3KO/KOohun5n6efh/1DtxPRfBZMXXtnon1qYRT0HaMXPATPOWRa2XRKKO
 GXG+c3mSR0SEyQwqsPFYjy1zkTntYdoTeaG3H5xNJCQC7B/TWfJUA2W8kS7E/Nzw1MFBTA/W0qR
 /ikxBeVWRhpe4PYwguQsSlVg2VPSSDz3bBHM9PVprjV/0C0eh82KSov++DiEHnEnSfD/BBM56f+
 jWK1yBikat52oml53pc4ES+/PpU
X-Received: by 2002:a17:90b:2d46:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-39b2620a25emr34032291a91.15.1788800719557; 
 Mon, 07 Sep 2026 10:05:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 04/13] examples/symmetric_mp: do not print or exit in
 handler
Date: Mon,  7 Sep 2026 10:03:22 -0700
Message-ID: <20260907170454.351647-5-stephen@networkplumber.org>
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

The SIGINT and SIGTERM handler called printf() and exit() which are
not async-signal-safe.

Set a flag, let the forwarding loops return, and print the stats from
main() after joining the lcores.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

