Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDFACAC59A
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 12:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA524402C3;
	Wed, 17 Sep 2025 14:50:26 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
 by mails.dpdk.org (Postfix) with ESMTP id B73AF40144
 for <dev@dpdk.org>; Wed, 17 Sep 2025 11:06:06 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Pdg5I8X9idDtV4BWcmqgYts2oD4mv9QTS+9NH2LsDuhJJPgFxohIk9w65/fdTdVxgW3l9jJP/AIWxPIo7wFX11FmUVgMvmJ4Y5judMJLlt9NJAaJBqShtOh9VKSLhB/CWlrxImwJ+IpuxBs8+cmM03UPqwEsJy1scJ+aCcjsu11RIbCkUmnaBxLO1CwXXBOL897bBUSU19wCCVDUta6mfMw2BcY1hSc4hoLn7P8G33jJjmNlnPQKMzZy7VYql5zk5VhN1guhceutcXBWenol0G6P7nLIlN165JfWWjMspV/YfMb4lwpmu13pamP0IZXvzxWTLp0uFBorp7MyMa7rUA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l9psfvFk2FFt9/znaoeJtLPeTRJ8atizfc4C8CaqN8=;
 b=UP2VMVZKU+Q1n1O6IQ8N3Njy594UL8e3bxpqGkh/XaJH0HDf6boxLLWt7H8KtWH1SQA9vVkyCfN5e5iEPEhcXATlnCuBBn5CUToiUen90AFIiEhvPhLqe9ztbLynjooyW1+wzsVpyojHfZ6M8KtUJ7F+3xUYgXvWWeCvMywEEnqAu+Ys45qDNEZCxfDO+cIUDLiQ/53GAa+uFPq1IR9szja9tmnavlLUu+wseRlIjlkEqD6/s+FwAilTYHz8LY6odEAXfXJZ3rtvrBDw93gKrBv2Id6PDiVjDU3q+ot6q0pZ2Yrs4i6R9YBrDFcNML3XkS/Fa1ncHSl9WORcDMnlXA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l9psfvFk2FFt9/znaoeJtLPeTRJ8atizfc4C8CaqN8=;
 b=agmQo+32rrNFCXt8KKKc28DS+Ar0EPNr2Xdk9gRiSMDEkQHwgofUQqDQ3iGbPxyYNDJL2to5XGxyBRZp70RhRd5DO988o366ur3i4CFhkI35EURZCHbBOVEvRvFMFhrFJ0O2dwM16U2YreMgsPW+Wlrvexot3nJPNH6l2zh85d8=
Received: from AM0PR04CA0057.eurprd04.prod.outlook.com (2603:10a6:208:1::34)
 by AM0PR08MB5394.eurprd08.prod.outlook.com (2603:10a6:208:183::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 09:06:04 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:208:1:cafe::1b) by AM0PR04CA0057.outlook.office365.com
 (2603:10a6:208:1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Wed,
 17 Sep 2025 09:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Wed, 17 Sep 2025 09:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uhs+H43rRCPV1A17FenZ9P3noQZDylL9BJiay9klNHrthRUDFSc/kqHsP0DAvQO7IRtD+4Qw7MqhpMYMpRL1Nlwlec3D3+URUrwZalTUFuMscgaPcBvi/4QI+gHVjNKiNihl+g8BpYGUNfjsGx20SEW8HTLLD314ByOq5nfEaC5swVoRDyYqgG7iNeci+jEoDjNZSZw7HDutaeJP1t9DrElaOc1i6JuGwfox1/LhOEUcmpZcjT39MMtWxAbUm3y9Ojba/lfUrF/iKvyZT8rjyZayCYJMmW6T1yobPoLHkmPntxbk+drSOko6uKHtK2g+7sNidgi66BMNiqP62ZtBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l9psfvFk2FFt9/znaoeJtLPeTRJ8atizfc4C8CaqN8=;
 b=lRwDDZOGpeZWY6Q27edWyjOmGewhrNXoV6MspNNiBNuuQwXvyKxdsnhxm5UzvkW6aiFUB47GyiqzUnDI94OsyNSi7M3zjp96aIUXhhcaefCiAsSAwJBOcsMBQx1/H3R7lvnXKbvrqZolGRx3L5WJQZKRbADFx81f+d/whcmnPka3Upm2e0mruiZgI3oS6/TZJNtChd6habDSjhm0y+5HasxBAV/lrQz4mt6D87GTSllwvUeHLeYutSKLqQegtPLLHHlZFBIjzb77MKXtmIHFtBCQ6FJUp+wCR10d6x1U8K7DxDEIWXH5hyAygv/+ac/6IMpitVMofZWGVDeiWHTMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l9psfvFk2FFt9/znaoeJtLPeTRJ8atizfc4C8CaqN8=;
 b=agmQo+32rrNFCXt8KKKc28DS+Ar0EPNr2Xdk9gRiSMDEkQHwgofUQqDQ3iGbPxyYNDJL2to5XGxyBRZp70RhRd5DO988o366ur3i4CFhkI35EURZCHbBOVEvRvFMFhrFJ0O2dwM16U2YreMgsPW+Wlrvexot3nJPNH6l2zh85d8=
Received: from DU0PR08MB9557.eurprd08.prod.outlook.com (2603:10a6:10:44e::14)
 by PAWPR08MB9687.eurprd08.prod.outlook.com (2603:10a6:102:2ee::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 09:05:30 +0000
Received: from DU0PR08MB9557.eurprd08.prod.outlook.com
 ([fe80::fdd1:fe93:89d8:1c07]) by DU0PR08MB9557.eurprd08.prod.outlook.com
 ([fe80::fdd1:fe93:89d8:1c07%3]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 09:05:30 +0000
From: Ola Liljedahl <Ola.Liljedahl@arm.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcJnJiBml2HHEBUEWClQ4fxxecK7SWYP5wgABfdICAADf1oIAAQKiA
Date: Wed, 17 Sep 2025 09:05:30 +0000
Message-ID: <4173E44D-BB31-45B9-AF6A-553B1E755604@arm.com>
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
 <a5fae8a9edc947fdbaf4e2519c39f93e@huawei.com>
 <2a611c3cf926d752a54b7655c27d6df874a2d0de.camel@arm.com>
 <61a9d5b157be4816aa296194f9c0eabe@huawei.com>
In-Reply-To: <61a9d5b157be4816aa296194f9c0eabe@huawei.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.100.25090553
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DU0PR08MB9557:EE_|PAWPR08MB9687:EE_|AMS1EPF00000044:EE_|AM0PR08MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: fa010717-0fef-4881-6556-08ddf5c96daa
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|13003099007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?eG9uMFNGaDU1UjkrK1l0SG1oK2phVFFxZ0pWNEMvQjlUUjVURnlOb1pmTHYz?=
 =?utf-8?B?dEdkOHdnUGpUU2NIZDR1UzdaZXJ2UFpIaTVscUhHMDlOL3lHSHdGditPNktM?=
 =?utf-8?B?MmRLSUxOWGE1MkR0R2hwTyt0cVBEK3FRelBvaEVmSVVVaUpiM0hNU0RGcnVJ?=
 =?utf-8?B?a0Q4TDk0c291eGllSTNwSUYwWHdBemRqMjRtSVc4RUIxVDdVNk9ldEN0RnFJ?=
 =?utf-8?B?MlZ4UnhKd1FyQkFETE5TbXdkNHpvbFZQN0d6bjVXRWZldnh6WDcxdkg5SjFp?=
 =?utf-8?B?UmxBK24zOFhWNEI0VVpMVm4xNE55RXpHVkRaNVJZNDBydTlhZ3kzc3E4RFJM?=
 =?utf-8?B?REtQWm9rNE9yTDRHSSthcW1PNG5IVEYwWXd1WkV3R0VMOVZPdTBPUWpJU0Ux?=
 =?utf-8?B?NUJYQUYzL3dzSDVDL0ZUMk9Pem4vQlNqMktUakRiV2ZYTWt6VThSRWl3aTJv?=
 =?utf-8?B?WVo3YU1yOUxTMEhQZ0RhRHl0a3hqMWQ5OFhhaEJVY3VsNWx0THFCNnF3bVgv?=
 =?utf-8?B?UWhEU1hmZ0NPSlI3elp6NFdyUEs2aU1CMXI5SktCSDVseTNpemwzRkdLU1NX?=
 =?utf-8?B?QkU5SXdwRmcyTUg3WTVXdXBVS3BJanJOblpsY1A3NHRCVG9XR0Mvc2xnbnNN?=
 =?utf-8?B?NkNZWHR1dnNsZUZZVk4zdVFUanVVTUJYOVYxNUN3dnE4L0N2ekZQQ2MvdzVY?=
 =?utf-8?B?SkNGbUVrL0xYTTJ5K1VwWEhiRStmbk5QR0ZzVG9OT1lSUG15N2V2RHhaRE9F?=
 =?utf-8?B?V0t1NmxHVnFUZ2RVMVFnTmw5NW5IZG1EVUNMTERwa1Nrb1RVa1dIdG5zMzdE?=
 =?utf-8?B?cno2cW5IWExHa0hSSW9PTFhrMzY5WTRNL1EwZ0NxUnJabEptODB2aVhBSnBt?=
 =?utf-8?B?N0RuTXdtWWFJaWF0SGxHM2M4T0pIT0dRWlA3aFVWTFV6RlVPMWNFTC9xSWgx?=
 =?utf-8?B?TGhlZzBsTTR1alZjMzNPYTRsTUZyUHNieTFHUGNraWtrWld1ckRUaTYvVFpG?=
 =?utf-8?B?ZnVETjJ6Yml5a2k4QVI4REpiRzh6U2FyNmdoazI4Rjcwa29EcVM0bFpmRThN?=
 =?utf-8?B?aktNbUkwMVU4ckxncFVqTG9ZK3ZlVy9jVkFHY0dSaW12azR4a0NwNGM0Mll1?=
 =?utf-8?B?Z2EzSDJ0QTRpWDcyOFlscDhhend2elZJS0s2MU1rbzVmakxndjl6dFEvbEgx?=
 =?utf-8?B?dlE1MFM4Z2RCWVdBVHgveW1EcVBmSlZmVVZrZW1DaHdzY1ZEK3cxbmNKU09L?=
 =?utf-8?B?ckJjaHVhMlcxSjJuMXRGNGp5bzhDeTBrMnpjemZSOGNzUGpGamlMZ0RYY2lM?=
 =?utf-8?B?VDhJMXRMa25aTWY4NVp2RjVpZXdha3ArSTJweGd3bElZMk1NQ01tMVdlQkcv?=
 =?utf-8?B?K1QrNnJGSGZPV0ZHSGo4UEhwb1B0RDJ5ZVIvQUxHbURKOFFzU0hubURQeldj?=
 =?utf-8?B?M1JkODFKc2hEclFvN01FYURCQlFuQlJ2dTIzNVlIUklpeHVsMUZ0d0M3bnl1?=
 =?utf-8?B?UDlXYXFRVEZ1YVJXSmZ5WFZzL0c0NDhFbzFtRVRJb3RPa1lTMGFTcnZHQm8r?=
 =?utf-8?B?ZzBzZnBiVnFxODVnZGlLejRPTzVCUFBBd3M3V2JqN09RTFdncVU1U3NtTExS?=
 =?utf-8?B?d0lVVFgvMlVXS08xWjdwRG1mbDJoVTJYVzhQZ3JwTHkzM0JwemR5S3Z3NmFO?=
 =?utf-8?B?elpJNHFFTkxFREhEcnVlT1FQUkVHOCtpWk9zck9NbmVnMFhEbDdoa1R1OHZp?=
 =?utf-8?B?ei93K0txTDYvTmxoWnZmVm55SjloYVI0ckp3ZWFhM2wrT2RtVUxiV0N4KzU3?=
 =?utf-8?B?YVlYZFkrcWs3T2FiUTBManpoeWJrZFJkQUNkczI1OXIwTnRCa3ZVRmExOWNN?=
 =?utf-8?B?WDZISlQ3VE5ldnQ5QUl5MzFDKzNUQ1RWWVVpOTVaV3FRQ1BRb3UyMi9oSXJi?=
 =?utf-8?Q?RlY0rydN/+9XHhUPe1uJQxi+GaIkg+Kk?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU0PR08MB9557.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <646ADB3168BEDF42B0B55BC3F0E6007B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9687
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8b6b39c3-48af-40bd-f0e6-08ddf5c95a0f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|35042699022|14060799003|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmZnekt1N2lYVC81NUc3czJibGNoWGdNMk96c3ZsY09xRjBvaU95c0VrcnNk?=
 =?utf-8?B?MmZqdGRQMU5OTXpjcmFWbW12Q2M3WXJMT24xRzNPcTZ4Y0hERnVSUG0zVEpn?=
 =?utf-8?B?NldxdEo1cDVRL05CQzdpRHp3WVZnVlZJemtWSFR0Rlcyd0JYRFUvTUU5Vzlj?=
 =?utf-8?B?SE5QVHJVRjF0ZEdsRHhnMGhuY1VtWS9ucmNWTHVUMVd5dkt6cHg2TVkvZFUv?=
 =?utf-8?B?UUcrTkEySHJOMjNPWTFjU2ExTDEyOVhPem5XVUN3VFRhVjEwWVFFL3BPc3Q1?=
 =?utf-8?B?WE95ckkxZEM0Skl3aWtYRStVWm9mTU1zcFo1N1EwMitVT0xhZmpLYkVPZ09F?=
 =?utf-8?B?dlBQQ1ZSbWpQTlFqdi8xeisreERXenlNZlVoMkpsNGlYRFFNU1I3cWdXanMx?=
 =?utf-8?B?SDNhcDJqUVBOZUx6eTY4dlh3ZjFlS255bFFVRHhzaHcraEVTQW1GK1F2eXZw?=
 =?utf-8?B?TGUzWmdDVmhUd2s5QzVHMzdDTXMrMkVEOCsvQnVNZGxMczlIbXdCTTJLYU5h?=
 =?utf-8?B?VDBUNWwwT00wbVh0YVVwNEJlNFZyWUpEL3JqMWxyS2VZNFdmUWhBbjl3akxV?=
 =?utf-8?B?R296TlF1RGxHTVZsbXd2ZTBZWDhJNnZZM09sbG55SmU3OTdLRlhEZThaRVpY?=
 =?utf-8?B?QXowQW93TS84NGJiL1YwS0d0N3FnQk9DOXd6YjVseDJGa1Y0Y2Y0UE4yV2xy?=
 =?utf-8?B?M2prQTlIeE1tZDlPdVd3bitWeUdtYUdLL2lRVGpndWJyMTdlRWQ4WjkzSVZ1?=
 =?utf-8?B?TzhrdWdMQzk0aE0rVGxnZFVGNHRUMHd6VENxR1JYVTAyY2Fqb1o1WFhNbDFm?=
 =?utf-8?B?bjYzT0NOUTN5MElYeVlwQWx5YmNHU1g4YmhsNjBESFc1RjdjM3ZZaTlDN2Jy?=
 =?utf-8?B?akF0Ymovc1RDWW1lRTdNWVB0NzNYclVwbk5JMnAxVmlKbzNxRkREVTBabXRZ?=
 =?utf-8?B?Ny9wbTV1WnFIQ1NMMEkrbHBGRkt1a1pja2VyOHB1UFZoaUU5SzNVWThqSHN4?=
 =?utf-8?B?bXZqT1RPSkpvY1VFOHlWQ3FSTlMwNEhZRFNURndEVHRiOXNyUkxXM0FpcnZt?=
 =?utf-8?B?alBHV0kwbTN4UVpqTEJmTFRmdHVremoweE9EaGNxLzR0NVpsRyt6RVFNNG0y?=
 =?utf-8?B?S3J2Um1WcnREKzh5b3hSNWw0YW9uRUZ1d0xkWDJhRW1SOXNwR05DOFFiMTA4?=
 =?utf-8?B?U0hVZ3ZxSmVDVFBCa3JrTFJaa0ttZ0FybmdFaFlYdUNZSmhRQzhoTjFJSjZl?=
 =?utf-8?B?S3BEalJqaGxiWHFjT2ZXYU40RFlIaERQam1UYWlZRkxLQk50aEFNYm5ndFFD?=
 =?utf-8?B?SmZtOG5aNVo4YUJZZjgyZmU2K0E4S0xsV3B4R1RkV3c3RTZOK3NZMWRVMUpP?=
 =?utf-8?B?dUdXQ2lIMHhrR09FWmlFUkNoUjgrZHY2Rk9VRTVmRWhRWGI2UjNpODUwcm1L?=
 =?utf-8?B?RzFqZEREL0ZBWGNJRlZEc2JxVVcyQWRYOXZRdldsT3Y3dTJGVURxOHdyU0NL?=
 =?utf-8?B?cmRHc2RVbzI1TXpoNzY5VWxPK2puUVQ1SmRwcTZlSzFHOHpjUmNCSDlOTVNn?=
 =?utf-8?B?RFFBOUdISXdnR3JGdzF4V0NEOTVJVVQzdHBvajNaSEc4aFhDZnpjN2hEZDky?=
 =?utf-8?B?c09mSW43SlhtOWJaMXlMTUNGaS9JbllwTURUc09zNnN1OWFGalhhbzJ5a3BC?=
 =?utf-8?B?L0NueDZPcVFDUjlscTBWWHBXYjZGOXY2SHM1K254ZmVCMnVhSytydnFoaW1X?=
 =?utf-8?B?bHRJc3NUcENCeFEyTWRFY1ZVQkkxeFJYM243NWFjUUZjektqT0RzK2ZFWjNF?=
 =?utf-8?B?VWFRRElBUjdnSkRrdjlhWUxlUXcyRGdKYldkemRVMHdUWnlCMWJsK2U0TVda?=
 =?utf-8?B?KzRNTldZZVpwSzU1eWs5RnQrNzZVRVlkcEF6TkErLzMwbXlsWmFDakJqeitk?=
 =?utf-8?B?VXZuL01Wb2J4M2V2bFkwVExYeXVOdTVES1BhSHdEVzV3UFlZMTdrLzdZalM0?=
 =?utf-8?Q?wrYO1rQu2VkqYctsXHvA9k0FYxBmcE=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(35042699022)(14060799003)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:06:03.2419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa010717-0fef-4881-6556-08ddf5c96daa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5394
X-Mailman-Approved-At: Wed, 17 Sep 2025 14:50:24 +0200
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

PiBPbiAyMDI1LTA5LTE3LCAwOTo1OCwgIktvbnN0YW50aW4gQW5hbnlldiIgPGtvbnN0YW50aW4u
YW5hbnlldkBodWF3ZWkuY29tIDxtYWlsdG86a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+
PiB3cm90ZToNCj4NCj4gVG8gYXZvaWQgaW5mb3JtYXRpb24gbG9zcyBJIGNvbWJpbmVkIHJlcGx5
IHRvIHR3byBXYXRoc2FsYSByZXBsaWVzIGludG8gb25lLg0KPg0KPg0KPiA+ID4gPiBUaGUgZnVu
Y3Rpb24gX19ydGVfcmluZ19oZWFkdGFpbF9tb3ZlX2hlYWQoKSBhc3N1bWVzIHRoYXQgdGhlDQo+
ID4gPiA+IGJhcnJpZXINCj4gPiA+IChmZW5jZSkgYmV0d2VlbiB0aGUgbG9hZCBvZiB0aGUgaGVh
ZCBhbmQgdGhlIGxvYWQtYWNxdWlyZSBvZiB0aGUNCj4gPiA+ID4gb3Bwb3NpbmcgdGFpbCBndWFy
YW50ZWVzIHRoZSBmb2xsb3dpbmc6IGlmIGEgZmlyc3QgdGhyZWFkIHJlYWRzDQo+ID4gPiA+IHRh
aWwNCj4gPiA+ID4gYW5kIHRoZW4gd3JpdGVzIGhlYWQgYW5kIGEgc2Vjb25kIHRocmVhZCByZWFk
cyB0aGUgbmV3IHZhbHVlIG9mDQo+ID4gPiA+IGhlYWQNCj4gPiA+ID4gYW5kIHRoZW4gcmVhZHMg
dGFpbCwgdGhlbiBpdCBzaG91bGQgb2JzZXJ2ZSB0aGUgc2FtZSAob3IgYSBsYXRlcikNCj4gPiA+
ID4gdmFsdWUgb2YgdGFpbC4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBhc3N1bXB0aW9uIGlzIGlu
Y29ycmVjdCB1bmRlciB0aGUgQzExIG1lbW9yeSBtb2RlbC4gSWYgdGhlDQo+ID4gPiA+IGJhcnJp
ZXINCj4gPiA+ID4gKGZlbmNlKSBpcyBpbnRlbmRlZCB0byBlc3RhYmxpc2ggYSB0b3RhbCBvcmRl
cmluZyBvZiByaW5nDQo+ID4gPiA+IG9wZXJhdGlvbnMsDQo+ID4gPiA+IGl0IGZhaWxzIHRvIGRv
IHNvLiBJbnN0ZWFkLCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvbmx5DQo+ID4gPiA+IGVu
Zm9yY2VzIGENCj4gPiA+ID4gcGFydGlhbCBvcmRlcmluZywgd2hpY2ggY2FuIGxlYWQgdG8gdW5z
YWZlIGludGVybGVhdmluZ3MuIEluDQo+ID4gPiA+IHBhcnRpY3VsYXIsDQo+ID4gPiA+IHNvbWUg
cGFydGlhbCBvcmRlcnMgY2FuIGNhdXNlIHVuZGVyZmxvd3MgaW4gZnJlZSBzbG90IG9yIGF2YWls
YWJsZQ0KPiA+ID4gPiBlbGVtZW50IGNvbXB1dGF0aW9ucywgcG90ZW50aWFsbHkgcmVzdWx0aW5n
IGluIGRhdGEgY29ycnVwdGlvbi4NCj4gPiA+DQo+ID4gPiBIbW0uLi4gc291bmRzIGV4YWN0bHkg
bGlrZSB0aGUgcHJvYmxlbSBmcm9tIHRoZSBwYXRjaCB3ZSBkaXNjdXNzZWQNCj4gPiA+IGVhcmxp
ZXIgdGhhdCB5ZWFyOg0KPiA+ID4gaHR0cHM6Ly9wYXRjaHdvcmsuZHBkay5vcmcvcHJvamVjdC9k
cGRrL3BhdGNoLzIwMjUwNTIxMTExNDMyLjIwNzkzNi00LWtvbnN0YW50aW4uYW5hbnlldkBodWF3
ZWkuY29tIDxtYWlsdG86MjAyNTA1MjExMTE0MzIuMjA3OTM2LTQta29uc3RhbnRpbi5hbmFueWV2
QGh1YXdlaS5jb20+Lw0KPiA+ID4gSW4gdHdvIHdvcmRzOg0KPiA+ID4gIi4uLiB0aHJlYWQgY2Fu
IHNlZSAnbGF0ZXN0JyAnY29ucy5oZWFkJyB2YWx1ZSwgd2l0aCAncHJldmlvdXMnIHZhbHVlDQo+
ID4gPiBmb3IgJ3Byb2QudGFpbCcgb3IgdmlzYS12ZXJzYS4NCj4gPiA+IEluIG90aGVyIHdvcmRz
OiAnY29ucy5oZWFkJyB2YWx1ZSBkZXBlbmRzIG9uICdwcm9kLnRhaWwnLCBzbyBiZWZvcmUNCj4g
PiA+IG1ha2luZyBsYXRlc3QgJ2NvbnMuaGVhZCcNCj4gPiA+IHZhbHVlIHZpc2libGUgdG8gb3Ro
ZXIgdGhyZWFkcywgd2UgbmVlZCB0byBlbnN1cmUgdGhhdCBsYXRlc3QNCj4gPiA+ICdwcm9kLnRh
aWwnIGlzIGFsc28gdmlzaWJsZS4iDQo+ID4gPiBJcyB0aGF0IHRoZSBvbmU/DQo+DQo+DQo+ID4g
WWVzLCB0aGUgYmVoYXZpb3Igb2NjdXJzIHVuZGVyIFJDcGMgKExEQVBSKSBidXQgbm90IHVuZGVy
IFJDc2MgKExEQVIpLA0KPiA+IHdoaWNoIGlzIHdoeSB3ZSBkaWRu4oCZdCBjYXRjaCBpdCBlYXJs
aWVyLiBBIGZ1bGxlciBleHBsYW5hdGlvbiwgd2l0aA0KPiA+IEhlcmQ3IHNpbXVsYXRpb25zLCBp
cyBpbiB0aGUgYmxvZyBwb3N0IGxpbmtlZCBpbiB0aGUgY292ZXIgbGV0dGVyLg0KPiA+DQo+ID4g
aHR0cHM6Ly9jb21tdW5pdHkuYXJtLmNvbS9hcm0tY29tbXVuaXR5LWJsb2dzL2IvYXJjaGl0ZWN0
dXJlcy1hbmQtcHJvY2Vzc29ycy1ibG9nL3Bvc3RzL3doZW4tYS1iYXJyaWVyLWRvZXMtbm90LWJs
b2NrLXRoZS1waXRmYWxscy1vZi1wYXJ0aWFsLW9yZGVyIDxodHRwczovL2NvbW11bml0eS5hcm0u
Y29tL2FybS1jb21tdW5pdHktYmxvZ3MvYi9hcmNoaXRlY3R1cmVzLWFuZC1wcm9jZXNzb3JzLWJs
b2cvcG9zdHMvd2hlbi1hLWJhcnJpZXItZG9lcy1ub3QtYmxvY2stdGhlLXBpdGZhbGxzLW9mLXBh
cnRpYWwtb3JkZXI+DQo+DQo+DQo+IEkgc2VlLCBzbyBub3cgaXQgaXMgcmVwcm9kdWNpYmxlIHdp
dGggY29yZSBydGVfcmluZyBvbiByZWFsIEhXLg0KPg0KPg0KPiA+ID4NCj4gPiA+ID4gVGhlIGlz
c3VlIG1hbmlmZXN0cyB3aGVuIGEgQ1BVIGZpcnN0IGFjdHMgYXMgYSBwcm9kdWNlciBhbmQgbGF0
ZXINCj4gPiA+ID4gYXMgYQ0KPiA+ID4gPiBjb25zdW1lci4gSW4gdGhpcyBzY2VuYXJpbywgdGhl
IGJhcnJpZXIgYXNzdW1wdGlvbiBtYXkgZmFpbCB3aGVuDQo+ID4gPiA+IGFub3RoZXINCj4gPiA+
ID4gY29yZSB0YWtlcyB0aGUgY29uc3VtZXIgcm9sZS4gQSBIZXJkNyBsaXRtdXMgdGVzdCBpbiBD
MTEgY2FuDQo+ID4gPiA+IGRlbW9uc3RyYXRlDQo+ID4gPiA+IHRoaXMgdmlvbGF0aW9uLiBUaGUg
cHJvYmxlbSBoYXMgbm90IGJlZW4gd2lkZWx5IG9ic2VydmVkIHNvIGZhcg0KPiA+ID4gPiBiZWNh
dXNlOg0KPiA+ID4gPiAoYSkgb24gc3Ryb25nIG1lbW9yeSBtb2RlbHMgKGUuZy4sIHg4Ni02NCkg
dGhlIGFzc3VtcHRpb24gaG9sZHMsDQo+ID4gPiA+IGFuZA0KPiA+ID4gPiAoYikgb24gcmVsYXhl
ZCBtb2RlbHMgd2l0aCBSQ3NjIHNlbWFudGljcyB0aGUgb3JkZXJpbmcgaXMgc3RpbGwNCj4gPiA+
ID4gc3Ryb25nDQo+ID4gPiA+IGVub3VnaCB0byBwcmV2ZW50IGhhemFyZHMuDQo+ID4gPiA+IFRo
ZSBwcm9ibGVtIGJlY29tZXMgdmlzaWJsZSBvbmx5IG9uIHdlYWtlciBtb2RlbHMsIHdoZW4gbG9h
ZC0NCj4gPiA+ID4gYWNxdWlyZSBpcw0KPiA+ID4gPiBpbXBsZW1lbnRlZCB3aXRoIFJDcGMgc2Vt
YW50aWNzIChlLmcuIHNvbWUgQUFyY2g2NCBDUFVzIHdoaWNoDQo+ID4gPiA+IHN1cHBvcnQNCj4g
PiA+ID4gdGhlIExEQVBSIGFuZCBMREFQVVIgaW5zdHJ1Y3Rpb25zKS4NCj4gPiA+ID4NCj4gPiA+
ID4gVGhyZWUgcG9zc2libGUgc29sdXRpb25zIGV4aXN0Og0KPiA+ID4gPiAxLiBTdHJlbmd0aGVu
IG9yZGVyaW5nIGJ5IHVwZ3JhZGluZyByZWxlYXNlL2FjcXVpcmUgc2VtYW50aWNzIHRvDQo+ID4g
PiA+IHNlcXVlbnRpYWwgY29uc2lzdGVuY3kuIFRoaXMgcmVxdWlyZXMgdXNpbmcgc2VxLWNzdCBm
b3INCj4gPiA+ID4gc3RvcmVzLA0KPiA+ID4gPiBsb2FkcywgYW5kIENBUyBvcGVyYXRpb25zLiBI
b3dldmVyLCB0aGlzIGFwcHJvYWNoIGludHJvZHVjZXMgYQ0KPiA+ID4gPiBzaWduaWZpY2FudCBw
ZXJmb3JtYW5jZSBwZW5hbHR5IG9uIHJlbGF4ZWQtbWVtb3J5DQo+ID4gPiA+IGFyY2hpdGVjdHVy
ZXMuDQo+ID4gPiA+DQo+ID4gPiA+IDIuIEVzdGFibGlzaCBhIHNhZmUgcGFydGlhbCBvcmRlciBi
eSBlbmZvcmNpbmcgYSBwYWlyLXdpc2UNCj4gPiA+ID4gaGFwcGVucy1iZWZvcmUgcmVsYXRpb25z
aGlwIGJldHdlZW4gdGhyZWFkIG9mIHNhbWUgcm9sZSBieQ0KPiA+ID4gPiBjaGFuZ2luZw0KPiA+
ID4gPiB0aGUgQ0FTIGFuZCB0aGUgcHJlY2VkaW5nIGxvYWQgb2YgdGhlIGhlYWQgYnkgY29udmVy
dGluZyB0aGVtDQo+ID4gPiA+IHRvDQo+ID4gPiA+IHJlbGVhc2UgYW5kIGFjcXVpcmUgcmVzcGVj
dGl2ZWx5LiBUaGlzIGFwcHJvYWNoIG1ha2VzIHRoZQ0KPiA+ID4gPiBvcmlnaW5hbA0KPiA+ID4g
PiBiYXJyaWVyIGFzc3VtcHRpb24gdW5uZWNlc3NhcnkgYW5kIGFsbG93cyBpdHMgcmVtb3ZhbC4N
Cj4gPiA+DQo+ID4gPiBGb3IgdGhlIHNha2Ugb2YgY2xhcml0eSwgY2FuIHlvdSBvdXRsaW5lIHdo
YXQgd291bGQgYmUgZXhhY3QgY29kZQ0KPiA+ID4gY2hhbmdlcyBmb3INCj4gPiA+IGFwcHJvYWNo
ICMyPyBTYW1lIGFzIGluIHRoYXQgcGF0Y2g6DQo+ID4gPiBodHRwczovL3BhdGNod29yay5kcGRr
Lm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNTA1MjExMTE0MzIuMjA3OTM2LTQtIDxodHRwczov
L3BhdGNod29yay5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNTA1MjExMTE0MzIuMjA3
OTM2LTQtPg0KPiA+IGtvbnN0YW50aW4uYW5hbnlldkBodWF3ZWkuY29tIDxtYWlsdG86a29uc3Rh
bnRpbi5hbmFueWV2QGh1YXdlaS5jb20+Lw0KPiA+ID4gT3Igc29tZXRoaW5nIGRpZmZlcmVudD8N
Cj4gPg0KPiA+IFNvcnJ5LCBJIG1pc3NlZCB0aGUgbGF0ZXIgaGFsZiB5b3UgeW91ciBjb21tZW50
IGJlZm9yZS4NCj4gPiBZZXMsIHlvdSBoYXZlIHByb3Bvc2VkIHRoZSBzYW1lIHNvbHV0aW9uIHRo
ZXJlLg0KPg0KPg0KPiBPaywgdGhhbmtzIGZvciBjb25maXJtYXRpb24uDQo+DQo+DQo+ID4gPg0K
PiA+ID4NCj4gPiA+ID4gMy4gUmV0YWluIHBhcnRpYWwgb3JkZXJpbmcgYnV0IGVuc3VyZSBvbmx5
IHNhZmUgcGFydGlhbCBvcmRlcnMNCj4gPiA+ID4gYXJlDQo+ID4gPiA+IGNvbW1pdHRlZC4gVGhp
cyBjYW4gYmUgZG9uZSBieSBkZXRlY3RpbmcgdW5kZXJmbG93IGNvbmRpdGlvbnMNCj4gPiA+ID4g
KHByb2R1Y2VyIDwgY29uc3VtZXIpIGFuZCBxdWFzaGluZyB0aGUgdXBkYXRlIGluIHN1Y2ggY2Fz
ZXMuDQo+ID4gPiA+IFRoaXMgYXBwcm9hY2ggbWFrZXMgdGhlIG9yaWdpbmFsIGJhcnJpZXIgYXNz
dW1wdGlvbg0KPiA+ID4gPiB1bm5lY2Vzc2FyeQ0KPiA+ID4gPiBhbmQgYWxsb3dzIGl0cyByZW1v
dmFsLg0KPiA+ID4NCj4gPiA+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHNvbHV0aW9uICgzKSBm
b3IgcGVyZm9ybWFuY2UgcmVhc29ucy4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
V2F0aHNhbGEgVml0aGFuYWdlIDx3YXRoc2FsYS52aXRoYW5hZ2VAYXJtLmNvbSA8bWFpbHRvOndh
dGhzYWxhLnZpdGhhbmFnZUBhcm0uY29tPj4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogT2xhIExp
bGplZGFobCA8b2xhLmxpbGplZGFobEBhcm0uY29tIDxtYWlsdG86b2xhLmxpbGplZGFobEBhcm0u
Y29tPj4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEhvbm5hcHBhIE5hZ2FyYWhhbGxpIDxob25uYXBw
YS5uYWdhcmFoYWxsaUBhcm0uY29tIDxtYWlsdG86aG9ubmFwcGEubmFnYXJhaGFsbGlAYXJtLmNv
bT4+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBEaHJ1diBUcmlwYXRoaSA8ZGhydXYudHJpcGF0aGlA
YXJtLmNvbSA8bWFpbHRvOmRocnV2LnRyaXBhdGhpQGFybS5jb20+Pg0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gbGliL3JpbmcvcnRlX3JpbmdfYzExX3B2dC5oIHwgMTAgKysrKysrKy0tLQ0KPiA+ID4g
PiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4g
Pg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbGliL3JpbmcvcnRlX3JpbmdfYzExX3B2dC5oDQo+ID4g
PiA+IGIvbGliL3JpbmcvcnRlX3JpbmdfYzExX3B2dC5oDQo+ID4gPiA+IGluZGV4IGI5Mzg4YWYw
ZGEuLmU1YWMxZjZiOWUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2xpYi9yaW5nL3J0ZV9yaW5nX2Mx
MV9wdnQuaA0KPiA+ID4gPiArKysgYi9saWIvcmluZy9ydGVfcmluZ19jMTFfcHZ0LmgNCj4gPiA+
ID4gQEAgLTgzLDkgKzgzLDYgQEAgX19ydGVfcmluZ19oZWFkdGFpbF9tb3ZlX2hlYWQoc3RydWN0
DQo+ID4gPiA+IHJ0ZV9yaW5nX2hlYWR0YWlsDQo+ID4gPiA+ICpkLA0KPiA+ID4gPiAvKiBSZXNl
dCBuIHRvIHRoZSBpbml0aWFsIGJ1cnN0IGNvdW50ICovDQo+ID4gPiA+IG4gPSBtYXg7DQo+ID4g
PiA+DQo+ID4gPiA+IC0gLyogRW5zdXJlIHRoZSBoZWFkIGlzIHJlYWQgYmVmb3JlIHRhaWwgKi8N
Cj4gPiA+ID4gLSBydGVfYXRvbWljX3RocmVhZF9mZW5jZShydGVfbWVtb3J5X29yZGVyX2FjcXVp
cmUpOw0KPiA+ID4gPiAtDQo+ID4gPiA+IC8qIGxvYWQtYWNxdWlyZSBzeW5jaHJvbml6ZSB3aXRo
IHN0b3JlLXJlbGVhc2Ugb2YNCj4gPiA+ID4gaHQtPnRhaWwNCj4gPiA+ID4gKiBpbiB1cGRhdGVf
dGFpbC4NCj4gPiA+ID4gKi8NCj4gPiA+DQo+ID4gPiBCdXQgdGhlbiBjb25zLmhlYWQgY2FuIGJl
IHJlYWQgYSBiZWZvcmUgcHJvZC50YWlsIChhbmQgdmlzYS12ZXJzYSksDQo+ID4gPiByaWdodD8N
Cj4gPg0KPiA+IFJpZ2h0LCB3ZSBsZXQgaXQgaGFwcGVuIGJ1dCBlbGltaW5hdGUgYW55IHJlc3Vs
dGluZyBzdGF0ZXMgdGhhdCBhcmUNCj4gPiBzZW1hbnRpY2FsbHkgaW5jb3JyZWN0IGF0IHRoZSBl
bmQuDQo+DQo+DQo+IFR3byBjb21tZW50cyBoZXJlOg0KPiAxKSBJIHRoaW5rIGl0IGlzIHByb2Jh
Ymx5IHNhZmVyIHRvIGRvIHRoZSBjaGVjayBsaWtlIHRoYXQ6DQo+IElmICgqZW50cmllcyA+IHJp
bmctPmNhcGFjaXR5KSAuLi4NClllcywgdGhpcyBtaWdodCBiZSBhbm90aGVyIHdheSBvZiBoYW5k
bGluZyB1bmRlcmZsb3cgc2l0dWF0aW9ucy4gV2UgY291bGQgc3R1ZHkgdGhpcy4NCg0KSSBoYXZl
IHVzZWQgdGhlIGNoZWNrIGZvciBuZWdhdGl2ZSB3aXRob3V0IHByb2JsZW1zIGluIG15IHJpbmcg
YnVmZmVyIGltcGxlbWVudGF0aW9ucw0KaHR0cHM6Ly9naXRodWIuY29tL0FSTS1zb2Z0d2FyZS9w
cm9ncmVzczY0L2Jsb2IvbWFzdGVyL3NyYy9wNjRfcmluZ2J1Zi5jDQpidXQgY2FuJ3Qgc2F5IHRo
YXQgaGFzIGJlZW4gYmF0dGxlLXRlc3RlZC4NCg0KPiAyKSBNeSBjb25jZXJuIHRoYXQgd2l0aG91
dCBmb3JjaW5nIGEgcHJvcGVyIHJlYWQgb3JkZXJpbmcNCj4gKGNvbnMuaGVhZCBmaXJzdCB0aGVu
IHByb2QudGFpbCkgd2UgcmUtaW50cm9kdWNlIGEgd2luZG93IGZvciBhbGwgc29ydHMgb2YNCj4g
QUJBLWxpa2UgcHJvYmxlbXMuDQpIZWFkIGFuZCB0YWlsIGluZGV4ZXMgYXJlIG1vbm90b25pY2Fs
bHkgaW5jcmVhc2luZyBzbyBJIGRvbid0IHNlZSBhIHJpc2sgZm9yIEFCQS1saWtlIHByb2JsZW1z
Lg0KSW5kZWVkLCBhZGRpbmcgYSBtb25vdG9uaWNhbGx5IGluY3JlYXNpbmcgdGFnIHRvIHBvaW50
ZXJzIGlzIHRoZSBjb21tb24gd2F5IG9mIGF2b2lkaW5nIEFCQQ0KcHJvYmxlbXMgaW4gbG9jay1m
cmVlIGRlc2lnbnMuDQoNCi0gT2xhDQoNCklnbm9yZSB0aGUgZm9sbG93aW5nIGF1dG8tYWRkZWQg
ZGlzY2xhaW1lci4NCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1h
aWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBw
cml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ug
bm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29u
dGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3Rv
cmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
