Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4D3C0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 08:37:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 156DE40156;
	Tue, 11 Feb 2025 09:37:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id C037C40150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739263049; x=1770799049;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mq2u7XN54a7eIPQg2xQ+K5UzDdJSdH3ca182/UrZQAw=;
 b=ihWpV+tlV6MUHUiqZ4rLBA/GRgWIGFFH3A9SJTwgzhV5Pvlo5IKrkTD1
 QZw5Vy2VHLxSHVGuVGng4t0110qFM1jx4Fh7Hr+UBEtKJNEsy0qbnyj8q
 BzRzxJk10CHfvi4nxA3neWo9UTSxJHyJKUrq21JkFYlljUVwf2EC+XeSU
 g7yy5RY3qoEuCV8b+rSXBOpkHpVXsoNv0xo+I23djJSmLW3pd3AFUjEh/
 o5J0Fn2KzZYR7kA7zoZgWfmRzzO1hYWkX16d8ZKdi7Fk0u5NAdoBPud3Z
 Vfm8Bvhdh+vHWTzA9OKG+JPrSSzWdKdrUmQSM6X5YojB45+3F2Z+K7QFD g==;
X-CSE-ConnectionGUID: jHJatjjCTJOvni43EFDJjg==
X-CSE-MsgGUID: WFsab2vLQTG5PHcr7hP2QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="43632839"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208";a="43632839"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 00:35:07 -0800
X-CSE-ConnectionGUID: Arp0bHgyTlKRQCfbuOVBbQ==
X-CSE-MsgGUID: SLxnt7AOQVqU9QnkkVkwvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="149620827"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 00:35:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 00:35:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 00:35:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 00:35:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViG0OhxrudhPVwUWEwvesgE2F/MlCtCK63f4cL9K/Td65M1AxWHJeTiIjdWo1BbfIO962L+b/13auLJs3EMy39b7a4zkqXiC/jemdDWdegHgviv6jrVd42MkD0NsQ21FRAqy2nsyJoNBhFkwML1BO1H4MjYsBjkoTOPZcZ4fErUo50vfSna2FIU4C1YCnQN09Ei29saqAkF8GFs92a1WkTfFYCIwSO18kixLsFnYHnQDjYf6Ip6uNcQ1VNY4u+Oj7RyIa/Q/34Wh6gOM92k2OZeCARtQm4ZyYnBO7JEX4qAFDadzzaWvrR/pczpY4U7hfWh6IYH/o4sBlzJy2sziRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq2u7XN54a7eIPQg2xQ+K5UzDdJSdH3ca182/UrZQAw=;
 b=a5XTbPvY3hqFz7VYcDUVbWDdkj62Dcminy7obtYd0iWCspaXlsmf8WdDyDV9HD+8JXQHHEbJtqzDo3mkm2F2UGBgsfYI63ZDiGM9c1p4wBHUEsIPEM6qlIFD1Bk1EtdMQt+jjXCp7uKgb+TxNs4+22n91Knw49g2XrD+RHAclGZeedo+o4qlIuMQRsqM3KKT8AP4GOBZS9qvKTeXTTRlb18M0NEWXb0u+NVK1nB/DyGM1v5cfJZWB0+3AZJgvXobYFWlChgheWua/Rg4qwni4mBXxbHdK1+GH56Fywx5YOsYldTSlepPDKXYEMTSym4aR3Q2+77lJIbBj8djVoSSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by LV8PR11MB8582.namprd11.prod.outlook.com (2603:10b6:408:1f7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 08:35:03 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 08:35:03 +0000
From: "Kusztal, ArkadiuszX" <arkadiuszx.kusztal@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "ferruh.yigit@amd.com"
 <ferruh.yigit@amd.com>, "Ji, Kai" <kai.ji@intel.com>, "Dooley, Brian"
 <brian.dooley@intel.com>
Subject: RE: [PATCH v6] net: add thread-safe crc api
Thread-Topic: [PATCH v6] net: add thread-safe crc api
Thread-Index: AQHbfAKVdADSb4iI4UKhuhh+FN1dMrNBowWAgAAhAwA=
Date: Tue, 11 Feb 2025 08:35:03 +0000
Message-ID: <PH0PR11MB5013805950ECE4513E13F08D9FFD2@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20250207182443.9775-1-arkadiuszx.kusztal@intel.com>
 <20250210212710.708809-1-arkadiuszx.kusztal@intel.com>
 <20250210222353.2b670260@hermes.local>
In-Reply-To: <20250210222353.2b670260@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|LV8PR11MB8582:EE_
x-ms-office365-filtering-correlation-id: 180bd6e7-124c-4e03-a4a4-08dd4a76fb25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UlE3ZklMaVJ2RDlCc0MwdGQzRFpGVWoxcHlFN08rMXpIdnJGSUY2MkE3bzFF?=
 =?utf-8?B?eXFlNEhJK0pWd3MyUmV2NUJMYmNJZkdYcjFUQm5Qb2JuTVl6N3h5S2dHQnBj?=
 =?utf-8?B?MGJaWnpBbTM1WEdIem1NUS9GNjNCajEyVkxRQUtEaG9tVXlQdE1xZE5iSnVR?=
 =?utf-8?B?RVc4akxwbStyWHkxUERiM3ZzQTR4T05rcW5JeFFpNXhtK1ZReXdDUFFSejJO?=
 =?utf-8?B?ejgrUkZyK0JiYVNBYzdTbCsrTndRNE1TWDQ2RlVCTzhwT2szUTJtMGdJQkkv?=
 =?utf-8?B?aFFieW5JNHEyTDkrNkN6d3k4UVNyTFBaZmFRaWhlMkpLcTZpY1gxOEdCTXI0?=
 =?utf-8?B?RHlSODVMd3RtUk5XZ0RwMldNTlN1QjdMaWVWb3g4QTZmaHhqeUxxTlROR0JL?=
 =?utf-8?B?bVpJdEtMRjl6MEFDYWhnaWUxeVdKRHYvckxLZFQ2eHp5UWt6YlZPYUl5dTZR?=
 =?utf-8?B?MWQzK0p4SkxxRjBBczBSbWQyN3QyMmNwb21jU3p2WldmR2ViUW42MkZpK1Fp?=
 =?utf-8?B?NjZoU0RiZWJ5anBDcEFkRFpUa0thUDZnU3FQUWprTVFqbnhHdm5WT1k2Z0F3?=
 =?utf-8?B?TGpkY01jczZRSVJadFhoamdITHB4TGJrVzB4Vy9lODg3c3F5T2Z4YjF4WldJ?=
 =?utf-8?B?Y1plMmkzWng5ejJVUEllVmlvek9CTFBFUklkQ1dGN01ia2M0UWVGTVFIZnNp?=
 =?utf-8?B?RkVKS250dFhNM2lSN1lBbkxEanA2ZWI2RzQ4ZThJUzl5T0t1SDJ0TnNMWmIy?=
 =?utf-8?B?STg0cmVLOS94NFNtdVNFMEFjUy9LamlQOGVDc2MrZDYvcGpKeEFqTlZrZUJ1?=
 =?utf-8?B?S2tvamdJb1ZvZXgzVTZNUW5NZ1k0ZGhpQVhVNXQyRkhBWHFzb1ErTUlGbTNS?=
 =?utf-8?B?QVlyeW9VdGh6QS82ZkNWaVVMZzhFNmtYNjlSYlFrOG5XRVNkWWQ1Mm9zek5V?=
 =?utf-8?B?Mm5jRTlxWWVDV3JweDZlSk5jRE5saWxqQ0NOWlhHZG91LzR3TEFyN1dnNnVz?=
 =?utf-8?B?S1BMTHFYS1BqSjFadXZidDhmL0grNWlkZnJ1YVNkVkd5TitDYTZtNk52eURT?=
 =?utf-8?B?OEc5SkNLR1ZKakYwN2tCS0tSd2dOUXg1MHMrOHZtSU5waUhYUHpLVTdidHVE?=
 =?utf-8?B?dGVTQU1DSUFhNjhPMDV2OURlNUdsUDAxVFNhWDV5U0tNRHAyQWlPSWtFblM2?=
 =?utf-8?B?dS8zSXlKdm5sNmsxd1hWSjRmczJKVFpIMjlKeHV4QlFzRSttRWhxdkZZQ1pl?=
 =?utf-8?B?SCttYVJXMi82VVM2L1VDTkdhOU9UdGNaVGFwQy90QlNTWVFPRE0zVFZ5eDB3?=
 =?utf-8?B?N2FiWkdJSWdVaVk2ckJ2TlBMSXord1VXKzQ1V0FYK2FTTndKNFREU01CRWMr?=
 =?utf-8?B?NVBGeW8xT2JpNWl5V1VSaW1MOHRWaFFuY0p3YzM4TjZOTmlMTXdEMDZKbmpD?=
 =?utf-8?B?d2JzWUcvSnhQZ3ZXSURoZ0xSWnVXM3JlaGNtZUV2WVFVemIvMG91RWJhNHcy?=
 =?utf-8?B?TmpiY2pOcDJ3Q0MxYkRtS1lWMDNoQXBRL1ZmeTdDUithRk9Ma3Z0M3JqMDlr?=
 =?utf-8?B?YUJ3U2g3TGJRMlVMclVSOVJnclh2bjVsVWF3ODJNQkF3WGY1amVGaE5laTV2?=
 =?utf-8?B?bzh3VFhWNHBWS3pXUXNqU1JVRzdsLzRLckFDaHdCa2lZb3RacmJNaWczVFJq?=
 =?utf-8?B?emFGV3Z2NWFRTGdHSDRkelpMa1dvYVpVVkxKZW51WXRXTERYeWpnNmZSM21p?=
 =?utf-8?B?cFBxT3FaKy9hQXRjMG0yMTZjT3o2QTdoVmhMa0FCcU5vdDNFWHl1WkFRaG0r?=
 =?utf-8?B?SndOajhaSTArRURvQy9KRzBFK1BhQXpmdTVDZERFd0oyS253TCtqbDNHOFcr?=
 =?utf-8?B?MGFRcFFKTVE3YlV3LzZpOWxsUkhVd3ZXNGw5UEZMNXNQUWhmKzZ3OXBTdFN6?=
 =?utf-8?Q?XpfxlTXzDVtmDmiV87BhSCX0qGp563Lz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5013.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGJseTU2ZTIxS0JJcVNLUi8yeGI5WU5OSkFLbXJlMmJNS241RjBQZm80aHI3?=
 =?utf-8?B?SXYxK3ZHMXVSU1EvSVRJUHJuY1ZTQkZJOVNqSGdEVTZZQUNCYTlpS3ZrOTJW?=
 =?utf-8?B?WG5VUHRlTFlLNXpMTVQwTmI1YmVIY2tWcUJxd2QyK1VmbXlMRE5QbFBWeVhW?=
 =?utf-8?B?RnpwQWlhNmRPNzVRMFFwS0RLVUZxNUtuWjlLSjZhMnVmN0ZCRExMcy9IMnI1?=
 =?utf-8?B?YUlPbUQ3cFJZT29GQ0gvQnlRdnh0ZTNHRG1wWlVtd2ZKSDdqa25CZnhBdThQ?=
 =?utf-8?B?cEFRaVk3TEc4djEwajk4ZUlIanU4Z1dHREczVTVCMzBVbWFPcjN2c0lLd2pp?=
 =?utf-8?B?dGZ3ZFhhMVErbUJVa0lwSEN5WlMwMmhjamx2SXNWSHN4RGFtc3RhZlNMcURz?=
 =?utf-8?B?RzF4dG1uTmIrbjVsV1ZPcjFQU01MZ0FSVmZaQ1E0N2VQWkJ4bmhzelBqQnJr?=
 =?utf-8?B?VlV6S1hMOXZQdXBqc2tIajVHcitORmkyVjhPaXpBUFNhb0ZBWkEvcFhncC9C?=
 =?utf-8?B?MmhZU2JMdzh4MGkzcm5ZaTU1c1RJZlhhRFc2amNTTDdPMW5IL1prbVlFNGk1?=
 =?utf-8?B?enpVWXIvRDVld1o0OG9pNExMRk9SUWNVMnZBODQ2aS83N0syTkVnT0phNEV6?=
 =?utf-8?B?UkhmdTNxblRRUFdLSldrVVU0dERSVXI2Qk10VU12RVByUE9WRmxoS1FTR3Av?=
 =?utf-8?B?cTdPMFZIeVlhdHAra3FtRFoyNCtvclo5N3RIaFMvK0RrWHcrbUcrT3JDOGNK?=
 =?utf-8?B?MUpTVGpBM3RNNG9sV3Vsb3gzcGxZY2lMRVdvMEtqK0syZUZDUWxnVlM4UUIr?=
 =?utf-8?B?ckJwSXpacXdIUTFuVXU5STIwUzZsWmtERXVON0czT3V2M2FSSnNIWGlPSEp3?=
 =?utf-8?B?S29iZ2tUNDZ6VHdubUhNSEZpazN4dFdlSkZmdGpBMnNUUUNJdEh1MWl4cm5y?=
 =?utf-8?B?Z202ZHUzaitMUzUvbEhlMWlxc2t3RGtwNEI4T3ZGYldwYXhERFpiQ0dwVmRC?=
 =?utf-8?B?ZDlGeWJkN3lMcitBWVk2Q0MwaVRpQUk4SlVrTlE0SjhCM2FNU3k0bzI1VGoz?=
 =?utf-8?B?SFBrSjNsWTBKejdNSG0xNzRUOEpDV2cvQWpPdGRxZUJXVmFnNTYrNW0rNDF5?=
 =?utf-8?B?eFN6OW9RUHVKZS9iTndiNC94eDZOSXAxeDFLRVpBRzA1b1EvYlJCem9JcnJH?=
 =?utf-8?B?eWM5NGF4ZExFM3l3VW5acTI5RTV6dk93Zk53TU94TDErWThibWVpRXJIYml1?=
 =?utf-8?B?UWxWV2pkNEZJbENibEpFQnhFYmlGTnlRNTV5aEV2czlaV0dWM3phZW95VWpI?=
 =?utf-8?B?RnIyM2NVRmxWSE9wVXFaemRKVU0wZjZqVWZuNEpCM010Q251Nnd1amxlTHRL?=
 =?utf-8?B?VlFEWWkrRmtXOWliOFZmU2FuQkpLZnBycEhiSWtNQ2dYckd4dnFyRkRNQTVj?=
 =?utf-8?B?S0NrNWZpRU42Y1dvdVhvT1hPVFBVazVFcHdMdVZPRWNFb3RHV0dneDk1RTRh?=
 =?utf-8?B?bTh5TWVjSEF5a1NFZXlFRzVkdDd2OHlTVFNnZEYxaVJOTzVScEVSYzl0SVFC?=
 =?utf-8?B?RkFpdi8wU1lObDUxMDJuWitUQXp6WmY1YlNXWWlPZ25OKzZGNHNrZ3FwTWJ0?=
 =?utf-8?B?VlgxZXc4d1IzSWUwQmU0THRXam9LRDVZNEVTRUt1dTBQZFVwRXZrM1hIbThY?=
 =?utf-8?B?OGdxWHRMdnByaTJEVmtET1YwRGtDT3Nxa08rbHBwekM1WjlxcWxUM3RmRTZL?=
 =?utf-8?B?eHowdXJJQ1hiTnRlYVorWms4bTJYa0FpMno3OEYxUjFTOFl2aUE0cWU3SWp5?=
 =?utf-8?B?SEtUcFJCd1lyckZSVHZqZEJWZWQrSWhrSkZpRDRzZ3JDcVRnMmZMT2NVZTVi?=
 =?utf-8?B?eGJlaVFaVEIydVUyVkFmSG1hY3ZXSkswMFlWY3kxNnBCMlBFRWtpK3lqZXhr?=
 =?utf-8?B?VEhiSWl6YUR6cDdhRzJyVWhiazlBT3VwUXNDS1NyS0xnY1Q4dTlGcnA3T0t0?=
 =?utf-8?B?MWd3OEI2dFc4NFdmZWVaTTZ5eDRLY28xakZid2F4L012UVZMRzFtcVExMVll?=
 =?utf-8?B?alRZZkVvbnkyUytOR2xseFgyRHJDZkF0anF3NTd2R2d1VGp1aUVKc3hMcnJL?=
 =?utf-8?B?TTBqMHk3VFMwSFplZy9HUzRGOXJZQnBwL0VJMnZDTkJDT3lYUk9hK0ppSFBV?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180bd6e7-124c-4e03-a4a4-08dd4a76fb25
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 08:35:03.6009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXNWIy+TIZoT8sNUWWGlE+IWo5XYBrdIkkO7Pc67VJVJ8xeQNzGR4FdlNSUnCZSDvW4CzBq63oZfy0ws5DrZJz3vfrvNRds6Jldn+yA4xUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8582
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFy
eSAxMSwgMjAyNSA3OjI0IEFNDQo+IFRvOiBLdXN6dGFsLCBBcmthZGl1c3pYIDxhcmthZGl1c3p4
Lmt1c3p0YWxAaW50ZWwuY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBmZXJydWgueWlnaXRAYW1k
LmNvbTsgSmksIEthaSA8a2FpLmppQGludGVsLmNvbT47IERvb2xleSwNCj4gQnJpYW4gPGJyaWFu
LmRvb2xleUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjZdIG5ldDogYWRkIHRo
cmVhZC1zYWZlIGNyYyBhcGkNCj4gDQo+IE9uIE1vbiwgMTAgRmViIDIwMjUgMjE6Mjc6MTAgKzAw
MDANCj4gQXJrYWRpdXN6IEt1c3p0YWwgPGFya2FkaXVzengua3VzenRhbEBpbnRlbC5jb20+IHdy
b3RlOg0KPiANCj4gPiBUaGUgY3VycmVudCBuZXQgQ1JDIEFQSSBpcyBub3QgdGhyZWFkLXNhZmUs
IHRoaXMgcGF0Y2ggc29sdmVzIHRoaXMgYnkNCj4gPiBhZGRpbmcgYW5vdGhlciwgdGhyZWFkLXNh
ZmUgQVBJIGZ1bmN0aW9ucy4NCj4gPiBUaGlzIEFQSSBpcyBhbHNvIHNhZmUgdG8gdXNlIGFjcm9z
cyBtdWx0aXBsZSBwcm9jZXNzZXMsIHlldCB3aXRoDQo+ID4gbGltaXRhdGlvbnMgb24gbWF4LXNp
bWQtYml0d2lkdGgsIHdoaWNoIHdpbGwgYmUgY2hlY2tlZCBvbmx5IGJ5IHRoZQ0KPiA+IHByb2Nl
c3MgdGhhdCBjcmVhdGVkIHRoZSBDUkMgY29udGV4dDsgYWxsIG90aGVyIHByb2Nlc3NlcyAodGhh
dCBkaWQNCj4gPiBub3QgY3JlYXRlIHRoZSBjb250ZXh0KSB3aWxsIHVzZSB0aGUgaGlnaGVzdCBw
b3NzaWJsZSBTSU1EIGV4dGVuc2lvbg0KPiA+IHRoYXQgd2FzIGJ1aWx0IHdpdGggdGhlIGJpbmFy
eSwgYnV0IG5vIGhpZ2hlciB0aGFuIHRoZSBvbmUgcmVxdWVzdGVkDQo+ID4gYnkgdGhlIENSQyBj
b250ZXh0Lg0KPiA+DQo+ID4gU2luY2UgdGhlIGNoYW5nZSBvZiB0aGUgQVBJIGF0IHRoaXMgcG9p
bnQgaXMgYW4gQUJJIGJyZWFrLCB0aGVzZSBBUEkNCj4gPiBzeW1ib2xzIGFyZSB2ZXJzaW9uZWQg
d2l0aCB0aGUgXzI2IHN1ZmZpeC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFya2FkaXVzeiBL
dXN6dGFsIDxhcmthZGl1c3p4Lmt1c3p0YWxAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiANCj4gVGhh
bmtzIGZvciB1cGRhdGluZyBzbyBxdWljaywgYnV0IHRoZSBwcm9ibGVtIGlzIHlvdSBuZWVkIHRv
IG1vdmUgdGhlDQo+IHByb3RvdHlwZSBmb3IgcnRlX25ldF9jcmNfZnJlZSgpIHRvIGdldCBpdCB0
byB3b3JrLg0KUHJvdG90eXBlIG9mIGAgcnRlX25ldF9jcmNfZnJlZWAgZnVuY3Rpb24gd2FzIG1v
dmVkIHVwIGluIHRoaXMgcGF0Y2gsIHNvIGl0IGlzIHZpc2libGUuIEZvciBtZSwgdGhlIHByb2Js
ZW0gc2VlbXMgdG8gYmUgdGhhdCB0aGUgYHJ0ZV9uZXRfY3JjLmhgIGlzIG5vdCBzZWxmLWNvbnRh
aW5lZCAoZHVlIHRvIG1hbGxvYyBhZGRpdGlvbiksIGFuZCB0aGUgY29tcGlsZXIgdGhpbmtzIHRo
YXQgdGhlIHVua25vd24gYXR0cmlidXRlcyBhbGlhc2VzIGFyZSBhY3R1YWwgZnVuY3Rpb24gYm9k
eS4gSSB3aWxsIGZpeCB0aGF0IGluIHY3LiANCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS1CRUdJTiBMT0dTLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
Iw0KPiAjIyMjIyMjIyMjIyMjIyMjIyMjDQo+ICMjIyMgW0JlZ2luIGpvYiBsb2ddICJ1YnVudHUt
MjIuMDQtZ2NjLW1pbmkiIGF0IHN0ZXAgQnVpbGQgYW5kIHRlc3QNCj4gIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCj4gIyMj
IyMjIyMjIyMjIyMjIyMjIw0KPiAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+DQo+IC9ob21l
L3J1bm5lci93b3JrL2RwZGsvZHBkay9saWIvbmV0L3J0ZV9uZXRfY3JjLmg6NjE6NTM6IGVycm9y
OiBleHBlY3RlZCDigJgp4oCZDQo+IGJlZm9yZSBudW1lcmljIGNvbnN0YW50DQo+ICAgIDYxIHwg
ICAgICAgICBfX3J0ZV9tYWxsb2MgX19ydGVfZGVhbGxvYyhydGVfbmV0X2NyY19mcmVlLCAxKTsN
Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXn4NCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKQ0KPiAvaG9tZS9ydW5uZXIvd29yay9kcGRrL2RwZGsvbGliL25ldC9y
dGVfbmV0X2NyYy5oOjYwOjE6IGVycm9yOiBvbGQtc3R5bGUNCj4gcGFyYW1ldGVyIGRlY2xhcmF0
aW9ucyBpbiBwcm90b3R5cGVkIGZ1bmN0aW9uIGRlZmluaXRpb24NCj4gICAgNjAgfCBydGVfbmV0
X2NyY19zZXRfYWxnKGVudW0gcnRlX25ldF9jcmNfYWxnIGFsZywgZW51bSBydGVfbmV0X2NyY190
eXBlDQo+IHR5cGUpDQo+ICAgICAgIHwgXn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBidWlsZHRvb2xz
L2Noa2luY3MvY2hraW5jcy5wL3J0ZV9uZXRfY3JjLmM6MzogZXJyb3I6IGV4cGVjdGVkIOKAmHvi
gJkgYXQgZW5kIG9mIGlucHV0DQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBidWlsZHRvb2xzL2No
a2luY3MvY2hraW5jcy5wL3J0ZV9uZXRfY3JjLmM6MToNCj4gL2hvbWUvcnVubmVyL3dvcmsvZHBk
ay9kcGRrL2xpYi9uZXQvcnRlX25ldF9jcmMuaDo2MDo0MjogZXJyb3I6IHVudXNlZA0KPiBwYXJh
bWV0ZXIg4oCYYWxn4oCZIFstV2Vycm9yPXVudXNlZC1wYXJhbWV0ZXJdDQo+ICAgIDYwIHwgcnRl
X25ldF9jcmNfc2V0X2FsZyhlbnVtIHJ0ZV9uZXRfY3JjX2FsZyBhbGcsIGVudW0gcnRlX25ldF9j
cmNfdHlwZQ0KPiB0eXBlKQ0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+
fn5+fn5+fn5+fn5+Xn5+DQo+IC9ob21lL3J1bm5lci93b3JrL2RwZGsvZHBkay9saWIvbmV0L3J0
ZV9uZXRfY3JjLmg6NjA6Njk6IGVycm9yOiB1bnVzZWQNCj4gcGFyYW1ldGVyIOKAmHR5cGXigJkg
Wy1XZXJyb3I9dW51c2VkLXBhcmFtZXRlcl0NCj4gICAgNjAgfCBydGVfbmV0X2NyY19zZXRfYWxn
KGVudW0gcnRlX25ldF9jcmNfYWxnIGFsZywgZW51bSBydGVfbmV0X2NyY190eXBlDQo+IHR5cGUp
DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5efn5+DQo+IGJ1aWxkdG9vbHMvY2hraW5jcy9jaGtpbmNz
LnAvcnRlX25ldF9jcmMuYzozOiBlcnJvcjogY29udHJvbCByZWFjaGVzIGVuZCBvZiBub24tDQo+
IHZvaWQgZnVuY3Rpb24gWy1XZXJyb3I9cmV0dXJuLXR5cGVdDQo+IGNjMTogYWxsIHdhcm5pbmdz
IGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzIFs2MjkvMjEyM10gQ29tcGlsaW5nIEMgb2JqZWN0DQo+
IGJ1aWxkdG9vbHMvY2hraW5jcy9jaGtpbmNzLnAvbWVzb24tZ2VuZXJhdGVkX3J0ZV9tcGxzLmMu
bw0KPiBbNjMwLzIxMjNdIENvbXBpbGluZyBDIG9iamVjdCBidWlsZHRvb2xzL2Noa2luY3MvY2hr
aW5jcy5wL21lc29uLQ0KPiBnZW5lcmF0ZWRfcnRlX2FycC5jLm8NCj4gWzYzMS8yMTIzXSBDb21w
aWxpbmcgQyBvYmplY3QgYnVpbGR0b29scy9jaGtpbmNzL2Noa2luY3MucC9tZXNvbi0NCj4gZ2Vu
ZXJhdGVkX3J0ZV9ldGhlci5jLm8NCj4gWzYzMi8yMTIzXSBDb21waWxpbmcgQyBvYmplY3QgYnVp
bGR0b29scy9jaGtpbmNzL2Noa2luY3MucC9tZXNvbi0NCj4gZ2VuZXJhdGVkX3J0ZV9uZXQuYy5v
DQo=
