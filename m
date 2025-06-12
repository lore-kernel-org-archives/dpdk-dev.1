Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC780C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 12:12:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5CAA410E6;
	Thu, 12 Jun 2025 14:12:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3EAA94021F
 for <dev@dpdk.org>; Thu, 12 Jun 2025 14:12:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749730346; x=1781266346;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=8Vh49V+7HzqLKymQO4cee5hesryG9ye2kuQ25Bdv4yQ=;
 b=RVUu3bQPUFWrQ4Hkhu6Px8pgdXWXNbpbpwc/+8+P7l3kLE3mauaeHYYO
 x13VayZOrrHW4y5sO68AsBMo/ZHVhfCwXPPnq4NdNPatXR9GGcEzkHVR2
 sL4cbzL96XyjNMMk8mTMLRYSrl/k5UH+3MwrLEHxxy1fWGJy7s8qVcKBG
 zACyPMcMfBaxvVsDN1v3Da4tWoXaeQAKqI9YjX6qEY31TAIygVGP9V3os
 jEu2PVqZerJ41P3izEa6+oZspKhukbHW/stkXsVsEzFl3PQLIxfjjUAf1
 z/2eNhP0ZLJt3t9wuKDNHdwKWu3wkaqAD6essqavzIunNz24RH9y7dMWO Q==;
X-CSE-ConnectionGUID: tYhD/crJTeGNM8YVEs7j7w==
X-CSE-MsgGUID: 0BNAqUksQ2Gc44owjG/QoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63250386"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="63250386"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 05:12:25 -0700
X-CSE-ConnectionGUID: FSuZvN7RSvWGP8vQB6goGA==
X-CSE-MsgGUID: K/xzhmKySpqNcrCR6GwgHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="178407217"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa002.jf.intel.com with ESMTP; 12 Jun 2025 05:12:23 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 2/2] doc: update recommended matching list for idpf PMD
Date: Thu, 12 Jun 2025 17:43:22 +0530
Message-Id: <20250612121322.146355-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612121322.146355-1-shaiq.wani@intel.com>
References: <20250612121322.146355-1-shaiq.wani@intel.com>
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

Updated the recommended MEV-ts release versions corresponding to
DPDK releases in the idpf driver documentation.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/nics/idpf.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index b55de3abd3..3d694a4e3e 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -33,6 +33,8 @@ Here is the suggested matching list which has been tested and verified.
    +------------+---------------+------------------+
    |    23.11   |    0.0.720    |       1.0        |
    +------------+---------------+------------------+
+   |    25.07   |    0.0.754    |       2.0        |
+   +------------+---------------+------------------+
 
 
 Configuration
-- 
2.34.1

