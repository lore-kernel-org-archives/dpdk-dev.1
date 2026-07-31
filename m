Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEFBC55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 01:19:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CD05402ED;
	Fri, 31 Jul 2026 03:19:13 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 8F589402ED;
 Fri, 31 Jul 2026 03:19:11 +0200 (CEST)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UMsO6i1083647; Thu, 30 Jul 2026 21:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=U
 i47wLpvCCSpcoCtTGQadtslFl9qsbAttOT1cMX+59A=; b=wPf7YHxyORaZau05J
 vlx+QA3uwkpbvw8M2BB6B3oD0P0/eg0++MVI3G+gw2TYQ/DZ9hnPSSEdSQbaFwTL
 hdXBkCkFAGcU27z+UPM/i7W4pzTJEwh8FCt6uWdXAe1XYLp2VPfH8IzKkmAii64a
 mdcu7xaMo7qGOmPCgvwq5eaKAsugevFeio6vSxcAIzSlsccQ/5P4YO4LupuO6EmP
 i/TFZ9LHWUGx7BvjvfW2s/LIHB3+T5VjZnOOJ6DRx7JTWCwSa7IEtUVQikMohpBa
 2kQpdKDA4IJSWRsBip5H2JH18YdFY/frL1X2JHmjHsjN7/EoCYiYIXPIvJRh7jrX
 D6TsQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4fqpgqekh1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:19:10 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V0mZgT1672721; Thu, 30 Jul 2026 21:19:09 -0400
Received: from esapsmtpat09.us.dell.com (esapsmtpat09.us.dell.com
 [143.166.211.151])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4fr81ghees-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2026 21:19:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1785460750; x=1816996750;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ui47wLpvCCSpcoCtTGQadtslFl9qsbAttOT1cMX+59A=;
 b=MM3WE3REm9Zw3M5xS0jyD7Oc0ZAr1cyXh9NTJblbjkHb9bfxdemRndbZ
 mg5EMFeIIuIXrcB7S34gwTp0kYRTfZWYyTgBKTEx9/mSzBZ+TgIPIYo3r
 d4WRlZkVnXHPMN//uIs9qe7zsmg4R8lu5K2hQuYAUPmRXzvLMPb1onEtT
 CiSnSKAKrVGY2gsOiw7QvBx2TMANlss0i2WbAhWdm52xjQ4jwVP9P2Y+Y
 UGv5ICWupSI5PxL3+KCo1l7HAIBsD8nyrmz5zpCESf/J/YMK78N/0Htgz
 u5Q/oiEem1Aj+vfjHGc9MHf2/95svbNCgS/5MJ4vqbrbLqk8QvzVSiq6r g==;
X-CSE-ConnectionGUID: QBs3nd+8RxW4qsQlHmX5/w==
X-CSE-MsgGUID: OR4HNvD8R9WvZ5C3M9XN0w==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 01:19:09 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 30 Jul 2026 20:20:12 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 30 Jul 2026 20:19:08 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 30 Jul 2026 20:19:07 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
CC: <stable@dpdk.org>, <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH] vhost: tolerate file descriptor in REM_MEM_REG msg
Date: Fri, 31 Jul 2026 01:19:00 +0000
Message-ID: <20260731011900.3518573-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731011900.3518573-1-pravin.bathija@dell.com>
References: <20260731011900.3518573-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310006
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwNiBTYWx0ZWRfX2tiLeR4v8G+4
 n36D4G7QPNfI1ig0reWn1zXDIRydcCjWMGsHI3l8OpqsNC2fLrJU0PyncTgSoxndMMgZxlYsEaD
 Ae4TRHBrBa15pzwajFeJqU0ZnOwwno0=
X-Proofpoint-GUID: VbUXrE2usk-mOkn7k9QPJ8HLl8d1INsy
X-Proofpoint-ORIG-GUID: VbUXrE2usk-mOkn7k9QPJ8HLl8d1INsy
X-Authority-Analysis: v=2.4 cv=NtDhtcdJ c=1 sm=1 tr=0 ts=6a6bf80e cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=Vd41IKOgs+CGE2+bDnhSdQ==:17
 a=RAioF0-LDSMA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=fe1keu9KhAX5AoWrZvs2:22 a=iLNU1ar6AAAA:8
 a=8rWy6zfcAAAA:8 a=K4t2kwVcIw6_QTpaq4MA:9 a=gbU3OgOOxF9bX48Letew:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwNiBTYWx0ZWRfX+W4W6d97gZeX
 G3tj/uoGPIinhvn2AZcWvt/quXGHFipcZH7mDoey4Bxnkl5CYlb5nWVlUJ+n5fnfdtvZgZJqOsi
 r/gaND3wKWj8/qhpwr2dyMuZyBi24W0xIa484qgn2chq4jtQD/j2WxPrLMbfadVODEf403dH+t9
 m+gX3/xk8WgUOAUctdKNVMRa+5pOvBMbK+Sv7Wha6QgZ3jSAemwCcRpl2kCgYQN/yhzebH9XOMS
 7qBKuoQyL+kqgQUKfFnc1qy4FdBY4IoY6do2lOK7N/LIWAcQqeu0QbtS3/yXe2dd+mc9Uh5NfJF
 PUGeBDlv8RKbR07iloVqf7PPYFmWkEd3g9c5NZVGvBYAFuctOHyOk56BJ5I6Ya9zVXX7X07ZmKL
 sJWzO0z2qZEtvL1OuNI3c1R9AWGEsouyLGEZo83UrmIPL/L8TACsXmK3egTg4mcKJUqX3ib61vP
 VYunLnkCgyh3ImUn3fQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310006
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

The vhost-user specification (vhost-user.rst) states that no file
descriptors SHOULD be passed with VHOST_USER_REM_MEM_REG.  However,
it also says: "For compatibility with existing incorrect
implementations, the back-end MAY accept messages with one file
descriptor.  If a file descriptor is passed, the back-end MUST close
it without using it otherwise."

Some front-ends, notably libblkio, reuse the same message-building
helper for both ADD_MEM_REG and REM_MEM_REG and unconditionally attach
the mapping fd.  The previous implementation rejected any
REM_MEM_REG carrying a file descriptor with the error:

	expect 0 FDs for request VHOST_USER_REM_MEM_REG, received 1

This broke teardown and memory region hot-swap with these front-ends.

To reproduce, run any libblkio (v1.5.0) application using the
virtio-blk-vhost-user driver against a DPDK vhost back-end.  The
connection is dropped during cleanup or whenever a memory region is
unmapped and remapped.

QEMU's libvhost-user reference back-end (vu_rem_mem_reg) already
tolerates zero or one fd in this message.  Align DPDK's behavior
with both the specification's compatibility clause and the reference
implementation by accepting the message and closing any unexpected fd.

Tested with:
 - QEMU VM bring-up with runtime add/remove memory regions via
   QEMU monitor
 - QEMU post-copy live migration between source and destination
 - SPDK vhost-blk with libblkio (fio libblkio engine, write + md5
   verify)
 - libblkio alloc-mem-region and map-mem-region tests exercising
   ADD_MEM_REG / REM_MEM_REG / ADD_MEM_REG cycles against SPDK
   vhost-blk

Fixes: 1d730eea6a42 ("vhost: add memory region handlers")
Cc: stable@dpdk.org

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 020c993b29..82c62f2f64 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -73,7 +73,7 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_reset_owner, false, fal
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS, vhost_user_get_max_mem_slots, false, false) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg, true, true) \
-VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, false, true) \
+VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_base, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_num, false, true) \
@@ -1811,6 +1811,13 @@ vhost_user_rem_mem_reg(struct virtio_net **pdev,
 	struct virtio_net *dev = *pdev;
 	uint32_t i;
 
+	/*
+	 * The specification says no file descriptor should be passed with
+	 * this message, but some front-ends send one anyway. Tolerate it and
+	 * close it without using it, as the specification requires.
+	 */
+	close_msg_fds(ctx);
+
 	if (dev->mem == NULL || dev->mem->nregions == 0) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR, "no memory regions to remove");
 		return RTE_VHOST_MSG_RESULT_ERR;
-- 
2.43.0

