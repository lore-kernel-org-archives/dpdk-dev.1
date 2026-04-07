Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9046EDB7D0
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 22:41:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3A9540668;
	Wed,  8 Apr 2026 00:41:39 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id E3CED402EE
 for <dev@dpdk.org>; Wed,  8 Apr 2026 00:41:35 +0200 (CEST)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637Lm8R94000694 for <dev@dpdk.org>; Tue, 7 Apr 2026 18:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=Y
 i5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=; b=DqcnmRi2LyGen5ZYC
 fozwxt0wjW0AnHYEKX/MNU1dmfeWbIxloijvcghJXjBr0FD7gv8x9/mdVfsxeZ+I
 03snDPTz1euhHaiEpW1ge7RCCAnd/CjgkznE+VdTFrzZUDfYYnZ+TCLpio7qaWkC
 GA2F98kxirZeXSPhJlYXFxtM9G6ipKYTrc+nkPfD0425+ma/f6u2eJjJkbB97/Tp
 +Yf4Oxs7FKcV6RT8PvWiGAwVF6nh/YSLr5ALuTStIWoeUlSQn+UpXE1uT2c6bxcK
 gcaDh5cdyJPbuCpTzDXK+mhEPDwC/iKbikk0AFRAnq4aX43yERJMqCBsLBzSBIpE
 dNzVQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dda4x07h4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 18:41:35 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637Llsu33938245 for <dev@dpdk.org>; Tue, 7 Apr 2026 18:41:34 -0400
Received: from esapsmtplv02.us.dell.com (esapsmtplv02.us.dell.com
 [143.166.203.150])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dda5g8mah-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 18:41:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775601694; x=1807137694;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yi5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=;
 b=PdgmhKEzHQcZFGGSiWfBx8tRSzZm5r7teBKEN+cgmvZiWLj7hUwVzu5V
 emNcMnrPQAhXlGjbGe7vrtDzfx/6KZjGJQ10sOYVJKtMhF1GV7SMVKb8v
 yh+8rHQtvL5KNPFx0wG2ijgrEXDqtpHZ5jpczS/HvDqNw5icIdEsfOv5R
 g8W7o5p32hyZz7rvlyiwsns9yJIlGhGKM4SEwuhH/hJ2Pz6sN5wUdeHNg
 NaOtJ6kapQFhjgHSsWb5sXJS8FHmww1eKCRlpsSkfelt/HUNo68R3XYYS
 fzHJMvA2MDGl6h6MPsVkFK+IntqCHIUQsP0Q9MQjfSPTBCkLtsGbfQ45e A==;
X-CSE-ConnectionGUID: H4+fZUoKREaIteacJv4eNw==
X-CSE-MsgGUID: Bhj8itycTTiTZZ7kF1ubUA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv02.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 22:41:34 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 17:42:26 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 17:41:32 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 7 Apr 2026 17:41:32 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v10 5/5] vhost_user: enable configure memory slots
Date: Tue, 7 Apr 2026 22:42:05 +0000
Message-ID: <20260407224205.3910803-6-pravin.bathija@dell.com>
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
X-Proofpoint-GUID: OhI0udPDQ3E4H0nO5TRJ05P2y4QvUw8_
X-Proofpoint-ORIG-GUID: OhI0udPDQ3E4H0nO5TRJ05P2y4QvUw8_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDIwOCBTYWx0ZWRfX59Fbp6koUK1B
 i0vrwPpKO/BfrXkW0tQyE054mKuWymkDQc80rVtK3ikbYL6Ge6/tGmV7zplS2oByMZGtbMXMqyf
 Hi/WF9qHBIyrqojS1WBuw0z5emKkTULgFd5Xj281Rp++wD7BPgwh53fXnijII4dkNG999drPzJC
 OC5vQW3rZUblsTj3oDcBzCMoE8JTupR2GE+4zVTCFETOPg+bMOEc03e+7dYc/OoXjW/ySoXdyyM
 6qqjr2K2n4Nq35yvc0HqyqDKHMdzuwKeNLFl8qXt3sAOQgKJjBRi0UAQwVxjeMwvNfbGp+ydZ2U
 1FXT5WW5kw2DaIjHc0aausQswSvEvivaYieBoleJ1sl8kdUaIxdGueHcgkGf7mRxE7H+ooUR7Nq
 oMIfXPWeFlt7IEPtYM7kuMO95E/OeR68nh87/lbpKZPEt4129TipZlVd9K1I31++NquiEvbMExG
 NArrTmMFAaLXwneDl4Q==
X-Authority-Analysis: v=2.4 cv=RcKgzVtv c=1 sm=1 tr=0 ts=69d5881f cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=AlKjE2zswbbG9QqlC8cQbA==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=fe1keu9KhAX5AoWrZvs2:22 a=iLNU1ar6AAAA:8
 a=-L3Ti0Wm1PsFXVv1eAcA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
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

