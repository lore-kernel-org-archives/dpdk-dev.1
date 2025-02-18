Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B93C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:47:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAD74402CF;
	Tue, 18 Feb 2025 17:47:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4DC44402C3
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:47:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739897228; x=1771433228;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7MojIrhV0EIN9ouMmcfj2jZoQz1x4W8lAMPrpQh1GAE=;
 b=DM5Vd5SGsM1GCeFpyuMweZ6BMsrkf8S3ufs6JWoIezJLtnQwdXefH2zr
 2lhh1bf2yNFyS4c+tbKTWwyZ5JidYEnvYbE8Yp6jIVjEX+GiK1u0A+sEy
 IByNWKxnJSbPx6ezwyyLo4YJPxmBcf8EEzZnY4pcO9ImvSpDIWcZO2RDd
 j1qpTESX1ac7x3qvV7HLr6FDhjSr+COXr5Ve4wRzEfMVYXMz+kk6SSghm
 eYtlA6fX1Y9Va5K4Zgqv45RTiybB0maAKSKQyaPZisSj8CzlxqA57HkJb
 gNHrdn7lna7wKZsZlzIifIA3troQmmPa5fk33xj/rT9HV2LeapJIgdiuK A==;
X-CSE-ConnectionGUID: l1TbKq5xSmSoycl730TdJQ==
X-CSE-MsgGUID: fWgCaMXmTD2+ezVEu1Ja4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40526064"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="40526064"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 08:47:06 -0800
X-CSE-ConnectionGUID: K7zQoPUjQBamlICbFv/fCQ==
X-CSE-MsgGUID: 7zrnJAaxRN+b50NiTFlzGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="119539483"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 08:47:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 08:47:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 08:47:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 08:47:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+oTSTGGD7jbksWLcX5VKXeU+MENNmFM4GL/b3kPW/4FcTPW8vjOFDiSDfiR769ZQ3cHIDn8iEr/2Cl/Xblr9VzS/OhqDWaeNLxM3P2S+3N9uF8IZTZEIQL5qhmSOqwNHOlsX3k06Z6k/0sjX0IJC/UWL53z2i6bY77lJVeDkbTKOpOF5v2DTNWcGu8UK59B1bZ1G4MGQ2w1QqkUJAXUx0NowLsUC0sFjzJ//NWVhKWuFJOKRkiYvReHSf9wzr1Wh+qCTxRWb21Iw2XAHGmo9b0fS+m1/F+M7ky2Uz4YioIFAOPgDhuRQaic6CKT6M4quVzeaHARHYWuKLGFY+83Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEFZiQD5EsREcARW7cuQxrRmDs0Z64Oj4BlZX5WVdc4=;
 b=OW5+z1efZzWuW7bQ7Qc8cOknHKp8HAu61RckIeis/an+uOn1uf3RhweOy0YRzE4gIxmu+Tf0N1vPpOkmn7ONahFQE2ac9hNCZR84hvYvGBLJmJTWP1I6I4C9e0oyMpBBHic36hClXHv8UUzR0DFL/L3dg+qDvvyzaSws3sNCo1Otc7PBrAUbphi6egXthqnioOkdn61vcD+gFiwMsNxZpA5Cd/ZWVKxNCw0PAWRhW7qN/I8/bb//2iYZg/iAPlFeDqipHXfawxt0ON2HxEKc/xSvrc71+uhHpcOVzrIfIDnE5i4laFE80ezzKnvDGeo40R/1fuSHmE5/q9sLGrjNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6980.namprd11.prod.outlook.com (2603:10b6:510:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 16:47:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:47:02 +0000
Date: Tue, 18 Feb 2025 16:46:56 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 03/10] test-pmd: fix printf format string mismatch
Message-ID: <Z7S5gGEGpNqwoctj@bricha3-mobl1.ger.corp.intel.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-4-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1739896329-1946-4-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU2PR04CA0248.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ca6fd4-e00c-422f-5582-08dd503bde7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dyg1KX3tXH6apA2wzKLH84DmQiYy/MACK2L9HfxhkwnQ76eBjUvb78QzKN2B?=
 =?us-ascii?Q?p/XyGPlRNKUzygEDAw5v3HgUqCgIVquLmK7UHBMJh7SwwITI7e/oeOk9Vr0D?=
 =?us-ascii?Q?RUKHSVolbydwzJoTc6LsnZ8Cxi7z+1wTNRCyv/x9c5RDJM3rucgMDAvVVycu?=
 =?us-ascii?Q?rU6oGag4XcqkFi4Z1LYSTEf5+dSmN06XiOrqhJkmVPmRnZI1bAPshBOqEjnG?=
 =?us-ascii?Q?wy0qo1zeRwjm5yDfZtC7a5byERnG6c/mRRDaqArcpFD77dHSl5TkDYGvMoNZ?=
 =?us-ascii?Q?JPzI3HhDq2C86NuAm0yn3cnwGv8jwnxBR9dfxvYJU74wEQqwL/EqrndJV2fx?=
 =?us-ascii?Q?sXQMCyHqCNRnNzBDcOAN4XUc8ou2ez47cjlZcni0ka6RsBk8uppAIIG5kO8Q?=
 =?us-ascii?Q?E62iNgfC30NnwX1/OEyv7IpgNCJfxzX1MwNg+iLITLcwGQ77m1NmlnlRGJPp?=
 =?us-ascii?Q?YyGyJLBww4XMpQR75mU2Kxqz8hIoTC3W5rpa3bKfCQL9/8PqU8Ojhh7Jc5uN?=
 =?us-ascii?Q?T/vQc9vwO8KDVfwKeCMhetv+t5Q2cwAJ/v3TxnFJfPRBoN7ZMHtIN5m9TRr1?=
 =?us-ascii?Q?ei7riwfnfYBVPNg9lstyES5s8cPcRaO7MVJ8ZEhDUxsM6mZ6KJ1YHWQCwHZz?=
 =?us-ascii?Q?6WSYzPOTznXd90++1gMr1G5dsPPupI/ZGgy9tEb1QDyuIaON3VwCcWZg+p0f?=
 =?us-ascii?Q?YfMfkJeOMVwBeViRLn15zj3uTcKIB6WjZhTsycwQv3YsIR3uEr/1z4bqkFed?=
 =?us-ascii?Q?1M3pfKLP7r25HW+Kzpgs8MZz0/N27d5t4UDy19XHARv5xw1I/r+HlsiKxilv?=
 =?us-ascii?Q?PkHiboJxUwNp74BiOkYr36LaTBcQe51iEc46YLYFs8+/sfpciP1nVxdlVLZN?=
 =?us-ascii?Q?Pi4Qr3LgktPlK3lwlGgpA7eydkDuDJie2hG2KU1Zp/kicPovgi87ljr9Gn0j?=
 =?us-ascii?Q?lr7ZFrziWMgcPspd3ZHLA5wMts8kHtOZji2FJaxf+ZJMe4XQvdiy9NI8E13G?=
 =?us-ascii?Q?/DZzzKvwWRz+aMSiKEcUCD9YbF1q7DaUPh9XuEfG8rfV5WodLd/AvHvbMuhX?=
 =?us-ascii?Q?fyXjP9O+6pi8IpTCcwpACYAQHNM2TMK4Zk9TqcYPHu2CrZbbYQwA9/H69Zcb?=
 =?us-ascii?Q?yrkSGUFhRQCTBq+EjDM13J9YvJZ7AWprxJNiC9a8FRLM3OD/g27LS1B3r71y?=
 =?us-ascii?Q?sv6vfhzOkWmcIHowwB6UgVgJKKuJm/xKqXMcLSsbdFuyJwXtuWH9Q8LbPqTv?=
 =?us-ascii?Q?eU2irlHC3zjUEHLmSA2j/2qk0k+VGOqjZ92Pk8ccycCyTDRMYUMWhPG2kq+4?=
 =?us-ascii?Q?PPEzxY+0zzVA0vAxA0nMsbRXbDuuY1/As0Z8ZRgVHx6Um6uYqzo11w49OBml?=
 =?us-ascii?Q?eX13Z8rpbRnAnz0PU137CdtQWgGC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lqm0EdV8dMLYzrUf0DpcjCal8SzY5NMY3G8LxOJWvYdW612ndWCHegqptS0S?=
 =?us-ascii?Q?fC5oV+QF004mbuffGy3AOVlvKxRZdc9yoXz0kS1atWm+DN4rA/ycb9GJjy6G?=
 =?us-ascii?Q?j9Ysb0WDg9PgWmx7b13JkxwdgapbdthZg80i1U84u/ZLSeZcaF8bfPmM22mL?=
 =?us-ascii?Q?r/DCVmCPkUqQAm62I/a77fdVc+0tKXsdK1CbDnSSFE5RrvSV2adTvEA9VIj4?=
 =?us-ascii?Q?yvBpQcxDtQIUM030n+4mmXQY7W0kJv70w3C5zDC26FWyumTHsDTbZFQ4i2f9?=
 =?us-ascii?Q?QPnWusRv+HDHpfz/bufuamxOGnBORo3wmJ0Q5oMfio0UYdj+r4k81ZGC7HhL?=
 =?us-ascii?Q?W/2Hkfqd/YcTCq/d8QZKsz7HiVA2pTbaLZWMDPyaWN24mY0+eoIVH7Xk/4eb?=
 =?us-ascii?Q?TpCoyPZvbNN/q0HY/F3Wgkk5uvm73v00iPEzbRAEIdxGwTCNFk5QJR4jiqgh?=
 =?us-ascii?Q?BTcQLa4V+Fdz3UBtP0M3KbmpYqL8iuuFqLuSwX4/+rxEkN71Yqe2+3dc2Bg4?=
 =?us-ascii?Q?n6VN//NxHeQ0WHFCZ3zH8k5Quv+4lxauEHzWx2v+Ujn01+LrZ65ogZ1DNDm4?=
 =?us-ascii?Q?j+mJ+4/e/MPjidWjRlVkfl69tUffTCccmzp/hf/vIpDHud58yn+ZRWcxRvGI?=
 =?us-ascii?Q?i6Hee8KGlOdJhWpyfpCfDNn9cDTiT5eLHPtsiSh5/RdLed7D+PtUzEEtKd+p?=
 =?us-ascii?Q?UnjZ6mBEDT3nnCol8OchdTQkl/au2It8o2SjnOIWKx2upGSc3gFn2Kjg11NE?=
 =?us-ascii?Q?H5qMurhDdXgXfVEGE++ZGybgEFo2Albu16Jux//o0IoNM6TfkyRq5u2QYF+b?=
 =?us-ascii?Q?CTUTS6Y2KxFc2K/da7OekNj6LQ7gPpI/EH5MsAutFR4Z0OyBJtsDI5C3Zbvb?=
 =?us-ascii?Q?FhEgvDZHdh8DyHKaYUJrpt0M+pueJ8O14G4rwF+bi6stqGGRclGliXTLkG1d?=
 =?us-ascii?Q?K9BfMaj1hcmqD3NVEkPWsM44QzW51eNDMMCOg/wOo6z6TLpolFYgCUkwuQoa?=
 =?us-ascii?Q?WnaN2LOpKOLwVT1TXVJbb1n5NbFirVDFtNo5aAUvC9W8NRznNt+izFBYXocL?=
 =?us-ascii?Q?rVkHs2XsMi/2aktkJmHlkw9PAiUaO2Ok8udDbyWYbhw0ip+HxYVuf86aWcik?=
 =?us-ascii?Q?uTi5Wrqr9IHrDq8Vuwfpcjttbnf2CWAqev8QE1CgTZL4uzJa0ka3i8C/tj/d?=
 =?us-ascii?Q?oRSnbz3kL8oTrAd9JRXLp1Kf6kKC3X/sHsMdZ/HLc6lHklJt/j4XJQI+03xT?=
 =?us-ascii?Q?JKytO31mzvrCYPneDNS32gnTTVpKoAGlLBOvVyExg9HWOg9kK6isFZHYsRc+?=
 =?us-ascii?Q?/CzBdKtPLV34ytz0jd9j5icK0aejumhV5S8bBPtgmCm4LRWmNAtXKMVFFuOu?=
 =?us-ascii?Q?DmBYP6N095Uc4ToTVux465sLO3AaBebM9IQOUrjNTXP9YKXw7hEVGelmMVCE?=
 =?us-ascii?Q?Ae1hLmyG5Bg0wLhpZfskH1Wj5kJzM+ht8TyzADtMazilnAUQp+YCeu/kwEn7?=
 =?us-ascii?Q?OBtkJjDUd8rGvf3mpfH/wQ3BfOKfLOl2t08VpmgKcdN+ExOg33SaxgnQWnSC?=
 =?us-ascii?Q?IF0+3ETPFlg/GPgdaYwvZQ5MNMycuVxzWuUtnwgXu5hlQfz6CAEH/JjLyLUS?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ca6fd4-e00c-422f-5582-08dd503bde7d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:47:02.5305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnmpqoQ2BxPaMRd7h064PUURN9tB7LlhW21PeTqaiaQlvtgGwPi4IGj80dL8QtMXouLmGi+xBfe/74ZIBNrNVWumqxBalTzZTNNLZW07UfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6980
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

On Tue, Feb 18, 2025 at 08:32:02AM -0800, Andre Muezerie wrote:
> Compiling with MSVC results in warnings like the one below:
> 
> app/test-pmd/csumonly.c(1085): warning C4477: 'printf' : format string
>     '%d' requires an argument of type 'int',
>     but variadic argument 1 has type 'uint64_t'
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  app/test-pmd/csumonly.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
> index d77a140641..8de5ad6ad9 100644
> --- a/app/test-pmd/csumonly.c
> +++ b/app/test-pmd/csumonly.c
> @@ -1070,7 +1070,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
>  				info.l2_len, rte_be_to_cpu_16(info.ethertype),
>  				info.l3_len, info.l4_proto, info.l4_len, buf);
>  			if (rx_ol_flags & RTE_MBUF_F_RX_LRO)
> -				printf("rx: m->lro_segsz=%u\n", m->tso_segsz);
> +				printf("rx: m->lro_segsz=%" PRIu64 "\n", (uint64_t)m->tso_segsz);

tso_segsz is already uint64_t, so no need for the cast.

>  			if (info.is_tunnel == 1)
>  				printf("rx: outer_l2_len=%d outer_ethertype=%x "
>  					"outer_l3_len=%d\n", info.outer_l2_len,
> @@ -1082,28 +1082,29 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
>  					    RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
>  					    RTE_ETH_TX_OFFLOAD_SCTP_CKSUM)) ||
>  				info.tso_segsz != 0)
> -				printf("tx: m->l2_len=%d m->l3_len=%d "
> -					"m->l4_len=%d\n",
> -					m->l2_len, m->l3_len, m->l4_len);
> +				printf("tx: m->l2_len=%" PRIu64 " m->l3_len=%" PRIu64
> +					" m->l4_len=%" PRIu64 "\n",
> +					(uint64_t)m->l2_len, (uint64_t)m->l3_len,
> +					(uint64_t)m->l4_len);

Same here, using casts and a changed print format seems wrong in the patch.
Either we change the format string to match the variable type, or we cast
the variables to match the format string. We should not do both, IMHO.

>  			if (info.is_tunnel == 1) {
>  				if ((tx_offloads &
>  				    RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM) ||
>  				    (tx_offloads &
>  				    RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM) ||
>  				    (tx_ol_flags & RTE_MBUF_F_TX_OUTER_IPV6))
> -					printf("tx: m->outer_l2_len=%d "
> -						"m->outer_l3_len=%d\n",
> -						m->outer_l2_len,
> -						m->outer_l3_len);
> +					printf("tx: m->outer_l2_len=%" PRIu64
> +						" m->outer_l3_len=%" PRIu64 "\n",
> +						(uint64_t)m->outer_l2_len,
> +						(uint64_t)m->outer_l3_len);
>  				if (info.tunnel_tso_segsz != 0 &&
>  						(m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
>  							RTE_MBUF_F_TX_UDP_SEG)))
> -					printf("tx: m->tso_segsz=%d\n",
> -						m->tso_segsz);
> +					printf("tx: m->tso_segsz=%" PRIu64 "\n",
> +						(uint64_t)m->tso_segsz);
>  			} else if (info.tso_segsz != 0 &&
>  					(m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
>  						RTE_MBUF_F_TX_UDP_SEG)))
> -				printf("tx: m->tso_segsz=%d\n", m->tso_segsz);
> +				printf("tx: m->tso_segsz=%" PRIu64 "\n", (uint64_t)m->tso_segsz);
>  			rte_get_tx_ol_flag_list(m->ol_flags, buf, sizeof(buf));
>  			printf("tx: flags=%s", buf);
>  			printf("\n");
> -- 
> 2.48.1.vfs.0.0
> 
