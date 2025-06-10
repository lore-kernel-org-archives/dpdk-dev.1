Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB50C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:51:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B729242EAD;
	Tue, 10 Jun 2025 16:51:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 69CB440672
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749567062; x=1781103062;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ux5CS/PiKzQx2V7wnyjh0QopHvn68FsSXSt/KoCa4Qc=;
 b=mFUvDwEsZhsJ838BvWJOZE+xAo/robjnXBuPTkSOmEs0RGPmqga0r7oa
 LcFJHQhi1wkR5jPAeNP/0JYPFGcX19hvr86WDD4NZeH9uSSG9u6jZ5Ung
 GnkfG+S9B02c3U7Ui/AuhKIUUztq+jKMAv+b7NNrbibbOoD9cn9B3ddNb
 o8nCRWO2QFySVkhhTbUU6EwjGZ4ERGZU9kdXfqGSZM9LVwC965DCC7UMi
 T32DkC3LmLAIAAf4Xy9NFZD4BtYPNhL8esh6n91FkPLf01wHOlIXKPjGe
 xIDCzyc8dcJU/r+mFQ0BRj/2pxphtSrcJLyp4M2dAwI9nRG3RIGTfDJ87 Q==;
X-CSE-ConnectionGUID: ieSrI2IIToubuKYyI0iFww==
X-CSE-MsgGUID: OflsMVvvQMW+xBt/qkrtzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51562367"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="51562367"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 07:51:01 -0700
X-CSE-ConnectionGUID: asrVseWrRKaHhdTVAgEJiw==
X-CSE-MsgGUID: HHDDw+R0S3qWZyq17ICu3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="146775436"
Received: from silpixa00401217.ir.intel.com ([10.55.128.45])
 by orviesa010.jf.intel.com with ESMTP; 10 Jun 2025 07:51:01 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] doc: add release note entry for EAL lcores flag
Date: Tue, 10 Jun 2025 15:50:55 +0100
Message-ID: <20250610145055.1497390-1-bruce.richardson@intel.com>
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

Add an entry in the release notes about the "-l" flag now being the
same as the "--lcores" flag. Refer to the GSG for examples.

Fixes: 1ea3833e9c4e ("eal: merge corelist and core mapping options")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/release_25_07.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index a5b353d342..fa44dc562a 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,14 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Enhanced EAL ``-l`` corelist argument.**
+
+  Added support to the EAL ``-l`` argument for the full range of core-to-cpu mapping options supported by the ``--lcores`` EAL argument.
+  Previously, ``-l`` only supported a subset of the options,
+  allowing only a list of cpus to be specified, which would be mapped 1:1 with internal lcore ids.
+  Now, it is possible to use the shortened ``-l`` form to map lcore ids to threads running on specific CPUs.
+  See the :doc:`../linux_gsg/eal_args.include` guide for examples.
+
 * **Added PMU library.**
 
   Added a Performance Monitoring Unit (PMU) library which allows Linux applications
-- 
2.48.1

