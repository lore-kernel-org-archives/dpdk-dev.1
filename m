Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD30CFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 12:09:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3440E40609;
	Mon, 24 Nov 2025 13:09:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B94DC402E5
 for <dev@dpdk.org>; Mon, 24 Nov 2025 13:09:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763986179; x=1795522179;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cy8I9LN4RyyJFGBcy6KdHCVZ42D5mTcPyvZ+3+UnzeU=;
 b=dGAG58YCrSJ9k9NtiedcYTdxmwCcmJGatagsYW9M/nEBuDSpnGL39nca
 I38gvrTSSnUsXhOq2f9tXZE5NH1bKLxUniyCvKrNaMIjX1uwFPkof/YtN
 oH1yDToBHQtppEM8rPUKA4ovDhsroCF2JaVwoJkM5hYaTqCQpl4Brztcr
 DmjMBAyz4kEd+vslQT5zzwY9hR/g1pNGWkCk9SiMhKeHvNZ7LeOsEdFTg
 CUsYqcNZxTPiCPTejnFc1B+UnDH4QmNygsMPW58rVt895n793JUol45Pt
 kLf9ZgcTbiwVZr9LKmPmP5DEH345z1DG0F2Lyf08qwYDJwYH1vsYu1OfN w==;
X-CSE-ConnectionGUID: EgUQAdJ8QUKk20PCDkcfJw==
X-CSE-MsgGUID: Dgmx+bORRSGJ+P5vRvjDXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65863994"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="65863994"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 04:09:37 -0800
X-CSE-ConnectionGUID: qyyCrdZ9R/OQiepio/Znfg==
X-CSE-MsgGUID: gVobCUohTEWI3FUBY1Sd9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="196607461"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 04:09:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 04:09:36 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 04:09:36 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 24 Nov 2025 04:09:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwYO97QQ55I7ZmgSiwWiQV+Dz5b47QYldQVh5VUOqgZq75ZnPTtTFKcL0/yFXK12t91tmT5LpfQGwSZW1F5QDZN86gRytAHGBSclHTNSv1W8GptfXMGIKh4FiYp33KVUWM0z5TF7Nf7BlRfZ4S1fReqRYyTOJstZNszBlpGcoNR2IZKOz+ofaOr42nIzLs740vw6KmqexrUFowClcKt3ihF2eKqG1DzNR4kuE8fDybj5Svxy3ulmvqMX3/pXYLi+HtrzERHBR5LApPHTCNxqVood5/+6ngPQerUjVCCJMnAHetqBJkFPt5fyBVoDfY61fl3M+qmQhJGIgQiwZSmHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw5VFwk8IHFk2KBK3LZ/nFGtJKvr+9VFsyAaF+g4uXQ=;
 b=qhLwA5LzOPAfUU9YCMfEItatXFZVUOaVtOSacnrFSVMG1c2pA/W3vkkxqXOHZFGJ3Vaj15kMW++tBe7G8l/uLQhrm3RGnjeLDm2ppdKgsTzz8sClfXjb5hw/0Rf3vK831cdsrIkO8fjSrbfUythe40Joe7m7gsqAljWjfYLoKpTqcdI+AatNQirthQrKFmbXHmv+/tXDK/nShRMTMcnk0ioxdq0phhpgzo9TDGVd1D0IR+QhkS3KmeZOZ8+YuaP0Kx6X5pZBJErUuuY3IGJxb1KVllie2kKs1ND0mW7Jxus1+8EaglhO02l14L771LYXOdG1wjxnfhqHBaNWAvdKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB8404.namprd11.prod.outlook.com (2603:10b6:a03:53f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 12:09:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:09:34 +0000
Date: Mon, 24 Nov 2025 12:09:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <dev@dpdk.org>, Paul Greenwalt <paul.greenwalt@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Kevin Traynor
 <ktraynor@redhat.com>, <songx.jiale@intel.com>
Subject: Re: [PATCH] net/iavf: check PTP capabilities during init
Message-ID: <aSRK-FE-yAgaU-oT@bricha3-mobl1.ger.corp.intel.com>
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
X-ClientProxiedBy: DU2PR04CA0263.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d6efc3-147d-48a6-4108-08de2b52547c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V2PDqvx6G4+rDMBL4ME/FQ3Iw1Dd5dn2wGsngAk13/XO++LfZrZg7Sqv0WvR?=
 =?us-ascii?Q?f7M9O0WjE2n6xvNXGuJ3g+JfmRBuci7vY6Sn68l97j+vuRMKbjosMzP6Pr4n?=
 =?us-ascii?Q?H02jmeoxR7d8tkT1bnHcrAt+/nvNLvXXWacz+Mv0gyj+lmRdl3vXok73L1uM?=
 =?us-ascii?Q?PUHT2L6VXPdDbWOr+t8mMH5k1rvRHYqUjqmEDVpCb8q8ekxPaLuFcmb9qEVU?=
 =?us-ascii?Q?PAh6PAjLLg+FtCgIt4IC6w5xSRDnv+ntE4aJeesshW9ztAggYiliwtyi6vsq?=
 =?us-ascii?Q?YiMO1GaLIGYlGGxREflJiJs54oJwg3IHMfVzvQ+8PNd4x307Yi/oXr+NdUlW?=
 =?us-ascii?Q?YlgEEPxe0gtgQDFp3lTqeB5EKt5v1vApdCUMzHccx+nS3chBm23YBjfQFg0X?=
 =?us-ascii?Q?5Gn+eo6OabJ99noGdO5PwpfFnh59UzHtBhnnpMEFz4l+Z9Lekzmo0T6nskZK?=
 =?us-ascii?Q?wWp+PGSXIR87BxUnKHfMj+qorhBC/nTgz6bWGonzMZeOLw9HnTqps9OWIjoM?=
 =?us-ascii?Q?uwJ44Khsm8n+j+0pe+8frW3JkT+2/R+KMgL0hi2IdSR1FCf1czZMvrGYTHdB?=
 =?us-ascii?Q?U9km97rWjPjFiVEVqD4whJV/Xja672AoAl3SnMiweO04iJYGnoEUqgnjg0zw?=
 =?us-ascii?Q?3Y20VO4JvoSxxx9RV4uyjvrsdRVbP8NpddlYZUzHE7/vanyU2V5zWvgi2tIF?=
 =?us-ascii?Q?oQKIpPWay16X+s76Nt7fKyiR9qM+zSVmdD/QJYOKtqmpZTSXJ+UyCOE2vuFj?=
 =?us-ascii?Q?7pwgjg15pUCmeSWBkdUx+HX0au8/agWq5Qo2Klm+JJvmisuR2vgGRYT8SonO?=
 =?us-ascii?Q?XtxOKqbNIawD0mkTVXJ9TzciGEjCooBAmoOc8nvVLdCa0hebX9RLekhNJvCa?=
 =?us-ascii?Q?9AYZwLeXS+EW5O0EiFpKSIA7d/TN7q6ogAmsqrmpTBKH7cXgRFVxirbvKuz2?=
 =?us-ascii?Q?1r7CP99vRSsjNsHqxNn3LS1Ize1s1mJKs1Jl226Gm5o9dKcUDrEfluI88Q19?=
 =?us-ascii?Q?Mtgoz3lqqKPk+Lr3yP+msa0o3BSe95kqYMh/i7HrO4TQit5WYK+E3zI7QzeO?=
 =?us-ascii?Q?FbcdJDDuFQel/YkOzrieLmLrtudptcZE6m2smZx+IcoLhd+vndQCi8w91jcq?=
 =?us-ascii?Q?EHI2jYYIvfC04M7/TnTnsV5gjnMC/EdKiV80t+5EYGcazZoYT7c31qBh4GSU?=
 =?us-ascii?Q?g/a6n1wXrFnwjdqhtqfnxfAjdme+9g1n1Xc+PgGyMv40VGm53fhP2Zp43P/S?=
 =?us-ascii?Q?1KNEmolf74mwzis78AumsbJ/Jrr8ZuiW9Z+8kiRfPncFqXwwZAwq/JR57w8L?=
 =?us-ascii?Q?kX54Glf/RW3G0n5CpwfB29cNn2IsLwp2inzQPhiwkcOdHlkzWsjJYRjewASF?=
 =?us-ascii?Q?q0/zoH4VnSyKZrHP9N4huL5I2w8ORQZEGWiD0YvrO60DIQbCLg10RaJU4Uav?=
 =?us-ascii?Q?3qA6r/GAPsJfSGw5POI7g4L5QV38p4V6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?thDUxM1DU6bxLww59MzruRPQ3vf3m9uvjmKqHSD0adUu8h2Cc1DpIgMFxAHc?=
 =?us-ascii?Q?1ch+RiFs+6a+Ho1S2brIGln+fM93LwqdahoCXlWQpMuoJ0I9rIbngqRG+nsI?=
 =?us-ascii?Q?K2uiG+0HSkHsOKldNTGoywLoAraS3AiNXysYhIz9upaaf+BbHrO6nl7XKCa1?=
 =?us-ascii?Q?cQF1X6mg800SN2vyOa2R7Wdq+gU5g3bGPS2iz434Pil+ZjCmhgCbr+X269jk?=
 =?us-ascii?Q?pzc8dhsoodcCK+9IihCY97nWnlwKxTDv+Z6vt0IQW4GNZEPxRQZx3HvSUyqM?=
 =?us-ascii?Q?HbVsUBFreI/wYzSMfhW88ajAL0CIIzkjHWw0zkrKtkeBMjJpy3xs21GOnAih?=
 =?us-ascii?Q?PEshPsc41Zry5Yxrtj7ePfNJcqhdOyFn7bTmZaFQgQVvcZdIOLP2mtMFLslx?=
 =?us-ascii?Q?xyu9UkINfDXOd6/+KN+ijV0poha8Z7IqCYoB1RRnJXt8FgPaRgToNNk4EBQ7?=
 =?us-ascii?Q?uMnAsHSlXkiyx9m6uXNMelcUs8bm/MUTBLioQA/SNzsMFJrA/UyBL078LnJK?=
 =?us-ascii?Q?kOLo+7AvvUy2+Lx0dj2JZR6SGcS5Ki53dTijQXXibZfzQcV7FHMj1GRgTolz?=
 =?us-ascii?Q?hlSnHYNQ5xxrRnBD/evLCBZyjrAbdDijClcZ/+9zQ2BcPzz6Ui4cwRxtQVQf?=
 =?us-ascii?Q?wQis6SWOYRKcAEm9015Ia/UZbN9IKd3UgIO8tmwLn5GdXjGS7pCmj4Kfyea4?=
 =?us-ascii?Q?sCot7IvK4UcHqm3a4plQyJhLN6Eg4/7yjQizWCb5ksjOGin+6c+f1x1fxuyh?=
 =?us-ascii?Q?G7/3edxNVooVEd0zPasRXJl/IGkUnwjyEdHhA2IAGDaAXXt6QafBvnGj88AU?=
 =?us-ascii?Q?f/OvIlIQx2EMQSEInr8MGBRsgtm1wtC47fEl6pwMX1mFl1i3KHszccO922k3?=
 =?us-ascii?Q?p/K7AB33SR2GNvNDAZXcUpGe8YQwUIQq5hOZn1Fprt0tvy5WGkgcnbx7y031?=
 =?us-ascii?Q?OE+aG+tCoFxE0oRhVNTTfa26cNdC035y6r8nKhPSaqGDpAoj/VApFBJQnXWF?=
 =?us-ascii?Q?Oh9KBboxETC+RMkum+ZqfFDRyZno+H5aDltHQ+34M4kqm4Pcs4NXtoDR0yvR?=
 =?us-ascii?Q?ir3lDBF3Ts5qRfuVq+NeG1nSKBO+JQRBLQlu5519rYXOVQz7t3Qy0CcTyuo/?=
 =?us-ascii?Q?OwfFs8dAJvthh2gp0fJ7s7VOA0hl/a733O1F1jA/kwLUN3WZzWp28eAkdic+?=
 =?us-ascii?Q?kMVcvgR41XRGYmPpt4JWcXoCjEvX41E3UbxGrEgwJ5wyxjEyXRo63lxtJN28?=
 =?us-ascii?Q?P0/NNuv8t/DYq7+TxRlbH1Hly2Y4UG4Qmeq+gk/k2fdL8pGztl15l2FLrnzQ?=
 =?us-ascii?Q?F89jb32NCplUAjpjqm40iselwnZfqvnxzMKrfJA4Xg4SXWWXNEM7pvkuQywE?=
 =?us-ascii?Q?PPDPexn44hunexkYNw6JyM7D0lM2sexmhZ6O2ERP1Bl0fcufpbzN7nyDN9Gn?=
 =?us-ascii?Q?x74oid/8wiRnRhmR318cg9nVk2i8gjW4gLEtl5mAnhb6acc0fqm+96sAw6Dk?=
 =?us-ascii?Q?c0fimTEkmBjaE2h1248JeXnbpPZk9jEePs2KzcSVkCj6Yg+Yffl2F9+ssfAR?=
 =?us-ascii?Q?CoIc7SOojupUQ3ZqAcpNKsjNlAMtXQGORgV95BxHI1+imoV4byKOXkFcHjPl?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d6efc3-147d-48a6-4108-08de2b52547c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 12:09:34.2329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUVI6pHrCTGWb8SV6TUI75KwjvVHfHT6outPA1r19RlvtP+eTUY/rZDOquawCNLJJJY3ktpL9+rrjkW+9eeUc1c7srpsHJQKxula3kCTviU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8404
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

On Fri, Nov 21, 2025 at 03:39:37PM -0800, Jacob Keller wrote:
> Commit d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")
> added a check against whether the PF has actually enabled Rx
> timestamping in iavf_dev_info_get(). Unfortunately, this function may be
> called prior to the PTP capabilities being exchanged, which results in
> Rx timestamping not being supported.
> 
> Fix this by checking the PF PTP capabilities near the end of
> iavf_dev_init(). This ensures the VF knows the capabilities at the point
> where the iavf_dev_info_get() function can be called. Doing the check at
> init is better than inside the info callback, as the info callback is
> called many times.
> 
> The capability exchange in iavf_dev_start() is kept to ensure that
> capabilities are updated after resets.
> 
> Fixes: d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> My recent fix to prevent enabling Rx timestamping on PFs which do support
> PTP capability but do not report Rx timestamping accidentally broke PFs
> which *do* support Rx timestamping. This is because the driver did not
> exchange capability before reporting its device info. Fix this by checking
> PF capabilities during iavf_dev_init().
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 3ef766de4704..9b07b11a6b51 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -2887,6 +2887,14 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>  		}
>  	}
>  
> +	/* Get PTP caps early to verify device capabilities */
> +	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP) {
> +		if (iavf_get_ptp_cap(adapter)) {
> +			PMD_INIT_LOG(ERR, "Failed to get ptp capability");
> +			goto security_init_err;
> +		}
> +	}
> +

With this code added here, do we still need to keep - or should we keep -
the existing call in iavf_dev_start()? I would have expected the call to
iavf_get_ptp_cap to be moved rather than duplicated. Is there a reason
to keep the existing call?

/Bruce
