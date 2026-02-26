Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6E0FD8FD6
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:34:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6600440611;
	Thu, 26 Feb 2026 17:34:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2BB6A402E6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:34:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772123673; x=1803659673;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PTsOtjoZVToMLw3h9/1PXXD4acWP9eW8U+TJVv2IMYI=;
 b=S0uMsQ8437ogemcD86G0Q2F/oNaKbLwc3BSCO4Ma8ap31cEWcdb/ar4L
 Qz++YBn1DCDZymhEshxSgzd9exrXdeTzStHRt+aHuewh7u7dhp/e13mQ1
 u8HJS1rW8zp3vUuArOMR708fejfLhXyowHzP6uCODzuo25VoEvBTANA3S
 Zh8yMpaXUMKUMup/PS+2zaIc5irSvZpAvrEI16JixDBZGsFR45NG9AZQS
 wIzLnVQ5kGR/Xp/rhRAmB/Fv7Sl7JS7e7LMZrz5sQZEMlxERT/s79M1Yd
 YQ2FQQns8UWjGz7jTAW8AGDP18j5bo2H6DidYdnA5QYk4sRVMxjTh4SkA Q==;
X-CSE-ConnectionGUID: uD+D31piQdmfDNNo6ag1ug==
X-CSE-MsgGUID: TwkUfTbyRoGLrb8anEkBpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="95807476"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="95807476"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:34:32 -0800
X-CSE-ConnectionGUID: hR/CjlHLRymxkGoz6X0k9g==
X-CSE-MsgGUID: MBmnFaXTSLOXp6eHcOmMfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="254387199"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:34:29 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:34:28 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 08:34:28 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:34:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1wjE0nmDL2z/vG/50gVE+bkLY98E7l4rMToa+6FaVRzjXfYLNFOq2DENx6U5zgC1cFS6saGcKiATGVComSPGcMsyK1QfYWCVpXUrl6bK7PUhpvBXLkDWwLGcMLtpMu1OrPM70Mv0ZMsT2kdXTJ7DJ3WUIlLWhbgyWdYSjXoD35b4wrlyBKFT4h2sQlJVDiM7JWJsnFFWifjOt0Xl4eAoXXn9djzf5cRguqBu9KePS7x7gxaUySqDCcX9IaOXd+R0U3vG9inMigCdnXkDBkeSWE9kqnwk9NSwX+GYey3WWnF7p9iDtjdyUVuoRlvpPjnvEsBnxH3hdP12+Cn4ibJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1XAnkqnYKBwGlgYmUS3HJNdM6L7avIiLS22pcqFqHQ=;
 b=wxw+UnuK+gxDBnUK5HLT/Sg1My5eVRxTXq3XRldV2HyCUPro5h9tB4mGj5e96ft/5vL0ZxPVU7SejsIv6zc7nR11XuAIQiNV6m6YsGm+e28Q67KWcpualjzXta5v34XdyMHzfTKmCezDIT84Gn0HpB0xnfRABa39DhS9xZmLOn7J3JOwwmUTzoc8a6fiM48BB4nZ1yyOI0rh9TjDw2OVrcPNGufNvOhLMg1YYSnxILDPH80+yN2BPBxAGKXzS1VuVkMXwmiWUPUTtYAjchCBaLKHFutmFYxCXK6tfl2fiN91zNUDZN1doiQnekcwfVOR5IHfkQ4EbtZxs0isxJWZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8434.namprd11.prod.outlook.com (2603:10b6:610:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:34:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:34:27 +0000
Date: Thu, 26 Feb 2026 16:34:21 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC v2 5/5] eal: configure initial device probing
Message-ID: <aaB2DauiL2bvWI5G@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-1-david.marchand@redhat.com>
 <20260226162057.207202-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260226162057.207202-6-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e2abf6-1c3b-4056-33bc-08de7554e86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: TIVLslhOdZ40Vom2SwIddYcDdlakys2U+O7WACW+ucGqe4UkBa+IHp0O+hFc6doJq9LdgNO5oO759XArr0nUyOvjymrZYpLXD9JVekiKYZXZi0j7vKxNeglQiqV9Bx3Gf/zBKrwehOWgSi5HwyqGEddEF5BaBsA2DJjJ0q932+kP8j/OIWhPV6Xl259C2zEu26+A1vaGah+L8EwW/vIsIa8tGYK630aoTLmACTG5g1qp4iWhhGBDews2+VLf/2yljqFBDluEsb9vc+2BipTt7EtGGOLxLfU/bxftnPQD+oCv02uEcVtvzxZVXNEfmbmPJA6YTRzT7QPaDKHzG9yAno6BfDnihb2Us2vLAqJJpoREBC0AE2dO6hZZUM+zL6gFOfuWkaZzCR/OsLcyDgkuu/HgOHldu0JxYLKFWP5IJQWktrzhJFHO00ga2MZLW9xM784QX3Nr68fonekmJc6Y2qj+1UlgbYFFRmdHlpIKVcAwk+LO7PtLjpLr/De+GM0GTPoa/EiJxEi+Pj6NnpK5ae+0gI0olCBNC7smTqh4m+tDok0kC3cOleizUkEgw7wzAFCjYUSe4iTYqhUkBpe95Ef9m+zdTl0bSQRxM7fLbLSpebGEJP0SmxGTWlOMm8+M19SdfrdiUTPURXmuHQ5q6jOnPzexOHkCfaIrSZbNdvmmBDtpD7fxC8wtE38pa8iW7dxgizIRAv1I4VEOL9S/5Wi8otDkQXI0UZ4dyzgK5LQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9wB1zLUawwNJWoQ90EsZxxhZmK0JzJYBXru3O6tryRBJc9faIZzkBV1BiaK?=
 =?us-ascii?Q?kQ2WFfSDHURGgfcDxD/748AeNZ+qo297dSF3gu+V+Dwiddg8Hmaf5gdhPKWQ?=
 =?us-ascii?Q?yOo+JmWCIN7TWRJZAmOpDbU1NeDLUABUnYMtaIZ0TXwvT5Sy9laKHV8QqWAJ?=
 =?us-ascii?Q?SHWtatDWCxw2QN34iddZbC410kLzyYZ+5gt5EM0TPtf6jzbYK5JJxqzXX3Ma?=
 =?us-ascii?Q?UbNbPcoqKVmigW2v1aVFV9GnQkPfFho+ugM9nGhpPvnLmk/R8B0I6e+PMNvc?=
 =?us-ascii?Q?FanFabo1CersivaUgLEkvBR3IDrKUPqR5e3lV5KcyqJp8wm5LsB+yDYgmPZX?=
 =?us-ascii?Q?YHfEc58tSUB+o1Qf/a/V0lNnvHyjeDFW3ceZPXTJKT4bJZyNM64HGDJ0zqH7?=
 =?us-ascii?Q?YrE7Nfs9GUROcU64lhqIyJ/9w7+jE5AC4af7mNDb4dYYPbz1YwcCHXlDxHrj?=
 =?us-ascii?Q?hzEZF2XrxhAXDyAjneBvLx0/pbl4tdCMT+L4cshYRStb0GyWfl7g607GYi/d?=
 =?us-ascii?Q?Gook87lJ8DJ7q8tgqtY1bn+r78W9iUEUqH8BcTxVWpauQV/ulbc3X5ZuK+GF?=
 =?us-ascii?Q?hVkOx37EO6TpW3gHb3AbrnUtY+qLMRyu0XFOiKRBvnw4dXwFsXkKp9NLAptV?=
 =?us-ascii?Q?KYyCgEAbblvVCFD39OU+FdU1MR+vYskN6lqrckx5gYPv+fGTDAS2Ye3f1tBb?=
 =?us-ascii?Q?1ytHGJalohSWDL4LM6X4KkV34mW203pfcubpS9d8fnv4/S/I4oyDPpWmlWwC?=
 =?us-ascii?Q?c0FiNQ5GhZ9OzGJwo9bwpLf6aXj/HzmXTZhBLPG9Fzvw0rE93mxo/5XIPYWE?=
 =?us-ascii?Q?+1CK/TGx4+IXqhd888xIpPEJeJ7SgPTvx2tRgITtlZP5a8OcW2DUon1Zkbvk?=
 =?us-ascii?Q?CYJk1PW4swy0ptZb/h453JHHNttkqos73NiIC3/vIRj3RRRKQ5h9GSR7xz2l?=
 =?us-ascii?Q?pUMookRCDh65dyrdGpYBTnIZ2N/E7vuiHIGx9RjMSTchJbd43jXe7KxsL4zH?=
 =?us-ascii?Q?UW81/ifaTeZOWkioNHkhsGApfyFG9bdLNArWWi0MsVt2XbxGVa2REBp4mjj9?=
 =?us-ascii?Q?/7D8JdxzKsS97sD5GaNCKwa3yku4fvAB4YvtP1vmHDONPgqOK2/Oxi3ura+F?=
 =?us-ascii?Q?3+n8xr7siAtp0FMYJuTeiTuVvWACRfYxTxcTjJq6z27wup5amY8YKeJhyn2N?=
 =?us-ascii?Q?1ZzAoDMMP0vO6ST/cUJfppXZUWjywUDMg0szJ+LOXEmo4taJ9uG+baffjGEr?=
 =?us-ascii?Q?sAmQ6MtWIgU2sneT8DDygC5uVgJoWpRSkDSAUQmhoDaAL2iyJncPobhwMNPd?=
 =?us-ascii?Q?aBsySiLPNMtW9IRlIDzvc4R5NxjrcAZYmQDk5C0FPc0b76RGWPLjESZDi2nR?=
 =?us-ascii?Q?7D22kOJyuyF+vlKclB60YRex1epfBXiR/ON8e3WR24+0KsTGp/qhHMhueN98?=
 =?us-ascii?Q?r3hnq8hCf5g1vEECQByxMtsK+rwxGact/yQlkwUV8DCyuU8tFeCVd4qA3H0R?=
 =?us-ascii?Q?uGeiRPtYuY4aQK4fkjrKpeJx8BG+9/6OC0GrxxZNi6UlvYAxTrU01ROOWXta?=
 =?us-ascii?Q?yzX5HHuxYScJVQ1gDqL0D4/Xv1xLlvsc071yF4R8hE+4KT7c/kx9RgVlt84T?=
 =?us-ascii?Q?mZ9sgfS4r+2npDFOWD6JWciL8I6UU8rbGnmdJ106N1uZv9Ce+Vd3NNvHy3ef?=
 =?us-ascii?Q?2I7WOmMjW/kaUA9IXqtvsixxO99ckoRDLrqKKXPqiYx5BTpnqxzCR4ohSPFB?=
 =?us-ascii?Q?xzpgug7zDJ6QJaxEaJ+/02LxWasvQNc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e2abf6-1c3b-4056-33bc-08de7554e86d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:34:27.2337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cnq3+Ydk2HYAys47HSD45lBc/3E39V+LqFMUGlvm75z7QnLGIftPB1VJKPOo0S8cw+TLfjR5QwHDGLjyby6JtOyvzYZaoorXscsFUxsYv4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8434
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

On Thu, Feb 26, 2026 at 05:20:56PM +0100, David Marchand wrote:
> Some applications use port hotplug as their primary way for using DPDK
> resources.
> Having a systematic device probing is a problem when not all available
> resources will be used by the application, as such applications won't set
> an explicit allow list at startup.
> 
> This is the case for OVS on systems with multiple mlx5 devices:
> one device can be used by the kernel while the other(s) are used by DPDK.
> In such a setup, the kernel used device may get reconfigured in
> unexpected ways and trigger issues like the one described by Kevin
> not so long ago in bugzilla 1873.
> 
> Add an EAL option so that we can change the default behavior from
> block-listing to allow-listing.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since RFC v1:
> - changed approach following Bruce suggestion,
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
