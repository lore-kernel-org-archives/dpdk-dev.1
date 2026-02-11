Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17DCEA3F27
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 09:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A744B402B5;
	Wed, 11 Feb 2026 10:17:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 519E14026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 10:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770801463; x=1802337463;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iRc1EILn0ppSI2JilDvTZ+dG1D5VMgNJNRheQDryxRk=;
 b=fDTWPgVN66BL5t1OCKKwuR+TrLo+a82sBrQVm4w5FwfrITScpNpIMLwi
 jN0D/+P3JoEcvaSCaI5s8Latb9Lx4Ylk+u2pU23j4rAav6wcZTem97iRE
 ZxtBfirKSD9rW8akcvvu5Ox705lligc4izc9Bw0ETdWsZQHv0LelRoxfo
 WAFWXf6XYzidS21GAgUSdjd1CF1qlvUpIjRjknDM6iqh005aGfo4O/DS2
 8cK+le4wLjKj6eU3hoRnz8Z7D0aKW5HfSveyljBTEHw86pBhrIOR/+Jn1
 4XEIfjj/Dt8WvAjTDSRR8vXgteQHEUyqP7xZLGhdf4amMAsl5BZUC7XuN w==;
X-CSE-ConnectionGUID: nbcpNznFQ+WxMdTk8av3cQ==
X-CSE-MsgGUID: 80QY2+dbTLWG75vir+/x2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75789846"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75789846"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 01:17:42 -0800
X-CSE-ConnectionGUID: ExB4DGEFSpSaqq7cpVzu2w==
X-CSE-MsgGUID: T1sFgfnuSiu9UUs+lZzAdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211595673"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 01:17:42 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 01:17:41 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 01:17:41 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 01:17:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tum+dBbDhHpKtZxek0s6fDDH3c4FzkvnNd7LF9PFxt9Fy6hnDzoV/gKZhDujVWijtfNwZM0x6rKtlJF4DHxgbz5l5hljqPDhI7uB2/1O1D/CvPHgfhSWDgw7Q2IxcYAnURo7eVFe9ECj3e6/3xvTQypBsslnvbHiQOsFFb0hrfPQx5VKfpOLWKMkQKXJssXZJ40PG/RnltXt6kVMJ09UPttpk1BnVPf9B5cMwV4imKRU2hoBwvca/ePy4VMH10LH0vWoAV+aDxfe8oA3kQGBcjCAUg3owZEhBHfBBvW8HFAKRwVHzZOs6j9Q0n0L/K77TNtguG1sKlI1nnHOTVwKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBm6AvRsBo1HkfCI3vCd1kVQFHKm0s5V8CLrJDsDZqY=;
 b=Tfs4Xt9R/nSeP9LxCq7OfQH1zJznEFz3ZJTCNjT5MSCnmHroqt9YlWusswci6MAIwV+vgBTsnsJnfVCzimORZ6kZZjWiXPw2LrzOEm5NLZjHH5qI5yQAPjQJINXXl0Z4nJ9gOFJGw6h0PIumvm+QJKm6w9TMtBzEQ3BQNATOeQ4d0PgLrTD7KBQocLBjEW74RW8IkrWGL4oRmIZqI15NWmd13MYnZySHkjCGOcraIKB/olId7i86zdUUFxBXgpJoybQX8Jra3bSg9jVeZoY2A60lI/9pMDIITZlKUaFxft0gc30H24+yn1Y1HR9cGVP0wTILfr1cdBKXhlcpw5E+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 09:17:40 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 09:17:40 +0000
Message-ID: <5740f4a3-5bbe-46ef-acc7-6ddaa6092f14@intel.com>
Date: Wed, 11 Feb 2026 10:17:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/35] net/ice: refactor context descriptor handling
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-7-bruce.richardson@intel.com>
 <f3a53f53-e636-4660-81a8-5ae3b3fabf0f@intel.com>
 <aYtthv1wbK7xHdm5@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aYtthv1wbK7xHdm5@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::25) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 699f586c-9774-4633-9cd5-08de694e6792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWdEV25iMkY3M0JQaHhTUCtKUEQ3Q2lBRUl1dFJoNUhRSGprQ2FaUTFObkZh?=
 =?utf-8?B?YWJxcnF0NkZhNlVVZG5VZnhMVVJLSkg4MDhJSUdpZTlsUk1sWWFMaG9VeXVN?=
 =?utf-8?B?aEpmY3p5MDcyNC96Z1N2c3ZMcE95ZkVVczhCTWJKWUdvTHJTdCtTWERuV0Zy?=
 =?utf-8?B?Zm42dFFNTGF0TTM2TlY0cjRoQlI2d3E2aEcxN25FNTJISnVRdCtycnc1cEhx?=
 =?utf-8?B?QU1FK0QvNzRqM2N1SFVlVFUwbHRkVFduN1dzREo2M3FMZkp1RE1qb2ZZTXdM?=
 =?utf-8?B?UmlFdkYvVWVja1d6VjZRYnNOc1U2ck5Zb3FodnIxNG5YRUl3eVM1Znd5YndZ?=
 =?utf-8?B?azg4KzdYUXpVbGVmc3o2MGxXeXFXRVlwZFJUVTRkN05zOWkrNUxyaEN3SXRa?=
 =?utf-8?B?cGFyNkF2Vm00a2NZY3EwOWk4N1pkSTdSajdZVTlWYkZIS2VCQXZHN2EzT2pi?=
 =?utf-8?B?bGN3d3puTHlMUms1M0pQVDBvSXdndFB1WXh4LzZSY2dPemp4TnpvaHhIR2dG?=
 =?utf-8?B?RmI4Y01Md1ZEZk54Z09Qa1FtNzN4bGJyK2xBYmNXaGxIK1ZUZXNnU01LSW01?=
 =?utf-8?B?SWFObWNoMTR0TWVXRis2Nk4vT3pXVitlSVIxRUxvVXNGUVIxWlpPNTV3TzhV?=
 =?utf-8?B?TjBOOWxtWW5BWnEra1BQMUpudW9ZTkhPNXEzWmJiZUhyWi9XUjY4bzVOK1lj?=
 =?utf-8?B?SkRMWDVSWHJDMjFWMDBxMktVNWJ1T05qa1pZc3lHRWx4dkxvK2sySG9wc3p5?=
 =?utf-8?B?MHdCNHJ5SkU2MzhRL3c1eWJlWmJvVVBlNkFsTGF6V082ZnpURDJ3akM4b0l1?=
 =?utf-8?B?SGdveDdLNFlvdExwZnF0Mjl6RFBYYW1GbnAycURNeG5Mc1hjMnRGd1hhSnpv?=
 =?utf-8?B?RGpVdVM2T0k0N1N4NVNRRkdBWC96dEZzdlZDTUp0VVJLSTFacVc0K1pSNERW?=
 =?utf-8?B?RVFvUW5SdC9yU2tKZmlBTzVUb2hDR0lpSytoWkpNNFk2YWJWWGRVdzNwODBH?=
 =?utf-8?B?MURpaDkwSmQ0Yk1rYjNQeFpJSDhsR2RmUUpXSFcxNUtrR28zdkxITldZWXBZ?=
 =?utf-8?B?cEUxQ2JqY25UQTJVUE56a0ZxRlgyZENUUW9EY1JvcFhxNVREdytLTU9BbjRK?=
 =?utf-8?B?aStGS0laMndtaTBoK0h5S2lRQSt3K2Zya2Z2OS9rK0czbHJsUWxvNlp2Yzdk?=
 =?utf-8?B?Z3cyclI2MTlTRUhQQ09LVVF4YXBzdG5XSVJKMDVHbWwrQm1LYzRFTk5QaDlR?=
 =?utf-8?B?U3d5Yk5zWkRidjBKejdzV29NZzVmYVhuUnpjeTk5R3J2d1VUdG10dXZxeFgy?=
 =?utf-8?B?dG5FRFBQVWhnWVhYRmhPcStJdlVGRmFVRkhJcTNVYnhqajhxT2FtcEl5dFRr?=
 =?utf-8?B?Yno3eDJlQWl0ZE16Q2V6dDVXby9Na2dBZ2JUTW11TEpNV1hqeGdIek9HaFpQ?=
 =?utf-8?B?NjJ2Z05vTVVVdlZDaG5TdGhNKzZPa3d0UkJLSHZvcnBSTmhOdEQvTk95Y2xl?=
 =?utf-8?B?djYyNWlUcjRocW04WG5XN0wxRkhxTUxFMXNYTk1TSXNLdStIQXA0cWZKREhT?=
 =?utf-8?B?bmxsZWRFeWNaMlJhZjhGbjNUU21odURtcnRrWVI0djRiL1Qza0hIb2dzK0ZM?=
 =?utf-8?B?eUFGTm1hTVlJZFErZEk4Nk04UDZRbHNrL3ZhQytqU0FBVFdBdXVIUE1aclN4?=
 =?utf-8?B?ejl4dCtNaDNTL0hoWld0ZWVNa3BBS2NnZ3l6bFBrTkFhdzRqeFI2Y1MrTmlU?=
 =?utf-8?B?enVMTjJrMUcxLzFKMUZQbkg0Kzh5ZkI5Z3dULyt4MnBydjByY05VeElZdEkw?=
 =?utf-8?B?OW50VTVxdktieXBJOHFrTndUSDNnbytLb242U29EUnpPNlFyQlh5WW94eFFv?=
 =?utf-8?B?K2ZqWXNJd0dSWU5mR2NqcmFoTmtxR1BNZzhRVFBuejdxZmF2WXZEdDZiUzBU?=
 =?utf-8?B?WnhBZlROcE1UbEtYTFIySHBvQ21CWW05Ty95ZVJjclFOOFlYeEtNdTBBQng2?=
 =?utf-8?B?SmkwNy9DTVVtQ050UFBvclZYYWpHN1pGVmJBWnRSNm50RE5oQS9nODNhMk50?=
 =?utf-8?B?KzVUbmFPQjJ3RmFjUzhqemRqUlZROUJVMktIZEZ2SVJyOEp2ajIvYlI5dHBv?=
 =?utf-8?Q?CxeU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGVPZHFrdmVYYm50YXc4cnNrQkJCVmp0akphVFZWdnhTOUxyZ2VobmdsbVJ0?=
 =?utf-8?B?a0FvOCt1T01BZEFYQndIM3lMMTVJcUtWNElIbVlXZWVmalliUkxaeEVaS3Fq?=
 =?utf-8?B?ZHpHRkp2ZXhkUVpQdFRLUGgrb3JHMU0wL2IvUWFWK1NUeFZyWFVrdDJXeUgy?=
 =?utf-8?B?Wkd2Qkt2dEpxS1ZOWm41M0hXbkJqNXRPWFBWRWFsTmJJTmpJR0lkNHVwaGZF?=
 =?utf-8?B?UVJHbzVzTHpUU2VnSWVSUG12dUFkNkl1em9EdGtidHlQSkI4d2p0cjcrc2pE?=
 =?utf-8?B?ZitCSVV4ampnVnA4bWFKYXZValR6UlBOQXNaZkNneHp1RU5JT2x1SmpLamQ4?=
 =?utf-8?B?a2pmR3h4ZEZmcEpFOVZWLyt5OW1mSnVyNlRNQjNQKzFXM2ZlaVlnc0hSM2dD?=
 =?utf-8?B?djI4UXA1Mk5MVjBiRGx0OE9Xck1YMk16bEZ4djZxR210YU5Nek9XUW1jRzE3?=
 =?utf-8?B?cDVWdzI1VjZJU0VnYkttbGt0NnozVWNHaWM4WnFHRi9HVzB1VGxVRkVYbFRT?=
 =?utf-8?B?bE9Fa0IvQlpBdGZJRm1mY2MwZzQvblB2MWlsZitWaHNKWHdGQlhNYjlGNWlr?=
 =?utf-8?B?d0I1aDZKTERpUDJML3dVSjBjRWRMMUlSSXBQdVV3OVhOMkNZUGpZbWwxcUti?=
 =?utf-8?B?WWxhU0Q1REFtaDV5bmY0dHY4TmM0aExXTzVreU9LNlI0eXMzN2txQ0g4NGxw?=
 =?utf-8?B?OExlRitpZW55S3g1VjJBWDNlMmducnN6cWM4d25HOE9VdFN6UEtMbFBxelhv?=
 =?utf-8?B?MExRY1A0ZkhJcElKTlBza2l4VWV6RXcxSzVIQ3V4dHBXaEhRL01lV3Y4YXc1?=
 =?utf-8?B?NGV5cFlVc2p4Sm5uK00wdWwweUU0dFZES0NQaG1QbEJEUUpRbDk4WkRNK1BO?=
 =?utf-8?B?aFJ6ZkRITDhzakRSTC9XaHJGOUdqOVdTeFdOcCtXREkwTzY4L0VaVTVNZ0RV?=
 =?utf-8?B?dWxoakJ4WkF0ZVR2b2NZQUZEZVpXZnNBSW9MQWNRT1lnZUJ0eXJuckxmK2pq?=
 =?utf-8?B?U3A3a01yN1RKTzg1YlI4QXJZZVZ5ZU9LVjJvYjN6Z2I0Z3dKYTUwRWRTVFFo?=
 =?utf-8?B?UUF3aUR3QmNlSTg1WWJwYlptOFd0aDd1dDBqMmZ1a214MFVHTko0WE1KRE9J?=
 =?utf-8?B?Uzk1UGhzeVp5TDl6VXE5NVVvZjg3KzdSMHF0bGx1R3UyNVZDYm9XZGloNHhj?=
 =?utf-8?B?K21oYmRuMmQ4Y2FzdkV3YktjL1VhQ1FjQ2FZSjRoNUxnZmdMaE96amswaVMx?=
 =?utf-8?B?SmY3TlJNb016Y2lRTHphSFBodnF3Z3FwR05SdEhwbUtWUndTNm1qZWQyb2Uz?=
 =?utf-8?B?Mm4wSXVtRmUwVlJtOXA5WjlMVHNOQmZGN1B2ZDlBOVJZV3JnYmt0bEdJTmVD?=
 =?utf-8?B?anNaZ0djTUlkOE9MU3RqNUdUd1pZL3RzWkFWWnA5SWcrOWlpK1FTOG5QS1dp?=
 =?utf-8?B?ZzBzZ0dXbHM1dTBTaDBMUC9OZjNwbnQ5Qzh5SC9LTHhJaGRBOWhvVGoyUm5Z?=
 =?utf-8?B?V01sRlFVUGF2eERCVXZ5V0VpWHZMSmhGNXg5UTh2S2J4b2hLVUtqZ2tnb0Jy?=
 =?utf-8?B?c2xFTHhQbThRUExnMmV3Rk9zdSsxWndKQjBFc0R6amFBdmkyUnJkK3NqcUYr?=
 =?utf-8?B?bFJTYXEzTWJSSlhWUFhxRU4wczJvak9XSGltSkE0Z2g1NEgwSllrSzZSemdy?=
 =?utf-8?B?dmVCRkZNaVVCWWEwck5IVzhKUzhOOXl0MWhPejNSWUQ3R0prNVl1VUZ4WnZi?=
 =?utf-8?B?L1JNOWRtTnN0K3lRWG1MS0ZFc2dBT3Bka2hXcFJiUUE5M1lzNmRCWWlBMWov?=
 =?utf-8?B?RmpjamtaSTZpRG5uakRnMGhtZUhxN2FWMVBVS2xlZFg0QWJtd0FncFN6UFE5?=
 =?utf-8?B?K3ZnWTQvYzhwWldGUlJDN0RnUUd0YzdvQVdYVFlXUEY0bldWdjRtSG1ScUo5?=
 =?utf-8?B?dE1meFBhVzkwbEFTaG9ybWp3NXVVSzI1eGVtT1grSTIxbGNNMHNiQ29mMUl3?=
 =?utf-8?B?RUI2RmdOT1YzTWpPOXJJanlSbkFDOHkrcEZEais3bk9Vd3QwM2U2cWpxeXRz?=
 =?utf-8?B?Ujd6TkFYME5HMDZJS09ZYWlhbGZ2eGNUL0J5MzFqeTVPVDhRT29iaklPN0JD?=
 =?utf-8?B?aUZGWitGK2RvRTBnRncrbjBVbW1KbUNGaXNMdUdaYXRTSjJiYllvVDJtQ2VJ?=
 =?utf-8?B?SWdDN0NUbnAxSWw5c3pFb0IvZG9vM3BsZVNnRFphR2V2Rk9NU2tFRVpXNDhp?=
 =?utf-8?B?YmFwbHpTN2QwZUM5dGdtV0ZWSFQwRG9rR1Z3cE9XRFdtQzZreEo0RE1PejI2?=
 =?utf-8?B?UWUyNm1rc2RySTQ1cmVOM2pEU21vNmMweUJiNkl4RGZlVUJvMGM3VGxTeEdT?=
 =?utf-8?Q?rMeygAsVCmnG3Qo8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 699f586c-9774-4633-9cd5-08de694e6792
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:17:40.1321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iq+ATy1VZsxieAAyiFAbqVMgAmcvxTu/+Wf6yfpZY554TEmuXrjfUBq29lr8nP/UX9XUI2qWOiaJztnLWlPOQvdw7KPd/3wFHVuUl+aipec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
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

On 2/10/2026 6:40 PM, Bruce Richardson wrote:
> On Tue, Feb 10, 2026 at 01:42:17PM +0100, Burakov, Anatoly wrote:
>> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
>>> Create a single function to manage all context descriptor handling,
>>> which returns either 0 or 1 depending on whether a descriptor is needed
>>> or not, as well as returning directly the descriptor contents if
>>> relevant.
>>>
>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>>> ---
>>
>> <snip>
>>
>>> +static __rte_always_inline uint16_t
>>> +get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
>>> +	const union ci_tx_offload *tx_offload, const struct ci_tx_queue *txq,
>>> +	uint64_t *qw0, uint64_t *qw1)
>>> +{
>>> +	uint16_t cd_l2tag2 = 0;
>>> +	uint64_t cd_type_cmd_tso_mss = ICE_TX_DESC_DTYPE_CTX;
>>> +	uint32_t cd_tunneling_params = 0;
>>> +	uint64_t ptp_tx_index = txq->ice_vsi->adapter->ptp_tx_index;
>>> +
>>> +	if (ice_calc_context_desc(ol_flags) == 0)
>>> +		return 0;
>>> +
>>> +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
>>> +		ice_parse_tunneling_params(ol_flags, *tx_offload, &cd_tunneling_params);
>>> +
>>> +	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
>>> +		cd_type_cmd_tso_mss |= ice_set_tso_ctx(ol_flags, tx_pkt, *tx_offload);
>>> +	else if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
>>> +		cd_type_cmd_tso_mss |=
>>> +			((uint64_t)CI_TX_CTX_DESC_TSYN << CI_TXD_QW1_CMD_S) |
>>> +			((ptp_tx_index << ICE_TXD_CTX_QW1_TSYN_S) & ICE_TXD_CTX_QW1_TSYN_M);
>>
>> It's tangentially related to this commit but it caught my attention that TSO
>> and timestamping are mutually exclusive here. They *are* mutually exclusive
>> as far as the driver is concerned so that part is fine, but I couldn't find
>> any signs of us enforcing this limitation anywhere in our configuration
>> path, so a well behaved application could theoretically arrive at this
>> combination of mbuf flags without breaking anything.
>>
>> (if I understand things correctly, this applies to both ice and i40e)
>>
> Yes, you are correct here. However, I'm not sure if we can or should
> enforce this, as it is completely possible to have a queue where some
> packets are sent with TSO and others are sent with the timesync flag on
> them. There is no way for the actual Tx function to flag a bad packet.
> Best we can possibly do is add a check to the pre-Tx packet prepare
> function. WDYT?
> 
> /Bruce

Now that I think of it, I believe these features do not make logical 
sense together anyway (TSO means segmented packets while timestamping 
means you have one packet you timestamp) so perhaps this can be 
considered user error? I mean we could add a check if it doesn't hurt 
performance, but maybe this isn't a problem we need to solve.

-- 
Thanks,
Anatoly
