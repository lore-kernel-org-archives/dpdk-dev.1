Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C45FEA8139
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:52:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F9D540693;
	Tue, 10 Feb 2026 16:52:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9D5794067B
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:52:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770738739; x=1802274739;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=+vV1EwJiu4siBwWTjBbmHf3TOH7Xv8OGvJhDqh2Ewbo=;
 b=m/GJrft21Q/PACQLmwftHStfOUok2xM4cWfIQzrthameDEdjQ93WUcHd
 SCB6RSQHefB5fS554/22YJX/fTBE49fkoIxNQ76NjhJkyIaQtClpFiWRn
 S+X82r5O2GcKgleVCzf2wyyTf0/pD6kaqwymsUnKdKWEKa8KYA8LIUzeO
 909YIksrMpN0eOQDgILTGgVy/ND5KrCKmspzkAnXtePNcCR1SN8dbpkvW
 ElDQSGiGJd2A7PdhF/ObJ+vB5kJU37rdytr6Kt7ko9Up10NPMY2+jnc9x
 FOSNDVOM2MRaTWD7g1NuGGa8CZzq5NF/+osaJJ7/3nhk17mFs7EYqnaer Q==;
X-CSE-ConnectionGUID: 6XpVzUtaT56qIBq0t69itQ==
X-CSE-MsgGUID: wjSDnUgiSMKBbyl1ciaOiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71080894"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71080894"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 07:52:18 -0800
X-CSE-ConnectionGUID: 6GPuTOiJRyuRZxSdk/b32Q==
X-CSE-MsgGUID: aYRetpa+QWenWljB3u2ahA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211285380"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 10 Feb 2026 07:52:16 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v2 4/7] net/iavf: fix memory leak on uninit
Date: Tue, 10 Feb 2026 15:52:06 +0000
Message-ID: <0e2ff471b699c3382b680a9c159eb91f81846192.1770738711.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <23738c8f043b1f65742744caa9b725d5474cb059.1770738711.git.anatoly.burakov@intel.com>
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

