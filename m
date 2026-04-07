Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5848EDB7CC
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 08:06:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3310A4060A;
	Tue,  7 Apr 2026 10:06:17 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 5F17D4060A
 for <dev@dpdk.org>; Tue,  7 Apr 2026 10:06:14 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LSGax748747 for <dev@dpdk.org>; Tue, 7 Apr 2026 04:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=l
 x97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=; b=jkLHxAEEoP9g2ec+M
 DPCXkXsxOhYgEmN8K3viknt+/yNYZExRNqJghUXoMdsEZQRXiMfLUboJkSbdxXCG
 mUbU3LmPJewSPj0N/dk6JB5Sv2TLme0ZGNNBm0cQVHJX70W+Z2qWnnKh8UEcQ7IL
 vzCgFsBEJJJFDsNICkVDvJ1S9e+zO8V2EgjqPbOtmT1Vt5Zyye97+HSifBhE+ie8
 qH3E4jEBAATkN4Gr4IWpD1crb4lhbBHmc/JPhl+c8s/JfxCO+Horq0KWqweNHgX+
 hOpzMOcgK7rEn2PIy1VQYDzF65HfpPfv/LIQV+chkmVj2nje4/TbWJq9mS06kVoI
 FSPVw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dcmrmtg3f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 04:06:13 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6377QIFh3424384 for <dev@dpdk.org>; Tue, 7 Apr 2026 04:06:13 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com
 [143.166.211.150])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4dcw9hrstv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 04:06:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775549173; x=1807085173;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lx97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=;
 b=YhkqsPExuwFNSVfcJhTAk0HKexIDaWeOeyzWOw0Htg12lH3m/hxkDYU3
 cjCoAGkI3J5APKe2emFoMrYCR1oF5dYOJFIWqEQqtG176BB1frYtP01Zf
 befXWhEPwbXnGg/BNO95g8FQno3Rvrpe7VFjq5aDKjipd0GaCLZwloYms
 MJPVlyC6jAbwVwCl9BuB+xfYPbEKMiUMQCiuyE8Fpb+T83Nvx/BebgNvT
 x/qNbNa5a+CSgIWt/LZNysZeXvgxEdNRZaGEhvYCdwyvn+w+KlbNEXa8k
 yVJSmFWlr3npZBIj/wc8dixBCyGXyxXU8SWcnvxY4bbkDz3Zz0kOqy17y g==;
X-CSE-ConnectionGUID: 22J2cDuVSByQIx5wGbc0Gw==
X-CSE-MsgGUID: pwQxVoXYR66gqk9FV9zF3A==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat02.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 08:06:13 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 03:07:17 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 03:06:11 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 7 Apr 2026 03:06:11 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v9 2/5] vhost_user: header defines for add/rem mem region
Date: Tue, 7 Apr 2026 08:06:33 +0000
Message-ID: <20260407080636.3878354-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407080636.3878354-1-pravin.bathija@dell.com>
References: <20260407080636.3878354-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070073
X-Proofpoint-GUID: aCsUy031eY1-KTLQda0LLgGLLlyV4FWR
X-Proofpoint-ORIG-GUID: aCsUy031eY1-KTLQda0LLgGLLlyV4FWR
X-Authority-Analysis: v=2.4 cv=PJw/P/qC c=1 sm=1 tr=0 ts=69d4baf5 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=CCbkoWxl33X5vWekUEUA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA3NCBTYWx0ZWRfXzcCmXu3bzHr5
 xPeqOn9rszgHsLIJSpxUV9OnMDh8C+uOn8XvbWmk2HMP65U2AEtU/zy0m2BeFwBFu4b3rOGN6VP
 2x+iQPCoV6opggOHMuhMDRPlo8MWgML2USCBHjl5+6KFtIEDDoliv+SuuZit9Dv5zW9scHiPKRn
 qAgh3bg3ss3mkWR0ExVTRwiNXiaQm1mpjh4iV7ePWIgkeVI2JhH3ToxIaEnXZhVCrKnBpoQ4oPv
 ft3lldAJzOdKz9uvlhDNA3LOEza3KdXT+g7Mgs4lLBM4cU65WHyUCTmjgOC1wWeFAS4x31EhVLJ
 /a0/HPl9HK5Fj/241F8HbjLuD8WTTmO0jNMYV6svAcVmEpDYjSw3cylMaU8RGFjdW6TbldMqajY
 dBxte+8Bo7WNHYJRVVeosvOIdfPGmbPR7I4gab7dae89DKyGcNyD2Z40thtjufZTRP49DGxdwgl
 D+ulaXIk/JUBHos9XjQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070074
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

