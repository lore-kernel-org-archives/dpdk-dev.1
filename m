Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D7ECCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 15:12:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C72E2402CE;
	Tue, 14 Oct 2025 17:12:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4ABA3402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 17:12:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760454755; x=1791990755;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xy0g4xb/On5SaKVkfR53s4TBDSZHCZP0d3o3bVepkME=;
 b=bod3VVOw9vaBEQXNmLxnKOm3MEs1Y2+57HSSDyZm40cNUQFL7YOHNrGt
 rY4A0LftrdXNquFaomFxcwHTpHvJWNFOTlz/jp65xBWNmB4XyLYgf0iDS
 P7dHBuZas9MY2QwewrkiXkV39hrefbIpjNxq0nUyxnHB/Mim0/Lc+cphG
 z97rvtY7kZRpkLkptEFolyXV4UzpOLT5bK2XygLZX1rKZ4gihmX0RpHr1
 vbq24NEV0C4Xc1i5/V5U+fnZ4OqUwzJrMWrwibwC1Ho3QiV+hqyt6H0+C
 AfyTOn9BwOlqGddWk+xzlf0Ts7986DbLbDaMff4iNv/QDptlkF0CbRQHC w==;
X-CSE-ConnectionGUID: 73Vc144HQjqiPDGJV5/0rg==
X-CSE-MsgGUID: AoZK53xiTUySTQ/UaTZJ5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61652309"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="61652309"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 08:12:34 -0700
X-CSE-ConnectionGUID: X5+He4S3TQ+7kOH6xHuQHg==
X-CSE-MsgGUID: aYndBOJfTeqB/GtMEnEotA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="187004348"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 08:12:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 08:12:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 08:12:33 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 08:12:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeE8zkcpq2UDiRurjxI/qZBLj2YKCiwuS0AALxUs7YhUhibgsPcr2zIZLj7zqhuxeySyMm6heeadXAPU3MAXPasHe2ImHnRIZySMO3H4y2ezmzQgqve20D1cOKmEDWwjBQFeoy8dCfegglWMKJ4z7eQxqt1QuqOiqVkX28lImBumn1BOGaM3WfmUVAgGkgZ1G5n3Kl+BMHwOJjBlATg6DjMhnMWoIS3qdwFD8qQ7NG80+7KFzjwr0qaQxGXDf0V1ONdlWKmy2phjDXvS+svepUVa9D7MGxcUJDb02UI3d0FGuXZZIZAbizTTQj/qQjTqHOnL/f9MpYY1cHNg+V8ZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fczmn3Qlni57C3FhzwjUJClF3Hx6fwW9hdr2a5iKydM=;
 b=n2hkJ3xnIbGKnsnlTqMkuxZB8cT3AHhwm3YZZgrqk+mnDKm2buIT7CavnuXCE3kzspdoK/z92Egl9Swtm1F+d31QiReVxKn0duWuwGjjfqmHnso9VwjNceg8ffO/xjonGxuG3spmGTaqqTgC+BKWVyNTRJ5vZ+VBVxkFRQcyax23IrDiiLFeYmNoU2Ph6/2+3TjUIo8NqIiWIg4hfF+QcB/V7nekVWWM1DtBnML2Gba2sXBwTMb0ItjgDoTq92WHVxR40aoJn07tyU2fCEAeyGzlaQSfh5NlZffrwLpL9A2h+67pvVjgoceSVDXNjas8/RzQRRub88eYUFn1wCnfsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ1PR11MB6276.namprd11.prod.outlook.com (2603:10b6:a03:455::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 15:12:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 15:12:29 +0000
Date: Tue, 14 Oct 2025 16:12:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 2/2] net/iavf: add reinit command to testpmd
Message-ID: <aO5oWb_xaYbPhaZY@bricha3-mobl1.ger.corp.intel.com>
References: <20251009102835.926479-1-ciara.loftus@intel.com>
 <20251014123624.1413473-1-ciara.loftus@intel.com>
 <20251014123624.1413473-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014123624.1413473-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0058.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ1PR11MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 784c5b08-79c9-4dbb-bc23-08de0b341797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K88JXUo07X6g0ju8KfDeGAjAwFYan2IDAOcTQd3VBcMYSw9MgBgWAW+Ws7yo?=
 =?us-ascii?Q?N9oOy1bErEnUVF7s/ATLVHbTv1yVv9fhanjASTipRxJLw7vr0wdYJ9D2okyB?=
 =?us-ascii?Q?uRUjbraVF7GzE4JDZhW8ZIAq1EOrU38NNHFkbDFgTrmZBJ4yDyxrx4EK7u4E?=
 =?us-ascii?Q?QyEfzWV7HjnxBTU4oEDDGQOw+xcxvhfq9q+IQOtBCyWcW5D4gKq+gc1O1+Lq?=
 =?us-ascii?Q?+B76AnM9kCpTTQRuDm6N/025Skv60/Z+uyozt15Cd1Myp4QvtQ6fqIT5L8dg?=
 =?us-ascii?Q?kPM6Grb/Z3y+xvF5nDpmWpf+CRWR4OdJAgNkARQGyROlG1zo/0stWyV8UGNR?=
 =?us-ascii?Q?odH77qwwRs6CbIgQKl2zMnN2h97wejMNSNatQsF+OYPoFZDIA8anrVLKWbTg?=
 =?us-ascii?Q?0wHNOcPlikKySdbfPPUXyBTwpR708lXfTfF5YywRO9jhfrJkNJgKRh+o2Eov?=
 =?us-ascii?Q?vgOPm9XEQZ7gOIi9gX85uUEmYojGb5LNWKj3Id5YBot59jhM/UtxppLOImrF?=
 =?us-ascii?Q?nnMmZxI8Ljc41a2N1XvI2W2cFvoAJu9N25g2Z+UjjtnPnn6B/mVoyol6aO/5?=
 =?us-ascii?Q?XBRR/h2F6tD9GTe+BLiNBnhfKSIuuEbXaKaLQ4UMC0coYtbq82y+VRkd+on+?=
 =?us-ascii?Q?NMNU4yUxFysxi3f9tbI77frKxiXpoyUYZqPBrSlc4BGHe8cgAtRungnX/l+M?=
 =?us-ascii?Q?G54qSYWQhDv9b3GQvKfAZblQc6GtZzSWK971cSiFGg6Q5r8KeqKhlO3z6PXc?=
 =?us-ascii?Q?tXobOorxuprSiL/Z6h9rN7kH5pggz/4wfUQyUcQYzS4VGrSvsj2+4TdzfZLm?=
 =?us-ascii?Q?jlm76Ib4k7v3043wPeC6aFIq9Nsc9geEbPjZ0NS7pdZ597mOnfdHy5B03/W/?=
 =?us-ascii?Q?wCHXxd21y1lf6loF+4iCfn5Ug9qhUgj19eMiAviwvwirBfA3cBRaz8e7oryF?=
 =?us-ascii?Q?LAao//jFhNdoO9Nws2M67b8wi4DgPpZQ5M+WyAEwnXdXdlAS0rVvdKu1GSop?=
 =?us-ascii?Q?DPGZ3yTnPAfNbYGMtwFZVkWfjVAGlhcDxNUUbqqcC412+yFR9nQqA3OwCd4b?=
 =?us-ascii?Q?YC5en7EoV0OADMkbga3lDOw4yUb8suldVqugcpMPSSsgLIMxy9QI6aVYx4sM?=
 =?us-ascii?Q?9gIxSPI4JP43ze6TeIGMZrSKbPDdIXKfLhVY/4VS4NeKscgFWkr0mEyAmff0?=
 =?us-ascii?Q?rq5ZQIJpUdZypo47F9NfOyu3/384MZ7IaGNT5wj2kB0VudduuqYhpwYCQUap?=
 =?us-ascii?Q?jXAqOXjbGtUqZbG0FhEGhkHXm7cyb20sVGh8ye1CPD+XNNi9r7XbKH917H6m?=
 =?us-ascii?Q?Ux9G6HJwr74/TWB/evNiLSltifHzZlN+0o5dqZymRxNwcnCK7A4xd0sgcaEr?=
 =?us-ascii?Q?p0MkD19f8exL8jzVnFpftZCGEtFpctcX5yUIEmPDsyMEoONp8lOoCSOrcMcj?=
 =?us-ascii?Q?qVAs2BseV7mz21b9H88K+e/BBcTQem7I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IC1rfhx1A5BuBa1VZewgZ6xbTsqFbTj25IYXGD2lPMMQHcoBQeDOMnF0+dUM?=
 =?us-ascii?Q?SvoSEsFgOFPevXZslysTJGHKY/SUlXnT9kNjXWMvRDVRAzOFxmr0/M9jWFdN?=
 =?us-ascii?Q?mFoXed9gy3m3lSuDS9xdorUqhtxE81BJJSVkOZz+tmBPuc1fSg+rgk3dabJb?=
 =?us-ascii?Q?xjEolXgB+6gCz6Axg2akf90UrZAOMHDR+YlUSr0IYEkCyRtMLb2l+yXRKfDj?=
 =?us-ascii?Q?NKeu875UakUqeTMc+PF+KDklB43nWF86kolnHKa3CEHenMHO9BcOu18RKMcS?=
 =?us-ascii?Q?hG9QEy21ZAO4XKv64jnBwaZ4LBqwytbiESjIHfhdC5EkUOGpHjOuHIeWxgcG?=
 =?us-ascii?Q?+dv+RZbHF0l6AIE7vLV/K/leMz2ZkX3B8tuYNSfyVepB2nTb+tLDrir7LP2a?=
 =?us-ascii?Q?ileSk8F/BUwx7dC/mFj7IB/A2vphse3Pac6W6gDS5gwXFOPbvU6s5ZcSS+nC?=
 =?us-ascii?Q?PTyJdOxLdjGVMakvGlq3fZQW7TaIEt2PCNA48abTvaJrfl/mstS3Y5lbi1lo?=
 =?us-ascii?Q?VeN8c6mGw1F2r0KIG6tzZOkAzcmyGi6Xkv3uRb8rSHFbd0t/GPp5hCRM4PU1?=
 =?us-ascii?Q?tq/0xatq5zmB+1PRSOmrVNBhe7eLmJ6WtXzmhgvk9WAVr8syx0BF18Z3j3hd?=
 =?us-ascii?Q?F62bFvaLt5O3eQyEU3HM/xJOpU7PL6LV1mrKNo0g7NxWlxHP3LUrJJJEmTpY?=
 =?us-ascii?Q?ER732KzIH+agNEVF0QUC5/jQ9ALyCxVjc0K8z8IiWnKA/L/q3Lb89DWYcnSL?=
 =?us-ascii?Q?9GoseXmmGXyThRcUCMl/N2EddOIwa+mF9o8Z3tip35Bwn6q84IyNN7UplDST?=
 =?us-ascii?Q?IHKv4ChcVQyaRwmtpHTjGxf4xk1RivcvXijSgTF+/cNU6xDuL1NO8od5D39U?=
 =?us-ascii?Q?cJP9m6qyE0NzoT41HnbagJWQOIwsRm9DwwQ5yvtmzVfYDNRexyKoFxJGbIRR?=
 =?us-ascii?Q?6KTIU/q3yTb24z2gkj+gYDSFYzR8qVz9u6yZEBF8RahW6siG4LkAUGBbSWvS?=
 =?us-ascii?Q?cOoC6sNnMWAO8VpfwCiwCnFqv0YXlSwy03xWGnUxSJ184+Nfv9p+OicrPOWC?=
 =?us-ascii?Q?w+4ZTnTolGGYtPsDG3l3EEzmL8N2n6ott0nCfjA0atOvtUh7HT3sj495JY5P?=
 =?us-ascii?Q?K1q00EwJghA7za8vNWdKwjWN+QlpGIEOkMgJdlxlsrid8bwXkr/fOkuDd7nc?=
 =?us-ascii?Q?05EO0uVP13jgNyCtkhpbEP7tpNhzhDYsNWDvxMpS/c50a8WtagL0E6sIdaC9?=
 =?us-ascii?Q?bv4tawoWHFVOEQxr5rpLRPMr7buueP11qG85BQX+j2UzHaEgBM15v5IAoxkL?=
 =?us-ascii?Q?tFaVGw3cjM1wmoFaql61+M73usGp+QTqSQwnqevwZG9yqWVrbksfIWSHnW+y?=
 =?us-ascii?Q?95wRxMqi6hcWr5Rst7DebVta2Misey1Ca+G4csKqNWsmszfdyySw1E8BYFWr?=
 =?us-ascii?Q?LIWnQHqOF5w/7fDPi6eCBGRNvHSX8jpIVIrtbT8bsjaXgp6nNEaFV58E4++K?=
 =?us-ascii?Q?oKw+15vxlB/doM4U7ZrgcPFK67fJg0tOFuF+igHyXCTXtjD6sBVTlswUGJaw?=
 =?us-ascii?Q?sHAKuoayBjjeH+5bRQrBEPa9hCJvUeAhgQlVJwFWZcPq2+VkP+XNOXVk+cS1?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 784c5b08-79c9-4dbb-bc23-08de0b341797
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:12:29.7922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAzBTE+1ZfR6jw5kinM6hQNrC34QiofFRXO3oJAxPP/3MveENhfpNhNi6wQJH0e4MbgkiMjKxBu3/peFuGm2YPL/C4fHgnMM//j+8c8rq9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6276
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

On Tue, Oct 14, 2025 at 12:36:24PM +0000, Ciara Loftus wrote:
> This patch adds an IAVF testpmd command "port reinit <port_id>" which
> will send a request to the PF to reset the given VF, followed by the
> VF then reinitialising and restarting itself.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> v4:
> * Rename restore -> reinit
> ---
>  drivers/net/intel/iavf/iavf_testpmd.c | 51 +++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Taking this as driver-local for now, but hopefully we can convert it to a
standard ethdev API in the next release.

Applied to dpdk-next-net-intel.

/Bruce
