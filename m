Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2114E83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:44:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4BEC402EE;
	Tue, 17 Feb 2026 06:44:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0A5914029D;
 Tue, 17 Feb 2026 06:43:58 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GIxa4N1907473; Mon, 16 Feb 2026 21:43:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
 wa/JgJvz/o/6jhz87EZsdbFNzSDFlF3NOlzy7aofvs=; b=NMmUjSIiIFAMT3eI3
 x7VZpPGgJNYm0h3jzzdmUPUt5GtTFmjLZ15veX9CYPc93/4SbxGzjphT+WU+3j3B
 F8j2IK5MMvPqsqrpb6U8R176jhLGQcQd/p06PdpmCCidhcUB3xHX8yCMQPJJGRE9
 TEyMCffIy0nP6+JMJ/vs1DBgJrc6jh86CBayF2heBO2LUM06XgXnyJqACe3rB/GR
 UnxNS6ePUZC6kBqla/7HXfgMpFCrpyaIIOlXFWbMy7OYwlAK+cLs221zReliyhcK
 U677z0kZpoN+HFfRjWD1QYgBJ1N+KixZvoLz7b0+DaaEfpokclZ5t3CylXqWNMhg
 NMUWw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cbapcb7rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 21:43:58 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:44:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:44:13 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 11A6B5B696D;
 Mon, 16 Feb 2026 21:43:53 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 01/18] common/cnxk: fix engine capabilities fetch logic
Date: Tue, 17 Feb 2026 11:13:28 +0530
Message-ID: <20260217054345.2759687-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=fMw0HJae c=1 sm=1 tr=0 ts=6994001e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=PnxCTWz9nqBHbpKa4poA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: CH_sqqN6kztBCdd-hQk3FZpJv8-mbaM-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX7rLU/vX8FMuv
 w50FPp37XPcw2dKGw7kGwiDJ8xeGXa6j87dHDBg6+uwJqQSwM1i2L1qb+GBVSA5LZeJNR5oX7NQ
 cxwuwp6HooWc+sbhXHHgUqMW3lJK4m95dt0U+uOz7OxZRIwEd5Wa+xFJTF0FJSFzKXtHW5fAbas
 CdDvpaztfuF9mjoUNoS/nBA2UZ3e0Lg5XmrL4fJkub8irD0nXB+P37u1xs6m1fIOIs8WYCBRv8i
 1HZi3QT/oN+EdzUb5NRrJPXF6pUG56uNoDA4Sc3BF8aGkU0o0DtnKTxLL1Z54bkhsCXoCGqLe9t
 AekfSiR4wNbEkEC6Oc2q9A/RO9TfaaqUvi2Jp2ioVkIuyjch1FOjAQyQWsU6ndvZpZcaswYaCzl
 /r+xlwq9y7rzyaHHzgQq/cRvVuaAUTMBCKjXpoztAp9hClASlA6O6drg0ROzi1D8xd5dlpRcYn0
 RwfnCKcK1Y+isGbOXQA==
X-Proofpoint-GUID: CH_sqqN6kztBCdd-hQk3FZpJv8-mbaM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

For CN9k platform, incorrect status is checked from LOAD
FVC instruction while retrieving engine capabilities.

The loop is updated for a valid return status check on
LOADFVC instruction.

Fixes: 7c67c489d466 ("common/cnxk: fetch engine capabilities")
Cc: stable@dpdk.org

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
Changes in v2: Updated commit message. Removed not related macro change.

 drivers/common/cnxk/roc_nix_inl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index f8be98efd5..683a9cc7ce 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -1228,7 +1228,7 @@ nix_inl_eng_caps_get(struct nix *nix)
 		do {
 			roc_lmt_mov_seg((void *)lmt_base, &inst, 4);
 			lmt_status = roc_lmt_submit_ldeor(lf->io_addr);
-		} while (lmt_status != 0);
+		} while (lmt_status == 0);

 		/* Wait until CPT instruction completes */
 		do {
--
2.34.1

