Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D382606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=opnjD4aF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11A03402C8;
	Sat, 24 Oct 2026 18:47:09 +0200 (CEST)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by mails.dpdk.org (Postfix) with ESMTP id 726D74003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 15:07:47 +0200 (CEST)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 0DBF4202F0A6;
 Thu, 22 Oct 2026 18:07:47 +0500 (+05)
Received: from home.mcr.net (unknown [94.131.86.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id 42FC1203294B;
 Thu, 22 Oct 2026 18:07:31 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 42FC1203294B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1792674465; bh=wrqYj7t7PEUdbhpu0e6ODf1m9//8qkiMZRelheXiqyc=;
 h=From:To:Cc:Subject:Date;
 b=opnjD4aFVbQ3xSx8+2ouEsuo5FjQcl78TUEKdUc/QMaayVvGXf/H8cA0Xaa1qLLaD
 sJ/looV+cm0b01EO0L45uzDZq4ktc0/v136UVtUTCBan88XPXwBmHxr5y4o05/CEx1
 GJVCPdmVcCVCj7zLfkA2/Hzo/Sipemir2FfEI1N2oTu7sMsxiSrcQHv35uO5jW3mjT
 088hpPOoLQI/o0pfyJR9U+vU3uirhhlzUhnNsLJH2KtuSSAGB42s1Y36bUXs8LaFLu
 xXnKPx0gLd2Dd9fbVRuTDmsSearrW02N5874zknypmu9ZE7YWxyd31r3iQ4Mde3VmS
 RE/MUSHqMw19Q==
From: Andrey Mokrushin <a.mokrushin@ideco.ru>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, vladimir.medvedkin@intel.com,
 sdl.dpdk@linuxtesting.org, Andrey Mokrushin <a.mokrushin@ideco.ru>
Subject: [PATCH] net/ixgbe: remove unreachable WFQ weight mode check
Date: Thu, 22 Oct 2026 18:07:24 +0500
Message-ID: <20261022130724.17371-1-a.mokrushin@ideco.ru>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 Oct 2026 18:47:07 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In ixgbe_node_param_check(), a non-NULL nonleaf.wfq_weight_mode
of a non-leaf node is already rejected with "WFQ not supported"
before the n_sp_priorities check. The pointer is not modified
afterwards, so the following else-if branch that checks it again
("WFP should be byte mode") can never be taken.

Remove the dead branch. No functional change.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
---
 .mailmap                           | 1 +
 drivers/net/intel/ixgbe/ixgbe_tm.c | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6d9e262cfb..5b06576b4a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -123,6 +123,7 @@ Andrew Pinski <apinski@marvell.com>
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru> <arybchenko@solarflare.com>
 Andrey Chilikin <andrey.chilikin@intel.com>
 Andrey Ignatov <rdna@apple.com>
+Andrey Mokrushin <a.mokrushin@ideco.ru>
 Andrey Nikolaev <gentoorion@gmail.com>
 Andrey Vesnovaty <andreyv@nvidia.com>
 Andrey Yudin <andrey.yudin@infotecs.ru>
diff --git a/drivers/net/intel/ixgbe/ixgbe_tm.c b/drivers/net/intel/ixgbe/ixgbe_tm.c
index 984c157223..000223232f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_tm.c
+++ b/drivers/net/intel/ixgbe/ixgbe_tm.c
@@ -508,12 +508,6 @@ ixgbe_node_param_check(struct rte_eth_dev *dev, uint32_t node_id,
 				RTE_TM_ERROR_TYPE_NODE_PARAMS_N_SP_PRIORITIES;
 			error->message = "SP priority not supported";
 			return -EINVAL;
-		} else if (params->nonleaf.wfq_weight_mode &&
-			   !(*params->nonleaf.wfq_weight_mode)) {
-			error->type =
-				RTE_TM_ERROR_TYPE_NODE_PARAMS_WFQ_WEIGHT_MODE;
-			error->message = "WFP should be byte mode";
-			return -EINVAL;
 		}
 
 		return 0;
-- 
2.56.0


