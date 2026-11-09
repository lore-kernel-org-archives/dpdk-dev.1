Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B3606A326
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Ow5S9T4L
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6735940A76;
	Mon,  9 Nov 2026 17:09:46 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 3E06540278
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:09:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAje7FU5bynQ6liElGlvf6rHc/605rPKMe7qFIAw5F8LF0MrTfcPMdkti5AA7YguoAVsXV7ZQBuIYPZrvhzadyzoEZSJ4rePtaFqi0vkhbzaYWOFJLY2+HT8L3Jx0RLHQlUI93I4M3oV3PfZ1d0mOqtpPh7I1IYiL3WfMS1TiPI7K6VnTP9mMxT8Tzw/LCOPb7Pys43kBV47oWz8VdQtOh4BYzlRqfUEGNhlmHc0OnuFTmfXP7EHtHG5/gErleBwBcN/rnmjA4akHDKQYKnbgst5gaZxXWAIceKuC45E4Hd6MKvxXT4J+BxJDToS+KptN+2h2lwGYvcZQLz34z1u0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srycgLsOACLSIae+twLIVzHxGDCsnUxUyUxY6bVH8Bk=;
 b=PKSI2ogXGZ+QRwORRIZ12fNZd3NXHF2cGq55qhrCK5l/FedhIhkabIngiIEy/hjCmS7+q8LFN+Kpf8M9/I8UQlJCzC4AnKRlUG+UbPpYxIN3vwpc8vyHS3+baI5yo7pMAxtotRga63x6N3vdQ3qieYR2U4+mcM8zIs/x2x682L7c0Mx8/kUUIiCPrJGDlp+Epi3zWbLJDl2uKy2DwFqrmNFpikEp5leSDNoyAFIX6YUKPfBx5wNP9iyJDpqzGH3VdV1p0gStqc0qtP50T7PSccrfo3clwf0Ey51pkkCYkBbLgCwNsMVvQs1JoBcRwe8d/Q7LDS/B5NkJ2IAd7bfVjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srycgLsOACLSIae+twLIVzHxGDCsnUxUyUxY6bVH8Bk=;
 b=Ow5S9T4LVkQ5sICoYCbpPycHLcntvs20/rgu6q4pyh7WBT5jP1tH06f5vmOHtwhNNG8oq0J8AJfDaqc7w8VILDa1Nc302n7cce7hGNvBgc2157WwXMNTzGE+CnFmKRCmjTeJFbe1ZUL0Nj0tQ58+V5RjDsG6dIAAONK3qGMCGdeddx3IiDDk+xMfYWfaTLySx2VceyE50CDHPPyfriQp78EmWy9wKAAGP4PunEdwsf/GoBDgDfEcBrcbRz46sf2u3hsR7/+KH3FmU9/3TuM43anqOEDOM5xYbSfJSHwt6NCTqV3H7k96e5L3TshY/ceUOH1hf5P0u4xtzCn68iUvSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CH3PR03MB7411.namprd03.prod.outlook.com (2603:10b6:610:197::16)
 by DS1PR03MB7942.namprd03.prod.outlook.com (2603:10b6:8:222::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 16:09:40 +0000
Received: from CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088]) by CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 16:09:38 +0000
From: "Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>
To: dev@dpdk.org
Cc: ferruh.yigit@intel.com, stephen@networkplumber.org, rtice@cisco.com,
 cheryl.bansal@altera.com, nanditha.jayarajan@altera.com,
 "Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>
Subject: [RFC 1/4] net/mcdma: add Altera MCDMA poll mode driver skeleton
Date: Tue, 10 Nov 2026 00:09:23 +0800
Message-Id: <20261109160926.800828-2-subhransu.sekhar.prusty@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
References: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To CH3PR03MB7411.namprd03.prod.outlook.com
 (2603:10b6:610:197::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR03MB7411:EE_|DS1PR03MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 77416832-960e-4002-2812-08df3e7bda5c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|261021130227099003|261021135927099003|56012099006|261021121427099003|261022113327099003|261022075727099003|261022105027099003|261021123027099003|261026130827099003|261009223027099003|261026135527099003|261022115727099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|10067099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 7ODnT2lGBOH2xpg76/z99ulsP9DtsdCGt5+/Zi7IBEITlAOuhi61mElJmDiFfG7LxvSKWtxfQOrhEhCG4MvRTqM1VLMOue8iIJgv8GISWQXMyzwOcsj9VyK4Io5DtF6EYz86CJIVfyzAyi3tl4foXOzcS7+7EV0mih2or23C3ngCV+iMN7ycv6Pd1S8Aw1JuApwxMkKmH6gSfQdAql4DOZuIq/NPtwbwDA2WOFpkb14Qgn6hojw79/E5JOdFzvcuV6k7l5hnX9CvAMLV/yc0hXj9uMDD5/zb6vumWilrh2F1crHm0X1VnXT8QcXK/ptJ4goCfaAfDyVppIRUMGKejS7QZgiJ98aurrMz9aDesFjJ2oJmplUF6yJ+6uNTSL0ilqqsMsj74TgGnWRelUyB38YEaqxzZPel4bHlho80hvVRiYfl8/YZPOejEQVZfaJOoWFMJftY5UVsVxNs6HX9L15Mc13c8IvRWK/MiUBxy25AgImTpHmULCg53789BNv67yHheTwzabEKNmJU5SgY4Ua7++r6Lt/w/Ww1/HbFcCh/NbsYPgIHLYCTPiy1m6Fh4DcbHq/xaLHMlH40H4YU9yzwLy6ya5skE8TmH/iA2fLerK8eMxh0+5odxKHCDu2JnfqnpglRflu052aLfQhpZRCq+WcBQDK7gLFXtVVVvJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR03MB7411.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(261021130227099003)(261021135927099003)(56012099006)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026130827099003)(261009223027099003)(261026135527099003)(261022115727099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S01jQVpaam8xd0JTT2FkU0QyOEVHeVdjT0c3VHJkbDI1cXVIcXF5cjRpN1Vn?=
 =?utf-8?B?K2U2cERoZDA2cTBaTGd0a1pMN3BXRWtrVEMwdDh1cm4ydWZrb1NQUjdEMFhD?=
 =?utf-8?B?RGVHMG5ENlQveUdLQ21jNXZLTUd5dTJPZjlRUERtampPbW82MmRtTGRhSUtn?=
 =?utf-8?B?c0IvWEoyRXVya2dTV2dNZzdiNzFNTmZqUHFuMmw2K0kzZ2crRE0vNVN4R0Qw?=
 =?utf-8?B?dVM5T1hubDJIeEIxWXR1RE1JT0VuM0NZWXVrbHJyU2h3MDJ4OU41eklhN1g4?=
 =?utf-8?B?LzRoSURpNm9kV1ZVOVdOMlVlSHRheGRDVE92cElsRUNKUURxVVFnQ0plcGZx?=
 =?utf-8?B?Z05QZVF0NWpBZWI2bWxHM3VJY2hhNkJVSmNMZExid29GWktVOEMvVnhUWkZl?=
 =?utf-8?B?MlhBUC9hOUV2eWliN1d6TzZQVHdVUDBOSkpvSlRwQm53dk1zL0JER1NpK3cr?=
 =?utf-8?B?WTFVSDZWaEYyMnlEanFZdGZ6RVcyd2F0NjhtVFlKdXNTR1owWWdOZzhIek9M?=
 =?utf-8?B?UkRDZUFjVHZMcWRiN3M3MzhRV2hjbUc2ZmQ4UHEyUmIybGZJZFRtQ2F0Mkg5?=
 =?utf-8?B?NDJ6dDZlcmtkVTFaNWJWMzVWUnFMdVd4Y1U5MHhldzhDL3RrTVlsSjV2NGpX?=
 =?utf-8?B?UDQ5WUZpaWhJZWVhVitMUnNycXVPaXBTMXo4Uk1heGd2cnIzQTN3bVVBSkJU?=
 =?utf-8?B?a2RnUUlxY3dVYUx0NmQwRms1WmNHaGtVNGh6eGVxeENqeUUxMThURHh2UXZ2?=
 =?utf-8?B?MHh6OE9IWXV4dzhuZGZjVXJZZ1pzM0xHeHN5NXRHUzMwcHMxTUk1NUhLSEZT?=
 =?utf-8?B?ZE1YL2h4cSs3MXVCU0xZcTFXT2NXYy9WbTdzT1FPRjlqbTc5aDlsbWVqWUVO?=
 =?utf-8?B?SG5UNDQ2OGlLc0xTanE2RVlYVUNGQ2pGTWM1dXRncUhMMnIvaXlLaVQvYmNY?=
 =?utf-8?B?U1ltYy9INkJUMll0ZzlDZjlNc3A5dXRhMW5QbmhFdTB6S2JKaFJXcmFuUkJ0?=
 =?utf-8?B?Y2NNQXlYSUNVa1E1YlBoSDNtb0gzVUsyRXpYWWNVRUUwTnB6M2ZFZmtZc3Ux?=
 =?utf-8?B?ZFBZUE9HamhpUEJtcGpzNTAxcE9tSElBRXJQNTg5WjdmaWtIa2hDZWFEeG1j?=
 =?utf-8?B?YmFvWkxqRmRZejgxMUtNQmQ5ZEY3SkE2VlJkM0MvOUdzajhNUmdXNTIzZ2sy?=
 =?utf-8?B?ZWhGR3kxY0w3VnJiNjlxWVRxKzQxaUVXOThBYkVlVnJSenlQUkc2bjFydDZG?=
 =?utf-8?B?UGJ2ekhWaDRSamx1QTM2WkJvenMydzBmc2dzNGU2blB2Y1pMSWo1bm04SWlv?=
 =?utf-8?B?d2x1VlNuMVNIOUswOXUrczBCYXF0Nzh1TGc5amR4K1ppNEhsSko5elUzaUdv?=
 =?utf-8?B?UVNDckRJRHRudnhUay9DYUY0OVVuaXJ1V1k0cE9xVUd3NXZ5eHFoSmF4b0JG?=
 =?utf-8?B?S1hsQ1JRNk1Yc3FSS24wSmlLWUxHSW9FSHpYaU5uNkhaV3p4SFplL3JWdWlu?=
 =?utf-8?B?Y21CVUMrZWZaVTNUR2psUmdUUVprMXZrQnBpWEp0OUdXdWpXUzdMazRSd21I?=
 =?utf-8?B?K01qVUdwRWpORnF0Y3VtWGdQM1luL0EvdTJOOWJpQ2pUT2JJTUJmOTJxMU9n?=
 =?utf-8?B?ZG9va0pkbXhreU1ldG1hQVRPRjBwbldxRDgvanhiLzIyUXFzalBpc3A5OVdh?=
 =?utf-8?B?OUV5ei9pNFRFd1FoY1F1YnlyUTdza250NDdQNm93cEp6RzFzZ1NzOS9MclFs?=
 =?utf-8?B?VVdJVjFxVkgwUmVoY3lDNWFOU0xlQnlVV0c1YXZTTFE0TndvWU9hMWxRclJt?=
 =?utf-8?B?QnFEdjVOSkFVcXI4dkVFOTlSNWs1ekNKZG4za0dmeU1yZ1RPcnpqcXZrVTd6?=
 =?utf-8?B?a1RZUXoxdWFJU0RPYUhuUlRmdDVuS2gxNFBTV0RZTTIwNTRscm1nYTE3NzhG?=
 =?utf-8?B?Y25BaHhQUWJYZFdiMTF1OUE1OVNoODJaeVBkNkc4YWRReTFya0FNT2UwMDZD?=
 =?utf-8?B?bVZIOXNGMVBrVGRvZUc0RytoK3JIOTIvK3FlZGkyVnMvOThKcm1udytMRHY3?=
 =?utf-8?B?cWh5VHdRODRSSU9QZ29NTmF2a0VmYXp3WGw5VzFpNkkrWXgwdFF4TkNuYU91?=
 =?utf-8?B?MHdLUHJrTmlWT3h1bWhyaFMvazR0Rm1ZMElUTUlXMXczVk1tL2JvZFZKeHlR?=
 =?utf-8?B?Z1dGaG5QVGV1dTVUWXRUWlRFQlJoWHlOYVI1OHJBaHkzSGNRaXExUEFMbU5v?=
 =?utf-8?B?ZDQ1TUNFQzJkMEFqK01Qem9pK1VjUDhlRklUc05VN1YxTmRDT05TQ0Qxc3pI?=
 =?utf-8?B?ZzFQakU5NldrTmdQR1A0ejYrcVE5Z3NobUYyQ3I4bjNPd0g3RHFtOERWN2hO?=
 =?utf-8?Q?A7trP4nlvxXf1a2zMJvYZTkMDb3VffBb9harX?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77416832-960e-4002-2812-08df3e7bda5c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR03MB7411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:09:38.7597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSE57i405TwsXE5Zsi4eqdhK82U8GGqr7sIsGlx0fLOhOMP8QG3KVjhIzbQ4V1KRWuze4MxOrfH0FrcC12N2eLur1kS8vcRLhFGm3cbNLHQxZ1nGwJiut3Gp3gd+KGM7
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the initial poll mode driver for Altera Multi-Channel Direct Memory
Access (MCDMA). The PMD registers with the ethdev layer, maps
configuration (and optional PIO) BARs, parses PF/VF devargs, and
implements port configuration, Rx/Tx queue setup and start/stop,
link status, MTU, and statistics.

Introduce DMA CSR and QCSR register definitions, device- and queue-level
private data structures, and driver documentation with the features matrix.

Packet burst handlers and experimental APIs to access user logic and
debug dump are added in follow-up patches.

Co-developed-by: Cheryl Bansal <cheryl.bansal@altera.com>
Signed-off-by: Cheryl Bansal <cheryl.bansal@altera.com>
Signed-off-by: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
---
 MAINTAINERS                                 |   4 +
 doc/guides/nics/features/mcdma.ini          |  17 +
 doc/guides/nics/index.rst                   |   1 +
 doc/guides/nics/mcdma.rst                   | 128 +++
 drivers/net/altera/mcdma/mcdma_config_csr.h | 201 +++++
 drivers/net/altera/mcdma/mcdma_eth.c        | 323 +++++++
 drivers/net/altera/mcdma/mcdma_eth.h        | 333 +++++++
 drivers/net/altera/mcdma/mcdma_eth_ops.c    | 931 ++++++++++++++++++++
 drivers/net/altera/mcdma/meson.build        |  12 +
 drivers/net/meson.build                     |   1 +
 usertools/dpdk-devbind.py                   |   1 +
 11 files changed, 1952 insertions(+)
 create mode 100644 doc/guides/nics/features/mcdma.ini
 create mode 100644 doc/guides/nics/mcdma.rst
 create mode 100644 drivers/net/altera/mcdma/mcdma_config_csr.h
 create mode 100644 drivers/net/altera/mcdma/mcdma_eth.c
 create mode 100644 drivers/net/altera/mcdma/mcdma_eth.h
 create mode 100644 drivers/net/altera/mcdma/mcdma_eth_ops.c
 create mode 100644 drivers/net/altera/mcdma/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d865ffd4670..9298ea085ec8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1166,6 +1166,10 @@ F: doc/guides/nics/memif.rst
 F: doc/guides/nics/features/memif.ini
 F: app/test/test_pmd_memif.c
 
+Altera MCDMA PMD
+M: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
+M: Cheryl Bansal <cheryl.bansal@altera.com>
+F: drivers/net/altera/mcdma/
 
 Crypto Drivers
 --------------
diff --git a/doc/guides/nics/features/mcdma.ini b/doc/guides/nics/features/mcdma.ini
new file mode 100644
index 000000000000..08435fb2fce3
--- /dev/null
+++ b/doc/guides/nics/features/mcdma.ini
@@ -0,0 +1,17 @@
+;
+; Supported features of the 'mcdma' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Link status          = P
+Queue start/stop     = Y
+Runtime Rx queue setup = Y
+Runtime Tx queue setup = Y
+MTU update           = Y
+Basic stats          = Y
+Stats per queue      = Y
+Multiprocess aware   = Y
+Linux                = Y
+x86-64               = Y
+Usage doc            = Y
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index e20be478f837..8bb3f490178f 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -47,6 +47,7 @@ Network Interface Controller Drivers
     ixgbe
     mana
     memif
+    mcdma
     mlx4
     mlx5
     mvneta
diff --git a/doc/guides/nics/mcdma.rst b/doc/guides/nics/mcdma.rst
new file mode 100644
index 000000000000..e31fac2efe71
--- /dev/null
+++ b/doc/guides/nics/mcdma.rst
@@ -0,0 +1,128 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2020-2026 Altera Corporation
+
+MCDMA Poll Mode Driver
+======================
+
+The MCDMA PMD (**librte_net_mcdma**) provides poll-mode driver support for
+Altera Multi-Channel Direct Memory Access (MCDMA) PCI devices. The driver
+exposes host-to-device (H2D) and device-to-host (D2H) descriptor queues as
+standard DPDK Ethernet ports and is intended for custom FPGA datapaths where
+packet movement is controlled through descriptor rings and queue control/status
+registers (QCSR).
+
+The PMD binds to Altera PCI functions (vendor ID ``0x1172``) and maps the
+configuration BAR for DMA CSR access. A PIO BAR is optionally mapped for
+application-specific control registers in user logic.
+
+Prerequisites
+-------------
+
+Follow the DPDK :doc:`/linux_gsg/index` to set up the basic DPDK environment.
+
+The device must be bound to a DPDK-compatible kernel driver such as
+``vfio-pci`` or ``igb_uio``.
+
+.. note::
+
+   The MCDMA PMD is supported on Linux only.
+
+Device parameters
+-----------------
+
+Device parameters are passed through the EAL ``-a`` allowlist, for example::
+
+   -a 0000:03:00.0,pf_index=0
+
+pf_index
+   Physical function index (0–7). When set, the port is treated as a PF and
+   PF-only parameters below become available.
+
+parent_pf_idx
+   Parent PF index for a virtual function. Required when probing a VF to locate
+   channel capacity in the PF configuration registers.
+
+config_bam_bar
+   PCI BAR index used for the BAM (bus address mapper) region on a PF. Valid
+   values are BAR indices other than the configuration BAR (BAR 0).
+
+vf_weights
+   Comma-separated list of 16 VF scheduler weights (1–8). Each weight is
+   programmed into the DMA CSR VF weight registers.
+
+Queue model
+-----------
+
+Each Ethernet port corresponds to one PCI function (PF or VF). The number of
+Rx and Tx queues available is reported through ``rte_eth_dev_info`` and
+depends on the IP configuration (up to 512 channels per function).
+
+For each queue the driver allocates:
+
+* A hardware descriptor ring in IOVA-contiguous memory (memzone).
+* A software ring tracking in-flight ``rte_mbuf`` pointers.
+
+Descriptor ring size must be a power of two and a multiple of 128 (4096-byte
+pages with 32-byte descriptors). The hardware supports up to 65536 descriptors
+per ring; the driver accepts at most 32768 (``rte_eth_dev_info`` and queue
+setup limits).
+
+H2D queues are used for Tx (``rte_eth_tx_burst()``) and D2H queues for Rx
+(``rte_eth_rx_burst()``). Multi-segment mbufs are supported on Tx when
+``RTE_ETH_TX_OFFLOAD_MULTI_SEGS`` is enabled. Rx delivers one mbuf per
+completed packet; the driver uses an mbuf dynamic field to track
+start-of-frame and end-of-frame descriptor flags internally.
+
+Queues can be started and stopped independently, and Rx/Tx queue setup is
+supported while the device is running
+(``RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP`` and
+``RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP``).
+
+Link and statistics
+-------------------
+
+Link status is only partially supported. ``link_update`` always reports the
+port as up and full duplex; there is no carrier detection, link-down state,
+or link speed reporting. Applications can call ``rte_eth_link_get()``, but the
+returned values are fixed stubs rather than hardware link state.
+
+Port and per-queue statistics are maintained in software and augmented with
+hardware drop and pointer-error counters read from QCSR. Use
+``rte_eth_stats_get()`` to retrieve them.
+
+Limitations
+-----------
+
+The MCDMA PMD is a DMA channel driver rather than a full Ethernet NIC PMD.
+The following standard ethdev features are not implemented:
+
+* MAC address programming, promiscuous mode, and multicast filtering.
+* RSS, ``rte_flow``, and interrupt-driven Rx/Tx.
+* Checksum, TSO, VLAN, and other L2/L3 hardware offloads.
+* ``stats_reset`` and extended statistics (xstats).
+
+Traffic acceptance and any Ethernet semantics beyond descriptor DMA are
+defined by the FPGA application connected to the MCDMA IP.
+
+Building and testing
+--------------------
+
+Refer to :doc:`build_and_test` for general PMD build instructions. Enable the
+driver in the Meson build (``-Denable_drivers=net/mcdma`` or a full default
+driver build).
+
+The driver has been tested with `DPDK pktgen <https://github.com/pktgen/Pktgen-DPDK>`_.
+It has not been tested with testpmd.
+
+Example: pktgen on a bound MCDMA device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Bind the PCI function and start pktgen with one port mapped to a logical core::
+
+   # ./pktgen -l 0-1 -n 4 -a 0000:03:00.0 -- -P -m 1.0
+
+Use the pktgen interactive commands to configure packet size, rate, and
+forwarding. Port statistics are shown in the pktgen UI.
+
+For PF-specific setup (VF weights, BAM BAR), add the corresponding allowlist
+options to the EAL command line.
diff --git a/drivers/net/altera/mcdma/mcdma_config_csr.h b/drivers/net/altera/mcdma/mcdma_config_csr.h
new file mode 100644
index 000000000000..a7cb27e85f2f
--- /dev/null
+++ b/drivers/net/altera/mcdma/mcdma_config_csr.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2020-2026 Altera Corporation
+ */
+#ifndef __MCDMA_CONFIG_CSR_H_
+#define __MCDMA_CONFIG_CSR_H_
+
+#include <rte_bitops.h>
+
+typedef enum {
+	MCDMA_QCSR_Q_CTRL			= 0x00U,
+	/* QCSR_Reserved		= 0x04U, */
+	MCDMA_QCSR_Q_START_ADDR_L		= 0x08U,
+	MCDMA_QCSR_Q_START_ADDR_H		= 0x0CU,
+	MCDMA_QCSR_Q_SIZE			= 0x10U,
+	MCDMA_QCSR_Q_TAIL_POINTER		= 0x14U,
+	MCDMA_QCSR_Q_HEAD_POINTER		= 0x18U,
+	MCDMA_QCSR_Q_COMPLETED_POINTER		= 0x1CU,
+	MCDMA_QCSR_Q_CONSUMED_HEAD_ADDR_L	= 0x20U,
+	MCDMA_QCSR_Q_CONSUMED_HEAD_ADDR_H	= 0x24U,
+	MCDMA_QCSR_Q_BATCH_DELAY		= 0x28U,
+	MCDMA_QCSR_Q_DEBUG_STATUS_1		= 0x38U,
+	MCDMA_QCSR_Q_DEBUG_STATUS_2		= 0x3CU,
+	MCDMA_QCSR_Q_DATA_DRP_ERR_CTR		= 0x40U,
+	MCDMA_QCSR_Q_PAYLOAD_COUNT		= 0x44U,
+	MCDMA_QCSR_Q_RESET			= 0x48U,
+	MCDMA_QCSR_Q_CPL_TIMEOUT		= 0x4CU,
+	MCDMA_QCSR_Q_REG_MAX			= 0xFFFFFFFFU
+} mcdma_qcsr_reg_offset_t;
+
+#define MCDMA_QCSR_Q(reg)			MCDMA_QCSR_Q##_##reg
+#define MCDMA_QCSR_Q_RESET_MASK			RTE_GENMASK32(0, 0)
+#define MCDMA_QCSR_Q_RESET_SHIFT		0
+
+/* Q_DATA_DRP_ERR_CTR: valid in bit 20, drop count in bits [15:0] */
+#define MCDMA_QCSR_DRP_CTR_VALID		RTE_BIT32(20)
+#define MCDMA_QCSR_DRP_CTR_CNT_MASK		RTE_GENMASK32(15, 0)
+#define MCDMA_QCSR_DRP_CTR_CLR_MASK		(MCDMA_QCSR_DRP_CTR_VALID | \
+						 MCDMA_QCSR_DRP_CTR_CNT_MASK)
+/* Error sticky bit in head / completed pointer registers */
+#define MCDMA_QCSR_PTR_ERR_MASK			RTE_BIT32(24)
+
+typedef union {
+	struct {
+		/*
+		 * Enable. Once it is enabled, the DMA starts fetching pending
+		 * descriptors and executing them.
+		 */
+		uint32_t q_en : 1;
+		uint32_t rsv : 7;       /* Reserved. */
+		uint32_t q_wb_en : 1;   /* If set, upon completion, do a write back. */
+		uint32_t q_intr_en : 1; /* If set, upon completion generate MSI-X interrupt. */
+		uint32_t rsvd : 22;     /* Reserved. */
+	} field;
+	uint32_t val;
+} mcdma_qcsr_q_ctrl_t;
+
+/*
+ * The following "read only" registers are available for all functions, not only PF0:
+ * VER_NUM (offset 9'h070)
+ * P0_<H2D, D2H>_TPTR_AVL (offset 9'h100, 110)
+ * PF<0,1,2,3,4,5,6,7>_PARAM_2 (Offset 9'h084, 094, 0A4, 0B4, 0C4, 0D4, 0E4, 0F4)
+ */
+typedef enum {
+	MCDMA_CSR_CTRL			= 0x000U,
+	/* Reserved: 0x004          */
+	MCDMA_CSR_WB_INTR_DELAY		= 0x008U,
+	/* Reserved: 0x00C - 0x01F  */
+	/* VF Weight registers */
+	MCDMA_CSR_VF_WEIGHT_0		= 0x020U,
+	MCDMA_CSR_VF_WEIGHT_1		= 0x024U,
+	MCDMA_CSR_VF_WEIGHT_2		= 0x028U,
+	MCDMA_CSR_VF_WEIGHT_3		= 0x02CU,
+	/* Reserved: 0x030 - 0x06F  */
+
+	/* Version / IP params */
+	MCDMA_CSR_VER_NUM		= 0x070U,
+	MCDMA_CSR_IP_PARAM_1		= 0x074U,
+
+	/* PF IP PARAM */
+	MCDMA_CSR_PF0_IP_PARAM_1	= 0x080U,
+	MCDMA_CSR_PF0_IP_PARAM_2	= 0x084U,
+	/* Reserved: 0x088 - 0x08F  */
+	MCDMA_CSR_PF1_IP_PARAM_1	= 0x090U,
+	MCDMA_CSR_PF1_IP_PARAM_2	= 0x094U,
+	/* Reserved: 0x098 - 0x09F  */
+	MCDMA_CSR_PF2_IP_PARAM_1	= 0x0A0U,
+	MCDMA_CSR_PF2_IP_PARAM_2	= 0x0A4U,
+	/* Reserved: 0x0A8 - 0x0AF  */
+	MCDMA_CSR_PF3_IP_PARAM_1	= 0x0B0U,
+	MCDMA_CSR_PF3_IP_PARAM_2	= 0x0B4U,
+	/* Reserved: 0x0B8 - 0x0BF  */
+	MCDMA_CSR_PF4_IP_PARAM_1	= 0x0C0U,
+	MCDMA_CSR_PF4_IP_PARAM_2	= 0x0C4U,
+	/* Reserved: 0x0C8 - 0x0CF  */
+	MCDMA_CSR_PF5_IP_PARAM_1	= 0x0D0U,
+	MCDMA_CSR_PF5_IP_PARAM_2	= 0x0D4U,
+	/* Reserved: 0x0D8 - 0x0DF  */
+	MCDMA_CSR_PF6_IP_PARAM_1	= 0x0E0U,
+	MCDMA_CSR_PF6_IP_PARAM_2	= 0x0E4U,
+	/* Reserved: 0x0E8 - 0x0EF  */
+	MCDMA_CSR_PF7_IP_PARAM_1	= 0x0F0U,
+	MCDMA_CSR_PF7_IP_PARAM_2	= 0x0F4U,
+	/* Reserved: 0x0F8 - 0x0FF  */
+
+	/* Port H2D tail pointers */
+	MCDMA_CSR_P0_H2D_TPTR_AVL	= 0x100U,
+	MCDMA_CSR_P1_H2D_TPTR_AVL	= 0x104U,
+	MCDMA_CSR_P2_H2D_TPTR_AVL	= 0x108U,
+	MCDMA_CSR_P3_H2D_TPTR_AVL	= 0x10CU,
+
+	/* Port D2H tail pointers */
+	MCDMA_CSR_P0_D2H_TPTR_AVL	= 0x110U,
+	MCDMA_CSR_P1_D2H_TPTR_AVL	= 0x114U,
+	MCDMA_CSR_P2_D2H_TPTR_AVL	= 0x118U,
+	MCDMA_CSR_P3_D2H_TPTR_AVL	= 0x11CU,
+
+	/* Misc */
+	MCDMA_CSR_SW_RESET		= 0x120U,
+	/* Reserved: 0x125 - 0x127  */
+	MCDMA_CSR_MSIX_WB_FIFO_STS	= 0x128U,
+	/* Reserved: 0x12C - 0x14F  */
+
+	/* Debug bank 1 */
+	MCDMA_CSR_DBG1_REG00		= 0x150U,
+	MCDMA_CSR_DBG1_REG01		= 0x154U,
+	MCDMA_CSR_DBG1_REG02		= 0x158U,
+	MCDMA_CSR_DBG1_REG03		= 0x15CU,
+	MCDMA_CSR_DBG1_REG04		= 0x160U,
+	MCDMA_CSR_DBG1_REG05		= 0x164U,
+	MCDMA_CSR_DBG1_REG06		= 0x168U,
+	MCDMA_CSR_DBG1_REG07		= 0x16CU,
+	MCDMA_CSR_DBG1_REG08		= 0x170U,
+	MCDMA_CSR_DBG1_REG09		= 0x174U,
+	MCDMA_CSR_DBG1_REG10		= 0x178U,
+	MCDMA_CSR_DBG1_REG11		= 0x17CU,
+	MCDMA_CSR_DBG1_REG12		= 0x180U,
+	MCDMA_CSR_DBG1_REG13		= 0x184U,
+	MCDMA_CSR_DBG1_REG14		= 0x188U,
+	MCDMA_CSR_DBG1_REG15		= 0x18CU,
+
+	/* Debug bank 2 */
+	MCDMA_CSR_DBG2_REG00		= 0x190U,
+	MCDMA_CSR_DBG2_REG01		= 0x194U,
+	MCDMA_CSR_DBG2_REG02		= 0x198U,
+	MCDMA_CSR_DBG2_REG03		= 0x19CU,
+	MCDMA_CSR_DBG2_REG04		= 0x1A0U,
+	MCDMA_CSR_DBG2_REG05		= 0x1A4U,
+	MCDMA_CSR_DBG2_REG06		= 0x1A8U,
+	MCDMA_CSR_DBG2_REG07		= 0x1ACU,
+	MCDMA_CSR_DBG2_REG08		= 0x1B0U,
+	MCDMA_CSR_DBG2_REG09		= 0x1B4U,
+	MCDMA_CSR_DBG2_REG10		= 0x1B8U,
+	MCDMA_CSR_DBG2_REG11		= 0x1BCU,
+	MCDMA_CSR_DBG2_REG12		= 0x1C0U,
+	MCDMA_CSR_DBG2_REG13		= 0x1C4U,
+	MCDMA_CSR_DBG2_REG14		= 0x1C8U,
+	MCDMA_CSR_DBG2_REG15		= 0x1CCU,
+
+	MCDMA_CSR_OFFSET_MAX		= 0xFFFFFFFFU   /* force 32-bit backing */
+} mcdma_csr_offset_t;
+
+#define MCDMA_CSR_PF_PARAM_STEP		0x10
+#define MCDMA_CSR_PF_PARAM2_OFFSET(pf) \
+	(MCDMA_CSR_PF0_IP_PARAM_2 + ((pf) * MCDMA_CSR_PF_PARAM_STEP))
+
+/* NUM_DMA_CHAN_PER_PF : bits [31:16] */
+#define MCDMA_NUM_CHAN_PER_PF_SHIFT	16U
+#define MCDMA_NUM_CHAN_PER_PF_MASK	(0xFFFFU << MCDMA_NUM_CHAN_PER_PF_SHIFT)
+
+/* NUM_DMA_CHAN_PER_VF : bits [15:0] */
+#define MCDMA_NUM_CHAN_PER_VF_SHIFT	0U
+#define MCDMA_NUM_CHAN_PER_VF_MASK	RTE_GENMASK32(15, 0)
+
+#define MCDMA_GET_NUM_CHAN_PER_PF(reg_val) \
+	(((reg_val) & MCDMA_NUM_CHAN_PER_PF_MASK) >> MCDMA_NUM_CHAN_PER_PF_SHIFT)
+
+#define MCDMA_GET_NUM_CHAN_PER_VF(reg_val) \
+	(((reg_val) & MCDMA_NUM_CHAN_PER_VF_MASK) >> MCDMA_NUM_CHAN_PER_VF_SHIFT)
+
+static inline uint32_t mcdma_reg_readl(volatile void *addr)
+{
+	return *(volatile uint32_t *)addr;
+}
+
+static inline void mcdma_reg_writel(volatile void *addr, uint32_t value)
+{
+	*(volatile uint32_t *)addr = value;
+}
+
+static inline void mcdma_reg_updatel(volatile void *base, uint32_t offset,
+				     uint32_t value, uint32_t shift, uint32_t mask)
+{
+	volatile void *addr = (volatile uint8_t *)base + offset;
+	uint32_t tmp;
+
+	tmp = mcdma_reg_readl(addr);
+	tmp = (tmp & ~mask) | ((value << shift) & mask);
+	mcdma_reg_writel(addr, tmp);
+}
+
+#endif /* __MCDMA_CONFIG_CSR_H_ */
diff --git a/drivers/net/altera/mcdma/mcdma_eth.c b/drivers/net/altera/mcdma/mcdma_eth.c
new file mode 100644
index 000000000000..003b7c0e7d72
--- /dev/null
+++ b/drivers/net/altera/mcdma/mcdma_eth.c
@@ -0,0 +1,323 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2020-2026 Altera Corporation
+ */
+
+#include <stdlib.h>
+#include <string.h>
+
+#include <ethdev_pci.h>
+#include <rte_kvargs.h>
+
+#include "mcdma_eth.h"
+
+RTE_LOG_REGISTER_SUFFIX(mcdma_logtype_driver, driver, NOTICE);
+
+size_t config_csr_offsets[MCDMA_MAX_CONFIGS] = {
+	0, 0x100000, 0x200000, 0x300000, 0x380000,
+};
+
+void *mcdma_get_csraddr(void *base, unsigned int idx)
+{
+	if (idx >= MCDMA_MAX_CONFIGS)
+		return NULL;
+
+	return (uint8_t *)base + config_csr_offsets[idx];
+}
+
+#define MCDMA_ARGS_CFG_BAM_BAR		"config_bam_bar"
+#define MCDMA_ARGS_VF_WEIGHTS		"vf_weights"
+#define MCDMA_ARGS_PF_IDX		"pf_index"
+#define MCDMA_ARGS_PARENT_PF_IDX	"parent_pf_idx"
+
+#define NUM_VF_WEIGHT			16
+#define VF_WEIGHT_LO			1
+#define VF_WEIGHT_HI			8
+
+static const char *const mcdma_kvargs_keys[] = {
+	MCDMA_ARGS_CFG_BAM_BAR,
+	MCDMA_ARGS_VF_WEIGHTS,
+	MCDMA_ARGS_PF_IDX,
+	MCDMA_ARGS_PARENT_PF_IDX,
+	NULL,
+};
+
+static int vf_weight_parse_handler(__rte_unused const char *key,
+				   const char *value, void *data)
+{
+	int *weights = data;
+	char *token, *str, *tofree;
+	int i = 0;
+
+	str = strdup(value);
+	tofree = str;
+	if (!str) {
+		PMD_DRV_LOG(ERR, "failed to parse vf_weights: out of memory");
+		return -ENOMEM;
+	}
+
+	while ((token = strsep(&str, ",")) != NULL) {
+		uint8_t weight_val = atoi(token);
+		if (weight_val < VF_WEIGHT_LO || weight_val > VF_WEIGHT_HI) {
+			PMD_DRV_LOG(WARNING,
+				    "weight value not in range; defaulting to %d",
+				    VF_WEIGHT_LO);
+			weight_val = VF_WEIGHT_LO;
+		}
+
+		if (i >= NUM_VF_WEIGHT) {
+			free(tofree);
+			PMD_DRV_LOG(ERR, "vf_weights expects %d values, got more",
+				    NUM_VF_WEIGHT);
+			return -EINVAL;
+		}
+
+		weights[i++] = weight_val;
+	}
+
+	free(tofree);
+
+	if (i != NUM_VF_WEIGHT) {
+		PMD_DRV_LOG(ERR, "vf_weights expects %d values, got %d",
+			    NUM_VF_WEIGHT, i);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int id_parse_handler(__rte_unused const char *key,
+			    const char *value, void *data)
+{
+	unsigned long val;
+	char *end = NULL;
+
+	val = strtoul(value, &end, 10);
+	if (end == value || val > UINT8_MAX)
+		return -EINVAL;
+
+	*(uint8_t *)data = (uint8_t)val;
+	return 0;
+}
+
+static int bar_idx_parse_handler(__rte_unused const char *key,
+				 const char *value, void *data)
+{
+	unsigned long val;
+	char *end = NULL;
+
+	val = strtoul(value, &end, 10);
+	if (end == value || val >= MCDMA_BAR_MAX)
+		return -EINVAL;
+
+	*(int *)data = (int)val;
+	return 0;
+}
+
+#define MCDMA_BAM_BAR_KEY_IDX		0
+#define MCDMA_VF_WEIGHT_KEY_IDX		1
+#define MCDMA_PF_IDX			2
+#define MCDMA_PARENT_PF_IDX		3
+
+static int mcmda_parse_args(struct mcdma_pci_device *priv,
+			    struct rte_pci_device *pci_dev)
+{
+	struct rte_devargs *devargs = priv->dev->device->devargs;
+	struct rte_kvargs *kvlist;
+	int bam_bar_idx = 0;
+	int ret;
+
+	if (!devargs)
+		return -EINVAL;
+
+	kvlist = rte_kvargs_parse(devargs->args, mcdma_kvargs_keys);
+	if (!kvlist)
+		return 0;
+
+	priv->is_pf = false;
+
+	/* Process pf_idx */
+	if (rte_kvargs_count(kvlist, mcdma_kvargs_keys[MCDMA_PF_IDX])) {
+		ret = rte_kvargs_process(kvlist, mcdma_kvargs_keys[MCDMA_PF_IDX],
+					 id_parse_handler, &priv->pf_idx);
+		if (ret) {
+			PMD_DRV_LOG(WARNING, "PF index parse failed");
+			rte_kvargs_free(kvlist);
+			return ret;
+		}
+
+		if (priv->pf_idx >= MCDMA_MAX_PF) {
+			PMD_DRV_LOG(ERR, "Invalid PF index: %u", priv->pf_idx);
+			rte_kvargs_free(kvlist);
+			return -EINVAL;
+		}
+
+		priv->is_pf = true;
+	}
+
+	if (priv->is_pf) {
+		/* Process weight priority for VFs */
+		if (rte_kvargs_count(kvlist, mcdma_kvargs_keys[MCDMA_VF_WEIGHT_KEY_IDX])) {
+			int vf_weights[NUM_VF_WEIGHT];
+			int i;
+
+			ret = rte_kvargs_process(kvlist,
+					mcdma_kvargs_keys[MCDMA_VF_WEIGHT_KEY_IDX],
+					vf_weight_parse_handler, vf_weights);
+			if (ret) {
+				rte_kvargs_free(kvlist);
+				return ret;
+			}
+
+			/* Program vf weights */
+			for (i = 0; i < NUM_VF_WEIGHT; i++) {
+				/* 4 vf weight configuration in 1 register */
+				mcdma_csr_offset_t offset = MCDMA_CSR_VF_WEIGHT_0 + 4 * (i / 4);
+				uint32_t shift = 8 * (unsigned int)(i % 4);
+				uint32_t mask = 0xFFu << shift;
+
+				mcdma_dmacsr_reg_updatel(priv->bar_base, offset,
+							 vf_weights[i], shift, mask);
+			}
+		}
+
+		/* Process BAM_bar index */
+		if (rte_kvargs_count(kvlist, mcdma_kvargs_keys[MCDMA_BAM_BAR_KEY_IDX])) {
+			ret = rte_kvargs_process(kvlist,
+					mcdma_kvargs_keys[MCDMA_BAM_BAR_KEY_IDX],
+					bar_idx_parse_handler, &bam_bar_idx);
+			if (ret) {
+				PMD_DRV_LOG(WARNING, "BAM BAR index parse failed");
+				rte_kvargs_free(kvlist);
+				return ret;
+			}
+
+			if (bam_bar_idx <= MCDMA_CONFIG_BAR ||
+			    bam_bar_idx >= MCDMA_BAR_MAX) {
+				PMD_DRV_LOG(ERR, "BAM BAR index not valid: %d",
+					    bam_bar_idx);
+				rte_kvargs_free(kvlist);
+				return -EINVAL;
+			}
+
+			priv->bam = pci_dev->mem_resource[bam_bar_idx].addr;
+		}
+	}
+
+	/* Process parent_pf idx */
+	if (rte_kvargs_count(kvlist, mcdma_kvargs_keys[MCDMA_PARENT_PF_IDX])) {
+		ret = rte_kvargs_process(kvlist,
+				mcdma_kvargs_keys[MCDMA_PARENT_PF_IDX],
+				id_parse_handler, &priv->parent_pf_idx);
+		if (ret) {
+			PMD_DRV_LOG(WARNING, "parent PF index parse failed");
+			rte_kvargs_free(kvlist);
+			return ret;
+		}
+
+		if (priv->parent_pf_idx >= MCDMA_MAX_PF) {
+			PMD_DRV_LOG(ERR, "Invalid parent PF index: %u",
+				    priv->parent_pf_idx);
+			rte_kvargs_free(kvlist);
+			return -EINVAL;
+		}
+	}
+
+	rte_kvargs_free(kvlist);
+	return 0;
+}
+
+static int mcdma_eth_dev_init(struct rte_eth_dev *dev)
+{
+	struct mcdma_pci_device *priv = dev->data->dev_private;
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
+	uint32_t reg_val;
+	int ret;
+
+	dev->data->dev_private = priv;
+	priv->dev = dev;
+	priv->bar_base = pci_dev->mem_resource[MCDMA_CONFIG_BAR].addr;
+
+	ret = mcmda_parse_args(priv, pci_dev);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "parse args failed with error: %d", ret);
+		return ret;
+	}
+
+	PMD_DRV_LOG(INFO, "MCDMA RTL VERSION : 0x%x",
+		    mcdma_dmacsr_reg_readl(priv->bar_base, MCDMA_CSR_VER_NUM));
+
+	priv->pio = pci_dev->mem_resource[MCDMA_PIO_BAR].addr; /* user logic */
+	priv->pio_bar_len = pci_dev->mem_resource[MCDMA_PIO_BAR].len;
+	if (priv->pio == NULL) {
+		priv->pio_bar_len = 0;
+		PMD_DRV_LOG(WARNING, "PIO BAR %d is not mapped", MCDMA_PIO_BAR);
+	}
+
+	if (priv->is_pf) {
+		reg_val = mcdma_dmacsr_reg_readl(priv->bar_base,
+				MCDMA_CSR_PF_PARAM2_OFFSET(priv->pf_idx));
+		priv->ip_num_chan = MCDMA_GET_NUM_CHAN_PER_PF(reg_val);
+	} else {
+		reg_val = mcdma_dmacsr_reg_readl(priv->bar_base,
+				MCDMA_CSR_PF_PARAM2_OFFSET(priv->parent_pf_idx));
+		priv->ip_num_chan = MCDMA_GET_NUM_CHAN_PER_VF(reg_val);
+	}
+
+	/* Register eth_dev_ops */
+	mcdma_ethdev_ops_init(dev);
+
+	dev->data->dev_flags |= RTE_ETH_DEV_NOLIVE_MAC_ADDR;
+
+	dev->data->mac_addrs = rte_zmalloc("mcdma",
+			RTE_ETHER_ADDR_LEN * MCDMA_MAX_MAC_ADDRS, 0);
+	if (dev->data->mac_addrs == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int mcdma_eth_dev_uninit(struct rte_eth_dev *dev)
+{
+	rte_free(dev->data->mac_addrs);
+	dev->data->mac_addrs = NULL;
+
+	return 0;
+}
+
+static struct rte_pci_id mcdma_pci_id_tbl[] = {
+#define RTE_PCI_DEV_ID_DECL_XNIC(vend, dev) {RTE_PCI_DEVICE(vend, dev)},
+#ifndef PCI_VENDOR_ID_ALTERA
+#define PCI_VENDOR_ID_ALTERA 0x1172
+#endif
+	RTE_PCI_DEV_ID_DECL_XNIC(PCI_VENDOR_ID_ALTERA, 0)
+	{ .vendor_id = 0, },
+};
+
+static int mcdma_eth_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
+			      struct rte_pci_device *pci_dev)
+{
+	return rte_eth_dev_pci_generic_probe(pci_dev,
+					     sizeof(struct mcdma_pci_device),
+					     mcdma_eth_dev_init);
+}
+
+static int mcdma_eth_pci_remove(struct rte_pci_device *pci_dev)
+{
+	return rte_eth_dev_pci_generic_remove(pci_dev, mcdma_eth_dev_uninit);
+}
+
+static struct rte_pci_driver rte_mcdma_pmd = {
+	.id_table = mcdma_pci_id_tbl,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING,
+	.probe = mcdma_eth_pci_probe,
+	.remove = mcdma_eth_pci_remove,
+};
+
+RTE_PMD_REGISTER_PCI(net_mcdma, rte_mcdma_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(net_mcdma, mcdma_pci_id_tbl);
+RTE_PMD_REGISTER_KMOD_DEP(net_mcdma, "* igb_uio | vfio-pci");
+RTE_PMD_REGISTER_PARAM_STRING(net_mcdma,
+	MCDMA_ARGS_PF_IDX "=<int> "
+	MCDMA_ARGS_PARENT_PF_IDX "=<int> "
+	MCDMA_ARGS_CFG_BAM_BAR "=<int> "
+	MCDMA_ARGS_VF_WEIGHTS "=<string> ");
diff --git a/drivers/net/altera/mcdma/mcdma_eth.h b/drivers/net/altera/mcdma/mcdma_eth.h
new file mode 100644
index 000000000000..c3b74474c10c
--- /dev/null
+++ b/drivers/net/altera/mcdma/mcdma_eth.h
@@ -0,0 +1,333 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2020-2026 Altera Corporation
+ */
+#ifndef __MCDMA_ETH_H_
+#define __MCDMA_ETH_H_
+
+#include <stddef.h>
+#include <stdbool.h>
+
+#include <ethdev_driver.h>
+#include <rte_ether.h>
+#include <rte_log.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
+
+#include "mcdma_config_csr.h"
+
+extern int mcdma_logtype_driver;
+#define RTE_LOGTYPE_MCDMA_DRIVER mcdma_logtype_driver
+#define PMD_DRV_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, MCDMA_DRIVER, "%s(): ", __func__, __VA_ARGS__)
+
+#define MCDMA_LOG_ENABLE		1
+#if MCDMA_LOG_ENABLE
+#define PMD_DRV_LOG_DBG(level, ...) PMD_DRV_LOG(level, __VA_ARGS__)
+#else
+#define PMD_DRV_LOG_DBG(level, ...) RTE_SET_USED(level)
+#endif
+/* PCI resource */
+#define MCDMA_BAR_MAX			6
+#define MCDMA_CONFIG_BAR		0
+#define MCDMA_PIO_BAR			2
+
+/* SW resource and flags - start */
+#define MCDMA_COMPL_WB			1	/* compl status: Write back */
+#define MCDMA_MAX_PYLD_CNT		1048576
+#define MCDMA_MAX_BURST			32
+#define MCDMA_MAX_MAC_ADDRS		1
+#define MCDMA_MIN_MTU			0x40
+#define MCDMA_DIR_D2H			0
+#define MCDMA_DIR_H2D			1
+#define MCDMA_BATCH_DESC_DELAY		1
+#define MCDMA_IP_MAX_FRAME_LEN		0x1FFFFF	/* HW descriptor len (20-bit) */
+#define MCDMA_RX_ETH_OVERHEAD		(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN)
+#define MCDMA_MAX_RX_FRAME_LEN		MCDMA_IP_MAX_FRAME_LEN
+#define MCDMA_MAX_MTU \
+	((uint16_t)RTE_MIN((uint32_t)(MCDMA_MAX_RX_FRAME_LEN - \
+			    MCDMA_RX_ETH_OVERHEAD), (uint32_t)UINT16_MAX))
+#define MCDMA_TX_MZONE_NAME		"TxHwRn"
+#define MCDMA_RX_MZONE_NAME		"RxHwRn"
+#define MCDMA_Q_RESET_TO		300000
+#define MCDMA_SW_RESET_DELAY_MS		1000
+#define MCDMA_DESC_SOF			RTE_BIT64(0)
+#define MCDMA_DESC_EOF			RTE_BIT64(1)
+
+#define MCDMA_CNT_HEAD_MOVE		100000
+/* SW resource and flags - end */
+
+/* HW resource - start */
+#define MCDMA_MAX_PF			8
+#define MCDMA_MAX_VF_PER_PF		2048
+#define MCDMA_DESC_PAGE_SIZE		4096
+#define MCDMA_DESC_LEN			32
+#define MCDMA_NUM_DESC_PER_PAGE		(MCDMA_DESC_PAGE_SIZE / MCDMA_DESC_LEN)
+#define MCDMA_NUM_DESC_BITS		16
+/* HW ring capacity: 16-bit didx index space (1 << 16 descriptors) */
+#define MCDMA_MAX_DESCS			(1U << MCDMA_NUM_DESC_BITS)
+/*
+ * Max ring depth exposed via ethdev (nb_*_desc is uint16_t): power of 2,
+ * MCDMA_NUM_DESC_PER_PAGE-aligned; largest value the PMD accepts.
+ */
+#define MCDMA_MAX_RING_DESCS		(1U << (MCDMA_NUM_DESC_BITS - 1))
+#define MCDMA_IFC_DATA_WIDTH		512
+
+/* tail/head/cmpl ptr: [15:0] */
+#define MCDMA_PTR_MASK			0xFFFF
+/* HW resource - end */
+
+/* Num QCSR per direction per device. 2048 for H2D and 2048 for D2H */
+#define MCDMA_QCSR_NUM_MAX_PER_DIR	2048
+#define MCDMA_QCSR_SIZE			256
+#define MCDMA_QCSR_H2D_OFFSET		(MCDMA_QCSR_NUM_MAX_PER_DIR * MCDMA_QCSR_SIZE)
+
+/* Max DMA channel per function */
+#define MCDMA_MAX_CHAN_PER_FUNC		512
+#define MCDMA_MAX_CHAN			2048
+
+/* Config space CSR offset */
+typedef enum {
+	MCDMA_CONFIG_QCSR,
+	MCDMA_CONFIG_MSIX,
+	MCDMA_CONFIG_CSR,
+	MCDMA_CONFIG_MBOX_CSR,
+	MCDMA_CONFIG_DCA_CSR,
+	MCDMA_MAX_CONFIGS,
+} mcdma_config_idx_t;
+
+struct mcdma_config_map {
+	unsigned int idx;
+	size_t offset;
+};
+
+struct mcdma_desc {
+	uint64_t src;
+	uint64_t dest;
+	uint32_t len:20;
+	uint32_t rsvd:12;
+	uint32_t didx:16;
+	uint32_t msix_en:1;
+	uint32_t wb_en:1;
+	uint32_t rsvd2:14;
+	uint32_t rx_pyld_cnt:20;
+	uint32_t rsvd3:10;
+	uint32_t sof:1;
+	uint32_t eof:1;
+	uint32_t rsvd5:28;
+	uint32_t pad_len:2;
+	uint32_t desc_invalid:1;
+	uint32_t link:1;
+};
+
+struct mcdma_queue {
+	struct rte_eth_dev *ethdev;
+	void *qcsr;
+	struct rte_mbuf **sw_ring;
+	struct rte_mempool *mb_pool;
+	void *qbuf;
+	uint64_t qbuf_dma;
+	uint32_t qid;
+	int socket_id;
+	uint32_t dir;
+	uint32_t num_desc_pages;
+	uint32_t num_descs;
+	uint32_t wbe;
+
+	/* SW shadow of last freed HW didx (1 .. num_descs), 0 = none freed */
+	volatile uint16_t freed_cons_didx;
+	/* Last filled descriptor HW didx (1 .. num_descs), 0 = none */
+	uint16_t prod_didx;
+	/* HW writeback: last completed didx (1 .. num_descs), 0 = none */
+	volatile uint16_t cons_didx;
+	/* Last tail submit HW didx (1 .. num_descs), 0 = none */
+	uint16_t submitted_didx;
+	uint16_t ring_avail;
+	uint16_t ring_to_submit;
+	uint16_t processed_cur;
+	/* 16 bits - Monotonic index and IP requires it to start from 1 */
+	uint16_t didx;
+	uint16_t burst_size;
+	/** D2H: DMA length per buffer descriptor (full frame, <= mbuf data room). */
+	uint32_t rx_seg_len;
+
+	uint64_t rx_pkts;
+	uint64_t rx_bytes;
+	uint64_t tx_pkts;
+	uint64_t tx_bytes;
+	uint64_t drop_pkts;
+	uint64_t rx_nombuf;
+	uint64_t complete;
+};
+
+#define MCDMA_DESC_PTR(q, prod) \
+	((struct mcdma_desc *)((uint8_t *)(q)->qbuf + \
+	 sizeof(struct mcdma_desc) * (prod)))
+#define MCDMA_NEXT_IDX(prod, qlen)  ((((uint32_t)(prod)) + 1) % (qlen))
+#define MCDMA_PREV_IDX(cur, qlen) \
+	({ \
+		uint32_t _cur = (uint32_t)(cur); \
+		uint32_t _qlen = (uint32_t)(qlen); \
+		(_cur + _qlen - 1) % _qlen; \
+	})
+#define MCDMA_RING_AVAIL_COUNT(cur, base, size) \
+	({ \
+		uint32_t _cur = (uint32_t)(cur); \
+		uint32_t _base = (uint32_t)(base); \
+		uint32_t _size = (uint32_t)(size); \
+		_cur < _base ? _base - _cur : _size - _cur + _base; \
+	})
+#define MCDMA_RING_USED_COUNT(cur, base, size) \
+	({ \
+		uint32_t _cur = (uint32_t)(cur); \
+		uint32_t _base = (uint32_t)(base); \
+		uint32_t _size = (uint32_t)(size); \
+		_cur >= _base ? _cur - _base : _size - _base + _cur; \
+	})
+
+/* Monotonic descriptor didx assigned to d->didx; wraps at MCDMA_MAX_DESCS. */
+#define MCDMA_DIDX_NEXT(cur, num_descs) \
+	((uint16_t)((((uint16_t)(cur) + 1) % (num_descs))))
+
+/* HW descriptor didx is 1-based (1 .. num_descs); ring slots are 0-based. */
+#define MCDMA_RING_TO_HW_DIDX(ring_idx, num_descs) \
+	((uint16_t)(((uint16_t)(ring_idx) % (uint16_t)(num_descs)) + 1))
+
+static inline uint16_t
+mcdma_hw_didx_to_ring(uint16_t hw_didx, uint16_t num_descs)
+{
+	if (hw_didx == 0)
+		return num_descs - 1;
+
+	return hw_didx - 1;
+}
+
+static inline uint16_t
+mcdma_hw_didx_nudge(uint16_t hw_didx, uint16_t num_descs)
+{
+	hw_didx++;
+	if (hw_didx > num_descs)
+		return 1;
+
+	return hw_didx;
+}
+
+static inline uint16_t
+mcdma_qcsr_ptr_val(uint32_t reg)
+{
+	return (uint16_t)(reg & MCDMA_PTR_MASK);
+}
+
+static inline uint16_t
+mcdma_queue_cons_ring(const struct mcdma_queue *q)
+{
+	return mcdma_hw_didx_to_ring(q->cons_didx, q->num_descs);
+}
+
+static inline uint16_t
+mcdma_queue_freed_ring(const struct mcdma_queue *q)
+{
+	return mcdma_hw_didx_to_ring(q->freed_cons_didx, q->num_descs);
+}
+
+static inline uint16_t
+mcdma_queue_prod_ring(const struct mcdma_queue *q)
+{
+	return mcdma_hw_didx_to_ring(q->prod_didx, q->num_descs);
+}
+
+struct mcdma_pci_device {
+	struct rte_eth_dev *dev;
+	/* config */
+	void *bar_base;
+	/* BAR region for user logic */
+	uint64_t *pio;
+	/** Size in bytes of the mapped PIO BAR (0 if unmapped). */
+	uint64_t pio_bar_len;
+	/* BAR region Bursting AVMM master */
+	uint64_t *bam;
+	/* num channels configured in IP */
+	int ip_num_chan;
+	bool is_pf;
+	uint8_t pf_idx;
+	uint8_t parent_pf_idx;
+};
+
+void *mcdma_get_csraddr(void *base, unsigned int idx);
+
+static inline uint32_t mcdma_qcsr_reg_readl(void *base, uint32_t offset)
+{
+	void *addr = (uint8_t *)base + offset;
+
+	return mcdma_reg_readl(addr);
+}
+
+static inline void mcdma_qcsr_reg_writel(void *base, uint32_t offset, uint32_t val)
+{
+	void *addr = (uint8_t *)base + offset;
+
+	mcdma_reg_writel(addr, val);
+}
+
+static inline void mcdma_qcsr_reg_updatel(void *base, uint32_t offset,
+					  uint32_t val, uint32_t shift, uint32_t mask)
+{
+	mcdma_reg_updatel(base, offset, val, shift, mask);
+}
+
+/* Except few registers all register access are restricted only to pf0 */
+static inline uint32_t mcdma_dmacsr_reg_readl(void *base, mcdma_csr_offset_t offset)
+{
+	void *addr = (uint8_t *)mcdma_get_csraddr(base, MCDMA_CONFIG_CSR) + offset;
+
+	return mcdma_reg_readl(addr);
+}
+
+static inline void mcdma_dmacsr_reg_writel(void *base, mcdma_csr_offset_t offset,
+					     uint32_t val)
+{
+	void *addr = (uint8_t *)mcdma_get_csraddr(base, MCDMA_CONFIG_CSR) + offset;
+
+	mcdma_reg_writel(addr, val);
+}
+
+static inline void mcdma_dmacsr_reg_updatel(void *base, mcdma_csr_offset_t offset,
+					    uint32_t val, uint32_t shift, uint32_t mask)
+{
+	void *csr = mcdma_get_csraddr(base, MCDMA_CONFIG_CSR);
+
+	mcdma_reg_updatel(csr, offset, val, shift, mask);
+}
+
+static inline uint32_t mcdma_pio_reg_readl(void *pio, uint32_t offset)
+{
+	void *addr = (uint8_t *)pio + offset;
+
+	return mcdma_reg_readl(addr);
+}
+
+static inline void mcdma_pio_reg_writel(void *pio, uint32_t offset, uint32_t val)
+{
+	void *addr = (uint8_t *)pio + offset;
+
+	mcdma_reg_writel(addr, val);
+}
+
+static inline uint64_t mcdma_pio_reg_read64(void *pio, uint64_t offset)
+{
+	volatile void *addr = (uint8_t *)pio + offset;
+
+	return *(volatile uint64_t *)addr;
+}
+
+static inline void mcdma_pio_reg_write64(void *pio, uint64_t offset, uint64_t val)
+{
+	volatile void *addr = (uint8_t *)pio + offset;
+
+	*(volatile uint64_t *)addr = val;
+}
+
+void mcdma_ethdev_ops_init(struct rte_eth_dev *dev);
+int mcdma_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+			struct eth_queue_stats *qstats);
+
+#endif /* __MCDMA_ETH_H_ */
diff --git a/drivers/net/altera/mcdma/mcdma_eth_ops.c b/drivers/net/altera/mcdma/mcdma_eth_ops.c
new file mode 100644
index 000000000000..8e7624312fe0
--- /dev/null
+++ b/drivers/net/altera/mcdma/mcdma_eth_ops.c
@@ -0,0 +1,931 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2020-2026 Altera Corporation
+ */
+
+#include <errno.h>
+#include <math.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_cycles.h>
+#include <rte_errno.h>
+#include <rte_malloc.h>
+#include <rte_memzone.h>
+
+#include "mcdma_eth.h"
+
+static int mcdma_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qid);
+static int mcdma_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t qid);
+
+static uint16_t
+mcdma_dev_mtu_get(const struct rte_eth_dev *dev)
+{
+	if (dev->data->dev_conf.rxmode.mtu != 0)
+		return dev->data->dev_conf.rxmode.mtu;
+	if (dev->data->mtu != 0)
+		return dev->data->mtu;
+
+	return RTE_ETHER_MTU;
+}
+
+static uint32_t
+mcdma_rx_frame_len_from_mtu(uint16_t mtu)
+{
+	return (uint32_t)mtu + MCDMA_RX_ETH_OVERHEAD;
+}
+
+static int
+mcdma_rx_frame_len_check(struct rte_eth_dev *dev, uint32_t frame_len)
+{
+	if (frame_len == 0 || frame_len > MCDMA_MAX_RX_FRAME_LEN) {
+		PMD_DRV_LOG(ERR,
+			    "port %u: Rx frame length %u invalid (HW max %u)",
+			    dev->data->port_id, frame_len,
+			    MCDMA_MAX_RX_FRAME_LEN);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+mcdma_rx_seg_len_for_pool(struct rte_eth_dev *dev, struct rte_mempool *mb_pool,
+			   uint32_t *rx_seg_len)
+{
+	uint32_t frame_len = mcdma_rx_frame_len_from_mtu(mcdma_dev_mtu_get(dev));
+	uint32_t buf_len = rte_pktmbuf_data_room_size(mb_pool);
+	int ret;
+
+	ret = mcdma_rx_frame_len_check(dev, frame_len);
+	if (ret != 0)
+		return ret;
+
+	if (buf_len <= RTE_PKTMBUF_HEADROOM) {
+		PMD_DRV_LOG(ERR, "port %u: mbuf pool data room %u too small",
+			    dev->data->port_id, buf_len);
+		return -EINVAL;
+	}
+
+	buf_len -= RTE_PKTMBUF_HEADROOM;
+	if (frame_len > buf_len) {
+		PMD_DRV_LOG(ERR,
+			    "port %u: Rx frame %u B exceeds mbuf data room %u B (MTU %u)",
+			    dev->data->port_id, frame_len, buf_len,
+			    mcdma_dev_mtu_get(dev));
+		return -EINVAL;
+	}
+
+	*rx_seg_len = frame_len;
+	return 0;
+}
+
+static int mcdma_wait_queue_drain(struct mcdma_queue *q)
+{
+	uint32_t retry;
+
+	for (retry = 0; retry < MCDMA_CNT_HEAD_MOVE; retry++) {
+		rte_rmb();
+		if (q->cons_didx == q->prod_didx)
+			return 0;
+		rte_delay_us_block(10);
+	}
+
+	PMD_DRV_LOG(ERR,
+		    "queue %u drain timeout (cons_didx=%u prod_didx=%u)",
+		    q->qid, q->cons_didx, q->prod_didx);
+	return -ETIMEDOUT;
+}
+
+/* Free mbufs still held between freed_cons_didx and prod_didx */
+static void
+mcdma_sw_ring_free_inflight(struct mcdma_queue *q)
+{
+	uint16_t nb_to_free;
+
+	nb_to_free = MCDMA_RING_USED_COUNT(mcdma_queue_prod_ring(q),
+				      mcdma_queue_freed_ring(q), q->num_descs);
+	while (nb_to_free--) {
+		struct mcdma_desc *d;
+		uint16_t idx = MCDMA_NEXT_IDX(mcdma_queue_freed_ring(q), q->num_descs);
+		d = MCDMA_DESC_PTR(q, idx);
+		if (q->sw_ring[idx] != NULL &&
+		    (q->dir != MCDMA_DIR_H2D || d->eof))
+			rte_pktmbuf_free(q->sw_ring[idx]);
+		q->sw_ring[idx] = NULL;
+		q->freed_cons_didx = d->didx;
+	}
+}
+
+/* Caller to ensure value fits inside the mask */
+static int mcdma_reg_write_verify(struct mcdma_queue *q, uint32_t reg,
+			       uint32_t mask, uint32_t val, unsigned int shift,
+			       uint64_t timeout_us, uint32_t poll_val)
+{
+	uint32_t reg_val;
+	uint64_t start_tsc;
+	uint64_t timeout_tsc;
+
+	if (!mask)
+		return -EINVAL;
+
+	reg_val = mcdma_qcsr_reg_readl(q->qcsr, reg);
+	reg_val = (reg_val & ~mask) | ((val << shift) & mask);
+	mcdma_qcsr_reg_writel(q->qcsr, reg, reg_val);
+
+	start_tsc = rte_get_timer_cycles();
+	timeout_tsc = (timeout_us * rte_get_timer_hz()) / 1000000;
+
+	for (;;) {
+		uint32_t readback = mcdma_qcsr_reg_readl(q->qcsr, reg);
+		if (((readback & mask) >> shift) == poll_val)
+			return 0;
+
+		if (rte_get_timer_cycles() - start_tsc >= timeout_tsc)
+			return -ETIMEDOUT;
+
+		rte_delay_us_block(10);
+	}
+}
+
+static void mcdma_dev_descq_disable(struct mcdma_queue *q)
+{
+	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_CTRL, 0);
+}
+
+static void mcdma_dev_descq_free(struct mcdma_queue *q)
+{
+	const struct rte_memzone *qzone;
+	char z_name[RTE_MEMZONE_NAMESIZE];
+	const char *ring_name = (q->dir == MCDMA_DIR_H2D) ?
+				MCDMA_TX_MZONE_NAME : MCDMA_RX_MZONE_NAME;
+	struct rte_eth_dev *dev = q->ethdev;
+
+	snprintf(z_name, sizeof(z_name), "%s%s%u_%u",
+		 dev->device->driver->name, ring_name,
+		 dev->data->port_id, q->qid);
+
+	qzone = rte_memzone_lookup(z_name);
+	if (qzone)
+		rte_memzone_free(qzone);
+
+	rte_free(q->sw_ring);
+}
+
+/* Allocate and initialize software queue structure */
+static int mcdma_sw_descq_alloc(struct rte_eth_dev *dev, struct mcdma_queue **q_ptr,
+				uint32_t dir, uint16_t q_id, uint16_t nb_desc,
+				unsigned int socket_id)
+{
+	struct mcdma_pci_device *mcdma_dev = dev->data->dev_private;
+	struct mcdma_queue *q;
+	const char *type = (dir == MCDMA_DIR_H2D) ? "MCDMA_TxQ" : "MCDMA_RxQ";
+	uint32_t qcsr_offset = (dir == MCDMA_DIR_H2D) ?
+			       (MCDMA_QCSR_H2D_OFFSET + (q_id * MCDMA_QCSR_SIZE)) :
+			       (q_id * MCDMA_QCSR_SIZE);
+
+	if (nb_desc == 0 || nb_desc > MCDMA_MAX_RING_DESCS ||
+	    (nb_desc % MCDMA_NUM_DESC_PER_PAGE) != 0 ||
+	    !rte_is_power_of_2(nb_desc)) {
+		PMD_DRV_LOG(ERR,
+			    "Invalid descriptor ring size %u (power of 2, align %u, max %u)",
+			    nb_desc, MCDMA_NUM_DESC_PER_PAGE, MCDMA_MAX_RING_DESCS);
+		return -EINVAL;
+	}
+
+	q = rte_zmalloc_socket(type, sizeof(*q), RTE_CACHE_LINE_SIZE, socket_id);
+	if (!q) {
+		PMD_DRV_LOG(ERR, "Failed to allocate %s queue", type);
+		return -ENOMEM;
+	}
+
+	*q_ptr = q;
+
+	q->socket_id = (int)socket_id;
+	q->qcsr = (uint8_t *)mcdma_get_csraddr(mcdma_dev->bar_base,
+					       MCDMA_CONFIG_QCSR) + qcsr_offset;
+	q->qid = q_id;
+	q->ethdev = dev;
+	q->dir = dir;
+	q->num_descs = nb_desc;
+	q->num_desc_pages = (nb_desc * MCDMA_DESC_LEN) / MCDMA_DESC_PAGE_SIZE;
+
+	q->sw_ring = rte_zmalloc_socket("desc_sw_ctx",
+					q->num_descs * sizeof(struct rte_mbuf *), 0,
+					socket_id);
+	if (!q->sw_ring) {
+		PMD_DRV_LOG(ERR, "Failed to allocate sw ring");
+		rte_free(q);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/* Allocate HW descriptor ring */
+static int mcdma_dev_descq_alloc(struct rte_eth_dev *dev,
+				 struct mcdma_queue *q)
+{
+	const struct rte_memzone *qzone;
+	struct mcdma_desc *desc;
+	size_t len = MCDMA_DESC_PAGE_SIZE * q->num_desc_pages;
+	char z_name[RTE_MEMZONE_NAMESIZE];
+	const char *ring_name = (q->dir == MCDMA_DIR_H2D) ?
+				MCDMA_TX_MZONE_NAME : MCDMA_RX_MZONE_NAME;
+	unsigned int flags = RTE_MEMZONE_IOVA_CONTIG |
+			     RTE_MEMZONE_2MB |
+			     RTE_MEMZONE_SIZE_HINT_ONLY;
+	uint32_t i;
+
+	snprintf(z_name, sizeof(z_name), "%s%s%u_%u",
+		 dev->device->driver->name, ring_name,
+		 dev->data->port_id, q->qid);
+
+	qzone = rte_memzone_reserve_bounded(z_name, len, q->socket_id,
+					    flags, RTE_CACHE_LINE_SIZE, len);
+	if (!qzone) {
+		PMD_DRV_LOG(ERR,
+			    "qbuf zone allocation failed with err: %s name: %s len: %zu",
+			    rte_strerror(rte_errno), z_name, len);
+		return -rte_errno;
+	}
+
+	if (qzone->iova == RTE_BAD_IOVA) {
+		PMD_DRV_LOG(ERR, "qbuf IOVA mapping failure");
+		return -EIO;
+	}
+
+	q->qbuf = qzone->addr;
+	memset(q->qbuf, 0, len);
+	/* VFIO mode */
+	q->qbuf_dma = rte_mem_virt2iova(q->qbuf);
+	desc = (struct mcdma_desc *)q->qbuf;
+
+	/* Initialize link bit of all descs to zero */
+	for (i = 0; i < q->num_descs; i++)
+		desc[i].link = 0;
+
+	/* For every desc at the page boundary src points to the addrss of next desc */
+	for (i = MCDMA_NUM_DESC_PER_PAGE; i <= q->num_descs; i += MCDMA_NUM_DESC_PER_PAGE) {
+		desc[i - 1].link = 1;
+		/*
+		 * src for last descriptor points the address for desc ring,
+		 * else next page
+		 */
+		desc[i - 1].src = (i == q->num_descs) ?
+			rte_mem_virt2iova(q->qbuf) : rte_mem_virt2iova(desc + i);
+	}
+
+	q->wbe = 1;
+	return 0;
+}
+
+static int mcdma_reset_queue(struct mcdma_queue *q)
+{
+	return mcdma_reg_write_verify(q, MCDMA_QCSR_Q_RESET, MCDMA_QCSR_Q_RESET_MASK,
+				   1, MCDMA_QCSR_Q_RESET_SHIFT, MCDMA_Q_RESET_TO, 0);
+}
+
+/* Stop DMA before releasing mbufs still posted on the ring. */
+static int mcdma_quiesce_queue(struct mcdma_queue *q)
+{
+	int ret;
+
+	ret = mcdma_wait_queue_drain(q);
+	if (ret != 0)
+		return ret;
+
+	mcdma_dev_descq_disable(q);
+
+	ret = mcdma_reset_queue(q);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR, "queue %u reset failed (%d)", q->qid, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mcdma_dev_queue_init(struct mcdma_queue *q)
+{
+	struct rte_eth_dev *dev = q->ethdev;
+	mcdma_qcsr_q_ctrl_t q_ctrl;
+	uint32_t payload;
+	uint64_t cons_idx;
+
+	/* Empty queue: all HW didx counters at 0; first fill is didx 1. */
+	q->cons_didx = 0;
+	q->freed_cons_didx = 0;
+	q->submitted_didx = 0;
+	q->prod_didx = 0;
+	q->didx = 0;
+	q->burst_size = MCDMA_MAX_BURST;
+
+	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_START_ADDR_L, q->qbuf_dma);
+	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_START_ADDR_H, q->qbuf_dma >> 32);
+	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_SIZE, (uint32_t)log2(q->num_descs));
+	cons_idx = rte_mem_virt2iova((const void *)(uintptr_t)&q->cons_didx);
+	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_CONSUMED_HEAD_ADDR_L, cons_idx);
+	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_CONSUMED_HEAD_ADDR_H,
+			      cons_idx >> 32);
+	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_BATCH_DELAY,
+			      MCDMA_BATCH_DESC_DELAY);
+
+	if (q->dir == MCDMA_DIR_D2H) {
+		if (q->rx_seg_len == 0) {
+			PMD_DRV_LOG(ERR, "Rx queue %u: invalid segment length",
+				    q->qid);
+			return -EINVAL;
+		}
+		payload = RTE_ALIGN(q->rx_seg_len, RTE_CACHE_LINE_SIZE);
+	} else {
+		payload = RTE_ALIGN(mcdma_rx_frame_len_from_mtu(mcdma_dev_mtu_get(dev)),
+				    RTE_CACHE_LINE_SIZE);
+	}
+
+	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_CPL_TIMEOUT, 0);
+	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_PAYLOAD_COUNT, payload);
+
+	q_ctrl.val = 0;
+	q_ctrl.field.q_en = 1;
+	if (q->wbe)
+		q_ctrl.field.q_wb_en = 1;
+
+	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_CTRL, q_ctrl.val);
+	return 0;
+}
+
+static int mcdma_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
+				    uint16_t nb_tx_desc,
+				    unsigned int socket_id,
+				    const struct rte_eth_txconf *tx_conf __rte_unused)
+{
+	struct mcdma_pci_device *mcdma_dev = dev->data->dev_private;
+	struct mcdma_queue *txq = NULL;
+	int ret;
+
+	if (tx_queue_id >= mcdma_dev->ip_num_chan) {
+		PMD_DRV_LOG(ERR, "TX queue id %u >= max channels %u",
+			    tx_queue_id, mcdma_dev->ip_num_chan);
+		return -EINVAL;
+	}
+
+	ret = mcdma_sw_descq_alloc(dev, &txq, MCDMA_DIR_H2D, tx_queue_id,
+				   nb_tx_desc, socket_id);
+	if (ret < 0)
+		return ret;
+
+	ret = mcdma_dev_descq_alloc(dev, txq);
+	if (ret < 0) {
+		mcdma_dev_descq_free(txq);
+		rte_free(txq);
+		return ret;
+	}
+
+	ret = mcdma_reset_queue(txq);
+	if (ret) {
+		mcdma_dev_descq_free(txq);
+		rte_free(txq);
+		return ret;
+	}
+
+	dev->data->tx_queues[tx_queue_id] = txq;
+	return 0;
+}
+
+static int mcdma_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
+				    uint16_t nb_rx_desc,
+				    unsigned int socket_id,
+				    const struct rte_eth_rxconf *rx_conf __rte_unused,
+				    struct rte_mempool *mb_pool)
+{
+	struct mcdma_pci_device *mcdma_dev = dev->data->dev_private;
+	struct mcdma_queue *rxq = NULL;
+	int ret;
+
+	if (mb_pool)
+		PMD_DRV_LOG_DBG(ERR,
+				"qid: %u, mbuf_avail_count = %u, mbuf_in_use_count = %u",
+				rx_queue_id, rte_mempool_avail_count(mb_pool),
+				rte_mempool_in_use_count(mb_pool));
+	if (rx_queue_id >= mcdma_dev->ip_num_chan) {
+		PMD_DRV_LOG(ERR, "RX queue id %u >= max channels %u",
+			    rx_queue_id, mcdma_dev->ip_num_chan);
+		return -EINVAL;
+	}
+
+	if (mb_pool == NULL) {
+		PMD_DRV_LOG(ERR, "Rx queue %u: mbuf pool required", rx_queue_id);
+		return -EINVAL;
+	}
+
+	ret = mcdma_sw_descq_alloc(dev, &rxq, MCDMA_DIR_D2H, rx_queue_id,
+				   nb_rx_desc, socket_id);
+	if (ret < 0)
+		return ret;
+
+	rxq->mb_pool = mb_pool;
+
+	ret = mcdma_rx_seg_len_for_pool(dev, mb_pool, &rxq->rx_seg_len);
+	if (ret != 0) {
+		mcdma_dev_descq_free(rxq);
+		rte_free(rxq);
+		return ret;
+	}
+
+	ret = mcdma_dev_descq_alloc(dev, rxq);
+	if (ret < 0) {
+		mcdma_dev_descq_free(rxq);
+		rte_free(rxq);
+		return ret;
+	}
+
+	ret = mcdma_reset_queue(rxq);
+	if (ret) {
+		mcdma_dev_descq_free(rxq);
+		rte_free(rxq);
+		return ret;
+	}
+
+	dev->data->rx_queues[rx_queue_id] = rxq;
+	return 0;
+}
+
+static int mcdma_dev_tx_queue_start(struct rte_eth_dev *dev, uint16_t qid)
+{
+	struct mcdma_queue *txq = dev->data->tx_queues[qid];
+	int ret;
+
+	if (txq == NULL)
+		return -EINVAL;
+
+	ret = mcdma_dev_queue_init(txq);
+	if (ret)
+		return ret;
+
+	dev->data->tx_queue_state[qid] = RTE_ETH_QUEUE_STATE_STARTED;
+	return 0;
+}
+
+static int mcdma_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t qid)
+{
+	struct mcdma_queue *rxq = dev->data->rx_queues[qid];
+	int ret;
+
+	if (rxq == NULL)
+		return -EINVAL;
+
+	ret = mcdma_dev_queue_init(rxq);
+	if (ret)
+		return ret;
+
+	dev->data->rx_queue_state[qid] = RTE_ETH_QUEUE_STATE_STARTED;
+	return 0;
+}
+
+static int mcdma_dev_start(struct rte_eth_dev *dev)
+{
+	uint16_t qid;
+	int err;
+
+	for (qid = 0; qid < dev->data->nb_tx_queues; qid++) {
+		if (dev->data->tx_queues[qid] == NULL)
+			continue;
+		err = mcdma_dev_tx_queue_start(dev, qid);
+		if (err != 0)
+			goto stop_started;
+	}
+
+	for (qid = 0; qid < dev->data->nb_rx_queues; qid++) {
+		if (dev->data->rx_queues[qid] == NULL)
+			continue;
+		err = mcdma_dev_rx_queue_start(dev, qid);
+		if (err != 0)
+			goto stop_started;
+	}
+
+	return 0;
+
+stop_started:
+	for (qid = 0; qid < dev->data->nb_rx_queues; qid++) {
+		if (dev->data->rx_queues[qid] == NULL)
+			continue;
+		(void)mcdma_dev_rx_queue_stop(dev, qid);
+	}
+	for (qid = 0; qid < dev->data->nb_tx_queues; qid++) {
+		if (dev->data->tx_queues[qid] == NULL)
+			continue;
+		(void)mcdma_dev_tx_queue_stop(dev, qid);
+	}
+
+	return err;
+}
+
+static int mcdma_dev_stop(struct rte_eth_dev *dev)
+{
+	uint16_t qid;
+	int ret;
+	int err = 0;
+
+	for (qid = 0; qid < dev->data->nb_tx_queues; qid++) {
+		ret = mcdma_dev_tx_queue_stop(dev, qid);
+		if (ret != 0 && err == 0)
+			err = ret;
+	}
+	for (qid = 0; qid < dev->data->nb_rx_queues; qid++) {
+		ret = mcdma_dev_rx_queue_stop(dev, qid);
+		if (ret != 0 && err == 0)
+			err = ret;
+	}
+
+	return err;
+}
+
+static int mcdma_dev_link_update(struct rte_eth_dev *dev,
+				 __rte_unused int wait_to_complete)
+{
+	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+	dev->data->dev_link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+
+	return 0;
+}
+
+static void
+mcdma_dev_queue_release_common(struct rte_eth_dev *dev, struct mcdma_queue *q,
+			       uint16_t qid, bool is_rx)
+{
+	if (q == NULL)
+		return;
+
+	if (is_rx) {
+		if (dev->data->rx_queue_state[qid] == RTE_ETH_QUEUE_STATE_STARTED) {
+			if (mcdma_quiesce_queue(q) != 0)
+				PMD_DRV_LOG(WARNING,
+					    "Rx queue %u quiesce failed on release",
+					    qid);
+			mcdma_sw_ring_free_inflight(q);
+			dev->data->rx_queue_state[qid] =
+				RTE_ETH_QUEUE_STATE_STOPPED;
+		}
+		dev->data->rx_queues[qid] = NULL;
+	} else {
+		if (dev->data->tx_queue_state[qid] == RTE_ETH_QUEUE_STATE_STARTED) {
+			if (mcdma_quiesce_queue(q) != 0)
+				PMD_DRV_LOG(WARNING,
+					    "Tx queue %u quiesce failed on release",
+					    qid);
+			mcdma_sw_ring_free_inflight(q);
+			dev->data->tx_queue_state[qid] =
+				RTE_ETH_QUEUE_STATE_STOPPED;
+		}
+		dev->data->tx_queues[qid] = NULL;
+	}
+
+	mcdma_dev_descq_disable(q);
+	mcdma_dev_descq_free(q);
+	rte_free(q);
+}
+
+static void mcdma_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+{
+	mcdma_dev_queue_release_common(dev, dev->data->tx_queues[qid], qid,
+				       false);
+}
+
+static void mcdma_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+{
+	mcdma_dev_queue_release_common(dev, dev->data->rx_queues[qid], qid,
+				       true);
+}
+
+static int mcdma_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qid)
+{
+	struct mcdma_queue *q;
+	int ret;
+
+	if (!dev->data->tx_queue_state[qid])
+		return 0;
+
+	q = dev->data->tx_queues[qid];
+	if (q == NULL)
+		return 0;
+
+	ret = mcdma_quiesce_queue(q);
+	if (ret != 0)
+		return ret;
+
+	mcdma_sw_ring_free_inflight(q);
+
+	dev->data->tx_queue_state[qid] = RTE_ETH_QUEUE_STATE_STOPPED;
+	return 0;
+}
+
+static int mcdma_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t qid)
+{
+	struct mcdma_queue *q;
+	int ret;
+
+	if (!dev->data->rx_queue_state[qid])
+		return 0;
+
+	q = dev->data->rx_queues[qid];
+	if (q == NULL)
+		return 0;
+
+	ret = mcdma_quiesce_queue(q);
+	if (ret != 0)
+		return ret;
+
+	mcdma_sw_ring_free_inflight(q);
+
+	dev->data->rx_queue_state[qid] = RTE_ETH_QUEUE_STATE_STOPPED;
+	return 0;
+}
+
+static int mcdma_dev_infos_get(struct rte_eth_dev *dev,
+			       struct rte_eth_dev_info *dev_info)
+{
+	struct mcdma_pci_device *mcdma_dev = dev->data->dev_private;
+
+	dev_info->max_rx_queues = mcdma_dev->ip_num_chan;
+	dev_info->max_tx_queues = mcdma_dev->ip_num_chan;
+	dev_info->max_rx_pktlen = MCDMA_MAX_RX_FRAME_LEN;
+	dev_info->max_mac_addrs = MCDMA_MAX_MAC_ADDRS;
+	dev_info->default_rxportconf.burst_size = MCDMA_MAX_BURST;
+	dev_info->dev_capa =
+		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
+		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
+	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
+	/* Multi-seg Tx: one sw_ring owner (head on EOF desc); see H2D prepare. */
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->min_mtu = MCDMA_MIN_MTU;
+	dev_info->max_mtu = MCDMA_MAX_MTU;
+	dev_info->rx_desc_lim.nb_max = MCDMA_MAX_RING_DESCS;
+	dev_info->rx_desc_lim.nb_min = MCDMA_NUM_DESC_PER_PAGE;
+	dev_info->rx_desc_lim.nb_align = MCDMA_NUM_DESC_PER_PAGE;
+	dev_info->tx_desc_lim.nb_max = MCDMA_MAX_RING_DESCS;
+	dev_info->tx_desc_lim.nb_min = MCDMA_NUM_DESC_PER_PAGE;
+	dev_info->tx_desc_lim.nb_align = MCDMA_NUM_DESC_PER_PAGE;
+
+	return 0;
+}
+
+static int mcdma_dev_configure(struct rte_eth_dev *dev)
+{
+	struct mcdma_pci_device *mcdma_dev = dev->data->dev_private;
+	int ret;
+
+	if (RTE_MAX(dev->data->nb_rx_queues, dev->data->nb_tx_queues) >
+	    (uint16_t)mcdma_dev->ip_num_chan) {
+		PMD_DRV_LOG(ERR, "Max number of channels supported %u",
+			    mcdma_dev->ip_num_chan);
+		return -EINVAL;
+	}
+
+	ret = mcdma_rx_frame_len_check(dev,
+			mcdma_rx_frame_len_from_mtu(mcdma_dev_mtu_get(dev)));
+	if (ret != 0)
+		return ret;
+
+	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER) {
+		PMD_DRV_LOG(ERR, "Rx scattered/multi-segment mbufs not supported");
+		return -EINVAL;
+	}
+
+	dev->data->scattered_rx = 0;
+
+	/* perform IP Reset - only from PF0 */
+	if (mcdma_dev->is_pf && !mcdma_dev->pf_idx) {
+		mcdma_dmacsr_reg_writel(mcdma_dev->bar_base,
+					MCDMA_CSR_SW_RESET, 0x1);
+		rte_delay_ms(MCDMA_SW_RESET_DELAY_MS);
+	}
+
+	return 0;
+}
+
+static int mcdma_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	uint32_t frame_len;
+	uint16_t qid;
+	int ret;
+
+	if (mtu < MCDMA_MIN_MTU || mtu > MCDMA_MAX_MTU)
+		return -EINVAL;
+
+	frame_len = mcdma_rx_frame_len_from_mtu(mtu);
+	ret = mcdma_rx_frame_len_check(dev, frame_len);
+	if (ret != 0)
+		return ret;
+
+	for (qid = 0; qid < dev->data->nb_rx_queues; qid++) {
+		struct mcdma_queue *rxq = dev->data->rx_queues[qid];
+		uint32_t buf_len;
+
+		if (rxq == NULL || rxq->mb_pool == NULL)
+			continue;
+
+		buf_len = rte_pktmbuf_data_room_size(rxq->mb_pool);
+		if (buf_len <= RTE_PKTMBUF_HEADROOM) {
+			PMD_DRV_LOG(ERR, "port %u: mbuf pool data room %u too small",
+				    dev->data->port_id, buf_len);
+			return -EINVAL;
+		}
+		buf_len -= RTE_PKTMBUF_HEADROOM;
+		if (frame_len > buf_len) {
+			PMD_DRV_LOG(ERR,
+				    "port %u: Rx frame %u B exceeds mbuf data room %u B (MTU %u)",
+				    dev->data->port_id, frame_len, buf_len, mtu);
+			return -EINVAL;
+		}
+
+		rxq->rx_seg_len = frame_len;
+	}
+
+	dev->data->dev_conf.rxmode.mtu = mtu;
+	dev->data->mtu = mtu;
+
+	return 0;
+}
+
+static uint64_t
+mcdma_qcsr_read_drop_count(struct mcdma_queue *q)
+{
+	uint32_t reg;
+
+	reg = mcdma_qcsr_reg_readl(q->qcsr, MCDMA_QCSR_Q_DATA_DRP_ERR_CTR);
+	if (reg & MCDMA_QCSR_DRP_CTR_VALID) {
+		q->drop_pkts += reg & MCDMA_QCSR_DRP_CTR_CNT_MASK;
+		reg &= ~MCDMA_QCSR_DRP_CTR_CLR_MASK;
+		mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_DATA_DRP_ERR_CTR, reg);
+	}
+
+	return q->drop_pkts;
+}
+
+static uint64_t
+mcdma_qcsr_read_ptr_errors(struct mcdma_queue *q)
+{
+	uint32_t reg;
+	uint64_t errs = 0;
+
+	reg = mcdma_qcsr_reg_readl(q->qcsr, MCDMA_QCSR_Q_HEAD_POINTER);
+	if (reg & MCDMA_QCSR_PTR_ERR_MASK)
+		errs++;
+
+	reg = mcdma_qcsr_reg_readl(q->qcsr, MCDMA_QCSR_Q_COMPLETED_POINTER);
+	if (reg & MCDMA_QCSR_PTR_ERR_MASK)
+		errs++;
+
+	return errs;
+}
+
+int mcdma_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+			struct eth_queue_stats *qstats)
+{
+	struct mcdma_queue *q;
+	uint16_t i;
+	uint64_t drops;
+	uint64_t q_errs;
+
+	if (stats == NULL)
+		return -EINVAL;
+
+	memset(stats, 0, sizeof(*stats));
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		q = dev->data->rx_queues[i];
+		if (q == NULL)
+			continue;
+
+		drops = mcdma_qcsr_read_drop_count(q);
+		q_errs = mcdma_qcsr_read_ptr_errors(q);
+		stats->ipackets += q->rx_pkts;
+		stats->ibytes += q->rx_bytes;
+		stats->imissed += drops;
+		stats->ierrors += q_errs;
+		stats->rx_nombuf += q->rx_nombuf;
+
+		if (qstats != NULL) {
+			qstats[i].q_ipackets = q->rx_pkts;
+			qstats[i].q_ibytes = q->rx_bytes;
+		}
+	}
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		q = dev->data->tx_queues[i];
+		if (q == NULL)
+			continue;
+
+		(void)mcdma_qcsr_read_drop_count(q);
+		q_errs = mcdma_qcsr_read_ptr_errors(q);
+		stats->opackets += q->tx_pkts;
+		stats->obytes += q->tx_bytes;
+		stats->oerrors += q_errs;
+
+		if (qstats != NULL) {
+			qstats[i].q_opackets = q->tx_pkts;
+			qstats[i].q_obytes = q->tx_bytes;
+		}
+	}
+
+	return 0;
+}
+
+static unsigned int
+mcdma_xstats_count(const struct rte_eth_dev *dev)
+{
+	return dev->data->nb_rx_queues + dev->data->nb_tx_queues;
+}
+
+static int
+mcdma_dev_xstats_get_names(struct rte_eth_dev *dev,
+			   struct rte_eth_xstat_name *xstats_names,
+			   unsigned int n)
+{
+	unsigned int i;
+	unsigned int count = 0;
+	unsigned int nstats = mcdma_xstats_count(dev);
+
+	if (xstats_names == NULL || n < nstats)
+		return nstats;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		snprintf(xstats_names[count].name,
+			 sizeof(xstats_names[count].name),
+			 "rx_q%u_errors", i);
+		count++;
+	}
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		snprintf(xstats_names[count].name,
+			 sizeof(xstats_names[count].name),
+			 "tx_q%u_errors", i);
+		count++;
+	}
+
+	return count;
+}
+
+static int
+mcdma_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
+		     unsigned int n)
+{
+	unsigned int i;
+	unsigned int count = 0;
+	unsigned int nstats = mcdma_xstats_count(dev);
+
+	if (xstats == NULL || n < nstats)
+		return nstats;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct mcdma_queue *q = dev->data->rx_queues[i];
+		uint64_t errors = 0;
+
+		if (q != NULL)
+			errors = mcdma_qcsr_read_drop_count(q) +
+				 mcdma_qcsr_read_ptr_errors(q);
+
+		xstats[count].id = count;
+		xstats[count].value = errors;
+		count++;
+	}
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct mcdma_queue *q = dev->data->tx_queues[i];
+		uint64_t errors = 0;
+
+		if (q != NULL)
+			errors = mcdma_qcsr_read_ptr_errors(q);
+
+		xstats[count].id = count;
+		xstats[count].value = errors;
+		count++;
+	}
+
+	return count;
+}
+
+static struct eth_dev_ops mcdma_ethdev_ops = {
+	.dev_configure        = mcdma_dev_configure,
+	.dev_infos_get        = mcdma_dev_infos_get,
+	.dev_start            = mcdma_dev_start,
+	.dev_stop             = mcdma_dev_stop,
+	.link_update          = mcdma_dev_link_update,
+	.rx_queue_setup       = mcdma_dev_rx_queue_setup,
+	.tx_queue_setup       = mcdma_dev_tx_queue_setup,
+	.rx_queue_release     = mcdma_dev_rx_queue_release,
+	.tx_queue_release     = mcdma_dev_tx_queue_release,
+	.rx_queue_start       = mcdma_dev_rx_queue_start,
+	.rx_queue_stop        = mcdma_dev_rx_queue_stop,
+	.tx_queue_start       = mcdma_dev_tx_queue_start,
+	.tx_queue_stop        = mcdma_dev_tx_queue_stop,
+	.stats_get            = mcdma_dev_stats_get,
+	.xstats_get           = mcdma_dev_xstats_get,
+	.xstats_get_names     = mcdma_dev_xstats_get_names,
+	.mtu_set              = mcdma_dev_mtu_set,
+};
+
+void mcdma_ethdev_ops_init(struct rte_eth_dev *dev)
+{
+	dev->dev_ops = &mcdma_ethdev_ops;
+}
diff --git a/drivers/net/altera/mcdma/meson.build b/drivers/net/altera/mcdma/meson.build
new file mode 100644
index 000000000000..9195a5d34982
--- /dev/null
+++ b/drivers/net/altera/mcdma/meson.build
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2020-2026 Altera Corporation
+
+if not is_linux
+    build = false
+    reason = 'only supported on Linux'
+endif
+
+sources += files(
+        'mcdma_eth.c',
+        'mcdma_eth_ops.c',
+)
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index 4e8ccb945fa7..aef8af277088 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -68,6 +68,7 @@ drivers = [
         'vmxnet3',
         'xsc',
         'zxdh',
+        'altera/mcdma',
 ]
 std_deps = ['ethdev', 'kvargs'] # 'ethdev' also pulls in mbuf, net, eal etc
 std_deps += ['bus_pci']         # very many PMDs depend on PCI, so make std
diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index 15b19acb2781..8edfde33d832 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -30,6 +30,7 @@
             {'Class': '05', 'Vendor': '1af4', 'Device': '1110'},  # AVP vNIC
             {'Class': '08', 'Vendor': '177d', 'Device': 'a0dd,a049'},  # Cavium PKX
             {'Class': '12', 'Vendor': '8086', 'Device': '0b30'},  # Intel FPGA
+            {'Class': '06', 'Vendor': '8086', 'Device': '1172'},  # Altera FPGA
         ]
     },
     'baseband': {
-- 
2.34.1

