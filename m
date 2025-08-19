Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E392ECA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 14:50:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3969640654;
	Tue, 19 Aug 2025 16:50:46 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by mails.dpdk.org (Postfix) with ESMTP id 20CEE40653;
 Tue, 19 Aug 2025 16:50:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9hBEKslZrDlGeGRruMw5VTPFjQnzOabq5XQxcNyC0AOdfCXMQi+meTS2+fzG4fp83tE0c+/E9GqgiDUNfsxJCQzCbUbHV/NdfhbLixgvuSa1KqGTDuU5obbYGK9k+MKS60NMsG1GN/KU3q2NUumPeF/6qAVlJY/2W96Py/x5/xvtmEoy7JWMhyWA14A5gjxnUb7rHynjJ6sYT/Tx0ie/Mi4xE5gno9MhAzLnSkfan3/1EF6Sch8kai/UT7rA9PdqKMUJE8fIPgAXEpF73DFqifxfBUQhbNmDDA6chpdmzOE623wdDovzwjwARrA4ZFTLkl9kjK3atATqtf6bg8q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=070d0oUvscYEdYv0zqg6zoUaW+wGKod3soG84opvp+s=;
 b=Wu3px3UMDVXUaalVZ3NAy5qj0yn1SevIgVIfZ/LsPoZAI/sAGVUPXVrrD28sIzanjAP+gnJuLFc3gUN40DRxVH+gZfSUUvxqpO7lSX1RmgIo8ZfGBvhAT+xrxpQRWs0tAGSAy0hJm5zo3yqBoRUAsmdcvOqz1YsGh6I6Hsw1ilzNtIaU7kI6CPhr6tZZObca2MJl4w33WCKoDJwJ14B+VPjGMEbACHlTRkpMJpCNpJl75XG1txFEh2/Jp9KJsYb35QF+E8F7aNwzuqS4YcKpNyqWGWKuVJAIVlrXTOIcyzhnJIFE2ejBHmerepbhKD13ZJn7FYCB8TSsiflH0yNWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=070d0oUvscYEdYv0zqg6zoUaW+wGKod3soG84opvp+s=;
 b=BTEew4wfyAgeGiV+GCdqfQ6zDzKnxmRVWx7mlQBGnMaTxX4IFqqLYbEBt21RqWTa2Ncr6NP7oU73lqx09rO2PQtEjRSXi3lWiErY91ZObs955ohm9k6U8J1gU78ziyNqdMeXDBAmsCiHUE4j/psJ+EsZzCYpEIyTesw1Jy9AWazSGpzM54H4MPGN9NS3nRXSEJ10GwgMPHPmAHgOJeS07l5SUmvs1n05kkQvb/2/uPZ55XEXqoEuPkYjl1neZRTs0he6ilLNsxftH0lK6Q8BhyibhFo8BRFLRfOkkT9bjz5ftMenS35Ki2nWwrNBC+/oWb86vTlQm8S3+glH0GOeNw==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 14:50:40 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7%2]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 14:50:40 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Alexander Kozyrev <akozyrev@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Raslan Darawsheh
 <rasland@nvidia.com>, Ori Kam <orika@nvidia.com>, "NBU-Contact-Thomas
 Monjalon (EXTERNAL)" <thomas@monjalon.net>
Subject: RE: [PATCH] app/testpmd: use table ID for jump to matcher action
Thread-Topic: [PATCH] app/testpmd: use table ID for jump to matcher action
Thread-Index: AQHcERgcZorBBi9v+ECB0jRiIeVT2LRqDknQ
Date: Tue, 19 Aug 2025 14:50:40 +0000
Message-ID: <IA4PR12MB9763631C4FA0466668F81E41D030A@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20250819144508.722653-1-akozyrev@nvidia.com>
In-Reply-To: <20250819144508.722653-1-akozyrev@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|SJ2PR12MB9189:EE_
x-ms-office365-filtering-correlation-id: e1f9245c-1355-4a59-4186-08dddf2fc44a
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?P7ZdF/2H+ucNCRzxgfBTi5NCkUgGZFrfhAY5mqlmvZ/5EP0TIshUuC5fw66G?=
 =?us-ascii?Q?Py36RwzQCgSdTIC0+ToLv57aYS+zjxfELDHwYjXoL8kA8KYX56/ekz1ZaXgX?=
 =?us-ascii?Q?QWjR3p/5EfQXYlBGq0/iVXhL249Vd5sByC8Wzr2wjOC8/wt/YKhDsSM+LL4E?=
 =?us-ascii?Q?dHhgp9uXeB6BPFza9FSAz8QOETAMtiSGeJtI3YF2Z8g2m3DU0ThBX93OSBCq?=
 =?us-ascii?Q?9EN6NNOvfEWHDGWhrwjFq4IygS/6inOD1zZZPpQj1eZLXS33zwwFcnOq1QDX?=
 =?us-ascii?Q?6i9HzPWNzo7fTSO+U1ce9U+1DqyK7hjEyqk1DZt93CLRMOMzo+S3eb5i93L5?=
 =?us-ascii?Q?rf30zF2HYlM51mKOBaxAPi8fdFn8ZBGt1rTovjiY6jQ6+AHbGtZLfC3CoyPm?=
 =?us-ascii?Q?LxCgNmo+1YursN65t4+qkoJ25m6TFMEklNnpWa0c/G0j100OCVrFAvoc701q?=
 =?us-ascii?Q?eQ9HZmI5QUivkAY2n9fTfiGSMqogGH5eO2m3VhMeAQPvgu5QblVaZigD5egV?=
 =?us-ascii?Q?U8MX2ibKFoLjOzRf6PyrnwNnmsaB8ZQikiRmIchqZFHAAb5T91KAEY/23SHF?=
 =?us-ascii?Q?aejsmzRztmUiUVP5GIiZCOBhjtkZansQCOJQfyqu+KkqtcGQtVhgC3ZvyIdR?=
 =?us-ascii?Q?LeqeJ4j+5Hfh6kRk1g1zv9nBIFHouw0nH4bpIPMHTCysEQNz1hSHJAu0qej+?=
 =?us-ascii?Q?IFOXbhTiZOvo026NsqpiIHKMux2fs9ZpdC9BTk87o0KFuoPBCkgSgHVIbUDo?=
 =?us-ascii?Q?th27utQYN7N8hyp3xPrsg3TTiDEExC4e3anrKYz+/sbSnYndnNMUjt0/kMNH?=
 =?us-ascii?Q?B6aQMVj48JpwmDJJG3G1f7Z2vpU9ynUiWP2fAqNwTS8oYKPlN2IlDDBZBlm0?=
 =?us-ascii?Q?HzlCQzBlPyZn3AxzpUxpoDbuBPAmi0rFfQWqFdrxfpiV2yhQTiieV6YHG+jR?=
 =?us-ascii?Q?FrdsSmXIdhS1c5JwQnLnXIAGcbsSGpxKTRtGoNOhycBQOIxA49Zm1Icp3NI6?=
 =?us-ascii?Q?1Fjw9nE5SBYEjZrUVoSyLNhivS4Z40GUYcXlGhB84zMrQxW+BBqpNtkA2fY6?=
 =?us-ascii?Q?TQXMz/SqxOTv+M9RYo9Zj5PpfXH1GB07hDXTNHrXq2g7QTPOMyVQmHIzDN6l?=
 =?us-ascii?Q?cuaTpYfH6mQnO0UIhax97SxDEz9gA8BVirlnFXrw/BJ/AKgo1I46FiE3loNr?=
 =?us-ascii?Q?DVV0P13KaSKjSgxPjn2YS/XAYyiDaUKGtuxdwGKCMuoKTfmka/3E7ijRM42k?=
 =?us-ascii?Q?nMJhQOkjhXBl7kvZE3SYdIoi0XdHszcBGysQ1PVSOZ0sfniotNHs+DnSeWfc?=
 =?us-ascii?Q?/a2W8YIGyr7OHaSSRsco0A/dtrzknz1lyuo2Bj63GdeFSqXQFtsLUp+go1zJ?=
 =?us-ascii?Q?40R+RqF5OIH1oxsSj3wGaMyxbQV9jWWZomkWuL9KyCCAJoM0BpLsG8rOrj1+?=
 =?us-ascii?Q?oFQhp1GT40qJTYUHyxTW+QKMa87n2toqeMyM9qH2adseIPo6GPADJr3j40sr?=
 =?us-ascii?Q?sTnsKgjY6uyaXIo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e168W/XmP8y1ETdXC+pW31Hgq4ixYfd8A2iHjjTeUVmAOkeQafivmieTLGSu?=
 =?us-ascii?Q?D7l7yPIt3My/Bnxm1s2k49KvnPxnuFk0b98hy/ypoYU0UTHjdIXtZ9fVOxy0?=
 =?us-ascii?Q?Y8YfuV7yaiRRiyBjh09XL/iEI/YNR8H28ZlVpyffOp+cJE5tnosBMZgT5rYP?=
 =?us-ascii?Q?8z5LCXGAbT5+ejcZ80PekcmMhMOlRk0Mb9dzHbn4LGlJA6D9cTVqS8iVXJ9K?=
 =?us-ascii?Q?PjaMVgU7ChPiifKPpYr6uFxjMuINYj75M0ZEFrMAdrk1+R7bJYHVb4j9J2lr?=
 =?us-ascii?Q?Vv8VfRnIUZyaOoAK3gouikXgKpM7s5r4lLRoDY0UxHACEyilR7/Y+wXEK4Xj?=
 =?us-ascii?Q?+zMeLRom3rG9ecGkXAx6XBORX0FpZ2VuJZvjKB88IlgpZr3el7jqNT0JdqjR?=
 =?us-ascii?Q?5gxcyOGyQQw7c8oe44OGx9gG3pvIZ54QUpszC4kQa6fZDnNRHdNJmfHnBg4c?=
 =?us-ascii?Q?FjZuDB6jUoiulFCh47cJXfFWyD2cXvFt8ftEycjlRNsCC/pf3+X8lZJbTGKx?=
 =?us-ascii?Q?88pF0fXMx/4J51MsiDg9BmR2uIV2AcKZE77l8dxgQkrfVQUFl3I0dbMPAoiy?=
 =?us-ascii?Q?295FtZNXucHa0ucS59W1PaGwY96zYHDPxGwJzuwf4REXg8TxfcK2k4l+xl3C?=
 =?us-ascii?Q?Eo3RejBlWUBvMo5kMxGSxlU696eC3ppkZBV74AUEQW2ZpbAQ4DVyPz03hcOB?=
 =?us-ascii?Q?ruvuZ+SH1k8LVTO77RQI5VqD7b1wh95H13a4Jgsk8faZM1QRxNN78LcDMRYs?=
 =?us-ascii?Q?//+KPxW2W6DbNqnR1vvQfss/kyUWSNg76SEZN6zKEXyq9Amq9yc8e9BJAaID?=
 =?us-ascii?Q?hPXKRcqNP8yI10c5agF0iiEhkJQU/Rr/jId+kHW+/CaFYLn1qqGOvCbK+4hG?=
 =?us-ascii?Q?DbANfuqxdz/ISIsJS6p5N5SQ3opGyRAWrdlPeWadZGYjYAz7+lSQHT8KkTHu?=
 =?us-ascii?Q?R1VvydaWhYyF6Ye0d+LUr18Io+wTsZcO5HNZzPNh9903R9QL0qnWbhjtuXgQ?=
 =?us-ascii?Q?R/4XimA2DJpHkpYnu78XwCIjMPm3Vixklo1UpVUSgzZdoUxXJqTqlhRbyd0u?=
 =?us-ascii?Q?56F9Jmn9dcZZzrq9C/9BQPXww3uSzG4FzrQFpgQxR+b9YUiDEhC1jywo1rUy?=
 =?us-ascii?Q?8jFehzHtJ6WWtSnuJ27AvzF+QV8GGF9PhdTYxZeNCHEALrESmSs1wKGEOOlP?=
 =?us-ascii?Q?pbPh6/riQX5hMH4OONiJklqRVthPBPgh7vI4AG+fqIOozwRJiwqvcxAZM9VI?=
 =?us-ascii?Q?DLRMe55oWs4irUavE0J1MTtOAvGpAkl0Ey/ZXExEdR44x0aucfmjrwnTZs08?=
 =?us-ascii?Q?gFJHAmiiTUy7znYVZ0OkC5sNyh4bFuEnbEves7Im4c3kZqyrdX2jhYnBEuQU?=
 =?us-ascii?Q?WZmB4l8jnYFypSmFI66mEk7IVuEBJPatJToGuzDBzDl0Qpndidh6fBFSn+S8?=
 =?us-ascii?Q?arz1CLNz51fiw/0dOXGMe8/2tO0YRzNFZT/7b3as9dtsExUX/jWl3Tiji13W?=
 =?us-ascii?Q?WLfISWw7i/j+9NO86RLNq0Zyxq6DlO6FP4y4hZeArIfZmTcT6BLgh93AXmxZ?=
 =?us-ascii?Q?LnJt/+ITdxvNB5SPkx4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f9245c-1355-4a59-4186-08dddf2fc44a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 14:50:40.5319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FDUnrMxFSYv2lEkvkJ/WAFbad025E33tJUX3cAg1VKrZDMHvZ8PI/Jk+CiWNHnWehRVjmfwkb+6abxLj+VdFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189
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

The testpmd maintainers should also take a look.

> -----Original Message-----
> From: Alexander Kozyrev <akozyrev@nvidia.com>
> Sent: Tuesday, August 19, 2025 10:45 PM
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>
> Subject: [PATCH] app/testpmd: use table ID for jump to matcher action
>=20
> Current implementation requires specifying the pointer to the table you
> want to jump to in the jump to matcher action. It is inconvenient since
> there is no table pointer shown anywhere in the table management.
> Table creation/destruction uses the standard table ID for that purpose.
> Use the table ID in the jump to matcher action as well.
>=20
> Signed-off-by: Alexander Kozyrev <akozyrev@nvidia.com>
> ---
>  app/test-pmd/cmdline_flow.c | 59 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
>=20
> diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
> index 38e751f3f3..5d9c8f04f2 100644
> --- a/app/test-pmd/cmdline_flow.c
> +++ b/app/test-pmd/cmdline_flow.c
> @@ -788,6 +788,7 @@ enum index {
>  	ACTION_NAT64_MODE,
>  	ACTION_JUMP_TO_TABLE_INDEX,
>  	ACTION_JUMP_TO_TABLE_INDEX_TABLE,
> +	ACTION_JUMP_TO_TABLE_INDEX_TABLE_VALUE,
>  	ACTION_JUMP_TO_TABLE_INDEX_INDEX,
>  };
>=20
> @@ -2864,6 +2865,9 @@ static int parse_table(struct context *, const
> struct token *,  static int parse_table_destroy(struct context *, const
> struct token *,
>  			       const char *, unsigned int,
>  			       void *, unsigned int);
> +static int parse_jump_table_id(struct context *, const struct token *,
> +			       const char *, unsigned int,
> +			       void *, unsigned int);
>  static int parse_qo(struct context *, const struct token *,
>  		    const char *, unsigned int,
>  		    void *, unsigned int);
> @@ -7634,11 +7638,19 @@ static const struct token token_list[] =3D {
>  	},
>  	[ACTION_JUMP_TO_TABLE_INDEX_TABLE] =3D {
>  		.name =3D "table",
> -		.help =3D "table to redirect traffic to",
> -		.next =3D NEXT(action_jump_to_table_index,
> NEXT_ENTRY(COMMON_UNSIGNED)),
> +		.help =3D "table id to redirect traffic to",
> +		.next =3D NEXT(action_jump_to_table_index,
> +			NEXT_ENTRY(ACTION_JUMP_TO_TABLE_INDEX_TABLE_VALUE)),
>  		.args =3D ARGS(ARGS_ENTRY(struct
> rte_flow_action_jump_to_table_index, table)),
>  		.call =3D parse_vc_conf,
>  	},
> +	[ACTION_JUMP_TO_TABLE_INDEX_TABLE_VALUE] =3D {
> +		.name =3D "{table_id}",
> +		.type =3D "TABLE_ID",
> +		.help =3D "table id for jump action",
> +		.call =3D parse_jump_table_id,
> +		.comp =3D comp_table_id,
> +	},
>  	[ACTION_JUMP_TO_TABLE_INDEX_INDEX] =3D {
>  		.name =3D "index",
>  		.help =3D "rule index to redirect traffic to", @@ -11182,6
> +11194,49 @@ parse_table_destroy(struct context *ctx, const struct token
> *token,
>  	return len;
>  }
>=20
> +/** Parse table id and convert to table pointer for jump_to_table_index
> +action. */ static int parse_jump_table_id(struct context *ctx, const
> +struct token *token,
> +		    const char *str, unsigned int len,
> +		    void *buf, unsigned int size)
> +{
> +	struct buffer *out =3D buf;
> +	struct rte_port *port;
> +	struct port_table *pt;
> +	uint32_t table_id;
> +	const struct arg *arg;
> +	void *entry_ptr;
> +
> +	/* Get the arg before parse_int consumes it */
> +	arg =3D pop_args(ctx);
> +	if (!arg)
> +		return -1;
> +	/* Push it back and do the standard integer parsing */
> +	if (push_args(ctx, arg) < 0)
> +		return -1;
> +	if (parse_int(ctx, token, str, len, buf, size) < 0)
> +		return -1;
> +	/* Nothing else to do if there is no buffer */
> +	if (!out || !ctx->object)
> +		return len;
> +	/* Get the parsed table ID from where parse_int stored it */
> +	entry_ptr =3D (uint8_t *)ctx->object + arg->offset;
> +	table_id =3D *(uint32_t *)entry_ptr;
> +	/* Look up the table using table ID */
> +	port =3D &ports[ctx->port];
> +	for (pt =3D port->table_list; pt !=3D NULL; pt =3D pt->next) {
> +		if (pt->id =3D=3D table_id)
> +			break;
> +	}
> +	if (!pt || !pt->table) {
> +		printf("Table #%u not found on port %u\n", table_id, ctx-
> >port);
> +		return -1;
> +	}
> +	/* Replace the table ID with the table pointer */
> +	*(struct rte_flow_template_table **)entry_ptr =3D pt->table;
> +	return len;
> +}
> +
>  /** Parse tokens for queue create commands. */  static int
> parse_qo(struct context *ctx, const struct token *token,
> --
> 2.43.0

Reviewed-by: Bing Zhao <bingz@nvidia.com>

