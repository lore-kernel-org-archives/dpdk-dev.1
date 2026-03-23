Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B97BF483E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 18:43:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65EC6402D6;
	Mon, 23 Mar 2026 19:43:13 +0100 (CET)
Received: from mgamail.intel.com (unknown [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id A079640268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 19:43:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774291391; x=1805827391;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=W/gEyz6Nr0JvNSnXs6HXpZkR6uo42n6LvhDmtCOgKzI=;
 b=FPaG+JA8yXarpItBniuQf/CjnrGfmgxBl3iS0cNjKcYiyuhkHauQVqPq
 paBdoFnDIAhnf0T8M9qunq+HcfLGxahBuEnVmukQILoXf+tgjbFrtv9Rt
 nlQSUfqj3BWCB05TaRL6ywgqwbxtAnEWOTyoaCKUWnCWXceHhPA+0FShV
 jTKCcUq8U56WYTF9LMH5AH9D0dNHxuSpgV1dNAt3ALaazlmhB3O0NZ4b2
 Q487JGPdQAasGJ7ggvVIdZ8jGU8+j6yDM70WSJC85bNR5i51WlP2ZhDz/
 fMZpnOuKLlxIStq4IZek60vczC5ymCMwjeDcref1PmidcTf77JuP2tY4d Q==;
X-CSE-ConnectionGUID: KIawstAuRqyExoJFcDn9LA==
X-CSE-MsgGUID: NDEva2P8Rr+fO/mCSe240Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="100750517"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="100750517"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 11:43:04 -0700
X-CSE-ConnectionGUID: r7uU6rAfQmK/kGtaNChdDw==
X-CSE-MsgGUID: RKacQNceRFamm2tK1TERzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="254594898"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 11:43:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 11:43:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 11:43:03 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 11:43:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8vodBE1SpEMx2Crz9uybTWQjwy+YNP61nEaKk2fYexFGM+FmyC6cmjIcAXTS9Qrzt1onA8Q8StwLJt4gYCRk16GTtLtFextDK/fcoE/E5A2hq/mtCHmVCiFdSU6N0AU3LOerv0yYSAD7cZdsaj4/SK4sqTNZbhbWFRPJl+/QKZFBQSmJLMfvdBuvltUfgHTgkGABDWvTCBDyPkTIpicQo2R9parYtmp6nnt9j7ZyPySqLgyygxBUP5Y0MqVKEUZmcSlucpRa7U50TOiVC+LvMPqiXr0H1gthKeoO//0D+vKwQq6iw6HlA+edfazfmQSpjQb+U8QZ/4/MBWe+brpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4Tu89Xe3Y4ONbQDqELZXRtXx4lagR7FtGAfwVtyrtY=;
 b=dj+EYGNCmhL2UomIuywPK3MMcf0IaXMwqLlac942qIDZYeIjgDUy91AL/VRx95HBpZiIFMZ4kfP31FmD/Nwic62awcUejGjNpPMt8AweplVMRwd+4HAcNjAEUJrzeKtaLyRh95u2pZJyHtm4Z7uI1DSOqB3+tnVdWhACEkkrz865T5gaq3AWju6SLLuk0QPSHvmd1b9ncB0nvh40b99P29NQyMVj5tRMdHhYGkOmc7188ySsBlVh4hGHyEM7S5ph+Z/gKc6ru3pwHjR9TMYPv4G7b2mc0vUCDq15O6SSk+GK5blPgoZ+dpbuIstbE2R+XDpEavAmauQk2m4vKfGGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SJ0PR11MB5215.namprd11.prod.outlook.com (2603:10b6:a03:2d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 18:42:57 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 18:42:57 +0000
Message-ID: <d944f17d-35a7-42d3-9011-2d368f530474@intel.com>
Date: Mon, 23 Mar 2026 18:42:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
To: Maxime Leroy <maxime@leroys.fr>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <nsaxena16@gmail.com>,
 <mb@smartsharesystems.com>, <adwivedi@marvell.com>, <jerinjacobk@gmail.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
 <22bebf4a-3801-45e9-8ac5-726cb6c89721@intel.com>
 <CAHHRULVvLpFpwA-Z8KMuCKmdM24OCeZDrzEMEMs88h2-iqapXw@mail.gmail.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <CAHHRULVvLpFpwA-Z8KMuCKmdM24OCeZDrzEMEMs88h2-iqapXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB3PR08CA0035.eurprd08.prod.outlook.com (2603:10a6:8::48)
 To IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SJ0PR11MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: 567e14e4-2a84-4f83-1cc2-08de890c0064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 7kZ5/1r6ctWI5VLJcMiDqeUbOmnw259EjmvZQD4a8iFSmpt43WSvNDiHeQuJE+8X7lKpRKJAozNBvP54D6L2hYVWSb+cPyKRdzaiQerYo4rliyj0GCc1gYQtb8N48le0ej5xlVNa/p2Kcin+iPqxTrbeRjBGzGIBfSW2L+3/fRV8dAP+bM655ClFCrKV8lI+5VyXrMKTv+uE0tldZiuMk/21rJkp1IfTp9wZwa+b0a8LhkHW/Dnl2EOZ7MCH+WM9tCcG/wDWrO7OOEj7Ty/0CLuqHEF9FC1u6M5OJAiilIl240fzPX4GpvcgvTHY2wox0ikoizahS/EsEKkHI8ADnoBQ62b4A/Vp98cv3aBIum7FWGFx1lFljljMMfjAJolFdrMNz5Aoao9VKSuQIQZbzE5Fb8uNFQxbcsfz/s+DfB2l7d0WXQaaOMMafIDkIXSTMxpnTCE9cLfaUSf98EPKZC19KwSfk5bC70BqoL7P+zvyo4U8kmPmqY4/4qN1MaBR565YmWehL4SRhO/FyOGPMVI9v4PQ+uSm2bPaB6ccfHnNz1omEGAiP/R8vs0JL8VZUuoy7ZrNDigg1zAr8w5qmGwVtGpj6nJ7/26rasG9xYaOac0kqX0M+yFlVeDU1xJnH7tsc+f8CSfE4I79bLgGyHo724/Oxlaalnnz7YVtPgND0uCn6Qy7ieinwG1DkjoMWq9gpWmg1JF9t77ck6PTRUzG6hgQXxk7rTSD6gOOsLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3hSemRTaHZCa2Z2UCtpZ3ZocHpIY0h2aUlXclZvR0sydUMyM2x5UzhhZnlm?=
 =?utf-8?B?akJDTkZDaDR4MmFQendPNjR5dWVTTXFad2VvYlJHL0tqOUluSjNSRDlnZ1dK?=
 =?utf-8?B?YXBTZVJ3c0ZSckQxZGxBZ2krWkN3VTJDRjMrZy9rZXJGbXVTMW5JRE1YRGlR?=
 =?utf-8?B?RS96T2xCM1VkSFZJdys5ejZGTFlxcEdzRGdaV3g2Nkp3MXQ2TGZiekY1SXhU?=
 =?utf-8?B?dFpsdUErTTZqZ1JDVFl2d2xjWHlnVmxSaU95YzRLdHNCaDA3Ky9zeTJuSHN0?=
 =?utf-8?B?YjVqT3lXZmZsMkdJM0dxcDdXYXd4TFNvcEFzMHFIZVFTYUh6SDJxU1lvTzYx?=
 =?utf-8?B?MGdsRzFTd1Npb0EvcDN4YlJpcFBOUUZRbkN3QlVHK3hQdXltSDEvTzFZdmhM?=
 =?utf-8?B?QWkyc0pMNFpMcmVMYlVwK3AwUS9MV0JhT2JnYkZBSXNUVEdQRFM0YnBHZUJv?=
 =?utf-8?B?UHVybU56MjZDRm8vMkUwb3cvL0pLYjV5ME5mL0JKY1BGTEo0UmtNSjJlc0du?=
 =?utf-8?B?K1MwOVg4a1crbmg0aWtuVnhFNUtHUkpJZEk2ZGJ6MkV4UTZkQUUzWmZHVTNM?=
 =?utf-8?B?T28raTB6Vmdtdi9idDRnb2hGVnVHM283ckFLZWlvbFgvbkd1N3Npais1aEpQ?=
 =?utf-8?B?YkRYSzFzWTBtTUhMWjQ0SVJNa0s4TmV6Uy9DUmtvZVRKKzluemxtV1ZNTXlM?=
 =?utf-8?B?MEk5T1ZnVWl2bWdxdlRnbFlYL0VCb25FckN2dFdESGlKNERIMUowdHZFZzVz?=
 =?utf-8?B?cGNTVm03NEN1aWxJVllWZjJQQVQvZFN5ZmwxTy8xS3VDNG9kejhVYzdzZEpR?=
 =?utf-8?B?OGR6WjJqTXd2TXJaaUZtZjRXOWl3emg0YVVNNzAwNGxQTTVGZGdPK2tjck5p?=
 =?utf-8?B?ZVhuTG5BdkIwdElkMnpTRmpaOEhWWHFQci95U0lGN25XSWwwdDBDOHZJVVp4?=
 =?utf-8?B?d1owYlhMT1VxTDFkRzZCeC9sMk5HTXQrM0RPOUJSUnk3Wk5wb3pQVzNjVzZR?=
 =?utf-8?B?bXZpZUFJV3llTGwrRjJIamVZQlZsSWhaTDRmZFFIbHZKbGgrek94YnpxbnhF?=
 =?utf-8?B?d3VwWnhjYllUdnA0ay80VkVCWjF6Nlo1aHFtODZaZ3JCR08zbHJiNmVpWU5E?=
 =?utf-8?B?eWxRWENEYlAxNy9kN3ZIaG5SbTJkTVFBb0FONjFGWVE1eEhpUld2OWJqSysv?=
 =?utf-8?B?UFVVdWxPQk0wMm53SUt4VDJHbXgwTitkYlFaVGRlV1YvUElJYldDNEpadUNx?=
 =?utf-8?B?WHcyMnlOUjlpVmxnclNaTE42anZWMW9oNXFXZm5HVDl0K1crcFhhYk41TkxS?=
 =?utf-8?B?K25SQUZzaVE1U0IzVTA4RHZaM2I2QXRCNkVkaE55RzRyUWtTV1Y3RmlyTTEr?=
 =?utf-8?B?U2FQVVQrUERsNlhOQ1kzRkZLOTlreTdsZnB3SFM3eDhYVGpnM1RMSzVPYklX?=
 =?utf-8?B?VUxuZDlaUm9sait2Q2h2SEZaUm5wTCtpTHUweFFNL0NBZ01FWHYxVkg1Y0wr?=
 =?utf-8?B?cTVGenQ2aGhvNHNJcjhHb3R4c3VKN3ZTK3M3VGMwd01wRFlPc1J2UGpvOXZ2?=
 =?utf-8?B?QjdyVGFOZEdFd1RRR3dSd2kvditDRTd6cmNIcjJDb29XdmoxMGx0WWsySmZm?=
 =?utf-8?B?Mm81N0dsVDIwNU0xYWFvbml6clhZV1FyNlZjcFk2RmdtYjNpQ3EzV2FpZXJP?=
 =?utf-8?B?RGJXY21KSjA4bWZ3b29yL21JWGVGU2hLQWxJVlJUcEJ3dHIvRVpDUFlXTWln?=
 =?utf-8?B?Y3owVVNmR1pXWjEzSHAzcW9JcW9uQ0k5dFN1Q3NLOGFPMnQrVkVqL2RVYnl6?=
 =?utf-8?B?Yy9hYkRiblp0cmNhd0tWdEtaenk5N0VJVGtUc2ZsZko4OFg1K1dHMWMxM25q?=
 =?utf-8?B?a3VmbnVJT1AyMGQvQysxdC9XOENwWVBlamZFUnVlemo4ZzJYMkhPUEVDWmJH?=
 =?utf-8?B?WUM0Y0FrK0MwRnVHQUl6bzRkUkVOeXdrUUtjd3JtSnM2cFNXanJHRzQ1U3h4?=
 =?utf-8?B?Z3ZESEM4NEFvZWxDUFhNdENNc1ArNHQzZHh6TGtjWjRpOElyOVBkWDM5VElO?=
 =?utf-8?B?VXdEaDNwYlpwWFV0d2FIUzlNY0hab0pONVp0MEdUb1dadDYwZW1kRUQvZWpH?=
 =?utf-8?B?STlLVngwWU9JNGNOaUx4MTJqbDBONlNwRjJxMUF5QXZxRDUwcmtpakdnWVM1?=
 =?utf-8?B?STdhRUQ0S2h3UTloaGRJNG12TmprTlVGR283YzJLdmJrTC9yQ3YwMjhVbER3?=
 =?utf-8?B?RXZZUlJSMUN0SGUwNk9LemNoRzBOS0ZWSnJvclBadndYeHo1TVVTVE0zRGhz?=
 =?utf-8?B?c0sxU2RibkpoQXZ6TVB1SHlEaEFlb1RCMjUwZG9tbzBJSXVBM2tSa0d1K2o5?=
 =?utf-8?Q?yyCHjlM+iIfSFGvQ=3D?=
X-Exchange-RoutingPolicyChecked: OxohzWlCkO6Imek0gzaDh2EcWlMe2BWC6OH+dV7GN9+rknfqgMw3BjxHjVuLOZLXS/8QCpx3wfmg9wxREOmR5rJDdD7tB5SdVzh8aqkEEWHmuK9GRFnRl7bj62gxHnAmZXeYm14gx6Vxwcd5J8GrWPEB5ySH6fOoyyRRQu9b7plXykS9kKIHGdU8lg1yzp15Yhy+AG8etkYtwObbIbY2Bh7XiEqaQZTkoM8dgfvifkBT0K1PamRUIReImt6tvKeDPMBQlCNqf5skjhooGDdlEKCsCCiOsx2Som6UvCtzGdIxXH8HqtcXEhXPro7SiEQIKxXQ0l+HjZYEWVzBA3wRqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 567e14e4-2a84-4f83-1cc2-08de890c0064
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:42:57.7489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8fgXmqKCqRosZlZGr2mxi7D66zw8vHfu29dzmrrBwplgXoRMXcqTxeiC0a5uz02vsb8C6gS0hu4i6C85tgY+rUKJP9T7GNSm8p9uo4B0wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5215
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


On 3/23/2026 2:53 PM, Maxime Leroy wrote:
> On Mon, Mar 23, 2026 at 1:49 PM Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com> wrote:
>> Hi Maxime,
>>
>> On 3/23/2026 11:27 AM, Maxime Leroy wrote:
>>>    Hi Vladimir,
>>>
>>>
>>> On Sun, Mar 22, 2026 at 4:42 PM Vladimir Medvedkin
>>> <vladimir.medvedkin@intel.com> wrote:
>>>> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
>>>> allowing a single FIB instance to host multiple isolated routing domains.
>>>>
>>>> Currently FIB instance represents one routing instance. For workloads that
>>>> need multiple VRFs, the only option is to create multiple FIB objects. In a
>>>> burst oriented datapath, packets in the same batch can belong to different VRFs, so
>>>> the application either does per-packet lookup in different FIB instances or
>>>> regroups packets by VRF before lookup. Both approaches are expensive.
>>>>
>>>> To remove that cost, this series keeps all VRFs inside one FIB instance and
>>>> extends lookup input with per-packet VRF IDs.
>>>>
>>>> The design follows the existing fast-path structure for both families. IPv4 and
>>>> IPv6 use multi-ary trees with a 2^24 associativity on a first level (tbl24). The
>>>> first-level table scales per configured VRF. This increases memory usage, but
>>>> keeps performance and lookup complexity on par with non-VRF implementation.
>>>>
>>> Thanks for the RFC. Some thoughts below.
>>>
>>> Memory cost: the flat TBL24 replicates the entire table for every VRF
>>> (num_vrfs * 2^24 * nh_size). With 256 VRFs and 8B nexthops that is
>>> 32 GB for TBL24 alone. In grout we support up to 256 VRFs allocated
>>> on demand -- this approach forces the full cost upfront even if most
>>> VRFs are empty.
>> Yes, increased memory consumption is the
>> trade-off.WemakethischoiceinDPDKquite often,such as pre-allocatedmbufs,
>> mempoolsand many other stuff allocated in advance to gain performance.
>> For FIB, I chose to replicate TBL24 per VRF for this same reason.
>>
>> And, as Morten mentioned earlier, if memory is the priority, a table
>> instance per VRF allocated on-demand is still supported.
>>
>> The high memory cost stems from TBL24's design: for IPv4, it was
>> justified by the BGP filtering convention (no prefixes more specific
>> than /24 in BGPv4 full view), ensuring most lookups hit with just one
>> random memory access. For IPv6, we should likely switch to a 16-bit TRIE
>> scheme on all layers. For IPv4, alternative algorithms with smaller
>> footprints (like DXR or DIR16-8-8, as used in VPP) may be worth
>> exploring if BGP full view is not required for those VRFs.
>>
>>> Per-packet VRF lookup: Rx bursts come from one port, thus one VRF.
>>> Mixed-VRF bulk lookups do not occur in practice. The three AVX512
>>> code paths add complexity for a scenario that does not exist, at
>>> least for a classic router. Am I missing a use-case?
>> That's not true, you're missing out on a lot of established core use
>> cases that are at least 2 decades old:
>>
>> - VLAN subinterface abstraction. Each subinterface may belong to a
>> separate VRF
>>
>> - MPLS VPN
>>
>> - Policy based routing
>>
> Fair point on VLAN subinterfaces and MPLS VPN. SRv6 L3VPN (End.DT4/
> End.DT6) also fits that pattern after decap.
>
> I agree DPDK often pre-allocates for performance, but I wonder if the
> flat TBL24 actually helps here. Each VRF's working set is spread
> 128 MB apart in the flat table. Would regrouping packets by VRF and
> doing one bulk lookup per VRF with separate contiguous TBL24s be
> more cache-friendly than a single mixed-VRF gather? Do you have
> benchmarks comparing the two approaches?

It depends. Generally, if we assume that we are working with wide 
internet traffic, then even for a single VRF we most likely will miss 
the cache for TLB24, thus, regardless of the size of the tbl24, each 
memory access will be performed directly to DRAM.
And if the addresses are localized (i.e. most traffic is internal), then 
having multiple TBL24 won'tmake the situationmuchworse.

I don't have any benchmarks for regrouping, however I have 2 things to 
consider:

1. lookup is relatively fast (for IPv4 it is about 10 cycles per 
address, and I don't really want to slow it down)

2. incoming addresses and their corresponding VRFs are not controlled by 
"us", so this is a random set. Regrouping effectively is sorting. I'm 
not really happy to have nlogn complexity on a fast path :)

>
> On the memory trade-off and VRF ID mapping: the API uses vrf_id as
> a direct index (0 to max_vrfs-1). With 256 VRFs and 8B nexthops,
> TBL24 alone costs 32 GB for IPv4 and 32 GB for IPv6 -- 64 GB total
> at startup. In grout, VRF IDs are interface IDs that can be any
> uint16_t, so we would also need to maintain a mapping between our
> VRF IDs and FIB slot indices.
of course, this is an application responsibility. In FIB VRFs are in 
continuous range.
>   We would need to introduce a max_vrfs
> limit, which forces a bad trade-off: either set it low (e.g. 16)
> and limit deployments, or set it high (e.g. 256) and pay 64 GB at
> startup even with a single VRF. With separate FIB instances per VRF,
> we only allocate what we use.
Yes, I understand this. In the end, if the user wants to use 256 VRFs, 
the amount of memory footprint will be at least 64Gb anyway.
As a trade-off for a bad trade-off ;) I can suggest to allocate it in 
chunks. Let's say you are starting with 16 VRFs, and during runtime, if 
the user wants to increase the number of VRFs above this limit, you can 
allocate another 16xVRF FIB. Then, of course, you need to split 
addresses into 2 bursts each for each FIB handle.
>
>>> I am not too familiar with DPDK FIB internals, but would it be
>>> possible to keep a separate TBL24 per VRF and only share the TBL8
>>> pool?
>> it is how it is implemented right now with one note - TBL24 are pre
>> allocated.
>>> Something like pre-allocating an array of max_vrfs TBL24
>>> pointers, allocating each TBL24 on demand at VRF add time,
>> and you suggesting to allocate TBL24 on demand by adding an extra
>> indirection layer. Thiswill leadtolowerperformance,whichIwouldliketo avoid.
>>>    and
>>> having them all point into a shared TBL8 pool. The TBL8 index in
>>> TBL24 entries seems to already be global, so would that work without
>>> encoding changes?
>>>
>>> Going further: could the same idea extend to IPv6? The dir24_8 and
>>> trie seem to use the same TBL8 block format (256 entries, same
>>> (nh << 1) | ext_bit encoding, same size). Would unifying the TBL8
>>> allocator allow a single pool shared across IPv4, IPv6, and all
>>> VRFs? That could be a bigger win for /32-heavy and /128-heavy tables
>>> and maybe a good first step before multi-VRF.
>> So, you are suggesting merging IPv4 and IPv6 into a single unified FIB?
>> I'm not sure how this can be a bigger win, could you please elaborate
>> more on this?
> On the IPv4/IPv6 TBL8 pool: I was not suggesting merging FIBs, just
> sharing the TBL8 block allocator between separate FIB instances.
> This is possible since dir24_8 and trie use the same TBL8 block
> format (256 entries, same encoding, same size).
>
> Would it be possible to pass a shared TBL8 pool at rte_fib_create()
> time? Each FIB keeps its own TBL24 and RIB, but TBL8 is shared
> across all FIBs and potentially across IPv4/IPv6. Users would no
> longer have to guess num_tbl8 per FIB.
Yes, this is possible. However, this will significantly complicate the 
work with the library, solving a not so big problem.
>>> Regards,
>>>
>>> Maxime Leroy
>>>
>>>> Vladimir Medvedkin (4):
>>>>     fib: add multi-VRF support
>>>>     fib: add VRF functional and unit tests
>>>>     fib6: add multi-VRF support
>>>>     fib6: add VRF functional and unit tests
>>>>
>>>>    app/test-fib/main.c      | 257 ++++++++++++++++++++++--
>>>>    app/test/test_fib.c      | 298 +++++++++++++++++++++++++++
>>>>    app/test/test_fib6.c     | 319 ++++++++++++++++++++++++++++-
>>>>    lib/fib/dir24_8.c        | 241 ++++++++++++++++------
>>>>    lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
>>>>    lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
>>>>    lib/fib/dir24_8_avx512.h |  80 +++++++-
>>>>    lib/fib/rte_fib.c        | 158 ++++++++++++---
>>>>    lib/fib/rte_fib.h        |  94 ++++++++-
>>>>    lib/fib/rte_fib6.c       | 166 +++++++++++++---
>>>>    lib/fib/rte_fib6.h       |  88 +++++++-
>>>>    lib/fib/trie.c           | 158 +++++++++++----
>>>>    lib/fib/trie.h           |  51 +++--
>>>>    lib/fib/trie_avx512.c    | 225 +++++++++++++++++++--
>>>>    lib/fib/trie_avx512.h    |  39 +++-
>>>>    15 files changed, 2453 insertions(+), 396 deletions(-)
>>>>
>>>> --
>>>> 2.43.0
>>>>
>> --
>> Regards,
>> Vladimir
>>
>
-- 
Regards,
Vladimir

