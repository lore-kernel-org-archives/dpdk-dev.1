Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A9CCD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 03:38:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E541D40A71;
	Wed,  6 May 2026 05:38:14 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6F01640685
 for <dev@dpdk.org>; Wed,  6 May 2026 05:38:13 +0200 (CEST)
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645L4arC363318 for <dev@dpdk.org>; Tue, 5 May 2026 23:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=Y
 i5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=; b=ZqLXIF3Dc2OPKOlDJ
 A2CuFWdRGMU1ZvfrGsCPH51OgmNNypjLg9RbLPYKOQ2c8XzJyOoFDghq+rMogQmY
 M/ttkFoCmeHUKwCNN4yVyCvojatEee0dtI97pAx82hjwwIAzAIHtMbF/p0lna3+V
 QEQOzEBwKF/elRJrLAYv+YB/7Cr/6Lao9tD7lBwY4aZWO0dPZnostxV5s4cbd082
 DN4MXlgaof/RGnDRys2YWLdSbAAnVFFYPHuFvCfgOpQlLw9PMzxUy2yXXJnbMeur
 vemy6V7OAnY2W/kHnKylBl/yhKjtJXahiATkRZiaumX9p8TYO842IJlo3YjABXbd
 /Sb6w==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dwabppjae-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 May 2026 23:38:12 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6463VARQ2189555 for <dev@dpdk.org>; Tue, 5 May 2026 23:38:11 -0400
Received: from esapsmtpat10.us.dell.com (esapsmtpat10.us.dell.com
 [143.166.211.153])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dywtb02ry-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 05 May 2026 23:38:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778038691; x=1809574691;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yi5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=;
 b=kC/oL69ALp9XSrs+SIVSN7f8d2WoQDzaXK67KW2hT2Qh8HLj4KYYtADj
 9eoQjGm9HN6ibPJiQ1wfQbAGiWab2augCh1NZ3jDbwAc3iqYixFTQcWKA
 P6b9DUPRtBVLjsWUmhDfqkHIit4NyfM0kynGUgqJICeU8+a+moKn/cpFE
 CMQRVsgr5puEkThJDhxBZqz7j/xrh9KUC1jiT4eM491zIDzFeB4tEoxVX
 A6Q6eoj1laoH58CRhg3hqGJgcq/jAoqaSAJ25mfrLGxRXN5LOFmFd1mPL
 dZ3Z68VRHWEoV8rN30JAqd78pPdq+FC7xYN7ag/oZ5yyd69puuUHjFNC1 g==;
X-CSE-ConnectionGUID: 6STy2uEcRqeGVQHXkZpdqw==
X-CSE-MsgGUID: K7U1dpSwT9u/qlmjQpUjRQ==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat10.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 03:38:10 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 22:39:06 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 22:38:09 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 5 May 2026 22:38:08 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, <fengchengwen@huawei.com>
Subject: [PATCH v12 5/5] vhost_user: enable configure memory slots
Date: Wed, 6 May 2026 03:37:33 +0000
Message-ID: <20260506033733.972952-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506033733.972952-1-pravin.bathija@dell.com>
References: <20260506033733.972952-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060032
X-Proofpoint-GUID: 4VcPFshyzwC7WmzSjwmWkLt9rUpH1gVP
X-Authority-Analysis: v=2.4 cv=W5wIkxWk c=1 sm=1 tr=0 ts=69fab7a4 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=zctdXvwhg3EK6xEvKeLW8g==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=U3ti1ie9CgboSd2qXsAw:22 a=iLNU1ar6AAAA:8
 a=-L3Ti0Wm1PsFXVv1eAcA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: 4VcPFshyzwC7WmzSjwmWkLt9rUpH1gVP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDAzMiBTYWx0ZWRfX0abJT03X06Bd
 ikO9Dwh2/NXu698xkGj3ieaxPnbmQ8kqK+QEsy+obxo/y5AZfSfMVb2dLPtnz4l5eBuAjSC96zC
 mtNqiBgyWxriA7PMTGqyAiexgoHdGSAtRV05zxaPPD8frAL9fqBS6A56feynpo1wgzY4LKEKhFq
 38/vujTcKJw27PLXv0E6UfCSK4onaCG1uNE7vvJZEQ/E3LQAoMj8nB5b/qhWwBBXDvioquJHoO8
 FHLnS+qTY6edkbbPuXRWGdwlGrnFVy7Pq3MxU/VWBkKl0YOOGsHEeIyemGhDbps9ONrZMIgBPl9
 EEyzEvnS/abzdC35GNAX7Q4SEl8b7+dWLszXNDL1qBKrKRsYYsZERvdTpaWf/OishJUvRLP6/lr
 vFNFY7A51A2jqxK8dsbs+w1PXUBuwVKFZ0KgjpYopdxtTSX/JGAbFoaxda+L2BGg3Tj79ZTUa9L
 KwwomdRVIGIsxoCUvSQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060032
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
index f8d921f7f1..5a0e747b58 100644
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

