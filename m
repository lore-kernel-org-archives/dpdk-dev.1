Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EFDCA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:55:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6C53410D4;
	Wed,  7 Oct 2026 12:55:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6B9C240E3A
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:55:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791370501; x=1822906501;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QJcmm3i5gxXQ8KMmgK9tOeEdJGCm96xRS+GBK9IyFjA=;
 b=IOTezyOYzHdyUMnpzZAHlEA6C+ILwM1ZDaPmzlIwgRz7ilDzMhY7hhJt
 x8iSGDc5opW84uVIf6cNUcYmkooMb9286xMgzU7l6OaGM5LKN8UqUc+uH
 4luT4/xrq+fgUwH++YJVH+ZWRnEeFkoL9z/esKeJPXhtd2RaRtjU93GoG
 BEdg2NwR1U+SVQiGes/LuiYqrjha1Kv3A8ybgYy2ADcPSPEoLmrwU/Uka
 5lYgI2j8wG27hbNpxy3yGJfxZ1Z6VLwcF5anfDYU1kt1tatY3uaHyGdSJ
 sBVHNnnQeS8ZxEwbOcal6IG4AyfNZOegUwvfhexwPS8kxa0xBjtO3tQgn w==;
X-CSE-ConnectionGUID: Y+nUGlZ/RqeBUnIAl20o6A==
X-CSE-MsgGUID: cKpffYr8S+KhZv+XfFdtWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="137466"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="137466"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:55:00 -0700
X-CSE-ConnectionGUID: 6R0gZeyvQ/WNm5vaIIkthw==
X-CSE-MsgGUID: Rs6nLWNwQIuv7qBfIegUJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="315434382"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:54:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 03:54:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 03:54:59 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 03:54:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NykaFNY5Lb/QtEbKkNHj2YN2ggC+ivNdQELqmHuntXHQkrdRJZB1vgj/BIfp6uXdo6Yy+GcQ2y6oDftfINYLWjz7pTnW+QHo0oXFPTwQbnZYhAtb4Cul7h68Bjjg/ffo2C4xB6KlaNhOjXRK6fF2e6YCt9tcW0f578Z4erAqkAhjxZSwLOaqbhy1aoMG7pWIyCHJdNTPFW0kut1mHGXO5JH9yiwTGYmFlo4dYfK+f3CirWwpL60HqmC3/qIRQ6Y7lf8NZ2i7uWMgtWfVpJikBNIc/wnoRZXK7wWV4KVyzWTSULRhakNvwKq7f5wrT92Gg6xxdBohUJQaiSUb6g1VcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JaONk7uutP4eJRXIFbGU/8MT+hdPPyAE0pi+MrjGds=;
 b=OndKrmf3z/N7KVJMZ08VMm5A8TYIO8/cqRRw9kxYVBiRo5NyvxSqRkfVFY+spKzHFIN5p+SJIBiuH+hQVo+P7OKTy/9RLbWJiU+63B9qCeyb82zA5g6FWPygLDoxbfJ+NGSFviQ6sW9QdeLGJNN/qaj1RMlKamUKvxdIfXu23+F/qfAFFCFmiJi4QvNBJwmvHQHhG9F7gMpCCZZwaq5MRorAmSOB6pKWMHfbMTvYItlyIOa3y1KIwGtG7AVEtzGQn4GBWF9J0FlQDATtdx5dnZqkZdP5+Lo/uLthnFKoXHVqBMz/n/3t5lFBExgcWTMF2SAnvurfaLIl8YEGDwaYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW4PR11MB5774.namprd11.prod.outlook.com (2603:10b6:303:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 10:54:57 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 10:54:57 +0000
Message-ID: <80fa2575-c418-44a7-a712-7193e7ed15d1@intel.com>
Date: Wed, 7 Oct 2026 12:54:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 04/26] bus/pci: move VFIO concerns in Linux
 implementation
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007073206.567001-1-david.marchand@redhat.com>
 <20261007073206.567001-5-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261007073206.567001-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0205.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::30) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW4PR11MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 1917b442-5d50-408c-ab13-08df24616ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|10067099003|56012099006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: X3adhWMoMWoIWa8nCShx+OY78RP7b+BflUu9wKqe9k0nDf8UlReZ3FG+RW9etGx1Wy6QhK1YvcHT3XfnsszknpWc2EckfV9jnOOFgwgx6ADmLVws0ophzeLtWD5oxHp/A8lrCen5E4itsfsitpB4SLpqzZH72yeXoTVLPLIw7UznVt4lKjp8/XhEs6ojdn+ipyEB1Fzs2/8ZzKC6yLy1Iido7Lb21dokWm2EhBPK0WzFXtVa6xiEmi1h2FFSxmDPwIAtWWqhs0GeZC4VIA1qK8BPsFaJ9sH8y3XFwSm9O8WH4o75O7btgRmLUd9Q5Dv9xsMpk+QiUeF5YDWo3wcdr0fVOsNjch2q8wmyClAPB/QX7gZjdfyObM7b8aEgnuOGiOcLvGMMHmX2RrSPBGowE8CKnkac+px7q8rOeRiGSwvpdnKlx/+4JTzikFM9QvCtaxIi6+qgaEfM4iyCfWrf1qLN5oqBjn8izkxcWvrNGH9tXrqHMKEFgDwlAMlfRkAoecRqedgG3oYo44Xr9q1PO5fB974Hy5XuW3xq7jru7fcA+vy5gYQKiQyvi2AKBef7GIHMt9vue8tHveXc8Eijs2i84cALUNJIn2fNwKShWvAEwUWI/NnbtJSKyn1xdyFAqEq64C7YXafrZmjP8PqmJICgT1X50lE8dvN1Y3EtSKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3dyQjAxNGdET0ZpSEwyVjlpaXBicllUYitqYmxPc01EMllDV25PYm9YY1RH?=
 =?utf-8?B?SUM2eXZxdVlzL2gvdDNjSXNqVElmbEhSRjcrWCtVWUtQUlgrem9LWVRsTEZC?=
 =?utf-8?B?M1lHZVFuOWtWNmpiK1pCRmMzd2l5Qk9EZjhCakVRUzIyQkdQMmlaQjN0V2Qv?=
 =?utf-8?B?Zm9rblhyMnp1eURJaFg4aDkyeENlVHloYmwvbkkxNmpidWRKa1VvZWFFTWFq?=
 =?utf-8?B?Wlhkem52aWtnalJXZ2dGdzN1MXNtUmhoc0hhcFVtbk1aVXVzYWh5U21GRmFP?=
 =?utf-8?B?WTJmSWdIUVBmQzZ2QmlkS1Yya0VZdmtPY2d0WFBFaGpZcWVhYjBTSmlRNXp4?=
 =?utf-8?B?VWFHc21oTjdYMkJjQVIzdEJrZU1qQU9JYVNRR21EcXlvejR1KzFNaU0reUsy?=
 =?utf-8?B?MnhiMFhGNSt1bHc4dEYzNGNmSWZqZlI2ZlhXekdYelV1ZWhrRUR1S1RwcFl2?=
 =?utf-8?B?MWN1QWJVZ1JSakFZL05sRE81OForV2swajZWdXRIUlZnVVNzV3VHbWdaUWx0?=
 =?utf-8?B?eHpSb0pxaDNxR1BKMDR3S3ZORjNtTXVrS2Evb0NHNkRTRzJaY0ViRVRaMUla?=
 =?utf-8?B?LzhBeTgxc09vNWMycWQ3S0pQME02NEpFY3NON05mSmdGNkNvWXFyMkMxV1NV?=
 =?utf-8?B?cC9sVWNSVnFuTzNoNXRRTWRXK1Nud2NpMmhmaHhISHo3Y0gzQXRyUkNOUlI4?=
 =?utf-8?B?TDc1VXc5TXp3S3UzTGVaU2ZZY3dyN3ZwaVprcEVTM1RkNTIxbmFSQmg4OHpr?=
 =?utf-8?B?QlhWMGVTTzY4TDN6WjhDTi83cXlBUXJHdFVYRkd1VGxrelo2cE12QWY1US96?=
 =?utf-8?B?R1hSdXNKK2I4d2p2dlorK2t5WU43dFdVem9TdW9vaHVmSDVhWTBPWVJrMXo3?=
 =?utf-8?B?S2RJaVY0czV5emQ4MG1PUms2aExnakVLQ1NEVDI5bGVOTlhBWGZLcUx1Rktk?=
 =?utf-8?B?UVhaRmRRS0R2YU5XMFBQakFwekVsZTZwN1o0QnpDbHpKcFpldTJVanArQ0Nm?=
 =?utf-8?B?eW5uQ2J3VmtBbzFhYkV5ZWh3MHhpQStndTNPSjk2MjM0WkFrSklRc25xVVBj?=
 =?utf-8?B?UGY2bUVuQWRqOERMSVJuajgwVk9VV3dyV3BCR1d3V0tTUlJPb0NXcU1VaTJD?=
 =?utf-8?B?YVF2Y0I4RjZhODkwb0xqRmlLVFFRcGRuSm9sOVloVkczakRoZGI5UXhXS1dr?=
 =?utf-8?B?T0l2UEF4a3F4a3VEVG1MaVVEanpVQ29nMklUd3h2U0pFc2tTRUF1YmdrTStq?=
 =?utf-8?B?ekFDcXhldWIxQndYRXFhMVp5eDJYcVVUNW9hdTNkcW53NHZUN3ZTLzhFdkZj?=
 =?utf-8?B?Vjdxa25vazdFRGV4VHlqOGRhQ0ZpektXU1UyWlZNems0d0Y4OTRNdmMyclVN?=
 =?utf-8?B?Y0tVQzd6clRaQmZ5VStwZXRmNTVpMUtSN2hiTEFheXFsUEtwNVg0dXlSTU9l?=
 =?utf-8?B?YTRCRXBZZks0WmFOQjF6cjdxS2c3NUViTTRLSnBvaHVkOFpCM053aGdOTUY0?=
 =?utf-8?B?NHdkQ3JTQVZ2ak90Y1FBVDVVeXVNRnRpc2VCQ0pGOWxjdjFFMzhLWEhQNStr?=
 =?utf-8?B?S2UvS29BOWRSZmJtMFl6blVKaWhPd0MrTExOWjg5bENyVnlPcnJESEpDQk1T?=
 =?utf-8?B?OUVibWxycVVqRFIrenFXdXM3TlV0ZnFobE91WDh5em1qNDBqL1RkZVFhajhG?=
 =?utf-8?B?dGFXNGZGYU44QnY3S1RLWkFnWEJiWDl0RWpZVFN4cVZnMWwvOGRWeVljYmJJ?=
 =?utf-8?B?QnNBeUZJYWNaMWhIVFFML1lrMys0U3FtajdlMlJBWWExVnFpcmpMTjBnOWhz?=
 =?utf-8?B?YWNJU2ttWG0xWE9aaXBTcVJFTmR0eXhOaE41Rkw1c3ZpTHJoWHo1UzAyUGJR?=
 =?utf-8?B?UklFQXgrbnpZRDB6Uk5YR1E3OC96Snh5MktpMFZseEF2ZTBzcTc5RXowZXZu?=
 =?utf-8?B?bnRsdXdkVHZoN0dlSTlQc1dXSkZrQmpKQWZCMXVBKzhod05SYUZlZmI2SndY?=
 =?utf-8?B?dzdwM0RnanNPQjJUTXRxRnIxbGtVSlhHT1NpTHhYaVA1OTZXNEJVcUdnbnVM?=
 =?utf-8?B?K0hDRWFhR0MxVWtMbms0MTBTejFuNmhSRmo3NElNRnFYRGNHK3hyM0F3WGFo?=
 =?utf-8?B?SDdDR0tqL21Pa0xhL1hITjhFbzJia0Q4RGJHbHFUQVRwL2xGRGdOZ0x6eS9T?=
 =?utf-8?B?VjloZDBMMHR1S2pKblpMelF3T3UzK0FIM2lBbXM2ck03cGY2RCtOMmtYdjlL?=
 =?utf-8?B?K0Y3bmFwU0taRVorQWFEa2c4QzBEUktRMWQvUFZuR1R0Nm5uOGp0eHR0bnpx?=
 =?utf-8?B?a25ZSHFNWFc4Y01JajY5ZUxwYVdMTlpLUFVueWFqekc2b3RzZFFuTmQ1dFFN?=
 =?utf-8?Q?w0citBz4bdP5r0HE=3D?=
X-Exchange-RoutingPolicyChecked: 3pfJTXnceuwweeW9LGBW+w6mvTr1Jh2KNPsTiYi+ZxlnLqT1bBmvP1d9b/cZPhLmjW0UUcAPcGEWcoSPWWDjhjTYNQbNvph2ymt1H9ZvH7BflJawPfqpD5zpMxUm4sGm3AEMaJ+Tp+sN/Cgs/2J1mkMEDljLZeMImnkV/USwVvPIVsidJqsdFkTdzoEmaeG/eX+SAG54HrfgyNohSJGtjzg44FSYVf6u7AYu1riQg9C/IVDC/QQ9+jwERKyjKbU2mmIUIXxGnMKLL5pnfgQFQCYcYA/PabBh7HPy379epDGPcENyhmSlD+vH8oOakypSYbPN+U8zjd0GKmjkb9CEZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1917b442-5d50-408c-ab13-08df24616ce4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 10:54:57.0216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PtGRsyeg655xumAZ0SOzfG3LjR7ofOfsawCHrDvYrmExJiGhaG7IJtBxBujFrYrAx7Nos+m/1PU1W6gBtwJZ5QAYD1qAUaFepAknxYJZio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5774
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

On 10/7/2026 9:31 AM, David Marchand wrote:
> Make the common PCI code independent of the VFIO API.
> Move VFIO dma map/unmap operation in Linux only code: adopt the
> same approach than IOMMU VA support and expose a OS specific handler
> which calls a common implementation for FreeBSD and Windows.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
