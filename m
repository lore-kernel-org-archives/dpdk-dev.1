Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB021CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 14:22:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9531E4021E;
	Wed, 14 Oct 2026 16:22:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8318840144
 for <dev@dpdk.org>; Wed, 14 Oct 2026 16:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791987742; x=1823523742;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eK0F86OJKEkmjpYz07mCqDOKE/gATiX9+IRvy0Lze1M=;
 b=VUs6jqk5O+zDsZyxBRSyx7JD0sPyB4GfAVVU7KL4IJku/Vbff8E7bX62
 tpyQ2RnnnXojkIoIcrhPR+9iwAZm440bmEXzN86DRvfpnoH/t0VH5FEbc
 vJ87dYIDfYBu4K5CDwZbquWtBg2ZIU6kBGE63nR49J9P6KW2UzyBAax4H
 Fn7cWs1Rt8A0qtaINHJZAXs99cgGmz65znBn4yGqZR6Ud2IHZoC/0Rsji
 BU3RllVYfKKCTZkQ0pglZ1gXbHS8UZ39zHi8eIpoauaoUeAdCOMA8GEly
 Sxj5P7r3qkWKyCs/A/iD8D0Hi392++cL22oGGizYu6/DavjhUzZEH6RhY Q==;
X-CSE-ConnectionGUID: APk82iKTSde9Awk4CBsx7Q==
X-CSE-MsgGUID: L5Milmp0RrS8M/3Jbm1fXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="766324"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="766324"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 07:22:21 -0700
X-CSE-ConnectionGUID: AXCwMrrNSKeCuKX1wlXIKQ==
X-CSE-MsgGUID: 87MDyaAbSeSmpkIz9WIDeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1403567"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa001.jf.intel.com with ESMTP; 14 Oct 2026 07:22:19 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>,
	Kai Ji <kai.ji@intel.com>
Subject: [PATCH v4 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Date: Wed, 14 Oct 2026 14:21:33 +0000
Message-ID: <20261014142217.2117229-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Intel(R) Multi-Buffer Crypto for IPsec Library released version 3.0.0
codenamed Túnel Pablo
https://github.com/intel/intel-ipsec-mb/releases/tag/v3.0.0

This patchset adds support for the new library version and support
for the new algorithms included in this release.

Series-acked-by: Kai Ji <kai.ji@intel.com>

Radu Nicolau (4):
  crypto/ipsec_mb: add support for IPsecMB 3.0
  crypto/ipsec_mb: add support for 256-NxA4/5/6 algorithms
  crypto/ipsec_mb: add support for ML-KEM and ML-DSA
  test/crypto: add asym test suite for AESNI_MB

 app/test/test_cryptodev_asym.c               |   7 +
 doc/guides/cryptodevs/aesni_gcm.rst          |   4 +-
 doc/guides/cryptodevs/aesni_mb.rst           |  26 +-
 doc/guides/cryptodevs/features/aesni_mb.ini  |  12 +
 doc/guides/rel_notes/release_26_11.rst       |  21 +
 drivers/crypto/ipsec_mb/ipsec_mb_ops.c       |  49 ++
 drivers/crypto/ipsec_mb/ipsec_mb_private.h   |  20 +
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c      | 267 +++++--
 drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h |  31 +-
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c       | 702 +++++++++++++++++--
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h  | 375 +++++++++-
 11 files changed, 1372 insertions(+), 142 deletions(-)

-- 
2.52.0

