Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EBACAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 12:03:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94E13402C1;
	Wed, 24 Sep 2025 14:03:11 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
 by mails.dpdk.org (Postfix) with ESMTP id 33B12402C1
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:28:12 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SoHKqM8mYPqKjGU0FMjbpJKuG89tDJb86VI8ogpzsJCAYN+cUaJmQ8962+JRq8Hkmf5cLbwN+TABXQotJ9tAZediPOJsGlqXWJkWNhyjmhOLCU21yAzAV+RdOOfS4YsCag+54QCco1ku+9eUee4XmXqydv/2gNwT+LwqGA3cNYQuT4tvN8bNjFozBjeK9Dh86AMNHIXrkIMqzrFDru1WkXbRd8egkvtyIgFX+IK6K/ityZAgcUGwLmGYZLZKE+aE6lLIkkz8rdl0UtA9/sXEcoxO4oWcaZqQzkP1il17VxDa7+gsGkF+W9e9LEBPqrr8WYQvzMnA5p2he7Ysejl8kg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ7EXA+Yc6h3Z/jGtCOaT7jhMOLMkVuHLgUAnSFXWW8=;
 b=huy9JBkeItwUZ802ZkLB6zSf7AUAxsCwr+PRDhohAk/hlb5BxRJRQCMX2XC6kRnZ5A7qAj0rsob7Ifb4EIZSH66j6C6QOTUhRKZclon43PS8QRqAKNna/Y4tjhnBBl7UF5PWFzomMLEvrAxAK9CuO6Lvw5ui2ACv2n++OohHPFGyqOid/HanjSTJbEfgves1cByQ/QgOJ7cgrqeLrHgqTxuKJZXi390/AhT11OLfMWbzLzgLHFCmEtC8Js7ccK3C0ygvIsqcu5I8jxZ/QSobUl9DIgI4IjLzKX2KE9r7kC6KPJa9QWtdWy0iyzXU2ddFIT2LrkrZ0UT1pg9ZVH/7kg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ7EXA+Yc6h3Z/jGtCOaT7jhMOLMkVuHLgUAnSFXWW8=;
 b=EutAaWS5nW36HLqcxz6C62mFQeKC9nu4VGYYWnG8MG8dMq8NAfq+BEK2E8x+KfypaUYFZ4c0iRqiH5SG/fEMaDWNtoPGLd5AsXwIq+Ny6ironFeurzhbIyXKnrUeYi0Zw76LZ/5PejCvSNQJsLa+GL/JGuZtmZDjtaAXcRpYT60=
Received: from AM0PR06CA0084.eurprd06.prod.outlook.com (2603:10a6:208:fa::25)
 by AS2PR08MB8950.eurprd08.prod.outlook.com (2603:10a6:20b:5f9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 11:28:07 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:208:fa:cafe::92) by AM0PR06CA0084.outlook.office365.com
 (2603:10a6:208:fa::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 11:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Wed, 24 Sep 2025 11:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiR98eQcI8wLgisJYtr/u9imABNHBbQgyk6kcQgumpOOSZNzsSN+4/qtdY191CPsW2d5HVdy5pxaYxcmjeXkhUXTXojislV53cE/Ij2zSCErZSAPBJKpL1V0EJOMcvg+U/ew9bDGBNK3gHkM8hVykMQ3awMmKKCWrrL0jHT39YzX2I6pXgAJFMMJtbMT5SS3OIR11dl0Eu8D22BVZY0jZeW9j1n2kk1amzOIhW2rUbC+gBn/cZCss+oXLYBRZnrQl1/PN1CbYlJlIpLWosP/RkcdMdRYzlISqRd6b/3zQ6I4pBs2ovAvk/UruG0xkiH2jPbekzALTnPvVJO/1lbc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ7EXA+Yc6h3Z/jGtCOaT7jhMOLMkVuHLgUAnSFXWW8=;
 b=Zpxn4cWl2L08pikPoN9E+RluF7Qgdvw8U/B15zUCgZWPGO1umR+q88DJCKaE+955JlnaBsRKuy3n7DunOhweS/XTPUmvaQUBOaeJqRmfZC08J13+dqwF2pWvjrsvfpayJf7mlYhRamDOhR+ZP49B9Ha63Tg8S+8IwRzvSXYmcN1hP+l5D8Z5+7P6NOP+ix3JYFP91jSJ+3WkCAZZgGpwdEVqi/WevnhQP7JMhZnmdwrDIFwckb+DIpJrewcdpZml27LoJS21VnlFr9c8rp5NPNBHnt54I9y/EaiTWdygAYgLNaTmVZ9U8vq06mTeYgXS+6v3S+TXiKJaz1yB3XdR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ7EXA+Yc6h3Z/jGtCOaT7jhMOLMkVuHLgUAnSFXWW8=;
 b=EutAaWS5nW36HLqcxz6C62mFQeKC9nu4VGYYWnG8MG8dMq8NAfq+BEK2E8x+KfypaUYFZ4c0iRqiH5SG/fEMaDWNtoPGLd5AsXwIq+Ny6ironFeurzhbIyXKnrUeYi0Zw76LZ/5PejCvSNQJsLa+GL/JGuZtmZDjtaAXcRpYT60=
Received: from DU0PR08MB9557.eurprd08.prod.outlook.com (2603:10a6:10:44e::14)
 by AM7PR08MB5319.eurprd08.prod.outlook.com (2603:10a6:20b:dc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 11:27:34 +0000
Received: from DU0PR08MB9557.eurprd08.prod.outlook.com
 ([fe80::fdd1:fe93:89d8:1c07]) by DU0PR08MB9557.eurprd08.prod.outlook.com
 ([fe80::fdd1:fe93:89d8:1c07%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 11:27:34 +0000
From: Ola Liljedahl <Ola.Liljedahl@arm.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcJnJiBml2HHEBUEWClQ4fxxecK7SWYP5wgABfdICAADf1oIAAQKiAgATGqYCABX8KAIAAdQaAgAAPLICAADKHAP//8/gAgAA3n4A=
Date: Wed, 24 Sep 2025 11:27:34 +0000
Message-ID: <9B712773-4A39-4D09-9313-1623EE30F209@arm.com>
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
 <71C73931-11EA-4B4C-8FFF-F82A2B2F7520@arm.com>
 <2421eba5de7c4586a7b80dda29078eb2@huawei.com>
In-Reply-To: <2421eba5de7c4586a7b80dda29078eb2@huawei.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.100.25090553
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DU0PR08MB9557:EE_|AM7PR08MB5319:EE_|AM3PEPF0000A78E:EE_|AS2PR08MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7cf84f-6bee-4791-554f-08ddfb5d6eff
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?OUdnM1d0czZaS3kvbFpDdGsvY05MNGl2cnRmK0ZiTkw2UHJVUUxYaVRabWRT?=
 =?utf-8?B?NnJUQ2ZtRVFCR1RLS1hDQU9ZdHRPL3dmV1pFN04zMTBiZTlabDdwU016aTll?=
 =?utf-8?B?SkxFU20yVmlId1dDbSt4Y2hxb0h0WG1WNW0xeVVVeDFValJxdGV1emMyRzhQ?=
 =?utf-8?B?K04wZ25KNVRjaDRJSDJwQzAxMFUwaDQ0VkhXWm5RT2c4YWhpQzF6OXAwTDhL?=
 =?utf-8?B?UVBqUitkUHNDTmt0RGZrSEROd1J5UGhmdG5WeElTUGVDeExhVmJDQWM1TTcv?=
 =?utf-8?B?aTVzQlFlanAvTWNUNFd5OXIvNDhiZGZ5Z3FkSjJuVzl3WGJPcVVGYVcxTmpO?=
 =?utf-8?B?aGFzOGJza0g0MDRuZkxpeHpWVEU3bEovemowaCtRZTVXUFl2dEFOTG94WXVE?=
 =?utf-8?B?RTZ2NnB3Ymw5ckdlSys5YkhXV2hobVZQTUlkWTNmbU5hRG5NN1B4bW9VNkxi?=
 =?utf-8?B?QVVFbm02aW1LSEM2SjlObG1ndkFuaDRzSitodHZ1Z1hWK1A5NUFPdEZtUHFR?=
 =?utf-8?B?ZGxRdnp4cHpIc1lFNFE0VjBWVTBHUGpQUU8rQk5Ed0RFbnVadld6QW95OERw?=
 =?utf-8?B?U1M2c0JWOUpVYnh0amRpdnhXdkJrSkFiSzUyQXNCL0s4ekpZc1R5Mytad0Fk?=
 =?utf-8?B?NnBBU3VWVDBqQUVMNUpQZEZLQUJRMkozM2Z6dXRrWHlMU3VWNnVkQ2hKK09Y?=
 =?utf-8?B?b2FvWFRxcjVnR0Z5OFJCR21jTllWUGZCMVJIWkFqcWtkcmVYenlIejFLZ29B?=
 =?utf-8?B?YkZuRDVKanpPaUZWL3Q0TXhCa1VHTDlESFpvUS9VYjhJTjljbnVFTmg2T0Fz?=
 =?utf-8?B?R0p3dHhPTUllOE55eFo0NUdCM1FPSURwNUIvOTVUL3NQQ2l1UjgxNFZkWW9C?=
 =?utf-8?B?QVVZOE1LbHREd2dOeC9qbW5DUzZ4NC9yTHJHQ2xqVkE3SWFwYVpmMmMxQWZZ?=
 =?utf-8?B?S0Rwdm9PQlZ4ZTR0bXE1MDgyWm5CWTlRWVI2MHh0aU5CVjJacnIydzZEZE1p?=
 =?utf-8?B?eThIdERXUGhYL1F6VzNVaW5uWWtlK09JaTE4NDJUWFZwTXRWc3pYNE5XZ2Ni?=
 =?utf-8?B?QXErY0hURXV3L0JncTEzYmlpZ2dlUC9qejduS0tNN09BZ0hyQXd0bHVSNjAv?=
 =?utf-8?B?eU1VYzJWZ0RTZHloQ1Vqayt1dXdia21JNTYzRGRNKzhMRDc2NTEzL0lpR25n?=
 =?utf-8?B?ZGIzMGtJTVlNV3VYMlJTRG9sa1IvSC90aW9ZenVIM2hpN1ptVVI3Ry9EZ0Nk?=
 =?utf-8?B?QzFwejlWU3RLZzF1QnJrcWozUWxnY2tTV3VZdkxHZSsrd2VKZjhsSHBNS2FR?=
 =?utf-8?B?REkzRk95cXcva2FsVDBJM1hyS0d2L3E4aER4TGRYdE5mYk9YenBFK0hTV1gy?=
 =?utf-8?B?UFMvbnZENnN4S3oxUlZVQldMZzVwR1d2SWNyMG9XbldhSjlyYmpRZXdwbC92?=
 =?utf-8?B?Nkt6aFJkOFVvR3MxYWdBNzRzV2Z6OHZHcThDM2JhdXk1YTFtWnV0NHViSE5R?=
 =?utf-8?B?aTIvN1ZaUWdqVGs3NDFvTSszVkdzOU5uSjVSTThjQnoyVzhwTisxSjlweVF3?=
 =?utf-8?B?azZucjV6ZkZQZ0lsWG4rK1U1RS9pY09UVndvMzJ3eTQzSTY0azJXTTBoSFFL?=
 =?utf-8?B?UUpVMm5BV2htUzhKeEUwMWxaSGlMZnRlbVQ3VVpDWmtpM1AxVW5QdFhBeHlW?=
 =?utf-8?B?d2ZVcHhoSUZFZUNQcWZET2llc0NhWkxSTXl2TjQ2aU9UN0NBTEdlRThaWkhD?=
 =?utf-8?B?RjlqOE9iNWFFem5kbEdXaFlrVHh0VFhpNlh1aWx3ZlJwWjl4d0w4anVQRGNl?=
 =?utf-8?B?bEdjUUd0c2Q2T242Wm5uWFJGMmo5aEp2bmVrN25MbFBmT1FQNE8xeTllZGYz?=
 =?utf-8?B?UWRHMDNRbytWcVZXakpLbiszNnlYNzdrU2JHVitKa0JBbWpOczZOKzBvbGJa?=
 =?utf-8?B?VzBqTmJ3VDllRzMvNGVCNHVpK2tGZ0wrRjg3MFdJblFtRGxXM3dGb1dxc0Ny?=
 =?utf-8?Q?QI4cprO/GzxZmtSUGW0uJkzxI50Bjg=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU0PR08MB9557.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0BA4A8DD91E7A4BBB2E2F480017BB4F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5319
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f657f3a3-946e-40e6-20d3-08ddfb5d5b9c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|35042699022|376014|1800799024|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUM0MFNDekdoRjVUREh6UGl1QkZCbnRDZmtwekMvcVhvQ1d3WXFjRXh4NGE5?=
 =?utf-8?B?RXNWZllsNWJiTVJaMkpxQVJmMWVSSy93Y3FkUEtZcnFyRlFSTGhYS2h0Y3Jx?=
 =?utf-8?B?ZmMwbkJERnlJRVQrK3Q0Uk5HbmZZeDhjMFdTUTJDWTlTNUxmWnJjRXBOa1hu?=
 =?utf-8?B?ajlzWG5MUEZ5eUttMlFoMDNhQm1EMlVGdVBiMnh1UlYrVUVqeStmc3FpSkZV?=
 =?utf-8?B?bk9ib09rZWVZL3JDQ0RMaG1JWkJwNVErVmFQZmtuQjVOa1N3L0g5NEFuMGRF?=
 =?utf-8?B?V0ZNeVAvSWs0ckVPMXVWWGlKS25PaUxRZjB1d0FPb2JxOU9SRDIwRi8vSlhR?=
 =?utf-8?B?UFJMQlNpaXRkdTYreENSbUFRMFJlUmRWSVo2anlhZ3A2d3lwSmd0M2tWMk5a?=
 =?utf-8?B?ZVFQTVVBakFJRk1RUmlOSFdaZFZFM0ZwUklac1psakRvcWhuaEQ3bmFaVTZX?=
 =?utf-8?B?eFdkZm9lNEpuZlJUbGdObWFWMEMzZUYzY0I2UUI1TXJxUlVTNC9PL0hkWlU1?=
 =?utf-8?B?NHBmOHBsK0ZtTE1CckkxaTk5QXF1TDNqZG5ROFQ0TkR6cVpJUVpXYzZsdFNL?=
 =?utf-8?B?MDNjMTAza3FXRkl1RXI3R1hrYTFURzkyN3lCbTRwU3JLZktRdkJFNllRbjQ0?=
 =?utf-8?B?WFMvNElzOU1OdE1mZC9yYU5JalREL3M1dlNGbmdrTWtQUFJEZ1Y4aWtML1pR?=
 =?utf-8?B?TXFicXd0MnJsL1NiU1I1R1pYcHErbW1OU09rM2hCUTVUbG81Tk1lSHRxWTVw?=
 =?utf-8?B?emJxVi8zSk9FdDk3WVh1OVBmMVlBb1JYS29XYXgvWS9JRThhWkl2K25Lb2Uw?=
 =?utf-8?B?cEZYWkRzaXFuTUxnNmgrT0lKNk5pdkgyN1FHY3Jsalk0eGZ2U2xoYlNmVjdB?=
 =?utf-8?B?eStLQVVRMEFLVFRURDI3WUswY1FBRVB1L2pBSzJ4SDZuWi9tZ3Z0OC9Gc1A3?=
 =?utf-8?B?ZkdVN1lybGIvVGUvcHppb0lNTENDcGZScXZtMzFHZVpOS2x0V2Zub0ZudTc3?=
 =?utf-8?B?eXJka1ZEa1U2Y1U2VGdxZjRTN2dpZVdiOVdZWHFxdkJkclYrMldxUUR4TkZG?=
 =?utf-8?B?ZDl6R0E5L0dsaThWQml2RVdQUGpkazNIRkdBTVgxRjJGOVVlRXpzMXJLeStQ?=
 =?utf-8?B?SkRMVXJMZFdRWmc5S2x5Z09lZnlxREI3TUZZVUc5K2gzVmIrWm4zdU5MRUxz?=
 =?utf-8?B?UGY2T3dGVVVuVExpaVUrb3U0T0Y1YnA3cXpMelRSaCtVRTlOSk5KZWU5eTF6?=
 =?utf-8?B?YTlqcC9lS2RkWGVmeFJSbFU3b2ltQytmQ1pJV0JsLytmNHpSc3BqWmhyTmhY?=
 =?utf-8?B?K2o2blMzRnh1WnJEUTdsb3VNRDZqZm5GdFFPamNDMHlJUjZaTUxkQkRJWWsw?=
 =?utf-8?B?SHhQOFlvekQ3KzdtcGRVTVBNUDNnU3ZUK1U1WUhWTExzenp3bVhYNWRSc2pa?=
 =?utf-8?B?Yms5Tms0aVVVYzVzYjd0U3pFcTVsWWJzaDRYdXlxYWNjRERZS1ZBT1RQSDFK?=
 =?utf-8?B?QlVLN2xQNHROejJQZFk2dlh3bmhISFVHMWtJU2ZCcnlyNXQvS0Nlek9sV2hF?=
 =?utf-8?B?Z3V1cW56R3E1Ym5FRDlTSStLYzF0ME1CWGE0cEdsYmc2S2tvV240aVZGOWZL?=
 =?utf-8?B?NEtCREdxOW9xU3hlTlVEemhzR01WRUIwc0MyRitYV0l1TTJZQjBsN3l4SXJG?=
 =?utf-8?B?aElnV29RdHJuSTRlWXRqcEcxTlNHNFpWRDJmZzBZVFBpbjk0VW1DMjdldXlE?=
 =?utf-8?B?SVFxNnkzVUIrUnQzK0V3SVpwZFBxRVU4aXgrU2VtOXVCM0xjL0ZPSVpjYXlp?=
 =?utf-8?B?Zm5IempPZzRzM2dSKzgzYThVYXg2TzRCWVU5NSt0YmVYelhqTkhYcCtKeFB3?=
 =?utf-8?B?UTdZWlZDd0lSQURtZUZXMDhGVXBROFlrTGpRRTZpQ3QzMkxHUzZSU2M1QmhI?=
 =?utf-8?B?czRJYk1RcEFiR25FOTZldkxpSHhhaU1hQzB5UHJvTzRoUC9FZk5tdGZyaW1n?=
 =?utf-8?B?MjlEbTVVZWJPb3Z2V1NUNS9GRkZtdWFwQ1RYSGpwRitIQjVDZUZ6WWZXUFEv?=
 =?utf-8?Q?WX81rr?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(35042699022)(376014)(1800799024)(14060799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 11:28:06.8163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7cf84f-6bee-4791-554f-08ddfb5d6eff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8950
X-Mailman-Approved-At: Wed, 24 Sep 2025 14:03:10 +0200
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

Pg0KPiDvu78+IE9uIDIwMjUtMDktMjQsIDEyOjA4LCAiS29uc3RhbnRpbiBBbmFueWV2IiA8a29u
c3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20gPG1haWx0bzprb25zdGFudGluLmFuYW55ZXZAaHVh
d2VpLmNvbT4+IHdyb3RlOg0KPg0KPg0KPiA+ID4gPiBTdXJlLCBJIGFtIHRhbGtpbmcgYWJvdXQg
TVQgc2NlbmFyaW8uDQo+ID4gPiA+IEkgdGhpbmsgSSBhbHJlYWR5IHByb3ZpZGVkIGFuIGV4YW1w
bGU6IERQREsgbWVtcG9vbCBsaWJyYXJ5IChzZWUgYmVsb3cpLg0KPiA+ID4gPiBJbiBicmllZiwg
SXQgd29ya3MgbGlrZSB0aGF0Og0KPiA+ID4gPiBBdCBpbml0IGl0IGFsbG9jYXRlcyByaW5nIG9m
IE4gbWVtb3J5IGJ1ZmZlcnMgYW5kIHJpbmcgYmlnIGVub3VnaCB0byBob2xkIGFsbCBvZg0KPiA+
IHRoZW0uDQo+ID4gPg0KPiA+ID4gU29ycnksIEkgbWVhbnQgdG8gc2F5OiAiaXQgYWxsb2NhdGVz
IE4gbWVtb3J5IGJ1ZmZlcnMgYW5kIHJpbmcgYmlnIGVub3VnaCB0byBob2xkDQo+ID4gYWxsIG9m
IHRoZW0iLg0KPiA+ID4NCj4gPiA+ID4gVGhlbiBpdCBlbnF1ZXVlcyBhbGwgYWxsb2NhdGVkIG1l
bW9yeSBidWZmZXJzIGludG8gdGhlIHJpbmcuDQo+ID4gPiA+IG1lbXBvb2xfZ2V0IC0gcmV0cmll
dmVzIChkZXF1ZXVlcykgYnVmZmVycyBmcm9tIHRoZSByaW5nLg0KPiA+ID4gPiBtZW1wb29sX3B1
dCAtIHB1dHMgdGhlbSBiYWNrIChlbnF1ZXVlcykgdG8gdGhlIHJpbmcNCj4gPiA+ID4gZ2V0KCkg
bWlnaHQgZmFpbCAoRU5PTUVNKSwgd2hpbGUgcHV0IGlzIGV4cGVjdGVkIHRvIGFsd2F5cyBzdWNj
ZWVkLg0KPiA+IEJ1dCBob3cgZG9lcyB0aGUgdGhyZWFkIHdoaWNoIGNhbGxzIG1lbXBvb2xfcHV0
KCkgZ2V0IGhvbGQgb2YgdGhlIG1lbW9yeSBidWZmZXJzDQo+ID4gdGhhdA0KPiA+IHdlcmUgb2J0
YWluZWQgdXNpbmcgbWVtcG9vbF9nZXQoKSBieSBzb21lIG90aGVyIHRocmVhZD8gT3IgdGhpcyBp
cyBub3QgdGhlDQo+ID4gc2NlbmFyaW8geW91DQo+ID4gYXJlIHdvcnJ5aW5nIGFib3V0Pw0KPiA+
IElzIGl0IHJhdGhlciB0aGF0IG11bHRpcGxlIHRocmVhZHMgaW5kZXBlbmRlbnRseSBjYWxsIG1l
bXBvb2xfZ2V0KCkgYW5kIHRoZW4NCj4gPiBtZW1wb29sX3B1dCgpDQo+ID4gb24gdGhlaXIgb3du
IGJ1ZmZlcnM/IEFuZCB5b3UgYXJlIHdvcnJpZWQgdGhhdCBhIHRocmVhZCB3aWxsIGZhaWwgdG8g
cmV0dXJuDQo+ID4gKG1lbXBvb2xfcHV0KSBhDQo+ID4gYnVmZmVyIHRoYXQgaXQgZWFybGllciBh
bGxvY2F0ZWQgKG1lbXBvb2xfZ2V0KT8gV2UgY291bGQgY3JlYXRlIGEgbGl0bXVzIHRlc3QgZm9y
DQo+ID4gdGhhdC4NCj4NCj4NCj4gQm90aCBzY2VuYXJpb3MgYXJlIHBvc3NpYmxlLg0KPiBGb3Ig
UnVuLVRvLUNvbXBsZXRpb24gbW9kZWwgZWFjaCB0aHJlYWQgdXN1YWxseSBkb2VzOiBhbGxvY2F0
ZS91c2UvZnJlZSBncm91cCBvZiBtYnVmcy4NCj4gRm9yIHBpcGxlbGluZSBtb2RlbCBvbmUgdGhy
ZWFkIGNhbiBhbGxvY2F0ZSBidW5jaCBvZiBtYnVmcywgdGhlbiBwYXNzIHRoZW0gdG8gb3RoZXIN
Cj4gdGhyZWFkICh2aWEgYW5vdGhlciByaW5nIGZvciBleGFtcGxlKSBmb3IgZnVydGhlciBwcm9j
ZXNzaW5nIGFuZCB0aGVuIHJlbGVhc2luZy4NCkluIHRoZSBwaXBlbGluZSBtb2RlbCwgaWYgdGhl
IGxhc3Qgc3RhZ2UgKHRocmVhZCkgZnJlZXMgKGVucXVldWVzKSBidWZmZXJzIG9udG8gc29tZSBy
aW5nIGJ1ZmZlcg0KYW5kIHRoZSBmaXJzdCBzdGFnZSAodGhyZWFkKSBhbGxvY2F0ZXMgKGRlcXVl
dWVzKSBidWZmZXJzIGZyb20gdGhlIHNhbWUgcmluZyBidWZmZXIgYnV0IHRoZXJlDQppc24ndCBh
bnkgb3RoZXIgdHlwZSBvZiBzeW5jaHJvbml6YXRpb24gYmV0d2VlbiB0aGUgdGhyZWFkcywgd2Ug
Y2FuIG5ldmVyIGd1YXJhbnRlZSB0aGF0DQp0aGUgZmlyc3QgdGhyZWFkIHdpbGwgYmUgYWJsZSB0
byBkZXF1ZXVlIGJ1ZmZlcnMgYmVjYXVzZSBpdCBkb2Vzbid0IGtub3cgd2hldGhlciB0aGUgbGFz
dA0KdGhyZWFkIGhhcyBlbnF1ZXVlZCBhbnkgYnVmZmVycy4NCg0KSG93ZXZlciwgZW5xdWV1ZSBv
dWdodCB0byBhbHdheXMgc3VjY2VlZC4gV2Ugc2hvdWxkIGJlIGFibGUgdG8gY3JlYXRlIGEgbGl0
bXVzIHRlc3QgZm9yIHRoYXQuDQpSaW5nIDEgaXMgdXNlZCBhcyBtZW1wb29sLCBpdCBpbml0aWFs
bHkgY29udGFpbnMgY2FwYWNpdHkgZWxlbWVudHMgKGZ1bGwpLg0KUmluZyAyIGlzIHVzZWQgYXMg
cGlwZSBiZXR3ZWVuIHN0YWdlcyAxIGFuZCAyLCBpdCBpbml0aWFsbHkgY29udGFpbnMgMCBlbGVt
ZW50cyAoZW1wdHkpLg0KVGhyZWFkIDEgYWxsb2NhdGVzL2RlcXVldWVzIGEgYnVmZmVyIGZyb20g
cmluZyAxLg0KVGhyZWFkIDEgZW5xdWV1ZXMgdGhhdCBidWZmZXIgb250byByaW5nIDIuDQpUaHJl
YWQgMiBkZXF1ZXVlcyBhIGJ1ZmZlciBmcm9tIHJpbmcgMi4NClRocmVhZCAyIGZyZWVzL2VucXVl
dWVzIHRoYXQgYnVmZmVyIG9udG8gcmluZyAxLiAgPDw8IHRoaXMgbXVzdCBzdWNjZWVkIQ0KRG9l
cyB0aGlzIHJlZmxlY3QgdGhlIHNpdHVhdGlvbiB5b3Ugd29ycnkgYWJvdXQ/DQoNCi0gT2xhDQoN
Cg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBh
dHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJ
ZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBz
ZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55
IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0
aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
