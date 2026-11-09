Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B33606A32A
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=p2goO344
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E26A40278;
	Mon,  9 Nov 2026 17:09:45 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by mails.dpdk.org (Postfix) with ESMTPS id E72BB40270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:09:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ws72ltc2YILTLM4k7K5E+GX+QTwDUIJ0Lu8ngm7bN9bMqg3oBhvd8P/oABTCSKAaN69gBz4E1MEbaE+AHaD9I3Z2z30oeVnTz7vsHfLU8VLCHAXJmJxaE/NCFY6FWTcQ/tEaaJpe0NGbQy0yrpOGHRwdqvcP4XBOOoOGLUEGx+jdBGjIchJJQK8qL0hXQRJwEQYErLGL2Ym4KSO/odXXlDLcGTACvzVlJ6+HCKfPRoSzIoSa+iYFiVUrxXr/4qU5pFVM6q5fEGnMTlpL1Z1X3ZdGwcDFj9rqO7d4PpxLIjbF41i/J0X+mL2vaCkDst5EEtXHErGfQt7x4WMYM+o6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuAJU5bPIPvsx1myghSklhPRC8FXo830QAiOF6sxGdM=;
 b=UWJ1hisrixZ9PE3m8gNI25ZN6Dfv16HlDzxJW9W2Ti30HpIZ6kvyOyrcQqO6DWTU2dWQnr7HJiBsIEScODHuKzYFBMp40qIrp+2LVG41P3ZploxtMWtt2B7oQKEjaGLqghuMW8x++bVPFFMOms7ARlRz2cyxy0sac27Yz+jXTVo/+PxvJTY9hCWVdTZH034IfJ4Uxs/F4S9FgDiQ2715CoHM6NQ3/jBlDMZiLPtVAiHWCoKTUA9gyg7YzZJsvbPhKpuBqDk16h1zjiHxEqdy2MyBNPQQZ3C4t5VMTZy/s/T0seDPQWG3vbMwrERTKiKAMk/q4QhNT/hUvcpQTEIo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuAJU5bPIPvsx1myghSklhPRC8FXo830QAiOF6sxGdM=;
 b=p2goO344hMG12Ita0N8vJnMsc0WONPxpDCLu3FLhdwYQfhSkGqaE/euip8SdkoSTmpPCJbO4OegDh1luGlUd4qR83M9u5QGyifdSBGgvAZU4Haepz1FZgj2k1FHEZB1dGVlhrmj444LRK5OZ6U3Mav/d7HXaG/2MxnNEh616DhAB85xAW48Wq5CCZaYeuZqALtpoytaX3whvWNAD8Uru++gE5BokZmn0TEtjNDMFtln/KSjiaHak32inVae+MhxsWSkuB04B7JPqMAphFdboF5QUhTED3SYieO9lyAGTsruxUeMhd5IOZOLBE6bZFu/OmpxEDNDqdWk2eBnd8owqxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CH3PR03MB7411.namprd03.prod.outlook.com (2603:10b6:610:197::16)
 by DS1PR03MB7942.namprd03.prod.outlook.com (2603:10b6:8:222::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 16:09:35 +0000
Received: from CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088]) by CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 16:09:35 +0000
From: "Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>
To: dev@dpdk.org
Cc: ferruh.yigit@intel.com, stephen@networkplumber.org, rtice@cisco.com,
 cheryl.bansal@altera.com, nanditha.jayarajan@altera.com,
 "Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>
Subject: [RFC 0/4] net/mcdma: add Altera MCDMA poll mode driver
Date: Tue, 10 Nov 2026 00:09:22 +0800
Message-Id: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To CH3PR03MB7411.namprd03.prod.outlook.com
 (2603:10b6:610:197::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR03MB7411:EE_|DS1PR03MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 93115e7e-201e-41ea-2419-08df3e7bd858
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|261021130227099003|261021135927099003|56012099006|261021121427099003|261022113327099003|261022075727099003|261022105027099003|261021123027099003|261026130827099003|261009223027099003|261022115727099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|10067099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Eh9tjJaA/5XDSafH1Fie7NI5keH0muRBxQ9sENsY42GxY4c1jb5fE/BC48C/F6U6sXJvggMKAmmnCEFJIVgW5fBh/mQMSx3zVyxM1OKHs7CsCl8lKoLbIKNZ+Ro0JMl/8w4EF/9y0x86P9rgfyteBuwvrantwIVOGt/PyyQbpih3GqRrTA+qtrvl9wHXTXO6KSJdZGKiqZd3xwfqsJ6MEC6/2LD+FhkC4LbFcB70JM2359OdVKKmZBhSZTWheSRhoKmuJtTT7sO/qVjbyi/+I3ax1QphIx/FFQmlwoudAeu9t4zcJYzl5pxycelR7n+YVvco8RjSj5UbcsLca5tr85X3e+5yks5nbVzzl9/OdeMtCOOh4p/ozRsI1n6ODXyVvRd7dI1E+cnWpalq/uCbemYhFlnTJA2D/4ScuwgWfWdq8SXQTa3nljZF+U7f0V1sEN170nPCdX8Su56fC8TkOH6pGkAhbN7lftu+DGfy40zdGXa8e3TLEFEHWQOcKH06GU78yfrKPltIQmPmMpYlPkvXod8olAJhVF2GSiSUFmH5W2Qp5vHBa2bZ+sdWNvVxY5f0ytlIaSmbPPD/XuWMQhCqBuJmpb3wYD55SKgSrYbHEK/HhO+EcK3Jj+JYhM7ObIIVNiyNfGD8jo0vHRdQxkmUfxpOaYp4jpImT1on4+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR03MB7411.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(261021130227099003)(261021135927099003)(56012099006)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026130827099003)(261009223027099003)(261022115727099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(55112099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uh8X1Yue+/uHYajg5zJmdhYih/zXqUe1hSP7rHao6yfPFTkL/JBUJXu0X39y?=
 =?us-ascii?Q?UafLNKIXPPtHJs59II8GNZ0bV5kSCcP8wzHwEzQoRDCcxz5zUhJQZZI2hh26?=
 =?us-ascii?Q?v/GaNQ6n9E7KjcPlfwlGUNqyjwfUd5Jb/TWEwD3YibRb9bDxv6ahGGBn9yti?=
 =?us-ascii?Q?J88EOoo63DtD3lu27UcsdW3IeJnink/Y4lmJW+hPhYOkAYbL22NKXFOz3xNg?=
 =?us-ascii?Q?dr+cVJBnFbVOyRqdjfy52EGPy0e17ejT4+oWjgBuuTHorSp5wBd7NZFVMx+S?=
 =?us-ascii?Q?DfBVq2ooD+60tbu6Jy78L48QdiY0rUqbvsOi9Hzqi0OSpepFCQ8egVpf2jyk?=
 =?us-ascii?Q?2n8JcVoIu9BhOu8au4nxYv31Ftx6+RQpRyvzVWAb6MBPLHUhQtcnUQwabtax?=
 =?us-ascii?Q?wN/3TKzMT8HV1LVBCaDG8JH0Np8tZYGHFy9IbGmpekXfI/g3dHIMPz3b5+VI?=
 =?us-ascii?Q?84Ni0qa27tff4AogAiw4/ChHMKUXHAd0SjYaDRw5SigTXs2PcPX/aDPRPig6?=
 =?us-ascii?Q?T+QEiQ3uTsxZrj8/srkB8ACRd7XxL381kNdYKt7H8frhmLmJvIxsN0ZErxMu?=
 =?us-ascii?Q?DE3XdbYumu0knIS/IBPWGFVkCZDt9SKWPEg0wWMUHF2HaDtdxl9AENxdazGd?=
 =?us-ascii?Q?Hqqm4reKZCOg5JiStfqoW9Pue3VCKCsU8iIKfEFp+LAoUqg9xJkVUpXT69Cn?=
 =?us-ascii?Q?x55VmXsl3jgO8I2xKarvWctv2I0tmE2MYTK+pQs+C4l5eND3reGgcLqdN1Gf?=
 =?us-ascii?Q?xmCnKQ0+7cOHUl8xrLPbkwL3TNCCBAoX4hq7RrMfXWw02rtkTyhCWFV7SMEx?=
 =?us-ascii?Q?93sdL9HmIvd+t6BNhKsTOAubFkzTrOx2VzmwwS2EQXr492uJAvo/qkGFLKsh?=
 =?us-ascii?Q?DKkntI3lPDBZwUBgyIInh1K72mZhy4Xlgkm1nnKNNXF9cSY380rtTVq8MZLs?=
 =?us-ascii?Q?F7fXpQP4GR4lOHh6mMPDZH5h2IyEVseEskmYeJ+AXywJBbiHwhCSn3Af9zRk?=
 =?us-ascii?Q?5LfQnyXZHhokItykhPOeIxX7zXiXSr8xOsTo2b4ERo1iVLbEKBFceCn/QYWM?=
 =?us-ascii?Q?A8QDfyX3kbTCLEn4hbuuJTQODounfS3VGvJfvhB0UTFt9zvXg12t421pkJcZ?=
 =?us-ascii?Q?c+ySZwcrEX1XpavLRSHK8Wd6oMAw3ObInKIshT+kTyxW3iHE9vxmDYir/bgm?=
 =?us-ascii?Q?7NYbS2zavIBGnspR01y3lGafYDmuQjCQZ7YfeSMJhwQ0WDZLMvBEhrEMDLRA?=
 =?us-ascii?Q?toNcpbHSNanqfovlRMpOzEZ8ZNSH9xJC8WImamFkU+r7h67LZpR8dM7kDky5?=
 =?us-ascii?Q?YUFrPIY3TKDVM1b6/vH7a5SgKbpBHrLERis2WxiKiCpxBThwamcXlneLo/pO?=
 =?us-ascii?Q?ygZcQhAOYGodpPFsurmmuPhagaqMIC9cTdU/0t150AGCd4FbW6zZhrsBRCi+?=
 =?us-ascii?Q?88RbIn2/vSUGxlS1ROHZWF/qHzDnm2qOaybcByVw2vidNFNZsoChAC9bd0TE?=
 =?us-ascii?Q?pnNLfS8S/QNm7KUA7z+By+7/tgHwzkV+YJpK+SZAHhywrR9N5FTUr7WyOjeC?=
 =?us-ascii?Q?L5x807KvL2GwA78nELewfD1lbiSQd4LQCBa0PVih4826i5PTWlEQ/fVsTjhQ?=
 =?us-ascii?Q?q0GsMXT0O7o2Fzm9qc7605B5dv9qoOFdD8Q40mhB6A2vjmETikn+NiVxezGd?=
 =?us-ascii?Q?UNDo1a0Ux2rpaCZrKj99rumgAhPI0JvFmwJeWvoqknbPPxPAOFdnzkvzk6yU?=
 =?us-ascii?Q?v4QPzR8qFbVXkIyGGSzJh87Cxc6FblcWmzdERaeFfE7HvEWsfCov?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93115e7e-201e-41ea-2419-08df3e7bd858
X-MS-Exchange-CrossTenant-AuthSource: CH3PR03MB7411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:09:34.9217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCj6T2yYDf5FOsBQb8RJFGll1fHJ11p/qny9juBaZ2dXnZlIo+DBdNbzmGW+cA7LJX9JYtx7tzG/7KbA3jOpFxfMWuRBQnLnnbHxjNaJo6wMG0FtIm1SDz8r0ketb3O2
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This RFC series introduces a poll mode driver for Altera Multi-Channel
Direct Memory Access (MCDMA) PCI devices. The driver exposes
host-to-device and device-to-host descriptor queues as standard DPDK
Ethernet ports for custom FPGA datapaths.

While the MCDMA IP supports multiple PFs and VFs per PF, this RFC
implements single PF with multiple VFs; each function exposes multiple
Rx/Tx queue pairs backed by H2D/D2H descriptor rings and per-queue
QCSR.

User guide reference:
https://docs.altera.com/r/docs/683821/25.3.1/multi-channel-dma-ip-for-pci-express-user-guide/before-you-begin

The series is split for review as follows:
 1. Core driver skeleton, queue management, documentation, and features
    matrix, excluding datapath bursts, debug dumps, and PIO APIs.
 2. Rx and Tx packet burst handlers.
 3. Experimental PIO BAR access APIs.
 4. Experimental QCSR inspection and dump APIs.

Functional testing was performed on Linux with vfio-pci, using DPDK
pktgen on a single PF and VF configuration. The attached user logic
was adapted as needed for validation.

We would appreciate feedback on the ethdev design, the experimental
PIO APIs, and PF/VF devargs.

Subhransu S. Prusty (4):
  net/mcdma: add Altera MCDMA poll mode driver skeleton
  net/mcdma: add Rx and Tx packet burst paths
  net/mcdma: add experimental PIO access APIs
  net/mcdma: add experimental QCSR dump APIs

 MAINTAINERS                                 |   4 +
 doc/guides/nics/features/mcdma.ini          |  17 +
 doc/guides/nics/index.rst                   |   1 +
 doc/guides/nics/mcdma.rst                   | 147 +++
 drivers/net/altera/mcdma/mcdma_config_csr.h | 201 +++++
 drivers/net/altera/mcdma/mcdma_eth.c        | 323 +++++++
 drivers/net/altera/mcdma/mcdma_eth.h        | 335 +++++++
 drivers/net/altera/mcdma/mcdma_eth_ops.c    | 933 ++++++++++++++++++++
 drivers/net/altera/mcdma/mcdma_eth_rxtx.c   | 401 +++++++++
 drivers/net/altera/mcdma/meson.build        |  16 +
 drivers/net/altera/mcdma/rte_pmd_mcdma.c    | 284 ++++++
 drivers/net/altera/mcdma/rte_pmd_mcdma.h    | 140 +++
 drivers/net/meson.build                     |   1 +
 usertools/dpdk-devbind.py                   |   1 +
 14 files changed, 2804 insertions(+)
 create mode 100644 doc/guides/nics/features/mcdma.ini
 create mode 100644 doc/guides/nics/mcdma.rst
 create mode 100644 drivers/net/altera/mcdma/mcdma_config_csr.h
 create mode 100644 drivers/net/altera/mcdma/mcdma_eth.c
 create mode 100644 drivers/net/altera/mcdma/mcdma_eth.h
 create mode 100644 drivers/net/altera/mcdma/mcdma_eth_ops.c
 create mode 100644 drivers/net/altera/mcdma/mcdma_eth_rxtx.c
 create mode 100644 drivers/net/altera/mcdma/meson.build
 create mode 100644 drivers/net/altera/mcdma/rte_pmd_mcdma.c
 create mode 100644 drivers/net/altera/mcdma/rte_pmd_mcdma.h

-- 
2.34.1

