Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA87C55162
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 03:14:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82DA7402BB;
	Fri, 31 Jul 2026 05:14:05 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 32CE440151;
 Fri, 31 Jul 2026 05:14:03 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V1x62Q1482365; Thu, 30 Jul 2026 23:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=8VTprtjhMF7gVRukNBUFEgc
 sk7EN2i2d8C3d/WNzmEI=; b=o2ine1JYzBTNBzjmUre0n1xdGle9sUH1qiIzctP
 cFBVDg+UU8ymIK/ZdjvA0NlAfY8nlw478/rF99qSItjcOj+LI/G6RRq6yOe1WvpU
 mCTVL8few1FvMrXYp1rngzM+xxXvSqar+bTZFqs1jTmZq73KpnKWF9OWd42oqmBT
 bv/XFRhWs5Voge+vKUyneOc1ZSSq3cUzMtUCKvOGiuEFj7XZ6WK6x6e6jJSCWopq
 Eid8WiHRVZ9ZOJHSaiuSdg5Tv96lLRqtihcDQ8vEZLXbQU/2JeakO9GrWZUHlX9W
 pm0U2DmStTBbtUwk0xNfhjvkBLCOILX8OsQ1RM7wDvJ8oAw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4fqpxcpt9w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 23:14:02 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V1uZYK069061; Thu, 30 Jul 2026 23:14:01 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com
 [143.166.211.150])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4frg0qj64p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2026 23:14:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1785467641; x=1817003641;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8VTprtjhMF7gVRukNBUFEgcsk7EN2i2d8C3d/WNzmEI=;
 b=inmPhn+9hTqy59F0Kr5eMXrAXWHeRFdNdhfHTnHe7nLh5basOiVkOAms
 IP/fgwN7KxQfpy9C3q4Q19xSkJoZS04ibLWQG9RzHg15TARpdzZPk/KiD
 sAjwO4LjndHZb6gzttSlOqWjne/4GFJlo0s5m3JNzmjynr8H1bTvQTmYc
 19eycVZUYV7DcrBJkuWyLzkNgBwUN/vkiINsIU2zPcCldjHG9jYXiiDFv
 Rp8YdDKa6hp0HU4mCwrab/oJ/gUCXnx3plziUSVQnW+3gJzbyB4qqvrC1
 3dCueEFKeiZ8p4HVzB7ojr8yvvz9WKBm4QcDpv8OmQoL/XBp0n3opLD6p w==;
X-CSE-ConnectionGUID: SgeC2BBhRpiLb9UZmmLyxQ==
X-CSE-MsgGUID: CMtBvYv7QjKSsYwpRecpaA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat02.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 03:14:00 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 30 Jul 2026 22:15:25 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 30 Jul 2026 22:13:59 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 30 Jul 2026 22:13:59 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
CC: <stable@dpdk.org>, <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v2 0/1] vhost: tolerate fd in REM_MEM_REG for interop
Date: Fri, 31 Jul 2026 03:13:54 +0000
Message-ID: <20260731031355.3578236-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_01,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310017
X-Proofpoint-GUID: i5HodYVGZZzCQuojMH_L4TwzbsDPHwnI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAxNyBTYWx0ZWRfX9a643ObZ3SXz
 ZApALWA8vgmJRAPh7NXM058wMOSwvjq9zl5BIkRW14HVsTv/jHPwYlYiroC0vNJ2Gbc0EPLb6hH
 j2nBa1pD/12KNRrRTKTzdnah/ISe+50=
X-Proofpoint-ORIG-GUID: i5HodYVGZZzCQuojMH_L4TwzbsDPHwnI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAxNyBTYWx0ZWRfX9fjpifw1ulGf
 IL/a9M0A95daPdlNM3VtKrGUtk9zwnr1D94QVkH+mD+n+pb+jNrYrJVvkPx+YIuLX/Y4hDIToZw
 P2f73XVQOEDpPQtR5mC48Wqs/1kJShy1DtV5oQOxH9YIuXsUwI+0iMq4qyWcfQYurxqsMlUTokA
 CDoS6JUovpqIR52lZfiw8DfmAuazB8k60a9Np3AvYJV9Ubaj+bllgFlz7q+wvBWAD85pU4cKFPA
 Jj1SCFXnrsgSncAMfYq6g7zkLjtFHofEYWCykqYFACEszXE0lwYCPT8JAaHLFM6VvDtF/ZKurN1
 4zWivJs4Dq7odwnylGFDvtg+wmDgAlKgs/7MxPM+GLIhezHsWXNVunt60POQYDDYJU14xMJTwEq
 0/C/yNnyTdj3M8fuV2Z+36HTbP2iiAmtdOt+XEqE7pArs+T2dKTqrcpJxyus1c9A0GuxdKNsBIF
 pTPxS73iZIvRX/jd81w==
X-Authority-Analysis: v=2.4 cv=NIHlPU6g c=1 sm=1 tr=0 ts=6a6c12fa cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=RAioF0-LDSMA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=3cEc0xAJMBXqnWx4iN0A:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310017
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

This is version v2 of the patch and it incorporates the recommendations
made by AI code review.

The VHOST_USER_REM_MEM_REG handler rejects messages carrying a file
descriptor, but the vhost-user specification allows back-ends to
accept one for compatibility with incorrect front-end implementations.

libblkio (v1.5.0) sends an fd with REM_MEM_REG because it shares a
message helper with ADD_MEM_REG.  This causes DPDK to drop the
connection with:

  expect 0 FDs for request VHOST_USER_REM_MEM_REG, received 1

QEMU's libvhost-user reference back-end already tolerates this.

The fix accepts the message and closes any unexpected fd without
using it, conforming to the specification's compatibility clause.

Also added Release notes as suggested by AI code review.

Tested with:
 - QEMU VM bring-up with add/remove memory regions via monitor
 - QEMU post-copy live migration between source and destination
 - SPDK vhost-blk with libblkio fio engine (write + md5 verify)
 - libblkio alloc-mem-region and map-mem-region unit tests
   (ADD/REM/ADD cycles against SPDK vhost-blk)

Version Log:

Version v2 (Current Version): Added release notes entry (review feedback)
Version v1: Initial patch

Pravin M Bathija (1):
  vhost: tolerate file descriptor in REM_MEM_REG msg

 doc/guides/rel_notes/release_26_07.rst | 8 ++++++++
 lib/vhost/vhost_user.c                 | 9 ++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.43.0

