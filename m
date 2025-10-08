Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEABCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 09:05:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 062F74065C;
	Wed,  8 Oct 2025 11:05:24 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id C7AFD40649
 for <dev@dpdk.org>; Wed,  8 Oct 2025 11:05:22 +0200 (CEST)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5981sjYA007935
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=I
 duWOw7esRRJ1YbhVl3tb8y34pO0zW/VUwkPoVJNJgo=; b=HjoJOlr77PKoZJmle
 vtOfCzUUJie6fbETBdE3oCW9CqiwTuof1lZr1faumFyHpW0eTBEQNXIVLRV9O64O
 L/YTKOgbRMlXlTZm+ST7UI7XklyR4EmUezgxyjSqegq3SdjHzTHmkmCIJLpVdeUq
 nm+7MF2r1EFPKxwpFF4p2Ys1pDh8oPNxif5CfM8XoLFupKrzXe+0s26vVjGglYiF
 qlPf0M4b/7XOgUtUICqez0LZDbbUBdIdlLrnDSiKK/F9Cfc2MJFz3rUkD8exbIw5
 zMIEMSD9TlLbTCupVWhjcRIJCiiIqhRBgd6us+PnKvuRIrvrox3c8h0U0CNXaVP6
 EClPA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 49k08n8qr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:22 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5988KoEr032498
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:21 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 49ndqfvkew-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1759914322; x=1791450322;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IduWOw7esRRJ1YbhVl3tb8y34pO0zW/VUwkPoVJNJgo=;
 b=J2o6pC2KgpIWgy0WAAFBbPVCTRHS1t16ygJvlDndY+QcNI7u1rE1UvMp
 /xEi7euP5i2ZN9VM35bBnKPHIpHVWClT8oX1GRwMV7/Lg/VYaageyRMkY
 TksvMglN5gbIo/Fj+l5tiRYzhfeexEYcp90JZsP9oxkU4x0Kb3qiopO3P
 wqYQHxyGTRJD2ILcNRTe0uWlgrl8IbcTDN6jR5XogZ6JOP6moX2B0QOSk
 GasZLTkp61v1segGWIsFbtDLAuImLbZlH5Vs5I/3DQbR2z+DFE253/3J5
 U5An+WakEgNu9NdGvQMLs/FuKfberIGET/OAczduu/8jv3cEPE5mlWzt0 Q==;
X-CSE-ConnectionGUID: FMb1RaH3ROelIJmHrDbabg==
X-CSE-MsgGUID: Pz86JXXSRNiavj4bXRhtNQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 09:05:21 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:06:21 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:05:20 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.34 via Frontend
 Transport; Wed, 8 Oct 2025 04:05:19 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v2 2/6] virtio: increase number of mem regions to 128
Date: Wed, 8 Oct 2025 09:04:40 +0000
Message-ID: <20251008090444.2689652-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008090444.2689652-1-pravin.bathija@dell.com>
References: <20251008090444.2689652-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510080003
X-Authority-Analysis: v=2.4 cv=IYiKmGqa c=1 sm=1 tr=0 ts=68e62952 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=x6icFKpwvdMA:10 a=ke5jqHz-1hQA:10 a=iLNU1ar6AAAA:8 a=rHWVgcRUz1b9TMvXgjkA:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: UAwX8asWUixfOH7qa_Ji5IVSCDpqcl8H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA3NCBTYWx0ZWRfX1Ntqs7bOFN1e
 Km1Cs8emqcy/Hc2SoYFfe6IlmA7Mh5IvIfsReLMHRxfOfp/CWP8sdEyA8d9KVUzyvuYYy6ZIhBd
 f153yy3vLt4n4CZnlhGcZG+7cirYAmqfpEMNsvzyiJWievilxoGrm4Rbcqxg1RjQqKI+v1KEnGC
 Pqul4jfBKWHDBnMu3WqaJZirVk4AdyRi4hpSUvHSexcYa5dSb1KxKukMpzjY3IyhfrY+YB/EmUd
 6cKjh3XtckDh8PkCY71NKE3ZHXJXWeWK4zsipAE7apC7FiLXzJd5a/Stq7xCzHXifrdO4c4T7Zo
 I7peQ2CeMGDwLpU2oWQkg2akQEjinCCv0ADDkwSeROez3IqxmMxRWzpwCKQC2UbT1pHdGfoIm1u
 aSlM0HyVeVKQW+8hwLcdjNM2yG3p3A==
X-Proofpoint-ORIG-GUID: UAwX8asWUixfOH7qa_Ji5IVSCDpqcl8H
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040074
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

* increase number of memory regions from 8 to 128.

Signed-off-By: Pravin M Bathija <pravin.bathija@dell.com>
---
 drivers/net/virtio/virtio_user/vhost_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio/virtio_user/vhost_user.c b/drivers/net/virtio/virtio_user/vhost_user.c
index 6c042f6186..2647002c5d 100644
--- a/drivers/net/virtio/virtio_user/vhost_user.c
+++ b/drivers/net/virtio/virtio_user/vhost_user.c
@@ -50,7 +50,7 @@ struct vhost_user_data {
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION    0x1
 
-#define VHOST_MEMORY_MAX_NREGIONS 8
+#define VHOST_MEMORY_MAX_NREGIONS 128
 struct vhost_memory {
 	uint32_t nregions;
 	uint32_t padding;
-- 
2.43.0

