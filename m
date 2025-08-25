Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3FDCA0FE9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 12:36:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DAA24067C;
	Mon, 25 Aug 2025 14:36:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 69D2640608
 for <dev@dpdk.org>; Mon, 25 Aug 2025 14:35:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756125359; x=1787661359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q4XmJaRcum9051yeM1YQA9slGQG2kzLHsDAO6JGuTZ8=;
 b=GAyrjqaYycVfm8wbgzqsyxkGXWBYPpiXGV28SXhaxQLv+xfvxVIPusK9
 a2To/gK9Ana//5NHSrX4y1Z5C8uOtteC5TrqmoTqrA1mwLh3RLMkJ4F+T
 iXZRCuL0TSiDTNEUu2cKws4zjlw4911E0XzXvbynrinl7dTyuQtCGKxEG
 aUQocaY4ft9Z4zidn0OTk5fFIIrRCWV3YnhEEgduPbH4+GosVpEmIwE0J
 Kp0Z/zI9ne49LHxBel5+165INnwrVf9OiW9nOtKD5cof7jNE3up886fGn
 q78mZ1YPU8yR5c7dh9+pSxe5jqFuqq0Jiw0My6frLZ2XMQO5cgFp/248t g==;
X-CSE-ConnectionGUID: GzrHpMckQ0GbqZLYNMNigg==
X-CSE-MsgGUID: qTv6C/cPR6qRLvjzGKhL2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69049719"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="69049719"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 05:35:59 -0700
X-CSE-ConnectionGUID: k7SQn6iYRC+WGExWebs76g==
X-CSE-MsgGUID: 259JOkRyTTytjvBsnS9qZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="168791971"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa007.fm.intel.com with ESMTP; 25 Aug 2025 05:35:58 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 4/4] doc: add release note entry for SSE removal
Date: Mon, 25 Aug 2025 12:35:48 +0000
Message-Id: <20250825123548.1177090-5-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825123548.1177090-1-ciara.loftus@intel.com>
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
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

The SSE paths have been removed from the i40e, iavf and ice Intel
drivers. Add a release note documenting their removal.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/rel_notes/release_25_11.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index ccad6d89ff..d2749f2e4b 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Removed the SSE vector paths from some Intel drivers.**
+
+  The SSE path was not widely used, so it was removed from the i40e,
+  iavf and ice drivers.
+
 
 Removed Items
 -------------
-- 
2.34.1

