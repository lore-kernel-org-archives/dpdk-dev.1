Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA5CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 07:38:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 716F540E1F;
	Thu,  2 Apr 2026 09:38:08 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id ECD6E40275
 for <dev@dpdk.org>; Thu,  2 Apr 2026 09:38:06 +0200 (CEST)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6321pb1f3346556 for <dev@dpdk.org>; Thu, 2 Apr 2026 03:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=l
 x97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=; b=YCLQgF82ceWjKRt+v
 FMfeH3tRFDg5UrwkeEkTtdjpN/wQc6/8fng04cEwWFi3UigHjXuOd7TXZELABPMg
 FRovk7FBuKdyi0IKbf3DK/0M07Z5kQ2nxF2M+CR4QCA0TLagl2JVHw07K01N33bW
 /BPw/fhp/fkWaVRsLDrBKJyfxBLfGJQZ+mQNUWS9M6GsbpeYLbJ0f7WGyCWVnCiM
 EmDyMBbOt8QgRJdLcm2cj0qKneO4n7FkI+n4o3ir3KlIOgHJL2FXgyUJPglFBtgs
 kCPBpJ2k7k1yf08rQZGzU7LNUVEtccfsCLeCTeW41ceqerpnHbQ1Ds5N8c5YQIA2
 AmWEA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4d6aacqktw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 03:38:06 -0400 (EDT)
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6327PJcq1998953 for <dev@dpdk.org>; Thu, 2 Apr 2026 03:38:05 -0400
Received: from esapsmtplv02.us.dell.com (esapsmtplv02.us.dell.com
 [143.166.203.150])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4d9m0j066q-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 03:38:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775115485; x=1806651485;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lx97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=;
 b=lLOvXWobST03Qxu8COnllXaAomO6ZGL105Md0lEYN68yOF7Uha0OBtEt
 XovaI4NQbSsVnP2bNVq890B4kKR1PqE1HOvOvylf72a5w41grP5AiPb3u
 cYN4ejVT8yF5ZxGlSXIbA9Zc3qjkSKgOAVPCUYc66FxZXh8eOI4g9LLvq
 RZnNjBtMMcTK5+Zhu30djNV0VSN1Z0A2vUlG1DTYSAuEKaSnWztGBlHZJ
 7N/gCtU3s/qCb5ETogclAvj5Burq3auu37O3loLaCSutBsutUZgxUiGkX
 HLau9FY+6SpMuUuYdmzt0nQvStWZjRYXDdBNcVdh/X9MSQBvnKkVTjoPo w==;
X-CSE-ConnectionGUID: 3ysEVMkKS7OfNk2T3h27Lg==
X-CSE-MsgGUID: cEn3+5VYQ7GWzCehqGAU0g==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv02.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 07:38:05 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 02:38:56 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 02:38:04 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 2 Apr 2026 02:38:03 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH 2/5] vhost_user: header defines for add/rem mem region
Date: Thu, 2 Apr 2026 07:38:00 +0000
Message-ID: <20260402073803.3068147-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402073803.3068147-1-pravin.bathija@dell.com>
References: <20260402073803.3068147-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2NiBTYWx0ZWRfX7pT+/w20B9LH
 2UVJLRY4f5jSWRf2TxxmgktsVs8fGqwD+JmTzdQoiM6xrJgAC2l/VgLp0GyxvpfmA/6qq7/odyS
 W65VYBhmQZI+/tH5Ziwz5bHZNCfCvF8ag4EjSyBuszEDvU0Uc7h33ABl7IQwcjl+n+tSd7CqZCq
 MyLEpO3urqcrDwh0iiS4H57Q03NgbvqBribPy3mxxuf5IPf00RuEEZUHrCXjHnROuiMKIsrehT2
 jbhfFX77K/8tmY8HscLDBBN9HCJvEPSYhAWpIwMdudWriYrfXorWATDMjXkDQuo+mZ9F/MoAL5K
 AhT6fgf2QZH710vaq3l0c0TEQaaPtKaaPavyBhFaJfj51T8foW4KnZQBcUkc8rOeCpOzKt3Q/fo
 k06U67nk6q+Dlkooi7Qw2tCkpsg70EGZTaaGLBR9lnOej8RgWfGqbSXEVGoLPl9Go4IzlJtBMAs
 mLuL7EBgE7LEiLFbCbQ==
X-Authority-Analysis: v=2.4 cv=eIAeTXp1 c=1 sm=1 tr=0 ts=69ce1cde cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=AlKjE2zswbbG9QqlC8cQbA==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=2Lpba0WeoN7BYVdwMO11:22 a=iLNU1ar6AAAA:8
 a=CCbkoWxl33X5vWekUEUA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: ZclIVnz6jFBELqKFZdwAY5E_Io1UpwO0
X-Proofpoint-GUID: ZclIVnz6jFBELqKFZdwAY5E_Io1UpwO0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020066
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

