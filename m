Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCD4CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 02:20:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64AA44068A;
	Wed, 20 May 2026 04:20:44 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 399D740691
 for <dev@dpdk.org>; Wed, 20 May 2026 04:20:42 +0200 (CEST)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K0NaLD1662650 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=e
 y04WpQsF8hb1l0N07TCj3FTdDC8+ccfibjdJSJFLcQ=; b=dytmyLlLqzIZSmlBL
 rnOu4xVMca6uNZ+frAGYCsYmpDFx8bQ3Mx61sbAOFkpylQodAjxaDhnLHmO3G3vD
 PhTp8veGZx0QNg3EQnqDFCK9olPTR8zdd0j+E+5O6BXHoaMVM0Ij7lFoJdPDulNT
 G1HAB+IAXGreK+MModx8vFL/2g3YKdFQFyxUeALhp63yWtUYQvT/l372tgZykfEm
 qoJpk3bkYtrQ9EqNBqTr5m4Sjc7O9bfRUm3cEQHfVnJiDbGuvVmFIZJxbWXMhxln
 DzWDIhalqMyBJwCQn1xowDYsXeFbgIUrmbNeRFN3ByK+I6gEDXbPJ+AscK9n6hEq
 kMfew==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e6kmypbdp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:41 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JNbbG82927618 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:40 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e8x4dvbh9-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1779243641; x=1810779641;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ey04WpQsF8hb1l0N07TCj3FTdDC8+ccfibjdJSJFLcQ=;
 b=hTLhWpYy7eufhg8BPv/sd76U95lbAeuY2V9BefzRERElyM8SebO7SJjG
 fiYuiGGtcPgNpZB3xHy9ZsZRYcb3DR5yInltPOfeF3OGURuojfCakvq1n
 XrNUnDhGpY0s398svbGxioss/fX7emdufdGiIanjRZOvjnug2v3yRKpon
 wknM6YlKjYVMUTcdoRsVvEQ/JsmZ19iZ384bXXPChQ3ZCXCHx15WlCyOr
 ko8uJtj9a6kF1J7Tk0gRzvM0AH98QewKCBJlmgxuhbHAOS/n752AtiBZR
 dOpz+fx7k6reLwADFNq1E6cHBVlOXTBn9N8FNL3B4iKsxM9ieQ46p2pCT g==;
X-CSE-ConnectionGUID: wVYOVlDZSbu9IZMV+Hi4nw==
X-CSE-MsgGUID: SLo0Hi/sS4Sz/tahZ8YW3A==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 02:20:40 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:21:30 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:20:38 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 19 May 2026 21:20:38 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v14 5/5] vhost: enable configure memory slots
Date: Wed, 20 May 2026 02:20:12 +0000
Message-ID: <20260520022012.243619-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520022012.243619-1-pravin.bathija@dell.com>
References: <20260520022012.243619-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200019
X-Authority-Analysis: v=2.4 cv=b8uCJNGx c=1 sm=1 tr=0 ts=6a0d1a79 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=sEWawkeXllE7TocFc0N_:22 a=iLNU1ar6AAAA:8
 a=i0EeH86SAAAA:8 a=CPuvAHPoAAAA:8 a=20KFwNOVAAAA:8 a=SCJ4Fr7V5OtDq1HSOwcA:9
 a=hlJyneSgMmFPbskH-t2w:22 a=r6J0Z2L7KMegjY60bkqS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAyMCBTYWx0ZWRfX4dSqFmH1QwQK
 07TpMZN1nWpd9p7yZJdpfvXlehEbV9weJqlmU28VHfS5mVCxrtoQq+ugaAyfbhY1qoxS7NVMWvd
 PmQRQiUX5/PKmCPHEeTiXYU+Ay+w6AOlgIJ+5Kht0wdEEmWhppXb5DyzAjjhy20pCMtQt7KNh7t
 6cdBgvt26BI1nIJ5s356LfRqFZZXyowEPdKfRG5ZS+NkNvXRbgvlfcn9j+/EkQxosxMtczoRZTQ
 F1CgbShT5yl0egf6WVZzqLw1rPOaRHoK/rOnYiQybtcGzpeTGlCxtl4b+86Jqiw6utjCtbDwb9o
 wc53HJUsi/Dv1gh+Imjwal3cIjuy/QuWJEZMZAmK/Ejxuywn/dNwPzgVtesRUjFwF4nDdZ1JWxl
 ovMPcbf03U9mEKtlDw7N5zU7Ri6S3usmaMnSosOi0airtDXGJM1YIXXsGp6e+1ZMKOPf9LcgeYp
 vhTyPahxgaBc38caGHg==
X-Proofpoint-ORIG-GUID: uq4IQuZOCiFwQBpW3IY3NieCvSm6Ktlt
X-Proofpoint-GUID: uq4IQuZOCiFwQBpW3IY3NieCvSm6Ktlt
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200020
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
Acked-by: Fengchengwen <fengchengwen@huawei.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
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

