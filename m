Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A80CD8C88
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Jun 2026 02:52:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17E8D4067A;
	Sat,  6 Jun 2026 04:52:32 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 15BFA40664
 for <dev@dpdk.org>; Sat,  6 Jun 2026 04:52:29 +0200 (CEST)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655L21A72204119 for <dev@dpdk.org>; Fri, 5 Jun 2026 22:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=w9AkWVgijIYvyXKHnsYNLzH
 jLvskvMc5xpMrmv0WmGA=; b=WbxT+K1mpP9HtemaPbS+IinK/WX2BhKAAZ/PQOP
 GVvRHdGTLvWKIVt5Ag/dDWFHjYGqRdxtlLQaHSR7vok4/4F0a7ERdCRte4J793vG
 fM/tTekDl6BI7eZ8lj+9XgOZ17MgUytP9DMw8Kgb6474yp9cphXzJY8DxiHLhYBS
 dPRPEEwnjxKthbu11eQLo5Pt/VJlV+r+tqWeg3fE/tf4OPXIdyx4hLDOezLaIW17
 xjLoexzuWnyGYUv/GYMXY9P+fZ43uI8Op4vpW4kE30rmhSOUKAvhp15M2g8fqdrP
 Hyvsdcc1kIYZM4M6hTMWe5VBRrbAZ3u7xb94WGT1r1xkO1w==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4ej75kys1s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 05 Jun 2026 22:52:29 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655MFH0i2491284 for <dev@dpdk.org>; Fri, 5 Jun 2026 22:52:28 -0400
Received: from esapsmtpat04.us.dell.com (esapsmtpat04.us.dell.com
 [143.166.211.147])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4em6qrk7yb-5
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Fri, 05 Jun 2026 22:52:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1780714348; x=1812250348;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w9AkWVgijIYvyXKHnsYNLzHjLvskvMc5xpMrmv0WmGA=;
 b=MlQ+Mxhx92KI52Bnt84TnzupQoWEV9p3+sH044tAMRmYzrsotIbQ/2oi
 K1Q/sX8LiB4/i8O8uqx+lGuIyaph67Zo8u68Fl2ct8LU8RN8Cj+ZWcGXE
 SABbHJYHIAZBu+fD0VuC+o+li4VMrckEoG74mk06bjv16/x1+WnM2/XGm
 cFNfYlqLguvenUnFreLOPRG9pICmUPveoj5yMoRxfLpJifM6euACedX+6
 CQ9UlW209z8zP7wY6H2x8nIkUMSwoIXURSNWQmhuZ2dLCJM0njRLI8neV
 1zXcj0/rzdJVS32Oq/fFqcXCj498I6fLPwAz8IU3XYp6jRthXcL0oNWvI g==;
X-CSE-ConnectionGUID: 2lDvsOjRRGyeCl2Ed1qsAA==
X-CSE-MsgGUID: 7CF5qcisQCSS+nQA2//XGg==
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
 15.2.1748.39; Fri, 5 Jun 2026 21:52:14 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Jun 2026 21:52:13 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v16 0/5] Support add/remove memory region and get-max-slots
Date: Sat, 6 Jun 2026 02:52:06 +0000
Message-ID: <20260606025211.1082615-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
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
X-Authority-Analysis: v=2.4 cv=Fuo1OWrq c=1 sm=1 tr=0 ts=6a238b6d cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=xQoiRHjKKYbJmV+sD1MyuQ==:17
 a=FelO9ux0wxsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=fe1keu9KhAX5AoWrZvs2:22 a=iLNU1ar6AAAA:8
 a=Zfjfo3tkTRbYG8q6a7wA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: XUFNn81PCzIThjF7XNokLC41c16iCTmo
X-Proofpoint-GUID: XUFNn81PCzIThjF7XNokLC41c16iCTmo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDAyNSBTYWx0ZWRfX002dRQJRanYr
 VIHclI0lRVDsookvelBD8FWSNYZe2uNZzQlrJhvEIVsrQwXRWfjWVWGjQ80AebBCtx3LrgKpHbe
 UbBzoybfxRCqoVPuK8vorGU2clLb4wVYWWtL4gPLmb7lhV3cEX5fYPlHBnVn98V+UKWP6QTJCgV
 5/OrEwSJ9XuxqthM9qggwsLrCW+4xL1eNLDV5Y6MHdi1seGR3+fnGsOYG5sSJ3HOWQuHSC+Jezn
 kxLew/WS38kVCQlrHSRbjh6FkiLyoRnzcbqSQL44wUer5iJYyHWwLcbhAZcoUK5FKjG89rM+LGN
 5PVkHvdMBXqK3K9Giuo0aMOFmuE335IafIfKGH9pYaIkhevp1TDV8DnrOVCNNJuS39Ngdtbmu8y
 DpF4unTE13mce2DXs6RXP31GJZPsg4C+7q7BhYoET27PyDKEljy8yG02QfvF3ILaq6EA8/eRV5g
 cHRwKzPS8lvMofm2UUA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
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

This is version v16 of the patchset and it incorporates the
recommendations made by Stephen Hemminger.

Patch 4/5
- Fixed use-after-free in vhost_user_add_mem_reg(): reg pointed into
  dev->mem->regions[] but dev_invalidate_vrings() ->
  translate_ring_addresses() -> numa_realloc() can relocate dev->mem ;
  re-drive the region pointer from the refreshed dev before reading
  host_user_addr for the reply.
- Gated the ADD_MEM_REG mapping-address reply on dev->postcopy_listening
  per the vhost-user spec (reply is postcopy-only); return
  RTE_VHOST_MSG_RESULT_OK in non-postcopy mode,  matching SET_MEM_TABLE,
  to avoid desyncing the channel.

This implementation has been extensively tested by doing Read/Write I/O
from multiple instances of fio + libblkio (front-end) talking to
spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
dpdk testpmd (back-end) performing add/removal of memory regions. Also
tested post-copy live migration after doing add_memory_region.

Version Log:
Version v16 (Current version): Incorporate code review suggestions from
Stephen Hemminger.

Version v15: Incorporate review suggestions from Maxime Coquelin.
Patch 4/5
- Changed VHOST_USER_REM_MEM_REG handler declaration from
  accepts_fd=true to accepts_fd=false, as the remove request does not
  expect FDs in ancillary data.
- Removed all close_msg_fds(ctx) calls from vhost_user_rem_mem_reg(), no
  longer needed since the handler is declared as not accepting FDs.
- Removed validate_msg_fds(dev, ctx, 0) check from
  vhost_user_rem_mem_reg(), as FD validation is now handled generically
  by the framework.
- Added targeted IOTLB cache invalidation in vhost_user_rem_mem_reg()
  using vhost_user_iotlb_cache_remove() for the removed region's GPA
  range, instead of the nuclear iotlb_flush_all() used by set_mem_table.

Version v14: Incorporate code review suggestions from Stephen Hemminger
and Fengcheng Wen.
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
 lib/vhost/vhost_user.c | 438 +++++++++++++++++++++++++++++++++++------
 lib/vhost/vhost_user.h |  10 +
 4 files changed, 391 insertions(+), 62 deletions(-)

-- 
2.43.0

