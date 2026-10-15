Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757AFCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9910402DF;
	Thu, 15 Oct 2026 16:17:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id C4D754027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792073864; x=1823609864;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MP6dHTlzlXJj4QCz96lpPnC4jIi3QKdcrCmEIMoYbCI=;
 b=B8D7FDsMafyLQgK9miCym9A0C0dvVqMfOha+i5DhTejSNsOVI3brfAcl
 lxmDAPUJaDmBJiGhJpGzI9hglfUChkDKzsaIvek8ZIdrgYUIdVbJPUTT4
 y4Rxhefp9ok5HvtK5RQ35FP9k9YUCTuzSax6+7hQnHHwRokXkx9Z2q4h+
 JsaEZ4rtAIcSrBeU3EYfN0thUeegfuuObYbViVTDf8zPcjc1eY7rKEX36
 oAGNh8Zzk2A9mcwjqH9eXFg0CTcxSgrDqoPVvbjiIYfCQFWZE/HGYc/Vy
 NWrSGVpMH+MSWwgWjO5/DRBgVjYHQ8Yt/BVtnmcC96Gh8tGqe7GnR0tKT A==;
X-CSE-ConnectionGUID: 51Xb7SHPQO+HNYzDJLOB5A==
X-CSE-MsgGUID: chBSzSIwQFWwHzeBON+dYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="846292"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="846292"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:17:41 -0700
X-CSE-ConnectionGUID: a9aGFrEbQtKs4bzsSqSiRQ==
X-CSE-MsgGUID: 4nk0fYoMR6uKdEX4ek94Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1671804"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:17:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:17:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:17:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeNimO5B0DsJoKwJOJdk6hlvoG6ZcKIhPDhC34pjaZSSqMyH4qIjHD4rsDl7bHVHYHd9Fxwx3ppDFhZGuqTEUflczGBXcvWpQVPlYv1EvSW/DFmI8e+jGJXot47qwKQLWjZyxBoCcFzwNE4cuBEPa1Bln0oWJQH/Xy3A6qT40R+YL8BdVkkqJaXxsKNmjyyVAXE3eogOPnAvtilSuVJMpp/qhAxo7RcE8aJZNA3mmI2rJmt+/RLLHePwLQxJhiaxrBwmaDZqF2btAjAbWZ3FCMSptPrrwbk0heAlm9dg8RZyIxfF4k6uhRt/IvIBGvB1AanNC48ujRCk6LCHbxqulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OmIicXTpvqSENJ8UWpOGhp5ILTuOTacN+87VNrsb0w=;
 b=zSkIkrkoSJSij6/RtCkWvK0BJV4Pgv06cPs5M3QHj79eNdAzm5C0zAui382rmyO2CF1v4JfQGyeFKVcYM0U3TdM5AIn6O7T3jebwCp0ZrEHK5wpd+lAVfO4o7xxzzv7xPQOKFFXUoF5Y0Ty4h9vBjcEq+AQDFisCO1chZk4jGgpv3F7C8+8uwaCh8HalTljU+gtkwBiTBerFne9Da/D/bzDoI5w0FBNEcg9RuIkaL1obbbEjS4AETA5a3cgxgI8TdcHTXVSiXzlpeUE4n8D/fDA/8Egu1qwDqGV8lWOUzAjIW7gDdyYcXH6inYw8FSnezqzROiUdveEAqp0MpbQkZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Thu, 15 Oct
 2026 14:17:34 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:17:34 +0000
Message-ID: <c9df7898-78ca-4dc6-a19d-23c120aee2b5@intel.com>
Date: Thu, 15 Oct 2026 15:17:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] VRF support in FIB library
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <mb@smartsharesystems.com>,
 <maxime@leroys.fr>, <konstantin.ananyev@huawei.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
 <20261014155540.33820187@phoenix.local>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20261014155540.33820187@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::22) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|PH8PR11MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 110a5118-974a-49d0-caaf-08df2ac70e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|4143699003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: iDHCRKHO2/QNgae8Btt4U1mbjDbB2jP3+hYBBAKdjN77F4OTr33E5Y0xhI/huZ6QCWjpE/T8GjvMU/MDcy7oSXN6jwZ4KJXBu75lM4aEehjJ9OjTNnCkYfjxw53UcJF1Gf2q1J+1I1MZAFnPhfensinJY219xmUIKdEqS6EeIpRhXQERKvx2XW3dwd42fwUASn3Z6S6UoxtbBswNYNKLW8cw0Bwyy3JWj1uDmDZRi494/DMH6SaQ9igJRmOi+Xw8L2/kIwl2S3s0RJ4Lu59rD4/iyRpG+xhP0nhNDQhFQDG2DIc3OxBkumsfbmDYTVMoqQv/YrKUe2B5VpsY5rRys4xlmPGWI/ErOUSmV3jjHYANfpyMbd6SfBQw7fQojK5qaNuGC/Xt/sQQ3ufMc6Oz8jR+UugD4IiLbOb/F+leRRcjWKzlhegYMZ9UdZ773wIMsBlYPiqpFEOZkA/GoTAgUqxID40z5e6veJ7CTAfqPkpFKHuqADBGETUzoed2vLQCyds94qbPsXiKrb96K3p/mnW45fi3aeGRtGtYPd1EhtzCJu0mdnIbfmOlEbMolLBVDg0RXjrQt2MKn509ZCkD7enaKej5BftEZskfxLfGQuoczgs7VvCmsYLqc2EZqc4kHTU1v5v2eQOW3n+ANxBUYtC92yke03TK1lhVTRuAuc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21IbFQ2WVB1TDZqUVlXczkvTGdocUtzVHZPR2QrUk1RakgyUDJ6TlVjczJr?=
 =?utf-8?B?bEY1TmgxelVPRVIwWDcxaGZoNkZHdWJyVys4a0RUNHFiek5MNnNHTHBGb2tB?=
 =?utf-8?B?S0hoWlNzcDFVSjB5aGF1OW9JN0gvRGU3UzM1bXBqTU1vVlNjNGsvOU04cWRF?=
 =?utf-8?B?cjJ5S3VpclU1VmhRenh1VnZxa0pnOE14UVhWaHgySHR0OUdsZnBZekU5ZVYy?=
 =?utf-8?B?ak9XQUlMNHNFYi9nL2NkbVpheEd4N2hMNVpucUxIQktkWjUwcnRsdzJ2MVpu?=
 =?utf-8?B?L0VPYkNyMnM1QnlxT0JNSjRzUHp4a1VUdWt4VVB3bk44VmdxbjVBU3ZLdXI3?=
 =?utf-8?B?M0VZR3I5aGpFanFZZTNoV242ZVh4S3VKNEtVQ3RPTVRreTNjeXU4QU9kRnFZ?=
 =?utf-8?B?TFJ0ckt3ZzBpRXh3Y1VRQTdmckttREVGYkp5cEs0TVloOWJsZVk0emk3Y1Bo?=
 =?utf-8?B?RnhxNDBKRHdXb0xSUkVVYzBGZlNmUnppVFlqSEtNZkU4MnE0c0grVmdTMk4r?=
 =?utf-8?B?YjFzTmQvaUhkblJrQnFLU21DZEkyQW1BUkJIRXVwU25JQ05NTTd3c3h4ZlVu?=
 =?utf-8?B?VVdrSjFvUm9TdjEyYUdjTE5VYjBaSzhsSUU5RDBkazVHdnB1dk1SL3JKRnFL?=
 =?utf-8?B?bGo2ak4xWGFWcDZXT3VsSFdiNEx1cGFvWmFMRnZQV3lrNEQrNjNva1orWUs1?=
 =?utf-8?B?RUgvb01nYS9SUmJOQXRnRzNOS1owejdUOWJHM0lJTjdTVEFWV3drdThSbzdG?=
 =?utf-8?B?aTFzc0tkMzZMY0pWcEtxRWdZaHRiUm9OTVNqVlBqMWtPNUt5OGllaThPZERr?=
 =?utf-8?B?VEwwc0FaS20rckJnUkxyY2RtV0g3bWE4YU1lUTROUmdiNmNGTjJhekNnUGhS?=
 =?utf-8?B?L3VPUmtRRUZmbFZxRWZ3dDE0ODRPNCswcjJQYW84TmFjTDBYQmZ2NE5MU0RF?=
 =?utf-8?B?RjdTV3dhcGFadDNJWGNjaUdmTWlTMkRWdHFLVTlpUjkwWWNIbnZvUUhsUERq?=
 =?utf-8?B?SGYzUDdhSnpjZHpuNlN4WmpVMnVIemMrQTJTeTNLMXdtaUV4TTlvQUx0Zjg3?=
 =?utf-8?B?Y0tTODFIREVCeTNjS1lGTSs4QWErc1oydElabjgyM3dhQk04aXR1U08xTzRI?=
 =?utf-8?B?aGZMS1M2bXNUWEdyR3kvZ28vZk92YXI4U3hxRFVSNXRoWXYwWHJIcXRGN1k0?=
 =?utf-8?B?eGNaM1NTMUlpOU9KYWJCRXdaYWZTbjJHQzB2Q3V5WE9BUSs2SGk2R3U3SkN3?=
 =?utf-8?B?eFVHZXVSM1Z1RG5obHRQMVQ5MXFKYWtlWXFId3RkbFJpUkhDNzc2akFWbVhP?=
 =?utf-8?B?SndaY0phaFdUeW5RaEV6NWIxSFNqV0dXdXgzZURST1BucmFUb3IzTkV6WXlJ?=
 =?utf-8?B?eWY5QzhNeUdETmw5NHljdDBuenZFU3hDcjlkQkNmN2dZNzNXc01uN3Z5UTh5?=
 =?utf-8?B?U1BLVko3R2NQMzROQjYyTFU0TFlrODcyanVoSEcvOHA4WWpiTHMwbUI2UVAy?=
 =?utf-8?B?M0NaWFpqUERCVEE1WmFQWFJRSDhQUUpUcWp2YlgyVityaHFhd0JqVGhWNXky?=
 =?utf-8?B?bUNHZXNMYzJlbDdUTzRkR2VTNXpITHA4NGVFK2M2VVV1M2JGYkttelpIelNq?=
 =?utf-8?B?TmxOMmwzKzhsb0RhNkhOVEdTcEdRd0dlanF6a3lQOHYxVE82REsxVlY1NWpu?=
 =?utf-8?B?UFgxYjhJdTYyQWx1QUYvYkllZmdabHozRk1WVDk5RXA1VGkxUCtTUk9sWXE3?=
 =?utf-8?B?YmdKSkJuNk8rY3Z2MHJYUU10UzZRYk44bnNuV3BVMnBxeExQUklXYVM3VHZR?=
 =?utf-8?B?L0lkNm1DR3BaNFZWQm9FVVRwWUc5Sk10WlNYUUhQL1VkYWc5eUdIcjR2MnZI?=
 =?utf-8?B?TkxiUW9HLzkvekFnL3VuMVlGdGs3RzVYQ0NwN0h0OGwrWVViWGlXY1loRTBI?=
 =?utf-8?B?eWNVbjJDMFB0dFJobkEvN09OZXRqWWpHMFQ3ZHBQYjlZeDF3UGN3WndORXE3?=
 =?utf-8?B?WHp6dXFaTDdFcjRUbFlWWGNOMzhXbktjU3A4em1PVmlPWXZCNlVUVDlEckU2?=
 =?utf-8?B?UWtIZjU3ZFJNbGNBUWNrSjMxbm9wbjduZEpQQTIydDJkY2xDdUp4ZnhkT3lQ?=
 =?utf-8?B?bkpTL1RoZFdsb3Nxbmo3Uy9GdzZ6dmdObkUwb0ovd0hrM2pKYUtTdFYwWUNJ?=
 =?utf-8?B?NTVsZzNhWXlSUXdROGJBeVdyQ1J6M2pzNERla0JSSnpOdEM2TEYwRitGdG9x?=
 =?utf-8?B?ZlZQcHE5RldTVXJ2ZFlQVENCN0JqNzJQM201ZHFncllBemJOTFJtZmgxQUcx?=
 =?utf-8?B?MHBmanhtT2paaFZkUkJwd2txU2ZIL2VTWnBpSHRnK0s5SEJacW9kc1RIUkoz?=
 =?utf-8?Q?LiYjzLk89XlFguPU=3D?=
X-Exchange-RoutingPolicyChecked: 12CC3I8VXIZCeNwTziJ+2HWs0VgelgYeYU/xhBCBVrmol8pZ7hFIzemtce1IN/PA6Wm7xjwm7UHiaY2yndw+yoA2Y13btqKKJ4G0pANwRYJUg6tvBJtuyjWppYv1QsbCMrdJQT/mMO4FwrkJ4kE8ZM7/4w8FL3f5/NVEpYkc7clB2PXR8VHW2UtSRM64xmCh2TrqkFsnQz+/imoASARlYTM2prcL9JKQVUfk8THJnOVHcuLz5iRGur8pXOc107jxLzv3QmaO9K2gr9izSIRKASyy4QQTyyRfY1X6twhqtKVGqYt2uUrzPPUpsdGep+azm++xGK5krXDk4GAl85ElQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 110a5118-974a-49d0-caaf-08df2ac70e8b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:17:34.2047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuHpZc6PRPL5kq80y50R/shyWfgl7JivV+QOsz63sUJYd08CFdjE3hB2tRrh63G5sRshLlDYVpe3ShEHdi5ybrVL/+XOaz6t7NhSM4aErO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
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

Hi Stephen,

On 10/14/2026 11:55 PM, Stephen Hemminger wrote:
> On Wed, 14 Oct 2026 18:39:14 +0000
> Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:
>
>> This series adds multi-VRF support to the IPv4 FIB, allowing a single FIB
>> instance to host multiple isolated routing tables.
>>
>> Today a FIB instance is a single routing table, so an application serving
>> several VRFs needs one FIB per VRF. In a burst oriented datapath packets of
>> one burst can belong to different VRFs, and the application either does
>> per-packet lookups in different FIBs or regroups the burst by VRF before
>> the lookup. Both are expensive. With this series all the VRFs live in one
>> FIB, the bulk lookup takes a VRF ID per address, and the existing API
>> operates on VRF 0.
>>
>> v1 replicated the 16M entry tbl24 per VRF. That kept the lookup on par with
>> the single VRF case, but memory grew linearly with the number of VRFs,
>> which was the main concern raised on v1. v2 resolves the issue by adding
>> of two dataplane algorithms with different memory/lookup trade-offs.
>>
>> DIR8-16-8 is a new three level variant of DIR-24-8 with 8, 16 and 8 bit
>> strides. Only the 256 entry root table (2 KB) is replicated per VRF; the
>> tbl16 and tbl8 groups come from pools shared by all the VRFs, so memory
>> follows the routes actually installed rather than the number of VRFs. The
>> cost is an extra memory access for prefixes longer than /8.
>>
>> DIR-24-8 gets multi-VRF support by resolving the VRF after the longest
>> prefix match, along the lines Konstantin suggested on v1. Instead of a
>> vector of next hops per prefix, a single tbl24_8 shared by all the VRFs
>> returns an internal prefix ID, and a hash table keyed by {VRF, prefix ID}
>> returns the next hop, a miss meaning the VRF default next hop. The aim is
>> to resolve the VRF with a single memory access, so buckets hold 8 records
>> and there is no probing beyond the bucket.
>
> The problem with existing FIB lookups is they are space intensive.
comparing to what?
> They tradeoff memory for cache misses. Every level of indirection adds
> another cache miss.
This is not always a case. Also that's why we are using prefetching.
>
> Not sure they work well for VRF case at all.
I suspect this objection is applied for v1? v2 should resolve the issue
>   Normal LPM is more compact.
  more compact compared to what? Under "Normal LPM" I assume rte_lpm 
library, if so, then comparing to existing FIB, which uses DIR24_8 with 
4 byte nexthops (apples to apples), the memory footprint is exactly the 
same.
> For normal mortal size machines having multiple VRF's is going to be huge.
> How big are you envisioning this?

 From my experience when I was working as a network engineer in network 
operators, an average PE router could have 2 big VRFs (about 800k 
prefixes for v4) and thousands small VRFs with about hundreds prefixes each.

With this input an average size of a dataplane struct with:

DIR8_16_8 could be around 2Kb*1000 (VRFs) + 2*256*64k*8b(TBL16 for 2 
VRFs with full view) + 1000*4*64k*8b(small VRFs needs around 4 TBL16 - 3 
for RFC1918 + 1 customer public net) + 1000*100(prefixes more specific 
than /24, off the top of my head)*256*8b. This corresponds to TBL0: 2Mb, 
TBL16: ~2.5Gb, TBL8:~200Mb, so under 3Gb of RAM.

DIR24_8: single DIR24_8 with joint prefixes for all VRFs and 4b entries 
- 64mb for TBL24 + a few Mb for TBL8 (since all prefixes are joint) + 
hash table of size from 8Mb to 1Gb.

This sounds like mortal machine RAM usage to me.

-- 
Regards,
Vladimir

