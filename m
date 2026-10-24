Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B3606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dWcQkUD1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B947A402B0;
	Sat, 24 Oct 2026 11:58:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id A9A854021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 11:58:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792835884; x=1824371884;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uxYI6LDpuqW5Q5zggJsefIl53/HPiPzVv6ErzjwK8m8=;
 b=dWcQkUD1ucsSoI27Vz17q/rU16owJGS80T5Veo9iQFJRe7hfxHAWn69+
 aFBpBfHlju9tj4YXn2r2T1LN0xCl00deM5c0jHwhoJOTLGpdsL44r3XnW
 i38VVqCCxLn1k9YSn257VCPXNuRsGkMA6XQe2aP/Pfl7IuZkJlM/Ham0E
 xoX9pyGvjJV1fVFu1NcsfERvIOyb67r8mRQSqse/DQGcrA541xJQiRm4I
 0h8XzneQrdZtobdgnYXQE9RMf0RCW7wZK5DlBPKweJj1NSSUOjTmvqrXi
 toZoKrGNRRNLa+Kf3EgkJq7ejbi6syS3tG4Eu3bpOV0rQVDX1iOFclWh3 A==;
X-CSE-ConnectionGUID: emuWr8qkQdSTN/T5w/wUIA==
X-CSE-MsgGUID: SM+TxZBhRtagsHJjsn1uQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1566403"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1566403"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 02:58:02 -0700
X-CSE-ConnectionGUID: qoYpW+PbTDu/cirbS8+xMQ==
X-CSE-MsgGUID: IioTe295RVSi3bKnf903RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="3949949"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 02:58:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 24 Oct 2026 02:58:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 24 Oct 2026 02:58:01 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 24 Oct 2026 02:58:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYYnnTbGWxpCrFmDMxnjBiXYbNnfsLtNP4PuS2K6/bD1F2FFQypK3lkP3Ya4XNmdz42Pl0GtIsrNaoObzZJdpvAFQkevwf8000AyhUi/ipznw3ygBO1PcLIGTaG6owCV6JMwuxp+PMHGGV4sPFcqQZlR7E7TTVstIBQ+TA07imvcchWogohtluOCPMnSrq6wgwpa9ScqP+0G1YDTIsx25FoG4tfqLAiRqa1KoeQR/8j9NysLeqDrQpnTD7vF1yhPRwFl4mhRNcLN4FZ/tVxsEd0+/skHBwyrqnSVFUtGq5RP7neYbnLu6g7cK98cUe1VXmNEXXc+LruICuJweuOWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gee64noc4zBWH7xiGNkEYQkc5hS9v5QL42m/Mi9zgw=;
 b=WckOD/GaWCyAX23ppn3zorXIcmPfscYAqKibX/ropAVn8FVEDDzEyONMvrde1L7OIJtXUMJb6xOt7AN+oyppzUybhCjtHz7K2EduC0H8k6yj+hGAUbq/0JqkvDY1XMsdP5XI77SWPSbpHXeTcXxLFM+5IOXyMyzicV/sUu83IDLQFCZzRoj7Qw3Cm3x6wzQK4ssvhdNkQib9/kuH+z3Vsn6rhV2G+j2dLY2M2aMAKOlmzc4KSW57ATpmAmR2lH5MUTracRj7KWaPMjJOZuKMy3IhlyS5re/1sBDHE056nR0lVEgYmjFuhesBEGXwprPgyY5qEcUTEQ4Vuak06ILn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CHAPR11MB9677.namprd11.prod.outlook.com (2603:10b6:610:300::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Sat, 24 Oct
 2026 09:57:58 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0546.017; Sat, 24 Oct 2026
 09:57:58 +0000
Message-ID: <32ad22af-a3dd-4fcf-94cc-cf698cef44fe@intel.com>
Date: Sat, 24 Oct 2026 11:57:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] interrupts: warn on leaked event FDs
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Harman Kalra <hkalra@marvell.com>
References: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
 <6313a2be1e6288e2844cb13e0c8523f7296c5b98.1792763492.git.anatoly.burakov@intel.com>
 <CAJFAV8zHmbL99Xi3REFd6P0WEewstUZ29=imnbVoxym9KTWA+w@mail.gmail.com>
 <6be57c4e-0c3d-4505-a64b-ac7f3037d7da@intel.com>
 <CAJFAV8yh9UxD9D+bNCvh+tcKASpVg0x=czpDfdJnVvgXxPmxsg@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8yh9UxD9D+bNCvh+tcKASpVg0x=czpDfdJnVvgXxPmxsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0207.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CHAPR11MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 73184850-f1d4-497e-8f84-08df31b54824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261022105027099003|11063799006|56012099006|4143699003|22082099003|18002099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: vVsEbI919vHfp1FvYB4uCVRSNbBLX47V9o02APJDp3d0bdGebJJCHahP5jaCNvN+RY2KST/A0MfTg6xkcn37nS4vFoO7/rzZfEvZPIuayb+B//wPVGF2X3YcxTsdp7CfwS0pNrntgCWwt0IR3GfIahH4nQEJmPKLIIxCCvXm330APutP3vvr2zq5t8mEJW1WOOae0uQgVU3UYGT+B7/ItJM20PY+dq62EIgs2Yv6ir+YNbFbuUd/7TNsjXgL3mKCo8acV3mKQs1eM6A1Kb0ph+Yg02lpktIlHS7o56okrRSpgiCH6xaVMRFMjcvEBxCzl2fK+PzJyVI+gKA/YqMp+udUHw6VTGMWnUD/q2qx1PooLyU7YZfufLY40y1eTxQlAUBvGYKvvIZeTgCYQWaayv97rRsptUFZZ0b73YrKy/8ZXJ+ymThJCFFimHGgjzYPjqMydubcort2hXSrAgNBUOzYk/VlmdQ3oMln/ibXiPdxGDgmB0p8HkGYdkK8ll780B7qp4Hw6Xrd7hGentWD0cGHlagF7MwWGs9Qvwt37vhpH+Sb+3eplLSf5fFVkxZnMzQzVgM0Htg4uQ1ySW1t3q/K7fL3jzRkDzDU4fhE9DS2ua9FwyrLhsQzhWLK0yBTHWajnPTR3wW+bpamCLKxyCjFypPGd1pR9sKO7w0FQzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261022105027099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnNkWEllcVkrOWd4TTl5SG9lUEQyK1gyTnVkRzY5U0JoTTM5QXptZ1Iyb0VR?=
 =?utf-8?B?MnMxN0JVZHhiQlN2TFhmRkhEVENHMTFEakZ1V1NmUDhUVWlSSUxFaTNzUmgx?=
 =?utf-8?B?TmxrR2MvRy9QK21wTk9rNEM4NkRaRVNuZnlvVXorZVA5U0NPd1IyZmpCWS9x?=
 =?utf-8?B?blpZakQ1UEk3eUg3SU1VYVdtMSsvaVFTTVp2eE5ncStQL0NDcGpwWjhKd0Js?=
 =?utf-8?B?dDNYZ0NDdS9XbFJZMmdTN0RjWUw4RVlQdUdVTzlaZERwNTU3aTJxSzVRMHNz?=
 =?utf-8?B?UDhIYTBrYW9JRTdqYnRkRVBGelFIaWVPbWxOUnRiVmtMemE4T2l6NUs4SFVW?=
 =?utf-8?B?QTJXNEZ6aVIrbllIR2Nnak1mRmYvWUpPM2JsTnpVZlp6TnI3d0p5M0JlenhI?=
 =?utf-8?B?aEtWY0lTVjZiK2pIekluWE5TV3FyVmpFRlBWNVAydDNjb0d6MWF4ektLZTRR?=
 =?utf-8?B?S3FMSHhEWDMzeWpGc29HazRORnFvbVd3TDNZK1JFVUhZTjNpTU5KS1Q3aHlX?=
 =?utf-8?B?VjVEbzlzSjdFMGtHa1B6S3I4WDNSU2NMWlREVVdjaTljeXNNN0NNVUV0Vlla?=
 =?utf-8?B?NmJQL1ZRVlZIdHN6Z3ZKVXM1blBDWXQwVWNyY1ZyWmFGTnhPeFlDU3FBNURh?=
 =?utf-8?B?R3QrSjk2Qmcwai9nOS9meXc3dUtBc2h6MVdjdmxaV3JVYVhMT1MvbE4xTzk4?=
 =?utf-8?B?OS9PVGluYUNaS25Eb2plR2VzUjVCTGF0ZEhEQzVKRkkycDBmYnVsVWxVb2Ji?=
 =?utf-8?B?cVNrcUZQaERCc3FyWUdxZGRXSllUUlRwRUppeVpHNDdodHFYZ2RYUkptOEpt?=
 =?utf-8?B?WHZxY2sxS2RlbHA2L004cTNnSjhJeFByckxTbWRhZjNiT09uZXVyZUZoaUQ4?=
 =?utf-8?B?V3ZUMHpDRmdNbWlpREVjV2h0V0VSaTlsWExKR2FvTnF6RFgvOUs5ZmdUZzBj?=
 =?utf-8?B?QnVIRnJySU5SWkZxdklJejdZdXphY3RkcHphemJQMnc3T0lPZzcwalQ0RXM4?=
 =?utf-8?B?dHJOcHl1RzNoNThzeTF3SlZ2aE9iRERuTDV5TWRuVDFUcm55S3NmOWxqVUZP?=
 =?utf-8?B?cXV0QVlsdmJsUU1DSFFMeC9pTEVLODdCcXRLMXpLSk90RTBZL1QrZzY2OEJD?=
 =?utf-8?B?dllObGxhSnVUNGwxV0dYVGpueEJmQllQK3c1c1BUdFdiUjV5SDVtSUwxV3VU?=
 =?utf-8?B?b3ZkZHd2eUwvc2lsVmV6TE4rVXdQMmJtTWVLZnBsU1pTVjFHZTB5dXVBQzdM?=
 =?utf-8?B?N1ZiUGV5bm00UXBOWlJFemNJSktCU3RmOHg4L0x1MWxlMDVDN0I1VHdlbGRU?=
 =?utf-8?B?RVIrSDZYYXhuZVV4SGtzdkdxdGd3Zk1tZDVHTllmVzVXdEU2ME9ackhsRkJQ?=
 =?utf-8?B?QlBSR1ZKbE55Q1MxaWNsY2FrMVpXYVVDbWhXZi81S2ZxSE84VXBRQ3lQOHhH?=
 =?utf-8?B?RWxXOU4zNUlZTnRhZEdBVHgyKzVtbkIybGpKQnpYUFhQeklxN2paU2kweGpx?=
 =?utf-8?B?SnR3WFVuaDNISDk0eENPRHN3WFUramxmTWE2TGhLbFNjNkhpVG9zKzRNUFBh?=
 =?utf-8?B?L0ozWnRNbm11SWwyTnNybVFpa2tOVkpoTnA0SkluNTU5UklScTc2M3ltaEpL?=
 =?utf-8?B?ZTVFWld2YnVZU0lyek5pVjI0RWdBWUtRRE5ncnBSMXhiRS8zNHYyL3lMY1FX?=
 =?utf-8?B?R3lucUEwYUgrT3N2OHhxS3Ewcy9FN0xMektWUGdYZXVsRldKbE10eGlyMFdi?=
 =?utf-8?B?TkJqRUlPZnF0NENOVTRWNS9VRUx4ZmwyWmVkWW9iSUdSRnJlQlgreks3NnBz?=
 =?utf-8?B?VytNR0R1ZEg2Y2xDRWhqR0ZBc3h2TUdxZ3RnZS8xU3g0SDJBWUw3MzJGN2Nq?=
 =?utf-8?B?bklCdmNHdkJUVTlmRDU4U1UxdFhlL0N4VDdKQWsyMVB6WGJ4MmkzZkk0Yk8r?=
 =?utf-8?B?V1FkdFZyeFV5V1BsdUVLS29HcHdrU0dFWis5OElVYTZpM3BSeEdZL0hIa1Y2?=
 =?utf-8?B?d2hvbTZ5OGdPTUpldE9tUXg5c2VQS2EvbDVFemUyM0JFZHBhY0hJWnpwRW9Z?=
 =?utf-8?B?SHoxc1o2RUE4Sm5DWHByN21jQVd4ZDd5Mm9xWnhoU0N5MTByOStLbHN4WERj?=
 =?utf-8?B?aFVOYUorenphencrNnZBcmJDN25COGZnQXppVjh4WWFhbFltZjgzZ2hLeU9H?=
 =?utf-8?B?NitkdVlNak96QVZ5MTZQZWNxWGZQdEZPYXRQUzZGcHgvcE1IWUZUOXpuZVE1?=
 =?utf-8?B?RDArSmVTUWR3TUhSTXg4RWp2NGxIOGt0WWlYbkNVNUF5RjlpMGtQK2ZpdVN5?=
 =?utf-8?B?aFZmOFZuZU56S3U3bS90R3RtVHh2QzJUZ0tYYjU2bXRBb3dwZjh3bUdlU3lI?=
 =?utf-8?Q?LyFzrnfkIT5qrsTg=3D?=
X-Exchange-RoutingPolicyChecked: lN922CCYZMW9IcUyPc+k6X73Vwgtc4aKE7FzTQwG7iLg/+IXoca2XKRigQdR78PRpFRe80Gapr9X9iZbETHWfvJ5ddYBHftTHBGHDnd9EeJnCmVodCDm359M+qVOL6z31a9WoY8g+ArlNXQsxsR9/H4Cxh2X+JVpy+4FM6o1lKTS9Je6AiRwX3N8pZhA94EPXgd4rnGIQpdSVDSJ3MxqbOU1sWsSyVQX8Bc70OhI4NH7zHok4Ce4mHdb2TChwcyGmnZbUOyf0h/1bNNZFlenV71d0LFYteGOps4Pm6tkCsGbTXSYoeyWI4R/obuHPdFB289e0JRlhdIs6eimnZ1hRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 73184850-f1d4-497e-8f84-08df31b54824
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 09:57:58.0959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFJ2GqWIDzcHhxT1TAmYRnnBX1HQq3QxoogV0ybJAagePoQPcxKGCF7TAVRLtIriM9+kBLi0Ii6oPqijqsBTSVv2G+7Rnvc91EiRrxy6phc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9677
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/2026 10:56 AM, David Marchand wrote:
> On Fri, 23 Oct 2026 at 16:48, Burakov, Anatoly
> <anatoly.burakov@intel.com> wrote:
>>
>> On 10/23/2026 4:41 PM, David Marchand wrote:
>>> On Fri, 23 Oct 2026 at 15:52, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>>>> diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
>>>> index aadb7b84a22..f6f51ba53c0 100644
>>>> --- a/lib/eal/linux/eal_interrupts.c
>>>> +++ b/lib/eal/linux/eal_interrupts.c
>>>> @@ -1667,6 +1667,8 @@ rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
>>>>                   for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
>>>>                           close(rte_intr_efds_index_get(intr_handle, i));
>>>>           }
>>>> +       for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
>>>> +               rte_intr_efds_index_set(intr_handle, i, -1);
>>>
>>> We don't want to waive for types != VFIO_MSIX, do we?
>>>
>>
>> Looking into this further, I suspectwe want to check for != VDEV
>> instead. All handle types except VDEV will write into the handle.
> 
> Indeed, I had misunderstood rte_intr_efd_enable...
> Ok, I'll respin those patches as part of my series and let the whole
> set of changes go through CI.
> 
> 

Yes, the efd name is confusing because not all handles created by our 
interrupt subsystem are efd

-- 
Thanks,
Anatoly
