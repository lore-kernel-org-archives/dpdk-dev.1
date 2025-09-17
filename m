Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC4CCAC599
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 14:35:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BF06402C3;
	Wed, 17 Sep 2025 16:35:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 74C3840285
 for <dev@dpdk.org>; Wed, 17 Sep 2025 16:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758119713; x=1789655713;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=94P5hd+MLkRIG1GjSaZFZdt1vfnGsBn0jrjQn7zKiGk=;
 b=LH5fl44cVdJ25bY6gLz2Bxsr/jXX9gWhFSozpt+rrRmHMnMDTBT+ulHj
 JJUHiB02oS+GDMiA/ZSwLScZdqdmeA6W6JrR/dTSAq6zJEv887gs748we
 Rj7T0+UAIjaovbD2753N+rnUonvTl+Or23TvcG1ECVHJvQoxNubRdYyi3
 yyyVDI60l4imAs1XO78BmIsIkatL1yZEvLqB2BrqNu8VnYg1YzbJ6QTC/
 qC1CNdD7F3bg+X7f6hgeSsNaeiPliYvahe7fGrLP8GNHifqDUwptxuHpP
 KPItlfUHpKdOTTpLgcZ7EPIm3Jhwxds+rtqv4QLl2wPGz6xdtnNl7k9aw Q==;
X-CSE-ConnectionGUID: lsBJvsjnT/e3hq+Ke8ltRg==
X-CSE-MsgGUID: FkdA1JbqTHeFv0NbBGgs1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="85869656"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; d="scan'208";a="85869656"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 07:35:11 -0700
X-CSE-ConnectionGUID: KRZJZqHnT1qJfAEYyMqX6Q==
X-CSE-MsgGUID: yAL1lKq5S1y1s8pHRCq7Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; d="scan'208";a="180398274"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 07:35:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 07:35:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 07:35:10 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 07:35:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Losw3kBFsgQG60LXcvD7so3tyHcbbRbhLtzVm0FLtAyVIqrtCO91urEEclXdn9oSzyBeQi5kRo7mm/cN4ZPW5gbac2QKyc5E1d6Tt0Ps/jkygMCjaUnzZWCwEQ8EGwekH/C2UZ+LW30IaIi0KADC5cIe9JUrnaC1QiC62efdtjNziPPVLFZZToZRSpTEeGQSMc9AYXgIgp4Tr9kF9kUXshSMXjq5+wD94nojuIqHWq468+nzY2Of23JgdhV2aEty49tJFE4a0QVyqScTJ6NrMjhfmyaIgem7vnVrrBzrlttzuGzuU0DwYBoKXJgxDBPcpeKraiC3p16h6RBJ8w+H+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl0vWSIXU21HRtndkjBHLu7dA+xMU0s1LEr1hr1VWgA=;
 b=DCkPvJJeWQp9ZVUixFpqim1KuDwmDZQdrI+o8p8u+EESLB+UVibXG7maTlIcP/RU+UQWV+HbdnxLFT6zGF8oZ6ohU92REXHlCRpbOE8ZQziCXGBmB0imxNP4uTownIJM4pox0F4RI3I8XBx+A9o5jAz3Ydr/uXnOMYFxabz6qXXYaN7Xu4KaPjolIEqjG0QulZTYqaN+fDU4/Ysia1dAoKNllVXGzX0GdIslQ3y3kWJ5Jh96lICsQy1OgBqy23jHOD4nBqI6O7/CndMRtpuYZKueXV2evbYmJPm181AdKs861nA9aQVzQH6bV3fw0gwAt7xRs3TiqzG3GXNYFW9Ipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MN0PR11MB6012.namprd11.prod.outlook.com (2603:10b6:208:373::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Wed, 17 Sep 2025 14:35:05 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 14:35:05 +0000
Message-ID: <a7594d91-1ff9-4f09-8302-1f76bb3b929d@intel.com>
Date: Wed, 17 Sep 2025 16:34:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 7/9] vfio: stop including Linux kernel header in public
 and driver API
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <maxime.coquelin@redhat.com>, Rosen Xu
 <rosen.xu@altera.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, "Sachin
 Saxena" <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, "Tomasz
 Duszynski" <tduszynski@marvell.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>,
 Chaoyong He <chaoyong.he@corigine.com>, Vijay Kumar Srivastava
 <vsrivast@xilinx.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>, "Harman
 Kalra" <hkalra@marvell.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
 <20250903151800.1965006-8-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250903151800.1965006-8-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MN0PR11MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: c2035647-694d-4a02-bf8f-08ddf5f76479
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1BWS25qdmFMRjdIbjMxL25BdlZ0SEZNNHRWeFJHKzZ4eHY0Sy9jQjVJL0Nh?=
 =?utf-8?B?Um1SVDBFVERFaW95bVk5a3BVWmROU2RnUGk4c1lTczFKYUlXOU5EYUpKYUZn?=
 =?utf-8?B?a1hxUnRTeCtaVVQ3Vkk5eG5JcFJ6WnZpd1VlZ2JqMENjSUxhZWpobUVXTkxz?=
 =?utf-8?B?ZEVaUWRid1dTcllDM29iL2djQWZvbk1KRlBFeGlYVGVEMXRMdTNlNGVwZGdn?=
 =?utf-8?B?aGFwYnBubnRIYi9wdW0wTjJjOU5yTjd5V09FdGpId1hwcDRXMDlWL3FRVkJy?=
 =?utf-8?B?aDJVeVJKdUdOZVRHaEhvOENqRXJQK0RXMHZHVFRkSStyZXRIa2hGNFozTWZE?=
 =?utf-8?B?NmV1QVp4Tlc3RTBPS1BOaU1idnhDTVdZWjc1SFJnUG9BM0xqRHlXWk8vZEd6?=
 =?utf-8?B?NStlTlp5SG45UklIeVBJRVpFL2VBQncwVWpJV2x3MXZCR1pNSHNhR1BQSVF0?=
 =?utf-8?B?ZGJnWlZxdE9VbHJKUXhzYnRHSFBPMUxHRDNaRnNsQU1ZeGlQSW1UNkJkK2s1?=
 =?utf-8?B?cUtueDFZYjRteTREc2tVZzVlQVZUbGpWb21NZlBrVzFMR2xlVC9SS1BXd2M4?=
 =?utf-8?B?cEtsNHN1cU9tZjhjZWZxZGFjbWQ3L0wxQ3E2dDNxNEJvU0hJdVRlTFBPdUJw?=
 =?utf-8?B?ays2YmZkcTRmZ2pBNkxqOGZFQUc2cFNreHZMM0R0K3Y1akNiR1ZRYmlOUXNM?=
 =?utf-8?B?NlN6eks4dTZTQVBmMGV6c3dKK09JTWpkZVFsK3NNUlNLUFF0b0F6TmhiY2Vz?=
 =?utf-8?B?ZlVZMFFmK042SVRlYnZ1NTArWXpEbEloYWRNNzg3TzBZVi9RWndzR1Uzdzdl?=
 =?utf-8?B?bUIvVnRSaUFENFRoL0gwcE1yUmVKenRqd2JxNnJGWXZTcVRlTHUzSW9ub21S?=
 =?utf-8?B?c2k3QytGMVkwOUJZK2VyNnZGODE4cEl4b0poZ29hTnk2N0pUWXBxN0taRzQ5?=
 =?utf-8?B?RzUyWHk4dzFRZDg4LzVhZ2RjWUNGSnFXay80cHJSYTBpVG5XVVppRmRhSUtO?=
 =?utf-8?B?Rzd1UjN5Tkl3dldaRUJZWTdIVm5tMjI0MTBzaEhMTGZCTUZmVXRGVW5PaEMy?=
 =?utf-8?B?c3ZjWnJnUzVpVkhVVzhpU2M4N1lzLzBXaFdraCtQb05SVDdYbFNLTFZ4VDQ0?=
 =?utf-8?B?M3E1NU96Ums1dkV2Rmp6TEJkYWtKUXorbkpiVUZmdTFKUmIvS0w1VTFwdFUw?=
 =?utf-8?B?UERrNTFjWVB0QnlnZ2pYOWhHRnB3amxvY240NlNJVmVzQThNNUtyQnhsM3do?=
 =?utf-8?B?dXlVSE5kWGhhMzVEUmZRVFJ1aHpibDRtcCtQYyswQzVBSHVraGxqVU5iSlNk?=
 =?utf-8?B?M2ZPby94ZjRSd0tIT1IzdkZCYm9VdkErd05kbXYxTXdTUld1MFdTUnVVTldw?=
 =?utf-8?B?STZFa3JrQjhYMkdsSDhqVFkrU3FLL0xIVVVVMlZoaGJFNUx1NzdicUZIYVdU?=
 =?utf-8?B?c0FLYWlyaDlZbmtqdFZpbSs3c1N5Qk55K3E1ZTZ4b0RPd0xSc1BrQzNBRkYv?=
 =?utf-8?B?M0NjMFJlS2YwRU16bkExd0RSbmxCV2kwM0JFYmRkREJaWVp1by9vOWdBQTk4?=
 =?utf-8?B?NjlOaHBBeVZNNTVsMjl0eXY1Y3dMWGNIY0VyU1k2YW1WNVNrTnRGUFloV05B?=
 =?utf-8?B?VUJ2dmh6aUMycVVnZzVudERGZnR1em1oWURuWC90V2U1amUzdWxXZCsvR2Rq?=
 =?utf-8?B?WlM1V2ZsNGRRY1BJcTFaOG9tS0xYK0dObVExMGVvUzdXQVlkS1dNcHV2SzJY?=
 =?utf-8?B?MVpLLy9SU28vcVovN3AwMnJmK3JFWEl3bm1URDhJaWg2RHBPVHlNQngvazd3?=
 =?utf-8?B?cHR1b2NDUW5zdkYvZDBBNVdKcEp5LzI3VVFNWFMzTHlRZzd5b3BXeVR1TG9F?=
 =?utf-8?B?U2JiZUlpRGNiMHFDS0FqM3BwMkt1empBRWQvZHNJbkxNTVRreEVhcHNjYytY?=
 =?utf-8?Q?goEWX84EnT4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm9WUEpvQmQwQ3VIdmNJbVFpRElkbzZXWnVDU2x3VmI5TkhZa05IVWRlRXAw?=
 =?utf-8?B?VDYyZS9kdTY2UmN5UlhzTnJZWnU3MkZtaWJXb1AyZk5PR2d5TVpVOVJFZ2tz?=
 =?utf-8?B?Ym8xTHZ1MnVTN3ZFWUw4VDQ5NkJZMlVGbmVxd3loSU9rdW9UcWdsZ2tXSnI1?=
 =?utf-8?B?dTZhRjFjb1hBNkJBcGVtMWh6SEZEOCtoUnQxcHIxMmhzVUt3YmtUTXFMR24w?=
 =?utf-8?B?M2JWV2h2RmVCVEhJa29xSjA0cmdBZmd6YUQ4cXN3dU9KSmI1WS9yeWo3a3Fy?=
 =?utf-8?B?TGRMd21vcnd3bnIvSTl1dk5iTWFLUE9GLys5RGVvdDVOQS91K2N2OXdlck42?=
 =?utf-8?B?dXh2TzB5U2xZNis0MjB6UjUwODRQZTlBU3JXY2h5ejhyUFNxRkpOS2NNUFNJ?=
 =?utf-8?B?L1pVNkpaZXBEeGFLYWdRbmY4enI5azcydjJDY2VvNjFpanEyekZwVzRyaWd2?=
 =?utf-8?B?U2JTMXRsTmFVemd5U0xoMnRQMEYzV0YrS1lFNjQwOW1OZnpva0hkSzlDRVVk?=
 =?utf-8?B?YklscFRnSVhOcnREdUpScDRMekloaW9pSktYeFRSajQrOVFLZUFJYmdsVUdo?=
 =?utf-8?B?cm9vbXlwWXNreXE5ZmQvQmRKVnhrUEQxZ0M2ZVB3V3ZIR2xHdUdsYjVyVjZt?=
 =?utf-8?B?SUtqTUhncU5oUWc2UmgxdXNhWkdYekFtb3YwQ21yVDFIdUdnWWR1UFFOakpk?=
 =?utf-8?B?WUxrQkdFUm9mQW4zZ3RGcEh6RjB1anY5NHE2Zzc3bzZEWXVsc09xWHREU0kr?=
 =?utf-8?B?OEx2SnpJVk1VWHFkQzMzVUY5eUY2VUNrbDU4VU1iWk5lVVlUWXZwM3daakNV?=
 =?utf-8?B?Y3RJQ0NwNXVQUmswc1djRCtzY0U2WXdhOEpWZmZuWVNLcWxURGpIZnRVMzdn?=
 =?utf-8?B?RXZHV2Izay9EN1QwS0Z0MUw1NUdJTGFDVHFYWlJnRURqd0ZlcWhid3R0Sk5Q?=
 =?utf-8?B?YWdRSTlDWFNvMEI2b2lEVjlRZnovcDg2R2tweUhVVGEwVTV3bmlqWXBFWUli?=
 =?utf-8?B?UmhQdWJIUnhqTWFyUFl4a1YwN0dvV0ZINk5MWnR5R2Izc2ZEeGdVcDBqMkFN?=
 =?utf-8?B?NmJOM3MvY3FtckZjeUlwOVhoVHRvTVZMRkFBdEpYYmhSUzBRc1dvNVZDelNV?=
 =?utf-8?B?WDN1M1dBZUsvdVpNeWlxZXdOWWhzNGVJZWRlRTVmV0xQZ0JXQktQcUxvclFx?=
 =?utf-8?B?SGhVdVByV2pPSFI3RFQ2cG5Cb0lGNmNQcG5KUTRoUEl5T09tSkkrd0s0VmFs?=
 =?utf-8?B?bE9NWW1sc2tIZGR0ZHN2UkNkaFhIZE42aFMzVGRrK3p5L04xYlFQRlhjQ1VO?=
 =?utf-8?B?ZjYzN1ZhYWllQk1ZZFc4RXhGK3REM0l5UnRhWTk1eHBZTFFSN0s3c0FTZkVv?=
 =?utf-8?B?TllCOXFjSFI5WWg5d1MyK1lUTEN1VkxLTWtSaVFvUEJVVzV2U0kzZm1SVS9i?=
 =?utf-8?B?ZG5nbTJKTWV3UiszQ3NITU1aVitRV01wUE0vZEtVRWhDQmN0aWd2MTlocTRs?=
 =?utf-8?B?VldINThYTVU0cllYRzIyZUdwOUFWdFhERDNCdFkrVlA1TGtqVGdjSWFETm1F?=
 =?utf-8?B?RGI5em9waHAyTjJhc1RUdmFwbURGWFhTYnBzV1BNeW9sZFZOMkNkVnFKS25x?=
 =?utf-8?B?NkxWQ3FjQWxnZ2lqeE1UUUwvVGowdGFxOC9CaDRzMW05bGVzM0RMOElLSGE4?=
 =?utf-8?B?YTdUV3BZMSs2Zktsam81UFZLSkNYdGN5ZWZodDFpUzExTElqMnJSRFI5UUp6?=
 =?utf-8?B?ZDVSMmR1MXhnMW5KTnZPNHBiUjhrV2dENHV1RzN0QzB0NWdPbDJWVFdaT1dE?=
 =?utf-8?B?MFpvL1pUMnpOT1g2cFNJU29ibVFyUndZb2xMYWVJV1U5MUVTT28rb1pCc3h5?=
 =?utf-8?B?N1BiOWlFeVM1OVlPOWxuL3BDRW4yMDY0UmxicGU3N2lQQldYRkNaZmVtOEQv?=
 =?utf-8?B?YVhjZjBNbUVFU281d1RhRzBkcEZwVUoyMFptMkV2aWlaTks5Y2RIK3JrWUl2?=
 =?utf-8?B?QVNzbSsyNzNLR1M0OVZON0tVNVhHbUp1cndNVmlDMFhvMFN2R08zYnFMUHFH?=
 =?utf-8?B?blBBRk1vWUJ4Y3pyRk80VWF5bUw1TWhZdGNJUTZoaHZaZWh0R0l2Rk90c0k3?=
 =?utf-8?B?d2FOREtvTzlieXBLQlhzNDlrUndzLzdxSi9wcEdHVWgwN2k4MDVTOXBGRDdo?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2035647-694d-4a02-bf8f-08ddf5f76479
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 14:35:05.0565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbT/Om+heFRTqGQhLiAWoj5+mqILQa+6Jfuox6BenvmWJeiDFcYgzLO2mJHysOCm1qww6uRRNGblsB674Vnf/GvjcaNZZD09BfyzFBf93dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6012
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

On 9/3/2025 5:17 PM, David Marchand wrote:
> The DPDK API is not dependent on the VFIO API itself.
> Remove inclusion in rte_vfio.h (and bus_fslmc_driver.h) and add explicit
> inclusion where needed.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Reviewed-by: Rosen Xu <rosen.xu@altera.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
