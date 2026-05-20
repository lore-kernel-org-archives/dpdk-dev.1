Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0393FCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 02:20:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51A4A4067E;
	Wed, 20 May 2026 04:20:39 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4069540672
 for <dev@dpdk.org>; Wed, 20 May 2026 04:20:37 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K0t8tI3233586 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=G
 7RvdF2EqnOupSOf91f+pcxUxoWWDTWQ0A1WT0n8Rd8=; b=BzJ/Vf+GmzsKl6Rw/
 pUIquq55wjl8FaM9wE5RN4j8dg7EgCz5mGJHYekXzYHPsugkKcElscY2ilco45xj
 /QiCMPrLBz0Aq6J01hZonPRgJHLmcGDUT/YTiH7ACn6DyCSJ5ZKds4t2wmMQKp1h
 Zlfayw6bjH+GaiCt+ZyJqSRiS/oRy8fvYkcro7TdXpW9Juz5xJwHm0opZ+bBri7I
 9VUHgqzS8iS4ZsPuSYsi/dXgmNmJlA3QGvjsJatkrIMXfcQMRXdOaSbJeZfG0vtm
 RxsJsrH7WfatjgyS0RIZfq0B2VFc47EEJlOAsUNxCyLncAqUoWvZnYmvOuoBWIQg
 pms6Q==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4e6kt59me3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:34 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K1j5Vi1912367 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:33 -0400
Received: from esapsmtpat03.us.dell.com (esapsmtpat03.us.dell.com
 [143.166.211.152])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e8wd853k6-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1779243633; x=1810779633;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G7RvdF2EqnOupSOf91f+pcxUxoWWDTWQ0A1WT0n8Rd8=;
 b=oT/NP7IL3ozw1ms1vLMVs9C2bHBurGm3ObnZz7E38kbNItx0rvltrJY4
 iEgpAI31dCmllophnGyRhzrKjytRtz2l+Dk76fmFW6ZEHLun57vCjb7Vj
 qV+p01K3WzOZTx5UoDr8iFtfCIX/k7Re+1SkY/xpZfmZ0alThwE/iSHCB
 OxuwVXwEFtyc+XXOgucjzVi7zRzBUdNJ+YGHHvHRw/dOBA6ThBUe1/5XA
 LYRWlR2sAQH3MBquHDyd1ubNR7eBtK0IzIvZyQTSKVjk1fCvgz2WKth7s
 /ud/xzB8sKH51dEFe+lYrKbAfPrieaxJqMMfr1by9ZM9uOUjdPUASLZTP g==;
X-CSE-ConnectionGUID: Y140qD2fRSizPMey3ZiI7w==
X-CSE-MsgGUID: HhEHDfWZTluGULlclX5agg==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat03.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 02:20:33 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:21:35 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:20:31 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 19 May 2026 21:20:31 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v14 2/5] vhost: header defines for add/rem mem region
Date: Wed, 20 May 2026 02:20:09 +0000
Message-ID: <20260520022012.243619-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520022012.243619-1-pravin.bathija@dell.com>
References: <20260520022012.243619-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200019
X-Proofpoint-GUID: 2dS6qPJQSOg6iYL-Uen60_XoKI6cO3EU
X-Proofpoint-ORIG-GUID: 2dS6qPJQSOg6iYL-Uen60_XoKI6cO3EU
X-Authority-Analysis: v=2.4 cv=KYLidwYD c=1 sm=1 tr=0 ts=6a0d1a72 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=Exi4HLWdEtKd1bGGvbjpxg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=i0EeH86SAAAA:8 a=CPuvAHPoAAAA:8 a=20KFwNOVAAAA:8 a=CCbkoWxl33X5vWekUEUA:9
 a=gbU3OgOOxF9bX48Letew:22 a=r6J0Z2L7KMegjY60bkqS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAxOSBTYWx0ZWRfXzg0vfSG4ke9l
 FoFIQMlxPP9r6Zuu4xaKdcYutmNLwBuaL38bG5QJGy4yS94UB+/9Hm1W41kKM3dx5KpzVNHi2yy
 VGBuBXBSeLkuDCsP0lHcDVhzomz1v4LX7cdB+ucC3oV9nKNfDcG5yCs9kFUbdXNh6QrEByRlHXU
 wxDmNyuHeeaae9w1l0fXrf/XEHxn0yvDj9J2RpRTLRfAWFn0duSxnAx7M5nrCB6cmT12lMOYZwK
 6bvMsyDLY85VPnsTblTfMey6gbMQTSBxEmwjmObA/c2p5Wc2yRL0tb7vpNxLfqEcx9+F+8yt61M
 XSCVzBbvhbpVxF6DdB4ZrRR/nAvrVyWBGRQDKNkQtJiSNnfIs2uU7IL3YdrC8VtU7OzBk2YJ9fo
 mIwMY9NnnB7NJCOZ9ZvYnRCiej+DJ+05a3kvG8r3UFIbLauvG8OUf/1Ut0A4O8VLqUoqOl446hN
 K9UrbqvrKtO/upuyg7w==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200019
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
Acked-by: Fengchengwen <fengchengwen@huawei.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
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

