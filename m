Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4029CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 19:13:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A7D40DD5;
	Mon, 15 Jun 2026 21:13:20 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11020137.outbound.protection.outlook.com [52.101.85.137])
 by mails.dpdk.org (Postfix) with ESMTP id 89537400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 21:13:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOeCA6BcQ2UOMYS6Ey2Gfs3JZ0vHCvkdmwLff5ezk9doSl/rp+b/w2Wl1ukVnSoM9EKnU0j2pb5tpJsj9tYDkpuxVzSQDPmK9fKESkL4eWP9mr9jF+XvregqomSzi2ZR6gCCC6x8yaT2cQ9+X6ZKE5r7UBOHciCHRakz1hbjsAxtquIsAhNH3c8MIp0q7qbmK7Js+uF4dThTK/dECsENoE+WkGIl3JfKHz29mJ8708TZcVc1L+SaXCO5gZgQgDENQCCO+DHvwsF+xeOf69p/nQFMN4+q/ituBT9UJeD6ziUW7/znqAz4zgTfdpusbggV0sxIkTrqURSC9sFb/bapvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy2ZFb26g9zpGfJoCAHTSTtbS3llEWOeMEQB5zJivLw=;
 b=WlE5JQzohMlCuN9Y3ECwkUXfYE5d7VHcpHeR7BMX6Oj++T4UtkVd8fftt7Vf/nfvWM75CvKInLEeuFcJUpWs1EMGT4np6C52qovvAhgiCpLo3kFGjhCNqeek08uCSot9LCMe+iW7FWTNHuT6WWZtfWp1FT7P6iA1VQLb78GHV4MbCyh3hVxDm1zvcFDK0bGVDeEYMPHX4PhWDE1JVHH4TTH6FaaNUEK5iqAdOFFkhvKvM9u1sPLsOCrz9WYpVIWIqfbX2bjhHb8Y12C8E5JifAxc127/bHnNfutzud82QydtKRS7SH19lKanMcweS6ybDOjfsr9CtyLSEmEnd7JtpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy2ZFb26g9zpGfJoCAHTSTtbS3llEWOeMEQB5zJivLw=;
 b=BVJECNNWE0IaIL/L/HJR60xiwLicoqbH4zVtDbCcttNB1EQnZD4U52/wd2lJS0W+cFs3AJG6v9OJ7Y1dUzlQztKIbHsYahqIXjvM41Y/19uaHdqPTrKSCxe1yemI9+Rtp/kEMdyHGzynkP7DzmQD3p+BXiTZhVlUfHcsDBztW+g=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV4PR21MB6750.namprd21.prod.outlook.com (2603:10b6:408:357::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.0; Mon, 15 Jun
 2026 19:13:16 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0139.005; Mon, 15 Jun 2026
 19:13:16 +0000
From: Long Li <longli@microsoft.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 08/13] bus/vmbus: allocate interrupt during
 probing
Thread-Topic: [EXTERNAL] [PATCH 08/13] bus/vmbus: allocate interrupt during
 probing
Thread-Index: AQHc+Yc6Wkr27XDKYkyqkdFC4cWvIrZAAcLQ
Date: Mon, 15 Jun 2026 19:13:16 +0000
Message-ID: <SA1PR21MB668385E4EB19D0EAAC37AAD1CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260611094551.1514962-9-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-9-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c0aaec24-0543-412d-8c94-3cf286701fac;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-15T19:08:54Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV4PR21MB6750:EE_
x-ms-office365-filtering-correlation-id: 4377e03d-fa89-4036-c32f-08decb12277b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: c+dl3A9s55Anh0iV6auF2XykvnnBAj314inobkOA59q1HfPg8lQxdae5R2Fr2M1+tBRyh8JFLUVrxuQ/wkZIvHwnDdh6q7cbHRI/m3rbWCq6V5yqDdmkE5mQaZ/5ZGQM5GAQQCSXjrGbB3GHBx8BCvuhCsQNsfXu2jvwYri8Xl7HfyImxtBPbIzCegVLtMoOZ7rRk4r3swtIy1amHc0pKUvxtrfeZEakxJ60YibXtH7AAc1bIiqhbNU3z6Jf9fFkhLD9dMBOBZOdGdjYXSblTjWz76BJ846RQ7GERgaffLTNRaB56PI33Y7HeGFYComNii3Ipxhb9rAtOwnhbVfnTXjkLozUKMWhJgLsxiZ7TA/0j6mQeIykllc9CbitdjbJm1KDECODLFiI6R/r1AcljKf/vOMwQfIOtW8KmtvJKn449BwBg8xILHmMm7ErEDhDHPBCx0n1JhwQ0jwVD9LM3Zbj7Kpt8xWy9wk765kfvn0lalv7o0CBoV6D9Vnh2nyfO9vWOF9cqDYpG0GUNFQywVS7vsHI/h00/ssFuk3qP4g9BPyGvWs0nvGGWbcEdlyLo+g+Z2p6lSK3N5ma3JK9jGqpvaCGJtUAWoW1bIJs6DJl6I1JTz29BThAuayapZ1V0VQAFzWzjVn2jKBumISlMqsVmGgvHEPFnT+lQyTH26eqg31CGdwgYcNobG+MTQhdPNQmGBeeAdikpYWAwl13F7tdlfN1xMJl4XItt3Z90LwgGGlossBrk+u9bjaXRhVY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SIUOIanukLxhVSBnyq3tda7EKUiaQocWq0Ppk7Gt5ZsgojYNiR5V5dn8gr/I?=
 =?us-ascii?Q?btRAJ8e/GQeY9AMieVG2SBesYQekMOONrwLr7KSB0RD0JceazPywHtSjMc2g?=
 =?us-ascii?Q?tEcj1mp8jvwUSDSO6TQr9Tu52+w0Ahe/2CtnNp0AFJ8/xUvaXDueRUV1XyEJ?=
 =?us-ascii?Q?fvOS19Fcjdu7MCg7S6CwPYNiheKhxxa+2kHXmDK6bUE0zUIxeaTQsAFxw4Lg?=
 =?us-ascii?Q?BNh5SA0JvKJRc0l2olKjpdA3NA/woTmAeKq40iQ0cLtfPki/cmrqTBlnTcXt?=
 =?us-ascii?Q?7m07tLHmjktJNqAfgqCeN7+W3xEVSJcF2opgaKSx0kgFLGNSsndg7Bulxrvd?=
 =?us-ascii?Q?bRJfYbc2GWw/f9ryFC7sK07HQyqkWaEqWms/tdEs/NLPsVHIK28JrdaLGuCV?=
 =?us-ascii?Q?/kSewtwsxRM4H2hCdIoANtDfwO1W1wmsirHpn9ZCFJSYuqgQEqBNnnwkv3k+?=
 =?us-ascii?Q?1Qhau8y+oo+K8/11kPHyq1xfcPWBlkMfGWMChs00W31yMABTkfVYJoO6qPN2?=
 =?us-ascii?Q?djHjAC97b7mc/Bjgf7ZRvolBTVKXrDaCtlBvZu48aHLJmvFYE2EVwvUe4gCP?=
 =?us-ascii?Q?xQkiy5GND7mXdY5YryJEgHjdAbt46vLNsLdvzSXhrzfX+I6ZFJBTiHjgHXvd?=
 =?us-ascii?Q?zlQ2EUe8GGEJXSpi/l9wGzdnFshoUVv7oRGhS1bJJ1VtwT3IMAcDDT36tlH7?=
 =?us-ascii?Q?cgzb4NYg2z5Zi42ILw5PXNw604nsON8M0ly39jmqthxbcgOMIi4vxx/X2oC1?=
 =?us-ascii?Q?x2AtqYALmkROJDaHwymjdV3jvQIcN8X0+v0GlqKH72e7zRrO55tPLgZXxwRv?=
 =?us-ascii?Q?O150zodv15Ph3ZgouqAOv7sKJaYBgqYyk0fTavJKnmH4v6ZY90ZvOB6ZN9HQ?=
 =?us-ascii?Q?HHPKgywRcLXEBClY2GtTD9Cojs0qK2hH1tZtNdYHCE9gVaNigBd3jDZkATBH?=
 =?us-ascii?Q?8wn3vHUNrd5uwENBEk6fDx5io4HXqy5k3Pu4IVWJbPpU4bIpklpvgq1HZ1QV?=
 =?us-ascii?Q?xen46qOTzCG/E1MuFUaNCr1joYhxBTPMOxCQwC+zKf0GzDZyqhWjHtOueyh7?=
 =?us-ascii?Q?8evv6ZSwLsG4ipvqoVgS5ZTxzPWzuJL0hh6QgPdssudDKbC6f9yV4tzmkMto?=
 =?us-ascii?Q?A6I3kXJxBvCfQwtSUJ7jQiGaPKQhc4R6QxeWXtQvyZKjedG84ZyXh3n1R1gU?=
 =?us-ascii?Q?Xc+2hSWRCBvczfMI3te0PIjylhdZeyvanc7amhrF2IYsP7AJ0F8EYzV+MSo3?=
 =?us-ascii?Q?CwetE0vfmlhaum3hVAvssT1xxHSX4qX1iXHVaGy+1iVwXS+aBcnh3RdQHtt0?=
 =?us-ascii?Q?dDKEGKxDbU8Mq6elLCc1fNn8XW3iQ6gn0BwG8xElzBW1dpnwTYr/9RChLvDA?=
 =?us-ascii?Q?PqtFo9rIirIaPCWVk1I7GM8nfC5upDNFa8H01ugGOCqIysZhxMdyMicwRxnt?=
 =?us-ascii?Q?DNVybvu+akmeDeMe8ghxfV4Hs/FacY8OofuzkUMRG4p96W4KJuac/skiWdX+?=
 =?us-ascii?Q?T+26g7adxDX4vGupXRayW6KESdQo+8CkHvO7Oc+t+guANwqmw7CFrKupJiCK?=
 =?us-ascii?Q?VaNAH2Bo53/U3HU5hJUKlM8I4xgwcOEhdvFrZ/+sgmuh63LIffOCjNXBk4ZP?=
 =?us-ascii?Q?tKqCphGCTzhtuikjXxQ+WSJCMIe/bbkzqM2aR5R/99AyJRfhhNJDfWdZrY8W?=
 =?us-ascii?Q?ZZ+F1rW1i84u1UBBZL/IW8AbIVofldDGCejdb1Hw8Pc+s21r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4377e03d-fa89-4036-c32f-08decb12277b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 19:13:16.5414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHTWHECO0fWpStUss4JoVm3JrNWFmIdVP6Id6z5Xt6VqwHLa+2wgiyYCHze3RWPSjBBg61xtUwPZN0zRSqHnkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR21MB6750
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


> Allocating the interrupt handle is a waste of memory if no device is prob=
ed
> later (like for example, if a allowlist is passed).
> Instead, allocate this handle at the time probe_device is called.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/bus/vmbus/linux/vmbus_bus.c |  6 ------
>  drivers/bus/vmbus/vmbus_common.c    | 18 +++++++++++++++++-
>  2 files changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c
> b/drivers/bus/vmbus/linux/vmbus_bus.c
> index 0af10f6a69..77d904ad6d 100644
> --- a/drivers/bus/vmbus/linux/vmbus_bus.c
> +++ b/drivers/bus/vmbus/linux/vmbus_bus.c
> @@ -345,12 +345,6 @@ vmbus_scan_one(const char *name)
>  		}
>  	}
>=20
> -	/* Allocate interrupt handle instance */
> -	dev->intr_handle =3D
> -		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
> -	if (dev->intr_handle =3D=3D NULL)
> -		goto error;
> -
>  	/* device is valid, add in list (sorted) */
>  	VMBUS_LOG(DEBUG, "Adding vmbus device %s", name);
>=20
> diff --git a/drivers/bus/vmbus/vmbus_common.c
> b/drivers/bus/vmbus/vmbus_common.c
> index 74c1ddff69..b6ae82915f 100644
> --- a/drivers/bus/vmbus/vmbus_common.c
> +++ b/drivers/bus/vmbus/vmbus_common.c
> @@ -108,11 +108,27 @@ vmbus_probe_device(struct rte_driver *drv, struct
> rte_device *dev)
>  	if (vmbus_dev->device.numa_node < 0 && rte_socket_count() > 1)
>  		VMBUS_LOG(INFO, "Device %s is not NUMA-aware", guid);
>=20
> +	/* Allocate interrupt handle instance */
> +	vmbus_dev->intr_handle =3D
> +		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
> +	if (vmbus_dev->intr_handle =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto unmap;
> +	}
> +
>  	/* call the driver probe() function */
>  	VMBUS_LOG(INFO, "  probe driver: %s", vmbus_drv->driver.name);
>  	ret =3D vmbus_drv->probe(vmbus_drv, vmbus_dev);
>  	if (ret !=3D 0)
> -		rte_vmbus_unmap_device(vmbus_dev);
> +		goto free_intr;
> +
> +	return 0;
> +
> +free_intr:
> +	rte_intr_instance_free(vmbus_dev->intr_handle);
> +	vmbus_dev->intr_handle =3D NULL;
> +unmap:
> +	rte_vmbus_unmap_device(vmbus_dev);
>=20
>  	return ret;
>  }
> --
> 2.53.0

rte_vmbus_map_device() needs intr_handle to already exist, so need to move =
rte_intr_instance_alloc to earlier before calling rte_vmbus_map_device(),
something like this:

diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_com=
mon.c
index 419eb9b895..f3bcb90e46 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -100,35 +100,33 @@ vmbus_probe_device(struct rte_driver *drv, struct rte=
_device *dev)
                return 1;
        }

+       /* Allocate interrupt handle instance */
+       vmbus_dev->intr_handle =3D
+               rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+       if (vmbus_dev->intr_handle =3D=3D NULL)
+               return -ENOMEM;
+
        /* map resources for device */
        ret =3D rte_vmbus_map_device(vmbus_dev);
        if (ret !=3D 0)
-               return ret;
+               goto free_intr;

        if (vmbus_dev->device.numa_node < 0 && rte_socket_count() > 1)
                VMBUS_LOG(INFO, "Device %s is not NUMA-aware", guid);

-       /* Allocate interrupt handle instance */
-       vmbus_dev->intr_handle =3D
-               rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-       if (vmbus_dev->intr_handle =3D=3D NULL) {
-               ret =3D -ENOMEM;
-               goto unmap;
-       }
-
        /* call the driver probe() function */
        VMBUS_LOG(INFO, "  probe driver: %s", vmbus_drv->driver.name);
        ret =3D vmbus_drv->probe(vmbus_drv, vmbus_dev);
        if (ret !=3D 0)
-               goto free_intr;
+               goto unmap;

        return 0;

+unmap:
+       rte_vmbus_unmap_device(vmbus_dev);
 free_intr:
        rte_intr_instance_free(vmbus_dev->intr_handle);
        vmbus_dev->intr_handle =3D NULL;
-unmap:
-       rte_vmbus_unmap_device(vmbus_dev);

        return ret;
 }
