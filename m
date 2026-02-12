Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359F5EB491F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:54:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8C3340668;
	Thu, 12 Feb 2026 13:53:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B50E84065D
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900828; x=1802436828;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Ovv18ukYA2Pwzo9CEA4mcbrWmQLVwiFeyk9TDK6Ga3E=;
 b=BDuj0cB+D0A/vsvkYYH25+nGXdQ72d1fqNWHWP/G2pYrn2e5qhXZwdgP
 KX/xTYTExYdgKmsoHLKrVnMqkNjVPeXIJCduIlC7O5XFCXsNmgje+No+W
 c3MFVoY/Hse0yPQDs0mA6nBrfLga5B6CPsrDE1k/CxbfsMtrAC3BKlR8b
 Qq49dsUq8/nzKa8hMxbkJkwY+yTy8X3LxKOUrOogCHFCjmk0yq55pJ1sI
 s3dFTnY2cDswc9Ptl3cCLxpuKhxrd7X1QpQUytRxEx3chPWjD3NSJX3Lv
 P7Lu4Hpthjl/0ODfCIWUPBznEDTXA5KdS3NxofmkCVgL+R1zw+8zH3Vrb w==;
X-CSE-ConnectionGUID: 2G70PPyHSTu5+DEqClsHpA==
X-CSE-MsgGUID: rI8Rq0hPRrC4NUJBGeiwPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71785486"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71785486"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:53:48 -0800
X-CSE-ConnectionGUID: JwRycRJWQnWCHe5dKVLV+w==
X-CSE-MsgGUID: VABpoACARHaomBY4VxL1gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="243179132"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 12 Feb 2026 04:53:46 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v5 04/12] net/ixgbe: fix potential null dereference in IPsec
Date: Thu, 12 Feb 2026 12:53:27 +0000
Message-ID: <c90dd3517961437012e26f9f1abc5e7fa2d8d935.1770900758.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
References: 
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

Currently, IPsec flow parser will look for IPv4 flow item in the pattern,
and then pass it to IPsec SA flow function. However, we do not check if the
spec pointer is actually valid. Fix by adding the check.

Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 81b983ce69..90a24806d2 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -251,6 +251,12 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 			}
 			item = next_no_void_pattern(pattern, item);
 		}
+		if (item->spec == NULL) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM_SPEC, item,
+					"NULL IP pattern.");
+			return -rte_errno;
+		}
 
 		filter->proto = IPPROTO_ESP;
 		return ixgbe_crypto_add_ingress_sa_from_flow(conf, item->spec,
-- 
2.47.3

