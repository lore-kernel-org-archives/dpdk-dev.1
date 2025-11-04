Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C1CCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 04:23:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9065C4065A;
	Tue,  4 Nov 2025 05:22:59 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 9604940430
 for <dev@dpdk.org>; Tue,  4 Nov 2025 05:22:58 +0100 (CET)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3LnK50008834
 for <dev@dpdk.org>; Mon, 3 Nov 2025 23:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=v
 8Ns9WAFNzjQZ81cMfPcGdaBnn2n6XflWbfbVuuZpl0=; b=qzV44+g9Om4tboq2Q
 9skOuKa8qK2pmLFuim0val4dlQ0jNIWUx3C8bqsnySuI/K7D6iP76KkB9EJEKuPX
 TagVYv9DinfkPklicuhe014Um/QmpN8iqdRpnv65P0wHCLR5Xg+fXUoppoCw4j34
 VqwqrqzsDmopgTvkT8MaUhOKmNNO5SdVc5XNVjIaIq5c9+w+18Y7hOWIum4d27Xh
 Fqd38dWiW21L7manOjVktscX0XWGPS843VQpqeYb/pih401rQsG3lfhneOf8hJSc
 s4LC1szFNntDBwv+brmL5pIMg2dboYQBkhsmwcHlc6ZDi8V8RS2sqk/gC3HLQoth
 qcL5A==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4a5cs5b1tx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 03 Nov 2025 23:22:57 -0500 (EST)
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A42pFiw007946
 for <dev@dpdk.org>; Mon, 3 Nov 2025 23:22:37 -0500
Received: from esapsmtplv08.us.dell.com (esapsmtplv08.us.dell.com
 [143.166.203.145])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4a5ydaqqd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Mon, 03 Nov 2025 23:22:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762230157; x=1793766157;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v8Ns9WAFNzjQZ81cMfPcGdaBnn2n6XflWbfbVuuZpl0=;
 b=DgSwmZWYd2TIrzT+7b9hg3+7UT+MMtJpKhnKAstbQl7qs0fTp+RJfHZQ
 5WaRUWlL3OVf7Aqvc08DMS81UhJGaaRdoREjrbgsADzDNaHertNiw2C2T
 6/G2ijbvXT8cZ12HlIgaWiNjOJ/xvDgHCfnLX1c1vRv6hS+CqglaZO8Dd
 qRi8Gvfp9Qd8kCnUKjnUkIqsBVpMi+s1snY8bi0UUonvOIUX47JSXztA9
 eZNLHD0k8fCgB3UD0ioMazoDpy4wD0ZgQkYfVyjKvRXI4WDeqoXnKhc33
 DVp+SyuD8ow8gdzeyO6RAvwFs4w+3+YC5M6GFJPImGxkhGwsfo6+ckfca Q==;
X-CSE-ConnectionGUID: 3vR3F7qYTlSIZLaMw1wPXw==
X-CSE-MsgGUID: HhD3rtaHSwqMaImcPNqaZw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv08.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 04:22:36 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Nov 2025 22:23:36 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Nov 2025 22:22:35 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Mon, 3 Nov 2025 22:22:35 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v3 2/5] vhost_user: header defines for add/rem mem region
Date: Tue, 4 Nov 2025 04:21:38 +0000
Message-ID: <20251104042142.2787631-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104042142.2787631-1-pravin.bathija@dell.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511020029
X-Proofpoint-GUID: oRrTQFI40Wwetdoaom2MpHelu--FOyUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA1MCBTYWx0ZWRfX+ujDKYwfW5kG
 7mTSFbrHlyYyzSKj0WXjw+CzL/U0djyfiW+WSnS3kW6s3Vdm2u21RSLlScpny1MU6Sd81NwEDsx
 gfOHDLsJvyDFd+NEgo7sk/1NHYHOHJi/XNFD6veCBzaiyJ76YYL1Ay7+9nwWVWy7Qd35NWhPx/p
 3jQd6GTqLJ5q72yB10CSjzbH4x7viPZCJHzQnaTAiC5xf6wXWTxJxSUuFb2Bcf8SPZnR7WEG1S+
 z+MS2wZwN0+J2tH0/2VVPn0aRjEzPNcI3Z20dOiCTkempsQBvJOTTsTqkaBteMEzWxWesSkRiw0
 Jb04VGqH1Pbd9ZR/N+GtBol1QFxK/PVCfkKXPB2fvm7Coq3R08PtJTvLqzqf/YfCZlY9Ep6XNm/
 A2OqEynvBJZ14fV5B8GEHGiQEAVgsw==
X-Proofpoint-ORIG-GUID: oRrTQFI40Wwetdoaom2MpHelu--FOyUu
X-Authority-Analysis: v=2.4 cv=BLS+bVQG c=1 sm=1 tr=0 ts=69097fa1 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=7aFXbidJGpJUqALx8qt4zQ==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=SZDRi_bp6sUVpNgfmQ0A:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010050
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

