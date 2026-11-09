Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9D606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Kkp69rDM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD23240DFB;
	Mon,  9 Nov 2026 17:09:54 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013071.outbound.protection.outlook.com
 [40.107.201.71])
 by mails.dpdk.org (Postfix) with ESMTPS id E14AA40A75
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:09:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcNyg5df0KjPCX9C47q0cWOMLCON0IG+7DTt/D1v53X24ikjEiNlbym0G5WzT3Rk6hlhSccWvs35KMqeZORwCxBahvkFZ3xQABvCbS3fSF32td4fa1DT1NFozgYWapemIEA+/f1Lc6aBx/IK5XxnadKU7TmmRbVS1tr0EDvQKx9oE/nFFNS27vih4dIFL1Pk4w/KkVzSmhw7puZataxxoom2ypzPz3MQgatUHQj/61R7Wa5ThqXmt+yb95iX+jOftLZA4W9yed9dXdCIiWElBDuoCID3V29b9t2UVGthRDCWS1Ac5hrSw7sEpYzrcH9szfOORTyOibiDUMeQtPuAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMpCXc//ZRwEUrmQgORdOzgq7vv/2ZlDCLCr61jSF68=;
 b=GjUgCxdiq3YCte9I8YvLfHQX+FGk9xb98GE+7I0i+CfHbyo1MVivkzyYIS7p68P3P1qnoXTvqZQF3tONnrHNzv59CZLY1tVCOAFO/sBz+I5kNyi6XB8a0SIIS0P8odqIEDziJNSne0lBi8UoAtdfAp7o3oLafGqnMRr+BAllyONY4kutDcvMGWWEhYa5HknIfuHmcARZC3XOsZnpvHonWNl+yWQKPSFFrl8PsEtcdSE2Q+w8FxX8C25KRf4tLpUgbY/Q3bmLFY6LI9325N87cZURHQmEuAQfMDlvRRjrVE58MRVIZJ+CvUcFcnNbQkPz3jkxAGLtttcCeXqIbjSjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMpCXc//ZRwEUrmQgORdOzgq7vv/2ZlDCLCr61jSF68=;
 b=Kkp69rDMzHBrPHP89hwXG0019278DFyMUgVSqb2HKXR2/7jNYgTB6cKsKMmQwr5gCyIH7vuzsu52xdVtwYlfjW9/Cklq3BZAFfmNSxJL1WCt3RXC0f4R4eszkAOg5dOUmbPDVE3G2qg4lXohQmU9TJokKlJT/LZL8t7R7iXJFotZW7pkiqGrPi9/VnSrFpNnRhHXFetzSDtr7ti7wkGe3TfHNYP2g5YssHorcUOwqjqDgQLQ77VzqxG60W1z1ORNI6NZ/29cVAdToUjMPz7NUAIHq8O18oUIaXKRVn0YEmsT/TV3jHujB3YN9SCBsu22xX7sgd/bocpwKBT+ae0B4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CH3PR03MB7411.namprd03.prod.outlook.com (2603:10b6:610:197::16)
 by DS1PR03MB7942.namprd03.prod.outlook.com (2603:10b6:8:222::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 16:09:47 +0000
Received: from CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088]) by CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 16:09:47 +0000
From: "Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>
To: dev@dpdk.org
Cc: ferruh.yigit@intel.com, stephen@networkplumber.org, rtice@cisco.com,
 cheryl.bansal@altera.com, nanditha.jayarajan@altera.com,
 "Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>
Subject: [RFC 4/4] net/mcdma: add experimental QCSR dump APIs
Date: Tue, 10 Nov 2026 00:09:26 +0800
Message-Id: <20261109160926.800828-5-subhransu.sekhar.prusty@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
References: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To CH3PR03MB7411.namprd03.prod.outlook.com
 (2603:10b6:610:197::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR03MB7411:EE_|DS1PR03MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 4804ba40-5b98-44ad-8648-08df3e7be049
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|261021130227099003|261021135927099003|56012099006|261021121427099003|261022113327099003|261022075727099003|261022105027099003|261021123027099003|261026130827099003|261009223027099003|261022115727099003|261026140227099003|261102130727099003|261028144727099003|261102123227099003|261026121527099003|10067099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: vONbq6WE3ULX/vPtmkLHakUy9f869Tn7pXOKIc51An1oZHp9UbSjyI02WKLjtsl/Q5vzEHTN2paCQnK7F6sq5SZ/2uNpBsF/3DuYphfjqLfGQXsJBjApLYeR9wPgm+fQTWfUzTCdLOv+GzCYEmEdzmyQw/iiz7eaNJ/sb7TEn0RkEmaWaMU2pAd0MxOUrAwFQkacpdKAavOGlvE/QLuURMw1t5MmcUp6wunSoRTXQk+0/giEcI/bdPrX6XtdDjXRhL+qQMxZuVs3ySc9ynOOBsnjDRM7A7mhs87LSgoMvSQr/sQKijKVtGpHz00w8A84y1WEdDDcw1tXQyJu99OglUVeJ82d+sE/jvimm7mrQGgTBEljdorOIdBSdyTuUpE55JKRv7t+hN24cZHKoNvO4XHZiqAzF55bQpNrWujtPZlcL4PpEYFbYEK5VcjWdXJYhzj6hkmyb9LKSpXjQU8Q7LSi/jpcl5NnnVFrfzxcNGHCiTOBAy12tcfKRtgVqLOr2vHZEXiKOnxBFYgJVzvbGXSGVjQ7UN+zBEPDupp6Ubif9QTT/fs/AbxTqGgDN+Mz0+icxQBpnFrhyQVZT0mEa+pn38Fc6e4sgA67dyFenuLevmPfqjFTxVlF7w0LO5+iOzsAxuegW643DTPvF5EMyzvkvRN6NEzT+4LwvEf7DIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR03MB7411.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(261021130227099003)(261021135927099003)(56012099006)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026130827099003)(261009223027099003)(261022115727099003)(261026140227099003)(261102130727099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?npuarJbEzjYwxEq6PJWvoUyBA0srlFDAj2rMDIH4WQtZm8+RKdT1q6P6/Hah?=
 =?us-ascii?Q?Q2L84SyJlzIfrUtX7NYxnRA0aR0lcf9cfEfnVwqOXR3xIGKWM9fcJpga9FQ3?=
 =?us-ascii?Q?J9qYwTbM3gqcS3Pg9/aeGhsOccEpYBhHFfcdrPKU+eDcDcH0xdMBCR2Y2whE?=
 =?us-ascii?Q?cKwP7eDWwKg+RCAeyy4fRQFHLh7xq0DbRRJD6XLhr1jkHRPVUI0nLfR8bNpJ?=
 =?us-ascii?Q?zJkuGE+n9QRIxab+1LPTjZzcoMdFdrpdyElRaECarzA2BndN5qP+KhEVqdnE?=
 =?us-ascii?Q?DeQo9FkxevOZfqsbc28bqdwyJkRkiTKxuV4TmtQ/2J/KSpBfLusNikbloedF?=
 =?us-ascii?Q?kjBBrIWCXxu+mZTDjZ3gwC06pbb70VEYzasrtl2b8dCZIDQkPfkkQ4+A6kLq?=
 =?us-ascii?Q?fS/0xYjHpsbzC6JKq5r/n1ML5XHKnBeTD4WLDebNhUyhpb8KxPJ47ZJI7F7l?=
 =?us-ascii?Q?hULNxFP7UIZbs0/xDszk1hDgE2G22dpATO1i+Xj2ZJa55v3RG1VLre2kF738?=
 =?us-ascii?Q?VFdJYBUDkVCywAqrt4lGTcbzvAM79QVovyKUPdXLGwGNfcEpNshy5PlpTW9Z?=
 =?us-ascii?Q?CX2xHzijhtXinRGbIWwo0RKg5ompTZ4rujxVOlZjuFkPCF6Z9a7ZD0AODwB6?=
 =?us-ascii?Q?+D/iHKyMLm7YRXsdBsSYDeu8Xd2BdLx7uXegqN2oKX7SMZ1q9vPH6KIITlPh?=
 =?us-ascii?Q?FMEk9PHTQkxQNEqCi+3Q6mPgQsKpVPKloLOOLF+15e50bxODBlT9iqKRxz/H?=
 =?us-ascii?Q?J0WQ5G01PXEOhpIra6fPbvhdkpwkzSKbnahnTRSdb8UJfS2XMSEqVrYeGhqz?=
 =?us-ascii?Q?fWLE+g2h+iiO/TX3O7ed5S/EPj3a2EyaY7lIeQJpr3Zi1mHlHKj5ctkF4Fol?=
 =?us-ascii?Q?9r9aCCl4nfPiccrV0PKKaTY7c8q3HPOSZ8nH5zb8ma6xuxegc/ghEBEm4KyI?=
 =?us-ascii?Q?8NHAGEeg9pQLFXVgBZSl283pCmTcXSujwsYu2Ndu39sKaKtb9VgQ9sL7w2A4?=
 =?us-ascii?Q?BC8wxJ1uaRS88DC3iJV7q1YRf9fj3ss+s0MD6IpRcQMqjGAiamwje27T14dP?=
 =?us-ascii?Q?S0itQY0I+Scj4tBhctW1GocOTtEt1R1w8VIuo9kbz0rcYcGK86KOKU+3W8P4?=
 =?us-ascii?Q?AQ29pv7+6ToePGOgGToxnRiLu/mGUTXcEC/iw73x+k1yWbWPM0C6Xr34FVB+?=
 =?us-ascii?Q?qi/8wgAfgG73jydKedWK7jslrQ2pzdeJxJ3582iILAWPOf2deHgoTJqZptiQ?=
 =?us-ascii?Q?+YiS/SNrWCwYt48xxWBjiZeF40PkZ3X1XSYUUTsOm85ZKLzqXRpQJJH1mvnN?=
 =?us-ascii?Q?uEh4Utzac87tChSGXP9kWxva6mVIn3SYyq2qv8MndntNzKrDSITfsxV3L5o7?=
 =?us-ascii?Q?T9x4ymmt/moT/xckYfqIFGKnNF1EvB/zBaJ8NnAaRKjQHF7OWvu/3qE0n2BJ?=
 =?us-ascii?Q?yvCDEz7Ui5v/IkTI1i59aUEMlXEinSUqHH6IABxD44CU/0k+efH7whDX9Ev5?=
 =?us-ascii?Q?bMqeFEUzWDyrjaP1vEmN9npFgi4YbnbMCXeU3A/C0zNG6tFyzQ1uHz6kt6sr?=
 =?us-ascii?Q?PovXUX/9xT7UcX6MkYH+pXE0vlSSZooCqh3abVu2Deh5g44p8Xh5rjuLzbmY?=
 =?us-ascii?Q?DWZggW1GW6kLAbH2dWjEkSbI/iXklu/iKs/TeErphiWRdFZZbhuZXlgoaNLf?=
 =?us-ascii?Q?eMrnmRANSd8zXbAFhUACDEDOLORjI3FkRO2RYFLpQd31IoEEn2HLPgEmPn7i?=
 =?us-ascii?Q?Z+Pdj2wt8kwBrkdWbe6U/GT/DzNX7EUNV9pPgTAZiz1tivQdvplB?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4804ba40-5b98-44ad-8648-08df3e7be049
X-MS-Exchange-CrossTenant-AuthSource: CH3PR03MB7411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:09:47.7477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +T+kYtWDrMfsGzCiOESrC7ASsb4tHjyVVsXGRdK6mpPSvTxYyOZW1GjF17lyqsd7wuLy3vFQWli7ca4/M1pzr9ZZOgtOeM8J9iqzTpzV1IFwshwYoxiFJ/8IK6q048Bj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7942
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

Add rte_pmd_mcdma_qcsr_read() and rte_pmd_mcdma_qcsr_dump() to snapshot
and print queue control/status registers together with driver software
indices. Document the QCSR helpers in mcdma.rst.

Co-developed-by: Cheryl Bansal <cheryl.bansal@altera.com>
Signed-off-by: Cheryl Bansal <cheryl.bansal@altera.com>
Signed-off-by: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
---
 doc/guides/nics/mcdma.rst                |  10 +-
 drivers/net/altera/mcdma/rte_pmd_mcdma.c | 178 +++++++++++++++++++++++
 drivers/net/altera/mcdma/rte_pmd_mcdma.h |  79 ++++++++++
 3 files changed, 265 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/mcdma.rst b/doc/guides/nics/mcdma.rst
index 3bbd345d575c..a41997f1618d 100644
--- a/doc/guides/nics/mcdma.rst
+++ b/doc/guides/nics/mcdma.rst
@@ -107,8 +107,14 @@ defined by the FPGA application connected to the MCDMA IP.
 Experimental driver API
 -----------------------
 
-The header ``rte_pmd_mcdma.h`` provides experimental helpers to access
- the PIO BAR:
+The header ``rte_pmd_mcdma.h`` provides experimental helpers to inspect queue
+state and access the PIO BAR:
+
+rte_pmd_mcdma_qcsr_read()
+   Read QCSR registers and software queue indices for one queue.
+
+rte_pmd_mcdma_qcsr_dump()
+   Dump decoded QCSR state to a ``FILE`` stream.
 
 rte_pmd_mcdma_pio_read64() / rte_pmd_mcdma_pio_write64()
    Read or write 64-bit registers in the mapped PIO BAR. ``pio_read64`` returns
diff --git a/drivers/net/altera/mcdma/rte_pmd_mcdma.c b/drivers/net/altera/mcdma/rte_pmd_mcdma.c
index 49d7d97b90bc..3736c7b45913 100644
--- a/drivers/net/altera/mcdma/rte_pmd_mcdma.c
+++ b/drivers/net/altera/mcdma/rte_pmd_mcdma.c
@@ -38,6 +38,82 @@ mcdma_pmd_port_get(uint16_t port_id, struct rte_eth_dev **eth_dev)
 	return 0;
 }
 
+static struct mcdma_queue *
+mcdma_pmd_queue_get(struct rte_eth_dev *dev, uint16_t queue_id,
+		    enum rte_pmd_mcdma_queue_dir dir)
+{
+	if (dir == RTE_PMD_MCDMA_QUEUE_TX) {
+		if (queue_id >= dev->data->nb_tx_queues)
+			return NULL;
+		return dev->data->tx_queues[queue_id];
+	}
+
+	if (queue_id >= dev->data->nb_rx_queues)
+		return NULL;
+
+	return dev->data->rx_queues[queue_id];
+}
+
+static void
+mcdma_qcsr_regs_read(struct mcdma_queue *q, struct rte_pmd_mcdma_qcsr *regs)
+{
+	regs->q_ctrl = mcdma_qcsr_reg_readl(q->qcsr, MCDMA_QCSR_Q_CTRL);
+	regs->q_start_addr_l = mcdma_qcsr_reg_readl(q->qcsr,
+						    MCDMA_QCSR_Q_START_ADDR_L);
+	regs->q_start_addr_h = mcdma_qcsr_reg_readl(q->qcsr,
+						    MCDMA_QCSR_Q_START_ADDR_H);
+	regs->q_size = mcdma_qcsr_reg_readl(q->qcsr, MCDMA_QCSR_Q_SIZE);
+	regs->q_tail_pointer = mcdma_qcsr_reg_readl(q->qcsr,
+						    MCDMA_QCSR_Q_TAIL_POINTER);
+	regs->q_head_pointer = mcdma_qcsr_reg_readl(q->qcsr,
+						    MCDMA_QCSR_Q_HEAD_POINTER);
+	regs->q_completed_pointer = mcdma_qcsr_reg_readl(q->qcsr,
+							 MCDMA_QCSR_Q_COMPLETED_POINTER);
+	regs->q_consumed_head_addr_l = mcdma_qcsr_reg_readl(q->qcsr,
+			MCDMA_QCSR_Q_CONSUMED_HEAD_ADDR_L);
+	regs->q_consumed_head_addr_h = mcdma_qcsr_reg_readl(q->qcsr,
+			MCDMA_QCSR_Q_CONSUMED_HEAD_ADDR_H);
+	regs->q_batch_delay = mcdma_qcsr_reg_readl(q->qcsr,
+						   MCDMA_QCSR_Q_BATCH_DELAY);
+	regs->q_debug_status_1 = mcdma_qcsr_reg_readl(q->qcsr,
+						      MCDMA_QCSR_Q_DEBUG_STATUS_1);
+	regs->q_debug_status_2 = mcdma_qcsr_reg_readl(q->qcsr,
+						      MCDMA_QCSR_Q_DEBUG_STATUS_2);
+	regs->q_data_drp_err_ctr = mcdma_qcsr_reg_readl(q->qcsr,
+			MCDMA_QCSR_Q_DATA_DRP_ERR_CTR);
+	regs->q_payload_count = mcdma_qcsr_reg_readl(q->qcsr,
+						     MCDMA_QCSR_Q_PAYLOAD_COUNT);
+	regs->q_reset = mcdma_qcsr_reg_readl(q->qcsr, MCDMA_QCSR_Q_RESET);
+	regs->q_cpl_timeout = mcdma_qcsr_reg_readl(q->qcsr,
+						   MCDMA_QCSR_Q_CPL_TIMEOUT);
+
+	rte_rmb();
+	regs->prod_didx = q->prod_didx;
+	regs->cons_didx = q->cons_didx;
+	regs->freed_cons_didx = q->freed_cons_didx;
+	regs->submitted_didx = q->submitted_didx;
+	regs->num_descs = q->num_descs;
+}
+
+static void
+mcdma_qcsr_dump_decoded(FILE *f, const struct rte_pmd_mcdma_qcsr *regs)
+{
+	mcdma_qcsr_q_ctrl_t q_ctrl;
+
+	q_ctrl.val = regs->q_ctrl;
+	fprintf(f, "  Q_CTRL decoded: q_en=%u q_wb_en=%u q_intr_en=%u\n",
+		q_ctrl.field.q_en, q_ctrl.field.q_wb_en, q_ctrl.field.q_intr_en);
+
+	if (regs->q_head_pointer & MCDMA_QCSR_PTR_ERR_MASK)
+		fprintf(f, "  Q_HEAD_POINTER error bit set\n");
+	if (regs->q_completed_pointer & MCDMA_QCSR_PTR_ERR_MASK)
+		fprintf(f, "  Q_COMPLETED_POINTER error bit set\n");
+	if (regs->q_data_drp_err_ctr & MCDMA_QCSR_DRP_CTR_VALID) {
+		fprintf(f, "  Q_DATA_DRP_ERR_CTR drop_count=%u\n",
+			regs->q_data_drp_err_ctr & MCDMA_QCSR_DRP_CTR_CNT_MASK);
+	}
+}
+
 static int
 mcdma_pio_offset_check(const struct mcdma_pci_device *priv, uint64_t offset)
 {
@@ -104,3 +180,105 @@ rte_pmd_mcdma_pio_write64(uint16_t port_id, uint64_t offset, uint64_t val)
 	mcdma_pio_reg_write64(priv->pio, offset, val);
 	return 0;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mcdma_qcsr_read, 26.11)
+int
+rte_pmd_mcdma_qcsr_read(uint16_t port_id, uint16_t queue_id,
+			enum rte_pmd_mcdma_queue_dir dir,
+			struct rte_pmd_mcdma_qcsr *regs)
+{
+	struct rte_eth_dev *dev;
+	struct mcdma_queue *q;
+	int ret;
+
+	if (regs == NULL)
+		return -EINVAL;
+
+	if (dir != RTE_PMD_MCDMA_QUEUE_RX && dir != RTE_PMD_MCDMA_QUEUE_TX)
+		return -EINVAL;
+
+	ret = mcdma_pmd_port_get(port_id, &dev);
+	if (ret != 0)
+		return ret;
+
+	q = mcdma_pmd_queue_get(dev, queue_id, dir);
+	if (q == NULL || q->qcsr == NULL)
+		return -EINVAL;
+
+	memset(regs, 0, sizeof(*regs));
+	mcdma_qcsr_regs_read(q, regs);
+	return 0;
+}
+
+static void
+mcdma_qcsr_dump_reg(FILE *f, const char *name, uint32_t offset, uint32_t val)
+{
+	fprintf(f, "  %s @ 0x%03x = 0x%08x (%u)\n", name, offset, val, val);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mcdma_qcsr_dump, 26.11)
+int
+rte_pmd_mcdma_qcsr_dump(uint16_t port_id, uint16_t queue_id,
+			enum rte_pmd_mcdma_queue_dir dir, FILE *f)
+{
+	struct rte_pmd_mcdma_qcsr regs;
+	uint64_t qbuf_dma;
+	int ret;
+
+	if (f == NULL)
+		f = stdout;
+
+	ret = rte_pmd_mcdma_qcsr_read(port_id, queue_id, dir, &regs);
+	if (ret != 0)
+		return ret;
+
+	qbuf_dma = ((uint64_t)regs.q_start_addr_h << 32) | regs.q_start_addr_l;
+
+	fprintf(f, "MCDMA QCSR dump port %u queue %u %s\n",
+		port_id, queue_id,
+		dir == RTE_PMD_MCDMA_QUEUE_TX ? "TX" : "RX");
+	fprintf(f, "  ring_dma=0x%016llx ring_size_log2=%u\n",
+		(unsigned long long)qbuf_dma, regs.q_size);
+
+	mcdma_qcsr_dump_reg(f, "Q_CTRL", MCDMA_QCSR_Q_CTRL, regs.q_ctrl);
+	mcdma_qcsr_dump_reg(f, "Q_START_ADDR_L", MCDMA_QCSR_Q_START_ADDR_L,
+			    regs.q_start_addr_l);
+	mcdma_qcsr_dump_reg(f, "Q_START_ADDR_H", MCDMA_QCSR_Q_START_ADDR_H,
+			    regs.q_start_addr_h);
+	mcdma_qcsr_dump_reg(f, "Q_SIZE", MCDMA_QCSR_Q_SIZE, regs.q_size);
+	mcdma_qcsr_dump_reg(f, "Q_TAIL_POINTER", MCDMA_QCSR_Q_TAIL_POINTER,
+			    regs.q_tail_pointer);
+	mcdma_qcsr_dump_reg(f, "Q_HEAD_POINTER", MCDMA_QCSR_Q_HEAD_POINTER,
+			    regs.q_head_pointer);
+	mcdma_qcsr_dump_reg(f, "Q_COMPLETED_POINTER",
+			    MCDMA_QCSR_Q_COMPLETED_POINTER,
+			    regs.q_completed_pointer);
+	mcdma_qcsr_dump_reg(f, "Q_CONSUMED_HEAD_ADDR_L",
+			    MCDMA_QCSR_Q_CONSUMED_HEAD_ADDR_L,
+			    regs.q_consumed_head_addr_l);
+	mcdma_qcsr_dump_reg(f, "Q_CONSUMED_HEAD_ADDR_H",
+			    MCDMA_QCSR_Q_CONSUMED_HEAD_ADDR_H,
+			    regs.q_consumed_head_addr_h);
+	mcdma_qcsr_dump_reg(f, "Q_BATCH_DELAY", MCDMA_QCSR_Q_BATCH_DELAY,
+			    regs.q_batch_delay);
+	mcdma_qcsr_dump_reg(f, "Q_DEBUG_STATUS_1", MCDMA_QCSR_Q_DEBUG_STATUS_1,
+			    regs.q_debug_status_1);
+	mcdma_qcsr_dump_reg(f, "Q_DEBUG_STATUS_2", MCDMA_QCSR_Q_DEBUG_STATUS_2,
+			    regs.q_debug_status_2);
+	mcdma_qcsr_dump_reg(f, "Q_DATA_DRP_ERR_CTR",
+			    MCDMA_QCSR_Q_DATA_DRP_ERR_CTR,
+			    regs.q_data_drp_err_ctr);
+	mcdma_qcsr_dump_reg(f, "Q_PAYLOAD_COUNT", MCDMA_QCSR_Q_PAYLOAD_COUNT,
+			    regs.q_payload_count);
+	mcdma_qcsr_dump_reg(f, "Q_RESET", MCDMA_QCSR_Q_RESET, regs.q_reset);
+	mcdma_qcsr_dump_reg(f, "Q_CPL_TIMEOUT", MCDMA_QCSR_Q_CPL_TIMEOUT,
+			    regs.q_cpl_timeout);
+
+	fprintf(f, "  SW prod_didx=%u cons_didx=%u freed_cons_didx=%u "
+		"submitted_didx=%u num_descs=%u\n",
+		regs.prod_didx, regs.cons_didx, regs.freed_cons_didx,
+		regs.submitted_didx, regs.num_descs);
+
+	mcdma_qcsr_dump_decoded(f, &regs);
+	return 0;
+}
diff --git a/drivers/net/altera/mcdma/rte_pmd_mcdma.h b/drivers/net/altera/mcdma/rte_pmd_mcdma.h
index d76babbdf7e0..7b4ad83c07a2 100644
--- a/drivers/net/altera/mcdma/rte_pmd_mcdma.h
+++ b/drivers/net/altera/mcdma/rte_pmd_mcdma.h
@@ -16,6 +16,85 @@
 
 #include <rte_compat.h>
 
+/** MCDMA queue direction for PMD APIs. */
+enum rte_pmd_mcdma_queue_dir {
+	RTE_PMD_MCDMA_QUEUE_RX = 0, /**< Device-to-host (RX). */
+	RTE_PMD_MCDMA_QUEUE_TX = 1, /**< Host-to-device (TX). */
+};
+
+/** Snapshot of one queue's QCSR registers and driver state. */
+struct rte_pmd_mcdma_qcsr {
+	uint32_t q_ctrl;
+	uint32_t q_start_addr_l;
+	uint32_t q_start_addr_h;
+	uint32_t q_size;
+	uint32_t q_tail_pointer;
+	uint32_t q_head_pointer;
+	uint32_t q_completed_pointer;
+	uint32_t q_consumed_head_addr_l;
+	uint32_t q_consumed_head_addr_h;
+	uint32_t q_batch_delay;
+	uint32_t q_debug_status_1;
+	uint32_t q_debug_status_2;
+	uint32_t q_data_drp_err_ctr;
+	uint32_t q_payload_count;
+	uint32_t q_reset;
+	uint32_t q_cpl_timeout;
+
+	uint16_t prod_didx;
+	uint16_t cons_didx;
+	uint16_t freed_cons_didx;
+	uint16_t submitted_didx;
+	uint32_t num_descs;
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Read QCSR registers and software queue state for one queue.
+ *
+ * @param port_id
+ *   Port identifier.
+ * @param queue_id
+ *   Queue identifier.
+ * @param dir
+ *   Queue direction (RX or TX).
+ * @param regs
+ *   Output register snapshot.
+ *
+ * @return
+ *   0 on success, negative errno on failure.
+ */
+__rte_experimental
+int
+rte_pmd_mcdma_qcsr_read(uint16_t port_id, uint16_t queue_id,
+			enum rte_pmd_mcdma_queue_dir dir,
+			struct rte_pmd_mcdma_qcsr *regs);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Dump QCSR registers and software queue state to a stream.
+ *
+ * @param port_id
+ *   Port identifier.
+ * @param queue_id
+ *   Queue identifier.
+ * @param dir
+ *   Queue direction (RX or TX).
+ * @param f
+ *   Output stream. Uses stdout if NULL.
+ *
+ * @return
+ *   0 on success, negative errno on failure.
+ */
+__rte_experimental
+int
+rte_pmd_mcdma_qcsr_dump(uint16_t port_id, uint16_t queue_id,
+			enum rte_pmd_mcdma_queue_dir dir, FILE *f);
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
-- 
2.34.1

