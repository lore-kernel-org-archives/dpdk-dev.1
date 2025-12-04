Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB8DD29FA7
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 18:22:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A891740A72;
	Thu,  4 Dec 2025 19:21:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 776424067A
 for <dev@dpdk.org>; Thu,  4 Dec 2025 19:21:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764872469; x=1796408469;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jw38IJeuia8ayLYJzVRpRIg6H9gSEcZaxMV7arPtwQ4=;
 b=QjmP1tiPsPy8HLnXj0TZlmh5jI2xXZ64MOdpSfmN4dpONy9MBzPf/V0F
 WNJmmJgCpmuMuMWfNE1zK5Xm8HMzykrFHqjqXj6+tJc1j192BADUF7h4+
 3JHeT3Mn0FvpzF2VJ3pQQMgILqXHVcz8khugsWboryzmve1tngjyRqCBA
 sO/Z1LrQzdio9OtVhON0jCLICSf1MGwz4p3p9j1jpObmzo8G4gGIY1zOm
 H8h6V/aaB0l3qV7D3TAhHwHVGt7GrN25YBGnar79JSu1P/X64apq6mTtf
 EyUgRsLhsNuaKmx6k+b0GZ8P8AkK2ptx+xCb+Rg6sG3YqNssXpTUg/uqa Q==;
X-CSE-ConnectionGUID: M8gEyj20RD6Y/+w2lsKquw==
X-CSE-MsgGUID: HTy8fP9HTPunV4vffW8SGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78013040"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="78013040"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 10:21:09 -0800
X-CSE-ConnectionGUID: Q+qghJGnRQmEM4kpCm+GJg==
X-CSE-MsgGUID: dZWK0Br7SiqGBNPCsSH8Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="218423204"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2025 10:21:08 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 09/10] app/test: add tests to driver test suite
Date: Thu,  4 Dec 2025 18:20:46 +0000
Message-ID: <20251204182047.3154429-10-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204182047.3154429-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
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

