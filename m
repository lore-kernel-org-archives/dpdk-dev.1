Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C811D3B7DE
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 11:53:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8ABF40A71;
	Mon,  8 Dec 2025 12:53:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 60E7840663
 for <dev@dpdk.org>; Mon,  8 Dec 2025 12:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765194778; x=1796730778;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jw38IJeuia8ayLYJzVRpRIg6H9gSEcZaxMV7arPtwQ4=;
 b=eUIk2dxBuMZ71Uo2BJS7SPK053bLh4/q2QeOVtdcYH2em27BmDLHZboQ
 vfDaKBsrgntkDiy1SWHR+RJN8N9zg255AqgQaolDOaKgPWqfyynxRPWuK
 Ta6Nq/SxjFsPH7mKAitNDqvWs4bOsaceitJsqWzn5fe0p8RzRUXLWMtlX
 dQ3l1wkrHTOuGvtT0NBxMt9o0go88CEgjk75dcpm3YC32eC3DmLPigF24
 morwya6w59jIgA35f8SvR0aM6celkS3nlNj/r3ldWQgSU4tkQ7v8M0w9j
 E7w8wsQonhn4/4vx3G2HZK7FWx+fIyeZMXrIGp3IAPgzdDMYd81gmlK0v g==;
X-CSE-ConnectionGUID: qeCtrYQWTcyYM+GLlydzjQ==
X-CSE-MsgGUID: b6SJ+iutQESsD3xwTi/usg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67096061"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67096061"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 03:52:58 -0800
X-CSE-ConnectionGUID: h016Hdm3RVumRvPrGRnk8g==
X-CSE-MsgGUID: Aj/UL/roSkew10YC1IGbDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="195970676"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 08 Dec 2025 03:52:58 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 09/11] app/test: add tests to driver test suite
Date: Mon,  8 Dec 2025 11:52:43 +0000
Message-ID: <20251208115245.3809624-10-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208115245.3809624-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251208115245.3809624-1-bruce.richardson@intel.com>
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

A number of eventdev, cryptodev and ethdev tests require devices to be
present in order to run so add them to the "driver" suite of tests.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_cryptodev_crosscheck.c   | 2 +-
 app/test/test_ethdev_api.c             | 2 +-
 app/test/test_event_crypto_adapter.c   | 2 +-
 app/test/test_event_eth_rx_adapter.c   | 4 ++--
 app/test/test_event_timer_adapter.c    | 2 +-
 app/test/test_security_inline_macsec.c | 2 +-
 app/test/test_security_inline_proto.c  | 6 +++---
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/app/test/test_cryptodev_crosscheck.c b/app/test/test_cryptodev_crosscheck.c
index b9a53a430c..bb21c3bc50 100644
--- a/app/test/test_cryptodev_crosscheck.c
+++ b/app/test/test_cryptodev_crosscheck.c
@@ -1047,4 +1047,4 @@ test_crosscheck(void)
 	return ret;
 }
 
-REGISTER_TEST_COMMAND(cryptodev_crosscheck, test_crosscheck);
+REGISTER_DRIVER_TEST(cryptodev_crosscheck, test_crosscheck);
diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c
index 00d6a5c614..76afd0345c 100644
--- a/app/test/test_ethdev_api.c
+++ b/app/test/test_ethdev_api.c
@@ -185,4 +185,4 @@ test_ethdev_api(void)
 /* TODO: Make part of the fast test suite, `REGISTER_FAST_TEST()`,
  *       when all drivers complies to the queue state requirement
  */
-REGISTER_TEST_COMMAND(ethdev_api, test_ethdev_api);
+REGISTER_DRIVER_TEST(ethdev_api, test_ethdev_api);
diff --git a/app/test/test_event_crypto_adapter.c b/app/test/test_event_crypto_adapter.c
index ab24e30a97..cac1584f40 100644
--- a/app/test/test_event_crypto_adapter.c
+++ b/app/test/test_event_crypto_adapter.c
@@ -1625,5 +1625,5 @@ test_event_crypto_adapter(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(event_crypto_adapter_autotest,
+REGISTER_DRIVER_TEST(event_crypto_adapter_autotest,
 		test_event_crypto_adapter);
diff --git a/app/test/test_event_eth_rx_adapter.c b/app/test/test_event_eth_rx_adapter.c
index 9f8c8c1b26..2b623bfb28 100644
--- a/app/test/test_event_eth_rx_adapter.c
+++ b/app/test/test_event_eth_rx_adapter.c
@@ -1555,7 +1555,7 @@ test_event_eth_rx_intr_adapter_common(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(event_eth_rx_adapter_autotest,
+REGISTER_DRIVER_TEST(event_eth_rx_adapter_autotest,
 		test_event_eth_rx_adapter_common);
-REGISTER_TEST_COMMAND(event_eth_rx_intr_adapter_autotest,
+REGISTER_DRIVER_TEST(event_eth_rx_intr_adapter_autotest,
 		test_event_eth_rx_intr_adapter_common);
diff --git a/app/test/test_event_timer_adapter.c b/app/test/test_event_timer_adapter.c
index 2bc2e026a9..bf5ff56bed 100644
--- a/app/test/test_event_timer_adapter.c
+++ b/app/test/test_event_timer_adapter.c
@@ -2036,4 +2036,4 @@ test_event_timer_adapter_func(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(event_timer_adapter_test, test_event_timer_adapter_func);
+REGISTER_DRIVER_TEST(event_timer_adapter_test, test_event_timer_adapter_func);
diff --git a/app/test/test_security_inline_macsec.c b/app/test/test_security_inline_macsec.c
index 4043667701..a929ff5326 100644
--- a/app/test/test_security_inline_macsec.c
+++ b/app/test/test_security_inline_macsec.c
@@ -2584,4 +2584,4 @@ test_inline_macsec(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(inline_macsec_autotest, test_inline_macsec);
+REGISTER_DRIVER_TEST(inline_macsec_autotest, test_inline_macsec);
diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 04ecfd02c6..09d710eff2 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -3616,6 +3616,6 @@ test_event_inline_ipsec(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(inline_ipsec_autotest, test_inline_ipsec);
-REGISTER_TEST_COMMAND(inline_ipsec_sg_autotest, test_inline_ipsec_sg);
-REGISTER_TEST_COMMAND(event_inline_ipsec_autotest, test_event_inline_ipsec);
+REGISTER_DRIVER_TEST(inline_ipsec_autotest, test_inline_ipsec);
+REGISTER_DRIVER_TEST(inline_ipsec_sg_autotest, test_inline_ipsec_sg);
+REGISTER_DRIVER_TEST(event_inline_ipsec_autotest, test_event_inline_ipsec);
-- 
2.51.0

