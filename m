Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4D7105F787
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 10:12:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAFF840279;
	Fri, 13 Mar 2026 11:12:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 61BB34026C;
 Fri, 13 Mar 2026 11:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773396730; x=1804932730;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aeYkVidnEXnn6StlqTdr+uWmB3TQGkAYjWNLFCaKjTc=;
 b=m+0BMy8T1BQKNse8U3HHMnwnb2d8pv7qcsiuu4zywRLZQ2FdAqCkjaR3
 EsChw82QhgTrHb/Wsgh2WBD8/CH7NxQME37JSYzq4oICN6rEZ9I/ghVT5
 JzyEXCZ0MAyxocwgpIFZwVDkrn7DLRSDpp1pFk0q/oQpB++rByGpqUSu2
 Y5Jk1qcng+cwYvt+OE1WcJTjJXgJTShOKoyX5sYC5xn7GiDMYS1m+Ua+q
 3YNHR6lrhPNtFkEtEl0Gdpwc4BzGhtOFM26YYFj81lj41i17b1MKzvvzQ
 2htovwjIJ3zn/vb0qZi15zAQNb66qBNYDJclFNIAXkO8XTUdrk+eklNSG Q==;
X-CSE-ConnectionGUID: 31VOHRSxSgWCl21xwgJ7FQ==
X-CSE-MsgGUID: QYnRRyZrSnSHIf7iBidxzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85983189"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="85983189"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 03:12:09 -0700
X-CSE-ConnectionGUID: 2KC/aeT4Ruid2qO3g1UYpg==
X-CSE-MsgGUID: L2DzdE3URR22EW9TqJklJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="221331928"
Received: from icx009.iind.intel.com ([10.190.212.240])
 by orviesa007.jf.intel.com with ESMTP; 13 Mar 2026 03:12:06 -0700
From: KAVYA AV <kavyax.a.v@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 vladimir.medvedkin@intel.com
Cc: shaiq.wani@intel.com,
	KAVYA AV <kavyax.a.v@intel.com>,
	stable@dpdk.org
Subject: [PATCH] app/testpmd: fix DCB queue allocation for VMDq devices
Date: Fri, 13 Mar 2026 10:15:53 +0000
Message-ID: <20260313101553.1827216-1-kavyax.a.v@intel.com>
X-Mailer: git-send-email 2.43.0
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

When using DCB mode with VT disabled and requesting more queues than
traffic classes (e.g., rxq=64 with 8 TCs), testpmd crashes with null
pointer errors because it artificially limits queue allocation to
num_tcs.

For VMDq devices, use device-specific queue count (nb_rx_queues/
nb_tx_queues) instead of limiting to num_tcs. This allows VMDq devices
to utilize their full queue capacity while maintaining compatibility
with non VMDq devices.

Fixes null pointer dereference when queue structures are accessed
beyond the allocated range.

Fixes: 2169699b15fc ("app/testpmd: add queue restriction in DCB command")
Cc: stable@dpdk.org

Signed-off-by: KAVYA AV <kavyax.a.v@intel.com>
---
 app/test-pmd/testpmd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index fbacee89ea..70be52d36f 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4444,9 +4444,11 @@ init_port_dcb_config(portid_t pid,
 			if (rte_port->dev_info.vmdq_pool_base == 0) {
 				nb_rxq = rte_port->dev_info.max_rx_queues;
 				nb_txq = rte_port->dev_info.max_tx_queues;
-			} else {
-				nb_rxq = (queueid_t)num_tcs;
-				nb_txq = (queueid_t)num_tcs;
+			}
+			/* Use device queue count to prevent null pointer errors */
+			else {
+				nb_rxq = rte_port->dev_info.nb_rx_queues;
+				nb_txq = rte_port->dev_info.nb_tx_queues;
 			}
 		}
 	}
-- 
2.43.0

