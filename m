Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53640E9A057
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:40:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CA6840616;
	Thu, 19 Feb 2026 18:40:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7F9D44042E
 for <dev@dpdk.org>; Thu, 19 Feb 2026 18:40:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771522806; x=1803058806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rBBVhKx/MGsavVwPU8MmyPTSouoikPOf1n3Nrl5QYpk=;
 b=mOsuE/5BADLQzmqfaIf4h4kkRpgzZ2vF5+wSTbgRELY1E0/+mh9V+q/h
 LPRzIh+ix8w8m50LfPV6taezdptHNPGnn5zgrEPLMwgPFX2U5CkcjbTGN
 Yr9rxCcolXP3ZBBtQF/O66zhor3gfv8S7rhYKcY05voaHfqlvRlQpqFE7
 M+4jdEqhx1d59kSYUJ9tBgZWg6Sizc5A/CbQ9+uEpZPpXNNkwRj20vFUe
 AKi/iUruM9kb4/cSr/UHbRBZOig6f3a9l5YRYwvnd4FMVSYEHa+eQGiaG
 6QJtUW2AC3exdivASjubzb+0Qaqc+C8g1VVQJTEiQI8Wsf/M2neVg8P9c w==;
X-CSE-ConnectionGUID: 5XnolFyaT1CM1wXfgJ6OcA==
X-CSE-MsgGUID: sFxH2PsgSGqEUmVQVqW7tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72518116"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="72518116"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 09:40:05 -0800
X-CSE-ConnectionGUID: Uvrcs6z+ROGTrIE9zQQnEQ==
X-CSE-MsgGUID: iMOAth0RQbycavzi9G/SFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="212803301"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 19 Feb 2026 09:40:04 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>
Subject: [PATCH v2 2/4] test/event_eth_tx_adapter: remove dependency on NULL
 PMD
Date: Thu, 19 Feb 2026 17:39:51 +0000
Message-ID: <20260219173953.2182757-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219173953.2182757-1-bruce.richardson@intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260219173953.2182757-1-bruce.richardson@intel.com>
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

The eventdev eth Tx adapter only uses the net_null driver for the final
test case within the suite. Rather than adding an explicit dependency on
that driver, just report the last case as skipped if not present.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_event_eth_tx_adapter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/test/test_event_eth_tx_adapter.c b/app/test/test_event_eth_tx_adapter.c
index a128a4f2c2..bec298a8b8 100644
--- a/app/test/test_event_eth_tx_adapter.c
+++ b/app/test/test_event_eth_tx_adapter.c
@@ -937,6 +937,7 @@ tx_adapter_set_get_params(void)
 static int
 tx_adapter_dynamic_device(void)
 {
+#ifdef RTE_NET_NULL
 	uint16_t port_id = rte_eth_dev_count_avail();
 	const char *null_dev[2] = { "eth_null0", "eth_null1" };
 	struct rte_eth_conf dev_conf;
@@ -977,6 +978,9 @@ tx_adapter_dynamic_device(void)
 		rte_vdev_uninit(null_dev[i]);
 
 	return TEST_SUCCESS;
+#else
+	return TEST_SKIPPED;
+#endif
 }
 
 static struct unit_test_suite event_eth_tx_tests = {
-- 
2.51.0

