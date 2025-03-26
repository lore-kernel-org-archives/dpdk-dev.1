Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9E4C3600B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 13:37:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A211A40657;
	Wed, 26 Mar 2025 14:37:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9AB1140656
 for <dev@dpdk.org>; Wed, 26 Mar 2025 14:37:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742996231; x=1774532231;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TaV/SGhEXlIowy0mCMRF21i62LBU5Js6mp6e3+hhZYk=;
 b=E3dxMKkEbUJsnZdlc1/pkacztsTg2PsbAn1KI6eOV9G4701qX6BTm8do
 Rdc9KCkQQAdyvcn5hUZfxt1gKBVeiWsEIdUK8vrQrjC0GZTUIFHs0xtsU
 ue6LCFrileSugh++aO6dBnN6xo8txuqCLpZOoA+L31P6bLSdSLoRZ0RoA
 4qs3xPKicm8rn2okpMMJy+ZK+Q4s3u8lpzZPcSfTXFw+XZDtvLf9gfC4c
 PvPjMSWBTMayHTMk0eR0rlbsFMl2bTtoSeWBPt4eGNK3sKW+GwlmLFVGd
 +zGRXdsM0L6jJUSIxK3itfeIjlPHO9/wrNlztZfrg58XC/1YAQGAbnmA5 w==;
X-CSE-ConnectionGUID: WNjymUWGQg6QHrjXSHc/ag==
X-CSE-MsgGUID: iv2HI/bKTIa467cnROssMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54488137"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="54488137"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 06:37:10 -0700
X-CSE-ConnectionGUID: duujh1cFT5GUdgWRQyN3rA==
X-CSE-MsgGUID: gD2V1Ph5Qvy+xwDjrknwOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="129615691"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Mar 2025 06:37:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 06:37:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 06:37:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 06:37:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcNrdSCLOGoYOchtF6CTNkTcaf6pgVI1WSOoRBxKDIDIX+d9TKskhQw1Gr0pMg/6fpepMebTqmp8zyuA2eakYRG4sd8IW5okbK4SboF951ngr8yFV7cp9p8eBtuwwtNy5Vrdlme+QS2wr7MUyzvUahtaejUdkLodliivOm9pgskp95j8SCqLsgT90XnzvlF43OhCZXPxR2fe1wB3il2hCNDwLJB0T9kRUa7DrPvYpbSwbBIDuYHZhrHXlAGlvu5KwINV++194C2H/xg/5wPJZt+MFFezAYbT7MUVGMfarF1uPotVZL80cRiJ6oAsrlKKCI9bqLTCFwp/AYkONRDqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whvdzhfYzrNGMfKADYS3+ALcj+r0OH8gvF5pN1jGb80=;
 b=Lh1Y2mZtar9cX6/8XGRlenFJo9aCYLzhkaRazSYHi7nicgiPc/96tOWNfF9uhFZ2WiYepYOZVSABUAHUpVpPAZZ76F1ZU8RdDQJA1+zvAjPm3oHuCWEGEFMZvjGqm9EK4Xrzj5eyz/I2A4HqI5F88B/jjyAybaY3K17HiNeZdl3sZ+wC5fGcJ48FjPMXG5d4eTw9Bp5tWw2+kx65JQCvllPPjfrrWxFVVpt/nQDV8e8+u97mds3UYlh0gsC0k4sT9XwFoFgWzRwnIfoZFD9aG9ojohCRITRIjD8KqLSha7bOTFmjyqlD/hsgPnivLUyFAMBBZDZ6F8fiMCwRxTzzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6460.namprd11.prod.outlook.com (2603:10b6:208:3bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:37:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:37:07 +0000
Date: Wed, 26 Mar 2025 13:37:02 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ian Stokes <ian.stokes@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1] maintainers: update for iavf and i40e
Message-ID: <Z-QC_jX3z3Vva-ut@bricha3-mobl1.ger.corp.intel.com>
References: <20250326133010.168470-1-ian.stokes@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250326133010.168470-1-ian.stokes@intel.com>
X-ClientProxiedBy: MW4PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:303:b5::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 498724e8-6118-4c42-f2bd-08dd6c6b4d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+h6J5HXkpuRlvxmlogLj5ErDnljZ59qCAPAP6MdcUbVU1EeMJZMEgNoq6s6E?=
 =?us-ascii?Q?dYjzqIdZvmO3sCQvpWtd/kZ7o2SrRAUFu0/PXe4/ZoxthxQ9obDrDIaZvVT2?=
 =?us-ascii?Q?v/xBSwwp0nI3Kg+6VM48aNyyrvVZ002XluHAsaBUxXbUzWfU2z5LLtp08NuX?=
 =?us-ascii?Q?lUjmEV1rpSNkRcjVyOa2BnLPKIdkbiAdPHouVjHCYQy3C8TChuEnikei86Id?=
 =?us-ascii?Q?xmujfmXM7x4KuMiBQ20RWETU1t1zINykATNoKl4h7JOm8RrBg7kCUs3xAF7H?=
 =?us-ascii?Q?1o3cstNvorTlB+WpHdCvko62op0a1cumzkX4I+LN/tCiJkUDZ5hFNOYPkW5e?=
 =?us-ascii?Q?WId082we6MuSFepN5Dyhrs9MhmBE4CQkMe66+kHCjAJGDl1n17XRBcq/wdKa?=
 =?us-ascii?Q?WQ3FRmqzbDtm5g4FRCeslwzZ+CTcUtJWwgt2ps2RGbseh4JN7fxw9awlIlZ7?=
 =?us-ascii?Q?Xx2JXXeE6v2Vm2I58mhfdMWcEh+z3NL6HmTgd8o+BfhS/0/PWg3D6aAbmVhC?=
 =?us-ascii?Q?Ve8G4aJ31+9zXrXnlP6Pv8dKd6yPCGY+nboqWn7H0EqCi3i03NZTh1aheXO5?=
 =?us-ascii?Q?b/a4g2GRAlbLsquZjQDP+sU2A1wmzvLemRtQyT8Ujtgs3uW7QJTvl0P7PCkZ?=
 =?us-ascii?Q?DJXOUDvmKqnVD/RCnVEf3neXhVdzDPJkK0bJgWSaVF8NHFPEHZw3eZGq06QY?=
 =?us-ascii?Q?p8hAgCw3uVBztZ/QB4QalvlWVTUOcGMEQ2nTIcn+u9fDFcwYJcvLJrdLK1LG?=
 =?us-ascii?Q?FPg2DBv+xKY4deaMFUDYLl9S9QgOLdWgfVUg+iHXOfLhhLDlo5sA7g2t0hxT?=
 =?us-ascii?Q?lEpGl3UIttBV4rGojlls+LfPjqeyFAV5oAMyc/U8IuXKrW0czbVvNg9i9Y4R?=
 =?us-ascii?Q?rHVfBjhoF2pHWbGMmJOru2DlzHsJKr8mClMWWd+CuHzAiYkjOBIWu8FpHJhO?=
 =?us-ascii?Q?v5eWgh8+E1E8B0apY6uxyqEzUZdttTABbS4Enh5GPBCep3IqSUtq4d6pZFbv?=
 =?us-ascii?Q?0SjnUy+h4ImmDsAbf3HtwJ4dp5ZCC48U1WZcNKx0Jx45+8P9M1SGFdXXEisY?=
 =?us-ascii?Q?qO5YPsQAxTk/KfdpekUo648k8DTfoPOgJj62s9Cjjh39FqPrM9Zh6L3MBllh?=
 =?us-ascii?Q?BGOEC3hh+CSg/BEb0SU8bu5n3DucxBsLYU7N8OOtFvZVm8RF0iPVEcRsXsq0?=
 =?us-ascii?Q?Q70Boot1fyCElO3Vt2JkZa/9s7yORb8iB3GITidZkgzCT/KCLi2qgsl62Tvo?=
 =?us-ascii?Q?Z7pUv/2bzsGd0euHqFEF4tVYzcY93Sp3cSmSUY1ydLJFWA8aB/vbh2S9y1h7?=
 =?us-ascii?Q?tvHTQYezw1UcZgIDfjnc4IEVXyD/nCCwoX4uG8YsSBprmzAKoMkuC2z+KjvH?=
 =?us-ascii?Q?Py6mY0QYTEHSIuCxUBS68Vkwjb5qtowBX0oXQTjRAsJlJHZdzr0jCBr1aa5y?=
 =?us-ascii?Q?xhBKyr765YI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tbhIXSpShg46QVJgSEbDc9nzMASPtCjlj95LWoEvZ1eFR3UgI7aXEh11yT/5?=
 =?us-ascii?Q?Lmrnaf/Rj4YPBbJdmZxfVRgxoQeeFkEif/NvXTMkwgFDKD29pK6r5NlyiaSz?=
 =?us-ascii?Q?CNMQHanfvKrG/zY7IHsKr9DZg35/fel1Rjxzu7xBeIWJEDZR8azcEVta21l5?=
 =?us-ascii?Q?llCD/LF6JYJhnVu12qvVIieOwsMq/81O9R4YpdNWUOAFTAmo0PYa4zTcyv0g?=
 =?us-ascii?Q?1ndb7prw1X3OkxqXBi2fzSXklqtOPB3ZFvqMn0mA24WfIUtbxgPNYUHwHCwz?=
 =?us-ascii?Q?/KP0S7dzDEJHkimLEJqeUWUgxHSfqdCZIexJUa47uBzwc61kPX7jRQX9YuRK?=
 =?us-ascii?Q?y26FRMdtwXQiCF1PL5rLBtTZhuuEhwGLuZbVbiydbytXtM3wzkf6QY2yzmYc?=
 =?us-ascii?Q?uP6gozyknwjTFA6trU/hiJk3mNmcmK4YNIV2LZ7ogfBFcJH4d4m29ihEjXZK?=
 =?us-ascii?Q?LhK4EJ+UOg7/MVPjUhdiOpweGWyqPIhebB0rDJrNDnTr0Cbx7PAOHZmX/3sc?=
 =?us-ascii?Q?1eyuzP9wKMBEjSjEJwsCiWNauyz5C44pn67hAdwv4YXfbY4lw04Ds/iat8LC?=
 =?us-ascii?Q?GVvavkKtO3cwfDR/MVFT89I31Hm8RSo2elz9aRiFKurFLSDGWceroNEjvIvH?=
 =?us-ascii?Q?4gYBnGMGb95/zCLZFasAlzRTEYUHede1fgAXHrKsZtlazQ1hiCv8t0MxxeKs?=
 =?us-ascii?Q?tJkll/mD3bmUROzHsIPJqBdvxNK7kOuaaDDbehbZwE8PUE45tePEArDyo8pB?=
 =?us-ascii?Q?x+qBWwn6JZqJi+Sk9gaSiQiQYxxq7HuJklSCgKVo5Oiox3TYzUXPABzLQW1R?=
 =?us-ascii?Q?hnEiu+TeuwAE8pV+o3gcoghtW1wED16lYxLnTPw2kSG9T6l56LODTHH050k5?=
 =?us-ascii?Q?EImUYPt9vBTk9ucXQXBatuS2IRtNSIvfG81BewfQdiQssdcv2rQvPpLmwkiK?=
 =?us-ascii?Q?1E1x02YgTFt1CEzwveZ0GKWzLG4OzCACuOg3d7dB0pJesctpodUq6JjOmoBx?=
 =?us-ascii?Q?ZOhQDqVzV47/KCaKZ0RbTA+7Uhm3Yz63AX+4wpGLpeST2si7PgMGJ2DhN/Rt?=
 =?us-ascii?Q?fa+xxlz+kx4YCzamOOihnL1tQhSDcJv+QZE9E0oNSJbnj4WGL/Ejm+IZEr/d?=
 =?us-ascii?Q?wNVmDbOlg+DDmat11B7RHV1XFiqceplFjs5nfl2NYP720TYqeCklork1N+SG?=
 =?us-ascii?Q?EavLFy2TrXiTmm2INLRb0isu64s58CVrMfrDzjNQcnjly5frdyFg5j+q6rI+?=
 =?us-ascii?Q?fqE6ITYvA7d4gs9S8ABWcanZnz143BeGT3EHUYQ9AmnUlwHXVmmuKeqJpugd?=
 =?us-ascii?Q?6JhNzVkYhTgEBt/9D1X+iR7gBC7yxHvNZ4IdqVFOp1clRtCRi150pmmTFYfG?=
 =?us-ascii?Q?VifSGqUg7NLDzq0POeizusU1Vo/o6khEIBAHCjvkLGGpp8VARCJd86/SALkO?=
 =?us-ascii?Q?yhdKkVOrjvIawpr/AwGpyDF4G49tDCBjXWYvOLW7Wnaxbm2scXY3LRa0E0BH?=
 =?us-ascii?Q?iQIEAJBgHL6CIX4NG8ATwnL+76FZ4onz8iFcathDM1xIj/PFo9VFZcl/aIah?=
 =?us-ascii?Q?AVGGBMRu8SmjYHoTYeazCgjzaZIZ2XEYzRsMi3wZEnTxifGMrR8B+wyMq5Ww?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 498724e8-6118-4c42-f2bd-08dd6c6b4d2c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:37:06.9973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3y7kfW4jxwcQYfj93Dcq3/YJeyhyr7a2hwek/PO+/98si136PWA+Y8bW5xf4V8EASqTp4KaULkt+v44W3o5QYVpSnyr0c4F1SAqrdj5+lnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6460
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

On Wed, Mar 26, 2025 at 01:30:10PM +0000, Ian Stokes wrote:
> Removing myself as maintainer for iavf and i40e.
> 
> Signed-off-by: Ian Stokes <ian.stokes@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

