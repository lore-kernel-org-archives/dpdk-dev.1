Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB8ACD37AC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 02:02:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C77D1402AA;
	Thu, 14 May 2026 04:02:44 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 5C4634025E
 for <dev@dpdk.org>; Thu, 14 May 2026 04:02:43 +0200 (CEST)
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DGZqkI3909141 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=fUIEzVnVgt7af/9N/2aoa20
 RPkyUfnImFaeqbbmNDtk=; b=lK62PL9eB7Lk68ld8Vnu5X4rNpmxsgLUoGCeYhM
 zu8MmTCZCb1BpFHxDycCyvkmqImPyUFW0FOhzZnvEaQZLC51dSG5zKwjOH9ydNlU
 tZcfjfI571dIFqj7RLFod1JCEtJEwMTwEB7GrGkHqM4OmYa5EuULq1Oo1a7Akxwb
 0JBeAaEEYabWJ7oGj3JACGHH3WNDi8/r9sYkjjykb+E4P6ZiVLC4UM4IPdKo3N9F
 f5SVN+zXxH0KAQaADRADcERiMWVeyI0QiBD74JY2H/SPE8hjjC8iAO968CzjzJde
 24vrEDZqZSHnixCIYLciDX+riUGUKe8yI75aZLcYCyLWNzw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4e3nv0usr7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:42 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E1xfGC2151400 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:41 -0400
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e54ue083e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778724162; x=1810260162;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fUIEzVnVgt7af/9N/2aoa20RPkyUfnImFaeqbbmNDtk=;
 b=UlfQqukSVQtAQQZxYEvqZKjGIV0Vnx1fHI601siDMj7pT0czaSOnOjUD
 na58ggyv8MrxrIPwWBfwX811Jubb7xAaeXFPqqi7uX1IrRoit2xzmTJCP
 B93qpxKAqoEPwcgo3OfCSpzq0DX27bWBLVJxO070i1wYPN+u9pE8EFLJg
 cR1xZ6A5SsPZ2R7xDmAHGZz3ErHb7FWgNEInsqSrehup2ifWO9xRHMIIm
 xV9D/3Csf9Dq2F4DW+BYbBvb0hDD3vCuV7ZDGUsklWXPgMovGvVTawIeE
 /k8qzAmQJ8WQlOLvr+8t3OwYapQCaEdDyEsYhVXVAQUAcHwTZ8e7JvkCW A==;
X-CSE-ConnectionGUID: SPTsiNwfTICkAy68yMqFrQ==
X-CSE-MsgGUID: 7SLNvEZIQVaJJXphRQU+IA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:02:41 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:03:56 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:02:40 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 13 May 2026 21:02:39 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v13 0/5] Support add/remove memory region and get-max-slots
Date: Thu, 14 May 2026 02:01:52 +0000
Message-ID: <20260514020157.1937404-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140018
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAxOCBTYWx0ZWRfX8YBk7J5pY8C3
 99yl4IaSgIZr2ME2bMbY+UJ/U3/cJ9xmKufDl9IR7yQM0c3Fetw4zkt8oPY9bygE/3/+sWVnH4C
 bTwuQf1oQl0ZBnnyDiTeRgVNkBAe6swASNnYJuVucodVhsEnz1XxzmFud27wbiFRhcpVlu28twZ
 a16Ufn2hkPRfDuRMS2o8fye8lgforkiy0MnM0ecGYPclrLXJm87PWhzfs65RDNJm3iMr0IUcdya
 Zt10a1DW2AhQwNAUf5s2rZ1C/g3lF9eECAP5E/5yqi3LHPgmxDo/MVW6y+KORT7bDnh/ZxJCUzP
 yyvebQLG7Wi02Kgu6cSEV0sDupxfsX8Vpnbe0qJ0O4VzLGK+NBSLpLA8GOQItbJ2gM3dC0m7mit
 jH6TvNJC6VpxAAzZD4umH7vCjb3MlsiCkFwFAEpNGdDO1XoPpcFAcF6ckSFkv9OELOLsxq2uP6o
 LbAVhianOFIEMkaTY/Q==
X-Authority-Analysis: v=2.4 cv=ZIrnX37b c=1 sm=1 tr=0 ts=6a052d42 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=U3ti1ie9CgboSd2qXsAw:22 a=iLNU1ar6AAAA:8
 a=PKI3R_pDefeA-SqXiwkA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: gbwEO9440bja-Zh9ZEZEeizDLZl4Bcz4
X-Proofpoint-GUID: gbwEO9440bja-Zh9ZEZEeizDLZl4Bcz4
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140018
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

