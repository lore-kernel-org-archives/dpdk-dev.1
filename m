Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBA4CD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DA9B402DD;
	Mon,  8 Jun 2026 16:55:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 96C5E40265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 16:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780930532; x=1812466532;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BUPvASjJXnJ2o6OLD2otGSjralxmlv8BerBuzTpNqbo=;
 b=FEuhufCT/BQh5cBfrLnRhLByxtEumq88ethpvaMK4B4mpEumrnXc3Dhj
 INg9yWR8Fbgl7tNbMIRRhTISb02fsZy3YuJcBu7qUEu2XzlGnu5J4R4lA
 khKIpjXKGMS2ODkyEl05yUQCfgLcZ/wUzj8/vZ0yg/eVS9W0L72KjOpW3
 7d+FXxDiYKZp2KfGw9qRyzCYYberuFTjhS0OuVfZv//8F1XaxGwL3qnLN
 R8Qm6c6KsCqv5x8OAK5rCwIuqxmt+5zHzGGM/WuVgBEmB5IcGVt442y/I
 M36rE4CBdA/3mrbnXZ3JXkh31RhMOiO2plaNyaJf+P8r/nP5Yq3/5OpcX w==;
X-CSE-ConnectionGUID: 5B9q/ATxRhuwAdzS5JvjTQ==
X-CSE-MsgGUID: DyFjIxXdSfKqeFl+rwweaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93055937"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="93055937"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 07:55:30 -0700
X-CSE-ConnectionGUID: rm0rjOLOS0WBQXgrjk4aDg==
X-CSE-MsgGUID: 6A/CbszuTAOf1u24nXYdEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="247436442"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa004.fm.intel.com with ESMTP; 08 Jun 2026 07:55:29 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/3] net/iavf: vf reset fixes
Date: Mon,  8 Jun 2026 14:55:15 +0000
Message-ID: <20260608145518.1705524-1-ciara.loftus@intel.com>
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

The patch [1] aimed to address a race condition in the iavf driver
during a reset and also reduced noisy logging during resets.
Patch 1 of this series extracts the noisy logging fix into its own
commit.
Patch 2 offers an alternative approach to fixing the race condition.
Patch 3 fixes a pre-existing refcount imbalance in the shared event
handler thread that became visible while investigating the reset path.

[1] https://patches.dpdk.org/project/dpdk/patch/20260605123646.1328492-1-chaitanyababux.talluri@intel.com/

Ciara Loftus (2):
  net/iavf: wait for PF reset start before reinitializing
  net/iavf: fix event handler refcount leak on HW reset

Talluri Chaitanyababu (1):
  net/iavf: downgrade opcode 0 ARQ log to debug

 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 14 +++++++++++++-
 drivers/net/intel/iavf/iavf_vchnl.c  | 11 +++++++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.43.0

