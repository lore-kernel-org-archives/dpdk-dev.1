Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC373CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:22:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C85940A6D;
	Tue, 16 Sep 2025 16:21:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2363E40612;
 Tue, 16 Sep 2025 16:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758032485; x=1789568485;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9G7HIGsj5gH82Mli4/W6BqXFbJz7LwsUGGsoXrNUCfM=;
 b=deQY1oeEByoKS2K25sSMCaE5xviPR9i5Y+vCoMhTz8QiZ7eHEsg6k3te
 a9M5qJCUOehuw+1COKPD7g8CCExiYdoxzMfYeNvs9LeeeagxPdhm9V6ey
 61WEXvEg4E5XioHypyP1vVUuikGxqS6gNIrWvInqveCZLSOdmj1CBzS55
 YG6YZDAm3woww9gkAA0vKV04FNGAPLkBG+03d9PgJtWUdnlxOojMUfWT8
 qMYikMonVacykQoXWRPdj6keONauKakeLokZ5xCNIkQm98L7yzrXRT2fc
 Y5hRtEEFs7OwX0FYmGwX7GWtIVUH1aNBXtozSU739X3jM3LJeXwSTUJtO w==;
X-CSE-ConnectionGUID: 0m5p+Sf+T4iOVhbVO/2rBA==
X-CSE-MsgGUID: v6+NvprES2aIVmzchqpasA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71681343"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="71681343"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 07:21:24 -0700
X-CSE-ConnectionGUID: 8djWhzNZT5yQ/yGyUSQ7HQ==
X-CSE-MsgGUID: +1vUpnLuTPaEIWCe8tZDBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="212115235"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 16 Sep 2025 07:21:24 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 7/8] net/iavf: fix documentation of support for TSO
Date: Tue, 16 Sep 2025 14:21:12 +0000
Message-Id: <20250916142113.3485738-8-ciara.loftus@intel.com>
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

TSO is only supported by the scalar path in the iavf driver. Update the
documentation to reflect this partial support.

Fixes: 319c421f3890 ("net/avf: enable SSE Rx Tx")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/iavf.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 7420432840..63c89ee28f 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -18,7 +18,7 @@ Burst mode info      = Y
 Power mgmt address monitor = Y
 MTU update           = Y
 Scattered Rx         = Y
-TSO                  = Y
+TSO                  = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
-- 
2.34.1

