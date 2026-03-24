Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CC2E9A759
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 10:01:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 290B3402BE;
	Tue, 24 Mar 2026 11:01:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 304114025F;
 Tue, 24 Mar 2026 11:01:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774346480; x=1805882480;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qDM1Ye3hO67uVsbu2HFiceZDhSjbwU2xV0xEbynYleo=;
 b=PqyR3qvVSb0UgAYSm4MuhiXsGZaWLvBfvvbYmJO5cicDgk059TmebmRl
 0h+UgT8L4sYFXazwliUXQPwrxCUiZfm32qoRZsuCZRhz4us6bTO9e/uAZ
 1o2Zw63LfOWmT/uXn7bstBVZjU4eGaW9+UMhF5eP6xWxodfta+mCQfWnm
 6At9X25wBUpB12zywKzm/3koD0M/g/9RcVAPs6QF3NQ/OTqugFfeYErTZ
 hgYUJqsu101ALbFk0hMRT4VAjm2/xE9U9im+N08Oitq77Xy3G0lqBEbE7
 QRkXw8m2U6uVGKH8tI9YBzYB6WEbkS27bsbQO0PMT1+SO0SEoLuClBG57 A==;
X-CSE-ConnectionGUID: yj/7xaDjQzeadIc2QlOO7w==
X-CSE-MsgGUID: VdefOIRXT+Wc9cdrlx6Yqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="62909429"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="62909429"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 03:01:18 -0700
X-CSE-ConnectionGUID: c1EsJpmQSAeuCPHD8FGyzA==
X-CSE-MsgGUID: JgM5SVSIS2mMnWDW8bE/0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="262228573"
Received: from icx009.iind.intel.com ([10.190.212.240])
 by orviesa001.jf.intel.com with ESMTP; 24 Mar 2026 03:01:15 -0700
From: KAVYA AV <kavyax.a.v@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 vladimir.medvedkin@intel.com
Cc: shaiq.wani@intel.com,
	KAVYA AV <kavyax.a.v@intel.com>,
	stable@dpdk.org
Subject: [PATCH v3] app/testpmd: fix DCB queue allocation for VMDq devices
Date: Tue, 24 Mar 2026 10:05:00 +0000
Message-ID: <20260324100500.2516672-1-kavyax.a.v@intel.com>
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

For VMDq devices, use actual VMDq queue layout (vmdq_queue_num) instead
of limiting to num_tcs. This allows VMDq devices to utilize their full
queue capacity while maintaining compatibility with non-VMDq devices.

Fixes null pointer dereference when queue structures are accessed
beyond the allocated range.

Fixes: 2169699b15fc ("app/testpmd: add queue restriction in DCB command")
Cc: stable@dpdk.org

Signed-off-by: KAVYA AV <kavyax.a.v@intel.com>
---

v3:
* Replaced configured queue count with actual VMDQ queue layout.
* Changed comment accordingly.
* Revised commit message.

v2: Moved the comment inside the else block.
---
 app/test-pmd/testpmd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index aad880aa34..abe40a3428 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4448,8 +4448,11 @@ init_port_dcb_config(portid_t pid,
 				nb_rxq = rte_port->dev_info.max_rx_queues;
 				nb_txq = rte_port->dev_info.max_tx_queues;
 			} else {
-				nb_rxq = (queueid_t)num_tcs;
-				nb_txq = (queueid_t)num_tcs;
+				/* if vt disabled and vmdq_pool_base greater than 0,
+				 * use vmdq queue layout
+				 */
+				nb_rxq = rte_port->dev_info.vmdq_queue_num;
+				nb_txq = rte_port->dev_info.vmdq_queue_num;
 			}
 		}
 	}
-- 
2.43.0

