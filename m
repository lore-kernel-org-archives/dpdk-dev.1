Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E70E9E311
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:45:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 970284060B;
	Wed, 11 Feb 2026 16:45:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id C1FFF40431
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:45:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770824756; x=1802360756;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=aIASTwhLb+UjVhXV7pO9HAPTI6vUJDhGNJVFkY3wVlo=;
 b=WR3J+/U/lc7+uxBIG6H96moBXMm44dYu01BMVNqAu7Tjp0GhgMNXUs0R
 LUERaIA8XtBteNrHIzu1dphzcYvmhRQR3E/aOFtedFBCR8UwE4LDkf32d
 GIb4bMGmyMlFGq843BLr20SU30EvpkLtdNy6oBRvFMXqYvxaEliR41s4N
 CqRv/aUgWg9ZnqdaPK5W/I1CJBrNBSxBuTMqzUus1R+0CU3djcKYooNtT
 z8K9F0ixjeWLDMFHxT7+6lS9fB+5+akPNMHd9FoFBGCtOmIMeVCS3+hud
 flASqqB91bgjwnM9l/R25DdKw2mfLDkSbnjYWOf5rSjwpIILgyJEEzC1l g==;
X-CSE-ConnectionGUID: Zvf07QvuQfu9+kvQV/bJWQ==
X-CSE-MsgGUID: Z5pXwfGeRDmmozrzaw73lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83076554"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="83076554"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:45:55 -0800
X-CSE-ConnectionGUID: 8kkH2DXNTuKdp3kYs35ZbQ==
X-CSE-MsgGUID: cXflXakDRJKDQlRxwcsB2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="211324488"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:45:55 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:45:54 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 07:45:54 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:45:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U94LAebX8MCSAZKauoF8ayZqc7m6En4bBsRgNYEhfAv/G77MgeK9WaeBunrDXkltNgkHBJWqfNi3IuNspduPCtPm7PgGqIpuNcqe73LZRK2HBZvyvsaFmPlkOVQt6jG8NKwHMujJxoBLhX/RWQsNccVzxkjYa1laBWHgkdWRbOJK9qVy6RVw7TiVYXUet6h0GALPz4r92hqFSIj71iobAS5cGc9uOnVzoourddR3b1Anb6V2NNkEHcoxBiN93vZu/+LCW0JkPW6p1hFgXDMZt+C7cjJ4nvGR+dTzuagt8/XFcjYDtQ5f+U+la565JoBB2gUcmCPWb1ihNHTFhspFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV+jHcJZeHYDEl7h6uaiHdYCgem/B0LMEYvRDkr9fL4=;
 b=w2Q9NgawN9fRDaPlLO2zhw6cjVcHEmd83AJxCKR7CUS/7tri06HHpu017sHSIUHhwc8u6i1VlKKCO4HgDPvNoMn/novLGg8wb9VE/bZJvWNTkh+JmJOTWqT0Gq+YUywUdPv+MJEG5a6H+fmW/DSgZPG0GjVpn0qwjjTCa/mTLxxSlqtJINBgJygtPzmliejSrcuCUu0NeA3sCujIJ9Kr56LMriyCRn90l8gEINsCtnKU1uC/y5fJkVRE/fCEiwXzGdgHEL6hpWiW5PzvxvW41Jui0JS/P5Svs4ymO8q9y5jDjBhzIXpzVV7F3k7A98v83VU/D5+w2xZTGpAhKabp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by PH8PR11MB6660.namprd11.prod.outlook.com (2603:10b6:510:1c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 15:45:52 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 15:45:52 +0000
Message-ID: <711c0fa3-3779-4f84-a7ad-f17141f141e9@intel.com>
Date: Wed, 11 Feb 2026 15:45:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] net/iavf: fix memory leak on egress IPsec flows
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, Jingjing Wu
 <jingjing.wu@intel.com>, Radu Nicolau <radu.nicolau@intel.com>, "Declan
 Doherty" <declan.doherty@intel.com>, Abhijit Sinha <abhijit.sinha@intel.com>
References: <90b6ea2f2756de0a9865ef53faf9b529dd570baf.1770817694.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <90b6ea2f2756de0a9865ef53faf9b529dd570baf.1770817694.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0040.eurprd04.prod.outlook.com
 (2603:10a6:10:234::15) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|PH8PR11MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8aea47-2b96-4543-803c-08de6984a27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUpJZ1F5NzJBMjBSV3dtcStZM1pJdk1oWEJJakk2b1BDcTBtVXplT0EyQjh6?=
 =?utf-8?B?MjZmNUY5dGVnMmE5Q3krLzdDM2tSOG9JRkhKVUtTS1ZQZktoQU1ZdGZNMnli?=
 =?utf-8?B?NUlPelVIQ3BKeDVVM24zekdJcU5abktYN3l3aWNRVFRCZUtCV004MFdTQTl2?=
 =?utf-8?B?RXZ2U3l6Ny9MNHF4Sk1oNjdZcjRmU1ZIUFdPclhLanVXbE5WT29scnpBbGZV?=
 =?utf-8?B?b1JjTnFtV1hPRVFHRFZieGZmUWZFSmlmYnFaMHpyVkFtaXVnalUzZDhNNDIx?=
 =?utf-8?B?a3ZYRURMbm9JcnNtSGJWeTI5Wmd0Z1ZWUTg4MkNGT2tDbUwxN0tVdWVndHB0?=
 =?utf-8?B?M0M0UmhpMkwzL3FwQTlONFhGL2FvWmF5VjIwMDBKSzh5MEhKT1VmWHc3c0Qw?=
 =?utf-8?B?M0U4dWdOQUlHM0NvQzlpTDJKbFZ0VkNJUW5qb2toOXFQVWRUTXdseUhPWllD?=
 =?utf-8?B?U0pHaVIzRGUzN2NZeHlRQzFtTnlXVDJBaDlZYi9RRXdwUlh0VXhTcndOcUl3?=
 =?utf-8?B?alcrVTlZWGRmRHRDbDZwai9IbWhnN0tiT2NQKzdxdTg3TGc3algwMGJCcGQr?=
 =?utf-8?B?MFhsSTNWbDBLUXRXK1UyQmE1bk4wNTR6ekp5VFdOMTlVL2x4Z3grVG5LNkNu?=
 =?utf-8?B?bFFRTXZpYVpXM0VKNUZaMVFOaGdUbi8yVzhIajB6VFRNaHczK0JnQlAreVFM?=
 =?utf-8?B?RWNhd1JiODZxd0FhcUE4T2RVeWs3MERYZ011dis0OFM4M0pPN1JvNVNpQ3dK?=
 =?utf-8?B?cHBmcS9FS2h5UjQ3TzByaG1tRVNLZkNTdGhvaEgvQXlOc1draVFHZTAxRGp4?=
 =?utf-8?B?aGhDbU5NeTdiWTJsa3VFcHVCY3hrdzZTVm0wVWtSWkxFY2FZVWZlQ0dvbDg1?=
 =?utf-8?B?Y0JnWS9lQVd1U2tXZU1OcDU4QlhDdzgxdmFzdmxPaXB4SElPOW45ZDlnT0Ex?=
 =?utf-8?B?bkNNKys0Q1NNaXRYakNVMHpPYmJ1dEEyMFI0SyszMjQydlFROUlLNkFCdDlQ?=
 =?utf-8?B?ZEJhSXJSUFkxWThlNG01TU1FTFZCc0MzcXRhcEo3WEtDOVFYbURJUlFNc1ds?=
 =?utf-8?B?alIvNVYxZkVVWUUvSEpKOVhIRERKWGozMWQ0RHRDZGxUYWVvMS8wNVU1UjVX?=
 =?utf-8?B?aCtsNnBTYmF0WForUStzQmlQM1RrZFN1MDBrQ1BxZkZrVEdoV3lmV1poWE9s?=
 =?utf-8?B?bUU1aHdMbk1ZUmN4dVdFaDZsUDk4SWZhZ1VCaEJDNlVZVTNNSExzc08wZENj?=
 =?utf-8?B?MGtma2NBTE8wTnlaa0FsdkhwdHIvc1BHb3J1c0RTU0hOLzVHeFNnWXJhcGZF?=
 =?utf-8?B?cFlJTzBMTGxUTVd1cXFBRmpFb0I0endxNlVmc2RFeEp4ajcySjkyR2tRQUR4?=
 =?utf-8?B?MS9FTVdsSXZFSmdzNENlWU1oWWExQXVXdDVsejd1L2hiL0h4V0tYc2FmSmlF?=
 =?utf-8?B?eEVadkd5RWozZ21YM1Blc1FvZWJuRkV0ajduU1VKMXRsQUdKUUVDUW9HajhV?=
 =?utf-8?B?bUF2aUZaZVlmNlhhMVdwbUV1N2szQ2g4V1JIejg2SVV4ZXJQeEVQTUhISzdr?=
 =?utf-8?B?ODB4TXFOUVpiR2JienArS1NYQXRpU01NODdCNDMwRmdkUEt2Zm9TbUNMdC9H?=
 =?utf-8?B?S2dIMkFZdk9QMUt3RTRlaVR5NTRzQ1BNRmc5bW1OOTk0empoZzhKODVjWWhl?=
 =?utf-8?B?ZkZyb3RFRjJHY3lRS2FvMlM3TGVrRVUwNE5TNVhMSUJLUnFBTjRIQ1R4bUxl?=
 =?utf-8?B?eXZCTWZBTk1UWnY3Qm83cnp3L1J3OE5WVFNUUzVqdzArWU4xSmRRcENlNWUy?=
 =?utf-8?B?VDFGblVsbDEyL3pUa0hRMzRwcEdab1VFTUxIZjFTSlZGUFVROXR0cTRiUndL?=
 =?utf-8?B?VUxoR1U5NG96d0UxenQyR3EyQTdFSFZuSTFzSnVmaG9URG4xS3N2dnRRcmJC?=
 =?utf-8?B?MVhpRVp1WGNwek5vWHZYRTVYbzZLdGxpSHdJcElYSW1iSHp0anpQZE5hRFlh?=
 =?utf-8?B?RGJwWU1nTUxsT2wrd2xZT1M0R3pEWmYxTklQYWI5ZUxBWXdRaUFIRzF0RDg2?=
 =?utf-8?B?anpVNklHdGFvTHVIdStlYi9lL1hsWG43Yk5HSGczNnBIeWpPVlBDdEMrNW5V?=
 =?utf-8?Q?YR3w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzQ3b1loUi9RdlhySHZ2L2J6bVpyZzhldDc1WUZPVXFpQWpJbi9JbzhLMzk5?=
 =?utf-8?B?SHNJeWVFTjFzdUtFSjBrZDRZejA1Q2hMQlZzakh0aGtsUmwwSFgyRXo4UmVH?=
 =?utf-8?B?VVVKOFJzVlNBUENQc1pqajI1RE5DUGR4TFp1dk5XZjZnSkVzalp2YmdrODhZ?=
 =?utf-8?B?dzZiejJLSHVyaDJwVWdpaythMXNuY1dJY0xPSzRhUm1ZTkkwRnA3d3FjQW1O?=
 =?utf-8?B?Q0FoUzFleExKS3JDS2VObnc1VWhiQWx6VytzL3JXREwyWFFjL3F5aGFETGI2?=
 =?utf-8?B?VE1DVC8zbzd4ejc5NmpaTE5ub0h6b01XZGZTVlFMYTFyV0Z1UVBwL05odEdM?=
 =?utf-8?B?ZGs1d0lnc2g3TlNZdkV1TXJCSTN4TTRNU2I0VEZuZmcydlhTaExkeW54NlI2?=
 =?utf-8?B?OUlmYUs3V1F1Wm9IQzdjSjNsclg5bmdWZ203Ym1hL05OSHkrZEQvbTlWbTh2?=
 =?utf-8?B?eWpEajNFSzBNTzhWcjNHNnd1L09acEdUWDVPVU5ZWWVCSTdUMkFIWTlqSlNG?=
 =?utf-8?B?QU12NEt0bi8xb1RwTGwxVGJjUG1YeU1CeEZKczhyWWRvK1VjYmh4MkMvQVZR?=
 =?utf-8?B?MGhjd0J5cVRCaWpRZUZFZ3B6Q3pTZU1mUFJqQ1ZVUjlESVg5ZGpjUlJsS0tj?=
 =?utf-8?B?cGMzQVplQ1htbzZnWXNaNC9wK1dpeEFOVHZOQnlEVjZ5YnNPK2cyNzRxdi9T?=
 =?utf-8?B?UFhoS2FOM2hld1krS0pwRSt0MWNXd1M2V0d4bTVLc0h1TU5IMDEzOEJJQ2FR?=
 =?utf-8?B?M0V4NFQyYnNQVEdSUk9sTDExVk1LVitRWWNSR1ZCOWRyMFd3WEE0SHl4cmRH?=
 =?utf-8?B?QTAwQ2xPS1VFZnFwSXE2UTdtWWUydWQ4UkdHd0ppdjlwQXBDbVczYjdYMEtY?=
 =?utf-8?B?Q1kyWERxVEtxak0wcU5nY0dUbTdJbElGTlBxR1Fva0Mrek42YUk3SU1IY3JV?=
 =?utf-8?B?QjhXekJoQXRaKyt6dnVud3BGZTRXT255VGI2dUlUNXRxN2k3TzlTQWNrYk42?=
 =?utf-8?B?WDlTcmRRTDZGU2tiQnBpZVJGL0hxNkthS093cnRFam5DMUNjS1pWZFZmS0J4?=
 =?utf-8?B?VDFQcHJsS0Z3MEpFWWhQT2ZnbFJ3UjUwaDUvM3pISlMwbFFSTUlyNlMxbTlR?=
 =?utf-8?B?NFZGeHhuRUJTNUc0R0NzbEdBblFsUGc5dWl5aGFOa3owTDA5V0cxT2pkdDNU?=
 =?utf-8?B?LzJsVm1NNHFheWllYmF2UE5tZTFjZnpMK2ZhcnU3VmFKV3gzVHVlZUhsb0o1?=
 =?utf-8?B?Y0V2WnlZQ21SQy9PSlhadXY3SW1hNUZkck94YkZybVd3SU5ybDQva2dDVEtn?=
 =?utf-8?B?cFhTV1RiNjArSGNzQTZUcXE2aGw2dXQrYUo4dzRNSlZ5S1pFdlllMmNTZjF5?=
 =?utf-8?B?WFR4Q2YrNWt6d1V2S1VjRzNmVk9iK1d1c1dIcFFlTzRoanhPaXZnN0R1RUJh?=
 =?utf-8?B?QTlWdXRNZ256Z2QrWjlNTjliVjRzbE5LZ3lDYy9na3lrZThvOG0zay95bGNU?=
 =?utf-8?B?OUZpWmNZV1V6aXo5TTk2Q0tmcDdUVmxIenVhem9CQ3Nxdjh6QlppK3VtL2hr?=
 =?utf-8?B?SVl5S0ZEVWV5OVp2Nm1kdTdKMHh4NnF4MDdwWEFvY01FUU9kZ0R2RkQ4N1FY?=
 =?utf-8?B?empRaEFsOFB1eko0QVhQTTdRUFBqL09oVGZjNjhFRHMrSWsrb25FSUgyRFZP?=
 =?utf-8?B?TFRyVEwrWGFSVUg5djE1QzExY29uMVlhUnpKQWU1U2F5WjRBTk1nbkx1ZXlV?=
 =?utf-8?B?d2tjaUE2azBGWHpHWWM5THpsV2xrTHpNanBjMUNJam9FMGIrUk9jeGFtS0tI?=
 =?utf-8?B?NlJrM1hpTWZnT0tiOXp1UDlvUnpDY0s3UVFGaDJJVlVmZFZQTzZzMUlkcTg5?=
 =?utf-8?B?T0piMzd0QmI2VXV3TlplRTJqTWRtUzl6ajFiZkp3V2RvbmRKQTVvV3VESjNl?=
 =?utf-8?B?NTBEcXZuOG9yVlpjS3JVaFZRdDFXU05QRE9sRDlhZ0dCRmg4ZVM0OExiMGVw?=
 =?utf-8?B?UmdiS0RGUHFiNDdmQ0d6bWU3ajlBN2FFUFFIemtFYTNJaHF1RFJabVpUNE00?=
 =?utf-8?B?NFluTS9hMFhWeVhEeXh2eHBCcy96S1hxMjh1eU9ONGRYbWIvdDdWbVZSdkJt?=
 =?utf-8?B?aUhlNUdRSk52MktySnZFckdXRm05aXVDUmhpQzEvWVptM1oxNHJtcndTMTJM?=
 =?utf-8?B?c00xcjJ5cXRISTJISVZ6V3FLSkgwSHV3UU5qbmthZ3hEVFAvSTJETUpTa01S?=
 =?utf-8?B?WGFoM29NZXU1cGVXOGVZNTdmdkxMNGdwTzVGZDRqWjF4SkZzWGl3aFYzTUsr?=
 =?utf-8?B?Qkl5SGkwV1l0ZnNSVW14dmVKUjVSN1VuU2l4RVlhaXg3OG1VaERDd1JveElG?=
 =?utf-8?Q?R0DxqVcdmKfrJUiA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8aea47-2b96-4543-803c-08de6984a27f
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:45:51.8367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YW2+69+MgxmswuaWMsj+FhV43r2jpywa70uh5e7McgZwIdFHPAj7YSEdHSWT8r9WEBbu0olCZ5TCrCDAKQA1+2hWGvzbrdXj7ekweF69jx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
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

On 2/11/2026 1:49 PM, Anatoly Burakov wrote:
> When creating egress IPsec flows, no action need to be done in hardware, as
> this is just a software association. However, because we do not write
> anything to the rte_flow entry, subsequent destroy call will not destroy
> this kind of flow, because it expects a valid engine to be set for every
> flow. This results in memory unable to be freed back to the system.
>
> In addition to that, when creating these flows, we do not actually store
> the rte_flow pointer anywhere, so even if the user has triggered `uninit`
> (which would have freed the flow), this flow isn't in the list so it would
> never get freed.
>
> Fix this by marking the flow as egress IPsec flows, adding it to the tailq,
> and changing the `destroy` code to take all of that into account.
>
> Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Radu Nicolau <radu.nicolau@intel.com>
> ---
>   drivers/net/intel/iavf/iavf_generic_flow.c | 30 +++++++++++++++++-----
>   drivers/net/intel/iavf/iavf_generic_flow.h |  1 +
>   2 files changed, 25 insertions(+), 6 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

