Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA661606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.a=rsa-sha256 header.s=mail202505 header.b=B+xSKd9B
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B06EA402B2;
	Thu, 26 Nov 2026 06:22:13 +0100 (CET)
Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
 by mails.dpdk.org (Postfix) with ESMTPS id 0370840284;
 Thu, 26 Nov 2026 06:22:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1795670531;
 bh=5+p6zis1vQVnFBZKpeWOcPwk8Ya0sVKku0oJkdXJuJk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=B+xSKd9BwVZpC39FqT8lGQWv3m+NYv53j1UfOIx9+APy7qlDX00hi3vzDqBnIwmQe
 dVvTAluABqj2xrFCnxDwZOAfSbnO+/H1d4ovWENgMmzp2K71XxiiUMNmnL7EPoY086
 uy6JBoylUGOpXJHprgHTKNjVXImW/OV+LIN2y4Yh645M7m6zDEw/8ey+medYQtFjOb
 YAGuESW8C8KC1Wdqipqd4VdQLRMMBSb+TZ2qvfKCwSsdM4hxTJkNOmMMiloaJPad2+
 KIK0D4hZH9/CD1jILevbUxbmprn+q10z7pRuOSK62rF5Jfs0Bxhf8UPjEW8h2Q0E6u
 ZoaNsztxQGbTw==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
 by relay16.kaspersky-labs.com (Postfix) with ESMTP id BA53BC2882C;
 Thu, 26 Nov 2026 08:22:11 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id 1E3D7C167BB;
 Thu, 26 Nov 2026 08:22:10 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 08:22:10 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <cristian.dumitrescu@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <jasvinder.singh@intel.com>,
 AlexanderChesnokov <Alexander.Chesnokov@kaspersky.com>
Subject: [PATCH] sched: fix infinite loop in rational approximation
Date: Thu, 26 Nov 2026 08:22:07 +0300
Message-ID: <20261126052207.4051378-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/26/2026 05:06:33
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 207851 [Nov 25 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 136 0.3.136
 23736263c36d600868e9fbb7b30669123b6e1813
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: chesnokov.avp.ru:7.1.1,5.0.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; kaspersky.com:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions_lk}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/26/2026 05:14:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/26/2026 4:22:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.1.0.9599,
 bases: 2026/11/26 02:07:00 #28981953
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>

rte_approx() scales alpha and d by 10 until d reaches 1,
multiplying denum by 10 on every step. For d below 1e-9 the loop
makes 10 or more steps, denum wraps in uint32_t and no longer
equals 10^k. The input check still passes, the search compares
against the wrapped denum, never finds a match and spins forever.
A fuzzer input with alpha = 2.65e-23 and d = 1.13e-23 (23 scaling
steps, denum = 4135583744) hangs the function.

The same wrapping breaks rte_approx_64() for d below 1e-19. Besides,
both variants hang even with an intact denum once denum squared does
not fit the type: the products in the search overflow and the
comparisons produce garbage. The 32-bit variant hangs on
alpha = 0.333333333 with d = 1.5e-9, the 64-bit variant on
alpha = 7.38e-19 with d = 6.78e-19.

Reject requests whose precision cannot be represented: stop scaling
before denum wraps and require denum * denum to fit the type, so
that every product in the search stays exact. Requests outside these
bounds could hang forever, or compute against a wrapped denominator
and return a fraction unrelated to the request. Requests within the
bounds behave exactly as before; the sched configuration calls
rte_approx_64() with the constant 1e-7, which keeps working.

Add sched_approx_autotest cases: the two hanging requests are
rejected, and coarse requests still return the minimal fraction
inside the requested interval.

Fixes: de3cfa2c9823 ("sched: initial import")
Cc: stable@dpdk.org
Cc: jasvinder.singh@intel.com

Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---
 app/test/test_sched.c  | 44 ++++++++++++++++++++++++++++++++++++++++++
 lib/sched/rte_approx.c | 10 ++++++++++
 2 files changed, 54 insertions(+)

diff --git a/app/test/test_sched.c b/app/test/test_sched.c
index 96b48f1897..528ee3462a 100644
--- a/app/test/test_sched.c
+++ b/app/test/test_sched.c
@@ -10,6 +10,7 @@
 
 #include "test.h"
 
+#include <rte_approx.h>
 #include <rte_cycles.h>
 #include <rte_ether.h>
 #include <rte_ip.h>
@@ -22,6 +23,13 @@ test_sched(void)
 	printf("sched not supported on Windows, skipping test\n");
 	return TEST_SKIPPED;
 }
+
+static int
+test_sched_approx(void)
+{
+	printf("sched not supported on Windows, skipping test\n");
+	return TEST_SKIPPED;
+}
 #else
 
 #include <rte_sched.h>
@@ -213,6 +221,42 @@ test_sched(void)
 	return 0;
 }
 
+static int
+test_sched_approx(void)
+{
+	uint32_t p32 = 0;
+	uint32_t q32 = 0;
+	uint64_t p64 = 0;
+	uint64_t q64 = 0;
+	int err;
+
+	/* Precision below 1e-4 cannot be represented in uint32_t */
+	err = rte_approx(2.647139521348302e-23, 1.126263171287887e-23,
+		&p32, &q32);
+	TEST_ASSERT_FAIL(err, "rte_approx accepted unrepresentable d\n");
+
+	/* Precision below 1e-9 cannot be represented in uint64_t */
+	err = rte_approx_64(7.383780580184771e-19, 6.781948062808501e-19,
+		&p64, &q64);
+	TEST_ASSERT_FAIL(err, "rte_approx_64 accepted unrepresentable d\n");
+
+	/* Coarse precision still succeeds */
+	err = rte_approx(0.125, 0.01, &p32, &q32);
+	TEST_ASSERT_SUCCESS(err, "rte_approx rejected d = 0.01\n");
+	TEST_ASSERT_EQUAL(p32, 1, "Wrong approximation p\n");
+	TEST_ASSERT_EQUAL(q32, 8, "Wrong approximation q\n");
+
+	/* rte_sched configuration calls rte_approx_64() with d = 1e-7 */
+	err = rte_approx_64(0.125, 1e-7, &p64, &q64);
+	TEST_ASSERT_SUCCESS(err, "rte_approx_64 rejected d = 1e-7\n");
+	TEST_ASSERT_EQUAL(p64, 1, "Wrong approximation p\n");
+	TEST_ASSERT_EQUAL(q64, 8, "Wrong approximation q\n");
+
+	return 0;
+}
+
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
 REGISTER_FAST_TEST(sched_autotest, NOHUGE_OK, ASAN_OK, test_sched);
+REGISTER_FAST_TEST(sched_approx_autotest, NOHUGE_OK, ASAN_OK,
+	test_sched_approx);
diff --git a/lib/sched/rte_approx.c b/lib/sched/rte_approx.c
index 86c7d1d3fb..7af4191df1 100644
--- a/lib/sched/rte_approx.c
+++ b/lib/sched/rte_approx.c
@@ -157,10 +157,15 @@ int rte_approx(double alpha, double d, uint32_t *p, uint32_t *q)
 	/* Compute alpha_num, d_num and denum */
 	denum = 1;
 	while (d < 1) {
+		if (denum > UINT32_MAX / 10)
+			return -1;
 		alpha *= 10;
 		d *= 10;
 		denum *= 10;
 	}
+	/* the search products must fit in uint32_t */
+	if (denum > UINT32_MAX / denum)
+		return -1;
 	alpha_num = (uint32_t) alpha;
 	d_num = (uint32_t) d;
 
@@ -310,10 +315,15 @@ int rte_approx_64(double alpha, double d, uint64_t *p, uint64_t *q)
 	/* Compute alpha_num, d_num and denum */
 	denum = 1;
 	while (d < 1) {
+		if (denum > UINT64_MAX / 10)
+			return -1;
 		alpha *= 10;
 		d *= 10;
 		denum *= 10;
 	}
+	/* the search products must fit in uint64_t */
+	if (denum > UINT64_MAX / denum)
+		return -1;
 	alpha_num = (uint64_t) alpha;
 	d_num = (uint64_t) d;
 
-- 
2.53.0

