Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9785DCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:13:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BFA64026A;
	Tue, 11 Nov 2025 12:13:32 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0DE9C40144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:13:30 +0100 (CET)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB2qBZP023628
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=I
 y/BSR988r9ePt5TtnXMbnZ3nwi0Qm25mXnfJr/xq7A=; b=JjkdPVbJSkCINuabb
 Xfollx7BRU4iFkKSDOa+yOA9hhvNK7K5e/d/ziW1R6pfmSjRE+LXPKWZR9kNojCZ
 xMU0i0wa2QBgmAwHyW5huNUqRlqoIuSHxRnPYga9K3FJf+3+jHEuf7P1OptsZ4Ba
 Zs2RMT8qQ/yyawdrkd8aTFD6wDGm7TJcCsQD22YR31VS2wFk+Zk2dlPQ+XUmf8uh
 cRtxqM7k9o5GmFRHu7I5b98PdLHgPTaffOU/+bSJjNuLXIM4cljIIeVaTOP0E9iD
 o9ZmQHU7M+3NL5RdpP+0izKJqkrX+eKQfwBIFrFqo6fvBkH6KR3stUXCfJNq/nyD
 0o/4g==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa2rpkum7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:30 -0500 (EST)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB8JmIn034608
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:29 -0500
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ac1hm9tgr-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:13:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762859609; x=1794395609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Iy/BSR988r9ePt5TtnXMbnZ3nwi0Qm25mXnfJr/xq7A=;
 b=qDM7jLHCH1sMGeBnUvGRhGOIgdAon2Ht3ql3IxmvmrCAghO9aQQqjeSb
 fCBrhLSWkruFpHbqxS6xcdYM+14nd2bzTJpWnc2R58PLK7bJgMYhhFzM0
 E8qZcN0zoPIuwhyi/dLsj7P7L0A97+kXxjsjP9VLixOG7eU+2rpi2EMdM
 HZ3hb8gYSXhyHLP6cSXwo++9gO+eMshT17nx7P5eATklVnfbULUE8UOhG
 d0zU/sb65Wb4XwkWOIagzZmt+SdWzVHaLFzyhL3P+SAL6zXq/8KwAjBiW
 5B+LsfuoGM9lfxvllOpc3C5Uiz/t6l7rnVMC6dez4umEdt4pV6Nxrzd/8 Q==;
X-CSE-ConnectionGUID: YsituTd1RaqiFGDKqhWpng==
X-CSE-MsgGUID: wCqJKC3vTI+Ks77KW6HV1g==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:13:29 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:14:21 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:13:27 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:13:27 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 5/5] vhost_user: Increase number of memory regions
Date: Tue, 11 Nov 2025 11:12:35 +0000
Message-ID: <20251111111235.2902146-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111111235.2902146-1-pravin.bathija@dell.com>
References: <20251111111235.2902146-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511110064
X-Proofpoint-ORIG-GUID: rM08fTtAKOu8aWFe5DzSF_J19SJ8DG5m
X-Proofpoint-GUID: rM08fTtAKOu8aWFe5DzSF_J19SJ8DG5m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3MCBTYWx0ZWRfXzVZrX6K5IVzf
 eqB+rYG5HbSH/V7Q4Feag51jXyHmTMeb4nuN4u97yhoLTDYkPJHBVb0CAkVOg6U/EW5wIFSmTU/
 SYs2pMXQf+wZ0l4paNeE3bdOtStIEukI8QQ2ugmSwNDHlfKxbA2g/VDf8jZbgupQ2D0NUyTSwWK
 u9UTrTYyLzPVxlQzXuzT7unN60JSp1QUeeEa8wtR5n7LKPoYJk6kmrZduUBtREOae/qZUejlCGi
 0Sk60D5XV2M01vA/JexvEf0YDX5Yrfd5/rWTv0iWUbF+8QRPmh/FqXGjpcfweg2/Un8LIQ2hj9m
 PtiOHEYYMMl15MnavwFkxkG0WLCTXX1iJT0AmxBGlxVxZlUUJRhTx4PNjYzG9H7MycHOAnkMbQE
 wtoNN83wofwnLBMW/2K9e1QzsvCwww==
X-Authority-Analysis: v=2.4 cv=UqVu9uwB c=1 sm=1 tr=0 ts=69131a5a cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=v3BNB8zNHenIr8u7HDwA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080070
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

