Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CB8C54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:56:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A61EB410EA;
	Fri, 23 May 2025 15:53:25 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id EE672410EA
 for <dev@dpdk.org>; Fri, 23 May 2025 15:53:23 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NDiaxq008882
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 7sJG73rjq++P6jmeIFkx6p8EmfztlRqsmpca59CjDI=; b=H6CGS4m4bjrYz1dhK
 XWmpNJ9beayQL6z5nWSavkpPPnBAe+CiUmOZLTCvJdObV7TSYJtv9VF0nPifcafm
 /5GLRZpe4G05MPs0f5dEUyjG6NKlEQv9YxH33Ph14Av4S+uaP7yDZmHjeuUtfpyi
 YrxWDgW/b0BzHYplkQ92MNpQ6dWai20ZjC1+3rb3DIlbXc1S8tjL1Mv1JJTtR/MK
 t0vDwMAMJHWMm9reV6kJ4SMRziKnlgHnP5Cz2Tnge+q/3XBLYjip0HSG6dQRnCJV
 ljLkm9fj41hy+uk/0hHoRhixjFXDtGi/4j0UbTYtl0zqnGzSjn4xP8ZleXrmgFCC
 d9iMg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tt5w00hs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:53:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:53:21 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 2CEF03F7041;
 Fri, 23 May 2025 06:53:18 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 39/40] common/cnxk: update qsize in CPT iq enable
Date: Fri, 23 May 2025 19:21:10 +0530
Message-ID: <20250523135111.2178408-40-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bYBrUPPB c=1 sm=1 tr=0 ts=68307dd3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=gGeKaNl8JbtvcH-T73IA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Y9OPOyPcvfBqO_xLlnz7XEi0tINfzsV0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX7nudRai8ahhX
 LgoNkQ8Alw+9hHe7w7l3eb0StbdFnK3IpVYF2dNm6Yim8DhmY/GQgQH94BklLOtrqM9G57KtwZj
 PShAV2N7037ZZJgbSHdfzvHUPZZNwiXNV3OO8cTmSnRoBsrt8hs0rjWCQwTioT+QAQTt3xeKDIy
 DCZnWkRe53U7Re/hPfyFkfl9oyHuFKDh3Bi6JCrnHpOdFKt1htCTd9vN41vSlJMitdxsWJT8+AB
 pgiNCa9JFhiZ9Sn5gUJNMnkBbd0BGfc5Yru8VuOgMIQp8yKQeQQb3+2CVQCB5DYRmwz3esUvXE8
 EC2qlqsWm3Ce0K192oN7aOWBjc1mrdFIcQdjvEzQC6yI8xaO/ZqvoPQTklOlV4R9Qi4W4DLjAFw
 pcKIslRzWOw4ERf0rCPGYYgll1gjRikDzhde76TSB2ff8X8TUuVpJtfpSNkB4jeZZ6LBbUbl
X-Proofpoint-GUID: Y9OPOyPcvfBqO_xLlnz7XEi0tINfzsV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

