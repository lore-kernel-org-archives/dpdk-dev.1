Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4BDEC01CB
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 11:34:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62E074065D;
	Mon, 23 Mar 2026 12:34:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1D7114065D
 for <dev@dpdk.org>; Mon, 23 Mar 2026 12:34:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774265682; x=1805801682;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LEcGluDO1HcgaHoyi/8S3FpXbhHGkZrT8CPcXUuf9JY=;
 b=BkcXdNtP304vd7wwyZngGWS9Lvdw3B/KLHSK3WasfirZj3C2sIDZY9Ix
 gS3wdoo6kJf71/YNSWkO0aQHTFdLr4B4NnVG81YcUS9JNP16bT3H+ydHG
 FZBD+N3gd337hOEzakCicePpQ8SqJfcTsbB1C3IIn3RPsvBC0aIRHYGtB
 7y7UavI93TQaxiydRRy3twG9bfHtF7SFxxQZDMKtOxGJpwMfg+4OM1oWz
 JlCgFZO7j9IPTYi3mJpA5tWgjkxWsuqYtEhsDkQk3GWFnaKSVxDVIRCaG
 OvfhuLGm0Yvepe1CIVj7tQCnC1xdlqzDjVrddxqiy+0FCACOjyYDJ2UAi g==;
X-CSE-ConnectionGUID: rHTEa3NZSfC83Jn+yF3u7g==
X-CSE-MsgGUID: Iwm/2ZsGSSmgULu8trOhYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75381081"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="75381081"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 04:34:41 -0700
X-CSE-ConnectionGUID: YhmwxbZzQuK76nPHFmbBDw==
X-CSE-MsgGUID: 1oAUaSv/RWWWkT5rO6kGKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="221165530"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 04:34:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 04:34:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 04:34:40 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 04:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcvG644NU9JzY7dZDAykru829B4TcNC+MDpGvZdGbA0fTpcCN0xzxm4HYT7qomFgW2RnDjzuw7f+Ti5JnLBhCnhkuMqmlTCHLy1VzCyzve7iWlWyxQVzXJ1mHJUPk0pDWEuP7MDniDm78lJA3alKR0EiyQYPSh3njlg/J9jX38Zw4NcPTtJ9JLh8S/2HV2XJyWFKgSiqiwXW8FftGCMDbUShSA5C8EoaoFbRJIiJpGwzgnMS7OLG/OmFwfNW/JmmoLmUePr5roYZpsGxpAqglNB4C6Q9ScIw4F4Fj5rUMLOYqNPy+aj0FAIbRfs+OVuwDnMXNAAjwCbeojfPDsQ/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeRJ8rNjr17ICbmxXeO/ubjYX/EvUExxz30omuSKSI8=;
 b=aYVxfh5Na0aQU3yKkfzVgz6SH+DR9cfmvVLK83KZ4byoeaejc7i18QIn3diADdSv4EVKA62pJoQedRxydtftX/eRSte/5yrQXtV0OUzp8Gggl3ak8fP5usebO44fFOs8TtINp9iX6rXLdhYiQfGvDLDrXl0cpFaNFvOE26vqPw4uESJ0wnRp4GeY+Ihoc9vFgy0GNTo9s8iXcfvUghh+skaYvd71i4BxlkPJ+FG7BmKbmZDXvjSPfy54cN8DlAAEn6Kt25NMM2HQlso3el0wCeOOcGpWwqHrabzYwYX9e35mbxR9y643aULhcH2arj3fLt0I5nPkYvAUjwM4eVjc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:34:38 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:34:38 +0000
Message-ID: <0da44a7a-eb55-4bcc-b128-6e1bf1efa629@intel.com>
Date: Mon, 23 Mar 2026 11:34:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
CC: <nsaxena16@gmail.com>, <mb@smartsharesystems.com>, <adwivedi@marvell.com>, 
 <jerinjacobk@gmail.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <DHA2KCDMUWQ8.2E2MH717JQEH2@redhat.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <DHA2KCDMUWQ8.2E2MH717JQEH2@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0264.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::20) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DS0PR11MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1aa89e-8894-4387-be64-08de88d02a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 8IRWIRo+PbMBWxVhzkHlhtEuyImWzKbcUAxWIgFc+2TgNEB9ZpWZ/zEEShEM+ZsdjR8+Hoezi5rneoGAQaVDyyyRMVH+wtR8XXreYTji5uk6OBq28gZif69EXmtfXUcCmnUr/m9gyRAXmLV5nHcRfWoU8oza//sYY0S1INfF+ixG57Pt4ezwOotSS5UAjDPMRsPa26XeNjYIMBryHBjMkW1HxUSip/1JC0vh7FcJkfQ4BiU+a6AAq2+t5BfpsATIikMY18EsM09mGVb7LaU/18bXw8zaEyGZ+y4DrFXcRNCKk9H3wJ3jESr9nYlDRUTJKIXUBVh8nXDEoOlkL08L4FTSjNHaluy8Wh5TnOSPMqWOAVKrzZWAkYRFffhlm1x7dx+f8iS6hUtem41bQzVg728AfY+skd2jwt+Zn4b+STuvlqJxwZw2uYNI2lt29o9UX7B+oUXkp2BpvbKQjZa6M48vsQ7ln69wRy5PmFBLvDbutRJMXNn14z4wYo9+8zkaoTTZAOsRFfOBXRj9zmW6poKMafiKgDIK2XfO1e4CRSwoT+O/97MzrTmVgw9Iup6d3HsLsCdoaC8iFAOlfTSZ9PxbG2vP/IcFjbfXvPBHLuBRS+wbA7BNrdXymBRjlCV/31Ji5mVuqUx7apD6G9KIJfVpkhclHNVQtZfbdrZwA19BhcY26r7zJswDpBT/e2nY4JMuD+7rBmR5SAZhRFGNT1EykjqfIroL8FWMcN5F0ds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWZUZ1FFQ0FGL1B1UnVrWlRuQjNPeVordFI0U3RhS0xKV1YrUlhtUXpVL25q?=
 =?utf-8?B?VGJJOW9oN1I5cVB5eWl1d0d5eExReFMwZFlUZEdacTJ6dDE3OUVWQ09obmcv?=
 =?utf-8?B?K3kvbDlqSGRRL1IrcUVxNXQ4cUV6NDdSZzR2amhNQ3JWSnFFOEZ4Vm94cC9T?=
 =?utf-8?B?dHBWYmUxZEhLYURCbGZUeWRBbU1wSXNFWC9mYm9Cd3VJTGZQbTk1Y01VbkQv?=
 =?utf-8?B?dUhsRkhYS0xwcG8wc0hlUkNFU29xdTVRekVpWS9MdjY0YzFiaERsVDRsZ0kr?=
 =?utf-8?B?WGZoTnV4THZZaVhISERjSlF4MWpuREhQR3RTZFNqY2xTNHlCaVdzY3cwKzND?=
 =?utf-8?B?dVFubzVReVdMQUkwcktlNVFNYnU0RWxibDd5U2tTZXlCbGM5RUs4VlZjSzAz?=
 =?utf-8?B?aExxdWVhd2hWWkxBeXZUcXl4SUdvc0NuS0dFRlUzR3BVVFQ3cDJGdEVQcEZr?=
 =?utf-8?B?enJENEVpd2VKT09DOS9wK2o0TFVkaVY5OHFVUTBHZ2o2QTRKK2lpYzhHeHhW?=
 =?utf-8?B?ZVphaXJocWJRcm9Ga1phTTJkMkUxQkdwNlorcGpONGlSLzVidjNlTzVtVmVB?=
 =?utf-8?B?VlJmdUUvMGtRTUlrcVpLL0x2a0lZZitPeTY2bEZsWjNsVDYvRXhpRERNZk1u?=
 =?utf-8?B?RGNZc1NyQUppK1dBakljaHNCcXVLSlkvN3hGbDVMQVlyQlFEUlA5bEhyQU9x?=
 =?utf-8?B?cmcyUGkwQUV5VWdiUXdJRjUyQnUwem11VFRQQW0xdCtlcUJSZitPaTdyMGtK?=
 =?utf-8?B?bVBVMHk4T0tpTU4vYlpJUkxZVHd4VXZKT3lWZ3N5LzZtK2pOTFJPNEVja2x3?=
 =?utf-8?B?M3ZVdEFacjdDZDR4ZCtFQXRNVXEwbzJadnJKOUJPcHRydXBrS0h1dVE0RDlZ?=
 =?utf-8?B?UVFrSm5yam1CdERwQXBUK3QzT2tRZGhMTjgvNUhZemkzNldUN0hQUjZrc1F4?=
 =?utf-8?B?UERHMU1BQ0lsZUJiczVZaTJGcUdCSmxOelJHTWpOUmZ3YmYvTjViZFMrNXg5?=
 =?utf-8?B?MFBSRVozd2ZuTkJTQUR2bHB3L0QvZ0RSSFFncDQ3Ti9ZMGF5NEl4aHhkdUVX?=
 =?utf-8?B?em1PRHlITHFEUE9xb240b0RaOWhoRDJaQ3RsL0p4amxUWS8zUGNUZ3pKMFdW?=
 =?utf-8?B?QWJsZUhuRzY5cnk4NnEyWDY2Wno2SmZqS2NaNHZzekZIaEg3SGxsTVpjUUxK?=
 =?utf-8?B?VHRDbDRnU1dwelFJeXZOV3dKanhrLzA4S2JjVGZxL3l3eFNyS1BuejdvdVJD?=
 =?utf-8?B?a2VSNHFraVRobFA4eVkwdEFLU1JNZGlJNDdPUDdZVGE0YUJscFlscjVld3R3?=
 =?utf-8?B?RlRiTWt2MTFiSVQwVkhNaWJRTmFraDFhR2t0eXVFQnRuV3BQUGVhUTl1elkv?=
 =?utf-8?B?ZG90R1RhT1d6NlY3ckM3bm9iQjh2N2NpNjkxWW5WWmFVWmJjaHdEcDJDNDB5?=
 =?utf-8?B?Q05GRXdPbVd2K0M2VkNWb1FVeC9OUlFybDJEVEVMVEhTL3dqK1ZvZ1NKdnlJ?=
 =?utf-8?B?eVl6bG91ZUZSanMyZnByajBwU1UvYnVVQVhHamJjY3FlT0ZLZ0NSNGZPM0lL?=
 =?utf-8?B?VWI0MUZ4dkI3QTFXdFJ5VXNxT1lGK3pQRFQ2QWJlNldqNi9lWmtEWHZTcmNj?=
 =?utf-8?B?ZHNuemhTc3hmRFFqRm0rM2J1MzZxOUxHQ2U0Y3ZPNGlXaWNwSE1HTnRZVFY1?=
 =?utf-8?B?SWl0bGpzWEZ6U1ZmaWMydHZEM3huMmQ2ZjQxRDlpc2hYN2t2ajllR1J6ZXc0?=
 =?utf-8?B?RERTb2M5MmZhTTZWWlkrTmRGc2NiWElxZGgyY2U3eWFQOEFjUWpib1NzODJ3?=
 =?utf-8?B?OE4yOUF5N09jWEdTOC9FMVdVRFFHWEd5eHVjdUJhMlFSZDZjYTQvOFRBSUdu?=
 =?utf-8?B?ZXRwZGg4NmxWRUh2c0U4bzV0T3FXUEUzS3BBZEFsT3lGRnBRcEg4QTAvTlhP?=
 =?utf-8?B?NWdBWk1YOFluVWU2SURSdDRaMllsMGkwYW1Od25oZEJaT2N5VThBejZENndJ?=
 =?utf-8?B?YWlUTHNhVUJYaThHY0cwTW83WndBazJFNlZpZ0pFclZEZHl5d2ZIVzkxN0w5?=
 =?utf-8?B?UitQd1ZkN2tjeERqS3Q4R2FWdlIvT2Y5YnA4c3FLQ3ZXdkZJcU56NklMdTlt?=
 =?utf-8?B?RUVheHZ4aWVQM3VidjBwMjRYR3BOUDFuZWE4enBFNTZXelorYjBtMDNtM21I?=
 =?utf-8?B?MGVhMjIwTmRFZVp2RGJvYk5OUDVRdnZOUWhxU3UrMDU5aEF6TDBuQUErVUNk?=
 =?utf-8?B?UjE3R2kra0ZENmZBUTQ3VEswRFN6d3V5Q3lCUDhvRUpQSHhWQ3JWZE11bVFu?=
 =?utf-8?B?QlRYZjZEK0tHam13d0lpaXBNWnhQSGlPSVB4cHVVR0p0d3hrQnFkMG0xSU4y?=
 =?utf-8?Q?B4qcLOXPr+q6Xke8=3D?=
X-Exchange-RoutingPolicyChecked: J//iH6+B+MDIMoyW5YIH1KBojtBcVaxgSI6skp45Y8mfc6qV6Qd6PRQGqen/oYtt2VjtyfPBnwWX+2B9VXXzM3yLeu+AItA/3FOAuDFbfJeAUq1cbU0ESd4ymXcwpRRkC4tFBB/ZwQ2UyHgC7WsffC4DC/W1AldMjpYq657tsZqtxAevUAQ2U13IyLRIiqepkQlRE6Dhx9g0KdznX1X+8wrOSvKBZ9+DFBDVJ52H98YV2tQrs/DbLkqUE1pBVdlxeG5depYRgIPiXClR+Aw0YeZ2dlIumxb4ALr1EzhHmrh7RN61jefMALuV6+UsYqlpun4nfo7RL8//VH260LWrGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1aa89e-8894-4387-be64-08de88d02a71
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:34:38.1683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmjZg17Vg4S56HKxLBrXHqimVuj6i7eMrqCp22PUl/VXObUzJNpoLuE1x1iaUNSFp5BUHZpeqxkIkkRVcNacjNCn5Ommng7o3ddx2CgG2rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8114
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

Hi Robin,

On 3/23/2026 9:54 AM, Robin Jarry wrote:
> Vladimir Medvedkin, Mar 22, 2026 at 16:42:
>> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
>> allowing a single FIB instance to host multiple isolated routing domains.
>>
>> Currently FIB instance represents one routing instance. For workloads that
>> need multiple VRFs, the only option is to create multiple FIB objects. In a
>> burst oriented datapath, packets in the same batch can belong to different VRFs, so
>> the application either does per-packet lookup in different FIB instances or
>> regroups packets by VRF before lookup. Both approaches are expensive.
>>
>> To remove that cost, this series keeps all VRFs inside one FIB instance and
>> extends lookup input with per-packet VRF IDs.
>>
>> The design follows the existing fast-path structure for both families. IPv4 and
>> IPv6 use multi-ary trees with a 2^24 associativity on a first level (tbl24). The
>> first-level table scales per configured VRF. This increases memory usage, but
>> keeps performance and lookup complexity on par with non-VRF implementation.
>>
>> Vladimir Medvedkin (4):
>>    fib: add multi-VRF support
>>    fib: add VRF functional and unit tests
>>    fib6: add multi-VRF support
>>    fib6: add VRF functional and unit tests
> Hey Vladimir,
>
> Thanks for the series, this is an interesting approach. Does this allow
> sharing the tbl8 arrays amongst VRFs?

Yes! tbl8 array is shared for all VRFs in both IPv4(dir24_8) and IPv6(trie).

-- 
Regards,
Vladimir

