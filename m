Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CF4C0219D
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 22:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3BA4402A0;
	Fri,  7 Feb 2025 23:06:07 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11022081.outbound.protection.outlook.com
 [40.93.195.81]) by mails.dpdk.org (Postfix) with ESMTP id BB01640270;
 Fri,  7 Feb 2025 23:06:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4Lf27r82Jl4+peJDx0EqYpnCG5qkl8x2fEB/D2DAUmWqVPFqre5ovSnBKNFv87xUz57VBoU6wEwDGcvX6c6HrNU/Iv5DynImkfVqwCEjTWNy1u9hxthVx8+VX7mQq+C2UCET1te2bDJ1XcR1461jlN1FHy792Ky08flLvKvLzvXS4yxa0U1KSGWaILblgoy+l7EPs33S7vRLrhyWsqx/Ly9yP+zIhqbuvyGXORFb/JS2wJaA4ddqvV3X1yjUJSMxxxslhPYYpLhDZC18mgl25foZN5kz08Q4etinEsdlw2Ji975Rkzq1n0ziiwQKONsh0rHuoCPgtYVdCYWYoiHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjF3o2rGelv/8GGpt4v5Ijd12mFt2zDOP9yc2nfLvLo=;
 b=lBzsJ+YZv03uxw9IiBsdOHhN39yX/xxbsvynotQ3xEPiZs4fIGGAq2+5RRMhZ6wQTTLHswSmPLIL/PEKpYLGODr4oFIIOwA/coTRRrGWREZU8OorAXdhR+MwmzOwLtwuoCe/rtUB0xpRUjdadaoXRui7kPlC+0Zbm9CtacKZouFWa4HSXS0Z9VJ7xFJT4Wf3BggLpkmvNNFHJcZHjvNUbeGd6VZazWXbXmCoRn8vn+vhuSTEcBo7UDnd1V0L8rhY6rVMdB32P+CaG9n8C4DfhyGB8x/hG3CXNS4hmKO4nLBWxdoUMeFrAavyYEkvljkL/IeVL8+n4KWBNZPNWlUUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjF3o2rGelv/8GGpt4v5Ijd12mFt2zDOP9yc2nfLvLo=;
 b=ZWX83MgBp8xTB1Z0pp/J8fAM670Jy/RJPEBXgYxa49RudZPxpev7oLron+IY8LZh0pnXWy/YegHYJbd8uEH3Dfr4RT8Ayzggbpvagy7yDH8aDEfexCE83Xg+RssWT+NIf/BeF97ntte1H8/jp49Bq216hestWxAKRkSDYatBnUQ=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by CH3PPFBBE5CAB7F.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::185) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.8; Fri, 7 Feb
 2025 22:06:03 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%3]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 22:06:03 +0000
From: Long Li <longli@microsoft.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Wei
 Hu <weh@microsoft.com>, Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 1/4] net/netvsc: scan all net devices under the
 PCI device
Thread-Topic: [EXTERNAL] [PATCH 1/4] net/netvsc: scan all net devices under
 the PCI device
Thread-Index: AQHbcSThGtjiy6otGUmvi5/Bx4qol7M8diGA
Date: Fri, 7 Feb 2025 22:06:03 +0000
Message-ID: <SA6PR21MB42315368828B9851E80B1D0BCEF12@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1738028106-25239-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1738028106-25239-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=11698197-b90f-41c6-b638-dc454d81cb72;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-07T22:04:08Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|CH3PPFBBE5CAB7F:EE_
x-ms-office365-filtering-correlation-id: 96badaac-342e-4736-b9b5-08dd47c39cdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xNGWHJ96xXLeKVm4a6SawIv64PnU2As8gmIHEcQJexf85wv4S4eZlSSPlgjA?=
 =?us-ascii?Q?PV+d1P24KhEO5sWr+MOSrCkhKvUpG8KDNNSc4Uq9OJFeG9kjvkjiZu3JFw7m?=
 =?us-ascii?Q?HC+a794fyU4Gf9IjH0rHAZEa1PogMd9CZB0IvPkjTSUMej/t2HF/FILrnlQN?=
 =?us-ascii?Q?FtdQsCPf+pBPH+T8OhcAi+iAA/JrRs0SR6bfCFEDAP5o1augXUd3EbyBIFZx?=
 =?us-ascii?Q?Q5HZ5EgIiGInmVBfNWUqJL6ZCnX9E4DMtzwHPBPjub/L+xk6r5jBM/HVdoEr?=
 =?us-ascii?Q?zj3SnyVQDsPiiiRi7MeAnR/D44KTcSHiBdGigIGuMee8DFrJGy/qK16puJKS?=
 =?us-ascii?Q?l2XxLzIhGP8U2K8mR2VR8CGHLUOwXYjPcVO1a99eAWg1gAKT+Va0wFaD4S2e?=
 =?us-ascii?Q?OZDCM/N6ldDKNLkvmf8xLmbs+wXcFnEvetbY3BLYWlVVaNX3NKhJFZXvv334?=
 =?us-ascii?Q?Iq4/drsA83SM6UCKPbAMkNDxnk1v8uMd7/Cfz5qZ6v70T5ILVUVyqniEUi2v?=
 =?us-ascii?Q?G2pbuQiTsTwFYnJ9aVkumWgetKHIOtByxK1TjPwjY+8+iYoXrOrvfFxv3B54?=
 =?us-ascii?Q?4i6+FUJD/GA2rqRHRcAkOgRnvW5U7vx9kSwxl8LmlvpCnzqIVSztJZymjsQG?=
 =?us-ascii?Q?EWr0wNPPSc9k2Wp40qNnFOfpIWVAyU00RnhOgz6K7CId+6qxqJ5nEbXt3fVs?=
 =?us-ascii?Q?HjTUwGYYm+Uo9QIR7tuatHxWuaGWKOUd1nXZDRWgWZDX4FOZZ/GhqXq8Tl4T?=
 =?us-ascii?Q?sIq49cZa1WgzGW8Y+7zukP2ScSI9zjegGMvkmhY8WskWhCqwZrULiAFD50vx?=
 =?us-ascii?Q?LCKtiYnA+ZyEETiCoa2Vni6xvLPCKEN58MP+ggR4EjKQny5dRe6hEWvSalVv?=
 =?us-ascii?Q?hwqA0N8cZuYdTSptwCr1OWDcDzlBPRyt07cDH71rfEXz5qKdN2VMX7q3yYBg?=
 =?us-ascii?Q?wXtLgSZpnts6ecul0jOvN3rectClCwVfoDrGEYya/0qt8JyTnRUyolXI3MxT?=
 =?us-ascii?Q?JggtxdAzuAbHPtTZYnSiey3YfTKyVv/xVGK+MeTsO5aJmw1SGZpaEn/3r+k2?=
 =?us-ascii?Q?NRW6Xj1YmR9UBpiB/FJG0sI6Fl8Ekk0pOuv1ventPysGR7TLvHu3/2NAEN+W?=
 =?us-ascii?Q?uXaaIGGeqS4H/HZqZeQ8Na2NPTzjvnnEXRQqGrk+vNhUegoslkIUDQDIcAO0?=
 =?us-ascii?Q?qgMMyOG3yTe2XIOsLnVPNUJ2tP4NASDhtAwg6/qEPl7RrEHPFAPLV6brzsen?=
 =?us-ascii?Q?Z2TvcBikQJ1rwQJRDHCQ+coXAKewkYkuv7bVwicQ6iEpQDo5TT/wrYK2p84N?=
 =?us-ascii?Q?iNO/PW6Dm1q3h1bLkD9sDtqUH4DSgv/463QJa2azFErXd6Bonu8HCAoF6314?=
 =?us-ascii?Q?rknOLgnTgUbR6dHY7kwKrS8Bj+hNe8EfYuQHCvgWc9CXJ3W1vqBnkAVCXaf8?=
 =?us-ascii?Q?ESH0aoDRJu6THcMQ3ry9DFujDh2RpJHh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eoYpMM+3/yiUbkkJS5BvIc/wVO0c1ieZyzPrhVibGDj8jjfw2LE4mUqJ85CJ?=
 =?us-ascii?Q?+lnQVIXFfruIewRhvjhYQc8mxUrLBVNXlhVme8ExzoBt+yNRP0hxgBrUBK5T?=
 =?us-ascii?Q?1QWXkkPaMBD7PFt1/pDB+uxP5fxKk8jW8mtal4HNF+v2Zlf6lJ0n9nMdFJkS?=
 =?us-ascii?Q?86uJ3qvxcG0h9BbdHSFbCxqwyBj/FodSpL+u72RyQYBw7el/rEQ1uB49YyVg?=
 =?us-ascii?Q?TIEAqxw5vwltdiQVnefnCnsCWkYORNxTboSUMnDEAbQ0n1UWAYwlk110Hrv8?=
 =?us-ascii?Q?YbEA0FXyz/lnNqyz2q5V+9NCm7ojkwMDjRTnzvX/Z6AoQ6TI24UsolgeXO8j?=
 =?us-ascii?Q?xZgGL4k4Y+57Mm1FBrHyBp96H5r47MdQlBZczqvHcv9erN3SkwDXpeO+Kceg?=
 =?us-ascii?Q?pE0ASjJ5ML9l9B/QsUG3+uaDCSKzgizv9T54oeTbt6/PUFIa5KXY4BSvQ2Xg?=
 =?us-ascii?Q?6VVMrgrYuln/Pt+kir4l9BPvWqMFzEWD2MzetezXOwnx3gKHNHAsUFFjIh8Z?=
 =?us-ascii?Q?XcoVHn+CyrjWyVNHlAAxr+LwpvJ9i/Zg0Ni1iBi4JrqIBJzrNkF9Nrr+goKJ?=
 =?us-ascii?Q?M8zrCv20c8gvAAbNlZk98/0cx+5gPK0pk8YK72Y2jSieaoeX7drBFyGAk4Y3?=
 =?us-ascii?Q?VbRuegz7gSURWOFgmTWwrqfgYJY+tpKtQBBumhmzrobpMa4xyPqCDAYS+SRI?=
 =?us-ascii?Q?6QYjBvMp3HduSQeO/FydTSBoFQLCGgydaSRBTn+ObgVcbEbxPzQhu1TpuG1E?=
 =?us-ascii?Q?5ICMUl0NKVJgLfbt8mz2CzwbsfEOVNnF0xmQblXfLO69CUuit3r+v9aCU1Y6?=
 =?us-ascii?Q?W3dwCEqy4tBTqwtqqM7Vu0h/48ARTKMwTrtkqgShjmi0RJ6XfRw2cjkkbDvU?=
 =?us-ascii?Q?sgbSJozsXdmDgguICnbAdv37Tkp54XzZr7XVVuyYvIDxNbHveYLigpgauZPj?=
 =?us-ascii?Q?l7fOb1TjxU0cbrhgDzfsCeM0j7+lE5IYUdGLhVJ2Lp4gt7gM40yE541vM47A?=
 =?us-ascii?Q?WOq4mLzhA2WfxWUCEw8mBFDa69Z+T0Yqwv7/jwIDFeWQ5yoQumC9ABPaM5RI?=
 =?us-ascii?Q?yEweNmgKV6XZYtjWeI3J/C5AVsXLfrREWcw9F9xyDVYbZHgAol5zREeM7Byb?=
 =?us-ascii?Q?om4R3YxKowg8oKJmFEJFnSFEImAW3GoVB7RHJzM3soAZAXNpiJGHlWW/SjQS?=
 =?us-ascii?Q?SgSVzVx6wiJVnuaL9+a5KkNbbrfzdhA0SMUkz18lKLU9yUUf9l0JvD5W4tIn?=
 =?us-ascii?Q?/T3Zy/EkjwFKQy+aS5s0UZztkgtjWqK4vH1febueAH5+tb57kJSFX0qJmBxi?=
 =?us-ascii?Q?bd6ixXVKDLRZccsBZqcHvXAq9lU6HDGH33x+t++GdBG6gJSMPA28t3MPea5c?=
 =?us-ascii?Q?K+BXeMuaYrDBqLQ4UIGBB8ZLpBdYt5hdMoZKnOubQoQi1Dwsf3d33oZ5glIW?=
 =?us-ascii?Q?4sBb/9Vb/ZitnrjsWycU774EjIxx0dOvXb2QWZFdyLnGRL+isj1Gg+9sW5fF?=
 =?us-ascii?Q?6msOaMx6QkkB1fkhCUEsYipiTE0/wZOUqZu2UBUgp2GYB5aeF9Wghfo93OkB?=
 =?us-ascii?Q?AUtRS550xWMSmFmeZNo8L/f4UTKBaV+8C5d8yBDMEv5Rp4ocCtok88YcMAw3?=
 =?us-ascii?Q?40/rqjU0p/GShXq3F1jqxbC+nTjejKjtf1usFcc+f2yx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96badaac-342e-4736-b9b5-08dd47c39cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 22:06:03.2013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHDj/Y9Tja6FKuchOxqysRzvYfS5Nl3QvhA/51sbp0emgH/ec0wLOWlTJwHOsxNvzj+LUCXxAlFwUsK8JDzD5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PPFBBE5CAB7F
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

> Subject: [EXTERNAL] [PATCH 1/4] net/netvsc: scan all net devices under th=
e PCI
> device
>=20
> From: Long Li <longli@microsoft.com>
>=20
> The current code has the wrong assumption that a PCI device can have only=
 one
> Ethernet device. This is not correct as a PCI device can be multi functio=
nal and
> have multiple Ethernet devices.
>=20
> Fix this by scanning all the devices under a PCI device.
>=20
> Fixes: a2a23a794b3a ("net/netvsc: support VF device hot add/remove")
> Cc: stable@dpdk.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/net/netvsc/hn_ethdev.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethde=
v.c
> index 1736cb5d07..f848157b49 100644
> --- a/drivers/net/netvsc/hn_ethdev.c
> +++ b/drivers/net/netvsc/hn_ethdev.c
> @@ -570,7 +570,7 @@ static void netvsc_hotplug_retry(void *args)
>  	struct rte_devargs *d =3D &hot_ctx->da;
>  	char buf[256];
>=20
> -	DIR *di;
> +	DIR *di =3D NULL;
>  	struct dirent *dir;
>  	struct ifreq req;
>  	struct rte_ether_addr eth_addr;
> @@ -590,7 +590,9 @@ static void netvsc_hotplug_retry(void *args)
>  	if (!di) {
>  		PMD_DRV_LOG(DEBUG, "%s: can't open directory %s, "
>  			    "retrying in 1 second", __func__, buf);
> -		goto retry;
> +		/* The device is still being initialized, retry after 1 second */
> +		rte_eal_alarm_set(1000000, netvsc_hotplug_retry, hot_ctx);
> +		return;
>  	}
>=20
>  	while ((dir =3D readdir(di))) {
> @@ -614,10 +616,9 @@ static void netvsc_hotplug_retry(void *args)
>  				    dir->d_name);
>  			break;
>  		}
> -		if (req.ifr_hwaddr.sa_family !=3D ARPHRD_ETHER) {
> -			closedir(di);
> -			goto free_hotadd_ctx;
> -		}
> +		if (req.ifr_hwaddr.sa_family !=3D ARPHRD_ETHER)
> +			continue;
> +
>  		memcpy(eth_addr.addr_bytes, req.ifr_hwaddr.sa_data,
>  		       RTE_DIM(eth_addr.addr_bytes));
>=20
> @@ -636,22 +637,16 @@ static void netvsc_hotplug_retry(void *args)
>  				PMD_DRV_LOG(ERR,
>  					    "Failed to add PCI device %s",
>  					    d->name);
> -				break;
>  			}
> +
> +			break;
>  		}
> -		/* When the code reaches here, we either have already added
> -		 * the device, or its MAC address did not match.
> -		 */
> -		closedir(di);
> -		goto free_hotadd_ctx;
>  	}
> -	closedir(di);
> -retry:
> -	/* The device is still being initialized, retry after 1 second */
> -	rte_eal_alarm_set(1000000, netvsc_hotplug_retry, hot_ctx);
> -	return;
>=20
>  free_hotadd_ctx:
> +	if (di)
> +		closedir(di);
> +
>  	rte_spinlock_lock(&hv->hotadd_lock);
>  	LIST_REMOVE(hot_ctx, list);
>  	rte_spinlock_unlock(&hv->hotadd_lock);
> --
> 2.34.1


Hi Stephen, Ferruh

I'm going to work an EAL patch to replace the 4th patch in the series as su=
ggested by Stephen.

Is it okay to merge the first three patches of this series?

Thanks,
Long
