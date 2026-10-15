Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7FACC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FEAF402E4;
	Thu, 15 Oct 2026 16:14:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 17061402DF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792073672; x=1823609672;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wZwnlIuJVhWiVUKMDM8EmWYH8myWnOcboEpIQm2mmEY=;
 b=PsBxfln2ep2EZ2n3pzKU8LuPVmLVTYvbSoFPWvSSQizw7VfXG0QdpViU
 6zfcSqUBNwJ7IegJ3YK7yLqX7pb+UbS+x6fe7nbRADRX6MMGCfuMYaMhG
 Q2K8negRPEqY6DbMLhMD7T2K69o5XiLZIE1K7JQQMuOPmENOOt1xuxGni
 0+6OD4IR3ktCLK/tWuKGWSGXSPLIqu/YBZtsDphiJt15soIgat3FvjGgc
 9xm9GaCcxoee94rLvSHv2P3Sqry0/zpep8wx9eNk2isvb82u9hAHSFkwn
 GGBCE7c0VlP0FHm3Iyhk1f77DtyBv3ulL1E7jwKwJu/7k1CIFvWm1AFBO w==;
X-CSE-ConnectionGUID: wWegQc9qQiOooOeb72hxEw==
X-CSE-MsgGUID: m5yezSgIRW6xUgHC4iGieQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="716745"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="716745"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:14:31 -0700
X-CSE-ConnectionGUID: 2DsW1+u9T8O2V4RyYYkgkg==
X-CSE-MsgGUID: yDULzjfXTbi+QIn8ibWibA==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2060546"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2026 07:14:29 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: marcel.d.cornu@intel.com, Radu Nicolau <radu.nicolau@intel.com>,
 Kai Ji <kai.ji@intel.com>
Subject: [PATCH v5 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Date: Thu, 15 Oct 2026 14:13:54 +0000
Message-ID: <20261015141426.2275568-1-radu.nicolau@intel.com>
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
 doc/guides/cryptodevs/features/aesni_mb.ini  |  14 +-
 doc/guides/rel_notes/release_26_11.rst       |  12 +
 drivers/crypto/ipsec_mb/ipsec_mb_ops.c       |  49 ++
 drivers/crypto/ipsec_mb/ipsec_mb_private.h   |  20 +
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c      | 267 +++++--
 drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h |  31 +-
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c       | 703 +++++++++++++++++--
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h  | 378 +++++++++-
 11 files changed, 1370 insertions(+), 141 deletions(-)

-- 
2.52.0

