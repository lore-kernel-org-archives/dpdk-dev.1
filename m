Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46D3EEC2AD
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 23:25:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E2D1402C1;
	Tue, 24 Feb 2026 00:25:16 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11021118.outbound.protection.outlook.com [40.107.208.118])
 by mails.dpdk.org (Postfix) with ESMTP id AECE3400D5;
 Tue, 24 Feb 2026 00:25:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBQfZy9g2imbWem38m5vONnN/z42lmYEME89pxg/gyHnpU9Uvk2ptBja2nz82QGVwmDXfebSlvglj98sB0EEsk3Y3pZZFbuaQVn/LAq1YZU133mB7KHyerHXiMzOSGLJ/ozn7BDAYJOGOo8szM7C9gcT6WEzUr9KZXqzHwGb5G0V78ibW7koRcIzFRsrcvOKnBSvaXygYWNEEXZCMRLTuM9jpfNQPX9NDRV0z8p+dx7LGCdIbfhzb+Cb/j8gX0zZJ+j/03liOS0bdg4dS17Kof55cWplnxf7kzWynDiyBkuA5j3RfuAdV42RqYTfZyhoUoTh/bUACjhYoKditdFuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUVTjXTRoqzQ6cjVZFRBRWQujOuWp0pB5O2OZzKt/Dc=;
 b=NC/09BJrbyA++VBSz+Xb7YarRFL+cqNMqTJglP3Ww4AtrzQ3EdNVH/NR86jKM0l0l3kkAHyUWoqkwiSjNpKaz/LR94YdhfH9gUi4O7jjUM5eLUY8siHeXmpF11jsy75WMPEnNJFxuDZveC9E6yOFVw9SX4H1/ir0KEN3g2xge3dKzI0rznLny/78bLQ0i8dQUan28MXfLzkzEBEYTYoPRMyqFfgl8tA0lprAME6xRORmhyh7DfJ7YAvAa1XJgZ02UwwS538loJ+ME9sHFS9HG7jXHAglTxoKWF4pSGwqtcxYKdlOSo70GmPbB6LTP391otg/9pU0C4Jz+ASb6mi1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUVTjXTRoqzQ6cjVZFRBRWQujOuWp0pB5O2OZzKt/Dc=;
 b=WTHgALu9VCz23g6vs7UJqFRvp2F6T7piRndc602YpHu8aXquoZ9mvLRj+gWr8/5gzBnjkDrcXv0EIP365o/C/KNPHiXZnML8zsIm3DJDQrNbx+nZ9Ab6QUxuA3SIDzw5Pt9cQ3en2zg3S55ZN1SwmFsGGXt98jSEdEqG/IcoCKk=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS2PR21MB5180.namprd21.prod.outlook.com (2603:10b6:8:271::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.0; Mon, 23 Feb
 2026 23:25:11 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9654.007; Mon, 23 Feb 2026
 23:25:10 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 "longli@linux.microsoft.com" <longli@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/8] net/netvsc: secondary ignore
 promiscuous enable/disable
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/8] net/netvsc: secondary ignore
 promiscuous enable/disable
Thread-Index: AQHcotwujEJuzeh2DECb1xiHGNZ4J7WMnK0AgARUvdA=
Date: Mon, 23 Feb 2026 23:25:09 +0000
Message-ID: <DS3PR21MB5735CA3E7E84C5F12AFA9855CE77A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260221024540.659098-1-longli@linux.microsoft.com>
 <20260220211614.44f6b3df@phoenix.local>
In-Reply-To: <20260220211614.44f6b3df@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0404cf6c-174f-47b4-b3d8-853c6b1842d6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-23T23:24:33Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS2PR21MB5180:EE_
x-ms-office365-filtering-correlation-id: 2b0e4aa9-71e7-4b08-ef96-08de7332c99d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?ac4K5V44PwtvPZRD8Iwe/ChMhn0aKtj/FQpY/+FZ2ZUSikx7uGaRfuH/LqvD?=
 =?us-ascii?Q?78dRQyRHJwVFWbWciYQvlVoRyr35OBLZW+qWKqFyZRd7tWM65Tbbfs19x8uS?=
 =?us-ascii?Q?ieZ1CW/lbHGHVBucU/WpTkp6cVTvnI2eeXDDjBjTno9njU1XX8VU1PiVnHDZ?=
 =?us-ascii?Q?nxmzNfI0Y4f0B+Q3nuERZWo6IGt8/1wiAGrmbiRsi52wvbFbc30ggrHk5uxb?=
 =?us-ascii?Q?Wpg1qRoQpYAVeI6o8B9n/f27jfSDrhlh3G8um60vXpkViLpJyK2+J+G3HTtt?=
 =?us-ascii?Q?RVRR6+/ZKQP6QjcYWwdVD79qOZnOOJZPngzepdY0MJXVtC/JiGGDj9QH+l89?=
 =?us-ascii?Q?Gv6VWEbYkXM6+MHLDNTzPN8IhOFvGUMpH4+1eiobYDPpeaLABXUmqH7gpvUF?=
 =?us-ascii?Q?echJKrihh7U2F+itM3GQLhSUHT2l3JF6p8lL+vrWh4Ma8bp4yxntvxEmaa3X?=
 =?us-ascii?Q?uMNtudm4YCaB2S0/8EjMtOs+1CxrDqId4fjMaRhZ+mpYPLoG3TZqRK3sK/7+?=
 =?us-ascii?Q?ef/6RIXSYqXvXfF6yNcsn00n5GAal9X7I6j7N3ZT9u29BtMI+DxkPpCFmA/x?=
 =?us-ascii?Q?VQDqBsUDDuMqWWR3VBremacx1ahuaLgfC//nN/XzMKyI/Usj0D4bQg16iLM8?=
 =?us-ascii?Q?ig/3bt2NYpeZff7wmsqygklPNfWrrk0xQ7TH6HafpajHDaHoAnWs3gFvpI3Q?=
 =?us-ascii?Q?YjZQa1RYxBN7wbF+TGhUDtlNzKeRSVtgg2znLrf3Qyo8V9cMUoKcLY4ZKvYg?=
 =?us-ascii?Q?l66N5uGqq8hBN2kk+tOGDdOORDhqEQ23BXYKH65AGYbyuxK4NFG4an2HUtQb?=
 =?us-ascii?Q?l7Qai7WJ3uv1LtKgGUQC7sVkMZJQUDO7WdK/dQTEYkpq45LKblqta1wJphh6?=
 =?us-ascii?Q?ZyO6vySDq5NPMTkGGIv558o1ZsVOE+Lp/Kk6W6SB1PqJoGy6Akla1MrhWEDO?=
 =?us-ascii?Q?855MYmupHpjzurtN10dau0yptJoNm8XSmagbI8qCQI3tJ/rdrf13DtT5WZVM?=
 =?us-ascii?Q?m/fwyBJJQrNNMwZzKwjLtXjW/+gDdxHztwsVNtazRPsWAQkr/It/wt/YRIT0?=
 =?us-ascii?Q?Q0rI30XeXipC4jBwFon/UIISJAHr5RMqf18CQpm7aIncX6YnX/qW/xxCFdKV?=
 =?us-ascii?Q?150PrktWV161kloVB7b+6UqGgKX70wz0BXzHM96k7YICRO0jz7n3F94MLuUS?=
 =?us-ascii?Q?6HZYj4iGpDXwcXH6BITeURrXGJKL+HIFG5yuCmF5JR4Vxg9eYeCb+Nd7TfBc?=
 =?us-ascii?Q?HZLBHPJZoYm7WDq/8Ja0YSK0N91m2Vurs5+SeWBUT/oyV5JFCKZ3OCQ6D6jU?=
 =?us-ascii?Q?SknW3cTUuAK7oDohv3sOaNwuj/rzGOs1L9w4u05OPX21++0/W7KGSLeJ2J6H?=
 =?us-ascii?Q?3ln9duF1lFuGdQkKyTJYCf4iZnxxbz38SXBhYOFaoU0XdW+ltDbZ1M3h/p4g?=
 =?us-ascii?Q?hY1haKIpzjLy0ciDIG3OLWiYbjPmhZqwnwAhKnDKciVzJeRXGSnDGL5nxamS?=
 =?us-ascii?Q?uUj8dimGHj9Fe0IuD/YVp7xjPsL7fcT3pkHmVMYNqkvt7OL0y2uTgjyiSqXN?=
 =?us-ascii?Q?vdGd0NO2eY/x9ocBP7jNoU/Mc/IgCadLLnEfDr6kxT7Y9pJN52f8ibWmwm/6?=
 =?us-ascii?Q?dEZUTW/hMf5hNiajpZNfcdQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U4cUX2UQjGv1w63k0Ev48DSyJUUzZn7Tj9vHrXwliyyR5urcb+UGAN7cczV2?=
 =?us-ascii?Q?5HAc8VpNH3fsgcPEaKPA4vuSrfgcPoWHzHmLVKiCkuzq0Nawi2kjsKP51Jca?=
 =?us-ascii?Q?+1DIEO00fYsc3BEfH7CtpCvAJlYDYGmTd5uZ8t/V3FVTYbTdn1tGJgCBqNgA?=
 =?us-ascii?Q?RPOfvGpwT4NGPwzdmziMMn1zqN87i5BqvcCWEkdy3mXXX0bb5DsfZgsjz/wJ?=
 =?us-ascii?Q?UNWIL817q7HgQMdd1PaQjzKu9LImldmm+y9pzZYRJW5VIfU4K7griBqbNQ6V?=
 =?us-ascii?Q?kRbnXowvwOyjRWppCVoiAfPCHpBCeW4V6Yv9aLxRUSY3dN6aThdSUrKHh1n7?=
 =?us-ascii?Q?M6i5pwoWQUxQXPAfxDe0tzYyizz1byFDJmkVhG6YjcFB//eqaNg6ho6cZb7b?=
 =?us-ascii?Q?+fqJLMwG1SMC0udco3KmQrTt8N5xNnCN1VHx066e6cXNbBI6xl1XbIDvzu3b?=
 =?us-ascii?Q?HzcoiyeQo6t+GQAgxLCSHRgWyybNh7LiQahN2GJaa0K7f6IzNFtxu2xqQzZm?=
 =?us-ascii?Q?JnxGX4/XTAOnJBq13TgIdm8NcNyEOg/nEx+m309aZVAo243fiA3ZfaPowliT?=
 =?us-ascii?Q?JgrBKSRgA/qE7JtuscgSgNxHTn3EnGJKp+kK9CusVpD46KLqCAVPnc+YCO47?=
 =?us-ascii?Q?rb39MKqbZCXCxxkFoQej4LpIAPn3Dg/OXOH5hEvSeEer0eh8emHxBLcMWii3?=
 =?us-ascii?Q?3NYaCMo1dipRNaVVXNNwLanwtm2Hy0enGtOkrC83HA+k+AYMn/ao6hFeacBd?=
 =?us-ascii?Q?PaPx6wnX08POQgbCKz79cXjbrNaOiQID6uuZYvilOUKPiHwtGdf/s3/qqaZw?=
 =?us-ascii?Q?NX9pzw2DYH/2osnb+TAujI1dNSRm4xgndmPD9R+hWm1TGr3pKavgrK7FsOWr?=
 =?us-ascii?Q?2uht9/JE4ZD8f6SzjWPO38IZh7n1Rp6Lwf8bTyV+gzANNf9NQYRIBmsYs/XD?=
 =?us-ascii?Q?O/fEcTDix0tOxOFFMsl1FKBFUoj4sCHJTlHrcUkMXznYfvmRgbbvZImSQ5j1?=
 =?us-ascii?Q?OSYNJ+NDcuX6jXb0nVckOlKgNMQW5+XRHuxmlpuGS0+0SfADCf9F1tp8yj7a?=
 =?us-ascii?Q?o6tIsRziUSmUCrrdgUKoAFyuYZE3zxUdvwGuJXs45gWniL7nCWLqKZqeNCSz?=
 =?us-ascii?Q?+QHz0WqBxE1sqPTiavc1hZIreNXt3u6/ZiK9hK+6Wd3cscl0Kk30VnYgS1sR?=
 =?us-ascii?Q?Sf8pv9b/DhJviY9N6D74gWKXm/OE2KCJQvC42xykyBf88PZf7BgBFyQjsTIk?=
 =?us-ascii?Q?kES95gHXgv2aIU4sCpKUYwSvzrcBQEINlYrarKu8CR3k7zFwEghpsA0bdoeJ?=
 =?us-ascii?Q?k8v/e5tC/8ZMS+JCqF9MW933Wm6YdoySmpC+QrLbW3Til5HFbdtn2Lj7jKuT?=
 =?us-ascii?Q?bFYedj08V8xvvDc993eAMAnQkgBmbDIvUSIwotzVEgfdZqf5YirMCO0lQnic?=
 =?us-ascii?Q?aGsAj44WjiPLWrQC6L59n9NaBipI6inVePqFV7tQqy0RTwfSG7jfWT4IMaNY?=
 =?us-ascii?Q?aKfdW2fuqT/PlcWE2oyXk3ro4ARdt03Nb0f1BwUxfFkh3TmdGC2HqBq86yqN?=
 =?us-ascii?Q?CRG1quDbeDUCIi3YZfVbignQdx0j6zRTxMhBNLQ3FXZBuaO7hbLoFCneQykl?=
 =?us-ascii?Q?ikhnIvnZhstbPzeWS8/Ogj9DPb+duMB2SV7jc63BaWGs98AOKoiNJ+3bruBo?=
 =?us-ascii?Q?tzz7/fEMQhn+IWMr+0fgAQywG2HRusnGqd0coA2RgZbscxSf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0e4aa9-71e7-4b08-ef96-08de7332c99d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 23:25:10.0857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oep5PXPY0ahd1rfgn5wf3/hEmMv50UYsePWSdKf/PPOnoZW/3jjul2v0AHbTEC9aDH9zfpT6+PtNiRuFEbzndA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5180
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

> Subject: [EXTERNAL] Re: [PATCH v2 1/8] net/netvsc: secondary ignore
> promiscuous enable/disable
>=20
> On Fri, 20 Feb 2026 18:45:20 -0800
> longli@linux.microsoft.com wrote:
>=20
> > diff --git a/drivers/net/netvsc/hn_ethdev.c
> > b/drivers/net/netvsc/hn_ethdev.c index 6584819f4f..5d7b410f1b 100644
> > --- a/drivers/net/netvsc/hn_ethdev.c
> > +++ b/drivers/net/netvsc/hn_ethdev.c
> > @@ -480,6 +480,9 @@ hn_dev_promiscuous_enable(struct rte_eth_dev *dev)
> > {
> >  	struct hn_data *hv =3D dev->data->dev_private;
> >
> > +	if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY)
> > +		return 0;
>=20
> You might want to return -ENOTSUP rather than silently allowing secondary=
 to
> think it worked.

I'm dropping this patch from the series, as it is for another unrelated iss=
ue.
