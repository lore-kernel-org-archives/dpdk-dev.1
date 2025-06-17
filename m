Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA30C7115B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 06:45:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 383BB410D3;
	Wed, 18 Jun 2025 08:45:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 95A6340E0F
 for <dev@dpdk.org>; Wed, 18 Jun 2025 08:45:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750229145; x=1781765145;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t+ZUCU2XQRZ/GMnDkM+tD25Oppkzlb5MMPr6BMdnRvg=;
 b=i6XNzce19Ins+/jGVNFz9G/C/By35vC8DUkG2QBamDIVFujBrfnSTvTx
 QWa1QZcpIU0p84BG8Guraq0iMycZGj4zrBKUB3lD9rFgL29DzXjP35mXa
 kvtQEZN7E21x9q3Ft7pg2HShXGs2pTsfIPKQhXDoHWVMPGj2qbAm9sW2D
 uLm3PGde3jaqgTLB3xEXNpYFZze/DpLGhbZcuqEjzPWW1mrKY5kY+E+FY
 c1wpHZF524FQ3jGm5ENYCUweyyTEoNfTJojYHNusoU8rHN5CpwNieY+Sh
 Ti4iGKwMvBdO/e0fsF5013ygMKbY2m69MqTDXZRzZd6kb4bwUL7fFumHU Q==;
X-CSE-ConnectionGUID: YvSa5xHzTHW6WhKg6Bcxew==
X-CSE-MsgGUID: pGFdd6bbSle5kDICcIOakQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63469067"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="63469067"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 23:45:43 -0700
X-CSE-ConnectionGUID: fJcNynfATyeQ5aoTRW2Xmg==
X-CSE-MsgGUID: xqsf6TCoSPqRDztZWnKi+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="150110476"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa009.fm.intel.com with ESMTP; 17 Jun 2025 23:45:42 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v7 0/4] Add TxPP Support for E830
Date: Tue, 17 Jun 2025 22:36:10 +0000
Message-ID: <20250617223614.568996-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617051337.563233-5-soumyadeep.hore@intel.com>
References: <20250617051337.563233-5-soumyadeep.hore@intel.com>
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
v4:
- Addressed Bruce's comments
---
v5:
- Addressed Bruce's and Ciara's comments
---
v6:
- Addressed Bruce's comments
- Fixed compilation warnings
---
v7:
- Addressed Bruce's comments
- Fixed Windows Compilation Warnings
---
Paul Greenwalt (1):
  net/ice: update E830 Tx Time Queue Context Structure

Soumyadeep Hore (3):
  net/ice: add read clock feature
  net/intel: add TxPP Support for E830
  doc: announce TxPP support for E830 adapters

 doc/guides/nics/ice.rst                    |  27 +++
 drivers/net/intel/common/tx.h              |   1 +
 drivers/net/intel/ice/base/ice_common.c    |  22 +-
 drivers/net/intel/ice/base/ice_lan_tx_rx.h |   4 +
 drivers/net/intel/ice/ice_ethdev.c         |  20 +-
 drivers/net/intel/ice/ice_rxtx.c           | 235 ++++++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx.h           |  32 +++
 7 files changed, 321 insertions(+), 20 deletions(-)

-- 
2.43.0

