Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94629CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B00E4065B;
	Tue, 11 Nov 2025 12:13:11 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 831BB40656
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:13:09 +0100 (CET)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5JscJ004587
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=K
 6NlBXRPdAnMc6K38ZkXvDc7xEV++RedsEBEM/H/lko=; b=k6jfJ9WUg80djeZjX
 iutJ69MQ4ekRqZIOdQCb8G5xnQpDMqiiwwERRud9HCXm1b1v2/+WG4fwdjEpKOUS
 HnW9hIgrTQc7xaavTKNmZhdqYUU0C3VOD5ET1EGzaNXoVX2+CL3kBzH5s5Byz31U
 mfU0qR6tlYv0RSR0KWF/DpXzWco68LETsPN9lLUIwzuG6eQ/PpKUydKlXZW/k35o
 4ZwIvWEG3+aJgjMK0IEc/IGU8l5rZvzmORO0iUOY4usYfkMebTz1dH4QTKOmq8pm
 3FVSOa+S+kkK68rXzE8N0xto8i7jGrxks4ZOM4Wdpb42qV06TrCbkqfJYmvvhPXz
 icgmg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa1a9m2d6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:08 -0500 (EST)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABBAXQF020809
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:08 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4abxg33ytq-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762859589; x=1794395589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K6NlBXRPdAnMc6K38ZkXvDc7xEV++RedsEBEM/H/lko=;
 b=A/z7ZEdMaBNTrfcyxSY0IJBagX8I3AAWDUqjYRw+l/sFq8GduVyEhjAz
 GV1gj/zUUyjeOiuT+SL8dxE74VEPgZhG8xy3mLB0uYWKKtGyT8/24ocis
 sa0x8P4phzGUXteK2EVXI7PAW3uHkK1GTEnwVQF0UERBZdArrYcgQ0GsR
 pfYE0y7DaRxzR9U3V/F4hzwd552eikWoFVX4cgSHfoxa5hToMDfUNolPt
 VfWu/QL05j1EjQwDJe+J6vuU4afU+ipJABQ/o5VvI0qzUrQ+8KDm3gEZh
 UF+B/mk5/oDtF+jYdVGOehIZeuDUm+bQgXzxDiSLL7C5z4G0fpAWDmxku w==;
X-CSE-ConnectionGUID: +ZPLzdA1RZSW1Tc/85qnsA==
X-CSE-MsgGUID: 2HmdYGI0Q2acaTIZS2hVkQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:13:08 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:14:12 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:13:06 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:13:06 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 2/5] vhost_user: header defines for add/rem mem region
Date: Tue, 11 Nov 2025 11:12:32 +0000
Message-ID: <20251111111235.2902146-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111111235.2902146-1-pravin.bathija@dell.com>
References: <20251111111235.2902146-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110034
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA1NyBTYWx0ZWRfX9uLgH5grc/Lm
 BGB75qVhO2l/1cWr71Z4MdfIB/9WfZHgbagCZKvAm7Kncd9lMQN5p9QnS/lbOxCcS421qM71y96
 qTiEjmXRT8NVdlcSSM8vZMckUochbIbiIpyOxQYgrzFepJYu3BveWib/4aZdwAy784qQRAks5i7
 rBFL0my/K59sLTzEM6mN4LYH61w1vPk/RWilkZXmfc3OJO5jnJHgf90XarOdjuSXR7+J4o5qVGf
 pWv6YjpTaSgRZJUmLI/SX+meHPFULpWpKyyIfpEVaqpOlxXGa+9SxnSGpSi91aw7FPSRMyrExkb
 MBnQewVwJAThS2AECbayS2EGtqIsr+M91d14x2oBLSKJgxzi4c7bjZwCCN97iziE7LGqGU4eI9X
 VNCQp850yE2z3IYcH5s1vqZTkcG29g==
X-Proofpoint-ORIG-GUID: UCbJ2MC3_2VMYW1fptoVyo3zOMytW4qt
X-Authority-Analysis: v=2.4 cv=YPaSCBGx c=1 sm=1 tr=0 ts=69131a44 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=SZDRi_bp6sUVpNgfmQ0A:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: UCbJ2MC3_2VMYW1fptoVyo3zOMytW4qt
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080057
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

Signed-off-By: Pravin M Bathija <pravin.bathija@dell.com>
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

