Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492E606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kNydIArD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 769EF40647;
	Wed, 21 Oct 2026 12:17:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7428940041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577857; x=1824113857;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=NApSG3N5WAX8UArLzFLB7KiFe/0VhmGzdTWjTO5GkdQ=;
 b=kNydIArDJBHJ3UUhKiOhK16JLZ6x9MfwjN+ZxsheaK8NjH4NxIuAJJ7f
 3JV66BFQJ5OKaDj8qgrRZzQikjPelevRXxZES1CZnxA6APQylN6wzlNOF
 GE6uZ0iBmyWAjOu8ObRkXcBu7kFPOXqWfH6YypFiFI56luNyqY4GU5lRr
 tMXPT0YELZ6CEUVDFYf60CghGUufdtk72lLHyWhnzlLunCeSquSrTuBSb
 KQyBid9ql4g2lVW9zQ7FbMomJieGNnxEK1YRU0hYjZWXIoZ6Hir+veRSX
 K+0TCoFvlDewLmL+YxrvCYH688vHYfb8uO4VF7xiAHTtaWnCJV827QqOE g==;
X-CSE-ConnectionGUID: 7rpeR7n2SFi69RqRzChg6Q==
X-CSE-MsgGUID: n/d/5ZcvQIqJWhszpVtV8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1173091"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1173091"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:17:36 -0700
X-CSE-ConnectionGUID: 0v3yob+ySd2cHubGMk223A==
X-CSE-MsgGUID: FbW64y9UTaaMF/sfa2VD+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3518168"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:17:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:17:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 03:17:14 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:17:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKlrVs1fkcep6B5FItUFB2In3wyGbrevgC5M7jvWTj47yY2crXDLa4swOLue/QFre/K8AsIxAll8Po28d8LHncjMkgnspfT0xP4pvEn5f3//uFcbihaKCQumQHv+pOJiv+RVbqoCkVqJ4j1G6rvMY5Fjqnh54hpl3oxribvYuchYCJCZsfR9YFLSx7UQN1McKpZvt64yjuonSzYwKMAzTrKNboKk+VcoqdKpJKzK88oMYBvzQmymmzpt6nIoaV83C3TQU1wUn4bM2FZ1j+7aWdSa10AMvPPDuy9y7fiXn/5bBPGHecrB/5ySc7uirwEVRAs4REWVNHTDl5v01UDd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj+tpUBUT3gTP8VaPsvhuI62qb1qrE5AIq1IkLTLrD0=;
 b=lczKP1wimIkEUu+EYsYOqtHxxBQlv3oKCgZFe+e0jOh7bA5JSwX9z1oWkUw8rg8wcPspn1IZkXav4yOLMely8Y7eY29FD65AfUbSr2el1jNGhrPUEIAKgQQMVI10q9nZ2nvEpxSC6hAa2ih/UfYWB9qYfOxfuhVQw2Tx64/MZ6A1HAIBBvo+XloN7Ae8SrLuZpvK6XqxTKI13XEx/y8mBjJ7nwilNaZDcnaS3Lrxzg6deMV3sKhxKjFy0GeX8RJX9+H/xTK0IpBAHyLxK4KvMYY/Lx2LhNI1XKRkCTwOY1W6HEhYyStTsDITwc1Ixk5kyjKEhbK4z9QrqR1L0oq9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CY8PR11MB7847.namprd11.prod.outlook.com (2603:10b6:930:7c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Wed, 21 Oct 2026 10:17:07 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 10:17:07 +0000
Message-ID: <5290da6a-975c-4605-8468-c87a87afd329@intel.com>
Date: Wed, 21 Oct 2026 12:17:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] net/ice: remove unused flow handle from engines
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>
References: <869a70bf8e9bb8ce36de57ddb46ea2d44d7b9be9.1792577695.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <869a70bf8e9bb8ce36de57ddb46ea2d44d7b9be9.1792577695.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CY8PR11MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: d35ccbb8-a1bd-46f3-c3e5-08df2f5c761b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OwdVfHqQZkg4dA42vU8IGgiheSA34cgEFBg47NeB2dy3EIWuyB25JQPE3F07QWFonhfL0Sf4s0TzLikysqR1eqc5kCBxfZVr8Jk+O/Td/gNVlDjpw9dGKyLzhK/dwUnjgSPTkus4iuETm4Ls79NFs8XAd2XzCxr47TV9kTORMkTA66KBBExQdnHwNLGhdDvTHZpBcgAjQnSuvHIZSMeqpx9lfBOCx/vDVtD2Sn3jd277oGDW3hpzpjs7tRiaMoXrFqSrl0mPhfVRhpa18JX/Dol32xvLHWgFbmMexMOAhgDF1MQoLmOw0XqPDUg3CeEeU1m256L1IFRk4s9ITV/pHPHjVtnRZKudmQhKJ58yICUBzW+feO/5E3qcKROVGi3PrTGiwqZCAAMmJy2g3P+DPYUps9lwSP2qna7+W/cgIyiPszjvFZcbDLIDwR7X3Y1tHRIhSRiHjIortN81fJmGwdaVBU8rymSJfbP8ar6Yq+66ii7c0/nHR/MAwTdcaZU7O8A/D1LLNvRHofAP1OthJRdC57cFWYpYVRmpv5I6Z25LKypds6oXoZYVX5h1DwNnSzthlC2zWGS4tDuOxyP9txZJHgDwcnzdZIHogiRfMFRZ4xi66+J0UCHOLGEHAXKU6lYuv+k14J9e4FIjUYjsQti0pq5374pgOB8mNaytyZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1A2QkpDU1Y3dmxtWXZlNjhhelFJSThZcEJDTURscmxDbFd5S0RMMjhOYlBC?=
 =?utf-8?B?d3hTLzFlMXkrcjBlOWp0RS9TVUhUVUpvZmt4aS9oTU1EUmxUcFBiUmx4eFZt?=
 =?utf-8?B?dWFiblRCb014dUlleEpTVWYxdkMvUmc4TzVXSUsrNFBBa3hURjZPcyszY2pB?=
 =?utf-8?B?WGorWEVOanFTWklQV0F1Yy9BRFFLbGloakVmSkVPdlduZGM2MW1lSk01d3M0?=
 =?utf-8?B?Qk0vT1I2UmwxL0tsOEx1RUxSdTFVVSttQ1cvQmtSb01YT2VTZkJ3M2xUdFhR?=
 =?utf-8?B?MmdLWVVIdG9sVGc2UitQMHQ4UHNuaVpUV1pyeWwxbkxRbmF6Y1BIWjdVekpp?=
 =?utf-8?B?MTJIZ09QcURRY0IrQUpLdHl2c1BKQ25uR20xbzJqbWZrYWRJcDZSMldEZHM3?=
 =?utf-8?B?K01aMGJreW5Pa2x5aE9peTBGQjJrQzNhajNhdG1PelJiOWh5M05tSGtjbDJF?=
 =?utf-8?B?U1pqK0xkbS96clE3NUthR0V6MmU5WFpZS05DMCtJRjhrcHJKYUFnWHJxSkxG?=
 =?utf-8?B?NlFoRHlKM0RmV2VpelVLOGxqemtrTlRCS1NZTFJWOVRteFJMV1JOYTNURlRQ?=
 =?utf-8?B?Yk9lbnFaUWV6ZEVEQjZZbDRDT2hXLzR4TUdaNTJ0bnhVbjhxNm9Da2xnZmNw?=
 =?utf-8?B?L044L3ZOUmFkWmgyQnNzaURjWDlnNzl4MHRuRmZGQ3VaSjJkZzhKOU1WSnor?=
 =?utf-8?B?KzdUaU1tMWFwS2xQbERXVkN1QkdOaWxId2hhbnBtNG5sWnRXRU9zZUtidjhk?=
 =?utf-8?B?c1Z4bHozU2thM1duemdmN1ZwZFM1bmEwaEMwckFJdkVEeW1heEdFZUh0QXpq?=
 =?utf-8?B?WGxUd25PcGxYS3ZFQ0lNZFhkUlpEaWhRNFdvYzA1UGpXVmx2c01NRjZ1dHE2?=
 =?utf-8?B?RXc3eUxTc3ZaSjdWL2JDYjlGd3Z6czVWa0hWQmRVcDZTdTNZMFhGdlorTjdX?=
 =?utf-8?B?VlJoeHg3MUU5elJ3QmtMMlJDdGxjQ1hJdXhmVUhaZlI4YjB5OG53R1N1OTRt?=
 =?utf-8?B?aWdQVy9lM1EwT2NncFc1eERSY3UvMGhiYWg5SGZSWExuaUg2QlJ5dEsreFpi?=
 =?utf-8?B?dUoyZEVqeWN1YmNERWVicnRkZ1U5TFNKQ01uVkx5eTgybTFnQ3pESkVzZnY1?=
 =?utf-8?B?aXpySUdXRDliY2oxMWhQeUVnUzE1NzRyV05EdzdkcHJkQkN2NWRoWkRPS1Fw?=
 =?utf-8?B?TW44UXVDNVFVVEtsbE5XNHo0dVB5b0pJRzhUZDM3cGJpMDcrQms2ZWVXKzBK?=
 =?utf-8?B?QUdiQk9xT3I0YmNEbUdBYUxrd1diclBndHFDVWhzbkUvUnNxUDIxcHUxN0VJ?=
 =?utf-8?B?Y3FnQkJpVU1xUjYzVWV6R05yUmxYUFlVZjBRN1k3djdzMHArcjNibDZQUnZU?=
 =?utf-8?B?TkIvZjJnb0JWNjR2NWl4N01nSm0vTUF4dGNRdThnekRLaTZpS3VkTC91UElN?=
 =?utf-8?B?M1lBd1VtbEFtbGRLQWJHL25LdElaNFJoT1BZaVpXK2JMaG9iSjJ1WXZjdnIx?=
 =?utf-8?B?bVNUL0JOUXA0UDd4dkI1WnRoc2o5KzR4VFFOaVlBQ3NyVW93RTNUekxQZFg3?=
 =?utf-8?B?NnQ2cTd4K1V3emJBSGNGRCtueVlLblNwTnI2VkpVT0RJemJXOFlNaGIyODBD?=
 =?utf-8?B?YzBqZHpybXhISU9HTGNOcklOcUdOOGZpWWJVZTRaaFYwbUZqOEJNSU5QOTE0?=
 =?utf-8?B?VjBvMksrdGRJL2VXbFFDYjRkODZ3RnlGTWFFQkdyc256c3dBQ2RWTXkxZlBI?=
 =?utf-8?B?RktCZTNLS2hxSjIyOW5PdngrbzM1aDVPMGZYczBUeHNSK0VRMzc1M1ZYemdV?=
 =?utf-8?B?cVREM2ZSdVJrdjg2dEhxanNUSElLcWxxNExGMHNUY242SmtNb2V6OE5Ib0oz?=
 =?utf-8?B?QnY4RVdMM1RBSk9mK2g1UlRDR3h4RGUxT3B3bUphQmxuVlRDQnIrbzVRWWJo?=
 =?utf-8?B?OEJLSUwrN2krYnNRekkxNGROMmlBWmtiWFRZV3Z4bVRBU2draU9ydk5XMTk3?=
 =?utf-8?B?ZlJQcTNwSkNGOG5raFZLT0dDRGs2UXliaFBUendPTDkwc2czelp0a3k2MFJn?=
 =?utf-8?B?Y0dhYlZCNmYrRnU5RHZHcUpOREx1TVZBU3E3NE1OQ1RneWVCRFk0dW1iRzZl?=
 =?utf-8?B?M3ZiRkpicjk2U1NDQVd3bUFjRHJDbEg3anlzRi9PeU5KTXI4SnNid1R4RmUv?=
 =?utf-8?B?SHNzbEd6T2dXQUFpbDJZS3N6U0pQYUFYYjF6ZGpkbG9PcXVDcjNyS04yR2Zi?=
 =?utf-8?B?dzE4bmlTdm5MNnl4eE1lUDI2OUVudFFSMGlDMVV4WlFKZGQ0WDMyNis1c3BP?=
 =?utf-8?B?L1NUdUhGTG5pYjBKZXdnZ1hhOEhOWkxRK0Jsa01Td0dXNDRKUUVMSG96K0hZ?=
 =?utf-8?Q?tWabwHlPb9SRlaMk=3D?=
X-Exchange-RoutingPolicyChecked: VDlzhwsD/UrxFvF0KJpScrg+ynVyAF1Orhn+1GJ0Ix15lCThpxZ9TQT42YMSU3HOrNn9R2Y8luYlLhFT7AekIzTb8kM4ulC+tYopSyWD7Wk7/1C7sJoRydSunJePJsw2VRwGMcte5VVC8WupQWpCLYJXswwavdTKP4boDTtjY6KKdbnRdKQG0o/QoWHln6g7qR7VMkfoTLUaXZeJbVkXqyMvfdskSDJGFgo7rNnfJLcdcJnd1DOlpKKlrkj/CLxNPj4n+t9o4Bn8A4btvWFIB2tcn5RDBnDQfr3Nfv9bSDbLN0fWD79dbsaEDNM1tfKnB0xEBA+enyLwwI/Dcd7LOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d35ccbb8-a1bd-46f3-c3e5-08df2f5c761b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 10:17:07.6046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2QjN6M0sFz/w/sUtJTQ5JL4pozuwvkGA5yZAq3RJ11X8t+W/vPJP7vBI5/K3pin3Gup73NxhUml9sXp9TlkFpo/Dwijyx5DghSs9rpp8ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7847
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/2026 12:15 PM, Anatoly Burakov wrote:
> The generic flow layer now assigns the parsed rule to `flow->rule`
> after successful creation. Engine create callbacks no longer use the
> flow handle, and all four implementations mark it as unused.
> 
> Remove the parameter from the callback type, declarations,
> implementations and generic invocation.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Missed a

Suggested-by: Bruce Richardson <bruce.richardson@intel.com>

-- 
Thanks,
Anatoly
