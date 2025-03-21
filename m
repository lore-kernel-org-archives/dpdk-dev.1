Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD2CC28B30
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 00:10:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB55140151;
	Fri, 21 Mar 2025 01:10:12 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11020117.outbound.protection.outlook.com [52.101.61.117])
 by mails.dpdk.org (Postfix) with ESMTP id 75A9C400D6;
 Fri, 21 Mar 2025 01:10:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I96m4ixOvXxKdlz72m10E3Khi1l5HX1e+OdSaDqn6wpR+l9BpRCNxKYV3IGL+Duz4VNgpaB3cW4iP4IuUuH7oq7dE1NlOguzchGkLPMv8QhzVKeVJOsJBdDmqPjdo9jN8WldK7a/gn7YGVFxGSnhxfidcPS8NLhUIquD+GOLn3JZlRvYI2qza3zARrWIpBiTkKBlJLRR8oV/xCGwV94N0Aowm1Vl4wp/TOQ0PYXobxTMBOPC8BwkgsG5xUpU6JpaEnLGm/FxGIftBrJ59tT7LWdhP9KnH0KfbuXlYfISkBq5SyrBYafxuviC6J/EQ0sG6HfKMWrR/dii96JVlxEqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzybrr5Bg/e8R9h80BDKj00dTvdlwMWtC11Mqghgsxc=;
 b=xu1xZQuxQNzKN1eHoAvPI/fs9t5PFd/RyACEjBFUpVhZV3U21ifhod+VNizcCZsKETMJRjB2HadDx+DlGqXMpS7kfSSvY1E6EurLHRG8gEy2lYc+CYaed6MxLI+IYkQ+OzFp6yIuvDtab8Cakw/257XzR9gQy19rGwC/m/9p2nbHjlkmaE2pGlZSgxAWZu9I211l0fZM6DM6LDcMJj02vOuTI9cRZXufWYD2QgnLYdUncAr9J7oocqpPvgfS4nSRwOnIPS43rH9eBgfojYXZXkSu2NYC/UojVieylSPdmA46ERxfvj52UtklEq2+8fVoFU5VEitaHwJvsMdbZkjVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzybrr5Bg/e8R9h80BDKj00dTvdlwMWtC11Mqghgsxc=;
 b=JJbbY54r5ivMOVT/7IeZtDCQv90JWWsy/ikpJ0tfWPp+CEAXQrjfE3I1GSuFi1Pb/D799iTBINfsHnlxoo7YF8nExFjyn5uuR3Lrjnorah1VZsQwufU/PUXOrG0Yso8dj335Pyq8zAz4aOjsqCofio6A5WkZLC8hVPKg9hT/HvA=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA3PR21MB3912.namprd21.prod.outlook.com (2603:10b6:806:2fe::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8558.26; Fri, 21 Mar
 2025 00:10:09 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::ebfa:8e51:9b6f:f94a]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::ebfa:8e51:9b6f:f94a%6]) with mapi id 15.20.8558.024; Fri, 21 Mar 2025
 00:10:09 +0000
From: Long Li <longli@microsoft.com>
To: Wei Hu <weh@microsoft.com>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>, Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] net/netvsc: add stats counters from VF
Thread-Topic: [EXTERNAL] [PATCH] net/netvsc: add stats counters from VF
Thread-Index: AQHbgkn2LvmISjpuHUeN7DhAp037F7NOJc+AgBngSfCAFOA3kA==
Date: Fri, 21 Mar 2025 00:10:09 +0000
Message-ID: <SA6PR21MB4231FB2AB26BE70704C6CCA8CEDB2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1739913199-8988-1-git-send-email-longli@linuxonhyperv.com>
 <OSQP153MB13079AEE64F785EE8EB9F75CBBC52@OSQP153MB1307.APCP153.PROD.OUTLOOK.COM>
 <SA6PR21MB4231D4FF5AA7380EF4581D79CED52@SA6PR21MB4231.namprd21.prod.outlook.com>
In-Reply-To: <SA6PR21MB4231D4FF5AA7380EF4581D79CED52@SA6PR21MB4231.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4d371c9d-53b4-42aa-bcab-4bcb3c4f69ce;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-19T06:10:54Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA3PR21MB3912:EE_
x-ms-office365-filtering-correlation-id: 93345cb1-4be3-4b4a-622a-08dd680cbdf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1Wko9TdMiXrg2/AIIuyeSyKt7F4PRfSqFtnBBWCao7KM+ZYO8dwtKqG/3RZ6?=
 =?us-ascii?Q?MThrAYQtIb12eI6gvBesKMaPrWxsZQwayAqCSqHGSFy1qAage+JWOrYQUlor?=
 =?us-ascii?Q?OKi+0uwM+7kZDps0HrjYJja8hzdyKhgRieGrgWeKmcNZiR815ios71h2DhyM?=
 =?us-ascii?Q?B1qUtkBBZGfTo4+bnTI7yVYQmcODsDqf0hKRPFv+hzFu6LJozUU2uJTTNqkZ?=
 =?us-ascii?Q?Por4jc/Zdh0EhnXEEVmNH8YsIHxvqG+AQgm1TCpnkr2BwxrDeYa/haDiwB0B?=
 =?us-ascii?Q?WppzCnxOWWeJHtO5AX1s7FWo1pX+HMKGCAYmHKfswAX1ImsEQEHh30IdZBYk?=
 =?us-ascii?Q?T2TWJarUblMbZ1XBkVcyhxhvuKHXLzxHS3IyLQECG4+m2Ma7ZAcdap3M20dv?=
 =?us-ascii?Q?66Szn7sLdAELDDNqkbWyTWigko2LtVGtT6Sblwzs5OFDpYD0CNU3G5iPpLVd?=
 =?us-ascii?Q?C9GAUYmDywf1sOZnIzqLaNPUpR02eqsb8b52pLDSmU3mbk4isCYfj53Py4sy?=
 =?us-ascii?Q?dPwzLbAiL4//elmawjM8Es8aEIvxuGBpv6lCi59ihWBXetDcatnyP2WIAS8Z?=
 =?us-ascii?Q?9Vv8GM3aG5hzBbPbZBruz3oD8a/YXC2dHJQ/kgBxkRuayhyE+wrcARxs3LUn?=
 =?us-ascii?Q?Lvew86CYP8Sm+eno5EszAhTCEpnPRc2XUT/MYL9CDQDcfKy10vNJqAh7CHXU?=
 =?us-ascii?Q?mWxQgf9gCKhNkIp9leaRXGzt5gtbcVyR7ipmlO/gUdrFsW6FXFiN94fJyOjz?=
 =?us-ascii?Q?f01DeHDIhmGVM4uytRcXCUJZk+VvJUhEmxJWKnkamMmT6ig5vzK3l65yGbbV?=
 =?us-ascii?Q?gtDQHXOayFcxq/IF4ueml6Qi/BYuGxy47O+TH9ZrATQgNMICbBuNvzVvgEQO?=
 =?us-ascii?Q?SVrCLmUFqnluMQ7cQu0dYiedqJ0uWKziPAJ80eEtFJDsOakTv+UqyV7fHqY1?=
 =?us-ascii?Q?+8wic2bGbV1rn8vSgqlwjp1COkowTjW7sySaeM86w3oKqnBW2f8zH4XFgOlk?=
 =?us-ascii?Q?Gc6cu/33IlVOe4HjCUiiX7SzFzORof+NouiJ3wtLEdL12xOzEAwBJddPgAcR?=
 =?us-ascii?Q?ozjkDX3TPr8O2GjCa+VYzov5NH3hufLuSdHUvEu7cFyyewJt+oAI8ErvpaAV?=
 =?us-ascii?Q?UWjcr0yrftUxTvu+5cfXdu09veNnSpMTbeL5bHXn+Ik+o3qVNi0toDyEvbPJ?=
 =?us-ascii?Q?ZemArHAF2Jm5/qbNSeQwXT1F6oJ5+ekwwC6SRrfkU0j6S2OF5xeHJHboz9rj?=
 =?us-ascii?Q?47gvHgppUMzA76iXJZnbEgifjuFytl/suAbR7maw/foXC6OuQXxXbi7MqIUh?=
 =?us-ascii?Q?/0154rxfxhyUZCrkg4Rp2u/4XfZsapaupeyEcPeFrBopgU2Plp+o3OSqoxwZ?=
 =?us-ascii?Q?uXQQnAwLQ27lH4hQ9hN10ljO7V59nwgPoKMa/O30SNJ60s45q3ZQWSqdEKg4?=
 =?us-ascii?Q?I0m26HcVTfUXOMz9nlm+sNTR2AO9FDNfG1zF1PUwrzJL8v96QsgXp/7xU5RG?=
 =?us-ascii?Q?K5/is8SIbxexd90=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7GBjs3l69QRp4m1NFT3l5rvij+WbBLYPUHG0B9iBEw+lQzaavfgnH4mdKKcI?=
 =?us-ascii?Q?UO5LZrHyBiYF/Cb6lu2iveSDn2TEfFIr40KUxBwO+my//xmjW7fW7Qao8WRL?=
 =?us-ascii?Q?ijaFT5FRDH7Rtyr1x9I2k+CwFij8DwpY+P/27R5ijA3Lhw1VVMAsSfmrdBD4?=
 =?us-ascii?Q?8VIvGw22GLj6wQzcuFXHLjSdU8bK/ekR++4vKaG9T+4+b8fhandvDr3pvZWM?=
 =?us-ascii?Q?p4W73epUSD6img08yENa/vq/xvvVgbvDrC+UiB2a/igZluXGZjL992XtfcqB?=
 =?us-ascii?Q?GvXgg7qXbDHq2rIHPp7x8mBYckMOeVD6UyDy+34LK+netX7IFCK17v69AGNP?=
 =?us-ascii?Q?Y4qYoiNGbylXo6NAL4XB1NuLVCF6TWi9r0fbzOjGre5NGHkNEzZq1vSqxwVx?=
 =?us-ascii?Q?VxbvcWYkGdUP0bQbgGjrHusTJIxl/XDn7yBsf8NbHMUoSocclvm2k3Df3TkH?=
 =?us-ascii?Q?dp4VMME5Sg+ukZot/bsG0itKOkEtaHQAlZZ70NQ9QBFzRa//JVvxDEMgviHJ?=
 =?us-ascii?Q?efvcatOcuCbNLMi4yY1g5xiJJ/GgfjmSHdx/8Tcn9wWEj1DagjgRDrxQHDSe?=
 =?us-ascii?Q?Fo+CumJA989YOi8KZbY3LYt/OmVWOwTSSshofne/wtQaPJs6Ec67dh9R3IWw?=
 =?us-ascii?Q?BzFWJdeI66ZjtPOtoOhX+8Ylgzie9xln6C21+X7oPDntwenDCz0EbiHKL3jy?=
 =?us-ascii?Q?n6lccft+MHQ92ibnEMypMZYcSjq3Tp+0AvIEyFc0lr/+fviNLwe78disxv9j?=
 =?us-ascii?Q?k5IhvuLcYcYNxZPV/JARHIXafXC6IN2sJuhB1G9Vdg2UwHH/aNIw6GJBLLUG?=
 =?us-ascii?Q?TALXEEgRVkSjEgyiasYhfZ6dYnRP2z+NzOamJBZmhEiQ/8zdICZCrduGNA7Z?=
 =?us-ascii?Q?vP1F1PsaEYjZlveDwQ9hlppZM1mLl/pCSVgxlsDhc479Fv+gkUD9hI9kcjgJ?=
 =?us-ascii?Q?mjGdTNWyGdiqDNoj5zDMojxQcCy1KWgopIu0TvKk99y+9AV+ebAyMKvOl50i?=
 =?us-ascii?Q?ko5YdVE/MgaRY0PxIb/OHXG9BPRI+esTQ4l8tQvYOZa+kpNnD06MLzRUQfW4?=
 =?us-ascii?Q?9VUCfo6zdU05JOVnBnEE3vc/geYrIdYT/soWvob8f/Q0ohiCs8SlsUSQfbKR?=
 =?us-ascii?Q?xkREjEZvBaD/22B6OwnaTPa/9esoIZA/YxsH0QwHIuvyXm5anxpRLVvdbUax?=
 =?us-ascii?Q?iESoi7HKQxNrGkKbGAMbW9B50TctXwYyp/0sI5cUH1gY73pJjpn6cJVNMVq2?=
 =?us-ascii?Q?MF9UPwfId1XFikknV00qD/2/a3cHNnmXRSjO+OArDcSAnC2U1OwjjnTkmGwy?=
 =?us-ascii?Q?dS8VFz3dk89skCYA+JcdBkzV686yWR0PQYlIFksuu/lpPOE21CaGPF843yid?=
 =?us-ascii?Q?/vQ0QoXlQFW4d+OzciWLB36hdMXECgondvmjVtfzHNFDAF9mt0/7fHZmzwzw?=
 =?us-ascii?Q?FD93DFm/FVNUwScorDdDkf1GB26J7Y5fkvnqGHG4tgO23Iq7i7BeRRuhUX4n?=
 =?us-ascii?Q?FYdlYR2DuHPoUrG9+VEFX3iZ4x1dKY6NSNY/i2ld1PqQSoRsJc0FfdDFTM4n?=
 =?us-ascii?Q?IjTporRGd83B6OxBIoLKlOyKhjPRx9E3Q32ntEYQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93345cb1-4be3-4b4a-622a-08dd680cbdf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 00:10:09.1569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxkyJRbs0LGjhLfxsrwAbN/sVbyIUhpQTdGyxxzMB9HmVKImqNAhhV1geh7mq2879vz72c81VEYE71TN+qWDyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3912
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

> > > Subject: [EXTERNAL] [PATCH] net/netvsc: add stats counters from VF
> > >
> > > From: Long Li <longli@microsoft.com>
> > >
> > > The netvsc driver should add per-queue and rx_nombuf counters from VF=
.
> > >
> > > Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
> > > Cc: stable@dpdk.org
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > ---
> > >  drivers/net/netvsc/hn_ethdev.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/netvsc/hn_ethdev.c
> > > b/drivers/net/netvsc/hn_ethdev.c index 988c51928d..069d603d90 100644
> > > --- a/drivers/net/netvsc/hn_ethdev.c
> > > +++ b/drivers/net/netvsc/hn_ethdev.c
> > > @@ -824,8 +824,8 @@ static int hn_dev_stats_get(struct rte_eth_dev *d=
ev,
> > >  		stats->oerrors +=3D txq->stats.errors;
> > >
> > >  		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> > > -			stats->q_opackets[i] =3D txq->stats.packets;
> > > -			stats->q_obytes[i] =3D txq->stats.bytes;
> > > +			stats->q_opackets[i] +=3D txq->stats.packets;
> > > +			stats->q_obytes[i] +=3D txq->stats.bytes;
> > >  		}
> > >  	}
> > >
> > > @@ -841,12 +841,12 @@ static int hn_dev_stats_get(struct rte_eth_dev
> > > *dev,
> > >  		stats->imissed +=3D rxq->stats.ring_full;
> > >
> > >  		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> > > -			stats->q_ipackets[i] =3D rxq->stats.packets;
> > > -			stats->q_ibytes[i] =3D rxq->stats.bytes;
> > > +			stats->q_ipackets[i] +=3D rxq->stats.packets;
> > > +			stats->q_ibytes[i] +=3D rxq->stats.bytes;
> > >  		}
> > >  	}
> > >
> > > -	stats->rx_nombuf =3D dev->data->rx_mbuf_alloc_failed;
> > > +	stats->rx_nombuf +=3D dev->data->rx_mbuf_alloc_failed;
> > >  	return 0;
> > >  }
> > >
> > > --
> > > 2.34.1
> >
> > Reviewed-by: Wei Hu <weh@linux.microsoft.com>
>=20
> Hi Stephen,
>=20
> Is it okay to merge this patch?
>=20
> Thanks,
> Long

Hi Stephen,

Ping again.

Let me know if you want me to rebase (but it seems it should be a straight =
apply) and send v2.

Thanks,

Long
