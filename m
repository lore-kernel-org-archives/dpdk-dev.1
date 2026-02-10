Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11929EA8126
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:06:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C82A40697;
	Tue, 10 Feb 2026 16:06:14 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 648F1400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:06:12 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A8bkkP2594817; Tue, 10 Feb 2026 07:06:11 -0800
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020110.outbound.protection.outlook.com
 [52.101.193.110])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c65snpe7s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 07:06:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxE39lBzJP97SCDLLTAO6zaVU2D9xe06LQgWLT+/NWbns25hAcdl07svAXZqv6P9kJMo6g9g6gDPH2KFOMu43vBTNc9r9avaWQWiFIoAtvxcv1OI+5tMIcWlz/qA7FJJM+S/hWig+mv4gA5xzkAyeeoxZIlBP1oO4NbIejBk8SILZNI8AsABZuJt+dZc4Xeha4nq4lbWP67dOwBtmzrrGquVIDaGa//jsOtfAigP4pcjB1pqNX5nd+AFJQfuDPYVP3E/F3Bx0o6nYtCyyOjALIDvZJRH5P/2LYOug+Wxslezj1jMJKg5RUsNnu+/YaeOeoFcMDBjoNISzg5OZyTRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHUZ3kzWB9aa8M+w+gTiYBRN+7wRQJtoTjy/fK3nu7s=;
 b=p+PZCI/MHtsm7fClwxS8p4d2UJuvY176NJwbcJWsR8fWAXFCpdnaOKw5fKgSnmCRi07R6n/EI5DGRsPJTkCuaoz8ovM3ajeWXcNdIbhNQyJGxFbdk+rrOAJljl2Tt3DlIdroQJ1Xh9+fQkchRnns71AHzp1P3JDxDNVrzc6c1f2PbRT8s4wvQQy0VkxOvRoE3KyWSctPFyAtqjKKzGRNmISS7rVxzycQsYvcQSeje+f48C1lolQRMtz8syaRWqzP+vBELyaIqrA5YYzrnDWhN68Ae/IoniihTLbrsnrvHhWOJ0uACJdjvy95cP/5uURw/BZQqpNfZpc/GB9gxzjJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHUZ3kzWB9aa8M+w+gTiYBRN+7wRQJtoTjy/fK3nu7s=;
 b=g/qLtsq2bCNyq2ZUxKn4YKPX6IvTKtUym1Ya9bE2wE07hbJzVyFWKNgWCXLmE/ZD7ZtkyN2qRF9Id9XEwvyA+a6gzwtzyncpRDhRyvRw6m2BvyaTOCbMSnbWcORywJl5txFQqVUKgm+sfNxOHresFfadSgl5fYT2gsemeAKJ4tI=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MN2PR18MB3511.namprd18.prod.outlook.com (2603:10b6:208:264::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.5; Tue, 10 Feb
 2026 15:06:07 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 15:06:06 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Shaokai Zhang <felix.zhang@jaguarmicro.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Joey Xing
 <joey.xing@jaguarmicro.com>
Subject: RE: [EXTERNAL] [PATCH v2] crypto/openssl: support AES-XTS operations
Thread-Topic: [EXTERNAL] [PATCH v2] crypto/openssl: support AES-XTS operations
Thread-Index: AQHcWUx0pp3zembieUuERiqfUHaWxLV8it2A
Date: Tue, 10 Feb 2026 15:06:06 +0000
Message-ID: <CO6PR18MB4484492C408634C7C9EDD992D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251117124414.1839-1-felix.zhang@jaguarmicro.com>
 <20251119120231.1399-1-felix.zhang@jaguarmicro.com>
In-Reply-To: <20251119120231.1399-1-felix.zhang@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MN2PR18MB3511:EE_
x-ms-office365-filtering-correlation-id: a2acb38e-aff0-4f9a-fc56-08de68b5eaab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dHZnOXBOY1Vtd3NWRjNiZnNONlFrTW9BSzBXSUpRRE52R3QyZDZ3UE1VU1pY?=
 =?utf-8?B?ZEJoRnNvaVRyWlB3bnlpZFgrcy9WYzRKK0xCdlYwQy9leWgyUU5nNk1raWR1?=
 =?utf-8?B?akt3d1hUMzV0RFA5NVdmYk5hYnFqYmlONkxNeDJ5dFF0UjQzck9hWERPQTJ6?=
 =?utf-8?B?TXZhY3FPZGl5RkJHWVhiZmEyazdWdmx0Zm8zZ3QrUXNyQ3VwUXM1c29NRGxB?=
 =?utf-8?B?NkZQSkNaNzladDFxVlUxOFdzSWZwbHFXeDlZVzNPMlhlbk15TjNYVEhObjZz?=
 =?utf-8?B?N29rYmRzUE5ZU3pWbng4S2FLOGtJMlR4dGtWbERubU0vbGJKd1diSmdLY0xO?=
 =?utf-8?B?ZDBCMmVUZjN2blJmNndJVHU5QUN1MFVxSEhpd0U4a1k5OTQ4c2dEb1U2eE04?=
 =?utf-8?B?SHB3R2hWZTB0WnZNdlRUTW1rdGxIQ05EOVRRR3VQRzN6N2dpS0VaU1FxbUJB?=
 =?utf-8?B?U2Uwd2ZGaDg2ZlIxODlkcXZHTUN5V2ljSG1jRVF2MDQxVDd4ZmRrOW44Uytl?=
 =?utf-8?B?NWpFOTdrRGhKQXZDNjA0N3ltT2Vnb253Sm9UWXJVQklxc1VHdWJ4czJtamhR?=
 =?utf-8?B?cVU5WU5WUERqbXYweXozTWZqVG9ZOTROMUphbFFtWjBienlhNnVTU05vN2Q3?=
 =?utf-8?B?aVZCckJKUFZBL1orVVFxM1JlQnJiWjUrK21OMVpYODZaSGpKSStjWWxYTDJp?=
 =?utf-8?B?STk0aHhPWXYweHFaTHBXdE85aVRNcXljekFPVEhSSGVnODhaWFUyZFZCRnR4?=
 =?utf-8?B?V2NxbDBWa1JWbVZYbk1zMGxjMkQzKy9LdlRyQUhUc291ZmlHYmlGY2NOakpv?=
 =?utf-8?B?Vmx6RzBqWHhFZjY2dzZ4NjM0RTRVQWpGZU50d0w0V3pkcTlLdHVNWUlVOEht?=
 =?utf-8?B?dlN3MC9pb2dKN2tHd0E3TzhseFlMZW1IM3lsck0wUXEyWlc4Z3o1SDJocGYy?=
 =?utf-8?B?R3RZaHl5MjJkeGV4VnAxU2dxbUxaMDZ3M0ErY1c3dlpHRkpVMVZDQUM1cDQr?=
 =?utf-8?B?UWJqZFJMWmZDUTRHc1Z2NU5pTnl2d3p4QTdMblMvOUtNOERMUURkcWhzQzd4?=
 =?utf-8?B?c0dLQ3JYMmVteGtUcHV3QUZCdHQrQy9LZTV5aU5yMXYrRS9CTk9pQkxWNzNP?=
 =?utf-8?B?aVBIWkMvTTljbkhYL2t2MmxjaGVxWktseEJrR2NqWkQ1ZzZQbmhkcldVeVRG?=
 =?utf-8?B?Y096V3IyTW9IS3htZXBackZrZElkTFN1L00zZVJCOXZRRng1Uk0rZTdOVWYy?=
 =?utf-8?B?bUZnclJUWTZkNGtkWkFnckRaOVNNRFFXSktaNEJyK2cydVlBSnJVbFFiVDhT?=
 =?utf-8?B?YnJkNElBTWZBTGlqakdxTHhqQldnSTZWcjVkTHA3Mjdvc1haRVQwa1htN2wr?=
 =?utf-8?B?U1laU1d1NEQ3RmZvMlUyNndPRjdXa2NrUjI4V0JINy9RWWdSekdHTEZBcnBV?=
 =?utf-8?B?cFVpblpZUm1uSVJzWlFMbjhtb3JhcGV5azZ4Q1p0MVFJUVJGdTVleE9jRnk1?=
 =?utf-8?B?NEc3WS9qcUVRanJmK3lsc1NNNVZFellSMHcwS1phQWUxVlhGZWEvb0pWTG5F?=
 =?utf-8?B?R3ZyOHlySmJzR0ZDOUhuZ3NqdnVRUzI1alJjV294OTMxVjR0NGVoQTROcDIx?=
 =?utf-8?B?Qzk4eE5ITnhKQzYxeU12UzIxV1FxcnBFTXU3UG1zcTVUZ2VvS0NINEVUU09E?=
 =?utf-8?B?eTFjTXlTRjlLK2R2VTRaOXBoSzZRZ05wdWw5STM4ajZxUlpBdHZKYnhUUDdx?=
 =?utf-8?B?Yi9KTjJTZitxOTBpU2IzRmpUMEFyYUZMeUIxNmdqam5tbmt4K1M2VjlPWmtU?=
 =?utf-8?B?eWdFSndlRjdhYm9KYVhLRDJOK0pjR3FUS045dlUvQnkzWnFycjBRM0J2cGp2?=
 =?utf-8?B?R0xnNUFIend2VDNDOWlDcThJaEQ0NUZBcVJjSDk0d3lWSXp6U3lrajhrMWtj?=
 =?utf-8?B?Z0M2b1NiSUMrR0VFTUczRmo2K3hoUXFkclFrV0NRamQ4RENMNmpsSlgyRUdI?=
 =?utf-8?B?VlJZSk4wdWNlTTVZa0RkR0NhUTVmOGFwa3FmbCtEZFBOdjFid0o1S05rRHoy?=
 =?utf-8?B?VFFJNXFsN3JMZ1B5QjdDRVMxRURiaVdyQkh2ZVdnb2ord1BxdzlZQmh1SnE0?=
 =?utf-8?B?V3BZcFdYbXlxVDNpU251K3drYU9XQTF5TUFObjl5SkR3cW1hdG9ITVdHYkZk?=
 =?utf-8?Q?4ydtvOTQpiT+bSP63YLRMJ8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHFKLytuWHpwU092UndCQzNqVEV5Q1JSck1oSU1IMlI2S3lkaU12L20yUXZL?=
 =?utf-8?B?b0JWV0VhWUVCT3BYZkdxdzIvQlpUUm5EclFtU3A5MUlEaVlZbnJDVlQ0MXQ4?=
 =?utf-8?B?RGVidDlXMFY4KytsZ25PMWx5d2VMVWhrdUJEWThJdzQ2b0dTNE5VcWh4d1Jw?=
 =?utf-8?B?dVM1RUdVRXpXNFdtWk4vdjFTQmJrTzhieU9VUm52TEpVSERSa3crN0doUEtn?=
 =?utf-8?B?VGFyRHdWY0dUeUZMUDcreXV3K093ZlNGV2d5dTQxVVd3SGcrdTNsMFlDMHdm?=
 =?utf-8?B?NTBSWFBKUUxpczdJRnMvNmxQYXhBZDYvUmxtUGh4L1VVZUUvUEFadmo1MFZG?=
 =?utf-8?B?aWJITWNQWDg3ZzgwUkVNVklEL1Z0VkNyL3FGQWJqWnZwWXNUZ2dDWWt0QW1u?=
 =?utf-8?B?aTl3NjhOUW1rUU5tcUtXTXdEenpsdFlqSjlobGV0UjJLc21RMnpsRWV1NjJm?=
 =?utf-8?B?UitHVi9CcEt5OTZkcE5uck9sMUVLdE44d1hCM01pL1NaTmM1UG1kTktQZllt?=
 =?utf-8?B?VE9LR0FNTlRYaGM0V3RpemdyN3pMaUJiVWNTbnZ1Q3o2NW1ndHZKRnNRZmRW?=
 =?utf-8?B?R3FRYk5NMTU0RmkxV2szYTRkeWJMM2xuTlRyUGRqQVQwaFZVRzFuRS9CYTd1?=
 =?utf-8?B?ZGpwaytUc1Q2RUlEVlpncWlYVHUvS05SZERTa1V1WjVYRVJyR0NJMHdwL1BL?=
 =?utf-8?B?bExDZ2dOTC9uYlV2TG9GVjNQRzBLN0s0OU5kYWJaMkFnYmxFZmIva0hReEhO?=
 =?utf-8?B?b2xZL0Q0bEtxZkJoZmx6Syt4M1pid0dxZk1COU5UY1Z0cU1ndlAwdHA2ZmZp?=
 =?utf-8?B?MUp3TFlDQUVVVzZiekN4YmVWaTBXRzVxK3kwWGFJQ1BkZ0VZQ21jaG1weWVO?=
 =?utf-8?B?VDJKYi9vT0pockYrRW1NTHNrcXJaa0x2NGd1bytvL0lIT3BSNTNSNGMwRzVk?=
 =?utf-8?B?ZWtjNUE1UjY1eTFKL3h2L1BtZ2pqaEFyaTVWYXN4bCtkY3pDbS9tNDdSL2cx?=
 =?utf-8?B?dUJLWWJNZ0ZnbG1XWGNLcG9VKzhyazZlbmdkNDBiKyswMnUvdnBQTWVqOTBi?=
 =?utf-8?B?ZDZjNCtVNXJJZFlzRHgxSW5sUjZkR3BFNE5KU2VIUFlMR3cwemdCSkl0SmVr?=
 =?utf-8?B?dnZUa2x5ZzRGRVQ1VmI0bmNMbUF4R1ZCRXFWa0pLR3RNRCtDa2tCQjRFZWFx?=
 =?utf-8?B?SXVHbm5vWHhDUi9MR1VNNEMxNGlIZW05akZEZE1MdzNBcnpuUkhUWGdCQjJw?=
 =?utf-8?B?V3R0WjhVN1IxcUtaQmtIaDVYSHhaRFhJdWJSZHBGMGJsbktWNVA3N0d5UGt0?=
 =?utf-8?B?S0E3VXo3a0d5QWExR3NhNUxsWnh5bWVraUVaVUtmVnNEd0ZwcmNRV0xwUUJV?=
 =?utf-8?B?QUx4UjBxYkRpMG42b1d3YVRWN1BPNGRubHVQa3ZHOUdveFd3YWFzeEVqZzhC?=
 =?utf-8?B?aEJmbStrb0FHaWN3SjVEMG9qSDhyN29MYU5NeWJWVWNpbnJKQ2JQS0U2KzVE?=
 =?utf-8?B?OUFUWHZHb2tTa1pXTXdtNVhLS1pEbWZqUDJITWN0WmdFZUZIVG5wdWJ6a2hV?=
 =?utf-8?B?UEdrc3BjNzg1dUVFd1kreDVJQ1cxNFArRXl3L0lrakdLY3o3UmNxUUE4MHo1?=
 =?utf-8?B?a01MM0UrK3VxZUdsamp0djZOYTd5aDc2aUluc1VYQ0FNSG5FWUZGb1AwWmFM?=
 =?utf-8?B?OUdkMm1YNnc5YmU5T1RqUGxBNXRzNkdHUHlPdm1scVlsZ1gzV0VVQWljOG5u?=
 =?utf-8?B?QndDMGg2MnFEN0NQbnpzaVZIS09kN3MyYmRzZElzVXNNYXoxUWNaQzlJSjcv?=
 =?utf-8?B?RnlCNDlNS3pBZi9rU3czUm1mZzdNdS9OM3JYaklZOXcyNDU3U2ZCaTdsK0pF?=
 =?utf-8?B?bDAzZ3g4NitqQUlFbk1FL3BVVytzbDh5SURac2FFUVNKTUI4OG1UQTlkeVNm?=
 =?utf-8?B?Ym1HZnZUU1NDRWRQRVhrdjJLTXZHVlVMVWxHQk85Q1kvam9seE42MmV1WFl2?=
 =?utf-8?B?ZmM3YkN2Y0RhZG42T0RMdEVWZU5QRkZMRC9vaWZldXRMY290UXdwellSVnlk?=
 =?utf-8?B?SU1wRk9KRk1qanJJOEFTMDNkNXBIMzYrYXBrSUhOeWNvaWZxK0VrWHBNamI3?=
 =?utf-8?B?Q2tPSGREQzh2ejd6UExKU2xKaVpkaTN3QzUvbDYxMXpvc21JMFpRM0tPUTBi?=
 =?utf-8?B?b2FsYzFWYlRxOVFVbS80NEVyWUkyblp4Y2p5eThkbHdWMHFRZ2lBanF5YzFt?=
 =?utf-8?B?a3pIMlZaYTJ2M3RYSEtXbWVKZklGVjkwK2RvdjhTOGVKU1ZQK1djVUIxVFc1?=
 =?utf-8?Q?pugmsPjKpkKH4sLOV7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2acb38e-aff0-4f9a-fc56-08de68b5eaab
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 15:06:06.8066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sXTTrs3uik77igogEdhU9v+bVB9VOj5H6sHJIJYwcq4GNBDIKOeEvEF6M3TB2vYICvLGzz4kNigGt1UZxiv6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3511
X-Proofpoint-ORIG-GUID: GCvPZ3aTkGToLqzBRs09P4ekkUHxGdh_
X-Authority-Analysis: v=2.4 cv=aue/yCZV c=1 sm=1 tr=0 ts=698b4963 cx=c_pps
 a=pY+kOdcf8RAo0+yonGAjpg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yacp4PbrAAAA:8
 a=M5GUcnROAAAA:8 a=f3x1QCOo691-KGJfO-sA:9 a=QEXdDO2ut3YA:10 a=_CEE-nPnlLYA:10
 a=V3FWeFeR7HlZ9tVNOp1k:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEyNyBTYWx0ZWRfXyyLjQJ3vGDok
 EEiYg7Wid/uPKDNqfffLofdz821CUxUqizHWj86gBNZPV/FUWvU7qsh+hOXaXB5RsOmMn5FmP+X
 lWcDVEBMkLM2YnQyEueKrmwzTGrIoh5ty+Qk0lgPTXgcVD8bXuzEVRRQddAjzIYXYyHnUTupWn/
 MNqcRr7XxbwAgVXsT94272LYobLYVxRyjD7+nlOYRH+ydioGPUU8S+29AGvUbpIn63iG+YhSWzt
 /8yFbqQ7pKWuOwsI5y+IGNT9xFvwQtPABDee8y8lIa0ACMSmsZnanetxzR4mstWTLO6ar/SjLdL
 qbW0CbUyNxzToVWTswDixq2m/smuV07xebLYHm4h/rFLNmrFCqECo6hXmU5kH6dSxComk8Xh1gg
 ktFZPrMAEVgpW2myQkgYMe4r0y7Em+dvaTwvoOEzJqGpd2EsQA1iGbsPPfheqvI52HVKIIFp2sE
 rMClr6re781kDTf401g==
X-Proofpoint-GUID: GCvPZ3aTkGToLqzBRs09P4ekkUHxGdh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
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

PiBFeHRlbmQgb3BlbnNzbCBjcnlwdG8gUE1EIHRvIHN1cHBvcnQgQUVTIFhUUyBvcGVyYXRpb25z
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2hhb2thaSBaaGFuZyA8ZmVsaXguemhhbmdAamFndWFy
bWljcm8uY29tPg0KPiBSZXZpZXdlZC1ieTogSm9leSBYaW5nIDxqb2V5LnhpbmdAamFndWFybWlj
cm8uY29tPg0KPiAtLS0NCkFja2VkLWJ5OiBBa2hpbCBHb3lhbCA8Z2FraGlsQG1hcnZlbGwuY29t
Pg0KDQpBcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8uDQpUaGFua3MuDQo=
