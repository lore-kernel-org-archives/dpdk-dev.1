Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7DCCA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 13:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EFF640274;
	Mon, 12 Oct 2026 15:59:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1465F4026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 15:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791813593; x=1823349593;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9hLFN50d0BMbSkgI9y1nI/h+m+fLqnuN2EtJaCu8sW4=;
 b=ZgmI9iG3HueDb6YjIoxZC5l3H8omBvUEsms49dsVdwWplael5v5Kk3mm
 JA5OUKkexc4wU92sttndmnQr4NVToYEGJgP29xlrYF1jAQruxziMWbj0I
 tq0cG35+vRekzJ/kEE4SGI5EbEQ84LVQMHacNj0XzWRX6xZieJnLNk/hq
 jD/3z/sV49arjSsqP7HcYppB46T57UapJ5Ssv+GJbnTY0PdLk0/rcupwS
 CRtjMIw/o6NoARWfjqCPnCQrAE33/UTjXJMs2jH6JfZ8QVFwqL3KH1lBs
 RhIkwpjcoyPJpItzcDoeOzKGpYI00d/Y1Wq01PDR/cK8hDTNctgtae+FX g==;
X-CSE-ConnectionGUID: uWqCd9jiR024BgbhSrCz5w==
X-CSE-MsgGUID: yQ7PvX9vSG+I0AWMEsbLyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="530237"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="530237"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 06:59:52 -0700
X-CSE-ConnectionGUID: fnHjsRAOT/6v9IZR+hIiSQ==
X-CSE-MsgGUID: PJRnLxjeQJ6FhkkPrnxL4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1225132"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa007.fm.intel.com with ESMTP; 12 Oct 2026 06:59:50 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>,
	Kai Ji <kai.ji@intel.com>
Subject: [PATCH v3 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Date: Mon, 12 Oct 2026 13:58:37 +0000
Message-ID: <20261012135947.1895429-1-radu.nicolau@intel.com>
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
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c      | 267 +++++--
 drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h |  31 +-
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c       | 687 +++++++++++++++++--
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h  | 362 +++++++++-
 11 files changed, 1348 insertions(+), 138 deletions(-)

-- 
2.52.0

