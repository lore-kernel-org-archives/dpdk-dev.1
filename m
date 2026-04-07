Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB003EDB7EB
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 22:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE26240430;
	Wed,  8 Apr 2026 00:41:30 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 93FDC40616
 for <dev@dpdk.org>; Wed,  8 Apr 2026 00:41:29 +0200 (CEST)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637LlpRm3991097 for <dev@dpdk.org>; Tue, 7 Apr 2026 18:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=l
 x97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=; b=bX3HjJXQ18/qL/Rdr
 Fsyj3ae+KUrSnU7l0+PkKbYoYLzkh9tXKa8BQnU24Lfy27ap+YTYinVninekL0IN
 ijnUuSiesqVtJPBdx3abhI9ICGSPzPg+hBXjLi6uIMD6MXTuVWqpkmYtVz4uZL+Y
 Exw2nQFBSnWulNrWhMtB+3cnuZWJPahXdB3s/FpJxsR65kujo5JFuDnjOnjzbER0
 5SVYKivUXhpF3ArvbfBQ8zgW6DZEAz+y/4CCFVrZmgtmHicUXSnrMCTWoLIw/vBx
 0416GyTGLqfRiyw99lnFWde3/EDZ/Ax2DlurIwx3GGQ70VptRGiWj7l8H6CQY2yF
 ws9Yw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4dda4w07ve-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 18:41:28 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637Llsu13938245 for <dev@dpdk.org>; Tue, 7 Apr 2026 18:41:28 -0400
Received: from esapsmtplv02.us.dell.com (esapsmtplv02.us.dell.com
 [143.166.203.150])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dda5g8mah-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 18:41:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775601688; x=1807137688;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lx97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=;
 b=Cu32NsvxXsC6x3rAA+g9eeEwn2PpEuN4CxeAuYDAiWMK5g12cjScNFY0
 NSNs/GOFOwCbANxr+soH8ED+iq0ul2cHZbz7NEpB5hOlVVuS2j+rl1cgp
 dtfErBY0zlxBu9ZqwWNtQUXegnesnx/C1uTFFKuhk2q2RT5C6PzkSZ4cP
 hkocbu2x2dIpqw6QmnCAOxsWGk2NY0wva7PvZ5iQBwBssNNo2WGVA1eso
 StkJsEX7dSZzAGm+KG8F3gyzPnNjxeEE85cGbhF1k+zAbaSaRM5R0xKsp
 ne/O9FQT5sfKtDEJN5aoKnuu8LjXcPqoOIgQRTe16j5XB3wHgYAdNw4ui A==;
X-CSE-ConnectionGUID: qs+KV/myT/uhpFRvqkeb5g==
X-CSE-MsgGUID: 4Z0wGIRcSbWw3k5L86sFTw==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv02.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 22:41:27 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 17:42:20 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 17:41:26 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 7 Apr 2026 17:41:26 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v10 2/5] vhost_user: header defines for add/rem mem region
Date: Tue, 7 Apr 2026 22:42:02 +0000
Message-ID: <20260407224205.3910803-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407224205.3910803-1-pravin.bathija@dell.com>
References: <20260407224205.3910803-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070207
X-Authority-Analysis: v=2.4 cv=Q77iJY2a c=1 sm=1 tr=0 ts=69d58818 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=AlKjE2zswbbG9QqlC8cQbA==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=PpEg0BoV_A2aca28hXd0:22 a=iLNU1ar6AAAA:8
 a=CCbkoWxl33X5vWekUEUA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: OUWOEtA4BlYJCV8forLz6s6_5qw-gwYt
X-Proofpoint-GUID: OUWOEtA4BlYJCV8forLz6s6_5qw-gwYt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDIwOCBTYWx0ZWRfXxXXOJeTOqSKr
 72GMTQvcK9b3r7zWVh5TPIOIYmOrnmEM4kPhOPLHSndY6hrWPPox/Etv+3Ogu5Euq4xp1aFe+ro
 Bc09MbBWN4Re1qKjxxH1zY3yygW19IkyrrS/CS7HbGBZRnsnZdvpwFtgyLqgy5cnl3KcgQp2Ruo
 9NB6l+LNlYPsr6R5SuY7fvPLUWdjOa58Oqeijba0WglqlcRDuwSM9ZfpSMChOZvedNpvqi7O16o
 uvbcHoZsyMD67X/hhrPFB5T/nKzcLfmC1KK9yW3IisuAGTzGL8CFTn8mhPQhFju3OpLL0NeJezH
 MQrHooaQwowdlv8glTk3gezP+9ceTZVNSD053ZbwJ8qiBKSVO/VidUl60sx+duzpDDu8rXeOV4P
 U4IQNXNzjs/1zVoByP/QVi3Y3aqUWlhMw7bfn6YftzYE6wzn8r/BFpv7pWD/TAJTIh8isMeKHQb
 CLTEf1a6+kTu1bKLkxA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070208
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

