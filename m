Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3825AC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:47:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 189F24067A;
	Thu, 10 Sep 2026 15:47:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id BA06B40274
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789048072; x=1820584072;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nx+PPLo+TmMaEum8grahmuIXFqxCbxvVoKtOvkkkGXQ=;
 b=G23QXlEAtA84/j9pJvEWUzQJOuQida7gWTMX1YCcIPvmkBfETcaa7FSG
 QUrMct2dBS8IRGRXhJLj5GFYfLlLZNo1SydrlaBUQQFgDbhLasBE6JED2
 khJGGbf7DAjLQvZA7tfMTYP1niwIrJFIyakqx9ng+ABBzsnDd1dt9B5rF
 gn+4Ee2HgilDVCuiddUsxbynxaisbWEoUZFV5sejTKKqOOPFmtPvHTQi7
 JC9Z4n0Svyn/irLaQ47QDsoR+QXP7fGUYdkb25PdLohpdBa45XNtAndRW
 atoIsjO1KvCuCCCcB0/1BjJaMKsungjib3MEH2CTwjSUxvh3iJbV03A8+ A==;
X-CSE-ConnectionGUID: zU+IYb8ORK+yol5aUpNuzQ==
X-CSE-MsgGUID: Eq8ARAE0Qo2cvpfJjMPUvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100662413"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="100662413"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 06:47:51 -0700
X-CSE-ConnectionGUID: u1aAjdFRSwuJJfKrEWdeyQ==
X-CSE-MsgGUID: HhQ24SXkQYGZ9XkWEyxfCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="270290440"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 06:47:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 06:47:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 06:47:50 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 06:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4+2zW+wQY8FmA0CwX8DMx2CHwF0fGnw9nL9HQc7s3emFyE3yFMXUpfGb1iMjLltczVLlJCfKPPBW9bdnmygieZsyntBOn8Fjy2E0GqJPsfj9qXnED/BgD5ILvwex+W+p+7jb3zZT5UPcYRmnnaTZ82KNc9mqdgHMKrKUgSW21esYYCpSmgMFLncP7rddhC2KTrV+wVgomn9pJvaakTz9Hs4LgMWg3+NRnzKmrJfZZgzSOV2Qb1OGa1cwE1wKPvJmln8KF8W4VQfH2V3kRmYc537a9qk7eNO2fwrmce2adgqaLog758FwCbD7v0YQZSQNjoCe9YU3lWZiis7TvTzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RT3Nin+eYNfDPxzsg98cNburJJuQbUEEw6+Ezh+r3mI=;
 b=rsHcJzVJyntYmiwbH3cM3Xml15GgUddYjMXnYFylQUCsJUbKA+uQGiOBeucH6auOYvsyg2SAI6iO+DMPACKTj9KCrzMa/j7OYZCHwWQrqutj9axn60r7M7wagkfV4Hg088pe0AJrJgdNIkwpxKdXYeTeZXzl3IwvP/Ka6dZNTPRbMme8x/c5fgaO0QoCuhSBVnIBT0ZoM4n3fOCHQ7VHFidiKO7Qe2OAD7osDcsxB8yp7POby4Nezc68sdzaksvJpwZpLCXJPC2goHeN17xHtTxBQfYiyAx5FXJMGdmLw3mcHgVzLGwKMBUgW5w0eqZPZEBbEieSxvl8BPsyvvxiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB941921.namprd11.prod.outlook.com (2603:10b6:610:363::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 13:47:43 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 13:47:42 +0000
Date: Thu, 10 Sep 2026 14:47:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhang Tengfei <zhtfdev@gmail.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: add FDIR pballoc devarg
Message-ID: <aqK0-Bg-X3Voi5Jz@bricha3-mobl1.ger.corp.intel.com>
References: <20260908155858.126042-1-zhtfdev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908155858.126042-1-zhtfdev@gmail.com>
X-ClientProxiedBy: DUZP191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::18) To BY1PR11MB8080.namprd11.prod.outlook.com
 (2603:10b6:a03:528::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB941921:EE_
X-MS-Office365-Filtering-Correlation-Id: 47782c1b-6e73-48df-b170-08df0f4215b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hkarVRu8pG/sODcskqHMPKq1pAkSFbFy+2WJSB5RQ7Mh2qpoU7kv1bIGmbIDd1WBKS188i7ewQZj+biD1qtDQyjnEzjFbq9wB20Qea2/b9BEMx0iyX7r43cT/Rz/LN5F+XR/irVoCuXovwBUOjJ+ASksJ8h52jikkmGJc8XMB4AiPC39a1w1N8FN9ukw1IvJV1I2RXuVg0yViG1iEnZvOAP1t3yWDuSxmLuJNWIJ/NFpXQo7Yz86kxSUWf9EoFlLYCY31bsHiCxs5oKNVAnIrP2gnLv+4/Un4XNqjYmC9vBxKnMD+w1gAiXiS7/q+9v/k80ElwLDJmvrNbF0xY9wM8UpgnzcsIbjj1gDJ655cCzprzpxAbGZRPv4/WpdiMaNNtKhWmgrjq577STZM7Q0LLn2JAEwzmbl8hC0GX3Z4N6O7ddJg/rX94DCHMdeWo5ZDUw+VZEWDy5+koo2Regs4BkNM78+cDtD6M99v4Ygip/Q7lfR7iFHd6ivd+qbK4m5bHcxe+yWJj3RAvNXpLP8Xe1wS7CnKUr95V3eWFNVguz8xvFB/OMu4mC0hcc1yGldja0DUE+54koxEe6y9BG8ajiEtOW9leP4l4WYlAXeZDazCPWQg812BjIHJDAdUUNkuGORog7hgTOHF9bJ8xT7eNS+spnDveO/n3TbCgt1VXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4lFojSeuj9M96V3AkcQ21FS5DE43W5xNI1/siUk72esjI1UKdncqKTd4XXmN?=
 =?us-ascii?Q?Tcel/oLHDsQzov5+gn1OUIEXt1sXjoLjvnfbZ0UsLVaW0U1iGaD85Qw7vaYY?=
 =?us-ascii?Q?L/pHw6jJ9m40rOkbH0YPyAZwqFhFR8VJ93a7+gcs3nDAXg03gW/TfXFrleZo?=
 =?us-ascii?Q?nY3Wgvsi+Pt4XG3/DYY3EWVZL+Rzsj/5ooGTsjYMUw9J+D8QUuswZCsBsHAt?=
 =?us-ascii?Q?ykkkFCu3IGss/AyubiMHtovq0yPyylz57PdbvG5UPTFqSCqXcvVd97MCnEJh?=
 =?us-ascii?Q?6zVJwqcw3oM0J1429KvC6Ygl45hJgg1q2G7BwFb2fun3S750jLXWZ4la/zkM?=
 =?us-ascii?Q?q6m6vNlZW3HfZ/2RIIVNXzVSq9P+6jbZo87bggsBo9D8KglyKBV2XBCKO87q?=
 =?us-ascii?Q?yAi06Pdl1yu1C/s3dH3OdZf5CyPsgQ+Gf1CM57TQ+qdxdnr3nzaHkY6FYp9w?=
 =?us-ascii?Q?U3EGpHD8bI0EVaP6QRSUCU8DAZlGP5vA0QR7VfsTuhiB2/MpzNlSMnoMCnWT?=
 =?us-ascii?Q?uY6S745iaKwRu/wOlX48PNMRaUoSmuFsHsLIq+dMv9ZVKGs6cr2knx9vLVIx?=
 =?us-ascii?Q?HY3u4Lj/jgpfskrI7CrLEsCX8ZlvVAi34g8Lzt14JaJ2drJWMFKtI7uuaoc9?=
 =?us-ascii?Q?MVulp97QwzTtCo3j+SKwWo3D+DDLcR4grcHR4PC/SRA5pNiwqoZcBaP2X11A?=
 =?us-ascii?Q?6PTR5xUHjl2r7MELeBWC9GRW0ThLW0pFAhnR+1F4LLFPo0lFEEPsRM5pkiSo?=
 =?us-ascii?Q?sl7fQPs/tLbyUvdUgrOzEcFBC4I5dzO6mCyj1TJVFyYtVSVHHlIadUxpLZD3?=
 =?us-ascii?Q?oSSYKGzyvAOy3BibEkGvIljsb1ey49rgcqKBdpbRdIhkNORngVeAme5KrGjE?=
 =?us-ascii?Q?/iy3L75CGyOqfyepUN4/kkB0T2cQDptR/RgX8lOB61SP6a30lMqmFLPNd6N7?=
 =?us-ascii?Q?6cYu1Hp6zO+0MhsZBAsGRpm3Cm7JNZxeoNsg4r6I8Blgw2C0o5R59okyQKzq?=
 =?us-ascii?Q?GWfKraKeKKW2TvHsMqdpcYBO5zVrWvpBScoinvbyUNfWXChDj0pWpAlqvjL7?=
 =?us-ascii?Q?w92ya+/6n4b3VWfjcTuAigobaOST37oO73J7nU881aiC+izBC3KPC3ut/SLA?=
 =?us-ascii?Q?pR9FaTjNYhDHVorI+1CUVidk1v3suGHAC8sszn7uBLACNJrsN4Opc55dNIep?=
 =?us-ascii?Q?SHvkLhvB7f5E8AnSHSnVlrehKN1pxYOla9LRe5Z1g7/h9uQmF5CAK0iThZJl?=
 =?us-ascii?Q?arHJne6mhvB2TBKZLhNiAUK9niVQRbvy+vmx9vZwkgqb/EFBgJlzpzGA7031?=
 =?us-ascii?Q?z6EIZeIzILyAC7lnGOpQYYPtg71ATX7yJbFN6OhcCboXewLG18PwlzPNq4NY?=
 =?us-ascii?Q?2WLASBmcsAdE1FiuLoloPKdkzBSxbY4f9lTwaLac4iBbM6ZKstfKdvLXD6or?=
 =?us-ascii?Q?UV8ZUuEtCzGDe9SiHO6bOSlCtofDFShrkCHRmo5H67RjNmoWYKKc9Io0/1eD?=
 =?us-ascii?Q?vfUj92yBSZ8fywKMzzXO59A3SVkLp2tm5rsjgg/NvCMrIopeOIXbMSH3mQiP?=
 =?us-ascii?Q?Z9pvu6B10Hyx2qpUP9IryRwKli1dfHUHmWK/3jJXMsOznm7GaCEtfLoXqCST?=
 =?us-ascii?Q?/4z/dPUjzj70bXdzHU5UOGzXoUJXG9OUZEh9pg3sOfZqmrs2J+mxl+RiDZwk?=
 =?us-ascii?Q?HltRVdzV4ojeaBdnDbC8yIVETyuFUNEet+tp+qqAcmkukx3sqx7rss5OmRh/?=
 =?us-ascii?Q?8UOEJIMSFv7jVocBt/EvIS7W3vWN73M=3D?=
X-Exchange-RoutingPolicyChecked: TgJPv5MnusWde3nZhwIg0RNETeaMcrRcqxv+L0w7gGG8YSYprHpvNoae3ghykn0IrSLbJjP0xaqZQPk8AZMLpALJYJ1lHICG9AYeP0qfAdNVbew77bCmFLZ2CzLpxQx0dGHuF9+tPoY9h51C8R+MBQ7pQBuBro0rAtCUsaTDiARnuaW9Xjo0ieur2HhIn27GBJ1LeErYrk7zUui149/e4LBUmY+VVGWX1AvdTbs88vKA0Wf1cswk9UgEZeOVjxKNqCrGANprVy63l2JnoyxhzffN71/LtJXr0wPDeEhDNqdL4QYu2LrSMGcJL39bo79zOThJhoSSWCywmyzeyqYieA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 47782c1b-6e73-48df-b170-08df0f4215b2
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8080.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:47:42.8679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvO+BNljYS0wikaXH7IV6VS5i1GWwvSALWr45JX3tHj44HtJNNRnH4Qk8mfsxYlv/RmuB3pECcTPpOksYVvHcf5pR8KM5sf5lao6J+GFne0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB941921
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

On Tue, Sep 08, 2026 at 11:58:57PM +0800, Zhang Tengfei wrote:
> Flow Director table memory is taken from the Rx packet buffer according
> to fdir_conf.pballoc. After the legacy rte_eth_conf.fdir_conf API was
> removed, pballoc stayed at the zero-initialized 64K default.
> 
> Parse fdir_pballoc=<64k|128k|256k> at probe time so applications that
> need a larger table can opt in. The default remains 64K.
> 
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---

Using a devarg seems reasonable enough for this.

>  doc/guides/nics/ixgbe.rst              | 26 ++++++++++++
>  doc/guides/rel_notes/release_26_11.rst |  5 +++
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 56 ++++++++++++++++++++++----
>  3 files changed, 80 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
> index f075ef6f6f..18b685f441 100644
> --- a/doc/guides/nics/ixgbe.rst
> +++ b/doc/guides/nics/ixgbe.rst
> @@ -164,6 +164,32 @@ be passed as part of EAL arguments. For example,
>    This option informs the driver that in this case, SDP3 is not to be
>    used as a check for link up by testing for laser on/off.
>  
> +PF Runtime Options
> +^^^^^^^^^^^^^^^^^^
> +
> +The following ``devargs`` option can be enabled at probe time.
> +It must be passed as part of EAL arguments. For example,
> +
> +.. code-block:: console
> +
> +   dpdk-testpmd -a 81:00.0,fdir_pballoc=256k -- -i

We aren't particularly limited in the length of devargs names. Therefore, I
think a bit less cryptic name for the parameter might be better. How about
"fdir_buffer_size", for example.

> +
> +- ``fdir_pballoc`` (default **64k**)
> +
> +  Memory allocated from the Rx packet buffer for Flow Director filters.
> +  Valid values are ``64k``, ``128k`` and ``256k``.
> +
> +  Larger values increase the number of hardware filter entries
> +  (perfect mode: 2K / 4K / 8K; signature mode: 8K / 16K / 32K)
> +  and reduce Rx packet buffer space by the same amount.
> +  On 82599 the Rx packet buffer is 512KB, so ``256k`` takes half of it.
> +
> +  This value is read only at probe time. Changing it requires restarting
> +  the process with a new EAL argument.
> +
> +  Using Flow Director together with DCB is not supported:
> +  Flow Director rewrites Rx packet buffer sizing after DCB configuration.
> +

This last two lines might be better highlighted as an explicit note. Is
this limitation enforced in the code?

>  VF Runtime Options
>  ^^^^^^^^^^^^^^^^^^
>  
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index 87c7e81bde..ba3669b9da 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -55,6 +55,11 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Updated Intel ixgbe driver.**
> +
> +  Added ``fdir_pballoc`` devarg to select the Flow Director table size
> +  (``64k``, ``128k`` or ``256k``) at probe time. The default remains ``64k``.
> +
>  
>  Removed Items
>  -------------
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index c5010f623c..fef596460c 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -128,9 +128,11 @@
>  #define IXGBE_DMATXCTL_VT_MASK                 0xFFFF0000
>  
>  #define IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE	"fiber_sdp3_no_tx_disable"
> +#define IXGBE_DEVARG_FDIR_PBALLOC		"fdir_pballoc"
>  
>  static const char * const ixgbe_valid_arguments[] = {
>  	IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE,
> +	IXGBE_DEVARG_FDIR_PBALLOC,
>  	NULL
>  };
>  
> @@ -1054,19 +1056,45 @@ ixgbe_swfw_lock_reset(struct ixgbe_hw *hw)
>  	ixgbe_release_swfw_semaphore(hw, mask);
>  }
>  
> -static void
> +static int
> +devarg_handle_fdir_pballoc(const char *key, const char *value, void *extra_args)
> +{
> +	enum rte_eth_fdir_pballoc_type *pballoc = extra_args;
> +
> +	if (value == NULL || extra_args == NULL)
> +		return -EINVAL;
> +
> +	if (strcmp(value, "64k") == 0)
> +		*pballoc = RTE_ETH_FDIR_PBALLOC_64K;
> +	else if (strcmp(value, "128k") == 0)
> +		*pballoc = RTE_ETH_FDIR_PBALLOC_128K;
> +	else if (strcmp(value, "256k") == 0)
> +		*pballoc = RTE_ETH_FDIR_PBALLOC_256K;
> +	else {
> +		PMD_INIT_LOG(ERR,
> +			     "invalid %s='%s', use 64k, 128k or 256k",
> +			     key, value);

Don't think this needs wrapping, should fit on one line.

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
>  ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
> -		      struct rte_devargs *devargs)
> +		    struct rte_devargs *devargs)

Nit: you don't need to edit the whitespace indent here.

>  {
>  	struct rte_kvargs *kvlist;
>  	uint16_t sdp3_no_tx_disable;
> +	enum rte_eth_fdir_pballoc_type pballoc;
> +	int ret = 0;
>  
>  	if (devargs == NULL)
> -		return;
> +		return 0;
>  
>  	kvlist = rte_kvargs_parse(devargs->args, ixgbe_valid_arguments);
>  	if (kvlist == NULL)
> -		return;
> +		return 0;
>  
>  	if (rte_kvargs_count(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE) == 1 &&
>  	    rte_kvargs_process(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE,
> @@ -1074,7 +1102,17 @@ ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
>  	    sdp3_no_tx_disable == 1)
>  		adapter->sdp3_no_tx_disable = 1;
>  
> +	if (rte_kvargs_count(kvlist, IXGBE_DEVARG_FDIR_PBALLOC) != 0) {
> +		if (rte_kvargs_process(kvlist, IXGBE_DEVARG_FDIR_PBALLOC,
> +				       devarg_handle_fdir_pballoc,
> +				       &pballoc) != 0)
> +			ret = -EINVAL;
> +		else
> +			adapter->fdir_conf.pballoc = pballoc;
> +	}
> +
>  	rte_kvargs_free(kvlist);
> +	return ret;
>  }
>  
>  /*
> @@ -1141,8 +1179,11 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
>  
>  	/* NOTE: review for potential ordering optimization */
>  	rte_atomic_store_explicit(&ad->link_thread_running, 0, rte_memory_order_seq_cst);
> -	ixgbe_parse_devargs(eth_dev->data->dev_private,
> -			    pci_dev->device.devargs);
> +	ret = ixgbe_parse_devargs(eth_dev->data->dev_private,
> +				  pci_dev->device.devargs);
> +	if (ret != 0)
> +		return ret;
> +
>  	rte_eth_copy_pci_info(eth_dev, pci_dev);
>  	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
>  
> @@ -8665,7 +8706,8 @@ RTE_PMD_REGISTER_PCI(net_ixgbe, rte_ixgbe_pmd);
>  RTE_PMD_REGISTER_PCI_TABLE(net_ixgbe, pci_id_ixgbe_map);
>  RTE_PMD_REGISTER_KMOD_DEP(net_ixgbe, "* igb_uio | uio_pci_generic | vfio-pci");
>  RTE_PMD_REGISTER_PARAM_STRING(net_ixgbe,
> -			      IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE "=<0|1>");
> +			      IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE "=<0|1>"
> +			      IXGBE_DEVARG_FDIR_PBALLOC "=<64k|128k|256k>");
>  RTE_PMD_REGISTER_PCI(net_ixgbe_vf, rte_ixgbevf_pmd);
>  RTE_PMD_REGISTER_PCI_TABLE(net_ixgbe_vf, pci_id_ixgbevf_map);
>  RTE_PMD_REGISTER_KMOD_DEP(net_ixgbe_vf, "* igb_uio | vfio-pci");
> -- 

Overall, looks reasonable, but I think it would be good to have the DCB
limitation enforced in the code, rather than just putting it in the docs.

/Bruce
