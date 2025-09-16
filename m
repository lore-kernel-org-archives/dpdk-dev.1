Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9104CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:21:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1994D4065F;
	Tue, 16 Sep 2025 16:21:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 90057402D1;
 Tue, 16 Sep 2025 16:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758032480; x=1789568480;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iGpvLBzwjvm9DM3/YBBTVxlASkRScOf9DXW1oOkgqzc=;
 b=NQ7oSa68aMHcH9T1iEhR9Ceb/1OYSUlmUNdrWxnqXVzJXYdbHcD035hP
 eyMZwp9X3PP7H7TGjX1djjzdJMWaHgJ7e2R3TWT/aO3Y1iX8nxDQ+Z+up
 d3ryOAB+D2fOdZNRR8pOaVXIoKSMUZ85lkKXFBHqCg3n+ZBsqdYsKn2u4
 y4zidgLdfpoffZvDYxY7gC+pauD/4Y7njqqhhcrdxqUAl/TlmcExKPdH7
 PNCJPWObTKVMhyjbSGMWd4InLkUiPRujFndZK222DlJ9+lRPDlp68eiB9
 kz+hzG3/AZ0Vno78MkZju3DvwYxsgrc2KE0hNsoEl3uZ/AYHsR4+ZiSMC g==;
X-CSE-ConnectionGUID: sS9QDr5eRKGvtg5KcBpt+A==
X-CSE-MsgGUID: FnThbSdVQNCS6WpaGvmk3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71681330"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="71681330"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 07:21:18 -0700
X-CSE-ConnectionGUID: jExsxhGhTc2s6iXrwib6LQ==
X-CSE-MsgGUID: EqDLj5eTR0KDTZnrb/3D/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="212115202"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 16 Sep 2025 07:21:18 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 2/8] net/ice: fix documentation of support for TSO
Date: Tue, 16 Sep 2025 14:21:07 +0000
Message-Id: <20250916142113.3485738-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916142113.3485738-1-ciara.loftus@intel.com>
References: <20250916142113.3485738-1-ciara.loftus@intel.com>
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

TSO is only supported by the scalar path in the ice driver. Update the
documentation to reflect this partial support.

Fixes: f88de4694d94 ("net/ice: support Tx SSE vector")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/ice.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index 2703493514..f6439fde35 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -21,7 +21,7 @@ Power mgmt address monitor = Y
 MTU update           = Y
 Buffer split on Rx   = P
 Scattered Rx         = Y
-TSO                  = Y
+TSO                  = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
-- 
2.34.1

