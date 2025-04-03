Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A341EC36014
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 12:22:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A55140B8F;
	Thu,  3 Apr 2025 14:22:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4C8E14060C
 for <dev@dpdk.org>; Thu,  3 Apr 2025 14:22:54 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533AI0Lh020914;
 Thu, 3 Apr 2025 05:22:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=AR2ANH7BlxR+/8bgMm77CUq
 GAosi7MUeMbvKXuRXeQc=; b=AsYes0mwY50+vft5sWHnrIDGdRcB7c68lf0APBi
 vdP85gHNaRQQK3lE2X/xKBYZu9ddH+bGSc+F5SqzfKAkYMlQCApgCRkiCdqUdPux
 dwZ5RCmbKaHyEhdv+ZqSSRQT4xsmTthEfzEKNRykbcwmYupHtroZYMOQE0/IFVJE
 /JB185PbsU2A5dfJ35jqjRpHNnaqvAkgyKUfYmtmf5lD6jsL0yfwuGbSC+FamcOG
 y5aUrKpraE4umB0N2lSXp7BoyToroIAW+9r+ZIOu92156bXCJPkdA0EmDKkYdrhS
 23cAFJYoAUkuX4+f4x9ywSiP1dCH2Xszme4mryAk0Te3tkw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45srf0g835-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 05:22:52 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 05:22:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Apr 2025 05:22:47 -0700
Received: from Dell640-transport-1.sclab.marvell.com (unknown [10.106.48.36])
 by maili.marvell.com (Postfix) with ESMTP id B940C3F70DE;
 Thu,  3 Apr 2025 05:22:46 -0700 (PDT)
From: Rajesh Mudimadugula <rmudimadugul@marvell.com>
To: <dev@dpdk.org>
CC: <maxime.coquelin@redhat.com>, <chenbox@nvidia.com>, Rajesh Mudimadugula
 <rmudimadugul@marvell.com>
Subject: [PATCH 1/2] vhost: fix cipher data length
Date: Thu, 3 Apr 2025 12:22:34 +0000
Message-ID: <20250403122234.3508100-1-rmudimadugul@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eIFM5de-lCe0NsIhob608t2th3MBd0BK
X-Proofpoint-GUID: eIFM5de-lCe0NsIhob608t2th3MBd0BK
X-Authority-Analysis: v=2.4 cv=QYRmvtbv c=1 sm=1 tr=0 ts=67ee7d9c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=YpsJ9D7ZE14GsfVIoVwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_05,2025-04-02_03,2024-11-22_01
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

This patch fixes cipher data length, in the event of algorithm
chaining. When enqueuing crypto op to vhost backend
cipher.data.length is set correctly which is in
virtqueue_crypto_sym_pkt_header_arrange(). This field is computed
and assigned wrongly instead of using passed value. This is
rectified and using correct cipher data length in vhost crypto.

Fixes: 3bb595ecd682 ("vhost/crypto: add request handler")

Signed-off-by: Rajesh Mudimadugula <rmudimadugul@marvell.com>
---
 lib/vhost/vhost_crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 3c6c5dc114..ddcd93738b 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -1358,8 +1358,7 @@ prepare_sym_chain_op(struct vhost_crypto *vcrypto, struct rte_crypto_op *op,
 	op->sess_type = RTE_CRYPTO_OP_WITH_SESSION;
 
 	op->sym->cipher.data.offset = chain->para.cipher_start_src_offset;
-	op->sym->cipher.data.length = chain->para.src_data_len -
-			chain->para.cipher_start_src_offset;
+	op->sym->cipher.data.length = chain->para.len_to_cipher;
 
 	op->sym->auth.data.offset = chain->para.hash_start_src_offset;
 	op->sym->auth.data.length = chain->para.len_to_hash;
-- 
2.34.1

