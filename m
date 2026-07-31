Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6558BC55162
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 03:14:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC791402ED;
	Fri, 31 Jul 2026 05:14:07 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 534CA402ED;
 Fri, 31 Jul 2026 05:14:06 +0200 (CEST)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V208161456527; Thu, 30 Jul 2026 23:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=9
 dHWTaWFV86Scbq454cZYC5DVZkRyH/gyiQVGNqodJI=; b=s/1ld0sMJPFfR0BY0
 Bd+aSZWsbSPgQ5s/th2lajuACQnssXoadevUB72yWyGCSufg9qUBAy0PkmKeCaeH
 R0ScqgCQifxA+LCZ/ROrTT0rL6Danv8wsFo9RV6zprbT3xNT/4pBX/LRyQRmN3Wj
 yruMP+h/shx8MzGjjJcGAWXRlDUe8ocV02hcJi1lCA2WxIooU4PtGcmlw9Xi8PSQ
 B2bwoMHQw1g3YjkBnCOdFYl4SjxMHhjZNlO72zD2RpvNoZn/f4mgZMeeVK20uVUC
 7Sd45CzLUdNhxkKnP1l8O+8BaUUJU8rhk5fCt8lVyCEJ2iuk5HHsHUcHqRBBkF+n
 bt1rA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4fqp3by0mp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 23:14:05 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V1uZYL069061; Thu, 30 Jul 2026 23:14:04 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com
 [143.166.211.150])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4frg0qj64p-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2026 23:14:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1785467644; x=1817003644;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9dHWTaWFV86Scbq454cZYC5DVZkRyH/gyiQVGNqodJI=;
 b=Lzd/PCBoBKg8YWCOTwjun0uN/CIoLWX5qYPBJu+ZecEJBcEqAcv0oV9l
 YJMPn96rcxaG3XYJbAdktlk+4WoAlmV/tfwloN61gbfb9pQGncjJWRb2y
 iGqsSiGxWVYaWxxSOe64/COyrSjXSorlRerhX3xPSIi2yzwhTfgG0wHc8
 tRta6fA2XS6/KTYQogmh7/+FWGc9WwDjFM1m2DjroYLbIPNSgqev+ce48
 JO+KxPgyha+uAMfTrNDZepOrCTW1arLRifl07CEM7JHSLzMyujTa9sEqG
 TNsFlKX1h3ZeF32zwbxy7tbeKOMon43pMm9P4l11lgT+PYYdY3eGR1LMc Q==;
X-CSE-ConnectionGUID: VzL/FLDkRki8u1x/3oxTsQ==
X-CSE-MsgGUID: hzl6nJjAQze3WLd0u69txA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat02.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 03:14:04 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 30 Jul 2026 22:15:29 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 30 Jul 2026 22:14:02 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 30 Jul 2026 22:14:02 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
CC: <stable@dpdk.org>, <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Date: Fri, 31 Jul 2026 03:13:55 +0000
Message-ID: <20260731031355.3578236-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731031355.3578236-1-pravin.bathija@dell.com>
References: <20260731031355.3578236-1-pravin.bathija@dell.com>
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
X-Proofpoint-ORIG-GUID: qxCtberrtVpOF157yrZ_fQKJYQNGxweu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAxNyBTYWx0ZWRfXwgUqach6Jb+f
 +7utbaGIJ9keP/xeQjFhELE/AzAkDIM+mpbbd2czdUr/PVrRiMrT4PbK47q2MLFkBtvrTWIDxT7
 NIftgoU0TSEa5xqpYWLAO1YDf8uaCGlH9oJ49MAq8B3OT5eBt8IRHO1oItbC8YWiabJAhgN5ekN
 xSQ5Ax8+RLC6DYol9iO0DcKDa9nnOP93CU0lIA1F2BVXtW+BozSaamNphM6oUCx/xQoSdtu7IUW
 KjUaqbkvcQQSJWu2tlwc31KYYOsnpo3EllaHeIFksxhc5zThgN+2KPIfMbvPVgNtpmPZlzxNKu/
 FU7DghZIgBPBpjZnibH8s4H85SfEyOJLSN0UYjHkWpPW79BA4llwQ1gLNWcIheasviSN+e42ItK
 KwjRQ+JtMkV4fx+6E7Ko+pZt5RnvfAa3CLNC5umzGRgS3mqP/S13h6Tfazt/Dzl8CZnPcmJV/xx
 tCNg2MYnmaEBQuzr/7g==
X-Authority-Analysis: v=2.4 cv=Kp99H2WN c=1 sm=1 tr=0 ts=6a6c12fd cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=RAioF0-LDSMA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=gLxAKuEMs0EQMVFiDJnH:22 a=iLNU1ar6AAAA:8
 a=8rWy6zfcAAAA:8 a=NEl2ZuJTfHH0q2ainhUA:9 a=gbU3OgOOxF9bX48Letew:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: qxCtberrtVpOF157yrZ_fQKJYQNGxweu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAxNyBTYWx0ZWRfX8YWTfl38lXJ4
 7rvwq4Q8ieA9i30jW4uxiSUeFFc0tVrC4sAiZQstkV6mbXBkZhzYZXpz391GknbngsIr7kw2c2P
 KwGqhjrrl0UHtD4pieZ6EXSGVnacak0=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
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
 doc/guides/rel_notes/release_26_07.rst | 8 ++++++++
 lib/vhost/vhost_user.c                 | 9 ++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 3d18ba2dd0..86042bd5e3 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -85,6 +85,14 @@ New Features
   to support adding and removing memory regions without resetting
   the whole guest memory map.
 
+* **Fixed vhost REM_MEM_REG compatibility with front-ends sending file descriptors.**
+
+  The vhost-user ``REM_MEM_REG`` message handler now tolerates
+  an unexpected file descriptor sent by the front-end,
+  closing it without use as permitted by the vhost-user specification.
+  This fixes interoperability with front-ends such as libblkio
+  that unconditionally attach a file descriptor to the message.
+
 * **Updated Google gve driver.**
 
   Added hardware timestamping support on DQO queues.
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

