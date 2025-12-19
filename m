Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC5FE66880
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 17:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC69E40276;
	Fri, 19 Dec 2025 18:35:38 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11023122.outbound.protection.outlook.com
 [40.93.201.122]) by mails.dpdk.org (Postfix) with ESMTP id E483E40150
 for <dev@dpdk.org>; Fri, 19 Dec 2025 18:35:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7ak13NrsbD7C4OFzTb27ELi/NQpMoABDL/KpOlUTheAyAGyUHrOyZMJgF0GcoF65S5ZP9POPSujiDmLaRkRLf+Tr7UvlYYTedoPdem9U6l0ifUBe1FLHd7J3OPX5kFIDk8xJBANl3TwDV4wRjvcwaAj+u7UOIwDTke7mB8wKSGP+JIirVXokfpUF0lExc/allaLo6uJdjCcjbGpydeR/+lHQPjQQVeOnStWiIWNB6nwOkTK7pCcVj82LGAZChma/iB8LPJcFRxyqiuaNygvx+B8d72Et/7GyidA568v0zUINOVYc6JhtDYxsm04/iEQEsYD7mvze12j0n7rnWNJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cQzR11wK+7T3uqSDWpVXDStyYn2sUIHQt/q+miL0BQ=;
 b=BoIQBtCObxoJ+O86p261//gWZs96eAFYU7VU34LSJBAHbV3Zf/WmfTkP2rVyFbiyqPC5N13FIgoLaH/PBWSLlUHT0x37R7/vkBHKz4oxtBWsMZt4UfUh4B0I/ukD4dlo322hs2/GsAH3wDT9xkRdA1JxJ+g/nhGF46wGi7ZW2zD1vV7cBAamJJLj/aUfZcSvKGsv0/Qa0ISRjmc4THtZmFlShLhAqKHjEtadJHhOKXOD9WaxxN4H9owbY6fYErhGD42KtiCUJca0Ux8ua5vNCKvod+HaxyJL5nOECvvWwDSvoN0n9nso+00hA5nXYbPiFcPCiqpmlEe8xa5A2TIfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cQzR11wK+7T3uqSDWpVXDStyYn2sUIHQt/q+miL0BQ=;
 b=gF8j3yXNvYQJhaNcLsDVNp1WM9v0Gf04Y+0sUNo5MrfjsH59LEtrgqVf+wWfB92J3Jq0NVIjTmOQLKvHAgHAtfieXR8QfpXK7B0ZH9/giQkvgPpftoghFTXVgJ97zyuuVrhwBhGhDTWKRtNx2cdW2ykSx6ftHbc0tFOCsygQJV8=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DM4PR21MB3274.namprd21.prod.outlook.com (2603:10b6:8:6a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.2; Fri, 19 Dec 2025 17:35:34 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%3]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 17:35:33 +0000
From: Long Li <longli@microsoft.com>
To: Madhuker Mythri <madhukar.mythri@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "madhuker.mythri@oracle.com"
 <madhuker.mythri@oracle.com>
Subject: RE: [EXTERNAL] [PATCH] net/netvsc: Fix on race condition of multiple
 commands
Thread-Topic: [EXTERNAL] [PATCH] net/netvsc: Fix on race condition of multiple
 commands
Thread-Index: AQHca13fON/7BJ3k7Uq9o8X1sMVdRrUpQRDQ
Date: Fri, 19 Dec 2025 17:35:33 +0000
Message-ID: <DS3PR21MB5735BCEBB4C726C7E0B7AC4DCEA9A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20251212115238.59710-1-madhukar.mythri@gmail.com>
In-Reply-To: <20251212115238.59710-1-madhukar.mythri@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1089bdd4-81b6-43e1-a673-b9246e2cf1b0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-12-19T17:21:23Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DM4PR21MB3274:EE_
x-ms-office365-filtering-correlation-id: fa7b6281-ed42-45fe-94ea-08de3f250389
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?c5ZWiEO52XGwIaVpBsJRldcvTm/DGYuoLKO4xoDdMG3GozDNGkDPbH1jr8z2?=
 =?us-ascii?Q?wPXQD1xpY0JeAsfA8Qo9nxS/mrruYGPf56WJfqA/zfBh3CfGQhbryM7quBOX?=
 =?us-ascii?Q?ZB/RkifuOPfVCqw/bpbtD+FePVUJfNAJQFsp3QyEesBLOgfCAb2trYUGyYzD?=
 =?us-ascii?Q?nuXioNT1Zd+1ZaSd/KiNIGEbyLE7NWQRXUvmNJvFkU/v90EBuIr0Ca2iKgAt?=
 =?us-ascii?Q?1MfRSrfP8Ztvjw/3mhxTiIK8xWVjD9bsRALRvhr3BIaeVtwZNc3J/Te0YRB8?=
 =?us-ascii?Q?6+YiNeS2yllK7Wk++QKlWOee6I9GlOLBOqwPG8J2Pa116aiCyQ1UtGyoY94f?=
 =?us-ascii?Q?i80naACLBPM4yVlJzozkRad08xt0z2W3RK0BEaopiYBexgAqZ7VYhWq5PE+s?=
 =?us-ascii?Q?1Dry0YHvZh5V18mTwNv8mP0dXOgA865tGL4IRM9nHJySuJYiP4QQ5eF/HGzz?=
 =?us-ascii?Q?GgGpV9aH8f43IotPqNsQWzGQoJmw8meBCfCuaoU/MNCq5E/zXTBDaislVBJo?=
 =?us-ascii?Q?Fu8OhGe2qwzaEmA5dEWjZsWQ5dCrFumLSWva9KcOBjsLRBYCmQb742ioNcHh?=
 =?us-ascii?Q?U1sjeraaocrnu3muKBn7zQsfWDw7BL0/U4R4vvH0wn2khDLdAApJdmJPXx4C?=
 =?us-ascii?Q?cUBZI2HX8QgGWDAd6/CAcPGTcJHZ+JIP17k+YJRb922Lzq0KPmpLUXtauHWj?=
 =?us-ascii?Q?gnKCXRZs9JPQ/KMB/mvcxLqfCE4R9fFiqeZGVS7q4KEMfIgkSX9D+vE/uvKH?=
 =?us-ascii?Q?hKOuoP7a2MnDPFc3eAIGNoU+nTHw0+TZEUw8sr4bxTiYRvHxCpasOiiPUr/e?=
 =?us-ascii?Q?LN0bW3F2yhL+iU0HuWrK6Dynn/hSWruXx7X2Ud0bXYwc7Q2oAQVUe7TCmcj5?=
 =?us-ascii?Q?mlhcsW/0VJ4dNrkKDvB6xrUlrsEOe/XUzmDHon5+jBLomUjA2xZGXW2MaEoI?=
 =?us-ascii?Q?omLYK6q3gWSCoHorzFTzlREkSUBajB2YQc02g1eob/zRQXtiC3cf/4IUauhx?=
 =?us-ascii?Q?YtKs+9KLjFbkviwAS3eawyKDVAhZQq/Qi7qF1aKWTZHoMyO/c3gcOSiiRESz?=
 =?us-ascii?Q?xNkZxrERpgQqiYpPWNYt+3gh+i2Ka+v/eYxl2aQgFYdoisf9OHzbxKM05OOX?=
 =?us-ascii?Q?yrbzBWAtTKQZ3PYL7uV6rak6ww+EQorESf9695C1btTZLyO5OiIxKvDP7yIS?=
 =?us-ascii?Q?sPNv6ayrzHow1s2okuIsfZqkU3uQvibJHhGNfv4sde2/GcM6qrOudi1GrdoJ?=
 =?us-ascii?Q?V7BPecwtrODoLTxuf1xTG1SOhrS+TpDyXQAVZAuKCQBuuokAi7srKyaTDGON?=
 =?us-ascii?Q?76NulX8cCd+bFqDxMEKfG/dvcIzpXtjsMMaoAmc1c2kiTNvexi2/69tluj3g?=
 =?us-ascii?Q?J28w4Y7a7LcLH93CM6+01JOa5wr2kmcWzVUKqTzn6svRW3bjxAUTIuVYDxEO?=
 =?us-ascii?Q?ooLJxjH/LNr4en5omJmM0Tsz/ckOCBlH7NHTKsvKRrYuEp7/+qJoOLwwD+6P?=
 =?us-ascii?Q?+6WBzV6oRy3LuiMCmcjaLM3a8NwbdxHnaidM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UmuS9/JzVuo1ErMHKodAhMd2yjxbGBTewNNOrrQ6N1HRXgaVwxBgWqf4l7/i?=
 =?us-ascii?Q?4EdLL8QPuMnOZYW3UPzu/wyWPMOP3V+gn9VJWMDWa6ELWQScYr3Qkrmc3mxB?=
 =?us-ascii?Q?quuvDk5nryi8f/J55ia9zN9f0JLumGM9/xbjkR8+3rfgLiFKbwzTucgYGD5E?=
 =?us-ascii?Q?/kMpKNiulSHtH7aLbW0MvclGgrupfMKWZgFtQrkc7RfUQ776gNnY9s0DJ9cc?=
 =?us-ascii?Q?zflUZfbYVCz8wbwmJ9vdZVx8ipuHeYDM6CVWJuuiTuwhVrA65Lzm4iCnXtsA?=
 =?us-ascii?Q?lMpRxpgiNsjGsFHf+V+CTi7+J7i8I7gORES6ln7YEAnjQ/50HxP7/GfJQANw?=
 =?us-ascii?Q?sz91P7hcMpe8A3qR0RZMxUiXUuXL063OWFk4yia48wHh/MLzEbsLshO6LUgv?=
 =?us-ascii?Q?hn64UAHPL8V7ZoGZxZqv85XZIS9o17Uh4gDxxw4Swtmx7WvjNWBp34pGFPFl?=
 =?us-ascii?Q?ju1kHZsvSDcAte9UbFnSfBpiNWiNPXvm8Ds5CT0fW7UkuJKBuZP65ExMG/H+?=
 =?us-ascii?Q?u/hslZyBHMFlP7LwSlBbxCl+vF6RDzAJ2gUsrzhrAsd4htgE0i7HW5BHXWip?=
 =?us-ascii?Q?4B72NGo41u5/AVwTiGs4SeIB7oMQtPQP8jjUCsXUkK046nDJlj8Pj8RDQ3/M?=
 =?us-ascii?Q?4d0K4tkZF1OM6xu/hdNww6LeQ8k+k3Peukgajol+0UaCbcxYbbdJjJhio+xd?=
 =?us-ascii?Q?nUAWlq7TiWGC0w8HsH+mXKS77dGHUzqYQmipF2Mn1295pV/Q7K3i1rs1X+z7?=
 =?us-ascii?Q?cG2gOl8qYZKv2V8XIXa7n0XlhEZt18RJPtnemiECyNeYt+ZUmVp6VlV7Sgd9?=
 =?us-ascii?Q?FXT8E6BcWpafGUwOaHG2OfhREgTUVFlSeQf/WxAubyx079y0/yQiI/5xebeh?=
 =?us-ascii?Q?ay3n0ARZIAwMof+by7FZc4FWnzA8OpEdamuK0iy7BEFJRf07jDBmCh4mhOCO?=
 =?us-ascii?Q?dugX/vRpyOjlJg/TyZWVjiUQnjrQCPAiU9ZdYp5hjMSuKtJfX4sq9BuEHuRo?=
 =?us-ascii?Q?0u1gSInNOotgxvRMx0PqPBy8f32bYi84hDGV5XF356cumTECzUAlmAhDlQdw?=
 =?us-ascii?Q?NzDXzRPUV93Ix2GkAc89FWpOKYR62PZdqgWMAdHW3GmLCNdgR9x9gXCsJXva?=
 =?us-ascii?Q?Rhi7/qESxF54dpo4LqO9SoVnr0WdOCsOSK2ePgBhNkpUjXErRvtZ1ps2/RwP?=
 =?us-ascii?Q?5uyQifxV19Py8xKYPYBgLquPpfSa9lyzIQ9diBmxXwTrKSJZRpF77UdM5ZSJ?=
 =?us-ascii?Q?mBwYBf9G/CH6S+avTmHgEJTh2tY6CnnmVwfYCtLZm5CY1deok6sB3lw0X86Q?=
 =?us-ascii?Q?M6MkIfIaaxbqYLyhp2hwEtGXEFtCCsLonERNf0tAf7LgIqtS5Ua2MEXzMxKs?=
 =?us-ascii?Q?HVmWfZWd9oNoIBffpZvQHxoPct/9QN26ZlPmXEyPKuO2a6A0nGc3YuGtmX8P?=
 =?us-ascii?Q?y1PCx+kJulrMcScY+bLc+cHCaPZFxbFoS8cR73pPqrzzbXKI7wyiE4tnYWxK?=
 =?us-ascii?Q?9msrPOEsf1RVT25xXKMYVu8It9ZYHGTonU+RB7IuJvwjlLyS2Z3Jz7WeKlJF?=
 =?us-ascii?Q?T+K5bVHHgCPs4uNmdx//X+nfrPeiMvkcu0qbER3EpFP5Omdjxqfxjj/tCjVy?=
 =?us-ascii?Q?foW/kO752YSUH1NriBm2ZujpFGEdfrSCzaIKOTYBQ6hwRkg5sggatPlIitIh?=
 =?us-ascii?Q?0pB+tFO8FPX/w7+WkpfcCduJo+aD3nzIttBvU132r7xSRMYZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7b6281-ed42-45fe-94ea-08de3f250389
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 17:35:33.8506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOz+qSb728xYN+kNq/Chq4spDQpgc05lOJnqMglhstKf5cw3GA7VuPZtlUGOUA58OYnPJPSNlbP5QNbSKY0ERg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3274
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

> When multiple processes issue command requests(like: device info get and
> link-status) at same-time, then we could see the command request failures=
,
> due to race-condition of common function execution.

Hi Madhuker,

I'm not sure if we should use a lock in the driver for this. It's not clear=
 in DPDK documents but in general the calls to query device status are not =
thread safe.

Is it possible that the application uses a lock to sync calling to this?

Thanks,
Long

>=20
> So, to avoid such race-condition introduced a new spin-lock to protect th=
e
> code of critical section.
>=20
> Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
> Signed-off-by: Madhuker Mythri <madhukar.mythri@gmail.com>
> ---
>  drivers/net/netvsc/hn_ethdev.c | 1 +
>  drivers/net/netvsc/hn_rndis.c  | 2 ++
>  drivers/net/netvsc/hn_var.h    | 1 +
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethde=
v.c
> index 6584819f4f..b525e287fa 100644
> --- a/drivers/net/netvsc/hn_ethdev.c
> +++ b/drivers/net/netvsc/hn_ethdev.c
> @@ -1310,6 +1310,7 @@ eth_hn_dev_init(struct rte_eth_dev *eth_dev)
>         PMD_INIT_FUNC_TRACE();
>=20
>         rte_spinlock_init(&hv->hotadd_lock);
> +       rte_spinlock_init(&hv->cmd_lock);
>         LIST_INIT(&hv->hotadd_list);
>=20
>         vmbus =3D container_of(device, struct rte_vmbus_device, device); =
diff --git
> a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.c index
> 7c54eebcef..8a0716df89 100644
> --- a/drivers/net/netvsc/hn_rndis.c
> +++ b/drivers/net/netvsc/hn_rndis.c
> @@ -500,8 +500,10 @@ hn_rndis_query(struct hn_data *hv, uint32_t oid,
>         /* Input data immediately follows RNDIS query. */
>         memcpy(req + 1, idata, idlen);
>=20
> +       rte_spinlock_lock(&hv->cmd_lock);
>         error =3D hn_rndis_execute(hv, rid, req, reqlen,
>                                  comp, comp_len, RNDIS_QUERY_CMPLT);
> +       rte_spinlock_unlock(&hv->cmd_lock);
>=20
>         if (error)
>                 goto done;
> diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h in=
dex
> 17c1d5d07b..66ed186c0a 100644
> --- a/drivers/net/netvsc/hn_var.h
> +++ b/drivers/net/netvsc/hn_var.h
> @@ -179,6 +179,7 @@ struct hn_data {
>         struct vmbus_channel *channels[HN_MAX_CHANNELS];
>=20
>         rte_spinlock_t  hotadd_lock;
> +       rte_spinlock_t  cmd_lock;
>         LIST_HEAD(hotadd_list, hv_hotadd_context) hotadd_list;  };
>=20
> --
> 2.50.1 (Apple Git-155)

