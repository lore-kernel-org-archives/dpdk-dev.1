Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92F3CA9EC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 12:28:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 876C940274;
	Mon, 12 Oct 2026 14:28:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 161FA4026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791808132; x=1823344132;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4ojmljEGmqJh3FY1AeQDrfD0Cdj9Ygikqcl951YkVoY=;
 b=ES2tU2uKaFVs9OHVSiYyK1DGOkynO9dg70TX+P3WmIO+Ejai5RKPUYN0
 haPO/2rmhChulNYdQCxTCxSAh7Wt0ZhZFhdcHKrY/RPKbKj8cBPXW8T+T
 AYN2zCNw1607rxOLGcs6SISe41ujPN8uZ9AIfOi8zTApUpeTeymgXn5Od
 fbBpDyI/ysYh7z29O/w5GfIJtJWsSJ5j3HKHQ7JbiDoCgiufHz0ORy6Vn
 6j3hbFad+gTscGWOI7mEsSalXThLsQIuTU8VDMQAtGfmMhXGJlk9YdGIy
 hCe6PMzqu9FmJj7I5vtxB0pSg94yY9Si2P9aLId3wA+gu2nxuPvBZ6BAg g==;
X-CSE-ConnectionGUID: Bb1dVy/wQqWyaMtQa5Ewwg==
X-CSE-MsgGUID: eTvkTVkXTKGtfgPhU96gyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="400300"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="400300"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 05:28:50 -0700
X-CSE-ConnectionGUID: 8hEaO1guSQGaSU0dG9+A/A==
X-CSE-MsgGUID: 4FMYyQ0iT2mEfKbLn4Dy3A==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="864627"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa001.jf.intel.com with ESMTP; 12 Oct 2026 05:28:50 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>,
	Kai Ji <kai.ji@intel.com>
Subject: [PATCH v2 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Date: Mon, 12 Oct 2026 12:24:15 +0000
Message-ID: <20261012122841.1887023-1-radu.nicolau@intel.com>
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
 doc/guides/rel_notes/release_26_11.rst       |  12 +
 drivers/crypto/ipsec_mb/ipsec_mb_ops.c       |  58 ++
 drivers/crypto/ipsec_mb/ipsec_mb_private.h   |  20 +
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c      | 267 ++++++--
 drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h |  31 +-
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c       | 685 +++++++++++++++++--
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h  | 362 +++++++++-
 11 files changed, 1346 insertions(+), 138 deletions(-)

-- 
2.52.0

