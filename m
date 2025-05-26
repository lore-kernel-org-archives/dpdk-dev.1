Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFADC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 16:58:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 435094066F;
	Mon, 26 May 2025 18:58:37 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 398FC40668
 for <dev@dpdk.org>; Mon, 26 May 2025 18:58:35 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q9dLIM000432
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
 ID+OeGZtbNNevou5zbNsxCA7KEHchVTlFMK3cj/PTc=; b=eq/eeNrL5Gzci9tLW
 5nvby5/1dbU4QnB5SuH5qwvWshLRCbe6cgWH7XSzARPwykP3cdWRR3K4l2mUluO5
 nw9t+inSfVbJPiCjL9jZBYNnTTh4WLVUGAfRYwM9B96kcxpdc8jYUBiZ0FIR3S28
 4j7sGBpf0KGGTZRrSdqMCcRlp9dGqmcxIz3ATw+Ko/VQ9wch+8AkQJESGQ09A3YV
 Kqoav/aa7PfAC785fm0bC9FRZZwIbRoqesCtjo/sya8Hd6HSoLkxrTI65tGLcIOg
 /IYoZzn+gV03p/O+69AIvcbh1/wmba7onc7YnPh08PEMXuyB2dOVDUX874oNMl3+
 WE2TQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46vnv1gsm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:58:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:58:33 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id DCBA53F7063;
 Mon, 26 May 2025 09:58:30 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 03/40] crypto/cnxk: fix qp stats PMD API
Date: Mon, 26 May 2025 22:27:42 +0530
Message-ID: <20250526165819.2197892-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZJh5geiQv-dp3_aCqqECEYABiJkGKCMe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0MyBTYWx0ZWRfXxFPx5SB6nRjD
 1oF4/JLwXhjrhnCDjqghRSqXwr75HnEmzoBF9aDdAxImuI28nn9Gw4MgD9JpZrwjvxXOjlSWW49
 7mGTwHODc85THn3oNHfhxsZZamcbb74Eb5HeG935sr8M+rloVqoM96vq+TDw/kYg246lyT/j0z9
 aV/dF/sv4pylDucAj9m9F6LmYtvek203KjEOuSz+4VSmHBEU4IMZ9EbTz1ruHE1Nrkr+u3aQ6nP
 dY4SP9/wQar2pflbuF7UOD/+MhzQu2nr5NjDXBsC/4d95J8aLdUDHqGKPFVLFUmuEiWYH/LhCGg
 /ab6/skkyEaoCGXwlbGYDmBakGWQP3GXSHUZtARydiFmHEdtDwtO7x4oKXPVMdU693Vi2xpk8BH
 gOkDdPpasMfkfE196MN4U/iplR5MUT996q6mGuX++WwwqaTEfKCF/I+M9NsqSsgybgVw4l0G
X-Proofpoint-ORIG-GUID: ZJh5geiQv-dp3_aCqqECEYABiJkGKCMe
X-Authority-Analysis: v=2.4 cv=PPgP+eqC c=1 sm=1 tr=0 ts=68349dba cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=awJWYGnfD9vRpg5u9u8A:9
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

Fixing qp stats PMD API.

Fixes: bf52722b9377 ("crypto/cnxk: add PMD API to get queue stats")

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 613ce11ec1..61f3e135aa 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -1218,7 +1218,7 @@ rte_pmd_cnxk_crypto_qp_stats_get(struct rte_pmd_cnxk_crypto_qptr *qptr,
 
 	stats->ctx_enc_pkts = plt_read64(lf->rbase + CPT_LF_CTX_ENC_PKT_CNT);
 	stats->ctx_enc_bytes = plt_read64(lf->rbase + CPT_LF_CTX_ENC_BYTE_CNT);
-	stats->ctx_dec_bytes = plt_read64(lf->rbase + CPT_LF_CTX_DEC_BYTE_CNT);
+	stats->ctx_dec_pkts = plt_read64(lf->rbase + CPT_LF_CTX_DEC_PKT_CNT);
 	stats->ctx_dec_bytes = plt_read64(lf->rbase + CPT_LF_CTX_DEC_BYTE_CNT);
 
 	return 0;
-- 
2.25.1

