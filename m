Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A7CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:54:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B6A440275;
	Fri,  3 Apr 2026 03:53:59 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6C29D4025A
 for <dev@dpdk.org>; Fri,  3 Apr 2026 03:53:58 +0200 (CEST)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632K6LF3234562 for <dev@dpdk.org>; Thu, 2 Apr 2026 21:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=8e5tIjkAAYKPD2K1xpF+fiC
 0+VnJ5kRQJz05FqTrUdU=; b=AapZPE49XBk/aX8snpk7a/9PV25hY5oUVKTmOMo
 QI3FVTN0BMyQZ1or7hIoGDLGOVFTcF5rL+b+httAb/e+DR1h+2k26JXKwMBxefTh
 E1PVgBuxJXAYItgBXxBMUsCqZul/vVn5rw0S9wfhuatG2nBc3aEUy8eD7iYjV4cD
 7EvqjsTpGUIUfDzK/0RB2igY9fqjFuA88KElATkwU28938tu++sr/J/MOkhH4YTO
 bOXygnLSXjbPDZl+sa9xGGi0DTVhBfvXOw0nj54a8ecFlwMBd1O0c5pHO1K356zM
 hhFjVO5oR7nrKytEuuZgdwZ7na5p7JiJ6LIDUVcIEQSguZg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4d6bnhmfsc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 21:53:57 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6331lbkL1305381 for <dev@dpdk.org>; Thu, 2 Apr 2026 21:53:57 -0400
Received: from esapsmtpat03.us.dell.com (esapsmtpat03.us.dell.com
 [143.166.211.152])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4da1s29j9m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 21:53:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775181237; x=1806717237;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8e5tIjkAAYKPD2K1xpF+fiC0+VnJ5kRQJz05FqTrUdU=;
 b=eEX0182RadmI7rJLDC9XDrFtr1W3tm4hEjDC93UXyMoPtdyKklOAGY4t
 ILP4v3x05BXACpqV0BJe6Q7X2CWy+hB512tnv/YGdC0xnIGCrUamn93VF
 KKxm3DxaQOHub41Qr/wV5kyx9SBPEdBvKe3Mzwlp8YIzRgqF/Q96ayQDw
 Q9UPAPVCEX20tr9huvDJNrc1SUPw9FriK7HLkiI8UM9SKBARPYei3AxnK
 mww2TFyyZZz/wE38wab4VkdqKnrUrhse0ikcUhsm8lD0KeTnw7VcdSi7b
 DpPIsX93OkxAO+AiRZ97qq2xcUmAyM+4u6u0tf3UBLhqhYOrvyWiuLWEZ Q==;
X-CSE-ConnectionGUID: Zd8JMCycQm21VZssxR23Jg==
X-CSE-MsgGUID: MWOfUkfkRWS7ATxFZVFVBQ==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat03.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 01:53:57 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 20:54:48 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 20:53:55 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 2 Apr 2026 20:53:55 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v8 0/5] Support add/remove memory region and get-max-slots
Date: Fri, 3 Apr 2026 01:54:29 +0000
Message-ID: <20260403015434.3124102-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030014
X-Proofpoint-ORIG-GUID: ZaWo1Vq5chNSHOggzYQvqRaNgPe0jqGG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAxNSBTYWx0ZWRfX7JU6S0PCt4/8
 8vqUqHf2RPCsghILtWvWiZZZj7KsJ78JrOcseSqt6OTES5sqCjz6WWKLQa6coZ06YYwr4Qz7f5g
 s5WXeKT7ZCeuwMy8dNe2HZXSb2Q39yorOw2R7+rsvjcuB5GVU8enMcqh+u/KmaCDG2elun1+eyW
 Q3eSA1xgJmdx1zbWHnYfVd+Au1SBlue0QEIZjSv6HNrdC44u19wn7N+nxWVeUTDnhv0d1qp/HxK
 1AtfZ92pNF3iqhV3WHhRzTlrzG9Bcp1lyT6AA8mBiwSCd5mID8d2WkT4TTCJSbC1oXBIcsKJJBo
 +lG49bNW6g3/iq8NRYeLmm8HZrRNWQQhmkGJiwDjOLJiZoWta6guvuSh6ZkgYcVC/l8xPhztxBN
 a1VDGg9u/tAqkQRM3IuFUe5zC0RCrji/57idJb29LCN6eOx/+1xC8i9TV93Q8Hw45lu6z+YYV2p
 UIt1WpqK72KyO+Po7Bg==
X-Proofpoint-GUID: ZaWo1Vq5chNSHOggzYQvqRaNgPe0jqGG
X-Authority-Analysis: v=2.4 cv=AI4ICPZ1 c=1 sm=1 tr=0 ts=69cf1db5 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Exi4HLWdEtKd1bGGvbjpxg==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=Qy6CKLcU0MZ4grw4BCWD:22 a=iLNU1ar6AAAA:8
 a=RilTStGhrQvzZSyXj9oA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030015
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

This is version v8 of the patchset and it incorporates the
recommendations made by Stephen Hemminger.
The async_dma_map_region function was rewritten to iterate guest pages
by host address range matching rather than assuming contiguous array
indices after sorting, and now returns an error code so that DMA mapping
failures are treated as fatal during add_mem_reg. The
dev_invalidate_vrings function was changed to accept a double pointer to
propagate pointer updates from numa_realloc through
translate_ring_addresses, preventing a user-after-free in both
add_mem_reg and rem_mem_reg callers.

A new remove_guest_pages function was added to clean up stale guest page
entries when removing a region. The rem_mem_reg handler now compacts the
regions array using memmove after removal, keeping it contiguous so that
all existing nregions-based iteration in address translation functions
like qva_to_vva and hva_togpa continues to work correctly. This
compaction also eliminates the need for the guest_user_addr == 0
free-slot sentinel in add_mem_reg, which was problematic since guest
virtual address zero is valid.

The add_mem_reg error path was narrowed to only clean up the single
failed region instead of destroying all existing regions. A missing
ctx->fds[0] = -1 assignment was added after the fd handoff to prevent
double-close on error paths. The overlap check was corrected to use
region size instead of mmap_size, which included alignment padding and
caused false positives. The rem_mem_reg handler registration was fixed
to accept file descriptors as required by the vhost-user protocol, with
proper fd cleanup added in all exit paths. Finally, the postcopy
registration in add_mem_reg was changed to call
vhost_user_postcopy_region_register directly for the single new region,
avoiding the use of vhost_user_postcopy_register which reads the wrong
payload union member, and a defensive guard was added to
vhost_user_initialize_memory against double initialization.

This implementation has been extensively tested by doing Read/Write I/O
from multiple instances of fio + libblkio (front-end) talking to
spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
dpdk testpmd (back-end) performing add/removal of memory regions. Also
tested post-copy live migration after doing add_memory_region.

Version Log:
Version v8 (Current version): Incorporate code review suggestions from
Stephen Hemminger as described above.
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
 lib/vhost/vhost_user.c | 392 ++++++++++++++++++++++++++++++++++++-----
 lib/vhost/vhost_user.h |  10 ++
 4 files changed, 364 insertions(+), 43 deletions(-)

-- 
2.43.0

