Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C05FD9E25
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 23:51:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C63914028E;
	Fri, 27 Feb 2026 00:51:32 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11020141.outbound.protection.outlook.com [52.101.201.141])
 by mails.dpdk.org (Postfix) with ESMTP id AB36040265
 for <dev@dpdk.org>; Fri, 27 Feb 2026 00:51:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOJbuieWgnmZppNNjvvWlri4w+QUoXvVOYy9JFaP6hxUc+Wl8YrTsdFNYz0J1AtnMF5Mk4vBZXFHx+0SIsu9nmUmSg7gIUT0/EwpLGxpJjHok2YyInj3WCnID9LzAFEO/TcGew71xNZqXwdsx98OUm/aKg0HAkJC9OZHBDp1Fn4m7RH/wJZvYOrWnt5AI7PPjKml+Och2XzhXHn1hWNvIRa77TfGKqB2dw7hCHIXqcDaV9UQcr1lRAQbH7Y5tT/XvrJVJQ13xVqSWGBOdlFH9SNqBcWWKfNnXe8+k8ifJF9NHSMFmk+fZZWqFfpW9zpR3B6uKNThvaAjIAk50dBsmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj6Q8zeDa/Tl6haHwYDbvkMR+GPril/fwPmUNgrBEd8=;
 b=inBF22kVB8sPxkksgA6LN2qaxCSxQoUjo8tWU8thtGzduu58ysUGJSNIS3eXzGFmEykyRhjrrJo2Ef1n3EtMrRs+r2mMd1U4EomGMl1bJIU5s06OkQSroYLhbLFzbu1PEumuuzh5aZUyivQhcwmZLB/jblF60wxW/WsP8hzYTLR52ic0oujH1QvBqJ692BnAohi7Z4EeSMW5SxHTqO1szknk4Qm1NnTyjwKgPI4WwVqG9h3fknVRcbKNVxUivQx18C6m2CyInEVnoFMw8Wh9U2h6AXaIWIirz+eSEZl+c6cc/0a0kBXhAqBLY/f/BHe3jTccokThsGv/S9VxIL5K7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj6Q8zeDa/Tl6haHwYDbvkMR+GPril/fwPmUNgrBEd8=;
 b=VBdBZNlhNPPHj6Q4U7yyKVuTKG3aWwx90XbpPUe21RQCxMgEU3Q52FF3+DfeYuKPlUd0LEBjSq4eaw7KcT40mL4xCWkJCDc08E+ZdeWFBD96QbkwzpCeOwniFb0Z6zven1W385V45EKjpCTQzriKFfAgsv0qzfLns55eORQricQ=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS4PR21MB6486.namprd21.prod.outlook.com (2603:10b6:8:2ed::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.6; Thu, 26 Feb
 2026 23:51:27 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 23:51:27 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] [RFC] app/testpmd: add configurable flow count for
 txonly multi-flow
Thread-Topic: [EXTERNAL] [RFC] app/testpmd: add configurable flow count for
 txonly multi-flow
Thread-Index: AQHcp3btiOJwJ8Dd3kG6iwi0sffRhrWVpn3g
Date: Thu, 26 Feb 2026 23:51:27 +0000
Message-ID: <DS3PR21MB57353E44A4187ADE53DEAED7CE72A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260226191625.1049670-1-longli@microsoft.com>
 <20260226232323.545972-1-stephen@networkplumber.org>
In-Reply-To: <20260226232323.545972-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f3fbbe47-8820-4b3e-8022-f441748176e4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-26T23:50:38Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS4PR21MB6486:EE_
x-ms-office365-filtering-correlation-id: 9fce3454-afe5-4292-9a60-08de7591f50e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: Zvhmez3EzV0JlNzp4BUnuuewJqOZDD4lH45Jt6rJs6lmyUfjSa1XMrfVfS7UxvBf+GbzdyvX0n6USsK5DEkgyx3qb0Pfsd/1Q88oyubXFPRJXPBEBD9c+3Dn/wItSif+NT1URJbZKBO7bJkpvOq2nqRK9NekWe5ks1yj+P4zsDByIidvWe3SAnOi/FrtoNwFSL8w/XRsr74s2SNdg0VkDO7Sy8e8JlVS/wA/UqXdJS/41kSna7v2bOkYFb6RuqEMERAT3W9P44bezr9oydRCh8qLlpWny9TLlq8OHu4+bo2dqaucWJlbr5vdVtLSTPaT/WDZkNtLG9rOqFZP3x8i5y1d+1wZmhDu3Rg7l7etSHn55e5PqKWJAHxxr3drP5niA/pq/zZuRqcHC2L/urhBs0n2j1KqN8rMrEl02mpovQOlT/DBQqTTsPYjy4qu0E2PkBv2Nw7oNVkoL+RCa3VHSGe956hzI76xYa1d/na4y5P/P69ADw8Tcd0DMDNtIaiEW5ynN32yx5GXf3NfTUSo6BmmVdDMvBfSOSIjzMZHdW93/v5H39UdxrI4MP0HIgCsuVhuSxADIsXp6YyzTunv1loFKrqey14zPwYZh4l7bVOd2KRLX6BQKndhUEx9LiVY08+HKbpalpwXKrz+QNJUzzgc4bw+uKZ4LE7hYowDhClJArJYRC76/eVq0kJddYaR+6V7QYISFcAMR+lBepK5mqvXCo8U880vnf1GZo8XM0k9k7xzJ5bPnF8bvgwFEiG2s5jEwxZHoS2FYXdkAZA7BoAklbYzUiTlTH6MGr6kV5U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZxIpQdbbVNmL6ShkbmrN/7lXw4g4PVYymPFUl2XKBm20tiFaBx+LGlULbwV+?=
 =?us-ascii?Q?MjFXkB1oK0QI7cFlqtRLner61nUxfL1l9iB58MRQvFwk3WmSNEgl/IGljonD?=
 =?us-ascii?Q?SXyhdE2+IiNTj9d8l+ySvKJTMklUOWYOifkAnHBn5EOAKHcnk82GDVUqR8yg?=
 =?us-ascii?Q?IdATqArKJpEp2anJJHKO2QnP8PMo1dyc3xLWXjdHy9FwSk9DEjowhq+xShYH?=
 =?us-ascii?Q?i6dz7e/MA7FkDEL8iUvDRGiVYwM2OFmEpltBp2OCgG0xXis2p7YkNSsXDreP?=
 =?us-ascii?Q?O6zrBGT9KqEGfBI2EstzjdVGfG6hT7kchMLAtxx/L2e6i95ousy5qpBbNudp?=
 =?us-ascii?Q?A/riWyymNx6K4PTcUDDsluHQUf87cVxLlnl5lnntI3l5WxmFHNNfUkpBS6U3?=
 =?us-ascii?Q?k/qUQKZT2RVWNvtK3jmoB31GLf2YjFoppT3PMD68sjZ0uren1Q/ToscstPX0?=
 =?us-ascii?Q?bbLvbGP+LNNFMwj5Qet8yBfMwTBxWVN3hxKv9+CzFkynkQpG6fMep3JY1TGz?=
 =?us-ascii?Q?nL8ZI35AeYcgx8MJ4PCnoJamUx4yme2/l4WR6Wfos6q9wo8v2MBJ0HopBC4/?=
 =?us-ascii?Q?SfSb6wICacK8HL3ck5jXPlA0oxjMR/iL4SrDUn6uxMCIRBZ8Le+DAUjxmO6I?=
 =?us-ascii?Q?WgkziorfyxSDP/ex0QE2JqvlCUn7dBT/qnOIB8nivlLEflCx16a/QvmMMhr8?=
 =?us-ascii?Q?KiZyVnfXASyRh3TzF1OwOPWL76oGV1Fm5PlJ1TTn+yU50vpQ/YBz1G5pAcYK?=
 =?us-ascii?Q?eqtn9CvVCex8c5Hzohmnxs+zVEriFmJGF0ok56iXfEob8C9DUx85WjbIVVwc?=
 =?us-ascii?Q?LXnzkxtIGfEeQPHXAZ5VLk0pozTw+VKPIOTvUhB0aGa4A2gGAKmOXPpzXhV1?=
 =?us-ascii?Q?dLemkYZ2iKiO+azaHt6naBatIVYgmqVzp2/yJVZzw8lykY6PnjRbSWCL/AQR?=
 =?us-ascii?Q?UYUk0lAF7UpXotQvRBlZcbWbV3hIuiQJlyyUTI621fkrCGJTRhUf62PP1Gxs?=
 =?us-ascii?Q?6sJJj90xxXY68wOKJdPiRhZKmh4H2JQ7+zbdAp1vq0Yk7rU8kJ9mS7l35iHw?=
 =?us-ascii?Q?wrrSfCSRuYpCA9HQrFkILxSiUk4tVEftxmxtXrVg5Hhb94Vvan4wjF3ymikh?=
 =?us-ascii?Q?RFEQmX/ucLImNYCd3HNgXWooCeA4hbM72fjgWmBVGC8LANRiYds9SRRgap7l?=
 =?us-ascii?Q?Phc3lj796jtJGYjaTVLQTO6S9kMdP39oRWulZzCMoXfzQ+G+4KrZHdxQGJ90?=
 =?us-ascii?Q?LdPZ8DdvrrR0dO26H7VplqqGxxh7/GGaU8SwXS54tON6M8EfUKLQCBQutoXm?=
 =?us-ascii?Q?XCeVhA6Os1Cxw28cMXcNKyhU0n/lC4tduqIxxe17nwbATu0U4luftSwmYohw?=
 =?us-ascii?Q?mWbk1v2IMlNwDtrSuuNWcn4j4kEiSc30FN4ELUHKpnUq/sEn63ZWlkKlLItB?=
 =?us-ascii?Q?a3SLHS1NezWHnXKyIIMbtfgQAPQ51G748Sfk1ghNP4E9GDi8yU8p5mYLaHJv?=
 =?us-ascii?Q?4lT+YLPwpXbgB61IdpBKOXR1yyhniJTDvLcPOTtfl846FgCFt2KEwnHqVJX+?=
 =?us-ascii?Q?3QKi1IJeJDpaQqrdB82uy+HR3MyjKHFdCzX7MReoszWMFKeUr7mPaGwXHIF+?=
 =?us-ascii?Q?jd7bPDkgv+H5enmXrIU4kM/hTcXQ2Y2ppbheX52QIF0UvMZUNEMcL36kenRn?=
 =?us-ascii?Q?0Bw0r9kuIUjrqmYwATBSj9Ry+8CcI8TpOoYzyepPwjsfyFx1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fce3454-afe5-4292-9a60-08de7591f50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 23:51:27.5036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbNWgZVqbzYc/GkS7l+GnFR0curbEulC3U1VfWweoroQlOCYkf0xuIumNA7itCy3R4VqzMOfMESeyHl/uWFTEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB6486
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

> Subject: [EXTERNAL] [RFC] app/testpmd: add configurable flow count for tx=
only
> multi-flow
>=20
> Started with Long's patch to change port and added a parameter.
> This is suggestion only *DO NOT MERGE*
> Not sure what good name for parameter is, this is just a quick hack.
>=20
> The txonly multi-flow mode generates 64 unique UDP source ports per lcore=
 by
> cycling the high byte from 0xC0 to 0xFF. On SmartNICs with limited hardwa=
re
> flow table caching, this fixed count can exhaust the flow cache and degra=
de
> receive-side performance.
>=20
> Add --txonly-nb-flows=3DN command line parameter and 'set txonly-nb-flows=
'
> runtime command to limit the number of unique source ports per lcore to
> between 1 and 64. The default remains 64 to preserve existing behavior.
>=20
> The source port encoding is unchanged: the low byte carries the lcore ID =
(avoiding
> atomics) and the high byte cycles through N values starting at 0xC0. Tota=
l unique
> flows =3D txonly_nb_flows * active_lcores.
>=20
> Reported-by: Long Li <longli@microsoft.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Thank you, worked well for Azure VM at 200Gb/s.

Tested-by: Long Li <longli@microsoft.com>


> ---
>=20
>  app/test-pmd/cmdline.c                      | 49 +++++++++++++++++++++
>  app/test-pmd/parameters.c                   | 13 ++++++
>  app/test-pmd/testpmd.c                      |  3 ++
>  app/test-pmd/testpmd.h                      |  1 +
>  app/test-pmd/txonly.c                       | 24 +++++-----
>  doc/guides/testpmd_app_ug/run_app.rst       |  8 ++++
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst | 16 +++++++
>  7 files changed, 104 insertions(+), 10 deletions(-)
>=20
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c index
> c33c66f327..debd226762 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -384,6 +384,10 @@ static void cmd_help_long_parsed(void *parsed_result=
,
>  			"    Set the scheduling on timestamps"
>  			" timings for the TXONLY mode\n\n"
>=20
> +			"set txonly-nb-flows (N)\n"
> +			"    Set the number of flows per lcore in"
> +			" txonly multi-flow mode (1-64)\n\n"
> +
>  			"set corelist (x[,y]*)\n"
>  			"    Set the list of forwarding cores.\n\n"
>=20
> @@ -4612,6 +4616,50 @@ static cmdline_parse_inst_t cmd_set_txtimes =3D {
>  	},
>  };
>=20
> +/* *** SET NUMBER OF FLOWS IN TXONLY MULTI-FLOW MODE *** */
> +
> +struct cmd_set_txonly_nb_flows_result {
> +	cmdline_fixed_string_t cmd_keyword;
> +	cmdline_fixed_string_t name;
> +	uint16_t value;
> +};
> +
> +static void
> +cmd_set_txonly_nb_flows_parsed(void *parsed_result,
> +			       __rte_unused struct cmdline *cl,
> +			       __rte_unused void *data)
> +{
> +	struct cmd_set_txonly_nb_flows_result *res =3D parsed_result;
> +
> +	if (res->value < 1 || res->value > 64) {
> +		fprintf(stderr, "txonly-nb-flows must be >=3D 1 and <=3D 64\n");
> +		return;
> +	}
> +	txonly_nb_flows =3D res->value;
> +}
> +
> +static cmdline_parse_token_string_t cmd_set_txonly_nb_flows_keyword =3D
> +	TOKEN_STRING_INITIALIZER(struct cmd_set_txonly_nb_flows_result,
> +				 cmd_keyword, "set");
> +static cmdline_parse_token_string_t cmd_set_txonly_nb_flows_name =3D
> +	TOKEN_STRING_INITIALIZER(struct cmd_set_txonly_nb_flows_result,
> +				 name, "txonly-nb-flows");
> +static cmdline_parse_token_num_t cmd_set_txonly_nb_flows_value =3D
> +	TOKEN_NUM_INITIALIZER(struct cmd_set_txonly_nb_flows_result,
> +			      value, RTE_UINT16);
> +
> +static cmdline_parse_inst_t cmd_set_txonly_nb_flows =3D {
> +	.f =3D cmd_set_txonly_nb_flows_parsed,
> +	.data =3D NULL,
> +	.help_str =3D "set txonly-nb-flows <N>",
> +	.tokens =3D {
> +		(void *)&cmd_set_txonly_nb_flows_keyword,
> +		(void *)&cmd_set_txonly_nb_flows_name,
> +		(void *)&cmd_set_txonly_nb_flows_value,
> +		NULL,
> +	},
> +};
> +
>  /* *** ADD/REMOVE ALL VLAN IDENTIFIERS TO/FROM A PORT VLAN RX FILTER
> *** */  struct cmd_rx_vlan_filter_all_result {
>  	cmdline_fixed_string_t rx_vlan;
> @@ -14102,6 +14150,7 @@ static cmdline_parse_ctx_t builtin_ctx[] =3D {
>  	&cmd_set_txpkts,
>  	&cmd_set_txsplit,
>  	&cmd_set_txtimes,
> +	&cmd_set_txonly_nb_flows,
>  	&cmd_set_fwd_list,
>  	&cmd_set_fwd_mask,
>  	&cmd_set_fwd_mode,
> diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c index
> f2037925c2..2432d720fb 100644
> --- a/app/test-pmd/parameters.c
> +++ b/app/test-pmd/parameters.c
> @@ -193,6 +193,8 @@ enum {
>  	TESTPMD_OPT_MULTI_RX_MEMPOOL_NUM,
>  #define TESTPMD_OPT_TXONLY_MULTI_FLOW "txonly-multi-flow"
>  	TESTPMD_OPT_TXONLY_MULTI_FLOW_NUM,
> +#define TESTPMD_OPT_TXONLY_NB_FLOWS "txonly-nb-flows"
> +	TESTPMD_OPT_TXONLY_NB_FLOWS_NUM,
>  #define TESTPMD_OPT_RXQ_SHARE "rxq-share"
>  	TESTPMD_OPT_RXQ_SHARE_NUM,
>  #define TESTPMD_OPT_ETH_LINK_SPEED "eth-link-speed"
> @@ -348,6 +350,7 @@ static const struct option long_options[] =3D {
>  	REQUIRED_ARG(TESTPMD_OPT_TXPKTS),
>  	NO_ARG(TESTPMD_OPT_MULTI_RX_MEMPOOL),
>  	NO_ARG(TESTPMD_OPT_TXONLY_MULTI_FLOW),
> +	REQUIRED_ARG(TESTPMD_OPT_TXONLY_NB_FLOWS),
>  	OPTIONAL_ARG(TESTPMD_OPT_RXQ_SHARE),
>  	REQUIRED_ARG(TESTPMD_OPT_ETH_LINK_SPEED),
>  	NO_ARG(TESTPMD_OPT_DISABLE_LINK_CHECK),
> @@ -499,6 +502,8 @@ usage(char* progname)
>  		" or total packet length.\n");
>  	printf("  --multi-rx-mempool: enable multi-rx-mempool support\n");
>  	printf("  --txonly-multi-flow: generate multiple flows in txonly mode\n=
");
> +	printf("  --txonly-nb-flows=3DN: number of flows per lcore in txonly"
> +	       " multi-flow mode (1-64, default 64)\n");
>  	printf("  --tx-ip=3Dsrc,dst: IP addresses in Tx-only mode\n");
>  	printf("  --tx-udp=3Dsrc[,dst]: UDP ports in Tx-only mode\n");
>  	printf("  --eth-link-speed: force link speed.\n"); @@ -1566,6 +1571,14
> @@ launch_args_parse(int argc, char** argv)
>  		case TESTPMD_OPT_TXONLY_MULTI_FLOW_NUM:
>  			txonly_multi_flow =3D 1;
>  			break;
> +		case TESTPMD_OPT_TXONLY_NB_FLOWS_NUM:
> +			n =3D atoi(optarg);
> +			if (n >=3D 1 && n <=3D 64)
> +				txonly_nb_flows =3D (uint16_t)n;
> +			else
> +				rte_exit(EXIT_FAILURE,
> +					 "txonly-nb-flows must be >=3D 1 and <=3D
> 64\n");
> +			break;
>  		case TESTPMD_OPT_RXQ_SHARE_NUM:
>  			if (optarg =3D=3D NULL) {
>  				rxq_share =3D UINT32_MAX;
> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c index
> fbacee89ea..6661bf16cd 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -287,6 +287,9 @@ enum tx_pkt_split tx_pkt_split =3D TX_PKT_SPLIT_OFF;
> uint8_t txonly_multi_flow;  /**< Whether multiple flows are generated in
> TXONLY mode. */
>=20
> +uint16_t txonly_nb_flows =3D 64;
> +/**< Number of unique flows per lcore in TXONLY multi-flow mode. */
> +
>  uint32_t tx_pkt_times_inter;
>  /**< Timings for send scheduling in TXONLY mode, time between bursts. */
>=20
> diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h index
> f319471c73..13c3915848 100644
> --- a/app/test-pmd/testpmd.h
> +++ b/app/test-pmd/testpmd.h
> @@ -673,6 +673,7 @@ enum tx_pkt_split {
>  extern enum tx_pkt_split tx_pkt_split;
>=20
>  extern uint8_t txonly_multi_flow;
> +extern uint16_t txonly_nb_flows; /**< Number of flows in txonly
> +multi-flow */
>=20
>  extern uint32_t rxq_share;
>=20
> diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c index
> bdcf6ea660..7ba9abf656 100644
> --- a/app/test-pmd/txonly.c
> +++ b/app/test-pmd/txonly.c
> @@ -223,18 +223,22 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct
> rte_mempool *mbp,
>  				sizeof(struct rte_ether_hdr) +
>  				sizeof(struct rte_ipv4_hdr));
>  		/*
> -		 * Generate multiple flows by varying UDP source port.
> -		 * This enables packets are well distributed by RSS in
> -		 * receiver side if any and txonly mode can be a decent
> -		 * packet generator for developer's quick performance
> -		 * regression test.
> +		 * Generate a configurable number of flows per lcore by
> +		 * varying the UDP source port. The low byte is the lcore
> +		 * ID, ensuring each lcore produces unique ports without
> +		 * atomic operations. The high byte cycles through
> +		 * txonly_nb_flows values starting at 0xC0, keeping ports
> +		 * in the ephemeral range 49152-65535 (RFC 6335).
>  		 *
> -		 * Only ports in the range 49152 (0xC000) and 65535 (0xFFFF)
> -		 * will be used, with the least significant byte representing
> -		 * the lcore ID. As such, the most significant byte will cycle
> -		 * through 0xC0 and 0xFF.
> +		 * Total unique flows =3D txonly_nb_flows * active_lcores.
> +		 *
> +		 * Note: lcore IDs above 255 will alias in the low byte,
> +		 * causing flow overlap between those lcores. This is
> +		 * acceptable as the total flow count at that scale
> +		 * already exceeds typical hardware flow table sizes.
>  		 */
> -		src_port =3D ((src_var++ | 0xC0) << 8) + rte_lcore_id();
> +		src_port =3D (((src_var++ % txonly_nb_flows) + 0xC0) << 8)
> +			   + rte_lcore_id();
>  		udp_hdr->src_port =3D rte_cpu_to_be_16(src_port);
>  		RTE_PER_LCORE(_src_port_var) =3D src_var;
>  	}
> diff --git a/doc/guides/testpmd_app_ug/run_app.rst
> b/doc/guides/testpmd_app_ug/run_app.rst
> index 97d6c75716..a4a57ea383 100644
> --- a/doc/guides/testpmd_app_ug/run_app.rst
> +++ b/doc/guides/testpmd_app_ug/run_app.rst
> @@ -386,6 +386,14 @@ The command line options are:
>=20
>      Generate multiple flows in txonly mode.
>=20
> +*   ``--txonly-nb-flows=3DN``
> +
> +    Set the number of unique flows per lcore when txonly multi-flow mode
> +    is enabled. Valid range is 1 to 64. Default is 64, which preserves
> +    the original behavior. Reducing this value limits the number of uniq=
ue
> +    UDP source ports generated, which can prevent exhaustion of hardware
> +    flow table entries on SmartNICs.
> +
>  *   ``--rxq-share=3D[X]``
>=20
>      Create queues in shared Rx queue mode if device supports.
> diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
> b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
> index 62bb167d56..ff1c8a444d 100644
> --- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
> +++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
> @@ -924,6 +924,22 @@ Where:
>=20
>  * ``rand`` same as 'on', but number of segments per each packet is a ran=
dom
> value between 1 and total number of segments.
>=20
> +set txonly-nb-flows
> +~~~~~~~~~~~~~~~~~~~
> +
> +Set the number of unique flows per lcore in txonly multi-flow mode::
> +
> +   testpmd> set txonly-nb-flows <N>
> +
> +Where ``N`` is the number of unique UDP source port values each lcore
> +will cycle through, in the range 1 to 64. Default is 64.
> +
> +Each lcore generates unique flows by combining the flow index with its
> +lcore ID, so the total number of unique flows across the system is
> +``txonly-nb-flows * active_lcores``. Reducing this value can prevent
> +exhaustion of hardware flow table entries on SmartNICs that have
> +limited flow caching capacity.
> +
>  set corelist
>  ~~~~~~~~~~~~
>=20
> --
> 2.51.0

