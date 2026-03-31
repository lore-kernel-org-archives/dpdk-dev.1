Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA96FF60D0
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 08:55:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 873F54042F;
	Tue, 31 Mar 2026 10:55:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BE56C4026A
 for <dev@dpdk.org>; Tue, 31 Mar 2026 10:55:35 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UGNrlj3054078 for <dev@dpdk.org>; Tue, 31 Mar 2026 01:55:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=8As6Ebp8fKyzNq64a0RZkh4
 pYAI3c4FSF5nEXjEX4g4=; b=ba6LMFisyuh7s4BmKq3CuFP586YDx9OQQO7/fDE
 ExkIRSEj1WsgqiVEKEPVbJS2gPILXalrUXIX8czlxez7vr8qUgXpa8BfsK37BGng
 Gkd3Hdr7ZXejo8kpdlYJyNbFk3VwL2Whj8TnYssWC3+ExWHxuK4EIxh9Hjp1d3IA
 uRM3ezGo0nGn/gKMUR8iU3OyWtmGzoR+CbY/MsIYIKi6K72L0ZdLk1NDwHAYaB6R
 vTmhLb5mRTzHJ9Qt9Urwf/3fd1CORy5xlM9Q+nDA+wm7YRmxD3wqeC9mgP4TGxsl
 DH1e8YTDz1GK9E8oQ+mw/9qfLwFxTLkHBqolUuWCbDSMk+Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d6yr74mag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 31 Mar 2026 01:55:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 31 Mar 2026 01:55:33 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 31 Mar 2026 01:55:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 31 Mar 2026 01:55:32 -0700
Received: from sj4r760o4u9.sclab.marvell.com (unknown [10.110.150.37])
 by maili.marvell.com (Postfix) with ESMTP id DFDE83F7054;
 Tue, 31 Mar 2026 01:55:31 -0700 (PDT)
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 1/1] ml/cnxk: support for 64-bit int type in metadata
Date: Tue, 31 Mar 2026 14:25:29 +0530
Message-ID: <20260331085529.1105898-1-syalavarthi@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wOe41apy8ozigX7CV_IE394FkVopHwYm
X-Proofpoint-ORIG-GUID: wOe41apy8ozigX7CV_IE394FkVopHwYm
X-Authority-Analysis: v=2.4 cv=a949NESF c=1 sm=1 tr=0 ts=69cb8c06 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=b_xYxUl4L9BejnmXttsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4NCBTYWx0ZWRfX1iThklgXF1mA
 kImpb3csuKRmKyklB6MLjFKAn+R4tCK0V/2a1ifzDLAgEKTPsi2WkX59GBM86Et/L5Btdf0ENHx
 F/ZMKXLmcWKR0rhY9prmZgwmi66TK3tgjAhNmqf2h5MuhtvcQHMfvA/ncrcfb6yDUxqENq30hO3
 YeXpGjh/snruUdcSOZDuI+7+PtEF5HEn/MJVhAMD9CAef/lC/3MNvaJuLarAvs6flayNmLCBsd7
 47/B5R+3oiGxfncU2HQgC3DjJG/nQm/HSD6wn44YUnIMEs8PvMHmt2vL3YJKxefDxU+rI+eDVhg
 ZIFUQKGyjtb3smP9eKbMvX5cMO7vCPMfly5EFVTnBJShkXKrYHkwD8ncLwrPSvn+etNVxjWKRRA
 ETABKwbftIm2oedd4wEEREEDivKGOq+zaiBn3NFbcuAXQXQoAJ8Fm2+7j359QiZz7lzdWE8nCAM
 EibzBa+UImDHAF6+u3A==
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

Added support for 64-bit integer data type in model metadata.

Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
---
 drivers/ml/cnxk/cn10k_ml_model.c | 4 ++++
 drivers/ml/cnxk/cn10k_ml_model.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/ml/cnxk/cn10k_ml_model.c b/drivers/ml/cnxk/cn10k_ml_model.c
index 12a2dda800e..3eb64825d24 100644
--- a/drivers/ml/cnxk/cn10k_ml_model.c
+++ b/drivers/ml/cnxk/cn10k_ml_model.c
@@ -33,6 +33,10 @@ cn10k_ml_io_type_map(uint8_t type)
 		return RTE_ML_IO_TYPE_FP16;
 	case 8:
 		return RTE_ML_IO_TYPE_FP32;
+	case 9:
+		return RTE_ML_IO_TYPE_INT64;
+	case 10:
+		return RTE_ML_IO_TYPE_UINT64;
 	}
 
 	return RTE_ML_IO_TYPE_UNKNOWN;
diff --git a/drivers/ml/cnxk/cn10k_ml_model.h b/drivers/ml/cnxk/cn10k_ml_model.h
index 6744175cd5e..746eed7c702 100644
--- a/drivers/ml/cnxk/cn10k_ml_model.h
+++ b/drivers/ml/cnxk/cn10k_ml_model.h
@@ -224,12 +224,14 @@ struct cn10k_ml_model_metadata_input_section {
 	/* Type of incoming input
 	 * 1 = INT8, 2 = UINT8, 3 = INT16, 4 = UINT16,
 	 * 5 = INT32, 6 = UINT32, 7 = FP16, 8 = FP32
+	 * 9 = INT64, 10 = UINT64
 	 */
 	uint8_t input_type;
 
 	/* Type of input required by model
 	 * 1 = INT8, 2 = UINT8, 3 = INT16, 4 = UINT16,
 	 * 5 = INT32, 6 = UINT32, 7 = FP16, 8 = FP32
+	 * 9 = INT64, 10 = UINT64
 	 */
 	uint8_t model_input_type;
 
@@ -282,12 +284,14 @@ struct cn10k_ml_model_metadata_output_section {
 	/* Type of outgoing output
 	 * 1 = INT8, 2 = UINT8, 3 = INT16, 4 = UINT16
 	 * 5 = INT32, 6 = UINT32, 7 = FP16, 8 = FP32
+	 * 9 = INT64, 10 = UINT64
 	 */
 	uint8_t output_type;
 
 	/* Type of output produced by model
 	 * 1 = INT8, 2 = UINT8, 3 = INT16, 4 = UINT16
 	 * 5 = INT32, 6 = UINT32, 7 = FP16, 8 = FP32
+	 * 9 = INT64, 10 = UINT64
 	 */
 	uint8_t model_output_type;
 
-- 
2.34.1

