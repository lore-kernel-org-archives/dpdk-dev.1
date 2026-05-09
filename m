Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E765CD3436
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 13:20:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA72940650;
	Fri,  8 May 2026 15:20:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id AECF44013F
 for <dev@dpdk.org>; Fri,  8 May 2026 15:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778246406; x=1809782406;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g86z3wadlz08Xe5IT2c2fnfOfIfUlmIN9npi9sCrRCg=;
 b=Bg9Adq/1zRuGIiyhG/OjWooqJHBcaKVo3VbEXi+FBHdg6ZiJjZbhTocO
 qrBC/vcMjIzhlh+nMhebuK0zvhRkG/WgmI8m++LiKeS+U/+e4ptx6Fjy9
 7v6ZACFMLB97x+5Po/gJ6nxp6U0TaP2fj+R17Jy3yiivJD0P25JpuB3BZ
 H2ECDJv6CCjyltMF2eVpYTgRgdBK8HZcjCCHu2BYK4xImVAyY/Irwn6Y/
 o7On+M3ypR1bkxxk1kkQTGNgx8Z9JxB275pO6x2LeXAmvDtbhtv+jQAeE
 iF3n9ZNrz8CCa38e/e/52+WtODpos9S2vjm3YEGAezTKdLTpkjmW9yiD6 g==;
X-CSE-ConnectionGUID: yz4XkWNFRByBDPXPYTGSHg==
X-CSE-MsgGUID: BHl/9P03Q6SrXgKTgZ5ZJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82833591"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="82833591"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 06:20:05 -0700
X-CSE-ConnectionGUID: 9gFn30j9T+eeDL0WrIDgkQ==
X-CSE-MsgGUID: dXHdjmraRHyWDHvNSkAoJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="241110537"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa004.jf.intel.com with ESMTP; 08 May 2026 06:20:03 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Cc: Christopher Pau <christopher.pau@intel.com>
Subject: [PATCH v1 1/2] net/idpf/base: add MMG device IDs
Date: Fri,  8 May 2026 21:54:07 -0400
Message-ID: <20260509015408.29188-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260509015408.29188-1-soumyadeep.hore@intel.com>
References: <20260509015408.29188-1-soumyadeep.hore@intel.com>
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

