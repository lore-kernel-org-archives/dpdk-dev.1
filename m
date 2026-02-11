Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2377E9E30C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:54:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FB2C40A73;
	Wed, 11 Feb 2026 14:53:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0C77B4068A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818021; x=1802354021;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=o5rBcxLnkdoGn86YmiecJgJTaHQm/7eIsZiUKQaI9kI=;
 b=KhPV1yXSiZspcxd5xL8Ff0Wc2vwphG4ahCKOqGOWj76R1JHXxVdVgXmY
 dpS7VGcxKGleeYrfgzur9MM8eudEKR6+Cv5HIokwFeXaNQZcLp/M5BdLs
 FHxe36/N7P216bPktVywy6xcTtwjSIqnsM7ig+H4H/KrIQlwLaa+2Xb+t
 8R3kpenxFjF0fsX2IGb6hgkwZNMJOpJDPk3wHZiHIbgkSkvAWRtfT4M1G
 IzNWn1Vn67qDlfB0mYIp0s2GCDhxayqV2iVXgLgcnd8ozlP9sUD1v990g
 t1crgqFbgIElHZ6i86RvkeXRmWVb4E1pB0M3wJAXWjNudT1/PE/gAaqWP g==;
X-CSE-ConnectionGUID: pv3E8x2zT5GgNtAajutZCA==
X-CSE-MsgGUID: FFFGOqj2RjisYVXcalvP1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808235"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808235"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:40 -0800
X-CSE-ConnectionGUID: NVf4tgRbQCuEOdMb8fRhGQ==
X-CSE-MsgGUID: UgbTuOyZSryehT48iYxwww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359577"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:40 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 07/27] net/i40e: use proper flex len define
Date: Wed, 11 Feb 2026 13:52:49 +0000
Message-ID: <e7922c5c197a377d38c1a896c4576434759092fd.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
References: 
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

For FDIR, we have byte arrays that are supposed to be limited to whatever
the HW supports in terms of flex descriptor matching. However, in the
structure definition, spec and mask bytes are using different array length
defines, and the only reason why this works is because they evaluate to the
same value.

Use the i40e-specific definition instead.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index d144297360..025901edb6 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -631,7 +631,7 @@ struct i40e_fdir_flex_pit {
 /* A structure used to contain extend input of flow */
 struct i40e_fdir_flow_ext {
 	uint16_t vlan_tci;
-	uint8_t flexbytes[RTE_ETH_FDIR_MAX_FLEXLEN];
+	uint8_t flexbytes[I40E_FDIR_MAX_FLEX_LEN];
 	/* It is filled by the flexible payload to match. */
 	uint8_t flex_mask[I40E_FDIR_MAX_FLEX_LEN];
 	uint8_t raw_id;
-- 
2.47.3

