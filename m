Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D17EDB7EB
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 22:41:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91B7940261;
	Wed,  8 Apr 2026 00:41:27 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 7CD134013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 00:41:25 +0200 (CEST)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637Lm8Qi4000697 for <dev@dpdk.org>; Tue, 7 Apr 2026 18:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=xerRjOqqHUU6ekvF++7Li7N
 KcdlSTsLybGZIynCtRJU=; b=XMb26RQlVWpn1C8HGMRDNxhikqFnA5mFuwHrlRM
 YUYqq7umXrEWs42knZcJsfA8TmPDex9skYJNpEViP1gve2OXEJhsjfGwYEYRufIn
 bQ/whn1OVKtCnZnaEz4UoDTWpbkV0x+9poF76ng3ZxpiNpsRwwmFz9qCySJNu+TH
 ofWTUK5Y8UUnEdXWrVXzu9S2RD0PKoJ2PwZb13hOd3wGJKIFpJbpXl5Qf7lrZHw/
 EaMKAp78Zmd8kfp/ghNpmloyaSH9deFoJkge4m2umkhsOyFUko+Hx6Tl6Krnhv97
 jHkdCKbgrJerRFNTlETan7Kit8nIc2nyDIOzLI+m1QEsAqw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dda4x07gk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 18:41:24 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637LmGKK3408395 for <dev@dpdk.org>; Tue, 7 Apr 2026 18:41:24 -0400
Received: from esapsmtpat03.us.dell.com (esapsmtpat03.us.dell.com
 [143.166.211.152])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4dda5ngnxu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 18:41:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775601683; x=1807137683;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xerRjOqqHUU6ekvF++7Li7NKcdlSTsLybGZIynCtRJU=;
 b=kzt58xsAwNo7r3E60crKnLgdgbrrKr/ErJT88agc1cuyUVw2EShP8iha
 JvOgr+aLbzu/E9azWHatpJ9IQfpIGDviK9gTTdGOInXiOuIspJ+5y1Ita
 gaNsVrqYMHgpiW2qa87hAGrH89yK6Cr5Hz1CtFXEPSe+dlDcdjG3olW+U
 HHkRv/K72MWBzh0Dd7dPGhGqua95oloDKD+7tEwiR3X+ZqUDE1aLpgnUb
 ylBh1GYc5Ng7Rywqyad5LG8oAnW2/S3HgjdshCTJ6AWxFip1IB6dvp1cf
 oCqe/t/ZaFDhLlJxqnZwkxIM+vahcwWyer7WjSq9WHRPg9mnmctJSo2IP g==;
X-CSE-ConnectionGUID: OnPFj65rQoKAG/MfI+rM2A==
X-CSE-MsgGUID: 0JUqDaaYQHCCt9crSXnmQQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat03.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 22:41:23 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 17:42:28 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 17:41:22 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 7 Apr 2026 17:41:22 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v10 0/5] Support add/remove memory region and get-max-slots
Date: Tue, 7 Apr 2026 22:42:00 +0000
Message-ID: <20260407224205.3910803-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070207
X-Proofpoint-GUID: IGWiRwHC0qfO0eyyeDcpyVu-kIFlMQDT
X-Proofpoint-ORIG-GUID: IGWiRwHC0qfO0eyyeDcpyVu-kIFlMQDT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDIwOCBTYWx0ZWRfX/0theoGS/f3d
 f2s1EI7hr4HsVP80MImM0JJ14Q1ZLR425TUgpMN9l8TFluXoJ6WKA7t4/nP79tCS8u7E7M0u6Cl
 Eso6gHkwLKx52/XGICfE8KF2MFg6LnwF0sg38/SMLEY1F4BWckWt/GLB02oE/82FefKBmBMlMJ3
 61jhg3mIBCLK9ysd46WMy9lvuLSn3iUE91HWb6H+0fpRZgUPFsgV4/fQp2rihut7u/L7X3FZx/k
 eCrWS+QnObxhqUa3GKBnur2D+UaS9/ofPk8dj76LbAVCVbXqmk0gHUOPgvjljsl43p4NrhvEBMI
 ZqPqOpur9ZJeP+Zc0JbypMbMEsVuNypuJ7gE6uDOqtMYiCDD/FSfo25ACyM0Yppx2meD2gW5weA
 qUszuLz8dToxeWHveh2FVk1XsjtqWrJMobPYqzcxkd3zBQv7RFURMA9id7uowm/I/PPFYOHw707
 q+7vmSlrQPlJRaecXZA==
X-Authority-Analysis: v=2.4 cv=RcKgzVtv c=1 sm=1 tr=0 ts=69d58814 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Exi4HLWdEtKd1bGGvbjpxg==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=fe1keu9KhAX5AoWrZvs2:22 a=iLNU1ar6AAAA:8
 a=RNmmVWOz6b1SMx3EG9wA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070208
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

This is version v10 of the patchset and it incorporates the
recommendations made by Stephen Hemminger.

Change made to patch 4/5
Moved dev_invalidate_vrings after free_mem_region, array compaction, and
nregions decrement. This ensures translate_ring_addresses only sees
surviving memory regions, preventing vring pointers from resolving into
a region that is about to be unmapped.

This implementation has been extensively tested by doing Read/Write I/O
from multiple instances of fio + libblkio (front-end) talking to
spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
dpdk testpmd (back-end) performing add/removal of memory regions. Also
tested post-copy live migration after doing add_memory_region.

Version Log:
Version v10 (Current version): Incorporate code review suggestions from
Stephen Hemminger as described above.
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
 lib/vhost/vhost_user.c | 403 ++++++++++++++++++++++++++++++++++++-----
 lib/vhost/vhost_user.h |  10 +
 4 files changed, 375 insertions(+), 43 deletions(-)

-- 
2.43.0

