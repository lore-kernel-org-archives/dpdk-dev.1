Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCEDCCF2C1
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Oct 2026 14:48:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF8D640298;
	Sat, 17 Oct 2026 16:48:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1750C40276
 for <dev@dpdk.org>; Sat, 17 Oct 2026 16:48:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792248485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WiEXgFx7z8uUf4qBjmDMpIJ1u1+G39ScNIHNYWkUqqs=;
 b=R4+PgmGEcNdf3feLmh+zNjx2f1TIRRuxOD5lOSEHwNxn9xkDTiAhKSGDzp28WBO3hgd5R/
 UWiwNyY9sY7R6QPcKI7bPMHVPx+jnpkPYAna0pJ/f83RgfQrMEbIGHdT8uXN45JHp+Gqb0
 HsIENxLe58GDQdWkV8eIH2ZcuK12Gyk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-d-YTIxqrNq2Te5W7NS1uyQ-1; Sat,
 17 Oct 2026 14:47:55 +0000
X-MC-Unique: d-YTIxqrNq2Te5W7NS1uyQ-1
X-Mimecast-MFC-AGG-ID: d-YTIxqrNq2Te5W7NS1uyQ_1792248473
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E05831956068; Sat, 17 Oct 2026 14:47:52 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43C4E195608A; Sat, 17 Oct 2026 14:47:49 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, stable@dpdk.org,
 Anoob Joseph <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH] test: defer timer initialization
Date: Sat, 17 Oct 2026 16:47:47 +0200
Message-ID: <20261017144747.2155513-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HBU4D-47lFLHlvWBdA9Ol5-GZyFA-5RX4yz7w8KGJRk_1792248473
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Initialize timers only in unit tests that do require them.
This removes an unconditional memzone allocation (3MB on ARM).
This avoids failures of the eal_flags_file_prefix_autotest unit test
that runs in legacy mem mode and has a tight 18MB memory budget.

Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test.c                 |  8 --------
 app/test/test_pdcp.c            |  6 ++++++
 app/test/test_timer.c           |  7 +++++++
 app/test/test_timer_perf.c      |  7 +++++++
 app/test/test_timer_racecond.c  |  6 ++++++
 app/test/test_timer_secondary.c | 12 ++++++++++++
 6 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/app/test/test.c b/app/test/test.c
index c610c3588e..8f23325cb6 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -162,14 +162,6 @@ main(int argc, char **argv)
 
 	prgname = argv[0];
 
-#ifdef RTE_LIB_TIMER
-	ret = rte_timer_subsystem_init();
-	if (ret < 0 && ret != -EALREADY) {
-		ret = -1;
-		goto out;
-	}
-#endif
-
 	if (commands_init() < 0) {
 		ret = -1;
 		goto out;
diff --git a/app/test/test_pdcp.c b/app/test/test_pdcp.c
index 784e2dddd9..4802225791 100644
--- a/app/test/test_pdcp.c
+++ b/app/test/test_pdcp.c
@@ -1759,6 +1759,12 @@ test_expiry_with_rte_timer(const struct pdcp_test_conf *ul_conf)
 	if (ul_conf->entity.pdcp_xfrm.pkt_dir == RTE_SECURITY_PDCP_DOWNLINK)
 		return TEST_SKIPPED;
 
+	ret = rte_timer_subsystem_init();
+	if (ret < 0 && ret != -EALREADY) {
+		printf("timer subsystem init failed: %d\n", ret);
+		return TEST_FAILED;
+	}
+
 	/* Set up a timer */
 	rte_timer_init(&timer);
 
diff --git a/app/test/test_timer.c b/app/test/test_timer.c
index c936843ddc..c943d3155d 100644
--- a/app/test/test_timer.c
+++ b/app/test/test_timer.c
@@ -540,12 +540,19 @@ test_timer(void)
 	unsigned i;
 	uint64_t cur_time;
 	uint64_t hz;
+	int ret;
 
 	if (rte_lcore_count() < 2) {
 		printf("Not enough cores for timer_autotest, expecting at least 2\n");
 		return TEST_SKIPPED;
 	}
 
+	ret = rte_timer_subsystem_init();
+	if (ret < 0 && ret != -EALREADY) {
+		printf("timer subsystem init failed: %d\n", ret);
+		return TEST_FAILED;
+	}
+
 	/* sanity check our timer sources and timer config values */
 	if (timer_sanity_check() < 0) {
 		printf("Timer sanity checks failed\n");
diff --git a/app/test/test_timer_perf.c b/app/test/test_timer_perf.c
index d2d74ebbc6..feb2e910b5 100644
--- a/app/test/test_timer_perf.c
+++ b/app/test/test_timer_perf.c
@@ -41,6 +41,13 @@ test_timer_perf(void)
 	struct rte_timer *tms;
 	uint64_t start_tsc, end_tsc, delay_start;
 	unsigned lcore_id = rte_lcore_id();
+	int ret;
+
+	ret = rte_timer_subsystem_init();
+	if (ret < 0 && ret != -EALREADY) {
+		printf("timer subsystem init failed: %d\n", ret);
+		return TEST_FAILED;
+	}
 
 	tms = rte_malloc(NULL, sizeof(*tms) * MAX_ITERATIONS, 0);
 
diff --git a/app/test/test_timer_racecond.c b/app/test/test_timer_racecond.c
index 6f8b448ff8..4f0ae04062 100644
--- a/app/test/test_timer_racecond.c
+++ b/app/test/test_timer_racecond.c
@@ -121,6 +121,12 @@ test_timer_racecond(void)
 	unsigned lcore_id;
 	unsigned i;
 
+	ret = rte_timer_subsystem_init();
+	if (ret < 0 && ret != -EALREADY) {
+		printf("timer subsystem init failed: %d\n", ret);
+		return TEST_FAILED;
+	}
+
 	main_lcore = lcore_id = rte_lcore_id();
 	hz = rte_get_timer_hz();
 
diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 529774f4d0..0f325365ad 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -134,6 +134,12 @@ test_timer_secondary(void)
 			return TEST_SKIPPED;
 		}
 
+		ret = rte_timer_subsystem_init();
+		if (ret < 0 && ret != -EALREADY) {
+			printf("timer subsystem init failed: %d\n", ret);
+			return TEST_FAILED;
+		}
+
 		mz = rte_memzone_reserve(TEST_INFO_MZ_NAME, sizeof(*test_info),
 					 SOCKET_ID_ANY, 0);
 		TEST_ASSERT_NOT_NULL(mz, "Couldn't allocate memory for "
@@ -188,6 +194,12 @@ test_timer_secondary(void)
 		struct rte_timer *tim;
 		unsigned int i;
 
+		ret = rte_timer_subsystem_init();
+		if (ret < 0 && ret != -EALREADY) {
+			printf("timer subsystem init failed: %d\n", ret);
+			return TEST_FAILED;
+		}
+
 		mz = rte_memzone_lookup(TEST_INFO_MZ_NAME);
 		TEST_ASSERT_NOT_NULL(mz, "Couldn't lookup memzone for "
 				     "test info");
-- 
2.54.0

