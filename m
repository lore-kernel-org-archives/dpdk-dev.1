Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE2DCD8C89
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Jun 2026 02:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 019AC40665;
	Sat,  6 Jun 2026 04:52:31 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3C91E40671
 for <dev@dpdk.org>; Sat,  6 Jun 2026 04:52:29 +0200 (CEST)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655L1iq91973449 for <dev@dpdk.org>; Fri, 5 Jun 2026 22:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=w
 J9Pt/hsOn8QghHFVQR6VjG7J9F4pOKtAPLIvqBGDAY=; b=O0f3cJ+xNn0OrmkY+
 vN8sDLe8kfD80QFNVX5EPGvC7vj93dqFTeT6dpE6ONtTKi0t57iDuDSPhbCJbXPI
 QFGB9KPtWJECpS12vxSWKDUEv2WPPEcjn4ah6ZHQIrndwTAnEoeT+lT8Y3Rec6qp
 +H/qoosXLJvy7v10ZbBUzRoqgvEJeIHWdZVi1knTuSncgZ6vUKi6HzEGIu+VNgWp
 gMZyLsFUx/tt+EsCS9LPLkLb8qjCm3Vmhs0R26A4rKdRjvxGkmOtK7gO/MNf6fsc
 m0UZLGeU4TtkPHwWK155kHLmiVsw1cB6T5fZbDT36XMwzHRQ/7nscpbwfL4QjyV9
 ZiKUg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4ej75kqnw9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 05 Jun 2026 22:52:28 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655MFH0h2491284 for <dev@dpdk.org>; Fri, 5 Jun 2026 22:52:27 -0400
Received: from esapsmtpat04.us.dell.com (esapsmtpat04.us.dell.com
 [143.166.211.147])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4em6qrk7yb-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Fri, 05 Jun 2026 22:52:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1780714347; x=1812250347;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wJ9Pt/hsOn8QghHFVQR6VjG7J9F4pOKtAPLIvqBGDAY=;
 b=XbT+ojVMAXD9SFe22MRCLQHUu+8tcy20WnCOBlvoIPRpRWhaCNS0ir1q
 AL/1hgSsRTpyd9vSyx4kFaNdFO2oll6/CB60ut2YqHABFUyPPaOCeKSq/
 VX9GBrSwbOXQ4ojQhkyt0FEUuRt8iZmlgaBw0Pk01DspCeHXPr4R1/Jcx
 9Tzig+J+GXWzR802ypHiwh+Hci+2a4amjR9ngGQLhnr2vEGRnIud2XgXU
 eg0nI5INpCdGUgEm4jOAVW8MHJtC22YfXpUEj029ceuRkg0I2MR6wlAUo
 UFvKuwPSzqpybK9moUqYuirUi+mmyNS7bvWenL6N2nB9Vj/rOSWt5Hawv A==;
X-CSE-ConnectionGUID: 8+KTW2a1T0aa2+UqD7aSEQ==
X-CSE-MsgGUID: s+fI1vwfR3y9mQ7CYOJqQA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat04.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2026 02:52:27 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 5 Jun 2026 21:53:29 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 5 Jun 2026 21:52:26 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Jun 2026 21:52:25 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v16 5/5] vhost: enable configure memory slots
Date: Sat, 6 Jun 2026 02:52:11 +0000
Message-ID: <20260606025211.1082615-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606025211.1082615-1-pravin.bathija@dell.com>
References: <20260606025211.1082615-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060026
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDAyNSBTYWx0ZWRfX2jG0aBJ2xk8d
 ghoJbEXCdhjTafdP+UBVfhK/lQNhHyyNbNy48tVkEeG6OsSmvbvDyozSppZCtZdf1GWbTDp3CSu
 31szkQRRtJ9LfG8iohJ0VtIzVyFnFX9sskC3pm2vzyykqGIytCIMDV1ZqPgX0i3yUcCMMOuKM+Z
 MyoZkX9rvZ22RUv7kojCkWefvzFcIOO8H+yMI3+KQG5NOcECDJTyB33GSeVap5jsrdNyM/7ZV73
 kmMuZrzHpbF1xUULMOYKTgrvpeahZPym6bzhGLulceSI2MLhMwnyoPFuERvAgsC2JBWZUQe18Ao
 0K3PPbCcVuX7S+lue5aVSYZvAG1FaOFR5w2W5XMRkNarJf3/P5PsyVq/UJ0bs33RAuedjmKy/5w
 g6LjXxuaa5HeNAa+zbWITNyfd0wG40Jjd6lofjzsmHSaAucwfJPnmC+rkNWROaPpEmYQvvADpAK
 CZhbjsTBVX98SQE9kHg==
X-Authority-Analysis: v=2.4 cv=d6XFDxjE c=1 sm=1 tr=0 ts=6a238b6c cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=xQoiRHjKKYbJmV+sD1MyuQ==:17
 a=FelO9ux0wxsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=Qy6CKLcU0MZ4grw4BCWD:22 a=iLNU1ar6AAAA:8
 a=CPuvAHPoAAAA:8 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=rZn8xLF9xNrzFNIxwagA:9
 a=gbU3OgOOxF9bX48Letew:22 a=r6J0Z2L7KMegjY60bkqS:22
X-Proofpoint-GUID: lq2jt5rVthvlaZG96W7u6YYKYAD6afPQ
X-Proofpoint-ORIG-GUID: lq2jt5rVthvlaZG96W7u6YYKYAD6afPQ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060025
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
Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
Reviewed-by: Fengchengwen <fengchengwen@huawei.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vhost_user.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index 6435816534..732aa4dc02 100644
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

