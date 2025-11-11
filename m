Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA840CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:45:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C20FB4069D;
	Tue, 11 Nov 2025 12:45:45 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id BF81040678
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:45:43 +0100 (CET)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB2Z6J1025685
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=v
 8Ns9WAFNzjQZ81cMfPcGdaBnn2n6XflWbfbVuuZpl0=; b=qLRoBOCwmiLZpzoLM
 VQd4x/Ehl4LgSs2Om/9wl2dpIekqwoDO4f3slex3a993Q1X66k/fcrbq8/dM5mnm
 FsgogpIzxoP3eS9kR+hSgT21kjJll0Nssu+328OHJTsvwTE+1ABa3qHRnpk1yFsT
 0wo5H82CJJYNPtAA9fsFuuv0DlWsPtbVX8lCnLVtlp0oexIftboRIRuFe4KU4eNP
 BPSPKg21ml7a7Aygfz9ZqJxNW/6u57lCIzM5vSwgagGP29SakJZ050AHJxy3vYPy
 d1yzuVVUIJmCcFKrDslH+UvxsNJ7FPeoRqBctPB9pRMNwGqs1ZxbncF0t22kq4pM
 1zPjQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa3dskxqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:43 -0500 (EST)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB8lnMO026022
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:42 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ac1xphwr9-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762861542; x=1794397542;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v8Ns9WAFNzjQZ81cMfPcGdaBnn2n6XflWbfbVuuZpl0=;
 b=Kx2rCwalo3CgHxj0uD1zl4gr71dzkVWkCavlJ7Sl6hZ0DsgkzkehS9HE
 6Zd3ud9/Xt0F7AvVaxSFKu6FANEQ+r/VvozesfdETjZgXl0OnoxL2FWJt
 z25ykXo15HN0xkmURni0l+38gspcFGlbSiVZba40gqGcE5k9nYRkXNXyD
 V8ayRhJH/XS9cWo6gGCfWetP2DHj2IwjBaq2g49LWTgNEuJJfaW9yaD/y
 3kpUXqXfCXicl/0/dq6oOXGy2fE5CwoW2jds3STDAt9V8t9ZfJXqSx41y
 dDMgschanjfG02eLzGZ0Z0rTLg8tkQHQ3NM9fRFR/ifGMKLL7OLOP9CXk A==;
X-CSE-ConnectionGUID: V6m4vLQ5T4msHBV9pw2wPQ==
X-CSE-MsgGUID: h016J7UpS8WfRFcOrdGitA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:45:41 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:46:34 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:45:40 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:45:40 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 2/5] vhost_user: header defines for add/rem mem region
Date: Tue, 11 Nov 2025 11:45:18 +0000
Message-ID: <20251111114521.2902867-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111114521.2902867-1-pravin.bathija@dell.com>
References: <20251111114521.2902867-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3NyBTYWx0ZWRfX904ZwkZ+d1N2
 UBKhVzh61bGZCAUHQVzQ7EhdNDpVAoBSbIqFKLw/kbYX5glj5fnlTcpnQL3TiXMgGmWRcvX+sWm
 3aapxvkEP9jh3WdzpJ6sEciD2w7MrVBPPlUyEtqdyUz93htZKsYrODMPeDQs2v/vS2DWCTLRvyG
 nj6lDECS3xOXdObB2565n7xdw15B7pGivY72Nt8sHP5o1g72CH89+cxexlqVusIAarZvOdBpBte
 ZH1O+l0aEdShvjkdsJFjNNEyKBeFmVVu3bVnknNq90nEflpxWuNB1g51uvTMopKxOCvBoApaE/t
 mHY174foD6vGl/VR1qDfUbHA+oDybgrTGsp+yPMbRIEfYsfsk0xjMZwMJGieZIeuDWDQDqshkP2
 vLrhIdjIWjxhzN+zjVIrWsglZ95WHQ==
X-Proofpoint-ORIG-GUID: j0u3BKQqIuAedcGdBDxBdBxdRqMz1lyw
X-Proofpoint-GUID: j0u3BKQqIuAedcGdBDxBdBxdRqMz1lyw
X-Authority-Analysis: v=2.4 cv=Ud9ciaSN c=1 sm=1 tr=0 ts=691321e7 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=SZDRi_bp6sUVpNgfmQ0A:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080077
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

The changes in this file cover the enum message requests for
supporting add/remove memory regions. The front-end vhost-user
client sends messages like get max memory slots, add memory region
and remove memory region which are covered in these changes which
are on the vhost-user back-end. The changes also include data structure
definition of memory region to be added/removed. The data structure
VhostUserMsg has been changed to include the memory region.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index ef486545ba..5a0e747b58 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -32,6 +32,7 @@
 					 (1ULL << VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT) | \
+					 (1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_STATUS))
 
 typedef enum VhostUserRequest {
@@ -67,6 +68,9 @@ typedef enum VhostUserRequest {
 	VHOST_USER_POSTCOPY_END = 30,
 	VHOST_USER_GET_INFLIGHT_FD = 31,
 	VHOST_USER_SET_INFLIGHT_FD = 32,
+	VHOST_USER_GET_MAX_MEM_SLOTS = 36,
+	VHOST_USER_ADD_MEM_REG = 37,
+	VHOST_USER_REM_MEM_REG = 38,
 	VHOST_USER_SET_STATUS = 39,
 	VHOST_USER_GET_STATUS = 40,
 } VhostUserRequest;
@@ -91,6 +95,11 @@ typedef struct VhostUserMemory {
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
@@ -186,6 +195,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
 		struct vhost_vring_state state;
 		struct vhost_vring_addr addr;
 		VhostUserMemory memory;
+		VhostUserSingleMemReg memory_single;
 		VhostUserLog    log;
 		struct vhost_iotlb_msg iotlb;
 		VhostUserCryptoSessionParam crypto_session;
-- 
2.43.0

