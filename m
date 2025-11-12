Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106DFCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 10:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38F3640677;
	Wed, 12 Nov 2025 11:19:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 346F2402B0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 11:19:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762942760; x=1794478760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tFGSpHwqc7sHLNVUKi6+DrYZRyr5GhUioUTrvsrh6cg=;
 b=BPIbg5mmUR4n+UbrqFs1LsVH2daWso0N/7+eWk6uCRacjHn9QTtuHhQk
 k1q6BaUtN8eA1GU/e9zQmG1FgXlHsKFXcFyHMeZ5Q1cw7GfBvKEVx5/P9
 4kq6yw0DOph764NwxxahI+NJKtRdw6XDA9j2bnjzjp/q+s5bfVueh9Ecd
 1blILfACjyf60iIJfUKwK0gZZt9kLRoAxuBxuv0ydQpvlPewsLGUBaIns
 ul0Wdo6Owv9CvVQRVbiHeLAD9d9LwtkcCMWwkm8oZgZqWAr0F60dRfMpZ
 E2Y5Z1WMQrlonVyEIR2mKQ9BNzykGHLRGXj+4GKhT5VhuxQr62k39s6Ir A==;
X-CSE-ConnectionGUID: bowwprVJTOuc3vHwmA7YxQ==
X-CSE-MsgGUID: Gsw69C4eT3CE9jdDBe9I1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64884341"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="64884341"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 02:19:19 -0800
X-CSE-ConnectionGUID: HAcE4SKiTb2DfWHMizCx0A==
X-CSE-MsgGUID: FD04PjrdQx6uZOrfdaXY3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="226449548"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa001.jf.intel.com with ESMTP; 12 Nov 2025 02:19:17 -0800
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>, Fiona Trahe <fiona.trahe@intel.com>,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [v3 1/2] crypto/qat: fix CCM request descriptor hash_state_sz field
Date: Wed, 12 Nov 2025 10:19:10 +0000
Message-Id: <20251112101911.2377840-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110170107.2296951-1-emma.finn@intel.com>
References: <20251110170107.2296951-1-emma.finn@intel.com>
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

The hash_state_sz field in the QAT request descriptor for AES-CCM
operations was incorrectly set to the digest length. According to
the QAT firmware specification, this field should contain the
length of AAD in quadwords for CCM operations.

Fixes: ab56c4d9ed9a ("crypto/qat: support AES-CCM")

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
v2:
 * Updated to use 16-byte alignment.
v3:
 * split into two patches.
---
 drivers/crypto/qat/qat_sym_session.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 98ab82ffb3..2ba4fc0a3a 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -2774,7 +2774,8 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 		hash->auth_counter.counter = 0;
 
 		hash_cd_ctrl->outer_prefix_sz = digestsize;
-		auth_param->hash_state_sz = digestsize;
+		auth_param->hash_state_sz = (RTE_ALIGN_CEIL(auth_param->u2.aad_sz,
+						ICP_QAT_HW_CCM_AAD_ALIGNMENT) >> 3);
 
 		memcpy(cdesc->cd_cur_ptr + state1_size, authkey, authkeylen);
 		break;
-- 
2.34.1

