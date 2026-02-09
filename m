Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605E6E81BBB
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 12:59:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4808340657;
	Mon,  9 Feb 2026 13:59:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id D714F40655
 for <dev@dpdk.org>; Mon,  9 Feb 2026 13:58:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770641940; x=1802177940;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=REjiyFdUB9WB1GQpss8WrnmtgxYlbdC1mN0ZELDNeL0=;
 b=M9K5RtEiOEn3G1qH2KfQwnmrVLFJxh2V4cEu4jezkB7xT65r7j9AkLIN
 QqbVqKap7rIQluxx4IZ8qkqiZQzQgh0PnT55vVgw1vDwzIqrmWwyEp0qa
 FRjr4RobJGZXovhw42NZAAevBKGqP/jZ0vbOTfzG0XsLKJrIg9T6ioTm6
 zIzooMFXgxR3Y1T5WVjXYGsmC5kOMZjdzws7gpjexrPhgJlGNH/GTSisL
 /H2KwqrMyG5WNhQvhr9OcfM5JSrvCa98x+xdmNUJJbwvGcjm4wyg2zZYK
 y8MKeOP2IgBZHCOrlubRAZlE1YgUtkHFw67N3RRDd7t81u/imlYb8jXQ9 A==;
X-CSE-ConnectionGUID: 1Exo/nWDQWCZsxgxPPtSFw==
X-CSE-MsgGUID: aP1isEQGQmu061b0LpBxFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75376798"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="75376798"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 04:58:59 -0800
X-CSE-ConnectionGUID: IcMl/XKJSNO2/Ga2FjugCg==
X-CSE-MsgGUID: q+LlgQWeSjWFbKuWc7RsSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="249215584"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 09 Feb 2026 04:58:57 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v1 4/4] net/iavf: fix memory leak on uninit
Date: Mon,  9 Feb 2026 12:58:43 +0000
Message-ID: <a28f0e16fb83ef776eb5147ddda862d9ea742841.1770641909.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4084ed8c4f7c01852ca22c7975d0639fc4c8a066.1770641909.git.anatoly.burakov@intel.com>
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

When IPsec is initialized, parsers and engines are registered into the
common infrastructure. However, during deinitialization, they are not
cleaned up. Fix it by including IPsec engines in the cleanup.

Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_generic_flow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 02917f863d..42ecc90d1d 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -1859,6 +1859,11 @@ iavf_flow_uninit(struct iavf_adapter *ad)
 		TAILQ_REMOVE(&vf->dist_parser_list, p_parser, node);
 		rte_free(p_parser);
 	}
+
+	while ((p_parser = TAILQ_FIRST(&vf->ipsec_crypto_parser_list))) {
+		TAILQ_REMOVE(&vf->ipsec_crypto_parser_list, p_parser, node);
+		rte_free(p_parser);
+	}
 }
 
 int
@@ -1920,6 +1925,8 @@ iavf_unregister_parser(struct iavf_flow_parser *parser,
 	else if ((parser->engine->type == IAVF_FLOW_ENGINE_FDIR) ||
 		 (parser->engine->type == IAVF_FLOW_ENGINE_FSUB))
 		list = &vf->dist_parser_list;
+	else if (parser->engine->type == IAVF_FLOW_ENGINE_IPSEC_CRYPTO)
+		list = &vf->ipsec_crypto_parser_list;
 
 	if (list == NULL)
 		return;
-- 
2.47.3

