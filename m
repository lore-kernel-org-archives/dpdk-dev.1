Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76430CD3427
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 03:37:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE63F4027E;
	Wed,  6 May 2026 05:37:54 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id E11A1400D6
 for <dev@dpdk.org>; Wed,  6 May 2026 05:37:52 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645HlA631833272 for <dev@dpdk.org>; Tue, 5 May 2026 23:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=eaZI5Nrnuj2TfW5xOsYrTaN
 k+J5tV4VGy/9+t44SLe0=; b=CC/Q8h8o1/Pm5CEbHyCXuK7EEA4CKS5qkSgPZnh
 0paoZh8wEuYGjMYW9/MeKGe9FhHJsC7sIovPtsNmIi6ZwC/vsGdenj4jhmRyzywq
 LJ8lfnY0/8ER5YARiC1ReVSX8hWtg7zlYUK7COh2uS9i+wVn4UNymZ1KYH4/1ysi
 0Nw3oQsfGEB1jFZvK2HtH5Jho88dOcVpli1qncIly2c2ZHZsH11Manam4otb9EAC
 1YwklbTLmVGy09AuX+2JWGRe3UYE42G9fYLeejx2AJxEugYnP/SBZdhHdjsLZ1X4
 pwLJikHm6AJmAXiM8Lptg0TycWkrJMBBz3EfaBOp+/Bno5A==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dwcg5pa2h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 May 2026 23:37:52 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6462UZZ3548036 for <dev@dpdk.org>; Tue, 5 May 2026 23:37:51 -0400
Received: from esapsmtpat07.us.dell.com (esapsmtpat07.us.dell.com
 [143.166.211.149])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dyv1u1992-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 05 May 2026 23:37:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778038671; x=1809574671;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eaZI5Nrnuj2TfW5xOsYrTaNk+J5tV4VGy/9+t44SLe0=;
 b=qt7+GV1empMQyCDL2iAamvZFh61ofRoxVg6OKZ3wJCrFwDyn//OFc4Xf
 eFEqcoGITb8TrjpV/eJ8sj2k+4kOTXnQ4Sg06xyQuQLa7T6FtYmuweFYv
 4IXLTUtKSo7Z2kOb3ZV5/Zw6m6xPuwJ/6cGFqV98/Jwi78fYSVgKvwmW6
 3ox/ngXYqfiNvjv0OeUES/8GR3pS4f+NZh1vYJvpUm8zm/IhVlUEgVXGv
 gUCHYVLMfr7nSl1lxX1SCHdchbXqt7wGTU7+ESssM20HPyDKc9R8uA2bN
 OVge6L8m7cmqdj4cT1KnKLMIoMJUYJjnpHHDQg5z6U8WIxbv4HrbDptT9 A==;
X-CSE-ConnectionGUID: F0la+AvzT0aZMJgfsJx7qw==
X-CSE-MsgGUID: 2OzcuVp+QhmqmRDTrhm/8g==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat07.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 03:37:50 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 22:39:00 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 22:37:48 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 5 May 2026 22:37:48 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, <fengchengwen@huawei.com>
Subject: [PATCH v12 0/5] Support add/remove memory region and get-max-slots
Date: Wed, 6 May 2026 03:37:28 +0000
Message-ID: <20260506033733.972952-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060032
X-Proofpoint-GUID: G6FdL0JzzvAtq2w36CP-zIPHJRM02YR5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDAzMiBTYWx0ZWRfX2AUma1iVBeMj
 rw5qzGjfJ7+8I1LbP1vTY67IEZ1RTt8B/uHdy1zI2HX0fMwqG59kr8EPxOR4A2W/orwzPgOlKdn
 pSRdzqd9ALs5eUjc9GZ4jxF8DMFO5+/AfXlCpd6mSUIweF/ZfpGEnnrqBpXBc6CaIBETxWZAXs1
 dCiWxuC46xX2io2T7v5EVqk11JB9AQIJVvOOLHRerF/P3rmLTxzKG2pgADbqWkLrby4cwpzZ6mA
 m/9RrMlV4NX+gSSj+6B9TtcTt/GofxaUGNNPC7dseEaT0UWLI/GIDScuuEc6roTZIX649EPm3fD
 iGDRgPQuY+UFqOBAdiF4UmcJaOBGDViSzhaEMSpovD3BKGE+9nM78TWnHEo3TTXvOM8lNL7CKri
 YA0LzLYtlMlmdwY8Q5JUnktNbHceb+LmkFziArOvrmN8VJ3Lh94SMzswoghA/QCO3MEAI/8SwT8
 iE/SU55KGLhWOwC+25g==
X-Proofpoint-ORIG-GUID: G6FdL0JzzvAtq2w36CP-zIPHJRM02YR5
X-Authority-Analysis: v=2.4 cv=bLQm5v+Z c=1 sm=1 tr=0 ts=69fab790 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=vdbZnCXtvJht7X5WT7bgSg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=PKI3R_pDefeA-SqXiwkA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060032
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

This is version v12 of the patchset and it incorporates the
recommendations made by Maxime Coquelin and ai-code-review.

Changes made to patch 3/5
* Refactored async_dma_map() to delegate to async_dma_map_region(),
  eliminating code duplication between the two functions.
* Restored original comments in async_dma_map_region() explaining why
  ENODEV and EINVAL errors are ignored (these were stripped in v10)
* Reverted unnecessary changes to vhost_user_postcopy_register() -- removed
  the host_user_addr == 0 checks and reg_msg_index indirection that were
  added in  v10, since this function is only called from
  vhost_user_set_mem_table() where regions are always contiguous.

This implementation has been extensively tested by doing Read/Write I/O
from multiple instances of fio + libblkio (front-end) talking to
spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
dpdk testpmd (back-end) performing add/removal of memory regions. Also
tested post-copy live migration after doing add_memory_region.

Version Log:
Version v12 (Current version): Incorporate code review suggestions from
Maxime Coquelin and ai-code-review as described above.
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

