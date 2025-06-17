Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1842AC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 08:24:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78B7740E21;
	Tue, 17 Jun 2025 10:24:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 543A740DC9
 for <dev@dpdk.org>; Tue, 17 Jun 2025 10:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750148660; x=1781684660;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ABhDCLdvJaw6hcbwZC8nL3RbP4noP4nZiMy0UMGDCzQ=;
 b=ZXAxeMGVjk9IR+xJc3I7FBAb4WeY/IHeN4dG2p3iGTEiUtKnGV3PzhAl
 v5ITGQc+iqRP33R9qKfhguRau8T8mYcUivuIyFaFhCrmf7D7kvvXDjYr5
 m+XICjTzmZHIEX3N5h8BkVLHauSeec2SDthA7jdAWmXTEHRdqtucIDVC5
 O1NWE9HgZVwm7IYD2XILD4x+0TwxhHTAUm/pweVspjbdntiesqbx9i6dq
 pWeuW0wHnhsrjBN/VkOWrzeFuMJOehBzor+kikpmrfo+BGZn2YnFt4J96
 oO7w0B2sjptanQa9w/2xKvzGadragheYEeDX6zQaUPLZfwkSkT3OurGkQ Q==;
X-CSE-ConnectionGUID: ADHp/0WrSQy5q8MnxmBQgA==
X-CSE-MsgGUID: f87aUXW/Sua8znzEbHipAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52449731"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52449731"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 01:24:19 -0700
X-CSE-ConnectionGUID: S5ACD5GeRkmfsDBiz5IOFg==
X-CSE-MsgGUID: m0H+TkxTRtmgYj0iwMbrSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="148563843"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa006.fm.intel.com with ESMTP; 17 Jun 2025 01:24:17 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v5 4/4] doc: announce TxPP support for E830 adapters
Date: Tue, 17 Jun 2025 00:14:29 +0000
Message-ID: <20250617001429.551262-5-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617001429.551262-1-soumyadeep.hore@intel.com>
References: <20250610131159.495566-2-soumyadeep.hore@intel.com>
 <20250617001429.551262-1-soumyadeep.hore@intel.com>
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
 doc/guides/nics/ice.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 77985ae5a2..e7d1fb2e1b 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -415,6 +415,31 @@ and add the ``--force-max-simd-bitwidth=64`` startup parameter to disable vector
 
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
+Based on the offload Tx Time Queue will be enabled during ice_tx_queue_setup()
+only for E830 adapters. The initial time should be fetched using
+rte_eth_read_clock(). Further the timestamps should be calculated based on the
+inter_burst and intra_burst times, then storing it into proper format as to be
+placed in packet header. The timestamps should then be copied to packet mbufs
+and packet header length should be adjusted accordingly.
+
 Generic Flow Support
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.43.0

