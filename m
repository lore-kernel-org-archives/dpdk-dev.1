Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A63E9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4FAD40663;
	Wed, 11 Feb 2026 14:49:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 525CC40608
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:49:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770817780; x=1802353780;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=+vV1EwJiu4siBwWTjBbmHf3TOH7Xv8OGvJhDqh2Ewbo=;
 b=FlO0DQ1DNHba4xGfwjRykwqboyY7pRy/rmas0tD+SOo9U7+rMjVl9SVm
 rHmDBmwe18nAAkSe1qf6ll/Mr9m7wnjom9vc33XZRASbRgwjChby3z4PW
 x1msVo16iYMtp9cxQc3h/z9i8tHjo0eiA2i5YrO6lrlcGl2rrS664CV3Z
 SQLNMDKRa8+0+JzaFj/lq0UNy2OULtyvfW5BF28ipESzGVuTg7TTspFyN
 zB17PD5GgMDhcBVc7KHBzmJMvqX9XvjUT9JROQHIwoe85d2bN8SPzAfbb
 qHTMamwak0bypI3JbjsphQX+ZKK9WecirvM8RBzf3FgIGELf0GnWqgg07 w==;
X-CSE-ConnectionGUID: 8gfqXTkUQ7mQRer9Y/JFYA==
X-CSE-MsgGUID: NoJeplElQCqGvQWtb+qnHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83332524"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83332524"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:49:38 -0800
X-CSE-ConnectionGUID: 9/QmQcNGQkipg9w5X0QibA==
X-CSE-MsgGUID: jp3QqTCjTSu0gTznAjb88w==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 11 Feb 2026 05:49:37 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v4 6/9] net/iavf: fix memory leak on uninit
Date: Wed, 11 Feb 2026 13:49:13 +0000
Message-ID: <d977085ec59e6ab62d73603667aeac0474014079.1770817694.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817694.git.anatoly.burakov@intel.com>
 <cover.1770817694.git.anatoly.burakov@intel.com>
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

