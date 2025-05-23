Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414E6C54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4915B410DD;
	Fri, 23 May 2025 15:53:21 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 56516410D3
 for <dev@dpdk.org>; Fri, 23 May 2025 15:53:20 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBwrje008033
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 9TR/u6VBUgxkeQ7tfgoc/rgACG0fRULBBHnIpB0DvI=; b=iqIGB9INZocsMrvMM
 VnuxZfJy46ZnZHSx6qXPPKKSpw0GjpMs3buehSIfBKT9Vtt8GMjzcAtIC8gzPoeu
 J5l1UxuZXP2e/FwsnmDQPo6wvQ9ra4LBqFrcx7zizjswjgKAip0JZCz6rnp+7ysB
 74cIGb1cji/gHn0iwb4AoPnhoriYq6CmLor1K2IbGcpcWsDvlRzmoarVcaGbvV7W
 PzXT7JzO6awluNXLD2zWx1P+7v+rfHnVWSPOq909t7kylFbms2OOWbubVBVEB9V5
 suJHNR7FFgoQlygwm9lafukOazCiWDQGrpd6XZ6eN+oTksTRY5IO+WDe7X8lD6Ga
 spOCA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw589mm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:53:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:53:18 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id EF57B3F7083;
 Fri, 23 May 2025 06:53:15 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 38/40] doc: update CN20K CPT documentation
Date: Fri, 23 May 2025 19:21:09 +0530
Message-ID: <20250523135111.2178408-39-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68307dcf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=6cXmKztfqU2S9WV7NuMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX0zC+KDi+Tv80
 OtWcIVNQHfcEg09EVSCmDgry0HdE6aHA+bitxVtxlOckhzKStqEd34eRPqEoAioCQp059N+JxuN
 +ZMRW+5/q64pL+RLxpkAkeomCAd2l/YUrlj7Q1bV9ulZTOA1zRMmBHotP5ZdbZojbxUxmUQtHB3
 qVkNzIHYc59Ob2KelPlXkFE1tK4PKVjf2wyjr550KKQG5AUMoTY7SQqqhKSLT+PI8H3J6z45iWj
 48XmjmBX2vyOmVV4DmaG1f0kYjgYJSNRXy5jrVGXUZqayWvAMLWWmWksieNoOumCIk6M9gOFggz
 YE4Lnn7XhBOHSTAXjb1mWUglOewkIzqHqrNXHV9A5WdVLkuTdasveBDU/SjzQtASV0jpWgMlUOH
 CiJh1ex75WCKRBDEKVaALQ3ZPnLVufQKI50t/QxO0Rxlb2aCYXyc+3Hb3mOW3BCdzjRH6LGx
X-Proofpoint-GUID: BJVuXN-RTYR2_xNCBNVSAKNp7Xg77fdO
X-Proofpoint-ORIG-GUID: BJVuXN-RTYR2_xNCBNVSAKNp7Xg77fdO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

