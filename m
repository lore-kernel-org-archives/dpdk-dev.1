Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED09CCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 18:06:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAC6640B9B;
	Wed,  5 Nov 2025 19:06:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 278DF40DDA;
 Wed,  5 Nov 2025 19:06:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762365974; x=1793901974;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dIi5zuJW2C83nEy2jh1khwtgDtVu58liIn12sL7f3Dw=;
 b=StRA0c5DR2vvrj34qhcQca9die/jTXF+8yFJge5ECtJlq6r+xBIUFAE2
 DCFOtww9pQdLdLXYlMZyyM0m2ipFz01StHaYspqsD+e2SAxQ753BpHLmv
 Vrepuanlk7/zzA7T7eSFwq4YrNo0eSqpHWPFUK/UPuomkuUm2rxCxfg6o
 a2HMF9YgCTz12ZKeamd7/ZlgJnA8u1RtbUDn8xiiMhMlPSl/bJu/quMsF
 wG0696ftuoqCgIb+ynn5iCD1mSW1EC7lK9OENeZ/aYdUwf8/HX3rG6hyM
 OZGeL9HgFqz66FV40l0yrC29U9Kjw4LP1p470fk502PyN56rb2T25WnuV A==;
X-CSE-ConnectionGUID: iq9kaXUmT027nwfTtVUC5w==
X-CSE-MsgGUID: 7Wk1l8nJTXGPO5gKZehoKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75842009"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="75842009"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 10:06:13 -0800
X-CSE-ConnectionGUID: DzKiRtNGQ/qHdYr0RZvcsg==
X-CSE-MsgGUID: 52mx0jBrT0WFNtLtXmyPfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="187368653"
Received: from fenlix-mobl.ccr.corp.intel.com (HELO localhost.intel.com)
 ([10.239.252.5])
 by fmviesa006.fm.intel.com with ESMTP; 05 Nov 2025 10:06:11 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com, stable@dpdk.org
Subject: [PATCH v3 4/4] doc: update TxPP documentation
Date: Thu,  6 Nov 2025 01:46:37 -0500
Message-ID: <20251106064638.23020-5-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251106064638.23020-1-soumyadeep.hore@intel.com>
References: <20251030173304.260209-3-soumyadeep.hore@intel.com>
 <20251106064638.23020-1-soumyadeep.hore@intel.com>
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

