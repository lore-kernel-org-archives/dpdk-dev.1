Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DBFC5518E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:15:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8538040A67;
	Fri, 20 Feb 2026 11:15:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8412F4065C
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:14:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771582498; x=1803118498;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uwxlNxibRhrTvZAS+s+P641C9cbqH766qWDqEDLFeuY=;
 b=LwE/NRZPO5WxJRBzKlKzfXY+Y1vyRG7C0BAR3LV7ey33w7AD33NH8Uto
 K/IzWHVpCFjwjdNzTo/qegd6/51hhieH9djY7A0ib5wmV6SxShMtI1IEL
 8VJwTH9nPVveimTJge5qWrJFhgQOi52xjk6Y3J4nS7kiW4sTfEohviPWd
 AOS8fxka58DuNbTtsNxFehN/4MsALgNay80GpLWRwN9VXJ6LZwuFMymYZ
 NY2fz5Bud80ausGCMZuCdPA24m59taT+AT1j5L423OkrusvvtV+f8UjQ8
 qdGUEvQm84Bkil0DXq0LXi6UCpH2TocgkcHgD+7xOXEf9uv7hawhF/Gc9 A==;
X-CSE-ConnectionGUID: bl94tbGKQd6jEAvpjKBqPA==
X-CSE-MsgGUID: aIJ0GouuSGGrSuhSaix+Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75283344"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="75283344"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:14:57 -0800
X-CSE-ConnectionGUID: oBL7EaWbTaSbem0Gl3RE9Q==
X-CSE-MsgGUID: mGkvqqBeTeuJLq3ZmCMxpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214038468"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 02:14:56 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 07/27] net/i40e: use proper flex len define
Date: Fri, 20 Feb 2026 10:14:14 +0000
Message-ID: <dd794184f34006a702ac799c6fdbacb5bf51c62f.1771582362.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771582362.git.anatoly.burakov@intel.com>
 <cover.1771582362.git.anatoly.burakov@intel.com>
References: 
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

For FDIR, we have byte arrays that are supposed to be limited to whatever
the HW supports in terms of flex descriptor matching. However, in the
structure definition, spec and mask bytes are using different array length
defines, and the only reason why this works is because they evaluate to the
same value.

Use the i40e-specific definition instead.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index ca6638b32c..d57c53f661 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -631,7 +631,7 @@ struct i40e_fdir_flex_pit {
 /* A structure used to contain extend input of flow */
 struct i40e_fdir_flow_ext {
 	uint16_t vlan_tci;
-	uint8_t flexbytes[RTE_ETH_FDIR_MAX_FLEXLEN];
+	uint8_t flexbytes[I40E_FDIR_MAX_FLEX_LEN];
 	/* It is filled by the flexible payload to match. */
 	uint8_t flex_mask[I40E_FDIR_MAX_FLEX_LEN];
 	uint8_t raw_id;
-- 
2.47.3

