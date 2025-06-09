Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8192AC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:41:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96D5F40E4B;
	Mon,  9 Jun 2025 12:41:04 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 226A940E4C;
 Mon,  9 Jun 2025 12:41:01 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55998dT4029060;
 Mon, 9 Jun 2025 03:41:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
 e0DG3UoSPQBQUohgz/Qb9hVBCWS5tO5ekDfbNAh8LI=; b=RopoecrGmOaF3/RHV
 h8ZI9Md00arURqCAnLnGa755YQ5+FcW6LOyjbtMvHLgjGZe24UaCq/Hc9Uc+b/BW
 3ukQ8r7x8mZ5vfW5jQ5kZNcSwzEv+Sw5sCIfhbkSPPLjwU5HI5XZA8p1HZg7J/+L
 MEis+83ej5ek8Xw64xB7kSbPb/bKce7sWCFF2DPMqhAAZeYeKV5QJ+e2peMmfCdl
 /M9qxtt3b8raUiVkMlyx8PpDWTO8qvpp/nZdL+/SjhcpCSekMZFFZ03fHhHAyFid
 pIoE4XyywIp65bBYiQ/WAmd679zixpNiZJB7XY3tKwoTSLVU8HrCaHSgRtQrslk4
 OEHrA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 475vq804qp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 03:41:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 03:41:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 03:41:00 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 678543F707D;
 Mon,  9 Jun 2025 03:40:57 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya Sagar
 Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2 6/7] common/cnxk: update qsize in CPT iq enable
Date: Mon, 9 Jun 2025 16:10:37 +0530
Message-ID: <20250609104038.3102767-7-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609104038.3102767-1-ktejasree@marvell.com>
References: <20250609104038.3102767-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: B9RBUXjJQjKVFcB15LQ1gmCETYndFza3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MSBTYWx0ZWRfX3fgtG6zQg5Tq
 e0Jlq2ATtPhrnaDQzgUPTLLjeGfa8rCBhsE+y1XCm2OhwKB9gK4GcY5kUvYPlRVXkgmK7XAOVUw
 kd+qxKKesRw+5NkDSyjZI4N1rPEYnz14WBV8ViTuofomrVBRofwqgMCkNvoEBGFAOPnWEOrpF2z
 u0jnFIv4Vye6EVFP3BRLit/cldnEvwrK7N3xyyhWg3JgiJ5lirmsHEpqru0WiSsWBeTSvx7Mrm8
 e3JN+VtWVLBxxLibxQMU+436yodiZaOJsx8qPXcQ3vxwLbk+bTH/BgyfzPv0KC81ir3KyzArXPG
 TkOacN5sl9N2PsLzyAF5VNOTo8yKD+Tv7XWAjvgK+S01HIv4WtoBWKeveH2jH3S1YsA0G9qaK4Y
 9LBBmCd0owo+6ilK7/8v+vmPMK6/EmBQxMDL4vsd/eKUAf7A52sFKasYsVeowfksqXJMZB7G
X-Authority-Analysis: v=2.4 cv=Rp3FLDmK c=1 sm=1 tr=0 ts=6846ba3d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=htK1KuUZ6dj1tKQlpFsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: B9RBUXjJQjKVFcB15LQ1gmCETYndFza3
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

From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>

Reconfigure qsize in each CPT iq enable call.

Fixes: 3bf87839559 ("common/cnxk: move instruction queue enable to ROC")
Cc: stable@dpdk.org

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index b4bf0ccd64..d1ba2b8858 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -1125,9 +1125,14 @@ roc_cpt_iq_disable(struct roc_cpt_lf *lf)
 void
 roc_cpt_iq_enable(struct roc_cpt_lf *lf)
 {
+	union cpt_lf_q_size lf_q_size;
 	union cpt_lf_inprog lf_inprog;
 	union cpt_lf_ctl lf_ctl;
 
+	/* Reconfigure the QSIZE register to ensure NQ_PTR and DQ_PTR are reset */
+	lf_q_size.u = plt_read64(lf->rbase + CPT_LF_Q_SIZE);
+	plt_write64(lf_q_size.u, lf->rbase + CPT_LF_Q_SIZE);
+
 	/* Disable command queue */
 	roc_cpt_iq_disable(lf);
 
-- 
2.25.1

