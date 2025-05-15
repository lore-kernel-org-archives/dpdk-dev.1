Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F9AC3ABC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 08:05:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE91F40B97;
	Thu, 15 May 2025 10:05:38 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5F252402C2;
 Thu, 15 May 2025 10:05:37 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EMAhTV026429;
 Thu, 15 May 2025 01:05:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=n+jlUsUgpq1bCgsSxeArim7
 RmAz7tyv09YpaGM6kMK4=; b=fW8pnO6MJt27ivpkzmRtoS2IkIopnlpbIDQANES
 cvatjQkrCvouv0aI1lQra6mJ6nMQevdBsnXLmkNjA6vAsfrmejRCxGJE9CycZznw
 jpAjOdbDpUJwdqiq+75/mUff9qskQgKRWgVk091JhyDH9WNEi33Uuf9tQlnyB+sW
 5hgZzEdzC7lGDmi4uG3VMpxGic0GFibUVFYiB3ZHFFofQwoF1bdKdCx6AwpJcdJI
 6ztXw2588EqBL9QSME8zYnEhV2dG4xdSuxMRsnjRlwd7jDlJRTNHDR8tCpllsaPF
 YXbJZxoBULD3WfvDy7bHiBznPdOMcS4bFbSTNVKEurY4X9A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46n3r00ycb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 01:05:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 May 2025 01:05:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 May 2025 01:05:35 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 5998F3F707D;
 Thu, 15 May 2025 01:05:32 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>,
 "Gowrishankar Muthukrishnan" <gmuthukrishn@marvell.com>
CC: Akhil Goyal <gakhil@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] crypto/cnxk: fix out-of-bounds access
Date: Thu, 15 May 2025 13:35:25 +0530
Message-ID: <20250515080528.1644-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OXPjtLKwrtGhl4i0DnlCjjoPImauwRet
X-Authority-Analysis: v=2.4 cv=WdEMa1hX c=1 sm=1 tr=0 ts=6825a050 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=YQQ7OYSl46z1sz9MqEYA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: OXPjtLKwrtGhl4i0DnlCjjoPImauwRet
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA3OCBTYWx0ZWRfX7oYl8tf5W0Dk
 gaOz4S0en/jxZHxO0/CIVwCkcMZSTCD2kN+y9xieeJVztYkTZXfC951Jme4N7sCGn9NPb04tWcJ
 xoYSzY5g/iKTRjAeUwF6gBXMi6spfxC0MFcnoe0OlEAmfEfhc5IUp2bw950Xeqo0OlgSh1Kn5Aw
 mOaQSppK/DSDvoNYUvm1nl5K+iAIEo7MCa41YTnUZjy7NZ5WutxrJp3BOOb09L5UHeF0/tYRjZc
 IzQtnZ5Y5pgGRSbdFKGTCfB0PkqXERzSpKJyEf7zjM/3s/HvG5KqJYA4EpJnl7r2L+jFbz7GOkD
 It+5wUu5UVKlGDLC/qm/TOaruLza6NpnBe7B0BAebMb01IsBIHzKEm8Od3eXTdlBSBtNw7dMxnE
 GliLWdOQw8kldn8s/IAgPlHVujWvCik9TsQLm/jTrX/qYb+zO6MKmFxcohWea/1I/r5Bc6Eq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_03,2025-05-14_03,2025-03-28_01
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

Fix coverity issue on out-of-bounds access.

Coverity-issue: 403166, 403171, 403172
Fixes: 5686b573e4b ("crypto/cnxk: support SM2")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/cnxk/cnxk_ae.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/cnxk/cnxk_ae.h b/drivers/crypto/cnxk/cnxk_ae.h
index cd66f66e70..75d6a536ae 100644
--- a/drivers/crypto/cnxk/cnxk_ae.h
+++ b/drivers/crypto/cnxk/cnxk_ae.h
@@ -1090,6 +1090,9 @@ cnxk_ae_sm2_sign_prep(struct rte_crypto_sm2_op_param *sm2,
 	if (order_len > ROC_AE_EC_DATA_MAX)
 		order_len = ROC_AE_EC_DATA_MAX;
 
+	if (pkey_len > ROC_AE_EC_DATA_MAX)
+		pkey_len = ROC_AE_EC_DATA_MAX;
+
 	/* Truncate input length to curve prime length */
 	if (message_len > prime_len)
 		message_len = prime_len;
@@ -1181,6 +1184,12 @@ cnxk_ae_sm2_verify_prep(struct rte_crypto_sm2_op_param *sm2,
 	if (order_len > ROC_AE_EC_DATA_MAX)
 		order_len = ROC_AE_EC_DATA_MAX;
 
+	if (qx_len > ROC_AE_EC_DATA_MAX)
+		qx_len = ROC_AE_EC_DATA_MAX;
+
+	if (qy_len > ROC_AE_EC_DATA_MAX)
+		qy_len = ROC_AE_EC_DATA_MAX;
+
 	/* Truncate input length to curve prime length */
 	if (message_len > prime_len)
 		message_len = prime_len;
-- 
2.25.1

