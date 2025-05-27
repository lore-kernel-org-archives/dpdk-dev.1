Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0624C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:02:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0ACC40A8A;
	Tue, 27 May 2025 15:02:10 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 73B09406B7
 for <dev@dpdk.org>; Tue, 27 May 2025 15:02:06 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNTsgQ001051
 for <dev@dpdk.org>; Tue, 27 May 2025 06:02:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 7sJG73rjq++P6jmeIFkx6p8EmfztlRqsmpca59CjDI=; b=Gvrxmsq2esGYzmQaj
 P9UdKPX/ldO179XX+06HetDupz0GRglKaDm9yIhmVvTP8Y0IRRdSUAXaJc1b4lJe
 Qi1oS79wJpe+A575Y40cbUu03MR13B5Tmci3xZ2shVUmHBrHNkQm5KAYqeLt24vC
 o8Q5vAClZObxjSpsckkNcLt0VKHTshkR2P36i0ZDYRM21RjmAYifcLOP4+cuRruQ
 6MK0cpq04x90shMqxgQZc5NCHyvRl6oKmJC6GTv5wB5H8RiVke9PstbxuHJfi+KS
 AYfWU8+21tLXf8urEFn7ps37uMmKzt6vcsThOdAChSZ8su1E/MAENzyvLgphM/3g
 IQcYQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21299pu-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 06:02:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 06:02:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 06:02:01 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 2792A3F705D;
 Tue, 27 May 2025 06:01:58 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya Sagar
 Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 8/9] common/cnxk: update qsize in CPT iq enable
Date: Tue, 27 May 2025 18:31:34 +0530
Message-ID: <20250527130135.2301726-9-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527130135.2301726-1-ktejasree@marvell.com>
References: <20250527130135.2301726-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=6835b7cd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=gGeKaNl8JbtvcH-T73IA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: CTC12Yibr5E0yPuaEe518-hl73f-us25
X-Proofpoint-ORIG-GUID: CTC12Yibr5E0yPuaEe518-hl73f-us25
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNiBTYWx0ZWRfX4l3Dc1QFAu7y
 j42zbpdvRwE6OCTUUgVbiD9QuxPkA22urM98XRM29VQmBOM4U0rbeEW+ogTxOoqUR5lTK/uKJJz
 7dBGPYMt9CRMIfQxbYRsBxxbAUJoag2ZC5MquPak/OxwTtyUJLHCji1KsLYQc+EBiREGWIrjqnE
 1M2/iMr+muwIxFWL7vNWUXHt/LyEZ4uA1tnGxokqjKodEKFBqT4VvCgJbDagyjr4CaksCm50B5S
 Og5HhSwNLxIQFNRHpQYWFgM4Qo7oY6vpNif6Jn8zXLyeRuE2Bd98S7jXfNmmPncwFSHYAfpoXqZ
 KyjUgDk2zKT8AFquV5CaHnSogedDwb+rdJ37uVGPx33Wbjg8uahjTWDYYzMCq2fckU26LvU9Fqs
 mNwwAIODRGQq8FJ+/Bw3NkG6GgxZkFOa4XiXkG9XdGFN2vX5leY/ZRXxwHYels0rOXkxB2Fn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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

