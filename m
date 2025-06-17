Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4095C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:23:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FB1F40EE3;
	Tue, 17 Jun 2025 15:23:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 44B3240E72
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:23:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750166594; x=1781702594;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XoWGG8/2sSooQoBnvDtuQlzvf/ZzIhS1O9+dSNI1dMc=;
 b=VHc/QVmSxV67ukVH7gSpbUGyTUzyjAZI+orIde1EfwtJCVgeWV1BoKOq
 +0rBCJsq3TKOAo/nzcG495d5fsZgqoJP1o3Z/sWMO7btS02xZFE+ALReU
 nkKLZyf/ZRBLPkBXf254L+Bpk4iQQdsM0wJZHw0yQo0eoZhZIGCQYzEld
 /sFKs6qrwXN1H0ADsltn1+BFuUpWq7ZzbA5sH/9Hp9JteV/NiN/8VhUz1
 I8jgApVICTpSIRuJwumwdq9xAtiB1ogfVNpvBhsWp2qxVD0G9P7aslN/2
 eMQW/kqCwtgVZKgMYsY/RRxDhaRfx+kf/Y5e1CcVMzSyDBu6Z2/hYZUGP w==;
X-CSE-ConnectionGUID: Dxropw71Rqa1uEhqJeaClA==
X-CSE-MsgGUID: JJuTHp7HTzaROj4T8IMDPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="54960512"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="54960512"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 06:23:13 -0700
X-CSE-ConnectionGUID: uAaSz55DQymCny3UFsuKtA==
X-CSE-MsgGUID: +GZHj35zQemekDdvHpBD+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="172022267"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa002.fm.intel.com with ESMTP; 17 Jun 2025 06:23:11 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v6 4/4] doc: announce TxPP support for E830 adapters
Date: Tue, 17 Jun 2025 05:13:37 +0000
Message-ID: <20250617051337.563233-5-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617051337.563233-1-soumyadeep.hore@intel.com>
References: <20250617001429.551262-5-soumyadeep.hore@intel.com>
 <20250617051337.563233-1-soumyadeep.hore@intel.com>
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
 doc/guides/nics/ice.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 77985ae5a2..8ab693ff0b 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -415,6 +415,33 @@ and add the ``--force-max-simd-bitwidth=64`` startup parameter to disable vector
 
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
+Based on the tx_offload initialised during port configuration time, Tx Time
+Queue will be enabled during ice_tx_queue_setup() only for E830 adapters.
+The initial time should be fetched using rte_eth_read_clock(). Further the
+timestamps should be calculated based on the inter_burst and intra_burst times,
+then storing it into proper format (Refer to ``struct tx_timestamp`` in
+tx_only.c) as to be placed in packet header. The timestamps should then be
+copied to packet mbufs and packet header length should be manually adjusted
+accordingly.
+
 Generic Flow Support
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.43.0

