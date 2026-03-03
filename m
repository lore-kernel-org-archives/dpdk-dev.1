Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759B7EC145E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 15:01:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3FD5402B0;
	Tue,  3 Mar 2026 16:01:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 59C4340268
 for <dev@dpdk.org>; Tue,  3 Mar 2026 16:01:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772550100; x=1804086100;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=KCJdoICrH1R/6FvSRBqkxgc1/EKlLVreO6KnhmH83pI=;
 b=hdbdJznfL/hQzDvH5rlwKe+HmxJbzUbQ1dDgv4haZjihYzwxtK6vKdKf
 H+KFN6/vuv/4vnI53Qr3k4XDrGzFEPu7fXybEidCMtzeKC4xK/P4TIkN8
 9htIFeLSjbU4IBbJryDYCT4IQ6uX9ARWj73toZ4AZRhXxqOFUiuQ2BFR5
 TRX8dr1kozMom6qyvXoST4aLkuvkMMEtjPrt8/D6mzZsk1ts4PcsjImdM
 SA43QjjP4VbxAsLpIX4tFzZJBk+tlyqhmi8bERnUp3uS50i0nNOH3W+Vi
 NbtXphN/bVdi84IwU6SKtZoNiE7dznNjPupb40sj6fRLaDlHsd++Mlsw8 A==;
X-CSE-ConnectionGUID: 6I82Ao1sShya1U1aZbByxA==
X-CSE-MsgGUID: csLP0pFATPi90bfUcCh9Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="91162197"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208,217";a="91162197"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 07:01:39 -0800
X-CSE-ConnectionGUID: /mJEe3WwRz2K60Q/04kmQw==
X-CSE-MsgGUID: E6HsMnGSRHORk76d7cH5dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
 d="scan'208,217";a="223020534"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 07:01:39 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:01:37 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 07:01:37 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:01:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVh8zLF7TKyfJly0kaPMx4YRft9VsBewFXMINPWlQMjiayXh66U4bS69y2kL5tVySMVPCjDvFHspe1fJWWW1DgaOM1jNidh8RgNdLSrIWZlcFCIg2i9BzwiP13JipvA8rpIeURscg3ezWI422zE4RR4UjXzY6dpEcb0F7dH9TsdUuCoLuHdpYtIu8qQEB7rNhs5ujCwyuvw3jzQ/STW6RzywU/7FmfY5FGU2aj+qkcdyVphBswFgH4I/mqmUe8gqCZDUnU5PYyz4cIJXAwbeBBsyfLZJ+y7L5MSDzqS0hnD5ZchgwOSsGxquU0+DlDswh+s62TxB+Ydf8/eN58FtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnnG9pv/BIDsSAYX5Eeb7RVjfelzSj00GCCoxC3XT3Y=;
 b=lxWi5Tj0+7KMW5TglVWMWlwrvWRNHkkcJSTT3FuagMvjCaHns7KS4EFjM0BQMtVnJXE51dY2/cEsfQUEkv8DHrYTaAtemnfPkaev+vqr+HGSUAmW+HKumyx/qSUaHgXC+6N4gM8Utigwl9EQawMWMlLK/BZJ7YgkWIj/op/p6YI3m7j6L7t6zAfcns/lbyyurRGXyIT9PhlzlLDTWRBx6TMOLP4mGPtpKA+MlWdgS6s+xfymyqWDBKI24IYjKEjez2Yp7zpAJRGZjiW/cP0X5+DyEZnOGVSvb6o45r1TjytHBHt/11vgXtprjj9fCJdvtlRbn+mMpUL9+lfbLfr4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by LV8PR11MB8770.namprd11.prod.outlook.com (2603:10b6:408:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:01:32 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 15:01:32 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-03-03
Thread-Topic: DPDK Release Status Meeting 2026-03-03
Thread-Index: AQHcqx50RnXeA1JRjEenTZsw3K87IA==
Date: Tue, 3 Mar 2026 15:01:32 +0000
Message-ID: <CY5PR11MB6318EB501891A22CFA2F5750FC7FA@CY5PR11MB6318.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|LV8PR11MB8770:EE_
x-ms-office365-filtering-correlation-id: 7080d847-9066-4cc9-7e8b-08de7935c1df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|8096899003; 
x-microsoft-antispam-message-info: sp0KpeGkkNg9n9vVB3g/bQEBnaxIkMrEaXH0dmk05W0uoZExWSLfbv6bZxHhISryzcRl45tky3XEdl/MW/5fUBpEGFLb//a/tthQtrcLfxPtsJewA3WYoNaMUxLJj7ovogIBdzUvtsm/7qAGizzNd1GzEYXQh+kiePgH958pKsfWBrEznb3+Qaxn/Utt0aNIOBpZo6P0OzsDawo8Umxkq3LjxjK0kTY32jN5xRGbkeP8AUZnAqhP+YzyagYf58TkzBzDbIMSWdRs1ZMTqH0rFIaR4S5rAPEIYxSxXb3d/qB4nEzF/uPGDrtSkXSZyNwaDjne1py3PlXUKOTg/3W3ZC4ARW2Pl4gpQALW7b/KWhGaLurGIV3szjq97ktiaF6xJYrbXqShHZLLaheEHd1tptrhyLCI8Q2nig76b41msP0HinVaH74XvqY9Sst84iCWLIxVui2R5tgYiC7eTIHqp3ontFuHOl2dIuIsBtBWuXlmhhJlMffNzgrFfF6b4ITmT2YQ3z5vI6+wBbGhSkC9zfSjfk9XIZ28AaxEr4SiinakMjlZgHpyTYc7vtuU2900YfZAUaK8HO60XCMAQlvCQjOUOQfT21dZclA+K/S1l53kp4X0WPQIZ2NPFp3RY8xFpzbTjZYpXq3VjGCDjFG3A2sp/onsyw48lsr2haTBSX6mSpvngDa/9DFq31rmEmQYsWxG0UItASIaMQV2cDLAVCzRppuWoAOtOVJe8OLWpdsddfg+W5xxkIV3nWWTv8Qu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?o6onQyeULFZn6V7ApASUsw6itt3/KmauPLioXRufLnuxNZt+5E9wdck33X?=
 =?iso-8859-1?Q?uKHpgOU9zw3D1HRh13Q6q1yLRLA+zwPQcN8jXq+GObnk5IjJCoPzqHAmKi?=
 =?iso-8859-1?Q?p38VT7AmfuHDpTeY6GGj8but97CmAcFoj+5/h+9JaAOBvMW9tlRm8F7HOQ?=
 =?iso-8859-1?Q?VvP1BxtRHMMcpot3kiQYkgMDHJB4mhlIrKs880Qt7g3UjuRR/fWbGbwPhZ?=
 =?iso-8859-1?Q?4grXmrLzUiszuM8DhSjHSa9L7tpnghzQDIyWKP6oQcTISTCVkzyLe6MY8o?=
 =?iso-8859-1?Q?RZf16knPTVnM0C9f0EEiSmDbhEuStL7QQlBdh0oeR1h3h+6Y8kIB/QILWF?=
 =?iso-8859-1?Q?CUBf0IueybGepjuceWlDUYkI5k8VlFOGkvj5K07HgMQI5ju+VtbSUb1qjI?=
 =?iso-8859-1?Q?kVmr5T6hBu7ZyCcxvnAY77rBxyo5GhIQRoPqc0S0vs58HUp98HElV8S5OD?=
 =?iso-8859-1?Q?TdpAfjpbhtxPsx6p8M0aejGzI0RU0tjpf13xeg+Q2NsQ5O9B1ZU9Usf7NA?=
 =?iso-8859-1?Q?K5xXmKOKV1mRkHMWIlGp+Nv2PNAbIhb2dU6dwtpqH/W9yY/lYQgqKpN/tq?=
 =?iso-8859-1?Q?ciQ4GomwP+wLGI/R0/laR7/CxCSqN9d/vW/rhvI2ztEzoqv0VKsMB7Bihu?=
 =?iso-8859-1?Q?f2C4HlYLD3C3Q9xQKO5Q+EH8biQYKkSc0HsCYlRnm3vwDQEv8ZTWMvoG33?=
 =?iso-8859-1?Q?Lj43grPnM4KMQX3Q+Au55Lhs/LuwEg55Mkt0+PsyKeu34h/YTMX1tWq7iB?=
 =?iso-8859-1?Q?HrZ+e/CbqnYE1F3SIunjEaCgP1JalwOFLDjlL19Syyoz2ZVopUk72k/OV6?=
 =?iso-8859-1?Q?XCdBf3FAOc5/91z/TFfd+O3Pc5PEiCioGPthv2DkPnL9vb75+VnEReyK+A?=
 =?iso-8859-1?Q?2mkulCuMG52xXR9n0rJbQALuw+teCeSLMcSuCMwHCfFkQsBwkWHiXrls7R?=
 =?iso-8859-1?Q?6Zyey/lhShH65P1TOsVOK9tMT/tu4+FVc99mkTVgAoWlqiPqf7mue0IMr2?=
 =?iso-8859-1?Q?iAsvREYMUr+ugWXmmG71yorgNaMIVbkY9oD1zyf//TLSspdZNlJ9REm+iM?=
 =?iso-8859-1?Q?AcIBpWgS5h1IdcTbluYtp0X99xXQwIpFQovFObz0c03Pe8zu9kBVQo+Uk1?=
 =?iso-8859-1?Q?MNUZS6n0rTXABuUqRa3/40JdjNPuzftoBZaQnQwBwBrq7/G7ajkz1qdKAO?=
 =?iso-8859-1?Q?y3eI7SncfB5PktNRKkUrq/Nydm032iU2XSaAUZLPjKHZxl+tflGLQGfkvZ?=
 =?iso-8859-1?Q?e1bqQ9FlAlWY3MSFdvtX73RmHZR1npIcDaWzpvAhfRabc+TU8eUQ0mnRb+?=
 =?iso-8859-1?Q?dodDemvt+mcpx5S5hqEYeQZ/8+L2F/b6kOvj1pGBAfytdZASRWmhZUlIn9?=
 =?iso-8859-1?Q?AZtl502XZbLMEH9vJ/WO+LC1HLayG0vLD+jYN0BXrGuczwYOwSBdTfbL8V?=
 =?iso-8859-1?Q?gV39KBICONcenbz8YhWHAMq4v8rwyxE1vTCW89lGekoP6kzYWL+oaNSLoI?=
 =?iso-8859-1?Q?EtS01e28JtZNZvi0YCEU+0jJlUYubJ/hnWvxNz7XsNDKyITLYSXNGCqjL+?=
 =?iso-8859-1?Q?+ckiusuXRFZgU8RQs8RSE16ADX1z8EfGnBptV6Zqltfxxd6JGfB3Atg5qw?=
 =?iso-8859-1?Q?d1h7rOID19pn6M/lukEBDAtInwTzkRltxRLeysj6fgdLfz8NdIcyh+bjFR?=
 =?iso-8859-1?Q?17nFojGPSq17kvUlxpYGMwRslCyQ2v2AEWaxHfVDxoACg44B5VxfDFYWcd?=
 =?iso-8859-1?Q?tv33fPhwizTKGOrSU+dxvcffGFtAXKw+OQZh+4CmAL3ZLqKYEolYO6XVO1?=
 =?iso-8859-1?Q?ZirWbTCNZQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB6318EB501891A22CFA2F5750FC7FACY5PR11MB6318namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7080d847-9066-4cc9-7e8b-08de7935c1df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 15:01:32.5830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEdTdwEJQoCfZNK2s3xO5d34M1hTVgMungs1Nvp9bQ5ADqine1zbNu6wdtpKb8MiTf98BB7+SUX37t/IkyVjyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8770
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

--_000_CY5PR11MB6318EB501891A22CFA2F5750FC7FACY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-03-03
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
- Broadcom
- Debian
- Intel
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
  - 61 doc patches pending for merge.
  - 30 patches in review/waiting.

- next-net-intel
  - ~40 patches.
  - 5 patches in backlog.

- next-net-mlx
  - 17 patches ready to pull.

- next-broadcom
  - 6-7 bug fixes ready for pull.

- next-net-mvl
  - No update this week.

- next-eventdev
  - No update this week.

- next-baseband
  - No update this week.

- next-virtio
  - No update this week.

- next-crypto
  - No update this week.

- next-dts
  - 1 patch ready and 1 failing CI.

- main
  - Some LTO fixes to be merged.
  - Some fixes on unit tests.
  - RC2 targeted for Friday.

 DPDK Summit CFP is closed: https://events.linuxfoundation.org/dpdk-summit/=
program/cfp/


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 24.11.4 - Released.
- 23.11.6 - Released.
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



--_000_CY5PR11MB6318EB501891A22CFA2F5750FC7FACY5PR11MB6318namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">Release status m=
eeting minutes 2026-03-03</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">Agenda:</span></=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Release Dates<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Subtrees</span=
></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Roadmaps</span=
></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- LTS</span></di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Defects</span>=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Opens</span></=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">Participants:</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- ARM</span></di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Broadcom</span=
></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Debian</span><=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Intel</span></=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Nvidia</span><=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Red Hat</span>=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Stephen Hemmin=
ger</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">Release Dates</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">-------------</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">The following ar=
e the proposed working dates for 26.03:</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">| Date &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;| Milestone &nbsp; &nbsp; &nbsp;| Descripti=
on &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</=
span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">| --------------=
- | -------------- | ------------------------------ |</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">| 5 January 2026=
 &nbsp;| RFC/v1 patches | Proposal deadline &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;|</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">| 9 February 202=
6 | 26.03-rc1 &nbsp; &nbsp; &nbsp;| API freeze &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">| 2 March 2026 &=
nbsp; &nbsp;| 26.03-rc2 &nbsp; &nbsp; &nbsp;| PMD features freeze &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">| 9 March 2026 &=
nbsp; &nbsp;| 26.03-rc3 &nbsp; &nbsp; &nbsp;| Builtin apps features freeze =
&nbsp; |</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">| 16 March 2026 =
&nbsp; | 26.03-rc4 &nbsp; &nbsp; &nbsp;| Documentation ready &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;|</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">| 19 March 2026 =
&nbsp; | 26.03.0 &nbsp; &nbsp; &nbsp; &nbsp;| Release &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span></div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">See https://core=
.dpdk.org/roadmap/</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">Subtrees</span><=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">--------</span><=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- next-net</span=
></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - 61 doc =
patches pending for merge.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - 30 patc=
hes in review/waiting.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- next-net-intel=
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - ~40 pat=
ches.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - 5 patch=
es in backlog.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- next-net-mlx</=
span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - 17 patc=
hes ready to pull.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- next-broadcom<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - 6-7 bug=
 fixes ready for pull.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- next-net-mvl</=
span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - No upda=
te this week.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- next-eventdev<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - No upda=
te this week.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- next-baseband<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - No upda=
te this week.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- next-virtio</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - No upda=
te this week.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- next-crypto</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - No upda=
te this week.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- next-dts</span=
></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - 1 patch=
 ready and 1 failing CI.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- main</span></d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - Some LT=
O fixes to be merged.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - Some fi=
xes on unit tests.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - RC2 tar=
geted for Friday.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp;DPDK Summi=
t CFP is closed: https://events.linuxfoundation.org/dpdk-summit/program/cfp=
/</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">Other</span></di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">-----</span></di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - None.</=
span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">LTS</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">---</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">See also: https:=
//core.dpdk.org/roadmap/#stable</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">LTS versions ong=
oing/released:</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- 24.11.4 - Rele=
ased.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- 23.11.6 - Rele=
ased.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- 22.11.11 - Rel=
eased.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">Older releases:<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- 20.11.10 - Wil=
l only be updated with CVE and critical fixes.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- 19.11.14 - Wil=
l only be updated with CVE and critical fixes.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Distros</span>=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - Debian =
13 contains DPDK v24.11</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - Ubuntu =
25.04 contains DPDK v24.11</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - Ubuntu =
24.04 LTS contains DPDK v23.11</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - RHEL 9 =
contains DPDK 24.11</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">Defects</span></=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">-------</span></=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">- Bugzilla links=
, 'Bugs', &nbsp;added for hosted projects</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">&nbsp; - https:/=
/www.dpdk.org/hosted-projects/</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">DPDK Release Sta=
tus Meetings</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">----------------=
------------</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">The DPDK Release=
 Status Meeting is intended for DPDK Committers to discuss the</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">status of the ma=
ster tree and sub-trees, and for project managers to track</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">progress or mile=
stone dates.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">The meeting occu=
rs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK</sp=
an></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">You don't need a=
n invite to join the meeting but if you want a calendar reminder just</span=
></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;">send an email to=
 &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Consolas, Courier, monospace;"></span><br>
</div>
</body>
</html>

--_000_CY5PR11MB6318EB501891A22CFA2F5750FC7FACY5PR11MB6318namp_--
