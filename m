Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBA4606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=jIN8P8P4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CC6B402DF;
	Tue, 17 Nov 2026 08:58:24 +0100 (CET)
Received: from pmg.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTPS id 81A42400EF;
 Mon, 16 Nov 2026 12:16:28 +0100 (CET)
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
 by pmg.amicon.ru (Proxmox) with ESMTP id AB20810191F;
 Mon, 16 Nov 2026 14:16:27 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
 by pmg.amicon.ru (Proxmox) with ESMTPS id 89E79101909;
 Mon, 16 Nov 2026 14:16:27 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1794827787; h=from:subject:to:date:message-id;
 bh=QPsNQIWqkGOo5frWrW1Jm9SAjbrTECVZ+yOmVTIx3Hk=;
 b=jIN8P8P4AtZU1SAXHPRNMmOIVDWTBkA4F6+3jOGQV7Yc6pkt2yIf16sxPdKFrxF4N/ZV4LzGgXb
 IZjbZCcfHoXwDjJngnE+RaoeTeOtteOD2ojQI0TTyyT96PwbN4VVKSgG0xmO6kM9lfMQ7srKQZB4f
 qQLjvOwsyVNTDG9hDASy5msQjurqbIgq46ahhLBiY5EECkGEY7ORg2khj2J5bG+c9f+H9Vff2kpWo
 utDcfrabT3zVOkHSqAvh/k4nuXg3E+PQSKsTFTJrysAvxa/EDTXkYaRjxQncICANQ3LI6/w8E0UDf
 fI4a+KX7QIK6xfkEov+51oXf+ZjmXzYtvxmA==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 16 Nov
 2026 14:16:27 +0300
From: Artem Novikov <naa@amicon.ru>
To: <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <anatoly.burakov@intel.com>,
 <stable@dpdk.org>, <rrv@amicon.ru>, Artem Novikov <naa@amicon.ru>
Subject: [PATCH] net/ice: remove unreachable TM weight mode check
Date: Mon, 16 Nov 2026 14:15:54 +0300
Message-ID: <20261116111554.27652-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:58:20 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In ice_node_param_check(), non-leaf nodes reject any non-NULL
wfq_weight_mode pointer and return immediately.

The later else-if branch checks wfq_weight_mode again, so it can only be
reached when wfq_weight_mode is NULL. As a result, the condition is always
false and the "WFP should be byte mode" error path is unreachable.

Remove the dead branch. No functional change.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8c481c3bb65b ("net/ice: support queue and queue group bandwidth limit")
Cc: stable@dpdk.org

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/net/intel/ice/ice_tm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index 2e6ef9c264..6c4c3022ec 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -144,12 +144,6 @@ ice_node_param_check(uint32_t node_id,
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

