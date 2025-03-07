Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67F1C19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 09:01:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 921454029E;
	Fri,  7 Mar 2025 10:01:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E77C240275
 for <dev@dpdk.org>; Fri,  7 Mar 2025 10:01:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741338114; x=1772874114;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ndksBsSn4fg8ShugeujfIYT7RSqKBpYnU9c2MUg7iuw=;
 b=SmYv9dGigEMkzz6tcsNAj+QyYG5o9etj8vYCJDONIKob6hu64bTVuWqx
 RW9wAq9G07lK04C+uCD5E65EtTPORe4ORlwGP3VQUC6O+hJ8agNd1rGk6
 hwgZCN2sR9fDBINMDkdUr8ZS4Gft5mxjfSzu+A2FJZPSCwMZ5CjvTRvSi
 2Zt5n4ygK4IJuizmV6eRhnb6GNtLJgRg5UmUEtnwj6cBKi73xPk/30+z+
 ThgHCCVxHkG8tJ4GMYkLgi70xHeZXHJWKBw+kCvSGHzWM4+tBkH3tUqCV
 ubhrhzcBv2j4P4X+x/76UtB16NJJcda8muzEd0EdgqeSX6wzDXZGYKySL A==;
X-CSE-ConnectionGUID: jQXyRycGSGWnZW191iz6Ew==
X-CSE-MsgGUID: /7qQJXdJSfmMsiA5djnJ/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41547749"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; d="scan'208";a="41547749"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2025 01:01:52 -0800
X-CSE-ConnectionGUID: oCdnWq1qQPyGV4AYijq1iA==
X-CSE-MsgGUID: A5DrtSYUT4COhoTp2M4Tlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; d="scan'208";a="119273944"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2025 01:01:53 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 01:01:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 01:01:52 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 01:01:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdHbq06wts5mtd+ZDnr7vSyH9kcn+UFFbCO3XVPrJXlvEQHWgvVCkbc0btIbfTAPpAosJwAv4lLc6q7syFXPcnHYvfJ4lgkHvQDS/opXY+GBPK0YCHLPFofUpXb9MdpSRTvSQ5e+O/7lm4mJ1WQggIHBxO58DDb/iV37pnmoFgg6OBGSomOt+QwGTmI5NwzsuBjAMuJsrNYe1rBN3RzzWxMWjWGbki0fqGkPki1qQYYpZiynydeGQJs52UvYra0eCzQ0OGCqrVq/3a4REFicOTQYRIx807LZuuQcE3gpvPCXEmFFmGgifH644GOLoRdt0VvVe9qRKTYH9soo6dlwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJOaqho6cHoI4ee+73VgubMHgslOxHayRHMolVBOGtg=;
 b=egEq6WmmSIAJ7+Gn13BP2Xu2W0fkNFSx7cySADCbaBlvDtS1ZfkZpZs+RVnEQRp6T0sychbWc6DU6vaJshq2YblWkowOAja9FnLzuLbvnsW6WHIQhH2DkRAEeD5/uAk3P2M9OIMeafeA6Xb3Hwyl75/TmcnbKgYQUut9pDlB1AIfzaXQATLtPCtRWr+CZblTWBrvYMSJ7gW+cv5ykfwP09jx3Nj8+6OkPcCtFeWMeRDEaWuYpeVIpfXBZDyu6Iq+7ZMvrbqQAan62mw+a322k7B+CqoyC5C61RjVtBnknzL7G01UKDFoUmrQSqjvx4+vAFLe5zbzjBon9F+IyyetkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM4PR11MB7398.namprd11.prod.outlook.com (2603:10b6:8:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.23; Fri, 7 Mar
 2025 09:01:48 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 09:01:48 +0000
Date: Fri, 7 Mar 2025 09:01:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 <dev@dpdk.org>
Subject: Re: [PATCH] hash_readwrite_autotest: fix printf parameters
Message-ID: <Z8q16Ikzl4_flbpK@bricha3-mobl1.ger.corp.intel.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DUZPR01CA0176.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM4PR11MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: df463a24-810b-448d-763d-08dd5d56a8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Uljukq8by035bmZCBCwkOjnC7+kc+Ag68feR3szPLRymNDBDtTJueI/WJmw?=
 =?us-ascii?Q?iieQXNokORhOs9rlGFhoq46zXPb8pfvvGZ1GqTIDI2X4fHz4zVq5sNhM87Yw?=
 =?us-ascii?Q?cU6lZymIu7PGe5FPa1eButB67D9rZxGU5jVgPRyQAHvCSBgVnbdMzyIU0RJI?=
 =?us-ascii?Q?cjgIeE9G7Fuk/BMQRqFg+LcLEmapc+OhTqtqa6/MIy/n4Ds4Cc0/FHAUFDnj?=
 =?us-ascii?Q?vn4QhQOMLSFqL3s5z01zAdFSPGrqe+lfEwWDbY9TcBPWrmQn+VsBRJl3tXcd?=
 =?us-ascii?Q?2lsAforb2S+2oO6eSFPUxNNs157J6PMsKSvWBMs3dwlE0pwPy+viEw5yrmov?=
 =?us-ascii?Q?1UTDIQyRFjHH567qctr5X9+SOtv1llPfLP2JBOyiGwK2xPBXTbR6WCOYzveM?=
 =?us-ascii?Q?26R7KPISWw/puXXqWUWQtqv3B2PF6NUugytaZiT1Un23mEUXc6IX+803afwi?=
 =?us-ascii?Q?UwyohuoS7zyJ1NmrTIOJJ7qWI2GKgm15t1xksNTuTGIGtTwXvTzo62qLQgBx?=
 =?us-ascii?Q?GwGSlkxBTLReEkXXtsLtKE4qbvQbpuC9SPD1MDfK7rmBe0Dpd35YIyhYJHbf?=
 =?us-ascii?Q?diqiAeF4+qYqbiw5Jj9nG6geVO1jHC2m2jxnMmjYQ2HNRyYMBq/di9iahADr?=
 =?us-ascii?Q?Wc321oK/+0OWuxyCXBngs4C6MI5Ixxj0s71OLCjYottCixNm5WTZ4Q9/rH+c?=
 =?us-ascii?Q?+4kk6AX34vdNzDsNrU/M6jIg8x11J2PXyK93t9Eapv9ThoedWz0MfC1EvncD?=
 =?us-ascii?Q?vq4AD86uUnhy/fhpxwReeCqT+Gt8MM4K2UiUdahin58GV818Em6oKMLArkRZ?=
 =?us-ascii?Q?T5xgV3xdU/1FoJMBdJRcppd3aIRRz3JsM02rlILADGw5VADvQo62S6zElP9a?=
 =?us-ascii?Q?IehN5KZ54P7/FQSi0iJu7FzdZknrsWTRDETKSoX9fV+ghyxCN+hObgsP9ib6?=
 =?us-ascii?Q?EXnC0K5G9m4/iBMR5ZwU9SydbktomK4Hrwe14JEZAiSQrKCkyEG3q7/oTrR8?=
 =?us-ascii?Q?HvKq5+y1rHkoxZsGLF8Yr3go57FIbk3V0yc5GLUMMfNFk6FvtyHe8ziOUEdF?=
 =?us-ascii?Q?kPKimjQC65qi0RuKPMO/5Y5x+n5ScFgIVZNqy1c+/aJfqxptfZWqay1xa/sl?=
 =?us-ascii?Q?8uWP7cPmYm16hTfmcpX27IFR1cL3sR6suQsuoysQw6S2PmFvwaDfXBqlu06F?=
 =?us-ascii?Q?dMcgy9Wvyg4YN6msfQbCQ2PdeTR6nmlXn01HtHB9f6XZ+NEP3RbLJ0AJG7VZ?=
 =?us-ascii?Q?f957sp+PsrVt5pfhBif7eFKc3+R8D6bQ65N5t4aqh6bsqme7GiZ2W7ev5fB7?=
 =?us-ascii?Q?9Rc2oi38g6RxFKGDyDwdQTL1F5PRj6k/2LNOH/FzChEiaEPvw0T5TL0XyfUv?=
 =?us-ascii?Q?/9eankjyG+xxU1ZpKHES7rIuGUD9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qnx1eDg3ZzYxnazXWneHsZEDy3i5nF2WcMhMEH6E5PDhdOzEVYuglyHu5QDD?=
 =?us-ascii?Q?S1fvwKf/XOLUkpTalrbzTfRnYYQdFNVUHnQfs4yOWU3DgRDQDD8bW36GKkr+?=
 =?us-ascii?Q?RMko+zteFULJBgQIyAuu8yS8DNe61M7CzkXIhSfAymt+WHLEJio/l9O/vjDR?=
 =?us-ascii?Q?w5T8co2mIgvjms738+fo1RbE43g9gZVJy34JXF0yS5pVQ0FFSExEAcmUPbwX?=
 =?us-ascii?Q?XqjUAeKAZN17iNCU9T1kpvhSo4PPjIUa7t27GFQnM/mKd6oahVER0olTHKCp?=
 =?us-ascii?Q?GZxYKdYDoDo/Lc7JFwAMhgEmtq583wzj9o7UGBpT7TxhLb/CM2H2C6NzocCH?=
 =?us-ascii?Q?d/tb4ohMkQtAwjIz9cFdvskuaeceiipZePFbDb4bo05aMSi7J96O5MaQdTpO?=
 =?us-ascii?Q?fyoaP9k6rMQPewD+XmawFNEHbXqrdxn2nAz74NZ3hEl42knSQctKIaRNsJEX?=
 =?us-ascii?Q?y+brJcQ+RlEMnjUrDm7S02r+S3zcd2co7VnKSl7Cd8Vf+NK+IVJB+CrDkjyz?=
 =?us-ascii?Q?/tudZgiHYakMDxCdrMnsagnFkkSzpGr0cwE2MEtis6XrXH584POSIaJNbQHH?=
 =?us-ascii?Q?h2sPdoSN4kIOQspIuBd8EOQRfz5YNXzGKRD0LgI9FXz5tMZpvcdByT9C3Bkv?=
 =?us-ascii?Q?HMhrRlT43W8Mibu6AbN225VkGQkikX+Hk50EtVD/RAb61FASwb6luC9YzVWX?=
 =?us-ascii?Q?BhnvdZzjdAZghcJOyzLFpD8BPyYaU+ZtbGOYI4BHiCtNt/q2js1d5XmaPfD2?=
 =?us-ascii?Q?GBafN2tDrzyvBZ8OxRTcY15LipXLIncjzA+CWq/J1maestcnZBN8TtN+WRP1?=
 =?us-ascii?Q?NqrAvdIY+gPY6+b8useyl1EPaexvDdkEUOhBWVFbttsGGdp8lM5JOQymgeth?=
 =?us-ascii?Q?0J79+ToJxZ2BdbZHpyiN8vPy26M7WSz1K+6Dlp3M6Yj1Z4232Mfn5KmV/pat?=
 =?us-ascii?Q?t6yQaOBZPl2/Cf1Oz0cnZHexuGFSckkGZOO7O6EdsYohchIY5cTewV3T++u4?=
 =?us-ascii?Q?mv6I/5M76pP7h2OJYwZpbFA/abrB3eXKSBVWSw1UfKAVLRKxsDml9HUtzrDr?=
 =?us-ascii?Q?8CgrSMBmRWFxpPOqrKoK7fsSMQMwSMUtX9nQE61R5VLL1vWYXYSWgyuObf+K?=
 =?us-ascii?Q?w8/7g4zoAurBbkrZp8uk06OPaEi8PH1j9CwBlODeKaP6EjGikNOjuEubyquC?=
 =?us-ascii?Q?02w2BotQwIgDUoiSDfh2qehMJQabKnOB0/nldAwMFvDd+AcvzewkQa8TjblB?=
 =?us-ascii?Q?FqY0kYXWQiellwHs9KVMyUWClbkbLHSFSAzFui0Br3cxN3uN/55vHjOodH5o?=
 =?us-ascii?Q?8u7lEzDipHU0iaObmcZl3sj8Wc6Z53/gl+3ZtzUYHKFl3J+puMW8tg847XZJ?=
 =?us-ascii?Q?fMYOQm8i4a9TtM4bZ0c1sRFgmpp/qq1b9y4uzfSErpVNl6bPvURr9NnpnEy6?=
 =?us-ascii?Q?PdCIvXSuyN45it/LyDz/5jEbIaxeOFzV+mdpx3Zms/n3dxDjCuEOK6xvJ/9n?=
 =?us-ascii?Q?WoEKMrP0KQc9g/VLwoyuU0374xSsHNahdj4mtUfJnYIWCX1vJAfwFCnRkWfl?=
 =?us-ascii?Q?ZL7baOOTzuqGWpLKP0QddUghqqMgF6DazP5SGLngrm0fI4JKbBi+mmRddSxV?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df463a24-810b-448d-763d-08dd5d56a8ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:01:48.3844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUEPQx+iB6mXch3WIPzdzA6qt9WUiOw9kPe03qD5msBSebdQl3BG3UEBzX4vPYoRCQJR5xMZXMN8a9FKXyrOnj/2nMAi9kyBHa6kyDz0OHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
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

On Thu, Mar 06, 2025 at 12:03:28PM -0800, Andre Muezerie wrote:
> Compiling with MSVC logs the warnings below, which result in
> build error:
> 
> ../app/test/test_hash_readwrite.c(73): warning C4476: 'printf' :
>     unknown type field character ''' in format specifier
> ../app/test/test_hash_readwrite.c(75): warning C4474: 'printf' :
>     too many arguments passed for format string
> ../app/test/test_hash_readwrite.c(75): note: placeholders and
>     their parameters expect 2 variadic arguments, but 4 were provided
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  app/test/test_hash_readwrite.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
IF the "'" character is not supported, is there some other method to do
thousands grouping in MSVC?

/Bruce
