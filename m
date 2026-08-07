Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D3C5AC7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 11:08:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91E0A40A7D;
	Fri,  7 Aug 2026 13:08:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id AC97340264;
 Fri,  7 Aug 2026 13:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786100931; x=1817636931;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Od9A1IjPmuSQv3ua/8gvQ8DVtKH3gEX/xzawezTw23Y=;
 b=NSqOODbbwmriNxW9lms8BRtjRvel35Mw2mSQgglTZKshEsXCDkFL9giK
 BMWldqVIHjNt1j3n3Aq29L5dvSWkw2VK5ZDKJyt8PzyXU/U123ffSEete
 OMAuJm8nt44BuDpOwu52FZkjnleuhumXJMzGTyk9hdprV7ncK7WWskdma
 uKde9GhBSed6E8SaImYgR+U/e1tAM4/iu2jtplNUG5wbbBAyAZthzTC1h
 XwooGcGqH+fU3vaexdJrhAzDXeYx+/M6uAbFSzCNOduBlcKJMFJTE1ot0
 rJA981ARGict0UYTxwnmY62ZrWVcq/rzcSqi/IUxw7tMGbVUFAo8+2e6V A==;
X-CSE-ConnectionGUID: fbi4SIteScGAkI+COOWlkw==
X-CSE-MsgGUID: JvnXUNUlRq+xLqajdsDh3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86716298"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="86716298"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 04:08:49 -0700
X-CSE-ConnectionGUID: hvYe+ySUS0SoKq0PF4AOQA==
X-CSE-MsgGUID: NdPSKrAOQUmEhcyW/LOKzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="261080660"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 04:08:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 04:08:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 04:08:48 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 04:08:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTaKK8LvItXXFfesA6pn1gvMgUsicntGbsubHa+u4nOoIeWivk8S5cBLPDUl/8pQ2BzLhdSDt0eTjMdSgb57u6drvbsNT9K880GrHCgAdyuaUqAU7Stp4u3Pd9bFM+m0Nitmk2ad9uPpw0/pf5dZn4978DLOHq74DBHU6vDyse2jh9FsRRPTfR2IMeGWWt5QzTGmGUFVSCcxBIebH7otqYI5WPx926YKxTw/V0tUBWPofRpWts4m8q9F6AbG/r3h7B+nFDNu3ZTD5HI4CcuizehDvUlyrvnx1gjqy456Kylo/bXYt0m2l3GFTtQrcNgKcxZ1Fq8ue07gtWGANHyjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgFbiynUFXbaxr3ff4aNjm49fX9ySySoo+wX9pRcilM=;
 b=btqICaCfzl55RJplcwzkTTHPEVIhDW7Cl1DIZ6kOvyKC+srQzzPEpAO+J5kmdkj3sfdKqCSK+B5ARwjFM0qyQ4/kxgICbDheARxOY6q3V5UZsMwu2/KN0Fd0xDOB7ypbHS+RwglvOWYGAyTDSdjUjEcLkqyRx6c5eMoZJ3INmwavGHVtzqeZ+WrWdgeHT2zQwK3lEqzGLo2Dz1wRICf5HLkbyc7rrQXvQhOumxu+y8IF8mZ2swVNtu105drn7+DxzaFacSbss1aRRV5a7n3O98569RbASC3rm8W7yUZSIbzNYkE4b2dAHQI3DvG4jcaGsh3C73aHxTpmHe2UNWV8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SJ0PR11MB5134.namprd11.prod.outlook.com (2603:10b6:a03:2de::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:08:45 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0270.016; Fri, 7 Aug 2026
 11:08:44 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 5/5] net/iavf: improve VF reset detection on fast ARQ flip
Thread-Topic: [PATCH 5/5] net/iavf: improve VF reset detection on fast ARQ flip
Thread-Index: AQHdJX2EVWw/xi8VokqBu5T3Kmzn+baSbaBQ
Date: Fri, 7 Aug 2026 11:08:44 +0000
Message-ID: <IA4PR11MB9278C66FA76806F9DCC652408ED12@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786004043.git.anurag.mandal@intel.com>
 <ffb0fb45f27b33c90e26bf420193671f2488a172.1786004043.git.anurag.mandal@intel.com>
In-Reply-To: <ffb0fb45f27b33c90e26bf420193671f2488a172.1786004043.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SJ0PR11MB5134:EE_
x-ms-office365-filtering-correlation-id: 71dce86c-1278-45b3-119f-08def4743f52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003|6133799003;
x-microsoft-antispam-message-info: jGRizrdMcBDH2asT+masEYXUa4+NdIQUiDDZzYY+DmM1C2/B0UtQc31tKhBjKRbiENxxFJiy0F2+ExtcD+qnY7kopzH+Ni/5l2N8vRag+EJ4u1bVHkbWGMrqMj7fezI0rCsuv5AFgst6WOplFOpkieISDD1h8g+k9RqQPGf0YU6ysLcS3qViUDccK1OuXY39GSdYUjP0Ax5Gnmdd8HJP9uTgVYkxjn7KHfpL7divcDHDVYDB6yuxGLYrc2zfgb/wm2xP97lno1tcoIetg0Gs3IQduvkn/n6AKBQgboUObhKPWRaZK6NpBfCoa1JSW73aJRyu/cU9dsJ0Tvo+zrhHQIK9RSEaTZ2jV5TJOFbxIKez5/2exlI23is77XZREwc6o8IjRU/YYetgpSmdAz6NhWfdaHBfzqUOnBBUBCbOjSbz0z1T1dxydIZWFg5SUicklETyPHHm8zGQ+PV4v7434ojf0WOkbkZN8zPbfacXRZl6utFtVRtfPgaNol04Nk9QZmztfe5NUa8fh+4tKr4GnDaI+Kg47d3Bz5PYOFD8s7javOBPlPfNa5leasdjKtVh+32rdbXBTwho2a9GpViNVxPTpvf4HhVY6MPgXPuTjDT7DBv2qOK8YMEGgU68F48DdCZ20JHhYNpA41e7LFBEF24jI14rWlfY3rBsrSjXtpRnregNL8+3tgMQE0HnHlDOojXekLqTmYnf3SMtXvcfpwJb9SHEe9Ly4RTP4i23DsU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WeHKvL5RMYY1P1alfVoIEzZXBXT5WmNlyEsW+C9tGyNfSgdDY6wwrdLUI7jS?=
 =?us-ascii?Q?PdrYBJNB+SOkiPl/b5s5A87CwGxHz5vTvJr8ho2ERmaWnyjx1amzYVLnyHT5?=
 =?us-ascii?Q?IAwy4MikG+Wv65xlZB9GWY8gMtJHUdJxB5EwnKQXSCG0CbmwojkZekH2a4yS?=
 =?us-ascii?Q?8EO7lsJxf4Zn8ZGzFMQJUjp/ViYRiatKiHFjBw5u5xXQSpD1jGrv8zTzQ0Hj?=
 =?us-ascii?Q?G5IVluga17P2w9inB7s3SUtbLnvemQZHg9P4nf5vS+cZ1rf4TIlBt32BPiRD?=
 =?us-ascii?Q?A/HkMtC8KTeCS/UYCJL63sowQoRvGT4RsPb8Dut0UDlUAK6q7/KT0KwTuyTw?=
 =?us-ascii?Q?OiHfqWew5W5CzVowQbjpGH7z40nkN2AveHFE+auqTxXeuHMm65kgPjZbXJiC?=
 =?us-ascii?Q?D9hWLWUBxBB3vzv66paNj0R9uKJ9QTW5we5LGO6+OAhdCeDQdTLY1g7v6m2U?=
 =?us-ascii?Q?VALCJle/NwXu6YmDyPvYcv6CZL6XTxhxx2QU9OI7akytt7kayHcSDtt4hCoL?=
 =?us-ascii?Q?7Vi5x74mXUuucOXIjkwiMGed/gfiTckYB3TdGFyT/m31PcXTH2iZAWRqwy31?=
 =?us-ascii?Q?m6Q99eWKukoa6VMQie2PJBbmUNw+N3RtCSkuDnPHxUZOvYD2ReyuNIKmVbCn?=
 =?us-ascii?Q?adeWSJvUKnnPTe5qtLDFauORPa9UoUF/pOl7LC8JTIwV7pAM0c9JP4j6bw2c?=
 =?us-ascii?Q?GAH5nXwMnga5a7HIS7kDnu9IegFjJxyCQtoc1D7b/lcBjwDqngfNiioTcKRZ?=
 =?us-ascii?Q?Yuqt/MNNYPoNZYEiXsp85JupTjWiACkc3v1kd8Jvf1Od+lcR3L8kS+5XZOqV?=
 =?us-ascii?Q?dvCW177mNaKtD74wWLdsMzQjMiLj7FwbDz6rNfpAX9pTWRg6wGRjS14avZ2j?=
 =?us-ascii?Q?boiB1CyJse07GdXdPcXahgPixIX6iP0qlU5LH93ts7wE28Cl9JPzFsKol/uz?=
 =?us-ascii?Q?c3lJopyyOcjmkb6QwEaFYceEJZ1PC1jzdb9RseFHfQQ+nGBrAz3Whh6El+kH?=
 =?us-ascii?Q?LZMw3g/xNV1vhot4Y/m4T7Jl9TpsZMhXOzlCwMN+f/Jp49q0u1Fy7QB0iJCQ?=
 =?us-ascii?Q?BOoLMFgtTtfHTbVp3V+GLvu/hiL0a92aseQs3XdJX6O/C8vgu4OCal79Dgd1?=
 =?us-ascii?Q?IUV24ZOfQP/cWXMhKDqowQeScPmewrzMnhgvMEU4kD6mOlom9pcQmOHYgmTy?=
 =?us-ascii?Q?lpurAyrfkUF+QVmmvp/2ckvA0MuXCkJpVpOPPCIgIdIU3X43t8jmQKjCNLgh?=
 =?us-ascii?Q?NFHTHN1VKRRMJaaD6Npi+AgBvl1bthn+ISrWDHhY82RE+VLIVhmohWQihP7K?=
 =?us-ascii?Q?MF4t386EqQdrJXsA92m6RTYwyS2DUnZGfNymQr1g3iB/rbtNDhdVQ7jMBMp6?=
 =?us-ascii?Q?E3AqAPWTx5oyqGZr5cIIXbTj6EMz27bpBfCACU+dctrHujwNrfXU5ZwywOG2?=
 =?us-ascii?Q?SnIFQAHSFmAlWTNJuMyqdtP7XTlhaYhM+Jvj+BqL3Vl37sX/s5F77KKLFwrN?=
 =?us-ascii?Q?sGtDoUAbOgOw3ztLzUgrfUTnK109EBc50w0BJC97aNgTD5BnUE6bK8vVSEad?=
 =?us-ascii?Q?0yO8getyPPNf8FohlEiEJhODGFbRujFBym560oxhky3cyAQEvSC46ePbdTV3?=
 =?us-ascii?Q?ngjGai1K2Jdon1DcxYa7ZWQQ+YrlS9YefbgjwfHohfsNw2UYHUmCsM3hPAum?=
 =?us-ascii?Q?E0gKbk1wyDcGuu5/iv708uns9FhOvRDG2qZL6/95zLxle50M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DZ11/TFluTdvoosbtR+ikdTkoUbbr6s9dVCsxuiZWcUK0c/rfx7II2dSsNYiubv8wGYNOmgQa4GWsQsSFSsBcQX8MOkKM+fSBh3pS1kKXpp9df9A1dklxUyxcQOtjx0DFjzl+0hLIj9d8ureN9dPPN2Mw5xepVkKq78I3cGsZwYCkchXxrgPmO70agducz5djDu25LfMj1iOoVASuL9m1UypXlOH7c4SNH4jnF0LT3NsSn+bFYtFPrbHbeNjUb3cslJpqFXgdPys9/l9kroUmzT/2lzJCFDdVskwnDeIlcT6dAdW+ZEpZqaCPjUvsXau400eGyIdAX0HOVmBvipnPw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dce86c-1278-45b3-119f-08def4743f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 11:08:44.8180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWDq8l8wgmcUYr6q96CZ5z/CXxtdumq0eem9AtZa3QkU4GrdGwf6ERhlfN7WT3jYIJOj1L+kev4icqWC67ChQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5134
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

> Subject: [PATCH 5/5] net/iavf: improve VF reset detection on fast ARQ fli=
p
>=20
> During PF-initiated reset or a remote/ToR switch link-flap,
> the PF toggles the admin receive queue enable bit (ARQLEN1)
> so quickly around a VF reset that the VF's sampling window
> misses it, leaving the PF and the VF states out of sync
> and the data path stalled.
>=20
> Complement the ARQLEN1 check with VFGEN_RSTAT
> (VIRTCHNL_VFR_INPROGRESS) and shorten the poll interval to
> 5 ms (with a proportionally larger count, keeping the ~10 s
> budget), matching the Linux kernel iavf driver.
> When the VFR is still not observed, proceed with recovery
> instead of bailing out so the PF and  the VF states converge.
>=20
> Fixes: ada64daa1a5b ("net/iavf: fix VF reset for flow director rule")
> Fixes: 80fb3c920458 ("net/iavf: fix crash on VF start")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/iavf/iavf.h        |  1 +
>  drivers/net/intel/iavf/iavf_ethdev.c | 41 +++++++++++++++++++++-------
>  2 files changed, 32 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.=
h
> index 037bc8436f..5e49e81447 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -21,6 +21,7 @@
>  #define IAVF_AQ_BUF_SZ            4096
>  #define IAVF_RESET_WAIT_CNT       2000
>  #define IAVF_RESET_DETECTED_CNT   500
> +#define IAVF_RESET_POLL_SCALE     4  /* Poll-interval scale for reset de=
tection
> */
>  #define IAVF_BUF_SIZE_MIN         1024
>  #define IAVF_FRAME_SIZE_MAX       9728
>  #define IAVF_QUEUE_BASE_ADDR_UNIT 128
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index f6ce339b0c..21bac51467 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -3235,7 +3235,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
>  	/* remove RSS configuration */
>  	iavf_hash_uninit(adapter);
>=20
> -	iavf_flow_flush(dev, NULL);
> +	/* Skip the virtchnl-emitting teardown on a PF-initiated reset */
> +	if (!vf->pf_reset_in_progress)
> +		iavf_flow_flush(dev, NULL);

This seems like a valid change but unrelated to the rest of the commit.
Consider splitting it out.

>  	iavf_flow_uninit(adapter);
>=20
>  	/*
> @@ -3358,8 +3360,26 @@ iavf_dev_reset(struct rte_eth_dev *dev)
>  static inline bool
>  iavf_is_reset(struct iavf_hw *hw)
>  {
> -	return !(IAVF_READ_REG(hw, IAVF_VF_ARQLEN1) &
> -		IAVF_VF_ARQLEN1_ARQENABLE_MASK);
> +	uint32_t rstat;
> +
> +	/* ARQ has been disabled by the PF as part of the VFR. */
> +	if (!(IAVF_READ_REG(hw, IAVF_VF_ARQLEN1) &
> +		IAVF_VF_ARQLEN1_ARQENABLE_MASK))
> +		return true;
> +
> +	/*
> +	 * VFGEN_RSTAT reports VIRTCHNL_VFR_INPROGRESS.
> +	 * At times, the PF flips ARQENABLE so quickly
> +	 * around a VFR that the ARQLEN1 sample window
> +	 * misses it. Using VFGEN_RSTAT, as a
> +	 * complementary indicator, prevents from
> +	 * missing a reset that really did happen.
> +	 */
> +	rstat =3D (IAVF_READ_REG(hw, IAVF_VFGEN_RSTAT) &
> +		 IAVF_VFGEN_RSTAT_VFR_STATE_MASK) >>
> +		IAVF_VFGEN_RSTAT_VFR_STATE_SHIFT;
> +
> +	return rstat =3D=3D VIRTCHNL_VFR_INPROGRESS;
>  }
>=20
>  static bool
> @@ -3368,11 +3388,14 @@ iavf_is_reset_detected(struct iavf_adapter
> *adapter)
>  	struct iavf_hw *hw =3D IAVF_DEV_PRIVATE_TO_HW(adapter);
>  	int i;
>=20
> -	/* poll until we see the reset actually happen */
> -	for (i =3D 0; i < IAVF_RESET_DETECTED_CNT; i++) {
> +	/*
> +	 * Poll until the reset actually happen.
> +	 * Poll every 5 ms to catch the fast ARQ flips.
> +	 */
> +	for (i =3D 0; i < IAVF_RESET_DETECTED_CNT * IAVF_RESET_POLL_SCALE;
> i++) {
>  		if (iavf_is_reset(hw))
>  			return true;
> -		rte_delay_ms(20);
> +		rte_delay_us(5000);
>  	}
>=20
>  	return false;
> @@ -3423,10 +3446,8 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset)
>  		if (!dev->data->dev_started)
>  			return;
>=20
> -		if (!iavf_is_reset_detected(adapter)) {
> -			PMD_DRV_LOG(DEBUG, "reset not start");
> -			return;
> -		}
> +		if (!iavf_is_reset_detected(adapter))
> +			PMD_DRV_LOG(WARNING, "VFR not observed;
> recovering anyway");
>  	}
>=20
>  	vf->in_reset_recovery =3D true;
> --
> 2.34.1

