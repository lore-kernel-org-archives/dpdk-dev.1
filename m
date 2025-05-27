Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE1BC54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:17:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39EB7402D1;
	Tue, 27 May 2025 15:17:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E41224027A
 for <dev@dpdk.org>; Tue, 27 May 2025 15:17:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748351867; x=1779887867;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=m5CBiBbXTv+SGb0mDp1ej0+p3A1pJlu0B3vW0DkcBIY=;
 b=RX3qYrQRLpqUNZJ1qzZKuVzVtf/hbyn1Wft9CCintuGDvq96cUalrqrb
 8Ls76NfcmncFdn7OwBGiZPsI8yYPz0aJfvhtfpmBJfAfwgtZzFEBduis/
 01UuU0WYtz6/hhaZ80ib1lC1JSrru0c0tMfsU1PaLJDcmtSVA/UwfIpB4
 unOhQl9zTmFMf5D3qTEpCs7x6Xr3dkJw4iSrEaZa+93fcupByyhVj/E23
 tLfOtA+1WsssC4/Q7B5yBGcZrYqw4D7eJMWqg1AuHmOmP49vMzuGMTtsn
 ufcI9ly7l4QGBiZZofTwuuJULlnWfu4iWZQBfdNQngRjqITDH2A/jjtxp A==;
X-CSE-ConnectionGUID: TwbEoWeVShO+KAXGSfkPzQ==
X-CSE-MsgGUID: 9hxxwxA/QN+AyXWl8dbYRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67884813"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="67884813"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:17:46 -0700
X-CSE-ConnectionGUID: F0pKS2aaTjKe0pXdDADYjw==
X-CSE-MsgGUID: vP+noSZUTNGGpDfaDbF6ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143150021"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa008.fm.intel.com with ESMTP; 27 May 2025 06:17:45 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: 
Cc: dev@dpdk.org,
	Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v3 00/10] Update ice base code
Date: Tue, 27 May 2025 13:17:19 +0000
Message-ID: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
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

ice base code is updated to latest snapshot.

v3:
- Fixed check patch failure in DPDK CI.
- Added Fixes tag to bug fixes.
- Corrected author name for couple of patches.

v2:
- Added Author Signoff.

Dhanya Pillai (1):
  net/ice/base: update version info

Janardhanan Arumugam (1):
  net/ice/base: increase reset timeout to 20 seconds

Lukasz Krakowiak (3):
  net/ice/base: fix integer overflow issue
  net/ice/base: set speculative execution barrier
  net/ice/base: fix typo in desc for dev ID 579F

Mikolaj Filar (2):
  net/ice/base: support for MAC rule with own filter flags
  net/ice/base: configure PHY FEC error in logs for GNRD

Oleg Akhrem (1):
  net/ice/base: ptp minimal refactoring

Paul Greenwalt (1):
  net/ice/base: fix typo in media type check

Waldemar Dworakowski (1):
  net/ice/base: fix type conversion

 drivers/net/intel/ice/base/README          |  2 +-
 drivers/net/intel/ice/base/ice_common.c    |  6 ++-
 drivers/net/intel/ice/base/ice_devids.h    |  2 +-
 drivers/net/intel/ice/base/ice_flex_pipe.c |  2 +
 drivers/net/intel/ice/base/ice_osdep.h     |  6 +++
 drivers/net/intel/ice/base/ice_ptp_hw.c    |  9 ++---
 drivers/net/intel/ice/base/ice_sched.c     | 10 +++--
 drivers/net/intel/ice/base/ice_switch.c    | 46 ++++++++++++++++++++--
 drivers/net/intel/ice/base/ice_switch.h    |  1 +
 drivers/net/intel/ice/base/ice_type.h      |  2 +-
 10 files changed, 68 insertions(+), 18 deletions(-)

-- 
2.43.0

