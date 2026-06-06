Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BA0CD8C88
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Jun 2026 02:52:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8651040611;
	Sat,  6 Jun 2026 04:52:24 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 457314028F
 for <dev@dpdk.org>; Sat,  6 Jun 2026 04:52:22 +0200 (CEST)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655Juvkj2564631 for <dev@dpdk.org>; Fri, 5 Jun 2026 22:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=N
 N7Su9NiV6JPGUTqDHsVB63fbjRoTa1PnozYB6MS1po=; b=leO5sEk6tnzKjmAiO
 Ak45ptGathPMdX++YMwAGJJiXMGTSKi2VcSWbYTm2PENkEASWVeZyK6Z45/2pBf+
 zbXjV/0AkKlgUYF3hdVuXx6u/wPB19ZPG3GeJVG3sUZtpjlmmZ0/2FG2fSv5ChRN
 qwnC/jmWGpBIbhKLlA/4/beGfWsa48y72U2GNEA+4x+eVi2xvwuVrCuQ/y9gI/fL
 IJEHSvNKlrcp9/hKVsjiajkbsUXH17dXT8/hvG7haWY0JY+s1UnirkXdpvK7eoBl
 Qytz+/cfb6cCA7RTqp2c6YAyTLkKe6A6PRdMdBsfk9SqsxPSiY6Txz+7XVlqokIG
 juJJg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4ej75hyq0e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 05 Jun 2026 22:52:21 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655MFH0f2491284 for <dev@dpdk.org>; Fri, 5 Jun 2026 22:52:20 -0400
Received: from esapsmtpat04.us.dell.com (esapsmtpat04.us.dell.com
 [143.166.211.147])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4em6qrk7yb-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Fri, 05 Jun 2026 22:52:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1780714340; x=1812250340;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NN7Su9NiV6JPGUTqDHsVB63fbjRoTa1PnozYB6MS1po=;
 b=gJRrAVUIVRwBABiEmjthgUffmuDtWHFKYMjm1ZtAnFDabhOEdpjQl+xd
 f/CpvYUOoRb/pr5Cw4ZvDmsVaI8qK2GPwnBOhVcigzFTGryz78iVIRmzU
 GGDiRkpBeSRvzUHIYydcnYptKD7xShytoN97BZ+7R3nJ6k8DYqUWT8Y3a
 Wpv34UR8VijHGDJh/CuR9mlqGoHDRjI/PINgE7zWGlnztlvG1RxbEfz7Q
 wXcXPj9oKPI9zOpezRpWr+M7xz3P8jE4r4pOpy3xd4DPoMxrRsJHh6vn0
 YInRrWLwY00VUcYkOLhdUNe6ZLQLWkndk3MhHYDPUvQ2QKKF6lJ715TD9 A==;
X-CSE-ConnectionGUID: dAzbCziaTqKql0L2M/107A==
X-CSE-MsgGUID: kWMHBU1nS0GhENtxmRk/YA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat04.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2026 02:52:20 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 5 Jun 2026 21:53:22 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 5 Jun 2026 21:52:19 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Jun 2026 21:52:18 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v16 2/5] vhost: header defines for add/rem mem region
Date: Sat, 6 Jun 2026 02:52:08 +0000
Message-ID: <20260606025211.1082615-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606025211.1082615-1-pravin.bathija@dell.com>
References: <20260606025211.1082615-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060026
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDAyNSBTYWx0ZWRfX+HKvJbcJGeP7
 BNZJIOUoZQ0dUoedBzWn0nrndTto0hbncmyQrZWWpgZ0jSJV4IyVsuZuus3X6tuDMtkXibtSkZe
 yNhhb8VVtDT2p83itRem6O0Gr9/wSUq0AYp2Lz+K7hfDfBUPkRikF6RP5smoUxqd7QBZEVxlFwS
 eicZGrYfi/jQSMWzB02Jvw/uqsoCaobz9HK9MlpewW+I7pkFtqcYfRg8YfKxxv+42yki0VWGTbB
 n/EwZePnaW2W/l7Z/8rKOt5TKS3z9Y1k8tV/WWGYcbkhpeMX0aRXZc0zGKMMFzzO6QegpINFMPo
 9fStQFnhfrZJp/beZfGrnCS78y6N8uk5Yd0jYs9hbBsHhA8aijc0kCU8A/ZRNk9Gjl48olOL7jc
 ZPyLGys6MvEA3F3kIfpEqw/6Vtd517zY6tsTZaHqnnvVe5PKCMzd/XFCQc/EAFIpqfhdHF7Tag5
 33a1nTd1xsBbPOS5acw==
X-Proofpoint-ORIG-GUID: e1yfzvlYvYXq5uga6y-rCECEfJ6uJ5hn
X-Authority-Analysis: v=2.4 cv=HsVG3UTS c=1 sm=1 tr=0 ts=6a238b65 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=xQoiRHjKKYbJmV+sD1MyuQ==:17
 a=FelO9ux0wxsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=2Lpba0WeoN7BYVdwMO11:22 a=iLNU1ar6AAAA:8
 a=i0EeH86SAAAA:8 a=CPuvAHPoAAAA:8 a=20KFwNOVAAAA:8 a=CCbkoWxl33X5vWekUEUA:9
 a=gbU3OgOOxF9bX48Letew:22 a=r6J0Z2L7KMegjY60bkqS:22
X-Proofpoint-GUID: e1yfzvlYvYXq5uga6y-rCECEfJ6uJ5hn
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060025
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

