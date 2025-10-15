Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851BCCCD194
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 15:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5132340677;
	Wed, 15 Oct 2025 17:53:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5814C40273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 17:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760543594; x=1792079594;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=/XbYxZKLjfrpJBn6Hjf8gZpiCk7mrSnA/5+fv0tQZTI=;
 b=JiN40b+H94byi9i5g+TxrofifTivQlvaT1Zq2LcN79HoNyIqa07/MDQM
 LtmYTNk0ZWU8ss7D+iQTPw66sERes3M2kCvxiyIIz2t7vol4wZzPi/U67
 gWJUeZiupuNE4TJX8Em6dhJHP+8OpAgzX1oNFFBY9ULRKhpXGbWb4QXrc
 i/WG4Eib7h05tyKGXHzTV2O9AVEXCFdRHGMHvQDL7VUQ4kkAEUYW8/W7w
 6mc28F76R8VPHlndkkxRBt1NjYI0fwvW2fx46ZWqVQURVCyFbk+Fup2Xa
 7XL5yTidy7bkTPG1J+wQEO5zldkQsjHkMNJVzbth71uyfSGkDn6zdzpKQ Q==;
X-CSE-ConnectionGUID: rcvz3xpLRlC/WbdrLIVKhQ==
X-CSE-MsgGUID: QVJGAp9mSrqVV9/+tzTBHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="61753983"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208,217";a="61753983"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 08:53:12 -0700
X-CSE-ConnectionGUID: 0EbdE5YtT0+tEPlVLTNSBg==
X-CSE-MsgGUID: knUQ2DrHTlCQ7CegRs0zxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
 d="scan'208,217";a="219350614"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 08:53:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 08:53:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 08:53:11 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 08:53:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXvkiuAZLnhClszZ3FzhNFhZGsNHYL5bUT3qjvlRMWpMk//OE8LBmrI/veVVkLRYrZ0y/MSiixNBTd3fnm5JYgiaQI5ITY8iVZOal3xa/EZGnliQG4KUmDp1L5szcSrAvOsdqdCss9GqtS4piBk5wXYvrXUxdlTnaI0WEHlYVMH1J03p0UOBflm+igWXPZWrZXtSN0ddZfpNAtneZsub9kiQeVvpWq3+sTrHPM46zECdtPm5KgNUWolFk+J4he77uk9a58Av0ZebXUEC+C4mjJDMfdLyoQwq47Gfx4jSl/ksHTi/Le8cvNm2XlQBScMknINnOvK6gJv2bSf/6TOY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XbYxZKLjfrpJBn6Hjf8gZpiCk7mrSnA/5+fv0tQZTI=;
 b=TKRxMJg2UREVIXGa6qIUZnTet5HNV1GEfWbGJmUdHLcY+oKqqdzDsAzpHBoVW5OwERXSspprB+ot+eEX8bAaKdaABXpya1aR434n9ZHC12ND4nxjk57Ffv6SpA2yj+wJkNCtyN0V0/fCz5SYTLfvVeejIkN2Rqp41Yf+WMuf/Ps56xvrWeiZQlCpgPUSHMcKSq7hSYeE7ZXa2vZCw6K3gfHNqwZDQ4Nn+lbNgYP8GYlONfmQ2ZQTvzVwYFSn7ud+GCBiceGIsp+rVjpm7ADxebYjIzEQD7GI8duY7soc22U4LOsuabroPOyaVi+Lww2aEzfG+wQIPt+ZwzNd3cMadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 15:53:08 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 15:53:08 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Finn, Emma" <emma.finn@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling pointer
 for SHA test
Thread-Topic: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling
 pointer for SHA test
Thread-Index: AQHcF/4lsV8c1wl/2kOAiJRDCe/QbLR30B4AgAGcUoCAAAF8AIAABNYAgAAayQCAABAUgIBKBqEg
Date: Wed, 15 Oct 2025 15:53:08 +0000
Message-ID: <DS0PR11MB7458B0BBD71209DB366BFD1281E8A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250828092822.2791101-1-emma.finn@intel.com>
 <CO1PR18MB471416C114E8D59E97EEBE2FCB3BA@CO1PR18MB4714.namprd18.prod.outlook.com>
 <CY8PR11MB784530D82EB6D7A7D4EF1F99EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
 <CO1PR18MB4714A60A5FEED89BA023628CCB3AA@CO1PR18MB4714.namprd18.prod.outlook.com>
 <CY8PR11MB78457F3C1B8380E1903391D8EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
 <BY3PR18MB4705890AC3B3EC7AD3E89F3CCB3AA@BY3PR18MB4705.namprd18.prod.outlook.com>
 <CY8PR11MB7845999CCF5464976CFF3DF8EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB7845999CCF5464976CFF3DF8EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|CYYPR11MB8388:EE_
x-ms-office365-filtering-correlation-id: e8b653c4-06c8-42b9-a307-08de0c02efe1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|42112799006|8096899003|7053199007|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?iRcRJU44XVipvNXlJ+wz76XJ19OHWO2K12szFU+HY1vE/tvNQJNCLIfraQ?=
 =?iso-8859-1?Q?Ks5now87THfONSqJpFCX9SKrCJIAPCXzDQElMLsH0CoouQT8SOxF2jfQ/V?=
 =?iso-8859-1?Q?N4t+1Rs8ufZvwptx/nalJ0RleMDE4h57WggjmFm3OTnePQJ7GagWaxT/pl?=
 =?iso-8859-1?Q?C1qdMSPuCzpKOM5ha5RKuiLRp1h7946qLKiCk5NKBy7rjPDFcEiklje9ej?=
 =?iso-8859-1?Q?tloLdPAnnv4DWp/fozzrAuOYQNxUeISNbjRmmG8+iBo9TMwvES1ItVF31/?=
 =?iso-8859-1?Q?j5b0e8u1PVk4EuDtn3hsCBaXWPM1iGujuDdOh8S4G/C4O87Egr+CF1UfjL?=
 =?iso-8859-1?Q?5pcWcx7tBshKH1wZ+HOp3xgKvF/Xo5hEd5F7izgNQsBTPtCVTY30XQPzzc?=
 =?iso-8859-1?Q?fSx+LMclBdwkA7/QtbWHXmEgiLG5RvG9vIgUDyD8K1NRg3HxtgMTThkkZB?=
 =?iso-8859-1?Q?3k3JFc1USmi78B3AnqA/nmtDp5giussEFDTfvd0MBWHiU1dsVr2PSu4wq9?=
 =?iso-8859-1?Q?Fs7ZtgnFsKo6LH6wTWwE56LD2if8RvcTIw0c984cB+shjc5UMgIIKf6J6i?=
 =?iso-8859-1?Q?EQC0/NIVcVD6YlaagMxltNymJMwLox4JJO8GJEZuiCqUBDwd8RApFeAY3e?=
 =?iso-8859-1?Q?EfZc4FkG+Nohv+tvjIVHuq+S9jLpeGSmvfR7CFZ7b0mzkXGXa4yo3I5W6R?=
 =?iso-8859-1?Q?WrXCbn2Prp95RLZ6uxEdBRABJPX9pz792KNC1dfyrlc7TVoA0q3YgmqZPn?=
 =?iso-8859-1?Q?ZbpNmYzvTa3hO3tCAjKN9McbzHKe/MY4rhtSqXJn+CuItBBwuTMmL62u3m?=
 =?iso-8859-1?Q?kv7drFOB4nvwS4zm+xcTIz8N/bOspZtlr+Fd51yN5ygYel2gC5pJ4jRhB1?=
 =?iso-8859-1?Q?WvG96uObbS+o8p6EAh7S7R/GOhqIvatyZ/ma047U7Nb0WGt4pNqaetzkBx?=
 =?iso-8859-1?Q?x8xPYY7l+u285XMlzitcLB7FyxHEEA+9Mvr1sQWf1OYBi8tOjW5MIQBpeH?=
 =?iso-8859-1?Q?UsGy6AN2Y6zi/I0DsTu3cFzDW7Kw6XKE9/gtL76/roPsfPpQKa0OgKet2K?=
 =?iso-8859-1?Q?wcrrR1i38GY3gPcbVlswkYReMuQVBOS+KMQv+EeaAAkh/fBWdz70s77LPQ?=
 =?iso-8859-1?Q?3k1sjkEQR5fNsfpV7bgGmA00Q89UnanCQ60vdOyrw97d595703duBG1CFN?=
 =?iso-8859-1?Q?68qVFAK/5n5bl7HTm6Rw6czsrlP1Hj32LidXNtKB5JzhKBGE4e2JUv9+5E?=
 =?iso-8859-1?Q?YpjuG47juvil4TewNReK7BIETd2afPJOhmCoC/9H3c5ZO+4C753XvNsdyv?=
 =?iso-8859-1?Q?4TNgU/kelqUKh+EhEsVjWpTd0PP4f+wFH7RqmQN6HPzqxCx55wstx0wtrZ?=
 =?iso-8859-1?Q?MRjcIKAVJB7Y4see6QQn7CLgx3RpFzm9Q7m2nngXRZit8TAwZaa4YJjygW?=
 =?iso-8859-1?Q?yDYoMRy2oN9xyqKbPkkimkuWahpE6gWdizd30gn3g+tZezihYkc+r0rBpM?=
 =?iso-8859-1?Q?eIXnnrfrvl5WcvxoB1ZhEfFdZmAEpMn/z7UvSuA4OQ/FUAgAKPq20eocKk?=
 =?iso-8859-1?Q?17vRavDCvK/GhSBrW7v7JW/hFckJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(42112799006)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uOUyUKl/W+ZCsQVxAFtBN4hnlmuh4rSCXFpg+F1PFCm5TT2X2Ge5YEh8GY?=
 =?iso-8859-1?Q?NqtUPuUSGYOcGk7ojPCmnB1oPSlZI6z5A7VN8QjC0OKHc3Aym4YRcxkZwi?=
 =?iso-8859-1?Q?8dVDwOYx5gkqorDZ1SB776nm4/bCvKDpVfA/l9vQbXoEwDz3BhwaeoACjo?=
 =?iso-8859-1?Q?P+/0VR7sJwPprUxYa40CBBVde9+7SZeRDHaorA4JQFoQEOdySOrWkt0dLp?=
 =?iso-8859-1?Q?gFeWYEVehSbTAJO1EGXM4VGNJ5qCyZJlI2A44Hez4uoU7Pg1otpkcJBi6V?=
 =?iso-8859-1?Q?KZl7Fc20pFYHTdVehPbESiYLD+SXugR5k2z/wK/a27eH0rziAKsE4c7hNS?=
 =?iso-8859-1?Q?xlNgTzn74l6cpI703yOPyURJclKf6ZVqlJtDl2E21lxDm7/fUGoFUvsww9?=
 =?iso-8859-1?Q?DtIflP+KtNkBVQAVhlxkOkEOotMJm4hShcpQHNXsPB3reTlSI6Hif9iV8P?=
 =?iso-8859-1?Q?gTJ8YtNqv9vbxv1zwVXk2Ynje4wlk9vh/4GcH26F9kEg2mlUuuXmwUxl+H?=
 =?iso-8859-1?Q?FiaxybyywWtw4OnxYCAcy0A+Ps4qvaZigZj7aKXhO20oV/FJ+BNL+umcnL?=
 =?iso-8859-1?Q?QOAsvPDwkLnNIkG0ggzBLeh1ESPomnBsaCigNykfWAhr/0Fana3QF+GVlH?=
 =?iso-8859-1?Q?AcPWsz9lzdGt5zGo3Z8XHzO7yw/bGzaWtHdOsUfuW8XHVFkTl8MH5WqYWR?=
 =?iso-8859-1?Q?iij8tMbFpXn7cU+KmgZ+EYMLXxJEiD1hDfxDy8j6H1+HI4FdyIb5S0i4kj?=
 =?iso-8859-1?Q?I/ne1/TlLSUoFkvKgYw1XWrB5k+0klgch8qsEEUHYYYLlI6E+jvEGX9IQw?=
 =?iso-8859-1?Q?NJ0rCW345DshOtgiZCHkMfwl8V6OESZfCgToRPXGDLvhvLnxJPKqLgjehF?=
 =?iso-8859-1?Q?dDN36mMqXZXHFu/VdHYwk/KRUFDXLKwUItzqtb4DZ/SxoVUBGeIdHLLw7h?=
 =?iso-8859-1?Q?rpVr6VPOLA060TCCuCC8U/VwjA8dy0xbu1j7ntGpUKj2ZTabAoecD8PxHs?=
 =?iso-8859-1?Q?XwkBy6YpLnqI8VkP2xkpyQ0Jwazhec4LnyjnOKclw2ho28GL0WByBIrwdm?=
 =?iso-8859-1?Q?Lq0TR2I19E+kQiChZbatoEH+ItCC6hzKNAkI7lLCkS2+rk6r5gLA72GFvL?=
 =?iso-8859-1?Q?XxaW2nfa4O6rUDeCHUfYA+LMZBw9uxVEhOltArz1Oymn0K3dfvPD9aR3yh?=
 =?iso-8859-1?Q?grUVN/2UB8jESdm+cjE9QLUoCGqre4fIDXG4orpZR0zTo4ah6wgG/Vw1CQ?=
 =?iso-8859-1?Q?RwLMqOtSWYDZPysyLjBdzcGruV/3ySIA9OI9JJ1sBWvTOnmhCm3Qw4WqF7?=
 =?iso-8859-1?Q?tMe+yxulCDyQvqsT4jSLzfm0//sTegptrAevldcBkjeYMTpmUdaipJGmlv?=
 =?iso-8859-1?Q?chVeY1vuLgphNltoigX8rKXlyHvTkjE51vZQN3aYKXzFGe/A5UADS72avq?=
 =?iso-8859-1?Q?AN7pJPXMQnX2Zlbhjre2VY+eWWHpcd6dOwWBoLncv+xDoT4BivjBZfoQQL?=
 =?iso-8859-1?Q?cejQ/GBcuN1bitF5Ifo2HPpYq49nls31JxLkKPkoReh6NZwRziTwRTBnVG?=
 =?iso-8859-1?Q?HVZqtDj/7U2zfHUO2JGg4AlnauxAyV5vxxJtThWaYURl6KmN2sUw/TcPNY?=
 =?iso-8859-1?Q?fw0n9rdb5VALKchUcdnGBrlP8yOvcZI+P8AlIyPWuhgIWav7pFG2Nv24Wt?=
 =?iso-8859-1?Q?dhc20pgys2nBw3720yI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458B0BBD71209DB366BFD1281E8ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b653c4-06c8-42b9-a307-08de0c02efe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 15:53:08.6940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9t6bWlskaiDLMtDzCCpXKYP0lrec4lMiR+gSV+veGlOf8deZWpXCY+t7POzbhsPLEacJ8hYzTt+tR8Gk3IN3Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
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

--_000_DS0PR11MB7458B0BBD71209DB366BFD1281E8ADS0PR11MB7458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Gowrishankar,

Have you get a chance to test this patch against SHAKE on your ends ?

Regards

Kai

________________________________
From: Finn, Emma <emma.finn@intel.com>
Sent: Friday, August 29, 2025 14:14
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Ji, Kai <kai.ji@intel.com>
Subject: RE: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling poin=
ter for SHA test



> -----Original Message-----
> From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Sent: Friday 29 August 2025 13:17
> To: Finn, Emma <emma.finn@intel.com>
> Cc: dev@dpdk.org; Ji, Kai <kai.ji@intel.com>
> Subject: RE: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling po=
inter
> for SHA test
> Importance: High
>
> > SHAKE is not supported by these hence I did not catch it.
>
> OpenSSL PMD supports SHA and SHAKE. Could that help verifying both lines =
of fix
> ?.
>
> Thanks,
> Gowrishankar.

OpenSSL PMD only supports SHAKE-256 for EdDSA operations, not as standalone=
 hash functions

--_000_DS0PR11MB7458B0BBD71209DB366BFD1281E8ADS0PR11MB7458namp_
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
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Gowrishankar,&nbsp;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Have you get a chance to test this patch against SHAKE on your ends ?&nbsp;=
</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Regards&nbsp;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Kai&nbsp;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Finn, Emma &lt;emma.finn@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, August 29, 2025 14:14<br>
<b>To:</b>&nbsp;Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.com&gt;=
<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; Ji, Kai &lt;kai.ji@intel=
.com&gt;<br>
<b>Subject:</b>&nbsp;RE: [EXTERNAL] [PATCH] examples/fips_validation: fix d=
angling pointer for SHA test
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.com&gt;<br>
&gt; Sent: Friday 29 August 2025 13:17<br>
&gt; To: Finn, Emma &lt;emma.finn@intel.com&gt;<br>
&gt; Cc: dev@dpdk.org; Ji, Kai &lt;kai.ji@intel.com&gt;<br>
&gt; Subject: RE: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling=
 pointer<br>
&gt; for SHA test<br>
&gt; Importance: High<br>
&gt;<br>
&gt; &gt; SHAKE is not supported by these hence I did not catch it.<br>
&gt;<br>
&gt; OpenSSL PMD supports SHA and SHAKE. Could that help verifying both lin=
es of fix<br>
&gt; ?.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Gowrishankar.<br>
<br>
OpenSSL PMD only supports SHAKE-256 for EdDSA operations, not as standalone=
 hash functions<br>
</div>
</body>
</html>

--_000_DS0PR11MB7458B0BBD71209DB366BFD1281E8ADS0PR11MB7458namp_--
