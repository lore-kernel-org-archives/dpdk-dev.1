Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9169C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 11:03:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC30640289;
	Tue, 14 Jul 2026 13:03:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id E727A4026E
 for <dev@dpdk.org>; Tue, 14 Jul 2026 13:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784027014; x=1815563014;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Rv3b22y+fiptCDz9k6bRV0QffxD3l5ssFHiWXGar62E=;
 b=F9gK2ZiQN8oT14k88iDYJNEkhGfOQgE2Hi4cCcXLaCRSoxJW1NcGJU6V
 3dVybkBGqX0jzG2LL8Ouc6iWLzsWPyKkqupm3pjvRmrikdDqVi6fsGmk7
 5aLQtqUgxiivVxVXR4IyXDHe4hgo2M3BtxRpDkq3FdHfOj7q7L1n6IRVk
 nFT+qycXGv5rPVA38rq5bMqUEruDUcTfJwIRcVNZQQPpZqYfJRqhKFj7X
 PzXa9yVITJfGglOPrH6GK5lSrvYkV7MUcO3co98DaR6wGNpaIjEKGn6iG
 RzYcnA56/ioqSOt8esGeOKYmceaOzlY16o2yOl83lcL2sZKmomVxsdEcl g==;
X-CSE-ConnectionGUID: qHi7mWEqRQ6itZpVIx7aYw==
X-CSE-MsgGUID: hbIU+vhCRRGwZzYoxQyIxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84526096"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="84526096"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 04:03:33 -0700
X-CSE-ConnectionGUID: BF3uDLJzSviaBg9l0t0bxA==
X-CSE-MsgGUID: 397eGXbSR1urn04Zg4lqsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="254079538"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 04:03:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 04:03:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 04:03:32 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.23)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 04:03:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVHOwDek/lx8xHgphlC+/EEPPg8TwhUTNa35SjhQTKL8nqLwQUaFESaREILwQjFU8XB/SNmnlwHV7scyUhgYtY2zJG8fhLr4R/CdPAnbh8JNJvyg7L255Ko44TMOmWmjS539TU59rbMCgT/oeuX0Ui43YprwLGcEc7IfaC6U/pYXg1Dla8g1BYpUJd5pAPk6vhsRWEmWTriMhqPnE81LiZgMu6eeKCvVdlyZyGazp0bOrBzUtyovaGYzAZ8IZg4thH5wDW5tz3FLmXzbZrWlG3b7ASnxIPrRfJdxOysow4ovQjIMU2mUfiEqTQJdXWt/OMfp0CMpCscHfw9t7IFjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgCEUUF2ITCg7MDW2GhdfEnszbsBbCf6zvBxuOT5/C0=;
 b=h30Itd7bBIiQdt4rKZnnYk151Atfm1rY1gIm+NWhEvdNi5bd0cdhPbqNLBc3AdmrPFD4xtU61lVHrBnDCpJhJQk+kBaIF4gih1XhuOBd32F0WTYSouYckOhjX04JCXMWsbWZyQgHhBa145PJo+OBq/fPSwK5yQPMZJXP8e2MUXwlsTpwQffe8+IjMoCrGAgl8RjZ5QCABHh40Ycp4yhkk51q/XBPfCC4zKBjrZubhrbl3ZZ7ANNz3XAYYrpnXk5oaxZaTDLnxsdI9kZvV5HwzTCoYDTB6ZwYB/CU6A/cWB6Yi+GHOd4DWQKH95iv/kEpf3+121pwVlsaHX2NWJvhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH8PR11MB9854.namprd11.prod.outlook.com (2603:10b6:510:3c4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 11:03:29 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 11:03:28 +0000
Date: Tue, 14 Jul 2026 12:03:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
CC: <dev@dpdk.org>, fengchengwen <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, David Marchand <david.marchand@redhat.com>, "Thomas
 Monjalon" <thomas@monjalon.net>, <Selwin.Sebastian@amd.com>, Bhagyada Modali
 <bhagyada.modali@amd.com>
Subject: Re: [PATCH] dmadev: clarify last_idx documentation for completion APIs
Message-ID: <alYXfN3OXL6eKntk@bricha3-mobl1.ger.corp.intel.com>
References: <alXt5X6MsOEy_5IX@bricha3-mobl1.ger.corp.intel.com>
 <20260714110043.3424477-1-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260714110043.3424477-1-raghavendra.ningoji@amd.com>
X-ClientProxiedBy: DUZPR01CA0103.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::15) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH8PR11MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: e35fef21-216a-47e5-aa7d-08dee19788f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|6133799003|56012099006|4143699003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: 3SWssMHE1i2o8HodBMt3tVYKLO98Zna2yIZznNr/h4gJ/0ZcLbyery0hR6yTfrq2VuMn82iL3JSm7jzRMOXJ/eIQf9HZw1AydsUc1jKGkx9u645jB512Hddsuf4kJwFnFFnzOMFQBgUxQDQ1HWRIqvL9tyrwwHMILikMNtNwCM7JrzgWRvdPegsO3Ys3ha5s/wg8q3v6Abc0ejrEaCASXe0zlHSY6vWigN1/k3+GrUNJm4Dx4j4yS/cCfuQFeOTQuOTF0PcbOv00J9dFVW7ZMn+8dcb8qddr0+lE+7Vy/q+heTguVIYr4u+vPdw/wYRNIghG9Yb2Y3m6bgXWy+bNAx0GItAX2eiAjCfikKEmFnGk1hwXMzseUH1n5PtpHmUw0l/gE0Axw4RAo3vf00Av1qVgOD5oc0TtVHJYEuMEqX+x7Dcr4fCD7EimZ2HtfEYiqi2jLoej1y9v7xxGnrKFO5BKlfzpPMf6c1UrdWUKd479eAAoxwl8Sn/nDiZ8jSEoxOQSAvW+HdrxaEzs+rTepQLMnS9dkDXs8xdSLR6qK3Hw2lE5boV1qEoZqNAm8Xb3BoXSRxkDavD3iuBwlfm1lZ3wpbrLnH1zCsu7ugVXds3cvuibcdX/9GgcaIte9znJZRmhoI9hBjglu/mnbjIXm6rkMr0Ih+xMgCbw9qTGI/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gkAJ/LgbRQAdqDUg99/ZPZiTUAlWTiCLlbNM6gMfLBHcDR5/eczAu1PKTt3v?=
 =?us-ascii?Q?XXuf7m1i631vqvQ2FZJZNHeJJ34jZdCHQ1AGKCqiM7Xm/VeV8xz2uxeQoaV7?=
 =?us-ascii?Q?+Pu3WZNLmwbMVSdWUZjOtSRw1bsWBkJAWLTcEkv2vvIJ1MhQFGlhHthdTOFt?=
 =?us-ascii?Q?1GXVamCjNDOZdaUUfCF5ByIvxRbdNg7JotH0vYgX4GjYdRe2ylLq6uWDvMj+?=
 =?us-ascii?Q?fl3uWw+bNb0KhgAO1GEKeDg25q4LcGl+IFVEaHZ1/NLIGIK8uOu58MI06dX1?=
 =?us-ascii?Q?9fPF7XTBcRHwI9uqyB56oOgRL+44ialiDEL9mBYrjoQDc4G1qOaFyvM6LNQC?=
 =?us-ascii?Q?ck+qQIdARNQOjXveM9hCXb5N4Kwo7W6y8wUoKwv2Z9vwnRXGqf3nI8xbwmxo?=
 =?us-ascii?Q?fqJSw9BDSBfm1wMF5Dk5hAR0TvBrn6m3hNwKjQ4oDUeQBRDhUgHI3BTN0Vc5?=
 =?us-ascii?Q?jr3rG+Jks9OHEGEClx9D4A4AGKZb54ZIT3ErYhCZ/JdJ1FRnOs7RnNSDtG7y?=
 =?us-ascii?Q?0oA3XKrckM9QDSp5d6ikY6TQi0xiWE5GmodienuQYC2iHx7ilGKH58PPQ64/?=
 =?us-ascii?Q?IPnOBmua+Tf2PUJWny7Xeyv7iebA8NEJuS1zsS5rE/3ki69YeH9c/DAF4TOC?=
 =?us-ascii?Q?0QrwVsx8F+g6OXsmPRFPMQdkXR0lOJLH1s1YnrOcYDXBQ7q1khsbv3i2KpE8?=
 =?us-ascii?Q?jccj4Ul33xgDQxhDzyF3uwfOXluvFJKBtSuu13zZ8IIlQtMVNaRIgBF3OfaX?=
 =?us-ascii?Q?NTvfz2PFwrItcAzPvON58JDKUm+9I5ZQHr8Rx+mDkPOmJF219uO85oVfXhoV?=
 =?us-ascii?Q?lcWDFOBWjM8LGQw+JklQfWxkI2sVZw3ADFpwk52YsTeq7TNjHFnGEsIM5xdd?=
 =?us-ascii?Q?ufTrfdcoXary9rrP879xSKyXImWbBfzQ4s1SIVnvRtRNXCTFGmww2/wa5Bng?=
 =?us-ascii?Q?bsKA8XYJQeevs7XSt9NGhllCyaxIJyE7NseKJ6nmY0NG9B7wRaiC823/zJu6?=
 =?us-ascii?Q?Mpw+tvoZFN4MefCTj42XYlMoJy3rVrdM98mgy3S1iiCpcvOQYdrjfIo4Yzj1?=
 =?us-ascii?Q?bjlbYLDc+uOiky++VuC82Sqodi8lqM1TGukJbLaDYfkGI/ytHPV2stCGpCsH?=
 =?us-ascii?Q?f4PnY3bxvNqdnWzJ/3GMwEK51aW4LEK1kehsTSpjhopVnwKfBSSQYmZBtJ/H?=
 =?us-ascii?Q?uLU7TZGHmp0c2cShiYbkRSKhkXdsjBlJvZrU1FiAjy9un0DEcVXKROTBcdL4?=
 =?us-ascii?Q?PwFmx8/nO7OM5QriTQ/OWzs0iWkb25msZ//QCoAboHmoURUdDbHPqYLjHIkg?=
 =?us-ascii?Q?63HUGPuvybpfa7DV5Nl6U0QwRf0RSBZbaHcZ1zxEBytT5a5ygr+Phz987xb9?=
 =?us-ascii?Q?oH27S8nicoN4pkVFAB/3HBD+O62wknq9XJLw1+wyodbDaDgqvxlqZCee+mTS?=
 =?us-ascii?Q?GMGDEbAuINGadF0wNriQEyoP8Q9or1njpgEutAeI+wd1PuuUQ8/Ix3I065X0?=
 =?us-ascii?Q?d5FQQ+2jm/1hhdxPw/9tCxWDCH3lA8AFhmH4BMxzfMPA7Ac3FSDcn+nYn9Qm?=
 =?us-ascii?Q?FNpDbx+Aes22jOxTbTkQoINgtqBLrKZctQZdQQMcV3LcgI19t/rY8e7JxeW/?=
 =?us-ascii?Q?MDZxN6kJu2pBCMG6VXtHedo0RdLKNGWzwKyJOxd98zUF/TjOa8T62um6ys1y?=
 =?us-ascii?Q?yqhREBQypxt4VkugY+npUTXwVb2QrqM8nMPYv/DezxiZy6TmLmqxKmItyWSZ?=
 =?us-ascii?Q?UNyONc80Knc5JZlOKcOLRw5g/1BC5lk=3D?=
X-Exchange-RoutingPolicyChecked: e8a7mkQoteLlBXCYFUPRsL958FGlxW14wp58qYtsOAyThNn3RKCTc3srE6jRIzeViZvToHBulDCx+aKiu5c1x/zQ0dpx3T14u4uUOfj6JrEJ/fM9261UJV59IlM2IkUU7ArFMHUmsMP/APVI81O9HTqXdNSrf3KdK4WkLcCu8AUZ0NHbc3dqp96FgYxxiYi3oDkeLVZSXTsPDT/k7H4COPZo0pW8UdkwXJ9RNtu2V4bCWCxP8MEhZQ4IwrY0bJe5U++ZOMDrcC4PSgzI4kIUM/Fr7WfEUitAlbyAkwH6iNGaITcX4ykyC4vjg3FEvtGh4WUGbuOJheQiy7CyUnxLkg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e35fef21-216a-47e5-aa7d-08dee19788f4
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:03:28.8575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSfKlydVTvugJygViF091A/IZskN3hlpGHI9049zUvMzBnvsZHZvT8RlIV3vLG2cBxaXNLDxEV3SonlT4rcVGIm+Oqwb6efP4naPKlSY8VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9854
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

On Tue, Jul 14, 2026 at 04:30:43PM +0530, Raghavendra Ningoji wrote:
> On Tue, 14 Jul 2026, Bruce Richardson <bruce.richardson@intel.com> wrote:
> >
> > Just wondering if completed is ambiguous here. The index is that of the
> > last reported operation, right? So if we request completed status of e.g.
> > 32 operations, but 64 are actually completed, we only get returned the
> > index of the 32nd op AFAIK.
> 
> Right, that's correct - last_idx is the ring_idx of the last operation
> *reported by the call*, which is bounded by nb_cpls, not necessarily the
> last operation the device has completed. And as you point out this applies
> to both APIs. How about making that explicit, e.g. for completed_status():
> 
>     @param[out] last_idx
>       The ring_idx of the last operation reported by this call, regardless
>       of whether it completed successfully or with an error (at most nb_cpls
>       operations are reported, so this may not be the last operation the
>       device has actually completed).
> 
> and the equivalent (with the "successfully completed" wording) for
> rte_dma_completed()? If that reads well I'll send it as v2.
> 
I think that would be much clearer, thanks.
