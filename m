Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6171AC3ABAC
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D4BE402A0;
	Fri,  2 May 2025 17:19:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 27EA64029E
 for <dev@dpdk.org>; Fri,  2 May 2025 17:19:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746199159; x=1777735159;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=HhdvfhblqfTT90dJzXPpygHZLtON1jr1UfRKrwGdjrI=;
 b=NBdSijWFIo6fXtGtCSZe86yboH2vuLvB6v+4tUXxHJYc0KhtxBLCTk1h
 r3Qyrx0VNF0hFKf9Q3zreFidyYyZVrfzaKqVS2y1i1Boh20uizR1x9S3h
 9ftUkTxAOln4+/qPa9LPucVtp4tQpKThvNnEgN2lYzuhRw7fN2E6Oa05y
 O9XNi62DVxjHuku3/dg1/hv9JRzeLNEhXxdi3vbz5pb/xA2bKyDrySFvg
 JIj8RHCDRsOdS5S7AIbNQR3gSI4tmnTaSE/BpbbyOAR2OUXTvRnsJS56+
 8zsXR+dLE+tMXFamzX5bo+qlVEx64ZzJbio2joislk5sMpuXxWgM3Vz6m w==;
X-CSE-ConnectionGUID: jaS7gLsGSSqN6TrKMDbHjQ==
X-CSE-MsgGUID: e+zDVnEaRVORtK/pkV1jUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47793677"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="47793677"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:19:17 -0700
X-CSE-ConnectionGUID: QJfVAxRyQvSRZgZbK9S6XQ==
X-CSE-MsgGUID: zEu0MspwR0C3tNVq51Qo0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="135180903"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:19:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 08:19:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 08:19:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 08:19:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gF/IQvFOqpGr7BLmxmgn+2lT6H7ve7AhlmrPJsIiwQGbSVT97DsokwGFlJAYgcMDNQQ8d9DjyeoTevkHjPlQC4EnjlPP6grWqHb+/DOv5bMcs0H69V13Pw0+lERjC/QibAq8QUZ4RSezTXRgNgDA+eIospmyLCuBXEOYsCmUhAXKFXPWsNh7w9w6rGF1+miNQvWXIPY5SAN0LAP/i757lsbDAmVL0sJlU2Db4LuAAV1g4EfUc4M2o0Z9aHHwLB0aQW0gq6+7XYg7CzU7AfbUCQJ+39hBf/0Dh5F09p571RuOoKOk28jTvHXIpgzhEM/Ca3ixcnCJJIr4zSGVKtQhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kjOrjcIw3nSLUykn69Or485UbpmQg7L8JMmH3GQjTE=;
 b=T3lZ4P4zql6YwL/pVnhG5XFTlYQI/9tIWd5XCdhZZtHNv6xENjqjqSBQ74pQV9Z29puV4M7oQF4Rmd3wN872vS6YiaHOFD00+RUXxCBhLH2sCSxC1SitBXAiXj4Pc+/ucwRq4u8iu1VWkIiOBGlF0Y0I6OccPH3JoFDskbeQlbD5/Mj7zfn1n3QdDYLzuhwrpCbHkiW/6e8Ny517XOiZggQEa2E4EdYG1hKgOU9Q0xD0bjm1DJ7qv9k5inf6FaxsL/veZAW8rTPwwwIrhE09s+p7j+Qxob/Mztvqe16B4N4GBMJQCcS0m++YhLvZ8lpo2ZC1OzrvpvFGpS2J95PZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 15:18:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 15:18:31 +0000
Date: Fri, 2 May 2025 16:18:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Subject: Re: [PATCH v2] doc: provide examples of using lcores EAL parameter
Message-ID: <aBTiQe7C6RTeczIs@bricha3-mobl1.ger.corp.intel.com>
References: <20250407132451.1101691-1-bruce.richardson@intel.com>
 <20250407154901.2206824-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407154901.2206824-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0257.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 02290e28-b749-406e-a3f7-08dd898c98cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LSXNH9nTKb0pYJvTxn4LAu4JmX2u/S71pbqC4PBzy65BdAlq96Sp1f1ptp?=
 =?iso-8859-1?Q?QSmaBKIyHPKjxxeehqY1dB9GJUkp6+DiOjl+KEK8JqLYl4Dk151d6KRAA1?=
 =?iso-8859-1?Q?HGzsjZiGdYFDPM/LVHMkRTtywyRgB48XGwe0RlUHc49vGmWBPsZZ36oW/I?=
 =?iso-8859-1?Q?b2eqYZT5eXCs3ijfDkqoVPEvr/zagYT+d/tNCzmMLmMFSYY6UN9f16hZKl?=
 =?iso-8859-1?Q?m0+87RcggCFuze/AsQL8S5EIcKdzOkay6jXUc2C5ax1L5PbRZAP0xkm4t1?=
 =?iso-8859-1?Q?WWpxEwED83Lxx+FCe1F3BQz95zNnuFtBU0qaUkLOWXlUtcdDhuhvNseQ6U?=
 =?iso-8859-1?Q?0iN4TeRPstCCiErhWn6iaI0nTKCxz2AXTS9J3AKc6+h/aZw9r1qe5PCuI8?=
 =?iso-8859-1?Q?/mgL+MSZlpy9Nw5wUg0zC71nBi7ATB6rg8mZRAKNrtxexmZcEt6ebjg0qw?=
 =?iso-8859-1?Q?9SBiESwI0dCPdrg/jxPGsnWk/QFn+aKxi9F36sZrsBUpEk+InuPxZIifQW?=
 =?iso-8859-1?Q?qA3VjGtwimHjKA8JHSKP+QOfz2w0P5R+6dLMqiJaSzXrk34PP13rGuIMlI?=
 =?iso-8859-1?Q?0P7DaQRzbKJFv+SDlKKGQ54A2uuQJmfg3ep1+8VVUKviYc4n9Cs+Amm6Tt?=
 =?iso-8859-1?Q?tvK0AEDxA0JhyP9R7g4ms83ciIrtoku3pacSWFK/YG6fZHgcY4bCJIwT8F?=
 =?iso-8859-1?Q?hU/dLJJCP965nJeV/fSFqQXrRZCvo5GBWASlIsUzmI7OZ6gltHr6tPhR5s?=
 =?iso-8859-1?Q?C02B+KhbDmIZn1UYejsIku/E/kI/eSv6ggTqhQP27Grzk13r685cQUp7MK?=
 =?iso-8859-1?Q?t9FpTjLFdbr5Zvpyj7ZEt22Y/MkATVG4SlnlA+Dpq0g/1EmKM/gW5Rfp8h?=
 =?iso-8859-1?Q?LuDOiSobLauJEYT+1cfbdaoiHdV9K/kEIyZ0PJ32pVAkLfynWvqlCCooqD?=
 =?iso-8859-1?Q?ydblVnWCGmnX6s5l+ZJHMWtVn203xcVg8uXCteO4xeinBz+YrT5mcUqg87?=
 =?iso-8859-1?Q?1emeVT9f6tPoafUVSvMitsj4uesDCMEf+vt35A028D59asaFDKYl6pq3aS?=
 =?iso-8859-1?Q?CBH5IVB0uixEODipop96iLZ/Ele02lf+FN88SZV4EZUQU2byLn2ZLpj+d1?=
 =?iso-8859-1?Q?SGa6ddOHvchoXZt0P2swuJ1xRJvq72jZFttshhaF/g3oD6KyDSrKBYj/us?=
 =?iso-8859-1?Q?FiF4uqUy11e8opigyHutX59n4obIyCV/+pe2masdLdsNdO9kIguTey8uIH?=
 =?iso-8859-1?Q?tqCnpdVybMS/ZGAxtGZwEoKFwhTfGZu+XRrO3lvzn9018SW98roNOvr88l?=
 =?iso-8859-1?Q?Vnsp7xDqyVJ+sZlrWLMAHlMLRXDuywKwxa24FvSVUCydoeLNOhb0yBsUzQ?=
 =?iso-8859-1?Q?UYPYOKDsq4JMixHq9HRnd2ik0bdWu9uXMFZpskJjddR48lonfmKM0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?O97uYBGHp5k54vhy9Gv7r5+0hukbMo4yy69HPCQr4kkPppaY2Ie5hTiC8N?=
 =?iso-8859-1?Q?6qw2l4tn1o73dyceSVWwnrJSJWOhAD+NRfE+ajgbUAFMdfz7O1FwQbz03N?=
 =?iso-8859-1?Q?W1YIct+NqQcxLHbv6qRsUZZiOMhsiy3XaAMCBdbmg5JahgppwGzrYJG0Yn?=
 =?iso-8859-1?Q?fbQfQHSzjWjtLQN+Dn355hB6cV45JzPs57Z1AhqUcIFGwCR6nsDH/Roc7R?=
 =?iso-8859-1?Q?ObwmsInio8hvql1GJVYjlk+xyl5KYAIM5rIsl13vDsSOEQLQLnAnulnum3?=
 =?iso-8859-1?Q?9IOsBqGDVAEQP67d7wE8HN9Dbc0yA92abAPAEJTW7Bak/pLgMsDD82hZap?=
 =?iso-8859-1?Q?PVD2rx01fq+D6kD7w0+5t5GWlOMLc/0XWICwcZwExI8YB7pCelCel+c0FF?=
 =?iso-8859-1?Q?v3qV8/3GU84dfBgfhNc7KD4RxOG8bV/O/N3Q/UPUWok99CKPAKP7BPHe5K?=
 =?iso-8859-1?Q?l5BHViAYN+JIdguYQxLaDVIAht+2M9PHqmV6U0Qf97pS8etgoEqdgZ9YJ/?=
 =?iso-8859-1?Q?bEpXaPlA523Etfc10PTn0sy09qnFbRucyrkBxHg2PXis7sPCL5MM8fZtun?=
 =?iso-8859-1?Q?NlOYLyXD8HU/BXxggD6nkZmILDgZrCgRAPpYxbBUY3ntxHvM4tGaryxXHS?=
 =?iso-8859-1?Q?ODD1uKEqlhYHImLyHXMlpmjwJjklo9fjidKheiwcmQ9so63GQJBAmBloVW?=
 =?iso-8859-1?Q?vwGSjAlrE6ozSs73s+cutFqR/pxDDR7FNRowitTVayA2ciH/60dYFpcV3E?=
 =?iso-8859-1?Q?31qhZVLh8OZDwKBOv3JUo401U4/GnvYdGiDYzHFMPb18qQa1IzGgMihx9W?=
 =?iso-8859-1?Q?XKLmFzbJYadOKBYzfvMOTg2hyfcTNgi5snTq4sluyYeVT945e4g8QoHeq1?=
 =?iso-8859-1?Q?WszUHDZnsReB9c2hcZjkJAGzHy+vU/+LClBXpha44Gp0g8VZqjJCUDUuBy?=
 =?iso-8859-1?Q?yTmoGScuaBvDH2gHz9J0nSJqlv/sBrxIUt+Ovww6zF93Dh5uHagTqdVvlI?=
 =?iso-8859-1?Q?fnhN8A2jl7qU96H4vOpx1jDurkqf6DravoXlNZJ9Rx7TuXfmi0rat6Ru+e?=
 =?iso-8859-1?Q?iO3tI7x9pXwtn+D1AdECmxpHQ1jyfA+AqaTATnP+vE7RgA0FZnnTgZy/TK?=
 =?iso-8859-1?Q?B4LrsxGtJdr9UViwXnVDkpVqGkA6ber7a5xmFXYG8UHc94apg03L9+HIQF?=
 =?iso-8859-1?Q?9jplm4c0fxsLdqblx4r4K1tmGUO/3+1xFCAJIQg9Js7WKAeYhNcJ/a4kUZ?=
 =?iso-8859-1?Q?oOHCS9TZNKKIhR4a6/EKfBjEd1wh/qZtchoaPiHOdubOb6Z76Coj0zFNMU?=
 =?iso-8859-1?Q?DLrGKs7WNDdEcDxhzBI0yQEs/xm/yZwk6+RhWDpTdMOzIYjoLsXafO0GeB?=
 =?iso-8859-1?Q?n028rGf9kk3uIFGHZU62ibTXd/v4NAkgsSyzQ83EkO4WN+pjT4vmxvDyZi?=
 =?iso-8859-1?Q?zaOlcMIPg/PVLOhYDXRwBSMa1MLPghQZLegYtO+Mn9LMhI6ND0jaN4SlGN?=
 =?iso-8859-1?Q?iqAs7QkEGyGvwkS5EQwGHpxfFl/Z2WxtcMJOizJTAbbHxV+uRfhFvVNaKq?=
 =?iso-8859-1?Q?7tTOaTPaeLeJioNZZWJjJN/z7wlmTj+kjm5I2epFCioTO3xJVkSCe/ip8P?=
 =?iso-8859-1?Q?lO/FbcEjc4DJWwvj6ZUvarbaHTCkD264/2rzpzKLqvIA4S7oONEBb6Ng?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02290e28-b749-406e-a3f7-08dd898c98cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 15:18:31.0729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aONp51MRVRsOvV3cxY0eVowwaWn3mShjoEvdK9VS4mC6GdZ4Jr3dKlsGjPczWnZriC3ePYz9QSWPWfCMal1pjNOG/GHX+LBaxuxGszVUUH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
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

On Mon, Apr 07, 2025 at 04:49:01PM +0100, Bruce Richardson wrote:
> The "--lcores" EAL parameter has a very powerful syntax that can be used
> to provide precise control over lcore mappings. The docs however, only
> provided a minimal description of what it can do. Augment the docs by
> providing some examples of use of the option, and what the resulting
> core mappings would be.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  doc/guides/linux_gsg/eal_args.include.rst | 27 +++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

This patch has now been rolled into the wider set of changes for CPU
coremask flags[1].

/Bruce

[1] https://patches.dpdk.org/project/dpdk/list/?series=35137&state=*

