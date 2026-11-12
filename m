Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC96070FE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=eF4HiKhv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66144402A4;
	Fri, 13 Nov 2026 17:05:49 +0100 (CET)
Received: from pmg.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTPS id 9243A402A2;
 Thu, 12 Nov 2026 12:41:10 +0100 (CET)
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
 by pmg.amicon.ru (Proxmox) with ESMTP id 9279A101823;
 Thu, 12 Nov 2026 14:41:07 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
 by pmg.amicon.ru (Proxmox) with ESMTPS id 72E111017E2;
 Thu, 12 Nov 2026 14:41:07 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1794483667; h=from:subject:to:date:message-id;
 bh=81YhSjGCYrShlUsqCcli9ugvibpCp1OvZbfdW4lI+V8=;
 b=eF4HiKhvvpa1RC7UtNotaqf3En3d14y9+aycXCI9On4NXFBnThGE/O4wdUhJLWmRa0QtbucR9gw
 80VxJ+BxfCJ56cy2+qsnNm7IW00HuZYxTuwXO8ZqMb5nOvivNcHwR9hv7Ohwd7LEBsCMgdAVa9tDe
 LpyyibI+uC92nustmeAG9tz45TPSrZcAtlH5WvWsG7CxBx6A7ofevu9C1ychywKRL6FtbwHEBTWO7
 FHLERXBWIiLWGiMVtizloIyu8bqHn6MOqJEIgGT9EOnCBpPXX35O4XYAmbGYmosg1qS6cqzAXBylc
 4WlJbVRcBmi5a1+e4dov+IXU6kBSyDSP88Wg==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Thu, 12 Nov
 2026 14:41:06 +0300
From: Artem Novikov <naa@amicon.ru>
To: <vladimir.medvedkin@intel.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <rrv@amicon.ru>,
 <radu.nicolau@intel.com>, Artem Novikov <naa@amicon.ru>, <stable@dpdk.org>
Subject: [PATCH] net/iavf: remove unreachable flow return
Date: Thu, 12 Nov 2026 14:41:00 +0300
Message-ID: <20261112114100.167839-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:05:48 +0100
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

After checking the RSS, distribution and IPsec crypto parser lists,
iavf_flow_process_filter() returns success as soon as it finds an
engine. If all three searches fail, *engine is NULL, so the final
return 0 is unreachable and the preceding NULL check is redundant.

Report the error unconditionally after the searches and remove the
unreachable success return. No functional change.

Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
Cc: stable@dpdk.org

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
Cc: Radu Nicolau <radu.nicolau@intel.com>

 drivers/net/intel/iavf/iavf_generic_flow.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 9608ec59b1840d40be98717833ea4e8edfa98277..a5f19ccda3452101dccb284c566559be8bb8b1a0 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -2199,14 +2199,10 @@ iavf_flow_process_filter(struct rte_eth_dev *dev,
 	if (*engine)
 		return 0;
 
-	if (!*engine) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Failed to create parser engine.");
-		return -rte_errno;
-	}
-
-	return 0;
+	rte_flow_error_set(error, EINVAL,
+			   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			   "Failed to create parser engine.");
+	return -rte_errno;
 }
 
 static int

