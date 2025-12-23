Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC15E6F093
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 14:09:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DB4F40265;
	Tue, 23 Dec 2025 15:09:23 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54]) by mails.dpdk.org (Postfix) with ESMTP id A9E554025A;
 Tue, 23 Dec 2025 15:09:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prHnHa+76hxjFdVFDIZbFi5omCzKKShPXZX9rob1gzHg00U9iN5To9C/RMFCCtlS3QLR0PuNsHxTNB/wzU8IhZvLZf2depT2CEJ5b2JeTPIG2vCAbS90rILsJZGLGAm156xscFOyElj/uT9r3k9r9sCTRmN0b29BW9SkkwCsB6R394EG1fcCm+pIopGWa60j8dp8MkKAGxV/5Xf2Q/ADVhfDQwFq24bz1CKq4WDsiCzgbR58iR9SRilSzmQ1Oo1UeFso6BCiI5oohrRPs59xf/V9FlfEhaHZvpwf+8lxqhemV1HwBgolR1qP7Xam3wNuJQwGhNexTx5ayt5sN55ztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu88zskqKokwYfbUJaIz/hXTHOFMf+whxqs2p75sH1I=;
 b=vgRXZEBIEICABM6dnA3ot7mCLb2kx9Vfjmup+VhMnpNjtg8EOPyazZX1G9kagJvn05y0LCL/g9yNSwU4lA9QCFDlBpl3ZA4rE3Im5Ys9v7SeDwhnyKajDvFFC6KfyNU7gjClptiBLJcP3CzJ5qXmGzBxnmpjjlgOYZNWAu0PtdGwfrGOWAW2bDJ++DiI4YdC5UIODHSJs4ixJ7Ojn/9TwFulF+Lv2a9FkAJnyjHxoUHnks8FI388ALkQik1Be7dRveSseW//Dw7sShmJe3sHuUAfGWi+kGrQ0GTAB7y6mlXvbejL9eBq0jjN03z8r4JnNwDrxM5BfujDB8Z7gZ3uXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu88zskqKokwYfbUJaIz/hXTHOFMf+whxqs2p75sH1I=;
 b=Qx2EcxrydtwktOQoBkXdIfkGcYleELkYRZAymwXqsfiZTEvfc2oVxbshQ8JzueE1hHlT2RdypkNd4WWlhstPApftMdGAVWv/hVRj95fhputN6RsLWfT1SLCvHLdOD4SgaozWyth3HxwEQBBExpoLXY5yTaM0rWK7SJI3fB9YdbPmD2xp3LOJ6tB9860rirRaSF3p7lteCjAgj9IRzmDtWDvgKJAOTyjDwhwkKYmi5/dB1ewMozbXe1cHBpJqudB4a/DERh+7IIZhhLibO6FlCuImISS60ia8G75UGxCIpBiE0BUsm8HuqKMI8XtbZolqJWaPF8afA2vv3WvxAS23pA==
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Tue, 23 Dec
 2025 14:09:18 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::e7f:6d00:5e86:274a]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::e7f:6d00:5e86:274a%5]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 14:09:18 +0000
From: Maayan Kashani <mkashani@nvidia.com>
To: Luca Boccassi <luca.boccassi@gmail.com>, Ali Alnubani
 <alialnu@nvidia.com>, "Minggang(Gavin) Li" <gavinl@nvidia.com>
CC: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, John
 McNamara <john.mcnamara@intel.com>, Raslan Darawsheh <rasland@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Salaheddin
 Badawi <sbadawi@nvidia.com>, Wael Abualrub <waela@nvidia.com>
Subject: RE: 22.11.11 patches review and test
Thread-Topic: 22.11.11 patches review and test
Thread-Index: AQHcZLjO7Lty3hXNOkag0IUhaR0SX7UnzUgAgAABGQCAAAiiAIAAAnMAgAXI1QCAAb+g4A==
Date: Tue, 23 Dec 2025 14:09:18 +0000
Message-ID: <CH3PR12MB8074149AF08F3DDE53EB3F7FB2B5A@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
 <CAMw=ZnRXeX+UxekNOFtkeTbWYyBm-WosWqOi3MtkQ+4Ot3mFpg@mail.gmail.com>
 <4132b192-db18-4df2-a755-44405501330d@nvidia.com>
 <CAMw=ZnQwf8cH_cO9CK3Y--XmzYU+cfCNJ3YWe8qjNZbuCfSe6Q@mail.gmail.com>
 <CAMw=ZnRPba=cPc1waWhmzkkSK_+iKpdhuFf8u9QZZqDjmScUYA@mail.gmail.com>
In-Reply-To: <CAMw=ZnRPba=cPc1waWhmzkkSK_+iKpdhuFf8u9QZZqDjmScUYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: gavinl@nvidia.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SN7PR12MB8104:EE_
x-ms-office365-filtering-correlation-id: 678bb81e-5133-4ac7-5b2a-08de422cdce1
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?eWx4ZEpzbkpQdktrVWp4N1NVcmE5NnFtMlhOWWZXTHpLdm5paXhab0NWRDZD?=
 =?utf-8?B?NHozUXVhMm85TDAwMnJ0UzF1aGVHb25UVjNab3FOa3pzbytRTmpPR2xXR0N3?=
 =?utf-8?B?WDB2SkxNcXBWbnpsUGp1VUZJcU5YMXNZQVVtRjhFNGxwekZualZ0QkdIa2xF?=
 =?utf-8?B?L0dOKy9yRFF4WEZlODJRSkV5RXJaN2hidUlqVHV5UWczRjJHRXJRaEQ2bmNw?=
 =?utf-8?B?NWR6STVBMjN0Mi83OEtiZXM0bW9KT0xJOFE4bDgxMkl1ZG03WmR5RldEQ254?=
 =?utf-8?B?b3lSUUdlOEtqbThUakdKc1FJZDRqOWo4U21aK2hWdDNRYUZGYUVhd1YrR2Y4?=
 =?utf-8?B?aGRTMklMNkE3VFErblRJOWZwRm9uMkxPcmlWMis1OGtER3V0Rlg4YjVGK3Ny?=
 =?utf-8?B?YlFyaHhqa1BYOHFNclViQzVSOTkyV3ZSbmg2dzVMbi84Q2Q2QzZkd1l3Q2Fn?=
 =?utf-8?B?SEpPQUNrMkdWd1FEblo2UnNiL0FvaklFQ3FqUkRTVG5EbEx0TFdnRWxsYlAv?=
 =?utf-8?B?NHovbmxjUjRjS2wvcDdXMkFQUEFSaDFvUDlPcjlzWjlIdDAwaW9JclRBTVY4?=
 =?utf-8?B?MVM1QjhXTFRDT0NoSDY3cFVvTGZQMXFEeXZqTlZYWW56NE10NTNNcVFrSXJK?=
 =?utf-8?B?WWZvcDRjL24rNWpmZjlUWHNOSi9ud2tnM0RaOVBiRFJaSWV1VG1FVlc1c0Js?=
 =?utf-8?B?UmR2NkhBd0JqT3hFaEdkako5UzZWWkdQeVZ1SUNQcmVHRk4rZjNybFYzZ3Ew?=
 =?utf-8?B?MTd1S0xrckJib1hodi9UbUpidHNPMk1IMTcxaTNrQ0Q0cGFSNG0wZXlmaXJa?=
 =?utf-8?B?YXAreG53YkhuZDBaT3BJdHQrWTZQbzZ5WU5jamRLQ1M1WUJlSDZZSTh6Nnpw?=
 =?utf-8?B?TlBhTE4xTHlSbmFBeGlheHlncVVBWExKZVJNUUhMbjZQMFkxVHNZQk5JZzVC?=
 =?utf-8?B?N1BGL1R0T1lGa3NiVlN1QU1tSlRjWVBCc0xyR05aR2VyK0IvNVJDT0RsUnBt?=
 =?utf-8?B?ci9Ib2RBOHRVWUtIeEVDTUg3Nkd1b3JYaFV3Y1NGSzY3ZmdkMG1jUUd3K29S?=
 =?utf-8?B?b0xRTHNCQ0JGUVk3TjNJd2JnTzZ2Z0xYVEZxS1gzb25jM0UyY05BSXNRRjcw?=
 =?utf-8?B?YVVKMzQ2UFp4Y3dpQUJ6QWp2azkzU0dOcWFRQURPRHhScUgwTVBnL0pCaS9u?=
 =?utf-8?B?RTdEYVBDZUZLbTBPaGZLSTZXYkt2emFxMy96NUJVNFhCQW5iUFdzN0NPRGh5?=
 =?utf-8?B?NFArSkJtbWVwekxTMk5QanFlUlBMZGw1K3VZWmpXd0UzbHZ1eTRYaFd2S0dn?=
 =?utf-8?B?N0liYnNSYmtjQWEyUDFDSFMySG4vcU9ZK1dZaG4wUWpFRW9EYTRYTm5hdStC?=
 =?utf-8?B?MWVqcGthZlZBdyt4Rk1WbXA0STMvLzE4RnR5OVJIbXRrazc3Nk9uSmZ5THlX?=
 =?utf-8?B?Rlh3cXJXMUJBSXRwTlhCNlpxZXE0REJoeXN4SE95UENjMEtqSGs0RUJwa3l2?=
 =?utf-8?B?azRDbjRKUFdGYlJaTkJSOS9YVzFUd2pTZmpmdnlIKzA4ZFJwSk9HUzVyaDVt?=
 =?utf-8?B?UVBkRkx0T3VQVGU2MTdKd01FS3pLYXZSTnlycStXV05xU2luN3dDM1ZyWVVB?=
 =?utf-8?B?N3dJY2RNV2w3c3ZvMC8weDFHSnNYWUJHWngwZXE4K3MwUmt3bDZsdkh5ZndN?=
 =?utf-8?B?b0ZHNFdsWTU5a3FONVNSNndXVmJDeWFmaGErdm14Q1pWVUs3NjJRMXJQQ0lo?=
 =?utf-8?B?WkMxUnhEZnpMMVZCc09xTVBJeFhZTmpMRXJqekMwbVo3OHFadUQxK3ZieTdx?=
 =?utf-8?B?djd2eVRIakQwRmVhT2ZKNVFMcWFvS1ZXSVc4QUV5bzhtVlcwdWVNMVpNR3Jo?=
 =?utf-8?B?S0FuQURqOFVUbkloRUNtVnZmcWtzOVBtTVBkakpZMHI4M1d6Z2gzMjZmd09l?=
 =?utf-8?B?cndZMXRZckVvUnNOSFJZbjFwaUZBYit6U0NzQStmdENodTU5S1gwaWlaeW9q?=
 =?utf-8?B?YXZ5VGptdEJoVERlWnAyTldNMGZhRVRMZGZNdW80eEtnMys2dFlBMjZXbnJD?=
 =?utf-8?Q?mjSJHy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXVrU1hZemR5UnMxMzBJM3hQQlVPYXZ4YW9xOEU4M2duSkgwK1JuYmRZRm1T?=
 =?utf-8?B?YXltNSsydmhJcWpneE8yTlhvblJVbkdKb3ZGMTFWUTF4YTM1TDlRZkVKemlt?=
 =?utf-8?B?U1ZuTm1vcDU3dGhub09pOW9heTNENkkwNkpTcjYvWWltSU11N0lDdjNQZ2pr?=
 =?utf-8?B?WERIaFBwUndaeERtM2dRZFJyYVFiN2htMUkxdSt6SzRsWHFORUFNTmV5Zkpz?=
 =?utf-8?B?WGE2UjgxQThQakFqMmkzd1IxRmpmSVVQUUdKMHZYd3Fpa29YVlZGeU5wcS9N?=
 =?utf-8?B?VXZPclE4WVl3WmRVSWhJOWtRWklMS3cyQTlzQlcxdnY4amt4RVEwRTgyVVg2?=
 =?utf-8?B?dkpucVJEd1VWZGFrR2lBQTNZcXR0a0J4TnY2ZEE1YnhBTitjZVJobmh3czAv?=
 =?utf-8?B?bHJDUDVTTEZrUTdhT1V2djZlejdnWlNvUEpiaXlZTTNnTG1tb0ZoVXkrYkdF?=
 =?utf-8?B?NDEyWVlEUXhTN0FCanRCcE0xSVFmWUc0Mnd2OW95ZS9tT2VVd2xTU0wxdEk1?=
 =?utf-8?B?MUJlZ2hnTEpydHR6emo2eVZRQ3NZZmd0OTN5Uk16OGY3U0IvclNPQUlkbzFx?=
 =?utf-8?B?VzcwVDJLMGhxOWZoQWtYcW1KYnl5WDNhMFZJejZTbTZHNkdxOUVxSDIwNzNO?=
 =?utf-8?B?N3pTN1VlR1R0VmFxTEpIUXp6bitmek84WkxGc0FWdTRvdjNuNWZ5bml3ZFN0?=
 =?utf-8?B?NlZ3Y1JpTWNMTlRQQ3R1aWQ4enRiYk5lR1QvUzQ0dkVUajRSWkU2azQ5R2Rl?=
 =?utf-8?B?eFNpTkg2ZnhUNGRNU0JWcUpXM3ZiZUU4a2xvQ25zRUtpK3VibHEwMWFxRFJp?=
 =?utf-8?B?RGFXbTF1Tkd0a0hvWUFMVlZjR29pSTJQeXRFdEZDOXNkSERvQXNOY0Zqb1NI?=
 =?utf-8?B?OUJ5a1BWQ1ZUOEwvR1BzOXJsUHYyQlRzTytHYldWanpCZVhBUWdnUEIwaHlN?=
 =?utf-8?B?dTIvYk5yZ2xYTXVsSFVuRHdpSXdueldPcVkwR3IyS1VSRkFFN3ovazVFckNC?=
 =?utf-8?B?dm1zdk1FUEkyZjNwbFdNQWtwZnZHMVdEVGFDUlB3eGNONGZRZVVJZFQ0R0Jl?=
 =?utf-8?B?ZmwwV1VPSUlBazBvZ1J0anJLaisyNjk3elU2bURzVmpEcE0xWlN3L0JzU1NS?=
 =?utf-8?B?dFpIWXQvYTU0UGlQeU5hQ2cxSkZoeXdnVytZV1FIN21GekdSdCtkVDd5TTNM?=
 =?utf-8?B?V1pqNytXS2VHTzhhSHV4bG03SjRlQzdDSXNvU2k3d3lDLzcwTjdUQW1qVWY1?=
 =?utf-8?B?cm9pbjk4VmtvVWlKcUh5emJpOEhyZE5sMWdXbW1CUm9BWkxGMk1uSlJXdVNu?=
 =?utf-8?B?UHlyT3dOMUtialpxWXBZUFhQdmx4TXJLWlp1SWtZV01OL2d6UEpLN3ZaOU1C?=
 =?utf-8?B?czVScmcveUJzU2R3WFQ0Y0dDbXlYUzZnK3htMGxSYUZhS1Fmd0FhREdIUDhH?=
 =?utf-8?B?Vm1XOFg1U1pVSU5GMTBGaUpsQU1KRnRkVUIzbzhiNXBqdENROW1NQ2RhVjZn?=
 =?utf-8?B?Vys2L2xqbk44K3VQcUtabEw0V3VTSFREbys3VlJuVkxQcGhjbXE2U1RGMGV0?=
 =?utf-8?B?dys3N3oyS3VxN1B0RmZmUWxVbXNEaHFicHVlSSt6YlBDajVseHhHdmdWSld4?=
 =?utf-8?B?ZjZmUnUxQVpLZVQ3R2xPUlJPSjVhNlhZUzcrdzF1WTUyQVIwenZObFBxbXRO?=
 =?utf-8?B?cHc2WTJ2cFhZVFZCSTNHeVNETGhveTBqSEgxR3lHUlJ3Uy9UL2NwSVBKMUJs?=
 =?utf-8?B?ci9WSWpuVUtnbitXREdvRElodTVFb1lJVExZbXYvTmNybUEyanBzVCtTVE1K?=
 =?utf-8?B?Y201clNWcnprN25UNzJ1UGU0TmdPNXEzTWZzcWRWcW90QVlDVDZETzcvV0FH?=
 =?utf-8?B?VjUxVWR2M2NSNVBxckZGMU5ZUUp4TGZRQ1BHUXJTck9CMTUzRDFkYmh0TE11?=
 =?utf-8?B?dVZXdEZRK2NuU1hpQzJTczJFaGgyK21idFVWVU55ME9IczZ4TlVDbFNxMU9s?=
 =?utf-8?B?YmJmMnFQZThEeHNVMjF2Y0JtamdmSGxmSEdJS2Z2M0VkVEpXTCtzNnpJeU9u?=
 =?utf-8?B?TGcrSk0yV1FNT2hIaFlHdnNjZXRiWHdrSk1iQm1UZDhibzZoRUZvRUpKamdL?=
 =?utf-8?B?K2VYUmhiUTBMWkMxay9PTytBL2poY1VqcEd5a1l0dHcveDlqUmtTWEIxY0s2?=
 =?utf-8?B?VUJRSnRaMkUzTWRyYjMwZDBGQU5ZU1JDUm9EMkVVOWd4N2pWNVlVZmVrWGxS?=
 =?utf-8?B?cUgzRGxibGhzeGdqRWNRNVNOTnVoeThISU45NGQyd1JEc2IwRXdzWVV3cEkw?=
 =?utf-8?B?d0ZHaDRZTGY0S3NMNlh5ay9GQURXZTNZMCswVzdXYUxockhxVWovQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678bb81e-5133-4ac7-5b2a-08de422cdce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 14:09:18.4786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLthfYk1xHfGiJvWn2XXFPuOZPaZdNuaiPTK5N6mlBtTFQIjwHRXdQGO8/z+141Ji6Fk/LZ5V9X88cZxtwzI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
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

KytATWluZ2dhbmcoR2F2aW4pIExpDQoNClJlZ2FyZHMsDQpNYWF5YW4gS2FzaGFuaQ0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1Y2EgQm9jY2Fzc2kgPGx1Y2EuYm9j
Y2Fzc2lAZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIDIyIERlY2VtYmVyIDIwMjUgMTM6MjcN
Cj4gVG86IEFsaSBBbG51YmFuaSA8YWxpYWxudUBudmlkaWEuY29tPg0KPiBDYzogc3RhYmxlQGRw
ZGsub3JnOyBkZXZAZHBkay5vcmc7IEpvaG4gTWNOYW1hcmENCj4gPGpvaG4ubWNuYW1hcmFAaW50
ZWwuY29tPjsgUmFzbGFuIERhcmF3c2hlaCA8cmFzbGFuZEBudmlkaWEuY29tPjsNCj4gTkJVLUNv
bnRhY3QtVGhvbWFzIE1vbmphbG9uIChFWFRFUk5BTCkgPHRob21hc0Btb25qYWxvbi5uZXQ+Ow0K
PiBTYWxhaGVkZGluIEJhZGF3aSA8c2JhZGF3aUBudmlkaWEuY29tPjsgV2FlbCBBYnVhbHJ1Yg0K
PiA8d2FlbGFAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IDIyLjExLjExIHBhdGNoZXMgcmV2
aWV3IGFuZCB0ZXN0DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBs
aW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIFRodSwgMTggRGVjIDIwMjUgYXQgMTk6
MDYsIEx1Y2EgQm9jY2Fzc2kgPGx1Y2EuYm9jY2Fzc2lAZ21haWwuY29tPg0KPiB3cm90ZToNCj4g
Pg0KPiA+IE9uIFRodSwgMTggRGVjIDIwMjUgYXQgMTg6NTgsIEFsaSBBbG51YmFuaSA8YWxpYWxu
dUBudmlkaWEuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gMTIvMTgvMjUgODoy
NyBQTSwgTHVjYSBCb2NjYXNzaSB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCAxOCBEZWMgMjAyNSBh
dCAxODoyNCwgQWxpIEFsbnViYW5pIDxhbGlhbG51QG52aWRpYS5jb20+DQo+IHdyb3RlOg0KPiA+
ID4gPj4gT24gMTIvNC8yNSAyOjU2IEFNLCBsdWNhLmJvY2Nhc3NpQGdtYWlsLmNvbSB3cm90ZToN
Cj4gPiA+ID4+DQo+ID4gPiA+Pj4gSGkgYWxsLA0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4gSGVyZSBp
cyBhIGxpc3Qgb2YgcGF0Y2hlcyB0YXJnZXRlZCBmb3Igc3RhYmxlIHJlbGVhc2UgMjIuMTEuMTEu
DQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBUaGUgcGxhbm5lZCBkYXRlIGZvciB0aGUgZmluYWwgcmVs
ZWFzZSBpcyBEZWNlbWJlciAxOHRoLg0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4gUGxlYXNlIGhlbHAg
d2l0aCB0ZXN0aW5nIGFuZCB2YWxpZGF0aW9uIG9mIHlvdXIgdXNlIGNhc2VzIGFuZA0KPiA+ID4g
Pj4+IHJlcG9ydCBhbnkgaXNzdWVzL3Jlc3VsdHMgd2l0aCByZXBseS1hbGwgdG8gdGhpcyBtYWls
LiBGb3IgdGhlDQo+ID4gPiA+Pj4gZmluYWwgcmVsZWFzZSB0aGUgZml4ZXMgYW5kIHJlcG9ydGVk
IHZhbGlkYXRpb25zIHdpbGwgYmUgYWRkZWQgdG8gdGhlDQo+IHJlbGVhc2Ugbm90ZXMuDQo+ID4g
PiA+Pj4NCj4gPiA+ID4+PiBBIHJlbGVhc2UgY2FuZGlkYXRlIHRhcmJhbGwgY2FuIGJlIGZvdW5k
IGF0Og0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4gICAgICAgaHR0cHM6Ly9kcGRrLm9yZy9icm93c2Uv
ZHBkay1zdGFibGUvdGFnLz9pZD12MjIuMTEuMTEtcmMxDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBU
aGVzZSBwYXRjaGVzIGFyZSBsb2NhdGVkIGF0IGJyYW5jaCAyMi4xMSBvZiBkcGRrLXN0YWJsZSBy
ZXBvOg0KPiA+ID4gPj4+ICAgICAgIGh0dHBzOi8vZHBkay5vcmcvYnJvd3NlL2RwZGstc3RhYmxl
Lw0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4gVGhhbmtzLg0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4gTHVj
YSBCb2NjYXNzaQ0KPiA+ID4gPj4gSGVsbG8sDQo+ID4gPiA+Pg0KPiA+ID4gPj4gV2UgcmFuIHRo
ZSBmb2xsb3dpbmcgZnVuY3Rpb25hbCB0ZXN0cyB3aXRoIE52aWRpYSBoYXJkd2FyZSBvbg0KPiB2
MjIuMTEuMTEtcmMxOg0KPiA+ID4gPj4gLSBCYXNpYyBmdW5jdGlvbmFsaXR5Og0KPiA+ID4gPj4g
ICAgIFNlbmQgYW5kIHJlY2VpdmUgbXVsdGlwbGUgdHlwZXMgb2YgdHJhZmZpYy4NCj4gPiA+ID4+
IC0gdGVzdHBtZCB4c3RhdHMgY291bnRlciB0ZXN0Lg0KPiA+ID4gPj4gLSB0ZXN0cG1kIHRpbWVz
dGFtcCB0ZXN0Lg0KPiA+ID4gPj4gLSBDaGFuZ2luZy9jaGVja2luZyBsaW5rIHN0YXR1cyB0aHJv
dWdoIHRlc3RwbWQuDQo+ID4gPiA+PiAtIHJ0ZV9mbG93IHRlc3RzDQo+ID4gPiA+PiAoaHR0cHM6
Ly9kb2MuZHBkay5vcmcvZ3VpZGVzL25pY3MvbWx4NS5odG1sI3N1cHBvcnRlZC1oYXJkd2FyZS1v
Zg0KPiA+ID4gPj4gZmxvYWRzKQ0KPiA+ID4gPj4gLSBSU1MgdGVzdHMuDQo+ID4gPiA+PiAtIFZM
QU4gZmlsdGVyaW5nLCBzdHJpcHBpbmcsIGFuZCBpbnNlcnRpb24gdGVzdHMuDQo+ID4gPiA+PiAt
IENoZWNrc3VtIGFuZCBUU08gdGVzdHMuDQo+ID4gPiA+PiAtIHB0eXBlIHRlc3RzLg0KPiA+ID4g
Pj4gLSBsaW5rX3N0YXR1c19pbnRlcnJ1cHQgZXhhbXBsZSBhcHBsaWNhdGlvbiB0ZXN0cy4NCj4g
PiA+ID4+IC0gbDNmd2QtcG93ZXIgZXhhbXBsZSBhcHBsaWNhdGlvbiB0ZXN0cy4NCj4gPiA+ID4+
IC0gTXVsdGktcHJvY2VzcyBleGFtcGxlIGFwcGxpY2F0aW9ucyB0ZXN0cy4NCj4gPiA+ID4+IC0g
SGFyZHdhcmUgTFJPIHRlc3RzLg0KPiA+ID4gPj4gLSBCdWZmZXIgU3BsaXQgdGVzdHMuDQo+ID4g
PiA+PiAtIFR4IHNjaGVkdWxpbmcgdGVzdHMuDQo+ID4gPiA+Pg0KPiA+ID4gPj4gRnVuY3Rpb25h
bCB0ZXN0cyByYW4gb24gQ29ubmVjdFgtNiBEeCAoT1M6IFVidW50dSAyMi4wNCB8IERyaXZlcjoN
Cj4gPiA+ID4+IE1MTlhfT0ZFRF9MSU5VWC01LjgtNy4wLjYuMSB8IEZpcm13YXJlOiAyMi4zNS44
MDAyKS4NCj4gPiA+ID4+DQo+ID4gPiA+PiBBbiBlbmdpbmVlciBmcm9tIG15IHRlYW0gcmVwb3J0
ZWQgMiBpc3N1ZXM6DQo+ID4gPiA+Pg0KPiA+ID4gPj4gaHR0cHM6Ly9idWdzLmRwZGsub3JnL3No
b3dfYnVnLmNnaT9pZD0xODUxDQo+ID4gPiA+PiBEaWQgbm90IHJlcHJvZHVjZSBpbiAyMi4xMS4x
MCwgZ2l0LWJpc2VjdCBwb2ludHMgdG8gNThhNjQyMWJjMzk2DQo+ID4gPiA+PiAoIm5ldC9tbHg1
OiBmaXggbXVsdGljYXN0IikuLg0KPiA+ID4gPiBUaGFua3MsIGFyZSB5b3UgcGxhbm5pbmcgdG8g
c2VuZCBhIGZpeCwgb3Igc2hvdWxkIEkganVzdCByZXZlcnQgdGhhdA0KPiBjb21taXQ/DQo+ID4g
Pg0KPiA+ID4gSSByZWFjaGVkIG91dCB0byB0aGUgZW5naW5lZXIgd2hvIGF1dGhvcmVkIHRoZSBw
YXRjaCBhbmQgYW0gd2FpdGluZw0KPiA+ID4gZm9yIHRoZWlyIHJlc3BvbnNlLiBJIG1heSBub3Qg
YmUgYWJsZSB0byBnZXQgYmFjayB0byB5b3Ugd2l0aCBhbg0KPiA+ID4gYW5zd2VyIHRvZGF5LCB0
aG91Z2guDQo+ID4NCj4gPiBUaGFuayB5b3UsIG5vIHByb2JsZW0gaXQgY2FuIHdhaXQgYSB3aGls
ZQ0KPiANCj4gSGksDQo+IA0KPiBBbnkgdXBkYXRlPw0KPiANCj4gVGhhbmtzDQo=
