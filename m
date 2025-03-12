Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DB5C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 08:43:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F185402CE;
	Wed, 12 Mar 2025 09:43:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id BAC1740265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 09:43:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741769015; x=1773305015;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=m/HeguzUL6Hebcpsw2Td5MSeBTSwhLZzi4Mp/mjJbpI=;
 b=V+bN83PIRNVnDcdG52KZuvWCDuH/sTOGEeV4vs9Sfkj58/nMlzpKlc+u
 ah2a1OWeeera+xRfevLkR2wN+7I5Q67uhRrhTw86dpN7GM9QyxZwyTP1N
 gCPIMw5EIx23AFEkJS8iXvgwEArFVqHNnYQwIK8e4yMvf7ZwhsNa+jFTz
 r3dRtPm2y02sL9c37C7qAchVDgjWIPBsGOR5nj+AHFNa6gjW8DqdYyoHt
 3RBLGBnC+UICfM0cw899DrGhQX3vjQ1VPpTydKfw4U0JB5k3tqrNaRhMb
 l3Ikl+ZTao7hVOXitPBZzqv6boKKcOiChBKv7xkSmNQnsJGhOcqarVQg9 Q==;
X-CSE-ConnectionGUID: 8yAGiBgpRPa+ro9QDeInqg==
X-CSE-MsgGUID: aF5GZ5d6RXCEyC6u3zWzcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="30416076"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; d="scan'208,217";a="30416076"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 01:43:31 -0700
X-CSE-ConnectionGUID: kGV0dYPsTY6Lq961E6MBDA==
X-CSE-MsgGUID: qozV/TI2TA2HuCT69W9FKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
 d="scan'208,217";a="120792340"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 01:43:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 01:43:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 01:43:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 01:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+kwWfi6zmddHriHXZ5AbZl5fRGFlShkTdJFOHXY5M+TJXv2QwwZA3Dpr5cPet84R9kh8cjoJSrn+cb2U83twVVKo7PTD38skRM5Hx13a9o309sOa0gcMPmM64GJ6Y22ZsiVZFG9sl0c+knTRRLclnXnOTvuWy5H1x3IFdKMrG0d8EQVo3Fo7eR0HWCvE/FIWr6J6ja9mJDys8SglBFTuYLwgST2FQ1JLAsCpNq3mKRZkegbKCq9IUCZP5HHluvb0fPaN0KJMcXQU44BNaAIs7OY1V+OEwmOxI/nBVdCGIcAT7Jj+qNeyX1YmuaJ5vAp0Fqbgga/ai8ViuMpKHPfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbf1d0I19VOUz5ism9uNUaZx0L1279e5mVh32zhnQkg=;
 b=OIh5CkFQ5AB/4EyuKZuS4VKt96pVFc0HcoKWlEl6dfEYlSAunJl5HnXQ06Eu5KMhUeUwZWGiZXWMIEXgLWB0Mqj1YWhxvtl0v5m3OfsB0FoUnqzR7p1MJZeNGctY5Et8CIKYqLD1DKi82GS8ES1zhV0mq2K645+ipvhjsPRxXm7cHz8aZE2xfRxb0/waM2VSgnBLuFUt+j4fNTEoNxeimdSLU7Zb5wfQTIx0MXcZWLUVLjY4OET5WZK223tzhwyRQGqtF4wWbhrGm3R5XvubnZFvJaer5HIkoql+xgGkxfO883fVTcmIIj2nbAp9pEl0luiyenE0ZGr2uGSGLtzARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by DM4PR11MB5995.namprd11.prod.outlook.com (2603:10b6:8:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:43:28 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:43:27 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-03-11
Thread-Topic: DPDK Release Status Meeting 2025-03-11
Thread-Index: AduTKrj+fbVmk3dTSnS2VOqijIiWwA==
Date: Wed, 12 Mar 2025 08:43:27 +0000
Message-ID: <PH8PR11MB6804C2943ECCBB883C418EF1FCD02@PH8PR11MB6804.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|DM4PR11MB5995:EE_
x-ms-office365-filtering-correlation-id: fda59090-0de0-4902-f69b-08dd6141f5ae
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9dJWbuYH+MpB3UT2VXIE4jJqZ3PWlFDS/bJ/f5AgNpBycOXVjY4ZIQkPEI2S?=
 =?us-ascii?Q?naUVYFEYgyWrmJ5a4p99KHfpj7IIT/jJrrJjw3b2ujmQmv439FIckEs6JfgP?=
 =?us-ascii?Q?REf3n6kWdwMgeL4Di53DDz9sVNkmqxkmI2phB85vtXO8eKojOyQL77IJWl+C?=
 =?us-ascii?Q?+2OppIWdg5f4w/hDpGpNSblImM+kW/WECwELKvrWZyxfBx9wRIBuse1+5vMk?=
 =?us-ascii?Q?t+GOljf8UhIB1DqOz92cOCN6pXBWm8LZyA4P/AZsnKQW+HezfLP8LQTFEqhD?=
 =?us-ascii?Q?TNwVvtCuI5e9HeL6paNRkz3/Ax9F+Q93WntJXru+YUXGOZxFMMc1HVYmrM3b?=
 =?us-ascii?Q?To4N7Qrzarj0Alinqgp5KSrknbMaG7bKUtVgnG8q215CcZosZdP7YOphLVtN?=
 =?us-ascii?Q?2W0AMZTmKv5tA7vJqJZZLqVgYruoiEYmf34kI2HnKphqjemS8shkrU7uiib8?=
 =?us-ascii?Q?UWqKwyNF4e4QjyyNIJOy7Oitm/ITxmo5nONh7k4flMiS+FfnJM6wgJAYoTj8?=
 =?us-ascii?Q?fiFT609Me/AoWXKb9EpYHVZTImaZOBh9yQ9xUTYz6+MGgtp4CMwGTrWKNyQC?=
 =?us-ascii?Q?LYDQ62LAk3wHiA/7aRvTzq/OGX0GCRAkJpqZFdjafXifyu5YPfv0dqZbr5cn?=
 =?us-ascii?Q?IszWbjPd4j+gpGU5mD31oae6TlzWUiVLw6NCY2MbpIULF7CyTUIMx4DARHWv?=
 =?us-ascii?Q?YXAeCqykyt536J/Kop05Ij28ly/w/nDGg50oaSYQiCDjOwJVr/XbIVpL2Cdp?=
 =?us-ascii?Q?yvIrCp7+r/4Fu3vEkN4gQ5BIpE6mSzKMvFFINvipnrnTfLu4Sdas3+0/j0i+?=
 =?us-ascii?Q?StrS7yQ9g/rRwPaHYJGGvpIr2cVJYJp4Rt2XbMIF3Sdq6ycWACic3LAW+wPR?=
 =?us-ascii?Q?7SiAq8uRhV/JUTyoj+kL+HOofWA7oPBupuVBDZJwmy3/Pv+aE8AnlUlAawws?=
 =?us-ascii?Q?zN78XlvIWhElo4OmPGoONEB50g6bJrCce0OiFJPLQHeeDDracKUWR77HwwjY?=
 =?us-ascii?Q?pgE0fBhmginQVBZ3YgK4A7OED7ggsYrCuGdjXYvKhdqMEkSx4uJhEGUYdJv9?=
 =?us-ascii?Q?qQ7k/XigCwTiSVhhIMqiI5/jcnL16Ep4sB/1hPEZ01rFlW7s3PEJHR1D8Rio?=
 =?us-ascii?Q?AHVqWdAmeBlDL9Jht2yzC10v3oooTPEplscUWUNv8DGrizk0yJBkEN51sHyV?=
 =?us-ascii?Q?5lOuH87RmtbPQDSUhyfstikuDyDtsnxFRxYgO8MSohP6xdQNFcNkj+W4er/F?=
 =?us-ascii?Q?Iz0dWy6nUMxj8TB/tpOKUXTHI1rMtv1OF9pqdlyT6m+9lv2qGSeAlplIJHXs?=
 =?us-ascii?Q?cr6ihIqzwrElnsTyJD5aqcfYIdHJ0KkATcZbjW9Q/D3X15pTktjnm1a/p+Xs?=
 =?us-ascii?Q?9RZVLl6h6SNV1VcEtGR97PWdTGU/nsTpBFqjEfJxwPt6RrFk8A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mddggbepBIxtOLi2jU38TBfB9Myk4NA7WnGjhU4tM7jKG190AtibPCBANPJ2?=
 =?us-ascii?Q?ToBh3EpgkcGFun+CA00391msYAOIb0rr0jZSvtSiTSQpxyw5c2hwdYBLexdw?=
 =?us-ascii?Q?LIQP/0BIZPNOxo20mBra+7b2ZVj+NR9QZpzeIEppTY30JWLXsp2FCNOQILss?=
 =?us-ascii?Q?8IIU6tJHdV/NCZcfkWAWL2ufNhN6wOeYj/9Qa+TCeqPH+2wcLI2e5sAO2WqG?=
 =?us-ascii?Q?57YCCqa/qd3JIJtt+aPj2wuaKNNVRgNfftvQVf6ae2yfUqfv6gu75NZR+VqZ?=
 =?us-ascii?Q?STvNiZPhsiSCCR4esH0VPZaTBfCAp86ei6EQDGDy0mVDNbW9aS+bi23a5za5?=
 =?us-ascii?Q?dfri8Eg3vvxa+4pNQLUJ9/fIfM2DHRApTDPRIb3nSE0siTMJZIEh/0VqlAYl?=
 =?us-ascii?Q?gW5gZ4E6MUgXRc22GMh3zfwUnco5hZ0ZFrV6FLKSdYmwhGsZ0hqdy2eSgLTx?=
 =?us-ascii?Q?JiYnSzsV5bNB5MSZXg0FKjYZnP6C5U5Pk0/4hcf+shiHrLrxdG0vkvnKywh9?=
 =?us-ascii?Q?anxXkOTNLRKlD6vlDxccZYcO6Z2LCC2GNX8q+8hcZ1nF8wojePtTdZFprtAV?=
 =?us-ascii?Q?FpQvAYVT9yHPp4DJW++uACiGowDyYUruxNK+8uXdROjMUI+XwFJH1U0c0HFG?=
 =?us-ascii?Q?wCIXt9Hlp8YC4RFSNGHuyZLqLjsDoNbstfjalgqK0TnHKocfiSElFPXYvXv8?=
 =?us-ascii?Q?8itWotdI/9nqC38tUuGMKRDkpxe//QAwbEBbGtNbd2BStAZh2necS0L7Dzgx?=
 =?us-ascii?Q?bThiKIcXXFviq6CZhtmQD1afEJQlk/An6WM/trZCAXR8JOuOUUWfSNUk8Cjl?=
 =?us-ascii?Q?LfFkbpCfhmOVckC3aIf0H4iH+9mq9Ajiye90QXAWAC+8xvn3oFsn6JbG2WLl?=
 =?us-ascii?Q?hHfB5YpKPthj6qUa7YftJCMLUvbDIFqPezxvWY0SGbWWZ9GH5yKV6hMTpiIO?=
 =?us-ascii?Q?I953wWNyuWq8eJEGP0yZki3T63pssM3N8l0Cd+b09LAFKlmkFkMJCn76g/0v?=
 =?us-ascii?Q?xkV9plVJhTp7W7uGTXT5Kv9NLBaG0UrUvnEtUkykRKZ5cLcuORxoSTIJ0GDz?=
 =?us-ascii?Q?zC+WsL0tPY9hihir+Rs1Z208d+yCQbS4nfly9LtsQx/pBm/YH608Yv06MM0H?=
 =?us-ascii?Q?Ni5KdxTfKlKqD9jgpY5+78KgzpPP3QnNXq2BybsYoEEQBnsy3nNIFzigGywj?=
 =?us-ascii?Q?3WgQa/0ZyoknnAQfJui7n4s2Zl3UQ9KS+c7XznI+QBMl2WgyoGcBJyEBg+/B?=
 =?us-ascii?Q?eNBfzulOkl7sX6SLLC7WhwObLGBdya9FTA2cYhhp4Ct2rB0wTelL8pmokrj2?=
 =?us-ascii?Q?tDbhwWacNdhHOKsbMymKvGn+7MI94lazNFkGjWA6hQ6OwU8gYpp/X+qFLIJX?=
 =?us-ascii?Q?AuiCEonjc4jXmgIitbAwbl4BTCoMJEzSzisxsOPadSOIOntcq3Y7T9pr4l00?=
 =?us-ascii?Q?txED1iPIKbhPB9W9x53OC1LlcCmmyRMIAOZli3mIM8rUyvhkbGWMb2aZM4gQ?=
 =?us-ascii?Q?w6ovCatLHVIQpEsL3epowbqKUU6QqGH/Z8pzbh94wErq1JvsrWsSSjX5Gdlu?=
 =?us-ascii?Q?UuiAkz3xP8kjTSqmUeBbWxxJlyy7VGXR25YII7pF?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB6804C2943ECCBB883C418EF1FCD02PH8PR11MB6804namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda59090-0de0-4902-f69b-08dd6141f5ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 08:43:27.8873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXP4uxP/yrihv8hhfoxVAj2gttUtKi1FvE4/AaZHtG58Jj7jft3FuNF6SFpbhzmQxg+7JFFzSnu1SLzXED5O9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5995
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

--_000_PH8PR11MB6804C2943ECCBB883C418EF1FCD02PH8PR11MB6804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-03-11
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
* Release Dates
* Subtrees
* Roadmaps
* LTS
* Defects
* Opens

Participants:
* Broadcom
* ARM
* Debian
* Intel
* Marvell
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.03:

- Proposal deadline (RFC/v1 patches): 4 January 2025
- API freeze (-rc1): 7 February 2025
- PMD features freeze (-rc2): 6 March 2025
- Builtin applications features freeze (-rc3): 14 March 2025
- Release: 26 March 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * ~ 9 bugfix patches.
  * Some patchsets awaiting requested fixes.

* next-net-intel
  * Some minor fix or doc patches pending.

* next-net-broadcom
  * 2 fixes pending.

* next-net-mlx
  * Some fixes merged for RC3.
  * Some other patches pending.

* next-net-mvl
  * 1 more patch to be merged.

* next-eventdev
  * PR sent.

* next-baseband
  * 1 minor patch to review and apply.

* next-virtio
  * 1 patch for release notes pending.

* next-crypto
  * Merged patch for RSA.
  * Cryptodev patch for C++ compilation.

* next-dts
  * Testing last 2 patchsets.

* main
  * Working on series for MSVC.
  * Working on symbol exports and versioning.
  * RC3 targeting March 14.


Other
-----
  - DPDK Summit 2025 will be in Prague in May:
    - https://events.linuxfoundation.org/dpdk-summit/
    - https://www.dpdk.org/event/dpdk-summit-2025-prague/


LTS
---

Backporting in progress. Current LTS versions:

* 24.11.2
* 23.11.3
* 22.11.7

See https://core.dpdk.org/roadmap/#dates

* 20.11.10 - Will only be updated with CVE and critical fixes.
* 19.11.14 - Will only be updated with CVE and critical fixes.


* Distros
  * Debian 12 contains DPDK v22.11
  * Ubuntu 24.04 contains DPDK v23.11
  * Ubuntu 23.04 contains DPDK v22.11
  * RHEL 8/9 contains DPDK 23.11

Defects
-------

* Bugzilla links, 'Bugs',  added for hosted projects
  * https://www.dpdk.org/hosted-projects/



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

--_000_PH8PR11MB6804C2943ECCBB883C418EF1FCD02PH8PR11MB6804namp_
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
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2025-03-11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Broadcom<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Debian<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Marvell<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 25.03:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 4 January 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 7 February 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 6 March 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 14 March 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 26 M=
arch 2025<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~ 9 bu=
gfix patches.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atchsets awaiting requested fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some m=
inor fix or doc patches pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 2 fixe=
s pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some f=
ixes merged for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some o=
ther patches pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 more=
 patch to be merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR sen=
t.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 mino=
r patch to review and apply.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 patc=
h for release notes pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Merged=
 patch for RSA.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Crypto=
dev patch for C++ compilation.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Testin=
g last 2 patchsets.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Workin=
g on series for MSVC.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Workin=
g on symbol exports and versioning.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC3 ta=
rgeting March 14.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - DPDK S=
ummit 2025 will be in Prague in May:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; - https://events.linuxfoundation.org/dpdk-summit/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; - https://www.dpdk.org/event/dpdk-summit-2025-prague/<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Backporting in =
progress. Current LTS versions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.2<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.3<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.7<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/#dates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Debian=
 12 contains DPDK v22.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 24.04 contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 23.04 contains DPDK v22.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RHEL 8=
/9 contains DPDK 23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * https:=
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
</div>
</body>
</html>

--_000_PH8PR11MB6804C2943ECCBB883C418EF1FCD02PH8PR11MB6804namp_--
