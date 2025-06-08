Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA5C5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 19:42:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC1AE4026B;
	Sun,  8 Jun 2025 21:42:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4A4BF40269
 for <dev@dpdk.org>; Sun,  8 Jun 2025 21:42:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749411722; x=1780947722;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TdlSQ9kQWxEK8saBowvkSnQNEB0/byQFc+5mnltq0F4=;
 b=AE6BE7sAUMK2HXRPuy52oOBewg82ZsZkooqBi3M2C4h5nHdIyZoFBUUb
 GEd095jVRBr6IHqRv21bTq700zjXUpEa1SIwRcs+S4or0spm6Ht8g9R/Z
 x7p7LTGRlaSi+fGY2hWpUblOBa+66kqdL7O22sYFnjvhGFmdfZu43T4yv
 0PA7d16DeEAOdvSloX5YKPSRZG7oGRT9/7qPeaHmAX6MOMrBvNuLoG9tr
 PawrXnv8Qdg/XYlpV/MQXEmngDvtmoDyt8T60sfmg9hvxA5xY/U6dg+gX
 E1Ng4N0ANu0SMFrmlaQm+ksQUh9zmxV9Lwd1UaCsrY/6DH8WemR5JMIi1 w==;
X-CSE-ConnectionGUID: NgidpZrCRiCy2lkrpYTyLg==
X-CSE-MsgGUID: Hd4ikyUTQumToKrONEfD9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="61757547"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; d="scan'208";a="61757547"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2025 12:42:00 -0700
X-CSE-ConnectionGUID: EKlQIaTxQh+qFzkEF2wbbg==
X-CSE-MsgGUID: AOjgvCz4S9mWffn7WxJnhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; d="scan'208";a="146847493"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa010.fm.intel.com with ESMTP; 08 Jun 2025 12:41:58 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v3 0/6] Add TxPP Support for E830
Date: Sun,  8 Jun 2025 11:32:17 +0000
Message-ID: <20250608113223.487043-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606211947.473544-2-soumyadeep.hore@intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
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
Paul Greenwalt (1):
  net/intel: update E830 Tx Time Queue Context Structure

Soumyadeep Hore (5):
  net/intel: add read clock feature in ICE
  net/intel: add TxPP Support for E830
  net/intel: add AVX2 Support for TxPP
  net/intel: add AVX512 Support for TxPP
  doc: announce TxPP support for E830 adapters

 doc/guides/nics/ice.rst                     |  16 ++
 drivers/net/intel/common/tx.h               |  14 ++
 drivers/net/intel/ice/base/ice_common.c     |  22 +-
 drivers/net/intel/ice/base/ice_lan_tx_rx.h  |   4 +
 drivers/net/intel/ice/ice_ethdev.c          |  16 +-
 drivers/net/intel/ice/ice_ethdev.h          |  12 +
 drivers/net/intel/ice/ice_rxtx.c            | 232 +++++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx.h            |   9 +
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 135 +++++++++++-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 206 ++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx_vec_common.h |  17 ++
 11 files changed, 661 insertions(+), 22 deletions(-)

-- 
2.43.0

