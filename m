Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BE7CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 16:36:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C6E040698;
	Fri, 26 Sep 2025 18:36:01 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11022133.outbound.protection.outlook.com
 [40.93.195.133]) by mails.dpdk.org (Postfix) with ESMTP id 74CDD40647
 for <dev@dpdk.org>; Fri, 26 Sep 2025 18:35:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o55xKkdbkvWBC+Sw9DCHgxlIRJ/BALd31wfF1tP4lbPLTdIBWwYh7C4hk8MwtSrlOL1dOMKkwBw8L72JpMVYd29HS7lPch5gDfVmPHUVszBllgswGoA/Zf1kZy7KmJRQTSe88Fgzfn/ltu+qMeqJ1HafDCHjgUtrUbC0yJUlsDFassRrHTSHCqIwDAUiDrWDrn25x3ZdY6TxuHS0VoFBegFirf4KtZdGZUsza/WvWScA47uFxOizBa02lA9jtCqBdXReqg7fjLmD7Di/j+TirDp9fDm6wWNbfaiI9XNEXRXTbYmyNbZ570G+KPC6uYBdRCqekK+deIlZs/zvQUk3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIOTfPFOKNP/2DhFPEiqUrTdEhaXngjZZxWwzgmEADk=;
 b=TlxinrkUqpdrDsJbDdINLkAsGlbEV7OK4qCkhWd/5bdhRleeg70YU4ERgPAQRTMJkBuW8Bv0YMhAs2956LFTXgK9apCylA+UyIHO5or1rQoHwHaAAr/id2lSkVCe080Itf0l+hI/+IU6rJosNjT6FFQmWkjto9H/NiZHSoWzgbIpkv8U4PltSpGzx43RopQmC03+m/rjzHUcxWKQqpbuQw/KFsRf3kRrd8h/nItTQun8ERiMdATAYqsraIgEBDbSppnAV1dho/iuKybCm0Gk97JOJvk82yFxSxqACplB8W/Qf4XQ2CUo87fglk6S+lyT8B1d/FZvLK/+SBM0hWRIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIOTfPFOKNP/2DhFPEiqUrTdEhaXngjZZxWwzgmEADk=;
 b=HzinSwJ1Agk/IIi7xSJqPoL7TqhvRRDJiOOSGmxH6sdvnhkiLyHdV4AbU0f0ZyQD0xj/d1A0b1MnMm9zVOTZ+vJdq5klwzx67GUCHzKXXhnw0JQasrYxgHZrGLKKqJaxfj6E9+DEL1b5tzC9tr6eG8tY/M/+qLiJj+kDd7T1GcY=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS0PR21MB4132.namprd21.prod.outlook.com (2603:10b6:8:1d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.1; Fri, 26 Sep
 2025 16:35:57 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983%6]) with mapi id 15.20.9182.005; Fri, 26 Sep 2025
 16:35:57 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 2/2] net/netvsc: rename get_vmbus_device
 internal function
Thread-Topic: [EXTERNAL] [PATCH 2/2] net/netvsc: rename get_vmbus_device
 internal function
Thread-Index: AQHcLv5eqynpsfjtuEWElfMJcPqrF7SlqTDA
Date: Fri, 26 Sep 2025 16:35:57 +0000
Message-ID: <DS3PR21MB5735EB0F2DA3EA0E8B087826CE1EA@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20250926155802.398869-1-stephen@networkplumber.org>
 <20250926155802.398869-2-stephen@networkplumber.org>
In-Reply-To: <20250926155802.398869-2-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=51bb7ae9-fe9e-45ca-9bba-2079b13e4932;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-26T16:35:36Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS0PR21MB4132:EE_
x-ms-office365-filtering-correlation-id: 4ff9d6e9-0972-464d-2fba-08ddfd1ac4fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?zXkkdwDVwqwRdVEhGrj43TbRqBCGBUoFxcDV422Jv9zz8czjTOh0vovE7AUF?=
 =?us-ascii?Q?aT23PHts9ODoeQVFfXe+NAAdZ9L5FGCGlNiXeMuh7+lE9LdjSQiJ4NUPr1ot?=
 =?us-ascii?Q?zTZfEDcSALoeTwE18sgd6QFQgdi5cWqiOzlJ3zN/QXTRcrmY1tuCFVPuKFuB?=
 =?us-ascii?Q?WHi1ikMr7PYZWnZZxssPCbVe7Qqf1waod7El1pC7QJ+caWod5563TaCoddZA?=
 =?us-ascii?Q?pNAv7A+vvFJIwcQpRcnAid7PxJSUTshHO9OhGmNAQXOcEdneG1+ZnxZbB8du?=
 =?us-ascii?Q?SWyWaBMo+7G2XOPzQMKAE0DDObaJXkbeuTxCjtAAiGPVPENshMoohjzf/0YH?=
 =?us-ascii?Q?mKphlYde+qgKjZ0SDWoA6Mjw8H/fSPFdzUZAoq++HgPuali2pi3Q37XWeWjd?=
 =?us-ascii?Q?eBRjsgDPATD4eks09gEWSVVATL0/6WCLX4mWTJYbshAAo8HYJ0iSV1FqpcFH?=
 =?us-ascii?Q?U4MWTyVWJjvDZzEiKRkB8u4qAsq4ZV2XWJEINt4K0CDDXjfveibylWRBqvcb?=
 =?us-ascii?Q?6qPkvCpcIXoJntflQc0aTextigeEviBY2/EpsXz3Gznc1FkAK0W6RS3RuSob?=
 =?us-ascii?Q?JQ1w7nc8IZl1W1RvVtEpmHTIFKoNhXN/3HPFrjzY7SD3acwMvVM6SGIoDZVp?=
 =?us-ascii?Q?cPnhp75RIdFC8t4Ng2lytcGCpqRpLQjdi5Qg5RHBwkVRZk4xtZo2wtH8m+IC?=
 =?us-ascii?Q?R+uMHbTsNsSfQD3ZlnnALPTy6yerN2uSFUMgzL/MFkzlPaSyAYFeKpjHLBG/?=
 =?us-ascii?Q?nzn28EMISCDHX/51Ibztx4IHHFIehmKHPamS5Vqtol8F6xh9ojEvmPUuWCO7?=
 =?us-ascii?Q?xRs6DQB9wtRfcCUPfCO0CSxRt3AywkcH24OHpecscIEH+FIkj/SwgpMjDk9h?=
 =?us-ascii?Q?Uklsule8WAg9sMmcHQUv2Tb85iXzGBaW9zWPiaMI8Vb4O2WuNJ9K1xAKqX4X?=
 =?us-ascii?Q?3Wk0Ux+eaOto0Cwh3r0AMeg9D0eixlZ3jvCIFIr+VsRhpsMPD/V5e1YxnEyV?=
 =?us-ascii?Q?XaDd+91Xm9Qz/RfCMiFtjRlOe2X6RjSPXv4+Ue0JYyniYSHMQqs+nFywhV1k?=
 =?us-ascii?Q?YonzkZAT0WpL61K1CBu3CxDK/PffKnbOVwvNxYDsOIo6WCfq7EcPsowdtJPJ?=
 =?us-ascii?Q?9u5nNyp6kV7Gi1YeeRfawqhYmiPdBdon+U9hdxbTY4OZPnxoqccroptVY5Dk?=
 =?us-ascii?Q?QTr64b5EzxW1ficnR5+WeP7zIZ8doehi/Rb6rvNpeNTf7ksq4WxGxmiU18Lg?=
 =?us-ascii?Q?srMsN8f64BN+1+5RLW0aCQqz2kcgpes3LeHINksYgfaxdySJ3f1Clo4UPLfE?=
 =?us-ascii?Q?ofHn9jb6UHD1zJp9SMTgMBkkzNGLqkU7YSdj8KSgNcB1qfcOcz//nOLkRmoH?=
 =?us-ascii?Q?Z+Yoc/PafAbB0M4UWdQwAO9yyUXvjhEsSErGfAINWHJ3gPE2k3v2tBTzDZvA?=
 =?us-ascii?Q?H7UsRdTpWEGeJITqAQAllEbVZhQ/HAPH4K2OR9nw5MRNkB5vaU0UWWdhGjN5?=
 =?us-ascii?Q?txa8jOo/8A8cRvCMUpWaIBGecwF5E52nUe21?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cg2+nZx5xPglDTRpwDruu9aFOtF0/p0hywOy34bjY4t+7FmqsnT+4YH/jVeK?=
 =?us-ascii?Q?lrAUDYSPQk1BlmD+QKrUnJ9ldKZu4cQpHU735TvH+RoilKOqCEd4NkiyBecC?=
 =?us-ascii?Q?3IzXR2uanro4nVqyuz4Yo0Uqb8b32TXALggWcpWC4JWYt9lC80O+cQ+1dXuP?=
 =?us-ascii?Q?9Tuf/ozR15pwou5ADlQ/p4pNqn4bP1qgB2Vy0jeJCNhQ734n23LxanU/QiqX?=
 =?us-ascii?Q?i00FuQOZMIKS7x4sRnM+gA0hbZflzjJn6pT94YiPudSFqCis3K2MVEi4Vd3b?=
 =?us-ascii?Q?ILdQAptC9khzukIJHALgEcKMmyOWdQFCeLckhhooPI+L9pexfWbSnhpVmqvQ?=
 =?us-ascii?Q?MBn/Gs+oIYOdQYgmJcZBEs/m14iYQgCC0AIUtfLnX189BB7W16M1A2KGDPyT?=
 =?us-ascii?Q?hfdkTg36FPXEtx4kTWJHfIzvx8dyaBsG58HD6ozD879HQk0TjJJENqr/7tET?=
 =?us-ascii?Q?KFx8dV+KbgUpuTapnYAO6gyiaibefKg2CL/FGt4Hfk7Yey8WjklyIpPsbFfJ?=
 =?us-ascii?Q?QTyNlZvLmIqAMbkf3CTsWLCR9Oy7RcunWCBeYt4LQXAr09q1waABR7Vp8EJI?=
 =?us-ascii?Q?4q5A1WgnNwtqrYMcfhWMrU6twXV3xhX1M3Er5n35mehVHI3C4/9U2MjGyx/N?=
 =?us-ascii?Q?bOXKtC320aJpntUWBXsFT6Y8Ec7Vzjfmj5oZ7TiBGZLp2kOqa+vQxbwjaFG1?=
 =?us-ascii?Q?EmEfkyrKqBbIdT5XtWT/jJgqLRTPDd9YsJGO2Vr+s0ivtwsnLHR/+gDE+cEN?=
 =?us-ascii?Q?n2gSn7AY5NCZ/t2k4htTum5z9Y8iO/ak+9B8RD16GyK2BAe0HQUYyUtgYsrm?=
 =?us-ascii?Q?OFzBBhNPsXqRw5wW/5P/ps6b0rgez6286JtETuuQFySenL3DnBaVNlbJ+zY2?=
 =?us-ascii?Q?yCXVp8o9ETJkCHSgfDkI6WLjwD4rswrDqOzIsz+JN1eJ9yym1FIaYEApGvrM?=
 =?us-ascii?Q?P8Kr0UI+LwEEQIU6kYiv0So6CGRCipNG/LHZOaGrNhIOFlx5CaErn4xnGODo?=
 =?us-ascii?Q?f4a4InDRJBpFagYq6hZspHqrAmYUjINtUXmDZJnZt+/bn+7MR9rmsKjuP4N+?=
 =?us-ascii?Q?7SJVUTAiux0kxeOknpwIRdkoZypBYyOeBZBW+U15lWbFwRXqCYbk80U9EwuT?=
 =?us-ascii?Q?bHj5fJ38Q29hy6Rc8mV5Wc2t0l0y5uU6QqWUgt2w9cyGuVFjgsTfkfd8Tzxr?=
 =?us-ascii?Q?ITesrHsCkZf++dNfx6gFwvYWm61UCsMeK8Kfe+Xi1Qvojy2hWv1i84MACC81?=
 =?us-ascii?Q?YNgFj0C5qib9lK61GYGL31kIP3m9H9Ong898WZytisigqX3qJDuXc7NU+i5C?=
 =?us-ascii?Q?SaD29PmB46bdLZUbjd9BiDvVzWT3tn235Vayi8IA2zQhQVCrelIcny8SGE3T?=
 =?us-ascii?Q?3+F9l4A6anuVnYjbYh3O8PuhBzaCo6gWSNd4Mo8TpLY8iC4RAuJDDgQZl6jP?=
 =?us-ascii?Q?3fSClhvueG3wdrUgMcdHiZaBnImG/k1ri0diKOyCMCz5bwQBuVY5INXyMwmn?=
 =?us-ascii?Q?m3niPtgBrpOxeH2BCeH+mljrnSb9xTfiUrQ8/E2yzqJGi+M0MVUGSpYPEb6I?=
 =?us-ascii?Q?On11i+QanM0HNz5okg0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff9d6e9-0972-464d-2fba-08ddfd1ac4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 16:35:57.1619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPZfHpkHnb7Ee6Y3Rb1wtUOyutOi4PgRh1hygQdhceiTBj8IMOVpuEGGaB8Htg7TzW7b7gm1T8FqkE/L/9o10A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB4132
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

> Subject: [EXTERNAL] [PATCH 2/2] net/netvsc: rename get_vmbus_device inter=
nal
> function
>=20
> All global functions should use a common prefix. For netvsc all globals s=
tart with
> hn_. Rename get_vmbus_device to hn_nvs_get_vmbus_device to follow pattern
> used in this code.
>=20
> Fixes: 11c0663c9445 ("net/netvsc: add function to get vmbus device")
> Cc: longli@microsoft.com
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/net/netvsc/hn_nvs.c  | 10 +++++-----  drivers/net/netvsc/hn_nvs.=
h  |  6
> +++---  drivers/net/netvsc/hn_rxtx.c |  4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/netvsc/hn_nvs.c b/drivers/net/netvsc/hn_nvs.c in=
dex
> 0b7e6c0264..c6bd60dbda 100644
> --- a/drivers/net/netvsc/hn_nvs.c
> +++ b/drivers/net/netvsc/hn_nvs.c
> @@ -44,7 +44,7 @@ static const uint32_t hn_nvs_version[] =3D {
>  	NVS_VERSION_1
>  };
>=20
> -struct rte_vmbus_device *get_vmbus_device(struct hn_data *hv)
> +struct rte_vmbus_device *hn_nvs_get_vmbus_device(struct hn_data *hv)
>  {
>  	struct rte_vmbus_device *vmbus =3D hv->vmbus;
>=20
> @@ -62,7 +62,7 @@ struct rte_vmbus_device *get_vmbus_device(struct
> hn_data *hv)  static int hn_nvs_req_send(struct hn_data *hv,
>  			   void *req, uint32_t reqlen)
>  {
> -	return rte_vmbus_chan_send(get_vmbus_device(hv),
> hn_primary_chan(hv),
> +	return rte_vmbus_chan_send(hn_nvs_get_vmbus_device(hv),
> +hn_primary_chan(hv),
>  				   VMBUS_CHANPKT_TYPE_INBAND,
>  				   req, reqlen, 0,
>  				   VMBUS_CHANPKT_FLAG_NONE, NULL);
> @@ -82,7 +82,7 @@ __hn_nvs_execute(struct hn_data *hv,
>  	int ret;
>=20
>  	/* Send request to ring buffer */
> -	ret =3D rte_vmbus_chan_send(get_vmbus_device(hv), chan,
> +	ret =3D rte_vmbus_chan_send(hn_nvs_get_vmbus_device(hv), chan,
>  				  VMBUS_CHANPKT_TYPE_INBAND, req, reqlen,
> 0,
>  				  VMBUS_CHANPKT_FLAG_RC, NULL);
>=20
> @@ -93,7 +93,7 @@ __hn_nvs_execute(struct hn_data *hv,
>=20
>   retry:
>  	len =3D sizeof(buffer);
> -	ret =3D rte_vmbus_chan_recv(get_vmbus_device(hv), chan, buffer, &len,
> &xactid);
> +	ret =3D rte_vmbus_chan_recv(hn_nvs_get_vmbus_device(hv), chan, buffer,
> +&len, &xactid);
>  	if (ret =3D=3D -EAGAIN) {
>  		rte_delay_us(HN_CHAN_INTERVAL_US);
>  		goto retry;
> @@ -530,7 +530,7 @@ hn_nvs_ack_rxbuf(struct hn_data *hv, struct
> vmbus_channel *chan, uint64_t tid)
>  	PMD_RX_LOG(DEBUG, "ack RX id %" PRIu64, tid);
>=20
>   again:
> -	error =3D rte_vmbus_chan_send(get_vmbus_device(hv), chan,
> +	error =3D rte_vmbus_chan_send(hn_nvs_get_vmbus_device(hv), chan,
>  				    VMBUS_CHANPKT_TYPE_COMP, &ack,
> sizeof(ack),
>  				    tid, VMBUS_CHANPKT_FLAG_NONE, NULL);
>=20
> diff --git a/drivers/net/netvsc/hn_nvs.h b/drivers/net/netvsc/hn_nvs.h in=
dex
> b7691a5dc2..bf10621927 100644
> --- a/drivers/net/netvsc/hn_nvs.h
> +++ b/drivers/net/netvsc/hn_nvs.h
> @@ -222,14 +222,14 @@ void	hn_nvs_handle_vfassoc(struct rte_eth_dev
> *dev,
>  			      const struct vmbus_chanpkt_hdr *hdr,
>  			      const void *data);
>=20
> -struct rte_vmbus_device *get_vmbus_device(struct hn_data *hv);
> +struct rte_vmbus_device *hn_nvs_get_vmbus_device(struct hn_data *hv);
>=20
>  static inline int
>  hn_nvs_send(struct hn_data *hv, struct vmbus_channel *chan,
>  	    uint16_t flags, void *nvs_msg, int nvs_msglen, uintptr_t sndc,
>  	    bool *need_sig)
>  {
> -	return rte_vmbus_chan_send(get_vmbus_device(hv), chan,
> VMBUS_CHANPKT_TYPE_INBAND,
> +	return rte_vmbus_chan_send(hn_nvs_get_vmbus_device(hv), chan,
> +VMBUS_CHANPKT_TYPE_INBAND,
>  				   nvs_msg, nvs_msglen, (uint64_t)sndc,
>  				   flags, need_sig);
>  }
> @@ -240,6 +240,6 @@ hn_nvs_send_sglist(struct hn_data *hv, struct
> vmbus_channel *chan,
>  		   void *nvs_msg, int nvs_msglen,
>  		   uintptr_t sndc, bool *need_sig)
>  {
> -	return rte_vmbus_chan_send_sglist(get_vmbus_device(hv), chan, sg,
> sglen, nvs_msg,
> +	return rte_vmbus_chan_send_sglist(hn_nvs_get_vmbus_device(hv),
> chan,
> +sg, sglen, nvs_msg,
>  					  nvs_msglen, (uint64_t)sndc, need_sig);
> } diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.=
c index
> 0764d5b319..72dab26ede 100644
> --- a/drivers/net/netvsc/hn_rxtx.c
> +++ b/drivers/net/netvsc/hn_rxtx.c
> @@ -1176,7 +1176,7 @@ uint32_t hn_process_events(struct hn_data *hv,
> uint16_t queue_id,
>  	}
>=20
>  	if (bytes_read > 0)
> -		rte_vmbus_chan_signal_read(get_vmbus_device(hv), rxq->chan,
> bytes_read);
> +		rte_vmbus_chan_signal_read(hn_nvs_get_vmbus_device(hv),
> rxq->chan,
> +bytes_read);
>=20
>  	rte_spinlock_unlock(&rxq->ring_lock);
>=20
> @@ -1641,7 +1641,7 @@ hn_xmit_pkts(void *ptxq, struct rte_mbuf **tx_pkts,
> uint16_t nb_pkts)
>=20
>  fail:
>  	if (need_sig)
> -		rte_vmbus_chan_signal_tx(get_vmbus_device(hv), txq->chan);
> +		rte_vmbus_chan_signal_tx(hn_nvs_get_vmbus_device(hv), txq-
> >chan);
>=20
>  	return nb_tx;
>  }
> --
> 2.47.3

