Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A768CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:56:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B353D40281;
	Fri,  2 Oct 2026 11:56:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 21BAE4003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 11:56:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790935017; x=1822471017;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VfM7dTHvzOSqx1vXhY3WccgARa7DhHsa72wyrcs7Aes=;
 b=O5ZraxeGGHNJIxWMlJJRh4NebCsWNLj7jXKzRRCWkczJvAgYFaOEdDxn
 hnMFVGLqXAFn8D47HLWH+SF9YkoQofq0mg17eeMTKObM76RPVVVFqtRDp
 zadZkVi4xUfh3fX51235mKcPjZ9tuh8+x7xRf2mCBW8/1x+vwfrVCs1Bv
 wUP58bAJDCLfDLWdma8fg2DGdRzuA/24Dqd+rtFeyiLcYUnBR6TT5xCgG
 P7WBr3FfKIYd0PiuorKKEGBT+lSZwcFKiBv1HvJP4TCG2WkI78OPT6E1D
 X4UHiq3B4kEbFLEYEc44HPhr7AALosIZmgAK9qTAEyOdXZFL7gcqlKzqr w==;
X-CSE-ConnectionGUID: bBL22WD3TmWcBK9FbMMXoQ==
X-CSE-MsgGUID: 9GjFs6GlQWmK5uhDqkP3lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94581559"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="94581559"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:56:56 -0700
X-CSE-ConnectionGUID: WjAtUSAvRfqU5K2S5+6HzQ==
X-CSE-MsgGUID: b9Hmjl8iTv6iIXrZ+KNhLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="274862056"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2026 02:56:56 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Date: Fri,  2 Oct 2026 09:56:20 +0000
Message-ID: <20261002095652.1540556-1-radu.nicolau@intel.com>
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
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c      | 267 +++++--
 drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h |  31 +-
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c       | 695 +++++++++++++++++--
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h  | 360 +++++++++-
 11 files changed, 1354 insertions(+), 138 deletions(-)

-- 
2.52.0

