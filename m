Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A01FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 05:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E595A40272;
	Tue,  5 May 2026 07:53:05 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id B7AD340270
 for <dev@dpdk.org>; Tue,  5 May 2026 07:53:04 +0200 (CEST)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644HrajY3665666 for <dev@dpdk.org>; Tue, 5 May 2026 01:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=1ESel11BVHSHs8DWgk4clc3
 0hcsueaJnoD4YaBBXtTo=; b=ufScBTw4axe++7TqLQB4tjnkVdE7q9PP7PzR0Pq
 vNMu+regW0nJzTEWqucMzHOZU9YvV5tQpsaW8rK0hhllNVvwd1z3B0bRhPFcwm+U
 eklP1BPFXprX7bGFbODdsGIvLa0x3ELIUlQm6xSfH17ODrSlCsXkj+T8pv3Fx27b
 S0of673dmL8CuAP+9Vh4PKKSOXL5vwPbNsc/LFFhOhqfD8kkc+yb5WoBGRAbKP5M
 7BWsuXdlsTc9kB3AfKolSfaevOrqQRvrnvvMg3YPBtgHWqBD6v7rkP/s2sJ+NuDU
 +JMsskmAvyLgoK3fJqi0SSIvlpWI3S72+IHJXils4s+qt7Q==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4dwd9c9ex5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 May 2026 01:53:03 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6453a4eZ2486908 for <dev@dpdk.org>; Tue, 5 May 2026 01:53:02 -0400
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4dy6k12u6m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 05 May 2026 01:53:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1777960382; x=1809496382;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1ESel11BVHSHs8DWgk4clc30hcsueaJnoD4YaBBXtTo=;
 b=lsYCYpjiyk3g1LJubGIClAOyS47DMprjEDfR4zWEElRMO4kqjbMcjmuM
 Sy7OB1NzuSu3GN+wUay72t9Y9R0fWffKXUpzA8bmDbeozeBSCtkLme4SW
 zMgO684JuCYBMem7u1agzjlqm2isjJ4W50IJw6EpfOm8+wdT3120zvrxT
 M05bkZoRwMbj8lRMe2QTm4DXlVYDUjhnBqBp/jqZHhiVV1+lp0g8BI4XJ
 2vJ9WsUNqoZDWFcAzsvfbhQcvGlm+RNnFS93rJ9lw+gAzkB7EKKEnJ2p2
 y+JJofqXPLs7tJf1+sT+eHXM629phCzxZmEuiGN5JpTdNNviLdQ/oI9iM Q==;
X-CSE-ConnectionGUID: 8DXJmFx3QlK5dJpQXWec4w==
X-CSE-MsgGUID: uodOM1zsQKGi49ZOV7e1ZA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 05:53:01 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 00:53:56 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 00:53:00 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 5 May 2026 00:52:59 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v11 0/5] Support add/remove memory region and get-max-slots
Date: Tue, 5 May 2026 05:52:46 +0000
Message-ID: <20260505055251.818594-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050052
X-Authority-Analysis: v=2.4 cv=JrzBas4C c=1 sm=1 tr=0 ts=69f985bf cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=PpEg0BoV_A2aca28hXd0:22 a=iLNU1ar6AAAA:8
 a=RNmmVWOz6b1SMx3EG9wA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: dwVVFrPkaAShBl0GC5s2hlqHgoKi5wG3
X-Proofpoint-ORIG-GUID: dwVVFrPkaAShBl0GC5s2hlqHgoKi5wG3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA1MiBTYWx0ZWRfX2IbBjDzkQOrP
 /IXvEEALOLvhfFGNqDWdgYdqktX4RYLdq9Rs5xc69rAjqeAN2l2cyezwz4WeEYQQnLNpyLCNeeI
 wXqZQPdxQCk+nAFpYFSpD9nSIH99O8tUIrVDt59dHvv7ZPFcPlugw4xK9EaOORLA3BHVLAGkYDg
 lv0CgQ4N6S58eKa0YN9AoZ5sKR6MnFO9S8cjhtJkVQFkHwNbTPmfb99KJfI+tGZhgSDCOIOVSaR
 xim77i7lVtvjjdVbb9zJu3a3pJ8qkfkmvf74zED8nHcD+ctmqScAYIkovGE1dns/Gnc1GNaOJpf
 P7YKhlw/C1Jb2mPS2jv3WHcqHlxZqldwPNhGEu9miyu4esbe6wGujargYEIw8GG0/ACPbq0cj+3
 DPzXhVB3Bet5oFEB416epn2bggZkjGwsw6CGK1f1pO8ivakJcRrxPm6kOXlt9RkOKKHeq0QZB5E
 SqU6Yqx+Zo4P6SKkOQA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050052
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

This is version v11 of the patchset and it incorporates the
recommendations made by Stephen Hemminger.

Change made to patch 4/5
Fix incomplete cleanup in vhost_user_add_mem_reg() when
vhost_user_mmap_region() fails after the mmap succeeds (e.g.
add_guest_pages() realloc failure) realloc failure). The error path now
calls remove_guest_pages() and free_mem_region() to undo the mapping
and stale guest-page entries, preventing a leaked mmap and slot reuse
corruption. The plain close(fd) path is kept for pre-mmap failures.

This implementation has been extensively tested by doing Read/Write I/O
from multiple instances of fio + libblkio (front-end) talking to
spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
dpdk testpmd (back-end) performing add/removal of memory regions. Also
tested post-copy live migration after doing add_memory_region.

Version Log:
Version v11 (Current version): Incorporate code review suggestions from
Stephen Hemminger as described above.
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
 lib/vhost/vhost_user.c | 411 ++++++++++++++++++++++++++++++++++++-----
 lib/vhost/vhost_user.h |  10 +
 4 files changed, 383 insertions(+), 43 deletions(-)

-- 
2.43.0

