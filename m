Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58268606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=gEYu+59F
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B34F40616;
	Thu, 26 Nov 2026 09:47:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id E0B134027A
 for <dev@dpdk.org>; Thu, 26 Nov 2026 09:42:12 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ7DdOZ2342737; Thu, 26 Nov 2026 00:42:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
 hods+6zsUb6op6mvuXSbzuovAVfi6+poXnTYRV9sFw=; b=gEYu+59FN5PGxE2uG
 SwvtDZvnfwqGeONZoMb5Yzf4YNti89Yk0ZPhJPSg84lB6TkmmWDTV6ymwGRKzmrt
 zHgJK2Qc7emydXHR7S3u8923JfA1FEcIWwahQ4G0yVgjS40AkfQnZMigSg9PZoHA
 w+hjBrBgnJgdH32ac+rcxnz6bSI8N9kQj1Q7z2MGrxoc87pMUArmqFh6vHJh3zZS
 dzGF/pVgG5YR29f6hKDE6nWsG5HBPBB4OSS2QdyD39fpxhHFGvYY3QazQLVJCjZs
 0Q4K9VzM+eo6fO0UFngO6ZMfPIxIgzEQyIyJL5hsl6qiWZvuQPPlncacncDSpJRt
 jLr7w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4j5nhf6q85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 00:42:11 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Nov 2026 00:42:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Nov 2026 00:42:10 -0800
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id 59B1D3F7072;
 Thu, 26 Nov 2026 00:42:08 -0800 (PST)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <kai.ji@intel.com>, <anoobj@marvell.com>,
 <gmuthukrishn@marvell.com>
Subject: [PATCH v2 2/2] crypto/openssl: load default provider first legacy
 optional
Date: Thu, 26 Nov 2026 14:12:01 +0530
Message-ID: <20261126084201.1173287-3-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126084201.1173287-1-psenapati@marvell.com>
References: <20261009112543.1766727-1-psenapati@marvell.com>
 <20261126084201.1173287-1-psenapati@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX3v6OrnGTpdIY
 8YUHAgCB01QSwTo7b+NL2dR/xG68hNZhHXvzioU/L6GZz0zYGoyQZLjiJ8/DAa7sOjH8yvLfyEA
 xfv3XlVyVGZp7ZG616lPHlnCVgRJW/I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX4tR2uH+IQLNC
 KKYpsaerzaPtjb8spSmO8OnPAZc8QO50Og7CFqf8WGzAlBlcEH8DPuxl0COgbEXCLK8maAB0Nk7
 KLR/MVasB3SG8oyOp+QVZmLlXOpbJbjSpGvmZtrJRE1IGA0jECzNWRTRx0xH6gnxa1v0uk9ZYy2
 li6ucGfqLJ4fUH7JnPgwXz8lKrbpw0L556IOtV4LPyRR/mjntBglG20Xe3VeN1ezQQ26jRlzamG
 IxFf12Yy6Eb4rDIWoimFyvYLOO45NqLVhD0GUr53w1taNOHAH5W+P5K5WDiNU4PWzuLtzw5he2w
 4H4IN/l97B9TD8uqFhgzLVxw3qkh8NXNKelsJeZxs+n3UUepWBhtJSHrspJFpPSNtXmwluC4OPB
 ddihBjzLrhBRLzCnheOfSPIRTsZDQ/DsdJtsJMEbzb9u+q87b5eFq96I6YcPzKNhaywmS0G/Hy7
 DVb4S2wmx+FSxxq+4dQ==
X-Proofpoint-ORIG-GUID: qxCB10mrJaHowUZxbDAOjn6BuF2pqcDq
X-Proofpoint-GUID: qxCB10mrJaHowUZxbDAOjn6BuF2pqcDq
X-Authority-Analysis: v=2.4 cv=GcGCDgXL c=1 sm=1 tr=0 ts=6b07f0e3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=B62oVDk9Aq9Sxya1MKYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

A failed OSSL_PROVIDER_load() call disables OpenSSL implicit default
provider loading. If legacy load was attempted first and failed, no
providers would be active, causing AES, SHA, and MD5 operations to fail.

Load the default provider unconditionally first. A failure here is fatal
and returns an error. Attempt legacy load second; if it is unavailable,
log a warning and continue with default-only support.

Provider load is moved to the start of cryptodev_openssl_create() before
any device resources are allocated. There is no valid use case for a PMD
without a working default provider, so failing early avoids unnecessary
device allocation and cleanup.

On provider load failure, unload providers explicitly and return -ENOTSUP.
On device creation failure, unload via the init_error path after
cryptodev_openssl_remove(). This is needed because
cryptodev_openssl_remove() returns early with -ENODEV when no device
exists, bypassing the unload.

Rename ossl_legacy_provider_load/unload to ossl_providers_load/unload
to reflect that both default and legacy providers are managed.

Signed-off-by: Pratik Senapati <psenapati@marvell.com>
---
v2:
 - Fix provider load order: default provider loaded first (always
   required), legacy loaded second (optional); v1 loaded legacy first,
   which on failure left no active providers breaking AES/SHA/MD5
 - Move provider load to start of cryptodev_openssl_create() before
   device allocation so a missing default provider fails early
 - Add ossl_providers_unload() to init_error path; needed because
   cryptodev_openssl_remove() returns -ENODEV early when no device
   exists, bypassing the unload in cryptodev_openssl_remove()
 - Rename ossl_legacy_provider_load/unload to ossl_providers_load/unload
   to reflect that both providers are now managed by these helpers
 - openssl_pmd_caps_init() call moved here from patch 1 as it logically
   belongs after provider load is complete

 drivers/crypto/openssl/rte_openssl_pmd.c | 44 ++++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index b1ede62da2..1200f22d51 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -32,24 +32,26 @@ static uint8_t cryptodev_driver_id;
 OSSL_PROVIDER *legacy;
 OSSL_PROVIDER *deflt;
 
-static void ossl_legacy_provider_load(void)
+static int
+ossl_providers_load(void)
 {
-	/* Load Multiple providers into the default (NULL) library context */
-	legacy = OSSL_PROVIDER_load(NULL, "legacy");
-	if (legacy == NULL) {
-		OPENSSL_LOG(ERR, "Failed to load Legacy provider");
-		return;
-	}
-
+	/* Load default provider first -- always required */
 	deflt = OSSL_PROVIDER_load(NULL, "default");
 	if (deflt == NULL) {
 		OPENSSL_LOG(ERR, "Failed to load Default provider");
-		OSSL_PROVIDER_unload(legacy);
-		return;
+		return -ENOTSUP;
 	}
+
+	/* Load legacy provider -- optional, non-fatal if unavailable */
+	legacy = OSSL_PROVIDER_load(NULL, "legacy");
+	if (legacy == NULL)
+		OPENSSL_LOG(WARNING, "Legacy provider not available");
+
+	return 0;
 }
 
-static void ossl_legacy_provider_unload(void)
+static void
+ossl_providers_unload(void)
 {
 	OSSL_PROVIDER_unload(legacy);
 	OSSL_PROVIDER_unload(deflt);
@@ -4169,6 +4171,12 @@ cryptodev_openssl_create(const char *name,
 	struct rte_cryptodev *dev;
 	struct openssl_private *internals;
 
+	if (ossl_providers_load() < 0) {
+		ossl_providers_unload();
+		return -ENOTSUP;
+	}
+	openssl_pmd_caps_init();
+
 	dev = rte_cryptodev_pmd_create(name, &vdev->device, init_params);
 	if (dev == NULL) {
 		OPENSSL_LOG(ERR, "failed to create cryptodev vdev");
@@ -4199,20 +4207,12 @@ cryptodev_openssl_create(const char *name,
 
 	rte_cryptodev_pmd_probing_finish(dev);
 
-	/* Load legacy provider
-	 * Some algorithms are no longer available in earlier version of openssl,
-	 * unless the legacy provider explicitly loaded. e.g. DES
-	 */
-	ossl_legacy_provider_load();
-	openssl_pmd_caps_init();
-
 	return 0;
 
 init_error:
-	OPENSSL_LOG(ERR, "driver %s: create failed",
-			init_params->name);
-
+	OPENSSL_LOG(ERR, "driver %s: create failed", init_params->name);
 	cryptodev_openssl_remove(vdev);
+	ossl_providers_unload();
 	return -EFAULT;
 }
 
@@ -4254,7 +4254,7 @@ cryptodev_openssl_remove(struct rte_vdev_device *vdev)
 	if (cryptodev == NULL)
 		return -ENODEV;
 
-	ossl_legacy_provider_unload();
+	ossl_providers_unload();
 
 	return rte_cryptodev_pmd_destroy(cryptodev);
 }
-- 
2.43.0

