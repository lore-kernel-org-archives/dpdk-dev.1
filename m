Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F22C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 01:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 658B8402E9;
	Mon, 10 Aug 2026 03:09:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 2B8F4402E8;
 Mon, 10 Aug 2026 03:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786324150; x=1817860150;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=84biAA3DWJafRTVFGMfGZohzL2v5ab6YydWHhF4bQOM=;
 b=jlY6b0F42nbUXA91nNmtopPMbE5nDt7lt6KygqSHp4IUHkIR9h3kgLnB
 Djab1Dlmk1zz9+FkndroAIQD4Dl896mZDrwaT351AVEuPKrS2Cg9OSl1U
 KMkJt9w+qu/3l/dKsep3QpjfqqXPmPjJgscaaYXfKOWwqVe/E36u9nkqY
 fIH135woIRK7aqadIuPi1p/0Drt5fBQ3c8lDRfsG3JaAzmyrm0plc2Xka
 K0Qa25HWrV7Dbn+BfIvu5IW3Z6kvBVLOdBxEhD2BgoyYDTjdMQiYuwRz2
 H7F+g2CJeBxewUx1ooS4SyYoLxDSkjFA3ePHWPe9iBUivh6kU7K7akT0p g==;
X-CSE-ConnectionGUID: SE1FCnCMQxWhQ09hM061XQ==
X-CSE-MsgGUID: SsKHfUpXRtaMQRgFh1mQXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86907105"
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; d="scan'208";a="86907105"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2026 18:09:08 -0700
X-CSE-ConnectionGUID: 1Q+mdc57R9yQkoi2/M7+gQ==
X-CSE-MsgGUID: 1SUT4TLDQB615YZsx5WEqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; d="scan'208";a="268061782"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2026 18:09:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 18:09:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 18:09:06 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 18:09:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MP1TQx+JG4dVqgcSEodXwtNrTLPUJYyPkyltZpTSt79+sVS0culapyPyk2hgjmgspTVdcNSxCVz46IDqotfA34ioQ833ZUkZp0RFGlAcj+pebjjA45tfFvYKm2nSKZYtgOFOwac8fGPRn8D9MEAVElS7vynymcvyTaIroF+7Dlspv7kWlGeHVMdYIv3DNYcMP1ku2tT1Wf5egxzvdVuHe/faUR3swkrzNbTZNrv+CVDfJQ+Gi+GkjgnJXxbR6l+SPI7qi4cFuzcI6ErHeinWm8i7X9CCbaH5WR31r6WjvrxnE2Jsw9Apsm8IshL6LkgfyHb1CRFoaa+UyNswfQRgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi9L7SP3ScaBEcrNMPcbTGkmYb54aygWiOYRGxyXzKI=;
 b=V2bllz+qYmvrhUD2B3CVVdWl3bxrpbF3+OR0adbuH/ULF2wgl5+5Jtn2tLovAcZ3b5ONUokClAqeqnxhasD8c3ONAtJGTaL2y4WtRLTOuy5eEgB1FhkYzgJpq1klZW7R2++rWwAHOf94G7Pf4sTDC7JpVNYKWiL9PomP3SfoePDrtJR0HHvI4C/3g/xcOa1pNIq/8eIK+/DCSRUYah1I7CB4KkQjZ258WYpC2+iFfOswJvt6pJlEIAMKCin1Xa+wIUsY0WG2F1xkNg+092pU0IQ699/qSyHI8eciKNf5fnIVOW6fflJY27g/Qp9chgjWHiOzgGQzQhkUesV+MeAL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 01:08:56 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa%8]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 01:08:56 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: "luca.boccassi@gmail.com" <luca.boccassi@gmail.com>, "stable@dpdk.org"
 <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, "Agrawal, Hemant"
 <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, "Mcnamara, John" <john.mcnamara@intel.com>, "Ju-Hyoung
 Lee" <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>, "Luca
 Boccassi" <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: RE: 24.11.7 patches review and test
Thread-Topic: 24.11.7 patches review and test
Thread-Index: AQHdHaxnpcFPnc/buUCHOhfoSOv0t7aWjYvw
Date: Mon, 10 Aug 2026 01:08:55 +0000
Message-ID: <DS4PPF00BBED10C46A3A7E83F35B88C059E9FDE2@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <20260727094306.41797-1-luca.boccassi@gmail.com>
In-Reply-To: <20260727094306.41797-1-luca.boccassi@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|PH0PR11MB7521:EE_
x-ms-office365-filtering-correlation-id: d06601e9-b20f-4bd6-1305-08def67bf380
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|11063799006|56012099006|10067099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: jdS4KvKgvCSWDHXxEStXhIq6VVW+QqX2zW2oY8lFKUJF2jQdkjgxE3ddvzLpx1OJt6a83PS4LHm66qy7B4lKtI2YK7bdbLPYiy8UG69st1eXcUXXwEO+xLuqY/DiFNvOsA1yeVare49W454wDHbUEfkxwhx+MnQgLjfDTk2uNnEhIrFcox3XXvf0GB3aQILoIJ36dgUknFItfbtG5n23Le6s6r9IBP59jP6EnuaiiXqOYtlMVWGnKFROPOuoKipLqG9xkMPYzZsItONXfMAhB5GND2u39i3z6oQjMEe+/nblUjvrzl8b1qtesXJfWzT5bmo8binc24Me9OKqkp7r3/zt/Gv+EF62IouoxRylLvalectenekhb0v0hqsPr3DE5XoszL9kWkVUofH2F/wc4pfCTqWU2DPFVuY96O5TqK75r/NXYpE2D8z15fdR5k6LpoI6lNo2lIgdDymab9CVhJasTuurkn4PaCnYKYpeUkNlA6txua17Gt566E9KkmS3K/egZcxr8tlwXfOtztLTBQtOvCsENgzuv2TefR/IFsjdpNLm6GxbUOreQpjeaQbTcVU95zgpKCY2vIrXN98addhrGuVCk28BPul9AzXUUjIar3X0suYh+M2D8d35DLq+5i1aEqRVdnxa+qDF67rIVGxz0DdX0vgHeKjUze3OZ83iSagKGz3YiTYHusSTnjGOb+NmFnsQVA8E8EGWrRtVNKgfcDn0lZE/G0h7wIfjjLE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(56012099006)(10067099003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v9E7CO7y+lFbCn/4C4wZm4WWxGCakjGs2cL11cgYjHWFpfLcj1Vb374FAdCx?=
 =?us-ascii?Q?M2jxCumMBxSO1P19V2KVobvNKLFcgM6bbVd09lr89L386d+u9AlmBEvax/OP?=
 =?us-ascii?Q?MpQwHHEb4+KowsRjZrUTseB1o61fVo8zqEH4FbqoZu1bgDp4GUadK/+MlEO3?=
 =?us-ascii?Q?YXfYjc/cGbSPrji1xnSX5vt8cKp8u6S+pAjNjp862rmQjEo1llDpoYccHIDT?=
 =?us-ascii?Q?vGsaSF+mP4lRfqLaLXGW01UwdYDBwBzkIVUrZxPM8S1xGR9VafOzWmPyufc3?=
 =?us-ascii?Q?THiWXGIQEZOKIzaXJzExRAwuz8VCkZ/TqnhcuSYSmX+Xer/Z6tDUSnJcrSay?=
 =?us-ascii?Q?colxyptZMN1agmcnMm1mHYwKzAJjoFVte4Ltfqfud/G6KSopHsZlkBpbyOpe?=
 =?us-ascii?Q?1jKJ4DNwL7kUQGW9kilp/HcL/o8rYZFts9TtFuX62ILGbE1Lw+EuG4pLrO/g?=
 =?us-ascii?Q?dhJOK+GbgDgmG1fgy8cMCRPmmxATny1eylOKbYVOieLnGCJXg4J81xQakBlJ?=
 =?us-ascii?Q?nct3yYgnE9G5uIlOQOVXe7rkthxaA6L9vByrqQ5ZaNZcS2o3pgFoAWu6rxRd?=
 =?us-ascii?Q?zPaxi8dNg3gt236d6Nf+0lWgoQt0TyBAyJihUlljFmYdMoOgagAXifv5Fih2?=
 =?us-ascii?Q?p4T9iBLw+IXq0oO7JolQZCtM++Ugzw4mKBlQDo1yK4aw4AMe7Tg6Y6buNhkx?=
 =?us-ascii?Q?aqz9ygwHODKTCr4KUznf7yUN3mOza2tjbSuaDE3Abai3KxCmhW7XRrIS5QHD?=
 =?us-ascii?Q?KjaSC/lI/sXpCpP7nPunKAjctcu7gFCvUpRp7timMX+LpwLNqtblf1Px2yXp?=
 =?us-ascii?Q?lxF5Q2pgRWQnzXtHmTxJqEnVdPjUqkPwXW2GE02ZQ8prMlpnuLwXbDMlKJA5?=
 =?us-ascii?Q?uvgY+KdZSFZWy46+bGldOzztVq9ZKrZdI5cZ1N6z8vLiN+7FigxbFo340w3+?=
 =?us-ascii?Q?2CsNLXyfzwlSeHsVG9Rd0enOeKTkb55lxTWCUxGy3HECBK66I9QfplEiT2oK?=
 =?us-ascii?Q?QE3ZfyrTzwDoa6a4wnOMwzXI82qt3bFhyCor3k+8/bW9GlT91of8VfoLAT1/?=
 =?us-ascii?Q?I4qrGucl384rYuVjFDM1+cN0mT5oH4MEsycURwqLbiRbMubl4GwAn6cFTyzE?=
 =?us-ascii?Q?KEjv2+IcASICFaiS0QPSWQTSsdZIit9eYFkl/HYiIS08iT1qKJejjTWYVOVJ?=
 =?us-ascii?Q?S/p53wYKVzFejz9J9XtqKG7YIAnaKmAZh8PPv24xh23sSFOMZ2bymqtog1R2?=
 =?us-ascii?Q?HcgB9BFkzdymo41yrGe0B0cSfiuHBZXDH0glofSV5RPjWM09SVTquJReRDJw?=
 =?us-ascii?Q?0CGwaR2eJDTVMh5jEo0rNB+6HxOaZykPkdvrfq4C0KGu/6u1cCsZViJ9EYkg?=
 =?us-ascii?Q?mphacJDbR0iWXZZX33Ia7yX4IAIGNXMLnq8D/aVQj4igwHRXmc7LlbAFKebL?=
 =?us-ascii?Q?BrksNvFjZFZcoN8r654kt0EB61klASafNww6Nwlsw3k6eltt89N6bH2OiyHf?=
 =?us-ascii?Q?czb5me8cz/j0NgzbqIUb+y5mdL/1bfY9mPnDiI1GATi2hVGTAbiyoQu64M4f?=
 =?us-ascii?Q?UNezfCi/e48LLHMwhbcnDlMdzZ1OjUIlgBn436MIhGzPkKa3hqBEiOtAx7+p?=
 =?us-ascii?Q?i5X0gZzAWmtlQpmULxnVR+tqgfQl3m1r54X4Vx5Jq/qJy0yTjkCzMSZ9Rl5H?=
 =?us-ascii?Q?ulJyuAhs8pMS+kVjVkoxBVG0ZxQLJL9PLdUBPeAiP2g4Ksbc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hmwu45Ugd5by8tRdGpE7q6z4692LkiDUAp9GRqdoggS322o9BQF4TU6QXK9Mj4Us7BOWc/UDqY8Yn+N8XtAUOr3WOn/73+IJXa99hLCBPTMbJkij2OD5KDmgReU8+NGk6qtpKVW58521LX0wJP6x7j0eUOfltND6sgd9R7YkXYwB4gNywe5H9rJmxND1dBscROU6i3+95euo3gfLRpz5m5/8SSeKC0qmvoLJ/W3dhmSrQ6v2FiGjVxc/9Dv3JO6czEz473lbezJq9xMThfd1avgaRrosUgs2LpE6zkUq15bAdwXEwC6twOwC2W9RqvtwztFITtTMPrA+xfYoxqWzMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06601e9-b20f-4bd6-1305-08def67bf380
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 01:08:55.9264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gneMxvKC/32eZFf25GTQLU3CQRG+8DxydtsbIUbu6KqtKU0e+EZbkbPwYmSfF9VnVMj5QsTrWFd7d88iRb75A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
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
> From: luca.boccassi@gmail.com <luca.boccassi@gmail.com>
> Sent: Monday, July 27, 2026 5:43 PM
> To: stable@dpdk.org
> Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
> Ali Alnubani <alialnu@nvidia.com>; David Christensen
> <drc@linux.vnet.ibm.com>; Agrawal, Hemant <hemant.agrawal@nxp.com>;
> Ian Stokes <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>;
> Mcnamara, John <john.mcnamara@intel.com>; Ju-Hyoung Lee
> <juhlee@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>; Luca
> Boccassi <bluca@debian.org>; Pei Zhang <pezhang@redhat.com>; Raslan
> Darawsheh <rasland@nvidia.com>; Thomas Monjalon
> <thomas@monjalon.net>; Yanghang Liu <yanghliu@redhat.com>
> Subject: 24.11.7 patches review and test
>=20
> Hi all,
>=20
> Here is a list of patches targeted for stable release 24.11.7.
>=20
> The planned date for the final release is 2026/08/10.
>=20
> Please help with testing and validation of your use cases and report any
> issues/results with reply-all to this mail. For the final release the fix=
es and
> reported validations will be added to the release notes.
>=20
> A release candidate tarball can be found at:
>=20
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv24.11.7-rc1
>=20
> These patches are located at branch 24.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>=20
> Thanks.
>=20
> Luca Boccassi
>=20
> ---
Update the test status for Intel part. dpdk24.11.7-rc1 all validation test =
done. found 1 new issue.

New issue:
  Bug 1974 - [dpdk24.11.7-rc1] DPDK build failed with clang on Ubuntu26.04

* Build & CFLAG compile: cover the build test with latest GCC/Clang version=
 on the following OS(all passed)
  - Ubuntu26.04/Ubuntu25.10
  - RHEL9.6/RHEL10
  - Fedora43
  - FreeBSD15
  - SUSE16
  - OpenAnolis8.10
  - OpenEuler24.04-SP3
  - AzureLinux3.0

* Function tests: All test done and passed
  - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW/TSO/=
Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - IXGBE-(E610, 82599) PF/VF: test scenarios including basic/RTE_FLOW/TSO/=
Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - ICE-(E810, E2100) PF/VF: test scenarios including basic/Switch/Package =
Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descript=
or, etc.
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
