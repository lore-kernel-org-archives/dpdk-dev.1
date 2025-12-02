Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEF4D116F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 15:50:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E7CD402E4;
	Tue,  2 Dec 2025 16:50:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id AD3BB400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 16:50:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764690632; x=1796226632;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G5BcYt8KLE/k/R7wJ5zfWAOp6LBTZtiHgiRZ7NRySQw=;
 b=f+FfeZg9YFaG7H3TJz8agWPRbo7D11p+B+5nawJaIa5MiO9N9LRmq0pv
 5UT2LbtTGna5AnzaSdoyVdDRqkO/LUipoYvcNyYa4DxFsQIEYrTQSjs0j
 A8XtBTuknsR/InFe2J0Rr+/vvP2aXj3OQtX4dTZmlo+rznssSGi12jm8p
 J+QgUgEB0uejJ6oPCWffGtwIVoFoKFomoeLXEsoWTOcdaOpbkajWPS2VT
 KxIg6MJWpnhllmCZPFQsjugwDPtJdOGtAHo7h5ijV7MIfx9SMyWOe3uqc
 ydWBYZytJUMPA7mvPHWixm2pQi/4cYF7/ee2I81G+UdDn7UpdIxhQDYKL Q==;
X-CSE-ConnectionGUID: 7sOrBzGVTBq3XjFdCCU7Tg==
X-CSE-MsgGUID: YIy1X9jPSS6dP30OvchDrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="78008724"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="78008724"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 07:50:30 -0800
X-CSE-ConnectionGUID: 6VHi4uRjSMuq3RfKrCs4PQ==
X-CSE-MsgGUID: eb8wnXtYQG+vrIQE6hxkHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="194499142"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 02 Dec 2025 07:50:30 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/2] app/test: add some unattached tests to fast-test suite
Date: Tue,  2 Dec 2025 15:49:47 +0000
Message-ID: <20251202154948.1757169-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202154948.1757169-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
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

There are quite a number of test cases defined which are not present in
any test-suite. Meson warns about these on build, so reduce the warnings
by adding externla-mem, ipsec-sad, red and secondary timer test cases to
the fast-test suite.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_event_crypto_adapter.c | 2 +-
 app/test/test_external_mem.c         | 2 +-
 app/test/test_ipsec_sad.c            | 2 +-
 app/test/test_red.c                  | 2 +-
 app/test/test_timer_secondary.c      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/app/test/test_event_crypto_adapter.c b/app/test/test_event_crypto_adapter.c
index ab24e30a97..2204a521d0 100644
--- a/app/test/test_event_crypto_adapter.c
+++ b/app/test/test_event_crypto_adapter.c
@@ -1625,5 +1625,5 @@ test_event_crypto_adapter(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(event_crypto_adapter_autotest,
+REGISTER_FAST_TEST(event_crypto_adapter_autotest, true, true,
 		test_event_crypto_adapter);
diff --git a/app/test/test_external_mem.c b/app/test/test_external_mem.c
index 0c64b610a9..ac77de1440 100644
--- a/app/test/test_external_mem.c
+++ b/app/test/test_external_mem.c
@@ -587,4 +587,4 @@ test_external_mem(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(external_mem_autotest, test_external_mem);
+REGISTER_FAST_TEST(external_mem_autotest, false, true, test_external_mem);
diff --git a/app/test/test_ipsec_sad.c b/app/test/test_ipsec_sad.c
index 642643eb63..c8dc3f0387 100644
--- a/app/test/test_ipsec_sad.c
+++ b/app/test/test_ipsec_sad.c
@@ -899,4 +899,4 @@ test_ipsec_sad(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(ipsec_sad_autotest, test_ipsec_sad);
+REGISTER_FAST_TEST(ipsec_sad_autotest, true, true, test_ipsec_sad);
diff --git a/app/test/test_red.c b/app/test/test_red.c
index 7f38ed1469..aa91a53562 100644
--- a/app/test/test_red.c
+++ b/app/test/test_red.c
@@ -1872,6 +1872,6 @@ test_red_all(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(red_autotest, test_red);
+REGISTER_FAST_TEST(red_autotest, true, true, test_red);
 REGISTER_PERF_TEST(red_perf, test_red_perf);
 REGISTER_PERF_TEST(red_all, test_red_all);
diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 60ce8c7507..d860656f27 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -224,4 +224,4 @@ test_timer_secondary(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(timer_secondary_autotest, test_timer_secondary);
+REGISTER_FAST_TEST(timer_secondary_autotest, false, true, test_timer_secondary);
-- 
2.51.0

