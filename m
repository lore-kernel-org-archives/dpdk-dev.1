Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBB9EB2700
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 10:24:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACE97402B5;
	Wed, 11 Feb 2026 11:24:19 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1E9434026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 11:24:17 +0100 (CET)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61B45LGL366331 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=gqUrUic/BrfzI9ilrdqAM7i
 DdBd4H+Ea1yMPsTvdbHA=; b=KWOPP00dPwlrU7Lx0fEfSX4j2Rjlp0SyBP44LtH
 wcJpzdh5t4te2cOWaqTygpOkDkLT8+QibcwclofsBQUxNyk+dLvAMAelTQp++W/y
 HFrqpW/6cXLuKqyMA8ix2i5cug7jUGYh/Xwra6IduOo/9uBnz2DDJr5bzAVux0LM
 LzO4BPKqkQGI+8y9eE+MtQbNZ4ZivqQTOR9ooWVNQI3LCxMg8IcnUpPPntL+JkBg
 cjf3Qx4dPDh/Op9aqOo7gOi7Gd71F+PJN+4E3+gtPpsqSO93MEXjASNItGnCs9sz
 4GvoxKc+hcivCF3Ux/LYkpfrf5W9LKdiZx67taxb8Mu54Rg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4c629g0arr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:24:17 -0500 (EST)
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61B9xsB71814388 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:24:16 -0500
Received: from esapsmtplv01.us.dell.com (esapsmtplv01.us.dell.com
 [143.166.203.147])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4c8njc9q7c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:24:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1770805456; x=1802341456;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gqUrUic/BrfzI9ilrdqAM7iDdBd4H+Ea1yMPsTvdbHA=;
 b=GrGgyY/1bzJ5FuiH54X3owKNaa5sTNm6ofZ9BY3fVyJ4z1nwn+Zq1dHl
 18kcHnEFecm/PuK22hUDY6O3+cxjuKjNxQ27mHsDL1YrU4LrRAt/lsug5
 ps6cc/60NdqnyQtoo7i+R8zYgq16kNUD3uUGt3Io8eSqI8imEqwowniFX
 h3aqNF1UPlxIFsV0m862WqFdopibwI83mIMdmXZYGytqpcyYSCCday+mb
 XqmQHcus6QmmHjHvWnmjqgkIxFoQ4uHC5dQEZtjr1pF5+8pdbFRQCciD+
 5WZoSMtmIuVNgoczuZ2uUfNm9WUEmiNCyahCS6/MgzYzK7jpSx8Q5lxbu A==;
X-CSE-ConnectionGUID: KI/zRXyrQQ2T+nIGuBFAyA==
X-CSE-MsgGUID: OJXBhfuVRfW49O4vaEyEwA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv01.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:24:05 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 11 Feb 2026 04:25:14 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 11 Feb 2026 04:24:04 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 11 Feb 2026 04:24:04 -0600
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v7 0/5] Support add/remove memory region & get-max-slots
Date: Wed, 11 Feb 2026 10:24:28 +0000
Message-ID: <20260211102433.694516-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110085
X-Proofpoint-ORIG-GUID: fdrB--4pRm32CjjEn5eohGEq06IS9TnL
X-Authority-Analysis: v=2.4 cv=dOGrWeZb c=1 sm=1 tr=0 ts=698c58d1 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=L/h6WUVEnF1aJ0/14Ndw0A==:17
 a=HzLeVaNsDn8A:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iLNU1ar6AAAA:8
 a=bdPje4QtJAzN3LWH44cA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-GUID: fdrB--4pRm32CjjEn5eohGEq06IS9TnL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA4NSBTYWx0ZWRfX/G4h0XDB1CjB
 iCbYNZ5snsl01xnb2qqmrppXt6lC9FnB58IGimWakiyphfjFAxv/HBlmpSGMlpC+XBDQCJtyxDV
 6T5nlxJswgKhRJqKOuJw5DD9kTuMCv9wnzDsl6Yb9w7Yo4c0KhmrOOUMo7JjbCyavElNxvNEC+5
 N1L1SFWKFMaJPfDgHO2dEUmkgCogf7b/DHk2N8p24J1d8L1RmU/T/8WH9mKSuC88qG79+j7MahG
 /ReTY2D7kceShLVJ4FqqO4sJofb+8TMppXWhxW5kH0atsg/3oam4LXeAWMlCRJc7etjcJm6yEGm
 TDJ21ewv7E3BZM5Xf+xn4lSEAVzfiM9eYn+Mn+1bL/9IXMUe2WawTyzPiZHySHVWsDpMoNrNjF0
 Sc8rfcnwI5RmJYix4BRuG+wInUelwN/ZBqco6PVRLQVkN2XY1RjdlR89rK83Fvjv86DUlorcRAF
 nbAxLUfJdXYPTMt7/zA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110085
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

This is version v7 of the patchset and it incorporates the
recommendations made by Maxime Coquelin and Feng Cheng Wen.
The patchset includes support for adding and removal of memory
regions, getting max memory slots and other changes to vhost-user
messages.  These messages are sent from vhost-user front-end (qemu
or libblkio) to a vhost-user back-end (dpdk, spdk). Support functions
for these message functions have been implemented in the interest of
writing optimized code. Older functions, part of vhost-user back-end
have also been optimized using these newly defined support functions.
This implementation has been extensively tested by doing Read/Write
I/O from multiple instances of fio + libblkio (front-end) talking to
spdk/dpdk (back-end) based drives. Tested with qemu front-end
talking to dpdk + testpmd (back-end) performing add/removal of memory
regions. Also tested post-copy live migration after doing
add_memory_region.

Version Log:
Version v7 (Current version): Incorporate code review suggestions
from Maxime Coquelin. Add debug messages to vhost_postcopy_register
function.
Version v6: Added the enablement of this feature
as a final patch in this patch-set and other code optimizations as
suggested by Maxime Coquelin.
Version v5: removed the patch that increased the
number of memory regions from 8 to 128. This will be submitted as a
separate feature at a later point after incorporating additional
optimizations. Also includes code optimizations as suggested by Feng
Cheng Wen.
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
 4 files changed, 365 insertions(+), 42 deletions(-)

-- 
2.43.0

