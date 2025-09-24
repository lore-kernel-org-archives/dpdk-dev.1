Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D7ACAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 10:12:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A600402CB;
	Wed, 24 Sep 2025 12:12:25 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5F8AB40289
 for <dev@dpdk.org>; Wed, 24 Sep 2025 10:52:11 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RE8lAYi2zkmGG4Z/z6ljO+idTnI+rXU2R2B044unw9P8OYu0oVWX1FztG1gZ+diNCzIpdy582b4bEjIDKp1ntEuPwv6ZoS5JNykD49VYV6ic2ODVzrkZWFsfU+AUikNkjZzVAvSv9GFcPqtbaYjVh0MI+e+VCAT0hyZlfIl9PIT3rN9zhoEzyHp0kmlAKAV4gMrXi6qars2eUS321Vy9JNlIWYDsgeDMd8YO/nEQNzM3wMx5hob9zGFVhhqYx8lQQBbHNl8YDDXrxWCiWGPYRzITCyZZlb06ikqDWvJPH1Ca5U2V8hRzp5W/Nl2dFfqJq6s6z8ZrgBsv/xesfi1JSQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lf0qYXPA+5XEt5G8SH6hWRauKN3Pcp+xwsYmgOc2+9k=;
 b=mVwfA46cu2RXrUExKCQeCUWXmsJeLuSMxlenAQzCliFgJJQ3LukkYROVGdK0LtdCc6hXNFs++K+wrSo9visx95Nl3BI41jpwuLBbvhQJguHEJ1bo5LVLOcXdRROF2vr6STVKZ+zeD/B+545e2mKW6zlFD9tVmFpZxAtaTvbmJskFZrKx02LHajA8pscV3ZC/rHVr9RNpuPJxiEX6qCnxUXE+lbyHS5EN84n5BmO/rIQvizlQZyHt5/wRlGyM6aIWg4emQmiBdHksEi6wscVFwsK0dORzd1OsZTM9ifz+UiVhLq495kPlfGwqrMC20s0r3yMlV9mxxLXIuhgA8mGDiw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lf0qYXPA+5XEt5G8SH6hWRauKN3Pcp+xwsYmgOc2+9k=;
 b=dewjuZ0g9VsUUcUT2pJC0a+SOuD9S9KOI/wLzYtVT9eM/NIDrY2HGpGIWDwpjnOIWjXlD7AN0FvtYZJQ9llPs58z3hMAcsif+Kyz4KYvv2pEwSa8y7y11wL3/XwAm/JhZr8Cd2TjdQ9izTX1vLej4kDtWrgTlpk7OuO6WnRjOIk=
Received: from DU2PR04CA0337.eurprd04.prod.outlook.com (2603:10a6:10:2b4::35)
 by VI0PR08MB10447.eurprd08.prod.outlook.com (2603:10a6:800:207::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 08:52:09 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::3a) by DU2PR04CA0337.outlook.office365.com
 (2603:10a6:10:2b4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 08:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Wed, 24 Sep 2025 08:52:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aaz361TS98kEcQkpRzYLof4jCCd9vqGPkcgZEF1k7M9tbocEbvwBTarqnwQslwuV7RBAL9HbyIzjyyIGSgdD9vOQoC+D8bQ/3PQ1+RlbSxOm4ErFRxHfs9GHyalSVtpk+rE8tQrrAHUsBPRqBifZqLH/21BqHZK9vqA2MIT8Zx6ki0nvWija+l97URh3JU77zzlBCyaSJoMB81tQaV1BDbos2SvyQ5YwrwSP3XdloD77LKabNI/W0MoGupgFk8+Bc04aoJWOmZAy7cBttaFfE0ClRsC3Y6UGy/2vZOlKz2Yb/hufY//R0WRhU1zSOhELzf42ckD5dvyrEluN/NtF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lf0qYXPA+5XEt5G8SH6hWRauKN3Pcp+xwsYmgOc2+9k=;
 b=pu1jl8A9Rw8keikJ2TDCzn8VhSk/glMGJmBxg7y81dac3FyM22noN+NUSibPGYDl5B7c7T4aJG+TitaURzp5hpst14gRgBHWDUU6ZlXyYfS9y2uUvgUqLNOZrI8KMI2Nk4bswRIfix4SO6Jks5p7evMWhizKdPXVcPGSdCusqjEoMWaJgSvKS9yYbAT7FhvmaWrlrRA2LD1zKD3B0U5OqUYsEDNhvF1WdVxLLgv8aJN8T9MfndazaLzrjegZaDy1eHxzk65lyr4pHCjEobXqU9Y7rZMgTLYH9g0S72nJmQ941Je44eCI3Tjt61ZtRWRuGdl4yttsGD3cyMR/YT6rOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lf0qYXPA+5XEt5G8SH6hWRauKN3Pcp+xwsYmgOc2+9k=;
 b=dewjuZ0g9VsUUcUT2pJC0a+SOuD9S9KOI/wLzYtVT9eM/NIDrY2HGpGIWDwpjnOIWjXlD7AN0FvtYZJQ9llPs58z3hMAcsif+Kyz4KYvv2pEwSa8y7y11wL3/XwAm/JhZr8Cd2TjdQ9izTX1vLej4kDtWrgTlpk7OuO6WnRjOIk=
Received: from DU0PR08MB9557.eurprd08.prod.outlook.com (2603:10a6:10:44e::14)
 by PAWPR08MB10133.eurprd08.prod.outlook.com (2603:10a6:102:35f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 08:51:33 +0000
Received: from DU0PR08MB9557.eurprd08.prod.outlook.com
 ([fe80::fdd1:fe93:89d8:1c07]) by DU0PR08MB9557.eurprd08.prod.outlook.com
 ([fe80::fdd1:fe93:89d8:1c07%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 08:51:33 +0000
From: Ola Liljedahl <Ola.Liljedahl@arm.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcJnJiBml2HHEBUEWClQ4fxxecK7SWYP5wgABfdICAADf1oIAAQKiAgATGqYCABX8KAIAAdQaAgAAPLICAADKHAA==
Date: Wed, 24 Sep 2025 08:51:33 +0000
Message-ID: <71C73931-11EA-4B4C-8FFF-F82A2B2F7520@arm.com>
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
 <a5fae8a9edc947fdbaf4e2519c39f93e@huawei.com>
 <2a611c3cf926d752a54b7655c27d6df874a2d0de.camel@arm.com>
 <61a9d5b157be4816aa296194f9c0eabe@huawei.com>
 <4173E44D-BB31-45B9-AF6A-553B1E755604@arm.com>
 <64a7def62ee642139c3af31ce4fd94e9@huawei.com>
 <EF1C5BFC-B9C7-4D38-8FDC-FF412DD45C21@arm.com>
 <8eab3da6eb2944a4a4a197aeb38ee2f1@huawei.com>
 <d485010b97654d09a1921b97879faf90@huawei.com>
In-Reply-To: <d485010b97654d09a1921b97879faf90@huawei.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.100.25090553
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DU0PR08MB9557:EE_|PAWPR08MB10133:EE_|DB1PEPF00050A00:EE_|VI0PR08MB10447:EE_
X-MS-Office365-Filtering-Correlation-Id: a8330fa0-555d-4ee8-85f5-08ddfb47a50e
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?SWRFc0VodDM5RU9FTFdKNXJONHdES3BDWHZsNXBjNnFxUDFrMUNXeU9kazlr?=
 =?utf-8?B?dEptN3JQYUlMbXpSVmFTczRjT1hIK0FmbmJabVVnU3p3TU10Zk1nQm1MOVdV?=
 =?utf-8?B?NmkxUm0yaGwxK1NYNUZNenJYL1FsOFFzVE5vVWJqUGRmMHVtMUE0a2tveVMw?=
 =?utf-8?B?QWRoY1Zwd3d0YVdYM25aS0E4UjhUOHc2NHBBMllra3V6VXVsUXVZd3NkZFll?=
 =?utf-8?B?SWlnTTBabkllRXc4R05TMVh4alR4SHNLUEtmYjRLT0lxeTllYlRUYWlick9L?=
 =?utf-8?B?ODVub0NYY3Nsbmxqd1dHZ0VnN3Q2emtuNGVpMW56UElOWEF0MUFhQnUzeXRj?=
 =?utf-8?B?dHVNcFBha1BwTGFSL2hqcUg3VFFBR2dobzRIY0tDQ0lObXdhdnFHVjNZancw?=
 =?utf-8?B?SUhjb2JiSGlON0M5OEh6WExtcHZtdmpxOGI2bUxKTVNMVWdNN3ZhZmp4WVJU?=
 =?utf-8?B?MGRpSVhnckFzYjMzTGxLMmpqT1pmWGR6SmpENVFyd0FjRjhYQkFBMW1GVDVT?=
 =?utf-8?B?RWRPWmJXVE1Ja1oxUkFDZ2NLOEF2MmpDSWNhaTBMcjBCREhLd3hKTmFFcjk1?=
 =?utf-8?B?a0RnMDM5YXMrNzF5SiszZlVrVUhoeGJyR2pUV1lRUHlYZ3FOY21qVlRqMFpj?=
 =?utf-8?B?dWJIVDR6ZUFJcXhEWFhMQXdxQ1F5blNRRnUyNzFieU5xbURzSlZqQ1E0Lytu?=
 =?utf-8?B?SEVHcTlhdTdRdmFYNHQ0cDA5YzJQckVJdm9RWjJhZ0VWQWZOSDFZUzNvOGx2?=
 =?utf-8?B?YVYxUm0rL2l2M0dJVHkzSkNlUUNRTEdXRkIyMFlZeFVUd1FnQ0dxTDN4NHdP?=
 =?utf-8?B?TVBLY2s3RHlZYVpSMzRzSzZ5RE9DM1I1dlBoZTIxMzlZbThCT1ZMM1hLN1RZ?=
 =?utf-8?B?dGdGYXAyV3JZNzNzamhUK1grU1pWRnpoUm9Uc0E5eE1mREFiVFNUU0Y2M3Vn?=
 =?utf-8?B?bWxXWWx5TVV0Nnk4SVAzVnh5NlVVaXlzaUFGek1CWE9HWE9EV1VkQTBUQmNk?=
 =?utf-8?B?eEg2dFo2YTFIY1dTMnhTNHFwSC9vbmN5WWt3bzlrVTJxM3QrK2FiRkxiRXlR?=
 =?utf-8?B?M0NlK2JHYzB0MjhZbEpRb05UcWlqYW0rSDMwc25SbnJuWUl0TnZzUUVNam1t?=
 =?utf-8?B?S25qRjRSUDZQcU9OLzlUR2R2dkx3Qm5zRTJIb1N3ZE5yMWRYWiswNnF1cXlo?=
 =?utf-8?B?NlZUQk0xc2k3amJxcXNVcHhKcG5iRloza09PS3NkVC9SUkNWM2NXVmhHWTUx?=
 =?utf-8?B?Z2pzdkZTSG1PUzV2emZmOFg1U1FVOFJEZjUyc0szMWtkcUtjUVF2Ujg0SEN6?=
 =?utf-8?B?am5UKzFSaURVdjZlWjg5VnAxYlphYjJEbTJmTjFqT3BGNmJHREdUOUw1N2xS?=
 =?utf-8?B?UXpWS1M3MU9pMU5oelRsUk9heVd6YlRhRmtDWmx1QXRvS0hnV3VEWDZiS2VJ?=
 =?utf-8?B?UXpaOURtK0ZHUitjejhhQVJ4bGRqREtCSGdBVGxoRUxINGk4UGQwVmhGZnRU?=
 =?utf-8?B?UHRQejhhNTVXRFMxcmZDQ0t0UldSNDJLaERmZFhZdGk2R3AwaW1tS3FwSGlS?=
 =?utf-8?B?NnBPNXQ3SDBPazZ5clVyVUJIcEhFd0kzYVQ0WGI0c2R6OUVKVXZxRWZDaTQx?=
 =?utf-8?B?MGJsTC9XcUVldFgrcFZETzMyZTJCTVZhaHExcmMvMHdCSmI5RDM5Zk04N2Rv?=
 =?utf-8?B?Q05LN0tZZzcvdHdiTW5PejFZbnhsNlY3WDFLTFJUWGV2U2Fpdm1jWm1nUElG?=
 =?utf-8?B?VjFYWEFPaTRCdUdLV21hME4zbGtta3diS3J6L1gwZkw3aFdCNnNLOG1KWUNi?=
 =?utf-8?B?Ui8wajMrQUJiM1N1VW5ubmc3RzZQejJKWDVsNHlUUjVpeUoxUi93TmJOV1hu?=
 =?utf-8?B?SXcvYXh0cFFrSit6Q1VYZGxVV2JoRkh4WkZ2dkN0MTJkOHJaNldySktXbzNu?=
 =?utf-8?B?bXlncUNSck90aUVlUTBqS3hiQjVCK0VnUVl6OUsvczZiR1FRWVpKMmVST2NI?=
 =?utf-8?Q?4a48Owj4C8ohF9oWO3qQUwUqSUk7Jw=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU0PR08MB9557.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <F17D1B81D38E554296965614FCC563DD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10133
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 74a54134-992c-42da-8088-08ddfb47900d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|35042699022|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGRYVVZHWW5yc2RYSWxTMVNiQWRwTmI4Z1JqTjFUTlpIbzR1bFBmRFIvdFp0?=
 =?utf-8?B?cW1OUDRXd1NFcFVJbllIV2MyRU9nMXpoYWxWdkZWMUtScWtqN21RWi9GbGli?=
 =?utf-8?B?SzVvOHBCVVY2U0tzT1MxeUNrNjdhQXViRENMN3hlVzdnMnZqTXVNRStHOTZ0?=
 =?utf-8?B?dFFSTVFUOXIzazFycndiQk9OTHZMMmVsTHdJTmxuZnZEa3hpNEVNSktIME9V?=
 =?utf-8?B?S2lmbjNpblJYdTRjVUp0MnkrbEQ5UDluVkY0dUp5OWw5Y1lkNGllb05DbzJo?=
 =?utf-8?B?dnl3VXdtT2NoVzR5ellkUTZITW9ET1hDaktiUG5IYVJpb1I2enRxSUxxLzNL?=
 =?utf-8?B?ckdwdnRQTHpac2RWMXBGUzdpQ1VRb0tMV2hnZW40a2JpZC9obnJMOXlpajVx?=
 =?utf-8?B?ZSsxRHFBWmxJUjB6S3owWFV0VnN4aVF2OUtCRHAwV1kzUzlBN0VJcUFTeUVx?=
 =?utf-8?B?bmw3cmpvK3pLUkFObUlIbDlHY1pwa0lBUzhlOElxdUpQWDlGTktuODUzcVE4?=
 =?utf-8?B?c05CR3BJdHp4WjR3V1dCQjc3bWcrekFMOHBjUDBKVzNzdytNK0pMRWg0d09O?=
 =?utf-8?B?bmo3L3FyYmhWbFJCSi9rem1odzd5bzVXSTFuTEtnMkJ2L3AyMElmZ09tbitS?=
 =?utf-8?B?WlA1ZUlGOGczdkFDK1JGNDNBVTA2dGZId3VaZnBFRy9vblFRNUJEeVBFREFa?=
 =?utf-8?B?TFlRT01PMUtISXF0K3ZVTHArVXRXQ0dOYWdabFBZYnl2eCt5SVNCNDEzWlIz?=
 =?utf-8?B?TEdDYkdhNS9GMGIzQUkxSUFQWGJYaFhTajhobzFDblNYaEdVUGpDcDkramNU?=
 =?utf-8?B?ZjNIQWVHTyt5eFFqcHhqck1IcitoVVRHL2dUUXc5ZXRiRG1zdDNvdUVxSERr?=
 =?utf-8?B?V2hLbXRaT201Y0s2enFycnI4R1lZMTloTGlHUUZUM1NmeGJnbkFPZkVKUFR5?=
 =?utf-8?B?YU9SOXFNcFdIZExzVzR4dFV0bzEra0JOZHdGQzlZK3J1MFBxZU5IL3BLS3pk?=
 =?utf-8?B?QURYbXpPa2JuWUhPb0d2TXlSSmZXc1dIT3YvVU4ybksrbUk1dHhCWkw1QUk5?=
 =?utf-8?B?UzVxMFVnVGRhajJTV2NXNnRQdjJXRWJLRmFxbU1aa2N1bFlORCtiRk1zOVhp?=
 =?utf-8?B?MHpubS9nRzZTZm1Ja1VTdi9ZNDR1U24zMnBlUXhTcE5UQTl3RXc3dGZOV2NB?=
 =?utf-8?B?NUhjYjExUjJjdXhCdk9OOTk2ejNPZ01ZdnRKeVdMbjZZRk4wQ0Y2NVkyZ0Z4?=
 =?utf-8?B?S0tXNkE5clY0eGtzdEs5S1NGWGlNVjJmQ01QRjBLeWVuTGVkd3FET2JxMmtW?=
 =?utf-8?B?eXJlekdibXBoQlZaenA4bHI1M1NVeTFTbGlGbDMzUVJtVXQ1VjR4aE9ROE4x?=
 =?utf-8?B?QXpBV1NDM2VESFBwcTE5VlNpcGUyTmdTcFVLbUFtNTVVMnpQRjc2ZzIvOHFX?=
 =?utf-8?B?UUZLcVFmSGNwT1h5b1E1aHM2SXo4Y0RYeTN2dmNoS3VyTFMzV1dkK2VyZmUv?=
 =?utf-8?B?aXpnbi9GTFRZQks4aFR6VWJTSHhFYlRSWEVOUWJjcVBFaVFUWkdITzdUVmV2?=
 =?utf-8?B?c2RRVndnVGYxSVVjeHpTOEtTQ2xkb1hEWHVZcERwSWdOam1qYkxuK1RuL3dz?=
 =?utf-8?B?NXlQSlJxVUxxYlNOeElHVDlVMVFDUDNlM2lzQVg5YVFCMEtBU3hjYmsvNEk1?=
 =?utf-8?B?clBWRzFNbG9HZUtJWEhpdlpYcm40VjgyODJLTExkQjg2TFRuS2pPS0c3VkVx?=
 =?utf-8?B?V3Rxa21lV282MlltM3oxcFpMMHZCaDFicGgvSElQWjRuMFNYUGtUOEVnR201?=
 =?utf-8?B?U05TUll3WWhCc2VXTHBJRk4zNGE1Z0lTS0lMVnFKY0RGWUliN3RaR2R1WDNl?=
 =?utf-8?B?b2NxdWt1c1NzMVdQTmFNcHA0ZGhubmpOaGt4ckVyc09nZll6Zzc3MCtsSWRV?=
 =?utf-8?B?eFZPWGxWWUg1aTlNWk1aRFBCbi92eDNnWWh3SDh6Q0Q5TWlxN0c0SzlWNHgv?=
 =?utf-8?B?cHpCb0ZJTkgxb2NNQU9Zc21CMDNNQW12T1FtVUpVMzhmZFRPek5TaW92UXF6?=
 =?utf-8?Q?U7dasa?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(35042699022)(14060799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:52:08.5939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8330fa0-555d-4ee8-85f5-08ddfb47a50e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10447
X-Mailman-Approved-At: Wed, 24 Sep 2025 12:12:23 +0200
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

PiDvu79PbiAyMDI1LTA5LTI0LCAwOTo1MCwgIktvbnN0YW50aW4gQW5hbnlldiIgPGtvbnN0YW50
aW4uYW5hbnlldkBodWF3ZWkuY29tIDxtYWlsdG86a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5j
b20+PiB3cm90ZToNCj4gPiBTdXJlLCBJIGFtIHRhbGtpbmcgYWJvdXQgTVQgc2NlbmFyaW8uDQo+
ID4gSSB0aGluayBJIGFscmVhZHkgcHJvdmlkZWQgYW4gZXhhbXBsZTogRFBESyBtZW1wb29sIGxp
YnJhcnkgKHNlZSBiZWxvdykuDQo+ID4gSW4gYnJpZWYsIEl0IHdvcmtzIGxpa2UgdGhhdDoNCj4g
PiBBdCBpbml0IGl0IGFsbG9jYXRlcyByaW5nIG9mIE4gbWVtb3J5IGJ1ZmZlcnMgYW5kIHJpbmcg
YmlnIGVub3VnaCB0byBob2xkIGFsbCBvZiB0aGVtLg0KPg0KPiBTb3JyeSwgSSBtZWFudCB0byBz
YXk6ICJpdCBhbGxvY2F0ZXMgTiBtZW1vcnkgYnVmZmVycyBhbmQgcmluZyBiaWcgZW5vdWdoIHRv
IGhvbGQgYWxsIG9mIHRoZW0iLg0KPg0KPiA+IFRoZW4gaXQgZW5xdWV1ZXMgYWxsIGFsbG9jYXRl
ZCBtZW1vcnkgYnVmZmVycyBpbnRvIHRoZSByaW5nLg0KPiA+IG1lbXBvb2xfZ2V0IC0gcmV0cmll
dmVzIChkZXF1ZXVlcykgYnVmZmVycyBmcm9tIHRoZSByaW5nLg0KPiA+IG1lbXBvb2xfcHV0IC0g
cHV0cyB0aGVtIGJhY2sgKGVucXVldWVzKSB0byB0aGUgcmluZw0KPiA+IGdldCgpIG1pZ2h0IGZh
aWwgKEVOT01FTSksIHdoaWxlIHB1dCBpcyBleHBlY3RlZCB0byBhbHdheXMgc3VjY2VlZC4NCkJ1
dCBob3cgZG9lcyB0aGUgdGhyZWFkIHdoaWNoIGNhbGxzIG1lbXBvb2xfcHV0KCkgZ2V0IGhvbGQg
b2YgdGhlIG1lbW9yeSBidWZmZXJzIHRoYXQNCndlcmUgb2J0YWluZWQgdXNpbmcgbWVtcG9vbF9n
ZXQoKSBieSBzb21lIG90aGVyIHRocmVhZD8gT3IgdGhpcyBpcyBub3QgdGhlIHNjZW5hcmlvIHlv
dQ0KYXJlIHdvcnJ5aW5nIGFib3V0Pw0KSXMgaXQgcmF0aGVyIHRoYXQgbXVsdGlwbGUgdGhyZWFk
cyBpbmRlcGVuZGVudGx5IGNhbGwgbWVtcG9vbF9nZXQoKSBhbmQgdGhlbiBtZW1wb29sX3B1dCgp
DQpvbiB0aGVpciBvd24gYnVmZmVycz8gQW5kIHlvdSBhcmUgd29ycmllZCB0aGF0IGEgdGhyZWFk
IHdpbGwgZmFpbCB0byByZXR1cm4gKG1lbXBvb2xfcHV0KSBhDQpidWZmZXIgdGhhdCBpdCBlYXJs
aWVyIGFsbG9jYXRlZCAobWVtcG9vbF9nZXQpPyBXZSBjb3VsZCBjcmVhdGUgYSBsaXRtdXMgdGVz
dCBmb3IgdGhhdC4NCg0KLSBPbGENCg0KDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMg
b2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1h
eSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGll
bnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Ns
b3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJw
b3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFu
ayB5b3UuDQo=
