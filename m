Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D7CA9EC9
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 07:41:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09125402C8;
	Sun, 11 Oct 2026 09:41:43 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 28EFF40274
 for <dev@dpdk.org>; Fri,  9 Oct 2026 13:25:49 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998IcnC2750986; Fri, 9 Oct 2026 04:25:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 jFcPfob+QXY1EzYYeowdvPVRAc5Kafvp/5cwngnkhg=; b=aXjzK+kN4gMS/apzA
 QXwgb6f0aKpOsvOBeK8UiNdgC98/R001DwUZy0hhAoMyMrN4rqrjh/DXYnLkPAeN
 J/pi8asLlQ+W5A7kFcCW9VIygbg9QwljAdC+UIbudIBW4z0uPknOKk76Tx9VCpG/
 3oLibC7bmZJxZ81dDl5prCUt07KhO+CNv2nsc1zEH7LU37ftpM092ntFa7Lhp1TX
 5ZRoANhq1N/lQh9XvSU1fzd53sjqNe+Bm8pFYOdoV5qTw+tdwopi4F4r9Xvn6CJK
 H6rnz5mjJ2QtQoDFAyqL+vfgI4SUqa4TNf+x5Z5AKaBNJ3gMDzlsQWW6FdzW2Ktb
 kqe1Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4h6kmftppx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 04:25:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Oct 2026 04:25:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Oct 2026 04:25:47 -0700
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id 45D7A3F7055;
 Fri,  9 Oct 2026 04:25:46 -0700 (PDT)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <kai.ji@intel.com>
Subject: [PATCH v1 1/1] crypto/openssl: filter legacy ciphers from capability
 list
Date: Fri, 9 Oct 2026 16:55:43 +0530
Message-ID: <20261009112543.1766727-2-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009112543.1766727-1-psenapati@marvell.com>
References: <20261009112543.1766727-1-psenapati@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfXy6ITNGb9tg8B
 gOrZclya/VFgFYdID3cft+fsssUoJSGVWmKHZZvFrYTmhy35xhoORKCf2xrTuUTEB/OEJNuNYfm
 g6WeketBbjja1S0QXfXcFrFuO8it+qs=
X-Proofpoint-GUID: VYz704NC-nLEyWlI85L17KzOB7pEfh_8
X-Proofpoint-ORIG-GUID: VYz704NC-nLEyWlI85L17KzOB7pEfh_8
X-Authority-Analysis: v=2.4 cv=bP2Ds/+Z c=1 sm=1 tr=0 ts=6ac8cf3b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=nHadp34HEaI70njISScA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX6nncQ4J2mZRn
 PssIAvgixYUZDG5sT9bnASSuWQAaIpt9Tnl/CNijDsSt98c+8wjc0M+XMriLnG1REyVu6lSrSXd
 f4+tTYuYcNtOIB7xJY2aYJYu8OFwXia2SBWXXLeJEmDHT7m05fIJhjjznewNDiLSO7u8f2pnknM
 bDrQj/u2Liqfq5wkL/UMParEZv6GEC7QSaOtAMywvCicP5yYrKWpspT6VRsVrQDXnKDswCXaxN+
 MeYx4uGTLFJX2geZCZERx1gaf8cj6spogPVrUR1ZYQSdrscy8u2i5dznzjR7ihRFCVmTz64XkqS
 om8HADB5nw2k5D1MbHuHP1Rzas+V+eWb0IsvAk7xvO7wP3Ah7HB/JbFoTO6dIHRO8rX6JDL+C44
 i05VnEk2yh0sREGr+6mMDZXfY81O3SQ8iHYmjg6cgbGqiUNZVX/QuYqc3e7y9pKwu2SY/wjpljQ
 6f7LzVmStGzNiuEMmRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Mailman-Approved-At: Sun, 11 Oct 2026 09:41:40 +0200
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

When the legacy provider is unavailable, DES ciphers were still
reported as supported, causing runtime failures when applications
attempted to use them.

Add openssl_pmd_caps_init() to build a filtered capability list at
device init, excluding DES-CBC and DES-DOCSISBPI based on legacy
provider availability. Add a warning when DES algorithms are
unavailable.

Signed-off-by: Pratik Senapati <psenapati@marvell.com>
---
 drivers/crypto/openssl/openssl_pmd_private.h |  2 ++
 drivers/crypto/openssl/rte_openssl_pmd.c     |  3 +-
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 29 +++++++++++++++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/openssl/openssl_pmd_private.h b/drivers/crypto/openssl/openssl_pmd_private.h
index ab40012d61..71d78459ee 100644
--- a/drivers/crypto/openssl/openssl_pmd_private.h
+++ b/drivers/crypto/openssl/openssl_pmd_private.h
@@ -21,6 +21,8 @@
 
 /** OPENSSL PMD LOGTYPE DRIVER */
 extern int openssl_logtype_driver;
+/** Initialize filtered capability list based on legacy provider availability */
+extern void openssl_pmd_caps_init(void);
 #define RTE_LOGTYPE_OPENSSL_DRIVER openssl_logtype_driver
 #define OPENSSL_LOG(level, ...)  \
 	RTE_LOG_LINE_PREFIX(level, OPENSSL_DRIVER, "%s() line %u: ", \
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 2319c7cfa9..275078050a 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -37,7 +37,7 @@ static void ossl_legacy_provider_load(void)
 	/* Load Multiple providers into the default (NULL) library context */
 	legacy = OSSL_PROVIDER_load(NULL, "legacy");
 	if (legacy == NULL) {
-		OPENSSL_LOG(ERR, "Failed to load Legacy provider");
+		OPENSSL_LOG(WARNING, "Failed to load Legacy provider");
 		return;
 	}
 
@@ -3941,6 +3941,7 @@ cryptodev_openssl_create(const char *name,
 	 * unless the legacy provider explicitly loaded. e.g. DES
 	 */
 	ossl_legacy_provider_load();
+	openssl_pmd_caps_init();
 
 	return 0;
 
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index d927cc5228..3dc1ee11a2 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -929,6 +929,7 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
 
+static struct rte_cryptodev_capabilities openssl_pmd_caps_active[RTE_DIM(openssl_pmd_capabilities)];
 const char *ml_kem_type_names[] = {
 	NULL,
 	"ML-KEM-512",
@@ -943,6 +944,29 @@ const char *ml_dsa_type_names[] = {
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
@@ -1014,7 +1038,10 @@ openssl_pmd_info_get(struct rte_cryptodev *dev,
 	if (dev_info != NULL) {
 		dev_info->driver_id = dev->driver_id;
 		dev_info->feature_flags = dev->feature_flags;
-		dev_info->capabilities = openssl_pmd_capabilities;
+		if (openssl_pmd_caps_active[0].op == RTE_CRYPTO_OP_TYPE_UNDEFINED)
+			dev_info->capabilities = openssl_pmd_capabilities;
+		else
+			dev_info->capabilities = openssl_pmd_caps_active;
 		dev_info->max_nb_queue_pairs = internals->max_nb_qpairs;
 		/* No limit of number of sessions */
 		dev_info->sym.max_nb_sessions = 0;
-- 
2.43.0

