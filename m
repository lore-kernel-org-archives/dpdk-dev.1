Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34359EA4E04
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 13:53:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AFE540A76;
	Mon,  2 Mar 2026 14:53:33 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5277040A76
 for <dev@dpdk.org>; Mon,  2 Mar 2026 14:53:31 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621NirBs1283095 for <dev@dpdk.org>; Mon, 2 Mar 2026 05:53:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
 /OlsBalM091xPYKQZWRK079ScO6fN9mn8veEIMJ2u8=; b=EuadDmQou1HkuZ1td
 3V72L/lVAp/tJeYeYhn987ZT7Xy7rknvajTJm5h1dwtapZySm+j5kSnPhnZU/bAW
 qS45W9lCC/46Zn0URhufYq8xDNis20CpZsHZV/N/QBFaDoeHdb8WP1bhZL8yK1bC
 a7vclC0kLQzFCs4BjGYhord1+EnRHnbSwWIxwQTQeqdhy3Qhtt6HukvqvCRLbBjw
 6PVikqueKQlU2jFCHg0fD0wpV+Z2a7E2Wee4Gx6z2/o/3rWzfK9IUVg8xBqRLop6
 CFqterACBpIU3/xevJsrPdae8EtjPCMJhLXVLvSUVaLeh1bH0MZa4Fgsjbwi0unj
 /mhEA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cmng8t184-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 02 Mar 2026 05:53:30 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Mar 2026 05:53:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Mar 2026 05:53:29 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id ED4A33F70DF;
 Mon,  2 Mar 2026 05:53:26 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 2/2] net/cnxk: config option for RXC time step
Date: Mon, 2 Mar 2026 19:23:19 +0530
Message-ID: <20260302135319.1971488-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302135319.1971488-1-rbhansali@marvell.com>
References: <20260302135319.1971488-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qePCa6FdD3smoMqJ1lpONgJe8ArqH3MP
X-Proofpoint-GUID: qePCa6FdD3smoMqJ1lpONgJe8ArqH3MP
X-Authority-Analysis: v=2.4 cv=UeZciaSN c=1 sm=1 tr=0 ts=69a5965a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=aLfi41Bu5ofLkWKDA9kA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExNyBTYWx0ZWRfX7Rt4lecJykm8
 z1eirbLlRb3fAzuVpMlR4ngfVgnD2+hkOCSbXZPREXcRLjsK+IQG+09mLcmumLv7FYerjPCx+Ud
 3v0vRenqD+gEu8vxQQNWFjfJ/n27Vmu36NU84UTo+8jrn28p2PHjlhKXX/PH3Gt+9fhFZRIBpT/
 8ndLlrYW6TxddTIoyqiO0YK/RvVuEOmKtwxfsK+acEnB2ALprcAP7Y3dn5E4V3x5EJvx5xQxYJ6
 gRzm6URLXfarTaYo7mu6rzp2dlHIqFSgoT13CscFQ10Oo8E74UBvxHGb4quCCCiLoshSwr0hIEN
 c/q/YBrZO8TcMx10P4XEcB6HM+lXUe8H3YUGxtzJFA4Fa8DfOcoWz3T6G6yOlEWmUHd4PJFp9oS
 UxS2kb8+ffGx79G4DIj6jvksZaWdipimfPTjLR34o628/T5UO7QpsXe9I2kWfGQQ/vWOYQkQPvj
 /q8u2cocX+ffcHP/tDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
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

Provide devarg option to configure RXC time granularity
for reassembly handling.

It will be set as rxc_step=<val> for nix device.
e.g.: 0002:02:00.0,rxc_step=10000

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 doc/guides/nics/cnxk.rst               | 14 ++++++++++++++
 drivers/net/cnxk/cn20k_ethdev.c        |  1 +
 drivers/net/cnxk/cnxk_ethdev_devargs.c | 26 +++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index 9e758a1b5e..c43c70b275 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -494,6 +494,20 @@ Runtime Config Options
 
       -a 0002:02:00.0,disable_xqe_drop=1
 
+- ``Configure RXC time step`` (default ``1000``)
+
+   RXC time step/granularity for reassembly can be specified by
+   ``rxc_step`` ``devargs`` parameter.
+
+   For example::
+
+      -a 0002:02:00.0,rxc_step=10000
+
+   With the above configuration, reassembly time step will be set to 10000
+   microseconds. Default RXC time step will be set to 1000 microseconds
+   when reassembly is configured.
+   It will be used for OCTEON CN20K SoC family.
+
 .. note::
 
    Above devarg parameters are configurable per device, user needs to pass the
diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index 4a3d163c75..f08079f612 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -705,6 +705,7 @@ cn20k_nix_reassembly_conf_set(struct rte_eth_dev *eth_dev,
 		}
 	}
 
+	rxc_time_cfg.step = dev->nix.rxc_step;
 	rc = roc_nix_reassembly_configure(&rxc_time_cfg, conf->timeout_ms);
 	if (rc) {
 		plt_err("Nix reassembly_configure failed rc=%d", rc);
diff --git a/drivers/net/cnxk/cnxk_ethdev_devargs.c b/drivers/net/cnxk/cnxk_ethdev_devargs.c
index 68e6b1d190..da8fc83f9d 100644
--- a/drivers/net/cnxk/cnxk_ethdev_devargs.c
+++ b/drivers/net/cnxk/cnxk_ethdev_devargs.c
@@ -64,6 +64,25 @@ parse_ipsec_in_spi_range(const char *key, const char *value, void *extra_args)
 	return 0;
 }
 
+static int
+parse_rxc_step(const char *key, const char *value, void *extra_args)
+{
+	RTE_SET_USED(key);
+	uint32_t val;
+
+	errno = 0;
+	val = strtoul(value, NULL, 0);
+	if (errno)
+		return -EINVAL;
+
+	if (val > ROC_NIX_INL_REAS_STEP_MAX)
+		return -EINVAL;
+
+	*(uint32_t *)extra_args = val;
+
+	return 0;
+}
+
 static int
 parse_ipsec_out_max_sa(const char *key, const char *value, void *extra_args)
 {
@@ -283,6 +302,7 @@ parse_val_u16(const char *key, const char *value, void *extra_args)
 #define CNXK_CUSTOM_INB_SA	  "custom_inb_sa"
 #define CNXK_FORCE_TAIL_DROP	  "force_tail_drop"
 #define CNXK_DIS_XQE_DROP	  "disable_xqe_drop"
+#define CNXK_RXC_STEP		  "rxc_step"
 
 int
 cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
@@ -314,6 +334,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	uint16_t lock_rx_ctx = 0;
 	uint16_t rx_inj_ena = 0;
 	uint16_t no_inl_dev = 0;
+	uint32_t rxc_step = 0;
 
 	memset(&sdp_chan, 0, sizeof(sdp_chan));
 	memset(&pre_l2_info, 0, sizeof(struct flow_pre_l2_size_info));
@@ -370,6 +391,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	rte_kvargs_process(kvlist, CNXK_CUSTOM_INB_SA, &parse_flag, &custom_inb_sa);
 	rte_kvargs_process(kvlist, CNXK_FORCE_TAIL_DROP, &parse_flag, &force_tail_drop);
 	rte_kvargs_process(kvlist, CNXK_DIS_XQE_DROP, &parse_flag, &dis_xqe_drop);
+	rte_kvargs_process(kvlist, CNXK_RXC_STEP, &parse_rxc_step, &rxc_step);
 	rte_kvargs_free(kvlist);
 
 null_devargs:
@@ -413,6 +435,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 		dev->nix.rx_inj_ena = rx_inj_ena;
 	dev->nix.force_tail_drop = force_tail_drop;
 	dev->nix.dis_xqe_drop = !!dis_xqe_drop;
+	dev->nix.rxc_step = rxc_step;
 	return 0;
 exit:
 	return -EINVAL;
@@ -439,4 +462,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_cnxk,
 			      CNXK_NIX_RX_INJ_ENABLE "=1"
 			      CNXK_CUSTOM_META_AURA_DIS "=1"
 			      CNXK_FORCE_TAIL_DROP "=1"
-			      CNXK_DIS_XQE_DROP "=1");
+			      CNXK_DIS_XQE_DROP "=1"
+			      CNXK_RXC_STEP "=<0-1048575>");
-- 
2.34.1

