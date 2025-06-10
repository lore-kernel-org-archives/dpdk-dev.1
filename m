Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863A2C61DB2
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 21:21:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C19640144;
	Tue, 10 Jun 2025 23:21:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 43304400EF
 for <dev@dpdk.org>; Tue, 10 Jun 2025 23:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749590497; x=1781126497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V/dGcQnrANlVGDMya4gxLm2P5mGX/4aT+cf3czSy7uM=;
 b=QCyEAKOX+vcT+czNdPZ34lA5DsX2iwzYbNwGThhpRSK/k0vWjqtGpnfr
 cRiM2jEXRoOOFeeIz0etGAbGzIJwSX8EGYHgHppvVHT32qJuBJbzI0YLC
 QzT3Xe3aEbMIlu/hBf3f5QQYopqF2Rq4Khc1/eMrt0wbPlY4UJtP3Plc2
 UbJOeb+8hVRxe9zche+bL4N6wFZCXC2fUUt3zCmAc+Ewb4TQYaPAYW/ZZ
 XZ+3e5dT5OAYEb9Lizzqz7/n+fRYqPzO5HeF4YQRpKX0nz9Sjn/BEOyxB
 SNKvQpx8gUnShKk92c871/Hv24NTDEnGgarB+wn6r/2EQGfeAL4wdbXW6 Q==;
X-CSE-ConnectionGUID: hDHK/1FpRbi70I3erBSutQ==
X-CSE-MsgGUID: OYFNqzOFRsS7OZFT4YvuYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51710195"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; d="scan'208";a="51710195"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 14:21:36 -0700
X-CSE-ConnectionGUID: 6AILtr9XR1K6m9/Nz3xUCQ==
X-CSE-MsgGUID: spbZJJNUSBejrF/ZjpokAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; d="scan'208";a="170157904"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa002.fm.intel.com with ESMTP; 10 Jun 2025 14:21:34 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v4 0/6] Add TxPP Support for E830
Date: Tue, 10 Jun 2025 13:11:53 +0000
Message-ID: <20250610131159.495566-1-soumyadeep.hore@intel.com>
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
v4
- Addressed Bruce's comments
---
Paul Greenwalt (1):
  net/intel: update E830 Tx Time Queue Context Structure

Soumyadeep Hore (5):
  net/intel: add read clock feature in ICE
  net/intel: add TxPP Support for E830
  net/intel: add AVX2 Support for TxPP
  net/intel: add AVX512 Support for TxPP
  doc: announce TxPP support for E830 adapters

 doc/guides/nics/ice.rst                     |  18 ++
 drivers/net/intel/common/tx.h               |  14 ++
 drivers/net/intel/ice/base/ice_common.c     |  22 +-
 drivers/net/intel/ice/base/ice_lan_tx_rx.h  |   4 +
 drivers/net/intel/ice/ice_ethdev.c          |  16 +-
 drivers/net/intel/ice/ice_ethdev.h          |  11 +
 drivers/net/intel/ice/ice_rxtx.c            | 229 +++++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx.h            |   9 +
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 127 ++++++++++-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 198 ++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx_vec_common.h |  25 +++
 11 files changed, 651 insertions(+), 22 deletions(-)

-- 
2.47.1

