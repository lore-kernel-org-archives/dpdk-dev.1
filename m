Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2C0CD4F25
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 22:47:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB4C74066F;
	Fri, 15 May 2026 00:46:55 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id B713840151
 for <dev@dpdk.org>; Fri, 15 May 2026 00:46:53 +0200 (CEST)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EJ1n4S3596369 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=R
 Hf3Qe8PMPymFQlQCfrM0u1RZk8xe7tD8E5j9JH1BUY=; b=PAReJCDs2EaVWkhQR
 ml525vcsAC3Gp+dqq3QX+RKBBn8ZfP4dPZ9TgZ1G8iWXXVWzIPDVZhaTa67S6sij
 qJFC9xvXo9z577p/bPkQhYEH/YMdlPQ5Kw8eUrpnW7yvcEBmic0obktILSrDCzhD
 fUbNpVHil3hsVT1HfPghElpjaOcKefY5yPHW/F0U/zeshRCwmTkQ4pKUIc5xObDh
 ywfPgT9zR65NPWJ2DtLNCXi9n2vwx7sC+Q5+MyT7EWNL75AD8eAvBzIwD3zUS3kx
 K9S8DuhNVMcf8mAayWSZyy0oZ/z0PghbCMSHix4MlFGy/nEhyks23RvmWwCt6iPB
 KCqTg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e5m6c8qdv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:48 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EMhl3Z1523172 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:47 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4e5m6paa5d-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778798807; x=1810334807;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RHf3Qe8PMPymFQlQCfrM0u1RZk8xe7tD8E5j9JH1BUY=;
 b=BHPAZbl3lsxUukIb0dqwtBtP7PuMxGYtg+auwbeg9dnLhZ1imuoYVIA7
 PG62cwOAMTfDdqha0wHxau+PMtKbzTvYvTb7+nOqys0b+24FKcn2XJjiI
 QrukSW1+cW8aClJ/S+8pak/N96Kf5hIvHf9uk6VJnUk3pmJBw39wT3SK5
 E1/ljoaBItaHF9QSBCB2Q62iMQDbHdtVrxhUAeElEz9/rR3oEActSiqbj
 f0kvkKTIrwExNHRpl132gGBbcqtocn1fJTIs7K1xyzq7cFjeKpGmBu5cX
 uLx9nntD0BUgGCp3FFuSuwfSZEo1o3VMxWOOdyRIpRNpfOsoCJiPLcQqx w==;
X-CSE-ConnectionGUID: myYRhvLsQgmEMcgW4SHQNQ==
X-CSE-MsgGUID: SNP+wGHPTxukIGcNj8/Xug==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 22:46:47 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 17:48:02 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 17:46:46 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 14 May 2026 17:46:46 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v13 5/5] vhost_user: enable configure memory slots
Date: Thu, 14 May 2026 22:46:27 +0000
Message-ID: <20260514224627.2014566-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514224627.2014566-1-pravin.bathija@dell.com>
References: <20260514224627.2014566-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140223
X-Authority-Analysis: v=2.4 cv=QLpYgALL c=1 sm=1 tr=0 ts=6a0650d8 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=m3zZTHMLHbwB7Lmtoed2:22 a=iLNU1ar6AAAA:8
 a=-L3Ti0Wm1PsFXVv1eAcA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: zPhqdJoo_u4861kAiIs48h0S799IVaKZ
X-Proofpoint-ORIG-GUID: zPhqdJoo_u4861kAiIs48h0S799IVaKZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIyMyBTYWx0ZWRfX1zdyP0fqJsHZ
 xWw/EAJ5FgNdFDoszTVovnkBe9T+6PMVqk1XvZI1bz1yxa6Z7yzwAUMDj6PVsEUZffQ2yY/Dym/
 tqnIdr/qA76z/jv07qRtCqKGt5PJ7jdvh+xLMavHGpyWSWV3xVc7bCdf7InlicG/n/rOjs8rw+U
 z1zEJj+XgcxHkZvXd+y2wWruDEUT/d0+VNL5OIz+Rclcsll28Gi59nRwQ3BDABjtWKURT93daRC
 D6pBzC9G6VrfspglhSvjXUUaKa2dPqJQ+En6/4vHefuj0JA6gHgMha470LodO006zdHWT9sZnAO
 ATnbsTqJZdLsm8UDGHl/QkQ1rKLbh+ZS+Vo+bGGRSF0Nt8A7gwbYptb/6SjchbycQ2Thvili71M
 VhsP92xd9dOoeKNEYZFlpqqxOUltCrtMqk7SVcTANz6SnP+J3cC7czC3NuHKsoE9IGIc2jYyIRG
 fQJ+V8JpZktgskyKzrQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140223
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

From: Pravin M Bathija <pravin.bathija@dell.com>

This patch enables configure memory slots in the header define
VHOST_USER_PROTOCOL_FEATURES.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index 6435816534..732aa4dc02 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -32,6 +32,7 @@
 					 (1ULL << VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT) | \
+					 (1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_STATUS))
 
 typedef enum VhostUserRequest {
-- 
2.43.0

