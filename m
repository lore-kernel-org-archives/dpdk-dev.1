Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6C5C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:08:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69FF64013F;
	Fri, 14 Aug 2026 17:08:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 07065400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 17:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786720116; x=1818256116;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xa0HXSSrr7WoeHGZjnz6xmNSuqPgMfBftvaDoLGtDF4=;
 b=mOwVz2HXx57gYJ8/qYW0RLG7cjBMiSMwc809tmEdb6Dldmdag3swtHS3
 CqLZns2BKVYwr5jwpRppOpoTkMK04BZ5rg2hRK4M65A0wGqInCqNiDoLs
 dzWHBsCBMhSGTpCJ13O1xZMuWwnNCwFwaKSBY11lyjbZy19yWDWhy83RF
 6KgKdxLtnrDBAmjCRIP0k5XdVeRIosMZBe8hw5/VFPyWyuK2u7yD0VaDY
 bIUVsvZ9n+Mz/uDkGs7mvY8QmykXOwWfbHg5unNW+sWB55FaHVutqCcPw
 bV70CVSIuUxPBJt5e6MfHYxT6DuZhAeQPNjurXZDQp3WhzIUw5xJ/O5k1 A==;
X-CSE-ConnectionGUID: YrM+a2orS7KRBi5zl2dUPQ==
X-CSE-MsgGUID: 5yQEH5CfT+2G4DagmaoScQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="104681734"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="104681734"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 08:08:35 -0700
X-CSE-ConnectionGUID: RvpMWywrTH2qgunXo9YbWQ==
X-CSE-MsgGUID: bLQPtZzjS7WnIz8UTqfObg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="264289516"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 08:08:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 08:08:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 08:08:33 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 08:08:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjE7sIBUmd44y6n7xgN4Y9zY4XVi8eYUrAEQ5wqMQIldN10Nx79XnGbzKGAp4aQdaMtd9taeLur7McK599Po+KhLfYB1tc7gemXG9FcRvC5Y3jCad9w8mLrVHYTMrknSfLDabaTSuMJUWMe9ZvsU+ifqAOyhJhTKfYNPBPpFfdew83ZMR8g91U/GePZsFp3fSkSUYfOkLYDwlsxsPcAuCBIUee+elFqfB+dFQRHzsQmM8lneekE298p4XDkHSsjmLTXxw604aDRCbeZ4lHIfAI/mLkNriM1cTFuV9FzTJfGurTPxCFzNzNFS0FmofxW6jmCaNx+zUmXlYrsXKudzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYDFPnFHTztgGUoCzniltc3s8dVRwUbQuHxCK/wIDl8=;
 b=SzW4hvOuLgosYVXwRsGE/RsEkG+OsLbNtWCR6oP14/UDLu/ENo8u0UxpyztiBmxBeqciLgObhkcD+CGYirJqTKV5E0xFY6T8yhuZKVmEAXxywTp0GrRzg828wIXyGTGadIYxcQvkMzpsj6oLZScOIj/YmsPwP9NDln2FSgj2+J4Q9mdVErQ3ac5l6NO+J4kDmoH89kTFhuXcUg6RzENMgYFdq7fyZtX0Mzx19p/5ulZwEZ/+FRsmbiKbo/3fLYOQ2ujODmlFb3bCVEcEtqkFbyM4GndWmNr8sqD27n1zssJJq9lqk+Jkr6b6Uu5KGwnkxckFcFVhaoNm/J+Cb8ZzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CH3PR11MB669537.namprd11.prod.outlook.com (2603:10b6:610:366::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 15:08:26 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 15:08:26 +0000
Date: Fri, 14 Aug 2026 16:08:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/2] net/iavf: remove Tx LLDP dynfield method
Message-ID: <an8vZnMsk6F3lhwc@bricha3-mobl1.ger.corp.intel.com>
References: <20260810140354.1869708-1-ciara.loftus@intel.com>
 <20260814123753.2041645-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260814123753.2041645-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CH3PR11MB669537:EE_
X-MS-Office365-Filtering-Correlation-Id: 48011769-8a5f-4033-67ba-08defa15e425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|4143699003|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8ZcsM6dYsrMTq4cre03wnS0nr6R1I/bc3Wony7+Ppv7Aehk5qQM2eHlwD7QVYD9Ss4rqpv3MmlSIyYWDS0OTkvZnTANEKvc0waCZHJ7RavH28D5oMzD1sdyZpABdrqq3UduiZ0iZjhA06qEzQV+ce7O2nsJKYNqcMex+ZHTAeX0ePfvDU9P1mQrPx5byV0cR5Ur1P78LA+Tgl/nwc+NWQa3gW+2givnFAbpM2BhrymVIn943iOBytxJNJTdPp8JWw+oOJflk1PC/ljq1NBJ7BdsJTZ1ZK2qe2QgxoJ/S97FpsTnm+867bEZmy2I73EpiXdWmtgcBG2edHi3M/PYaQGckgIYC5rBms4H5fRPLbl+C665e36nehpEaz1vH2uSA+7iv7CWD72rnYUAkbRzClcqUrvgrI2coyNL8ntU+eJBRyLl6Jy80kWiJDROG0B3yKf5wUYRrv4k5SEvEH3UjN6KPSEwwBtkxD3OHdhZ74WFX10nZVBTWqKJiqDM7O848f1FSpdc9CKwVHHRnjnP0/e9NwbAANO8yfd0ghzSffcga8511sb5BwEFVE1aO+//uAVATKdQySHCdugckUgJs3wldzFNwYQJfnRFJfRjvBGt+HW+nmU+3Gzaf7e82RVtqjL2ZTavxRUHi/pEwDzzZgldc235LaThQkO+gVzFQT10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(4143699003)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?afSUvdDV3BO6C83CUjoZtUBvbKwLjD0sDiTXkl65MHC8+VOg/XQFxPV+uNZc?=
 =?us-ascii?Q?ftkBoLT6/oD7INB3xhYziTscxwvE0828H9j5xs0MvzYUvBDgs+SG4+ZpXdpB?=
 =?us-ascii?Q?YKrQI/LclSYk1ZIFUstKTyCDqc3OquUfhjmUnQUWOgv+ZPujrLseI7FpCBxk?=
 =?us-ascii?Q?KCW3I4gJzmIWElDn5G4dSGr3XRBkRaH/uI+9x+llxI3daYFyT5azJpzHr559?=
 =?us-ascii?Q?HzuHft6uVNBnVWWm7eW8ZQbHKIADv/yHt0HhiO58eQb8sOW/9enIA8txLkHK?=
 =?us-ascii?Q?ETlL/MfVE/bfksu18CFnoCh3ytcqrQG/dtlPnjVXTY9UYjQICiOwR7Mn4iwg?=
 =?us-ascii?Q?m1HFeoxkrw3b/PbNukARi48/5EkKtd6NVDIFADxIVkcK6FBafFDZNou1HeqT?=
 =?us-ascii?Q?AB31TOxNmizVh4IXKQRVzgesHKLK8qPPkcdgNKtNP/WM8Mte4T9ax31d7Cj+?=
 =?us-ascii?Q?K0w17zeqVAZyC65BLDMe2g58nKaVB66Z7VlHh3kdnCTGreoYGIy1S0l7rqjX?=
 =?us-ascii?Q?Hk78/dVYW+QgB034MWXt+NB1ZRppRXw3Nsgm0iLkucbolUh0oaRi2YpBwI4Q?=
 =?us-ascii?Q?ZNwmrgysaVbb/EVKFunnRvYlLdHkmXLHMu+WYfsjKcIBST5SKKYkqVhqMg5k?=
 =?us-ascii?Q?XeO45TixGsqh4e4dpnprsrJLg8R24sIL5UJfg0SHcQX0YxKVOvOHtSNoC7Z8?=
 =?us-ascii?Q?MVIrzUpmsjQrDai9/ZhWRuzVbij4QC/g+yAidhTVTJx25zCPAv0m2XWKW1a5?=
 =?us-ascii?Q?/L4pwRBVKtS5Wb9+IQVYxNUjdXRd7z/Z+Ou2qVxMq8UiYf9g5CuPeYq8ohDm?=
 =?us-ascii?Q?U0Y95rnnLBCcvO65gAcnQvBWS1AUiCHp/3h4GASXNHM4crfdvkQXVz3fOoys?=
 =?us-ascii?Q?HAfGyt0bdzFKxX3vqfV/MWk4jcTUUkOsRrcS8p/hJYyqswj/RmtVp6zxtLLd?=
 =?us-ascii?Q?WfkSt4OR4FBtJbWTnlcCTn26Wc69hUSaqbaHb0MTN5zt0oNhcymEYrD28CkT?=
 =?us-ascii?Q?REJvaQJQdjrEAiSblO53F1sme3gvOCm0SzwSea3MMWGxIvQCoX50lNbJ4+8b?=
 =?us-ascii?Q?7YXIEMs+A9GEXYSBtkeJeTCzTWnAlxnXrbTT0IgYDfqlOpcfnFTuaQ8fW1Va?=
 =?us-ascii?Q?eRLie9tWJIZiDWVXuIntI+Mea/3myvnV5RsKqZjvKzLGKo7OaaMeTgVkxTOq?=
 =?us-ascii?Q?dihMI/wLHhuw2a/Ucr393aBF0i02+QzRSu0jAyG5BUPqAIEPqsBBSD/huWUz?=
 =?us-ascii?Q?5LyZQPp0L4yt1jzd9L0wMH/sMoIHX7kXXV56cxD4EZb7X9YLbVSPy3PdH+Vv?=
 =?us-ascii?Q?qcbYtjm2m5BUC/cCD1F54hBjYGop1rntIFPlnMWzo7LiJNO0oUrtFnCSbCq2?=
 =?us-ascii?Q?dH2IvjvySzR0owNeiMRDduNMe/eI1nCT9kR1/wkTNoABrtC0TdhlfdCHbRXV?=
 =?us-ascii?Q?6remjMHiDD/9jCSjDV1j6nZMceNvWJt/PlA52uwykrXlAuWmsOF0oNvKIiwQ?=
 =?us-ascii?Q?fWdy63dsBwHKeGu4Een046WU0ioXzMzjj1fdOvRsnJFR5HQgtaB+EJFCitNE?=
 =?us-ascii?Q?SD0ch9JMNcV7rwJsrNqVIYZ1EzqVKQ+feQK7IzozjQb5wpi2WdTasnzo8CgD?=
 =?us-ascii?Q?Da9M0S7168/bRGhouZWUSUBdoyqPRL3L9CWqvvH48E8XL8x3L6S1w70qthZT?=
 =?us-ascii?Q?ZI6hQDnZthlF2xtJqr8VaP6b4pK0DpfSyef1v4/v8F/bGE5vYkTtDMIkgNLY?=
 =?us-ascii?Q?yUe0oF7h/ZCDwuE7GIh7KCMPBpQY42g=3D?=
X-Exchange-RoutingPolicyChecked: cWdgrUZbIBjffy2FgR+ACjvB/QtU6NdazKrzpJrAlRBtvI2jbitflXklZW4KXD97bB1oI4yzpAF85rp3Vsps3PFtQSiduueM197PsdQZ0l7/aUPjybuqHPdVuC62sC9BMI91O1bQ/kUOjck2msydfREkMQmOd28VUdKRFfVPX03mTJFJjjxQqV7O/Hd43sHFKZJrM+BDTqdSgvTkcel4462sS+UEg1K4cj/6ttX7NXYvbNTms0cuk41DB1rFkjhpsaP0zeLSwCOgxTUXdZbgg/ynrp7azKsjoaelOo9C9wC7OYyuyU69EF0i3ilvrKMfQQ8rsmV4vNPLP4lXRM7XDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48011769-8a5f-4033-67ba-08defa15e425
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 15:08:26.5934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ejVu7oG2Xd0P1A3uq0ppdsvMWs5TQ1Ii9XnO5aMHyd6PfwU4zBM/TYOx5egujiFcBHDIRiI2wj1PFKxP1ABrYoafDOORWdD3ZMx/+U7SOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB669537
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

On Fri, Aug 14, 2026 at 12:37:52PM +0000, Ciara Loftus wrote:
> Prior to this commit two methods existed for triggering LLDP packet
> transmission in the driver: the dynamic mbuf field method and the mbuf
> packet-type method. This commit removes the dynamic mbuf field method. The
> dynfield method required applications to tag every LLDP packet manually,
> whereas the packet-type method gives the driver the opportunity to tag LLDP
> packets automatically on the Rx path, leaving no work to be done by the
> application to explicitly flag a packet as LLDP before transmission.
> 
> The per-queue LLDP state is reduced from the tri-state 'lldp_mode' to a
> single 'lldp_enabled' boolean. The testpmd command 'set tx lldp on'
> whose purpose was to enable the dynfield lldp method is removed. The
> ptype lldp method is enabled via the enable_ptype_lldp devarg (as has
> always been the case since support was introduced):
> 
> 	-a 0000:xx:xx.x,enable_ptype_lldp=1
> 
> The deprecation notice for the dynfield is removed and the driver
> documentation is updated.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> * Added warning if dynfield is registered
> ---
>  doc/guides/nics/intel_vf.rst                  | 29 +--------
>  doc/guides/rel_notes/deprecation.rst          |  4 --
>  doc/guides/rel_notes/release_26_11.rst        |  5 ++
>  drivers/net/intel/common/tx.h                 |  2 +-
>  drivers/net/intel/iavf/iavf_ethdev.c          | 30 ++-------
>  drivers/net/intel/iavf/iavf_rxtx.c            | 15 ++---
>  drivers/net/intel/iavf/iavf_rxtx.h            | 17 +-----
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 22 +++----
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 22 +++----
>  drivers/net/intel/iavf/iavf_testpmd.c         | 61 -------------------
>  10 files changed, 47 insertions(+), 160 deletions(-)
> 
Patchset applied to dpdk-next-net-intel

Thanks,
/Bruce
