Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8815C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 06:03:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 684D34028E;
	Tue,  3 Jun 2025 08:03:50 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by mails.dpdk.org (Postfix) with ESMTP id 1E32D4025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 08:03:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUoZoQvI4g5YmFQS7Ms5UbTiz2tDonqeNw/zah583hTE0/pJSkZkSfGJ1AipD+DyZ0EJjNNIgpWkffTv6zWtWn8ZfAX8HJICpXv4zFg+KlxhcA5/Emb2tr8c0OjuzPTbdq9JmW1YAQoNDp1eCl+SmgBneFurX0rC8z6tne9Y05bm7hWh8QjcWnUM02PW2NwnXlj1AxoS0UMjGsN/ZJX4qGCL42KuP/UUuZP+ywI8Jw3AgtB7KfAm0XGzG/Vd3ojNd/V9As2EZ4EJ7KPQMYfDROVg1d+LyUSCdxb7X1BuJiG/aRRn2/3GQ18q7iTOtVyfMuI7kEKkk8qV0X8tLPD7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCstoXd81HFUccnByq0I9c/cmXHMrwAeE/lqiwlrcMw=;
 b=Mn7E0CwN043uzE5SLqsMTOQO/cZGnOjkrKKMeqHKMydPTju0L3nj54MEQoQDMBatynmiah6kovII/hm+QbQy8+8XwAaGVOQ2jgPO5q16H7Ezg7wW4AMnQDgo6Nn0kF7bsOcamfbNhKeFrasPrPRx0zrVr7p+OsxbdVIgCHis/XcbFZ2PrIu5m52pmkhi0iYOBMkl0CPhFd7Exs0f0dl3IxFlm7pJMR072eOZTpmn5FzxwAd2HphLyMvbI7jiQkDTpCGQbkZkuklqfC7DQFJvrb6Yw9PpH3M1H83HH/Uh61nGAD2WQn+5JaKC8TqtN/b9y5P1nRnYOKvJJwMV33S7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCstoXd81HFUccnByq0I9c/cmXHMrwAeE/lqiwlrcMw=;
 b=OlcEoe6S1p8mu8uv6jKlLPm/i2gzuE0Ps6ftYTFMqmxeTH+8E9q+W+dw7PoYSElahlPXUKdRRHv8xAWTi9VwUQZLmupM5w1X7cho3VQ+10YS+2UEUHF9ZRF+//pact42EGIxWyK8tVwWsn5n+4BXPF1kTPx6n36aRcebO1irNLI=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 06:03:46 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8769.022; Tue, 3 Jun 2025
 06:03:46 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>, Jan Viktorin
 <viktorin@cesnet.cz>
CC: "dev@dpdk.org" <dev@dpdk.org>, "roretzla@linux.microsoft.com"
 <roretzla@linux.microsoft.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "john.mcnamara@intel.com"
 <john.mcnamara@intel.com>, "dmitry.kozliuk@gmail.com"
 <dmitry.kozliuk@gmail.com>, "pbhagavatula@marvell.com"
 <pbhagavatula@marvell.com>, "jerinj@marvell.com" <jerinj@marvell.com>,
 "ruifeng.wang@arm.com" <ruifeng.wang@arm.com>,
 "mattias.ronnblom@ericsson.com" <mattias.ronnblom@ericsson.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "honnappa.nagarahalli@arm.com"
 <honnappa.nagarahalli@arm.com>, "wathsala.vithanage@arm.com"
 <wathsala.vithanage@arm.com>, "konstantin.ananyev@huawei.com"
 <konstantin.ananyev@huawei.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Topic: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Index: AQHbL22WzCqF9Lj5SUqurJMDjBRIs7N4JwKAgCPluoCAVi5aIA==
Date: Tue, 3 Jun 2025 06:03:46 +0000
Message-ID: <PH7PR12MB8596C6514508F8AA29715775826DA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20250317144607.118a40b0@coaster.localdomain>
 <PH7PR12MB859601B11BE68F7DB30C64D082B42@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB859601B11BE68F7DB30C64D082B42@PH7PR12MB8596.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a93a71a9-2957-4d88-8e70-3490aecb2707;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-03T06:01:50Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|DM4PR12MB6278:EE_
x-ms-office365-filtering-correlation-id: 92d4075d-6b88-4480-0ea6-08dda26466dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MLiui8dkb5lweI/V5ZtDtJ3mDuGIdUSosDrRNI1sIZic/aDL+kMRR6f11KFS?=
 =?us-ascii?Q?kR4nsAcbWoxEN2yQqQBxCwiI1FicAHC16tbZcbF8L50sm8LXrF0XGGQ5r/Wv?=
 =?us-ascii?Q?l4V3hFuf9LYsK68/qrI0ARD9wytGbgu8axkZq8rfy+eRjIB0GEDT+QBXtnbC?=
 =?us-ascii?Q?5SCHZlHFV2EbjyGavP5oOjWV1Z2db6PRtT8OtMpLsq/fvEfTexfKtiuJQEB9?=
 =?us-ascii?Q?QBGCKsCSEuvMZkYdDrKva6DBnhbhY+Jw4IG2L4OKcMONx/k+gFWHuy0wAixj?=
 =?us-ascii?Q?5U5oA4wmEztOm/jsCVGjV9/bTvUfkqgd1uS1ZYzGx8ELDxvYaTFgJcSfEZkD?=
 =?us-ascii?Q?OEOTVbhn1fPQsJ33zWp8U/lcZ1ymPkBrfCY0mW/rxh7wVLxIrwba6B3i69QQ?=
 =?us-ascii?Q?j1MxGPBFFs6FR4YZK80TqYPDt5VyIKPCYo4kt/QX8qSdi2sAC1jgWcfo4gXr?=
 =?us-ascii?Q?Zxx80GdN3CeG7VPi5HE5BnafU9inZ/fojQDKAlgnQ3PdQPwoo4YBmQ8AhOL5?=
 =?us-ascii?Q?g/0s5+fiXxof/Z3r9JbcZnAd61Nu+O9zgXA0hgDmISW3E3cbc1zSIf5uFfVf?=
 =?us-ascii?Q?QiY41QZS4DCF87dFigDmaKt3WT6jjQojS7MLuukdJQPw01uCybmlbgRFJ9Cj?=
 =?us-ascii?Q?JLy11qZycWuy0VNc45910Me3XTUHjr/fflGYhrZMJiyMRtddUnA1vvhfn79V?=
 =?us-ascii?Q?SnUkjiYU78Xg+CqGmWzTpgww24BssN9mpH9117UXp2I/MqNaI9Kk3BAMgONo?=
 =?us-ascii?Q?FT7N8EUuOZbwP7ClUkLaYTLhwnvt0O/JSyTtauNqqGapp7PINmYo20gtKS/u?=
 =?us-ascii?Q?79HYMT909qoFWR0akpUWbF+w94dIKXIytQX/Lc/BEe6RycZaCvqxDeb/TgpH?=
 =?us-ascii?Q?ZnAFO8a3Uvo8jKrkJ4GchnFEORPlHYM/ZuoK4JsMD+ZB/0g6JTSvvnnZFt0q?=
 =?us-ascii?Q?p/MBD18JNTuN46XL2ruztue8Nxrakt8Pjlr380cmWAaVrBCgFCgD2wjIkglU?=
 =?us-ascii?Q?UZvKLmhzNDDjhuxp7sw3aP8C6Hzmz8Iu8I+tSRMT3YFy6LyaYDT5OZVKZo2h?=
 =?us-ascii?Q?n8PsvRQsInjvm+tzqhnpe6TJFiReQXWifD+a3ksS8dBnmUnsjP3hEJXx2XDU?=
 =?us-ascii?Q?jtKHU3COc0feM3uqXrGmx/mOZelcu7CFgKzCRzjaCplc9VuhvJCH3Mc0zfVU?=
 =?us-ascii?Q?n5YMTJN6mqpg1ebFElUGjjMDtamMWhMQfqlZA/7pbBcgG6gsOWsM3RLaKium?=
 =?us-ascii?Q?mkNQShzyVEkbzXvYUTS0/BtvuAv5jYQuD0mzw8lWqngF+wzvUUVR3wQnMAs3?=
 =?us-ascii?Q?qdRRE2kYU0dmEsLow4DZSvK7YB0DF6OdFdzzAtAM/wL/XEQoX6CSlRFUKUj7?=
 =?us-ascii?Q?EvFK4V0M1wpNead6qmLtXg7QT5FXMZrISDuOOs/jKfbYu8+qv8EI/zMx8KcB?=
 =?us-ascii?Q?5LlBOFQAO2A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U6jBVLZ9r4S65oo1Ao1hE5QZtyhm9IV7D68tAOSeNtDHUZ75HyQxDidCc7la?=
 =?us-ascii?Q?kDYyOqGSlb5NQY5IZkoRoej4Vnw41UXEI7kCpMCTkLnKynWc33Jqq5Q4IB3g?=
 =?us-ascii?Q?nDje/9J2TDdHB1389AgQmUJL4ZKNqMVEzt+pdPrzMHX1iyrc9J+JHc8ta2jT?=
 =?us-ascii?Q?dR1/6LQaHizeXEdZTBLLkkAN57AsU16CMorQxEalJsxHZseAxCItNU6epq/9?=
 =?us-ascii?Q?ukHT0FQZO99DOkrknFT6vlUx0v4PO0OTLqHj/i3/GWSPsM8HXXhm07IEb/CI?=
 =?us-ascii?Q?61lKM9YgiKsgbSZyM0BAfsiic0F0Xgs2yCZg7X4REbuBpf2v7oCqcxIGPMgu?=
 =?us-ascii?Q?QUekVthyumrYhJ3vSmm3A290Q6mFtGPqV/jZjqfSGyNuWio+37W1RJdDH2NI?=
 =?us-ascii?Q?KelSARNSH2e1lAyUmscEi0ocBPOhBLC9rhY47G8+ciZOgi0U7lXCsUCd5MNB?=
 =?us-ascii?Q?uQ+ETE7s8H7t3Xm6a8cg+XNVEV6gt/BueSzj6y10bVXHsvWbVdVpVKjp0OU0?=
 =?us-ascii?Q?NYulCO2dJ2sJmt4XbauLYMBiZKaTl/nmQnOOom17boAgzVP4bONpI0PFAmok?=
 =?us-ascii?Q?4cmQH8x+n0xWhX5HHtTFUGNji+CZrmVqM1XZy2xvbH12B3LCmsMH/7PcX6O7?=
 =?us-ascii?Q?ISUnskZs9ebOWWH0SlrhlgSyyfVOsFpxfkRQUN9X0Abf6xRE5T+PhKFUh9Md?=
 =?us-ascii?Q?bO5Vc2UwOlt0GF+P6Ge0VPNp4gVYolsov3VPtlPcEPrlbkkWNljsPdXUS7r+?=
 =?us-ascii?Q?2EdCwiFMqonDkW8ymkC9v9iuBMSynOldZB1jc6TJFn/X4CILIOTBkDKbrUpG?=
 =?us-ascii?Q?ETXqoiI+pgPwtJ6gTahx5Y6/hGOsnft2jTX71Q7G1O5/Z3V11mvuvOv89oOM?=
 =?us-ascii?Q?IaegG3wewSMj+3ubhgQYXJStyygeZFnxH+cBSI7OlvKVW6tM/H1xuCJbeNU8?=
 =?us-ascii?Q?XrsDSOH+A6YkpXqrksiM/F/svGM9mYUi1zGrN7NgY2tH6zMgwJdKwp5QhA7h?=
 =?us-ascii?Q?7hyv6yKoWELhL2FUQLncQkcxCe3s8Fwg4pzavY7HQHsMRh/d5p29J1aikjR5?=
 =?us-ascii?Q?HRevIxvx2ND5Mw9zoZaVVjREX1jSLUV7C8LiBONOA9wGpBefoEeofogYh4rH?=
 =?us-ascii?Q?t/5eKRVW0h4IVYEx0U9iIQNqmoNLIBQoJAURVIEuBH9wDdSH3d8Onng+8WKi?=
 =?us-ascii?Q?lZ/5XQj9xGLs3H5seIPQ60bATFKJsspiN3om92+a8NNYaw9+d8bLxPQ+kCnH?=
 =?us-ascii?Q?h8yDsrrsb1PcHYrBmx0B6NPyDwZhvrDMDHmrcquz8vIVVRgL4lSpV9soYFJ+?=
 =?us-ascii?Q?us3+kTBf7txeqL92FrT4gHwY4ySDIZYNVwJDjkBI8B3+WEuwH/do1aqvvPvK?=
 =?us-ascii?Q?ghfchr6GNXK3Q4w1GV9bmbVfRYT8+ILvD/eg8+eXdisv2wmYmkfwLI67WL4d?=
 =?us-ascii?Q?yaSWYZr6VZur7cIEPPkne1cNzoAB+mOIKgX5hE78AD0tvexKdA65Htky7KgR?=
 =?us-ascii?Q?GiOYgEIcElBs6U/VfxPQpg6a3OILQtmedcZ4BwQ8vAKOY0kX7UFgl/srhgLj?=
 =?us-ascii?Q?2hYlSq08QavYvKGI6v8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d4075d-6b88-4480-0ea6-08dda26466dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 06:03:46.2634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pU7MSYNOovvVBvIaftdYjlbEyHB7vCZuxhjB+emUicGeL+8OGLarqHe9y/LlS0MVfac6RvaYSS/yGh+AVZbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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

[Public]

Hi All,

Saring `rte_topology_` API patch next version targeted for upcoming release=
.
Extras adding support for Cache-ID for L2 and L3 for Cache line stashing, C=
ode Data Prioritization too.

Snipped

>
> >
> > Hello Vipin and others,
> >
> > please, will there be any progress or update on this series?
>
> Apologies, we did a small update in slack, and missed this out here. Let =
me try to
> address your questions below
>
> >
> > I successfully tested those changes on our Intel and AMD machines and
> > would like to use it in production soon.
> >
> > The API is a little bit unintuitive, at least for me, but I
> > successfully integrated into our software.
> >
> > I am missing a clear relation to the NUMA socket approach used in DPDK.
> > E.g. I would like to be able to easily walk over a list of lcores from
> > a specific NUMA node grouped by L3 domain. Yes, there is the
> > RTE_LCORE_DOMAIN_IO, but would it always match the appropriate socket
> IDs?
>
> Yes, we from AMD were internally debating the same. But since there is an=
 API in
> lcore API as ` rte_lcore_to_socket_id`, adding yet another variation or a=
rgument
> lack it luster.
> Hence we internally debating when using the new API why not check if it i=
s desired
> Physical Socket or Sub Socket Numa domain?
>
> Hence, we did not add the option.
>
> >
> > Also, I do not clearly understand what is the purpose of using domain s=
elector
> like:
> >
> >   RTE_LCORE_DOMAIN_L1 | RTE_LCORE_DOMAIN_L2
> >
> > or even:
> >
> >   RTE_LCORE_DOMAIN_L3 | RTE_LCORE_DOMAIN_L2
>
> I believe we have mentioned in documents to choose 1, if used multiple co=
mbo
> based on the code flow only 1 will be picked up.
>
> real use of these are to select physical cores, under same cache or io do=
main.
> Example: certain SoC has 4 cores sharing L2, which makes pipeline process=
ing
> more convinent (less data movement). In such cases select lcores within s=
ame L2
> topologoly.
>
> >
> > the documentation does not explain this. I could not spot any kind of
> > grouping that would help me in any way. Some "best practices" examples
> > would be nice to have to understand the intentions better.
>
> From https://patches.dpdk.org/project/dpdk/cover/20241105102849.1947-1-
> vipin.varghese@amd.com/
>
> ```
> Reason:
>  - Applications using DPDK libraries relies on consistent memory access.
>  - Lcores being closer to same NUMA domain as IO.
>  - Lcores sharing same cache.
>
> Latency is minimized by using lcores that share the same NUMA topology.
> Memory access is optimized by utilizing cores within the same NUMA domain=
 or
> tile. Cache coherence is preserved within the same shared cache domain, r=
educing
> the remote access from tile|compute package via snooping (local hit in ei=
ther L2 or
> L3 within same NUMA domain).
> ```
>
> >
> > I found a little catch when running DPDK with more lcores than there
> > are physical or SMT CPU cores. This happens when using e.g. an option l=
ike --
> lcores=3D(0-15)@(0-1).
> > The results from the topology API would not match the lcores because
> > hwloc is not aware of the lcores concept. This might be mentioned somew=
here.
>
> Yes, this is expected. As one can map any cpu cores to dpdk lcore with `l=
core-
> map`.
> We did mentioned this in RFCv4, but when upgraded to RFCv5 we missed to
> mention it back.
>
> >
> > Anyway, I really appreciate this work and would like to see it upstream=
.
> > Especially for AMD machines, some framework like this is a must.
> >
> > Kind regards,
> > Jan
> >
>
> We are planning to remove RFC tag and share the final version for upcomin=
g
> release for DPDK shortly.
