Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90218C36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 10:14:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B76F040A75;
	Fri, 11 Apr 2025 12:14:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 06F8E406B6
 for <dev@dpdk.org>; Fri, 11 Apr 2025 12:14:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366470; x=1775902470;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OTeeYmIo333Rp18aHvRcQDoo+8XA77uvXhzH8K0TPZ4=;
 b=FI2NY9vSYhqaUCi7hx4rmtosZwX+kS1WfUqQ3CoV9BqaxX3iS948499C
 xwG9WmlegWbiCaKGKpGm0umcHaaxBC0HkBqX+bGTE4ucbJiOe9B104MLK
 uM/SfAo4chVXP+lRxArFW62+Q5v6VvrHEOuUkMyrEiN7NbrG7qRNZGNpE
 EDMoU3Ku49Fd+RFCfJ6OuKBJ3iNyGt/ab9mUBOyC/bhfMihQH4M+aGFBk
 r/fBcemIJjKsGwRvqDkOTW0wKRZzgAJ/Q7Et2qm3aaxGraalOO/l0DcQN
 9mf2BQRLtUReCReL7ck+dzoBMV/krEtMbj/NwmZ19cWxaaB/y8ZExAoMZ w==;
X-CSE-ConnectionGUID: 3DCI9sG7T8qHA8DWUcdyrg==
X-CSE-MsgGUID: LSf62hRASZeEhxD5HonVKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56896766"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="56896766"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:14:29 -0700
X-CSE-ConnectionGUID: IWCvvF9UTbi+kWh8KG3W9w==
X-CSE-MsgGUID: CGaGNOiOQkeGRh0Niibpgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="160130570"
Received: from silpixa00400884.ir.intel.com ([10.243.22.90])
 by orviesa002.jf.intel.com with ESMTP; 11 Apr 2025 03:14:28 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: 
Cc: dev@dpdk.org,
	kai.ji@intel.com,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v2 0/5] add SNOW-V support in ipsec_mb PMD
Date: Fri, 11 Apr 2025 11:09:36 +0100
Message-ID: <20250411101425.3041736-1-radu.nicolau@intel.com>
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

Add support for SNOW-V and SNOW-V AEAD in ipsec_mb PMD.
Add unit tests and test vectors for SNOW-V and SNOW-V AEAD.
Add support in cryptoperf and eventdev test apps.


Radu Nicolau (5):
  crypto/ipsec_mb: add support for SNOW-V
  examples/l2fwd-crypto: add support for SNOW-V
  tests: add unit tests and test vectors for SNOW-V
  app/crypto-perf: add support for SNOW-V
  app/eventdev: update eventdev app for SNOW-V

 app/test-crypto-perf/cperf_ops.c              |   6 +-
 app/test-eventdev/evt_options.c               |   3 +-
 app/test/test_cryptodev.c                     | 599 ++++++++++++++++++
 app/test/test_cryptodev_aead_test_vectors.h   | 275 ++++++++
 app/test/test_cryptodev_snow_v_test_vectors.h | 213 +++++++
 doc/guides/cryptodevs/aesni_mb.rst            |   2 +
 doc/guides/tools/cryptoperf.rst               |   2 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c        |  70 +-
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h   |  52 ++
 examples/l2fwd-crypto/main.c                  |   3 +-
 10 files changed, 1217 insertions(+), 8 deletions(-)
 create mode 100644 app/test/test_cryptodev_snow_v_test_vectors.h

-- 
2.43.0

