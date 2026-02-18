Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B42CE9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:51:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 052F540678;
	Wed, 18 Feb 2026 10:50:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id CECBF40657
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:50:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771408212; x=1802944212;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xPLe4ozF1lUMl/v2hnDlnsXDey3GEaBmCCQv3WktsrQ=;
 b=L/TCbXJJoqNAfBWMqZHbDhlxfWjFDSwU6zMW0lJy/X7gJTMSRlO2Gsg3
 +28xT6a3aemiHhoJtaZeNMRHoXMSnSNoYu5C7L6EgUmBMlByv7nsjOint
 JUV3i/5JxFeOf95Kh3Ci/NTBhUtcuB2dFY2c/yLpzeM+pw5hJPm6v0CDs
 4yf/pqomo9F+cr8nTGtOxAs0/F3MivnKeaMin8nquoF+GPLukdcS0qAQN
 Vu+ReFK85vd+D9b5z0CllHTN0sfbcEDXcTTL1hF4f3rRT5t1vVDFFSpiG
 p39O+Q5llQsnQe/nElD8H7mu9rpaMaMxa2LRr9+tGDajItLMDPrUbBGKD w==;
X-CSE-ConnectionGUID: r3ButtULTlOoHzjJioriqQ==
X-CSE-MsgGUID: D81p4yLqT6+lGIEXKpXMqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83929850"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83929850"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 01:50:12 -0800
X-CSE-ConnectionGUID: lJmu/hj+TZGJrMxSpFJc/w==
X-CSE-MsgGUID: TDtvncjYR7+o8DaW4yLYjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214257134"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 01:50:10 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 09/10] net/idpf: permit secondary process Tx path selection
Date: Wed, 18 Feb 2026 09:49:36 +0000
Message-ID: <20260218094937.1652391-10-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218094937.1652391-1-ciara.loftus@intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
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

Commit 7cab7e67363a ("net/idpf: use common Tx path selection
infrastructure") changed the way that secondary processes selected their
Tx burst function. Instead of letting secondary processes select their
own function, they now used the function selected by the primary
process. However, the primary process only selects the function at
device start, so if the primary process hadn't started the device by the
time the secondary process was selecting its Tx burst function, the
secondary process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 7cab7e67363a ("net/idpf: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/idpf/idpf_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 81bcc08126..d387650719 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -875,8 +875,8 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 		.simple_tx = simple_allowed
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-- 
2.43.0

