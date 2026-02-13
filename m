Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAC6EDF023
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 09:11:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C8A140678;
	Fri, 13 Feb 2026 10:10:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id F29BA40678
 for <dev@dpdk.org>; Fri, 13 Feb 2026 10:10:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770973836; x=1802509836;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pKgRXo70M6Z7cHc3yoNB3mQJPOsFxhJ3tFgNp1bPV2o=;
 b=c8U9FhE+1jurWE/aRYb37ZfVdgu43tMKZ9SmmT9gQR8zmn41dZ8MjWGF
 yHcdanxJmUKW+kQ0RfV267X0ublynkosE3Ov9XtS1ESAlSEWdAo14YXIf
 Zg6O6peUe+IAlOiMpKUXYFZGoEDow5B82SdF04nkfMYmr/kRZXJiN2Zko
 Dh8fWChYZGuofCwA26qCN72wjR9p+WELuwXfLecOyT4SYAcwp57W8vL3N
 17GEmclhkFNQ4R4AxbcEt+cMseCGWc6Fg2exGL8CM5PSwSDzDPhrVqIul
 bNKKKZYLCEQDxccCMMzXy78SBtuVM9y9YdklCdU9whlRj5K6HOycBpxJh A==;
X-CSE-ConnectionGUID: 39U6Vv8QRbuVbX6GusEsKg==
X-CSE-MsgGUID: 3AuwhFNBTHaOhpXW4UiIaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89567889"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="89567889"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 01:10:36 -0800
X-CSE-ConnectionGUID: B7A0i557QQuEDQSkGTu8pg==
X-CSE-MsgGUID: V4Z1y4UAQTWWlCw7F5h+bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="211966096"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 13 Feb 2026 01:10:34 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>
Subject: [PATCH v6 09/12] net/iavf: fix memory leak on uninit
Date: Fri, 13 Feb 2026 09:10:11 +0000
Message-ID: <168f677320abf3f1c5d795ab902b4426e9b69bf7.1770973745.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770973745.git.anatoly.burakov@intel.com>
 <cover.1770973745.git.anatoly.burakov@intel.com>
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

