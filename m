Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506FEC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 14:39:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 827C64060C;
	Fri, 27 Jun 2025 16:39:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 229ED400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 16:39:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751035185; x=1782571185;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=1xA2IF/fcePV3L0vEeOJ6/nM26i9VZhAx3kZjMI9VeY=;
 b=lCTnqz1Lnr6cCbP14ZGeGii46GCTTeLTQq5uHmsuUvZ82fu09hTT4Y4i
 leq9VxPnWPmnQMd5eH2fQMHtwJIfn+cGXuYXYtqh1DT6z+/h/TqLOG7ge
 NfaF53OfqfdIz1ldAcWU819qHI0jbaLsm9REXYAGddlXKCNzdO1VNHxgh
 smL4RIiXN5Fio9HZLnneX1mbC5sFYWAIVr7brqe7FDWVI+/iCYvY8l5PQ
 YKMAFMttv8px3VpFikYCQaXfqIYaBhooyu/UBBPdOluZrcRWJz/xPS/0q
 Wbb+paoDmnSifoytOhW5ZmlqGbLRCLEOI9jH3hBc4mFdFeL5gle3DGXmn g==;
X-CSE-ConnectionGUID: D//D3fuXRyyAFoRZaFM3qg==
X-CSE-MsgGUID: 8RUCKF/ASUK/Ly351j7BKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="52581670"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="52581670"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 07:39:45 -0700
X-CSE-ConnectionGUID: r91KAm0QQO2yKt6Cct/+OQ==
X-CSE-MsgGUID: v1bLxq7gTR6m2eJZ1IZBtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="158305821"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 07:39:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 07:39:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 07:39:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.64)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 07:39:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH1YPZ6NfGbmwzc2o6g+2CN2GRBGR7LXCo6OakiCHy8BpU18uTnTgMh/+kMscY4va4cYX8gNpLHcBb0vGB4+grfraH0/vPz3/LbKMFo9CYi9mvCftx8CcimAxLhqPBH+HhvPnyFQqXeW92QrsO8Zfdw+cNIE71wFIpOdDmNlzQTNVkNi0aYh2VA1EKVX4e3KGLaXiaXSa5cMwgc3cLW2QCipTQ2NNhvnMH11IvKCAqHVTFON/Fkn3DjKhWDnGDOvofcSUcFdIFm9yfklfOiJdRMJNixCFwlEIm+ndJKuWyQRiDauKTe0S+0JDWezE6sNRC8PumR6yFV+Pv3DZnO/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGozVbw9OhPfnNb40mYFxxJZtrhYEZTzYG3BjRBmt98=;
 b=Som/HHYN8QrDE65n2BLb8oRGiRPeCkBjb4Gn3RnVF/wtrpf8htyN6ltXTcjTSLhAiLmnMqXBU03MhWmqO3wbgYujThkGz9TrBoeWXd6sRkr09bq3mE+ardD7gzH3iUMuzxppqcwIBKIdXHddABAn57HUnmEcAqNDMFyclJGJE7I2a9+N0db3JvDWXenONn8gvy01wqDj0b9qpBw5FliCp3UNFJVOM9k3/1mg6D4SDRBcwbnp+2fY8CM2LKCJxnuacz7SQ4Umx0MBEoIsT398lgLnUgUae4Qwe3RI1bDmqTh6gskBBNFjL0eo9pPkHecCKYHACDCl/p1fhw67bDT5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB7550.namprd11.prod.outlook.com (2603:10b6:510:27d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 14:39:41 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 14:39:41 +0000
Message-ID: <e36845cd-f75a-4593-a4ef-1b554d3a0e24@intel.com>
Date: Fri, 27 Jun 2025 16:39:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] eal: merge corelist and core mapping options
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <20250527152913.279011-3-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250527152913.279011-3-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0661.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b82b57c-6992-4c6d-51f0-08ddb5887369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVRBK2t3VWdGd3NCbVdldTVDQUs3OGJuME9SeGRHVUxuVk9ZeHZObEFMTnBE?=
 =?utf-8?B?WEdDalRYOHhuMnk5WHpvTWVadmMwcGE0TS9STGJ4Rm0xNnl1VEdhbXNmelFH?=
 =?utf-8?B?c1lEeVM2blZNQVFLZDMrN0tNTE1uN0crc1FMOVlUWllQMGdHVjBZdEVkaldw?=
 =?utf-8?B?TlJZZUYrbG83UGN2UUliZmhoS29DUHYwVHZ3WStxU3FnUmVUZkdZREVSY0Ja?=
 =?utf-8?B?ZzZvNTBIY2FMWHJWSzlySWpTc2l6dnN1MHRDK0JUN2tRRkVNdTZFN0UwQjZZ?=
 =?utf-8?B?QzlCUkw5TXNMN0c4Z2VVaFhuRDRwTjBMTDZiM2VsOWhEQ0JwcWc5ZEczTWxi?=
 =?utf-8?B?ZTVINGs4VHZabmNWT3lIWFQ4RU43VzkyM093Y2FHRkdpQ0dTclM5MENIQVpS?=
 =?utf-8?B?TkZNcHVUOHdISVhDajJFOUlHbXJVRGhIVWZuRjdRL1ZqK1lHb05Ua3hOQjJR?=
 =?utf-8?B?LzRKT01NaDlLalNibzVLRUtaMVI5d0hDdVFlYldEdVhqUkY1cmlFc2ptazVk?=
 =?utf-8?B?aEdQWkJ3MlBIRVVmUHltVmhuQnJNMlpHb1dRZ2YwR2RzUDRYNFpUc1BqbUtx?=
 =?utf-8?B?NG0wQk9XOFFTQjA5TmlTdEFCUVRlVzR1Tk5tbnhYSXYxODQzUW5IVURaMFpz?=
 =?utf-8?B?WUNhUGxaQTF0LzFyS2lsdzBDdDJOVU5vZUJWcS80V2tiY21UbENRaEJuWW90?=
 =?utf-8?B?Uk9UU2E1QU5uRTNyU1orc3RKVkdHWE16L1R2UkhkTk1Jdld1UGVFaUNROVNm?=
 =?utf-8?B?K0tKb25EL0pHS3l2MWlhSmxydVJwU3VzOGpIN2xRbnQyMzFSYm9HVm1oN29V?=
 =?utf-8?B?ZnlnNk94cU41eE9zOC95ajlXMmlWaCtrWFFSY3FjQnUzdjQwVEJGNTgxWUJl?=
 =?utf-8?B?bHcvT3hMQ2JONWUrU1lpd0lTV3htWFBtVkRMYTRvN2NLdFc4R3NEeUxpQkRP?=
 =?utf-8?B?RlBGWG1QdzROekkxQlFKdjl5bkcyNGY1QkhIWVJTYW0yaUxoZlQreHpKVHU2?=
 =?utf-8?B?TlBocndoNTkxVXNVZGVoVWtaWmZxSWxmUDJTaUVqOFNZbWw3TXdGSWxOR0Zk?=
 =?utf-8?B?ZS9aMVROZm9uRDNqUnlaakpRdGRLWVFwSmhscGVBcnoxMUdMcnlxbzViZHV6?=
 =?utf-8?B?VnpMZG1ENjNuYWRsTzUrY3BtbXFabUFFMzBzQWVjZ29pL1ZxS1BSUGJ2T1hQ?=
 =?utf-8?B?WlJnWHlaNW9qaVIvRG8vRGJ5dkxNS3hWak9MQzV0RDk5bDNNZVhKYmYrVG0v?=
 =?utf-8?B?S0lGNG1CT0JMcDlnbzZjVDdHUkVqU3dYU2lZNFpwS3o5OSszNWJiNktweStt?=
 =?utf-8?B?bStiVG1mWEVOa2E3eGMxR21iZEYzeTZjQ0lxY093cFVubkI5TUdhRmZDMk5i?=
 =?utf-8?B?S2ZqZXhFK2cxNDZWbFdhNStpWWdSM1U3Y2FqeGw1M1UxVUVtRUUxZmFWb2RV?=
 =?utf-8?B?M29CRTdOSFh5T29GeS82ekIxQXI1aEtrZW1nU1RsTjUza1JCbjlMVW1hbDhj?=
 =?utf-8?B?bUxkSUUrcEduVEE0ZTdLVTd1VFo4MUY1ZFhKWXlhNGZsWkRFQVhBYVB4NHdD?=
 =?utf-8?B?VHdFcE5aLzZhNTU3L0Q3ZEhrUmFBRlFhNTYzU0ZNL2pDTk5nbDVpQUVMVWJi?=
 =?utf-8?B?QXlpYjMwQnZGVUJxRjF4QWNWSWtMUXJqd1gvZGZkcjhaSHpqbWhMdEZENzNY?=
 =?utf-8?B?ZXRoNGtnNUp3TEFxSzR6ck1Zb1hvYzJnZ2lBSU9GWCtaSUFFdDFTb013UGZu?=
 =?utf-8?B?SVZTWGNIMGFWQUxIblU2Q0EzUi8yUHBiK09yY2JRZEs2aCtNNGEzL2d5VUpx?=
 =?utf-8?B?aWZXOEZPY1JTa28wVmczNDZ5UlR1T01aY0Exc1FkZk9ZZTR2NW9laytXWUxk?=
 =?utf-8?B?QmU0VDhucDByRzNoUEdyVkRQZzYrdnBXc2phWUUwRmJDdjdpRDJXOFU3UnV5?=
 =?utf-8?Q?F0ks51pToTw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cko1OVZHOURXc0tRSXMyaUVrQi8rK0JFRE96aVlDVnJsTHZKaUhKVnI1VHZr?=
 =?utf-8?B?a0ZxVUhUTlRCbnpEVkdKRWpTV0crOWExSGFubnljelZZOFljdHgwaWRJWC9h?=
 =?utf-8?B?NDJRSXhUZUdWZG5SMzIyNUxEWFZXSjUwNmw4TStuYUthSkcxM0tqVGo0Q0hN?=
 =?utf-8?B?WUZZNWpldU50L045YStla0VhNCtMYkUrMkttNURRYmVucDQ3Q0hFbEdKb201?=
 =?utf-8?B?d1NpeVY5ZFk3VG4vZ2xwaVRxRGxKeW9OT1dMWlo1Nis0VDE3NXZ6RDl3dnJZ?=
 =?utf-8?B?OHBvdUxPK040dU9ycWR6Ny84TW1DeXVFU3VlandXR2VoV0xoemd4UXJyck9V?=
 =?utf-8?B?R1N2Zld6RkZDcG83QjVmeEozdHVIcmJGMGNBTWhVOHIrZ1dzN2NVOWtKV3Y5?=
 =?utf-8?B?OWJNTEZWbzNHNlBDeEZIVCsyelpoUVhKY3Z0L1dOMWsyUk9xSlJQdDFxL2I3?=
 =?utf-8?B?REZCbHoxOEllZy80em5BTFl2a2ZLWjE5M1JsdVhYRlRaMnpOUjk1SkJaMmJQ?=
 =?utf-8?B?TVNiakdYTTJtbmMrUEdjKzg0ckd2eExvVXFIYXNUcVN5ZXJ6ekhMaTRBNURJ?=
 =?utf-8?B?eGlSR1dTRDdWSnhPVkk5NC9aT0NlR0RwLzBvSHpyQ2JTSFVMOXF3RDVWTEwz?=
 =?utf-8?B?eFZxbVNEQzZwS3FzN05DRHJHZ3lmU2hxdjJFV3h5SFpCQmQzUDVCRjZjWjRa?=
 =?utf-8?B?Y3JBNFZuanloa3F4SXdGYlNFSU5wUkorVVhxeFZ4OVh0WnJrV3VHZ1hob2RQ?=
 =?utf-8?B?WUEvbUkrcmRFbFZyYjA2djE4SWk3eHN1Z0tmUHRYOW1SM0hWTFg0U1RSdDhi?=
 =?utf-8?B?VlEvckJEeE1EVWVESjhYeEFHVTVqWGplNm1obG03NlNKT3QrNUkzQ3MxbXdk?=
 =?utf-8?B?VzViZUJkNDZQam1yQk9aUjEvM1RMaXNZM0pEQVNFVEFIaktvNVVUQ1d2Ly9r?=
 =?utf-8?B?NHZTUzA2N0RIcDkwMmJCMmtCcnlaek5jM05WK0ozRDFSTnBrQmVCNGNtUUdy?=
 =?utf-8?B?Y0ZucjdOZHdqWjl6K291K2VpRnZ3TVU4VTJXZ0k0a09Tb0c2eG13ZUZLYWxV?=
 =?utf-8?B?MGZIQnIyekxtTmw0SG5TSnlBUXZQSVh5NUlyYXNqQWV0d21kYXFSOUZCcGQ5?=
 =?utf-8?B?TjF6RS9aYzZPTkpONWVidENBMHFiTzRLYXI4TDJnblhVelJ0bWFzbTg0dXla?=
 =?utf-8?B?Z1B3dFVMT3RQcGxMK0E1VW0vRngzMDJpQ2RveE4rbEJiaXRmNXZvWXQwZ2hW?=
 =?utf-8?B?T3pmT0ZyRS83Nmh2NHNCd2pWS282TnRQei8xbnJqUU8rd3ZEd2Y1S3dZbE83?=
 =?utf-8?B?VGxYdkIrNmdsWVJPUE1MQUhmLzBzbHJmS3g0aUZ0MU5xK2ROdzliekxYbEJl?=
 =?utf-8?B?YTl6VFJPUGhCNGVrL2FuNk9ORkVmOG9mSVVrb0dSM1FhUkNPL2drS1ZhOG0r?=
 =?utf-8?B?am1YelhwSDdHN2d6Vy9LTkU4U0RxTWlrRG1hNTJGNncvb2RzOUMwb1NEejlB?=
 =?utf-8?B?d1dYYTdZcGNoaThlRGJvdlFEeXpWTkdLVURrRkRQTS9RMXJ1UTRjck5PY3U4?=
 =?utf-8?B?MVBmZ1BJVzhiTUEyUkZKY3JOeUFGQlJ4eUtIcUFUdU5oU0UvU01kaDZtZEZu?=
 =?utf-8?B?elZrTEFRMFAwc0xxK0hsM1JYeWxVNE1zcDlmbHAyQ0NZcEoxTVZnSjVDTUtZ?=
 =?utf-8?B?d1JwYnB3NzV0VVdFUDQzMU1rTXpHemovYlQvNnhLbENCYXFXRzVRWDJ1SGQ5?=
 =?utf-8?B?THJ2SGI0K25KWHhzQjdtc084Um0ySWhkZVNCMkczL1ltWk5pOUlKWDZLakJy?=
 =?utf-8?B?bHpLbVo3eVJUNmlPd2c3cUZubE0vRDZLY1R4WXlOd252ZmoyQUFUZElEOVdm?=
 =?utf-8?B?UTdoL1Vrd2ZPeHBjamFIWjBXNkxsbVN1MHVjNy95RDd5SWtCMElFcTVwbzRh?=
 =?utf-8?B?LzUyaXp5SUhDVHFRTGJrMWJ3dHpKQ1RzU3RESThWeElFMWhrRHpiYUM3NkVo?=
 =?utf-8?B?L2Vod3dSRS9TUVVRdTE3QTF5cThsak1YbjVCd0RPYTBTZ1duSVluRUJ5T0NP?=
 =?utf-8?B?azZOSGlrU0pzN2QrUDcxSXc5Q291N0wrZlVvNVI4eis0Q3ErRy81Nnk1a3pi?=
 =?utf-8?B?OEdJcHFrTnlocndMRmhsdjhEOXlGOFR4OEdDWUErMHpmQ1FXemhuV3pWT3VB?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b82b57c-6992-4c6d-51f0-08ddb5887369
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:39:41.4486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vxe4dNt9PyrBKnkRxnnVKNBz0qbuK9AmoSPKWexuWg1Gj2+kf0jUY/9FJKnkTPfTTOfutw9Hg6qzN0dHWF95UxgFWOGnWKL9CAShqE47LhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7550
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

On 5/27/2025 5:29 PM, Bruce Richardson wrote:
> The "-l" EAL parameter supported a subset of the features that were
> provided by the "--lcores" long option. There is no need to have two
> different options with different behaviour in this case, so we can just
> eliminate the special-case handling for "-l", and have it as a shortened
> form of "--lcores".
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-By: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
