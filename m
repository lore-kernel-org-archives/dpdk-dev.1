Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EABC5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 10:23:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 657A44064A;
	Mon, 24 Aug 2026 12:23:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 23BEF40270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 12:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787566984; x=1819102984;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MNLfSyOuInlCK8u7cskQwUgSeHCNCFjvA0S2Zoq8vNU=;
 b=OQtvQdERxXQMoAv0Io47TmRPvGaqWPogf0+HFI5D2E/uN3WDeqPc3yCO
 OkwHpk3WxrjmpsXlsQs1V5oLKj1lx9ibCRLGP0WL3Ahn8mFjwRrN8D3cY
 JFYIyDMfFRiMaQL+odJS4/tvHu6UKF2stvYymP5fOMrqtuErvvIo3tbBL
 yATmj5OSt6oELjEVjC6iVlRzUs+XfxIvMO8V1MUmDiAjaLA8h5bBihSrz
 2UTbx+mtn4JPkM/Xy55rGPurjz3093dTKhpsGMibqH3kqqB+0izG9YnhN
 qkGXN7GiM8KF9adv2OYXt8h+Iz/oQr3pN7iLDY9dQRY6TaF3Z2IRZiovm A==;
X-CSE-ConnectionGUID: UT6OkBtoQq2iPIS0CFUvDQ==
X-CSE-MsgGUID: FfFcx1NxQRiddGS827Yx0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87884923"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="87884923"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 03:23:03 -0700
X-CSE-ConnectionGUID: R5CcJg0wS0+QCOVWnyI6bg==
X-CSE-MsgGUID: RhhfhB44ToawqeFpI244Uw==
X-ExtLoop1: 1
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa003.fm.intel.com with ESMTP; 24 Aug 2026 03:23:01 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 1/4] net/common: share Tx context descriptor flag
Date: Mon, 24 Aug 2026 10:21:51 +0000
Message-Id: <1e2a3778ab771dd7daa08d2ae33546a02f0d61c4.1787566677.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787566677.git.anurag.mandal@intel.com>
References: <cover.1787566677.git.anurag.mandal@intel.com>
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

Moved context descriptor state to the common
Tx queue for reuse by ice.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/common/tx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 55757d34d7..61ad041065 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -175,6 +175,7 @@ struct ci_tx_queue {
 	bool tx_deferred_start; /* don't start this queue in dev start */
 	bool q_set;             /* indicate if tx queue has been configured */
 	bool use_vec_entry;     /* use sw_ring_vec (true for vector and simple paths) */
+	bool use_ctx;           /* each packet uses a context and data descriptor */
 	union {                  /* the VSI this queue belongs to */
 		struct i40e_vsi *i40e_vsi;
 		struct iavf_vsi *iavf_vsi;
@@ -196,7 +197,6 @@ struct ci_tx_queue {
 #define IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 BIT(1)
 			uint8_t vlan_flag;
 			uint8_t tc;
-			bool use_ctx;  /* with ctx info, each pkt needs two descriptors */
 			bool lldp_enabled;
 		};
 		struct { /* ixgbe specific values */
-- 
2.34.1

