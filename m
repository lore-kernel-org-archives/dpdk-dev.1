Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455E8CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 07:38:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54DD54028B;
	Thu,  2 Apr 2026 09:38:03 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id ED71740275
 for <dev@dpdk.org>; Thu,  2 Apr 2026 09:38:01 +0200 (CEST)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63277ncr1378916 for <dev@dpdk.org>; Thu, 2 Apr 2026 03:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=8e5tIjkAAYKPD2K1xpF+fiC
 0+VnJ5kRQJz05FqTrUdU=; b=XjuiFGmjk0K+lY/Eq3Wsu0nd5fqilTWlBAjJZpU
 HzlBTV5pyDEccGnBxJ2Zc3lS2TYUznMIiH1XusqfuuiIJCENfnqPPBGhhldHajAv
 /fKWzYQysBTeUYz49IBylQHgDdZKPHkdzOKcPbATjWwzV07M51MG5o8U5LOcJ66f
 iffKTpS6SNNBNUyl39NI8SrYN9iG5glMdGBtDlGJJQokz2V0DnEVj8T0o03jbp/g
 BG0w8btNAOg3YCZ+FbtzF0uYw7tJYpqYxbIkhPfwCklnHqGRfuRGEzGVJStjHSpL
 LCD3porolvKVmKdWJyzqYl7HinYzzpJGut/8E4QLEQlQaZQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4d6attydq8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 03:38:00 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6327W4tO417671 for <dev@dpdk.org>; Thu, 2 Apr 2026 03:38:00 -0400
Received: from esapsmtplv04.us.dell.com (esapsmtplv04.us.dell.com
 [143.166.203.152])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4d9fpbb209-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 03:37:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775115480; x=1806651480;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8e5tIjkAAYKPD2K1xpF+fiC0+VnJ5kRQJz05FqTrUdU=;
 b=pmqtoAWdwMmHuHcSBJZS1ZQB+Ed75xpkos2VbHQH1gT24gqsNTCrn8kp
 d/LdhHNC/UR9AjsFGTah5ikyxoFZ2FEv3a7lCLqp7NEMoH3lv40nzqNEo
 HUeUCqf1ZSe8b1kaLY840WjPdaXb/G/Ykcojo+zVZurAzEWqM3dgJOfT8
 AeK+r+c6exBl1cyneZr9aZUvfG8jJ7Ajc0OkbSA7WI6mRhItWw9tKd3+4
 u5VHfq+5+48rHcC+u5YtGCSez0N1+KEayTJSKVy+JHoSnV6PccvfAHooC
 n5bnipadfT3j43JrwMbfHOHT0yWPBtz676XqCngjjQuW+RxSh6bD9So+L A==;
X-CSE-ConnectionGUID: Jt4gIDIYR9uR2/30Vkh56A==
X-CSE-MsgGUID: je4HG5jiToebQAn5ykgEQw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv04.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 07:37:59 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 02:39:01 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 02:37:57 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 2 Apr 2026 02:37:57 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH 0/5] Support add/remove memory region and get-max-slots
Date: Thu, 2 Apr 2026 07:37:58 +0000
Message-ID: <20260402073803.3068147-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020066
X-Authority-Analysis: v=2.4 cv=Hp572kTS c=1 sm=1 tr=0 ts=69ce1cd8 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=XtseytAk/c9oG0Kwoj6KRQ==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=fe1keu9KhAX5AoWrZvs2:22 a=iLNU1ar6AAAA:8
 a=RilTStGhrQvzZSyXj9oA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-GUID: DQFOVe3adE7rsBze3HgHzHXxg20zRaUB
X-Proofpoint-ORIG-GUID: DQFOVe3adE7rsBze3HgHzHXxg20zRaUB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2NiBTYWx0ZWRfX68m5aPRsUO7Q
 udhiYQ0xLGXWH4mbloOLt6D+76l8AgZ4eZ4WYPF1U9eELp1Hj19ynQMqsXRcCVgd12/u/cq1bjg
 FsIgkZToi8X2IbIRqQ/z0ARqii9G5n++QAVWWBGbKV0wIIZ2xGSsvmNFHcH7TBqB4Cl83l2tJ/v
 Ul1NnCYsjDIIC1mSyUPAzd/YpETiK0zHEKLdvxKYPEFkQsiraWEtelXAYyVWBztWL2sOlhmbhGz
 QlWB5D4rqHfOME9hdc1WwJ0mYB713DR89Hl+XaGif5NuQNUXpQ3epjOm7EwQXwK3F+s01biB484
 CdJqxzkqnDA2kcIMuRxpJCgiy27X7WeJWCE7nxbG6ZoL684hqWjz5pME9NbYNKs+NT+10NrLPFN
 OG05ZxoxPha9BMM995sQFv8UbTCPnUm2kErs6Gdzu5V5O9tI18E8ZTYnGJOyi7skiH6R1eTt9Qz
 0mMv/BNn+me4ON411hw==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020066
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

