Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB75C28B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 14:21:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95DA8402AF;
	Thu, 20 Mar 2025 15:21:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id D978D4028A
 for <dev@dpdk.org>; Thu, 20 Mar 2025 15:21:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742480479; x=1774016479;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xdDsBJ4FHhZ8jj0cS1YN8TxZgrgTLilwXSTihizxcJ8=;
 b=HMkfDs6aqAaxMCg9l5oSahb0khqKGTXdum/f+YSQBCKB4za6q3A9pWlL
 EPJDdyHWMBWvkfLxCQoHrTMNlYrWDwfk3SWwMOtOPkdHhEJn0zQ9p2ujg
 +5uW9GPolzc6qdiIydhVckCbvFlYTAXSITBTnDSCmQLu0lyaAuQxXOZQM
 DGjLB2xnWrlkbQgSADXwsuiUKQh1l1JdK0JCSOxAN6MUhcNNJD3evscWc
 lBIy494E/oPREN1oimsjq8czbQAhu7Exg9zl3VrI4akiuU/qvrWc038kz
 4HxjTewNCzlfcP3gxrBiw82897FNmj2fModkKBVTKtXdlhVbuMjKI68XK g==;
X-CSE-ConnectionGUID: upVDLBBASFex6EsvdEVtHw==
X-CSE-MsgGUID: dJkqdiRlSemag5PqGyM0MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="53932604"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="53932604"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 07:21:18 -0700
X-CSE-ConnectionGUID: mdAU1FLASSmb9RYXhvqbrA==
X-CSE-MsgGUID: wN6sCo0sQSuFmfibz+8f0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="128204467"
Received: from unknown (HELO silpixa00400886.ger.corp.intel.com)
 ([10.237.222.180])
 by fmviesa004.fm.intel.com with ESMTP; 20 Mar 2025 07:21:16 -0700
From: Brian Dooley <brian.dooley@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, gakhil@marvell.com, kai.ji@intel.com,
 Brian Dooley <brian.dooley@intel.com>
Subject: [PATCH v1 1/2] maintainers: update for crypto performance test
Date: Thu, 20 Mar 2025 14:21:12 +0000
Message-Id: <20250320142113.1130872-1-brian.dooley@intel.com>
X-Mailer: git-send-email 2.25.1
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

Replacing myself as Crypto Perf App maintainer with Kai Ji.

Signed-off-by: Brian Dooley <brian.dooley@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82f6e2f917..cdcea9aa72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1936,7 +1936,7 @@ F: app/test-compress-perf/
 F: doc/guides/tools/comp_perf.rst
 
 Crypto performance test application
-M: Brian Dooley <brian.dooley@intel.com>
+M: Kai Ji <kai.ji@intel.com>
 T: git://dpdk.org/next/dpdk-next-crypto
 F: app/test-crypto-perf/
 F: doc/guides/tools/cryptoperf.rst
-- 
2.25.1

