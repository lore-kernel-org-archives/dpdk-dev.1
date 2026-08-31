Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4FBC61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:23:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82C4E4060B;
	Mon, 31 Aug 2026 12:23:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0DBED40430
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:23:51 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V86X6J852277; Mon, 31 Aug 2026 03:23:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 shqBOAq0sm60UyN05VQI1SAWdmti6gIxmMO/+Khres=; b=ECqZFhd98UNCCLcFb
 h6uukbWkT0dMRKhHlJFfYM9+2Wsrn+zbMBwFLejIAEbNT3cJKd2+HoDx8AqVrLMQ
 7/3vLi5y4xTIdL79m1pmkesPCdklFInqogmI0IpuFT8JQcCnKBm/vnoFkre8blzY
 FT1MZOOMfEpDrJ+Cr5wKBfGc8eDyfPbtGi4UzJPBFWKkWXRKrBgwegdoChdkCfMZ
 RFf3ejoJY3mKaVQv2ls+eBR4g3ga0Fg60aBodJPpG57s+klBvgfnQwGLAVYa/QoD
 13MUAya8V0M6VaawfPTDavCzUzWGIBdj/B7h/7clJshNg242eEDKNY0mH+5CcFbD
 dcz4g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gbxxj3kuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 03:23:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 03:23:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 03:23:49 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id A85D33F7062;
 Mon, 31 Aug 2026 03:23:46 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH 02/10] crypto/virtio: advertise RSA padding and hash
 capabilities
Date: Mon, 31 Aug 2026 10:23:20 +0000
Message-ID: <20260831102328.2813604-3-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831102328.2813604-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX61FFppeBjXcS
 bmsZGGwixu57SWmNyowpehOATTaeZ7O3puGh2N7dreXej8/1rxBEC9XRDkc/ZTBSwSOzBaJTvMb
 WFYqlD3Rog+fnQFa3bOl6L0cza3PmuU=
X-Proofpoint-GUID: oY5WSJUM7RBNgzlmUkD1dXeAwR4lRVCH
X-Proofpoint-ORIG-GUID: oY5WSJUM7RBNgzlmUkD1dXeAwR4lRVCH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX/HUpv1D8BMXX
 ctxI+yl9yzFXrS8tTu5Ud6NlzBCsiJwRGIZBeTYZpxDRrBF6UsVjDBI4hcZ0qoKBCIm/Cjg2+o6
 1wfNJI92b2oS77Tsu88yprh0fM9IUW5LZS73p33v5z+wvaefZSGSqEdz5xfr8vs0GBRMpWSo61x
 OkJQl9nUorO+wzMkE7EStpzgK1zTrnAbW5lUyQT0ESN1sO8PJrp95Ed7fbFTr2Krnhs8SyFQqBm
 oFaMtRy0q4rR/LgGk3HZ8wGxcRZa46ar1IRCZxYj9tBFLhZ4ntJo4UZYK47Fb6ognYcpIhlHpZ6
 /L2TcgUyImgB39c9KwlhtIUM9gd6U3lDGPi/Jg0yj1UDdcyJRelgoypnZg1U8w5qbQP6CiliDzY
 /fDuO+YTMIZ8BTd9T4uaNh3IUQ9g9RIpwYaoNm5OQxsO9N+NvoH8wD+LgzSloO1lU7OfNG6v6BN
 rojQ/rmxKRFVqoyJDlg==
X-Authority-Analysis: v=2.4 cv=QuJuG1yd c=1 sm=1 tr=0 ts=6a955637 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=-CRU_LKD4LrivVcj2VgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
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

Update the virtio cryptodev RSA asymmetric capability to use
rsa_capa and report supported padding schemes and primary hash
algorithms.

Advertise RTE_CRYPTO_RSA_PADDING_NONE and
RTE_CRYPTO_RSA_PADDING_PKCS1_5 via pad_types, and MD5, SHA-1,
SHA-224, SHA-256, and SHA-512 via hash_algos to match PKCS#1
v1.5 hash support in the PMD.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 .../virtio/virtio_crypto_capabilities.h       | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_capabilities.h b/drivers/crypto/virtio/virtio_crypto_capabilities.h
index 1b26ff6720..7d5eea1f9d 100644
--- a/drivers/crypto/virtio/virtio_crypto_capabilities.h
+++ b/drivers/crypto/virtio/virtio_crypto_capabilities.h
@@ -58,11 +58,20 @@
 					(1 << RTE_CRYPTO_ASYM_OP_VERIFY) |  \
 					(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) | \
 					(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)), \
-			{.modlen = {					\
-				.min = 1,				\
-				.max = 1024,				\
-				.increment = 1				\
-			}, }						\
+			.rsa_capa = {					\
+				.modlen = {					\
+					.min = 1,				\
+					.max = 1024,				\
+					.increment = 1				\
+				},						\
+				.pad_types = ((1 << RTE_CRYPTO_RSA_PADDING_NONE) | \
+					(1 << RTE_CRYPTO_RSA_PADDING_PKCS1_5)), \
+			},						\
+			.hash_algos = (RTE_BIT64(RTE_CRYPTO_AUTH_MD5) |	\
+				RTE_BIT64(RTE_CRYPTO_AUTH_SHA1) |		\
+				RTE_BIT64(RTE_CRYPTO_AUTH_SHA224) |		\
+				RTE_BIT64(RTE_CRYPTO_AUTH_SHA256) |		\
+				RTE_BIT64(RTE_CRYPTO_AUTH_SHA512)),		\
 		}							\
 		 }, }							\
 	}
-- 
2.54.0

