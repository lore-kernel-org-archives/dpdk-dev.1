Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6188CC54ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 15:54:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8E7D40B94;
	Fri, 23 May 2025 17:54:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C748840B94
 for <dev@dpdk.org>; Fri, 23 May 2025 17:54:47 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NDiU8g008845
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
 XjEDH3JPfQu9x94l1i5YPam+P3ZNlWELZndya6nE28=; b=adaqpU7CE5Ng6QCj3
 +IBX51c9TXks2B+7G8+UwIcmeeaElkIsTR3GMN5eMetRFyUuIHTkGRHScK+6yzNw
 MQgbAyVOIPvpexHISDyVij8iOlryarOvC6dacd3FeIqj2CdK9clBQsePnR84Bwn9
 ltqMox/KjWqnBtuYXgD5mjiZoRzKkaSP5JnB8WWLeR8gHXmDakmUefLI3B+4ILTO
 U4B8tTusRQlg7atv6pdmVwTSb9FyXnHnBtvbHDuJ4hPEbyuvupUrm00j3BTfEROJ
 Qz9jMTmBQlASj22HRu8wngLsQIRXksJSIrOc00iWNCP00cdtP9LOM7L4yLPgDDt+
 0erqw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tt5w08b1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 08:54:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 08:54:31 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id E3B323F7078;
 Fri, 23 May 2025 08:54:28 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 3/6] common/cnxk: update CPT parse header for CN20k
Date: Fri, 23 May 2025 21:23:44 +0530
Message-ID: <20250523155347.1156891-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523155347.1156891-1-rbhansali@marvell.com>
References: <20250519125424.1435140-1-rbhansali@marvell.com>
 <20250523155347.1156891-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bYBrUPPB c=1 sm=1 tr=0 ts=68309a47 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=K81mkqCTapQ1dLxXzbQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: DNi75w-jtG4Hnal46NvW9hQwcYpXTQfb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE0NCBTYWx0ZWRfX3EgZHDo12Z8B
 68RjfeR83mSNZROykSznrTt/n08a19n0rQ/ItTjrZtdAAp+FiCm8vRSHaj9YXHxeVrrN099F3Rc
 04r7EuHWNpuZ51ai0ynzzjI+z116yVnHqO8F0foPTDMgLqEessSZzCPxILB7KBZOXxBagigByLi
 /PRMPgYlimWpNEPLuXHGCoQB/Jprf+uG9yfIBp9RngAd83BWHZd+Xwn3ZbdWX3c0xtbzJvhapU+
 Y8vM/pMfYaqwof4/17q35yXIcKiHKmjGDMhWnUTwpUybgKY4pwWsIBtdO9qr8tweAf+FwJd28IH
 FSxQG+pJJ3OO0PlwempnqTt5lcINyb2dD86/jJbGJJRKNmiBnFQSDfPUjQfQ6pQCWLXXmSxrGFf
 M/1YOyMJV+MUt5dQQOj0aa2OnidHh3yOyOS4hEzF72tKNKiDdsJ9NZESZI+0NiOfSqvblWka
X-Proofpoint-GUID: DNi75w-jtG4Hnal46NvW9hQwcYpXTQfb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_05,2025-05-22_01,2025-03-28_01
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

Updates CPT parse header HW structure for CN20k.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: updated commit message

 drivers/common/cnxk/hw/cpt.h        | 12 +++++++-----
 drivers/common/cnxk/roc_cpt_debug.c |  8 ++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/common/cnxk/hw/cpt.h b/drivers/common/cnxk/hw/cpt.h
index 40987abbb9..e542f3a3d4 100644
--- a/drivers/common/cnxk/hw/cpt.h
+++ b/drivers/common/cnxk/hw/cpt.h
@@ -358,11 +358,11 @@ union cpt_parse_hdr_u {
 			struct {
 				uint64_t rsvd_134_128 : 7;
 				uint64_t pkt_inline : 1;
-				uint64_t new_pkt_aura : 20;
+				uint64_t rsvd_155_136 : 20;
 				uint64_t orig_pkt_aura : 20;
 				uint64_t il3_off : 8;
-				uint64_t ptr_pad : 3;
-				uint64_t ptr_offset : 5;
+				uint64_t ptr_pad : 5;
+				uint64_t ptr_offset : 3;
 			};
 		} w2;

@@ -383,10 +383,12 @@ union cpt_parse_hdr_u {
 			uint64_t u64;
 			struct {
 				uint32_t l4_chksum;
-				uint32_t l4_chksum_type : 1;
-				uint32_t rsvd_298_289 : 10;
+				uint32_t l4_chksum_type : 2;
+				uint32_t rsvd_292_290 : 3;
 				uint32_t channel : 12;
+				uint32_t rsvd_308_305 : 4;
 				uint32_t sctr_size : 4;
+				uint32_t rsvd_314_313 : 2;
 				uint32_t gthr_size : 5;
 			};
 		} w4;
diff --git a/drivers/common/cnxk/roc_cpt_debug.c b/drivers/common/cnxk/roc_cpt_debug.c
index 35a2cf6b3a..28aedf088e 100644
--- a/drivers/common/cnxk/roc_cpt_debug.c
+++ b/drivers/common/cnxk/roc_cpt_debug.c
@@ -36,8 +36,8 @@ cpt_cnxk_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth)
 	cpt_dump(file, "W1: wqe_ptr \t0x%016lx\t", cpth->wqe_ptr);

 	/* W2 */
-	cpt_dump(file, "W2: pkt_inline \t0x%x\t\tnew_pkt_aura \t0x%x\t\torig_pkt_aura \t0x%x",
-		 cpth->w2.pkt_inline, cpth->w2.new_pkt_aura, cpth->w2.orig_pkt_aura);
+	cpt_dump(file, "W2: pkt_inline \t0x%x\t\torig_pkt_aura \t0x%x", cpth->w2.pkt_inline,
+		 cpth->w2.orig_pkt_aura);
 	cpt_dump(file, "W2: il3_off \t0x%x\t\tptr_pad \t0x%x \t", cpth->w2.il3_off,
 		 cpth->w2.ptr_pad);
 	cpt_dump(file, "W2: ptr_offset \t0x%x \t", cpth->w2.ptr_offset);
@@ -53,9 +53,9 @@ cpt_cnxk_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth)
 	cpt_dump(file, "W4: channel \t0x%x\t\tsctr_size \t0x%08x\t\tgthr_size \t0x%08x",
 		 cpth->w4.channel, cpth->w4.sctr_size, cpth->w4.gthr_size);

-	/* offset of 0 implies 256B, otherwise it implies offset*8B */
+	/* offset of 0 implies 256B, otherwise it implies offset*32B */
 	offset = cpth->w2.ptr_offset;
-	offset = (((offset - 1) & 0x1f) + 1) * 8;
+	offset = (((offset - 1) & 0x7) + 1) * 32;
 	frag_info = PLT_PTR_ADD(cpth, offset);

 	if (cpth->w0.num_frags > 0) {
--
2.25.1

