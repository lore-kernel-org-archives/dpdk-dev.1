Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F6A10ED664
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 13:05:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EA79402C5;
	Fri, 27 Mar 2026 14:05:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id EEE2D40280
 for <dev@dpdk.org>; Fri, 27 Mar 2026 14:05:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774616710; x=1806152710;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9y7v7lXQ/srJ7Lkt7LVA64wAfsVh8hBJsMXmbQomZRE=;
 b=AqMtMCOB8kyH0VoeDt6CBc/9fcr2H95MQIXav498LuHQqyji5vj8yeDX
 1hW4thjXOQfDn/BVNdJP7CBhR4MtoHKS3rDp2DmRRI/MbSJMkCHs6aLNs
 PzJ00Wa24MzDB8jUm+IOBIDZlgK1uslLSGddtQ7yfNCNtr/31u6vC0wk/
 30wzwy2STXeiDwpgDh9luNaTi6Oc3HDCK0gTdVKVTfYbZMnZLLxNnXFtC
 FuEcBbMWg6LVQT8Yl5Ru/kiUFy2NFlDAxETQYArUt+qn8815bUh5witfk
 7T8MsgY0CN1dcbcUZQ1aAea9UiZBM9tTBKTba9GjJcGbn9ZcBq5BbDbEO A==;
X-CSE-ConnectionGUID: sQbKrwCLSJuLqwFtirTwDA==
X-CSE-MsgGUID: 9c6W/xsCTk+4qayuKIAUYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75654587"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="75654587"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 06:05:09 -0700
X-CSE-ConnectionGUID: R/zzo8/FSSCfD5Hbl4NCjQ==
X-CSE-MsgGUID: uyU9UYQLQkS/z/ketEwN6Q==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 27 Mar 2026 06:05:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: john.mcnamara@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/4] Consolidate and shrink version tables
Date: Fri, 27 Mar 2026 13:04:43 +0000
Message-ID: <20260327130448.1033651-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

The version tables in i40e and ice were overly long, having details
about long-unsupported releases, as well as containing duplicate info
in separate tables for different NIC variants. Merge and shrink these
tables to make them more manageable.

Bruce Richardson (4):
  net/ice: merge version tables for E810 and E830
  net/ice: remove non-LTS releases from version table
  net/i40e: drop unsupported releases from version table
  net/i40e: merge version tables

 doc/guides/nics/i40e.rst | 77 +++++++---------------------------------
 doc/guides/nics/ice.rst  | 53 +++++++--------------------
 2 files changed, 25 insertions(+), 105 deletions(-)

--
2.51.0

