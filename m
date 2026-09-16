Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477D1C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:53:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F94940DCF;
	Wed, 16 Sep 2026 08:53:04 +0200 (CEST)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022091.outbound.protection.outlook.com [52.101.126.91])
 by mails.dpdk.org (Postfix) with ESMTP id A53DB40265
 for <dev@dpdk.org>; Wed, 16 Sep 2026 08:53:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLQcajbua1rJu+ia3Yl/SstqWa/5y11QPt/Let+KpohxFwlQn62C+fzGnzro+iN02HpLCjcphbMWCVlgeKw7ITiHXz64bRmyeqJuLPYcBno5k4tthHSeEFDhkSq8Sd4uAbtOQIRtX6E7ExzQA2BWsmOqlbsISUC0G7KXfjRl5oYvsST+ai30VavhStPlGSc5LsmXROVpda13v9qFEMB43GgbLXuag6ESG89tvwpvMdf9T8gVCUuG4d7WOkKTivWi+/b7pnL/dG4vaN5qQVAag/9lSp6wF2vOlAaHz2CfsvyW7Thwb80lUI6M0LoweMMacNSICfVH7AonqI6GJ0fmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=kS2ft36CVykfUnuYs9Ix2zI9S+PZneGxbMxl9MjK7ww=;
 b=Wvba8JPWte9izRvvsW2xt2Uu9/4pRzz74/5YwuKzSa5Jy2nNAD5tcLlhJT5xtUAcYMgk1yvkqGcVQOK9plz8vMCOc3B8DayVwqkFE1vscg/3KNCWgcV4lGKSzmPRNKEgvbBQYxHwOSsO6zPBOaU9pbikjAr4gayAl8y4Wujmujct9dvZKNifZYnMzpPKT4yT+jDRImGdB0UENzvvQYOSy6h3/1+J/WKmgsCKb2WK4DhfZo3SKTf7qwsdWKJ3jnwy1z05gu+l5ZCWTt9CwSlbTiTxIYq+7VoCZQQDwaNZvwYvfv9dSPFh47+5omTYt4NpZg7NcPwX0Yr+0/a3KJii7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS2ft36CVykfUnuYs9Ix2zI9S+PZneGxbMxl9MjK7ww=;
 b=jkZaQEHaeTEaFMetlqgkNgGrBdleQ9TxWJINYqEtZWez7WfjDAZRw9I+xb9VD7kH5v2wFZZkqwH1bSLXfrYM7b3iY67mJlYjBROnet2Dtaoq9znq4KDhxoOnwOUemOehd1TKewCezhd2jpLCrRZjaE3MNm1LdUZKvZCpOCFigh8=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by KUXP153MB2210.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:6d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.4; Wed, 16 Sep
 2026 06:52:57 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%6]) with mapi id 15.21.0451.003; Wed, 16 Sep 2026
 06:52:57 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v3 4/9] bus/vmbus: use common sysfs routines
Thread-Topic: [EXTERNAL] [PATCH v3 4/9] bus/vmbus: use common sysfs routines
Thread-Index: AQHdRG+7eMANnmiRcEmt8N3/mfRht7bQuXXA
Date: Wed, 16 Sep 2026 06:52:57 +0000
Message-ID: <SE3P153MB18480815AC50DA21CB033D5FBBB92@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260914173700.2795983-1-stephen@networkplumber.org>
 <20260914173700.2795983-5-stephen@networkplumber.org>
In-Reply-To: <20260914173700.2795983-5-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7ae0a79a-5e31-4fcd-94ef-3604927899b9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-16T06:03:59Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|KUXP153MB2210:EE_
x-ms-office365-filtering-correlation-id: 620e3c4f-7d22-4e45-b681-08df13bf240c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|42112799006|10067099003|11063799006|56012099006|7146999003|38070700021|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: DxPmXqY9IA0U83MFXhHZxqIdUBh67DPW6QO46JR7qb0Z6TaPSnuJespmNNJULZ+GxXjacp81VCIXZIRmiPV20qxGMcrWdJwPrUZ7IhmrcWAbzJ2pgFQjS+rdxnsCQ3r8Iz3rUtxbCmYV9827G8CkaOYiylks25TfJy1Q7ycQKkqoaNcnxTQYDW7t7dG20GJmoV5BfAVMg6aGLndofwg1pS0Y/zv3q+MJ+aiyE0G9ToYVO+Xp/MOUfqmRx1KRS+Eo2N83rgCHCScFYNW0kPGM/zmpe/1y40+zo+GP82pobO3f8D4HWIyxyG01S83H2oJSteMhc+ihYIxWTBg1xgid7Uqat4KGu1Lo48yKdknPXg1Klyex2LiIYo3ZsBNre40OK60Y7AWc25tHlwh3Lcn16HW/ttjRQN/YDxN0eGwoJNnFj/dOQO0a5KwyiVwsFzMVlRJWyug0Ib1LAQRc7FnBajx2hFGIjWYLxwGiiCeXp0EsSHVB6eIHmuOo0IRIzTF/A0FLVMetdgFdye3iHXCR3JsX03G09nPvcaGIIMeVnyH1v0ouWdsgkM2ty0ihVtwT+3C+oYfO+k4xqvA8zLtfT66m3wLupxKkdYiR0sUAxPGaSla+jjfheToISmsBCQaa1zSTGYDh3umvXk8MJyEjfhjTan9o4dWOGTJz8mvuf6dvrXueMre8tS5dg4a6c2NbL/SxjoMUbi9fSnU5mL6Ohxf9MvNpbHw0xLFML/Nr+jA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(42112799006)(10067099003)(11063799006)(56012099006)(7146999003)(38070700021)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lEDohj6kUts40BeH5DwFjZIu0szSLsQl+Q4E9oa6d6CcbeUHUwnorlbOCZN3?=
 =?us-ascii?Q?IAqcFb5tBn87PLp5tQrctiQKsKX5bUnZfsPAHZ4zkBhGpZMb8YNV/w/3qh4M?=
 =?us-ascii?Q?5l3u83B/Zlr0WocC7k7lqxE5pbsmGHiGOOxl1N6tOklk1eJkPH+EsPJ+QlwI?=
 =?us-ascii?Q?RVFn3C/NpUdhAe9CkgcFxbyRe8GEmmjf1lpSTlh2FM6hWoR81kH1S4vVmuEF?=
 =?us-ascii?Q?vzLCMc4bQP30QziKNAu4NKOnKwkc7mZqWrB/CdvHaEJ8oA4pzsVzlthJ/uwj?=
 =?us-ascii?Q?1mjwhpfaYgDm6y3mMOpNcZwKLSo9FUEGqd5Yk/neIxb4Ih0fPj0TeqFEG4S7?=
 =?us-ascii?Q?bpY2Z29I+aqV8/hvv0LJ9bqnUmnDe28Ut2Z6AYTf9b7F6V1IaMP4Jkgmz8Rx?=
 =?us-ascii?Q?URNDrPfX19mCJdil158+WPO/tKJhBxgqwbCZ9zPk7O40VI4/2bLtTO/hfmY6?=
 =?us-ascii?Q?2JfCHtZfXfdISbLIVnXLtMhBQyBdadK+2gNyHE9Ri13khKoqmsG7c+yqEfjx?=
 =?us-ascii?Q?/rZ7Mrwimiq4/TqswrHdo1IFS6UMRxlHsGaD9hM4+CsqtXPEM1qOlVBaWUpv?=
 =?us-ascii?Q?hnrKy5xuVvodb3yiVxHo7NBIMjD2DPMC1p44a3C7D8YYRVjm6Tiyg1RsdSbT?=
 =?us-ascii?Q?RSVOfqOT/IU1XXqnKAZqaXNsZosD67VrxWSeVQJeJtL0NZgkOgiM9Z+5iAhy?=
 =?us-ascii?Q?FpW0wcHkDiPqhjG8AEvaGQaSEox35ccabxn8msRf/v+vsgD0sLBiz++hBVDv?=
 =?us-ascii?Q?PRXK2vTfYWYG+fxIffmbEQ2fnf6TX7M7t0xElrM0a/QvYgP8WuWolmHqyL2J?=
 =?us-ascii?Q?+m2nw+GT2czQ80BOypF42UuJyiTVSfeNrzgvzSjSRl8LeDA3dPy09ggVW5L+?=
 =?us-ascii?Q?lc3WxSr/n/P3t60e9F13qRQL+zdqOB9lIQlE5wj1nCtrJFeX1UOy69Lspb25?=
 =?us-ascii?Q?+saKUn721LlpzrSBppHbL9lIqSeUTCEfgT07d7OnKNfwwIjC6DgDV4lqYvNd?=
 =?us-ascii?Q?IIXhFAVDhhZU92FzhoNmjTp3UgAWY7Jd89ZXE7WMV5bRnJSpdNE8xl724RBo?=
 =?us-ascii?Q?U5uLt+fM7tLfF4kGf9q1PtlnLdplvvt0/POTLC/2y1soQCaqK4ShgtTg8+oE?=
 =?us-ascii?Q?d56pRH7Js97cGCJ5Fhi8ZeyoBR3JPbU0OalNhbWQGPNzTamYH5zwOak6QrJF?=
 =?us-ascii?Q?DE/dXAJIItO3S4/ScfIgxqzdCBBus5k6jh2BNLOnEN8SMKFVsliEmG1FjrRP?=
 =?us-ascii?Q?pERq3lbVoGVAeRdRzrCx4TRRC9wHV7XEwGSGd6NoHC/E7idd2sl6EDvPnyDE?=
 =?us-ascii?Q?XeTtRQtIEtPX/6QynV2FCY8adF1KIV9feDssEM9s1yyEAavnUckkqYrhzHsR?=
 =?us-ascii?Q?2IgZhEkPRy7BCSyD0i0NAG3nMjI7HgrbCPCRua9OTXTutLGSYbD/y++tjpca?=
 =?us-ascii?Q?7auvfMa/Xq8FAKPYHrLl31YTTLU1UgmIdoHwSFH0sBn9g5wiwmNrvFX18fJ4?=
 =?us-ascii?Q?pWya6Gjr+Akh2mxbJUIjeA0zbELnuFbJknhGDbl+jbNsFKycsK7xugA5D5bC?=
 =?us-ascii?Q?qK3jqsPh4RtMsp7US9S1p8hakE99HiuMRJaNCP51TcpoLj3Y2v2Ck2RA+ZaW?=
 =?us-ascii?Q?113nMpmkd3jesK+SLHvw6Lyf8qRxOhKvduBW6bZE+pCrBomKjgT4SSJd1Sx1?=
 =?us-ascii?Q?zyRDU3svdbn/yJJujgOSqp4KJGdEoJ6JHmFzMUM9Vdwtu5Sy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 620e3c4f-7d22-4e45-b681-08df13bf240c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 06:52:57.4198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jabt0Pv4PoPrguRKJfK2+hVN6G+dOqhcPK2+gulCSV+ZBP4e/PCtjQE+Z83HEqjaNSMSZ6KWWIXPjNUGxADXQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXP153MB2210
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, September 15, 2026 1:36 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Long Li
> <longli@microsoft.com>; Wei Hu <weh@microsoft.com>
> Subject: [EXTERNAL] [PATCH v3 4/9] bus/vmbus: use common sysfs routines
>=20
> Replace the open coded read in vmbus_uio_sysfs_read() with the EAL routin=
e.
> The range check and the -ERANGE return are unchanged.
>=20
> Two things do change. On an open failure the helper now returns -EIO rath=
er
> than -errno; both callers only pass it to strerror(-err) in a log message=
, so this is
> message text only. And subchannel_id and monitor_id were read with
> fscanf("%u") and are now converted with base 0, so a value with a leading
> zero would parse as octal. Neither attribute is printed with leading zero=
s by the
> kernel.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Wei Hu <weh@microsoft.com>

> ---
>  drivers/bus/vmbus/linux/vmbus_uio.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/bus/vmbus/linux/vmbus_uio.c
> b/drivers/bus/vmbus/linux/vmbus_uio.c
> index fbafc5027d..50e58f9b65 100644
> --- a/drivers/bus/vmbus/linux/vmbus_uio.c
> +++ b/drivers/bus/vmbus/linux/vmbus_uio.c
> @@ -18,6 +18,7 @@
>  #include <rte_malloc.h>
>  #include <rte_bus_vmbus.h>
>  #include <rte_string_fns.h>
> +#include <rte_sysfs.h>
>=20
>  #include "private.h"
>=20
> @@ -334,27 +335,12 @@ int vmbus_uio_map_rings(struct vmbus_channel
> *chan)  static int vmbus_uio_sysfs_read(const char *dir, const char *name=
,
>  				unsigned long *val, unsigned long max_range)
> {
> -	char path[PATH_MAX];
> -	FILE *f;
> -	int ret;
> -
> -	snprintf(path, sizeof(path), "%s/%s", dir, name);
> -	f =3D fopen(path, "r");
> -	if (!f) {
> -		VMBUS_LOG(ERR, "can't open %s:%s",
> -			  path, strerror(errno));
> -		return -errno;
> +	if (rte_sysfs_parse_uint(val, "%s/%s", dir, name) < 0) {
> +		VMBUS_LOG(ERR, "can't read %s/%s", dir, name);
> +		return -EIO;
>  	}
>=20
> -	if (fscanf(f, "%lu", val) !=3D 1)
> -		ret =3D -EIO;
> -	else if (*val > max_range)
> -		ret =3D -ERANGE;
> -	else
> -		ret =3D 0;
> -	fclose(f);
> -
> -	return ret;
> +	return *val > max_range ? -ERANGE : 0;
>  }
>=20
>  static bool vmbus_uio_ring_present(const struct rte_vmbus_device *dev,
> --
> 2.53.0

