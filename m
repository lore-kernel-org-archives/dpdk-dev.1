Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29621D44176
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 10:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 551D840E30;
	Fri, 12 Dec 2025 11:33:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6E9714026F;
 Fri, 12 Dec 2025 11:33:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765535619; x=1797071619;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xel/7bfJGrBx4R2oY9YgmQkQKU8rAofjBK72fALrMfw=;
 b=kzPPb7GIBMHbeBmbGrXNWeA2CyoGY3rf5Rj3aCUcA8ssi9KCGdZcePqr
 4pE1bA3x/r7u4BTX277qA2hiUJkFQhxvPPm5EZ0C5OyvvxgoQFx5xmwpS
 r84yDFgZe5Fszwxaz8ouvJzEaeAfhZvOBVIiG0tXARDRFKIXoM3lGGrha
 PSuAian+Q4iQuh2FpIF3/jU3fkHUAy6oJC1D79HKJzJpzJ4zguGWQ3Xmn
 g3+Cll6x+Ip4dJkCmQToKhl18LfsAq5xOz9nLAHYIiftdKpjdJkhZXGvL
 /aI5mieVf1k3cswjAxG8YVreQ9xOprJvC4RnqlvE7oHLj2HS0UFxo+LVj w==;
X-CSE-ConnectionGUID: Q+c6HuiqR56tad6H7uvfDA==
X-CSE-MsgGUID: 5/4HEumCQ/merrO9nCObbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="66522886"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="66522886"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 02:33:38 -0800
X-CSE-ConnectionGUID: yqV0U/NIROSw4PoccqQRJw==
X-CSE-MsgGUID: L93S85oQTEelrxW29UJ1iA==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 02:33:37 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 08/10] docs: fix TSO feature status in iavf driver
 documentation
Date: Fri, 12 Dec 2025 10:33:21 +0000
Message-ID: <20251212103323.1481307-9-ciara.loftus@intel.com>
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

Fixes: 319c421f3890 ("net/avf: enable SSE Rx Tx")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/iavf.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 7695e3ff7c..6c9e97594f 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -17,7 +17,7 @@ Burst mode info      = Y
 Power mgmt address monitor = Y
 MTU update           = Y
 Scattered Rx         = Y
-TSO                  = Y
+TSO                  = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
-- 
2.43.0

