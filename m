Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9AC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 18:10:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7894402D1;
	Fri, 26 Jun 2026 20:09:59 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11020088.outbound.protection.outlook.com [52.101.201.88])
 by mails.dpdk.org (Postfix) with ESMTP id A02444026D
 for <dev@dpdk.org>; Fri, 26 Jun 2026 20:09:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TejQT584H7Z3o1huS2yBiUwQXKxTSCXVCE8W6PqJIat80KBYhnK8LjwMIVWbbomtYWuB7TNIRUjV8hG0rMuExHvSDsYrVhQ5fgXJGzlWUaxfO1mXowgYqEnkzU4a9MKMuEdz+pt2x/ShY6DjuGheIzaAv//8stjBRdEHY1ShPTvfPbMSXvDpRVHZACWT12KsmNOuH0xzEIa6CskmihqMiGiACMLzIBB3lYd+d2j19OHdyW4qJmtMq5PsCQsZ+IVqbt4kVDz77nDpdkJXMBQkzJfjNTxXzuw9aOdAjXkxEP59/+h4ZAk0OeavysFeN/5e2slCa0s6Axbvupfr3MF6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwRm2TePVzcsYBHb8heWjSaQozEqDxXO6TkVot5NxI0=;
 b=zVBAplCz9IbUtjUIcyXdfDr0jvS0K2oUztfNpX9Bwfh/Q5VCicQqtnTBLP5xxnMl4BM4iDkNkpAIDxDIrUMsoEdcHbr8i2G+Pv/gX29EKey7fUX2CiQnR1OIIGz5zXfmXVWEBCfRN9KxDECDVdPaFTED3Alzmz5EibbRdgC7ksfa8zialEUXK4rbU3fsemtvqn7x4SRSt8VIA2j0NqN0CoMfhXLi1iczUZg8n1GWlpKAi6v12Ug3GuSXAYnnEvl4enYCaeB1uL44qIhW5tPtW9A7umLzcDj5glBA84tYDNLSTnuwcCDE7y1HBMBcBqW61Q/aNbOAaHUHZvr5/duc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwRm2TePVzcsYBHb8heWjSaQozEqDxXO6TkVot5NxI0=;
 b=D51gTE7yvwGuMTBkbDK4IQ95HdiaEe/fJw7/RIC5JX97DtBOSa5nwGPOsEK4wjd8sJlBVAdFHF4lFjULDKFNUmH41TVTBKkfbGs45btXiQXUMInXIc5FTmrEjHhsTBEXyVL4hypPk+8f3WAiAb5KMVu2r4LjiuGXFmX9JngjRxU=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6392.namprd21.prod.outlook.com (2603:10b6:806:4a4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.9; Fri, 26 Jun
 2026 18:09:55 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0159.007; Fri, 26 Jun 2026
 18:09:54 +0000
From: Long Li <longli@microsoft.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] dev: skip multi-process in hotplug
Thread-Topic: [EXTERNAL] [PATCH] dev: skip multi-process in hotplug
Thread-Index: AQHdBHN2LH79sl7R4k2LrkvTepe0nrZRJIGg
Date: Fri, 26 Jun 2026 18:09:54 +0000
Message-ID: <SA1PR21MB66832482A8C80E279EAAAB7DCEEB2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260625072254.4190227-1-david.marchand@redhat.com>
In-Reply-To: <20260625072254.4190227-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d38b5d6d-26c1-4339-8f75-f104f3840c6e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-26T18:07:52Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6392:EE_
x-ms-office365-filtering-correlation-id: 70d2a297-20b6-480e-3d57-08ded3ae1ff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: woPFpnTg0si6dr5xiYTDDtxM7gR4azIlZAGsI8e7k8WEOyt/KLq4zowgh2jIFIfjGjYGr1KDYh/Mn5RniRuoaMgyBIJElsWOp3FrCjLYALsaC9S9wAcdDoE2od8dC9WwEqL/Q8SRO8xURc5ot6Nqfm85DH/QbdPW3pvWfZecojinkawkt7vSlzCQ3C3nmwExsVH90MjLofwkIEhDltEJ2MrGiJubo5rkhPdU6T6dyY1M2fCsuOY1VOJ910wkfzuKA3tGTwKK/PsOIxAeSuNAtn4iK2qvVF+5GQWmbsDGj3JLWHtfhQXy761ejyalMkWCZRAFNHlZDVHLQ8HHQb5mZ750aWDLUi4F7eSPM0HtiXSYrP/z8zUM6Yfp2SnyetgIOIfAsEQjg5HzoalozlgYT6bfEC8+eqG1db9QvHPtsNfzm+jwlcrNaiWBFzyIGCM7Tki4xkKi7g5zgHCopyrHlPHdBKHJyQrTPz/e86EzBqZITAubwpMi35kYKqxAuAK9JR6VjYOcOaDy/ZyCMvcwz3tg7b9/iSs8IbkDFEA/NvFmCkfykvNJeyzr+lLLPAN41YupOUXyTuxQkhjlWTrM/A6DF7qgt2Mbnf0BDccGlGb3J5clSLaFYJBxxF6634d4rdGhqOHlU98PanYtl4fq0aHP+Hy0PB1FTwHwwUsBZn4s0Ac9t/sgJx8TqPnU1UOeAAg1qvXgAFMej1lGY/VD0Af4lnJsqdL7jq8P5qH1FWA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8dVF6fwy7zde17Ys8Qn/v37gH4s4OE646ttnlIXJk6SL2bf5XHkY+sup9IQT?=
 =?us-ascii?Q?Ktk0bfF9XXg+pUi1DUWnnGLks0PNSsmR4e7GNlUW2+4+MPo+rZ2DFBzkYwms?=
 =?us-ascii?Q?CB5wv0hUy1F4N+JRLBHRM6WLPWPLhV26nAwoq9QvqrRoSdiBDLitezPZbRsn?=
 =?us-ascii?Q?efy8tuj8brqDwd/N6sCPNN9uySsilLFjlevLZmqfqsxIJOYMzpZH0KLLXHhA?=
 =?us-ascii?Q?eV6pwYdTThYyETGQu45q8Eq6xpLrCCYTcsTids+U2gDBdorbwp52vnuGKpTC?=
 =?us-ascii?Q?14/rWU3SB6SiSLFzRRmYkdmb/0QcWlBGHcf0NIvRENUQBI9DOCgZN3inR5LP?=
 =?us-ascii?Q?FwfYc1TMtcY/MHh3Q5P37QkZhDZ7fJrIqCre/KwypJoKTGxOStldK2gSvV1J?=
 =?us-ascii?Q?8cYzEhLzo+1jj7Fe5f5P7OI3k18tRuFEdNHWMmmYJ/E4/H58M125ZRyv5Ee6?=
 =?us-ascii?Q?kAixnKBajq7FK3GBuUrZCj5u+ziCzdWlfAVhNVlQctYWdpg/2s/Oc32rQ4eJ?=
 =?us-ascii?Q?pbQjilz1mp5yAT50nkdwhccUnVEIJU3Z3S350gJ0EvxZdVeDRLQtSDonaP9a?=
 =?us-ascii?Q?k2gq5TIuuIJvDRFeBqafz+nB31c8Kn6vUa2zOD2a/gRolGApwm1Um3kQVc85?=
 =?us-ascii?Q?8uRS6Ulp1eSivHq+ilnWkEaYknkBgWFS+Wd5N9S2smViwyLm1x1MiLnTQnWs?=
 =?us-ascii?Q?3kpml5Dwnr6HorfFjI9lyfzmUdk7GZ6/0ME/RKhzRH46En2/GxLD+8LAfNc1?=
 =?us-ascii?Q?Y5SRRGp8YicH7KQNpQNUritvrfeFzRSPgJRbOLeTWhx3+728I97KEPfBNnXf?=
 =?us-ascii?Q?+lqEEXTw3+OFFbeet1NaHZRAFkoVc+XXULqAXQUG80RCkqqcMtFvag1R32mW?=
 =?us-ascii?Q?jJZNMOm4XnD68dtJlwHcCGUlo3x/+AdH98FpiD/9molUNNnx32QsuTTdRbBG?=
 =?us-ascii?Q?BY1SOCJ0kdaqBb3XhLY2LTVord+TUld3I4VOsGHDiMZ4DotT0Un2ZCmDxTH+?=
 =?us-ascii?Q?VtG80ji0TXh0yY12BiGpaSrL/dtxwoG2iGIOMgQNVpsp94s+ldkyc36bYMa3?=
 =?us-ascii?Q?RVnsWedPUl+KUUdbK2fL+2tEb1ZW609RuPj9R1v0EjZ+bLTXyBj3E/be4+Pd?=
 =?us-ascii?Q?fmIE53nTtUgTfcl/euLL/tL1CZr1DpY+2NLMMLZj7bdPjSxwMNk2B5d933uv?=
 =?us-ascii?Q?yx1j+iZyyy1zHpiRQgSJ/qkdfoRiY9mk+RPhThV0KXBR/lPEejkDHJZ/LiJ7?=
 =?us-ascii?Q?sgkmr6eIt0d4uOWiITx4rpP63CFijGtOaPvod/w6HzC8rm16BCPsy8C7yUe9?=
 =?us-ascii?Q?0KUAcuxbthjG+t01tatrawhPXAFXXC2o2BBVZnygHQYHlXd/sTNvK2wBBneQ?=
 =?us-ascii?Q?uwTAF62rpuqgmy1o6YZIweXoqWH+9Ct83tyRIciKmnT1Uq4sm3FWnkgvi0ph?=
 =?us-ascii?Q?yHEzYNagpiTVJJ9ObBLa/wFih4hl2uu7pG5WGv9wkR1MCpYZXdOwWqXwH7pL?=
 =?us-ascii?Q?skSihe1RG4bX71ByFgpP7HVFzkqJNvmdl/0KAcXd0CvwFOMx48KbFE1QzZni?=
 =?us-ascii?Q?r/nV0hPFwc1KsBIZQPNwzGltkVnbVFd7e8/NrFznI2q02JMs2+AbgSn+kqIq?=
 =?us-ascii?Q?eNxRVXYF2iRRWmHjAI8yQrmup2zCdqjDe7OVWVbydXIkSF19lslwdITPRlQ3?=
 =?us-ascii?Q?LbJ7V/6ZZwJlRp9i1I2QCmwX1+qbTWtcnpWV5ccHzlpbtsE7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d2a297-20b6-480e-3d57-08ded3ae1ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 18:09:54.6644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJMpXLGsZDOU3OR6n/Y8kcYI3s5a/ocLefM/Rm51ONZbXheIPsBVYUswWqFLae3xZPRWQ16Kt8OegjT51NSFwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6392
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

> If multi-process is disabled (--no-shconf/--in-memory), there is no need =
to
> build a multi-process message.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/eal/common/eal_common_dev.c | 46 ++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 12 deletions(-)
>=20
> diff --git a/lib/eal/common/eal_common_dev.c
> b/lib/eal/common/eal_common_dev.c index 48b631532a..b0ec2b0601
> 100644
> --- a/lib/eal/common/eal_common_dev.c
> +++ b/lib/eal/common/eal_common_dev.c
> @@ -267,10 +267,16 @@ RTE_EXPORT_SYMBOL(rte_dev_probe)  int
> rte_dev_probe(const char *devargs)  {
> +	const struct internal_config *internal_conf =3D
> +		eal_get_internal_configuration();
> +	bool do_mp =3D internal_conf->no_shconf =3D=3D 0;
>  	struct eal_dev_mp_req req;
>  	struct rte_device *dev;
>  	int ret;
>=20
> +	if (!do_mp)
> +		goto skip_mp_req;
> +
>  	memset(&req, 0, sizeof(req));
>  	req.t =3D EAL_DEV_REQ_TYPE_ATTACH;
>  	strlcpy(req.devargs, devargs, EAL_DEV_MP_DEV_ARGS_MAX_LEN);
> @@ -294,6 +300,7 @@ rte_dev_probe(const char *devargs)
>=20
>  	/* attach a shared device from primary start from here: */
>=20
> +skip_mp_req:
>  	/* primary attach the new device itself. */
>  	ret =3D local_dev_probe(devargs, &dev);
>=20
> @@ -311,6 +318,9 @@ rte_dev_probe(const char *devargs)
>  			return ret;
>  	}
>=20
> +	if (!do_mp)
> +		goto skip_mp_notify;
> +
>  	/* primary send attach sync request to secondary. */
>  	ret =3D eal_dev_hotplug_request_to_secondary(&req);
>=20
> @@ -337,16 +347,19 @@ rte_dev_probe(const char *devargs)
>  		goto rollback;
>  	}
>=20
> +skip_mp_notify:
>  	return 0;
>=20
>  rollback:
> -	req.t =3D EAL_DEV_REQ_TYPE_ATTACH_ROLLBACK;
> +	if (do_mp) {
> +		req.t =3D EAL_DEV_REQ_TYPE_ATTACH_ROLLBACK;
>=20
> -	/* primary send rollback request to secondary. */
> -	if (eal_dev_hotplug_request_to_secondary(&req) !=3D 0)
> -		EAL_LOG(WARNING,
> -			"Failed to rollback device attach on secondary."
> -			"Devices in secondary may not sync with primary");
> +		/* primary send rollback request to secondary. */
> +		if (eal_dev_hotplug_request_to_secondary(&req) !=3D 0)
> +			EAL_LOG(WARNING,
> +				"Failed to rollback device attach on
> secondary."
> +				"Devices in secondary may not sync with
> primary");
> +	}
>=20
>  	/* primary rollback itself. */
>  	if (local_dev_remove(dev) !=3D 0)
> @@ -405,6 +418,9 @@ RTE_EXPORT_SYMBOL(rte_dev_remove)  int
> rte_dev_remove(struct rte_device *dev)  {
> +	const struct internal_config *internal_conf =3D
> +		eal_get_internal_configuration();
> +	bool do_mp =3D internal_conf->no_shconf =3D=3D 0;
>  	struct eal_dev_mp_req req;
>  	char *devargs;
>  	int ret;
> @@ -418,6 +434,9 @@ rte_dev_remove(struct rte_device *dev)
>  	if (ret !=3D 0)
>  		return ret;
>=20
> +	if (!do_mp)
> +		goto skip_mp_req;
> +

Need to call free(devargs) as it no longer used.


>  	memset(&req, 0, sizeof(req));
>  	req.t =3D EAL_DEV_REQ_TYPE_DETACH;
>  	strlcpy(req.devargs, devargs, EAL_DEV_MP_DEV_ARGS_MAX_LEN);
> @@ -472,6 +491,7 @@ rte_dev_remove(struct rte_device *dev)
>  			goto rollback;
>  	}
>=20
> +skip_mp_req:
>  	/* primary detach the device itself. */
>  	ret =3D local_dev_remove(dev);
>=20
> @@ -488,13 +508,15 @@ rte_dev_remove(struct rte_device *dev)
>  	return 0;
>=20
>  rollback:
> -	req.t =3D EAL_DEV_REQ_TYPE_DETACH_ROLLBACK;
> +	if (do_mp) {
> +		req.t =3D EAL_DEV_REQ_TYPE_DETACH_ROLLBACK;
>=20
> -	/* primary send rollback request to secondary. */
> -	if (eal_dev_hotplug_request_to_secondary(&req) !=3D 0)
> -		EAL_LOG(WARNING,
> -			"Failed to rollback device detach on secondary."
> -			"Devices in secondary may not sync with primary");
> +		/* primary send rollback request to secondary. */
> +		if (eal_dev_hotplug_request_to_secondary(&req) !=3D 0)
> +			EAL_LOG(WARNING,
> +				"Failed to rollback device detach on
> secondary."
> +				"Devices in secondary may not sync with
> primary");
> +	}
>=20
>  	return ret;
>  }
> --
> 2.54.0

