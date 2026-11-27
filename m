Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E5606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.a=rsa-sha256 header.s=mail202505 header.b=ScvxOgK3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2F0D40679;
	Fri, 27 Nov 2026 05:41:06 +0100 (CET)
Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
 by mails.dpdk.org (Postfix) with ESMTPS id 55B7E4060C;
 Fri, 27 Nov 2026 05:41:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1795754463;
 bh=xQbzcrYFjlCtJ2OIuwokIjCbSxwGDzh9mUn/lhky9UE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=ScvxOgK3UIECQY8r9gxLSFdXRl2AE498YmXtOC6I8WPmv4NvLslL1Ljj9JDP8eapz
 HTAPUW2tXZ1EfEWsnf04Hj4KYF6XEHUzzi9EgYFHh/6kjRAObqGMVcGZI6WZ+HN/OH
 /gidkVaxO9TvyLxTNq54OSsDDvUEwMIJ6Tews72a6lfFPzaRPPrY8Uo2nJsPAasSIP
 sRs/lPNoc3ZTUYHX+M0G/OQhiepkj6yD4TQZQ2TwHzIhtMkVWf2GC37xxtWe1RC6l0
 J1/up3wRQZyh5YJw/+vKsuoq9vLMCrNH/5fGNfNWXXJ81XwX3o1bSxeqLE0rEY4l62
 Yh6yvcfYpYpQA==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
 by relay16.kaspersky-labs.com (Postfix) with ESMTP id 0E8ADC657F7;
 Fri, 27 Nov 2026 07:41:03 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id BDB48C657E2;
 Fri, 27 Nov 2026 07:41:02 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 07:41:02 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <cristian.dumitrescu@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <jasvinder.singh@intel.com>,
 AlexanderChesnokov <Alexander.Chesnokov@kaspersky.com>
Subject: [PATCH 3/3] test/sched: check port survives config failure
Date: Fri, 27 Nov 2026 07:40:56 +0300
Message-ID: <20261127044056.2869218-3-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127044056.2869218-1-Alexander.Chesnokov@kaspersky.com>
References: <20261127044056.2869218-1-Alexander.Chesnokov@kaspersky.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV2.avp.ru (10.64.57.52) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/27/2026 04:33:33
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 207887 [Nov 26 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 136 0.3.136
 23736263c36d600868e9fbb7b30669123b6e1813
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: chesnokov.avp.ru:5.0.1,7.1.1; 127.0.0.199:7.1.2;
 kaspersky.com:5.0.1,7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions_lk}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/27/2026 04:36:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/27/2026 2:36:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.1.0.9599,
 bases: 2026/11/27 01:57:00 #28986712
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

Add a fast test for the configuration error contract: a rejected
subport or pipe configuration leaves the port valid, the
statistics of the configured subport keep working, the failed
subport can be configured again, and rte_sched_port_free()
completes cleanly. Under ASAN the test reads freed memory on the
pre-fix library, so it doubles as the regression test for the
port ownership fix.

Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---
 app/test/test_sched.c | 71 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/app/test/test_sched.c b/app/test/test_sched.c
index 96b48f1897..a9e5ac8dc8 100644
--- a/app/test/test_sched.c
+++ b/app/test/test_sched.c
@@ -22,6 +22,13 @@ test_sched(void)
 	printf("sched not supported on Windows, skipping test\n");
 	return TEST_SKIPPED;
 }
+
+static int
+test_sched_config_error(void)
+{
+	printf("sched not supported on Windows, skipping test\n");
+	return TEST_SKIPPED;
+}
 #else
 
 #include <rte_sched.h>
@@ -213,6 +220,70 @@ test_sched(void)
 	return 0;
 }
 
+static int
+test_sched_config_error(void)
+{
+	struct rte_sched_subport_params sp = subport_param[0];
+	struct rte_sched_subport_stats subport_stats;
+	uint32_t tc_ov;
+	struct rte_sched_port *port;
+	int err;
+
+	port_param.rate = (uint64_t) 10000 * 1000 * 1000 / 8;
+
+	/* Out of range subport profile is rejected, port stays valid */
+	port = rte_sched_port_config(&port_param);
+	TEST_ASSERT_NOT_NULL(port, "Error config sched port\n");
+
+	err = rte_sched_subport_config(port, SUBPORT, &sp,
+			MAX_SCHED_SUBPORT_PROFILES);
+	TEST_ASSERT_FAIL(err, "Out of range subport profile accepted\n");
+
+	err = rte_sched_subport_read_stats(port, SUBPORT, &subport_stats,
+			&tc_ov);
+	TEST_ASSERT_FAIL(err, "Unconfigured subport stats read accepted\n");
+
+	/* Bad parameters are rejected, the same subport can be retried */
+	sp.qsize[0] = 33;
+	err = rte_sched_subport_config(port, SUBPORT, &sp, 0);
+	TEST_ASSERT_FAIL(err, "Invalid qsize accepted\n");
+
+	sp = subport_param[0];
+	err = rte_sched_subport_config(port, SUBPORT, &sp, 0);
+	TEST_ASSERT_SUCCESS(err, "Subport config retry rejected\n");
+
+	err = rte_sched_subport_read_stats(port, SUBPORT, &subport_stats,
+			&tc_ov);
+	TEST_ASSERT_SUCCESS(err, "Subport stats read rejected\n");
+
+	/*
+	 * Update call with out of range profile is rejected, nothing
+	 * changes (rollback sites live inside the first-invocation
+	 * branch only)
+	 */
+	err = rte_sched_subport_config(port, SUBPORT, &sp,
+			MAX_SCHED_SUBPORT_PROFILES);
+	TEST_ASSERT_FAIL(err, "Out of range profile accepted on update\n");
+
+	err = rte_sched_subport_read_stats(port, SUBPORT, &subport_stats,
+			&tc_ov);
+	TEST_ASSERT_SUCCESS(err, "Subport stats read rejected\n");
+
+	/* Out of range pipe profile is rejected, port stays valid */
+	err = rte_sched_pipe_config(port, SUBPORT, PIPE, 1);
+	TEST_ASSERT_FAIL(err, "Out of range pipe profile accepted\n");
+
+	err = rte_sched_subport_read_stats(port, SUBPORT, &subport_stats,
+			&tc_ov);
+	TEST_ASSERT_SUCCESS(err, "Subport stats read rejected\n");
+
+	rte_sched_port_free(port);
+
+	return 0;
+}
+
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
 REGISTER_FAST_TEST(sched_autotest, NOHUGE_OK, ASAN_OK, test_sched);
+REGISTER_FAST_TEST(sched_config_error_autotest, NOHUGE_OK, ASAN_OK,
+	test_sched_config_error);
-- 
2.53.0

