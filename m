Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F29CD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 03:38:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB2D340A67;
	Wed,  6 May 2026 05:38:02 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id DB78B406FF
 for <dev@dpdk.org>; Wed,  6 May 2026 05:38:00 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6461k7xK3114067 for <dev@dpdk.org>; Tue, 5 May 2026 23:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=l
 x97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=; b=FunNA87Q9Rnf+RvzO
 163xm/HY7AaZOGEfzSr7nTdW1tbOSHr549gX1XG3YDSPw3pbi3VKDg+YQiQQdS4H
 4TmHjfpknD7AtVtXrwoH9+yqpb1v2qTfWCRSK1FykIDM8e7i+eKpSUdnHVbEoFph
 cANKkGz9eEp3RY1Mf2GmG2gM7MwgtWCR40YaLoSondsT/+QFy9s0xXxS8bSDJB05
 b4mBx04/GGyJ1kJNIKGaM0IRsGTb9e7wGDl62pzXrmEI/VdDxILnz4xwpPTYybGJ
 P0xfZZrKhMzT/OveQUuTp4pv2aXCp0hMluZnz2mlScnnZf0ujwacRtLomRC1ZQte
 3dFNQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dwcg5pa2s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 May 2026 23:38:00 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6463D2aN2164713 for <dev@dpdk.org>; Tue, 5 May 2026 23:37:59 -0400
Received: from esapsmtpat10.us.dell.com (esapsmtpat10.us.dell.com
 [143.166.211.153])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4dywhxg8tt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 05 May 2026 23:37:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778038679; x=1809574679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lx97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=;
 b=YZbW1TGYo4N30d1dIDOssHWudHlSiEUxS6MUsTuE+xwuEINWq9fldW7L
 rD8a9VqQF/lxYLL2prSoTOBrH0NlIm155wpuvpF4dYNRMNlJsfNmlpMC0
 i1vFEDi7796/SlU4r624FdkpizcQrNo4XCbdI3wBOvmQCkucxGqLnHXtL
 bUX6UkFnzlF1aOaUgtYPJCqsKchaUz6HdsZUhrRsPkSsfMrGqR9nUVv3o
 tI7A0IZd55qnFNfcB0X0d3e4IGrSpjXx/HLZE75KcE+4OIeX8a/p6n6re
 BHURntAZqNe3fwfVXe17zSLrDsUxptsAFQ6AqAycz5kfLN7FE5/2oWYsY Q==;
X-CSE-ConnectionGUID: +owRMzWKTgq3GEk9SiH//A==
X-CSE-MsgGUID: BFdc0WjoRquYsW/tBrrTlg==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat10.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 03:37:59 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 22:38:54 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 22:37:58 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 5 May 2026 22:37:57 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, <fengchengwen@huawei.com>
Subject: [PATCH v12 2/5] vhost_user: header defines for add/rem mem region
Date: Wed, 6 May 2026 03:37:30 +0000
Message-ID: <20260506033733.972952-3-pravin.bathija@dell.com>
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
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060032
X-Proofpoint-GUID: 8b0yMnPad9ts1DX7lsZnk7u6ohFTqy1b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDAzMiBTYWx0ZWRfX2Fo4ND7r9ueh
 8oRlaQvUyjtDmCc66sn6rnMYc7jtqQT/YiYnsLM96/lsMYlNRpmobzIJZHHXew8HMXRApT3FIYG
 q0P/T7sTYz5P+31BoJAPRQ5OXQtLWZdmPnrwKUTfA1d9U4/HSz1u60okCvJbbpJjjDGny+P2gxg
 5EUntvid9drc+fAe8sUpcc3sbFCsXUAxbO3UpZKPolqrMQ2+Wz+nirr1wdZ31k6mDLTyVpaBG6A
 THSE1mJqDM3U6xopPzpvJxfByztypmIBjTksCDJioOahyypI3coca9HMyMZPvOadupmHges2ur2
 I38mv21sIF66M+phWJPDp2m1WMkxzzw4wjmyhdNmqSCYJ7RB6TsrjDDipWAVXBxG/yCLigwrDxC
 MMDRjmRPWSav/X+nI7tfFHRxhgAmUrDXvBAY4hOgHDkTcfZYqLfU7mV7fxo27Pi3u0ZwE5Oeeb4
 R1gFnjreMG1xzt6HH0g==
X-Proofpoint-ORIG-GUID: 8b0yMnPad9ts1DX7lsZnk7u6ohFTqy1b
X-Authority-Analysis: v=2.4 cv=bLQm5v+Z c=1 sm=1 tr=0 ts=69fab798 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=zctdXvwhg3EK6xEvKeLW8g==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=CCbkoWxl33X5vWekUEUA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
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

The changes in this file cover the enum message requests for
supporting add/remove memory regions. The front-end vhost-user
client sends messages like get max memory slots, add memory region
and remove memory region which are covered in these changes which
are on the vhost-user back-end. The changes also include data structure
definition of memory region to be added/removed. The data structure
VhostUserMsg has been changed to include the memory region.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index ef486545ba..f8d921f7f1 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -67,6 +67,9 @@ typedef enum VhostUserRequest {
 	VHOST_USER_POSTCOPY_END = 30,
 	VHOST_USER_GET_INFLIGHT_FD = 31,
 	VHOST_USER_SET_INFLIGHT_FD = 32,
+	VHOST_USER_GET_MAX_MEM_SLOTS = 36,
+	VHOST_USER_ADD_MEM_REG = 37,
+	VHOST_USER_REM_MEM_REG = 38,
 	VHOST_USER_SET_STATUS = 39,
 	VHOST_USER_GET_STATUS = 40,
 } VhostUserRequest;
@@ -91,6 +94,11 @@ typedef struct VhostUserMemory {
 	VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
 } VhostUserMemory;
 
+typedef struct VhostUserSingleMemReg {
+	uint64_t padding;
+	VhostUserMemoryRegion region;
+} VhostUserSingleMemReg;
+
 typedef struct VhostUserLog {
 	uint64_t mmap_size;
 	uint64_t mmap_offset;
@@ -186,6 +194,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
 		struct vhost_vring_state state;
 		struct vhost_vring_addr addr;
 		VhostUserMemory memory;
+		VhostUserSingleMemReg memory_single;
 		VhostUserLog    log;
 		struct vhost_iotlb_msg iotlb;
 		VhostUserCryptoSessionParam crypto_session;
-- 
2.43.0

