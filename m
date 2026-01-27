Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39762D2FED9
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 20:58:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35CC140F1A;
	Tue, 27 Jan 2026 21:58:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id ED73740E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 21:58:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769547527; x=1801083527;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=IKnWpyfFuEJGI4n6VMMHYrcBkSDm3THZijjqXfZxfu0=;
 b=NvvhZEJ8J+TC+7ihgoh8arRy0kMue7UQWKe9o+HafO6/UK8wwpgoyFUR
 IXdzXLtYoLcjTLFgC6fbh8hI2ibVWZYDI0L5vYYBXRBEIqaBw+S5vSubW
 XJ9fmDnRgmR1B8AYvz0MfepixJg65rktYXFrjD+f5WdymaHJOZdKpahDm
 26BmYVWZUSZzUZ4KJbaE3MKhFxs87qOGjeVj+gEVJg/R4bmtAZFuda6p3
 KHfq4Mt4BiRyv5QFEevth8avC0BmydHQApcoYgY/Q8kZilhp3bor/exdG
 hFXhv1H338XcGF9gSkc+tYp+iHHbY3Uk84f4Ly2aEBgrFLcFuIOyPmGEk w==;
X-CSE-ConnectionGUID: Lpb9ebC8TnahT6zBPCuZuQ==
X-CSE-MsgGUID: fGhCISYqS8yv9iObiEkcgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93412496"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; d="scan'208";a="93412496"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2026 12:58:46 -0800
X-CSE-ConnectionGUID: 2n64Fb6oQgu+VB3k0z5skg==
X-CSE-MsgGUID: mUlX+xQlRMiXPjcabqVFyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; d="scan'208";a="207214957"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2026 12:58:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 12:58:45 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 12:58:45 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 12:58:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAICteZqmtl4bbtMVY7/h3XMBZUOOslAubvqrdrsH3t+wqKwSszDqTQJbGAWc4k3EeCjNFrhwiuzzcvlixGBDVWmYlN8d9EAAs8U9r1Q1olmXiV/TSikoNrmg/YfQFb/nPvIn8EKWCF7I2u39Tgoyc/bWPUfxZOKan1KjJ6ZlXaWyTvEuCZO2DsFJVa9WsldKp4ptmw/vaSPElEOXZEIX1n/mmGGpPziNCgHB7pj3GKyShP+3I7vwrW42ZL6MfsqL/LhsxhSQofgdykVN8KTcewKxIrVEoAZe6xGX2zGY8II+ON/RgvdNDPpxf5xAboysFUmRLz9+8ooBsTl6AJ++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gXA+7PyCL9I72APhWwUB/5XY48uYMICXZDCOoHP2Aw=;
 b=FTU0uUZKqoRA1PgeXSrI2BPxbO/p6IoyPSMWXntYqiyoWBf8XZDx7WdD2ZwJO5bkPI54/EBLfGWlssgMyBIEBSuJCsiK6NrgWk3/Ll3U4hBdL1Qzk7uB5Ho8KOWKSTr3zUgrZEWS38iVyIcpOedzMX1k4bKo6Q4/Diyu9CPEuGDvJ2yj6A+h7G6E7V/TNQI1QPQWgx1Ynx1y4cb51vq2fIVQHcXaPutx21mcSEMAzV5JDBHNMBJMHzfDZPLPoSll0RWiuKpzrjirlYkJKkmUKPFu0+ePZzGxM4Q2b560QwCOczqdD0Vbwbj31noHOUhgIoju48ZN5aCPVWQZJWGmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DM4PR11MB6017.namprd11.prod.outlook.com (2603:10b6:8:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 20:58:42 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 20:58:42 +0000
Message-ID: <eaeaeb1b-16b1-42ed-9bba-69357833c9a4@intel.com>
Date: Tue, 27 Jan 2026 20:58:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/intel: improve Rx descriptor ring size checks
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251215173543.1707960-1-bruce.richardson@intel.com>
 <20251215184342.1722960-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20251215184342.1722960-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0028.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::33) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DM4PR11MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 233b96d0-7a53-44ee-cc03-08de5de6da58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFdobjltSzhkcnVWdEhJemViOE5EYVI0VHJIb2FkdU9jZEZNSThlUnNMbEJV?=
 =?utf-8?B?VHVITC9ZTk50VkJYUWQ1MDgwcHNiYVJFcHZFaFFVVDU2QjlqbjQrNlk4WFVm?=
 =?utf-8?B?VW5kTGRsemJ1UnZPdjRTY2crc1pMN09KVEF0dEZUUWNrVlVKV2kyZUZ6a0I0?=
 =?utf-8?B?MlVNMXNHV2Z1aE0vcmVNN05UQ2E1RjB1MmJVVW1RUUZiZ2JUd3QrZER1WW9V?=
 =?utf-8?B?WjZnMUxKSThRU2RJZ2Zhanp3anExN3Noc0RmbjA4WGpnbEVmZ2M1MEpEM3Vq?=
 =?utf-8?B?QWxTb0VUSHE5UzNYUnJpbTI3T2hHNjM0QzlYUGFHcWkyWDZlS1djcDJGTFJj?=
 =?utf-8?B?OEc0b0FBQk5PRU85Vk1iS2FZeUNmSUZ5YWI5V2ZhaUp6bG1nSFlHV0V1Q05H?=
 =?utf-8?B?c054NGRQUSt3Y1krdlNER2l3b1dnd0RYcG1wVXRnOWE0L2FrVDNFeHU4MVVR?=
 =?utf-8?B?S2JvZWZzdVpUc3ZkQ2FBdnBTUXE0VlNsdm55QkhJSjJJZXVHZnpDT0VDWVRv?=
 =?utf-8?B?NDczejJIclhPVzJ0Z1g0cEVlSTJaeGZOaFdmbVl3SU9EZWxMVEYzbFZVSUEz?=
 =?utf-8?B?a3ZiZGxpbStJQ1Fpc080UkNFV2xETC9Dc3FWRlB3TktSWC9zaHRnWUduSnVi?=
 =?utf-8?B?ZWdHMTlabVp5Z1dYZTBzNWJIV3kvaXNMeVZyWUwvekExVTh6VjdTd0lJcGV1?=
 =?utf-8?B?eXdENkdyaHdXdjY5RGIxaWZPVTA5RFJIVEpMRkc5em1rejhHRnBWR0pSQWpY?=
 =?utf-8?B?VzN5bkx0R3hVemZ1SzdibTJVNTAyTlFSdjlUQS9Fc3hBcGlabTN5Z2N4dG1k?=
 =?utf-8?B?bFFyUW9lU0hKZm5CbHJkK3FPSjg5elRzOW9qYWlvMm9Ram9OZ0E0K1l3K0VF?=
 =?utf-8?B?WVZwaUlYTjVsMlhoS0phT2JCa05Vb2pYM2VGZVZCU1pDaTJWV0JqbEs2SVpm?=
 =?utf-8?B?TU5LcTF2akVuTjY2TkdNemhzMmFvdlJ6ZWdhWEFBZ2ZzUWVvbU92T1VOckJG?=
 =?utf-8?B?Z0MzamNIazdrTENlUko0YUkwQ2VvTkRuZk1Hb3hKQitvWEd2ckNnWlFQUjRS?=
 =?utf-8?B?c0xZanF2S2p0cHRMUjJuTzluaVJHVWFhbG5nWW5Xa0pnbzFBeWMybzg4L1Nn?=
 =?utf-8?B?cmdPY2V1Nm1UQ1FNaWlKTndEaElPMTV6eU5ZVlBCYmUwaHhtVkxzOXVrbzBw?=
 =?utf-8?B?K3JVa0FpR3lzblo4SWtvbGhSaHJ1aTVLejJBWVU1T3B4TEdoRUptY25zRkkr?=
 =?utf-8?B?LytMQlpLNnBaK1NQWVdoYzk0b3RzMDYwdnVtYXBkU1cwQk11algrNmlnUVFi?=
 =?utf-8?B?Y1JCaHRObGlBaEpWZHdvMGNvNFVrMlZpVFFVaXVVbFBXQnoybFpKM3hsNzNa?=
 =?utf-8?B?M1lZMmMyTUx1Kzh5NnZsbFUxRElPMWtpSXRsd0lRTEJxN0k0dFFKbGhBaWRC?=
 =?utf-8?B?aWJDTVR3Y25VaU5ZY1g1b2dKcW1kUW9pYVcxVWdwazZLVk1YUWFjYTV3TWh4?=
 =?utf-8?B?eTlrcS8wdmpMVkpNcXBSZ1FmSFNPZDVaKy90OWVLYWRzQkVYVDUxcUh3dEJ4?=
 =?utf-8?B?QkhWRlF4aDVrVzZNQ0pycUZYRVgxY25mQjdIYmhaS3ltTnV5L2h2dGo3UHA2?=
 =?utf-8?B?R3ZhejZId3QzeVBIYW5KSzZ5MDdmZjM1bEh1dDAyTVVjdFhUclhiT0V0czVD?=
 =?utf-8?B?amd3SFdOdXQyVldwMWNGaURNbi9id1V5ZnBxVUhzaHNTaC9ONHJsQjBycUtZ?=
 =?utf-8?B?bjV3U3dtQW8wTTJ5cHlQcjZVbXA2bU14dU1hNENPR3NMbFpEZGhWOXB6TFN4?=
 =?utf-8?B?QnVOYkl0eXlEMDQ2SlpjOFArRCtuRjlsTUNXeEY3MUYzZ2VDenc2TzVHdFJS?=
 =?utf-8?B?TGFVRzdQVWxlZ2R2RGpoY2V6ZG04cHdtVFRBU2FMTysyVldxdkVtM2JpRmQw?=
 =?utf-8?B?Q1FKVDl3Y3h2T252WDA2VnlSQlVXM2dJTWdVLzN3SDJ3QTY0eXd6cmQrT081?=
 =?utf-8?B?WmFDd2xzT3pKcmtVZmJLL0ZEQVpSUHpBSVdzaWMyU1RZMDY5eWgvQTdTTDdo?=
 =?utf-8?B?V1pCcnFkTmdPRFpYdWk4eEJUV3JMQ2xhT0luZytZcUJ3cEwxOHhLRnZKRGJ0?=
 =?utf-8?Q?7W/Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnJWWGdjSkQ5U0dRY2ZRSHp1bDJXOUx4TzExQklVUUMvMFVEZ2RMSWN1ZERH?=
 =?utf-8?B?OElZOExhb2pKREpLUWpiZTFuTVdqTExFcWNmb1NPNjBoS2JXTFRRWjRON2xK?=
 =?utf-8?B?cVljaHJIcFF1V1JYemZIRkpja3FzVkJGYmY0WEptRVpMQ2Y4c1g5cHkxOUJZ?=
 =?utf-8?B?VUg5dGZQRnNWQ0xVdG1NZHRKZFFoQ2xZQnhobU1QcklQN2UvUktJUkJFMEtH?=
 =?utf-8?B?K2FxK0xBeHA1ci90dk1sd0hUMTNSVGU2NlpENHRKQzJ1ejZpMldpeEZhV3V4?=
 =?utf-8?B?MFVweVNnNU9IcEMwTWNMYlliQWE5allVZS82a09weTkxbHZGOVpKbGhld1Bv?=
 =?utf-8?B?eHA1VUpyWTZZYnZJOVdIUmdPa3lZY20xSnBYNEp6eTRmNkdvRFJ2Y25VQTgx?=
 =?utf-8?B?Y2FFSDBPRWJESjNJRHNwK1U3dWNmUmRldkJGSjNEcU03emFmVGt3aGFQQ2xT?=
 =?utf-8?B?Rlg1SDgxcWlqOXNsRUhwUDRTSWhESXFzck9pZlpWOVRtSVd3Z1BZVS9Xa3Rt?=
 =?utf-8?B?WVptSW9TNWF3NmRucnViTUY2cmlaTEY0bTk4LzVBREl0OEhCV1RlUVZZOUJI?=
 =?utf-8?B?Y2NjNmx0SERPQTdLRThXTnhoU0NnU05ucHZ1dVhxbmhJTkRJdDN4UHd6QWJH?=
 =?utf-8?B?YkFSUnpERXh3b05ZdHB6bVY1SmJ6T0pvUWxNeVVIU2tHMGs5M3hqSHFmZThW?=
 =?utf-8?B?WVEvcTlZOHNialZSZVhxQmRRZytVc0ZlRytEdUlTQ0hqZFVmcTVlcjNtVFRH?=
 =?utf-8?B?Y1BmYlZrV0QxM0RseTlBajJRRFVNL1RPQTdQYVRRN0cxUm1KbWxyc2UrNWpN?=
 =?utf-8?B?SkdwaEQvcHhDNXl0RCsvSDZMamsvYlpQdHJOaGFhUkxOc1pEL1NmTDhWenN3?=
 =?utf-8?B?RHVjTkxWQmtvYmtBWW5yV0YzcVhqbDFTeDkwYlhHSFVwTG1xVUJUNzBDSzUy?=
 =?utf-8?B?QXQvWFhxYWIzVE92ZjcrQUJWeUN0VGN3dWNZK25ad2QzZHBINEF2UVhaUlFX?=
 =?utf-8?B?TUdMdmVwRTNUL2VYdWxPSE9jZldqRGlvWVRGbXg1YVdrRWlsSWc0T0tPVkFL?=
 =?utf-8?B?UkRQTnZPUVB5WkdOMWJRRUYyZUl1OFlIWVlLTm12UkxpWmxkT2RFV0tXaWdD?=
 =?utf-8?B?RWRCNHRMdGxOaEltS3hpckhDY0ZuTVBoNUtOOFdzZStvdHI2VmRQZjlCUFN3?=
 =?utf-8?B?VmNVbU5kblFvTWN2YzJnY0JFMjNOOFVpbGIwSmhpclYvNkJHVkJYMUhXbytY?=
 =?utf-8?B?YXFGQm53aVpWclVnQ3ZsbDRzQ3U2NEJwYXRXUXhpZ2NaaUo2S1RveFJ1Zjlk?=
 =?utf-8?B?Z1FtcldnVDBDNmZJSFZnYkxvcUx4bzBvMVU2N0ZLVFNYemU3UDJsMVg5RVRY?=
 =?utf-8?B?Y216ejhJdkJ1MHlFWWs3TUdvRTRRQUlJTk9OY0NpS2UxL1RzN0l1QlYreVZw?=
 =?utf-8?B?ZEc4WGtCODdnaWsyd2R6UlU5bE5QdXdGSFJWTkEybklPdWxNMDdPL0FpNU1V?=
 =?utf-8?B?NElvbHFqa2ltM0lZMld6M091Q0xHRm5KU2VNcStQVFZKVTI3alZzQU1zY0RK?=
 =?utf-8?B?Q2N2b2xVKytpUlAxYitZWFNhNExBSXpwZ2M0S1lsOERia0lHQjY3THZuTHU5?=
 =?utf-8?B?bzgwWk8ybFFPRytZajdXWDFlVE9YUVMwNG1MazB3SndxV1lLYmIwOGt2VG9t?=
 =?utf-8?B?MWNJZ3hkNi9Xc0dsdkhXZHdobW9mSEdpZFVxcWV4TnhYQjc3VGZXMVlncmxy?=
 =?utf-8?B?N2dhQytuMjdDTUxhNmJJelRvTW9tUWhyVDAvb1hlWmcvT0FLdWg3WUV1SWRk?=
 =?utf-8?B?YXM2aVVwMDFwOWI2Lytpb0tmOStFd0xoQkVUU1RjZmhJZDRIcDhaMXdmWFdo?=
 =?utf-8?B?WER4cEpRWmdmeldRd1lDbTcyNlFGRHNQY3o0MTFCeVdhRFo5bkRaU3d1dEZj?=
 =?utf-8?B?RFo0b0NnaHVrYnJaTVZxelBaMCt2VHplRTlHSmpoVHpSdmF3aEJhR1EzUURk?=
 =?utf-8?B?NlpzZnVYWG56aG54MGtDZ2JkNms0Q2RSc2lCdlRxNWV5QWVpOTRUOHl3MHUw?=
 =?utf-8?B?UEIxUVdFTFdIcVBJdUNDZnd5L0NlQXdETzdDRWNVTlliK0tlQmxVbTVxZGE1?=
 =?utf-8?B?YVZxb1ppTTBqdU81dENvdTdOQi8vMFBlZEVOaFFjU3NqbHBHK3RMbDJQaVNY?=
 =?utf-8?B?a2o5ZkVtUVJaUUpRZEVhb2VvNk96dTY2UkwvbVhockh6dmR3ZXNYQ2l6T2FD?=
 =?utf-8?B?eTlESmFxRU5zYUROQ1E2anpRSVJsbUZXM3NzTDJ2d0U3SFgwL1d5YUlsSXha?=
 =?utf-8?B?SXJnOGtyampwNHhGRTJ0cjJWWGJBSjEzcXVnT09CM3FDL1NRM0pONEVNZ0JE?=
 =?utf-8?Q?KSVHXHrsq/UpbFS4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 233b96d0-7a53-44ee-cc03-08de5de6da58
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 20:58:42.2367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfGUF+zhm13Pa6ME1tjZzzzMwpkOjCBQEeOn9wriU75nnbXizlqtu5E3F+kSBCH4fUyrbHrYAEUwpTlKwGOXxnouIaxUuPIJpJL/H01fCqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6017
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

On 12/15/2025 6:43 PM, Bruce Richardson wrote:
> The default Rx ring size checks did not account for the fact that the
> port would not work correctly if the Rx ring size was only twice the
> free threshold size or less, so add in a new check for this. This would
> generally only apply in cases where very small rings sizes are being
> used, for example, with default Rx free thresh of 32, only ring size of
> 64 would cause issues.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v2: add in extra error message for the small queue size case, to help
>      make users aware of what setting they need to use to fix things.
> ---
>   drivers/net/intel/cpfl/cpfl_rxtx.c   | 10 ++++++++++
>   drivers/net/intel/i40e/i40e_rxtx.c   | 10 ++++++++++
>   drivers/net/intel/iavf/iavf_rxtx.c   | 23 ++++++++---------------
>   drivers/net/intel/ice/ice_rxtx.c     | 10 ++++++++++
>   drivers/net/intel/idpf/idpf_rxtx.c   | 10 ++++++++++
>   drivers/net/intel/ixgbe/ixgbe_rxtx.c | 10 ++++++++++
>   6 files changed, 58 insertions(+), 15 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

