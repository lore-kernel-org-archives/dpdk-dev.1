Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0204ACD98F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:05:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8FD84028D;
	Sat, 20 Jun 2026 00:05:13 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11021080.outbound.protection.outlook.com [52.101.62.80])
 by mails.dpdk.org (Postfix) with ESMTP id 829AC4028A
 for <dev@dpdk.org>; Sat, 20 Jun 2026 00:05:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksGVWUg6RNAX5zAD8OhOFhkM2AP3QymO+uXzdgpDk0xY2N4edVPMRdoXaaBd98+aLcvPBZ7MlVTU2wHtKJ5mVRiahvTMEKi3oftQ1q7N26a7WT3sWGjXNzpMOxbyURp8OoICBg74DB4OzlcBVlYsnHFsCFwKO2XBjOoqKRWZGhuGW0P6V2RefNNFurREHw4/1DX791/Mboixw3KOKuOJfBmyU/T0xIdA+dkCPsB48w0ZzLXxzboe2HmhXgHEj+TTdfdpBRDwFsKkMBy/UWMNVxqAnACJQjfkT2xX8uwLuZB9c27Mf+0d/AdLSs+4F9SlSgjrKJf9tkBVjWtcUxwIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvWSpxnmUR+L9Bw6uPVaKTiuZ/andGzAJM+77RnzdeU=;
 b=N7FlS/eU1XfeeT1OYd07Dm3o+OqyTZkA/aUCFRaO3aKiY+nqSDYFNxTwloYt40vZ+P+zWR2Xd8AcbZqsLNwZ+9qDPaqrAhZsa2G/AZNygzcPZ/3fEXVlPr3+OFPkWouYI+yQI6OBomJv8z+r9aKGYqp0brEx5U/wzQo6+BGK5vYYauJxvlP/b6zumxGFKwlQbMMKw9CCp1SFiI0qxr23WT4vIdqBvVy6u3Sm/U5G3P20B394wEoLSXr2VjqOz9CMB9D2RNbIlCcTMYKVbtoQHpE0gF+DYU/BAc4gJAjd9OzGv1foLY5BRpfA5sr8K6GeFurxE82EpD//AB+khqq/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvWSpxnmUR+L9Bw6uPVaKTiuZ/andGzAJM+77RnzdeU=;
 b=S+o9F+PWM1xrf+bukO2QTm/7+Ch7M+10t6tlYeEUMFRktm7u2WAkPeaLxpVqk+cV6rDhFbyHWXM1bn7DSKw6QnYRbkQLwpnQlKP6lD403zeyJ/opwXYhsLnPnnwaw6tEEU1LPNnaXD+4mjcTleD+/eMo/g2WVMU3LXaH8INRS/0=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6584.namprd21.prod.outlook.com (2603:10b6:806:4a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.9; Fri, 19 Jun
 2026 22:05:09 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0159.007; Fri, 19 Jun 2026
 22:05:09 +0000
From: Long Li <longli@microsoft.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>, 
 Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v2 06/10] bus/vmbus: allocate interrupt during
 probing
Thread-Topic: [EXTERNAL] [PATCH v2 06/10] bus/vmbus: allocate interrupt during
 probing
Thread-Index: AQHc/zc3GvLaq1EISk+svgz0huw8tbZGcNeQ
Date: Fri, 19 Jun 2026 22:05:09 +0000
Message-ID: <SA1PR21MB66832AADF4D9CB5E99A63B75CEE22@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
 <20260618152826.490569-7-david.marchand@redhat.com>
In-Reply-To: <20260618152826.490569-7-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6abb68a5-e0b1-4bab-8ac7-2437e1c17e3d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-19T22:04:44Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6584:EE_
x-ms-office365-filtering-correlation-id: 96ceb277-bfbd-4c6a-3ea0-08dece4ed402
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|4143699003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: zVFgK1QzLe+QAXqH8WmrfmTlnvVcPS/q2D9qLPBCd/XG1uE2BsBw0jF3lT3qmgHKdXhchA3MYg7K78Ly9vFJG6NNxskszOlFhM9b3PyqPOQ+MBESZfbpX00PByJRdvo87ADUt/H49TC84fu2cQKmEuwjCMZSvkrrp5xRuSKFiOqdGbYtdvD7H52/RarXgqwE0JlDplGgmI2y4v/qujtohF2kNLrSfgSVqrKayUfl2x/pOtSXgVUJDWDFi6+aQg5MP59is3A3O7OVIhhJRQW7Pf2vhAp0Sg3SwjHdfxd9QeohIfnteLMwPSZiSb3zvz7Pao/WU+7Lt7fxn1DC0DE2p2yU6PHacO8IFbktma0hxFfGCdI1Gj90fbt/0waJ0GjwORmW3tPEd5GFPMcMX6hMpe7NzmPcw7SdgeA4seF5Q7wF2chPVavLrIRkyNXJps+7GLdcBRLlqX/S99xzlKKJmRRo3LwO0/RzNxeTIfPZzs8Da2+ThM8Ho2GhzRClLRdqZTGkEBiZ5RAiMyKvezLJs0kKGk5mfQxWu2tKB8fbbSKWxMP06ee/MSgnpWyFBQZn+37Ui8BQh9TC/Uhs4yNhRQH73bau72XFsPtQmmpWGRkRp2rvHb3zEmOu3AAH2uAyUhNxmgM2QvCwsWgXJmvzm1A9XucZ+6lT4H3X1i6idpqSj2Yc8WVvwJB294U3pfiRyiUnlEeNl1I3z8cPnSBWXOImknYQtDIvoXdVAUDyrJE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D/Prpx7z6b510syYntQ7ufWTdWV3OzbsxmNUOlZaskpMAL2d4HahBcLRbQEG?=
 =?us-ascii?Q?qnyUk2OoQa2MFptGsUfac15Z1h/+SEg1MDCfchogQrfQfY6fQiCAo7iA3U7Y?=
 =?us-ascii?Q?yjTqPdvKNcttRhAS4yLhUfHdjLpNMvvR5moADqHL4fWtfDW1mMaObUw9togV?=
 =?us-ascii?Q?I86dwWGHE0h7aakIuSqkseLOse6IAvNqhAeWmABMSXwK9FcRIUhNrkM+yxCQ?=
 =?us-ascii?Q?9S4tNTe88ICJNc8vG6LQhKuYOkj35rDCgb/b+vJyW1v0Cf83yyCH00sd3XzH?=
 =?us-ascii?Q?J/PK8Phh5z6vYHJ7qVfIBgo+Cz8DZjQ+Qe974k8wi1lMIGYGQ1va2DsBnYGS?=
 =?us-ascii?Q?Ryo8ClYPOlHe/tNbVDLhgupH5dMMGpeFn5sLPS77O58eW6SJXEXpJAmjPJRQ?=
 =?us-ascii?Q?f3+Op5CZWHKbg11abu8w1DbO8H7CxNb6cgSCNSsyuxb0KrqfcGqHAAnD6XGp?=
 =?us-ascii?Q?MOB/MAsTOcnEuLgvv7BnhnDzbqk+s4jg0lTZGPdeC0kBRO+/1OqYFyRoiF5k?=
 =?us-ascii?Q?Tsdiz5XrjFxwOA3HjY/b3j3Z/8QMfi+EClMfLINKL6wgKex4qNzx2StEcKjM?=
 =?us-ascii?Q?D4mApoL1YFodoIYv+Pb2XxOqjJUBK5K62PSn6L1kYCgvmsPete3OmtjoLdrI?=
 =?us-ascii?Q?hjWhO9yEedQNsDEpREEmc6z/2THqVJlCHvthTQS/wJWD3ESLZadZvi4s4yoO?=
 =?us-ascii?Q?itv9EPe+jhmsZf2rZpPA5+zEFFoU+nge5UtJVU9u0QATeMWi8Fp6eAKc0q/k?=
 =?us-ascii?Q?cYQJbAL8CmJcMRXFBVl5QmQNLaJBHGrzVbkfmEboJuzA6QU2CeGsUmIQ7VBM?=
 =?us-ascii?Q?DDJeYlNPZZ6QrGyQfV3PeDB0z/z2hGSgXMDkvOtLL15rKFDeuWxyAJ05x27g?=
 =?us-ascii?Q?Gt+dvMuRj9JiY0DOrSbpYDYNnZ7VQL4vDCex492ijqWMTenHRs8r9TCWB0pq?=
 =?us-ascii?Q?/G2ZPRqMeqk8PO5avU6loYcC2j+JkjhPjRfxQcrJSnnaT3YuTKr9xAztmrty?=
 =?us-ascii?Q?pzx2uD9SLcOOZFHso+vZ4thZimL5I7ijvANRqVEsvBQ34hdFmsh6oJN83kqS?=
 =?us-ascii?Q?IFSoHshOd141K0dR7fXbi8WXwK47uOntx8WNCHEL0Zrb6z9qdzSm/9gvLMmi?=
 =?us-ascii?Q?x3VAmT2BBXB6uMe0MQexTgKpBiGYLXEU+pYRocR0kfQn3HTPMuPC3ue2UaZY?=
 =?us-ascii?Q?8sIncTMIJxGVOsgHx3s5PrBPzkl2/6t/JXikpa4o3n1bkemTeuew08MpRF6q?=
 =?us-ascii?Q?2mW1feTyzuMqgXtpmsXLl1F9/sUGkxBhuUb185frk4EMvG2biDaTUfFuPdJ4?=
 =?us-ascii?Q?pDzqKPu86GVm+im5aE7OGlyO+mYTL+kkGy0jOgI+F3QF1HzDt4LQNz8e5fDu?=
 =?us-ascii?Q?gSmfBtUmwXRxZ/zobpVTjD2dajZsCge7JHUWaj6mF5PqEIVHiRm5Giaje0lC?=
 =?us-ascii?Q?IHSRPton50i1Rm/AmoGSkys0dXLVb0hupVjTHP7a35Zoaf0+KNOWTsVKblRL?=
 =?us-ascii?Q?cXysS3PHMCNqHX+B6gVHNA9hstjHtkr4yW4szFLm/+sMLTqmwDUtY4wyGtHO?=
 =?us-ascii?Q?ZlIqgi5xmT9fm66JG2E2QE1npAGdQJcuJ7Ea2GslOPuXmTAZtw8HBMaBPCca?=
 =?us-ascii?Q?XGb8VpzS6ySubciLO14YxMP8FCBEoicok74qGtSjARF1JNdJMHn50/Qc++Ry?=
 =?us-ascii?Q?10jEki6Ir1UhzpcLUxjePUp1ZJZ0WDCjU4wCng7qkKMNQB6d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ceb277-bfbd-4c6a-3ea0-08dece4ed402
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 22:05:09.2458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HcQPmwHV4DZOetJTEi4yDuYuEbMs1xXXHLMLCvQiIwmG+0ktGc2FoawCYFhas1ev6HaUu65D5sdr/zKEM8CAQ==
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

> Allocating the interrupt handle is a waste of memory if no device is prob=
ed
> later (like for example, if a allowlist is passed).
> Instead, allocate this handle at the time probe_device is called.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
> Changes since v1:
> - fixed/reordered interrupt handle allocation,
>=20
> ---
>  drivers/bus/vmbus/linux/vmbus_bus.c |  6 ------
>  drivers/bus/vmbus/vmbus_common.c    | 18 ++++++++++++++++--
>  2 files changed, 16 insertions(+), 8 deletions(-)
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
> index 74c1ddff69..bfb45e963c 100644
> --- a/drivers/bus/vmbus/vmbus_common.c
> +++ b/drivers/bus/vmbus/vmbus_common.c
> @@ -100,10 +100,16 @@ vmbus_probe_device(struct rte_driver *drv, struct
> rte_device *dev)
>  		return 1;
>  	}
>=20
> +	/* allocate interrupt handle instance */
> +	vmbus_dev->intr_handle =3D
> +		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
> +	if (vmbus_dev->intr_handle =3D=3D NULL)
> +		return -ENOMEM;
> +
>  	/* map resources for device */
>  	ret =3D rte_vmbus_map_device(vmbus_dev);
>  	if (ret !=3D 0)
> -		return ret;
> +		goto free_intr;
>=20
>  	if (vmbus_dev->device.numa_node < 0 && rte_socket_count() > 1)
>  		VMBUS_LOG(INFO, "Device %s is not NUMA-aware", guid); @@
> -112,7 +118,15 @@ vmbus_probe_device(struct rte_driver *drv, struct
> rte_device *dev)
>  	VMBUS_LOG(INFO, "  probe driver: %s", vmbus_drv->driver.name);
>  	ret =3D vmbus_drv->probe(vmbus_drv, vmbus_dev);
>  	if (ret !=3D 0)
> -		rte_vmbus_unmap_device(vmbus_dev);
> +		goto unmap;
> +
> +	return 0;
> +
> +unmap:
> +	rte_vmbus_unmap_device(vmbus_dev);
> +free_intr:
> +	rte_intr_instance_free(vmbus_dev->intr_handle);
> +	vmbus_dev->intr_handle =3D NULL;
>=20
>  	return ret;
>  }
> --
> 2.53.0

