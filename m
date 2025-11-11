Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD95BCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:40:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82C0040673;
	Tue, 11 Nov 2025 12:40:34 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id D8DE84066E
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:40:31 +0100 (CET)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6jcPi029878
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=v
 8Ns9WAFNzjQZ81cMfPcGdaBnn2n6XflWbfbVuuZpl0=; b=OHf8ovjr8yrKRIu0Y
 Wg4/JE/W+YA9nht9xzDeaiyN5jFpepOCBQDoGCqJkHUDJQhS1FwSvdSZnKuiRYvk
 qzogfmuY4YCWJc+jTwQmBD2iOmkbBRKrNyjYGcpcYlEh7yhF2vlK9mQybjU3b60+
 ZrvAxcCRwC/kVoZ1H5dDY98YUUdhgBBjTQTunDXZsIK3qiZyf56goVAvUFfHN0WD
 WoffyNVXl/QzvQu8mIysHILW0JBWvMmgQX+qDzlvz9e8HUhtPCD5ELOWxpgk+OoU
 7xowYIhZ6J2NKV6aWrDd7+rjpTxgpclpZ90A8wnH9UzJSYRcMAm8g5ygPIv3NTWk
 NbOXw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa2k2m2fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:31 -0500 (EST)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABA1x5e012576
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:30 -0500
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4ac31mh1fb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762861229; x=1794397229;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v8Ns9WAFNzjQZ81cMfPcGdaBnn2n6XflWbfbVuuZpl0=;
 b=DhWXGsWW9K2c4v7S4Cbm1mE5zX9p9dJNGmm4dE70RjxbvT45PJqDki/+
 jYWk1H2fY7Jtqr7LAcrH3bz/8EnNCZQx3W/AJPonDaNIXLCgRo6asnuoj
 O8VylL1kW8TjaPIrLYss5yjrTCA3rw9mBc4EN5X1gVG7uIo+TrCpJOQoJ
 qxmh6rS4bYDXpeie+OmziqA23laShCGBjL1v76RsVILzR20/vWagnBFSD
 lvuDNhCwpEBucJ3HA3RAaYUcGK6hYxREy/+CGvhnq0htEbx39/ywm1gKp
 8X6Gw0cXQXnWHHfSHy3qKDzLTp/mZ1yjc68GATK+QbcJrh49+sIzQhDtr A==;
X-CSE-ConnectionGUID: 57aIwm9UQR6NIFxfAO3QFg==
X-CSE-MsgGUID: VcWehMM/R3Kzqr6i+wrDRA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:40:25 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:41:18 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:40:24 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:40:24 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 2/5] vhost_user: header defines for add/rem mem region
Date: Tue, 11 Nov 2025 11:39:59 +0000
Message-ID: <20251111114002.2902696-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111114002.2902696-1-pravin.bathija@dell.com>
References: <20251111114002.2902696-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2OSBTYWx0ZWRfX+WT3twb60Lxt
 mE8WiPqSimsGMgtl62FFilgxIZTGhCkhullb5mY5cPiOEAbgbvjFg17iOVJXzDPfpddAiOgftcR
 T6ZbJy0ywd2dcQowUlCOh7vzH72ihs53sZM4UwbzdYNamkG7vMHcjimf3Kd6DPpQJ7JSAe46wG9
 jSI0ZAwxlAhei1cSX+fNnmUiq92mZgUHPHG7EQ24RNHgI9PZck6WnNh/5CLYo5vGAQFQElC97Pb
 Dsmq8axABxXfKpv2a/XhGFhu23G4EiABj354MXxiy+z4v5A06EUPTZuUmfR3B2lA47T/71/kltC
 md2exCv0jkjVNMkAQ5b6hU2+07V5hyR3oP9RfTqAbXLnIptiUwWA2meiAnxaEVqlu4Gpm3zJF3E
 4aLm1tWaLfM8VNtfUvDhl38zQjf/MQ==
X-Authority-Analysis: v=2.4 cv=Vbb6/Vp9 c=1 sm=1 tr=0 ts=691320af cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=SZDRi_bp6sUVpNgfmQ0A:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-GUID: x4a_Y4GPc6Qg4W9LFjJ4pzu6UIZ8bAAE
X-Proofpoint-ORIG-GUID: x4a_Y4GPc6Qg4W9LFjJ4pzu6UIZ8bAAE
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080069
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

