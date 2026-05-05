Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B704ECD13DA
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 05:53:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2BB74067D;
	Tue,  5 May 2026 07:53:16 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 5D0434067C
 for <dev@dpdk.org>; Tue,  5 May 2026 07:53:14 +0200 (CEST)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6451KKU14081070 for <dev@dpdk.org>; Tue, 5 May 2026 01:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=Y
 i5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=; b=Th6U8uys+El1RxGrc
 E5G53wS5YwfgMyKdqJ+xCqVKXNMn2N0uEPgYgzfGzp1exqbd6Km0PManUxy+/Odw
 Pu1Vq7XpcsC1KJh/zXHu6XkWZ5oxPtxW85MTYIcsrXUgXa/hzHdVKr7Ei8oai6gp
 t3BYt6DSfqtv7AOn3e7i6tBw5S7hBVVBQZhtrA7rx2/vhtErVKOI+UO/sjzmQLhb
 hmJyjhjyj1C8e9piPcaIdsuDNVaQaZkTKNJqnY3U/gxhqvmT6fpOt9jZd/ybANRz
 dMt6gcIcSMpBxAuPvE0NceXr8Gzq1PRnEB5gwbDdXgjRdZ3mFrtLJSDaDfuUQLdg
 Bdrtw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4dwcax9jhx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 May 2026 01:53:13 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6455ev5O2342767 for <dev@dpdk.org>; Tue, 5 May 2026 01:53:13 -0400
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dxv9nkfcu-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 05 May 2026 01:53:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1777960393; x=1809496393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yi5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=;
 b=D96hVCLy/Z97icWe5EoRb9wwlrxDY0gS1nmMP7qawmQSd9rkne2VfjSJ
 6UTLL8mW1a7uFAVNnx5fCwRCLFTpSzDDEdIEoqFgG7dV5bUdjhGq1cKNe
 W0EbyeWgpw4W9tHSj/AovD/W86uwXrgkBQIqQpbkcP5LHZiMvQ5F+7f+V
 cAPgYozyrA7Us7e6sPT2TgcccgnUctXrFyn/kRmcH+4fbEm1uujCic60F
 B6WUv8X8+ICaFkAqGm/M6SWWcpcIsgrlsNvtJmo69Qn2I6LqHhbmdHZob
 UUDdNFZykcQmCVF5cCW5y4KpvEocBLBdyzydkXKwPmL+iqjv2jFnCzRdW w==;
X-CSE-ConnectionGUID: 8CRZ0zVETG6qdzfffIPnxA==
X-CSE-MsgGUID: rJVg2KxNRXGryqHYDmFeNw==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 05:53:12 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 00:54:08 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 00:53:11 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 5 May 2026 00:53:11 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v11 5/5] vhost_user: enable configure memory slots
Date: Tue, 5 May 2026 05:52:51 +0000
Message-ID: <20260505055251.818594-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505055251.818594-1-pravin.bathija@dell.com>
References: <20260505055251.818594-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050052
X-Proofpoint-ORIG-GUID: dWGpu4NMFbXK-bhQTvbPd-pb9Bh4AJxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA1MiBTYWx0ZWRfXyPZbUn2tc8IU
 pFgDr/QujX1Fx10MvVKxXFhpcQUeuP+k9dRT9/VFi8oUHAjzJNNOOxLGEMtgmy1mtegza+CzXJD
 pcKfpSX6/ErGtqjwswmaMQjSh7CpnzVvJkbwiRS6X70Q9RMPyKVOH5BWXM63TmqIOX/+oyQVLA0
 Xm3HPAFZFUfY8N1Lix6m9emW0a8pgtYO9UpQr/m6L6kUeLhu+vpa6MT8456uB3AySv403c6aYp/
 MythqFdUQzxHxDMMi/4xwyJ8q4Bim8ROAsrgCefYyONTfsFGAdMhlJngoL9IRqufgsYm8zsdUi3
 U1LIc9LwbTlsHeItWAYtboMDIwhFEMkGbR6SSr5TnzJ7ZleLVPMFCTakYrgSAaXEYTSNZ+5nuhC
 GObj40YSIJrZOvRjcsVNP/Q845mjp+PGmBiaCsvKb4OjpLyvNfEXbHgCR6ayYndzuw9t35caUKw
 hxntk6M/gcJl4BamNqg==
X-Authority-Analysis: v=2.4 cv=W/UIkxWk c=1 sm=1 tr=0 ts=69f985c9 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=sEWawkeXllE7TocFc0N_:22 a=iLNU1ar6AAAA:8
 a=-L3Ti0Wm1PsFXVv1eAcA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-GUID: dWGpu4NMFbXK-bhQTvbPd-pb9Bh4AJxK
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050052
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

