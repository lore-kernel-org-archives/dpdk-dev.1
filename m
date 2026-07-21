Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8BCC44533
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 13:08:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC1994042F;
	Tue, 21 Jul 2026 15:08:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 61A5D40294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 15:08:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784639310; x=1816175310;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ibh+6YjQ7dXsZGizdwZg3XwnNqHHbg+YMurA/CIK9c0=;
 b=cQvODVljaM1FFrCQpkafHAdKiO/pcqDPD+SOkC21VVNpwn5LSIda2gg3
 cdjzPHLe7/Z7WqfjEyyhwDSYc4nuCNXcpI6lZN5cHdnjLR1Uq47MRM1t7
 LNIZaKpO0bca1gRwVaku3IRe2d6vYe6G5fHBfEq71bDrvg7yNaHxX9cj4
 X/g879aFI9RzXppXa2f7+UM75a8Kvro4uLb2Tv5CWUpAxplKzvbTqrKn3
 A6ACRQ8kX84isi7DXDCSD4dvUTBEpyn9Eo/jIV1avkMdQj3IWsjTZQEa7
 g5N7+pZz2zrefxZTMh8Hfge8nxjJ/5pFIjIzFG5KtaILPYUHvPAIov++V w==;
X-CSE-ConnectionGUID: L02EhbMGRey2NNSpZZQCRg==
X-CSE-MsgGUID: FYW95SG1SduJ+XkyoRQc7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="108027788"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="108027788"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 06:08:29 -0700
X-CSE-ConnectionGUID: B3oYERVPQg2XkB5CnJJLjQ==
X-CSE-MsgGUID: hXbY1vFtQnaid2rIxoxfQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="254360074"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa007.fm.intel.com with ESMTP; 21 Jul 2026 06:08:28 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC 0/2] iavf post-reset state restoration updates
Date: Tue, 21 Jul 2026 13:08:12 +0000
Message-ID: <20260721130814.2950332-1-ciara.loftus@intel.com>
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

A deprecation notice [1] has been submitted for the iavf auto_reconfig devarg.

The first patch removes the devarg, restoring promiscuous and all-multicast
modes unconditionally after a VF reset. The second patch limits this
restoration to VF reset only, avoiding unnecessary work on dev_start.

[1] https://mails.dpdk.org/archives/dev/2026-July/341822.html

Ciara Loftus (2):
  net/iavf: remove auto reconfig devarg
  net/iavf: restore promiscuous mode only after VF reset

 doc/guides/nics/intel_vf.rst           |  5 ---
 doc/guides/rel_notes/release_26_07.rst |  5 +++
 drivers/net/intel/iavf/iavf.h          |  1 -
 drivers/net/intel/iavf/iavf_ethdev.c   | 62 +++++++++++++++++---------
 4 files changed, 45 insertions(+), 28 deletions(-)

-- 
2.43.0

