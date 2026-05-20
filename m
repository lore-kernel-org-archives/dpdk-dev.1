Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86637CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:53:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02CCB40A80;
	Wed, 20 May 2026 14:53:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A58B540689
 for <dev@dpdk.org>; Wed, 20 May 2026 14:53:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779281599; x=1810817599;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W+wl9/mO3wyU3kMes++uY2omy2F6Ao1jYDW+CHJvAeQ=;
 b=I4EDnNHENZOyzlboO0LiVn+im80b1Bp2Nni2FFxVV+OZZoM51A01Ak4c
 mAZlM47n9A/x0qKkMq99oZT+/Czb0QmHsLre1QzqHuxlTrcZDLuPwul+p
 gOCWlpDvTU9SFfgAkowl35fnyjyJSCA+riiUyJXsnOJgKCHHdTD9CL/e3
 stFZ+G6CQdxFpt+sHDKc7Y+9+5TxouyhNlEIvdFIACEdaOFX2D/8mniN0
 yeoeLrwwq03cIm5DdZgL73I96Elt+foI6eabwnyaGVsZ7r5XU1vAwwaTW
 sAf0WPv9BMrmJ0KhGLIA+8Punc44nPzgYy2FuvHuprY6im45TI3k3/TQg g==;
X-CSE-ConnectionGUID: +eqd2rzuQwmk7FHgEAV4MA==
X-CSE-MsgGUID: Rpe5iAUtSgCtVApOYGk/Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91570274"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91570274"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:53:18 -0700
X-CSE-ConnectionGUID: FSj48EtFR8CflxZnaMJS7w==
X-CSE-MsgGUID: ecr1M6KYRg2qyRpdyeFojQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="235908283"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2026 05:53:18 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 04/10] net/e1000/base: reclassify MAC type
Date: Wed, 20 May 2026 12:52:41 +0000
Message-ID: <20260520125256.354336-5-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520125256.354336-1-ciara.loftus@intel.com>
References: <20260520125256.354336-1-ciara.loftus@intel.com>
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

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Reclassify LM19/V19 from e1000_pch_mtp to e1000_pch_adp.

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/e1000/base/e1000_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_api.c b/drivers/net/intel/e1000/base/e1000_api.c
index 7ff63414a7..a7877613e3 100644
--- a/drivers/net/intel/e1000/base/e1000_api.c
+++ b/drivers/net/intel/e1000/base/e1000_api.c
@@ -312,12 +312,12 @@ s32 e1000_set_mac_type(struct e1000_hw *hw)
 	case E1000_DEV_ID_PCH_ADL_I219_V17:
 	case E1000_DEV_ID_PCH_RPL_I219_LM22:
 	case E1000_DEV_ID_PCH_RPL_I219_V22:
+	case E1000_DEV_ID_PCH_MTP_I219_LM19:
+	case E1000_DEV_ID_PCH_MTP_I219_V19:
 		mac->type = e1000_pch_adp;
 		break;
 	case E1000_DEV_ID_PCH_MTP_I219_LM18:
 	case E1000_DEV_ID_PCH_MTP_I219_V18:
-	case E1000_DEV_ID_PCH_MTP_I219_LM19:
-	case E1000_DEV_ID_PCH_MTP_I219_V19:
 	case E1000_DEV_ID_PCH_LNL_I219_LM20:
 	case E1000_DEV_ID_PCH_LNL_I219_V20:
 	case E1000_DEV_ID_PCH_ARL_I219_LM24:
-- 
2.43.0

