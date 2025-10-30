Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC22CCF9E5
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 04:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5072402F0;
	Thu, 30 Oct 2025 05:53:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4C5A44027A
 for <dev@dpdk.org>; Thu, 30 Oct 2025 05:53:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761799983; x=1793335983;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HcQtSAFRmZF1ysuC7zjgwuT9wGRDIy+hVI0TRXFPpV8=;
 b=W5dDPQh8ZY9WJ9247Xvl+SoE9BVg76v0qBe5jrAmqzjZ+y0n347W6PpQ
 b5adcIj350YBl0Ot7c1corebLJnopI9oyTsNbbesuX+/II1OHdXkpeRdL
 zCwoFux06rfn75PQ2WFtEHUDjAfVrxftvqRjels//35sp9+JYLUfvNE8O
 NAXmU6TUv7zVhWr2VfZUg9Lb41EejtAQpAC89RNnsT+lXcgqblFAB87Ze
 dFXJ5/byGPLAszTYxKsDvYqiEAViZRQERMnN4Cwl6oPO/R/CeGN1FQd3L
 IHnF/Lf+FhOOOFTwoiCrUodztpfFywoM5wjZxLiu14yz94TG2R0bsv/rK A==;
X-CSE-ConnectionGUID: vk5bDf0yR7m4ZlUh910z1Q==
X-CSE-MsgGUID: 4Rt/Q3K4QLWTSqt9FARXQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74225245"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="74225245"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 21:53:01 -0700
X-CSE-ConnectionGUID: 1NGK+jL2RLuyAZ9cGkS9AQ==
X-CSE-MsgGUID: 9WkqInZhQVaJlYoenpeeQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="185733119"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2025 21:52:58 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com, ciara.loftus@intel.com
Subject: [PATCH v2 0/3] Update TxPP feature
Date: Thu, 30 Oct 2025 13:33:01 -0400
Message-ID: <20251030173304.260209-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251027182801.191295-1-soumyadeep.hore@intel.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
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

Fix bugs in TxPP implementation and update the documentation
for the same.

---
v2:
- Addressed Ciara's comments
---
Soumyadeep Hore (3):
  net/ice: restrict ice PMD to scalar path for TxPP
  net/ice: fix PTP clock corruption with TxPP
  doc: update TxPP documentation

 doc/guides/nics/ice.rst                     | 4 ++++
 drivers/net/intel/ice/ice_rxtx.c            | 2 +-
 drivers/net/intel/ice/ice_rxtx_vec_common.h | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.47.1

