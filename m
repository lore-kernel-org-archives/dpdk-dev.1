Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C602BFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEEB840608;
	Thu, 30 Apr 2026 13:14:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6DFFE4028C
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547690; x=1809083690;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JY69IFTGwWfZm3zZKnXF53p0ZawUHq2xoniE1nTnmk8=;
 b=GsU0tpmWGg6Z1VIMLdqMqbIjZcwu8ck5V8xr4lH9nMkWol5PrnxcpJgq
 r+I84aN7399ZkdZnyPmHzfwvUMkJ7uSw7OBJhN75AwDO6cceJRGql5f9+
 hFcSwtCvKRJMOJupZ3/o//eiNqz8CkAVGnub0XZNjLDOKTVZTQuLxrSKY
 HJI4oGPtmWSoHBB75lAmHzPuvFN9yghy4Wp1ecnkax7YhZEqYSzMS7jvs
 JLp4SlENhT2pAuy4s7rGTltd6jKQv1KUlWB+kK+gr5q1BW9NT2M+YrkIz
 Y0jt+h0OY6ZnYUzqniUbOvRbBNnPRjDuydX+eS8CdEFzg+p9E+x0iyfDN g==;
X-CSE-ConnectionGUID: CXvoVmbcSCSpzGec/jSACg==
X-CSE-MsgGUID: HhPV+SqVT4CalZs+m9YuYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482254"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482254"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:14:49 -0700
X-CSE-ConnectionGUID: UwXipPc0TUaMtTkr9XhmNg==
X-CSE-MsgGUID: hGWs50gyQuO35r5fqBDzQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444652"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:14:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 00/15] IXGBE fixes and cleanups
Date: Thu, 30 Apr 2026 12:14:29 +0100
Message-ID: <cover.1777547413.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

This patchset fixes a bunch of very old issues in flow management
in IXGBE driver, such as:

- storing process-local pointers in shared memory
- incorrect L4 protocol matching for FDIR
- wrong handling of SCTP flow items
- reading stale FDIR state after flow destroy/flush
- storing all flows in global lists

In addition, some cleanup is also performed - refactors, moving
things around to avoid accessing process-local state, and
writing read-only values at init instead of deep in FDIR.

Finally, FDIR was also rejecting protocol-only matches for TCP
and UDP, these are now supported.

Depends on flow dump patchset: https://patches.dpdk.org/project/dpdk/list/?series=38016

Anatoly Burakov (15):
  net/ixgbe: fix flows not being scoped to port
  net/ixgbe: fix shared PF pointer in representor
  net/ixgbe: fix non-shared data in IPsec session
  net/ixgbe: fix SCTP protocol-only flow parsing
  net/ixgbe: fix L4 protocol mask handling
  net/ixgbe: reset flow state on clear paths
  net/ixgbe: store max VFs in adapter
  net/ixgbe: do not use flow list to count flows
  net/ixgbe: remove redundant flow tracking lists
  net/ixgbe: reduce FDIR conf macro usage
  net/ixgbe: use adapter in flow-related calls
  net/ixgbe: support protocol-only TCP and UDP rules
  net/ixgbe: write drop queue at init
  net/ixgbe: rely less on global flow state
  net/ixgbe: refactor flow creation

 drivers/net/intel/ixgbe/ixgbe_ethdev.c        | 112 +--
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  45 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          | 240 +++---
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 716 +++++++++---------
 drivers/net/intel/ixgbe/ixgbe_ipsec.c         |  10 +-
 drivers/net/intel/ixgbe/ixgbe_ipsec.h         |   3 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |  10 +-
 .../net/intel/ixgbe/ixgbe_vf_representor.c    |  63 +-
 8 files changed, 590 insertions(+), 609 deletions(-)

-- 
2.47.3

