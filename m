Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1881C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 16:59:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEC524066C;
	Mon, 26 May 2025 18:58:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E194A4028F
 for <dev@dpdk.org>; Mon, 26 May 2025 18:58:54 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QGvnJe007849
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 NT2PMZaoGjHXal4xNlt+JkO/H2fS+M8nOvxS5d6cIw=; b=ckklvFqIxIFtQKy2w
 /1f1CtHhOjtl2zuOEbyCqg+TJfresW+tPmPH89A3Z7WpFGRrtKIhEOEZ9PiiFt8X
 hGGMbNIgisss9zIs1MPXan8xiWZWb2pDuhTfQUDBE7yTI+xo80icuJ+H+kKLQmrs
 LuizHJoCj12UrfAS0NVeJpnt1uKBsGewEEtRX5+5nQKigIEq+jqGqmN60P7fCrcz
 N0jMyZKTjkrOsr5eExukuertpxJfMWkdWtva9/uQwW1Gym0DKmBmlTEnc3D4GRqr
 u3bClLXFnVM1uZ62d5YTTkyttyN/CdD3avk3P1nX6v11Cjmkdp9dm+b57rErGmJu
 KzCeQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46vnv1gsnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:58:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:58:52 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 42A563F7048;
 Mon, 26 May 2025 09:58:49 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 09/40] crypto/cnxk: add dev info get
Date: Mon, 26 May 2025 22:27:48 +0530
Message-ID: <20250526165819.2197892-10-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QSYNjCuZurmlTs1yjCOI3_obBqcb7JEp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0MyBTYWx0ZWRfX5SG6LVFWwbew
 fhRLKfcYwfMtC7aH1UA2ErD/YKo1OHqeH1BvjQE9L6RkfZKux92JvyjiuSHVPdlv+HxJtfzmWtH
 xnVv/wIhP7JdRqv4Z0LuO6evmZostVNnyNFip7OVJ3V4EuC43W1pWT1Z9rMy359K8BMYKV0tVa2
 Ow93ARWEXQla7gzccbn005Jm2CoWoXP9DOHu3RyP3azaIjqZHO6O4QVxA5EdELXSi9TDyapDQd+
 WxrElipHDifVlYdFc2uyegaYr85JF46AbWzADNLvj0nK2iuTmPqX2y3tkttcgm5RlsH/KQvqnYW
 TVb/x7VnfjtdWjRR5kMyIfe/l3GB8qK6+4HlSoZP1vevPFP0nNmCPb69XfslaHY8bqgCc7Otv46
 FIpPdH1z4lJ/TaB0laQV8nxdwnBNQe0udof5uWtaxO1kgK1pc4GDnPJMDlwv6SerUJ0hO2XN
X-Proofpoint-ORIG-GUID: QSYNjCuZurmlTs1yjCOI3_obBqcb7JEp
X-Authority-Analysis: v=2.4 cv=PPgP+eqC c=1 sm=1 tr=0 ts=68349dce cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=Pe1cafgnUAMM2Of7aycA:9
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add dev info get for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 64ab285235..ac321a2b91 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -33,8 +33,10 @@ cn20k_cpt_crypto_adapter_ev_mdata_set(struct rte_cryptodev *dev __rte_unused, vo
 static void
 cn20k_cpt_dev_info_get(struct rte_cryptodev *dev, struct rte_cryptodev_info *info)
 {
-	(void)dev;
-	(void)info;
+	if (info != NULL) {
+		cnxk_cpt_dev_info_get(dev, info);
+		info->driver_id = cn20k_cryptodev_driver_id;
+	}
 }
 
 static int
-- 
2.25.1

