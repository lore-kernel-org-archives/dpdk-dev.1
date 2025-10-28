Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564B4CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 14:53:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 982A74060B;
	Tue, 28 Oct 2025 15:53:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4A313402F0
 for <dev@dpdk.org>; Tue, 28 Oct 2025 15:53:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761663182; x=1793199182;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=/JMGexXv9GyY7BbNm6WyPSbLgi9ZigAy1YU0TJKJKzg=;
 b=e+hP8IY4oYg4TXdEMr8zdyMZfDBRfIM6Z/CLWGhopqoN7Juk3vI7fekk
 TvqfCmdNHSjUCWYAvWAsPUM85VHfNabyLs0wOu3ukAIColK6udtQ1JhEx
 4GLu0zt/ow0MCL4y0TRyYGC78NeEvXKhev07whdGV5GiuxI1WMK73Xq2j
 7Q78ekAIzyYAlWbJyv60rILpq5Reib7jBHps5VvQNlvr8u7kViXs7t+zi
 VAJ3frVPlm/TQYhMHZGT5YG+KtSsyP0fPvLDH8/ET812pE0nY/hoq9A/Q
 ljUWdEYE4O23N6sHdsV18Kr6bxJExTfUPkND8BQjuBLBNYrJoeXWBBsXB w==;
X-CSE-ConnectionGUID: Ye1ZFMfERl6cwI6ra8OmsQ==
X-CSE-MsgGUID: Z80VrMZpQ7+8S2LiEzdlJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74364376"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208,217";a="74364376"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 07:53:01 -0700
X-CSE-ConnectionGUID: qvP3q36pSJygq+IC4FrZWQ==
X-CSE-MsgGUID: 2LqzGfimSCKLx+yuIBh5cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
 d="scan'208,217";a="184545489"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 07:53:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 07:53:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 07:53:00 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 07:53:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfAa2Gywfz5K1I/Dx8XnOCyIcFmxIa1hWIk4YspYOPdUqnu7EyxSKgcYWDTcoCwx9ufl0jocj7taYA3OVD0Yblq26f4jp6zmTGmJMy9fVad5Oq+ej1ciaXdxK4r/38TduVOvUXrY5V8rPhDFAYLDo6pTBAx/xuyhTQoqlhAlCEveHpbzyR+9O9iYCECK5czRhdnWSs7DI5ztNNW0B+tfEZ48kt81SypoBIzeLKo2D4tYa7gVGG3LwfagYO2OvPiFsEYOOQzMEUIFMLcHJcEpRsMfXBh34qJ4zUO1xs0ouOKrICpWrN74pBMGBdtuS8NCabfb+ieSyNl7iHzjZiqPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhbHhr4xgVe460ffsAtqhZ1b0Vu8sOf2ZLDEhJE7CGg=;
 b=TRGiSeP/oUYnhz9VRdo0pRgSe4MeEq8fQw8xOwQ+uvAN7kotRREVTTcPOz4GGYiS/lfVlPbEm1s+B8xRGpnUKrwocBUxCZNAhFmBwIqMmK0h3L6sP5MxicfIclkE/3VXe6Bcn0E2DuliR5Ob8wAnwRvFk2OsVCrCfLjptOJk+bdHMJimd5qSAZOxyc7ZCjw5Rz9Knp9p2JkfAwG0eKqq6GDgckXo+zIGD7cqDtpS2JRFZaYxLU3q/YU5mql7bgS5NGEqkHQf7+luIAQGRQwErtIG3yDGDVa9fUSRBivPwabEmZ858NIxqrc/ty2bl1rJC/4u+8806RYry4LH7h0mgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by SN7PR11MB8262.namprd11.prod.outlook.com
 (2603:10b6:806:26e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 14:52:53 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 14:52:53 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-10-28
Thread-Topic: DPDK Release Status Meeting 2025-10-28
Thread-Index: AdxIGm0siFGKYaRcTkyGw7D1j6sUWQ==
Date: Tue, 28 Oct 2025 14:52:53 +0000
Message-ID: <PH3PPF37F43E35D6A4015F36A3914DCE4DFFCFDA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|SN7PR11MB8262:EE_
x-ms-office365-filtering-correlation-id: d10b1263-eded-420a-5989-08de1631ac53
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nPr83AAFZh8RLblAzk0IfAin9TjUaQJKjFmmocESKr+9n2nNWqkY7bDUyWQI?=
 =?us-ascii?Q?xprY+fVPZxWevqU8akJ1f1a0ydpPGAuAyRpXLwObrZXZQNhFtvnHb62JCYJd?=
 =?us-ascii?Q?pUiXZdkIfGrBOoVM/mAvJQqkTxsWVUGABer1gc6LCGtABH1bbpzFWjqNSMHn?=
 =?us-ascii?Q?QJCU1XNb0obj5dR/6ebRiK7nGEifU1QeNWNBtXBQIjVBA8wkhGTnZnobIB2b?=
 =?us-ascii?Q?9Vrfwc+U0pjEhbsGLjZyCF8MWcZ+rtiaTEMTCIIkaqvSfBe5dr7oqLWqSvv+?=
 =?us-ascii?Q?Rh7ZYPROBDUjKU5BZIJnIuL3Tujbp9oNHkSV8NPvbvHi7BLJC/tlJASYp65K?=
 =?us-ascii?Q?6x976j8wDAeB92sjXTeGj3FCspiZTtwmtG6ekoH2/bdMbAyJ8Bw+kYhUjHXD?=
 =?us-ascii?Q?TTvvui69SiZ8mz0lBVxCt0eGDYUIyHIUjijyfHdiAypsg2yD7niXPw0g6HXO?=
 =?us-ascii?Q?TpjRcgJRBgNXwZaXOx9szsMn4xm4K0LdVa3IilshIxrc9kIGMdUDYiJhHTir?=
 =?us-ascii?Q?MnthgmVqwBdYySiMCEptlLVpBYVKGQHW/2GKcOEjAbL5uG4iwEb+un2mPcGl?=
 =?us-ascii?Q?kX2vfej5482DXfJSgv5g5jdTxoVb0UtJ73M4S1WKTYav/O12JaE8bXxoWjym?=
 =?us-ascii?Q?o0rvxqqJ78vS9ybyOzGEBViHgRPnXUT9UbBkgDV6uXvt5pji9KcuMiq8a3GR?=
 =?us-ascii?Q?zaNXrUXcmY9HRIwVPHnB3rh+BruTQbFWaXRVeSentkbDQB7Pl0IkDvTj/lTl?=
 =?us-ascii?Q?2VhGgdWmCzlzcH8T38gtv4Ts8I6U4Nbwa4zfergZ36TdoG0F5U+awU457jhq?=
 =?us-ascii?Q?VBWV86IVEn5d+zbet2kmQDJb/n+QGQgfz72UF+cXPsjxIk7FW/qXKgX0IIsW?=
 =?us-ascii?Q?oaLFjcLfg77J7MqlMLzs7h8EJUUTz9iZ/jKxtLfevZkakgQBAXBEPbQgC2q2?=
 =?us-ascii?Q?tjS/QEWhYR/kA/6ku2sWzDvIhgwUc6+3k8qMcgZBdlAHSVhoktrjrlJjWWfR?=
 =?us-ascii?Q?u+R2UdTIb1N9KIWxjI/KhGVO8IHvN7azD981rJ3x+Uo391RI0+ulmydx7PuA?=
 =?us-ascii?Q?S7AteO7L3YMUFA+cy81fwfVbjzc8X8XlGOPIeRKHMTA1OQdNoQ7lmE1ocLRz?=
 =?us-ascii?Q?SGT36JwsQuXyQweZRCEiG2Aa91vVvCNZm3ySLf0laRq0Md8vlUikhN9XbaEN?=
 =?us-ascii?Q?sHsHN2bsm6lOygEVB8aROei7A3Q496wpdmwBTnrgGwigW781db+kPDI09lJZ?=
 =?us-ascii?Q?x5e0XCQOykNqstPOH2VJ9Qbh8louoTxR/VgK+HSQtxHSpy+WG/MpU2Gj8aju?=
 =?us-ascii?Q?d26DPrNr/OFevZTTTfVzQm9XF6g9e7fvjW35BuI0FnnBISEL2yXthAqOZAqv?=
 =?us-ascii?Q?vp2S6C8i8xYTzFLrNUJ8UgmJLrS9wSwTrtGlZYeTTjpnsQRUQ391RJIK5itP?=
 =?us-ascii?Q?gVQnik9NBHN1UcKfyynx/HX2EqbtOV3csW9lGhl4sQk3jUwBh0ZveQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XSdptegr5ID9iymv67iHStoMDr+guhMUwOc3nSwD8vv5MaKtK6iAjMalceAL?=
 =?us-ascii?Q?qYp4Djdz4n+AO0KhoMdG7Fd5GXsk3nm1aoW55XhI2s4UmFODe8fJVmGDthB9?=
 =?us-ascii?Q?F+hBpmovOL9QfPQZrC5Rv0GBY3FYqkC+CBJRFXU7k6PGJA3GHYf86GruXURO?=
 =?us-ascii?Q?7Kn8T8Mo8wMJS+GaccxKrT0kPG7QIJbdOM11NXvm40QINVl7R0fEQqksq9Sv?=
 =?us-ascii?Q?abhoa/My0raphxSVzaDyw9U+wSmYMnsMq1eC3ywCBtx3Ch1nyHmnMVPRyomf?=
 =?us-ascii?Q?mAxElY01COeuAMfyn0zcuTrEibUShaOM3nX7vyK0FLwhibIow0DN4LXYkDS9?=
 =?us-ascii?Q?ru3YKEBS62PCwk2ytF+ZMuhT+Gi9GyW4wpaCvjNbFVOuhquZ7D/mPKJToM/S?=
 =?us-ascii?Q?HDcPi6I/FkUn1/2E4iL5IkXFe9KiWCxEUh9NyCTmsJrPBiYlu5NTZJVMq9PD?=
 =?us-ascii?Q?zABNwSpG6y/k7jXBtBUL6QxkRP17GNGAo7wTLmWqqzyqQs9Ff3rxuEgINqO2?=
 =?us-ascii?Q?rKg79gxzqMNF0depeoXsWYmU5zLwOmJZNsRhutVyC50uIdbARBPz5p4tav/M?=
 =?us-ascii?Q?k0b1DEOwcSFvP5LAPaNdNZyGVriNNlKEVr6YjhhQiszCGBP1sQbPqeODmRAB?=
 =?us-ascii?Q?GsE86/WYGTk6dwA8Hy9QM0rMNu0iicwXbOHCGBSkFgjnXaqIRq/OKlv/+cnK?=
 =?us-ascii?Q?3uqp+LlZ1RXmZ36tzNQCNnaO64UaZtQ82h6IJJSARTepzT7aZ9jS7q0Xvzjz?=
 =?us-ascii?Q?l+WMfMfhwHYWkx9bp/xeBcdIFbaXQx25mp3ju7a5SgBuZvb3X3C3ifHwLdzC?=
 =?us-ascii?Q?YcN3hOSsK8BwymxZhxyeWJ4Bn+EGgN7A5NRurQmcPD+aiZz6svhKMXkUpr3S?=
 =?us-ascii?Q?SqI3ksX6aVPHvmQqcpTIiZiK9tATOfjE45YORCC+ky7zH8VevD1w6VS0exZE?=
 =?us-ascii?Q?9FNLRbN5fOcqfQCyEBz53xGz7HVyB5jgsJoCkbyJkV9C8xL0B6eJNHBefNIn?=
 =?us-ascii?Q?o2URkcnxSBSoFUuzqNKNGuTaoFU4J5chUd6LMpxG7iBDuZkRsWNAY4YlUxAn?=
 =?us-ascii?Q?FU/UNl5xbSoksNlEAMgxOwX0CwoYxYGASyMUUx8WkDlBiLJ13AJQDCiADcRi?=
 =?us-ascii?Q?lAole5JixgSIMNf+iRH5DTymd7hQPG2cxTSos7wafacfQ94aLglssYqGlE0X?=
 =?us-ascii?Q?WItr/e5/e+DfoNqcH50TsbautS7wC39WX/g0O0FrP3JMc0NsTQnfQqsTuMQZ?=
 =?us-ascii?Q?yrudJJEnOTShjn/Kseo5FvCT4oIE7Rk9H8HqZ01UkAmun8VFoazwgwupkjSx?=
 =?us-ascii?Q?4LmDr7BGrc1jfGp/YJECLGA9sHxZQp4VERP+8MyeWMUMo4UuQgo6toxJk14v?=
 =?us-ascii?Q?HanFW0Rb3VcZmJprYzsYXO1u7sSJRACUr4vhsA0Yo4I8SzbLBVOo4mhKtvV5?=
 =?us-ascii?Q?H3r1loE+iv3sv8i/ZdpHgtcX3/1mX2PsaynxgVYsAJg8uC2BOHjfKDzHJYiV?=
 =?us-ascii?Q?7c/IyDXGg1V6v1uJ1ryCuhwkMTkAFVV+Dc5UEDJYJQhzEgNDnDahPV7IBXQY?=
 =?us-ascii?Q?nWplDciALKQwVCyx+iU3ifKAIPtVjF/Ka8HVmRRh?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D6A4015F36A3914DCE4DFFCFDAPH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10b1263-eded-420a-5989-08de1631ac53
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 14:52:53.3135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90WSl66MnX+Q7N/yJ5X5/zwn5hk4z6GjCsrYUliSbwyBUMDV95iEtl8iSWCa1VXoJBC9EUi7Zr5kQGJMsCIGgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8262
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

--_000_PH3PPF37F43E35D6A4015F36A3914DCE4DFFCFDAPH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-10-28
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
- ARM
- Debian
- Intel
- Marvell
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 25.11:

- Proposal deadline (RFC/v1 patches): 31 August 2025
- API freeze (-rc1): 24 October 2025
- PMD features freeze (-rc2): 7 November 2025
- Builtin applications features freeze (-rc3): 14 November 2025
- Release: 26 November 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - Merged to RC1.
  - 36 patches pending.
  - 11 to review/merge.

- next-net-intel
  - 1 patch outstanding for RC2.

- next-net-mlx
  - No update.

- next-broadcom
  - No update.

- next-net-mvl
  - No update.

- next-eventdev
  - No update.

- next-baseband
  - PR ready.

- next-virtio
  - There is one fix for VDUSE that will be needed in rc2.

- next-crypto
  - Some Coverity fixes.

- next-dts
  - Due to merge Rx/Tx offload test suite.
    - Investigating CI issue.

- main
  - RC2 released 24 October 2025.
  - Some CI issues under investigation.
  - Outstanding work on PMU integration in trace.
  - Updated RC2/RC3 dates. See above.


Other
-----
  - None.

LTS
---

Released LTS versions:

- 24.11.3 - Released 2025-08-19
- 23.11.5 - Released 2025-08-25
- 22.11.9 - Released 2025-08-19
  - 22.11.10 released 2025-09-17 for CVE-2025-23259.


See https://core.dpdk.org/roadmap/#dates

- 20.11.10 - Will only be updated with CVE and critical fixes.
- 19.11.14 - Will only be updated with CVE and critical fixes.


- Distros
  - Debian 12 contains DPDK v22.11
  - Ubuntu 25.04 contains DPDK v24.11
  - Ubuntu 24.04 LTS contains DPDK v23.11
  - RHEL 8/9 contains DPDK 23.11

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


--_000_PH3PPF37F43E35D6A4015F36A3914DCE4DFFCFDAPH3PPF37F43E35D_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
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
meeting minutes 2025-10-28<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Debian<o:p></=
o:p></span></p>
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
re the proposed working dates for 25.11:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 31 August 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 24 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 7 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 14 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 26 N=
ovember 2025<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Merged=
 to RC1.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 36 pat=
ches pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 11 to =
review/merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 1 patc=
h outstanding for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - PR rea=
dy.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - There =
is one fix for VDUSE that will be needed in rc2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Some C=
overity fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Due to=
 merge Rx/Tx offload test suite.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; - Investigating CI issue.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - RC2 re=
leased 24 October 2025.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Some C=
I issues under investigation.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Outsta=
nding work on PMU integration in trace.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Update=
d RC2/RC3 dates. See above.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Released LTS ve=
rsions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 24.11.3 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 23.11.5 - Rel=
eased 2025-08-25<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 22.11.9 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 22.11.=
10 released 2025-09-17 for CVE-2025-23259.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/#dates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
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
 12 contains DPDK v22.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - RHEL 8=
/9 contains DPDK 23.11<o:p></o:p></span></p>
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

--_000_PH3PPF37F43E35D6A4015F36A3914DCE4DFFCFDAPH3PPF37F43E35D_--
