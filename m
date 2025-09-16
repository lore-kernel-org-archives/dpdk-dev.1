Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE75CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:21:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FED8406B7;
	Tue, 16 Sep 2025 16:21:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C176D402D1;
 Tue, 16 Sep 2025 16:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758032483; x=1789568483;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UxIZEYUQCNqAfS2MBc9KFiXJPrN/eW8WRYmSenLBy5s=;
 b=Taxs7uRazK/XJKmLHMfxmswCOAjhdLHycRQVwu3c/k4z9EIlvYZED23L
 pDc+DgooEGuWtSNOZoxWRb4qAaB1tyeRrjPn0xEX4nZBbfKQAawQYhiPQ
 BqYjWLxXZmUpbT70quIrZywku/HCLDuPUh3vdbouRRd4jpDGTTYdwF1km
 2o0M4C8B0q+TXvcnxLEIxab0vvOacyRdGagigU5P9casf+ep+JmwM5KBw
 HblTW28/XmVPg6UM9dJHPvy0w1Iks1P55SOAIst1yh7sQNFLMzRxpqdRZ
 PmRXfozwpbzf2ZEP7goh6OcoTGZFWYIGaw2Sy0nA1tKycgcYQRRmgTwI0 w==;
X-CSE-ConnectionGUID: hHDd1CxwRkitOHk8WBRZjQ==
X-CSE-MsgGUID: J/EqzwVdTRKeiMPefL3F9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71681338"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="71681338"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 07:21:22 -0700
X-CSE-ConnectionGUID: JCREyna0QtO9/+9V2BXmLw==
X-CSE-MsgGUID: Di/LDPE0Tly2emXuTCNKmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="212115224"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 16 Sep 2025 07:21:22 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 5/8] net/iavf: document support for free Tx mbuf on demand
Date: Tue, 16 Sep 2025 14:21:10 +0000
Message-Id: <20250916142113.3485738-6-ciara.loftus@intel.com>
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

The free tx mbuf on demand feature has been supported since commit
86e44244f95c ("net/iavf: cleanup Tx buffers"). Update the list of
supported features to reflect this.

Fixes: 86e44244f95c ("net/iavf: cleanup Tx buffers")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/iavf.ini | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index aac27bd706..4e4c5cc817 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -10,6 +10,7 @@
 Link status          = Y
 Rx interrupt         = Y
 Fast mbuf free       = P
+Free Tx mbuf on demand = Y
 Queue start/stop     = Y
 Runtime Rx queue setup = Y
 Runtime Tx queue setup = Y
-- 
2.34.1

