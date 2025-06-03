Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D6CC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:53:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC6F240E3E;
	Tue,  3 Jun 2025 13:51:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5113640E30
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:51:28 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553AHu3E017702
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:51:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 XfaRbcb+7HqVk19FXa00bd2oSuo5FHhNuxLgGwnhe8=; b=Yuzyau0El8yCNuVBk
 AzvkKR3WyuSf+ZasqN0jzaYnNQfd5BdL+hA7gsnkJVz0DDJP32m8tMSSQYips1TI
 zpBHvz0QlL/g7UjJUsu+B05lNPc8spFzbkX0UZysLp7bxzPTcE0gWCTmUnDWRenJ
 EtNIxRR1bwyQ+Jx4aorv/J4zzhDnUHFuZhFc87KfP4OAYxymNG5bMOJZ8BBBoWGo
 opH4mbKSOBiM2oRXkLOERgL+rK3fZDysmzq4LrDrUcjrc6Dbq/UkYf8QK4uXfMw1
 61AFbC407lThK0FrkHTzBm8NtjinbOWnkJUw6Prq2HFgVmic5qQnj+HS3Qdzf6aI
 HJL8A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 471y6304f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:51:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:51:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:51:26 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id E8FAE3F7041;
 Tue,  3 Jun 2025 04:51:24 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 25/25] doc: update cn20k CPT documentation
Date: Tue, 3 Jun 2025 17:20:26 +0530
Message-ID: <20250603115026.2664706-26-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfX57H3cQek2j6f
 nucX1JTug0UPvJL9nPXP7p67+Y3ALzL+vEneFnZal0yw5l9PSuaSE4rYkqsENe8PAwugYE/5EAf
 rHVMnp+IStjYIailQ9ogpuuSxBkuCMb3KH+w5j0zoLBKOqrzJgJggioJJHNA7m1ZiiPJuMkArXX
 y6sFr03oQEZLsmW9xqpn4pSx8JtEaLGU4b4ReirL13H6IiBLwqURq0VaZadKQVA6eZ2Qq/LVxxv
 bYQAleNoyN0EwSC6HegqfnnMChcpM+5+ngbx5+5zGc3KiFZue3/mja6XU+uaBu1q6EnBQinFNdF
 pWSKjLRHrLb7jDhlMcDJRIpcdKmcMUTyO5yImz9YelrhALqC+CzkiST2aTAnxVi9MAqIjW+7ep2
 zG935TKpWZflD0/FV37udZtVAC6glAhI0UHoKPKRGpReksz0oJjk81HhPU/bD/iaCDztOjsy
X-Proofpoint-GUID: OJqr9Zls9aQfXV7gCz2Mb2V7gpPr0ewB
X-Authority-Analysis: v=2.4 cv=QaJmvtbv c=1 sm=1 tr=0 ts=683ee1bf cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=6cXmKztfqU2S9WV7NuMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: OJqr9Zls9aQfXV7gCz2Mb2V7gpPr0ewB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

Updating documentation for cn20k CPT support.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 doc/guides/cryptodevs/cnxk.rst           |  26 +++++-
 doc/guides/cryptodevs/features/cn20k.ini | 113 +++++++++++++++++++++++
 doc/guides/rel_notes/release_25_07.rst   |   3 +
 3 files changed, 137 insertions(+), 5 deletions(-)
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
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index f8ad77c2ca..5a772c0b69 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -74,6 +74,9 @@ New Features
 
   See the :doc:`../cryptodevs/zsda` guide for more details on the new driver.
 
+* **Updated Marvell cnxk crypto driver.**
+
+  * Added CPT PMD support for CN20K SoC.
 
 Removed Items
 -------------
-- 
2.25.1

