Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C60ECA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:40:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DA234026D;
	Sat, 10 Oct 2026 20:40:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 92C1A400D7
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:40:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657633; x=1823193633;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=moKsVDlry4nnVFknllC5qqj7/DeqBeaE0rq55eCXZo0=;
 b=MWKe1iHBzzK8QZjNPkp6I3/5NpzD53msDewOHuz58X831oSlxBJD+LGy
 qTVeg93eNin6lvjO+RJPPYtkOTvy9MnX8q+rwR6kAKoKIZx3JirSoQ3Bv
 I+y0IO8rgg+5X5ErTu10aSdDriYsLkGsUKKD8V3NPMHXG3SX8aA72rx44
 y4n70brhp1mQDe7OAVNPMZttQH2Y9tfZwmSmr3OpxnsXdo6Ds7Hm0SM3G
 1GFxOr6D350S4PPtuhCQ040fdgVNeB2eR8bwpWcCV45EsObcBd/IdKnhO
 ViTZEQ3tyrrKui4cbuCJyuITh+0GAah4JPi9SCFhONgHCPmL8rZmXYyv9 g==;
X-CSE-ConnectionGUID: /gAyPvLYTPOg83QjJpLr4Q==
X-CSE-MsgGUID: uDFGpPU/Sye7YJGIIwS0zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="435059"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="435059"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:40:32 -0700
X-CSE-ConnectionGUID: DCr9SqeKSxubFMq0yNQDkA==
X-CSE-MsgGUID: GT29vVvXRs2IacW7zzSJaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="877943"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:40:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:40:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:40:32 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.16)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:40:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piwOG36DGIlNtNGWEYXgL3RqgegH5vsEzFNBfPBUOQMTO5Xmcqn0IakViUzIIZV0GyzCmuvWrY7FJYJc8KjuGOGv3hSnEj3LyNQw0cBHOXXAq8ytQNWhylpuREYTdEQOuMlrp+UACT/2OSY2k0mRrXCCVNfZHFCwcuCbc5Wnh+IsJUlDd3stTeTCHL65Fi83fXy/cBfc/b0+Yu3MO+7LtOTYdMX8pPQCdONBRmTyp5qRGYyvHAGJslIGMMIgEmA1gZ+OML9nq967paB9RY0Rix8s9hm18Jw1j/kTOKY1/s9B1I2JWAayTEewxPcVeLI6AcdsZWQWtu2KSLYQImu6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmRGyQHTyb6yUqdExbbBrr9DTnVYyWQT9CLj3jB38Hk=;
 b=S+bAMF5dZH8+LBbMx0R8Lw1eyldq0q49fQVAG3TM9TrCLbMcD/IsoZUA7LtMuiHp953BIwq1gO2xCEobe/b0gn5al3t0TUcB8Cp8XbNfch//q24o/O/eBBE1r7bGAMK+rNL2Aksk6TW0QLN2OPV3cjmN2sRI6KHpiMNJPodxmzXLspAMZ4G0C7w7xQ9F8RaBNxUvnyNtnCp1n79kArRt6zl4P3yhpeqxHf/5Ka64RakD2XBRUwPIctOKpo08mbWeUz1l5DGfBTr6syrUKA74mFyANfCsvlhGrALA51X5YhE2Ew4h0b3Ho+x1gZKdCX+i0vGVef1fYzYxzyt42jFbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA2PR11MB5049.namprd11.prod.outlook.com (2603:10b6:806:11b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sat, 10 Oct
 2026 18:40:28 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:40:28 +0000
Message-ID: <95ef7551-1fb2-4622-beff-1b5bd636a2e6@intel.com>
Date: Sat, 10 Oct 2026 19:40:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/25] net/i40e: add support for common flow parsing
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <46caa981dd40734d11ab0241caf02096068e0e7e.1791543155.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <46caa981dd40734d11ab0241caf02096068e0e7e.1791543155.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::9) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA2PR11MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf5f35e-6886-4e9e-af24-08df26fdf4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: n2ALeH7Gl6t7r/nV9lNS/qdZanYUmQE5jyTn/jM6n+hi/5nxgQWSuOHtU5YeiBlwqnFnb7bciyIdgpLRftX+3wPof6cnTzMgZztuG45r9ADWI59yrd3jxb7NEBEToh6kZccavnAgU3I1/gIaORbO/FwbU0RQyW/VcTuNXj0x1CTZ0py1fkIYTKEmVIPNS+fPxi61NzOwTkgPbnIdOuv55K65LqjylTCy5xoOieulBLUm+fJw5SO5lAPoOfArXl0c02MlqVGqqdgzWs9X34tas8DstNRaLGzb9ZQjaJNL9ktp1bNAzv4cyUM4k6QJnH4LreqeVgOuOdGWAmQ2gRfd2ozsmBz4CXtZdcpBGn8SBnz25WiXzc9wkoMNTba92CmuKKbMowgNg898gD+t2sgiXX8HNKiMjKoQF3rzEztO2VyR6HEY315L6z4VUzqA6s9f4Bh5Rl84I/E8Q0MlkQ8PQu4AHpAGbe/aYJYkSucyXQO7tzneq9MK09xTE1oMciCwT3xnz6O/QUhf0pA40g5PDRL/idUNn/wpZbgT7sqn05uvXPUPXcrlqKXnCmB3fVGohUAAozhwhPILTjJbldluhs9qaHc9rLZSad89gsk6EL1h9waQejShmNFe5N7ktPi1/zRbh+RxQNZUVujOTHjaS7AittAPWkywDAle5Q0tZ1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTJwMlpORFJxVlhxbW1QQzNBSFlkdGd1R2tsdk1pNnVreEprTkdUVHM5M1ZY?=
 =?utf-8?B?NlVUYmNDazNKZXUvaGs3SzdYSEhoZmFOTitZcVBKd3pUYncvZTduT1ZGMVRi?=
 =?utf-8?B?OURWMlI5R1daQWFPMHlMUUFqekhEWUorVEFnWDBqeDFhaFNseWl6eDFuVlZx?=
 =?utf-8?B?Qjd4U0pzQi9kM2RuTzZ5cUlWL09FbnRUbW1JSkRVVkpLb2Z4YmNaVm4wSFZO?=
 =?utf-8?B?TXYxMGJJZFhVdUt4NTY1MWsybFg5bTN5UnVxSmk1eXlOVjJKa3c3Mk5VZWw0?=
 =?utf-8?B?R1YwY2Q0WW1tQ21yZmVQZGFhL3F6Y2R5eVA3cndGUmdXM0VrTnZnT3NWa2ZE?=
 =?utf-8?B?RDE3QjdUdThQdzVKUEJkMWQvYUR1ZFk3K3F5SXNxZWNrVEU1M05Odjhpc1cx?=
 =?utf-8?B?MjdWRkZReGRxdXhuaGM0UUtURFpuZVd5MUpQVmZvSTR3eUdXcStlRTJLdGhY?=
 =?utf-8?B?UmVmZ1ErOUZNWDJYd0FDSlpmMnNkcFg3M0w2WFlWUFFveWdYMGxYZ1BCNDVt?=
 =?utf-8?B?THFUTXg2Z1NvMXZ1MGthOTJkMGpkYXhkM1I2SnlKd2tkSTkyRUZ5aGY0QUha?=
 =?utf-8?B?aVRMQzE2YkZmVEYzR3FWZjd4c0xmK3kxNHlPempFeWE3UEZuOHN4TmhFNUlK?=
 =?utf-8?B?QmxZSk93Y2diMnlpUDJQUUJwU1QrdWsxVFFXNTZpQnNLQ1Mxc0ZXSDFvek1v?=
 =?utf-8?B?L3ZOS2xDNXlJdEtKd3U4V2VIc04xOEV2dExaanF4cXJiLzRhYXFRN2tVOHBX?=
 =?utf-8?B?N1BUR0kxWHFuVldLNW5ReHVDbENZbHJtbWh1TU95blVFV2ZHV1BkUndMeTZi?=
 =?utf-8?B?bjRGT1Z0Uld1TVV3dXdaYmxtald1VTlGTFBkSFZoV3ZMakpPZ08rMklkKzFa?=
 =?utf-8?B?cDdOdHI0Ti9tRkxDUzJTVEtjaUE3VkFYUHRaTXZuN0ZPeDgvYWJkc1dhSDRi?=
 =?utf-8?B?ek91RnpqaHNUQkpGY2p1b290aHJqMDVUR1JLSXdNeEtwNlFJdDB6akJMSEtO?=
 =?utf-8?B?OFgzTlRzUHB4YnM4OHZEdEZtSXF1MEhOUmhjV2hoZWJ2S08xVGdZcE00aVhV?=
 =?utf-8?B?a1BTdEZReldXTW5EODFKREp3MC93dWt1cWpJRGpyTElQejFzTHRrSnNnZjhH?=
 =?utf-8?B?c1F4eXpPcW9RbE1jVVJRYmQwK3JORHUraFdJVDFQeC9vQ2xSSWp5bXJzWVZa?=
 =?utf-8?B?S2FVMndFUFQ1NWJTa3JQNHFWazcySHB0Nml6dG9TZmFtZ09kQy94L1RGYXZR?=
 =?utf-8?B?R1VxcnMxSkxvUVlDaHlCSndKRm9DS3Q0Z1FqYlliVTFwTFVIOElIWmxoVXI5?=
 =?utf-8?B?bGFtSEtweFVUN0xxaEJocmJEVThSOFBSYlJGQkFtcVNEMFgvSXEzWlVmZWYr?=
 =?utf-8?B?T0hNRXNZZEw2ZG9wdTFTUU1ncW9PMEFoNjNPZTVIRERPZWx0ZEtkODVaUEkv?=
 =?utf-8?B?MHJyS1dCTFlKQW9jM1owd1BQOE52cXB0Rkw2cWYxdHVITS9PajZKOUZmS3lH?=
 =?utf-8?B?RE1jVVJBRlVJdkVPdHNOSnJiVDJlc1ZUdjkvUVdySlFRcEtqRjdsV1RVeUxL?=
 =?utf-8?B?RU1wbldrMmQ0MVNRR1lHcTNDNUNpNHE1a1FlZ1F6NmRab05SUUJleGRKMXBQ?=
 =?utf-8?B?Ynh3OGFCdmYvNTNsU1NCWC9HZ3N6REdURmV4N2lJd2FkSGxyUFVjK00rcURU?=
 =?utf-8?B?eUkrUnFzbklSdlBXNmdvOVZjaSt1b25DVXFhcjQyaGxydENpSHVHUUN6dzVw?=
 =?utf-8?B?ZkMxdE91UGU4ZTNQbEV5WEhGQTZ6dDVUSmNKcVhVUUpjb0c3bktHNHJjeEZr?=
 =?utf-8?B?c2R2VTJScGJMNVoxQ3htdS9peURZYlg4dExOenNncWc5VGZUckpsSWJrTldO?=
 =?utf-8?B?SVp1ZlNHTVgxQU54cytFYVpqQktxZDVsR2ZjMDQ1OFE4QXpuNWZjY2JTWm5F?=
 =?utf-8?B?dnR2aGlZMnE1cyszbWFIMnczN050V3JQQ2QyaDVQcUhONysxSVVxenQ2MmZ5?=
 =?utf-8?B?NmVGdXlNckp5UHBCbzVKem5NRG92Y3hqQi9rZ1VOOFEyQ3FxY3pMNlRyV2Fn?=
 =?utf-8?B?L0N5TE4vZGpvZ0kyYU1sR0Myejl5bWltZCt5L3d5VTYxUmQraUR0czVDTHZZ?=
 =?utf-8?B?Zm84Y2lsNFc4ZjA5T0JQMk9Jb3ZJV2RXamR4ZCs1bWJaSkZOQi9la2RhM2tm?=
 =?utf-8?B?QngyRStadnlvU3hJQ0xuUlBTRTROdGZ5MC82WVlKaUpKKy9mdTBLb2hMTlZV?=
 =?utf-8?B?RXI3b1UyRnhIVGxBR1lpdW0yNVN6eUpOSSs1ZFQ1NW42SkhkZXc3eWs0UFZv?=
 =?utf-8?B?TWplVG1STGYyUGJOeFJDdkJ2TE1Uejh6Z0NyYWVvOGNqUXI0bVV0cE9vQTdP?=
 =?utf-8?Q?V9FrR4/a26uOTi54=3D?=
X-Exchange-RoutingPolicyChecked: lJNl94508uxH2RvKIooxrOcLgxAgT6nfN/JQ+T2GDabyLSP+2q39F0Wb7Et8rkJ27pWnuKhs9SDhQ7udnpfm3cw9t+I01aa/ZN9FU6etQsnFrn1qqF8/jfECRFnUWIxvQaVapG6lSLFxpV1A358Hqv//gYyeK4Srf/k7Ag3G0ZATaMky71baB7nafLvCevYtIiDkTAEyLDm+JMhGwW/lyEHmGC2hOZ6/1Wy5luYoKPJ1Vr55Q2q2x0o9USWOOmrk7ykJbwjrkqva9GVZUwiurwXpor9PhBMA4NbxZNbe8cCEsiEnOODK5yvWvpeB5kPSV8meq2OGHEq4LRROMuH+tQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf5f35e-6886-4e9e-af24-08df26fdf4c5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:40:28.6185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlH1dkuxg/x+0VTkQAuPDyJCsAO+LQtdoDDi3uenFmHVCdn9avk/Z77PJ9MiNrIPZo3s6n1Ba1QJYcd79W46hXAV5+WpypHEZC0VCfhrYYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5049
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/9/2026 11:59 AM, Anatoly Burakov wrote:
> Implement support for common flow parsing infrastructure in preparation for
> migration of flow engines. The following features are enabled:
>
> - Conf init on dev_init
> - Conf uninit on dev_close
> - Flow replay on dev_start
>
> Currently, i40e explicitly clears KEEP_FLOW capability flag, meaning that
> it advertises that all flows are flushed on dev stop. However, in
> practice i40e actually restores all flows on dev start, so while we will
> not (yet) advertise the KEEP_FLOW capability flag, we will also not flush
> the flows on dev stop with the new engines, and instead replay them.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
>
-- 
Regards,
Vladimir

