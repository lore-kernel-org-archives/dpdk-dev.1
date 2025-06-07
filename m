Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4453EC5B543
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 01:19:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8335B4060C;
	Sun,  8 Jun 2025 03:18:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 075CF40430
 for <dev@dpdk.org>; Sun,  8 Jun 2025 03:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749345531; x=1780881531;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=56I87qJ2bxg+fjCYVXA+IETtdC0dlOyYsL/UKX6A6MY=;
 b=EGkbcqEkaE4eRGd6wE+oyHWUMCbK+aIjBsImIbaaROdx8vwdS1d0HwVt
 Yt0QQ2F4tRqEChAUPWvpW4lrO1oiiSoiZKsD+N0f6XA5JBo2BpqXxlZ6L
 uwAqsab5dUDFx2VajhP+KQrOTNZyT0KgU4T75+z61FGAQON00G27j78Ia
 AkP9Y93LBU9f5dDcVfpmMo2LYLpMZg8YQ8xXkOz4ikW1rjtLV41kfKqFp
 az2haw0zo+I/6IVUOZBBn9OJE29wVxLE0v1GOoc33MIPAhp/Bs9sRbvXo
 cMIxt+nSVIf8yb4vwqviSMKgEzftLvueGKctPmqsdHPmfvx9rLiorLk5r Q==;
X-CSE-ConnectionGUID: 02ql/ExlSFS9EAKY3VXFVg==
X-CSE-MsgGUID: 6bPWgNgIQcOWDBX5OrS2ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11457"; a="62856902"
X-IronPort-AV: E=Sophos;i="6.16,219,1744095600"; d="scan'208";a="62856902"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2025 18:18:50 -0700
X-CSE-ConnectionGUID: pNiruHfYSgG3AokbPc0Rdg==
X-CSE-MsgGUID: KbdQ2rNPTpyHdi+GgriAug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,219,1744095600"; d="scan'208";a="146676587"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa010.fm.intel.com with ESMTP; 07 Jun 2025 18:18:49 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v2 6/6] doc: announce TxPP support for E830 adapters
Date: Sat,  7 Jun 2025 17:09:04 +0000
Message-ID: <20250607170904.480937-7-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607170904.480937-1-soumyadeep.hore@intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250607170904.480937-1-soumyadeep.hore@intel.com>
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
 doc/guides/nics/ice.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 77985ae5a2..73c5477946 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -415,6 +415,22 @@ and add the ``--force-max-simd-bitwidth=64`` startup parameter to disable vector
 
    examples/dpdk-ptpclient -c f -n 3 -a 0000:ec:00.1 --force-max-simd-bitwidth=64 -- -T 1 -p 0x1 -c 1
 
+Tx Packet Pacing
+~~~~~~~~~~~~~~~~
+
+In order to deliver the timestamp with every packet, a special type of Tx Host Queue is
+used, the TS Queue. This feature is currently supported only in E830 adapters.
+
+The tx_offload ``RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP`` is used to enable the feature.
+For example:
+
+.. code-block:: console
+
+   dpdk-testpmd -a 0000:31:00.0 -c f -n 4 -- -i --tx-offloads=0x200000
+   set fwd txonly
+   set txtimes 30000000,1000000
+   start
+
 Generic Flow Support
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.43.0

