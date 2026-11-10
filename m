Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95D606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 10:40:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CED440283;
	Tue, 10 Nov 2026 11:40:00 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 8E7774027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 11:39:59 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3E98F2024A
 for <dev@dpdk.org>; Tue, 10 Nov 2026 11:39:59 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 10 Nov 2026 11:39:58 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] net: add special-purpose MPLS label values
Date: Tue, 10 Nov 2026 10:39:52 +0000
Message-ID: <20261110103952.4114848-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Nov 2026 10:39:58.0980 (UTC)
 FILETIME=[D5601C40:01DD70FF]
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Added definitions of Special-Purpose MPLS Label Values,
with reference to IANA registry.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/net/rte_mpls.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/net/rte_mpls.h b/lib/net/rte_mpls.h
index 53614a0b88..39c69e1ea9 100644
--- a/lib/net/rte_mpls.h
+++ b/lib/net/rte_mpls.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2016 6WIND S.A.
+ * Copyright(c) 2026 SmartShare Systems
  */
 
 #ifndef _RTE_MPLS_H_
@@ -14,6 +15,24 @@
 #include <stdint.h>
 #include <rte_byteorder.h>
 
+/*
+ * Special-Purpose MPLS Label Values
+ * https://www.iana.org/assignments/mpls-label-values
+ */
+#define RTE_MPLS_LABEL_IPV4         0   /**< IPv4 Explicit NULL Label (RFC 3032). */
+#define RTE_MPLS_LABEL_ROUTER_ALERT 1   /**< Router Alert Label (RFC 3032). */
+#define RTE_MPLS_LABEL_IPV6         2   /**< IPv6 Explicit NULL Label (RFC 3032). */
+#define RTE_MPLS_LABEL_NULL         3   /**< Implicit NULL Label (RFC 3032). */
+#define RTE_MPLS_LABEL_MNA          4   /**< MPLS Network Actions (RFC 9994). */
+#define RTE_MPLS_LABEL_ELI          7   /**< Entropy Label Indicator (ELI) (RFC 6790). */
+#define RTE_MPLS_LABEL_GAL          13  /**< Generic Associated Channel Label (GAL) (RFC 5586). */
+#define RTE_MPLS_LABEL_OAM_ALERT    14  /**< OAM Alert Label (RFC 3429). */
+#define RTE_MPLS_LABEL_XL           15  /**< Extension Label (XL) (RFC 7274; RFC 9017). */
+/* Extended Special-Purpose MPLS Label Values (valid when following an Extension Label) */
+#define RTE_MPLS_LABEL_MLI          16  /**< Metadata Label Indicator (MLI) (RFC 8595). */
+#define RTE_MPLS_LABEL_MPI          17  /**< Metadata Present Indicator (MPI) (RFC 8595). */
+#define RTE_MPLS_LABEL_FLI          18  /**< Flow-ID Label Indicator (FLI) (RFC 9714). */
+
 /**
  * MPLS header.
  */
-- 
2.43.0

