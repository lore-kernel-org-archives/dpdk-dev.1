Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2EECA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 13:10:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BC4E4064A;
	Mon, 28 Sep 2026 15:10:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id D0B8740275;
 Mon, 28 Sep 2026 15:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790601058; x=1822137058;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LPq4fI1mnPfv8c6H1a5bZuPkq1RM48dSpBCTSbRPbXc=;
 b=jz+8t8NeuxFg5lbTpcdJt3HG9pBEaczl9W0ixsMvUPo9bcQ1jUlURhNF
 3NcA3u6UvxnpxBbfrLa3DBITRqx4cUhWO4FTNWx8GezL78eG70JpPLg9K
 MPEVpFce/r1GYYC/EQWIY2U8NkV8eWZWhCHqanf4BgLEP2gyWt4/ID85P
 DrjNsr4LBkxofDeRa1GbBIx2XWDrupkkWyKvCwXCyEfCCxDHBJFWk5pWq
 agg1oxStjeUTenfjV210EQTLtS/qHs/MuM9xXmBiYx9/67HL/URHxrRxk
 5oBHCBEljauOguzh3BES9njHNh7erjj2hXfm7rxSxLGgubMYLGkozJlls g==;
X-CSE-ConnectionGUID: 2IYiQr08RE2xYSpZcKPI5g==
X-CSE-MsgGUID: DUwVWkXpQAycDh7AZVnG8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90351031"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90351031"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 06:10:56 -0700
X-CSE-ConnectionGUID: fMWXlppuR+yFMQKldEZrTA==
X-CSE-MsgGUID: qA7scHHQT0yDvp3WuHUh+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="275173037"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2026 06:10:53 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v2] net/ixgbe: fix null dereference on EEPROM write for E610
Date: Mon, 28 Sep 2026 16:12:53 -0400
Message-Id: <20260928201253.45484-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260928165054.20913-1-sandeep.penigalapati@intel.com>
References: <20260928165054.20913-1-sandeep.penigalapati@intel.com>
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

E610 does not support EEPROM writes and leaves eeprom.ops.write_buffer
as NULL. ixgbe_set_eeprom() calls this pointer without checking it,
causing a NULL pointer dereference when a set-eeprom request is issued
on an E610 port.

Check the op for NULL and return -ENOTSUP instead.

Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
v2:
 - Moved the NULL check before the argument validation so an
   unsupported request returns -ENOTSUP instead of -EINVAL.

 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 78e19f94c0..b7b2b92e3c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -7362,6 +7362,9 @@ ixgbe_set_eeprom(struct rte_eth_dev *dev,
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return -E_RTE_SECONDARY;
 
+	if (eeprom->ops.write_buffer == NULL)
+		return -ENOTSUP;
+
 	first = in_eeprom->offset >> 1;
 	length = in_eeprom->length >> 1;
 	if ((first > hw->eeprom.word_size) ||
-- 
2.27.0

