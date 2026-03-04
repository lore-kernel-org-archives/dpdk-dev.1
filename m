Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B394EB7ED8
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 12:00:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8239C4066D;
	Wed,  4 Mar 2026 12:59:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 31FAF4003C
 for <dev@dpdk.org>; Wed,  4 Mar 2026 12:59:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772625599; x=1804161599;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=umsZlbow/9JUPYSM3KGXSSWuXkrFbZTN1HlK0Lff86Q=;
 b=KYoMb7R/sw4+zoNNFlJZxSLSvE7ATAkYp7j7oX6K2VyiND8mcsIRR+c+
 zKBOa/T5me3cskOdwUKfv0ABIlXVCsT3JYzDvVtszrUsZ1fRahJrXAgGZ
 VwkvZLPJ71+LyXtbNAFAT09zFK7ZVO71bxkd7294z/7VbWMt/57AKLOU4
 FuPTFLbnkDPV7ZoyYTsiHuT/b+q2VXujCOOJ16g/O6AJkQfLXYI0Lk7gd
 2XMkHMjEHgAO4preE/ZNtavrlDE/nLoQ7LyNhkLFxUGmDJOpKhBiOE/kh
 lU7j9r6sB1lS00FPI7hPAO/PTJAHc3lRS8vjQ+3aLWCtnwQFqQS9U2k/W A==;
X-CSE-ConnectionGUID: bq+f/bmGS3Wi8qhZu5lLSA==
X-CSE-MsgGUID: XewmGxqPTP6rSvy/9EfD1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73810425"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="73810425"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 03:59:56 -0800
X-CSE-ConnectionGUID: VE3ZVoCXS6OuwKobEZWuAg==
X-CSE-MsgGUID: ptfGuRReQciREfc6yzu5AQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 03:59:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 03:59:54 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 03:59:54 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 03:59:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4IY7idYj77JNoTQvjhgwQNaBZYSrrQ7XRHc861cpTYAFuhrqxqclatnoXur9n91femtVE3uQUYogfGQJDuAq8hxCfgsdRRqo0qOVA4S7m5TyduYzesnZ2jK/Erbtl2wuQfbESNcTFe5VIF4jonk3A0rcnLW8pLcL+wXEUHKAeJuZZHp1xBtvWbH3MgXOSMwLfdheHuqthm1j7vixxofjoLLhLUf/L8IxVETi8jVn9fKdDLtC8WhrIFLQfIvNnEE0sqy5Fc2AY20vRENgZFvyJfDHYdxKG3OYrrgFh8ocEMPMcH/124zJ2mZ+pMtXGyH/zAy0QXu/BcxSqoPNiHScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWRkuvrQXwWvF/YUXJPe/mHJZAny/bXJct9Ab7nFQHQ=;
 b=o/4N930w+nyEzqMuOEAJGhroTfpBt5/lItUbE12fdkwouqflQ60ba+4sQHrvgmzWiu4aKDEt9vMZLuEwipuYOeF7ug8zC6P3dyRzdifJhuFZBaXSyg+iOW7aRdbkTjTsPPwszoD+RtrQ/75DXTiCUxJha+OcYUtcd94glz277MqxUh3LH4DcbxPwN9dPEaxCCFHCCd+I1HAq1T5jfXNCB26Wyag0+ByeBHAr5xRSPIYuMrG2wkV+Lx3dn2eZUbS3288UAV6Us6nQMs/MupenkXrvBnLN3a9F3LzmvTjqBLibuubhzUfNjAueVYTquIa7eE0YIktmvQzLNk70A14hmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DS7PR11MB5992.namprd11.prod.outlook.com
 (2603:10b6:8:73::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 11:59:52 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451%7]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 11:59:52 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH v4 1/2] net/ice: remove malloc call for admin queue msg
Thread-Topic: [PATCH v4 1/2] net/ice: remove malloc call for admin queue msg
Thread-Index: AQHcqyoBP/aPYUmvJE+1afAYk3CNnbWeRb0w
Date: Wed, 4 Mar 2026 11:59:52 +0000
Message-ID: <DM3PPF7D18F34A19CBFB3BE55DF3E2ACE328E7CA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260227110205.4099981-1-bruce.richardson@intel.com>
 <20260303162157.1634379-1-bruce.richardson@intel.com>
 <20260303162157.1634379-2-bruce.richardson@intel.com>
In-Reply-To: <20260303162157.1634379-2-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DS7PR11MB5992:EE_
x-ms-office365-filtering-correlation-id: 29115d90-7913-4561-f48f-08de79e58b68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: ASGe37rFtlnVbEzZLNj3DktKJ0NRymoyGwzi0q9KRiOZ0J5t8D1Xbt49Eg4vJ7blbmIOCN0z928+blXuEdlTWycOW3fDPrIjFkkf8hRC+Gv5CWaeBNqv8bjRIgpI/jk1w5Kz9UXxe2ukrfC1/WKPgYSh/6jE6VAbvtqPZWMdqjf5ZIM5Ymqgpj25oKddCqKMpCBaWhjFMU6AtbHigFirKx+xEbY+5yY2AY+esEDW/h8lkwpqo3ERPYHf+DW85lM3fU4Qm/E7ZC6hHrXLI9BALvpT6tOyUG2DH/daE9JKn0N27p7SGhm5R1ITjehHbgF1iv8o7wYAqYdgpwl59xq0eCouPjUvAqOhIBUMWAClXtWgtjWst8rEWNjZ/c3CDhgiczESpvZjxgO+eGjiMKJOyRmwDAg2eBC5eY6uBqJlCY739byWqr+4jBMlm24gUnNOmJLH7Iipfb71HdJ2Dori8U5z4IwRk0+57kbbWp8ZJJZJG1A4Ui8TMvzqST24Z1h1KOfOVsSvvyZUxPczx2y+tUV0xSYL4j52rtyY5vDch7iEXnZ9peWl08rIBwKzkl4CDmWnLSCKNDiFtaAQvgTrn2VEJiOVNLDWBdsPYaDfSNJeonHegBdZjbyPMopJOiVQeD1wNDquAjOYYaBQMDWL4fq2OemOg2C0D3dkh+jrtWysViQwwwywFEMaiI2X/yFERJOCJepIZUvcO7E2shjkYphxkNmEtoH7uWViBBcvQOY6KrJb/magc70ONxr7y4rWov7Hhu3/kGvjQMnYQvkrIfXXnhbab3A0GGRVEhQKwU8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cd0bGo0hh6XLiNELMOcYXniLnLJ94d+NVtPH294S64afy5JqSSBVkdDtky/3?=
 =?us-ascii?Q?uGqE6iWrJJnDM0iFTIRKG4yOCKkh1VHcilF6N0S5nir9rtKMG3Y+Ka5Y1GCX?=
 =?us-ascii?Q?f8e3UM5vo6UvuXdSMbC5KmjVQ9JJByBk020RInGXwqB3Sp6+w28RfRvHgdWU?=
 =?us-ascii?Q?s2AJFWhzTp33NNjVnSFmFgyxmCHXEW42bntVLMzzuHooFE+/h/3Me5VRaekx?=
 =?us-ascii?Q?yweDjnpekfqakhbGxBGLc5XiYwwlmm2h2UpqLoaPNJ31rrsY9iaEFn1WvrCp?=
 =?us-ascii?Q?Lhcmi2Bghh5j78qiuF/cUgxYkQaM2cwF6HSR8c5l9NoLklt9Cg/qb5yKHV2z?=
 =?us-ascii?Q?ToOWFxy+HUp39wYNiCjrqQW11mxHb/PJDJmNyLre4iBqI4lXVospmEDL3LgA?=
 =?us-ascii?Q?yPt1rg5RzfFKlz88zRussLArcT5mOx3+5c6SYiWO8TGcbvgttapWjR2q8KNh?=
 =?us-ascii?Q?mOwAGMaajPRlj+b7zLIBRv5eUoPzIq4SlO2ZJaCtRJRJpRxVTwS3RSQYfB8Q?=
 =?us-ascii?Q?5YCTEiwMeN7CzZulRy6n3Wj0Y/pQDfVrquDleO6fKGwpjvkCnEA/iG+f1hD2?=
 =?us-ascii?Q?gFwigrEPGv6DWmNyjYhXAbYRYn4/WG0L27RkstPgWgVcGBHYOT//DH4ZlRU4?=
 =?us-ascii?Q?dVxzjnw4IOX+KjN9xmv+b4amADjKA7IeE/i8Y+f0MXP/A9Zqgg+R6FKBlKvp?=
 =?us-ascii?Q?4lhVMaKtowDT2GpVUJ4ppWXoB338vedPOE79jrrl25FtcvqIJeWnXsJ2ziMF?=
 =?us-ascii?Q?jX4e82G1YGYNfPQRGUZYwN7NRYOu2R0KCiHSyi9W+bpi8HgiFhIRBfEqE/Le?=
 =?us-ascii?Q?hSSQ1ZWztnBimeJElOAmSMO1QIhGbDEe1HPCOQ1b7Ft/QsSxz48Jq7NinlJ9?=
 =?us-ascii?Q?MD11le6lWDkncjRrcfWZUagO1u71T46gKOtxNtika0v2Og+Q8p6e5G7ik3JV?=
 =?us-ascii?Q?meLziWY32zm9jsu47TTTw/0YtCgnLvDrWtJdufWY0GdT3NPYMr9Pg6+JQe+c?=
 =?us-ascii?Q?EjJKUpSH0sHQraxy3NgXLymXEw4rNjQVnyIbU7AhKb40OEDInqMnFk7Wd+/m?=
 =?us-ascii?Q?73OTv85GkxJBVNz/cWd7GQVXQu4f2G9Yz+Lw/dCdcMJCevjj1G3UJh7tA1V4?=
 =?us-ascii?Q?MvLSMywv4ThjJMT8rOQv3srtbubwULP8eN9dkiP8s2CCHTubRlGrGx+oq8Qs?=
 =?us-ascii?Q?93npW/2X+SvbnGkv9ckVHfyZsRjgeYeq3VoY52vnnSoJz6/qHXeQFzZUrfHU?=
 =?us-ascii?Q?YvdNxLnHAguBxKe+hYvUpiI6IV00+IU2z0YZ0ZqyrCzRMBd7Zwj4vJaXEMQF?=
 =?us-ascii?Q?XEsRE0KmT2JiGRObisa9CfOkCGVGVIETCMJFDVoBRtGUAlWTY8xNwiYKBQOp?=
 =?us-ascii?Q?E/3OaQ1uNSmtPmz4ZKAc2d1JzRMNZQJIV76NeRydSxxkCpx/wfx64atAedQD?=
 =?us-ascii?Q?k0m9pzLGR3ERUlzpJ5mMhV0a/XavB3tWS4711q+TwkveelhOepBIXQmoiIhW?=
 =?us-ascii?Q?vu8p+JeN59QnCSeQtHBpbW8jgx9ujBS24pN90RVU++Dp7feG+zzVFXy2A2E1?=
 =?us-ascii?Q?02wiP126BPZ8kBui+LuhLABXpWDXkQEJp9Zl86UwGB4MaNgp7QG/9H8K3Qm0?=
 =?us-ascii?Q?bs24s+BmbZ1ij8vX36Kz7e0oNt+c3TzZLYRSYrQNHzOL0wXD8DNOltY1giNf?=
 =?us-ascii?Q?NSi66rCgC8YqVuKO5c4f6Eu0iz6IWLhUqWWNCJasFTg93E3t+E0mTK/O2lCl?=
 =?us-ascii?Q?22leNAIoeQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gUWZKukIhaQ3rAcncMRyUvBsnnrrNz4gevdUNb5fudVrbe9om3sik0Ammep+vY21pEkOKNXswDmiTFsghwJfQcir818XB8BsU6ZJ2TyFNMCY0wW7tM0p60UEuwvccgpF06Zmr7tl4+Q3973UtovUMKPnYLuySFyuAGa3DfVvr59QLaXuedgDc8nsE5FfBObNcaklaNx1gUeKbWwYygFkKOwcCLq2t/CqRnerFmY4mpEqlRn+Jdo0SKgUx22BeMP2Fz/l1n4GrFPW/6ApAmP3u1IvNO7lfC7bwONyEp+Uv5vSKpvO/UaSmPPbHN3OBZH2xZM4Y83tZFaWTq7nxDyLsQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29115d90-7913-4561-f48f-08de79e58b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 11:59:52.6335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGFFiNv7WW6w8ayKti0yhLLsbaQywn7Kj/HUIILqrmWhOGU4D2+588mbJqHxXO0YMgfqNpLQHhPNz2sJXtdUIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
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

> Subject: [PATCH v4 1/2] net/ice: remove malloc call for admin queue msg
>=20
> The max message size is defined as 4k, so we don't need a special
> malloc/free (and especially not rte_malloc/rte_free) for each call into
> the function - especially if no data is present. Replace the malloc
> calls with a local memory buffer instead.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/ice/ice_ethdev.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> index 0d6b030536..a59ca2e047 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -1440,17 +1440,14 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
>  {
>  	struct ice_hw *hw =3D ICE_DEV_PRIVATE_TO_HW(dev->data-
> >dev_private);
>  	struct ice_ctl_q_info *cq =3D &hw->adminq;
> -	struct ice_rq_event_info event;
> +	unsigned char buf[ICE_AQ_MAX_BUF_LEN] =3D {0};
> +	struct ice_rq_event_info event =3D {
> +		.msg_buf =3D buf,
> +		.buf_len =3D sizeof(buf),
> +	};
>  	uint16_t pending, opcode;
>  	int ret;
>=20
> -	event.buf_len =3D ICE_AQ_MAX_BUF_LEN;
> -	event.msg_buf =3D rte_zmalloc(NULL, event.buf_len, 0);
> -	if (!event.msg_buf) {
> -		PMD_DRV_LOG(ERR, "Failed to allocate mem");
> -		return;
> -	}
> -
>  	pending =3D 1;
>  	while (pending) {
>  		ret =3D ice_clean_rq_elem(hw, cq, &event, &pending);
> @@ -1477,7 +1474,6 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
>  			break;
>  		}
>  	}
> -	rte_free(event.msg_buf);
>  }
>  #endif
>=20
> --
> 2.51.0

