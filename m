Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE7CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:21:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03F2842F04;
	Thu, 11 Jun 2026 16:21:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C516142F01
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:21:10 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXpk32103994 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 4JWPPhs6FlaL1ueyavTgkenp2ABeRhcZyzaQ57rztg=; b=WkQ6i3v1ZRtcrgFqr
 CFHpCMlLmc/MPTNDl0yUE/LcPqXtBvn4JZcxEaqqcxIh4GUNovpXUjIYGUrsuD23
 ktLg+/5PlR+EO8c2HdQgATbK4fduCkry3gEepvN8rg1XIWHvx8RiNji1WkBwI1dm
 1DtixuCy1iIYq5lR/6Pg1PNItwb4NlD7xIGfEhuL2837r1bhkzCff2peSA8sE0/3
 XuXzLzu9ZGkRG1wqptA1msxdWJM7wNEi42LRXBYnqz4UJ/5EPW6JrtE12CoGUpVw
 hnTmbT/VW+gLAY8VuPzojy0X4SJp/GZ1M2JD2Veye6zMY+y0tWPiYlVGrL4im+/R
 OqFCQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5r37b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:21:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:21:09 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 2DB555B6974;
 Thu, 11 Jun 2026 07:21:05 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 05/22] common/cnxk: configure LSO mask for single segments
Date: Thu, 11 Jun 2026 19:50:12 +0530
Message-ID: <20260611142029.3351415-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfXyhbElG+A+8QX
 EOUfcSOihsCSITTnx11eZkcWtnF/azA0QhnvK+7f1qylpnx73iDQ3C5fY/mk4sjllYw/hsXf6/G
 4jcVoiyAISNu7q/vWSYEiAU5uh8OYHY=
X-Authority-Analysis: v=2.4 cv=O6gJeh9W c=1 sm=1 tr=0 ts=6a2ac455 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=HkXQYvCU1nhRFysMGnkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: x1ssYvPJ3pZ0Xz3A9AzHpFbPsVttBz3i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX67xUDfJTHdVI
 BFyANde7tiUu2WluGEBXeFHLwGcF4NlqUc+CrMlTWjAdaup+QWx1b5BvY8e1UiBs1wW4XqIAGXB
 xC/8AxOhBzyi5w6vRZxJlS2C/uFmGvpSOt3HiW3xcUWByF5yCc/moSy81+rzc3h4yHlHPpzxXH7
 CFoNOCCJJU+Azwx+BaYgqyiAXLdxj1gX0JemS4p61UHLx7y8fJvhU9F4xnUM8JWk5Nf+NO3wgP3
 47gR7Rlg47tgm2/xjwcUnhcGUSCrZDqMfy/kzyeox/Zb8Noz6M3blOQWjz93Cs/58garsFq400d
 1OHbKzGf/zUOYO/7upTFYt76jRA2x4EbqyDN3bTzJMCS3iMjmJeMbb60KVcLtYWgJHhT1shrk7U
 3eogQv6buqCkkfk+17ZutOKSu26+Cc36ki8o/tA8bN9U+4OmOrbV+5drHn50PfrTffjLCBR7/Pz
 yNqbaYRiCqzMN5N1L8A==
X-Proofpoint-ORIG-GUID: x1ssYvPJ3pZ0Xz3A9AzHpFbPsVttBz3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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

Configures LSO flag mask for single packets.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No change.

 drivers/common/cnxk/roc_nix_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix_ops.c b/drivers/common/cnxk/roc_nix_ops.c
index 12a12c6e35..4653bb2049 100644
--- a/drivers/common/cnxk/roc_nix_ops.c
+++ b/drivers/common/cnxk/roc_nix_ops.c
@@ -239,6 +239,8 @@ nix_lso_ipv4(struct roc_nix *roc_nix)

 	/* First get flags profile to update v4 flags */
 	memset(&alt_flags, 0, sizeof(alt_flags));
+	alt_flags.s.alt_ssf_set = 0;
+	alt_flags.s.alt_ssf_mask = 0xFFFF;
 	alt_flags.s.alt_fsf_set = 0x2000;
 	alt_flags.s.alt_fsf_mask = 0x5FFF;
 	alt_flags.s.alt_msf_set = 0x2000;
--
2.34.1

