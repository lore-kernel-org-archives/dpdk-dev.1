Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E59C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:18:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DB3E40A8A;
	Tue, 27 May 2025 15:17:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 3FBC640669;
 Tue, 27 May 2025 15:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748351877; x=1779887877;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VZwcIyJsYATf4Mjf53YVDQgjShIfppWlKnG1aqP+rLU=;
 b=M89Z6NFvfGY1CuiBNfVeiXeBMsxcGpaclRX5YYXhVL7QXh4EQPitAMXB
 qUCGJH3KF73KsFC6s1iPR9X1o/OOycgZhgCUn9G2VnJqdqz2Z7SshFcC5
 WU1KtzsbOEULU4aKNA+MKQ2Ko+3xDKgM8Ao4n0YGkLJvz8xyb9kT6mS+p
 DOicZDTWfeV5412ubyyx3QOTw7lbiMesT1dHhNw7wh62JcITxpU+oc+Km
 8ShrYZCG1C6kSz4pnRaq3rPPO6rDsZO5r6S/b3KwsfdysaVNEMEd7TB9a
 wpZRc8ouFIu9c9mB3BTNPNzyIM4/s8EQoQ8JugNg7OXisQyQnunpO/JQA A==;
X-CSE-ConnectionGUID: bB9mQTijS+CaVKFM5qWScg==
X-CSE-MsgGUID: U/+ndnPeR7enRUbwgoMSTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67884842"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="67884842"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:17:57 -0700
X-CSE-ConnectionGUID: yc/ZWlQ8RhePbb//EDGjpw==
X-CSE-MsgGUID: 92leiJEWS5aLcw2GC3nV3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143150062"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa008.fm.intel.com with ESMTP; 27 May 2025 06:17:55 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Robin Zhang <robinx.zhang@intel.com>, Ferruh Yigit <ferruh.yigit@intel.com>
Cc: dev@dpdk.org, Lukasz Krakowiak <lukaszx.krakowiak@intel.com>,
 stable@dpdk.org, Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v3 05/10] net/ice/base: fix typo in desc for dev ID 579F
Date: Tue, 27 May 2025 13:17:24 +0000
Message-ID: <20250527131741.7606-6-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
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

From: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>

Fix typo in desc for dev ID 579F.

Fixes: 6fd3889c1779 ("net/ice/base: support E824S and E825 devices")
Cc: stable@dpdk.org
Signed-off-by: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/ice_devids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/ice_devids.h b/drivers/net/intel/ice/base/ice_devids.h
index 807b5d0c29..20c6dbd4a5 100644
--- a/drivers/net/intel/ice/base/ice_devids.h
+++ b/drivers/net/intel/ice/base/ice_devids.h
@@ -90,7 +90,7 @@
 #define ICE_DEV_ID_E825C_QSFP		0x579D
 /* Intel(R) Ethernet Connection E825-C for SFP */
 #define ICE_DEV_ID_E825C_SFP		0x579E
-/* Intel(R) Ethernet Connection E825-C 1GbE */
+/* Intel(R) Ethernet Connection E825-C 10GbE */
 #define ICE_DEV_ID_E825C_SGMII		0x579F
 #define ICE_DEV_ID_C825X		0x0DCD
 #endif /* _ICE_DEVIDS_H_ */
-- 
2.43.0

