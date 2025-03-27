Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3055CC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 16:28:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3903A406BB;
	Thu, 27 Mar 2025 17:28:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6667240654
 for <dev@dpdk.org>; Thu, 27 Mar 2025 17:28:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743092924; x=1774628924;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XmPwvh9QzckIHLp/qnG4YtufLlpqtCmPAWPeBjzcyG8=;
 b=bo1v61sz0yMb3Ql1/JAHDb4fSmbrYC+Qt/pT5ByTvdklL7XXxiBO457r
 WbsgCdY2km+Rdhohg8DvMSJtpp1GVFECIno3XbfSX45jY33Vf7G++DyK7
 prWUc0/Uf2tOqzAf8vq6a38bMmENJTAmGB19HldNg+lzC6456JYKC8Dhq
 rD4ID2ZX5kVdrfXOl9oAGXwq/NzeIwqdmfDdpTjsDkRrursqKl0vW35k+
 4MmfxoXedQOHzCBUCcgogU/8X8xEullDcyY1QtlllPvWMUZR12bBzRCeQ
 OMptqT0T8/zPU6G+Oto3C8HEk86orgh53sDjBLDaSjBGGiA9UMLq20/Xi g==;
X-CSE-ConnectionGUID: if+s8LSCTM+7ulXM5T5ozw==
X-CSE-MsgGUID: RHdd7MMSSaWWcP/OrrJEOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55086620"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; d="scan'208";a="55086620"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 09:28:43 -0700
X-CSE-ConnectionGUID: M5WOQbl/Sg2SzinjBg1dNA==
X-CSE-MsgGUID: 4B+0g1qYRzaWOFJ72pl20w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; d="scan'208";a="125002939"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2025 09:28:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] doc/contributing: remove obsolete advice in coding std
Date: Thu, 27 Mar 2025 16:28:39 +0000
Message-ID: <20250327162839.2472573-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
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

Remove obsolete, and generally not followed, advice in the coding
standards doc, around local variables.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/contributing/coding_style.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
index 1ebc79ca3c..0d8821b325 100644
--- a/doc/guides/contributing/coding_style.rst
+++ b/doc/guides/contributing/coding_style.rst
@@ -556,14 +556,10 @@ Exits should be 0 on success, or 1 on failure.
 Local Variables
 ~~~~~~~~~~~~~~~
 
-* Variables should be declared at the start of a block of code rather than in the middle.
-  The exception to this is when the variable is ``const`` in which case the declaration must be at the point of first use/assignment.
-  Declaring variable inside a for loop is OK.
 * When declaring variables in functions, multiple variables per line are OK.
   However, if multiple declarations would cause the line to exceed a reasonable line length, begin a new set of declarations on the next line rather than using a line continuation.
 * Be careful to not obfuscate the code by initializing variables in the declarations, only the last variable on a line should be initialized.
   If multiple variables are to be initialized when defined, put one per line.
-* Do not use function calls in initializers, except for ``const`` variables.
 
 .. code-block:: c
 
-- 
2.45.2

