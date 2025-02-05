Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BC8C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05465402DC;
	Wed,  5 Feb 2025 17:50:23 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4AD76402D0
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:50:21 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515FZhlW011630;
 Wed, 5 Feb 2025 08:50:20 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44marx86q5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2025 08:50:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkaFNFVQ9wQiL/kTvFuA0dUhxPZ/MMdj5qo/wB3BoDu6TBndEPoVXfEgUTzW69e0X8k+6x/E+2Bw6VLEEgNSy1+ceqpnI0bh22Fart0t6RRTAlMd7XMccQpkt6iTgfBsrbuEVF61eSkZllNLhviB/0qS28fQH9fsPpjn8H4K4Vuk4p4V86WdGcphrs0OWQ9ArggilwJLeCQrqVfkH6d0DMwdH7btOfOQIhkpVGG2nzc2Qdsydp1/v9hlpYMnNZFqn+RfrJBq/lH7TDCarZHajyVZoMDVtQfkqteWjVLV4QaERR2lARtNESUAIi4GXGLNUBvatq92QNqo9T2Jo3TuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daq6NFLXNL2CsIYhPz6jhaV+suYbGj/mQKbLvSnAX7k=;
 b=gyMMsYQzB3D9ieK8xZrfGouvAUB8D/5BZT3AMWvsXgWnA1Y5AHCaFSF3e8IUeTkj0QHXR1VIDl/vYWtATDdfkzhSEPXivLXE6sP6JR3a3gCdrueThnJWcd11QakOsNnfoXp8qVjOBh0BRLo9IzrcFkYURFVJ+uzxmUAzRtFi+GWY5olHj08Wx+BKoLbBg/1cvZg7LSGUbgLbGpxQ1MAopKQZPotkD4jMWSHcrhHaTrOFU+r5oTJGIkZXL1+bT0ajum13BFIMHizWI3SIcgGf6IrHk9FXmP0YtYTKu1UIyYsVWSdE56UfGkmBCma5nWHABUhsX4f3E9pnhk2wdnR3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daq6NFLXNL2CsIYhPz6jhaV+suYbGj/mQKbLvSnAX7k=;
 b=NRHTS+BFCLnpYW9p4xXVNZfuzCNTS+lKWK9YsxMMQ5gvkVKSpQssUZcQ1R3Ujpb1Dr65aSfn+ptNIVxKQBSYyF1981EtZc5IxfuM4XdJHQ4Y5P4LwQchCYTtfa0hR8cT7oN5KASpN0u3PlRsVQG0VyC+x/9qD8l7yAxYsyUt6HA=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by IA1PR18MB5492.namprd18.prod.outlook.com (2603:10b6:208:44f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 16:50:16 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 16:50:15 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, Andre Muezerie
 <andremue@linux.microsoft.com>
CC: "bruce.richardson@intel.com" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "konstantin.v.ananyev@yandex.ru"
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: [EXTERNAL] [PATCH v2] drivers/net: use intrinsic to access
 content of __m128i
Thread-Topic: [EXTERNAL] [PATCH v2] drivers/net: use intrinsic to access
 content of __m128i
Thread-Index: AQHbWMcWOASElksxw0enOkLmSnx4wLM4YWUAgADI+XA=
Date: Wed, 5 Feb 2025 16:50:15 +0000
Message-ID: <BY3PR18MB4785A82529845715EDA25272C8F72@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <1735328684-10684-1-git-send-email-andremue@linux.microsoft.com>
 <1735348983-19590-1-git-send-email-andremue@linux.microsoft.com>
 <MW4PR18MB5244483B1E4E5BC7D58A452EA6F72@MW4PR18MB5244.namprd18.prod.outlook.com>
In-Reply-To: <MW4PR18MB5244483B1E4E5BC7D58A452EA6F72@MW4PR18MB5244.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|IA1PR18MB5492:EE_
x-ms-office365-filtering-correlation-id: f30d89f7-bf5f-45b7-4d5b-08dd46052a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Q21qUjUrSTRYb3RGU2VDSGVEY1VNdjhMK1RMRkNSZWNPb20vMDk4dzJNL3Jn?=
 =?utf-8?B?b0RDLzIxK3hBaDJwQ2ljZFNUKzRXWWxpZlF4U3N2RUc3dWZhbExsRlAwMVVS?=
 =?utf-8?B?WWFzYUpsY09mSGw5YWlxZmtGMUJFZWVXeHcra3BwV3VHc3JoMlExek1ZUXIz?=
 =?utf-8?B?eTU1Mk4zVHV3ZDJNOEN5WlBoRWVBR05mZ1NnZGo4N0hNZVdZWGlaNTVudFZi?=
 =?utf-8?B?QUVCdXBocjIrQWdXNnJ6dzFVeTJUTjE5d2s1K2ZGcTJMa3BqbFVNclZoYXRV?=
 =?utf-8?B?akNXOEpKV3RMT3pQNnNnTm9FSXhnVGM0NjBiSUM2UU9LMDRVS1hOOXJRYzV1?=
 =?utf-8?B?Y3NSclpzYUJDOFE0OXJrTHdvaGs4VXFxWWxxTndlTUpZZ2YvOFRzMmhrRlZZ?=
 =?utf-8?B?ZW5TT0tMbkRWQzdCcUpDN1BXSUticm4vK0hvRVJob2lCQXhPRG0zRGZQZG00?=
 =?utf-8?B?VHRoRlRtTWN4VFIzb21QNEJSZXgrdFA1YjQ3cWx5cnZKWmk1Z1FtUmdYTC9X?=
 =?utf-8?B?K3ZTazRkMlkzbkl3MS9GUnJhL3k2M3I3MHNmQkZSNWJLT0ZDcmhuVmozc2Ux?=
 =?utf-8?B?OHFuY3VCRGxLZTgwQVVGT0oyQktMMWhzb3A3d1doODRBaDBqZ0wzWVNFSlRK?=
 =?utf-8?B?SDI4cXJhUEJSYWI5K0crbk44OU1WWEVQak8wb1FlL09hdTFZUGdkNHlNcmVX?=
 =?utf-8?B?MENDeGtqNndvdnFpamN4K2dud3gvWHlBWHU1VmJBRExKeWY3SXpiNmpjV0Fp?=
 =?utf-8?B?NDdTbTFmTUtjdGlWellKRUgwckhuRzZTVC84R2EvSm9MdCtTcm5scDczcWdv?=
 =?utf-8?B?UjJuQW5KTUdMWkpzcjhXTFpnaU1tdUk3UlQ2UkpLY3pja29TRjhaUnFvc0No?=
 =?utf-8?B?aE5HR2s0UDA5eU00MDJWUjBaMHNHUVY1QllOYjZxbEhiVmhtYmRrUUdYZ1kr?=
 =?utf-8?B?bHAxQmwrcENuTjJKQVNwZzl0WGZudmZlQ01ybGhRbVBlVVR3d2RmaUFHT0ZD?=
 =?utf-8?B?aFM3ZVI5cFZYS3BCc25mSFpicGRKRkxGNEduNnVRQUUxUU5pandjWlJPQ2pi?=
 =?utf-8?B?L2tIYzY4UGhRNm02MkMvZ0c3d0w5OHBGbnh3RE05OXY2NThQclpWckNwdDgr?=
 =?utf-8?B?TER2akpveWt3ZmxJZDZiTUJGL0VBTzlRNjBYanJuVW9FQ3M0UmhWL05JQ0Er?=
 =?utf-8?B?RjZIUVVSbHQrZDlSdy9EbmlGYmluRzVIRC9uTHBJeTJyaDI1TmNUYzJkUm1E?=
 =?utf-8?B?S1RLeTFSNksvREU0L21UQTVQaUJSRXQyRTdLOWczakJ0OWhWL0pVaXRUM0N3?=
 =?utf-8?B?L0MrT1JPMG1IZFhMcEJwWE9wQmN3Mkw0MGU0d1luemZ1bTlqUDBDNzJhV3p4?=
 =?utf-8?B?QkVidGozbFd1bTFVbmJWbHZtYTJvdlB4TG81eE1SbDB2ZFU4eVRJZ1BqU3lp?=
 =?utf-8?B?YXVIbTZRV3lsSnJNVmNwcUpERml3STdmTWlncENaRzF3cFJIZWs1TDVLeDg4?=
 =?utf-8?B?SGNVWDFtU0twOHZCemZZSFEvM2lFMThjOHowcDNRcHcwOVZzSFVZc01EazVI?=
 =?utf-8?B?YWtZbkNtWUZVRTFldkkyT3BSdFNCQzI5b1JyZGtpTDlvN0xsQ2VOUGhSU3R0?=
 =?utf-8?B?bmVDNWc5aFhnZkxjNnFuS04rcVNTdFhSWFpRUVZxMHAvcUNoRTA3UnZFTy8y?=
 =?utf-8?B?SmpNM2RGdXZWZklrZytneHR1T2FlRmJqaXh6TDBCNGFwQm5CdmxqVzRXK2ls?=
 =?utf-8?B?cFEvcDBtRDcydE9PZTBkMng2TDhFVmFObEpLUG4xTWlobmJvdXVrcEVKZHFy?=
 =?utf-8?B?N1pZZnY0aUJycUZJa3gyTEp6TmY2aWxSay9CRkVMTXdFZGNMUjBqdFZPdXMv?=
 =?utf-8?B?V3ZVTnFkcGJBV2I0d2l5T0RqSXZYTkNoL1F3Ny9vTHFwZmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVZUaWszdjAxNXBMaUtsQjdsMElnZ3RCMnNlNGNWV3IwRER0L0tIS3RsN2hv?=
 =?utf-8?B?TUd6MURCQ2NPU2Z2ODJGWmo5QjQ2MEZmalVFNjNIK2h0ZndTbGw3RWRlc1lC?=
 =?utf-8?B?MGlpWm5tVktWeUJUa2FEQ2I1VlYzTGVYSERiYUJCUG03Vk1IcmplYWFhR29r?=
 =?utf-8?B?bkN0RG9mbjZIajdzbExwNEpkTlNrR2xmRm1SZU1hTzdRVUpHWFdPK2xJT3pC?=
 =?utf-8?B?WXZkdVFMOHJlbnBjOHdFTk80bHJtOWNpWllYVCtNWVdZbEw4TWFXK041UE1Q?=
 =?utf-8?B?Smp5d2E0WTI4RHJvd2dFaG1rU2pyeUFQRW0xbU1hZjA4cVNWeFhUYVJzekFn?=
 =?utf-8?B?anR5OERKOXE0eDJhamd0cDJUb0pKMlRrcVJSUTBWUmNNWUFob2x0dm5tTkRi?=
 =?utf-8?B?aXFuTzRCNC9UTnN3ek10bDFYUE5oUVlrdXVvMTNiRE1taVZoaDI3U2pqaUxm?=
 =?utf-8?B?czZ5SzBZM1o3R2NHc21velhManhuYXBzNjBtVzdGK1U2WDRTd0hhVDF0LzF3?=
 =?utf-8?B?cVhNb1gydDFpRXYxb2IwN2RSNUU5aGxFdTRpMGNEU3hPaU5GZEo4N1NmMTRl?=
 =?utf-8?B?Y2lzWkRPaUJaeDlaYjhoQnl5Qng2eXdsVzhidytGUXppcEc4VTljRVgzeUJB?=
 =?utf-8?B?TjFUZkNhNkxDeHBMVHg5MHdRU2UvMWVHL2JnRDRlYnhvbThtb3QrMEtQcW55?=
 =?utf-8?B?eDZqUW5LMEpNMTdpVjE5UWdkZ3BkMUM1Ni9tL1hNUDV2TlRmVWVDWmpEaWxu?=
 =?utf-8?B?bnV6Y2lmMHVXdFNYeE5CUGs2eEwxOEVyVllzWWpsTVhpTk5CcjRyR0ZpZktt?=
 =?utf-8?B?cTRoczVsNWhGWUFPbGNHem1Qb29vdHh5QWlLL0NRNzY0TnFYN3J4Y2pBS1g3?=
 =?utf-8?B?TFhlTXc2OTNmUkI3QXNYb3YxMUVub1cvcWN1TlR0Z2lxRWdrcUtnaHRwVmR1?=
 =?utf-8?B?cEQ3Z21DMVVuUjlSZ3p6VzkrQzlsVitMcU5TRXpKUmcvMlBGT0hkcVRpbXBp?=
 =?utf-8?B?L0tZdlliTVVsRVJwbjRCWHpzWDFDczJyY2pEUGE4UXlSSmwzOHpSaVNtNjBz?=
 =?utf-8?B?Uk9hcHM4a240b2s3S3FYN05WZnZUb29QZkowRXhhdVZYZDZMbUtBQysrVGlG?=
 =?utf-8?B?dnAvV2N6TVlCNEVSMWQ1VVF5RmFETkJ6aWk0TXhHY0ZhMXlicUFleE44Y25H?=
 =?utf-8?B?YVBQMkxmVkJjbXQ3K3AxQWsyMG9xbkNtbG53RnlwUW5iS2xabEJ1Vyt3L0wv?=
 =?utf-8?B?aFFiYjY3WFJMS2VrUVFybHpFL2JiRUhGaStEdG5EYlRST3h4NjMvYnRhaWtJ?=
 =?utf-8?B?RThUUkcwZkc5T2dOa2xubzdOVlBCWDZMYlJxVEVtUUp5RmJVR25mWXlZMTVD?=
 =?utf-8?B?bkpqemZhN1I5bnNQZW5WSzYzaVBCQnNIRGg3dCt3Q3lsamVZQnBWVGxMSU00?=
 =?utf-8?B?eUlObGRBRWkyZ2xxTDR1MW9EUU16TXhLT0RoRDhEUEVxRnZQeXZWcFFhKy9y?=
 =?utf-8?B?L25MaGFVWTM3d3JROW9RZnYrc2kxYVFVdDlDa0p5Q1laY2ZSL3pTOHhvVk9o?=
 =?utf-8?B?WnRIazl1eDEwYnBnMmhBL0VxRVlMSS9DZzk3bG1FT1hsWm5YNEs0bjVqV0ox?=
 =?utf-8?B?VHdvMmdXSXJNRldvRVBLbjJmSCtUOGRiRWdGa3dOM3lMSmtPSTdCVUFxRHh3?=
 =?utf-8?B?ZnJjaTUrUXQ3d0s3SmRNWis3WDI5VGwrV01mSUxtbzZqaTNoUmcydnlaVkto?=
 =?utf-8?B?WmoyVUF4enNyZ2x1RWIwZS9iQ25RaXhmN04xbkhkbTFzVmdSOWkzSTlicUU4?=
 =?utf-8?B?QmUvUnY4Mi9sVTRzSmRtQS9nOSsySlZORUFQV1hJSXBkdjI4RUxSMmI4MTJm?=
 =?utf-8?B?RkhkQW1HamFHdjVOclNBM1o3L0RkS3RsWkc4UTFja29MRFBuU3IzUTdzUVJS?=
 =?utf-8?B?Z0Y3TWg1Q1VkUGQ0NjlaR0dqWkdUTXE2dlhKc1c3b0tScnBTOGdGSHBMTHdZ?=
 =?utf-8?B?K0JOVHJCcE5EMW5SK21QQ1JwU1hiZ1l0TEVteFNpU1RQUlNkcDJpZ0t5N3U3?=
 =?utf-8?B?eHZsTFNpbUEzcndwck5ZcDRQbmdiSnRvbG9BTUpock5pOUhRNjc3eTZmMU5M?=
 =?utf-8?Q?F/abKVFwJhamSl6nPVKO4wsSR?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30d89f7-bf5f-45b7-4d5b-08dd46052a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 16:50:15.8559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlyTp+ep7psgbnQZ+8fftjNgA0mb4P4NAnjikkpLonsEcZxDXthPGlctdYHz9IIEMvCVB938TDvDCTCTb934yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5492
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: K_kAOvf1aNknYiK8Iv8OcvOlyec0YdbD
X-Proofpoint-ORIG-GUID: K_kAOvf1aNknYiK8Iv8OcvOlyec0YdbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
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



> -----Original Message-----
> From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Sent: Wednesday, February 5, 2025 10:20 AM
> To: Andre Muezerie <andremue@linux.microsoft.com>
> Cc: bruce.richardson@intel.com; dev@dpdk.org;
> konstantin.v.ananyev@yandex.ru
> Subject: RE: [EXTERNAL] [PATCH v2] drivers/net: use intrinsic to access c=
ontent
> of __m128i
>=20
> >-----Original Message----- >From: Andre Muezerie <andremue@=E2=80=8Alinu=
x.=E2=80=8A
> >microsoft.=E2=80=8Acom> >Sent: Saturday, December 28, 2024 6:=E2=80=8A53=
 AM >To:
> >andremue@=E2=80=8Alinux.=E2=80=8Amicrosoft.=E2=80=8Acom >Cc: bruce.=E2=
=80=8Arichardson@=E2=80=8Aintel.=E2=80=8Acom;
> >dev@=E2=80=8Adpdk.=E2=80=8Aorg; >konstantin.=E2=80=8Av.=E2=80=8Aananyev@=
=E2=80=8Ayandex.=E2=80=8Aru;
>=20
>=20
>=20
> >-----Original Message-----
> >From: Andre Muezerie <andremue@linux.microsoft.com>
> >Sent: Saturday, December 28, 2024 6:53 AM
> >To: andremue@linux.microsoft.com
> >Cc: bruce.richardson@intel.com; dev@dpdk.org;
> >konstantin.v.ananyev@yandex.ru; Vamsi Krishna Attunuru
> ><vattunuru@marvell.com>
> >Subject: [EXTERNAL] [PATCH v2] drivers/net: use intrinsic to access
> >content of __m128i
> >
> >Compiler intrinsics should be used to access/manipulate contents of __m1=
28i.
> >Existing code results in the error below when compiled with MSVC:
> >..=E2=80=8A/drivers/net/octeon_ep/cnxk_ep_rx_sse.=E2=80=8Ac(61): error C=
2440: 'type cast':
> >cannot convert from '__m128i'
> >
> >Compiler intrinsics should be used to access/manipulate contents of __m1=
28i.
> >Existing code results in the error below when compiled with MSVC:
> >
> >../drivers/net/octeon_ep/cnxk_ep_rx_sse.c(61): error C2440:
> >    'type cast': cannot convert from '__m128i' to 'rte_xmm_t'
> >
> >The fix is to use an intrinsic instead. This compiles fine with gcc,
> >clang and msvc.
> >
> >Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
>=20
> Acked-by: Vamsi Attunuru <vattunuru@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks


