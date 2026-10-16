Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE63ECCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 10:23:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83DA740291;
	Fri, 16 Oct 2026 12:23:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id DD5F1400D5
 for <dev@dpdk.org>; Fri, 16 Oct 2026 12:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792146188; x=1823682188;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=R8IXliFe+//DlJPtSTm+4icL4xox97ay8fsUlxS25sc=;
 b=n0veDo805tiBfF8E0meE3reDdfuDuONDGJLpKgbGmh6/wtOJIqz4qilr
 nRT+LcHhmfXO7EjQGFi3oI45YyMtCG98Zn7EpIfAaKgB3I5YT6w1n4CnD
 X44S1ZLp+I3KYrqLzvXeXbgHXO/Y7gcXzKRj0DWImyUmBMsAWxuDKHVuE
 LUcLeYRkbHdlnWwN281oXNHoMeS4P2bfhdfFGloeJofihY1O/RLMfjfTm
 N+MtuY0hsSKpZ11LKBDvvled4ocdErXykeVZTLkzmRsTeQSiOJFckGLff
 Sj+ioKK1srR1OtpXXg0lX32pEXEtkPVgaqWkGYwesDbCzsXi2j+9covGh A==;
X-CSE-ConnectionGUID: aRrEzsf/TCSloEgpXBZy2g==
X-CSE-MsgGUID: DTZRMDvVRMeT2Q9k1iJfnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="809298"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="809298"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 03:23:07 -0700
X-CSE-ConnectionGUID: E1obhhJXTK22+OgeB20qHA==
X-CSE-MsgGUID: 0snoJNLxQj+nnl4UT9vhzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2292832"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 16 Oct 2026 03:23:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 0/3] e1000 base code updates
Date: Fri, 16 Oct 2026 11:22:58 +0100
Message-ID: <cover.1792146148.git.anatoly.burakov@intel.com>
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

Small base code update for e1000 driver.

Dima Ruinskiy (3):
  net/e1000/base: add new PCH MAC type
  net/e1000/base: retry failed MTA writes on i210/i211
  net/e1000/base: enable ULP on LANPHYPC

 .mailmap                                     |  1 +
 drivers/net/intel/e1000/base/e1000_api.c     |  5 ++-
 drivers/net/intel/e1000/base/e1000_hw.h      |  1 +
 drivers/net/intel/e1000/base/e1000_ich8lan.c |  8 +++++
 drivers/net/intel/e1000/base/e1000_mac.c     | 34 ++++++++++++++++++++
 drivers/net/intel/e1000/em_ethdev.c          |  5 ++-
 6 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.52.0

