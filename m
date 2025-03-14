Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22DC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 16:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5796B4029E;
	Fri, 14 Mar 2025 17:24:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6C3CC40289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 17:24:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741969488; x=1773505488;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=2o4xrecxTZduEcQNskNWoQY2j+aAvGdEJhzyiOPeimA=;
 b=nr8yduYjpmErao52WfMqnUglWxR+BlodF54+Kk4qrdFoLsExLduVl1FP
 /nexbjSH1Qhh2w0ZK8JlJlyQ6nZikDc7vvFH3iUxLE1ysyXhpsrD3Z0OO
 mPyn+QkVTyLn+SUiMWh2TCjOyCXVsOGz2gl8Dqke8GSS8+/NE4f2y0Idq
 4DxBJeeKNVS6+wmN91yDv9YrLmJ9gb99TxUraYHOYHMyFqj2eJ2U72Zkb
 PmjS76IeNc1aOFOSDaf1CLWZZbeasZJZWT1GDjat7+hvdS25VpHVsv1yg
 ROx873U/nESNSYHAFCKSEaqGzOV+8qiicViRtqLf2FhV9lgxolFw7A5Ho Q==;
X-CSE-ConnectionGUID: M83q16SITNeH3JWQwA0jUQ==
X-CSE-MsgGUID: SiSOabA1RXmelsI27IYP/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43305307"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="43305307"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 09:24:02 -0700
X-CSE-ConnectionGUID: BYnNESgGSIyukqzbSSTP6Q==
X-CSE-MsgGUID: 1qqnHhL/TT2uEzBj+EbmIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="125512385"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 09:24:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 09:23:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 09:23:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 09:23:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhsTTMFXY8lUfdQLULewuyhL4O9SYicr0cdAyjaCGdr3YRotERkwPWjUyU+J6hsar91dzOjBHCWokmVle/PXWuuQ2JITmdIqm2+xBt0+fvz7UU76ev/NKOj5tMjwKg23ZuFodBMuUIXMMb+EI3CdiHnTAheQijXFE3ZOfNXPxwjWkq7qbp6LdMzkiu8A7gbEZVTcqCBpC1vCjRN6UK7iIa5DhQKN5GWSOHg530z48Je2EcXAfZMaiOGN373+UvkyHYKRp3hFh9NpIFJQoJccCDqHlpwXtAjYxW/mWxvKhZLbd87QiRjvAc+nl/ndWMef+ev2ZXwBHCaToudSJXtemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyfbEP7RrRNMtAco3EfL/U2PGdRzYH42/wORAfTVuUQ=;
 b=vzHEQXGVNQnWyvLfUe/TFII6isUWvlq1zAEYRMpBnkGZcJ/WZaD6KphAXUjaWI+iuEeG3LwzUb2T3cE3a0ezmH5yjlVpYiQMgG8Imc4DfvUmZO36dYYFZ1KHBK0KmVIsMYJKBqMeyjNL7CKIxB48Rce5Iqt2X2AdXak+9RqeLfllJFEVX//bHf5YYr1/f7N/ITzprflteB1Gb8Er/IT4fw2bsCbsG1YrJQksGEF+YMN6aons66blPJJuPiiIGlRBYrhFxCEcLYTx5k5H660ZFSTI6AppYcWHFLrVKz5/qDpP5/A3FT9ScYOv2AmSbdJnpJSLQJCeQVOBb4fxPeB+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB8026.namprd11.prod.outlook.com (2603:10b6:806:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 16:23:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 16:23:54 +0000
Date: Fri, 14 Mar 2025 16:23:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <andremue@linux.microsoft.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>, Parav Pandit <parav@nvidia.com>, 
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, "Nikhil
 Agarwal" <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>, "Chenbo
 Xia" <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 "Chengwen Feng" <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Anoob Joseph <anoobj@marvell.com>, Andrew Boyer
 <andrew.boyer@amd.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav
 Ovsiienko <viacheslavo@nvidia.com>, "Bing Zhao" <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Liron Himi <lironh@marvell.com>, Chaoyong He
 <chaoyong.he@corigine.com>, "Nagadheeraj Rottela" <rnagadheeraj@marvell.com>, 
 Srikanth Jampala <jsrikanth@marvell.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ankur Dwivedi <adwivedi@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, "Gagandeep Singh" <g.singh@nxp.com>, 
 Kai Ji <kai.ji@intel.com>, Vamsi Attunuru <vattunuru@marvell.com>, Pavan
 Nikhilesh <pbhagavatula@marvell.com>, "Shijith Thotton"
 <sthotton@marvell.com>, Pravin Pathak <pravin.pathak@intel.com>, Ashwin
 Sekhar T K <asekhar@marvell.com>, Igor Russkikh <irusskikh@marvell.com>, Ajit
 Khaparde <ajit.khaparde@broadcom.com>, "Somnath Kotur"
 <somnath.kotur@broadcom.com>, Chas Williams <chas3@att.com>, "Min Hu
 (Connor)" <humin29@huawei.com>, Ian Stokes <ian.stokes@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Jingjing Wu <jingjing.wu@intel.com>, "Praveen
 Shetty" <praveen.shetty@intel.com>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, David Hunt <david.hunt@intel.com>, "Sivaprasad
 Tummala" <sivaprasad.tummala@amd.com>, Akhil Goyal <gakhil@marvell.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Fan Zhang
 <fanzhang.oss@gmail.com>, Ashish Gupta <ashish.gupta@marvell.com>, Mattias
 =?iso-8859-1?Q?R=F6nnblom?= <mattias.ronnblom@ericsson.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, Jerin Jacob
 <jerinj@marvell.com>, Harry van Haaren <harry.van.haaren@intel.com>, Min Zhou
 <zhoumin@loongson.cn>, David Christensen <drc@linux.ibm.com>, "Stanislaw
 Kardach" <stanislaw.kardach@gmail.com>, Dmitry Kozlyuk
 <dmitry.kozliuk@gmail.com>, Byron Marohn <byron.marohn@intel.com>, "Yipeng
 Wang" <yipeng1.wang@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>, Amit Prakash Shukla
 <amitprakashs@marvell.com>, Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>, Elena Agostini
 <eagostini@nvidia.com>, Zhirun Yan <yanzhirun_163@163.com>, Jiayu Hu
 <hujiayu.hu@foxmail.com>, Sameh Gobriel <sameh.gobriel@intel.com>, "Reshma
 Pattan" <reshma.pattan@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>, Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>, Gaetan Rivet <grive@u256.net>,
 Volodymyr Fialko <vfialko@marvell.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
Subject: Re: [RFC v3 6/8] build: mark exported symbols
Message-ID: <Z9RYCXF6Ag23k8Uy@bricha3-mobl1.ger.corp.intel.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-7-david.marchand@redhat.com>
 <Z9MWQR_o3m4T_rFt@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8w0MPV7XQpMyiGTsSVDGuW1LctGyrXZ6n52O7AYzij7Zw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8w0MPV7XQpMyiGTsSVDGuW1LctGyrXZ6n52O7AYzij7Zw@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0195.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 29bec6c7-13d2-40c5-1bf1-08dd63149cd0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KysrOWpsNUJ6WnlZSHBwU3NpbHBZaUZqSE41RmdVZ2t2bXdtZWkwYy9zZzE2?=
 =?utf-8?B?bTZlS0pldEpQZmR3ekxOOHpGNDZVL0Z6QzQvL3VoekJaRndXY0JHUUhQVmZM?=
 =?utf-8?B?TnJGajQ5Q1hMWDZoa09WQ2Nwb2JxTHdLby9SK01lZGlpR0VQSGd1NlJXVkQ1?=
 =?utf-8?B?LzlzV2Q3K3BZNFRnbi9uZmcwTjRmWHBSSnBvcjB0eVFLbkR0dEFBM3RNZ0Zt?=
 =?utf-8?B?M3BvSDVhSGJ1ekZ6ZDRQZmJIKzM3Ti91S0NnM3JqbHZpODl2S1d0Y24ybUli?=
 =?utf-8?B?Sy9pUUNhK3BGc1lkKzZ0dngwNVV0V2VGSUx2LzFWSWpaTW8yYlJSeE5LRVRu?=
 =?utf-8?B?UG84NzEzQ2IwY1FJU2lvRUNIRSs5TjcxY1ZDOFhZWTBOdm40eFNRalQydUZv?=
 =?utf-8?B?Y2lmU3BvQkJQM1Jxc1ZZOWFBSXB4cFB6R2dPTGJGbmpsMUFqdm4rSnpZbjQ4?=
 =?utf-8?B?NnQ0SlZOWnVocTRpSmV0Z1VaSVhXZjFad0xaejVjcUpNQmNuamlLRGpNemhY?=
 =?utf-8?B?NEhjbDdvVkx6VjhoYmh6QTdaOEkxdWt1ZmJnL3hQQm84eWplSEVpQVpUNERN?=
 =?utf-8?B?N2VHM2w0QmpOV2svWTdHQnhMVlFwSm1PNXd5aXdqYnZrV1F4cnBXNGJ0YmtL?=
 =?utf-8?B?WXNUMWxDTG55QVRtOTNhNjNXbnpsNU5HWVNvV2p3eGJPdFo3c21GdGZNeVNV?=
 =?utf-8?B?em44N01GdkpreW1yY2F0STBMMStNc2ZvZVJJL1RSNkYrSUY3MVhCRGlhaVgw?=
 =?utf-8?B?d2pXd2YvSGhOQlpGemtFSUZIZW5POFNhakQwMmVQVGNmdGRkclFBcUl1ZEFn?=
 =?utf-8?B?OUFlQnpjbHRzUG1hL1lCUXNac1ZlSjRHK0hseSsrSEdFOTROZWpSZ1krU0Nn?=
 =?utf-8?B?WGlpL3VXWXYwRXdnODNSSjQrSmFlYVV0alh2SU83bWF5cUVldzVxOWI2Nk5L?=
 =?utf-8?B?VHhKZFNIa3JHbUtqM2g2L1FnZlpOK09QVk5EQ0ZLK2ZJbEdWZldyTjlmTk83?=
 =?utf-8?B?aS9Dd2NkRzk4OHZhU0FRa1paNWx4RjBFRWJDa2FDL1VzeS9MZnNYODVoc2ho?=
 =?utf-8?B?NkYzQWgxeXZvaUxQbTRkVlc2Um5pYjM3RlFLQTRJa0pnN0lCVW1YeWxqcWd0?=
 =?utf-8?B?VmtJS2VCdmlhdDg1N1Vpc0RWZ1BDZHZOZXdHTk1XdU05WDlld2V2ejlPU1RF?=
 =?utf-8?B?UnkzQW1PM0tNWDU5ZFE1aTAyYThJME1IRkxMeG5pZmFCclRpZ25ac2E3TGY5?=
 =?utf-8?B?YlJaTXZaZUNCTGQvT0tPMTFJaERRZlVxeFBncllDM3d6RTRDOFIyVWwxeFdY?=
 =?utf-8?B?Q0FGblVtZUVadnIvaFFydnZrZlZ6cnRRbnRrSHNwQ0hqN2RGbDdrRFZPNmFP?=
 =?utf-8?B?Ui9VZk0zTkJscWR6OXlaVHRRbk9wTXFkZnc3cVFERzFNSEljRlM1aE1RUXZ6?=
 =?utf-8?B?ZkZwS0NZRTh1QlVLaDBWRnRWR1ZNaGp1alRwT1l6K3BzVzhrbUtPMkVCS0pt?=
 =?utf-8?B?a0N5d28yUGc2Y1dUdjFZRnAybTY0ejN1eUNaNTQ4NTNLWkJoZ2s5dmU1TUxK?=
 =?utf-8?B?ZjBOb01qbHYwTTBKcjk3dDJFd01pU0RVTlh1MEczM0k4REVoQkJKTUZ3V1ph?=
 =?utf-8?B?d2orV0ZHamdtUTBJSWRpWXlpVUpHTFlqUHluaDI3QlZROG10em9TVm5aeW9p?=
 =?utf-8?B?YVdobEk4RHFjWEJ4RVRjZEFLcE5YcHZGUTVJc1pyRVFweURzcDlPd2pIMUJa?=
 =?utf-8?B?QkdQR1BSL1RYdkE4RUtCbmdGZGpPR04yVVF4bzFqTUVhMTZnQnJNeDRFbktR?=
 =?utf-8?B?d0lRa1dqTHcrZE9Zby81eklNbTJmNUtoY1d6aXZGb3o1YU93UU1ObGJqbndo?=
 =?utf-8?Q?LnjNxa8oDQsCe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlFwVTB1OVEvUDN2NEFqSkJRcnhzVUEyU1E0RExXWjQ1TGxkbzA5bWtqWmtT?=
 =?utf-8?B?VzNBa1g1c2ZDbkF1b0NyMFdUVVdGWjhXL2hXTFkrbW1obVNieXNucHNxOGo1?=
 =?utf-8?B?MHhVUU1qRTZXTngrQXJadm5RTzFSRE9pbHhBNFRITmNFTEo1c25uYkRHTzYv?=
 =?utf-8?B?ZURyUTBFaXBIRHgxOGY3NjlyT3piNGhHWk12L3JxRWsxVlFEQWZEdUpWc1ZH?=
 =?utf-8?B?bWRwM0NqSFhucGlDckpMdWt6czFaenQ3azlhZkd0VFNJUjNYdzY0NjNZMnIy?=
 =?utf-8?B?Z09lZjlkWGk0eDlFSGJoNEdLck1UeTBRY2lFd1hWR205UXZzRHNkTk5FcWtR?=
 =?utf-8?B?VkV3RUJ5TFpRbyt6L1Nkd3BMdk1yRTQrK21TU1o0Wi83dlRCdnJXMitXYnpR?=
 =?utf-8?B?bVZWTWduQ1BvRWVseVlmTDNCdm12U0FIOGNINjN1b2d0ejQrVTJCd3VGWVVv?=
 =?utf-8?B?b2x6UklwSTNLTGkzM2ZWVjM3aENXYVdydm9vTGFzTGU5c0pDeDgrVkJNeTAx?=
 =?utf-8?B?S1YzbjRua3NtOFNDeUlweXpPN09NWDlKZEZOYU55TFkvL3JMdW1hRjNXNWIz?=
 =?utf-8?B?YnhhZDB6TTEvNTg0QlRjb2svdy94WWxUYlNaUDZEcGxZUDhyZFpza216VUJv?=
 =?utf-8?B?akFPclJJYUJaY3cxZDZPRHhIdVZzbVdjTEwwUTJ3dDhOSld6MDJXNjdyVnV1?=
 =?utf-8?B?RHQ5cisvVEFvWHhYNXhuSmlKWnNEQTNNSTUxcnRvZE9LRENjUTNZbU1JYmVJ?=
 =?utf-8?B?NWw3VGFwRFc2WkZQVVBRMFN1QVdYNHVwQzdsT1VocFVvZmhWamhYNmp2YUQz?=
 =?utf-8?B?dEJMWktFRDR2QmJveVNWcW5iZG0ycFNJZmt3Wnkwak8vUW0vZEo0bmFZMG5h?=
 =?utf-8?B?ejFWWUU1UTgxL01yZ3pKU3Q5MXRPZHd0UXNrUThHeEJsODAwZHVOOVJ1Z2x3?=
 =?utf-8?B?a3lOdzVCbEhqQ3FNRWk3bHFBZURQd0xPejFYZmVtbnZCTGJkZ2xoUmxMMGI4?=
 =?utf-8?B?d09qZHF2aGZ0UGJzckNJWmxISG1nalFmY01KWVZpTk9jaXc0ZmJvSUVHQTJk?=
 =?utf-8?B?ZTZRV0l6dmlOTDFYYU5mMjA5OUltVG0wRWxFTXlka25INzMrajI3T1ZIbjRS?=
 =?utf-8?B?bWUzaUo5RGxhYzFZSC9wb1dLaDA0RUNhNDBlRzY0bXlNem5iVFVGZ0NxdE4v?=
 =?utf-8?B?S1dwN2VBcVdKMmVseFptcFhuV3RtcTNjZ2gwU3RETEw5TU1SNTdUTlV6TEEv?=
 =?utf-8?B?N2N0UTY5WTNmUDRZbU5DK1pFQ25JR0ljZ2s5NHVndS9wakFBSXhNT3diYk1n?=
 =?utf-8?B?djU4ZlJYakZsM1Q3bkZ6N3Z6TVM5aFlCbnpuSXZhWlVnREovazUrQWZ6SS9J?=
 =?utf-8?B?bUs1SFdWdHBRMXNkai9XTUlaVXBOWTlXUzZ6bWwyS3I4bEZHWWMzMEJXMHFr?=
 =?utf-8?B?T0F0a1k4eERlT3FzWFFvQTZMMjU3RWF0NjF5QkJyQ21HbWMyc1c1QUV0cWkz?=
 =?utf-8?B?THB3cXNhZEpya2Q5N3BrelUvOWR5N1RDcG9aYkdLS2ptTUswclRnM0hMSjRF?=
 =?utf-8?B?aStvNWtxS1ZsYzNWWEZDZk85dTNrTytiN0hlV2pabHV2S0UrOUJ2QVBteFhn?=
 =?utf-8?B?ejFZTDBYdC84eTh5V3ppc0hoczN0LzZqcVFaQ0JlRWpQK3VKUEV4aWVXTGtT?=
 =?utf-8?B?K3pudVdsbzZkZXU3S0lMWDZ4U0l6bkE1S1pPRXZYNGdHMGxuOUtaMTMyZzNL?=
 =?utf-8?B?c2RTbTRlUGY2RDk0cHBmTDROK2NwNTgzQTlMdmdEaXNlT2I4TlljazZRR2t6?=
 =?utf-8?B?YVZVWVRwYTA3L2RKL3VTWFI0dE00T0lIaW5UUHY5NVpwWlJvWHNFOFhVZW5R?=
 =?utf-8?B?cE1iWTFzZnpTc05HUkFiMm1rMnZjajZwZUhoNDRVV2FOOTJDV21OMFo5U2d4?=
 =?utf-8?B?UndSam9qdG9La0xoSy9TMmYyMytnRnV1eFo2eWpoeUp4U3FZZzlFQ05mUnNv?=
 =?utf-8?B?cnppU3dBcUNNdkxXcWY0a0I2MG1vTStnVnlDTU1zZGF3YWVZSHBMWUEySUdK?=
 =?utf-8?B?TFJEMTcxNUZSU2RuY2pCN0d5UzlrR2JIYVRPK2pvaU9nN2xjSitWNmNFMWNS?=
 =?utf-8?B?NEp6N2pYYS9RcmVQQWdBV2RBL0RqZ1pRamlCM0lvbVhyTC9lK3BVZExqSy9r?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bec6c7-13d2-40c5-1bf1-08dd63149cd0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 16:23:54.1103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vitqI9+wrFjBx9oHQYRNMxsK79KoSiNGnmZCPjs+RHaeZEfKzVG2xRGNRnnBS2tkUBBkL7qOrc6b1AHKMXZ80ZyjQsmyMLxVgJVjrVkPWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8026
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

On Fri, Mar 14, 2025 at 05:14:34PM +0100, David Marchand wrote:
> On Thu, Mar 13, 2025 at 6:31 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Tue, Mar 11, 2025 at 10:56:04AM +0100, David Marchand wrote:
> > > Annotate symbols with newly introduced export macros.
> > >
> > > For code not compiled by lib/meson.build or drivers/meson.build (like AVX
> > > separate libraries, or sources in /base/ drivers), the exported symbols
> > > are added in some file listed in the sources so they get caught by
> > > lib/meson.build or drivers/meson.build.
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> >
> > Just checking: for the AVX2 and similar instruction-set-specific functions,
> > we don't get errors if those are not present in the actual link phase, e.g.
> > when building on non-x86 platforms? We don't need to put an #ifdef around
> > the exports?
> 
> We are not there yet, but it is likely MSVC linker will complain, indeed.
> 
> #ifdef around the exports won't work, we would need a precompiler pass
> (and exclude rte_exports.h inclusion).
> 
> Another option would be to provide stubs for those symbols when the
> additional AVX512 (for example) libraries are not compiled.
> 
> But I think the simpler is to let a driver/library provide a set of
> sources to parse for exports... maybe via an extra variable?
> WDYT?
> 
Yes, something like that could work.

What I'd actually like more, but never have had time to actually try out is
to generalise the instruction-set-specific build stuff into the higher level
drivers/meson.build code. After all, much of the code for doing so is just
duplicated - check for AVX512 or AVX2 and if present build these files with
the extra flags for that instruction set.

Something similar with the base code. Most base code builds follow pretty
much the exact same routine.

/Bruce
