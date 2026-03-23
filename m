Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00177EC01CB
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 11:33:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0458040268;
	Mon, 23 Mar 2026 12:33:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id BD8D54025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 12:33:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774265582; x=1805801582;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l+rFYzZbyI3zVh5fZvZ+BdMkReISxcJfvpm5rScYWjg=;
 b=j4JsLMsdfSsGjuzhRrt7ivxuYBU3jj6t0/K0lAV8dNL39TUgtwrvMPun
 L2XjpYmkU2qzMpf1s5Lo6Q8Rwe+8tYQ4M8yNSq5yjH1E32UtThM81C2Es
 Ew+lVPoXOPhSoDlX8+ndm/9dzuyTfGOkqNZAKWa7sFDBD3BSiQvWYh/iZ
 Sp2qviGmiUOzLP3lGSTlJGuiYx1Auyj/lpGddQkm2DJO16yGJo3GHO3FD
 sVITGUMdW/U0Kq8PQXaJBvhwmutCrVuJcFpgr4MCP/Dp12U+ysoU/RlwG
 XrqDVl1tRFzKU0XSfkeEkBaJCvKxIcAc90EPl3gLNKq+oU79JZGjayTtB g==;
X-CSE-ConnectionGUID: SJJSroNvRg64H3JtLLBrEw==
X-CSE-MsgGUID: Att6i0K0Tk6Tp6mOhbPGmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="100712706"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="100712706"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 04:33:01 -0700
X-CSE-ConnectionGUID: TS4W6PQqRh2Ev4ldRYIN8Q==
X-CSE-MsgGUID: GLDxjfL2T/29/YQA4yUN/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="221165328"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 04:33:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 04:33:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 04:33:00 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 04:32:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zvm5cHsu2OB+8TwGaFPsCk25LwZ91CltceLiSoCpe9PR4j3fwnPLbnZtZ8krM+eEDScDPnMBJDtJ635fICdSVQwBPaeHevDl8esHBoqmfWzLWdFGLVGn/c1eGe40dUuHJKtHEynzyxfgG+O3c0JWpumsYKjyFZdb+KuCbazTcWY0VfL5+QpkspQR6naPgLCK2IpY8MZZ4/pyD8VKPpc7xuyP7xdMyYKmmRGuk9oG0YF94AdZNBr98YKKD5aOSHX8enCgilxQolToO3HArEn7kbodivZPFQKmlp4J5mv6Zt31GIhPBtouyhZwn9W9IKnjP1PPyJPLI+eeWj2vMFza0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26PLDV4Ig2HjfxJsZ5+oi+6+PRNHb082X8FgJZqFyAM=;
 b=A3/audMSYUWCtVY8TWZfXluvPWg7qehAUgDFqADelX6Yu0Lb5H4KZShyeHvKbjVAXd6gzmSCjfFHMckTpz9DGYnecfkKp+0wZklFoH8xG7wOykOI2P60G6brD54soyUNieW6I5s8oHTrhUmSKhFbTszVaqCsNUUTUrf85O201X9S7CjqVfv1ZMhjKjoPLsqo6Pd9N81EWaJU4cBPKQbfd2nnSZ1oqNolcx2ogKn7Ojns1JpzLdn4WmO9fumYDJ54LJeYMl0PDQ6nwiEpYu9hjJHojjeWUhFYVqyXZAvOoG1PvG8ajHdX0qqGnwfiHrPtD4SrC2yPNf+t5FZsC1Us7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:32:57 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:32:56 +0000
Message-ID: <bb973e24-bbf5-42fa-bc3a-2d5a524e1d1b@intel.com>
Date: Mon, 23 Mar 2026 11:32:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <nsaxena16@gmail.com>,
 <adwivedi@marvell.com>, <jerinjacobk@gmail.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20260322094346.52a87b29@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F657B2@smartserver.smartshare.dk>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657B2@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0274.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::13) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DS0PR11MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: bf10bcdf-3b38-4c27-15c6-08de88cfee12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: jhg7q4fPZCnwg1oGWV6LLgUgMntgNzDhkzbWk6y4H3On8Zrl1EGwMol8yJcumDHzexXgyxZEMyr/v13CnzR1UMRKLRbdCkQA1gasWADqu3gE2JS2Q0f1iVUD3lOthcKD1qoicK6mag2Ka3WuN/n6if39xtedC2Zjmf/ZV3cSmv/0zym0UY2bzgXylOEQSA1B/O5kfyMIm1yU4NIKqT9lHPiTdz69lpMZNleE69cpxiYZ43Ygq26AdijKhWUC/NeQiBEtWmBABzqXb9ebx/TeqaaIWEBDQ+p8i1HracXiOISpHzn+tDvlUbenD0HGBBbDvXYYYsiAh2GYeWkTreIoxXKZ346/rUoxpZgrccYXHUHyzl6xrh4+oQeNslMRRV2J45+hK//TG5vNT2524zbaZE+uvwV8QIUjvEfhYe6gM0sl6QyCrHjQ8mNSpJ6c6IskV/ApVGXk6fAwJu8naLqtyLaDsBUJ1U2F9sY+LNoRwEx0g/8A+5FT2SrYFEutd1x+OOxVDCiN/xUXxVayv0OBfH7WS3Zno2O3ODAr2QQ0lMqcNoDNHsMOsjGNAQLWfFcdoBn0ixDQR2BrdeuwsMuNS/RaWwNSv+iOqDTlGvwR20rL0BlY3oYAlW+zeabdPi3gp4NJAOKf0h+yUw9daK1+4TQGov3+y6rrMu4z0XIxww4PGDDKpDVq3/TVMpS//U/5Q/5I3bOjtpXQnnjuJt6r6q99VBPnHf83qRSwC34V5mg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01YcUZpY0xrbkNmaDZ4S2EybGF6SXRFYXNyc2lSSkpPYTEzMlZHMEw4Tmti?=
 =?utf-8?B?ejlYOG9UWHVZb0Roa3JOdHhxK29CWGJsdGZwcHBTbTdYVGFtc3UwNkpnUHpV?=
 =?utf-8?B?WmV2THJ6MXRuVlhuY2Z5bHpLZVRLK1VqRmlwNGMrTUxTQXJmZUc1MDEzT3JQ?=
 =?utf-8?B?OXUrd291cTJJZnhhY2hCMHJaK1F6VHNJVFdER1A3MlBvUGF1aS9jWW1HTWd1?=
 =?utf-8?B?MGNRTHFCZGxCNlBRbXpSZFFNSkFhSjhzYkthYWpmZjN1QjM2Z1BlelZTbGxl?=
 =?utf-8?B?dU1paktPaUxWV2xvUnFTN1JtQmtlOXFTQmxZdzhQY0JqZDlOMzkwamJvRksw?=
 =?utf-8?B?blhYMnZQVkdZcVpscEQvYWJvYVhCRG82eTRWTTBNOHRHa3hrY1JIeldpRUFy?=
 =?utf-8?B?ZlRDNWVUUExYRnIxQmdtTnBxNWNya0JZZjRhMXZ2VGRNNng2bWJPUlYxYzdC?=
 =?utf-8?B?dGFRUUU4WlRuckowTzZ3TWNyTG5IZXNTa3dkV3ZtZk9mYy9zcjIrSlNjZ1Yz?=
 =?utf-8?B?MjJmLzVXNE1NUFM2VFBkbnRianpWNjQzS1NqbERVSVcwN205MWpQREsrSHNS?=
 =?utf-8?B?Yi9rdk96UVJkZWZhSC8zVEFjMEQ0M3BmQVg2OVI3eGNaa0lUMzFmY0tObXIv?=
 =?utf-8?B?WXMwOWNhdWdndjdnZW9QQ1pxR0lYNkllaS9QS0phRGs5NEwzd0FZQm9XVVVU?=
 =?utf-8?B?STV6TEtnSlBCWXhabUxiK2h0cjErbHR4ZlZTQ0NsQzhmZldWZktwLy91c3Mw?=
 =?utf-8?B?cFNoMVp5Y2hqSFUyQU5YNnpVYkJjbUVRd3g4dmxrb0lzWXpTZ1llM2F4ditz?=
 =?utf-8?B?NDJEdW95V2Y5RWN6dDRYWmZlOXlWeVZMK0hCQmtZY0VnK0NMRElubEFxazBD?=
 =?utf-8?B?a0VWMlB1QUp6YTdwQ3FBbzd1L2tvckNrUFZGdktMcVcxUHYwOXpyY25id24z?=
 =?utf-8?B?WEVnVDlHRFZKS1U1b0I0RkVkNUFQaDBkWVVudVVIRkNtRWpiaEs4TUNjOE83?=
 =?utf-8?B?YlA5M01jWnZXTm96U2htbVlNWFBZVWJBK2hOYmtRT0UrTmRJZDJYc0Y3bjhQ?=
 =?utf-8?B?STFJc0pJSU9TNUNFb3RDWWdqS1VJditwMG9Yc09tbFVlWm1NdHZRK0NHdGUx?=
 =?utf-8?B?ZDdLQ0dmcmRNRUVrQ2prZVRsa2ZObHVEV01CWmpEVFBSTlRNenJteVVyayt4?=
 =?utf-8?B?T2FBc1hhY0RIQ2EvR3NEb2tQS24rM3pndkpUTWFaV1EyZm1oYzZ2QnVlVDJr?=
 =?utf-8?B?NmlTa0JMNjRMaFFYTmxPTENvVGpobTEwM3lYdlFzbG5Ed1dzeUVmMXlIM2lR?=
 =?utf-8?B?RUFUTHhNV1RGT0lmdzBJaDhnUkkxQ0hsd1pBM2xmYStXb2daajJTNXlhdzFN?=
 =?utf-8?B?WEpmeW5pRlVNR1NYL2xqeDhXanZaeEpJbjlKOHpxdzZ1aWpnZGc0VlJhUE9j?=
 =?utf-8?B?eXQvMGtvL3pXSHY3bE9QcWJoYUxOMjlsVkJkUUpqWlpZWlJ2dDY3R2lLZURm?=
 =?utf-8?B?b2NtODM3UDkycG1XNTRVOE9QOThGcEQ4Mnd3UmhucDlqcFNaWm5SZnJncVRH?=
 =?utf-8?B?aWxUSldLZlBjZFVVN1gwK1IyL1ZtNkRWaDRkdElHMnZFd0h0U1JLN0JoZkRh?=
 =?utf-8?B?T0xlMHFjSkRsZ2dpY3BLVk1zNTB6bVVDR3RSa3A1VjBBb3hEaFVBdlVKR2hK?=
 =?utf-8?B?UVVBRXhBWWxweHljQzJ4cUhjYVhxZWxubmpvQnNrODBqd3hjcjg5ZXkvRmhK?=
 =?utf-8?B?ejAvQnVBazYrcndwclJ5MWtBTGYzTGw5NkpJZEdWNHBHNFNUbUVEWjZHdEpy?=
 =?utf-8?B?SGRUZGxRRGltTnBXbWNqOG5xUzlUQkY4djQ1czVxZ2Q5R2JiMldDQVR4Vktq?=
 =?utf-8?B?RTQ0VzRLbE1RMjZvbElVK0E5ckg5U2QzaEFkNTRDMzdQdGpmVnMvSVAxeGFH?=
 =?utf-8?B?bzJqcmhnRnJyQ3hRNGpuWDF1YWRGaGdPZnJXcnhHZStvRUxJcExxdk9nQ3Vt?=
 =?utf-8?B?aVN1UXFOYmNBVklZOGxGVSs0T3RXd3VpcHh4SmcwK01UbGFrNHVTUTBSTjZw?=
 =?utf-8?B?dmFHaVE3UzFqQzFabkZ1bHE2aXpWV3piekJPZEJTY0JkOWVORTZkbUlRK2hy?=
 =?utf-8?B?NGVQeXFQeDlMRm40OEttR1U1MkZBdmdsbkEvdjFaSkNPT1JtdHE2UXNnQisw?=
 =?utf-8?B?U25Gc0JqMnZSR1g2cW8yRmpEZXl5QlpQV1F5TmVNL0xSQ3ZwMHo3eEcybjRs?=
 =?utf-8?B?QVhIcVY0K0hFNTA1Mi93ZmFrTWs4a3FJNFN3Y09uOHd5dmFDdkRveFdXK3Vo?=
 =?utf-8?B?bjJzREhzeU03ZUhIQTRjMDV2dTJEV1NuNVhZZEYycFBuamcxS2VaNFFCUm5x?=
 =?utf-8?Q?AfisG+SGafoiR/xY=3D?=
X-Exchange-RoutingPolicyChecked: kV/TWXlezfCVPDGJ6ymbGbIFfNPomW+oh3nJcf/0nUZx/0JJSXtdmJpYA8PUZqHLl02p5Q4d3TFxt4KgeNq5Fd2QLWu71ngYyNa0t1t138PPjXbC5+gfAtPIiOm18Ysz1eBYTvx+zgfDspupe9jYCXtBeCE1fsUUlJ5NyKviyyDzWBIukMd+64OYnPKRsK78CvFG0QnTBtyjptjjhGNjHeTml5yvk4ayzgY/zGgsyo5mpQMROIkynw67sxQKOAXwtJOouOv47qGV57D7r/+UxM9gdsIG9uhzMtZ9b6sKdg7jL+mDLTM4uF5OTLSTRL1b7faQPpb38W+c+mvz96NoeQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bf10bcdf-3b38-4c27-15c6-08de88cfee12
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:32:56.8928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhZ8TDWSQo634xcMxYNqp82SIwG2OpZAWpOEzAa12A9EkXzX/ZgMep53pZ8kHpWa+Q3NdDtnK8IoBIc/I57RNml6wZDkTfW9kF/cw3/5UUA=
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

Hi Morten,

On 3/23/2026 9:01 AM, Morten Brørup wrote:
>> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
>> Sent: Sunday, 22 March 2026 17.44
>>
>> On Sun, 22 Mar 2026 15:42:11 +0000
>> Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:
>>
>>> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
>>> allowing a single FIB instance to host multiple isolated routing
>> domains.
>>> Currently FIB instance represents one routing instance. For workloads
>> that
>>> need multiple VRFs, the only option is to create multiple FIB
>> objects. In a
>>> burst oriented datapath, packets in the same batch can belong to
>> different VRFs, so
>>> the application either does per-packet lookup in different FIB
>> instances or
>>> regroups packets by VRF before lookup. Both approaches are expensive.
>>>
>>> To remove that cost, this series keeps all VRFs inside one FIB
>> instance and
>>> extends lookup input with per-packet VRF IDs.
>>>
>>> The design follows the existing fast-path structure for both
>> families. IPv4 and
>>> IPv6 use multi-ary trees with a 2^24 associativity on a first level
>> (tbl24). The
>>> first-level table scales per configured VRF. This increases memory
>> usage, but
>>> keeps performance and lookup complexity on par with non-VRF
>> implementation.
> I noticed the suggested API uses separate parameters for the VRF and IP.
> How about using one parameter, a structure containing the {VRF, IP} tuple, instead?
> I'm mainly thinking about the bulk operations, where passing one array seems more intuitive than passing two arrays.

I found this design to be more intuitive and kind of backward 
compatible, many apps already create an array of addresses, adding an 
extra array with corresponding VRFs maynotbecounterintuitive IMO.

ButwhatIfindmoreimportantisperformance,atleastthisapproachis 
moreconvenientforvectorization.

>
>>
>> Not sure at all if this the right way to do VRF.
>> There are multiple ways to do VRF, the Linux way, the Cisco way, ...
> I think a shared table operating on the {VRF, IP} tuple makes sense.
> If a table instance per VRF is preferred, that is still supported.
>
> Can you elaborate what Linux and Cisco does differently than this?
>
>>
>>
>> This needs way more documentation and also an example.
> +1
>
>> Like an option to l3fwd. And also an implementation in testpmd.

-- 
Regards,
Vladimir

