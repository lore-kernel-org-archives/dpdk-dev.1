Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C1FCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 09:29:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8156840611;
	Wed, 20 May 2026 11:29:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id C716E402EB
 for <dev@dpdk.org>; Wed, 20 May 2026 11:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779269393; x=1810805393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g86z3wadlz08Xe5IT2c2fnfOfIfUlmIN9npi9sCrRCg=;
 b=RCxEPfH5ZNneODV8BPKksL3Js/KNtZvq5cyJUaFI9ypCE/0mgERN+zL+
 qC2OaqyoOethGYZulg9ulr+MKch8zHJDUGCWt5JqE5SwdkcBtV/eSt/wD
 f7HgSpfk7RiwOtdLxEDwnP73dqzMlMsP2o0lKbFyfJ1NXNV1+IOpgtaNV
 TJm01l94loo94Dtsp+XD9F7gsu3/jIFuGbqH64BNZj8enP4hnIjaHYIKD
 GVix1O+74wsylkSY4yCh32/Gn2FdzMG+PePf+37nmox3ulhiGOo4Ly87P
 mCFjWOFrZsluJvx1b36cavOFKslu0Xq+aad7N75OHKhrKQM5bN/sTXGpT w==;
X-CSE-ConnectionGUID: ZiMLPAFFT9u+NCaKW8y5Xg==
X-CSE-MsgGUID: iB2s7aMmSySAhRVjHgxw7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80013703"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="80013703"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 02:29:52 -0700
X-CSE-ConnectionGUID: qClgLhvyS6SwkRExBq3BXQ==
X-CSE-MsgGUID: ZlJO2wLhRkqwqSEXFd6Y5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="245088187"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa005.jf.intel.com with ESMTP; 20 May 2026 02:29:50 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Cc: Christopher Pau <christopher.pau@intel.com>
Subject: [PATCH v2 1/2] net/idpf/base: add MMG device IDs
Date: Wed, 20 May 2026 18:03:05 -0400
Message-ID: <20260520220306.85273-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260520220306.85273-1-soumyadeep.hore@intel.com>
References: <20260509015408.29188-3-soumyadeep.hore@intel.com>
 <20260520220306.85273-1-soumyadeep.hore@intel.com>
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

From: Christopher Pau <christopher.pau@intel.com>

Add MMG device ids for PF and VF.

Signed-off-by: Christopher Pau <christopher.pau@intel.com>
Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/idpf/base/idpf_devids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/idpf/base/idpf_devids.h b/drivers/net/intel/idpf/base/idpf_devids.h
index 1ae99fcee1..8b10ef9e32 100644
--- a/drivers/net/intel/idpf/base/idpf_devids.h
+++ b/drivers/net/intel/idpf/base/idpf_devids.h
@@ -10,7 +10,10 @@
 
 /* Device IDs */
 #define IDPF_DEV_ID_PF			0x1452
+#define IDPF_DEV_ID_PF1			0x11DF
+#define IDPF_DEV_ID_CPF1		0x11E0
 #define IDPF_DEV_ID_VF			0x145C
+#define IDPF_DEV_ID_VF1			0x0DE2
 #define IDPF_DEV_ID_VF_SIOV		0x0DD5
 
 
-- 
2.47.1

