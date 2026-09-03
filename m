Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B32C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 08:27:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2AFE4275D;
	Thu,  3 Sep 2026 10:27:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4B51542790
 for <dev@dpdk.org>; Thu,  3 Sep 2026 10:27:21 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6835mSvt199094; Thu, 3 Sep 2026 01:27:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 xRj96mFgI9MRqIfPFhMZGo7EjDnPR0iyTh7p2l37WM=; b=j4CBPkrtnbFXHsblG
 AJCaONJfxeTOclzp5DQOSsRTJhhFKCPPE4kZuBhb7MdFVELTXcFXH+690l51swO0
 Puhn+zmNtNuvPiTDvtL84ENVUZvtQaOPKx3cpXaJL3gw4X2P6DxUgMgwFvdEcK7G
 4vJOcpYU9FmvgDkiMb2SExW2oWfKnpoNgJ0USZhRlay72MM33+ftcmYcmlZOiLbD
 vVwESyA6IgWD5GBxpaWNzJsoY95V7v3Ykj52DVpVhjCgZi4zsjvrse3wLKiLKPv8
 EL+Aw4hYiihUmG8Bowf963f+r4PvgNT2E2vedS89yMaQEgaDEv36r9u8yWp1lx/f
 ocFYg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gew3k1bpf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 01:27:20 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Sep 2026 01:27:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 3 Sep 2026 01:27:19 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 83D923F7068;
 Thu,  3 Sep 2026 01:27:15 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v2 3/8] crypto/cnxk: advertise RSA PKCS#1 v1.5 padding support
Date: Thu, 3 Sep 2026 08:26:43 +0000
Message-ID: <20260903082648.3610676-4-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903082648.3610676-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
 <20260903082648.3610676-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GdjPK_qCRg8h2zhBm-2-T0HIpeEm67oL
X-Authority-Analysis: v=2.4 cv=OYSoyBTY c=1 sm=1 tr=0 ts=6a992f68 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=fIrzOnsVuvAh4eYyrfwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX6EYKYgQn+/9L
 7Tcs6j6tUlyfqgBsqCNspeEOhVcL2YKz7MmzMv1NJQ+xmFI10B0UE9gWMp9SpEiBzlkhMkhAb4a
 W4FJlyV9blE7ieIOqYSiiIXf4Aznd8hFyKnzI1cQvJt6L/4jBEG5yB0xZZe8GnpDX/I2fxrihek
 dwaYjmQjByp4ZSiUggsA4um/9iO1uM271VDJxMfJ1fdpRGgoV4JXc4JYkS/hWqLq8CYQb+Og2kk
 R1WsISg6XUvpirXgEsleg2rSRR24LKoWO8HspjGVD8Ex17agp86BX2/0AKsIiZIHUl78fOLgrt9
 uJJ/AX39L96nKZkAGTLTvIoifZEafjsY2a221dU8KAP3HSX7EcQN3HFl/5l3dHp55O2aqiCZEB/
 wnn1MiiPB4u2wG0qN4/ZM67x9tEVa83pzCvOBbi5E2VHFH6k34ugYt32lWCVl7DeDE3nsyD9u2O
 F9FosQAxlz7C8ED6wLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX0ln9gezXLGkc
 Z/OVmkb41uo7NIkEYeKmn6dhzNcNWSqQjDpnTngpCc/f4rvjqe3XL82dfXvCJCM8F8Y3fVQFbxE
 WsIg3LQPRC4+IF4jv9RutqOsJz5atT8=
X-Proofpoint-GUID: GdjPK_qCRg8h2zhBm-2-T0HIpeEm67oL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
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

Update the CNXK cryptodev RSA asymmetric capability to use
rsa_capa and report supported padding schemes.

Advertise RTE_CRYPTO_RSA_PADDING_NONE and
RTE_CRYPTO_RSA_PADDING_PKCS1_5 via pad_types to match RSA
padding support in the PMD.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
index 736d588bde..577f080ba7 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
@@ -60,11 +60,15 @@ static const struct rte_cryptodev_capabilities caps_mul[] = {
 					(1 << RTE_CRYPTO_ASYM_OP_VERIFY) |
 					(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
 					(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
-				{.modlen = {
+				.rsa_capa = {
+				.modlen = {
 					.min = 17,
 					.max = 1024,
 					.increment = 1
-				}, }
+				},
+				.pad_types = ((1 << RTE_CRYPTO_RSA_PADDING_NONE) |
+					(1 << RTE_CRYPTO_RSA_PADDING_PKCS1_5)),
+				},
 			}
 		}, }
 	},
-- 
2.54.0

