Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5194BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 18:03:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 261AA402B5;
	Mon, 26 May 2025 20:03:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5D8E4402A4
 for <dev@dpdk.org>; Mon, 26 May 2025 20:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748282606; x=1779818606;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AF+D6VwbQs66IL4lzrK6JPu8sa65lOZ/95ZVGEylGpU=;
 b=nUNU8ps2wuC6arwRlSnDp3Mo9E+Hi3G1mq2ng0ab7eveqntV+MDaes8Q
 SEZaMOzYVvKJQJpRqmLzVFZQfkJRNwWEEi4FOQsKsMjO6EDlbssFW2VIO
 8yA2p3gr3iIWphRLaWPwvBfE2U0RTxWv1muYWj+u4htmJffc20pX1qLql
 A73tjHXkDocfIlH0Rsfvg1CYCvnMXIsrCVmKNa2DMF8nqMFBZiix0XRoD
 csUHsCwVphhT3pNJi5Z4DIZNU6+/bl1lSibUx6Iv//FDWYRsbg4VxJquE
 K9eCk/WNyfnhxlcapi7cnvQIF6NDRBnmoOUIBY4ixeuTa7wIWIcYUowL9 w==;
X-CSE-ConnectionGUID: oyh9UYhKQzaW1rUoGZfQEg==
X-CSE-MsgGUID: IR7QmYzATvOYXZUf+mXXOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50375153"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="50375153"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 11:03:25 -0700
X-CSE-ConnectionGUID: pzk42LAJRi6kxZI9T6CrNw==
X-CSE-MsgGUID: fjitzHwWT0+VxllCMRP74w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="142478290"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 11:03:25 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: 
Cc: dev@dpdk.org,
	Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v2 00/10] Update ice base code
Date: Mon, 26 May 2025 18:02:48 +0000
Message-ID: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
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

Dhanya Pillai (1):
  net/ice/base: update version info

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

