Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0BFCA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 02:43:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20A7B402EF;
	Tue, 12 Aug 2025 04:43:48 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 154004026C;
 Tue, 12 Aug 2025 04:43:45 +0200 (CEST)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BIgN4g028014;
 Mon, 11 Aug 2025 22:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=B
 QK50U54yzzFtx/soozja1rQEd2VuYva0SOqzZRRZGw=; b=BLvOAcAEl6JK311Gc
 mBOK6R8HDyMZboCFd7kGaP9DXGK93Q1uPcJ/mS9Z4vL3eIYgEd03gHyC1xdiJ9zn
 JH8ycAraDp31xji+DHy4IwW2Xxcp71JJ2KbsYYjH+NPmjag1zvEFsW6axYo5i7Qi
 NWL9R54cjdnvCqPDv9CSNvfpqX0Or6NAmF2LhlHsn3K1fehLdM1jlbGD7PfMMtIp
 mvcQjhcWZ1V3towVmQohEV2Ym7W6aihWF+eRnx0ETcM9/PtfmCjnwrX0grFYyLUZ
 cZmTIF20ojD4Z3+9mV4VDWoBTQvfFST29ZRlWicTrYE1NQm4JhqCQO9RzWOF3liS
 kVHug==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 48e1d7td6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Aug 2025 22:43:44 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C2dF75014486;
 Mon, 11 Aug 2025 22:43:43 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 48fux4rsqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 22:43:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTiRADIrcYJry3UGhKNXesMfJn7umCXOByS03pHrA2xoXWc/Q2uSiGIO3tSiXVPgWTOb64CZGssIKxFj9MNi6Mtlyd7IezFUnu2i0JxOgPBG53QiAhL4vBJtntfvjxjJhQskHH/H//BWONrFUJFlwyBZwWbitYC+Fo9lXfvm7rX7sEUt1r8g0DJSFJQe90llsuiboMy+h8PrnZoqpCvOcQfqGjKzmEJHz5dLb0esXkKbXz/4UT2iNR9sfjdKm9O0t/bJ/nGRkwwaJJ4hHTrewUaUF8z8N6nAswM7Ogq9ZdKflMbHMTJk5EwE/+BwvU5V7iRz9YfTuq1LOTjdLzIMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQK50U54yzzFtx/soozja1rQEd2VuYva0SOqzZRRZGw=;
 b=GVzeIekcqZ1MWqL1I4q9xj+gZpGoR7lh4Cq/hj8UVMVTimujiCsGV79HgzDN/hG/bWUuuq9kJgmEDd8jQu2CnAuZ8w4mrAFuVdZHn8umdtoQo89iD7OQgM3tVrP3rQYllGKGxB1IVMJAwaO7XPn+YD0myVo/XGcubsv4yzTKznc8PsSu/Ehm8At+SIsIGeXntni8grQVk6GKskZueGtn7OOMoOzalVNZcWvqQxGerAwWGknvoNewbX0ES+qB8zNcxObdoV2cCp89JtoqTamjoqmpdN5qDwBdWhaH9IShFoXogagksKICsLV4faKnwMzvhBNkOjZkScPE1TnMcboXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by CY5PR19MB6171.namprd19.prod.outlook.com (2603:10b6:930:2c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 02:43:39 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.8989.009; Tue, 12 Aug 2025
 02:43:39 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>,
 "Glimcher, Boris" <Boris.Glimcher@dell.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 0/3] PATCH 25.03.0: vhost_user: configure memory slots
Thread-Topic: [PATCH 0/3] PATCH 25.03.0: vhost_user: configure memory slots
Thread-Index: AQHcCCMnefk1Ssy/pEW6NuEFM/+pNbRddX6AgADe2rA=
Date: Tue, 12 Aug 2025 02:43:38 +0000
Message-ID: <SJ0PR19MB4606FDA04F9664D9924A65E0F52BA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20250808051305.2386231-1-pravin.bathija@dell.com>
 <2263105.NgBsaNRSFp@thomas>
In-Reply-To: <2263105.NgBsaNRSFp@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-08-12T02:39:22.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|CY5PR19MB6171:EE_
x-ms-office365-filtering-correlation-id: cdd344d6-43cc-4eef-e224-08ddd94a0ae9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-7?B?SVJpWVVMT0pPYzQwa1k2a0pwNVVkY3ExV0JsVVFNOHpONDBGbFRUZ2l3NkEv?=
 =?utf-7?B?NkpBV3BicVM1RXNWMWN5Y0xCMUtXdFIrLW9aamRKTXc2ZGpvdXp6d2dVTC9t?=
 =?utf-7?B?YlBXTEdhSHJoZU9zOVlnV01YSGJZNmNLclQvampKODZmaW41b2Z4bFlzakpr?=
 =?utf-7?B?a3hmNzZ5cUF1aTMrLS9Lc2cwYXd0em9iMzNqNHlHVVdHdjNYRlI4cEFoeHdG?=
 =?utf-7?B?dWNFZWdTZllBVlpjV3BKZElRekNVM3d1WU85ZlZpRE9nbWxXTlNKT1llNUN6?=
 =?utf-7?B?OEo5ckFRSE9INE8xKy1nTFJPeWo3MnFkVmZLVlQ0VWdCQ1pMKy1LZ0xnKy10?=
 =?utf-7?B?UUxrZDlyN1FUcTNtcmlSMndJVXhCdVpBeXdUMzNlVEp2SjJFQ2pMcFFxbGda?=
 =?utf-7?B?ckQrLWhpWGpURzdKVHF5anUwZ0dZYmJDQnF0UkFSU1Y4bEJEZC9raUszUWlt?=
 =?utf-7?B?UXY0VzFyQWlSNjFPMkE0ZXpCeGRrektPMEpCRXJWLzU4eTliRHZmQUJwb1Y5?=
 =?utf-7?B?TG5BYkdVY0xvV0NlQUJZejlYUFR6WFpLR0I5Q3dVckF4NFQ1MistZ2JHRGdH?=
 =?utf-7?B?VVpRTmJITWpidmRuMVd3M0hEaGt1VVZaSTN5bG1uYVNLRmJGdzNWQWVLbUFR?=
 =?utf-7?B?TDNtdFVpeGRQYistY3VZVlY3UlVwZHIva2xscGlQOHRtL0wyNDV1cTV3aldR?=
 =?utf-7?B?ZTBvRTYzTEdLUHRCblJSNy9FalFOUW9SNUxxYmpydjhDNGRQSktSdzRCRTFa?=
 =?utf-7?B?bnkyNERkYVNQKy1ld2hKcUZKd3o3Q04xT050dFg2a0pOYzVXek9aWlVKR0xk?=
 =?utf-7?B?a1FkTTdjKy1KQXpWbjVURlkrLU1EM0drSnJzQ3JpWFN4dy9DUldzQUh3NllT?=
 =?utf-7?B?SnJvcDlhU2crLTdOOEFIZHcwTzJzSXhrNE1VdTdMWXYyL2Y2MG1jWmFEYk5K?=
 =?utf-7?B?eEY5YW5FTy9nYmdiVkFHbTdIN29yY1crLTJvb252NWJ2RnVYekYrLUViTUta?=
 =?utf-7?B?ZENOWGpUS2lNVmQvbzJZdUtGMWUzSGx6dVRRM0xLOWNvTWVyMm9QQ0NzYy81?=
 =?utf-7?B?RmlQWTRqOFBSV29CaGoyQ1JrdlFCUnlabXNpSlVSN0pib0pVc3F5dTR6d1RS?=
 =?utf-7?B?RlUvRTRGbVNZazF1YnRMTG96Ky1zR2dWRXAxZlZTNzd1ZDlXWEs4elo0S0Nx?=
 =?utf-7?B?NWFNWUtON0lmUmhIL3h2TWlwTTVYcCstYTB2ai9XcXNjRERoQWpvZ25UTXdE?=
 =?utf-7?B?YlAxeXJXMnhvZWZieFU4aExsYystVVNGUVVpS0syUGlxYkxqRVo2eEErLXFS?=
 =?utf-7?B?Y20wR0l2ZjVpUC91WkxweHdxdlNURFBKNnBxR2t4eHkzblBBYTBxaVlyOUdC?=
 =?utf-7?B?REhFazhPT3ROWGdobTBvR2RUWDdEYi9MMko2ejhmUU13ZHdQKy10TVJUVUpF?=
 =?utf-7?B?UlBVeDNlVG9ZTmhSOG5SU2g3bmRScjExUWp4eSstWW1lM3V5dmF1bFU5Znc5?=
 =?utf-7?B?c1lhdDRvd0l1SExJYkh5Um85YlNmZG9FRDZiZVl3bldxMzI2UHhqRmJlSkZW?=
 =?utf-7?B?cTh4eXBFL09sZVViT2JjdystYTNUY2RRWlYzMnd4b1VkUzVrREZLb1V4cUpX?=
 =?utf-7?B?VFlBZTIzMnJEb0o3ekNTSG9laSstNFZ0SG1xMystMnVLSnVRemljdk53NEVz?=
 =?utf-7?B?VGxkbndPbGcvd0FmMVkzcHVVVVBoZXVDbGlKQlRPMTFDUkZHdk8xR3RuNzZ6?=
 =?utf-7?B?WGRLNVpJbmNubGpQdzZuTEJZQmhWLzdEaTlLR05idUJYTlNXUUxDZ0M0VHlH?=
 =?utf-7?B?akNGKy1tZEwyN1M0STFjZlBVQ0VQOWsyR1lHQW1LVmhXRUdLMzBKVEVidFQ2?=
 =?utf-7?B?ZTZLR2ZyL2xrNWJCbndnVXU0dExremx0a1RkRHdUdkJHUkowZExMblFTUno3?=
 =?utf-7?B?eHg3OSstM3hjTmZtelA4YmtEUjk2d3NTTUJnKy1RWlZHaks5UStBRDAt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?Ri8zbWZvcjBKSlpZM1B6aDc3V3ppVWJ1UWdVY1B6TEtaMnJuT2RYUkxwQSst?=
 =?utf-7?B?U0JsRXJqamxQQXBvSDA4YUZrSkFhS2doOWtwV28xdG55MGRsbUFkb1ZSSWRD?=
 =?utf-7?B?OHBORVJzaVJOSUxxTFhyYXVYbzl6Rnp6NGt2bHQ1amxGalRwdlJwSnB1OXlT?=
 =?utf-7?B?THhRQWZpN3RYemZCa3FYcnY4OXc2UEZ4R3BjZWdvZDUrLS9GenplWGcrLXZE?=
 =?utf-7?B?QmdWVVErLXFTenpEcEkyeHJzOUJWY2xSNHpYVjNsaUtzclF5WFVoZC96TGxC?=
 =?utf-7?B?MXlqNkE3RXV4ZExWMHkzRUo2NTJmU3B6cEVXTmpEQ01vZnFuY3dTMW00N1pY?=
 =?utf-7?B?NmtHb2lIN1FzcXJ0OGpLZU1nSGNnVHRQeEFZakk1ZFdWVFJYS0I4NUVZQTVq?=
 =?utf-7?B?U25ZM2phRnByZkFxQlRUVWk0dnBLaWI1TEVsMlpKZU5TelM4MmRQTWFlL3E1?=
 =?utf-7?B?Z0lSdnE1QndlbGNxV0tGQXB4MlhxNkhNNFk1MUJCalZ3VThqTXpDaVJKZXNF?=
 =?utf-7?B?NUszVistYXZRTWdaTmUrLXV0d0pTQ2lzUXlkeUd6Ky00L1lydjdSNWt6VVgw?=
 =?utf-7?B?bHRnQ1lRKy02ZzFicThSOGtsUTFxTU5tQnpJaFNiclF5bmZwZFRrY3VzVmJI?=
 =?utf-7?B?aCstbmNjNEowYXJXQkN1bVlkeGEzQklFYXY3RXFEbU5kODZRWnZNbDgvRmxr?=
 =?utf-7?B?QUtxQXNBY1crLTRGalp3ZEZuKy1DWW9KZ3kxdFpTOElydWJuKy1xcXNYc0Ju?=
 =?utf-7?B?TzJmREFLN01mSU9SaFlBdE56b3dPT0MvNzB0SEE3RWFoaFBXeUtjcVcwMEdZ?=
 =?utf-7?B?djZpN0xrNmlWdXArLW5iZnNkbW04V2FUM0VTVmJ3ZjY1OFFNVDRUTHZNbkxh?=
 =?utf-7?B?UFdnQk1GNk91RkVxZUdZKy1UZS95bHpHblE0alJadnIzbEJabFFDOVk1NXF4?=
 =?utf-7?B?dzBUcjlzS2RwbnJ5aTI0MXROYTdvbGYzUjloN1h0cTNDWGozKy1kREJUamh5?=
 =?utf-7?B?eWF3cUpuZGlDQXZiZzdoNlBqblZNNkpEbnl3bXczS3VyeW1KR2pnb0IvMjhx?=
 =?utf-7?B?R05jRDl3SmIwKy15clMwcWJpUCstN3dyOCstZVBpQ3U0dDBLQWhRNHB1dkIx?=
 =?utf-7?B?S3p6WTJhSkhYb1dEeEdmTXBZVWlVODl3YTN1REY1RS82OFE0TUtCMVNYYXpY?=
 =?utf-7?B?N0VqRkxsdXJBUG1zOUJWbHo0Vm12ZjV3anFhVjRPbFpKbDIvOHU0TGlGSW40?=
 =?utf-7?B?L3o2SGs2eHZCU2FtT2JVb3BxSDVNb3ROYlUvQnd2Q1M1R3UyUEVkOG9WOEVj?=
 =?utf-7?B?Rm82TzNwV1hnYW0vUkdqMVFPMUU1amZXTGY1MWJhbmM0bEhKZistbFVzbHlT?=
 =?utf-7?B?QkkxL003UklucU16WTBoOW5lNVNJV29RdjlxOFhUZGpETlNuTWlUSU9pSHpw?=
 =?utf-7?B?QUcwdS83SXRTc1VldWZCZFIvUDkxcUhZQW5WSFhLMHVIWUhiZzQ3eU1IZWxL?=
 =?utf-7?B?dzhPTystM1NXNG5BR0NvcndFTGRBOHBhMFpGU3pyUXhYdUFTZSstVXV1ZjRL?=
 =?utf-7?B?MkdjdUxrVzlUc1RwaUpkY0ZEZ1hubWhGbTRod2RySWRYbDRyajBPZnFuS2Zq?=
 =?utf-7?B?cDB3NmxRUmpDd2k5cEZYS3RMZ09UWWhlMUgwZXd6QlQwM2c2Ym1VQXhPNXRW?=
 =?utf-7?B?b3I0Vy9IZXpodENWeGNqQVlvTWpzL052TistdHYybk1XM01QTGZlSSstSll3?=
 =?utf-7?B?UW1CMVUrLTZXNXFtbUhWMlRTUzh6cmxhNHB3Q3dmYURoWC9qZVIyT1RkUVl4?=
 =?utf-7?B?MXR4NzR5UkhESW1ieE9vUjRBMkNjV0ZUd2JXM2RmT1dNZjV3alFSTnZoeDY1?=
 =?utf-7?B?Z0ZxcHNOZHdWS1ZEcGJObEUzb0hxbndyMUl4MWJDMWlGU0QzKy1YQ2VKMzJD?=
 =?utf-7?B?ZC9YdzBYckFiL3pVdTJrWkpNQ0RYQUh2TTl5dGZ0UjZ1TnI1YnVqamJvM2RF?=
 =?utf-7?B?U1dmKy1LdHZkTTBMNWhUU2FSL0JTZXU0SFRnWkZvS2tvZkhyOVZleTFSRXRx?=
 =?utf-7?B?dmJ3dlJCOVYxTDdrSDBpMFJqSFBnUDllVkRkZjVUbjBjbGVoNXpwd3hTZVZR?=
 =?utf-7?B?Zkc4WDFGRDZUZGk5STBPTCstbllDY2F1NUJZWWdHQjMyMFYxZEppN0NmcnR1?=
 =?utf-7?B?ZTFRc2FSSg==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd344d6-43cc-4eef-e224-08ddd94a0ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 02:43:38.9833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpDTadZT0KFLWTqc6Pv5niRm0xHO+72F9luNXQPwJFB1bpqF1w+PbFjjURYNAsW1TbdebVjwPeaeKBJgZz8jdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120024
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDAyNCBTYWx0ZWRfX5iR6l6fngrFA
 5TROvwtbFE4fLhzTq4NJoK2mhWWwMI89uJXJic/tV/G7n06iw9B4BR4jMRU0kibc8Iy5rn5Nvdp
 ftzgGujrtiAFnnviWFkb8P3Vs7I7el6CKipJzCn3MMRbtCw6kZopiQ0weYJVxZNIA0N69hcbz6E
 8HPhx5FLNerLXYdAkxaHyzvpG1GB7hw8J5D6EJnOaiM7Nnr0P0iauqbtL3UmFvSrKm/xnLDQd4Z
 bNIF1W4IMoafb1IFAJtE1rHnNmcIbJNEOJv879G0T2DnhNZS6jyEeunMJkTuJGm084U+0QdsuQ5
 eULUhGChfIrvu3v+47MbyA7VPpwCxVPqI0Llk+icuafsvXoroGSdaaknKP2NHVP+tdpvL4LoZqt
 VbaOXtxcBYWbBwxTDDGu/ZyOOE0ojW8vOfwEiy4ZrYzIWQaPEuEvn9rquM8MUnn5tV8RcsgH
X-Authority-Analysis: v=2.4 cv=fPk53Yae c=1 sm=1 tr=0 ts=689aaa61 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=2OwXVqhp2XgA:10 a=uherdBYGAAAA:8 a=8rWy6zfcAAAA:8
 a=bt5KbKNvAAAA:8 a=iLNU1ar6AAAA:8 a=pGLkceISAAAA:8 a=6-dRa9qSAAAA:8
 a=LfxEVeEBAAAA:8 a=QEEkIeqjAAAA:8 a=eSb-bNSJAAAA:8 a=-7NLO8ONgITjkdoHWnIA:9
 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=a-zEBD5cKgE7DNtTSb7C:22 a=NZk92sZ4hQKp_Sw8PGvT:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=iapMWHAMLVzCBf0btcAb:22 a=h7YW-pclpbZRD8svLbQ0:22
X-Proofpoint-GUID: G4MlLYk-uHWMm4EtdyfP6NQN7ThSh-a5
X-Proofpoint-ORIG-GUID: G4MlLYk-uHWMm4EtdyfP6NQN7ThSh-a5
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120024
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

Hi Thomas, Thank you for the greetings and link to best practices. Response=
 to comments inline.


Internal Use - Confidential
-----Original Message-----
From: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
Sent: Monday, August 11, 2025 6:22 AM
To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
Cc: pravin.m.bathija.dev+AEA-gmail.com+ADs- Glimcher, Boris +ADw-Boris.Glim=
cher+AEA-dell.com+AD4AOw- stable+AEA-dpdk.org+ADs- dev+AEA-dpdk.org
Subject: Re: +AFs-PATCH 0/3+AF0- PATCH 25.03.0: vhost+AF8-user: configure m=
emory slots


+AFs-EXTERNAL EMAIL+AF0-

Welcome in DPDK community,

Thank you for contributing.
Please check this quick guide about our tools and process:
        https://urldefense.com/v3/+AF8AXw-https://core.dpdk.org/contribute/=
+AF8AXwA7ACEAIQ-LpKI+ACE-h4SuVXVKUjguLjeWE-7JzUs5v-AcsKmyYYwpUFXx56QCsIKgrd=
B6laqMyPpxtebrxuzwxAJ87oW2ibtaWnLc+ACQ- +AFs-core+AFs-.+AF0-dpdk+AFs-.+AF0-=
org+AF0-

There is a link to register to the dev mailing list so your future patches =
and replies won't be moderated.
Note that you can disable receiving all list mails after registration if it=
 is too much for your box.

More comments below.

08/08/2025 07:13, Pravin M Bathija:
+AD4- add protocol feature support add and removal of memory regions/slots
+AD4- dynamically.
+AD4- this patch set has been tested with multiple instances of fio
+AD4- connected via libblkio to spdk target backed unix domain socket.
+AD4- please apply this this patch-set to dpdk mainline as well as version
+AD4- 25.03.0.

We didn't plan to maintain a branch for 25.03.
Do you think we should?
The next LTS branch will be 25.11.
+ADw-Pravin+AD4- SPDK master uses DPDK 25.03 as sub-module. It would be onl=
y appropriate to have the DPDK 25.03 also have this patch to correspond wit=
h what SPDK is using.


+AD4- Pravin M Bathija (3):
+AD4-   mailmap: add user

This patch can be squashed with the next one, but it is a detail which can =
be handled by the maintainer.

+AD4-   vhost+AF8-user: configure memory slots
+AD4-   vhost+AF8-user: support for memory regions



