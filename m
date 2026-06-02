Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C314CD6E60
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 16:56:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67502402AB;
	Tue,  2 Jun 2026 18:56:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0472D402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 18:56:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780419379; x=1811955379;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=xOJcvkMf+8PE0XxFph2Aw8WYd9yqd13zQH01YaXbZew=;
 b=Ayr+pjW+JxyhDfPW8verICpKrxN6dOrchZEVTwoKKKgPZx1CkjuCFDgn
 shggX8nhUY2gtRsk0stvnceK2LKScFd06PIXVyhTvYEPpNTIgnailV8Oa
 LxCFF20A30ldt4n6mx2aqKKcEqNmr1at1r/9W5tZ7crXsdsQ6OxY+C8k2
 ckR3OI7PUn8DsnYlRT2HP5W0uB+mXhbcoHdsW1bsNhwIivxHqLILclY7M
 TkKC0twv8iPQvhfAy/e2PM8U/0XgLSLNiLeOwOtFGgCB4zK01BbymKEBa
 7beDdRLw3wjaD2oNWOaFiMqaonM+pFlFJvCdGsdkjiup1iAxBMnIvi8+L w==;
X-CSE-ConnectionGUID: BmCxJDHIRcGuCNlDP4pHQQ==
X-CSE-MsgGUID: rtnm3pVsRsKatzKv7Ui7qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80243138"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208,217";a="80243138"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 09:56:18 -0700
X-CSE-ConnectionGUID: 7XBhT6iLTcyz3iqrYkImXQ==
X-CSE-MsgGUID: kDs0Ukb9ROCdE551IJ8fXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
 d="scan'208,217";a="248890385"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 09:56:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 09:56:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 09:56:17 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 09:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUvaAaEhW/tANPZxNygcCmPOuF1XBnWKcxfQ+KjL2HnVgXXRju/uf73hmlrn0TdW56pWTZjYvUujCAweYOAdK+z+5ikn96I5RR+LN4anEFMrCmVS4gwwCvZMZel0gwSdNY1jUqT1e5Mo6jodjdo4wxQCjOWQvlnMRHB8b0Ngm8oeIQfugfyQ7NoD0Djv3BaVezTUqkaXFDnhS7PxaVCF/XvNJgyHC9W+JOVS5IGKeJPl2PFBh4gsu0uY5470X3AsxY9V92o6mfyePRTGjLOeyyq7FYhI0A2bSNl18e4o02aRQvJMSUUVb7Bq41tL92K9o9B/hZRcrsRKRGDLcB/MCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HlPXvp5qfukvas9X3lXmZg+WxEh5UGetmbmeS7fi1s=;
 b=G7nWnhAMzhOHbTEoeHh4csc7we7N0Naf6THGGVrcCk93T408IEuoxleDDsSGh0XNL1CvbkmTkMHyi1OxRXCopJflzDtLDBCGsKvByHrgVxGevAE7VsEem32KugFuG9nj5lW/1IC8e0PYxsrWiFngQkwFAIrg5q+DPwQ3GgYMh9pfLdSOZcKUipEkiYs4HgybK/s+LRb+G6ooV1XUpDz4DFbvibmpq1SA2J72eNJ7DWti2FJhZYhukvrlu/HrCtQjN9QzsQFcrEDVhOvJsyusBzeCQvE6cD5Q+g9yUeTgCVT/yP8VbiJwt3EGZva744+IWuFxAHCn1CPXo3yqeeyyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 16:56:08 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 16:56:08 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-06-02
Thread-Topic: DPDK Release Status Meeting 2026-06-02
Thread-Index: AQHc8q+kKRpwyjwIAUGb3jFeRXh7YQ==
Date: Tue, 2 Jun 2026 16:56:08 +0000
Message-ID: <DS3PR11MB96466545C80EEF8FA8BADCAAFC122@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|MW5PR11MB5785:EE_
x-ms-office365-filtering-correlation-id: 375b858e-f4b9-45ab-e87c-08dec0c7d795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|8096899003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: gYkoNSVe/JCMjH9xOTfvfDYbBGrdO3hJOIqLrWNvUrs9/eaygIR3Pj+zrXthC28SdD6JC05tu3nVTncIsln5cDLWUA/yr3P2kUx8h+ZNg+7xjmU9Spk/U8HC5htwy2f5bGEu6CKUslWYicDB1D7bE/eCAVR3H+an5+OEn1GR7WhKHFi1zW0QiDD13daEM3UcFbuz9SZwUcF6UWWQkDck3ZWn8nVaGcpJttO8Nm2pEryOZCXlayFwD4cg2gHqgPuBDmLrg0D6GYwWRTOI+ZktLsslPFG8vR+juiZJHdAeC4bW2lEYcNDmvU+nENDvUtgZbz4l19nLdGD2sBFNvhMG7gDLvO0C0JCAtpLdgs1BL6d3Kj3RGdMNPPV5AmzhwI32CD/6SvRmJpODenZJzpR+FQ8GgWUJbi1GOkVjInj37bhSEnntmxGDNrZFVFcT3GHBwFSl9GhUd9fkomYuryIbo5i57bQ+P0QvrZsaSA053BrhsTt8jL9bLyzbbV8zq5uMOxGWk2I7sbx946P6FG6vtwKidwlX4wbifdgAHocN8XFT91YvOcFDHAjJF+kPmJks84gZfCTFbIgNGch20Xnh02zJC+9iODBoULAMROTMvRfj2w+v6QHx754n7zYgiBfFAPAwv7SVqoTL8JqycHv7CTPfsNzTqRVZD4BKzRHo7ekE73rcnm6I7xAKV92piximTVeuHS6VopY47IkvCUF9KQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q+H2WE5JgOhzdyEM1kzK1wYF0vfjgRckTYgt9cnm+lV+a+VbqHScfEzPkE?=
 =?iso-8859-1?Q?9AOADHh4m9eZINy4IEXbeq8JzvZNtcJR6gUCSfH5mh+lMZ5RxM5CNiqlS3?=
 =?iso-8859-1?Q?7XfvkjrNkDeUDIFHg8tV8jL4mgGUqRXzEilTwGKktzry5xrwphph5g9o67?=
 =?iso-8859-1?Q?tTGrFt/Q8kaaTTgC6d0b0P/ZIjyxdwuVxTEiIKDq+2/a+wLDIBDjdLOsop?=
 =?iso-8859-1?Q?bmbgoBf07gC+yEq4kqlj5uPUGBD9mHyCcgkS/6gp2ATlYzNg629Q3i60pN?=
 =?iso-8859-1?Q?aKrmWqxEKj0niyxsXrprsrPNawEfKRpJON+fIK14nGoZKWBDmG4QWm4FQT?=
 =?iso-8859-1?Q?reyCgeNkpFd/axP7bOMne1wpB/zSzz/kGstAzd5adYOorE/OWD0aGzHchZ?=
 =?iso-8859-1?Q?6DaVkEhZUs+AbdnYzhoSb9am8qHHl19Yf9LiLr/9UUhf+F7PY1sVDGp1nD?=
 =?iso-8859-1?Q?WjyUAj9R9mZH0MfpKz0QpVto/pX8nRDSqUKXL/1woXOlauTGKgiwYSG+ho?=
 =?iso-8859-1?Q?q2fjF2wSifyE09zznfk/i/DWEUVmfj1j8qI7Rr5ais+HlP1eFQwX+UjCWc?=
 =?iso-8859-1?Q?9sTgFNDHL+Zbwc/1YRWjLexNYIV0JMWvHQ47Ca0nHtHCoKRE62oRJRlONg?=
 =?iso-8859-1?Q?aLPiOCvoBubVLckRE37YOrlft13YQBDf1yo9h2E0IiVVb/na/kCmOeqnre?=
 =?iso-8859-1?Q?pMm3nTpTEA5XUyoPBOFd4yqsPRS3Tzp1DQJpwlwbFARjvlgzFYg0j5tMSL?=
 =?iso-8859-1?Q?PYd5w9yZ8CWoeK4dzrYBQ0zoC6Wasm63OdGdGDS+Ci2sjCKvwnz6sawb2w?=
 =?iso-8859-1?Q?W8wl15JKfwJZM2I2wNNTWNrtdzAZadk8FkWllaydsqwpZGAhN5335MiKKr?=
 =?iso-8859-1?Q?coOoDCEurXpStjvZklL8Na1AqXDc2Ti6uNQjw9+HmZo9z79I2gxeam6Wd0?=
 =?iso-8859-1?Q?VwVyW/h3et6+EPJxQsiedTDLbUxgZwh4IYy1KXTNNS60RHAF2xL6/LI0oJ?=
 =?iso-8859-1?Q?/qb+E8x7hpIp7FrDmP1J/otSwsAYqUW2J4vpDDwwEhonApZfFIAErtGqtW?=
 =?iso-8859-1?Q?kYJZSWRyKKF0CiA5W+D2XLcKX+1Y1H1UOgi8DnIZpsXUtL+qgJZ5X8RKfC?=
 =?iso-8859-1?Q?a0Qnr/jwqNXwUkVzoS+KqaXxJYfA2QbzG2hAJHMxhFkgvoroaMgy3c+Zwl?=
 =?iso-8859-1?Q?hNkDWqXExlMa4g4EPECIZooOSbmDVz6134NbfI1yaG1AOGKjpXkPntR1VQ?=
 =?iso-8859-1?Q?8ujWOZkY3KlzbD4Ng/x2h6OYN16sqOIn90HXVAJ617aOLW+jePIl3e/qmG?=
 =?iso-8859-1?Q?w9L0sgt9aNSUwzKuav/dkDmdZs0VUhU3WhczxsnXz0fo6u/hB3QOFpZbwW?=
 =?iso-8859-1?Q?gwNVtWmdGwlOiQZW7fQcKyjiIfD1pmisMHntIPaFhDu2C+ndzrca10dU8d?=
 =?iso-8859-1?Q?P+k/wgfGg0RHSlDvA7GyGXGNwznS9aKA/FCXFcKCphqWnMs93yS03nB+x0?=
 =?iso-8859-1?Q?EtlUfcm5OKhb3s37J+pfExadUWxkaPZehO2X6x3++b/YkYU0UV/DXcISqe?=
 =?iso-8859-1?Q?V2OxXGl3PvbHPNUsWwHdRbsq+RQxzCZa+LltNvB9FIMJyxdcwhZA1PBxdi?=
 =?iso-8859-1?Q?9VR9Ck0iifNf/8nJwr2PgaLjXSwvs/SGilQDYoGFSo3VmRJ/+pq64nSouS?=
 =?iso-8859-1?Q?bO0JEqwmnT/Kvtu5U0dNXosPOOgHyJByy7aPoxEamX+KYiDLUDtZo99Vxs?=
 =?iso-8859-1?Q?oM0t4fNCow4s/FbqdNOLjXr+uNOEOrBl/g9wfy15qnke3kssSzrlSqopIA?=
 =?iso-8859-1?Q?YDeqTmJeAQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB96466545C80EEF8FA8BADCAAFC122DS3PR11MB9646namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BxoEsXw8mktMj3SBxdKyc4uXsk/wHeY0WNwunXjtq8i3YTzeZN3imw+LYudnovQPvyxx6nh7dMXWTVMokaf88mTr+zKIyB1xHYCo4tP+0ASIVjoKSpkebT+WdBi72rdw0HTP+6HndU4KwL0jwQDJeqLWYi+ROcPOGCqxuRVDLLmhGjgdE4WTy2CPgnRVI/0boRdNKCYx+H3onm83LWxPgrOzynCxM67I3coQm2J2yUJBnw5Mp4wCOs6nZNUT/P/T6ruQmLmpc7J7fnQooA8g8x2xHF+6nOPfF8ufkmZn54CliwflMjAX3E3R0WgTGZ2UN2LUTxKTs9YFl3jJCuoETQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375b858e-f4b9-45ab-e87c-08dec0c7d795
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 16:56:08.0868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ev03mXpPkqc8IqUQs9kw8+Y8T1WFBmV61yS3IbX8h20bSIAhhFx7bwyRaZXtlUFIQzaHiegss6+Q73DW851/Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
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

--_000_DS3PR11MB96466545C80EEF8FA8BADCAAFC122DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-06-02
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
| 04 June 2026    | 26.07-rc1        | API freeze                      |
| 25 June 2026    | 26.07-rc2        | PMD features freeze             |
| 02 July 2026    | 26.07-rc3        | Builtin apps features freeze    |
| 9 July 2026     | 26.07-rc4        | Documentation ready             |
| 16 July 2026    | 26.07.0          | Release                         |


See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - Has been pulled to main.
  - 2 patches pending for merge.
  - 38 patches in review/waiting.

- next-net-intel
  - Has been pulled to main.
  - 47 patches in backlog.

- next-net-mlx
  - No update.

- next-broadcom
  - Internal testing ongoing.
  - Patches will be pushed this week.
  - ~20 patches in backlog.

- next-net-mvl
  - No update.

- next-eventdev
  - No update.

- next-baseband
  - No update.

- next-virtio
  - Series for ASID under review, targeting RC1

- next-crypto
  - Applying patches for RC1.

- next-dts
  - No update.

- main
  - New version of BUS drivers refactoring series. There are some conflicts
    so will need another version.
  - Looking at fixes in EAL. Large patchset on atomic deprecations.
  - Series on MAC addresses targeting RC2.
  - There are currently some strange failures in the CI that are under
    investigation.
  - Risc-V patches.
  - RC1 deadline 4 June 2026


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 25.11.1 - Released + regression fix on 25.11.2.
- 24.11.5 - Released + regression fix on 24.11.6.
- 23.11.7 - Released.

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



--_000_DS3PR11MB96466545C80EEF8FA8BADCAAFC122DS3PR11MB9646namp_
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
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);">
Release status meeting minutes 2026-06-02</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Agenda:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Release Dates</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Subtrees</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Roadmaps</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- LTS</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Defects</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Opens</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Participants:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Intel</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Marvell</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Nvidia</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Red Hat</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Stephen Hemminger</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Release Dates</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-------------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The following are the proposed working dates for 27.03:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Milestone &nbsp; &nbsp; &=
nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
|-----------------|------------------|---------------------------------|</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 30 April 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 04 June 2026 &nbsp; &nbsp;| 26.07-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API fr=
eeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 25 June 2026 &nbsp; &nbsp;| 26.07-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD fe=
atures freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 02 July 2026 &nbsp; &nbsp;| 26.07-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builti=
n apps features freeze &nbsp; &nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 9 July 2026 &nbsp; &nbsp; | 26.07-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Docume=
ntation ready &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 16 July 2026 &nbsp; &nbsp;| 26.07.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| R=
elease &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
See https://core.dpdk.org/roadmap/</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Subtrees</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
--------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Has been pulled to main.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 2 patches pending for merge.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 38 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-intel</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Has been pulled to main.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 47 patches in backlog.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mlx</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Internal testing ongoing.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Patches will be pushed this week.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - ~20 patches in backlog.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mvl</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-eventdev</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-baseband</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-virtio</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Series for ASID under review, targeting RC1</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-crypto</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Applying patches for RC1.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-dts</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- main</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - New version of BUS drivers refactoring series. There are some conf=
licts</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; so will need another version.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Looking at fixes in EAL. Large patchset on atomic deprecations.</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Series on MAC addresses targeting RC2.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - There are currently some strange failures in the CI that are under=
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; investigation.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Risc-V patches.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RC1 deadline 4 June 2026</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Other</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-----</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - None.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
LTS</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
---</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
See also: https://core.dpdk.org/roadmap/#stable</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
LTS versions ongoing/released:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 25.11.1 - Released + regression fix on 25.11.2.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 24.11.5 - Released + regression fix on 24.11.6.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 23.11.7 - Released.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Older releases:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 20.11.10 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 19.11.14 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Distros</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Debian 13 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 25.04 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 24.04 LTS contains DPDK v23.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RHEL 9 contains DPDK 24.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Defects</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Bugzilla links, 'Bugs', &nbsp;added for hosted projects</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - https://www.dpdk.org/hosted-projects/</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
DPDK Release Status Meetings</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
----------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
status of the main tree and sub-trees, and for project managers to track</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
progress or milestone dates.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
You don't need an invite to join the meeting but if you want a calendar rem=
inder just</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
send an email to &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; =
for the invite.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS3PR11MB96466545C80EEF8FA8BADCAAFC122DS3PR11MB9646namp_--
