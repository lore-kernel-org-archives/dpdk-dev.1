Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B662EC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 15:51:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CA5A402DE;
	Thu, 13 Aug 2026 17:51:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 18B8F402D3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 17:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786636268; x=1818172268;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4TuVG0Ltt08z63d0TpXOzf1xsQt1bFX0C4dGLUClpfg=;
 b=XkvGTq5MOpdvbxcNFGhA/JCugcJb/vhBf4f4M1cnRpCT1f5fHnTyiaPD
 pN/R2oSxgG2BYucnnj668pNy1WfcEjCLMuyuBiV5zuaCkYEutPYsMbu9Q
 IXcDtpuQZlgwwrAsaxiJMuN6Hvlk49cxj/kcLzXYwfsbZ8CkIkauL99Hx
 GbW6W6LAnOom8fYdt8IKWG4MB9MSw/RXib9s8yuWfiV10zYbZSpJxWVnj
 5YDI7UHSAKhSQyVxwgIdSBWSJH2+ZjFjuXRxqgbQRsz57/2HoHu29UuTo
 8JcsiFAkwtWG2VGywXyxTekmXjgHoDKrbhb+ApOQfi2x0DFr5Z8gwqxfP A==;
X-CSE-ConnectionGUID: vI+K4h4NSQOJa4Ov+8Z7mQ==
X-CSE-MsgGUID: zm9YMVtYTjCOB/sm2dhy0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="74751277"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="74751277"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 08:51:02 -0700
X-CSE-ConnectionGUID: cymC/A5aTYGQ6vTLK9uAtA==
X-CSE-MsgGUID: uZ6DGu5zTZOsei281Oq5NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="259723210"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 08:51:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 08:51:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 08:51:01 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 08:51:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iW5wPGs11n7lPLz0iGNR3QhQTuxMT/jD9itcXxqbaXgIL6tSW8NaRSUAZFcZ0HRgrSZkcUNrydg40xyB3IOd8/D0XfgfIAUB3TjgL+KWoav2hXJOPq7rNft5PJUny3xpwHzjvNY4psF++JKpp74i5AMM5C6DvNI+ccEjDS2XZ4/5PWA+hx9eCpulW8I673TRPFUuBm2tijzlq3zczCAEdRHc2A1f0CufPSjom+OH8B5Yt//L9WzQ4n687btl6eHwMJcPbT2Ew7+aQPz/t3QpCn15cIS3eJCyVXaS1A1/3Iy4eO/MqgdeEKEEmFi6iEhpqxeolJAhp2rgUr0xUltIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCHiNbq9IyRwNmiBnH0FLjer/SfpKncfItne1D6+3pg=;
 b=ng5i7fH4AtM/pcy0e4vSc6imXyQeCtYNEP75oQPOYqsN8SKC4v8hK22pQN4iCnHlmHucoj2jtGXgiOVebZayl940+WCvf6h8Q2McZkhJKEy6X832Xv+YISppv/HeAa6nVBnSxLeShtYW+c/dFI4aIvpj8MeNPNus9P8gxhs4Df/h9D3dsZ07P1T7x4vn43/rJkIqxvJaUr7LA4at17p2I6JrYPPB4XoUtizzeaDoJNUKBCwrnT5KN+uQbU21Jt21toI27Zf4YjPw18n9TZ7ztaJAphfOi5VturksN0SeIsA/OUGE4ZHR2CpA7xqMeDhoKcsdWygOOLMVF+LWsYxkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA4PR11MB9419.namprd11.prod.outlook.com (2603:10b6:208:564::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 15:50:58 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:57 +0000
Date: Thu, 13 Aug 2026 16:50:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 2/2] net/iavf: rename LLDP Tx devarg
Message-ID: <an3n3stq0tftci6b@bricha3-mobl1.ger.corp.intel.com>
References: <20260810140354.1869708-1-ciara.loftus@intel.com>
 <20260810140354.1869708-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260810140354.1869708-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7PR01CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::28) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA4PR11MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2048b3-2c3f-4563-10c2-08def952aa98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: VJjDR6X1P0HrXSi3v4yvoSoX9Y8ipjElTreubvmGo6gzbqskzfkUde4EH32Q2eXR1Nf/hLdkh2+E667QKvOE4AoS0oAyRgKtR1ND39vzX7a/HEYdXNACHjRQuqxfvRTKOFlCrP7oBP2NGJrkEh0L6a4ap++m8KRICXHmn71QC0wn9iuz1oTiQYkaAORmV4RS9zhfeg9bBVUiZ6V4KQUXvDp/1T8vlKqkJvoLGQkb1fc68oPBXlurue8THuWTgeay5K8lQ4m/I269cq12ojG2IjQM9lUsaJA8LN1+e/uEZnoVm7FKlf+s268kWt5ohAJ9RDRm/PsZLoN4jYBTM3QpvMVSYJxAVz27QZwJxp5Jnp4AbJplC+QGe4CzdY8rlbRWW0mZdwY8452EhO15IoqdVeKfz+yZKYaOSleHoOfCJDf1qz9+7qeicf7fuHvgU0sF+7q+OkbM4peKi7cY+6qqeOEQ0cJ2Ifnd7YaPKsWQR5H58jiRB48cULtcAtEqe21d6pX99hVbCsvKHeIijMbKr0euhBWXuuB/LS0a91TBbQ+Zq3LIu0rCfplYDvPS+0EazdtnYfH+jNcWq7j5ER3w8vvI3mKKvflOnBJG5vB3jx3bCQ34/BIcpgCI2nqfFuiCcLfnOUvmgVMEhjfvjVSnEY4jfWA0PwKaWuLLkOKQYQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d5zwUZYnGWVtpSYOH7XsF8vdSgM5En+r/Yd2LMTdUSuQIuEAUqSoaoieMRMr?=
 =?us-ascii?Q?6Vt/tAoMIuuDJOvnKALNBsrajNzQCkvWAwDj8P9f21f9ua7lnr8GST+jS5Y4?=
 =?us-ascii?Q?wqTPNRmo11H0KaNnNSWtVf04/fYuQuPSiJvBULdFJU0PeLZ+/DeoGtehtQSW?=
 =?us-ascii?Q?3nshEWDdiVcZD4htJ+ZExy37qB0qTInH/CQ82P82E3jB4u1R05yVDizvG92t?=
 =?us-ascii?Q?8t07JdO7KWHTcJexn9NhJo+i8hqkYHVrGcnLhh1RqSQkB4wG1126RbKhAe72?=
 =?us-ascii?Q?YKtBbqtUjJ1kVIuYxwCXmjrPmrwPGeATEEpUXPRFEDv859m9Rw2WCkxst6wa?=
 =?us-ascii?Q?YwP9dnDMM54CoxRojyr4HEyu0Pzej9bkueGzzNhZOrVHc+NdnPUq3tLfFFcc?=
 =?us-ascii?Q?Z1414GHoglMRMO7eaOFb4xvRGdYHtEJ1qh8r927uPlQ/RB7omDFdfddQ9GLq?=
 =?us-ascii?Q?Ll3+ZGXkq8yH/Hm4VAztZOqiANnrMz75Wu9+BJBvASP5q7m2wSQqFbpFvkEn?=
 =?us-ascii?Q?bw88CY/qCOt/GGmWwcNMqeKkfmtMdBimB8vg/SG8l89nfZP/cnr9MsAII0eS?=
 =?us-ascii?Q?PQnbrC3KrZkyvSnENEv5SvCZ/t7HeKhjT/79Gdhs0LPXo7JdudsiTqNORnT3?=
 =?us-ascii?Q?HLwWZzLCox6pNF5+9xbmn2Y0BBZdOn1F1WNg4MDxc0JpRPssMCUdP0YNrQYE?=
 =?us-ascii?Q?l8BrqRovjDH13669+1F6QuUMsU2aO4O0Es+OEi+IDvWaDJFuzvzLQf7PE2V0?=
 =?us-ascii?Q?bsOsX5CYg5W9aglT4CPX2Jp1UNOeQjfiFPbMIVzmXgGzubkgD2Q6CPMsKTFV?=
 =?us-ascii?Q?ckiwSPL9jINWiUbGzSHC4gI1fQyALz3UmmrjsXCGPQKUBljGgl4gGdt+R3/n?=
 =?us-ascii?Q?RvRbyNum6pBkSa/wlqYlcpl70q685Px16vu8KpoLHuv9fRK3da4o+g6mh4fY?=
 =?us-ascii?Q?kaC8ZKBwMxuay9OVjSlNtDR1jCyt+3KAR7Tr6vdA0+E2fCfSyG5N5OmsEclD?=
 =?us-ascii?Q?en5zU49PY5Kuw1+ceocHdCPKEVhmjwahBFFIzck2p94G52JCy0quHqeswm8W?=
 =?us-ascii?Q?sB2zNoz3qSqeAVoiXgfVnSo75zGpN8O+6riSjVUnT1UZY/WMpzm0uZn8ebCL?=
 =?us-ascii?Q?twmGOQblJZLu+kHEBriysR2mOrlyGbBjxedBE1BCgktrRGqr5A1V6S484XtN?=
 =?us-ascii?Q?r1rOQ6WFvhTEXdXUzxl6q9pkDYIg8XE3V7UL1a/PXHhuecTnhL0bkMfc131K?=
 =?us-ascii?Q?u8+FJHzO5JAoor5vokvihlZHaX9BmWdH+8PJ1rVo99RWK4Sg3AV4qGea4SJJ?=
 =?us-ascii?Q?0JluVHgYKKTbfjzkUjbwWniBLmHxawVYYxA+dNM93KG3zJP/4SvjevH5xN/s?=
 =?us-ascii?Q?rfg256bkvSjQ9EVB+QYd26MesSUACtECkO2VqpBj46/hSA5V+XwufTsKMY1v?=
 =?us-ascii?Q?Vw6BP654M24bDFCc2hrfQHVJpXvOk0XUKzFEAnorHkQIYLqk0vZ4w4v7ZoW8?=
 =?us-ascii?Q?R/19tcuY+6Uvt7ktvsBYMG01COYqyy3OFtgQ3SwVLUzzIW0lW6oiwjGGg3Mi?=
 =?us-ascii?Q?sKp4pQ7mI3RoPBdGyMYDfXCu/Mu4Y7J2xXRZFqZXbtAp5EAG/nJcySPjy7jm?=
 =?us-ascii?Q?cBB386wtTgY/ILH2+LaPq8PKbibsG2+gfeMbtjll1jRoBPqd3yJXAyHJq8BF?=
 =?us-ascii?Q?htn/Gpaz8BY3VfoIaL8jSb2Yo+qA35Q960HDWHOb4tgh8MKj7Is0GuCYWoxP?=
 =?us-ascii?Q?KgUwm5DLgzquUeR8lprxbxUNu7mpRVI=3D?=
X-Exchange-RoutingPolicyChecked: nwLfQ0KL23/oMrRDRfd49XWps7NYmCgjtd8hgCHCYFJtLvbMJksPjf93m7gLXpdnpqREpQJPjppN3h0ZFmIDxYXyVqkHGJ2PZwl2wToEiYWW21PlMwlOsYPsuWenD8IKLGLoEPFqKrhY/wMEZ92hEB1TJCfKQnWLE3euAphJx4ZRi9r8q/sNHf3baH3zqhMpsknM7fwgxJRe69cjbHGKQskG05Ipz+i+3J+QmdAOS8v1ee/j2LbxLGEeVr7coepoCCYXWuvNSGQqLQOo22ywdU9YFUNqKFZ0n5D+HoOpWW7Lo6dh7rxM1qoSJ2LmAGv7WwCY2H+HLurtY10CLyWnQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2048b3-2c3f-4563-10c2-08def952aa98
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:57.9171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0htl2jq/xQAXNndXHuCVbsbWPU15BZhRJrUKKflGV92SRzqTaize7UdSHBMCUp0NPQwCLJ2V67pFpYPoWxw66Ov5UsnzJfNqWhu6idz494=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9419
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

On Mon, Aug 10, 2026 at 02:03:54PM +0000, Ciara Loftus wrote:
> Now that the dynamic mbuf field method has been removed, packet type is
> the only mechanism used to detect LLDP packets on the transmit path.
> Using the word 'ptype' in the 'enable_ptype_lldp' devarg is therefore
> unnecessary and an implementation detail that no longer needs to be
> exposed to users.
> 
> Add an 'enable_lldp' devarg but keep 'enable_ptype_lldp' as a deprecated
> alias that maps to the same setting and emits a warning when used. If
> both are supplied, 'enable_lldp' takes precedence. The
> 'enable_ptype_lldp' devarg will be removed in a future release.
> 
I wonder if it's just better to implement a hard failure for use of the
legacy devarg? The old devarg was only present for a release or two, so
shouldn't be that common and its use implies an app or script running an
app that hasn't been properly updated to latest release.

Also, is it worth throwing a warning on dev probe or start if the LLDP
dynamic mbuf field is present? It's again a sign that an app hasn't been
updated properly. [I don't think we can hard-fail in this case].

/Bruce
