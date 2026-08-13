Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67657C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 771A6427D2;
	Thu, 13 Aug 2026 12:46:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 083C1427A9
 for <dev@dpdk.org>; Thu, 13 Aug 2026 12:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786618013; x=1818154013;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KZfilWHQb+vWGFS3z9xSF/KEvOKTtt+fWL6xR/rZi0I=;
 b=AvII3enaZqESj/PWNeEgkBQGe0l0EdkXY1IoGsw0GZO3EBou6+B6Of+p
 ACrTwqeRW4S8pfO+Cdmj+66u2HVUl22SYgApKbt19rkskC7qDX3iNdWxk
 J3/ADqfMjAXWxcQqv7C7o2tHDmCIdGtFAerP55wIBnw6918mY1uCPnBIX
 sM4bXIgfUqhWpFLB/Em73ypkvyLF77c+z/kG0H74xeSy8JsGZGqhbPYFQ
 esl9LAv2JSQeBbTNh9ToJkRcVWZ4XEOoa4/PgfTnXmViILgkPiuxXmnjm
 Njo9rcQ5Jw6RoGwwoJqjL2WZjdRXNjgTh+9gkKHCuNTwvSI65dN9/3CV/ g==;
X-CSE-ConnectionGUID: 4x9UAAuwSX67udb4KEkdzA==
X-CSE-MsgGUID: Wti3rKe9SoaUjOmrdHUvqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89709013"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="89709013"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:46:52 -0700
X-CSE-ConnectionGUID: 6RgtHxq9R+qNZjBYyOsE9g==
X-CSE-MsgGUID: cVhFULUcTAOpGX+Ou1C7wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="264491582"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa009.jf.intel.com with ESMTP; 13 Aug 2026 03:46:51 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 7/7] net/iavf: skip flow flush during PF-initiated reset
Date: Thu, 13 Aug 2026 10:45:35 +0000
Message-Id: <8ac1b7833679b57c30c76cf10f170620c2c29f03.1786617159.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786617159.git.anurag.mandal@intel.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
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

Skip the virtchnl-emitting teardown on a PF-initiated reset.

Fixes: ada64daa1a5b ("net/iavf: fix VF reset for flow director rule")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 322b59d68c..5373e71b69 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3235,7 +3235,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	/* remove RSS configuration */
 	iavf_hash_uninit(adapter);
 
-	iavf_flow_flush(dev, NULL);
+	/* Skip the virtchnl-emitting teardown on a PF-initiated reset */
+	if (!vf->pf_reset_in_progress)
+		iavf_flow_flush(dev, NULL);
 	iavf_flow_uninit(adapter);
 
 	/*
-- 
2.34.1

