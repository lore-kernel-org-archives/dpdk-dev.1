Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BCAC87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 04:30:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B1E040270;
	Fri,  8 Aug 2025 06:30:16 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6165640150
 for <dev@dpdk.org>; Fri,  8 Aug 2025 06:30:15 +0200 (CEST)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577JdLwR003964
 for <dev@dpdk.org>; Fri, 8 Aug 2025 00:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=rNteGg757/6ABBrxVw714Q+
 vTrlNGq5ewAf9jnGTSEk=; b=tMo1Guw0fducKTL2hQoB1FABj/q6Us6vFO6gTiT
 NE+///HLPTLPoppRxWEcfQRKLk1y/dXu5SlJcFznQb+AvTpl7VMAEnIbW1PhrNwN
 Yl9shx7hyTJ9r2TagsaN9y25pIuAyN43TxReuQHHBs3ntqhyh1Km0gXZSP5GuGhp
 613tmwqhAaQLriILlGHAI1AK5hSCpSSq2X9/WuBsdMe0GT6mpsTYxvcaatmTO9b2
 kixrQ1ZGsXibtPliBLeG2UtzNeBkJKRppiCUwm+5Yw26auYWJ7jUzF1HHJ8IfHp5
 gVUx+Mv+wZyl4kfIWzYxFPtvFntaArxqrA37QYqezCy/Z7Q==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 48bpws65y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 08 Aug 2025 00:30:14 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5784DwjU005693
 for <dev@dpdk.org>; Fri, 8 Aug 2025 00:30:13 -0400
Received: from esapsmtpat01.us.dell.com (esapsmtpat01.us.dell.com
 [143.166.211.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 48cwj9hnbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Fri, 08 Aug 2025 00:30:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1754627413; x=1786163413;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rNteGg757/6ABBrxVw714Q+vTrlNGq5ewAf9jnGTSEk=;
 b=b625iYax7aRFB0A2HDnLuaChxEGfi/lS8AOYv3i5lnC7uyubuFGmDc/c
 Bw4P6dQyLhx0cihY8JkVnVI5TIFPX/bcmEAMMmF5ebPJ3UBHHIxEMlCQK
 BA+AIVI2ZL5K+1CPwug6xWs6Y2G3iZ4Tm3PIg5f+x4OevAV3LpPGy1lE/
 MhUsw9NLOSCVAn+khIrc12Ik06HvblLkVr7ulTBDHUBpbbx+b6hZJjFpf
 lus3zkvl3YouluyZLBM4qFfxYX11E2U61QEkq0H4OvDDeIeES9UK5FOt0
 e2IaowIcBKgLhOjW2NzjXXId1zJTT4zRXTJ3pEAtFPcDjKkxs3WcZGSF3 Q==;
X-CSE-ConnectionGUID: 2KizkJIPQ2uqqm3ltHVqiA==
X-CSE-MsgGUID: FDuaE4UnTbyEmWdnd0y1vA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat01.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 04:30:12 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 7 Aug 2025 23:31:04 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 7 Aug 2025 23:30:10 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 7 Aug 2025 23:30:09 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>,
 <boris.glimcher@dell.com>
Subject: [PATCH 0/3] vhost_user: configure memory slots
Date: Fri, 8 Aug 2025 04:29:52 +0000
Message-ID: <20250808042955.2386083-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=536
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080034
X-Proofpoint-ORIG-GUID: 2AzeWrXJ1PkUivml8GOrzYltUSu8AoSQ
X-Authority-Analysis: v=2.4 cv=JI07s9Kb c=1 sm=1 tr=0 ts=68957d56 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=MDsIxxkBee3CUfGUG3hQZw==:17
 a=2OwXVqhp2XgA:10 a=ke5jqHz-1hQA:10 a=4gVp8_51gQM-wQZJVKIA:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDAzNSBTYWx0ZWRfXxHlffii8r3rC
 CjbG/Ad1StfNWyD0B8peyPl+molfEZy917GZNtfxXrk2dKe6H6EJT5UcjipoBrC8x3tkwCOcNC7
 drYR1Z/8MkTbCxkdrBGC77Au51sNqWvDdZkIGTzVgZXWaecTE+ysnadJXkqtSuf3ahg85n4uJLP
 kY2JxRU8j8rzcKIPsoNxdqtquoyC+DolHsePemnZQKGWumbqoiFEnrBcOl7u5cs031ivAbqJB/G
 tfFDlkZtlbQ5iMbmsFZiRG2h/jFgEDH4gitBbnHYpbSplX8HyFPPOI2VC+OIJnU5/IfGhvjcvLk
 drREFNZI2ySl7Ak2IJ67HO+2nITky7Ayzeo1O0ahHiP7r37vdw3oeT4OCDbOUAMVp3yRjHXoRYC
 ivAZSWyCrPYC2vfGZWETeHjUH77qZ99paxcy7x2RXJM3e/ofGe3ie1SHqi2qAnIROw3lM5WV
X-Proofpoint-GUID: 2AzeWrXJ1PkUivml8GOrzYltUSu8AoSQ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=580
 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080035
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

add protocol feature support add and removal of memory
regions/slots dynamically.
this patch set has been tested with multiple instances of fio
connected via libblkio to spdk target backed unix domain socket.
please apply this this patch-set to dpdk mainline as well as
version 25.03.0.

Pravin M Bathija (3):
  mailmap: add user
  vhost_user: configure memory slots
  vhost_user: support for memory regions

 .mailmap               |   1 +
 lib/vhost/rte_vhost.h  |   4 +
 lib/vhost/vhost_user.c | 325 +++++++++++++++++++++++++++++++++++------
 lib/vhost/vhost_user.h |  10 ++
 4 files changed, 296 insertions(+), 44 deletions(-)

-- 
2.43.0

