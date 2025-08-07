Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE05BC87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 19:56:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 047F740270;
	Thu,  7 Aug 2025 21:56:45 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013000.outbound.protection.outlook.com
 [40.107.162.0]) by mails.dpdk.org (Postfix) with ESMTP id 62EDC40150
 for <dev@dpdk.org>; Thu,  7 Aug 2025 21:56:43 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jgH9Jelmh2GbQGTcWUTuaKIkj53KoYP5rX76mdwdfspQQkaffTmFy8DAfPiMnmzvuDYaebcYYo4r77V7xVdSzEJCgwAWlnnNlV5abYjl0SZXoMSNwBgTZngjKS0Es2SFYMBPTOxZGiXiUI05EL6lK/FBvqu38HHzQGjHQn2Jvlws/7gimoHtcEE4ylLOYHfFoTNxDp/P/Ls+5rxieg53dYEAIuk9Yx+mRRyQlv3tDVKcPoXvGaT2HAr9Pv+cuooPx5VOThYNfIT1Zmmu1DnramXRZHqsfQmEEN+3HZy2dE40kh43NCcNWMmevMnxgMo6PBV1Ihz3VQZJMjwcyNlg9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K014KqH1RGVq73XI144B8j/6TJBg67/YZ628NhS2ljw=;
 b=buqWIcK3FEZCWcQdxViOCOuLxrJ4xhfwnDzX/xpuKPtwnK84oBvmuxN2AMS1TLn+/tLAJcr/NfuxeYlePlbK029pQgoTJKx5ui5NjoKQafyOjrQd+NXBMeVAhbfg9a9QSVr2AbLmHtoKFWSs4WaTy/qk555IERNBa5pjkHhD9W0Ii8wTz2ZF3BKTXJXtecHe14+QM6bi37YGF6s7bPYT2gHD7725bFI9ZJ/fLeCOA0hbheywrTR4htzOOLZVQDYyI/nYh6vEEuKZLKooC+zftWJm8ymzVplVXd1qPskr2XLjKE9ytE5omMC7awloLSw7pj0tblAZuPCRnMQEZB+NBg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K014KqH1RGVq73XI144B8j/6TJBg67/YZ628NhS2ljw=;
 b=Pr+OLUjnGleDOAIlYv7qhOcV/I6efRQtXn7/sYNjza9GQTcxGzwfT27QW3ZWzlvqZDxns4iLIf/PUKZOfiMnSw0sFz+AxiDcQhdufyjoDUTk0BAU4jxYAprxVLklQUlZibguf+ikQoPqRBOeYUrDRYUbFgmJgSkyI9xJO4eljGI=
Received: from AS9PR06CA0396.eurprd06.prod.outlook.com (2603:10a6:20b:461::9)
 by PA4PR08MB6304.eurprd08.prod.outlook.com (2603:10a6:102:e1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 19:56:40 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:20b:461:cafe::75) by AS9PR06CA0396.outlook.office365.com
 (2603:10a6:20b:461::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Thu,
 7 Aug 2025 19:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Thu, 7 Aug 2025 19:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZk1x1kYJcWbIzLU64ln60/sQU2oT6fdOeZJhUlr6wCJaalPO0pa9EVGUNKaivxxWBTh/Z5PQ1A0H5rUZa3JFFfLwrSWXZskIn9mUipnTgYB8Exqt+RGGY8erbcrr9lxCaECfNimTVYxWxsw4wb8VgUSR7nvV23jN4uOnJHYI9QnG/O6e4R1oRvoOaiaIMjzoF8S+ZgLWnkOng/cmMXyAg92Af1P2v9xWhCtEXj4rOgzlXi0WDN0nrV51Qk3ZPf8XUViVSguZAraRiSsiLqy1t247Undg9KdxJ299jQT+Mned0BwfLRVkLtMWPjMPpgbbWUxKxo3sj9eU9qCPG6lKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K014KqH1RGVq73XI144B8j/6TJBg67/YZ628NhS2ljw=;
 b=pmr70U+AymW6giGQedLFDn1TtYLD9Up7fvCGK9Qj4EvDdMYsNjEmscuaDYhnecHx/Pu6/eJ552AXhO8ZsXRe/XU5qKJ/GooEIxzsEArBTtjjUieyJwL8YLpriI/DBCzcqjlIemca8LaQHjfhnEAsaTUFm7xmkQwdU0Y8A3LWACr6Y4DAgYP3I87MGClZwG+Vljs/WZhnlDGBYykXGIFRbuR8uX6LEFkQQUGsbjifURgNABu91gPoMF9zVTk4BR+LS6awLBwETh1IaG2Sif4IZ7lxh6iSuMnfaOG9CAvoQRWq7YRKp4YWlf+Trb9H1YI/cNhzGJUCZJNmFeMaBiuhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K014KqH1RGVq73XI144B8j/6TJBg67/YZ628NhS2ljw=;
 b=Pr+OLUjnGleDOAIlYv7qhOcV/I6efRQtXn7/sYNjza9GQTcxGzwfT27QW3ZWzlvqZDxns4iLIf/PUKZOfiMnSw0sFz+AxiDcQhdufyjoDUTk0BAU4jxYAprxVLklQUlZibguf+ikQoPqRBOeYUrDRYUbFgmJgSkyI9xJO4eljGI=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by DU0PR08MB7616.eurprd08.prod.outlook.com (2603:10a6:10:320::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 19:56:05 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%6]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 19:56:05 +0000
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, Andre Muezerie <andremue@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
Thread-Topic: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
Thread-Index: AQHby3JyK1i7se7QvUm9nFLxthnwgLQdjtEAgA4qsoCAAXD3AIAEel+AgCZs4ZA=
Date: Thu, 7 Aug 2025 19:56:05 +0000
Message-ID: <PAWPR08MB890987187E300A80DC4FD36B9F2CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <1747957021-2581-1-git-send-email-andremue@linux.microsoft.com>
 <4620749.daG60p0z9X@thomas>
 <20250710143747.GA24344@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <5695570.h0BymrIErR@thomas> <b2f6bd8eda1c4e728caeb5ee918d0068@huawei.com>
In-Reply-To: <b2f6bd8eda1c4e728caeb5ee918d0068@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|DU0PR08MB7616:EE_|AMS0EPF00000192:EE_|PA4PR08MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: e0208db5-cef9-44c4-45c8-08ddd5ec8609
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Rjk1TUNSTTBNenN0SnpET3dCQ0dYUWovcEFOVmxsbGdUNldNajB2eVhRQTY5?=
 =?utf-8?B?ek5TUlBJSjZGU1ZUNlp4bFBFUG1aNWwvVE15K0FndjY4c3pmV0NNRlg4eENB?=
 =?utf-8?B?dmR0TVpwY0cyS3dya3h1OWVEWCtPRHB0NDh0aDEzUzF3dFFBeFRrUmJ0SVpq?=
 =?utf-8?B?bTFseDVBd0NudmZ6Z0I2VzRmNUY5UWs2cTFOS3BDRTRreWRMZmpJeUR1WHVk?=
 =?utf-8?B?T1dkVjBwbldlQmJUdGViM0Y4SWpRQzcxdzErQ1hpdWx3NTRWSDlFdE1iOFRi?=
 =?utf-8?B?VnY1UDhSblhLSTZNOXo4OXBXYTkvZ3ZoQ3VoWkJ4aSsrYmFaZ0tWeUZXUmZq?=
 =?utf-8?B?Q0JzTjUwRG80SU5WTWxzMUNjTk1aVURWTlg2VEdWeTVzNzFqMTZ1aEFIQ3VU?=
 =?utf-8?B?WUEzdHBJYWV2d1V6dG5jRWw1L25qaU1aRW1WNXJvMnFvRnVWcGF3TXkrUmRz?=
 =?utf-8?B?cmI0eUN2VGZHaUgzTzhib2psMFIvMW5DNE92aW15VVYvWkEvRHFiK3gzQXlT?=
 =?utf-8?B?clVSekMzcGxQT3pKRmF6Vll6NmxtMjg1SjRvdW1YNDh1VmI0Qno4S3NtcTBi?=
 =?utf-8?B?bllvK0JFUFVEdGRrVUZucEFSM0pQaThrUXIrRzhKWGxnV3RBKzBtRVltRWxH?=
 =?utf-8?B?aG4yM1VyKzNJNnFVcHBsS1pTMFNqcFFGR1hiVjZWcnRSR0x4ZmYrOVFqWDVE?=
 =?utf-8?B?b2JkSzU2RitmTWxPRmQzbkE1NFJvb1FqSEEyTVJ5YjVhcUN4eWVub1ZDK2lT?=
 =?utf-8?B?b2RiZ1N2bTRGY3h4ZW9SMHR6bnM5Q1dSUmJlZWRlYXNRRkxPV1BSOTQ0MFJL?=
 =?utf-8?B?c2RNdmdzaWNNTXJIcnZpZ1BrbE54RVhramx6RHR5NEI2dFlHYk90eUUzWUQy?=
 =?utf-8?B?S05oeml2bzl2U2JYY3A0TWU1UWFMK0VFUXN2dGtBZ2xhVlYvRDFaNk9GaGhC?=
 =?utf-8?B?NWNjZHd6cElHZ1BJV3ljbjJBUmh6NXdMLzduTElGZ2xFSmZUU2VRSWVJRldv?=
 =?utf-8?B?SG5SRFVSQlIwZGRNNStsajJQcklmYy9Ldk1wbjRUK0RJTzVKN05wT0ZFNDdp?=
 =?utf-8?B?aDBndW43WlgveG0xMFMxamgySlViUjlMdkJTaTY3dFc2WkZ2dkpib0JQdUhF?=
 =?utf-8?B?eE1xNGoyRGY0allxcyt1eHlDZUFORDgzb3d2aVZJWWlLdDRNNnIvQjRLMDcw?=
 =?utf-8?B?QWJCQy9qNm5VWUcvN0NEQnZndktpZ3JUc0lwcklkYTk4SHRPdGhqTC9ySnNB?=
 =?utf-8?B?ZXhMVktFSW9JbmFNUlBaVFh6UnRXWGszOEhxM3JaaTVzOGlZdzZBdG5OdEMx?=
 =?utf-8?B?dnVRM2xBdGNPaklyT2d2MTV2Nk43T0dCbzN1YWxkVE1yOFlkWWpoMTQ1d3hD?=
 =?utf-8?B?dlkzZ05QYTBYancrNjB6d3pxd0hEYzFMdTFFQUdNSms2TWs1dDJBMHdTSDhH?=
 =?utf-8?B?R2swTTAzTkpNdGNkS3JLL05rK2E0bFpWQmNlNkpDVE50TXpZVjVLQkVLQjVm?=
 =?utf-8?B?UkF0SVplV2JoK3R3OXU4N3Uzei9HVmVjNWt6b0F2ZlB4cXF3UDg4cnBPVnVM?=
 =?utf-8?B?QnNoZ3ZIcmxSQjhPdzA3WHFucFNlTFhQbkVFMTdTUlJ4NDFoVGlwY3VINWlM?=
 =?utf-8?B?UHhLUks0WmFTUkhLUHhBQ29UVk9aK3pqUkpDaDF6Z3dMQWMzcURSL0NNNWZU?=
 =?utf-8?B?LzkralRHd2ZZRVRGSkY2K3RjVjVXeHRERDdaVTdKSUdPeHhCQ0w2R0dlUjR6?=
 =?utf-8?B?a3FSMWtPWEs1UWtxL3lranB5b1hBQ25lcGpRR1psQnVONWd2bFZVOUpoVzA0?=
 =?utf-8?B?V2hZTWRkNzN3UlFwMGVLTk1iVHlDT08xZzBlUGFxc3d4bWJYdDU2L0E5QXBO?=
 =?utf-8?B?TVhQUDE2OEtSYnpMUldtc3hKTlFmT0YzODF3N0xjd1pQR1FncFQ3cE55Njky?=
 =?utf-8?B?YkNNREY3ajFmQWgrVEFTVDVKUlVVU05raTBmYmhna0s4NWJSeUNCTEJWTk1Y?=
 =?utf-8?B?TlhFbHV5Z3N3PT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7616
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3cef6b74-769c-42fa-a900-08ddd5ec71d9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|14060799003|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnNjLy8vQXkxdFk2czgvVTBFZzBIT3krR0JTQ1l0T1lJamxuZzRocXoraU1h?=
 =?utf-8?B?VG9DSlFLdS9OQjVDM0dhbkNuM1NodWx0TTAzek8zNzBrakgzT3UzVU1nR3pW?=
 =?utf-8?B?LzFsejRtYVBaM0hVeStWSUlGeXY1YUhUNS9Rb1prQm0vZHlnYUNnOUZKekUw?=
 =?utf-8?B?d2pyZHdhWlNvUENhSXhVek12UnFoeTJUbVZPdG9lalBtdDNCTzQ1NEMwTFpm?=
 =?utf-8?B?ZG9ReFVabmRGU2IrV2hreG5TeFZKWWlwazZBYVBDeXFNdHlVV3dJWHJhaGJR?=
 =?utf-8?B?blpKK2pRMGNHbnIzU3ArRTVjbjZUMXZDcFNyUFZuYmJqb040eU12T3I0anUw?=
 =?utf-8?B?d080YUYzZmtwTVBybVFwVG51bmsrL08yaW5CY0RvRlJGcWRUUUwxMjRBcVF5?=
 =?utf-8?B?VnJ1cGZZQkpUbWszSVkrT3Vsa3NVQzJZWGZUb0RBbXBUOGZKOVFTTXZqdEhi?=
 =?utf-8?B?QjU0TFgwb3FMbGpFZ0Zxdjlrb1Rva0lnZDYwNENudEVQWEhCeC9aMUk4T1BE?=
 =?utf-8?B?ZHlrYjdrcjNPblltODMySC9BY1pPZFFnUUV6KzVJNHJDV0VJZ1lCc2VhZGtG?=
 =?utf-8?B?b0d2YXFpelBHRnFMMEtWTVkwS3pzdHFaTFZYbG5vV2NkVURHT2lJdVk2R3lZ?=
 =?utf-8?B?MWVEQU9zWGwxbVJxbEg1dTFjQWxuL1FLemFybzc1TkF6eXNueXZ6RHd2ZHZD?=
 =?utf-8?B?RDU5Sk5MSHQrMWwveWVZUnMrRy9NbXhSZmd4Z0IxMWtKeVN6T2NEOWdBZ24r?=
 =?utf-8?B?aDFYSHBNQnR2WXRkRFBNcFJPTE5ZWGtMZUlyazQ2bWF2M1RRV2pGWmtFaVR0?=
 =?utf-8?B?NU5QT1oxOHdXZUZLUUozZ3RLTUl3VDVRd3BFVURzeDFqano2WGxUak1GL2Rq?=
 =?utf-8?B?MXZkcjhQRk5CYVpYYWNMY2RtVlFlcytsMnFMSVJLTUppZ0R2NS94SERTY1Na?=
 =?utf-8?B?M0YvNURxZTJtM1ZVS2RXcm44a0djZWxsZThzMmNjRmc3bk1XZE9lRFROWEE0?=
 =?utf-8?B?aTBDejVHZktqUDBmQkVHbC91VjJjRkxxSFZSbHRvVEM4VHA4YTNWd3RCb1hH?=
 =?utf-8?B?RnRQeUZqSUU0dkx4Q2xvQ3NiTXVlaXhIT0JQTEtwWjJ1TnR2enpDSUZNV0lB?=
 =?utf-8?B?OHdvd1lVdU1uVThXcUtTYUpWZlQ2ODg0SFh4M3FiZy9GS3RjUVQrdU9iR0Jo?=
 =?utf-8?B?b2k0ZTNwK0hLVjdpVFExVzEzL0w4TXlZNENUS0dBRHFxNDhDTUR3bHNQU3FQ?=
 =?utf-8?B?VkY4VTgzbXFsMHNoR0JyeEdHK0JxZlp5Z0Y2YTJlQzdubG5Odzdsa2lLNVgz?=
 =?utf-8?B?K2dHVWJIVUJQYTkzUlF6allmbm9Edk9PdE5oaEFlS093dmZ3Z2dsVXowUHRj?=
 =?utf-8?B?UVlIaUdVdmQxYnVpSWlvMkp1ZGR2eDIxS3ZHUnVBa3VzcGdLaDFPaEVqVzRw?=
 =?utf-8?B?bFZJNlRYNndXUkR3Tk9KMFFwQUhhNXZ3MTJNRHZtYVlrYjBZL3F0aWs2N0ZK?=
 =?utf-8?B?K0xteUJ5Sk5nSUN2YVRrbGtTeVNONXJXVEhOcVBDL1NKK0pWSnhpU0VNWkE0?=
 =?utf-8?B?Z01kNjYxTVp3VFdLOEJyMTBOVzJuTWltRzc1OXdxbEZRM0FoZ1MwQ0tkdXNZ?=
 =?utf-8?B?U00vVzBHUG9VOGFNWE12U01TOWtsaTVCbndNSkVSYzFmMm10dDJkNHpxeEFj?=
 =?utf-8?B?U01qeHVSKzBIUlY2Q2ZGR1V0ejh4WlFZNXhXaDV5aVB4enV5NVpZMHBlbUZK?=
 =?utf-8?B?eTA1L3h0NG5SRVBjaFZHM2NFMi82WG1rcDQ1N3dtQlFVRW11WjA4akRtV3RU?=
 =?utf-8?B?SzVsbFF6bGlTN2ZqMmUydFpsWUV5cGd2TmNHNFIyNkoyT2RIU3o3ZmFmc2J6?=
 =?utf-8?B?MzNnd1dVU2JzdWZWNXM3eHZyeUJmVk1MdXhUSjhUa21VODRiVWtMSHNFaXJn?=
 =?utf-8?B?N3grZGkvdUlwZlA0Smw5N3NWMUZ0MFFIYVhQRlc4RjZpQndIRkRDbUVRNUo4?=
 =?utf-8?B?RmY2V0ZYVmVoaTRwbUxnYy8zbnBueGg5TW5NT2FSMWgybFRteWhERHNxazhO?=
 =?utf-8?Q?s0J432?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(14060799003)(1800799024)(35042699022);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 19:56:39.3185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0208db5-cef9-44c4-45c8-08ddd5ec8609
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6304
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

PiA+DQo+ID4gMTAvMDcvMjAyNSAxNjozNywgQW5kcmUgTXVlemVyaWU6DQo+ID4gPiBPbiBUdWUs
IEp1bCAwMSwgMjAyNSBhdCAwNDoxNzoyMFBNICswMjAwLCBUaG9tYXMgTW9uamFsb24gd3JvdGU6
DQo+ID4gPiA+IDIzLzA1LzIwMjUgMDE6MzcsIEFuZHJlIE11ZXplcmllOg0KPiA+ID4gPiA+IFRo
ZSBmdW5jdGlvbnMgcnRlX3JjdV9xc2JyX2RxX2NyZWF0ZSBhbmQgcnRlX3JjdV9xc2JyX2RxX3Jl
Y2xhaW0NCj4gPiA+ID4gPiBlc3RhYmxpc2ggbm8gbGltaXQgb24gdGhlIHNpemUgb2YgZWFjaCBl
bGVtZW50IGluIHRoZSBkZWZlciBxdWV1ZS4NCj4gPiA+ID4NCj4gPiA+ID4gVmVyeSBnb29kLCB3
ZSBuZWVkIG1vcmUgdW5saW1pdGVkIEFQSSBpbiBEUERLLg0KPiA+ID4gPg0KPiA+ID4gPiA+IFdp
dGggRFBESyAyNS4xMSBhIGhhcmQgbGltaXQgd2lsbCBiZSBzZXQgKGBgUlRFX1FTQlJfRVNJWkVf
TUFYYGApLg0KPiA+ID4gPg0KPiA+ID4gPiBJIHRoaW5rIGl0IGlzIGEgc3RlcCBpbiB0aGUgd3Jv
bmcgZGlyZWN0aW9uLg0KPiA+ID4gPiBJIHByZWZlciBoYXZpbmcgbm8gbGltaXQuDQo+ID4gPiA+
DQo+ID4gPiA+ID4gVGhpcyB3aWxsIGFsbG93IGZpeGVkIEMgYXJyYXlzIHRvIGJlIHVzZWQgaW4g
dGhlIGZ1bmN0aW9ucycNCj4gPiA+ID4gPiBpbXBsZW1lbnRhdGlvbnMsIGF2b2lkaW5nIFZMQXMg
YW5kIHVzZSBvZiBhbGxvY2EoKS4NCj4gPiA+ID4NCj4gPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5k
IHRoaXMganVzdGlmaWNhdGlvbi4NCj4gPiA+ID4gV2h5IHRyeWluZyB0byByZW1vdmUgdGhlIDIg
YWxsb2NhKCkgaW4gdGhlIGxpYiBSQ1U/DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gT25seSBiZWNh
dXNlIG90aGVyIGRldmVsb3BlciBleHByZXNzZWQgY29uY2VybnMgdGhhdCB1c2luZyBhbGxvY2Eo
KQ0KPiA+ID4gYWxsb3dzIGlsbC1pbnRlbmRlZCBjYWxsZXJzIHRvIGNhdXNlIGEgc3RhY2sgb3Zl
cmZsb3cuDQo+ID4gPiBJIHBlcnNvbmFsbHkgYWxzbyBwcmVmZXIgdG8gaGF2ZSBubyBoYXJkY29k
ZWQgbGltaXRzLg0KPiA+DQo+ID4gWWVzIEkgdm90ZSBmb3Iga2VlcGluZyBhbGxvY2EoKS4NCj4g
Pg0KPiANCj4gUHJvYmFibHkgaXQgd2FzIG1lIHdobyBleHByZXNzZWQgc29tZSBjb25jZXJucywg
c29ycnkgZm9yIGxhdGUgcmVwbHkuDQo+IEkgY2FuIG9ubHkgcmVwZWF0IHdoYXQgSSBhbHJlYWR5
IHJlcGxpZWQgdG8gRGF2aWQ6DQo+IA0KPiBGb3IgdGhhdCBwYXJ0aWN1bGFyIGNhc2UsIG15IHJl
YXNvbnMgYXJlIG1vc3RseSBjb25jZXB0dWFsOg0KPiB1c2luZyBhbGxvY2EoKSBkb2Vzbid0IHJl
YWxseSBkaWZmZXIgZnJvbSBzaW1wbHkgdXNpbmcgVkxBLCBpbiBmYWN0IGl0IG1ha2VzIGNvZGUN
Cj4gbG9va3MgdWdsaWVyLg0KPiBJIHVuZGVyc3RhbmQgdGhhdCB3ZSBkbyB3YW50IE1TVkMgZW5h
YmxlZCwgYW5kIGluIG1hbnkgY2FzZXMgc3VjaA0KPiBtZWNoYW5pY2FsIHJlcGxhY2VtZW50IGlz
IG9rLCBidXQgcHJvYmFibHkgYmV0dGVyIHRvIGF2b2lkICBpdCB3aGVuZXZlcg0KPiBwb3NzaWJs
ZS4NCj4gDQo+ICBzdXBwb3NlIHdlIGhhdmUgMyBvcHRpb25zOg0KPiAxKSB1c2UgcHJlZGVmaW5l
ZCBtYXggdmFsdWUgKGl0IGNvdWxkIGJlIHF1aXRlIGJpZyB0byBmaXQgYW55IHJlYXNvbmFibGUg
dXNhZ2UsDQo+IGxldCBzYXkgMUtCIG9yIHNvKS4NCj4gMikgdXNlIGFsbG9jYSgpLg0KPiAzKSBj
b21lLXVwIHdpdGggc29tZSBzbWFydGVyIGFwcHJvYWNoLg0KPiANCj4gRm9yIDMpIC0gSSBkb24n
dCBoYXZlIGFueSBnb29kIGlkZWFzLg0KPiBPbmUgb3B0aW9uIHdvdWxkIGJlIHRvIGNyZWF0ZSB0
aGF0IHJpbmcgUklOR19GX01QX0hUU19FTlEgIGZsYWdzLCB0aGVuIHdlDQo+IGNhbiB1c2UgcGVl
ayBBUEkgIGZvciBlbnF1ZXVlIHBhcnQgdG9vIChydGVfcmluZ19lbnF1ZXVlX2J1bGtfZWxlbV9z
dGFydCkuDQo+IFRoYXQgd291bGQgc29sdmUgYW4gaXNzdWUsIGFzIGluIHRoYXQgY2FzZSB3ZSB3
b3VsZG4ndCBuZWVkIHRvIG1ha2UgdGVtcA0KPiBjb3B5IG9mIGRhdGEgb24gdGhlIHN0YWNrLg0K
PiBNeSBwcmVmZXJlbmNlIHdvdWxkIGJlIGVpdGhlciAxKSBvciAzKSwgYnV0IEkgY291bGQgbGVh
dmUgd2l0aCAyKSB0b28gLSBzcGVjaWFsbHkNCj4gdGhhdCBJIGRvbid0IHJlYWxseSB1c2UgdGhh
dCBwYXJ0IG9mIFJDVSBsaWIuDQo+IFdvdWxkIGJlIHJlYWxseSBnb29kIHRvIGhlYXIgb3Bpbmlv
biBvZiBSQ1UgbGliIG1haW50YWluZXIuDQo+IA0KPiBLb25zdGFudGluDQoNCkp1c3QgbXkgMmMg
b24gdGhlIDMgb3B0aW9ucy4NCjEpIFdoYXQncyB0aGUgcmlnaHQgbWF4IHNpemU/IEkgZG9uJ3Qg
a25vdywgc28gSSB3b3VsZCByYXRoZXIgbGVhdmUgdGhpcyBmb3IgdGhlIHVzZXIuDQoyKSBJIHBy
ZWZlciB0aGlzIG9wdGlvbiBvdmVyICgxKSBkdWUgdG8gYWJvdmUgcmVhc29uLg0KMykgcmluZyBp
dHNlbGYgaXMgdHJpY2t5IHNwZWNpYWxseSB1bmRlciByZWxheGVkIG1lbW9yeSwgUkNVIElzIGFs
cmVhZHkgY29tcGxleC4gU28sIEkgd291bGQgcmF0aGVyIGtlZXAgdGhlbSBzZXBhcmF0ZS4NCg0K
U28sIEkgcHJlZmVyIGFsbG9jYSgpIG9wdGlvbi4NCg0KVGhhbmtzDQoNCi0td2F0aHNhbGENCg==
