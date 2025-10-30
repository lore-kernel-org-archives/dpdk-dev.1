Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F78BCCF9EA
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 04:53:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40D2F40652;
	Thu, 30 Oct 2025 05:53:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 1C17B40651;
 Thu, 30 Oct 2025 05:53:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761799990; x=1793335990;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dIi5zuJW2C83nEy2jh1khwtgDtVu58liIn12sL7f3Dw=;
 b=Q92onik0zvTL++ybTSoNqsKzZFUK3BRcz796vyUWBNcFUQLEGjJ4io9X
 jLm32czvPkvEcfC1XCP7IEmpoESMMqQE46RZw736+wGeHyKckWHREgUqq
 /4ZB5bskHYB8tA8HbTt222l5aUtrkow9apxSWugiMfHbUbmCvWcIoRQu3
 2LTVy/r2LPdrKE7tWKcVfQrkDLAsmS5BqDPS0cgxUbv5pGRBxwc+k+582
 TbSbvBF6BB7nSbYuUxmQKmM0pSLST+dFdOOZbtZo4uf9DI7vI4HbFYyn+
 ntTBt/6qr5ciN76/HXoxoLpGzJxfV3o2DkMl/T8nz51ii6krOnWQY/NMQ Q==;
X-CSE-ConnectionGUID: RW9jeg7iQs2gJRwQDeFwYg==
X-CSE-MsgGUID: Ees1bF2WS6av5WHBy6aMOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74225269"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="74225269"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 21:53:09 -0700
X-CSE-ConnectionGUID: cf6/ThBJQjmYz1z8+9x8FA==
X-CSE-MsgGUID: 2f5G0m+DTC68M8JizzSTpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="185733151"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2025 21:53:06 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com, ciara.loftus@intel.com, stable@dpdk.org
Subject: [PATCH v2 3/3] doc: update TxPP documentation
Date: Thu, 30 Oct 2025 13:33:04 -0400
Message-ID: <20251030173304.260209-4-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251030173304.260209-1-soumyadeep.hore@intel.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
 <20251030173304.260209-1-soumyadeep.hore@intel.com>
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

TxPP feature works only when DPDK library is compiled with
PTP feature enabled and application is run on PF.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 doc/guides/nics/ice.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 7e9ba23102..a15304fb34 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -457,6 +457,10 @@ This feature is currently supported only in E830 adapters.
 The flag ``RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP`` is used to enable the feature.
 In order to deliver timestamps internally ``set txtimes`` is used,
 where inter burst and intra burst time interval in nsecs is provided.
+
+Note that dpdk library should be compiled using PTP support enabled and testpmd
+application should run on PF.
+
 For example:
 
 .. code-block:: console
-- 
2.47.1

