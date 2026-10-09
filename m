Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE380CA9EC9
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 07:42:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57E30402E9;
	Sun, 11 Oct 2026 09:41:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D7AD940280
 for <dev@dpdk.org>; Fri,  9 Oct 2026 13:28:45 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998IiJg2796980; Fri, 9 Oct 2026 04:28:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 jFcPfob+QXY1EzYYeowdvPVRAc5Kafvp/5cwngnkhg=; b=FJf+BQwpfj+NYmVkw
 70k0ffni9WiBxdOBj/oFAB440E10gJBupQNzlKDW6en371uoInVCzsKcDETOAaY6
 UhMYrBAYYH7W5Hc2hmNU3K7oq/6wAbSWFCtr4FSh0bzXIqgjAvaYdbCjNshaXSlM
 w13BtC2gYoqkk1UPenYVEWwXTTfv1i0PsChU9R+SMwpYAgdJGmSLfHArLhMGnwGy
 GpCmFzUZMsJ9cFiTQpZLDVY5hKvtf+wBdc1j3SkcQofbt4GP9TDWe6Zvfhgg2IIo
 +fYydjFRlLlH4QuCQpSIgJ0ubHoloO3k7ji3j9tcC/sHHJQaPcZ2zJwHq6EACgQZ
 62moQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h6kjs2m57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 04:28:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Oct 2026 04:28:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Oct 2026 04:28:44 -0700
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id A5BA83F7058;
 Fri,  9 Oct 2026 04:28:42 -0700 (PDT)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <gmuthukrishn@marvell.com>, <kai.ji@intel.com>
Subject: [PATCH v1 1/1] crypto/openssl: filter legacy ciphers from capability
 list
Date: Fri, 9 Oct 2026 16:58:39 +0530
Message-ID: <20261009112839.1766920-2-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009112839.1766920-1-psenapati@marvell.com>
References: <20261009112839.1766920-1-psenapati@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: p10BqicQ29GV4LNuuhVpdFQrqpimdjC4
X-Proofpoint-ORIG-GUID: p10BqicQ29GV4LNuuhVpdFQrqpimdjC4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX170r0h3HvUne
 8vPBVlNhC2yLAswjJfZw7coYWsh8dxGR3sPpUdiT3Cp0bOnTUqmayZ8/AjajW1EmMF4Z3+FAPag
 RW+NZtTh/BfIvDJ8Px37r+ewFgcQdXc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfXwnByxKzyBX4d
 QH9fVSlE0S20zYYEDW+31foqctn5uZBJSc80kdKVHRXrm4BzkxnvK5MfI7F/PPxwlYzU6sKv1jH
 xiQBDAfdq2kR/tZbR26IH770pr0Up7oVbPv5NQA0gUlUjgPrzovVCl1a1WUCWRDFZrdWn/HYs0e
 /fNUZ5Fepy8EmI/7947OKH0OmWepwHoYfgWXKRqGL9ll1Nl3liJg88lkHATgzWbfLnxc5nn3Ehz
 WVW/LImBbOrzeZUJuiMFI0nGDcrRQOdrzQpI489wgyPLpskPCtPjP4FlTZsQdxxdLE+Kf3Vmkaq
 Qzw65SZAJm/6rjuL2if+EPhajE3w1lQBlql+a/uX0rfemcFMpDTvMKHLAK6lTt5lrl2KJdrJmO/
 jBnrzhZxcIQy2gzr9a2UlHND3TP2mnRyeaL+nCkX43TYilHxZ6dDvlZEv0HhRvgtoj/dAvRxCik
 nmcS6zcz+Aa9gaqr1rA==
X-Authority-Analysis: v=2.4 cv=BPQmP1QG c=1 sm=1 tr=0 ts=6ac8cfed cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=nHadp34HEaI70njISScA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

