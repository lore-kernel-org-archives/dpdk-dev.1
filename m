Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E962AC44500
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:20:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 064D140BA5;
	Fri,  3 Jul 2026 15:19:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D795740BA5;
 Fri,  3 Jul 2026 15:19:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783084797; x=1814620797;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YdwapKFEB+5WOn+QJvFw68I8C0jc0WICncXmRPQ9frE=;
 b=PqQ+hzJ7xBLrr5xMdUO3zxwTGgk/6pA5TJbEu4KBwmpUkiUVfB22o8dc
 aBXnVDwvZbw1FJhvPbnjbzBdICqOduP2WpoNZfFBLxOe2h9w5m5E56HKp
 DADlFYa7Y08EHmlwm267mPd8mwJ/yjrsLtnTyuBXqP4UKzzZaCnHUDHj2
 EAUK5YUirrrLprDgulBlEGBnVRMamQTv4idrJtg3pyXYy6l1+/Q8VmTL6
 /XQBqWIJZpotTBcP/CkNLxzY9rOYBaInvPu9Sm7CP4Y9Q4CqgNK7ijAyH
 ThBvlWLUodynL3iwu6STSY06WuWqLxrcrGr+t/IyR7h7OHBfFE5x5tI3o g==;
X-CSE-ConnectionGUID: z88h1fbvSJO6UyE62pbdqA==
X-CSE-MsgGUID: Axt0k/5ATWK/YFGMLY3WYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94486683"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94486683"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 06:19:56 -0700
X-CSE-ConnectionGUID: s5f/24kUT3uV+xNZRnbsog==
X-CSE-MsgGUID: dEtgE5BsQcOS2vLeaIv1Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="257439874"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Jul 2026 06:19:55 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v2 6/6] net/iavf: fix leak of IPsec crypto capabilities array
Date: Fri,  3 Jul 2026 14:19:20 +0100
Message-ID: <20260703131921.4102325-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703131921.4102325-1-bruce.richardson@intel.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260703131921.4102325-1-bruce.richardson@intel.com>
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

The security context setup allocates a crypto capabilities array and
stores it in iavf_sctx->crypto_capabilities. However, the security
context destroy path frees iavf_sctx and sctx directly, without first
freeing that array.

Fix this by freeing iavf_sctx->crypto_capabilities in
iavf_security_ctx_destroy() before freeing the security context itself.

Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index b2e08da0aa..9c8f694de5 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1572,6 +1572,8 @@ iavf_security_ctx_destroy(struct iavf_adapter *adapter)
 		return -ENODEV;
 
 	/* free and reset security data structures */
+	rte_free(iavf_sctx->crypto_capabilities);
+	iavf_sctx->crypto_capabilities = NULL;
 	rte_free(iavf_sctx);
 	rte_free(sctx);
 
-- 
2.53.0

