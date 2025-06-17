Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA372C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:23:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D05640E40;
	Tue, 17 Jun 2025 15:23:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4849B40609
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750166588; x=1781702588;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tGcP+zPDbV9wsk7Um4LZaMy5PM3DAC2rx1lcEHu5/Ds=;
 b=mWCHbb6LTG4YTX8lN5y0UrpSk0Ys0nVBJSWWtmthnMhDw/qryINWzVzN
 Sfz1H1l8iPgams0gpgTnfeMJSKv8Hx78gqRoiPcuNtS75QTtnJeIdMGDY
 BIqeP9TZ5HchzxmqM7i2ETbAsFiKA+Xa2r5TIqR+s27Ed2TfBmB72vAW5
 ielLnzrFC4EEg8krT9OQbBJdamgXyFsxWuGGFQnyZ2u0q5Mv/kGkJkjpG
 QLwVCmjL6LvsupFIguBySzVTWWc/LTE3Bu3archT+84pPgd16gRvr6raB
 Lhbmddp72sli7NuOzL9EOKaXtOiEPLCzVjHSx3BpqZDwuSssVOGKjJuKM Q==;
X-CSE-ConnectionGUID: nSXskY67T8CLPJh5XcnraA==
X-CSE-MsgGUID: OlgoUuiZTgKwT11EUJqb1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="54960504"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="54960504"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 06:23:06 -0700
X-CSE-ConnectionGUID: 5fyXuqsGQkK0pNV3emkxdg==
X-CSE-MsgGUID: oFkxSTPuRGCmdr2zEQQ3bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="172022242"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa002.fm.intel.com with ESMTP; 17 Jun 2025 06:23:05 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v6 0/4] Add TxPP Support for E830
Date: Tue, 17 Jun 2025 05:13:33 +0000
Message-ID: <20250617051337.563233-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617001429.551262-5-soumyadeep.hore@intel.com>
References: <20250617001429.551262-5-soumyadeep.hore@intel.com>
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
v6:
- Addressed Bruce's comments
- Fixed compilation warnings
---
Paul Greenwalt (1):
  net/ice: update E830 Tx Time Queue Context Structure

Soumyadeep Hore (3):
  net/ice: add read clock feature
  net/intel: add TxPP Support for E830
  doc: announce TxPP support for E830 adapters

 doc/guides/nics/ice.rst                    |  27 +++
 drivers/net/intel/common/tx.h              |   1 +
 drivers/net/intel/ice/base/ice_common.c    |  22 +-
 drivers/net/intel/ice/base/ice_lan_tx_rx.h |   4 +
 drivers/net/intel/ice/ice_ethdev.c         |  20 +-
 drivers/net/intel/ice/ice_rxtx.c           | 235 ++++++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx.h           |  32 +++
 7 files changed, 321 insertions(+), 20 deletions(-)

-- 
2.43.0

