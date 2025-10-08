Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13D8CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 09:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F21DE402A0;
	Wed,  8 Oct 2025 11:05:16 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 24B6340297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 11:05:14 +0200 (CEST)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5988ifG5027426
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=ZwkVMrspH6Xmr7ad5G/BlHI
 +FrlbZfv9Y2IwQWONjHQ=; b=nclI4EltmHrTD5LW8uWV5RjgcEEn0fMKcn2nLmy
 JNKc5lWXacy4qZlh0BqemCYIl2bWDyUeen0y9oNfEvM9kpkgM1gEsvW2nl8gKW7y
 UWtxgf845XgIkn7SOnOSGasVGZasIIK557VlddmbMqEOX1TOuK9wa05WeUVlCsPl
 elvyUphmgyeWHdEVu743dsKTbOaWYTHl+xGycSe4m7LR+iwKBUvZ3mfVW4KqC3p+
 CEEKbtP9D4exhUr84n8vkiwGc1+Fk2iuNvGyj38x0W9G0hg03+ovpOC1guHZeWyv
 v4u62+P3lyKcYsPXMkyoQ3vR88Ep7IU8fg7J+0dgDIbGKmQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 49jxwhs1bs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:14 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5988KoEp032498
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:13 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 49ndqfvkew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1759914313; x=1791450313;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZwkVMrspH6Xmr7ad5G/BlHI+FrlbZfv9Y2IwQWONjHQ=;
 b=XkHcUb67j9Vs4LebXiy/Idk5BuxE2zuMOMayk5WWnMidGOVNUIFSGQBm
 yvC17wMAgIeNJat8THJ5gC080aa+7RJaAztptRESkpa+mZAA2/rEar72I
 NUG+Yq/4ydoU+85cARiGtJELZQDl65ga/1UXNz031kdbKHO9DrYf4rD3v
 Z9mphUejshPdVw0aetNJ4cXH/qJ5AzVqXf6qXDZoQKUosyEP1DOEnXZev
 cmftVIe0WocL0lzO0Ft2v40lVzovM00gRoki1fwJkX/tFltkLafL6aew8
 xVV8L0wBiPRxCiSKIV6mJUzOJyZgAL1Hd7RkN1xDLze6yPrXfiIwCjpl3 w==;
X-CSE-ConnectionGUID: VrhKsQ6NRcClEBPBKRdLag==
X-CSE-MsgGUID: /4KzailNRkiDwE8cMu80vw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 09:05:12 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:06:12 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:05:10 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.34 via Frontend
 Transport; Wed, 8 Oct 2025 04:05:10 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v2 0/6] Add/Remove memory regions & support funcs
Date: Wed, 8 Oct 2025 09:04:38 +0000
Message-ID: <20251008090444.2689652-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510080003
X-Proofpoint-GUID: O0ITBWv0bT2XY8ydbaWqIYtMh799u_nx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA1OCBTYWx0ZWRfXzrCHdRFw4l79
 CpEXyysj3RZvkOOXbLzZ3aciMQ5XI6hqYHOyxWXOwqN0CX7cBvM/BMPSeYVAxKwu8zhWgkMCSha
 1QywxaV/1uPqwg5ECjvxJWVhY39n2yCxYia0Z4gPjdp++h2R3C0oHUzD5waSEcxe6BVmwEdfOfl
 KVoNcYqrNcqqDv05S4LlI/NdcDtqdCNgigNmfLb6Cv6n5Zk/DW/NNeCK0xBbl2JSmb5nDNrgDEJ
 hIkPCC59kT7kZJ4vSSkYuXGMSvWskWpjF940kQqa2y597WZVQ0phT7ekcCxtia3qgRLwhKQPTZu
 whtKub0zzupUjaMd3Jl2pvk/4UH0nLKYYLxqSN6BnKDBc4ROqkhsv9JibZKzv/OmnxkPwBBy+on
 mXbsD+H/YOcJw6gW7DUDDguka2IfVg==
X-Proofpoint-ORIG-GUID: O0ITBWv0bT2XY8ydbaWqIYtMh799u_nx
X-Authority-Analysis: v=2.4 cv=ccTfb3DM c=1 sm=1 tr=0 ts=68e6294a cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=x6icFKpwvdMA:10 a=ke5jqHz-1hQA:10 a=h24xheAe2T7KXywDFcwA:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040058
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

This patchset incorporates support for adding and removal of memory
regions to vhost-user back-end from a virtio front end and the
corresponsing supporting functions. The max number of regions supported
has also been increased from 8 to 128. This has been extensively tested
with multiple instances of fio when running with spdk and qemu performing
add/removal of memory regions to vhost testpmd.

Pravin M Bathija (6):
  vhost: add define for configure mem slot
  virtio: increase number of mem regions to 128
  vhost: hdr file changes for add/remove mem regions
  vhost: add/remove memory region function defines
  vhost: support functions for memory region ops
  vhost: changes to function set_mem_table

 .mailmap                                    |   1 +
 drivers/net/virtio/virtio_user/vhost_user.c |   2 +-
 lib/vhost/rte_vhost.h                       |   4 +
 lib/vhost/vhost_user.c                      | 333 +++++++++++++++++---
 lib/vhost/vhost_user.h                      |  12 +-
 5 files changed, 306 insertions(+), 46 deletions(-)

-- 
2.43.0

