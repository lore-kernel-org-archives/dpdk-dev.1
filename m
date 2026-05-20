Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB5CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:54:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA35C40BA4;
	Wed, 20 May 2026 14:53:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7934D4067D;
 Wed, 20 May 2026 14:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779281603; x=1810817603;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AJZLdNxwArlyvRwBAMalmTmLfRiYJiBu3LLZ/tl6WFM=;
 b=c18YU+JVjNh6zHZuBbvxHbGqzU3mF6e8rs/FU1/FbvTf6Z1zJCSg3uIX
 Xra69VcvK7k0o5WcmlqKaavuQUtpKfL8F4JDCY4WvHB14YwuUX24fQmEv
 vM4Rx5q1srif0uBjD0fFvJUHJstnaUfmQMfrl2s2otKnelZPgPUTj6Yy2
 wXwCpFf0rviGqpWoJAKyQC0ongRQ/E+7EPvgvfKefpB2fXwJZprESalJl
 FH5wAIMoX1/o3uIAxHv0xszhXiEYn/hfKQUzRoZACmb7vEPmtE7jCHEFG
 V/q+JyzwPZzgjstEjRcoOX/c+v4MNlHhsxiHbPqqtiwF32g5LwqRUvwF1 A==;
X-CSE-ConnectionGUID: T+wcjR8RSCeYzygzLtKUTg==
X-CSE-MsgGUID: WwP6HyBySzCYHZWKASqtAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91570283"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91570283"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:53:23 -0700
X-CSE-ConnectionGUID: B8sWxgj9QiqOVP+dIc1zgw==
X-CSE-MsgGUID: EPvBnUqqTzugO587SrUvkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="235908305"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2026 05:53:22 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Dima Ruinskiy <dima.ruinskiy@intel.com>, stable@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 08/10] net/e1000/base: propagate PHY control register write
 error
Date: Wed, 20 May 2026 12:52:45 +0000
Message-ID: <20260520125256.354336-9-ciara.loftus@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

During HV PHY workaround handling, a failure writing to the PHY control
register was silently discarded rather than returned to the caller. Add
the missing early return so the error is correctly propagated.

Fixes: 5a32a257f957 ("e1000: more NICs in base driver")
Cc: stable@dpdk.org

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index e62847fb4e..0290a7dcb4 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -2696,6 +2696,8 @@ STATIC s32 e1000_hv_phy_workarounds_ich8lan(struct e1000_hw *hw)
 			e1000_phy_sw_reset_generic(hw);
 			ret_val = hw->phy.ops.write_reg(hw, PHY_CONTROL,
 							0x3140);
+			if (ret_val)
+				return ret_val;
 		}
 	}
 
-- 
2.43.0

