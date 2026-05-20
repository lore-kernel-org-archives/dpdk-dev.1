Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67D4CD4F5E
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 06:10:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB59C40276;
	Wed, 20 May 2026 08:10:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8B4724025E
 for <dev@dpdk.org>; Wed, 20 May 2026 08:10:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779257444; x=1810793444;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=kmENOwv9AGQ4WpdDFagluRKT9wvtsUT+xefh1fE8Qb0=;
 b=YmIJtQ2Irzu8gGq5O1eQuRI6KobnvkKu5aUCZfmBfWbs5wnyXYU2aFIq
 SQJQRGUMoZ2wxE4LYT1BVcWJI+Popr0x0Mx8s+W1HWiitYfRidKUjAnNj
 agx4n9VCO9iezNEJkYaZm2FFrbulxo94j6gMVLQrsL5tRHo6LoV58hMY7
 SINwsi5kTvEaHCL2tKNRfqyly+cD12AYcuzOCi77XIN15rcBE0DM7nnhD
 yGH5KEku3MDCMB/WdtKEVFp3yhRtFmpqhI1ygTt9eGwL51pcSioreO8cC
 Gmtdq3TIiEZVZ2TCGHaabebm9/To8JRL/yyvvmVTRSMuszZM1ItZE0gSJ A==;
X-CSE-ConnectionGUID: KmMhz2VbRti2OSmc/FtJfQ==
X-CSE-MsgGUID: Ptol5LuARl+Xs6ljJ+YXfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80203410"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80203410"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 23:10:30 -0700
X-CSE-ConnectionGUID: S7Oc+zMlSvqKXMZRhK1COA==
X-CSE-MsgGUID: x+TOX0P7RmG6gWnIybqipA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="240093500"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa009.jf.intel.com with ESMTP; 19 May 2026 23:10:27 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Subject: [PATCH v5 0/2] Update Rx Timestamp in IAVF PMD
Date: Wed, 20 May 2026 14:43:48 -0400
Message-ID: <20260520184350.81934-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260509101447.42093-3-soumyadeep.hore@intel.com>
References: <20260509101447.42093-3-soumyadeep.hore@intel.com>
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

PHC Polling from Rx Datapath is removed and existing alarm handlers are
used to fix latency issues in IAVF PMD.
---
v5:
- Addressed Bruce's comments
---
v4:
- Addressed Bruce's comments
---
v3:
- Addressed AI code reviews
---
v2:
- Fixed patch apply issues
---

Soumyadeep Hore (2):
  net/iavf: reuse device alarm for PHC sync
  net/iavf: remove PHC polling from Rx datapath

 drivers/net/intel/iavf/iavf.h                 |   6 +
 drivers/net/intel/iavf/iavf_ethdev.c          | 168 ++++++++++++++++--
 drivers/net/intel/iavf/iavf_rxtx.c            |  34 ----
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  16 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  16 +-
 drivers/net/intel/iavf/iavf_vchnl.c           |   4 +
 6 files changed, 168 insertions(+), 76 deletions(-)

-- 
2.47.1

