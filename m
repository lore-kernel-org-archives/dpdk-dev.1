Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091A0C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2A7842E75;
	Tue,  4 Feb 2025 16:12:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6F89A42E12;
 Tue,  4 Feb 2025 16:12:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681951; x=1770217951;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aqLhpg0JIglQ/VUp1OsaPEF26Pm144Ow5tqBeJQ/vO8=;
 b=c8L6bCiyLBYcw4LhrHXOgKG6nDDgmck+nC/oDt7GwJnVZ/H90O3xjOsk
 j6q92y8P30q2F7mHZAlDkWpN8ntL5y7++VweYswySpKczHcUPhyai74V5
 3L36cIwVSZCoUvixn4WHuPaopNx9NwpicvWg8uZRCvSS+I+HiN45cy1QS
 5QKp/OLhP6L1GPMUTdiArBh7pjQBVGqTVIGKdncObFTEPcvS+VUyUVpUj
 h69T4pIIU0/yL0DXZkzaKsLA+o8eHaCGQ6zXuoSQqEOUbVVjXIXpmbnFM
 ZftUZAqxrmn0vne1OxJ7+Ptz8lQMaroGH8H+hNvyX60ZfFLshovTHp6xQ Q==;
X-CSE-ConnectionGUID: xGvbuXZdReuV/vyrrWuvFQ==
X-CSE-MsgGUID: DEfCGXVPQfCzfLGlvsYjrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097200"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097200"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:31 -0800
X-CSE-ConnectionGUID: sm/YprFUSTudBW32pxA78Q==
X-CSE-MsgGUID: 3a6+SIZ3TlmybOTXwvQLng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792785"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:29 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 49/54] net/e1000/base: fix mac addr hash bit_shift
Date: Tue,  4 Feb 2025 15:10:55 +0000
Message-ID: <feb9e5ad6ec4f5e77ab931cd7fe8b27b315ed36f.1738681726.git.anatoly.burakov@intel.com>
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

From: Loktionov Aleksandr <aleksandr.loktionov@intel.com>

In e1000_hash_mc_addr_generic() the expression:

	"mc_addr[4] >> 8 - bit_shift", right shifting "mc_addr[4]"

shift by more than 7 bits always yields zero, so hash becomes not so
different. Add initialization with bit_shift = 1, and add a loop condition
to ensure bit_shift will be always in [1..8] range.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_mac.c | 4 ++--
 drivers/net/intel/e1000/base/e1000_vf.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index 0ba03e6a04..4ec7cab7ab 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -488,7 +488,7 @@ int e1000_rar_set_generic(struct e1000_hw *hw, u8 *addr, u32 index)
 u32 e1000_hash_mc_addr_generic(struct e1000_hw *hw, u8 *mc_addr)
 {
 	u32 hash_value, hash_mask;
-	u8 bit_shift = 0;
+	u8 bit_shift = 1;
 
 	DEBUGFUNC("e1000_hash_mc_addr_generic");
 
@@ -498,7 +498,7 @@ u32 e1000_hash_mc_addr_generic(struct e1000_hw *hw, u8 *mc_addr)
 	/* For a mc_filter_type of 0, bit_shift is the number of left-shifts
 	 * where 0xFF would still fall within the hash mask.
 	 */
-	while (hash_mask >> bit_shift != 0xFF)
+	while (hash_mask >> bit_shift != 0xFF && bit_shift < 4)
 		bit_shift++;
 
 	/* The portion of the address that is used for the hash table
diff --git a/drivers/net/intel/e1000/base/e1000_vf.c b/drivers/net/intel/e1000/base/e1000_vf.c
index 7d20150b59..bb314e2f12 100644
--- a/drivers/net/intel/e1000/base/e1000_vf.c
+++ b/drivers/net/intel/e1000/base/e1000_vf.c
@@ -331,7 +331,7 @@ STATIC int e1000_rar_set_vf(struct e1000_hw *hw, u8 *addr,
 STATIC u32 e1000_hash_mc_addr_vf(struct e1000_hw *hw, u8 *mc_addr)
 {
 	u32 hash_value, hash_mask;
-	u8 bit_shift = 0;
+	u8 bit_shift = 1;
 
 	DEBUGFUNC("e1000_hash_mc_addr_generic");
 
@@ -342,7 +342,7 @@ STATIC u32 e1000_hash_mc_addr_vf(struct e1000_hw *hw, u8 *mc_addr)
 	 * The bit_shift is the number of left-shifts
 	 * where 0xFF would still fall within the hash mask.
 	 */
-	while (hash_mask >> bit_shift != 0xFF)
+	while (hash_mask >> bit_shift != 0xFF && bit_shift < 4)
 		bit_shift++;
 
 	hash_value = hash_mask & (((mc_addr[4] >> (8 - bit_shift)) |
-- 
2.43.5

