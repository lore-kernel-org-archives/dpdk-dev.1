Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FA2C02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:10:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89A7E410E6;
	Thu,  6 Feb 2025 17:09:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id E1C1140E41
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858157; x=1770394157;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=NrkprsQHEdVfbV0axmDkPA4fiUYReRoVnCmO3vdLZh0=;
 b=DqK7GWJ2sxeAwx+Ud1vi6CoU5saXbONJN7iqGG39h0VVekV9qtMw5bff
 FWGjPlABfKlQuUxu6AI+NYfTLvXjE3Vzq9O/UQ3TBiqtm886wMnZozSGy
 FEBR+u9kcD4A9rPZy4r/tu8TmUhDAVhJ/ZLNkEGtjrJX1ZCbtPdols2oZ
 anSk5sylCwXeqT1uEyhSH/yOx+mwE/E0gyNhpAoKilAAYXTru2M6z1EcP
 Im/k+iMjv3gpoPWn8iztQmObE/AkUsR0KI2nmM5S+0GFxgegXrDYadxbJ
 y41WxWu2QdJETN+BDxNasq0ogMJqoWeA4tW58bauEMlZEOY6vvBLgRVYL A==;
X-CSE-ConnectionGUID: fZLbokRGSTGsI98us7/JLA==
X-CSE-MsgGUID: MBz6BufNRSqoG7LffeB8nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860733"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860733"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:16 -0800
X-CSE-ConnectionGUID: W0ondnBSQlWvZS2s8qqHow==
X-CSE-MsgGUID: NTvdEjtuTUSl+XkOSBDIbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166751"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:15 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Alvin Zhang <alvinx.zhang@intel.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH v1 11/24] net/igc/base: fix MAC addr hash bit shift
Date: Thu,  6 Feb 2025 16:08:34 +0000
Message-ID: <d678a977b168d9970311a3ad3a0638504d8561a2.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
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

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

In e1000_hash_mc_addr_generic() the expression:

        "mc_addr[4] >> 8 - bit_shift", right shifting "mc_addr[4]"

shift by more than 7 bits always yields zero, so hash becomes not so
different. Add initialization with bit_shift = 1, and add a loop condition
to ensure bit_shift will be always in [1..8] range.

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/igc/base/igc_mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/igc/base/igc_mac.c b/drivers/net/intel/igc/base/igc_mac.c
index 3cd6506e5e..c69f8ac73b 100644
--- a/drivers/net/intel/igc/base/igc_mac.c
+++ b/drivers/net/intel/igc/base/igc_mac.c
@@ -486,7 +486,7 @@ static int igc_rar_set_generic(struct igc_hw *hw, u8 *addr, u32 index)
 u32 igc_hash_mc_addr_generic(struct igc_hw *hw, u8 *mc_addr)
 {
 	u32 hash_value, hash_mask;
-	u8 bit_shift = 0;
+	u8 bit_shift = 1;
 
 	DEBUGFUNC("igc_hash_mc_addr_generic");
 
@@ -496,7 +496,7 @@ u32 igc_hash_mc_addr_generic(struct igc_hw *hw, u8 *mc_addr)
 	/* For a mc_filter_type of 0, bit_shift is the number of left-shifts
 	 * where 0xFF would still fall within the hash mask.
 	 */
-	while (hash_mask >> bit_shift != 0xFF)
+	while (hash_mask >> bit_shift != 0xFF && bit_shift < 4)
 		bit_shift++;
 
 	/* The portion of the address that is used for the hash table
-- 
2.43.5

