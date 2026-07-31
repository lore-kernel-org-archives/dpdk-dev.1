Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A4DC55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 08:10:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DA36406B6;
	Fri, 31 Jul 2026 10:10:49 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 5DEAB40280;
 Fri, 31 Jul 2026 10:10:47 +0200 (CEST)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V7tx3E2398491; Fri, 31 Jul 2026 04:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=U
 i47wLpvCCSpcoCtTGQadtslFl9qsbAttOT1cMX+59A=; b=gj/IghoTDvrCywFqU
 I+DbsSzoWO6DjnasyXs9yXVFCVoAJMA9wCkBx2suQT4nG3Zju9tOPoBWwFWfxSOq
 EGykR1F+XEfIATqqPmTzw9f1rCGHMjv9gGcGFujADWhgBhTc2jZLRN1kVSu9vkGf
 7mOgwqdJkjSB5aW8yJGu65B5lYpxSzsrCrHAK/fulDga7rVBpU/EWXw70ijzPzVx
 pd932xafUhGdXbPxXBBCWCFGgB1HVTWsakux3jl990wcEV0/0IWaaJTqrF9YAyfA
 fp3x1iz7gdFOFuz7RTGsRmLmisv3ayBl7bsO/idDG0mSBXM+PVFgDbsLi6MDYI04
 bWeLw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4fmstg1vv9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 04:10:46 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V7ttpQ3254154; Fri, 31 Jul 2026 04:10:45 -0400
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4frm93tjdx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2026 04:10:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1785485446; x=1817021446;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ui47wLpvCCSpcoCtTGQadtslFl9qsbAttOT1cMX+59A=;
 b=QaNOWmHPSX0zO42uzTg22T4lpsLQOu8SUTpsEO4F8AlynUEajE8YG3BN
 axFd3sKp9IO0qP6/L2+MvRDdKALxCymokXse4WJBTNS4BMoHtyq0H2g/D
 /YkUcs+XuBXhmM4XXmBIQki4dgAdzGBvDikuB0LNSroUXH1f+3Kt1lL/a
 j7eaiwWSXpBwAMMGEl/ZYMudfHoOQfWC1GSM+dBnD1heIyosCbWj1bMNG
 9hf0ndZskVyTVKXy1AOgsz+FVDOBRsDvWFRBk5aAmFvTVI3KeetnzIOMq
 z+K106/tjfOZlopww6GUQc3YBcdLCjSd9lXNYROfSolAnnuScvqOijVLE Q==;
X-CSE-ConnectionGUID: nhBpNDUbTFaH6a2RTvblVw==
X-CSE-MsgGUID: Y9Bsq82BT+C8vgI48fg//g==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 08:10:44 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 31 Jul 2026 03:12:10 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 31 Jul 2026 03:10:43 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 31 Jul 2026 03:10:43 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <david.marchand@redhat.com>, <stephen@networkplumber.org>, 
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
CC: <stable@dpdk.org>, <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v3 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Date: Fri, 31 Jul 2026 08:10:31 +0000
Message-ID: <20260731081031.3648665-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731081031.3648665-1-pravin.bathija@dell.com>
References: <20260731081031.3648665-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310058
X-Authority-Analysis: v=2.4 cv=HLfz0Itv c=1 sm=1 tr=0 ts=6a6c5886 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=RAioF0-LDSMA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=Qy6CKLcU0MZ4grw4BCWD:22 a=iLNU1ar6AAAA:8
 a=8rWy6zfcAAAA:8 a=K4t2kwVcIw6_QTpaq4MA:9 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: TpNsjUg-NCUE6mtrFHG4TPnKteiZceqY
X-Proofpoint-GUID: TpNsjUg-NCUE6mtrFHG4TPnKteiZceqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1OCBTYWx0ZWRfX8yQxsvuZymr1
 lUHytgzakVXObNH3GfxrfpKcmfizEnrqmYpXjcGB2hW1F387U1Oc9lSEBLXY7FwQCXyT+NFVgOv
 6AGIsMrBqitOodh9KR19Uf/HfSdVHmEVUGvnqJzS6t5zgiHwZ5ar1EfhwIYa40367AFrL2KrAIF
 XtpHPn37dPTtxHGvJnc9va2PEw2dxbkninMTd3rvILREzYskFGxHzSTrDgUowV2uQhKtTz8Uxrq
 XhD4LzUFu785IcsS5U3grkEEz277Rxkp83ydJRicjTOjQ2mdeauVKl7Zxc4ZXKc+fLlR3TelEPh
 0a9Ub8Py3QGx6IywSGuWb/k4QhuYmEU1dDEIXHZGyTztdG9rB2/yfaFQ1P/rz4ud2SaZcphDcEC
 hSJccTVioL/kgcrI1t00QL5VOHi8Hs3IAw3BPY5UzABArD0hFFtZlES8uO7wH16bl2iNlBl9rjb
 BW1dVsRpbq+RtVrvD6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1OCBTYWx0ZWRfX3OOjPsyTMmgi
 LGBB+3/D8NfbrbllL/ktBlRm4rG7TJ1rnKwJwDTIOAWwTh/O4OV8iLP16enf9yngBUHkhbW086Z
 AVbI0JN4S6sWYZUnYCXmHd9m3y8oiJw=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
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

