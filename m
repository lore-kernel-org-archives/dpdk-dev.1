Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55513C982DA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 13:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 969464325A;
	Fri, 18 Sep 2026 15:15:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id E2B5042F39
 for <dev@dpdk.org>; Fri, 18 Sep 2026 15:15:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789737309; x=1821273309;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fl58TcIH2jzv/g9R0cJZ8cbGvPRaczwuyONh4Y65tZE=;
 b=X9TMPLyfBU1am2MuYOTudbfyxeTxNWTAehD4LYh7cbCq2nEY9yNASOGd
 Mxep+3XXPl/6bDVCEAinIOZaEfuNMrgvOOPzGaLZMiOPBQsgZA9nHJoY8
 qy8WKoDlVwcv09ZfltaI1Xv6pQRwn8DvsbyeZNb59aofgGwdOY+1ZL54K
 KurbRVwvoehY90GM0Soy7I7+9nPuwS+Cn/s7vHOXkwzk6l3Wfvw7A06Za
 fUibEqaWJOzalF9qXqqWL/15qTHShMaWhE85KimyVdqF5Rwocf5frtKzF
 2QfvNuW0oGAInx5Yef05OX2F6AMCq0cQHa0qbeB2TYgqWfU4pvwB/QZUs Q==;
X-CSE-ConnectionGUID: OWQ9b9qiTCeb8qCdOH0eeA==
X-CSE-MsgGUID: Eskpss0fTHSx37pLotlcBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="100838571"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="100838571"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:15:05 -0700
X-CSE-ConnectionGUID: XAcSqxktSBu5DkNcULmlwA==
X-CSE-MsgGUID: iB4MpdZTQK2JqAYa+zBa4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270711066"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:15:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 06:15:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 06:15:04 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 06:15:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1RHCo0h2B7ZqL5qTFl8lIHwg1dQSAkyDfeovCyHicl1kdYNua7geeSuxbpZJSnffKdrWg4Y3oe/1b0UsDNvUlsbhTmER8G8SeTHhgR+e3HaMvAP/JHIWTP00YmCPNpGpGNSQlj3DxBVD0/p5zOK39Us7pMcPNIkAdGBxYyWdxTLlwpXKGMlO/x/uGBSUWZ1VckOLM63A2ps84KnVeZYqnXCuNSt9eFt3kANHeEjlfxupm9I7JW0iOxNhk2wBthxySvUAoU5rSq/Z8Hd1odQh006Ao67HUYvBjJ/IT3RIWJApZG2wjNM9Ec7Tm9cQzTM/dyHl8BXWLHf8v76ISCUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgpkVvIflwJNbqBAa+Br74zUH92P4IIy6cKpRJXPCSc=;
 b=DuSXBmUoaJbTaDJzswoQBwrb7DAS7SNAYhnznhY4SvflwwQekTIOLz0MeOkROZ3wTKRmZPgLNa3hsS1r3jcl1A1gMDPnBzVPyJbWr4vmBo7H1mOmYR1N/gs49OcYLMvmbJ0OIGDm0HpNvDciBHmbJxoirLoMI8soze2XIPC4tiXuxgRvoLAvDsB3V9yOUT/zwkyTwpYmVr2oTk0ZOhS4Sgk8sstunIl5IOb3z/tFOID7SgqX5Va2FE8pD35MtcmtGoQcgOil4Rc9GTOv0j4R7G19bKje+1BzgYM79z09nWypKQedj5/fUFJCUpgHcfHfmWVUvpvjSw1d8Arihxpx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM3PPFE441933A2.namprd11.prod.outlook.com (2603:10b6:f:fc00::f56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 13:14:59 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 13:14:59 +0000
Date: Fri, 18 Sep 2026 14:14:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Omar Munchaev <omarmunchaev@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/intel: use rte_validate_tx_offload function
 correctly for i40e/iavf/ice drivers
Message-ID: <aq05Tvy9xSXjuQR1@bricha3-mobl1.ger.corp.intel.com>
References: <20260916162927.2137856-1-omarmunchaev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260916162927.2137856-1-omarmunchaev@gmail.com>
X-ClientProxiedBy: DU7P189CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::7) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM3PPFE441933A2:EE_
X-MS-Office365-Filtering-Correlation-Id: 310cb971-bcfa-4800-f0f5-08df1586d73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hixPJc5hcE6FWCK5cmkhdjwFP5Y1Rk3cx2OyYUiLJVyjGIHbqnD95fFVNaeN4uRr1ZzwWbzalzyKqq4uPce85I1BR1evX2kYp6rWNfdQ/IPCqHnpo5OZ8/mw19Kr7G2ED1m4EVDKTmQfgKft1+QPh3ZepjzigvfqIbHf5N3Nq4lA7MZw2rWZXF+oFKOnJAZfzE4cwLYcmfXfcgSmXMBflpj30nHGc3Y9ny3b8umn7q0EggmaKC2O8+4pixbabuZBJdWllw2JBiTAt9Nv9O8MDIrouz7W4QecYEqx3zbNq2sEQgxG+cApktxG/vhX1lLNju3vhmohwm0On2kVzfeINq5ef0PGr1bKQxQGysnb1x77BQkiiAPxtYeuo2MNW+Y8Chp9EBOV3mwxU3o48PyGi3OlhBlqJGtCWIAWvyF3ncdmE52ib3hnXPkXTp1R4rYPOo2y4C/Zq2Chw5ISqE9gkheDBaWgLodk2Z9oIR/0P66CJiQO6ulDuEuqjsk179VzSuDIOKl4VGVjN0um+Dojjiqg2L3BCipoB5rl8TTBKBvJwtS1ILCMwnweZJAVFbqCG1FdY0a4v3XxDTv+quOPOY+WCTKedd9YksuQGtGbh7PBsdkpLogL0QxHB+xqe3y9y7x5JtCMSQQ+ubVKVfAwOJTNgOB8qavBU2sv7pvoG5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MlvfOT8t9JtRmDXjUAR9jJ//A/wWPR9gNWJQYkuo4wMUHw6ZnMphAeUMm/am?=
 =?us-ascii?Q?88nitytTavFCwfRi7KmRUpHwsjnHXjxowXM0GwkZBGFM1BfCVJNY6jUR57SP?=
 =?us-ascii?Q?8E5qF5tcUTLSKE4VKPRB2BpMCOYb3Gyomi7G1/w6iqc1mKBTVN2GScGRdJ1T?=
 =?us-ascii?Q?fBgoZLyt9mlbUhoU3ZSqP/WrPwTmq5BlI1T/ZwWjY6xkLtiGgijvu/yeptxM?=
 =?us-ascii?Q?QDHEreTkvIttxqgH7AdptYFf8UOWJGuo4FnZGz/tnXk84mCGaTrk0ukePL3n?=
 =?us-ascii?Q?U5iequ8Zn+o9W797BYsEtaSrCikvTnv+IJPcuju/R9vKKZjUwSoKW0TqB/oY?=
 =?us-ascii?Q?GDH5ATvBrnl5EuNWgeO4M0gmpFoSy0N5pVuHoLkfyrJLNL3apkPdm09TwsFs?=
 =?us-ascii?Q?Xv8E+E4stWa89F83ftAki+SIe4+4omqcnsZygsq3sdXrS6jtbQ7Zk5nuw3HC?=
 =?us-ascii?Q?LSm5UPNqhfBvxbSsLREuTIGfwN6lmWTnyKH3af1vejltpoYGVlmWBOuYRrzP?=
 =?us-ascii?Q?LXj17yDy7zhiCTb+hQP410AdKEBuhMbGAqLNfCwqm5RxkHXXDWFSg3yBw2Oj?=
 =?us-ascii?Q?arJNiKEfiaNZDHcsc8rufKJuQbI1lNS3dadLgbvaP4T4dmxO2+SZTc3nTZ7v?=
 =?us-ascii?Q?YT3nVjXyVEyOcXtFcnANJOpCCgtdQyFzrRQitqfXPHTJpSeexsIAMNvuOB9P?=
 =?us-ascii?Q?3fB91g7ktu90Jb8BRyy3FShZJqaVBguEsigiLyUmFRIjnknInDHSsqk3rdfD?=
 =?us-ascii?Q?zp7i8ubFlY5bF3ZzQ+h/MMpEUstG8kmQ/2TG+18UDASeMuzdaMN5oTXVuFqZ?=
 =?us-ascii?Q?DYwzQK3BdzsWAHRipaoFP93zgaXvrXNZX7MNyD0fduYMVK9UH1mlAMBAfrEy?=
 =?us-ascii?Q?wPbSMvOCZjvlGbv3WQPrwFvPJNvYPE5E9A/CIIQ87dNFp7cf+hG/HukG20CF?=
 =?us-ascii?Q?g0XiSfTc63IB8Cu5ok14ud+RMAK5jvKuzX/vb4gZlhzfZB6PrPcFaHUHyZ4u?=
 =?us-ascii?Q?1zILzlKffbh4C4ps3dq4pwlFdZImyq/0vzu06Y60ncDytsM8y3YmjmxR+dsk?=
 =?us-ascii?Q?m+/OY7C2+PUuk/UfWAmx6xey48v/m7G39muHGbAj0aV0a8TQg6zNDrtghL0a?=
 =?us-ascii?Q?2vz/ZqadXwg++HWiFWx4r6TuL7JHf6I7806KyYQsZ8rci3Kth9VQir+yXy9E?=
 =?us-ascii?Q?GYcuQZWmoimLC+HE0AAebTqUr2WIX+dSPdTiRvsl1X8ohUT/Uc1Qc1Nya/LS?=
 =?us-ascii?Q?NIYJiO0VFLTiJYe93ERzJFhmnNmqj9lAC7V683SzQGbAmAo/ZCqCDvfCmKkS?=
 =?us-ascii?Q?QOn7K+ZO80q5ViBKPQEh2TDu0g2dy0IMrJ028kBzmwDF126WgkY7ZxGWb7/v?=
 =?us-ascii?Q?v4hdQ+GSr5j0jdnX+rgorLMxyZkHrQ9FSf3m7A3++K6coYuOSd8tRw4gM8W2?=
 =?us-ascii?Q?f4rcUKiQ7KiFusHpUFJjZ5LCtDDlbBxra6a6Oj5+110k+ZLVB2MVifsVd1kB?=
 =?us-ascii?Q?dYexwL+nulSe5gWqlmWh76fe+35cY3LYheKWUfoMM1H/CHbgKk8ixevn1GD8?=
 =?us-ascii?Q?NgLUU0MSRonDW6Ra9Hterg6kdmkeeSGnNkxpziMCrq2WE6sDnChpalN4baFL?=
 =?us-ascii?Q?xOxahaWO3nX9pYcIQiMkV6cq3hvUBEJcr9Rc7pP6IOv98F7PzABTirX5cUy1?=
 =?us-ascii?Q?3n6MK3RvOamjs+P72YJjJcRXchApvZ5plxHoz5f5c2g9i61htaDgjGnxZ6jf?=
 =?us-ascii?Q?Uy4ywmGsWjwYMk84mbCKTfnveXrwFC8=3D?=
X-Exchange-RoutingPolicyChecked: O/aO/7rvZm5BtA+j0IcHL7W5CEyY/ab8kqZlU8Zt7VI0V81XHy+AECzU+FHMgRI/FutKGvD9c1RDLWyxaPtnV4Vfd0lUGgN2tE3pZ9hfOi2TZPRVGBvC9tvRINP/ps+j1VukVNyIknuNFZKAviyAgNcfO02w3PZd4HQWhQmophohzSMkZYIaIntOB/Jx018TjNpSwlDGLMJ9C98tsbq1oSI8oOUscbPioUKs3hY3wkOg99KLoZ1s56HcbU7LktxmwvTQPoY7f34EdNroquFTuJqiK8hhpaEcYuzy3j3YLYZ3rtnNcCd5Mx71PeqQ93dMi8sMTsMmc9GW6Fici6eCBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 310cb971-bcfa-4800-f0f5-08df1586d73b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:14:59.3050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwiuLH5CSpSSZK2cEzolkTCBEbbu34X0yqh+2bGy8/Na23SbccgyB549GOA8f57N998ZWeoEsnhlBMlCOnD9/kic/k4OoGe5WTR8an6/Sas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE441933A2
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

On Wed, Sep 16, 2026 at 07:29:04PM +0300, Omar Munchaev wrote:
> rte_validate_tx_offload() returns 0 on success.
> The i40e, iavf and ice drivers treat any non-zero
> return as an error and drop the packet, causing valid packets to be
> dropped when Tx offload checking is enabled via EAL, e.g.:
> 
>     -a 81:00.0,mbuf_check=offload
> 
> Only reject the packet when the return value is not 0.
> 
> Signed-off-by: Omar Munchaev <omarmunchaev@gmail.com>
> ---
> v2:
> - Fixed From/Signed-off-by email address mismatch
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>  drivers/net/intel/i40e/i40e_rxtx.c | 2 +-
>  drivers/net/intel/iavf/iavf_rxtx.c | 2 +-
>  drivers/net/intel/ice/ice_rxtx.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
> index e29fcff661..ee70f7ce4f 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -1194,7 +1194,7 @@ i40e_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts
>  				break;
>  			}
>  
> -			if (!rte_validate_tx_offload(mb)) {
> +			if (rte_validate_tx_offload(mb) != 0) {
>  				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
>  				pkt_error = true;
>  				break;
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index 4f2ffe6188..10d33660d9 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -3813,7 +3813,7 @@ iavf_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts,
>  				break;
>  			}
>  
> -			if (!rte_validate_tx_offload(mb)) {
> +			if (rte_validate_tx_offload(mb) != 0) {
>  				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
>  				pkt_error = true;
>  				break;
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index c4b5454c53..3d98d821b2 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -3669,7 +3669,7 @@ ice_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  				break;
>  			}
>  
> -			if (!rte_validate_tx_offload(mb)) {
> +			if (rte_validate_tx_offload(mb) != 0) {
>  				PMD_TX_LOG(ERR, "INVALID mbuf: TX offload setup error");
>  				pkt_error = true;
>  				break;
> -- 
> 2.54.0
> 
