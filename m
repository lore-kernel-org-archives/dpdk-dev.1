Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC6AC3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 16:02:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70B814025D;
	Mon,  5 May 2025 18:02:19 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by mails.dpdk.org (Postfix) with ESMTP id A9FB64003C;
 Mon,  5 May 2025 18:02:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHuXwFRDxXLmKG/ItGpAFvCs4XX0PX9YIT3JBloTRAcpJR9RihoPe2W1p5YK1oQ121Gfn0xLe8j+HYHHXmg02NPXZ05V0a6E22Lh55VvMaB4p85+Clv1GBeN+PxXXOx5tlFRi9ZEVPzH3I4hAujfMPBXNq/VZOK/HCsajuuG85Gar6mIYCxezBrpXV8eJgHDT0oraacRKcXHpdgfXxL5ywgeZ6Qmj0WERinGU6f7xtZcozFWIPYFpUWapDVP9Wmauy8EIMZtVbVscm3amNjipGcsaZjOitlYV89zmqL+IJUMwU3oP43aeuvGl4Kmt4ZKK4vqQ+jj6eo1I8CcqSKWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpsIgUaNzgw9xagME3F8xjYp77jatNqhqCTv6sY+/ac=;
 b=s+dqOIR+QiCG0dIJLZzQfzpEYHLaIfUMJlUwjquh2MtDEPy5TknaGcHcgMZFbZMB2OU76kmxe8Wv+X29Qo/1rRPL2vY4xxjdcw0Xihxh7VHvcbXXGj/L+88Y3wgXoV/LaIBm5mpak/FCaVgxJbfGX4c2qB74c2rG3dQjSUWzrZdbdW9XUPW3XRDG6vWOviqMydjwcPgfRKdNH8MEqdmudK3i6FH6+Mjpcau5p+cfZGaAfunOF5yAw0oJRSCq+Yx9RB7jXwdZTeeTHIRBRKewv0RBCn5fJDp06GVkrGs3LQMa3qi8ebqYG8dxCvGX5kFW+a8+Ky2YXveycXZR2l0czQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpsIgUaNzgw9xagME3F8xjYp77jatNqhqCTv6sY+/ac=;
 b=V5ah3YZ12/nAcyYdPWN9TaV/FKSxnj6CjfzDQo6iEQCnQ6//T4gN4j7Fv+AL669XsIwkHepsqaAwgbtfIIrdbidHFggYUI22Un9fv/0nyst2Tp3cm+3vmZEKgYC3Dnq8tJei2xvA4lxzNRnvn0y9EADHAZ1qpCknNfQrTdNy+10PP+6tbyiiJTm8hn7qZD1cUSMAZh43mZTKkMRx/J1QBwWIRIgRJlULSUcl6gXf8YgD+Y+p2wr7zY4oV+LGgXae9EvY74VIZ7QIorfxchtkvDOiZJ2Zf2NDN+J92cNmFzNBsL9ZlRImRn+CaLYO/pgLZAbzHF2FNyDrG4OFeahvBQ==
Received: from PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 16:02:15 +0000
Received: from PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662]) by PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662%6]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 16:02:15 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Raslan Darawsheh
 <rasland@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>, Alex Vesker
 <valex@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: RE: [PATCH] net/mlx5/hws: fix send queue drain on FW WQE destroy
Thread-Topic: [PATCH] net/mlx5/hws: fix send queue drain on FW WQE destroy
Thread-Index: AQHbt2eH/04bAB2/g06A4OvKsxy4DbPEPyPg
Date: Mon, 5 May 2025 16:02:15 +0000
Message-ID: <PH7PR12MB69050CE7D07D606A74BB91FAD08E2@PH7PR12MB6905.namprd12.prod.outlook.com>
References: <20250427112821.108929-1-mkashani@nvidia.com>
In-Reply-To: <20250427112821.108929-1-mkashani@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6905:EE_|MW4PR12MB6950:EE_
x-ms-office365-filtering-correlation-id: 430a1f86-6b81-4bbb-2e84-08dd8bee3457
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RXJIMUpjkzObYn7iw1HbAWzNqrk0UpNc2j0ZYpGMI+BUB59kdEi/NKZX7xUx?=
 =?us-ascii?Q?mI65Bk9i6TOpqm4tGhck2rmVq8VvtF1J6X6hTgYVVbVOfcHXJFjFKJnTOPAT?=
 =?us-ascii?Q?zbdciYgWhYxFkDJbVFyauTXdMA+nrSevdrgTu2STApDFa2fqNf5OPDe5QtSG?=
 =?us-ascii?Q?otxkF8kVb5iOmu0hFu8HI11SLwOF6pPAcBUqwWnrKsjG7+6KFxf+wF5sHnPo?=
 =?us-ascii?Q?AAcLGr+GyTFZz2O/zjBngs39K/AEhJ6ckiapGGeni+bzD+jqV4t25P5wc9p1?=
 =?us-ascii?Q?LB9Q4ZhzE/DDMA+cqTiQ/LCL0JfUoaQJR0tRULISESa/MduBHXuuUB9L/t3Y?=
 =?us-ascii?Q?lIlo/fiGppKFaCjsSNvGaPXNlZiPPtH+eUUYHjRRBeQ7ruZ2/dwvwZ/+jFy0?=
 =?us-ascii?Q?0+fbNFxqVCOfP4rdtkE/8X8KbE5KYLWlcuQWGkNDPoOQbWDXouQKLFrQohG0?=
 =?us-ascii?Q?7DzMTuMwcKGNJ5XM3pNyW5VX3sgB5uwXPg8vRC7JOTrImJt32pxa3CCD47RN?=
 =?us-ascii?Q?tOwIneq7erPqTeVzjaTWdLUgoybuflxZ65VYF/0z7hmxy0b1xxjrdOBb0vkz?=
 =?us-ascii?Q?0nd2m9zzWJgLJhTfjZQzcBeUbAufqwnXkJIrAu+Cx+EX4qKgYc9wJt4YiUUO?=
 =?us-ascii?Q?Zf4mU/LQr9m8ZkctBi+Z85mjY7NiQFqW2KvCzY7fYADoTL4ykk/lqNqht/op?=
 =?us-ascii?Q?3Iir9dYI6fPUaHnG94Kq1fbW8BvRaUNZFgmzsC4ggYzE9PgFZIgLUp5+OsVM?=
 =?us-ascii?Q?eLOIzbtYC01qVNZ16r/5k7rhC81eRDLmw/s3aZHu9zxr0hB53qKbiHJUhvbA?=
 =?us-ascii?Q?NGyeaSEyGkhTSvqHh+IllzHNgpaCHuDVBXfvXMuggtTaL5qEXwcU0OWgu77A?=
 =?us-ascii?Q?2h8kMdZNii3cGs6Zctxdzi0+DMBs0PnFAcZg8pvGcvguxt9j0ksHlba4nybV?=
 =?us-ascii?Q?BV+mOGicNNrcHoqSI+bDmV7iW03GwhcrpE7P7wzbYWANnQiq6TqqLbZnoGCq?=
 =?us-ascii?Q?/jdhVbolC5Z6EyMHZzkaGQ3GRFlZ/KPAfnoB1wcXa42OB/l0/F1jmX+GKDBT?=
 =?us-ascii?Q?Rz/NX8sgVVqa1YBOSRVDaMcLFMDSnZD8SsO6+CQG+o4GmbNWxw8qG44qGPRn?=
 =?us-ascii?Q?Fng6+WOGzZzpeJdWeWopNQcJh20rueQLL7LeQ4/fOY8eME5jgKD9SOrtUNzy?=
 =?us-ascii?Q?LMN36WtS5dXyJ+aaRnvg5Do3CZP7YGYmqgVaHIfwPLpXpUM9mMylqnnZhG+g?=
 =?us-ascii?Q?TfhqrshrZKsqQzP6pJFWGgsQEIbYVJ8PlVNzLxCEAGBmYz8KBPqZHxaI5+rr?=
 =?us-ascii?Q?Qap4R5s6sEqgXqx9OUd8wIlLQ6IdGyq9w2ROPtzwnflCpw6xnipJPPGIsesc?=
 =?us-ascii?Q?twAs5CtlSvOupR1LRjhum+H1zMX+d2uPRiwhQcOEe/UncDCiXA7M7B4/sbwM?=
 =?us-ascii?Q?tTP6W2BV9A0vp1B6p9JbC3I8In8kUG3a97j7jD3uHTmUHozrAeyM2ps7WYz4?=
 =?us-ascii?Q?czOvaujgum8Jxd8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6905.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CjVSwUOSPiwsdPf3kxEBqBdJK5sYJwKoD3bI+5XH/WrTtkyBnb4Ny+NaHK8+?=
 =?us-ascii?Q?QqfwBPJvwaU8a4jnDHQuHTUWjOk7VRgCI8uY8cNmbNqCSpPXWqDL9r9I9Hq8?=
 =?us-ascii?Q?byaUJpInfhYeTYbDT1o/93Xj0Mb/gUZlrjY8fMptYaUUHmsNB7qldJQA90hf?=
 =?us-ascii?Q?NblW9Yx7c+O0x8RQkzppQNgoQIpZUpsEUFa874n0nN1DkRfVJMMliMNy1Qgl?=
 =?us-ascii?Q?3wKKs/yRSB+AKg/WeVnt3ekOobeFMC1fXVGiD5IGmD8uxF0QuzUyMvQbKuzy?=
 =?us-ascii?Q?3wRE0p2dOS7cnzz3eQr5+s4VMy9Y0EYOH9kRBZlQVwbBikfw84MwJjYlueZy?=
 =?us-ascii?Q?AzB+qMMVuh++UFqlFXhcby/d8xVW0aTmCX/zDpFcZC4LqOGAwuUJlOkJZRiC?=
 =?us-ascii?Q?ghmovsRFzewAkTR/SzSBIhuTqKpAeeGwthGv3FoLHAyLJS0l9tIkCtNGblDG?=
 =?us-ascii?Q?XY2YmXUHkWkU1oAaKwZOzmvShaHV+YaTv4z4SeIEbrzify6bk5E+8kJ7Wixi?=
 =?us-ascii?Q?QOdRtUII00fzdTeOybIh479Yd2LSPPKulecfFonDxNmdtNkmPN/WyNqvGc4I?=
 =?us-ascii?Q?wFoc/EN4kRq8ykAMhcpFZgayBTx8N3+7wwGJPmrHxc0euNvML7d7sRy3JCBC?=
 =?us-ascii?Q?7ldR+ooPx7gICDx4M6PeCu8AaH/2YCqfbyxLnxE9I5alSCFay/8/AR2mpXYy?=
 =?us-ascii?Q?nKUNPAOj3vJS6z+Gxo6Q6WoEgaLDCLuIODHe4MW7SDx50cEQDWguFxPVVKMC?=
 =?us-ascii?Q?RrnpuMvsvRssrF5/ULDniR+X6TKdFjd6kGT4P6AhVoPmaflMTreGw8O2Aii2?=
 =?us-ascii?Q?rkjH5tKLgCvUDyXh6vjZt/1BJGvEJtA3EaD2Mh11r32Gn1wLtjKWfVY+hRye?=
 =?us-ascii?Q?SddgS/F0m9A69voY7BW4uDumwz6vDo58EnVgHROW4qcMGjWuPBkSzZSLn8w4?=
 =?us-ascii?Q?zJJFWbdcYnUbcvafgPnrHTm5jPlLstLmDLsrJ0hLPNFyFBB+WKhDUf1kM/qZ?=
 =?us-ascii?Q?PCYynRb6gnMcOg32HnAr5rJQKXxGWG+cZdcyoQzBLb3Yv8fbk2CxH46JbU63?=
 =?us-ascii?Q?rPcjAlNdOQaTpeiDnd3Llj7dYNLIjx1W8AZAsBuU8ZjgzfOXekV0pa4Cmqgf?=
 =?us-ascii?Q?Oz07rje8LweiruhH4utMEQJjaV3kdWc/lxaG/K9X9dYkxJgT1OLecL/kWbN+?=
 =?us-ascii?Q?z2EzjQUuCG7ukPd56lgS3zhvTwI1BlM/tvgDnXFtidrLdsbgghlO08WDH47v?=
 =?us-ascii?Q?NGAAO7Q2qM5QNl8CISIGHrzNntjB53PJih8vl+q76Cp4eQLTPx48uJ3WZ/xb?=
 =?us-ascii?Q?Pf4F1sfxDS5pFH0oTkuxJHj3EitFlFZat9c7Sm6HCXdR3botLGjVvAyiEgsg?=
 =?us-ascii?Q?YpNkUS4rlpo21ge/rqAZnhD1DemfHWw8AXQ4q3uZwrgme3NqgCE9MUVgR4FQ?=
 =?us-ascii?Q?cUGj3GTa7CFSgkHvT46FeFMYwEZKIYNaOistT2/mwZocWsfk7gl/kAUzXYzl?=
 =?us-ascii?Q?35hhjf3AqR/VqPE/sdlJ+yYb91DRbcYLaMPfSpmwNXZyJ5M/14hbC+DlBe8x?=
 =?us-ascii?Q?o17pZanr+naq7TX562E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6905.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430a1f86-6b81-4bbb-2e84-08dd8bee3457
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 16:02:15.2894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AspZeS3nsIY2cNefIiujkX3OUAHY4DCD9odo169aWRVqgwxIOb8Aoyv28V9ToPPeeqmO6IS3icUk1k42kLSp0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
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

Hi,

> -----Original Message-----
> From: Maayan Kashani <mkashani@nvidia.com>
> Sent: Sunday, April 27, 2025 7:28 PM
> To: dev@dpdk.org
> Cc: Maayan Kashani <mkashani@nvidia.com>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Raslan Darawsheh <rasland@nvidia.com>;
> stable@dpdk.org; Alex Vesker <valex@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Subject: [PATCH] net/mlx5/hws: fix send queue drain on FW WQE destroy
>=20
> Queue sync operation was skipped on rule destroy.
> Unlike on fw wqe rule create in which both fence and notify_hw are set to
> true, on destroy fence was set to false causing previous queue operation
> to be stuck in the queue forever.
> Example:
>    rule_a - HW rule, rule_b - FW WQE rule.
> Sequence:
>    rule_a destroy, burst=3D1 (HW rule put to queue but no DB)
>    rule_b destroy, burst=3D0 (FW WQE rule cmd but no queue sync)
> Outcome:
>    rule_a is stuck forever in the queue - no completion.
>=20
> Fixes: 338aaf911665 ("net/mlx5/hws: add send FW match STE using gen WQE")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Alex Vesker <valex@nvidia.com>
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---
>  drivers/net/mlx5/hws/mlx5dr_send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/mlx5/hws/mlx5dr_send.c
> b/drivers/net/mlx5/hws/mlx5dr_send.c
> index e121c7f7ed5..d01fc7ef2ca 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_send.c
> +++ b/drivers/net/mlx5/hws/mlx5dr_send.c
> @@ -339,7 +339,7 @@ void mlx5dr_send_stes_fw(struct mlx5dr_send_engine
> *queue,
>  	pdn =3D ctx->pd_num;
>=20
>  	/* Writing through FW can't HW fence, therefore we drain the queue
> */
> -	if (send_attr->fence)
> +	if (send_attr->fence || send_attr->notify_hw)
>  		mlx5dr_send_queue_action(ctx,
>  					 queue_id,
>  					 MLX5DR_SEND_QUEUE_ACTION_DRAIN_SYNC);
> --
> 2.21.0

Acked-by: Bing Zhao <bingz@nvidia.com>

Thanks

