Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39E8C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:18:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0E1F42E82;
	Tue,  4 Feb 2025 16:12:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5780542796;
 Tue,  4 Feb 2025 16:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681954; x=1770217954;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eGnW4oL7/dqj0BdR+q6XHd0tPcHZZryuCc/sc/dEdTg=;
 b=V8egHEaaQVE5cClowxbocOgZaUaRh9qE+lYnxrLFWQ9ugxahQ35809er
 G1GRSXpXqCEgEFtr8rx1dPqLSeW9uwkBRmKZTvtfFqD9zohtsAVXNVXtx
 sRghuYLWdBWlVf5t3k8PCgEF4WRm+NlY1m1YVU2y3TK0gxq6gGaS6N6Pi
 GmdO2QGlGoytjt159c4GFgdz6Fm9q4q4av6QL7B52EpfHOaMp4EFLu4Cd
 LrrDu7Jf0kPNwkfiDpklkA+AoD7nQw1RlKbxWcXJtueh6iChR/R1Accxp
 Fs55Nf5RYfw236k+qXzTuL9kUk87zfKgKa6Ywv0+1gdPd07zKFfbCIjNA Q==;
X-CSE-ConnectionGUID: EDJR64gwQOWuGqSJFIzHeA==
X-CSE-MsgGUID: To7gZXWCT1qVz1qN0nRfeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097206"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097206"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:33 -0800
X-CSE-ConnectionGUID: +x5p7AgVQNe50DiQ9hVDeQ==
X-CSE-MsgGUID: 535m69h2RTGWmuCaFBSokw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792794"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:31 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Wenzhuo Lu <wenzhuo.lu@intel.com>
Cc: bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 51/54] net/e1000/base: fix unchecked return
Date: Tue,  4 Feb 2025 15:10:57 +0000
Message-ID: <9f8001ea7728d68569bd54893e593b879d537a39.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Static analysis has detected a write that is not checked for errors,
leading to ignored error return value. Add a check.

Fixes: edcdb3c5f71b ("e1000/base: fix link flap on 82579")
Cc: stable@dpdk.org

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index c3449a3f45..6b7eb245a6 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -989,6 +989,8 @@ s32 e1000_set_eee_pchlan(struct e1000_hw *hw)
 		data &= ~I82579_LPI_100_PLL_SHUT;
 		ret_val = e1000_write_emi_reg_locked(hw, I82579_LPI_PLL_SHUT,
 						     data);
+		if (ret_val)
+			goto release;
 	}
 
 	/* R/Clr IEEE MMD 3.1 bits 11:10 - Tx/Rx LPI Received */
-- 
2.43.5

