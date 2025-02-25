Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3B6C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 12:11:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED59042E54;
	Tue, 25 Feb 2025 13:11:03 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by mails.dpdk.org (Postfix) with ESMTP id BE81A42E3A
 for <dev@dpdk.org>; Tue, 25 Feb 2025 13:11:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toVBQ2oYCDAig7+2U4ObayNO1BaU6eS/vGnvs7USHn1NgV4G+qASTSq4jhnCvdLd8vl2B7spFDf5osvQMgqsTSMgYfizS4PMaPOcfsGHU+wkwOQW7u348D3BDSh7ABXIb1QVxFQMK8F4JcNnXp+djlTXyU7Hm3jMjRES/aizBpDZLA4VZ19MQ+Xnyc7W8C2QR2csdzicuUCQ7KcqoqC53CTtDPN3xIWH0pFeNOUNnNUEOsA2M9qQngIpX8iOEw/24XqHdta7TVsGAkCBcntGHpJ6QOOCvN+Qjvi0EShVPOggDYpmun5a+wlAYDJldNXUcVxq2kkxBOKYokMl+AgJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2xhCGNB5Sz1W+0TWFOaFtJCw2uVB5PHkicH6qBgDtk=;
 b=Jeu3VQ/dYl5HO7ZNBmAJSxrFfDP8a3aoJUQLSMnUa1alLiAycgH7ghj7CIjJ7vUnWWEb2O2i4WwIJYPF4+4RV7X9ZKGB2ZSkqfvxYdLnomEgNLPUe3uAmvySxqcS7x2SJXr+FzOacisTEuBtU+nU/46J458uyPmJOR6l7I36z5QFk490driDpdoFRxLxbj16kro5lZVBGDSG14txt2kq1jGEQr3JqBNPe7artQTsi6UY4qDM1Vhs9JNoMYJl+Nwm9IuJI/lb7TX9SZlodApIi/5V7T4aCzC1LGV6BHw+cj6svsuCH6BG0CTpzMem+WZYnMA5UzZmezheECMd0hgtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2xhCGNB5Sz1W+0TWFOaFtJCw2uVB5PHkicH6qBgDtk=;
 b=dppInsymIhYnOg12D24e0qoEHClUlGnpIm+MCSjl87z1jtI1mTWKluWOwhPftA11rIOEomcDQDLZCJCW6SEMjAxhVwQTv/LdikJMsFBCOGQ+YycKUn/sIH2Gslb9jnuuPxW0HVAM8NPEOyK0sCt5NMzEwa26SCU8d0IAo4xTKmYyx1WSHqbw/2nZ6Hw+pjoIlqf6Pf3hfkK/v/AVCCJ6bJlcMzQMCuD3QRCzWc2CHBvEMJb+kEBUy0Gsdk9JlnBU6CNJ3WsiT3Earrn/LRxjqiWPlp8ZYgNrRvPHggWRogF4sDqYNKYZzSfnBzeQ7JxSXhfnCLUlAGHWD13aPJNzWw==
Received: from DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 12:11:00 +0000
Received: from DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a]) by DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 12:11:00 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ophir Munk <ophirmu@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH V1 2/4] net/mlx5: support FDB unified domain
Thread-Topic: [PATCH V1 2/4] net/mlx5: support FDB unified domain
Thread-Index: AQHbh31PsZY0wykkP0e/dvRRjeSSMbNX7Z/A
Date: Tue, 25 Feb 2025 12:11:00 +0000
Message-ID: <DM4PR12MB845219F7A6B5ADC7E5831DBDA4C32@DM4PR12MB8452.namprd12.prod.outlook.com>
References: <20250225120213.2968616-1-ophirmu@nvidia.com>
 <20250225120213.2968616-2-ophirmu@nvidia.com>
In-Reply-To: <20250225120213.2968616-2-ophirmu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8452:EE_|DM6PR12MB4236:EE_
x-ms-office365-filtering-correlation-id: f8842d4e-fa17-4283-7557-08dd559577a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mj+xcMvHtLA4ImMVW3reNrXnWvBiOpaQDOCqBHGMrJRkgtQPCbv5rbkf80XE?=
 =?us-ascii?Q?nOCyV76C13cWc9H+u6/i8GVC0BpD/SU/NJyG9M//p8GsdAmsjQKGqvLDIUfH?=
 =?us-ascii?Q?UC5bbHC+/7bgn7klZNXxJlPjms470YgIpJsoQth1ufav3pkYCYGHXvfpgDMB?=
 =?us-ascii?Q?6RT71j4cbc5bzzA1yDQ3Xi1uxbd61M5zdbrvqpsJRmaNRZMjTjQ9wuXaovLs?=
 =?us-ascii?Q?v/sJYJS8odirJidY0lJ97k2g1WwRH5LV9Vc6CNkR9INRcfWBnri1+5pex66h?=
 =?us-ascii?Q?3Q0XfHTWAey/CspUrhBfLGN14yadC/8nE6zVu8L9wJzpxQOQwzdCIL7en3QJ?=
 =?us-ascii?Q?OmNpLBFZtoYHDs2o//h3ga8L/UpfQSL5qznSJ2JmPFpxiV2iDYciSKPquUXc?=
 =?us-ascii?Q?cGgQvAAK6RBxI14d5d48NwCeSrfUZLG8CJni51MhpLYe3rMc8Zf65KLSMpTD?=
 =?us-ascii?Q?6tOUeStmnBnnFoETZ5F4w6ccgKtD0VCmmTjwbtCiBmed3O96iZp8lzxx+D0o?=
 =?us-ascii?Q?4ZD2EediIdQ7VA+f6xngL7Ug8UUVTi1aUTkFtv43HGD1I8ohAgtqPTp9lZkj?=
 =?us-ascii?Q?2/PoNoYGE3KDkYhawTmSlkyKnPtmbJJLUS7X85y10+VQTbALJM3ltWgEvyKq?=
 =?us-ascii?Q?/oYF7fJ3ChS05fvw5VGsANUDx5auRR8/8yFSaFfs7aAjkoNK4wlF8qjDMuL3?=
 =?us-ascii?Q?ANkCaItDpDeWYMwc10jrRC32awCiTfNWPhMPFYKwjCWFFXogYKp/Ucjm8LHY?=
 =?us-ascii?Q?PIzaRIhVbAPBrxATMGLAk0mwESGMImcd65ABIqP2dzuQYSzQVcktecd6ISDG?=
 =?us-ascii?Q?dPQiTLuXys5ACJTvkuA0Ubd5gD/Hg6fjYJoR1UrnPGXNvJdS5AvWORGExaWR?=
 =?us-ascii?Q?VR70/+KWxtMOG5xLqjrmUO/Fil5IZpLZ7zx620B8LmCbPWpCu9spSLhpgCZZ?=
 =?us-ascii?Q?JGjx7dQvlVRML1ShP3aE/1JsKLQFE7RblzR4bFV2raIrjH0NJAEwM6hCZeA6?=
 =?us-ascii?Q?UoCluuW0aBdSu8z9wqVXW21iqsf0f3B5joeyQX7I7cjansqs99hUImZvSTqq?=
 =?us-ascii?Q?1kv6k56ZhNXyAHrjxSDhbKgH3tnE9E4h0EpGc5SO3cXnb592D33+EjTMNFt6?=
 =?us-ascii?Q?FyHn790fTNAnHDL/1fjFiWX4OrJJU+0DRA6sjDALIfwzXbSDwVw1FUruNDgl?=
 =?us-ascii?Q?O25r8xnYJPnXHjX0qG96RaP7WDDp0TFMei8XhXSWx8jBsMycZG/Hn8YhuHrg?=
 =?us-ascii?Q?AyPf/od1xO/mE+uBZeffXD/8ydHctzolKJnxaE56T2EFI3NHWHxABrWYs+yt?=
 =?us-ascii?Q?pnFqKC5X0SSEGHPCfdiwn8K3atYzhl8PDY5d++J63FAy0eemiR09uTJz5QaW?=
 =?us-ascii?Q?xxslyB4nKYt4+HT/1nGcVSK0tjTlhbFF4dREanUnhatw9jIvguAv7RATJt1a?=
 =?us-ascii?Q?Q/ha+G0NVKlSLq5DXXyK5bsHRGS2gJLA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OilMQcIOZW6LJBNhiHn52CCUD8u9a4691mXmtyhkZtFSFVngRQgtXAqF8FKs?=
 =?us-ascii?Q?x/5C39yb6039p9upIidGaYvLsuiVzQ18Dch72ufB+AdAXigoT7Y3W18O/O0R?=
 =?us-ascii?Q?oBQHuPRnN66hU7746uywLhpa0JLHOoMmvMjF23Q3gHfGqKMd+np07nAt2knf?=
 =?us-ascii?Q?8RsZfOwLCCDdOSPMToCIUeqKMYGYdBL/50HtpiEM+Rh32YVFnJvXUAreQIDK?=
 =?us-ascii?Q?Np0qLi2ZEbcSgLtWheVZ96Z1OnFCo/DaI8yCaJOjrgKNe4407YeDyz8hMMNP?=
 =?us-ascii?Q?apJtFvG1I/Ibg0S9i/fDcl5rzONjZCS3pmvYOVab3FDBB+XtPySw2v4iyWrb?=
 =?us-ascii?Q?GaVdO8u3r6yP6yd8MlPm58t6VObQA9rqFHma7hlVv+UstQpsfPl9uZU2xip6?=
 =?us-ascii?Q?Vk4f1yXmkE8y+AM3xMMB2NcUi+Zf8mCsmxj5fPOmWXxU3yQH+rwMrGcOc1Eo?=
 =?us-ascii?Q?d54u9Wriu3meV1GfRhE4xXSp+hmk2q1PMySaBY7Icm0GJPTZC/vYzv0+7qqP?=
 =?us-ascii?Q?25MVeuWpP0fzmvnsiCzTWGjzA4mjGgygC2vs5YH8ENw0RL+7HkJV7tynLTFR?=
 =?us-ascii?Q?kPwofnBOZGh31e+xHEgP5uIsPtlYw4kytC4RPr1sEh5p6/pwi2Xwg+opMIyb?=
 =?us-ascii?Q?+AstbLNwE5ioqAqmkFv/st5baIyPQTqtmkbNylpG99DW/oxsmpGT/T7cAC56?=
 =?us-ascii?Q?EAEN+B/eRmygj1Qdojs902Go+HYjWQzEKAQQ+6k4dJmjjZfGmiRdfBBYtuMm?=
 =?us-ascii?Q?a4MgMHVsRQRYSxyD8bv2BLVpapMFO03LoHGTcv8/yZeDEqCHl18Eii8fSTCv?=
 =?us-ascii?Q?97biY1pJJD9Is7IW0TrLPV13A7jZ33eLK0pZ2UuaHNl1GigwadFOBigt3IMz?=
 =?us-ascii?Q?ifPJfizN2UB8+iuZkOGVZEuGdgFwKJy0BU8tKWgjFwNjSXhgip9lCuMAkMv5?=
 =?us-ascii?Q?Yn0jNuULhB1+mqii3dZV7yQZh/S8YDP38ExVUa8E3MQmCZM5hAOueXDOkgML?=
 =?us-ascii?Q?KwyAn2odktv2GFjvdEJ+wTY5myNquLrqFbss9Z1ddZ/VVFZ1xcfp5npjMhZi?=
 =?us-ascii?Q?GCDgyedGhsCwxdjO8NN8LRQvgY8ew4Vdf/6IH9rhGzuhMT0VpRzdHw/U8bmH?=
 =?us-ascii?Q?y1WS/VH/lbH8hv7rzfY2/JfqBG7Mc0L8IawkTILKJOzRsNN4gvJjU0On1m5N?=
 =?us-ascii?Q?FZmXXf/9zQV6eTXF4vCuqHyUGuvwlyrwZsHsXDyS46uK1mt+KJt/CTcOLN7i?=
 =?us-ascii?Q?zeuH4vOeoshva07soKppk8X39LVn99T0TPHiwMPsxVGewwKABEv1JHJqaB/O?=
 =?us-ascii?Q?zpGfPlR9NCBDBs1r5/1EQh+aMf8Md9CAAEaVBqne71PHUW2WXftTe2KhArl0?=
 =?us-ascii?Q?+PJw7TrRM0ZImulbpr57wu2XezPg5YibfdwZrr5hlAZKKTHiXhYpsS7FetZU?=
 =?us-ascii?Q?4xtvTjXo7ebyY+y5p06fxQYgwAXdqT+QXlAVrnNdha5Fg6IwoMNAZfClczsA?=
 =?us-ascii?Q?H6oIxnsvdaXvP990gcs4jqRZzs8Krh6GZ07gpzyDSDzNiC5iC/oWo1jIFgSW?=
 =?us-ascii?Q?HsWiGuaS/ngsE3HZvu73pgyFTL8uYs19VHVjdjsL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8842d4e-fa17-4283-7557-08dd559577a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 12:11:00.1824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kuEZoyKiTsJfhGtbKw8j5SQ1Per76fQQrKgIJ9IgNl/ovLeQyfJYRCLE2FjUR9rLpRDhMEjQWmT+U6BArXh74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
> From: Ophir Munk <ophirmu@nvidia.com>
> Sent: Tuesday, February 25, 2025 13:02
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH V1 2/4] net/mlx5: support FDB unified domain
>=20
> Legacy FDB domain is enhanced with optional three sub-domains: FDB_RX
> FDB_TX and FDB_UNIFIED. Based on FW capability bit mlx5 will work in eith=
er
> legacy or unified mode. To work in fdb unified mode the flow attribute tr=
ansfer
> bit must be set and the fdb sub domains are determined by the table speci=
alize
> flags SPECIALIZE_TRANSFER_WIRE_ORIG and
> SPECIALIZE_TRANSFER_VPORT_ORIG.
>=20
> +------------+-------------+--------------+
> | WIRE_ORIG  | VPORT_ORIG  | FDB domain   |
> +------------+-------------+--------------+
> | 0          | 0           | FDB_UNIFIED  |
> | 0          | 1           | FDB_TX       |
> | 1          | 0           | FDB_RX       |
> +------------+-------------+--------------+
>=20
> There can be no two groups which only differ in their fdb sub domain.
> A table must be created in a group which has the same fdb sub domain.
>=20
> Signed-off-by: Ophir Munk <ophirmu@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
