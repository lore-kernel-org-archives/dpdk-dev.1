Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B603C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 16:36:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52DA842759;
	Wed, 19 Feb 2025 17:36:01 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013007.outbound.protection.outlook.com
 [40.107.162.7]) by mails.dpdk.org (Postfix) with ESMTP id A23C34270A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 17:35:59 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UD4arBSS1+p+dBnU0mkKLdTwtqBMgSv1eUC/nQjyuSxbK3KQSryk9/tx6jfZB3uEpCYeThSLyKcOJDFMEt0098rieb6iYyhD82yil2eGryRnRvPYzfxWS49bXpXCTlga1O3WcHPNoN8M0GrTVnKy2EFmcY0aiNWWvcQLXLsKkNC2SkljHmdogw1DegFk+lpiSDmMEdMR8O406uH4JWGepI+Ly/I/jDbtHTKT3nKwvP8vDD8s+ejocvUeG+fmLJOhfGxMh1Mz/BOklegLEFpNITySN0Ab+XELi7VTS3qGbfQth89D6WnUxdcaDdwAWnc6tTSgByRHa08/TUxzuDw4TQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfQMHvQEe+9x8/oCB1GrCyvPnakQefTIgX3HWeBVBEQ=;
 b=HjMF6T/CL6FYxXS/EUXygmQWltiWAO9Rz3qr0ovSHAMdYHH1XRVu4CCQjT2D+HQh9oxq0zpsJwyJPZ0FIl77+dMtmoqDpJfS8KhtHJy3y/aK7AoI5Uia1XfZArMf4x2kbMnhLF/TuXbIuo1u2kHyI6GsnUHiFQ3jAZp1MG5u8xz9DPkoJExZ1S/fnYuCTNgiYSixPviHmD3FHYsdj3HO21QP5WT+1uHLW800BuR+ZReevsHgBihOJqLyV6UQU8eppfohixFXZFI2C+aP0GlRg9v3OmMbYE0wA0jCmFJtMJbylCFpFKWizFDATfPguzwePEl7+Z3nvp66K0rhRWH45w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=dpdk.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfQMHvQEe+9x8/oCB1GrCyvPnakQefTIgX3HWeBVBEQ=;
 b=kC6s3WiU+HiXFYjQvR6QBWSObLWhaYeqbWaInk1f+gfO1c9Qqb4JWSFm0j0uDm+p9CV2eU1h//BTKVWG7AnYXlSz7gTzIe534ziOy5GGh1IXo8EpaPdpPYmBZaMIEfVEVz1zLdpvpouV3HXp+8CvR3AfP2KAFX0wRysil5Q0G8k=
Received: from AM0PR03CA0067.eurprd03.prod.outlook.com (2603:10a6:208::44) by
 DB9PR08MB6348.eurprd08.prod.outlook.com (2603:10a6:10:263::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Wed, 19 Feb 2025 16:35:55 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:208:0:cafe::d2) by AM0PR03CA0067.outlook.office365.com
 (2603:10a6:208::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 16:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.11
 via Frontend Transport; Wed, 19 Feb 2025 16:35:54 +0000
Received: ("Tessian outbound a593bc61b951:v567");
 Wed, 19 Feb 2025 16:35:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3fe377e5299237ee
X-TessianGatewayMetadata: bWe1gBSaOpZPePshymSnEciNrFtS3ax2asHwxo3qeOfSC9Ju8/MB2FO9qbod4e97xn0HArQo4qV/M8+MVm/SzVi0114XBWqvkDUhBKy0DEbIQ+WprQqWZEDjTemTWjOiRk/XkY0W0f2K65ieTi03ZJzFjS2GTdF8xYDVejmQ4pM2Uz1/GR/gCZmUX+fuJnPVSjnSIsxgJhsBXMOUpN3mXg==
X-CR-MTA-TID: 64aa7808
Received: from Lbc98b557fa4e.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 854A8F1C-D006-4CF0-B385-230435A62D37.1; 
 Wed, 19 Feb 2025 16:35:47 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 Lbc98b557fa4e.1 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 19 Feb 2025 16:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUNgo/CZGnxoLMB/nIlwANrvVui5wADPyevFtGCQ9cGZWLnBiKoyyBwz4N7yyNt39Qr7JqUm2DkR3E74o7b79m4tTdAUhMqbqDOIdkuE1IkwuCS5sOKFeX8tUWn448XGVyX+5+skGMfVW2FFw9I9gHVMsEQgyW/+1/h+cz9FLTbQNF5JzvGEVHaxkjjbbwrddGCCoS16ZauIqABpkbuH6l0Kw9Si/TnWZbz0X7bboA/gJjkYwTaa5+x+hHFGhzR04UNOaGFm3NTwQdy01TEDencsZKipH9Si89+Fs9u0aHPWtHL7TzihvVVv7793HOKgtLbX5nkqh56NLM7u488QRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfQMHvQEe+9x8/oCB1GrCyvPnakQefTIgX3HWeBVBEQ=;
 b=BV5kdu1MajN29d6+//q1bHcDQE+4Jhrk3Ea6+AJvD7XoKXf1nkNuJrfYe+DvIS7n5PujlevibBsVhSFFTg6c+tMzcYISwr1Pb3/2SYF7MUxiJsH8RayCQI9SvaskN7QFk7xGM+TcG98OhSNSk7sB8bl709sJnq1DGMGRt7yC6ABlCThlKV3pLFbHxNsoad5DpNfExCnNswZxsiOKXHdiZbTOgkOJHIwA2m82769IvGgSgxa8r/IM72tsGI6kiQv+LeK6Qyy0TFpfXaLTxlTRUk1XLnxjFdPsSJLRSoVSDCokUhH9LceWQd8SYgMGWR8cBVZGElRfkJZiX7pnJ5JCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfQMHvQEe+9x8/oCB1GrCyvPnakQefTIgX3HWeBVBEQ=;
 b=kC6s3WiU+HiXFYjQvR6QBWSObLWhaYeqbWaInk1f+gfO1c9Qqb4JWSFm0j0uDm+p9CV2eU1h//BTKVWG7AnYXlSz7gTzIe534ziOy5GGh1IXo8EpaPdpPYmBZaMIEfVEVz1zLdpvpouV3HXp+8CvR3AfP2KAFX0wRysil5Q0G8k=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by DB9PR08MB7584.eurprd08.prod.outlook.com (2603:10a6:10:308::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 16:35:44 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 16:35:44 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "mkashani@nvidia.com" <mkashani@nvidia.com>, "rasland@nvidia.com"
 <rasland@nvidia.com>, nd <nd@arm.com>
Subject: RE: [PATCH] config/arm: update NVIDIA BlueField-3 configuration
Thread-Topic: [PATCH] config/arm: update NVIDIA BlueField-3 configuration
Thread-Index: AQHbgfLmP/PEaXyZd0iWBsleAUCFArNO0sSw
Date: Wed, 19 Feb 2025 16:35:44 +0000
Message-ID: <PAWPR08MB8909905417281D380EEBEF0B9FC52@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250216140420.216805-1-getelson@nvidia.com>
 <20250218104942.81984-1-getelson@nvidia.com>
In-Reply-To: <20250218104942.81984-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|DB9PR08MB7584:EE_|AM4PEPF00027A69:EE_|DB9PR08MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b26d9a3-a76d-4f61-6593-08dd51037b0f
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?pqHC12omJZfxYX7Br2LM3Gb7OVDJl/efwaSc6pEkVQKjtKHxlitvBpJn/IGg?=
 =?us-ascii?Q?PesnSX4LH824/KQ+gsc5FecKZbY9fpKgir6dMt8tiGZ/CJ/4WXvCbkB3zzFo?=
 =?us-ascii?Q?d9Q0Ib4qxvVGwkif6la/hTUiTz/3NIbfRPQ97MwC+/b4W21GZDMTnBr+HBMH?=
 =?us-ascii?Q?AxfpvGDgO2VpBrdCppXDWGcoDxxyyg9iEnGx6oQ2aaSUtp3XnF4foX1DQ/KB?=
 =?us-ascii?Q?+P6nnxVtFsmtU7XV752fcjGBvqmimdVV/TxPEGZpOHLWbdPhHTMrR3kv6h+G?=
 =?us-ascii?Q?/Gi5MIDJe01ILhT35mOPQZJh/+z1mHkTjhfEm61AAoaUoiKOXB+0fa5LbON+?=
 =?us-ascii?Q?j94JYnTGegKWe9j6aYEHE7uHRa9GbgEL+gfQxdR0/R6Dac4LEjkiKbr7ePJ3?=
 =?us-ascii?Q?ko8IF7uqwCqS1rkFpcwtAQJioTYuW3cpRJHTXFpQXPnxRmVoW/b/IQm2brev?=
 =?us-ascii?Q?zjXmAg2TjXdX4/eV7Vj1yLF/6DFI+Qz9ysoUQ9T8UnF9EpEDYzKUqMKLUAj5?=
 =?us-ascii?Q?YK43citVUsKL3CPgK2o1cVnSmZMIYvm+BXyulekcd19Z9/zYN6plgUEA6y3L?=
 =?us-ascii?Q?F3eaF8UOH5udJmNxudFDRXdyUQLdwcE8NlX+6SRNfZZhIi2Zr0h9zuQ/0uRb?=
 =?us-ascii?Q?+aXwPWH+eqzZc94k0InLlNhI5dKYirBJcLe2U0/4tBkYpGm1N07Nd11o8gav?=
 =?us-ascii?Q?JDIlX0B1HMefVZ+3kUsNJcxwJ0MPeH2P3XZ4rEVFSsY/kTbidQqB1KH4pke9?=
 =?us-ascii?Q?whgr08/NhKwVwnZmtt2zQHGXzJ0wRuWCQUOF+eWfdYptksYSGHvVcOzrZ38x?=
 =?us-ascii?Q?ge2JohF9EBNHRGF77juPM658VsS9Hw5k6TBmX1ekkzovS8PtYdnT7xDR+tqZ?=
 =?us-ascii?Q?0eMEvsJ0YXPET/flV6jVF73ktSyV4SZHDO1+GP6l5E4UVsUmIafVilk61AzA?=
 =?us-ascii?Q?ppMMCRdKiDRt79C2G8+9+rwCVzhIOVb6YQ1pD/jBizBjgPeDKUcD4vyWvukM?=
 =?us-ascii?Q?G2dVl0SJ+STS/h23RWd7x2W6OwCJrTJ+FizdKSElTzk1YgEfLOZDs9SF7ks6?=
 =?us-ascii?Q?OB6Td8U0B+M9nlKbSs7VMyLizd32TfxH5dOIvV8Xm+8JGQgtr0Ly4RUBB64B?=
 =?us-ascii?Q?/i93cbIcnYXZi9ctzcC5G+84oA6nMEk0QmnDKhuoyTtPfuyjh6OrTsGPLEXj?=
 =?us-ascii?Q?3T5krjg6WiJ2AIXjrL1VeIp25Yi3ue3Gh0XdQbBXzD8ePcNHCG1k/K4FMnSA?=
 =?us-ascii?Q?kqvQyaO21L3rOSdIxBDuU3rSfdhGzd2OogOjKgBjtJlIAG8QkGQU3mMsNROQ?=
 =?us-ascii?Q?Fs1+Mp3R0hnYgZRBLlwhoJ0ClKeo8mrLH7gBd7eY8AcZJoB3TgPvh+dVQf/N?=
 =?us-ascii?Q?Xr/MyvBwugMSIvOnCtz0/wrszbVeS6mTRjrgAeJjCLHBFDEMcafqcUhLBeXq?=
 =?us-ascii?Q?zpST2npOZ7VCXERPP7iEeauh4QyMTaKk?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7584
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:102:33a::19];
 domain=PAWPR08MB8909.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 238a9693-a39c-4cde-019e-08dd510374b5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|1800799024|36860700013|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lf8pP3HWCn/dAKdjkXBTYg+GGxd/M+C6xQaCyDvW+0QgVBstwQhEzDpb0EJ6?=
 =?us-ascii?Q?VXnYTJme8qZrWTAyqRq0YUaO67IiL4gNiT98ceIq1VWSWM7Ye7r5W8XTfWoZ?=
 =?us-ascii?Q?zrvyJ1JjcSREf5IJ8LdXGFHgi0186ReSUmxnbW0SnzS7M/NLWnXxFg+kjTK4?=
 =?us-ascii?Q?ZSRcNBH89K2XcTUUPFDCnlUCvMTRLcSeZ4VnMgaSBbP3DsLKCBNoCf2JbLZw?=
 =?us-ascii?Q?kBdmWDTYYXq5lc2AJ7JAZvQVSVnxPDaxgGNFI8cCNmcTBlS5tm4Lh5hX1kAP?=
 =?us-ascii?Q?tlsBTcZizNDcREMDqsdwJbrHxTsCeiGhGdhJpNIkJW0oMlmoOG+R/bkD1XV7?=
 =?us-ascii?Q?3Ae6cpKy2Cuo2HBUYc+8tJ1AuW7Og0jYzRW7mSAbiSov+8K2LG7hs2vpijyL?=
 =?us-ascii?Q?nxKWb3D8M/MhDDAN0a5Pvyg1IvGcGRqHuOWXYYAltRBs1f2XBQqmMq9QUedo?=
 =?us-ascii?Q?6uZUWUJWc3PZDRt6xzyPmggFjCmenvDjqPeosMR/P2gupI4mzap7RxGfpl7k?=
 =?us-ascii?Q?qG4KXYCX7BCedeghHeHNHhvWAczNWleIKeXK68RSjPewpSH830jthi8/9tj1?=
 =?us-ascii?Q?vQYwCY9BytlN1zCgYNDsa/wPv35ZGkCpd+GmUN7LJ9tg9WgGIKsRrVVowxzi?=
 =?us-ascii?Q?mkGqVn9huJUyU2t9IwBH63VxUaEmKkeOjX8LG7UP2eO+TF8qkWIdBISGnfrE?=
 =?us-ascii?Q?W0I6T+5tlHTEv1ZjYl+udQKA0FH0NxLaUPzYIIyLngnrQjTWEbbxlM9uVX8P?=
 =?us-ascii?Q?46uT30F4ObIyF8BWxzds3ggOPRWCxFpkZvIXv1UHy24AQqAgnksY5fpWQ494?=
 =?us-ascii?Q?h0R8AtdhtC11cIEZ7x/uEX7WmaBi1N7zcwRl9Z5lV7zfXzhj/3gOCr/h7OOw?=
 =?us-ascii?Q?+Lk6UBjrKhZU/rkK5twN91bY93y9JX795Uv+cSRpGbSVMWekvF77GzGhRpKa?=
 =?us-ascii?Q?Gzfd6tQiDaQuNOFlR8wF4yteP1EqA3f0D87wU4qyC1liDJAQGWOgIpc8968W?=
 =?us-ascii?Q?sX+gUlr8/BURnNJhpm8aXY367dC835K76y4pwxKZsfn87HApRwSkRb3tFRuk?=
 =?us-ascii?Q?EXnI7yH/tTedxkcnG0W/sh4pxA06UrITgJdK9dVaTslUx+7CI2DerARwhXL3?=
 =?us-ascii?Q?s5m1SwPRjPllbiKi3YAsP8l6I91v58kSmAo4mNrB0IcYMPOHG0mvQBCpEqBg?=
 =?us-ascii?Q?mmGujMbhyuy2o+H72ESPpzL1KXhFIUqTT3JGh7OojxK+luOhKrCyNgANNTjX?=
 =?us-ascii?Q?vpxpq5PtoL0F2psn6RBiHVL9ehzsI4ks64229TEqIf5QtRUrgY/nODySre57?=
 =?us-ascii?Q?NQHdvuIxauoaAPgPaTIricM59C0t6Tndjs7inm9LAIDglEGVK96xRNqmLL4G?=
 =?us-ascii?Q?9aOb/YGJ43sp9jq2tsRsUslV0KPimXhaCo2cIEU7V9uzeJ8m24c0RFDSD1Xn?=
 =?us-ascii?Q?COArRq7RJG02k/72RfPwaHsr8RlG9kLppC9cd/ZXHADI5SAxbg+G+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(1800799024)(36860700013)(82310400026)(14060799003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:35:54.7211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b26d9a3-a76d-4f61-6593-08dd51037b0f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6348
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

> Subject: [PATCH] config/arm: update NVIDIA BlueField-3 configuration
>=20
> ARM configuration requires explicit `mcpu` specifications in the implemen=
tor
> description.
>=20
> The patch adds `mcpu` and `flags` description for the NVIDIA
> BlueField-3 configuration.
>=20
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> ---
>  config/arm/meson.build | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/config/arm/meson.build b/config/arm/meson.build index
> 5302861e2c..74f4dd4e1f 100644
> --- a/config/arm/meson.build
> +++ b/config/arm/meson.build
> @@ -85,6 +85,11 @@ part_number_config_arm =3D {
>      },
>      '0xd42': {
>          'march': 'armv8.4-a',
> +        'mcpu' : 'cortex-a78ae',
> +        'flags': [
> +            ['RTE_MAX_LCORE', 16],
> +            ['RTE_MAX_NUMA_NODES', 1]
> +        ],
>      },
>      '0xd49': {
>          'mcpu': 'neoverse-n2',
> --
> 2.45.2

Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

