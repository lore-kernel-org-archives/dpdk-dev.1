Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F44DCD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AF9942F69;
	Thu, 11 Jun 2026 16:21:40 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3282943274
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:21:38 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXees2094976 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
 U1L18vtpu7+EaSK9DbDlT64CRagD7bsDlBFnAIjBS8=; b=jBnB1uaQ6U+Roh14c
 BiOMhxIZBKwScjQhWRTzcC5COkc85PJq5KdXv6errE7KZWWchhK78Zu9b10T3A23
 zqeFFSDokUkIVuJ/QJ7wnJApWQffYZIs3RtITPFoSxC3rt/sSBjTymi6znnQbAzj
 Wpf5kMVcjDp8w54ARP5oeZYL++JMsVniLXpy1GRrNn4NpmpwazHsrl6cql96tJhy
 DQQjJ+AFOgEuGkH3uv9SQ+odACVtORvX/a4WDaHuGROF0AEJZqaxd87Gnk4pohVF
 IxC7inNYBd5MB5IDklwO5LHJJ9/WTjtUgY8cXRrcg8KdxWIJ84ayIWQp2b6cx7Mi
 IZUuQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5w370g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:21:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:21:36 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 001965B6974;
 Thu, 11 Jun 2026 07:21:33 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v2 11/22] net/cnxk: enable CPT CQ by default for inline IPsec
Date: Thu, 11 Jun 2026 19:50:18 +0530
Message-ID: <20260611142029.3351415-11-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX1rkQkP39pCF0
 +xGABTlyKI5IxPVqvTsjHv0n+9x2DcbZ4SQvVCjZisHhthSe+TG8v/V5PoDnVKEW9UFF+WHeFyk
 2LrAFCHm3USNEm8/u52PSFq4Bol7gByekHDhMqcvuEm5436BbwhXpMcWcoCzw7zJ9L+Hg5JpQ5z
 +JOKGx/CtAH9E3eKP04dUoJs5qsn6gwdyo13hTnhIrtKavxCCC5o02oN4XLlQJ1uNWpKNwyVh0e
 ByhFTY2euUMsXJnRS0mT/7BMnAvNvubi/20HRGZOeTUPFQe4Ve5CiRADGlJqa+0QgBiKlJ9GLZq
 B3bL1s/oi/TmoVYjfusPsj7BzIMWuZPsgnaIbW2+kHb+yiOmN/t1DKoMOJwV2SZSkes8IJMBYz5
 tOEmWbCCVkJqGaIHNEHe6eMJVMer1hTeOZWBTAZl8pDi15YT+p9auW/VCF0DBF5BeEsSxBO7Q0A
 0qZoCY8jE+qAM2dM3Gw==
X-Authority-Analysis: v=2.4 cv=fv7sol4f c=1 sm=1 tr=0 ts=6a2ac471 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=ZZU3Wc5vmQXhhph13kQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX2i6DcdB+QtT0
 HK6wQCJ/7CThZGoUVUl1cIaUfbrVfSiuExZhIXuFu+LD30rPG2Z5hRpEvnKY+/o8+1DpXQMg4Ai
 NxD971NzACoyzZmB8LbeuqMdlERHEZ4=
X-Proofpoint-GUID: nPSEvD_OLu5VHGsu-yILIr-LZ-wSHHit
X-Proofpoint-ORIG-GUID: nPSEvD_OLu5VHGsu-yILIr-LZ-wSHHit
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

From: Aarnav JP <ajp@marvell.com>

CPT Completion Queue is supported on CN20K and provides
hardware-based completion notification, eliminating the
need for software polling. Change the default value of
cpt_cq_enable devarg from 0 to 1 so that CPT CQ is
enabled by default.

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
Changes in v2: No change.

 doc/guides/nics/cnxk.rst           | 13 +++++++++++++
 drivers/net/cnxk/cnxk_ethdev_sec.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index 239ebcd05c..c71029e1dc 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -745,6 +745,19 @@ Runtime Config Options for inline device
    With the above configuration, inline inbound IPsec post-processing
    should be done by the application.

+- ``Enable CPT Completion Queue for inline IPsec`` (default ``1`` for CN20K, ``0`` otherwise)
+
+   CPT Completion Queue for inline IPsec event delivery can be enabled or disabled
+   by ``cpt_cq_enable`` devargs parameter.
+   This option is supported on OCTEON CN20K SoC family.
+
+   For example::
+
+      -a 0002:1d:00.0,cpt_cq_enable=1
+
+   With the above configuration, driver would enable CPT completion queue
+   for inline IPsec event delivery instead of using the err-ring poll thread.
+
 Port Representors
 -----------------

diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index fa7eacfbe4..61eb55ba43 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -742,7 +742,7 @@ nix_inl_parse_devargs(struct rte_devargs *devargs,
 	uint32_t meta_buf_sz = 0;
 	uint8_t rx_inj_ena = 0;
 	uint8_t selftest = 0;
-	uint8_t cpt_cq_enable = 0;
+	uint8_t cpt_cq_enable = roc_feature_nix_has_cpt_cq_support() ? 1 : 0;

 	memset(&cpt_channel, 0, sizeof(cpt_channel));

--
2.34.1

