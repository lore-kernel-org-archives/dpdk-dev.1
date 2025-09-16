Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F65CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 07:30:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD2AF4027A;
	Wed, 17 Sep 2025 09:30:04 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
 by mails.dpdk.org (Postfix) with ESMTP id 5D2C040288
 for <dev@dpdk.org>; Tue, 16 Sep 2025 20:20:20 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JOjwzZtxXeD/5cEKMu526Ru2U/fQ0mSaWMhnZyD8PpXKHhqWeDaDExjoS0WL4IdihIx5oapFb5mP/qDCn0EJ0tLaVyrE8rti5vmHwGL68WF32/5wNvllPPkjgqoG5sXBhqt/6VjCxJLWjXesqwcprGeAxOiPmA4WvgHa9c+Oe0Joa8OhqGO9jedRa34T783vGpWh4LdhlET2ynIrj48htzEGG45bq2xHfxbYkv6u7QMfsZWuxlfRLmT8hPLmhfd/gKtDnN5Hw9FTWUkNGVsZtNGfyPUGsskfF9lyobGwfBvS3mT6sLP3dNqvDtgkKj5gML+ph5YDB+r9v6oWkf7x0w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLWDJuTwvcf2p7s30MSTyYa9WfExOMTR3YABIag+WpQ=;
 b=V/oz4FhfdoKZFlKPg+o2oPleu1UUrof91/f3CYLY6IoFOaKQkXYt5Im6w/G7lBQyO9fuHsNkJhLPyppkoKmcGUIEPasIszx7OrOGpZ/Gnlr+l5EVW/Ody+MrYTaiIIfNcbIV1hFbag/velMeMbYnKa1dYNZbKQh/sEYP1dVMWY4JNQ0u9jjPQ6t8qDA3Wrj1YC8mKG+t2JXrT1Z2NWOitTSrrNb5+M3zKYHRVXIwj83q6yHK6NZe2GhHnoSP5bsaFb3jDM757OQWjyioT/wrnlmuOUoin/Pltsjp4UnAqhpqyouBF8xr8Gd58gksyT+uaAAIQRxOQE3MyMEDgLASoQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLWDJuTwvcf2p7s30MSTyYa9WfExOMTR3YABIag+WpQ=;
 b=Vb9QSAJ/sBbybcGbzrTyEPrsLdaQmx0pcsvS1hAdUnrXA4nLSLG9xxxKfMH0KpZ6ylFN7sComC96CnumOgVjCs5q7eLsokaYPC8pjtWNL9nwFJPvH7jVPpmEHaxng8EjhR/yYfO6JYocIOoEewoUW5lex+UWO8dhLdC/BEBAnKo=
Received: from DUZPR01CA0306.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::16) by DBAPR08MB5719.eurprd08.prod.outlook.com
 (2603:10a6:10:1a6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 18:20:16 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::61) by DUZPR01CA0306.outlook.office365.com
 (2603:10a6:10:4b7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 18:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via
 Frontend Transport; Tue, 16 Sep 2025 18:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZaPHniKzrKcB2iKLliSt2cViVBUs51hLw9ONzw+n9yLxbfbZNAdLqNP5T5WPKXndy/9z1KO97M3Qp1J+B1FG2/65i18SXCCmk2X0a6/5VNT5hrz88DANuhLTU1mkT8iPznAm/PVb986DHGULDD5nrWq2F3hLl9MBnwGXeDg22eZcEfT1jB/5XKqkIbAngEsHTcNhk+efd671lz49y6YbXYC2qFG8aVgZfzPhk1MKKuyU0Do8T3u29acXbRLBxgqtTFLNzyTZCE5htwRZxP3ILHwShyQMVwBKzK6ycsKdDTbYDli5bt/XEEjn6NrHZDGon6djEfKzLOSwrvHcGWizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLWDJuTwvcf2p7s30MSTyYa9WfExOMTR3YABIag+WpQ=;
 b=yOyWF+uK1xVeUCtOX4qPL7avAvtamwdeTcUFLH/Y7W0rL/zwptqR8a9H+Ip336tutGnDpxUfw0CeCTLuuYDFBuRKQ3XMTsFO1nOKHNMi4hqBtXPMoHWRhMS+NM7WbqU7zxak6UrtDtQNe8XeLWGNtSQzFOgn16SohuU4F/rWnVt1CxfPm08nbprn9k5BC0UzsYUBE3hgZuzKkrHeYRA270xBMYtBwfGPn9/ntPs/TZ0qTHfQcuKdJ1WtiRJDbY2LBTetVqWK8Y2oP0MQtfC9AmfUKoGdOIlX2QZQTq/FjrfK/1iDjz2xBI+EkkhflJNJ4yFL+s/RwQrfy2OT4kjMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLWDJuTwvcf2p7s30MSTyYa9WfExOMTR3YABIag+WpQ=;
 b=Vb9QSAJ/sBbybcGbzrTyEPrsLdaQmx0pcsvS1hAdUnrXA4nLSLG9xxxKfMH0KpZ6ylFN7sComC96CnumOgVjCs5q7eLsokaYPC8pjtWNL9nwFJPvH7jVPpmEHaxng8EjhR/yYfO6JYocIOoEewoUW5lex+UWO8dhLdC/BEBAnKo=
Received: from DU0PR08MB9557.eurprd08.prod.outlook.com (2603:10a6:10:44e::14)
 by DB9PR08MB9682.eurprd08.prod.outlook.com (2603:10a6:10:462::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 18:19:41 +0000
Received: from DU0PR08MB9557.eurprd08.prod.outlook.com
 ([fe80::fdd1:fe93:89d8:1c07]) by DU0PR08MB9557.eurprd08.prod.outlook.com
 ([fe80::fdd1:fe93:89d8:1c07%3]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 18:19:41 +0000
From: Ola Liljedahl <Ola.Liljedahl@arm.com>
To: Bruce Richardson <bruce.richardson@intel.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>, Dhruv
 Tripathi <Dhruv.Tripathi@arm.com>
Subject: Re: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcJnJiBml2HHEBUEWClQ4fxxecK7SV9DeAgABNVwA=
Date: Tue, 16 Sep 2025 18:19:41 +0000
Message-ID: <590A2369-28AC-494F-9E27-7CA9C670426C@arm.com>
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
 <aMmFeXsHI9VRn3GY@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aMmFeXsHI9VRn3GY@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.100.25090553
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DU0PR08MB9557:EE_|DB9PR08MB9682:EE_|DU2PEPF0001E9BF:EE_|DBAPR08MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: c66bbcb4-90f8-456d-4934-08ddf54daf35
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?TGRTN0ZGMDZiOVJuaFRkRzIxMms5V1diMkIvQ0xleW92YkZGcmoyaWZESllv?=
 =?utf-8?B?OHFsZWtKSlYzVFNoVlJIam1HVmJ4YzE4U3VHVHJ0WlNLOG4rN0ZHZXJES0hp?=
 =?utf-8?B?bXBwUDBhajM1cE1heFFQRWF1K3U5dllLOFIyNDgySGVpMGpGMXBLY2hGTUdH?=
 =?utf-8?B?V2FNN0xZejNycGFsSmV3NDlYZjc5UThDb1k5c3VUa0Z1d21EeXQvR0o5V0Fw?=
 =?utf-8?B?Z0k4aWlsMVRVZU5KMm9vWkFpb1RpcnN1RWVldGNWY3hjcHdIYS9PbmxnUjBY?=
 =?utf-8?B?RFYwUnN0SlpSU2NadENSWHhCRlh2N2V6elRpTDNIZ28ybU1OSllUYXN0SXNX?=
 =?utf-8?B?V3cxSllrejVVM05vV25FZjhKemg0WDVpbWFKRVprSTArcXQ4L2JpL1hHRDht?=
 =?utf-8?B?MGF5OWwwa0tVZ2dZMTdra3NqMmdta1dwRUlkaFBQczBYQkVqNklEam1KaDFP?=
 =?utf-8?B?d1FGUG1GYVdKQUVLQ2ZnUHhYak5tOHVjU2ViNFJnNFJSMkZLRmhEUFRMdHUx?=
 =?utf-8?B?bDkxMU0xVkp1bHgrM0RsYmhuWnArL1padS91VzlKWjJJZThBbWxTS0RLWXUv?=
 =?utf-8?B?NDJlUGJlKzRMWWNJTVZuY29VeDFsSWhsckx3RGhOZldZUEhCanNpOHNuUE8r?=
 =?utf-8?B?WWdZQjdKdjB6SzBIZjJrbVV3bngxZzNuZmJuWXorSGZoeVgyNFdUelU2Y2FK?=
 =?utf-8?B?NkhVQ3JUWUpPTU5PVXNWT2tzYTFvWXdRSVpEeG93bUtFMVRlZjROUVdhVlF1?=
 =?utf-8?B?bnlteDRQYTFJUERqOGVVSzFnS3IyQmNJdEJGQXd1Q25IV0I0QlFOcUxMMUJ5?=
 =?utf-8?B?eHlURWlnU080UWVNaEF0SFpyVjJyNGFBcnRUeURrVGZvdzVuUGM1cFkrdkwy?=
 =?utf-8?B?U0pPaEN0WGJDQVo0ZHRYUFp1OTZ1aXZNRk8rM3ljd0VJbzdUMElNN2QybXJ4?=
 =?utf-8?B?UXhEVDhtNkJHVjFFYVJMblFMN3ZELzZwZEYrRzB5L05OOFcySFlsRlZrQ1VH?=
 =?utf-8?B?YXNCU1MySGdBRC9FOVdDSy9nZ2lDQVFNSGFRZEc3clRWYXA4VG16RmlBM3Bj?=
 =?utf-8?B?dzRjVGlaa21XS2J1NUZtN2w1RVNvdk8yR2xEZnhUOFNDR3F3alJmWDhMN3Vn?=
 =?utf-8?B?ZmRiOUdzdHVjak95NmM1S3JrSVFVTDZrcnlRbE05eGl4bHlINU94ZFBCR2dx?=
 =?utf-8?B?cUtmTFFNS1YxSHZiWTk4QnhGMXNQMnVaODB3T2NqREl0aU9Hcks3Z2U0TWNv?=
 =?utf-8?B?TGczZHVjeExkczJ6cVA4bHhuZjJHUTBOWHk1SUM2Zm0rV2Z0a0Y0dlh6SHd4?=
 =?utf-8?B?UWRZdHRrOUpSMkRYbE9YSGR0cDI5UFhNeVU0cUkxKzQ1Zm5zK0d5aENiUDhn?=
 =?utf-8?B?V1p3MURtY1hHQ0U1Rm9Hc2pNOVBIYVU4a3l6NnQzZzNXZUllV0tUTlRzNXBT?=
 =?utf-8?B?OVk0M2p3YXJmeWRlZjc3R0VvNXdGeHdrdGhDb0FhakdjcUI5ejlQcTJxQkVt?=
 =?utf-8?B?NWRSVitmTUZTSjVZN1F0VmpEN05iRUZjcFVJckVwRW5MT29nYjRnM0tOMzFV?=
 =?utf-8?B?VkxLeUJEQzVWODE0cGNGRU1jaThSdmt1ejdrM1ovV243ZDV3cHNJSU5wL1dV?=
 =?utf-8?B?RHZ4YnppZ3lnemdPWEp5eHdEc2I1eVRlcXpNUWRaM2RPempneVpFMy9jVWFr?=
 =?utf-8?B?dVF1ZzFSVkVLbnJIeE9qdUVuN1JMTUNSL3Jld2YySWwwOVFWS3VQY2NXWGlE?=
 =?utf-8?B?Mzc0S05IcEJHL09EdjZlUkY3T1FRSkdsei8reFU2cEk3enhpcGF2RWV5TjQ0?=
 =?utf-8?B?MDQzMlhEdUNuZVpqMEFDZ0Fjd3dYa3N0RmxkM2lIb2JUY3FERWJWdFVkeGJC?=
 =?utf-8?B?S1pKSFF2UXJFelpIdmlzWk4vc2hKbU9QK3dwdU9hQ2pXY1laRmJhdllaMElQ?=
 =?utf-8?B?Q2VKbkR4TDBYQ0xpTlc3T2NBNVovQVFiNjZ5SmNFd3hUY3dWL29RQ1NSZ3JV?=
 =?utf-8?Q?OLKiQHBRQXZhcrdPPlk9SdDjWAem/M=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU0PR08MB9557.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <35202689A34C20418460E75D6DC4B601@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9682
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6f51150b-995f-4eb8-8d8d-08ddf54d9af3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|35042699022|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWkrM3JMcTJCdDBkUG5MUXFIVisrWmxYK2YzKzYxMmxkSTVjcUxUQi9FS2ox?=
 =?utf-8?B?MHcvM211ejJOeS8wODFSVzErZVhTRFlzNXJwSHVBM2p5WVQvL1UwcnFnQStV?=
 =?utf-8?B?aTlqN25YdGFhWlB5S2NNWXQ3MjkzaFJIb2NyU1BjSEE4NU5IeDRNN3ducito?=
 =?utf-8?B?SnlyaG5kTlVXeXcwa2lDcUFpbm9oSDdwcGh6RmJJaEhVQmdQR2JxQXZUd0ty?=
 =?utf-8?B?SDFoUDZVeU5RaVVZeXQ4R0lJR1Nmc2dKNGZlZGgvWFBMZ2loQUdNdTdjbjQr?=
 =?utf-8?B?QkFRYjZUYkZuSjVuTXpERDVLbkFJZTRJVnVScC9EcjU2QVREejNjc3o3WjJw?=
 =?utf-8?B?VlMxZ0lydjZCVVdvbGFBTWJ2S09oNThxNnRRTDEveVQxWGg3VDN2VTJmM2xt?=
 =?utf-8?B?blYvLzZ5aDNqaGtLT1I2b3htWVRHM0Y1TFlwMWw1RmJGOWZWZTM4cE9HSzNp?=
 =?utf-8?B?L2J5aVh2UjNtRjZaYlRuMVQ0TXo5VVJPQzBqRFpHTm1mbklTaS9wclk2bWxv?=
 =?utf-8?B?aXlNZm1qKythenlhcEs4ZFRHMytidTFpK25acS9pSjVlL1NzTGh5UHcwVTdk?=
 =?utf-8?B?cTVXelhtVjMzRkpiWlJvTmFhYmd4WlNpTmN6TS93NEx1N3pDcVptbDFqNHl3?=
 =?utf-8?B?eFpjQTZSSkpiT1A2SzZtcnZkVDhVd0Nzd1hHYzNQa001RG1NNTJZV3JiTjI3?=
 =?utf-8?B?eEZyZXRGeWZzTU14Y1dIUUxHemNYWit3LzNqU3d0eTJ3SktmcE1HdE01Tlhz?=
 =?utf-8?B?VklXanNmenp0a0JMSjZBNzB4a0tiODhPUzhGSjlpdkFZQUJEdFAvcUVWM3Vr?=
 =?utf-8?B?UUhJcGtScmZmVkFGRzlvMkh2MFBmdjBwNlU2QSt1TFhsaUVEb1pVM3IxVlVy?=
 =?utf-8?B?Q2NvQ0FCMk13bVp6WjZqMnRaZER0Tmo3eXJPNjZMRGJoRmRQSGdET2loK3Bs?=
 =?utf-8?B?aWRRVW1CNkdaU1U3b3RpY01qNnIxUEhQTllWRkVhMVlOYTRSdjhJaVZMMHc4?=
 =?utf-8?B?RGsvM2NUMW5vUDh2bU8ycjE0emF6YmNuZ1ZVcWplOVRDWXFOTWtCQ2g5VVFh?=
 =?utf-8?B?RllLajhaVnk5Ym5VZXVCV2x2VWN3SU9NMVFOM0hIc2g3aVhDQzFCeUU4a1U2?=
 =?utf-8?B?cXhyY3A4dEVJNElPRERLWUNvU0d3Z2NueXM4dExsVm55QVpsRDZxOXAvaDRG?=
 =?utf-8?B?ZkxlMWU2SFlMTzhKajNNeUdMZDE4a2d3QVBGQnJHNWY4bTYwcTYwWHZLem9R?=
 =?utf-8?B?NGVZbzE5YlFuVVZWbWhKRXAyVFZ6M25IUzFTR2U1VE1GT01jWDU1VG83UE9t?=
 =?utf-8?B?bHhISmJod2NBa0hXbXh3L0M3eklKQXJldGJjWFdneXdtdHJsREV1MEQ1eGMr?=
 =?utf-8?B?L29qc1dPMkNJVTVXb2pkUzFZdFdObEsxWEZPSWI2NlNBTkhoWVNlcHVjNHZU?=
 =?utf-8?B?dUh6bHh4Qlk4MG85Mm1sVVBNUXlIM3FDeDVEbzhORTFueEtEemQ4UmZLSmsz?=
 =?utf-8?B?YXV4SFJzMzNrK3FNZ0Nia3VPSWFMdEtjS2g3aUc1dkM3aWNGZklKZHFLSWNN?=
 =?utf-8?B?alkxOENvejNEVDdqanljcW1DbkdJNkhXWU5tSmpEQ1g4SEYvM1l4V0RaOU9S?=
 =?utf-8?B?dldLblZsdW5zR0RLR0VjZ05uVEpoaDZianJacUZncDg3UWluZXVkU0l2c1VB?=
 =?utf-8?B?UC9SeTU3ZU1pNzFsYmd4NjB2NWJHcEFUdDVQeEpGdkJ5K0ZZRjJPR3FScGN3?=
 =?utf-8?B?MEJQa25pcVloNVNjUlM1RVVTM2E5NWFFQ3lMcTUwVmhkVDlVenFQWE1kSldl?=
 =?utf-8?B?TzVNSGlMSjc4d2xLd1RvRW5LTG1VVTZHOTZ6QytMeElmVnk3VUNSbDdaU3l1?=
 =?utf-8?B?TXBRdnNKbStsNG0wZkE1ZENQN2hEMnZib2lJTjN1WXBHRHJ3NzJ2Y0tjT05t?=
 =?utf-8?B?aXpRTGMvOUtta2lVZzc5RHZJWlBCRGZzb2RrbmhBRjBpMExBUzV1R0l6dzEr?=
 =?utf-8?B?RXAxVkhUY1dQSUVOUUFiclREZFdUbXBZK1FneEF3Y1NpQXBEVXFFbEFuV2dN?=
 =?utf-8?Q?lZn3mk?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(35042699022)(14060799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 18:20:15.6193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66bbcb4-90f8-456d-4934-08ddf54daf35
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5719
X-Mailman-Approved-At: Wed, 17 Sep 2025 09:30:03 +0200
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

KEkgYW0gc2VuZGluZyB0aGlzIGZyb20gT3V0bG9vaywgSSBob3BlIEkgaGF2ZSBiZWVuIGFibGUg
dG8gZmFrZSBhIHByb3Blcg0KZW1haWwgY2xpZW50KQ0KDQo+IE9uIDIwMjUtMDktMTYsIDE3OjQz
LCAiQnJ1Y2UgUmljaGFyZHNvbiIgPGJydWNlLnJpY2hhcmRzb25AaW50ZWwuY29tID4gPG1haWx0
bzpicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT4+IHdyb3RlOg0KPg0KPg0KPiBPbiBNb24sIFNl
cCAxNSwgMjAyNSBhdCAwNjo1NDo1MFBNICswMDAwLCBXYXRoc2FsYSBWaXRoYW5hZ2Ugd3JvdGU6
DQo+ID4gVGhlIGZ1bmN0aW9uIF9fcnRlX3JpbmdfaGVhZHRhaWxfbW92ZV9oZWFkKCkgYXNzdW1l
cyB0aGF0IHRoZSBiYXJyaWVyDQo+ID4gKGZlbmNlKSBiZXR3ZWVuIHRoZSBsb2FkIG9mIHRoZSBo
ZWFkIGFuZCB0aGUgbG9hZC1hY3F1aXJlIG9mIHRoZQ0KPiA+IG9wcG9zaW5nIHRhaWwgZ3VhcmFu
dGVlcyB0aGUgZm9sbG93aW5nOiBpZiBhIGZpcnN0IHRocmVhZCByZWFkcyB0YWlsDQo+ID4gYW5k
IHRoZW4gd3JpdGVzIGhlYWQgYW5kIGEgc2Vjb25kIHRocmVhZCByZWFkcyB0aGUgbmV3IHZhbHVl
IG9mIGhlYWQNCj4gPiBhbmQgdGhlbiByZWFkcyB0YWlsLCB0aGVuIGl0IHNob3VsZCBvYnNlcnZl
IHRoZSBzYW1lIChvciBhIGxhdGVyKQ0KPiA+IHZhbHVlIG9mIHRhaWwuDQo+ID4NCj4gPiBUaGlz
IGFzc3VtcHRpb24gaXMgaW5jb3JyZWN0IHVuZGVyIHRoZSBDMTEgbWVtb3J5IG1vZGVsLiBJZiB0
aGUgYmFycmllcg0KPiA+IChmZW5jZSkgaXMgaW50ZW5kZWQgdG8gZXN0YWJsaXNoIGEgdG90YWwg
b3JkZXJpbmcgb2YgcmluZyBvcGVyYXRpb25zLA0KPiA+IGl0IGZhaWxzIHRvIGRvIHNvLiBJbnN0
ZWFkLCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvbmx5IGVuZm9yY2VzIGENCj4gPiBwYXJ0
aWFsIG9yZGVyaW5nLCB3aGljaCBjYW4gbGVhZCB0byB1bnNhZmUgaW50ZXJsZWF2aW5ncy4gSW4g
cGFydGljdWxhciwNCj4gPiBzb21lIHBhcnRpYWwgb3JkZXJzIGNhbiBjYXVzZSB1bmRlcmZsb3dz
IGluIGZyZWUgc2xvdCBvciBhdmFpbGFibGUNCj4gPiBlbGVtZW50IGNvbXB1dGF0aW9ucywgcG90
ZW50aWFsbHkgcmVzdWx0aW5nIGluIGRhdGEgY29ycnVwdGlvbi4NCj4gPg0KPiA+IFRoZSBpc3N1
ZSBtYW5pZmVzdHMgd2hlbiBhIENQVSBmaXJzdCBhY3RzIGFzIGEgcHJvZHVjZXIgYW5kIGxhdGVy
IGFzIGENCj4gPiBjb25zdW1lci4gSW4gdGhpcyBzY2VuYXJpbywgdGhlIGJhcnJpZXIgYXNzdW1w
dGlvbiBtYXkgZmFpbCB3aGVuIGFub3RoZXINCj4gPiBjb3JlIHRha2VzIHRoZSBjb25zdW1lciBy
b2xlLiBBIEhlcmQ3IGxpdG11cyB0ZXN0IGluIEMxMSBjYW4gZGVtb25zdHJhdGUNCj4gPiB0aGlz
IHZpb2xhdGlvbi4gVGhlIHByb2JsZW0gaGFzIG5vdCBiZWVuIHdpZGVseSBvYnNlcnZlZCBzbyBm
YXIgYmVjYXVzZToNCj4gPiAoYSkgb24gc3Ryb25nIG1lbW9yeSBtb2RlbHMgKGUuZy4sIHg4Ni02
NCkgdGhlIGFzc3VtcHRpb24gaG9sZHMsIGFuZA0KPiA+IChiKSBvbiByZWxheGVkIG1vZGVscyB3
aXRoIFJDc2Mgc2VtYW50aWNzIHRoZSBvcmRlcmluZyBpcyBzdGlsbCBzdHJvbmcNCj4gPiBlbm91
Z2ggdG8gcHJldmVudCBoYXphcmRzLg0KPiA+IFRoZSBwcm9ibGVtIGJlY29tZXMgdmlzaWJsZSBv
bmx5IG9uIHdlYWtlciBtb2RlbHMsIHdoZW4gbG9hZC1hY3F1aXJlIGlzDQo+ID4gaW1wbGVtZW50
ZWQgd2l0aCBSQ3BjIHNlbWFudGljcyAoZS5nLiBzb21lIEFBcmNoNjQgQ1BVcyB3aGljaCBzdXBw
b3J0DQo+ID4gdGhlIExEQVBSIGFuZCBMREFQVVIgaW5zdHJ1Y3Rpb25zKS4NCj4gPg0KPiA+IFRo
cmVlIHBvc3NpYmxlIHNvbHV0aW9ucyBleGlzdDoNCj4gPiAxLiBTdHJlbmd0aGVuIG9yZGVyaW5n
IGJ5IHVwZ3JhZGluZyByZWxlYXNlL2FjcXVpcmUgc2VtYW50aWNzIHRvDQo+ID4gc2VxdWVudGlh
bCBjb25zaXN0ZW5jeS4gVGhpcyByZXF1aXJlcyB1c2luZyBzZXEtY3N0IGZvciBzdG9yZXMsDQo+
ID4gbG9hZHMsIGFuZCBDQVMgb3BlcmF0aW9ucy4gSG93ZXZlciwgdGhpcyBhcHByb2FjaCBpbnRy
b2R1Y2VzIGENCj4gPiBzaWduaWZpY2FudCBwZXJmb3JtYW5jZSBwZW5hbHR5IG9uIHJlbGF4ZWQt
bWVtb3J5IGFyY2hpdGVjdHVyZXMuDQo+ID4NCj4gPiAyLiBFc3RhYmxpc2ggYSBzYWZlIHBhcnRp
YWwgb3JkZXIgYnkgZW5mb3JjaW5nIGEgcGFpci13aXNlDQo+ID4gaGFwcGVucy1iZWZvcmUgcmVs
YXRpb25zaGlwIGJldHdlZW4gdGhyZWFkIG9mIHNhbWUgcm9sZSBieSBjaGFuZ2luZw0KPiA+IHRo
ZSBDQVMgYW5kIHRoZSBwcmVjZWRpbmcgbG9hZCBvZiB0aGUgaGVhZCBieSBjb252ZXJ0aW5nIHRo
ZW0gdG8NCj4gPiByZWxlYXNlIGFuZCBhY3F1aXJlIHJlc3BlY3RpdmVseS4gVGhpcyBhcHByb2Fj
aCBtYWtlcyB0aGUgb3JpZ2luYWwNCj4gPiBiYXJyaWVyIGFzc3VtcHRpb24gdW5uZWNlc3Nhcnkg
YW5kIGFsbG93cyBpdHMgcmVtb3ZhbC4NCj4gPg0KPiA+IDMuIFJldGFpbiBwYXJ0aWFsIG9yZGVy
aW5nIGJ1dCBlbnN1cmUgb25seSBzYWZlIHBhcnRpYWwgb3JkZXJzIGFyZQ0KPiA+IGNvbW1pdHRl
ZC4gVGhpcyBjYW4gYmUgZG9uZSBieSBkZXRlY3RpbmcgdW5kZXJmbG93IGNvbmRpdGlvbnMNCj4g
PiAocHJvZHVjZXIgPCBjb25zdW1lcikgYW5kIHF1YXNoaW5nIHRoZSB1cGRhdGUgaW4gc3VjaCBj
YXNlcy4NCj4gPiBUaGlzIGFwcHJvYWNoIG1ha2VzIHRoZSBvcmlnaW5hbCBiYXJyaWVyIGFzc3Vt
cHRpb24gdW5uZWNlc3NhcnkNCj4gPiBhbmQgYWxsb3dzIGl0cyByZW1vdmFsLg0KPiA+DQo+ID4g
VGhpcyBwYXRjaCBpbXBsZW1lbnRzIHNvbHV0aW9uICgzKSBmb3IgcGVyZm9ybWFuY2UgcmVhc29u
cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdhdGhzYWxhIFZpdGhhbmFnZSA8d2F0aHNhbGEu
dml0aGFuYWdlQGFybS5jb20gPG1haWx0bzp3YXRoc2FsYS52aXRoYW5hZ2VAYXJtLmNvbT4+DQo+
ID4gU2lnbmVkLW9mZi1ieTogT2xhIExpbGplZGFobCA8b2xhLmxpbGplZGFobEBhcm0uY29tIDxt
YWlsdG86b2xhLmxpbGplZGFobEBhcm0uY29tPj4NCj4gPiBSZXZpZXdlZC1ieTogSG9ubmFwcGEg
TmFnYXJhaGFsbGkgPGhvbm5hcHBhLm5hZ2FyYWhhbGxpQGFybS5jb20gPG1haWx0bzpob25uYXBw
YS5uYWdhcmFoYWxsaUBhcm0uY29tPj4NCj4gPiBSZXZpZXdlZC1ieTogRGhydXYgVHJpcGF0aGkg
PGRocnV2LnRyaXBhdGhpQGFybS5jb20gPG1haWx0bzpkaHJ1di50cmlwYXRoaUBhcm0uY29tPj4N
Cj4gPiAtLS0NCj4gPiBsaWIvcmluZy9ydGVfcmluZ19jMTFfcHZ0LmggfCAxMCArKysrKysrLS0t
DQo+ID4gMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiBUaGFuayB5b3UgZm9yIHRoZSB2ZXJ5IGNvbXByZWhlbnNpdmUgd3JpdGUtdXAgaW4gdGhl
IGFydGljbGUgYWJvdXQgdGhpcy4NCj4gSXQgd2FzIHZlcnkgZWR1Y2F0aW9uYWwuDQo+DQo+DQo+
IE9uIHRoZSBwYXRjaCwgYXJlIHdlIHN1cmUgdGhhdCBvcHRpb24gIzMgaXMgc2FmZSB0byB0YWtl
IGFzIGFuIGFwcHJvYWNoPyBJdA0KPiBzZWVtcyB3cm9uZyB0byBtZSB0byBkZWxpYmVyYXRlbHkg
bGVhdmUgb3JkZXJpbmcgaXNzdWVzIGluIHRoZSBjb2RlIGFuZA0KPiBqdXN0IHRyeSBhbmQgZml4
IHRoZW0gdXAgbGF0ZXIuIFdvdWxkIHRoZXJlIGJlIGEgbm90aWNhYmxlIHBlcmZvcm1hbmNlDQo+
IGRpZmZlcmVuY2UgZm9yIHJlYWwtd29ybGQgYXBwcyBpZiB3ZSB0b29rIG9wdGlvbiAjMiwgYW5k
IGFjdHVhbGx5IHVzZWQNCj4gY29ycmVjdCBvcmRlcmluZyBzZW1hbnRpY3M/DQpJIGFtIHByZXR0
eSBzdXJlIHRoYXQgYWxsIG5lY2Vzc2FyeSBvcmRlcmluZ3MgZm9yIHNhZmVseSB0cmFuc2ZlcnJp
bmcgZWxlbWVudHMNCmZyb20gcHJvZHVjZXJzIHRvIGNvbnN1bWVycyAoYW5kIGVtcHR5IHNsb3Rz
IGZyb20gY29uc3VtZXJzIHRvIHByb2R1Y2VycykNCmFyZSBwcmVzZW50IGluIHRoZSBjb2RlIChJ
IHN0aWxsIGhhdmUgc29tZSBxdWVzdGlvbnMgb24gdGhlIHVzZSBvZiBtZW1vcnkNCm9yZGVyIHJl
bGF4ZWQgaW4gX19ydGVfcmluZ191cGRhdGVfdGFpbCwgd2Ugc2hvdWxkIGNyZWF0ZSBhIGxpdG11
cyB0ZXN0IGZvcg0KdGhpcywgdG8gc2VlIHdoYXQgaXMgcmVxdWlyZWQgYnkgdGhlIEMgbWVtb3J5
IG1vZGVsKS4gV2hhdCBvdGhlciBtZXRyaWNzDQpmb3IgY29ycmVjdG5lc3MgZG8geW91IHN1Z2dl
c3Q/DQoNClNvbWUgZGF0YSBzdHJ1Y3R1cmVzIGFyZSBzcGVjaWZpZWQgb3IgZXhwZWN0ZWQgKGV4
cGxpY2l0bHkgb3IgaW1wbGljaXRseSkgdG8gYmUNCmUuZy4gc2VxdWVudGlhbGx5IGNvbnNpc3Rl
bnQsIHNvbWVvbmUgY2xhaW1lZCB0aGlzIGlzIHRydWUgZm9yIHNvbWUNCnN5bmNocm9uaXphdGlv
biBtZWNoYW5pc21zIGluIHRoZSBMaW51eCBrZXJuZWwgYW5kIEkgaGF2ZSBzZWVuIHN1Y2ggY2xh
aW1zDQpmb3IgdGhlIFBPU0lYIG11dGV4LiBBcmUgdGhlcmUgYW55IHNpbWlsYXIgcmVxdWlyZW1l
bnRzIGZvciBEUERLIHJpbmcgYnVmZmVycz8NCg0KLSBPbGENCg0KPiBJIHJlYWxpc2UgdGhlIHBl
cmYgZGF0YSBpbiB0aGUgYmxvZyBwb3N0IGFib3V0DQo+IHRoaXMgc2hvd3MgaXQgYmVpbmcgc2xv
d2VyLCBidXQgZm9yIGVucXVldWVzIGFuZCBkZXF1ZXVlcyBvZiBidXJzdHMsIG9mDQo+IGUuZy4g
OCwgcmF0aGVyIHRoYW4ganVzdCAxLCBpcyB0aGVyZSBhIHZlcnkgYmlnIGRlbHRhPw0KPg0KPg0K
PiBSZWdhcmRzLA0KPiAvQnJ1Y2UNCg0KDQoNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50
cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQg
bWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lw
aWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlz
Y2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1
cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRo
YW5rIHlvdS4NCg==
