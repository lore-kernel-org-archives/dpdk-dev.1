Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E4FCCF2D3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 08:16:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD92040611;
	Mon, 19 Oct 2026 10:16:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 456A740269
 for <dev@dpdk.org>; Mon, 19 Oct 2026 10:16:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792397777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yTDhPDnX6OSFPmagP2ghE0sKIMlvaghX/fviQz2TpKg=;
 b=ZeBMZ6+Cq0rk4A3m7Ph/kCA7KoKgQ8qjPNrSlWkyBnGZ/azOmDI4sjMN7vfMfzf0OuDQsA
 pn7YniR1jruJSqy09nbQNLg4dVGPVY2u4YibMPk/jV/9QBV+mCReluYbnj9mota29rcWFa
 VzcoE6GWz1Oe4RtUC2H57QSGzNzouw4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-YLaqSV_kMHqojFJo9E2_cw-1; Mon,
 19 Oct 2026 08:16:11 +0000
X-MC-Unique: YLaqSV_kMHqojFJo9E2_cw-1
X-Mimecast-MFC-AGG-ID: YLaqSV_kMHqojFJo9E2_cw_1792397770
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B0161955F11; Mon, 19 Oct 2026 08:16:09 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5FD9C18005B3; Mon, 19 Oct 2026 08:16:06 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, stable@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Anoob Joseph <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2] test: defer timer initialization
Date: Mon, 19 Oct 2026 10:16:02 +0200
Message-ID: <20261019081602.2426732-1-david.marchand@redhat.com>
In-Reply-To: <20261017144747.2155513-1-david.marchand@redhat.com>
References: <20261017144747.2155513-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FtjlxcawAfS3Ly05jzPbKE7PyEWc2ZSSukrh512qOkc_1792397770
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

Initialize timers only in unit tests that do require them.

This removes an unconditional memzone allocation (3MB on ARM) and
avoids failures of the eal_flags_file_prefix_autotest unit test
that runs in legacy mem mode and has a tight 18MB memory budget.

Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
Changes since v1:
- fixed overwritten default return code in pdcp_autotest,
- factorized timer init in timer_secondary_autotest,

---
 app/test/test.c                 |  8 --------
 app/test/test_pdcp.c            | 10 +++++++++-
 app/test/test_timer.c           |  7 +++++++
 app/test/test_timer_perf.c      |  7 +++++++
 app/test/test_timer_racecond.c  |  6 ++++++
 app/test/test_timer_secondary.c | 18 ++++++++++++------
 6 files changed, 41 insertions(+), 15 deletions(-)

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
index 784e2dddd9..af525cf73a 100644
--- a/app/test/test_pdcp.c
+++ b/app/test/test_pdcp.c
@@ -1751,7 +1751,7 @@ test_expiry_with_rte_timer(const struct pdcp_test_conf *ul_conf)
 	struct test_rte_timer_args timer_args;
 	struct rte_pdcp_entity *pdcp_entity;
 	struct pdcp_test_conf dl_conf;
-	int ret = TEST_FAILED, nb_out;
+	int ret, nb_out;
 	struct rte_timer timer = {0};
 
 	const int start_count = 0;
@@ -1759,6 +1759,14 @@ test_expiry_with_rte_timer(const struct pdcp_test_conf *ul_conf)
 	if (ul_conf->entity.pdcp_xfrm.pkt_dir == RTE_SECURITY_PDCP_DOWNLINK)
 		return TEST_SKIPPED;
 
+	ret = rte_timer_subsystem_init();
+	if (ret < 0 && ret != -EALREADY) {
+		printf("timer subsystem init failed: %d\n", ret);
+		return TEST_FAILED;
+	}
+
+	ret = TEST_FAILED;
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
index 529774f4d0..774751c0f5 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -127,13 +127,19 @@ test_timer_secondary(void)
 	struct test_info *test_info;
 	int ret;
 
-	if (proc_type == RTE_PROC_PRIMARY) {
-		if (rte_lcore_count() < NUM_LCORES_NEEDED) {
-			printf("Not enough cores for test_timer_secondary, expecting at least %u\n",
-			       NUM_LCORES_NEEDED);
-			return TEST_SKIPPED;
-		}
+	if (proc_type == RTE_PROC_PRIMARY && rte_lcore_count() < NUM_LCORES_NEEDED) {
+		printf("Not enough cores for test_timer_secondary, expecting at least %u\n",
+		       NUM_LCORES_NEEDED);
+		return TEST_SKIPPED;
+	}
 
+	ret = rte_timer_subsystem_init();
+	if (ret < 0 && ret != -EALREADY) {
+		printf("timer subsystem init failed: %d\n", ret);
+		return TEST_FAILED;
+	}
+
+	if (proc_type == RTE_PROC_PRIMARY) {
 		mz = rte_memzone_reserve(TEST_INFO_MZ_NAME, sizeof(*test_info),
 					 SOCKET_ID_ANY, 0);
 		TEST_ASSERT_NOT_NULL(mz, "Couldn't allocate memory for "
-- 
2.54.0

