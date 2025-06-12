Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A0C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 12:25:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1099740F16;
	Thu, 12 Jun 2025 14:25:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 536AF40ED4
 for <dev@dpdk.org>; Thu, 12 Jun 2025 14:25:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749731105; x=1781267105;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=8Vh49V+7HzqLKymQO4cee5hesryG9ye2kuQ25Bdv4yQ=;
 b=mCHFVWs1Yeh0A71vmGmvXAJF1f/v10KVN3jECv5XIFW+iMMpq8gr0Ygo
 5wrCofOpyobIfZ2atV3ho0A9fNoO3boqkCHEqmBVJnDMo5DLqU3UU8xF6
 e6Qr4ZBLSORPYwj2odGTQB9oB9s4CinpX/RVs8yeLLxPP8dEjlx2nmBJD
 Jqt8qOEjTQoHxzez3QIjKU+lm9zhfoegSHEoNziuMcOeVnISc0NHhMpl/
 r7ANBtUqZl/oLdPGtopljlKlrem/MdaG5V5fDRNqEtSkOnnV3otWm9z7J
 kH1Wn5M5cnO6siPzbvSGAwDIB/zIee1PCuEaPKdEtTsuzg5STMs0fQC61 g==;
X-CSE-ConnectionGUID: qGc8MT8pRyaE3Qh9G33X+A==
X-CSE-MsgGUID: 8teYdYlpSG+91yrLAbBSfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="62557377"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62557377"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 05:25:01 -0700
X-CSE-ConnectionGUID: pa1fH+ToQ46Av8E4ePTkWw==
X-CSE-MsgGUID: Bu7mMhHuSJ2VWxYTIlgsHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="152650659"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa004.fm.intel.com with ESMTP; 12 Jun 2025 05:24:58 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v1 2/2] doc: update recommended matching list for idpf PMD
Date: Thu, 12 Jun 2025 17:55:43 +0530
Message-Id: <20250612122543.146876-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612122543.146876-1-shaiq.wani@intel.com>
References: <20250612121322.146355-1-shaiq.wani@intel.com>
 <20250612122543.146876-1-shaiq.wani@intel.com>
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

