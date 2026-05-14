Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD1FCD4F25
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 22:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 296CC40274;
	Fri, 15 May 2026 00:46:38 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 307EC40151
 for <dev@dpdk.org>; Fri, 15 May 2026 00:46:36 +0200 (CEST)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EJ1gf83478819 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=YafD6fmdKRzswCfXsl1Yx5f
 Y7JtZwewpo2TVT45Bu9E=; b=Cw9xmN7DUQSwh/vCBDSssR+JHR5UzTEpoIA5v+D
 1j++ANvLTX6wNaax5UdkrwJJnTT8JbZ8p5N4MGLTbMS0pgRmaR2yKa9v+Y5nRVr7
 OND2Rih6vVBm0T8IVG9gqTmHWmmk7u3qmBqe89J2Rkm12eW5ELyjMDsTZL4VGQdY
 ROTaDgY8SN+YVdTpSCeuWp1XMcmZRJF8Md6PioyJOK0IIYWLxK5uCU1Pbb33cXaZ
 ASc2hnksgxmkltDOPlM7jSipQng2xnZ+JjoHBJMKJ1kMpdpsLqwfe1WAFab4+t4r
 xpoL1qgqUNXmkWBfyJLEiy4iRLeV5Y8yFwJvQdsq4px4Ckg==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e5m6fgqef-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:34 -0400 (EDT)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64ELmSg9794030 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:34 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e5m6m2a9f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778798794; x=1810334794;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YafD6fmdKRzswCfXsl1Yx5fY7JtZwewpo2TVT45Bu9E=;
 b=JtKlomsoJjU3XlvP9dvCo57lFDpuZq2+5U0pISw7kqkJW4qr24A/kBrB
 TH6ypgsdxBXgqMOXbGlKV4iIWW17TQhnOqVyUe5+1SiDkAOw2onSE/Bph
 nysIhb5T6Iggvfooo02LI2Se9rmtKZF9382yQ6gpZX66DQDfOt1JIJLHa
 F6ZrCi/U8Mz2kz1Jkm+vQ5SM4WPy1mB9bt28yArNNItBtojyb0vRNSVSQ
 k82/zB83qYFwsvBHhYqi35qLd3F/ypGCJCMZF1evtU/I+MTqVJj28YU2Q
 n1WkiNOQYuo/jFSG5lbEiVKD8j/Sn0LKk63zE7iBpy6YKUIADWbBe6dUZ w==;
X-CSE-ConnectionGUID: JJUhL1WZQcyxAWH6O+S0LA==
X-CSE-MsgGUID: NiKm/0yDSBmF8F05IVLT0A==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 22:46:33 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 17:47:48 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 17:46:32 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 14 May 2026 17:46:31 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v13 0/5] Support add/remove memory region and get-max-slots
Date: Thu, 14 May 2026 22:46:22 +0000
Message-ID: <20260514224627.2014566-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140223
X-Proofpoint-ORIG-GUID: x35XUipO2synKhstutMer3YEN6mHywFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIyMyBTYWx0ZWRfX42fPo1smG7Gd
 JGQW8OELH3p21PdK237XkPJ/oKmpudEdoRJFDWBeKU4lrdHV/lCD6iisMgZ9Tv/wwaufSrfmusv
 rIrp1/zMMCYsJbQxNa6wRqYFujq5VAchBGlMYs0JiFNEcvRG9hZbahGD1cZOzKQzK7nhUrvtkmS
 NchwBPrsgjJve+ppsA0hkiuk+dhzjRCiqVUGP2smhumRex4qlSLFJjcigon9Yramo4EzgslhXeQ
 Ou6WV3hKo3znT5n3grTSsVgVMG0Fp44JvMa1hjoX9pULVAI+1MHNLuk5YbfvUHTcVCTA2kZxDZt
 8KiuUjJNft81XF9lqsg8Gnv61U0y2feJK4L9I42lkgI3fb4Kk+b/V5jLB0z9pWHBDJmJlGY4MVv
 W5Aqtw/pQMatdEM+6V9+VFcnsytpctNSNKC2YxmxNxCKr/I0WZX3+FCQjZOgMlrY9oy22S6fedW
 UwESi2I6zGwsfJH+WlA==
X-Authority-Analysis: v=2.4 cv=JP0LdcKb c=1 sm=1 tr=0 ts=6a0650cb cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=PpEg0BoV_A2aca28hXd0:22 a=iLNU1ar6AAAA:8
 a=PKI3R_pDefeA-SqXiwkA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: x35XUipO2synKhstutMer3YEN6mHywFc
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0
 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140223
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

This is version v13 of the patchset and it incorporates the
recommendations made by Fengcheng Wen.

Changes made to patch 3/5 and 4/5
* Relocated function remove_guest_pages from patch 3/5 to 4/5.
Changes made to patch 2/5
* Renamed VhostUserSingleMemReg to VhostUserMemRegMsg and memory_single
  to memreg.

This implementation has been extensively tested by doing Read/Write I/O
from multiple instances of fio + libblkio (front-end) talking to
spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
dpdk testpmd (back-end) performing add/removal of memory regions. Also
tested post-copy live migration after doing add_memory_region.

Version Log:
Version v13 (Current version): Incorporate code review suggestions from
Fengcheng Wen as described above.
Version v12: Incorporate code review suggestions from Maxime Coquelin
and ai-code-review.
Changes made to patch 3/5
Refactored async_dma_map() to delegate to async_dma_map_region(),
eliminating code duplication between the two functions.
Restored original comments in async_dma_map_region() explaining why
ENODEV and EINVAL errors are ignored (these were stripped in v10)
Reverted unnecessary changes to vhost_user_postcopy_register() --
removed the host_user_addr == 0 checks and reg_msg_index indirection
that were added in  v10, since this function is only called from
vhost_user_set_mem_table() where regions are always contiguous.

Version v11: Incorporate code review suggestions from Stephen Hemminger.
Change made to patch 4/5
Fix incomplete cleanup in vhost_user_add_mem_reg() when
vhost_user_mmap_region() fails after the mmap succeeds (e.g.
add_guest_pages() realloc failure) realloc failure). The error path now
calls remove_guest_pages() and free_mem_region() to undo the mapping
and stale guest-page entries, preventing a leaked mmap and slot reuse
corruption. The plain close(fd) path is kept for pre-mmap failures.

Version v10: Incorporate code review suggestions from Stephen Hemminger.
Change made to patch 4/5
Moved dev_invalidate_vrings after free_mem_region, array compaction, and
nregions decrement. This ensures translate_ring_addresses only sees
surviving memory regions, preventing vring pointers from resolving into
a region that is about to be unmapped.

Version v9: Incorporate code review suggestions from Stephen Hemminger.
Changes made to patch 3/5
Restored max_guest_pages initial value to hardcoded 8 instead of
VHOST_MEMORY_MAX_NREGIONS, matching upstream semantics.
Changes made to patch 4/5
Added close(reg->fd) and reg->fd = -1 before goto close_msg_fds in the
mmap failure path to fix fd leak after fd was moved from ctx->fds[0].
Converted dev_invalidate_vrings from a plain function to a macro +
implementation function pair, accepting message ID as a parameter so
the static_assert reports the correct handler at each call site.
Updated dev_invalidate_vrings call in add_mem_reg to pass
VHOST_USER_ADD_MEM_REG as message ID.
Updated dev_invalidate_vrings call in rem_mem_reg to pass
VHOST_USER_REM_MEM_REG as message ID.

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
 lib/vhost/vhost_user.c | 418 +++++++++++++++++++++++++++++++++++------
 lib/vhost/vhost_user.h |  10 +
 4 files changed, 371 insertions(+), 62 deletions(-)

-- 
2.43.0

