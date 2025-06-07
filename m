Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7778C5B543
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 01:18:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60C3A4014F;
	Sun,  8 Jun 2025 03:18:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id CD049400EF
 for <dev@dpdk.org>; Sun,  8 Jun 2025 03:18:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749345522; x=1780881522;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5FEGSOQb2OOEuy022OKzV99585eOl7idr5teyMWuvwo=;
 b=QbjM6VXoPOoAkRIktlLbHrrpZ8EXMdNmbCPGAh97gjK0o/hxfPkb3Q0w
 yJhgKNB/U6TNjUHUEG1lxdkgLYIyNVlxCpTq69GhJHEtlbYC0WwQrz4e6
 //FCJVctZN9qhYXKXcX4nALzXvMwsqN1RrC8iQy2Lf95WLsHenkfcCQ38
 upqnfuRW70HKPRgy+KD5ToiIJe26X5J5s/+QPLu+Bi8ZoSxodUqUvJj8X
 IFNyihiRYyB4X/VlPvFnmUn0Cju04mf4q4x3z5nDhJrneQ5upSovSJaYD
 Z14lP8flwoEpGbmu0nw5jMRmcKZthT2iXjVsF4vCw31VgESaeMNWRygxO w==;
X-CSE-ConnectionGUID: w/05c99yR7ubpVqHy16amA==
X-CSE-MsgGUID: kgEXjHZXTc2AvHhv7DyKGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11457"; a="62856893"
X-IronPort-AV: E=Sophos;i="6.16,219,1744095600"; d="scan'208";a="62856893"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2025 18:18:40 -0700
X-CSE-ConnectionGUID: M/8skN7eSUuRlBII/2KA7Q==
X-CSE-MsgGUID: 7aXFzFfgQNqCBtgDySK0RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,219,1744095600"; d="scan'208";a="146676558"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa010.fm.intel.com with ESMTP; 07 Jun 2025 18:18:39 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v2 0/6] Add TxPP Support for E830
Date: Sat,  7 Jun 2025 17:08:58 +0000
Message-ID: <20250607170904.480937-1-soumyadeep.hore@intel.com>
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
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 136 +++++++++++-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 207 ++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx_vec_common.h |  17 ++
 11 files changed, 661 insertions(+), 24 deletions(-)

-- 
2.43.0

