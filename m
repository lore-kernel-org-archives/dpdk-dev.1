Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06EFEE2082
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 10:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCA7B4029A;
	Fri,  6 Feb 2026 11:23:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 50E6B40293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 11:23:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770373427; x=1801909427;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yqE58ywQY815aC1tTuE184qot1cHa7yy8RCMNsswyeg=;
 b=m+Kzbdm6i5KqDf08jsHilEvYe/lCpEy9LBp1QAcb6o9lJIoik0Kh2fX7
 tmJIQEzUhM/fkkk1MUTVmH+m/Tj7SIZuV1h2oxAdS9Zo63hXqhujkjHo3
 1SaTbRObMtPLKlA0/sP2wg1HlR+PSc7toWjCXljYKMzLB+3XUmyZHNCH1
 zO1c/+C0HoAAysn7umgd+sbgmA0QJ6Xg2pJMr09bCr3xeR58Dfz5KN18Y
 cmCrQSYct0cCj7d8o3Se6YCRrH7iSchbMxrY6E2moNNxzrGLaBjUFe2Mt
 Lpgp+k3K8BAydSsGm0ALea1qnNSGsDt6ZmbCkbnuoeL9MtJHQqxUQ4b4y g==;
X-CSE-ConnectionGUID: EPYB/6yWQIKANeEY5OE+ug==
X-CSE-MsgGUID: BTbQOcH3SHWyyHTnaTAJLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82317114"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="82317114"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:23:46 -0800
X-CSE-ConnectionGUID: xGKJ7KkAQk+CHZgk/nTnxw==
X-CSE-MsgGUID: abClwYnTTsS67MED8gxsWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="241312735"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:23:46 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:23:45 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 02:23:45 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:23:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikNNv9b9zqnfwUj6UmxfXqIuufGmp273AkwGg4jPYRnqogSZvVrZxB9OHYK+lb+mzYbSsZ4a4T9eDzvBz7C/7nXjbojk1b13DiZqG38WqrliSQsJ6hLEUZoqyTq4aDnb86YNYXYFPGtYkt1rDfkKMBsftKOUN8WCWf/vEFnXs+Dmx9yjDEBHwVGVYh/T6NDSSWRN0Y4CobMPnSaR2F14+haQe5olCdBqoYqP9wLHDRuCr7lZcYB9sc99HUY6RPVRb7w6uXbkuhFokgMpUdFhVrxo1Wpck76itXluyLKp4yjtC7/AMfyNFI6jeL6JlRECvqcVw8TLWgTbFSaQq4P9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6Yo+AF90rd18P2M6FeojAX5hduoLnx91QmXfCbnKX8=;
 b=CccMV0pmLEOzCPWK1no/5MQtTFe5duQ3RBSDkrGNqBB+4sfsAG1jP5AEgkW9s3GB9IBQ5MYaqpEqDz0HpwCHgAyyRoGfn9Qz9GWnBeiXS0kivNp1C7B2eeW2hKIMEeXSgNzfrT8oPVlSLFYj9BO87ukcFA6xV9k5q+gbscMtNPGhFG8vhMT3HGtZF+n+OqNZuoQU9QL9SxRBs9sGUCQ0m9R7WNu+MRUHfTGEjDJHHIkAAZmXV31sKX8QFlYQ5O0rIlobJrtB+VmrF3sy2Pk/nu/v6QSA2Bi0cbY+1MUdq+i3ou/T+cxe4dLhYkvMTy14+BDRQEKcGXdWMyk14NbxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SA2PR11MB5210.namprd11.prod.outlook.com
 (2603:10b6:806:fa::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 10:23:44 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 10:23:43 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH v3 05/36] net/intel: create separate header for Tx scalar
 fns
Thread-Topic: [PATCH v3 05/36] net/intel: create separate header for Tx scalar
 fns
Thread-Index: AQHckd2isdc81VuWKEuup0+sVAEEdLV1f0Jg
Date: Fri, 6 Feb 2026 10:23:43 +0000
Message-ID: <DM3PPF7D18F34A1FE170818FAAF21F014D28E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-6-bruce.richardson@intel.com>
In-Reply-To: <20260130114207.1126032-6-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SA2PR11MB5210:EE_
x-ms-office365-filtering-correlation-id: 0ee2305c-c078-44e0-1c8c-08de6569ce39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?V4aFiYIsFYW9lvq/yevxZkvdM8/K4ptZeYokDW0+KbzxQDq1ZTAJ6qcdB/o8?=
 =?us-ascii?Q?FCnszDBWGI8Ai1ye9Wmc1rid4+8tHa9sN4tnzmqPhHcG7cNbJCk+Xd/SKRv/?=
 =?us-ascii?Q?G2m7Xg4jPFO9fLQklDUCxXM3hqpjuiwuB1DEmVIfgi9WRnEv9dysMXIfViru?=
 =?us-ascii?Q?6e6aq2E4GdAdPgztiDeao/uDAjbuSKpuRMiCmjVl273YYUj51Qc1fPU8Ctoq?=
 =?us-ascii?Q?yJFpmG6419c/rPI2CTpjstcEN41iQrUv1bTvTW6t2KDPX7y69Rpvy6D+oVR/?=
 =?us-ascii?Q?AWsAJqCB+aw5GmSZ5DH/wXDk4p4L5YwUDCsctJx/GciUc3g9MQbicMGso771?=
 =?us-ascii?Q?VBsTFNEia4uy1ceonyY9o+hDcDUyQG+PBhAILZXejsjc2zgbKJzwMLZdSgWl?=
 =?us-ascii?Q?3a7LDHb0TWa+WFEPxXnnTpNRXsNTELTNsJjpsbv+KVjkiGVUwI0uiF2hkRUb?=
 =?us-ascii?Q?DbQBX7w7h+BP0f1Cmt/8xMpJKy/8H8SXQAu7MVSr6K3QK6gnt6Uz82dDVh6F?=
 =?us-ascii?Q?AQZfZwYr/ZCJYFabH1i6SF2vFEsDv4hEMToEeLN8QIz2d06K8e0HbM1ux58i?=
 =?us-ascii?Q?CJOtDptKehWAqeKG+qSdTK/kWUsdLQ4w79GS29bOGmmP+HIKvD1SzcaGgUx2?=
 =?us-ascii?Q?4m9lzBeZ+Wy/28R2NWXBFv33nslclC7OgbRo8euWiqY4DiB1eHxaxYWuSPyu?=
 =?us-ascii?Q?ly8A4TrtWOorz1uFBlRgAUer3PrHeKzQCw2JcAWzf2uH1nnvTgS2ez8miAF1?=
 =?us-ascii?Q?Cs77VlpnfQXiXBYkUS/tdZXnym/1tQVCXyFHnN5VTZxNhdD6jloDEBcerfxR?=
 =?us-ascii?Q?Ad8n5oK6Ka+zMpwJwodLWYqCcg+MBAmDNqfOOF0CZj59K3Tf4O2Gz69jFJt5?=
 =?us-ascii?Q?fJPToUtmCwn1nk4J9ZZNnGMUfeVSFXs2oFiuHjp8Yh/9XeC46+HLU4ZDizSt?=
 =?us-ascii?Q?mSaNgZrY+zbMO/uVGwiFvnlB8iK8CKN/K1jaw1CJZPVNCGlt1EnK+1BUyYpH?=
 =?us-ascii?Q?gQ74xFnN9mxa80GbmPEsP6J3+nePldCd3R6grM+jZhwPN+oZJNf/Zw/Fd15m?=
 =?us-ascii?Q?1NuiMG49TG8138InhHn0xoGeiEGKPGaua/5F8MkbF1jKsznVJ1DlYw7IEad1?=
 =?us-ascii?Q?cy3H1c1BY1bUGbyGIFkGLlNV5AR+saTqIMQaG2K832i4tVme+KZN0wspDDTC?=
 =?us-ascii?Q?6VbA5IVsQCmg0HoDDSvyihuX7PgyaSW8MTnNSj6q3+shgrwSFJCg44Miq08y?=
 =?us-ascii?Q?rRQq7Hp8Uil4Gp2MYcW+1wgV/rE8XZfZH0jes3Sr33DaAkkpeFtGxa72M0zs?=
 =?us-ascii?Q?l7rjOh+Jc86grLft2I7qqnjmfvZppiS47sGqBSa2L2kJytfXOil1JueBhbUc?=
 =?us-ascii?Q?LRhNd8f5Z54mlksai1I5/tUx7b7icGEct3vmBFLeF3THgLuOVREJJlkvITrU?=
 =?us-ascii?Q?MuUIHfyXCLBu8sMMMgTkoUEragjDTSp3HaPIv5mOxhokjT3zSiIq06KQgqU0?=
 =?us-ascii?Q?6wwQGKA+HEjTG/kWzahTFCh8ZsPjlycnlkY8Rpifl5Uv0ihKGNQc35nixS46?=
 =?us-ascii?Q?kvCmehFbbLbVsBkZFue5/lFsG0Nw1eK6h1jzw6a9nqZaHJDGi/yOhVZ3XnFt?=
 =?us-ascii?Q?DW4zFv/HSid9H0e1GwibWX4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0JUfPt2d14V3jw6FYU//y91t7kt9lERLodHtfGj+mFz5jN0AKd0ote9zoy0L?=
 =?us-ascii?Q?e/w6/MqZOea5NXqQ6YuCBwNd1cUGIAVz9kzAUnttB2g4DM7hmpYGg3ehUc09?=
 =?us-ascii?Q?m4AGFW87uxewwHnAsUCoz2E6XU6O9GXKYfOddUePBiObMfyEmCBbeWtDSNNH?=
 =?us-ascii?Q?mapl9c1DLfbpw1mZuL6cz+kmLJhb1fFe+We0xC17yBMB4BWVOa52KDccSQUu?=
 =?us-ascii?Q?ni/MzV2q6RejFXS54wZXFaZpQkaHqVJ+i1WeqLLiEvqdUI8WioYE7zCldFcc?=
 =?us-ascii?Q?XH+VC2580ibPk506ZDatZNh+QwjgQdyEQ3soYGmJtdvJ3oBZdmIcjgqnaexs?=
 =?us-ascii?Q?wAnMMAvpeqgvbIth+VgkKh1Sxygzub7Rc9wd+L0GuLTJtlPrzeiVeMpYmmvK?=
 =?us-ascii?Q?wb09adPnB0UIMW0KpB7yla2qJzePi4+4q2eps3gSyg/+QKsX9PaV7ZdC9fIp?=
 =?us-ascii?Q?MKnG3FemLnX+oYHsWxYI1hq0gAE94UDOzG3aUaG60dxc/CDzO5OtrGPODXlz?=
 =?us-ascii?Q?81Z0NpspShSuaxyk6oSb28XqvriHIlFhS3kgaxMNNRiUbJYNjjCHFp0HsEVn?=
 =?us-ascii?Q?3+Tzcwa5PTKGu029vZAYFEWA/06q2PnrSI0dCjqb/VO7zGMuaT22oW8XHYGa?=
 =?us-ascii?Q?6lNnihyVh4pSS9V3DF7YXMbNmjIN92Fj0ijNqTBV8JZWcwcGx+2GHwM2NUpH?=
 =?us-ascii?Q?GXCPJxaYtgRC15kVtjr8KPfO9nDwQ8wyPhZ4wkA1MltE2KZFQLqVVFeaTguW?=
 =?us-ascii?Q?UYc+wQHldNniSs/NB2tzpOdhVomXHAAFZb2XoktL4jxrqVsWatJNa4wYLSX+?=
 =?us-ascii?Q?3wmx07wfrrwnc9kSenubUulagUT/gzOa+QHuh9CumXugCqf2qTyNDAZeVuLC?=
 =?us-ascii?Q?4YKL+jXHE7VClY93POnEFTR64srX2zv+YFU3pnd6p+VPLZg4Fsk4TnOvyaFq?=
 =?us-ascii?Q?oc687Lkq9kUYt+U6oW6KZB5k0Xc+fGGIOqoCBpBMJDbBzrF6zmUrsNxy9U7b?=
 =?us-ascii?Q?AtSpIQ1uW1ppXTYbeIpycxkdksiROL6/BBnpK460EAXRXgvqF3FDBFkJepaV?=
 =?us-ascii?Q?QDwCnbAMGdlrc4LtZ80GIdsBw9EYC0OteXWy/xcd/O6Kv2EfawgDZbUjpcoq?=
 =?us-ascii?Q?V2Jv7pTQoQquZnDkr8yNtkIslbDbn/B+P4mhn0mhwekDqFQIxlz0+W4vIZx0?=
 =?us-ascii?Q?DQG+Xey69dfpY0Kpov3HDgW7QTNV8g8rsZRBJUemW1lmrwdh/weVaSMWNP6H?=
 =?us-ascii?Q?YaftkNwPWmHkG7OcdgRUZ1qiFeyxCPq4LZos3j1G7eOt5zrRDTCuLTjhmHZa?=
 =?us-ascii?Q?wNXrJNveG9aqyheo6R8HaeGWSXLSWXzXzicpoKaszNCTZgMQcMOKVSmv6lmL?=
 =?us-ascii?Q?BOn1PKHh21KOdgV3Xq3VpC3qw2R9tUS8j9g3fl+uY0xuUm7Cll0My9HQW0Vo?=
 =?us-ascii?Q?AXDl1V78oracsIUWwjzC6bqSJgqD3hw6rx4eKNKVx4owGNgF8+aMSlVvc/TO?=
 =?us-ascii?Q?UcQHNmrjj26xRMT2p/uh/vubDrSgM7fOmKrQhxv7oiJ+DFTsSFz+ZWFhZ9Yz?=
 =?us-ascii?Q?nBcW+0pVowssQYCcp+TLAj/ioeH3XebNPApr0sojV2sSzTsE7ugkWMeD65zM?=
 =?us-ascii?Q?vR5hZpM/Gfksy3OZDHlD8dFoRE7Kthn7E0eScvSlcpTkVnij48iaiyO6OYs5?=
 =?us-ascii?Q?8rYv9FkcV/McSwF/+emaUv0hGzVdnHdsKkQMUsIV1aFLT/+maViU+4G2JvoE?=
 =?us-ascii?Q?7ThldklD/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee2305c-c078-44e0-1c8c-08de6569ce39
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 10:23:43.8837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7g1Az34tJiXqSzjDW5OS7lAX3ycVE8khjKg1IXstbgBZ4CFmiWMJd0oW3NhrCjXGjFH68+1SEaqRNkx/YDRR0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5210
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

> Subject: [PATCH v3 05/36] net/intel: create separate header for Tx scalar=
 fns
>=20
> Rather than having all Tx code in the one file, which could start
> getting rather long, move the scalar datapath functions to a new header
> file.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/common/tx.h            | 58 ++------------------
>  drivers/net/intel/common/tx_scalar_fns.h | 67
> ++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 53 deletions(-)
>  create mode 100644 drivers/net/intel/common/tx_scalar_fns.h

Why not create the file when ci_tx_xmit_cleanup was first introduced?
I prefer the naming tx_scalar.h but keep tx_scalar_fns.h if you feel it's b=
etter.

>=20
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.=
h
> index 03245d4fba..01e42303b4 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -319,59 +319,6 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq,
> ci_desc_done_fn desc_done, bool ctx
>  	return txq->tx_rs_thresh;
>  }
>=20
> -/*
> - * Common transmit descriptor cleanup function for Intel drivers.
> - * Used by ice, i40e, iavf, and idpf drivers.
> - *
> - * Returns:
> - *   0 on success
> - *  -1 if cleanup cannot proceed (descriptors not yet processed by HW)
> - */
> -static __rte_always_inline int
> -ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
> -{
> -	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> -	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
> -	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
> -	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
> -	uint16_t desc_to_clean_to;
> -	uint16_t nb_tx_to_clean;
> -
> -	/* Determine the last descriptor needing to be cleaned */
> -	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
> -	if (desc_to_clean_to >=3D nb_tx_desc)
> -		desc_to_clean_to =3D (uint16_t)(desc_to_clean_to -
> nb_tx_desc);
> -
> -	/* Check to make sure the last descriptor to clean is done */
> -	desc_to_clean_to =3D sw_ring[desc_to_clean_to].last_id;
> -
> -	/* Check if descriptor is done - all drivers use 0xF as done value in b=
its
> 3:0 */
> -	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
> rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=3D
> -			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> {
> -		/* Descriptor not yet processed by hardware */
> -		return -1;
> -	}
> -
> -	/* Figure out how many descriptors will be cleaned */
> -	if (last_desc_cleaned > desc_to_clean_to)
> -		nb_tx_to_clean =3D (uint16_t)((nb_tx_desc - last_desc_cleaned)
> + desc_to_clean_to);
> -	else
> -		nb_tx_to_clean =3D (uint16_t)(desc_to_clean_to -
> last_desc_cleaned);
> -
> -	/* The last descriptor to clean is done, so that means all the
> -	 * descriptors from the last descriptor that was cleaned
> -	 * up to the last descriptor with the RS bit set
> -	 * are done. Only reset the threshold descriptor.
> -	 */
> -	txd[desc_to_clean_to].cmd_type_offset_bsz =3D 0;
> -
> -	/* Update the txq to reflect the last descriptor that was cleaned */
> -	txq->last_desc_cleaned =3D desc_to_clean_to;
> -	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> -
> -	return 0;
> -}
> -
>  static inline void
>  ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
>  {
> @@ -490,4 +437,9 @@ ci_tx_path_select(const struct ci_tx_path_features
> *req_features,
>  	return idx;
>  }
>=20
> +/* include the scalar functions at the end, so they can use the common
> definitions.
> + * This is done so drivers can use all functions just by including tx.h
> + */
> +#include "tx_scalar_fns.h"
> +
>  #endif /* _COMMON_INTEL_TX_H_ */
> diff --git a/drivers/net/intel/common/tx_scalar_fns.h
> b/drivers/net/intel/common/tx_scalar_fns.h
> new file mode 100644
> index 0000000000..c79210d084
> --- /dev/null
> +++ b/drivers/net/intel/common/tx_scalar_fns.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Intel Corporation

Should this be 2026?

> + */
> +
> +#ifndef _COMMON_INTEL_TX_SCALAR_FNS_H_
> +#define _COMMON_INTEL_TX_SCALAR_FNS_H_
> +
> +#include <stdint.h>
> +#include <rte_byteorder.h>
> +
> +/* depends on common Tx definitions. */
> +#include "tx.h"
> +
> +/*
> + * Common transmit descriptor cleanup function for Intel drivers.
> + * Used by ice, i40e, iavf, and idpf drivers.

Do we need to call out the driver names in the comment? If a new driver
were to adopt this function they would need to patch this file too to
update the comment.

> + *
> + * Returns:
> + *   0 on success
> + *  -1 if cleanup cannot proceed (descriptors not yet processed by HW)
> + */
> +static __rte_always_inline int
> +ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
> +{
> +	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> +	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
> +	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
> +	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
> +	uint16_t desc_to_clean_to;
> +	uint16_t nb_tx_to_clean;
> +
> +	/* Determine the last descriptor needing to be cleaned */
> +	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
> +	if (desc_to_clean_to >=3D nb_tx_desc)
> +		desc_to_clean_to =3D (uint16_t)(desc_to_clean_to -
> nb_tx_desc);
> +
> +	/* Check to make sure the last descriptor to clean is done */
> +	desc_to_clean_to =3D sw_ring[desc_to_clean_to].last_id;
> +
> +	/* Check if descriptor is done - all drivers use 0xF as done value in b=
its
> 3:0 */
> +	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
> rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=3D
> +			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> {
> +		/* Descriptor not yet processed by hardware */
> +		return -1;
> +	}
> +
> +	/* Figure out how many descriptors will be cleaned */
> +	if (last_desc_cleaned > desc_to_clean_to)
> +		nb_tx_to_clean =3D (uint16_t)((nb_tx_desc - last_desc_cleaned)
> + desc_to_clean_to);
> +	else
> +		nb_tx_to_clean =3D (uint16_t)(desc_to_clean_to -
> last_desc_cleaned);
> +
> +	/* The last descriptor to clean is done, so that means all the
> +	 * descriptors from the last descriptor that was cleaned
> +	 * up to the last descriptor with the RS bit set
> +	 * are done. Only reset the threshold descriptor.
> +	 */
> +	txd[desc_to_clean_to].cmd_type_offset_bsz =3D 0;
> +
> +	/* Update the txq to reflect the last descriptor that was cleaned */
> +	txq->last_desc_cleaned =3D desc_to_clean_to;
> +	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> +
> +	return 0;
> +}
> +
> +#endif /* _COMMON_INTEL_TX_SCALAR_FNS_H_ */
> --
> 2.51.0

