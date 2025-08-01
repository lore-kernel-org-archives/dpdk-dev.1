Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CD7C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:13:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C23340E2B;
	Mon, 11 Aug 2025 15:13:17 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0CF3240298
 for <dev@dpdk.org>; Sat,  2 Aug 2025 00:23:06 +0200 (CEST)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571CiJon002347
 for <dev@dpdk.org>; Fri, 1 Aug 2025 18:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=9
 lsfEBA+4jLQnNwRT8NCtqOwdjqKEPoPwP+4xD5zoxM=; b=SyRtQ0HJsuUJiaosH
 E2f7I1Q0UpVElIPM7oO64YISVZRY3Xuaw7plW22bCbPW3RZGvkAcZVnwdlbCUsoo
 ocQeeYGEt8ccpr5R6cIJ1KUOvO0Zbov69oY/r4sHVaYQyAI0h1YPV7sPtZ6MbmuO
 nIcDiLlHcQXpsQu/TgZhLTLv9ODx+Hu7YW/92XVYKMz4zFj4qPhdE2mvxHeWR8CA
 aTzKUw6lmDnKXK8bN4GQcaG8kQcgLCkfM1ycoHsWW7+SsiEnARL0EMj6+JnFVNxd
 vx0qKwi5drmAWGdg0CVXCP3d4Rz710Oaid7fodPuUFrCDfP74Sywdge+DVtNd9lY
 2HTSQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4876cg002j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 01 Aug 2025 18:23:06 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571Kh63X000897
 for <dev@dpdk.org>; Fri, 1 Aug 2025 18:23:05 -0400
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4894uv0um2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Fri, 01 Aug 2025 18:23:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1754086985; x=1785622985;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9lsfEBA+4jLQnNwRT8NCtqOwdjqKEPoPwP+4xD5zoxM=;
 b=BlSMh2h72OnwIwYzw/3qOcD02NF1tBhLO2ZmY+0fSTgdOZO0QoYSD05E
 Pljdng+4rxgNp5n8tSD8XET+OQdF9wB3I0YJKaPSSVLjwQxEXdiWN5/oz
 kx41GGwCBSJdzFpbPlAfQoQqxtYE52i4MoXeq2LKJ6UOxw1kw5wMIXPQ5
 HWiQIiXWcFzQg++JYeZZN1W827yRd8q32Yg2xpALAKO2PW1hwFAMBvLDC
 UJcojFGx3FdFKA8QsCqf6Ozbl7TFvFMfAJ/ZpXLOzwFn7g4S6+hb0IE3K
 +CG4NwntqwwgOnWUorKmmSGig/ZCtdh1uTyditBxcEDway4Ju+VjF+9MP A==;
X-CSE-ConnectionGUID: O0QLllNJRNS+bswizv7eYg==
X-CSE-MsgGUID: nLwSGcHlQYyBBlRKw2ZAiw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2025 22:23:04 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 1 Aug 2025 17:24:06 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 1 Aug 2025 17:23:02 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 1 Aug 2025 17:23:02 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH 2/3] vhost_user: configure memory slots
Date: Fri, 1 Aug 2025 22:22:37 +0000
Message-ID: <20250801222238.1519748-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801222238.1519748-1-pravin.bathija@dell.com>
References: <20250801222238.1519748-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_07,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=668 adultscore=0
 malwarescore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010179
X-Proofpoint-GUID: vO1vG-5TeR_W0BKSFwal2clHLZa3O9jC
X-Proofpoint-ORIG-GUID: vO1vG-5TeR_W0BKSFwal2clHLZa3O9jC
X-Authority-Analysis: v=2.4 cv=NsDRc9dJ c=1 sm=1 tr=0 ts=688d3e4a cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=2OwXVqhp2XgA:10 a=ke5jqHz-1hQA:10 a=pGLkceISAAAA:8 a=iLNU1ar6AAAA:8
 a=vhdcl8Btm4WQQZqW7OEA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE4MCBTYWx0ZWRfX29yOdYOkoWLR
 pLzCNEXukrjG9nruZqnpobGjAq03GxqH3CF7JMcz5fT9HXTgmwBq2h4vCEKRRD77WtC4pZjSTdA
 4FIVSobxpjcLk+8bbyABWnvkADvN43tupcBov582KLPLyz8hGi9g9C84U2MyKiSVtME1ZZuxLGS
 30iZj9XP7HGfzdGtrcOu2rhw930zapeU0ZQny6gaBgw/t17hPEIlgEJe2ElwzAXriEujx2dH7Ip
 7QVfSRxCqNwyJoAcz7B7VHw6Iird3W30Ucx6w46FMjTpwEtFW3r2pIiK4TDj7vwkZCu/TCqMCWD
 4yQ3zlsV3AwvpNnq7ncQmEmWxG6qtdf2RvE/SsWw+TD79uPfQhWa8g3Uv16NgCNs/H0AhezHFpQ
 ZoVOnrnvpHCXm21s9b3DKsrfXPU36g376ahiDkf3BFksy2zL1cLVJXSoiy4vnPhrvOTSpX/5
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0
 mlxlogscore=712 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010180
X-Mailman-Approved-At: Mon, 11 Aug 2025 15:13:09 +0200
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

From: Pravin M Bathija <pravin.m.bathija.dev@gmail.com>

header definition to configure memory slots/regions

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/rte_vhost.h | 4 ++++
 1 file changed, 4 insertions(+)

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

