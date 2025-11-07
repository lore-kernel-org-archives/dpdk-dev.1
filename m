Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D9ACCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:52:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 632F440B92;
	Fri,  7 Nov 2025 16:51:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id C036F40A84;
 Fri,  7 Nov 2025 16:51:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530670; x=1794066670;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9VrZPuDd44MV9g38qiBY7ONs9cqxnNKw92NtTLyznD8=;
 b=SYsqBlt8VhZWWJzM/Oe15fH+Bjt/3aZRNXITmpbQU5ISY+PV9rtWqzBm
 6rKApf3s5uWuD1YJSjjrt16Si324NFCzfuQYSAxyhbhWNvXN4poykyZYB
 lV1Je5Ftmg334fvwbh7cBQR8GSiDlPmRVYpoVNAPsRrhVS9yfZnM+d9pn
 1M9RBD530A3YXX5gX3j1T09mHPIqPapJZNRuPTHv/xy4BnTitaV7204r3
 WiXzvVdLBP/mHknqdWjfcHiJqwikv89XXsfIkXrwLIgb3Wj/z1HE2UYBa
 7F2p7HJzu+nmR6lYkpN6IxXvGuYgEMoO3RhgpoBO7IABlODMCiH78sECi A==;
X-CSE-ConnectionGUID: Gzi4jgG3RtakLDPIBvUFgw==
X-CSE-MsgGUID: Sxp2aGx9SRKYNJmjOdDDog==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151841"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151841"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:09 -0800
X-CSE-ConnectionGUID: wEp5HUdLQV22VA4CUpllTA==
X-CSE-MsgGUID: CQxLsqHdSNa4D1DPounDWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321669"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:09 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC PATCH v2 09/33] pcapng: rename variable to fix shadowing
Date: Fri,  7 Nov 2025 15:50:05 +0000
Message-ID: <20251107155034.436809-10-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

The "len" variable is shadowed within a function, so rename inner use to
the more descriptive "filter_len" to fix the issue.

Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/pcapng/rte_pcapng.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 21bc94cea1..2cc9e2040d 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -296,16 +296,15 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 		opt = pcapng_add_option(opt, PCAPNG_IFB_HARDWARE,
 					 ifhw, strlen(ifhw));
 	if (filter) {
-		size_t len;
+		const size_t filter_len = strlen(filter) + 1;
 
-		len = strlen(filter) + 1;
 		opt->code = PCAPNG_IFB_FILTER;
-		opt->length = len;
+		opt->length = filter_len;
 		/* Encoding is that the first octet indicates string vs BPF */
 		opt->data[0] = 0;
 		memcpy(opt->data + 1, filter, strlen(filter));
 
-		opt = (struct pcapng_option *)((uint8_t *)opt + pcapng_optlen(len));
+		opt = (struct pcapng_option *)((uint8_t *)opt + pcapng_optlen(filter_len));
 	}
 
 	opt = pcapng_add_option(opt, PCAPNG_OPT_END, NULL, 0);
-- 
2.48.1

