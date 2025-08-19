Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89533CA0EED
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 09:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 905D740297;
	Tue, 19 Aug 2025 11:04:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id A3C6C40289
 for <dev@dpdk.org>; Tue, 19 Aug 2025 11:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755594267; x=1787130267;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=r/iudqTnxHUYuCVCSVfx/qZLfvRnhTPNBDtQ4V6YlHU=;
 b=GLqQyusMST3LdI0wXBikA2Yg36G6mJ2nglaadl9w2pXg7u8ZUBZwAXAz
 QHFCyJbK6k9/vTAi7sHESeTW1PYfNt5KsifXI4q1HDhAlPCrLzp7tuijw
 q4G7K8dnM3npq0u9iYdC1b3+C3sB82a3J8+F0zostxZBru6qm1wCNGsDo
 G5PlByQu86e7FGwN7nnlA6tqZCf3NL9wjk/f+JozKViGchwB6+RRxUP1P
 atw4wUqPk21rgtC1eyjKskX/ruU7G10iHWwfTkAfqxjB11koJ3JLsB8Oy
 rMvg+gYuHJzsfVcMl6sObUYQmNNYbT6WrC0Mb0P58N4qZG/ZBoUBM4Dy0 Q==;
X-CSE-ConnectionGUID: CS9vhjxxQgqzsndIMxs7pw==
X-CSE-MsgGUID: lj2cxWuxS0y6y5G9BQILjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57036543"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="57036543"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 02:04:26 -0700
X-CSE-ConnectionGUID: GtnVsrMoRzKrsZOkvAzglg==
X-CSE-MsgGUID: l9r3ErlqS1e/dWl+S1U/fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="168040738"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 02:04:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 02:04:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 02:04:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 02:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9OtqdLKFhC/fsQiUl/Qh0eBYDFWae042iXr/Z22bKRiZMIjuzOKPsFiN4LoQ8kLLZUGTs740xQ7nv5sNu48zNeM/uqILQUuuch9EbUo1C6jVaUYIBDou1jaRWL89AdPvKncqxFqnCd/h4HFfFDY4daG9Qlu2vJDVinI/wax3vsJStXpBSS33Q5s7I5+Z4R9x6Z5o4m9zpwz+2pra8k+3FA1tSCXOfaKoaphjKznzndtjPd4JlHz0htE9+fIMcjuJrZOBCXHjEr5mmWpVmRhDrxOvnbjV9NDabpVWdhqnJJ/GJeOlJqkXcoKrGttRRiYLoBKpzmL5Q90V62nEmOr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBUz5bFrHSFAbJAttpbnmcanm+lP89L0+BXtOhsWqWk=;
 b=BIZTH3CjzyYvz7nv/y4jnBdBQskKadjm3XO0lPj6MAW8veckx5ClOnJ/fec1yBiERj07OTsUPqkzfPHO7CMJwrXPpmNnxgbSnUF1u5GG2PUKCMKKBPBDoCq2Ul5PgwcaWUnKkQUtwalGZIBtU+As24xbxlD9HY+whbBE9cw79jUMfy1rXOARsHlJLO1ptcWnW2lOSBEe9KhTkjWs3K21ifqwca9UBWcJ8D7wn4nQWiAro3Zjgn0u6ybDVZ9Y3yivx4chLUJEs5UHGAqfi5afYBYc92yC1bDp1Y+QPAwNxQdXABoJRtXeHQNYue7/erdRqar+CJO9FGL9lQB7SdSxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:04:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 09:04:23 +0000
Date: Tue, 19 Aug 2025 10:04:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] build: remove obsolete compiler checks
Message-ID: <aKQ-Ezy_JONJf9jN@bricha3-mobl1.ger.corp.intel.com>
References: <20250718121402.856265-1-bruce.richardson@intel.com>
 <20250725160730.18354-1-bruce.richardson@intel.com>
 <CAJFAV8xObjjfq5zFce_kT_ZhsPhiXzixXEdT+G-Mi8OV77sssw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xObjjfq5zFce_kT_ZhsPhiXzixXEdT+G-Mi8OV77sssw@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 00bb7a64-dced-4641-ec64-08dddeff63c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z09tZU1RcXJwUElpeVErbndtMGlCSElZZGxBNUFhVWc4WVRCVVdzVm0zbjh0?=
 =?utf-8?B?UXRXVm9VVzIwRG11S1lLcVlBWlJNRDZHL0NDYUsrKzdtRjBTdE10WUJ4MUVB?=
 =?utf-8?B?WWEzNitnbS90MTdrUU50dUpBNlNDa3BwUHkwaEg0MGNiRnprUlludDRSOGhy?=
 =?utf-8?B?eEJZaStKVkdPTVp3U3ZGeVhYL29HNEVHczV4VDRrZjI0OGpiRS9NU1UzZUN6?=
 =?utf-8?B?bjA1WVBrRTVZUTNaeml4dHpWR2dEbkFsaTAyL3RLNThmRVNBQm1ra2FqV295?=
 =?utf-8?B?ZGJlOG9NUkNlN1VCbXg2bkVJMndsTVhDKyt4MGFYa2k4TDVJcTd2VDM5eG9w?=
 =?utf-8?B?MEZPZ0NxcTg2UmxxU250bDF4QTZZOTBtaThyMkZ0OTdlL2lDanQ2dFJRQTB0?=
 =?utf-8?B?M0ozTVdUY3dlbkd1TFJIeHh6VG1nNDB6ckhiNHZLR0RwTmo0Mlo4U3ZEL2dT?=
 =?utf-8?B?ck5SN3VMQ2dEWmpLU3JZY2tJSVQxaE9OVXNYRUdNM2R2ckdxWHVCSlkvb3c5?=
 =?utf-8?B?aXcxQzlsVGJ2ZHJscHBwbW9RbTlQWFBzTXlkUlVTK1dHRExFZmZPZHM1MjZa?=
 =?utf-8?B?bjZubkNpMzN0aVErYlE1enRPQVJScnJPR3VGWHZkYTYrUlI5TkdDcGN5ZkU4?=
 =?utf-8?B?WWVuSzI3YjdDVkFqWXZHQmxiY0pDc1k1dmlpL3ZtcjJZcUVwQmhoek83Rkhv?=
 =?utf-8?B?eFZTcFpYdnBWV1EybkRvQ3pZYmQyamxNU2oyUm1sZzVqSXJ0UXZKYkFiK0tW?=
 =?utf-8?B?UHdkcEc0Q21WZWFRMlFRMHBhVzRHc1JoUlZETEo0OWlZUHpTVmFSZWZCZW82?=
 =?utf-8?B?bmU3VzdFcUNJOFRsR0dIcWlLN1cwMDVlbXJBN0xCMzNwdHBwN3ZQRXZMM1Bx?=
 =?utf-8?B?d3QrT3NISEZ1TXNXajBGTXB5SFhXYXNzUmF3M256RVNaWlZIaEdVYVRlOFgy?=
 =?utf-8?B?djBjbi9HRFdRa2hzZ3JFL3BTdFRkVUpPUkVRdldhaThWM2lETWR0Yi9BTGx2?=
 =?utf-8?B?L3BOSUMwZ0tQSE01dDVaMFVPR00xMmdnSDJkUkJZaXJ6ZjZZeTJ3MDBIbTVH?=
 =?utf-8?B?QVdPOHUxcm5hYlVJZC8wcXNiSXFOVVljSHRTb09ibHlpNEV0MDJwa0Q3b0ZH?=
 =?utf-8?B?NnBoZWhaTFErVW9yWnZBZmtORVJCVFQyNi9nWkJFTFpuaEFFNElqajlRbkY2?=
 =?utf-8?B?amhUZDZkWkNPc1czaWtlV1ArMDBCc09oaWw3RFArdTFSVVdIQlZycE80VnJr?=
 =?utf-8?B?ZlUrUkhTV0NrL1lnTlhOM1RDbzQwLzVJb0RQcWhGU0hreml5NGk2cWlkelc0?=
 =?utf-8?B?M2FuWDJDOG1EOWw3dzBiK25LK0hUSE1jMjRqZ2dabkRNZUdPZGtOK2VRcEJM?=
 =?utf-8?B?UG8xaDBseE96MVk0eGh5bkVhMlcvVXRVblNYTE8vQXVJY1JVUHlsdDdpK05j?=
 =?utf-8?B?Vys1RkJGcThwTEtGRFdZZ3VmTWR2NEFmcmhqZHlGS2g1dkdBOVlBNWVEOHJJ?=
 =?utf-8?B?M2VTd3lvQnNyUko5WnIxdnkxMlA5bE4yMnlwLzQ4Tk14OUJWcEFadm80WE8y?=
 =?utf-8?B?WEsyZVpmK09GZFYwaFYvbjh0Y0V1ZTZ0ckNoWHZndWZjQkhHTVdPdnFVKzI2?=
 =?utf-8?B?SUx6aG9pdXlUUXRhZll0dlY4NjhUZUNoL2xNU2FWK2dCZXdSbU9peTJNMXZ3?=
 =?utf-8?B?eVBPaUVwRVBFa2ROOGlraUUyTEQrV2tmNnR4bkYvQjFzOU5NS3IzL2pqTlJL?=
 =?utf-8?B?VHhUaDAyeVQ4TzRNWnlXNmdwdGcyRXoxNTRrdmVVZVZaNnlqQ0hEWjlRcGla?=
 =?utf-8?B?a3ZjRE55eTRYbTM4M3ZzQmVadVoya2c3RWNHVjRUTXRVS2YzTjR2NHhDMCtI?=
 =?utf-8?B?MGdoU2FXaFJ5NEV6ZGhkWExPdWlsZDNhZkdPVzlDTk1uaEF3TUgvWjlVYS9F?=
 =?utf-8?Q?GoG6tjZbup0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anF4SEUrSGp0Sk9rQWp1amRaNXBkUGl3Q1BQVlV6R2VNVEZsUTdGdWRVazhD?=
 =?utf-8?B?ZWdacllYN1B0bFh3VURSM1J2S2JoVXFTSEluNy9ncG5hOE9uV3VzbDdnMzhL?=
 =?utf-8?B?cVQ4V0ZQZ2ZvMnFCbGxybUoya2lSWnE4bUZoSVZFejdSRFRVRlhYY2d3Tzgx?=
 =?utf-8?B?N1JYSVFjMWxxYU0rTUlCd2FCMG5YZjlNUElabHpRMFZ6MnlaWWdQWlhaaXhj?=
 =?utf-8?B?a1BLMDh3TUhTNFA3dzhlaks5WUcwT0ZrYjk4eFNpRFZleVV3VUpKOFdYL2lz?=
 =?utf-8?B?MTEwY29QY21GTTl1U0RQSnUrL1BTQXRXWlkwZndPWFRiS0xEMWxDdGtiQm1B?=
 =?utf-8?B?dUJHQkZMRFgyN1hiM1ZtMHUzRnBKYXU4UTQrbmk3d1k4eUxadDRFOW1JZDFx?=
 =?utf-8?B?VGxBUlYyK2R6V1VtK21pU2M0c2l5UjBFY0JNdER1VkpmM2FXaFM0a01DRXM5?=
 =?utf-8?B?UnhmQWhvOXo0MERCK0d3RTBqeHJhVGQ0TkxYcHpFcHBZK1lzY2RBbUkvQ0du?=
 =?utf-8?B?YmRUdU9kOVI2K3FWRGdHam9nQzlvOVdMa0F6bCt4SGZ3Y3JtRDJtL1hHSkFy?=
 =?utf-8?B?ZVdTYjMxSzNnaWVEbkxLWk55QmJMN0crdWpwMFZXbmJmYy9kcHgvQ0NmUjFK?=
 =?utf-8?B?RTNaZlRPZXphTkdMU0dTNmxYaFlWSloyd2F1RlUyYkpzQjB1WHB4empKeWM4?=
 =?utf-8?B?SnlTSjNGZ3dvcVkvZlV2UEQ1YlF0L2pZajcrSjBmTXBXZHlFK25WaUI1RzA0?=
 =?utf-8?B?OEdTb1VFUVdJczZqeWtnYU1nMFJQZndsK2lnR2crUUtMcng2WkYvQ3Y2TnVi?=
 =?utf-8?B?RXpFbmY5TStLeEVDN0xkUzBVOFk3TzhHWDF6by9Tb1BqVE1EL21VSUYxNXAy?=
 =?utf-8?B?RU1mK0lnUnRtcDUvWUFHeVFBLzNNUzZnZTN0dWd1RC8rNXVoaTlGbmYxUzVV?=
 =?utf-8?B?WjJEempYSDFxUTF2amQxQjJ0emQydUR4QnI1a1BHT1ZQdGJZTDhic1Vqa0xt?=
 =?utf-8?B?RFpxN0tNQ2RZOHNlcFVPK1BSTnhocnI5UVlWVHA1MFoxNHdJZHhrS1hpUEtD?=
 =?utf-8?B?NGpsbm1rT3RMbktINFlTcmZsSSsvN0ZVVnk2cU93eTZCYWI0MHBEelZLUmY2?=
 =?utf-8?B?MDA0YzhqQ0hINFVMcElGeklmTytEYlFmN1dDM1QzdGh5QWZCNElBOXVjRnVy?=
 =?utf-8?B?SnUrOWYyRkZOb1EvWTZONG14TnN1U1dkbEJUdnlDaGFSZk1RdTNFcGVUeUhY?=
 =?utf-8?B?eUNYMXNPaGpxMjN2NURIa1QwUmhVak9qS0tkTVpJSWlOSDhtZms3UGwwWHor?=
 =?utf-8?B?cFN2eUxvWVRmTFY0Y3Z0OXVvK0ZkUUplMW9tak1KMEE1Ni9IZy84NU5MbWow?=
 =?utf-8?B?TEJaWG05ZGJQbGxjU1ZYTnhWWkdiMGxGNWxRUDA5aVdzQzlyTFNlYXl1Q092?=
 =?utf-8?B?cHY3UlpBaVNRTXFzTFZhU3drKzc2Zk5CdVMxQ2FldUdZMlQwUzdVL3Yvd043?=
 =?utf-8?B?TndiUzA2am1ZLzJOUUw1Rzd6VmsyanRHVURvaERlTExtdmYwZFNlaEt1ak4z?=
 =?utf-8?B?WW5SUmpQbGlJd2pvQ0ZRN3BjQ01Eb1o1WS9SeHhtMXlZVFIwNzFOdEE5WlIr?=
 =?utf-8?B?ZUJWQTFMN2Fmc1hrWmZtaXFibnpyenBqRjhXbHoydEpubml6V3EreVJxSC9J?=
 =?utf-8?B?THg2R2NMYkxXRmd1bnN1TnFuR2xOeWltNjZMY0w2VTFpelhlc29FNG9lb0sv?=
 =?utf-8?B?eVV1UFRwU2hYNTRvU1ZVSG5NTnNJdGtTWE1ONnJxb2RQVDR0UzdPZUVUa0lp?=
 =?utf-8?B?MlZsaHZtZjR0MDJNckFnQ2k1VVowczg0Q040S1dsb3YzMVBiUEF6bzVEUnVW?=
 =?utf-8?B?RWw2MTR6YmNqRk9tL1FKcDlsMHN2OXpHWHZreFBiOXo5NlhPTUlVdjJDQ0k5?=
 =?utf-8?B?MURPT2gzRlBKbG5udDYvUXBVcjIrcmJOQ1ZpZkcxem5DVGtHZDREd1NuRk9K?=
 =?utf-8?B?Q29iTEdxWXZqZUFYWkZWa1FmNG5OQzJhSFYyblpOTTNTV3ZDT1FEcTZHV1pJ?=
 =?utf-8?B?WXgxWWhwRUtkYlpBUTlLMndCcTBXSTEvVktyOWJ4Vi9kZDJlNmtjQWpnWVJS?=
 =?utf-8?B?YkJnMFU3QkVoNmh5MDRIZFJrL2lDbytaeWQ5b3d5R1dvL0MxNDlIVS9xcEZo?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bb7a64-dced-4641-ec64-08dddeff63c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:04:23.0843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voBJbnpl3/8VSPfip+DePvE5D55vDhbIMMcj6rDTVcLfiAxr1h0wA00t8Zcvolo/euBzVZIr1NBSS0d5H7JAaE263fZ3Yr2aqSY1AnBlDvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
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

On Tue, Aug 19, 2025 at 10:10:21AM +0200, David Marchand wrote:
> Hello Bruce,
> 
> On Fri, Jul 25, 2025 at 6:07 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
> > index d3caa3a3b4..a9ff87e863 100644
> > --- a/drivers/net/virtio/meson.build
> > +++ b/drivers/net/virtio/meson.build
> > @@ -31,7 +31,7 @@ if arch_subdir == 'x86'
> >          sources_avx512 += files('virtio_rxtx_packed.c')
> >          if (toolchain == 'gcc' and cc.version().version_compare('>=8.3.0'))
> >              cflags += '-DVIRTIO_GCC_UNROLL_PRAGMA'
> > -        elif (toolchain == 'clang' and cc.version().version_compare('>=3.7.0'))
> > +        elif (toolchain == 'clang')
> >              cflags += '-DVIRTIO_CLANG_UNROLL_PRAGMA'
> >          endif
> >      endif
> 
> [snip]
> 
> > diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
> > index 9c6325aa0e..a74d0cff7c 100644
> > --- a/lib/vhost/meson.build
> > +++ b/lib/vhost/meson.build
> > @@ -8,9 +8,9 @@ endif
> >  if has_libnuma
> >      dpdk_conf.set10('RTE_LIBRTE_VHOST_NUMA', true)
> >  endif
> > -if (toolchain == 'gcc' and cc.version().version_compare('>=8.3.0'))
> > +if (toolchain == 'gcc')
> >      cflags += '-DVHOST_GCC_UNROLL_PRAGMA'
> > -elif (toolchain == 'clang' and cc.version().version_compare('>=3.7.0'))
> > +elif (toolchain == 'clang')
> >      cflags += '-DVHOST_CLANG_UNROLL_PRAGMA'
> >  endif
> >  dpdk_conf.set('RTE_LIBRTE_VHOST_POSTCOPY', cc.has_header('linux/userfaultfd.h'))
> 
> Sorry, I did not notice in the v1, but lib/vhost and
> drivers/net/virtio have the same construct, yet only lib/vhost gets
> updated on the gcc version check in this patch.
> Is this intentional?

Not that I remember, I seem to have missed that.

> 
> Since GCC 8.0+ is recommended, I would keep the version check in both
> vhost and net/virtio.

I think I actually checked this out, and decided that it was ok to drop the
check. I will reconfirm that, see how this is used and if it really
needs 8.3 GCC.

> 
> Other than this, it lgtm.
> Reviewed-by: David Marchand <david.marchand@redhat.com>
> 
> 
> -- 
> David Marchand
> 
