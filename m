Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20E9CD6E4E
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 12:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0ECC40E4C;
	Thu, 13 Nov 2025 13:44:49 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id B67AB40E4B
 for <dev@dpdk.org>; Thu, 13 Nov 2025 13:44:47 +0100 (CET)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD53Rra019147
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=G
 /1XBhQqTpf4UJuz8Z0qBzd46wngxr8lhv3gU96eUb4=; b=f7JMeHAwLinLGtxKw
 ku0awoRc1USSSer+1rvISWDBAnjGJsgjMA2O6odvTHlqd6iIFs4ZYISNxUII5EGC
 6368OCt+ZeSxiZjFIwAz34g6liuLe3OBEI2/S2Q7eCbwokKyNZGECTe3gG8C/HEG
 ZW8307i+twYrup86L0xVkSJwGmnfflJbhRaJ2XX1l6DK6JaxuCEEQn3JEH+dfrE9
 wRMNXknqsFYKU1kklqb65ETknpkKVV7lgJEQKh62soRkK2mJXYn1CCGnsDnPjqDP
 zhxxEraBQD5fjphNlu+qpVM1n+VZLJcEr3DTdUjf4h62Cz5XcZoaRn+uKuEH1Qji
 YC/Yg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa3dt19yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:44:46 -0500 (EST)
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCFH6R028910
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:44:45 -0500
Received: from esapsmtplv03.us.dell.com (esapsmtplv03.us.dell.com
 [143.166.203.148])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4ad0j1k6kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:44:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1763037886; x=1794573886;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G/1XBhQqTpf4UJuz8Z0qBzd46wngxr8lhv3gU96eUb4=;
 b=W0Notiy2fgK++Dg2h12wUKP4hTVLByKZ9LA431OGkKPgmY40rMVvBGsM
 RjD0vvZdhu2C/iQ3QtAG1pM772FSnk02Ry826G1vSjq5fujgYfDNxWb6m
 1MpHl0YDn0cv8TuhqwKQxKQcGWCuUkO/8qnOmTRgM4g/1stArbWKiv3/b
 MjuyScFadPfUNgeiLn7y4H/svYpnbxUq6QF34FyjAtp2emcDfwrwUWdUd
 dQUUWwZ+gv2kmu69OcJU2e1Bf+mZF9uDZM1WxGEzeqzRMBGhvPwSUGDj0
 8DXOkz/J6jQjLJodm+WeWFrxMIG47tJAOzhq0ldzudoZM+hGOtZYtG4z/ A==;
X-CSE-ConnectionGUID: z1i9ercfScCpYBvpHvqFvA==
X-CSE-MsgGUID: rZYEwU7/SwysJHT75r4VeQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv03.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 12:44:44 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:45:48 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:44:42 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 13 Nov 2025 06:44:42 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v5 1/4] vhost: add user to mailmap and define to vhost hdr
Date: Thu, 13 Nov 2025 12:44:22 +0000
Message-ID: <20251113124425.2913881-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113124425.2913881-1-pravin.bathija@dell.com>
References: <20251113124425.2913881-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511120158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3NyBTYWx0ZWRfX7bmPj5j0Bm08
 Mb6jmlzEuYx2IQwdbdDEoU+LR3sbhJDIbeSRrfco1Rv2xAGwC0G/RRDBPpOed64P1LwmgGOP9rL
 AR+N5AHLM86vDfw9K0GYDJuas9tzDLO1H0VltKHKv2gyu3KzhbO3Tx9CIaTUfXS1751bs4vkrGh
 o32wE+7JQLjx2Gr+H+u3bqtAN57ZbuqBa2I9nvk0ODA16oqJithsyWlZiy1BwCEK1HK26Tw0/eK
 103zmK6c9Z0PsQzEZ3TAegfPHVIjXszTzYjjz1KcEphSqOrxRtuuqfFan6OOxNIROLP39+I5Bhm
 vnQ8XrZeWl6HNIhq8lan8BzGE+Qam4lndgebStSAqaBa90Hw6RPddZgPvMEQs0uMmqosVivzadl
 LVFyDmkBZr7nvPApIp38Y4eycFW1vA==
X-Proofpoint-ORIG-GUID: MqPByF4Imt1SpKVPNc1j3Jz7hzvrsZEm
X-Proofpoint-GUID: MqPByF4Imt1SpKVPNc1j3Jz7hzvrsZEm
X-Authority-Analysis: v=2.4 cv=Ud9ciaSN c=1 sm=1 tr=0 ts=6915d2bf cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=iGMIhCliR854E25UHWhNxg==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=3CDqXdsAvEiB_ezhLkQA:9 a=gbU3OgOOxF9bX48Letew:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080077
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

- add user to mailmap file.
- define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
  that depicts if the feature/capability to add/remove memory regions
  is supported. This is a part of the overall support for add/remove
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

