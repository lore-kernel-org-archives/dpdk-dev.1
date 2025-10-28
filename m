Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406A6CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 14:47:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6A434064A;
	Tue, 28 Oct 2025 15:47:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 29FA44028D;
 Tue, 28 Oct 2025 15:47:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761662869; x=1793198869;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=gkBI3r4A0UEyYvCTbUDXejbPorXvegoDOk/NH/ISPa0=;
 b=TkIGEU57r9KScfAjxpL+AaEzNsktKuv+76OOYkLCQa+MHKPveB8193P5
 l81vEKcretZtbQA2bKlGUNT11cZu6b3UFxRVu6VY2QepG0iTicMU9f35R
 oXdhJdmEAFIx29w1WFas2b41qGe93EuukcDp/LK+JYhH2AAS4LoyJRyQA
 EyhukKI0RIIedgfwNnM4QVnAyg/hEo/qRqFNOlIEgxPyevuX7ADkAsuAA
 kTSj9dVvJwHRkMoea3zPGW/CVBCGD9qcaUDMbL0DW3eb+urNJ1KgcyiBh
 8UZH/OHZ5UGVvw8bUGkADOj4Td/qbcIBJakPqvdXTohGqUiw1vjB31MRK A==;
X-CSE-ConnectionGUID: KvvNvEmeSgSSh1FjYzlKMg==
X-CSE-MsgGUID: Kh29JLRbQYiR4dbBYziijQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62793868"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208,217";a="62793868"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 07:47:48 -0700
X-CSE-ConnectionGUID: WcXnNAs/Se6e7FOtgU0gsQ==
X-CSE-MsgGUID: ncLECwF1RQqFGnEyLpEUCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
 d="scan'208,217";a="186113338"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 07:47:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 07:47:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 07:47:47 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 07:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVifn1rmY6Z/BFAUONLcp6ZY2pZ9sdJAO+iDThbcqDX/PRMcK3IDe48EF/7yKsBMWIMEysSgNkfXOaAopbxquZCWrl5TC5IpqNf13zpGW+Uuud03s7YjDkH6xQeeU0b2NRKmUcS12dko5kMFbVLMa/JehOHypqyOOAwcRNhwdeyZOleO3VMHDzQTePqc/isfvoQSoxdR3uLFv3E1J1hFJ1dxSsJgbEjQxYiv0oWc4lnLeMoiQuuQmXpjEyzitwLB2+7eEdLTrUEB4JGT76yrujl034nzOKtGOvJPSd/ni1dZgvJuUBiJ0/BoCrrfaNXQX9oaqQjWK60FnQ7x2oxo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkBI3r4A0UEyYvCTbUDXejbPorXvegoDOk/NH/ISPa0=;
 b=A/3Z/AiJAkx5Xyk0WbyG5Yap9A0Ez5Gszc714SUMrHP9U5NT1KzNuXjTyqfuow1QnODZGJgcgqgmwsLjh7pSq3UWTbHQaAt0yMOVnF4G1lfvdGhLvryQigV563i8e3KGunJhXa1EkWVYjGujukeCP6QvaSRoQ9IlGbl/W616Ydp1fpB8L1J1vcDH+FhJ4Rz1Zp+SlCZFJoOcx7fjfP6TfwMhDhyza6pCzqfot2fUQi/XElsa1R7rldJ+KHEtGQSuuhNdHJJ5dORlH7KGi7biEqJHB9jGfaUoyD76eVF97d4wZOSz8TbOW6wzchzL/rCojAu8cokTJuCU000nsSp8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by DM4PR11MB7376.namprd11.prod.outlook.com (2603:10b6:8:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:47:43 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::68b8:5391:865e:a83]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::68b8:5391:865e:a83%2]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 14:47:39 +0000
From: "Carrillo, Erik G" <erik.g.carrillo@intel.com>
To: "jerinj@marvell.com" <jerinj@marvell.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, "Pavan
 Nikhilesh" <pbhagavatula@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "Marchand, David" <david.marchand@redhat.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [dpdk-dev] [PATCH] doc: fix doxygen errors with v1.15.0
Thread-Topic: [dpdk-dev] [PATCH] doc: fix doxygen errors with v1.15.0
Thread-Index: AQHcSBTmdpfCzTW2DEmI4gqH6MK197TXozh7
Date: Tue, 28 Oct 2025 14:47:39 +0000
Message-ID: <IA1PR11MB641812087BE4BD8A494F26A8B9FDA@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20251028141159.177727-1-jerinj@marvell.com>
In-Reply-To: <20251028141159.177727-1-jerinj@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|DM4PR11MB7376:EE_
x-ms-office365-filtering-correlation-id: 7c7c5f2b-6ba3-48ef-ef25-08de1630f146
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XgpAbFtgRcz3uHDw0P+x9s3X14A3n7li9FmVWNDBaRmqeZlqmBpWJ7oCty?=
 =?iso-8859-1?Q?rvEQBc4gQuCH/0i8pqiNtrreZ7OHxI/maS8gxq2fYokWRwkQBXIjvM1krv?=
 =?iso-8859-1?Q?1w/Ydd1NR7lzMAY20ggYHxcCstMZTv5WXyM1ATh+xRSL80gb31Pvjza5V2?=
 =?iso-8859-1?Q?IDB0XscP79sYcGPqlkoDl4ks3UP4ORCXpkdb3ckIkPYI/C7MWS2HZLgX2e?=
 =?iso-8859-1?Q?sQK0B8MiCDM1yXAN6oRucoU1Jk2dRPSqVSBgB1x0EyTUT9ZO2wAqhR+neK?=
 =?iso-8859-1?Q?jmv3UrEoP3Yw4wuRnqCilDl5GFIpvMV+FlZVDClqd+3iG8fs5WqmD0yL84?=
 =?iso-8859-1?Q?+G5tNrynJwqOhb0ptW32wVwO5iNvvEpNtmEzrSO279U72olD6ImFQoqEfb?=
 =?iso-8859-1?Q?Q6wiAXFVqVG2LRYOErMBsVlcLTH5SvggikjQ0M1TCg763o3x6bfGJtyP/s?=
 =?iso-8859-1?Q?16sFdPH0iPbpBotieGMdtjsqx2HY8HAR77ufTO85pVjJMeDxyauGoA61YB?=
 =?iso-8859-1?Q?vfkOW3LaGk4seU+ANkPPvhcVsR+l55yhZMduF5+T0tULyDDFN36dmbdnPl?=
 =?iso-8859-1?Q?EawN0Zw4FR6+PuZLyac5pmW6rNem7ff8eSNic1ISMK66oL535+VO7JyR+k?=
 =?iso-8859-1?Q?wX7afSUtkaVTkf5ORnPE9gAAlLy83Q3FZtuJ7xrPeajg7KUXoaqI3aueMB?=
 =?iso-8859-1?Q?Z2LTmUt3PlMe3sQcedWMnKp9utJHk8/H8KxXwAay2YNLXtoetbXVXz9dbt?=
 =?iso-8859-1?Q?JOLbZ5+aOZWtflITF9zALpQArm5z5EkzphAndARmtGLIUNz4jEA+afvUss?=
 =?iso-8859-1?Q?tGScpZgg8N6X3gKPeIF7fVIBJO/BM61kAA8hyjoU/6KLeybD5ma6ExHNUD?=
 =?iso-8859-1?Q?V6UehzmHCwl88YN0qGe6cRwhSgAUZg0fqgHbkhMoq5iRrCbu6gqOvIuSbx?=
 =?iso-8859-1?Q?rhfZxihqlU6j+4womK2nR8cZwhNhDOwZWgU6nOuGo+0KOD6BTXRPdppWDu?=
 =?iso-8859-1?Q?2RJ8A2OeVUBemjWK7TmG7Adx4+eOCdTqiAM/zIYVJ8ZqB5h+jH6D/By+Lw?=
 =?iso-8859-1?Q?LOcIC0Es9RyyvzfsrdzqBWa0bYz7CnXiXbM1VSwBZ7sYr6Tx7/oSVOz5Qj?=
 =?iso-8859-1?Q?dfgbAQ4U/9K8yw8nIXgtzm513wYnv9PB+sjG1Ik8p+uxMsXeQapIJ311U4?=
 =?iso-8859-1?Q?F1TwS5+UqG92BsQZSOQIhqSAPir+odQasK/8D4wjdxAOzolAeGYXix9NfM?=
 =?iso-8859-1?Q?L8lW1r8hO+LY9m/eFpWY1dbSIgtAfnVxxRkF/lamA7eYHVZmO+68cv6zWK?=
 =?iso-8859-1?Q?p4Zp3uYenKhSaMpUCcxNuf5Sd9XIRL2VNYSFseeje5zjIlBR1eUKDJPPL4?=
 =?iso-8859-1?Q?E5idG7qOdZXyeXIBNiPn1Jdmo0BmbX5KJXR7Z+x0GKLBShzSdzFDOnb5/C?=
 =?iso-8859-1?Q?+a8XSf7se3ZJBKeZSh2tsdKzSF/7axfg66Frp6FyxKdr4TAtOhrMz2/3I5?=
 =?iso-8859-1?Q?cpfq0DvljD16JKTDnPm18UzqoI53vhJi4W7aO4sZWNjaCwozhgarve+bJH?=
 =?iso-8859-1?Q?VghiN1QLqkMzw4+OV7XRP1iOpSXq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6418.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NjLIJ5AgM4T5ued52TJHm4eDMde95VolIOvZrUximBi9rZJ8nKap+gqTg+?=
 =?iso-8859-1?Q?4Hzp/QRKND4dqwJPuC0K2wMXLELY6wnQSNTBe+/ZDSFZDHdm1y7FvgkW6j?=
 =?iso-8859-1?Q?eWMUReBB5qfhqGBSaAn7legaeoHTAysCldPULHyzov5ROOKRMJdzKMT3DS?=
 =?iso-8859-1?Q?U7DELy3KhQpicxCiAxDn8TS8x2rq8pWk0wKukSLe9CA+COBt//4lB9WLEV?=
 =?iso-8859-1?Q?XGHh43tPy6VuU8S/polG9KD0KedpFnIEOb0NAbdEkuGxcKzmWlibZtNvhh?=
 =?iso-8859-1?Q?vksAWYlL6UNfd9pCKZ1hNC0ueqmC7ePMbM8GerakbC01V19ucWKwY4IAAr?=
 =?iso-8859-1?Q?mzYPFJGT+rDCgnwZoBeNhc4+4BCRj5zWWnz13xjrkAWp0Jvn4VXOfUyFbl?=
 =?iso-8859-1?Q?c75kIA7sawcyWbbRw256jmWjKBwWSeBFc9V7Me/1WoOJi1VOHoy439Y5te?=
 =?iso-8859-1?Q?6AIvBn2FB5WQoYXZiqn6fwKEBZEIH7EEd/jyjMWwL8bnbpoUJ9cgWLOdhd?=
 =?iso-8859-1?Q?HM4pYAuD374+y0dvOfyvkVlmXt/dBv7L6hmMQB+C0JepPYwd/UDCUX9Gs+?=
 =?iso-8859-1?Q?JaJvzqhQdMqfzqkttpO+epCRIrxuLnkssj4gzEX+GHRgr7QdmOccENLHCa?=
 =?iso-8859-1?Q?NGgACvcUJA7OAMeuYWQn0NGmV5D9aCK9EacVTFmMHJX4m5KMyCjGqBhe3X?=
 =?iso-8859-1?Q?JrGgJaVGMBrEh2W3G6uHxhJHsAI92aU/OXjf8D4zDFCHGUBgwbltStaB3k?=
 =?iso-8859-1?Q?ZIuBR9om0pWSzVXZP6jrjpsQOJ93tCJhgIymIKxEWrqcJEjrWmREOvBUyU?=
 =?iso-8859-1?Q?8Lq57G57uw38+TCiuMPPaiwEs/FFEVEhC1uqNIigfio1AQyxwK7Y6raSu2?=
 =?iso-8859-1?Q?6wauCtvupMNxjcAEMatJGLRBFf0DVGD7Lem+iSPKkoyyVlM5I4hhJeBKc/?=
 =?iso-8859-1?Q?YHLSYKEe48iFZn6moboIpmy1w1lZw+oGsM1aXM0ST4N/FWdup3wLFs542X?=
 =?iso-8859-1?Q?Rcr4V8XfaqrTPM/4qRe2vS8z7JHjRjHbEcinsesT1P6MeqiX+G2C/UkZ7g?=
 =?iso-8859-1?Q?sqNkdwtq308gXpeaQUEtvSaDvpL89/pO0O3SaYQhpRIs9m66940M0hTJtC?=
 =?iso-8859-1?Q?jdRUntO8W18aqCE6lVyFPer5GE4hyLwmVo72SiYb9D3+FEdRTydrpUi5dt?=
 =?iso-8859-1?Q?+PupS6hbvRBayVBM4FupGA6oTqIxyaR2WzWK3HVK6NSeRKnoZazrq32YhS?=
 =?iso-8859-1?Q?fs9WUjKLb19e4HlHPxA++D/jNMAgxLIfrbt3segjOnyuwXrRRpF25Dvo0x?=
 =?iso-8859-1?Q?WOn5kBBTeqf6IduGyIixAzxZlsiSqX6loSdATnY5E/VHup3RPrCcN3QqFJ?=
 =?iso-8859-1?Q?AqtQaq6lxlLtwscLGNBX4YF938cmuKC9EaEw1YosQxqXH26WHQ3df68B5j?=
 =?iso-8859-1?Q?0I/XuVsnLDlghJbQeVDX+11utGk1t+1G+GAefmUlGNJ4Yzp4INxIilmZFA?=
 =?iso-8859-1?Q?ebRVq16ejtR5+PWy8tpoWsrCsGCZOLLeBi6pYJ8hEYkYFKzE9rWymXCuBH?=
 =?iso-8859-1?Q?lLuVh/Wdpmmke/N5Qsvb7QJmhHBvwHUP2SO+dCkahEC+3lE3UEc4FU9eGG?=
 =?iso-8859-1?Q?R55y10P8mEQTyfhU+O4WhEDSqHSN9iRIUN?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR11MB641812087BE4BD8A494F26A8B9FDAIA1PR11MB6418namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7c5f2b-6ba3-48ef-ef25-08de1630f146
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 14:47:39.5260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3cfWlJmoWMpOEA/InXTdwMFghtgz230t/SL81UTZkJRUclgZKRwltFaXGWIE6L5puiXQJsO3L6qLg+Lrc57eKor3NIAW96k8YcR6sw3sOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7376
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

--_000_IA1PR11MB641812087BE4BD8A494F26A8B9FDAIA1PR11MB6418namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks, Jerin.

________________________________
From: jerinj@marvell.com <jerinj@marvell.com>
Sent: Tuesday, October 28, 2025 9:11 AM
To: Carrillo, Erik G <erik.g.carrillo@intel.com>; Jerin Jacob <jerinj@marve=
ll.com>; Sachin Saxena <sachin.saxena@nxp.com>; Hemant Agrawal <hemant.agra=
wal@nxp.com>; Pavan Nikhilesh <pbhagavatula@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>; thomas@monjalon.net <thomas@monjalon.net>;=
 Marchand, David <david.marchand@redhat.com>; stable@dpdk.org <stable@dpdk.=
org>
Subject: [dpdk-dev] [PATCH] doc: fix doxygen errors with v1.15.0

From: Jerin Jacob <jerinj@marvell.com>

Doxygen detects valid errors. Fixing the same.

Example:
lib/eventdev/rte_event_timer_adapter.h:720: error: Reached end of file
while still searching closing '`' of a verbatim block starting at line
569 (warning treated as error, aborting now)

Fixes: a6562f6d6f8e ("eventdev: introduce event timer adapter")
Cc: stable@dpdk.org

Signed-off-by: Jerin Jacob <jerinj@marvell.com>
---
Acked-by: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>



--_000_IA1PR11MB641812087BE4BD8A494F26A8B9FDAIA1PR11MB6418namp_
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
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks, Jerin.</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;jerinj@marvell.com &lt;jerinj@marvell.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, October 28, 2025 9:11 AM<br>
<b>To:</b>&nbsp;Carrillo, Erik G &lt;erik.g.carrillo@intel.com&gt;; Jerin J=
acob &lt;jerinj@marvell.com&gt;; Sachin Saxena &lt;sachin.saxena@nxp.com&gt=
;; Hemant Agrawal &lt;hemant.agrawal@nxp.com&gt;; Pavan Nikhilesh &lt;pbhag=
avatula@marvell.com&gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; thomas@monjalon.net &lt;=
thomas@monjalon.net&gt;; Marchand, David &lt;david.marchand@redhat.com&gt;;=
 stable@dpdk.org &lt;stable@dpdk.org&gt;<br>
<b>Subject:</b>&nbsp;[dpdk-dev] [PATCH] doc: fix doxygen errors with v1.15.=
0</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">From: Jerin Jacob =
&lt;jerinj@marvell.com&gt;<br>
<br>
Doxygen detects valid errors. Fixing the same.<br>
<br>
Example:<br>
lib/eventdev/rte_event_timer_adapter.h:720: error: Reached end of file<br>
while still searching closing '`' of a verbatim block starting at line<br>
569 (warning treated as error, aborting now)<br>
<br>
Fixes: a6562f6d6f8e (&quot;eventdev: introduce event timer adapter&quot;)<b=
r>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Jerin Jacob &lt;jerinj@marvell.com&gt;<br>
---<br>
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Acked-by:&nbsp;Erik =
Gabriel Carrillo &lt;erik.g.carrillo@intel.com&gt;</span></div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
<br>
</div>
</body>
</html>

--_000_IA1PR11MB641812087BE4BD8A494F26A8B9FDAIA1PR11MB6418namp_--
