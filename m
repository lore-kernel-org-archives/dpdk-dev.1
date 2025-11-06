Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFC3CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 11:50:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2D494021F;
	Thu,  6 Nov 2025 12:50:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1099A4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 12:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762429821; x=1793965821;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FtNHCJnTcI7USNBG/NBU9yaOzsiK4nXij8CzvSsgMJE=;
 b=BNdrKYIY7ML0ZBCsaUnktXvru1Y6/V/nir0saRTJepGD4Ktgv10NL1a2
 uHXXUPBZfup+YCazePDRFgD7C968/4/R05p7+kJ5nqTf7HsZcKyMJqi0o
 ZlvMAOqf6O9XKmPST2hSVrtOZ6PEbs8Cv4cZmz0Loe5X13ZLl0OlHD8SX
 dGQCOsLUbF0JeGcxzTTRQpRp0h8wjt5bZL2FY280DY55nORo/cogwMEVY
 w9ZD+s0Szdsbv4eFGYIn9LIMPUPhLcgyREEpQyanzss3M1l2JrciIkDLp
 E0pm0oAyJGxxJa2kupsbcK7LVA9itEEuN7xmF1QKuj5L16XraZ8IHVf+9 w==;
X-CSE-ConnectionGUID: gZ6wssKfSmu4d9QPcNnIKQ==
X-CSE-MsgGUID: CnlBQQlxQEaABY4e+FM6gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="52129781"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="52129781"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 03:50:20 -0800
X-CSE-ConnectionGUID: r/N8UdsxROGfrAndOFMIyQ==
X-CSE-MsgGUID: xlkRceAjT22xecI/2295WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187898339"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa008.jf.intel.com with ESMTP; 06 Nov 2025 03:50:19 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 0/6] Fixes for iavf VLAN insertion offload
Date: Thu,  6 Nov 2025 11:50:10 +0000
Message-Id: <20251106115016.3035639-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105152642.2981673-1-ciara.loftus@intel.com>
References: <20251105152642.2981673-1-ciara.loftus@intel.com>
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

A series of fixes for VLAN insertion offload in the iavf PMD.

v3:
* Use RTE_SET_USED instead of #ifdefs in patch 1.

v2:
* Split AVX512 QinQ fixes into two separate patches (5 and 6)
* Remove duplication in AVX-512 VLAN insert logic
* Ensure correct behaviour when IAVF_TX_VLAN_QINQ_OFFLOAD  is set/unset
* Consistent checking of mbuf offload flags before vlan location flags
* Reorder, put fix for existing AVX-512 bulk logic before introducing single tx logic for QinQ

Ciara Loftus (6):
  net/iavf: fix compilation with VLAN insertion disabled
  net/iavf: remove duplication in AVX-512 VLAN insert logic
  net/iavf: ensure correct conditions for AVX-512 VLAN offload
  net/iavf: fix single VLAN insertion positioning
  net/iavf: fix QinQ insertion for single packet Tx
  net/iavf: fix QinQ insertion with mbuf flags VLAN and QINQ

 drivers/net/intel/iavf/iavf_rxtx.c            | 53 +++++-------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 83 ++++++++-----------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 16 ++--
 3 files changed, 63 insertions(+), 89 deletions(-)

-- 
2.34.1

