Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75371CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB5C740668;
	Wed, 20 May 2026 14:53:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C60EE40662
 for <dev@dpdk.org>; Wed, 20 May 2026 14:53:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779281596; x=1810817596;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tcunG5IXLfHoLQSbQNKpwR+f+fQ9bvNHWrAvhhs5k6Q=;
 b=n3h92K98JlLor0ZMV3KWL/so67lKt0BZQTgMpFN41DekNczfdgmj23m2
 z8sf+gCdPeXAqGnbyd7uxqjd4X0QX80OR6L6RbL5MkCL19wahWfEe3sRx
 X/M1aimyCU9Z85VfwX5dVcpasihceaz6BrWuQpC7f/05Yxi3qCEeeedp/
 tmBpFRzEQYojm5s86Vd2qiGeWptstUd2CbpdEh0y2A0dtNaAC1MDHbfey
 M2XW44Mi3L3WWF6jMJnAGoCcXzoodizmF62ae0dqcyC3jnBGdhuk7xMrF
 bPhaB/d7C0JZJMJK56S/31RjJGrb8MGPv/q7OFvwnM0pRXEou3oopmFQ3 A==;
X-CSE-ConnectionGUID: gQQjZrd9R8SUIVETIxTfUA==
X-CSE-MsgGUID: nCZHhw+qRKKKAWmUYuF1AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91570265"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91570265"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:53:14 -0700
X-CSE-ConnectionGUID: pZW75PzOSxyjEcJU401l1w==
X-CSE-MsgGUID: B179reaERZSrFKp6x7ZVEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="235908266"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2026 05:53:14 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 00/10] e1000 base code update
Date: Wed, 20 May 2026 12:52:37 +0000
Message-ID: <20260520125256.354336-1-ciara.loftus@intel.com>
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

Update the e1000 base code. The changes are mostly fixes, refactoring,
and code cleanup.

Ciara Loftus (1):
  net/e1000/base: update version info

Dima Ruinskiy (2):
  net/e1000/base: fix coding style issues
  net/e1000/base: propagate PHY control register write error

Lukasz Czapnik (1):
  net/e1000/base: fix possible variable overflow

Mateusz Fryze (1):
  net/e1000/base: auto-negotiation status for 1000BASE-T

Menachem Fogel (1):
  net/e1000/base: fix NVM loop bounds and pointer access

Vitaly Lifshits (4):
  net/e1000/base: refactor K1 exit timeout configuration
  net/e1000/base: fix typo in e1000 base code
  net/e1000/base: reclassify MAC type
  net/e1000/base: clear DPG enable bit post MAC reset

 .mailmap                                     |  1 +
 drivers/net/intel/e1000/base/README          |  4 +-
 drivers/net/intel/e1000/base/e1000_82575.c   |  5 +-
 drivers/net/intel/e1000/base/e1000_api.c     | 20 ++++-
 drivers/net/intel/e1000/base/e1000_api.h     |  1 +
 drivers/net/intel/e1000/base/e1000_defines.h | 23 ++++++
 drivers/net/intel/e1000/base/e1000_hw.h      |  9 ++
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 28 +++++--
 drivers/net/intel/e1000/base/e1000_ich8lan.h |  3 +
 drivers/net/intel/e1000/base/e1000_mac.c     |  2 +-
 drivers/net/intel/e1000/base/e1000_manage.c  |  4 +-
 drivers/net/intel/e1000/base/e1000_phy.c     | 86 +++++++++++++++++++-
 drivers/net/intel/e1000/base/e1000_phy.h     |  2 +
 13 files changed, 169 insertions(+), 19 deletions(-)

-- 
2.43.0

