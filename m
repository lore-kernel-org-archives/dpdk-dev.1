Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8896D2D11E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 14:51:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E9884028C;
	Tue, 13 Jan 2026 15:51:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id D045440276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:51:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768315896; x=1799851896;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=ntYD016Z1JeagcaPCTyE94L1S3574wMhj5Ube7B8OxQ=;
 b=StLpbroP3/eVt5HG3+AESVInpXrg23o4mepCITNgr4AJzqYKH8blgr8u
 FcmYjUbTy13bqfBitfCDpb/Yzw4gnWxYXrtttNl6tZzlMFU7Jvpvj22MC
 0DrhE832tSJnE9pjalIBI9Y9NwEaMYxTGAQ1TcVHzVauEkO+OIWo0LNiA
 gBi1MU8r19FzPmwZ2DCfzCEJPhU1/I/CnRUh2qefkCvS0Wvn47nh5fz5O
 SUN7Eionf9JjAxYgvCzVygExjj/bB7aRWZd9pCAttLyhWJXICO3IO4L7u
 NpdKLk6M8rBrvpwYrsOY5LET7rBR6/zmDkO3zBuo2rGsD70tRndD+KZeX Q==;
X-CSE-ConnectionGUID: bHp5AKF0TdeXtXsSPTyBfw==
X-CSE-MsgGUID: seuQwFymRmqtS9WrLnHY1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73442792"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208,217";a="73442792"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 06:51:34 -0800
X-CSE-ConnectionGUID: xTwF6XILSOWfMSKu8eOEUg==
X-CSE-MsgGUID: 9k0hongwS56QBiOEfeWp3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
 d="scan'208,217";a="204415120"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 06:51:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 06:51:33 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 06:51:33 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 06:51:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp73ICej6bbU357s0G/NRb1GTBtdqujfMlui50bx0B1Wev6ld0RPTdSyDCO0/l+uTlUjh3CG3Nr9pjBaHcHzTUc5MVZWO5GDDnUnQgn/4qgNyfh9UTjQPWxnS3kEXlOsDl6QbnBMJTBG9QuOXttHnz9R0sPQP1sDFPa1vje7qk2VNsE80b3v0ujuqd1EVRtffhMaqgk07DT3mhwTiFRhOD3DMjDxrqVnVsEUpUxOlfGTkwRBVbVbiJslIqzA6Q4gW8IDkjOZylSQ1FVOf+snzr8Wx3Eu8U4OXQuqmacljQ5qY5Bzju27bn9fUhIzEEOJg00VEe/pnC4WkZ5sQZG02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTKLqcMwUxQlhThZGnyq8N76996Fl9tQMQ3I5br6z08=;
 b=JRxadhAIPWQNjVRVZPQyFUfnZLBgbNWc1qtwbJNQUfmpee3bPm3LzqHY9CYsi/+zsI3Rm3e1r0fGwSpVdR7sCAXJCL+usvRvZv3jIgSmloGRtfZ6pjCdBPdrPuewpujlny1gUVVCE1wQNFV3BnuoJehwkI1LZPaXiR2emL4F5ZYR9j9udCNfwn/1E3cF3u61drf2xyM2EWbwLqXFqy4SycEeVqVJ49zyEg88dNxzhIVFfBych2EYfrOBcc1HpXoV1s7A5kHkMmSmH+NFHGaDuWBgsh4wBGOoz7UPwNHauPOtX+QALIPXHoNGZAN0AeTV+99M+O/NR4R2hMUquNkkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by CH3PR11MB8592.namprd11.prod.outlook.com
 (2603:10b6:610:1b1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:51:28 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::bdf:9086:1292:5d72]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::bdf:9086:1292:5d72%5]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 14:51:27 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-01-13
Thread-Topic: DPDK Release Status Meeting 2026-01-13
Thread-Index: AdyEnAX79aDZFG7lSQyUiX8psAOjjg==
Date: Tue, 13 Jan 2026 14:51:27 +0000
Message-ID: <PH3PPF37F43E35D937D02A9C544D3A792F2FC8EA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|CH3PR11MB8592:EE_
x-ms-office365-filtering-correlation-id: 4733bab6-c224-4a1e-40b2-08de52b33b34
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aJu+NTe84yRqaFCNuHA+ACgG7bnHfLWkDOC9UVK1xK9J/LFtC21uSmzOlEv5?=
 =?us-ascii?Q?EdQPjPpHB08r5gQn2G4cpkvn/hsB82iTF5WaYXv+lqAqQud8tZ8/BDA7R2k6?=
 =?us-ascii?Q?tZ+xaGbeLnmKoQTwPUIZ1rvUCSi2lD1rwiiHEoMjvH16VAh9c22P80GYrnTb?=
 =?us-ascii?Q?gOg4RMYVM69glHlclBMHOB+9dIdl5KfEEYw+X4JPWxDNI/9iABtTG0aLPYoR?=
 =?us-ascii?Q?KDQ02wzUvYzsOD8Bp8+3B6vtDbRL0GkXB422BF7Axq4xIBlyAp0gKp8NN7lu?=
 =?us-ascii?Q?ZHFjQE6Tm3NdYJs77A5nkjZUAGPUrkkvrVYPAH6O1M+yLVoWuJvveDkGtFom?=
 =?us-ascii?Q?SosHwRfkpHqlMmahW+yCRKmMKFYxjHeuwW7/LwaNBOBbFJTuJN1Kkcb0bIES?=
 =?us-ascii?Q?jvZPh0tIFcTEneFHrV9k2Uu1W0OOJb8S6t6Sn3S+eooD29QibU09f2iEBqTp?=
 =?us-ascii?Q?D9dreXPqz6Uaq5VgXIf4QHdzyjOovCOxB7KJVzjloiJvgQv/mZXTEXqcXpFu?=
 =?us-ascii?Q?ErNEQDa7NBhKPF0N2bZz9IuSKPDqRJocavCzQsn7r4EmvqOj2IVFeVUqZUmf?=
 =?us-ascii?Q?cwuPzekGQFIr8bpPQX0447ezL233EouIp+KZd52LqJZYT3TZKvth807KYqx6?=
 =?us-ascii?Q?rkaEwM9/QK2kvsNXFLZiMGt7A0hGnIWdHjKRTRVj+i0QL5glycUUhoVHqc8C?=
 =?us-ascii?Q?R+3UnfJ8pcuiiIlUN0aYKpobFypfbKizLMkF1tygYXEm7fzCBlA7CkomUX6c?=
 =?us-ascii?Q?e+QTiTAFRJYQZvT9+qC9k+Gk1MLELuralOySgHDvjlk+CF/ETZLKGdZdWe7Y?=
 =?us-ascii?Q?ivLYaXRlwIiyFO3hi0fBXTuCgj7QmH8ue2qtvxcvTSW5YqGZ3iJXirTsZ1aE?=
 =?us-ascii?Q?QtJaBRUbgWO8Ivw+eU3z7e27jh7hsDVF9tZwp82CqjtyudVlg4dqwqPh1T0X?=
 =?us-ascii?Q?GcbxapnFX++unPlcMdsCjIpyXABwHj4xvEz9FudoV1x6VmfKyVO5/fSZs2UN?=
 =?us-ascii?Q?nU1MO+sjRfMJOINrerAJUUnZgRvIxTlMlr9EUxayevkzH3QK63Pm4+kHoluW?=
 =?us-ascii?Q?2kgTl1MDNEFXaQc16tvL2jd0T+DVjhpPTnqhZql+ABmgjmsxP0UWH1TTtKrC?=
 =?us-ascii?Q?kFGhHvihCxARnnrUIIaeAlfS9OhBImo/zFkxSNvre6uXa0ngWQsQmzNcgUtr?=
 =?us-ascii?Q?8jkS7M/wxpvfhrW1rOumQFut3ZjUE3sTuBeFlFGL8o43+xzHX5EqvT4lqios?=
 =?us-ascii?Q?dZ8rZwUIdE4FFObbSldpi59SOIh10CF8AaEcCPrgwNH3BC7rAJV4L1cgkbXT?=
 =?us-ascii?Q?3d0F4n/QLS4oFljdCwl64kvYdtdKMOzQIJB4CwOji2CsWKiwV5NtONJo8aB+?=
 =?us-ascii?Q?yp90ZeFu57+yXOlkTUGnZ6BhMMXg8hAKQJjHsNjzprVg97h3kDOhJcPnHWS1?=
 =?us-ascii?Q?Fpwypd8tSQRYPOjBLGhoaw/4NxQ3BwXvSVfUA+REap8eH3Zv2jFztw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qm304TfJSrhCSbQx3ZNc2kwkCsCtq41kwFAJXgMjKGplJzemgWBo1ONo12hq?=
 =?us-ascii?Q?SWnBxvJMK3lWa69FSUWdRxJ7ebgkV2OIO2NaNQuCARrkeDjNb5x6IhLGOVjk?=
 =?us-ascii?Q?IcmCvR32pa58W1TxiCQQEmfgF7ZZvuYM+JHmQ3buWU+X2RtuyyiAmWHxrUND?=
 =?us-ascii?Q?CCrJmoo7XSPsSS7EOrBgVQ7Hg3XhCrRPgxL98oEl3lnSke7wn+scDXSb8JgJ?=
 =?us-ascii?Q?gvX2C8SRLokEmzgPQ9fRJUl+WezSVnzVeXhzz8sucKryYhP0d7ZkTzQae+O+?=
 =?us-ascii?Q?wvPVZZ+nj9LR3cAH7A+DHyZ8DvKqyhoQzPvZug5oNY6tjRpnn+/L5sIikl7m?=
 =?us-ascii?Q?nnZ87n10oZZLTgxnCPtVNHY/mf6NbJv1OLWhccAa+3Sd1Mt9sGoYXdRbgRos?=
 =?us-ascii?Q?rxm+eYVBOk4t19sQ00JzB8Cs8o/rV+FNTPdBacMGjPYnyrNXkSg0338/HWGJ?=
 =?us-ascii?Q?vvclFT9tPoBxrYP07i3mx4lIaTOq395tb5gyhq7ermExopa9jb/urbstZo0a?=
 =?us-ascii?Q?K1ICXFK8Wybq6CoVKkL1lhfUqMw2vh/jOqF3bLogbji/27/BvVbaujVFV/a3?=
 =?us-ascii?Q?Z6JbeyN20t2LlH+DhHCwPz0zeJECs0sV932CCatMTrQSLaScRa//toBw8Vs7?=
 =?us-ascii?Q?UvM7DhoO39DFyDGI20IggV+pYlPG1aUGf0ANpwIE74ICD3KW0BQspFXwuN2X?=
 =?us-ascii?Q?38qnshQ8Okc6KxviQdVpU5HoEx/8fJmFAw0Gmy9P+jpMjJU84Eg0+lv3Djjr?=
 =?us-ascii?Q?nGrBZ5zFDl5PhFW/p+m2xhXXQTIFsDOywVGHyLp+wvHzcA9P0Xkmb7EosarF?=
 =?us-ascii?Q?fjCVU06Y6nAmUyolZ9QzbGQmoSTgekiHEmxkLKNZ+fovLxpLiz2fqS44AP64?=
 =?us-ascii?Q?D0GNS3Ryq3P3L7umyWVw+SKR/sNFpuxBISoZV7p+v4rfNDtdbjHiiKVuqMRt?=
 =?us-ascii?Q?4eP/mb7JsuT3i/WdmDVkJUbRnJXoZC7EmshdyL7bsRxApqktHxI+PymiIIOx?=
 =?us-ascii?Q?8Oz/4/zxY8cMDvqmce5KFGrm3bxSCrAV2g4WKnEcYah8biJ1h7U9K1WahwHz?=
 =?us-ascii?Q?j060co3EA6Rx3lftbWMP9RhkfObICfKG8wjNsurABeVR18ziAjx5ljeYdR/q?=
 =?us-ascii?Q?UzWGLmg/sA4mtu9ziGI23aXPjGiTPI5l+QLvXR4qgLq1GvXr8H4hYb4JID7h?=
 =?us-ascii?Q?mYu3q5k4jmFFefhsx24BKjL/k9z47ddQi/REx7TbUb1Zr9RXUTOpYhPcSn7I?=
 =?us-ascii?Q?DOVSt4F1DvnoV8KbXRZdJMtRFgK9T5ERIfU5yoqhKvNhYuTEz3Yuiss12ajM?=
 =?us-ascii?Q?kWVfiJSbIVallBKyCUAuhIgyq7mz5gpgi8Yq76zoyINzScVKugQNYAJ+LBtM?=
 =?us-ascii?Q?l9MDt2XdyFBKxdPm9fPe9k3AyYCwCUo5Lc3uostMd8NJ6aeUtKJrLxnQZJqC?=
 =?us-ascii?Q?0xibGQZW2yvD3ACKApLooo4clQn5GzkF6azPbpuaxIXRhsG5gAuPQozMGbAX?=
 =?us-ascii?Q?MkNP8dSzREAkkPZpw27Bjg6Lhlo82VV+WE5qnGHQth6ri+Ix+IxGkbA7wejq?=
 =?us-ascii?Q?Srl9HGJbnBUI7r4t/TTXRqQujPe+2GysOb34XZkSutfCKtJHZ0krDtz3gHPL?=
 =?us-ascii?Q?cpQkPyod4QrDGYjIWact2Ff45LkxWGrL2UtGcZMGAFoC88gi1RLFTS4gWWHs?=
 =?us-ascii?Q?vFve5Zo/CC5TUaeIa9lUQNShidqsL0lNq619HBNoTGRDct6pjy8PBf3/+k/y?=
 =?us-ascii?Q?BW3eNYLq7A=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D937D02A9C544D3A792F2FC8EAPH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4733bab6-c224-4a1e-40b2-08de52b33b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 14:51:27.8744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3cgS35y3YIJ9mSEeYmOXhQa0E/Q843X/ZsgySpHYsShnWTxdVHvoCCoDy2qdvP8m8QyMzokPkcsV85QJPLOLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8592
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

--_000_PH3PPF37F43E35D937D02A9C544D3A792F2FC8EAPH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-01-13
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
- Release Dates
- Subtrees
- Roadmaps
- LTS
- Defects
- Opens

Participants:
- Intel
- Marvell
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 26.03:


| Date            | Milestone      | Description                    |
| --------------- | -------------- | ------------------------------ |
| 5 January 2026  | RFC/v1 patches | Proposal deadline              |
| 9 February 2026 | 26.03-rc1      | API freeze                     |
| 2 March 2026    | 26.03-rc2      | PMD features freeze            |
| 9 March 2026    | 26.03-rc3      | Builtin apps features freeze   |
| 16 March 2026   | 26.03-rc4      | Documentation ready            |
| 19 March 2026   | 26.03.0        | Release                        |

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - 24 patches queued.
  - 2 Pending.
  - More in flight.

- next-net-intel
  - 15 patches in backlog.

- next-net-mlx
  - No update.

- next-broadcom
  - No update.

- next-net-mvl
  - Working through.

- next-eventdev
  - Working through.

- next-baseband
  - No patches yet.

- next-virtio
  - Some series pending.
  - Reviews ongoing.
  - Some fixes posted.

- next-crypto
  - ~ 11 patches.
  - Snow 5G.

- next-dts
  - No update.

- main
  - Working on CI issues.
  - Unit test work under review.
  - Series adding additional warnings and fixing
    the resulting issues.
  - Fix for GCC 16.


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 24.11.4 - Released.
- 23.11.5 - Ongoing. RC1 sent. Awaiting test results.
- 22.11.11 - Released.

Older releases:
- 20.11.10 - Will only be updated with CVE and critical fixes.
- 19.11.14 - Will only be updated with CVE and critical fixes.


- Distros
  - Debian 13 contains DPDK v24.11
  - Ubuntu 25.04 contains DPDK v24.11
  - Ubuntu 24.04 LTS contains DPDK v23.11
  - RHEL 9 contains DPDK 24.11

Defects
-------

- Bugzilla links, 'Bugs',  added for hosted projects
  - https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.


--_000_PH3PPF37F43E35D937D02A9C544D3A792F2FC8EAPH3PPF37F43E35D_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Consolas;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2026-01-13<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Marvell<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Stephen Hemmi=
nger<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 26.03:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| Date&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Milestone&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| -------------=
-- | -------------- | ------------------------------ |<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 5 January 202=
6&nbsp; | RFC/v1 patches | Proposal deadline&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 9 February 20=
26 | 26.03-rc1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | API freeze&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 2 March 2026&=
nbsp;&nbsp;&nbsp; | 26.03-rc2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | PMD features =
freeze&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 9 March 2026&=
nbsp;&nbsp;&nbsp; | 26.03-rc3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Builtin apps =
features freeze&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 16 March 2026=
&nbsp;&nbsp; | 26.03-rc4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Documentation read=
y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 19 March 2026=
&nbsp;&nbsp; | 26.03.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Release&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Subtrees<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">--------<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 24 pat=
ches queued.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 2 Pend=
ing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - More i=
n flight.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 15 pat=
ches in backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; <o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-broadcom=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Workin=
g through.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Workin=
g through.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No pat=
ches yet.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Some s=
eries pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Review=
s ongoing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Some f=
ixes posted.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - ~ 11 p=
atches.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Snow 5=
G.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Workin=
g on CI issues.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Unit t=
est work under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Series=
 adding additional warnings and fixing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; the resulting issues.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Fix fo=
r GCC 16.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - None.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See also: https=
://core.dpdk.org/roadmap/#stable<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS versions on=
going/released:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 24.11.4 - Rel=
eased.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 23.11.5 - Ong=
oing. RC1 sent. Awaiting test results.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 22.11.11 - Re=
leased.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Older releases:=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Debian=
 13 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - RHEL 9=
 contains DPDK 24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - https:=
//www.dpdk.org/hosted-projects/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Release St=
atus Meetings<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---------------=
-------------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The DPDK Releas=
e Status Meeting is intended for DPDK Committers to discuss the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">status of the m=
aster tree and sub-trees, and for project managers to track<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">progress or mil=
estone dates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The meeting occ=
urs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">You don't need =
an invite to join the meeting but if you want a calendar reminder just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">send an email t=
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH3PPF37F43E35D937D02A9C544D3A792F2FC8EAPH3PPF37F43E35D_--
