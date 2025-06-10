Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BE7C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 13:02:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A406402D4;
	Tue, 10 Jun 2025 15:02:17 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by mails.dpdk.org (Postfix) with ESMTP id F0AE44026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 15:02:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPaleYI5FY/WeyZoyi6dM0W2ka7Vg91V3D43Rip9qcKMEiivlLzwPnQ7W8SG4XHJXHY+gw0itNDTWAF+6DVL0KLbq3Mk6ur3+Jmy/z9wo84PsOCa9mmRiHoUhOakvWB9YUSKeHc08zI/vj0MekBqLSKXoMxIUWDuCR1QrSibcra+RwchAFwmTOTLEGW2hyDwqSRyJsT2foJaW14pgJTURsLJi5mKaZD0trf1obGzxdNE/4LHwxvOr9riyZaqZk5T1X4V1Mc9GVjucUnIT5tNA0hzhYKepPAdfvYBbGuzA3GFL/yiE7Ots8lwKoiZFx1ooERAO4MxcUzObHtkw9tX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9loDdawQ/dxFnZd+vRBcn96TYDOoTGZGjMusXC0l0Q=;
 b=aYm4k0W8e4DDvMy7AJUUrHpzEu/G8/UvdfS0wyR/jnJBTE24TwrSKL7NqAfRUjfNv97O7maAOJ3sIPs+Fviqi4VF0YC1/4KyTShg8Ibstuc8t6RjrycrAhOBCP/JtN23k8oIc8FW3sNEmUffoXTLImFMb1nLStXmfCnrqzDDpDwJ4mkEJnY7UttUhgxYGSKG/icibL2oQnaXVCsuH3o9fht/AHYfydGttV4dfIZwFNEpD11x+oo0zyyABo9w4tJYL96FxiDYUF/5zVN1iSIJGb4C2G61AY/sTTJYLDEkSKBKy19+jdKuSrHFhXXSBauX54dafoKUzzGb/f86lBcCKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9loDdawQ/dxFnZd+vRBcn96TYDOoTGZGjMusXC0l0Q=;
 b=4A4fO+//uSCbuG4Swm5GMpEotssPYWZMYIUwYpK+LN1mNwqgAj0tqE2li9Jh6yFX8xvUTU1s57GiYPt8QkPqrl7KMlJrzW8oph0hotSF3LQL/Us9biKDCYZq55VoDYZqFpgbzUvew7H1f2AHGsLmifK6wuDNYvnTEWIuJznKnH0=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 13:02:13 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 13:02:12 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Song, Keesang" <Keesang.Song@amd.com>
Subject: RE: [PATCH v4] build: reduce use of AVX compiler flags
Thread-Topic: [PATCH v4] build: reduce use of AVX compiler flags
Thread-Index: AQHb0LCFssNT35AU5kW6BTDmyPwZVbP6ZSmggAAh4ICAAEGXQIAACI4AgAACbwCAAZdkAA==
Date: Tue, 10 Jun 2025 13:02:12 +0000
Message-ID: <PH7PR12MB8596ADB9B5BC7947CF6AC43C826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250529154249.1310449-1-bruce.richardson@intel.com>
 <PH7PR12MB85967617A71099E2F0E5C835826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEaUA7rDVyPJEvP7@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB85969B5D596151F83DA09600826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEbSNr7iv7oNJ7_U@bricha3-mobl1.ger.corp.intel.com>
 <aEbUQNFZHhKFKGeB@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEbUQNFZHhKFKGeB@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a5b10a89-3000-4033-a535-523dd8a7cd07;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-10T12:50:21Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|CH3PR12MB7570:EE_
x-ms-office365-filtering-correlation-id: 79065b9a-7e01-4fd8-8d22-08dda81f0462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?O7fM1v8CHhOtow2GHbuank5uPB2wirPGerj8pnvbpjSCC/Sw8+n1rYJIPlbs?=
 =?us-ascii?Q?u/j8ftWPDy+DopeRUBf+wl/t0b6GgZJ5auiunf3lGwW+3IgqqV6iEbjwl5B9?=
 =?us-ascii?Q?nDcQMo5CbFq+YiRaJxwNe9/rX5Ff/Lf5fE3YRzUurGJal/wyrXPBiILFCfxM?=
 =?us-ascii?Q?qeh+W2uMTR4UW/dsk1GJ81z7jRMStJQhcTnT9EpBQMwYttI6FHlDfRuwH0SX?=
 =?us-ascii?Q?4pCX/FrEIMrORj9/4HDKshdyycRF/0e7MaRr9BHbNbvE+ZN//SV7tIZS04G4?=
 =?us-ascii?Q?VXBYNtgAZLQOWm0iaV5I4lhMPC6IM3knzrt/1sICOasb6wfeywOYpf31fGGI?=
 =?us-ascii?Q?84I5FIipF21o7OuuNWw3BnYkhnrJKM6N4eVPSAH4HLV5R2IcqBYMOjlz59O9?=
 =?us-ascii?Q?iqCifVRcn/KQAnn6AZlCd59SOfg5QnqnkWhpG73RM3T7MaM8VcOyRx+cE/5S?=
 =?us-ascii?Q?uwEy0TG9FhJ/XQwcLy5AwD761DaGV6PIl+2Q1Z7XVi0MfrpiHlInQyRYUXd9?=
 =?us-ascii?Q?xXOqhDVTMS1r1jxBRrgYNXPhc2c090v7jjEvnSUU6dIW8Wgj+oqRH83i4RMB?=
 =?us-ascii?Q?OzbmTZ3aSbJfIOJniSJnhIdrbn2fp491MW0abDvqPYCpJHyFC+hFzTS3LNd0?=
 =?us-ascii?Q?8c8HDIvEHLn3u3U2QJXIyurq9VsgXGkrjuNWXO2LzjLZCXYzFNPiC1EPhNcw?=
 =?us-ascii?Q?3UQwXRDqejavN6pJ6rvlz1RV/c+CaQd6vtr0fr0qtFvGPd5gnSL1QFATvhya?=
 =?us-ascii?Q?JF4Nb+2w+D+yH92dTQFeznFio0efmtt7WwvLiydH1Ayt2mBII98/tpMJEBWr?=
 =?us-ascii?Q?i2hAIvOQ4y3AxJu8IJ//Oa4Wd72m3RlatBNYxnSsSYLkX733RaRzOa42UC7d?=
 =?us-ascii?Q?l4QJJz70izOvYTZNQkzkk3L12N75WJWHm/Vg6ilwBvrxYx4UqOHN3iruU+Mo?=
 =?us-ascii?Q?ZNIKhx6MVjH6mCQaawz9vOD2Y/Ub6PicYQKZVk+npD+rgQK1k9G7qJJZ0fcf?=
 =?us-ascii?Q?BLtg/nl6bm+xIqjbZ7zRmYxNeglOrgabGfIyx0T1cDF5Cir0jsm+Ix9lNw/+?=
 =?us-ascii?Q?DN1T4f8Bt7tYo0MW0BuEokGcKzQxgRFaYbE1eq9hNHORqqeNchudtq97AXBD?=
 =?us-ascii?Q?gL4u5dQ+8aFqTlYxYsyGNgInqaAxWY8RQKzgVwSuYSNNhc0nJCK+xby+kgUg?=
 =?us-ascii?Q?v/pn65xxX6PdHxZ37Hoq8Hq2PeZ3JKGIVInsMqpzTvw/8zjq38r6Wz9aBLb4?=
 =?us-ascii?Q?E9NpoM7WoYYJEwbK5dG5hwTAkl7WqoEMHIgiRQAICcPYFArxfcAb6JtRNg4r?=
 =?us-ascii?Q?b9SdOQqrJE41zhturqRfhaX7E6Xl6IaUwpgBjhHV+H1FgTQHF3PvkODpKi0V?=
 =?us-ascii?Q?mvwsA7qmZz8VHd1iRs2Dm0/LA37jie78lKW7OTe0FGJ+qT5T+OiDbSTxkNvx?=
 =?us-ascii?Q?41lpdagWMnM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uPilKRebJ7uTLB0eH3Qtwgetz8a743fZRq9qXm+mFls/YrI+sFVcjeVhfGQu?=
 =?us-ascii?Q?MIPz7axEHWhZvsoTBBpNBHpca9YGQ/Thym5DAjPxiJFmNyzObS5g0A4D2to5?=
 =?us-ascii?Q?La78/m1P8T5+YGCprVL3ULFjkOu/PlRcwMJTcVLSAIpul2BBzIwGh1ytbKX7?=
 =?us-ascii?Q?VmDFv/1kx4bMlVugE4zT5+s0gLWg+EtWEi4DpPabCJ+lMbXsSalFj+pJnZgp?=
 =?us-ascii?Q?zzN62mpz/EjLdHVbJ4/vZtxB1sYl2s+NAAmx6u1dZ0CtGT9D0P1rf6OqagdN?=
 =?us-ascii?Q?Hmgn25/eCjCS5KNltaA4RtTl3QPGSnJwHqwFNv/5zQa3a1Bb+cgq2c3VpO3J?=
 =?us-ascii?Q?Pn3Y6gQnI8Z+s5I2dxNEF1UUk9DHvqZCl20Nr8aVFOCPDrbpMAHYZLP1xVaj?=
 =?us-ascii?Q?DPhyhk1+GBbRUCjdF7yHHSNhNSu9OV8yio9IekrO5d9wFksbyg9+OJvYfxg4?=
 =?us-ascii?Q?7g4i4z/n+sLHkh4eejw/zwkdmEg7bDGKx2P+5R9wmujESxTkCRsbPt+Y4kKT?=
 =?us-ascii?Q?NPZM+RoPlM517+PBfeHmE0YUlHinZNx9OVTLF77L2kQ7Dl0854dlIdv4PY1T?=
 =?us-ascii?Q?k8k6EkdXqzHmF1z4gOkPRUOP7WF8fYFQ7rEqz76i0V9XR/N96Sjgb4qZw4vn?=
 =?us-ascii?Q?NYaWRdi+JmJLcPFJR+MDRhcoIlHMqTCXFUe53jFKF4VRzqoIUjLSvK15mUZ9?=
 =?us-ascii?Q?ULRqMsEcs9MO6c0rdywFmizQyaW5M0RClJGz5wXA+ZcuCE4ruPUyhJMOSWW0?=
 =?us-ascii?Q?hFIi3AqUZfoi4XaM7WAQ1dgbzvzIFn/DfpQNoyI40GpWvQbHukwUCkpS6THo?=
 =?us-ascii?Q?C6Waa8M052ypYedi5lfc+6P4n3VFKf9ohzfxNDj+Ai8HMruT8RoGEf0PbiVP?=
 =?us-ascii?Q?nQ0wJjenGlKyEYA6N8I8o7YxRUggNuqBo3Atct0cwe/bWkAiVaQU3Hw7NQu3?=
 =?us-ascii?Q?jffhYelupiOO+oFhdPq4R4tnuK1aQkUtzlMsZ2WbAkNW2dipTptCS6Ka146y?=
 =?us-ascii?Q?TkoEvDote2es9MESZxgE94Vev8wGu3g7vIautoKFEf53bxl5tHyLxHE+mmra?=
 =?us-ascii?Q?5rMWFis5j7CEt5XdwLrNfD/0Yb2DcwVRzHFEbQ3U35Fm5fRp9mveAzhw9iKu?=
 =?us-ascii?Q?eepQLywFh51cQ6r8RRpmnLA0Fx8panliInuiYsnGDrJrAiAv/5pFEWJs9pW7?=
 =?us-ascii?Q?F3rFpM/f1cOrJAPyrhNefWWcd+/420DJMkGd9lm/7PUCz+KK9IoNu0lWQtG4?=
 =?us-ascii?Q?wMkO2y+3v1tU+ddeBxYRzNCIK+oR/+Kpho55Jfma4aKyYp6pn99BY8gXmwmC?=
 =?us-ascii?Q?hugVxPuGn6ThNZ1LlSC5VhN0RVP1Bc4EiOKzWi3km6bmBokKTED/FD+WyQ0w?=
 =?us-ascii?Q?qVJNLMggFdNLra8eh8JF0DQxgcdrWmZU9Yh0KICQcqFPLiCSnGZSBXHvqYB+?=
 =?us-ascii?Q?cWBhcfvLCVO7OEmzzcnWI+XXjsWfFjsNmRjjBm4+x7I6jkiNhm3Ol+WFi8vY?=
 =?us-ascii?Q?DGQ9d9HSkUyVsAwtBTVlV1wfj90oddO4+9lXbCgDGvPcsoQi6Npq57Uw8tCA?=
 =?us-ascii?Q?ynY8Gnwtsasw1VM57tM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79065b9a-7e01-4fd8-8d22-08dda81f0462
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 13:02:12.6986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRtNEkP4QWXxkz7ltCgk/4EY3iYMHnE3sCxgr8uEEDKDsuuryERkzOsItxECQozL7YwAT8yraBq6+cv+avrhMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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

Hi Bruce,

Snipped

> > > > >
> > > > > Hi Bruce, we have reviewed this internally and tested the same.
> > > > > We would like
> > > > your thought for the following.
> > > > >
> > > > > - Before patch: we were directly setting AVX512 falgs for F, BW,
> > > > > DQ, VL
> > > > > - new patch: we are setting the flags for `skylake-server` as bar=
e minimal.
> > > > > - AMD supports AVX512 from `znver4 and higher`.
> > > > >
> > > > > As per GCC
> > > > > `https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html`, the extra
> > > > > ISA
> > > > supported between skylake-server (super set) and znver4 and znver5
> > > > are `SAHF, FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`.
> > > > > Currently for DPDK microbenchmarks and examples runs safe as it
> > > > > is not using
> > > > the `SAHF, FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`
> > > > instructions.
> > > > >
> > > > > Question: should we check if target is `AMD EPYC` then apply
> > > > > bare minimum as
> > > > `-march=3Dznver4`, thus avoid possible unsupported instruction
> > > > generation when non `c_args for march` is passed?
> > > > >
> > > >
> > > > Can you clarify why you mean by the "target" here? Is there a
> > > > specific value you are thinking of for the "cpu_instruction_set" op=
tion?
> > >
> > > `Target` is target CPU, when generated without any arguments we get c=
ode for
> `native build`.
> > >
> > > On AMD target cpu zen4 or zen5; Before patch as per the code ` AVX512=
 flags
> for F, BW, DQ` are used in ` cc_avx512_flags`.
> > >
> > > With the patch, the cc_avx512_flags is set to `-march=3Dskylake-avx51=
2` (where
> compiler optimizations `can add HLE, PREFETCHW, SGX`).
> > >
> >
> > With this patch for zen4 or zen5 the AVX512 code paths should be
> > compiled with no additional flags, since the -march=3Dzen* flag should
> > include everything necessary. Can you confirm that you see the extra
> > -march flag in those cases?
> >
>
> Ran a quick test myself, this is what I see, doing a zen4 build:
>
>    $ meson setup -Dcpu_instruction_set=3Dznver4 build-zen4
>    The Meson build system
>    Version: 1.7.0
>    Source dir: /home/bruce/dpdk-github
>    Build dir: /home/bruce/dpdk-github/build-zen4
>    ...
>    Fetching value of define "__AVX512F__" : 1
>    Message: Extra C flags needed for AVX2 output: []
>    Message: Extra C flags needed for AVX512 output: []
>    ...
>
> Checking the build.ninja file in the build-zen4 directory, there is no us=
e of
> march=3Dskylake. Here is the compilation recipe for i40e AVX-512 code, fo=
r
> example:
>
> build
> drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_avx51=
2.c.o:
> c_COMPILER ../drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
>  DEPFILE =3D
> drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_avx51=
2.c.o.d
>  DEPFILE_UNQUOTED =3D
> drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_avx51=
2.c.o.d
>  ARGS =3D -Idrivers/librte_net_i40e_avx512_lib.a.p -Idrivers -I../drivers=
 -
> Idrivers/net/intel/i40e -I../drivers/net/intel/i40e -Idrivers/net/intel/i=
40e/base -
> I../drivers/net/intel/i40e/base -Ilib/ethdev -I../lib/ethdev -Ilib/eal/co=
mmon -
> I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../l=
ib/eal/include -
> Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include -=
I../lib/eal/x86/include
> -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Il=
ib/log -I../lib/log -
> Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/ne=
t -I../lib/net -Ilib/mbuf -
> I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ili=
b/meter -I../lib/meter -
> Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pc=
i -I../lib/pci -
> Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/hash -I../lib/hash -Ilib/rc=
u -I../lib/rcu -
> I/usr/include/x86_64-linux-gnu -fdiagnostics-color=3Dalways -
> D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -std=3Dc11 -O3 -inclu=
de
> rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral =
-
> Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-ext=
erns
> -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes=
 -Wundef
> -Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initializers -
> D_GNU_SOURCE -fPIC -march=3Dznver4 -mrtm -DALLOW_EXPERIMENTAL_API
> -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-
> member -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.i40e -
> DCC_AVX512_SUPPORT

I have retried the patch and tested the same on 2 scenarios

1. Scenario-1: znver4 (avx512) with gcc 13.2
2. Scenario-2: znver3 (no avx512) with gcc 13.2

For scenario-2 where CPU is not supporting avx512 but compiler supports avx=
512 I get the logs as

```
Fetching value of define "__AVX512F__" :
Message: found AVX512
Message: ['-march=3Dskylake-avx512']
Compiler for C supports arguments -Wno-overriding-option: NO
Message: Extra C flags needed for AVX2 output: []
Message: Extra C flags needed for AVX512 output: ['-march=3Dskylake-avx512'=
]


Message: AVX 512 flag in drivers
Message: ['-march=3Dskylake-avx512']
Message: ['-march=3Dnative', '-mrtm', '-DALLOW_EXPERIMENTAL_API', '-DALLOW_=
INTERNAL_API', '-Wno-format-truncation', '-Wno-address-of-packed-member', '=
-DDLB2_BYPASS_FENCE_ON_PP=3D0', '-DDLB_HW_CREDITS_CHECKS=3D1', '-DDLB_SW_CR=
EDITS_CHECKS=3D1', '-DDLB_TYPE_CHECK=3D1', '-DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd=
.event.dlb2', '-DCC_AVX512_SUPPORT']
```

The above is correct as per my understanding as the test is to compile for =
avx512 ISA.
But When using `ninja -C build -v` and building for native build, I get

```
[1741/3539] cc -Idrivers/librte_net_i40e_avx512_lib.a.p -Idrivers -I../driv=
ers -Idrivers/net/intel/i40e -I../drivers/net/intel/i40e -Idrivers/net/inte=
l/i40e/base
-I../drivers/net/intel/i40e/base -Ilib/ethdev -I../lib/ethdev -Ilib/eal/com=
mon -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include
-I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -Il=
ib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal
-I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metr=
ics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net
-I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/=
ring -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../driver=
s/bus/pci
-I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../d=
rivers/bus/vdev -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -fdiagnosti=
cs-color=3Dalways
-D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -std=3Dc11 -O3 -includ=
e rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral =
-Wformat-security
-Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-de=
finition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite=
-strings
-Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC=
 -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-f=
ormat-truncation
-Wno-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.i40e -DCC=
_AVX512_SUPPORT -march=3Dskylake-avx512 -MD
-MQ drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_avx=
512.c.o -MF drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx=
_vec_avx512.c.o.d
-o drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_avx5=
12.c.o -c ../drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
```

In above log I get `2 instances of march`; logs `-march=3Dnative -mrtm -DAL=
LOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
-Wno-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.i40e -DCC=
_AVX512_SUPPORT -march=3Dskylake-avx512`.

Question-1: I think this is not expected right? The `-march=3Dnative` is po=
pulated from `cflags` and `-march=3D skylake-avx512` is populated from ` cc=
_avx512_flags`.
Question-2: if the target is meet minimal ISA why not we use `-march=3Dx86-=
64-v4`?

Note: I am yet to check for cross build. Will update on cross build how thi=
s comes out.



>
> Regards,
> /Bruce
