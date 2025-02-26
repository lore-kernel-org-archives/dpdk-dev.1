Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E37AC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:30:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19CE6402E2;
	Wed, 26 Feb 2025 10:30:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id C5A454027C;
 Wed, 26 Feb 2025 10:30:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740562225; x=1772098225;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7rgqwAI2rdfg1Ya+aLOs1NnlTQsE1lfJtoRiwxy/xB8=;
 b=Tc1OYjkz41asIc53pUGFxMBJIiEsq5zld/pMH+MNetliZ6+WKTB9BCHA
 099gkJwdbnPQ4cz1OLoE9gDz3qSY9VZi8aaGUL72hvrvdTRSnmO55nm0Z
 Q9d2H5C/TkNncI8mQk5CrwBm/hQ++fgJBIcxy6ce48aRVd6erTkjC1YWQ
 NcWom5G6vWRRa9MhWrQyWfGeu5LECN86IZfHczsg7JNZ6hvdAzbNNwEhg
 PPONTR8knDTUsfgsTPNJOQ+0P0TjHDxISCfS9e5qNS/Cma4bt2sEjVPpT
 MGaeoU1L9a3Rhti6LjdT2LP0uTWvNOmlTqAkOGp/TMcbtqWVakQuM+jLR w==;
X-CSE-ConnectionGUID: JflxGym9QLmXJB9AoOtKIA==
X-CSE-MsgGUID: 1VAY7XyHQiCst1FfHPolLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52033799"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="52033799"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:30:24 -0800
X-CSE-ConnectionGUID: P9gXpZOAQt2OMcU3plkohA==
X-CSE-MsgGUID: gQKYV532TyGkfjN+cpoIGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="121647902"
Received: from silpixa00400465.ir.intel.com ([10.55.129.27])
 by orviesa004.jf.intel.com with ESMTP; 26 Feb 2025 01:30:21 -0800
From: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, brian.dooley@intel.com,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>, stable@dpdk.org
Subject: [PATCH] crypto/qat: fix incorrect sm3 state size
Date: Wed, 26 Feb 2025 09:30:19 +0000
Message-ID: <20250226093019.1582450-1-arkadiuszx.kusztal@intel.com>
X-Mailer: git-send-email 2.43.0
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

This commit fixes incorrectly set state size within
the QAT PMD.

Fixes: 75fd4bbc94ab ("crypto/qat: support SM3 hash algorithm")
Cc: stable@dpdk.org

Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
---
 drivers/crypto/qat/qat_sym_session.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 9b26f8a89b..7f370f03fb 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -2473,7 +2473,8 @@ int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 			qat_hash_get_block_size(cdesc->qat_hash_alg) >> 3;
 		auth_param->u2.inner_prefix_sz =
 			qat_hash_get_block_size(cdesc->qat_hash_alg);
-		auth_param->hash_state_sz = digestsize;
+		auth_param->hash_state_sz = (hash_cd_ctrl->outer_prefix_sz +
+			auth_param->u2.inner_prefix_sz) >> 3;
 		if (qat_dev_gen == QAT_GEN4 || qat_dev_gen == QAT_GEN5 ||
 				qat_dev_gen == QAT_VQAT) {
 			ICP_QAT_FW_HASH_FLAG_MODE2_SET(
-- 
2.43.0

