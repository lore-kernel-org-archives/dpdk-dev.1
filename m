Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1465DCD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 23:57:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 488524066C;
	Fri,  5 Jun 2026 01:57:55 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 65E0F40671
 for <dev@dpdk.org>; Fri,  5 Jun 2026 01:57:54 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654M01Ju2997927 for <dev@dpdk.org>; Thu, 4 Jun 2026 19:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=N
 N7Su9NiV6JPGUTqDHsVB63fbjRoTa1PnozYB6MS1po=; b=H++gXNNfs57YIurBE
 MS/d6wlCfJ4a73enxH3/V+Tl/HsWP54smMUFHt0F4oQ6R9TIpK450GWaHPJDi6UV
 Z52pECzIGlQ2Ip4wcJMyVZV94ii7g2TgAM/WWVCTm34vX0Td+O4h+Yc+drGldyHF
 xZHgejRcvIRI0A9KR0ewN/pnIAVmnmghKY5OzyIuK9kXLhf/vFJQdyr7mcPwDTxj
 V0xn3KHy0uIbQ1kVBfwwznLyIYxO9uYRG53p8EXnMI0ubdiFx8FbXQzk6erHEgRp
 yOGFwOfR4lbPZaNEzGEnCiFz0j5e+cVO2I1RruxIvwKay8d7kJRH416F1ccMFG4g
 wVWDQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4ej75nt9x6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 04 Jun 2026 19:57:53 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654M0npN1586793 for <dev@dpdk.org>; Thu, 4 Jun 2026 19:57:53 -0400
Received: from esapsmtplv07.us.dell.com (esapsmtplv07.us.dell.com
 [143.166.203.154])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ekhsk991v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 04 Jun 2026 19:57:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1780617472; x=1812153472;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NN7Su9NiV6JPGUTqDHsVB63fbjRoTa1PnozYB6MS1po=;
 b=XBEemSAk3EdRVCvHZKUbKSc3jXYjuSC0G9fx9fCnVwQI3tOK0djEMs1i
 dZtzUvaE3+3L7+ltld9Fn04a5milAu6NwPDD2OSFe0FZAQjOSdzBklx0P
 0KY9OV69w8KIjB7tHi+L+qMLpUACCy/cIJJg+71QAfIrJIaF3px79LmCe
 VlWbZ7a1cc3LcS780maiESpNeM5QDr4uwz71jXj+QMIqJSa6A6KBK+mH3
 aaUq89I2XZsQIAxGLcICCU4gGQcXtDOSt7Dof8bHr42KNaFpsYSylZDsp
 rOPH8KTkBBi2s8OcJmYBkN3LEvfF951YWAKtdy47twWOB+Cf9kNXpxCHz A==;
X-CSE-ConnectionGUID: koUukXzqRHuSsLLbbtKrBg==
X-CSE-MsgGUID: RDBbUsO1Ts219ACr7g/oWA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv07.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 23:57:51 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 18:58:37 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 18:57:41 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 4 Jun 2026 18:57:40 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v15 2/5] vhost: header defines for add/rem mem region
Date: Thu, 4 Jun 2026 23:57:20 +0000
Message-ID: <20260604235723.1046607-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604235723.1046607-1-pravin.bathija@dell.com>
References: <20260604235723.1046607-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040234
X-Proofpoint-ORIG-GUID: TqeIpJKBwT8pfButEbaql3ofnGBeYyUh
X-Authority-Analysis: v=2.4 cv=TLV1jVla c=1 sm=1 tr=0 ts=6a221101 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=FlBIjDbFArVVlnHZBJJA7g==:17
 a=FelO9ux0wxsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=i0EeH86SAAAA:8 a=CPuvAHPoAAAA:8 a=20KFwNOVAAAA:8 a=CCbkoWxl33X5vWekUEUA:9
 a=hlJyneSgMmFPbskH-t2w:22 a=r6J0Z2L7KMegjY60bkqS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIzNSBTYWx0ZWRfX/NYMZpwu016j
 tT+nfgZUvpnRjbJrusWupXHhyafgAhw73pFJRyj8aRtLmpkSn2smHPwaLxEEvtAeTeV3EKZ7b+b
 Cgh2DeiZj8yoYY5GwbfLTitpJZpPUq5yltGJ9AvniHISjSuRiGMrCDqYL2/h62K+z+tcRhpX5X7
 xT5Q8f1Gi2H/ypq52hOcPCErsDMKMFoymzPE+zAOEwcOcGlSNSiUcHQWT4v4LKm0Nq1+CNZK75K
 BDlKIDGQA0o5HUb7+CE7yFgeh4/yqGbR4Z3Vsa1pUKPOtmYd/Tne0f6MnLK1ByYnfPeIpvj3wlf
 GNzC1l6PC+wx+wLFZstir5ehbgi9sEXrQpLK8bAlw9Ox0cSy9qO/NeH0EPu1DEW+x89b/4ZRvXD
 95fHsRFb2dL9LfHGS30zk7QZ1lk7dp8ioYskI21dMeYL8sTxB4GEyWbKPAvqSZmgIpNeUSrugAC
 weQOxPpsQVSn+7bHuWA==
X-Proofpoint-GUID: TqeIpJKBwT8pfButEbaql3ofnGBeYyUh
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040235
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
Reviewed-by: Fengchengwen <fengchengwen@huawei.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
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

