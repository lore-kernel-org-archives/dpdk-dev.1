Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E29C982D7
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:11:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CF7740BA3;
	Sat, 19 Sep 2026 18:11:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 13DA940B8F
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:11:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834303; x=1821370303;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=YFlPCIZHdqaQYqNV29+eEzpu75ZnPJssnr8NYb/53J4=;
 b=BdBBm9NwaNxThnnslY37+x802EgOrihg/I6JwaMC8mtrdemYM/Ok/5To
 KQ9ndPKriC0GA7lTPyIC+RX8WHOQ7FSuUIL4I01LOGr06EB6x6H7qjat/
 u3ecWgVN8W09ajmO2RixgOlxJUANfcMwNINH/kjDDgLr7msg5z9wgB3ca
 tXZYOmZXmHQtvyQ9gAe5Lv2sjyafsBAV4fe5iVmGuSc/JFzBwSRydnNUK
 FSWR7FNWvMxViPxzHRezdzDN8m4IFmakySvhECUaui9vgFrolHRIb50iM
 iMVDc67rNlZpzVQBuowFPHfJp32/3vn/tRxB6vT3HPPnOXD7ZBzcQ+odC Q==;
X-CSE-ConnectionGUID: GGNEIvpBRM+6ipvcBPyxVQ==
X-CSE-MsgGUID: FtAi1qWbRju6MOmo+zumLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="101023488"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="101023488"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:11:42 -0700
X-CSE-ConnectionGUID: fBi5myUTQMSHROX6MMEtAg==
X-CSE-MsgGUID: FpSTJbQRTG6RDkhk1Xnw6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3047567"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:11:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:11:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:11:42 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoL7MWdWA8yB+aJKtvMjCRAyZgBOlZ6ADJa/o4ZiZK2GPenpImNjrpLqBdiVSWAtjq/f88X2bOwFknIcUSDEaanQUe3WzIiX++aVr5bs7HUZVAZPKtoFacQ+s3Iwr9Bh6AhEnrSqPfy6ahegKnbnLYlFlusVeDHgLrHNA4uvkDDajmrGSeI0mcTIcaI2SAo1R6RS3ZdAxvIaVBImReemRiPQqZm0MzUqQ0u3Fc1grUcpA7CaRSNMJ9w/SWWyyrINHlb9GjkysKTxG2nefKMknk+ICI/vupWV0Z8vhvcXHv2zJVECr1cicFshEImDpfV2SR7xCATxy6KFgbGpSZL6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maosKdFsbFrl9eL2/GFLzEvlgCiWUeloBvu7vTFgy9Y=;
 b=w/jxaUpDJ5FpnOkS+W2nwI7+Ta5zm6xk3xmNmQjiuhkgIQgbvTJq6UTYRjR5Bo7qkmGaVk2ZTxXKD+uO0V6QWOyjsQ41h/whMcEmXOPJWiL9mmJUGSYOq4CpPaXtKSR8cKb/Xa3dAUhBI0MhNBMAKSGgaA9Py7+cD7LDMe6FYA10ceDgkIIhGHHEzmck1MY5BJCgyBMRodfmbcNz3W63nCW88xTFy9Y19VJJ06ok/spmewECJeUMwwtfWiRryEOsuzi3DV7cWQrwAalX4CsyT9vlMV2f/RDl+Gln6WtALrjIVX0HwVJeDI/oqbSNgE9jIVNXJcGJ6zaXKDWsZ27N1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:11:38 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:11:38 +0000
Message-ID: <dee838d3-36e9-48ea-aead-bc478b8bbf56@intel.com>
Date: Sat, 19 Sep 2026 17:11:36 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 11/19] net/ixgbe: reimplement hash parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <cc6363a66e98e41defc05be3a4e63b4fc1e26674.1789560946.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <cc6363a66e98e41defc05be3a4e63b4fc1e26674.1789560946.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::15) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: f87fa653-edbf-4d82-130f-08df1668af86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: RFviPVrC0zQSLvJ4eBvMS0DAfkcUlFMTpmlU59SYl1GvVeF/4nvwVy8raiubsyoMvA1aMZkHSetpBybUjDVwj5OCykGBcqElT3ApeBLwwgeb+GeS6XquV/y4GOxLt4oJ14EnoIVflTtgNQsxdQLH+DYmzbVkchf4kPD+wRVYrEBpvCdBtaMD5SrY4Ucw6VJT0AK71FDfGatfLfKDGX/vdSsH6kibOyHCmKGl392JvV+47588lxdOTZif8zHgNpRGOy2DRqk74Bp9g9pD8T9T00bp4Gd/8O7oKViG3YxWIOpa9R2N8ARyb/oVEOm5BDduxYcpd2ecNUN7kOp3wvB76yjNMWokoKNy9fuWxGBKW9NO4ry7U83KVuptzv0pE3wbp19CSodrr+s15OsAM7gxYRkeu9Swi09MeJ0TkrHc8Mp2xA7aly6tSPxFyLCJ37OzkpVeeeU7hbTu0yOmljl4h3GzJub0XkiaItQ11sVv4eMCjD9NeNPVE05Lo5EVMrBmtzDhOGCJqKqe+bJ2tVm3ZPRQdOiLYoXEiPzZXPnxmZmAZoznXI01ouuxiH61TsI3y5BHkg0vWGJqyelKfxeBahkMIR0daskxidyZXEdwCPQB/UNzm87yHiZdQJdiihy4APjha10kG6p8fz5TT4DdRMKv+0WbLVtlk1qHoOSfXM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1hpU3hpUHpHOVo0SldIT2hrcktMcGtPMXZ5dk1PcDQ4SlJMYS9seUlRRG5l?=
 =?utf-8?B?U0JJRC9vazUvOUhZNjFzdUtOWEQzTTBLQlZwTnRCYndCeFJ0WkRFRXNtVUJi?=
 =?utf-8?B?aTNWR2VNbXc2ZStDZElTc0hCc1ZydS9ZMVMxNVFXc0E4K0hxV05WVUlvby9R?=
 =?utf-8?B?NEttL3Btb3hsVDdua21sVkJlNnZTenpNYmdib2hmcGlsZjlwaVR2U05qUkor?=
 =?utf-8?B?SjhPQVdPWDFEblcvMGhIVWVxMFQrZmNFUDlNbXR2WkxRYmJmRmhjRkM0UTNW?=
 =?utf-8?B?aFVVTGYvVEd6RE9kaXB3aWFRRnhnUVpScTJJQzFkcEZrYWlTZjhteTNGamZG?=
 =?utf-8?B?Mjc0eEJTL3p6a01ZQW9NRHBFWnFZdFIza1YwTWFYeDkrM216TkVyM3IxVEdT?=
 =?utf-8?B?N2c1KzFwRDlkS21nTXM3RGxqUFJGcGhSa0k1Vm0rQ1ptbUxudjJFZG5lY3Z4?=
 =?utf-8?B?a0hyZ3dESDlyMHdaalFWMUVOTUUrbExzOTJVanZyZ05kbHRYUGlWKzAwNmVw?=
 =?utf-8?B?RmhyWEZsTDc3WnJjT0wyVjBpNWkzejcrVkFhaFIwcGt6NTRUWDhkUDk0cmVU?=
 =?utf-8?B?TDhGYnltMDI5Zlk5V0xJMi9kKzRvOWFQYmpXRElDMVMwNGk4dUtUVWtWcmlR?=
 =?utf-8?B?SlRrZTZsa09Ka0pQYTUxUXpZT0U2THROOVNyZE02NmZ4RmljRnYwek4wSmZM?=
 =?utf-8?B?UmJ0aEpvbGJyL3FwQ2ZZMEl1MllkaUR6SENSSEU2V1AvSW8yUWtzd1hFWFM1?=
 =?utf-8?B?Q29UYmdaanljekNBeTJEQ3hDSTIyZkhCTFROZFpZbE13S0ZJS3JUME5zTFRn?=
 =?utf-8?B?VDUxb2poQ3RuekdqY3hscEpzREZtT0VEbGplMXdjc1hIN0ZkakJoa0M1NmNk?=
 =?utf-8?B?UmdjSmhhUjEyUjFXMWp2TkNHN1VRdUtXVHRjb2VNZGhmV2pGcUVkeFlGWGxn?=
 =?utf-8?B?UmV5UkpxSG8xVW45WXRFVTZSNGVVM3owanpjVmJXaENJTm4wSnl1aWdKSDMx?=
 =?utf-8?B?blBoc3FienF6dXJTWXVlTC9RdEtvaFZjRTB5Nzg2N1dsRDRxZHZGSTBYbVdV?=
 =?utf-8?B?MjNXTlIxVFlnTythV0dkY3NkWXgvL25kMkJDSTY0dUpnQ2pmOXpHQkZwYm9a?=
 =?utf-8?B?aVdMYk01TytBd1Jjdmo1MFRldlVuZGN6cmRFalFBa0ZSbTdQNllqN0gzb1o3?=
 =?utf-8?B?bmFZUWlTL004NWdrZVJzY3RpbXNsRXVOa01mM3NPVW9YaCtpTnJWK01wZkdW?=
 =?utf-8?B?QUQzbkNEN2NSejRCSUVWQ1J4SjZDK0RHY05IZCthbGdmWTVaZkpUN2NEdDY1?=
 =?utf-8?B?VEVQNTVWeEVLQ2g0TGI4SndFUEJJdE1Ub0puY3drUDg2OWZpalBqdjAxWVp4?=
 =?utf-8?B?WTJ2M3JRWXVCc2d0U0pFQTJRWFJEQk83Q3VoYU1RUy9Ha0RpSjdCVWJtS1Nz?=
 =?utf-8?B?U0o5eDdacHhQd2c0TTd3UTd2WVg4Wm1tRysrbmFnNkdWRnFmMWxTeldxb0tG?=
 =?utf-8?B?MGEzcEZrWEhINGh6RndpSEZNaEVKWjJkTTE4OVZ3a3p6Ynl0WHlWajlyc0hP?=
 =?utf-8?B?QVhsei92Qmozd3IzR1ZFTVNZN2dJZW50QlZNRVNzYzU3TCtyYWh1TFd4QW1i?=
 =?utf-8?B?ZHRQQTBDZy9nYzRneXJhK3lSZFc1cDFtUjNtenBKbGdOUmM1dEhhditLQno3?=
 =?utf-8?B?TWc3OHZWelpQNVV2SVBoMUc5bXM5WFNYVis3bnZlN3RqMzJ6NUtaVnhROHE4?=
 =?utf-8?B?YXB1cmpGL094eDY2RTJkT2xURExPMWI3QWU5QWR0Y0lrcUxSUUZOK1c3RWQ3?=
 =?utf-8?B?QnJUNFlTMDVvS3Znc2tvZ0RibVJQUCtBSjZsUW1rNElhY2I4T3owQXVLSDIw?=
 =?utf-8?B?VzMwSWFhY0g5anF1WWswdEM4V24wWHlJZi8zcmNqM0xhc1VQTlJBZk5UNEtT?=
 =?utf-8?B?Y25SR3lLbzFLenZRdXUxMkk3aFpDTXUvV2FUSHRwWGJDTjFrNHJPdFN3ZUtm?=
 =?utf-8?B?a0x0UEFaUWc4NWlvQ0U4MHVpMlBqdnE1WTRuSEs5NmJTcmlYcGVxNitDMk9y?=
 =?utf-8?B?VEJ4VE5rKzJqNHRFbVhKK205cEx0V0dyMkhtRjUybndObTd0VU53SnRaZmth?=
 =?utf-8?B?M3dQd0VDUXJ4QXNkRi9PeC9iRVlQc01UYzhZVHlWSVBMblczNG9WNlFmSldX?=
 =?utf-8?B?V0QrWExQTVJYbit5Nzdhd2hXS21wMW02aDJVRVEyWVh2TmI2Y2syaFgxbklT?=
 =?utf-8?B?NkdYZU9nbVIyY0dwZ01LRVRQM0pRUGpQYkRMaTk0aTVGT2w0bWlFaEI4QnQx?=
 =?utf-8?B?bGV2bXhBbGZ0USt6NW8zcjN4OW1SbHRiRDN0SHdzTGZBUWE5ZkRrTmlaeVc4?=
 =?utf-8?Q?/ls9K8B8O7bUk4O8=3D?=
X-Exchange-RoutingPolicyChecked: yBXdUQQge5vd/1a1ILK/m1a/rTri9+HAs2lY5Aw8dwnr25LS8tQMg78XJoRCXEUca9QFMHTiAQBjT9pMVr3mV29OcYq+c0lox4BHKicSXBwZw+mymsaVgmiCThPj3u6xgfGivniJ3HPrMQrVU03hcOxg5M4KK66fX/t81W98OMKGKXew4WvBw9I08diz7vOBcdbrNq6pU39QpDv7TGk543ieLxLpwTF80xdehi6nYfIkXzcavQXbDkBvSR69YPSzOay/ZckCeocYFGLC2wFSWItrSRPA8MMEVZa7kCm2q+IksGdOfGafNhfEP3xaTybzaefRBPuTR3qeo8i7JQgDsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f87fa653-edbf-4d82-130f-08df1668af86
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:11:38.8520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGwSbwiPCVnn6PJzoBd5B1I6PTqciHRFviFTsMU/hkAMcaKvjsNMO2+U7kSkuv86sbgaDkPY5pb0BsQuIN7QTX7CyzwM4w3frhqBxyXi45o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
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


On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for RSS configuration.
>
> RSS flow parser doesn't really parse any "flows", it was completely
> ignoring the flow patterns and was only looking at actions. It will
> therefore not specify a pattern graph and will match NULL pattern, empty
> patterns (START -> END), and ANY patterns (START -> ANY -> END).
>
> RSS was the last engine using "filter list", so that is now removed. The
> RSS engine filter tracking was also moved completely into the new engine,
> and all of the "filter list" infrastructure is removed for good.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>
> +
> +static int
> +ixgbe_flow_hash_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
> +		struct ci_flow *flow,
> +		struct rte_flow_error *error __rte_unused)
> +{
> +	const struct ixgbe_hash_ctx *hash_ctx = (const struct ixgbe_hash_ctx *)ctx;
> +	struct ixgbe_hash_flow *hash_flow = (struct ixgbe_hash_flow *)flow;
> +
> +	hash_flow->rss_conf = hash_ctx->rss_conf;
We cannot just copy this structure, as it contains self-referential 
fields. For example, hash_ctx->rss_conf.conf.key points to 
hash_ctx->rss_conf.key within the same structure. You may use 
ixgbe_rss_conf_init()
> +
> +	return 0;
> +}
> +
<snip>

-- 
Regards,
Vladimir

