Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C880ED2F338
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B51D40615;
	Tue, 13 Jan 2026 16:52:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D0567402ED
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:52:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768319523; x=1799855523;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jlHtNd+etA+5XWcDFlygRrceSazpIPel9M4Y/faSO/w=;
 b=n7i0puAz6QLeEjBOk2C3U1/OVIXnHVgyv8oHf8urHtVHdFZs+Bdry56u
 xdsqtIYDSKAQS0xagnpmiRrUvIqElLXPw6/kBN+9QSSzy4HzzhVpik4ba
 GyGm9RQoUybG2UAdDR/rDpBToyo7zRkjkkW++zHYYcvXrRAywZSe+DpwT
 G+xN8EwZZmvkhqWxIv7tQZ4Z0CGXrRzIF+xf8s8FSHmwrqB7Xy2E4u4js
 jPccGrVvl9dcYzGKdMTVZozRAoNwy4CZ4goVFI3NP9+gwEEJPx/kHOE1D
 KK0H5rBVUTA5g26eFcRvVjZ//7x3p3336B7mHwFmSaV4eM6jmfhSjxXDj g==;
X-CSE-ConnectionGUID: 1JUwbkHKQYi5XOtN+dy59Q==
X-CSE-MsgGUID: fO4gzsVNT3i3y9hX1ScD1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80324693"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80324693"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:52:02 -0800
X-CSE-ConnectionGUID: d4mqG2ghST2XqKghH52ELw==
X-CSE-MsgGUID: aR+Ty35tR2G6tZomtlszjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="208573354"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:52:03 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 07:52:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 07:52:01 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 07:52:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1lgpA99hD1BZH63Apr2pIJXG/LPKMs4JULXlCBnTSQw27e7RzBqqCMMaxMVkHLx4vkHbgmpW2aIS+1UAPnCLj+lcs6dXCQ6ArPqx2cu5y0mKhb2+eGwKgflEkKIzTf/NuIxxEoMdQU5amNcUtRxkiPgsxKN/cd7+VEaTr+WaIM4XySsbW2GZDZD2LDWgMIfRP03WiHn5Ga1DN5yvNVDW49+Ad+00UFJP4jAE7EPsCz4JtdkTQsEDQhhC9YS/lmVjqG94LqeTCBESKjkpIFtt0rSk7xmXEUhci1RrTdoPbEDI9NQSj2n6BUtKt9B72ISj5+gocEPJDhmGKCwmB2LNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueBYLJ3jdO99T47I2ZHr9GUjiMQByvsjwZRCy6gikyM=;
 b=pbLmNm5W8CCQTRU4YsBreBXbTVumCgk1Wm/igsHiT9d70Zftp0WSJOHBfv42p5g/L2/2O4vNLZKfnFfL3cLONDK1mz2duORpGY3q2t9tJk46aCt+Owpn8NzrNpHjvG11Ftx50fbktfGKbJMBs8y5DV3/sKbKbeVETSl1HBWlHI8DuHIa3NQZFwhGdKF99YzRwMEpLprc4f58WT2sycZ5QhY5k9j3k7klp6Mg+O6EfxxgX3DW5B9M3DTBXwoC2MJyNAu5C9kZOdUDnyDwSuURKcF0e2/aDhobew5EwQzqJIiC82VEcO/V8VNBWwnPxXjPfULBk9mFsWI1lDn6u35QgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 15:51:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 15:51:56 +0000
Date: Tue, 13 Jan 2026 15:51:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/iavf: support pre and post reset callbacks
Message-ID: <aWZqGAzKjHj9OwhE@bricha3-mobl1.ger.corp.intel.com>
References: <20260113151757.567234-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260113151757.567234-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0342.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b3db27-5a53-4e3e-0a6b-08de52bbadfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hvzZnFxbB/E8r1xPWkUXFf78FlWckfHIq28sim+EU04hk06Ybysk2GVDYs2v?=
 =?us-ascii?Q?P3YBsSdmJ7DLNheALS69q20uoZHdFYjXIieGyY0oYZkUyZ098aEt+TiYe8K5?=
 =?us-ascii?Q?FU2FTRmsXpw5cF2+hySSFsSwGtwStQLytXCco/gbdQVlpfTAwxsQhrVkXUDF?=
 =?us-ascii?Q?Qtu6Z8P9PbnSN1qO98x+lOJKsUMngr5sSQAD6/jaKSMfhNoJ/SwgO4R8n/14?=
 =?us-ascii?Q?AwmQsQVw8UqXTcrTxMtHmVpn5xx5pdIYV1i+BDQovoVM0f2vLEuqbqcucT2d?=
 =?us-ascii?Q?EQ4Q+6LCKUqI0bSlNFgYfVUbYHzK825IeFQE5EyyFl2ldCnF10JelcdkmMQI?=
 =?us-ascii?Q?EQy3ADnj3hITLs8A1B1KWylMePNGw/aEa2NWlkEdzEf9qdUQYPWPkNt1kbkp?=
 =?us-ascii?Q?CLQtVDCsv0OuRRTJksUPaefh5+wdhIx9VyW0rFAz/STVNKgXciyYd57/a2pe?=
 =?us-ascii?Q?gjfNkBBiNxACb060ozihShC17EIqCDi7/n6J42MUs2CLJzkp4glHg0BT6mb1?=
 =?us-ascii?Q?QGxuNZiNxnhNrk8Xx77HyzAoRhMp9NwHlV6epiB1vYVSr58FZQaPFIH1f2Hv?=
 =?us-ascii?Q?u8Ty3tSxNbXm1tsCol3o5sbNF3H9nvTzXGCrH/ELSzRul+CAe/mA6P1ymcwd?=
 =?us-ascii?Q?crcxuLPhuImXoHFfo2j7AA98I+gW6ZC9aqshDzwMw/Az77aYrE9gu0MoTSns?=
 =?us-ascii?Q?Cg7WyugZI0qWpA9fa8BNw/Po5Xw1JqrlYDFYm3G3NDMySFWPCFgh/5il2Wrq?=
 =?us-ascii?Q?qPRdlIweBU72ddGVP/TnNLf79pLk4mTLR8WwfIu/EjVYKTrQMcx2pBvselA+?=
 =?us-ascii?Q?Zi8l7SuDGm4uE2kl2QPIAdP7qrd3tK8RFPCbO3MsHwqBLqygDtC4s7XyvPS5?=
 =?us-ascii?Q?mDF8nlhvYY1bmLJfjCiLc/gB/oniKYh+ZZ54HwFNxyYHvXOrLTov5sD3xbWj?=
 =?us-ascii?Q?6IylgV3qFasD5shMsPTXRj+U7EYOz5ISoaZjpQfFT8VDWJqIldOll7zE2irl?=
 =?us-ascii?Q?b8Cr1gFG28oaiHXQ8CHWQDMyfGcHUV0rbHYyoDYZbFOgRGkmLXtwX4MXErlD?=
 =?us-ascii?Q?fNZsj1HxT/ZNGSJwigAN7fqG4UZ4hCIQvd/20P7F75X4WDwDM2MGp5q6Oxs/?=
 =?us-ascii?Q?DsKzQl54+JfVMEYP8i80cPEhu6S8CSy7+SZYz9UHJxZdoZI6+IYwbKz3zqlV?=
 =?us-ascii?Q?opVjneeIXOREd0WJMIzTascdHtlRB6fgJES6CHF2lYLIwzy5cAeZcOpEGWLW?=
 =?us-ascii?Q?n+/E8aJv8ZHf4pckplfen/QU9Qnx9777OBH9PJBeCX+G09zyrG4KezDonnhP?=
 =?us-ascii?Q?+faAT2Ms2MOYTRn9e9WHJw5W2XEnnwgE98pEdeuCD7TWyXwKi9V4c3wFRZGX?=
 =?us-ascii?Q?u5QBEe5uNhOcHR7+vuUYiz7Nq14r64bt6NSm3zLNX5S+oKQWXu35gtBLZSBY?=
 =?us-ascii?Q?LsnCyUBTZ3fBmhaE0obpnEf/IvITHcCd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dcF14zqYkEjVasVZdTm0s8Ml2zj5tZklxZ2kub5nvyXsHMWM3v28tpTPvV2t?=
 =?us-ascii?Q?qsaAouBxZWm1wRdiBywjhYkfRVIC5UCKWjx6Nnvs4f19g7Pg6MaetfVeZLiT?=
 =?us-ascii?Q?v11L3FMsm8GyKNWTCQLstMD8BgS+7+oYq7BNdtkATJnNEFSH/G3mNDskByNK?=
 =?us-ascii?Q?kjDOpx1R8pvhFAinBV/lQmRL9F8iOD986/6Zq4Q10ejn0Aej3/N4n8Pv+KoP?=
 =?us-ascii?Q?WJNtjBlhcAWrRWfU1LczrpXz++knbzy9bVyluVtFsWFWXC5yyav37LUTh6UH?=
 =?us-ascii?Q?HUwvO/i/mL79/YmVsW0khwzEQDPYxytsqiRpruNTRf+5rDCQRAJE4kALgHPk?=
 =?us-ascii?Q?/M2vPe8XCwKlKY4W0agbdzy26m2GAiRqc3+Sh4T2BxZIWZKYZCgx+XHrGmls?=
 =?us-ascii?Q?X+w2FiU9WEOCk2vRQG1dng0oKNi7AEp2bpSq85ZRgHp9Ys7ReXaUP9DxdGMv?=
 =?us-ascii?Q?7+PEKymJxo0aTPLdVPtGCxcp9jgIjDVD+YX8KAB6ny1VdfIoy7jxqYYinXyP?=
 =?us-ascii?Q?JY7+OLnEElg2bG0TjuoC/q9JENv5Ye7L4He+o5tku7EQVmp9wCHj0LwlDa1H?=
 =?us-ascii?Q?EG+l5eGgbSoMj3eT8m+bokp0CDng6kaSTOAWsK2A4/H6wH99amim7HOuQCDT?=
 =?us-ascii?Q?Sl48U+Fl0Ng7DjWRDoqearmC749sleZiwoX8yEegO37cB+H55pPf85CzW/xe?=
 =?us-ascii?Q?BC2bKXXeGP5FhNUaCp9NP26vjaveryepVLNLMUAtQvIiYkZ/YJGBmzKT3F2/?=
 =?us-ascii?Q?l4KdmHlYt4SVNnbZFH0pJ6UNx/Ynp7v94IhWQzhucvUfyVZ/ZDj7LttfBdXG?=
 =?us-ascii?Q?lKw4CldINZ6Q+edoHUWP7O0u/t6//zLl6eQMqqERhZRAj75ypFqDZq2tf7Qr?=
 =?us-ascii?Q?nPrd5H/c83869YkObZ1DsWCD9bza58HW7cHU3Cp7AyFrXhRLBezNIlcJbsME?=
 =?us-ascii?Q?IL92xi5YG/3LqLJv6E/kJOMqxJ2Fz3gWDMsH/8J7Jt5KqSPRFBRG+OlrllFV?=
 =?us-ascii?Q?cEVr7oXi/5+zzthOsIphDtZu8/W7k/w6RVLIFGgueLhr5eMuPa8ZWw3zcP57?=
 =?us-ascii?Q?bAm07uafqhh796etRQzsQA4/hDrS+lL86UXZDyBreZYdjwBwCdKo+F7lG6EY?=
 =?us-ascii?Q?W0pSRaN5s/lQLukWrTdnTSDVUXbW/kXuYuvCY5xHQxfokHR9zO+ULEKX6/qE?=
 =?us-ascii?Q?LLSZKGdDaLQ/fmrdBqaEpvTOKEzpG8mHEu4zudYJdiOJ7HdfmE2fiOncbkKo?=
 =?us-ascii?Q?3j7pU1zZpUx0TfRgjWyymDaRvUfTlamk/xrkEe0QRjEK3Ykgxose67Q/DU48?=
 =?us-ascii?Q?ehhRP08ZxgpgDgRfUZHJZD1dwTHgf7jr2n4c2t9ysp0owm8YpKiQRBZt0FCB?=
 =?us-ascii?Q?FpH9sSPtpKFMULw6bff0K5ZJcjHDNt6wX4TTCEf/RhGkE+zPNoInMGJFsrpr?=
 =?us-ascii?Q?cmZCw4m7c9jPGb4xsZJk+o9fI9txkCPEvF12ymUGwZDROVAo6Ecvxy/Waw4c?=
 =?us-ascii?Q?HoCQKBIIu94bAGkbysVpSDZXVYnoJCF9A8IQvivGZhfd/v4F0zjIuDHzcOej?=
 =?us-ascii?Q?gpJHZJJfO2bHSq2/oQJqYhCLQyl7TFO4sYKJi7cOdgP/JyWqSCaVZ2ZmLoeR?=
 =?us-ascii?Q?Cm2h5HgHItcz9MttM0BWhrLKuwYaVcVHT3vHhCqcTP+ENpn5ivQUWcWUvOot?=
 =?us-ascii?Q?Ipz5AWxVy/ia+j/dam94diPi9AgE5Q72IFdC3CY748lRsmkPJ0Y5HmpkMDs9?=
 =?us-ascii?Q?Tjp82m6iKOxt3mT9NSfiMHJDOMdr5Z0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b3db27-5a53-4e3e-0a6b-08de52bbadfd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 15:51:56.7010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0g+Z0RF7E/dtWnvT6aKADcm8Ekl8OCDH+N59IK8zzuJvwK5tnvb7BMQciIECOqI8ZEPJAIeYbtVvcrG9zmMn4TC+8r91C1YDdg7lELaTg2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
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

On Tue, Jan 13, 2026 at 03:17:57PM +0000, Ciara Loftus wrote:
> The user may want to perform some actions before and/or after a VF
> reset, for example storing settings that may be lost during the reset
> and restoring them after the reset. To facilitate this, introduce a
> new function which allows the user to register either a pre or post
> reset callback, which will be executed before or after the VF has been
> reset. To unregister the callback, simply use the same function with a
> null callback as argument.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

Some review comments and suggestions inline below.

/Bruce

> ---
>  doc/guides/rel_notes/release_26_03.rst |  4 ++
>  drivers/net/intel/iavf/iavf.h          | 15 +++++++
>  drivers/net/intel/iavf/iavf_ethdev.c   | 62 ++++++++++++++++++++++++++
>  drivers/net/intel/iavf/rte_pmd_iavf.h  | 24 ++++++++++
>  4 files changed, 105 insertions(+)
> 
> diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
> index 15dabee7a1..770f9933ee 100644
> --- a/doc/guides/rel_notes/release_26_03.rst
> +++ b/doc/guides/rel_notes/release_26_03.rst
> @@ -55,6 +55,10 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Updated Intel iavf driver.**
> +
> +  * Added support for pre and post VF reset callbacks.
> +
>  
>  Removed Items
>  -------------
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
> index d78582e05c..5482472549 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -224,6 +224,17 @@ struct iavf_qtc_map {
>  	uint16_t queue_count;
>  };
>  
> +enum iavf_reset_cb_type {
> +	IAVF_RESET_CB_TYPE_PRE,
> +	IAVF_RESET_CB_TYPE_POST,
> +};

I don't particularly like having the names end with "PRE" and "POST" on
their own. How about renaming to drop the "TYPE" and then adding in the
reset again at the end, so that it's pre-reset and post-reset, which tends
to read better IMHO: IAVF_RESET_CB_PRE_RESET, IAVF_RESET_CB_POST_RESET?

Perhaps there is better naming again that can be suggested?

> +
> +struct iavf_reset_cb_arg {
> +	uint16_t port_id;
> +	int reset_status;
> +	void *user_state;
> +};
> +

I don't think we need this structure. When the user is setting up the
callback the only parameter they provide in this struct is the user_state.
Then for each callback, I'd make it have each parameter separately rather
than using a struct.

Semi-related, since the reset_status is going to be undefined for the
pre-reset callback, did you consider removing the reset_cb_type enum and
just using separate types and APIs for configuring pre and post-reset
callbacks?

  void (*pre_reset_cb)(uint16_t port_id, void *user_param);
  void (*post_reset_cb)(uint16_t port_id, int reset_state, void *user_param);

and then APIs 

  rte_pmd_iavf_register_pre_reset_cb(...)
  rte_pmd_iavf_register_post_reset_cb(...)

Just a suggestion - if you prefer to keep patch as is, I have no strong
objections.

>  /* Structure to store private data specific for VF instance. */
>  struct iavf_info {
>  	uint16_t num_queue_pairs;
> @@ -257,6 +268,10 @@ struct iavf_info {
>  
>  	struct iavf_vsi vsi;
>  	bool vf_reset;	/* true for VF reset pending, false for no VF reset */
> +	void (*pre_reset_cb)(struct iavf_reset_cb_arg *arg); /* Pre reset callback function ptr */
> +	void (*post_reset_cb)(struct iavf_reset_cb_arg *arg); /* Post reset callback function ptr */

Normally we use typedefs for function pointers in DPDK. However, there may
be cases where we don't too, so no strong objection here.

> +	struct iavf_reset_cb_arg *pre_reset_cb_arg; /* Pre reset function argument */
> +	struct iavf_reset_cb_arg *post_reset_cb_arg; /* Post reset function argument */
>  	uint64_t flags;
>  
>  	uint8_t *rss_lut;
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 15e49fe248..553f38a286 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -3120,6 +3120,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
>  	vf->in_reset_recovery = true;
>  	iavf_set_no_poll(adapter, false);
>  
> +	/* Call the pre reset callback */
> +	if (vf->pre_reset_cb)

DPDK style guide says to always compare pointers explicitly with NULL.

> +		(*vf->pre_reset_cb)(vf->pre_reset_cb_arg);
> +

Don't think we need the "*" or the brackets around the function pointer
here.

>  	ret = iavf_dev_reset(dev);
>  	if (ret)
>  		goto error;
> @@ -3144,6 +3148,13 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
>  error:
>  	PMD_DRV_LOG(DEBUG, "RESET recover with error code=%dn", ret);
>  exit:
> +	/* Update the reset status */
> +	if (vf->post_reset_cb_arg)
> +		vf->post_reset_cb_arg->reset_status = ret;
> +	/* Call the post reset callback */
> +	if (vf->post_reset_cb)
> +		(*vf->post_reset_cb)(vf->post_reset_cb_arg);
> +
>  	vf->in_reset_recovery = false;
>  	iavf_set_no_poll(adapter, false);
>  
> @@ -3183,6 +3194,57 @@ rte_pmd_iavf_reinit(uint16_t port)
>  	return 0;
>  }
>  
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_reset_cb_register, 26.03)
> +int
> +rte_pmd_iavf_reset_cb_register(uint16_t port,
> +				   enum iavf_reset_cb_type cb_type,
> +				   void (*reset_cb)(struct iavf_reset_cb_arg *arg),
> +				   struct iavf_reset_cb_arg *reset_arg)
> +{
> +	struct rte_eth_dev *dev;
> +	struct iavf_info *vf;
> +
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
> +
> +	dev = &rte_eth_devices[port];
> +
> +	if (!is_iavf_supported(dev)) {
> +		PMD_DRV_LOG(ERR, "Cannot register callback, port %u is not an IAVF device.", port);
> +		return -ENOTSUP;
> +	}
> +
> +	if (reset_cb != NULL && reset_arg == NULL) {
> +		PMD_DRV_LOG(ERR, "Cannot register callback on port %u, arg is NULL.", port);
> +		return -EINVAL;
> +	}
> +

Minor nit, but I would check the parameters before doing any other later
checks, so suggest moving this up as a parameter check right after the
port id check.

> +	if (reset_arg != NULL)
> +		reset_arg->port_id = port;
> +
> +	vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
> +
> +	if (vf->in_reset_recovery) {
> +		PMD_DRV_LOG(ERR, "Cannot modify reset callback on port %u, VF is resetting.", port);
> +		return -EBUSY;
> +	}
> +
> +	switch (cb_type) {
> +	case IAVF_RESET_CB_TYPE_PRE:
> +		vf->pre_reset_cb = reset_cb;
> +		vf->pre_reset_cb_arg = reset_arg;
> +		break;
> +	case IAVF_RESET_CB_TYPE_POST:
> +		vf->post_reset_cb = reset_cb;
> +		vf->post_reset_cb_arg = reset_arg;
> +		break;
> +	default:
> +		PMD_DRV_LOG(ERR, "Invalid reset callback type: %d", cb_type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  void
>  iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
>  {
> diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
> index dea1bd2789..365f8a3e6a 100644
> --- a/drivers/net/intel/iavf/rte_pmd_iavf.h
> +++ b/drivers/net/intel/iavf/rte_pmd_iavf.h
> @@ -20,6 +20,8 @@
>  #include <rte_mbuf.h>
>  #include <rte_mbuf_dyn.h>
>  
> +#include "iavf.h"
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
> @@ -109,6 +111,28 @@ extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
>  __rte_experimental
>  int rte_pmd_iavf_reinit(uint16_t port);
>  
> +/**
> + * Register or unregister a pre or post reset event callback
> + *
> + * @param port
> + *   The port identifier of the Ethernet device.
> + * @param cb_type
> + *   The callback type, pre-reset (0) or post-reset (1).
> + * @param reset_cb
> + *   The callback function that will be invoked by the driver.
> + *   Pass NULL to unregister an existing callback.
> + * @param reset_arg
> + *   The argument passed to the callback function.
> + *   Can be NULL when unregistering (reset_cb is NULL).
> + * @return
> + *   0 if successful, otherwise if a failure occurs.
> + */
> +__rte_experimental
> +int rte_pmd_iavf_reset_cb_register(uint16_t port,
> +	enum iavf_reset_cb_type cb_type,
> +	void (*reset_cb)(struct iavf_reset_cb_arg *arg),
> +	struct iavf_reset_cb_arg *reset_arg);
> +
>  /**
>   * The mbuf dynamic field pointer for flexible descriptor's extraction metadata.
>   */
> -- 
> 2.43.0
> 
