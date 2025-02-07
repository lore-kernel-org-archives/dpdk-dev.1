Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBCBC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:55:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15F7242DDC;
	Fri,  7 Feb 2025 15:55:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id D1CE042DC1
 for <dev@dpdk.org>; Fri,  7 Feb 2025 15:55:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738940117; x=1770476117;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MtHVq1d2bdZV/f90Tg27LWRzFIo8tk+nKnhgIikr/uI=;
 b=LzCWmPcIvaOC5kn3IT9Cd/n2SWGfYuBQUr2e7noEC/x/jhaxIkgB7A3o
 q5/PEW+A/Z0brBlfX0IdrGT1qVQ6Bu4BE/FiAXY50W19040qKZD3p2wh1
 03dEmX0T2pobBJysP1kzey9pd5/O/ySGbrYfbqt3KHw8wZqglWaURNysh
 Qjr4sZMmzwWwHi/cdEmTu0cyo+9GT9D2agC6yg51hR6GFdHnH+4G6uNGS
 EOAUr+dyt4JJ0NbXyJJxXTrho6qpxhwIk/FIHS7k+iiPvILdXhF6ms46x
 tv4Hp2/FOHmW4XwYoKMrT86/LadgCcQNfczxI0uNekXfE1GRQJlCsAf/5 Q==;
X-CSE-ConnectionGUID: Ozgq8BZMShGTgJVC+wkpIA==
X-CSE-MsgGUID: 2V2tdwscQ8+NbWUXlIhxww==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="43343185"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43343185"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 06:55:15 -0800
X-CSE-ConnectionGUID: F7+PXlZ0QLq5D067eRTNRg==
X-CSE-MsgGUID: x1NLeEjzTnGYV9dU77tiUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="111369938"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 06:55:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 06:55:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 06:55:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 06:55:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQWj9kHGyNS3qC49J8PvcO3SluZnqhA3SxMh0q/Ftb7C2z14SDc34zCToIMkW/Aipdukva6hFu91IdgLDelpA2sVSfE213fTbSugDjkXJve4bjuLhib29jwP8f02dDloUSFgP8hZ28Yp7xZUw47s+XOFLI0aZbVRZwg4APwg6UEogb+Obd/5YxQQaIuM10+h1Zsq/pAYnQBr5vht4QuFAnN5RszjyMimPeAP1ut4pSt9H2nF4slUEHYiHp5Kl2ZKoT220m0ZZ5hjEPVNBWufAePAKOKoUnWAO4Xdy1ULdWtmzgvRqFHceWTNQOgS18HxMIGNNg1pyWwLP4hUCFhfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPGTTXwbSVEPKBPcNGIQDbQ6hwx8503A0Es9ryCvsbg=;
 b=Z/bI56264ANCVMbzPS2bF/vMRt4OIkKJNyPYLRndTyb5pL7a3F2Qz4XcsuiHY8uqHck23qK1JyeN3I1VSe0dKNtroOEvPSmqM9Ehe5KiZy4+fEr7kPk80rJeT1Y7EOzaWX567CWZcfTeWiPa5yjg2Nhll2c6k7cMkZPw4qaEk5ByZUoYwtIf29fZVbVYz5riAmlp21EnviU2KfDiyX1bPMze1nAqu5fyBQQSh01e6zc6VVPGOsItjJh6KHk0DE3oDiWzmJG4a24UmOw60vtoFPQmca7lAeVpWD3Yhcd2B9xf8u88qXhUWHhexfCnoYl304Q7ymrgSzz2SFr124Q49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5918.namprd11.prod.outlook.com (2603:10b6:a03:42c::22)
 by IA1PR11MB8861.namprd11.prod.outlook.com (2603:10b6:208:59a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 14:55:10 +0000
Received: from SJ0PR11MB5918.namprd11.prod.outlook.com
 ([fe80::891b:9bb3:428a:c72a]) by SJ0PR11MB5918.namprd11.prod.outlook.com
 ([fe80::891b:9bb3:428a:c72a%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 14:55:09 +0000
From: "Wani, Shaiq" <shaiq.wani@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>
Subject: RE: [PATCH v5 2/2] common/idpf: enable AVX2 for single queue Tx
Thread-Topic: [PATCH v5 2/2] common/idpf: enable AVX2 for single queue Tx
Thread-Index: AQHbdg84v7ELJsnQC06rPRxJhnSI3LM7xGCAgAAvUVA=
Date: Fri, 7 Feb 2025 14:55:09 +0000
Message-ID: <SJ0PR11MB59189C232D90074099052A3A92F12@SJ0PR11MB5918.namprd11.prod.outlook.com>
References: <20250203052430.1243485-2-shaiq.wani@intel.com>
 <20250203075508.1304702-1-shaiq.wani@intel.com>
 <20250203075508.1304702-3-shaiq.wani@intel.com>
 <Z6X2e4hD7FQN94ax@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z6X2e4hD7FQN94ax@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5918:EE_|IA1PR11MB8861:EE_
x-ms-office365-filtering-correlation-id: c5a88357-e4e0-4cbe-da77-08dd47876b08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fN2g23t4kuswTpgpEuLJTLo1fSr0eMH0szvS7R6tTs8PnzEG+TJpc3qde81E?=
 =?us-ascii?Q?SnWDr0eRLySLGKoD5IUzYVAcXqY69vhnkADCsiZFcU4vkbmYFeIF/Ny2VvZY?=
 =?us-ascii?Q?QFb9eMRRviPkg7qiTiOZBLeFY6Akcy1xwykZLf3upFv+UVn/gFlmpzOi+T/c?=
 =?us-ascii?Q?emY8bi8R89VtGE+md+B8ibVreax/es4kXXc6FU8lRxmIyHBeamAKCcXVbb1p?=
 =?us-ascii?Q?V/Zc+IirHgzrARz40L8JIZuFAUpFWMTEpSqSswL6pe/DjyaBRdwh0LrZEktq?=
 =?us-ascii?Q?Gjzy/vJi7kO/rY2FRC3nWHiKpXZaWyqABN6nLlmlEc3o7c/P/ZPEkACUQzP9?=
 =?us-ascii?Q?yad3kPTyvRP19BFbmGeBc0itbjaq1IeZWUCjt98/6QF79T7S578cuqzYEOI6?=
 =?us-ascii?Q?u7bexCBkMklqPV5VbZymLKy/TimtHLbEk1x2jTWTqjLCZwWTXm11xprNN49b?=
 =?us-ascii?Q?PME+jMBrHkng6MoHqee9yQdFs3WwgHA+ny6mlsp1Xz2vdZ7nohaTzHHMjMXV?=
 =?us-ascii?Q?tFnXpSUpunyS6Cri9COGYUxC/XjQu8Dhyvkx6MXk/n1tkYk1Tdoaimc5X37M?=
 =?us-ascii?Q?DUWbvffJaL2yhf7tI3NEJSa/EWovBrcL+khipRAQARNJEDjcPNCK0yR172FE?=
 =?us-ascii?Q?vpFGVsAtLXAbLjh6OzNaVz1ghDc00COEVgO+50GdQ4o4AwP4cxttEDupjGI8?=
 =?us-ascii?Q?q3x7W/MiRBI6byTSUrhnNLa8I8pkEaTayW5KyEXIVwiuC1EZunHjLEv+VgRL?=
 =?us-ascii?Q?HEwhNZwvLoizkafhACQs74b9m2QkGtUDQmpougV3Dt/Fzdspz+5/cwAChG/b?=
 =?us-ascii?Q?4yeR+Skto1hl6v8BHowfz86ybJFuEt8pVBCKAyMoO5mVRLIv1mVPxfhjMuxl?=
 =?us-ascii?Q?XjlcF6Nhkw84G1yBlK+JzM6Ivle6/2tcXodpLkBRtpIniMDftXBE5aCDqPZ6?=
 =?us-ascii?Q?trImoqPKZbY3jBHi5C46+cU2ztgWTpBS94peWALriOQ2nvGJe4SZdtZbtHF6?=
 =?us-ascii?Q?qtQlEz1Ae5udJ9FZgXjzQEwr6cgFXa9AZZ7BHxIKBX64KbDPmJET7tNIVC33?=
 =?us-ascii?Q?qse482ave+RfURRHdynOZX/gUsqyWV3JLKdDqAOps96FggAG03neb2gUEaUt?=
 =?us-ascii?Q?VJ7VNUYX6NpgdmD/lQ5Ink/B8SvzimvgZm1IAkdh6+cpi5d6120d19FbYXuA?=
 =?us-ascii?Q?3QjszIoYImKJBrqobMJv3GKr/uqYCSIwb1M02VoXx+DB/v4168M9u4zXmqDX?=
 =?us-ascii?Q?bkmKnYsxv38MNeJPO69pIepGwnUjOWiTrR+Ql0LTB7OFCLAcoS58zvWRwGUh?=
 =?us-ascii?Q?uTcFAyzCOY6LFzJDNqdZ9tzpTw8e7R+FG+q8xUIvYH/hEHSVMK5YIkx6NgdS?=
 =?us-ascii?Q?DeQnln6t8vljzjiSaNAY8nJFD+UoNkgyuxzGJjFGFFNL/JAe70SEEcyF1tuy?=
 =?us-ascii?Q?F5mTacfb69n66FV9H5WFBu8OtmlzIbwW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5918.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/rxwPfIdxosWF1V61mAObVp/ZK2CGKBTA41cmglfL1ld6u5NppsAq2lU+tEk?=
 =?us-ascii?Q?XaAvy+9tY3eEsF+f9gzfqAPZSKu7yP6CYwAO6R5OC7guq43kImMoFOdOfONw?=
 =?us-ascii?Q?CR/Msj4qQA+tHxT8B5K1nyxQcUNXsqhba8Cg9wGvIbN+KXF+37EoeKoYVFzJ?=
 =?us-ascii?Q?4oGRfcr82k9SuAiwxuobtl1gea0zej8I89UzudThCHVl0x5qmZB1RdZTAc9D?=
 =?us-ascii?Q?tsY35bhdC+/OBxzotRPyMpr0smTj+O5x4V553pnCHpAmCGzIIlrqf+38TR7G?=
 =?us-ascii?Q?UgmtRgl2xiuuouFpd9zk3CZ1/YzdUXDKnhkZTm5IJ8hKbUat8QMH3MImVPEh?=
 =?us-ascii?Q?s355VSIIWMLgcrA3IW69Btuh307mRDERuBtHTFhUAVIKzEauTKcYSgrj5mqe?=
 =?us-ascii?Q?vlIz55+1VNjyVyt3710soHmsEsEdCfpD/wAtDV0cMCdzqyhGMz023vkMW1wi?=
 =?us-ascii?Q?K+3A9Spbb5MP45YVLM4ModarKmthL3lgoybgWUgvdmWRudggFfsscQuEOoea?=
 =?us-ascii?Q?myopRK0lX4bOq6LwubammoEDAsZZW+AOsRxy+ZXqN0TpYR3EoUPYVI5OrL3f?=
 =?us-ascii?Q?yEB6MVk2Qi20J8EtWTEVCO+s82jZS4JgD8rqrYUQj7h4NSeGEprVvrZ9tJcF?=
 =?us-ascii?Q?UNmxbvyiehQzH9pyjRUCOP9i0axPoDi+OJ3erMOlwJyliiCBnu+Ry2TErVUf?=
 =?us-ascii?Q?u/6OOph6KIvCIDTk8bgOZLO8B0oFWWp7CEn/n7Hj+SkWck6mmFMNWi3Teyau?=
 =?us-ascii?Q?QSTrRWPHjhkZfJMm2nB9jxf3TlZELk7rF2P4myPw7tYT/THmgOeyO0GPWn1V?=
 =?us-ascii?Q?znhsSW0FA6rWpIHlYi7izfi+4vnmDTP1Dq6rpAh76Ke0NyESv4vgvMFB3uNr?=
 =?us-ascii?Q?m9es2JldsLARbtBba7bNm0JpBiVPv5xxo0rWALygqqyiQB83hNHhd2MieErG?=
 =?us-ascii?Q?mi+PjbsQvVEyeq4K5oooeCjvsbVUi67HbNFAMjtC6fld8jq8OWcPxzKoz570?=
 =?us-ascii?Q?uOX1/RT/6WvU6X+e+uDjI9UiEBV0ZmPR1tc9cuEV3lmFSy/snK7yuMIUq87D?=
 =?us-ascii?Q?OR/6p9+C5Qy8NGGyCeehh3laJXFG3U2lF6i7hcGJENxCaneq73xk6Yah6NWi?=
 =?us-ascii?Q?Ry/ka1gNyfjPUkwEPzuMqKzbEa3SLtcxj0O8pYt3/r6V4y6Yxd+gUNWBD5Kt?=
 =?us-ascii?Q?j8dzhVw5o6A7yFcbGrrMk2gaRvx1jVt6V4uLzN4L3cZp3CPwEzdPq5O1rsiu?=
 =?us-ascii?Q?bgzhZLeJDXNEPqOUCEU/G0sGZpdZ/ueb1Z6ogOpVypqThO1z8RVNQljlLuE4?=
 =?us-ascii?Q?giQ2XeyCQ0BIJw6tkBc3Gu4Oaj/cl+yco9pHEIKa++Kcng2psRKJcp3mYZeo?=
 =?us-ascii?Q?TSDrh1Eymk0m5vQEmy1IFHOVkmPWxCr0mp/iS1RkPM/e550aEA/PuR9MtEzS?=
 =?us-ascii?Q?m+IQ5oVOPQrGW9yKyG0l/Hsaj9qzoKHgEq3QB8XbrvNHDERaiA1M2eYu5VU7?=
 =?us-ascii?Q?c7imNrxJvnCtLv8bPCy7vDd2bU0xfaqxoMTQQN0caOe/VEQAWcfLicJN0Z0c?=
 =?us-ascii?Q?SM+Nlhud4RPrX/auIRFkJZULENmhazjK31OXCuuO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5918.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a88357-e4e0-4cbe-da77-08dd47876b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 14:55:09.7784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnHcg92Bv6V0HL4waPPfQWxNKwCkiRhFJfi6d4w22oAJekBdE/I+5keAd9A1akuR6CGFl21koP6Mkq3uClc4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8861
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

Hi,=20

The AVX512 code paths and SSE code paths should be done together, we will l=
ook into it next release.

/Shaiq

-----Original Message-----
From: Richardson, Bruce <bruce.richardson@intel.com>=20
Sent: Friday, February 7, 2025 5:33 PM
To: Wani, Shaiq <shaiq.wani@intel.com>
Cc: dev@dpdk.org; Singh, Aman Deep <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 2/2] common/idpf: enable AVX2 for single queue Tx

On Mon, Feb 03, 2025 at 01:25:08PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to get=20
> better per-core performance.
>=20
> The single queue model processes all packets in order while the split=20
> queue model separates packet data and metadata into different queues=20
> for parallel processing and improved performance.
>=20
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

See feedback inline below. Would it be possible for this release to rework =
the driver to use the common functions from drivers/net/intel/common? If no=
t, can that be looked at for the next release?

/Bruce

> ---
>  doc/guides/nics/idpf.rst                    |   8 +-
>  doc/guides/rel_notes/release_25_03.rst      |   7 +
>  drivers/common/idpf/idpf_common_device.h    |   1 +
>  drivers/common/idpf/idpf_common_rxtx.h      |   4 +
>  drivers/common/idpf/idpf_common_rxtx_avx2.c | 224 ++++++++++++++++++++
>  drivers/common/idpf/version.map             |   1 +
>  drivers/net/intel/idpf/idpf_rxtx.c          |  13 ++
>  7 files changed, 255 insertions(+), 3 deletions(-)
>=20
> diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst index=20
> 0370989a07..90b651d193 100644
> --- a/doc/guides/nics/idpf.rst
> +++ b/doc/guides/nics/idpf.rst
> @@ -93,9 +93,11 @@ The paths are chosen based on 2 conditions:
> =20
>  - ``CPU``
> =20
> -  On the x86 platform, the driver checks if the CPU supports AVX512.
> -  If the CPU supports AVX512 and EAL argument=20
> ``--force-max-simd-bitwidth``
> -  is set to 512, AVX512 paths will be chosen.
> +  On the x86 platform, the driver checks if the CPU supports AVX instruc=
tion set.
> +  If the CPU supports AVX512 and EAL argument=20
> + --force-max-simd-bitwidth is set to 512, AVX512 paths will be chosen  e=
lse if --force-max-simd-bitwidth is set to 256, AVX2 paths will be chosen.
> +  Note that 256 is the default bitwidth if no specific value is provided=
.
> +
> =20
>  - ``Offload features``
> =20
> diff --git a/doc/guides/rel_notes/release_25_03.rst=20
> b/doc/guides/rel_notes/release_25_03.rst
> index a88b04d958..905e8f363c 100644
> --- a/doc/guides/rel_notes/release_25_03.rst
> +++ b/doc/guides/rel_notes/release_25_03.rst
> @@ -76,6 +76,13 @@ New Features
> =20
>    * Added support for virtual function (VF).
> =20
> +* **Added support of AVX2 instructions on IDPF.**
> +
> +   Support for AVX2 instructions in IDPF single queue RX and TX path
> +   added.The single queue model processes all packets in order within
> +   one RX queue, while the split queue model separates packet data and
> +   metadata into different queues for parallel processing and improved p=
erformance.
> +
> =20
>  Removed Items
>  -------------
> diff --git a/drivers/common/idpf/idpf_common_device.h=20
> b/drivers/common/idpf/idpf_common_device.h
> index 734be1c88a..5f3e4a4fcf 100644
> --- a/drivers/common/idpf/idpf_common_device.h
> +++ b/drivers/common/idpf/idpf_common_device.h
> @@ -124,6 +124,7 @@ struct idpf_vport {
>  	bool rx_vec_allowed;
>  	bool tx_vec_allowed;
>  	bool rx_use_avx2;
> +	bool tx_use_avx2;
>  	bool rx_use_avx512;
>  	bool tx_use_avx512;
> =20
> diff --git a/drivers/common/idpf/idpf_common_rxtx.h=20
> b/drivers/common/idpf/idpf_common_rxtx.h
> index f50cf5ef46..e19e1878f3 100644
> --- a/drivers/common/idpf/idpf_common_rxtx.h
> +++ b/drivers/common/idpf/idpf_common_rxtx.h
> @@ -306,5 +306,9 @@ __rte_internal
>  uint16_t idpf_dp_singleq_recv_pkts_avx2(void *rx_queue,
>  					struct rte_mbuf **rx_pkts,
>  					uint16_t nb_pkts);
> +__rte_internal
> +uint16_t idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue,
> +					struct rte_mbuf **tx_pkts,
> +					uint16_t nb_pkts);
> =20
>  #endif /* _IDPF_COMMON_RXTX_H_ */
> diff --git a/drivers/common/idpf/idpf_common_rxtx_avx2.c=20
> b/drivers/common/idpf/idpf_common_rxtx_avx2.c
> index 277b2a9469..7d292ff19e 100644
> --- a/drivers/common/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/common/idpf/idpf_common_rxtx_avx2.c
> @@ -478,3 +478,227 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue,=20
> struct rte_mbuf **rx_pkts, uint16  {
>  	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts,=20
> nb_pkts);  }
> +static __rte_always_inline void
> +idpf_tx_backlog_entry(struct idpf_tx_entry *txep,
> +		     struct rte_mbuf **tx_pkts, uint16_t nb_pkts) {
> +	int i;
> +
> +	for (i =3D 0; i < (int)nb_pkts; ++i)
> +		txep[i].mbuf =3D tx_pkts[i];
> +}

Can idpf driver switch to using ci_tx_entry (and ci_tx_entry_vec) from the =
intel/common/tx.h header? Then we can drop this code and just use ct_tx_bac=
klog_entry and similar functions.

> +
> +static __rte_always_inline int
> +idpf_singleq_tx_free_bufs_vec(struct idpf_tx_queue *txq) {
> +	struct idpf_tx_entry *txep;
> +	uint32_t n;
> +	uint32_t i;
> +	int nb_free =3D 0;
> +	struct rte_mbuf *m, *free[txq->rs_thresh];
> +
> +	/* check DD bits on threshold descriptor */
> +	if ((txq->tx_ring[txq->next_dd].qw1 &
> +			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=3D
> +			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE))
> +		return 0;
> +
> +	n =3D txq->rs_thresh;
> +
> +	 /* first buffer to free from S/W ring is at index
> +	  * next_dd - (rs_thresh-1)
> +	  */
> +	txep =3D &txq->sw_ring[txq->next_dd - (n - 1)];
> +	m =3D rte_pktmbuf_prefree_seg(txep[0].mbuf);
> +	if (likely(m)) {
> +		free[0] =3D m;
> +		nb_free =3D 1;
> +		for (i =3D 1; i < n; i++) {
> +			m =3D rte_pktmbuf_prefree_seg(txep[i].mbuf);
> +			if (likely(m)) {
> +				if (likely(m->pool =3D=3D free[0]->pool)) {
> +					free[nb_free++] =3D m;
> +				} else {
> +					rte_mempool_put_bulk(free[0]->pool,
> +							     (void *)free,
> +							     nb_free);
> +					free[0] =3D m;
> +					nb_free =3D 1;
> +				}
> +			}
> +		}
> +		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
> +	} else {
> +		for (i =3D 1; i < n; i++) {
> +			m =3D rte_pktmbuf_prefree_seg(txep[i].mbuf);
> +			if (m)
> +				rte_mempool_put(m->pool, m);
> +		}
> +	}
> +
> +	/* buffers were freed, update counters */
> +	txq->nb_free =3D (uint16_t)(txq->nb_free + txq->rs_thresh);
> +	txq->next_dd =3D (uint16_t)(txq->next_dd + txq->rs_thresh);
> +	if (txq->next_dd >=3D txq->nb_tx_desc)
> +		txq->next_dd =3D (uint16_t)(txq->rs_thresh - 1);
> +
> +	return txq->rs_thresh;
> +}

Similarly, this looks the same as ci_tx_free_bufs_vec.

> +
> +static inline void
> +idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
> +		  struct rte_mbuf *pkt, uint64_t flags) {
> +	uint64_t high_qw =3D
> +		(IDPF_TX_DESC_DTYPE_DATA |
> +		 ((uint64_t)flags  << IDPF_TXD_QW1_CMD_S) |
> +		 ((uint64_t)pkt->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S));
> +
> +	__m128i descriptor =3D _mm_set_epi64x(high_qw,
> +				pkt->buf_iova + pkt->data_off);
> +	_mm_store_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor); }
> +
> +static inline void
> +idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
> +		 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags) {
> +	const uint64_t hi_qw_tmpl =3D (IDPF_TX_DESC_DTYPE_DATA |
> +			((uint64_t)flags  << IDPF_TXD_QW1_CMD_S));
> +
> +	/* if unaligned on 32-bit boundary, do one to align */
> +	if (((uintptr_t)txdp & 0x1F) !=3D 0 && nb_pkts !=3D 0) {
> +		idpf_singleq_vtx1(txdp, *pkt, flags);
> +		nb_pkts--, txdp++, pkt++;
> +	}
> +
> +	/* do two at a time while possible, in bursts */
> +	for (; nb_pkts > 3; txdp +=3D 4, pkt +=3D 4, nb_pkts -=3D 4) {
> +		uint64_t hi_qw3 =3D
> +			hi_qw_tmpl |
> +			((uint64_t)pkt[3]->data_len <<
> +			 IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw2 =3D
> +			hi_qw_tmpl |
> +			((uint64_t)pkt[2]->data_len <<
> +			 IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw1 =3D
> +			hi_qw_tmpl |
> +			((uint64_t)pkt[1]->data_len <<
> +			 IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw0 =3D
> +			hi_qw_tmpl |
> +			((uint64_t)pkt[0]->data_len <<
> +			 IDPF_TXD_QW1_TX_BUF_SZ_S);
> +
> +		__m256i desc2_3 =3D
> +			_mm256_set_epi64x
> +				(hi_qw3,
> +				 pkt[3]->buf_iova + pkt[3]->data_off,
> +				 hi_qw2,
> +				 pkt[2]->buf_iova + pkt[2]->data_off);
> +		__m256i desc0_1 =3D
> +			_mm256_set_epi64x
> +				(hi_qw1,
> +				 pkt[1]->buf_iova + pkt[1]->data_off,
> +				 hi_qw0,
> +				 pkt[0]->buf_iova + pkt[0]->data_off);
> +		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp + 2), desc2_3);
> +		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), desc0_1);
> +	}
> +
> +	/* do any last ones */
> +	while (nb_pkts) {
> +		idpf_singleq_vtx1(txdp, *pkt, flags);
> +		txdp++, pkt++, nb_pkts--;
> +	}
> +}
> +
> +static inline uint16_t
> +idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf *=
*tx_pkts,
> +				       uint16_t nb_pkts)
> +{
> +	struct idpf_tx_queue *txq =3D (struct idpf_tx_queue *)tx_queue;
> +	volatile struct idpf_base_tx_desc *txdp;
> +	struct idpf_tx_entry *txep;
> +	uint16_t n, nb_commit, tx_id;
> +	uint64_t flags =3D IDPF_TX_DESC_CMD_EOP;
> +	uint64_t rs =3D IDPF_TX_DESC_CMD_RS | flags;
> +
> +	/* cross rx_thresh boundary is not allowed */
> +	nb_pkts =3D RTE_MIN(nb_pkts, txq->rs_thresh);
> +
> +	if (txq->nb_free < txq->free_thresh)
> +		idpf_singleq_tx_free_bufs_vec(txq);
> +
> +	nb_commit =3D nb_pkts =3D (uint16_t)RTE_MIN(txq->nb_free, nb_pkts);
> +	if (unlikely(nb_pkts =3D=3D 0))
> +		return 0;
> +
> +	tx_id =3D txq->tx_tail;
> +	txdp =3D &txq->tx_ring[tx_id];
> +	txep =3D &txq->sw_ring[tx_id];
> +
> +	txq->nb_free =3D (uint16_t)(txq->nb_free - nb_pkts);
> +
> +	n =3D (uint16_t)(txq->nb_tx_desc - tx_id);
> +	if (nb_commit >=3D n) {
> +		idpf_tx_backlog_entry(txep, tx_pkts, n);
> +
> +		idpf_singleq_vtx(txdp, tx_pkts, n - 1, flags);
> +		tx_pkts +=3D (n - 1);
> +		txdp +=3D (n - 1);
> +
> +		idpf_singleq_vtx1(txdp, *tx_pkts++, rs);
> +
> +		nb_commit =3D (uint16_t)(nb_commit - n);
> +
> +		tx_id =3D 0;
> +		txq->next_rs =3D (uint16_t)(txq->rs_thresh - 1);
> +
> +		/* avoid reach the end of ring */
> +		txdp =3D &txq->tx_ring[tx_id];
> +		txep =3D &txq->sw_ring[tx_id];
> +	}
> +
> +	idpf_tx_backlog_entry(txep, tx_pkts, nb_commit);
> +
> +	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
> +
> +	tx_id =3D (uint16_t)(tx_id + nb_commit);
> +	if (tx_id > txq->next_rs) {
> +		txq->tx_ring[txq->next_rs].qw1 |=3D
> +			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
> +					 IDPF_TXD_QW1_CMD_S);
> +		txq->next_rs =3D
> +			(uint16_t)(txq->next_rs + txq->rs_thresh);
> +	}
> +
> +	txq->tx_tail =3D tx_id;
> +
> +	IDPF_PCI_REG_WRITE(txq->qtx_tail, txq->tx_tail);
> +
> +	return nb_pkts;
> +}
> +
> +uint16_t
> +idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts=
,
> +			       uint16_t nb_pkts)
> +{
> +	uint16_t nb_tx =3D 0;
> +	struct idpf_tx_queue *txq =3D (struct idpf_tx_queue *)tx_queue;
> +
> +	while (nb_pkts) {
> +		uint16_t ret, num;
> +
> +		num =3D (uint16_t)RTE_MIN(nb_pkts, txq->rs_thresh);
> +		ret =3D idpf_singleq_xmit_fixed_burst_vec_avx2(tx_queue, &tx_pkts[nb_t=
x],
> +						    num);
> +		nb_tx +=3D ret;
> +		nb_pkts -=3D ret;
> +		if (ret < num)
> +			break;
> +	}
> +
> +	return nb_tx;
> +}
> diff --git a/drivers/common/idpf/version.map=20
> b/drivers/common/idpf/version.map index 22b689f5f5..0557321963 100644
> --- a/drivers/common/idpf/version.map
> +++ b/drivers/common/idpf/version.map
> @@ -10,6 +10,7 @@ INTERNAL {
>  	idpf_dp_singleq_recv_pkts_avx512;
>  	idpf_dp_singleq_recv_scatter_pkts;
>  	idpf_dp_singleq_xmit_pkts;
> +	idpf_dp_singleq_xmit_pkts_avx2;
>  	idpf_dp_singleq_xmit_pkts_avx512;
>  	idpf_dp_splitq_recv_pkts;
>  	idpf_dp_splitq_recv_pkts_avx512;
> diff --git a/drivers/net/intel/idpf/idpf_rxtx.c=20
> b/drivers/net/intel/idpf/idpf_rxtx.c
> index a8377d3fee..0c3ecd2765 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_rxtx.c
> @@ -887,6 +887,11 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
>  	if (idpf_tx_vec_dev_check_default(dev) =3D=3D IDPF_VECTOR_PATH &&
>  	    rte_vect_get_max_simd_bitwidth() >=3D RTE_VECT_SIMD_128) {
>  		vport->tx_vec_allowed =3D true;
> +
> +		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) =3D=3D 1 &&
> +		    rte_vect_get_max_simd_bitwidth() >=3D RTE_VECT_SIMD_256)
> +			vport->tx_use_avx2 =3D true;
> +
>  		if (rte_vect_get_max_simd_bitwidth() >=3D RTE_VECT_SIMD_512)  #ifdef=20
> CC_AVX512_SUPPORT
>  		{
> @@ -946,6 +951,14 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
>  				return;
>  			}
>  #endif /* CC_AVX512_SUPPORT */
> +			if (vport->tx_use_avx2) {
> +				PMD_DRV_LOG(NOTICE,
> +					    "Using Single AVX2 Vector Tx (port %d).",
> +					    dev->data->port_id);
> +				dev->tx_pkt_burst =3D idpf_dp_singleq_xmit_pkts_avx2;
> +				dev->tx_pkt_prepare =3D idpf_dp_prep_pkts;
> +				return;
> +			}
>  		}
>  		PMD_DRV_LOG(NOTICE,
>  			    "Using Single Scalar Tx (port %d).",
> --
> 2.34.1
>=20
