Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BFFE9E302
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:04:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 820434065D;
	Wed, 11 Feb 2026 14:04:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 7B79440658
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:04:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770815052; x=1802351052;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=+vV1EwJiu4siBwWTjBbmHf3TOH7Xv8OGvJhDqh2Ewbo=;
 b=MobNBZPHG6ujYRXEP6VFTYgTSi94+sbG9Yrphy/K/HHcb2b2cAZGZ204
 kt4rompYn34eH/vXjK/gVHR+dht7j8Rd/ffvim6pAAJeEKGt5ewx7E21B
 +fy+Vuu0lVOPobGnpTkPqTO3N2tg49iJKujxpiiyP/6d69POc2CFfJjVR
 prQoEebR1EvehB+p5boFviLfcgBbaL085qpwFguAze24KdFvyk+Q7btHf
 qiFy2CaS3Toa3cTrM59HQpIR72Bx3Jo5QRgElc4vEtIzOPaCMvcJDMuwN
 8deWC/2j06EG85nKdRORxhdNC1o43rRZqWSv6NlWQiG3fa/FYDMRxqbzm Q==;
X-CSE-ConnectionGUID: VB/Jv6UGQTOSWfPw3JSzLw==
X-CSE-MsgGUID: DIwaELlFTmCMeLAYfuexXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59529073"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="59529073"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:04:11 -0800
X-CSE-ConnectionGUID: S8xJ+OVmTfqWKR/umrV0Fw==
X-CSE-MsgGUID: YgHpZ2VPSfiQbOXkJEbDFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="217206398"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 11 Feb 2026 05:04:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Radu Nicolau <radu.nicolau@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v3 4/8] net/iavf: fix memory leak on uninit
Date: Wed, 11 Feb 2026 13:03:49 +0000
Message-ID: <f83a71aa1124ee5538cc1f6f6236372434de59cf.1770814868.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770814868.git.anatoly.burakov@intel.com>
 <cover.1770814868.git.anatoly.burakov@intel.com>
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
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
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

