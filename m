Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C4BC83F21
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 12:11:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA7704028C;
	Tue, 15 Jul 2025 14:11:21 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id EE58B4021E;
 Tue, 15 Jul 2025 14:11:19 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id 7AB5CEC0BA8;
 Tue, 15 Jul 2025 08:11:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Tue, 15 Jul 2025 08:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1752581479; x=1752667879; bh=419omgLmk7zFwRDTUsJCo
 bH90uCTk5GYhmdUZ+KGYF4=; b=ssmgk3epWtCnkHOshb+wCmudZgZeZlJCbWsgR
 OBd2FGLz/abIU1SRJibwVvSebSMNnZaoT1Idb9p1oRSNtujQKKWEIwSiQOIzmb9P
 U8ov1CQM5KUoH/oBpyF4haSuD9Klw1V7kXsGGX3HQ0btdnBIOxMuqIau/itgbwVd
 H5AMfsBM78irA8N4+qlipeynvnqGaD5VPbsM1KrX76iYr12iwhTbMX2MkOm+xSs4
 Gy9EQ5/WnJnOCnvE1tiD6AFykI51c04SrmiY4Semf6fCIa0IkTm+/YNFeLIFvuuP
 JUK6F5UmlZ6pwq8jVimJdiEFbQ4VSDNcmjOIy06tVVk2mD4XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1752581479; x=1752667879; bh=419omgLmk7zFwRDTUsJCobH90uCTk5GYhmd
 UZ+KGYF4=; b=MNU5UdWQlggXaZ5pdi8/JllSSiEH3ppWL3mEphZYO5Qkm5unFEG
 ETrHV2mxuMQZqKKCL0RIUjJVfB7ABzfM1SaUdf4sWr9MumqdGf808eITBRk8bZ9J
 /aK9w+zHo4AUGRL4njrP8KsG13U8ELoNRvpI56vJ0IoH+fLeCqQhVcaXbFJZAM2N
 prOKl5Z37lzK+sHG3CQ4w7qxo7byukwNoWsT3CJ7V/kkObz/1idqXVvAkbFdk4C7
 6r20LOZ7Jmu1NWdXWB73CkbGO3kOjWVkkvwBnhJhsCdaYISn253V3ITea465G3nu
 7OfjD9GkF4SpQSqa0KU6NdU+fC9qlGiLplA==
X-ME-Sender: <xms:ZkV2aCQLuoW220bKYPaMWgKwcUtaTsBsvhjPPvKmZ4pdWLKV-gAWkw>
 <xme:ZkV2aOr8la5IRP3HyiYnBEDqts4rOKWS0CsNNBeWhIsLIAdHwYMt_5RcJWe69h4E4
 ayXekzcArWgPKmg0A>
X-ME-Received: <xmr:ZkV2aIJ-4c0_pXtMLG4U2H4XApZ7Yegah7vna_S7rFB8gTPAlFlJPhGJ9bXoAGv9vnsuUwr_VToJWXwSYPlgF_ArwOJMfms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeektdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepveevfeevieeihfetudekgeekleeigeffueekveduteeuffeiudevteeiudek
 feelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoh
 epshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopehsohhnghigrdhjihgrlhgv
 sehinhhtvghlrdgtohhmpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesih
 hnthgvlhdrtghomhdprhgtphhtthhopehmkhgrshhhrghnihesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:Z0V2aJrTJCI49EsjN1yqd5W6qpNpTjQKvLUHHnwoOuJxXGcORssUnA>
 <xmx:Z0V2aIwx2HJusSRkew_35e6ENSrksYWIMu5DITljgv16AO55IcNOzw>
 <xmx:Z0V2aFM6nTvFJ7YlrbhjargANwP-T8EBsGI3MlS6TBg_FIMk6r47uA>
 <xmx:Z0V2aF6vFbmAz5gTO52hpNWApiaDKytk5ycxawXy9vj-SnS2r4rLHA>
 <xmx:Z0V2aJBR5k-gmhaQLjd7GfMXP7d_D-MglCgndDon6qSeNxjsaKky2nhN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 08:11:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Song Jiale <songx.jiale@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Maayan Kashani <mkashani@nvidia.com>
Subject: [PATCH] examples/multi_process: revert ports cleanup on exit
Date: Tue, 15 Jul 2025 14:11:10 +0200
Message-ID: <20250715121111.156639-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
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

When closing the primary process, an error occurs when closing ports:

Error closing ports
EAL: failed to send to (/var/run/dpdk/dpdk_X/mp_socket_Y) due to Bad file descriptor
EAL: Fail to send request /var/run/dpdk/dpdk_X/mp_socket_Y:mp_malloc_sync
EAL: Could not send sync request to secondary process

And the secondary process crashes.

It may show several problems to fix in the next release.
Revert the fix causing these issues for 25.07 release.

Bugzilla ID: 1751
Fixes: 4382d58097b4 ("examples/multi_process: fix ports cleanup on exit")
Cc: stable@dpdk.org

Reported-by: Song Jiale <songx.jiale@intel.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 examples/multi_process/symmetric_mp/main.c | 27 ++++------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index de16608a0f..f7d8439cd4 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -92,25 +92,6 @@ smp_usage(const char *prgname, const char *errmsg)
 	exit(1);
 }
 
-static void
-exit_cleanup(void)
-{
-	unsigned int i;
-
-	RTE_LOG(INFO, APP, "Close ports.\n");
-	for (i = 0; i < num_ports; i++) {
-		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-			if (rte_eth_dev_stop(ports[i]))
-				rte_exit(EXIT_FAILURE, "Error stopping ports\n");
-			if (rte_eth_dev_close(ports[i]))
-				rte_exit(EXIT_FAILURE, "Error closing ports\n");
-		}
-	}
-
-	/* clean up the EAL */
-	rte_eal_cleanup();
-	exit(0);
-}
 
 /* signal handler configured for SIGTERM and SIGINT to print stats on exit */
 static void
@@ -123,10 +104,9 @@ print_stats(int signum)
 		printf("Port %u: RX - %u, TX - %u, Drop - %u\n", (unsigned)p_num,
 				pstats[p_num].rx, pstats[p_num].tx, pstats[p_num].drop);
 	}
-	exit_cleanup();
+	exit(0);
 }
 
-
 /* Parse the argument given in the command line of the application */
 static int
 smp_parse_args(int argc, char **argv)
@@ -506,5 +486,8 @@ main(int argc, char **argv)
 
 	rte_eal_mp_remote_launch(lcore_main, NULL, CALL_MAIN);
 
-	exit_cleanup();
+	/* clean up the EAL */
+	rte_eal_cleanup();
+
+	return 0;
 }
-- 
2.47.1

