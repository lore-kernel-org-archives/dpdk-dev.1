Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B74CC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:10:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F0FE411F3;
	Thu,  6 Feb 2025 17:09:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id CC35640E4F
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858165; x=1770394165;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=n0q/biA6YQw81NkXtYtg/XxtSwH375HIv4hjyB2Ur3o=;
 b=EvJNUEZTQ3nIfh6e66nJU8NlAZg+65RILgdWs1urfZvWFN5mA97E+0gb
 MK0YxTP/5rzYQghphjEBvnDE399lRthhzlnt64dc/E8TWxlDno7qWmMzL
 TmPDr0+qwiZ7j2vrcll74ecnMIMSAjCR6jgYz+AP1Kv5Aj5W6cDuk+5Y+
 m50ZSBU34BcAzRZloaQJYShIllHkSjAyC7MdO5cy6h94DramIRCcueP4X
 txf/B3bThOALVJodwQemRY+mfoKvO0OGzsk0rFOgY0QeqoRLDCMwVDiAs
 VE9g2M7lJehh3Pb7Oz5xhe5pAdBPBDdpgR2uel3aOcZS/crvYqbctckaM Q==;
X-CSE-ConnectionGUID: JBKEX6M/S5KlCV/x9EUFow==
X-CSE-MsgGUID: 7t2ILYN4TsCq7K3XjTZmJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860761"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860761"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:24 -0800
X-CSE-ConnectionGUID: bJF5lF5HRQ+wKvP65KqoFA==
X-CSE-MsgGUID: csq+AQsfRIWMBY0zLaQhdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166796"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:23 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 17/24] net/e1000/base: fix MAC addr hash bit shift
Date: Thu,  6 Feb 2025 16:08:40 +0000
Message-ID: <2875edd08be71a243a1a0666616ec806b85dbe66.1738858026.git.anatoly.burakov@intel.com>
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

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_mac.c | 4 ++--
 drivers/net/intel/e1000/base/e1000_vf.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index cf0a9f21e1..2b8482e114 100644
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
index 44ebe07ee4..3d0383fcbb 100644
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

