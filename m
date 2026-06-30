Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F033C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 17:35:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACF614067A;
	Tue, 30 Jun 2026 19:35:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 347A640299;
 Tue, 30 Jun 2026 19:35:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782840925; x=1814376925;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i8eqBE8L4VZ8DpxLEAB771TAoe0hGkmr068hr9yS+z0=;
 b=JL2eR+jgpo8Zo465KzSG6CbizQQWkpQUpXXLeKa5B88A2aVj1pV2P1A+
 9EDEI5X5Up2927BgqlUtrmTSgk64P0zdh9G6r6js23n95Y2KPHq7LiRQd
 EGp7Gm5BK0C/5Qr5Ze7r4AQ+Wa1sA/G1SxMIquqo65TX0FQwA0mRbojEM
 FxlQp4o2xnFoDNxAT91bLLp9UHiTlSDVyaX/4nR2t1EkPyic0v+pCc2CR
 q5FUU9hQRRntzK2QOUhjGCnwa9MTV0S4dWLMbqEop75m5T8awu51xV/zT
 Kcyoh0YEPlHU8+colIIs6xFE+oLKcysz0d2zFnvoCnZjklYj6wEvqdBoH Q==;
X-CSE-ConnectionGUID: IHgaB3jrQXmho2fYTbkA+g==
X-CSE-MsgGUID: 260dOWPgQ8OaW5QZV7YtSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="109111254"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="109111254"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 10:35:24 -0700
X-CSE-ConnectionGUID: m9K3x9X0SsmMY1yt3p3+AQ==
X-CSE-MsgGUID: 6jxqpvZNTSCuhBMVRnVjbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="248965852"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 10:35:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 10:35:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 10:35:23 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 10:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B93laOuFWKwBJxjyD/IhnWyvmsXxZB/ZWcMvQwFpatanTA9AV4CB7c4nCr++hQvaXqYCGtfdW+Od9lPTelVKPI5ES1bZWMWtPlHa0AtEC2uZECFyHR9kOMXHuP1EU9Db9Rjxk52nFVV5wvyIXDCBpGTgIVqKoaAGZ93/8cZ9sqL0Vwe3+gVtO+9uW0trfq8Lt9nplMo0DIc+FoFUZ51ae+T5ll6OLye5+6UJUWp0BoQnti8lbvRjtnmIgULDbT1P+mf1ojorVx4t1toT2fAXjiYfxQNtfSmca9Hy7j2AiS7oYjtpmv8wE12H+S9t5C3fYGTfXrrBAHd1f0nnHdshPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmhOToIf/G5VN7sUuwzjfmPueh9JFMzG8NiH2AjDuVU=;
 b=tWxtcgK5TD8SLwDE5tMPhzY4wnVbP14Nkc90dVo/Ftjoq9og8azNwD/Gs2Xfl8JNknFwFMAtFyxmvPJ81SBpdjH9sSIGfiCAXtQQNTw82Iu2rBCd22/F0ARwxvYr1Q9CWzf7sMJW/C+TrUGHyHY99hivDfV5/kT6Ak+XGkF2vqdUivyuTlvnAgRx+cZ+pVsZdehlzUjrZdetpyGv7D+6bYSTX6CRAipESQs5ftKRgmUDB3zaOQ433sPqZ0jXo5+TRl2RRCVRRnIhgYz72YuDt21EbXW/SnrQnsCFhG8QWVIBdJrvhUzjvbCo9pI2I8Xj/tnPZUQBsSjtkTuji2qCFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3002.namprd11.prod.outlook.com (2603:10b6:5:6d::29) by
 CHAPR11MB9679.namprd11.prod.outlook.com (2603:10b6:610:2ff::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Tue, 30 Jun 2026 17:35:22 +0000
Received: from DM6PR11MB3002.namprd11.prod.outlook.com
 ([fe80::f3b4:28e5:66ab:113d]) by DM6PR11MB3002.namprd11.prod.outlook.com
 ([fe80::f3b4:28e5:66ab:113d%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 17:35:22 +0000
Message-ID: <7be25168-9dbc-4a8a-a4be-58c3367435ad@intel.com>
Date: Tue, 30 Jun 2026 18:35:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/idpf: fix Tx of large mbuf segments
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>, <stable@dpdk.org>, Jingjing Wu
 <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>, "Xiaoyun
 Li" <xiaoyun.li@intel.com>, Beilei Xing <beilei.xing@intel.com>, Junfeng Guo
 <junfengg@nvidia.com>
References: <20260303150026.1601461-1-bruce.richardson@intel.com>
 <20260626134440.2108591-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260626134440.2108591-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0233.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::28) To DM6PR11MB3002.namprd11.prod.outlook.com
 (2603:10b6:5:6d::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3002:EE_|CHAPR11MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b860675-9c16-4642-1bd0-08ded6cdf600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IoXUp8bZRyPTsnpovIhS4/+uC9HEdkioxYj5PG5PbSKbshsZ93gvRHxbODnHpsNWInEge7DoN8FFxn3uz5znJQhN0dIVsv5b2kO42xl/UuIDNy81j+A+l53ObzS6RH6Mx49GDQn4dgyhQF4xehdwmKySNZmYhmuTNGTYk2VRhaHh48Ut1u6Soo3KQC9EboRU2+sc5n5LtxUU+qlAtlLDgEDoghyZ1/T7jMLYC6upCSnB2pW/odO0/3vqDJI5WNM6Nd+WPHh3WcKw2JAbolJeTVifqIXJ4qps3K+cUKooHIlFvK2C09OXR0ctmNWJut0uqVVZQK8VBzWcTzfS/hsTKRS4zk2YmsunTUYcCod7Egjl4Td/4UIdpZTLt1wp7k4tYKDukENChYuUVuAwgG/NdpuY2A1isv+377emMDCnnBpg+HKSCg4ZKwJL8BJon+2q9gd6blhgF6y4cuEH63oG4k2j9eD8n346lSd/u0y+GBk1fPv+Om6PL+uOkYJlvmEx/LBmeiKP2q9iujPy5rOx3g3QGarkgBoLmzx6Y0ggzGlqjFPsNUyqLTULcKtg3uPg0Uc+MVVI8tzsfprWg1zKo3T2BqziMVzrbMHLCJAvWR7FGksgqFfoCgHYLuO2sT5iTme3ZpJOO3F3VQcjw+zt+VymfV4Riqv2SyQni06P/60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3002.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnRiaHVadExKaE5jZitxQ1VpQzQwSk9HNUxnbVlxUml4SjFQRWdZMEJMZ0Yy?=
 =?utf-8?B?eGw1TGxJR09IR290dXJPeXlKWmsvcDhWaHFFdzN6NUtOdm5OaHp4aTZsUDUv?=
 =?utf-8?B?NDBLZmcrU3NKVnNWNlhBZTJJT0l1QnRreGJWbmdvR05OS0VVeEFGNmhsMWFU?=
 =?utf-8?B?VG4yK0xEQkhMc1c2bzEwYzJJcEtPQ2R4LzZQeE1ORXFYRXVQOVRyZTFsWlF5?=
 =?utf-8?B?Y2JKUDlaVkJqbCtzZUxZaVlrR2FlcisvcU1TL0ZhRkxoSmhBQjRlemtGWmJC?=
 =?utf-8?B?c3pZc3F6aUlVM3ViejdubWNyc25ac2VId2Z6RS8yRDFvNnlra1dJK0lMeCtP?=
 =?utf-8?B?VEZISWdhWmFFQ2tBb2JlS25WV3luZzRCNnA1OXgzc1ZjTXdwaExhS21PSHlt?=
 =?utf-8?B?SzZMazB1VnpYaStqYStnMFVSYjlvSnlFbjB2U1BNOWI2SHBkY1lsZUNJSm92?=
 =?utf-8?B?TEtHRUVkUy85ME83dytWRHlVQ2F1WDNyUGFaSnp5NHVGcnFvZTd3SUMreEZY?=
 =?utf-8?B?TWYzWFAvK1pIdXFkTXgyeGFoMFpBaStGckoxN1h5dnBQZlFsTC83L1dlUmpi?=
 =?utf-8?B?b1JrNTFTbVBzU1ludHZHeUh1S0JLRXFJWEFKdm9kUWlxYmcxWkdveHI4aXZa?=
 =?utf-8?B?TDFWK2Z3V0xZUUlRaWM1ckdYMnJRMjRPNENkaWF4Q3RwZVZybjRwYXBmOENh?=
 =?utf-8?B?eVdJQ09qeGJ0eDM2MWhwdmw2cXNCRVBEbURGOFg1eWVjcHFzdHNpMTFMK0NR?=
 =?utf-8?B?K2VQblppM2JZZER2MGwxTFQvQ0lKd21hMmVqSGFKUDN1cmJlRXUrT09MMTc5?=
 =?utf-8?B?THhUTXEyY1pBVTBmZE1JS0duTElIMEpmMU80eHNneFNtRkJxSFRsWWVtUTd4?=
 =?utf-8?B?Nm9wTlpUZ1JqZ0hUbi9GL2xpREQranF3VXJWdTlxYXB4YXN3MU5kRTVELzJt?=
 =?utf-8?B?RzJSZTUxckUwRlFEaGxsL1IvSS9rS3JtN3RkWUFHQVJrSVhFTklIOE8vdGlh?=
 =?utf-8?B?NnlDRnNvQTV3S3k2d3FOMis1L0xPWHFtV0F2SDdBdGxRUG56RWJTSEdFTCta?=
 =?utf-8?B?TkdMVHdRNFNnZUgvL3ZlcldEU25WZExpcUs1QWFRaFZxVXVoMUlCTlEvSm9W?=
 =?utf-8?B?YXd6V0hpOVBvWXZGT1JrMVdaK1pwVHNYbzVlRGk3dGFJK3FuK3hVUDZXeHpm?=
 =?utf-8?B?OUZtVW1zN0F2elpaenBXYllJNElBN1lsWHNJYURCc0x6YkpEQXdqNVYwSFFF?=
 =?utf-8?B?QUJsbUEzY0s1dENkek1OWjllQW9kNm9HbWt1b1NlbXNIcWlEajVMU21YMWVp?=
 =?utf-8?B?YWoweGdmZlJ0N01MdGJJRm0xbEFGRXdKVFRkNWFTS0lHYk1kbjJhcGRBVHNG?=
 =?utf-8?B?ZnNGeGc5V0V4Qm9iVVd2OU9jLzcyT2FVd3JFUjFWK1Uzd3JnaCs2VlJKZTAr?=
 =?utf-8?B?RjAveVd2NVUyWitKdFlqV3A4OEdubXFadGd5WDJxdmVkUXdPa2EzMDB2Z1B5?=
 =?utf-8?B?a1ZqK0RxMzVINnRxQS9mYkJGNFovZGNhRTd0bXVrZG9KKzZ2Ynp4S3ZZWjNK?=
 =?utf-8?B?WDA4Z1JyN2duYzltYUlJdEVKWEZlOHFIY0NuYlgrN21ac0VUUng1UXpIcjFP?=
 =?utf-8?B?NzYwQWhJY2pybEE2ZVJPVGJRemF5WnY4ZG02bFBZdk9WQXNldWV3Nnh3NGoz?=
 =?utf-8?B?V2Z4VTFzQ01YRFVmWjByQU1Ba3RkMVNpcjArVUdoNy9mM2ozSWw3d0p5cDRJ?=
 =?utf-8?B?STJzdmtCeE43UzhrZ25vdWtnVGhITkFHR1NEK1JuTlRPOXJLVVVGOTd3b0JG?=
 =?utf-8?B?NHVEb1MvY0Y4YjRNeUIyRGVwNkZndHpRT0xvTG5lb29KYXdVSG1rV3J5TG1w?=
 =?utf-8?B?bE5TSzBtbFRQdzh0cWpoOE9lOHBEM1JZRlNVOU92OTBsYkhNR3lhOTZiT0FT?=
 =?utf-8?B?K25MUnpQOE5SOHkzVGpMUm5NaWtCa1liTzVJbnhDM0JvcFh4dE0xOGxDS1g3?=
 =?utf-8?B?dFMxem9tSzNXT1FIc1lBdHBlYUN4ZE1LaFhtSndqcU5QM0o1S2R5TktLb2hS?=
 =?utf-8?B?TmxHK3p3Ylp0SUtmV1VIYUhqWFFCS2tsM2tQSFR6b0MxSkxucWE1ZFl0YUpH?=
 =?utf-8?B?Y3NTc1QvUHRQRGhKQ2NSVkpQeWUvQm5LdldTS0EzVUlqUXlGZ0cvU0JOd2Jv?=
 =?utf-8?B?MUM2Y1laeXZIU2ZsVnFlaXdVOExIdXlhTHZMTUk4aXF1OWxHU3hVZENwRUlX?=
 =?utf-8?B?eHo2YVZzNmlYYmkwdGdIeXV6Y0NKVjZNcXpwY0ZyVlB0d2ZEQVdBOGpvS3Rm?=
 =?utf-8?B?NWtvQno4MTNPa1hRRmJMbFo1c3UxVXRiVG5teGpTL2JiWkNiRHNlVmUzOU5E?=
 =?utf-8?Q?jvuZJXeUSMq0x+X8=3D?=
X-Exchange-RoutingPolicyChecked: rqddAdm6cjW85Xy2cCO4Z70ndMGbf4/wI7Q5QCc/7GTJyVFkBVJoKaWNhGWQ5lhbio5tGD9X4rlnhGYmFYyacP4ggRxQcgyzcveVZk5iDxp7CtBVYXo/vHwZiVR8onjQZjDLaubOTEbUiDUfvyc+efQk8VtIVTSHaDsPDC+/WV8nSxcEy2dR/FWokRugkPlsKPg7P0HyCRA5jFPPUP38IDhvr0NQ7BEZkS0jB9Ma4JedXeX0f9Wa5V/JJbsshrzS7WAeB24zDx7QqAHC2vZgw+ZYljEYw1Nt0PG91UJZgWAxCsLuKUNtj5tzS6TxQ0OQkgLzD4f1IOimx+3D6jRuIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b860675-9c16-4642-1bd0-08ded6cdf600
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3002.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 17:35:22.0313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqVunGkFiQKlWbrMbPSK7XYMlEbvo0XNdF/Ui5IYAOKRfiR1urXNiymSSG8G26uN7Q2NUIDYXXeVtatXg8ca/fwPsb0CUSclE7q/O7YsUy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9679
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

Hi Bruce,

There is possible tx ring overflow after a new internal loop is added.
I'd suggest to add into account "nb_used" by moving "if (txq->nb_tx_free 
< tx_pkt->nb_segs)" check right after "nb_used" was calculated.

On 6/26/2026 2:43 PM, Bruce Richardson wrote:
> When TSO is enabled, and we get a packet to transmit where an individual
> mbuf segment is longer than 16k, we need to split that segment across
> multiple Tx descriptors. This support is present in the single-queue
> mode of idpf - since it shares common code with the other Intel drivers
> -  but was missing from the splitq path.
>
> This patch adds the proper data path handling. Previous work ensured
> that the descriptor count calculation took over-sized segments into
> account but the actual descriptor writing part was overlooked.
>
> Fixes: 770f4dfe0f79 ("net/idpf: support basic Tx data path")
> Fixes: 2904020f8313 ("net/intel: add common function to calculate needed descs")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v2: rework implementation based on changes to the idpf driver
>      since v1 was submitted.
> ---
>   drivers/net/intel/idpf/idpf_common_rxtx.c | 37 ++++++++++++++++++++---
>   1 file changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index a123d969ee..8aa61a2af4 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -994,16 +994,43 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>   		uint16_t first_sw_id = sw_id;
>   
>   		do {
> +			uint16_t slen = tx_pkt->data_len;
> +			rte_iova_t buf_dma_addr = rte_mbuf_data_iova(tx_pkt);
> +
> +			/* Split segment across multiple descriptors if needed
> +			 * for TSO packets where segment exceeds max buf size.
> +			 */
> +			while ((ol_flags & RTE_MBUF_F_TX_TCP_SEG) &&
> +					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
> +				txd = &txr[tx_id];
> +				txn = &sw_ring[txe->next_id];
> +				txe->mbuf = NULL;
> +
> +				txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
> +				txd->qw1.cmd_dtype = cmd_dtype |
> +					IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
> +				txd->qw1.rxr_bufsize = CI_MAX_DATA_PER_TXD;
> +				txd->qw1.compl_tag = sw_id;
> +
> +				buf_dma_addr += CI_MAX_DATA_PER_TXD;
> +				slen -= CI_MAX_DATA_PER_TXD;
> +
> +				tx_id++;
> +				if (tx_id == txq->nb_tx_desc)
> +					tx_id = 0;
> +				sw_id = txe->next_id;
> +				txe = txn;
> +			}
> +
>   			txd = &txr[tx_id];
>   			txn = &sw_ring[txe->next_id];
>   			txe->mbuf = tx_pkt;
>   
>   			/* Setup TX descriptor */
> -			txd->buf_addr =
> -				rte_cpu_to_le_64(rte_mbuf_data_iova(tx_pkt));
> -			cmd_dtype |= IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
> -			txd->qw1.cmd_dtype = cmd_dtype;
> -			txd->qw1.rxr_bufsize = tx_pkt->data_len;
> +			txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
> +			txd->qw1.cmd_dtype = cmd_dtype |
> +				IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
> +			txd->qw1.rxr_bufsize = slen;
>   			txd->qw1.compl_tag = sw_id;
>   			tx_id++;
>   			if (tx_id == txq->nb_tx_desc)

-- 
Regards,
Vladimir

