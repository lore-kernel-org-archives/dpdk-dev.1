Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE41C369A1
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 12:57:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49AEC402E5;
	Wed,  9 Apr 2025 14:57:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 50BA5402B7
 for <dev@dpdk.org>; Wed,  9 Apr 2025 14:57:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744203457; x=1775739457;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qrGzBN03gxiWoWnNJS2FMgL5IbkE+Eh99pOy4mXnwBc=;
 b=SnbFced2Z7VKx59ZANFhINM4Pan7ph/qcSHr/YcgI4sglwXDZhxW5cg9
 gJxyRz1idTT4ALGPHvd8V1oeXWTwjHnDIeRgBJgkCcpHPQKzNN63LugeK
 PIP3gErPi7q0xafkoD104kDfkhKx1liQhhAyQLRY9llkZ0Cjf02QEfFWX
 KxzduFmvNy9djLy0IgetwQKzZvRrxtxxzl8iw/prJfbxZ+2Rx77NrBEXO
 YQX962e4GBPA8+/aRTSTWvufCjXqvC2Kqb0rA7gdVpfAsHen7wCmBLCaE
 vExpEOo4n9+zlu+IOOyvaH6l2f+IG4nzrxFGDTXQf4Q7n6fDK2o1MguPo w==;
X-CSE-ConnectionGUID: 6/8QvlpOSkCODVjFlsFFkA==
X-CSE-MsgGUID: NQWpqILQRja7HX4QTEcqiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49468703"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="49468703"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 05:54:49 -0700
X-CSE-ConnectionGUID: szZ0NbibTVeC1DLjYeFopQ==
X-CSE-MsgGUID: UTf2vKcMTFO3NKFUqVrj1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="133450365"
Received: from silpixa00401164.ir.intel.com (HELO
 silpixa00401164.ger.corp.intel.com) ([10.237.223.78])
 by orviesa003.jf.intel.com with ESMTP; 09 Apr 2025 05:54:46 -0700
From: Praveen Shetty <praveen.shetty@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Subject: [PATCH v1] net/idpf: avoid truncation of constant value
Date: Wed,  9 Apr 2025 12:54:40 +0000
Message-Id: <20250409125440.7103-1-praveen.shetty@intel.com>
X-Mailer: git-send-email 2.34.1
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

Truncation of constant value compiler warning was reported in clang/msvc
compiler for the VIRTCHNL2_CAP_OEM bit setting.This is due to 64 bit number
is initialized in a 32 bit enum.VIRTCHNL2_CAP_OEM capability is not used in
the present dpdk code,so removing this bit setting from the dpdk to avoid
the truncation.

Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
---
 drivers/net/intel/idpf/base/virtchnl2.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/intel/idpf/base/virtchnl2.h b/drivers/net/intel/idpf/base/virtchnl2.h
index 3285a2b674..cf010c0504 100644
--- a/drivers/net/intel/idpf/base/virtchnl2.h
+++ b/drivers/net/intel/idpf/base/virtchnl2.h
@@ -265,8 +265,6 @@ enum virtchnl2_cap_other {
 	 * if a reserved bit is set in a standard completion's tag.
 	 */
 	VIRTCHNL2_CAP_MISS_COMPL_TAG		= BIT_ULL(20),
-	/* This must be the last capability */
-	VIRTCHNL2_CAP_OEM			= BIT_ULL(63),
 };
 
 /**
-- 
2.34.1

