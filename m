Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F453EE208E
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 10:59:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F75E4029A;
	Fri,  6 Feb 2026 11:59:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 16E8640293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 11:59:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770375548; x=1801911548;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=49qyf1Pz1Dm8HVqDuu+w30e2WCzIKRcFEHBh3oN7A6o=;
 b=SqNZmdWpH9SXkNaMs8eEG6nE0h4e6Q+X4f/e2tUml4WhoBTI95Eld6HO
 /T6cBYqh+5F/TdlvDGkXlyF4gs5IjGYfmfYvQBz3sZBmAk9dJ8jaTp59A
 pcQwmoO1v+TBGWn4ZX7s27ER9K6mLElYj5JGackWlZkUKUVwcbH8T+PL3
 Fo9AB0KhgRGL5VwZ86b07lrBnMlvFIHL9VlvFmOddcN0s8jrUNQLtPPwM
 SW7MfQuwK3FnnPo9WItk04vI+yzENmMcYDWb1t88j2NsSpwY+ksL9rgBK
 2NzDrOVfaJ5kmEBVdLBzYZKANFLhZQQq4YhsIznJtpEb9xFY8EfN64Kw1 A==;
X-CSE-ConnectionGUID: JZ1p8K5wRxyx9PT20DJCZA==
X-CSE-MsgGUID: NvGJSdfjTRKOHNjbBAAREg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="59153509"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="59153509"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:59:07 -0800
X-CSE-ConnectionGUID: 29lt9U+jSmSwTgwIkj4XCw==
X-CSE-MsgGUID: L+UC+E71RPyxXwQtYMwzmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="210916076"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:59:06 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:59:05 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 02:59:05 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:59:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNGVpAZbEeYYYiNOmjnHXPihYJMzDL8a7ydGWh40aO523e6gT9IGjLtN3egnJ5KTHE+Buv4xKf1nYrBuwabLZnpFfGIN5I+7cI3lcXuhtOP+MVfXSX7/x5IgU+bTSVsLzPk0ocPjCgLK7cQmLoFc2fmVvDewVyZG77MhCnARd4zp7TyFXsdXCKTTJtTno0X2RjFQYkrD2atEA7iqmN7bkT1fAvKfwnTIBH8wpx9XgkQ3CJAmF5e9kipUUcYNiU8CtybMlyWmIOwxr3AsiO5Z5NvemZzdGslaYxfGZ21leZQRrj5FrnpqzsGGI9un+bMN2+eIJW1emc4tg8QoyLpF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49qyf1Pz1Dm8HVqDuu+w30e2WCzIKRcFEHBh3oN7A6o=;
 b=YXs/Ul4RieYcrX+gabph8hHw1dWxND9aXKHxXo0BRgfmSlUbgIO0Q1KUbwGf0xjk3CpVXxS9FnXTzEfXLggzG8F8H0UHm5/5aHKpcgPYq6V/+/hQNiDb6Ks7iJHJynhWwb8kI/xKhVF3kO2cVPe7dunJd0A87fM1e2PyOX8/u5/Wqo2GGBlN3AfmOfCbZkS4/dqcVQL4bSFRz4KZ/asnPEVWA/t5OrVpVNf/e/pybPr9LeqIBaKz9HFiPfQxVd7OBjPy1STzzlOcSk+ScSZ5CQexOxFNeKtoyNNWIz8CM7fYymoeNoMoCOeipyOzvfBYsAiZhYu611n18rR3eQ66sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DS0PR11MB7481.namprd11.prod.outlook.com
 (2603:10b6:8:14b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 10:59:01 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 10:59:01 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Wu, Jingjing"
 <jingjing.wu@intel.com>, "Shetty, Praveen" <praveen.shetty@intel.com>
Subject: RE: [PATCH v3 09/36] net/idpf: refactor context descriptor handling
Thread-Topic: [PATCH v3 09/36] net/idpf: refactor context descriptor handling
Thread-Index: AQHckd22o2O5WDJPY0mUmxFaEK9kPbV1iknA
Date: Fri, 6 Feb 2026 10:59:01 +0000
Message-ID: <DM3PPF7D18F34A1C654E77A21C44AD6D1558E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-10-bruce.richardson@intel.com>
In-Reply-To: <20260130114207.1126032-10-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DS0PR11MB7481:EE_
x-ms-office365-filtering-correlation-id: 170bcbff-e536-4e5c-c1f7-08de656ebc27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?7dods/P36iTkqxe4gto0kRDi+0v2oQ/OiyN4kEbDDxymn436b0zEACGoypN2?=
 =?us-ascii?Q?VCDFuJYx5Qnm65JcMsRE9UBp/zcYAzCFZwIr2uM4ZT+wa+DAkKD6z07Rjqoo?=
 =?us-ascii?Q?yDBSBv0+6u74YgHyvHNd9ysR5FMnQLar3CkSvDgMvsyGOKgCH3/y8PKaASzo?=
 =?us-ascii?Q?3yw6uUWJNPomGnlJZQv862/kzaX9WrkYtihkQXCUvDYVCghJmf+ilFA1YbFa?=
 =?us-ascii?Q?04O1FhkcFGSnsqroZjesSipg9OUU8eTq7SniwjstCsgJtWGfa88tlkSTxipd?=
 =?us-ascii?Q?P/cJ4k+WL2PKFBLWXRUKnUUBEcrXJ8rczTex4vyzUrU1XuDAwhhSmwWtAUVl?=
 =?us-ascii?Q?c+IMggnWyoo5n7K5yaMWKnoqcFWPtprhMm6NlZix39HXrUs0pR1obzohWHRq?=
 =?us-ascii?Q?B1zFznkmnZUuDBG636jKjp7tU+1769WXVmN3aeDnyG/1+1W4Ti+JwLRBGUed?=
 =?us-ascii?Q?04eQnEPnVa1MWWDFXMMbeLfGkxiSBEqFuFf1SI27qykoFaNlIgo+9sB417Hx?=
 =?us-ascii?Q?K9DKzVFmYYGKDRsDga1SPrqbQNJLChym/gOne1JNXuKHdJ9O2ul5QsKuGZY2?=
 =?us-ascii?Q?+wSuVIme5VRXP84Vt8m4c4Da9bUKUWCVd/KzjDjsCdx/g5lxv+IzhgHsQDwI?=
 =?us-ascii?Q?hkZqApwp4pWVc7f8SWgYGERvzzRUO6QE/VvogsU3lf1ZvlIgw82b2N6Lr67X?=
 =?us-ascii?Q?PYWQWeFOFB8g5L9Gaa3VQrolEscTYyzTet+3e9chjuestoZ5KP1AyeoVTPon?=
 =?us-ascii?Q?crQXS+POF3HZCijs5GawkeKsAhIZOJzDBhQpRex6xjq2DMq3IxXF1lMXSZoQ?=
 =?us-ascii?Q?6/J8aSAhgZFrmfobzN8r+dCxXvhR5jG0v+ijfGKQR+uyv2v/qVWNKjv31Q3Y?=
 =?us-ascii?Q?V32z7D6uu7Z0QbUNMf++Kz5LmH6xWud+v5S37tBcc+oFO1WF4/SL3c8PJqto?=
 =?us-ascii?Q?+RXy0xyV9Mn5Y6keRtUwbaTieVukMlSc8FbWRigwFit2OTDwcs16kj+SKaEV?=
 =?us-ascii?Q?816EBg+wBIaI0BmtrXJu1GwoJ2rhlosYv8nTosGoAe/L9bTbvcb9xtVBTMRg?=
 =?us-ascii?Q?5e/Na6i1abcLOeep2MCDYkGppECOOcXMwks95xiaPn9xP4+sPyt1pg4fYdQj?=
 =?us-ascii?Q?5+ge0CFkmrrGPhIdWoJF/uxxRcia5A11UcApRqvewnbadI0FqahkVEW8w/yF?=
 =?us-ascii?Q?jUVIBg+y7hU0EfS+Wtk6OQKN7L655od22PWtWEZZSRUHnfTGB1tPRGJnZ9Q8?=
 =?us-ascii?Q?kpyx73QOMa+dt0/tfsx9HdMmHbd4++/xIrWNQgB6Dcg90b4Rdd+TM4vbVgmq?=
 =?us-ascii?Q?et8PeoePIMZtuyV4iLtI9TQHLexrfVGlaF9BvcsQ0yFvMz9gXKbwgE4b1Gc6?=
 =?us-ascii?Q?KIr/0Hr4zum0Fd7BY6qoR6b81ziNsdjvTC7/Ox/8nwyvMHr2Yl/cF6eHKX7i?=
 =?us-ascii?Q?DoUfssUlDT6Jmi1LPEzCd8agwZW722+2oNRGiPOmjYbUZo05c4dsJPdnZtPU?=
 =?us-ascii?Q?2/5mRfeos3xy0Owvmcd2HHMm2bKSo9V3Cqgr8SYHiLEnvEFmdUBui1U6Lxg8?=
 =?us-ascii?Q?0BU7shHCSV1nKWndRLZW3WtQEHfTdNOh/4adorWxO65yqYdGPWbJmCIgEH7u?=
 =?us-ascii?Q?7IljCSeFKOpD8pBK3JLByLg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zw32Xpgu1W98wSQ3mTRG7CqaMzouynAoXzNOcQew/okwuOTkBXWQTdzbJ7ez?=
 =?us-ascii?Q?VXoKDnvEJS5kRHVER6Lq5xeseQaSTUPPEprroiGrFsRL6nGMIdR1TALEgeeP?=
 =?us-ascii?Q?fSqE1stOHS7wPapaneAJUY3F6mZ2oVwGXnnGppIj+c4rz7CYxRs/CizGjPQG?=
 =?us-ascii?Q?XDlWb0QfOk97yw+nPTCNzNUcI4kQnF58dwAmGCpLvdxxThQIk8iAPf2YdjAv?=
 =?us-ascii?Q?vE7NgV2Y3WKKiAcXxdGWVfORB37He7jF9jYO11TDABddyf8aNSMcGWUFLmYN?=
 =?us-ascii?Q?EoD2F3835mPoTJ/sekXDXYCvtaHOu26yl4hivBn92LnJhvMFlyp69vLzZ5H4?=
 =?us-ascii?Q?VdGtruBb6Vj9BUihvHVZ96saWwceAz+fyoT4AxZIQ2LZwqZwimGdYwNkRRMH?=
 =?us-ascii?Q?9GZRplBiyMeR3wiesi5/Ln98AmUKJr+YyzJH9mTfHPsmbVfcPxOZRFzsapze?=
 =?us-ascii?Q?UDUydhiU23f/9kmJ/gx6s6VUYLvdM4yyk+P4vFAChx+VthR2bOpag2r/kn0Z?=
 =?us-ascii?Q?QMPr/Lu10Sd+NjZBIQMGSbcF2gzQsjsGnD9Tgp66/KL3phMQ6K+j9e+WriZe?=
 =?us-ascii?Q?UlonZkwMjhemnlLJg2Qf6cjwrypZhqXH2wVdam/snCcxJLrSB4GYcQ6hSzRC?=
 =?us-ascii?Q?Sie6uxV4iZWW0ap0wgtjzhfmBcsj/8ddlZiWATzfnFQBLiAz4a1Bd4A9f3Vn?=
 =?us-ascii?Q?cEttRSjOBLjWFDlKHlrctoIWlUyorIIxMu5Rb9I19ao/D2mG47JAILVq+Uve?=
 =?us-ascii?Q?0pltzty/3ufiaTAS8VcTFZKkJoySPDbWwlFxpqmnVAplLdDWkIvU79DOlEZo?=
 =?us-ascii?Q?QoRtO/3i2E1Cr8lgRTep5P1cx9040Du4PU7czD/750hADO83sWwC/e/LG/Bw?=
 =?us-ascii?Q?3QQlHCcXE3Ly1Q4V5F3b6KITCCfR4SiHecZweNTFPqjvqw8WloBovFvs9p22?=
 =?us-ascii?Q?UX8nzjTOIyjfbDaDx2U4v8zgR7yN4T03w3Oyum7o9Lpvmi9Gu5Ou3xoE9cth?=
 =?us-ascii?Q?fYvdo8roOV2JTg1YnuA2LMiQvpeZblQaGbkAbXEw0HOFJITFvHNdZPFQfe6t?=
 =?us-ascii?Q?h3/vdF5W5VOOHpNc/NgloQ05UOZYH9rDitEq1NLLz22ww5GbPMD6/NZgiGZL?=
 =?us-ascii?Q?82LB4jLfJ0yFOpR6bFUry4Z8BNa8/E9oEuDKKjIWfpz6HjNk7fsBEEGnP+x6?=
 =?us-ascii?Q?MLjzu50GzfHwMvc6nsqICBxL4FaGfPgDBTPNn27jgu1VaBEZGEM5AxpXkPjo?=
 =?us-ascii?Q?MpgTOwTaFXrncQqfSmXRJ3GU0UrqJuFKsHwGIGq5axNkvocvsJHxk//G2eT3?=
 =?us-ascii?Q?RQzMIgL6PPoQJAAxDfU6ykt/n6JJWgFSm2AiGC3msdHOKNB/s3w8xap/YOLe?=
 =?us-ascii?Q?kKrXFsntPzH4GQDuDNjZmVM0MKQwan3WqW4i+1in2mYmwrXFc97DqzGf9+T/?=
 =?us-ascii?Q?qoMM/5C4s8zzmuk3o7nvW2C6dHaQVzVVeKl57ahKxaGQFyzuqNsfzKmvuPU9?=
 =?us-ascii?Q?8+qfpzbDiZLMIR7YtFfmGIhjDpRlSHYLUVwJnrqW9wznykmpW6Oi3VNO/t7k?=
 =?us-ascii?Q?DNDUxfs/SuXG2q97VJoFvcOWHPUk24tkI7JkjhMq7HWeIiZY4DZOdIeNAW1d?=
 =?us-ascii?Q?/k3ORqkwrLtu4MUxMKBgfUJZM0B9Ky+Z1ZiiijCTENFKL8G0nyfS8ESElf7O?=
 =?us-ascii?Q?Mh71ZJrTptDQDd0iuchhQnGPNFGYyGD+kxMFx3xxSJJ3RBxtwlHgQuUa/b6i?=
 =?us-ascii?Q?UmvSSbOavg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170bcbff-e536-4e5c-c1f7-08de656ebc27
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 10:59:01.0278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b09rPnKHCXlVJRztzXV1wXOLmWVHWZb0y4tF/pQOzzG0jZVoLXQnEO1GCVdbjG7kF7G3y5cn60k4h7EVH/fHKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
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

> Subject: [PATCH v3 09/36] net/idpf: refactor context descriptor handling
>=20
> move all context descriptor handling to a single function, as with the

Nit: capitalise

> ice driver.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>


