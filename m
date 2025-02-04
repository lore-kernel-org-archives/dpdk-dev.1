Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD332C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F2CC42E8E;
	Tue,  4 Feb 2025 16:12:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B5B6B427DA;
 Tue,  4 Feb 2025 16:12:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681956; x=1770217956;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pMigtNfhufy1sMcPxAL8ocGnnqnQkPoDFrNXq9LfbwU=;
 b=h54jaXvnhMDoJ7TgRuj7TuK2Z11Cl3uK8FHapq5zwhw8OL5zi9x/M6N8
 ZJI/DHzLsAiPu2IZqS7V+vfzZ4K1oz0nOVfFWz9/D2P2SbOkZ52/3zrJi
 r+o9WbwMvMr/PVppVU55rsEMy3OT7L/+bSKci+eGLL6UULX7uhQLXGqh/
 GxNUzxvND2aD3jAyZqwOgIvECAk+Gnh37OGbpUaen3NSTj28///1LzjV7
 Qk5eg98f4PHkoemZJqPYBi4iFF7Jovy5/DIKN39zgV+flue/BUn/6Mmss
 vOFq8yi8ZamHLQG7CReIY9VF3/MM1lA93FyoQFz6BJaAFeNokprq9riUZ w==;
X-CSE-ConnectionGUID: SjzqjffGTEC+aL6dWedidg==
X-CSE-MsgGUID: OKZiQv+KS0CBnaxMpm4VZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097210"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097210"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:35 -0800
X-CSE-ConnectionGUID: n+JIcLmzRMahqVSq5vrpMw==
X-CSE-MsgGUID: g/mGIfe4Qf+CQacNXvjiXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792797"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:33 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 52/54] net/e1000/base: fix data type in MAC hash
Date: Tue,  4 Feb 2025 15:10:58 +0000
Message-ID: <e166fba269dc7d6a1ac2aa810f2ab7b1c1d4f400.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

From: Barbara Skobiej <barbara.skobiej@intel.com>

One of the bit shifts in MAC hash calculation triggers a static analysis
warning about a potential overflow. Fix the data type to avoid this.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Barbara Skobiej <barbara.skobiej@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_mac.c | 6 ++++--
 drivers/net/intel/e1000/base/e1000_vf.c  | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index 4ec7cab7ab..2fa97d12a9 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -541,8 +541,10 @@ u32 e1000_hash_mc_addr_generic(struct e1000_hw *hw, u8 *mc_addr)
 		break;
 	}
 
-	hash_value = hash_mask & (((mc_addr[4] >> (8 - bit_shift)) |
-				  (((u16) mc_addr[5]) << bit_shift)));
+	hash_value = (u32)mc_addr[4];
+	hash_value = hash_value >> (8 - bit_shift);
+	hash_value |= (((u32)mc_addr[5]) << bit_shift);
+	hash_value &= hash_mask;
 
 	return hash_value;
 }
diff --git a/drivers/net/intel/e1000/base/e1000_vf.c b/drivers/net/intel/e1000/base/e1000_vf.c
index e0c95aa130..b02459900b 100644
--- a/drivers/net/intel/e1000/base/e1000_vf.c
+++ b/drivers/net/intel/e1000/base/e1000_vf.c
@@ -345,8 +345,10 @@ STATIC u32 e1000_hash_mc_addr_vf(struct e1000_hw *hw, u8 *mc_addr)
 	while (hash_mask >> bit_shift != 0xFF && bit_shift < 4)
 		bit_shift++;
 
-	hash_value = hash_mask & (((mc_addr[4] >> (8 - bit_shift)) |
-				  (((u16) mc_addr[5]) << bit_shift)));
+	hash_value = (u32)mc_addr[4];
+	hash_value = hash_value >> (8 - bit_shift);
+	hash_value |= (((u32)mc_addr[5]) << bit_shift);
+	hash_value &= hash_mask;
 
 	return hash_value;
 }
-- 
2.43.5

