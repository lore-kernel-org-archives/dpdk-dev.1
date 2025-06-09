Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259F9C61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:41:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D765740E44;
	Mon,  9 Jun 2025 12:41:00 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A090B40E34
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:40:59 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5597oNLG022070
 for <dev@dpdk.org>; Mon, 9 Jun 2025 03:40:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 xA3O4piuic0ZMYpa89MKQbSrJp6hNPhousdNsCn9J8=; b=Umc4VcTaxA1mJRLux
 iF8tqZU6g0Y2uMskLi5jG/ipao3yMe/4OI2R5uWs1ntc3u08rdDIL+WrtssKUHBK
 GO/WJzM1G+/ZPy12zfrSlZ4GdmznDhm3b3J6iQn5VJN0VgA6JIBAFi59pGZqV1Kf
 M00Cr+DfdkDnOtq4NqzGaMb4KQ/DGNPXKEU9apbQgbUI5qL/eaJ8YNi7dfJ+JsQu
 ABGKqkCpIYMgxCe+pBKCFObt0A9ykXJmtW24kFw/550wqm1yE/8UxI7OVMTlzU9L
 ZtP9IDRaZM2U0EtX3Y05HS3D9NR+Xn8CzK18YyCBrSu3t1H3nUnW9TQTRZ/ocshO
 5x4hg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 475ujxr99e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 09 Jun 2025 03:40:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 03:40:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 03:40:54 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id B2AE53F7093;
 Mon,  9 Jun 2025 03:40:51 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya
 Sagar Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 4/7] crypto/cnxk: add meta variable in CPT structure
Date: Mon, 9 Jun 2025 16:10:35 +0530
Message-ID: <20250609104038.3102767-5-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609104038.3102767-1-ktejasree@marvell.com>
References: <20250609104038.3102767-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uA9fh7Nr26lG-C6Px_722cGnwi-_HfBO
X-Proofpoint-ORIG-GUID: uA9fh7Nr26lG-C6Px_722cGnwi-_HfBO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MSBTYWx0ZWRfX4ytxrYV0/iCD
 7zcdXTrh2j05gt58Kg0DT344aDOmhY0ddb2CQuLnmIasi1CEYDHRR35yt3HEWpvcBa404+eaId3
 AGq1S04Y5XiigfhoWoWtBu+cm1exLwwuL0WeTabJLkK+TwmvO9HldjwfIbKOX6hukapu6qB2GOo
 HgAbPd0r9BXV0bT/UgnR3/qy0HgTRbefR6h8mEW7NCr6Y3jpOGkFlubXaqYjnLV/w0YZfZ9rHvW
 /GceD2eyB3nZBhIZMTi7GXbtRINIogBVli+DMMGoBJUjBxt/bGXo1+5y9io1sGuxgLddAhn/Rtv
 OQ9sfqg4e0dK9xQiPN1JvkwNg+hBRCn7Hqid6RcCVmGV/QJKCBZBgBRyb/dUN/xuDUv6U6TssyD
 Hk5Jtuie7sVx547RDaqJawclumw3DrtESVCZXuUQI165Gc8OeqAnPTmHTIEym5HvVFc8VFHP
X-Authority-Analysis: v=2.4 cv=LuKSymdc c=1 sm=1 tr=0 ts=6846ba3a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=kDeZ-iwJ3rUndtvFCIMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
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

Adding meta variable in CPT high level structure to
pass custom metadata to CN20K firmware.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index df8d08b7c5..17d39aa34f 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -30,6 +30,8 @@
 /* Default command timeout in seconds */
 #define DEFAULT_COMMAND_TIMEOUT 4
 
+#define META_LEN 64
+
 #define MOD_INC(i, l) ((i) == (l - 1) ? (i) = 0 : (i)++)
 
 #define CN10K_CPT_PKTS_PER_LOOP 64
@@ -58,6 +60,7 @@ struct __rte_aligned(ROC_ALIGN) cpt_inflight_req {
 		struct rte_event_vector *vec;
 	};
 	void *mdata;
+	uint8_t meta[META_LEN];
 	uint8_t op_flags;
 #ifdef CPT_INST_DEBUG_ENABLE
 	uint8_t scatter_sz;
@@ -70,6 +73,7 @@ struct __rte_aligned(ROC_ALIGN) cpt_inflight_req {
 };
 
 PLT_STATIC_ASSERT(sizeof(struct cpt_inflight_req) == ROC_CACHE_LINE_SZ);
+PLT_STATIC_ASSERT(offsetof(struct cpt_inflight_req, meta) == 32);
 
 struct pending_queue {
 	/** Array of pending requests */
-- 
2.25.1

