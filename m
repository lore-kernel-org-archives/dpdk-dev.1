Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FB1C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 08:33:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC68D40430;
	Mon, 26 May 2025 10:33:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4A013402A0
 for <dev@dpdk.org>; Mon, 26 May 2025 10:33:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748248425; x=1779784425;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uB/xIRsc/ra4B6ONLEmelRlS7sxVReEGaMQHtVLGtvc=;
 b=M+RMTB/ZanYKd3XDogUV1EfBMFx5RHLcY3YSQGjZ2g82sC8ZukI/W6FV
 a4Ad0SfTvmnMchzIcpdICE6tI5ULqB3FeXcCCYB0+MKi/xgoq3+YflbFo
 M5Qho9g86VIFW8WeGMRkrwSOtTIZ4SgnRUOa3DirN7y+3JIMQ6Xocgq0l
 PQfwyivbriBm2Pf1MasU9ubQZiHKT9L78vHdxEo664hG4kB75nSKHkM7K
 pbdRRy56W7QRrTtB9VfLQ8ZNzhot99zt9adwEHmrnKl4WkjZoI8RQWkNd
 5FBECXG5IBHr1WephRUty/5C/5U8sxgpx2S2OBvj2T38H9R7HIEpndr82 A==;
X-CSE-ConnectionGUID: VrVNNohXRIGESML9NrLnLQ==
X-CSE-MsgGUID: MIlDW2mXRJWA0mUQUGV5hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="54008982"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="54008982"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 01:33:44 -0700
X-CSE-ConnectionGUID: 4AdUiVCPTOaXzNF3Ml+NFg==
X-CSE-MsgGUID: XIdgl1WgQ8SHB32nGCNIkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="142293376"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 01:33:44 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: 
Cc: dev@dpdk.org,
	Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH 0/9] Update ICE base code
Date: Mon, 26 May 2025 08:33:02 +0000
Message-ID: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
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

Ice base code is updated to latest snapshot.

Filar, Mikolaj (2):
  net/ice/base: support for MAC rule with own filter flags
  net/ice/base: configure PHY FEC error in logs for GNRD

Janardhanan Arumugam (1):
  net/ice/base: increase reset timeout to 20 seconds

Lukasz Krakowiak (3):
  net/ice/base: integer overflow issue fix
  net/ice/base: set speculative execution barrier
  net/ice/base: typo fix in desc for dev ID 579F

Oleg Akhrem (1):
  net/ice/base: ptp minimal refactoring

Paul Greenwalt (1):
  net/ice/base: typo fix in media type check

Waldemar Dworakowski (1):
  net/ice/base: type conversion fix

 drivers/net/intel/ice/base/ice_common.c    |  6 ++-
 drivers/net/intel/ice/base/ice_devids.h    |  2 +-
 drivers/net/intel/ice/base/ice_flex_pipe.c |  2 +
 drivers/net/intel/ice/base/ice_osdep.h     |  6 +++
 drivers/net/intel/ice/base/ice_ptp_hw.c    |  9 ++---
 drivers/net/intel/ice/base/ice_sched.c     | 10 +++--
 drivers/net/intel/ice/base/ice_switch.c    | 46 ++++++++++++++++++++--
 drivers/net/intel/ice/base/ice_switch.h    |  1 +
 drivers/net/intel/ice/base/ice_type.h      |  2 +-
 9 files changed, 67 insertions(+), 17 deletions(-)

-- 
2.43.0

