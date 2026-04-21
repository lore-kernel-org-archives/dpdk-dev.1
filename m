Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D5AF8FA7E
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 14:02:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F9154029D;
	Tue, 21 Apr 2026 16:02:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C80054027C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 16:02:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776780136; x=1808316136;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=T1X31wOFschbXvvQrkaQXR2s0iemJS7zAcc5zSUQx0M=;
 b=JSfj/Bw0BAvbICiUhPUWUUA9/4URl0Wrx7Hu6kbGQgTSSg4l5qCJM8wL
 e9auWXFbvgQiBJrcQBkee6jBO4cZAOcUGIB5OjJIJkGFAkajmG7FCbZ8T
 xtj2ahQb/XCGnEXE6vTp9etkJ/Sx5f9bzQ+I6uaTy/wyrQLWyWRcZ8CLG
 1gMHu5fthDe9r8zbEvoQymsTtVWmgwXdtthyOQ81Upl0KgcG/nvd1Wve0
 XyKMlTMXvLOPfVI7qa1C3c1iaUdHsS0+AkP7EbgvghIEaFs02F2X7tlFs
 43QmoEJQ8aABzo3ZM72PmDkwCaOUReXN23Z7OmpySF6KIl7W/8Yb8yCFK Q==;
X-CSE-ConnectionGUID: Ji0RSYhfTqeLnLa972jncQ==
X-CSE-MsgGUID: PPv8ooNQRPaRB2riFIUkEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89182997"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208,217";a="89182997"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 07:02:09 -0700
X-CSE-ConnectionGUID: tjJDBaECSEqtUtt2axvb6w==
X-CSE-MsgGUID: i21uIpDfSLmVFZP+s3/5cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
 d="scan'208,217";a="231912960"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 07:02:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 07:02:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 07:02:07 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 07:02:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9jnFPdOZSeaSTB5AsUkZbmnWeqxtfYOGXaTW8sk8tRnMqdOn5jU3/5Zn5qkpECfhGKsqD7w+pBZoTHP12TfpUdmyP3Qcu+hYbk+Gm0TaLpzncfEW296dGTyMXQPDNdh994lwunfMaVqUMqNWjb9EUBahjlEkrhSUf/PV5HqJdXK9c9u7d//1NRpS10OYw7jAaqJFu+QgZkucWKQuoIIi6E2G2BofMLZ1G/6B7MdFPXLD2NHwyM1Z8wxOqA8rOsc1fjs9TfFOWz7lFYc7fiqj/1lyhb3k80A23Gy0nA+Ki7hsv7eOv4deRgRvZjXPv7YQRrr4PUDyxiqjkVKno0Czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfFu3vQCwJD24bQE9yRV7Pnq3japXzO0wH+aPZXsVj0=;
 b=fLcpGEZA5rttAQxPxmPM/1H6B1VfvJcaStp+lf42fM1EEDJEXu9Kd/6pe5M/W/u2gVJB9vaVvl0N7tf1iuwj1YjvQHwHlmWcF9KodfuyKVXqrXcxE8hP2moXlElMRWcIFim8dXooO4KJ6K7gDCLX51JLJOlP1iP959TSmJ0O4oFStMKdJ58Uqo/WWx1JxAqnRivaHg87FcHvc3gbof7OY6zL7tl58/WTma7dClYB3mnWnc7ckM+dOLuzvYrFf1hIpVcpvfU/OEETvm29jjWN74zupWt2C16J4EuzqN3IYIl+nnD9Yb5gZQ7nTWnMpK0d48YcDvnJoTwOqd7Gx0KF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by SA3PR11MB8004.namprd11.prod.outlook.com (2603:10b6:806:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:01:59 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:01:59 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-04-21
Thread-Topic: DPDK Release Status Meeting 2026-04-21
Thread-Index: AQHc0Zc+nF9oxmWOFUSJpyCmAHiDtg==
Date: Tue, 21 Apr 2026 14:01:59 +0000
Message-ID: <CY5PR11MB6318790E935CAC864F16CDE8FC2C2@CY5PR11MB6318.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|SA3PR11MB8004:EE_
x-ms-office365-filtering-correlation-id: f48a2637-c2aa-47be-7945-08de9fae8e39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|38070700021|8096899003;
x-microsoft-antispam-message-info: 0IZG4bhbUY2DNIn2Bx+4gjEiNu05Vvn/8+Vx2vMcx4PI8kUqEBgof5A04guIZ46ugdxo96l123zu2AaJSsS0OJI496smh1ey3XdJW7TEZFgfVKzgxwmLrvZE7lRYSz1xe9bWHrybPRPmLLXinitSNmueJITOqX+0+9Zt6yBZu07oHAZNxsPQ7AoBbGeq9AYU9tVFQiTBHznPOc2uPy4iK69WU60+1Ua8f+3ARgDm9Wj6RvGCnX/98BaPCVqIPKJNwFjrAvU0DeJ+cN5erGxwk9JjRa/Uyb/PgQKieJlFs3IIwtjF6RXlpTZJZZ3+7ChtN5uIBbEUsGQiW5l7hV3jRTAw+Bj25CgNbBYkBDMrNOqRZ0+fRfPxYYjLsa0kY852rZuNJBOPGgdNvhCGcoY5//HVCY4+miI8dQW1FVPlphoHK12bvMnLeUHdUg4RFtMlBmJek4dQthiQUTvaGtu3ZidNYXj/B6xRsZ3tCSo2AeQV/bIhkwchDEawASn7QcoegiFtjhWw6Z347luijBD//WSV4sot1y+0/lxTNPTexwpejW2gbnp/ltRuAZdf9kQB6D2NPuW1J3bM+9srUWknByyt4Xze74gIz/FQNfCPcu2a30BYV9eMy7Y+QYrejeGzVYY5xDwCn8X7G1Edoz5M1gCMrmsDTV7ESS8A1jtMLMw2iYP73+Kvr5/2ZoC/jplBzk0Nc/wm1/XTqk2+DOEJ97BFOtxOC1JCp+WVftUeE3+v+6BfbPrZEwX70byoUDRl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zwgj92UmX4RzlJpk0ZWR0eMlT53/d5tMI4gKJmpmrFbF7GGWMmgT/i9d4D?=
 =?iso-8859-1?Q?e0sib0y0/czRHqIOJLp3O0LEKLJ7mmjoM0qvHejnOulwZWnBx4HOoC7Y78?=
 =?iso-8859-1?Q?xeSjZuFYwIOYd/ZQeogg6Y1EN0A2S9+j3LgU0sbQkPJwv8p2aImyryt3Rv?=
 =?iso-8859-1?Q?YlTTSf8ynENyDpx5NotUcIf08f+Hx5eYStKHYo/r+FtlqUEmkQVxZ1qELo?=
 =?iso-8859-1?Q?JhePamjUPxRkYw5Gx1h0xGlqaJ67txp7qdWOB3OuBykU1IS3y0enYx6LlI?=
 =?iso-8859-1?Q?53LqD/viBpJxT58iAGNa+smG4rFUb+wvJQg4T2VJxo140Py0trPmsGSEcm?=
 =?iso-8859-1?Q?8GRUnjIESQxXZW0M1BWEdqhEjS6S1jjP8RQY3StiPqXz2jw70atvV+Fc+2?=
 =?iso-8859-1?Q?47p+cc+C7R7XqyZrJvRfNbYK87wh8ozFk+0PWsX4dZUXITwXwlnz1B9a73?=
 =?iso-8859-1?Q?4Ou0Kjsaaq6WSSRruZbbbdkyZWunillGg692QHIoS13c71klAicK2l8mQF?=
 =?iso-8859-1?Q?AoNJJVCx09VU0rwRSv4JSxNnTPYUlLQUeGM7prHmWsQCvWBOOBL+hxdAdZ?=
 =?iso-8859-1?Q?Y8O+Y+DRlrjj9Igh718HOktRNhku011YXgQLDGRv6qNIPjoR5B4zjQmUpv?=
 =?iso-8859-1?Q?814QFq7h8qiwoZVgXacwM/Lb7B2XJNhI64qvh/AoiY3FJVPhzmaOOivmZi?=
 =?iso-8859-1?Q?WHkf7DT4MNvWLmiEL9zw8NAkG4GMm7kBVG67a5G9BRTvbU03LalHqSW409?=
 =?iso-8859-1?Q?HI8FklFdjqYndKiB5SM31EpwyxWw/jUd4x73iKUkpm+UTHc6niPwxQ9kQF?=
 =?iso-8859-1?Q?ac03Ozh3ctHbI3vMnU5V83Rg6I3M/6D8E509Qk7WahCXniYN4+Lb1XBTyJ?=
 =?iso-8859-1?Q?qi8DUmoyQSbW8PG7SwizwIJVPM26veGATO7oVadUYkeHVECRKyLPLL3oxd?=
 =?iso-8859-1?Q?eF/8y3hpS2wXwn9riUdSKM8GoE5bwGxojvy70qaDpxh+cG2pGU6iv28cuD?=
 =?iso-8859-1?Q?1Zd7ri1JTpZZUpGl9iz6BpTt78e6GeOQdjY/RRuDwDAQvUrVnV9iM+UYF6?=
 =?iso-8859-1?Q?O3g32DD1c3JcxNEJiGm59QJ8BthsaJtp44+1kgG3tBS/fqdLf8aUKXwg3t?=
 =?iso-8859-1?Q?dbcTJjXSBkO55FMhQEWQXGJMJtyOlFkAF99JwjXxt2b61hGBOld92SEnpC?=
 =?iso-8859-1?Q?YucwR5Gx+EyGpDSBeh50lq1S9AbzPuriD28B+OJ66U4s7EQ5n/918V5gNg?=
 =?iso-8859-1?Q?KbRgQH/Cy55zEW0rcQOza62UnUf3CCtD5cxVEinLw/AWvDNFuYcrEYF9eA?=
 =?iso-8859-1?Q?OuJdzDiQvihxAns6Xz4sYiRYSQ6q8hTTkAWPFUJHPirglu9AlYJVD7A6ov?=
 =?iso-8859-1?Q?HmC6nTl4cx9l4Vd3QwHUzAHBi31nu5yETIGB8xqRb7/DyWLpnuQeVpPGcU?=
 =?iso-8859-1?Q?W2k5IBcFkuW8q5cQAwR3LrQQXAw/gytFCH20uVA9rvapyrfuqcXVzXcLpK?=
 =?iso-8859-1?Q?9OuCqhfa1gny14g3WNrDOaf1DBCQ3A9fPvMT1xXHG25r9J2RU4UeUwqqxE?=
 =?iso-8859-1?Q?7VIagNAfwb8/pLY1hZ7E6/KWx0uHCxViotZOFDeUWYa2izG8OPY0cLVFPE?=
 =?iso-8859-1?Q?aWW3lkLBd3S7D5QNpncGlVjFIA9vAMA1oLMgk8uzsNHFnhXPbtau0HFoJK?=
 =?iso-8859-1?Q?VWN/AGOxTCfQ94p4Ijz0f0QIT4QUxwohBdHyaX5iJf8COc+alggIwbqTJw?=
 =?iso-8859-1?Q?U1E34iTp/m9e+dIc8uDqRDOaoB69IGgl0Qmx5/XwQ9q5kwlHpX8vVoVPzJ?=
 =?iso-8859-1?Q?ysTStB09eg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB6318790E935CAC864F16CDE8FC2C2CY5PR11MB6318namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B+EgIQXxVnF2FBvB7sOZp2rHbYb0fvEVTRRB1fufC1drvqsctTeGDvCx/3pCPBvkP87+yqZ+iw1GBgZPTKikDCUV+6oDvAhdtc+1H6c03i+2xq/xHZxWWsG9Zu0BYuphH3oex/7dx9dIugMerYm4ZzarpIZT4wU0B6oiX2sW6xwn2SIumtr+fGRjwW/lrXQVIV69/zp0ga9ZHb+uOVBRhufjMocrWgcCf7tul9nDESb3u6EDG8dtguAkqZQ7ipXnHZqIuTFz8ILmFwZXfojn9M9tGZAOXWZaRfLy7VQJsaI1fhlsz3OKO6IqSePiYhYYjmUYIuLl4sye0gwC/Zersg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48a2637-c2aa-47be-7945-08de9fae8e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 14:01:59.1294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkAQ9LoZDG8wMHb6JtzrFY0Cc/J2VINW8hQKwkFhc2gQn0VsSbX+jtDJdVDyRVTFZo7eM1YwTXQX+XRoaY9YZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8004
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

--_000_CY5PR11MB6318790E935CAC864F16CDE8FC2C2CY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-04-21
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
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 26.07:

| Date            | Milestone        | Description                     |
|-----------------|------------------|---------------------------------|
| 30 April 2026   | RFC/v1 patches   | Proposal deadline               |
| 04 June 2026    | 26.07-rc1        | API freeze                      |
| 25 June 2026    | 26.07-rc2        | PMD features freeze             |
| 02 July 2026    | 26.07-rc3        | Builtin apps features freeze    |
| 9 July 2026     | 26.07-rc4        | Documentation ready             |
| 16 July 2026    | 26.07.0          | Release                         |


See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - 12 patches pending for merge.
  - 11 patches in review/waiting.

- next-net-intel
  - 29 patches applied.
  - 13 patches in backlog.

- next-net-mlx
  - 11 patches merged.
  - Some patches in the backlog.

- next-broadcom
  - Some patches in backlog.

- next-net-mvl
  - No update.

- next-eventdev
  - No update.

- next-baseband
  - No changes.

- next-virtio
  - Series for ASID under review.

- next-crypto
  - No update.

- next-dts
  - No update.

- main
  - Working on grout
  - V1 deadline 30 April 2026


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 25.11.1 - Release pending.
- 24.11.5 - Released.
- 23.11.7 - In progress.

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



--_000_CY5PR11MB6318790E935CAC864F16CDE8FC2C2CY5PR11MB6318namp_
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
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Release status meeting minutes 2026-04-21</div>
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
The following are the proposed working dates for 26.07:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Milestone &nbsp; &nbsp; &=
nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
|-----------------|------------------|---------------------------------|</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 30 April 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 04 June 2026 &nbsp; &nbsp;| 26.07-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API fr=
eeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 25 June 2026 &nbsp; &nbsp;| 26.07-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD fe=
atures freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 02 July 2026 &nbsp; &nbsp;| 26.07-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builti=
n apps features freeze &nbsp; &nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 9 July 2026 &nbsp; &nbsp; | 26.07-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Docume=
ntation ready &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 16 July 2026 &nbsp; &nbsp;| 26.07.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| R=
elease &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; |</div>
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
&nbsp; - 12 patches pending for merge.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 11 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-intel</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 29 patches applied.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 13 patches in backlog.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mlx</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 11 patches merged.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Some patches in the backlog.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Some patches in backlog.</div>
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
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-baseband</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No changes.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-virtio</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Series for ASID under review.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-crypto</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-dts</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- main</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Working on grout</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - V1 deadline 30 April 2026</div>
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
- 25.11.1 - Release pending.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 24.11.5 - Released.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 23.11.7 - In progress.</div>
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_CY5PR11MB6318790E935CAC864F16CDE8FC2C2CY5PR11MB6318namp_--
