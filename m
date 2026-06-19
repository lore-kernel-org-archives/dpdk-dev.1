Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C97CD98F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:04:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FBA44028D;
	Sat, 20 Jun 2026 00:04:16 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11022126.outbound.protection.outlook.com [52.101.43.126])
 by mails.dpdk.org (Postfix) with ESMTP id D561A4028A;
 Sat, 20 Jun 2026 00:04:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyFm/hf1hR73adXmVzVEyN2SQYEAWPTYuJbuwPylVqB3r4y30FLY9j0y9LvTkW7YGTjWBsHZLI634EKZpa4hmXMxG/E5V4TTE0r+qr9Tl6UUyRIXat8CkE23HBtS/50P1d9iZgPITM3at9goITL81J4nhu0yDVS4/99b8BSyazjiZ7zMDtiWy+ZBGy/4Rroy9MgKrojMVmtQPpsICQRpn/PQh5lXIMlsZk1XsB09lCASWx1XdiPo5rFDNA8p9lGOv6gbI/ce6BBSwy264cpRUd1Ml2NixmLM17IcrH/JjT6485hJRRtoDavd43Sx6DyncX9dW0+7eXAwCgSunnWIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTnpSqMQhxX5E9s6CStsFLZU8gIXsN7L1fT0JEfBFFw=;
 b=p3HpSBO+T6VB2yOfffSimJLbLtPgVgelTqt3/JkcyjnKrHsXaTGhZR8bhKDekv56k0aVTC0EcK1l1LdIKsBLppZZ9hc80BqlXjN+YiKtIX5r5wSfDZfLOWgTTkAjEt+FKnR+r3m+HQAbHo+ovHtJRYaIbH53WwzQG0241bVZB+gKC8Ofq20wdgRon49Gt9X9bIXjBpOLGghvxLJUDHRR2Rti3saISftHAHBS/iTQ00gSXu8EYfJmiF0CGJf8D4WI9QUxg0krarhGsnxsf38dfyUEYPBY+QP7QaYykZhSXPK80E95DYb5b63sm67+g3LhLDfXH5c/Ti/TnagQKprYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTnpSqMQhxX5E9s6CStsFLZU8gIXsN7L1fT0JEfBFFw=;
 b=XA7epwVm2bCCcqDO4L/tgVInA807ZYx3AqWgKYLWDXksYCxOqN5/Lwl3IOZs2lLrrRHk+AQp5+cYV8DVqhhtIeK3IWb2mytWr02vr20LCCQrq/3Rbc9LFErpo4ON7/TW4YIMs9NtmRZbiW642toumyo5O9tp4JvtYL32rlCLSKA=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6584.namprd21.prod.outlook.com (2603:10b6:806:4a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.9; Fri, 19 Jun
 2026 22:04:11 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0159.007; Fri, 19 Jun 2026
 22:04:11 +0000
From: Long Li <longli@microsoft.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>, 
 "stable@dpdk.org" <stable@dpdk.org>, Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v2 05/10] bus/vmbus: fix interrupt leak in
 cleanup
Thread-Topic: [EXTERNAL] [PATCH v2 05/10] bus/vmbus: fix interrupt leak in
 cleanup
Thread-Index: AQHc/zc05RyVgnkZpUWblvpJOkgOwrZGcJXw
Date: Fri, 19 Jun 2026 22:04:10 +0000
Message-ID: <SA1PR21MB668398E287F75969DDD60FF6CEE22@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
 <20260618152826.490569-6-david.marchand@redhat.com>
In-Reply-To: <20260618152826.490569-6-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1be1113a-5201-47ec-8d92-63805eb871a9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-19T22:03:49Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6584:EE_
x-ms-office365-filtering-correlation-id: e4d51fb2-74ca-457b-3115-08dece4eb14d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|4143699003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 3IPjolDrfgzdjkE76ctNrP9Omz4ohKBB5t3YfGLko+N56uqoBPt8MCDBMbKj0Ra6hJinUG/QXhcJVWxYjMSF/xfHiWWd4/r4NkPgFhZuw35coovt/YV1p6IrJjeM+DItSyNhq2Y7DabALwqpXRn4QSgeKkqJoDwpfd/WIpK8BzLasVkudGj8bZ9WazKP0Zgad1Pr7A17qj8hoBSnvYvK+urxQSwGvoynuHSu/bHXOqcwwGDC3rt9GibaNxdjvJuYuSZ+ZtasAMmf+RWjzqxvmx1O+6NjKO3iLdygeRl+HopTQ+xvrBV/kLBIZF9tbwRFm49nSN4qWwdQ3LNoq36K+ltcw+E7LdaDJKzRndgFAteSMPPmTvJIsxxJc+c4yQXkNRaxbrVYUddjBV1+6Uqom8uNrHSBUaJzJWPuTZIs5pK9nZcaqCDgbZzaANVPrWL5kbTWMz/IVLS90J1U5dsavQD+6zowPbbHyM4qnCkVxyDzTe+VOlUXuKgx9nlADSPNbzo63F1BsM8dGjTLKGXOn0RjAEAPfJqwJrU/Mnqd9t/JMC8k7fQLNDDPe0FfmDmsADerR9d7gDdjg7wQnolFnbE5Gm2U8laXgPx0Tr6DGnLaSEfYtNH4Mh4gjdSIth3caTs9hpJy0QMExXk+VQPItzs3sV9lUuDBKIdrFHOc0YWywwjpk/01qS5SAu5/4J6R5HvUI8RLmUeg4aj4JCD2LMLdEvijSpKypxhfHQj5zek=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zMprKxcbFUNlppcGgNSia/lTrjNE1Cvmok+0dE+u03jsDGkl5O95i11xT3MJ?=
 =?us-ascii?Q?KtXmDVWI0si3yiSsCzfbfPc0+dKzIf4LcKeyDRM5FigEvMJp9wR+cGWGyFy/?=
 =?us-ascii?Q?Brto3P5f4tjvnVnMramSIoI3xGc7to/m+JAg8ppUJoM4jpP0BLBJTTwcnbz2?=
 =?us-ascii?Q?o24C7opz6NjCkQUux+eSM6dsO6yQ+66a+t9ozL+w/XoRc6GcAQf7loQoyUh9?=
 =?us-ascii?Q?CefHfNlcN/+ILfCEpZXLzYjSjWjWD+cfYdoWvrTiOoobFtLXogzxyQ8KSFCd?=
 =?us-ascii?Q?8VRhZMPSc+XyUeQ9kaixG/OdwxwW1hpAogjeXcFDMt5lA3fxF9nCO+ZWLPj6?=
 =?us-ascii?Q?UjrCtajwkSVhZUoU2xvqeyiEF2L7HvqjFae43GD+Bj/Tv8kanwvv6K7ScfVn?=
 =?us-ascii?Q?C3d8JHw3+FEftybXtgJ8dqkhF+FnTuDuEnz/MM0CtmATHcna0I2OEKek0eJK?=
 =?us-ascii?Q?VJBtOahpU/Nvn74Od6h+sv9ldw9ScRnpogFTVCg62X+5SoauWOO+RvUY44Y4?=
 =?us-ascii?Q?/Fh76/UY5DTP8XKePl5dDfk9YG/yeFaKc7sTqPPDnDe10nNi0T+NABn+++gj?=
 =?us-ascii?Q?9IREjE9FX06sXMHnHLugdaVVSXzDwX8N4o3mBW2WkeULbzVe6ZvQRMDurRtJ?=
 =?us-ascii?Q?sdqkl6wKyIWcAmugA15TjviG5udGWNK8wf17MkuLBj6EzIDm1F+iM8K48ZRd?=
 =?us-ascii?Q?xVnVypAuhgyTrs0x9IqhyCOuqPwpEurWLXvvRBsAb5Wro5NWSxEnZW7a68+t?=
 =?us-ascii?Q?0SSAaavAQZLJpTp/Knw/TPIlnKFY1jl+3iC1DgKGNrvo76kaWgTM+q6NLxtW?=
 =?us-ascii?Q?amGtAmf760yN3q15pabiAygtSOiI0IWC0qsOs6r8jvtkh4OFgwe2KhxX0wBu?=
 =?us-ascii?Q?EIwz6Hjv3JPKDamfmMVDs69ZYUzXdHh/cNp+WMhYW+7piON121kWJxGqAK7v?=
 =?us-ascii?Q?Q5aLoJH2GNY7swLs1Iq9HKr9psXOEK5DDAQTQtHpWYaOQO5mfvjAUoUDkYYB?=
 =?us-ascii?Q?+e0Jo8go1oDhx3xJrefAFkP/8IqzmaqQAlq0pgrCeC/8/xsV9zn+NqHsbfiH?=
 =?us-ascii?Q?Luv5+Ia5ohZ5XdSOFAeSMpnZCrrtIPoJD9nsYMncTNB9MPNEY1770onliMOW?=
 =?us-ascii?Q?y0sEPpoGhOLyJ+F+ZKh5NeRIojXCm0/nxacFgDVlMJaEKdiDXFQtYR0p8TnP?=
 =?us-ascii?Q?tjKC7PDTF9MijZK0lZTsuSpRO6uZzVHRMjB/V3Y9omSH5/GF56RgSiUciJl9?=
 =?us-ascii?Q?tqxURI2Q7lDgW3EFGWyKlt87sExzjGbgP50ebie8prFQfiHQWq0xjqdul3xK?=
 =?us-ascii?Q?b9TujVnHA7pJWnqXuRxUg4UiJ2C3/pZmxhwDjWI/2RhHyCiKwiw+TDmLUGVQ?=
 =?us-ascii?Q?7A4yPwgdbASVsTdtTsrGrffB/A88NDcftp+9RWZHDVnCrRoT1gPB6Y77fpP8?=
 =?us-ascii?Q?l4ZZdhmrOeke+rcHzZ4uD2obdAIYq8dZ82YOb0d1xgha7EPY+gjBRIvQUJzg?=
 =?us-ascii?Q?4s0vYj+vVcyIFP47qH+WHjuhcEell7GIVSLX19pIbeH7NxsxWsTJFQkhxV+r?=
 =?us-ascii?Q?DleATCw92Pq/g8Fd5uhZTpj9qiEfA5g/mcsenTDlHDlRUwLxEzFuqIBiMMDv?=
 =?us-ascii?Q?DUKwffWJocDIigQPHp4+/CIjKNlHnxcjqUDVZ8bK9hWMnI2xqxHnCavLHueZ?=
 =?us-ascii?Q?H/t7FOpI/3CFx+bNGwP98v02Hx9Aal42dOLhFtMrK6CyvJXt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d51fb2-74ca-457b-3115-08dece4eb14d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 22:04:11.0234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hV8JY7XFGjZpCehzN66Uv4/VcbUPlTvRkD/UE+VSW1xO2/A0mcY+Yfb6guOtksYQkyeOO0NyHYnHZtjnf6uGrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6584
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

> When calling this bus cleanup, interrupt handle was not released.
>=20
> Fixes: 65780eada9d9 ("bus/vmbus: support cleanup")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/bus/vmbus/vmbus_common.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/bus/vmbus/vmbus_common.c
> b/drivers/bus/vmbus/vmbus_common.c
> index 01573927ce..74c1ddff69 100644
> --- a/drivers/bus/vmbus/vmbus_common.c
> +++ b/drivers/bus/vmbus/vmbus_common.c
> @@ -150,6 +150,7 @@ rte_vmbus_cleanup(void)
>  			error =3D -1;
>=20
>  		rte_vmbus_unmap_device(dev);
> +		rte_intr_instance_free(dev->intr_handle);
>=20
>  		dev->device.driver =3D NULL;
>  		rte_bus_remove_device(&rte_vmbus_bus, &dev->device);
> --
> 2.53.0

