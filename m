Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD24CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:00:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12B7A402DA;
	Thu, 15 Oct 2026 17:00:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0DBFD4027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 17:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792076458; x=1823612458;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=1M2ks6LOyZbKbClaqgkkEbdi52qQ/fM6OGkPZ5vlbhM=;
 b=CNCWnadNH/KythmMI8pVbr1BRA8H8iy22ARhESO5Wo7hLdngVN2JYuJH
 Aj4hdFgEChF7fi3N/a8qugMLSbUnDJViseCAEoNu+b14t5kQKGOmCrV+x
 lwFpgzW6VVXRMf9kbJ/tIOqkyJhI0m03ZjUr2YW1Mxc+ohmQA1TAbZ18H
 K4Vz6c9ZWtWtP1ekSj5HI5u0un6/ztmPbWK6loXilx2wQ4228WoJKVZOQ
 7nZ9SVs0LoPelHkVJkrVJxWV7nnMbrVFu4qigCuM/8Yd4xNWrihC20ct8
 yciIFCJIqB5GafwwqJv3SGlzsfG/E92m12n2Nrhl84kyS6KS0yBlj3i8N g==;
X-CSE-ConnectionGUID: 8vKKyqJiTUiDvSjhmrrYJw==
X-CSE-MsgGUID: jPv/wfFITA2wcP4kMmJVMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="747501"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="747501"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 08:00:57 -0700
X-CSE-ConnectionGUID: 1Kk0QwrPQlaavokCangJ+g==
X-CSE-MsgGUID: pmyKJSOaRPWdRwopRs6miQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1594628"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 08:00:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:00:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 08:00:54 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.17)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:00:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDfoJlRfcV1CicpZdrmp98kUQixVmGHcnSKHo9B/FiKeTqNUB0oI2/KIo39/hZlMzIl9/FrmC9fNVvI49aot/ZMCyTEQ2n4kAAykdCe0XiIx4eMeJAwSMffIXtpZs2aC4WAHZ6+GdP09B8qZ8OnUcpB0UgDG3nqE4/GtfjUu4zKscq6LWFDxUVNZsdO04WyJ/62sndN2o+f86V7MqF4lo9hPYjkydobNHFoXQxIvonrpwLtIm/Ok2FVPL74MWWBeRbkUUpwRDAM5a2GoYxah31J0kFP6Pn/FIQiwNoFB94CS2cKcTX1t/CzH5UGQK1GwBHGTclKed549puYWvyUhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV5g+vGcHEml/akKl1TredX25Ee/M2Q9W+LAC2T1LAQ=;
 b=MA8CV2Gp3TXy1kV5VLnXMzYwJhFKSiVR7oLTbO7wr4gJzlNZyPma4mGOQweYdV25BXBKEBn/n+N0KcpE/Sm1uUFGmu44P4+6B90hDVLhdZzFFbiiG/fDTVGjg/Cn3cU2TcX5SYFOm/0ZHyIBi9U+VCfCKNSHkRmLr32cg877t+7uNHETn8dJyR4X5usaFKu8UE9BYJ2xZe97hkYMlhdq1TmCNnZxc1Y10jzfytf4BwhoZjkVpadWr5/1h914RyhbxSsrRdd4vHvCvVGqHyAlmdeQ2nyfxXOjP3uI/jR8DlbWlB7sBlPvxdKebW3xnQx0p81JDtGBYT83xytmJ4N0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB7794.namprd11.prod.outlook.com (2603:10b6:610:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Thu, 15 Oct
 2026 15:00:44 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 15:00:44 +0000
Message-ID: <ef450e1d-34ca-4876-b94c-6a3dcd885f19@intel.com>
Date: Thu, 15 Oct 2026 17:00:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] net/ice: do not include private headers in testpmd
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Kevin Liu
 <kevinx.liu@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
References: <ff393eb2eef43c9ab3d27824badda9743e717a98.1792074055.git.anatoly.burakov@intel.com>
 <46e98c80-f44a-4c69-93fb-050ccc864c4b@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <46e98c80-f44a-4c69-93fb-050ccc864c4b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e5fd44-25fd-4391-08fd-08df2acd162b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|3023799007|6133799003|22082099003|260925022911599003|10067099003|18002099003|260925021311599003|260925021911599003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 86+ymMNkq8rzmXiLwLFIZw8m2tWfL5SYQn+Qoa/RhVI7lRWKqyTh5s+vWgr+bgm1+JAaCmpivbMV/5hnittQBCm2ZgQxUr3PZ/mnVlO/bXzZp4dVLTK8KhYWv2GijT4hdA5uR6kHZQ0eAdP5CHw48oU9oy0LMZPflgZLnaQi8H/TuTNpeAPvHwCv7Z/5AqRypuWByKNJXs93IH6YX11SCWZ39lI3cOyaVmM8WY5oQsqGnc68GjSeG44iVlrX5srL06TNye2UeIznwI/LfsJTA/wmzuhYdhH45zhY+WJVDn9U4bGsENLK5j34AdVOQ34z/uLjZlJl2mbq0IayL6MNcdCgP2Z6E7a5+UdGUS18t+tAHlroG8CjvvMGeJCSW+a4WNZLgXlTSjxWh3pU7+4r7IQNgU6RcoMDub5JDEkittApSp+gd4dZTKMabgb00HhG2vEKpM9cntZMLQhOoN8bP+jq5U0bd88XIYD1O15NpYxDFs1bRO5f8H6J7gNzoMJbiIXabZsvbeI9REIMSFiPiPtfQec85+/KRB2KPAuAen7GfQ9hszIbkKbnzX4rJzFhuRviG7Bnyu7JlSol6lyQ2y3f3CnwGFGoHxD2/IsteY/M0UzcYLEXIDyMvXuW30xP3jId0KBN8sSLgUGofRzdLHjDdOMLqGV9hb8sFTMoa6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(3023799007)(6133799003)(22082099003)(260925022911599003)(10067099003)(18002099003)(260925021311599003)(260925021911599003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekYvcE8ySzJWT0E5RzdBSXJPd2JrWmU3NUpINTZyS09KaG0zN3dlYmpoTGRy?=
 =?utf-8?B?bG9NRkdhaC9KalM5dUIvdW9rVzdieHh2QzB4aTVDbHVsUnVwUW5pWmp2Zkxm?=
 =?utf-8?B?aWQzL0RJK28vamJhUXEvNkVNLzRFaTJSNG85VGN4aytqNG5ld3JwTmd6OE5m?=
 =?utf-8?B?eG80Um52VjMyNFRaZFozdjBXdTg1OHBldGUvNVZ2UzVBdHpLdWxqWlBqTnVp?=
 =?utf-8?B?SGRacktqTTNDZ2FObGhWc2c3UHV6V1JpRDlYUDcwWkQwM0hiTHdTbG53OUNJ?=
 =?utf-8?B?TWZkRFZLY3hsTzcwYVJhRng3cmJmK3graS9Kc25pME15NW9YZjl3T3VmQWNw?=
 =?utf-8?B?QVJjbVBCdUd4ZFdOYnFHVVUyMzd0WFJSMXJDQU41akFGd0VXb3VVOHVkd3pw?=
 =?utf-8?B?akRGay9GaGxyb0pGdFhIWFNqU1pYWWR4ZjZTUTF1bE15MjUxQm9hT1lZRUNK?=
 =?utf-8?B?Q2hHUHNoelhWaDJ1Q2kxdUh5aDEzNGRDUFA3TzQ3WkFnUUc5YkxXWFNiTkds?=
 =?utf-8?B?a2czZ2dtK1U1ZGFSMFZPK0d4VDVjQzd0MjRaOHZ3S2E2UloxS0RrZFhlTTNN?=
 =?utf-8?B?NHgzblFkQ0xKOXZjZitEMmlsQkd1UllaRHcrVTJJMHNBZklaL09BT0E3SkZZ?=
 =?utf-8?B?RmE1Z2dzK2lvdVhVNmJCNjBSYkZOWnRXMGdGWm83Q2RiV0dEamRnUk1MbkVN?=
 =?utf-8?B?MnJKVTd2anZ4UjVGcmFOY3RVNzRXTExBWXB0M0pXQllHd2h2cHVCWUlCcDN5?=
 =?utf-8?B?SEw5UkpaQWtUeEFrTmZsaGxWQXorcVIxNjhQa01KZVdHUnF1YmhDaW9uRGp5?=
 =?utf-8?B?M3ZvcG9rcUdwRnAxZTBWV2VTb3piTVdMTTlqVGlsbExJZXVuOWJxWVlINVV6?=
 =?utf-8?B?cVdQL2hFSGRSdVFMOHNLLzlTRm9tSjNDWHZaOHpWWHVVSHpyZXI0a1pReTI0?=
 =?utf-8?B?b3FjdCtqQlJkV29nNnYrZGQ4Vmx3YkYyT1NIQnU5MTkxTjdoYTMvbWVlQVk0?=
 =?utf-8?B?elV0MWtpenQ1VFdlYjI1QTJZOHBrelNGNU1BSElHcUQvaElIazNkSm0vQVhH?=
 =?utf-8?B?KzZVUmk2YXdiOCtMVkFwckd4NzNaZm9aeWtTNXV6bEF1ajhxTm5CVkV2TGpK?=
 =?utf-8?B?QUdtTWUvcmt2dHBtNnZDb3gva3lHcTRQWmo5d1l0OWZ0eHcycVdadjcrcm5U?=
 =?utf-8?B?U3hMaXFSNTZjdTVDS1ZCVG1sRWNiSDV0Snc4cHBpK2s0RDJkblc5Wis4dC9S?=
 =?utf-8?B?aWpQZy81VHRtS3VObjNoMVhqbFoxVGNNQlkzVEoySXQ1L2F2Kzc2Z2h2OEJQ?=
 =?utf-8?B?TkNKcTYxQmZQVFk3TGNYby9HUnJ5ZHQvWjJ4RGk1di8xRlM0Q1FvNGVYem5w?=
 =?utf-8?B?YU81OEVyRkRRUGxrdDVuaGFWQnF4U0lZd0xoTjNDREd4T3ZEV3RGZnlZT1B6?=
 =?utf-8?B?bHZMYTV2OVZsRDg4U09qTktpcWlNNExhT1F2RTdDL1pnRmJCcmZYWVc4QXAy?=
 =?utf-8?B?MnVmSzY4ZVBHZVBYMXJnbkpnV1VuZkc2NFhUTjJ6WU1Hc29FaFc1NXdlYUR5?=
 =?utf-8?B?OGd1MzFvbUFOcnplaEVOcHR6MDk3MUh3by9qcGhCWWJ5ZTFNelBuZ1ZiaVJY?=
 =?utf-8?B?cHdSQTYzRGpQT3pJUnloS3o1USs1RTBqWEJ5MS84WUV4MmVOTHhUSVhCdU1w?=
 =?utf-8?B?Yk9NSFFsdDIrVlNLd2dnd3hObXl2M25QU1RYWTNHZDFBdHNRbDhsSm9ZOUp4?=
 =?utf-8?B?cjc4d3RPdXdTRXh4azUybCt1aXZxWXNzeDlpZTNrNHRZQ3NxZXRVaHplclZG?=
 =?utf-8?B?dXdaODdaaFh2SEpWbk9KUVFsaXQzY0xFcXV6cXE2b2JDVlpURFBwV3MzRTFx?=
 =?utf-8?B?Nk1UbU8rQWZxVjBLSTI3YU9mOC9aMGMvQVFqNjRDY0t1UkJJVHY3WnorWW12?=
 =?utf-8?B?dU5qMHN0T0FjOFBtVjFkRUdDc0dQVzhGU1c3UlVLWThMQlZwTnA0QXVTSE95?=
 =?utf-8?B?K2p1OHF2RGY5QkdqZGlMdG04UEtrL29SbXJ0ZUdHNVJULzBDUSt3WlYxS1hH?=
 =?utf-8?B?Ty9MWm1JUzZUWGxCNFFKaXMzQTl2dUdCb2dmWlhTaVJqNnFPK2drTXJxUWc3?=
 =?utf-8?B?VzRsM29yUFludUhoRVRRTmtyWkQ3MkN1TUpZN1lQZkkrOGNpbkdtSVBQbXZU?=
 =?utf-8?B?a2xTbUNTYXZFdGx5d1VKbUlldlM3ZGVoRVVRMjlsUHBGaEFlaGVRVDRia3h5?=
 =?utf-8?B?YmdNcFMyVytSTHdOQlpJWUhPOXJ5empmQ0RKYzFVemtLOFBTbTJhbUE1OXNT?=
 =?utf-8?B?UDJiWmp4bEEwRzFiaE4vZDN5NGV1aDAyMFZpTlA0QTJIcWRYcGlqSFF2VjE2?=
 =?utf-8?Q?7dFv1CIQUzRrQz+s=3D?=
X-Exchange-RoutingPolicyChecked: 1vaipz5+htWtUg1jafRHJDx8QT7BMUyHJefBCzAkIn522pWobMhmHeIVDhHb2IjNOEJnOU+zUAsZSyUyFoev5rJkLvpe9SauWXDWvKZ5GXsdIr2GZSqxqj4Vm+w3PP2nJKUV1Eb5oILXmHuM7aS4KV3cVt9DjWatp2zBqW0L92GIKKCRNnAVtmul8EQoW+KBpt2SWusgqwONsRWC7YnMM1IXPOC6/DQOeoppXe9GMw0+0D6NMcGQ/fSFLylt+7bQPHJY+0SjNv3v/+4QsYpJWD5aR1bUlq11FcSIPsptlIztLecDx7kc3JzXhP0DkcxGMgN4WcaIP6puBBhO4mTyzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e5fd44-25fd-4391-08fd-08df2acd162b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:00:43.9637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKvqQYbEpi9haRmbicUPBsy16K+glMspCoQqvaIcvAV2F8TnkYbDLJdvRDVaQd1J3czS0hvKyXpNiGbKGP5gKhFzf4jXphZSWNZH4pMLQt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7794
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

On 10/15/2026 4:52 PM, Medvedkin, Vladimir wrote:
> Hi Anatoly,
> 
> One nit: the buffer must be allocated with malloc, could you please 
> reflect this information in doxygen comments?

@Bruce

Perhaps this can be fixed on apply?

diff --git a/drivers/net/intel/ice/rte_pmd_ice.h 
b/drivers/net/intel/ice/rte_pmd_ice.h
index dccfdcd5f4..881dc4cc56 100644
--- a/drivers/net/intel/ice/rte_pmd_ice.h
+++ b/drivers/net/intel/ice/rte_pmd_ice.h
@@ -27,8 +27,9 @@ extern "C" {
   * @param port
   *   The port identifier of the Ethernet device.
   * @param buff
- *   Pointer to an allocated buffer. On success, it may be replaced by a
- *   newly allocated buffer; the caller must free the resulting buffer.
+ *   Pointer to a `malloc()`-allocated buffer. On success, it will be 
freed by
+ *   `free()` and replaced by a newly `malloc()`-allocated buffer; the 
caller
+ *   must free the resulting buffer.
   * @param size
   *   Input buffer size in bytes; receives the size of the dump on success.
   * @return


> 
> Apart from this,
> 
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
> On 10/15/2026 3:21 PM, Anatoly Burakov wrote:
>> Currently, the `ice_testpmd.c` file includes headers that are only
>> available to driver itself, but should not be available to applications,
>> including testpmd. Instead, testpmd should access them through public PMD
>> specific API.
>>
>> The ice driver does not have one (even though it offers a testpmd 
>> file), so
>> add the public PMD-specific API header, move all function definitions
>> into that file, and get rid of driver-private includes in testpmd file.
>>
>> Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field 
>> extraction")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   doc/guides/nics/ice.rst                |  3 +
>>   doc/guides/rel_notes/release_26_11.rst |  2 +
>>   drivers/net/intel/ice/ice_diagnose.c   |  1 +
>>   drivers/net/intel/ice/ice_ethdev.h     |  9 ---
>>   drivers/net/intel/ice/ice_testpmd.c    |  7 ++-
>>   drivers/net/intel/ice/meson.build      |  1 +
>>   drivers/net/intel/ice/rte_pmd_ice.h    | 76 ++++++++++++++++++++++++++
>>   7 files changed, 88 insertions(+), 11 deletions(-)
>>   create mode 100644 drivers/net/intel/ice/rte_pmd_ice.h
>>
>> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
>> index ba598742c5..e4dd87649b 100644
>> --- a/doc/guides/nics/ice.rst
>> +++ b/doc/guides/nics/ice.rst
>> @@ -1021,6 +1021,9 @@ To start ``testpmd``, and add vlan 10 to port 0:
>>   Diagnostic Utilities
>>   --------------------
>> +The diagnostic dump functions are also available to applications through
>> +the public ``rte_pmd_ice.h`` header.
>> +
>>   Dump DDP Package
>>   ~~~~~~~~~~~~~~~~
>> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/ 
>> rel_notes/release_26_11.rst
>> index a4f44e5ebd..f3c820a72a 100644
>> --- a/doc/guides/rel_notes/release_26_11.rst
>> +++ b/doc/guides/rel_notes/release_26_11.rst
>> @@ -118,6 +118,8 @@ New Features
>>       enabling QinQ tag insertion and outer IPv4/UDP checksum offloads 
>> on those paths.
>>     * Added support for getting and setting link (802.3x) flow control.
>>     * Added support for Tx rate limiting per queue.
>> +  * Made the existing diagnostic dump functions available through
>> +    the public ``rte_pmd_ice.h`` header.
>>   * **Updated Intel ixgbe driver.**
>> diff --git a/drivers/net/intel/ice/ice_diagnose.c b/drivers/net/intel/ 
>> ice/ice_diagnose.c
>> index 4946ace7ae..ecfcdf5559 100644
>> --- a/drivers/net/intel/ice/ice_diagnose.c
>> +++ b/drivers/net/intel/ice/ice_diagnose.c
>> @@ -13,6 +13,7 @@
>>   #include "ice_ethdev.h"
>>   #include "ice_rxtx.h"
>> +#include "rte_pmd_ice.h"
>>   #define ICE_BLK_MAX_COUNT          512
>>   #define ICE_BUFF_SEG_HEADER_FLAG   0x1
>> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ 
>> ice/ice_ethdev.h
>> index 8d5e17e2df..08c2b61519 100644
>> --- a/drivers/net/intel/ice/ice_ethdev.h
>> +++ b/drivers/net/intel/ice/ice_ethdev.h
>> @@ -821,15 +821,6 @@ ice_align_floor(int n)
>>       ((phy_type) & ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC) || \
>>       ((phy_type) & ICE_PHY_TYPE_HIGH_200G_AUI8))
>> -__rte_experimental
>> -int rte_pmd_ice_dump_package(uint16_t port, uint8_t **buff, uint32_t 
>> *size);
>> -
>> -__rte_experimental
>> -int rte_pmd_ice_dump_switch(uint16_t port, uint8_t **buff, uint32_t 
>> *size);
>> -
>> -__rte_experimental
>> -int rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream);
>> -
>>   int
>>   ice_tm_setup_txq_node(struct ice_pf *pf, struct ice_hw *hw, uint16_t 
>> qid, uint32_t node_teid);
>> diff --git a/drivers/net/intel/ice/ice_testpmd.c b/drivers/net/intel/ 
>> ice/ice_testpmd.c
>> index 98c02d68c6..0c135d79a3 100644
>> --- a/drivers/net/intel/ice/ice_testpmd.c
>> +++ b/drivers/net/intel/ice/ice_testpmd.c
>> @@ -2,14 +2,17 @@
>>    * Copyright(c) 2022 Intel Corporation.
>>    */
>> -#include <stdlib.h>
>> +#include <errno.h>
>>   #include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +
>> +#include <rte_pmd_ice.h>
>>   #include <cmdline_parse_num.h>
>>   #include <cmdline_parse_string.h>
>>   #include "testpmd.h"
>> -#include "ice_ethdev.h"
>>   /* Fixed size for ICE ddp runtime configure */
>>   #define ICE_BUFF_SIZE    0x000c9000
>> diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ 
>> ice/meson.build
>> index 322d9597d2..00077be30a 100644
>> --- a/drivers/net/intel/ice/meson.build
>> +++ b/drivers/net/intel/ice/meson.build
>> @@ -19,6 +19,7 @@ sources = files(
>>   )
>>   testpmd_sources = files('ice_testpmd.c')
>> +headers = files('rte_pmd_ice.h')
>>   deps += ['hash', 'net']
>> diff --git a/drivers/net/intel/ice/rte_pmd_ice.h b/drivers/net/intel/ 
>> ice/rte_pmd_ice.h
>> new file mode 100644
>> index 0000000000..dccfdcd5f4
>> --- /dev/null
>> +++ b/drivers/net/intel/ice/rte_pmd_ice.h
>> @@ -0,0 +1,76 @@
>> +/* SPDX-License-Identifier: BSD-3-Clause
>> + * Copyright(c) 2026 Intel Corporation
>> + */
>> +
>> +#ifndef _RTE_PMD_ICE_H_
>> +#define _RTE_PMD_ICE_H_
>> +
>> +/**
>> + * @file rte_pmd_ice.h
>> + *
>> + * ICE PMD specific diagnostic functions.
>> + */
>> +
>> +#include <stdbool.h>
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +
>> +#include <rte_compat.h>
>> +
>> +#ifdef __cplusplus
>> +extern "C" {
>> +#endif
>> +
>> +/**
>> + * Dump the runtime DDP package configuration.
>> + *
>> + * @param port
>> + *   The port identifier of the Ethernet device.
>> + * @param buff
>> + *   Pointer to an allocated buffer. On success, it may be replaced by a
>> + *   newly allocated buffer; the caller must free the resulting buffer.
>> + * @param size
>> + *   Input buffer size in bytes; receives the size of the dump on 
>> success.
>> + * @return
>> + *   0 on success, -ENODEV for an invalid port, -ENOTSUP for a non- 
>> ICE port,
>> + *   or a negative error code on failure.
>> + */
>> +__rte_experimental
>> +int rte_pmd_ice_dump_package(uint16_t port, uint8_t **buff, uint32_t 
>> *size);
>> +
>> +/**
>> + * Dump the runtime switch configuration.
>> + *
>> + * @param port
>> + *   The port identifier of the Ethernet device.
>> + * @param buff
>> + *   Pointer to a caller-allocated output buffer.
>> + * @param size
>> + *   Input buffer size in bytes; receives the size of the dump on 
>> success.
>> + * @return
>> + *   0 on success, -ENODEV for an invalid port, -ENOTSUP for a non- 
>> ICE port,
>> + *   or a negative error code on failure.
>> + */
>> +__rte_experimental
>> +int rte_pmd_ice_dump_switch(uint16_t port, uint8_t **buff, uint32_t 
>> *size);
>> +
>> +/**
>> + * Dump the Tx scheduling tree to a stream in DOT format.
>> + *
>> + * @param port
>> + *   The port identifier of the Ethernet device.
>> + * @param detail
>> + *   Include node configuration parameters when true.
>> + * @param stream
>> + *   Output stream opened by the caller.
>> + * @return
>> + *   0 on success, -ENODEV for an invalid port, or -ENOTSUP for a 
>> non-ICE port.
>> + */
>> +__rte_experimental
>> +int rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream);
>> +
>> +#ifdef __cplusplus
>> +}
>> +#endif
>> +
>> +#endif /* _RTE_PMD_ICE_H_ */
> 


-- 
Thanks,
Anatoly
