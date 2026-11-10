Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD866606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iu3VoVFV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7769240285;
	Tue, 10 Nov 2026 16:11:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 6F69740281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 16:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794323488; x=1825859488;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=VkW9nxXlH8OJtlpOqhlVB5qDKMe8xIMIxNXFPIh+v8w=;
 b=iu3VoVFV3N2blHyZsU7UryTO7Ea8zIQ7ALjsvNzdrySz7YbPXwjuo1q7
 1EpsoEKAXYV+RcccqkidRcA+W0aCgvd/OOIpYr8gmAXeuDX80oy7LJz+d
 xOIg1+Dfv9Lk/d7JRVA4xQEfoCtMul1crak+EYGvHTeWb+06KT+BeEI4t
 P6hmguHNj/b47/4EKA5oXFz7EELiNIF3WG12HNPOcgAOkn4N6DVUVREX1
 ghjJn1Rf6oxcL17NC7231Oe3e1XDgNise2vKHfLyauVqlgk0QuqFbAKo2
 K+S4veXXeqte/Bl2PPqpnvRGCs+StARs2HX73TW71LQrrKyGD5f7a2ufp w==;
X-CSE-ConnectionGUID: 4YeDes/CS4Ksqba8tFSm/A==
X-CSE-MsgGUID: bOKnWVGoQh+nYQdcqgHiMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3096799"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; d="scan'208,217";a="3096799"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 07:11:26 -0800
X-CSE-ConnectionGUID: 19i0SPe2TjSpWo2tJqqcUA==
X-CSE-MsgGUID: 9f+1wL10TSy5xNPvrkmwsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; d="scan'208,217";a="8312317"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 07:11:27 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 07:11:26 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 07:11:26 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 07:11:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2X8nAIwiODyXYgwlmvQ56gCzVyuqi8+/hwYXCKCFRLiJlGAaAV1VBg8irPWna33NIhkhJWllvnhs860Nk07HZULXuw4UXun8C9yKHm9fwn3lxBdA1exMfCUTE3aBIC8cLa7Ntj3Z8kQ6GdoB0eoaJXSnVU0tOoD01JdM+u+mlEy0Kf+vtjusc6kvnbckajB8I2EdBg3TR1k0pqW7FYb4/EGTdyTbEKRw1nNh228ThE9htRqk0PcS/6yqFMCRktOdocO700wjm0Gmm7gFD3JWwAqjBTxrfpiG4sGU9aa0qtkd+tr2VBho3uRsA7NNAQmqkYcNTlF66UyGg+/5aA/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huJ/MFYs2DnEK9k+usvpKNT+9mnz8DS70v+HEen4dAQ=;
 b=GSHBxeeuCkOiyWDgtuJY+8iABtLU74ZPS5tCZ9tircUN9J3ebfU9RdjeR9ycXxmN1MuHaJzeBMy1I0HW7zU4UBZYu2CnVZJ3QxzcemWGq5PQM5UE3PMK/ejlfTovNbO7y57hG/BlHlGIU+Ju4S8XVtejN+IwTBvqQiy2QrTfVu6NCiQtqAGj1Zu/pVDIfuDnBGYaPTa/UHF7v4Fa86/QvdAzGjNflsxwzEILTrKUU/62KnEBqF/CCmoTq3fzu3LP/kQ98IGd/QEI2Vt6lZ6VoQ78bfKb5H1a3+loC2cKUsz7YObcb160Nxz05GbPiOu1t9xKyxpzQra4x0Flj59AyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 10 Nov
 2026 15:11:22 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%5]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:11:22 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-11-10
Thread-Topic: DPDK Release Status Meeting 2026-11-10
Thread-Index: AQHdcSWfx1UP8apLLEmviBlR9xMi0w==
Date: Tue, 10 Nov 2026 15:11:22 +0000
Message-ID: <DS3PR11MB96466817A5809ACC6CF79210FC722@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|PH0PR11MB7522:EE_
x-ms-office365-filtering-correlation-id: afa4586e-f5fd-4c89-b8a7-08df3f3ce180
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|261022105027099003|261026121527099003|11063799006|261009223027099003|261026140227099003|261028144727099003|38070700021|10067099003|18002099003|8096899003;
x-microsoft-antispam-message-info: FqOf46AC0BQkF/NDBTiF/u0vl4MeNiX8Jgj4vJC3y6DLU5jmOkP4ZUraF9UQ3nN52IXLoBYfgKbIU98bs1K0uSM3XIyoDUgmz9+z40n94/e6asH3JuhFkasOSIUsapPP/NcMLkF3EVIQQ9vvECWxUF5TbkP2547kcMEDIkzAe20hN9xPEC9CoFMCacRmSDkoUWopAQlUm7T8tG2bVvkAAJiICudsJ0qooiPDmMBJJJrPE0/Wtmzf1BefSYahUMeDqMEPQETmeHVbGA9ZXbNUNBjzKL5WozimemojG6b3x6RM/5LWVANQ4ZLm23DxHcEcRU3Hpb9CcShYhHvYWW4tXGOwMZCFhBOrdoNoSdbQr9dtyCw1ShzXYvSAxLfbO3VKu36hijese8+fMkodSfyaIrq42SMhDO4apD99X6Ot3U0Bews0nVRojtmDass0zR7LQuEyuXeCCkE4BXos76mShDKoRH80ha/VNT4gFXq8gr44ChaoAGhH1Ho4gNNHdwDJyMmFC53O/HGPzS7WqEw0JFNNRA3oG5vvAcg7ycooeA9YKF0RAbPeUGvJ2JiQ1rh3cvfjdNnjIfPI4pui+DXktDJaDrH0fLCEozdd/8/z5KJFpjHjBcFA6y3HZ06nVNLAMP/sW+4hFu2loPWmOwjlwS+6fInhjxXjAb6RHxUEiMg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(261022105027099003)(261026121527099003)(11063799006)(261009223027099003)(261026140227099003)(261028144727099003)(38070700021)(10067099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fXZnISCkOYMjAJfIb8wSfJGUIfic7F5JLv0AyjiXpdP/3KSE2nAf7acU/o?=
 =?iso-8859-1?Q?r7kbHgnTdujmN1GnZH9PWSKUYi+Xx8qDrSetncN9odxTDFt3NVNZ4H6NqT?=
 =?iso-8859-1?Q?0CJ8GK+kCb0z7jbjT5mEIyRzArZIseS8BFU9uFYOFj7n4FN+LOBBliB/cm?=
 =?iso-8859-1?Q?YFA7PM/ISnk2c5Mzjy/leuK81SJeuPxEYXMLIDAZfv/lqDmYjFjnGcSlTk?=
 =?iso-8859-1?Q?aHwYvV93hCpqSIu+m2zJmn7qB9unOCq72xPAR0rohqvXMvdyIiDdt+zf45?=
 =?iso-8859-1?Q?g8ak7T2JSxjxk/OUEoO/hz75vpMoD0yPxhyjGGdeY6dwwVQZJIGmjyJZoV?=
 =?iso-8859-1?Q?xfCcWh6YkF5PDm5maC2WoVmLreIdDC9YN8r5tUhuH8OGG8HkOeUJHmZJTO?=
 =?iso-8859-1?Q?TPPl8gp8H4Ikhr3fx5yCjWGOCHh0L69a3kKjPb422HzcaseRhIuspHkn+n?=
 =?iso-8859-1?Q?4wFKfTJc/1mytBxYRdrFgkIBkSUp1iC2RtF48K90TkqPYbScE+YXzoLWph?=
 =?iso-8859-1?Q?hTAoeDyzXIoWbXrtLqpHyUnEUI2ET/U0rnG7jA1/zmTBqmCERKXG/GnEEL?=
 =?iso-8859-1?Q?hHFbbByxwyzjNbN6U3oWx2tPdJUzTFfUcEGje1ohTxhJWLZp1WylYIrZv1?=
 =?iso-8859-1?Q?lbfeA8gQZ72G8Fk+ZeViENtVJ6RezPHx/D/H4oFVxJtPfI8jkwkZh4zPhS?=
 =?iso-8859-1?Q?4BP+4ZDE4tZpOPAgKmLK8Zp3PWXJCps6GDA/QIsrrwEhnwdETf1RdBIkrf?=
 =?iso-8859-1?Q?hgqYi1cHOd/tEpnbGIzjyCsR+iMCZ70pXKQq5pZgFPwdaczx9cFZH2BTIV?=
 =?iso-8859-1?Q?oUEhnPg1346ZLPichhc/WsKJ9b8pa5YaCMqOz32WPvGfGXVObnE5EoRRTz?=
 =?iso-8859-1?Q?2dFDXZDBCxE9SrZ38nn+S2nvv/wVXltVkTVfs7Q89bcudr94EP2XyS6wlt?=
 =?iso-8859-1?Q?Kxb4MCgnboefM7bFfs0I5H4cJpbO6m7g1TcAwVdi9DpMpa/sn3EYWDq/ru?=
 =?iso-8859-1?Q?0SsO5lYFZFngjq7RhWBjIzm62tMLRTHRsoLZAJgF4fe/hj7qgZ7Mz8mayG?=
 =?iso-8859-1?Q?+wtMAT6uH8QxF6zXAyOk5y67eBGM6TZ0MlVPPZDd9c72CLneVNzro1GPf2?=
 =?iso-8859-1?Q?L+xzhPcei3M+3C/YsVejkrKqIYF8q5dclfMehS4RQeIqSjYDbKvF1RZ1rP?=
 =?iso-8859-1?Q?DSytJifg7mUzqWHeBhkL2qMpWpgIvtG7KO7+1jZ/5BjIw2enDRAQNpoUwU?=
 =?iso-8859-1?Q?lHg7nDs2bjW9Vlsm9sGVQn+zzzGE3UXrgL0T5ZvUdmiqQ9ItIlBeI01K6f?=
 =?iso-8859-1?Q?BY/YraXikeqztb+VkAyhZ11bwoh1Goal6nHbqqaTBI6l1e/dA/VlhuxhaL?=
 =?iso-8859-1?Q?t7BJokDRqh6YNAxvalbs3HVpcFSQXv2gmd5ZsDx3t490ShWBF7uP3aMV5i?=
 =?iso-8859-1?Q?1lqVIvERKt2JswM+wSEDZtqKiOy2nZ15fMOFxQJgD+cBcinCG0ZdAUcSLk?=
 =?iso-8859-1?Q?aR5Dh1a0S6ONNrIUC3UjMjYhC1VoAusnF6zTuPKkoF1Nslk1v8GmuGoAad?=
 =?iso-8859-1?Q?xejoycPUojnyw09lOnNMZsHxulvSwWLQzGT293hDmzL90LhawliyDenvyr?=
 =?iso-8859-1?Q?BRRwuljk5/0ogGAue4mt/q4V+BXkzb0KKSZvYaNgEjzx1e1SSi4Sf3OdDY?=
 =?iso-8859-1?Q?GASbtOnrBLwr2LFJrVfK4FEoISg3D9FWz27RwObrGYRatuV1p0+D15e30q?=
 =?iso-8859-1?Q?NDXiNVaQvdNdkpbCzed2Dtcg9n9pVKS+5oalwziXOrPVJPxAJaiGbVPdn9?=
 =?iso-8859-1?Q?o553rP79tA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB96466817A5809ACC6CF79210FC722DS3PR11MB9646namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: co5Dab7etXbY1Cx2mWwmhtl0f8SWy1xvH1FVHzKU0pXGUTLo9V4MumZZ29nlOvBvnV1COjiDg0B+cIq8Aj+0QPWzLv6HaiMuMJ3XD40TJSxWJ5QpgP2tp0Zeu1KvhNBaACgIWf4LbWROcaQqPme4TDz+ndI+TmOlU0qjh2PqSlFB+bIw68eMGsn/aYqQ2rH0CoVHNSjDeZHFUtwgdDkLfNJ+KTubPfe/cHZKDUcz5ek20xfIDYfLEECGTRpxZjZsxjfwmAAo1lEA6iopRRAi0BD9JnIeSebGnhL+Vf4pZBDRUjTtvzCehozMrlfchTTzigcCCSf0u0FD5B1dryJOpg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa4586e-f5fd-4c89-b8a7-08df3f3ce180
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 15:11:22.3771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWODxSsr5lEYo6GXK6ssIGjZlFYaWR03SfwwYzfYWayuNM6gMhkzBTfvO/CAATYhujyh3V/wLlQk44oUduV+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7522
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_DS3PR11MB96466817A5809ACC6CF79210FC722DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-11-10
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

The following are the proposed working dates for 26.11:

| Date             | Milestone        | Description                     |
|------------------|------------------|---------------------------------|
| 31 August 2026   | RFC/v1 patches   | Proposal deadline               |
| 16 October 2026  | 26.11-rc1        | API freeze                      |
| 02 November 2026 | 26.11-rc2        | PMD features freeze             |
| 10 November 2026 | 26.11-rc3        | Builtin apps features freeze    |
| 18 November 2026 | 26.11-rc4        | Documentation ready             |
| 25 November 2026 | 26.11.0          | Release                         |

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - 10 patches waiting for merge.
  - 7 patches in review/waiting.

- next-net-intel
  - 0 patches waiting for merge.
  - 30 patches in review/waiting.

- next-net-mlx
  - 11 patches waiting for merge.

- next-broadcom
  - 0 patches waiting for merge.
  - 5 patches in review/waiting.

- next-net-mvl
  - No update.

- next-eventdev
  - 2 patches waiting for merge.

- next-virtio
  - Merged for RC2.

- next-crypto
  - 8 patches waiting for merge.

- next-dts
  - 2 patches intended for RC3 but may need changes.

- main
  - Reviewing patches on IPC.
  - Looking at patches in libraries.
  - RC3 targeted 11-12.


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 25.11.4 - Available.
- 24.11.8 - Available.
- 23.11.8 - Available.

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



--_000_DS3PR11MB96466817A5809ACC6CF79210FC722DS3PR11MB9646namp_
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
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Release status meeting minutes 2026-11-10</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Agenda:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Release Dates</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Subtrees</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Roadmaps</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- LTS</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Defects</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Opens</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Participants:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- ARM</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Debian</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Intel</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Nvidia</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Red Hat</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Stephen Hemminger</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Release Dates</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
-------------</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
The following are the proposed working dates for 26.11:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Milestone &nbsp; &nbsp; =
&nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
|------------------|------------------|---------------------------------|</=
div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 31 August 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 16 October 2026 &nbsp;| 26.11-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API freeze=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;|</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 02 November 2026 | 26.11-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD features fr=
eeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 10 November 2026 | 26.11-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builtin apps fe=
atures freeze &nbsp; &nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 18 November 2026 | 26.11-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Documentation r=
eady &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 25 November 2026 | 26.11.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Release &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
See https://core.dpdk.org/roadmap/</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Subtrees</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
--------</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 10 patches waiting for merge.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 7 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-intel</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 0 patches waiting for merge.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 30 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mlx</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 11 patches waiting for merge.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 0 patches waiting for merge.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 5 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mvl</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-eventdev</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 2 patches waiting for merge.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-virtio</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merged for RC2.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-crypto</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 8 patches waiting for merge.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-dts</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 2 patches intended for RC3 but may need changes.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- main</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Reviewing patches on IPC.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Looking at patches in libraries.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RC3 targeted 11-12.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Other</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
-----</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - None.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
LTS</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
---</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
See also: https://core.dpdk.org/roadmap/#stable</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
LTS versions ongoing/released:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 25.11.4 - Available.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 24.11.8 - Available.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 23.11.8 - Available.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Older releases:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 20.11.10 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 19.11.14 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Distros</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Debian 13 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 25.04 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 24.04 LTS contains DPDK v23.11</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RHEL 9 contains DPDK 24.11</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Defects</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
-------</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Bugzilla links, 'Bugs', &nbsp;added for hosted projects</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - https://www.dpdk.org/hosted-projects/</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
DPDK Release Status Meetings</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
----------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
status of the main tree and sub-trees, and for project managers to track</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
progress or milestone dates.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
You don't need an invite to join the meeting but if you want a calendar rem=
inder just</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
send an email to &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; =
for the invite.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS3PR11MB96466817A5809ACC6CF79210FC722DS3PR11MB9646namp_--
