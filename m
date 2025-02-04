Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F947C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:14:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAD2F427CC;
	Tue,  4 Feb 2025 16:12:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2F76C410FB
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681915; x=1770217915;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DbyiQlNe36sZbXIRrfSHSQilwsi4wijIEi7wQJE19HQ=;
 b=KdHTYdxPN/XYltzSm9uPGizz2WktLstRpHE7+z4+ELOUnOUGkzA8gH8G
 55IZQlDF7B+ZAjaJ0pUDlXaAl/N11QgxjQ8C6WbKCHnxZGFvha4BAopdN
 U3pkSZGmCDKjFzpQsEjxDTBzTCO1SBUKCc9J25lFD7z6b6r/2WWOyfrnG
 GBPOuStkHDKDlwoAjuYKcxzU05GFzVvHUX2Je+jhU7OAAL+mfiro0vl4V
 P1IVXzYfZ7QBbUxV7bZrN4QWWQh/1VYOUX/YLdBrIhUaGiWn0jqviCSIg
 aXkeQeKpG/H1ZhVpLq/FXhxYj8iwFu2U8w2FVrL3nQ/i+KuR7gQqU/xN/ w==;
X-CSE-ConnectionGUID: F4TKW+JzSU2mQ09Bh4JzNA==
X-CSE-MsgGUID: POzbUb/VRH6zpIUsE+uv1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097128"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097128"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:54 -0800
X-CSE-ConnectionGUID: gDkDP2VVQUOf/HhtJ+eG1w==
X-CSE-MsgGUID: DARJyxxnTq+s7V4Tjg40Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792659"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:53 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 21/54] net/e1000/base: fix LTR for i225
Date: Tue,  4 Feb 2025 15:10:27 +0000
Message-ID: <bbaac0d5edc45ac926aadbe029bf46d4fea9e358.1738681726.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

i225 specification recommends minus 1 microsecond from a value
calculated for a LTR. Fix the calculation to match spec.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 999fa03a3d..0b029c0ac2 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -982,7 +982,9 @@ static s32 e1000_set_ltr_i225(struct e1000_hw *hw, bool link)
 		scale_max = (ltr_max / 1024) < 1024 ? E1000_LTRMAXV_SCALE_1024 :
 			    E1000_LTRMAXV_SCALE_32768;
 		ltr_min /= scale_min == E1000_LTRMINV_SCALE_1024 ? 1024 : 32768;
+		ltr_min -= 1;
 		ltr_max /= scale_max == E1000_LTRMAXV_SCALE_1024 ? 1024 : 32768;
+		ltr_max -= 1;
 
 		/* Only write the LTR thresholds if they differ from before. */
 		ltrv = E1000_READ_REG(hw, E1000_LTRMINV);
-- 
2.43.5

