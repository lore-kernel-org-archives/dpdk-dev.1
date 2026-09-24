Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA4CC9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 502FD40144;
	Thu, 24 Sep 2026 15:14:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 25BEE400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 15:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790255676; x=1821791676;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QewwF0D48Qwo4HMjPkrZbwCAWkw+yGsuceQ2YuhfjAM=;
 b=H17U2wUVQP+jZFFFi9zrdS4mnxxEvCXc1Qsq5LnqtfY/xp87j99RTwgG
 st/1ZnhzJasa2/bnz8KW768P0ye5BOpM85uUTSh7PNZYCdbl2vRfH7JYS
 fL+546xePmADIVgLghOxxwE3FISsbiIeRyrk6qNYXzMqmJpIJxaV+HU45
 K08jAPPRSSNaRG+jNLaPUBLW/8+S8gWMBnkP4DbKnNUB2PLUCwU4XLhtg
 8FXQmNqNI1Hk49PWjbHzzBBY6tFs7YBv6yCu65B3o9T6Mdizrx4WKrJiG
 UIngrG1YAEQr5LFOVf2amvJVMhJd4zEltPwRZ5th4eiW4e0+q2dX+zVmT A==;
X-CSE-ConnectionGUID: i5Qc2GypR0SXFygIFktHCQ==
X-CSE-MsgGUID: ichZ+6d2RcC/mVFIgmM+Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93915421"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93915421"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:14:34 -0700
X-CSE-ConnectionGUID: i9RnFq2DR9STKBbIcCW09Q==
X-CSE-MsgGUID: RXBQXDi5TsG+gt9P38U5vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="273518511"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2026 06:14:33 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/6] Fix inconsistencies in offload masks
Date: Thu, 24 Sep 2026 13:13:40 +0000
Message-ID: <20260924131346.100156-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

This series fixes some inconsistencies in the path offload masks and
dev_info offload capabilities for the ice, iavf and i40e drivers.
The first 3 patches are concerned with fixing the path offload masks.
The last 3 patches change how offloads are derived for the dev_info offload
capabilities. Instead of defining an explicit list of offloads, reuse the
information that is already available in the path offload masks. It should
help prevent further inconsistencies in the future.

Ciara Loftus (6):
  net/ice: update Rx supported offloads masks
  net/ice: fix Rx vector path offload masks
  net/i40e: drop unimplemented UDP TSO from Tx mask
  net/ice: derive Rx/Tx offload capabilities from path masks
  net/iavf: derive Rx/Tx offload capabilities from path masks
  net/i40e: derive Rx/Tx offload capabilities from path masks

 drivers/net/intel/i40e/i40e_ethdev.c | 29 +++---------------------
 drivers/net/intel/i40e/i40e_rxtx.h   |  1 -
 drivers/net/intel/iavf/iavf_ethdev.c | 34 +++++++++-------------------
 drivers/net/intel/ice/ice_ethdev.c   | 32 ++++++--------------------
 drivers/net/intel/ice/ice_rxtx.h     |  6 +++--
 5 files changed, 25 insertions(+), 77 deletions(-)

-- 
2.43.0

