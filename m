Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8A8C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 08:10:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2756040679;
	Fri, 31 Jul 2026 10:10:42 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 71D1840280;
 Fri, 31 Jul 2026 10:10:40 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V7uEPB2231596; Fri, 31 Jul 2026 04:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=jtwl7vmSYAm0B+pgvzEccrY
 bd/Dpmgpmm2ZeUbc3AgA=; b=BLen2mBig1eNBzJrn+zj7iiJqemWkUHh6eTxdQZ
 tZZlVDGhHSmZnA5a4MI5nWRsd/3Onzs8qgfH+nXyRV35+v1OxVq4JSiHvu6COCWq
 5hHhCn1T3u0tP3nnWGwppLPRS0D0gHtAhwGXnYwNw4pY5jexhobpskz8kiG7bW1S
 Oa+2jztL3M2yNHzguzMOQw6pQYpVQhOGoplBlQoU7cHu6b34C+b0RCbmeqWTDmBd
 yeSxsLMFp4CgSB+O3x6EDimtVzCwJOc11daZ4sMj6M6MN5yjyiSy/V+vM7IzG72H
 CArwZzkZxwkmgJHDo2bl45gXsvIpaZhI0baZzfLMzfBWjpA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4fqpxcqrg1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 04:10:39 -0400 (EDT)
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V7u8RK3160287; Fri, 31 Jul 2026 04:10:38 -0400
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4frf345s29-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2026 04:10:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1785485439; x=1817021439;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jtwl7vmSYAm0B+pgvzEccrYbd/Dpmgpmm2ZeUbc3AgA=;
 b=MN4a3Zkt70CI6kkUN7oTV/BuhDc7kSu8t5CtZ6HGjV5lcacF/6Ovk9yI
 B9qyFdr5Ah2usvZTW1eAWWVzV3zPECajZuznYYm6z43QJzZQrvxT7qT37
 o4e7Prt9TOLFOHHGTb7WU+or5qZrx9RebBxaYF6D8t5CpKMXgb5zvTnSN
 3Nm9JzaLv4RKpFx0KzLo3vQz6bNiSP5hqu0pOH9WqKXtpSJH4cCyhFXSN
 iDvoEzbmosni8m0JEODnRPqZ3+bEo9riKoTZBi14+ureFRtE+aXozgtAv
 xemuHHGq90IusGh0xluvWnJClLey+joVRRuEcjSWE+/ioH8eH1/XG4U2L A==;
X-CSE-ConnectionGUID: LajC5QLvRF+wNYwQta4XvQ==
X-CSE-MsgGUID: usriOINhQQW+IwKmudoKVw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 08:10:38 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 31 Jul 2026 03:12:03 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 31 Jul 2026 03:10:37 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 31 Jul 2026 03:10:36 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <david.marchand@redhat.com>, <stephen@networkplumber.org>, 
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
CC: <stable@dpdk.org>, <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v3 0/1] vhost: tolerate fd in REM_MEM_REG for interop
Date: Fri, 31 Jul 2026 08:10:30 +0000
Message-ID: <20260731081031.3648665-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310058
X-Proofpoint-GUID: BzQ9FIzFf-6_3GORHNMD1ual0Akr-VzE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1OCBTYWx0ZWRfXwvZIyVSDJyh0
 72YOz7qy3nWNu+GtGp3DwzCbvjSPyJPOG7Cac8J5OFwNRRlT1j1Yb/zoyq7MfpT9HBuH/vrpNZz
 t8TrS14M06UVcjrt/6fmuXBS3wuyN8c=
X-Proofpoint-ORIG-GUID: BzQ9FIzFf-6_3GORHNMD1ual0Akr-VzE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1OCBTYWx0ZWRfX0sincyUC8Wae
 ugaZfhHzerh1SXr6IbzWUK/01tMaqkb6Mm45BjqeITKpdfDe6CYxiA/4fsvezHqBu233F2Jw4Dk
 gXGG97GJPz7xfw4A9rKiu+3OBUy1Kpz59QdKeQ0M5UJi/+WO/3g5ZldOwEu26OgMo7yVBgk1TP3
 RWL31gZpggvSJofcRgnB+5WbmtEWAXKNCdiyyqeQIpabXysjQY+mrliae/7iGVDXd2D001jQcrg
 oVf4ksZUVcZGcIRdfaI2CzNbZdrY04fmwoL8KRTN4KqLpMzNDodd4Q6lMDaN5KZszpMToFBUhrg
 yphyocdtVgFJDDaxDeNDfDEbCJblduR8y4Eqinyd0qQNWxTsHIn/ILpmk1mT7xsTQtJCR3w2tKU
 XGNkVPd4IBhdtv5tZm2a/IlCZ1RW9XUMIZtBfSs34l77S6mN5xyTJAXfLcp3txO7CHyBr9oP2zO
 hTKr2n9r2SyT4Y6Nyag==
X-Authority-Analysis: v=2.4 cv=NIHlPU6g c=1 sm=1 tr=0 ts=6a6c587f cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=RAioF0-LDSMA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=3cEc0xAJMBXqnWx4iN0A:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310058
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

This is version v3 of the patch and it incorporates the recommendations
made by David Marchand.

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

Tested with:
 - QEMU VM bring-up with add/remove memory regions via monitor
 - QEMU post-copy live migration between source and destination
 - SPDK vhost-blk with libblkio fio engine (write + md5 verify)
 - libblkio alloc-mem-region and map-mem-region unit tests
   (ADD/REM/ADD cycles against SPDK vhost-blk)

Version Log:
Version v3 (Current version): Removed Release Notes entry as suggested by
 David Marchand.
Version v2: Added release notes entry (review feedback).
Version v1: Initial patch.

Pravin M Bathija (1):
  vhost: tolerate file descriptor in REM_MEM_REG msg

 lib/vhost/vhost_user.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.43.0

