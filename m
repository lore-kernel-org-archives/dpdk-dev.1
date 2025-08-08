Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244D4C87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 04:30:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 898F740664;
	Fri,  8 Aug 2025 06:30:25 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 751884065E
 for <dev@dpdk.org>; Fri,  8 Aug 2025 06:30:24 +0200 (CEST)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577JdNG5026457
 for <dev@dpdk.org>; Fri, 8 Aug 2025 00:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=9
 lsfEBA+4jLQnNwRT8NCtqOwdjqKEPoPwP+4xD5zoxM=; b=VwV1YGA2mY4U6bO6S
 FuvG4/Toi+d8JuKXSZ6VxfGRhxu40hpvwZ9Sq+3FTHf8vrhpreyDASmrR2KsKgLq
 9CM+CD7s/95NtK1oJQJmfkzWoHTwAf0USVZeDbQfg3aQDYlCbLTJw0w+jh4l0xWp
 kIgCmvtXtOgYGgZOvee6L8grdUzWjrf0lZT5CFNEY/k07MmQb3uV6Aa93aV2mZ+u
 SzS/ubt5kXfTkmLVZTDdsLPGqtX1Yo4LDl0VXYOJ9eLYcXHt2kxax4/5pQs8Xxuo
 I2mNqnw6rTG+Pyd/fK4KRuTJdmxCum1gK6vNXzBfoku7XbXu5tFepdQ2sA/jzaxK
 K3iRQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 48bpx25jeh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 08 Aug 2025 00:30:23 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5780NDP9004623
 for <dev@dpdk.org>; Fri, 8 Aug 2025 00:30:23 -0400
Received: from esapsmtpat01.us.dell.com (esapsmtpat01.us.dell.com
 [143.166.211.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 48d34kckt1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Fri, 08 Aug 2025 00:30:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1754627423; x=1786163423;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9lsfEBA+4jLQnNwRT8NCtqOwdjqKEPoPwP+4xD5zoxM=;
 b=b4lEkamp2e36Mtum6fa2cl4249VlaBUsXlnrL1BKyQGkas/DL/s4Vnvz
 ntfnL+oOFcB0FI11lEtxEB8wc4fn0VxBZTVyEMc8si1qrqycYGePXbMiV
 uusgtKp3Ub0HSks/Cy4tYZrdM5oHcPxfe9J1mK/TnpbkfhGfMfKaY0g5Z
 ikRiUZa2y7FPDfeuYTTS0fw5WQvsfqSYw76SIqN4Qh39HxX7ANwRjHVy9
 yXUCI//X61JmWdWBPbE6P/y+8POZXRiFuCXtnvWtMHv0mIv6h/mFvzLnT
 Omv9cetWt8fDhglJdGQecleFArzqGks/DAuHSF+ALXB3l1Q8uj3miagLC A==;
X-CSE-ConnectionGUID: gGOHlZvXTHuVARSP8JA2vw==
X-CSE-MsgGUID: r2xhcmWlQQiUKsRewgCoFw==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat01.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 04:30:21 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 7 Aug 2025 23:31:11 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 7 Aug 2025 23:30:18 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 7 Aug 2025 23:30:17 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>,
 <boris.glimcher@dell.com>
Subject: [PATCH 2/3] vhost_user: configure memory slots
Date: Fri, 8 Aug 2025 04:29:54 +0000
Message-ID: <20250808042955.2386083-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808042955.2386083-1-pravin.bathija@dell.com>
References: <20250808042955.2386083-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=676 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080034
X-Authority-Analysis: v=2.4 cv=erbfzppX c=1 sm=1 tr=0 ts=68957d5f cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=MDsIxxkBee3CUfGUG3hQZw==:17
 a=2OwXVqhp2XgA:10 a=ke5jqHz-1hQA:10 a=pGLkceISAAAA:8 a=iLNU1ar6AAAA:8
 a=vhdcl8Btm4WQQZqW7OEA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: egJGoIiH-QZ6e0sO4yWGriXWF4zTNzNM
X-Proofpoint-GUID: egJGoIiH-QZ6e0sO4yWGriXWF4zTNzNM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDAzNSBTYWx0ZWRfX6TUN8HS0XMHY
 TWF98XgY29R/otF8bahLY3Lap+BkkPVnxwMVfUrKeh1hos+uOLAoNanYVaHz+dNHg8JTcdhVfu1
 zT+md46ZLSuPzQkKhlcMexitor0Jbshpb2W5W6GLC74Ob09SrRsK17LrhMsgU+CVcPLwSaI5aFK
 svpd+B8XW8rJ1PaJcjwQAtI7v+x4LxtU+ws8KKKkE4OVzEa9O4V+GvLsfZLX9bDRl60fmUIFchO
 YgIf6sZChvuPDx7P4W81SlgA/R4iZEgz7EI/Um6K7aIl6Ar3zq0iTxHdPCm1ORXM8pXMaSKaXmQ
 3+G5+cZQ9JTvK3ltauhkbqFCTt4X9OjUf+zMrIyKQgEQsksdYYiz/AbsPjNZnT11y0ZCKUC8BWY
 NdjbzChj4+SknHS8qQgX76ldNev2kRkgAtQjPDZueP6r0lgwkJJxc4RdGOTiISka/CetEQvN
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=720 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080035
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

