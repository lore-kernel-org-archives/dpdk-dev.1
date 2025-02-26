Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D45C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 10:49:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C04024029A;
	Wed, 26 Feb 2025 11:49:53 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by mails.dpdk.org (Postfix) with ESMTP id 0FFD74027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 11:49:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9fD8E7yzCiIM6FUblSraWYP3ALidzTFLC03ni9lveuhY9G9uYw7jG2yS/GnaMT+8tS15qcyqc2MDnYvn4LPU6fUk7rQ0EWiBf+9fa6JO7Ug35agvvUEbr+Zxcq/9Pv+USloOnfV14Q8K7ebieQOqqCEycl8O0i0Fhh2Pj84QpKpZ7eP4DsoZHxGGxlpxFowo7cgPTTOhKqmw9neQNarMkTLtig76/nJW3pcbDnf0mMl43Or8vk8nmKTJtr+OvAkntrAqITh9y6ql2Ak6ZnNzhJ0jdXlpnWmTCFOjwY4VPVXMhS0a55ChKwCGZ4EDNOnG1//2ptW6ULsCBSUhHVy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyH2jQp4IH5GSx+hHNZL3CRJ6n9lINzCb2IBkRCoJ0Y=;
 b=BebHMLHokmv5aYhNVw+oWnOaXCUGfyLH6OCB8aqB4aepoDAIxNN/PTbRnfeK1mN5g+o4hwYpcAcsvfSieqW3GWaAEpehjyhtIUVM/rzPMaVLLRgLwQdhzC6VEPTrRYBaIUprMW/Mp8M5Uf7OS4M3w0wESIBvmB7RsxLgelMShJYL3OPr4odrnhblqTMDOMpT01r0euJqJgofCwGtoVpscQnvAzyOvCBMhKgwpalUc9eioxDHICkDPedAtyB7D21yQUlsmPHNXjcMJ3pT/9ZYxAnt9dVyAJxfawbQvkoW43Yq7vSa5o1/2dJUUKcJOGckWQm9aotZ/Znly+wAfRtO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyH2jQp4IH5GSx+hHNZL3CRJ6n9lINzCb2IBkRCoJ0Y=;
 b=Pa433m3YsTivitFHjlNWtn33xwr0+SEtTI5z9I5PU1q33AknYqn0vqf+GybcdZtvl7y7+KvtMsXEU4yEHjDZdn5/KXnZkAy1tJzxWAeUXh78+ZMZKoxZCRA7j7DPenehsmsFi/ftyEKERhLqx46d4UpVKf6ceFpIYkppeu1EaVhb6Y7ETG6od6LaDmd6THl8TYkLqWZIrnngP+FZQaWDBxLyNRqd3+1JE1hSAfkftQ2BC0YvKbCHehEmZinBvIEzPLLBvS6qgpbjnmFT8Mb+tJLnLS9IaSVzE2iCU8721Aik44AoGo319cH07KBzLlu/dkD+asdLqyb6ekiOB7RvqA==
Received: from PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 10:49:49 +0000
Received: from PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662]) by PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 10:49:49 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Suanming Mou <suanmingm@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH 3/3] net/mlx5: allow FDB RSS
Thread-Topic: [PATCH 3/3] net/mlx5: allow FDB RSS
Thread-Index: AQHbhx6tMti1MtHRDkOdzXm2e/KO5bNZaTSg
Date: Wed, 26 Feb 2025 10:49:49 +0000
Message-ID: <PH7PR12MB690552DE1E8E766B1A208A19D0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
 <20250225004527.2066812-4-suanmingm@nvidia.com>
In-Reply-To: <20250225004527.2066812-4-suanmingm@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6905:EE_|IA0PR12MB8895:EE_
x-ms-office365-filtering-correlation-id: 7db35ab3-f5df-41e7-0d20-08dd56534ae1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3n0Ep5sj23xghNRanevvgQqW2k2JYeagqkYchkjfjY5nYHOkx8kqS8P9nAku?=
 =?us-ascii?Q?i4pJV9MDNerL1Qo3ZtBs8TV+E9qoWIiMOqyNQC5Ubv9R8SYopwlOGkaER2hY?=
 =?us-ascii?Q?QLx8rDQSrUB6qadDxNT+d13jPc1d42UsuPX0toS4r+F8tUdb7CqIz2koLcTU?=
 =?us-ascii?Q?rZuH0J/REQonvtCKbfcAwIGX18XaIVfNwid+d14ccXKRZpdCoejCsuyRxCQQ?=
 =?us-ascii?Q?i9QDwv44IY/cuxOchE8J/JDsIC//lX3F6JnNT/hGMnbgghXBP/TIHjwUNM/E?=
 =?us-ascii?Q?LOFHyNfJYfl25IGfAS2P1mJTb0xI0e6GY3NBQ4uKsyYGDTwFpEapPi+Ma4Zh?=
 =?us-ascii?Q?eJ3a6Y3x2ABy74ELFs4HlOxg5KWcfaTvh7bww77gGULyHEBbeUmT26aUUFrc?=
 =?us-ascii?Q?8RkdxpegAvra6dTKgxcqlr0gKLENoppal4/ERv5vw2FAkSTd+vyraJuxlxo7?=
 =?us-ascii?Q?xfQ5LVC2ea3zZTLISwMHcu+P75/I1NzOdEjo7ItwaXLoEHJhjEJwJGGbJSgR?=
 =?us-ascii?Q?3h2vK2Poj4zcPdfH0vijLmqD3aS/YhEhlsCWZfgfx0vUolwzFNe168DJudHz?=
 =?us-ascii?Q?WUe7Vi0B4qshQObebEFJdbAQVlF24mOKI5B+OAkM2UJsdLd7sgiq3fNTJlZH?=
 =?us-ascii?Q?LKgHmBdL3jkNdaRbMnjTHF65iqz4S7UMGwM/9SzBooNdWfVrM0u/gO5r9Jpx?=
 =?us-ascii?Q?afrtRpkUGFRTxl3+9Kc/9gD3eUaIv+bs79z5CmtWG6ZM4wf+rOWN6gZZ/YlO?=
 =?us-ascii?Q?Bk6upImwdIAAfJQZsCnSZsDSN3PpQcDBJbUwWYJIsqxkHe5uCMmE9gqYXMu1?=
 =?us-ascii?Q?+grQTGrFIxAprf1BYPcMEIwZ089JJdm26kHE/utaxqHaVcfN2PFRqMMeST/F?=
 =?us-ascii?Q?fQLIEKfcX6lzVg9kvRqHWAksSf4foMEl9sQIqjU/peVvdvOCYFpMClWgmeXJ?=
 =?us-ascii?Q?dUZRE+B4QOch8Ks5m967ZdVtFdYG3ldVvQwEKf9vurpHVV0j7eEYYKMvtqkW?=
 =?us-ascii?Q?lVJz0jxt0Oc8Pl5G+jhtAH4NeAazpmQKp0RsvU0xxwT2jzQe4j3VMxDke2Yn?=
 =?us-ascii?Q?76zG6iaFrMUvERuVxDisaolYgih3rsTTJM9KkBl7pDBRmU4U6prfek1hdTL7?=
 =?us-ascii?Q?oUh7BRJiL0GXZlIfeeD6DqUz03pW8iQsdL5LM6I9IK23YDZSbR4sEYAjArAH?=
 =?us-ascii?Q?dJHfYyqUG3cLH1ECrvNI5y/rTACCWkNXmqFjq8TLWMeEZzNrn44O+xwqjPJ+?=
 =?us-ascii?Q?TisciEpmJgo8moonjSArM6tRiby01yXpj/JgcAU8suC8XRyfty7jkvq1NtnF?=
 =?us-ascii?Q?4ySvSOQBpBbXvgDFITSOdNGFNWbRM+TCMZSazzGTNh6a2Ls+I5HQvI90M6Jw?=
 =?us-ascii?Q?nSFQgC09Giuh+9b5vrCstXek4EKZCipkvFfwMQuIdailf0j+UOo+zoQl+ii+?=
 =?us-ascii?Q?G2VtgG1H2gHUUT2WJWb0ZArsNe74p7SY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6905.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SU6w5+Oaiy5IgqiQmvXH+0KwK30SIN6YBnYnJIbm+qUyJ1A4zeIf8ksaz3Ao?=
 =?us-ascii?Q?gnZD6I6iAotLs6GsdxkuvNYwWMzyybXyprH4Xb4BnJwJ3D2CjO0n+xtdCF+g?=
 =?us-ascii?Q?HkDBrGAyk6GYkVf0JPoEQ63WrAyXIXQF54DWtKZasyrzDxSh1qnCh6PhVJu9?=
 =?us-ascii?Q?yIg4oaP7kjV1Xzjdn9vFhmMhXBzt6Zw1jp1dKXrumYR0BCtIvhLQIGVWfpFz?=
 =?us-ascii?Q?9tVZrnPI3ipxsXWOy+nDTn+hbnf60b4KEx6hqkftsnane+/kJqx9GRaO8oGq?=
 =?us-ascii?Q?IwB7xKUjRb8MXkHBYyiDYHJwB2PqkNsIMkeVsvDTjZPBa5/JAYOCTznbLx/n?=
 =?us-ascii?Q?Z+ipkbdh3TVkhnQ13/qC68xezfPATnj1DegD7l5K49zlIycINxijD0v45HSq?=
 =?us-ascii?Q?alvtUXnM5iXlh6Tk/tlcpavq/k3Gv0um38kv+bTTt27VQw/p7UVKZJY2154h?=
 =?us-ascii?Q?vpwhNeU0FJikHMQ6krRPWrUwzQ8tohFQtNZNxBLIH5kC0+q17b6FBkrYsFuY?=
 =?us-ascii?Q?ZGBx4u5Q/ewQSJemw1ytTz8edBdsFx7r2fV056KhBg80BY3xlZapMyxUYSJL?=
 =?us-ascii?Q?pG7Py+Pyh9YJ9n8m6cZlwOibQQnuvGBHC9tqK3Ph3IlgdJbTBEfv5kjfJhyZ?=
 =?us-ascii?Q?7H8LStj/BInWHH6sLs4NUV5jo1WCuuJSDLBf4l9Fwfy8lDYZJRftrV5iDiRm?=
 =?us-ascii?Q?ghqf2r1gGN/TKUw4H7r2tIb6IYreAHlI3hOw8cwJP9RZ07VuIZHDiuUMkmJR?=
 =?us-ascii?Q?/grWQf+sLDJWL3jXAYTxkmjYUvHzPE5bW8gB6NKEfL1d0Sjg2qmOaLaZTzy1?=
 =?us-ascii?Q?UmxVP6M7nH0v+DKW4Ru5+YUJskdrm1Q9B9r9plgOtt4Rlst3vUXt7NG3JHn/?=
 =?us-ascii?Q?3dNim5jx6/MrDriYB0qXX+F4b8hhx1iGo1nBkyd+PhtfoUWAV71j32IuX7zy?=
 =?us-ascii?Q?nT4ku1JLhcnNR5HETgRE5YXH/QG5IOxUFCTlyC3l8SyBCeEcfNi2LzCTfeKZ?=
 =?us-ascii?Q?ELY7/Ok1q1HCLwt5R3YZKu0WcSiIivepp8wngeN21IknrZnrtT42y81dv83P?=
 =?us-ascii?Q?lvKl/PMWfJ+TzgTYI2TeLVCegBDpFPM2/bk/05YJwAP3+MGM6ffvy0/qbb4d?=
 =?us-ascii?Q?VkAZt7nMDnBfSFqKyNNn8/qmsAA1/C5GLo36DNSbZ4z3YVaByiH1Una4MjfJ?=
 =?us-ascii?Q?OEQAgGdCV2W3kdJxIGfT2zUxWe/RcoXAckuCsNINt+Hid+v2UEK6eBcbi7dM?=
 =?us-ascii?Q?1R/D6cfSSRP/hzYWqT1ESErWXbfjLclec8jeZG8v8WVkebOI2VXwebyBRiKN?=
 =?us-ascii?Q?ykFIgeVpJWqEPf/tn+hg0CQdTibYlQw6rbEuLiYCqrEm4PvAnwDPkv4EwfWt?=
 =?us-ascii?Q?5AGCN8zEEvTmUiL/QDjqj16fgR01JJol2EeE7G/1iI92V20qUFLjiuoyqyED?=
 =?us-ascii?Q?19APTp93WY+HyGCAsDYzWgD1CR9Q8ztrvAp1jTjw9fi1U0aV6aK5vuz046qK?=
 =?us-ascii?Q?pEAyTwwmlenjLtgXeAu5eUiaeywgG+As6K03GeK5HIGw3kVsSo6CwSQxqQ2z?=
 =?us-ascii?Q?QJ2AEAXrveFYXKqD94c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6905.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db35ab3-f5df-41e7-0d20-08dd56534ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 10:49:49.4818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6oRTI1/l9gAUQaUiwfhdSzEumYWwycRtSxZzSsWaxDcZPmRgVZ2VY4FLijrW+7uAYXK0uxrnkW+KUbbNEZ7+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
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
> From: Suanming Mou <suanmingm@nvidia.com>
> Sent: Tuesday, February 25, 2025 8:45 AM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH 3/3] net/mlx5: allow FDB RSS
>=20
> RSS can be used in FDB Rx rules when JUMP_FDB_RX action to allow jump fro=
m
> FDB Tx to FDB Rx table.
>=20
> Different with NIC RSS, FDB RSS will not do the internal implicit metadat=
a
> copy.
>=20
> This commit enables the FDB RSS if JUMP_FDB_RX is supported.
>=20
> Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5_flow.c    |  4 ++--
>  drivers/net/mlx5/mlx5_flow_dv.c | 32 +++++++++++++++++---------------
> drivers/net/mlx5/mlx5_flow_hw.c | 19 ++++++++++++++-----
>  3 files changed, 33 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
> index 3fbe89a9d4..9c6a4f39fb 100644
> --- a/drivers/net/mlx5/mlx5_flow.c
> +++ b/drivers/net/mlx5/mlx5_flow.c
> @@ -1977,9 +1977,9 @@ mlx5_flow_validate_action_mark(struct rte_eth_dev
> *dev,
>  					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, NULL,
>  					  "mark action not supported for "
>  					  "egress");
> -	if (attr->transfer && mlx5_hws_active(dev))
> +	if (attr->transfer && !mlx5_hws_active(dev))
>  		return rte_flow_error_set(error, ENOTSUP,
> -					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, NULL,
> +					  RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER, NULL,
>  					  "non-template mark action not supported
> for transfer");
>  	return 0;
>  }
> diff --git a/drivers/net/mlx5/mlx5_flow_dv.c
> b/drivers/net/mlx5/mlx5_flow_dv.c index 633c41e358..61d3101ce8 100644
> --- a/drivers/net/mlx5/mlx5_flow_dv.c
> +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> @@ -8939,21 +8939,23 @@ flow_dv_validate(struct rte_eth_dev *dev, const
> struct rte_flow_attr *attr,
>  						  RTE_FLOW_ERROR_TYPE_ACTION,
>  						  NULL,
>  						  "unsupported action MARK");
> -		if (action_flags & MLX5_FLOW_ACTION_QUEUE)
> -			return rte_flow_error_set(error, ENOTSUP,
> -						  RTE_FLOW_ERROR_TYPE_ACTION,
> -						  NULL,
> -						  "unsupported action QUEUE");
> -		if (action_flags & MLX5_FLOW_ACTION_RSS)
> -			return rte_flow_error_set(error, ENOTSUP,
> -						  RTE_FLOW_ERROR_TYPE_ACTION,
> -						  NULL,
> -						  "unsupported action RSS");
> -		if (!(action_flags & MLX5_FLOW_FATE_ESWITCH_ACTIONS))
> -			return rte_flow_error_set(error, EINVAL,
> -						  RTE_FLOW_ERROR_TYPE_ACTION,
> -						  actions,
> -						  "no fate action is found");
> +		if (!priv->jump_fdb_rx_en) {
> +			if (action_flags & MLX5_FLOW_ACTION_QUEUE)
> +				return rte_flow_error_set(error, ENOTSUP,
> +							  RTE_FLOW_ERROR_TYPE_ACTION,
> +							  NULL,
> +							  "unsupported action QUEUE");
> +			if (action_flags & MLX5_FLOW_ACTION_RSS)
> +				return rte_flow_error_set(error, ENOTSUP,
> +							  RTE_FLOW_ERROR_TYPE_ACTION,
> +							  NULL,
> +							  "unsupported action RSS");
> +			if (!(action_flags & MLX5_FLOW_FATE_ESWITCH_ACTIONS))
> +				return rte_flow_error_set(error, EINVAL,
> +							  RTE_FLOW_ERROR_TYPE_ACTION,
> +							  actions,
> +							  "no fate action is found");
> +		}
>  	} else {
>  		if (!(action_flags & MLX5_FLOW_FATE_ACTIONS) && attr->ingress)
>  			return rte_flow_error_set(error, EINVAL, diff --git
> a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c index
> 83f55ed3e8..a063e5ac9c 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -7026,6 +7026,7 @@ mlx5_hw_validate_action_queue(struct rte_eth_dev
> *dev,
>  			      uint64_t action_flags,
>  			      struct rte_flow_error *error)
>  {
> +	struct mlx5_priv *priv =3D dev->data->dev_private;
>  	const struct rte_flow_action_queue *queue_mask =3D template_mask-
> >conf;
>  	const struct rte_flow_attr attr =3D {
>  		.ingress =3D template_attr->ingress,
> @@ -7034,7 +7035,7 @@ mlx5_hw_validate_action_queue(struct rte_eth_dev
> *dev,
>  	};
>  	bool masked =3D queue_mask !=3D NULL && queue_mask->index;
>=20
> -	if (template_attr->egress || template_attr->transfer)
> +	if (template_attr->egress || (template_attr->transfer &&
> +!priv->jump_fdb_rx_en))
>  		return rte_flow_error_set(error, EINVAL,
>  					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
>  					  "QUEUE action supported for ingress
> only"); @@ -7053,9 +7054,10 @@ mlx5_hw_validate_action_rss(struct
> rte_eth_dev *dev,
>  			      __rte_unused uint64_t action_flags,
>  			      struct rte_flow_error *error)
>  {
> +	struct mlx5_priv *priv =3D dev->data->dev_private;
>  	const struct rte_flow_action_rss *mask =3D template_mask->conf;
>=20
> -	if (template_attr->egress || template_attr->transfer)
> +	if (template_attr->egress || (template_attr->transfer &&
> +!priv->jump_fdb_rx_en))
>  		return rte_flow_error_set(error, EINVAL,
>  					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
>  					  "RSS action supported for ingress only");
> @@ -8104,6 +8106,7 @@ __flow_hw_actions_template_create(struct rte_eth_de=
v
> *dev,
>  	}
>  	if (priv->sh->config.dv_xmeta_en =3D=3D MLX5_XMETA_MODE_META32_HWS &&
>  	    priv->sh->config.dv_esw_en &&
> +	    !attr->transfer &&
>  	    (action_flags & (MLX5_FLOW_ACTION_QUEUE |
> MLX5_FLOW_ACTION_RSS))) {
>  		/* Insert META copy */
>  		mf_actions[expand_mf_num] =3D rx_meta_copy_action; @@ -12112,23
> +12115,29 @@ __flow_hw_configure(struct rte_eth_dev *dev,
>  	/* Add global actions. */
>  	for (i =3D 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
>  		uint32_t act_flags =3D 0;
> +		uint32_t tag_flags =3D mlx5_hw_act_flag[i][0];
>=20
>  		act_flags =3D mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_RX] |
>  			    mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_TX];
>  		if (is_proxy) {
> -			if (unified_fdb)
> +			if (unified_fdb) {
>  				act_flags |=3D
>=20
> 	(mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX] |
>=20
> mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_TX] |
>=20
> mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_UNIFIED]);
> -			else
> +				if (i =3D=3D MLX5_HW_ACTION_FLAG_NONE_ROOT)
> +					tag_flags |=3D
> mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX];
> +			} else {
>  				act_flags |=3D
> mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
> +				if (i =3D=3D MLX5_HW_ACTION_FLAG_NONE_ROOT)
> +					tag_flags |=3D
> mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
> +			}
>  		}

One small question about the TAG action flags in this case. If unified FDB =
is supported, should only FDB_RX sub-domain of all FDB sub-domains support =
the TAG? Or FDB_UNI also supports it. And if no unified FDB, will the TAG a=
lso be supported in the legacy FDB domain? Can we add some code comments he=
re and update the limitation?

>  		priv->hw_drop[i] =3D mlx5dr_action_create_dest_drop(priv-
> >dr_ctx, act_flags);
>  		if (!priv->hw_drop[i])
>  			goto err;
>  		priv->hw_tag[i] =3D mlx5dr_action_create_tag
> -			(priv->dr_ctx, mlx5_hw_act_flag[i][0]);
> +			(priv->dr_ctx, tag_flags);
>  		if (!priv->hw_tag[i])
>  			goto err;
>  	}
> --
> 2.34.1

