Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35675C98311
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 09:34:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 118DD4026E;
	Thu, 24 Sep 2026 11:34:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 56EC0400D7;
 Thu, 24 Sep 2026 11:34:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790242461; x=1821778461;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dsKYu9iLP89DsxY9TlPZNQhoQraulHmcFRBCbMofKhc=;
 b=eSrv+0pG1147r19/qLKnqZAIMo6caSmEsmFKACfMPJqR+7k6rg88xseN
 uWnp4AspsA+j+RrqjOdzQOqBpBDKCI0Gm5TONisjXqtlJNsiLyOoDflvo
 pyGOt2vTlLWBmbq4VaeE60lUYWrcFp34hByaWaXBnKxKZ78t5IANG10QO
 4ZDRgw40ppZMenUP7mU/aGrnT+yeObHntv8v3cgaTCgflcy4V5ugUUXHO
 iHlF6nLsUbfZJ5hwVjLx0GKd/GYr1Ev4Q06WQ11tMdD8QQ6vW1X+eWcJB
 jZipfxMk1cclfwz8G6iT0YwqZAI9s5/etE6Td5UGBC9DIWlsceW9+AK9m g==;
X-CSE-ConnectionGUID: 8OtRjPWAScqJPIjchIVlDA==
X-CSE-MsgGUID: +cXDIBvtSVSm+c/3HGHJ4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90234368"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90234368"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 02:34:19 -0700
X-CSE-ConnectionGUID: 47hdEp0bS0u5tsGecbKxGg==
X-CSE-MsgGUID: Q18ukvGUTwO9Gy8Yjq1wYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="274093369"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 02:34:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 02:34:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 02:34:19 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 02:34:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYXEBdW0lUn/Md+SxZ+ZbwommUGQuOhR5HHPtsHxGE09xVUMTd5HpGPAZMJZ79/DC/+YZgeojRZWkXIj8+4IZA5nCHA85c7xk/OqKO7TdfEy3MAAGqwyYerjkKE0poLQ9Gw+2+CvoRn+TI3CXlLurX6CVNbeVoRC+KuLW8pZZPrg4afJhnc1/8GRj7vy1wQfVvq33QqmK8/pllcmNqAUFNWvXCEjK3BorFd7AsyfrE29X+YAmv1Vlrwv1gFjm5JCjqIuWJm/WdoU04bPT9CRnvR5noAx0inQkzSWY/Mdfw7l/JzKoyjMpnvHo11BOMxexHesDRp7COp/cJxM3ziMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGJYO6LYa2qf/6w9WPUQ6OplBX1vshXDLOdyziTtP7E=;
 b=sDlGZcRCwbhDQaKxoQyvaVyVQ7/15oZVBAGJjoLF+2Aw6eGmTiH2rfLFAYHQRUtcv41mnw/59YrzmsW1VKddAYnkVVofeF3gfmNCres8fh/2vkiN41XSQ5W34b3NHPw4AA5ZT0PzpGWy7cNvMOZim1+y8Asj0k3aFqrl6wDgIZteFtj1KEtwBZck9Xy2lSb8oEutO/T5AUPwtfiDJ9cLIL8/d64Ii3FDIcGF7dHATW+Chm7eE4lGnO8djnYji1IdSLf4BW00iTGOfsQiMl74OPUWuyqrQlqCS061k0ATikD0wbwEXa/OJulfRProXT/euimhv/iBROdKA5OV8AkMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB7771.namprd11.prod.outlook.com (2603:10b6:610:125::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Thu, 24 Sep 2026 09:34:11 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 09:34:10 +0000
Message-ID: <c86e9c8e-7dc9-412f-a1ea-cbbeaead8bea@intel.com>
Date: Thu, 24 Sep 2026 11:34:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ixgbe: fix spurious MACsec event on E610
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Piotr Kwapulinski
 <piotr.kwapulinski@intel.com>, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, Carolyn Wyborny <carolyn.wyborny@intel.com>,
 <stable@dpdk.org>
References: <20260923112519.10600-1-sandeep.penigalapati@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260923112519.10600-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0273.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::12) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 2828440e-1445-42c8-6806-08df1a1efcf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4rAHcsvlHM6frNv8c3iVrcPmt74dyvCpB6yABnUOK8CRqLHIcAMUeae+4kfjpe/TGMi8XdHF2sHxfuk19f97xPb3CAJRMmTkS31UNASHNdRaTXuZkBSyYzrBRotk+bXqxl1Xo33S06Bq2fZvG7cWvTyym3xDHObnG6xKgM53Xg+nrwYur2tlr5v0u56K2X9nI+SqdKqmip1qqpinVS0VeJAbda+5jSDCeeH22zPTJ78bKefjYzghsmd/wnaVs5/RmEX0RB3jdRk5OpDUQIda+ijxdZ6YHeVFf0qR1y7obIgtBrSIW7fnR3CRdVyxjY9enKMKXmyHTzFLICg8bbHK+IePkS0FnKUu+nbQ7x0dOFz3Dopo5LYoxiMGv2ny23+aMsqRuw5YZIdnFe3jgwS0cbXFlVJVUEE6o/g+Q/7DFdU0uOW2QtomOEcCuh1VR1zZMqKARk8njZAKQEuomCZ0gF9JKPczpavVCV6vDPbjy+VzS56rMRkI4Zu86YsYrsyuTGDuEBUHQ1Uicxc9B7AG7PoaUi88NsOJ8heHQqFj5Z9+cbsRmqhqfs5wSdUpYD4lmdsxUe2GKL4bCwRRLoTbyxGNFIUMAWtblkhvZuVUe7wdvxchSHxywaJJYOyaLqadMuuikcCN77FzkO6j7pg5q+sHGocr6Q93P49lLnrY9og=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjVTUXJvM2ZESHRid3NPQ2tDOXJPOERVZjQ1bkthcEprWWlHYmVGYWRXdlpS?=
 =?utf-8?B?ME9EQUdEeDNyVWtMRDBqQ0JXRllQQjRBdVc5NTB0WG9tT2lTQUpqTTFBWDl3?=
 =?utf-8?B?Tm55WGNKczdJeGhBU2w0eWpqa1hsemdlMHRxZ0Y0Q25ZMGVFU0dPNHQzZm40?=
 =?utf-8?B?V2hXL3ZPU2xMNDFPbGRrUndhamFEV3U0NnNKc2JpZmVxcEtMMEwzZGRMZk1Z?=
 =?utf-8?B?K2JqNmxPWCtvR0tJRjlTT0gzRWJpU0xJc24yZkZzaURDSUljZ2hLdklSd09h?=
 =?utf-8?B?TG11SXM3K0N5bUpqUDgwVEFFTGxxTUM5dVlUUkxJNXYxTEZiZmpiN2F6QkR6?=
 =?utf-8?B?SW9vUlpGMUFzcG5HWWtCVTg0dVRTaDM5a2drVnA0NDNIdG5RQnlZZTdZZit3?=
 =?utf-8?B?TjRsNjlNaWI1T3JNNkVkWjg4dUVGSWIxMnZweE5VRVI3anA2R09WS2FDcEh3?=
 =?utf-8?B?QWN5cmtCSXArVWZDMlJ5bUVidlJSbVhJUXRHanBkUkw3bkZCNitjQ2JzSmFa?=
 =?utf-8?B?bXFjZkpkM2dqZkFBbmNzWVErYmdlSjEvaTk3eVQvcTV2QUwrMmt0cDkvZjVs?=
 =?utf-8?B?NzNpb1AwaFFoOXVqbSs2K2lDT2U5UjFEdjNQU1RLWmZVZFlrUlRGTlRNN0Z6?=
 =?utf-8?B?ZFJJZkVFc2dNbk9ER2xvRnQ3U3cyS0RBa3lIVE53bVJqY1g0aDhyRUpxeVQ0?=
 =?utf-8?B?STNtMUloTmJBQVpkVWJwWGg0N2RVM3JON2t2SjFZME9LZTYzS2RYcmxRV0VJ?=
 =?utf-8?B?WDNxRGJ5Rm1yOHpRNEU3UUkzblZ0OTBwU2M5YmZFQWZXZzg0N3MyYjY3cDJi?=
 =?utf-8?B?YkpFVXdmOVFrSmowdEZYZm9NTExQa3gxMHNwbmtDUDlLYUg0YTBMNGlaUC8r?=
 =?utf-8?B?ZVIyYXc3TVlVM0RRc014azY1T0F5WGNmS3hQazhwMjJEWm5KQnk0bGR3anVN?=
 =?utf-8?B?SjZib0JyRDRUWnEvb2YySGNGM0tNaDFCZHRONEtKZ0twQVhsRXVFcWQ4NHJw?=
 =?utf-8?B?WDFpcmlzZStuZ3VSaGJJMWZyTld1eDN4aWRIWFJTdEt2WHVzYmVjV0owUDBB?=
 =?utf-8?B?ZTFxd1lZbjJlSVNYSGdHdjVodWRKOFNFQlNRREdQcnphYlV5N0EvSXlveUM1?=
 =?utf-8?B?bWx1TlBCMUx6b2NHNUtBL2hKSDdGMGN2QitKakZ6SDhtaHJPNW8yQTJ1U3Ji?=
 =?utf-8?B?MXVPcitweTl2M1NsQzBvQ2lMUkRHZWViUW1jaFZVbml5WENSRXpnR3AxYVFF?=
 =?utf-8?B?NUhldU5iUkdoK1FsYi9ycW9wTEhIT2cwbTk4WEhxS0dqcWNwQlhMQXUzWGRn?=
 =?utf-8?B?ZjcxQ1RyV296VVA4UW45QjlTZTdXMFBuOXFkWHJOMEF4SmFRNnBxM1FEME1i?=
 =?utf-8?B?WmFhL09ZRDd2YUYrc3JqY2tldDFiWlptbFV4bUxQdmdmQjVhdTkrc1lqU3Ju?=
 =?utf-8?B?L05qUXFtNUNhdk5wbVBVSUdhZHdqWlFSZzAwSEFzempTYzhYN01wTXI3QTZu?=
 =?utf-8?B?cXM2ajRXQ3lFTGUyVmFVYmF5SEFrYy9LTzhMc1AvTU90SWpoT0FwK21VRmN4?=
 =?utf-8?B?VXRBek9LYnVDRGhzbWlMNWRrUktjNXVCNDBxNVFiNmozZm1qVDdyS2RENVVG?=
 =?utf-8?B?Yy91WFNOcFlQMWpLRndsUFFKSXh3ZFFyRlZXZ1BUZVZ1MDNyVE9KSHdtQndx?=
 =?utf-8?B?c1o1WDd2TkdaNTI2Q25sSENlV1NGcXMzM1BlbWFsS1gwaTM1MGNkZGJSYS9o?=
 =?utf-8?B?eHE2WlFWWk5DRXBiaHh5ZUNlQ1IwbjdVdE5GSGwvQXBlZ2Z1dFJWcDVycHVZ?=
 =?utf-8?B?czdpenNhZ2RXWnJZY2JmMXNhaTRQa3FmS2wrNnEvU2JZY2FZNkxxR2ViQVBY?=
 =?utf-8?B?WmRBbHRqTjBnVWVtdkpUL0hrTzZCQVI5MlBXTmZ5U0xWaE10T2FtMERwMjZN?=
 =?utf-8?B?TndtdHdRbzlQUkNEYlVUWU9KU1R4UnVVNFkxc0JQU0M5c1JZUUx6UVFwS2Z1?=
 =?utf-8?B?eE1xT3lWWTF5Q2t2ZHV2aGlUdjc3RGUyY0doWWVkdlFEWVZoL3BsenZYSkJ3?=
 =?utf-8?B?Y2FHRVptTXNkT1lvczFGMWVLbXVmYVNWbWV6OXhaV0ViSkhQUWU4dzNDTEFV?=
 =?utf-8?B?UCthMWdhSC9pVjVRSG1UdkpnVXd2NGtWNkNRYTBoRUZGdGJIY0JOSEgwZ2xQ?=
 =?utf-8?B?UlBCQ29BREVGMVV5OUU2NHRwRytoNjZoa2xaekJFSnVLV0pKRGR0VlEyQ3hU?=
 =?utf-8?B?R3ljZE4zOERqRkxYdlRrTGhJUGYrVDQxWjYvR3krRnNtUGZXQW0wdXgvdkZw?=
 =?utf-8?B?djBOZlEvYW5ZY3A0V0VMUUtCV3k4NUQ5YVFDWWFGZDBBNEZPZEJyai92VnFo?=
 =?utf-8?Q?l6kknQk8eBcVab4Y=3D?=
X-Exchange-RoutingPolicyChecked: 2C4ADUR1BLrubJkXGVhIc24zqJsV7wO59FIjy+PlOIoElqQM4k5jsXUSDAJCf+hqMeIv11i9/DC4SjmCf+d3s9qZ+sjD0BMYYMq3PQAVewoh+Ua3z0xyV86lixwSwU2KhW3SQY17ByT5Z13kTyfr8tZnIhcLBgO6uSWmgsw6IsJhWkxHg4B4ozmci1HEeF4Hlyuwrj0zOr6eHuELU0sE22BHtmNblAbVVrQQvjIg4b9+P3hNU1YYOtNh7pAV9XktTJLzmsF/eOMS68YAzedtnRIfQ/TWb4I8sGzwgVxRUFs8QpOh5Km5GdcxjOecoky4Qz8biVLYxF0dMhbRRx4Z6g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2828440e-1445-42c8-6806-08df1a1efcf2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:34:10.7573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWgBBIyunTmtuUyaFRHWLUWcCzf8q0r+WZ8fsUTR+8ujtiTae8On8SxlfHBCQs2dtOm/TcGOxjxGpR3ay/Q28Ix4ItD9x2ZVo0DDOSlCnRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7771
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

On 9/23/2026 1:25 PM, Sandeep Penigalapati wrote:
> On 82599 and X5xx, EICR bit 0x00200000 is the MACsec PN-threshold cause
> (IXGBE_EICR_LINKSEC). On E610 the very same bit is redefined as the
> asynchronous firmware event cause (IXGBE_EICR_FW_EVENT). The interrupt
> handler decoded this bit unconditionally as LINKSEC and raised
> RTE_ETH_EVENT_MACSEC.
> 
> As E610 does not support MACsec, every firmware event (for example a
> link change) was reported to the application as a spurious MACsec event.
> In addition, the firmware events posted on the Admin Command Interface
> (ACI) receive queue were never drained, so the cause was not cleared.
> 
> Decode the bit per MAC type: on E610 treat it as a firmware event and
> drain the ACI receive queue until empty; keep the MACsec handling for
> the other MAC types. Link changes continue to be handled through the
> existing IXGBE_EICR_LSC path.
> 
> Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
> Cc: stable@dpdk.org
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---

Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
