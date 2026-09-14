Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A90C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 12:44:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13B46402F1;
	Mon, 14 Sep 2026 14:44:22 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023116.outbound.protection.outlook.com [52.101.127.116])
 by mails.dpdk.org (Postfix) with ESMTP id E8388402AD
 for <dev@dpdk.org>; Mon, 14 Sep 2026 14:44:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQoLYz+um4mOcUdG0NZx+fMXcW1S5CkAcgH/NA4d01kbrYHNmQ8RdcMc1TTP/mLumE+yJiDuD+livwYn4QiNx6m3unIpTqUPtGcfm2mj8p/ELJyBNG78miYieDXGM12qXYGnRYio/xsrKMzQArW2+pSo8RgTeNGJBDR2Ej8gMI+9CH2xaOXsrJ/sm2Ho+A3zXjUTmyE7nmrYxSo7bWhbu0XJ/TeQriLFBvEjQDU9gJxj8tA2Zk065DRx+8NukRCO/4p4wuMC5Ail3njIMk7IAxH9ZoFPoSAXzWGj0IBy+wBQB0fMJkClbpFt+028MkhJXnP2uyimeA8GWYlLly9hUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=Xy9AxXkGW+XGR4VudndPvo3hCPUEWaRU+6jULynlP8o=;
 b=feY5lNSw6bt5EyTVlhRVqtekV0Ra0KJhGl6zMVLyiWkFD0l2CPZP86uj8d1vx0AGavDgvH4BInhS/0NVGvNHFccSrX9I+cLvGw3fhTcHouCtuJ/SHSe+xqQDOOHxldsNo/K8+uc4o3rWIzPypv7rRNJwEzMPsBH7aEGH3sWZRLx/s6OkB6hOYo+nb8ZLZXUla9UGMYsXlurmumpWjCGD5Ei2F18FgrJRiW1Ujy+1fs8hnp7OgDvKX7M3MJsIGKdlq7fk+dkWHF9e++k6uhCWVZIPR/rzX4vQVNIqhYVWR5zY3gAKmA/O0cvenD9O0c33l4yXx8ZDM4Fib+tUzKw2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy9AxXkGW+XGR4VudndPvo3hCPUEWaRU+6jULynlP8o=;
 b=TC8jCC3bLLKWAsjAiDbWE3Fanjye68IXWP0ussXETo2QMUPe4i5KxG1zBiadoUf8/Q82caibamXJcOMFpupBsCEglt32SFIcNbaGdNsuHCW9k5su53Iy83Z4VUhxu2DFGwf1LKkdt+5lIInraH0DYMJFdG0YbS8wVnhIWnnxLP8=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by KUYP153MB2117.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:74::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.4; Mon, 14 Sep
 2026 12:43:58 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%6]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 12:43:57 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 23/62] net/netvsc: use kvargs numeric helpers
Thread-Topic: [EXTERNAL] [PATCH 23/62] net/netvsc: use kvargs numeric helpers
Thread-Index: AQHdRAz8MabcTTWAA0GHEtQdxEbebLbOBOKw
Date: Mon, 14 Sep 2026 12:43:56 +0000
Message-ID: <SE3P153MB1848908D039498225636B76CBBBB2@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260914054912.755403-24-stephen@networkplumber.org>
In-Reply-To: <20260914054912.755403-24-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a4134d84-864d-4048-abf6-ee20b5d53cf5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-14T12:42:24Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|KUYP153MB2117:EE_
x-ms-office365-filtering-correlation-id: 8320cf57-1494-404e-9965-08df125dd78e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|42112799006|366016|1800799024|38070700021|4143699003|11063799006|5023799004|56012099006|10067099003|7146999003|22082099003|18002099003;
x-microsoft-antispam-message-info: GEecY0aVxFnRUjgcrNvhnbKU+MsNcc9DckCj/rVMYHMj6Y0i2viKP7ojhxNIaEgt5k6Uq/KSwJbIcSJoyXzLdiy12p1bJVZXXtVa2Cd3XYSBJjnTD7OZvJnFZqCKFDp5QHvdmnjiZsJa/wVkcxRqHvNPQPKITXWxWLqziG+Ufm6WVJyDDTq4JfrB81GQAUG8S51oVdyoV8k/8WunRgduihFRkXRr3PyC4zBzj3tK/PyuisU9TG15eSITDKAThdLeO+ewqnDvslZGl9f8g8qXeXyR4amobfzXvEQTOKIruaL5Wxg1sDphoag94bcvDCt0KJKES/2FmsOLcJRJWO2C+xMO/7JTUOvqsOZ1sdtEL3J2JuNjZ1WU4SfiTojDi71VKQGnKAbidmFAjufcCaGZmRMuf5FDUipvZhS0RYj2iqONSUe2sBmswr6z1Gi1PL1uHYwN/EOTqyhOAutQuqW0igW83bFq767c6P9h4+60BCZ9j20srjCCyRpjeCxTmKQ636B7QldWha3eHuxxSyNuVvqmv+fufqAMtOv6yurmbeUalRfmiTaoN9m88n3kXeBTJ72FghaVpnPotaAhTiTDJMxq067lxmZ9i4W9R5FJuBczTzAjpz0SAbc+dsz2apyOoxJsH+3fyaSmse0kPjHGsIKCKvnvDolxLE2U5+4YAzJVDT2F7/dYto7Bk9b5Z3/gVtoHw3cwf8J5yGU07Rq42y0HNzfsNcer+qiwI5DeMio=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(42112799006)(366016)(1800799024)(38070700021)(4143699003)(11063799006)(5023799004)(56012099006)(10067099003)(7146999003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gNyY9OEtZlSAp0ms+QPj+N6kzMzfiDWQnIXUQz9tPeHZxOHoJ4xTSJpRtT6k?=
 =?us-ascii?Q?ORqp8+Nmr1GF67d0Zq7U0aFtGi62Z3fMxbwIcKAsY1XPy6xYibGUioyMIa6U?=
 =?us-ascii?Q?fIqjcExY1cWDyqBdg1cssXGw30azeToH/Z2ns6OamtyEpCR5Y47FSMjR7kJs?=
 =?us-ascii?Q?kMwil7MdwQ/pvWXKQ/pf9jbOUi5k3292QgiUGdjoG/PRzSBJ8eFcwXuBqXAE?=
 =?us-ascii?Q?8K+NMD+xBeFXIKeUdvtXu8U+nt/fFFiXZ+OQSW60OfOWSBuhrLqSHA2vZqo0?=
 =?us-ascii?Q?/Apoo8sriS9brY1jbUKT+YbJMvI/saokE2uK7ddZemDRazTWqhsRJhkxuQhQ?=
 =?us-ascii?Q?Wt1n+/H/AaqIDansqi3st/Y1/NoOMxNfCp/1xVEtV/1qBrp0QYZvbOdLEsPt?=
 =?us-ascii?Q?Ng4jh043sx7ndPZFTdGHSSldvZ32N2vd1jORigNGNtNF2rcUfxErg4iru4Ev?=
 =?us-ascii?Q?p7IpfbG1156cUgWfq1jKGbR3Es200oz+/BJkVGee2TIyFB1V/HXJo4aUfS83?=
 =?us-ascii?Q?LJCMtOWR/ZnAOnRtFF85CTkZ2HIyIvn8yvsd7y/hmHghT40DU0TMv8Bl7odd?=
 =?us-ascii?Q?jTZSbX3N+X9K9e81E7+KMkNla4JLa2sqglPHhEcLQeUeP0N3T50bwUlt/VCh?=
 =?us-ascii?Q?8rvhBr9rMfJtcbzHGCGb7Px1m9l4lHXWRwEe3dpSgYpRtb9vuXIO4XfdJrRd?=
 =?us-ascii?Q?xf3Serj4s1pHU4Q2bIBkDjhpNLwOuHRtutrh9loXMkFUZmGIkg987YPX/lP/?=
 =?us-ascii?Q?IBdUQ1EMBC7Qk7elA6XgBpdYR86iqFsIlQOjFpRe8KvHcFN/2SEWx/0bSKgk?=
 =?us-ascii?Q?xGCt65vjLzcDmnfRM5i5izrBaJBjsFl9z9pjBrkDr2eXMOqULHAsYpfxb/cQ?=
 =?us-ascii?Q?kPNqLXwQfKd/mmTJL5bvMV+PeLj9KxIWWlICISzVjnHcTv3IZDcO5B/OwEBi?=
 =?us-ascii?Q?rbUjOXcZSNEO83Cp/dWFIrC/nn4smKpVdt0AZtPtS8pBqlyge0N0OePiUfG8?=
 =?us-ascii?Q?dPczdcJ0H3dRXZss1nf+HWRKS9DMB2E5F/vsoWxlhYpBzuesYLIXM+722RZF?=
 =?us-ascii?Q?FEgxloNcl9r/Nmdf0km/qUjtIDmCpjTg+An0hFBWkeF+V/3V/cHeA9aidSG9?=
 =?us-ascii?Q?9uS5RT8djZoYPmb1eQ9CnDnl2He+lTG9D/h0v5ylLlMxBDfwaUPmRET82TN7?=
 =?us-ascii?Q?e5Tld2UfY5fMyIZXxjqN/GJrE6auHY86pFt0oLIl9oqdYxm/Vr2cJXotyNBe?=
 =?us-ascii?Q?hkN1BsbTmvqD/880br/rByak7Mtud5sLP6W5XKxaOX/Cwz5yGjf7CVb+lDeG?=
 =?us-ascii?Q?+Xszuepy4/r0UrJajHlcaPqbemfGktbLxxTx3Byr+jdZy3lACgQjYoCIadii?=
 =?us-ascii?Q?bVMljLF687mWg4RSThFyoMdayj+muhK3qHTjFulsvSIuc76sGzgERthiZlFo?=
 =?us-ascii?Q?U8haoZlmY01aMlDO8HmoCy8RNPKeDV0D52meb7jjJSHayzzvSED3lOTY23Pu?=
 =?us-ascii?Q?ACZ9LcpI9qpU8bVSNnwwu6+H439xR8OXC4JI5/CM2H0nUFlHhMWHsvmyjEVX?=
 =?us-ascii?Q?aNwce1dAkctPBKInBKZFVLqF2bsR3LhoHhnydpZIhajvGjgkuSiMk5ZL8+5i?=
 =?us-ascii?Q?LVuhi7jdh1sy+fLP6kXWoGbgshIgA7EV/azUrOTBcCfSIo4hd7vzCk9n6XNm?=
 =?us-ascii?Q?NVFV+JtdPqDYaQzbfmTYPC1zo59APq7FNoSydaV9N5b3+QzQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8320cf57-1494-404e-9965-08df125dd78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 12:43:56.7448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXi6F98PRttszW5wV1AMaD9JKFH5Q7Vfe+Lm3BtJi22VRPsOfV2EpVT6eiCl2huxOIuCRVoAv7rEdip7dBRsaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYP153MB2117
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
> Sent: Monday, September 14, 2026 1:47 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Long Li
> <longli@microsoft.com>; Wei Hu <weh@microsoft.com>
> Subject: [EXTERNAL] [PATCH 23/62] net/netvsc: use kvargs numeric helpers
>=20
> hn_set_parameter() does not check errno, so an out of range value is acce=
pted
> as ULONG_MAX, and the result is stored into 32-bit fields without any ran=
ge
> check.
>=20
> This also drops support for octal, which base 0 accepted; hexadecimal sti=
ll
> works.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Wei Hu <weh@microsoft.com>


> ---
>  drivers/net/netvsc/hn_ethdev.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethde=
v.c
> index 9a193e4a7a..d9f60ec279 100644
> --- a/drivers/net/netvsc/hn_ethdev.c
> +++ b/drivers/net/netvsc/hn_ethdev.c
> @@ -202,11 +202,9 @@ eth_dev_vmbus_release(struct rte_eth_dev
> *eth_dev)  static int hn_set_parameter(const char *key, const char *value=
,
> void *opaque)  {
>  	struct hn_data *hv =3D opaque;
> -	char *endp =3D NULL;
> -	unsigned long v;
> +	uint64_t v;
>=20
> -	v =3D strtoul(value, &endp, 0);
> -	if (*value =3D=3D '\0' || *endp !=3D '\0') {
> +	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &v) < 0) {
>  		PMD_DRV_LOG(ERR, "invalid parameter %s=3D%s", key, value);
>  		return -EINVAL;
>  	}
> --
> 2.53.0

