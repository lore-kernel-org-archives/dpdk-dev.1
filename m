Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23A6CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:56:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B18D940264;
	Wed,  7 Oct 2026 09:56:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3544B4021F
 for <dev@dpdk.org>; Wed,  7 Oct 2026 09:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791359796; x=1822895796;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Z8l+vXusiCwLpDJOcTSY+OD+E19/TbHjtkCcZbzK0EA=;
 b=DQnFy7sJ7ohXex5jFG94AyGzfHa1qPjBYaxP7yWc+AAxS+vmwR1UlYfn
 j2P2/RnQcRuHqSzWNKXQOEeg8kdwOYYlwxoFyD62KGNfQlxathFS7i4t0
 twTgjia7m0aDLcs1WLsKgvu5T8kfYCoQ6o0BFuqMnWVsATIIgU7FoPJkQ
 ASbK5hGrfZlQcjDMFCOfyMvtIcomSib3VMrI3Gqcpe4lcenA+zEinBiTA
 k/oihuYEKAR/+74qub7qft7E+9DGFPQhtGbp16lTLKc8bPTOI5NKpLx99
 tvju2CSLYDXuetTkY40J05xZRFqKagljURkcxGXhLgCnqL/stWgBbQbQ3 g==;
X-CSE-ConnectionGUID: Ax4gIpppSa+rxbIAPC8Uug==
X-CSE-MsgGUID: JHbu4uohR3WnGU7oBtM0NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="216877"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="216877"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 00:56:35 -0700
X-CSE-ConnectionGUID: izsp86P+T7q+cwNB8LWsXw==
X-CSE-MsgGUID: KqqwLbpQQvqy2MeFu9SHRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="285301122"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa003.fm.intel.com with ESMTP; 07 Oct 2026 00:56:34 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 0/2] net/ice: fix memory handling issues
Date: Wed,  7 Oct 2026 07:58:18 +0000
Message-Id: <cover.1791356190.git.anurag.mandal@intel.com>
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

This patch series addresses two memory handling issues in the ice PMD.

- The first one makes memory allocation and release symmetric. 
  Several buffers obtained through ice_malloc(), ice_calloc() 
  or ice_memdup() were released with rte_free() instead of ice_free(). 
  Both APIs currently map to the same underlying allocator. 
  However, mixing them is inconsistent and would break if the OS 
  abstraction layer ever changes.

- The second one fixes an unchecked allocation in ice_tx_queue_start() 
  which dereferences the Tx time queue context buffer returned by 
  ice_malloc() without NULL check.
  On allocation failure, the E830 send-on-timestamp path therefore crashes
  instead of reporting "No Memory" error, and also the already allocated
  txq_elem buffer gets leaked.

Anurag Mandal (2):
  net/ice: free memory with matching allocator
  net/ice: fix unchecked Tx time context allocation

 drivers/net/intel/ice/ice_acl_filter.c  | 10 +++++-----
 drivers/net/intel/ice/ice_dcf.c         |  2 +-
 drivers/net/intel/ice/ice_dcf_parent.c  |  2 +-
 drivers/net/intel/ice/ice_ethdev.c      | 14 +++++++-------
 drivers/net/intel/ice/ice_fdir_filter.c | 12 ++++++------
 drivers/net/intel/ice/ice_rxtx.c        | 22 +++++++++++++---------
 6 files changed, 33 insertions(+), 29 deletions(-)

-- 
2.34.1

