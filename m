Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56946CCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:39:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B391B4060F;
	Fri, 16 Oct 2026 13:39:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3BFF140291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:39:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792150774; x=1823686774;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=u0FKtAz9wqDIBjJRqQ4dfS5uI2k59kLVbAMf++8ZV1o=;
 b=LHFtCjIFhuqjpWZZHfZn+QXm5rptdayVV+kzc5y0SCCdWLYVAmo5wQ5S
 daWQmYEYnYsjQwB2D3tZEU//eaXC4xAMlgNVBj6jhIxRCLl4jR5SrfWtd
 VXP9XhmOpje/mfw48t+xP7N1cRruQPQV/N+4NYgNB4yc7USdGrGs9D2mJ
 mu0pzCqASkAUkc5E8P/SJ8Q/fvxUlnOBIlGLiPmDuAQmPeXTwDktS0vxU
 CvIftufHVhNXbHoztnydSu23eMVhi7p8HdccfecwHPvyyYGcxaqzgydUp
 4qoke3S+Iz21AGxdvt/agPFCSQAXptocP0+EaXyXF2nlMXZ4eoS+opIvQ g==;
X-CSE-ConnectionGUID: SgQwP9hxSZGU0Ulw3+43Eg==
X-CSE-MsgGUID: ZZ8KZOroQv62ojlMJ0sxqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="940157"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="940157"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:39:33 -0700
X-CSE-ConnectionGUID: izNyhMAPSb6lDXYdbOfJrA==
X-CSE-MsgGUID: YfuN3PejTvm3nsqWmg2g/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2178425"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2026 04:39:33 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 0/2] i40e base code updates
Date: Fri, 16 Oct 2026 12:39:27 +0100
Message-ID: <cover.1792150724.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

Small base code update for i40e driver.

Oleg Akhrem (1):
  net/i40e/base: add get wake packet AQ command

Szymon T Cudzilo (1):
  net/i40e/base: avoid implicit conversions

 drivers/net/intel/i40e/base/i40e_adminq_cmd.h | 12 ++++++++++++
 drivers/net/intel/i40e/base/i40e_nvm.c        | 16 ++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.52.0

