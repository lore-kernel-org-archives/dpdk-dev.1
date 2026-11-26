Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B06606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=T9Qwcu2u
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87AE740608;
	Thu, 26 Nov 2026 09:47:27 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 25C10402BD
 for <dev@dpdk.org>; Thu, 26 Nov 2026 09:42:11 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ7E4Lu2083052; Thu, 26 Nov 2026 00:42:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
 37dncRNLLJcdsadCdKnoMxCfk2eWizGTNOCyLSdiFM=; b=T9Qwcu2u59R8/HpEC
 D1IT0hAU3bJKP2N7r58pnGbqVZwzn9IdRZjEz2Rh8Mip/HoBBrZR/Ff0bg1vN0zB
 /y2jBjl2xhSDDYLK5b5HhdMv7zHCUs9JRe1T3NKsa3buKZdGNLPbdmhKQuj9Is8A
 LbOocAUcvTsOZo+iyHXh3jObY+uq6RmytMzTxuRdy1tY8K7WTekjTMHoayC5DNpQ
 if1oDHqchc2KDDLGmiq48343rqAwmufKVqK40emMp1WAoh6q4v3jfhGuFB/ytyFO
 XnXo+T7bo3KWogJnPZj01HemSCf1YR/VvkUoVT5vqp6wtwMO1mCu9l/g5PZyxykP
 GTMsQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4j60g6chu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 00:42:09 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Nov 2026 00:42:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Nov 2026 00:42:07 -0800
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id BD9A63F7072;
 Thu, 26 Nov 2026 00:42:05 -0800 (PST)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <kai.ji@intel.com>, <anoobj@marvell.com>,
 <gmuthukrishn@marvell.com>
Subject: [PATCH v2 1/2] crypto/openssl: filter legacy ciphers from capability
 list
Date: Thu, 26 Nov 2026 14:12:00 +0530
Message-ID: <20261126084201.1173287-2-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126084201.1173287-1-psenapati@marvell.com>
References: <20261009112543.1766727-1-psenapati@marvell.com>
 <20261126084201.1173287-1-psenapati@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=f7Hdl+yM c=1 sm=1 tr=0 ts=6b07f0e1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=oTbtJoKfN9lnw4MYrU0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX3WsRVm7MVYoJ
 wi8mu6iYCY8bxZnRDLc+W7CVGYQrNp4C/YCqHm5jVllarPQDUVZh2V7TyE/PwUJLntwBwtIWV+N
 MOvh+tvwU2a8JN1Zw+DXDE0A3UyDYlu58/1kBpsR1Nv3RE2UjkUaQ9q5jvNJM6txaz1kfBfl9zV
 HUJNoZ9SpSlOuZyW3mNuy6I4uqg76nBrTjTWt6pMhs5C3fEemd0YXMDzCA98zJYC24Hy1ibTY1l
 BwXWvq1ppr7w1UK0YxzIUME/hjiW1K/XcY4Fw7yDZDf29Grw0mvv5dkRw/Be6UZRaJlb4sv1Mws
 CUOUObu1VoPdUA9F5ivr3OsCy1PsVCRlWjDOf2JQ30xuVA3nI+9mUzbuDPHjH5Fj5PFlFuADfsq
 oMA0bXBGX65YkAEfrz5qhBfoSPGel7xbhgde5omdJC82WVs1aW1eCUJxk2l9vQLQNIHHFU5m1Ji
 aaz4/ePfPPb2ObmxguA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfXwYtV76aPFQJx
 vyn6Exm8gCwCuouC3woITTFLcyFFkr3XhI6dyGCrlNKveUVsvEvDQP01vIgQl5Dq0vov0yyWwoU
 jOfeE3+HeEDlabRogqpwfJtdNRsRKCk=
X-Proofpoint-ORIG-GUID: lQyDl4zQysf9fx1pDqxvhzF80ySW-lfv
X-Proofpoint-GUID: lQyDl4zQysf9fx1pDqxvhzF80ySW-lfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Mailman-Approved-At: Thu, 26 Nov 2026 09:47:25 +0100
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

When the legacy provider is unavailable, DES ciphers were still
reported as supported, causing runtime failures when applications
attempted to use them.

Add openssl_pmd_caps_init() to build a filtered capability list at
device init, excluding DES-CBC and DES-DOCSISBPI based on legacy
provider availability. Log a warning when DES algorithms are
unavailable.

The active capability list is always populated before the device is
registered and queryable, so openssl_pmd_info_get() uses it directly
without a fallback.

Signed-off-by: Pratik Senapati <psenapati@marvell.com>
---
v2:
 - Remove unreachable fallback in openssl_pmd_info_get(): caps_active is
   always populated before the device is registered and queryable, so the
   check for RTE_CRYPTO_OP_TYPE_UNDEFINED is dead code
 - openssl_pmd_caps_init() call moved to patch 2 along with provider load
   restructure; this patch only introduces the filtering and active list

 drivers/crypto/openssl/openssl_pmd_private.h |  2 ++
 drivers/crypto/openssl/rte_openssl_pmd.c     |  1 +
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 27 +++++++++++++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/openssl/openssl_pmd_private.h b/drivers/crypto/openssl/openssl_pmd_private.h
index 059a14ef9f..e5dbe8f24b 100644
--- a/drivers/crypto/openssl/openssl_pmd_private.h
+++ b/drivers/crypto/openssl/openssl_pmd_private.h
@@ -261,4 +261,6 @@ extern struct rte_cryptodev_ops *rte_openssl_pmd_ops;
 /** ML parameter type names */
 extern const char *ml_kem_type_names[];
 extern const char *ml_dsa_type_names[];
+/** Initialize filtered capability list based on legacy provider availability */
+extern void openssl_pmd_caps_init(void);
 #endif /* _OPENSSL_PMD_PRIVATE_H_ */
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 8791186fec..b1ede62da2 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -4204,6 +4204,7 @@ cryptodev_openssl_create(const char *name,
 	 * unless the legacy provider explicitly loaded. e.g. DES
 	 */
 	ossl_legacy_provider_load();
+	openssl_pmd_caps_init();
 
 	return 0;
 
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index d3718c28e4..d7a48665d5 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -954,6 +954,8 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
 
+static struct rte_cryptodev_capabilities openssl_pmd_caps_active[RTE_DIM(openssl_pmd_capabilities)];
+
 const char *ml_kem_type_names[] = {
 	NULL,
 	"ML-KEM-512",
@@ -968,6 +970,29 @@ const char *ml_dsa_type_names[] = {
 	"ML-DSA-87",
 };
 
+/** Initialize active capability list, filtering unsupported entries. */
+void
+openssl_pmd_caps_init(void)
+{
+	uint32_t i, j = 0;
+
+	for (i = 0; openssl_pmd_capabilities[i].op != RTE_CRYPTO_OP_TYPE_UNDEFINED; i++) {
+		const struct rte_cryptodev_capabilities *cap = &openssl_pmd_capabilities[i];
+
+		if (cap->op == RTE_CRYPTO_OP_TYPE_SYMMETRIC &&
+				cap->sym.xform_type == RTE_CRYPTO_SYM_XFORM_CIPHER &&
+				(cap->sym.cipher.algo == RTE_CRYPTO_CIPHER_DES_CBC ||
+				 cap->sym.cipher.algo == RTE_CRYPTO_CIPHER_DES_DOCSISBPI)) {
+			EVP_CIPHER *des_cbc = EVP_CIPHER_fetch(NULL, "DES-CBC", "provider=legacy");
+			if (des_cbc == NULL)
+				continue;
+			EVP_CIPHER_free(des_cbc);
+		}
+		openssl_pmd_caps_active[j++] = *cap;
+	}
+	openssl_pmd_caps_active[j] = openssl_pmd_capabilities[i];
+}
+
 /** Configure device */
 static int
 openssl_pmd_config(__rte_unused struct rte_cryptodev *dev,
@@ -1039,7 +1064,7 @@ openssl_pmd_info_get(struct rte_cryptodev *dev,
 	if (dev_info != NULL) {
 		dev_info->driver_id = dev->driver_id;
 		dev_info->feature_flags = dev->feature_flags;
-		dev_info->capabilities = openssl_pmd_capabilities;
+		dev_info->capabilities = openssl_pmd_caps_active;
 		dev_info->max_nb_queue_pairs = internals->max_nb_qpairs;
 		/* No limit of number of sessions */
 		dev_info->sym.max_nb_sessions = 0;
-- 
2.43.0

