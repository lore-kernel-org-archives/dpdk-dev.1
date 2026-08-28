Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A47BC61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:32:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D63140151;
	Fri, 28 Aug 2026 15:32:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id D292340150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787923934; x=1819459934;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=OLOi0310P0swTf/B3iLo1dZy4UKCu7EWtKKZHaQnq18=;
 b=ZAKrJkWQzgRQhVbwM8U+V83zgKCWTIEtqwSxUh/+pkm7XUpF7aD6ABgI
 qWeA4vWt060aLCrSRFqd+L7ZJmP0kkub5xkzqT3rKVPPB91X0azjk8Oa9
 JxDFLXkSrpAz7oqBfMrWp8P9z3Vgf8IDcNZQUHaFTnxh5wQWsEUILZafr
 o/5kRvH6SwLGQ3g6Id8OqIIpXQFpJsXhMH4hZXjDQqjFj9lU0utKe+/g2
 P49pnMBZIE+wq9HRnuV0qGI1tFkNAtiK5E+JioWIGohBYOKO6pl7UJ8/8
 5EmA8f8zCYOO4t6GD9FAUokekAVVJpzdhcQnEBpGOm6qlfuQahVuWk0ew w==;
X-CSE-ConnectionGUID: vZrpMV+SRaiIXklmyexOdQ==
X-CSE-MsgGUID: KG6kwuO9SNGswUjpHJbSGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92297546"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="92297546"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:32:13 -0700
X-CSE-ConnectionGUID: szUeBnfTT5WWLZD74jaZbA==
X-CSE-MsgGUID: pE5VFt+1SnmL9zZZnOuJYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="292977557"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:32:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 06:32:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 06:32:12 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 06:32:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksSZAlg10sXWK1ic+wNy623DeOaniGu+Zm4/bzs1eN+vdZ57TS0q3u/KEMbW38t7QrjVqw3acJsqN1GiUbvcsjXkNlJb/hHDPludt8IQc6ePT8IcJxKmb82Szxz9BqsSdfSmf9ugwFUtWX+DXR+Sl6FUFVPq/rUOO1hOUm54FaUlD5P6HZKR6PfN4o/fSgZe4V73vTTNPRvxtPtbgO534XLz/5BuFezUo2A5udpvGHFW+ZoGbJ3Gxx8S9Hudv+0fYoJFIdDG3DSs/kH1+rPpJMVoDu24PFs+MAccuF4AT5sOAnLqStfgrPy3YnLADF/C6bLIBvNLLQQ0jFoJ/mVPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb3fgjFqmB0tqo9x8SLf2bTvUUOXCkr4VcMaXRXHchs=;
 b=E1GFoLNKJwamsiUV1VZm0FXHSdhzLRxLeJAjoMvgDlqMfR42FdicDAXx2ENZfW+mIczM3Pcm3lC5exjWbrorE39Xa99ZpBcv/OZQWMP27klNXSkMHwYrjg8/ci272kTFvvfFCPr6YwTTngOiFydD1hkFP1CLSgSZlbCRS2yYsaLGQ0DZIpNZbA0VAXN/hKOWDKvLpSwMEn/XUzikk4hZdRd1H4XDTKqRKuV7RaqocHws9OaWND0F2Zf9y4VJi3BwlwUodjMyhSfqNbXt0VEX4yYN6rLP+N+K8u6OQ6hP592YBgLtzMOPJjYic6ahcMFt7HZaXzrniPX91CW/oezONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LVWPR11MB9881.namprd11.prod.outlook.com (2603:10b6:408:3be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 13:32:09 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 13:32:09 +0000
Message-ID: <be8bf34d-b67a-45dd-81fc-6b4a71426536@intel.com>
Date: Fri, 28 Aug 2026 15:32:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/25] Support VFIO cdev API in DPDK
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <cover.1787922362.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1787922362.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0201.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|LVWPR11MB9881:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a66c4a-5d32-475e-bd3a-08df0508c232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /cSAZzupwKpiw4KZZy6nYaqxMz5vrrXk7R9UMLp5+aP6n0w5rofbeQi8n+qAA62VqVrGqpkhGhnHHfnaxCaR1r+zcvrLa2jojhcOPyK8HLd0Mp4OvX3i9p913DfDi/o1eQfMsA6BYK7DSRQvs+K5JO8M+B57975eGk1rTq4TgjIup3ft5Rclj+I8YjJ7+cNBRNWLkx3okYMtO44SOAiXXbpnCSVyiTTbjPkKoR4MOZHAz6kUQKPIbnifgFmRrIoJcIQNtrlHg+Xks4UaPDo4huhxUpz44tWCnDNyljrhaP7tiMcNI+DoqGme4zvS8RwqJCSjgVp9c06wYKu+OOFQhkl7QTLEDmlhAdMn3Lx+/ctV9zMvdaJ30UB/F/5B6j2qcEhENbTlWXyFao5HeU9Rpzt/nCEseSDgazn7L2SRNgw6rU2BX35xR7d2khPjL9dF4r+rfCEinZsba50Khlb29Nvf1XJOfsdE5eCUSOxK46UXMIduO0q7RbgH/yrgosY00H0VDI1szzRO+mT/TKNcPa12CMOjOdWtMeWvT0NZIifn6jw7ILpV1P1D/R1rnFhqPfShm5PGhEfg0GyKbusnhyRcHj+G+xCKGMhYqQomBpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDM5QkRvS2R1WjlZUS9IeGJSS0RndTkzRDdWYnlFa0JEUmZvZEV4cGZ2RTNz?=
 =?utf-8?B?QTF0SDFOOFNxOE5QaEp4OGl0N1FUSStxOXZTSElSaExXMzV2T2VncUFqZXdG?=
 =?utf-8?B?bG9OTXZyN3NxaldXWTQxaERwcFdJVllqU3VQNjVKQUFPbytBUzVveDd4TmVW?=
 =?utf-8?B?azFBd3JaNWR2THRRdUlMS2ptRytjTGtnSE0yUHpWblpCc0w5dUswYTBCM2Vh?=
 =?utf-8?B?blNwWXVKNkJDVFlPSks3YWxlY0RiWXdCUU9EZmZDN2dCanA2c1RGbk1pbjBv?=
 =?utf-8?B?b3VOS3RtaXBOekdWL0g2ZHBMVnhudlZTa21vSWxLeFJqV2NucWVDNkV4RGM3?=
 =?utf-8?B?aFdJU2IvZHVhT2Q5eWV5MU1oSWlnNmVtTjdoL1lDRnhoMVFQejlkV3hZZ1E2?=
 =?utf-8?B?eGN0bWF4RVN6Uko1NVRhc1RLd2xUOGxYQXBwaVFocEJ4eExwSE5GVWZkQnVo?=
 =?utf-8?B?Z2lHUnd0cmFpM3A5cThIKzBtR2I5bGZjdCt4YUZoV3FHOTJzbm1aZFd6TkYv?=
 =?utf-8?B?MG03UXZuNlZaTWF0R2c4eVUwcHZGTDlmaC9uNzNQM2ZHTWkwb1o1aXpMZS9l?=
 =?utf-8?B?Z1VXcTMrRnk4Njcwam1raDk3ZGluNjVoLzY1VEN1emlhUUk1cjdZL3FkNENu?=
 =?utf-8?B?SnIvWncwTkZ3eHg2YjNuRjV6aDlSRG1xV1kxdFZPWU40MHlqMTZIc1RnMksz?=
 =?utf-8?B?WkdLVXdNRkQ0R1g4VlZ3ZEhJYmllNk9yL2N4VFRQR2ZiQzMyVVg0czgwTlpp?=
 =?utf-8?B?R05DOGpqTGtBeHp6M2ZwYXVFWEdaUFNxZ2M0MFcyS1lIZjJlaUZTL1l3MHpY?=
 =?utf-8?B?VmpVR0NRdFdhL1VRRzhnR2xSRXpNbzV1UzNFV2ZWRjM3dUE5MVpTTUlrVk91?=
 =?utf-8?B?dTQwQzFLSjBROVNmUUdNZUhReGtVb1c2ckwvaUVIeERLQVlvRU1nVGZlbGRQ?=
 =?utf-8?B?cmNpZ0tEZ1RCSysrQUluRlZOVUpYVFhNcWNOT1pNd0l5QkMwVkFENHVaZDhV?=
 =?utf-8?B?Y0I3MHdhRHk4QVhKc1hLWkppcHl0dWhSbHptUXZFcTM2MXZDVG9SbGJCTHhC?=
 =?utf-8?B?N1ZaZThRZmtZMlFFVk1ZWHRuVkh6d2dBTWJzWEw4TEFpdm4zWDA1dWVMa1BP?=
 =?utf-8?B?bHNXc0NZVVRxQ3JqNHZjRVhiUWwxVTJVQ2drNUI5UEJQTXVMWjlzTlJyc2pJ?=
 =?utf-8?B?M09saGhPZ0dVUDRyWW1aU2ZNY2VsK0VpanFwajA3NzJwYTdkdzlKUzFoOVJC?=
 =?utf-8?B?b2FLVVZmQWJEbHovQjZRQkxQZXQ5cVFJM1dNWWx6K0k5K05nK2thSFkzZGEw?=
 =?utf-8?B?M3ozVUZTaGZ3djZUR2hBN0UrUlVPV3Nobmptdzl2ODBLeUNyb203YjBDam0r?=
 =?utf-8?B?N0w3NzIxckdjUTVoenVSOUIyT0cvZDlaRDJ3YnVqVVlONXhqaG1TTEdlaWth?=
 =?utf-8?B?N2Q5OUJjY2dLSXVKelh0SnJtT1A1azJyVnhXcnVyVFJsQXBrVllxL0t0bzhJ?=
 =?utf-8?B?cjJ3aFEvYnU4cG9scDhORlZ3V3B1eFB3K2FTSUNZR2svUFpYUnpLVWZUeWxw?=
 =?utf-8?B?dThSNmRCaVRzMlJYK3QrT1hkRTVyZ0hueUNpZzJqZVY0YTFHS2J2b1F6U2xI?=
 =?utf-8?B?bTZGMVpNbmErbkdLL1hzQUNvcm5nWTd6aXhJV0h5aWRCQ3ZaVllmOGJwVkNz?=
 =?utf-8?B?cnlQbE10RFVTNkV1dURSQ3Fvdm00YXE0OG9aaFFseXo4VkFSRm1ndUxLVDUv?=
 =?utf-8?B?R3V2dDdvWlo2V3lTWVBhNGpWRXZFcUV3cjhMa3QzNFJOSVFvQ25mS0dtZzBC?=
 =?utf-8?B?eWl2aHFhU3ZYTEMzKzVZQ1FVeHlpNjhweFR0L256YVA5S3ZwS2dtWW96ZG5H?=
 =?utf-8?B?eG1NL0sySHA5MFEyT1RVWVBmYVZaTmpjQitQQlZWNytPVXd6SkVtaWhTNTVQ?=
 =?utf-8?B?aTEyVFptejZnM0UyclpXdkhFckk2S3plUGtHeGJDZWp1QjE4VFRjZkt2UmRB?=
 =?utf-8?B?OUNMMTJ5NWJmNTlPU0ltNDl2eHVaSUVmcG94aDFrNWdXYUlZbzAyUEZhS3M4?=
 =?utf-8?B?M0pjaHlZaytiMCtHVStlalduREM0aGJzdDY1QmpqVFpoTnIrYXNtSTFrWWlG?=
 =?utf-8?B?UHJkUUoydUdQSndtSC9BVVlaUFN1eTRDMzJMRzhWVlNOTitrNDFla1gwOExz?=
 =?utf-8?B?Y3NQL0h5Sk1Wd0hSOWczWGdUV3pVNFppM2dTai83b3dRMkRvMm01eFdIRlZB?=
 =?utf-8?B?TWNKc1RNTWxhamdhV1BXWXBpL1F3OFp2bGdiQkxva1poZkdwUG5NbVo3eTBa?=
 =?utf-8?B?bEZiQms4ZllNQXNBZy9wRzRVRlNwRndNWXRhVzdrSFQ0My9UWDZCVHZBTzJT?=
 =?utf-8?Q?kuTC18txYf/iJQlE=3D?=
X-Exchange-RoutingPolicyChecked: XDIgSRCfHXCipgjJhp0LskowkYA7tN2zmmzjrMmxD4FSJw322kcq8PWEQhBheLYIK9CJAcuhgcap99NY35ngMp3zi/BN3nY2KkQICtmyUH5TJtaCue5xMi7Fh/ZJGphdwVqYTfFcneePT0Pu9QhIhQCYzgqCXuItQF+Get4zvQ37A6WRhu9tZDTS67hsLLm8BYNEkmWaQb8jVjucuBUhC1cMg4Nzb1gbd0TEUVI4KTNDlJo1bMU9oopniGGrlr8H2nWm4Onx2A89ZStJVMUBRwY1uZ5GkZdouvRRDV/fLtMCZ6VgJTDJX7ls55C3Efi90AeajbhaTM332x/u5CXOjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a66c4a-5d32-475e-bd3a-08df0508c232
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 13:32:09.0160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5G3kemTcpzf1og/BS9t0I+IjUsNdqiynP7qqsPgmwqcoWZzDuYbQFldqN0+BLqTvravKAPNbUtnZNT1ce1V6SwR5aXtWHF5Of6YcIDpN48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVWPR11MB9881
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

On 8/28/2026 3:06 PM, Anatoly Burakov wrote:
> This patchset depends on the following:
> * https://patches.dpdk.org/project/dpdk/list/?series=39072 ("net/nbl: fix use-after-free")
> 

Question on CI: what is the proper way to specify patchset apply 
dependencies? The first patch in this series contains a "Depends-on:" 
tag which is supposed to trigger apply of that patch before applying 
this patchset, but apparently it's not doing that. Do I also have to 
specify something in the cover letter, not just in first patch?

https://doc.dpdk.org/guides/contributing/patches.html#patch-dependencies

This page suggests that it can be "commit log" (which I assume is 
patches) *or* cover letter. This can be read as either being valid. Is 
my understanding correct?

-- 
Thanks,
Anatoly
