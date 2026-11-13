Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09EF6072308
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MHqYQ0/9;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Qfu1NEGF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE18940682;
	Fri, 13 Nov 2026 17:00:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTPS id BAA8D4028E;
 Fri, 13 Nov 2026 17:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794585633; x=1826121633;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xBliiZml067JsZXIwAAsFrq8Y0/polFkpAEonZoF85o=;
 b=MHqYQ0/9A8I0fZRCdP0WugjhVYwFdioQ8rfD/kFp8hh0pdBrnadrS87Z
 axFiWzcSkyRGuc/RP96PyB6t2PdYFk0fPSt6JB9+y0cL5cXTsYanvEokb
 OQnTAAvKimniTZtoa4ug0oxdg9FmfS846MQTYJWW/aULJkgllFdTYrXKN
 RJU85vp4DxelGIlf7xdUTFYf1WRkau2DSnrNHRCzdpkowhhfbDOVPboFB
 jDfjW6LGHnb1yhHSlepyytOI47zRFnd52x4QB6Mie3gqfEsv1ejKmyqKx
 SHi2Yq23fHl+isA1bgWlE2Qy+OUFLMbKD4bMo5xqdYjofxyVkMmF5cEgL Q==;
X-CSE-ConnectionGUID: nDWgljB1T96q5dHM04V4Cw==
X-CSE-MsgGUID: DtFusBHuQx2rKnz8hX/qBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3262277"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3262277"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:00:31 -0800
X-CSE-ConnectionGUID: pZ4bg58lRW6pJBPdWtuy7w==
X-CSE-MsgGUID: e2WAan75TteufG3Ln2MlaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8799564"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:00:31 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:00:30 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 08:00:30 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:00:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZCyfvLHe+4y3pN4cRXM5H232ud2ccvdMz6sdJSghEWtqcO63qplL2Z7QzwZFvRysfnowqNIN3s0LJEQFQjCtxAqJMgz0VrZ65UVkU6K/GR1+3kHKyQHD1UjzgslYntO9BcaA4LzbqP5ykm1gfY4b5VsBgrD/Bo6mem0C94oc67GffERHvpFkh5C5GDJyOWAg/ndWgnq8dyCmSmFYaN/cJPetPotnzJza7FBhUJPP6RduMi/D5DpBSdWFlamGaGfHggz/HqwGyqsxkF9WCqX+f6FtxfkeeRtptd/MlkOmu5uSGkAW5LUZJy+Wb/+s56tqRineiJUFkuep5/gEfucCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxG7QxJSGafm+2yywu0hQPXfI/5HJ05rt3dLOudcFJE=;
 b=fEPjUiqwwXSn2d3nLZUnC/6zdZ/KrgvI+Hgk6NfWH4sYNEoI0PNU+2k8iM7NhNUFQDyNiukWVQ8qTe2sEpj1g+KmcEq+HJ7Lb6DyyxWvuFTbkMJz/mtTDryMX/5D0WqIY9wLZRX+u9eKNDQq4q8J/jz+lbV2wU1357rTbcHKQiDsE9q2DMKD/vYKondV3H4p6gMoqoOE1xnCeiA33gvtLIxVEE3LsV5fGVxLbEPakCvUCLvOTQCIfYSKTGglDftvwb0B7AicgiU1Zr8fyuCj/V98wyqgCwpR4SDCspXnsK9zgc8Y4CuMpZTrNYonNVwKzUjM+CZi1Vc87RlOoVnTjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxG7QxJSGafm+2yywu0hQPXfI/5HJ05rt3dLOudcFJE=;
 b=Qfu1NEGFCDtpYyE7dzr74Z86GElWD0ulMXGGFn5qu3wZrUWRSXmu8uHD/0SmwXZuXj4EfPp067Y7f0AaQXbpIkiwESiFxj+LCTZBfL+HnSxd+xbVBTAxFyL72r8XGf/T/Q/cfwVN/Z6RHAs7qC/lP2lfwuw42t7wle5sqMj8BEU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH8PR11MB9506.namprd11.prod.outlook.com (2603:10b6:610:2bf::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:00:20 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:00:20 +0000
Date: Fri, 13 Nov 2026 16:00:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] doc: fix igb NIC speed
Message-ID: <avc0DhJ4WS5cPDqD@bricha3-mobl1.ger.corp.intel.com>
References: <20261110213103.151490-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110213103.151490-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DUZPR01CA0184.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::7) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH8PR11MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: d2937edd-fd65-4395-2219-08df419f37bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261102123227099003|261021135927099003|261021121427099003|261026121527099003|261021123027099003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1SabZ6HZyPcUGoP0jvsbmSsepbSnBOP03X0kmksjGr+IC8BnS9JIlhZPh7aeoBxsuZZvUcevIr5TJRsLkZ+1K3N77qrL8tfw684OcQOAfbwlOBnAxKr+crX8XC1ohAgb4fNqP4vAjFxwSrz7MFQH0lk7wEc86zy5fv5tqyjOPAOd/Jvdhi6i1ewQGCs+xo4h/jGouU73kkper5zzlSonBVB1xofJBoYvaC/HXPmQK+VnWadaYIl/1XjCPP7hW/BTlsDPwV8nWB/X9xGzMngQQJa5e51K9WN04K5Li2B1TjhYSvMQo85ozX39pM8L4vsaNoKj9P77r0Q7SCTJLNj3Lbzuz8d6tKCkFF3PSGZ2u2PQzTTtk396KZg9hpZ6i/g7ybC777FSqfKRxChtBmUDiNHiP/KeheSYqdm3G4rlwbjWWpz4yr2V6S4dSEmFYaV9nACVwnl6yQfPgn8rCQkex67/eKYNSK/bynTEvO+YelgZg11ZjqhBzOHbisM6MKGfw/nKKtDOLlhSMhv4zY7NBdgF4xkE4f0pO7buVfEbyfhu1GUX6rKazta52XKTp1uA+vDo5dBeVs/c8BzHhznYIwqLhOF3VYqiMLy+pnBHGm/6qwusYDfi/JDW2KyTMVgDi4q5Bej+xgP2NooTtAbdbDab9vcZuBWQ6EwKHWwzCyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261102123227099003)(261021135927099003)(261021121427099003)(261026121527099003)(261021123027099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dVu/xcd3nuE0I8oHfLMYsrOEkzg03NIZN4ek89YRu7X8isjJTCaYeRIYEC7G?=
 =?us-ascii?Q?tUoaEzIuWSeD5tZ0m/swRZWovTpMP5muSgJP4ip8pgyYNb3x15xyrERveZUM?=
 =?us-ascii?Q?Z2LIhHHDBxqpB9jbMIKcjjRLKwgHSeNv9IT2Vo1x+bQkHiYNDZlNwAoZgoxE?=
 =?us-ascii?Q?yYsz1KCZEe9ICa8MMAzi7RsK/nzPOKQgTVITtOiQ7ld3IsTgh2s4oJ6taY7+?=
 =?us-ascii?Q?kKKV6poMfis24Dn297f64fkV1OGOjQoNeqMLBow0nQ3m1Url2JhMXF2h4y9U?=
 =?us-ascii?Q?DKXpXUrL0wGiL1gMFjRy3O139Ro44jWADoPsJKls6OmRm0kXY+GX5CGIgPLq?=
 =?us-ascii?Q?PhXe5H2CWK7IhBvkOji+H/UVMMPm3uWXjE9smDBbXKUwK0VzOMQdTpCDq01v?=
 =?us-ascii?Q?uCPNyGzGqWMhnX9yGGiH1QFU+Zhn5VBVDU8+73URJNIahP7HSyvqhSzhvXlD?=
 =?us-ascii?Q?U8GYSn+wk7NGQXp9LzI4QqEIYXmHefH1OWyKasT+fpXU073ID0/KEn2OZw13?=
 =?us-ascii?Q?rTFq1Lc237qCoby4RTvKKhHPlFMPvqWiwjxmxEfIhKulGu72TqLzFW1w0mWq?=
 =?us-ascii?Q?223y7HPjle242wRKP90Db49ZRKkrBTLrMAfMHG1BxusIUDKDtHyl4xMki4im?=
 =?us-ascii?Q?IlGkSAyaxfxkoPYJEa4keTcSyKMBHmYuiW7kLDU+/DXzumOdIGsqwhf3dF2D?=
 =?us-ascii?Q?5bCF/DFHNZrq3CdflA62vyWeHLiI5K9oZedzNOOH0TwwaWmfdm5YUTsTG/7C?=
 =?us-ascii?Q?y++weFq2YzYB+ao6pt+sYVdmR3AF4pSqReo44h9SgNLl1ho+apn2g42vufDl?=
 =?us-ascii?Q?SJb+CULQPNn2Xrqlzzckfdc85rSqyRMYD99Okgi8mRaTUhBveVTUb1eCOoIG?=
 =?us-ascii?Q?271jI4q0RdzTh1qlFRnHMSHo0BH+fA+fC4mt7qnFNRqBHPVl8Ir9YAHjTE9i?=
 =?us-ascii?Q?pGEq9/vCOryiejbaRIkmqAWEXCMQUiMRKuv9PO+sMItzHxpVy0ss+Jb5WUIY?=
 =?us-ascii?Q?XFs8mnZ5OJ9RsuHwljBG4h8uvUO0Ls44QOonLoglzXP8WjO3KZ0T8AFuAkxy?=
 =?us-ascii?Q?dmrjWeH05cX2dlx0yoKVffKQ9xiYwIvtWcYzCFJGiw7mZTqnDa1WJEK9Fk4s?=
 =?us-ascii?Q?/wCWFe4kYpfoqOXRwXtdsL5SvsUHE11P3kw63OJBliJAvZmCVwg5OWTo4CEd?=
 =?us-ascii?Q?VsBvEvUHIkE9mas1Q3Hkw21JUNvqWc2vNC6O7cLWqFIrT5x52+YPtBlnsz3e?=
 =?us-ascii?Q?TTZ0gSh87lV2GomsGiV4mlpE5k1hJqGhqnx6ycfolYI32aSqts8AdLRoSyFg?=
 =?us-ascii?Q?A8IWq1n8MWKe7SWSUbf43TMFPG9yUkIiTy4TDMyOvJ/zqVPN7n/RU0IELDQ8?=
 =?us-ascii?Q?DK+GD+Oxt7dw1mPfhzHGjmURUI0o82nllto5AR0bZfXp6hjs/z0i5RDzW82x?=
 =?us-ascii?Q?MCWSCGW4rwbTXoOkMCreN2wbFyO7nGHY/m62HFm3oJsruhrTtJHCm5cD06yn?=
 =?us-ascii?Q?5s98W4QiISVyK6mOR5GMs24GAu8L6EOAoQAjwdGoYJMWuSOux152iJtEbE43?=
 =?us-ascii?Q?Yih7CHoBF3tW2NKuAHjzXzer6SbM2IDuYKUtxmAKU6SuO097DK9LuBJ4ysB/?=
 =?us-ascii?Q?LysLIiIO5QK89c0aGJ9MB3u1S/PYofEDoHhFILno7lsrixU2cx7SXrdfpVpB?=
 =?us-ascii?Q?4lJmcTlNjWFbia53seLqvZ7zE2UP5ukhhxm6TgnaT0lyEf/tZtAnW1PCEvVU?=
 =?us-ascii?Q?0bPJAiteln+3UXIF+tLMI2nM4RtbaqY=3D?=
X-Exchange-RoutingPolicyChecked: fg4X1ltxg4BcUpQoE7QFsa10bN85dzV5TsW8hSARE71v0W7fSI0wpjT+YIFmOiRvm7gj5wNzU2g+/DriZ0+5KBi2Nj6aVf7oXLX4xdg6tjompNPr7NplVnyIkiTAbBt/B+s83lHegFP4+5fjG8Iqu5mUi/T41nHXudMwH0vH3KYBtJOCpMgba+YVvM8+lpLL6CP0GgcjNS3WxU0yDxb8BeaQEj9vwPpzOZiuZg7o7jip43mZVqVpIWo+Jcku2FRU+c8ypmju+/kniKdyQVW/FM3uBGneQ0pymxwnGkxcF4KS6sez4LpZ48HlkD+YTbjcOMD71E8MEy2Kzt0Ue8k1rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2937edd-fd65-4395-2219-08df419f37bc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:00:20.3781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGHhreiccwxJBXI8uOcI6wVSaEr7RN+0UTVysfnu2mmSEkU57TDwz/qdvVytKk3ofu5nyYZ4i/GaK3cK9MgTTpa1AmVUW6NAjJEuRlKZzZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9506
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 09:31:03PM +0000, Sandeep Penigalapati wrote:
> The listed 82576 and 82580 controllers are 1GbE, not 10GbE.
> 
> Fixes: d2bc8f4d45d7 ("doc: add igb guide")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  doc/guides/nics/igb.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

/Bruce
