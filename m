Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2025FC44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 12:24:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80184402CE;
	Thu, 22 Jan 2026 13:24:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 77F1A402C3
 for <dev@dpdk.org>; Thu, 22 Jan 2026 13:24:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769084649; x=1800620649;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6g5CYSH0Tzp38AxDh99oPRtGtd3C41a07xmlBQWws2c=;
 b=MBXIO8k2MWbO21oT3QHTt4PUHNOutiZIyb9cgP/oggiv8k0itDhCKwyt
 jEq20mrOqdmvzEZtIhZ8IidMd5Gf1NzGhdHpPNYwAErPkWpCQx3u+k9AS
 SDemnfCEdCKOAYvFAbrKGyYRG7QHYtY+1+Cco452X1LhXOlWSsFrlYyqj
 aV9rOQMq3Eww9qfvoIgOhU/QpffPIVhybuhjhvep/V8sKmzcB9Yw2PgS8
 QagdZ1p2a+PP5wBmBG0Jv8Kxbke+wzxPbJkwtxgpGV+guE29QL5mXqeY8
 q3dHOl97SBJCFciwYuHifP0+HR+5B924ppOsIfUUDAAzikoLCG/DYnuxj g==;
X-CSE-ConnectionGUID: 1NFzssxARYm2u0o/ScF9rw==
X-CSE-MsgGUID: 479zbbEgRyCo5EiXX8W9PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81436229"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="81436229"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 04:24:09 -0800
X-CSE-ConnectionGUID: 5LKjzm2BRkScdnKNX69PVA==
X-CSE-MsgGUID: gg7g/OsCSUe0rpSV7GFHLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="205971702"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 22 Jan 2026 04:24:08 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 1/3] test/bpf: skip some testing if null net driver not present
Date: Thu, 22 Jan 2026 12:23:51 +0000
Message-ID: <20260122122354.1820368-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122122354.1820368-1-bruce.richardson@intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
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

Some of the BPF tests require the net/null driver to be present, so skip
those tests if it's not found. If the early part of the tests fail,
return that failure - on if they succeed do we return skipped on the
missing dependency.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_bpf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index a7d56f8d86..ae588acb16 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3725,6 +3725,11 @@ test_bpf_elf_rx_load(void)
 	return ret == 0 ? TEST_SUCCESS : TEST_FAILED;
 }
 
+#ifdef RTE_NET_NULL
+static const bool have_net_null = true;
+#else
+static const bool have_net_null;  /* statics default to false */
+#endif
 
 static int
 test_bpf_elf(void)
@@ -3732,6 +3737,10 @@ test_bpf_elf(void)
 	int ret;
 
 	ret = test_bpf_elf_load();
+	if (ret == TEST_SUCCESS && !have_net_null) {
+		printf("net_null driver not available, skipping remainder of BPF tests\n");
+		return TEST_SKIPPED;
+	}
 	if (ret == TEST_SUCCESS)
 		ret = test_bpf_elf_tx_load();
 	if (ret == TEST_SUCCESS)
-- 
2.51.0

