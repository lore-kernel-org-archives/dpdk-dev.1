Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2D0CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 09:05:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C7B440672;
	Wed,  8 Oct 2025 11:05:28 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id EF3FF40661
 for <dev@dpdk.org>; Wed,  8 Oct 2025 11:05:26 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5983Nt7d017183
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=x
 zzVodZjPQCF71w969m5wFT3DiGcwgMRawuP2Y6x5To=; b=mE0gxlk+2VVjmWS/f
 8CykcCkciSlFDCQG1Sb9HmFxW+cobhTGBb3U88PoGpy4dbn4nwnxAAKqCvxwzj7c
 MpBkBbdR3jRDNYw2EeIT1tdYZIHn7NXdb7AMbxha2aDfkLUgTFH8sgsjqXVHs6IY
 OXKchSWBXYOrQuEITmbotVneNjHTVZEGFz9DjuVo0hXJ1pthxcpHIPG0L4ElWqJj
 8sMTNZBsdpmMxFUbF/C7f8Ec9ZQcB1n9X/hPLPd4Yy929gVGhIKJbf0dHLHJwFvC
 E28+P5UUvEK/qBsiBwXRWoeaA2Z3v5qVSIF7dhtROPiMqWpuIYyJyod8bgn4U5Ff
 c01bw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 49jxqv998y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:26 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5988KoEs032498
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:25 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 49ndqfvkew-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1759914325; x=1791450325;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xzzVodZjPQCF71w969m5wFT3DiGcwgMRawuP2Y6x5To=;
 b=P8BEki760cWT7OMhVaJJ1w7rd4z2IiJos84iS3k5tjBcy7TTkrSqwNcA
 coJs81iBjG/4cL1F/g5xPOSBVxTRIxcvCX3eqOn6EQnM+0FSVXFlfjPQH
 i5i2OjLIsn2wGLG1CltvTdulMu8FeYCKTD9G/I4H90z+yBSIeplprmkpL
 WytsDhdBmmadZz7SG6E7NVMdsriYn4pZWQXerfanznNwDvujjO4o4dsbp
 g3GoU3wa/BP/5CMQ4+rONarXNVjR3lu/2ST0o+4DS8A1Yx6zFFiEVqswz
 EMRutS6WDylj+P8f+QloQnouR3F81SQpyVmcVxxz64gACkv4VFNHC29Cl w==;
X-CSE-ConnectionGUID: HvNsejooSpaTu3OD9uRzkQ==
X-CSE-MsgGUID: W0gvSmSQTs2wQm6YurrSHw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 09:05:25 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:06:25 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:05:23 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.34 via Frontend
 Transport; Wed, 8 Oct 2025 04:05:23 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v2 3/6] vhost: hdr file changes for add/remove mem regions
Date: Wed, 8 Oct 2025 09:04:41 +0000
Message-ID: <20251008090444.2689652-4-pravin.bathija@dell.com>
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
X-Proofpoint-ORIG-GUID: mm59QnUHfOUxVo2uSir-M9gxtgef9qVS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA1NyBTYWx0ZWRfX12+vBW6v+fWZ
 YSQgZWdsR75hDrLFX2Gxr8jEdIFUyMipCCQOb1LxSWSjRGLV5aD4SQRHdI3Qtknz8l9flwXJ1U5
 wdN1s+6jaWe2cjfJMCkCf83KYJJPPqcKn9Ep9qnsH8Zyu7q7pmCNNXfzeabu045/lRbzfIpMy5t
 LqhS5efql3HtsZh5FuvxHq0F3VBy+QQgwvu3LculUFdOAFXH8q3yzU4CkkdKeaTI5guMQVW2Plk
 M1Bx0UvgAAcLUuMBORJO8cal2m9QCgzpD9dOtwfB8/pj2lFZNla9wmbEhSC1g2029K/YWfNzWVR
 8eD4IJxGYdwSNcLJls3U/EqqcKBdeFRzGqTfRB++z/MzU/QyG+sucNkHwUw3ton99RNTlRwf5yg
 7FxyQcm8maQ6aF5DJ5Wv/ZkS4M+xoQ==
X-Authority-Analysis: v=2.4 cv=NPvYOk6g c=1 sm=1 tr=0 ts=68e62956 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=x6icFKpwvdMA:10 a=ke5jqHz-1hQA:10 a=iLNU1ar6AAAA:8 a=SZDRi_bp6sUVpNgfmQ0A:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: mm59QnUHfOUxVo2uSir-M9gxtgef9qVS
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040057
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

* add enums to vhost user request for add/remove
  memory region support
* data structure that defines single memory region
* increase max memory regions from 8 to 128
* 128 add/remove regions tested with qemu virtio with
  testpmd vhost.

Signed-off-By: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index ef486545ba..c6ad5b76d6 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -11,7 +11,7 @@
 
 /* refer to hw/virtio/vhost-user.c */
 
-#define VHOST_MEMORY_MAX_NREGIONS 8
+#define VHOST_MEMORY_MAX_NREGIONS 128
 
 #define VHOST_USER_NET_SUPPORTED_FEATURES \
 	(VIRTIO_NET_SUPPORTED_FEATURES | \
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

