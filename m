Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5604FCCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:43:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59B2A427A3;
	Fri, 17 Oct 2025 06:43:23 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
 by mails.dpdk.org (Postfix) with ESMTP id 4E08340269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:43:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arZl2Xi7iPAHJOTNnl/h7KW0u11wUHuo8cle8686Fu98sJpKt/smw9VUTypBtHrqB87vuZuU2rKAAtBYiL/+vxN30DMrqOm74Oa2Blu4ehQ1UrGWj7pudqTsOq62U0EwGBDDNlw67qh77NpdKNKbMRvmmkaorbjkxBNYEX9YusN+osEZXgzniHlvoCHnLtR3dH8VktKJBmRqqg4aRbyiyP0HgeZ3njw+PtPICgO7SFN6X4zAW/Rn1Qv5ImmMbGuy0/qncf01wxUdAsyIaHCocHwiazi08MfXBG8Lp++pyW2BU0WOOIhtFZ41te509Mn2Ug1xNk2WXi9Muxb8B9hZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYvQnSQI3VKXeMJkPowqtV84IRNJ6RyrNEI4pN3ayPU=;
 b=Z8zFi55AfLTJpjBnQ2+r6/sbvgXGswX3Bugg8QOPuQB7e6OxE21AtXsFLRE43mLY7iBCiqjvm+Rg+416d7AugdjhQTx9LQyMzO50jzej6oF4CpLe/OFD3C8ih4HyrjES8dbEyylW0t7H1AIZb7BpF496nv0FQuKP95r33Rctj3n6e+hhsrGb7/CRyLReYUCwuVfy8moZMoMCN6ajDukyE2oEFdsBfHdN+S7SUiQ5g+Hh7i2uB7hrdM/UrVv9Qr4STWhFCzuaXcuUzWsMljxgNNhTM7jJPyeMLurEIoIUYOOXTcQ+3UKdE0swfD4io8idfRic6Eggk/0IGU7yr2NmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYvQnSQI3VKXeMJkPowqtV84IRNJ6RyrNEI4pN3ayPU=;
 b=WGeVdsBs4DdenpO4cJjv7NOwlN3UjVb1t0wd2g+HEB2GdqEmJV6h4CSVG9Y5JgCC5S2PlIyEz03J/ds3q8IvrowF906jXxgJiXh/pgD/05hvQoLbvxYEx+mg7M3O+CdskXPECv1Md7Kf17c44kobs7St32p1ldi2sivrUBpsbinKVEBhUDcTPepSJLHKQwiaNTTpsav4JMVELQXYsXz2wbn6dcmKNRjxi8gZK97psesiJaNd+d710kmmdIabz/ZL5yvDV+cJkJWDisf1NPhU60V74NmulhI+6Hts28xIlNs0BW3R6AhRxvBKXJclnPlxUjQMzk1w7zNRLxI2T9fm5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by GVXPR04MB11655.eurprd04.prod.outlook.com (2603:10a6:150:2c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 04:43:18 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:43:18 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4 3/6] net/dpaa: Support IEEE1588 by timesync API
Date: Fri, 17 Oct 2025 10:12:53 +0530
Message-Id: <20251017044256.3264737-4-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 02c3deba-28ab-4183-f3fb-08de0d37b104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BVN6I/dIV+ytiO62N9Z4rSHRbGomerYbjfQMWf8s+xZurigoRsbYlzAPydMT?=
 =?us-ascii?Q?6Yaps8gC9G1h+V/4Vhx3fLyMnt4oF2kTGHdiKSCDvgn8EgyoRwhEghbe7YyY?=
 =?us-ascii?Q?9nAyS0FgFH4uZOZKI5IzdPmjNCYdNUSTzYuM0K1EYxtFwW7sJv1XdbQ4ZukI?=
 =?us-ascii?Q?26trL+3lIsiBeVOnVB5/FMPRtIbYbcizwlK0M0saENdGBYneNXJ2WaMi1izt?=
 =?us-ascii?Q?7EbabKdQ09vLJqsjTlnHPPDBQqNUbYS2OR7Ah8qM9TxyQrQFsvY2F1h7Y1CU?=
 =?us-ascii?Q?srvXwyqTEvTWW8FH9nF1W4MgbAwtc7s8XTkctzmPGTtRwRXzV/r9O0kmJKNF?=
 =?us-ascii?Q?RS1xzP15pz/K0I2fI5wo/nKq/3ctzsYWaZ1FVhwyBY8xZhdilsX55aHpjlvZ?=
 =?us-ascii?Q?hovTIbkpVQQ8m4Q58HLNAqlwXz1S9DkqOZ30Z57VqH1Z6vhLhyB71O4AYNQ3?=
 =?us-ascii?Q?aqtW0r2pmtzKWnUVIaw8ZY7wGGoFWQyITJkgkqywxH1jeNvp4nA+Rw6Vyque?=
 =?us-ascii?Q?pFaY3EsQPBhfRIwbArQ3gwBMlM5GafAAFQc872DPNBcMVslPG5IM669HFZf3?=
 =?us-ascii?Q?F8hd3l6nkZdHa6sLJCmwJ/yz6b6FQnj8l47dOUBIEfK+3hfWfI7O3sfm1Zsy?=
 =?us-ascii?Q?f2OlO4PrQ0Y0rffuOMaeIJg9P/BY+wILZnpquZpxiOGzZvbhfC7AKt8waRKq?=
 =?us-ascii?Q?iW47qFwEDPx7x59OIDrAxNhC/rhcpjv08Q27loQnzCa2iIxlk6J0NvVpEk/B?=
 =?us-ascii?Q?mB0SmHNu4BWWuOAzum6zR6GQaRLjqV7EIN5VZY/zPRaksjUvcIkb9w5U4g7v?=
 =?us-ascii?Q?FJfQqwNpCDmiTJyk7GG3WTQSRVdhtJND1usEO7x5RdY7bKSpNgQhl/msM4V6?=
 =?us-ascii?Q?Ue7BXOuOT4mEroJKgbU81tDs9y3v39nu10nL3PSuCOUSF0OuwCoJIQ2eSnaL?=
 =?us-ascii?Q?sKhVlCTyIGQgd08gWi7GlmLMX2k89LfRR5yWYPDfaZCHfvwC8L6rGDzFFDIf?=
 =?us-ascii?Q?zXDtlj75vOD3k8SIuwei7g3qLsQgsXWYDrEFRu8KedFLr7BNe0j9pHSz8BJz?=
 =?us-ascii?Q?wFqqAykyZhl96YpJgVuaCUFTqf2yFSpZuLWf56g0R9LIOpQsJjRCtqh4M4AW?=
 =?us-ascii?Q?BN3Amp0AiPT/Y5E4ZxWAPxw7lQ67RfDv1CTJz6p4EVvGLwjUwnmuc+iaYxFS?=
 =?us-ascii?Q?nB2+3AKwyOLFRp8CnQ8BwfkZgFjDDP7TRWTwvCFDpL8Eu4/nQraMz/FyrC4e?=
 =?us-ascii?Q?CfemVrwFc7PeNPqKQlBU3wFk9eBc096s/VqAcfA/iYI21E8qAqK/JJDM4ims?=
 =?us-ascii?Q?sUI6xO3GEPDUxiDH4hQlr/aOpoSPvsaD9nV1GKJZPawUjtgpuv0GP/ttixNn?=
 =?us-ascii?Q?1LMEkr8yOWKE7p4N/YvZYnSb7r/yJE0Z+/n6qnSkw1xVZoucwf+QSkJjjwz0?=
 =?us-ascii?Q?lQoFo5REIWMQvmsJDmBT5ET5JFuFV4NBBku1QEfAgfzgj8rTNJxYUcc6FthE?=
 =?us-ascii?Q?hWkimSwiCnVjJnoEf+AcU/3QqBY12eKONQat?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?InDcmHJxfv9iJV/2f8jEPQTFvdoiiKuwDbUu6yWCgs31Jwfs9rQkG4FoHu8W?=
 =?us-ascii?Q?dt/dsEXXsQPOgFPFWvMZ9AL2RTnOCRqmDTlmU7B1vE7uP1aw/3IEn/AHyEAX?=
 =?us-ascii?Q?QCg4HQPpjbAdbSCumSenBXW8T47HUfAvm5Bjwh6hzqqKIiXfogoVCfb/DO5F?=
 =?us-ascii?Q?jqDjOzwE5/P4CVevuqkSlk0N/h3dKoA9bUmQV49DqjhIntPoMkHE07J2lWvA?=
 =?us-ascii?Q?eUWM4Q4xtf71A++wtyhFeqHeGHO33FXX94VQn9GKyswTfgBpMfx57jDFUzkf?=
 =?us-ascii?Q?/+JD9G6bAi08GMa/PFMdzPsrouJA37VNSO2jU0IGr3FCPEp2kzGrg3lLgX5O?=
 =?us-ascii?Q?D02dwu9WE1AUF/GCSJums8fjcDZM8gz6OnjBYFhF6AIdV9CGd0T39WluNe53?=
 =?us-ascii?Q?uhhG69UBZR1f9tHn78TQss1oQjG682xACHIwer2GUORKzTjYhnsd8te60bvq?=
 =?us-ascii?Q?4C5UJpDVoanrJXupz6VwydR7ApdxXVrD1JPh9VJRJ91+xhuJQxE3awGI0vXo?=
 =?us-ascii?Q?NFT9vTXz+escMOFdIq+7UFGzMrANNFlGPhopDXXD5ayB+9jGVUrKNTsaR5N9?=
 =?us-ascii?Q?4pviDzh6C1hwD4ohD+nwBqnO4a49UPprBy9VmW/oiAfjKpZF0NDctEyhKb1J?=
 =?us-ascii?Q?tqkH/jxkX0Dw5+mRccJotBHrZJdCqNBZiGPF4Cfb2n9xNQoRGiwGUAgA7il3?=
 =?us-ascii?Q?JOn4QrblgzedBveP3GVADuHsKJ5bGO1Ypx0lol5+UeVtHbE1EgYwNKGKTx+G?=
 =?us-ascii?Q?otwHWghFC2SrWbrknRhTx3zLmyphj6ZMZMVoDXvyCchfxZoH1E/eO1O5fxFs?=
 =?us-ascii?Q?woo5Gd4xZFtMJ1sjlRSy+afrvuZvDnlnju7CAwxM3CCLSywL7vTz2xm19IUZ?=
 =?us-ascii?Q?vNnTxJ2CFgD5VBpjygj6A3OvjJiK0xCnuCwuPVR7zpJD31J2dpRy/Mc75maO?=
 =?us-ascii?Q?z4MgCarSZQxu5kgwc+e9TVm5qECmkxfurir+FtrVxHv3wKNvpyVKsdEALsG4?=
 =?us-ascii?Q?GnzYI6i1NFZgQ4PWZdDv6+gwHpW7VM+m6Vi1lzHvPl3Z1rjXyNodSaLU8aEG?=
 =?us-ascii?Q?MMBie3zH5TXokzGyLN3WYcCusIHxoZX0ZPsytkw9PEeB7pYFlnHGqLFaNCH/?=
 =?us-ascii?Q?eOmOmDxUfbjhB/viUO7g03ymz5yo6c6RQGeXjhTHu/fRtZQWFL71z1Et7B7C?=
 =?us-ascii?Q?myFQI3xmthnz5rsecJsM+LX+I91rV1EGVV6ZeZTJsk57zBV41srYw2xcI+Op?=
 =?us-ascii?Q?5ILSPdhQx8lHg+syrUrqt7NcXkoaDjzwsbzGbdcTwnTUf1RnSLRNEWWQ4Tt+?=
 =?us-ascii?Q?+Mh84nyDzJDejpnHXNFBw7i6wr23X8ZaWmsn8rl6pmOi4yTZ9kBksXIsZay+?=
 =?us-ascii?Q?GPSwnw9O9iREo88/J9vXNH6fyHRLJpQhLLkHej+Ud4hdOtngq258+bvolVdR?=
 =?us-ascii?Q?rz6UbELYl7DwQdgAG7eCaoq0nocqv+eKN0lGq9+FxrbZDMFZbCwkV+yXGy/L?=
 =?us-ascii?Q?Zrc3rfLVmyH0YAim8qFm5MQDrwoRrDdOA8U/l+V8Z/idn6ZUEY7QlCsRJ1Is?=
 =?us-ascii?Q?+qx3bw9xs2nC22fuInE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c3deba-28ab-4183-f3fb-08de0d37b104
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:43:18.0522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYxo1PtpUd4cNROChz4YqX+06pDOPzkXP4y3+MUqD/r4Ux9PDDvYPlGS62pztATl
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

From: Jun Yang <jun.yang@nxp.com>

Enable IEEE1588 by timesync API instead of devargs.
DPAA1 HW parser has no capability to identify ptp packets
from ingress traffic, remove ptp identification code from
driver RX callback which impacts performance significantly.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 doc/guides/nics/dpaa.rst            |  3 -
 drivers/bus/dpaa/base/qbman/qman.c  | 18 +++---
 drivers/bus/dpaa/include/fsl_qman.h |  5 +-
 drivers/common/dpaax/dpaax_ptp.h    | 95 +++++++++++++++++++++++++++++
 drivers/net/dpaa/dpaa_ethdev.c      | 15 ++---
 drivers/net/dpaa/dpaa_ethdev.h      | 13 ++--
 drivers/net/dpaa/dpaa_ptp.c         | 50 ++++++++++++---
 drivers/net/dpaa/dpaa_rxtx.c        | 93 +++++++++++++---------------
 drivers/net/dpaa/dpaa_rxtx.h        |  2 +-
 9 files changed, 204 insertions(+), 90 deletions(-)
 create mode 100644 drivers/common/dpaax/dpaax_ptp.h

diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index 8cd57b21f3..8ffe31ce32 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -275,9 +275,6 @@ for details.
       Done
       testpmd>
 
-* Use dev arg option ``drv_ieee1588=1`` to enable IEEE 1588 support
-  at driver level, e.g. ``dpaa:fm1-mac3,drv_ieee1588=1``.
-
 * Use dev arg option ``recv_err_pkts=1`` to receive all packets including error packets
   and thus disabling hardware based packet handling at driver level,
   e.g. ``dpaa:fm1-mac3,recv_err_pkts=1``.
diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index d6b2a58eaa..76a1d93032 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -1232,14 +1232,14 @@ u16 qman_affine_channel(int cpu)
 	return affine_channels[cpu];
 }
 
-unsigned int qman_portal_poll_rx(unsigned int poll_limit,
-				 void **bufs,
-				 struct qman_portal *p)
+uint32_t
+qman_portal_poll_rx(uint32_t poll_limit, void **bufs,
+	struct qman_portal *p, struct qman_fq_cb *cb)
 {
 	struct qm_portal *portal = &p->p;
 	register struct qm_dqrr *dqrr = &portal->dqrr;
 	struct qm_dqrr_entry *dq[QM_DQRR_SIZE], *shadow[QM_DQRR_SIZE];
-	struct qman_fq *fq;
+	struct qman_fq *fq[QM_DQRR_SIZE];
 	unsigned int limit = 0, rx_number = 0;
 	uint32_t consume = 0;
 
@@ -1273,12 +1273,12 @@ unsigned int qman_portal_poll_rx(unsigned int poll_limit,
 
 		/* SDQCR: context_b points to the FQ */
 #ifdef CONFIG_FSL_QMAN_FQ_LOOKUP
-		fq = qman_fq_lookup_table[dq[rx_number]->contextB];
+		fq[rx_number] = qman_fq_lookup_table[dq[rx_number]->contextB];
 #else
-		fq = (void *)dq[rx_number]->contextB;
+		fq[rx_number] = (void *)dq[rx_number]->contextB;
 #endif
-		if (fq->cb.dqrr_prepare)
-			fq->cb.dqrr_prepare(shadow[rx_number],
+		if (fq[rx_number]->cb.dqrr_prepare)
+			fq[rx_number]->cb.dqrr_prepare(shadow[rx_number],
 					    &bufs[rx_number]);
 
 		consume |= (1 << (31 - DQRR_PTR2IDX(shadow[rx_number])));
@@ -1287,7 +1287,7 @@ unsigned int qman_portal_poll_rx(unsigned int poll_limit,
 	} while (++limit < poll_limit);
 
 	if (rx_number)
-		fq->cb.dqrr_dpdk_pull_cb(&fq, shadow, bufs, rx_number);
+		cb->dqrr_dpdk_pull_cb(fq, shadow, bufs, rx_number);
 
 	/* Consume all the DQRR enries together */
 	qm_out(DQRR_DCAP, (1 << 8) | consume);
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 9bc4fc26b7..0494ad709d 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1393,8 +1393,9 @@ int qman_fq_portal_irqsource_remove(struct qman_portal *p, u32 bits);
 u16 qman_affine_channel(int cpu);
 
 __rte_internal
-unsigned int qman_portal_poll_rx(unsigned int poll_limit,
-				 void **bufs, struct qman_portal *q);
+uint32_t
+qman_portal_poll_rx(uint32_t poll_limit, void **bufs,
+	struct qman_portal *p, struct qman_fq_cb *cb);
 
 /**
  * qman_set_vdq - Issue a volatile dequeue command
diff --git a/drivers/common/dpaax/dpaax_ptp.h b/drivers/common/dpaax/dpaax_ptp.h
new file mode 100644
index 0000000000..b73c16c986
--- /dev/null
+++ b/drivers/common/dpaax/dpaax_ptp.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 NXP
+ */
+
+#ifndef _DPAAX_PTP_H_
+#define _DPAAX_PTP_H_
+#include <stdlib.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+
+#define UDP_PTP_EVENT_DST_PORT 319
+#define UDP_PTP_GENERAL_DST_PORT 320
+
+struct __rte_packed_begin rte_dpaax_ptp_header {
+	uint8_t tsmt;  /* transportSpecific | messageType */
+	uint8_t ver;   /* reserved          | versionPTP  */
+	rte_be16_t msg_len;
+	uint8_t domain_number;
+	uint8_t rsv;
+	uint8_t flags[2];
+	rte_be64_t correction;
+	uint8_t unused[];
+} __rte_packed_end;
+
+static inline struct rte_dpaax_ptp_header *
+dpaax_timesync_ptp_parse_header(struct rte_mbuf *buf,
+	uint16_t *ts_offset, int *is_udp)
+{
+	struct rte_ether_hdr *eth = rte_pktmbuf_mtod(buf, void *);
+	void *next_hdr;
+	rte_be16_t ether_type;
+	struct rte_vlan_hdr *vlan;
+	struct rte_ipv4_hdr *ipv4;
+	struct rte_ipv6_hdr *ipv6;
+	struct rte_udp_hdr *udp;
+	struct rte_dpaax_ptp_header *ptp = NULL;
+	uint16_t offset = offsetof(struct rte_dpaax_ptp_header, correction);
+
+	if (is_udp)
+		*is_udp = false;
+
+	offset += sizeof(struct rte_ether_hdr);
+	if (eth->ether_type == htons(RTE_ETHER_TYPE_1588)) {
+		ptp = (void *)(eth + 1);
+		goto quit;
+	}
+
+	if (eth->ether_type == htons(RTE_ETHER_TYPE_VLAN)) {
+		vlan = (void *)(eth + 1);
+		ether_type = vlan->eth_proto;
+		next_hdr = (void *)(vlan + 1);
+		offset += sizeof(struct rte_vlan_hdr);
+		if (ether_type == htons(RTE_ETHER_TYPE_1588)) {
+			ptp = next_hdr;
+			goto quit;
+		}
+	} else {
+		ether_type = eth->ether_type;
+		next_hdr = (void *)(eth + 1);
+	}
+
+	if (ether_type == htons(RTE_ETHER_TYPE_IPV4)) {
+		ipv4 = next_hdr;
+		offset += sizeof(struct rte_ipv4_hdr);
+		if (ipv4->next_proto_id != IPPROTO_UDP)
+			return NULL;
+		udp = (void *)(ipv4 + 1);
+		goto parse_udp;
+	} else if (ether_type == htons(RTE_ETHER_TYPE_IPV6)) {
+		ipv6 = next_hdr;
+		offset += sizeof(struct rte_ipv6_hdr);
+		if (ipv6->proto != IPPROTO_UDP)
+			return NULL;
+		udp = (void *)(ipv6 + 1);
+		goto parse_udp;
+	} else {
+		return NULL;
+	}
+parse_udp:
+	offset += sizeof(struct rte_udp_hdr);
+	if (udp->dst_port != UDP_PTP_EVENT_DST_PORT &&
+		udp->dst_port != UDP_PTP_GENERAL_DST_PORT)
+		return NULL;
+	ptp = (void *)(udp + 1);
+	if (is_udp)
+		*is_udp = true;
+quit:
+	if (ts_offset)
+		*ts_offset = offset;
+
+	return ptp;
+}
+
+#endif /* _DPAAX_PTP_H_ */
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 30a0c97a8b..43aab98339 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -52,7 +52,6 @@
 #include <process.h>
 #include <fmlib/fm_ext.h>
 
-#define DRIVER_IEEE1588         "drv_ieee1588"
 #define CHECK_INTERVAL          100  /* 100ms */
 #define MAX_REPEAT_TIME         90   /* 9s (90 * 100ms) in total */
 #define DRIVER_RECV_ERR_PKTS      "recv_err_pkts"
@@ -88,7 +87,6 @@ static uint64_t dev_tx_offloads_nodis =
 static int is_global_init;
 static int fmc_q = 1;	/* Indicates the use of static fmc for distribution */
 static int default_q;	/* use default queue - FMC is not executed*/
-int dpaa_ieee_1588;	/* use to indicate if IEEE 1588 is enabled for the driver */
 bool dpaa_enable_recv_err_pkts; /* Enable main queue to receive error packets */
 
 /* At present we only allow up to 4 push mode queues as default - as each of
@@ -1998,6 +1996,7 @@ static int dpaa_tx_queue_init(struct qman_fq *fq,
 		}
 	};
 	int ret;
+	struct dpaa_if *dpaa_intf = fq->dpaa_intf;
 
 	ret = qman_create_fq(0, QMAN_FQ_FLAG_DYNAMIC_FQID |
 			     QMAN_FQ_FLAG_TO_DCPORTAL, fq);
@@ -2011,7 +2010,7 @@ static int dpaa_tx_queue_init(struct qman_fq *fq,
 	opts.fqd.dest.wq = DPAA_IF_TX_PRIORITY;
 	opts.fqd.fq_ctrl = QM_FQCTRL_PREFERINCACHE;
 	opts.fqd.context_b = 0;
-	if (dpaa_ieee_1588) {
+	if (dpaa_intf->ts_enable) {
 		opts.fqd.context_a.lo = 0;
 		opts.fqd.context_a.hi =
 			fman_intf->fman->dealloc_bufs_mask_hi;
@@ -2063,7 +2062,7 @@ static int dpaa_tx_queue_init(struct qman_fq *fq,
 	return ret;
 }
 
-static int
+int
 dpaa_tx_conf_queue_init(struct qman_fq *fq)
 {
 	struct qm_mcc_initfq opts = {0};
@@ -2261,9 +2260,6 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	dpaa_intf->ifid = dev_id;
 	dpaa_intf->cfg = cfg;
 
-	if (dpaa_get_devargs(dev->devargs, DRIVER_IEEE1588))
-		dpaa_ieee_1588 = 1;
-
 	if (dpaa_get_devargs(dev->devargs, DRIVER_RECV_ERR_PKTS))
 		dpaa_enable_recv_err_pkts = 1;
 
@@ -2432,14 +2428,14 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 		if (dpaa_intf->cgr_tx)
 			dpaa_intf->cgr_tx[loop].cgrid = cgrid_tx[loop];
 
+		dpaa_intf->tx_queues[loop].dpaa_intf = dpaa_intf;
 		ret = dpaa_tx_queue_init(&dpaa_intf->tx_queues[loop],
 			fman_intf,
 			dpaa_intf->cgr_tx ? &dpaa_intf->cgr_tx[loop] : NULL);
 		if (ret)
 			goto free_tx;
-		dpaa_intf->tx_queues[loop].dpaa_intf = dpaa_intf;
 
-		if (dpaa_ieee_1588) {
+		if (dpaa_intf->ts_enable) {
 			ret = dpaa_tx_conf_queue_init(&dpaa_intf->tx_conf_queues[loop]);
 			if (ret)
 				goto free_tx;
@@ -2731,6 +2727,5 @@ static struct rte_dpaa_driver rte_dpaa_pmd = {
 
 RTE_PMD_REGISTER_DPAA(net_dpaa, rte_dpaa_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(net_dpaa,
-		DRIVER_IEEE1588 "=<int>"
 		DRIVER_RECV_ERR_PKTS "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_pmd, NOTICE);
diff --git a/drivers/net/dpaa/dpaa_ethdev.h b/drivers/net/dpaa/dpaa_ethdev.h
index be9398004f..f400030a5c 100644
--- a/drivers/net/dpaa/dpaa_ethdev.h
+++ b/drivers/net/dpaa/dpaa_ethdev.h
@@ -119,7 +119,6 @@ enum {
 #define FMC_FILE "/tmp/fmc.bin"
 
 extern struct rte_mempool *dpaa_tx_sg_pool;
-extern int dpaa_ieee_1588;
 
 /* PMD related logs */
 extern int dpaa_logtype_pmd;
@@ -154,10 +153,12 @@ struct dpaa_if {
 	void *netenv_handle;
 	void *scheme_handle[2];
 	uint32_t scheme_count;
+	int ts_enable;
 	/*stores timestamp of last received packet on dev*/
 	uint64_t rx_timestamp;
 	/*stores timestamp of last received tx confirmation packet on dev*/
 	uint64_t tx_timestamp;
+	uint64_t tx_old_timestamp;
 	/* stores pointer to next tx_conf queue that should be processed,
 	 * it corresponds to last packet transmitted
 	 */
@@ -244,6 +245,9 @@ struct dpaa_if_rx_bmi_stats {
 	uint32_t fmbm_rbdc;		/**< Rx Buffers Deallocate Counter*/
 };
 
+int
+dpaa_tx_conf_queue_init(struct qman_fq *fq);
+
 int
 dpaa_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 		struct timespec *timestamp);
@@ -256,18 +260,17 @@ dpaa_timesync_disable(struct rte_eth_dev *dev);
 
 int
 dpaa_timesync_read_time(struct rte_eth_dev *dev,
-		struct timespec *timestamp);
+	struct timespec *timestamp);
 
 int
 dpaa_timesync_write_time(struct rte_eth_dev *dev,
-		const struct timespec *timestamp);
+	const struct timespec *timestamp);
 int
 dpaa_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta);
 
 int
 dpaa_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
-		struct timespec *timestamp,
-		uint32_t flags __rte_unused);
+	struct timespec *timestamp, uint32_t flags __rte_unused);
 
 uint8_t
 fm_default_vsp_id(struct fman_if *fif);
diff --git a/drivers/net/dpaa/dpaa_ptp.c b/drivers/net/dpaa/dpaa_ptp.c
index 8482666745..e9b332c571 100644
--- a/drivers/net/dpaa/dpaa_ptp.c
+++ b/drivers/net/dpaa/dpaa_ptp.c
@@ -17,20 +17,40 @@
 #include <dpaa_rxtx.h>
 
 int
-dpaa_timesync_enable(struct rte_eth_dev *dev __rte_unused)
+dpaa_timesync_enable(struct rte_eth_dev *dev)
 {
+	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+	int loop, ret = 0;
+
+	for (loop = 0; loop < MAX_DPAA_CORES; loop++) {
+		if (!dpaa_intf->tx_queues[loop].tx_conf_queue) {
+			ret = dpaa_tx_conf_queue_init(&dpaa_intf->tx_conf_queues[loop]);
+			if (ret)
+				break;
+			dpaa_intf->tx_conf_queues[loop].dpaa_intf = dpaa_intf;
+			dpaa_intf->tx_queues[loop].tx_conf_queue = &dpaa_intf->tx_conf_queues[loop];
+		}
+	}
+
+	if (ret)
+		return ret;
+
+	dpaa_intf->ts_enable = true;
 	return 0;
 }
 
 int
-dpaa_timesync_disable(struct rte_eth_dev *dev __rte_unused)
+dpaa_timesync_disable(struct rte_eth_dev *dev)
 {
+	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+
+	dpaa_intf->ts_enable = false;
 	return 0;
 }
 
 int
 dpaa_timesync_read_time(struct rte_eth_dev *dev,
-					struct timespec *timestamp)
+	struct timespec *timestamp)
 {
 	uint32_t *tmr_cnt_h, *tmr_cnt_l;
 	struct fman_if *fif;
@@ -50,7 +70,7 @@ dpaa_timesync_read_time(struct rte_eth_dev *dev,
 
 int
 dpaa_timesync_write_time(struct rte_eth_dev *dev,
-					const struct timespec *ts)
+	const struct timespec *ts)
 {
 	uint32_t *tmr_cnt_h, *tmr_cnt_l;
 	struct fman_if *fif;
@@ -88,15 +108,21 @@ dpaa_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta)
 
 int
 dpaa_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
-						struct timespec *timestamp)
+	struct timespec *timestamp)
 {
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+	int read_count = 10000;
 
-	if (dpaa_intf->next_tx_conf_queue) {
-		while (!dpaa_intf->tx_timestamp)
+	if (dpaa_intf->ts_enable && dpaa_intf->next_tx_conf_queue) {
+		while (dpaa_intf->tx_timestamp == dpaa_intf->tx_old_timestamp) {
 			dpaa_eth_tx_conf(dpaa_intf->next_tx_conf_queue);
+			if (read_count <= 0)
+				return -EAGAIN;
+			read_count--;
+		}
+		dpaa_intf->tx_old_timestamp = dpaa_intf->tx_timestamp;
 	} else {
-		return -1;
+		return -ENOTSUP;
 	}
 	*timestamp = rte_ns_to_timespec(dpaa_intf->tx_timestamp);
 
@@ -105,10 +131,14 @@ dpaa_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 
 int
 dpaa_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
-						struct timespec *timestamp,
-						uint32_t flags __rte_unused)
+	struct timespec *timestamp, uint32_t flags __rte_unused)
 {
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+
+	if (!dpaa_intf->ts_enable)
+		return -ENOTSUP;
+
 	*timestamp = rte_ns_to_timespec(dpaa_intf->rx_timestamp);
+
 	return 0;
 }
diff --git a/drivers/net/dpaa/dpaa_rxtx.c b/drivers/net/dpaa/dpaa_rxtx.c
index 4dca63ea7e..c5e393159a 100644
--- a/drivers/net/dpaa/dpaa_rxtx.c
+++ b/drivers/net/dpaa/dpaa_rxtx.c
@@ -45,6 +45,7 @@
 #include <fsl_qman.h>
 #include <fsl_bman.h>
 #include <dpaa_of.h>
+#include <dpaax_ptp.h>
 #include <netcfg.h>
 
 #ifdef RTE_LIBRTE_DPAA_DEBUG_DRIVER
@@ -234,12 +235,11 @@ dpaa_slow_parsing(struct rte_mbuf *m,
 		m->packet_type |= RTE_PTYPE_L4_SCTP;
 }
 
-static inline void dpaa_eth_packet_info(struct rte_mbuf *m, void *fd_virt_addr)
+static inline void
+dpaa_eth_packet_info(struct dpaa_if *dpaa_intf, struct rte_mbuf *m,
+	struct annotations_t *annot)
 {
-	struct annotations_t *annot = GET_ANNOTATIONS(fd_virt_addr);
 	uint64_t prs = *((uintptr_t *)(&annot->parse)) & DPAA_PARSE_MASK;
-	struct rte_ether_hdr *eth_hdr =
-		rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
 
 	DPAA_DP_LOG(DEBUG, " Parsing mbuf: %p with annotations: %p", m, annot);
 
@@ -360,9 +360,11 @@ static inline void dpaa_eth_packet_info(struct rte_mbuf *m, void *fd_virt_addr)
 		m->ol_flags |= RTE_MBUF_F_RX_VLAN;
 	/* Packet received without stripping the vlan */
 
-	if (eth_hdr->ether_type == htons(RTE_ETHER_TYPE_1588)) {
-		m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
-		m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
+	if (unlikely(dpaa_intf->ts_enable)) {
+		if (dpaax_timesync_ptp_parse_header(m, NULL, NULL)) {
+			m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+			m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
+		}
 	}
 }
 
@@ -468,7 +470,7 @@ dpaa_unsegmented_checksum(struct rte_mbuf *mbuf, struct qm_fd *fd_arr)
 }
 
 static struct rte_mbuf *
-dpaa_eth_sg_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
+dpaa_eth_sg_to_mbuf(struct dpaa_if *dpaa_intf, const struct qm_fd *fd)
 {
 	struct dpaa_bp_info *bp_info = DPAA_BPID_TO_POOL_INFO(fd->bpid);
 	struct rte_mbuf *first_seg, *prev_seg, *cur_seg, *temp;
@@ -499,7 +501,7 @@ dpaa_eth_sg_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 			(void **)&first_seg, 1, 1);
 #endif
 
-	first_seg->port = ifid;
+	first_seg->port = dpaa_intf->ifid;
 	first_seg->nb_segs = 1;
 	first_seg->ol_flags = 0;
 	prev_seg = first_seg;
@@ -529,7 +531,7 @@ dpaa_eth_sg_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 	DPAA_DP_LOG(DEBUG, "Received an SG frame len =%d, num_sg =%d",
 			first_seg->pkt_len, first_seg->nb_segs);
 
-	dpaa_eth_packet_info(first_seg, vaddr);
+	dpaa_eth_packet_info(dpaa_intf, first_seg, GET_ANNOTATIONS(vaddr));
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
 	rte_mempool_check_cookies(rte_mempool_from_obj((void *)temp),
 			(void **)&temp, 1, 1);
@@ -540,7 +542,7 @@ dpaa_eth_sg_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 }
 
 static inline struct rte_mbuf *
-dpaa_eth_fd_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
+dpaa_eth_fd_to_mbuf(struct dpaa_if *dpaa_intf, const struct qm_fd *fd)
 {
 	struct rte_mbuf *mbuf;
 	struct dpaa_bp_info *bp_info = DPAA_BPID_TO_POOL_INFO(fd->bpid);
@@ -551,7 +553,7 @@ dpaa_eth_fd_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 	uint32_t length;
 
 	if (unlikely(format == qm_fd_sg))
-		return dpaa_eth_sg_to_mbuf(fd, ifid);
+		return dpaa_eth_sg_to_mbuf(dpaa_intf, fd);
 
 	offset = (fd->opaque & DPAA_FD_OFFSET_MASK) >> DPAA_FD_OFFSET_SHIFT;
 	length = fd->opaque & DPAA_FD_LENGTH_MASK;
@@ -569,7 +571,7 @@ dpaa_eth_fd_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 	mbuf->data_len = length;
 	mbuf->pkt_len = length;
 
-	mbuf->port = ifid;
+	mbuf->port = dpaa_intf->ifid;
 	mbuf->nb_segs = 1;
 	mbuf->ol_flags = 0;
 	mbuf->next = NULL;
@@ -578,7 +580,7 @@ dpaa_eth_fd_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 	rte_mempool_check_cookies(rte_mempool_from_obj((void *)mbuf),
 			(void **)&mbuf, 1, 1);
 #endif
-	dpaa_eth_packet_info(mbuf, mbuf->buf_addr);
+	dpaa_eth_packet_info(dpaa_intf, mbuf, GET_ANNOTATIONS(mbuf->buf_addr));
 
 	return mbuf;
 }
@@ -670,11 +672,11 @@ dpaa_rx_cb_no_prefetch(struct qman_fq **fq, struct qm_dqrr_entry **dqrr,
 		}
 
 		fd = &dqrr[i]->fd;
-		dpaa_intf = fq[0]->dpaa_intf;
+		dpaa_intf = fq[i]->dpaa_intf;
 		format = (fd->opaque & DPAA_FD_FORMAT_MASK) >>
 				DPAA_FD_FORMAT_SHIFT;
 		if (unlikely(format == qm_fd_sg)) {
-			bufs[i] = dpaa_eth_sg_to_mbuf(fd, dpaa_intf->ifid);
+			bufs[i] = dpaa_eth_sg_to_mbuf(dpaa_intf, fd);
 			continue;
 		}
 
@@ -696,13 +698,11 @@ dpaa_rx_cb_no_prefetch(struct qman_fq **fq, struct qm_dqrr_entry **dqrr,
 		rte_mempool_check_cookies(rte_mempool_from_obj((void *)mbuf),
 			(void **)&mbuf, 1, 1);
 #endif
-		dpaa_eth_packet_info(mbuf, mbuf->buf_addr);
-		dpaa_display_frame_info(fd, fq[0]->fqid, true);
-		if (dpaa_ieee_1588) {
-			annot = GET_ANNOTATIONS(mbuf->buf_addr);
-			dpaa_intf->rx_timestamp =
-				rte_cpu_to_be_64(annot->timestamp);
-		}
+		annot = GET_ANNOTATIONS(mbuf->buf_addr);
+		dpaa_eth_packet_info(dpaa_intf, mbuf, annot);
+		dpaa_display_frame_info(fd, fq[i]->fqid, true);
+		if (unlikely(dpaa_intf->ts_enable))
+			dpaa_intf->rx_timestamp = rte_be_to_cpu_64(annot->timestamp);
 	}
 }
 
@@ -720,11 +720,11 @@ dpaa_rx_cb(struct qman_fq **fq, struct qm_dqrr_entry **dqrr,
 
 	for (i = 0; i < num_bufs; i++) {
 		fd = &dqrr[i]->fd;
-		dpaa_intf = fq[0]->dpaa_intf;
+		dpaa_intf = fq[i]->dpaa_intf;
 		format = (fd->opaque & DPAA_FD_FORMAT_MASK) >>
 				DPAA_FD_FORMAT_SHIFT;
 		if (unlikely(format == qm_fd_sg)) {
-			bufs[i] = dpaa_eth_sg_to_mbuf(fd, dpaa_intf->ifid);
+			bufs[i] = dpaa_eth_sg_to_mbuf(dpaa_intf, fd);
 			continue;
 		}
 
@@ -746,13 +746,11 @@ dpaa_rx_cb(struct qman_fq **fq, struct qm_dqrr_entry **dqrr,
 		rte_mempool_check_cookies(rte_mempool_from_obj((void *)mbuf),
 			(void **)&mbuf, 1, 1);
 #endif
-		dpaa_eth_packet_info(mbuf, mbuf->buf_addr);
-		dpaa_display_frame_info(fd, fq[0]->fqid, true);
-		if (dpaa_ieee_1588) {
-			annot = GET_ANNOTATIONS(mbuf->buf_addr);
-			dpaa_intf->rx_timestamp =
-				rte_cpu_to_be_64(annot->timestamp);
-		}
+		annot = GET_ANNOTATIONS(mbuf->buf_addr);
+		dpaa_eth_packet_info(dpaa_intf, mbuf, annot);
+		dpaa_display_frame_info(fd, fq[i]->fqid, true);
+		if (unlikely(dpaa_intf->ts_enable))
+			dpaa_intf->rx_timestamp = rte_be_to_cpu_64(annot->timestamp);
 	}
 }
 
@@ -787,7 +785,7 @@ dpaa_eth_queue_portal_rx(struct qman_fq *fq,
 		fq->qp_initialized = 1;
 	}
 
-	return qman_portal_poll_rx(nb_bufs, (void **)bufs, fq->qp);
+	return qman_portal_poll_rx(nb_bufs, (void **)bufs, fq->qp, &fq->cb);
 }
 
 enum qman_cb_dqrr_result
@@ -797,11 +795,10 @@ dpaa_rx_cb_parallel(void *event,
 		    const struct qm_dqrr_entry *dqrr,
 		    void **bufs)
 {
-	u32 ifid = ((struct dpaa_if *)fq->dpaa_intf)->ifid;
 	struct rte_mbuf *mbuf;
 	struct rte_event *ev = (struct rte_event *)event;
 
-	mbuf = dpaa_eth_fd_to_mbuf(&dqrr->fd, ifid);
+	mbuf = dpaa_eth_fd_to_mbuf(fq->dpaa_intf, &dqrr->fd);
 	ev->event_ptr = (void *)mbuf;
 	ev->flow_id = fq->ev.flow_id;
 	ev->sub_event_type = fq->ev.sub_event_type;
@@ -825,11 +822,10 @@ dpaa_rx_cb_atomic(void *event,
 		  void **bufs)
 {
 	u8 index;
-	u32 ifid = ((struct dpaa_if *)fq->dpaa_intf)->ifid;
 	struct rte_mbuf *mbuf;
 	struct rte_event *ev = (struct rte_event *)event;
 
-	mbuf = dpaa_eth_fd_to_mbuf(&dqrr->fd, ifid);
+	mbuf = dpaa_eth_fd_to_mbuf(fq->dpaa_intf, &dqrr->fd);
 	ev->event_ptr = (void *)mbuf;
 	ev->flow_id = fq->ev.flow_id;
 	ev->sub_event_type = fq->ev.sub_event_type;
@@ -900,7 +896,7 @@ dpaa_eth_err_queue(struct qman_fq *fq)
 			dpaa_display_frame_info(fd, debug_fq->fqid,
 				i == DPAA_DEBUG_FQ_RX_ERROR);
 
-			mbuf = dpaa_eth_fd_to_mbuf(fd, dpaa_intf->ifid);
+			mbuf = dpaa_eth_fd_to_mbuf(dpaa_intf, fd);
 			rte_pktmbuf_free(mbuf);
 			qman_dqrr_consume(debug_fq, dq);
 		} while (debug_fq->flags & QMAN_FQ_STATE_VDQCR);
@@ -908,13 +904,12 @@ dpaa_eth_err_queue(struct qman_fq *fq)
 }
 #endif
 
-uint16_t dpaa_eth_queue_rx(void *q,
-			   struct rte_mbuf **bufs,
-			   uint16_t nb_bufs)
+uint16_t
+dpaa_eth_queue_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
 	struct qman_fq *fq = q;
 	struct qm_dqrr_entry *dq;
-	uint32_t num_rx = 0, ifid = ((struct dpaa_if *)fq->dpaa_intf)->ifid;
+	uint32_t num_rx = 0;
 	int num_rx_bufs, ret;
 	uint32_t vdqcr_flags = 0;
 	struct annotations_t *annot;
@@ -959,11 +954,11 @@ uint16_t dpaa_eth_queue_rx(void *q,
 		dq = qman_dequeue(fq);
 		if (!dq)
 			continue;
-		bufs[num_rx++] = dpaa_eth_fd_to_mbuf(&dq->fd, ifid);
+		bufs[num_rx++] = dpaa_eth_fd_to_mbuf(dpaa_intf, &dq->fd);
 		dpaa_display_frame_info(&dq->fd, fq->fqid, true);
-		if (dpaa_ieee_1588) {
+		if (unlikely(dpaa_intf->ts_enable)) {
 			annot = GET_ANNOTATIONS(bufs[num_rx - 1]->buf_addr);
-			dpaa_intf->rx_timestamp = rte_cpu_to_be_64(annot->timestamp);
+			dpaa_intf->rx_timestamp = rte_be_to_cpu_64(annot->timestamp);
 		}
 		qman_dqrr_consume(fq, dq);
 	} while (fq->flags & QMAN_FQ_STATE_VDQCR);
@@ -1314,10 +1309,9 @@ dpaa_eth_queue_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 
 	DPAA_DP_LOG(DEBUG, "Transmitting %d buffers on queue: %p", nb_bufs, q);
 
-	if (dpaa_ieee_1588) {
+	if (unlikely(dpaa_intf->ts_enable)) {
 		dpaa_intf->next_tx_conf_queue = fq_txconf;
 		dpaa_eth_tx_conf(fq_txconf);
-		dpaa_intf->tx_timestamp = 0;
 	}
 
 	while (nb_bufs) {
@@ -1326,7 +1320,7 @@ dpaa_eth_queue_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		for (loop = 0; loop < frames_to_send; loop++) {
 			mbuf = *(bufs++);
 			fd_arr[loop].cmd = 0;
-			if (dpaa_ieee_1588) {
+			if (unlikely(dpaa_intf->ts_enable)) {
 				fd_arr[loop].cmd |= DPAA_FD_CMD_FCO |
 					qman_fq_fqid(fq_txconf);
 				fd_arr[loop].cmd |= DPAA_FD_CMD_RPD |
@@ -1481,8 +1475,7 @@ dpaa_eth_tx_conf(void *q)
 
 			if (mbuf->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) {
 				annot = GET_ANNOTATIONS(mbuf->buf_addr);
-				dpaa_intf->tx_timestamp =
-					rte_cpu_to_be_64(annot->timestamp);
+				dpaa_intf->tx_timestamp = rte_be_to_cpu_64(annot->timestamp);
 			}
 			dpaa_display_frame_info(&dq->fd, fq->fqid, true);
 			qman_dqrr_consume(fq, dq);
diff --git a/drivers/net/dpaa/dpaa_rxtx.h b/drivers/net/dpaa/dpaa_rxtx.h
index edb29788fb..233339a488 100644
--- a/drivers/net/dpaa/dpaa_rxtx.h
+++ b/drivers/net/dpaa/dpaa_rxtx.h
@@ -239,7 +239,7 @@ struct __rte_packed_begin dpaa_eth_parse_results_t {
 struct annotations_t {
 	uint8_t reserved[DEFAULT_RX_ICEOF];
 	struct dpaa_eth_parse_results_t parse;	/**< Pointer to Parsed result*/
-	uint64_t timestamp;
+	rte_be64_t timestamp;
 	uint64_t hash;			/**< Hash Result */
 };
 
-- 
2.25.1

