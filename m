Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C916AC02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:49:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 356B242EE5;
	Fri,  7 Feb 2025 13:46:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id B945E42E76
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932398; x=1770468398;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=GJtThM0EdUCxy+gFNzQeJlI3tmhdk4fvCvErmEQphbc=;
 b=Tg8eeJl6q38BOsPL3VxQcEvBHgYdtpkuCQ9lY0iF4iz2BL1tt4yZVly5
 hDcAxzPn7/AzHDX/oNlSX9BfaGQUVVGRijrFTOkLzaRAVHE5XtlGh7FSC
 +dC1lKVthx9Dqqv3oEns/Sw8htdFrpBTovh+FUUv48nKrtR0PgQd3hIuI
 VNLNioKQ2onzwjk0i5vfr/Oyx7CC/1adGGFUCHvOnsTJwAGT1KXRvOSxd
 RLJCCOoszfvQKfrePrJf8syAEKgb1k17flWSTMhiMONCTVCZ6CzeeySXr
 dIhsuWlRUn2uWsW4604OmR8qHDfv5mQceAkVeHXreiJL+Ks8I8cVh3Gfa g==;
X-CSE-ConnectionGUID: E+LarZjfSP2IFZyLLO741g==
X-CSE-MsgGUID: b5g6L6fqRiiHdYrDx6gErw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331891"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331891"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:38 -0800
X-CSE-ConnectionGUID: ukvBljLNSAK6iBEeLiC3TQ==
X-CSE-MsgGUID: 3utiKdBySNik7o9YJNaCcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953859"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:36 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 36/36] net/e1000: update e1000 documentation
Date: Fri,  7 Feb 2025 12:45:28 +0000
Message-ID: <fc40dbf6c4eb68aa1954d4843e6d41c3ef0a659f.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

Now that the base code has been brought up to date, update the docs to
call this out.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/rel_notes/release_25_03.rst | 1 +
 drivers/net/intel/e1000/base/README    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 341fdb9a37..82d72714f1 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -96,6 +96,7 @@ New Features
 * **Updated Intel e1000 driver.**
 
    * Added support for the Intel i225-series NICs (previously handled by net/igc).
+   * Updated base code to the latest version.
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/e1000/base/README b/drivers/net/intel/e1000/base/README
index 5d083a0e48..2a0696f3c4 100644
--- a/drivers/net/intel/e1000/base/README
+++ b/drivers/net/intel/e1000/base/README
@@ -2,9 +2,9 @@
  * Copyright(c) 2010-2020 Intel Corporation
  */
 
-This directory contains source code of FreeBSD em, igb, and igc drivers of version
-cid-gigabit.2020.06.05.tar.gz released by ND. The sub-directory of base/
-contains the original source package.
+This directory contains source code of FreeBSD em, igb, and igc drivers of
+snapshot generated on 2025-01-24-09.44. The sub-directory of base/ contains the
+original source package.
 
 This driver is valid for the product(s) listed below
 * Intel® Ethernet Controller 82540
-- 
2.43.5

