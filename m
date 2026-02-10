Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95A2EA811B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:12:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35C99400D7;
	Tue, 10 Feb 2026 15:12:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5FBA6400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:12:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770732747; x=1802268747;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pVHDqgUFtj2qrbPEeihUx1RiqaTV/pn92Lh+Nx0j6zE=;
 b=E03qc2NHs8MgsZBJWBG2F/7ELVbZANf47doJIk92ktU1w6d9uQm64fhW
 NjPqdPhlZ1tTjv8JlxPKYzjtsX2alnjAwC1oUqIk1Accc8LLUFAXZcwCb
 2CWPXn12APBhrS9F6vpbem6DKCycKgcdtziocGWaE265JFtKBT3R065yY
 +D4dNk09+IKW3LosLzldcW+JzGJA1XCOFhV7/f+58Xyw4BMEOI0Q9Hhlc
 Cu6XyN31yiO5cV8Oi/4FRC9DxicabIpbnysfssvYUc4j6rRRmnyjc+TjJ
 Z9zZ+kKnbGmpAALEXuWV2c1KnbVpzN2NOq2M6eNiWNT846M0A7+qhsf3u g==;
X-CSE-ConnectionGUID: Gd2s1xciQCqAiegRV6XGfQ==
X-CSE-MsgGUID: s5PL1ASWTpKqWXCl0+922w==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83230515"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83230515"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:12:26 -0800
X-CSE-ConnectionGUID: uVrmbEwRTcSg7QLPS8k8eQ==
X-CSE-MsgGUID: 1nf3MSPMSrSLlFKV5ErY+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212010170"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:12:25 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:12:24 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 06:12:24 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:12:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtuXbPKskEPUUw4N5eME3fPFHzDRyK1I+lk7hi8eV9VErOMycjtTXoO+ebfX+1tmFTREIzLz62+YrHCfQGYJFzeNIBDOR7qb6cHNvVCHA6/2PTXde8x05l3ZiSmXXosdlpMLXdY/BF0oQNXfL9j/l/qJ+E0KYsmOMmBTPxv70B0+jvqgqu7ryyI6IuevJDZ/egS/YF119L41/tOgwyp37AnC9yN9LOzdXd4Qmps13gJhlhQ6+kfqQkNcV9tUrph3EtH6x/3i2JQ+FBM/VELyryoGFRQSRj5eDKSniQhsRRO8DXTV4X3QVuOMRoe+ccz6oDq9rAqTstifgBmwHJjSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BauVXbGn8gdW37NjVIri5xKgqVrmSoTnQq6xuBUWciA=;
 b=QZL5H40O96J5dBbtJBZi1T9FdQJfcAFQZPHXumRDOWpfcd/gLYzikW3BrXQUJjZM2gXsh08ujhCjbgOiJ2aonxX7Ipql3HVbyPasQo1d6VuopJYgV3WDEa6fMsWIouz+wx585nWHUX3fRG9PGI1vMU85iEBAhBR38Vu5zhmItCv9IlAPgpZ84/Afl80vjhWUGR7mb5MHlT9tw9bqbb7kvbajGiyEJqP0K9BaQJjIbTe3sUIdR/XDY3WlMCrcSlit0tv+fenUoD/GwjYFOnTa0eAPlNyYvQfMNeu8rxstIceI9OHlMpuVbRrewX2BCAi3M2+0sf+e4T10xmneMbJ1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM3PPF529E923C8.namprd11.prod.outlook.com (2603:10b6:f:fc00::f22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 14:12:22 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 14:12:21 +0000
Message-ID: <c1a462c9-f2f9-4815-adbd-870a1ee639c9@intel.com>
Date: Tue, 10 Feb 2026 15:12:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/35] net/ixgbe: use separate array for desc status
 tracking
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-26-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-26-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::7) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM3PPF529E923C8:EE_
X-MS-Office365-Filtering-Correlation-Id: 7997834e-9503-41c2-bf6b-08de68ae6808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFRrODhkZk5RQWNPWG1uQm5rcXJVUUFsanM2Y21HbFVvWVB1VXRMeEE5dmxp?=
 =?utf-8?B?NnFpanBwTGc0ZU85YWFWeVdLTHRrWDFMSDlXc2x2QzRpYVFPWDFyNGphcDhJ?=
 =?utf-8?B?SXh5OWtnbExWTTZoeE9ldVh4QndGcVkrWFFSWmVFdXA5d2FPWXlLK0ZPQlNF?=
 =?utf-8?B?azhKUTNpS1NWaEpSQlZhM3hXSlEwZFJCUXZkOGtuazJTUUJQWXpMVjYxanBl?=
 =?utf-8?B?MTdrYVkxbjlwMmRkaUdiSDd4UFhmeGMwNTZRV1A2NC9CTmw0dEZkbkxQU2R0?=
 =?utf-8?B?UlJRNzZ0M0NaWEZjV0pwMWdPSHc3ZlVsakVzQkxpL0pleWR4NWFQekhPKzZC?=
 =?utf-8?B?RkpMdGtqaGVCbFNlRkJCK1ZscGJyWUd2WXJhb1pFU3F3OTJoQ2d4cThEUmps?=
 =?utf-8?B?UkFBUWZ6NG0rS2JIanoxZXpMUjBxdmpXbi9pN1lpRy9oNGlUZ0FlUFFxUXlU?=
 =?utf-8?B?QUI0UHN3cmZUeW13Rm9NdDZjOWRnSGtnaW4vaE9Tbm92ZExpT1RUV1JSME5B?=
 =?utf-8?B?NFpOSm1uNkpZTzNSZnJSK1RqemJ2WHk2S21HdjZqRVVSc1F6UnRWcFBJWnBk?=
 =?utf-8?B?THE5RXdQOHZJRDRMYytVcS9nVU5hYXZlR05saFZNQWVlVXJjTndidXFpcDQw?=
 =?utf-8?B?RnI5dURSK0xqS2d0OVlJbzVMd08ySHo5bkc4eTF0TE41WHB2V084bzVBVUhX?=
 =?utf-8?B?NXJKR2lWWFQyZCtOZzVaWHgxVG45RitpclZKSnlJYUNyN3pTWWp5bnlYRVZG?=
 =?utf-8?B?NHFSYjd6Si9GaDdsejYvbnU3N2hwcFZjNlRyYkFTeW4vSHZ5cFVnU1hWc0dv?=
 =?utf-8?B?Uk95M2o3amtEcXZWVkVtbnYzWGxPZEpEOEZNTjJ2c0xEdWFZc3ZpRWlYQWFK?=
 =?utf-8?B?Zk9Ob0lMRGFWV3hSOFRzZ1BPZTRnNGozcUpLSnJTbEw4OTdKV1o2QkR2Z0h4?=
 =?utf-8?B?czdQYTRMYk1Ja0FGbHVlZ3hhNnVGU1hMbVBHaThET0dtdWg5QnZWTk9ONzEv?=
 =?utf-8?B?NzJwR2dySUFXSExlT2Qrd3JsK252QU9ORlErYlJhQTdEQ1lveUpVcUtVdkdp?=
 =?utf-8?B?YXl5UXhIL1ROYWdXclZhekZHbXF1TmRjelJ3RjZZM2czMi9Ya2VxZVF6b042?=
 =?utf-8?B?VmdwQk9yRjZNd3ZJbEdDV0lxUTFHTXlXejd3Wk9oOU9JYkRoRnZCd21CYjNK?=
 =?utf-8?B?djRiZml4VGFZeTdhWitaOXhoK0JVbXpoK0ZIRGcwOVlwMTdXUnllNjd0MnE2?=
 =?utf-8?B?UGgxODdpZlFIUW9OTjZ1YmNwTThUR3k5eVN2VkVHSjVvbVVlaTYvOXVVMWx6?=
 =?utf-8?B?S0liaVYvWUU0b2lHV2htWnQ3VVFKdGtseGpOOHNEdHBvQkxYNUxpT0dta3Vw?=
 =?utf-8?B?dUhVbDMxVnlhRjFVcC9pS0ZXSGJJWGZ2NGxERW0xZjBkaFVPK2NxTDBMNi9l?=
 =?utf-8?B?WTNKL1hwY0NUU01hdXF2aUZOaGdpWi9uVnZWRC9QUkZZZFlXNXYwSElVZnNm?=
 =?utf-8?B?WjF1aEZmWXVaWURmSWpDcnFJWWg3SldvcWE0ZENFUnBEQ1VNTU9wb0xhTUlG?=
 =?utf-8?B?Q3hmeXBXM3VCYmlVNHdxeFd3WHppdEhJcGJwdGEzU1FPUno1elp4Z3dsY2xP?=
 =?utf-8?B?N1NRS3hvNXd5aXY4Ky8yZTEzQnIvSFp4ekIyM1VKZCtmeU1aT2VldDY5RWIv?=
 =?utf-8?B?SHZUSnRNN2x1eGtMUVp4bmZ4NkhJc01GRzk4RE9qYUcwdmZyQm9IUVg3OTE4?=
 =?utf-8?B?SGhnbTFIbnVtL3Z0SjhQQ1lOWjVhbk50Y2VmYm1FQUd0eldXa29uWXNoU2w2?=
 =?utf-8?B?V2pVYzc0d3h5eVI1clEyZHZVRDBVdnR0N1p4YVRCenB1WklCRnBkenJaME51?=
 =?utf-8?B?MHdMYlVNenFMb1FjT29aZTlvWkhCazQ5eFVJMHhSa1lFRVNkenQzR0tjbTBN?=
 =?utf-8?B?QWV2THpsU0N0dUpDQTI4bDNGVW1TK2NSSG5waUt0cnpOQlg4VXpIamNadVF1?=
 =?utf-8?B?VEsxNkdGQkV4US91UE9uODN2dXJHaDhlby94N0FaTFh3cnZ1dFVweFlQUkpQ?=
 =?utf-8?B?VitMaElPRE42Z0RaVW9uaXhhakFNenVuZE9QbFFtOGo3VWJha3lTMXNWVzFQ?=
 =?utf-8?Q?Jzt4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU4ybEZRd2ttVDV1dldWbk1iRHFoREFnZVJ0aXpWdjBxZngvVUV1ckxVOE0z?=
 =?utf-8?B?UzZuSEZOME04RGM2cDhlejdSZ3lnQTBwWVByay81WlVnYk9ETDNwSjNTVEh0?=
 =?utf-8?B?UzlUUlZDWFJUcFRJWXVTNWxDL2t3UnZJdDJ5bFJiUWxsQzVSZTZVR1Z6QjVT?=
 =?utf-8?B?R0xQTkNBZ2pTaUFtb2NNUGp5NWh4ektwMTJPejB4aDBac3NkTmpBTXFTU1Nm?=
 =?utf-8?B?NE5oNnVPeHBIVTVvaTFDalhqaXc1QXVrVWtJaXpCRnlMTHMyR2NqV0MyUnNs?=
 =?utf-8?B?ZVp0QjdtVGl5TVlncU5qOGFldVg4YVRwZjFWaW9OTFZ4WTV2Yk0veVFITHl0?=
 =?utf-8?B?dXphdnVoWGJGZ0hyaGdtVDloT0xvSU5KczRUNWN3bjRzb2MrK2U3QjhDN3hD?=
 =?utf-8?B?Z2UwSHpWWTcxdE9vMVZDS0hpU1ZJaVB0c0xHblB3SXZxVjhnQk9VMlRoYnFD?=
 =?utf-8?B?Z3YxRjRuU04xek5hdzJuV3JFajRBdmx6azZWRWs3b1hPU2tHcHhiQWVXb21B?=
 =?utf-8?B?K0FiY3MvUDdGUkxQbzRZeTdvT1l3a0ZXNUdGMmwyYTVDVmlSVEhnSG5EaGht?=
 =?utf-8?B?Mk83MmFYS2s2N0tvbGVjc3RsRHFVNXdaeS9QSzUrZjE5elFRdUQ4RWgvdVBG?=
 =?utf-8?B?anByY1JWKzd1elNlZVM1RERpM0h6c3RsbGc0Mnh3SFBUWC94VkFWOUE1T1hk?=
 =?utf-8?B?cTlFVnc0YzJ4d1kwd0tBUEZmQlBnaHN3REJxZXlWVmMzV0xTa3dBV2kvbFVF?=
 =?utf-8?B?aHBpOUFWMEhqZXZKOHh3NEtlYkRKcjhJTlVvM1FxdzFNNEhOcGR3R1JqWFE2?=
 =?utf-8?B?dXhZcXBXQWJPeU5oKzY1d3Mva0VaTStVbkp0dlMxdTIwMHBzTkhHd2lqU0xq?=
 =?utf-8?B?T1dFU2tySTc5SWVlUU8zN0krcDVzbHFmT2pVcmoyTjNNdEJUT3pHYkFMZzgz?=
 =?utf-8?B?UFMzcG9ob2pkT3RwUU1nc2prQUpPYmI0VndNMTJTeWhoa2Y5cEZwY3hlOFZS?=
 =?utf-8?B?UExsMTliRjdCMnZTU0ZRVlhWSkdUTlNVSnZZTkkvMXhYVEkzY2FNbVJuSERy?=
 =?utf-8?B?M3h6b3Z5SG4rbkJmdkpaVkNtQ3VZTGIrWE9XTEo2WGhJMSticFpDaXE4MjVp?=
 =?utf-8?B?UFk3aWc2eW44ZWQzckRpUGZMMEFmRFlmcjh6VHJEc2hyZVJqTE5UZC9xdmZG?=
 =?utf-8?B?OEpHU3NNTmhna1ZERktibkdxVFNMVnl6STc4a0d1N2hFaEw3azl4WFhpYTRo?=
 =?utf-8?B?SG1QT21MbjJ5bGtuYnFkRitEYjNRRWI1OUJPNTJ0NEk5ZnNaMm1sSXhQbGZX?=
 =?utf-8?B?MnpDaDN2S2NncU4xL01lZS9RNVZmQlBjWDczcVZkN3NPUUpXNXk5MGR1YkNn?=
 =?utf-8?B?TnB6U3ZVMFkvbFB3L3dTNHpDVnlFWHVUSkNpeVZiSjJVdXIwR0dSR0gyV1RV?=
 =?utf-8?B?VUE1anZITWx0Q0NLZ3oySUxsOXhuNEhVYjRNamNXN25LL0o1VlJHUU5icnc0?=
 =?utf-8?B?THRSUHdKQXJ1R1JLcUFjYWtESkl4TDlUZG83Ky9oQzNndXdkeGR4TmhoaFVO?=
 =?utf-8?B?N21Mai9rb0NpVjluTTlIZUFEaXFTVHBaSHgzaytNT1JvbHFBUmJIZi9nc2Ir?=
 =?utf-8?B?WUdMTCtnMVNpNXJmU2RKeWhheGpHWDNzTTJhY0NYQXNibVJlK0NZWGJTRUky?=
 =?utf-8?B?bDFxZ2F6OExUNVpBbkp1YnBPVTVja2VqTS9ITllxOW9QQy9oOU9wT1g0M3Jy?=
 =?utf-8?B?Tkd5dVVyM2dFSGl3ejZsODBZdDErRlhRd0hheTVLRnVPTlJlYW8rSHM4Wml2?=
 =?utf-8?B?VU5sU1lyV1VKYlVzRmdUMjdHYWhtSWRPVUErT1BiZkkwdFFJb2FoSTBjS3Bh?=
 =?utf-8?B?UkxCN1hCWE1TN0Q1TUZZYkZrdVBZZWVMbW4vUjgwbytoTDZMbHM1Y2xOencx?=
 =?utf-8?B?LzNnUk1wbEw4NWMwKzhEUEZ0Y2hFbi9rWFRhREVRdWdSOTVVaUs3TGFNRWxK?=
 =?utf-8?B?dzViRHNHczVvQ1BTWEM1TzRXY08zbzJuNFJrU3FHdUt4MnJkTHJnZFZ0aVB0?=
 =?utf-8?B?QU96SkZTcVU4dm9OS2ZjQTUzbEtJLzNLWWtwM0dCUVB2WlcwVitxOUJKRTNM?=
 =?utf-8?B?ZlVtOWphYXhqYjZWb1o2dWNoTWhmdktlWktBZ1c5cmxkY01lZk4rUzFmVURU?=
 =?utf-8?B?UGlVazVSZ21jajh3TXdWWHlJVjNNd2xMamQ1aDJ2cW95eEJ5RDJBeFZUem5S?=
 =?utf-8?B?RDdRRk0zNkxLQ1M4VXBtOGMrTWk3elloWG14Y0tXRDgyK0toUjdHRTRqVEJN?=
 =?utf-8?B?eXRLUlpBTCtib0FjTitLRWtYaFArZWZZWDQ1L1hjT2NFSzZablBhaHYzclMw?=
 =?utf-8?Q?rlP8b2BziwskuexY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7997834e-9503-41c2-bf6b-08de68ae6808
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:12:21.4597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4OSye51aOq+t2HqKuaIc4GXcKw95j1yR3MKXxRQ9/vkGIJZ6KyJtSv9HfIDsLjHZxqKFcq+R7Ni7YEK9CGWLNwkDzqo5prbq+H5th+0+Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF529E923C8
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> Due to significant differences in the ixgbe transmit descriptors, the
> ixgbe driver does not use the common scalar Tx functionality. Update the
> driver directly so its use of the rs_last_id array matches that of the
> common Tx code.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
