Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC25CC982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 06:20:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 931DB400D5;
	Thu, 17 Sep 2026 08:20:25 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 987EB4003C;
 Thu, 17 Sep 2026 08:20:23 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60BPX2202649; Wed, 16 Sep 2026 23:20:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=82a3TpSysy2ntEHeMpUyfOj
 GCtAtry+5r+a9f21LQyM=; b=W7MAu+GtXCV7Gzg6NKEqEjS/jgVy+mRFX5FeXza
 gc8SgCmSUuc50OiiwqgnRpOzmVxDuopeYN+ohI8lnPXA2ofCGkXMI9lWwfLdAl48
 76CRMaZsaDNXUnwmeTM+lTBJF6Bog8Bjtv2X0BRGgKueMYlKI+4xz0Q0Mzuyr+hx
 f+CqYAeGeIupAuPdoU5nNSSMFdOod9XUvFM+aNDNoKwVXKcNm7U67EKRJPKK1OsJ
 ZXXXPbfHPHFL7f05K9PalfUegSmN54z/odhrspHtkfJq+bW9BTwpJqud3Y5G8TVP
 f2Ns+qC2ZG45EpwCS0GuHAw25PoTMQECNFy04cDGd/Sz4Tw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gra5yg7qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:20:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 16 Sep 2026 23:20:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 16 Sep 2026 23:20:21 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.40.118])
 by maili.marvell.com (Postfix) with ESMTP id A23115C68EC;
 Wed, 16 Sep 2026 23:20:18 -0700 (PDT)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: <jerinj@marvell.com>, <ndabilpuram@marvell.com>, <rbhansali@marvell.com>, 
 Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] test: fix 5-fragment IP reassembly test vectors
Date: Thu, 17 Sep 2026 11:49:02 +0530
Message-ID: <20260917061902.1299400-1-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA4MiBTYWx0ZWRfXy6l4R1NuajUo
 VNoRQ7utjc8mf2tgF1tNoX6Spa1uaAB9kZguqMxpfJBcvubVF/rKdaxxKhA7jc/AgWQif3qwx1u
 rHitRAPPxQitSs02VGml/25FbEFdbSs=
X-Proofpoint-GUID: dhF4IYElUsYePd7UFGDffEYXPchGtLxQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA4MiBTYWx0ZWRfXwMVtXnwiDbWq
 sgr32Yd/XPCOxw7uM+fr+SGMrMToxUmTVIAPAHEn/8DKOSNQzF5dhHercZXNtkgG1tFbgdYodnO
 WFRblo3whikjUpSqTYVCCr9eXUGfP/z4Aezv57amC5EnKjQVBRu15gDXW5VOkf+J8aNMeMyO4RK
 /WrV5t9RlTUfN6PHJww7hgF9/IYMqmbVPsd7lLQGjhAMldjt6JoqI6lg43HrQ+q5y4eHppQ6PdS
 0UAESFL3p/30DCTTxVThYH/wI7Iv+Bl/zvG//oG/hm5fTzUnlQWT+vTBNCWgMZG8uVeEO/yB9YC
 IyNs+0rlZjNL39ik3otYSbMeoTQGIpihLAoK8dQXUh56T9zXEWcISW6z9zz31Q5PabPj8ThnuJ6
 BhADkxZQ85Dgb5FzZjntFDJzk2XclJHgbFNlk1B7QvlsElH6em08Wc59S+JmwsWXODUWCDJ8eJM
 vox7+FfWIpQmChrU9qQ==
X-Proofpoint-ORIG-GUID: dhF4IYElUsYePd7UFGDffEYXPchGtLxQ
X-Authority-Analysis: v=2.4 cv=TekDJhQh c=1 sm=1 tr=0 ts=6aab86a6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=OB7HyrwAcz41z8OQzDcA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
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

Fix UDP source port bytes (0x80 -> 0x08) in IPv4
and IPv6 first fragments, and fix IPv6 full packet
next_header field (0x2c -> 0x11) to indicate UDP
instead of Fragment header.

Fixes: a310577766d6 ("test/security: add inline IPsec reassembly cases")

Cc: stable@dpdk.org
Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 app/test/test_security_inline_proto_vectors.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test/test_security_inline_proto_vectors.h b/app/test/test_security_inline_proto_vectors.h
index 86dfa54777..b2566654e9 100644
--- a/app/test/test_security_inline_proto_vectors.h
+++ b/app/test/test_security_inline_proto_vectors.h
@@ -217,7 +217,7 @@ struct ip_reassembly_test_packet pkt_ipv6_udp_p3 = {
 	.l4_offset = 40,
 	.data = {
 		/* IP */
-		0x60, 0x00, 0x00, 0x00, 0x16, 0x6e, 0x2c, 0x40,
+		0x60, 0x00, 0x00, 0x00, 0x16, 0x6e, 0x11, 0x40,
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 		0x00, 0x00, 0xff, 0xff, 0x0d, 0x00, 0x00, 0x02,
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -241,7 +241,7 @@ struct ip_reassembly_test_packet pkt_ipv6_udp_p3_f1 = {
 		0x11, 0x00, 0x00, 0x01, 0x65, 0xcf, 0x5a, 0xae,
 
 		/* UDP */
-		0x80, 0x00, 0x27, 0x10, 0x16, 0x6e, 0x2f, 0x99,
+		0x08, 0x00, 0x27, 0x10, 0x16, 0x6e, 0x2f, 0x99,
 	},
 };
 
@@ -439,7 +439,7 @@ struct ip_reassembly_test_packet pkt_ipv4_udp_p3_f1 = {
 		0x02, 0x00, 0x00, 0x02,
 
 		/* UDP */
-		0x80, 0x00, 0x27, 0x10, 0x16, 0x82, 0xbb, 0xfd,
+		0x08, 0x00, 0x27, 0x10, 0x16, 0x82, 0xbb, 0xfd,
 	},
 };
 
-- 
2.43.0

