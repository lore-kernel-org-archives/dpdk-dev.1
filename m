Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77658D44166
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 10:34:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0111940E4A;
	Fri, 12 Dec 2025 11:33:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 63F9C40687;
 Fri, 12 Dec 2025 11:33:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765535621; x=1797071621;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7G3JqIt2UeSME5dzKdtzRDfTjdadb58AsLoIRcr0flk=;
 b=LwnO0WFApwaNOYvElQCvMt17pCul4Zv8wxKazs8Yq6aPLnYHxz1Hnobc
 I9n4yWqfMHtk/iZWlolz4MAync1rHTia1I9+40Iao/dz0Adml2A7t/2PZ
 kZXOY94jn22CYX+aIBsD3g57pPGdExI3z/9JKXNWBPCjiuM98oH4vitEj
 MiaWtsiamyGo5T2dIvkF0AqJq4rr0Xig2SqVljLruONWa+FGrYOjYEFgf
 oGG9052t3XJrT5uZRP+fbE1xKt05KrLntZC3qALrpuuxVDo1ITf5eA9WJ
 Bd9HM2CQmtE1uM8u7C98YKuJ70v9WVren1Z3Hr+KpvjdKSa5iGUtWzBmG w==;
X-CSE-ConnectionGUID: QkdiQphWRBSAHmdrqUf4RA==
X-CSE-MsgGUID: UOQk8FicS0a/uDIdUHJzag==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="66522889"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="66522889"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 02:33:40 -0800
X-CSE-ConnectionGUID: 1OxMjGfSRgK1c663UffH6Q==
X-CSE-MsgGUID: rC7nvQx1SJm+rafTudpLsg==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 02:33:39 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 10/10] docs: fix TSO feature status in i40e driver
 documentation
Date: Fri, 12 Dec 2025 10:33:23 +0000
Message-ID: <20251212103323.1481307-11-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212103323.1481307-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251212103323.1481307-1-ciara.loftus@intel.com>
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

TSO is only supported on the scalar path so change the status to
partially supported.

Fixes: 9ed94e5bb04e ("i40e: add vector Rx")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/i40e.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/i40e.ini b/doc/guides/nics/features/i40e.ini
index 4610444ace..fb00b69830 100644
--- a/doc/guides/nics/features/i40e.ini
+++ b/doc/guides/nics/features/i40e.ini
@@ -16,7 +16,7 @@ Runtime Tx queue setup = Y
 Burst mode info      = Y
 Power mgmt address monitor = Y
 Scattered Rx         = Y
-TSO                  = Y
+TSO                  = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
-- 
2.43.0

