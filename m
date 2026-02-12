Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B4FEE36A6
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 16:44:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AB8C4025F;
	Thu, 12 Feb 2026 17:44:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7982540041;
 Thu, 12 Feb 2026 17:44:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770914664; x=1802450664;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WljvLEFwf2+DmWIK4gAYeb2wF7H2MBio2WbjbGzkLVQ=;
 b=FShdgsjw4MuPCuDAXu1ZzFLvPKRdWOfSpIoK4rlcjrAPKmemERDnpBPp
 VFbldUCbUHgXHZ+ogyq0h2fG+pHl7f18Hwt+xkLbFtJFVhtM5wb56sxnb
 ErCbKL4b+HeXf9fooPoCv/6/nrGpJIZ5cqA8zL9A8yoy/q9F7+m9J7No1
 2GrI6Xe8/cCW7giXgDsP/0Y9D95gOm8IwDNxdGh3W/kr3sJPQjfpYS5r3
 5ShMjaydiOuk/cb1D6KTwTzlC4JHFI0+Iw8Wxd56MbNA9CifIe7yABwLl
 Y3Ppgk34vq9cSds90LlxrLlLXuuT+zRIEEKRvhhrG+1q+PIP+msvY/nYS w==;
X-CSE-ConnectionGUID: 82As21nkSgmSWdq6hD3piw==
X-CSE-MsgGUID: 3foUFRksQqijufKWNgDW2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89499683"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="89499683"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 08:44:23 -0800
X-CSE-ConnectionGUID: Y1c4BfsOTNij3bdtlQgDwg==
X-CSE-MsgGUID: N7ysnPKkRHGeUwQd5UMBnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="235636458"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 08:44:23 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 08:44:22 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 08:44:22 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 08:44:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGbM6xoKSuiBfAkn0jMaS37cd91AegmB7OR6C+jkSy+9QFEuKQpeEm28XzlMxVrkFjTpX2ev8Po5EHe7BtFavoFWe7ANVvgPjKfaLUerP4z8Em9stQs3Fnp6zwChXl2HTAhXe9q53DCJXld+8V1/YYXP0LbgYg/HvreWZkLEoYbYU77FtHEvGQHnjq/2zbhhsBrMLk+XlMKfHbTs7QeIMh0+h+QM2z7WFoBz0FUgO+1ej4aLMNTRmmCS4jrwQB8eu87i9DeXd2yxY1eMNeD3MPijviuIdQ7YM0t0ntMsRfu5jqtbMqiK7X+Ka8tIsE3Hn1lCC/v5Rd/xq8CsUUhKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4flBVpAOQQa6HiWYjKz3d/I403yyCfVuSs8BgaaJiU=;
 b=O+JCphSUAsdLtnYRkG8kuebbYIG6rVt06oyR1xSaZ1pFPmA1vJpYx7wiuNiCTtBMMHBi3DOF488ndG1JLSioXirrBZ/SXAw52wuN1s8ey9ILt3+SpY4278n9GDxzsympBJ1oeqRPP8Q1RxmZI+QaY5v6AJXjPJb3d6AafTox+j5MYmAdcJlh+0HUmPsumClVJxTEgjJfKNGzpxgl261+GFG75lGBO54qUIqwPIl+m+jTTEMGh56FosoYWdPuMjxbY+PKr0zdM7EpNfwwZnv51KUwKUXcOm+WJHrJGgUlYYQOtUd4t0QF0ZQqEYBGg0TyaAqU/PV4iyoD+95OeJKM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SA1PR11MB5777.namprd11.prod.outlook.com (2603:10b6:806:23d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 16:44:19 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Thu, 12 Feb 2026
 16:44:19 +0000
Message-ID: <97685f05-c5a6-488b-b67f-f65dbf5e97af@intel.com>
Date: Thu, 12 Feb 2026 16:44:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hash: fix maybe-uninitialized warnings on build
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20260212162705.3923717-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260212162705.3923717-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0154.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::9) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SA1PR11MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bf22e5-d44c-416e-7bb5-08de6a55f76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWxPUm40MVd4bFVwRjlKLzYwYmVjY0VpZ1FsNWd0RlFTOGkwR2VQWWVDTUZK?=
 =?utf-8?B?anV0dDBFTE1wYkc0eVd5emRvalM0YUhYSStGbFYzZjRoeVJFZjdmZHFkOXph?=
 =?utf-8?B?Z1dmZ0Y5alVld3NNVTVHaXU0VzM1WHJhM20wY2lDQTQxSzJMQWJYQUwzaVpW?=
 =?utf-8?B?N01MMTFoQ25FdjZKVmNnY0R0eVE4ZjB1MmdaQ1JPenNWN2cvWjFYbEpxREIz?=
 =?utf-8?B?Zi9BV1AzZXhZWjQ3MFBBdUx3ZVRSanhEZnRHbFZ5bi9jSGMvSDlyN0lwWmZN?=
 =?utf-8?B?Ym40UTZwaVlYcUlPRUd3TEJNYjROcU1BTWM5akJSa2pXbDgxcUx4RnI3d3Bh?=
 =?utf-8?B?cXNlNUMwYzBweWZHV2t0Szh3bGxzWkVCV1hoSC9rSFhUcFoyMVZDRWN3YllV?=
 =?utf-8?B?cWYvU2ovRzZtWk5VcTJnMUZmUWV6Q2JIK21zbUNkRXkyZFo1WWwzenRtcFlP?=
 =?utf-8?B?NnAxZmxsL3VsSFUvVWZpL3c1MG9GQzhWaWQxOFJMaWFRZjVGcG5MSmxCVFFk?=
 =?utf-8?B?c2RSWW5kbnoxRVJyb25zbUx4OE9mOXVWdHU1OVlLVGRrQlRVbzVISWJrL1ly?=
 =?utf-8?B?QmhDdUtpYy82OXpWZ3FNWlF0V3VLUUE1Rjh6Vm02Y3d0WU9WUHRja3RxcThx?=
 =?utf-8?B?K3NxOHFZazl4dktjN0VzQkoyZml0WUpYUWJCNmgyb1Z3TVk3QzVJSEhoTjBu?=
 =?utf-8?B?N1BFWTBlUzZKRzF5RG1hZDQyOWg3YW5RTWo0QjFDZEppdHhZOVMzVlNIYTEv?=
 =?utf-8?B?RXE5dkUzTDhPVU1hL0dRWjJwZTZCUmdXU1BQQnhKdlgzV1B4ZTVXcUhyQllR?=
 =?utf-8?B?L3dYdVdtU0VoL1JpZ2Jhay9DcVpKNTdsY3pBOG9JNmg5bnVLRnpRRnFqcTZD?=
 =?utf-8?B?NzRJZGZDTEZJV0tKaFl4U2lVckJsRTdUdUVvVUJWRWg5UnF3dFRHVlFBVVlC?=
 =?utf-8?B?ZkoyUVJRUUFaWmhFZ25Wa0N3MlNLT3lxWkJiVE9qK1d1R3ZqUW9GcHdFM05y?=
 =?utf-8?B?QjVieUxtQTdPeThGYUFkUUhTWDRhUjBaYVM1aDkzS3ZOUjkyaUV4cytVdUIr?=
 =?utf-8?B?c0cwTlUwc1piNU5PZEhVVXBKRlBhRlRMRFhGVUo5RVRGVjRrbkxqWEJnS3A3?=
 =?utf-8?B?WlhYSzlyalpKL2hlRitFWkt4c3FpTHVoN2dVRHYwc1g2alVWYTIyYXdrNXpp?=
 =?utf-8?B?OE5uMnVBRzZMNHdlc3VzT2xpeHk4QXh2dzNGOVg1YkNJM0RDaitncU1XbUY4?=
 =?utf-8?B?NFlOVUo3YU5DMlpFQ3ZsQnlpeXc4TDltNWlXYTE0dlZWYWk0azIrWTE2VXJK?=
 =?utf-8?B?U2hOcTRoYi9oaFUzY2l2WFZTV1ZBaUhhUFdZa0tHaWVwcUpBeVh0UG0rUURq?=
 =?utf-8?B?ZnNJUE8rTmppSEJYbXIwQXU2RVJPTlNPTERTbEY2bGp1Sy9SbHo5TXdpeVZ5?=
 =?utf-8?B?UXhRTlA1TDg0SFIvem9EWU1SNXNVaklWSytUMnRRbUJNRXpmUmZ3cEN0THdu?=
 =?utf-8?B?MkpYdEtVUEtuN2N1ZEljVUlXd3paNmhScGZ1ZHlwRmhoREp0bDV3bWR3bkZi?=
 =?utf-8?B?YlpmNUhKUUR0eks2S2x4SEZSamhqNGc4WStGNlpKMHBTckJ3L21oL1FUbW14?=
 =?utf-8?B?YzY0UGp1QXdidDJmbEhhWlUrUmd1RjZTS2xzMU9yd2VYaHlzVlQ4cFFYbDI3?=
 =?utf-8?B?aDlLYUVReXFmQ0dQRnZENVl4aWNib3FiTXdrcWRzZXc4VjVSY2NjcTYxZXRp?=
 =?utf-8?B?TUp1VjVuV3J3T0RZZXVEU3ZRMyswTGwrS3dzZkgzWngxWlVQMitsWWpzWTdQ?=
 =?utf-8?B?RmVNL1hSVFdJUFdWRnhNenVyTXZKRzJSV0dabklXak9RYWVreE9YbmVkdzJR?=
 =?utf-8?B?dlYydThNTGlFeXAxTC9TeTI1NlJadXNyOUcwamw2Sk5YVHVGTDFJNlFLOEJ5?=
 =?utf-8?B?Y0NTallZc082QzFmbGNtdkNyLyt5TWUyTDJ0dStiNllKNkx1NERTT21PVW9j?=
 =?utf-8?B?VkdoR2hWbEQrdzVvSmRQWFNrSC9GR2V1Q1BHQ0NzQVNtczRHejFERytSVHk2?=
 =?utf-8?B?L3hObE82QWFaMFI4SjdyZG1wUEcveFh0Y3Y4Ylp3b2VBUEdQaWFlZWxNYTRu?=
 =?utf-8?Q?HDgA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThneHdJVnNUbk9hSkNmaUdCODdseVdtYmZlZlpxeXNpMWU1b3VjRW4wTDVm?=
 =?utf-8?B?R3BtVHYrSXYwcThmMzltc0RqOFdkOHBaSjdIRDM5bDNMd3RIWGRhZHAzRWpj?=
 =?utf-8?B?cndCdmRZWWR3dmtBOUNVKzgwa0FLeFBuVFhvZUs4ZTAwb0hVSVhjMzdVQUNy?=
 =?utf-8?B?UWJmbFhzQVMrUzNkaUh5dmY1SWplVW1jT3c2TFVuNnpCYnJqb3paY0x1eXM3?=
 =?utf-8?B?MVc3aWpPakM0Y1JpVUt2Q2VpMURMMmVyUkIyZlBrQk9TWFhiVFBCZDdBbnNl?=
 =?utf-8?B?VVU1VkRPRzZkeVhXdzBCT2lOUCtUUWVFZENSYzFReWhQOVl0czBHbWR3dDN1?=
 =?utf-8?B?Q2NqTVQ0SzhCVVFldG00SXUzNU1NU3BVcU5ReURERkErYWY1bnZ1TUo0R1FX?=
 =?utf-8?B?VkxLREhjcTVhZ2l5OWJFUEtpK2pFUlg2YXBBQno1czlZNFpQa2VsaC9OTWI2?=
 =?utf-8?B?RGhkS3R6MkdNU08xN2IrbDMrR3FCQ2tDSU5sWDBON2F6a05pSG5tUC9ycW9m?=
 =?utf-8?B?M0dEd0pwaVhvd2xvOERnbDY0TzJFTnBFTnRYYjM3RWpzczEyZkFWZFd1R3I2?=
 =?utf-8?B?OU01amdUN0FyTEdPcFBkWTArejEzZjkwdm9xV01pSC9jMkFwaDIxV1pSM2Vk?=
 =?utf-8?B?S3ZYMTZsUHZPS252eVo3NWkyK2pmdUFkdE5DbDYzaEtWWUFhaEtUcFo5SGI0?=
 =?utf-8?B?WWNlY2hzTFJXcWw3aWdFRm02WWdVZXVYVFZvd2tZbDg5cXpES1RrbmY3cTJx?=
 =?utf-8?B?L1FkS1lnclZCSmFHejNVYmtvcWxDT0Z1WWdoMjh6elpPYlVHOUMxVVZ6VGFH?=
 =?utf-8?B?VW1ENlFsYVVxQm90QTFHMkJoTDBjakFrODMxRmdNWUhwN2hOMXFMbW5QRDRl?=
 =?utf-8?B?VmM3MS9MbmZmVFRlUjJrak9XNzJkRkd3cVJ1WExvNER5c1RuUTdLR0QyaUNy?=
 =?utf-8?B?NGFZb0loeWFRUHRPSmF4VXA5S3FES1l3RUQxVkZrTEFQdWNaMUFJclJ6c1lw?=
 =?utf-8?B?eFdQSDhKYXZtNzd0bUtCVW4wUjAzenBkMkVaS0JxZWNsSVRFTVk0UTVFTzk5?=
 =?utf-8?B?cUFDR3RvZHQ4amRBRVl6L2h0YW5TSzlzbnFjUjN1cFN4aE5kSVVtWXgvWlR4?=
 =?utf-8?B?Z2N3ZVhZelFoTXh4cHZ1N0NqT2MwK25tL2ZZaGQ2Q25GcXdUUnRUd3g2bkhC?=
 =?utf-8?B?NUJnQ0QydFlaN3orRmdWMndYdG5rU2dTRzNmcnJreld4RS8xNU44d2dFc3hh?=
 =?utf-8?B?N0FzQTFDM0NtTDUxV2YxWGxzV0d3aG96N0hNTW03TGd6RmRwaXJ1bzhacXZx?=
 =?utf-8?B?N0hTb2thQkNJMEFQWkNKQW5ldGNyaG4wNHU5M2hhQ0Nkb1ZhNTVRNFBUMmY2?=
 =?utf-8?B?MER4K29IN21Jd0VnNHJDc0Q5aXF1SnBkSDdWeGNLLy85M1NQUmw3SklkWTd6?=
 =?utf-8?B?M0lNOS92UVgzNzdLbm5FQnJ0UC8zdFdsTUZHTXVyZGxSZEZIdEZqRFluamNC?=
 =?utf-8?B?RzVYc2NKdFd2dFNHVTQzUTNHZHlESXpjb2RRNGVCRFlDOFc5czZrWWd5WGtF?=
 =?utf-8?B?U0FMdHl5V0ZYaU1WVEQ3UDhCS2VHdlZEcStQRkEwU1B5V1VJaDAwRWR2bHo3?=
 =?utf-8?B?eFVIRU5wNDdISG5BbzVYZnBSeCtRUDBGSVI5T0ZIVUtxazdIVnFla2Z1T0FG?=
 =?utf-8?B?UGN2Y012d3ZFZ1B6N2Jsemp5WFRydStBb2JuSy92WjF5SFVzUEQ4TWVqL2hz?=
 =?utf-8?B?aFhPUU5jdXYvejkyYzRSd1BUcTh1ejlIUUtNYncyd2x3UHRPSDNNU3hYMFVV?=
 =?utf-8?B?bldrL00remtkeWsyTlE1UmJWamQrUFBSUjhZREFnVTg4NCtYWDhWUktqczlT?=
 =?utf-8?B?clJoNDNkN0xTTlZlN0xxQnh6end1OCtQTDd2U1pScGlGZTFpOERLekZ4eUZX?=
 =?utf-8?B?U3Z1WTRVMGlBQ3VIbHRNSlZpZHVVK1JOVDFzcXJGaEU4ek02cEp0V00zYVd3?=
 =?utf-8?B?eGZnbEhJQkJBVHFDQlNhUG52NTBOU3ZGRDlMT2s3My91WWIvZ2JLTGxFV0s5?=
 =?utf-8?B?R0JkUTFIUjVtSVdQYU05RHErNzdZWnhlYUtFVzdxOTlPWlBOcEN4Szk0KzZp?=
 =?utf-8?B?VWl6ZkpZNllxWHJydlN1cGZ0UDdMUWYzOGI3bThrT25WamRrbHlhakdaNlhT?=
 =?utf-8?B?aytDN2loY2xSMEVFZ0xoRTNXYk4xUkVWbGdqMDZoOUFXenNRRTNrWUlUSVN5?=
 =?utf-8?B?aTMxWTVtYmc2VGNKUCtjMExNRFJhZjM5YmlYZWxOd3VwMjYrNG1HR2xjdmVS?=
 =?utf-8?B?N2lNWmNWV3BIdEZTZXBIU284T0w2TlMvY3JSWDBzUzBLaWdCL0l5Ym5xd3oz?=
 =?utf-8?Q?lI/vuzOJoXeiV9RQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bf22e5-d44c-416e-7bb5-08de6a55f76f
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 16:44:19.2228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O8ZYYnRdy5CINYTYrjK49BYnNZgAVuqs8DFQWi1IZKyMrSFO0zX74s53epCWz4OKrD7mOth+EZ7QQxvuITYmU566wASEzBhz+rzAOJeiAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5777
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

On 2/12/2026 4:27 PM, Bruce Richardson wrote:
> Following recent changes to the test-meson-build.sh script[1] to use more
> build-types warnings are seen in the hash library GFNI code about values
> possibly being uninitialized.
>
> In function ‘_mm512_mask_permutexvar_epi8’,
>      inlined from ‘__rte_thash_gfni’ at ../lib/hash/rte_thash_x86_gfni.h:150:6:
> /usr/lib/gcc/x86_64-linux-gnu/15/include/avx512vbmiintrin.h:97:20: error: ‘tuple_bytes_2’ may be used uninitialized [-Werror=maybe-uninitialized]
>
> These all appear to be a false positive, but fix these by explicitly
> zero-initializing the offending values.
>
> [1] 177acaf5cf75 ("devtools: test different build types")
>
> Fixes: 4fd8c4cb0de1 ("hash: add new Toeplitz hash implementation")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   lib/hash/rte_thash_x86_gfni.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/hash/rte_thash_x86_gfni.h b/lib/hash/rte_thash_x86_gfni.h
> index 99226b7592..69973503fd 100644
> --- a/lib/hash/rte_thash_x86_gfni.h
> +++ b/lib/hash/rte_thash_x86_gfni.h
> @@ -89,9 +89,9 @@ __rte_thash_gfni(const uint64_t *mtrx, const uint8_t *tuple,
>   	const __m512i shift_8 = _mm512_set1_epi8(8);
>   	__m512i xor_acc = _mm512_setzero_si512();
>   	__m512i perm_bytes = _mm512_setzero_si512();
> -	__m512i vals, matrixes, tuple_bytes_2;
> +	__m512i vals, matrixes, tuple_bytes_2 = _mm512_setzero_si512();
>   	__m512i tuple_bytes = _mm512_setzero_si512();
> -	__mmask64 load_mask, permute_mask_2;
> +	__mmask64 load_mask, permute_mask_2 = 0;
>   	__mmask64 permute_mask = 0;
>   	int chunk_len = 0, i = 0;
>   	uint8_t mtrx_msk;

-- 
Regards,
Vladimir

