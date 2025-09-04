Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C17CA1002
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 10:44:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B74C40697;
	Thu,  4 Sep 2025 12:44:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9C93E4027D
 for <dev@dpdk.org>; Thu,  4 Sep 2025 12:44:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756982689; x=1788518689;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yHDMZEiKrVGXPOPgwqdiJqmUTbfpwuonfxrxHNpB8Z0=;
 b=Z2s2A+JS7DxkD382IZmfb/ijRUQP1C5FwHpd+3rWaiPpMu+yafY2t0zu
 XbzBbW8TJszDPq1OFNwlVzaNACSm1LztlEDgJlfRbjlRxqymOlCy/Ejoe
 0vKoyt3Dlw6CdxbblF0EbpY1ipxBroj+JGMQ430anb071Ae7RLs+c2Q1a
 pCyyRRvr4aQ02Dldoo1Z+W9U4MTalwuVFEIE6pmm+0mb6kSbl6hJZr3BQ
 vnw5ijo1dDYN77cCiNGFyzkDpGRXIUVWXIIc52fcQVhU4id4IrXZTKq2L
 4EzWTTA+pKOLFx5Dkn0Gca9qwhSV5eWyc3vN9QhumrAR5KwtDNpRi6ibr Q==;
X-CSE-ConnectionGUID: EKSAarasR4WZ9NuWAVoY1Q==
X-CSE-MsgGUID: O4Df2dVuQECJv3A56TN/RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59463067"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="59463067"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 03:44:47 -0700
X-CSE-ConnectionGUID: o2IQjDGERfqBEe0wEmQUlg==
X-CSE-MsgGUID: h16KvesKQMOGmvfc0HLowA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="195512078"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa002.fm.intel.com with ESMTP; 04 Sep 2025 03:44:46 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/3] Fixes for iavf Tx path selection
Date: Thu,  4 Sep 2025 10:44:37 +0000
Message-Id: <20250904104440.2167205-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

This is a series of fixes for the iavf driver concerning Tx path
selection. The first patch fixes the logic for selecting the Tx
vector path, which was recently fixed but broken again by another
commit. The second patch updates a log and the third ensures the
fastest path is selected for VLAN offload regardless of VLAN tag
location (L2TAG1 or L2TAG2).

Ciara Loftus (3):
  net/iavf: fix Tx vector path selection logic again
  net/iavf: fix a log during Tx path selection
  net/iavf: fix Tx path selection for VLAN offload

 drivers/net/intel/iavf/iavf_rxtx.c            |  4 ++--
 drivers/net/intel/iavf/iavf_rxtx.h            |  1 -
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 23 +++++++++++--------
 3 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.34.1

