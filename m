Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E40F46453
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 11:40:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04B5A40654;
	Mon, 16 Mar 2026 12:40:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 2CFDC400D5;
 Mon, 16 Mar 2026 12:40:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773661209; x=1805197209;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DNG7S4jto/md+F8xOqW/jOwUicUzF09Tu5tcPXxQ5ZE=;
 b=kjUm3yRD/inD5tUF84f6pdghG8aGm4ZSPoMJSI91/dkMGYocQfy/dKMz
 5GwQ4UI9oqP7LeB8Kl4a3D5kraZKOGKc2gTBVAAv2VY1CX72Sh3BmEDcc
 JDxqSGFmJuhJjt4KCGrTsVfAdH5dMq+wuRXYclNaN+KZPhf6K/LQ5KMtg
 Ib+R/jdi9EhLsnqDMW+5oRXaHiJWjIqYlqFX7GXD5933KUB6Syz04GdLa
 aFcvjcZ1Fael0sxheSvIgko/7/lDv+06j+s4eB8HohvRNsFHiX+xYAvgx
 RBZJzR9Vm/USIBPAAhcgcw6ULATBzoJLCy2IjTLEN4Lf8vyIwo3bp8kjX Q==;
X-CSE-ConnectionGUID: oJ+PnRDVTXqwXiKKYk2MjQ==
X-CSE-MsgGUID: 1oQA1VJTSYuhIuKucnvRAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="85301834"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="85301834"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:40:03 -0700
X-CSE-ConnectionGUID: j78gMUS3Q4GK77RDrhDyig==
X-CSE-MsgGUID: i9uH6KjaSaGMOiF3uA/M5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226878608"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:40:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:40:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 04:40:02 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:39:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFoXAmK4JFuAYfgssChzVECu+QfOXKtT8mwQhfJZoKD8gaZGTuTz9RORIWk2wHK2cELgfvrCXAh0RlgShR1Apw20MF3KPFvDBAYrecJ3UTz2A98WIi7qt5vZsS74RU8oIy19g9rUc4nhpm5MdESUhS8J8XUu/AQnxwJm8BwmWThDtfliXw+o6RWiWinrpFN44Vi/YcdzpqvE5C1g5TpzVq0ytb82schepxxSTmQOl+2tZwAmXVvkMvrLdMi05cRWKzwAdtlPx3H9djoqFtgVjYdrUaryWN03t/fuaz9XoRPPigyWVBxxjuoi4smiFBHIvNumEh9ettj1OUbjJczxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWjsIkEoAH9WIQp48MhvsLrF3ER6q/Peh5ZDqR710b8=;
 b=mysdivh/4Ll4ekkY/Tshpk2JyPoV6UFTM5s6YfjwnL340zYkiH77ZhlRwjSRO/bZEqF0DAapbZQz/FSdwv/mW0Tctw7DPEsUMRZmZrYnQPmyId3xwI1DJ7A8772ZIgSZqIWgESjTcSvWzO4yTUEQuLNmjHMpFDw1x6Hg4f0hHseTH6zAtpO03XPpp3/lttUcJHZt+6eLBfRqXZ/hcQJBiU+ASPwoZplRCkSgGPw3PNRm++Ok6LuMHMB6YqvotaWp3Gjc7veNOvnINQasGz7Wy9aU+WHL1RdSU6UTGLCp0D6pKTZlCsCbubILCvc6cjzPXZzh71YsTX03g7KwvDA7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB8226.namprd11.prod.outlook.com (2603:10b6:8:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 11:39:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 11:39:54 +0000
Date: Mon, 16 Mar 2026 11:39:49 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Ferruh Yigit <ferruh.yigit@amd.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v20 07/25] net/pcap: advertise Tx multi segment
Message-ID: <abfsBbcS3PQZB8H8@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-8-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-8-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: fce94536-751f-4b7b-d214-08de8350be15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SWq7YuYSoQZXRZ5Or2uhu3hV6eNxUaRe2pxyrh0CckBkeUxZ77OTbndGZsGYv2dkTrBgIs8P36cs+goBHuF/hvMM7OTrWBVrroCVFPHK+/xYGUmQRxlwWIdJxvthpVCPlSRHcsFL60xO9ZYhgaSrpbT/WKbUMYsNRsX1+4OO/zsSYPVjak7Thh1n7/k8e6J1moQsHGnXZBPQRdSxIheBT4CT1yINiOFBELv0LMp3zQMbEX+TElfbqIibVIW33oIyxegWC5pjWvR/9yYVz603CZByt2P6HQWVBfuQTeXr0xcB42e7ecWkoqvA4YQbiuRVKbDrKzJINsuczTi//Z8sRDqk+7qu5ucsUyz0JjoJU6vryXRJ+RsuP/Vr9F5h0FhPNupRzIoGRmM7rGwjIo3E4vFawds0M/k+B4NnjdL2n8n9SVK8z5OdYE8H6VvvAXX1p/GULNDtoeV1EX354NIlvnVBGNfmwEJeII/bASYS0o219RElPQQzQj2Q+FGDjrWdELcyO2Jah/SYcoTaTrJXGFr6hbj+PO3SvkksXIocBRvEohxK4q2gAgQCRRfz9ABFIgYTYDZeSfZjsaEPAIEfGTfrPUWFpTYHwPWvGXFvn0SQJNi/gKldXmks6UZH9OD4rh15Sde/H6OeWrJvCRtNuY2oBf7K0O99QKlN5uDF92xiCdVPg8yVmdikup9xen63zj9pE1OuLfOt1kDM2uv4f5qJkgF81Zv7MYDWP1L3F0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJ40suarTHhyEKgvJYW3JICZKuabphnpwNUM8nD2lTiIWuDNYUdjE658PD/g?=
 =?us-ascii?Q?l+Sw3Vu0NFyCrYBnpA1bR32ntgbhP9jSZ7b8WvT4D9ysN+W7wuSPPWId4Zp9?=
 =?us-ascii?Q?A6U9Q//zdvIaVxGB2iq71xcVW4VVEJg7CAuvXvkXKQ6uBRMRiAMtGIaZ7s3Y?=
 =?us-ascii?Q?kYCIQp9n6WVd8nn1HI8grwMDuPKtC2zo2qd3S1eBUxGEf1+mrQC554zaymB+?=
 =?us-ascii?Q?+jrs2JbVFeU2xKZsa/0FqxOgfpM4LXJBUrkkgGVKBcAYcRdtJvM4nrtqhLEr?=
 =?us-ascii?Q?NpEi1Bbed6l2IgJC/A5TnhiFqkLazz+9YvI6RRugTNmLp8vgyDwlMg6iFX/S?=
 =?us-ascii?Q?ACTmUg/wWjNt5rOiFfPgpCJJPY4kGjjnRXeYQzCfHM5j9tJpxRmWJrfYoAW1?=
 =?us-ascii?Q?QE2zNj/KD8fKTyBjX+qBEqbp+I4Vq2E5EbS0uTUDMHdJR7Xt1F1wSdYNorCZ?=
 =?us-ascii?Q?sgIkwstHuMVZ61DIAyBSqe5HnAGJXO/D5QhZ3R9h/6KplFAWdtXizwBGmFGd?=
 =?us-ascii?Q?fx7DVQU5b7P+54wD35wHLoBwYIpMfsGIlnPzDry14KwMqApoKVTbleq+jDDi?=
 =?us-ascii?Q?fksV71eAilPjhAfLEm4Upl3q7f9Hac/2hCaReqQmTnfmA9zJtROFc+Lz1jMP?=
 =?us-ascii?Q?EZ1d58ORMQB6bb/nlujcot0jTZ0VCAJOa9ia4zz8LvMTgZ8eQli4r8G6JkDp?=
 =?us-ascii?Q?Znxx8UtLDJp362FP/tHAaWsp3bd7VP9pz0VtJYwB8MBTZ8rCz1hP23GUjs2P?=
 =?us-ascii?Q?rP6nFfxThF5L4m9uo/vpt7nEt/mlKawFYwJrY1SIcOGR7A3kP+X3O+UHWHh0?=
 =?us-ascii?Q?+7gnnfNYlfWV4+828r9R3R+MoOLaYbKIqGbJ6P/WxLANw100w93RsovHlyHL?=
 =?us-ascii?Q?UfMaRv/ob3qHoDz7hihJBsQy+rstp1OAGtFzXPrc3XQZKSQ6e2UOITzV5EZn?=
 =?us-ascii?Q?1mEfoC0UYV31+pVQjNdwEY0QUT73X3skNWFExH5y827//z2yWzaLbTvF31rR?=
 =?us-ascii?Q?Di0EcrqNvMAsrywUVBoOQ5c9fAUAS2Ar3w5cbvAzfzeSDmhrEkRmcLZHEGm4?=
 =?us-ascii?Q?Pw7tOZrS356di7SWA1N+IiU+EqahBcQX48VsIab2H8J0vA5lFlg6bgMORJfd?=
 =?us-ascii?Q?PesRoXuxx7JqdZrpOLe9WLZ006scjBa3qaHvhDfi/F/gdB/c6eQxkl2CVJ6H?=
 =?us-ascii?Q?s+M3uZXywTs+3USMSNuN2q14oe/m7zPUo3iZZZG/RtPcM1HmC/yYvtD6zr1y?=
 =?us-ascii?Q?dhwFs2aYXWN+Du0vu2J7guHC8sj5YIYbgs8HYrD4S8XEv1xDaPSg8oA/0QHZ?=
 =?us-ascii?Q?Ers/+I4cdG6YasXFcDx7RUZ/ER6JsyD1/7EbHAAMI9IhazNZfSYfRUlOBBLM?=
 =?us-ascii?Q?beo1gfpahoTotaR80xIYTawsamDS+mCSeh550jCh9mtTIeKpCM16OHxqOv94?=
 =?us-ascii?Q?ZYwIXasNUBqn8VIWLskZDW2nvnc03y83DJtbE0MVoFdlStQXokcBmUfjjGMf?=
 =?us-ascii?Q?I07V572uLj8mDxfa9LB09tchHAyRMIMUge3jnx3NxngWuhrFDg8ruhbSVvME?=
 =?us-ascii?Q?+MXV3H6Jbr9v2iFR6QIZfTb/wPL6MnlkiQ4ZmQ0orpM8nJXyhOgMsmYRKsaQ?=
 =?us-ascii?Q?6PItWjvM7/RTuYvx+DoM4fptF0MSEE6wndHgmx9ORVsXUaqagH8gLJ7jcJj4?=
 =?us-ascii?Q?iyb3Ndl+HYpoLLl5iTzidZMmN/f+SuUVO5cpYXfglT7ROEUJJxwR88QldbKf?=
 =?us-ascii?Q?GENqmcKL7pPtEAeGfmCgy520SAtKizI=3D?=
X-Exchange-RoutingPolicyChecked: ECWQMfDmJp31TzQRXEqnvw65YRAjbPD0dWk2SOtHqoEIcTP0YM12NXA7v3JTyD6qcFxbj6ysyEIzA+m1IDO+7idKCFZITTd/q5tZJPK8SfqLENUcR28cr9eSDD9GfGRhZHD9CL3FJ0gW8cJfYWxGCAbzCGTXh3KDBNKmUzeJPBESImXVhL3nGYAMjAuFxowSgGqCckqy3ST+SbpGUsdftvqAhVb98L9IT2yfOhDd8nZ9ZCvjFOPBIcFNy3O4LxTiGCEFifwN/yfITETYmU4IvXNv6Z6ixB1MDtg0UitbKIXYXb6ATkkR9GvoEEHo4298WXbXJW6ZGqGLlFMhJPrQow==
X-MS-Exchange-CrossTenant-Network-Message-Id: fce94536-751f-4b7b-d214-08de8350be15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:39:54.4073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNXZlK/ijzbFG9qoMuSL1m/rZc7wIOBc0XlEQ5tnFKfKvgJjS31dUdwKpPxmdvVPq2n6xUkL5Vf4C7t5vkhOitMQNV6Aa0tLIiciSR11YQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8226
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

On Tue, Mar 10, 2026 at 09:09:45AM -0700, Stephen Hemminger wrote:
> The driver supports multi-segment transmit, but the did not set
> the offload flag. Therefore applications would not know about
> that capability.
> 
> Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
