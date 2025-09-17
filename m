Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737CECAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 09:17:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0145402DA;
	Wed, 17 Sep 2025 11:17:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5FE0B40144
 for <dev@dpdk.org>; Wed, 17 Sep 2025 11:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758100659; x=1789636659;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HSbV7G1Ck69N8VQJfU3O7FFkCn+lzbIBwiyRQ+k0Cd8=;
 b=Yx4zjPQqkjGxi7n2z2y8FiLiALxUc2nXfOu5muMvz1+qYzECw2cD4JqQ
 Us+8xH0hmwYSX/GIPOD6LpGRBUAEr4Sv5n2dLQlrCmXj41jK6+oEUna/M
 UZx7v8eS7g0xJ/I4ja051kTMsKEWjmrxYagXD1dcSOUZkDdTafw/e4aTr
 5s9zz9PY4YJFoIc1LulOdaR9MIdTiKOexCF8LK8cpiPOOmbpeWzUkGc1R
 Ds/c9vI/jDQrdhUQRqBxgpPMPxrokIV5prrbT59mj42HuJLMNnuvlinFr
 3hNAyMJsCTyOFjb2u1sqXaPpL9H+SJXxg6T1z/0Wu/5ly0phr52hVvNXB g==;
X-CSE-ConnectionGUID: kxP5pyqkTBadX/sAEmeDXw==
X-CSE-MsgGUID: ksuom4bJTlKHCdqJEBNYww==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60464521"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="60464521"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 02:17:38 -0700
X-CSE-ConnectionGUID: p7IHVL7QT6+yERSSouLoUQ==
X-CSE-MsgGUID: Ks0+j5/QSaWMH1pYZMBh4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="174760535"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa009.jf.intel.com with ESMTP; 17 Sep 2025 02:17:36 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/5] idpf and cpfl rx path selection simplification
Date: Wed, 17 Sep 2025 09:17:26 +0000
Message-Id: <20250917091731.3632520-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911143145.3355960-1-ciara.loftus@intel.com>
References: <20250911143145.3355960-1-ciara.loftus@intel.com>
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

This series refactors the vector capability detection and Rx path
selection code in the idpf and cpfl PMDs to use the common functions
provided in drivers/net/intel/common/rx.h.

v2:
* Moved AVX512DQ check to common code.
* Refactored rx function array definition for better readability.
* Restored Rx functions back to their original names.

Ciara Loftus (5):
  net/intel: add AVX512DQ flag to AVX-512 checks
  net/idpf: use the new common vector capability function
  net/idpf: use the common Rx path selection infrastructure
  net/cpfl: use the new common vector capability function
  net/cpfl: use the common Rx path selection infrastructure

 drivers/net/intel/common/rx.h                 |   5 +
 drivers/net/intel/common/rx_vec_x86.h         |   3 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 143 +++++-------------
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  12 ++
 drivers/net/intel/idpf/idpf_common_device.h   |  17 ++-
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  51 +++++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  12 ++
 drivers/net/intel/idpf/idpf_ethdev.c          |   2 +
 drivers/net/intel/idpf/idpf_rxtx.c            | 141 +++++------------
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  11 ++
 10 files changed, 180 insertions(+), 217 deletions(-)

-- 
2.34.1

