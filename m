Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E20D58B22
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 05:49:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B68F4025E;
	Mon, 16 Mar 2026 06:49:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 30B4B400D5;
 Mon, 16 Mar 2026 06:49:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773640144; x=1805176144;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=utzZ7Niuyy2u7oXQTv2I7p0L7howclf+lMre0JUalLs=;
 b=drccrrvSOqJwIt6DVaTPbkySQT5OVAOa6opw6weVHzSpe+jKKZ7NiCg2
 UhtyF8D4PAyxwOiSO7oBHCJ2N+Wc6unIM2jql/2J7+OVlDT2BIMVBUtIt
 V1XLWJI8KWBiKoIdSddeBbgV4U2GIV42VN6JudL6ufEuxuDliQAMlaTM5
 llRvvIjASbU7Ld1V0orAMUWo6Qe45kZVtbP3Q2Trixzz42swUIb61itzA
 bEsv0AbVBBjlu8GI8mg4HtSNM+yJsErRCLbY+ipqT6n3LelWdqqs02MMn
 oZSuRtEf2d9ylg8qdSnQFBAwTue7KyBl4A7HGSrC7zaKeTRa/yXMB9+fP A==;
X-CSE-ConnectionGUID: svNeAOQsTkSjCL2oqohZ8Q==
X-CSE-MsgGUID: 349Qc/qxSd6gMA5p2Ai9fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62217043"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="62217043"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 22:49:02 -0700
X-CSE-ConnectionGUID: BpyWtJJKQreHdux5onNAcw==
X-CSE-MsgGUID: UTRe00BxRbWALcJXPH3kLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="244843577"
Received: from icx009.iind.intel.com ([10.190.212.240])
 by fmviesa002.fm.intel.com with ESMTP; 15 Mar 2026 22:49:00 -0700
From: KAVYA AV <kavyax.a.v@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 vladimir.medvedkin@intel.com
Cc: shaiq.wani@intel.com,
	KAVYA AV <kavyax.a.v@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2] app/testpmd: fix DCB queue allocation for VMDq devices
Date: Mon, 16 Mar 2026 05:52:55 +0000
Message-ID: <20260316055255.2134834-1-kavyax.a.v@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313101553.1827216-1-kavyax.a.v@intel.com>
References: <20260313101553.1827216-1-kavyax.a.v@intel.com>
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

v2: Moved the comment inside the else block.
---
 app/test-pmd/testpmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index fbacee89ea..7e50689f23 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4445,8 +4445,9 @@ init_port_dcb_config(portid_t pid,
 				nb_rxq = rte_port->dev_info.max_rx_queues;
 				nb_txq = rte_port->dev_info.max_tx_queues;
 			} else {
-				nb_rxq = (queueid_t)num_tcs;
-				nb_txq = (queueid_t)num_tcs;
+				/* Use device queue counts to prevent null pointer errors. */
+				nb_rxq = (queueid_t)rte_port->dev_info.nb_rx_queues;
+				nb_txq = (queueid_t)rte_port->dev_info.nb_tx_queues;
 			}
 		}
 	}
-- 
2.43.0

