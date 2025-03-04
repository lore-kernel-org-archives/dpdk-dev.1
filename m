Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C449CC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 17:42:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBDF1402E2;
	Tue,  4 Mar 2025 18:42:43 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0D748402E0
 for <dev@dpdk.org>; Tue,  4 Mar 2025 18:42:41 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524ClDbe001485;
 Tue, 4 Mar 2025 09:42:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Hw3gPR6sF8j2qypWZhNiqvs
 7R0JY33I6i2H5evLllX8=; b=VAsRowxg2S5qm8RqvVolsM/qMSrZSsnOQsrPILO
 KOqoxZjGOh/vmNiINAGVYFDaxlJQ1qbJY6VMr7xlH+OY95anM4mkVT4QHEc+J5MW
 A8qrNlMIbaq6EEDhzp3IlAmniu/IdWsAuHUUhdF/fYCLmISdu0kiwMBKBMlG17Ww
 5jHtJCItyw6WDPxQeJgkFfCKcH5kOXzkMCys4AN50DWMhEST5aA6hjcoLrfDuqyQ
 SNDSC38oGtF8v3S0akVGHma/2YxznlBu2MiovswAL7Y51HOyUON+tsqTs/IdPwkx
 zsUOy6JvKOR/cna/4GbBaYE/OS9KGwr7QXb9aE3VriKoLAA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4561u2rngx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 09:42:40 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 4 Mar 2025 09:42:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 4 Mar 2025 09:42:39 -0800
Received: from 5810.marvell.com (unknown [10.29.45.105])
 by maili.marvell.com (Postfix) with ESMTP id 5817A3F7055;
 Tue,  4 Mar 2025 09:42:37 -0800 (PST)
From: Kommula Shiva Shankar <kshankar@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, <chenbox@nvidia.com>
CC: <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <ndabilpuram@marvell.com>, <schalla@marvell.com>
Subject: [PATCH] doc: update virtio prog guide with new feature list
Date: Tue, 4 Mar 2025 23:12:36 +0530
Message-ID: <20250304174236.280764-1-kshankar@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=G+TmE8k5 c=1 sm=1 tr=0 ts=67c73b90 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=8U-mNfdfLzYNiqMP6FQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: z2DJwYLHKNQl1aNy361L4TjfFoamuP4s
X-Proofpoint-ORIG-GUID: z2DJwYLHKNQl1aNy361L4TjfFoamuP4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
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

This patch adds newly added virtio hash report feature
to prog guide.

Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
---
 doc/guides/nics/virtio.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/guides/nics/virtio.rst b/doc/guides/nics/virtio.rst
index c22ce56a02..0615abfaaf 100644
--- a/doc/guides/nics/virtio.rst
+++ b/doc/guides/nics/virtio.rst
@@ -56,6 +56,7 @@ In this release, the virtio PMD provides the basic functionality of packet recep
     command line. Note that, mac/vlan filter is best effort: unwanted packets could still arrive.
 
 *   "RTE_PKTMBUF_HEADROOM" should be defined
+    no less than "sizeof(struct virtio_net_hdr_hash_report)", which is 20 bytes when using hash report or
     no less than "sizeof(struct virtio_net_hdr_mrg_rxbuf)", which is 12 bytes when mergeable or
     "VIRTIO_F_VERSION_1" is set.
     no less than "sizeof(struct virtio_net_hdr)", which is 10 bytes, when using non-mergeable.
@@ -68,6 +69,8 @@ In this release, the virtio PMD provides the basic functionality of packet recep
 
 *   Virtio supports software vlan stripping and inserting.
 
+*   Virtio supports hash report feature in packed queue mode.
+
 *   Virtio supports using port IO to get PCI resource when UIO module is not available.
 
 *   Virtio supports RSS Rx mode with 40B configurable hash key length, 128
-- 
2.43.0

