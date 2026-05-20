Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5BCCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:53:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 923A240684;
	Wed, 20 May 2026 14:53:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C64AE4067D;
 Wed, 20 May 2026 14:53:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779281598; x=1810817598;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2e7YGD3XTWI/of41x5chkKNu6iN86ekp38QnQhU+Qws=;
 b=QJtwS5oEJjd5obsTNL72tVhgly139JrwN1bw5dpEeXzT6AY2+a+NMCV/
 BjeaUMrNt88GMPtKbQrY06JNvWqYS/gntJry5NUCYmEAsSPrMOjN8eR92
 TYo951Aek3cadrU8mXAeFZOycheP47AGtIgkG2p8sqFHRPXIKBXmM10D3
 K381azboeJD3mwMkjXZ4Db5p5s2vjJpnPEvEu5yHO56OsXAPEaMtOvjTX
 mLtASc405dzRM0eK7gNGBDXSwekE2PPc3/rb1Kcw8/Dx65kR2rlUiG8Sv
 BCy1Udz1cUfG1MzL0mUlQlhToY8OJ+/BHm75gthUTdZ/qdO6hsZWlpb9u w==;
X-CSE-ConnectionGUID: InyOj8ebTUezlZC+P1CD/w==
X-CSE-MsgGUID: PTaOpjM0SWqaJshVXOkv3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91570269"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91570269"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:53:17 -0700
X-CSE-ConnectionGUID: 3JyM0RAfT2SJnhVe6kAH8w==
X-CSE-MsgGUID: bf+ucQBQR6i3HwFFHtrfmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="235908274"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2026 05:53:16 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>, stable@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 02/10] net/e1000/base: fix typo in e1000 base code
Date: Wed, 20 May 2026 12:52:39 +0000
Message-ID: <20260520125256.354336-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520125256.354336-1-ciara.loftus@intel.com>
References: <20260520125256.354336-1-ciara.loftus@intel.com>
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

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

A typo was introduced in commit ba54bdc79d94 ("net/e1000/base: improve
clock synchronization workaround"). Fix it.

Fixes: ba54bdc79d94 ("net/e1000/base: improve clock synchronization workaround")
Cc: stable@dpdk.org

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 58597cce8a..6190052368 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -288,7 +288,7 @@ STATIC void e1000_toggle_lanphypc_pch_lpt(struct e1000_hw *hw)
  * e1000_reconfigure_k1_exit_timeout
  * @hw: pointer to the HW structure
  *
- * Reconfigure K1 exit timeout as a workaround to the PHY sycndhronization issue
+ * Reconfigure K1 exit timeout as a workaround to the PHY synchronization issue
  * on MTL, LNL, PTL and WCL.
  *
  * Assuming PHY semaphore is taken prior to this function call.
-- 
2.43.0

