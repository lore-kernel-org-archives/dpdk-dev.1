Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67448C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 08:10:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE96040B97;
	Thu, 15 May 2025 10:10:13 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A9414402C2
 for <dev@dpdk.org>; Thu, 15 May 2025 10:10:11 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ENSPvh002067;
 Thu, 15 May 2025 01:10:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=42+q/M28FyWWorI1Y/YYkJx
 1i6ballHWVLmtrZt85o8=; b=DUvmbO10sRV5XA4FX7FAHBvYInGnmfFmfYBya0X
 Sa9KwiMth3tV4CG11NqFjrqljVv/qgv6lGRd2o8QHQRFHnzcCPzOujzPXG2ZDA5h
 voCSTqQg6tQMjGo3k5QeXJ/1SFFvBv0ZAYGZb0B6xG9XPrA+wXi8TlDBTwt68PYv
 HXlCD2RulllALIr/KSnVeGqLn6K7EcB4m52qswA5CdHMYi9aNSwzShNAhsanpUVX
 MLzGQFZndv7jJXpkeUwOWkUqVhnUW3s7U5kWQoKRuVaKpT3AyswCfj/YlxWdadyI
 Ovgr/4srlJS+vL9Hh8vAo2IzmaqVrCRYeR6NpwTAt7ZWNsw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46n4vngupg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 01:10:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 May 2025 01:10:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 May 2025 01:10:09 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 788573F707E;
 Thu, 15 May 2025 01:10:07 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
CC: <anoobj@marvell.com>
Subject: [PATCH] vhost/crypto: fix uninitialized variable
Date: Thu, 15 May 2025 13:40:01 +0530
Message-ID: <20250515081004.1742-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VWQAXVw23SLh0AV_e-fqT9zePJ6kBTRs
X-Proofpoint-GUID: VWQAXVw23SLh0AV_e-fqT9zePJ6kBTRs
X-Authority-Analysis: v=2.4 cv=aIDwqa9m c=1 sm=1 tr=0 ts=6825a162 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ja0yLUIz5reumCfwB20A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA3OSBTYWx0ZWRfX4uAW05XeJxGO
 dgoZvkiNJ+KtDzstkjwPK661LvScrHoKufPigJsPZnaGoSmNb5K8reh56+CU+aSO+1hH7XdLVSE
 djCcKgcuqe0sdr8AsHDKmNoMGccQ5HJScRLI37K9lDxz1kQseLMijbuVRpw5XbVx+1HbD9jvD4e
 qPiw3cVeWVn93Gfg/FMVN7J3EW/GPN/xUQjk1Wg8rGjeFLf1C/kkdy+01UTwGNUw5QcFFjzCfBo
 0sWbh35aN0gzlFGt4QmwsHHDP9Embivz6Lifp+Um/XDhGlx1nqSW/XHWbdUrWMRzgSLdiBrpXGv
 fCKBDsMfxpOio0kxElrCOqBKCP2NYC8FbS/kYTapl9h4gITY7+eRX1qS3qJI3ycTMJ70606VKxu
 VXXmYVxjAxsMU3bkgt0J2tO3ANiqEpQZI7pRC6TIacyWrIFaTUUlzZ9LN80AUN6+o4rLBLz0
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

Fix uninitialized variable as reported in coverity scan.

Coverity-issue: 457449
Fixes: d1b484bf187 ("vhost/crypto: support asymmetric RSA")

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 lib/vhost/vhost_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index f78daf98d1..66ba5342e2 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -1493,10 +1493,10 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 	struct vhost_crypto_data_req *vc_req, *vc_req_out;
 	struct rte_cryptodev_asym_session *asym_session;
 	struct rte_cryptodev_sym_session *sym_session;
+	struct vhost_crypto_data_req data_req = {0};
 	struct vhost_crypto_session *vhost_session;
 	struct vhost_crypto_desc *desc = descs;
 	uint32_t nb_descs = 0, max_n_descs, i;
-	struct vhost_crypto_data_req data_req;
 	struct virtio_crypto_op_data_req req;
 	struct virtio_crypto_inhdr *inhdr;
 	struct vring_desc *src_desc;
-- 
2.25.1

