Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AD8F46445
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:12:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD0324025E;
	Mon, 16 Mar 2026 11:12:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id DD069400D5;
 Mon, 16 Mar 2026 11:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773655948; x=1805191948;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=w1Vu4omkT8aCMz0J+U98W0eOqYdvnBjTYn/LOwCuzwg=;
 b=FKEYvTRz5+z6lfq0cZER9RtOv+sOeK1MFPAzrMzTmgHXpfqdhKJJrOcd
 gqzN+wosZy6v8C5XhOsAeQGT9GbRo5JPwTPtPmN+72v0IEVWYeXY45Qus
 lKwS6129b+HC7qJiOMm6tFvBpCNwHnSBbCcqamx4orY5PjaxRNKJtj1wG
 R121qAp4R6PYFctW/7eIGDgb5kHie5+njlWwmSjAkoT48AAku+V8F5Rok
 qJhi3cQA50yaMLlTOCDXyJd12FlbvZK8BAMjCb6r/zIGzktzSDiF69Qne
 iHU+gYilSpwuFW7DhBtw5yPIUGRbqHZxGVe/rKogSrmocei/8I6F9SvNk Q==;
X-CSE-ConnectionGUID: /pq+azARSRmS9pZ3jTsnXA==
X-CSE-MsgGUID: YjSaJqbhSum4YaAx5IUTJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="78516209"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="78516209"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:12:26 -0700
X-CSE-ConnectionGUID: 48Dx4QeaTFyIBDPmg5l3pw==
X-CSE-MsgGUID: w4RJdSA3QQCUdnYKMD59YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="219080116"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:12:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 03:12:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 03:12:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 03:12:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap1a6J8PVj8KhdS8gU1JHpCpz+hPk5O9eIBW3JUzC0BWF7Q2KtIF1ZhMz5dHLdAN2wVdWPH+ydwjNYsR7lhBxs3vTUN9dP36ccx0XSAnzznBMwek8E0wlXM6eJXa+hE12MYKC1j2NNnjUq6dT2TbjhqLQdQhmaeQ/YTFvHnoqBlHVru4h3Y1T9H8QL2746RUapQBGamyRlRG0X0F4GtMVnBM6/KHST+j5xj4dKeGIkw7yN0BGf6KrPD/noQE485m9ZdgFbVl8bft5YrELkZFCZeMkYFOnb+q8wuZRPZp/xGQJoU1+ZopJ8py4uftXD8CmtTJOU5QT3VCW7SIZPnguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7JhiqOZo/usLsk7GZ/IXG5vcDxc1eV8ee5DedRwysY=;
 b=Pqw82UMYTQr2fkc2uGBaScXQ7s9O6hIKjgS5vXE2GuolAUjkIVvYTjuUW7mGZ2vgHaTJlveggAEw5NAEORDxwitkH172DYzYmzt1f0nhLEA1cmaeFlmtMmYSr8SnZJ2i74LRsagMiSS0AlqztEh/wGrKPjgL5OVEupZy/eQEKq6DnxqEqqri6KUYgQpZ2t35eFqWBBQwvadxiva3S8P6RZCtVPeHV/QDvD3/jvw3fsPyy/iOaQH3fkaPGzkT3IBUNY8rpOzad9AQrfxqM6Xd8/f5xwn8tYhupB3YS36DnKF/ZaWvg+BrLYrARdTFNupL0Q9QZ7TX0Afx/6QXSzL/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 10:12:21 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 10:12:21 +0000
Message-ID: <c67fa3ed-a41f-4a92-a39a-1e7ca2a9da1f@intel.com>
Date: Mon, 16 Mar 2026 10:12:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] examples/ipsec-secgw: fix discarded-qualifers warnings
To: Kevin Traynor <ktraynor@redhat.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Akhil Goyal <gakhil@marvell.com>
References: <20260313103523.1094309-1-ktraynor@redhat.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260313103523.1094309-1-ktraynor@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::10) To SJ0PR11MB5661.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbe9e2a-d5fa-427d-7ad6-08de83448241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: pq7xaHfepsNnM8JdJQ4hBzNvIYjyKQvG4WpI1XcRo0vhKvaBPh9XLmlMmKjUEXgO+rIe4hIB5sUrOQrCFdx4Etn1d/I049HlxkYxOW/k8ZnmKVWXpO+cYNIK+ZlaO+2d1DmXexHQqogFsflHrEvxzOUPcWa3YD4m5oRob03AbRdSeQmJ6GxnIwHqPHyVZtP09yhrRrQM74i5ONL6jaz7LXcDWxld2bqSLmzcTNjlXtvHn5+HV1Ebz9mrIULevM8ZLNbO9XXZqXPWUV/REty1z3OCUeP869F/0+R/HViRE8gKITmeZFWm4SHR46oW6Tk+Z5Ks9wOziCSMPGxqMz6MkOpgAfwtOr7TwhtUZz3sA6/COgs3+jVHFpjo3T7yR11PiZEYgOXAMGzsYuueozneww1LXDwXm/NxTRoPlJYekAcaerd9sxxfMS3ZlHI/FegbIny7UeElAjpUn8HA205cmETI/bZhFwqVfDCNdkBRz2cZ8UA+1Djon7xCmyiMVrT9U6OXHR7TrIOZcuVniMwfUuUhT1t4qOd/YoZjYQBbULc+LJUq6URcEKTws31eA/Tedokto4e40F9kcvJXi3jIhBWMejx+7tyqtp6/kY8rg0QnvgUdH/EZlYu0hCMXeISXKepMnjxuATTLTd5MTNcbfVCTZIyxhXizkT7r/9Vnj5oANshCBHXoNkDyh+xS0YMyaAHMuyuaw7xxwXBpGVQa6WGxQF3jx54/VwUKnoA3OyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUFmc2UvT3plTGV4OU95TTNrbTIvMy9OQlJ3T04vTHlzSnp6UFJmSEVVR0tG?=
 =?utf-8?B?SzBpVzNqdERXbndwMGRvK1IybGZLWmt6eTJUU0ZQUzVTMmxJanNiMm9qd01i?=
 =?utf-8?B?ak9wcllXbVQ0SlFMc2FQSmE5VlJYQWtMM21HN0NaL0hxRm9ZWFZsYUtxU3NY?=
 =?utf-8?B?NHpJcEJhRGNRV3RkOHc5dktueEM1Yng4QmppVUt3SElHcmlDK1dDNWhNT2p6?=
 =?utf-8?B?MEx4RHB3QXp5RFpnM2tuZ1VDbEpKcFI0RWdCbWpSMVhRcCtyRVdNZ2FnUExL?=
 =?utf-8?B?VnB1dy9jZ09kM0ZvZHQxZlRnVlBXUnd6Yjl1SURGVG5Kb21uUEcwQjhhNlRC?=
 =?utf-8?B?KzIzdGx5RjlaV2NDUzFVZ0VoR0I3Rm0rYVRyeSswZHh4bms4T0sraFFxaHlR?=
 =?utf-8?B?NDJtT0cwa0FqeWN1OW5iTUVES3J1dXBSMm1tWUFVMitqV1N1TEREWnhIUVVB?=
 =?utf-8?B?aHVKOU5jZmI2emRJUzBCZEduU3VmaFF4NmRQdFdJOGNNUlpPU3JJclNlOExy?=
 =?utf-8?B?R2F5b0Z2b2lSTjBQVDZHQnE3OFBOSko4Rno4NWdBK2g1Qi8zMlUwdjZWblhk?=
 =?utf-8?B?QlFVbEpMdmU1QlZmS3U2SFRHdXZmSmZsMUVpYWRJN0VwOEF3MlcyY1NTY0Rt?=
 =?utf-8?B?R0wrY0Z3VEQ3Lzd5VXEzT2pqZkpEWWRIUGpvRzEydGdtOXZ2WXNobllENGkr?=
 =?utf-8?B?SVFlallLVElvb24zWEdVODhIc0o3YVc3MG5NUFoyd2xrSGNscjRsS3BUWGY5?=
 =?utf-8?B?MEFMdnpYazdiU0NzOW5rb09EUzFkU0ptV1hLZ2lya0RVT2N5R0VSZ0RWbGVu?=
 =?utf-8?B?clZqeTFOK0g4RzBaTlNDN3NtdW1DSTNmWGM4ZWpnNWlVeXZCRTZmcFcxc3VT?=
 =?utf-8?B?UXZPK0RockJMb210RzV6RGk1aFFFSjlXTThSc3YxVWlUcG5jb3VnaG9renFl?=
 =?utf-8?B?NUtOUXdMM1RwK2loV1YrL3lhSkdYRC9UWkhjOGRuRkhzeEFheDFhdlFpQkRl?=
 =?utf-8?B?STdFRHpaUnBxUDRHQkNHUFJuMWxKSFhmZi95eTE4MGo0NTdjRk5JU2lPNEI0?=
 =?utf-8?B?VUEvYmlzWnVrQmtTS0dINkFUNzZGcmNqOEpMbkFBdm8rSmwyVGh4WURzWmhH?=
 =?utf-8?B?VGg1V2pnaGJYekxaOHRCa2JBcm0ybHJxdDk0cW9aRlEyS2lobW1odVorRm9N?=
 =?utf-8?B?M3NZNVlUblhGZzBUMG9OYW9xVHNVdGVKSXVxSG9KYnZyb2JybEFwaDJVbTU5?=
 =?utf-8?B?UEszU1NOM0Z1NFdEb3Z2MzB0ZGlpcC9jSzdrd1ByM1RaSzZsTk9EcytZUm5E?=
 =?utf-8?B?bUJicHZIWXpWcFhpSmowR2oyOTRhOXE3SEo1NC9aR1h1ZS94d3NxTC9FQTRV?=
 =?utf-8?B?RW5xdUtKanc2NDljOTJsUjJvOGJhY3lQOVlZMkw0SVdVdHNza1JtN1VGck5r?=
 =?utf-8?B?RDlxK1Bla3RRU0l3N3NHaVZVUlNFdEhMUkhYTUlUdVZ0U1hybzdTbStvRXV6?=
 =?utf-8?B?Mk9FWERMRDJJWFc1LzgxL3BYOXpBRlJjQXR6SDI3MWplcUZWQjRVNWtBVXI0?=
 =?utf-8?B?NVd2MGs0TG9Mak5IazN5TlhDdk1SbWwvak9lR1V6UC9lTlBOQ3c5ZmtFYXZ0?=
 =?utf-8?B?N0M4RDJkS3MvVUZnYk9rekNYMHNycFAzWlFZb3VKUEFwR2w0NmV4ejRBK1JH?=
 =?utf-8?B?RFF5RitPRnQyRm9ybytNbEdrbkVDN0xIeVZWbjE0OE10SUwwWHJ2MDh6RDJS?=
 =?utf-8?B?RStZTHoxN2pjRXFONHRFa3lVWUo1YmdMbktNZTAxTWhWa3U0djJQZXBYRG9B?=
 =?utf-8?B?dXJReU9CRDJMUmUzNFJUSnhMcVN6NFdjb0VNMlY5MXhGS1hyR0JwUWpGMGdP?=
 =?utf-8?B?WmdWc0hyeFNaQ20vOXpzQ2RUcnBWYmhWaWZ2UW0xLzhhbTRobytDbDU2Mi94?=
 =?utf-8?B?Si9XVzVyNVVyaDJXNlNBNHVNYXE5RDFISlRDbUd4bGJNdXRkMXpLZ05NQ29D?=
 =?utf-8?B?MXIyR1RoMVlhZHk4ZGl2bGQyUDlCNDBGbzlwTHJzZ3ZNRm4wT0IvZjZ4MFYz?=
 =?utf-8?B?NC9PcXFhODFFUGw0dW1YZytkckhPZ2V0MGNaQk1vZ0psSnI4b0pDZ1BrL2Zq?=
 =?utf-8?B?NjQ1d0tsQmJrU2hyMERWMHhkc05VNU9JVGdHMUZ6bWpqWFZVa3RBU1hYUnBJ?=
 =?utf-8?B?blFSV0pnVFRJY3RuTnAxU0xMYW1lc3h0c2QvNjFhVE56M2lham01aXpUaGJX?=
 =?utf-8?B?UzRpY1FpaVFweEtKa3BtWEpBNUJRbHJUeE84UzBsNjRQSzhoMHlNUUZBM3ZL?=
 =?utf-8?B?OURIa0pxb0Y3WFEveGxnckxnNzJhbTVGQnBnOUpDSmp4WDUxencwQT09?=
X-Exchange-RoutingPolicyChecked: FbKSYVqSgUKsx00a6PUZdW5egrKL4QVgju8SfFKFmS5X1wLJwqIx5sOyH4ZFrvvZvWP0GvBTqcLsBclrPcs1zWKD0Bba78SDNeM+ghFu7HA/79QrncOwJYeqUeBleMiTVZCy/F21/Ca60N3p96iSGtMgByKdzOLGzE6RqF9db5BZurBriE05h86JrpKHEKPAfH94PiFdM7zagdV5hHLRw8tRD7spHnqiQtUAQqcQeoBf0wlonHkerhbGkiSKe0HrdJUFsDclvdKFM6lKXbt+BpvhKyLc04ESQt6pgn7yOnvb7M+dEm0xDNWgUX4u1A/SIkSZ8vr1DbsqadZFkfpp2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbe9e2a-d5fa-427d-7ad6-08de83448241
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5661.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 10:12:21.2556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eadovufZv4Df1Fl4j0w/bZ4m+icn+h3VgOg84Ud2ZM9kEQNdsvnddFigm3H8IqPzUaxa3PvOEtffR2FrxU5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
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


On 13-Mar-26 10:35 AM, Kevin Traynor wrote:
> glibc 2.42 has const-preserving functions.
>
> This leads to warnings when there is a const argument
> and an assignment to a non-const variable.
>
> Example with GCC 16.0.1 and glibc 2.43 on Fedora Rawhide (F45).
>
> /examples/ipsec-secgw/parser.c: In function ‘parse_ipv4_addr’:
> ../examples/ipsec-secgw/parser.c:53:13:
> warning: assignment discards ‘const’ qualifier from pointer target type
> [-Wdiscarded-qualifiers]
>     53 |         pch = strchr(token, '/');
>        |             ^
>
> Cc: stable@dpdk.org
>
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
