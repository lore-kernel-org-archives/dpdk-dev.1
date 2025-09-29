Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C70CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 18:56:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 109DF4065C;
	Mon, 29 Sep 2025 20:56:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7759E4065C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 20:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759172162; x=1790708162;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fNQaJDsGaRY6dS97G3zSjRYEM7BysFt5ito5eKQ8LA8=;
 b=KeGVS9eHA6oOF8ifoPJq0z2eEVAoEQhCkA0in8kShVG3uYboFnrJmtG4
 Psa8CzC/4fmpBDjlJ10J5SYL/BBz5rukyxOZAQBPyWb3XOD1P+eMkVaxf
 iSJMGtiEB6zU0yUuU+sItdFPp7zG8EIyN4ESNbq7E1/Ms4wUbuRTkawWa
 EEm1TNNzOnuIZ7NYIX8uAaNwExecHlL4xJ/e7ItPoOncisrpDOtW1LYgc
 7pevc7h0vrxu6cCt6jyfgaTz2pRIW6sR0vmK7SzbVaHzyZNDM2k+KiEhZ
 fCSAOJ93SIAFlOy2BTEUhBtgDxVDIrkG6xmhEoQqeyMxJkV+nM6Nbj+S9 g==;
X-CSE-ConnectionGUID: JmC5KsjgRWOFKbi2fEqciA==
X-CSE-MsgGUID: AItgDhvxSgCGwJEEglDcgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="71669105"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; d="scan'208";a="71669105"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 11:56:01 -0700
X-CSE-ConnectionGUID: RZ6DUBPOQhK/GAfQnal7GA==
X-CSE-MsgGUID: yr5VXHMbSpe862NDgeVD5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; d="scan'208";a="178737356"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 11:56:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 11:55:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 11:55:59 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 11:55:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrlouxBRNJ0z2hXq4Kb4rqPK7vUYDC+gVsU9by2StdAKEo8u6D4/wlxerIga/8I16CVyUbm3X5w+szzVVftqzp6XhHKpZQWgguv9H9bAN1NOrT6Yw4BjkR2UjKLmwUIbIgv3fXtJUYmQhQ5sPMKCvgY4IVLF3ptEIwCeZt7n9o0PBxsN9UgqxSSo70QWmCad0qh8MZG++2dOaFiTfaJRLic3LmtyDu09nzuhkMyFKZlMEs65yHSZHqxot5HdaOkWqdRp18LC2HxC9p+yIF9y/gbpLWRK4ieOAHYDTFYuOtWEKTZKKDJxePOY5hjVWA38iRe6/HLSlnW+7f011mzoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pj5KRIR9MW9IVqaQ39r8HTK1ji1dpeLmEvogB2bD78=;
 b=dPC8pKXzWjFSMo20d/uGTJaigGReKFuX/g9BcYfb1MK3a7k1yM4TsOZDpXHRiUJmWrDlmGF0aTGtWvJe9i9qXb25iPP9nnvK95U//NpXF/CKOM2ZGm7x/1iH9iHcWlYrhNS07k/Q0EUoOHJOG0ZkW5oJjtuCDJTAcrLOBaJudwNMK964E2EL4l/YnooN4O9WK4bXeomGJuedlAQ/+xvIoEClKar5QiYDtsyIqYR8w4CVdpt4AotL259HNjERj6ccBj/Z1GqT9Qvuik2/QbUxzHXck7ZFCVHwvXN4f+h+Lk9l9tfXO+vR+FYhLNCEKEgo4e8ru4zIqPkTgcq1v/1XHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f15) by PH8PR11MB6660.namprd11.prod.outlook.com
 (2603:10b6:510:1c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 18:55:57 +0000
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d]) by DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d%4]) with mapi id 15.20.9137.017; Mon, 29 Sep 2025
 18:55:57 +0000
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Shukla, Dhananjay" <dhananjay.shukla@intel.com>, "Patel,
 Atul" <atul.patel@intel.com>
Subject: RE: [PATCH v3 2/4] net/idpf: add splitq jumbo packet handling
Thread-Topic: [PATCH v3 2/4] net/idpf: add splitq jumbo packet handling
Thread-Index: AQHcLG0cp2pav4hw0kiEzHTsIdvYsLSqIVKAgABrDgA=
Date: Mon, 29 Sep 2025 18:55:57 +0000
Message-ID: <DM3PPF291EF9BF15EC74E5247ACF7E337519D1BA@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
 <20250923125455.1484992-3-praveen.shetty@intel.com>
 <aNp8T1rYYJHLFoQw@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNp8T1rYYJHLFoQw@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF291EF9BF1:EE_|PH8PR11MB6660:EE_
x-ms-office365-filtering-correlation-id: 1e717511-7568-41f4-dfbc-08ddff89d2f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?eJCcg05xwqCUNE/9Lq6EJm/nMdLBzuqvI+OKrD4gKr8uJHR44Jgojt9zqwoC?=
 =?us-ascii?Q?NCTTfIZPd5zVAtMvkRBK4ZwJv6kyF6XAUfe2mmpv9MBUaVxkgnV+L0A0jijE?=
 =?us-ascii?Q?8wGS2dXrtOa/8I7KTNM2M9W71xT5F0FNhLuI6rOFm+JtHRi8dpeywdqTSsh6?=
 =?us-ascii?Q?z19Ltpgn4cPMFzzImuAbTxafJ1/4a5vYBRYeiBDl3pTQZT1O6Ju74KlByG2x?=
 =?us-ascii?Q?EiBEYRgr8eYTLIdPFEnmDb0oTEijzXAW1IXOhkYTl4Toemam+te/+wl8o3+w?=
 =?us-ascii?Q?6H+fcaCNvkW5i1AGFtpUeQZgwwWzkJu/pS8Y8sNHGr/AwCdBFdUC/ny3TzoD?=
 =?us-ascii?Q?pdSaZjnu3fz3tBhpW/gVKDLanGPh4yxbGMGrzbTe5ei3vTuwtNwTJGtNAdoN?=
 =?us-ascii?Q?UHckG+xvayNtWfIDK3ouU+BV13LOZDpXkM47pBPfVyJ48DjHRr+lUsftxLPW?=
 =?us-ascii?Q?i+Z1sB4+0g9y5ktKCDb8zobIyEx4XF99vRHxXv2qqKjarKLJWAV8OACubGIh?=
 =?us-ascii?Q?mJGwMYsJAXI4a2qCmiEKVEZSQVy2pZhkb1EwabEEVoG2a2nEfGOMROCL6IAb?=
 =?us-ascii?Q?AAn/G3OktcAGOA7HwAAZDaqoRnpPobpB+j9YtLUkVY3iPvk7AX1j7rZXuolo?=
 =?us-ascii?Q?QPc77sABnX5chArH3oxXdkUunlILQQx/Wae/lO/wTK0m3Ejnmuew+0A0h3pq?=
 =?us-ascii?Q?BYw7lyZsGNUq8TBe6GDL0mOaUoeqiHdDxxy9smJqTTyzZoBqAOmimy7pyj/p?=
 =?us-ascii?Q?yDyvbzEcWUDfyufh3oDz34IAW4Ek+EPdbFfQJtsrU54U4zuOnTUG5zpAqUDC?=
 =?us-ascii?Q?BhCaMNbGgYDpbONTO3OkL/QS6EmL38LoTtC9ZfwwRToZteYJUXed0J04fGoY?=
 =?us-ascii?Q?0JCu81b8/FTFX3ct47p8lIUwvw9FgZ9rDCBe2v/AfV+VPee9oyFdHDm/+rb/?=
 =?us-ascii?Q?Xqj4Zmj4M9hgs9rQWlt7fpwsBW0v4Ua4JRLqnoIkkCF0rfHZ50hJxnwCH+GC?=
 =?us-ascii?Q?ZrG+7X+bJLgAPWANsWSpfMdAhIUU6Un9jj86PSe97Lu6vqCWfF1XyO0zcQqE?=
 =?us-ascii?Q?FyTXHE6WDv+LZSC7Xztqys/Y2dJ0qEatJCrXAYNxsCo3NwCINoAF815lYFmH?=
 =?us-ascii?Q?eWC2lNGQP3/hFkmYXbWU3hRJRj9TiB+z+JgMl8WHZhZd4b3wAoJwN+mJGzw+?=
 =?us-ascii?Q?hwaWWL1sBNDfHFWIrcc1nvbKx7DtKKqz8AY1XEzHC4uD6Ir15lPmhgOB/4IJ?=
 =?us-ascii?Q?MapfZvu90jd1FRU48QKyeQyOAkh/mJDC93F9CQ0kq+SRea67G5pzm1Th5ldK?=
 =?us-ascii?Q?wzqpR8vsVijBV5wo+1+Q1ywU0T+tAd8gu3On6RziD8MDcVfrK8H3Da2XY4rn?=
 =?us-ascii?Q?dlvx3IS+9g8UXYGvvEcCzk0s8a5XfAWRwyYGDlFCyYj/BaaRXSMixpNHXOht?=
 =?us-ascii?Q?Wls0222jyPS53WEULCuJAHW2xh4LRyDUUcPpho3DqRlQXzMb6uVfO7E/BTZr?=
 =?us-ascii?Q?PgkOMOdHeV2i9Q75yvQwp6sVqyMMawmSh5WK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF291EF9BF1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CoL4Yhiikqspl3fCKBgc5GlIh33PqfSYq0UclPwW5Og3EULRQziLzU+MbYxF?=
 =?us-ascii?Q?bwf1u+2M7POvSo5BmZ54ndE7kxlY0501KMslfwzQqPeeeXN/F2Nbk5DYPCi5?=
 =?us-ascii?Q?5xnFtGEqD1gltqO7bn3D/7/zQMV2kktolC0rm/8E/5kCVhiJ5DaIHdMzOjdZ?=
 =?us-ascii?Q?Ktrl48zttB0oRDnv5NIA0m+OqaRRB4OGL646mYdP/gaAuRI1H8SP9i2FT0MU?=
 =?us-ascii?Q?yCz0+qkzoy6uw9FEvTypTBypf0dZYdFdTW2e3dCWwh4wapIM2LMExmd3DnEu?=
 =?us-ascii?Q?/zKpLo+CvZRriRdNgtfaOMYbL0RQfaMF9/Knllb5yM8b91SG1jLEF0S5Vvn3?=
 =?us-ascii?Q?PHAd+nWbfKvs71RITgcDR+oRivCawLv4qRF+RJ+xYoh6Fiwbye9uLzyaDsHs?=
 =?us-ascii?Q?gy1xRTNR4HMh6JerlDxdx5j0XAnExNS0cbvdynhWuw8yaXYyYbENATp6VWhM?=
 =?us-ascii?Q?3sGESS/XIZHTx3ujXSTE9shFYwni7F62b5TPVLjXwnSMv63b3CAOYWJtF7PK?=
 =?us-ascii?Q?SLiJVwYqHx0ytqEBF6vH8teTxkOeKFlBsHwCeTVKocCNoAn5XWQwsHB2Y/ao?=
 =?us-ascii?Q?UhnYl+Eu4JEQzxAtSWD8nIh4h/F4htRHZAmKoK6NxuywKY38xp33qHKh2/8+?=
 =?us-ascii?Q?2upbaGMiy3nExbrAWuDGxdTI3NMnVhnqzLFb81C73ouCHswBxZroVv8jGtCs?=
 =?us-ascii?Q?mdAMbKgChfl78nSKvSjPpwV1lpEBeGtrYb6/N3jGTxV5X6RrVMayI5/bwMiV?=
 =?us-ascii?Q?bHEqjJNvdtIG1oy5mj8es2c0CIAvb4id0I6MLRz3L1oBScVJrT80aMLfZWK/?=
 =?us-ascii?Q?liDwZVtK2IPKicC/F/295jfaE8M12QbuNAE9aILAOYX5jeTpPUUbeQ11S/Ps?=
 =?us-ascii?Q?jeXwWga+qLS7/UVkwDJKeYd1TOdHG6hPYrtGuQRXWKs5njMuiw1Bj7yzck5y?=
 =?us-ascii?Q?rXKpSDTAnTrlrjG98/HRJcDAQjf59o6FsPamPCPIrcIwnDemezNGg0f9ZJvD?=
 =?us-ascii?Q?O5D3iTgF/0aiqhQlCzA9VjEFtPi2E0XMJbCDb0RCXwpZyZDzlv5StgsaYV5I?=
 =?us-ascii?Q?KRBs75M0xO1au2Vc18xxSthA9I9rOQhTZliCIb7KIzLvKQCOkDRuUDk80Q4P?=
 =?us-ascii?Q?GMkyQPArIMTRCyEkCO4Or69jSSqV4wFJvl/rlqB6fKb4LE2KpPLIoVD9FWU6?=
 =?us-ascii?Q?Ttm4oQ1Az7M7kJVWUsPtYzL7Y165M/SpXQ+iahb47cszBXAsz84mVgzoDsWj?=
 =?us-ascii?Q?V3mwiAwkJ0pc0s2n4pIhUA+SBJ7FLQWLPoBUXuQFvlEIyLy+zrDBvlgpJo1H?=
 =?us-ascii?Q?PGkc/qwOpomaMWi+1FZX6zWMy9yQ/6oh8mAnr2j2pTnY9PjohPOz8VhAPxnY?=
 =?us-ascii?Q?wnJoD13Aql67vFkVI31a/u/OijURHHXQy/ZkNCKh+P3fgLAVJtbdFAAE99+K?=
 =?us-ascii?Q?XMTttL/EmjkfiqfOHkFe/J2JRBIi8SajXfxVTHvAeKLx4MiR8Z1GHdqlW5t2?=
 =?us-ascii?Q?fW16/NmQeBm+TC2LXWOMNny/zyLT6AiQv8kMTWuMFIwSR6+Tw0I1iNrWgzot?=
 =?us-ascii?Q?8WXQFAs5HYC/HwrSSkRSHRcTjtyWyEm5rUlLwKVr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF291EF9BF1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e717511-7568-41f4-dfbc-08ddff89d2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 18:55:57.0942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJRS+9WHCPFOmgWxTmMqebG5pRq3+pz4H/A0KJgIvu+R1CADzVatCnW1imcqvsGw/RShuC87gOKtHns3rxpRp6+/VI9+pWjU6NI4e8tDlFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
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


On Tue, Sep 23, 2025 at 02:54:53PM +0200, Shetty, Praveen wrote:
> From: Praveen Shetty <praveen.shetty@intel.com>
>=20
> This patch will add the jumbo packets handling in the=20
> idpf_dp_splitq_recv_pkts function.
>=20
> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
> Signed-off-by: atulpatel261194 <Atul.Patel@intel.com>
> ---

One small comment inline below.

/Bruce

>  drivers/net/intel/idpf/idpf_common_rxtx.c | 50=20
> ++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c=20
> b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index eb25b091d8..412aff8f5f 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -623,10 +623,12 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte=
_mbuf **rx_pkts,
>  	volatile struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc_ring;
>  	volatile struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc;
>  	uint16_t pktlen_gen_bufq_id;
> -	struct idpf_rx_queue *rxq;
> +	struct idpf_rx_queue *rxq =3D rx_queue;
>  	const uint32_t *ptype_tbl;
>  	uint8_t status_err0_qw1;
>  	struct idpf_adapter *ad;
> +	struct rte_mbuf *first_seg =3D rxq->pkt_first_seg;
> +	struct rte_mbuf *last_seg =3D rxq->pkt_last_seg;
>  	struct rte_mbuf *rxm;
>  	uint16_t rx_id_bufq1;
>  	uint16_t rx_id_bufq2;
> @@ -659,6 +661,7 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct=20
> rte_mbuf **rx_pkts,
> =20
>  		pktlen_gen_bufq_id =3D
>  			rte_le_to_cpu_16(rx_desc->pktlen_gen_bufq_id);
> +		status_err0_qw1 =3D rte_le_to_cpu_16(rx_desc->status_err0_qw1);
>  		gen_id =3D (pktlen_gen_bufq_id &
>  			  VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
>  			VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S;
> @@ -697,16 +700,39 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte=
_mbuf **rx_pkts,
>  		rxm->pkt_len =3D pkt_len;
>  		rxm->data_len =3D pkt_len;
>  		rxm->data_off =3D RTE_PKTMBUF_HEADROOM;
> +
> +		/*
> +		 * If this is the first buffer of the received packet, set the
> +		 * pointer to the first mbuf of the packet and initialize its
> +		 * context. Otherwise, update the total length and the number
> +		 * of segments of the current scattered packet, and update the
> +		 * pointer to the last mbuf of the current packet.
> +		 */
> +		if (!first_seg) {
> +			first_seg =3D rxm;
> +			first_seg->nb_segs =3D 1;
> +			first_seg->pkt_len =3D pkt_len;
> +		} else {
> +			first_seg->pkt_len =3D
> +					(uint16_t)(first_seg->pkt_len +
> +							pkt_len);

Since we allow 100 characters per line, does this line really need to be sp=
lit into 3? [I realise this is a copy-paste from other drivers, but we can =
clean it up as new code here]
> thanks, will address this in v4.

> +			first_seg->nb_segs++;
> +			last_seg->next =3D rxm;
> +		}
> +
> +		if (!(status_err0_qw1 & (1 << VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_EOF_S=
))) {
> +			last_seg =3D rxm;
> +			continue;
> +		}
> +
>  		rxm->next =3D NULL;
> -		rxm->nb_segs =3D 1;
> -		rxm->port =3D rxq->port_id;
> -		rxm->ol_flags =3D 0;
> -		rxm->packet_type =3D
> +		first_seg->port =3D rxq->port_id;
> +		first_seg->ol_flags =3D 0;
> +		first_seg->packet_type =3D
>  			ptype_tbl[(rte_le_to_cpu_16(rx_desc->ptype_err_fflags0) &
>  				   VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_M) >>
>  				  VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_S];
> -
> -		status_err0_qw1 =3D rx_desc->status_err0_qw1;
> +		status_err0_qw1 =3D rte_le_to_cpu_16(rx_desc->status_err0_qw1);
>  		pkt_flags =3D idpf_splitq_rx_csum_offload(status_err0_qw1);
>  		pkt_flags |=3D idpf_splitq_rx_rss_offload(rxm, rx_desc);
>  		if (idpf_timestamp_dynflag > 0 &&
> @@ -719,16 +745,20 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte=
_mbuf **rx_pkts,
>  			*RTE_MBUF_DYNFIELD(rxm,
>  					   idpf_timestamp_dynfield_offset,
>  					   rte_mbuf_timestamp_t *) =3D ts_ns;
> -			rxm->ol_flags |=3D idpf_timestamp_dynflag;
> +			first_seg->ol_flags |=3D idpf_timestamp_dynflag;
>  		}
> =20
> -		rxm->ol_flags |=3D pkt_flags;
> +		first_seg->ol_flags |=3D pkt_flags;
> =20
> -		rx_pkts[nb_rx++] =3D rxm;
> +		rx_pkts[nb_rx++] =3D first_seg;
> +
> +		first_seg =3D NULL;
>  	}
> =20
>  	if (nb_rx > 0) {
>  		rxq->rx_tail =3D rx_id;
> +		rxq->pkt_first_seg =3D first_seg;
> +		rxq->pkt_last_seg =3D last_seg;
>  		if (rx_id_bufq1 !=3D rxq->bufq1->rx_next_avail)
>  			rxq->bufq1->rx_next_avail =3D rx_id_bufq1;
>  		if (rx_id_bufq2 !=3D rxq->bufq2->rx_next_avail)
> --
> 2.37.3
>=20
