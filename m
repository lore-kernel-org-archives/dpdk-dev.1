Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A62ACA0ECD
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 16:09:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04F874068E;
	Mon, 11 Aug 2025 18:09:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 8BC50400D7
 for <dev@dpdk.org>; Mon, 11 Aug 2025 18:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754928558; x=1786464558;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Y1aPJRhjVTNAcpj9NtTrp0ktrOdKQaxoCD5Eu+nHyZI=;
 b=gbzMWTIknXFY2W3hS8z0JoFjGBsbEbcoowVJc0d2svQhDB8WFsoEnySI
 CQfxc4IGdOot9W6bIuk4fTiMbxxPrTN+qanZiKL2uCPFXFSoHZOtjfsNp
 AgM7gnVEGoUQQR3CCJ6Z1gLOlhXvrQ5/X3PEmxoYjljdDoWmIWg7C44dW
 Mg4orjpQ4kwr3KQGUwX9V+oj37E+T+uklg+YfTz7MLbAz552PY5ydNI8B
 BP5rd0XTLQwWmmu9SO4TLnD9K8jf1SH2frsRnyQ8pn6NvCJ8LCbmAeoFI
 QfyL4LcCZZog5CjpyYO+6P0GMvPalppxcwQSbtUmtrHnXzhOSv/xoKYAV w==;
X-CSE-ConnectionGUID: Z0+sITe0RAO/KG68zy+Mzg==
X-CSE-MsgGUID: z/nyfJdUSVK+bohygRp59Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="82626723"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="82626723"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 09:09:17 -0700
X-CSE-ConnectionGUID: Gq0s0r68QxSSiVQl++GiIA==
X-CSE-MsgGUID: uEDEodvAQ92OyQo2sx2aSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="166264609"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 09:09:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 09:09:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 09:09:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.80)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 09:09:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/bHe65KUGQufLlQIep+CRHiTcuomijSAfcx6QQRXtN5qUkgVOr9p9sahYmkhBMVjiNkgrjkE5qgOwmY06vMPFrfSh9l7uFAZH+jAm8vxTJJeGVxN+S1UYPlG5Jf/uuPp1ozOHzedXkqTTi3By/mT05Z21AGX6FztMTVw4IKx2dCE51CMOepjxcHOu/q4GrsxKYA5kq8v8b3aoWmFMYPCT/XIKqlECan2rYGC2J3BClp5NIrF5g8st6O25QQHWTGqknMPRC3ju7Lw2fffBwJQltMJqgGKTdp5g0rLAZa3tgu3SNKwdf8UgOi60IIS/dL/ygHWdgLBAStQ3diTnq5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmMJraiIb+0p5KUbUhVAeQkL+pJP1BSHVE1scUUoyh4=;
 b=I//mlfWn2nI0F2CWQOptfnW0RpCkgkes3k6OPfJEOqGtJIdpSfzxYZCjFKxt70KgouJOC46+yqDJlHxOdZsYuAy3V0RlC8zry3Ohuqblu9E3wZ+f5SDVKmGQQJVrlU38OrWGu3TxUpmhsWai4zg1eDV8pRaF2pnyVu9GSrZBH8F0LK1VuD+aHBT6XIJBqLHvSgs++VMDV1yavPjowKRui/9oMigeK1W9QOFEcNGZLELG/m541EymL4b5ZySAlZX22quMwO9b10vOblkKENk4mQ4rKN9YH5l7VTMW6dXhDTNN9dMfU8FwwJc7l/HqYPLbkWiG84L7sMrYLMlyJH12sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB7885.namprd11.prod.outlook.com (2603:10b6:8:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 16:09:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 16:09:13 +0000
Date: Mon, 11 Aug 2025 17:09:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2 4/6] net/ice: enable DCB support
Message-ID: <aJoVo829_fRYAifi@bricha3-mobl1.ger.corp.intel.com>
References: <20250807122238.334177-1-vladimir.medvedkin@intel.com>
 <20250811134301.459523-1-vladimir.medvedkin@intel.com>
 <20250811134301.459523-5-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250811134301.459523-5-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DU7P195CA0011.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: c25d8ca8-d424-4892-821e-08ddd8f169e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ecwsceDe0IobXVepaeocsSx3bVEXrVbeKJ0fDF2aNWZYKL6Y2BRtcbf8FXI?=
 =?us-ascii?Q?gtyV0P9DcReCXUQXcPAVt39H2GNUvjrr8DiKQL9ZWotraFhrC4OBpBqbGtSm?=
 =?us-ascii?Q?WAuw1vDCUz8UoYTsGVGgaUr4x9arv/4on8yzJY/tOXq1r8JyUI1kKzSMeUkI?=
 =?us-ascii?Q?+cdGA2PmDY4b/nODt0HDtL3ZkS8OxxnyPjXaGH0Nn3HpIFdB/o4jxvHmjHVg?=
 =?us-ascii?Q?r7vR2GxtOrKXOdfNjxSqmim6KoMZflkqNh+PxaTbooEZTEAwdoJGqCftoSAX?=
 =?us-ascii?Q?Bp5opc7AFhoWRFgoLnJHmXIvCSRIvXnpY9mAYPSorHdua7ance6l7P9vS5BB?=
 =?us-ascii?Q?xsVUXDXTgcR5ROIR/qiA+evi22Rw+fEfjhgNAW5Fbb610P3DIONOlRz3uPym?=
 =?us-ascii?Q?H5NcBFUTRAl+FJ1DSg4CY/07DHls4/ZWlIrpIS0bbCuPt+io9E7hpKtpYbIl?=
 =?us-ascii?Q?1cR/6Qi6OA/vcfLchshvao81eGRRRH4bXEx/OmnOwZTZ08DETuXmM0Z4UZhc?=
 =?us-ascii?Q?dzpu3V3eZTDtGLUuz2kMQNPCbXl7NCr7Io5alpOSHdNE0VTeDbB7yUMG3dPY?=
 =?us-ascii?Q?umlzXmhaa0uXzsEJAjtghOD9f5PtNpWEmSA+NcUrrGcBt6W0W759OszEL6HF?=
 =?us-ascii?Q?Bkt3S1YlrAtrMzXwnj+KlEqvQnkN7TCXr4mpWRljgIA2qM2SQwQMNqu64Lqx?=
 =?us-ascii?Q?pSGw12ogJQgT9Xo47d4xY4fhLWcsyQ4lYiAqVG/8Cohl9IS7eiQrKkQ5H/4j?=
 =?us-ascii?Q?lAdGqOsZy5LfCPtdjJTKgU1GmntaZn65goPDxR4TdslaPLwvVpZ0CdOqKAn+?=
 =?us-ascii?Q?r1EovldmYtc2udsBHu+LFA+cPjGhsMftnzxUlSlyeSto8kEJ9miEwRepGI1F?=
 =?us-ascii?Q?n0jORjNGvu8tYnwENrQAFUiDP7k+6Pc6+hgBnuIK9Y1eKAzRFOIOjHc1W5gt?=
 =?us-ascii?Q?gDOrqOyFVKflONLRPRdrmgL5VtBvB1klc67nJLizIuG1lWPNQtFkRyw4lP10?=
 =?us-ascii?Q?lqn40WezL6W6v13riEa5S4gYWaykIaN1T3ITO8j8WPch9gKzCMQ4ir3MWtrE?=
 =?us-ascii?Q?8VePm1nFHf0hctgDdRnyQ/LNG/VUVzp15KA7Voh5RIKz6LpdUWDeuNbtHhe0?=
 =?us-ascii?Q?YlJyTD6Da+1IB2yZ2G8qYwhukolPy1UOBiP60YOqg4Cpk93V7usyemH1SRvS?=
 =?us-ascii?Q?u2e+MqFAN9tblZAGn6HLqsHErM1j2SyPd+e2riE/hA8h6D/YBamcHewO9xiy?=
 =?us-ascii?Q?RecJ1ujE0uCUiby3oDsh+zlyXd0QSO4Tc9JBo60pzmdSBzXWBAOKkfJzTb/S?=
 =?us-ascii?Q?GwA4pllUeq83mdGRhLQo3rON+ansHIFez6/E+0fK3IFX/s3BxHHiYanjgcWK?=
 =?us-ascii?Q?ntaPTtf0pzBhVuCyQvT0NPMfk/BfIrEZruJxVW5AGWY5RFbyI7XEOSssTbLT?=
 =?us-ascii?Q?MCsVhYtA6DI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QO87Uyz82xsnQnAI265O55WeKaREudcHE01aOZhJsTy4iBUApcp8150RsZ0x?=
 =?us-ascii?Q?BXgzUAtkN+yMUsECpar1kKrexzcd+7giapBxy5pvsHEbQQDGzS6S3JsiLxaA?=
 =?us-ascii?Q?+xeOHdi047M5ybjxo1ujbl2ezfVnVCf8Y7UGxHTvREWzI/JRkL2HcTIhoEpO?=
 =?us-ascii?Q?I/uwAKWBlxS6VTKqzS8FE5xNKCg+KVNXtORR2GPBNJ/ZJSph2DI6ujUBbfSo?=
 =?us-ascii?Q?NG1oLM2yAaVCn19cvnvfd0bjLt5IeTILG4RRWv+twNUbba5QSTEJsv4eZtSg?=
 =?us-ascii?Q?bR77z3KU/KsTIrTlmsrExX8XRlL0mKa81/Wntn1fmSbGxsS4OkypznemFICL?=
 =?us-ascii?Q?xWp2SbBgjknPZsVTbMqbOXJEDpF0i+7OkHkj2arAKacphEZePqbFmISfAfbF?=
 =?us-ascii?Q?948lzZfnsjPMYplnU4G5rEkGeQzn8oXByDFEKCOqAhkhbBYiMlaFC9dMVVbc?=
 =?us-ascii?Q?pfySd2afp4cznHKIter3KnYkxi9pt2nQxS0Iexz+o06l2xgOT8fffGc8Nq/L?=
 =?us-ascii?Q?No37pWjsjvrRAJqxPhJjKvyu9pWEkxcgKwBS6FhotiOqkz5+goMWLG/aTxcn?=
 =?us-ascii?Q?Feiu760qxXTqMa3hNlmrgJo1Iq4Zm9uTe2gnBykvx2FStIaDurDsgn8T07s9?=
 =?us-ascii?Q?KgKeDk9XugyQRXVWZYARB6CrrBIyDUbvmlJmYBiIahZAWwskO8Qb9/gGyNNR?=
 =?us-ascii?Q?ujEDnIC8s875Vljoi17js5Zm6OXfRYkjdOVXrZwxfJDVwz3hHqiECRhhN/Oi?=
 =?us-ascii?Q?z7xKgXJS/rczWsd2ldm9bggMIUtAYkOLXQ0GWKrK84gerj96LW/g36S6eG9/?=
 =?us-ascii?Q?SPbBZhplQXs2tv4xo0e/q/UXRnxH+e9r5U1bdHv+1NDalyLHs7BtXmFSZbAn?=
 =?us-ascii?Q?T6+Zf/fsEFk4P8nk9piNRtC9xdgopjBxWVvhjvxI2VKb89xmIrfUiHOZ7Kjh?=
 =?us-ascii?Q?OtgAnj+V8oeI3OeuIS/hTpfqkIPESyR0FfbSmA5BRbL8U6K2JbEgOwaNzstT?=
 =?us-ascii?Q?d4lgYubfNB25kh0G5w411DjdKFx/a7IOXHwIv6owmuHy8nEVcPFBukF+2/ye?=
 =?us-ascii?Q?wFxf+pjPuywmZqYhiZWbvjlcbE66cXJIkSX6LHQf4XqCnKJBOhtgP28MnakF?=
 =?us-ascii?Q?th01QHdvRGaagRNSn376inthbAF4GDgdU8a6eaZfjUTKfJV/d+idEzHaxosc?=
 =?us-ascii?Q?6M7XM78vbjqY8B7TqFpri50W2NvtMXoAVWp8780B9vJGMYLZLS65VEBMS7Em?=
 =?us-ascii?Q?UXwb0qCAvvlQjCHBseC9XQwKuMtrF/Y9l1YoUmOOu2DSCxqwKFtlYTnmZoiC?=
 =?us-ascii?Q?T8sPBvsXq5ys3TswgwaBRGxWErfEFnpj6EBaSkP8F+/VH/WGqSnN8HdFjW74?=
 =?us-ascii?Q?vE8FjAP3qH7xmIM+xUMsEBWppDu7GEJVG133Ude0P/ftXTJ6zMIwSZQck78o?=
 =?us-ascii?Q?64Tj5uLmpppVSOvCvXXnx0QJvOq5kbivKy76NwK1+XYdHw7ht4PP9s9H0vSw?=
 =?us-ascii?Q?DM8P6/DZq4ce0XGrN28iQL6LdGYJPxCiN21QOk6m7CJdW4XbTmUzsiFhCXVh?=
 =?us-ascii?Q?/Hx2NPzrXxbpD1Q9XUdSBjmd8WE4wXA+Qj7c0lcoRQ6WKohR8MH3OIyiOHp1?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c25d8ca8-d424-4892-821e-08ddd8f169e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 16:09:13.4582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAtqv8MTbhjWVDEYl9Zu/Qp6ciXAlSeIH/s/sOW++E4UxVfVbr9GZzZEFUchqfkrYhusequwMeijkbyR1ibyOsu/b4rIfU6wYixXeN1B4pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7885
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

On Mon, Aug 11, 2025 at 01:42:59PM +0000, Vladimir Medvedkin wrote:
> This patch adds support for Data Center Bridging (DCB)
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 182 +++++++++++++++++++++++++++++
>  drivers/net/intel/ice/ice_rxtx.c   |  21 ++++
>  2 files changed, 203 insertions(+)
> 

Some minor stylistic feedback inline below.

/Bruce

> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index c152da4fc1..27ba9c5b34 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -194,6 +194,7 @@ static int ice_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa);
>  static int ice_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa);
>  static const uint32_t *ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev,
>  						size_t *no_of_elements);
> +static int ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info);
>  
>  static const struct rte_pci_id pci_id_ice_map[] = {
>  	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E823L_BACKPLANE) },
> @@ -324,6 +325,7 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
>  	.fec_get                      = ice_fec_get,
>  	.fec_set                      = ice_fec_set,
>  	.buffer_split_supported_hdr_ptypes_get = ice_buffer_split_supported_hdr_ptypes_get,
> +	.get_dcb_info                 =	ice_get_dcb_info,
>  };
>  
>  /* store statistics names and its offset in stats structure */
> @@ -2826,6 +2828,29 @@ ice_dev_stop(struct rte_eth_dev *dev)
>  	return 0;
>  }
>  
> +static void
> +ice_deinit_dcb(struct rte_eth_dev *dev)
> +{
> +	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
> +	struct ice_port_info *port_info = hw->port_info;
> +	struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
> +	struct ice_dcbx_cfg *local_dcb_conf = &qos_cfg->local_dcbx_cfg;
> +	u8 max_tcs = local_dcb_conf->etscfg.maxtcs;
> +	int ret;
> +
> +	if (!(dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG ||
> +			dev->data->dev_conf.txmode.mq_mode == RTE_ETH_MQ_TX_DCB))
> +		return;
> +
> +	memset(local_dcb_conf, 0, sizeof(*local_dcb_conf));
> +	local_dcb_conf->etscfg.maxtcs = max_tcs;
> +	local_dcb_conf->etscfg.tcbwtable[0] = 100;
> +	local_dcb_conf->etsrec.tcbwtable[0] = 100;
> +	ret = ice_set_dcb_cfg(port_info);
> +	if (ret)
> +		PMD_DRV_LOG(ERR, "Failed to disable DCB");
> +}
> +
>  static int
>  ice_dev_close(struct rte_eth_dev *dev)
>  {
> @@ -2860,6 +2885,7 @@ ice_dev_close(struct rte_eth_dev *dev)
>  	if (!ad->is_safe_mode)
>  		ice_flow_uninit(ad);
>  
> +	ice_deinit_dcb(dev);
>  	/* release all queue resource */
>  	ice_free_queues(dev);
>  
> @@ -3670,6 +3696,35 @@ static int ice_init_rss(struct ice_pf *pf)
>  	return -EINVAL;
>  }
>  
> +static int
> +check_dcb_conf(int is_8_ports, struct rte_eth_dcb_rx_conf *dcb_conf)
> +{
> +	uint32_t tc_map = 0;
> +	int i;
> +
> +	enum rte_eth_nb_tcs nb_tcs = dcb_conf->nb_tcs;
> +	if (nb_tcs != RTE_ETH_4_TCS && nb_tcs != RTE_ETH_8_TCS) {
> +		PMD_DRV_LOG(ERR, "Wrong number of TCs in DCB config");
> +		return -1;
> +	}
> +
> +	if (nb_tcs == RTE_ETH_8_TCS && is_8_ports) {
> +		PMD_DRV_LOG(ERR, "Wrong number of TCs in DCB config");
> +		return -1;
> +	}
> +

I don't particularly like having the same error message given from
different blocks - can you maybe make them more specific to the error. E.g.
in first case tell uses that num TCs has to be 4 or 8, and in the second
case that it has to be 4. Ideally, we'd check the 4-TCs case first and then
the 8, so we get really useful error message for user.

For example:
	if (is_8_ports && nb_tcs != RTE_ETH_4_TCS) {
		... "Invalid num TCs setting - only 4 TCs are supported");
		...
	} else if (nb_tcs != RTE_ETH_8_TCS && nb_tcs != RTE_ETH_4_TCS) {
		... "Invalid num TCs setting - only 8 TCs or 4 TCs are supported);
		...
	}

> +	/* Check if associated TS are not in continuous range */

This implies that we don't want them in a continuous range. The check below
suggests otherwise. 
Also, s/TS/TC/ ??

> +	for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++)
> +		tc_map |= 1 << (dcb_conf->dcb_tc[i] & 0x7);
> +
> +	if (!rte_is_power_of_2(tc_map + 1)) {
> +		PMD_DRV_LOG(ERR, "Bad VLAN UP to TC association in DCB config");

Expand UP to User Priority for clarity, I think.

> +		return -1;
> +	}
> +
> +	return rte_popcount32(tc_map);
> +}
> +
>  static int
>  ice_dev_configure(struct rte_eth_dev *dev)
>  {
> @@ -3695,6 +3750,133 @@ ice_dev_configure(struct rte_eth_dev *dev)
>  		}
>  	}
>  
> +	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
> +		struct ice_hw *hw = ICE_PF_TO_HW(pf);
> +		struct ice_vsi *vsi = pf->main_vsi;
> +		struct ice_port_info *port_info = hw->port_info;
> +		struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
> +		struct ice_dcbx_cfg *local_dcb_conf = &qos_cfg->local_dcbx_cfg;
> +		struct ice_vsi_ctx ctxt;
> +		struct rte_eth_dcb_rx_conf *dcb_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
> +		int i, bw_share_percent, bw_share_left;
> +		enum rte_eth_nb_tcs nb_tcs = dcb_conf->nb_tcs;
> +		int nb_tc_used, queues_per_tc;
> +		uint16_t total_q_nb;
> +
> +		nb_tc_used = check_dcb_conf(ice_get_port_max_cgd(hw) == ICE_4_CGD_PER_PORT,
> +			dcb_conf);
> +		if (nb_tc_used < 0)
> +			return -EINVAL;
> +
> +		rte_memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));

No need for rte_memcpy here, just use regular memcpy, or even better just
use assignment: "ctxt.info = vsi->info;"

> +		if (rte_le_to_cpu_16(ctxt.info.mapping_flags) == ICE_AQ_VSI_Q_MAP_NONCONTIG) {
> +			PMD_DRV_LOG(ERR, "VSI configured with non contiguous queues, DCB is not supported");
> +			return -EINVAL;
> +		}
> +
> +		total_q_nb = dev->data->nb_rx_queues;
> +		queues_per_tc = total_q_nb / nb_tc_used;
> +		if ((total_q_nb % nb_tc_used != 0) || (!rte_is_power_of_2(queues_per_tc))) {
> +			PMD_DRV_LOG(ERR, "Wrong number of queues for DCB configuration");

I think a little more clarity in the error message might be useful.
Suggest splitting the check into two with different messages e.g.
"For DCB, number of queues must be evenly divisble by number of used TCs"
"For DCB, number of queues per TC must be a power of 2"

> +			return -EINVAL;
> +		}
> +
> +		for (i = 0; i < nb_tc_used; i++) {
> +			ctxt.info.tc_mapping[i] = rte_cpu_to_le_16((i * queues_per_tc <<
> +				ICE_AQ_VSI_TC_Q_OFFSET_S) |

Nit: I'd put the line break straight after the rte_cpu_to_le_16, so that
we get the multiplication and shift on one line.
Also, maybe add some extra brackets for clarity, for those of us who are
uncertain as to the precedence rules for "*" and "<<" :-)

> +				(rte_log2_u32(queues_per_tc) << ICE_AQ_VSI_TC_Q_NUM_S));
> +		}
> +
> +		memset(local_dcb_conf, 0, sizeof(*local_dcb_conf));
> +
> +		local_dcb_conf->etscfg.maxtcs = nb_tcs;
> +
> +		/* Associate each VLAN UP with particular TC */
> +		for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> +			local_dcb_conf->etscfg.prio_table[i] = dcb_conf->dcb_tc[i];
> +			local_dcb_conf->etsrec.prio_table[i] = dcb_conf->dcb_tc[i];
> +		}
> +
> +		/*
> +		 * Since current API does not support setting ETS BW Share and Scheduler
> +		 * configure all TC as ETS and evenly share load across all existing TC
> +		 **/
> +		bw_share_percent = 100 / nb_tc_used;

bw_share_percent is an int, so we lose accuracy here, which is why we have
the additional increments below, I assume.
Therefore, I'd suggest actually defining bw_share_percent here at point of
use, to make it clear (you can make it const too), and also defining
"bw_share_left" immediately afterwards to make it clear it's not forgotten.

> +		for (i = 0; i < nb_tc_used; i++) {
> +			/* Per TC bandwidth table (all valued must add up to 100%), valid on ETS */
> +			local_dcb_conf->etscfg.tcbwtable[i] = bw_share_percent;
> +			local_dcb_conf->etsrec.tcbwtable[i] = bw_share_percent;
> +
> +			/**< Transmission Selection Algorithm. 0 - Strict prio, 2 - ETS */
> +			local_dcb_conf->etscfg.tsatable[i] = 2;
> +			local_dcb_conf->etsrec.tsatable[i] = 2;
> +		}
> +
> +		bw_share_left = 100 - bw_share_percent * nb_tc_used;
> +		for (i = 0; i < bw_share_left; i++) {
> +			local_dcb_conf->etscfg.tcbwtable[i]++;
> +			local_dcb_conf->etsrec.tcbwtable[i]++;
> +		}
> +
> +		local_dcb_conf->pfc.pfccap = nb_tcs;
> +		local_dcb_conf->pfc.pfcena = 0;
> +
nit: I'd assign these values up above, after the memset. They look a little
out of place here.

> +		ret = ice_set_dcb_cfg(port_info);
> +		if (ret) {
> +			PMD_DRV_LOG(ERR, "Failed to configure DCB for PF");
> +			return ret;
> +		}
> +
> +		/* Update VSI queue allocatios per TC */
> +		ctxt.info.valid_sections = rte_cpu_to_le_16(ICE_AQ_VSI_PROP_RXQ_MAP_VALID);
> +		ctxt.info.mapping_flags = rte_cpu_to_le_16(ICE_AQ_VSI_Q_MAP_CONTIG);
> +
> +		ret = ice_update_vsi(hw, vsi->idx, &ctxt, NULL);
> +		if (ret) {
> +			PMD_DRV_LOG(ERR, "Failed to configure queue mapping");
> +			return ret;
> +		}
> +
> +		ctxt.info.valid_sections = 0;
> +		rte_memcpy(&vsi->info, &ctxt.info, sizeof(vsi->info));

Again, regular memcpy is better here.

> +
> +		hw->port_info->fc.current_mode = ICE_FC_PFC;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
> +{
> +	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw = ICE_PF_TO_HW(pf);
> +	struct ice_port_info *port_info = hw->port_info;
> +	struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
> +	struct ice_dcbx_cfg *dcb_conf = &qos_cfg->local_dcbx_cfg;
> +	struct ice_vsi *vsi = pf->main_vsi;
> +	struct ice_vsi_ctx ctxt = { 0 };
> +
> +	memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
> +	if (rte_le_to_cpu_16(ctxt.info.mapping_flags) == ICE_AQ_VSI_Q_MAP_NONCONTIG) {
> +		PMD_DRV_LOG(ERR, "VSI configured with non contiguous queues, DCB is not supported");
> +		return -ENOTSUP;
> +	}
> +
> +	dcb_info->nb_tcs = dcb_conf->etscfg.maxtcs;
> +	for (int i = 0; i < dcb_info->nb_tcs; i++) {
> +		dcb_info->prio_tc[i] = dcb_conf->etscfg.prio_table[i];
> +		dcb_info->tc_bws[i] = dcb_conf->etscfg.tcbwtable[i];
> +		/* Using VMDQ pool zero since DCB+VMDQ is not supported */
> +		uint16_t tc_rx_q_map = rte_le_to_cpu_16(ctxt.info.tc_mapping[i]);
> +		dcb_info->tc_queue.tc_rxq[0][i].base = tc_rx_q_map & ICE_AQ_VSI_TC_Q_OFFSET_M;
> +		dcb_info->tc_queue.tc_rxq[0][i].nb_queue =
> +			1 << ((tc_rx_q_map & ICE_AQ_VSI_TC_Q_NUM_M) >> ICE_AQ_VSI_TC_Q_NUM_S);
> +
> +		dcb_info->tc_queue.tc_txq[0][i].base = dcb_info->tc_queue.tc_rxq[0][i].base;
> +		dcb_info->tc_queue.tc_txq[0][i].nb_queue = dcb_info->tc_queue.tc_rxq[0][i].nb_queue;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index da508592aa..451816affd 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -795,6 +795,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	struct ice_tlan_ctx tx_ctx;
>  	int buf_len;
>  	struct ice_adapter *ad = ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	u16 q_base, q_range, cgd_idx = 0;
>  
>  	PMD_INIT_FUNC_TRACE();
>  
> @@ -839,6 +840,26 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	tx_ctx.legacy_int = 1; /* Legacy or Advanced Host Interface */
>  	tx_ctx.tsyn_ena = 1;
>  
> +	/* Mirror RXQ<->CGD association to TXQ<->CDG */
> +	for (int i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> +		q_base = rte_le_to_cpu_16(vsi->info.tc_mapping[i]) & ICE_AQ_VSI_TC_Q_OFFSET_M;
> +		q_range = 1 << ((rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
> +			ICE_AQ_VSI_TC_Q_NUM_M) >> ICE_AQ_VSI_TC_Q_NUM_S);
> +
> +		if (q_base <= tx_queue_id && tx_queue_id < q_base + q_range)
> +			break;
> +
> +		cgd_idx++;
> +	}
> +
> +	if (cgd_idx >= ICE_MAX_TRAFFIC_CLASS) {
> +		PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
> +		rte_free(txq_elem);
> +		return -EINVAL;
> +	}
> +
> +	tx_ctx.cgd_num = cgd_idx;
> +
>  	ice_set_ctx(hw, (uint8_t *)&tx_ctx, txq_elem->txqs[0].txq_ctx,
>  		    ice_tlan_ctx_info);
>  
> -- 
> 2.43.0
> 
