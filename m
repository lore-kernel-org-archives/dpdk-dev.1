Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7F1C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 17:23:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A65140298;
	Fri, 28 Mar 2025 18:23:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id AC4444028B
 for <dev@dpdk.org>; Fri, 28 Mar 2025 18:23:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743182594; x=1774718594;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=we2l34eVwSGTsA2ZrKZdCbK+LKh14fQR6nUi5NPecZo=;
 b=TruGzUoEkzEUjpMdIO1VT0CytJhWH4otzUxj3bh3P5IWZtdcvtnvYOM0
 fZBfpZLucwYpUQEvmmhVN7vNd+QsKkuLXXpKHSts9dyp+2Fhc51+/f3mK
 qs5fOF1JzR0hvRknl0vZUxxZ9R1bSGmZKtlcznhNkmfpvTNDXoaI00kQo
 r71OpaHAuM6fXFRKil9qAhrgUMTj6W8wblEeVNKZttE/rphJhJw4NpUJc
 h38hu83CRF62znbSmOJmBq4u81l0N/jC5cXoG747I1JmO+4YN0rJ2ETwz
 mjzMalpKtFE2EiF1rr+fHWYDcD5l1o6HVvnOPhxol3MBylv380zyfvEQx A==;
X-CSE-ConnectionGUID: n+Tp1eB4QB+XyGLmTNq2Tw==
X-CSE-MsgGUID: Mr50wezbSmenxXd4c89IbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="48423329"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="48423329"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 10:23:12 -0700
X-CSE-ConnectionGUID: GImF4/B6TWSZzOL3WFhgjQ==
X-CSE-MsgGUID: WtY1b2XOTmqPk3zq3jKCyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="148676361"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 10:23:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 10:23:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 10:23:11 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 10:23:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5CoX2HOmgxM7jIHMQaqX5CE9z2UzIx3N87GeriBrDJiCVoesVqaPu/LLkgGVu+/veWdbgVpufurxKu/xbA008rhsnaMmXYATwRzbgnlupzYLeTU1jGr+6aX+Q7gDvLsvuxMYjf6/pDXlXEsTcFF2m41tk2EuuTXXjHpcSs8EnH46Xa+skmC4DzVwdvhQTnCtXyTjIhelmmy6mCJPJ4UfiRRMphgXlzhNGjEaNaGrafGGIETjLpEtktKIY7Kea2iokc3sV5bGsAnidDuhkKa8w2HB/nqyixUdbP2X8RokiVHpyj7F9vvnpKHy6qBVJG5+gBGPhU/5K38QzEcFNdaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCkMgGlAYAkQ11SkODlUwxFOoi0uTk3vRJ0y2xk/9+8=;
 b=cMi7d+CIGnzgt66lcHYOLpHKvhaAqh/CG4eIgOjVK1stU1XoxDOC83cV4WUQnC2QqyLas49hzUJMItTWZhDyTGe7wsdGfN2Wb6pW/herJj58M21ipUEE6qy2tC/Mj7gk291UEaRu+8Iakgi31UYHB3TRxaTps15jVzN7YREsAxx7grty26rtZG4XD2tm/8dLmFp5rGa/ww84yE71VEIpChlxeqW+3R6ZOODrKumq/4S0sfwNJz3uQR3PzeLrX8RB5tYP5RAK16pwtyGPtsKBV2pf1Iya0kuvZEwolJB5dRPp/mr28ZOdYV1N0xnKwRqJVgnnIMctU2IK23pamII0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:22:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 17:22:40 +0000
Date: Fri, 28 Mar 2025 17:22:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 2/4] net/intel: use common Tx queue structure
Message-ID: <Z-ba3PJtd2aZYvD8@bricha3-mobl1.ger.corp.intel.com>
References: <20250327104502.2107300-2-shaiq.wani@intel.com>
 <20250327160437.2296127-1-shaiq.wani@intel.com>
 <20250327160437.2296127-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327160437.2296127-3-shaiq.wani@intel.com>
X-ClientProxiedBy: DB6PR0301CA0074.eurprd03.prod.outlook.com
 (2603:10a6:6:30::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 966fddbc-09cd-4dbf-681b-08dd6e1d24af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q1fJQSvm2/n+8IDM/VKBtkWjlMlcUDb2rRiOEZBRcMwuH7/JYWE9w/XJUk5i?=
 =?us-ascii?Q?wh8lO993iSvLMzRQL34wtToJyRR4hLvdKgskDhnB2rCaGJ9aqPHi+bzwZ6as?=
 =?us-ascii?Q?K9ehy7z6aHFK7NpDaGb+5NsmZ/GAneaSgj1sw8Gpct0qLTxIZh3foqnAN1ju?=
 =?us-ascii?Q?aHbO1Jl/G8mOG+De+istySB/gaXUDNcy8VfmbSMqBlvEiWi9ugXqXwTzRDZc?=
 =?us-ascii?Q?Rs1M5moDCCmaKLjDyaB6nOeXAKkL8mIZcPFHBJqbKLnHx7iAR6d9Km5kay7B?=
 =?us-ascii?Q?1UpA0fHxkPzSDvgOi8oR9om0b44evm/w3Uf8YDpyr6YmSeHp5hWf+4/cER3i?=
 =?us-ascii?Q?Ier0ep0dpG3rfEnYa3cfuZIYnipDzp4Zr/v9KWkYSvnSV5L5mDOT4gHmkvtw?=
 =?us-ascii?Q?BIdSfZDPbD/Xy83Sc2P3Q+QU8uDAP3E7fTWhRlSxip06WfREjnPc66g6Ycpr?=
 =?us-ascii?Q?25AJuLTsbrSy/vstYwlif7PstXvokv08ClSX78byuFFTVTI5X+dZXYeidm/E?=
 =?us-ascii?Q?8/9sLZd63PslNxKbHC9sWN6bXzWZK6eHx9YqRn5/tYC3U7wuiTbWEC8LUqY5?=
 =?us-ascii?Q?Q7zV/LArIkKv3bKWZopjXbHs22B6tbN8gy70eA0GGWYWklMoqCoHmpd9EpkV?=
 =?us-ascii?Q?bSbNLFy8zLYdpFl8kfQD8s19ZX0DfKwsZZJU2FpozP+hFW1fTP5S0mErXr8A?=
 =?us-ascii?Q?WtRwZmJybuZKUktwf8lUiq22SpycUIBIuZe/l+UC0OQOd58vZrzJrBjv7ZER?=
 =?us-ascii?Q?gfD00LPEwfX3z1/m9ERQ3dp9FDYPABHTWfmA0PIU6qxawbVLGmnUBciw1pDw?=
 =?us-ascii?Q?7G22jrOhQvY2m6A6b3Bj3glknx0KhN1v/EI1350/st0iGKq9mpmUI+XUXtXj?=
 =?us-ascii?Q?IUfcQUOieXetk6qNfSoMlLQP4LV1BFMmucp8WYKiAuJpYt8+kvNdxYz/Fj7p?=
 =?us-ascii?Q?ZdWWt3l4KQD/mAMv12cBR30DtlxSNvTkjCahxKqXko+HCwAwl+ZCISeyPgFe?=
 =?us-ascii?Q?0NqVdlprKBLd2D50sE/Msp+49qyhGGLIsKj8o3M/D7q2h/T4jsccyPRJfiNT?=
 =?us-ascii?Q?20N/ROYlsS656t9R1uyoRTvIEVnv2t4VTKx5sW0SZ5I4Ny6bppkdt91ozBlO?=
 =?us-ascii?Q?f9sFUQtK2nFYPxUbgHGa9ckweuRdmT/Rrp5efLKT+6m8D3aJmaILPHD2Fu+g?=
 =?us-ascii?Q?DHjc15mtYIref9i6E7ZM9wVSTd90gUucspxkAiv94hdnU4SMeUTGdEuA+dZg?=
 =?us-ascii?Q?T52iK4O9DLBV95b/fUOgFU9urSUcpfzZfrSDkbDiG+2z6uoSAm/a+QWEr7bi?=
 =?us-ascii?Q?oqEk5dlGdUvuu962VG7GAs8GiMgknPx/z+L8C80YzuPDTIxMsBRvIj69Ls21?=
 =?us-ascii?Q?8vYO9axkpSlcPJNhaMrWF1pfrpMU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QXVdU15//j6bN0lGjXwhnENU61VLHqyEzA8Hy3WLCfsxhrCG5ptnKeQcvXKe?=
 =?us-ascii?Q?JbegN1TPFxkounaPHFvPPsRmLNScFPv6tGzvUZvZ4AKuQSiciYP6MsP5kXJY?=
 =?us-ascii?Q?+w3SYTS4/8rFfvayn7DayvHlgTMGVTp4brzVuYlm68iawbC7ridHlNSCN0G2?=
 =?us-ascii?Q?T2g6iHAFZYEGkRbwXEHCjod0RWNEyOrfOOMCSI3/qM2HX47G4PWp7ggjWP2t?=
 =?us-ascii?Q?5Qq6t+0HU0oSto7XYzpaHlcetvuB6pGHBfmcsjv3kt3D7Tpexgvrx7OZzqqx?=
 =?us-ascii?Q?X71nbsVHzm8VASNqMOsnq6/oHaJrfm+azAEwRm7EsEQ0x+3hTbmY3P2OW9p+?=
 =?us-ascii?Q?0/fY/fEpztA7f15gsHNEyustlPBO7KsKxQieDbm3Zp8hGEr4HydWzOha1dmV?=
 =?us-ascii?Q?PZw5B/k50KnxIOJulkTkIKiy0KI3Jrzlcs/rd+peZN9Mn0C2lQh/wY3aJnsk?=
 =?us-ascii?Q?4vOsAgVTUXS9vA+vWxkxTGcja77SMAQWU6F4bbo/fAQeimsHol+63rKF9mcR?=
 =?us-ascii?Q?0JqI4dBPrv6snmy4xlo/4nRN2B3lfzJK96atzG51/OAtoqXqPxT8Aeoa8nRt?=
 =?us-ascii?Q?x32qiunIeDcu0GugwyYlzvR67QjCyuN7kUWCYAoNcXZPuJY+As8+ozodOV6x?=
 =?us-ascii?Q?cZ/MNTLs8TwgoLV+KCuq08exSbWH42MgyyQdkb6vlYCtdCUFFuRXfQAsEjLK?=
 =?us-ascii?Q?9tjxbBbMK2Eh40aEqv/pxs7L0IFOk5dnyYcMJeb4U7yDlHNX31sEstK15h9X?=
 =?us-ascii?Q?R0FInAV+Q9PaAjsoNyEKM9dbNahrRZ36x3Tfma87i1yaIeemAT0kkmUY5nfI?=
 =?us-ascii?Q?4GGBmc+/c7Yw5gjM+hcwGcgciYNDtxOvA1i7DmEWrvxdpPKSYeQcyy9MRyd1?=
 =?us-ascii?Q?XU4FVmLY/slDkT7KTEFy2ZFM4Tm/xGEAElxf0jzRIWDxNsWmCOQlT+qKiNJW?=
 =?us-ascii?Q?uEaJkRH7iy/m/gqTnixSacfB/gFqudU95DRTvAeXulReD4DXnSOvanNS5bcl?=
 =?us-ascii?Q?Zu+VEAGp7He6OPz+aNbGSfgl0ystGi3d4BXvtCCHWnhlVZIEYHLRapZP3rn/?=
 =?us-ascii?Q?T+/j7dzaqB+Ifd/UjzJlRgidGEN63ihAE0R0fT3qqFwYech111Ug0RGaUE01?=
 =?us-ascii?Q?Ylm9QikDDJTfXBUXlk/XnPmtL+eortqAgD7M6maPtmZbriVv7d8bwV2A4JZZ?=
 =?us-ascii?Q?pEuVvK4N9/460w2XkGKikwzfiv4OBqGg5hDRBFz4f7lrs99gud4tCEJQFmEj?=
 =?us-ascii?Q?h9NVA3P3Cezc1ylwV1UrRym1xFqyQJluFUJ7B/n/48Mb861v8hk7S4ujJeoZ?=
 =?us-ascii?Q?F+pK+d8s9DClQ4DUh6X9Nq4CfSkHnjEPgLFnDWVfHPohzSzQe/Mc8UsqdA1B?=
 =?us-ascii?Q?Jl36YEu4Q6g7x9VDbL3F22aBqgZAnmMWdgp/slL+rdW5AdgpONR4CRVxpXO9?=
 =?us-ascii?Q?l+i+XqUXJtSiBRy86Zf6Ybo2UgBWxpR2f01k3p0BZFt+8NPcJFyYcQISkWKR?=
 =?us-ascii?Q?bV45qPBCWmlXfcUdCgGFnzDjy36I3XlTsjuhXkNz3DxtvSdsccXQ8J1EsSRH?=
 =?us-ascii?Q?a7BhgPy6VPkZiGXUiNzw8l+hV/Qsa8XDQaTs2Vdo1jTUuJK13TGMvkLHwYx8?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 966fddbc-09cd-4dbf-681b-08dd6e1d24af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 17:22:40.6354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaGHDODCkKfoSevplYqJ/caaKWKS5ZFs/0VWPlZWXMsPxdvMzmJmx1viM2UonwzW9V0/jrbJuXWJ8fdQNk/OkQRweQ47rMjVkzpp9+rQVcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7554
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

On Thu, Mar 27, 2025 at 09:34:35PM +0530, Shaiq Wani wrote:
> Merge in additional fields used by the idpf driver and then convert it
> over to using the common Tx queue structure
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Some comments inline below.

> ---
>  drivers/net/intel/common/tx.h                 | 20 +++++++
>  drivers/net/intel/cpfl/cpfl_ethdev.c          |  3 +-
>  drivers/net/intel/cpfl/cpfl_ethdev.h          |  2 +-
>  drivers/net/intel/cpfl/cpfl_rxtx.c            | 26 ++++-----
>  drivers/net/intel/cpfl/cpfl_rxtx.h            |  3 +-
>  drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  3 +-
>  drivers/net/intel/idpf/idpf_common_rxtx.c     | 36 ++++++------
>  drivers/net/intel/idpf/idpf_common_rxtx.h     | 58 +++----------------
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 12 ++--
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 21 +++----
>  drivers/net/intel/idpf/idpf_common_virtchnl.c |  2 +-
>  drivers/net/intel/idpf/idpf_common_virtchnl.h |  2 +-
>  drivers/net/intel/idpf/idpf_ethdev.c          |  3 +-
>  drivers/net/intel/idpf/idpf_rxtx.c            | 21 ++++---
>  drivers/net/intel/idpf/idpf_rxtx.h            |  1 +
>  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  5 +-
>  16 files changed, 101 insertions(+), 117 deletions(-)
> 

<snip>

>  static int
> -cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct idpf_tx_queue *txq,
> +cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
>  		     uint16_t queue_idx, uint16_t nb_desc,
>  		     unsigned int socket_id)
>  {
>  	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
>  	struct idpf_vport *vport = &cpfl_vport->base;
>  	const struct rte_memzone *mz;
> -	struct idpf_tx_queue *cq;
> +	struct ci_tx_queue *cq;
>  	int ret;
>  
>  	cq = rte_zmalloc_socket("cpfl splitq cq",
> -				sizeof(struct idpf_tx_queue),
> +				sizeof(struct ci_tx_queue),

Minor nit, but this would be more maintainable I think as "sizeof(*cq)" so
if you have to change the type of cq again in future, only on line needs to
change.

>  				RTE_CACHE_LINE_SIZE,
>  				socket_id);
>  	if (cq == NULL) {
> @@ -528,7 +528,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  	struct cpfl_tx_queue *cpfl_txq;

<snip>

>  void
> -idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
> +idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
>  {
>  	struct idpf_tx_entry *txe;
>  	uint32_t i, size;
> @@ -223,7 +223,7 @@ idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
>  	for (i = 0; i < size; i++)
>  		((volatile char *)txq->desc_ring)[i] = 0;
>  
> -	txe = txq->sw_ring;
> +	txe = (struct idpf_tx_entry *)txq->sw_ring;

As I comment on the next patch in the series, if you change the order of
these two patches, you won't need to introduce these new typecasts.


>  	prev = (uint16_t)(txq->sw_nb_desc - 1);
>  	for (i = 0; i < txq->sw_nb_desc; i++) {
>  		txe[i].mbuf = NULL;
> @@ -246,7 +246,7 @@ idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
>  }

<snip>
