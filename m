Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010E0CA1017
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Sep 2025 15:08:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFFA440156;
	Sun,  7 Sep 2025 17:08:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 111C94025F
 for <dev@dpdk.org>; Sat,  6 Sep 2025 01:25:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757114725; x=1788650725;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=c2uZeJkzXt2OEmvVX7y8nSTFvNmiprbXgA6DbxO8LlE=;
 b=i6gIAre0Y7hBDr/P4yNkzCTJinMNv/IuySYm5WLS2upTUgUmma1Hgv3p
 6dHaemsn/cmfGuMl1P6ThVW3CK6CrLNIIokUjXX8JGR5RzdA3RHCbi7iS
 vqe3xXaxzT8BCTQDLNjMZZu9my2UlPfIsLHwVk5Xhgpm1MHfo1FplH75e
 LkJXTRBoJNMDX4t59ta/552ndD/a3tlifSJ55KwxGusYfhrM72ZLNKQH1
 uOLXqa2kipBb25Eu1/hSou8a8E/guuHjA0fJIAWzNAu1gAleb06nYwEQz
 8w/ZQ8fQimA/Lw9aoxRnDY3PW7Uel7w/1iDApMku2OWdSYgbErm0fTYSp w==;
X-CSE-ConnectionGUID: wa3q27AUSlGC8JcT2Y0ssA==
X-CSE-MsgGUID: +u3iP2nPRLW9Ws6JeAFq/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59541613"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
 d="asc'?scan'208";a="59541613"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 16:25:24 -0700
X-CSE-ConnectionGUID: ovwSTOF+TzGpPFGQTnt1XQ==
X-CSE-MsgGUID: +tVTSSqfQNOjYIzXqavKxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
 d="asc'?scan'208";a="171828280"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 16:25:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 16:25:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 16:25:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.65)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 16:25:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0GlRhhM8OJ13NoLvzgDEq9cetGzUzh+CdLhmfbh4WjjTyC5JWaXFYi48DqiTWdRqlLPXTWweDOBMo6wpuIZUXiptsHU/Tzbvw6Q3TrSwLQhkYYJmGvQsCqS4Uf1jMl8+hWYRSCixhZqtfM86b1HLE7j2o1buotlb/I82m9cTjOMAcJof4qqKjPRk3L7mkG0fN6qLtpwWMwrmSaDiGJutHc7ZgM12M7Ww1nVzCqUakVuRry3okXcYTgq3G0wlordJFthHd6f1RncDXBXyWaJOuvRnTX2VqjiV5Q9hPuhL/QBuJ6Sa1vE6VeMHpaml8WaZa/ht+NRp00KwuQRtDm+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZULFu/k68FlwFnFnuqyG+ysvcVldJieSTSoDZ9N8qH4=;
 b=flUHIqATlZlQhnweirkX5SOqKFUhfDa7qUzyPbzM14SGDuGpcTRdrCok8zKIPNH/LSUd/cYZ+GYTRDfdls/yAUtpXNXrcLnk20epAOOSfxEz8B5/vg81UiQqBPnCWF1gfdur4yi+h6Zn4YHyw15nq3TACtxATH871tSIsI7B26u8FusSZy9PTksfZDAYyyPoJV+AYoV9UAdbx2eBB9ar6UqVn9tbEf4BW1zRUznanGnHnykocCNm+APkkS2EaiZCmRB60X+i2Hf5EdGGhgf77PMTj/4Q2uq8s2CMTt21kzmnihzjiGT6Z3/cmy5L9kzhyk6JSuryQekKbyWreVQ71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7320.namprd11.prod.outlook.com (2603:10b6:208:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 23:25:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 23:25:21 +0000
Message-ID: <f2bd7403-b79f-4f7f-9979-d7cbe442c2fe@intel.com>
Date: Fri, 5 Sep 2025 16:25:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/12] net/ice/base: improve global config lock behavior
To: Bruce Richardson <bruce.richardson@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <890cfe97d9f716a7a65c028578bd1fc90ff04c4b.1756833701.git.anatoly.burakov@intel.com>
 <aLsCf6Of94EA3aP6@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <aLsCf6Of94EA3aP6@bricha3-mobl1.ger.corp.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HazwF8090YiCH1at8uIF60SX"
X-ClientProxiedBy: MW4PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:303:b4::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: af7ac542-ef9f-449a-90a8-08ddecd37b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3c4bVdLWnc0UEpIWUM2RzRuK1hjMDZDdCs2eHl2dWlMUVpqeTc0MWo5d3Az?=
 =?utf-8?B?b2RmV2c0bG5BeS95WnNJckoySUZBOWdIc1YyUXhuTUowQ2FNcHoyd0psVEU4?=
 =?utf-8?B?L0NHeDcwd1liZko1KzVuQXFIa0tpd0hUQW5iWkw2QTNOMSt4VXprWWNDNzJu?=
 =?utf-8?B?eFhBUTAzblBYVDVhMDE1a3JjNCs5eDFtVDhyYnhGMy92R2hnblhmemRFREhw?=
 =?utf-8?B?ZnFKRmlFTkRZNlQxTjNZTGV1dFpZWkJpNFBUbEVZckFhTE5TR0J3dm1LVUYv?=
 =?utf-8?B?WWF6QUtIQXByVmU1YmJiQU9yOXNoYXlYR0h4UXJueTJlL2tKRmx1Z2E3U1g0?=
 =?utf-8?B?WVU5bFhZV2V5amFYRW5LRUFERzJYQUZwajFkUG8reUJET3FtYW9UK3dzcElS?=
 =?utf-8?B?eUc1Y1BTQktsS3UzU2F0SWMwcjMvUzJVWlN2Ny85aXdYaFlVMW4vdkxrdm1E?=
 =?utf-8?B?SGVvK2pYSjVpT3NKOHROQ3VNbzcwR3Z5K1lKeHpXK0RFMEluRGxBV2JVOXJh?=
 =?utf-8?B?WGtEQzFyTEZKMVFwcEV2L3pxSVo3bER6ODZwZUd1VnBDc203M2xUbktzbDRL?=
 =?utf-8?B?RE9vdWNvU3ZmRGZlT2NiWElLSFJiRWl4UkNNVDE2WjZGblVjMGtnVVZ3RTZu?=
 =?utf-8?B?Szc4cGFLOUh4SlRmQVUreGZyR2FveXVvUWJUMGZtL2M3ak84ekpoeFVIdnor?=
 =?utf-8?B?cU5oTVZ4Vk5rTUZvTkxxRndybDV0USszaXlHbWNHMTJmNjBnMFFZUEFiZTh5?=
 =?utf-8?B?TVVsK21HL3VKd2h0NThnNWg3UW93K0VFR1MrdGdTZ3o5VHEwR1dtakxQS3FB?=
 =?utf-8?B?WS9OV1N4a3RwcmE1YTlGQnJ3N1d6UHo5SHBWSnBTZldYRkRrVXQwQ2tQd3NH?=
 =?utf-8?B?SStBdm5VbVJ4Rm5YTllqREwxZXQ4eGRSOWhhdmNCMm1lU1FjL2loOWxBcW9M?=
 =?utf-8?B?bU8xVldON2QwYWdMK3ByOVlyRkx2T0Mwd1EvM2ROQ0s2YWNvK0gwT0ozNUhn?=
 =?utf-8?B?a0lBWUs0Q3hnZE1lRXZkQkhwTmlmL1JhSWNYcVpoNTZrY2Q4Mi9rNUdwRklj?=
 =?utf-8?B?Z0VNaVhEYm1KKzFZQlJmUkUxdGZRMmNUME96Q0loWk8xQkEvRXlkelNqVWxY?=
 =?utf-8?B?WlcwclFWT1lNWDBZU0RHTyt5Mkl4WHU2N2haWndsN2ltYkpnUVhnWmVkUlRm?=
 =?utf-8?B?dVRZYUIyWi93cWJsV2VkNWJMMVdwL1BuZ2FtRXRBbFJubGxtZGlnSEx6cHMr?=
 =?utf-8?B?OVlUZVBjOGlqVElJa1FncmM5WDgzVU9ZdzE2MW5Pc1QyT0N3OUhneEZsTzBZ?=
 =?utf-8?B?MVNHcEE0VHJ6NEQ5OG1OTUpPVU4zVTNwdXFRUlZYYVFWcFFneFhJdEUxejcr?=
 =?utf-8?B?Q0JUN1hITjJ6cGhjMFZWRzEyK2R0em5ZY3BQZ0dES1FNSFhMUmpUM0VzZWJn?=
 =?utf-8?B?QWdlN0xvV2NuQTF4N2o1VHhYUjVudGdNODY1WnI4ZG1TLzc1OUp0cnFPVGJn?=
 =?utf-8?B?TDNmK3BFQW82NXJzL28yQmVWM3krNU1wcmI1SEJCekVnV2p1Tk9Ka2k4RXht?=
 =?utf-8?B?bDN2ajV5eWlXWkxqWDE0dkJOS0lWWU4zNVhkTzhWeEV4Zlo5bE0vMXFSMStS?=
 =?utf-8?B?R1YwQ1JnOW5EM2tTM1p0VzVya04vYWNUeG9ZZitvWVUxSTBmNzhiMHNDbTgy?=
 =?utf-8?B?aDVpOGhiOStYZlA2KzAzelJ1SDNtUVNQYkw1aXk4ZjFrV1RFeGpLeHVGT081?=
 =?utf-8?B?eTNZM28zVGtsb2E2d2JCK3VWSmN1UVFDVFU1aXdrUkdJcG9JZDlyVGp6WVVH?=
 =?utf-8?B?eU5RVkpaMjJEaUVNUTUvSGNRSFdjYUdmOUpTNUFRUWl5dGQ0VGgxTC9nelQ3?=
 =?utf-8?B?NFNqQ2JTZlBxaE15NEZrb0RsSGFBS2d4YlJEVHNUZzJBOXlEbXR3UXdSSjgz?=
 =?utf-8?Q?+CFhQ/FsxD0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5089.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cC8ybENYbXhGeDZNbFFmUFcwS04wSWlGZGtCUFI5c21CVXBNb2pxWThLZDlR?=
 =?utf-8?B?SlBtSE4yZkM5S3l2eTZvNVZia0U5SGVXd091R1JvNFlMaXh2VDllL20veDVh?=
 =?utf-8?B?Y0RHQjVLRTFic3FpZEVKdSs4MUQ0ME5saWhwbVhNb3dyUVUrTFhCM0FvaEVC?=
 =?utf-8?B?R0pWcVdJcmFLNTg1V016WVNSOTdwcGxsUnlYdnMzWCtLb1M3UXVqbHRVdmVv?=
 =?utf-8?B?dFpiNkRMSkl5dzRiZys4di9QT2x3U2lRMHcyZlovb1Z2bDVYTFEvazdCQ05l?=
 =?utf-8?B?STc2cTQvVnd5NVdyRWdCRGFqaU5nMk9mRFRqV0x4R2hxdVlKQTJQUzRyRFh6?=
 =?utf-8?B?N2IvTWo4OGFleTczUDJtNk1pT2szYXlac1pyODJqNTA5bCtEamNpdmFwcEtV?=
 =?utf-8?B?RlpwaDBkYm50S0pqTzlGc1hwSTNRd3gzTG9jMDdCTlNqZkVsdUduSXlVQURr?=
 =?utf-8?B?MXdqQ1RkSFd3OVhxQ3d2c1JLeXJNY3k5eGpneGpHYzcwVEZycHY5aXg0SElp?=
 =?utf-8?B?WXR5bkpuaFZxOWpjaHltMGY1UnRnc2VBUkVMOE4rM3NGaWc1alRKUWVFakZz?=
 =?utf-8?B?T2tuT3UwUjlJNDFld1JNc0dWNldnR3d6b05vcCtHeDdVYlhyeHdHd0NTRzFv?=
 =?utf-8?B?NHZVY1c2TjBYVHcySzlyVGZPYk9qdkI3Sm1LSjlkN1Fvck9PMUJ0am8xOGo0?=
 =?utf-8?B?YmhJSTBuVEtLd0czUlBJMG4zd3dETGJzZnpWUmNIT0J1UCtiU0dyakc2d1or?=
 =?utf-8?B?WGRrdWdKR2NyRC81ODYzT0xFczN1SEJBUEszMVdzVzU2MVNpNTVKY2d2QkZI?=
 =?utf-8?B?anB6aWlrMWdBY3ptMmhqVXh1Wjk2bkozZHdPbFU2Y0RqVGVHMUFNQXVQWUcz?=
 =?utf-8?B?V2VxRG9nNjZjYmdyNVRqMFQ3WkFsTGpSa05ta3NTV3o0U1dyTXMvcE9NV2Rt?=
 =?utf-8?B?VjZCblA3OUc0Z2x6UVpEbTRCMjdTaUJ6ZEd6VjBlbm56WW1zMFlZckZMaVJE?=
 =?utf-8?B?STJTUHpIWUxFNnVDOG9UdXZHL01rTlJ3MC9vZnhQMng3MHg5Y2xmdFBPUlhm?=
 =?utf-8?B?THVPYUpibUF0azdqRGRMdE9STXlnazBmVjJhN2N3WmpWYTNaY29pUnlUM0Fr?=
 =?utf-8?B?cEpKK3pySnpsemZUWVBNVExuQjdiTDA2M2NCL2l4WEFLcTU2RS81MzhReC9h?=
 =?utf-8?B?NS9DTFczWmR4TDhqdCtxNGNFRmxGYVFoZ291dW0wOFZyaW1hYTdGZzBWeCtp?=
 =?utf-8?B?SjU2RmRPU2VGQ055dWlKSXNmT2UyQ3Y1dmU2NVc4WHp3eEZiUnh4RS9wWDkv?=
 =?utf-8?B?QlJqcmFsOFR5WjZCZDIwTTJYVmk4bXRNOG9ZaGo0bGE5ZlVpYnJwZkdCWXJT?=
 =?utf-8?B?SHRmdXVSa29EUDhlSEdkeVM2VTBBWCsreUxUYzVnVWpBTldrNXU2ZjNsYzV5?=
 =?utf-8?B?WW1mQ3pTeUtCaHBXbG12ck8rZWpud3d5MnJ5QzV3bUJmZFFjK05pMkFSaHd5?=
 =?utf-8?B?L2RDYjFwVWNlKzVrQngyNWhVYXRwbC9VVHA2YXhFQlNJbHphM1I2eXJ5anhS?=
 =?utf-8?B?R25HNjFaVUFld3BjanlGYlBXZFo4RkhxRDV2d0tNU2ZsUkltcWJZU05IT0hU?=
 =?utf-8?B?TWtPVzNUeGoveGhzTndZTWpreVJGdHlxb1hUcGFvdUJoRG42TmdZbzAwaHZS?=
 =?utf-8?B?RGpXMWoyQm4zRWlWVTZzZjd0Y2Rsd0RDRkdQeGtiZ2VOMDFOMTh0WFVkUDlP?=
 =?utf-8?B?cTBraHFBSnNnVFVpYm1Ib21ZekxpWFk1U20xeXFEWWJrY1M2dEZraUgxQzNk?=
 =?utf-8?B?OXU4ZXVyMkZxZEdXVHp5R09rNE5MSE5vcC9IWUVhVmdLZlA2eE52dFN1dTlT?=
 =?utf-8?B?bGhSVUpXaDRNekZ2M0N1M1YxdmRtdnNkSnpDd0pROHoxZDY2TEFQeWlKQmJS?=
 =?utf-8?B?ZjZ5ZmNrWG1NWkR0N2hYckUxWDl4Mm40cEkrN3J6TE5iN2t5U0JhMjlLcm5o?=
 =?utf-8?B?WU5OWFVKMXRPM1NtSkQ3b0Y3OHV2NnBRN3REdytCYnJia1I0enVTbEV0S1FL?=
 =?utf-8?B?VTdzZ2VRMHZwUjdxZE9BTk8waERmQk9LbUpWODkrelMyNnJQMG5CRVhXNDBI?=
 =?utf-8?B?QWN2VjdOeWdYczdPOEdYVXl1Z3J5WllPeUtkZkppNkJWeG85M3hPWW8yS3l4?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af7ac542-ef9f-449a-90a8-08ddecd37b5d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 23:25:21.0165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qKLzAcrh45YBFEkfTNS0rVM5H1T6RzSaKaS3Ttz1p2RzmJuKMBlLV22ieS2dZxXaIxOFL4UAWFZub/ZQz88HJvuHFSfnznX+CbxG/B5BA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7320
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Sun, 07 Sep 2025 17:08:28 +0200
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

--------------HazwF8090YiCH1at8uIF60SX
Content-Type: multipart/mixed; boundary="------------Uq4tkBYsdMR7YX6EuDFWogY1";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Message-ID: <f2bd7403-b79f-4f7f-9979-d7cbe442c2fe@intel.com>
Subject: Re: [PATCH v1 09/12] net/ice/base: improve global config lock
 behavior
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <890cfe97d9f716a7a65c028578bd1fc90ff04c4b.1756833701.git.anatoly.burakov@intel.com>
 <aLsCf6Of94EA3aP6@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aLsCf6Of94EA3aP6@bricha3-mobl1.ger.corp.intel.com>

--------------Uq4tkBYsdMR7YX6EuDFWogY1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/5/2025 8:32 AM, Bruce Richardson wrote:
> On Tue, Sep 02, 2025 at 06:26:59PM +0100, Anatoly Burakov wrote:
>> From: Jacob Keller <jacob.e.keller@intel.com>
>>
>> The ice_cfg_tx_topo function attempts to apply Tx scheduler topology
>> configuration based on NVM parameters, selecting either a 5 or 9 layer=

>> topology.
>>
>> As part of this flow, the driver acquires the "Global Configuration
>> Lock", which is a hardware resource associated with programming the DD=
P
>> package to the device. This "lock" is implemented by firmware as a way=
 to
>> guarantee that only one PF can program the DDP for a device. Unlike a
>> traditional lock, once a PF has acquired this lock, no other PF will b=
e
>> able to acquire it again (including that PF) until a core reset of the=

>> device. Future requests to acquire the lock report that global
>> configuration has already completed.
>>
>> The following flow is used to program the Tx topology:
>>
>>  * Read the DDP package for scheduler configuration data
>>  * Acquire the global configuration lock
>>  * Program Tx scheduler topology according to DDP package data
>>  * Trigger a core reset which clears the global configuration lock
>>
>> This is followed by the flow for programming the DDP package:
>>
>>  * Acquire the global configuration lock (again)
>>  * Download the DDP package to the device
>>  * Release the global configuration lock.
>>
>> However, if configuration of the Tx topology fails, (i.e.
>> ice_get_set_tx_topo() returns an error code), the driver exits
>> ice_cfg_tx_topo() immediately, and fails to trigger core reset.
>>
>> While the global configuration lock is held, the firmware rejects most=

>> AdminQ commands, as it is waiting for the DDP package download (or Tx
>> scheduler topology programming) to occur.
>>
>> The current driver flows assume that the global configuration lock has=

>> been reset after programming the Tx topology. Thus, the same PF attemp=
ts
>> to acquire the global lock again, and fails. This results in the drive=
r
>> reporting "an unknown error occurred when loading the DDP package". It=

>> then attempts to enter safe mode, but ultimately fails to finish
>> ice_probe() since nearly all AdminQ command report error codes, and th=
e
>> driver stops loading the device at some point during its initializatio=
n.
>>
>> We cannot simply release the global lock after a failed call to
>> ice_get_set_tx_topo(). Releasing the lock indicates to firmware that
>> global configuration (downloading of the DDP) has completed. Future
>> attempts by this or other PFs to load the DDP will fail with a report
>> that the DDP package has already been downloaded. Then, PFs will enter=

>> safe mode as they realize that the package on the device does not meet=

>> the minimum version requirement to load. The reported error messages a=
re
>> confusing, as they indicate the version of the default "safe mode"
>> package in the NVM, rather than the version of the DDP package loaded
>> from the filesystem.
>>
>> Instead, we need to trigger core reset to clear global configuration.
>> This is the lowest level of hardware reset which clears the global
>> configuration lock and related state. It also clears any already
>> downloaded DDP. Crucially, it does *not* clear the Tx scheduler topolo=
gy
>> configuration.
>>
>> Refactor ice_cfg_tx_topo() to always trigger a core reset after acquir=
ing
>> the global lock, regardless of success or failure of the topology
>> configuration.
>>
>> We need to re-initialize the HW structure when we trigger the core res=
et.
>> Previously, this was the responsibility of the core driver to cleanup
>> after the core reset. Instead, make it the responsibility of this
>> function. This avoids needless re-initialization for the cases where n=
o
>> reset occurred.
>>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>  drivers/net/intel/ice/base/ice_ddp.c | 34 ++++++++++++++++++---------=
-
>>  1 file changed, 22 insertions(+), 12 deletions(-)
>>
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> See one comment inline below.
>=20
>=20
>> diff --git a/drivers/net/intel/ice/base/ice_ddp.c b/drivers/net/intel/=
ice/base/ice_ddp.c
>> index 850c722a3f..68e75be4d2 100644
>> --- a/drivers/net/intel/ice/base/ice_ddp.c
>> +++ b/drivers/net/intel/ice/base/ice_ddp.c
>> @@ -2370,7 +2370,7 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, =
u32 len)
>>  	struct ice_buf_hdr *section;
>>  	struct ice_pkg_hdr *pkg_hdr;
>>  	enum ice_ddp_state state;
>> -	u16 i, size =3D 0, offset;
>> +	u16 size =3D 0, offset;
>>  	u32 reg =3D 0;
>>  	int status;
>>  	u8 flags;
>> @@ -2457,25 +2457,35 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf=
, u32 len)
>>  	/* check reset was triggered already or not */
>>  	reg =3D rd32(hw, GLGEN_RSTAT);
>>  	if (reg & GLGEN_RSTAT_DEVSTATE_M) {
>> -		/* Reset is in progress, re-init the hw again */
>>  		ice_debug(hw, ICE_DBG_INIT, "Reset is in progress. layer topology m=
ight be applied already\n");
>>  		ice_check_reset(hw);
>> -		return 0;
>> +		/* Reset is in progress, re-init the hw again */
>> +		goto reinit_hw;
>>  	}
>> =20
>>  	/* set new topology */
>>  	status =3D ice_get_set_tx_topo(hw, new_topo, size, NULL, NULL, true)=
;
>>  	if (status) {
>> -		ice_debug(hw, ICE_DBG_INIT, "Set tx topology is failed\n");
>> -		return status;
>> +		ice_debug(hw, ICE_DBG_INIT, "Failed setting Tx topology, status %d\=
n",
>> +			  status);
>> +		status =3D ICE_ERR_CFG;
>>  	}
>> =20
>> -	/* new topology is updated, delay 1 second before issuing the CORRER=
 */
>> -	for (i =3D 0; i < 10; i++)
>> -		ice_msec_delay(100, true);
>> +	/* Even if Tx topology config failed, we need to CORE reset here to
>> +	 * clear the global configuration lock. Delay 1 second to allow
>> +	 * hardware to settle then issue a CORER
>> +	 */
>> +	ice_msec_delay(1000, true);
>>  	ice_reset(hw, ICE_RESET_CORER);
>> -	/* CORER will clear the global lock, so no explicit call
>> -	 * required for release
>> -	 */
>> -	return 0;
>> +	ice_check_reset(hw);
>> +
>> +reinit_hw:
>> +	/* Since we triggered a CORER, re-initialize hardware */
>> +	ice_deinit_hw(hw);
>> +	if (ice_init_hw(hw)) {
>> +		ice_debug(hw, ICE_DBG_INIT, "Failed to re-init hardware after setti=
ng Tx topology\n");
>> +		return ICE_ERR_RESET_FAILED;
>> +	}
>> +
>> +	return status;
>>  }
>=20
> There is a similer deinit + init combo in ice_init_pkg in the same file=
,
> which is the only use of this function (in DPDK anyway). Therefore, I
> believe that that code can be removed now that the reinit is handled by=
 the
> cfg_tx_topo() function.

I am not sure we can do that. We program Tx topology by taking the
global configuration lock, then programming the topology, and then
performing a CORE reset. We can't simply release the global config lock,
because then DDP won't be able to download at all. We can't avoid this
re-init, because after a CORE reset, the drivers AQ setup will be hosed
and thus we need a re-init.

ice_init_pkg should be called after Tx topology is executed. If another
reset occurs there, I think you may still need to do that re-init too.
There could possibly be a complete refactor that removed the need for a
double reset, but I am not certain.

--------------Uq4tkBYsdMR7YX6EuDFWogY1--

--------------HazwF8090YiCH1at8uIF60SX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLtxXwUDAAAAAAAKCRBqll0+bw8o6Nte
AP9UJC9ZYKI4fmQNRotDcs+wWYT9Bl9Dx1kl0IIQfSCQcwEAw4R7qLpmnMXyCm6UjgzEC4kOUeZi
yEWp4Y+MN049uA8=
=Vug0
-----END PGP SIGNATURE-----

--------------HazwF8090YiCH1at8uIF60SX--
