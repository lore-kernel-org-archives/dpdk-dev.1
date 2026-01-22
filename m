Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E69AD625F5
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:48:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A55AD4026F;
	Thu, 22 Jan 2026 08:48:54 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 17F47400D5
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:48:52 +0100 (CET)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M4Laa2027999
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=jK9kKlzorAoXhehglkVNlBs
 6roiZx3C0wMuNlmSYoP8=; b=PAf8MwSE20xdK1o+nBPT7YuF5CY6ogALsWhem4R
 gWssEPlvirBLaPw2xFtzXQTlqMw7ec2LCOddtjzK4JBpkhRtZRyqLoO1MmD3KKNu
 ktznk/DWqGghmj69napTEt5Y3e48MfXUzEdY9WSUQS1ZTVpRuhbGH6o1pFpJk3g4
 f0uWDuAM+UUOP87FujU885rg4d1zNMOwFLnx24Pwppml5uAnpL9BeCqdlW2vbsM3
 jNkgorztdMxqcY+izzGyseuDylDLNWdaP/4SiPZLOKeu/Z3YRUWbjE5lQnFFjUP5
 Ptpfnd7gfdAzG5ntHzIkzrFhCgDi58P/CLhx/E3IOpTFF5A==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4br6ewvm4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:52 -0500 (EST)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M6RfXX017224
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:51 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4budb6sq5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1769068131; x=1800604131;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jK9kKlzorAoXhehglkVNlBs6roiZx3C0wMuNlmSYoP8=;
 b=qZ7Sk5KonwELN5c0YR5wKcOlxf63c9dPQIp6HArNI8oiaOLPfBJ08XcZ
 8Xkbk99BSZmuPfkr0hRyNCK7szegGHI6XnyUEPxLtre6zWMV/41PYSp0w
 MMRKomjEXKsvk8s6Uc2MQbszpXwDTBu3D6rhiZpcff1xmBMl5UF/Jgtxo
 SkLlc+bbp9G42sxS2IV9Dle2RV+0tcG53Yoo7WVYfinVxb1q/L8vvw15G
 D7echGaESeBycLmtnF2AtkpqNDsxWiwpCyWRdRABDMYtWQYTMKlwr4Z8Z
 8bz/uCKfvg0KLgzX16KixvcxcythecxTyZ3MXpFr/B2k/IoZ4paMSvqfT A==;
X-CSE-ConnectionGUID: R49MZyluTBG2ZUB5pkf0EQ==
X-CSE-MsgGUID: Jyq7UEUdRT6mj2BDHSmZMw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 07:48:49 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 01:49:52 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 01:48:48 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 22 Jan 2026 01:48:48 -0600
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v6 0/5] Support add/remove memory region & get-max-slots
Date: Thu, 22 Jan 2026 07:49:01 +0000
Message-ID: <20260122074906.127942-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220050
X-Authority-Analysis: v=2.4 cv=Sdj6t/Ru c=1 sm=1 tr=0 ts=6971d664 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=vUbySO9Y5rIA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=bdPje4QtJAzN3LWH44cA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-ORIG-GUID: RuBQ-lUDyx6zq3uPxMCehNz5tEKLuiUv
X-Proofpoint-GUID: RuBQ-lUDyx6zq3uPxMCehNz5tEKLuiUv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1MCBTYWx0ZWRfXw6G+FjZDjQbR
 /bKX+16d4+ZujUK3cbRlrmmQadB5v/+3tpFhyvqyeu0qu4UEIgLmdo8J/gigNMUI6LTDiBN5pHT
 D6kYEyECm4J2n6nXaJGBdvt8njvZX/CMJrTMLGRZIkeuO0/aNWt69BXaIqbbDwuOcEJPlO9DEY7
 NtDblDBtKT67hRbwfrleM5P4ZkdqHw6lziMvpF0j3XLpYMuJR7yQQ9KVhlPjifW4Zs4NUrzXGEU
 itUTzTjRvmNoHPUpQ22kYVPTHglySfzW6bPw85vLbeT8stm78tAt6oX6yhBmm4Usr9DQaY7L883
 4+rRnK3qmzMe37eAxC6kvX9yKulrbvuC5K0DpdvkWtQk6P1wW3ahmyeqLRqf0RlzMjVhE91xazF
 k406mHzWZM6N3+CIKXpybxN2nGQRMfjvhK8edx2zTaQAISMCoPwuL8OuNsoVfmszfAG4wvw6Meq
 wuKLBmTNsn6rEm4BCVw==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220050
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

This is version v6 of the patchset and it incorporates the
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
spdk/dpdk (back-end) based drives.  Also tested with qemu front-end
talking to dpdk + testpmd (back-end) performing add/removal of memory
regions.
Version Log:
Version V6 (Current version): Added the enablement of this feature
as a final patch in this patch-set and other code optimizations as
suggested by Maxime Coquelin.
Version V5: removed the patch that increased the
number of memory regions from 8 to 128. This will be submitted as a
separate feature at a later point after incorporating additional
optimizations. Also includes code optimizations as suggested by Feng
Cheng Wen.
Version V4: code optimizations as suggested by Feng Cheng Wen. 
Version V3: code optimizations as suggested by Maxime Coquelin
and Thomas Monjalon.
Version V2: code optimizations as suggested by Maxime Coquelin.
Version V1: Initial patch set.

Pravin M Bathija (5):
  vhost: add user to mailmap and define to vhost hdr
  vhost_user: header defines for add/rem mem region
  vhost_user: support function defines for back-end
  vhost_user: Function defs for add/rem mem regions
  vhost_user: enable configure memory slots

 .mailmap               |   1 +
 lib/vhost/rte_vhost.h  |   4 +
 lib/vhost/vhost_user.c | 384 ++++++++++++++++++++++++++++++++++++-----
 lib/vhost/vhost_user.h |  10 ++
 4 files changed, 357 insertions(+), 42 deletions(-)

-- 
2.43.0

