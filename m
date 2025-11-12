Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ED6CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 08:35:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C250402C1;
	Wed, 12 Nov 2025 09:35:41 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012018.outbound.protection.outlook.com
 [40.107.200.18]) by mails.dpdk.org (Postfix) with ESMTP id 67F194026A
 for <dev@dpdk.org>; Wed, 12 Nov 2025 09:35:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CS3PVyTaeFiKK8Jfx1h1URz4Zv99KVuR9Sno9IbmDs+EFFoPN9fCkG1awWgUBeDOw/3EVScsgLN0wtFhSPmlYxK1DW9SF/axNvWVlxr6YoTSxEs2DEAgJVc3ozKLB328f1GufXk79W6x4k4JgaeAjzIoKQFgNt8DxrcOGo3jBHfi1d2vg10A1UTC700COkoP1QTVzJbq4lkro7FVQrJsYo/l3rS/LSPmzUjcISGlAt+LfImv9hO2Ob/eaoSscvQ4+z9TYErtEcstoLUyDR27CsTBEdb5Q0Tvdr6youh1PhlcRiDFavXJ4dMZjILkukG7aZF7Bf5ZwIh4Dh6kYZmzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYWH5aK4gsBPIoUn55yKUqHrdCg/XXBJwRSz+hGjBoo=;
 b=D3YMWvi3FVv+pvlviPy81fHSGWFYl71uVCV7zrfdKx4rpYDi9P9P2ALITDa+M/VCpm96rQ29ZdRDoh+RaAJ0V2mPMq/HI/c6TD0RJmEICzUH/SGykCXHDRwPBXLHhSkBH9gP2U3pK8aUAp6HcrzSLx1M0yRFx7R9+CGGtq4PQhOeJlFzGIdQ7Qr1FvQED4tSajVwFR/Kh20KLyS5CTGNIsxHOALxXB40nEtbyFOvsjl5d9Dufn4T7xQ8WBvMoEOppdszN1ybFyChAMJgKw6mzg//f6RitD712gtxkqsyTlpgzu21eMbmfQBnLZG3m+25+mS8TSw0GLU2BpfbJ/HGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYWH5aK4gsBPIoUn55yKUqHrdCg/XXBJwRSz+hGjBoo=;
 b=UtzQ30anNxqKt2r0v+n02NaLN0nQHw/aosYMnaS0PEM4Ptkbi/1fqQSXtiOsfaBHgwg2Dz1EmJ6sGGPLE/+hPy5a4pOAbT/gAiSDiq5ubsjjnjFCBGt0ZZEWiAKmCdVvHaVLp7RdBeCCtiDUVBuxQfXCMgvhr3G1TFlwOVwMDO09mPSJ3mNRjhX2lUB0IPiJGxt/ke6vzVup35DbhgaMotxBVilUQiWiCOtpq0j/VzPKobzyg40nyhIECZJ03iNznX4zWNPiVqf/gSRW3te1nKqbExepoq1+PX0wJOP68t8RjPfXgfQVPJ0SZ1RKg9kujikbEZYfQH1zQ8beMa+QVA==
Received: from CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 08:35:38 +0000
Received: from CH2PR12MB9544.namprd12.prod.outlook.com
 ([fe80::e839:c726:ff9f:706c]) by CH2PR12MB9544.namprd12.prod.outlook.com
 ([fe80::e839:c726:ff9f:706c%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:35:38 +0000
From: Suanming Mou <suanmingm@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
CC: Ori Kam <orika@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Roi Dayan <roid@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>
Subject: RE: [PATCH 1/4] net/mlx5: release representor interrupt handler
Thread-Topic: [PATCH 1/4] net/mlx5: release representor interrupt handler
Thread-Index: AQHcU6evDugtvBjR1UGURIpmpQ6oY7Tutxeg
Date: Wed, 12 Nov 2025 08:35:38 +0000
Message-ID: <CH2PR12MB95445BAB64591731DC938258C1CCA@CH2PR12MB9544.namprd12.prod.outlook.com>
References: <20251112074015.8901-1-bingz@nvidia.com>
In-Reply-To: <20251112074015.8901-1-bingz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9544:EE_|DS2PR12MB9687:EE_
x-ms-office365-filtering-correlation-id: 0d29c12f-0aea-49a6-b1fb-08de21c674de
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fWkaeWex5UzendPZst9HIGZWK0nqaMAU/VJaYmUSZQqxZZotJ6DesIbUlPvh?=
 =?us-ascii?Q?FqM/+4S340VvEAn/uWoaWeK8Hse8RZdGkYWcegc3xBdjFmG0Yn+xPuo8gPaW?=
 =?us-ascii?Q?L7+0bM1m7vvBaT/jIZY8aLfcEbJtm4V/iuuh1Im2A5jj+8r7VFpgaHLELlHm?=
 =?us-ascii?Q?X7QpxJXN9QNggsgc47szU54i3Olrujt17jMQYFSpGmRhPf+Tw6nqfX6+ynBX?=
 =?us-ascii?Q?GwVqpQobIXQM3fCt+2O+bMcsZqYcMzccLcYeBdsg4gJGYx0dQGm3mV3Gd50i?=
 =?us-ascii?Q?VTgwE7O6tTKzJX751BQK6kwMcROVPTmh8Km+tdUHrQiTmZLCp5yASGTvFK8E?=
 =?us-ascii?Q?gDdTTCnLEKPZleqQGl//rgNv4jwD6nJ88LjkkGQ3WgMX2BeFIW9RgSRfbljQ?=
 =?us-ascii?Q?LtRMRCtNwNUsAW+SynIarMnCfBD9wKsRDRqglZwqIl6ZV34aLfDQmheRSzI7?=
 =?us-ascii?Q?k8Ihvmzt1di+58DFWCxVS28Mwdl5ryAGl8Hl/QXNrRiiBH/m8Ukp06vJJ0HD?=
 =?us-ascii?Q?dKEt8GTeh1kzLQUpDQGPagAfU6tefiu4jg4ncyDFyPOz0K/pp68zzLuEmE3s?=
 =?us-ascii?Q?P0JxfATl8bEz4+EOByJkH5EwvOhvNgSOswmz0bqe+GcQGXw8vR1X+vpCEo7B?=
 =?us-ascii?Q?IhKO/MZ+eLSSS2vChnmXLbRjzdNgDt/yKmN6fYNH2HLNug/UWJEAQBdAOmM5?=
 =?us-ascii?Q?AOdk3miuJMS/qihfJtlVQSAfWrOVGsc1mpQvhORpTZZzytRUzGYH0xurakFI?=
 =?us-ascii?Q?OXAM1vYJ1pFGrzb5PQNpcMixQnNJ8EIIB44zIEN6RgIs2bCEkpDlocztmwQ0?=
 =?us-ascii?Q?caXn4i1ybSk8U2UbhnlK40YNqBCXhIb+XAsTuY3F6A2w6nt8L6n+581ooBis?=
 =?us-ascii?Q?XMYJr5HfaUjNugkTaBQPfK+8zshUel2ruRqstEH9QHJ3wZznkThIp4OZXNTA?=
 =?us-ascii?Q?ufmg4DpmNFcH8+5mXXpMc5ytYj3RMeTJ0xSu7P5UWeYcZ5ISEmy9O0f1fg0B?=
 =?us-ascii?Q?Ace1pUK7XuEaDn6F5rQ5xa54UZkRfplBolbRaBkDUS3QKkVuQHy9k+4PAdFP?=
 =?us-ascii?Q?PdnUKPdK0yTrXADYyjH1Fiu+gZw+e8tuHVCgfWU1iHUOQ9q2kTHgqHXSlrWB?=
 =?us-ascii?Q?jEUNR6x/jzShgcB326f++Sb0a5GEraCLGSKzBG+DSfr0bylN2FvUN2KwrmlO?=
 =?us-ascii?Q?S83+d0pvNj2yMx/o4E4ARSHtUqpknoFfqOd9QMxSHuCygRAtyvOxl5po0cfo?=
 =?us-ascii?Q?BtzHm5QUQJ95m90qJcwgiQM+1/GuMWpcvqv1AelUtSrIseng8oZJyzoaaujW?=
 =?us-ascii?Q?O+xJqrmdZ3tIAq2hukwMoFcnUVzyQDDXH5rPWE+b0aXBEPEZcwtuCB4joEcq?=
 =?us-ascii?Q?dZkg7gblC3nlJuBQgcN4dhuuGGvx7NNv/KYvXpWpoL1nZVJ72/qUYEeQGwm3?=
 =?us-ascii?Q?WUYzKCYefKfNf5jVtes8yJo2mBDMG2Mjqu1MWeVCWyU76JSqZCju77Vz8t4f?=
 =?us-ascii?Q?QT3kKbF4XNyPPaG9uvl2S0XoyxlI3gmiIZzX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x/D6JhCePrfMAGy1X7qoDGxyYiNuBiqTzqkE++S93xtjieIp8lnql5PJZtsd?=
 =?us-ascii?Q?1Y4V23ac5iVpG03XLkuOpLHhUG6RtavH3NXcHPAWcz9+mJ7WlfugNHQND/jz?=
 =?us-ascii?Q?mevzU/CMHdmLlrRHk+ZricbzApccJuViOneui/9l9Fkx8gWRQTGYaTVoadEz?=
 =?us-ascii?Q?b2Ksk+qOZKauw9WriXI0S2uqwoEnkpeCW2TUdRLuPdzAfZ3jaCJND0ZrzWCn?=
 =?us-ascii?Q?XkG172kfy9oahCcICrNrI7TOUVfu0uKCNsxCrT3XjLazA9TjurzQgBzlbOFJ?=
 =?us-ascii?Q?RvIBsbamAMQlKB/dKm6yxdXuazHpRtTz/5oc1/JOxuBElz2i6QIojQBTsEXu?=
 =?us-ascii?Q?bkMw5NK42s27/9MVUFHw+KJJt1MEPmMQKEwG2ZMArqaoh72yus+LLTBaT7MU?=
 =?us-ascii?Q?0Xn8r/jqsGDtq5ZnvnddR2by31yqbiucIaz02+UQF/yRC8NnkEo+j+8Upxd3?=
 =?us-ascii?Q?TIdMZdlwnzRjQWy1M8UuHwWcCdSbijif+ldml7jGnfBg/gThcokEiGb65+Jf?=
 =?us-ascii?Q?kBlHlpJOmWc9MW0bus4WFMnIBBqhsJ6xn6A6bixp6w1U0zLQIyUlRWgSMZ2i?=
 =?us-ascii?Q?FSPc+5IIN+vbC39qGmiHBHrMnVSAmY52hVZW9BXUsh0HqFNHGA8ToXPmCV7L?=
 =?us-ascii?Q?P+i55zy1JVcVU6oi5S70s6k5+TPzw7oza2VEu/KM0a3MozSAht3Q+prXR+/u?=
 =?us-ascii?Q?vYNiRBNp4XmGgHp2vYqUR013vhb5mlvO17HxQ7pM9oOp4SJowPFtwTipbhue?=
 =?us-ascii?Q?a+0i7KNk3nKY4afXmDviuaS4JZSoNh38lxbQddNLE1IOpwFrxyhFvnHLTwij?=
 =?us-ascii?Q?OeWb+OluoFknYKIZRCvT+W3ZmIweFWZAblbqdjIcOTmW8EEu49BRetjyWx60?=
 =?us-ascii?Q?TgZmKRvNdqaswHUvOrHUYtb9uDsOPUnepsXgYAMmmC6iCMB/9SjIOrqUQcs+?=
 =?us-ascii?Q?QQohFrtG/7qnuFjlWKELud7AwlD4+AXSOTwr6CNzbr8eLKu2lrZiA0CwVxN7?=
 =?us-ascii?Q?L/ODRbFP0RoBrn4F+4tOe0F0Mf7GDBMC2VdU4YKK1oA1R3aBsKYzgQHMMwW8?=
 =?us-ascii?Q?EF5POfWLJwAm1fTy0sPZ5OtJyEAbntrHDJDTGJIG8v5dN05WB2YtNXloXbPT?=
 =?us-ascii?Q?Q9lFDzYoJ9SXV4G/klBwm9zO2AxLSOd861ImCijbS8PfR7aCWclox36Ea2T6?=
 =?us-ascii?Q?k5R83SVpf8zXOEFFe3rboj5T8LzJ2OSFhUTl4L61LsUtXi95RsrDgDjLxW/O?=
 =?us-ascii?Q?8T3qW3WsZMyh+ovpt0m9fIpD66Yt5ddHTxHX4mMNi2/Knfqeycm2j6+lXGx/?=
 =?us-ascii?Q?0FjGv6F++njTL6DA1ZYT4GLENZtXftWTPBemjZLtn3axXnqVvxDb1PyW3kj9?=
 =?us-ascii?Q?9k4j2rABfYO91Jf3qyocKjbnlngfI9F6xh0tyj4v62ExHlUzvNmjqZwmwLrr?=
 =?us-ascii?Q?LrnphBOSwRzqLmP+M6e+6ggExKAV5jPx8PhBzuxhUvQ6/pmw3gOM5E+utX5S?=
 =?us-ascii?Q?yq5ETYOyXxzbH2V3yY1Pn6N/60DJQxOLoEz1JhOrTku7aaQBbTp/Zf7LJ55A?=
 =?us-ascii?Q?Mr51u51U/tUsOozzmBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d29c12f-0aea-49a6-b1fb-08de21c674de
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 08:35:38.1157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vF2pptIOoKL/ANncdjltM9wIvNw9sBovYbc9P3hMwxswYmLCF735cjCy1h0w7I2XyJ6B5SqmhphvGEHNXCV9hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687
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

Hi,

> -----Original Message-----
> From: Bing Zhao <bingz@nvidia.com>
> Sent: Wednesday, November 12, 2025 3:40 PM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> Darawsheh <rasland@nvidia.com>
> Cc: Ori Kam <orika@nvidia.com>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>;
> Matan Azrad <matan@nvidia.com>; NBU-Contact-Thomas Monjalon
> (EXTERNAL) <thomas@monjalon.net>; Bing Zhao <bingz@nvidia.com>; Roi
> Dayan <roid@nvidia.com>; Xueming Li <xuemingl@nvidia.com>
> Subject: [PATCH 1/4] net/mlx5: release representor interrupt handler
>=20
> From: Roi Dayan <roid@nvidia.com>
>=20
> Looks like commit the cited commit removed the representor interrupt
> handler cleanup by mistake. Fix it.
>=20
> Fixes: 5cf0707fc7e9 ("net/mlx5: remove Rx queue data list from device")
> Cc: xuemingl@nvidia.com
>=20
> Signed-off-by: Roi Dayan <roid@nvidia.com>
Acked-by: Suanming Mou <suanmingm@nvidia.com>

Thanks
