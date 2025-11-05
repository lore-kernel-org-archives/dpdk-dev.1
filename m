Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37278CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 15:26:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D6A84066D;
	Wed,  5 Nov 2025 16:26:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5747E4021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 16:26:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762356416; x=1793892416;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oGnJpeTLE92C2CTVMLXoGP3RXPMzD7S9xiGL6jYSuqI=;
 b=TchTh3FpoVw/5H6lrpgEwmbSZ7yEZY13fdFSTesj3UXxzuG/cqZYUHwd
 Gg4FHtYSKpP9Py72YlEW8UuT5586nW8Gymyw3QG10WJerEf3WZ16f4uKJ
 f+1OdTYoNR2vcI2n8eQFDbDrcaYvbUZrBqP40pRgeDw172x5kJAAfLMX5
 XZMjBxzZkDAkn9rvA4Fts77Y5U9+q0RZ73rMaGnpyqvJuVAAG9sT52YL8
 VArxCa9vyflDVKeLKD92l1pb31ixCGPHI2tOyB2osI2QTN6etDfzsqcAY
 PSAjxCJXJ/zaJ7lnmYynf8cs4sqVJ139Gj0OVqqK89tmQHptA344TMig2 g==;
X-CSE-ConnectionGUID: SYSEKgXHQsSYDMQNIOMnfA==
X-CSE-MsgGUID: Of2UrcSARiWGM8Lz6sqmEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68127080"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="68127080"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 07:26:54 -0800
X-CSE-ConnectionGUID: SVXpetWVST6pVmtc0LfAYQ==
X-CSE-MsgGUID: ck06Y3SNQm+A4DBQycuS4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="218257299"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2025 07:26:53 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/6] Fixes for iavf VLAN insertion offload
Date: Wed,  5 Nov 2025 15:26:36 +0000
Message-Id: <20251105152642.2981673-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031152250.2441980-1-ciara.loftus@intel.com>
References: <20251031152250.2441980-1-ciara.loftus@intel.com>
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
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 21 +++--
 3 files changed, 67 insertions(+), 90 deletions(-)

-- 
2.34.1

