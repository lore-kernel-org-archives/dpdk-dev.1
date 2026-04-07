Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C93EDB7CC
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 07:41:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D96D4025A;
	Tue,  7 Apr 2026 09:41:50 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 028334014F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 09:41:48 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LS1JD793867 for <dev@dpdk.org>; Tue, 7 Apr 2026 03:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=4C07BMsLHmUIK1mDMnJ/4/H
 nA4LMi702w5T5qEJST5Y=; b=ogcEn6EsnmR6y61jSa/vOu262sEYZFyUDn/NXvK
 9xalgtMBFjL7iYRJAvwhkRlhmriFXevWW3/V7u/ZhCwTauHk1i+yb+fVm1ZF4NtK
 MbwrtwO0AR+LvgxPfMGJjpGoE2Tb33UU1Rj0heXdlcJN/muk5RvMukIBAEqaeuJ6
 gafwAWnqe5pfR/8OxFsHhrfIVAw3VdgGzmTngfKbme+sBQL1jq8Yio3OmeksqSqm
 MVhXRpSZthAueSupl2J2JXVeEobRVprNQN4+p3xBPpcDz80uBlA3bHkKcofm+dAB
 vWFRu+B+YvfiqnZ8h5jr5XMEZGZ1wanGdd3x6ix1BRIeKPw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4dcmrwtayn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 03:41:47 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63774kK7293912 for <dev@dpdk.org>; Tue, 7 Apr 2026 03:41:47 -0400
Received: from esapsmtpat06.us.dell.com (esapsmtpat06.us.dell.com
 [143.166.211.145])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4dcu19t8h3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 03:41:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775547707; x=1807083707;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4C07BMsLHmUIK1mDMnJ/4/HnA4LMi702w5T5qEJST5Y=;
 b=KjmpHD2PfIL4GqAk9AI2DFmU0+7EbV1fxLybvgYmJcsHILH+GIJwYQlG
 Bn+wCKUBVpT5GsBSf+a6l/MxiofGfWhwSCgURhjfVW1m4F+Usz2EPB+rA
 /HPag6O1hjaj8UgqcsPp62SBf9pdzs4Mrdny8mUY1eUrVSLA0SBlg1Kfh
 Qpk6WR8G79QUmwDJwaVXCvT45V82EtZO0JRooTH+OUa0aS4oGBVijhgVd
 4IsWvdAlXPP2TSOMm0p6Ot2NCbjygO1lc+2nxmG0VYpyKOpvwajcAbQBv
 +o/McF/nHKmtbNOUTYoRtfHVL99mGO1hpb87K4ZCUflB09ZRtv/hN7+4T g==;
X-CSE-ConnectionGUID: vSn4h102RAu+/R2xtsWp4A==
X-CSE-MsgGUID: zEYL2FlnRk65dfMggC5ysA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 07:41:47 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 02:42:39 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 02:41:45 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 7 Apr 2026 02:41:45 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v9 0/5] Support add/remove memory region and get-max-slots
Date: Tue, 7 Apr 2026 07:42:18 +0000
Message-ID: <20260407074223.3876085-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070068
X-Authority-Analysis: v=2.4 cv=a/gAM0SF c=1 sm=1 tr=0 ts=69d4b53b cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=5Q2474zp7XKCQhFpYb/iUQ==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=2gTEiJevXRG9mBCVbQIA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA2OSBTYWx0ZWRfX/+oVacPmt3rv
 tjdfa9o/UNTlMJgFbBh1Pr+Y1R5mJCjo3cZaSj1KPGnCx3VIhxXgllDMXCVwdhypQu0g4iBvC9c
 eiHpDUqQdgnficsik7FJJx322Wu9oXdaTdtVR10anUsOanJ1DWodjuoVcscHr5Ow8y/zleMRkfJ
 RCgHIA4e+HviK3kR72pawuAS2KBwOIJYmWjF28NLU7DrtXdlW7T35nh3fNXMulKnYLpb3tuzDVU
 E8HT4rBBQQT6vRJRhCBn10P67hwb+5CWzRJ2ekT1LbzT/fJ2MRyAehNASsXTeJcgttbd57fq4R5
 4HwgzeCvPZSMgbxpkdSLLI2t9a5INaVHBEhQ88B/gLV4npB1YZCE5hugYQbp3g9ibtMS7qgYzkD
 B0Y+VzlvDee4BW8/0xjTzGKFasLK0qi9Ji5ONCwVy7eganTAhUpyyTePlSSokupv7Hys9PR3sN7
 U7Dqhkl8xOoMa/dn2xg==
X-Proofpoint-ORIG-GUID: D6jM9rpSGnIXTAw-j2kSEmt6BV6GSMss
X-Proofpoint-GUID: D6jM9rpSGnIXTAw-j2kSEmt6BV6GSMss
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070069
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

This is version v9 of the patchset and it incorporates the
recommendations made by Stephen Hemminger.

Changes made to patch 3/5
- Restored max_guest_pages initial value to hardcoded 8 instead of
  VHOST_MEMORY_MAX_NREGIONS, matching upstream semantics.

Changes made to patch 4/5
- Added close(reg->fd) and reg->fd = -1 before goto close_msg_fds in the
  mmap failure path to fix fd leak after fd was moved from ctx->fds[0].
- Converted dev_invalidate_vrings from a plain function to a macro +
  implementation function pair, accepting message ID as a parameter so
  the static_assert reports the correct handler at each call site.
- Updated dev_invalidate_vrings call in add_mem_reg to pass
  VHOST_USER_ADD_MEM_REG as message ID.
- Updated dev_invalidate_vrings call in rem_mem_reg to pass
  VHOST_USER_ADD_MEM_REG as message ID.

This implementation has been extensively tested by doing Read/Write I/O
from multiple instances of fio + libblkio (front-end) talking to
spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
dpdk testpmd (back-end) performing add/removal of memory regions. Also
tested post-copy live migration after doing add_memory_region.

Version Log:
Version v9 (Current version): Incorporate code review suggestions from
Stephen Hemminger as described above.
Version v8:  Incorporate code review suggestions from Stephen Hemminger.
rewrite async_dma_map_region function to iterate guest pages by host
address range matching
change function dev_invalidate_vrings to accept a double pointer to
propagate pointer updates 
new function remove_guest_pages was added
add_mem_reg error path was narrowed to only clean up the single failed
region instead of destroting all existing regions
Version v7: Incorporate code review suggestions from Maxime Coquelin.
Add debug messages to vhost_postcopy_register function.
Version v6: Added the enablement of this feature as a final patch in
this patch-set and other code optimizations as suggested by Maxime
Coquelin.
Version v5: removed the patch that increased the number of memory regions
from 8 to 128. This will be submitted as a separate feature at a later
point after incorporating additional optimizations. Also includes code
optimizations as suggested by Feng Cheng Wen.
Version v4: code optimizations as suggested by Feng Cheng Wen.
Version v3: code optimizations as suggested by Maxime Coquelin
and Thomas Monjalon.
Version v2: code optimizations as suggested by Maxime Coquelin.
Version v1: Initial patch set.

Pravin M Bathija (5):
  vhost: add user to mailmap and define to vhost hdr
  vhost_user: header defines for add/rem mem region
  vhost_user: support function defines for back-end
  vhost_user: Function defs for add/rem mem regions
  vhost_user: enable configure memory slots

 .mailmap               |   1 +
 lib/vhost/rte_vhost.h  |   4 +
 lib/vhost/vhost_user.c | 403 ++++++++++++++++++++++++++++++++++++-----
 lib/vhost/vhost_user.h |  10 +
 4 files changed, 375 insertions(+), 43 deletions(-)

-- 
2.43.0

