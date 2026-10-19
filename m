Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93292CCF2DB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A500A406BA;
	Mon, 19 Oct 2026 15:08:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D02BE40B94
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:34 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8O1iG288003 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
 H9pcF6HiL1DHzIIdJa1Rr2lpAo0UiXqDUzO1sWn3qU=; b=Qcq6Cy1n6PwZbiuAE
 WCuv2CDb7sxqd32zFZzEf7AX5YlRLs1Dt51BGq+iNguwag+oFvHNwSgDFvET9tzG
 mLq1C11pLoWYGskUDDIjX9/+L04n20G3QPCkpZmeC53UJ38n3HBH5ef68gCtorqH
 IOkArWJ+XMfR6MIjpT7CBgHecW8WseBqOJD3srvaZC+p+9p47H6InJZHxO89U+NS
 bUM3DR6p9T+P0ZqMNAAjsTbhFeIxPZg+ZcN6XZjjVZHX5JQUaYy6lt44OoEjE2jJ
 MxFeJ+VUkxYRs8RcaoDmchgqlXtVSPNX2zKqKvj7D8Tr3O7ng9uafkzlX5E9ojXh
 J0J4w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hcss7b54f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:33 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id E34433F704D;
 Mon, 19 Oct 2026 06:08:30 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 11/16] crypto/cnxk: guard trim len in TLS 1.2 MAC trim for
 CN20K
Date: Mon, 19 Oct 2026 18:37:52 +0530
Message-ID: <20261019130759.2181566-12-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RdAFmFtv c=1 sm=1 tr=0 ts=6ad61652 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=969-Y1Z6nkCOsZpFTBgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX2+vJHwxA0rPu
 e9YSkV3pY/E+7Rui4mW0uwOPZKhxeNfi72BRy+MaiUqjZNq0uWZhih55aKQ6rUlpyN17kqRX1XE
 3sfMJ2sk0U8qZ0AS7+AYk47LQVqlHXA=
X-Proofpoint-ORIG-GUID: sRbsI37wDSicB1V7m_HytvfCeR0C2kwA
X-Proofpoint-GUID: sRbsI37wDSicB1V7m_HytvfCeR0C2kwA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX9Wqdz2nzADRF
 qGnlMoJu6mWilGPoFD4ya2mexvuUk7WuIcU2doJbPVrZGIHhf+eM7z58JOXmS6f7JqPwlyZENjL
 dkE3zeEC0heBkHayYIZtmnqDRtbPMTHB36ox7LPyWu94Zw+PyI8a8vXBqa1TwYmWMrFpfpefQ+0
 P5prGvGVLov3HmZkfq1bssE+3jgUFXSpTIdENQe3XSjsR94I+jYZDSaXG4+mUYZAfB8Gb3GhtyW
 SwlT+qDjeY30/GVTAaGBe2aPpxyy4jzobf+ODlhgMPXAP7nntfaBBxH/PwJiiD4Ubk/6UpRl6S2
 GWUD++AuzvwpovmodSB5VY83dw7fqWQ8TrepoSukD/VfFa4EUm49PA9l4XNsAPD5W/nqFeyHz3N
 lS5U3RBLopKG7FMDNI+u25paN64+AS80OWnaYVPX1GOjbeiM69aKe9pVy+h2K13Rt9IY64CjaRm
 a9j9cw5Lc2QQjRfjYQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
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

From: Rupesh Chiluka <rchiluka@marvell.com>

In cn20k_cpt_tls12_trim_mac() the padding length is derived from the
decrypted record. trim_len was used to compute mac_offset/pad_offset
without checking it against the record length, causing out-of-bounds
reads and corrupted mbuf lengths in both direct and SG modes.

Reject records where trim_len exceeds the record length.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 7707755775..f91e56f3ed 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -704,6 +704,13 @@ cn20k_cpt_tls12_trim_mac(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res,
 	pad_val = ((res->spi >> 16) & 0xff);
 	pad_len = pad_val + 1;
 	trim_len = pad_len + mac_len;
+
+	if (trim_len > m_len) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		cop->aux_flags = res->uc_compcode;
+		return;
+	}
+
 	mac_offset = m_len - trim_len;
 	pad_offset = mac_offset + mac_len;
 
-- 
2.43.0

