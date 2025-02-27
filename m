Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183DAC19F32
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 18:15:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D606B40B95;
	Thu, 27 Feb 2025 19:15:38 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 140C740287
 for <dev@dpdk.org>; Thu, 27 Feb 2025 19:15:37 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAvBdJ006769;
 Thu, 27 Feb 2025 10:15:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 ktnuf5B+IwRhjW0Dre8m3imjKOW5af9UgOgwQwTJk4=; b=QuWWf5T1tutfh/+ag
 iQtRE8PKWbqYe0+7rBZLf3t/2Go7v9R1OrMg7BCc4WO13QLNodo4W5pbivoYLpmG
 txhYXQtYI+djzDzaF+DRWDaZENnqoymI/+fDsDgRR79MKS7IXbQqcNQmcuZrRtwn
 gGORIHHWoO7LUfvKTt0ZxoRqc+wd/T2B+1KRLVDUlhktjgnvSdGsyxkjl8GifJeW
 LKHLdpLtwxWGCtOSF9mQvg4PXvKCb03+gtiuIo678XXLAUsGlMWfG3A7+/qH8I7n
 MJ2PAVHHQy+NMrhX+SWWpo/1SoXba7Q8V1X58mDZ0sLM2t2oaCaatz9EMECFnBv0
 VNSGw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 452prggwnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 10:15:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Feb 2025 10:15:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Feb 2025 10:15:34 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 8F05B3F7071;
 Thu, 27 Feb 2025 10:15:32 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v8 0/5] vhost: add RSA support
Date: Thu, 27 Feb 2025 23:45:21 +0530
Message-ID: <cover.1740679955.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740664527.git.gmuthukrishn@marvell.com>
References: <cover.1740664527.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RPFJH5i+ c=1 sm=1 tr=0 ts=67c0abc8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=T2h4t0Lz3GQA:10 a=SSEcSf4z2q0PDGKyEI4A:9 a=0lgtpPvCYYIA:10
X-Proofpoint-ORIG-GUID: 9Cji904mzav2l5pu-upeAaSElQNeXYrr
X-Proofpoint-GUID: 9Cji904mzav2l5pu-upeAaSElQNeXYrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
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

This patch series supports asymmetric RSA in vhost crypto library.
It also includes changes to improve vhost crypto library:
 * support newer QEMU versions.
 * fix broken vhost_crypto example application.
 * stabilize crypto fastpath operations.

Gowrishankar Muthukrishnan (5):
  vhost: skip crypto op fetch before vring init
  vhost: update vhost_user crypto session parameters
  examples/vhost_crypto: fix user callbacks
  vhost: support asymmetric RSA crypto ops
  examples/vhost_crypto: support asymmetric crypto

 doc/guides/rel_notes/release_25_03.rst    |   3 +
 doc/guides/sample_app_ug/vhost_crypto.rst |   5 +
 examples/vhost_crypto/main.c              |  54 ++-
 lib/vhost/vhost_crypto.c                  | 523 ++++++++++++++++++++--
 lib/vhost/vhost_user.h                    |  33 +-
 lib/vhost/virtio_crypto.h                 |  67 +++
 6 files changed, 623 insertions(+), 62 deletions(-)

-- 
2.25.1

