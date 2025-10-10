Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34880CCD185
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 16:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0624240285;
	Fri, 10 Oct 2025 18:36:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 997BA4003C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 18:36:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760114192; x=1791650192;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EJz0ZBocmQvdOL10BT33+1aTYNG71g7Xkf4Gf0WSgRs=;
 b=npD4esKzJ4ybwHJNHax47VUAlGGz+HdV/YyWDj0mHGsgqbX0w0Uclp+z
 TIdQGfb8qK/Va2RC4hdWJ/ClAJWolWIvYu/6QKOrZHzJgcFPRuVHcS2iV
 EYJUmHM/MJzBKWBiOvQWSwouctE6WeLN2dNKkoDthYAF4S+DkL/44X1C8
 /Zmot1IwGUxq3sYmnlIW80O3BM4Z652ChHx7Kwfe9VhGxbw6NuWIBjWH3
 iGMe4IoYGnFJS3KFy1iaEhEsSuodKpX/bGN4TBbbvGI/jQW/Ka/SbzbYH
 KkMu8FLL4qtilxps1emV4Kwj7vDf4Zv4IuFlHbWwlCJGNbAnr9Ixm7gY5 g==;
X-CSE-ConnectionGUID: s0lzdK34SayLQMtICxGODg==
X-CSE-MsgGUID: BVIoE38FRnaAjvUgrLh0QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="73680395"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="73680395"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 09:36:30 -0700
X-CSE-ConnectionGUID: LYMza/eKSl278qp+ZuGHng==
X-CSE-MsgGUID: 9G8NpAYvS3yU/rSQgTgrpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="185403747"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 09:36:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 09:36:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 09:36:30 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 09:36:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMwzTtxFaXmlcH+g/BmuGEEZKP2nMENjPwUpP0YMSx7n2vNX02ydteEVFk9aWG7KWIyR+G9lK7KGmoQL+nsN26S46h32N/Sk1r6dWNNW6uk1C5dcuvqua2Fqf8+cdyEvu75N3Ay/EkfB/oNesHo/5EvNsAlNxPyC3OnrhXoytiRQ9s6scqI3gKleHIi749FF1Jc/A8Hb8j3ZoVUJ+VIdEMWEWddhun08D1G6Qbk9vg4wLb8dD3RrcQHEV0TODwCGcxUFzk/wZJIOtpOHz4yXHjykRv76tIaIbrF13OScfK31TnekR6TK+q81Hrn1wXjhb44DavjRe586cu2UO1ZVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5WhxnA6J6EhoO4NiLb8sHoYiasUKEWsIMX8xmRW2Xw=;
 b=Av5nNbRepbb+M7NrHE1dIzTsHyDWesquiht9gnWPl7lYrXtd3Ydki2HtJXqxZ2wGcchfbwWvqqeNc7pJmywyOerFVoGE4vpOSF81+3g7KFQYMnVocvHy/yK+5dmX5TWRFRIWTfVGPiOaOy4wEf1mpxPr3/wFCZSy+GFEcdkal8Udb5IZvTKyZbDEer1IYCB/WtvyP324n2Q+a+fULHGQpaVyWhxE1GIIB6zOf5QoXu4tjbyDWCrOpiaL7sHL6KGx5LyR3sdN0ybXtgJ1wn+Hh70KZtNgGcKaYmmCfXubsJDyEt7GLcp9XnuGRHHKu+4+Fm/ZNyBHyqYUTfORIact4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Fri, 10 Oct 2025 16:36:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 16:36:23 +0000
Date: Fri, 10 Oct 2025 17:36:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 2/2] net/iavf: add restore command to testpmd
Message-ID: <aOk2AsqVlJ1q90EM@bricha3-mobl1.ger.corp.intel.com>
References: <20251003102359.823028-1-ciara.loftus@intel.com>
 <20251009102835.926479-1-ciara.loftus@intel.com>
 <20251009102835.926479-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251009102835.926479-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DB9PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d25b5af-02b9-4139-cf2e-08de081b2616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o1lJwuhOpVhFidnrLADyfNYr133j69CVhVjoRYdUGBOqLJSa9x+AFa9D+1mR?=
 =?us-ascii?Q?Qc1pAZR/Gn5SY+YwBE+DTStIiH5l2i7lZNd0mpxQ0jeEZYfYGD84oQDL982g?=
 =?us-ascii?Q?ZGH6wOfyv9We6H6h6KDg5FUwDqZ+63oz66lfoixBWKX1Ici6junJQRS2ID+R?=
 =?us-ascii?Q?RJXNZ9UBfWs3Co6XFK7Bx6Q/xYKh8Kyc/lHGiCmFdZ7Hlr8VXmpuoihH+InR?=
 =?us-ascii?Q?JRmH04Bck97DZe78Ti6qwlb5BvXAa4kASMZuWw9u+IaldI3p5abhG9DR8O+o?=
 =?us-ascii?Q?gqpmszRvfwmsMOHJnObBvNRvzZNSw3PQ8zif08FG9P89nqONvpkkIkkLkA1G?=
 =?us-ascii?Q?udloW8C5Q9wlX0f2mUj1EE6jV456eH3vqQdO2ukPh8GLskHQh2V6rO5Np9UZ?=
 =?us-ascii?Q?/VeEqzmttqUfx+29PiP3tbMTCu3ZOHxTwwwwPOFQYsfz2YoNhsgIL7izk0Gd?=
 =?us-ascii?Q?71PWtav3b3lpuzU40wX7H1xY+YEsHD2GdbkvQYvIcac5UU/LIbX/LpI9KJpv?=
 =?us-ascii?Q?NL91SBcvDECRj12rgwD9e+BzKP+JOcOG+q39BvFH6q/3Y8/HdHPrmONRCWL/?=
 =?us-ascii?Q?7ZlF5X5FVC+5+LXYxl6P34hzMkLf/wx8QscAf5muAiRkcpUPHuFxhQuJyRcH?=
 =?us-ascii?Q?cIyXcjzFfmLtW6V7cQW5jsl01UPVTzzqaw6JPE8uYJFKMSzk6rgmQP7H9F55?=
 =?us-ascii?Q?9BZSIMDO2qFyanKSybkTwuHCJfefWqhZ2bwJydXz1JF864Yx3nD64WWQX/DH?=
 =?us-ascii?Q?R7m1/IsXbSZmWDUpXrNHnwn93h6TkolbwiqmaUq9RP22vNbyACJxodJFKSyt?=
 =?us-ascii?Q?WSJKfTQIW2upo77ichkfTCtqqcDou9fesKwXRPA0CyK1MM+MvTX+7ARd5JcL?=
 =?us-ascii?Q?tynjw7qw0inwdez5H/d2QG4Jd/3uf47Y3OQ3CdzH5FSE7rfoay8G4PEXhGCd?=
 =?us-ascii?Q?57s0CQKhapYN49sfkkD1SqT2D8Ns9ARdLgKESJQkDJrydL4nvnkg/d5WV/rz?=
 =?us-ascii?Q?L0GLs5TLjntKDCKhdpBIoCeZVy1qgKHghWLHKz/MjDIzl57PqB0lVCHDLM/M?=
 =?us-ascii?Q?JENr/IqdgWZPzC2EDTQ7AAMY+j+VztRs2dtmQk+dM55vePXyowuHoMkx/Exk?=
 =?us-ascii?Q?9ml1NDjdMp+XEod4O1AuoufhoEezQC7zfic5X1O7/fSdU9CHv3kCNMS3wIhM?=
 =?us-ascii?Q?GpWTghpMXAETFHC9WpVq4HumEfkrzYA5Oc7hFnZpq6uGJsiSYOGMtkuXQKsC?=
 =?us-ascii?Q?Ji9OobIr+onKgUOWMY3v0rufDSVlW54g4LaFFqQn3KV7dCsx2orf2Y+9QTE3?=
 =?us-ascii?Q?IQXj8rPCP2tKLYgc5KF/VEPCUgjq4PjQIeKO18aNzjO6qfJm9ZGfkWVZ0kiI?=
 =?us-ascii?Q?5XbTVAHolJgMKtLdKtrbd629bvTLj/5uQgUpHBHBaF2GCrpfxbSitZY39yuJ?=
 =?us-ascii?Q?AqZPzLJKJgcU+6x0ikMguiW71mXAu6RC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PHmKnhtPhQEMJFduOiVREsXQiNf8Q16HzF5ZTE7GPAHnkmuDPh8KHkNXva0F?=
 =?us-ascii?Q?AwansRy6EACzqIyRMmDLIh54FrrX7YoxPqRMkVRl+1qWb4NJavRDgzO9KHt3?=
 =?us-ascii?Q?PeIrQBGTLX53r2pZDRWCWmeDpxa0WwrkEQsOzQBxK5t4Iiypl0bUW5acKB+O?=
 =?us-ascii?Q?8SofKAK6NocX9VESm0TKLD/7ru1/48P40fyOC2C92AxFpUh6oTd10hjD89Nh?=
 =?us-ascii?Q?z31Gqmg1AAX2vswJe+CEvpKq1WtOilI8/OzP1mgHWJbvSGfDxxrB+8NwGyHt?=
 =?us-ascii?Q?H+xMA5oqOR4xA6RwZSJU1iCOLHa+tMVvOQPxRHfS9amcgp8JuXF61nU9ACbf?=
 =?us-ascii?Q?CBnvxWdL51Azy9GNKCsC6pIRP6k94npfp+P/KuxxToGLUedMddCIhYm3uHIc?=
 =?us-ascii?Q?6Ba76dYgfzt4b2n19vu34YjD87DmkGZV9noY/9k5FyqKInx3eUk3CuJwZGrW?=
 =?us-ascii?Q?2cIj6ZPoYNwpzrN3J6mD8hbx53WLn7rJ6G15toojryHY4IlVx1CoFyHlLvh/?=
 =?us-ascii?Q?mR0EAeISwe+p/R4czLQFAwMgEZHsE24qNIhvct7tNMd+mLAXQ/whNK9jhbR7?=
 =?us-ascii?Q?nHG2+VUxx5P+royu8kEH2ZtRm+Zr/DvBs2zHdGpLMz/jAuLr96F+NntGli/J?=
 =?us-ascii?Q?sp7HQtZ+c1PpkIa4CzwUhrBaLFQr3z0G8OFNx4fbMwNWe4noA4Ws8Mpkz9l4?=
 =?us-ascii?Q?UZhX96z+B+BucRkhgUSY8eftXPusoqkfyQYnNTasvgmpRXgNqL3cbfURWl/K?=
 =?us-ascii?Q?WwZUuOf0Itd2XgDyTMaxjhxgGHx/JvoOcqR/spG1T1qDXLp75TXNXlY6WaqV?=
 =?us-ascii?Q?2CkGdQmhzvfWIb3O3GyZjghy9kGda2rhnZLmsxVuMI7phbdNCcEaafbSeG5x?=
 =?us-ascii?Q?+hbaRYowB6yrzwmmqbsR3oNL7mj0PqcjAiXGRynAlTy7fgTYQlpuvLiNjXpn?=
 =?us-ascii?Q?oxUsAuNkLCtqyP4ZcnXtuYa+sqByEpP9R/d/vyhhBxio2zPgPJIO3Gxxv4al?=
 =?us-ascii?Q?LK7zPoyr3U5z4HDUEHTn1WxJkr6bNyTdZmJnZl5Ik1v0viCNDx2PwiFcCjJQ?=
 =?us-ascii?Q?K5ATXCUzqudMmhy/tksyWxE4g2KQcykUs4cvWiY5Uzz9dZ/jQGP88GE3QQCY?=
 =?us-ascii?Q?28hGBS9sWYyA2FQPzFR/rni5aNxA1oOiQvN6vWbs0o7/5R2DC1S7iDibQDNJ?=
 =?us-ascii?Q?07nnwHCHuTUpFKhhl2TJor5GVwZl5A0H4g51GPrEPKTl+ORRrdwHwJLa/vfL?=
 =?us-ascii?Q?D+3eSlW+jsNyPlkM2H8PwBhGV08UdOIS1iXoUw2LO27BVdz5DswbbffSDohz?=
 =?us-ascii?Q?ZeuZKfLxO4VRC7m99ZOyP3BuUM1zRsQ50I6SH/wYWYUXI8xRPy2H2qWfKI96?=
 =?us-ascii?Q?E8ZlBDi7BZcYLGr/NWAkbsxsHdob/BPC7vZzlWLfN4GD6wyafGgvxcHgtiqJ?=
 =?us-ascii?Q?c097Y+u4QJTd4bXpbylypphrzCF3I5kbuCv7vjFda5ZMloFocMh2K+MvCjkZ?=
 =?us-ascii?Q?TAA4MOr5OEnhnKuVUzqW0y5YOJX6u7uta0N11dzyzHeCNATXf57sRDyUMqVL?=
 =?us-ascii?Q?f7uqt0nJ9UTQt73s3bZc9KbSKSJDfaWNEq4nzMPeskVShgZjNTZqHhW006zR?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d25b5af-02b9-4139-cf2e-08de081b2616
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 16:36:23.1995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clWFUECfz1FV+WMPkFtJ14GjKWnW3/0yaJrplCW5x9ERnauNsa5d6FlUcbH1UOG9qehGiksE2J9GGXk8LkQticSX0LqJBT6WSNyjgIg7SUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
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

On Thu, Oct 09, 2025 at 10:28:35AM +0000, Ciara Loftus wrote:
> This patch adds an IAVF testpmd command "port restore <port_id>" which
> will send a request to the PF to reset the given VF, followed by the
> VF then reinitialising and restarting itself.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_testpmd.c | 52 +++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/net/intel/iavf/iavf_testpmd.c b/drivers/net/intel/iavf/iavf_testpmd.c
> index 775179fc01..2432e015b3 100644
> --- a/drivers/net/intel/iavf/iavf_testpmd.c
> +++ b/drivers/net/intel/iavf/iavf_testpmd.c
> @@ -69,6 +69,52 @@ static cmdline_parse_inst_t cmd_enable_tx_lldp = {
>  	},
>  };
>  
> +struct cmd_restore_result {
> +	cmdline_fixed_string_t port;
> +	cmdline_fixed_string_t restore;
> +	portid_t port_id;
> +};
> +
> +static cmdline_parse_token_string_t cmd_restore_port =
> +	TOKEN_STRING_INITIALIZER(struct cmd_restore_result,
> +		port, "port");
> +static cmdline_parse_token_string_t cmd_restore_restore =
> +	TOKEN_STRING_INITIALIZER(struct cmd_restore_result,
> +		restore, "restore");
> +static cmdline_parse_token_num_t cmd_restore_port_id =
> +	TOKEN_NUM_INITIALIZER(struct cmd_restore_result,
> +		port_id, RTE_UINT16);
> +
> +static void
> +cmd_restore_parsed(void *parsed_result,
> +	__rte_unused struct cmdline *cl, __rte_unused void *data)
> +{
> +	struct cmd_restore_result *res = parsed_result;
> +	int ret;
> +
> +	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
> +		return;
> +
> +	ret = rte_pmd_iavf_restore(res->port_id);
> +	if (ret < 0)
> +		fprintf(stderr, "Request to restore VF failed for port %u: %s\n",
> +			res->port_id, rte_strerror(-ret));
> +	else
> +		printf("VF restore requested for port %u\n", res->port_id);
> +}
> +
> +static cmdline_parse_inst_t cmd_restore = {
> +	.f = cmd_restore_parsed,
> +	.data = NULL,
> +	.help_str = "port restore <port_id>",
> +	.tokens = {
> +		(void *)&cmd_restore_port,
> +		(void *)&cmd_restore_restore,
> +		(void *)&cmd_restore_port_id,
> +		NULL,
> +	},
> +};
> +
>  static struct testpmd_driver_commands iavf_cmds = {
>  	.commands = {
>  	{
> @@ -76,7 +122,13 @@ static struct testpmd_driver_commands iavf_cmds = {
>  		"set tx lldp (on|off)\n"
>  		"    Set iavf Tx lldp packet(currently only supported on)\n\n",
>  	},
> +	{
> +		&cmd_restore,
> +		"port restore (port_id)\n"
> +		"    Send a request to the PF to reset the VF, then restore the port\n\n",
> +	},
>  	{ NULL, NULL },
>  	},
Same comment on naming as with previous patch. Otherwise LGTM.

/Bruce
