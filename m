Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC28CD98EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 06:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A37440276;
	Wed, 17 Jun 2026 08:45:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6A79E4026A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 08:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781678708; x=1813214708;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=AKpcjn0fPOSQIzwW9e2L67bigXENbj+KsbmGwOftFUc=;
 b=Ihq4QPXxYkrs4UB0tgFXWD83/c1nbkQyZIGZvlBXsPKjhgoleRr7dQHz
 Ex5gRBmahRX81fSShQO2I72VmGYPD/6kSIMs1NX5s021eXgRU3u3gkIgt
 HnvZjXiKlaSRewFJgyCexixHBdYS0GKB5lMGX6Io5Xy/W14fKkID4tvnl
 Axp6W9M8QL/x7Ripa1E/6MG55lWSWrMdV+AeoCRShKhXVleOtgXOBbqeK
 phrjzEBkCmAV5tX4I7fdnJOtr45CZWIJTzXiYMy4s3s01sfEynMJiGIiO
 IWWWzLuaqu8UuAhUIJshbX8OPd45yBnxT1ebe30ZyjJFBP1E6LTYwqmCL w==;
X-CSE-ConnectionGUID: hWPSEg7RTd2WSRMqHKranQ==
X-CSE-MsgGUID: pvrNNEZLRymdostOxrI1xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="81591954"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208,217";a="81591954"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 23:45:07 -0700
X-CSE-ConnectionGUID: gJMT7EqPTeikhp+sYzvNdg==
X-CSE-MsgGUID: kNLB1abXRwaN4ta7609TdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
 d="scan'208,217";a="247856153"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 23:45:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 23:45:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 23:45:06 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 23:45:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODxmFuR3e5y7KF5EisgftZYPoELEyDyHzxrkMuykWN9MMjthMNfF3NzHE6e2L3nFD/xFoZOtncQc1nfsxAlmnLoI1iOBqeVyGCunhKQYLKaxFbvUIGGq2Gtde1HPTQb3IbLTBn5jES6VNMAnGjaCOZc8khZml3rrJ3XMT0iZZMo3wwHeIU6WKyI2EC/iCcQjo0NxBoF7XAUhEWHozn/UhxnKs6jnM3AILDc6vm90ERriRRi92DHshoAaszakQxeCv0bNdHQNBv8u1q1dTcLN5C//YFy1i8XQ2KPNpQTZKcA5FbaijC6ftyIQ2Y640ZjXMjmRVtUvv44WROZ6ztlo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bu9C3FVYJvtv/cxWDBvvAsNOFDTWSjZPshXwyDWLwE=;
 b=rpmP2GR/tDKyQ93Eb4dhuGhGERG5N6/7YzB8dH8i/FIhEA08tgJ9y+1tfX1OkUKzVcS7OxttmZX6TLAAYjiPj6httcg65h9Y5VocJytSZi3KnOKxjwAaQBx/VmeGgYH5WDx7v6CKPv4JO7dzLxY85bOrSkdpn9jKtdMBw65RKIa7k8QalXit/ok8nNrSC/9yamP0Dy2ZfbXGSAViW7wUsi9X6JFzoJAeMwLA9IXIVHSdguqUZecbYtmV5W/D4pH8BhV+9reMW3Y410lKUKD1piEEvOhHnBSZjAaG/VKwtAIc3DSR0yhncaZyjSeHN/R8fdJk2qVWkiB59xNJSSI6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by MW5PR11MB5883.namprd11.prod.outlook.com (2603:10b6:303:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 06:45:01 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 06:45:01 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-06-16
Thread-Topic: DPDK Release Status Meeting 2026-06-16
Thread-Index: AQHc/iSyxeK0JyHumkWBKbKAL5d6Ig==
Date: Wed, 17 Jun 2026 06:45:01 +0000
Message-ID: <DS3PR11MB9646010C625260D63B6C27E1FCE42@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|MW5PR11MB5883:EE_
x-ms-office365-filtering-correlation-id: 7806c672-dbe5-4812-5a52-08decc3bf4b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|8096899003|56012099006|11063799006|38070700021|18002099003;
x-microsoft-antispam-message-info: r0HTh+yBKADac3hqhH20GVZtsxRrMi4zx+sTHGyMzXGZBXuJOQuhmQrNVAVY0TLV7tYggztunh3Auh3s0kRJc4JQsOYHM+akzqZdo228Urc+ThlNXjDETxoOIVpSNILeGGNMp1R7YiRhfXaJygF1f9tL15gcHxngy9mBLrb/851b/AUdxSvCEVAhjNiw+LOdjyLCEbZZmk/OoEl/mxV1E2HRyX3YGwBLbQziIRdvmgZpgxnUCi5dKaasXA4xAI5wjRhpO3wAVWj7rbwiZ5QwJFRBWNMJtKXPX89Jv0tfUh5cjJrbzNrogJAvcemPB5LvGNXLMEwCL5983vJeQRBcev6pBnQw93McYmi3dbjfvJyX8D+ZWMea61JroJd8qSGFFIcUBTpS4kSn9gJdahlgx17FjTQs0jkSXPDZKhmZpgKa0VQSGDjxGPACs5ee6owkawuZOPE1XeSnfK4IATmJ87wTGeI6mnPncnv1m1G/7e9Vvk5kChlYZemyljkvwwPpvGxXGtKfglc1bIyglDxztgnM1Alr6M5nkKOGZtziQWIqIb905k86CZ4XDQMpI70dIUcC5GS/t8Wei/ywt5bboijSvkkAr1kiPMMF5pQYOwpOJ1BqE+kWQI1PfE2QEB+n7ZUGHE1tl2tCsVBF5ju0BZBISzSLdv3ihPWO1w1nEHTToHlZ/Vs02JDlTveJdumFknFltUR82paSEPqDj3FExQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(8096899003)(56012099006)(11063799006)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VyVkDgnmiZ00w/AI8A24cWroiAiPxQuhLVVAJOr3MrE5ojsOBGFj8N37i7?=
 =?iso-8859-1?Q?fwZ/8/kEW9DnpC2giDQGyc+wDB8YrpQ01AzThJeDTUY792+Yh0Mv61kTrU?=
 =?iso-8859-1?Q?MM2W34p9llYoA7o4+jcFF9nmRb/r1R0fSlFZX0MEYo307gbmNpLugvWQiA?=
 =?iso-8859-1?Q?jXHYd83MBrU+i9sT+cbUKCtsho2vfrge/zB3J+Aay8Mz+wST/x4sfUsNmx?=
 =?iso-8859-1?Q?cqzrGk++3nSLsutc2SsttQ3rgurCZ22rWwLOYIKEKwm8Kq/d4oGzCj+a7R?=
 =?iso-8859-1?Q?HY4lRq/G1PgqwCYE0jqqAO1q9U1YseK5yro3BzCeUp+nY3xT757i9L5SLb?=
 =?iso-8859-1?Q?bijX3DFK2E63jB4Kq1DIJRXZdn8dLfPbhwTiuIY8GnCEdVIR9YJcowGw7b?=
 =?iso-8859-1?Q?MgnIb+CoNPGBx5Fiu0LR2BKL+H6zX/ba6ZQ60MI0af0PaWay8NNvMJ3QiF?=
 =?iso-8859-1?Q?iR51ODkpHUQDCjNDK/LIPtBFMyQ1ZWv/1cb1ZqscunEG4uW0sskWcMOyVV?=
 =?iso-8859-1?Q?5m294GO8PEGWftg8W35FD6f7HlKBCZHVyfdIAF5zelqZ5sUduo7MVWI9p0?=
 =?iso-8859-1?Q?m3nEEbJUOJDChD/FtcDGTNViMxgc4i7bGCKwwixUQdgMS7dxtnIoF7OqZc?=
 =?iso-8859-1?Q?3ZupgtZEJNFb93whGRWbEN+JmojGQKt+Znl49uliPfMV2CbG5rLkNGtthV?=
 =?iso-8859-1?Q?GLuLpHnD04ApOzU3Pe/bTL27nnIGWzJUXYRVeXaXiz1H+JhPSmud+p17gb?=
 =?iso-8859-1?Q?DxtzEhbuoVetILxVnyzYk6FUJPO1vHlwdmXeOQAqZvo/3Gw80DUKOA1O1i?=
 =?iso-8859-1?Q?PD7TAU9s2mvmt1JLitFkWt9K2sbZleBodkTfehjcEd2O0SnmlkBeEBAxj9?=
 =?iso-8859-1?Q?FPeDMF4vShGgy3TyhPPTP57c0Br755PVYuizEEzp8Mm3cHiFXDZKmdn2zS?=
 =?iso-8859-1?Q?/W5T3tUlZhQNQwFrkqNwgUky8memtO6itTA2lyR5GFyUzQVO5UCX0XiiO9?=
 =?iso-8859-1?Q?MQtlHS8wvFlP3EM4Nsq/PZxwlqdQkeg1zSl8FbEm8BEeYMu/4lN/GDqhmJ?=
 =?iso-8859-1?Q?h3cu0GDK9PnVSCQXJYsgXEGmIHATCl6RWjysY45EwUVAoqFXBq3elDLUO5?=
 =?iso-8859-1?Q?WJ1D5nVme7o5bsUoOJLsVoG2iph6yE5aGXwcVVPel/I4PXaSanu9FQMKOf?=
 =?iso-8859-1?Q?qaIgBYXWhR6dcZKm6vJzbsGVsffV032R+XNzRS/sA+319oucbKVQJkCoYx?=
 =?iso-8859-1?Q?N/x8li5jh/fCLVzGRdLQYPFzbeOv7XZlWzxDFNrt357pRkV4wExA3H7SQ/?=
 =?iso-8859-1?Q?bprt7gF5UQenFNDGQ8QB4OjWrbnpqvpHCtZc8twUF9ESSw+Qt9gmOqSJTN?=
 =?iso-8859-1?Q?ekb7RjGNaO/6RdLYiSSmD00KxOrEL94jbjeuQ3j1ZlpAia3gNmw2CWBoON?=
 =?iso-8859-1?Q?xpdoUzkQjuK/4084qUWfm2EaqR3OtAc0cFwdJx5Nv8g7DIYohuoARmIEjB?=
 =?iso-8859-1?Q?QWxBfV6CpET6pHuZPzJAtR7WEEKhmDC01d0zf/N2/l/h76D0FRHB+YsoVl?=
 =?iso-8859-1?Q?8qpJ6gsGeNU4fcDL3i+PeOcrj6BzGQTaJnF+cmON/mS/UfNXeaO/TnTlmd?=
 =?iso-8859-1?Q?/4RTOeycuIbzg0jjXWrF85OHc11IUA5fThUt8DnyJoK5zMMROl/g4tSS5t?=
 =?iso-8859-1?Q?pK4rlFrorA+8w5cfkgHkLZ5hITJpIEY9+EXafxwJhxBML1uJ6AhZ6nEaak?=
 =?iso-8859-1?Q?MV4lkGnjfZ46BN/A1+Q4A7pfMc2M+vJZ49u5S5D4+foGQT5r30XgMQQoVK?=
 =?iso-8859-1?Q?pxkffLs04Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB9646010C625260D63B6C27E1FCE42DS3PR11MB9646namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rd2U+e6Iyiixb2TP1RBpM5rMfrrvDV2t95qwXpgscm0jtwQzK/eWJZ5B8jvOMJpWLsWb1r2rb6cnk5yvGZ37f2+5tGrI7p0BotDHB3Sz+etC2EkOGIGCgNNG5OP4a/8R0CFYbT196vSC2Zh04uOWnFiywF8ZLREPhDrOyqlTqcU58smQIpm96AT188dOD61Qhhqzyj9YxKcucc+N+NduEWGXV+vf/KlPzWebAPe1l1kk8WEruH/I5uaxzIOJyl7wozOJb9efD1UKv/htcZsDnSZg9OOHEHKXY4WJtYrifpFUHaHTRN80oAizHaIwizYtwvw4+yTLIl3DtzWXjeEg9A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7806c672-dbe5-4812-5a52-08decc3bf4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 06:45:01.3703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgIBWS8mUzj+eLo+xazLgkAfSxxKoH6w67YYA8caRIJ49ovaVt18jG5fm6382wD1m+VYvt1F9m4Kfy24MiFyhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5883
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

--_000_DS3PR11MB9646010C625260D63B6C27E1FCE42DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-06-16
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
- Broadcom
- Debian
- Intel
- Marvell
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 27.03:

| Date            | Milestone        | Description                     |
|-----------------|------------------|---------------------------------|
| 30 April 2026   | RFC/v1 patches   | Proposal deadline               |
| 11 June 2026    | 26.07-rc1        | API freeze                      |
| 25 June 2026    | 26.07-rc2        | PMD features freeze             |
| 02 July 2026    | 26.07-rc3        | Builtin apps features freeze    |
| 9 July 2026     | 26.07-rc4        | Documentation ready             |
| 16 July 2026    | 26.07.0          | Release                         |


See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - 12 patches ready for main.
  - 41 patches in review/waiting.

- next-net-intel
  - 6 patches merged, ready for main
  - Small backlog.

- next-net-mlx
  - Has been pulled to main.

- next-broadcom
  - No update.

- next-net-mvl
  - No update.

- next-eventdev
  - No update.

- next-baseband
  - No update.

- next-virtio
  - Working on some reported issues.

- next-crypto
  - 2 patches in backlog.
  - Planning to merge this week.

- next-dts
  - No update.

- main
  - Looking at bugzilla issue.
  - Reviewing hot plug patches.
  - DMA driver to review.
  - Patches for BPF.
  - RC1 released 11 June 2026.


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 25.11.3 - In progress.
- 24.11.7 - In progress.
- 23.11.8 - In progress.

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
status of the main tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.




--_000_DS3PR11MB9646010C625260D63B6C27E1FCE42DS3PR11MB9646namp_
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
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Release status meeting minutes 2026-06-16</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Agenda:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Release Dates</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Subtrees</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Roadmaps</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;LTS</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Defects</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Opens</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Participants:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Broadcom</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Debian</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Intel</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Marvell</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Nvidia</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Red Hat</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Stephen Hemminger</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Release Dates</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>-------------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The following are the proposed working dates for 27.03:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Milestone &nbsp; &nbsp; &=
nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
|-----------------|------------------|---------------------------------|</d=
iv>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 30 April 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 11 June 2026 &nbsp; &nbsp;| 26.07-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API fr=
eeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;|</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 25 June 2026 &nbsp; &nbsp;| 26.07-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD fe=
atures freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 02 July 2026 &nbsp; &nbsp;| 26.07-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builti=
n apps features freeze &nbsp; &nbsp;|</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 9 July 2026 &nbsp; &nbsp; | 26.07-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Docume=
ntation ready &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 16 July 2026 &nbsp; &nbsp;| 26.07.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| R=
elease &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
See https://core.dpdk.org/roadmap/</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Subtrees</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>--------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;next-net</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;12 patches ready for main.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;41 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;next-net-intel</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;6 patches merged, ready for main</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;Small backlog.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;next-net-mlx</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;Has been pulled to main.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;next-broadcom</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;next-net-mvl</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;next-eventdev</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;next-baseband</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;next-virtio</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;Working on some reported issues.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;next-crypto</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;2 patches in backlog.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;Planning to merge this week.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;next-dts</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;main</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;Looking at bugzilla issue.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;Reviewing hot plug patches.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;DMA driver to review.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;Patches for BPF.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;RC1 released 11 June 2026.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Other</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>-----</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;None.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
LTS</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>---</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
See also: https://core.dpdk.org/roadmap/#stable</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
LTS versions ongoing/released:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;25.11.3 - In progress.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;24.11.7 - In progress.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;23.11.8 - In progress.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Older releases:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;20.11.10 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;19.11.14 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Distros</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;Debian 13 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;Ubuntu 25.04 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;Ubuntu 24.04 LTS contains DPDK v23.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;RHEL 9 contains DPDK 24.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Defects</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>-------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-&nbsp;Bugzilla links, 'Bugs', &nbsp;added for hosted projects</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; -&nbsp;https://www.dpdk.org/hosted-projects/</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
DPDK Release Status Meetings</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>----------------------------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
status of the main tree and sub-trees, and for project managers to track</d=
iv>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
progress or milestone dates.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
You don't need an invite to join the meeting but if you want a calendar rem=
inder just</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
send an email to &quot;John McNamara &lt;<u>john.mcnamara@intel.com</u>&gt;=
&quot; for the invite.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS3PR11MB9646010C625260D63B6C27E1FCE42DS3PR11MB9646namp_--
