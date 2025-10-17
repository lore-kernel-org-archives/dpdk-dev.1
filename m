Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0ABCCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:43:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D93940ED4;
	Fri, 17 Oct 2025 06:43:21 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
 by mails.dpdk.org (Postfix) with ESMTP id B8E0240269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:43:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ab34hmSie5bQjyWdiHq/CI/MpvAis6YezwTFs0SyV8MMXeh9VQd80wN5t3UZF6tyQsVlhL9pyHChwIk9TFBreBEgA/fq6+xzaJRLAt0t6HMxG8cHfcoeRwj12SAhLYp4N/8igrWsE6rKKHReUDqeqPnYci5PIAA0aBVdfGY1e9aXUbEeubuiHwbCtckHv88Q3YXy6kg+oQwptuIOesQ12NdM5TP8ng8P5/Mw0ITqYgcT7IG4DPMb1rrskq8EvZKhZ7Bo7KtBLy00hnQmV4xPCsUKxs0h3Xz5U8pVfZbWYgGB4iY8QmXrYBRKptjTG+isGAUSZs4HtbOzC69aExKVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MA9ghmNVrUXRJ2RBQToS+X4MybVs5WxXy0vmFvRgXCA=;
 b=VjByfi0amk1vAzfuCTvAgy89Gbo/Fmw9wojSa2VpqX7xTQEr+7vF3a8yHwNEYAO3v5pF1GzB/G9CyjC5L0ta5uet1DXvrjNvu82enHEWAloj84I6uwhHsDC5xUcisPdpfWwTd4X/d+6nH6vXxDodbPTVb7/D1sJB+dr+ObLAKeA1gqPEMHC5SMXAANTi7dEuCmxqHSkSIqyskxvPsidXwt1vkqSpoevfc47w4xXiXMnrHK0NzFFxCWwJ9cf4itEtkWEz1SBgPRLfApQLqj1qQQ06kC3PRIu9cJdUdXP8qdk+5croVdIaob01GJ4+Em88WYyMHv+v2IR4osEMyGiFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA9ghmNVrUXRJ2RBQToS+X4MybVs5WxXy0vmFvRgXCA=;
 b=HZgax3DB9XAqMctvoHpHide0FpV+M1V9849XQKsk4/NAV7KQ8+s5c/diRA23XFWj5j6QoO3G8Q/wvh5CsDHgYLThjMYW/EtHq93npsEom8dBP5vj7FUPVU7G5zWbdKJfMX7bRdIA41PBwbW7AEJT6olJ9p3iMdM/JhKERq7VE3B4xPC7SUuzOqP3pKHYtcud2xHIMUHmAol7o74Ech7BBVfeNpufufz9ZmwKZWjUDR535WQWdURZqFmuqNog2YsM5F8RfJd/i4pcM1ccBwvrCBUN6Seqi9MgwdcFdhNLRjQISV5xgooM9OUOGxCLUbw0DtxRtcBDfCpKd2oZVRX6SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by GVXPR04MB11655.eurprd04.prod.outlook.com (2603:10a6:150:2c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 04:43:13 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:43:13 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 1/6] bus/dpaa: add FQ shutdown and improve logging
Date: Fri, 17 Oct 2025 10:12:51 +0530
Message-Id: <20251017044256.3264737-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017044256.3264737-1-g.singh@nxp.com>
References: <20251014101716.2885563-1-g.singh@nxp.com>
 <20251017044256.3264737-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|GVXPR04MB11655:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6e812b-276f-467e-8b5f-08de0d37ae8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nMvgInuIZKsHdk70Bilhk3VZDaMzfrEizw3Bws+IG4ys5Y8EN9b0DNXNwYae?=
 =?us-ascii?Q?rIJYBDs8AjfBFPcd/JjBCNW6019JuhKvhZgGWo4Rs/YbX11Cj4ZJzR1E88mr?=
 =?us-ascii?Q?OPK4RtrsxSnawHYI+5Vr+8s21n+fJ5Xmw6vKo9o6OeakgagBM6Q21FBylWb+?=
 =?us-ascii?Q?G6DnZ2eZP669jetCLxPyRZqPRNTqgFGT5Hu66sbivvC/pA/kN4L6F38EtR1/?=
 =?us-ascii?Q?barVEHOtNp+9qoKIWpMn0hx+4HaEfebArx8krKmMlx3DrGxmp6tE76jcb8It?=
 =?us-ascii?Q?6rO0fKV5SHUydgZBm2oBAOC7hzoT4eYZ4oO0ENWFClV9a6jb7KBl6+uSqqDR?=
 =?us-ascii?Q?597UxAoH/Q0fYt78NURdN1Nwa0s9h8v8JHxrN0OJx0Garqr6pfjazmnuGbwk?=
 =?us-ascii?Q?hg9BLdt40e4XPvg0GCU/gWi4FJASjPosslBjhbPGuliF4uekxX6lDKdJE3do?=
 =?us-ascii?Q?2elnJIRIHtLm2IxlLYsCwHqhhL+nvjkik0ojR5pu45iyj4VoYllEbmlESE1z?=
 =?us-ascii?Q?nNAwlB+qvDMkKI0nafceltjyKTqMNjznkAsbaKjkMU8y3WPnvpJA6w8V6WuB?=
 =?us-ascii?Q?XQY7eBdg80Vqgdzs1mLJHbDk1SWrTyLviRdneKuv85sgejK2HGajhLwVBAmt?=
 =?us-ascii?Q?8xXpjwOZruP9VSbV8yswnUVl2jKkUcD1eA4bmHUoSZ0oh0ojuVmHb2Xrudhx?=
 =?us-ascii?Q?tEQVmFTORtmgQxqg1wc/YtAw/YmAxJ8oSvhDJxmIdV37tkk+DtaFw2RB+Ev2?=
 =?us-ascii?Q?Kcb+DtEjfx21FgQ89C7RiSYztInEcGffqZO5Le3QDbab4O/3Dn18HxkbMqzV?=
 =?us-ascii?Q?7blRf9EA9Re82il29ttMaXOGjn3h3tYDklLB3C0RpJVjzQp/3i/Vo0td+gMt?=
 =?us-ascii?Q?pm5kqHxNu7LPMk7EfOo4ccHUZuAc3Gmpgz4FEx+fC4s7MQBpxLn/lRvOq+Rf?=
 =?us-ascii?Q?OCVdGhBXKcpjwH+VhxlHMmHSCFFE2OeKHSg9FOmFW8PHSACi/p+q/xvj70um?=
 =?us-ascii?Q?z+/lpI+EWY73e8sPUb/BWSfRaPJyhVsU3hgGgwjLJ4+EzLPfdqqkPpOTkvXH?=
 =?us-ascii?Q?DrjvaA74Z6TM+3yBTQZQjobNOEvLKwHPx0Vxq68SixOKozv5r6JxpakkhJMZ?=
 =?us-ascii?Q?kAL22T0ztmv4OMhH3v3//RF1MPFg14hU+YR+GeZ5dEITku0IifusosUoEoQd?=
 =?us-ascii?Q?E7kgO7g29/7P7Ojrwwk7sOTerRwvpHfpQ9IzZvMBWwRjnP3AoRnsgLKIopWH?=
 =?us-ascii?Q?FJygyGfVIFA7bIQb9YpP8tkwgxivmY3aEDkdlaoTaepBmFaETffpMYb10Trd?=
 =?us-ascii?Q?YKx+OWhPI+4Vg+CA1QNBHHsDhc1vAEgeNxunc6hg5GyPyoQIZZVGwja34UuQ?=
 =?us-ascii?Q?2zr54KMZKxBt+vMeEuW64+XeRkXlBj8hxcVbCC13+I/dSThRzoiPQDBBFBFm?=
 =?us-ascii?Q?zEGLPwrvX2aD2uWd/ow/c4znHEA2D/NWDOkxWcl6nv+8hW1Wpbzv9brsvraT?=
 =?us-ascii?Q?sVLp6WhnYDmjQ8GSyfJpQAg5NaQsgASc8X7O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VNy6X2D6NsyqiQ/W0fx3bfKh+skDP8h/8KRQ0XZgEU7UIWW4jhwIbLhb30J1?=
 =?us-ascii?Q?Tx8/2A1fTjxsLuU7TkMw9yMGHHv86Hp+0D8bniVpJMYzeox/zF2ULQ6lhPKh?=
 =?us-ascii?Q?HDKlWFMUgDepHAMR5P++wbwdofM7/jT22ynm7+FZDQ76IshCDjOJGE8hrgVe?=
 =?us-ascii?Q?Z3oTibzLPRsdGtSZz2KUJtU1qYmgGsL7VaMZaLmEdTHIKYn2FHbw4Huzp8R4?=
 =?us-ascii?Q?bJdoAcweLe+cmv1aysJ8I5Bmq74EQQMAddLo4FAJBYhGzA8G5DiY0gCjREBq?=
 =?us-ascii?Q?ZSPQVETFQSI7zuN4tO3BKMUbgkTAcNqaQynixeyPG9kZZuD7WNx3XcN10ZlE?=
 =?us-ascii?Q?IiMxiPMFpRHszS/Qo2ezTh9Gy8iLcVrYGMD/l8jhNH64aNRaxAK1vIB25Oih?=
 =?us-ascii?Q?aUE8urlc64iHUk9dk4nntXgWgo5Ke8IquKuZautoDDTc0DbW7fK5p38KMS8V?=
 =?us-ascii?Q?hZiFLg41ZZG5vgR4ZbYOUSpblgMnDLjes7a6Nc6Ppf/jjfNSOLKjqPFbxrIB?=
 =?us-ascii?Q?2JEOAKvxUBsWTw7vu/ZNxoZOoR2yuxzsHzl3vD97kmv2gK9vHkqYdxa3BB+A?=
 =?us-ascii?Q?qHQz/gSPpgy8hrQJgJodNxSXtg+q5ZoYudF6dgtwoa9570Nt8F/5E8Bg6yXn?=
 =?us-ascii?Q?kBnip7lGUo9JNa8POoihftc+OSo8373/LmaqrVNpqktW5tTv6BHak4orttkh?=
 =?us-ascii?Q?Fhw4BzTvv/MZ+UnoswziymU71ToG4y5CAolQ+vYBAexqsEyYo9RuhyQHGt9A?=
 =?us-ascii?Q?/sVxlSBoCv9nTcd87Jze6Tn4un7OmeQByz4Bl5IpIKgMy5ktl1yrwBCv0vIQ?=
 =?us-ascii?Q?p3U8REMXoOSdz8qANDDyxKJ+dGLujpUH2/AG3/VQ/YdsNAxt4iTSZCrxyl7g?=
 =?us-ascii?Q?Wfrim7gLnwiBvmpntRGq/DJVrkG1Zb+W0Fq6GCIGMZqJw7n2/VZD6rFKsQ4/?=
 =?us-ascii?Q?WufDxFD7S4LRFS3L01DUsq++rZlgV2xmx+SmiB5xRS3yeea7KRLpw3rUq7hk?=
 =?us-ascii?Q?c4DLCG5wapXBl6kf1mADxDGiU9mwF20NP3myf3w90+iymLfDuGAx0KUMBFv4?=
 =?us-ascii?Q?HG/NUps2gfUQ/vGeUxpR27+fCkaXe/7Hl9KtCShmGBckIOKy0jyxi2xyu8lf?=
 =?us-ascii?Q?aIgSfICBALrrAChrfPkPGB+vbLDy05hom9QlAiuFOBomLS+fNEvbNTMVttzm?=
 =?us-ascii?Q?QDXUQPVldvxcVRjtPDBj52pRKvjXT6iwfCuIrMi/QQXKZ2PzL2Oi9DeQDh8Q?=
 =?us-ascii?Q?O7Ca2aLCYDAp5TSGUFGHfNy/U4IzoeaAbppEe3K7JK4D3TTjyRpcktAGpjes?=
 =?us-ascii?Q?Ew0IGEiRiJ8CfYLOUXzP2Fzbri7T+8vzTx2EWSKMVnXrQOL97zFRTKhC6q7A?=
 =?us-ascii?Q?F7lHp5l9DWYp2jjlv7IQWnv+d6rsBpaLopFr3sdNba/WzOOlXs9502G8wvRN?=
 =?us-ascii?Q?Lh/ef6O0Jbz8pbq6O5iOc7ilnB4YVSfoB5RNd676bAhuSLmpKLWqwCAcI8gZ?=
 =?us-ascii?Q?M+8PbNizd5FOvqjC3HPHhU14FilZf1dvweagEPJJZBo1bBD6+uLIhmQ2wtXD?=
 =?us-ascii?Q?ypxKmdurrOCu8ZCLh4A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6e812b-276f-467e-8b5f-08de0d37ae8d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:43:13.8691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAKRB015MBd/7/6KedjliNAlFtquhQ78aRm+0fR8rQXy6pjSZvWCnu7A8Qhi//st
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11655
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

Improving and adding a FQ shutdown functionality to ensure
proper cleanup of frame queues during queue setup. This helps
reset the queues reliably and prevents potential resource leaks or
stale state issues.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c  | 367 ++++++++++++++++++----------
 drivers/bus/dpaa/include/fsl_qman.h |   1 +
 drivers/net/dpaa/dpaa_ethdev.c      |   3 +
 3 files changed, 236 insertions(+), 135 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 60087c55a1..7c5ccc51bc 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -10,7 +10,8 @@
 #include <bus_dpaa_driver.h>
 #include <rte_eventdev.h>
 #include <rte_byteorder.h>
-
+#include <rte_dpaa_logs.h>
+#include <eal_export.h>
 #include <dpaa_bits.h>
 
 /* Compilation constants */
@@ -532,6 +533,41 @@ qman_init_portal(struct qman_portal *portal,
 	 * config, everything that follows depends on it and "config" is more
 	 * for (de)reference
 	 */
+	p->addr.ce = c->addr_virt[DPAA_PORTAL_CE];
+	p->addr.ci = c->addr_virt[DPAA_PORTAL_CI];
+	/*
+	 * If CI-stashing is used, the current defaults use a threshold of 3,
+	 * and stash with high-than-DQRR priority.
+	 */
+	if (qm_eqcr_init(p, qm_eqcr_pvb,
+			 portal->use_eqcr_ci_stashing, 1)) {
+		DPAA_BUS_ERR("Qman EQCR initialisation failed");
+		goto fail_eqcr;
+	}
+	if (qm_dqrr_init(p, c, qm_dqrr_dpush, qm_dqrr_pvb,
+			 qm_dqrr_cdc, DQRR_MAXFILL)) {
+		DPAA_BUS_ERR("Qman DQRR initialisation failed");
+		goto fail_dqrr;
+	}
+	if (qm_mr_init(p, qm_mr_pvb, qm_mr_cci)) {
+		DPAA_BUS_ERR("Qman MR initialisation failed");
+		goto fail_mr;
+	}
+	if (qm_mc_init(p)) {
+		DPAA_BUS_ERR("Qman MC initialisation failed");
+		goto fail_mc;
+	}
+
+	/* Reset portal before use */
+	DPAA_BUS_DEBUG("Reset portal = %p", p);
+	qm_dqrr_sdqcr_set(p, 0);
+	qm_eqcr_cce_update(p);
+	qm_eqcr_cce_update(p);
+	qm_mc_finish(p);
+	qm_mr_finish(p);
+	qm_dqrr_finish(p);
+	qm_eqcr_finish(p);
+
 	p->addr.ce = c->addr_virt[DPAA_PORTAL_CE];
 	p->addr.ci = c->addr_virt[DPAA_PORTAL_CI];
 	/*
@@ -2660,39 +2696,128 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 	return ret;
 }
 
-int qman_shutdown_fq(u32 fqid)
+#define GENMASK(h, l) \
+	(((~0U) >> (sizeof(unsigned int) * 8 - ((h) - (l) + 1))) << (l))
+
+/* 'fqid' is a 24-bit field in every h/w descriptor */
+#define QM_FQID_MASK    GENMASK(23, 0)
+#define qm_fqid_set(p, v) ((p)->fqid = cpu_to_be32((v) & QM_FQID_MASK))
+#define qm_fqid_get(p)    (be32_to_cpu((p)->fqid) & QM_FQID_MASK)
+
+static int
+_qm_mr_consume_and_match_verb(struct qm_portal *p, int v)
+{
+	const struct qm_mr_entry *msg;
+	int found = 0;
+
+	qm_mr_pvb_update(p);
+	msg = qm_mr_current(p);
+	while (msg) {
+		if ((msg->ern.verb & QM_MR_VERB_TYPE_MASK) == v)
+			found = 1;
+		qm_mr_next(p);
+		qm_mr_cci_consume_to_current(p);
+		qm_mr_pvb_update(p);
+		msg = qm_mr_current(p);
+	}
+	return found;
+}
+
+static int
+_qm_dqrr_consume_and_match(struct qm_portal *p, u32 fqid, int s,
+		bool wait)
+{
+	const struct qm_dqrr_entry *dqrr;
+	int found = 0;
+
+	do {
+		qm_dqrr_pvb_update(p);
+		dqrr = qm_dqrr_current(p);
+		if (!dqrr)
+			cpu_relax();
+	} while (wait && !dqrr);
+
+	while (dqrr) {
+		if (qm_fqid_get(dqrr) == fqid && (dqrr->stat & s))
+			found = 1;
+
+		qm_dqrr_cdc_consume_1ptr(p, dqrr, 0);
+		qm_dqrr_pvb_update(p);
+		qm_dqrr_next(p);
+		dqrr = qm_dqrr_current(p);
+	}
+	return found;
+}
+
+#define QM_MCR_TIMEOUT                  10000   /* us */
+
+static inline int
+qm_mc_result_timeout(struct qm_portal *portal,
+		     struct qm_mc_result **mcr)
+{
+	int timeout = QM_MCR_TIMEOUT;
+
+	do {
+		*mcr = qm_mc_result(portal);
+		if (*mcr)
+			break;
+		usleep(1);
+	} while (--timeout);
+
+	return timeout;
+}
+
+#define qm_mr_drain(p, V) \
+	_qm_mr_consume_and_match_verb(p, QM_MR_VERB_##V)
+
+#define qm_dqrr_drain(p, f, S) \
+	_qm_dqrr_consume_and_match(p, f, QM_DQRR_STAT_##S, false)
+
+#define qm_dqrr_drain_wait(p, f, S) \
+	_qm_dqrr_consume_and_match(p, f, QM_DQRR_STAT_##S, true)
+
+#define qm_dqrr_drain_nomatch(p) \
+	_qm_dqrr_consume_and_match(p, 0, 0, false)
+
+RTE_EXPORT_INTERNAL_SYMBOL(qman_shutdown_fq)
+int
+qman_shutdown_fq(u32 fqid)
 {
 	struct qman_portal *p;
-	struct qm_portal *low_p;
 	struct qm_mc_command *mcc;
 	struct qm_mc_result *mcr;
+	int orl_empty, drain = 0, ret = 0;
+	u32 res;
 	u8 state;
-	int orl_empty, fq_empty, drain = 0;
-	u32 result;
 	u32 channel, wq;
 	u16 dest_wq;
 
+	DPAA_BUS_DEBUG("In shutdown for queue = %x", fqid);
 	p = get_affine_portal();
-	low_p = &p->p;
-
 	/* Determine the state of the FQID */
-	mcc = qm_mc_start(low_p);
+	mcc = qm_mc_start(&p->p);
 	mcc->queryfq_np.fqid = cpu_to_be32(fqid);
-	qm_mc_commit(low_p, QM_MCC_VERB_QUERYFQ_NP);
-	while (!(mcr = qm_mc_result(low_p)))
-		cpu_relax();
-	DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) == QM_MCR_VERB_QUERYFQ_NP);
+	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYFQ_NP);
+	if (!qm_mc_result_timeout(&p->p, &mcr)) {
+		DPAA_BUS_ERR("QUERYFQ_NP timeout");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
 	state = mcr->queryfq_np.state & QM_MCR_NP_STATE_MASK;
-	if (state == QM_MCR_NP_STATE_OOS)
-		return 0; /* Already OOS, no need to do anymore checks */
+	if (state == QM_MCR_NP_STATE_OOS) {
+		DPAA_BUS_ERR("Already in OOS");
+		goto out; /* Already OOS, no need to do anymore checks */
+	}
 
 	/* Query which channel the FQ is using */
-	mcc = qm_mc_start(low_p);
+	mcc = qm_mc_start(&p->p);
 	mcc->queryfq.fqid = cpu_to_be32(fqid);
-	qm_mc_commit(low_p, QM_MCC_VERB_QUERYFQ);
-	while (!(mcr = qm_mc_result(low_p)))
-		cpu_relax();
-	DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) == QM_MCR_VERB_QUERYFQ);
+	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYFQ);
+	if (!qm_mc_result_timeout(&p->p, &mcr)) {
+		DPAA_BUS_ERR("QUERYFQ timeout");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
 
 	/* Need to store these since the MCR gets reused */
 	dest_wq = be16_to_cpu(mcr->queryfq.fqd.dest_wq);
@@ -2704,177 +2829,149 @@ int qman_shutdown_fq(u32 fqid)
 	case QM_MCR_NP_STATE_TRU_SCHED:
 	case QM_MCR_NP_STATE_ACTIVE:
 	case QM_MCR_NP_STATE_PARKED:
+		DPAA_BUS_DEBUG("In shutdown state is %d", state);
 		orl_empty = 0;
-		mcc = qm_mc_start(low_p);
+		mcc = qm_mc_start(&p->p);
 		mcc->alterfq.fqid = cpu_to_be32(fqid);
-		qm_mc_commit(low_p, QM_MCC_VERB_ALTER_RETIRE);
-		while (!(mcr = qm_mc_result(low_p)))
-			cpu_relax();
-		DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) ==
-			   QM_MCR_VERB_ALTER_RETIRE);
-		result = mcr->result; /* Make a copy as we reuse MCR below */
+		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_RETIRE);
+		if (!qm_mc_result_timeout(&p->p, &mcr)) {
+			DPAA_BUS_ERR("ALTER_RETIRE timeout");
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+		res = mcr->result; /* Make a copy as we reuse MCR below */
 
-		if (result == QM_MCR_RESULT_PENDING) {
-			/* Need to wait for the FQRN in the message ring, which
+		if (res == QM_MCR_RESULT_OK)
+			drain_mr_fqrni(&p->p);
+
+		if (res == QM_MCR_RESULT_PENDING) {
+			/*
+			 * Need to wait for the FQRN in the message ring, which
 			 * will only occur once the FQ has been drained.  In
 			 * order for the FQ to drain the portal needs to be set
 			 * to dequeue from the channel the FQ is scheduled on
 			 */
-			const struct qm_mr_entry *msg;
-			const struct qm_dqrr_entry *dqrr = NULL;
 			int found_fqrn = 0;
-			__maybe_unused u16 dequeue_wq = 0;
 
 			/* Flag that we need to drain FQ */
 			drain = 1;
 
+			__maybe_unused u16 dequeue_wq = 0;
 			if (channel >= qm_channel_pool1 &&
-			    channel < (u16)(qm_channel_pool1 + 15)) {
+				channel < (u16)(qm_channel_pool1 + 15)) {
 				/* Pool channel, enable the bit in the portal */
 				dequeue_wq = (channel -
-					      qm_channel_pool1 + 1) << 4 | wq;
+						qm_channel_pool1 + 1) << 4 | wq;
 			} else if (channel < qm_channel_pool1) {
 				/* Dedicated channel */
 				dequeue_wq = wq;
 			} else {
-				pr_info("Cannot recover FQ 0x%x,"
-					" it is scheduled on channel 0x%x",
+				DPAA_BUS_ERR("Can't recover FQ 0x%x, ch: 0x%x",
 					fqid, channel);
-				return -EBUSY;
+				ret = -EBUSY;
+				goto out;
 			}
 			/* Set the sdqcr to drain this channel */
 			if (channel < qm_channel_pool1)
-				qm_dqrr_sdqcr_set(low_p,
+				qm_dqrr_sdqcr_set(&p->p,
 						  QM_SDQCR_TYPE_ACTIVE |
-					  QM_SDQCR_CHANNELS_DEDICATED);
+						  QM_SDQCR_CHANNELS_DEDICATED);
 			else
-				qm_dqrr_sdqcr_set(low_p,
+				qm_dqrr_sdqcr_set(&p->p,
 						  QM_SDQCR_TYPE_ACTIVE |
 						  QM_SDQCR_CHANNELS_POOL_CONV
 						  (channel));
-			while (!found_fqrn) {
+			do {
 				/* Keep draining DQRR while checking the MR*/
-				qm_dqrr_pvb_update(low_p);
-				dqrr = qm_dqrr_current(low_p);
-				while (dqrr) {
-					qm_dqrr_cdc_consume_1ptr(
-						low_p, dqrr, 0);
-					qm_dqrr_pvb_update(low_p);
-					qm_dqrr_next(low_p);
-					dqrr = qm_dqrr_current(low_p);
-				}
+				qm_dqrr_drain_nomatch(&p->p);
 				/* Process message ring too */
-				qm_mr_pvb_update(low_p);
-				msg = qm_mr_current(low_p);
-				while (msg) {
-					if ((msg->ern.verb &
-					     QM_MR_VERB_TYPE_MASK)
-					    == QM_MR_VERB_FQRN)
-						found_fqrn = 1;
-					qm_mr_next(low_p);
-					qm_mr_cci_consume_to_current(low_p);
-					qm_mr_pvb_update(low_p);
-					msg = qm_mr_current(low_p);
-				}
+				found_fqrn = qm_mr_drain(&p->p,
+							FQRN);
 				cpu_relax();
-			}
+			} while (!found_fqrn);
+			/* Restore SDQCR */
+			qm_dqrr_sdqcr_set(&p->p,
+					p->sdqcr);
 		}
-		if (result != QM_MCR_RESULT_OK &&
-		    result !=  QM_MCR_RESULT_PENDING) {
-			/* error */
-			pr_err("qman_retire_fq failed on FQ 0x%x,"
-			       " result=0x%x\n", fqid, result);
-			return -1;
+		if (res != QM_MCR_RESULT_OK &&
+		    res != QM_MCR_RESULT_PENDING) {
+			DPAA_BUS_ERR("retire_fq failed: FQ 0x%x, res=0x%x",
+				      fqid, res);
+			ret = -EIO;
+			goto out;
 		}
 		if (!(mcr->alterfq.fqs & QM_MCR_FQS_ORLPRESENT)) {
-			/* ORL had no entries, no need to wait until the
-			 * ERNs come in.
+			/*
+			 * ORL had no entries, no need to wait until the
+			 * ERNs come in
 			 */
 			orl_empty = 1;
 		}
-		/* Retirement succeeded, check to see if FQ needs
-		 * to be drained.
+		/*
+		 * Retirement succeeded, check to see if FQ needs
+		 * to be drained
 		 */
 		if (drain || mcr->alterfq.fqs & QM_MCR_FQS_NOTEMPTY) {
 			/* FQ is Not Empty, drain using volatile DQ commands */
-			fq_empty = 0;
 			do {
-				const struct qm_dqrr_entry *dqrr = NULL;
 				u32 vdqcr = fqid | QM_VDQCR_NUMFRAMES_SET(3);
 
-				qm_dqrr_vdqcr_set(low_p, vdqcr);
-
-				/* Wait for a dequeue to occur */
-				while (dqrr == NULL) {
-					qm_dqrr_pvb_update(low_p);
-					dqrr = qm_dqrr_current(low_p);
-					if (!dqrr)
-						cpu_relax();
-				}
-				/* Process the dequeues, making sure to
-				 * empty the ring completely.
+				qm_dqrr_vdqcr_set(&p->p, vdqcr);
+				/*
+				 * Wait for a dequeue and process the dequeues,
+				 * making sure to empty the ring completely
 				 */
-				while (dqrr) {
-					if (dqrr->fqid == fqid &&
-					    dqrr->stat & QM_DQRR_STAT_FQ_EMPTY)
-						fq_empty = 1;
-					qm_dqrr_cdc_consume_1ptr(low_p,
-								 dqrr, 0);
-					qm_dqrr_pvb_update(low_p);
-					qm_dqrr_next(low_p);
-					dqrr = qm_dqrr_current(low_p);
-				}
-			} while (fq_empty == 0);
+			} while (!qm_dqrr_drain_wait(&p->p, fqid, FQ_EMPTY));
 		}
-		qm_dqrr_sdqcr_set(low_p, 0);
-
-		/* Wait for the ORL to have been completely drained */
-		while (orl_empty == 0) {
-			const struct qm_mr_entry *msg;
-
-			qm_mr_pvb_update(low_p);
-			msg = qm_mr_current(low_p);
-			while (msg) {
-				if ((msg->ern.verb & QM_MR_VERB_TYPE_MASK) ==
-				    QM_MR_VERB_FQRL)
-					orl_empty = 1;
-				qm_mr_next(low_p);
-				qm_mr_cci_consume_to_current(low_p);
-				qm_mr_pvb_update(low_p);
-				msg = qm_mr_current(low_p);
-			}
+		while (!orl_empty) {
+			/* Wait for the ORL to have been completely drained */
+			orl_empty = qm_mr_drain(&p->p, FQRL);
 			cpu_relax();
 		}
-		mcc = qm_mc_start(low_p);
+		mcc = qm_mc_start(&p->p);
 		mcc->alterfq.fqid = cpu_to_be32(fqid);
-		qm_mc_commit(low_p, QM_MCC_VERB_ALTER_OOS);
-		while (!(mcr = qm_mc_result(low_p)))
-			cpu_relax();
-		DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) ==
-			   QM_MCR_VERB_ALTER_OOS);
+		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_OOS);
+		if (!qm_mc_result_timeout(&p->p, &mcr)) {
+			DPAA_BUS_ERR("OOS Timeout");
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+
 		if (mcr->result != QM_MCR_RESULT_OK) {
-			pr_err(
-			"OOS after drain Failed on FQID 0x%x, result 0x%x\n",
-			       fqid, mcr->result);
-			return -1;
+			DPAA_BUS_ERR("OOS after drain fail: FQ 0x%x (0x%x)",
+				      fqid, mcr->result);
+			ret = -EIO;
+			goto out;
 		}
-		return 0;
+		break;
 
 	case QM_MCR_NP_STATE_RETIRED:
 		/* Send OOS Command */
-		mcc = qm_mc_start(low_p);
+		mcc = qm_mc_start(&p->p);
 		mcc->alterfq.fqid = cpu_to_be32(fqid);
-		qm_mc_commit(low_p, QM_MCC_VERB_ALTER_OOS);
-		while (!(mcr = qm_mc_result(low_p)))
-			cpu_relax();
-		DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) ==
-			   QM_MCR_VERB_ALTER_OOS);
-		if (mcr->result) {
-			pr_err("OOS Failed on FQID 0x%x\n", fqid);
-			return -1;
+		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_OOS);
+		if (!qm_mc_result_timeout(&p->p, &mcr)) {
+			DPAA_BUS_ERR("In RTEIRED to OOS timeout");
+			ret = -ETIMEDOUT;
+			goto out;
 		}
-		return 0;
 
+		if (mcr->result != QM_MCR_RESULT_OK) {
+			DPAA_BUS_ERR("OOS fail: FQ 0x%x (0x%x)",
+				      fqid, mcr->result);
+			ret = -EIO;
+			goto out;
+		}
+		break;
+
+	case QM_MCR_NP_STATE_OOS:
+		/*  Done */
+		break;
+
+	default:
+		ret = -EIO;
 	}
-	return -1;
+
+out:
+	return ret;
 }
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 71d5b16878..9bc4fc26b7 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1894,6 +1894,7 @@ static inline void qman_release_fqid(u32 fqid)
 
 void qman_seed_fqid_range(u32 fqid, unsigned int count);
 
+__rte_internal
 int qman_shutdown_fq(u32 fqid);
 
 /**
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 34b691fde7..30a0c97a8b 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1134,6 +1134,9 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	DPAA_PMD_INFO("Rx queue setup for queue index: %d fq_id (0x%x)",
 			queue_idx, rxq->fqid);
 
+	/* Shutdown FQ before configure */
+	qman_shutdown_fq(rxq->fqid);
+
 	if (!fif->num_profiles) {
 		if (dpaa_intf->bp_info && dpaa_intf->bp_info->bp &&
 			dpaa_intf->bp_info->mp != mp) {
-- 
2.25.1

