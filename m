Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85422CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 14:53:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D09340A6B;
	Tue, 19 May 2026 16:52:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 47CA240665
 for <dev@dpdk.org>; Tue, 19 May 2026 16:52:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779202366; x=1810738366;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pKxyC7SQag5yY9zW6TwuL1C6wGJw9T4yM796oEjZ/oQ=;
 b=hLksfUPBd6Dj3hp1JKzuHI0ajTI8kDTtHGLOKO1+iLXoEvoDPkCtGxKC
 n1jmbuZL4VUM9Lxa+TEw2NivEUQaczimanVvDLzGSEhGBYNLlBlZs/hQl
 /3FpvJpmhmV6a92Xf7/AKOZA9a32ysIaPox3tJfOAIHg3EZmyINCP67iH
 EWu1bUZ1MiYzQN94Y8Iw/srlNqydUxjo5VvqypSL+xunHrEjg0dpx28xO
 0tlUNemyoQeVShX+V1CtEhRZcYHUwvDeWxrj3r6IAC+yodbtYh8ff0YKL
 APJ7YqDVl6n9R54PhnCr+9wIXSDub9VWQNBRQ8npqgh2YwIdNZXPtUXCv g==;
X-CSE-ConnectionGUID: L7ktjEWOSimDVj/sPIUHyA==
X-CSE-MsgGUID: D+bAAHRbREKDoFvU1k/8cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90383763"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="90383763"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 07:52:45 -0700
X-CSE-ConnectionGUID: FETwK9Q2SiuGUKl+czxlsA==
X-CSE-MsgGUID: 8rrpemBARICZc01yqxK2ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="238794399"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 19 May 2026 07:52:45 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 3/3] net/i40e/base: update version info
Date: Tue, 19 May 2026 14:52:23 +0000
Message-ID: <20260519145227.308814-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519145227.308814-1-ciara.loftus@intel.com>
References: <20260519145227.308814-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update README with the date of when the latest snapshot was generated.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/base/README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/base/README b/drivers/net/intel/i40e/base/README
index c5305ffae0..59cae0fc90 100644
--- a/drivers/net/intel/i40e/base/README
+++ b/drivers/net/intel/i40e/base/README
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2017-2024 Intel Corporation
+ * Copyright(c) 2017-2026 Intel Corporation
  */
 
 Intel® I40E driver
 ==================
 
 This directory contains source code of i40e base driver generated on
-2024-08-30 released by the team which develops
+2026-05-07 released by the team which develops
 basic drivers for any i40e NIC. The directory of base/ contains the
 original source package.
 This driver is valid for the product(s) listed below
-- 
2.43.0

