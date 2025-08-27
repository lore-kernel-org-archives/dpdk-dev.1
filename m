Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D863C8303F
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 09:24:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 660AF4065A;
	Wed, 27 Aug 2025 11:24:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1F0B34042E;
 Wed, 27 Aug 2025 11:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756286648; x=1787822648;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6Dq24iyo1Hc5EWRUFys4hQ2xSOUBQndwtmM1MOhnaJQ=;
 b=MPJd5hOQ888xKVV6foncbF0ROL3nlEHPQRWqsIHdg+AhWfrk6oiX35+t
 saQL7B5USPvBZD4agwzsXK6o6JydXfq98K073k1VbQi1+MgdduXFgrEoC
 x3ca3LiAzr3INVqYnAaiSoQANm+bWj4ATyjTl5j85zET3PxG1PsL34Frz
 9giUX6Pc9xeVxN0IQEP3NSbvwY+rMnli7Z4zH0mZQLEdDcYY/x14vB5Q+
 lQFyuw+Ex14GugEc/cRZdrvRvz+jojf1qWBGDI+yscEWoJEhmXXNMnEnX
 vQeQPemNt1Mvm686Jhh26KToi/KjzJxYbwNW21zu8fVyTFgCQHu6j3Yso Q==;
X-CSE-ConnectionGUID: Nt8xX509TlieijaDKp3zsg==
X-CSE-MsgGUID: IOU9SuEkR0OZ1od81A3J0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58468885"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58468885"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 02:24:07 -0700
X-CSE-ConnectionGUID: Q9pVhyhYSLGF533Oy8WKlg==
X-CSE-MsgGUID: 2HHzpSuXSXaOHCL3lWuZew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169400213"
Received: from silpixa00401749.ir.intel.com (HELO
 silpixa00401749.ger.corp.intel.com) ([10.237.222.190])
 by orviesa009.jf.intel.com with ESMTP; 27 Aug 2025 02:24:05 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, stable@dpdk.org,
 Kai Ji <kai.ji@intel.com>, Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Subject: [PATCH 3/3] crypto/qat: fix ECDH implementation
Date: Wed, 27 Aug 2025 09:23:58 +0000
Message-ID: <20250827092358.765222-3-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827092358.765222-1-radu.nicolau@intel.com>
References: <20250827092358.765222-1-radu.nicolau@intel.com>
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

Read EC parameters from the xform, not from the asym_op,
where they may not be set.

Fixes: 305e1f856f0c ("crypto/qat: add ECDH key exchange algorithm")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/qat/qat_asym.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index bd22fc0a6f..e7042f702f 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -798,13 +798,13 @@ ecdh_set_input(struct icp_qat_fw_pke_request *qat_req,
 	qat_func_alignsize = RTE_ALIGN_CEIL(qat_function.bytesize, 8);
 
 	if (asym_op->ecdh.ke_type == RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE) {
-		SET_PKE_LN(asym_op->ecdh.priv_key, qat_func_alignsize, 0);
+		SET_PKE_LN(xform->ec.pkey, qat_func_alignsize, 0);
 		SET_PKE_LN_EC(curve[curve_id], x, 1);
 		SET_PKE_LN_EC(curve[curve_id], y, 2);
 	} else if (asym_op->ecdh.ke_type == RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) {
-		SET_PKE_LN(asym_op->ecdh.priv_key, qat_func_alignsize, 0);
-		SET_PKE_LN(asym_op->ecdh.pub_key.x, qat_func_alignsize, 1);
-		SET_PKE_LN(asym_op->ecdh.pub_key.y, qat_func_alignsize, 2);
+		SET_PKE_LN(xform->ec.pkey, qat_func_alignsize, 0);
+		SET_PKE_LN(xform->ec.q.x, qat_func_alignsize, 1);
+		SET_PKE_LN(xform->ec.q.y, qat_func_alignsize, 2);
 	} else {
 		return -EINVAL;
 	}
-- 
2.50.1

