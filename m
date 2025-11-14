Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C15CE8D47
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:00:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B71440E72;
	Fri, 14 Nov 2025 17:00:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 53C9740E2C;
 Fri, 14 Nov 2025 17:00:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763136010; x=1794672010;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bdZ1VDek1dKZRo64VAns42hBiv5tlzM+3YJ6U12FrBQ=;
 b=himvOjmdTQi9mvOpZSUJ2cZ3A+19DIAgKE2ViW2DGOzyO6h5Dng2eOTR
 FAyUivWwaxuRCUmdJOGORM9kk4+FG5WKaxAiWdA5XYS5sA05zZ3nt6kxQ
 JMag+jejs654H7TK7MDfIV9DreSwNb7h9s/ya46tHokASLNIMVDoQK7BB
 kX38F1LUhwtNA284A0oyzw6vWhfx6OGl+n0wqQvDEB8Zz/D5bruRrbOsH
 DcaclnjCph5FARXt5ambb8zxsmy87AdeGDqnldehC/jfiB/WKO8qLv+VO
 mFJj/QKfhBrxL4cHoOhL1ErtYe0hRqH+1KXPcULDAMa+EBwoJgrP7KgH4 Q==;
X-CSE-ConnectionGUID: glrqO96YRlKMKZVcafmKDQ==
X-CSE-MsgGUID: zuwaJ4vPRtS+4jdgQ2jdxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="76694281"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="76694281"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 08:00:09 -0800
X-CSE-ConnectionGUID: mVrCHd8tTj6sejODfyIrUQ==
X-CSE-MsgGUID: wS+Uxt4+SP+nDFck2No8Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="220449258"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 08:00:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:00:06 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 08:00:06 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.29)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:00:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcXvWBPmfUMA9n8+7/gKtPLzRvwcMvJQ2qJMtN5L+9TRGIkOmSsH343F230ZJJY+LEI6HANF0I4iE3/BIdHk8fEsPvqpYEqD3XRRhkfw45JcXnpmsdRGrZawPuni2xtIx9vjq109z+XcORXgUcmhCbmRC0QOHQLsXafywl9chGNouEl4bHKkvEtozBUuDD1rbOwT4gWXicNN1u9ADokkLQM0XFBYUviQfnHc/D8A1nCvmDNSBwU2YQXxhqfSci4hxVQJ94kE39VINOqSgCtjeOvdZc6wPzynpCfPVguTaQeslBS3SoaX6J881lrPtgB313uSn3+JFWGcB7NCe+RoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keKJBtoPk8A0tKRyaWMDgM86G26FxykghO/pXhkqqOM=;
 b=m/APy+LJ0nrMBHlGy246t4xkxzTd25szUKkrNd2+sr8DA2+JWPVHG/RGw0jtv/uYxyUXICOCNllNJWEO/R+Dj8BDVh/yJjszrcMlAIscQYiSW8XBDFHrDCNJmcPb8hiklrCDhryOZ2clA0J5OzMheG5cEHKIqDcHfIvaRbcC5/uBa6OZSsnjj42CD+h/iGy0GWgfKfQ08LZ4XgmL3bpN+9kMuwQe/crM7xhTG0pQBc1JpFcBLUZTru12kVSpphdCKbugGwy+05AZw7NKoq3hHUaLrdM4GSXNMapeKS1sAwPzdMFA4GHpXgu5hpU3revt9MG0jJ55O7rfhstX3cBbJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 16:00:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 16:00:04 +0000
Date: Fri, 14 Nov 2025 15:59:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, <stable@dpdk.org>, "Chenbo
 Xia" <chenbox@nvidia.com>, Adrian Moreno <amorenoz@redhat.com>
Subject: Re: [PATCH v2 2/7] examples/vdpa: fix format overflow warning
Message-ID: <aRdR__Vl97VdOE3V@bricha3-mobl1.ger.corp.intel.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
 <20251111221857.443752-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251111221857.443752-3-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3991a4-7b7e-4931-8c7f-08de2396df8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B2JtlL9VVJjfEAC2V/EZXMEtGZF2Ee1z2yJYo7C76QBQH6hZDnk76mX4EPQ7?=
 =?us-ascii?Q?3BNd9UcjoyNrfUMgHaXvbDoI/1XswuW+jk29oyN3BJl0p6AJv0sZTTlrNgPH?=
 =?us-ascii?Q?Nc7BbROZwohb5GOrWV0nf1RD8mtENAfjyOtT1Lfl4De/z5jwFyXeISDKnlEU?=
 =?us-ascii?Q?HeFhOB+fxgYsI8ExLWrBXFa/xuWk01Rqs9uqZGOmQ40upZc36pU6B2SJeVju?=
 =?us-ascii?Q?60N2o2WsrV8l6Kb09D6MaOlMvT+0Q9M5WFNqbNDmzlkBpTrFbluv+eRVwMDE?=
 =?us-ascii?Q?+HTiNAinOFL2S+M7OwEY39uGY4YFAk7ae/tJmf2ldYcKPtILlt5EIGcLHQLb?=
 =?us-ascii?Q?QxHJAISgXafhwl0Z97FfH+qBcWN8/itX4yjMv29pgaTwA9thp/dSKJfMv7gw?=
 =?us-ascii?Q?YY36t4cSAwIb4lN5c/WS92lNon00eRUucffaAGT1oip98jQJ0dWwsYdEPDgZ?=
 =?us-ascii?Q?pL0kKGLbY9fWMco1Bl/GA1tK0MSdtIcTwyndL60MIb1XjvROvzwdj24OK4WA?=
 =?us-ascii?Q?cqq3+AwMyfbcsQ2cqudY0PbvlaWosXhqbVuBhdXdhHlpxWl+KtMrKi4nmLH0?=
 =?us-ascii?Q?ntU8W9qp6iPuqYecDZLQUa53XpQ/5WzIOHPDcuoH7Nfgud3BV2X8Vfd07o9e?=
 =?us-ascii?Q?bPtHfPq0jaKWqc07o2OOTeF2+Iq9ZFWYn+HIk88/CMqtwFF3kFPwuU51YEM4?=
 =?us-ascii?Q?xwkKomI0M3ong1JpZnvG/9Bgb/qH/BPmJ9vJgEZD8+8Az3lnsXE13cgPMIy/?=
 =?us-ascii?Q?hzIzUfvjFiXVcl/yH7caV5Jr7I44t+5Efi+3LzRA+wLPSUpV59kCUCrJ/XHx?=
 =?us-ascii?Q?5duZOLWJ28g5ubsw14HY9n5IHPv6TwmgsYXQOhuVCzi4vxJjGHy06n5I5zhN?=
 =?us-ascii?Q?EqmLChBvxRCvExmEcIeeZ7aNqKxzzVG2nAIoVwucwxeK2gljjkIBPOHcg9yd?=
 =?us-ascii?Q?fbvYz2aUdte1+XKLVFb35lsOJEEFtwHSIDhLNkwVo+As2fkjcLN0Phc9eMJZ?=
 =?us-ascii?Q?qYRK38JAShmiKdxIAuIpGq0gpY5Az9X8CCCnVVWJgfLIsv9hc0DLh/ZMPRFm?=
 =?us-ascii?Q?79iX6pQPMvaTRFe+oGMyeltvZJRzOsHvx0CZj4vAvfSrGht/EG//H0LA2QWv?=
 =?us-ascii?Q?Qen3OE4TD49NfR2gE91SV2/vgLT8SENS1MXLlNljnhcFVUjJqj6sFwAeTlOH?=
 =?us-ascii?Q?6eBApbiCbG9qbWO8Y0VQMKSWOiL170Z5y1GFmSFRbVjgOazee1EAH6lLj7fw?=
 =?us-ascii?Q?alaDwcs9kiuPxoxV12zm0VnJQqHprpqYqcH7pmd5GqQs4NnbwLJNu8YdirJB?=
 =?us-ascii?Q?CiM5ytQx2569x9Yy+sbUPR+8CPfWpB769zWAZF0q/oWRKty+7XEwlDkxPy8c?=
 =?us-ascii?Q?sf2zAkB2zvyWkK4ImfexkskGvPsfYwh9AZwhsUS/njJNlU2gYSM3mSeY+7k5?=
 =?us-ascii?Q?NU0ra/Mqd2o0uxUugWK88RcDsAE0k4Ya?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kiofaTMoLiNtoNAFamT0Mk1AKokfVgl1YjRUnI27nQ58adIq/OTx2WO1wPkO?=
 =?us-ascii?Q?K8WGarp7seoxnP4ww7ftIks/zhxNtqcvBdjKkbRUSUQ7/3sP1n5J+IHs/o0Y?=
 =?us-ascii?Q?8HM4ddlrUB8/xqRPlEi7YGglmuFENYfqvJcYeumkUx3Bp6PPtvqYYDmJRy4H?=
 =?us-ascii?Q?YSm2qDfBiLzn+VvODOvTJRwIOV/UgmVE3ZjuLJzo78LxcbwQrI9Fte5ziL3s?=
 =?us-ascii?Q?lDbV03QXROc4yJBWtNEJSrIW9Rwkh5/0q1ka+4kKp+NxQBB8gDaqMS4vpzKJ?=
 =?us-ascii?Q?OBtzrCkhrDrFSHm5E2sMgSJohvLxe280WU2gAJEq1AEBKHxyUR221IWlXLuQ?=
 =?us-ascii?Q?RFyLkTWHnTq262uI1HBy78PLnITq4RI4z1QgsCALWc+oJu4qYhC/8BHhSVob?=
 =?us-ascii?Q?TYbGS71CTHrkgTKlb4kJ75RFuhVaXRrF0YnPehHNNWHTw5PI+UYmoetZ/0VS?=
 =?us-ascii?Q?oOvvCvEEleWlFR4nqRMrVvjsardrLIneAyHqWqFdiYtUSeiGBqa4E5dO7vRq?=
 =?us-ascii?Q?LoYqrYaBx5VJRhnqNb/nWeRoU6lwEwz+ufInCL3kL5rkC8Bffnb3/9rHlGhc?=
 =?us-ascii?Q?UzQN/cEKffcu7W0TLrHMNENSv1X+X2ppSdJt0MtB6oxcirwhyjZDo3CYOvZG?=
 =?us-ascii?Q?MsKFJvPOjwdKMMTceBMg3teA5gwsBxtIXCRUrbPi5UPDv6CtTajMcNe87H/C?=
 =?us-ascii?Q?WuvcsyqB5oONbWIb9vHzcQ/eHkQ1t+1QHaC0JAKqVViibvXzmYVzEdvc1XDV?=
 =?us-ascii?Q?TKCimj3wHexv6a0LaU3K95dzDuPJ9KWoz3iCDWN/+f7SMssIf/kw4G2l6wFI?=
 =?us-ascii?Q?tayBdj2noYIX9ON3AP1gJKIlHIiK1IdN67Itpu82s4KBPeo1nFDac59k2Wk6?=
 =?us-ascii?Q?/ATKR+0xq+qPW1aP4DBdj1ZBg+h7JjWL97lUP+vBOON3MY9B9lkUkcAO4/5K?=
 =?us-ascii?Q?/Qpxm3cfOg7DSLPLQu2eVs8WGnwYryQqiWsGBya90uAB3xYRAjx5+U72NaCl?=
 =?us-ascii?Q?8940YYI2yrWzo/2negmbfaehKpr2mZEUiKZ3lwIXWAOa+OMHOoDz5gu9S/1O?=
 =?us-ascii?Q?zPGgpDzKiCYS5ck8gqy3lPh/us7k1ssN++up42u+dR3EhDgf2ewMYYTGYQNV?=
 =?us-ascii?Q?QFgUwgQ1arWlUgAbnfJjDuAzdJjz2LV/bRp7VAGYvJoueRjrnvNojfBCZ4G/?=
 =?us-ascii?Q?tj6KUAGeLT8SxJw0GyJw7SBHJ+jvIUWwFWeNIpln8j4kHHo3Zstn9ABCrE7O?=
 =?us-ascii?Q?eFvy0YmL2Zzr7P3PQ7LabQeFJGh3qMzMv1bEbESUxv99uvwFZ/LRAVGQHtaW?=
 =?us-ascii?Q?vBNJhYVsNmvzeEnhAOMC4Yst8AkezHGvHMQUZ9g7/CQDhTMhJ3NEbQajNcrS?=
 =?us-ascii?Q?qF4Sa6XnVX0DzJT9fnAa5LKytUWs+pXKl15jHV0GOqgY5tljjs8tpexfT9I3?=
 =?us-ascii?Q?eq/9jls/7xzdBN32KmK+81t0MxBL3/ZcVogWr6O+w4GdRK9/6Lfq6u/8v8zM?=
 =?us-ascii?Q?ePb0CfDNQNdjW3hDc8sr7cy4SWoAzPvOF92iNbk3IYzfQhTpJpnOb6+x6KtQ?=
 =?us-ascii?Q?9xtS2ivm9b1Sw/O00P58cH/zhiqfQDlutvKVaRrPXmXITe5ApI+BcRxvICeV?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3991a4-7b7e-4931-8c7f-08de2396df8e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:00:03.8669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRuPu41gpfK8Uhf/zuvjKkIHKep41hMJSk5lMZ1gkl/vBL58SRpcJke3faQYOZ7ecT1YrkdPC+24dLkFxGhBTY9zDXRtd11mxfA6Hk6iD74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827
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

On Tue, Nov 11, 2025 at 02:17:19PM -0800, Stephen Hemminger wrote:
> The ifname is limited to 128 characters, but it would allow up
> to 128 characters as prefix then could overflow creating ifname.
> 
> Change to limit path prefix to 124 (128 - sizeof("1024"))

nit: sizeof("1024") == 5, because of the \0.

> to avoid possible format overflow
> 
> Fixes: 38f8ab0bbc8d ("vhost: make vDPA framework bus agnostic")
> Cc: maxime.coquelin@redhat.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

I assume this was found by enabling compiler warnings. It would be good to
include the actual warning message in the commit log, given that the patch
doesn't actually modify the line at which the overflow occurs.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  examples/vdpa/main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/examples/vdpa/main.c b/examples/vdpa/main.c
> index 289db26498..7fd0e55b20 100644
> --- a/examples/vdpa/main.c
> +++ b/examples/vdpa/main.c
> @@ -22,6 +22,8 @@
>  
>  #define MAX_PATH_LEN 128
>  #define MAX_VDPA_SAMPLE_PORTS 1024
> +#define stringify(x) (#x)
> +#define MAX_VDPA_STR_LEN sizeof(stringify(MAX_VDPA_SAMPLE_PORTS))

We have RTE_STR() and _RTE_STR() in rte_common.h

>  #define RTE_LOGTYPE_VDPA RTE_LOGTYPE_USER1
>  
>  struct vdpa_port {
> @@ -36,7 +38,7 @@ struct vdpa_port {
>  
>  static struct vdpa_port vports[MAX_VDPA_SAMPLE_PORTS];
>  
> -static char iface[MAX_PATH_LEN];
> +static char iface[MAX_PATH_LEN - MAX_VDPA_STR_LEN];
>  static int devcnt;
>  static int interactive;
>  static int client_mode;
> @@ -74,9 +76,8 @@ parse_args(int argc, char **argv)
>  			break;
>  		/* long options */
>  		case 0:
> -			if (strncmp(long_option[idx].name, "iface",
> -						MAX_PATH_LEN) == 0) {
> -				rte_strscpy(iface, optarg, MAX_PATH_LEN);
> +			if (!strcmp(long_option[idx].name, "iface")) {
> +				rte_strscpy(iface, optarg, sizeof(iface));

I realise that the rte_strscpy function is what was here before, but given
that we are not checking the return value, there is no reason to choose the
dpdk-only strscpy function over the more-standard strlcpy.

>  				printf("iface %s\n", iface);
>  			}
>  			if (!strcmp(long_option[idx].name, "interactive")) {
> -- 
> 2.51.0
> 
