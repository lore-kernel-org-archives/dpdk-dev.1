Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C14CC61DB2
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 21:22:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 904564060F;
	Tue, 10 Jun 2025 23:21:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B437340430
 for <dev@dpdk.org>; Tue, 10 Jun 2025 23:21:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749590506; x=1781126506;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wRQlzpEg5v0MNTycahG8mcSB0tnJZPyIiGR2NYZloCI=;
 b=dxzdkbQFMgowWFQRNss6WPOIIG3u7JVBToGg1Hcd/Vqk29oY/b8yrw2g
 bzF+k2ia9YOv6cXAPF96wU5HMLJd9HR4BHV/xVQX4DW+VA5G1oztn3wjr
 rP4YJCoiMqlPQIT66GfniJ4F5eOMhBb4LU1zTo5GJ8y5NvDp1z33wj63Y
 cp7OCzsspn8eowarN5vWheygfvJKBjuurkpVRIx6Yny2OpDwfz9xDnqgy
 KCUKBbqhbyMU414U6EXg+2wLRa5NNiaxBpukW/oEMsTcdj57pLSFw5nJ5
 SmGsLBpzea1ge/e/IyoPWUKSdGDumKeELKqpLCE3pVA6bU2cSD4yaPuav g==;
X-CSE-ConnectionGUID: kBgRNGZhQhiv/smB21zKfg==
X-CSE-MsgGUID: FF7Yg2IQRz2PQShL10O12Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51710210"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; d="scan'208";a="51710210"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 14:21:46 -0700
X-CSE-ConnectionGUID: VeGnepeASTG8O0vfIJvMCQ==
X-CSE-MsgGUID: NR5pnYXTRlGJpI+bpbE/hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; d="scan'208";a="170157933"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa002.fm.intel.com with ESMTP; 10 Jun 2025 14:21:44 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v4 6/6] doc: announce TxPP support for E830 adapters
Date: Tue, 10 Jun 2025 13:11:59 +0000
Message-ID: <20250610131159.495566-7-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610131159.495566-1-soumyadeep.hore@intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250610131159.495566-1-soumyadeep.hore@intel.com>
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

E830 adapters currently support Tx Time based queues.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 doc/guides/nics/ice.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 77985ae5a2..f284c78290 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -415,6 +415,24 @@ and add the ``--force-max-simd-bitwidth=64`` startup parameter to disable vector
 
    examples/dpdk-ptpclient -c f -n 3 -a 0000:ec:00.1 --force-max-simd-bitwidth=64 -- -T 1 -p 0x1 -c 1
 
+Tx Packet Pacing
+~~~~~~~~~~~~~~~~
+
+In order to deliver the timestamp with every packet, a special type of Tx Host Queue is
+used, the TS Queue. This feature is currently supported only in E830 adapters.
+
+The tx_offload ``RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP`` is used to enable the feature.
+In order to deliver timestamps internally ``set txtimes`` is used where inter burst
+and intra burst time interval in nsecs is provided.
+For example:
+
+.. code-block:: console
+
+   dpdk-testpmd -a 0000:31:00.0 -c f -n 4 -- -i --tx-offloads=0x200000
+   set fwd txonly
+   set txtimes <inter_burst>,<intra_burst>
+   start
+
 Generic Flow Support
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.1

