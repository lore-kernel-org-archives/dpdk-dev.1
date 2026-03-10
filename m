Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB0FEB105A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 14:50:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCBD7402DC;
	Tue, 10 Mar 2026 15:50:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 26FBD402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 15:50:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773154252; x=1804690252;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=jHam0ZnCTLSkfab069+YObQSIqkAewxge5xgKX869gw=;
 b=KFXcL95PDK+aVYkRd3sYTuKwvnH6xRzQkwaB7oQTyJbQZBMnaGiOXuEj
 95/UI4/xxdYlQND4Tgf+PcT+A6yXvMAMV4yzbB2+xb6ANuTQD+TiZFiQ6
 8cXAVPa1pcJ1liVYJY4x9oBIQ9xqlHIzK4nnU0ojfnmGUFc8zYaY2tDQq
 t1JL1VXf3RitOSmm/FkRxFa1v4lcQlDi9BaBP2PVjbSW9I5VfuisMo6cG
 duqMxap7Wuwi2O4vnsrDZJjcMW+2mTTsIlFGHYaurCojBEMv0Bk8GCHQy
 02FKrPSsRX2EbEGme5y7mcr7I3AF8ciNaN4/kg1hOkIf2abwcsaVfAFiF Q==;
X-CSE-ConnectionGUID: 6BCEX5aaTpuVGjWNUHIDnA==
X-CSE-MsgGUID: Uq/OaV+9Q/yhS0STJRy+KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74282657"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208,217";a="74282657"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 07:50:51 -0700
X-CSE-ConnectionGUID: Si/NOsYMRni7Jvi/nhzowg==
X-CSE-MsgGUID: 1G7/y8ZZQjSLJ66WJzpdww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
 d="scan'208,217";a="220099764"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 07:50:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 07:50:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 07:50:50 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.51)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 07:50:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=js9Wb3kGvu6I1DcGWxT3nvYeYDidI4SCo4BiJRwrmeFTqCvHXK4Y1qg1soHalSa08jJH9WUQ45OTxNKj/UaYrI1vl1F0uYcECZovBLLyePhKRfl+Qc7xmk1MjvKCCCdbXAjSpRKWh7rnzpEFMugRvrWs/hYEVN1ozigdixJi8M9IsZzfQj+DsPwZreHdOsonlWe4+6Tl4qflTw1YTHCCDOEGL0OmYzFRwpBqOlUCDLYQq7nw/QyFU3ebc3X3nYTy/LXy5yfjutIhyiifPHdpj7qA9g35cg+Tireo2OigMFAZ0BYn75D2s5q/m1Vfq6vVOClOGMhSHjq6gioMAZNHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFj+vquBJts0jW+YSlVzawX0bynZiXXgBCLxk4g2PjM=;
 b=iQoERE+/wmjB3r8lIrTwDjRpbCPTNr7dDyiPifKBcSj3WQNVgK5j64WR0r4cKuqswG3v67LZHGZtf98OWlf2wTCwqCRVMgLW/rrIYOROVvfZ5Qb3GD+l9uSmqP7OWGt/KZWDTRbeQ6BVOJqo0C3/zLb5DS6tsGMV+UXK2gy3mUOACGNbyMdRq8gI/+uN9TRwVgwFeRnGAVcZqrZS+C22NgcHAA3dbXGSlGaMphY09rr5hXG9d/SNN6QcMgLTZ4QSvsC4mIL0+BvShZR4CiIn5CtkmL+WFAs2P0wJViQqmH75454gGyJKA2znZ1lIphNGeftjf+PRd25J1dzxXTULAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Tue, 10 Mar
 2026 14:50:47 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 14:50:47 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-03-10
Thread-Topic: DPDK Release Status Meeting 2026-03-10
Thread-Index: AQHcsJ0fYwMnainrLkGIMOE8SyXWrA==
Date: Tue, 10 Mar 2026 14:50:47 +0000
Message-ID: <CY5PR11MB6318EE91A143BAEF736002C1FC46A@CY5PR11MB6318.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|SN7PR11MB6726:EE_
x-ms-office365-filtering-correlation-id: a767d730-9133-43a1-70cb-08de7eb46a55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: E0h8XJ20fbLsalXeZ0xz3Z4z5SreJKdwDv+pmcumYwy9ck0MfTuidsFmB+kR9mH7cIXw6cKW9I5lc66CCks89XszWBlH0jid6L1y++4JrvBV3aMaSUOuMcf6ZnP9qwwpshpD3QYMkLrJulALEC+jqbklMJwDijw9ukgOodDVpumFC1wleFL1wFbWXY28gSv92L9Dkc02J4mDFM+zOLMcnijjf5twBInJ+MLmKEnkrpt5pUVdkj+flc4Fj4O3V65Tj4ZBcIUUAk93R/LVqXs2MCF9Edus77+nq5h8DQUj0VOG1Q/I1KmNNHBil1oxuoSKfgl7+LjruujaZynd2lcVxxKJ0L2QoPIeRT95hkLMdmV+iBkIE/xYRXpO+pQK5o+II/6X6Fky3Juh9P+ZZCeEXSgJU/0kDCeZlnjhGWbXUUzaN5KVJ3zR5ZyihAAPOSJV4rHSP1XEOAvMHzcpE2oyv8rHERKXiarTzBQ6tVGLjSTMPuD5kC69jqHSUzY9dwVhMx7fXuDsWAqmZSjh2tnl7o1r7kAQXHMOEFhMjqK+g5rpU48y634HlKxaNQpgsyls2iEOJamt6jIm99mv9QJhrmTrSR49tShEUT3rKPGw354D8RpeMd0n8HxZAs/Dc2ruSSqCUFJOoPVuFoHgxGvNqWoka2eoukajxEH5j7mFceNYntYbnyjSR3JUzx8MZI8B+rCCsupxgkhI3loIgbfVVx5XuwIicXqtG04niY6yhb9DmYxEOgDqXjfUEqnhCnyb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hrii7Ok4H5aVSiGCi4xzR6vU01pH7TRkx19KX4LBmXXulD5siKR73Bb36s?=
 =?iso-8859-1?Q?Lc9/Nd+DIjhKykLkie+220wQhoBZD/sEWix2seDdJLgOc3o4YEphwBN5T7?=
 =?iso-8859-1?Q?dhwKch3CUIf+aVTxSs50XR5saib5dlhDG6xnhMZiT3uC3cMXK/RYCnwfhg?=
 =?iso-8859-1?Q?qrkpfScasp5ix+ZRTHrMegdzMzJu419IBAeTkeV3Hn0P59tsgatRWhzp1p?=
 =?iso-8859-1?Q?L84dAm5/p0HQ888mzQNJddDCjPH1c0fIUd1XQYnBOdTysPbP8sr+2YgJOg?=
 =?iso-8859-1?Q?PsShUfCs+LVAHWKDor9tRSl2+9HUU499aveUW3OHD/+ZprL7L2rLWrzjWA?=
 =?iso-8859-1?Q?wLDRXG+P6R1U0FSCTDX7bTDJfy+Vm1u3vDmqRcJ9qyOBanEIdr9HuJxOf3?=
 =?iso-8859-1?Q?gvXbcClHZKBnJ0WEBDy+AajxwrDIH2xuiEVAZL+Fbtv0kWqiepPQZMXGvZ?=
 =?iso-8859-1?Q?IcnIb6pVRijMFUZcP5QHhuuApa6aYzsDZ+ehB5KNB0hm440SvqPkg3XpNU?=
 =?iso-8859-1?Q?G76I4ih0aIcgsi6Fi3XT3K2QBQVOcmIfqi5OmJNV7AqUk+ybOadepT2pxb?=
 =?iso-8859-1?Q?ToSm8OmJpTMmiZvXj3cqgHS0Nw2to/ai29fmlhDxvY55yaY+5f7Ybn8+4m?=
 =?iso-8859-1?Q?2rl2+WHPh4Ngj0lhINsyJ6mOpiIoE/KFzytPE+vN9FdKj0d4ydefYwrPjc?=
 =?iso-8859-1?Q?l3iLZTuLGd9BmcvD/hYhkKH4OA1O8iRZpv9WtkIkOBW9caOYeFToZi/DLq?=
 =?iso-8859-1?Q?4iDbazof3nN9xhBKYl15nhi7Y0Tg0hFlgS7Lsl3Lhcl6xG7+zLctolLw5V?=
 =?iso-8859-1?Q?ymAA38zegK+p3nCQpJJEPZswidJqOlOT4joXaCAniDSPWPTRSyG7fYGLWO?=
 =?iso-8859-1?Q?2/w8hWXh49YTOGMQiuMlu5QpA/QWjjUo/kYyt82fSItmH1GESWI3YcstO6?=
 =?iso-8859-1?Q?0auP46DvAqKklz9zDRzN0Qijyi/xiq51+xG/vzaDLmYiw1quV4OOJZuQUI?=
 =?iso-8859-1?Q?3qBHxdsIXxzZsqW+DR//rGZUc4lsrE9E7pyPDyJforA7atjEEX0HYtqrG6?=
 =?iso-8859-1?Q?zrYBTxbFRiPZMUrdzX6weqmVp3jYuV3h2RR77rTU4+ptcRY9rcajntwj5m?=
 =?iso-8859-1?Q?r3acEjAcXKf0rvlXPXZgsyYXMemKFpxHxXoa0OOkpgo/xLhVh3Sj/7keZ5?=
 =?iso-8859-1?Q?cxRgSZkUt6MzS6hmtlNviE2JKgk0vGiVCFc2s4kD/jbTu+AG5wbbf5aN1N?=
 =?iso-8859-1?Q?bP1eBNpbwZomO0foa5pOuQHNjjfNM9rjAs7+gwU/kYCs3rayzQM0S2Ht3D?=
 =?iso-8859-1?Q?zOZdH+KCkiLBFDAJYlUSioibPxUWu+CzGLONSHUMNqpprrfhH0IUe7GIVE?=
 =?iso-8859-1?Q?lv4SyEUm3Op6tF25AjNXoay7YYFnWQ5lA3mZkyEWbZOk2ZUnD6cgxaNgPw?=
 =?iso-8859-1?Q?dupA4EPSBNNLJignp6G7opmZoJglmASkJYEOxIeyQUfNUHZkZyHmHp5dLU?=
 =?iso-8859-1?Q?rcXQtW372frMgpIkEVMCoXIpgLBxgReENpXsiBs5UbL0mzn1Gbxs9xTd3T?=
 =?iso-8859-1?Q?6iOq3RQGTSojf8qhv0pTZVq7U5HZByNPzPoHKFLw7RVSiHwrOed1uOFAls?=
 =?iso-8859-1?Q?IfqwahOPFbIorbE/pwbKzZk8/Y89JyqVxUkmok5TJE/Zh/pfd1xSIOA3n3?=
 =?iso-8859-1?Q?XEa6k4YxbIy3k/71STfuzNkhOe38foNbcGq9P9TSoqCJv+/GyLaDl7PWKO?=
 =?iso-8859-1?Q?uC9jBHXyC7uyMJo1bxgBYY/7uPOazE2fvjat5zDuCVdCEPU9onj155aqhr?=
 =?iso-8859-1?Q?vUnfwivtHQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB6318EE91A143BAEF736002C1FC46ACY5PR11MB6318namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RiG0X9W2CuO3v1zPWpQ5xVvX4puqQTfePO/DqJJ7lqJwlB/meDCUxdzOz7DMzFCvhJZ02P01Z5P/k30slJb5Z88/OHfcaClk8NlSAX7nEoLYlT5n/rOyTVENG6A9b4QtAfpE47KqkMS6C3aNBCNHlVmDOOm5FMUf5ks0Q9JeYM2ICTTr3cnRix5BbU5ogYJ3uB78PW22w1Ob9l13WHm/c1jLcdVADzu83iBJ/JCUTFHFgvabdlUuqdKcatMHbTubZlvxVqGAO2QkDYsPFtiUv4zSlsRC1El7h+eWMg0j273ptPF2Sj2JvloPDkOQGP7SHgnLarvFX+35jn0yQ1YMtQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a767d730-9133-43a1-70cb-08de7eb46a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 14:50:47.5787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8gmxk6rlProyvXiOoedPORMqMgXwlAzuOmyIVSFK2eBgO6K+IRPGHQ8XBDdc5tEMLZQbVpmgrl5XRJINY3tFvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
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

--_000_CY5PR11MB6318EE91A143BAEF736002C1FC46ACY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-03-10
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
  - 90 doc patches pending for merge.
  - 7 patches in review/waiting.

- next-net-intel
  - ~40 patches.
  - 5-6 patches in backlog.

- next-net-mlx
  - 17 patches ready to pull.

- next-broadcom
  - 6-7 bug fixes ready for pull.

- next-net-mvl
  - PR sent.

- next-eventdev
  - No changes.

- next-baseband
  - No changes.

- next-virtio
  - PR sent.

- next-crypto
  - Some patches pushed and ready for merge.

- next-dts
  - Cryptodev test suite merged.

- main
  - LTO fixes merged.
  - Interrupts fixes merged.
  - Some fixes on unit tests.
  - Merging the trees for RC2.


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



--_000_CY5PR11MB6318EE91A143BAEF736002C1FC46ACY5PR11MB6318namp_
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
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Release st=
atus meeting minutes 2026-03-10</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Agenda:</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Release =
Dates</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Subtrees=
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Roadmaps=
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- LTS</spa=
n></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Defects<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Opens</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Participan=
ts:</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- ARM</spa=
n></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Debian</=
span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Intel</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Marvell<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Nvidia</=
span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Red Hat<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Stephen =
Hemminger</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Release Da=
tes</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">----------=
---</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The follow=
ing are the proposed working dates for 26.03:</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| Date &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Milestone &nbsp; &nbsp; &nbsp;| Des=
cription &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;|</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| --------=
------- | -------------- | ------------------------------ |</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 5 Januar=
y 2026 &nbsp;| RFC/v1 patches | Proposal deadline &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;|</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 9 Februa=
ry 2026 | 26.03-rc1 &nbsp; &nbsp; &nbsp;| API freeze &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 2 March =
2026 &nbsp; &nbsp;| 26.03-rc2 &nbsp; &nbsp; &nbsp;| PMD features freeze &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 9 March =
2026 &nbsp; &nbsp;| 26.03-rc3 &nbsp; &nbsp; &nbsp;| Builtin apps features f=
reeze &nbsp; |</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 16 March=
 2026 &nbsp; | 26.03-rc4 &nbsp; &nbsp; &nbsp;| Documentation ready &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 19 March=
 2026 &nbsp; | 26.03.0 &nbsp; &nbsp; &nbsp; &nbsp;| Release &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span=
></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">See https:=
//core.dpdk.org/roadmap/</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Subtrees</=
span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">--------</=
span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 9=
0 doc patches pending for merge.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 7=
 patches in review/waiting.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-intel</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - ~=
40 patches.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 5=
-6 patches in backlog.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-mlx</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 1=
7 patches ready to pull.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-bro=
adcom</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 6=
-7 bug fixes ready for pull.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-mvl</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - P=
R sent.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-eve=
ntdev</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
o changes.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-bas=
eband</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
o changes.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-vir=
tio</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - P=
R sent.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-cry=
pto</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - S=
ome patches pushed and ready for merge.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-dts=
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - C=
ryptodev test suite merged.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- main</sp=
an></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - L=
TO fixes merged.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - I=
nterrupts fixes merged.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - S=
ome fixes on unit tests.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - M=
erging the trees for RC2.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Other</spa=
n></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">-----</spa=
n></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
one.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">LTS</span>=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">---</span>=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">See also: =
https://core.dpdk.org/roadmap/#stable</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">LTS versio=
ns ongoing/released:</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 24.11.4 =
- Released.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 23.11.6 =
- Released.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 22.11.11=
 - Released.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Older rele=
ases:</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 20.11.10=
 - Will only be updated with CVE and critical fixes.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 19.11.14=
 - Will only be updated with CVE and critical fixes.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Distros<=
/span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - D=
ebian 13 contains DPDK v24.11</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - U=
buntu 25.04 contains DPDK v24.11</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - U=
buntu 24.04 LTS contains DPDK v23.11</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - R=
HEL 9 contains DPDK 24.11</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Defects</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">-------</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Bugzilla=
 links, 'Bugs', &nbsp;added for hosted projects</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - h=
ttps://www.dpdk.org/hosted-projects/</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">DPDK Relea=
se Status Meetings</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">----------=
------------------</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The DPDK R=
elease Status Meeting is intended for DPDK Committers to discuss the</span>=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">status of =
the master tree and sub-trees, and for project managers to track</span></di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">progress o=
r milestone dates.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The meetin=
g occurs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DP=
DK</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">You don't =
need an invite to join the meeting but if you want a calendar reminder just=
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">send an em=
ail to &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the in=
vite.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"></span><br=
>
</div>
</body>
</html>

--_000_CY5PR11MB6318EE91A143BAEF736002C1FC46ACY5PR11MB6318namp_--
