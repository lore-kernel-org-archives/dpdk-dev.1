Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6760A3827
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=a07WCGJL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1B6440E3B;
	Mon,  2 Nov 2026 13:22:48 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 9C84A4003C;
 Mon,  2 Nov 2026 13:22:46 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29Dcb0545941; Mon, 2 Nov 2026 04:22:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 qBhALBEc4AFIumChLedbDMvBdIy21dM+XtdkmlrNrc=; b=a07WCGJL2BPwagpFc
 y4c+tvRBJLXqRc601CRyKciE0KoBoUNxKG/FXqbPaUWWP/aiQkjIE20sDhM2Y7b+
 hJ8dyzOwTwuOX2sHubzW0ZBdTLKB7lYg+Xx0kzdPThOKOuM4bMNtDEEncndKeh0L
 8/DWffV3eD5G5HZSpe5CDhsL8rSF0Q73S8azNVEH687O3RqbC0kK5ZUU3wKXxuO3
 kW42MV3PlGsXC+RAhx59goehg64eZxlE5he9nloTPDAmv1iT+g55jHJhNoToGn5/
 NxanycrGpXSgV8rKF92XTIbns+5Prw7QAnLAQ/5QBYZFkjv6Tb+wO+Qn0zhjXFVU
 0WQQQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hp5fd35ms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 04:22:44 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Nov 2026 04:22:43 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Nov 2026 04:22:43 -0800
Received: from cavium-System-Product-Name.. (unknown [10.28.40.118])
 by maili.marvell.com (Postfix) with ESMTP id B84843F7078;
 Mon,  2 Nov 2026 04:22:40 -0800 (PST)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <rbhansali@marvell.com>, Aarnav JP
 <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 5/5] common/cnxk: fix OOB write in rep count copy
Date: Mon, 2 Nov 2026 17:51:53 +0530
Message-ID: <20261102122154.2611710-5-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102122154.2611710-1-ajp@marvell.com>
References: <20261102122154.2611710-1-ajp@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfXwFLw2wrRTso+
 s1yzbENLqjbb3o83pOQmAJ1BnuH6elnlkCELWeesDBx25D+IrPzSChYBvAYcA3cg8jtt5Qd/qa3
 VBqgxF+cS+SaP60T9lJfhZIfZzbltKQWWBJv2KLnMDjnLu/hb8DlsQCsTkPxMYrxKmrHwGbkB+5
 iU9NF7V5RgD5OaUqGq14ROLq6KWuU4tnQPdtX9Npa9b54zSFnDK5KXK18xIFSOUf2tB5ngKgzxr
 YeLqvzsdaYpa4D/H/BrTh1JlU2coZDwOT8X1b6y1DXdWyilrBk8bahHHaBJ6wtrT0iJIFvpLaBs
 sAAaoZmA/rRVgBysrEpjEt4uEECnLkYpJDGqJPbbZs6k1CQirXi+fzcGjzaCVBsM4wDff7djuwB
 cNxdJRG2KJa6IS9QoAN1MxQvrVAzHWNLF1P8Dv2zWjtXCXfQX+D9CsaylKal2ldrNufis9xwC2M
 ARsFgeDp6Fr9ycIXCxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfX1f7nRJxi9kp6
 RIXqIITeshz7kf+p2+5gTU3+lDBH/ihQo15rTzhWWmIDqHlY0nEyD2lAboSjqt05qzYsn0BrCZ3
 nObobs5c1JFiE7TF3bW9Kml5YdkCHWw=
X-Proofpoint-GUID: ncY3VC6aq48sTbWp9_qbo0jH4LRbAbcz
X-Authority-Analysis: v=2.4 cv=bszZl0ai c=1 sm=1 tr=0 ts=6ae88094 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=3HoEVw3OMNDcHY79bEsA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ncY3VC6aq48sTbWp9_qbo0jH4LRbAbcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

roc_nix_max_rep_count() copied rsp->rep_cnt entries from the get_rep_cnt
mailbox response into the fixed 64-entry roc_nix->rep_pfvf_map[] without
validating the AF-supplied count. rep_cnt is a uint16_t, so a malformed
or malicious AF response could overrun the array (and read past the
response's 64-entry map), corrupting adjacent driver state.

Reject responses with rep_cnt greater than MAX_PFVF_REP before copying.

Fixes: 162c77c18838 ("common/cnxk: add support for representors")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/common/cnxk/roc_nix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix.c b/drivers/common/cnxk/roc_nix.c
index 8e3903051d..ae6a918682 100644
--- a/drivers/common/cnxk/roc_nix.c
+++ b/drivers/common/cnxk/roc_nix.c
@@ -589,6 +589,12 @@ roc_nix_max_rep_count(struct roc_nix *roc_nix)
 	if (rc)
 		goto exit;
 
+	if (rsp->rep_cnt > MAX_PFVF_REP) {
+		plt_err("Invalid rep_cnt %u in get_rep_cnt rsp", rsp->rep_cnt);
+		rc = -EIO;
+		goto exit;
+	}
+
 	roc_nix->rep_cnt = rsp->rep_cnt;
 	for (i = 0; i < rsp->rep_cnt; i++)
 		roc_nix->rep_pfvf_map[i] = rsp->rep_pfvf_map[i];
-- 
2.43.0

