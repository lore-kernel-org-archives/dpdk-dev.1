Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3199CCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 06:15:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DE4D410D4;
	Thu, 14 Aug 2025 08:15:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6A5B74026D;
 Thu, 14 Aug 2025 08:15:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755152134; x=1786688134;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GUtPEod03IIlwFaMQpqTl31XczbOSKHmO4CEBq3Y+gk=;
 b=jIZ5qe9OqgRBfmJaQq8rtgQ3RnUM3AMKl7pJ+ufKeEA35qatLhXadiPg
 4zexmXFb8K8ZqTSqF0p6TNmIy+IH+3eh/ZFXYAyjmbbWwn1lU+PH8IUmr
 1Ak5eBZc+K9QhuDTDiEEIFGkRuitBWqLttgiB0O5TNKFTG3N0Wj0Le+VO
 So2uH7b4ot4TxuEux01VnmGBB4kovg0ehGuzrwasAwgFhj+hlV/4PB+oB
 nc3s6Al9n/Mq98p7hnXW1Jx1CQlthpgOg6HZ/+6oJE1Wj8MGICJukQKE4
 0oECeduFOwtWhXdnu5bRac0Aj2pSc3kwXrfDqYPugnsYoNp1sK9rJR3IS Q==;
X-CSE-ConnectionGUID: /Kg8k9jLT+as4ROJlYvFeQ==
X-CSE-MsgGUID: r9PmLCYjQwyvKxi92/tCMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="67730710"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="67730710"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 23:15:33 -0700
X-CSE-ConnectionGUID: XZDJaVxpRXyURFrZhL/ojg==
X-CSE-MsgGUID: 8RQ7tmLMSPqigveEiJlDcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="172016109"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 23:15:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 23:15:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 23:15:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.78) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 23:15:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk6pRuaLPG+QXof84P9z10xhpRB77AcBc02cMzJ+pQ8C1fLlPboIuOUGrsdjopNgVdos3HzyOP1SpGzDGpBlxcI3HOzpQ9KPcOOQgYby9AQFZ0OENiLm3MYdTf9laHvAoV8CvKbtBIP700TfvxY63RQoODSiFTBx9uwXpI6JnUGijO+IvpHZ6lW6eqT+05xabOWh1OlO8M13QKKaoOE/2dzk1GyKHIO2x3E5vOtDqW4Kf7ZhOEQxUap2pMOXZLEdvp4DCGzRaSbvgcEnvCtR8cB04TOTFET6bqb2N9DKRbtmDAu8aePH5rXKtmnyFFRBsAQSvQdVEairpylpKci13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EdkSgR92f82hXsazfx68Ga7TXYW4sOUHih7kBlb6XM=;
 b=A8zP2023nnOuo85+niZ41YcDv1VBit1UtJRNVtv3fVsdvXHgE0wof7QG1iXW4+VxDqTZrTC0/yyNYSuTT1eUl167Lg8V7efVenVGQGeLi+Nk3LodpYMUbCsz8UcTNyS8cnFg9EgVtMKJwyGVlSjoBIMzuUjyEIEFc4XdUf6L+p34v8jUht8Sn+z9q/qZtPI7/foUHp5PieQOHNbJtTbxhOx4NOnsOMXSLBQ88iAOulUqEm71AdUbI1IW6fLnXJgC9s3zrXt5+6KmZkrfdBGAz8Xqip5ZA6pPSFnB5Ho2d7uyBKyAIHufS9DPcBaKwJoWNXDDEz0emAv2eJrAJKnrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF04AA7285F.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::806) by SA2PR11MB4809.namprd11.prod.outlook.com
 (2603:10b6:806:112::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 06:01:17 +0000
Received: from SJ5PPF04AA7285F.namprd11.prod.outlook.com
 ([fe80::d6ad:76e3:b3d8:86a1]) by SJ5PPF04AA7285F.namprd11.prod.outlook.com
 ([fe80::d6ad:76e3:b3d8:86a1%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 06:01:17 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Kevin Traynor <ktraynor@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, "Luca
 Boccassi" <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>
Subject: RE: 24.11.3 patches review and test
Thread-Topic: 24.11.3 patches review and test
Thread-Index: AQHb/LZCf7Bdiq2rDEuYm2wlLSnhIbRhxz+g
Date: Thu, 14 Aug 2025 06:01:16 +0000
Message-ID: <SJ5PPF04AA7285FA44F7390FE3113CCC24F9F35A@SJ5PPF04AA7285F.namprd11.prod.outlook.com>
References: <20250724161514.396245-1-ktraynor@redhat.com>
In-Reply-To: <20250724161514.396245-1-ktraynor@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF04AA7285F:EE_|SA2PR11MB4809:EE_
x-ms-office365-filtering-correlation-id: b7ee1309-d685-4c78-4394-08dddaf7fbb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2sKWjCbOTGRbs2PK08MXE41hxxBt9Um9QIktzOMVKt76QxPC5JLY0JI8d1QL?=
 =?us-ascii?Q?8pCblLSPVsqY0+t2ouAha1UZvLs7KMZ4rt+FVjtX4kO/ZBjBnW1najJxvXqn?=
 =?us-ascii?Q?n1AgLI4I1eO1kXDKHaaLtlOcVhw9QK+jxPdiblrrueeT4eDWesQyOlDhDjbo?=
 =?us-ascii?Q?ww10iBV1G5AgOENDqjj22PyzVg2QT8S3zFvTt631dX4odYNU+XNltkwWjton?=
 =?us-ascii?Q?BPa9HVEy/RfybhjTbbG2KC9+CikBTelWkdrTyWhPv3SBpxgeAe8MTEbfhtvw?=
 =?us-ascii?Q?Tm6oGvzpihSs/yz1ZOizF8G8pZrcCOe9aXDFm74YM6eFoW16j7eGwWvJl1QR?=
 =?us-ascii?Q?83t7i7644b04go6vGDgxy6dyJ9FbxO9kdpq+iWozv2hHXwnLFhoi3KtU3CY5?=
 =?us-ascii?Q?kraeqCUsJjEkMmDaeUTSAKbkfTOUfbHqij/qp+j/uCDQJmt3BmoRrn8v2mJ3?=
 =?us-ascii?Q?2TtwGm7n+iFEUevg9XBrUuiZ/GGn/NBDnO1+lFinYhwZRSsFdSht0Q8136Sn?=
 =?us-ascii?Q?S/n/+1rXvFjJUgCWIiQx212eUcwWK6rfvd2CQZaZF3XiqulIwYlSex5z/jZt?=
 =?us-ascii?Q?4QWun+IT4zafUf127H5Tt+WeZVGvFcwYyEPcWWk4DVy7TXjtzWtLFPpicQbz?=
 =?us-ascii?Q?ZSxwhSUOwqqvH/7Or0KSi7qaBDhpr2mgNQhevm6Zb35uhwYYdW2SuwTL3O69?=
 =?us-ascii?Q?5gHqt11xb0MXwCO0R8uzbE6uEzLtSWsxjFaT1z1W64JHqB8UOmhutPcduyEU?=
 =?us-ascii?Q?jzQy8VrGLrlCq5fUyCPmsm8QUGhBEtxjBAJg2kODpK48gWHzWFGCZSTJXxNx?=
 =?us-ascii?Q?mj5PEcUMIRwYLhPT3BR9Y/lezW2NZD79B5sjchmOYlxjc7iepVStmMnNShEF?=
 =?us-ascii?Q?X831R3MxFt7cnYVo3ITULSE3UIohqd0bP69folvK9UxftHQngSvE24MlL74y?=
 =?us-ascii?Q?pI6J3iZu2qU78aAI+GsfzwrR3mAkhGitTWm3fHsbzR3V/lQ0FUsrS8HG1Ub8?=
 =?us-ascii?Q?dklk9pNlrOgiZ6+ZSKaDckjXMMg4v+stHbXknSRn8W3VNKHWzAOXl5E629R4?=
 =?us-ascii?Q?++/M9dXa+cVNx+7CN+1VJ0b1XiMSk/QioLiUBfDytXFl2W1t0vmKD+nBbGmm?=
 =?us-ascii?Q?9NXXWVD4PTH/L7zi3s25XpqgIv5KkJrCYf3nLNZYf95gcuGcFxE2LUw4alel?=
 =?us-ascii?Q?7+fES/Q7e9ItETZTC+Yns+IHRFejeiOfvRXZI6Nw349HbNfFrcX4/pZVf4Dl?=
 =?us-ascii?Q?FlIbJGSEvJcfZZYXo+uZ8tMJH0WHQBlL1GXPJgEQ8bEVigO6GJDPD8rL8trE?=
 =?us-ascii?Q?xxB3zW5Z7Bypkf5vIDXjzMYv0HSTDF6qvOS+bkG7zVmSgJnTmpTWCNtDWjF/?=
 =?us-ascii?Q?aWjGVc7ZKlsXVPioHV/Qirx+LZeqQ8QPqh22ofcac+mvnEqe8u48pv9IzIkj?=
 =?us-ascii?Q?sF2uXX0R3ZAZQC2lRXz4hnnL2WLdhUUL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF04AA7285F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q4X/xmiPLX3q4qx7Iru4FtLmUCqZIFSn3d6s3yIg/xLdrzMsDGcIdfxzBOAe?=
 =?us-ascii?Q?aOb3lU7OltrWinW4fBGlXD99FpgEA29R90wO15pYkbsPbOs7kbePJkYFuCdM?=
 =?us-ascii?Q?xFxaAKTFrfoLaf+DzPDNNkiaZxVB09/0EosN82i5v+pwQhhBikn/q4U+W6Uu?=
 =?us-ascii?Q?QK65sL4fBJuvLZjmIaMgy9hPtj3jHo0bW9gwXv9M/FB1MqFMob9mFLI1GuNJ?=
 =?us-ascii?Q?JdS25gD3P6nxnpWWrDJ1PSMFgG5cm2GxuDGa4ZHdVSHH9ga58Evemc5NFT7l?=
 =?us-ascii?Q?yyhI3YF4wpu+lvRYaWHpaRaUmzgyp9mvb8+BUcRKwmlJ4qZkgTLzZmCHgOiB?=
 =?us-ascii?Q?AF8K+OvGXtZMZrIQaH9yeibv3pCh48hwlGicfaovBYQsEflyLIy2PuSsf0jp?=
 =?us-ascii?Q?Mx8xYTiAeka6r6qeKdKw6ZFJttakCWmzW/uorZAfLYzppfDmxwsy4NUmn31r?=
 =?us-ascii?Q?HR2uh8UmT/4MvW36R/SXSx8RiCuf7SqZj8lHWuMv8UZMWSioU4sqHNzshgSc?=
 =?us-ascii?Q?o94aQNXLIY72uXLzZq5o13z1uHcmHfWs1hnOkR0X9csbu8otSipTFU0BLmm/?=
 =?us-ascii?Q?DpYcDvJ6zqkXB0mfT9B8kE7CNT24+3GPzSU3r0op2zNDdpm+6S+mw3EmvLbw?=
 =?us-ascii?Q?DC8VWi5mV7YFVhYjwL9x0Tzj+xhKs2EKHWNMThcWZmWpgeJcja5F9MXJdtA2?=
 =?us-ascii?Q?WwNVByvwRHD3SxLGzEdpN5ibmiJyA6Dv0KWUV+tKVJmrimSdoKfto7dyh5ec?=
 =?us-ascii?Q?pWqOCseQXSa4WDRJ/J0mI1R5lqMYVLX62oz7pbaHSp9+IsBG8B274t8q5DQG?=
 =?us-ascii?Q?/yBkCPvim24oEqeDUPTKfZJiab2G1W5gy23qYe9ORisA8FoGc53e1hC9yxuV?=
 =?us-ascii?Q?ZuQa40uGKkg2NQtBJcv8sAUP/4ZAK0mp3YqOZtXl1o7O97z7G7d31EYwu2c1?=
 =?us-ascii?Q?36qXfpIfeNnkesCj27IRkg/Y2pnPaps+piKZ/n+x1JtsWbPalC8FPZUy/NsC?=
 =?us-ascii?Q?MEL72MH3EnbTMLN/LKBj4k5My7BXxNHixPVWgJMkS36no4vLMB6lfE8dke9z?=
 =?us-ascii?Q?8qnZH6mZ9zZgGt2bXfCmtBw0dnyUudGKKQtWYTmIV9XWb5E6SCmUnj/LNOZU?=
 =?us-ascii?Q?bLgXnQ4ZVpGw/TYd7CfXexpx64pTAS/Pf8YR38eni0Uxb+APS4X1FU00z6jl?=
 =?us-ascii?Q?N6ZUn2I8oPQgN7QltQdCgI26dYNVxyq/slN9VKXZTWI8m/a91mXZM/e9s2Ez?=
 =?us-ascii?Q?yzIkAyLCoJFZIbbVmEIeZyauL494hrKHAQqK2b6HO6PvIYE+z124nei6osNP?=
 =?us-ascii?Q?IXwX++v01WflzZ9VN2mzQzabVd19LgTO0CHXfQGP4m+zLiVO6GfOhHyhglMa?=
 =?us-ascii?Q?b4OjaZrhsYRaDTWEvntAnvKInr7t3VhhQJSAxuyrFzH4iXRHXtU2OhVpQse2?=
 =?us-ascii?Q?W67KANKn5gAV/tAcb6V/NEvyj+URhQI1mInyokCk7xXqBQ9YKxHHLZxuzyhq?=
 =?us-ascii?Q?9hwd9ckWLAuQhkXp/vcNYGhtNeNvl3t53A45YVE2y1s0AvsxQn5rFD+nJ88e?=
 =?us-ascii?Q?PUF3p8Uh0S28Uf1nFtmB0ZqKyQz9t1IhxHlkkdwX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF04AA7285F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ee1309-d685-4c78-4394-08dddaf7fbb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 06:01:17.0980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vymRbFOndGFtm/d/Zt66zK4wrYHLp3fFIRlkcozr3yfwglfNcH4AMk/B2II1yzXjLNJDN1IW7TpZ8dOpARXI7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4809
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

> -----Original Message-----
> From: Kevin Traynor <ktraynor@redhat.com>
> Sent: Friday, July 25, 2025 12:15 AM
> To: stable@dpdk.org
> Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
> Ali Alnubani <alialnu@nvidia.com>; David Christensen
> <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> Jerin Jacob <jerinj@marvell.com>; Mcnamara, John
> <john.mcnamara@intel.com>; Ju-Hyoung Lee <juhlee@microsoft.com>; Kevin
> Traynor <ktraynor@redhat.com>; Luca Boccassi <bluca@debian.org>; Pei
> Zhang <pezhang@redhat.com>; Raslan Darawsheh <rasland@nvidia.com>;
> Thomas Monjalon <thomas@monjalon.net>; yanghliu@redhat.com
> Subject: 24.11.3 patches review and test
>=20
> Hi all,
>=20
> Here is a list of patches targeted for stable release 24.11.3.
>=20
> The planned date for the final release is 12th August 2025.
>=20
> Please help with testing and validation of your use cases and report any
> issues/results with reply-all to this mail. For the final release the fix=
es and
> reported validations will be added to the release notes.
>=20
> A release candidate tarball can be found at:
>=20
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv24.11.3-rc1
>=20
> These patches are located at branch 24.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>=20
> Thanks.
>=20
> Kevin
>=20
> ---
Update the test status for Intel part. dpdk24.11.3-rc1 all validation test =
done. no new issue is found.

known issues: fix patch has been merged into main, but they not merged 24.1=
1 LTS, so this issue still exists in 24.11.3-rc1
  1. Bug 1606 - flow_filtering/flow_filtering_mismatch_rule: Some mismatch =
rule packets match the rule.
     - has fix patch: https://patches.dpdk.org/project/dpdk/patch/202501120=
75200.5020-1-shperetz@nvidia.com/

* Build & CFLAG compile: cover the build test with latest GCC/Clang version=
 on the following OS(all passed)
  - Ubuntu25.04/Ubuntu24.04.2
  - RHEL9.6/RHEL10
  - Fedora42
  - FreeBSD14.2
  - SUSE15.6
  - OpenAnolis8.10
  - AzureLinux3.0

* Function tests: All test done and there are two known issues.
  - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW/TSO/=
Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - IXGBE-(82599, E610) PF/VF: test scenarios including basic/RTE_FLOW/TSO/=
Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - ICE-(E810, E830, E2100) PF/VF: test scenarios including basic/Switch/Pa=
ckage Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible De=
scriptor, etc.
  - IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test=
 - QAT&SW/FIB library, etc.
  - Virtio: both function and performance test are covered. Such as PVP/Vir=
tio_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESX=
I 8.0, etc.
  - Cryptodev: test scenarios including Cryptodev API testing/CompressDev I=
SA-L/QAT/ZLIB PMD Testing/FIPS, etc.
  - DLB: test scenarios including DLB2.0 and DLB2.5
  - Other: test scenarios including AF_XDP, Power, CBDMA, DSA

* Performance test: All test done and passed
  - Thoughput Performance
  - Cryptodev Latency
  - PF/VF NIC single core
  - XXV710/E810 NIC Performance


Regards,
Xu, Hailin
