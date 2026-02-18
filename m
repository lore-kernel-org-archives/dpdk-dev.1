Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6255E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF7C340656;
	Wed, 18 Feb 2026 10:50:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 072F140395;
 Wed, 18 Feb 2026 10:50:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771408207; x=1802944207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zZ4H6c7r8qXKXIpOMN81nJiq/aahv8aNjU8fKIdCQvg=;
 b=ZDLjcMhN2gjQ5m2B3UmB00hJbABGlNEgBrukBwH5SYPurJdtbCnxzGBX
 JMiwlibaxrmDiJTjGXzExTjzGjzMjp/EyOAXfAPSlIjd+w7mTuf65Ecfs
 P2SGA1phaD0aX13eylGnuHteYs456jlsHQ/k1wh2dwxpGzMdSyDbGcEz5
 YLReY/iClex7ES+Awk3Zcm7QyuM9gH1qM28HtPiZVEurD04pLUAYWhUNH
 sAAYsYIghOoEEHsay9t1xg0SrSKBsHtd2iADaQivj3CuIzk5PxabIhcjz
 DZw/bEmJqlBy/IIMMtxNptO8fGUEC8MiLmkLuixxWaVLJdHtuSMnoGibk g==;
X-CSE-ConnectionGUID: 390QaMMSQZ+B+5fE3C5lsg==
X-CSE-MsgGUID: a+FpRJl5T9COnFsOCE5TCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83929844"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83929844"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 01:50:07 -0800
X-CSE-ConnectionGUID: z8fFVgUhSoqL0QsH9pgmgw==
X-CSE-MsgGUID: WSAx9O9ISB+RzAIWtUC1tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214257084"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 01:50:05 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v3 03/10] net/ice: permit secondary process Rx path selection
Date: Wed, 18 Feb 2026 09:49:30 +0000
Message-ID: <20260218094937.1652391-4-ciara.loftus@intel.com>
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

Commit 197e70fb8961 ("net/ice: use same Rx path across processes")
changed the way that secondary processes selected their Rx burst
function. Instead of letting secondary processes select their own
function, they now used the function selected by the primary process.
However, the primary process only selects the function at device start,
so if the primary process hadn't started the device by the time the
secondary process was selecting its Rx burst function, the secondary
process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 197e70fb8961 ("net/ice: use same Rx path across processes")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 321415d839..637c57b209 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3371,8 +3371,8 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 		.simd_width = RTE_VECT_SIMD_DISABLED,
 	};
 
-	/* The primary process selects the rx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-- 
2.43.0

