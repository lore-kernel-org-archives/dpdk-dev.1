Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F77EC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:09:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE72C402F1;
	Thu,  6 Feb 2025 17:09:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 312824029A
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858141; x=1770394141;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Stnmg+SvVGlQq1MDg04VVYAoVAemHdNiPaW7NAVghSo=;
 b=VYGxU+QQl7smdKS4T0r18sY9rXUtrmkEyiK6FILlmSo2hSn8zs3GGCbu
 LlcIMvQKe1y+BJX0qwyGm1nefqv0RVDNIUQjwWEfeh7s3k55183dnQih9
 Hmz5cAgIWYpqPDN+C435Usb9g3Jo/GNOZTh7AyixcNwAidfBPEfyRfKjv
 oN8G7MHeHuEaAEoOPr2PTp5gS9N1cxl8pA/tX2L7kQcWi049EWL7GKRaN
 1nPFKfG9bakyJ4NPPlvfdRhXM9F2PkFp7n1QczSdwAouJAR8koLnzNSQf
 n/vN9x+vyWWJhhE0soiV9hF85cMswuxiUQvRjjUzxNOOIONlYblPmrcEo A==;
X-CSE-ConnectionGUID: 6yLDkrM2QOiIGs8djo3YPA==
X-CSE-MsgGUID: rFukGVZoRdyHUcgQGNxtoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860705"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860705"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:00 -0800
X-CSE-ConnectionGUID: FVkx+0WsSqKlUdkgvWfMzQ==
X-CSE-MsgGUID: 2H5pgpVuSH2uwJQ2NxZ09A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166588"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:08:59 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 00/24] Fixes for igc and e1000
Date: Thu,  6 Feb 2025 16:08:23 +0000
Message-ID: <cover.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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

This patchset is taken out of recent e1000/igc driver update [1].

[1] https://inbox.dpdk.org/dev/cover.1738681725.git.anatoly.burakov@intel.com/

Aleksandr Loktionov (2):
  net/igc/base: fix MAC addr hash bit shift
  net/e1000/base: fix MAC addr hash bit shift

Amir Avivi (2):
  net/igc/base: fix iterator type
  net/e1000/base: fix iterator type

Anatoly Burakov (1):
  net/e1000/base: correct mPHY access logic

Barbara Skobiej (3):
  net/igc/base: fix data type in MAC hash
  net/e1000/base: fix data type in MAC hash
  net/e1000/base: fix reset for 82580

Carolyn Wyborny (1):
  net/e1000/base: skip MANC check for 82575

Dima Ruinskiy (5):
  net/igc/base: fix deadlock in i225
  net/igc/base: fix infinite loop
  net/igc/base: fix typo in LTR calculation
  net/igc/base: fix unused value
  net/e1000/base: fix unchecked return

Jakub Buchocki (1):
  net/e1000/base: fix uninitialized variable usage

Pawel Malinowski (2):
  net/igc/base: fix semaphore timeout value
  net/e1000/base: fix semaphore timeout value

Przemyslaw Ciesielski (4):
  net/igc/base: fix bitwise op type mismatch
  net/igc/base: fix static analysis warning
  net/e1000/base: fix static analysis warning
  net/e1000/base: fix static analysis warning

Sasha Neftin (3):
  net/igc/base: increase PHY power up delay
  net/igc/base: reset loop variable
  net/igc/base: fix LTR for i225

 .mailmap                                      |  3 +++
 .../net/intel/e1000/base/e1000_80003es2lan.c  |  2 +-
 drivers/net/intel/e1000/base/e1000_82575.c    |  5 ++--
 drivers/net/intel/e1000/base/e1000_base.c     |  3 ++-
 drivers/net/intel/e1000/base/e1000_defines.h  |  1 +
 drivers/net/intel/e1000/base/e1000_ich8lan.c  |  2 ++
 drivers/net/intel/e1000/base/e1000_mac.c      | 12 +++++----
 drivers/net/intel/e1000/base/e1000_nvm.c      |  4 +--
 drivers/net/intel/e1000/base/e1000_phy.c      | 25 +++++++++----------
 drivers/net/intel/e1000/base/e1000_vf.c       | 12 +++++----
 drivers/net/intel/igc/base/igc_defines.h      |  1 +
 drivers/net/intel/igc/base/igc_i225.c         | 24 ++++++++++++------
 drivers/net/intel/igc/base/igc_mac.c          | 10 +++++---
 drivers/net/intel/igc/base/igc_nvm.c          |  4 +--
 drivers/net/intel/igc/base/igc_phy.c          |  8 +++---
 15 files changed, 68 insertions(+), 48 deletions(-)

-- 
2.43.5

