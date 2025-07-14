Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE78C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 19:11:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AED2D402D0;
	Mon, 14 Jul 2025 21:11:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B9A774026B
 for <dev@dpdk.org>; Mon, 14 Jul 2025 21:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752520307; x=1784056307;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=86Q6nCxGfkLTIvg/+FBnvqOF9RNgVNuiaPs02yux+Gc=;
 b=WTyag5Qdae2I9X7dwkgQVN/g4jJb9ScNzbv3nglZea0reTSlW+l4zarz
 dDpFUcR3zi1ol3V8CSr896Kb3xV453XNqnuwV8tdtq2Z0XWzSOo828mOF
 Smitl91+SQTlNsaY/W0tJ27zcB/fa7MmELPlusCvvG/W71BJYfg2u30fi
 3Mw4fJcSyuwP+X+REviSexkXgC6/Sk6hYgjwBetpbkUy4TdIrAAiDgnjO
 ZY6+BHhsP6G77jsvp1pahDA30a/uNnNV0ODzx1RLLpGJtj8R1+U/QU96Q
 N5VBnohTDPxuvGuIlpz0qUzfI8WP3GedHaChIalhunDC+p3TM2OViFlRo g==;
X-CSE-ConnectionGUID: KsxQAZl6R5yeE96Fs9sCXA==
X-CSE-MsgGUID: w96OcVQ6T46t6ndT6ZVa/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54851474"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; d="scan'208";a="54851474"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 12:11:46 -0700
X-CSE-ConnectionGUID: 9lWRGZwvSaiU9+6ENGjZMQ==
X-CSE-MsgGUID: KTO2JoCTT2mZK5h7j6LNLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; d="scan'208";a="162679361"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa005.jf.intel.com with ESMTP; 14 Jul 2025 12:11:45 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, bruce.richardson@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v1] mailmap: add new email to DPDK
Date: Mon, 14 Jul 2025 14:11:41 -0500
Message-Id: <20250714191141.1243467-1-pravin.pathak@intel.com>
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

Adding new mail for DPDK contribution

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index c7d55c7386..c81e745ce7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1240,6 +1240,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
+Pravin Pathak <pravin.pathak.dev@gmail.com>
 Pravin Pathak <pravin.pathak@intel.com>
 Prince Takkar <ptakkar@marvell.com>
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>
-- 
2.25.1

