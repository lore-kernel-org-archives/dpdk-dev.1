Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C005CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 13:58:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3929240277;
	Tue, 19 Aug 2025 15:58:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 346AB4026A
 for <dev@dpdk.org>; Tue, 19 Aug 2025 15:58:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755611937; x=1787147937;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=+x1SybSyx4cfOHa5PsGnsR7ogwRZf6X61H+eeL5D/MI=;
 b=WNJYnwLwoMqU9TqpmuIdCDj5c+gLRlU88Tahap6UmaZsAvYh0PA1Y6C2
 HXq+zpJyR5aSHJIT27z+xKXtdFI0g8uwpuISqJIOQVRbFTXTX+xuUhBYa
 vQfh97PIdAKUp047ufpUOwn/85jkDxsVnPPRXx/1CQefXKw1eF4EQJxOH
 8yYkvuSa6vievnE0kNxk510d9sy2IzPRUbre92Y6rHXGfR/KjW45GgOw1
 vKVHzvnNchYOw+GROsN+LZb2M6Tn5+5fsQa7rdFkRkqfii6zizf4e2zio
 l045yQ8egwYIjIBD9WpNGj5/xK2MBZba98IJsp+lrHeUZ21E7AtoyGFNU g==;
X-CSE-ConnectionGUID: iavsYAAfTpuxV2fBxuXXJg==
X-CSE-MsgGUID: ohOO5oh9Qxu65eBJO2CDVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69308494"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208,217";a="69308494"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 06:58:55 -0700
X-CSE-ConnectionGUID: 8EN4Su/STJOUgHvP2FmtcA==
X-CSE-MsgGUID: wFVVXHGSQIaCDFMH4g2x9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
 d="scan'208,217";a="173091810"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 06:58:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 06:58:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 06:58:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 06:58:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0mHMYLm9dv+PuCb6g4dqIlKIqGvt2/B0Iayd/0S2KEw4uaaUwjYH4M/7S0r8ls+KsdW4E89r7QnxZmHYWnCXrEnd+Onc1OP23wvy9DQwQHxFgL621OnX8BY059KjP8688bv0RZrNwDXrUd3V5lZhpnxKnGc5L+2qwaMaS1RjoB7jIIWY9cB6/T1+0qKLAjr4uYMqIyO5mIEM1DXs/3aA3Bp4iiivzNf6t6bpiJs+MmdzBBoj/OirGERChGFYW4rED1H4r5ixSPI5jvPZ/7xV0RqfhKOzC3xDDTUTxySdoL1gN0VeIyBwbEiistRVCe4XYhTePBJP0SIkYlnbbSIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMPe/B+ZbsyM08UaRwPOoUmTOJd2CLWBjgChLzqVMWo=;
 b=JrV3P+If2WrxrFBu+a1uwVlmIkDQgW3XD0+e3qVYY5UNi7elRU0N5/RCydHMWbk9FZsPupvKEMiDiidS5aApYGnqKQMdJFCvTM6Hlv1mdd57vtix+cNrcWbripRD/dQzUgMndi4GA6MMb7Ro63oOR+sWN5XlH3mDDCv/kCqqXgKOL7QWmJKZIiG8iNNc5UyHXN/fQxHA/pVoEl2VXAKzxaw0QxR9DecKP4zv/a/jTxyHIhHKa6b1JfdIe3SxXRTfmyXgz9l9BO+pdKlpsgyMC9XXtMQUzyp+EF/ZEjQHUgauwLMGLPidGdTba+7ZS28fhIh+Ya+BDkPYv4c6HUbMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 13:58:47 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:58:47 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-08-19
Thread-Topic: DPDK Release Status Meeting 2025-08-19
Thread-Index: AdwREULm2Ch3FL2BSxqpdN3OTm2TTA==
Date: Tue, 19 Aug 2025 13:58:47 +0000
Message-ID: <PH3PPF37F43E35D3C7B5EBC9FC6A52B3611FC30A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|SA1PR11MB6760:EE_
x-ms-office365-filtering-correlation-id: 443915df-f214-4c9a-cd18-08dddf28848e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gmb71reuPghe7XI/WwYQ2AN88fgjFZ8PDRigACq9P/Ewf9Wt1EmBIIkxLh/u?=
 =?us-ascii?Q?5/0BzmHUu4MsTnqaVmr89/lr0wQRGxa9v6Y5OHGDcKidQa7IDgiE7uPAiQvt?=
 =?us-ascii?Q?TCiSpiwSlYglaEGo0JUb4X45Zn/Dx+DQUebyp2Wf+X+0yZmoLE0tckZ9Ry32?=
 =?us-ascii?Q?fFOq42Eq7SkVn4H+IJDe62XuKIq/6NzuBbj9P2xKyZOO7LsJgnPoXbzXooLZ?=
 =?us-ascii?Q?cKnpuVXrNAbPG4Jo9Dwa026h/SCjG2JWDug4WdK9IneV/HmXtUGJ2hyrzlZz?=
 =?us-ascii?Q?VuiV+cZ9WiyTcOwYck7nGbHcYZkspwszW/ZFfx7U2m7VMOVIaZ18dJH+tKdg?=
 =?us-ascii?Q?UHjKabQg81SVXpF9cLQhhWgThKWfFeqqBvehaYjrZwmFrLsNs0K4nzxzc0Cw?=
 =?us-ascii?Q?ndi2Gjojb8bBcaVEDArB+1C6bvy5GjHCibga7SwHdYuzvKCjMMS9UU6D3xNK?=
 =?us-ascii?Q?LXY2V6PK5Ze7mqawrYzpryw81sO5iPMCweKvgG2iqAbd72zlkFO+o8hAegAr?=
 =?us-ascii?Q?FcgNZqJlopNIlLapZ+7jbyoe+zCz9k8FfBF1lwjLB/OuBUAro+cnJaLmTxsj?=
 =?us-ascii?Q?FHw206kB3MuHQI3In5IEWYKCbq11OjVkDxxVqT9ilPNgZzlHcZwjjCTlB7J8?=
 =?us-ascii?Q?vuvuYOprWaBNvxbFFcORLvVbTxJO3F/ZJ2QT5pddHmEozxm3v4THECBXvywc?=
 =?us-ascii?Q?u+xcACSN3Y6jbpcIMqfoqe6j7f79QcvdYeI6FEZ2x+RE2/tHUdpIXpZYd99e?=
 =?us-ascii?Q?EK0V8gWAJNH/6s0h8zRQpeES3tdvZFONOk1Oz8dosmgJWSHtqj7qhfLyucT1?=
 =?us-ascii?Q?ilmZXHl5dCsegw2Q7AmWCr9xSJY8HeTfkjcDot5/NTJOFDGTWy/4dUcJjwjd?=
 =?us-ascii?Q?KVLs/dXONYimWO/HDF29/+6HAzTrr8xgMo7sC9M1ZvGdPGGWtA+bdNwL++iK?=
 =?us-ascii?Q?p8X/qEb+yk/BfQPjpBGuYwyYmFIpkdriEaxlyWbiT0Cn14grdnEDEK3y2Wuq?=
 =?us-ascii?Q?z4SlBJ1kUrH6S3lkzMWqUJkMZH3LP8nwx4qygqWPa7V7hrjaeA3hb2fgcx0k?=
 =?us-ascii?Q?s857FMecZ6PO0s3ekrSq7qy+TziPnx1xiviNHoVkc7/mrfZ/pVH/w1KQquzy?=
 =?us-ascii?Q?vuyRztc/HNNmiLl67PoSFytxsinSndayUDg99lw04pJwoliyA+7xKj6oUDxz?=
 =?us-ascii?Q?oFCXfb6cHgH0cCz5mVoqQwcwcfY19kj8qd/o9C+Ian/HR1SdyFOCL12N18RX?=
 =?us-ascii?Q?gQTI/x+5RT5Oy5I0b6CxtzKcUr277zWUQUXHtvIE++QzaikMjz1CayOdsEVu?=
 =?us-ascii?Q?C703th9+zPG4USccZbUCSre4P8bKNlXwNDzSBSB2q9bQHHIvLLkKNABPb8Ah?=
 =?us-ascii?Q?PNvBUKQrfgFwZkx8cshZ8us1IGsngnleipyVRX0iHvlC98YzyPvn8XJUGWYu?=
 =?us-ascii?Q?Gjd0SJ0e0Fg/W4jxN88ssLe1QecDJLjB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bE4VWGmSVR/gSGfh5ia/h0NB7tLw3dwasMRerkESm7XMUjEcr9w7NOcSNqLo?=
 =?us-ascii?Q?SSX4ZW1m1rNw9LmWfeh689iqid0ZdAmJ0Tb5vLtW2/7s5t3YcLLyR3S2b7Kw?=
 =?us-ascii?Q?2zKHKBEA5j6T80zXD+pbgnMNkI/oKMXddUN6gRaw3nBrndx5ld2aqhS76hNP?=
 =?us-ascii?Q?/FSCvLYwUW68YbW9GUWNn/L1tY755QWLJjBBSLXqAPSXIuppSWvTSVXAmkZl?=
 =?us-ascii?Q?dneUwV6Mvyuf42OL4fQCLDLltac00MVdbfA9jEZbudqjTWle5nTOn7CHaBKC?=
 =?us-ascii?Q?vmUA36KsMkgguRRHSmTLs+Ax6i3E6ZCOgFTWHKvLdAMHUiLyhmYnWe7lv6Ee?=
 =?us-ascii?Q?nQ4mUUbUSMi83rr+Wd5S0iro0uACJ3d1+x0bFLWGIaFpDcGAIujkgSWy1n7W?=
 =?us-ascii?Q?oJuFCJl3lQ3T9HoV91sNtoVNSKHsm70CAfcKUIUSaQSX42WPjJb1wV1PMgUJ?=
 =?us-ascii?Q?bkzQEn3xl/horgBCcbBaKojsXLeHjd21w1tmE3u/Y8WbZogpbBN4Xg6TUqAn?=
 =?us-ascii?Q?TjUN9X7tewsmoGqtk+IBFiItrPDrAYZpm661614oAGuClfpcja4DZjMyYjpQ?=
 =?us-ascii?Q?FLIsB65z05YfoV7U4/osHfKyt79rdfokCLhp1uz+GjT+YkmILW4lAQUk8wJn?=
 =?us-ascii?Q?HL3YPwxyf2X+FsowXzehtCZCPP+P4Xk6ufRbZjdBl1U3xeyYL2QlW2V6U9bh?=
 =?us-ascii?Q?W1oOxYdzYURG1CK15C7rozHxwrzykDFqHFY1MVMQNLyZzPdNwIt8pLjGFRWp?=
 =?us-ascii?Q?Aisd25wz4lcWQpU0YDjAkdV1SLJh1RygOadYsvhlEHNhCU89/o6QqHuCeEXI?=
 =?us-ascii?Q?AVEUM97wA75TEZkeo4Wqg+bw6pEiewFu5xa3cAXOcDKO4H8HAF+6CcksLYOd?=
 =?us-ascii?Q?CIFBsSxlCbnUiChsso1ZYb1cXz9UzO85bLW3u0lf3yJKb7vflpYx0rqMSHPZ?=
 =?us-ascii?Q?9C2GGzpwArz+ZVbdML+0dakaHptSQM07Nok8HdIwcfI2HpLI3snf8L9O4cxt?=
 =?us-ascii?Q?s5+ARuX6TzfM6qXkN8zNjMFEreXXvvJFULQL5pfEi1t5iLFUxSk9F56yuVuU?=
 =?us-ascii?Q?yT0hLIXPGNcPPA1rghdzxLXUoXKrJWHov5kHuTgC+xsIJk7yi+kjwKSeVgWy?=
 =?us-ascii?Q?S8E79gxllgYzZyhht3lzknvDbxapzU/jTVd1ELBRd6yYtsvdIQouCe0YTBoO?=
 =?us-ascii?Q?9eNhOtbVjx2nnt+8nmhXXVUsG2tL7IgQcRQBjWMNJrW2XeqgvMtQ+NzjT8QI?=
 =?us-ascii?Q?unVsPc2pztarK0m6lxUyk7nhWNIjIDs4wZcbOCWkiMDCC0531KI7kTT4EPWB?=
 =?us-ascii?Q?xFTk13E1Gv4f98P7KP0DOMapBNtBbD4NADstwkuGQ1eac4vZQMRbPYwek+LA?=
 =?us-ascii?Q?N8DqZCR6zsthq9FCi+FQpsF3BhhnKKcCk9+hwX2mn+Pt6bFt+PSmcfzu97Lc?=
 =?us-ascii?Q?fEd3n8OzvR9GwYtnqhx0JoMIg0FkjueqMmYmxnKre85CcuHPLNrC8DcXLfB0?=
 =?us-ascii?Q?qdmYBL/yb4G7H84q5IW5yeAITAKe+rgN3udczh+7YSThwirxbEpVBkCMv4JG?=
 =?us-ascii?Q?vkrggUazLWBFQOJNn7ZO4gSv9YMgEkIhVbnQeIxl?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D3C7B5EBC9FC6A52B3611FC30APH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443915df-f214-4c9a-cd18-08dddf28848e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 13:58:47.1727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obT2QpTj8ig8kbS+Qnaixmsz1lbL1rgDugbkNEQiWDEWvUBIuPeTz/bJJ1ot418BJmz44RG29HfgxJ6TZ3JgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6760
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

--_000_PH3PPF37F43E35D3C7B5EBC9FC6A52B3611FC30APH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-08-19
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
* ARM
* Debian
* Intel
* Marvell
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.11:

- Proposal deadline (RFC/v1 patches): 31 August 2025
- API freeze (-rc1): 6 October 2025
- PMD features freeze (-rc2): 27 October 2025
- Builtin applications features freeze (-rc3): 3 November 2025
- Release: 19 November 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * Some patches merged.

* next-net-intel
  * 8 patches applied and 24 in the backlog.

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * Some patches merged.

* next-net-mvl
  * No updates this week.

* next-eventdev
  * No updates this week.

* next-baseband
  * No patches in backlog.

* next-virtio
  * 1 fix but not much other activity yet.

* next-crypto
  * Nothing merged yet but 4-5 patches in the backlog.

* next-dts
  * Luca Vizzarro is the new maintainer.
  * Some minor patches applied.

* main
  * 25.11 in progress.
  * Proposed roadmap milestones: https://core.dpdk.org/roadmap/



Other
-----
  - None.

LTS
---

Released LTS versions:

* 24.11.3 - Released 2025-08-19.
* 23.11.5 - RC1 released.
* 22.11.9 - Waiting for final test results.

See https://core.dpdk.org/roadmap/#dates

* 20.11.10 - Will only be updated with CVE and critical fixes.
* 19.11.14 - Will only be updated with CVE and critical fixes.


* Distros
  * Debian 12 contains DPDK v22.11
  * Ubuntu 25.04 contains DPDK v24.11
  * Ubuntu 24.04 LTS contains DPDK v23.11
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


--_000_PH3PPF37F43E35D3C7B5EBC9FC6A52B3611FC30APH3PPF37F43E35D_
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
meeting minutes 2025-08-19<o:p></o:p></span></p>
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
re the proposed working dates for 25.11:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 31 August 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 6 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 27 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 3 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 19 N=
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 8 patc=
hes applied and 24 in the backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No pat=
ches in backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 fix =
but not much other activity yet.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Nothin=
g merged yet but 4-5 patches in the backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Luca V=
izzarro is the new maintainer.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some m=
inor patches applied.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 25.11 =
in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Propos=
ed roadmap milestones: https://core.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; <o:p></o=
:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.3 - Rel=
eased 2025-08-19.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.5 - RC1=
 released.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.9 - Wai=
ting for final test results.<o:p></o:p></span></p>
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
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH3PPF37F43E35D3C7B5EBC9FC6A52B3611FC30APH3PPF37F43E35D_--
