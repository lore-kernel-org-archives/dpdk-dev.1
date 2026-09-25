Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBCEC9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 13:13:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C74F432D8;
	Fri, 25 Sep 2026 15:13:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0FCB640294;
 Fri, 25 Sep 2026 15:13:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790342030; x=1821878030;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8SpMyEXF2+hvalWzq76a/rYOwoKMstBlZSEVjB3rI2Y=;
 b=iw3yId+LkEFEonJpIfIdiGv4WSwKoPbxaS7oguruH/f83LoHZK9TJ/1L
 R2hkOvxqIbtFLqexdKrZ9eJgUbHRjmvblIniOVAubYfE7LjQVnpZeJQtC
 AVr09FIOcWtUuUoK7v3sYpDh0KcofzSJbl5NItSuC4DH1WO8pjcujV+pj
 jv7LuVBREGCINQa7HqbanasVAh17/8Ui0u4E0i/p4AXXTakM8EKY7PAPX
 KAUDNBOmUncXLMuXjIQN0JZVj6o8/LOpHh0LYHcNrInS8mzsyxOCiZNfC
 jltMMec3DOFRFZPyr7M6H5ABfnVEeOL14EboUtyKokKe9kVMDWsCO9VSW Q==;
X-CSE-ConnectionGUID: r53Io8fSTrCs6z8m06ZL9g==
X-CSE-MsgGUID: f2bsDV3OSX6AV6f5p7evPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="102487999"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="102487999"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:13:48 -0700
X-CSE-ConnectionGUID: Y7UPDJhETAGKF5o3I5ur1w==
X-CSE-MsgGUID: C5QuyqH9RDGBBuDhcFf3HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="279036714"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:13:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 06:13:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 06:13:48 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 06:13:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI1aJQd/YRPUOUG4W6cU+KeDpJCURrsjWGP1WfiqjPhiEeeyjXjRoAuaJnTCeYaE4nKAtIwbqloOeY6pGZWrHdHtGHxoGgJN2mHsmiy1W1gy4eFoBx/WLK1xGR+2kM+3Tfdqxq9+o16Bhg9b0TXf51UxZCy5wwRR5PWgFrq83z2dTwuYfvkmMcKua/C138/d+7mtKlVdlSlj7Ls5ZFJ4KpwyZYEnldpkjESg9hzpUt7euG9UouniMYxHgowOzDQm3tZ7cWUUDiwYVoaVAfhzPrxKE8/LuogAYi325gBfkgYi+AqE+412ksPsE7YJVOo9PMVPvWQXW0AoA7C4Nk20zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2vBRX+aa85jp5S5qEN5I3gjwBJpSYhr1xXvnLBFe6s=;
 b=hWMS3wXAwFgJbH7Hgup7xdCvh6MOR1hAeQAUsWjwQdj3scTD/zi4iiY0lRr3AkFemOae33w/dg2rMKGTEJjCGgFEVC5c/CVKno3F55LTIWoRjEYWMfEtkEEtHRnk7R/B4bDQx0jWm6/sKRg+WiuFcfLpj+F9WHkA9vZO2D2uuB89I0pdeTODpUZ9Egaf9EfGNiSMXnYJAyRS7CFARU7gV0HHAQM02TqIGSbu6if7WfcCix0pCOmFXIXKcN8DIbB9Z03gcAuYUN+n4HK80IqE1X+dnElyjpXrexzGwNhfxV+QZ9m4spN9rhdzlAeiwfOQpd+ZEGYK0IW9kj2V9neMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA0PR11MB4704.namprd11.prod.outlook.com (2603:10b6:806:9b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:13:45 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 13:13:45 +0000
Date: Fri, 25 Sep 2026 14:13:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix overflow on storing device args
Message-ID: <arZzhGfoAyI8IBSA@bricha3-mobl1.ger.corp.intel.com>
References: <bug-2037-3@https.bugs.dpdk.org>
 <20260914153019.4034539-1-bruce.richardson@intel.com>
 <eb5d85c9-ef87-457f-8966-8b5b7b742636@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eb5d85c9-ef87-457f-8966-8b5b7b742636@intel.com>
X-ClientProxiedBy: DUZPR01CA0219.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::16) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA0PR11MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: 4180e875-c8e6-479b-d678-08df1b06d40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|56012099006|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: ddLkm34jwpQ0opkLQMql6eYY4se5nZp2HYR/IT9JAQ+ttWk3AvC8hFQRqnNY9rbVJZGtUCgOiNk0OSDS8SRSUWXWAtIyaTL6L0Ar7h3SUAZeEUc4fQh//9/ocYVyU2CKKCHcN1wd1dknSP9gMSd9B4CqeYdLixVKgaGbuAWcMtQDHxwngcmiGBj9ewZKv1673Kqu2mS58JrXdV9du96mDLKfa3PEVXnG8wzXxn3sRtvKNVbjnwNkV5PP8SWVk2hn/o3lk9o1CC1k4jWFw+Rk+BB5zUWTTrNqM7wMKyyqoIEBjUOqzS4BxGrrZRtleXNTaWdvyPx0gGJzhmLIQPoAQPH2DKD9Mn6r6aWuhwlBKL3BQkKMUjLYCeaHNlP0TacMGr+Xg3AFUX5j+emdIOCbrKBQJRw9MNQA22TK5bGZpwnZZe6DEESiYH/jQt6+w1hVmV0kucJBkLnbp6VuHV+t4/v5siWXwciieP8xNigcui16YgNYwZA0uElAiGMPQxA4R9h3Kw5FPsYeM6AZgMt8c7SvT+k552D06WDLQeuGe12E7qnHb9JKis8bVoTwQwKj3eOuqFizX8+oQsHaXotPL1WPrGk1q0Vyn0L9t45EkxR8IdoKHMjPxdqD6rjWwkJgZzu3OpUoI50NeTAHKoLtwFHMe6zdUiidy4w4BgtiGck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(56012099006)(11063799006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ad1cEHrEfoceDG8gHiepZfhsGEa95gRzWaFVw96yPfhsvtWQZgwgG55UVuQC?=
 =?us-ascii?Q?7nhQe1LCOHBjIpXcJPOjkDoNFoWxmXyXD7Fadq19nD5IugQaGg5337u9Xv+z?=
 =?us-ascii?Q?kncRgOT5fYYB3HCs0smAYRoWUDct6EsmnqoQMRfbx8OVGcOSCw3HRC5SA0qC?=
 =?us-ascii?Q?s4shd3LWvUL+PqdiWP+fJC8KXzVlWLNKXjVmmXYaXritOCL8A3z286ZSZVgJ?=
 =?us-ascii?Q?GhvUStXcCJqMILQUxuBErPy9wVWGe+N/XsidDmiLuphUTAa2jCAEMm5ulDy8?=
 =?us-ascii?Q?RQnwDtc666FUldVUSa/+qJv9C7Jk4cMTvtOExPIEdo15iauMkbxnCfGayQ8x?=
 =?us-ascii?Q?LYb4DkDLZSr73NpMWRshWouYk519DpbBtT78F3+qDhGHPci6GIWyep2cwzxf?=
 =?us-ascii?Q?diC/ESP5jP0m79rBalXZ7Egiy0+i01d8HFKer3tnsf+zRWK1RvVRqPmWtuE/?=
 =?us-ascii?Q?d1uEb3tn9crtpDb/OlKNonYgf4H998Fgpo00jkY1bmZDv52Nn6OiCcAFqyDU?=
 =?us-ascii?Q?PXBGrIB64GXaX6tucyLLiSGRt/2nC26tm/zyg+/EDTvT3kjA14njuOsgZa1i?=
 =?us-ascii?Q?m9m4xUh8P6r68h1w0dboTmZQCuOjH7yvFDhIFOw2NUJOaQ8v9LzWmiJW+zjx?=
 =?us-ascii?Q?ROnqs+V8c1l1cFVW80UMF3Zl1Pi8S+vG7/pdQNvVDYsTLmFInqut9AGaeM85?=
 =?us-ascii?Q?7F9zqg89l+UhYRsX/mHRaCQfLVqPHPfuTbtMDp7ESyeQhRsQln6tUOQH7xOQ?=
 =?us-ascii?Q?BI4U8UeUIrbBbf+rKjd3YR4EuH6/SqV+ve1Re3UKYnb7lifnhU5ZHyoUL+7D?=
 =?us-ascii?Q?McnLrbcnEZu5gjOwKHSMlLwpH62ao4f4na6Cd8i4fyzQgLunAD0Whh09BlGz?=
 =?us-ascii?Q?aYXXzJWSBEPhTD4gNEB5MPVQ0syp6GGWrL8FRSMuHFvv8xY2pFhHOSPBKocE?=
 =?us-ascii?Q?eJdhahC7B/RZSBQxMFIf+uHYTgmx0BmvY+Onjpk1CYt+Gvu41fdJBsLKn3/m?=
 =?us-ascii?Q?+yQ+rzns2YcyhTkOFjtABVr9EKJzDoFiie0UrJpe0AtFVXGffkpna6qHs+XV?=
 =?us-ascii?Q?oHL+FZEchMdU6doY9EhOX9A42zBQdBGzkpuBw03DderswLmls7ytT0+M6cwI?=
 =?us-ascii?Q?GNGmuqoVP3VZxdmaWGN9BWIo8JUlFSKlvQ8B30Uymm8st+wDwqBWgQNkrMJf?=
 =?us-ascii?Q?d5Yz8wvRErQksWSzIBJ8IOzuH283N1fIfnMUdUbFSAD6PcNdCDeq7Vz/ecep?=
 =?us-ascii?Q?b54ZL2MinOscKMcbcRr/HeNXOyqYKLMyzWdIB485gmHMvqnfapuJjFKF/LrR?=
 =?us-ascii?Q?gUugjpvsIxNHsI1OQ7jW1RF4q7Xddqv1/01AQu4DiKq88xtyaW5+a7Zk1uTb?=
 =?us-ascii?Q?yL20jYddKCyedPlePi3m6TNiFskm2oj7VyZJqxrTdl8leIHXfBoiZFQlIRsr?=
 =?us-ascii?Q?0pSldoZK7dYBGpyFDWlzFNa6md8NwXxURNlZszw4r0bOyoKW0p4Bx9kfg19W?=
 =?us-ascii?Q?HSGVGdwQeyVFKwgvRmRd7k1atjLXF4t/Nn5za/GclQ03rmwcvHV/DrHgw1Ez?=
 =?us-ascii?Q?igaW+ow09P2dtqvRebEWNgEpVEMTSnER6gRXWA5wkt9/Fo2XHoK/GEK3kZIx?=
 =?us-ascii?Q?guoLSGFms+L0hA1QCUbuN6/ShzayVXeTatEFZKKEAGkI735w7Ql3QxnlpH91?=
 =?us-ascii?Q?JKNz8dj3FcZLkagC4weynDr5VO4RuQA5LepVM096DKh7qRb9ktRd0tVenpjK?=
 =?us-ascii?Q?k2K8GO+FFDBUzGL9E+VfydX5W4lG7ds=3D?=
X-Exchange-RoutingPolicyChecked: G+Su+1D/uZVkT4f06yqwuMw181dsoArlAGqjrZ4NJnQdP36NooqzrJDbVYgf+/t/I2yQOSWadej9QW8ACkH8W2nPLIPe8T52U95+g/s8UL/jHaUJqUK12rR9h5CRuRiJfhqREKVyA301+kCzWkghwNgsxDvgRtEP+J3UAxU+KVSQcflkWCFPX2QREAKaTlE3tWdZQ1bGj+6igM7yMFvhRJoaujRRNBuImlCYZB0hOfb78T7Q0zJPVWzeSbACc4prNnzQp1l5wAGBItRY2SBJbhPe5OojQyQ9NT14b6TgIlVDDzc5DBW+qdDnrFZ+Q2pBedbHZTex0dw17dznt5hjjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4180e875-c8e6-479b-d678-08df1b06d40b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:13:45.3785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WBlQenwXZeeHzz/ZDn+chW9bdCMGouTS7Urp+OKkpaqQXlODrbLMUOD5mdGKKuwkK+QsSv4RmqH2YXusw/bOVX8Mxit4KMovabnewfUj8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4704
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

On Fri, Sep 25, 2026 at 11:36:51AM +0200, Burakov, Anatoly wrote:
> On 9/14/2026 5:30 PM, Bruce Richardson wrote:
> > Boolean device args to ice driver are sometimes stored as an int and
> > sometimes as a uint8_t. The parse bool function stores them as an int,
> > leading to overflow when storing a uint8_t value.
> > 
> > Fix all these by standardizing on "bool" type, both for the arg values
> > in the structure and inside the parsing function.
> > 
> > Bugzilla ID: 2037
> > Fixes: 603beeb970b5 ("net/ice: add safe mode devarg")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> > Note: this fix is superceded by the kvargs numeric args patchset [1].
> > However, that patchset relies on new kvargs features unlikely to be
> > backported, so this standalone fix is useful for backporting or if the
> > whole other set doesn't make the 26.11 release.
> > 
> > [1] https://patches.dpdk.org/project/dpdk/list/?series=39247
> > ---
> 
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
>
Applied to dpdk-next-net-intel

/Bruce 
