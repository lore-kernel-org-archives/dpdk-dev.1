Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D41D4417D
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 11:07:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACD6540E3B;
	Fri, 12 Dec 2025 12:06:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 85BB340DDD;
 Fri, 12 Dec 2025 12:06:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765537604; x=1797073604;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7SXnI01v8nSxh6J6i4Oy8uPLR1HgzVkpebMhtGR7YvU=;
 b=fs0NFVlpWUHB4WZjlrWTgGfGiyuC/eqVZKRzOPIyYYOcRf4oW44tApGs
 dblhcLzAGdUB1AF7RMY7kCMXA7hlUl7vRGGzHJ/Rmrudw64wehtESLqTM
 BIeNuwocIeu7o1sRvVA/JLpJV01EwneO/UG92ctWBzGnaz8gtNdL/y3ng
 CylFHgx2nOGCFws2CErWatEpD2qENkdt+1+vF+OdXKoH/5QfWQZs2DuIa
 dmdRgEVJUZlFcSEpPVZfAvw+5lwbL2w6FMvogznds7tTo/T5tKK6dvHW2
 iabWC+S4t+N0qkBtLCqQEaEnzdcUy3XOLV+lNsA+v2UC/bkhPb4+TdkTI A==;
X-CSE-ConnectionGUID: hSZyQVwLTxqjqpY3r4jDiw==
X-CSE-MsgGUID: 2D1epOF6RtKSs4iDSsF0VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67472055"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; d="scan'208";a="67472055"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 03:06:43 -0800
X-CSE-ConnectionGUID: L9uqsp0/Ru2YaeEt2SaWiw==
X-CSE-MsgGUID: cVjyGYvYSqyc0viBXIcXAg==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 03:06:42 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 07/10] docs: fix TSO and checksum offload feature status in
 ice doc
Date: Fri, 12 Dec 2025 11:06:25 +0000
Message-ID: <20251212110628.1634703-8-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212110628.1634703-1-ciara.loftus@intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
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

TSO is only supported on the scalar path so change its status to
partially supported. L3 and L4 checksum offload are enabled on scalar
and vector paths so change their statuses from partial to supported.

Fixes: f88de4694d94 ("net/ice: support Tx SSE vector")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/ice.ini | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index e9796c1eab..893d09e9ec 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -21,7 +21,7 @@ Power mgmt address monitor = Y
 MTU update           = Y
 Buffer split on Rx   = P
 Scattered Rx         = Y
-TSO                  = Y
+TSO                  = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 DCB                  = Y
@@ -34,8 +34,8 @@ Traffic manager      = Y
 CRC offload          = Y
 VLAN offload         = Y
 QinQ offload         = P
-L3 checksum offload  = P
-L4 checksum offload  = P
+L3 checksum offload  = Y
+L4 checksum offload  = Y
 Timestamp offload    = P
 Inner L3 checksum    = P
 Inner L4 checksum    = P
-- 
2.43.0

