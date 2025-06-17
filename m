Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0808C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 08:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8746640668;
	Tue, 17 Jun 2025 10:24:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 70D1A402DC
 for <dev@dpdk.org>; Tue, 17 Jun 2025 10:24:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750148654; x=1781684654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F2tJSuU/gwermmfkJRk3gX/azpMugEbew+0W8FW+SYg=;
 b=TXNHrnrraM7iSdWrf7MHpJHpvIEctpwpNYnA23ng1i3mAQ3YdIiJWEpd
 hccTAlYgCgv8ZpABv5ox++c62IZADSddQbFmenkAgLOw0AYtxTvVlNbXX
 ZQmSMHEuHP3TTzS6mEMarYNfkt+3i5YuyKB7NocUwu8I9qGttP+D55a+g
 wxxcPobmtkZwH4IHQgt4DZCVoJNUeJqq9YT1ER8bquZO3F+Esi3fPfqNH
 AoIj6HzN6GFdc/9OoVzR607nF6OVsNnAZ4rFc7cdlbhNjSxM5xYHsNO6z
 2MM0NK54SX9baGryWz7oFpBvQxgKPGbnO+CHXm5HMAwx9hZkjNBVZ43m4 w==;
X-CSE-ConnectionGUID: uE5frJ1JQFm/6UFcbofdXw==
X-CSE-MsgGUID: RXAh0vZRSLOC4o2+usR+Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52449720"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52449720"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 01:24:13 -0700
X-CSE-ConnectionGUID: 6xpr/ZakS/WPFxytigQqSg==
X-CSE-MsgGUID: OjZK9qKESrm+d7aosnN+bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="148563824"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa006.fm.intel.com with ESMTP; 17 Jun 2025 01:24:10 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v5 0/4] Add TxPP Support for E830
Date: Tue, 17 Jun 2025 00:14:25 +0000
Message-ID: <20250617001429.551262-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610131159.495566-2-soumyadeep.hore@intel.com>
References: <20250610131159.495566-2-soumyadeep.hore@intel.com>
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

Added TxPP support for E830 adapters.
---
v2:
- Fixed Compilation warnings
---
v3:
- Fixed further Compilation warnings (uinitialised one)
---
v4:
- Addressed Bruce's comments
---
v5:
- Addressed Bruce's and Ciara's comments
---
Paul Greenwalt (1):
  net/ice: update E830 Tx Time Queue Context Structure

Soumyadeep Hore (3):
  net/ice: add read clock feature
  net/intel: add TxPP Support for E830
  doc: announce TxPP support for E830 adapters

 doc/guides/nics/ice.rst                    |  25 +++
 drivers/net/intel/common/tx.h              |   1 +
 drivers/net/intel/ice/base/ice_common.c    |  22 +-
 drivers/net/intel/ice/base/ice_lan_tx_rx.h |   4 +
 drivers/net/intel/ice/ice_ethdev.c         |  16 +-
 drivers/net/intel/ice/ice_rxtx.c           | 250 ++++++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx.h           |  32 +++
 7 files changed, 330 insertions(+), 20 deletions(-)

-- 
2.43.0

