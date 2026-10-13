Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A25CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 13:16:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEA3C4028B;
	Tue, 13 Oct 2026 15:16:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 850704027B
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791897402; x=1823433402;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=1m5W9TaQq8OgYtj+ppVFb0Mtv8GZWq+5EQxmjwq6+BI=;
 b=iflCIdMKeO/+dTLQJAixyaduHLgdUjHSRhFm3/0ZzxDvTohJTcM5akma
 PsDDhK00ym3w3V5pDp7V3naFUcNiae5nhJ0PmOS4WM9Yt+oF4pz1BLwbd
 os//2HERSWL0TPqCOWE82/EoKuy+eAhG0stGqDlgbeF3tOnruN39OVAJ4
 0G3OsRptXD0LKMsiVatGXWzTD7w7mYsi7cyG0wQIG6oki+bmZFBgpbBWi
 PVb0DgbZE5l3R8wyQVmJPx+7uj45Yt20Q0g0quBwGOhbnpTLs/bwtTbbg
 iv2ptaaI1NywKBXxDpeKnOOCNoW2k4sUckL+5H2gnyU5G8CMWdmEEmpVP g==;
X-CSE-ConnectionGUID: h0FpOGUjQTCNw7M+ybah2Q==
X-CSE-MsgGUID: m7aB7v5lQFCckywfu6OutQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="628657"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="628657"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 06:16:41 -0700
X-CSE-ConnectionGUID: KmKbjhj4Td61CMUmfgl0Xg==
X-CSE-MsgGUID: UhkWM1l8SnK1hBcAYOzomA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1629805"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 06:16:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 06:16:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 06:16:39 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 06:16:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AskQ7/+cPAazm8m+stGw7qkAOCIEj9fdCOB2hEQ0NEDE/5DmEl+7evPDDqUOhvn6uaeG0k6ABSoWhVCFOfUW5fllHPC1JPo5tvNabW3UbSsGa8bIBOKrW/OjEatsm5Wa7GknFLgf8rBiM4ctjQMtbi8FC7ZlNJPRlqGR1rmL0sXTlVgQfY/+znfmu3GoAydU+GTKomPmp1gV1nekFDOzu1s1RKPHmm94lUJ2LXF8jStauxIBgOzKm7M6lzZQdaIzzSwSNwvlE8H+s+fSHqHGiCVbDCEReWD8xiiIQbzM/Dq9S+kHD5zee7bQsajz3H2L1AMqQdhIdieF/QmjS4Ko8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qv3CEAU4+dLJdzUdjkeIyJB4QI9Yoa0O0XPhgJ7NU6o=;
 b=OeK3nVwCZkVdi7Tpzq04D16xJXYCQ39jzjN9+kJXD8YI4Mws/cNldMLC3lUN0dARsUtpNODjVP3XzRjPAFVjx9krr8kkGbGHKEEPGjxw7bE92UAzKNx6zDXM1H368sO9aTOwM19eqo8pCP96+wt02jBtsHa+YrQ1CN12ju/HMwpiQUUU5/JZbS0qiXlmMb0INkXsk1vLGTgSkjXYzROkzbG0s6Xzh8otlURN6A0xuMOF1D3Z6H/8upKt8l7tx4bELH080WXVzVdJMp6XdE88W0M9q4+aL9M31n7xkl1EKqrpVRYS2QZXuSOEiAaauTJhNBlOhV5ujbMkIlLPo93YDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by IA4PR11MB9347.namprd11.prod.outlook.com (2603:10b6:208:565::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:16:32 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 13:16:32 +0000
Message-ID: <e028fc2c-f440-43d9-bccd-4b201aa21cff@intel.com>
Date: Tue, 13 Oct 2026 14:16:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/25] net/ixgbe: reimplement security parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <4998e7f919e66997246dca2bd1f5ab8359ce1349.1791892576.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <4998e7f919e66997246dca2bd1f5ab8359ce1349.1791892576.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0017.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::6) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|IA4PR11MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 507df35a-24c5-4c82-300b-08df292c32d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Nffc8iOjP4nr2e5fkzFflflsxYYEnUx6w+Ug7MAweMX8BN1AUvCrkPk4X9Pxu3V6FIV4FgmllbyHlVr8SvWxmBpIfkXSw7NKjIrCxrfH9sBAIPegbdcRT4XsYsywKetJXfWrTya/3vAtu9m2srHBjbjtGLDgHT5rSxxf2KrKpnNCmW0AMbgj1YKjoG47aL03oNAUcIYRaHMD5lXntvnKXWDNSy1eMRNgyL3mNhFrpsgJ++rzP44E7y0nx+MMF2bxwmO9GBmo55pQXJ9PKRuqCKkRix1RjP2DXIdbSAkd2voAMTjY83R9BLOXPO5Gz4HVyYOMnIdrZDX/IX8rgbaCvcQr17TQB+5Bjoz4x7iLh6uYTJi0Jm5YdEVoLel0tRJynvlPCXy8tUtimyVxgS2fNV78aZ5UfjCCwhjfMsgzcRaSF+5SqqklCgm9Mroy6cOCnixTjK+LvbRBAFBLCt+F9qpIUeDyrYuLol/SIRCYPT0uGSirPh6TKlIDE0mFP8SlAFF9L+3DlnMNtaNm8Zxr7XmCnRxB/K9t+iKoeZc5g/f4rJSSpFM8m5h+RXzUgRd+tmYS415kPcM2wlbGs1VGaWTbG8P4pk8+s++LlVgjYRGfOmtQDzE4d+ifSVdB+FAlWcw9+DOgn4gswVnfN7oxy1x31J6GMEMPginjm6NRfUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0NmOHlnamcxUzRnU2hFRlRPWjlwaGlUbTRzd0w5UXM3dCtPZ0tlUzhHYXpF?=
 =?utf-8?B?VEt4ZTF2RWQ0TWIrYkRTaE1xT0NhWi9mNUJpUzFPcmhFdmwwMTdkK0wvQnJt?=
 =?utf-8?B?V0d0QVJmR0ZkTGhuamhKQlZ6RE9oZmRUVXZCRlpJV25RcDh4dCtrRC9qWCtM?=
 =?utf-8?B?cjZTblVjSURuak9zdVVsQW42SENLOXJtRnhYeDRFN3dyZExLcDlTWXhsNHYv?=
 =?utf-8?B?TEE1dklWamNZTG9DcVIzcUUyZzljd3M5RWR2RTE1U2FHaHJIejIwMGpLa3dQ?=
 =?utf-8?B?UUZaMldQT1UwVEI5d0FweHYxWnM4T3krMS83SUNBMW1iRk5wR1FtblFNS29X?=
 =?utf-8?B?VjZsSTI5M3Q3U3BJOEJFenBnZ1FBbHl3TUJyZ0p1ZFBvVUFWWTJZcWorYjhP?=
 =?utf-8?B?ZlkvVFNtd3JrRHQ5cUhxaUgzZGVMZnphdnpkZnM4T0xRKzd4UGlnRjlBL2Yv?=
 =?utf-8?B?OGw2eHczVE5GdkVIbGJzTXRTQXc1c1BNbzVpT1ltZ05ZMWoybis1WlYzL0k5?=
 =?utf-8?B?OTUxMzBNa3NMMkd4YWVZaWpHdDJhaEdyRnRRVUFtazFHaStKYXI0ZG96Zmdw?=
 =?utf-8?B?bG5vWXlGM0NReDgwL2FYYUtzOEtBSkxDSDBWb0tVUWQ2N3E0YWtTc3dNRHhG?=
 =?utf-8?B?aWxVaVlIS0FORVZDSXRYTWlBZzA3N2w2K0d6WE4yVEc0Y1JSTTZ0RU02YU1I?=
 =?utf-8?B?cFBGY1pkdklTbk9JWGw5QWJYeTZ4VEpPZ0dBSzhHUCt3UXdXektSVWxaQkh3?=
 =?utf-8?B?bmR4ZXRsOFFDdEpSWEhjM2ljZ0crUTkwS1BMTTREQkV1UzBGdVl3L21TNVN1?=
 =?utf-8?B?a0hXQUx5UWIwamw1MlJTdCtZMjNXYTNKQStjdk9JL1Y2WFJHODAvaVU3RkpW?=
 =?utf-8?B?QVR1ckhhNENlR0gzM0lCVjIxaWJaWmZFZ0wwUkRQMWJYTjhUTEJqL2I0OFlP?=
 =?utf-8?B?dnM3Mm9hbFVoY3N1MGs1UUM5eVZSOHM3bXhZTUpIendEaGhVMTJjaVlPNU04?=
 =?utf-8?B?U3NpOGx4UElsejkzemhFWm03cVFXWFF3RnV4M3lxVjNhWGpvNm45RnlrQjZh?=
 =?utf-8?B?Mm9iUG1URkhONUxKWE5JZTNxSStFZm9BVGllZVVxZEJPcFVobEJhSXA2ZEoz?=
 =?utf-8?B?d1NFakVEcWVOVVh2bExSc1lHWnEzV28zZEVyQVFhYS93RUpRaG5tVXFqd1Nu?=
 =?utf-8?B?SEZzbFJseDEzVWxwS3E3TkgyTWo5aUp2elhVWDZsU3lxSkhrdndBTm9iNnk5?=
 =?utf-8?B?ajNzWmtnZVlzTDNVWnF2bFNWTFVUMlU5eXNGOWVoMEdwSyt5UXpoMUJDQ1FT?=
 =?utf-8?B?cy94Y0FEUGliSi90ZTdxbW8vUkw0TktEZzJNYTRQRTEzWUtoR0xlMmtkWnZi?=
 =?utf-8?B?TE1zdkROc0plNXpQM1J1QU5PeGRwcE9xbG9hVzN1dk5zcWFvNlZDckRUNVVL?=
 =?utf-8?B?dk1zRmg2OG9TdFdQbnJQZEliVE9sTkdWS0FFQ1NsMUdwNWJBckwwTDU1S2ov?=
 =?utf-8?B?LzhyRkRjVVhzY1Flc0Z4NE15VVhZWDk3dmxPcE50ME9LZ28yc1hKRUJWTTc0?=
 =?utf-8?B?SisrYWFIbXBBRGpuWGtZTzhKWUE3Q0xrTG9pWkRjVXhiUjhsLytvdHk2cHUr?=
 =?utf-8?B?MVArS3Q2bUc1UjZ5N3AxS1JrOE9WSHZ4T3oycnRRK1c0RjI4bzN5L1BVbEtK?=
 =?utf-8?B?TVlLMEZNblF0VGNScGkrZTlleXVYZzkvWHc1WmhkMDgzbU9tanJBeWJuaE1W?=
 =?utf-8?B?NVpGbDB6MmpFeWJnaXlZaG5kSmZSWGhWeWJ4TjNidFVzS3FQd2JnVU5UZEdH?=
 =?utf-8?B?VytadWFCVFFYU200RElqYU95MjltazRxeFE3cVNoNnpjWkFlR01nWFZLV3ds?=
 =?utf-8?B?V1ZWYjlYa0xmRTM4MWxjRkJ6TTZQQkFEbDFUV1NmUzhvbUZmWktvQUZkVjVS?=
 =?utf-8?B?Mmh2ZG1CaXRUOXBjY1BJNVNYbE9BTDZvYlcvMnRzQnNUZlcwQmdmYnNLQlZs?=
 =?utf-8?B?alV6dHpRRklBWWQ1NjljVGZvdEhHRHl4SWJqdVVJbzlPellPZ01JcjduVjNI?=
 =?utf-8?B?Mm5RNk1qT2JpTUd1bmR5VEEwb0l0U1B6R2xCdEN5bUc5S0RycncvWGtELzFy?=
 =?utf-8?B?ODR3cGs2N0krM2VuTnZmYUhyNFNPNmNNUjFiYjZSQlEwdnlkTmh1YWFvYnhs?=
 =?utf-8?B?YWRUem45UG9MdC9TcjZLSE5mdkxJN3owb2ZGeDRwL0VsVzhiaTR4ei9YdVN3?=
 =?utf-8?B?L0ppaHp4bjh2TEpVOGF6Q2U2UTNyZmJIaWQzVG1DMDNHeXhCbDFPRnlBUGV6?=
 =?utf-8?B?MjBVVTZOZzdVS3h4Z2lFYmd4QUlSaytKdnRqcmw4ZHRLNW1oL2I5Q2xEYVNj?=
 =?utf-8?Q?WN7hOPu+/+VGVNzY=3D?=
X-Exchange-RoutingPolicyChecked: VokjlHN2LTNM8190P1/uKOlmeSaVzsihWf7xz72TVlJy2Vdi/Q/gEIZgT5Vsy9xkNbzucLVoynZ8U8Iv7IRdlRMBuwba5lQAin4OfK0pyGM55OQiKcbv5eeFMpp5JAXjAYFZ4NMke7sIdRmjMugXRcq1Un/MDnqZRhVRu9aPsqU8aYf3QjE/g3gA2VKUv5KHXoWQxRkLKhxZ1nQpSCQFXS8pn8rVWqjGXvBGAEoZ7rXueXJaOECZCNN4sFBahbNilIvsQWjkjmioFliSMlqkUjr8fWv/TjbcAeeAHSK5BiwTdVj2s5+ISX5wg+ar3pKfEeM2NGh+p4vZik4T3wE5hA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 507df35a-24c5-4c82-300b-08df292c32d8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:16:32.0181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iF1gIQ1Q/1pvBSO88NCH7axleof39lkQKHFoYf+DGrJt22K+wS6FoMHQVTktQKnxEemJqykInZo1QqE4R47ulZBsTg5Y1fKfWAMh4NamUGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9347
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

On 10/13/2026 1:03 PM, Anatoly Burakov wrote:
> Use the new flow graph API and common flow engine infrastructure to
> implement flow parser for security filter. As a result, flow item checks
> have become more stringent:
>
> - Mask is now explicitly validated to not have unsupported items in it,
>    when previously they were ignored
> - Mask is also validated to mask src/dst addresses, as otherwise it is
>    inconsistent with rte_flow API
> - The security engine was only looking for IPv4/IPv6 pattern items and
>    completely ignored both prefix and suffix. This logic has been replaced
>    by allowing [ETH]/IP/[UDP|ESP] patterns, as is used in ipsec-gw app
>
> Previously, security parser was a special case, now it is a first class
> citizen. All decryption SA tracking has been moved into the engine, as the
> engine is now the authoritative source of new Rx flows and the state of
> the Rx SA table (the Tx SA table is still up to IPsec code to manage).
>
> Because IPsec code does not manage the Rx SA table now, a synchronization
> mechanism is needed to prevent IPsec code from deallocating a security
> session when it is still referenced by security flows, so the security
> session is now atomically refcounted. For Tx, the refcount is effectively
> a noop, whereas for Rx it is now managed by rte_flow security engine.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
-- 
Regards,
Vladimir

