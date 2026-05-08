Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97443CD3436
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 07:42:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BC3740268;
	Fri,  8 May 2026 09:41:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5CFE04013F
 for <dev@dpdk.org>; Fri,  8 May 2026 09:41:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778226118; x=1809762118;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=YwGw2wqPuO7ChgATSh8luojsI+rtFg8uNsRBj0K+Bkc=;
 b=H/OeqPFeLan8LWK6kX/7W5h61b4KNywpqM7dmhyeckQaRqm9VRNsBl/7
 j/OSBBgHJTn33Cjyq5MOJDvTYktASD8941UPdxaquFb2xv4iLc8mKYgOO
 KD3EPVKy2+Dw35rUnIqcQAnn7AD95K6neEu2hprCp7DDFMLfZVAd7Cx/3
 PTVv+0XCb3y3TigWbwGn5bLEeDrX++UF9PizY66dXFR5I6Wkv3o1dgvWp
 DgWo7iya80J0IdfxAktZoQkvsQIqlYu9UXzi1UiShI00PjBeUXhrVnwmO
 PEPSbTaI+6aePJGT+fWR6H8a0izDjYDVd6FgOt8jDXeV1UEPm29yhYVwp A==;
X-CSE-ConnectionGUID: H6b3tQA2RGC0Gdl9jS/uYA==
X-CSE-MsgGUID: ob20TLfTSJmuu+VPGaUwnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90568602"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="90568602"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 00:41:56 -0700
X-CSE-ConnectionGUID: bJODAqMtSAOlBpCx9RQ2cQ==
X-CSE-MsgGUID: 5BqRs2iESYmeMoQnOqTj6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="241045312"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 00:41:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 00:41:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 00:41:55 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 00:41:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtzfoJH6kdPRlSntyugLwnN0CmfcQsnAVV2QEjkqp3iYr7adeFiQOgnnT4YEiEN1VVWwlJMk/FCBo2A+zYM9ZQwam3VSy+rSUM5h+yXjat11nNHnEGPSJ5ZkyU78uxrMfvBrtAifBzkJJho/G02radMOJzSxTPLW+nmYcCokJRC7AI+mXjy317uzG0yNLW8DIInw1zQoli54/JuSx3a7b1vixjUgtuN3Sbo/ehR+969VIau3KKmytsg4jn5zaH9heizedh7AUZNuQrbPJHW7QM48PpeIxvWNaGS4dGcIdxb9Juty2GYcqJq3hI3yLqUYbYwJ26QMYk4SkKepGABSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwGw2wqPuO7ChgATSh8luojsI+rtFg8uNsRBj0K+Bkc=;
 b=WrXzFWjy3lM5V+s8nNlHACAHYy8yPQ9Z/WCRhEgFWpQl9csLa3n+p/cQ6MnLVEV47DuU1BKAGEQiox3v7V73l/vmx0z36TY6i11v2JwRsWx6Ot/v4ns9BzktbQrdldEk3oTqiB3otu4lU2qaIHIhkTyQuaRJHGP8/ey0zfJ1/2552foLue/xrVj2QmoB1bYbo2SeUw6gOZ1/wdDBZvSYPFsk5T7j/dE36J4NCIypFo66tJzFtCLH3PkrSGsb/KeJrYpR4omjEQJrP2CMJQc2rbEEqOjCyFLiHjH0dXGnudqV8PhWSFNiZbmpTg6ETnvaKn3DysIDvI2DrsIBRI95Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN6PR11MB8169.namprd11.prod.outlook.com (2603:10b6:208:47d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 07:41:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Fri, 8 May 2026
 07:41:47 +0000
Date: Fri, 8 May 2026 08:41:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Alex Michael <amanjakunnel@icloud.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 6/6] cmdline: add null checks for invalid input
Message-ID: <af2Tt6lCrIkWaUNc@bricha3-mobl1.ger.corp.intel.com>
References: <71F56436-5745-4CE1-93CD-8136788E6546@icloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71F56436-5745-4CE1-93CD-8136788E6546@icloud.com>
X-ClientProxiedBy: DUZP191CA0068.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN6PR11MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cb5df0-db72-44ae-d064-08deacd54259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: zuwWV9Y6blb+0U4lLdrUZQzhib9jm5YTruc39VxJ2QtO38QE9eC7HdvZuk0ZbnzUpFHbaAADv9EjUCx6eyjOUQz6ByOeyNIzIhTOoDAjUijGoCmW7LfLW7e86RK6b7Uj/xmbc0356s+Vz5jADbsG8fFEsz1wu+pjrjdfHyRO3TwiSmHe3AQRXVgk/KM5yFWRuYBHBgpR824NkiUmOUK0f9nACcAGvjmDgMbYPuCicxAsDRJ9Pj/hvRlIDtUSWyK0gCGRafogsieicZ98bclDoLp4RJw5r0n4XQwgcUE56YkeZ7YYfWGQ5MtdE3KeekN5lME5re5WZlJZwmmV0ofram3E7OMIwr52QjjD57QIxmaNCXLkFM9o4VY3PCGujg4/Hh460H61VfUZDJnUdGZba65/Yi0I0/mFyOaBqcaeogYu2K+AhsvmfJc0c1AvfR/mvmtPlbnO93szaZr73D5WpygTlEWNwmWRV3c4lujMc7d4kC7yKX/nsHLlOf/Z4v7aAq9/Kv7fyCXcWbxDflMm6giUOwPv8dHreAzXhp/uqM7s002ijD8LrPyuh0dt1iCBRbxzqTakJHLMpV4NupbAyOGHe7XnuwmgwJnN+mrCBIvtkr2Am6XiFle1kDXOZroM5pyQ7a3TMM7VbqN5AXHcZKNITsTv+R/sZ/+NkFsRdFukPfKJCjuwaebcqdZD8SAR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjNNVWsyQ1lWMDFPS3NORFNTUmxHR1R6RXEyZXRVbFdJNTN0N2ZBbVF4QWlx?=
 =?utf-8?B?TTlDZHlxMWtKdzg2eEtkak8zdUtSbitOaG1Oc2JMa2UrSjhFbzZOQytQVGcr?=
 =?utf-8?B?UTk0ZWpjTEo0RXBER0xYN3BlY1hPMy8wWnVJVHE4UmNmdk5FdVVhekVKbUJZ?=
 =?utf-8?B?QllqcjJYSC9zNWR3NlJtOVUrMmwvbTRXU0NpYnowR3ZKYmd2MEVpYVR5ekQ0?=
 =?utf-8?B?VW5scSs2MkZDcGgveGxqbHlIZHZuZGQ3QTlSOWM0SDVnSUROckFTUnU1T2hO?=
 =?utf-8?B?eWhqRzIxQzd2MFByQWdWSXdNRXk3djNUaGxmdHYwZjFHMklxVzlmQXUxY2JL?=
 =?utf-8?B?VEFpTnUwbHhzSGhjUTdJby9EdzZOQUJOYjlHUDVJSVlIaVZubFIzczBjTmlF?=
 =?utf-8?B?Yi8vZE1kQ1pUQUJYYWJGa2NrTGxSNkhaaEkyY0N1cmNOdk42TTJ1M3JleEdH?=
 =?utf-8?B?TGdDMzBSSEEzWXJTc1Nrd2ZhUVRUUTVHUWRuSVhPeHRvQWFuK1gyb2tyZ3pY?=
 =?utf-8?B?QkRjUW1HR3ZIa1RLL2NEUThHNFpXOFdVU2RDQnEvcWJxT0preE53a1RYTTRJ?=
 =?utf-8?B?azBHSktoV25IYlRiMngza2RwZFlLajNvbVRkRjhod1JQczc2WmltbjM4aWhn?=
 =?utf-8?B?K3M2eW9LL1drVW5rTnU0OStDQWlMWEZOTDNoZ09GNzlQOHQ2THp0bmttOEVP?=
 =?utf-8?B?ZE1HK1piNWgrM1NFemozSUlTVHdiOGVXdjVhYldjaFBMdWEyUkNsMXRIUk1Z?=
 =?utf-8?B?SEFrRDJhNFdXSE9kbVpHcm9kaWdaYkpTMnlDVXp2enFjMkVXbHBwVlhuR25y?=
 =?utf-8?B?YVNKN08zR01sMG1XMURuaWdiNWo3STNPMGhyQ0dmU1BNeXB0UDhpNVlyWGtE?=
 =?utf-8?B?ZG9yamEyZ3NOKzV3WC9aSUZSeUlQSWdoMzB3Rkc1UFV2cllHVUVKeG9XOTAz?=
 =?utf-8?B?V1V5UG5IaHJQQ3QvNTBac2FUTm1zU0hCbXZIMFRUL0Z3eWhkcDdidjZJVnV4?=
 =?utf-8?B?N0JGS1h6Q090VXgrek5DNTFleHlMelE4a0kxK25XSjBTMDB3M0ZrdDZ6M3JQ?=
 =?utf-8?B?WmFQQldJMEpOUWt0VUczYW1zdGRGcmh4YUFUU0Z6eTJPUkxsVE54NnFSb0wr?=
 =?utf-8?B?REF3aWJ4VDI5NFpWR0UwYVMzM05OdytRcFAxZm9vWUc0bXZGc1NNVEt2QzEr?=
 =?utf-8?B?dmlsUitmWWNxK0pxZ1NXOWVJOTkyeW0raGdFOW9tT25pdU5rZnZMMVVLTzd4?=
 =?utf-8?B?ZjUzSGY2bVI1V0NVYlFWWFJiUFh0QjJhYjZ0eGk0OGdQZGZ4UDl6bU82MHJl?=
 =?utf-8?B?S2tTamgyRkZkZ1REeTc2WTRxaktQWDlGRmlkdHdGcEg4V3VpZTVYN3NmZFhD?=
 =?utf-8?B?aTV4ZTM1aXdvTGlBdjJnbUEySnduWmxKVkFwU0VnQnpsNGlWR1l4a0tMemRQ?=
 =?utf-8?B?V1NPVDhQZ2l4ZTAxQ1FJdVRRY2RYL2FYb3htM1hlTnFESVdSSCtiQW9Cd0Jx?=
 =?utf-8?B?NFl1ZFgwdVF0M1pqSTNWWGxONHBua09KZ0kzWlIzSktqcERYdHNnUmJSY01G?=
 =?utf-8?B?U0ZrQ21pWFI2ZDlQODFkUzlPWDNyUS9tRGlvZnVvbGt6R1NUbS95OXU3Zncy?=
 =?utf-8?B?Z2Q4MzN3NGlRWEtzMVZtY2NUVW82TmhDREVnVnNFbHhFSm50TnRlNU1RUGFw?=
 =?utf-8?B?ZlZJVGVYSytLVlNjQ0NSQi9xNk83WWVmVFJEaVBIenZReGdvelhsQXNBSk53?=
 =?utf-8?B?SjhoM21DWStQdnpkVWFRV3UrSUlKRTZCYVJ2Y1lRdFZCb2ZlVVlYU1k4NWZv?=
 =?utf-8?B?MGFVbDdYWk9mY1gyaTNGcnhUL09Yc25wYVhlWDdzUE5EQWdvSTYrZWpESGo5?=
 =?utf-8?B?OWxNTkFTRHdDQUQ3QXo3M3o4Tm9SZmdmWnZnVkxic0ZNd01sVEdlL1BzMTVZ?=
 =?utf-8?B?VEhEY2dKNHl1WmtXVktDcFdlaUF2Nlp0Vk1wdW1qbmdpMDBMcnNXZStyYkJX?=
 =?utf-8?B?cXltbk5mSmpRWnFkdngrbWhGN0w5WlE0bUVqTTNITmlHdTNnRWZrTTJZVUlt?=
 =?utf-8?B?ZDF1R3FKR3F3L0lNRzRpQTE3VEZ6Y0k5UEpuQUdxWEUzeitSSXg3cjAzdHhI?=
 =?utf-8?B?QUR0YVp3QlNMUkYzWC9SS3JVZSt3a3d3cDBRdVd5NCtYTSswalF0cmZNeDlQ?=
 =?utf-8?B?TTJwREMvYmwzWG9ES21VRnE5Mkl0SERYWG53YVdOOXlIYVcwaUQyV0g5VllZ?=
 =?utf-8?B?ZElzSnBTN29hR1A5bUl4R0x5ZUtPZm8xMjlUMVFvK0ZnQVlrNUdmMWlvWTVO?=
 =?utf-8?B?WkdvQ253K0dJdkpiQjRzMFU3ditCT1dYanZBRGlja3V6VVdCTFdWUG5wa2lW?=
 =?utf-8?Q?5wzsByJENcEpGzGw=3D?=
X-Exchange-RoutingPolicyChecked: oNuaNHX8k+qpKFBAgpjMO1FDSVk50CgzQhSCAdEJGi9iOKvxJAkPKGB15h4q+/4xbBg3HxuN467nX3PhW/dwrNXtuyzlibfNIRRX4YaJBH3KkqsvrriZ5mi4KDsDgxk61aOelwRH16TUsiSZM6+ZwOFhs70ZEhCZ4oX6MflCQAvejlQsBqmEE/sQ9DsswwbVDvj8N1fHr8n32WxvVldaLy9WsWmtSN0A/jA4EkXK33p9K26LTf7HkQl6zgP5BzwvNxvWcnjXawC+e3r6ZieVQbenjHcTBt+66fEsHjnxDb8eSv/25UEC+v6EhRMGfyjTInAr2IBQMinxTW8lrf3qLA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cb5df0-db72-44ae-d064-08deacd54259
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:41:47.6904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilREQmu1lYxhMxhP0y8e3OJe1tXQqq1cAmuLyjwBC1l+PUG7mDEw9nL/ngN1Jecy75Pd+3pX7rTlPMduhDGfTcgii/zUcevB2bAHu4ZDHtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8169
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

On Thu, May 07, 2026 at 06:25:25PM -0400, Alex Michael wrote:
> pmd_buffer_scatter test suite failed on Ubuntu 24.04 LTS with an Intel XL710 40GbE NIC. Conversely it didn’t fail on Ubuntu 22.04 with an Intel E810 NIC, so the issue lies either with the OS (mbuf size or mempool configuration mismatch / buffer handling logic), the NIC (driver-level bug), the interaction between them or the test suite itself (as it should be unrelated to NULL conditionals).

Agree. The test failure seem unrelated to this patchset.
