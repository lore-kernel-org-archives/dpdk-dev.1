Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB258D3940A
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:54:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DC4D40E43;
	Fri,  3 Apr 2026 03:54:14 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 9D35C40E2B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 03:54:12 +0200 (CEST)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632KsSrx2394717 for <dev@dpdk.org>; Thu, 2 Apr 2026 21:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=Y
 i5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=; b=Kr0EFMH/4vMX1BzLw
 Z9DVbrAX8i+SGoo7xfMVF8iOeTPGMdwzvNZWVyCdr4VkdIew4NEOCVWxzd06Dsbt
 Pu53MgPcoCUSXIOjSf69ni36caNKY+ADBw4PpVEJmFdZoLeDplpTHpX5HjphEf3D
 Qc0t9PbgkWknablLInzrlxu8vF/dUJr0gdibWiW5dNnvazjH3QtuqQEXFwhjEcsH
 eiOwmr2fxMWRHpf8tmLyX/cBQdPyT/FVmQBr4joBKoSxdvSnEYIDkc1RUwtgNU7l
 Xu+Wm+NdQDurGkyvPkv90BsTyK94NOnjo/xMH0nNg/Ojn5d55/6EaKjRCUofuFPa
 Mqnsg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4d6b0dmphp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 21:54:11 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6331lbkU1305381 for <dev@dpdk.org>; Thu, 2 Apr 2026 21:54:10 -0400
Received: from esapsmtpat03.us.dell.com (esapsmtpat03.us.dell.com
 [143.166.211.152])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4da1s29j9m-6
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 21:54:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775181250; x=1806717250;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yi5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=;
 b=X40JPvE1k4f1uhWg4+PAnJuKt6SYHllx3VAYcPkcztmiURHBz7XXQNRD
 0iECel3Xp3W3HPCkM5JKrHuX0ygzFknuaNOZKzabkMRPApP318XLIxhsg
 gVCdYfV9IhDqY1Sy+8c5exQyEsq6IAkziu7szqkgNTtifnOn+aBc9GjWw
 2w7FxGspmuC7xA7WjUzjPZ8qoEv0rj5YrnBLM6ccUd7C//iyJeWw1pB/Y
 aU1AYkR+RRpEP39kQClo/XtD5bjAOWpLdD9rFLRI8cVswDzO2/0yvW764
 4r/CwhaN2OnbZxxH45ZKjNnBbJ+ldsi+X/JDQbwEjFTGOsBpx2PmLOpQS w==;
X-CSE-ConnectionGUID: zmZKQ1WES2W/NqH5Mwqw6A==
X-CSE-MsgGUID: SPg2V5ZXQG6IpEdTi5Ujrg==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat03.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 01:54:10 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 20:55:01 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 20:54:09 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 2 Apr 2026 20:54:08 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v8 5/5] vhost_user: enable configure memory slots
Date: Fri, 3 Apr 2026 01:54:34 +0000
Message-ID: <20260403015434.3124102-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403015434.3124102-1-pravin.bathija@dell.com>
References: <20260403015434.3124102-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030014
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAxNSBTYWx0ZWRfX38DgU5HqOGmv
 e+yesGcEaWv4GFwUPeLPOEGWUsjVtL0HeVR75AkVQ6fWqC5jJ0kf6K7lOnp5myRscSVOuJFkYJy
 XdX1qrbZeIlmwj172631EDUv5tMqtmCU3fs/GXAAnre+opTPcS0l7XhvTgboAZ+9+/hy1hwUxYF
 m/bwrb8XKydqliIchMECxCGboipQYSUR0W5gvEE4chGGHT7qs3OshRRjPZNEA97IehNlsHEuVd5
 F6M/JGz1CgWfGHNTP1P91nAmhjJo3HXf6NIKgGHA6HUgITUusHuy7wcdy2uvt5qCUn3gIvZwse2
 s+bnM/vMdMHW5ai6Aq7cITvijX7myEUwtf740fOhDkfgN3l8dV2e4kRkolqbGZN9H8MtP6VcBdi
 k7JaPKB/tvU2Ca0R219A3eTvNbje5hoY71M9RAZdnH8bcENbwuCoDdzKj7iwlqQYh/+jZ6lK9Vd
 hnz2Pov6+zAIhTOr2cw==
X-Proofpoint-ORIG-GUID: F8yZPR3kajKA5dxwgjbcJNenCTXLGx7q
X-Proofpoint-GUID: F8yZPR3kajKA5dxwgjbcJNenCTXLGx7q
X-Authority-Analysis: v=2.4 cv=Kd3fcAYD c=1 sm=1 tr=0 ts=69cf1dc3 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Exi4HLWdEtKd1bGGvbjpxg==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=PpEg0BoV_A2aca28hXd0:22 a=iLNU1ar6AAAA:8
 a=-L3Ti0Wm1PsFXVv1eAcA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030015
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

This patch enables configure memory slots in the header define
VHOST_USER_PROTOCOL_FEATURES.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index f8d921f7f1..5a0e747b58 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -32,6 +32,7 @@
 					 (1ULL << VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT) | \
+					 (1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_STATUS))
 
 typedef enum VhostUserRequest {
-- 
2.43.0

