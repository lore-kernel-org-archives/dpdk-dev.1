Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20484F506D8
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 14:11:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EF5F4025E;
	Mon, 16 Mar 2026 15:11:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0BCF6400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 15:11:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773670317; x=1805206317;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yZ+7MPCnHEh0iLEUgeQiXYtVYFp2JeIG1tXlFbCxoj8=;
 b=Gr6TJUouoOORt3cRqSyUqO0X/1VEYxoSH5mVUfVcuW22JpK0kobrrvLM
 RR2FaG0tyLDMqQA+7vc1X7I76wIJslY/bayjZO8ZwPhsu2csEsoK69dwE
 K4DCkbwmxBYWgMX9Pa2GugAMqrQf7o2AloVCfQzdTJ4yOOBbtsGS7cW0+
 bQD9PkAvkJ6vH+Dxq5gyS0uIKNrinCpjbFz5WDaJxlXE/01OGcONpQJuv
 +UgcnJ6TC/TBs8qwL270d43ntOo017my1Y2rJ39GTNGE/3F1TO0tHFsu/
 GntSmCHZ+ln89g8Atgmx7cBg2QS2qOk4eKzhvo/07igURQJO3zmiuCslg g==;
X-CSE-ConnectionGUID: sQTTg0/ASvW9btTraqKFtw==
X-CSE-MsgGUID: /XN8R4A1QbS4Ve7tnMxPaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85001660"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="85001660"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:11:56 -0700
X-CSE-ConnectionGUID: igPrmQXgSKuvhvBO+s4SZQ==
X-CSE-MsgGUID: gpb2E6qNSL+b3daf3JTqOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226609302"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:11:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:11:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 07:11:54 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.21)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKOxfE9Ucgn+gFe1KmkWESUe/eYAeeCR3jCRPvmyD0fuBqKwnsKPCuPslW+yxzYnB46fyfxrKg9qK8wbZUKQBN3qKe2KJcuo1ceAzPy6GvFUQDfxdULlToNOlmLvOnYerACKF13iDmyv+zVUppjOrr6WqOoZ8+kkYUCuXDnl20TZblpvyRIHfIAgBnTZVDlrI3HQT/eLK6CSh3hIwmAGo4zRztRPfNmWmtlUK6Q3VZsQtNoeUldDvdS0V6ejsLvp9u0ERUtvM3CEDxU8qum5A1UOUpYodcRrwYaFAWyINcDzZ+cYO02tLuElNJwKhNuyNHgO5Pe/g7QYrTHiaNeSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isNFv093MDxhHEA2oaagcyLwOhg0V8sRFfmRa98rC5E=;
 b=m+sNhxnzp/GApiRgooazuWhwHn4jUWSGnLIdWOUhhn+PZj+a+gpixiTJeWtfOTlwyVmiM05wRmaQ+MetpEk3L6IWeKL/DSmZXIX55Ld+UYaXiRuyk6iBr2CAvWSe4JAc5tbNwOdGOZOwsiiXnb97njzure+O50QFN+KBqC6rc6Ll9i6bW9c/J0VCBj9nC+8OLz0rZtJxn9BUbfPfFVyHjRi51X+AlRTTSueq+rzqf7xF5rDrQq1cYPKkk4zUnaNVLwmbH5yewLlR/E8qnDXzxO3huq2+CLxNS0YHh3/KWZZCq3S6nPF+Aw2d7nwNM9k4K7D8p7+eReFiyxUHzo0mSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 14:11:52 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 14:11:52 +0000
Date: Mon, 16 Mar 2026 14:11:47 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 13/25] net/pcap: add link status for interface mode
Message-ID: <abgPo5lcjWccTMCL@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-14-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-14-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0040.eurprd04.prod.outlook.com
 (2603:10a6:10:234::15) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MW3PR11MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4394a4-4403-4a6c-8b87-08de8365f8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r0O77W6/I6i5QuMdfVQKUDWRCh7j5ilZ1WB/mnOsfhoExVPSctYnI6MYhLBPqCIBrL2HNxwF8xDySrA2q2XMT+oX/DK0sSbpYOGxqCzktiqvBcEDos4nIDHjZw+hpz3v6xrbzIChKgBCX0nS6KFONjBcf9BTARIh5i7xlHw2TFJIu8om5BK0pTlegutpShol7rJLcXolqebrlITNRUS1V3FgiVgigeZLxai0yIpwnVCe3s60D7+fwh1NT1BAgrunNYhSOj8gELz2i3EGG8XwksSy5nmyvAPqNTZdykQ1pXNzVrXgeZqDq6mqfaOQHw2QBwXBCGYhGpxiNA5UvPD7JBTIwxFKRMyYZZ5H2+CfyiXuauIgJSvCh0atx7H+DoSdxln9H5D0JNntwqqM4K+7JXVbWExIYSbCn1C4sZZrLP1RPjBOmomMjpSToK46/YgFRif9P0nM7peZ6G11P4C7wY2UtfHqL2690xhjj+qF4+nETk047fNgMWjFBdX07HvvQU4TYMHcqedgx7TnEvoxnu8eiQzlBEFjzMT6A6V+2v5qwpOPAaV9PbBTG38Oplevz4yUihBWUexoj2Bp7lMQ76K+UR/QGDOFZblTHoHZriRXIQ2QHBxkwZgwVfe3H26qtKTAXs99KMAl+qBOEcqCR3tBFqDIF95NrSayD5Cyd202byaj144q7uvrdrlCuS8Rk4LZn2Yd8NVHwpuRspftaFeDATXQqOXe6+2Y6ccXAmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/cM0TrxsiCkfLgusEbMLuN2BxXDZdhBpYaBPvpwj/8fTQIBo+XS82jR5nzO0?=
 =?us-ascii?Q?CE7/d53CULDRihVM+ODDb+OYkrrWelH496Hnm8vNLB5Q32sRFwqZoRHG1IIM?=
 =?us-ascii?Q?nuPNZUE75wf+9h++F8/cJI4I8nT9mk/V4/XMJ64MxJh2ay8M/PgsVcu6tR4n?=
 =?us-ascii?Q?3LdmK+dm4Mp2JyAMLWryG5i6311vOCn+iBfery80AbB/ignpy1RCb1YuRugf?=
 =?us-ascii?Q?0pe3B+nFjxJUb10lzYaWkngJb2ughRKQM5PVAJ+Lz/mnZTTHOnrIro0SFvuf?=
 =?us-ascii?Q?ljgXNmEMqVc0jOKDeYyiyAhQkFSfWJ6mCgObJROiKP0pOtMq+qsxkqfxAOzd?=
 =?us-ascii?Q?8hpqJ2vnoZFLV3D/8QfV1JXR9sW1ZuqVO8BaT9m9HyhGrXV1rcXHl31EpFDp?=
 =?us-ascii?Q?eh77cJzjUgpuLC2exXwmKpjggoTTrwy/JG3pyRLPxYLoRrHNvTt3G3qHZiKn?=
 =?us-ascii?Q?tSyHmaUH9+Ls3/LqY+uYwoyU/yfPicrY+kf4XnrVFNj9PQIGvRVTDMMoOF6h?=
 =?us-ascii?Q?H/NKpYtV1jJkjJR9ybU47xxMLD6OStG8QfRQcQyx4cAg8B/ozGe9dK3gL97D?=
 =?us-ascii?Q?6GrEzPzue/cF+Bi8Hx7KdtKSzTuQBlRTGlkUOBTYDveRKVVqCit3B2TaSCUt?=
 =?us-ascii?Q?AqeIK8T0kiLPGfm/Ad8RBWcQXZvRS8x/gAxdHUXvG+JW5R9vSHzvHlUuSXRH?=
 =?us-ascii?Q?OnLwgmo4zyXm4699Sb/gC8kXvf/pJTidEviMmlm4/mjhS87wqRoEdywUAPCT?=
 =?us-ascii?Q?8Q7ZaZWy5syYTiZaHNVBgzzvH5Mom4k+LwJ6rKYwylQ7pZUvClL5lWQZ5EWr?=
 =?us-ascii?Q?LriUlvwNhBQbx2F0t640K381Y+ehPybISqAxi5JsWflyggkSge/sYwI3z34x?=
 =?us-ascii?Q?t4734Y+y0UdQ64tA4pWXgvogxZ0/SRUDSQlsM1Wg7QZ+++cz5TTxx24AL1t9?=
 =?us-ascii?Q?ZqgoTpaWii0/i23nFsB1LmrvHWE4JW8+k7Se1MaDs1h9F2jDz4nUCDvoiKh2?=
 =?us-ascii?Q?dvRSLyuL/+oX3REB+KIhgNUso9FqVdOW6jhQVjgH/g2zzhRJ++Z7NsVVbfVl?=
 =?us-ascii?Q?VHGjupzf5hOfoM4oMyE3j9+Rx/lqK1sHmN2gGgoA3R+gASwQgMqsjZOcvUJA?=
 =?us-ascii?Q?n0D3tJFiRhKQ34BGdYerSlWbBqPHTXW21AniluuDF30Fe6JuA+zcTfG1XBeN?=
 =?us-ascii?Q?5+VgDHY3FTS86bNHKeILaHWsjPBErp0ccWj0Hv/bj1FjRXuuHnf9Yi78kzye?=
 =?us-ascii?Q?Qc+yEbZdT0vy9SGCD0dvswZM097xDSLDjitX9uAXWytrRyQbjmRo3biUR01E?=
 =?us-ascii?Q?bTUc1KGen/YpSORdGOEDsWeFJCLtorMCDbD/AJxz798OuwWr+PDbxMmmJELo?=
 =?us-ascii?Q?iJGAblqxk1hzGfdUlUts19F2567dirxtX/v7AVyjOwnX1q1qulJGcqaMAwSS?=
 =?us-ascii?Q?0L8huBXH5evodogp1GnRMGU+wmtB7/eXAp4tXZP9Tz8umvbiDuzK3X/dlixB?=
 =?us-ascii?Q?JV3N9nOmGmlLBSkwoWXsEUiMS4zw387TwBOZEBwrR22czeMK65RfpsbFmC/j?=
 =?us-ascii?Q?PsYZT17olY6hZ4ig1UxFJRVjLGsKWLM8l21KYnwKLzVxDYCo1SfoSrLzhWQ9?=
 =?us-ascii?Q?PnUAJB8/oYKqnn7vTkGa+ubmlH4f5qS3j3cPOPyReW5t3gICGCij8XV3QtuM?=
 =?us-ascii?Q?AEsAKW+ybPwxGYOYPYOWRzT8jZzQ4GNAlqRMBlsWwQ4N0B5na9ROMAxH2POa?=
 =?us-ascii?Q?Tp87srBN3Dp7j5RuriQrGNc4TYHdEEo=3D?=
X-Exchange-RoutingPolicyChecked: PBUNkrHD4xN7fedcHJavxga5a4UFFdElF2Kwl6GCYxx/+NSbMHZcbqG5ZBaa2plu34pi7Nm5ty7CKnn5I+5Xy7AxCkAaXLfs/6ZFcyobqLLs1T0BWrFROcxAef3Ru6KQgcwJ46yUNwRgAMdQ3A4zFlybAEWuFJC++O6E3VB5imce/R8p1hj0bBs8sAK9kUgHC6MJnqUiYNrXwU2Yq1NeAXlA4IbcXaPwF24PYRcNnRYSuxkFnggBx1dhMN3+4X9L3EWagdU2MNOiw8/JUUGSRbINK06P4JmjE7h+ESucA5FzrMkHa1d14a7FntinrSKdQ20rCdFEPcBd9Gqw7OXFPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4394a4-4403-4a6c-8b87-08de8365f8eb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:11:52.5705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWdm4alcpnKXoS4Z8qvDl5sn9eaONIAwUPciHTDDlRFBMk6OsWP9ppOhIO7xxzPQkVRuOiGKrKv5+1419n5dNXEJF+FtRJ3Su7TgUA0ssPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
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

On Tue, Mar 10, 2026 at 09:09:51AM -0700, Stephen Hemminger wrote:
> When the PCAP PMD is used in pass-through mode with a physical
> interface (iface=X), the link status was always reported with
> hardcoded values regardless of the actual interface state.
> 
> Add OS-dependent function to query the real link state from
> the underlying interface.
> 
> Linux and FreeBSD use SIOCGIFFLAGS to check IFF_UP and
> IFF_RUNNING. Windows uses GetAdaptersAddresses() to check
> OperStatus.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Any reason we can't in future similarly query the link speed of the
interface in use, and the other link parameters?
