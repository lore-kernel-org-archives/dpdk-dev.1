Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ED4EDB7CC
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 07:42:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD20B40653;
	Tue,  7 Apr 2026 09:42:22 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id D4F9D4060A
 for <dev@dpdk.org>; Tue,  7 Apr 2026 09:42:21 +0200 (CEST)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQNxP843411 for <dev@dpdk.org>; Tue, 7 Apr 2026 03:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=Y
 i5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=; b=me5RthJOfNvHCagl/
 uOfSVrdzrmmZG/3c9iyn7Lrf3AgEcNUp0vNHYGQoQGKy2kZiIUvdnxCueOfKJ1ki
 JmlL/Qn4lhjMAOgfDodUQduywrQg1+6O5dwU3uKk9p7YGlzZgvKQu+m/WgbOYDuq
 XVgoNcj8aXdflJZZ/sQBHZ4bFTJpr9BG9abuHeSGs5YslFhdUdOk8lJ/VxCbb71t
 lgLiNbkXAy2j8RBasWHTWn68uSu6pI6D/uJ6mShV3NjN8j8sbDlLsD/5nPJz9gYi
 9BGOfEh5YSSEu+fwcuIgPnL7gyNgUGGAcXADKDqxVGxHk50F0xVHLfXdw88e6YVS
 wfE9w==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4dcmrf2c6v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 03:42:20 -0400 (EDT)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6377WMco3907706 for <dev@dpdk.org>; Tue, 7 Apr 2026 03:42:20 -0400
Received: from esapsmtplv04.us.dell.com (esapsmtplv04.us.dell.com
 [143.166.203.152])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4dcuw11ndw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 03:42:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775547740; x=1807083740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yi5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=;
 b=Z5OXKm8mQMZymMZUeB2ePleTIU2pAT3FTBiIAlMc+0+SiVcjmLF5S5fS
 zt519WRJoOx/olYl7jribatHjE8iY3j+3SGVEp36bSN0Gx4dlBzqTDpFk
 IjOc8iTCjq44PULB0nP141/6ePz4dEhdZQZqphEN5qMEYUkIzk3AltgnC
 AMv5JrxnjEasLgtnqKTv23r9Ex5YtriKOyd0fKUpTTVlXYBOQ3zFt24fD
 eO5HWUgkzjOiyapt4RJndOtFFTDYE+S4IZ+X1DRN0qmzjyhecQwhuuIaM
 f7tRwo7/gabwrDGKIcYddh7AQ0UUJHuvXLY4DTV3rge1UD3kBUoPHaOTj w==;
X-CSE-ConnectionGUID: 5RVk/9FxSGeaP3zfXFYZMA==
X-CSE-MsgGUID: nKHvjt/ZQIaqg41Z6SkdoQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv04.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 07:42:19 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 02:43:23 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 02:42:17 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 7 Apr 2026 02:42:17 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v9 5/5] vhost_user: enable configure memory slots
Date: Tue, 7 Apr 2026 07:42:23 +0000
Message-ID: <20260407074223.3876085-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407074223.3876085-1-pravin.bathija@dell.com>
References: <20260407074223.3876085-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA2OSBTYWx0ZWRfXymiZs+kjkhkY
 MToV/q9QDa20m96kJZWeusIimXCgte1zJkDmQQAZax+yDqI4UbN0SEWfSjbmEmlTQDVpBNhgDaN
 eGUhty9ojbmnNttBrhsUlelzd81aAkH/jCq5DiyEhdteGJyha/nceeSMArISUK3XOp9HH4GSoWH
 6vv3KKTWVkOGdRWKbL/moIyzxI4SJcQ5DoLFPOujJDH7OHQrcS5SaaWZnUzJm5zyI7/mJXVJiYb
 NHeUUqdFhbDYTaOISp069HIBF9tf077lgqBJPC+ODkGeofR4YP99MKOfZXkS4MZQUYuPrjsxLAi
 gD7vwy4XpZAWWhGxFVrW9hrnhZCBRd1KF61ZvMm7OFZFmExV2CtRRKzZ7zToWYciXc1M5cLGRhl
 qdYwIiLjGe3hx+c4QzrJa540rP0v909JVYP1znsqLXSG6ujjN3gKpI/7+PoXD5kyDpYBjetwdHC
 HUMWO7mMZ974bm7hiUA==
X-Proofpoint-GUID: 3T4BlqQNZhsocrh0wew8VpHrTzE05PSu
X-Proofpoint-ORIG-GUID: 3T4BlqQNZhsocrh0wew8VpHrTzE05PSu
X-Authority-Analysis: v=2.4 cv=E/79Y6dl c=1 sm=1 tr=0 ts=69d4b55c cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=XtseytAk/c9oG0Kwoj6KRQ==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=sEWawkeXllE7TocFc0N_:22 a=iLNU1ar6AAAA:8
 a=-L3Ti0Wm1PsFXVv1eAcA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070069
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

