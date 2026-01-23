Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AE3D74EEC
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 15:43:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 607F4402E5;
	Fri, 23 Jan 2026 16:43:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 88A2C402D5;
 Fri, 23 Jan 2026 16:43:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769183019; x=1800719019;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=hHlcjLPSBku71h/0Cg8uOUdXCIXdDyap808f+mCaBQA=;
 b=Knp1kpIaX1k97GazXbj/PX22k3tkMBF8fryjm4mqelMHaHGz1KU717PQ
 QBBkONK56VibiEIV2ENizjFsTNyjYPUrnBnaBOrnZc6YP6sFXTe2XXme1
 nslZlCzsZhjTahihmuzZdZ5Koxr287hwYOZHnMEgF9KO7/Ptng4Ek6C3p
 i5DE1aUDFsTnnpPg8p33I6iL4Zrk/WAW9jv29XLIsK+FbUgTX3lktbr2a
 bqNWR0hLMZiSIHvt0POnmtJjsWzAOp/3HN2AI8BMHlholvrxgps5D7NJy
 eP9aeCVNIlx/TbLqF5pkl7o21Cs50FBdiNkQ4WcZSDn6vKNba1S0T/SZn g==;
X-CSE-ConnectionGUID: bSmWaUurQYezvJ4XH8IqrQ==
X-CSE-MsgGUID: qIPb+26nQzKpThr1kJjagA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="69634712"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="69634712"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 07:43:37 -0800
X-CSE-ConnectionGUID: 7wqPWapJSU2vN1IBjHR+7w==
X-CSE-MsgGUID: pDFCOEHVRFiA3EVXDBiHbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="206659141"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 07:43:37 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 07:43:36 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 07:43:36 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 07:43:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmfMk3KLZKkXUXnMLtRoVFzGeAVDH88ceKw1scMaXwYczA7Z7ba4443EI7PAk6lprevo66W7YjQ3S3gpF+F2fvXgXl9mPxbaQA54GHP8rvy9I2Q04TVmr3MMukGJjoykZOxvYRtku9yS8nWjvRZ07Hfj7lxIqzW04wIc0BU+QV2VAWmFr4uVkR11pQPcNBskbzlynYlKvPyUyXk07uZ4dFw5OHPZZEazD6KuQUe4G5XXAjD42Z4raE1p3Tto4g3vPGALSRfMgoWo/f7v4UcwdzPy4EUUfasR21WTDno4zJM5lAamByHIAgT81xiVrjw5YYQ7UmrOZJHy20657l5I/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLG8CPOyd820lW7hF0dRWKphgaRWLitxQyqIOe56uXc=;
 b=VEk/QstVppr8lBPRYOmOliB1JvBsX1JuQHOY6Jq+haddOxXKjilIZJMxaSvDaI0hbqQdWovxzCF7RrDZSRacXJWqYSJt8sfh1EwU7GwwwvvKXksc9zQizRBA04DUp+gPsuGoqkyyrfxqWvQG6IwSN2IsZVjKmon6Wdsf16Qij9TfLSwiEmqpMX3cHgEi2AHB8qiennIum32HJryTp3W/ywNIME1fM0eihO/Z87vf73HzD3ACR+X+IE9Zkn/8REqA6p4nfOYCUGMWM3+7Srvn1yOdUXNxN8Pt2w6umeJx2EzUgHID8yl3JEbooIhiJvCDXk7q5daCdo9Nh5AsLesRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB9534.namprd11.prod.outlook.com (2603:10b6:510:39f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 15:43:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 15:43:34 +0000
Date: Fri, 23 Jan 2026 15:43:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Patrick Robb <probb@iol.unh.edu>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>, <ci@dpdk.org>, 
 Thomas Monjalon <thomas@monjalon.net>, Aaron Conole <aconole@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>, Timothy Redaelli
 <tredaelli@redhat.com>, Matthew Labrecque <mlabrecque@iol.unh.edu>
Subject: Re: [PATCH] build: bump meson version to remove warnings
Message-ID: <aXOXIJerY0lZz9VA@bricha3-mobl1.ger.corp.intel.com>
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
 <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yEy9Oz3u0ZqyA4RHQPUjmvEFSLH1cAnfMZccehd0+Z5w@mail.gmail.com>
 <CAJvnSUC3ze51WFHx=cRMGKezrwXvo7fCXH8o64qJsbWf9SXsZg@mail.gmail.com>
 <aXM5LAcV6EC6L9VS@bricha3-mobl1.ger.corp.intel.com>
 <CAJvnSUCd3MpiHbTuv17bXdQK+rfeXwiacW3=sJqpJgMxO3YkFQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJvnSUCd3MpiHbTuv17bXdQK+rfeXwiacW3=sJqpJgMxO3YkFQ@mail.gmail.com>
X-ClientProxiedBy: DU7P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: c12a9ea0-a4ae-45d0-b45c-08de5a962a7d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjBDUUhVVzhOb0xqOEIrdEQ2WTBXVUh6Ym0xYmM0bXRTZEFNbTBKNDZ6NVRq?=
 =?utf-8?B?d3VRNytxU1hSRGNvUWlxbWFSdWJ6QnV6ZTNlUHhoVGxkSlNjOCtZMHZHbFNK?=
 =?utf-8?B?TGxJK01yQkJ1OEpGTkxua3FDQlJ0c0c5U0xxVEFVK2dUZkNuSzZXMU9yZFdy?=
 =?utf-8?B?T1dUSW1idktNV1pQenMwR05QWHhyU1dFMzgyNkxaVFJzOFE2WXF2aVp1Z3ZD?=
 =?utf-8?B?cEtYZEQxNGtMcytOL3h5VFJ3Qit5QklZTlJiV1gyWFMyaGhpOFhCRlBYTk9E?=
 =?utf-8?B?SGJoQklWMXJxMGFkR2dyZFExbGJDeUVHdXUySEFaWEdEQllJNDJtWnlhWmQ3?=
 =?utf-8?B?ZTJzbDlBMGNyU1J2SnFBUU01cFNlUTRaZDhrbGJsamhoK0hlYWdvWHpPaDht?=
 =?utf-8?B?Z1l4dEJQajNBODVYT2lvL29tYnVLUG04b2JJeXdxdG9ZZjFOcTJlVjlsem5W?=
 =?utf-8?B?ZWZwbmNrbjNEakpYR1ZtbUM1ekw2NWtybEdVRU9uQjc3djVZSTJUdHliUDE3?=
 =?utf-8?B?NDFhTjhsWXFjTnJRbThhcVRwTUNPY0FEVXIwdkl4RWFjTXZQdGtid0RsZDht?=
 =?utf-8?B?a1IzQUtyL1BGVk84a2NoQTBDRU5PL2p0M1NzN20wT2p3SENiajc3SzMreXpK?=
 =?utf-8?B?QlZQUjVJaithNTgxOHMxdFR3L3VCSGhSOHhIZUpaSUR0eEwwTWYvd3p3QkNJ?=
 =?utf-8?B?ZXI5UlpEcDc0Wjdlb0FZLzk1bHNsdFk4SDFES1FJdDh6QkpRREkzY0c4cDhk?=
 =?utf-8?B?dGR3d2VMVUlOaHZyTmk4ajJvUW1BQjVFV0VHWU9GNUNvMC9XVDJRS1pHZk5u?=
 =?utf-8?B?akRYL0REck5WNGgyeXRhQVZnekhNblhsdHpEemFUL3BndE11aVhmektNdVMy?=
 =?utf-8?B?K3JxcytuL3pLWWtmQXVnbUJ2Q0VHVENxME1kSU5rT0V6b2FDT3lONFFibXEx?=
 =?utf-8?B?VG83cElEOHgvRkk3dFRBVHM1Zmg4b3g1T0lmWXptcTlsMkxSZ1huMzV2R3A0?=
 =?utf-8?B?MGdtWEFTVlUyTU0wei9FaEdRY1hOZjEzeWtiSlFCWWJLOEUrNjgxODdKSXZ1?=
 =?utf-8?B?Mk5xSW9oTHRJTkxSU3c3dklOTjF1RnBFc0tab0dmM09wNlRwbERjblFlaG9o?=
 =?utf-8?B?RXdpYlZlQnE5NFdvZ283U0grV245Z0psejBMTW5wOE5KckduZE80aTY5aHR1?=
 =?utf-8?B?dCsyTDV1SnhadG14cTFZa0RqNmFxRmpYMHJ6ajJYc01JVzV2WFBiVXlpOENh?=
 =?utf-8?B?RnJmaUx6V2QwOVFwRVNIQW9BVkFTTHNOY3pXL2RncEZnY0pWUVVYdFgyVk0x?=
 =?utf-8?B?OTVESVQwTStYZWNrWlM4Q1Z0UzJUTitydTVxaHJPa0I5Qmx0UHRSK25HSkRm?=
 =?utf-8?B?eTVmaHc0eUJoSEFVTkFEckt2bzFpRmpyZ0o0WjJxRlByV1k0RzZkOXBmQlJI?=
 =?utf-8?B?QWE5RHhiVUIyR2lmUkRMNlpnWjNyc1YycWlBZUhWb2FWY3BucnNTSy9BNmp3?=
 =?utf-8?B?YkNNeDdHdTFTK3ZtTWJ0c2ZIUnFIMkZ0VXZSbWNLLzZweGVVWGgxeTAzWUU4?=
 =?utf-8?B?TnFtd0RaUHYvWEwzYVJoalE0L2o1dUZpejJUTmk1VEVQN2cyNlJySWM4TTR3?=
 =?utf-8?B?Z0ordTQ1dWc4L2tsZzRkc1JacEdtblpENzc3bng2cGpWNWJZNnlxc1BVamx0?=
 =?utf-8?B?bGNHL3RSYXFOc1dkVG1kamRuOXNrbmVZYTduMGwrbjhEcTRqOHo5QUlUZXk3?=
 =?utf-8?B?bTlqVzBGS1o5OXN2elNVejE4Y3hJOHViOFVhb0pWWXJpc0lxdFhocGtLbWhD?=
 =?utf-8?B?NGE5TnJkd1E2Rk1JTy9KZEJaNS9vTlRlUi9IZUFnYmY1UEUyNmVhKzE5QXUr?=
 =?utf-8?B?a2dtay9wVFBaVjVzV3dseldrQ2I3dDNCdXVMcGRucjZrQ1BSR2MzTWtiUmdG?=
 =?utf-8?B?T1phWDZLajAyRjg1SnhFR0RPYStweDJkZ2xMWGJzZmlMTmd5ckdiMURoTkJS?=
 =?utf-8?B?a3FuSllzeWlSTHV0YysveFp1YXZIK09FTnBRTUNiSzMxOEFNMUtVNkIxL0VQ?=
 =?utf-8?B?RjAvODh6Z0dLbTdOUnB2NXZvbC92RlJqbnhKRXpLNXZVSkRPWnZzTFBiUUxW?=
 =?utf-8?Q?WbCc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFKcytOdW42Nml3VGQ3WXJ1aHNPV2srU01kZFRQR09FZVl5UHY3UVM2bXll?=
 =?utf-8?B?Z21jTXYyeS9CTHFkSUN1aHdsdDY3bncyV0hneVpjYXA2V2RzUmRWU004VytS?=
 =?utf-8?B?QWZ1YnRSeG8waGZQbUtFb3pkZk91QkpBd2hDL1BiSWVqZ1MzYm5aUE14SnBo?=
 =?utf-8?B?MjBnQVhUOU5OR0J4elU2c1BGemJIdjdhd2ZqSE43MVNxODR2RHY1WDNDaDVO?=
 =?utf-8?B?VlRZTG02YUR2NG9FY2NiOW1MS3czOGxwS2pGVjVOM2RJYWJuZjF1Q0FjTTlk?=
 =?utf-8?B?Wkh0ZWZmWTdtR29GRjI1WExMYjV0RHZNNXZoTHlNZVJKZVVxQ0NwUHQzUTR2?=
 =?utf-8?B?ZFNoU2IyQXBIcXNLQjFqZVBQemNHZmllRkFLV1pHV1l0bmJ0Y09URGx4R2Jo?=
 =?utf-8?B?YkNISlROMi9ZSmdzNGtFRE9oUGpjNHRSZDEySlBlWTltb1dxSThlUkJwM2RV?=
 =?utf-8?B?c2dJUm5sOFAwK0FFbUdmVkhpSVl1RzVoK2o2MG5Pa3Foc2NEMjFqWFRFclha?=
 =?utf-8?B?N3ZxME10eEZiaFc0cVlSNHV0QWhYN3ErRXFTMU83U1hEQVQ4TWVNYWFHdDRQ?=
 =?utf-8?B?WXRzQ3Zic1UzVFZ5dTZ4ZWpXNzg3N3JQRXFxZkRMejllOUtyZHhXU2JjSHZh?=
 =?utf-8?B?WVc3V1V4aFJzNGFEcmVYSS9OWThrM3J5enBZR3dJamRudGpMejIyTWFQSEEv?=
 =?utf-8?B?UCt6UHh1Q2tXS3JuQ05vdENwUUJKRkQrYURvZElyVnd3N29iUWZaTytNcHk3?=
 =?utf-8?B?NzBpVDB1L1krSGZJejg1STQxaFJTV21Nb1BSMG01UU1nTzB6eU5NK2FKakpa?=
 =?utf-8?B?YXRtOUMzZzdXbTVTdnkvUmI1ZU41Um5NNTBVL2d0aHlMNXhBMEZJZ3dobFJx?=
 =?utf-8?B?RE80eUFvazZlaXpjWWRDNFRTWFU1YjJFSFRPcmFBTWtOTzdDeU0wSFlRMWtV?=
 =?utf-8?B?SS9pR3h6YmErak1KU3dJbWV2Mi9IbWVlZG1oYzUxeHg0YXJuRlRKYzFod0p5?=
 =?utf-8?B?QWtMRjNSUXpYYlhMczhqa09KN01na2NxVWoydW1wSFZuY2xVRHhmczBKZTFD?=
 =?utf-8?B?MzVMUjlpQmhsc0ZzNzVteWVURCtPT3hKREVQdFF1dXNKYVRPTXJvSVhJNG5C?=
 =?utf-8?B?OVVUSERsVE9uRk1Ob0VuU25QLzI2Tlc0Z1htMzVxOTdsMGxZZEdXWWQwd29l?=
 =?utf-8?B?VE4wL05OT1VadmRNVnM3cWdxSG9lb0FiUSthZ2g0L2ZkUGhFZXBQekRhcm9Y?=
 =?utf-8?B?U3hHQmR2cjMrSksweWVHUUx6bU9Ib3I2L2tGdDFhZkdMVjVPUGxlMDdEZXZI?=
 =?utf-8?B?Vnl4U0svcG1iWlhHQVB3Z1graityd0pQYkpHRXBBbkdoRHFtQVdlRmp3VTdv?=
 =?utf-8?B?NmpTWXpraXJXTlE0S0tNcTMycGpmWk56RmFTSlh2VUtDd3hhNDYrcVJtWVhV?=
 =?utf-8?B?UzZHR0hWUk5xZUpKZ2Z3WWdobmpUcXNFMzFnN0VwMklkMXcyaGJCaEhKY3h6?=
 =?utf-8?B?UEZia3hQQWtKb1VzaVlrOHpNYXlic2JQMmhzbEsxUERFMTR1RDl4alh5Q05n?=
 =?utf-8?B?eWo3NmVJSXJNNVoyUUdXU2htOGxJNnhWZXBmRmxWK0xZcmJyRHJpOCtuQVlu?=
 =?utf-8?B?OWlsWko5Yi8zYWlIYlROVGxzS0NIME5UZ1Jqd1NtNkFNL2ZKRklRSWcwa0Fl?=
 =?utf-8?B?empNWmFLazZCNFdveU5sSmVEOUttUXNiZC9MZWlhUWM3NjJFckxSa0hKcm1h?=
 =?utf-8?B?c0p5WUllOC81Ylcxd1RxaFdpaENCRE5uUzl5WlZMNEhlb2d5cDlaR0t1c3NK?=
 =?utf-8?B?eDJuSldrTmZPZzgwdnhsQ0JYNjZGYm5ZbTZyUTdaZHFKSXVXeXVVM1JFalIz?=
 =?utf-8?B?eW5vN3FrSFFPYmVzWjlraExFTDlEUk1IZXRBNThlSDdRQ2FnYkF1YW9WcDV0?=
 =?utf-8?B?bStaVlZ5ZEhpRDIxOWxBSFdkK1NlQ0NudTNhRE1XSEk0THlORHdkNkRwYXp2?=
 =?utf-8?B?Vk9XNkpPajVRNmdyMVFpY0MwT0dGV0hrdHpnMVJQMkdLUlhVOXEycVhHcWZs?=
 =?utf-8?B?YzRvN2w4U1JKKy8yTnNwVnBlenNGVFFzQkN6Wm5hOTV2QjB3QURvL1Rnc3RX?=
 =?utf-8?B?RllQUEhKeURBbldmbEJpYUZTSllRekw1N21sVnNKK0FPcjVRVndNa2xlOWFZ?=
 =?utf-8?B?NzFOa1VpeStxVVd3TlJiT3paTE5NcExweWJYRzdqK0ZnRGRKRmZuYzBwMUhp?=
 =?utf-8?B?UGZpN0NOVXdMUVFkeHA5VUVvL0gxUHBTSW1sUWMzRE5TWkhORWpaT2xDM2Q4?=
 =?utf-8?B?REJvZXp0R0svb0xCWDFXM0UwNzY4Z1ZGUS9PMXo4WUs0QXlJclJVcVN4aVNB?=
 =?utf-8?Q?vCU5Nx3WaNDO09do=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c12a9ea0-a4ae-45d0-b45c-08de5a962a7d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:43:34.0014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwkwiwegZ6Une4Yl8a04bDzPFYBg0ZbyJruiGsm4G8tc4zsjVqFlMGYC0qYUKdg+ispJ2zoGGoSBoIsMQzJh2vm2kn9H2uJ4npRgwiuPaAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9534
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

On Fri, Jan 23, 2026 at 10:35:53AM -0500, Patrick Robb wrote:
>    On Fri, Jan 23, 2026 at 4:02 AM Bruce Richardson
>    <[1]bruce.richardson@intel.com> wrote:
> 
>      On Thu, Jan 22, 2026 at 01:59:19PM -0500, Patrick Robb wrote:
>      >    Thanks David for the CC. We need to rebuild all of our DPDK
>      >    container images for the distro build testing etc. which takes
>      some
>      >    time. We should be ready early next week.
>      >
>      Is rebuilding all container images something that needs to be done
>      every
>      time we do a minimum meson version bump? If so, we probably need to
>      look to
>      take steps to make things easier to do.
> 
>    Right now we do build new images any time any DPDK dependencies are
>    updated, including meson. That's done with the dpdk-ci template engine
>    (an application that templates out Dockerfiles for DPDK CI
>    testing): [2]https://git.dpdk.org/tools/dpdk-ci/tree/containers
>    However, to simplify we can just move to installing meson at runtime in
>    all cases. We already have to do this sometimes (like when testing with
>    an LTS that requires a different meson) so doing it in all cases
>    wouldn't be too disruptive. And, of course the main point is that that
>    would allow us to accomodate a version bump like this  without
>    rebuilding the CI images. Let me know if you have an opinion. In any
>    case I will chat with the CI Lab students about it.
> 
Having it installed at runtime would be definitely good.

The other thing I was considering is whether we actually need to use the
minimum meson version for all build testing. If one or two containers have
the minimum version that should be fine, and others can use the distro
supplied version so long as its >= minimum.

/Bruce
