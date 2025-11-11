Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB2CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:46:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DD0340A4B;
	Tue, 11 Nov 2025 12:45:55 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2F81A40A4B
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:45:53 +0100 (CET)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6fOUd010942
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=I
 y/BSR988r9ePt5TtnXMbnZ3nwi0Qm25mXnfJr/xq7A=; b=MbdQ3Hl06WMWW6VF+
 fMms92OMCL/WQDzG7iA24z+PFLXOz6oJohkX7MWKB5uCUJzt7cRaD4EZUDxYb85T
 CaoADuKy4fGtXn9zymKyTF/RK7f/cHBbeiI6rYN+UpQgPVoPAtNVuAj+st3pFekZ
 Yjt+X8L7p/KCbiAc0ApL2DJarmyAsaVY5qcfLfiqQGcbnFNSlyl/D94uLB2e/ZWS
 Eb1tOBggfNxSDtXZlK3FoW1Wx4OM08m/NiBqqNuKxS56o8l2jFk4Rx5GvvWLXRQG
 aTlQdg0XQvhIoE87RdQMNBquPRC68Zhx4PRjW/qjjqQZHSvtWfzcLgTiZB1Z8b6u
 N6K8g==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa1ydm3cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:52 -0500 (EST)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB8lnMR026022
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:51 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ac1xphwr9-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762861551; x=1794397551;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Iy/BSR988r9ePt5TtnXMbnZ3nwi0Qm25mXnfJr/xq7A=;
 b=q5aKRJeOEo3zzQbyeNRmamzKazlHrsi+5zVBSmu8pvdreZMI8OjA/Weu
 k8zec6X4EkdSTYCZyBGjKDZ0QTbi6wO2EXYhrToF9x2mLS+cO8lWgyhPI
 DYBuW0LCtPueqfwBWErSazpgkJByz44K5qRC4ksxBbts5fUNsDEvphRwj
 FLW8pI6LWeaUeuYVFN0FsbgriTkBUCUBvDktZ6WUY0rx8SOGVjIEf9ZMh
 Q04UUo8aJjeNJLyJj7AlEJX6Jwa+YLcbhEsv8TiJ8RwJLaj4Qw5ah889x
 Q9e0CtgxKC97sWnc/IpMnBhe9KcDqlN6qLd+Ut/3SG55d/8KZ/IR30Z9C A==;
X-CSE-ConnectionGUID: BJYt15+zR7yMTpl45RGdGA==
X-CSE-MsgGUID: 1wlnnT27SrWtQpssVD+zlg==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:45:50 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:46:54 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:45:49 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:45:49 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 5/5] vhost_user: Increase number of memory regions
Date: Tue, 11 Nov 2025 11:45:21 +0000
Message-ID: <20251111114521.2902867-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111114521.2902867-1-pravin.bathija@dell.com>
References: <20251111114521.2902867-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2MyBTYWx0ZWRfX7fw2tBnk2cUf
 i4Kh2cb3HKsXeEE1vKCsmJh0XacwriSf5sXFJEHVA1L8akw4pIFknpC2wwjlY8dZslABW/QDQu3
 jT0mZWmhDJprSFcdnsM9t9qD9aAJe00eM9VdSvA00mMOATJ+tWzv0UbJi1L5yg4lkG63JJuvh9s
 m8zJN7KVhMrV7DHL1YZtEW4Hn3nOif3UKefh8JtGJHKbsRhArigUV1nc+Dfc2VN6bhegkf02QpG
 otR/gCmPuQWik+ltqqgD5Q5uftppTIVxNDJbqppNbjEH8z2jIxcvDGRaPx25nDOkJpcqva70F96
 jNBfgSAY+zsWgS3WkR0nMKuLd5c+sjk4iPgGALZwXTeMeC2OEvDtiH+Ufy/XCRIqrZjUDu29KHd
 sLc8OTBGlXFRsWfi2c2JszvjohYYtg==
X-Authority-Analysis: v=2.4 cv=fI80HJae c=1 sm=1 tr=0 ts=691321f0 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=v3BNB8zNHenIr8u7HDwA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: 4nl6yLwltxPPhfORAoXllcDc4WpgcpJx
X-Proofpoint-GUID: 4nl6yLwltxPPhfORAoXllcDc4WpgcpJx
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080063
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

