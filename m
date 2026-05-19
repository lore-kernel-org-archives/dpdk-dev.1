Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE67FCD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 14:52:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01B1740662;
	Tue, 19 May 2026 16:52:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7DEE44025E
 for <dev@dpdk.org>; Tue, 19 May 2026 16:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779202363; x=1810738363;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+jRNJV8ib/gSs0K9bW+Ys5O4NSX6vwaPdo6gH5zO4tk=;
 b=WWz6pHIkS9rF+XKb9urJw9HMPgz9Kh23zsMqIOnWKBttJdPnFHyI0Qb2
 1Fph24DQhuRH9n/9NA0nSxFMB6wN4FsPAfPd27H5sA6SpIJMXJ9E2rrqK
 ucu+6KXej4wOnsPdFcgk7601kOvIVF+SQePTEFJHHtvxxN2xPy1dCWH53
 ZCjXXh2llFMaWmo1VT1BWwiYXlw6GO30xXHW05PnLs6/lDCyuBoDZ5RHB
 pGmfnYEeCzHweUqPy75PPgL5SaRL4jhDjT6GPOVkoPAze7QwelYzv7zcQ
 p5EuFZv6laAWW62VzglQkej+ZPu9KHCTlhfdT5giEvNCrADORTjaF2JEd w==;
X-CSE-ConnectionGUID: b9ySgZT6SgqtMX8KCr7jnw==
X-CSE-MsgGUID: veEMz+NlQmur4uJfEuH0Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90383753"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="90383753"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 07:52:42 -0700
X-CSE-ConnectionGUID: 4jmv7b/SQ2S6IOvbexA1xg==
X-CSE-MsgGUID: Hr84RKIzS+GXJ7PDNSiz5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="238794381"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 19 May 2026 07:52:41 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/3] i40e base code update
Date: Tue, 19 May 2026 14:52:20 +0000
Message-ID: <20260519145227.308814-1-ciara.loftus@intel.com>
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

Update the i40e base code. Both patches address integer type width issues
that can cause incorrect behaviour and are candidates for stable backport.

Chinh Cao (1):
  net/i40e/base: fix integer overflow in NVM timing logic

Ciara Loftus (1):
  net/i40e/base: update version info

Deepthi Kavalur (1):
  net/i40e/base: fix loop counter width in DCB parsing

 .mailmap                                     |  1 +
 drivers/net/intel/i40e/base/README           |  4 +-
 drivers/net/intel/i40e/base/i40e_dcb.c       |  6 +-
 drivers/net/intel/i40e/base/i40e_nvm.c       | 67 +++++++++++++-------
 drivers/net/intel/i40e/base/i40e_prototype.h |  2 +-
 drivers/net/intel/i40e/base/i40e_type.h      |  2 +-
 drivers/net/intel/i40e/i40e_ethdev.c         |  3 +-
 7 files changed, 55 insertions(+), 30 deletions(-)

-- 
2.43.0

