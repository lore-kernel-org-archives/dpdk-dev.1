Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03998FF60EF
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 08:54:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 100E14042F;
	Tue, 31 Mar 2026 10:54:54 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 704184026A
 for <dev@dpdk.org>; Tue, 31 Mar 2026 10:54:52 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UGMxpi321445 for <dev@dpdk.org>; Tue, 31 Mar 2026 01:54:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Rz1uSoYdGzcvg5W3N6IpYYY
 F0QKXjAkycbgQoq+9htc=; b=EzO2FagZtSy+JuSQNgJHhb3oZVN7aTIRXYAs4WN
 V/X5c+LAUBTPjTTlqiRUNCrIjcDaDnKkuuMDmqzV1+qIAzeXblt1Rgas2fjU3nqK
 8UsvDZGhuAVTrNwPRyLbXedj/hpArrKOFjnF/swm2ddkLow2K4Q3zdNpUMLCXERB
 M4IElm8poCij7RuXdDPD7funT0baVzmCvZWFy54E/j1Tur4BywAqKpUVnOv2bW3Y
 hyoWz3g3FlJp3h3Z5k5RLlHPRWyskRLrKU5u/fjpBjV8+5zEl3KSS5AHw4Fb7Nk7
 MphrgaEopOrGUp+f58KSwzvFXcAG9p4jeOBTWJB4q3dbEng==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d7u2ha6fp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 31 Mar 2026 01:54:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 31 Mar 2026 01:54:50 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 31 Mar 2026 01:54:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 31 Mar 2026 01:54:49 -0700
Received: from sj4r760o4u9.sclab.marvell.com (unknown [10.110.150.37])
 by maili.marvell.com (Postfix) with ESMTP id 6082C3F7054;
 Tue, 31 Mar 2026 01:54:49 -0700 (PDT)
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 1/1] ml/cnxk: avoid overwriting layer name during load
Date: Tue, 31 Mar 2026 14:24:45 +0530
Message-ID: <20260331085445.1105590-1-syalavarthi@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UCxfkMJUAhdwOePE79nVQjs7mofLOBhv
X-Proofpoint-ORIG-GUID: UCxfkMJUAhdwOePE79nVQjs7mofLOBhv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4NCBTYWx0ZWRfX/Agurlq/kdqK
 Wsg8LB+mJ3sV6JaPXRAN5TDdTJAwCyCfCMajqq9x6iZAHuWOJe0kmAnB1Ci/UFw0fntVdIaCvi6
 OYYGdh7tHlN2PKkImdYILkjctEYuLey32c7itJlzJ9YpSBXJUZwY4HkrkV/g3uRUASqq09PAfmA
 XZiDoA2J1S9Xx4FejgN6UZcN05JDyJicNY4xJnlx1ETse+mFZ/pn6Q0WNVH3Lf9nDxlOVBLqSGI
 zxi2PPyB4gtPMCcv5kSInuDZYxvDw9iobwf64EUWxoNnJz2df3vIQHx88i6J7UZ1e8JmjG+VBZP
 1Dh1H+x5CRsVf3gVtv9f98MM358vh91XwLDtyJrpbXCJBx5OKoLf6YTwhmOssdrHJ7xw2ZLIKoY
 Nq0jabpt5OJRAYxMIa+e+Jt+Nkkrj8Tr/Mmwk7wYQPvEyn8tyBfyB/1msdrjJL/Ex3LpBboOkEB
 AujbkJy+fqKPUX0khPg==
X-Authority-Analysis: v=2.4 cv=IeaKmGqa c=1 sm=1 tr=0 ts=69cb8bdb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=ZGR6sFl-nuH36UkXP0AA:9
 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
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

Layer name is initialized during metadata fetch and
parsing stage. Avoid overwriting the layer name during
layer load.

Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
---
 drivers/ml/cnxk/cn10k_ml_ops.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ml/cnxk/cn10k_ml_ops.c b/drivers/ml/cnxk/cn10k_ml_ops.c
index 628ff963c3c..77947120f25 100644
--- a/drivers/ml/cnxk/cn10k_ml_ops.c
+++ b/drivers/ml/cnxk/cn10k_ml_ops.c
@@ -671,9 +671,6 @@ cn10k_ml_layer_load(void *device, uint16_t model_id, const char *layer_name, uin
 	rte_memcpy(&layer->glow.metadata, buffer, sizeof(struct cn10k_ml_model_metadata));
 	cn10k_ml_model_metadata_update(&layer->glow.metadata);
 
-	/* Set layer name */
-	rte_memcpy(layer->name, layer->glow.metadata.model.name, MRVL_ML_MODEL_NAME_LEN);
-
 	/* Enable support for batch_size of 256 */
 	if (layer->glow.metadata.model.batch_size == 0)
 		layer->batch_size = 256;
-- 
2.34.1

