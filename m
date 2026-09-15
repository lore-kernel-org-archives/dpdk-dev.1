Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F272BC88E7B
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D08A42831;
	Tue, 15 Sep 2026 15:37:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 61D26427E9
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:37:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789479432; x=1821015432;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M+NXnRBVYrPlwzjx2pRhfvtRy6qquCtpqs7vuTmlwgo=;
 b=T5fq2fwv9AdMRa8m4U97pt532ociEhRQn1stCSk6PeqiPSziHGiILhOb
 bqB2hcM4Niw71IqGdiifZGyCpLKfxEsIauAbi+4+ygkho4OUvVyoR7CTK
 oqyjx10dDbq30bbfysMSkNNhkoqCtM+xmh34qCcjxX75QZ+UL4+cIZ2d/
 YC5xEF4Rr3OU4h0B3BklfLsb01AOGREAiVJ0MvEbQeGKcP0P9x7yD8LWJ
 UFia/j2MaI6hDyagqWtsp6wJ2KWjmeRe3xtz2yvRd9EROgzOx9ewb6gE4
 zNCSUtTJPdE7zIOCB3qOWU+w1JCYN28k5nDHytM9yEvYwl0niG6sX+6VW g==;
X-CSE-ConnectionGUID: ytQ/qoKpTk2wQX3ryyyTOQ==
X-CSE-MsgGUID: kSmnAb34SBuMq/vnJg/Jvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89972502"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89972502"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:37:11 -0700
X-CSE-ConnectionGUID: K4qapdVoTsWdxzX/nrVchg==
X-CSE-MsgGUID: +h1vhdlRTQyynEpI12RZFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="266800708"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2026 06:37:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 02/15] net/intel: make Tx context flag common
Date: Tue, 15 Sep 2026 14:36:39 +0100
Message-ID: <20260915133654.278780-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915133654.278780-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260915133654.278780-1-bruce.richardson@intel.com>
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

The flag for enabling context descriptors in the vector paths should not
be limited to just the iavf driver, as other drivers may use context
paths in future also. Therefore move the flag out of the iavf-specific
part of the Tx queue structure, to put with other standard queue flags.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 2d4a8b5d3c..fb5268c972 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -173,6 +173,7 @@ struct ci_tx_queue {
 	bool tx_deferred_start; /* don't start this queue in dev start */
 	bool q_set;             /* indicate if tx queue has been configured */
 	bool use_vec_entry;     /* use sw_ring_vec (true for vector and simple paths) */
+	bool use_ctx;           /* with ctx info, each pkt needs two desc in vec paths */
 	union {                  /* the VSI this queue belongs to */
 		struct i40e_vsi *i40e_vsi;
 		struct iavf_vsi *iavf_vsi;
@@ -194,7 +195,6 @@ struct ci_tx_queue {
 #define IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 BIT(1)
 			uint8_t vlan_flag;
 			uint8_t tc;
-			bool use_ctx;  /* with ctx info, each pkt needs two descriptors */
 			bool lldp_enabled;
 		};
 		struct { /* ixgbe specific values */
-- 
2.53.0

