Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D93C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4FCD40DFD;
	Mon,  9 Jun 2025 12:25:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4CCAF40E0B
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464744; x=1781000744;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0AFlKPtp3dXTM8H7rWLZpPoz6fdrg4PJR+SpqS+Kj+4=;
 b=Cq6W7YJP5jV9hiKqqg1toL+vo6TqzrHIcYd8HqYesyGCzhhmGeuX6awz
 Zg8TbJxxe70xzsIG4v02P8ncdg7pONGgco1Ny2rCNdysftcH6OHN+FXTT
 Iar/PDnaFhR2KN84Vla3k1LwnRX2pY1FugAhld5vSMI2ko0jFAauRe5hc
 YPMi3lMS4GxLI1iooLqxQsUSbYCdGmptzeKSVEZgmG45o0b1+qsflS1x/
 wRL19e0NvPwOezbJvIT3uH1nA2rVZeKFLZYuWwoPqfD7gGy5hoYM4Rhfm
 1cvERkVaZEKTRIbb2nCuQfD3839QQYzKObpOeR+eOphsKiItxRX/l5qNB A==;
X-CSE-ConnectionGUID: Miti/lWsQ6mIQqCjKsV6rA==
X-CSE-MsgGUID: 4XqDN0d7T+myVTVh5xy2RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51448496"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51448496"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:25:43 -0700
X-CSE-ConnectionGUID: bD2X6YKVR6KSh5vvyNjkqQ==
X-CSE-MsgGUID: tbB157KYRHWnBURqaQtwuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146356419"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa006.fm.intel.com with ESMTP; 09 Jun 2025 03:25:43 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 0/5] Update ixgbe base code
Date: Mon,  9 Jun 2025 11:25:33 +0100
Message-ID: <cover.1749464704.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
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

Update IXGBE base code snapshot to version 2025-06-04.

Aleksandr Loktionov (1):
  net/ixgbe: remove PTP by PHY cap

Anatoly Burakov (1):
  net/ixgbe: update README

Jedrzej Jagielski (1):
  net/ixgbe: add VF mailbox op for link status

Piotr Kwapulinski (1):
  net/ixgbe: add ACI debug printouts

Piotr Pietruszewski (1):
  net/ixgbe: add support for toggling VF Tx queues

 drivers/net/intel/ixgbe/base/README           |   2 +-
 drivers/net/intel/ixgbe/base/ixgbe_api.c      |  13 ++
 drivers/net/intel/ixgbe/base/ixgbe_api.h      |   1 +
 drivers/net/intel/ixgbe/base/ixgbe_common.c   |  56 ++++++++
 drivers/net/intel/ixgbe/base/ixgbe_common.h   |   1 +
 drivers/net/intel/ixgbe/base/ixgbe_e610.c     | 112 +++++++++++++++-
 drivers/net/intel/ixgbe/base/ixgbe_e610.h     |   2 +
 drivers/net/intel/ixgbe/base/ixgbe_mbx.h      |   4 +
 drivers/net/intel/ixgbe/base/ixgbe_osdep.h    |   1 +
 drivers/net/intel/ixgbe/base/ixgbe_type.h     |   1 +
 .../net/intel/ixgbe/base/ixgbe_type_e610.h    |   1 +
 drivers/net/intel/ixgbe/base/ixgbe_vf.c       | 126 ++++++++++++++----
 drivers/net/intel/ixgbe/base/ixgbe_vf.h       |   2 +
 13 files changed, 293 insertions(+), 29 deletions(-)

-- 
2.47.1

