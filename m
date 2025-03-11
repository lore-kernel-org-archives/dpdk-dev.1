Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF66C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 19:45:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E32C4025A;
	Tue, 11 Mar 2025 20:45:19 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
 by mails.dpdk.org (Postfix) with ESMTP id DBD794014F
 for <dev@dpdk.org>; Tue, 11 Mar 2025 20:45:17 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Qtif7t1Cl5jPQydApiaaKrqFoYcnYspV9P/Xl9jkP0mwZgZWJrEXp5dloBkFXA9omynPueMTCEUmJ71Ovx9uQQyPzOaIIAo+YXP/2nlW8M32ZlrxjjYzoMg6VxcSOhhNyVP20nSxwfaTj9D2oaa1PTLrynQSh8iojCsXicILXARxoRs30tG8qpKKqfG5xuXfV9WQMDxOKfy2sgDrhKzQV2sh6XxsdZ4FHZcBGoPySjfSXTidTm4oPRubRIWyTeOLaPnnfbTjRKYP+9DdcnxDJIFrSM0ukMvEMGGTFt+z7VMdsB/KlAF0tgQ4P3egDjMv51bojaRQBpgQ5RyrHtWacA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtseVjJ2PJEy/DHYO7C6h/FxEzWTETfoeIzxoAQ4dSw=;
 b=RZUFOnSw75PTr+rIdLm1NsJ3CEQ1IStEIm9r95+RMQ0SFeyL4NYo/8lETfjcc+I+nS2XueDuLQsdI+OX5uLJdgrOdczl2qyPBl/3f6FKR6dx6MGQocfyssisXAahDvdIwRj+1OmVLgERuFm9Wg4XeuDdIiP3ZX4Tqrc8qKxZTgr/KVTkYf+ahLSRmEJ31RaFGI/exQ0w//oMV3NoGRAQrW+4DPicGl/uqJSpEKJ7n0blWbxSmO+oYFR1H1SugrGV2ixRp5E+MUfjSOkDP3pCoXKXMrjXdmS1wm8nJTMCqPFz5fCMHFQ6Z9qyczYbYc9Ff9wgAA408GSc9ndNw2ar4w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=dpdk.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtseVjJ2PJEy/DHYO7C6h/FxEzWTETfoeIzxoAQ4dSw=;
 b=hXCQeF0uVevLIXSPl6MhahqeX10nuqcEWZofYSq95bc2LmznHRbUD67NYwAnAlW2IqrFYgSyr0CzoIUzZGD6aLiu05iU6ynApdGVBGxTL4WHJwJ+9JOqZ5piJ28NZnciWa2p9K22wVxYNpQXpw1HH/ZJMJV4tXfp0FSF7azuw+k=
Received: from AM4PR07CA0001.eurprd07.prod.outlook.com (2603:10a6:205:1::14)
 by PAVPR08MB9746.eurprd08.prod.outlook.com (2603:10a6:102:31d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:10 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:205:1:cafe::dd) by AM4PR07CA0001.outlook.office365.com
 (2603:10a6:205:1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.7 via Frontend Transport; Tue,
 11 Mar 2025 19:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Tue, 11 Mar 2025 19:45:10 +0000
Received: ("Tessian outbound ae00a21450c4:v585");
 Tue, 11 Mar 2025 19:45:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0432a0a6c2884d7a
X-TessianGatewayMetadata: +ioqwFMN1/ICzf3lUk8KGyYLmkaXw3x31f7c7ONdCQF+3lL7BeMnbyZTBQ9LcsOkDT/DF8MUYcK8nrUa3Hz6I1R9Nol6RJ/jaw3P7Fvkn1Y0195r7aD8cjncu97niVwNvwXBHxXbsmRsVnlxstJts1+RLG96O+7rGYuuYfmk5m2QGUy53nHL5SA8pmtPMCg3Z0WXgRvEvgjg0LhLaGBS7g==
X-CR-MTA-TID: 64aa7808
Received: from Lc0c733ec491b.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 ACE28A35-16BB-4121-8FA5-806A9E176C36.1; 
 Tue, 11 Mar 2025 19:44:59 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 Lc0c733ec491b.1 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 11 Mar 2025 19:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxiHu5pNftqyUW79saHiFp3t5RokxLrxzWTxd1K2rOnEETbjJhETN538U20CcbXvFHhX7KbKKdtLZLmCVtYixab9oWpud2NkxMSQPzSy1Jj/ZUfH+1ZStP63luc1+Dp7RrTVFW7mg+Ct1Rp8M8kvlUS34pZLG1rRSodzJrfrw8wsixrH8RYGxL5V82xH00f67dszfwoG1B3yi608gkE0JDDB3lGHPTeLEBQL5UhyIQdTcYiRfs1rrKTgLwtNar8Kb97VOJHJi6GEP93ywEO+GT1tLKB0+X3ockUMpsdspEFXXq1QC2XxfzDSn1epkTbQwcMk6JEB39tiMe6qCINnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtseVjJ2PJEy/DHYO7C6h/FxEzWTETfoeIzxoAQ4dSw=;
 b=nopURA41sr5AHbI1DnQmGH7h4Re/eVxHXaRxgP4i21yq15ldm3gER5uS0Zf7zDz/hqvG0iBs2cvEqUDaCLrC+cT8AN2VJ51sILA54mB4w5TEQj4s9q0eXKd+Etp0yP2DqQtD4MSZ1vQrqUlokJ6QTM6ZJZ+3wOewbkDkXazfyw2Dw2/cOftA3RGFrwifEeHApkBnRIqGnZ6mH7TITF36UDGjjfoH2ckwMe2y13FyBClMeaLZqQ5bodx+gz/ERIaFwqmRYXss0N08xq4y84wqp5XBm6poc94ZKty52/ezQ9h6fun45p2VzxVBXy1gwIFITyQtUoprjPo0v97z/oS8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtseVjJ2PJEy/DHYO7C6h/FxEzWTETfoeIzxoAQ4dSw=;
 b=hXCQeF0uVevLIXSPl6MhahqeX10nuqcEWZofYSq95bc2LmznHRbUD67NYwAnAlW2IqrFYgSyr0CzoIUzZGD6aLiu05iU6ynApdGVBGxTL4WHJwJ+9JOqZ5piJ28NZnciWa2p9K22wVxYNpQXpw1HH/ZJMJV4tXfp0FSF7azuw+k=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by PAWPR08MB10092.eurprd08.prod.outlook.com (2603:10a6:102:369::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:44:53 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 19:44:53 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: "jerinj@marvell.com" <jerinj@marvell.com>, Pavan Nikhilesh Bhagavatula
 <pbhagavatula@marvell.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Pavan Nikhilesh Bhagavatula
 <pbhagavatula@marvell.com>, "thomas@monjalon.net" <thomas@monjalon.net>,
 Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH] config/arm: fix march features not being set
Thread-Topic: [PATCH] config/arm: fix march features not being set
Thread-Index: AQHbkAheiMAivK1++UK2KEUhH14UkrNsb+mAgAHr4zA=
Date: Tue, 11 Mar 2025 19:44:53 +0000
Message-ID: <PAWPR08MB89090328B8F3D2F4FC653C429FD12@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250308085902.4383-1-pbhagavatula@marvell.com>
 <BY3PR18MB4785BC97AD137F9FFFACAABDC8D62@BY3PR18MB4785.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB4785BC97AD137F9FFFACAABDC8D62@BY3PR18MB4785.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|PAWPR08MB10092:EE_|AM3PEPF00009BA2:EE_|PAVPR08MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 4167d36c-4f56-4030-d4ac-08dd60d53bd2
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?Yv5f3R5jbvO5ffuBAzEs6n1YFzvs40ODkHj44W/Wcymd9f/POw2+7i+PRRtA?=
 =?us-ascii?Q?T+D0QKDbjTFZlW/44zqDcvU536lyQwxTNMPlV8XddXZa553lbyn+xq9HVBTG?=
 =?us-ascii?Q?Kcs0lt1qXarSZnPbdTenbnnm38kScR4oufAc8bxKaTkfpD7Tisz0fl3BtZck?=
 =?us-ascii?Q?WqeGxzA3JCKD0E48yCeqbtFU2k2BX2+8XhbWUBvcUm2IDbdufT5Q5UY+LeW1?=
 =?us-ascii?Q?ZrL1XFMLcMUc/YpNWGQs/3EdUeOtEeHhXtT24s8X5Ik/x9JTT+MZ/zoBfVvm?=
 =?us-ascii?Q?XurglGfRwAkuWZHICpC2zeMMv2pNc3e/w4eeRmBZjrl26oNFqpiNlME59leK?=
 =?us-ascii?Q?t14rGolUc4gPWuMa7I1apddFv47G9c4UbTWIHOQEWA3SQjO71cPxRJ/oyn2/?=
 =?us-ascii?Q?iGs3Oj0yhSeBpD1voBYGhKFxUXq9+suUUTz3kZGo5VvoQXM/ZcLrQWqSqFXz?=
 =?us-ascii?Q?eolGnS6M5N1Y0ASIpv3AALG0KseKfFYpX/t0r6kYbn0nL1l50ciqRi8uN4A6?=
 =?us-ascii?Q?DRW2Z/G0vCFT0uGu6y+PFtksILsTphbMs1ipvLk4KKsLAh10AgU2vKMmYSE3?=
 =?us-ascii?Q?kYp06K6PllkrdP3ZLomYni3xL+wbvzv2OPYuAUtJIDqDMw8TKqgoD+mhmaxe?=
 =?us-ascii?Q?G+7DFV9G5zK7DI5xJSG10/sgtbSW01jBnsVw4KlzWfQ2+fSaDV2yTdhExl3V?=
 =?us-ascii?Q?QjsgCv1AYtRI756Ard6z5KIbf2WLvoLtWioW4OjO9CiJl5O824XakoWd5+k6?=
 =?us-ascii?Q?uq0Q/umZx0OaRZ5fzL3Sx9Wd2+7fX6aeWhzCW+9XEXhgICaE5td33piTjD6b?=
 =?us-ascii?Q?Mid26SMsH+4EiMSvRQLQq4ZSIPtyfbrPCS99zkVPbbBgMKA80xIIoyI59r7w?=
 =?us-ascii?Q?uh/6duRIYU0sKF8nzs32v/fb4QwupmxqDVmS3qjw3474EB8kV4Ve+DoM9Gm+?=
 =?us-ascii?Q?4ZfMUubFi+KJ1Zgs1h3mUCjka+S2Lj2DnTO60v74/t1SCW1JzaJlA+WT0I3y?=
 =?us-ascii?Q?Os4yRVE1rxbvlymxLt2Y7tJ3EI1aaZP2TvzmfD1PBVoGn1XinHKORREUasGS?=
 =?us-ascii?Q?3e9pzfoJCHVUwPFGKMI26Kx+ok2SBbb34SZmtYHfHcdoS5vRnLgsi0tJkuuN?=
 =?us-ascii?Q?Bc/KncZYLGZvh1aJG1XNQ4Pgs4LsDJFmpgN7CfezE/ic8eJMk253jRJiZ9Xc?=
 =?us-ascii?Q?XDlFjhdmbI1QbcxE/bHNByk/tYhuwqYtmAGT4R3DoUEYSAbB0hbLwSGMQLzk?=
 =?us-ascii?Q?6qttsDMTvOaUdAEmeH3CBgVogEcVVkcI4eKepd84e8nUCf6vs4+DQwh59qHL?=
 =?us-ascii?Q?9BaIl1Zv1WM5m4OtQBvJLSkrtRKw1aFbZASeafrRdeAvrkkF3wLxEU9AKpJ9?=
 =?us-ascii?Q?wwmybaYy/Fno51g6T8YDF+J0STOsh/xrWVwXk+XzJ7NeJ/Qeb03q1Js50zhH?=
 =?us-ascii?Q?CSHV7kWa+dRHVlqmt8PTulYFg7/VdAbQ?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10092
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:102:33a::19];
 domain=PAWPR08MB8909.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ce08404d-c96c-44f3-397e-08dd60d531b2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|35042699022|14060799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wyzqnv0EfoQCs02yycfYlXAhYGcap1ZayjdGd0cYulGnnTaZC1WGDJy3icwx?=
 =?us-ascii?Q?zM/e+2LgBd/k/LAzLFzlK45NLB7I+UNGTW2zh4AGFZl+n4dgYoT9eNtK+ek+?=
 =?us-ascii?Q?9/quE1s9MK7Hil4nMIEEMM5fvpOdY/XeMMuE5c/Vtc4isFOqN2PhRrolr4QC?=
 =?us-ascii?Q?r4xaseNvAPp5bC9Z0rn7MeHbFoQiZ9r/bn7Bh1Fi5do0b+aRk3m1pI0FWMon?=
 =?us-ascii?Q?salIB/iL0QJiK+IptNBTUE92n5WGbZJzR/Ic8solCXKjsBchFVGjuXp7Gs4C?=
 =?us-ascii?Q?XcUzRJss68yLWhLr19pmb1FIcXyYo3Q4NsLXegTM5MO7rZfYWstELUc56u0m?=
 =?us-ascii?Q?WZYXH8nMO0NpJkLuz3rPKUOoPMqO8Rvj90pX5SYR+PwkjuVVcirQ5POZv2Xo?=
 =?us-ascii?Q?NE3FfC+18ug8bSCznNVejJqo70Lf1/MeQ3P+8kcsiGXz/9XOUpenM0Fl7FH5?=
 =?us-ascii?Q?7G87Zkv84BFEE0gmx/G76PuRellz55KxT1MLN+2aaPLsTnoP0pQKUWQjH9ZI?=
 =?us-ascii?Q?KrEb18ZxyoQp8S0CwN+7WVRxxFbiXvVcp35Uk87CdwC3oF4xIxmwII4WFZH/?=
 =?us-ascii?Q?bWJOrpHaN3ewaFPOya6R4UQWBBvxYypQBvA2Ui4AKml8wya/LtOBkWKm3uYA?=
 =?us-ascii?Q?h9RCMlVYfahUXR4SEVodTKWVbTyXoT4sIqMnKqi9Z7acWPg3Qjl5hsG9SWhH?=
 =?us-ascii?Q?z2pW/1AyDOX+oCTqCBRb9GzHaEdRNPM39NJIRwvyksfVHxnf3LvHkW2catZ2?=
 =?us-ascii?Q?yNS1zigEIDN1VZcrbjhqhEtRU7PjNFPc8ddcH1WXp//r38wBD6zIZhro0l7c?=
 =?us-ascii?Q?PV1F5g5lncYrnBtCrrRCKSykiYfrXYXWdseEK9lNZkkq2Yfnhea4S/tELsD7?=
 =?us-ascii?Q?CjZ9PR2jwokhelZFBoHCS1tp0OQgS6EtFXIzpGWXnO91JmLRaz4syPs0cB9H?=
 =?us-ascii?Q?nHuFCFMijUCUZBA8k4G4suAjqBtblIqFVVJwYc6IYVGgaw9eRGXNlojRxDPB?=
 =?us-ascii?Q?xRBNMn3UMtprvpnUqLVGcvyLETWDAbz6Atcgc7jvG1XBf578YgfjQA9xAtA3?=
 =?us-ascii?Q?Lhb22/kxawtBu/T6I/lNpYOH3d7Uxfye2j6wP/gyXcbp/wE/OVHif+7U72HP?=
 =?us-ascii?Q?2JUymdNXr0LjOiDMAT6Uj2a2io2vuBJPogJlPgMlEbI5PD+WD24NvSj+Th+E?=
 =?us-ascii?Q?to5CdKdNzFLLuQBN/CUZMNvsuEdgyEOr/dyp19k2wIv1o+fTXayWdWIkJdCu?=
 =?us-ascii?Q?D0FmKdRYw5gIS/l+hU2woKIvx+KRP6aH50tRKftipPk89vt+Rr2cLmUeWCQP?=
 =?us-ascii?Q?Neq6F2RwMO0eItenDS5M1fNbDeEL3k0WyvENpJ/asfpcgBMuNFtlLbqIeAXk?=
 =?us-ascii?Q?n1SW3gfVunnlMhVumjU5XMI+Fz/YcvDVe+YfxSiMg/NgelPxSKf1ubycKNj/?=
 =?us-ascii?Q?kKJ/xkcc9LS9Pe0PdyDxj0aFdiGdRA9yjVF7u/kwI5urQKG9suf23naDM+lQ?=
 =?us-ascii?Q?Brt4sq3PW7w2sAY=3D?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(35042699022)(14060799003)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:10.3982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4167d36c-4f56-4030-d4ac-08dd60d53bd2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9746
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

Hi Jerin,

We are looking into this internally.=20

Thanks.

> -----Original Message-----
> From: Jerin Jacob <jerinj@marvell.com>
> Sent: Monday, March 10, 2025 9:23 AM
> To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>; Wathsala
> Wathawana Vithanage <wathsala.vithanage@arm.com>; Bruce Richardson
> <bruce.richardson@intel.com>
> Cc: dev@dpdk.org; Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>;
> thomas@monjalon.net; Honnappa Nagarahalli
> <Honnappa.Nagarahalli@arm.com>
> Subject: RE: [PATCH] config/arm: fix march features not being set
>=20
> > -----Original Message-----
> > From: pbhagavatula@marvell.com <pbhagavatula@marvell.com>
> > Sent: Saturday, March 8, 2025 2:29 PM
> > To: Jerin Jacob <jerinj@marvell.com>; Wathsala Vithanage
> > <wathsala.vithanage@arm.com>; Bruce Richardson
> > <bruce.richardson@intel.com>
> > Cc: dev@dpdk.org; Pavan Nikhilesh Bhagavatula
> > <pbhagavatula@marvell.com>
> > Subject: [PATCH] config/arm: fix march features not being set
> >
> > From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> >
> > Fix extra_march_features not being added to mcpu flags when SoC
> > configuration advertises them.
> >
> > Fixes: c02c01dbf907 ("config/arm: prefer strict use of -mcpu if
> > supported")
>=20
> Acked-by: Jerin Jacob <jerinj@marvell.com>
>=20
> Wathsala, Could you review this patch so that it can be part of rc3. Foll=
owing
> machines configs are broken
>=20
> [main]dell[dpdk.org] $ git grep -p extra_march_features
> config/arm/meson.build=3Dsoc_cn10k =3D {
> config/arm/meson.build:    'extra_march_features': ['crypto'],
> config/arm/meson.build=3Dsoc_grace =3D {
> config/arm/meson.build:    'extra_march_features': ['crypto'],
> config/arm/meson.build=3Dsoc_graviton3 =3D {
> config/arm/meson.build:    'extra_march_features': ['crypto'],
> config/arm/meson.build=3Dsoc_graviton4 =3D {
> config/arm/meson.build:    'extra_march_features': ['crypto'],
> config/arm/meson.build=3Dsoc_odyssey =3D {
> config/arm/meson.build:    'extra_march_features': ['crypto'],
