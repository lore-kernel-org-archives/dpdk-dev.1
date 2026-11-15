Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA452606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Nov 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Lv5tPHgk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED0074025A;
	Sun, 15 Nov 2026 19:28:37 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
 by mails.dpdk.org (Postfix) with ESMTPS id C8428400EF;
 Sun, 15 Nov 2026 19:28:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtXeXQveWNAcCxors/91Ntx99Mc0CCUwn4zpZPCPZP6NEt3tgDtYc/tDJa5ih4Zuy6rNWzRsEBo1rXb0arkKxSenjFlKNl3TFaT7vYRg6XoYoyMVdqAWxXCE+1iZU/hbrm83aNpK/DQrkQjWsPEkcRdV358ZaahUdKSgSuFQpKhtOoukQAMpvMi42faOCnRd0oGjrtONgLOm1O4AQiMJQX5JhzLzWSRr2aNXxgWaSreYtB8oHnd1qfc7cauji5oGl8wO13pu0HYiFQ2afem9MeCiWqsQkcS4V+swq270mpdYvycDVP+nUCDbvTBJIotqIld5+BHnTDj+3FOIcs2M9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVLNi7ukUqB0g/mDgao1/fUk1W0L2MCk4ndvJCl9Ryc=;
 b=qx3nx/xU1srPwlN7FgfNxxR/nri5mC3ingD4XYqSQC+jQT4EJBGwbLxHwD4AKye1ZqTSFLvN5SoHEBKY6YuqV21mZdRf3A69d7hzyaUB/2RmaqDMIi5kOOPlrP3DAOGOZGiMzIHj3H4mpuswOp91FuaWXkEUHbyWr/63vnKTcGTjaXUUJxvLSd9Dp+YpSl4xUYuE8s7/KNndf/GcVRH3bTRl71S4m763aOXQ2QobG2/XDErHlgcAJ41eYF+OIK0RxUACIggyWt6oG32Bu9+Sy4PXs2fLt3zHS7JohXzAy9As97Su6vgE/kCPn6UKeoNX2rz6pcucpcqs0HlE/jkOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVLNi7ukUqB0g/mDgao1/fUk1W0L2MCk4ndvJCl9Ryc=;
 b=Lv5tPHgkSnDzFda9/vV6YRi+P3LU1jeHZFL3i/+ahT/PXzD6manWb0/IYQGhrbUUojTVktBoZsQz0ayxBZY/IACDObTBM5bLmZ997z3XhjqxGNWzdQUVTavMM0MdTwwW9s8xbDd8nMyy07/fndQ3umsOdwrB9gkkBaqVYHjrcP1mv6ZxiMtYyfecrFZURIFpuHUDpsiDqsB/Tvg5qy5YXc3gmJ0m4lcIHiSIzWtlLG0wEEfCWmqfBeYQLb22D4OLv/xWm1c7QPF6pm87f8yJc0MYgaCqJougZFmaW7ch+u+v6GDsawyKxoFeeN5t4skcvT+Rqm7hSjL6sQeONr+htQ==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 18:28:30 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%6]) with mapi id 15.21.0615.013; Sun, 15 Nov 2026
 18:28:30 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Maxime Peim <maxime.peim@gmail.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/mlx5/hws: fix completion polling for full queues
Thread-Topic: [PATCH] net/mlx5/hws: fix completion polling for full queues
Thread-Index: AQHdcTdxoTgK263S0kG058ROFOb3dbcve2sA
Date: Sun, 15 Nov 2026 18:28:30 +0000
Message-ID: <BN9PR12MB5338C45FBA27B66A54060B9ED07D2@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20261110171739.3917219-1-maxime.peim@gmail.com>
In-Reply-To: <20261110171739.3917219-1-maxime.peim@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|MW4PR12MB7384:EE_
x-ms-office365-filtering-correlation-id: 711bf252-075f-4f1e-e498-08df43463fae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|11063799006|260925021911599003|260925021311599003|260925022911599003|56012099006|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 9FjuSFSubEby/gUlr8FoHh//X4U+2vovbZ4ziYriH6DP85VMX8PV2zEtA6ke7PCgSLrTzw80V6TBpy0iwGjaEKdLTMSZg8+s/1LKShYfFnGwL4AgzklQGm3PFROiwsEbHI1iy0eogQRvXcImCMdg4TmyVLkJppscmAqNP5EIXKF9LAbzbYUoUTW30gyOTmWauIEofZlQH9XM2TvC3dqoJO217h67pq5Tk+Np4+XtDgHmlhKnzUjYUgOJgMyGq/hMWv1W42Oc3NKp/5m0Vi3RyN71aPhQhzy4nBUBvZiTCzL+/ibNoc97PY6RV23H2mCjqLNgfJK/HVMruij4xy1Xgkw/lEeApu5L2B3PBZjre4y0JIbjCth2jBjU36EFhuFARXc/JMWc1XDUOeGWAXzCdyJV+g72E3W0ZwxEXGi4R4ap8II6bunNVnyTxJrqDj+/IUAAgGL7a5o+Idv9jjZiFjS+CePDwxBMG+jYjR74j3/U/YDxK73A/KBG0TJq7zJOaZSiHTNnS7KQs/KnNpA+C+bIN4VcvlkX3k+Vk8b1ziT+ng26s0TMZDkK7mh8TvoUPhSlFx7EbvIqsom/Z2LP8daPjnp1o904Nlmv7Z9FPBhlPwpXlx/Cx7c5R7ooAc9AGQuG0pwE+ztrip5E1OFdGrXYd9xYeFgNsWCmq2jWINzkmjaZXOD7e7IQWvhVvDZr7hBEgJwl6Df+Airw28/FM0Z+Y6pbbOe/O8m7zBKTwlc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(260925021911599003)(260925021311599003)(260925022911599003)(56012099006)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qSsHlhqVHFc/li6XXlNPenfEnnq8G1mIDr/MvGS71I8KW06BpdHyadCvHEoD?=
 =?us-ascii?Q?dc0gHdXN6j8R+DyQ0ZOmVxEiwgr39O2rVTyNZvRsiHmSVY85LtNIH8VLdS8c?=
 =?us-ascii?Q?wIfCHzagoqVSs77hIwj+ecaaL/uubgitZfppyT3QQk6+p94P3vAn371O0omR?=
 =?us-ascii?Q?ysDLw3Od+4XlGMJCHmfxepBdngJZnb514y6GxrmyZkSzNe2nUFvURkXw/W5J?=
 =?us-ascii?Q?2mL4UYeeyuq0UIOldNG5bDCJnHVRMloUwtfmN6JOaIUcOVjOCD7KVcUi5bD1?=
 =?us-ascii?Q?RV9ENWAWO9ck5WP9kDDrUJkbQMQAtNfuGs2VjIst+GI9+zECGQ7IFuj6CzbX?=
 =?us-ascii?Q?l+jptJhqblKKM4SqR0BxFkgFkvb2SWjeT1G1Pn7tjAp8ZlsR11Pt6KRNkA9P?=
 =?us-ascii?Q?/mcNtVgaBVJM4uajtJOdH+M/EYKsY4N2T5Ftcc/5OsZinPLtps45cE6bWAI+?=
 =?us-ascii?Q?MRObYZqmMH36jsDQE0LcqB5mvQoUOxo6zTBcNwVEfMdRNS4lHIgy0TPzYGYp?=
 =?us-ascii?Q?AVJBb+WuPhuWNRlJrE5VdSXI7fKWzUDBhdByy33AfH36//oqndcIlchFod+H?=
 =?us-ascii?Q?VbBydnBD1VLTqx2n6LAleKTTzHMErDzF6Do9RCFzPo5OEMnhkilIcTE7ddyG?=
 =?us-ascii?Q?3FkYnrVUvt3+Mot0RrxJ4t92lnzi9RvSEfE08GkxpvsutWVGYqppaKh/SYMr?=
 =?us-ascii?Q?/3yuvYjY+VmPeJ0tx5Gy0PudEYpBdnieWjhbI0LtUFhAvDKjDiG0e6uUlQK6?=
 =?us-ascii?Q?ztQcBcCj5vtFZh/tqx+okRtvio3+rhkueQK49AOUTIlyqNprPxNh09lnPSDl?=
 =?us-ascii?Q?flhVQgD/0cO8Cm+VUpzM+ez5muH46MKWh2qRsjJwD4/GIe+Jun2eSE/L6SxF?=
 =?us-ascii?Q?QePamlheR7oeYkC7dldjYHJ9tZjmRVgmIsAhpqfq4DpzsuNrL9f583SywHtx?=
 =?us-ascii?Q?khKdWTqFWl8TMz7IM0XNm1OWB5MzP+hju3oY39gn3Z+if1n+EEIf5SB5lpfD?=
 =?us-ascii?Q?iGzNMxpH6NOfw6OqaCSJZXU6Dah0TaTT5OD4vxdrKSoaye1O2c1fvEeJiZ89?=
 =?us-ascii?Q?2YtN2f3qLYSJJFmRspCY2dwhN7C9jPPTurnrXq4VzxLob8RfRjWDFbJ4lWhX?=
 =?us-ascii?Q?vEtTiasKINPJqSyELlDIReDTCwkfn5Q0J0d4MxIsTLRZDXMtf9rYbazHQnGv?=
 =?us-ascii?Q?SK4s4H0aNvu1hhybhQ/GvvwHcFZ6y9A3Tdy782rNOgZUhM+lTpTyZFvE/Vei?=
 =?us-ascii?Q?vy1uNmw9MIW0TVUBpFH6RSWQuaYpTqyzM5mPqfuCxUrskx+JkRBeFdn74+lB?=
 =?us-ascii?Q?cUPXJDfBstkRIIjre/95DB7Avgb895m4hTYjdhEv8C5ss7Tic+TnEitRYANg?=
 =?us-ascii?Q?4pcqUhosyZfIH2dvdMaFhl+WvwlADmEe3psNfAM9/nJUMgGCuTWhNpI+RT15?=
 =?us-ascii?Q?+lbRrKQbh2hRth+jsXobht16ITxssIAqTVwc9ny74HWVpwnB9Wztm+7mLeLj?=
 =?us-ascii?Q?tYyCU1I490tsRJUc+b2zw7G3X876sdUcCZK1Gq2Y/Z21Xi3u/Rg9euHqJx6R?=
 =?us-ascii?Q?5RWSYTrcXuI2JY1adSaG3ebk3s68lXwLQ+ehPikzcpNehK5r3RlgDz4J9EaM?=
 =?us-ascii?Q?MNJgLrdzK3p74+/ohyHDj6T4saZaT3dxFc5LpmRHRwQCgah/NMx3F55u2D6j?=
 =?us-ascii?Q?L/3C4uZdb4R2NqrDMotd4Wh1O0pDh0q+ocVKgpAkUyuJfsyF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711bf252-075f-4f1e-e498-08df43463fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2026 18:28:30.4714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWWHKZIutcOF86atnbbWF9NHpLrCQ9gs2/gIMg2GAjuOEBDVi2zdl7MMHSdWk7a/MSnuNTPByW7MpBwd3oPwRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

LGTM

> -----Original Message-----
> From: Maxime Peim <maxime.peim@gmail.com>
> Sent: Wednesday, November 11, 2026 1:18 AM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Cc: dev@dpdk.org; stable@dpdk.org
> Subject: [PATCH] net/mlx5/hws: fix completion polling for full queues
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> The software completion ring masks its producer and consumer counters whe=
n
> advancing them. When all entries are filled before any completion is
> polled, the counters become equal and the ring is treated as empty.
> Root-table rule operations generate completions directly into this ring,
> so a full batch cannot be dequeued and the queue remains busy.
>=20
> Keep the counters unmasked and apply the ring mask only when accessing th=
e
> completion array. This distinguishes a full ring from an empty one withou=
t
> reducing the configured queue capacity.
>=20
> The power-of-two ring capacity divides the 16-bit counter modulus, so
> counter wrap preserves masked indices. Capacity also bounds outstanding
> completions below that modulus, keeping full distinct from empty.
>=20
> Fixes: 3eb748869d2d ("net/mlx5/hws: add send layer")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
> ---
>  drivers/net/mlx5/hws/mlx5dr_send.c |  8 +++++---
> drivers/net/mlx5/hws/mlx5dr_send.h | 13 ++++++++++---
>  2 files changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/mlx5/hws/mlx5dr_send.c
> b/drivers/net/mlx5/hws/mlx5dr_send.c
> index 85f613ed39..f94957dd27 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_send.c
> +++ b/drivers/net/mlx5/hws/mlx5dr_send.c
> @@ -646,12 +646,14 @@ static void mlx5dr_send_engine_poll_list(struct
> mlx5dr_send_engine *queue,
>=20
>         while (comp->ci !=3D comp->pi) {
>                 if (*polled < res_nb) {
> +                       uint16_t idx =3D comp->ci & comp->mask;
> +
>                         res[*polled].status =3D
> -                               comp->entries[comp->ci].status;
> +                               comp->entries[idx].status;
>                         res[*polled].user_data =3D
> -                               comp->entries[comp->ci].user_data;
> +                               comp->entries[idx].user_data;
>                         (*polled)++;
> -                       comp->ci =3D (comp->ci + 1) & comp->mask;
> +                       comp->ci++;
>                         mlx5dr_send_engine_dec_rule(queue);
>                 } else {
>                         return;
> diff --git a/drivers/net/mlx5/hws/mlx5dr_send.h
> b/drivers/net/mlx5/hws/mlx5dr_send.h
> index 9209754136..ad2488dca2 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_send.h
> +++ b/drivers/net/mlx5/hws/mlx5dr_send.h
> @@ -138,6 +138,12 @@ struct mlx5dr_completed_poll_entry {
>=20
>  struct mlx5dr_completed_poll {
>         struct mlx5dr_completed_poll_entry *entries;
> +       /*
> +        * Keep counters unmasked to distinguish full from empty, and mas=
k
> +        * only when indexing entries. The power-of-two capacity divides
> 2^16,
> +        * so uint16_t wrap preserves masked indices. Capacity is less
> than
> +        * 2^16 and bounds outstanding completions, so equal counters mea=
n
> empty.
> +        */
>         uint16_t ci;
>         uint16_t pi;
>         uint16_t mask;
> @@ -279,11 +285,12 @@ static inline void
> mlx5dr_send_engine_gen_comp(struct mlx5dr_send_engine *queue,
>                                                int comp_status)  {
>         struct mlx5dr_completed_poll *comp =3D &queue->completed;
> +       uint16_t idx =3D comp->pi & comp->mask;
>=20
> -       comp->entries[comp->pi].status =3D comp_status;
> -       comp->entries[comp->pi].user_data =3D user_data;
> +       comp->entries[idx].status =3D comp_status;
> +       comp->entries[idx].user_data =3D user_data;
>=20
> -       comp->pi =3D (comp->pi + 1) & comp->mask;
> +       comp->pi++;
>  }
>=20
>  static inline bool mlx5dr_send_engine_err(struct mlx5dr_send_engine
> *queue)

Acked-by: Bing Zhao <bingz@nvidia.com>

Thanks
