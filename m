Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1CDCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 04:22:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55D3140395;
	Tue,  4 Nov 2025 05:22:32 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 26A8C4042E
 for <dev@dpdk.org>; Tue,  4 Nov 2025 05:22:31 +0100 (CET)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3LCWPv021844
 for <dev@dpdk.org>; Mon, 3 Nov 2025 23:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=O
 mcSRbMjBO5ItoAphjsxzYW+0g8bU0ZezzzUNlDorL4=; b=BJz9EDp8s6fTDSk2i
 jvmwbST4t0SD/NatwCfureosng3WCMrNJgCvW8myI3koHtpwcOPsscGIeqoZzZcc
 IyLEHkQp23fp12hq7u+hR8p7iCy9h69jIVqSr/dPLHc3zXLHB+avkhtQhsjqSomm
 VRZjabK2EtCpNhWi7KkxKx/1fnkyw+q+5iH5ZHO9u/srcAw2fIEDuNfQxAQW+gec
 FFb82BcryfDGPD76998l7c01OKD9Lca7HF+qNk7N4SfGE+ha0khsxV6URp/EHAph
 Bcii27lPloQFzjxSULtHmgf/5AJ/aTPKQmO4kDaIlybW5fLlFwwmjl2Vb7BQC4OJ
 dOWGw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4a5e7hjtq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 03 Nov 2025 23:22:30 -0500 (EST)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A43NC9b008224
 for <dev@dpdk.org>; Mon, 3 Nov 2025 23:22:29 -0500
Received: from esapsmtplv08.us.dell.com (esapsmtplv08.us.dell.com
 [143.166.203.145])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4a78dh971b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Mon, 03 Nov 2025 23:22:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762230149; x=1793766149;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OmcSRbMjBO5ItoAphjsxzYW+0g8bU0ZezzzUNlDorL4=;
 b=kxI/cBCqPqHGX2c9IY1Zv8eQfO8i21+OFhzz00jSFA7zKiIdFVxhJBqG
 Vw230jihVycvoyIdgzerWQH4DDASnzK7lNU637SO6ZeFWeaihOs4iTK/a
 s/tAeVanUzE+bTofGi+AbyuMfTqLxaUnvI6nwBi0afia+OiavF44K3lQy
 8so4Hb3uHZV4pgAgqty661D37AvGBGWEQhxqAe93XoTZctcBcHJ5UadTJ
 avzSlGzey3Odh/yjZBUhmY9f+oHkirsHX9jGomVLpLyy3f+BoIWRAZqUt
 0APiC8WXz2BSEqQ5oPtKKHYmxzY/df30rAD/vqm8o167ZxDgtqBTJEcLw Q==;
X-CSE-ConnectionGUID: DXCnuvSySBKFrDRJJINHvw==
X-CSE-MsgGUID: 58xe+cq3STWPk01hQ9q+9Q==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv08.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 04:22:28 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Nov 2025 22:23:28 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Nov 2025 22:22:26 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Mon, 3 Nov 2025 22:22:26 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v3 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Tue, 4 Nov 2025 04:21:37 +0000
Message-ID: <20251104042142.2787631-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104042142.2787631-1-pravin.bathija@dell.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511040016
X-Proofpoint-GUID: UqRlFQmWY_-EpleHwaZWp1bf6Pw63wJR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA2NiBTYWx0ZWRfXzLFLsSCtqAO6
 Dd1Mr4eNQfVJ6pdhEqQFantSI2ev+OHkI9ukICSsy4GGgaJBDW5JQaavoEyvQp7/9O0rmYTd4Ij
 HM4mRjiwwYv8Ls6AxXaiYrTqDnuqThlMPJW9ZHJLEVsaAmLWbZpcdNX+zuxTzt0VR2fgcUe6Ql5
 lCnroAATkp2Z8pJnLJHi10l/lIZlmFHPQNPYW0S526OnvRmUe9uBinRLbbzrbDonCLSR9N6sCrr
 9dYzLku1G0hlPatN6fXdzweweewWCTCdHegjPVPGHjDDoDmywgTc+93ijcNHcLjEe1Uf9bahOAd
 12kK8zv4BkzVygJNiRVetVxQ5ndDBZb6BR8IJjm9VXXytaqVIvIgtNS4Ewi3dorcfld+xr0oUMt
 qw3vL4A8Hw3fEkom1z9iIp3N/8QZcg==
X-Authority-Analysis: v=2.4 cv=WKtyn3sR c=1 sm=1 tr=0 ts=69097f86 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=7aFXbidJGpJUqALx8qt4zQ==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=3CDqXdsAvEiB_ezhLkQA:9 a=hlJyneSgMmFPbskH-t2w:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: UqRlFQmWY_-EpleHwaZWp1bf6Pw63wJR
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010066
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

- add user to mailmap fle
- define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
that depicts if the fature/capability to add/remove memory regions is
supported. This is a part of the overall support for add/remove
memory region feature in this patchset.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
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

