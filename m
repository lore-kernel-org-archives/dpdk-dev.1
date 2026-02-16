Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DFAE63F15
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:23:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8769B40664;
	Mon, 16 Feb 2026 18:23:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4910C402D1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:23:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771262591; x=1802798591;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=e9obQuxLbIRb8rgdNi3mg/HIXdb6i7WnLz+ZP3XgvOQ=;
 b=ZFB/32ijpTxUZ+XJF1NyxYtGSO/mLWxr1Ao2PBG1nRGwcUvCIL/4YCvG
 SF160TaiNEurqm0q0TUqyBXYLYmhta6Ipvq1+w9g93Z116OiwyBkGziMe
 GtXdPiseFBPz+1Di8xTunoq7HTdLOkI210BF7GIh5J7g+CbjmlngbwrGU
 eHfLAppRjS2y0LS0qXCRl/cr86XxZk6Bi5jpNhoDFa1UN/7l56kCKMcIu
 ofU/VWwzEAaCCgffWlVegHbFTKDuuzUTtWPpv+9Q5QbznX84RD50T82fC
 VWz1S3M0II0lUoUYJhEZJU34vhYMC/Xr+gYPLikC7x3TMnbzudXUee6Dd w==;
X-CSE-ConnectionGUID: NShjyRH1Q8eZ58dgeWv9GQ==
X-CSE-MsgGUID: AImFQU2KRG25T0ful0A8Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="94976440"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="94976440"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:23:10 -0800
X-CSE-ConnectionGUID: qyszQFLqT4OSgU/dtRHR9g==
X-CSE-MsgGUID: yihufQ/CQz2qbOlxfi6XFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212968070"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:23:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:23:08 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:23:08 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:23:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0hibP+nw81qOd4tWKt7qzyE0Rx0tQgemFtADcr3s1riJVbGaUWQi6dUdxl/oRIo5gQ6Cl4BDl0fY7gpO4J6rEeBt6oG1ZMBlcMVa5S1heNyRJAY4iVfk1p/AUgCUOskJLtXr7Qcgjc6qJAAHOVrlWfEFsKkhx+Dz/Fgcxr3G3YS9MMdgQ6UJHvEZQ1dDgdrEvBNvGqwEQsjsUnCpkUmbDY7wU7bmSiTXBcf2AL6e8Ig4qGx0q+gmv8mi2Oo7TzPm0f/lzcz2WK/ZT/82n+UgQroUMK7k9VzXCfnxVzRCCBUhhM4wYQyn3tNpPdWy89ZgKZ0lXtGvqIkn617Itee9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmWASnjK4ldSTiCziadqxjYRR4F4SHqV2JXfBvYkOsY=;
 b=QGMXzkmfXJo5EzMzcBzdjQwCMJB1LO7kB1mubTgqi9EUExE/tk63ZGGMGxrUFHbp87ADPucojYGKzD06gc203wpEk1so7EkpzjS0Je8zoL/m3yH+7JvqbYulfXru/7gPfWr7eY6p/eOdCz49BtEk1hGLN+UJsCJBu7IWOtW5y4HsTp7bXBzyBFPGRxXuaT7IXCQytzZ4k1Ayuod7PBXSbr8JI3Goo/3g2xS3sGU45gmErJ5sCDpKk4K6ZjutcZfqAlkvwUCfRgu+B//9Q6UnHUU0Zc/T3schQxAl2WGzGtLJW5MyCT/wVTRxWtZ1YRbkYwWJ7wZNmToh9lUtBYNJ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:23:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:23:06 +0000
Date: Mon, 16 Feb 2026 17:23:01 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 18/27] net/iavf: decouple hash uninit from parser uninit
Message-ID: <aZNSdQEtmn-6yDHo@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <3b7b2c7a8f5e1e83650e5e64262b15273735dbf4.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3b7b2c7a8f5e1e83650e5e64262b15273735dbf4.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9ee114-8bc9-40e9-ad9a-08de6d800c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FRl0J+krv63BAOxR+K4RdpHjNnqpPOIfKtze2/uibThMBLwmUxrpUVFpwjWX?=
 =?us-ascii?Q?1IVJBGiZrHijEArbc90nIzTTiLup8TODAsvHJi1ClJCrg1j8y1cUOkV40255?=
 =?us-ascii?Q?0PjD9phQVIJvpoP36zlBUeyAZANw/JpnZZ1KkVJaAGF/Lu5vV856998qSieb?=
 =?us-ascii?Q?1TOC1ACI8A7uMWhB9svIgt6k0VPACPKY88Mx3II3kVg15EuywfnDJ0xgIGAR?=
 =?us-ascii?Q?MwZJEXpxmygYgBoOtDVQlAFzoYPBdOBxddBbHtnQuhQ4X17VHCLFov/rtusD?=
 =?us-ascii?Q?okSJ6get7uMxMMpRR9K/oozfbkFdHHeS7/fxeXJM9Y8m7gWHiyI4b6/56zJK?=
 =?us-ascii?Q?pBcQ0sHxilPjAQRN/4kIg63VJeEMul5+UNO2ThbM7S6QeGmOxnDYi3U5WEF9?=
 =?us-ascii?Q?0m8BqHcLBZxWH2Bpxv0YIu265Oof040zkUSiNWMDBa49XWbwFxpthHFLZtSE?=
 =?us-ascii?Q?pvfE8TFj7AZJ2tFVkrsmhJNxXhMq4wb51ScSv7OSVn8udsb7guG2vOJBtN7/?=
 =?us-ascii?Q?JZn3kZr63ffWW9Yk3x5ne92lUzFVDomA7kx0mgHOuIVlYbhTxkVBS1qETyRv?=
 =?us-ascii?Q?reLhOS2WLxGJjlFmOOVpyXr0zDc2YXa5x54AbV8+zOiheGPDplVEc+Rghz9X?=
 =?us-ascii?Q?1PjIM+5YM2H8/CQynD92GT44yKrIgPsgVzU7+mH4iiwp93wZhvoAX3sCNeJ7?=
 =?us-ascii?Q?0s27xg/vWgyjlRt89zYNGeTguXxBsy7qNOQ+SQg32FiheqQo40fY1AK70DqH?=
 =?us-ascii?Q?hbCRDPI5MroUbLnAXuNvHJ9OGWts5RZIRuWsM4nqaQ9jd+p6Hn5F/2mRZli4?=
 =?us-ascii?Q?nutPGV01DPu1+Abvm9zfpF4xz1HseS9T49BAGzCLnAhwOstjaYgYZUKrIEac?=
 =?us-ascii?Q?VXTxhnjoPHkpzHYGxV81sJfYBUgPW5mB17jmibjPLPDl0NT6jFLyoD+PN6R1?=
 =?us-ascii?Q?PEr2JfGozyI2zead0VBV2zBgs/fkbHCSu+p3CgJXPUoLJ5W6nX0NK4cs6pNt?=
 =?us-ascii?Q?Ay60GEkTe3qnfj/57mk5Vkn1WqcX3sL2oqFsMdc+VJfnGUiA4VXvvnvzQgkW?=
 =?us-ascii?Q?zyJwZoNk7cp9SxbEPDFywUDnoh4oj/dROk8nIOvVv4LrNfU+9jzhrCVGpDrf?=
 =?us-ascii?Q?YsjfYy0hX2/bR3g+o9+COFFHXk8zxvg3tRtNxfAEL7iOa1peUd8Ju9Kzpjw5?=
 =?us-ascii?Q?bl+stZiLB+3+SftCskvuOsfL65PwcqcDfdTJpfXyyKH6qUZOz7hZ5rCF8Me6?=
 =?us-ascii?Q?KGo0CHGVN7o0CiMd9wmxCsi0Demm5PxPpFbE2pIWRoKy9FCD22VD3muybkrr?=
 =?us-ascii?Q?N/ghqfZkJZOnqDjpImcXH4446Nre7IsNAPhyFqJQ5VUxVU+Oib7MQgKyr5bk?=
 =?us-ascii?Q?zTbhJdiffmvSnOdX2tPHhdueAT0Drn1TeZkDg2JT4bBB5pWhKmOt3X+yTZJw?=
 =?us-ascii?Q?AWrzTU5yKCdwZh9BZ0qEQfVLjoAebdhv7f6tue6khAF6gK6n9f5C1s4HPQiN?=
 =?us-ascii?Q?EgB18tgMgzaB28zoq5vQH3+7gH7hdE7twSLlJz7/PWzG3peR4eer3JW8bwF1?=
 =?us-ascii?Q?OX0pXcSApIAxS0tqEL0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?43Gh7fmmQ+bt4Unc3pz9/W6jKYwH5nXtLZJ/GuAoiDhyJdxoYB/T3iswLwMn?=
 =?us-ascii?Q?PAeQ6mBdenFdjAqlKvE+pPqDguokIaDl4jzzpwkf6LicN8oX+lIRLf8kRXLO?=
 =?us-ascii?Q?UaSA0IERYlaQ8sipOFGSPkB5mFy2YfM5ceEFmfoC7+nxSUZLQjar6Z8dQnGg?=
 =?us-ascii?Q?ZyfzRaNpABVrE4FLuCk3lGDFXCk2Bhm3Gm5J+WcW/zIERJj0lMDvDuhd+Fw6?=
 =?us-ascii?Q?JoHOiNrThtdOr8g3fLd4+0WBLXW0P+K7LWNqcnYa7SYXoWXkQiKVuwYO1pqk?=
 =?us-ascii?Q?fYW5hchLaynBHsn9hJS0u2pSwogZr3UhXY+8fmphtIVDUSc6WKNCN+l7okxP?=
 =?us-ascii?Q?Fv1ISJtMtkWV9FGTs+fzYMxvPSLN9SlhjEXUj21Zp+4lNbfEbzUgd9jCZs4w?=
 =?us-ascii?Q?OXkREgyNdNB1KfjKFJSDEjgweEaq8VWwZ5V+jdkxlf4ApNzSdtfckBQ0xp04?=
 =?us-ascii?Q?ukRJ06wJR/Eq4uMZ58hmkOsEyo9qXlKK9ML7rTlAdtAUgZKcbi12XzLjPMTs?=
 =?us-ascii?Q?eUFH7xv8RFZpiEUk6Ds4OYV61vw7aa+t1xVhFTgFqViQDAwouFf0l9c7GKTm?=
 =?us-ascii?Q?6HgOPj34hAWL4xvlyAqMmBCscV7BdTLZHIrPWPy28iPMTrDFT9yeguyPQl+h?=
 =?us-ascii?Q?KGoZcmKuSZS9k4yHiOW7cETizLGX2M4+e9TsfG+T3iUqUzHXQAnNGa9pbmfe?=
 =?us-ascii?Q?+I3ysOSHnbkEdWvzRR+edaDNF5SuH++m4esvRkT/8zscsdCY6nIHgoeQunhd?=
 =?us-ascii?Q?Tphxp9YxWnfpYSllUrk2Zc6cFbt/JfI7L8cmCcrSRWnY1hkG370zde9qRtLo?=
 =?us-ascii?Q?DxPvtUtNTQjNnGzp9Qc18+SE/Gz+fSwq3+5ikA/pYuaV5fPSuF5yWjAda8pb?=
 =?us-ascii?Q?ek/LxLt+7GGKQ51vLWzWIMiGHGE6w3TTAQgYclw+61AL27AUE5F+krGS3Il5?=
 =?us-ascii?Q?CXD6HVHRMNqEFYpLzyh/+Fs1Inex9Sis9hepDwGjqdkVzBNBac6gZHGk3IcY?=
 =?us-ascii?Q?7xMzim8XkfjIyAyod7HhIbgz/QXjrRiIjxYOTPokEEDB4OwAl73U46MPtT+p?=
 =?us-ascii?Q?7m77BlbqnELhTGKTfUvNJPkpX8bqN9J3BAQ+fsrauVZIiHe9Mwrju7PLSt5N?=
 =?us-ascii?Q?nO2tf2rZ5miR4wVArieJDBUSJZGbpkoWzTAN2U5Fr09UREeEoAhiNXJQRmM2?=
 =?us-ascii?Q?QrZ0YE5PacjN7m4FRF0zxNTbZc4V8xELNV0ScSdGlLCeJVlp2YcKxpZgi90g?=
 =?us-ascii?Q?QWLmNW6nB/xJkM6x64Nj/7tVVIYTEiZX5P22XUc+cjbUdTRqJxeRl/jEkuQG?=
 =?us-ascii?Q?BHMrO0Qp9Yz6+VsJIOAb29OpCObA7D/2BCrYTkydM/hkkU6vadaN71EAJjdp?=
 =?us-ascii?Q?FvJZQ16MKFeiNuV3Bq7Kz3DQyusio/AsEEGc8O/zQtfrayTxz6wHCbcmhnAq?=
 =?us-ascii?Q?/AKJeAfOJXL05TfqSp/4j78oyU0cRfB5oFwykEYMn6fiGLMsz2DpT5t9NvMy?=
 =?us-ascii?Q?R43BgbAEBYcZyYLpjfjNwm/w3VgBHuFbDKqYL5TG1c7I+7T3pUe+aRz4x21e?=
 =?us-ascii?Q?nIAIZndWHbV5YHZ0FgLI98ApIIO964wICtUjGsSHKaEp5U9mhAwepE0XuY7+?=
 =?us-ascii?Q?r3gg0pB2wX9MYaESyN8pkgJxlo+2tSO9YvN5oo9g2ieiVZnZcQOSaIACJvIM?=
 =?us-ascii?Q?oxJuN2hAOi4Q1ydR1oE+iWfU60QhNPnr9wKkB56j/D3sXoD0I/98SA6F+zD6?=
 =?us-ascii?Q?GH92EosJZqRUboRdWk37GgjU6tD28sY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9ee114-8bc9-40e9-ad9a-08de6d800c44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:23:06.4510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KyH5DlPek5UycEj45fcKEPVhNE/zlbAcEx4E9hmByO14q7DerAfwNaHQv3pp4SooLVhDxNeShpH7TnVCCZA71Kcwa8NAIgpgIHlfPwfXMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
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

On Fri, Feb 13, 2026 at 10:26:29AM +0000, Anatoly Burakov wrote:
> Currently, parser deinitialization will trigger removal of current RSS
> configuration. This should not be done as part of parser deinitialization,
> but should rather be a separate step in dev close flow.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c |  4 ++++
>  drivers/net/intel/iavf/iavf_hash.c   | 13 +++++++++----
>  drivers/net/intel/iavf/iavf_hash.h   | 13 +++++++++++++
>  3 files changed, 26 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/net/intel/iavf/iavf_hash.h
> 
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 802e095174..70eb7e7ec5 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -35,6 +35,7 @@
>  #include "iavf_generic_flow.h"
>  #include "rte_pmd_iavf.h"
>  #include "iavf_ipsec_crypto.h"
> +#include "iavf_hash.h"
>  
>  /* devargs */
>  #define IAVF_PROTO_XTR_ARG         "proto_xtr"
> @@ -2972,6 +2973,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
>  	/* free iAVF security device context all related resources */
>  	iavf_security_ctx_destroy(adapter);
>  
> +	/* remove RSS configuration */
> +	iavf_hash_uninit(adapter);
> +
>  	iavf_flow_flush(dev, NULL);
>  	iavf_flow_uninit(adapter);
>  
> diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
> index a40fed7542..d864998402 100644
> --- a/drivers/net/intel/iavf/iavf_hash.c
> +++ b/drivers/net/intel/iavf/iavf_hash.c
> @@ -22,6 +22,7 @@
>  #include "iavf_log.h"
>  #include "iavf.h"
>  #include "iavf_generic_flow.h"
> +#include "iavf_hash.h"
>  
>  #define IAVF_PHINT_NONE				0
>  #define IAVF_PHINT_GTPU				BIT_ULL(0)
> @@ -77,7 +78,7 @@ static int
>  iavf_hash_destroy(struct iavf_adapter *ad, struct rte_flow *flow,
>  		  struct rte_flow_error *error);
>  static void
> -iavf_hash_uninit(struct iavf_adapter *ad);
> +iavf_hash_uninit_parser(struct iavf_adapter *ad);
>  static void
>  iavf_hash_free(struct rte_flow *flow);
>  static int
> @@ -680,7 +681,7 @@ static struct iavf_flow_engine iavf_hash_engine = {
>  	.init = iavf_hash_init,
>  	.create = iavf_hash_create,
>  	.destroy = iavf_hash_destroy,
> -	.uninit = iavf_hash_uninit,
> +	.uninit = iavf_hash_uninit_parser,
>  	.free = iavf_hash_free,
>  	.type = IAVF_FLOW_ENGINE_HASH,
>  };
> @@ -1641,6 +1642,12 @@ iavf_hash_destroy(__rte_unused struct iavf_adapter *ad,
>  }
>  
>  static void
> +iavf_hash_uninit_parser(struct iavf_adapter *ad)
> +{
> +	iavf_unregister_parser(&iavf_hash_parser, ad);
> +}
> +
> +void
>  iavf_hash_uninit(struct iavf_adapter *ad)
>  {
>  	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
> @@ -1658,8 +1665,6 @@ iavf_hash_uninit(struct iavf_adapter *ad)
>  	rss_conf = &ad->dev_data->dev_conf.rx_adv_conf.rss_conf;
>  	if (iavf_rss_hash_set(ad, rss_conf->rss_hf, false))
>  		PMD_DRV_LOG(ERR, "fail to delete default RSS");
> -
> -	iavf_unregister_parser(&iavf_hash_parser, ad);
>  }
>  
>  static void
> diff --git a/drivers/net/intel/iavf/iavf_hash.h b/drivers/net/intel/iavf/iavf_hash.h
> new file mode 100644
> index 0000000000..2348f32673
> --- /dev/null
> +++ b/drivers/net/intel/iavf/iavf_hash.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Intel Corporation
> + */
> +
> +#ifndef _IAVF_HASH_H_
> +#define _IAVF_HASH_H_
> +
> +#include "iavf.h"
> +
> +void
> +iavf_hash_uninit(struct iavf_adapter *ad);
> +
> +#endif /* _IAVF_HASH_H_ */
> -- 

While its primarily a matter of taste, do we really need to create a new
header for this? For a single function prototype can it not just go in
iavf.h directly itself?

Either way:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

