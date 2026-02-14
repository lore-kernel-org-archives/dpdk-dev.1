Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7829DEF99E1
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 07:10:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60440402C0;
	Sat, 14 Feb 2026 08:10:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6C87240151
 for <dev@dpdk.org>; Sat, 14 Feb 2026 08:10:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771053047; x=1802589047;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=JnBNezp+D8dLcxf4yhI53jQaQPUG82ESN9R+yJL4H7U=;
 b=fMcJh98TgqbYoGCH/wmSCMW7kJnecu+mrVI1ffd7WOxvffoMa05ZiXh5
 +vn5WGun5GQrSoZKeFPCNQg5DsW7STRJnTDzzvYzDHecyFl0HGH9BIfz4
 2SwH/+eLfqmKOy8M/JBYkdLiXbmQoaC038MQQCzEukhAGZgo58u0mLIRP
 eafK4L3RQpxZ41wW24jlHjgs7Pzs2ALLJH5itTyM1wbKwNtlF3DaoEQkq
 PKVAY72iW6OTyXt0nnBbH5WezOnNw4zMJfqa9ZE/30x28bl3i2wTlYik1
 5t9tkCkB9f1EVRqPWNfP+6/RQgmo/fpPYYOHLUF0a5dMiavQZRamJqsj3 w==;
X-CSE-ConnectionGUID: WhVjceW9Sd+Ny7F2ilU1tA==
X-CSE-MsgGUID: 0dHpFdQnTbis9ptK8ykjuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="89640605"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; d="scan'208,217";a="89640605"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 23:10:45 -0800
X-CSE-ConnectionGUID: T3TpDV9ER6CvVp39nCz0Sg==
X-CSE-MsgGUID: HZ3Jff3vRUKOVXuzPd0KKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
 d="scan'208,217";a="217234117"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 23:10:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 23:10:43 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 23:10:43 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 23:10:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mV6wv+Yk3IAGuiebs+U7GE6T46TLKfvJTQ+DN8xuDRTkOs8PChXXSljMJ102NDRwAsc/JwUakMWdP/I2BjojqtrVI5ZjQHKWufr3B8nwfGj/7jMFKtzUz7DxkFywo2E48Av65q50wwv2T+4ZkmN3eKBY9irDkKdtZTWbzXI8BixAhMRV7Raw7fhVhs8UvrNKvaoTRAvkUcqX09BQiF1L9IgXGNPIJkitbL0TqVMwuyDwyoHI1YBRvIBpSezU+lbuSFprwTeib6prT2SLmDjA/ZRcv3PtZv/IQciVOSawWG03WLIFd7xyhqW0y2pBIYBo31YfT+82BeUdVZVWIvCt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iEUOb1lStFHqjs1m0pho6SRTJLqxLAkRSUceRk6c9U=;
 b=dd1OHrHptDXy5oepPo+UMVoumY/osUHhGTIkyc9ljVpB7kDDcX1V2aKFyfl6T50Pi/1kbITBpKPHSQgvfNSz79SUtqOeLAdvrz+1aaqVzxICSj3bmq6ByY1EcsJD9ZNKVvYPOIC0ecPKGYXKL0LkKTnROs1boYlZqqp8JUGJWRZzlrAmBVXVmHKT/KseyySfu+xHhQvpFf+6sqM63dAVKK2RbDLzH7gkNzzTsAPyIMgPvunqp3bUYQdyKKBBM8j4jFyJIboV0bNm3HzeWcpcKrgO3D6XsjZ4hc3ICuGGREBOt7LgGddySXyDIlNGWvpI9VhHqOjUbYLfii/GGaZ5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by DS0PR11MB6326.namprd11.prod.outlook.com (2603:10b6:8:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Sat, 14 Feb
 2026 07:10:39 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::1457:eb10:8766:7a67]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::1457:eb10:8766:7a67%3]) with mapi id 15.20.9611.013; Sat, 14 Feb 2026
 07:10:38 +0000
From: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Kumar, Rajesh3" <rajesh3.kumar@intel.com>, 
 "Singh, Aman Deep" <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v5 2/4] net/idpf: add PTP virtchnl2 support
Thread-Topic: [PATCH v5 2/4] net/idpf: add PTP virtchnl2 support
Thread-Index: AQHci5I4PPGyombOTEiHzkzFN49tb7VxANCAgBDoW+M=
Date: Sat, 14 Feb 2026 07:10:38 +0000
Message-ID: <CY8PR11MB7747A6678C62416C551473B8F96EA@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20260120191120.137078-4-soumyadeep.hore@intel.com>
 <20260123000449.188008-1-soumyadeep.hore@intel.com>
 <20260123000449.188008-3-soumyadeep.hore@intel.com>
 <aYHvl8fWWcS1ZKNz@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aYHvl8fWWcS1ZKNz@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|DS0PR11MB6326:EE_
x-ms-office365-filtering-correlation-id: fdd86409-a37d-4c0f-8fe6-08de6b982849
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FvjZabuEY5LQWH2EsW5Toene8oxGmP1VQ/BhKcv1x3tb4vf44GBanYqaID?=
 =?iso-8859-1?Q?kwElCTBc5/e4cxMGTVHohGkiQt9TmoauF55vncUY3IkjsYZmwq/oDz40cY?=
 =?iso-8859-1?Q?xcbMVsQ6tQhj+r+lSZDU01wG9p8B8GMUzkzWd/V3u7goJJCfVeEjV0dagY?=
 =?iso-8859-1?Q?Yy4HAh+4JU/XSsbd2oUJrToZRSdoHDvX3csTc3kFA70bjV1GRGupobjFf7?=
 =?iso-8859-1?Q?A8i2G8sGcVMe4w5eM/piD3iikNBzHFGY0w5+IDh7nyqXlS2v11evOzOCEE?=
 =?iso-8859-1?Q?fmTWIX2vyOLnTVXUjqCccBKSbkckRYH5489Ob7mm1xvMy8gz2pt4qVALlJ?=
 =?iso-8859-1?Q?cawXxvCfnnZAkOQ+23ndm92/7dtIyzS2Lod6KZpEOdknIBB1PIBcDevpwS?=
 =?iso-8859-1?Q?USxbucQrOWqUTz3DkFbFX/SXzS/NbFRSqXUwtSSMATMm9jqJP8tZmosT+o?=
 =?iso-8859-1?Q?eRrY7qEVNdLf347yqK7YYjIekzylvTmXSurg/kHb099bLjsykMsDN2bISi?=
 =?iso-8859-1?Q?vaWkovQ6I2WHUrqLPLUR2mbtfBuMoSUNgas5rQ/4ANXptRN4KhGOxeox53?=
 =?iso-8859-1?Q?8Eq7CAvgBPj1pKh5Tmkpzp49UNKCgxVxQAU9UHijrJmSGg49l3dNb1dyOg?=
 =?iso-8859-1?Q?NByebE5Ly2g5PbMLTXvcGV/xt6YuoMtq/uViXCqJXojw2cRnsRXeyXl+jk?=
 =?iso-8859-1?Q?Z8/4f2ZxH05p0T3m54PwIy+CqXtX7zkAuZ7eE/kpoVCD7YTukjozyES1f4?=
 =?iso-8859-1?Q?CmjbOhFa8z9Dj/cPIoix0tLLyLkmw50JUZLn4soYaaePrPcRI7wnfC3oex?=
 =?iso-8859-1?Q?YknoRlCI00X2D9+RTA32FZMuByCpM4x/IWzMDLxIrDrgqm9Fr65fvfnGwo?=
 =?iso-8859-1?Q?0bRy/9HywVNutJBImx6Lq6JNCWaq6kV5Kpg6/PC3j5tORRJmSMytgzsWeX?=
 =?iso-8859-1?Q?JAUY7nIQBhc1sink9qCv2717sPzILC9XPH9aMyHvJJ2Raunv++aVsM08+d?=
 =?iso-8859-1?Q?anO/ci+RplXHumOkKNPUtt64r4pd+GcqDSBZ2rN6hI4m+qvlXBLuHhd4gX?=
 =?iso-8859-1?Q?Y8Vfnn7FhmwGXhUHCeUXtkHOv5mvYRGABHB3/XyENyn5bwMfDTNtT0vvZa?=
 =?iso-8859-1?Q?sjijS6OSYyhw869A/l12z4xu2VytWJQsaK2H8hLlvjGtfhdMln6s/huk35?=
 =?iso-8859-1?Q?lsrUShOYFZVoU6NeuxazDyebGWKNUIQXfVt1CU/sYGvvZVbqxUYLbuPaeW?=
 =?iso-8859-1?Q?8TTHwV9dEBn1W4WfplZjsBkuj3rygeTO8Xmwx/1xcWjB2oDAU9TxzqBb2N?=
 =?iso-8859-1?Q?571s628I8aF8PDp3JXiPrE20OPgoC9hc4c56Uop4PYpumG1au9ugefMLbr?=
 =?iso-8859-1?Q?t4968Js1Z7NlQqXKhInIHciIBM7CsvVhwyeCw27/SLQNvwJNlVmTgS8Hc7?=
 =?iso-8859-1?Q?HDyP8R0XaRAvVlQdB0rqkJq4opz3KGgcJtmNSJKMs85BdZUe3MNHYq98og?=
 =?iso-8859-1?Q?dHs7qCfaPAysOn9n16pQ0AICwR5JVIxyX5vpMRtpzS4OcGKg7W4tIU0uwE?=
 =?iso-8859-1?Q?YLR58ee2B9Bq07Wvi9UhGXMEIj2VKsF/iRiKwXaAV1trrfxqg5B1ztORNI?=
 =?iso-8859-1?Q?aY9zoHZsnqIwDt5R8PjzlQsrIuKO9XMP/zfXswLdA/qyHPgR2t7WQF0h+3?=
 =?iso-8859-1?Q?AUNp6QtOI4j0/DFoex4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7747.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5wxTJ1PSbPuFvpz5NboKXAf5TFGMbPJAyCef/jIYj9NX4K6m5YKIYnDqlq?=
 =?iso-8859-1?Q?hEnsdQXpoZhvrGu+EWDAc4jeq0xJ46WQSRU51PT5jVYFIQEWwQTsMA7OJ8?=
 =?iso-8859-1?Q?OIoyoIVL0ineICpxvvl2m9geMh2IIUvTbp1vs6wLzrYnKmY6562ZRudKvZ?=
 =?iso-8859-1?Q?Nc275u+3IKhbkRDYf7dEQ/QlBM6C5cs70tbCHM4WhoOsfqYe+MAEwDv5VU?=
 =?iso-8859-1?Q?RTHxfFJovHo6GCUzNvTg1vU/n09WyM0MEwdB1M2qnF+6gqQmhZkHwmNZXF?=
 =?iso-8859-1?Q?kc+hH1cZf3jFuQuZwjqx0XT6dCGcH229kGmHcwXWdbCw4Za4LS2N42Z75N?=
 =?iso-8859-1?Q?TrTOxH4DJxqytwSudhFHzn9EaEUVjbHn4vbzzDOWATlRF6pktJojF6eDvJ?=
 =?iso-8859-1?Q?SabLJAUdx2DmjTMfv57fUDpAU0194E+trH7f5R8D7D21INfL33dS6b3UF9?=
 =?iso-8859-1?Q?ICQsBHUI8FutPGwIXr9v8Ywz8J5NKeZiCCWrE+JZ2tULnJYFEz9AijQhSh?=
 =?iso-8859-1?Q?t+wXY1biXYFzXFWXMOXSfteMepzt76ZjlE1EODYfbkBJ73cvHRenf8c7jR?=
 =?iso-8859-1?Q?U9rNs8w3Jz9368uruDmm9ZunJISq0iPa4vBCy2d2rmMi3jG3N5FGdgg84H?=
 =?iso-8859-1?Q?wS29SPYSwYKNogm8ukPHST5LONVMfdzIzxfKtCXSPa1kZLAM86PF22nJBB?=
 =?iso-8859-1?Q?7x1qKD0Rv56/MSW+8V99tvcTduiZ0Txc+uDmtfKz7DRrsHd3CiKVbD7HDP?=
 =?iso-8859-1?Q?Z6wqJXrJ/dv1loIqJSw7RBv9aHwqOhzA2J5w+69TxPCW/VYkk6hcCqNdh5?=
 =?iso-8859-1?Q?dM0JUFKkmOykaV4gvDQNiuda+aLtltAeub+GotC3Xoky4OkyzlwUdbwB7a?=
 =?iso-8859-1?Q?ebFwSf8Da7yxF1el6plC6X9nzmWuRQhRA+zixou6qDAARfZt6uZSveiS3D?=
 =?iso-8859-1?Q?tJVANIEU0oZeebz2HzgljUiuBkKTEfzoknhtQb3tkLeGxtPCWvNQontCf7?=
 =?iso-8859-1?Q?tGamBuk/7cUH7R20qt5RKCi0K4UW6MtxnS/kMSZ5IYZ0EBIXf4s2j/sXs1?=
 =?iso-8859-1?Q?lj3PQVLgE93cECOqOnhPegEgwqy+AVF/6caHBPImfrBqNM3slS/nShH9Kq?=
 =?iso-8859-1?Q?HfUgJgMQbz6TarhQqb3pi4NYInVkVSMYZ4chJNiSBqWVPyFEdDrd67tFSC?=
 =?iso-8859-1?Q?7AZiJFAx363/rfLa1d3HmonasGLazuTFv2TchKdLU9wgUDt5CSiirCEwbP?=
 =?iso-8859-1?Q?rmybHd/ZG0r43ZNOwlzU/TJu0w8ox/w4JJhvRQ6BPtKCJyLO6J4CAGoA2w?=
 =?iso-8859-1?Q?pbr/JSnpVIFQl2DUHEPuG/O8fVeBmZqHpwWE2R+Vbm5s8RFswjznhgdb5d?=
 =?iso-8859-1?Q?Zg64zvRL2+kYpxSjHGtha+Ege9GBSfIJ3AlN9b0DPnbMRkyEdhS1ONl77H?=
 =?iso-8859-1?Q?a4s5wckm5g+YQlw7Dcysskaa1JAwd/Rurzkk0OqVjpq4YYJ8jiiPy/jhTj?=
 =?iso-8859-1?Q?f5hizufX2/YUH91IWovZHO73v97w5Ihl78lH1Is2bwcI6Y8in3U1KQFeEI?=
 =?iso-8859-1?Q?ImCkDrJgT7ZMfE/+mPHcfdibOibwIwmF5/XqFLPn+BrLnvoboBwHBibMTR?=
 =?iso-8859-1?Q?A7dst9dl4bvIeTN2uzbF3tCYtxJM4EphSKWLG9QpdWL2GGdnAJqm1jQdlI?=
 =?iso-8859-1?Q?DLDhfvV4XVyFhcbV4ynsftiOrfeiJ8mZ4NvS7DNbOx/H5dB2qmCEa4kS4u?=
 =?iso-8859-1?Q?s9aQAx1iosGQLPc/1YhPqN44cE74dN7e01CGbuLh12nWqc7crlpT0AKjZn?=
 =?iso-8859-1?Q?SfbtAsaNXg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR11MB7747A6678C62416C551473B8F96EACY8PR11MB7747namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd86409-a37d-4c0f-8fe6-08de6b982849
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2026 07:10:38.7781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkmh7fSO9625cgEsBYtVlQKkHspJ9Ys0BJQO8vW/BcGEeEbbBQqdtb2AR06QgGywDnlEdtKm36Ks1JjnPQ9lLAxZsdEeMLx03Y7zQ9/LHnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6326
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

--_000_CY8PR11MB7747A6678C62416C551473B8F96EACY8PR11MB7747namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

 On Thu, Jan 22, 2026 at 07:04:47PM -0500, Soumyadeep Hore wrote:
> Add a new file - idpf_ptp - to handle PTP virtchnl messages.
> Keep the registers addresses in the PTP struct.
>
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---

Some review feedback inline below. See also review feedback from AI review
that was posted by Stephen.

>  drivers/net/intel/idpf/idpf_common_device.h   |   4 +
>  drivers/net/intel/idpf/idpf_common_virtchnl.c |  34 +-
>  drivers/net/intel/idpf/idpf_ptp.c             | 639 ++++++++++++++++++
>  drivers/net/intel/idpf/idpf_ptp.h             | 227 +++++++
>  drivers/net/intel/idpf/meson.build            |   1 +
>  5 files changed, 903 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/intel/idpf/idpf_ptp.c
>  create mode 100644 drivers/net/intel/idpf/idpf_ptp.h
>
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/in=
tel/idpf/idpf_common_device.h
> index c32dcfbb12..3c84b96225 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -90,6 +90,7 @@ struct idpf_adapter {
>
>        /* For timestamp */
>        uint64_t time_hw;
> +     struct idpf_ptp *ptp;
>
>        enum idpf_rx_func_type rx_func_type;
>  };
> @@ -161,6 +162,9 @@ struct idpf_vport {
>        /* Event from ipf */
>        bool link_up;
>        uint32_t link_speed;
> +
> +     /* For PTP */
> +     struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
>  };
>
>  /* Message type read in virtual channel from PF */
> diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/=
intel/idpf/idpf_common_virtchnl.c
> index e927d7415a..a28bc9bee6 100644
> --- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
> +++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
> @@ -4,6 +4,7 @@
>
>  #include "idpf_common_virtchnl.h"
>  #include "idpf_common_logs.h"
> +#include "idpf_ptp.h"
>
>  #include <eal_export.h>
>
> @@ -38,6 +39,28 @@ idpf_vc_clean(struct idpf_adapter *adapter)
>        return 0;
>  }
>
> +/**
> + * idpf_ptp_is_mb_msg - Check if the message is PTP-related
> + * @op: virtchnl opcode
> + *
> + * Returns true if msg is PTP-related, false otherwise
> + */
> +static inline bool idpf_ptp_is_mb_msg(uint32_t op)
> +{

The name of this function seems backward to me. We are not returning if
it's a mailbox message, we are returning if it's PTP related, no? Therefore
would idpf_mb_msg_is_ptp, not be a better name?

> +     switch (op) {
> +     case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP:
> +     case VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME:
> +     case VIRTCHNL2_OP_PTP_GET_CROSS_TIME:
> +     case VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME:
> +     case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE:
> +     case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME:
> +     case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS:
> +             return true;
> +     default:
> +             return false;
> +     }
> +}
> +
>  static int
>  idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_t op,
>                 uint16_t msg_size, uint8_t *msg)
> @@ -71,8 +94,15 @@ idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_=
t op,
>
>        memcpy(dma_mem->va, msg, msg_size);
>
> -     ctlq_msg->opcode =3D idpf_mbq_opc_send_msg_to_pf;
> -     ctlq_msg->func_id =3D 0;
> +     if (idpf_ptp_is_mb_msg(op) && adapter->ptp->secondary_mbx.valid) {

If the first of these is true and the second not, is that an error
condition and do we need to handle it?

No by default it should use primary mailbox for error conditions. Actually =
those are not error conditions but various cases where primary mail box is =
used for negotiation.

> +             ctlq_msg->opcode =3D idpf_mbq_opc_send_msg_to_peer_drv;
> +             ctlq_msg->func_id =3D adapter->ptp->secondary_mbx.peer_mbx_=
q_id;
> +             ctlq_msg->host_id =3D adapter->ptp->secondary_mbx.peer_id;
> +     } else {
> +             ctlq_msg->opcode =3D idpf_mbq_opc_send_msg_to_pf;
> +             ctlq_msg->func_id =3D 0;
> +     }
> +
>        ctlq_msg->data_len =3D msg_size;
>        ctlq_msg->cookie.mbx.chnl_opcode =3D op;
>        ctlq_msg->cookie.mbx.chnl_retval =3D VIRTCHNL_STATUS_SUCCESS;
> diff --git a/drivers/net/intel/idpf/idpf_ptp.c b/drivers/net/intel/idpf/i=
dpf_ptp.c
> new file mode 100644
> index 0000000000..b8f6afa518
> --- /dev/null
> +++ b/drivers/net/intel/idpf/idpf_ptp.c
> @@ -0,0 +1,639 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Intel Corporation
> + */
> +
> +#include "idpf_ptp.h"
> +#include <base/virtchnl2.h>
> +#include "idpf_common_virtchnl.h"
> +
> +/**
> + * idpf_ptp_get_access - Determine the access type of the PTP features
> + * @adapter: Driver specific private structure
> + * @direct: Capability that indicates the direct access
> + * @mailbox: Capability that indicates the mailbox access
> + *
> + * Return: the type of supported access for the PTP feature.
> + */
> +static enum idpf_ptp_access
> +idpf_ptp_get_access(const struct idpf_adapter *adapter, u32 direct, u32 =
mailbox)
> +{
> +     if (adapter->ptp->caps & direct)
> +             return IDPF_PTP_DIRECT;
> +     else if (adapter->ptp->caps & mailbox)
> +             return IDPF_PTP_MAILBOX;
> +     else
> +             return IDPF_PTP_NONE;
> +}
> +
> +/**
> + * idpf_ptp_get_features_access - Determine the access type of PTP featu=
res
> + * @adapter: Driver specific private structure
> + *
> + * Fulfill the adapter structure with type of the supported PTP features
> + * access.
> + */
> +static void idpf_ptp_get_features_access(const struct idpf_adapter *adap=
ter)
> +{
> +     struct idpf_ptp *ptp =3D adapter->ptp;
> +     u32 direct, mailbox;
> +
> +     /* Get the device clock time */
> +     direct =3D VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME;
> +     mailbox =3D VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB;
> +     ptp->get_dev_clk_time_access =3D (uint8_t)idpf_ptp_get_access(adapt=
er,
> +                                                      direct,
> +                                                      mailbox);
> +
> +     /* Get the cross timestamp */
> +     direct =3D VIRTCHNL2_CAP_PTP_GET_CROSS_TIME;
> +     mailbox =3D VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB;
> +     ptp->get_cross_tstamp_access =3D (uint8_t)idpf_ptp_get_access(adapt=
er,
> +                                                      direct,
> +                                                      mailbox);
> +
> +     /* Set the device clock time */
> +     direct =3D VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
> +     mailbox =3D VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB;
> +     ptp->set_dev_clk_time_access =3D (uint8_t)idpf_ptp_get_access(adapt=
er,
> +                                                      direct,
> +                                                      mailbox);
> +
> +     /* Adjust the device clock time */
> +     direct =3D VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK;
> +     mailbox =3D VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB;
> +     ptp->adj_dev_clk_time_access =3D (uint8_t)idpf_ptp_get_access(adapt=
er,
> +                                                      direct,
> +                                                      mailbox);
> +
> +     /* Tx timestamping */
> +     direct =3D VIRTCHNL2_CAP_PTP_TX_TSTAMPS;
> +     mailbox =3D VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB;
> +     ptp->tx_tstamp_access =3D (uint8_t)idpf_ptp_get_access(adapter,
> +                                                      direct,
> +                                                      mailbox);
> +}

This function could be much shorter if you just removed the variables "dire=
ct"
and "mailbox". Rather than doing

        direct =3D VIRTCHNL2_CAP_PTP_TX_TSTAMPS;
        mailbox =3D VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB;
        ptp->tx_tstamp_access =3D (uint8_t)idpf_ptp_get_access(adapter,
                                                         direct,
                                                         mailbox);

You can shorten the 5 lines down to 3 as:

        ptp->tx_tstamp_access =3D idpf_ptp_get_access(adapter,
                        VIRTCHNL2_CAP_PTP_TX_TSTAMPS,
                        VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB);

Furthermore, since all the defines used for mailbox are the same as those
used for direct, except for an _MB suffix, you could use a macro to shorten
thngs further if you want - maybe even fit each assignment on  one line.
For example (untested, and also shortening adapter to ad to fit one line):

#define IDPF_PTP_ACCESS(a, d) (uint8_t)idpf_ptp_get_access(a, d, d##_MB)

static void
idpf_ptp_get_features_access(const struct idpf_adapter *ad)
{
        struct idpf_ptp *ptp =3D ad->ptp;

        ptp->get_dev_clk_time_access =3D IDPF_PTP_ACCESS(ad, VIRTCHNL2_CAP_=
PTP_GET_DEVICE_CLK_TIME);
        ptp->get_cross_tstamp_access =3D IDPF_PTP_ACCESS(ad, VIRTCHNL2_CAP_=
PTP_GET_CROSS_TIME);
        ptp->set_dev_clk_time_access =3D IDPF_PTP_ACCESS(ad, VIRTCHNL2_CAP_=
PTP_SET_DEVICE_CLK_TIME);
        ptp->adj_dev_clk_time_access =3D IDPF_PTP_ACCESS(ad, VIRTCHNL2_CAP_=
PTP_ADJ_DEVICE_CLK);
        ptp->tx_stamp_access =3D IDPF_PTP_ACCESS(ad, VIRTCHNL2_CAP_PTP_TX_T=
STAMPS);
}

Much shorter! :-)


> +/**
> + * idpf_ptp_get_caps - Send virtchnl get ptp capabilities message
> + * @adapter: Driver specific private structure
> + *
> + * Send virtchnl get PTP capabilities message.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int idpf_ptp_get_caps(struct idpf_adapter *adapter)
> +{
> +     struct virtchnl2_ptp_cross_time_reg_offsets cross_tstamp_offsets;
> +     struct virtchnl2_ptp_clk_adj_reg_offsets clk_adj_offsets;
> +     struct virtchnl2_ptp_get_caps send_ptp_caps_msg =3D { };

Using {} is a GNU extension to C11, so its best to use {0} as initializer.

> +     struct virtchnl2_ptp_clk_reg_offsets clock_offsets;
> +     struct virtchnl2_ptp_get_caps *recv_ptp_caps_msg;
> +     struct idpf_cmd_info args =3D { };
> +     struct idpf_ptp_secondary_mbx *scnd_mbx;
> +     struct idpf_ptp *ptp =3D adapter->ptp;
> +     struct idpf_hw *hw =3D &adapter->hw;
> +     enum idpf_ptp_access access_type;
> +     int err;
> +     u32 temp_offset;
> +
> +     send_ptp_caps_msg.caps =3D CPU_TO_LE32(VIRTCHNL2_CAP_PTP_GET_DEVICE=
_CLK_TIME |
> +                                          VIRTCHNL2_CAP_PTP_GET_DEVICE_C=
LK_TIME_MB |
> +                                          VIRTCHNL2_CAP_PTP_GET_CROSS_TI=
ME |
> +                                          VIRTCHNL2_CAP_PTP_GET_CROSS_TI=
ME_MB |
> +                                          VIRTCHNL2_CAP_PTP_SET_DEVICE_C=
LK_TIME |
> +                                          VIRTCHNL2_CAP_PTP_SET_DEVICE_C=
LK_TIME_MB |
> +                                          VIRTCHNL2_CAP_PTP_ADJ_DEVICE_C=
LK |
> +                                          VIRTCHNL2_CAP_PTP_ADJ_DEVICE_C=
LK_MB |
> +                                          VIRTCHNL2_CAP_PTP_TX_TSTAMPS |
> +                                          VIRTCHNL2_CAP_PTP_TX_TSTAMPS_M=
B);
> +
> +     args.ops =3D VIRTCHNL2_OP_PTP_GET_CAPS;
> +     args.in_args =3D (uint8_t *)&send_ptp_caps_msg;
> +     args.in_args_size =3D sizeof(send_ptp_caps_msg);
> +
> +     args.out_buffer =3D adapter->mbx_resp;
> +     args.out_size =3D sizeof(*recv_ptp_caps_msg);
> +
> +     err =3D idpf_vc_cmd_execute(adapter, &args);
> +     if (err < 0)
> +             return err;
> +
> +     recv_ptp_caps_msg =3D (struct virtchnl2_ptp_get_caps *)args.out_buf=
fer;
> +     ptp->caps =3D LE32_TO_CPU(recv_ptp_caps_msg->caps);
> +     ptp->base_incval =3D LE64_TO_CPU(recv_ptp_caps_msg->base_incval);
> +     ptp->max_adj =3D LE32_TO_CPU(recv_ptp_caps_msg->max_adj);
> +
> +     scnd_mbx =3D &ptp->secondary_mbx;
> +     scnd_mbx->peer_mbx_q_id =3D LE16_TO_CPU(recv_ptp_caps_msg->peer_mbx=
_q_id);
> +
> +     /* if the ptp_mb_q_id holds invalid value (0xffff), the secondary
> +      * mailbox is not supported.
> +      */
> +     scnd_mbx->valid =3D scnd_mbx->peer_mbx_q_id !=3D 0xffff;
> +     if (scnd_mbx->valid)
> +             scnd_mbx->peer_id =3D recv_ptp_caps_msg->peer_id;
> +
> +     /* Determine the access type for the PTP features */
> +     idpf_ptp_get_features_access(adapter);
> +
> +     access_type =3D (enum idpf_ptp_access)ptp->get_dev_clk_time_access;
> +     if (access_type !=3D IDPF_PTP_DIRECT)
> +             goto cross_tstamp;
> +
> +     clock_offsets =3D recv_ptp_caps_msg->clk_offsets;
> +
> +     temp_offset =3D LE32_TO_CPU(clock_offsets.dev_clk_ns_l);
> +     ptp->dev_clk_regs.dev_clk_ns_l =3D IDPF_PCI_REG_ADDR(hw,
> +                                                        temp_offset);

No need to wrap these lines. Use the full 100 chars.
(Also, when wrapping, double tab indent is sufficient, no need to put in 7
tabs + spaces to try and align braces in cases like this)

> +     temp_offset =3D LE32_TO_CPU(clock_offsets.dev_clk_ns_h);
> +     ptp->dev_clk_regs.dev_clk_ns_h =3D IDPF_PCI_REG_ADDR(hw,
> +                                                        temp_offset);
> +     temp_offset =3D LE32_TO_CPU(clock_offsets.phy_clk_ns_l);
> +     ptp->dev_clk_regs.phy_clk_ns_l =3D IDPF_PCI_REG_ADDR(hw,
> +                               temp_offset);
> +     temp_offset =3D LE32_TO_CPU(clock_offsets.phy_clk_ns_h);
> +     ptp->dev_clk_regs.phy_clk_ns_h =3D IDPF_PCI_REG_ADDR(hw,
> +                               temp_offset);
> +     temp_offset =3D LE32_TO_CPU(clock_offsets.cmd_sync_trigger);
> +     ptp->dev_clk_regs.cmd_sync =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
> +
> +cross_tstamp:
> +     access_type =3D (enum idpf_ptp_access)ptp->get_cross_tstamp_access;
> +     if (access_type !=3D IDPF_PTP_DIRECT)
> +             goto discipline_clock;
> +
> +     cross_tstamp_offsets =3D recv_ptp_caps_msg->cross_time_offsets;
> +
> +     temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.sys_time_ns_l);
> +     ptp->dev_clk_regs.sys_time_ns_l =3D IDPF_PCI_REG_ADDR(hw,
> +                                     temp_offset);

Again, don't wrap. Also, this indentation used neither is a simple
double-indent, nor does it align to brace so please use one style
consistently.

> +     temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.sys_time_ns_h);
> +     ptp->dev_clk_regs.sys_time_ns_h =3D IDPF_PCI_REG_ADDR(hw,
> +                                     temp_offset);
> +     temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.cmd_sync_trigger);
> +     ptp->dev_clk_regs.cmd_sync =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
> +
> +discipline_clock:
> +     access_type =3D (enum idpf_ptp_access)ptp->adj_dev_clk_time_access;
> +     if (access_type !=3D IDPF_PTP_DIRECT)
> +             return err;
> +
> +     clk_adj_offsets =3D recv_ptp_caps_msg->clk_adj_offsets;
> +
> +     /* Device clock offsets */
> +     temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_cmd_type);
> +     ptp->dev_clk_regs.cmd =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
> +     temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_l);
> +     ptp->dev_clk_regs.incval_l =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
> +     temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_h);
> +     ptp->dev_clk_regs.incval_h =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
> +     temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_l);
> +     ptp->dev_clk_regs.shadj_l =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
> +     temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_h);
> +     ptp->dev_clk_regs.shadj_h =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
> +
> +     /* PHY clock offsets */
> +     temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_cmd_type);
> +     ptp->dev_clk_regs.phy_cmd =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
> +     temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_l);
> +     ptp->dev_clk_regs.phy_incval_l =3D IDPF_PCI_REG_ADDR(hw,
> +                               temp_offset);
> +     temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_h);
> +     ptp->dev_clk_regs.phy_incval_h =3D IDPF_PCI_REG_ADDR(hw,
> +                               temp_offset);
> +     temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_l);
> +     ptp->dev_clk_regs.phy_shadj_l =3D IDPF_PCI_REG_ADDR(hw, temp_offset=
);
> +     temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_h);
> +     ptp->dev_clk_regs.phy_shadj_h =3D IDPF_PCI_REG_ADDR(hw, temp_offset=
);
> +
> +     return err;
> +}
> +
> +/**
> + * idpf_ptp_enable_shtime - Enable shadow time and execute a command
> + * @adapter: Driver specific private structure
> + */
> +static void idpf_ptp_enable_shtime(struct idpf_adapter *adapter)
> +{
> +     uint32_t shtime_enable, exec_cmd;
> +
> +     /* Get offsets */
> +     shtime_enable =3D adapter->ptp->cmd.shtime_enable_mask;
> +     exec_cmd =3D adapter->ptp->cmd.exec_cmd_mask;
> +
> +     /* Set the shtime en and the sync field */
> +     IDPF_PCI_REG_WRITE(adapter->ptp->dev_clk_regs.cmd_sync, shtime_enab=
le);
> +     IDPF_PCI_REG_WRITE(adapter->ptp->dev_clk_regs.cmd_sync, exec_cmd | =
shtime_enable);
> +}
> +
> +/**
> + * idpf_ptp_get_dev_clk_time - Send virtchnl get device clk time message
> + * @adapter: Driver specific private structure
> + * @dev_clk_time: Pointer to the device clock structure where the value =
is set
> + *
> + * Send virtchnl get time message to get the time of the clock.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
> +                           struct idpf_ptp_dev_timers *dev_clk_time)
> +{
> +     struct virtchnl2_ptp_get_dev_clk_time get_dev_clk_time_msg =3D { };
> +     struct idpf_cmd_info args =3D { };

As above, use {0} as initializer.

> +     int err;
> +     u64 dev_time;
> +
> +     args.ops =3D VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME;
> +     args.in_args =3D (uint8_t *)&get_dev_clk_time_msg;
> +     args.in_args_size =3D sizeof(get_dev_clk_time_msg);
> +     args.out_buffer =3D adapter->mbx_resp;
> +     args.out_size =3D sizeof(get_dev_clk_time_msg);
> +
> +     err =3D idpf_vc_cmd_execute(adapter, &args);
> +     if (err < 0)
> +             return err;
> +
> +     get_dev_clk_time_msg =3D *(struct virtchnl2_ptp_get_dev_clk_time *)=
args.out_buffer;
> +     dev_time =3D LE64_TO_CPU(get_dev_clk_time_msg.dev_time_ns);
> +     dev_clk_time->dev_clk_time_ns =3D dev_time;
> +
> +     return err;
> +}
> +
> +/**
> + * idpf_ptp_get_cross_time - Send virtchnl get cross time message
> + * @adapter: Driver specific private structure
> + * @cross_time: Pointer to the device clock structure where the value is=
 set
> + *
> + * Send virtchnl get cross time message to get the time of the clock and=
 the
> + * system time.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
> +                         struct idpf_ptp_dev_timers *cross_time)
> +{
> +     struct virtchnl2_ptp_get_cross_time cross_time_msg =3D { };
> +     struct idpf_cmd_info args =3D { };
> +     int err;
> +
> +     args.ops =3D VIRTCHNL2_OP_PTP_GET_CROSS_TIME;
> +     args.in_args =3D (uint8_t *)&cross_time_msg;
> +     args.in_args_size =3D sizeof(cross_time_msg);
> +     args.out_buffer =3D adapter->mbx_resp;
> +     args.out_size =3D sizeof(cross_time_msg);
> +
> +     err =3D idpf_vc_cmd_execute(adapter, &args);
> +     if (err < 0)
> +             return err;
> +
> +     cross_time_msg =3D *(struct virtchnl2_ptp_get_cross_time *)args.out=
_buffer;
> +     cross_time->dev_clk_time_ns =3D LE64_TO_CPU(cross_time_msg.dev_time=
_ns);
> +     cross_time->sys_time_ns =3D LE64_TO_CPU(cross_time_msg.sys_time_ns)=
;
> +
> +     return err;
> +}
> +
> +/**
> + * idpf_ptp_set_dev_clk_time - Send virtchnl set device time message
> + * @adapter: Driver specific private structure
> + * @time: New time value
> + *
> + * Send virtchnl set time message to set the time of the clock.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time)
> +{
> +     struct virtchnl2_ptp_set_dev_clk_time set_dev_clk_time_msg =3D { };
> +     struct idpf_cmd_info args =3D { };
> +     int err;
> +
> +     set_dev_clk_time_msg.dev_time_ns =3D CPU_TO_LE64(time);
> +
> +     args.ops =3D VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME;
> +     args.in_args =3D (uint8_t *)&set_dev_clk_time_msg;
> +     args.in_args_size =3D sizeof(set_dev_clk_time_msg);
> +     args.out_buffer =3D adapter->mbx_resp;
> +     args.out_size =3D sizeof(set_dev_clk_time_msg);
> +
> +     err =3D idpf_vc_cmd_execute(adapter, &args);
> +     if (err < 0)
> +             return err;
> +
> +     return err;
> +}
> +
> +/**
> + * idpf_ptp_adj_dev_clk_time - Send virtchnl adj device clock time messa=
ge
> + * @adapter: Driver specific private structure
> + * @delta: Offset in nanoseconds to adjust the time by
> + *
> + * Send virtchnl adj time message to adjust the clock by the indicated d=
elta.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t delt=
a)
> +{
> +     struct virtchnl2_ptp_adj_dev_clk_time adj_dev_clk_time_msg =3D { };
> +     struct idpf_cmd_info args =3D { };
> +     int err;
> +
> +     adj_dev_clk_time_msg.delta =3D CPU_TO_LE64(delta);
> +
> +     args.ops =3D VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME;
> +     args.in_args =3D (uint8_t *)&adj_dev_clk_time_msg;
> +     args.in_args_size =3D sizeof(adj_dev_clk_time_msg);
> +     args.out_buffer =3D adapter->mbx_resp;
> +     args.out_size =3D sizeof(adj_dev_clk_time_msg);
> +
> +     err =3D idpf_vc_cmd_execute(adapter, &args);
> +     if (err < 0)
> +             return err;
> +
> +     return err;
> +}
> +
> +/**
> + * idpf_ptp_adj_dev_clk_fine - Send virtchnl adj time message
> + * @adapter: Driver specific private structure
> + * @incval: Source timer increment value per clock cycle
> + *
> + * Send virtchnl adj fine message to adjust the frequency of the clock b=
y
> + * incval.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval)
> +{
> +     struct virtchnl2_ptp_adj_dev_clk_fine adj_dev_clk_fine_msg =3D { };
> +     struct idpf_cmd_info args =3D { };
> +     int err;
> +
> +     adj_dev_clk_fine_msg.incval =3D CPU_TO_LE64(incval);
> +
> +     args.ops =3D VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE;
> +     args.in_args =3D (uint8_t *)&adj_dev_clk_fine_msg;
> +     args.in_args_size =3D sizeof(adj_dev_clk_fine_msg);
> +     args.out_buffer =3D adapter->mbx_resp;
> +     args.out_size =3D sizeof(adj_dev_clk_fine_msg);
> +
> +     err =3D idpf_vc_cmd_execute(adapter, &args);
> +     if (err < 0)
> +             return err;
> +
> +     return err;
> +}
> +
> +/**
> + * idpf_ptp_get_vport_tstamps_caps - Send virtchnl to get tstamps caps f=
or vport
> + * @vport: Virtual port structure
> + *
> + * Send virtchnl get vport tstamps caps message to receive the set of ts=
tamp
> + * capabilities per vport.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
> +{
> +     struct virtchnl2_ptp_get_vport_tx_tstamp_caps send_tx_tstamp_caps =
=3D { };
> +     struct virtchnl2_ptp_get_vport_tx_tstamp_caps *rcv_tx_tstamp_caps;
> +     struct virtchnl2_ptp_tx_tstamp_latch_caps tx_tstamp_latch_caps;
> +     enum idpf_ptp_access tstamp_access, get_dev_clk_access;
> +     struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
> +     struct idpf_ptp *ptp =3D vport->adapter->ptp;
> +     struct idpf_cmd_info args =3D { };
> +     int err;
> +     u16 num_latches, i;
> +     u32 size;
> +
> +     if (ptp =3D=3D NULL)
> +             return -EOPNOTSUPP;
> +
> +     tstamp_access =3D (enum idpf_ptp_access)ptp->tx_tstamp_access;
> +     get_dev_clk_access =3D (enum idpf_ptp_access)ptp->get_dev_clk_time_=
access;
> +     if (tstamp_access =3D=3D IDPF_PTP_NONE ||
> +         get_dev_clk_access =3D=3D IDPF_PTP_NONE)
> +             return -EOPNOTSUPP;
> +
> +     send_tx_tstamp_caps.vport_id =3D CPU_TO_LE32(vport->vport_id);
> +
> +     args.ops =3D VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS;
> +     args.in_args =3D (uint8_t *)&send_tx_tstamp_caps;
> +     args.in_args_size =3D sizeof(send_tx_tstamp_caps);
> +     args.out_size =3D IDPF_CTLQ_MAX_BUF_LEN;
> +     args.out_buffer =3D vport->adapter->mbx_resp;
> +
> +     err =3D idpf_vc_cmd_execute(vport->adapter, &args);
> +     if (err < 0)
> +             return err;
> +
> +     rcv_tx_tstamp_caps =3D (struct virtchnl2_ptp_get_vport_tx_tstamp_ca=
ps *)
> +                          args.out_buffer;
> +     num_latches =3D LE16_TO_CPU(rcv_tx_tstamp_caps->num_latches);
> +     size =3D sizeof(struct idpf_ptp_vport_tx_tstamp_caps) +
> +            sizeof(struct idpf_ptp_tx_tstamp) * num_latches;
> +     tstamp_caps =3D rte_zmalloc(NULL, size, 0);
> +     if (tstamp_caps =3D=3D NULL)
> +             return -ENOMEM;
> +
> +     tstamp_caps->access =3D true;
> +     tstamp_caps->num_entries =3D num_latches;
> +
> +     tstamp_caps->tstamp_ns_lo_bit =3D rcv_tx_tstamp_caps->tstamp_ns_lo_=
bit;
> +
> +     for (i =3D 0; i < tstamp_caps->num_entries; i++) {
> +             __le32 offset_l, offset_h;
> +
> +             tx_tstamp_latch_caps =3D rcv_tx_tstamp_caps->tstamp_latches=
[i];
> +
> +             if (tstamp_access =3D=3D IDPF_PTP_DIRECT) {
> +                     offset_l =3D tx_tstamp_latch_caps.tx_latch_reg_offs=
et_l;
> +                     offset_h =3D tx_tstamp_latch_caps.tx_latch_reg_offs=
et_h;
> +                     tstamp_caps->tx_tstamp[i].tx_latch_reg_offset_l =3D=
 LE32_TO_CPU(offset_l);
> +                     tstamp_caps->tx_tstamp[i].tx_latch_reg_offset_h =3D=
 LE32_TO_CPU(offset_h);
> +             }
> +             tstamp_caps->tx_tstamp[i].idx =3D tx_tstamp_latch_caps.inde=
x;
> +     }
> +
> +     tstamp_caps->latched_idx =3D -1;
> +     vport->tx_tstamp_caps =3D tstamp_caps;
> +
> +     return err;
> +}
> +
> +/**
> + * idpf_ptp_get_tstamp_value - Get the Tx timestamp value and provide it
> + *                          back to the skb.
> + * @vport: Virtual port structure
> + * @tstamp_latch: Tx timestamp latch structure fulfilled by the Control =
Plane
> + * @tx_tstamp: Tx timestamp structure to be fulfilled with the timestamp=
 value
> + *
> + * Read the value of the Tx timestamp for a given latch received from th=
e
> + * Control Plane.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int
> +idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
> +                       struct virtchnl2_ptp_tx_tstamp_latch *tstamp_latc=
h,
> +                       struct idpf_ptp_tx_tstamp *tx_tstamp)
> +{
> +     struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
> +     u8 tstamp_ns_lo_bit;
> +
> +     tx_tstamp_caps =3D vport->tx_tstamp_caps;
> +     tstamp_ns_lo_bit =3D tx_tstamp_caps->tstamp_ns_lo_bit;
> +
> +     tx_tstamp->tstamp =3D LE64_TO_CPU(tstamp_latch->tstamp);
> +     tx_tstamp->tstamp >>=3D tstamp_ns_lo_bit;
> +
> +     return 0;
> +}
> +
> +/**
> + * idpf_ptp_get_tx_tstamp - Send virtchnl get Tx timestamp latches messa=
ge
> + * @vport: Virtual port structure
> + *
> + * Send virtchnl get Tx tstamp message to read the value of the HW times=
tamp.
> + * The message contains a list of indexes set in the Tx descriptors.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport)
> +{
> +     struct virtchnl2_ptp_get_vport_tx_tstamp_latches *send_tx_tstamp_ms=
g;
> +     struct virtchnl2_ptp_get_vport_tx_tstamp_latches *recv_tx_tstamp_ms=
g;
> +     struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
> +     struct virtchnl2_ptp_tx_tstamp_latch tstamp_latch;
> +     struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;
> +     struct idpf_cmd_info args =3D { };
> +     int size, msg_size;
> +     u32 vport_id;
> +     u16 num_latches, id;
> +     int err;
> +
> +     tx_tstamp_caps =3D vport->tx_tstamp_caps;
> +     ptp_tx_tstamp =3D tx_tstamp_caps->tx_tstamp;
> +
> +     size =3D sizeof(struct virtchnl2_ptp_get_vport_tx_tstamp_latches) +
> +           sizeof(struct virtchnl2_ptp_tx_tstamp_latch) *
> +           tx_tstamp_caps->num_entries;
> +     send_tx_tstamp_msg =3D rte_zmalloc(NULL, size, 0);
> +     if (send_tx_tstamp_msg =3D=3D NULL)
> +             return -ENOMEM;
> +
> +     for (id =3D 0; id < tx_tstamp_caps->num_entries; id++,
> +             ptp_tx_tstamp++)
> +             send_tx_tstamp_msg->tstamp_latches[id].index =3D
> +                                                                        =
     ptp_tx_tstamp->idx;

Identation in this loop badly needs to be reworked.

> +     send_tx_tstamp_msg->get_devtime_with_txtstmp =3D 1;
> +
> +     msg_size =3D sizeof(struct virtchnl2_ptp_get_vport_tx_tstamp_latche=
s) +
> +                sizeof(struct virtchnl2_ptp_tx_tstamp_latch) * id;
> +     send_tx_tstamp_msg->vport_id =3D CPU_TO_LE32(vport->vport_id);
> +     send_tx_tstamp_msg->num_latches =3D CPU_TO_LE16(id);
> +
> +     args.ops =3D VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP;
> +     args.in_args =3D (uint8_t *)send_tx_tstamp_msg;
> +     args.in_args_size =3D msg_size;
> +     args.out_size =3D msg_size;
> +     args.out_buffer =3D vport->adapter->mbx_resp;
> +
> +     err =3D idpf_vc_cmd_execute(vport->adapter, &args);
> +     rte_free(send_tx_tstamp_msg);
> +     if (err < 0)
> +             return err;
> +
> +     recv_tx_tstamp_msg =3D (struct virtchnl2_ptp_get_vport_tx_tstamp_la=
tches *)
> +                          args.out_buffer;
> +     vport_id =3D LE32_TO_CPU(recv_tx_tstamp_msg->vport_id);
> +     if (vport->vport_id !=3D vport_id)
> +             return -EINVAL;
> +
> +     num_latches =3D LE16_TO_CPU(recv_tx_tstamp_msg->num_latches);
> +
> +     ptp_tx_tstamp =3D tx_tstamp_caps->tx_tstamp;
> +     for (id =3D 0; id < num_latches; id++, ptp_tx_tstamp++) {
> +             tstamp_latch =3D recv_tx_tstamp_msg->tstamp_latches[id];
> +
> +             if (!tstamp_latch.valid)
> +                     continue;
> +
> +             err =3D idpf_ptp_get_tstamp_value(vport, &tstamp_latch,
> +                                             ptp_tx_tstamp);
> +             if (err =3D=3D 0) {
> +                     tx_tstamp_caps->latched_idx =3D id;
> +                     vport->adapter->time_hw =3D recv_tx_tstamp_msg->dev=
ice_time;
> +             }
> +             break;
> +     }
> +     return err;
> +}
> +
> +/**
> + * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer value
> + * @adapter: Driver specific private structure
> + *
> + * Return: the device clock time.
> + */
> +static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter=
)
> +{
> +     struct idpf_ptp *ptp =3D adapter->ptp;
> +     u32 hi, lo;
> +
> +     idpf_ptp_enable_shtime(adapter);
> +
> +     lo =3D IDPF_PCI_REG(ptp->dev_clk_regs.dev_clk_ns_l);
> +     hi =3D IDPF_PCI_REG(ptp->dev_clk_regs.dev_clk_ns_h);
> +
> +     return ((u64)hi << 32) | lo;
> +}
> +
> +/**
> + * idpf_ptp_read_src_clk_reg_mailbox - Read the main timer value through=
 mailbox
> + * @adapter: Driver specific private structure
> + * @src_clk: Returned main timer value in nanoseconds unit
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int idpf_ptp_read_src_clk_reg_mailbox(struct idpf_adapter *adapte=
r,
> +                                          u64 *src_clk)
> +{
> +     struct idpf_ptp_dev_timers clk_time;
> +     int err;
> +
> +     err =3D idpf_ptp_get_dev_clk_time(adapter, &clk_time);
> +     if (err)
> +             return err;
> +
> +     *src_clk =3D clk_time.dev_clk_time_ns;
> +
> +     return 0;
> +}
> +
> +/**
> + * idpf_ptp_read_src_clk_reg - Read the main timer value
> + * @adapter: Driver specific private structure
> + * @src_clk: Returned main timer value in nanoseconds unit
> + *
> + * Return: the device clock time on success, -errno otherwise.
> + */
> +int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, u64 *src_clk=
)
> +{
> +     if (adapter->ptp =3D=3D NULL)
> +             return 0;

Should this not be an error, returning -EINVAL?

> +     switch ((enum idpf_ptp_access)adapter->ptp->get_dev_clk_time_access=
) {
> +     case IDPF_PTP_NONE:
> +             return -EOPNOTSUPP;

Strictly speaking, you don't need this, it's handled by the default case.

> +     case IDPF_PTP_MAILBOX:
> +             return idpf_ptp_read_src_clk_reg_mailbox(adapter, src_clk);
> +     case IDPF_PTP_DIRECT:
> +             *src_clk =3D idpf_ptp_read_src_clk_reg_direct(adapter);
> +             break;

Why have the function types for direct and mailbox different? Why not have
both just take src_clk as parameter and return 0 on success, so you can
have similar use of them. It would also possibly allow function pointer use
in future, if they are the same types.

> +     default:
> +             return -EOPNOTSUPP;
> +     }
> +
> +     return 0;
> +}
> diff --git a/drivers/net/intel/idpf/idpf_ptp.h b/drivers/net/intel/idpf/i=
dpf_ptp.h
> new file mode 100644
> index 0000000000..68ac66ae91
> --- /dev/null
> +++ b/drivers/net/intel/idpf/idpf_ptp.h
> @@ -0,0 +1,227 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Intel Corporation
> + */
> +
> +#ifndef _IDPF_PTP_H_
> +#define _IDPF_PTP_H_
> +
> +#include "idpf_osdep.h"
> +#include <rte_time.h>
> +#include "idpf_common_device.h"
> +
> +/**
> + * @struct idpf_ptp_cmd - PTP command masks
> + * @exec_cmd_mask: mask to trigger command execution
> + * @shtime_enable_mask: mask to enable shadow time
> + */
> +struct idpf_ptp_cmd {
> +     uint32_t exec_cmd_mask;
> +     uint32_t shtime_enable_mask;
> +};
> +
> +/* @struct idpf_ptp_dev_clk_regs - PTP device registers
> + * @dev_clk_ns_l: low part of the device clock register
> + * @dev_clk_ns_h: high part of the device clock register
> + * @phy_clk_ns_l: low part of the PHY clock register
> + * @phy_clk_ns_h: high part of the PHY clock register
> + * @sys_time_ns_l: low part of the system time register
> + * @sys_time_ns_h: high part of the system time register
> + * @incval_l: low part of the increment value register
> + * @incval_h: high part of the increment value register
> + * @shadj_l: low part of the shadow adjust register
> + * @shadj_h: high part of the shadow adjust register
> + * phy_incval_l: low part of the PHY increment value register
> + * phy_incval_h: high part of the PHY increment value register
> + * phy_shadj_l: low part of the PHY shadow adjust register
> + * phy_shadj_h: high part of the PHY shadow adjust register
> + * @cmd: PTP command register
> + * @phy_cmd: PHY command register
> + * @cmd_sync: PTP command synchronization register
> + */
> +struct idpf_ptp_dev_clk_regs {
> +     /* Main clock */
> +     volatile uint32_t *dev_clk_ns_l;
> +     volatile uint32_t *dev_clk_ns_h;
> +
> +     /* PHY timer */
> +     volatile uint32_t *phy_clk_ns_l;
> +     volatile uint32_t *phy_clk_ns_h;
> +
> +     /* System time */
> +     volatile uint32_t *sys_time_ns_l;
> +     volatile uint32_t *sys_time_ns_h;
> +
> +     /* Main timer adjustments */
> +     volatile uint32_t *incval_l;
> +     volatile uint32_t *incval_h;
> +     volatile uint32_t *shadj_l;
> +     volatile uint32_t *shadj_h;
> +
> +     /* PHY timer adjustments */
> +     volatile uint32_t *phy_incval_l;
> +     volatile uint32_t *phy_incval_h;
> +     volatile uint32_t *phy_shadj_l;
> +     volatile uint32_t *phy_shadj_h;
> +
> +     /* Command */
> +     volatile uint32_t *cmd;
> +     volatile uint32_t *phy_cmd;
> +     volatile uint32_t *cmd_sync;
> +};
> +
> +/**
> + * @enum idpf_ptp_access - the type of access to PTP operations
> + * @IDPF_PTP_NONE: no access
> + * @IDPF_PTP_DIRECT: direct access through BAR registers
> + * @IDPF_PTP_MAILBOX: access through mailbox messages
> + */
> +enum idpf_ptp_access {
> +     IDPF_PTP_NONE =3D 0,
> +     IDPF_PTP_DIRECT,
> +     IDPF_PTP_MAILBOX,
> +};
> +
> +/**
> + * @struct idpf_ptp_secondary_mbx - PTP secondary mailbox
> + * @peer_mbx_q_id: PTP mailbox queue ID
> + * @peer_id: Peer ID for PTP Device Control daemon
> + * @valid: indicates whether secondary mailblox is supported by the Cont=
rol
> + *      Plane
> + */
> +struct idpf_ptp_secondary_mbx {
> +     uint16_t peer_mbx_q_id;
> +     uint16_t peer_id;
> +     bool valid:1;
> +};
> +
> +/**
> + * @enum idpf_ptp_tx_tstamp_state - Tx timestamp states
> + * @IDPF_PTP_FREE: Tx timestamp index free to use
> + * @IDPF_PTP_REQUEST: Tx timestamp index set to the Tx descriptor
> + * @IDPF_PTP_READ_VALUE: Tx timestamp value ready to be read
> + */
> +enum idpf_ptp_tx_tstamp_state {
> +     IDPF_PTP_FREE,
> +     IDPF_PTP_REQUEST,
> +     IDPF_PTP_READ_VALUE,
> +};
> +
> +/**
> + * @struct idpf_ptp_tx_tstamp - Parameters for Tx timestamping
> + * @list_member: the list member structure
> + * @tx_latch_reg_offset_l: Tx tstamp latch low register offset
> + * @tx_latch_reg_offset_h: Tx tstamp latch high register offset
> + * @tstamp: the Tx tstamp value
> + * @idx: the index of the Tx tstamp
> + */
> +struct idpf_ptp_tx_tstamp {
> +     uint64_t tstamp;
> +     uint32_t tx_latch_reg_offset_l;
> +     uint32_t tx_latch_reg_offset_h;
> +     uint32_t idx;
> +};
> +
> +/**
> + * @struct idpf_ptp_vport_tx_tstamp_caps - Tx timestamp capabilities
> + * @vport_id: the vport id
> + * @num_entries: the number of negotiated Tx timestamp entries
> + * @tstamp_ns_lo_bit: first bit for nanosecond part of the timestamp
> + * @access: indicates an access to Tx timestamp
> + * @latches_index: the index  of the latched Tx timestamps
> + * @tx_tstamp: array of Tx timestamp parameters
> + */
> +struct idpf_ptp_vport_tx_tstamp_caps {
> +     uint32_t vport_id;
> +     uint16_t num_entries;
> +     uint16_t tstamp_ns_lo_bit;
> +     uint16_t latched_idx;
> +     bool access:1;
> +     struct idpf_ptp_tx_tstamp tx_tstamp[];
> +};
> +
> +/**
> + * @struct idpf_ptp - PTP parameters
> + * @base_incval: base increment value of the PTP clock
> + * @max_adj: maximum adjustment of the PTP clock
> + * @cmd: HW specific command masks
> + * @dev_clk_regs: the set of registers to access the device clock
> + * @caps: PTP capabilities negotiated with the Control Plane
> + * @get_dev_clk_time_access: access type for getting the device clock ti=
me
> + * @get_cross_tstamp_access: access type for the cross timestamping
> + * @set_dev_clk_time_access: access type for setting the device clock ti=
me
> + * @adj_dev_clk_time_access: access type for the adjusting the device cl=
ock
> + * @tx_tstamp_access: access type for the Tx timestamp value read
> + * @rsv: Reserved fields
> + * @secondary_mbx: parameters for using dedicated PTP mailbox
> + */
> +struct idpf_ptp {
> +     uint64_t base_incval;
> +     uint64_t max_adj;
> +     struct idpf_ptp_cmd cmd;
> +     struct idpf_ptp_dev_clk_regs dev_clk_regs;
> +     uint32_t caps;
> +     uint8_t get_dev_clk_time_access:2;
> +     uint8_t get_cross_tstamp_access:2;
> +     uint8_t set_dev_clk_time_access:2;
> +     uint8_t adj_dev_clk_time_access:2;
> +     uint8_t tx_tstamp_access:2;
> +     uint8_t rsv:6;
> +     struct idpf_ptp_secondary_mbx secondary_mbx;
> +};
> +
> +/**
> + * @struct idpf_ptp_dev_timers - System time and device time values
> + * @sys_time_ns: system time value expressed in nanoseconds
> + * @dev_clk_time_ns: device clock time value expressed in nanoseconds
> + */
> +struct idpf_ptp_dev_timers {
> +     uint64_t sys_time_ns;
> +     uint64_t dev_clk_time_ns;
> +};
> +
> +int idpf_ptp_get_caps(struct idpf_adapter *adapter);
> +int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t *sr=
c_clk);
> +int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
> +                           struct idpf_ptp_dev_timers *dev_clk_time);
> +int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
> +                         struct idpf_ptp_dev_timers *cross_time);
> +int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t tim=
e);
> +int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t inc=
val);
> +int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t delt=
a);
> +int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport);
> +int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport);
> +
> +/* Helper function to convert a 32b nanoseconds timestamp to 64b. */
> +static inline uint64_t
> +idpf_tstamp_convert_32b_64b(struct idpf_adapter *ad, uint32_t flag,
> +                         bool is_rx, uint32_t in_timestamp)
> +{
> +     const uint64_t mask =3D 0xFFFFFFFF;
> +     uint32_t phc_time_lo, delta;
> +     uint64_t ns;
> +
> +     if (flag !=3D 0)
> +             idpf_ptp_read_src_clk_reg(ad, &ad->time_hw);
> +
> +    /* Extract the lower 32 bits of the PHC time */
> +     phc_time_lo =3D (uint32_t)(ad->time_hw);
> +
> +     /* Calculate the delta between the lower 32bits of the cached PHC
> +      * time and the in_timestamp value.
> +      */
> +     delta =3D in_timestamp - phc_time_lo;
> +
> +     if (delta > mask / 2) {
> +             /* Reverse the delta calculation here */
> +             delta =3D phc_time_lo - in_timestamp;
> +             ns =3D ad->time_hw - delta;
> +     } else {
> +             if (is_rx)
> +                     ns =3D ad->time_hw - delta;
> +             else
> +                     ns =3D ad->time_hw + delta;
> +     }
> +
> +     return ns;
> +}
> +#endif /* _IDPF_PTP_H_ */
> diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/=
meson.build
> index a805d02ea2..5a4a3c2259 100644
> --- a/drivers/net/intel/idpf/meson.build
> +++ b/drivers/net/intel/idpf/meson.build
> @@ -18,6 +18,7 @@ sources +=3D files(
>
>          'idpf_ethdev.c',
>          'idpf_rxtx.c',
> +        'idpf_ptp.c',

All lists in DPDK should be in alphabetical order, unless there is a reason
they can't be. Therefore, this new C file should be above idpf_rxtx.c in
the list.

>  )
>
>  if arch_subdir =3D=3D 'x86' and dpdk_conf.get('RTE_IOVA_IN_MBUF') =3D=3D=
 1
> --
> 2.47.1
>

--_000_CY8PR11MB7747A6678C62416C551473B8F96EACY8PR11MB7747namp_
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
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr;">&nbsp;<span style=3D"font-size: 11pt;">On Th=
u, Jan 22, 2026 at 07:04:47PM -0500, Soumyadeep Hore wrote:<br>
&gt; Add a new file - idpf_ptp - to handle PTP virtchnl messages.<br>
&gt; Keep the registers addresses in the PTP struct.<br>
&gt;<br>
&gt; Signed-off-by: Soumyadeep Hore &lt;soumyadeep.hore@intel.com&gt;<br>
&gt; ---<br>
<br>
Some review feedback inline below. See also review feedback from AI review<=
br>
that was posted by Stephen.<br>
<br>
&gt;&nbsp; drivers/net/intel/idpf/idpf_common_device.h&nbsp;&nbsp; |&nbsp;&=
nbsp; 4 +<br>
&gt;&nbsp; drivers/net/intel/idpf/idpf_common_virtchnl.c |&nbsp; 34 +-<br>
&gt;&nbsp; drivers/net/intel/idpf/idpf_ptp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 639 ++++++++++++++++++<br>
&gt;&nbsp; drivers/net/intel/idpf/idpf_ptp.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 227 +++++++<br>
&gt;&nbsp; drivers/net/intel/idpf/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; 5 files changed, 903 insertions(+), 2 deletions(-)<br>
&gt;&nbsp; create mode 100644 drivers/net/intel/idpf/idpf_ptp.c<br>
&gt;&nbsp; create mode 100644 drivers/net/intel/idpf/idpf_ptp.h<br>
&gt;<br>
&gt; diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net=
/intel/idpf/idpf_common_device.h<br>
&gt; index c32dcfbb12..3c84b96225 100644<br>
&gt; --- a/drivers/net/intel/idpf/idpf_common_device.h<br>
&gt; +++ b/drivers/net/intel/idpf/idpf_common_device.h<br>
&gt; @@ -90,6 +90,7 @@ struct idpf_adapter {<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For timestamp */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t time_hw;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp *ptp;<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum idpf_rx_func_type rx_fu=
nc_type;<br>
&gt;&nbsp; };<br>
&gt; @@ -161,6 +162,9 @@ struct idpf_vport {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Event from ipf */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool link_up;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t link_speed;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* For PTP */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_vport_tx_tstamp_caps *tx_tst=
amp_caps;<br>
&gt;&nbsp; };<br>
&gt;&nbsp;<br>
&gt;&nbsp; /* Message type read in virtual channel from PF */<br>
&gt; diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/n=
et/intel/idpf/idpf_common_virtchnl.c<br>
&gt; index e927d7415a..a28bc9bee6 100644<br>
&gt; --- a/drivers/net/intel/idpf/idpf_common_virtchnl.c<br>
&gt; +++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c<br>
&gt; @@ -4,6 +4,7 @@<br>
&gt;&nbsp;<br>
&gt;&nbsp; #include &quot;idpf_common_virtchnl.h&quot;<br>
&gt;&nbsp; #include &quot;idpf_common_logs.h&quot;<br>
&gt; +#include &quot;idpf_ptp.h&quot;<br>
&gt;&nbsp;<br>
&gt;&nbsp; #include &lt;eal_export.h&gt;<br>
&gt;&nbsp;<br>
&gt; @@ -38,6 +39,28 @@ idpf_vc_clean(struct idpf_adapter *adapter)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
&gt; +/**<br>
&gt; + * idpf_ptp_is_mb_msg - Check if the message is PTP-related<br>
&gt; + * @op: virtchnl opcode<br>
&gt; + *<br>
&gt; + * Returns true if msg is PTP-related, false otherwise<br>
&gt; + */<br>
&gt; +static inline bool idpf_ptp_is_mb_msg(uint32_t op)<br>
&gt; +{<br>
<br>
The name of this function seems backward to me. We are not returning if<br>
it's a mailbox message, we are returning if it's PTP related, no? Therefore=
<br>
would idpf_mb_msg_is_ptp, not be a better name?<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (op) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP:<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_GET_CROSS_TIME:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CA=
PS:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static int<br>
&gt;&nbsp; idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_t op,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t msg_size, uint8_t *msg)<br>
&gt; @@ -71,8 +94,15 @@ idpf_send_vc_msg(struct idpf_adapter *adapter, uint=
32_t op,<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(dma_mem-&gt;va, msg, =
msg_size);<br>
&gt;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ctlq_msg-&gt;opcode =3D idpf_mbq_opc_send_ms=
g_to_pf;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ctlq_msg-&gt;func_id =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (idpf_ptp_is_mb_msg(op) &amp;&amp; adapte=
r-&gt;ptp-&gt;secondary_mbx.valid) {<br>
<br>
If the first of these is true and the second not, is that an error<br>
condition and do we need to handle it?</span></div>
<div style=3D"direction: ltr; font-size: 11pt;"><br>
</div>
<div style=3D"direction: ltr; font-size: 11pt;" class=3D"elementToProof">No=
 by default it should use primary mailbox for error conditions. Actually th=
ose are not error conditions but various cases where primary mail box is us=
ed for negotiation.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ctlq_msg-&gt;opcode =3D idpf_mbq_opc_send_msg_to_peer_drv;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ctlq_msg-&gt;func_id =3D adapter-&gt;ptp-&gt;secondary_mbx.peer_mbx_q_i=
d;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ctlq_msg-&gt;host_id =3D adapter-&gt;ptp-&gt;secondary_mbx.peer_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ctlq_msg-&gt;opcode =3D idpf_mbq_opc_send_msg_to_pf;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ctlq_msg-&gt;func_id =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctlq_msg-&gt;data_len =3D ms=
g_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctlq_msg-&gt;cookie.mbx.chnl=
_opcode =3D op;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctlq_msg-&gt;cookie.mbx.chnl=
_retval =3D VIRTCHNL_STATUS_SUCCESS;<br>
&gt; diff --git a/drivers/net/intel/idpf/idpf_ptp.c b/drivers/net/intel/idp=
f/idpf_ptp.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..b8f6afa518<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/net/intel/idpf/idpf_ptp.c<br>
&gt; @@ -0,0 +1,639 @@<br>
&gt; +/* SPDX-License-Identifier: BSD-3-Clause<br>
&gt; + * Copyright(c) 2025 Intel Corporation<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;idpf_ptp.h&quot;<br>
&gt; +#include &lt;base/virtchnl2.h&gt;<br>
&gt; +#include &quot;idpf_common_virtchnl.h&quot;<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_get_access - Determine the access type of the PTP feature=
s<br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + * @direct: Capability that indicates the direct access<br>
&gt; + * @mailbox: Capability that indicates the mailbox access<br>
&gt; + *<br>
&gt; + * Return: the type of supported access for the PTP feature.<br>
&gt; + */<br>
&gt; +static enum idpf_ptp_access<br>
&gt; +idpf_ptp_get_access(const struct idpf_adapter *adapter, u32 direct, u=
32 mailbox)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adapter-&gt;ptp-&gt;caps &amp; direct)<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return IDPF_PTP_DIRECT;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else if (adapter-&gt;ptp-&gt;caps &amp; mail=
box)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return IDPF_PTP_MAILBOX;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return IDPF_PTP_NONE;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_get_features_access - Determine the access type of PTP fe=
atures<br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + *<br>
&gt; + * Fulfill the adapter structure with type of the supported PTP featu=
res<br>
&gt; + * access.<br>
&gt; + */<br>
&gt; +static void idpf_ptp_get_features_access(const struct idpf_adapter *a=
dapter)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp *ptp =3D adapter-&gt;ptp;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 direct, mailbox;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Get the device clock time */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; direct =3D VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_=
TIME;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mailbox =3D VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK=
_TIME_MB;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;get_dev_clk_time_access =3D (uint8_t=
)idpf_ptp_get_access(adapter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; direct,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mailbox);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Get the cross timestamp */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; direct =3D VIRTCHNL2_CAP_PTP_GET_CROSS_TIME;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mailbox =3D VIRTCHNL2_CAP_PTP_GET_CROSS_TIME=
_MB;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;get_cross_tstamp_access =3D (uint8_t=
)idpf_ptp_get_access(adapter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; direct,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mailbox);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Set the device clock time */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; direct =3D VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_=
TIME;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mailbox =3D VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK=
_TIME_MB;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;set_dev_clk_time_access =3D (uint8_t=
)idpf_ptp_get_access(adapter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; direct,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mailbox);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust the device clock time */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; direct =3D VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mailbox =3D VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK=
_MB;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;adj_dev_clk_time_access =3D (uint8_t=
)idpf_ptp_get_access(adapter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; direct,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mailbox);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Tx timestamping */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; direct =3D VIRTCHNL2_CAP_PTP_TX_TSTAMPS;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mailbox =3D VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;tx_tstamp_access =3D (uint8_t)idpf_p=
tp_get_access(adapter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; direct,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mailbox);<br>
&gt; +}<br>
<br>
This function could be much shorter if you just removed the variables &quot=
;direct&quot;<br>
and &quot;mailbox&quot;. Rather than doing<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; direct =3D VIRTCHNL2_CAP_PTP_TX_=
TSTAMPS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mailbox =3D VIRTCHNL2_CAP_PTP_TX=
_TSTAMPS_MB;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;tx_tstamp_access =3D (ui=
nt8_t)idpf_ptp_get_access(adapter,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; direct,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mailbox);<br>
<br>
You can shorten the 5 lines down to 3 as:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;tx_tstamp_access =3D idp=
f_ptp_get_access(adapter,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTCHNL2_C=
AP_PTP_TX_TSTAMPS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTCHNL2_C=
AP_PTP_TX_TSTAMPS_MB);<br>
<br>
Furthermore, since all the defines used for mailbox are the same as those<b=
r>
used for direct, except for an _MB suffix, you could use a macro to shorten=
<br>
thngs further if you want - maybe even fit each assignment on&nbsp; one lin=
e.<br>
For example (untested, and also shortening adapter to ad to fit one line):<=
br>
<br>
#define IDPF_PTP_ACCESS(a, d) (uint8_t)idpf_ptp_get_access(a, d, d##_MB)<br=
>
<br>
static void<br>
idpf_ptp_get_features_access(const struct idpf_adapter *ad)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp *ptp =3D ad-&gt;=
ptp;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;get_dev_clk_time_access =
=3D IDPF_PTP_ACCESS(ad, VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;get_cross_tstamp_access =
=3D IDPF_PTP_ACCESS(ad, VIRTCHNL2_CAP_PTP_GET_CROSS_TIME);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;set_dev_clk_time_access =
=3D IDPF_PTP_ACCESS(ad, VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;adj_dev_clk_time_access =
=3D IDPF_PTP_ACCESS(ad, VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;tx_stamp_access =3D IDPF=
_PTP_ACCESS(ad, VIRTCHNL2_CAP_PTP_TX_TSTAMPS);<br>
}<br>
<br>
Much shorter! :-)<br>
<br>
<br>
&gt; +/**<br>
&gt; + * idpf_ptp_get_caps - Send virtchnl get ptp capabilities message<br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + *<br>
&gt; + * Send virtchnl get PTP capabilities message.<br>
&gt; + *<br>
&gt; + * Return: 0 on success, -errno on failure.<br>
&gt; + */<br>
&gt; +int idpf_ptp_get_caps(struct idpf_adapter *adapter)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_cross_time_reg_offsets =
cross_tstamp_offsets;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_clk_adj_reg_offsets clk=
_adj_offsets;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_caps send_ptp_caps_=
msg =3D { };<br>
<br>
Using {} is a GNU extension to C11, so its best to use {0} as initializer.<=
br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_clk_reg_offsets clock_o=
ffsets;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_caps *recv_ptp_caps=
_msg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_secondary_mbx *scnd_mbx;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp *ptp =3D adapter-&gt;ptp;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_hw *hw =3D &amp;adapter-&gt;hw;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; enum idpf_ptp_access access_type;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 temp_offset;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; send_ptp_caps_msg.caps =3D CPU_TO_LE32(VIRTC=
HNL2_CAP_PTP_GET_DEVICE_CLK_TIME |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTCHNL2_CAP_PTP_GET_CROSS_TIME |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTCHNL2_CAP_PTP_TX_TSTAMPS |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_GET_CAPS;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;send_ptp_ca=
ps_msg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(send_ptp_caps_m=
sg);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_resp;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(*recv_ptp_caps_msg)=
;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, &amp;ar=
gs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; recv_ptp_caps_msg =3D (struct virtchnl2_ptp_=
get_caps *)args.out_buffer;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;caps =3D LE32_TO_CPU(recv_ptp_caps_m=
sg-&gt;caps);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;base_incval =3D LE64_TO_CPU(recv_ptp=
_caps_msg-&gt;base_incval);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;max_adj =3D LE32_TO_CPU(recv_ptp_cap=
s_msg-&gt;max_adj);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scnd_mbx =3D &amp;ptp-&gt;secondary_mbx;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scnd_mbx-&gt;peer_mbx_q_id =3D LE16_TO_CPU(r=
ecv_ptp_caps_msg-&gt;peer_mbx_q_id);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* if the ptp_mb_q_id holds invalid value (0=
xffff), the secondary<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mailbox is not supported.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; scnd_mbx-&gt;valid =3D scnd_mbx-&gt;peer_mbx=
_q_id !=3D 0xffff;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (scnd_mbx-&gt;valid)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; scnd_mbx-&gt;peer_id =3D recv_ptp_caps_msg-&gt;peer_id;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Determine the access type for the PTP fea=
tures */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; idpf_ptp_get_features_access(adapter);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; access_type =3D (enum idpf_ptp_access)ptp-&g=
t;get_dev_clk_time_access;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (access_type !=3D IDPF_PTP_DIRECT)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto cross_tstamp;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; clock_offsets =3D recv_ptp_caps_msg-&gt;clk_=
offsets;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clock_offsets.de=
v_clk_ns_l);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.dev_clk_ns_l =3D IDPF_P=
CI_REG_ADDR(hw,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp_offset);<br>
<br>
No need to wrap these lines. Use the full 100 chars.<br>
(Also, when wrapping, double tab indent is sufficient, no need to put in 7<=
br>
tabs + spaces to try and align braces in cases like this)<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clock_offsets.de=
v_clk_ns_h);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.dev_clk_ns_h =3D IDPF_P=
CI_REG_ADDR(hw,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clock_offsets.ph=
y_clk_ns_l);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.phy_clk_ns_l =3D IDPF_P=
CI_REG_ADDR(hw,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clock_offsets.ph=
y_clk_ns_h);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.phy_clk_ns_h =3D IDPF_P=
CI_REG_ADDR(hw,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clock_offsets.cm=
d_sync_trigger);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.cmd_sync =3D IDPF_PCI_R=
EG_ADDR(hw, temp_offset);<br>
&gt; +<br>
&gt; +cross_tstamp:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; access_type =3D (enum idpf_ptp_access)ptp-&g=
t;get_cross_tstamp_access;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (access_type !=3D IDPF_PTP_DIRECT)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto discipline_clock;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; cross_tstamp_offsets =3D recv_ptp_caps_msg-&=
gt;cross_time_offsets;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(cross_tstamp_off=
sets.sys_time_ns_l);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.sys_time_ns_l =3D IDPF_=
PCI_REG_ADDR(hw,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; te=
mp_offset);<br>
<br>
Again, don't wrap. Also, this indentation used neither is a simple<br>
double-indent, nor does it align to brace so please use one style<br>
consistently.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(cross_tstamp_off=
sets.sys_time_ns_h);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.sys_time_ns_h =3D IDPF_=
PCI_REG_ADDR(hw,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; te=
mp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(cross_tstamp_off=
sets.cmd_sync_trigger);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.cmd_sync =3D IDPF_PCI_R=
EG_ADDR(hw, temp_offset);<br>
&gt; +<br>
&gt; +discipline_clock:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; access_type =3D (enum idpf_ptp_access)ptp-&g=
t;adj_dev_clk_time_access;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (access_type !=3D IDPF_PTP_DIRECT)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; clk_adj_offsets =3D recv_ptp_caps_msg-&gt;cl=
k_adj_offsets;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Device clock offsets */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.=
dev_clk_cmd_type);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.cmd =3D IDPF_PCI_REG_AD=
DR(hw, temp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.=
dev_clk_incval_l);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.incval_l =3D IDPF_PCI_R=
EG_ADDR(hw, temp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.=
dev_clk_incval_h);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.incval_h =3D IDPF_PCI_R=
EG_ADDR(hw, temp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.=
dev_clk_shadj_l);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.shadj_l =3D IDPF_PCI_RE=
G_ADDR(hw, temp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.=
dev_clk_shadj_h);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.shadj_h =3D IDPF_PCI_RE=
G_ADDR(hw, temp_offset);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* PHY clock offsets */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.=
phy_clk_cmd_type);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.phy_cmd =3D IDPF_PCI_RE=
G_ADDR(hw, temp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.=
phy_clk_incval_l);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.phy_incval_l =3D IDPF_P=
CI_REG_ADDR(hw,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.=
phy_clk_incval_h);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.phy_incval_h =3D IDPF_P=
CI_REG_ADDR(hw,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.=
phy_clk_shadj_l);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.phy_shadj_l =3D IDPF_PC=
I_REG_ADDR(hw, temp_offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.=
phy_clk_shadj_h);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;dev_clk_regs.phy_shadj_h =3D IDPF_PC=
I_REG_ADDR(hw, temp_offset);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_enable_shtime - Enable shadow time and execute a command<=
br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + */<br>
&gt; +static void idpf_ptp_enable_shtime(struct idpf_adapter *adapter)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t shtime_enable, exec_cmd;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Get offsets */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; shtime_enable =3D adapter-&gt;ptp-&gt;cmd.sh=
time_enable_mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; exec_cmd =3D adapter-&gt;ptp-&gt;cmd.exec_cm=
d_mask;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Set the shtime en and the sync field */<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PCI_REG_WRITE(adapter-&gt;ptp-&gt;dev_c=
lk_regs.cmd_sync, shtime_enable);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PCI_REG_WRITE(adapter-&gt;ptp-&gt;dev_c=
lk_regs.cmd_sync, exec_cmd | shtime_enable);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_get_dev_clk_time - Send virtchnl get device clk time mess=
age<br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + * @dev_clk_time: Pointer to the device clock structure where the val=
ue is set<br>
&gt; + *<br>
&gt; + * Send virtchnl get time message to get the time of the clock.<br>
&gt; + *<br>
&gt; + * Return: 0 on success, -errno otherwise.<br>
&gt; + */<br>
&gt; +int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; struct idpf_ptp_dev_timers *dev_clk_time)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_dev_clk_time get_de=
v_clk_time_msg =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D { };<br>
<br>
As above, use {0} as initializer.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 dev_time;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_GET_DEV_CLK_TI=
ME;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;get_dev_clk=
_time_msg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(get_dev_clk_tim=
e_msg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_resp;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(get_dev_clk_time_ms=
g);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, &amp;ar=
gs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; get_dev_clk_time_msg =3D *(struct virtchnl2_=
ptp_get_dev_clk_time *)args.out_buffer;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_time =3D LE64_TO_CPU(get_dev_clk_time_ms=
g.dev_time_ns);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_clk_time-&gt;dev_clk_time_ns =3D dev_tim=
e;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_get_cross_time - Send virtchnl get cross time message<br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + * @cross_time: Pointer to the device clock structure where the value=
 is set<br>
&gt; + *<br>
&gt; + * Send virtchnl get cross time message to get the time of the clock =
and the<br>
&gt; + * system time.<br>
&gt; + *<br>
&gt; + * Return: 0 on success, -errno otherwise.<br>
&gt; + */<br>
&gt; +int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct idpf_ptp_dev_timers *cross_time)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_cross_time cross_ti=
me_msg =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_GET_CROSS_TIME=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;cross_time_=
msg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(cross_time_msg)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_resp;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(cross_time_msg);<br=
>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, &amp;ar=
gs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; cross_time_msg =3D *(struct virtchnl2_ptp_ge=
t_cross_time *)args.out_buffer;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; cross_time-&gt;dev_clk_time_ns =3D LE64_TO_C=
PU(cross_time_msg.dev_time_ns);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; cross_time-&gt;sys_time_ns =3D LE64_TO_CPU(c=
ross_time_msg.sys_time_ns);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_set_dev_clk_time - Send virtchnl set device time message<=
br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + * @time: New time value<br>
&gt; + *<br>
&gt; + * Send virtchnl set time message to set the time of the clock.<br>
&gt; + *<br>
&gt; + * Return: 0 on success, -errno otherwise.<br>
&gt; + */<br>
&gt; +int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time)=
<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_set_dev_clk_time set_de=
v_clk_time_msg =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; set_dev_clk_time_msg.dev_time_ns =3D CPU_TO_=
LE64(time);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_SET_DEV_CLK_TI=
ME;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;set_dev_clk=
_time_msg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(set_dev_clk_tim=
e_msg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_resp;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(set_dev_clk_time_ms=
g);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, &amp;ar=
gs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_adj_dev_clk_time - Send virtchnl adj device clock time me=
ssage<br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + * @delta: Offset in nanoseconds to adjust the time by<br>
&gt; + *<br>
&gt; + * Send virtchnl adj time message to adjust the clock by the indicate=
d delta.<br>
&gt; + *<br>
&gt; + * Return: 0 on success, -errno otherwise.<br>
&gt; + */<br>
&gt; +int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t d=
elta)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_adj_dev_clk_time adj_de=
v_clk_time_msg =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adj_dev_clk_time_msg.delta =3D CPU_TO_LE64(d=
elta);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TI=
ME;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;adj_dev_clk=
_time_msg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(adj_dev_clk_tim=
e_msg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_resp;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(adj_dev_clk_time_ms=
g);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, &amp;ar=
gs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_adj_dev_clk_fine - Send virtchnl adj time message<br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + * @incval: Source timer increment value per clock cycle<br>
&gt; + *<br>
&gt; + * Send virtchnl adj fine message to adjust the frequency of the cloc=
k by<br>
&gt; + * incval.<br>
&gt; + *<br>
&gt; + * Return: 0 on success, -errno otherwise.<br>
&gt; + */<br>
&gt; +int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incva=
l)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_adj_dev_clk_fine adj_de=
v_clk_fine_msg =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adj_dev_clk_fine_msg.incval =3D CPU_TO_LE64(=
incval);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FI=
NE;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;adj_dev_clk=
_fine_msg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(adj_dev_clk_fin=
e_msg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_resp;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(adj_dev_clk_fine_ms=
g);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, &amp;ar=
gs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_get_vport_tstamps_caps - Send virtchnl to get tstamps cap=
s for vport<br>
&gt; + * @vport: Virtual port structure<br>
&gt; + *<br>
&gt; + * Send virtchnl get vport tstamps caps message to receive the set of=
 tstamp<br>
&gt; + * capabilities per vport.<br>
&gt; + *<br>
&gt; + * Return: 0 on success, -errno otherwise.<br>
&gt; + */<br>
&gt; +int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_vport_tx_tstamp_cap=
s send_tx_tstamp_caps =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_vport_tx_tstamp_cap=
s *rcv_tx_tstamp_caps;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_tx_tstamp_latch_caps tx=
_tstamp_latch_caps;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; enum idpf_ptp_access tstamp_access, get_dev_=
clk_access;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_vport_tx_tstamp_caps *tstamp=
_caps;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp *ptp =3D vport-&gt;adapter-&=
gt;ptp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u16 num_latches, i;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 size;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ptp =3D=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EOPNOTSUPP;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tstamp_access =3D (enum idpf_ptp_access)ptp-=
&gt;tx_tstamp_access;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; get_dev_clk_access =3D (enum idpf_ptp_access=
)ptp-&gt;get_dev_clk_time_access;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (tstamp_access =3D=3D IDPF_PTP_NONE ||<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dev_clk_access =
=3D=3D IDPF_PTP_NONE)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EOPNOTSUPP;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; send_tx_tstamp_caps.vport_id =3D CPU_TO_LE32=
(vport-&gt;vport_id);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_GET_VPORT_TX_T=
STAMP_CAPS;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;send_tx_tst=
amp_caps;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(send_tx_tstamp_=
caps);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D IDPF_CTLQ_MAX_BUF_LEN;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D vport-&gt;adapter-&gt;mb=
x_resp;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(vport-&gt;adapte=
r, &amp;args);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rcv_tx_tstamp_caps =3D (struct virtchnl2_ptp=
_get_vport_tx_tstamp_caps *)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; args.out_buffer;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; num_latches =3D LE16_TO_CPU(rcv_tx_tstamp_ca=
ps-&gt;num_latches);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; size =3D sizeof(struct idpf_ptp_vport_tx_tst=
amp_caps) +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(struct idpf_ptp_tx_tstamp) * num_latches;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps =3D rte_zmalloc(NULL, size, 0);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (tstamp_caps =3D=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -ENOMEM;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;access =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;num_entries =3D num_latches;=
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;tstamp_ns_lo_bit =3D rcv_tx_=
tstamp_caps-&gt;tstamp_ns_lo_bit;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; tstamp_caps-&gt;num_ent=
ries; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; __le32 offset_l, offset_h;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tx_tstamp_latch_caps =3D rcv_tx_tstamp_caps-&gt;tstamp_latches[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tstamp_access =3D=3D IDPF_PTP_DIRECT) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset_l =3D tx_tstamp_=
latch_caps.tx_latch_reg_offset_l;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset_h =3D tx_tstamp_=
latch_caps.tx_latch_reg_offset_h;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;tx_tsta=
mp[i].tx_latch_reg_offset_l =3D LE32_TO_CPU(offset_l);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;tx_tsta=
mp[i].tx_latch_reg_offset_h =3D LE32_TO_CPU(offset_h);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tstamp_caps-&gt;tx_tstamp[i].idx =3D tx_tstamp_latch_caps.index;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;latched_idx =3D -1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; vport-&gt;tx_tstamp_caps =3D tstamp_caps;<br=
>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_get_tstamp_value - Get the Tx timestamp value and provide=
 it<br>
&gt; + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; back to the skb.<br>
&gt; + * @vport: Virtual port structure<br>
&gt; + * @tstamp_latch: Tx timestamp latch structure fulfilled by the Contr=
ol Plane<br>
&gt; + * @tx_tstamp: Tx timestamp structure to be fulfilled with the timest=
amp value<br>
&gt; + *<br>
&gt; + * Read the value of the Tx timestamp for a given latch received from=
 the<br>
&gt; + * Control Plane.<br>
&gt; + *<br>
&gt; + * Return: 0 on success, -errno otherwise.<br>
&gt; + */<br>
&gt; +static int<br>
&gt; +idpf_ptp_get_tstamp_value(struct idpf_vport *vport,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virt=
chnl2_ptp_tx_tstamp_latch *tstamp_latch,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf=
_ptp_tx_tstamp *tx_tstamp)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_vport_tx_tstamp_caps *tx_tst=
amp_caps;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u8 tstamp_ns_lo_bit;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tx_tstamp_caps =3D vport-&gt;tx_tstamp_caps;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tstamp_ns_lo_bit =3D tx_tstamp_caps-&gt;tsta=
mp_ns_lo_bit;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tx_tstamp-&gt;tstamp =3D LE64_TO_CPU(tstamp_=
latch-&gt;tstamp);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tx_tstamp-&gt;tstamp &gt;&gt;=3D tstamp_ns_l=
o_bit;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_get_tx_tstamp - Send virtchnl get Tx timestamp latches me=
ssage<br>
&gt; + * @vport: Virtual port structure<br>
&gt; + *<br>
&gt; + * Send virtchnl get Tx tstamp message to read the value of the HW ti=
mestamp.<br>
&gt; + * The message contains a list of indexes set in the Tx descriptors.<=
br>
&gt; + *<br>
&gt; + * Return: 0 on success, -errno otherwise.<br>
&gt; + */<br>
&gt; +int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_vport_tx_tstamp_lat=
ches *send_tx_tstamp_msg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_vport_tx_tstamp_lat=
ches *recv_tx_tstamp_msg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_vport_tx_tstamp_caps *tx_tst=
amp_caps;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_tx_tstamp_latch tstamp_=
latch;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D { };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int size, msg_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 vport_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u16 num_latches, id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tx_tstamp_caps =3D vport-&gt;tx_tstamp_caps;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp_tx_tstamp =3D tx_tstamp_caps-&gt;tx_tsta=
mp;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; size =3D sizeof(struct virtchnl2_ptp_get_vpo=
rt_tx_tstamp_latches) +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(s=
truct virtchnl2_ptp_tx_tstamp_latch) *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tx_tstam=
p_caps-&gt;num_entries;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; send_tx_tstamp_msg =3D rte_zmalloc(NULL, siz=
e, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (send_tx_tstamp_msg =3D=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -ENOMEM;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (id =3D 0; id &lt; tx_tstamp_caps-&gt;nu=
m_entries; id++,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ptp_tx_tstamp++)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; send_tx_tstamp_msg-&gt;tstamp_latches[id].index =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ptp_tx_tstamp-&gt;idx;<br>
<br>
Identation in this loop badly needs to be reworked.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; send_tx_tstamp_msg-&gt;get_devtime_with_txts=
tmp =3D 1;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; msg_size =3D sizeof(struct virtchnl2_ptp_get=
_vport_tx_tstamp_latches) +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sizeof(struct virtchnl2_ptp_tx_tstamp_latch) * id;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; send_tx_tstamp_msg-&gt;vport_id =3D CPU_TO_L=
E32(vport-&gt;vport_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; send_tx_tstamp_msg-&gt;num_latches =3D CPU_T=
O_LE16(id);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_GET_VPORT_TX_T=
STAMP;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)send_tx_tstamp_m=
sg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D msg_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D msg_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D vport-&gt;adapter-&gt;mb=
x_resp;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(vport-&gt;adapte=
r, &amp;args);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rte_free(send_tx_tstamp_msg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; recv_tx_tstamp_msg =3D (struct virtchnl2_ptp=
_get_vport_tx_tstamp_latches *)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; args.out_buffer;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; vport_id =3D LE32_TO_CPU(recv_tx_tstamp_msg-=
&gt;vport_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (vport-&gt;vport_id !=3D vport_id)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; num_latches =3D LE16_TO_CPU(recv_tx_tstamp_m=
sg-&gt;num_latches);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ptp_tx_tstamp =3D tx_tstamp_caps-&gt;tx_tsta=
mp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (id =3D 0; id &lt; num_latches; id++, pt=
p_tx_tstamp++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tstamp_latch =3D recv_tx_tstamp_msg-&gt;tstamp_latches[id];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!tstamp_latch.valid)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; err =3D idpf_ptp_get_tstamp_value(vport, &amp;tstamp_latch,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp_tx_tstamp);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (err =3D=3D 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tx_tstamp_caps-&gt;latc=
hed_idx =3D id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vport-&gt;adapter-&gt;t=
ime_hw =3D recv_tx_tstamp_msg-&gt;device_time;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer va=
lue<br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + *<br>
&gt; + * Return: the device clock time.<br>
&gt; + */<br>
&gt; +static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adap=
ter)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp *ptp =3D adapter-&gt;ptp;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 hi, lo;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; idpf_ptp_enable_shtime(adapter);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; lo =3D IDPF_PCI_REG(ptp-&gt;dev_clk_regs.dev=
_clk_ns_l);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; hi =3D IDPF_PCI_REG(ptp-&gt;dev_clk_regs.dev=
_clk_ns_h);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ((u64)hi &lt;&lt; 32) | lo;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_read_src_clk_reg_mailbox - Read the main timer value thro=
ugh mailbox<br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + * @src_clk: Returned main timer value in nanoseconds unit<br>
&gt; + *<br>
&gt; + * Return: 0 on success, -errno otherwise.<br>
&gt; + */<br>
&gt; +static int idpf_ptp_read_src_clk_reg_mailbox(struct idpf_adapter *ada=
pter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; u64 *src_clk)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_dev_timers clk_time;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_ptp_get_dev_clk_time(adapter, &=
amp;clk_time);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return err;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; *src_clk =3D clk_time.dev_clk_time_ns;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * idpf_ptp_read_src_clk_reg - Read the main timer value<br>
&gt; + * @adapter: Driver specific private structure<br>
&gt; + * @src_clk: Returned main timer value in nanoseconds unit<br>
&gt; + *<br>
&gt; + * Return: the device clock time on success, -errno otherwise.<br>
&gt; + */<br>
&gt; +int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, u64 *src_=
clk)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adapter-&gt;ptp =3D=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
<br>
Should this not be an error, returning -EINVAL?<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch ((enum idpf_ptp_access)adapter-&gt;pt=
p-&gt;get_dev_clk_time_access) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IDPF_PTP_NONE:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EOPNOTSUPP;<br>
<br>
Strictly speaking, you don't need this, it's handled by the default case.<b=
r>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IDPF_PTP_MAILBOX:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return idpf_ptp_read_src_clk_reg_mailbox(adapter, src_clk);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IDPF_PTP_DIRECT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *src_clk =3D idpf_ptp_read_src_clk_reg_direct(adapter);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
<br>
Why have the function types for direct and mailbox different? Why not have<=
br>
both just take src_clk as parameter and return 0 on success, so you can<br>
have similar use of them. It would also possibly allow function pointer use=
<br>
in future, if they are the same types.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EOPNOTSUPP;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt; diff --git a/drivers/net/intel/idpf/idpf_ptp.h b/drivers/net/intel/idp=
f/idpf_ptp.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..68ac66ae91<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/net/intel/idpf/idpf_ptp.h<br>
&gt; @@ -0,0 +1,227 @@<br>
&gt; +/* SPDX-License-Identifier: BSD-3-Clause<br>
&gt; + * Copyright(c) 2025 Intel Corporation<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef _IDPF_PTP_H_<br>
&gt; +#define _IDPF_PTP_H_<br>
&gt; +<br>
&gt; +#include &quot;idpf_osdep.h&quot;<br>
&gt; +#include &lt;rte_time.h&gt;<br>
&gt; +#include &quot;idpf_common_device.h&quot;<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @struct idpf_ptp_cmd - PTP command masks<br>
&gt; + * @exec_cmd_mask: mask to trigger command execution<br>
&gt; + * @shtime_enable_mask: mask to enable shadow time<br>
&gt; + */<br>
&gt; +struct idpf_ptp_cmd {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t exec_cmd_mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t shtime_enable_mask;<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* @struct idpf_ptp_dev_clk_regs - PTP device registers<br>
&gt; + * @dev_clk_ns_l: low part of the device clock register<br>
&gt; + * @dev_clk_ns_h: high part of the device clock register<br>
&gt; + * @phy_clk_ns_l: low part of the PHY clock register<br>
&gt; + * @phy_clk_ns_h: high part of the PHY clock register<br>
&gt; + * @sys_time_ns_l: low part of the system time register<br>
&gt; + * @sys_time_ns_h: high part of the system time register<br>
&gt; + * @incval_l: low part of the increment value register<br>
&gt; + * @incval_h: high part of the increment value register<br>
&gt; + * @shadj_l: low part of the shadow adjust register<br>
&gt; + * @shadj_h: high part of the shadow adjust register<br>
&gt; + * phy_incval_l: low part of the PHY increment value register<br>
&gt; + * phy_incval_h: high part of the PHY increment value register<br>
&gt; + * phy_shadj_l: low part of the PHY shadow adjust register<br>
&gt; + * phy_shadj_h: high part of the PHY shadow adjust register<br>
&gt; + * @cmd: PTP command register<br>
&gt; + * @phy_cmd: PHY command register<br>
&gt; + * @cmd_sync: PTP command synchronization register<br>
&gt; + */<br>
&gt; +struct idpf_ptp_dev_clk_regs {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Main clock */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *dev_clk_ns_l;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *dev_clk_ns_h;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* PHY timer */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_clk_ns_l;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_clk_ns_h;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* System time */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *sys_time_ns_l;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *sys_time_ns_h;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Main timer adjustments */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *incval_l;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *incval_h;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *shadj_l;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *shadj_h;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* PHY timer adjustments */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_incval_l;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_incval_h;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_shadj_l;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_shadj_h;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Command */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *cmd;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_cmd;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *cmd_sync;<br>
&gt; +};<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @enum idpf_ptp_access - the type of access to PTP operations<br>
&gt; + * @IDPF_PTP_NONE: no access<br>
&gt; + * @IDPF_PTP_DIRECT: direct access through BAR registers<br>
&gt; + * @IDPF_PTP_MAILBOX: access through mailbox messages<br>
&gt; + */<br>
&gt; +enum idpf_ptp_access {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_NONE =3D 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_DIRECT,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_MAILBOX,<br>
&gt; +};<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @struct idpf_ptp_secondary_mbx - PTP secondary mailbox<br>
&gt; + * @peer_mbx_q_id: PTP mailbox queue ID<br>
&gt; + * @peer_id: Peer ID for PTP Device Control daemon<br>
&gt; + * @valid: indicates whether secondary mailblox is supported by the C=
ontrol<br>
&gt; + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Plane<br>
&gt; + */<br>
&gt; +struct idpf_ptp_secondary_mbx {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t peer_mbx_q_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t peer_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool valid:1;<br>
&gt; +};<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @enum idpf_ptp_tx_tstamp_state - Tx timestamp states<br>
&gt; + * @IDPF_PTP_FREE: Tx timestamp index free to use<br>
&gt; + * @IDPF_PTP_REQUEST: Tx timestamp index set to the Tx descriptor<br>
&gt; + * @IDPF_PTP_READ_VALUE: Tx timestamp value ready to be read<br>
&gt; + */<br>
&gt; +enum idpf_ptp_tx_tstamp_state {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_FREE,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_REQUEST,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_READ_VALUE,<br>
&gt; +};<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @struct idpf_ptp_tx_tstamp - Parameters for Tx timestamping<br>
&gt; + * @list_member: the list member structure<br>
&gt; + * @tx_latch_reg_offset_l: Tx tstamp latch low register offset<br>
&gt; + * @tx_latch_reg_offset_h: Tx tstamp latch high register offset<br>
&gt; + * @tstamp: the Tx tstamp value<br>
&gt; + * @idx: the index of the Tx tstamp<br>
&gt; + */<br>
&gt; +struct idpf_ptp_tx_tstamp {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t tstamp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tx_latch_reg_offset_l;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tx_latch_reg_offset_h;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t idx;<br>
&gt; +};<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @struct idpf_ptp_vport_tx_tstamp_caps - Tx timestamp capabilities<=
br>
&gt; + * @vport_id: the vport id<br>
&gt; + * @num_entries: the number of negotiated Tx timestamp entries<br>
&gt; + * @tstamp_ns_lo_bit: first bit for nanosecond part of the timestamp<=
br>
&gt; + * @access: indicates an access to Tx timestamp<br>
&gt; + * @latches_index: the index&nbsp; of the latched Tx timestamps<br>
&gt; + * @tx_tstamp: array of Tx timestamp parameters<br>
&gt; + */<br>
&gt; +struct idpf_ptp_vport_tx_tstamp_caps {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vport_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t num_entries;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t tstamp_ns_lo_bit;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t latched_idx;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool access:1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_tx_tstamp tx_tstamp[];<br>
&gt; +};<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @struct idpf_ptp - PTP parameters<br>
&gt; + * @base_incval: base increment value of the PTP clock<br>
&gt; + * @max_adj: maximum adjustment of the PTP clock<br>
&gt; + * @cmd: HW specific command masks<br>
&gt; + * @dev_clk_regs: the set of registers to access the device clock<br>
&gt; + * @caps: PTP capabilities negotiated with the Control Plane<br>
&gt; + * @get_dev_clk_time_access: access type for getting the device clock=
 time<br>
&gt; + * @get_cross_tstamp_access: access type for the cross timestamping<b=
r>
&gt; + * @set_dev_clk_time_access: access type for setting the device clock=
 time<br>
&gt; + * @adj_dev_clk_time_access: access type for the adjusting the device=
 clock<br>
&gt; + * @tx_tstamp_access: access type for the Tx timestamp value read<br>
&gt; + * @rsv: Reserved fields<br>
&gt; + * @secondary_mbx: parameters for using dedicated PTP mailbox<br>
&gt; + */<br>
&gt; +struct idpf_ptp {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t base_incval;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t max_adj;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_cmd cmd;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_dev_clk_regs dev_clk_regs;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t caps;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t get_dev_clk_time_access:2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t get_cross_tstamp_access:2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t set_dev_clk_time_access:2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t adj_dev_clk_time_access:2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t tx_tstamp_access:2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t rsv:6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_secondary_mbx secondary_mbx;=
<br>
&gt; +};<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @struct idpf_ptp_dev_timers - System time and device time values<b=
r>
&gt; + * @sys_time_ns: system time value expressed in nanoseconds<br>
&gt; + * @dev_clk_time_ns: device clock time value expressed in nanoseconds=
<br>
&gt; + */<br>
&gt; +struct idpf_ptp_dev_timers {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t sys_time_ns;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dev_clk_time_ns;<br>
&gt; +};<br>
&gt; +<br>
&gt; +int idpf_ptp_get_caps(struct idpf_adapter *adapter);<br>
&gt; +int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t =
*src_clk);<br>
&gt; +int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; struct idpf_ptp_dev_timers *dev_clk_time);<br>
&gt; +int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct idpf_ptp_dev_timers *cross_time);<br>
&gt; +int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t =
time);<br>
&gt; +int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t =
incval);<br>
&gt; +int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t d=
elta);<br>
&gt; +int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport);<br>
&gt; +int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport);<br>
&gt; +<br>
&gt; +/* Helper function to convert a 32b nanoseconds timestamp to 64b. */<=
br>
&gt; +static inline uint64_t<br>
&gt; +idpf_tstamp_convert_32b_64b(struct idpf_adapter *ad, uint32_t flag,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 bool is_rx, uint32_t in_timestamp)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t mask =3D 0xFFFFFFFF;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t phc_time_lo, delta;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t ns;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (flag !=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; idpf_ptp_read_src_clk_reg(ad, &amp;ad-&gt;time_hw);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; /* Extract the lower 32 bits of the PHC time */<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; phc_time_lo =3D (uint32_t)(ad-&gt;time_hw);<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Calculate the delta between the lower 32b=
its of the cached PHC<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * time and the in_timestamp value.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; delta =3D in_timestamp - phc_time_lo;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (delta &gt; mask / 2) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Reverse the delta calculation here */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; delta =3D phc_time_lo - in_timestamp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ns =3D ad-&gt;time_hw - delta;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (is_rx)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ns =3D ad-&gt;time_hw -=
 delta;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ns =3D ad-&gt;time_hw +=
 delta;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ns;<br>
&gt; +}<br>
&gt; +#endif /* _IDPF_PTP_H_ */<br>
&gt; diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/id=
pf/meson.build<br>
&gt; index a805d02ea2..5a4a3c2259 100644<br>
&gt; --- a/drivers/net/intel/idpf/meson.build<br>
&gt; +++ b/drivers/net/intel/idpf/meson.build<br>
&gt; @@ -18,6 +18,7 @@ sources +=3D files(<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'idpf_ethdev.c',=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'idpf_rxtx.c',<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'idpf_ptp.c',<br>
<br>
All lists in DPDK should be in alphabetical order, unless there is a reason=
<br>
they can't be. Therefore, this new C file should be above idpf_rxtx.c in<br=
>
the list.<br>
<br>
&gt;&nbsp; )<br>
&gt;&nbsp;<br>
&gt;&nbsp; if arch_subdir =3D=3D 'x86' and dpdk_conf.get('RTE_IOVA_IN_MBUF'=
) =3D=3D 1<br>
&gt; --<br>
&gt; 2.47.1<br>
&gt;</div>
</div>
</body>
</html>

--_000_CY8PR11MB7747A6678C62416C551473B8F96EACY8PR11MB7747namp_--
