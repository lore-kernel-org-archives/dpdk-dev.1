Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23161E7314E
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 09:44:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBFDB402D8;
	Mon,  2 Feb 2026 10:44:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 48F464027D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 10:44:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770025440; x=1801561440;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=d+7lZ56WdoJtctHnOE/sr/kPhiu9FoMP0Yxkek1bDH4=;
 b=bV/L+Ir6JVUl1bWJ1zuQ1tvp2ct0dpvFaguA1lfORvAK4N+UkzRhWTqW
 ZleSTCIwm9VwJFhAsb9cUr80E0D0N45Bkz0yrVZ9drsmnuKlE2540I3f5
 +SopFTfhpqz4zti0lGq4tWReUkf8ZrPY/vo6bkb766pMMWBNlHBgA7dgZ
 LdhuYtAmtYMRe2jtxsWmOziBBhBsF0/NvnwDkWJ4A5m4ST0RlWW+k3IF9
 woztf3Dl0zAKZVwXTxfxLxr/qJQ1JxL0HQk7/al5AOQXZFdvVKgKI1BHr
 MOTGoawfgTPUGE9lpPc46PiQDpj+tZdHV5CRSd8ijS8FJBZmaHr1Keb0C w==;
X-CSE-ConnectionGUID: KMCBqY99RCankBW4se+Q0Q==
X-CSE-MsgGUID: g8wdiQtGS7OP/iptVMWZQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="81917703"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="81917703"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 01:43:59 -0800
X-CSE-ConnectionGUID: pNKe29SiTBahMXlbydQvfw==
X-CSE-MsgGUID: U+ZpySKvTR+fuBvG0RoArA==
X-ExtLoop1: 1
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa003.fm.intel.com with ESMTP; 02 Feb 2026 01:43:58 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 0/6] Add support for L2TPV2 over UDP to ICE PMD
Date: Mon,  2 Feb 2026 15:12:38 +0530
Message-Id: <20260202094244.447966-1-shaiq.wani@intel.com>
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

This patchset adds L2TPv2 protocol support to the ICE PMD
enabling RSS and Flow Director capabilities for L2TPv2 over UDP traffic.


Shaiq Wani (6):
  net/ice: add L2TPv2 and PPP data structures
  net/ice: add L2TPv2 tunnel type definition
  net/ice: add L2TPv2 protocol and field definitions
  net/ice: add L2TPv2 flow patterns and FDIR support
  net/ice: add L2TPv2 hardware packet generation
  net/ice: add L2TPv2 RSS hash support

 drivers/net/intel/ice/base/ice_fdir.c    |   6 +
 drivers/net/intel/ice/base/ice_fdir.h    |  17 +
 drivers/net/intel/ice/ice_ethdev.h       |   4 +
 drivers/net/intel/ice/ice_fdir_filter.c  | 487 +++++++++++++++++++----
 drivers/net/intel/ice/ice_generic_flow.c | 177 ++++++++
 drivers/net/intel/ice/ice_generic_flow.h | 130 ++++--
 drivers/net/intel/ice/ice_hash.c         |  25 ++
 7 files changed, 728 insertions(+), 118 deletions(-)

-- 
2.34.1

