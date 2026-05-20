Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A476CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 02:20:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D1C2402EA;
	Wed, 20 May 2026 04:20:31 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 01B7840144
 for <dev@dpdk.org>; Wed, 20 May 2026 04:20:29 +0200 (CEST)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JHpJNn3903964 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=LWKlyxxIGNNbh3tK47jK9mV
 YOmnm2TeRYWgRfQ6nIWU=; b=OaACqJz0+HC8uPa/2kgZJpV5kIct2sgI+YpIipx
 STlRfa1RcTPncJNTbg8gfDVkKcErxZfQ/U1LRd6/XJVWcfQYLPlT9hdJEZo5+eUJ
 +tbN3YYE94ZLRGqlDbjeAapkCZA2S/uyTVNWao6/ES0/BW+n2GGCboIJk3CO1OFX
 eK54OIMxVxPVlCZuLWdsiQRVnGPdjwOVuR3H4ZCWcN/4HZOi23PODhFUcJi02yeq
 7b+y7ghHN6S74EZ0jArdUhZQd0UO9uUn0qiyVmb6o2JFND5YBsly4SgTQdb9fmJq
 6pJz8fP2xoPrPtals1G6LeB/G66/g8/djsVRt80yZJXcmWg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e6kr6ef7e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:28 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K1j5Vf1912367 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:28 -0400
Received: from esapsmtpat03.us.dell.com (esapsmtpat03.us.dell.com
 [143.166.211.152])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e8wd853k6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1779243629; x=1810779629;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LWKlyxxIGNNbh3tK47jK9mVYOmnm2TeRYWgRfQ6nIWU=;
 b=BNW/kgVC4jN8i7QiUBApkTcIO4KTSRqigX8xY1IN7ubiR9f4N8dIHGTK
 Ew0nsQEBdWysSHTjwLzf9EfQOxxf8QqlrrCtshFyGHYjRd75sU3ssMUgI
 V8JOG0UlxYT24EtbzoyNZ2rh31vNe7veZO/GiaotIJlV7HWJ5y5EZrwIW
 S11hVSC8ylR5Gw0lF5EOyiLyo92WUuD8OlRmbnsOhuI68kTC9D6S91ulA
 ws4VR60riTTnfVs/FRgpEhJFTRxLDD8W6+hKgcGTXdnSZVVO6uEya12hS
 m3uT0J5aMagkumCE9yzqljRIWKyjTLs6ubQQrQs8IjQI/xo5QgC2KmKKD Q==;
X-CSE-ConnectionGUID: NzGtLhEISdmZwR+Qj9EW6Q==
X-CSE-MsgGUID: 7EPY5GubS6CHJO8dG7znvA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat03.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 02:20:28 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:21:29 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:20:26 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 19 May 2026 21:20:26 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v14 0/5] Support add/remove memory region and get-max-slots
Date: Wed, 20 May 2026 02:20:07 +0000
Message-ID: <20260520022012.243619-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200019
X-Proofpoint-ORIG-GUID: HBTUiy41ME_baN9PBlCv3Ksb45iXZLW_
X-Proofpoint-GUID: HBTUiy41ME_baN9PBlCv3Ksb45iXZLW_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAxOSBTYWx0ZWRfXyIia1ednc+VT
 oJff8f9AKEEo1h6nOgKhaDscmwbr+oJJaGsJO3/0GavYh7utmTxiVvHkAOz3O59UDTA7KFiFlmS
 K0Gx6wnsdCgwp+iCT7yuALnJG8a2UBsryC9xN/o7X4QHFmiLsH9gwChm2Z58vQbw34azSodvY0G
 aBwTbJmFg6e2hKmH2mkmgJDohMy+qv0UvKhKAGPCbkgjDbnTsRhMbpt0vdo8t5O04FPPcGaVgOn
 5bhco1K2z+HKOO8TLYjbvo320h2btyihu8Rk/0Jg9lyfTZaoJHX2wqDjPiQMrpUZ7XmKqjWLAMY
 pz7OK6qEgRaWPVivRy4Ob76fMtJZca3aTTp9WSpmtGfQHIhf1MKjUgW+hxQsMCYlE1Q6Z9Ktjle
 eKdoM+ERJ7X1EwfbXiFv7x8hlDeZHB81Rsu7jz3wIczUHl7LMmqt+msKnCZI6ofiOnM10BBmjxd
 Ne1sP1KePQwtoYNZJig==
X-Authority-Analysis: v=2.4 cv=f6N4wuyM c=1 sm=1 tr=0 ts=6a0d1a6c cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=Exi4HLWdEtKd1bGGvbjpxg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=m3zZTHMLHbwB7Lmtoed2:22 a=iLNU1ar6AAAA:8
 a=PzSNswRjnqf5c4rvnDQA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200019
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

This is version v14 of the patchset and it incorporates the
recomendations made by Stephen Hemminger and Fengcheng Wen.

Changes from Fengcheng Wen review:
Patch 3/5
- Moved free_all_mem_regions() call sites in vhost_user_set_mem_table()
  from patch 4/5 to patch 3/5 so each commit compiles independently
Patch 4/5
- Renamed _dev_invalidate_vrings() to vhost_user_invalidate_vrings() to
  follow vhost naming convention
-  Added comment explaining *pdev propagation through
   translate_ring_addresses / numa_realloc()
- Reordered local variables in vhost_user_add_mem_reg() and
  vhost_user_rem_mem_reg() by descending line length
- Shortened overlap check variable names (current_region_guest_start/end
  --> cur_start/end, proposed_region_guest_start/end -> new_start/end) 
- Fixed DMA error path in vhost_user_add_mem_reg(): added
  free_new_region_no_dma label so async_dma_map_region(false) is not
  called when the map itself failed.
Changes from Stephen Hemminger review:
Patch 4/5
- vhost_user_add_mem_reg() now constructs a reply with the back-end's
  host mapping address in userspace_addr and returns
  RTE_VHOST_MSG_RESULT_REPLY per the vhost-user spec
- Added validate_msg_fds(dev, ctx, 0) in vhost_user_rem_mem_reg() to
  reject malformed messages with unexpected file descriptors
- Dropped unnecessary (uint64_t) cast in vhost_user_get_max_mem_slots()

This implementation has been extensively tested by doing Read/Write I/O
from multiple instances of fio + libblkio (front-end) talking to
spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
dpdk testpmd (back-end) performing add/removal of memory regions. Also
tested post-copy live migration after doing add_memory_region.

Version Log:
Version v14 (Current version): Incorporate code review suggestions from
Stephen Hemminger and Fengcheng Wen as described above.

Version v13: Incorporate code review suggestions from Fengcheng Wen
Patch 2/5
Renamed VhostUserSingleMemReg to VhostUserMemRegMsg and memory_single
to memreg
Patches 3/5 and 4/5
Relocated function remove_guest_pages from patch 3/5 to 4/5

Version v12: Incorporate code review suggestions from Maxime Coquelin
and ai-code-review.
Patch 3/5
Refactored async_dma_map() to delegate to async_dma_map_region(),
eliminating code duplication between the two functions.
Restored original comments in async_dma_map_region() explaining why
ENODEV and EINVAL errors are ignored (these were stripped in v10)
Reverted unnecessary changes to vhost_user_postcopy_register() --
removed the host_user_addr == 0 checks and reg_msg_index indirection
that were added in  v10, since this function is only called from
vhost_user_set_mem_table() where regions are always contiguous.

Version v11: Incorporate code review suggestions from Stephen Hemminger.
Patch 4/5
Fix incomplete cleanup in vhost_user_add_mem_reg() when
vhost_user_mmap_region() fails after the mmap succeeds (e.g.
add_guest_pages() realloc failure) realloc failure). The error path now
calls remove_guest_pages() and free_mem_region() to undo the mapping
and stale guest-page entries, preventing a leaked mmap and slot reuse
corruption. The plain close(fd) path is kept for pre-mmap failures.

Version v10: Incorporate code review suggestions from Stephen Hemminger.
Patch 4/5
Moved dev_invalidate_vrings after free_mem_region, array compaction, and
nregions decrement. This ensures translate_ring_addresses only sees
surviving memory regions, preventing vring pointers from resolving into
a region that is about to be unmapped.

Version v9: Incorporate code review suggestions from Stephen Hemminger.
Patch 3/5
Restored max_guest_pages initial value to hardcoded 8 instead of
VHOST_MEMORY_MAX_NREGIONS, matching upstream semantics.
Patch 4/5
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
  vhost: header defines for add/rem mem region
  vhost: refactor memory helper functions
  vhost: add mem region add/remove handlers
  vhost: enable configure memory slots

 .mailmap               |   1 +
 lib/vhost/rte_vhost.h  |   4 +
 lib/vhost/vhost_user.c | 427 +++++++++++++++++++++++++++++++++++------
 lib/vhost/vhost_user.h |  10 +
 4 files changed, 380 insertions(+), 62 deletions(-)

-- 
2.43.0

