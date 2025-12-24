Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA65E74ADE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 07:33:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19436402E8;
	Wed, 24 Dec 2025 08:33:30 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by mails.dpdk.org (Postfix) with ESMTP id A1A304025A;
 Wed, 24 Dec 2025 08:33:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR7loDaeCJZwg5bNsVe01icatjyKMDWoMPyI5Np0E3C4EbB6DR+ZvLwkFuQK97eNa3DTKPFPgrhqWOLP1Bx3CAuq/Xg4EB5zpiX6X1uD2tNq/vivgTmEWNlrx5hqC6xxjgJb+xLjytmZPOtmQFgGANlrULzsVP+xDZEdWgoVxE+rGAjQo3OeFizJqUwBM+/5+xlaCoQlNXUkDSHR2132LAGQfMZ3sH5myrgYXcHhLTSanMoktE8d49A6CHhubCFFNO9bycgRoh05wikT0zGXv5TdI+nEUgnt7gZmzpw68D0rCQBD2WVt1K0Q789TgQvCVqAzoIbtTHKT+B0AFrLZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rimfRcGsCteVjJyqFW1kj4bLRvkupvaicfi0kGniHs=;
 b=Foz6gF4EI1SosKE/Y1BJeebBrcN8ngFVaqb06TVxlWVz76+nVLboPgt0GgeKUM5B4grAU6KuB/FyMg+kCXjt85RciTHwiBhI8LBbGyFYBWUR14oNdTWC9+anOD5dukB+vv0sjAo7YdRaijalaj9vavmG8By8ehX2krDQvGWTJv4hhoK9DnK4McD1hqYfvNMOkqw5HweByBgcavxjdJTg0uds22tCSmZFx72j+T8UIghPJs2JUBAcNI0pLQhqIA0oxk64whALosDHIautvkTY7tPUM76DQ7fRoI3UUK3IDrJ+TxubRj7pAcEiki0aplxtpfZUKt4GTN2wog6qzBhO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rimfRcGsCteVjJyqFW1kj4bLRvkupvaicfi0kGniHs=;
 b=qpJxi9YrhwosxsgXXeGZdcjJH9F3C5VyCIXjykFODtc8Jk0ODn3ijTR4EutAnr8khaAaXYLUcIlcnmQvagb+VSkk24MkPib2PSdfPOraBjHkR2qQtNqvrPuwU/978I076X9q0MZixUpqn/omjbSZMzXRe6DkE+gi75MyFP84BHKykofftkGarVN+8tT+bDlDG17WGcTJTLYZTmZnUqLbaHPaeIvdChC6+pebD+i9QOn6o60wbUMVxRBZ6cnrIFiC7xUQggiBJNhJO8ko90UfUH0hKAKNUJr353i/xF2V8rA2zI1qgVfAJjeKesoQk534wDDebHjtA6EEwLOxd2r0gA==
Received: from IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 07:33:23 +0000
Received: from IA1PR12MB8077.namprd12.prod.outlook.com
 ([fe80::3ed4:f81c:236e:bf61]) by IA1PR12MB8077.namprd12.prod.outlook.com
 ([fe80::3ed4:f81c:236e:bf61%3]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 07:33:23 +0000
From: Maayan Kashani <mkashani@nvidia.com>
To: "Minggang(Gavin) Li" <gavinl@nvidia.com>, Luca Boccassi
 <luca.boccassi@gmail.com>, Ali Alnubani <alialnu@nvidia.com>, Shani Peretz
 <shperetz@nvidia.com>, Kevin Traynor <ktraynor@redhat.com>
CC: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, John
 McNamara <john.mcnamara@intel.com>, Raslan Darawsheh <rasland@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Salaheddin
 Badawi <sbadawi@nvidia.com>, Wael Abualrub <waela@nvidia.com>
Subject: RE: 22.11.11 patches review and test
Thread-Topic: 22.11.11 patches review and test
Thread-Index: AQHcZLjO7Lty3hXNOkag0IUhaR0SX7UnzUgAgAABGQCAAAiiAIAAAnMAgAXI1QCAAb+g4IAA2fOAgABJjXA=
Date: Wed, 24 Dec 2025 07:33:23 +0000
Message-ID: <IA1PR12MB8077E548000554C0B770779EB2B2A@IA1PR12MB8077.namprd12.prod.outlook.com>
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
 <CAMw=ZnRXeX+UxekNOFtkeTbWYyBm-WosWqOi3MtkQ+4Ot3mFpg@mail.gmail.com>
 <4132b192-db18-4df2-a755-44405501330d@nvidia.com>
 <CAMw=ZnQwf8cH_cO9CK3Y--XmzYU+cfCNJ3YWe8qjNZbuCfSe6Q@mail.gmail.com>
 <CAMw=ZnRPba=cPc1waWhmzkkSK_+iKpdhuFf8u9QZZqDjmScUYA@mail.gmail.com>
 <CH3PR12MB8074149AF08F3DDE53EB3F7FB2B5A@CH3PR12MB8074.namprd12.prod.outlook.com>
 <IA1PR12MB662825D68B439AA92B0D249EB3B2A@IA1PR12MB6628.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB662825D68B439AA92B0D249EB3B2A@IA1PR12MB6628.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: shperetz@nvidia.com,ktraynor@redhat.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8077:EE_|PH0PR12MB7862:EE_
x-ms-office365-filtering-correlation-id: 637eb1d0-ebd5-48ae-efb6-08de42beb81e
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?anhtdzN6WlRKK3NvOTdnNEZnUE8rdmVRRWF5YTFFVytHZ1Avc2ZoU3RYMlJL?=
 =?utf-8?B?RDcxVjFzUjU5MXVFeXNwNDRpbHV2cFc5a1pNZk5MT1BsRVFIT1VNZEtCbEpM?=
 =?utf-8?B?SVIyVGE1VUZLZGR6VUVybDFreTVpQ2ZQSSs1MFNiRVFIODZrc3pOcFZOaE1V?=
 =?utf-8?B?aEluWWpoS3ZSUnBUZ2NvK2VYeEltTU1LN2kyT0JPVTc3aXhVNlViZFRsbkxF?=
 =?utf-8?B?THozQmU1aTQ1b0RDYjhpRURncVA3dDRYZUNqVGMwSk15dlpZRWwrQnZsQnFI?=
 =?utf-8?B?OURPdFVPODZWUjFML3VrSHdtVnlzTjBzdk1YZkp5emtlbUZRaWV6TUJnbkVm?=
 =?utf-8?B?MVdYTlFsRUU0b3hrL0ROSTMxM0ZGcitBdklSSVdGekhURkVHRzdWeFlJM3FR?=
 =?utf-8?B?L2VmdW0ybmVWVVVCWm5sOTlNOFptNktOaFdyOCtMT1F1OVBLazdmRTZTaXN0?=
 =?utf-8?B?V0hxakNCNUJtYi9Sc3IwRmFzM3IzZ3ljQm9nUE42YWgvb3I1TGdWMHJON1B3?=
 =?utf-8?B?aWJtUG1jR1hVY1p4Q1FVUG9RWk8yTTBzcDhJVnRjM2lweXVVd2ZUSnpqZ2hy?=
 =?utf-8?B?UjRaeDhUUHdmTDY3RndvT0RReXJIN0kwWithNThiMFpLWTdNaUh1Sk00amZX?=
 =?utf-8?B?Lzg2SS9uWkY1UGR1NDdTbWhJdXFSKzFwWDhtenFxakNiaDhPWDBBOFF6TXB1?=
 =?utf-8?B?OXZMdUMwZ0RoUEVOdmJLRGREbUIvdnFpUkxoRVEyU0JwSnkwQkRydTFaYU9F?=
 =?utf-8?B?a0hQeFZoRmpEeUQweEp4MlBMVjN4ZXVubkcwMWRlSFlvYUlmZ3lqY3ArWkNX?=
 =?utf-8?B?K2FZWTB4dk1JK1ZUZlE3eVNnbUpwbVNqVC9MRU9mRGY3QzZMd1hCTU42a1lB?=
 =?utf-8?B?VUt4a2ZMUmFRSXNtelpRTWtjL0ZhTjEyeWcwTjZwYm0wWWdhM01YMnVTQnFP?=
 =?utf-8?B?TVcxR1BlYk45WjRKeTVLZWV0TzY5SEkxdHZpR28wTEUxQkVWMTEwaUZRYncz?=
 =?utf-8?B?QWFpS2tLVDdMVCtxd2YrSXVHd0hjQTRRclhUT0VsNEZVL0J0VVdod1FIY1Mw?=
 =?utf-8?B?N2xxSnNBVVBDY1ZYR096aEZLZ3hsUDdHS29sT3Q1dEZRMzRZT2c1S0RSbmpj?=
 =?utf-8?B?Z1M4VnphZTNESnJGWTJCYUJTMENmREt1c0tKbDRTNW5yK29vZFVnbEZ3NGhT?=
 =?utf-8?B?TVdOWTJFMWlSOEVCanJqRkFobjE0eWs4bHFQa0x6TVVpc0o5MjQvQm5Mc0VP?=
 =?utf-8?B?Ujd1RVpUWVpVRE9DZUJibE1acHQ0ckJieWk3WW9NZUM2cnBkaCtjcC9aZjVs?=
 =?utf-8?B?VTJqYjlJM0trMU5hTjZNcHNUOW90VUNmaDJKdGR4ZjJ3Tmt2UUx0OG93WFA5?=
 =?utf-8?B?ZTd0SUNrdEo1TFhiU0xWb3VKMWw3Q3U0enpWNkRqdm1zYkxLbzNqUUhmbmM2?=
 =?utf-8?B?WjFDVVJTYWVSanBYNE9EZnFsN1F4ZXdEYTl2TjY4T2Q0Z3BEb2czV1pndXpx?=
 =?utf-8?B?dTAva1JTWEcxcFJSNDh5a3p1a0dzZVNidXJEMHkxNGJ3MzZiUjBOam94RUJE?=
 =?utf-8?B?WHBlWnFreXZvL0h3aTBodWd2QTF5cEgyajFOdis5RVZKYTNESU5ubmhTMnFE?=
 =?utf-8?B?QWQ1L0ZDdTFGWm5zZTlOWHNqNnRFQkMxYzNFNUJWQzJPbDZvT1hmVGRQdEs3?=
 =?utf-8?B?RTJlVG52ZFpYNEhFQk9ob0taK0t6c3FQMWo3SysxZHMwWEJ1Qmc2SXRiY1dI?=
 =?utf-8?B?TXN1dUpxNkVIa2M4OWYyNS9Ccy84WFZUa0ZITXFRTzRPc2ZpZ2tFS1NMblI4?=
 =?utf-8?B?RXJUME56VWwyNDViT2pUU1dVN0NJdGdGZ0ZDcHNPdC9YN3FGSFo0RExoeUsw?=
 =?utf-8?B?SkRDVmthc2E1RGFZYkh4ZHNWSGZNemJoeHUySzY2ZGJ2RmxCeDFqbDk1RDl0?=
 =?utf-8?B?VEYzQkVCUnNManV0WXd5Y3A4eWV2RmQxd2lYc1IzZ2hEcHRHbXo4b1AwOWtu?=
 =?utf-8?B?dEo1VDJ6SFIxVmp3cGxUUnV0RWRUWTFZc1pTbmVmTTNYbFJhZERnYlZXOFpK?=
 =?utf-8?Q?+EQP5K?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(13003099007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rkpzc2huWFhiUTJpYzMyRHRBSjh6U2o0dEU3VDg4NWt5d2hTZHk2b2VnMUMy?=
 =?utf-8?B?R3JVdk5yU1Q2L00zSWQrQnBKSWJFWm9yM1hKeDR0bmNvRlBJbjB4NTNqcEdo?=
 =?utf-8?B?Q2pBYUczWkYwRk00enFuR1Zmd1RnV0VhV1BXcnlOdzZmWTJoaHlEeWxZVjg3?=
 =?utf-8?B?aXJrdVRWak9aNURjWXRoQnlKSXJnSkhIK3kxRXhoaUlpTklyeHpxUUlYaVlm?=
 =?utf-8?B?TVg3cWxDc3p1dFpMR0JDSjhpQjc4U2lqV3I3aWtWMm5XNlFZdCt6WVNRUTNo?=
 =?utf-8?B?WEVjaW4xTmd3SExRN2tmak9KT1FFaDBsNWduZ0gwRnF4OHY3eXJ4WWcrRWV6?=
 =?utf-8?B?OU56bndQeXdadndRSVFBTWw2ck9GTWE3QlFTemhieFl4cWo5b3AzN252M1Rh?=
 =?utf-8?B?UEdFeFl3ckJvQ0tla1JlRFI0OVQxbkpURnZ1OHZrZ21Yd0tmR3EybkZMMXg4?=
 =?utf-8?B?VHNRR01JemhNeDVVY3p3anJTWncvMmF4a2Rvc0lYNWpSSTExQ2tmQnFPWjBr?=
 =?utf-8?B?Rlh4L2g4aGZLWjNmakJURVNoai9jY0s5NGFoZld4TFE5K2FvTHFzcE1LcElo?=
 =?utf-8?B?R3AyU3dGejZPQjViSkhPWGtPUEV4NWVYTGMxMHE3UEFsVmlueGNPUy9QL1FB?=
 =?utf-8?B?MDBsWHgxTXpXUm5ndTRXd3NCL1ZtTGVSR084aVorWkFrNGVBMGhudGc2NkVM?=
 =?utf-8?B?cnNDWWNMY3NWdExBUHU5eGsrU0NWNkpYU1NLV2RWSGkrK3dzSmF5dkFZdHRx?=
 =?utf-8?B?WFVZS2lqc01icjVpOTZmaWRrb2J4aHRLMHMyR0tqTUhHRzhHZ3VaZ2pRZnRs?=
 =?utf-8?B?bUVZZHo4RmZKUzkvdVF6Zll6dksvaU1zK2hpY2hZMStMaGtnMXMrK0MrbjJ5?=
 =?utf-8?B?N1RGQWRuemtSRTdoWmc4b1grWlhpdE1ZWGN0YlVtcjBXclBtdGo1NjEvZDY1?=
 =?utf-8?B?Um52Z0oycFFKQitubllUcGZ3WHkyRVlDa0t0Mk1QNHJVUlVKcW40dkdGelVE?=
 =?utf-8?B?YWpTZXlhaGk3SGN6RS9vVmx1QlpJZUU5QjVEUE1yT3ZiMTRhYksyWTlzRjc0?=
 =?utf-8?B?RXBSU2J5NnVweW1rTUZOd013T0lqekM4T3grTG4yZlFXMzBCQy8rOUI4TnNY?=
 =?utf-8?B?N3hYQXpNNGlNbkJhTWRHQ295cjBDQWZCMlJzTXdLaXZXMXFWa3UyaW8xdVlY?=
 =?utf-8?B?cUhzYUUzMkFYNWdxVStKejNMbmhMUHFtbG9rdGkwaUJKUm1kSFZDVGV6WjEw?=
 =?utf-8?B?akRyaHVxRFFzQnNNOHAzbThtMCsvbDZQTE1sT2U3NkJ4WnY5djMvZDdFNllC?=
 =?utf-8?B?Q055MXZ5NjM2NmNJNjFoTmRraUwvL1IwWDIwY3NxY1dvZmtoRUFzWmNCWWVV?=
 =?utf-8?B?Q2tROVprcDBjMWxqL1BJN3RTeUk4TEY2Nlg4bkZvclJLSkpPNzFENVhFNUEy?=
 =?utf-8?B?c25ZWW43dGtRaDV0eUJUcG12TGI2dDE0cWsySlcvTWlVcXMxR1ZuNkZyb2J1?=
 =?utf-8?B?bDBsdXdvWC93ZnhPbTVTRm02bkJ1MkU4azF1dlE2K2FwRDRCQjh4dlV3c0do?=
 =?utf-8?B?NDkwNS9wd2ZnV0R5QzNtYkx1SlN6TENiOFo4YkJsTEpKWGswdE9TM2ZDejdH?=
 =?utf-8?B?M284SzJjOHBoeC9wakF0anZ6WHpMUFB0V3VqalBodkJuWk9qMmoyS3lXRUdl?=
 =?utf-8?B?MjlHbnFvaFJEdFF1ZGxGL1VQcGJJdmJqUnozSTRIY2NFazBFNWYrQUNNSG1F?=
 =?utf-8?B?eStCWlZHY2FCSXR4QjZVeXBnVHVkRVdxcVdnV3ZwNzd5bzAxMU93WFdwbmd5?=
 =?utf-8?B?T0NtbHNLT2V5aEN6RDNRMWtPVW5MUDgySFFTbnBRSjdEeGRmaE9wV2o4NFFD?=
 =?utf-8?B?M05HN3ZrN1YxUnBkL21mMm9RV1c2TjQ0RCt5N2JqY3MwMzY4K3p2Z2tMcTN3?=
 =?utf-8?B?eE83MEFVUm5MRGVhcDZCWUo0anhOSisrQ09MV2xFVGZwY2F3OXdENS9VbDI1?=
 =?utf-8?B?aDhsRjduYS9aaWdkWGNPc2FQc0dGWDlvTG84YmpBR1VyeURLVktSUWVwTVds?=
 =?utf-8?B?bFF3QVVNeXhBZmZRenU2bEN0bFlMY2hRVmpCY3FxWlNsdWpETDlyNk02U3Rs?=
 =?utf-8?B?REZRcnVJT1FUYzhGRDZkVUFEc2daRlQrVmVSRUZtbjV3SVVDd0JybzJtRmdL?=
 =?utf-8?B?MmZmMldXOFBMWXhkVUhKZ242R1M5ZHdGNStQVVRIbTl5S05WSGpjMG00Vlhl?=
 =?utf-8?B?YXNKTTJJMFprcklrMVNUOGtBYnRTcDdtdERNNzYwUWpvTFc3ajgyYmRSd1Q4?=
 =?utf-8?Q?i5Q5ESVENXEIrS6+qI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637eb1d0-ebd5-48ae-efb6-08de42beb81e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 07:33:23.3364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: biEj8UchEbFWYC72KGq9kiOPjm9MOLZkE87iXEZDVJlxVn6sZV0pn+uUsQD/xyo9soW+QOkkt7/2cSXUkrnvRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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

KytAU2hhbmkgUGVyZXR6DQorK0BLZXZpbiBUcmF5bm9yDQoNClBsZWFzZSBzZWUgYmVsb3csDQoN
ClJlZ2FyZHMsDQpNYWF5YW4gS2FzaGFuaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IE1pbmdnYW5nKEdhdmluKSBMaSA8Z2F2aW5sQG52aWRpYS5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgMjQgRGVjZW1iZXIgMjAyNSA1OjA5DQo+IFRvOiBNYWF5YW4gS2FzaGFuaSA8
bWthc2hhbmlAbnZpZGlhLmNvbT47IEx1Y2EgQm9jY2Fzc2kNCj4gPGx1Y2EuYm9jY2Fzc2lAZ21h
aWwuY29tPjsgQWxpIEFsbnViYW5pIDxhbGlhbG51QG52aWRpYS5jb20+DQo+IENjOiBzdGFibGVA
ZHBkay5vcmc7IGRldkBkcGRrLm9yZzsgSm9obiBNY05hbWFyYQ0KPiA8am9obi5tY25hbWFyYUBp
bnRlbC5jb20+OyBSYXNsYW4gRGFyYXdzaGVoIDxyYXNsYW5kQG52aWRpYS5jb20+Ow0KPiBOQlUt
Q29udGFjdC1UaG9tYXMgTW9uamFsb24gKEVYVEVSTkFMKSA8dGhvbWFzQG1vbmphbG9uLm5ldD47
DQo+IFNhbGFoZWRkaW4gQmFkYXdpIDxzYmFkYXdpQG52aWRpYS5jb20+OyBXYWVsIEFidWFscnVi
DQo+IDx3YWVsYUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSRTogMjIuMTEuMTEgcGF0Y2hlcyBy
ZXZpZXcgYW5kIHRlc3QNCj4gDQo+IEhpIEx1Y2EsDQo+IA0KPiBUaGUgaXNzdWUoaHR0cHM6Ly9i
dWdzLmRwZGsub3JnL3Nob3dfYnVnLmNnaT9pZD0xODUxKSB3YXMgaW50cm9kdWNlZCBieQ0KPiBj
aGVycnktcGlja2luZyBzb21lIG9mIHRoZSAzIHJlbGF0ZWQgY29tbWl0cyBvZiByZWZhY3Rvcmlu
ZyBtdWx0aWNhc3QNCj4gaGFuZGxpbmcgb2YgUEYgaW4gTlYgcG1kLiBJIGRvbid0IHVuZGVyc3Rh
bmQgd2h5IGl0L3RoZXkgd2VyZSBjaG9zZW4NCj4gYmVjYXVzZSB0aGV5IGluY2x1ZGVkIGJlaGF2
aW9yIGNoYW5nZSBpbiBQRi4gVGhleSBzaG91bGQgbm90IGJlIGJhY2twb3J0ZWQNCj4gdG8gc3Rh
YmxlIG9uZXMgZnJvbSBteSBwb2ludCBvZiB2aWV3Lg0KPiANCj4gVGhlIGNvbW1pdChzKSBwb2xs
dXRlZCAyMi4xMSwgMjMuMTEgYW5kIDI0LjExIHNvIGZhci4gUGxlYXNlIHJldmVydCBiZWxvdw0K
PiBjb21taXRzIHRvIGZpeCB0aGUgaXNzdWUuDQo+IA0KPiAyNC4xMQ0KPiBkZGNhYTE2NzFmIG5l
dC9tbHg1OiBmaXggbXVsdGljYXN0DQo+IGFkY2U2ZDEzMGIgbmV0L21seDU6IGFsaWduIFBGIGFu
ZCBWRi9TRiBNQUMgYWRkcmVzcyBoYW5kbGluZw0KPiANCj4gMjMuMTENCj4gYzA3MDQ1NWU4YiBu
ZXQvbWx4NTogYWxpZ24gUEYgYW5kIFZGL1NGIE1BQyBhZGRyZXNzIGhhbmRsaW5nDQo+IA0KPiAy
Mi4xMQ0KPiA1OGE2NDIxYmMzIG5ldC9tbHg1OiBmaXggbXVsdGljYXN0DQo+IGVkMzQxMTIxN2Ig
bmV0L21seDU6IGFsaWduIFBGIGFuZCBWRi9TRiBNQUMgYWRkcmVzcyBoYW5kbGluZw0KPiANCj4g
UmVnYXJkcy4NCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBN
YWF5YW4gS2FzaGFuaSA8bWthc2hhbmlAbnZpZGlhLmNvbT4NCj4gPiBTZW50OiBUdWVzZGF5LCBE
ZWNlbWJlciAyMywgMjAyNSAxMDowOSBQTQ0KPiA+IFRvOiBMdWNhIEJvY2Nhc3NpIDxsdWNhLmJv
Y2Nhc3NpQGdtYWlsLmNvbT47IEFsaSBBbG51YmFuaQ0KPiA+IDxhbGlhbG51QG52aWRpYS5jb20+
OyBNaW5nZ2FuZyhHYXZpbikgTGkgPGdhdmlubEBudmlkaWEuY29tPg0KPiA+IENjOiBzdGFibGVA
ZHBkay5vcmc7IGRldkBkcGRrLm9yZzsgSm9obiBNY05hbWFyYQ0KPiA+IDxqb2huLm1jbmFtYXJh
QGludGVsLmNvbT47IFJhc2xhbiBEYXJhd3NoZWggPHJhc2xhbmRAbnZpZGlhLmNvbT47DQo+IE5C
VS0NCj4gPiBDb250YWN0LVRob21hcyBNb25qYWxvbiAoRVhURVJOQUwpIDx0aG9tYXNAbW9uamFs
b24ubmV0PjsNCj4gU2FsYWhlZGRpbg0KPiA+IEJhZGF3aSA8c2JhZGF3aUBudmlkaWEuY29tPjsg
V2FlbCBBYnVhbHJ1YiA8d2FlbGFAbnZpZGlhLmNvbT4NCj4gPiBTdWJqZWN0OiBSRTogMjIuMTEu
MTEgcGF0Y2hlcyByZXZpZXcgYW5kIHRlc3QNCj4gPg0KPiA+ICsrQE1pbmdnYW5nKEdhdmluKSBM
aQ0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBNYWF5YW4gS2FzaGFuaQ0KPiA+DQo+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTHVjYSBCb2NjYXNzaSA8bHVjYS5i
b2NjYXNzaUBnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBNb25kYXksIDIyIERlY2VtYmVyIDIwMjUg
MTM6MjcNCj4gPiA+IFRvOiBBbGkgQWxudWJhbmkgPGFsaWFsbnVAbnZpZGlhLmNvbT4NCj4gPiA+
IENjOiBzdGFibGVAZHBkay5vcmc7IGRldkBkcGRrLm9yZzsgSm9obiBNY05hbWFyYQ0KPiA+ID4g
PGpvaG4ubWNuYW1hcmFAaW50ZWwuY29tPjsgUmFzbGFuIERhcmF3c2hlaCA8cmFzbGFuZEBudmlk
aWEuY29tPjsNCj4gPiA+IE5CVS1Db250YWN0LVRob21hcyBNb25qYWxvbiAoRVhURVJOQUwpIDx0
aG9tYXNAbW9uamFsb24ubmV0PjsNCj4gPiA+IFNhbGFoZWRkaW4gQmFkYXdpIDxzYmFkYXdpQG52
aWRpYS5jb20+OyBXYWVsIEFidWFscnViDQo+ID4gPiA8d2FlbGFAbnZpZGlhLmNvbT4NCj4gPiA+
IFN1YmplY3Q6IFJlOiAyMi4xMS4xMSBwYXRjaGVzIHJldmlldyBhbmQgdGVzdA0KPiA+ID4NCj4g
PiA+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1l
bnRzDQo+ID4gPg0KPiA+ID4NCj4gPiA+IE9uIFRodSwgMTggRGVjIDIwMjUgYXQgMTk6MDYsIEx1
Y2EgQm9jY2Fzc2kNCj4gPiA+IDxsdWNhLmJvY2Nhc3NpQGdtYWlsLmNvbT4NCj4gPiA+IHdyb3Rl
Og0KPiA+ID4gPg0KPiA+ID4gPiBPbiBUaHUsIDE4IERlYyAyMDI1IGF0IDE4OjU4LCBBbGkgQWxu
dWJhbmkgPGFsaWFsbnVAbnZpZGlhLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IE9uIDEyLzE4LzI1IDg6MjcgUE0sIEx1Y2EgQm9jY2Fzc2kgd3JvdGU6DQo+
ID4gPiA+ID4gPiBPbiBUaHUsIDE4IERlYyAyMDI1IGF0IDE4OjI0LCBBbGkgQWxudWJhbmkNCj4g
PiA+ID4gPiA+IDxhbGlhbG51QG52aWRpYS5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+
PiBPbiAxMi80LzI1IDI6NTYgQU0sIGx1Y2EuYm9jY2Fzc2lAZ21haWwuY29tIHdyb3RlOg0KPiA+
ID4gPiA+ID4+DQo+ID4gPiA+ID4gPj4+IEhpIGFsbCwNCj4gPiA+ID4gPiA+Pj4NCj4gPiA+ID4g
PiA+Pj4gSGVyZSBpcyBhIGxpc3Qgb2YgcGF0Y2hlcyB0YXJnZXRlZCBmb3Igc3RhYmxlIHJlbGVh
c2UgMjIuMTEuMTEuDQo+ID4gPiA+ID4gPj4+DQo+ID4gPiA+ID4gPj4+IFRoZSBwbGFubmVkIGRh
dGUgZm9yIHRoZSBmaW5hbCByZWxlYXNlIGlzIERlY2VtYmVyIDE4dGguDQo+ID4gPiA+ID4gPj4+
DQo+ID4gPiA+ID4gPj4+IFBsZWFzZSBoZWxwIHdpdGggdGVzdGluZyBhbmQgdmFsaWRhdGlvbiBv
ZiB5b3VyIHVzZSBjYXNlcw0KPiA+ID4gPiA+ID4+PiBhbmQgcmVwb3J0IGFueSBpc3N1ZXMvcmVz
dWx0cyB3aXRoIHJlcGx5LWFsbCB0byB0aGlzIG1haWwuDQo+ID4gPiA+ID4gPj4+IEZvciB0aGUg
ZmluYWwgcmVsZWFzZSB0aGUgZml4ZXMgYW5kIHJlcG9ydGVkIHZhbGlkYXRpb25zDQo+ID4gPiA+
ID4gPj4+IHdpbGwgYmUgYWRkZWQgdG8gdGhlDQo+ID4gPiByZWxlYXNlIG5vdGVzLg0KPiA+ID4g
PiA+ID4+Pg0KPiA+ID4gPiA+ID4+PiBBIHJlbGVhc2UgY2FuZGlkYXRlIHRhcmJhbGwgY2FuIGJl
IGZvdW5kIGF0Og0KPiA+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+ID4+PiBo
dHRwczovL2RwZGsub3JnL2Jyb3dzZS9kcGRrLXN0YWJsZS90YWcvP2lkPXYyMi4xMS4xMS1yYzEN
Cj4gPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPiA+Pj4gVGhlc2UgcGF0Y2hlcyBhcmUgbG9jYXRlZCBh
dCBicmFuY2ggMjIuMTEgb2YgZHBkay1zdGFibGUgcmVwbzoNCj4gPiA+ID4gPiA+Pj4gICAgICAg
aHR0cHM6Ly9kcGRrLm9yZy9icm93c2UvZHBkay1zdGFibGUvDQo+ID4gPiA+ID4gPj4+DQo+ID4g
PiA+ID4gPj4+IFRoYW5rcy4NCj4gPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPiA+Pj4gTHVjYSBCb2Nj
YXNzaQ0KPiA+ID4gPiA+ID4+IEhlbGxvLA0KPiA+ID4gPiA+ID4+DQo+ID4gPiA+ID4gPj4gV2Ug
cmFuIHRoZSBmb2xsb3dpbmcgZnVuY3Rpb25hbCB0ZXN0cyB3aXRoIE52aWRpYSBoYXJkd2FyZSBv
bg0KPiA+ID4gdjIyLjExLjExLXJjMToNCj4gPiA+ID4gPiA+PiAtIEJhc2ljIGZ1bmN0aW9uYWxp
dHk6DQo+ID4gPiA+ID4gPj4gICAgIFNlbmQgYW5kIHJlY2VpdmUgbXVsdGlwbGUgdHlwZXMgb2Yg
dHJhZmZpYy4NCj4gPiA+ID4gPiA+PiAtIHRlc3RwbWQgeHN0YXRzIGNvdW50ZXIgdGVzdC4NCj4g
PiA+ID4gPiA+PiAtIHRlc3RwbWQgdGltZXN0YW1wIHRlc3QuDQo+ID4gPiA+ID4gPj4gLSBDaGFu
Z2luZy9jaGVja2luZyBsaW5rIHN0YXR1cyB0aHJvdWdoIHRlc3RwbWQuDQo+ID4gPiA+ID4gPj4g
LSBydGVfZmxvdyB0ZXN0cw0KPiA+ID4gPiA+ID4+IChodHRwczovL2RvYy5kcGRrLm9yZy9ndWlk
ZXMvbmljcy9tbHg1Lmh0bWwjc3VwcG9ydGVkLWhhcmR3YXINCj4gPiA+ID4gPiA+PiBlLQ0KPiA+
ID4gPiA+ID4+IG9mDQo+ID4gPiA+ID4gPj4gZmxvYWRzKQ0KPiA+ID4gPiA+ID4+IC0gUlNTIHRl
c3RzLg0KPiA+ID4gPiA+ID4+IC0gVkxBTiBmaWx0ZXJpbmcsIHN0cmlwcGluZywgYW5kIGluc2Vy
dGlvbiB0ZXN0cy4NCj4gPiA+ID4gPiA+PiAtIENoZWNrc3VtIGFuZCBUU08gdGVzdHMuDQo+ID4g
PiA+ID4gPj4gLSBwdHlwZSB0ZXN0cy4NCj4gPiA+ID4gPiA+PiAtIGxpbmtfc3RhdHVzX2ludGVy
cnVwdCBleGFtcGxlIGFwcGxpY2F0aW9uIHRlc3RzLg0KPiA+ID4gPiA+ID4+IC0gbDNmd2QtcG93
ZXIgZXhhbXBsZSBhcHBsaWNhdGlvbiB0ZXN0cy4NCj4gPiA+ID4gPiA+PiAtIE11bHRpLXByb2Nl
c3MgZXhhbXBsZSBhcHBsaWNhdGlvbnMgdGVzdHMuDQo+ID4gPiA+ID4gPj4gLSBIYXJkd2FyZSBM
Uk8gdGVzdHMuDQo+ID4gPiA+ID4gPj4gLSBCdWZmZXIgU3BsaXQgdGVzdHMuDQo+ID4gPiA+ID4g
Pj4gLSBUeCBzY2hlZHVsaW5nIHRlc3RzLg0KPiA+ID4gPiA+ID4+DQo+ID4gPiA+ID4gPj4gRnVu
Y3Rpb25hbCB0ZXN0cyByYW4gb24gQ29ubmVjdFgtNiBEeCAoT1M6IFVidW50dSAyMi4wNCB8IERy
aXZlcjoNCj4gPiA+ID4gPiA+PiBNTE5YX09GRURfTElOVVgtNS44LTcuMC42LjEgfCBGaXJtd2Fy
ZTogMjIuMzUuODAwMikuDQo+ID4gPiA+ID4gPj4NCj4gPiA+ID4gPiA+PiBBbiBlbmdpbmVlciBm
cm9tIG15IHRlYW0gcmVwb3J0ZWQgMiBpc3N1ZXM6DQo+ID4gPiA+ID4gPj4NCj4gPiA+ID4gPiA+
PiBodHRwczovL2J1Z3MuZHBkay5vcmcvc2hvd19idWcuY2dpP2lkPTE4NTENCj4gPiA+ID4gPiA+
PiBEaWQgbm90IHJlcHJvZHVjZSBpbiAyMi4xMS4xMCwgZ2l0LWJpc2VjdCBwb2ludHMgdG8NCj4g
PiA+ID4gPiA+PiA1OGE2NDIxYmMzOTYNCj4gPiA+ID4gPiA+PiAoIm5ldC9tbHg1OiBmaXggbXVs
dGljYXN0IikuLg0KPiA+ID4gPiA+ID4gVGhhbmtzLCBhcmUgeW91IHBsYW5uaW5nIHRvIHNlbmQg
YSBmaXgsIG9yIHNob3VsZCBJIGp1c3QNCj4gPiA+ID4gPiA+IHJldmVydCB0aGF0DQo+ID4gPiBj
b21taXQ/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIHJlYWNoZWQgb3V0IHRvIHRoZSBlbmdpbmVl
ciB3aG8gYXV0aG9yZWQgdGhlIHBhdGNoIGFuZCBhbQ0KPiA+ID4gPiA+IHdhaXRpbmcgZm9yIHRo
ZWlyIHJlc3BvbnNlLiBJIG1heSBub3QgYmUgYWJsZSB0byBnZXQgYmFjayB0byB5b3UNCj4gPiA+
ID4gPiB3aXRoIGFuIGFuc3dlciB0b2RheSwgdGhvdWdoLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGFu
ayB5b3UsIG5vIHByb2JsZW0gaXQgY2FuIHdhaXQgYSB3aGlsZQ0KPiA+ID4NCj4gPiA+IEhpLA0K
PiA+ID4NCj4gPiA+IEFueSB1cGRhdGU/DQo+ID4gPg0KPiA+ID4gVGhhbmtzDQo=
