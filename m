Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407B6E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:42:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A3540654;
	Wed, 18 Feb 2026 17:42:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1FA2640275
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:41:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771432910; x=1802968910;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m5N1qaIHED/b4NR+SmUhuVP+RmMf5Aq+gl8DGUqsoc0=;
 b=WESBEPMCeYzg1o5qNRN0t4wfMNgYkWOtxaoy+kdnRr3aaCUBjTaF/MME
 sFa/5R7KkxVhykTQb6lMRT9sq9gc8kCHDYcrezGNOmfxKJTebGank1BPZ
 +ETnYrp5HOgCqkMTxXbRaUnDzZFj9YKGCEoYEWbOGE2Ca0CrwARP94F4t
 E7IMFhj0mu0HsYf6dsdsTXWXOX7F604EY0ZAU66Hmr7Ht03Qr2mVpBjZh
 rs6XphsB1kGloQ/U2odBIviABH/08smeSPuN58LWHilahISRvz0A3RoJe
 4Zxn33GZugwgk29Xt7vW1yGZvVj39J75pMeU5Q8q/+ERm0tVYBIc9Td2f Q==;
X-CSE-ConnectionGUID: zYsDsAXmTk6ytaJbzN1esw==
X-CSE-MsgGUID: IYN5Cbr5RgGfodiEKoUN5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72601865"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="72601865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 08:41:50 -0800
X-CSE-ConnectionGUID: JONIMCUvSey6BQ4Oc70iww==
X-CSE-MsgGUID: DvLEWs59Q0OsFbKkLw9yiQ==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 18 Feb 2026 08:41:48 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v6 6/8] net/ice: add L2TPv2 hardware packet generation
Date: Wed, 18 Feb 2026 22:07:48 +0530
Message-Id: <20260218163750.1408973-7-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218163750.1408973-1-shaiq.wani@intel.com>
References: <20260202094244.447966-2-shaiq.wani@intel.com>
 <20260218163750.1408973-1-shaiq.wani@intel.com>
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

Add L2TPv2 packet type cases to ice_fdir_get_gen_prgm_pkt() to enable
hardware packet generation for FDIR rule programming.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 drivers/net/intel/ice/base/ice_fdir.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_fdir.c b/drivers/net/intel/ice/base/ice_fdir.c
index f62313c559..2c0cb99854 100644
--- a/drivers/net/intel/ice/base/ice_fdir.c
+++ b/drivers/net/intel/ice/base/ice_fdir.c
@@ -4027,6 +4027,9 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 				   ICE_NONDMA_TO_NONDMA);
 			loc = &pkt[ICE_FDIR_V6_V4_GTPOGRE_EH_PKT_OFF];
 			break;
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_CONTROL:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP:
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4:
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_UDP:
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_TCP:
@@ -4038,6 +4041,9 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 						      idx, offset, tun);
 			loc = &pkt[pos];
 			break;
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_CONTROL:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP:
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4:
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_UDP:
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_TCP:
-- 
2.34.1

