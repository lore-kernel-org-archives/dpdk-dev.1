Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEA3CD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 16:26:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C0774027C;
	Thu,  7 May 2026 18:26:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D37054026A
 for <dev@dpdk.org>; Thu,  7 May 2026 18:26:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778171215; x=1809707215;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=eBcioEYfN+/QYN8m8ulEyq1iHUxnMdXQ5jDhyM6a78Y=;
 b=QHNo6qZzVsc/AFpo2GIqsx5Ko4BpsGdF/GAh1csIRmk0BdJWtLzsYZM5
 n4Ljdlh1mxdcpqtoprUGqFRMHkD2Z1Mcw8Zqvx1BlFZEUX3goaSby5mZ0
 ZNlpebbgk8Z7EQVHooznU7KcSZHpdqQHcqsNM8VlT9hFvL7KeLVHk4f4t
 osD0FlOaklXUWGy8BFvTwi3CqVbLhIG2EdamX+kSqGSS2dl2ijhCRrhj5
 hT7rTtKOrzVxDN5rK73Q0UtxzCMWsuRrMw6ruJgrswX7h3hx8URLGgCJ0
 gw+k7Ax5OX7DrQN0/AZtsOi4s5pJOHfbPF8P1DqW+mg53cAdEVBAMhiel A==;
X-CSE-ConnectionGUID: pBbF/miwQQyQcUCFnLVEqA==
X-CSE-MsgGUID: m+iGb2YPQVG/bILO6hDXBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="78848956"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="78848956"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 09:26:54 -0700
X-CSE-ConnectionGUID: nmvvbtbNS6WN6jpa6hulPw==
X-CSE-MsgGUID: cP9rgy4oQa+0W6hpP7s9fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="233847127"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 09:26:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 09:26:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 09:26:53 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 09:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqPS/RXJkzbZ52fp/DK0rxiBnUTNzS0prZtvhPY9hQ4hNxgXhBO1LGLNlyifptm4hXGO43QN/CwbC2g8CuHonQuwYJjaCAJ0qC+xQDV9kz1swq+Uxj9tb8CJP43jjWNxBNETe8Zyo7WLX2z8UH2vJZZy0s1XjqzoLrT8FO9yJWnWIFLvVVyO2OKy/v9W4TYfl+7DwGHppsB3imP+kmurqFiNB9y0vza2V4r2mI6JmOGYlbV+ziARpmiqAS4vzGZ+NkgJDb8qRjJKypuI307hBwVQGxhn51QwZwNsAWdj+5anNMMz+4vz9/6lUq4v+9K4FYC5xCWwuPxJdp2v0ACf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9TKIjUAQ29oxb7h6vQCPE/9PsH/uOFPHilKIcn9uB4=;
 b=HNXM2s6P/OfSIgRuAzZKSOAdfoQBM+8O1KwL0uU7WkMGG9nxL8vKrcSUmrGltv4n5KCmStACBjOHrR0ld9NnZTSFlqlXUTLJQsfWEqz6MIHpAQHEmWuXWduJEraMKTwvuJevDVGrzzpFdXBLO7U7xhfJLVxwdMo878fboG0hdU6csZWubt/SEUicP+LZWgCSUjXIqyET0Cnea7QphkorsH87Mkw+hG2/id1/BN6OKM0uXZ5hVg866efXIFFxsdPgBxrQk3hNQFwA5kGL1pb9lwQ5ABU13Gpiny1fYlxZSnWXk2Rv9FzCw+3+nCYPCFFd6t9Qrqdzm8YgNpNSRKFdcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 16:26:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Thu, 7 May 2026
 16:26:49 +0000
Date: Thu, 7 May 2026 17:26:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC v2 0/4] flow_compile: textual flow rule compiler
Message-ID: <afy9RC1UUlGlqp2G@bricha3-mobl1.ger.corp.intel.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260507001501.608724-1-stephen@networkplumber.org>
 <afxJCBfkbui5clep@bricha3-mobl1.ger.corp.intel.com>
 <20260507090923.0f8a620f@phoenix.local>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507090923.0f8a620f@phoenix.local>
X-ClientProxiedBy: DU7P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2f712f-16e6-4911-35a5-08deac55704a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Any7IecKxiVtkBwXFFq2com0jQ++GH/arotw2zxb1tlI3xc3D1WT1hXt8EEiYwXX925mh8vIr2O0pTyXnMVr2Z/LpQBOcbndqWi2Jk1YuZKCZcKN/mNwl/8zhkruntpheY7O/gYZ616nMgDai7IGxD7APaSB8DX/7BCI56EuH8EeK5gL9w80D0JOtTnk8U0SbMoUpog6sPqa3Rjwxk5NU5swKmn/OQHZO75nkvmyiLeyAb5kM6TSFH1SfoBCVo8mVSW4EEPNIj1UfQZQBNbwBfUHlKqSpJI2F8nqjmYMrOlCxYyX/qsIcizE3vQAZqLDH1H6IXTwtizVE4X5ahKPuqWmeXTRpozr7O1Q/c+SCoIgte0WM1xrwElMjSlVKP6V2y9kw1dFVSc8Yyc9vKma7034OktomClEcQRda1/N7RE44HQUXmn5vRiG+sPbXZZST9YGgLjoDeVdlas+BbywMlT2s5NW2qBN+uAMuy+Slq0fHZhls+t7tnatyE/ZavNRDLR/dtngslw96lTf0mK8mP3s/gD7niIxYXTMB4SKv6XozrMiKoMO6/bc3d+G31sV8ozH2lgkqx1rdN1A6mYkI0L7F1yYBB34zA8ruEo2/diF8loTsOEydEFYtnMMpbFsrRznWN7yBZio+5vB9P2rAMy19CGOtSNhGp4DcoXNI4lHN9QE5rygywtaA6E0oj+f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEJkU2YrM1FOb0VRdmlDRGo2ZkhBM1E1Y0VqTHNQQnpaR2xWOUEvUVNEVnFT?=
 =?utf-8?B?M0UxNHI1UmsrdFJ1b2dsaEJRbk9IVnZkSkZ2cG13bHlKNENXWkdJZ0ZoUUJ3?=
 =?utf-8?B?YitiUk40cDZsb3ZIZ2lQcEliS3lMcGFDcmdmNlVucGx3RkYya1VEaXZmOVRS?=
 =?utf-8?B?WGxtajVmSUpvQ2E3VzVDcmJ3RGtUQzQyOElsR3g1c2x3R3ZrdHRRZ3orQzFT?=
 =?utf-8?B?alNIWjNjUXVTNDNpdnJ2cW5EeVY1TEJmSDhsSEQ4MzVJWThIVDRZai9iS2to?=
 =?utf-8?B?aE5GcGVOc2RLZHFTcTY3WTErNmp4VHpHTVBsOXUzK1pTNWF1Z1Vxb1JXY0NS?=
 =?utf-8?B?VzA2TExGNDlpcGNSS0tmcXRlQzMwUHpGQU1pUktOTmhhRmgzcGNseHZneHhr?=
 =?utf-8?B?aGNlM1lZUkxwWVYzR0NvYkw1YTNHSThoN0c5RS9wL2ozckFXUW9aeWoxTllO?=
 =?utf-8?B?QUxhOVBRaVhDWDJaeFk3VnJTdHZBL2JQRG1rRHF4dUI4U041ek1wSkREcW1z?=
 =?utf-8?B?VE5iYjVSZStmUDNNVUpZejhNY0poM1pUODJNOFVLUWQrQ0d1QU1pcEJvVERw?=
 =?utf-8?B?TUs1TXFYb3hTRGpwVGtTMWVrMm9PVkx6cnJrK3JxSlVhc1c3SHBDbmM1Q2hM?=
 =?utf-8?B?aFRlS05ZQVd0QS8zalpMYTdzcVZVK0ljUjU1UnllcWtnTDRQVUNodmtvb0lR?=
 =?utf-8?B?WW4zZ2NNZkI5aU9Kb3R3bE4rV2tyRTFZTWgwL3lqTkxDb3l5U1pKVDArQTVh?=
 =?utf-8?B?UWdDQXVrT3FpU0tSa3dXaFd4ODVRcTY1VkVINHJ4bkc1UGkwMWp1ZTZOZThU?=
 =?utf-8?B?b3cremFHWEdzMk5kS3FzK0RycHcxUURJVFlQaW9uc0ZZRmxjZzlWKy91RGxX?=
 =?utf-8?B?Um5xYi9lYlJSRzJTd010bHIwcnh4d2dKZHpOSVJJUSt1UmFtMDh4dTVEVTlt?=
 =?utf-8?B?K0N2KzNnWmc3N2paMUJkczhYdmYraEM3Q1puWUlkVHBKVStONkJWa2ZtSldO?=
 =?utf-8?B?WjhoZGdpUWJtbG81WXhFUWVlS2hUN3luMEEyYjRJOXZ2Zy9ialdMbU1WbThi?=
 =?utf-8?B?Y0FWOUZJWGFlK2Z3RVlvOWZ6ZUFvcnBreFp3SEU3ZTZ2WWpTTlNVTnlhS1Fu?=
 =?utf-8?B?aUMzTmcyTkd4UFhLRWZhNU9KKzlJbCt6OU8zdURReDZXTDJyZVQ2TGtHdmMx?=
 =?utf-8?B?WEIrckpPUkNYWGh1cjZmdUNqOUY3TlFuYVFZM2J6YXpuYURyVFBETUhndjRY?=
 =?utf-8?B?SjgvRDVzUGVMNHpNbnZkS1RzNVRsNnZRWDhKQVpRVVhMem80MG0rSENUaFEr?=
 =?utf-8?B?QVhzdkR3Rm1KTlNLa2FuTWFhL0JlK1VVYXBWcXpkNTk2SnExNTlPUXdZdFhM?=
 =?utf-8?B?Qi9rZi9CdzhTaG15cDlZQmdmSUZES1h1ZmsxZmp3OGFaenZ3U3VwTU9XMWhI?=
 =?utf-8?B?SXJzTmdiK1U0TUNMcDdGYnpOZFZudGgzcEk3UGQ1VkRoU1JRNkxBZlVxTFl1?=
 =?utf-8?B?UU5sOUx2MmZSamxMUmYvK0oyaGhlT2hldFN1VTEvM1laYW90VFRKVXdiNXBj?=
 =?utf-8?B?RW1zZ3lNNGo1UklnQzZrWXVUc1pxSXdBVHMyU3RlT0syQ1NWV0xpWnhYNFJp?=
 =?utf-8?B?NWc4NVZkeGpHVUcvRUppSFFndVZaanYwcnJmd1ZHRUJ5bFZQSW5NK2UrbWMv?=
 =?utf-8?B?Z3lndDFyWDlaZDljOWh1dmcvWEgwUnlxOFU2c0xqSWM0RlhwYU4wdTBqR0ND?=
 =?utf-8?B?MGNISTZFemlMVGhNQ3R1TUxjZS9xbTFKZXE3SFdTeGY2cGhNOWplTFp4aFAx?=
 =?utf-8?B?cDU0RWsvcGFtenl4N2JCMjcwSTh2U2JFanVRelNUNzJ4UzEzeFBTTzluN2xr?=
 =?utf-8?B?VHJDWDdJZVl3Um9PSWhPQ1V6dVpsT3ZVV3lZd0h0a0pOZTVsYmdYVUo2dTJE?=
 =?utf-8?B?SmUxUkV5VDQ3SGg5R2dIbE5HR3pjTGRVS0d3N3c2bHZtUXA2cWdYeGlxbFE5?=
 =?utf-8?B?Zml3RXZTRmZVRWNUbFhYNjZobUViSmhCS2pLMlVVVVVjL0Y3bVYrRElmcko5?=
 =?utf-8?B?d2JhOUw4dzFkcXoyUGdTMjZ5OUp6T0lDdzZIWGpuM2NZYWhqclhqQUQybitP?=
 =?utf-8?B?YUtMd1U3Q1ZHL3ZpM0FxUS82MytwaFFidEtIZ1lrYmk2TitBdWxVQ25zL1Yz?=
 =?utf-8?B?QkNDdFlKdkpuWVhldG1vYStjUFNlcWZHL0Z4VjJWbkovU2Z0QVRDdjlXWXdk?=
 =?utf-8?B?bWM1OUhzNWlQR0pScWVneXVKMVJsSTNGVlg3dnhtOG5hNE9MbVFsWFFOaGRv?=
 =?utf-8?B?S2hQRGw2WDRzQTVNVXNhT1ZEWTRYMG5GOTlPUTlzS1ZVMnlQRmVkWEFuOWUx?=
 =?utf-8?Q?JOegBcNsSe/ZeGp4=3D?=
X-Exchange-RoutingPolicyChecked: CCCkktneRLf4Wz2BmVh2PQ3gKBlt7RXUT6Dd5U7oPc/21EGPA6VHwTAbozuob0uqPjfMjJ9MyDGusiL7kRF/lXwhZMacat21AwQyXJyfNhAcRd8qu9YXPOd+zy0SMCaCkbRfBUf0Dy0akJJ5Y/pwPy3kT+bNr3lxB4B9vcoCJqyjym2avn62gASBpRZs+TABF9PHfZ8nwQ4n4uQD9dNSOqZu0Au54MCnwh9wM3sf1hdnZdSw8j0tRHzDalq/OQK+Ab6uuIIo4UwtA/rAVtcn9rncGc5Mxm65cFNO07B/fDfqrXfMnFu/FtGo3dpiN6V+HLXusZsMaXL/t93oJNQZFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2f712f-16e6-4911-35a5-08deac55704a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:26:49.2409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05TywAXPO1v6BjrhPKNpVTPiUCwPPts6qVdi6+WOshsiLQ7paNefTfk95lZP+eyF+7z8mjcYUQU0y/tPLrYjUv8C3IePI0wo//xOMFWn+vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5162
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

On Thu, May 07, 2026 at 09:09:23AM -0700, Stephen Hemminger wrote:
> On Thu, 7 May 2026 09:10:48 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > > 1. API shape.  pcap_compile-style (one string -> opaque object ->
> > >    arrays) versus the three-call attr/pattern/actions form
> > >    Sismis's v12 exposes.  What does your application actually
> > >    want?
> > >   
> > 
> > For this, I wonder if we also could do with a second API for the creation
> > which takes a list of tokens rather than just a single string. Thinking
> > about integration with testpmd, or with apps which already have some
> > commandline interface which produces a list of tokens, having to re-stitch
> > the tokens together into one string seems awkward.
> > 
> > Also, have you already investigated how this might be integrated into
> > testpmd? Do we have the capability to pass multi-token strings via cmdline?
> 
> Lex pass does tokenizing in a way that is different than simple string split.
> Could have a wrapper that takes list of tokens and quotes them back to
> a string.
> 
> For testpmd integration.
>  - the new compiler may intentionally diverge from existing adhoc
>    parsing. The AI code generation already flagged a couple of these
>    and put note in documentation.
> 
>  - testpmd (and probably cmdline) will need ability to not pass unparsed
>    string, may need new cmdline type for "rest of line as string"
> 

Checking with Claude, it seems it's there already:

Multi-string (TOKEN_STRING_MULTI) — reads until cmdline_isendofcommand(), which stops only at \n, \r, \0, or #. This captures the entire remainder of the line including spaces.

>  - AI proposed new syntax:
>     flow compile <port> "quote rule"

I tend to prefer explicit pre-field names in the syntax as a general rule
as it makes it clearer what the numeric values in the command are. So I
suggest e.g.:

"flow_compile port <N> rule: ...."

In the absense of quoting, I think having a ":" at the end of rule helps to
separate the testpmd syntax from the rule syntax.

/Bruce
