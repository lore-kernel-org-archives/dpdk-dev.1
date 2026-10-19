Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B62FCCF2DB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A49840A84;
	Mon, 19 Oct 2026 15:08:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 517A840A8B
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:29 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OZK2110793 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=M
 5/UtglJntIBH+R0Y8YvUC6ceiydBLAgCwTAYQOVdyY=; b=HMIxT8nne4EJ+tXGG
 JZGVNEndenA0WcokQpJ6i8vtLTarXM8Sw20D6cjez6m/91eFdyOVLzO3R7kYIjL5
 gKwlRBIRFYzxoOkc4HcJjAjYl/GSUFhIO42VGw9pzkm3+RI6hJHiOJ4sZqi8hWRy
 42a3u3B6K9lHOhw4LGECEQoHP8GbHFCAzxKDqLZg4whe/1h1GuWL8BNr1UPMakI9
 yt1Pi/38Vz/GiNIT5D15tidLuLheovq0HFgv4i9uxvqahbgN7/aGGpza5GPGTsNx
 nFFrC7uwKaIbYRAmVRJ+9DYbZhOkQmwKrTOw4/CXwFnZPr4bZXCenzcNXuuiAOVi
 s4lVw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hc8hh4yq9-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:27 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 558263F704D;
 Mon, 19 Oct 2026 06:08:25 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 09/16] crypto/cnxk: guard trim len bounds in TLS 1.2 MAC trim
Date: Mon, 19 Oct 2026 18:37:50 +0530
Message-ID: <20261019130759.2181566-10-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pNgUtx2sEVHfhkE9IYrhKSsDO6zCcmO2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX3ROv1gQ5f7nP
 OL3/ZTgx2n+UAa3Z7PqRbnoHWdKwu0Poz6bw3JBR+BNU7h9wRlZlB9ZyNHwES6322Kvclh/d695
 3HTqjlLjKYwmKgF7VL3f3fBPAISvjJSvmUdMNlLOVwOEbuDNLYUIVLTpKfFw5DPgf9ePQD/shUh
 pQdkcdtip0majz81tb9+Zvnu4uw6wSxqT4OinqWg+jQ0ByA1lT0Wxi6wC5bWNkNMAjOFXfXBiMl
 IZJPXqb8aVCxSXGCcUDDd6Zb82IB2U1QFApiGXl5u7v/y3D1UdXUdUeR3BGtHH3rDV1ow9CjKMq
 hQkMA8Aa8fOMywlBu7HTY850w7PouOAvRAzQw909JJbX3E4eBZkWC4EczaU0VM7nChl/RcJnE1z
 6g1SAik0HaEaTpFWsEAcFNSIfA2fQIdp/1Nc430ySta/9TQ6dg6St4rNMF7zOVTBPhiuxgFYrDe
 wgSmmT5OUY2gjF7A5Pw==
X-Proofpoint-GUID: pNgUtx2sEVHfhkE9IYrhKSsDO6zCcmO2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX26qOuZXHNc9e
 AsXk3zrLXD2VSlRwRwiqFUTxtesBgICWn3PBEbLrIwyWKakdXeYO+K0tCslyq11+myARaDlf4BU
 k1tnNFVuovnM3f7p+jd3lyIMiYvp9/A=
X-Authority-Analysis: v=2.4 cv=LfupeTfi c=1 sm=1 tr=0 ts=6ad6164c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=969-Y1Z6nkCOsZpFTBgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

In cn10k_cpt_tls12_trim_mac() the padding length is derived from the
decrypted record. trim_len was used to compute mac_offset/pad_offset
without checking it against the record length, causing out-of-bounds
reads and corrupted mbuf lengths in both direct and SG modes.

Reject records where trim_len exceeds the record length.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index bf273774fd..30ef0d14c2 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -942,6 +942,13 @@ cn10k_cpt_tls12_trim_mac(struct rte_crypto_op *cop, struct cpt_cn10k_res_s *res,
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

