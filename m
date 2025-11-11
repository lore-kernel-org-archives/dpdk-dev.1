Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC730CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:13:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EA1740652;
	Tue, 11 Nov 2025 12:13:09 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 90E1E40395
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:13:07 +0100 (CET)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB2bbgo009950
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=v
 c83fSMw0mSLx1yCBksiGCLeXtefqtDWi1ZUd8SE1UQ=; b=SwiTeb65qTgmhzqfg
 1331Nj7oL4A4lMT/U1knSR33FPFpA+bWIhm1rJCKhx3pi5NfBdANB7v2LfIjw6ES
 8zFr4Is4LuddI/NmLX1fhMHw5tvz5mwoLKPuV+p61ZHvUaZvhz5XfQT+Wug/qB4v
 e/tfyrJH2rSfYrzd5GzgsqLOm2A3YLrvq1pF402S+qlMbkUllJ7ZJXFAywz/7omQ
 pq9dQYKdPOKcgjMnq5w7O812Xm8zez+IuJQXGQfouqHnQBkvM81uMMCFzPRpO+hO
 SpKZzscxumSCwIaIgbd5V2wblgZ6pG61nsn8u3i52MGPq8uxR8zjzmbvAs48GE76
 jbCCg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa1a9m2cs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:06 -0500 (EST)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABBAXQE020809
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:06 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4abxg33ytq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762859586; x=1794395586;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vc83fSMw0mSLx1yCBksiGCLeXtefqtDWi1ZUd8SE1UQ=;
 b=Zkz0UhZAciHNublRub85g1BQLNAyXAbnev05BhObMOj4+2xOUkDo13FV
 bpCHWM4jsww756g4F4L33UYsYhmnDMItgXpGs9v1wiCcUbdRB4qULBotw
 TOzhMW/843Sgaj4YutCgwlYDdIp5XrOpxNjPNi1z8UiIOfmxxONpD6pE7
 5qpekMnbI63+eQGOtp4eyDtuHCZerrHcj96Sb9IcpmOF4sr8Obd6nhdGi
 C/0x8qGrFUWPF8+CMa2prIRiZPXBVvIWEjZgoQV0fir/t7wHSlAvMPW7Q
 WKgwL15EP5+e5RWu/s316AIDHxxpi0fFzlrs0XF/RgTLt4JIryJwjE5X7 Q==;
X-CSE-ConnectionGUID: yVcxdMZfTBG7QzcLlYpMng==
X-CSE-MsgGUID: BQ2K+rTETaiXcSmVWwWEKQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:13:05 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:14:09 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:13:04 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:13:03 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Tue, 11 Nov 2025 11:12:31 +0000
Message-ID: <20251111111235.2902146-2-pravin.bathija@dell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA1NyBTYWx0ZWRfX3uaz5DYFrVIy
 dx7R7dkQ/vrZI0AhgXux/Q9kXdmd1EevD/1XFLbWr1vwajK9OMQFhIJzr/fxH0X5vjitq9S7Ikf
 yF3O37p1QbhmI60GDveU1SUXjZTlrwsApnwx7ugcSK4+Jt2qhnpTE4t7LDLsmrFK8Y4tP0h1SPG
 pBBZloqkbR0h7E5VPCSt11jlyWfmzdYMFaWTfcNWq6HBvlTLlM7EYX/JX2UTxrcUEwcvmFisV4g
 QE6+HX7fHCl8fz7/rU84coraqcGNZ/ZIHgD2gRDsq+ta9Y73j284LGR+JDS9FLnBcFDCFpG69VT
 XonNQidDEMlI9GTL4fsxi6aAdJSCal55hgFfsOzhEWvP7KiRPWcD2vVu21Tc8rcdKVpLAHQvxku
 3cF621daJkRCVvrNbq/8HWZPz+9CKw==
X-Proofpoint-ORIG-GUID: xXAUJGEoE63GVjCat5UpGqm5BhJBzgQB
X-Authority-Analysis: v=2.4 cv=YPaSCBGx c=1 sm=1 tr=0 ts=69131a42 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=3CDqXdsAvEiB_ezhLkQA:9 a=hlJyneSgMmFPbskH-t2w:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: xXAUJGEoE63GVjCat5UpGqm5BhJBzgQB
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

- add user to mailmap fle.
- define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
  that depicts if the feature/capability to add/remove memory regions
  is supported. This is a part of the overall support for add/remove
  memory region feature in this patchset.

Signed-off-By: Pravin M Bathija <pravin.bathija@dell.com>
---
 .mailmap              | 1 +
 lib/vhost/rte_vhost.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/.mailmap b/.mailmap
index 0b043cb0c0..33b8ccf92a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1266,6 +1266,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
+Pravin M Bathija <pravin.bathija@dell.com>
 Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>
 Prince Takkar <ptakkar@marvell.com>
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>
diff --git a/lib/vhost/rte_vhost.h b/lib/vhost/rte_vhost.h
index 2f7c4c0080..a7f9700538 100644
--- a/lib/vhost/rte_vhost.h
+++ b/lib/vhost/rte_vhost.h
@@ -109,6 +109,10 @@ extern "C" {
 #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
 #endif
 
+#ifndef VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
+#define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS 15
+#endif
+
 #ifndef VHOST_USER_PROTOCOL_F_STATUS
 #define VHOST_USER_PROTOCOL_F_STATUS 16
 #endif
-- 
2.43.0

