Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FADECD37AC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 02:03:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2D6B4065A;
	Thu, 14 May 2026 04:02:52 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 510FA4065A
 for <dev@dpdk.org>; Thu, 14 May 2026 04:02:51 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DHLwZ91865445 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=K
 GpmCNj4uSTXl2pij3fq5mzREVLTz9L4hgU+zdob5aI=; b=daa6oMkyekNse+TIp
 agA+gRDqa6R6qq6QbAnmiNCJx5ylv0+/z8nUJ4XQONSW4NyLUcCG6S0L8UeqmHv5
 Lm+WLGPbl22dB0ZZLgA5iuuKismu4qQ3iTyLeUo3ZYoN7g3QwrSomEtIWwAQQp8X
 CXpFMhQB8huvScnxCCexDLtO6kBdQfMtwy+xt4SL8UEyRZ4YndFKYDfpIyZ1Cnyy
 xcVvYSpYwQ4028Aw2w1qrjGTb35z4gzY62g8qu3dJwFC9uduSsN6odLDhzR0uN5V
 KI/X/bWdu9zZ/WAF7U0Uu9A8xcWg2yoMPx0BbfOWOyvh36RiiBzQStmc88Nx5rOP
 H0D3g==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4e3nv0ks7n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:48 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E0wojY1290069 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:48 -0400
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4e51aej921-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778724168; x=1810260168;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KGpmCNj4uSTXl2pij3fq5mzREVLTz9L4hgU+zdob5aI=;
 b=ijQVQRrpTwK4WcOJvE8coq1zF8mJdJo5Yad5is6HqF+m9jv/i3Br0K/e
 RflT+elM5B7K71bX/wm/cLx7LwPVmAjWnjTAJKE0g6geWjUqmnm2/bKAO
 qFdJk6N3CbRW8NiO7aGgzCDmIOW2zLQBql4x3uhA49vQ+cryPAL3fWMZo
 Shj/6ESqo0+PzG4KeI+JhhB1BxmljnRaTXxlCBvipm71AUAf4YEP1Wmwb
 21Tn7p6LPK+PtapASnjtgfC83jT7zrVY8IxYIk4sJaDGbb1GUy745X8pL
 BxQAiiRXy8L8KwqdtkBjBstUOEPAiGC5CpBUheQtDpccw19I0p4gOh1x0 g==;
X-CSE-ConnectionGUID: cUiGXqpAR+WPiYFnE5qBuA==
X-CSE-MsgGUID: KIAIriFqSEi3xBsN7OlWDQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:02:47 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:04:01 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:02:45 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 13 May 2026 21:02:45 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v13 2/5] vhost_user: header defines for add/rem mem region
Date: Thu, 14 May 2026 02:01:54 +0000
Message-ID: <20260514020157.1937404-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514020157.1937404-1-pravin.bathija@dell.com>
References: <20260514020157.1937404-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140018
X-Proofpoint-GUID: MwJ5Ti9mQqwSD5BRqWH9o94iSBvdY0w2
X-Authority-Analysis: v=2.4 cv=f6h4wuyM c=1 sm=1 tr=0 ts=6a052d48 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=CCbkoWxl33X5vWekUEUA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-ORIG-GUID: MwJ5Ti9mQqwSD5BRqWH9o94iSBvdY0w2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAxOCBTYWx0ZWRfX0eVKi9YW81u8
 HENsJ2MpDOX5uZrsLeHOuw+NXLd/Xl7g6H3PFo23k7d8n8DAyCsdtjWIBcu2hWtwujPSGMFCX8I
 /H+l7w+FbppmYiyug1aQVkxLrHAX15AW0gBSSDwdlBOzGLW+pUso+eHH6gMmy4vidtfXu3aEZGD
 1Yx3B8V1PlXI+8dh1rbSazqpPwnZnqPze6vF8Po4catCZlu8NsgD1T2Eu72ikLT78x3g/2IjVbE
 +WMjftyOiw95t/Lj7q2FqQopaiNQEEPjfztxsfbnG34iuzzf0CjSz02ytyWY06mPAkxTuwWneoI
 gGe11P42zbPB/0htFjCHNfHQ6ze0WGOIF5MZCZQmebtOOZFc9CUNHI1HBLYjEtqTaqSv/8aM7dd
 FrGH6EYgGXBsTSu3LsWZBnR5xWR/q5J17fY36suba72o9Th9CEl3ZZI7LwsFlRlEK6hsWYNyiZ6
 1ZxYMS5hRRyLpR3VHtA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140018
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
index ef486545ba..6435816534 100644
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
 
+typedef struct VhostUserMemRegMsg {
+	uint64_t padding;
+	VhostUserMemoryRegion region;
+} VhostUserMemRegMsg;
+
 typedef struct VhostUserLog {
 	uint64_t mmap_size;
 	uint64_t mmap_offset;
@@ -186,6 +194,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
 		struct vhost_vring_state state;
 		struct vhost_vring_addr addr;
 		VhostUserMemory memory;
+		VhostUserMemRegMsg memreg;
 		VhostUserLog    log;
 		struct vhost_iotlb_msg iotlb;
 		VhostUserCryptoSessionParam crypto_session;
-- 
2.43.0

