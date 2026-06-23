Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9501CDB470
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 21:30:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB950402A2;
	Tue, 23 Jun 2026 23:30:26 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11020094.outbound.protection.outlook.com [52.101.85.94])
 by mails.dpdk.org (Postfix) with ESMTP id 5163B40293
 for <dev@dpdk.org>; Tue, 23 Jun 2026 23:30:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnArWrA7No/DXISHXd9f7HMb7UocLttHyTdRpWKppgdhTU2L5uLJZO5yz+oFxRgNla3kvokctdoiOG4gPnfT7DE2/y+/0+JbRwYzJVOyyWwUE0S5wx98q6vBh9YMmTd5MX7ccmdDUZMyFwHaLnaGowIZCE1EVF8P2kS41Y0f4ipr7N2oy13i/ItanH/O+KFdhhKyP7NaN+jVKuoGBdV1pAQMGprtw7JskryeBTlWwWOrXGatMPsZLoEmHGAL+POzYUym2ZONKihTU0jHN93x9MhEU9iaDqrm1WGeMaf6CCjN/mu9gpKhG46O3nYsm4k6wlOrlRf8E4jJr34ESIBv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGyIjvWBoTkcSH13SHHKHm8XcZKTjP41R4Oae6jS5oQ=;
 b=pzLrwA9zusJoF5ZCXRzf9ewziCuhOtonnNu9THN5YLWGalipL8x5Dw0LpcDQfOd+mL/vl1eyiTQQWq8Sx4Zny42RtZB1fe1cjrsOT6yfyQyHUy3fZ2OgS867E1BAm7wHIxzOZ1t1/Hd/xkmJGx/5dB2WgxQdvkB20Y3NXOphJHFxzTJfx59inRqkCRzpDvZ4O3lNAFS8OfACYk1W4mzRkKelkIDfHGqUqG9MXRNHa/uLNbVZxFghEA56YiiI8RFMQ3I7jDfIA9KDm/0DKSEGv018v7pmfzOCl9rHIfj3wBDqq9QLHL5UA/JnFTrKG/mIymUf96fv/XtSz48+fydhug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGyIjvWBoTkcSH13SHHKHm8XcZKTjP41R4Oae6jS5oQ=;
 b=Gl7+9ZJGpBcVzfoIn5V0eBgK8Eu9rveNxlmClrtGjp8s7U7VfauFVARo3lH/GywZT7dCF1xlaPKqtYTukC45KVZ/pLQ7pGVjrHc0sirIaqIB/ERMJd11jIALo4p5OPnqAAVacyC0AysZREG9yK3q3Ls3comQFx5o/X4EXtCkOa4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS2PR21MB5444.namprd21.prod.outlook.com (2603:10b6:8:2bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.3; Tue, 23 Jun
 2026 21:30:21 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 21:30:21 +0000
From: Long Li <longli@microsoft.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>, 
 Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v3 10/11] bus/vmbus: store name in bus specific
 device
Thread-Topic: [EXTERNAL] [PATCH v3 10/11] bus/vmbus: store name in bus
 specific device
Thread-Index: AQHdAv7bVZVpgC5d1Ua9z73+F4MaiLZMi+Gg
Date: Tue, 23 Jun 2026 21:30:21 +0000
Message-ID: <SA1PR21MB6683F6BDA4C7269377CB2C1BCEEE2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
 <20260623105439.2144694-11-david.marchand@redhat.com>
In-Reply-To: <20260623105439.2144694-11-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7f5ea6e8-bf32-4c01-b680-dea1905d9c81;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-23T19:46:07Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS2PR21MB5444:EE_
x-ms-office365-filtering-correlation-id: 59174ef6-cf52-4389-454c-08ded16ea16c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|18002099003|11063799006|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: Fi5E2zDjPbaBylsIETm+wKKlxlihnZ5EUzIpx4XRI7yvhn9i5jkV+jp6H8TBeJLEHposFmZCLLbHIfKPdpewTjmHvzEmyEkaoTWYOpZZybrSwX3NW2Q82QZ97qgP8iu9wN6IkOFC4/hIKmT2vdDhVwF0FR1Xl/OfP+EeDcoiLSrC2c7alLlELI5clTp+6eDk+XI4s331qSi4i7TPyHcHL+21yxa8EZGb4bgTz+VqfCA+HsXgofq3GBw6CL3eXp0xegw0AEd5yrRQKyjay1rKMxRU6ZcdSKwnRi0MEn4seKBp3zpi1P0AlAjNP6CvXoW2aCnLbk/DRv2gg0QyRPuDhqb5j9z34nmuZnIeC0ebufmlT6SpHW4ApZqcl3/45Tc/DFOB+PIrNjBZhr/juQCwQIt4wdYOOcVHWJRQQli62akUpXmT8IK5f04YBUZTjFRoXOX9tOV3J6BoCKYAuUTpmgOzGuK12Rp4Aw0Q6o5HKTu1K3F6AeXDtVZ/rcIIcOuaVyfvItK2SoXVg8OVh2QY3utyfjMCkLeKSdCuP8D+B4aLfqVkE34Ji5II31ggqA294Tms75uutNbHOAlGQc1UM7y/Ai+y8G2auxoUvrraEM/ftVqVp4WbOotRkqYVwoBiJX6gTm1z0zXrIIuxvR2rSqsu2quGBvD0aKN2Frvo0rzan/uWXAe1Jy4atmkA4ffJCGPbdwEDJkY5V6wwDOP+LX9+P5u8KFcx4tXOvrMok9w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(18002099003)(11063799006)(22082099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CUHwh3GfB5mKXnzOr1NZTsVrg7qNQ71KXDyN3GzWodR5Pb0jcdAx/qCNDzoc?=
 =?us-ascii?Q?Enhwmbebt9jLPxk7kdG48sCiFfAFmLRQ/Mb4wWFYq09K7QmxxkxzIkevB65s?=
 =?us-ascii?Q?mo6mbaE2dzjgBIB2nzWvEU9hEId+QMy7tkd0TWVFirQT7kkM+sjb/lIoEQVI?=
 =?us-ascii?Q?JvxZORqyRXtHgNATlIDmgpwNkQ7kydwbmNi+5S27GeMMEJYLkUtzeK60xssw?=
 =?us-ascii?Q?NFkyr5LBOL7LgX3XIYS9qSPZtxvZ3yCTOZUnDVGl9+nUjgTowJS7eezQdpoB?=
 =?us-ascii?Q?TT1npmrpc2Ba26iv7Ja8RDcrXzL1dXO3eDnWE7tsPoXUD90h0AX7vJFFx9Q2?=
 =?us-ascii?Q?VTWB3KEGHbi4AhaL1f/WvxCnRf1MXAuXH8+4q3lBow4oiwgJ4XHCurXZfP5e?=
 =?us-ascii?Q?Fin1mJrA7V71a1KibgvEdm1g6Sy7UBl3n4NSyGqm+8qRLxDjAewahbhL14GF?=
 =?us-ascii?Q?IIbORjmf7dCcYRM6CEA5BEs/aHazNYlLmFkYvX8O10wKqpGeFyErGQMsTLHN?=
 =?us-ascii?Q?8WBxPr/HDY77qHLOpQCjjXVHYVqYvIk6w1PEpDt94zb4NgTpcZtvxdS9ulil?=
 =?us-ascii?Q?o5fvnPtfEWAkZxqP38Of3+WtnHgLeLen2BMAuo9gqbRoQ/qXUdJts0Vjaa5F?=
 =?us-ascii?Q?Z89iCTLc3XO7sMu2VbC6LMWzn2rWWc+8blPb5CXIQ3Sn118LjgDhM4+bByxH?=
 =?us-ascii?Q?j+9OSubOQkE8icSXaPiS9yhHNN7EqKGfCBxyIB4C8H9WEX8rTpBBRa0bGgNC?=
 =?us-ascii?Q?yvjJgzOI9HOrDt/kE7bHYZM5BnLw1PI3+L48fAYM0z9Zzu8kEoEJhmAd+elK?=
 =?us-ascii?Q?eNo99Jb0mc+CTwv6khISEhDYX5I45ey5YXrBeBPYcu/l3hfsCXxElOeoc5Ux?=
 =?us-ascii?Q?1apbTOepESRy94U5xLl9fO/iuav1WxQMrbLNmt1r3E90NtEbHFW7JkJ9mUO1?=
 =?us-ascii?Q?0+ZZ11EyKjM7AhGf9LLp/NRLQYhgdgK8//WSwihDiYUKHhBucVqDzf5b0VYs?=
 =?us-ascii?Q?xw4nhpWFF6xQOYwvUt3+yVix/P6XiJqv3FTziKdPCaGcX1Bzh0sjjZP22J04?=
 =?us-ascii?Q?38I1IH490tJxYW8Sx58BdLH/tdHcj8DDw0OvnPCYT7BMzmfwYd06UwrpFjuY?=
 =?us-ascii?Q?PGNqBgyM7ZQbpncCswey+UzS84xggzen9rxTspFQ+9Km2VKBzV4AvgHgLmiR?=
 =?us-ascii?Q?gH9pGVyPZxhSmCqF+GGS7tdCz8enrAaiEQpp4XEPWgi8uQDm/TP90F+hMcth?=
 =?us-ascii?Q?uUIpasUsUG1q98nJXPiIcxDXuaaOPq6VvagtiXzNhPWcATw6gLFYHsJnoMcW?=
 =?us-ascii?Q?DgOerfLQB49wx3a89rL/icGzRKJtEwulVL456N2wWU/kVs6JbwtaqhNxS1FW?=
 =?us-ascii?Q?nuzjdn62Bk2pdxZpl0DACuD7OJAvkcWpdFr2/kiaxyJ4TsexX0Q20SOr//fm?=
 =?us-ascii?Q?dV+IlXtfYPi21mLXhoQ3uvTn0VhCbvUZOyc/7/wGtGYwGHXg7ob/p/z6xETL?=
 =?us-ascii?Q?94wOyllAi+XYwF+muRSJTCVBRRvN+1XxtMmD3ErfQa8Tf0/jMj7AX21ByVwA?=
 =?us-ascii?Q?nYisaeu/IOCOwsCABswAfR6YaeN3IhhXwy3OYxr75HTXSqTlCkmbXaNhE2F6?=
 =?us-ascii?Q?KelvmmxyFr478qi/2a/hZcCtTyU8focagxuIBSpvtX20sXZj2Jj0Pn9/3lIz?=
 =?us-ascii?Q?6L4rKBq0By4AsuXo/5nGaeUjKFtB1894Yz3oJx9ToOI5jkQX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59174ef6-cf52-4389-454c-08ded16ea16c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 21:30:21.7475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGm/YLII6o9/y0pgVo5LCgS+w/QeDFMnQFyM4UfbzXISyQ1j5eZYc8VcqahaZo1GsF+oyjEb5KF6DoNYQVvFQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5444
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

> The device name is allocated with strdup() during scan and freed in sever=
al
> places. However, when this bus cleanup is converted to use the EAL generi=
c
> helper, freeing the device object will require a custom helper to also fr=
ee the
> device name (and for this, a cast will be needed).
>=20
> Instead, add an embedded name array to rte_vmbus_device structure (char
> name[RTE_DEV_NAME_MAX_LEN]) which is sufficient for all VMBUS device
> names (UUID format: 36 characters, or shorter legacy format).
>=20
> This simplifies the device freeing to a simple free() call.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/bus/vmbus/bus_vmbus_driver.h |  1 +
> drivers/bus/vmbus/linux/vmbus_bus.c  | 10 +++-------
>  2 files changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h
> b/drivers/bus/vmbus/bus_vmbus_driver.h
> index 888d856141..706ff1fcf5 100644
> --- a/drivers/bus/vmbus/bus_vmbus_driver.h
> +++ b/drivers/bus/vmbus/bus_vmbus_driver.h
> @@ -38,6 +38,7 @@ enum hv_uio_map {
>   */
>  struct rte_vmbus_device {
>  	struct rte_device device;              /**< Inherit core device */
> +	char name[RTE_DEV_NAME_MAX_LEN];       /**< VMBUS device name
> */
>  	rte_uuid_t device_id;		       /**< VMBUS device id */
>  	rte_uuid_t class_id;		       /**< VMBUS device type */
>  	uint32_t relid;			       /**< id for primary */
> diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c
> b/drivers/bus/vmbus/linux/vmbus_bus.c
> index 77d904ad6d..779ea50b92 100644
> --- a/drivers/bus/vmbus/linux/vmbus_bus.c
> +++ b/drivers/bus/vmbus/linux/vmbus_bus.c
> @@ -280,15 +280,14 @@ vmbus_scan_one(const char *name)
>  	char filename[PATH_MAX];
>  	char dirname[PATH_MAX];
>  	unsigned long tmp;
> -	char *dev_name;
>=20
>  	dev =3D calloc(1, sizeof(*dev));
>  	if (dev =3D=3D NULL)
>  		return -1;
>=20
> -	dev->device.name =3D dev_name =3D strdup(name);
> -	if (!dev->device.name)
> +	if (rte_strscpy(dev->name, name, sizeof(dev->name)) < 0)
>  		goto error;
> +	dev->device.name =3D dev->name;
>=20
>  	/* sysfs base directory
>  	 *   /sys/bus/vmbus/devices/7a08391f-f5a0-4ac0-9802-d13fd964f8df
> @@ -305,7 +304,6 @@ vmbus_scan_one(const char *name)
>=20
>  	/* skip non-network devices */
>  	if (rte_uuid_compare(dev->class_id, vmbus_nic_uuid) !=3D 0) {
> -		free(dev_name);
>  		free(dev);
>  		return 0;
>  	}
> @@ -330,7 +328,7 @@ vmbus_scan_one(const char *name)
>  		dev->monitor_id =3D UINT8_MAX;
>  	}
>=20
> -	dev->device.devargs =3D rte_bus_find_devargs(&rte_vmbus_bus,
> dev_name);
> +	dev->device.devargs =3D rte_bus_find_devargs(&rte_vmbus_bus, dev-
> >name);
>=20
>  	dev->device.numa_node =3D SOCKET_ID_ANY;
>  	if (vmbus_use_numa(dev)) {
> @@ -360,7 +358,6 @@ vmbus_scan_one(const char *name)
>  		} else { /* already registered */
>  			VMBUS_LOG(NOTICE,
>  				"%s already registered", name);
> -			free(dev_name);
>  			free(dev);
>  		}
>  		return 0;
> @@ -371,7 +368,6 @@ vmbus_scan_one(const char *name)
>  error:
>  	VMBUS_LOG(DEBUG, "failed");
>=20
> -	free(dev_name);
>  	free(dev);
>  	return -1;
>  }
> --
> 2.54.0

