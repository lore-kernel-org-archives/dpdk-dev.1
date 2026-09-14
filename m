Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C96C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 10:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDB4D402C4;
	Mon, 14 Sep 2026 12:16:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 849D840144;
 Mon, 14 Sep 2026 12:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789380968; x=1820916968;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o9okf7onT/v1+Exe3zU8BQ4yDIsVofs14E8OVSVDWJQ=;
 b=KDcibqIM7/J/nQhoC/a8+469rrNWoGW2e2EZYggNuIz8KAwhD7yswVla
 BUuPS6p09HTWfCT3RcX97TGxly71u7fCTYYFDCNKh/HEyGqjGGz2lAxt+
 7v9i3r+XwrrHITzewdtC/l0sxLZVHAX7foCdg/GlHMRxciI4UJPhNE6x3
 o8cjFiqsXbklo9W0YyLIt4+bW0tedJjxcjUxnUHE+4OS1aQkiEgmEKP1B
 /Otg1k/bP4m6fWKaN2YuWK2FYcDWcfGEVNq/RCBLv/MMVjxGSgc7gT8+S
 BuzeFco+ZKmWAPiwd8/Jk54kRRp+5R8eN7x9Q+FnP+x4nZf2i1Ywl0odr w==;
X-CSE-ConnectionGUID: ifFzM7YIS120kIFrn2CINQ==
X-CSE-MsgGUID: 1xvkFIhrQsCj5yS6I2M/Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89494075"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="89494075"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 03:16:07 -0700
X-CSE-ConnectionGUID: 5mQ2ppqYTUWRX2uUokiBYw==
X-CSE-MsgGUID: 6AvRdpO/TEmxu5e/OBKeUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="269971066"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 03:16:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 03:16:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 03:16:05 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 03:16:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V135G8f5RdxOoV0I+rwhfh695tdrlOa36okaQsYKRP0FmuCfQGlLGuuc4eresxJ9pYMqRHb8vG8sC5RCXvFe8GiW/GvljvE7A17H+HhS7dffR9twihWEKYjY2/aLXyqEA3ultbBtdN5naxWunLuqS69CH2FRnWFKHgDpzuh4IyJt92ZoAjcokawuNBAVb9d1mPXEB7kvZH9MeUdSuhhbOeC1U9VfNl58PoGp/TEloMTaFDv1dMxBPGDXKtpfvrL6SPPu9LczAfpxWU07TlkXji7ffFoiOc2SdAq+9JEcBetq0NkiyI4wuUbjXc4+KoQ0/rLnHS6z6f5wOjxCYJ2Xqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf6mWxeFI5z2E0WYTPoxvLeVkWuAVkZdngwmQZnnPTo=;
 b=rLDvPRpBNjyOeVf/+dcRl8TCGAVm6x/fh0Cx6qzQWlafSgy2J04ymy1/AYvi8gkADg8NOlQjBLxMRhQ9ED8kTzeTEoJrwzUZ6uqogcJCPWoIcSxhpmIS0FH+LSfZNNOLI09qatdH8YFJs1ZO5d+DygePlhqaXV6/gmf491ejqlEJZdRyFB27FRhli5Gf4EygWwUTdah5Xm9qQTVQ9eH2MAODKXEq4UkKQMKylOj93NMq/9d5eHEqWU09po9HUCf6WMbpCHDSMiGCdpTlkb0cXkCrPi7qxkhFWHdorp1oK9ZR0GUj1UGbxtQVou1NnZxZLazSqyZl8t9foYRHjWQQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 10:15:55 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 10:15:55 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "rjarry@redhat.com"
 <rjarry@redhat.com>, "cfontain@redhat.com" <cfontain@redhat.com>,
 "stable@dpdk.org" <stable@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, Lunyuan Cui <lunyuanx.cui@intel.com>, "Wu,
 Jingjing" <jingjing.wu@intel.com>, Xiaolong Ye <xiaolong.ye@intel.com>
Subject: RE: [PATCH v7 1/4] net/iavf: fix MAC addresses leak on reset
Thread-Topic: [PATCH v7 1/4] net/iavf: fix MAC addresses leak on reset
Thread-Index: AQHdRCGPgqyD/7JkykqIZgE6/0RWB7bN2x9w
Date: Mon, 14 Sep 2026 10:15:55 +0000
Message-ID: <IA4PR11MB9278D5E85C6AD7C17FCF659D8EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
In-Reply-To: <20260914081725.1097704-1-david.marchand@redhat.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SJ0PR11MB5893:EE_
x-ms-office365-filtering-correlation-id: 8f32cbe8-4c07-4b17-664d-08df124929e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 3H9QNCecHOcRBa27TpuO49FOdhUQRV93C+don66yloNGvaa7xVnOnhF494+lV9EWU7+WSs1bttiiB+a634u8vWhEC3+zsk1ZK3GcFR0Cl3YA2YTlSsnlR5o60YG6P2z1dTJqxNZQvkEVvE1MWsMEGpkkiPnuCIT6NAVTdUF9NEJKSRz6BN1l5AfjbpIWyj8xXGJD4mJX5uaVxmWaZhwE7FDIpyaJBnWch+Ia7wiVv01xFd4JOH5oeo+4F2FarQbAjApbQuZzGawHKeESbVtffKuPRB5ZWrlrsdRKKVvpqysGEIjxvc44FV15zcXtR39Y//V1QR1IAQBJTL1NOXICIw7/nqoqv5DUkzJFdoGoHACxdQTAuv9rFOm1MiROGlAbi1B5Veau1nzyljgQQfhAFiLn+5EwRbJpzjDpjtaLWNeE/ZaOGfbCXZlPYPl9Hkd2+muE2igOkag4SXT/37Cxd0CWK053vodndPDCJjFAlsi1IzqvBjKlw2/8Rob0xmFdxH21VRGGrhWfjBv8QBwut6f/EIsC6j2OXmN94s/SOgDib/ouhGrLRTaXPi7wjQbzYbM3nQwl0ta6QmTy7HbX/IVrTfqPAntHOtcATF4G0hSn3yfuScZ7+bO4+cfm0dz8k8l7hx6M1KSd6GEuw4m9N4bumLW/5J4kSm/lkdY6w7MLOWM13WAcx6V1R212IcB6mqHcsxr882iSRdHlXDVzPWwIntxN1LDGytJO4ywuM94=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yOKP/3VTLf+I2p9MKXynhPZpKYvzvCyqk0GwHV2RQ3TfBDRvl0luqBCoDPuk?=
 =?us-ascii?Q?PicF8uEf2iZMci9eBJ4GfNFRSc82xEPrA8VZKTfleZ7WuDpEdsX62TaeGbyL?=
 =?us-ascii?Q?D+n+DO4v0+uBW4UPbM76tmUhgsC/EAR5UJTd1h4nKWjs6i66aBJUKKllbMwU?=
 =?us-ascii?Q?H6p60MeVTN3aAel3xVdy7RjXXAKSSERd+bPy059MpDjE+xgRyZd3rreGelcl?=
 =?us-ascii?Q?SywS1OsgSvxZOT5LOSM5hyWJnffzrobUachI0HLdY4dU7GoPEgKQABam2gqs?=
 =?us-ascii?Q?T9ZLMiqeUwuuLzvQ9Ubho33nx/0yxdTWd/jL9c4YIRfFhvlBZWM4lzIzIdGu?=
 =?us-ascii?Q?FQrVALP7LhOvhLI2SSkl5xb2tVkqitljVNDPcZ1rRGR3v1Uzs6rew04XjHnz?=
 =?us-ascii?Q?Di3ujPEDUT+B0X4P5S5bpfr9wuNeCtURa59WYdfdijBaiWA40zCjJhlWeFUs?=
 =?us-ascii?Q?VSlVMfecOTaVgI5G71dlRney6zis1yA8fys1IuwZACmLKspaK/P/RQH5hkyT?=
 =?us-ascii?Q?JBtjO7UteU7jAg+QYo9k3L22OqesveIpa2jzsxFq4luvVxvdWzDv6DnTGx+j?=
 =?us-ascii?Q?osw2agAv1AZYq23jFGVZ9+Zuy8ENc4yq7pdMYRMqIkG8q0MLuazdrYNbxnkG?=
 =?us-ascii?Q?wiUNuYzPsIyr5zd/doBDFEAa6S2umt+PWtxGRA9BfzJuHqulYwdt2tnXVc9k?=
 =?us-ascii?Q?XYw73e6n91PjmWC/EG+POD4CjzIS1dJVPUeEYFxHmKRjkq2Z+dTxg+fCWxAh?=
 =?us-ascii?Q?TkvZ6xZmEs/WWJeDcqPuGEa/1qTGExk8CQqwl32ZzpKZkBIP/1HEfdP8OIU0?=
 =?us-ascii?Q?VLk1I2VQOAdDXnOR/o3goZdi/uTi9847gV5NEkT/xYsKu6lbNByQZ0s3G8Pq?=
 =?us-ascii?Q?R3U/yCxIDKOWKj9uwrhcPITzi9brSIcM08KV5as77AtCmPt/OvDgoc4KD8jj?=
 =?us-ascii?Q?aR0Fi9I0PuLc53keEbQM1sOcHQrXP9ZoGQYhqEmAk6M6w1DefXmtJa8vs297?=
 =?us-ascii?Q?DKUCiNHhzFedPLNzxF8WZpO4DuaU3l4Lv/I5RWlHwxIeHIKjNNz1gxvup9EF?=
 =?us-ascii?Q?i4n0cAqBAMBXuunVZ1R1XZJn7882WZI9gdzS+KRzaWXxKeGvV4RSE59/ZcL1?=
 =?us-ascii?Q?H2Dw6IGomeC2L61y7ThxnMKCt+7Ge0bC5OJmHrrN1RJy99KpGPDDYwDJV2Od?=
 =?us-ascii?Q?igH+RuVU3OQaVeQnJROqxrA0y4RjV956HJzZtZMF9g9Ue8VMsOlhueqk6bP1?=
 =?us-ascii?Q?LitFVScJ/BHoprCcKllp2BJOkfMWdrHhh/PVdv1MTD94mRIDMzx8lQkSYxdw?=
 =?us-ascii?Q?vX/vtNp7TErtRwxyj+quyku8iRk7N2LkzRa9OQlmZLmSFvYql0cQZ2mel6gy?=
 =?us-ascii?Q?13Nh5f2qbaxmSfYpFP6Ck+VBZCu3GtXD1/HtWQWFuWzSATqYqKr3oEWKNdoZ?=
 =?us-ascii?Q?DJmjj4YZ2Ni2laqv5Vkr1zCZ45I5h/MVFjU+DhsVVG9Q7j4gxDkETIpaF0CC?=
 =?us-ascii?Q?fZcNtQUDXgSNUXxMmCJSBE/VHXRzgaF3G1jsSBSzSb1sOFxdxRnmMvnUmDGN?=
 =?us-ascii?Q?EUVNg/e7eTdGdpNtZxUTPcli7L0P9TqSFeAk+TZfUgjht8iSXM6aUR6XjDRl?=
 =?us-ascii?Q?Cypym+VgxjoXUkYyxLFOw7FKKn/jYSnrJ6E10HOghsey249MaVhOMkq3jDY5?=
 =?us-ascii?Q?7BWIiurJ/gC/m/oyI07LQWGTh55upW0ciTEidWgkiESFnP/dzTNYdR7x0QUO?=
 =?us-ascii?Q?dnQUVo5IPA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K+0qXNvMMcIink9GvCuiGfbrH9gi4daE6LFiHXFzHXGUfkDmT01qVvh7lByqWy0N3cm1D02xNi/7URN9mUCYoOPPvPxj/C4mUBLIDL+EXJv7Z+iBLv4HNmy7yByp0n1eRM+1cGFRLSDOOG7xGnADNCWStXN2QxFVqRPTfCo2XrMZnlu93SVl0i+nujWJ4Y/qS+VT45qaDsFfW7ohVjGipyF/bwvba1jBugk1/IfqDgyYCjmjRBOJRy72tU1dpzVPsLtmClqOGMU83OyEbAi+9WzA2PvJVEVpXGDY52Yq7lvBWQF2yq0WFMRSTW6iwIp/fq35xWgVojTxP/OHtYe3ug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f32cbe8-4c07-4b17-664d-08df124929e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 10:15:55.4446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xb99+d6SQaJMUpDXZzffaTwHy7KPFshqzlWeNLfsupslnEFGnVWAVcgNcsQ1mK90zMY4swCMLpWHN+VZC3CGHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
X-OriginatorOrg: intel.com
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

> Subject: [PATCH v7 1/4] net/iavf: fix MAC addresses leak on reset
>=20
> When resetting, calling iavf_dev_uninit + iavf_dev_init results in
> leaking the previous dev->data->mac_addrs array.
> As a consequence, secondary MAC addresses are lost during a VF reset.
>=20
> Move the MAC addresses array in the private iavf_info structure, along
> the multicast MAC addresses.
> Set/clear dev->data->mac_addrs in iavf_dev_init/iavf_dev_uninit.
>=20
> Consistently use RTE_DIM() to avoid mixing with the multicast addresses
> array.
>=20
> Fixes: e74e1bb6280d ("net/iavf: enable port reset")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/net/intel/iavf/iavf.h        |  3 +++
>  drivers/net/intel/iavf/iavf_ethdev.c | 20 +++++++-------------
>  drivers/net/intel/iavf/iavf_vchnl.c  | 10 +++++-----
>  3 files changed, 15 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.=
h
> index 044de3cfd4..1d52b3d113 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -255,6 +255,9 @@ struct iavf_info {
>  	bool link_up;
>  	uint32_t link_speed;
>=20
> +	/* Unicast addrs */
> +	struct rte_ether_addr mac_addrs[IAVF_NUM_MACADDR_MAX];
> +
>  	/* Multicast addrs */
>  	struct rte_ether_addr mc_addrs[IAVF_NUM_MACADDR_MAX];
>  	uint16_t mc_addrs_num;   /* Multicast mac addresses number */
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index 2ac4dbdac4..b498258d58 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1186,7 +1186,7 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct
> rte_eth_dev_info *dev_info)
>  	dev_info->hash_key_size =3D vf->vf_res->rss_key_size;
>  	dev_info->reta_size =3D vf->vf_res->rss_lut_size;
>  	dev_info->flow_type_rss_offloads =3D IAVF_RSS_OFFLOAD_ALL;
> -	dev_info->max_mac_addrs =3D IAVF_NUM_MACADDR_MAX;
> +	dev_info->max_mac_addrs =3D RTE_DIM(vf->mac_addrs);
>  	/*
>  	 * Runtime queue setup can race with the hardware Tx rate limiter on
>  	 * E810 VFs and corrupt queue state. Once a per-queue bandwidth
> rte_tm
> @@ -3104,16 +3104,9 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>  	/* set default ptype table */
>  	iavf_set_default_ptype_table(eth_dev);
>=20
> -	/* copy mac addr */
> -	eth_dev->data->mac_addrs =3D rte_zmalloc(
> -		"iavf_mac", RTE_ETHER_ADDR_LEN *
> IAVF_NUM_MACADDR_MAX, 0);
> -	if (!eth_dev->data->mac_addrs) {
> -		PMD_INIT_LOG(ERR, "Failed to allocate %d bytes needed to"
> -			     " store MAC addresses",
> -			     RTE_ETHER_ADDR_LEN *
> IAVF_NUM_MACADDR_MAX);
> -		ret =3D -ENOMEM;
> -		goto init_vf_err;
> -	}
> +	/* Point at the MAC addresses array from priv */
> +	eth_dev->data->mac_addrs =3D vf->mac_addrs;
> +
>  	/* If the MAC address is not configured by host,
>  	 * generate a random one.
>  	 */
> @@ -3123,7 +3116,6 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>  	rte_ether_addr_copy((struct rte_ether_addr *)hw->mac.addr,
>  			&eth_dev->data->mac_addrs[0]);
>=20
> -

Nit: stray line removal. The rest LGTM.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

>  	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR
> &&
>  			/* register callback func to eal lib */
>  			rte_intr_callback_register(pci_dev->intr_handle,
> @@ -3199,7 +3191,6 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>  	iavf_phc_sync_alarm_stop(eth_dev);
>  	rte_eal_alarm_cancel(iavf_dev_alarm_handler, eth_dev);
>=20
> -	rte_free(eth_dev->data->mac_addrs);
>  	eth_dev->data->mac_addrs =3D NULL;
>=20
>  init_vf_err:
> @@ -3256,6 +3247,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
>=20
>  	adapter->closed =3D true;
>=20
> +	/* Clear reference to the MAC addresses in priv */
> +	dev->data->mac_addrs =3D NULL;
> +
>  	/* free iAVF security device context all related resources */
>  	iavf_security_ctx_destroy(adapter);
>=20
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index e3120c655d..df97ff2052 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -1674,19 +1674,19 @@ iavf_config_irq_map_lv(struct iavf_adapter
> *adapter, uint16_t num)
>  void
>  iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
>  {
> +	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
>  	struct {
>  		struct virtchnl_ether_addr_list list;
> -		struct virtchnl_ether_addr
> addr[IAVF_NUM_MACADDR_MAX];
> +		struct virtchnl_ether_addr addr[RTE_DIM(vf->mac_addrs)];
>  	} list_req =3D {0};
>  	struct virtchnl_ether_addr_list *list =3D &list_req.list;
> -	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
>  	uint8_t msg_buf[IAVF_AQ_BUF_SZ] =3D {0};
>  	struct iavf_cmd_info args =3D {0};
> -	int err, i;
> +	int err;
>  	size_t buf_len;
>=20
> -	for (i =3D 0; i < IAVF_NUM_MACADDR_MAX; i++) {
> -		struct rte_ether_addr *addr =3D &adapter->dev_data-
> >mac_addrs[i];
> +	for (unsigned int i =3D 0; i < RTE_DIM(vf->mac_addrs); i++) {
> +		struct rte_ether_addr *addr =3D &vf->mac_addrs[i];
>  		struct virtchnl_ether_addr *vc_addr =3D &list->list[list-
> >num_elements];
>=20
>  		/* ignore empty addresses */
> --
> 2.54.0

