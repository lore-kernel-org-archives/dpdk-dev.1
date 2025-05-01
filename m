Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C1C369DC
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 May 2025 15:54:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5B204060C;
	Thu,  1 May 2025 17:54:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id AFC3040609
 for <dev@dpdk.org>; Thu,  1 May 2025 17:54:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746114892; x=1777650892;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EVvhpkp89dmWno16g8G2c7Rp2kySX2cA8bFiF3ecvyk=;
 b=WpFye8dtdBRMe6JOQvGdP7WTutcrx2rjMvOCF7faVByz8x7IECKHJHWC
 9Y+PLEu5qI8O+9BnVCw+sOKMpBetIZ1ZiTzYd9p5cRuBNwqhIeVmmmXdh
 MfgWEPYjr+dlhjaQJ0Xzl2gQst5avNItZLTNUoBsilnIDwgLPsO8/cY6S
 3eZgWOa8cjOlyjIkIZaqgJ7IUuNxdX+MKuMwsH3x3ECqSCrWLNfpHfs+b
 6ugAdRBn7WdL62AuDNKj93/vOZIQKj13aiDYz0zeHWn+pmImMnsTBYMsr
 5Q2kp6IG2Uu5x2ToiL70HCcDe0hAwgWwLr+cTTjN6hC77hFpfR9cFmJwC g==;
X-CSE-ConnectionGUID: KK4cuf9WQGaOPEfgyEvmfA==
X-CSE-MsgGUID: 5VgSIujqTXOYywOdsiJCwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="57999658"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="57999658"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 08:54:50 -0700
X-CSE-ConnectionGUID: i3bDi/+HSqqvmgBStKsKTQ==
X-CSE-MsgGUID: n0Eqx/A3TUWsQyNAmnapwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="135378673"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 08:54:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 08:54:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 08:54:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 08:54:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiSHOrJwnQEQDb8b+bX13w9TZnRc3lWsjPvM8erOCMfBS5LDqF4UTYVPS5ngkRLY1bpk3oPqwtG1AFx+uO+nosDEMz9iYyFjDguvCT7efg/L7FaD8XlDeuewmU54jD1VTeYF/hXo7sINYKoKqsC6kmxZX9jg+mCtHx+QFJtNfpajWcM+F6Uf+oW/bSXBgdWP4AKgMsGCcTK7ATzrN5Eafp7P1/tOz9tppl4qqbSov5UqNnKwRLnVWMQvq21lE20vKn6QMcFEbQJxTpzKMszCUnwEF5oqWwgNjjxZ72qzXlWbfpDqUs0WCGcPT12tpnyhenQuwNDjbmSiUsJ1+PfXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6KFeqaeAIJG60ZgxV6bwN6CmLfraxD90epcESP7pE4=;
 b=oSE5gj5Gyqid4jh3Rre6tzIfvY1ORea5g3B/pC2yOsbDT7IEFVQfc3HMkdjrrUoabe4pdksjmy4MzwY8Wr42/XHQYsaPNKnAQyGJg21k8vRJvr4iuIdw4kaVHbimpsOY00sb9qdRx0Ndj78PuQe/7vBDFM1WDw2V8bm/3njvXQYYiirt7NUBqASjOS7ezZzi9aSEGb25+bThxeawyamrMD14rwF15w2OzCM/ncDwMhSUttLRwNBA59agbNkx6oqikewPnsxqoSMq9LMPC/GPT6t70Hl8mVNfhDLYh74aKgX049ct8Y3Kbtucw9m5pDYT+GLRDyZ8vwaLMVsl07vwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by PH3PPF5ACB2DC0D.namprd11.prod.outlook.com (2603:10b6:518:1::d23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 15:54:18 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%6]) with mapi id 15.20.8678.025; Thu, 1 May 2025
 15:54:18 +0000
Message-ID: <d2bd99f4-e161-4c9a-9bcd-f35d4dbf2d6c@intel.com>
Date: Thu, 1 May 2025 16:54:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] doc/nics: rework notes for iavf use
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Ian Stokes <ian.stokes@intel.com>, John McNamara <john.mcnamara@intel.com>
References: <20250224152611.1012935-1-bruce.richardson@intel.com>
 <20250224152611.1012935-3-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250224152611.1012935-3-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR04CA0028.eurprd04.prod.outlook.com
 (2603:10a6:10:110::38) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|PH3PPF5ACB2DC0D:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcdddf3-fd66-4d14-4a47-08dd88c86e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjJEaTFFRUpSRC8xTG5PcWh3Y3pQY2EzaG04Q1N2bnBIU2F5d1p1ZzJUMVBK?=
 =?utf-8?B?NWhCMkJGcW0zNHQxNloxeUFiZGh3ZFRSNTgzME5oeFhQZFBjNkQ5ejBSd1dH?=
 =?utf-8?B?SGFSenZqbVNxZmZjbDlTQXl4WGFNallMQlpuN2xmakZubEZ3QUFQajhPNllH?=
 =?utf-8?B?U2wxQkp2VmcvUCtWK3FaQ2FCZzg3WXg2UUY1OHBKL0pIckVNdnhkQ2NNUnlx?=
 =?utf-8?B?MXk0ZHltaWNxdzB4d0xDUDFQbFI1dmdOSmcwWk1qRUJKVVkvdm9mTnFjUk1U?=
 =?utf-8?B?VjNHQmxhTlZvZFQ4d3dZUHFaMDBzV0dpc1g4MjFSZytzRG9yam80ZDM1Tkk0?=
 =?utf-8?B?RTFwMFRsazFoQmM5RVE1Sy84cFdocWZLU1BTZVhDQ1o4VlZEQ2VJUy9FMVN5?=
 =?utf-8?B?aU9VOXF2cmVCS0tkRXRSTUlia0tZVUJ5STRUcytScGZNZE9MRTcrcjIrOHph?=
 =?utf-8?B?ZVI0aWNwMjZVK3ZiVW45NnhNWDYxcUkveUd5RFNXN2ZvNElVQ2NpeS8vcVZz?=
 =?utf-8?B?c2FDcVM0WWNjRVFYSkpnbndkL0QxMUpha1ovMFFBc00xRHByazkrUEhibWNr?=
 =?utf-8?B?djVsVVJTelZpenhoZ3BNT04yQ2Vtdmx3UlNzMUpVTFd3L2dyUXlVQzZXMnkx?=
 =?utf-8?B?MCs5Q0xVNmc4eWNKeGUwbW9zTzNsTHRETjBIcXl0Z05ZVlEwQldwNVkwRlNw?=
 =?utf-8?B?dXZ4NVFDOExnWllXY0pxMktIVCtBZGtrNEVVRWNuZG84L2hxbW1XSlRBdlZE?=
 =?utf-8?B?aWtEOVZ1Skg5MmtOYUdqRUxEZmIzNnBHR3FjVVJTR2RZRjJxUTgyeXVreEFa?=
 =?utf-8?B?dXczdG4xZkN5SGtnNUV4dHJCbGJYRlhRZlJmOGRJeUZ0dUQzc1kxc2t2RzhN?=
 =?utf-8?B?RnNDRlVOaWtIaGEzR0NDSGZhNlUwSmsrU2haRmg4b2NGRFRPdHZLK2JjMGEv?=
 =?utf-8?B?eUovZGI2WEJtb09QZkdvalZqVTJhOGtSaTZzRGhRM3A4a1BmZndXZVJBT1No?=
 =?utf-8?B?U3RHZDNNZkFGM0VmeEJLNkFLUG5DTHVGekJReDlnSXMybTl0V1BtdGhZdnds?=
 =?utf-8?B?dHJaMEtEeGV3MTYvSnF1OXNhZkNQZGxTeFVjd3MyRFdzV3gxb0JWM0RiL3A5?=
 =?utf-8?B?dFhZbEhuZE5XN3k1S0NpVTBsK0dZWGJYUEJsTXNQalJsZTNCOWpkL2JVT1hh?=
 =?utf-8?B?aXAyKzlVRi91NmdsL0FOVkFLZlhLQkpkUXZOUEh6Q1h0SUFtNFg5L0VJRlZv?=
 =?utf-8?B?MTlQTDJ3akhFbnhGTEpqbmZRQmtjdmRyMEZuamZiNlBmUkdXRkxLMFduUUhk?=
 =?utf-8?B?WWx5MTVTbUNwS2hFbWt3YzBESC94dWNFb2d4aDJLeXZOOE0rem9SdHdLZ05j?=
 =?utf-8?B?TVJQQmZPYmpvRkhlYzZtZmVxMU1kdTNUSGJ3ZGsvVnVNSGtPbjBJV2E0cldu?=
 =?utf-8?B?djdMcjQzcFRsTytCS3BCMmJvTVVyT2trd3I4N3YzSTg1NHptdjdCUUpYN3Qw?=
 =?utf-8?B?VG1jSTRqaDJJRzV5aXQ0VGZJRFBaUUdmdDRheTZjZU9MNC9BK3J2RzRjbnV0?=
 =?utf-8?B?R1kvZ01iMWcwbnp5NUdaZENTNmcvOUNwOFdjRmcwWkk4SkZPdjczMHBVMnFO?=
 =?utf-8?B?Q09WVU85dmhqTUNNQ3Z2ZThHK3pFQW5oanFuY0VmTjNVZXlTSVlZcFJLUzkv?=
 =?utf-8?B?ajFWWVpIbHB6ZFdnN005VEk0a3V5U01xVGRBS3pkcmxZS3VoWmgrQXVJL2Jy?=
 =?utf-8?B?Q2JHRisxL095TnBoSWIycTJHYlZqSGFwc3cxNU44QUY3ZTZ3QjNwdjdWNjFa?=
 =?utf-8?B?VVNCbFlhaG1NMGx5VEl2akp3RlZHMnhEL3hWa1BjR1NHNW9CWDFTMkpCTFpq?=
 =?utf-8?B?d0lPVTZDMml2S2hDVWZ2UGkrQWQ2WjllVG16clhmcEFHekZQZnRXZm1IVFd3?=
 =?utf-8?Q?F1G7oJ/LcvM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODJwZTgrOXZoSGFPUDQ1K0swWmw0cDRCYW9KVGdYSU1Uc1duN0FrMnpDT2ZS?=
 =?utf-8?B?UEJ1bUlDMGFqMmpDN0U2cU9SbVM4eGhkbWduMXJpVW9ORkZLQzBWQnJaQnhw?=
 =?utf-8?B?d1NqWUZTVUpocm5zUVVaWUhKcCs3L01IR1IwQmJiZ21tOURCWDRINEhkWVhD?=
 =?utf-8?B?TWZqNGhmNzVRZTRLb2VEaDcvdWtyNXhkbE4zdjArQjFqY2lkc1ZWd1g2dk5z?=
 =?utf-8?B?Y1hEOTNSUGdkdW5nbVpJam1nSEkya3JXb3laaDREaXJVUFl6TEJmbTYzNXNx?=
 =?utf-8?B?cWJ0eGdsWEtkM2J5dU9obDZ5MWVER00wTTV4S1Q0VGlobWpMYzBLeFRLYksr?=
 =?utf-8?B?UXBKakswbVB6NFkybmdKUGdsb3NvdlJFNTIrQWRoSGRuY21rTXVrYUsxU1oz?=
 =?utf-8?B?bkNrOW9HTW5KZVo4ajc0NVdIOVBabmVabUk4N3lJMGx0bXNURGVlRUFWY0VK?=
 =?utf-8?B?Q0NlU1FvRjJoWGUyRjlvVTVLSWozTHRKcDJYUGR0eVArVWFxT0FkczRCTnhm?=
 =?utf-8?B?WEtTMGkvVWE1dUkrcEhKWitHSDZONUFkZm84cmYwQk5RVkg1bTRnelZPalVV?=
 =?utf-8?B?VWNJQWdwOUZUMXZWcWk2cDFBUjduWkNxekZEd0x1a1YwWGo4Yyt6ekJTQU9K?=
 =?utf-8?B?ZG5pU3hPMzUvUkVmTmYrMXZFK1pjSS9tNTJmd2tTNmx6M0g5anpMVmU5Mzhv?=
 =?utf-8?B?RGF5Z3E4cHByL3k1U0tQQWFwQlZwWE16V291WGhsS2lnUGI3Qm1YaFJRSE1V?=
 =?utf-8?B?QzZNWm5VZUVmWmkrUE04WXBadk5Ib2pXSFBuTThMWHBGdWZKeXcvKzZYN0I3?=
 =?utf-8?B?a0xZS1I3UGttZFZxUitTbHF5ZG1lT1RrVlFmZXhpZGR3VnVwVzR4UVYwSUdP?=
 =?utf-8?B?SzlNZEpSOHZJOVFIZTdvSUNoU0FKYzJCQytVMTcwTWZEcmNMRmhtUmM3eDh2?=
 =?utf-8?B?NkZiTk1aR3FQK1RYOGhiMEVDS3plZ3U0V1IwdldCdGRQWXFyK1JaYkU5cVEw?=
 =?utf-8?B?RlNXRVJpRlMydDVKSC9ITndOYWR3RTVaMUV3cEEzUE1IZUhiNDBkSFBDZldo?=
 =?utf-8?B?WXZ4dzJGbmo0aG9PcmhqYkcwRm92QmtUc3QvZDZVcjVKZlZJZXZ2Q2xhR2cz?=
 =?utf-8?B?UzlPU09RQiszNDdqNVJOcHdCRG5YRWpiRnRoMzkwbDMxVVVrTTRsRGV1a2Er?=
 =?utf-8?B?bFFvUk1xSE1QVExydndwN1hUaTdwSUZsMEkrNWgwWVFCdTlFRkhlNWJVYTF6?=
 =?utf-8?B?dDlVT3RKenJoU0pkVGt1RlU5UkpyUlk5cFNSY2xLMFFLSmdVNExOenRtZXpy?=
 =?utf-8?B?RDlJeEFna0FnMnlzQkdGOHBtNHl5ZmVzOStOQ01Fd29OckhGbUhCbVJJaGFh?=
 =?utf-8?B?WUl1UlhGTmlVcjF6RHdTMXcrNHpKS0dMUkRlVk1mQ2pEZGMxMURPZkp5T2tm?=
 =?utf-8?B?bnp6ZmNQRSt3ZmdTeVJnZ3N6Y1VveUVUUU9neWl4QnpOTmg4RGNnRVdWM2hk?=
 =?utf-8?B?SENQNGplRExNS0Z1TFI0TzZCOG50RTVOSjNMemh5NGpYQUxXTjFHMk04MmtE?=
 =?utf-8?B?dGw4blpGQTBTNU5jQS9IbnNpWkt0M3pvdXZ3a2E1UzN2NC92MVBmdjNjSXI5?=
 =?utf-8?B?eUlqb0J0aDV0Yy9SYkx1Uk5VTmpEcTkxUXdDK1pkbXpFUld2UURJOGMyekxx?=
 =?utf-8?B?Q0VnU3JkNGVwSytrL3BmK2hyT0tIczZNYW1WVUtZUnRCV084L1k3ajlMbkdk?=
 =?utf-8?B?UTJkTDQzdnh1UkF6emYwSVZycUtKSHpLbVZaL2RzTDZONFlDNGxWYm16RG92?=
 =?utf-8?B?TFZKVmk5VDJGSXA0dWZra0RIcEMwMWh3MmR1VkdSL0cyOEpYYjc1MThaejdp?=
 =?utf-8?B?SHdYN0oybTdaVW5GTklDcWlOL291WFRjcUtKRUdZSHRJZkJTcWFqclV0c3dj?=
 =?utf-8?B?WllaTURnSVZ4UXB5eWRwcUE3UEpwbXorNy9UZXRTeGR2TVNaL3hPa0czYTFP?=
 =?utf-8?B?K0o0UU5PS2FjM0FGOTU3ZnNqN1h4eGV0QjJOK3lRUUY0Mjh1bit0NHlWNGUr?=
 =?utf-8?B?ckFtYjdCMHJ6M0wvQS9weitqSVBKUmRZeVpxQ2toODNPeVhxcDU3cmJ1bGx0?=
 =?utf-8?B?QTBlUmhBeHkxYnl1NGc0Sjl0QmcvNUtsU1Nuam44Q0tISTlUNGJjZjZRcVlv?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcdddf3-fd66-4d14-4a47-08dd88c86e5d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 15:54:18.5559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzc69cPTu7Y83B4VS9pOlBOaTjq6yiel5MxdEXGsjjI0L8n1tBLont8aUXjwiHgHEjdoSz8xumKDUeLQ87eG9HIS7r8op8Gkq979oWEvcWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5ACB2DC0D
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

On 24/02/2025 15:26, Bruce Richardson wrote:
> When describing the iavf driver, there was a lot of text in a single
> note block which could be clarified by splitting it up into separate
> sections and appropriate bulletted lists.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   doc/guides/nics/intel_vf.rst | 60 +++++++++++++++++++++---------------
>   1 file changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
> index 2b0eebcafe..708cb85417 100644
> --- a/doc/guides/nics/intel_vf.rst
> +++ b/doc/guides/nics/intel_vf.rst
> @@ -88,36 +88,26 @@ For more detail on SR-IOV, please refer to the following documents:
>   
>   *   `Intel® IAVF HAS <https://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/ethernet-adaptive-virtual-function-hardware-spec.pdf>`_
>   
> -.. note::
> -
> -    To use DPDK IAVF PMD on Intel® 700 Series Ethernet Controller, the device id (0x1889) need to specified during device
> -    assignment in hypervisor. Take qemu for example, the device assignment should carry the IAVF device id (0x1889) like
> -    ``-device vfio-pci,x-pci-device-id=0x1889,host=03:0a.0``.
> -
> -    When IAVF is backed by an Intel® E810 device, the "Protocol Extraction" feature which is supported by ice PMD is also
> -    available for IAVF PMD. The same devargs with the same parameters can be applied to IAVF PMD, for detail please reference
> -    the section ``Protocol extraction for per queue`` of ice.rst.
> -
> -    Quanta size configuration is also supported when IAVF is backed by an Intel® E810 device by setting ``devargs``
> -    parameter ``quanta_size`` like ``-a 18:00.0,quanta_size=2048``. The default value is 1024, and quanta size should be
> -    set as the product of 64 in legacy host interface mode.
> -
> -    When IAVF is backed by an Intel® E810 device or an Intel® 700 Series Ethernet device, the reset watchdog is enabled
> -    when link state changes to down. The default period is 2000us, defined by ``IAVF_DEV_WATCHDOG_PERIOD``.
> -    Set ``devargs`` parameter ``watchdog_period`` to adjust the watchdog period in microseconds, or set it to 0 to disable the watchdog,
> +IAVF PMD parameters
> +^^^^^^^^^^^^^^^^^^^
> +
> +``watchdog_period``
> +    The reset watchdog is enabled when link state changes to down.
> +    The default period is 2000us, defined by ``IAVF_DEV_WATCHDOG_PERIOD``.
> +    Set ``devargs`` parameter ``watchdog_period`` to adjust the watchdog period in microseconds,
> +    or set it to 0 to disable the watchdog,
>       for example, ``-a 18:01.0,watchdog_period=5000`` or ``-a 18:01.0,watchdog_period=0``.
>   
> -    Enable VF auto-reset by setting the devargs parameter like ``-a 18:01.0,auto_reset=1``
> -    when IAVF is backed by an Intel\ |reg| E810 device
> -    or an Intel\ |reg| 700 Series Ethernet device.
> +``auto_reset``
> +    Enable VF auto-reset by setting the devargs parameter,
> +    for example ``-a 18:01.0,auto_reset=1``,
>   
> +``no-poll-on-link-down``
>       Stop polling Rx/Tx hardware queue when link is down
> -    by setting the ``devargs`` parameter like ``-a 18:01.0,no-poll-on-link-down=1``
> -    when IAVF is backed by an Intel\ |reg| E810 device or an Intel\ |reg| 700 Series Ethernet device.
> +    by setting the ``devargs`` parameter like ``-a 18:01.0,no-poll-on-link-down=1``.
>   
> -    Similarly, when IAVF is backed by an Intel\ |reg| E810 device
> -    or an Intel\ |reg| 700 Series Ethernet device,
> -    set the ``devargs`` parameter ``mbuf_check`` to enable Tx diagnostics.
> +``mbuf_check``
> +    Set the ``devargs`` parameter ``mbuf_check`` to enable Tx diagnostics.
>       For example, ``-a 18:01.0,mbuf_check=<case>`` or ``-a 18:01.0,mbuf_check=[<case1>,<case2>...]``.
>       Thereafter, ``rte_eth_xstats_get()`` can be used to get the error counts,
>       which are collected in ``tx_mbuf_error_packets`` xstats.
> @@ -129,6 +119,26 @@ For more detail on SR-IOV, please refer to the following documents:
>       * ``segment``: Check number of mbuf segments does not exceed HW limits.
>       * ``offload``: Check for use of an unsupported offload flag.
>   
> +
> +HW-Specific Notes For IAVF
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Intel\ |reg| 700 Series Ethernet devices:
> +
> +* To use DPDK IAVF PMD the device id (0x1889) need to specified during device assignment in hypervisor.
> +  For example, on qemu, the device assignment should carry the IAVF device id (0x1889) like
> +  ``-device vfio-pci,x-pci-device-id=0x1889,host=03:0a.0``.
> +
> +Intel\ |reg| E800 Series Ethernet devices:
> +
> +* the "Protocol Extraction" feature which is supported by ice PMD is also available for IAVF PMD. The same devargs with the same parameters can be applied to IAVF PMD.
> +  for Detail please reference the section ``Protocol extraction for per queue`` of ice.rst.
> +
> +* Quanta size configuration is supported by setting ``devargs`` parameter ``quanta_size``,
> +  for example: ``-a 18:00.0,quanta_size=2048``.
> +  The default value is 1024, and quanta size should be set as the product of 64 in legacy host interface mode.
> +
> +
>   The PCIE host-interface of Intel Ethernet Switch FM10000 Series VF infrastructure
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   

-- 
Regards,
Vladimir

