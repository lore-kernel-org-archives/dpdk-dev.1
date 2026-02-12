Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C30EB491F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:54:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 656CC406B4;
	Thu, 12 Feb 2026 13:53:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4B157406BB
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:53:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900837; x=1802436837;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pKgRXo70M6Z7cHc3yoNB3mQJPOsFxhJ3tFgNp1bPV2o=;
 b=XswCSA1Qppk5f+vPrQu4bO/4d/+3yChGuKb9z1th9QnGGuWgW+gVcIoY
 dKXqelJaw9+lbi2QpuzaYd9n+nu9tWH54fup2HW/v4UMMm4oAY0tiCdOK
 +yqnpaBFwsenfEAjSPSc8vFW1zoNIRd80p/jGZ3C2doxBg1R7o3MxEyG/
 LME11jX6s8iRbfUT8FmjZ4mdxIw3bcHnqZcJshjG4a8DFCnPi5N6kynkB
 dcsJghB6FPmfyUGrSTiWcBwXG9K63k9ejYVC7SSmIdhaJpnTBQldQazsT
 540xRTIMv7h641gjDXbffuvgzLHo/LuNMiBxCBHb8ATPhC4yh6fkGBT/p A==;
X-CSE-ConnectionGUID: cguB5FhhTAORzBAHrNffiw==
X-CSE-MsgGUID: crvRGsIDSnew9w/zBlfh3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71785495"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71785495"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:53:56 -0800
X-CSE-ConnectionGUID: 9vRnNa80SLGrIbgWy9r38Q==
X-CSE-MsgGUID: ISCOu8cURgSfyT4wFfXfOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="243179185"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 12 Feb 2026 04:53:54 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v5 09/12] net/iavf: fix memory leak on uninit
Date: Thu, 12 Feb 2026 12:53:32 +0000
Message-ID: <cb6b01a3f3c25df5894f9a3caa0bb0860c74b1ca.1770900758.git.anatoly.burakov@intel.com>
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

When IPsec is initialized, parsers and engines are registered into the
common infrastructure. However, during deinitialization, they are not
cleaned up. Fix it by including IPsec engines in the cleanup.

Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
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

