Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58CCCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53819406FF;
	Tue, 11 Nov 2025 12:40:38 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id E987C406B6
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:40:36 +0100 (CET)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB52sCM014135
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=I
 y/BSR988r9ePt5TtnXMbnZ3nwi0Qm25mXnfJr/xq7A=; b=I6lr25ephCJ+a17ri
 HjtsmYqDCh54mefLe2QKoCUxAgjK0Si2cNHRa+VwJcqPQ8okb5j5lggVuvD3X2Se
 XZZu6+cFMudi23EkmRBPBmORd8l9EKXaXn5/n/jipAGaSp1D4RLol10ThngS0QST
 Awi58CrqT6R3ODQla1fXG1Vdo0tD0ND9HdS95iQWXh881MV7dAqC0QbcwUgHKUtK
 MGGUG4SN2DWMXHHBm84gPkx0C3LEESUE4V9totgvNeR2ucNjRkuMLasuRJdvub8c
 X7nB/Ow5PP7X0tCSA7n8VrMCwcBaB4lpL302LbWW8kxIVagdoikkTPLpS6iQYAyN
 sAbQw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa3dskwyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:36 -0500 (EST)
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6mbux023965
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:35 -0500
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4abwt24p8b-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762861234; x=1794397234;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Iy/BSR988r9ePt5TtnXMbnZ3nwi0Qm25mXnfJr/xq7A=;
 b=FtikL0/2wwY9RtNiSiGkuYdtHJTiYE1tfkAWY+PF4HFbXLH3dNUr2V9R
 wiZXjXFl0xCA5Ks6yHkJn55dibqNURpeSiWHGcJ2O20ePTbKEMRSkZsS2
 TwlsXJKMWMsyYBM8ak8cKCjPEYQrdyjxe6pgfQBCFiN4IHcD3DWBTmtRA
 wi3Us3m7PsBRrz7Z2vzQtrzycw+4nE0B3B3RnSagRzUg7k22MnsJTGXBe
 0o2HKX0S3Sq5CEZeEX3S9gRwbRN2FmwT9bZ0bySMvOUxAvpLTFgDWR7nX
 ml8OhVP8NNQkOCV2XNJKQLY3Z6O26YyCYA3dCeSlEdNnVZr3GudGwgb3g Q==;
X-CSE-ConnectionGUID: Gu3Ct65eTsqrsgISj0LkLg==
X-CSE-MsgGUID: eZcysDIfSBaHoiR+2dTeSQ==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:40:34 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:41:27 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:40:33 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:40:33 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 5/5] vhost_user: Increase number of memory regions
Date: Tue, 11 Nov 2025 11:40:02 +0000
Message-ID: <20251111114002.2902696-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111114002.2902696-1-pravin.bathija@dell.com>
References: <20251111114002.2902696-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110027
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3NyBTYWx0ZWRfX/G+Ed3M5R2uA
 yp9t8wQzoS0SU7pS8Rlb0upb/V8AAOeiM3bPWMknYgLHOCcGzwpE/xC1UC/sZtt0VffVfZGgXWI
 JYFkZObXMFw7Och8g13KA/vVOvZpRkhKslyCtg+LwWm+y3c15Ge2OFLPE4TxfWt/d2UFJZdbbAr
 zHqdIjhkzZyqDFVHsHq6FrJtJAAVuxpeg09nDv7xvgDNSRJmV7KncdoiorX5n++wetNJx7EPWQ9
 VGZIopmZDTcNFjLlmX0pSS3aU7GGgGL5KO+n886h/L7U400uVVWA9evcgwzi4hZlZrNaEZGKGFR
 /P7hd6n6bALU4M7wkvLTBKEc5MHLYT3kzdkGP9cqXBW0dR2hnFqBQx62uU4RehqEDXAKmr8rkz4
 ews66NMufS2tdP5TgWjXQ1KfWFVJ+A==
X-Proofpoint-ORIG-GUID: 8keuhqQHKwzEsGdjEfwINln1oGf5NSp3
X-Proofpoint-GUID: 8keuhqQHKwzEsGdjEfwINln1oGf5NSp3
X-Authority-Analysis: v=2.4 cv=Ud9ciaSN c=1 sm=1 tr=0 ts=691320b4 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=v3BNB8zNHenIr8u7HDwA:9 a=gbU3OgOOxF9bX48Letew:22
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

In this patch the number of memory regions are increased from
8 to 128. When a vhost-user front-end such as qemu or libblkio
queries the back-end such as dpdk with the message, get max number
of memory slots, the back-end replies with this number 128 instead
of the previously defined 8. The back-end also allocates that many
slots in the memory table where regions are added/removed as
requested by the vhost-user front-end. This also helps the vhost-
user front-end to limit the number of memory regions when sending
the set mem table message ar adding memory regions. Tested dynamic
add/removal of 128 memory regions with qemu vhost-user front-end
talking to dpdk test-pmd vhost-user back-end.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index 5a0e747b58..c6ad5b76d6 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -11,7 +11,7 @@
 
 /* refer to hw/virtio/vhost-user.c */
 
-#define VHOST_MEMORY_MAX_NREGIONS 8
+#define VHOST_MEMORY_MAX_NREGIONS 128
 
 #define VHOST_USER_NET_SUPPORTED_FEATURES \
 	(VIRTIO_NET_SUPPORTED_FEATURES | \
-- 
2.43.0

