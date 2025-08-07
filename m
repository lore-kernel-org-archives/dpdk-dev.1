Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737A1C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:22:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6542E402E0;
	Thu,  7 Aug 2025 14:22:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id A4E8E4027C
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:22:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754569363; x=1786105363;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=s9IXu93707x7gfmQH98QMDQFuLTrgiv2BTt8RDYClK8=;
 b=PveT+yhBbjhMcB2bd1MBKDvngooyXFefg/WxqUj+VnL6IkgIg/X9xQ41
 3NFY8nGqr5pD6EWCL/Ry/ZZb1LgGApdkizvh8iM54dAXAR5IwNMeifiNO
 Vyq9oSOdiAfjHypXF2Qw1dBOoC2ZvLCY+4u+GeekSoQGbz/cWBXBzikq2
 6FTMWq3xtbT5rDaqocUtfRs4CG5dW4lFTwyCl4hzVPGIpJ/Spd4T4w2wp
 e4NmqK7PkrLWZApSA5mzFgkc2+NhlwQpQ7xcfV5E76gZmxjiGvql0KSkg
 GOwE0hhi1GLgQkdX9/CBVIaAnq9n7rJOBaHZUg4BiM9yhgI3sP8OAh5uE w==;
X-CSE-ConnectionGUID: 1K07te2aRBalo8zMjboauA==
X-CSE-MsgGUID: 4SXEzfdhSCmHHrASdGrQ1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="59517162"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="59517162"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:22:42 -0700
X-CSE-ConnectionGUID: q5TNh1SMSMWgCeBDuqf+sg==
X-CSE-MsgGUID: bcM2cMQGSSyO+vBtRgBMwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="169171612"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa003.fm.intel.com with ESMTP; 07 Aug 2025 05:22:41 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH 0/6] Enable DCB/PFC support for ICE PMD
Date: Thu,  7 Aug 2025 12:22:31 +0000
Message-ID: <20250807122238.334177-1-vladimir.medvedkin@intel.com>
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

This series introduces an initial implementation of DCB and PFC to the ICE PMD.
This includes adding support for TCs in ice_aq_set_mac_cfg() and asymmetric DCB/PFC configuration in base code.

Current implementation relies on current API and has a number of limitation and assumptions such as:

- Symmetric DCB configuration with respect to RX/TX, only dcb_rx_conf is used
- All TCs are configured equally with respect to BW they share
- No support for Low Latency TCs
- All existing queues are split evenly across TCs. Number of queues must be power of 2 and be no less than configured nb_tcs
- TX queues assigned to TCs the same way as RX queues

Vladimir Medvedkin (6):
  net/ice/base: add utility functions
  net/ice/base: make set MAC config TC aware
  net/ice/base: add supports for assymetric PFC
  net/ice: enable DCB support
  net/ice: enable PFC support
  net/ice: add PFC statistics

 drivers/net/intel/ice/base/ice_common.c | 175 ++++++++---
 drivers/net/intel/ice/base/ice_common.h |  12 +-
 drivers/net/intel/ice/base/ice_dcb.c    |  96 +++++-
 drivers/net/intel/ice/base/ice_dcb.h    |  16 +-
 drivers/net/intel/ice/base/ice_type.h   |   2 +
 drivers/net/intel/ice/ice_ethdev.c      | 370 +++++++++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx.c        |  21 ++
 7 files changed, 631 insertions(+), 61 deletions(-)

-- 
2.43.0

