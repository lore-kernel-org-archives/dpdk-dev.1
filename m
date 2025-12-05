Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7483D2F7C1
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 08:46:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD606402C0;
	Fri,  5 Dec 2025 09:46:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C3E6C40144
 for <dev@dpdk.org>; Fri,  5 Dec 2025 09:46:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764924387; x=1796460387;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7ndRZxUY5ewBjEk7GB/FdEk+YK2BhTlJFKuF/Vz7Jjc=;
 b=jA+F6hmbwMtqMhRNnkgvScMEaTCeZjPymrghj5kvGc0lrWw0A/HtjvR1
 +lOOczjw3atKVpvYjpVoTRV45m8fMyIG8687KIaur7vFFrKRnuTLzd6eV
 dXNlkWBp9Gh/oyLW8lPe81wGd54L/R+XFNz+O9hYFrQztRnUD6imYBdiD
 Od6frWTvIA2RUcjmdsPGnKFd/AHdyhl0cWrVzNzeixG1DSmP7Ukm2+h50
 haz26rbmB9Bst/2S65Kynlv+1fTZp8vCRP8LwT/DuJeEMYN5xV49RlI0z
 HWyOdokOjmLkU2FMd9BAY9acGbFYtLmnPgxbCNxoBzzTLc/eh4pY71Xv9 A==;
X-CSE-ConnectionGUID: x8Wmr9J9S8WLLIxFNHVRgw==
X-CSE-MsgGUID: b97dde6LRmmn1WUU2CR29w==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="69549640"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="69549640"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:46:25 -0800
X-CSE-ConnectionGUID: umm2qqWNT82HKlojRmGv/w==
X-CSE-MsgGUID: 0jCMNcqXTsCzHHxSxd0sng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="196040715"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:46:25 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:46:25 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 00:46:25 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 00:46:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7KEq8eN2phUrJJSgV64O+JgSZ7vLLgGx1E3H1cPR2FIBeQiCnpske9dtGcSTGy7ZQ8yeZalrCOmPtbX6xPafBb3ssOFj4PK1+HdP6KU9LS5uSlXe1pbLla8LHJGhDRrFB1Yckr+G1/U/SdsNCLverHhnAHaLIgXP3buiBtwm+XZav7cCfTc2ZIskCiS4v7n+8F/hsgyKFHGINuDhUfP+4mumB3FdNDjA5hnQtNadLOC4N/qQsJlwpgOkP/cfle/eMCa4HNEIcsrLx68aREbfJwScJGf9v+NsYampwSvyLEJyOpWQNpi5qUR2yNl5xSfQiRjR37MFosjESASUZsS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zEoCI4RqhA+y8prEaibhrx5yxoALU9z2uaEAzZ/Y9M=;
 b=DYqfdIPLW9VE3BvCfOjo1AkS5nG7IT0TlLhJ4ZyIffl2+/D9ioUHEslsRt6vAcWqb3Tc81h1y4IiYjKa+dEi9GlbLK81RMYF+yYwGseZob5W0l5mHz4QwGcR3SV52fmovXmBaaHQcEU8VVSqpk9SLtM/4aHn7G4CdYbpM3XvPADA37OryBz0H021Pe7auDhqW5hE06tl7N+gDZCrh9gbxlScu/LxAEfpUzzHpDSwhw6f2Ofw8tJRf47U5/KJTb18veiLcjyEMUPI+32yeS8HK6wQU1JcwqBOPuIf6FCspOo6vHNmarQtlDXqDvNT86c9MYMzBdHFy0SStlyM655R6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 08:46:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 08:46:18 +0000
Date: Fri, 5 Dec 2025 08:46:13 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC v2 12/14] eal: limit maximum runtime directory and socket
 paths
Message-ID: <aTKb1ae5GDzIoZQm@bricha3-mobl1.ger.corp.intel.com>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205022948.327743-13-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251205022948.327743-13-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0232.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9740ce-214f-43b8-5f50-08de33dac1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7gW6uabYHocrEPCqudMu8SwFMm1TQydWTBh95YUUiN2ns9pYUW30EG75YCSg?=
 =?us-ascii?Q?DXABcAhJMhndE5o3q3y5QaIw9J9s1aBPJTlVp1HsQ7ys6b5rEjMwrnbHKGgz?=
 =?us-ascii?Q?ujbOxKtZYjMPZNxmfg5q8rMi+EFVwaGfh5jAIJQd63xErHKn4QipSkO8ODDv?=
 =?us-ascii?Q?4WlaUDwzbMs9go3P4HkQ8orsbDF+cUxEChAKiSzHL1kBQjikE+dAYAVpYcu3?=
 =?us-ascii?Q?QKRKk0BQ9RvcM8ynfsVbMyU9+VG1OxPS8vZH91FqO08xe1N9LUaKxf4FIGOs?=
 =?us-ascii?Q?i+mdRU9RLJMa9oy+8nb2CXnN/08ahaHcUMuDx4Q5AQKuyjIRuGTjT3oGZ/p5?=
 =?us-ascii?Q?amMHf7egOnnq2/6cuKsxiBM8H2InHQgin2vI17YHUAFKF+7RxqBvSwaD9sBk?=
 =?us-ascii?Q?hFN1XtzPs4lgm6Wz5+a6wAxJJWwvuxRv4a6tJ084crV8LZ6fWuvsfCR4ksjh?=
 =?us-ascii?Q?g5+je/foIHzGTJ22YIi3nQ5bgAIBl3AqY0xFRV2vf0DrwzOBXFXKRhomRY70?=
 =?us-ascii?Q?E5i6AP769QEI2TuEfuMKVYlRI9FpbaP9Fe1Bg+9aXp3G3QqoRk+Xh7nusQhD?=
 =?us-ascii?Q?aC2im1bgY1Ke0cLqkuWBOBQhzCP/Oup3ebtkfR9KyEE0keEMkCdhDoTHrE18?=
 =?us-ascii?Q?cw13ihey59W+ApUKH9qXcQiMRHtX+732MWKnXBpvd1vl4KcLdmutb97c9fVF?=
 =?us-ascii?Q?W3Cxy+d5DUr5C8A0NyjCK2us8vGKT+Nno0jwqbL4A0Jf2wkc0+SmX6aUnv2d?=
 =?us-ascii?Q?uENAHOd6mQfXnKegIL9CvTeem50yiTW+f3jAf1o7ld+IKqIkyt12uoPHIVIe?=
 =?us-ascii?Q?bo7IecosURCMJCYmzgf9g59m7kOFvoI1cTzhDXR7dFJO2rQDetd9uOoLB0qy?=
 =?us-ascii?Q?ew+9K6PgrbLmfGy2a0+IfRoW35FgytTOd2MAH0sEZgJW0OFIzL6+HCyexNhq?=
 =?us-ascii?Q?cA94l+0oCeRHFTi4FD50Jwx8vkK5rxUoMLPsIwB0+Jn/exFATt08D7mlR+k4?=
 =?us-ascii?Q?aKhaSWkR4wiqKd40IxZ42eX0Z4OjG07mQvVmDTh/qwpqN08X67dqRPwqkRxg?=
 =?us-ascii?Q?jWxAOVBJw6BfO/C7bVbPjTvlKTwvkeR+PTS4+NBPgf55OKObjNDEflABAcRR?=
 =?us-ascii?Q?1EEKi5EcimdqIubuxC9cnkWyBC0kgchrxvLFnG6Jx6EP6tRek/Wbz2f5Dndc?=
 =?us-ascii?Q?J0QbQkz8r2d96HyBkKNpBHbQn4oWknAWSGFjGQiwHtzXSPKZU4xcJi+8aH0y?=
 =?us-ascii?Q?Iio7w4l5WEJBIU1gcjhOGqfP5+1U6IX4B9KFTSCxxBBsVZCzQDJdcAsjfHLp?=
 =?us-ascii?Q?/PzRmu6tYgOK12szAtMNkaEOmngdvxMDWyZLkJhKsjfDfatPcmVJ+EKy6pTT?=
 =?us-ascii?Q?bMqB3Ae95QfPerwNGp9Y8FJNbEltORHYNTk93o1vqVWb/HSlqQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AAVBfeEGycBdH+SmRoXqTMT+5B/b0FIjtEut4DqSPsw7kkGt14t9nH4tTIYM?=
 =?us-ascii?Q?d8qzQQlEyIVyaxOiLJJb4Xalz2rJiJ8eTKCuSkvF0AdH6gwoVCQgq2Z/SoYx?=
 =?us-ascii?Q?Cdi5ATTyyrVRf3iLsmBfwY2PnSqqcWsMRifhBGO3VuiYDX4/JYRU7y8yeIwf?=
 =?us-ascii?Q?fae951TmuozeZE9c6dpL8fG8cyqO9kDwcxmKPh8Upo/u5ey7K2SMIfDvT7ql?=
 =?us-ascii?Q?DDRbTB0Gwb32IRqmuGA9jaM/5RZHC8Ljj+mlqnJR7Wp03VxsgIlLFYI86qJl?=
 =?us-ascii?Q?uWeaMeq1+BDXUayz4Cd+nuHStxXZN5XMEG8fysuR2UW2wUvBBadyIBrSm2v1?=
 =?us-ascii?Q?Sz5CX/ZqVM/nbDPqZfLrAQhBfJ0ecOkiHgtYsfY+9UcwVncwNi3EWahJ4LtW?=
 =?us-ascii?Q?XUqXYfI37RhxjgtZJqlFPfItazVJ6UGiyCdnWYYxciecvdn24tZqgTMKVJbT?=
 =?us-ascii?Q?Qdy4MixYqNWxf5FJBpfW1R/zAoTDUpLdfg4XYG8kmqY+bJH7ly/ndeKzF48T?=
 =?us-ascii?Q?qAO7ossxJWR1TQBuPNL84LdfIQbv8HdekTv3C7CJnKPgAYt5/D7/BNQCocDi?=
 =?us-ascii?Q?uUAE3BfvTgaIviSOUYrQl5UE0ThWZwTjBRViqbUs4KnGSN1ya6lBrgm4PxwK?=
 =?us-ascii?Q?4mcfg7+4V0zp5FSB16kBZ08tQ+QPSvmg+tBdffeN5CyFdmfhfT1FjdZIRgGD?=
 =?us-ascii?Q?9ZWvF1A8rGzgJWyEdfxLuXckiWZ1/f1v6hOiU0P/rGbxQwsIrRLf7iwVoAl2?=
 =?us-ascii?Q?hVBp5nLDwBAYl+GQ7l+9fknovnZe2sK8wIOTc8P8DvPg+Sx3MHRy8TI6bn+H?=
 =?us-ascii?Q?IO/wklqSTCWt5QToOnR9NvfjA1gVnsy5jJ8FOnkMCdJ+jOHM+bXNNNPPiGdP?=
 =?us-ascii?Q?zu/JnB1DJn0i8su7/R1mFm66AOY/WUsYLa6QMfzAdLqddQz1kRBi5W33yXhl?=
 =?us-ascii?Q?I4e6mGDfrIAV5VR7PDju6b2cootj3lwbdMioJWUYygIi9I2Li+2pFaCT9TuS?=
 =?us-ascii?Q?klH9G1OzF5MQI7a+23IsaJaeJGmPxf/HV1gSQBqcck+ZUEFpkcbk7n2luNdi?=
 =?us-ascii?Q?s/vEGzh4IQ2QarqvPlYBJxo0wQQ7t3Gc9KEeyQX528ubixoLlJwgJf/zyoZ2?=
 =?us-ascii?Q?j8CWAyHDibxpHu3dgpcQbXRDfwMNXCGanbCPBZThgs0zqVm2RFoUm/qUyffH?=
 =?us-ascii?Q?3fBDgII/Zwe0lmvAB/ilCcHMRfUy7OKHw5aLwy9fkukYvhAtLK8B1kisNxZM?=
 =?us-ascii?Q?yriWWE/jrCOYs7rMWID0/yOYvW8prfk15BXpz5k6m/Fz0FDTed97fVh3tukX?=
 =?us-ascii?Q?cJWpe1cGohcpodkZaS2j6/pWk4vr1FTlQrq/xpw9Iho8ySzFHCICCxVmQ0/D?=
 =?us-ascii?Q?VG0KVGXcmx6OGg+ydv+yLsLpKVsAXuZragMS+NZKFdxJic2GyGAOyWCbb9Qc?=
 =?us-ascii?Q?LULAJgJLiB/gdP60LoWBkCYe+5OIVzo+k41nWg5I20QDZtQgKtvtEy9M5g9j?=
 =?us-ascii?Q?D1lbLZkrPTsah9aX0U3+qDl4G0cb68i3iYCMcxIS5Ay0LdPCg1IhhnClg6Kz?=
 =?us-ascii?Q?EiAPCcaGmEG6imy6YHOGRtcQBm06WsA7IlsC5VVjtpeukxwLCXtgqMWPWsyD?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9740ce-214f-43b8-5f50-08de33dac1b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:46:17.9533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mf8zVa8nQr35cPGUMWDZf8LRvWEzi1hGh6yzkCkSaR501vni4UqReQjbjLQmV4M8z4y1uffBN7fIqqFzjRByk2DgMANmV7DL5g7H80SfN8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8289
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

On Thu, Dec 04, 2025 at 06:28:21PM -0800, Stephen Hemminger wrote:
> Linux (and FreeBSD) has a limitation of 108 characters for
> any unix domain socket path. Therefore DPDK would not work
> if a really large runtime directory was used.
> 

FreeBSD actually limits it to 104 [1]. Should reduce the define by that
extra amount.

/Bruce

[1] https://man.freebsd.org/cgi/man.cgi?query=unix&sektion=4

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/common/eal_common_config.c |  6 ++-
>  lib/eal/common/eal_common_proc.c   | 83 +++++++++++++++++++-----------
>  lib/eal/common/eal_filesystem.h    |  6 ++-
>  3 files changed, 63 insertions(+), 32 deletions(-)
> 
