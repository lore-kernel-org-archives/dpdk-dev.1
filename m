Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62B3C021BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 14:00:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA554402D8;
	Wed, 26 Feb 2025 15:00:07 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by mails.dpdk.org (Postfix) with ESMTP id 97AE44026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 15:00:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7+8/mhAYAEzhmIshV/TI7gKxSCC+VhMb05imtZL5qNNqImDvGiIb0FthsE393F4oSX+tsc3wQ1L/wBF3m8v1si1m50YXYA5HP+1amDCF+pby53WEvQiKqcc+5fOYmeVgY9A/WZxJlUN+Su3DPSM4l4SH7XxU+/LiuCq2pvRkiACVwh+jmXp0i6BZu5CRiXWXsAQ28J1lp5c+6lhfqKBslWyIuPjjFSLFXFZABZoK+2Gbmm+/ZpPDSdKY+abeFFkwm9F9OzWaVOmoug0YTTwIUuAF1vyqvscEDWWDtV/xJFbs21Ftq67AZjJLhlMfJw8QAtNqqrf1oAz/FL+kuS3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJdRJrIRZd9xfq1mFH5y3dzXqMPiMj9lsamJkszo2+0=;
 b=x9tYozuO/ud7qAC02FnpA2siG2qzsbT/oHyelH+lXCiVeSv1AK/8HVNu2qSj278HdkEhdOJ8axYXw07ItPhVSlQmgpEC1O3c8l6ur1WjrNZgmvE3ujQAYWuyN3G/CyqVCCRq4fZUzh2yyuZG8jAm0HxbcexDVJSW648QQVYtGlxSstSuZNRDBvJaFOX8rl7gXJBieYWM4wNrIWmPACC3qW9T6ivu7cye5IB0YyOFx2Nno5n+qh4cJjDvXlR70ydBiMu5/4ijS/BgNcK3EG0QK75hZ5M5tIulep/coofx5ITF920wEfXcDGjekTnT7/6FJPC1o0zjSWfYXZB4fRMEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJdRJrIRZd9xfq1mFH5y3dzXqMPiMj9lsamJkszo2+0=;
 b=au+7CQCBJwedq+WoM+vtNDcGPBIqTty5ntrjnK6MtCjzsDAEX9RxQ2f3uXsT0YG2P+uT1CyeWcOcs2Yf1lOnk4IUtUagZGJ/a0phbZ3W9B18rh3LkSy0eF/yyou4Ew5qH0FIzwH8W1Q+CpuqU2Awpj3GSKzI48lwg7Y++Sn3vgv4ErxR3WGsO4n6qVaZKn+gjwbt9l4LUox+M45voEIekn9moB93OVPo1weWXzVN4hxQ9LItsbd8cEs2ljQyiKwVzHAXh5zkbUrJSmEu3q+rzrXWt1W19fluXfImIWHhTf7ZozQV1fz56Sok/7bD8nEsWd7q4F0L5Uvz/Ty/jo+yPg==
Received: from PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 14:00:00 +0000
Received: from PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662]) by PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 14:00:00 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Suanming Mou <suanmingm@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH 3/3] net/mlx5: allow FDB RSS
Thread-Topic: [PATCH 3/3] net/mlx5: allow FDB RSS
Thread-Index: AQHbhx6tMti1MtHRDkOdzXm2e/KO5bNZaTSggAAxYoCAAAQyQA==
Date: Wed, 26 Feb 2025 14:00:00 +0000
Message-ID: <PH7PR12MB690585351CFF3CCD1791A02CD0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
 <20250225004527.2066812-4-suanmingm@nvidia.com>
 <PH7PR12MB690552DE1E8E766B1A208A19D0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
 <PH8PR12MB73268FD5C626A333580DD980C1C22@PH8PR12MB7326.namprd12.prod.outlook.com>
In-Reply-To: <PH8PR12MB73268FD5C626A333580DD980C1C22@PH8PR12MB7326.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6905:EE_|BL3PR12MB6569:EE_
x-ms-office365-filtering-correlation-id: 87735e22-85ec-46e4-d513-08dd566ddc74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OVTHiPAUusIjp6QwqDMayDxfMVPEXy50PU5GgfztS+iTCAxow8SZufgi3tsb?=
 =?us-ascii?Q?xBq9Z/m57xOsPCsZtzyn0VqFJhG7jcj/XsfEvm8O/tyVYnph1v0UUcEOoA7z?=
 =?us-ascii?Q?b9FbykfOM6+YWPATCeKEltSiNqv7GnoSYkYB3yqXS06Hdd547TJbvKHwO5En?=
 =?us-ascii?Q?w/JRMs1vLGxXKtNdyRIyqFzIgQbGH3PeoW1XOp7f+KRYwIObfnuhdBg1qFn+?=
 =?us-ascii?Q?MA4Ez4aLaPG2wVyilDL9/ABBj3vC//TKP72yKZ+BDS1xSrndu59tNGFQg4nw?=
 =?us-ascii?Q?QoG2GPKoNc+yMbCGmfHRL6x3OczCOYzIY61KFTD1XJly3Fr3kCqwNpLpCMpF?=
 =?us-ascii?Q?UJDPx6Dr4HqiyZsq1gZnDWkMHFZ7UE5rix0aX4z+8VbKGeZM8UDB9kM4TFeh?=
 =?us-ascii?Q?r39RHdp+dbZG0bB0xEP1C4BQXdRe6dpBnd4qBE1N8b4lmD7CTIaNXpxpDFGl?=
 =?us-ascii?Q?df1bpUy7PRKkrsCLeaytlMdB+9fZ/Av0Xc4Y0eZDURzOIClQzIqTCpK8E1lD?=
 =?us-ascii?Q?UFJHvQ1NZqta8oK+IZZ6uJ9Z35r8a79jFiH8f3XZT6D9WVaFre9zoABh0j3C?=
 =?us-ascii?Q?5EsIsit2tJAP8tZS+qzGBQnpF8TGqHJtwP7SN/QhlX59ieGYgvgmzImfXobi?=
 =?us-ascii?Q?f4evk+An+kKu9U3Sc6Z7xYXkhI7pu0Ky7GOuokPJ/opzPtwn0N2quNn07mV0?=
 =?us-ascii?Q?1CArgjnvJCc4MP8clIQuKj5qWk9JrKusBYOHYmrc/u6WTdhM2rUdcGPBt85Y?=
 =?us-ascii?Q?dWaavjgJER5u5GqBDZ2/bnV8wjxIoV+sfZwpptrEVSFtRmq1xaIx1gBR5k8T?=
 =?us-ascii?Q?Uyq0HbNIpHWMKER2IMBQ/5FcngI41s0ruVOhg6qP9Qr/qpuBqGDTa8mJc+4c?=
 =?us-ascii?Q?xxDVDEREJt96COLDpN0C9dxHYI19y8pfFo4cVWmg6QAI8OdytwEftxYZ3ts5?=
 =?us-ascii?Q?96uVKABCyBjoMF3f5ml95ers9OXm7O61uuJigVOge/eqU43rCZjYl3lijupu?=
 =?us-ascii?Q?XOIgte9FSsV+7UCeKEMuTm+vsgq87tuLkksT30dQ9cam5cPADt6pC1++CMaT?=
 =?us-ascii?Q?+J6h9Rv9XbMwKG+I1deDMYhIBKYmk7ihAK/YMTs48pMuf3sTkpiqTfa4lmOE?=
 =?us-ascii?Q?Y37Zizh6ZipHz89UEAlX5rNCvKKaVhGJVsiJb5U0rUcn3ANPqPfYebXJBfFA?=
 =?us-ascii?Q?pYxElHnSAZV+wdJfruHwj30WZpF84ZhUxa+4ekCbKFmco8AdrN3xNU93e0Q1?=
 =?us-ascii?Q?MdP5PBKrYpAj0g3KdTxj5nly7FdRpYOlpSKrQ8RfSK15ejtEC7lymuBVTPD7?=
 =?us-ascii?Q?xZTsx+qocJtz1N7Y8GFtA9ExMoGhEHfa3BKaq3wvMwEZETiQ/K1iOz5/8Yxf?=
 =?us-ascii?Q?MLv3B6Nsv/6X8o8luyR8A8J+Zq7FDX2ovMn//1kCqNkcx5nMFiu+1OnBSu/8?=
 =?us-ascii?Q?71pivbMYNuSRQvCT2KS6+VKHQVwZqELW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6905.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GobYq9dvt7eJt5RgV+UhNW3r9uKpYIkzg1zXjfhanpc1Mx8lf5dqdO4CHacW?=
 =?us-ascii?Q?3tJRt8ULc5k08WrKXCOLDZSqHF91FmRclZMJnKqOjM4J7UHdnq2cziWEvkxf?=
 =?us-ascii?Q?y8iCUupgh1LiPWthskvrBXWzt9KcvUO7kUaFuiqdrT6VL0VXh/SzP+XCL4Ty?=
 =?us-ascii?Q?gQaLli4cmZMK2ad6sgVI1A5DY2d4AIWJYy/IzgZepS4QlRjffStE6N5Xg/EC?=
 =?us-ascii?Q?GDVzKhU8I7lgiXN4hDuJeHs3xSlVp5qNn5bRi+3wejUnfjDWIwtzqG+Njk+j?=
 =?us-ascii?Q?sQ1NkdCQ82kOjOvfjo7N6jYgsk0YXX93ZK+vOmnH9GfdufV8Bzf/yAH9Hokz?=
 =?us-ascii?Q?LBib5SoEOXnQ7dBmYpJcLdi1jZQoFrs7I0AsxYpmo9dzOcwhRU8jwD957h/f?=
 =?us-ascii?Q?0UMBYGEeWsuVvRlNxGnWkpKfG6jjwRCpjflj4wQKQTq+JSArIh1reMN7qzTU?=
 =?us-ascii?Q?cRpQr3NP4rzPKAmJx9ZNIIbuXklgTW3P5YE2GmAY/1LpNufI9618x05T2o97?=
 =?us-ascii?Q?Bhb7TCnmkzm7D3kgXKx1wnM3Dbh8pasiqfbfsXHqZu9aPmoNoIFQN99aEhJ+?=
 =?us-ascii?Q?35JU+YNbHhEfw5tx3ImJareOSozoGPvCXG/O0p9KQVBJbypCTMt+PQw8ggTk?=
 =?us-ascii?Q?Nr5oC27Fv/bSHp23OrvrGUEBS8uaqAberufYWYLu/6v1mCb2C3143FRjNSHQ?=
 =?us-ascii?Q?HOrQkQp9XuVKHWqBbuw91U9RYWhwOO9jeuA0L7WyhL4aZTlqHS815iWl0ATv?=
 =?us-ascii?Q?coE5lzUaMaTwTWhC4n14tbRSSOKgFlNWTmu1+0cplPztYRasUlNaTpsW3g1M?=
 =?us-ascii?Q?sXsMI/LwIHcQY1+jkz311tn15Q/zlPvn7PKwZYhqyfjgaXfQ0bDQ/TS5b83b?=
 =?us-ascii?Q?E7nVhMD6Asay09nbulW0L+my134S8zwnEkV1XWUB6AAeIBVbnLWu5B63VF81?=
 =?us-ascii?Q?yAwSIzNFLFqzqwhDRgZgLuj3vMH2ny/CqjGyPPr3fqOudZJYrR4QMTZYP0J0?=
 =?us-ascii?Q?ZSJdT2+F9nF1kHvUw8u4Nw4BOg45U4eABWAobaNwJcueWPN+EQgNuyrjHFa4?=
 =?us-ascii?Q?pIoasFZd6529FQTtEcqwMyWj4JvlUZD2SwDADo/Qv0ofVTHr8n5q82jo61oV?=
 =?us-ascii?Q?p10ac82naMxL9C3Txd9M4SHVhVW0vnr1jmujaxyTu5xJSdaVZCdjxzXXqX1o?=
 =?us-ascii?Q?skIRSVWGp4TdH7xyD3/9bEhbdSwVvTgeSnXM44rMn0TDsg56zH29zPw1sZ8I?=
 =?us-ascii?Q?uc1O/NHQn82iZflto01S4LNRM09kIhHvbT7xghw2ps/D+7vR8iTKn3KjtpNo?=
 =?us-ascii?Q?efZ5aenSAYycmUDqEBEfTNXA8wpVCq5jNrpOUtsSx+850/mIp5TFfNY2/l44?=
 =?us-ascii?Q?P4N3gPPPqa7TJsaR3Z0GaZUeZham+HuHK/dt0DyN36W7OOMf7mPY5j3FQIwC?=
 =?us-ascii?Q?9TxCBGdUYE++37j+NfaDco9u9ikW2hqf2Qt3D8Yc+FgJ7xqRDWU2iUq6hZ29?=
 =?us-ascii?Q?yGcngThXwM1kPy5XjKYhLJNcQ350jUH71RJS9OqYe7tgdfRuAj3QQJKnV0V0?=
 =?us-ascii?Q?MRSePZ6tlOAzFjWpnnE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6905.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87735e22-85ec-46e4-d513-08dd566ddc74
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 14:00:00.6157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIs3AusYTyM5IIn+t5UdpliDjlxX4Q/4DIQusZo0gyeuPfrrk/pC+Ad7UMAn7YPNZiI70DIBKowhim6S3Eu06A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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

Hi



> -----Original Message-----
> From: Suanming Mou <suanmingm@nvidia.com>
> Sent: Wednesday, February 26, 2025 9:43 PM
> To: Bing Zhao <bingz@nvidia.com>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>; Ori Ka=
m
> <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: RE: [PATCH 3/3] net/mlx5: allow FDB RSS
>=20
>=20
>=20
> > -----Original Message-----
> > From: Bing Zhao <bingz@nvidia.com>
> > Sent: Wednesday, February 26, 2025 6:50 PM
> > To: Suanming Mou <suanmingm@nvidia.com>; Dariusz Sosnowski
> > <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>; Ori
> > Kam <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> > Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> > Subject: RE: [PATCH 3/3] net/mlx5: allow FDB RSS
> >
> >
> >
> > > -----Original Message-----
> > > From: Suanming Mou <suanmingm@nvidia.com>
> > > Sent: Tuesday, February 25, 2025 8:45 AM
> > > To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> > > <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> > > <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> > > Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> > > Subject: [PATCH 3/3] net/mlx5: allow FDB RSS
> > >
> > > RSS can be used in FDB Rx rules when JUMP_FDB_RX action to allow
> > > jump from FDB Tx to FDB Rx table.
> > >
> > > Different with NIC RSS, FDB RSS will not do the internal implicit
> > > metadata copy.
> > >
> > > This commit enables the FDB RSS if JUMP_FDB_RX is supported.
> > >
> > > Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
> > > ---
> > >  drivers/net/mlx5/mlx5_flow.c    |  4 ++--
> > >  drivers/net/mlx5/mlx5_flow_dv.c | 32
> > > +++++++++++++++++--------------- drivers/net/mlx5/mlx5_flow_hw.c |
> > > 19 ++++++++++++++-----
> > >  3 files changed, 33 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/net/mlx5/mlx5_flow.c
> > > b/drivers/net/mlx5/mlx5_flow.c index 3fbe89a9d4..9c6a4f39fb 100644
> > > --- a/drivers/net/mlx5/mlx5_flow.c
> > > +++ b/drivers/net/mlx5/mlx5_flow.c
> > > @@ -1977,9 +1977,9 @@ mlx5_flow_validate_action_mark(struct
> > > rte_eth_dev *dev,
> > >  					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, NULL,
> > >  					  "mark action not supported for "
> > >  					  "egress");
> > > -	if (attr->transfer && mlx5_hws_active(dev))
> > > +	if (attr->transfer && !mlx5_hws_active(dev))
> > >  		return rte_flow_error_set(error, ENOTSUP,
> > > -					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, NULL,
> > > +					  RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER, NULL,
> > >  					  "non-template mark action not supported
> for
> > transfer");
> > >  	return 0;
> > >  }
> > > diff --git a/drivers/net/mlx5/mlx5_flow_dv.c
> > > b/drivers/net/mlx5/mlx5_flow_dv.c index 633c41e358..61d3101ce8
> > 100644
> > > --- a/drivers/net/mlx5/mlx5_flow_dv.c
> > > +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> > > @@ -8939,21 +8939,23 @@ flow_dv_validate(struct rte_eth_dev *dev,
> > > const struct rte_flow_attr *attr,
> > >  						  RTE_FLOW_ERROR_TYPE_ACTION,
> > >  						  NULL,
> > >  						  "unsupported action MARK");
> > > -		if (action_flags & MLX5_FLOW_ACTION_QUEUE)
> > > -			return rte_flow_error_set(error, ENOTSUP,
> > > -						  RTE_FLOW_ERROR_TYPE_ACTION,
> > > -						  NULL,
> > > -						  "unsupported action QUEUE");
> > > -		if (action_flags & MLX5_FLOW_ACTION_RSS)
> > > -			return rte_flow_error_set(error, ENOTSUP,
> > > -						  RTE_FLOW_ERROR_TYPE_ACTION,
> > > -						  NULL,
> > > -						  "unsupported action RSS");
> > > -		if (!(action_flags & MLX5_FLOW_FATE_ESWITCH_ACTIONS))
> > > -			return rte_flow_error_set(error, EINVAL,
> > > -						  RTE_FLOW_ERROR_TYPE_ACTION,
> > > -						  actions,
> > > -						  "no fate action is found");
> > > +		if (!priv->jump_fdb_rx_en) {
> > > +			if (action_flags & MLX5_FLOW_ACTION_QUEUE)
> > > +				return rte_flow_error_set(error, ENOTSUP,
> > > +							  RTE_FLOW_ERROR_TYPE_ACTION,
> > > +							  NULL,
> > > +							  "unsupported action QUEUE");
> > > +			if (action_flags & MLX5_FLOW_ACTION_RSS)
> > > +				return rte_flow_error_set(error, ENOTSUP,
> > > +							  RTE_FLOW_ERROR_TYPE_ACTION,
> > > +							  NULL,
> > > +							  "unsupported action RSS");
> > > +			if (!(action_flags & MLX5_FLOW_FATE_ESWITCH_ACTIONS))
> > > +				return rte_flow_error_set(error, EINVAL,
> > > +							  RTE_FLOW_ERROR_TYPE_ACTION,
> > > +							  actions,
> > > +							  "no fate action is found");
> > > +		}
> > >  	} else {
> > >  		if (!(action_flags & MLX5_FLOW_FATE_ACTIONS) && attr->ingress)
> > >  			return rte_flow_error_set(error, EINVAL, diff --git
> > > a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
> > > index 83f55ed3e8..a063e5ac9c 100644
> > > --- a/drivers/net/mlx5/mlx5_flow_hw.c
> > > +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> > > @@ -7026,6 +7026,7 @@ mlx5_hw_validate_action_queue(struct
> > rte_eth_dev
> > > *dev,
> > >  			      uint64_t action_flags,
> > >  			      struct rte_flow_error *error)  {
> > > +	struct mlx5_priv *priv =3D dev->data->dev_private;
> > >  	const struct rte_flow_action_queue *queue_mask =3D template_mask-
> > > >conf;
> > >  	const struct rte_flow_attr attr =3D {
> > >  		.ingress =3D template_attr->ingress, @@ -7034,7 +7035,7 @@
> > > mlx5_hw_validate_action_queue(struct
> > rte_eth_dev
> > > *dev,
> > >  	};
> > >  	bool masked =3D queue_mask !=3D NULL && queue_mask->index;
> > >
> > > -	if (template_attr->egress || template_attr->transfer)
> > > +	if (template_attr->egress || (template_attr->transfer &&
> > > +!priv->jump_fdb_rx_en))
> > >  		return rte_flow_error_set(error, EINVAL,
> > >  					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
> > >  					  "QUEUE action supported for ingress
> only"); @@
> > -7053,9
> > > +7054,10 @@ mlx5_hw_validate_action_rss(struct
> > > rte_eth_dev *dev,
> > >  			      __rte_unused uint64_t action_flags,
> > >  			      struct rte_flow_error *error)  {
> > > +	struct mlx5_priv *priv =3D dev->data->dev_private;
> > >  	const struct rte_flow_action_rss *mask =3D template_mask->conf;
> > >
> > > -	if (template_attr->egress || template_attr->transfer)
> > > +	if (template_attr->egress || (template_attr->transfer &&
> > > +!priv->jump_fdb_rx_en))
> > >  		return rte_flow_error_set(error, EINVAL,
> > >  					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
> > >  					  "RSS action supported for ingress only");
> @@
> > -8104,6 +8106,7
> > > @@ __flow_hw_actions_template_create(struct rte_eth_dev *dev,
> > >  	}
> > >  	if (priv->sh->config.dv_xmeta_en =3D=3D
> > MLX5_XMETA_MODE_META32_HWS &&
> > >  	    priv->sh->config.dv_esw_en &&
> > > +	    !attr->transfer &&
> > >  	    (action_flags & (MLX5_FLOW_ACTION_QUEUE |
> > > MLX5_FLOW_ACTION_RSS))) {
> > >  		/* Insert META copy */
> > >  		mf_actions[expand_mf_num] =3D rx_meta_copy_action; @@
> > -12112,23
> > > +12115,29 @@ __flow_hw_configure(struct rte_eth_dev *dev,
> > >  	/* Add global actions. */
> > >  	for (i =3D 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
> > >  		uint32_t act_flags =3D 0;
> > > +		uint32_t tag_flags =3D mlx5_hw_act_flag[i][0];
> > >
> > >  		act_flags =3D mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_RX] |
> > >  			    mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_TX];
> > >  		if (is_proxy) {
> > > -			if (unified_fdb)
> > > +			if (unified_fdb) {
> > >  				act_flags |=3D
> > >
> > > 	(mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX] |
> > >
> > > mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_TX] |
> > >
> > > mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_UNIFIED]);
> > > -			else
> > > +				if (i =3D=3D MLX5_HW_ACTION_FLAG_NONE_ROOT)
> > > +					tag_flags |=3D
> > > mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX];
> > > +			} else {
> > >  				act_flags |=3D
> > > mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
> > > +				if (i =3D=3D MLX5_HW_ACTION_FLAG_NONE_ROOT)
> > > +					tag_flags |=3D
> > > mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
> > > +			}
> > >  		}
> >
> > One small question about the TAG action flags in this case. If unified
> > FDB is supported, should only FDB_RX sub-domain of all FDB sub-domains
> > support the TAG? Or FDB_UNI also supports it. And if no unified FDB,
> > will the TAG also be supported in the legacy FDB domain? Can we add
> > some code comments here and update the limitation?
> Yes, it is allowed only in unified FDB Rx domain. Let's do this.
>=20
> >
> > >  		priv->hw_drop[i] =3D mlx5dr_action_create_dest_drop(priv-
> > > >dr_ctx, act_flags);
> > >  		if (!priv->hw_drop[i])
> > >  			goto err;
> > >  		priv->hw_tag[i] =3D mlx5dr_action_create_tag
> > > -			(priv->dr_ctx, mlx5_hw_act_flag[i][0]);
> > > +			(priv->dr_ctx, tag_flags);
> > >  		if (!priv->hw_tag[i])
> > >  			goto err;
> > >  	}
> > > --
> > > 2.34.1

This should be with V2 version prefix.
Series Acked-by: Bing Zhao <bingz@nvidia.com>

