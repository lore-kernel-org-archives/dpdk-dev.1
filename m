Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2089C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 20:49:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5F6C40280;
	Fri,  7 Feb 2025 21:49:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 71F8740270
 for <dev@dpdk.org>; Fri,  7 Feb 2025 21:49:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738961347; x=1770497347;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jigK6WbTUIyV66FmIiLvLusosiFqS23HWPu8qVUCzFs=;
 b=b2Mp/GuSSqHPkSmlMzahb/kuSl5Wiakw5ndCrRcQiETNb+F0wfk3m4KE
 zOLWtVbhyME0/4IPSs2PPJDmtYVmMlDBfo20WRDINFlz24Ru7OpGyw46L
 KoV5Yyqx5mw0WpFs15AmQLJyM4jRxfSv++LtShM/kFRseR/nL6Zw6QpR8
 JW1BnHcka6IluE5+2mLdmNFC7n/sOnIyegc0riS8ze6fmYbYDEoSUX4uv
 s7dOKMKHMokwlSlwpAmjm2kGdb9Vbx26cilz25OIAcu27IoandLY5joGy
 Dxvk2blG5Q6d2YJs2fxumOaabvY9Zst/tUSTc1C9d+sL+YpE0/JmbEgNZ w==;
X-CSE-ConnectionGUID: 9Y8A2W5bQvO3lY//6vkrqw==
X-CSE-MsgGUID: vJVfrMjUSGW3hhOmbDFNrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39742255"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; d="scan'208";a="39742255"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 12:49:03 -0800
X-CSE-ConnectionGUID: woPdQOBGSUmMamB7GFdBUQ==
X-CSE-MsgGUID: mrWwMK+QTQiBS/fdEJY9VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; d="scan'208";a="116631306"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by orviesa004.jf.intel.com with ESMTP; 07 Feb 2025 12:49:02 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v1 0/3] Implement TXPP Support in ICE PMD
Date: Fri,  7 Feb 2025 12:42:57 +0000
Message-ID: <20250207124300.1022523-1-soumyadeep.hore@intel.com>
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

This patchset includes TXPP feature implementation in ICE PMD.

Paul Greenwalt (2):
  net/intel: add support for timestamp ring HW workaround
  net/intel: add E830 ETF offload timestamp resolution

Soumyadeep Hore (1):
  net/intel: add Tx time queue

 drivers/net/intel/common/tx.h              |   5 +
 drivers/net/intel/ice/base/ice_lan_tx_rx.h |   5 +
 drivers/net/intel/ice/ice_ethdev.h         |   1 +
 drivers/net/intel/ice/ice_rxtx.c           | 174 +++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.h           |   5 +
 5 files changed, 190 insertions(+)

-- 
2.43.0

