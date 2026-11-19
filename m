Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E0606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=khCJNtBU;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=WjjiDiGQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3FE340151;
	Thu, 19 Nov 2026 16:17:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id 13928400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 16:17:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795101450; x=1826637450;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LlIoQe3648gmMFoSrdE4EidZ7HIt/41XL3XH+XMYmEk=;
 b=khCJNtBUnRvF/PUSBPZDeyFvWFxYTByBWUHLSo3MsjewkbtQUaEFHFnP
 o5dwcwQl0dAiczBHI5oBeC6MzsbzkruNNsHD0EgFzcNfj9O6LMgAnTQf1
 yDcjk5prl2SXupbMQV1qFMEZWQ6Gjx6qSQo37E7maqwZGAwjFAZo5t+3A
 sjlx6mvUyjzex5H2b3MuUEjofU+gHC5klufTmFA8CLug9pnliVAf9/Mq1
 igbyHazf68YejtzZa8qe43iGPQ08x09PsK2SEn/usQcrl7wluxhyT4kWS
 l1vxBR134FYCb8EyvgRsVATg0MCYoQaPCHcrKbB+utbotCSg3RhMj+uHu w==;
X-CSE-ConnectionGUID: K5fFsD4ARySSAWfIYaFVAQ==
X-CSE-MsgGUID: qmycJuXmRO2Yy82i4aPypw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3981245"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3981245"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 07:17:26 -0800
X-CSE-ConnectionGUID: v23GA7GfQLySEBxxcVDcag==
X-CSE-MsgGUID: fsHyVJMYTQCBClI0ziVIFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="12403979"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 07:17:24 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 07:17:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 07:17:23 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.27)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 07:17:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVn/rz7MnucWVCocAp6r0WvYEJXAkEhOp1j4rhiF+JUhBzVo7YWH8RN1tzSpRydL1rOw8lH5XNG6TXregJtxmdKTL9YlMotzc68YTiehu14JSU8CHKLz7ICf7XlSJZ7YGtqWsiqAeqOXFTaS2xsK2wNTvLDanX1YEImF+eCjzbYKrTb+Z5za17CjrF1eR+WjnyN1/emW9IpWK4iiU2x7HSeQol7HyjpApv/VG+I2X5bI3WIyghNfp+pjf/Qg+iMOH5c6KUZ/puOojvf4UkUL4iOQLWTgtOE3SKjVO6sucZbkWmFW2xtcS4YnzLCX6nGn1qroOMXVfCqr9KGPm+cjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TadqBEZNf0eF1BVjlMdwKPfGeS1yfx1MFpadMHzCF0=;
 b=TWEED4RZHJVVziE+7Fym2mDXYwcsJAjfuDAWZtYeo2ZHpo/DElbrfRKZKFYufs4skbaD53lwLDMhNVuCq/OwoUI+1f/V7vdBxRCEVO5rEXgXMbGpkNvET9H6GxMdQX+jmwhsX8drjdm+YvtEMBzVZi3uOeGA1JcyC68bPnKObB9FOLP4e+otFUh1OLep/JyuRTeaMulJ92IPRrdkX3iDhahfOL+B1cpVHfwpSoUbb2WWvTyQVq/2GeNOAPt+9cc3DteJTVq7KCvxSfKzyi6ve3vEtPe/oNcyipYo7Kd7kFQz4bZ0mauQgC5xY0quY0lgOHB2hwnD5y4BhJjz2e1ZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TadqBEZNf0eF1BVjlMdwKPfGeS1yfx1MFpadMHzCF0=;
 b=WjjiDiGQUjzxqKXm1Dvuy0PbZF4WWD1i5RZfClqVRMth1yIMjwTCpOvXKevI65ijOWhquS0h+HXpiix7SA/3eEujeS8ar1lRZOfXVHvjuqSKXgKMuinUFNwt8YeO4lIb7AuqCD3ygxRZLIGPnuoGqmqg2xjgqhNve6XF1bqIAP8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:17:20 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 15:17:20 +0000
Date: Thu, 19 Nov 2026 15:17:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc: announce timesync support for cpfl and iavf
Message-ID: <av8S-8DJ9xeyHY45@bricha3-mobl1.ger.corp.intel.com>
References: <20261117110430.842264-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117110430.842264-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DU7P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: bff3ee13-03c2-4dca-db09-08df46503448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|261022113327099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KokQTxp7LOGNl70FoE54l8QJKixKTI43aqsEDmZU3mWnfBH6pg5pRJtr764goIXDqVXNpJ4VoZBY2ZcokvItt+G06oYTGv3XnN+pzkdJnD62KwZe9TAJghDGnzBPaUOBNAZlk8H0umHrsu0yOvC2duNBc55XmYuUE1wJzxNk1XtLZzzuoqpSoBtBmBTQA6M1DrLNwfphBScZeX7LoJbOglUen7VEwAQSZEn74AmnZfY/8rVzMYX+XJMHY3QNSThQ14VwCrsJdI3bIed6nRdIQ3joa5cJQOkNvQvsrB4q6UO0g0vHlXoKzqMh2F56t6mBnxIESUXK3u2uBph2duE0aboeW9s0orNZZ8ic0Ux2QMGFGTCYSjnO3nCNDWkRzbQFUw+uqdPXUl7Bw5tQB1KNjahvszr3uGNXK4F2kVakipeKHXtk8fNWtwuoG7vrDQpihLQN7BIzWdodqZK5NHt7d1AIZY1eGy6uvDiV8TS2THsZOIE+6afLaRpAaU0X+qvJfikj3h5ts26oheg6yjHOgf9G46lmAwX41NbFiNaO+lZvUjOs6YRL2C9QEV5MFLR7YMUSUUw1Kfo4UNI7S3tihw5D9pLlYUdICpmxUoGupnAiSy/Q8X3hDGq+ubpWTGpge0tGWxnxx4mWMrhN3eaOZELuSDrgGDmYDLJIn4Pvk+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(261022113327099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KR/5LGACaUciMDP3KVXSXGyXIo5gXkkcHuodDhlVzuH/JefAN/E44KFjX3E3?=
 =?us-ascii?Q?liz61ceFgSvtf9xxPEU2Qkp0ZCUheRnHd0Tt4g7rRV8whxcUbBEunvro6MXt?=
 =?us-ascii?Q?waWfgYfV+QvFWo7Sx4fDtSK1EYcbB4yHygNPctEH2AX2b5LKmwJJ5jnXg0xF?=
 =?us-ascii?Q?AeN631M/+M2hglZOb4/4x7D/rQD/xn/DIxQFvyZ9EWCc2CnbmwMnlLLWhBNQ?=
 =?us-ascii?Q?Q5iwCLR/1VKPLfskxWi4JP5D9uca5VAGXZy/8AefKMzRp3/bNaVbKBOJslIr?=
 =?us-ascii?Q?cF8z0IZVBerG1OB8V7HumyPauzLutAlZqz8noS4SlDY4/4oD6wQHkpkqwZH/?=
 =?us-ascii?Q?R1AkzK8vDEFZ8WRbF8rPe8wegLUfPaiWKs30kYG7X/rJh8+UFMyQiVMXjuZR?=
 =?us-ascii?Q?2n4wtzoeXqEjkEuGOwNYXlF9pNpD5Wy/oxJnN2Q7/oYtUBPWsyyxL+KQTM21?=
 =?us-ascii?Q?DNU7wQuDSgp1VHYSqAwtYlXeOx412PhBn3kWqg4V62nNX4pnuHuB82A3s7j3?=
 =?us-ascii?Q?aDyIoG6mWTaLnHH3C8z7aFmBN3gUBsZQnUftui4I4ah/WYAvRYueo7EMEsop?=
 =?us-ascii?Q?vli7kyUP4fTzMIBPbDgt4+JLJwb8bhsnL/6Oz7hIyn5aCII2Gw40i69xTRrO?=
 =?us-ascii?Q?LbrtGZIlX5OycRdUIcEyiYOphN8TuXesj/A9FNO9haSN/AXwUP8y9HRmyc/o?=
 =?us-ascii?Q?X3lgg+XokZuTj7UxN+Fj3XR7J8iN9OgAoPyKv8xw24ClvewQqozlLjlcdeAi?=
 =?us-ascii?Q?qLCuHlsC4Ub/rfh+oS5TeSxg3iZkM3EkTnMhb75FW2Grqc/troEd6amF2wk5?=
 =?us-ascii?Q?T0kDzzZPLXM21sI2UCkKhc1sTZ2P95tzx1/f+yjepCZrmDuK7j+RnzPMrWun?=
 =?us-ascii?Q?ZkkzE6Pci3BStBfTQqwVoRNfCPcuNf5d4d7cog8PM7H3moUi7e5/GZfanAPh?=
 =?us-ascii?Q?iXb8j1ITwu4B7spTCi16ZxGQzJXNupSQJtBbAXCFpt5XEJvGG5e9k2SAz8BN?=
 =?us-ascii?Q?EAm0SIjzM6C51jLvHqHH4iHZwDFPtPVTr/W+7CwLuLiu3Dzh0rJA5501befy?=
 =?us-ascii?Q?VLvFH/8qalnIyjiZ59Yk8ouQmDTMUdJEMdchrnT6OjjbYNNqG0Ts8xicY7kb?=
 =?us-ascii?Q?NvncMZgahSFYhcADoI3y72q4+CQ8xr2I3x/Lw/XTk3iBYE/h4ASHgYGbw7z2?=
 =?us-ascii?Q?BK+OWDmsdQ5sMkuBh+bSmmSqbmyEoynnEFhTI4GKSLGFhmIW9ZqGjkvm1vnN?=
 =?us-ascii?Q?/DrGmhyGVqH+z6dlmarMAd9iDD8rf204tp4I/ksutQSsnRf0yADDAMWUPh/2?=
 =?us-ascii?Q?PJ7/VGL6yeTAsTOBosXX3zw6wE+rsG+tH2AeDrE1wmzM30QG87NwnJt55xBn?=
 =?us-ascii?Q?7EWfafm/eMMkltUnyErrhALos028Up++Y8r0VNT5+VgtMtbwnbIMXM2QfgPA?=
 =?us-ascii?Q?HdWhLOuYHoNEhT5JXEs3C46DjHeaIn3JiIPMSFwsmLrX3YZbSL/pFQTG06vj?=
 =?us-ascii?Q?IIcdRjSgATofm42Ffcgql8s2c6Z+U+SAZzAuZm4YLNqzMyLu1/YQblRadC+0?=
 =?us-ascii?Q?53tvEhcjQNcgPUFq8lJ+lqk4QA7xQsayALvv+W83AS0vSrN/o8/UHtrbC8v6?=
 =?us-ascii?Q?gq/pYQH1cyYPzR5ygHmDlXsF/5826Dh3xewfJpjwJdap0WMeLKWtN3w5xknp?=
 =?us-ascii?Q?x1z3LbzJsbY8LqekYg2/bFtf8uw13XMTP4BYB687Cx65U8tX8q1uhvmmruty?=
 =?us-ascii?Q?ppz2OHGb3L0hPjbhpGOT2X6SlCpYu8o=3D?=
X-Exchange-RoutingPolicyChecked: uldYdln5L3zwXsJhoP797oB9LkbzYiWVBS/SzIiQfRyo7EhfpthXY3pypb7wbBn71Rj9zyoE7yazj2CfYyPOeGs6Ext4vZddPJfQpACpiFc/R9wlxPOizOA6tefE7dUTrBmLT0USjN+s1gxSL4SbbB0M2kW+Ulo63pc6GAKhXlDUKHR+4KekwV3K+Vg6VcK3v2FaqfV1UgTwZzxUvFSuA/FpQJ/W0waP/4QH9/L9hcNjQk2b/7yG35VuU1dwOdkRKNZz4Q9IZ2A4/yBCPmwIeV2RpbnpgNoEjf0QFW7MFD+MfxHrKPbFGdd0weDhUfoN9IwRYlDAolVwGAbEJO0vGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: bff3ee13-03c2-4dca-db09-08df46503448
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:17:19.9777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYfFGTB4ZdN2Uz9B7RIEn0S06mLVnOS/X3epayzMy3zC1JwVF7r9ctNOmUdK34KzZUqvK+dq7oSuufUm8kiK2uFkTX3FtmylJaB1LX9waaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 11:04:30AM +0000, Anurag Mandal wrote:
> The cpfl timesync support and the iavf PTP hardware clock
> read support were added without updating the documentation.
> 
> Add both to the release notes, and mark timesync as
> partially supported in the cpfl and iavf feature matrices,
> as cpfl implements only the enable, disable and read time
> operations, and iavf implements only the read time operation.
> 
> Fixes: 48ded83e8a5c ("net/cpfl: support timesync")
> Fixes: f0ac118828ea ("net/iavf: support reading PTP HW clock time")
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel with some small word-wrapping changes.

/Bruce

