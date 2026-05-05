Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85A2FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 09:19:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D25664060B;
	Tue,  5 May 2026 11:19:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 895AC40272
 for <dev@dpdk.org>; Tue,  5 May 2026 11:19:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777972742; x=1809508742;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=NLQflCzJmWStz+hZaAF1JFxnEoMRC3s6xv7TpPuR6Ys=;
 b=XasUS3JFe41h3pxBEauxepZJhtn9/4Vy6gjyY5P04sIGdlluDcNpMbfR
 R8EE4o/StjPLxesM104ev84bfnyXoLiayq86EcC03YzT79JlGFwZfGHqp
 mO1jmrpOlHz/izjntmRNFxUOSmKPeaHts2TuFqQJAgFXO0dmeRzOzBn7N
 gm9vbY4UIzdLO1LInIaXhD9ezPU7808Lk++SS02kQrpxSC72KaChUd3LO
 Yjju0cNi9iW2yyUpKZ0KwDlOLUykvongzMKD/FKTKNIWOVHixvn3fl+rD
 J71LvRfg8KZyTi8O84kHGd7L/epYQDrwmrlNS5Kw6Hg2bIziu2mBg/VXf g==;
X-CSE-ConnectionGUID: t/gH/GSZQli3qhMXN2EsRw==
X-CSE-MsgGUID: /xDdzIKAStqWUAMN89/Brw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82690601"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="82690601"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 02:18:57 -0700
X-CSE-ConnectionGUID: /ck+OvqZSOKVnbNYmGkdnw==
X-CSE-MsgGUID: hjUuFo4wTWWxZNOvx75rbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="266104908"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 02:18:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 02:18:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 02:18:56 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 02:18:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq9SOteoKJkBRLxd6YX2DftHm/OT0cseFauz1Vn1jp7rqT/lvkuaZVyluFZNEybmGH3s1J7U7but5QsJfp4b0QjuinI06Dy5sXnrN4T/qG2AvIv8i/4m6saXwszhtgOTumQbvm8Ei9hAMFGZgz38bDTJtr3HdBREFLnUgjfdkdVgcVrqOwx4FEZeDdr34xppA3e3Rw6bMVBFpXn6AAgWwu2eCXuVoZ0zwuEYYDOAOnjpT5Yn8DaU5FRfpnYFp8A9xLv5s/HbL67JM0NEU5RjmoCY26xn8M8W4GiKhhkFMbZTIxvTPz3kaPdtVe5mmsNolkijJ4Tz5obx32+fry14uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOBz4tT4pchY/GIki488z7gGoOU1MFaaUbkHBbU/ZeY=;
 b=M6GygBgGNbrh+c9NA19K/y/NxpEC/cyQrKfzV1JXDdNu/G/gl+1MtKz/p0uTIX3mIzM8/+ne/5uFvYSwvFi0sF70at8TApotiGVRmv+bye6pRPVWU5DuTSpLusYuXjp1HYYOwqVJBgz2uolLxa73Fp/mMHIMne4omu5aCeSFXypXYkJetikCstyHlgYud9kDRy3WuE7IqYGaV4W5r4STXRxppslbXF184w80AGPr1uPFfgp61Ry38CjFB2+/prbdxM3ZS0I7LKsenO9eJTJt0Tuc8uIg/rvJTnps5qpHQZoMs+rc7UYTuQJXfp7qenC4CVgPfgDAFcbAFmdsSaMycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by DS4PPFC60125F65.namprd11.prod.outlook.com (2603:10b6:f:fc02::4b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 09:18:52 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:18:52 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v4] net/iavf: add support for QinQ strip
Thread-Topic: [PATCH v4] net/iavf: add support for QinQ strip
Thread-Index: AQHcyApDTmBZaJXC3UeYbL0DtgLcg7X/T9hg
Date: Tue, 5 May 2026 09:18:52 +0000
Message-ID: <CY5PR11MB6116B7E9FFFAB3A5A253A55EE43E2@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260216103710.195777-1-anurag.mandal@intel.com>
 <20260409101951.114492-1-anurag.mandal@intel.com>
In-Reply-To: <20260409101951.114492-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|DS4PPFC60125F65:EE_
x-ms-office365-filtering-correlation-id: 232bd77e-e51d-45bf-5ec1-08deaa875344
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: WchBh0ntBvyCxXsxygbbbRNuAYl37FbdqbwNcUua/UXOrFgCeV/LQ/OSeKL2nAKfNi0F2DDYupyHJpnh4r5mjoEIzPNGSD6Rc2nsY6ANuC0/mwgs1iZ/T6DPbwpM9VTI1O6PXw1N2yNS17CKVeU20FfLx9oAsTNmu1zJri9v8QiOL3i2hOfEmvbC/2ig8DIA5SZA6AdpKIIKRVVLBWN4fKu/bu0Kexfb8mvX9EO7B6rarc5PbVXKfUDzszqjS6wvNSEEp+dINLo3oKq9LxwdHjouKlxOM9GadyG1rzEqNQbgxtSu5KDqqUihn99HLfxic02Sobcqjn0RQilcgPThMl0bRH9xslZ/2SNx5ahJXc7IMMdBEsPraJW6W26n2shjB8t23pg0sH09LXn0QeRBW/BKVvllpTBdu1norfYSVphl4fMD/nDZVzrE+peEgH3KTHCFXFZ9f5xyTnpQtAwTg31frcx6HlAFouTyGI2xzkT7wimeOVQ8j+4TJ5AYz4LPzD2NMsyvuuYvMhj0/akRacifT/FYMDTtEPHPaVfmf+xsbIk52eeVKLA6l4JXeUpp41vIqdyaOsn/0b5r8PSpMfZDEcCuAmS+Cb14TF2WiABxyYsziRr0+6JzGtXFvGq58oePNOwdn/mACsklf2gp843eh6eqk8URAzXz1BafpISzoSlR0eyPiC/m6Br5had6BlJkRVBM3hJHv5NOHyn0477jnfS6LbYuUx8D1vWhiZNFMt/uzf+AJYXDmRmp2p2d
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5BPLCvyf02E1Cn0LAQj7a/sJwlN8wF5ZruKABLiRhEX7zZw1A3z//v1AVOk1?=
 =?us-ascii?Q?55uFY8CAmodMQAEUKOwk3uF+N+mlzx8miU3aP1lpqk81WWO3OyjIiN25A92z?=
 =?us-ascii?Q?IriPX2TlxLiRCLTGZwO+R003ATvieNBzrq0ZgvmvDbS4aNmp1rP8QlymbE0g?=
 =?us-ascii?Q?ROXjZKqr0bt1U/zzYpIPdVlQhHPIfJT1bYVmxYE8JTruiNlYVAWpLT/kQopP?=
 =?us-ascii?Q?oIsQ/K56L0v1xda8yJZaYNifxlPDT7TcTzLj3Cl39nElIYJ+g92rEjIDJVer?=
 =?us-ascii?Q?g9E+I8ptilCe39cyOhoOjCSkHGxk/HiFTKyyVmSW0ICgjmm1Q7Ts5k66foTP?=
 =?us-ascii?Q?IUhw+NTWSqhQHQoqRS2JNr2YKQNMNWMmHsu0FPEnhOPQw7jw5HYksP0dW7Os?=
 =?us-ascii?Q?nQSEl/CcgEO/ZNd62lSE+Pm+EzPWQu4CL+qDb+ZRbh5GTPHcPsvasMgjghTI?=
 =?us-ascii?Q?St3aZ0MFc8jd5xx0VTTk5MLF9+J2UoIWCvpqt/Iudf52sshpjAcq51tXGhBR?=
 =?us-ascii?Q?gg+XPCKrnGO+EGU5fHkrc27e7Bq94mZjr0jiHyj2hFH8m6Ai3JVbBEqCqGk1?=
 =?us-ascii?Q?kUQgzsMsusro5qaDiO+VMV0zaVmFf2XZw/022tcfd9bufy0yzHFCEyIvIUSQ?=
 =?us-ascii?Q?QhjbpKJrMFXggZ2WIHE+jl/Mk7fTG47dnNVgQQDXslx4d1455yucHsws5HH3?=
 =?us-ascii?Q?c4tfmSJQe3cOP6vthTpVQGDy68NZKFgX11QSjW8oBbQixNoz9iuifPkAs3gu?=
 =?us-ascii?Q?A3P6926+vPSHSNcO9xefa2sqOo7ix7hsOBflesR/jO478O6tZ3Gtyrz57QaY?=
 =?us-ascii?Q?j3aGBAc7I0gX4V9VRkzGwiFVUeWJ8zx3w7b+NqlkQjNFggewEiVcb7dWNuxk?=
 =?us-ascii?Q?+RvmIrcSdHlB+LNKAHbBJ0/BoKx00deW/J+B0cVZFu1m9gIDns6JXUDOBr6Q?=
 =?us-ascii?Q?kh5jpJ1MW9Gt4d4NBfGEBmsXYguBaWyEA7iIBYDIpDIcV1VrzIZ8Hb+vDGXk?=
 =?us-ascii?Q?wgoEUDBzZ1p3Op0HGQpVMd1ixyT6adUmG/9WA88qSF5RZ99tmsSIBcQdU/Hx?=
 =?us-ascii?Q?pyCjggl7J0q54jLY0GacTL3UGpSeF7gzZzOFQ7KKY/KEefNjQ5F3E/gVL0EQ?=
 =?us-ascii?Q?eSMW/EmQY4WrfrjCTkAQ7rSXS20wjmh8k+/ja9pXXz7ecDpXkkDoGu8KZTwN?=
 =?us-ascii?Q?S0c7wAjSDL6od7mLfpzdDQRR8s9/bO49iy+eqwZu0aNFQ2BrOVofmoMMOt/n?=
 =?us-ascii?Q?GFoE4ImNewbhMmp6xCMpWqi7JdCHYinidrAT7UQJ4LaA3+ph+pC3WaAbpvui?=
 =?us-ascii?Q?l4hEelVbDn/pDqmOwi6/ZYfY4xv7BYvW4ZewfyRpTGVu3iNCVIyPHMpLkJeA?=
 =?us-ascii?Q?4VHKXF/M8fmkL/IJphqlxMBj0aOJ3prj1nz6KsXoMnyWiYOho2P8XkebLrSi?=
 =?us-ascii?Q?9tGcJ+IJQkH8K2lfPLdDoE570725lee6dmAvld/QiwmwMgGIx7JvLetcNKBz?=
 =?us-ascii?Q?GA2OS/NdkM86fS2YK964uh5CAs8xqToWBLrvrBpH28yp8Gu0ZLxnsW2uyjRx?=
 =?us-ascii?Q?3HBNx0ObuCL3deHaKhniU/rqMgAIgPLXb7se3tZn636OLL6oMAZiRjbz0BDk?=
 =?us-ascii?Q?M6pzSoM77rbxdXNBOET6+0YPMLDobg5Kz7tGlMFppcDxj1v0XQV0kddOlkdU?=
 =?us-ascii?Q?wjqoli+BGNSmj4uZEY+xHpCgw1WSMY05O0DACQfmv4uBpTc34yyuiUldbyqG?=
 =?us-ascii?Q?kIVE9PccPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QjWum+t4QELf4IOOx3fLE+226vsRaKeQos+gnRmo2QP6pQ8hCzpAYZunugA50Do3pjuv7v4CnCeVD+GJgCfiScb4zPswVupB/Pit4Gx4cFqj2c4qKCwduAdiRvGyeepEO1UcicZVokCCiW4iMUsr2LL3JrwFBqgd9POcv+f3D6nGU01qshXm7066cDYvndoo8T8zGNVqiIRLISPyO1wA8EPpl3h7AuKn0X+/bRYCzQJH6QBxB1P6A3XZz/jMgS6LUCj2vagC2yMKVclHePjrNV15jLjynU70dtdguegx69CNFOe0G9t1mZzXhopC6++mt9owEIuKUe8idTPL5cdk4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232bd77e-e51d-45bf-5ec1-08deaa875344
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 09:18:52.7275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBt7JTonezo8BTrDiZ/iYRpX2DinD4i3dfXjf3ztJEsYpoYnv/uVqxYO6gQCzH3F0L2JtiU/hd62s/ZOjB6CXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC60125F65
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

Hi All,

Gentle reminder for review & ack.

Thank you.

Regards,
Anurag M

> -----Original Message-----
> From: Mandal, Anurag <anurag.mandal@intel.com>
> Sent: 09 April 2026 15:50
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Mandal, Anurag
> <anurag.mandal@intel.com>
> Subject: [PATCH v4] net/iavf: add support for QinQ strip
>=20
> QinQ strip with VLAN TPID 0x88a8 & 0x8100 support was absent.
>=20
> This patch adds support for QinQ strip with both Outer VLAN TPIDs 0x88a8
> (802.1ad) & 0x8100 (802.1Q).
> VLAN Extend should be enabled for the same and Outer VLAN TPID should be
> set properly.
>=20
> 1. Tested QinQ stripping with TPIDs 0x88a8 as well as 0x8100.
> 2. Tested Double VLAN stripping i.e. QinQ (802.1ad/802.1Q) &
>    VLAN (802.1Q) stripping simultaneously.
> 3. Tested Single VLAN (802.1Q) stripping.
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V4: Addressed ai-code-review suggestions
> V3: Rebased onto next-net-intel-for-next-net
> V2: Addressed Coding Style Warnings
>=20
>  doc/guides/nics/intel_vf.rst         | 31 ++++++++++++++
>  drivers/net/intel/iavf/iavf.h        |  2 +
>  drivers/net/intel/iavf/iavf_ethdev.c | 50 +++++++++++++++++++++++
> drivers/net/intel/iavf/iavf_vchnl.c  | 61 ++++++++++++++++++++++++++--
>  4 files changed, 141 insertions(+), 3 deletions(-)
>=20
> diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst =
index
> 5fa2ddc9ea..dfff69b982 100644
> --- a/doc/guides/nics/intel_vf.rst
> +++ b/doc/guides/nics/intel_vf.rst
> @@ -771,3 +771,34 @@ the VLAN header tag length will be automatically
> added to MTU when configuring q  As a consequence, when attempting to
> configure a VF port with MTU that,  together with a VLAN tag header, exce=
eds
> maximum supported MTU,  port configuration will fail if kernel driver has
> configured VLAN filtering on that VF.
> +
> +QinQ strip
> +~~~~~~~~~~
> +
> +QinQ TPID is set as 0x8100 IEEE 802.1Q by default.
> +For QinQ strip with TPID 0x88A8 IEEE 802.1ad, extend VLAN is enabled
> +and VLAN outer TPID is set to 0x88A8.
> +VLAN filter steps can be added before or after.
> +
> +To start ``testpmd``, and enable QinQ strip for TPID 0x88A8 on port 0:
> +
> +.. code-block:: console
> +
> +   ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --forward-mode=3Dmac
> +   ...
> +
> +   testpmd> vlan set extend on 0
> +   testpmd> vlan set outer tpid 0x88A8 0
> +   testpmd> vlan set qinq_strip on 0
> +
> +For QinQ strip with TPID 0x8100, extend VLAN is enabled only.
> +
> +To start ``testpmd``, and enable QinQ strip for default TPID on port 0:
> +
> +.. code-block:: console
> +
> +   ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --forward-mode=3Dmac
> +   ...
> +
> +   testpmd> vlan set extend on 0
> +   testpmd> vlan set qinq_strip on 0
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.=
h index
> f8008d0fda..6a77dacf59 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -387,6 +387,7 @@ struct iavf_adapter {
>  	uint16_t fdir_ref_cnt;
>  	struct iavf_devargs devargs;
>  	bool mac_primary_set;
> +	uint16_t tpid;  /* VLAN tag identifier */
>  };
>=20
>  /* IAVF_DEV_PRIVATE_TO */
> @@ -456,6 +457,7 @@ int iavf_configure_rss_key(struct iavf_adapter
> *adapter);  int iavf_configure_queues(struct iavf_adapter *adapter, uint1=
6_t
> num_queue_pairs);  int iavf_get_supported_rxdid(struct iavf_adapter
> *adapter);  int iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, b=
ool
> enable);
> +int iavf_config_outer_vlan_strip_v2(struct iavf_adapter *adapter, bool
> +enable);
>  int iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable=
);  int
> iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid,
>  			 bool add);
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index 3126d9b644..5da2cd43c2 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -127,6 +127,8 @@ static int iavf_dev_add_mac_addr(struct rte_eth_dev
> *dev,  static void iavf_dev_del_mac_addr(struct rte_eth_dev *dev, uint32_=
t
> index);  static int iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
>  				   uint16_t vlan_id, int on);
> +static int iavf_vlan_tpid_set(struct rte_eth_dev *dev,
> +			     enum rte_vlan_type vlan_type, uint16_t tpid);
>  static int iavf_dev_vlan_offload_set(struct rte_eth_dev *dev, int mask);=
  static
> int iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
>  				   struct rte_eth_rss_reta_entry64 *reta_conf,
> @@ -226,6 +228,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops =3D =
{
>  	.mac_addr_remove            =3D iavf_dev_del_mac_addr,
>  	.set_mc_addr_list			=3D iavf_set_mc_addr_list,
>  	.vlan_filter_set            =3D iavf_dev_vlan_filter_set,
> +	.vlan_tpid_set              =3D iavf_vlan_tpid_set,
>  	.vlan_offload_set           =3D iavf_dev_vlan_offload_set,
>  	.rx_queue_start             =3D iavf_dev_rx_queue_start,
>  	.rx_queue_stop              =3D iavf_dev_rx_queue_stop,
> @@ -1365,6 +1368,36 @@ iavf_dev_del_mac_addr(struct rte_eth_dev *dev,
> uint32_t index)
>  	vf->mac_num--;
>  }
>=20
> +static int
> +iavf_vlan_tpid_set(struct rte_eth_dev *dev, enum rte_vlan_type
> +vlan_type, uint16_t tpid) {
> +	struct iavf_adapter *adapter =3D
> +		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	struct rte_eth_conf *dev_conf =3D &dev->data->dev_conf;
> +	int qinq =3D dev_conf->rxmode.offloads &
> RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
> +
> +	if (vlan_type !=3D RTE_ETH_VLAN_TYPE_OUTER) {
> +		PMD_DRV_LOG(ERR, "Unsupported vlan type.");
> +		return -EINVAL;
> +	} else if (!qinq) {
> +		PMD_DRV_LOG(ERR, "VLAN-extend disabled.");
> +		return -ENOSYS;
> +	} else if (tpid !=3D RTE_ETHER_TYPE_VLAN &&
> +		   tpid !=3D RTE_ETHER_TYPE_QINQ) {
> +		PMD_DRV_LOG(ERR, "tpid supported 0x8100/0x88A8");
> +		return -ENOTSUP;
> +	}
> +
> +	/* This API only fills internal iavf_adapter structure
> +	 * and does not send any signal to hardware.
> +	 * Inner VLAN always 0x8100, so not set explicitly.
> +	 */
> +	if (qinq && vlan_type =3D=3D RTE_ETH_VLAN_TYPE_OUTER)
> +		adapter->tpid =3D tpid; /* Outer VLAN can be 0x88a8 or 0x8100
> */
> +
> +	return 0;
> +}
> +
>  static int
>  iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)  { @@ -1453,=
6
> +1486,8 @@ iavf_dev_vlan_offload_set_v2(struct rte_eth_dev *dev, int mask=
)
>  	struct iavf_adapter *adapter =3D
>  		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	bool enable;
> +	int qinq =3D dev->data->dev_conf.rxmode.offloads &
> +		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
>  	int err;
>=20
>  	if (mask & RTE_ETH_VLAN_FILTER_MASK) { @@ -1472,6 +1507,20 @@
> iavf_dev_vlan_offload_set_v2(struct rte_eth_dev *dev, int mask)
>  			return -EIO;
>  	}
>=20
> +	if (mask & RTE_ETH_QINQ_STRIP_MASK) {
> +		if (!qinq) {
> +			PMD_DRV_LOG(ERR, "VLAN-extend disabled");
> +			return -ENOSYS;
> +		}
> +		enable =3D !!(rxmode->offloads &
> RTE_ETH_RX_OFFLOAD_QINQ_STRIP);
> +		err =3D iavf_config_outer_vlan_strip_v2(adapter, enable);
> +		/* If not support, the stripping is already disabled by PF */
> +		if (err =3D=3D -ENOTSUP && !enable)
> +			err =3D 0;
> +		if (err)
> +			return -EIO;
> +	}
> +
>  	return 0;
>  }
>=20
> @@ -2812,6 +2861,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>  	adapter->dev_data =3D eth_dev->data;
>  	adapter->stopped =3D 1;
>  	adapter->mac_primary_set =3D false;
> +	adapter->tpid =3D RTE_ETHER_TYPE_VLAN; /* VLAN TPID set to 0x8100
> by
> +default */
>=20
>  	if (iavf_dev_event_handler_init())
>  		goto init_vf_err;
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index 23d115298c..c2f340db81 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -829,6 +829,50 @@ iavf_get_supported_rxdid(struct iavf_adapter
> *adapter)
>  	return 0;
>  }
>=20
> +int
> +iavf_config_outer_vlan_strip_v2(struct iavf_adapter *adapter, bool
> +enable) {
> +	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
> +	struct virtchnl_vlan_supported_caps *stripping_caps;
> +	struct virtchnl_vlan_setting vlan_strip;
> +	uint8_t msg_buf[IAVF_AQ_BUF_SZ] =3D {0};
> +	struct iavf_cmd_info args;
> +	uint32_t *ethertype;
> +	int ret;
> +
> +	memset(&vlan_strip, 0, sizeof(vlan_strip));
> +	stripping_caps =3D &vf->vlan_v2_caps.offloads.stripping_support;
> +	if ((stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_88A8) &&
> +	    (stripping_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> +	    adapter->tpid =3D=3D RTE_ETHER_TYPE_QINQ) {
> +		ethertype =3D &vlan_strip.outer_ethertype_setting;
> +		*ethertype =3D VIRTCHNL_VLAN_ETHERTYPE_88A8;
> +	} else if ((stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100)
> &&
> +		   (stripping_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> +		   adapter->tpid =3D=3D RTE_ETHER_TYPE_VLAN) {
> +		ethertype =3D &vlan_strip.outer_ethertype_setting;
> +		*ethertype =3D VIRTCHNL_VLAN_ETHERTYPE_8100;
> +	} else {
> +		return -ENOTSUP;
> +	}
> +
> +	vlan_strip.vport_id =3D vf->vsi_res->vsi_id;
> +
> +	args.ops =3D enable ? VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2 :
> +			    VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2;
> +	args.in_args =3D (uint8_t *)&vlan_strip;
> +	args.in_args_size =3D sizeof(vlan_strip);
> +	args.out_buffer =3D msg_buf;
> +	args.out_size =3D IAVF_AQ_BUF_SZ;
> +	ret =3D iavf_execute_vf_cmd_safe(adapter, &args);
> +	if (ret)
> +		PMD_DRV_LOG(ERR, "fail to execute command %s",
> +			    enable ?
> "VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2" :
> +
> "VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2");
> +
> +	return ret;
> +}
> +
>  int
>  iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)  { =
@@ -
> 838,14 +882,20 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter,
> bool enable)
>  	uint8_t msg_buf[IAVF_AQ_BUF_SZ] =3D {0};
>  	struct iavf_cmd_info args;
>  	uint32_t *ethertype;
> +	int qinq =3D adapter->dev_data->dev_conf.rxmode.offloads &
> +		   RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
>  	int ret;
>=20
>  	stripping_caps =3D &vf->vlan_v2_caps.offloads.stripping_support;
>=20
> -	if ((stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> +	/* When VLAN extend is disabled, Single VLAN mode which is Outer
> VLAN
> +	 * When VLAN extend is enabled, QinQ mode, this API works only on
> +	 * Inner VLAN strip which is always 0x8100.
> +	 */
> +	if (!qinq && (stripping_caps->outer &
> VIRTCHNL_VLAN_ETHERTYPE_8100) &&
>  	    (stripping_caps->outer & VIRTCHNL_VLAN_TOGGLE))
>  		ethertype =3D &vlan_strip.outer_ethertype_setting;
> -	else if ((stripping_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100)
> &&
> +	else if (qinq && (stripping_caps->inner &
> +VIRTCHNL_VLAN_ETHERTYPE_8100) &&
>  		 (stripping_caps->inner & VIRTCHNL_VLAN_TOGGLE))
>  		ethertype =3D &vlan_strip.inner_ethertype_setting;
>  	else
> @@ -921,6 +971,8 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter,
> uint16_t vlanid, bool add)
>  	struct virtchnl_vlan *vlan_setting;
>  	struct iavf_cmd_info args;
>  	uint32_t filtering_caps;
> +	int qinq =3D adapter->dev_data->dev_conf.rxmode.offloads &
> +		   RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
>  	int err;
>=20
>  	supported_caps =3D &vf->vlan_v2_caps.filtering.filtering_support;
> @@ -938,7 +990,10 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter,
> uint16_t vlanid, bool add)
>  	memset(&vlan_filter, 0, sizeof(vlan_filter));
>  	vlan_filter.vport_id =3D vf->vsi_res->vsi_id;
>  	vlan_filter.num_elements =3D 1;
> -	vlan_setting->tpid =3D RTE_ETHER_TYPE_VLAN;
> +	if (qinq && adapter->tpid =3D=3D RTE_ETHER_TYPE_QINQ)
> +		vlan_setting->tpid =3D RTE_ETHER_TYPE_QINQ;
> +	else
> +		vlan_setting->tpid =3D RTE_ETHER_TYPE_VLAN;
>  	vlan_setting->tci =3D vlanid;
>=20
>  	args.ops =3D add ? VIRTCHNL_OP_ADD_VLAN_V2 :
> VIRTCHNL_OP_DEL_VLAN_V2;
> --
> 2.34.1

