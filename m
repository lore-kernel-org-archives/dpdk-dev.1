Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69915CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 14:59:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C781402B5;
	Fri,  3 Oct 2025 16:59:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 035BC402A2;
 Fri,  3 Oct 2025 16:59:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759503541; x=1791039541;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XFfbNT/GRBIB8QM8W9EQW+7pmZwSoaAfDymgnpSrFA4=;
 b=Osm51wbkeGoRJoeEFbfocsz+T5rlLRDMJ4Gjor7wQdW9J+PTvIM1Hj7M
 A7K5g6TJNRHBFk6Y7UYYfVg9mb7860lTM50hPusQIg1mK89vLERnTuhKX
 atu9gIUyUibbHJGsJz43TW39IEZyr3S6OTd9l1ghQIw7YyBO1ZiIbx+NF
 /MWbkof8vedzO7pk8h1fb+7HOn5Vozi0yMuuRpNf+LQQw6ADrU1QBM0YL
 /F6bJ3DGggkGCVzNSNjxEs9roXXMtjTvQoge+uOR4HHnK+KDZMH6zS9u8
 8lR4B+acaU2G39ZQvxFZFG00gWQELNfHs6vTmqMYYBrrdV5vgN2hNXixY g==;
X-CSE-ConnectionGUID: 6IZXNN9qTia+mtr3cZ1SdQ==
X-CSE-MsgGUID: KYZLcrPHSvmMtEl6b+Entw==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="65635124"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="65635124"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 07:59:00 -0700
X-CSE-ConnectionGUID: MYWz2RRMR+eemQg5FtsW0w==
X-CSE-MsgGUID: qm705QFtQEqEY4hN4hrjEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="183711214"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa005.fm.intel.com with ESMTP; 03 Oct 2025 07:58:58 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Praveen Shetty <praveen.shetty@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Yuying Zhang <yuying.zhang@intel.com>
Subject: [PATCH] net/cpfl: fix display of commands in the docs
Date: Fri,  3 Oct 2025 15:58:48 +0100
Message-ID: <20251003145848.1675691-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

The literal text of the commands to use were not displayed properly
because of a double ":" at the end of the preceding text, meaning that
the ".. code-block" marker got recognised as the literal text to
include. Change the double colon to single, and also indent the line
continuation in the multi-line flow-create command.

Fixes: 03f976012304 ("net/cpfl: adapt FXP to flow engine")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/cpfl.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
index 54a3015aa0..bc42c524ea 100644
--- a/doc/guides/nics/cpfl.rst
+++ b/doc/guides/nics/cpfl.rst
@@ -218,14 +218,14 @@ low level hardware resources.
       dpdk-testpmd -l 0,1 -a 0000:af:00.6,vport=[0-1],flow_parser="refpkg.json" -- -i
 
 #. Create one flow to forward ETH-IPV4-TCP from I/O port to a local(CPF's) vport. Flow should be created on
-   vport X. Group M should match fxp module. Action port_representor Y means forward packet to local vport Y::
+   vport X. Group M should match fxp module. Action port_representor Y means forward packet to local vport Y:
 
    .. code-block:: console
 
       flow create X ingress group M pattern eth dst is 00:01:00:00:03:14 / ipv4 src is 192.168.0.1 \
-      dst is 192.168.0.2 / tcp / end actions port_representor port_id Y / end
+         dst is 192.168.0.2 / tcp / end actions port_representor port_id Y / end
 
-#. Send a matched packet, and it should be displayed on PMD::
+#. Send a matched packet, and it should be displayed on PMD:
 
    .. code-block:: console
 
-- 
2.48.1

