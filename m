Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE13C02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:11:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18BF64279A;
	Thu,  6 Feb 2025 17:09:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 022474270A
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858172; x=1770394172;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=deNV6SRIoMUqOUXo18TTd1kufZFjXN7Qia89G3wVBf8=;
 b=GkfKBQvpz+0Z+QfNmgfu6gSxNQepcuERCGMLa8Zh49sJQlsOC3FmFHEP
 qum1En99ocOrQaQfk64Bsk8D1g8rLW0gu1L2PTbqhl/cW2S6+3YdlRmy6
 9p/H3QpsbJ+qJvC1exsL/1BroZeZEQChpFsBtkvI2sAZ6ymHNr0Umelj9
 v51h/yXJJLwaugiEYa60FtPbTEGq20hoMP4rTQanSH3shsNWXaYvOQXX0
 VA9ituHAVxsdSvYmTetDbV2nPPItbnIZwAFRH/C3/cMvSv2ufQButtitz
 +JQeoWBOO45KX8iWrbnx2x47hPqYjnsYI/arJypQxcsOh+2/+mLSixUuy w==;
X-CSE-ConnectionGUID: WbY90a6bT4+xJaglamb1Ug==
X-CSE-MsgGUID: HGMCT30WTSyb6w2RfGrPPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860773"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860773"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:31 -0800
X-CSE-ConnectionGUID: 1Owe/fL0Sg6tz/SUgg1WwQ==
X-CSE-MsgGUID: Y2rTA3RiQhmNdc+y6cz/Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166840"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:30 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Wenzhuo Lu <wenzhuo.lu@intel.com>
Subject: [PATCH v1 23/24] net/e1000/base: fix unchecked return
Date: Thu,  6 Feb 2025 16:08:46 +0000
Message-ID: <e2f59dcc3e5b15d9fc3c62d1165726e90aa776a4.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
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
index 14f86b7bdc..f5f91a148c 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -962,6 +962,8 @@ s32 e1000_set_eee_pchlan(struct e1000_hw *hw)
 		data &= ~I82579_LPI_100_PLL_SHUT;
 		ret_val = e1000_write_emi_reg_locked(hw, I82579_LPI_PLL_SHUT,
 						     data);
+		if (ret_val)
+			goto release;
 	}
 
 	/* R/Clr IEEE MMD 3.1 bits 11:10 - Tx/Rx LPI Received */
-- 
2.43.5

