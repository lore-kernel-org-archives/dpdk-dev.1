Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEC1C28B30
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 03:06:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CDAB40276;
	Fri, 21 Mar 2025 04:06:16 +0100 (CET)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on2123.outbound.protection.outlook.com [40.107.215.123])
 by mails.dpdk.org (Postfix) with ESMTP id 535DC40268
 for <dev@dpdk.org>; Fri, 21 Mar 2025 04:06:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tm8wJmXztuMFs51aFnR9UaFImmSpzAGZI4UB/F1ExZVgxDvlhktQmqpYPAaO1jtSndu2FueQ2wMvlt2o6dh4f6VUX9P5plhsy+KovEJZO4nKvE9FY1YJFM/r694ozSpIS5dM6OL6d1/8u53/6fHQq2bMe6uhHXrjFadZGgfAdcqC+UD2c4v+lFriEuVMU6RB814+F0yA7tViU9/w1TOfR0DSGA401D3nTyg+rLfK381zjfzdt6uBfHt9Hz2TM+4tHOplbCfYTG3UXNRfJTVEh1qaNd6/G9aTXweXbECM3e72VWbFO6z/Eo9InX2V4T5WAZSsIsKa6jNYX2aK1pWm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEZSp6advnzHHXoacqVEWgmYLC1aF8tSn64Lgjy6Eyo=;
 b=qEwHMXxCYsqWBOKlKlBKBXRF9TI83i2giidwtSDR28aFhn4UqDU0pMD+tyDXnT0WCadlRo++PwQ10JIP/JMgx2CjqQ8tfjIhjE9WloyxW+DqBVGF7mAWdRlMDRyDGswMkGUc7ngBcVOkIB/llGl6owo/A5SqJM12q8/8Aft7QL9wdUhOInvkFcQD2ubCHd2zIEHi9pa9qa/Y6Qcw5UuF8f6pIScb3MaH6z8WkuUBpA1nzmfdTTeLLRWyYNeDkvD3HlP9YkcUjMyCJFKtL8BSMcvWU248GCWo/KPqRrOx5yyTuLbE5T3IgXN1ITIJSZijJ81wfbumPX1RENOERFDXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEZSp6advnzHHXoacqVEWgmYLC1aF8tSn64Lgjy6Eyo=;
 b=IvU3WajQisgzdg7Ey921O9iwRKTvd5+mJe2REKoJw9nOaIb07RjZIMgIukc5MLR0SA0wjtQov9QDhsqfTwCzAPBo9ksf9aSAJW/JpWrXJV+lfEiMHeRkLVx/2yYz8CuKxQTFNm2evqeM058J1BcoN5M5NA0QmKxmJHs49VFlgjqa6+XJab9Xi9gr4aNK6psBpZeuwscMRRl0UOLJJuV+qI4Is1t9XBt/TT8jw7JrxxK3jXv/WbzLcYJqCL09slbe4J8V9PVlXWzViDre/lnxfECAWqAj3MGgYcpt8KpiTyZwLS2byJcWjMqwiYyIwtdF8z/QGE1NIlfCeI9ssOU7Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com (2603:1096:4:15c::13)
 by TY0PR06MB6882.apcprd06.prod.outlook.com (2603:1096:405:16::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 03:06:11 +0000
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4]) by SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 03:06:11 +0000
From: Shaokai Zhang <felix.zhang@jaguarmicro.com>
To: dev@dpdk.org
Cc: linville@tuxdriver.com
Subject: [PATCH v3 0/1] net/af_packet: register supported param fanout mode
Date: Fri, 21 Mar 2025 11:05:50 +0800
Message-ID: <20250321030552.6231-1-felix.zhang@jaguarmicro.com>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250320083707.5594-2-felix.zhang@jaguarmicro.com>
References: <20250320083707.5594-2-felix.zhang@jaguarmicro.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To SI2PR06MB4234.apcprd06.prod.outlook.com
 (2603:1096:4:15c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB4234:EE_|TY0PR06MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d07d084-815d-42fd-b3b8-08dd68255537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f9DNBV+BbQiBZ9osGYfstg4k87NypMZch2DNoZiNtIIJCq2aIhNeNRU7u5/K?=
 =?us-ascii?Q?+eyZ03t4fuEkdcZxgT+GWYHlsWypjpebthOmYIVdhO6UqJeDNWfrLeyTLdIG?=
 =?us-ascii?Q?2hEYYD1MkqBLjONzscolDHMWMrX8Q4AlOUfrk+QPThxDqhpcPbRyGaZc///e?=
 =?us-ascii?Q?QkqdfEQE+ZqNPJupFZmOXwkAssHBvVcZLyx1Ye/kEacczcn69rJtDJnunkjD?=
 =?us-ascii?Q?/62QfLeo9lcnpZJyUVAI+LIQ29M7Q8SLtBu5Y3IB/nQq8cBc7aMM82acwJC3?=
 =?us-ascii?Q?BEQ5Tks6czAwKwopE6qiGNLuQQrmxBJ2F2gaos+BPXZEdijBxQ8IEp6S11Ec?=
 =?us-ascii?Q?fS5RtVmltTRPpa/xWcThQn1vhTwCtnBBIVQBr5iPWTTb3FOir52x4Ky/M0pW?=
 =?us-ascii?Q?IC6FVt16MkSQxxCfY7o5mIYBtQji/23XcyhiRKKK0rbjQa1jnDEj5R1+Qg5A?=
 =?us-ascii?Q?5AG4VDCLQVougDtW8I2cq3DAHMaA0VyaauMuiOZMR4l+8sWIAIAIYTgZHDiV?=
 =?us-ascii?Q?LiiXLNE+1wgoLCEuEoN3+BDgnrNKHbGH4TJdxT1fk/oTh1Q/z/rKkxbHn3h8?=
 =?us-ascii?Q?FqI3+0ltTkfcPpIE1tORPRFM+TduRw19URmJZN9qkgebkZ6nnra2gJPszewg?=
 =?us-ascii?Q?K3s1Xe2YnppQMparcTESdpbpEbKD+rGJ6rF7CqGwW1LZ7EfNYpzvAsl6PCCn?=
 =?us-ascii?Q?NDjAljrUAm0546VoGKnHr2az1tDY7PeLds5ghBva1mJI0MbBUN3vV2JrQq+/?=
 =?us-ascii?Q?ommwBgRrD9ilYbSdqt95Yp5xuRlt+lkRTklFvK/RtMt/AQ26+YzfLQ9g37JN?=
 =?us-ascii?Q?iIqNc2tvDGZmwq7T1r1R2KfIssmNIyG5DrpE4ywu6A7W+leSHo6eTaae8Bdt?=
 =?us-ascii?Q?26IFZCAM7ZkRh2uk1L2xHxeRmRKlZu8e4d1AivvaJdMMqFJqUu1S911y8Znd?=
 =?us-ascii?Q?pphaZB9WL0PXrNKydVHjHKTk5FH3OMvbNbxPD3/BspaXDFwaJzTdt7U6C/N0?=
 =?us-ascii?Q?g1GsYVOShUSFv7TuX+Fu/zPhkXSyunesZpoKT+H3nKNYVmwlmJVh8ktOaOFQ?=
 =?us-ascii?Q?4JvIvIRS6Jluw3tZZO1WKhRZZzmEU66BQ+U5oZUridcMXv1FrLKQXWIGrS0t?=
 =?us-ascii?Q?mcXso5T+nMNuWXHWcSd9w+05HRU7NnB/uSZhkIEAFtBGUkxEb+zMTHVx3w1q?=
 =?us-ascii?Q?T7lVrRvAQTSSgj4BUTy6U7dlPTaPC7C9OB8brcUAhEy0DqrT2nH6lkWZq61k?=
 =?us-ascii?Q?2N5OaQd2BV7bFL/k9a09KAYxI9MVjYHGM0cVbtZ8osVbZwayI7MZj0ZneMQ3?=
 =?us-ascii?Q?F1akfh8I6uDF7VUL/YdwlIy91DET3DE32z3dBvh3keamL1KDM5Ww3J9kNsM3?=
 =?us-ascii?Q?rPDOgpVU51XL8hjiVB9kKvYYYZb4cQm5b0zi58QjzhOQVg5uq3vSo2ZnE5Dt?=
 =?us-ascii?Q?sltNDCTLbQ3yFfaxg6zW4xzYRcGJuxB/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB4234.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OHrTFUVW/765AC1TFTCltYN7Nz55R29TLxtk2ulRRCQ6x20BZ8pif0NCWQdI?=
 =?us-ascii?Q?8G+7Bf3WhT4Y9xKxsOgvEuS1XT4znZmZNo9Om4S9BU5ijL/LwGJv1ZuH+rrc?=
 =?us-ascii?Q?m93VO/fj17vkfuyBvPugETihgjnZiy9Vj0jM96MyTlxrxq+vlrlF24chk80d?=
 =?us-ascii?Q?88192CMlsbdrVr3yvKe9o10MWqZMkHShVVqeTFjt9IMbIBlxaDur6HtSO2I+?=
 =?us-ascii?Q?Ik5JOZ2dMLSnCOzwvVGN73OkeE4FenbHmta50oxgKbhig42AnwKjJSZtaX5E?=
 =?us-ascii?Q?DGCq7DKBa6eZwkJyT8BMFHsfGyhGyGjKK3+Jgsr5BWPFoRwW0jOuDR9Xh6MH?=
 =?us-ascii?Q?PRrD3k5GgMJ3Rp9N9EHd4U/mX0bSmHORpi6Pxt7fQvMdnZ3MzC9GEp55v1JW?=
 =?us-ascii?Q?6qlF0advB7hdzY2bhtDIpeIEgM7aZl1niCbmRsCheqxAIpexpeka9dw+7VXS?=
 =?us-ascii?Q?a4O3bNNtSa7yLRlHHMCRYedFvGkCE+PlCZ6PXRHFE07TRiuK7zjThbgYjmVL?=
 =?us-ascii?Q?1eVng4mqgZ0pkdYnqwrGQnDZRAeDGOI3yw7t28wWQwSJPyE62ZsDOm4cOvK3?=
 =?us-ascii?Q?XIE2+qWXgiO1G/TX5FOr/bohmovSfwviIJy+IVWRSaas8GLKpu9scinClMac?=
 =?us-ascii?Q?b8qy7RXUMkUQrxRkOH/CzpXBlnqJw20ABXeo+7huDmGfO4ikfu23GV6oChPJ?=
 =?us-ascii?Q?K1TPdCY9IvrnimduyGkSm8Fwxqld3uZtdxO7W0VcSdLcwhGeF4cB7XDM/FlK?=
 =?us-ascii?Q?Nfn6qWRYTCaOcpXSjpMxiH+RPMmQZh94uDdTXwJgNpBFH1KOoEoskNByUm2M?=
 =?us-ascii?Q?XnO2EhVHJiKFJTn64NSwoIhqpIWPku1QtCglDt6IV+sfKoVtBxAXjQKlmgzk?=
 =?us-ascii?Q?PKGbKtzBOa7LqIIOne5ytBykdHVmSDjSaoKN5MCAip9sLZrOOjBfUgZf1BEL?=
 =?us-ascii?Q?+5RcV2kzOalFL7Wf3BE27PxlAR4xOvdnJ29MM3BW9ug+tEkv1dadW8gCo+MP?=
 =?us-ascii?Q?tvg74ICA4eKmIcfjq/s6W6sZ2AjVU1SStkR/5EvODeIInFE49c5QV4meZK2t?=
 =?us-ascii?Q?JDhmlxxH+eu9u3TqaAKLZu1WLsiF8hjcRacu08iHiwJaQaK1TNbahnqlHBwb?=
 =?us-ascii?Q?ZGgcinhkZcyX5zEc7VCfc0aW8ssauU8atJfp8uCkgzSp7cU7+jE7CQp17U26?=
 =?us-ascii?Q?nUEe8OSOS2PqUgkEYqjJhy5qFX/WzDtsofFoKVYqVKcbA77tSvFbCxE7Ca5U?=
 =?us-ascii?Q?qvqggeoPnIjLAlfdwZ8AiqikYKipFjJUlXlwT+jgCqo5C46ayX5XYadw5XfK?=
 =?us-ascii?Q?2YVwicbxGhG/xt+LThXbu7Lk1AyTo5L02jB9AOmOiauMwhdSg4kFI2xN1hOc?=
 =?us-ascii?Q?WeQtEqlRzQp4C7WbzqVR+/BVIYVfOUAeHEPGM89hGYv123/6duOlBuv5vY4P?=
 =?us-ascii?Q?ePKJVGSBwu10iMUdnxVuWEczX/iZh3B/OcLS6CwxZXogWf3nbIC4BxWFaS6A?=
 =?us-ascii?Q?ygFMF1rZWCDS13W/PaZXUbrESALoU2oHpN++qx2TuHoU/C1vryyUdohh9etV?=
 =?us-ascii?Q?LBnWZibPnL99s5QFslpqPJhxQ+CwYwbROA5cWzn1Alvs/AEqNhh3C6DNg1nJ?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d07d084-815d-42fd-b3b8-08dd68255537
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4234.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 03:06:11.1367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct0B9CfNKKADXNUyvL/yrUK/gzcvrdebhi9go67Hf8KJQMEoNuHUzBDnzZwf2MHt+gHTPu82Zz2jZNufZzBm7EgfyVS3ZDZbjCyPitLMP1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6882
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

*** BLURB HERE ***

Shaokai Zhang (1):
  net/af_packet: register supported param fanout mode

 drivers/net/af_packet/rte_eth_af_packet.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
V3:
*Adjust unnecessary printing to debug level.
2.47.1.windows.2

