Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61069C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 20:49:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DEFA402D0;
	Fri,  7 Feb 2025 21:49:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D0FB7402C9
 for <dev@dpdk.org>; Fri,  7 Feb 2025 21:49:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738961354; x=1770497354;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TB8TMYUK3AJnjCXDi6Py3Xup78yqkO+CAx4GGURib/8=;
 b=JPz4nnr3WADel5woHr7HenTQ+/IxaJseeWhvzOhiy/yR8Uvpj21gotX7
 pGL3dPwmmQ5WCY/th1HkSdWedqendSrPcf413Fz9zqm0hT8RHJpUjrG4k
 q2xyvgTjGoBARogXJBPgofMhIs4kVdRLjUtDOE/WHTQpwYpHmGqr8toYQ
 fFI9NgkvglKlNyEyJPOKYHty3UM7pnfteF1hOlN9mrOkmYT2BAl31Urcb
 GtiG29aeckMlr+sb5c3Fgn/idLem6MdDKPrNG9vh10jt7yOKDYgbRGtiN
 WBdMIVNhOjWTY1FRPc3dwCZ3jhgq9SPktni9dSP7OoFnPTcwLUGwOoy1z Q==;
X-CSE-ConnectionGUID: //OO6BFxS5aUNu54nYOjMw==
X-CSE-MsgGUID: hThi1M9uQp6KM+y1Q9Ypaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39742320"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; d="scan'208";a="39742320"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 12:49:05 -0800
X-CSE-ConnectionGUID: cDnTLja2RRW/myXODOlZmw==
X-CSE-MsgGUID: 54L72h8bS7KhxAwcOZWkRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; d="scan'208";a="116631315"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by orviesa004.jf.intel.com with ESMTP; 07 Feb 2025 12:49:03 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH v1 1/3] net/intel: add support for timestamp ring HW workaround
Date: Fri,  7 Feb 2025 12:42:58 +0000
Message-ID: <20250207124300.1022523-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207124300.1022523-1-soumyadeep.hore@intel.com>
References: <20250207124300.1022523-1-soumyadeep.hore@intel.com>
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

From: Paul Greenwalt <paul.greenwalt@intel.com>

Earliest TxTime First Offload traffic result in an MDD event and Tx hang
due to a HW issue where the TS descriptor fetch logic does not wrap around
the tstamp ring properly. This occurs when the tail wraps around the ring
but the head has not, causing HW to fetch descriptors less than the head,
leading to an MDD event.

To prevent this, the driver creates additional TS descriptors when wrapping
the tstamp ring, equal to the fetch TS descriptors value stored in the
GLTXTIME_FETCH_PROFILE register. The additional TS descriptors will
reference the same Tx descriptor and contain the same timestamp, and HW
will merge the TS descriptors with the same timestamp into a single
descriptor.

The tstamp ring length will be increased to account for the additional TS
descriptors. The tstamp ring length is calculated as the Tx ring length
plus the fetch TS descriptors value, ensuring the same number of available
descriptors for both the Tx and tstamp rings.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/intel/ice/base/ice_lan_tx_rx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
index f92382346f..15aabf321d 100644
--- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
+++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
@@ -1278,6 +1278,8 @@ struct ice_ts_desc {
 #define ICE_TXTIME_MAX_QUEUE		2047
 #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
 #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
+#define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
+
 /* Tx Time queue context data
  *
  * The sizes of the variables may be larger than needed due to crossing byte
@@ -1303,6 +1305,7 @@ struct ice_txtime_ctx {
 	u8 drbell_mode_32;
 #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
 	u8 ts_res;
+#define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0
 	u8 ts_round_type;
 	u8 ts_pacing_slot;
 	u8 merging_ena;
-- 
2.43.0

