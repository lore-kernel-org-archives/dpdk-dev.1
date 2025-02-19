Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50257C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 12:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B19D440E39;
	Wed, 19 Feb 2025 13:47:16 +0100 (CET)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on2096.outbound.protection.outlook.com [40.107.215.96])
 by mails.dpdk.org (Postfix) with ESMTP id 486F940E12;
 Wed, 19 Feb 2025 13:47:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UY9FtUrhul3XTMcmL+uw39134AoXMu3ohQ+PLNCRNdvl2NEVNsHNk+iLJbn17lCsz22BKwBkKPhWhcfQMEEtfeD6mxaDAIr5EW91A7qhVA686BB1aNrIb82LrKHopXT8JtXQQyZhynKraYNuHPe8bBSPIXoClRlLljiamxF8kR7yvRMP8BWdwJUVQL7dJzilf1U0zYjodnwhOpuUmR96c/FlA8BGDbSXkvs03QtlVjrYTdPhWY3d7QP5haP7lJUJ6e3v83HA3Z4ph0cXhxPZxXeWEhF/Xt4jR5MPvivOuZvSz23+h8yq7bc+o8BUgM1CQIRL+spk/9I8HjEAt4q6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRp/riacURQON6FNF42LH08iQ6UbjtuHRwpD7Q8yDok=;
 b=rgkDoT/LlsCOA0C3fKsbidUB8l+xmo9psYsbSLUjPc53hlMd8C+N+PxO244nlilq4ZDl1d7sFamed4nUh2uBzawgTXIJh5z+CCpOv6KLA54RcqONTAXqV++iV5//SBFsMfBdQObHrp0SMbV7oggnsnERVXUygDoV07Z/DCGqtvJStctPm/kjOx44vSYeJQij4BHNqCJQepx8/glVkAq1L6lXAlZQ/d2fQvAriFEnyAnZkHmpyMZ67MQ3z/yXFKOgmf5o18ZgLeYCpkf7N6XjLLDnV0gdqkt5i55li1Vjv0en4J+4hox73tTQeOebm3XqYjFMrK8ai3g+83vy+moluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRp/riacURQON6FNF42LH08iQ6UbjtuHRwpD7Q8yDok=;
 b=bifVqnyiTNscjjNmwdXeHu0jXMYRyTixk0bSrn9EzoRLXWD3Jkn3mFlVDBrrzLgelb6yABfs0nX1fisGwZmq0ZlBsLbYuPeKtKJUIcpfNp53dt9Li9pwayj+E3VJ66HdllZnmLUyxsTaJk/rUYj/Lo3zA/qjRhcS6oEl/gRT9ng=
Received: from OSQP153MB1307.APCP153.PROD.OUTLOOK.COM (2603:1096:604:373::18)
 by OSQP153MB1229.APCP153.PROD.OUTLOOK.COM (2603:1096:604:372::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 12:47:11 +0000
Received: from OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5b4:898a:d979:93e9]) by OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5b4:898a:d979:93e9%7]) with mapi id 15.20.8466.004; Wed, 19 Feb 2025
 12:47:11 +0000
From: Wei Hu <weh@microsoft.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, Long
 Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [Patch v2] net/mana: use mana_local_data for tracking
 usage data for primary process
Thread-Topic: [EXTERNAL] [Patch v2] net/mana: use mana_local_data for tracking
 usage data for primary process
Thread-Index: AQHbgkgHhb71oHJKPUWSKNTKsoeD9rNOk/Dw
Date: Wed, 19 Feb 2025 12:47:11 +0000
Message-ID: <OSQP153MB1307B222A37066A4D6746147BBC52@OSQP153MB1307.APCP153.PROD.OUTLOOK.COM>
References: <1739912366-6052-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1739912366-6052-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b9b9ef4b-41d6-4202-afb8-68f401578298;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-19T12:46:09Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQP153MB1307:EE_|OSQP153MB1229:EE_
x-ms-office365-filtering-correlation-id: 1f5d447c-75f2-44e0-4134-08dd50e3871a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KxBGse5iurkpTFmngLWcvlmlJGfJedXpDzR1w9FCA82eES0G9ig+84agFj4B?=
 =?us-ascii?Q?qM8vANTIASjSGEYw89gBF7D+zGByHwHDFTfFCWr8ks0pp7LgRda0tPFHk8LE?=
 =?us-ascii?Q?quUmceHshY4f/37+qKIAogVFWxIrCY+79dzxtfRllMZ/QSdJN2wBFsh7nsVD?=
 =?us-ascii?Q?TM4IfHPalLDLG6AEmD6maHaTCbhRgJobsY02wlNCJruCwxYvvIfprEvvoYSM?=
 =?us-ascii?Q?ux2Y14YPxZLZDiA/HPseRiLQyCeLba22VFRs1paRCzpYmA+QBTyme2tFk9Xp?=
 =?us-ascii?Q?6JQisvAqwhRx9/EMCBbwWLXB6aEIQX0fQubyB6LdQAhaHsT+zW2fSfImvPDX?=
 =?us-ascii?Q?SWM6Xnb8Xn6tgrf6yZyPMkeoUpWpbjbsl7fU5hf4RM/jWMAZHMy2ffIeTkRS?=
 =?us-ascii?Q?kEeka+nsJ8TA2/0CimCWt4jaQ9LWY2PbLC3d6w8yNpYGZT391tIGJ6VGzwTC?=
 =?us-ascii?Q?TX6H5aN3juia98Wk0ZptdVr+pFCEdcjL097yfyEj0kUWwmTwkGrO95BZQf/I?=
 =?us-ascii?Q?bq00uBmhcaJfuDUInUkxy+VNxgH3JmD2My4i8YcEiDwc+Hxhbi/10JxEoLtH?=
 =?us-ascii?Q?iWjO65DZt5ncNV/V0PnU9Rnlz0gSZxb54aLr1amd1YBk+uFIgH3OtYD0KTSI?=
 =?us-ascii?Q?E0pVmgCdLG1IqLWnAqw4nzcg4ukw/56X9lMiL1bcjvlurOiR8pka0BTiHJjC?=
 =?us-ascii?Q?2R9qnzfWmL1SUYUFN8jYmYW1/AUiVq4cC1P9BqD9ohi73Y8fILgt4Of14Pfk?=
 =?us-ascii?Q?eSPYWMHCthi8yw1elNaKG7Awmr0sgcN8YOHI3WKZBDyLv5w7a5cG66RewPZd?=
 =?us-ascii?Q?HhU5f1/vlWwDeEgzmUsNfgAyFKR6kyBb1eVHVs/oSvdo+C1j6qMsMKuVNH+d?=
 =?us-ascii?Q?uyoW13IVq/wEdmMOL3NIGLcmaZr88UPWI9YnbS76CHndsE2WK9pb/9sBVD/e?=
 =?us-ascii?Q?QWY2rAmVlFAxqHGdrvMSMYIjUw/eho9TY0RtmLwsBJuc1Q3h+yQQryy/VtN7?=
 =?us-ascii?Q?SjjrKLPVAOr1v599qI/VRM8dC4gJB3gmgyi8/RjAEUrHWxOLl/c0X+Nw+rPf?=
 =?us-ascii?Q?mGZL+ZqbHWifJmWafiirVBrCAAXNUoV6V0ooB56AktaPEc6f4iweYQ+afLk/?=
 =?us-ascii?Q?Z98vnzj1QRnEtC0LMHVhuGBx5BXjzwVZkoxBS22pQ1ByRdZOJtZybXdSB6jS?=
 =?us-ascii?Q?c7kfCWOR89rwJpUI8unmpTiDSTwfHo69toT4igbOv8JEY8jkkT6zumoqKMAs?=
 =?us-ascii?Q?OO1SzqfU39ZO5wbKq+kQacj54Oiv5b4qDegzcMkDUSGQVz+8yIwg3xoRHRcy?=
 =?us-ascii?Q?If84ry+2o96pHGx5NkcV1UkHxURekvuWbC6nudjb5tWWZMQbudjgkv99hTSG?=
 =?us-ascii?Q?PFLzLT70DXvk7VFp7cAWH7Y+RvnGfXA2HpbBW7mexhfTCiR4ocJHGiCLral6?=
 =?us-ascii?Q?2dvQ7R9wSrtSN9FHDEJ5hgB2beBmiSx9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSQP153MB1307.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7053199007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w24bJKin8ZjWqwoGh+Stkf8teZ02OgysNNzXy9LcieD28m75ibzswtiSWcSM?=
 =?us-ascii?Q?9GW8fVN/+Z9tsBsRW0bjCGmXMt785wf5EiAHsFjDUFeBgPeNMcCVRVPePrs8?=
 =?us-ascii?Q?52AwoSqy/bP1xK+9nWtg5ISzwYm7g4x8/6ptMr9L3mQkKRokyAqWCEOb2bGG?=
 =?us-ascii?Q?cRIs7wYE5RXX5AhEcfR+o6Ztfqy7OW8kIqjpLPiEA7U0mHFuosr2xS59Uj+V?=
 =?us-ascii?Q?kMEbU3nanWc55OMVzbBekn4Z/TkTInVbhpGs6RuDkCKLhVy581LAP8XntarQ?=
 =?us-ascii?Q?DjDdNd1GYmu0cbLKRWUulxRaRjg7SMwCfcVT1GRqRzayIS/KRmX5aTwFK3rM?=
 =?us-ascii?Q?YSV12D41E++XTg8GeIwlou1pbgj4YrQM15G3PsEd60VUaGYBHpfHlVTmbeke?=
 =?us-ascii?Q?Tk4zDrGXSHXBdM4UDcgQW/wfjq+pcgFOwl+lcqBa5rEXi2wcn5Wxk3qwfH2N?=
 =?us-ascii?Q?rlTv8g77alzEQJZ7wNrsgdnwNAyvHBOjNHVAahvX9sTHEYkdpHIvRGIFxHxh?=
 =?us-ascii?Q?jh/IJaBR+0oIqiGeCJspSmks8jha5m6RHt/VYKUmOKtYCwF0xMY5ICYBlwmh?=
 =?us-ascii?Q?S5TV/b698fHW7FduMbtl5nqpXinlKtLcAnPNdNAStB2VnAZkCVQ/vBBCGou9?=
 =?us-ascii?Q?8aVbgCz76WoiZzCCjt0EvXHA5+dVpKiw7Q/CrPg7PNtg+BDox29VNOf/jAQ8?=
 =?us-ascii?Q?4E7LnF8m6fZJRZn8e2klUvjy/YgHEWUfH9R6whtMVgkJ+AFkEwgb6WNmx4L8?=
 =?us-ascii?Q?FCzwwyjgLJJ9bnP33+3h66LyraJPq/I9Pk2yAReK++OE4Ovuqv3wFLlthM8T?=
 =?us-ascii?Q?Irw2JVpr12rq8fwt4ZJzKBLR9u+riWyzuVl8SejUUfLKuRQFzOVCNVTypliI?=
 =?us-ascii?Q?ZAWcXtAtFgKKMhHqcKvKsX3XuaXqQd55fQrxW1Ewg2u0IQygwBmzLSaBttTG?=
 =?us-ascii?Q?EGR1bCSaYa59Qd47tNtGKy4K7OEjlttFVoITIUAmXTSB41xpDMJxU7aiRmkC?=
 =?us-ascii?Q?9a/boA0pZUggsdLqZ6jnoEmQHfp41EvLwZHuM1lJkr6vPIvIDJgu1PLb+jhp?=
 =?us-ascii?Q?c+zqHI5DQDXReX9IWLWBjcIAW6dnYpBb7A9W/NAX5gtenBKJDrtHy/K20uEh?=
 =?us-ascii?Q?EoI5ylUOLjGkNAeYm37vxlOyFu4bvjwPYA6/EXviKPc33l/P2YNBmdIiMWa+?=
 =?us-ascii?Q?qSFcbEOV1Omr9Q68ZTaY292veh6r72OC10jJg7UKJZ7mT+H7FwK8tgqvDtDE?=
 =?us-ascii?Q?wS+vcJLY7RPtIB/g3weYFhl4T+rtKbM0PHBujG79Ejvw3u02NbXBKbgvzrdn?=
 =?us-ascii?Q?4s6PrG858FDD5BYInZYCJvUJtWJfIzoLlEakLgHdFVuhyFsNobxiAS24hWKw?=
 =?us-ascii?Q?siSdbyG9FbIQbbQ41W2ZrL2+WjfO3a+Wloj8OYBtv1EnoZ2gAojpIUdEw2JU?=
 =?us-ascii?Q?8m0BY5Tb7aKx5/NxtpNGy4I+8/jM3vwgvqZjLLr+lVs887Aurn5kEe3wi19q?=
 =?us-ascii?Q?lpdCt8O+r+GQKuggHbTY5VCtUdTLkMMmizPiGZMlubOcRZ+h/9u7JBgq0gV5?=
 =?us-ascii?Q?e5Mcj1rgLRnMpo47A9k17U1rBf5SnNgMCFOgPdUR/23x09w/VeeMrvme4o4z?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5d447c-75f2-44e0-4134-08dd50e3871a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 12:47:11.0379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwPXXgerxe7KJn0z/KZ0+/4JavTZtgNPxsL2/N0aSMMNGYWQe2j/GQMCIOBlX2ynEXXUFPr5aLlqjTXHcUR71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQP153MB1229
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
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> Sent: Wednesday, February 19, 2025 4:59 AM
> To: Stephen Hemminger <stephen@networkplumber.org>; Wei Hu
> <weh@microsoft.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Long Li <longli@microsoft.com>
> Subject: [EXTERNAL] [Patch v2] net/mana: use mana_local_data for tracking
> usage data for primary process
>=20
> From: Long Li <longli@microsoft.com>
>=20
> The driver uses mana_shared_data for tracking usage count for primary
> process. This is not correct as the mana_shared_data is allocated by the
> primary and is meant to track usage of secondary process by the primary
> process. And it creates a race condition when the device is removed becau=
se
> the counter is no longer available if this shared memory is freed.
>=20
> Move the usage count tracking to mana_local_data and fix the race conditi=
on
> in mana_pci_remove().
>=20
> Fixes: 517ed6e2d590 ("net/mana: add basic driver with build environment")
> Signed-off-by: Long Li <longli@microsoft.com>

Reviewed-by: Wei Hu <weh@linux.microsoft.com>

> ---
> Changes:
> v2: use atomic variable to track the secondary_cnt in shared memory, remo=
ve
> the spinlock for shared memory
>=20
>  drivers/net/mana/mana.c | 99 +++++++++++++++++++++++------------------
>  drivers/net/mana/mana.h |  6 +--
>  drivers/net/mana/mp.c   |  2 +-
>  3 files changed, 57 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c index
> c37c4e3444..69cb7ab13f 100644
> --- a/drivers/net/mana/mana.c
> +++ b/drivers/net/mana/mana.c
> @@ -23,9 +23,14 @@
>  #include "mana.h"
>=20
>  /* Shared memory between primary/secondary processes, per driver */
> -/* Data to track primary/secondary usage */  struct mana_shared_data
> *mana_shared_data; -static struct mana_shared_data mana_local_data;
> +
> +/* Local data to track device instance usage for primary/secondary
> +processes */ static struct mana_local_data {
> +	int init_done;
> +	unsigned int primary_cnt;
> +	unsigned int secondary_cnt;
> +} mana_local_data;
>=20
>  /* The memory region for the above data */  static const struct rte_memz=
one
> *mana_shared_mz; @@ -1167,8 +1172,12 @@
> mana_init_shared_data(void)
>  	rte_spinlock_lock(&mana_shared_data_lock);
>=20
>  	/* Skip if shared data is already initialized */
> -	if (mana_shared_data)
> +	if (mana_shared_data) {
> +		DRV_LOG(INFO, "shared data is already initialized");
>  		goto exit;
> +	}
> +
> +	memset(&mana_local_data, 0, sizeof(mana_local_data));
>=20
>  	if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
>  		mana_shared_mz =3D
> rte_memzone_reserve(MZ_MANA_SHARED_DATA,
> @@ -1181,8 +1190,7 @@ mana_init_shared_data(void)
>  		}
>=20
>  		mana_shared_data =3D mana_shared_mz->addr;
> -		memset(mana_shared_data, 0, sizeof(*mana_shared_data));
> -		rte_spinlock_init(&mana_shared_data->lock);
> +		rte_atomic32_set(&mana_shared_data->secondary_cnt, 0);
>  	} else {
>  		secondary_mz =3D
> rte_memzone_lookup(MZ_MANA_SHARED_DATA);
>  		if (!secondary_mz) {
> @@ -1192,7 +1200,6 @@ mana_init_shared_data(void)
>  		}
>=20
>  		mana_shared_data =3D secondary_mz->addr;
> -		memset(&mana_local_data, 0, sizeof(mana_local_data));
>  	}
>=20
>  exit:
> @@ -1213,11 +1220,11 @@ mana_init_once(void)
>  	if (ret)
>  		return ret;
>=20
> -	rte_spinlock_lock(&mana_shared_data->lock);
> +	rte_spinlock_lock(&mana_shared_data_lock);
>=20
>  	switch (rte_eal_process_type()) {
>  	case RTE_PROC_PRIMARY:
> -		if (mana_shared_data->init_done)
> +		if (mana_local_data.init_done)
>  			break;
>=20
>  		ret =3D mana_mp_init_primary();
> @@ -1225,7 +1232,7 @@ mana_init_once(void)
>  			break;
>  		DRV_LOG(ERR, "MP INIT PRIMARY");
>=20
> -		mana_shared_data->init_done =3D 1;
> +		mana_local_data.init_done =3D 1;
>  		break;
>=20
>  	case RTE_PROC_SECONDARY:
> @@ -1248,7 +1255,7 @@ mana_init_once(void)
>  		break;
>  	}
>=20
> -	rte_spinlock_unlock(&mana_shared_data->lock);
> +	rte_spinlock_unlock(&mana_shared_data_lock);
>=20
>  	return ret;
>  }
> @@ -1319,11 +1326,6 @@ mana_probe_port(struct ibv_device *ibdev,
> struct ibv_device_attr_ex *dev_attr,
>  		eth_dev->tx_pkt_burst =3D mana_tx_burst;
>  		eth_dev->rx_pkt_burst =3D mana_rx_burst;
>=20
> -		rte_spinlock_lock(&mana_shared_data->lock);
> -		mana_shared_data->secondary_cnt++;
> -		mana_local_data.secondary_cnt++;
> -		rte_spinlock_unlock(&mana_shared_data->lock);
> -
>  		rte_eth_copy_pci_info(eth_dev, pci_dev);
>  		rte_eth_dev_probing_finish(eth_dev);
>=20
> @@ -1406,10 +1408,6 @@ mana_probe_port(struct ibv_device *ibdev,
> struct ibv_device_attr_ex *dev_attr,
>  		goto failed;
>  	}
>=20
> -	rte_spinlock_lock(&mana_shared_data->lock);
> -	mana_shared_data->primary_cnt++;
> -	rte_spinlock_unlock(&mana_shared_data->lock);
> -
>  	eth_dev->device =3D &pci_dev->device;
>=20
>  	DRV_LOG(INFO, "device %s at port %u", name, eth_dev->data-
> >port_id); @@ -1552,13 +1550,37 @@ mana_pci_probe(struct rte_pci_driver
> *pci_drv __rte_unused,
>  		count =3D mana_pci_probe_mac(pci_dev, NULL);
>  	}
>=20
> +	/* If no device is found, clean up resources if this is the last one
> +*/
>  	if (!count) {
> -		rte_memzone_free(mana_shared_mz);
> -		mana_shared_mz =3D NULL;
> -		ret =3D -ENODEV;
> +		rte_spinlock_lock(&mana_shared_data_lock);
> +		if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> +			if (!mana_local_data.primary_cnt) {
> +				mana_mp_uninit_primary();
> +				rte_memzone_free(mana_shared_mz);
> +				mana_shared_mz =3D NULL;
> +				mana_shared_data =3D NULL;
> +			}
> +		} else {
> +			if (!mana_local_data.secondary_cnt) {
> +				mana_mp_uninit_secondary();
> +				mana_shared_data =3D NULL;
> +			}
> +		}
> +		rte_spinlock_unlock(&mana_shared_data_lock);
> +		return -ENODEV;
>  	}
>=20
> -	return ret;
> +	/* At least one eth_dev is probed, increase counter for shared data */
> +	rte_spinlock_lock(&mana_shared_data_lock);
> +	if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> +		mana_local_data.primary_cnt++;
> +	} else {
> +		rte_atomic32_inc(&mana_shared_data->secondary_cnt);
> +		mana_local_data.secondary_cnt++;
> +	}
> +	rte_spinlock_unlock(&mana_shared_data_lock);
> +
> +	return 0;
>  }
>=20
>  static int
> @@ -1573,45 +1595,34 @@ mana_dev_uninit(struct rte_eth_dev *dev)
> static int  mana_pci_remove(struct rte_pci_device *pci_dev)  {
> +	rte_spinlock_lock(&mana_shared_data_lock);
>  	if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> -		rte_spinlock_lock(&mana_shared_data_lock);
> -
> -		rte_spinlock_lock(&mana_shared_data->lock);
> +		RTE_VERIFY(mana_local_data.primary_cnt > 0);
> +		mana_local_data.primary_cnt--;
>=20
> -		RTE_VERIFY(mana_shared_data->primary_cnt > 0);
> -		mana_shared_data->primary_cnt--;
> -		if (!mana_shared_data->primary_cnt) {
> +		if (!mana_local_data.primary_cnt) {
>  			DRV_LOG(DEBUG, "mp uninit primary");
>  			mana_mp_uninit_primary();
> -		}
> -
> -		rte_spinlock_unlock(&mana_shared_data->lock);
>=20
> -		/* Also free the shared memory if this is the last */
> -		if (!mana_shared_data->primary_cnt) {
> +			/* Also free the shared memory if this is the last */
>  			DRV_LOG(DEBUG, "free shared memezone data");
>  			rte_memzone_free(mana_shared_mz);
>  			mana_shared_mz =3D NULL;
> +			mana_shared_data =3D NULL;
>  		}
> -
> -		rte_spinlock_unlock(&mana_shared_data_lock);
>  	} else {
> -		rte_spinlock_lock(&mana_shared_data_lock);
> -
> -		rte_spinlock_lock(&mana_shared_data->lock);
> -		RTE_VERIFY(mana_shared_data->secondary_cnt > 0);
> -		mana_shared_data->secondary_cnt--;
> -		rte_spinlock_unlock(&mana_shared_data->lock);
> +		rte_atomic32_dec(&mana_shared_data->secondary_cnt);
> +		RTE_VERIFY(rte_atomic32_read(&mana_shared_data-
> >secondary_cnt) >=3D 0);
>=20
>  		RTE_VERIFY(mana_local_data.secondary_cnt > 0);
>  		mana_local_data.secondary_cnt--;
>  		if (!mana_local_data.secondary_cnt) {
>  			DRV_LOG(DEBUG, "mp uninit secondary");
>  			mana_mp_uninit_secondary();
> +			mana_shared_data =3D NULL;
>  		}
> -
> -		rte_spinlock_unlock(&mana_shared_data_lock);
>  	}
> +	rte_spinlock_unlock(&mana_shared_data_lock);
>=20
>  	return rte_eth_dev_pci_generic_remove(pci_dev,
> mana_dev_uninit);  } diff --git a/drivers/net/mana/mana.h
> b/drivers/net/mana/mana.h index 41a0ca6dfe..b60b1f1977 100644
> --- a/drivers/net/mana/mana.h
> +++ b/drivers/net/mana/mana.h
> @@ -8,12 +8,8 @@
>  #define	PCI_VENDOR_ID_MICROSOFT		0x1414
>  #define PCI_DEVICE_ID_MICROSOFT_MANA	0x00ba
>=20
> -/* Shared data between primary/secondary processes */  struct
> mana_shared_data {
> -	rte_spinlock_t lock;
> -	int init_done;
> -	unsigned int primary_cnt;
> -	unsigned int secondary_cnt;
> +	rte_atomic32_t secondary_cnt;
>  };
>=20
>  #define MANA_MAX_MTU	9000
> diff --git a/drivers/net/mana/mp.c b/drivers/net/mana/mp.c index
> 34b45ed832..e7eecfcc30 100644
> --- a/drivers/net/mana/mp.c
> +++ b/drivers/net/mana/mp.c
> @@ -306,7 +306,7 @@ mana_mp_req_on_rxtx(struct rte_eth_dev *dev,
> enum mana_mp_req_type type)
>  		return;
>  	}
>=20
> -	if (!mana_shared_data->secondary_cnt)
> +	if (rte_atomic32_read(&mana_shared_data->secondary_cnt) <=3D 0)
>  		return;
>=20
>  	mp_init_msg(&mp_req, type, dev->data->port_id);
> --
> 2.34.1

