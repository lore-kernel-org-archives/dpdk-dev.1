Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4DACA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:36:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44A4040267;
	Mon, 18 Aug 2025 18:36:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5F9D540262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:36:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755534991; x=1787070991;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=DBwYa6vgsX5Y4+IalDCnODiWF4ljPMnQQxZsKAlJHCc=;
 b=lJkvZk9MN9+Uhd0rxOgQ/3ODHraoP8xB75qA+Euudsu3amfctfVsI2SG
 msY32gyBVYyzW2FYyqtd1c2OBPsAnMSk690JMFX2S1mM7VbtfIP1OaUFx
 MmDiAIcBCHrETbYzXA356pCy2su5vKx6+oFIHHTQRcGeCyzILkP+K65h3
 S7sWCCtUOjgMciZ1pOODRYFRWuzd0pAh8DxeiL5ne+mftTaLrjuKRgc/H
 92jkwWdyzs5lmNNr3o0bNOXXeqxiJIpwkt7Hug8zIlJ8Lm4NNHGQmiBDm
 +/jJ/OnMWeP4s8cQFIRt/QyAdocCJvwiH64JVPArj1y+QIXmNgsEWf0Vh Q==;
X-CSE-ConnectionGUID: YzAPn+JBS32VodTA8IG5Zg==
X-CSE-MsgGUID: Lhd41bhbQNWje4UdLueqHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="61600788"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="61600788"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 09:36:30 -0700
X-CSE-ConnectionGUID: d44RLpWMTAOtRsAnL7mWxA==
X-CSE-MsgGUID: EdG9NzCiTJasbNcP9oVGMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="191301788"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 09:36:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 09:36:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 09:36:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.88) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 09:36:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SclgEenomeKsNQ/mB21rTe2sPDMqtaoy4QvCKy9vJCMWJwXiLB83nDbMfuTtfk8QkshrkMR9fNFb+eTPT0CwOfTRzK+GMHkFsB90LGUP8DI+AxXr18uEeLqD0gRMT+XDmDXnv/3oy1v/ouHwMVg525n0/vJpqvDAeaQq7di+onA4IAbPh4Lq1h8XLNX3bkfci/C9NMo34OcJnP6ZlzhtF2f0H6PkchosxzAmeoka1aujlb4Nylab4l0BYQYNrtdFv8UfOy3dwUXjPCIWSmUYpTBKPd+0UuzICtOqsCGIWv3jzhbShqDvg2g064VyKYTovZpccQrFNDDue4fj9D3jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+Jfq7yMkyVi8UjipniolNRWrPQw8L2BBPVdTZJEYNI=;
 b=v2atYWOTzlnFt2sc+GjRGzVieJ5fB9vdnidY325QdeZ3rvbd/6wLEfutiJ2V+b5RX95ngdJ808ZdXa1dVcwkKkAq49ZdpFWnNLSGTgpTKyKstasIwPooG+vqHlvrHqdCs0/g9a3dClt5LN2WTRZk5QLy1+RWNTH3ynQsFlQDoN2XpFIWm04kOk6ZFTY0Zg1dsQX1uYBZZyRaC+rhvCpYDy1lhN2pF1MsObZSHA0ylEALh1eKOsmy1z9vgrU2dmjUXLMkOl6ryQNHhoin0Y1f5H1t90/2b54Rl/OzbXTOLUl+cHPSCecESQsM4z/N0KmREVgUckUTLNeKKXU3q+iYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Mon, 18 Aug
 2025 16:36:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:36:26 +0000
Date: Mon, 18 Aug 2025 17:36:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH v4 9/9] config: enable comma warnings
Message-ID: <aKNWhb3YWogF4iRg@bricha3-mobl1.ger.corp.intel.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
 <20250818161815.23611-10-stephen@networkplumber.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818161815.23611-10-stephen@networkplumber.org>
X-ClientProxiedBy: DBBPR09CA0033.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: a57f2a00-343e-4888-a725-08ddde755ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?kpeUi2rAmQzj8I/XdkMbKfctLG44ebBz/lFN7xx1jEcccR5GU4Vg7vIAjY?=
 =?iso-8859-1?Q?AgSM7uFidcphpRxZnJYQ9x+Nx0Njq33Jx9btAeSstHVhLbkjtX8sdJOsjt?=
 =?iso-8859-1?Q?q449kIp643XgvjiS0UdwUWFqHFmCBg7eIQPXd2+DJS5DVTbTeHFPdJvHgm?=
 =?iso-8859-1?Q?/QbjN+VjgxbFbvVh3fhh/MgTwRsQ25ccu9f/Ki5kFjN9OqYuKeQii4+bBf?=
 =?iso-8859-1?Q?BtMovhkBPey4odzcLlP5Eyy1eBXfNohikJml8zOWH94+DITKitf5IpSx+E?=
 =?iso-8859-1?Q?S/O5+4ODhH5XDvbOF8oEB0OwfKdoaUelxJvNkns9X9puGWE+nXBtSLyLCI?=
 =?iso-8859-1?Q?rJUig7d7A5vAL44lSQaoOeRDWt+1LN26tjO8mgwCdXjU/2v3WYyz4FtHQ/?=
 =?iso-8859-1?Q?YRNz8dsQip0dkmMiiOCblENXiqLBF/twfwiRmphReMoofaKNDQ/Qdm0Ckv?=
 =?iso-8859-1?Q?9K8+lBVfKMeomUFFuJ7oqa9fwxao5S08HHX+FmYbsQQUHtlmE+oIBhX7lx?=
 =?iso-8859-1?Q?rG38xaUpGDTvad6ku74a0jsKAVLVIZwPjQ3R4whjSl5YJbTkOjvU7UuAdc?=
 =?iso-8859-1?Q?KWQlVS97Cn0/xG6g5K0+u4QADttpKRoBqY0JAQ5M+QZFxGD6TBLb1djicC?=
 =?iso-8859-1?Q?FKKf5tnZCXNt8c/0NhwU2oULJf0qpVxqlwotMs+UfRHtKMdY8U0mLgDS39?=
 =?iso-8859-1?Q?erfTsZ+oTe+7tRId7BlbKd+1beaMOlXs1TOpPVJBQEW0lwvxGxb2TxNCWR?=
 =?iso-8859-1?Q?+o4DaQFWyEkhBGZhpnqoiNrh63Sm3+SDCX9GSPQP5tPbIJf0eZV1sFWW64?=
 =?iso-8859-1?Q?9nGynYSCnagCORe5KG9FesvlaMxzEi2qK9gReMzz6VCYr0gy87JK62quy6?=
 =?iso-8859-1?Q?/DdMyDMqZ1KPbquXymCTPcZYevNhRECMG4Gm3m3PBqMb8M6HXR80mSNJXh?=
 =?iso-8859-1?Q?mfPSBU/IaJpk4HA76Z6jvR9LSJnw89RjUuLTmlOv3sy/SBYkRLRa11QM1y?=
 =?iso-8859-1?Q?/I50ejhJSS2WzxeYAou+wLo5Spf19wJfvmxIc+kKzyNYapbvpA0LgLat4N?=
 =?iso-8859-1?Q?9nbInsBjAtJ/hDIHbT0jy0lgT6R3cU4M9XEP3zztwGJ6DYSTCDKr7phGi9?=
 =?iso-8859-1?Q?k1qlSlhyrieY56Yl2WagaI0l4oHT3hKPRUB4YztRKFeMZZl6BYS763xPW1?=
 =?iso-8859-1?Q?o7knawMvF8ec+I8hEI7TCg9rZ4+SMdT8Q4CzOrvXX01YZ251huQP2C7l9M?=
 =?iso-8859-1?Q?gY60wfLSX3qwSBqQ0zsVQhsrC/6ht9xQjPjIs2tAgjE/b4srUsttT9i4Hp?=
 =?iso-8859-1?Q?YfYt20WKsciU8mnkDktfh3Paqg4LvndFcyuC/gprIO85W+ZZWsM+7U6rkI?=
 =?iso-8859-1?Q?34RRat1Ki0zgpKzp+TAO69fgpSxirEl0ed7Yq6mGEWiGnTTmx663WVLnW7?=
 =?iso-8859-1?Q?5woRyUtsMhi+kU9t9Whc4ma/3eKuuO9In/Ijg6ZDzKUHBafj3PvU+J4IO1?=
 =?iso-8859-1?Q?U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6nbZ/7wYjtw4L0ZzYcOcxDrpP15N+tYnCL6CYulNla7Rc5oSHGzxPDDK42?=
 =?iso-8859-1?Q?xizp8N3bGpx4t4rfUrgtBdyrpFvfolFaz/hfwh+U0HwKVq28EyFVdUsjzQ?=
 =?iso-8859-1?Q?505ooXK2+zQ8z9MHfegTnx5kKCXrNSKaVQmMSTEmPuJGogVJ/x1onl4V3Q?=
 =?iso-8859-1?Q?EJQFDfc7IDFdcX40YeCXI1LopvyLdMHaS7MQ8fE7zGWLmOtku4YCChMRcN?=
 =?iso-8859-1?Q?iey7bVkfB8vV/yTMCBHLXqlNHHY0D99CTitNW8EX1MkealAYZ0zmZsREGC?=
 =?iso-8859-1?Q?Z6io+iUBkvfYDXkCqpuoWWiRxAfTCgBCM8Vbb2mCSz66L+4D5IFDVt9B1s?=
 =?iso-8859-1?Q?4uxTT/BgRb6YUTpqJoVCYr2EOop0B8Jh0PNV14ntzJiCeOPyUEw1MvsfTZ?=
 =?iso-8859-1?Q?MiM8I6hjk9RvD0c+qerjhETB2mnTBkCt9oEixtvWwAblwsu6WiudXjgTIw?=
 =?iso-8859-1?Q?Vs/3ArpHhTtMfXM2XdstiIujcPlsoZc5MsKI3YSsNXkSo3/UVFE61Mo9fy?=
 =?iso-8859-1?Q?L7uufGMIoNq11+mFhmNI28CKTOTC8Li75yUd5XmGfPafKCydZbGil65sqN?=
 =?iso-8859-1?Q?TaGwEbcGtUE5Ilt+wx2+Emc0P2UuwjP5eVGgxGUYRDgYnb/TLu1eRLS0+l?=
 =?iso-8859-1?Q?6H2C22hxNNuQNSZ6jFroV4PrufkwTukcC6bTwbcr4qCXOsj5FvMjqt0Nj2?=
 =?iso-8859-1?Q?/ISsbxZoVj4YZIhlgq2K1If+5YAXoKGNLsxG3fK1OZFS7LrGEVtCoZqdxF?=
 =?iso-8859-1?Q?47ywIC9cXt1EWorjc0ajZi755ZVJIdUuPr2Upp4FHFYh25PJgrWOD5gyTq?=
 =?iso-8859-1?Q?kb1oYjd4Duuo0FyF/1h6SkJeafY4MyDh5EeULU9b3tut6LYiCt93TXprsn?=
 =?iso-8859-1?Q?Y5Mmv4PgpkKXT1+WDuJRa0Y520D8DSWTu2KfdPf87Us8JyNsOHzfKz2cfg?=
 =?iso-8859-1?Q?U6xTWMOske5uGi5CSyGoc5cXVgWOJxSMDd7zCmVBgY40dc191kzQlsyIXn?=
 =?iso-8859-1?Q?LodZUXZJLZracoYVBpEoalSWLsh+SIjyQEL3v1nIeGazwB47P+X43rwXW6?=
 =?iso-8859-1?Q?y+d6plH2/jbwpUao9JgtrcH/b4xyvnRMX0DyZZMlfRrTRhCEwaydFXvbz1?=
 =?iso-8859-1?Q?kLteDnZJCpJMlpoxOHRyywSvqrPzVojUg+gpuPZwONHNoVC3znSF26V++v?=
 =?iso-8859-1?Q?rlOunBRpAk+tqzi+MJZbNMgaggW/Of0Lp4CFjpmNHEOJCtVQUoc3C8/TS1?=
 =?iso-8859-1?Q?+uTevZ2VoLnUWir4+yIceNcvViaWA/HtkvjivQL8wQeH4w/6dwBBCTjAYU?=
 =?iso-8859-1?Q?2wBAA72R993nbAiUbi5f4tqNBVGOBl2h6JCWqSONDbIO+3CJc/78xiIJvM?=
 =?iso-8859-1?Q?CG+/A40z8Z8ezNls3hCltqir2VrSYMquM4BwAhCp+/bMQi5JiblREuUEmt?=
 =?iso-8859-1?Q?NiAPSXHaco2YpiAIkc1kAyMsM3RG++hd22q7lTKGqr8arkc4fnZbA4gmf6?=
 =?iso-8859-1?Q?kKSfzPIlJrJ62ayR4CgKaS7waduHHXeelv2aSZ1taN4hIxYe1SisVdBlTG?=
 =?iso-8859-1?Q?SSecjXMFzizV/87R8/4S5qRu37Aw8ISlk29UrsZr3FPczEF7T/wHDjOesG?=
 =?iso-8859-1?Q?1yuRxy1kgtQw8eP8KWH5BI5BcptFm2bcL/APDjEoDStQK+BFfGxP0tNw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a57f2a00-343e-4888-a725-08ddde755ff5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:36:26.1638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWVfjUnLT/x9yPw+TzQKPQVsDXdj7oWH6HwWi4UlVGJpmqKrDgwSVsHMNWFlrm647eE4mfWVC2oFknF7jQAhA9fvm0uAKaEh/bBDi58UH2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
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

On Mon, Aug 18, 2025 at 09:18:14AM -0700, Stephen Hemminger wrote:
> Clang (3.9 or later) has a -Wcomma that emits warnings for questionable
> uses of the comma operator.
> 
> Don't enable it for drivers since many drivers still use
> comma operator unnecessarily.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  config/meson.build  | 1 +
>  drivers/meson.build | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/config/meson.build b/config/meson.build
> index f31fef216c..d9ff0e31c0 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -313,6 +313,7 @@ endif
>  global_cflags = [
>          # additional warnings in alphabetical order
>          '-Wcast-qual',
> +        '-Wcomma',
>          '-Wdeprecated',
>          '-Wformat',
>          '-Wformat-nonliteral',
> diff --git a/drivers/meson.build b/drivers/meson.build
> index b62880db02..4c08a1dd9d 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -59,7 +59,7 @@ default_cflags = machine_args
>  default_cflags += ['-DALLOW_EXPERIMENTAL_API']
>  default_cflags += ['-DALLOW_INTERNAL_API']
>  
> -warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member']
> +warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member', '-Wno-comma']

Since this patchset has already fixed some drivers, are we at a point where
we can just disable this warning on a driver-by-driver basis rather than
globally? That makes it easier to spot where the issues are and easier
allows incremental improvement.

>  foreach cflag:warning_disable_cflags
>      if cc.has_argument(cflag)
>          default_cflags += cflag
> -- 
> 2.47.2
> 
