Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D11C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABC4B40E2E;
	Mon, 26 May 2025 19:00:34 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C12D240673
 for <dev@dpdk.org>; Mon, 26 May 2025 19:00:30 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QGv80w007027
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 9TR/u6VBUgxkeQ7tfgoc/rgACG0fRULBBHnIpB0DvI=; b=Dk7YbhSFitvY92hzq
 z+Dswg1s8YfAbRKakCuxIu1zqRF0wTePe8tkKlMXPirppJj6Uh0BBF8yaJg7pLxg
 8CxsHbLh0vr+p8XHtXc3WIcK1BFzj6UO7KBPnr4pq/+tlSAC/wfHNyYG/IRtbuKH
 P2xiG8Q6B0LQKpiEPkCp8hIP9bY5bjrFT0e7+d3X5yXk0b+4Gcpr+BpQaviV7Og2
 5N8RQEuhQ/E9MriUfFQwf1HB2cpiG5E/2KXKX6Gqa51W3n8QNzSAIWRflNwk53Mh
 94ck4ZDEH/c4P31PUDNv/CmepW3BV98dBxTIMoXRUUOen/N+jk605fIi7LK0eAcL
 RQGYQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46vnv1gsuf-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:29 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 10:00:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 10:00:27 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 39BAE3F7063;
 Mon, 26 May 2025 10:00:23 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 38/40] doc: update CN20K CPT documentation
Date: Mon, 26 May 2025 22:28:17 +0530
Message-ID: <20250526165819.2197892-39-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: L4PBtKyWLkj0Ja7Omc7F9Atdiu10nWA_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfX2RPc5zcLQzLj
 JQxo64AwUDOqcsEL2090yq1uzeUbf57mXy8+hTIUwF7hgDf6pZq/UpTlYINSCpFhzHNaMKLPxX/
 PR63yIT8i+xdvO0OUkavjrYfL54qr75usdAiM9znEH86A5dwieBONBT/uKj8C+/NMnDug7UTmfh
 O+DNAAjWIrB3lZTr+IkUGF2buVrgjNsd7JtVduwMKnxGzVv5cfOfuzix6OwNPniR06otT8ZQ0f/
 Fx/b0YZmE4H2YTwYvWU/mIn6f8GncuAO/WboM4mxJDtr32YBlS/M9007iPwxO4XOJ195o0w6GRm
 gqJgmZ9/ZYbe0+vL7+Ac6K5+qv79hOgwgFSK7zCP6Z46QeVZOEFqTCMDmJnAT23VUl1baD1847k
 xuj4WiVkRBosupKahNlHOAGB8F6gOgh9hkqT5sr64i8d1RYYD7NAIjYJKY2m1yVteVrvHm5o
X-Proofpoint-ORIG-GUID: L4PBtKyWLkj0Ja7Omc7F9Atdiu10nWA_
X-Authority-Analysis: v=2.4 cv=PPgP+eqC c=1 sm=1 tr=0 ts=68349e2d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=6cXmKztfqU2S9WV7NuMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

Updating documentation for CN20K CPT support.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 doc/guides/cryptodevs/cnxk.rst           |  26 +++++-
 doc/guides/cryptodevs/features/cn20k.ini | 113 +++++++++++++++++++++++
 2 files changed, 134 insertions(+), 5 deletions(-)
 create mode 100644 doc/guides/cryptodevs/features/cn20k.ini

diff --git a/doc/guides/cryptodevs/cnxk.rst b/doc/guides/cryptodevs/cnxk.rst
index ac843ddc53..1799161fdf 100644
--- a/doc/guides/cryptodevs/cnxk.rst
+++ b/doc/guides/cryptodevs/cnxk.rst
@@ -9,8 +9,8 @@ cryptographic operations to cryptographic accelerator units on the
 **Marvell OCTEON cnxk** SoC family.
 
 The cnxk crypto PMD code is organized into different sets of files.
-The file names starting with cn9k and cn10k provides support for CN9XX
-and CN10XX respectively. The common code between the SoCs is present
+The file names starting with cn9k, cn10k and cn20k provides support for CN9XX,
+CN10XX and CN20XX respectively. The common code between the SoCs is present
 in file names starting with cnxk.
 
 More information about OCTEON cnxk SoCs may be obtained from `<https://www.marvell.com>`_
@@ -20,6 +20,7 @@ Supported OCTEON cnxk SoCs
 
 - CN9XX
 - CN10XX
+- CN20XX
 
 Features
 --------
@@ -144,7 +145,7 @@ Bind the CPT VF device to the vfio_pci driver:
 
       Refer to :ref:`linux_gsg_hugepages` for more details.
 
-``CN10K Initialization``
+``CN10K/CN20K Initialization``
 
 List the CPT PF devices available on cn10k platform:
 
@@ -232,6 +233,13 @@ running the test application:
     ./dpdk-test
     RTE>>cryptodev_cn10k_autotest
 
+``CN20K``
+
+.. code-block:: console
+
+    ./dpdk-test
+    RTE>>cryptodev_cn20k_autotest
+
 The asymmetric crypto operations on OCTEON cnxk crypto PMD may be verified by
 running the test application:
 
@@ -249,6 +257,13 @@ running the test application:
     ./dpdk-test
     RTE>>cryptodev_cn10k_asym_autotest
 
+``CN20K``
+
+.. code-block:: console
+
+    ./dpdk-test
+    RTE>>cryptodev_cn20k_asym_autotest
+
 Lookaside IPsec Support
 -----------------------
 
@@ -265,6 +280,7 @@ Supported OCTEON cnxk SoCs
 
 - CN9XX
 - CN10XX
+- CN20XX
 
 CN9XX Features supported
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -301,8 +317,8 @@ Auth algorithms
 * AES-XCBC-96
 * AES-GMAC
 
-CN10XX Features supported
-~~~~~~~~~~~~~~~~~~~~~~~~~
+CN10XX/CN20XX Features supported
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 * IPv4
 * ESP
diff --git a/doc/guides/cryptodevs/features/cn20k.ini b/doc/guides/cryptodevs/features/cn20k.ini
new file mode 100644
index 0000000000..76553d190e
--- /dev/null
+++ b/doc/guides/cryptodevs/features/cn20k.ini
@@ -0,0 +1,113 @@
+;
+; Supported features of the 'cn20k' crypto driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Symmetric crypto       = Y
+Asymmetric crypto      = Y
+Sym operation chaining = Y
+HW Accelerated         = Y
+Protocol offload       = Y
+In Place SGL           = Y
+OOP SGL In LB  Out     = Y
+OOP SGL In SGL Out     = Y
+OOP LB  In LB  Out     = Y
+Symmetric sessionless  = Y
+RSA PRIV OP KEY EXP    = Y
+RSA PRIV OP KEY QT     = Y
+Digest encrypted       = Y
+Sym raw data path API  = Y
+Inner checksum         = Y
+Rx inject              = Y
+
+;
+; Supported crypto algorithms of 'cn20k' crypto driver.
+;
+[Cipher]
+NULL           = Y
+3DES CBC       = Y
+3DES ECB       = Y
+AES CBC (128)  = Y
+AES CBC (192)  = Y
+AES CBC (256)  = Y
+AES CTR (128)  = Y
+AES CTR (192)  = Y
+AES CTR (256)  = Y
+AES XTS (128)  = Y
+AES XTS (256)  = Y
+DES CBC        = Y
+KASUMI F8      = Y
+SNOW3G UEA2    = Y
+ZUC EEA3       = Y
+SM4 ECB        = Y
+SM4 CBC        = Y
+SM4 CTR        = Y
+SM4 CFB        = Y
+SM4 OFB        = Y
+
+;
+; Supported authentication algorithms of 'cn20k' crypto driver.
+;
+[Auth]
+NULL            = Y
+AES GMAC        = Y
+KASUMI F9       = Y
+MD5             = Y
+MD5 HMAC        = Y
+SHA1            = Y
+SHA1 HMAC       = Y
+SHA224          = Y
+SHA224 HMAC     = Y
+SHA256          = Y
+SHA256 HMAC     = Y
+SHA384          = Y
+SHA384 HMAC     = Y
+SHA512          = Y
+SHA512 HMAC     = Y
+SNOW3G UIA2     = Y
+ZUC EIA3        = Y
+AES CMAC (128)  = Y
+AES CMAC (192)  = Y
+AES CMAC (256)  = Y
+SHA3_224        = Y
+SHA3_224 HMAC   = Y
+SHA3_256        = Y
+SHA3_256 HMAC   = Y
+SHA3_384        = Y
+SHA3_384 HMAC   = Y
+SHA3_512        = Y
+SHA3_512 HMAC   = Y
+SHAKE_128       = Y
+SHAKE_256       = Y
+SM3             = Y
+
+;
+; Supported AEAD algorithms of 'cn20k' crypto driver.
+;
+[AEAD]
+AES GCM (128)     = Y
+AES GCM (192)     = Y
+AES GCM (256)     = Y
+AES CCM (128)     = Y
+AES CCM (192)     = Y
+AES CCM (256)     = Y
+CHACHA20-POLY1305 = Y
+
+;
+; Supported Asymmetric algorithms of the 'cn20k' crypto driver.
+;
+[Asymmetric]
+RSA                     = Y
+Modular Exponentiation  = Y
+ECDH                    = Y
+ECDSA                   = Y
+ECPM                    = Y
+SM2                     = Y
+EdDSA                   = Y
+
+;
+; Supported Operating systems of the 'cn20k' crypto driver.
+;
+[OS]
+Linux = Y
-- 
2.25.1

