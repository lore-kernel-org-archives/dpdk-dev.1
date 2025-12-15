Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FBFD5B16E
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:07:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 518A5402C6;
	Mon, 15 Dec 2025 15:07:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C156E40151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 15:07:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765807668; x=1797343668;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dTnWnm1tF+pMPe+if1jSnn9U+bGRR2g+rlxJRlVyGfU=;
 b=XyBiVakVEcEUXQmk2sggafMOQpa20H4DHpOc1LtCmKArf4yUdmgLh7kt
 bM7TYRSNDbQZ/vlxpk/j/0Xabaub0HzKOYkLszGCIn6iBg5xk6odbscmI
 v0Zp83pEdK7/fjg/JX5nlBufpsTyw485USVbyvfJhNmStpCDhuL17TiOI
 38PHcnsLEeJ/hPznLmEyNwI3k1ug22zFG/pML7FYikl+InxIUFFEwmPL6
 o1zar7Z3m93LKABqQVEHtdidZMoFX4am6tgi1tA63CM847GoBqFnJzqk7
 c/svz3wQqrqF6MoDfAI2aoP69v9VJyleDT63dKix9Sqy5r/O+aDDcmaod g==;
X-CSE-ConnectionGUID: VMh+ONM+R6ORoVZDxi5pWw==
X-CSE-MsgGUID: +lBFW2ADSMGXbrH5fyM2Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79078679"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="79078679"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 06:07:46 -0800
X-CSE-ConnectionGUID: FQhIdw9rSBamWga+sdJTww==
X-CSE-MsgGUID: /OXBDMJbQF2r08UpzuvX4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="196996387"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 06:07:46 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/8] Fixes for Intel common rx/tx path selection
Date: Mon, 15 Dec 2025 14:05:45 +0000
Message-ID: <20251215140553.2283531-1-ciara.loftus@intel.com>
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

An issue exists with the way Rx and Tx paths are defined and then used
by the common selection infrastructure, which in some cases means not
all paths are available for selection. The issue affects four drivers on
both Rx and Tx paths resulting in eight fix patches.

Depending on the underlying architecture and CPU flags available, a
different set of paths are defined for each driver. The path selection
function iterates sequentially from zero to num_paths where num_paths is
the size of the array as determined by the RTE_DIM macro. However,
depending on the platform, some of these entries may be empty, and valid
entries at the end of the array may never be considered in the selection
function. Fix this by editing each driver's rx/tx "func_type" enum and
only defining a value for the path if it is implemented in the driver's
rx/tx "path_infos" array.

The fixes for the Tx paths can be squashed into the next-net-intel tree
as the commits that those fixes target have not yet made it into the
main branch. The fixes for the Rx paths can be squashed into one commit
if that's a more desirable approach, since the commit messages of them
all are essentially the same but for the driver name. The generic
version is the paragraph above.

Ciara Loftus (8):
  net/i40e: ensure all Tx paths are selectable
  net/iavf: ensure all Tx paths are selectable
  net/ice: ensure all Tx paths are selectable
  net/idpf: ensure all Tx paths are selectable
  net/i40e: ensure all Rx paths are selectable
  net/iavf: ensure all Rx paths are selectable
  net/ice: ensure all Rx paths are selectable
  net/idpf: ensure all Rx paths are selectable

 drivers/net/intel/i40e/i40e_ethdev.h        | 12 ++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c          |  8 ++++++--
 drivers/net/intel/iavf/iavf.h               | 10 ++++++++++
 drivers/net/intel/ice/ice_ethdev.h          |  8 ++++++++
 drivers/net/intel/idpf/idpf_common_device.h |  8 ++++++++
 5 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.43.0

