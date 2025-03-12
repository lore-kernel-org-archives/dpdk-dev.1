Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDB4C28B2E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 19:47:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C38B340DCD;
	Wed, 12 Mar 2025 20:47:15 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
 by mails.dpdk.org (Postfix) with ESMTP id 5D21240663
 for <dev@dpdk.org>; Wed, 12 Mar 2025 20:47:14 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dyCTzju5LPTBhxOfIstoX6xcm4yg97BjTVQMU0PKTkuy56Sru2+7LHBoWmIWYmYTU3QAC6F9DyDIELdmBs/WxiaAsvXuIWhcI9KLP4LD9+/aRzMlvJ8riyPufncxDWJGXKcguvBPZalFjWBLxqhfl1ILsrd5CHF77hGuQPjpKCYoiQHycIrmgHHK1C/nHkaIIA8xocDHMpjgNccCNCMq71zr5GXWupqjJMPdwW6+xOdj0N3tNQVDAagxwidB957JUQ5HyhqFT/LmCFKiee4eNROEmegY4R41JeRDPPt/ObvJJ++T+TVhrS92XEFtZZESuytayQImhm/hg4YH+cIjHQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAmYkOduPnhPuNGSSCcwyyedxxjqf4Je2N56mhrpzBU=;
 b=nnC9+F7wabnw3C1z63n095jRNJjIjem7j8LB0az6wBD6LxGNNALhE3s9owyKvixuE8VcNy2aWNUj2DLedbpxEPk+K5HSR4n+8UySJMwgPGKmvg1xuCgUFm1fA8IwoBMJs24ZyEsYgYX4ZINtaJ3CddWJgGz7oqyk0Zg4BDQRMyi9Xd7P2Rn4NwGZKbD2VVfz9dZ1+1NbyvI3AotiXIh7rqYh1/VZMYTY9BrNHqau9w+GeTUGf0DS9tbd7HFpSeLWtNsFEHU1R8TeeNShxuHUxO5vgo1omz1ANGk2z9qPiSf17Rb3Xl9iQoz0aktbPnwJMOL8zmuxpLIc5+UMre52Ng==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=dpdk.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAmYkOduPnhPuNGSSCcwyyedxxjqf4Je2N56mhrpzBU=;
 b=Fz06+S6h1OePWE0qyh+gBjrZECGMftcHhJ4GrS9ShBV70iwHP/Wz4tAjYb+dFeWrTZUTTPPEWhXsXoT+Ep1WUJtyEs14rPW2yS0LD67sOxiiuFkTPpwKfOVOhVBL6Xqxa2VKySOLMJeJaF/o+zT0Bf8hWPxL62qPnqphfKBZDvI=
Received: from CWLP265CA0397.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d6::6)
 by DU4PR08MB10912.eurprd08.prod.outlook.com (2603:10a6:10:574::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.29; Wed, 12 Mar
 2025 19:47:11 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:400:1d6:cafe::86) by CWLP265CA0397.outlook.office365.com
 (2603:10a6:400:1d6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.28 via Frontend Transport; Wed,
 12 Mar 2025 19:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Wed, 12 Mar 2025 19:47:09 +0000
Received: ("Tessian outbound a8709f866bc0:v585");
 Wed, 12 Mar 2025 19:47:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4e5f271b7de76207
X-TessianGatewayMetadata: nJbu0a7+8EoBeaTaQLwVs1AusQGiSQ+so2hL902MQY+ZPmXdrbxA2dvDtNNIQ2cMZwMBkSyeAGe3ANC5fFNO3K4n2Tuw9d9I+QlrZAXiRe/OZ1lcsQ7PwG+qvlYiibiYRz6ofRt7xut/wKZPIKek9/AP0rvyGd1I/H9vcUMWoHTQnxFmRWCywFTlR12s10wLS8OBFvoZqB10MVhcFzB4dA==
X-CR-MTA-TID: 64aa7808
Received: from L752cb298aabc.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 677EDE52-20DC-4215-8D76-E26195377018.1; 
 Wed, 12 Mar 2025 19:47:01 +0000
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 L752cb298aabc.1 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 12 Mar 2025 19:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJHhqJ6ndQlirv1SireghnlmSfZrnMMmnC19UdLjEklO1kFxoEXLZ0/Z7u23t+Yw64cZTG5aoIynzNcirkTf/VuGKF8LD/ru10vkwy9d4AV/a8E4yC34snqYDgB2w7bwSHY6Lqgg5Q133lru9CNBScvvIVx+jIbrlF5nQEGi4JbZr10/x0vy3k2t3c13Ue2B8E0Ad/6z22senthY3oUgoFSMLB+EfvV+ewoEH2dB1CPlwZosMlxpM5k2oU1cY5UEe+Mp/Bb0XoU/1xp/ujRHroTyVlSo1BJ1VS2cHocBaTe+Get3fS/Nh4oEnRfeHqoaAmRofl9HA5rM/YehhE97Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAmYkOduPnhPuNGSSCcwyyedxxjqf4Je2N56mhrpzBU=;
 b=qiylZaJjEAf7macZHrwOH/yxewMHC6E9gzXIeyjISwIKvRBId/1d2xHhskKYAdAIDb20uPKSF2jgSuFa1kRfKckwlDPg8qCbPPiEX6+2bISAhrYIxAn1fi9YzgRPX2yttb4gyIOd5yHfcL/NC8nf7V/6J9Y+p6qVJSncIe8/vyE3wHz5NzHz31QIepq+6PWqkfeza3qc8HV/5wKZsXU8gVIfdWgM6lgF8EMX5BRJpPhWBQfxVVn37smgwgc+EYQaSolMli1IOtMSorgmIpVNtsqnC5u63yGrrSzhQSoX/hRcZdDe3APV8oPHB5H7FpP2Mxdm+wsjHQYPAjmmb6QSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAmYkOduPnhPuNGSSCcwyyedxxjqf4Je2N56mhrpzBU=;
 b=Fz06+S6h1OePWE0qyh+gBjrZECGMftcHhJ4GrS9ShBV70iwHP/Wz4tAjYb+dFeWrTZUTTPPEWhXsXoT+Ep1WUJtyEs14rPW2yS0LD67sOxiiuFkTPpwKfOVOhVBL6Xqxa2VKySOLMJeJaF/o+zT0Bf8hWPxL62qPnqphfKBZDvI=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by DU0PR08MB9727.eurprd08.prod.outlook.com (2603:10a6:10:445::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 19:46:59 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 19:46:59 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: "pbhagavatula@marvell.com" <pbhagavatula@marvell.com>,
 "jerinj@marvell.com" <jerinj@marvell.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>
Subject: RE: [PATCH] config/arm: fix march features not being set
Thread-Topic: [PATCH] config/arm: fix march features not being set
Thread-Index: AQHbkAheiMAivK1++UK2KEUhH14UkrNv7Irw
Date: Wed, 12 Mar 2025 19:46:58 +0000
Message-ID: <PAWPR08MB89099D7C522EFE6681BBA2EE9FD02@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250308085902.4383-1-pbhagavatula@marvell.com>
In-Reply-To: <20250308085902.4383-1-pbhagavatula@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|DU0PR08MB9727:EE_|AMS0EPF000001A7:EE_|DU4PR08MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: e6cb4491-a449-4d18-8247-08dd619eacff
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?6bEFbIvhehWWdlZ4rUcqRrayozNU2nHyeid64BLj02EVYbYn1rAuordZE9RI?=
 =?us-ascii?Q?eWuHkW7+hX4bJ0Pl1g5eF7e8/hfNXkTkw1FoX5sgGBhVY7rOR7gL3cWb7nQ/?=
 =?us-ascii?Q?73+MRSBAIF8arxe5F4qPwdSdTvFbRj7UxSyMWw7d3ixdHakLw/YU6XVbh2Sz?=
 =?us-ascii?Q?k+lHDFrBemY7xAgQzMplOgpZHViUIlDrJUr4dnjSDIs8ah3zxAA1uz2pDY3v?=
 =?us-ascii?Q?2K2pUnzpGbUBgV7GLZHANs/kqhzz4QyfsDglDuMF36dWu3yW6tOs7El8NaYL?=
 =?us-ascii?Q?2QC+IALTaDYEDfslLc6KlMbpMc8Wr34ELHMZ3bNGWm6kmiXOC9cFz+qW4bzC?=
 =?us-ascii?Q?tC1JYI6eOwzNMPk3xlDXZOQMIa/JbnbfEjH/2oUwfoAztwy0wMGx1x9TF15S?=
 =?us-ascii?Q?FChCHl8LkDFgp8bWY+jS/aNY5JGJthYEEW0w74/risO7tSJxz4sBo4f38vS8?=
 =?us-ascii?Q?EMN6lays00N23h07MKh3NTRujVrpypvp+gSgMn5OU8fF8qVQpZ4ddgaM6381?=
 =?us-ascii?Q?w6vNNEYxZQErcdyBdlpuLcYR4KEpa+mw/b4sSX1/ewlUp0wgjv0ikaqtEaFj?=
 =?us-ascii?Q?fxYvkTZezTFfx4dmuzCsXxtACxrPEq8ZHbJQ+Wb/iwKoyjmjN1TIaWZY9/Kk?=
 =?us-ascii?Q?xHRDFU0SMhlo+NQzeNXgztC5NCoawy59DM5DGqi442OOO8m75716NsYiTn6k?=
 =?us-ascii?Q?iPhSKJzPi7MgdlCVqxiQcSTpExnatmMb7IKFfHmrt3+ph3GuVXOtYfnnkGFi?=
 =?us-ascii?Q?iuDunhn3C+wQrp+vxFAydl0JFh/wig435k4uAPlthEIzQz0tKAJlgO4vp3A6?=
 =?us-ascii?Q?cwlTSkgvUWu0XSqutZgyGS3bJjrrtdPIJKwkwNcHKKtbCw4+KbdR+brGumbt?=
 =?us-ascii?Q?8kINydE+Pi8n42az6acwI98Osa8j9bm33VrVOx17gusW5rUVN99b5+yLl6zO?=
 =?us-ascii?Q?LBdKjI/X4cNevgwNDaPmfklWq9UyEBj7m/F7PJ5E5pwwoB5/9BuTyO4UBgyO?=
 =?us-ascii?Q?jkSYVXMtJjOGWRXS+5yCDk20tjFdqy3pcFIclBKWUpNwYHsGXMQ32W1ioJ6U?=
 =?us-ascii?Q?HuJ6GKdd2MsspIpLkzl0HNXF716zwdYEeZmVk5pTR6jvOXnqxIZ/7U242Why?=
 =?us-ascii?Q?ZPE+odhqkPeV566TpTJX8GwzkN2hEveAxBlT2CyMcEA5BI8KyhAxdWR9V9Vx?=
 =?us-ascii?Q?frh9IRkzHre31FqxAKRIN0XHkegnIQ39rNzkBrug3qo5tr3SE2bJFg7enXso?=
 =?us-ascii?Q?rwhALS3ApZXbbcm9GYg4kdSBLyyY0PJij1vJNV9ucMSWZEadVSyxIaCopcR4?=
 =?us-ascii?Q?3l4bOVtavxhtemNSUgtrhsbvBYWtWBZ3pKli1BOS4pYE4BYVAhND9I9PFwlO?=
 =?us-ascii?Q?JKtpgB5gLag145MFqFtSAMG1YvoVdXXWzJyJEHOBAYEWLIJZyuWBuT1c7Bjs?=
 =?us-ascii?Q?sqmCaz+DdW7BARgdkyojuhUWd7odvPQ4?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9727
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:102:33a::19];
 domain=PAWPR08MB8909.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7b63dadb-65a1-48e6-60ed-08dd619ea6ee
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|376014|14060799003|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hhvcmxhayj9jjajE++NvRc8i6/DOllBy4N6Qs1ikylwdDtS5E4hQ9pVOQlpj?=
 =?us-ascii?Q?43hfdpRgHVFilvIoQdvmGqOBrk8nTaUhI8jd+AWC2vMnYPMUZZLkor8jbdVY?=
 =?us-ascii?Q?UIVrIxMPUNiP5oz1Wobq0mOcYwRput2zcwX5Y0aMnbq2F7y1WqYeH2ids8vc?=
 =?us-ascii?Q?R1bIBdy1nSJpmH9CT058UsWF+PcDMl1zo8wsVAW2zqAkJ+mEUtixPFaQRG+j?=
 =?us-ascii?Q?f8Y8DHiFAT9CqpqtpCNns2W8D2I2Vao42EtS9WGw8c8UCIGu/Z50JeOFUjp0?=
 =?us-ascii?Q?c8evhTtvXUSqOrgimfAhR6eZd/ZXkaEiUGR5Dv/9av7d/aoIzq9KWqtRdmwi?=
 =?us-ascii?Q?TDBxQK1F0DgPGNSQpdxs9FImqwwPz07j4mFnRCGaVRUp/+EQ0/brPimll5Kb?=
 =?us-ascii?Q?mMeGlUTrgUCDmhWPBpjzGSgOuEVjk2eKPE11ALf/l7HpVF6xwzVyft9rzcfe?=
 =?us-ascii?Q?yQYG8lC8s4zxMPlWeabraP9txTc7rzG02FEIhD3y+FboueJwMHXjmEd2papw?=
 =?us-ascii?Q?qddt5Gt56QEqI4XRGb/eNbx73CRK3zRlElZYfuEZN8JvQoyxra7hGaev2jQl?=
 =?us-ascii?Q?tYNMegsogsIinGZAss5mZIaCInOdGW83FARP7Saye/jLopRN0ExHabd45/wJ?=
 =?us-ascii?Q?OWGg2tPxHKdIEodPF/I5J5mOqzsPKZxjjmeFXpieEgsQzaP5mFcGODNW7ILk?=
 =?us-ascii?Q?JNUOh8L9+ZXumJax9n5Vtuz+u16dRR4bTBW3XAW399XfgI/VNURSjj8pdw9k?=
 =?us-ascii?Q?PmFGsCEG0TXFLlOcmd51PDGTm7d9IBBnWyEaMtAoK02jIoT8iBQvr3t0a5Z/?=
 =?us-ascii?Q?h2cd/yKvDp08l11E4dgdslgcZF0GHkie55gNIvbNn0rgVsgKyT0jzm0M17p8?=
 =?us-ascii?Q?dT68xyvnlFDQWPeNtMQPeY4u3N24hDLQVcalsEAySZRrg4BbomrDLMjVNBig?=
 =?us-ascii?Q?F0E/G7qwyBV5KYTR7D8xz3RCuJM1CuMQ/L+0EbqME2wstqnK23Y6V66ssvzY?=
 =?us-ascii?Q?xP3Ypz5aX+2MEGSeAeWuFjgJBQpPabAc7ZwslIu5nfHbMghnQtGKxuy+njEN?=
 =?us-ascii?Q?pxF7u+pEvxBKfgX1UGUzBQyxFT+z/QPB2xxj3mV3M/EkrwrwpI1/wtNghN3J?=
 =?us-ascii?Q?h4H5uy/pkZlvMadIpC40vzZV/oa2CigLIFQyTlyqM8NOxxSTpzEu2swMYMSX?=
 =?us-ascii?Q?2uar30E8aKVaIrxxphGUH4uMzsgQjw+1xGTz4CsX+GytjgzcpGVawc4n8QY5?=
 =?us-ascii?Q?jS0IempBsV0aPWRhZg+FwKNUnVeBw0z0KItUuVAaORqCdAZ6/rBi5EhMd6Jm?=
 =?us-ascii?Q?jCGLMml1/UVtCoGQKgJ/sfwbrXQYMCj+LBt7UrUxGuOXUXsr0TaBwL3U4PKF?=
 =?us-ascii?Q?w48FU7BbDZdCkDURB6hfo/wLJyj/FNb45wObBgyupTN9S3njwJBWTJkccOhV?=
 =?us-ascii?Q?61TdCCOYM/91R8Rb9ROjwEDGyLHZcuuBtrpuopLSfIg4YZgrzd/3iLaJn63B?=
 =?us-ascii?Q?U3xA7xhrMt4AQeU=3D?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(376014)(14060799003)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 19:47:09.0694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cb4491-a449-4d18-8247-08dd619eacff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10912
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

Hi Pavan,

I think this patch does the right thing. I have a minor comment on the
cc.has_argument you have added.

> ---
>  config/arm/meson.build | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/config/arm/meson.build b/config/arm/meson.build index
> dea329ceb7..7f85b088c9 100644
> --- a/config/arm/meson.build
> +++ b/config/arm/meson.build
> @@ -841,6 +841,7 @@ if update_flags
>          implementer_config =3D implementers[implementer_id]
>          part_number =3D soc_config['part_number']
>          soc_flags =3D soc_config.get('flags', [])
> +        extra_features =3D soc_config.get('extra_march_features', [])
>          if not soc_config.get('numa', true)
>              has_libnuma =3D false
>          endif
> @@ -909,11 +910,15 @@ if update_flags
>          machine_args +=3D march
>      else
>          candidate_mcpu =3D '-mcpu=3D' + mcpu
> -        if (cc.has_argument(candidate_mcpu))
> -            machine_args +=3D candidate_mcpu
> -        else
> +        if not cc.has_argument(candidate_mcpu)

This is the else block of cc.has_argument, why is it checked again?=20

>              error('Compiler does not support -mcpu=3D@0@.'.format(mcpu))
>          endif
> +        foreach flag: extra_features
> +            if cc.has_argument('+'.join([candidate_mcpu, flag]))
> +                candidate_mcpu =3D '+'.join([candidate_mcpu, flag])
> +            endif
> +        endforeach
> +        machine_args +=3D candidate_mcpu

Looks good to me.

Thanks.

--wathsala


