Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763A6F94CDE
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:21:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84FEE40272;
	Wed, 22 Apr 2026 10:20:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 7738240144
 for <dev@dpdk.org>; Wed, 22 Apr 2026 10:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776846057; x=1808382057;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=LMwAnRNW2MkvfnbgTx3sAQ5v9Y9zSbEdSPxZ0j8gUXI=;
 b=djVdkdn7i1FSn3BJkTwIRwqjvknMo9pq+u1qUuuKIrhMY/uI1zQnK/xX
 rhc7IYYDuoYlkRplAZkpCCOxQ3N8UcsddxL9TgQuTj3oR0D+qvkuxVuXY
 w5tZQH6SNlrsKyw28Cs6NN/wWKHfsEYzLmOcqitPHcT2SSUWXmifkWqrU
 Ub4YBEIKhpR0ZdCw+iX5+4EJKpx16JdmTcdMOUs0RJUjv1NvfpHjh0Prk
 0zK0kl6vH+ywAURP3dO7j5uAH9h+BJebxn4HXZ1hLDKsGEmSdb2pXtOwP
 9G4MFortPJ566B9ugGz0twbS8dZnaT8DAcNTtUemUHM7ULXWkNrwPlarU w==;
X-CSE-ConnectionGUID: oa6fRiZ+QDa7Lcx6wwv3Ag==
X-CSE-MsgGUID: wx4DgGX/T6+Tx28znTqVYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77808816"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208,217";a="77808816"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 01:20:56 -0700
X-CSE-ConnectionGUID: YLhH/A19TdG5Iy1t8sHizQ==
X-CSE-MsgGUID: G3NZtwgOSKeWPP9Ngz4yOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
 d="scan'208,217";a="229124030"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 01:20:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 01:20:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 01:20:55 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 01:20:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzUm2VLZz7gV+z+HQmIBLtiOzaVG5Zu0IqA48zbSSHBsu2VzGxmJPEqZ2/xz/CK6PK3YU2RS9if3ZhPILVBax4uc0J75AlZVSJiKDjhynnY3Q5wRlosQGlPn0V5e/oQooUPlVHJrDPTzwxPOK3pLLXHBTOmMagXrsA88NbMlxHFFYk0WEbLBmkLr51G3LSobgIHZjSILx/hb+0EFjaA1zWD/PAf+FQ9O1DYBBaHUd0bgHIyig77nFlHCwAsrajgdvMNELtWdp1Vy9/2XAMoVNkaseh8vXlXAPtMwo5CQ3Pex2GjSBZeVIGaZ5gawazEYxvhU97uA8EocOtQXTyUc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMwAnRNW2MkvfnbgTx3sAQ5v9Y9zSbEdSPxZ0j8gUXI=;
 b=lUwSK0qE83AY0LSyK56xrpAqm6qCJAWsqjICPGOyQYE3iRf5hf+5Xp28yCn5W6MRv+sO0Vmo/Uj6M6duxXd+jb0cEF78JCX3TbWhTblfCtbTgcrbimUmWxNxok6Q/FeOvhGT6m0fu3Rhb9HLMClrrBM6FxClCIXZ9EuDBoqkjrksurDYQk+/M7mKCgGHzskDvAODE0FzHff4zmqh2eI0gLkZUrHpGju7+1uxyAAvTYmcUxAiDw4yEvXXfXiOAbr0y+MpNEZ7N931MaWz8UpchlLujnuaackfY7CUG05LwutOT36iQ9MZmh6hbF7s4Dn/BftweVX2wz2mEMjHBTu9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by SA1PR11MB8351.namprd11.prod.outlook.com (2603:10b6:806:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 08:20:46 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 08:20:46 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Adam Hassick <ahassick@iol.unh.edu>
Subject: Re: [PATCH v4 2/2] test: simplify spawning extra test processes
Thread-Topic: [PATCH v4 2/2] test: simplify spawning extra test processes
Thread-Index: AQHc0ciBUcYOb8nzjEa+QsgO/muzFbXqvijE
Date: Wed, 22 Apr 2026 08:20:46 +0000
Message-ID: <CY5PR11MB63182C62F2FF56D2C74305C7FC2D2@CY5PR11MB6318.namprd11.prod.outlook.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260421195227.1425625-1-bruce.richardson@intel.com>
 <20260421195227.1425625-3-bruce.richardson@intel.com>
In-Reply-To: <20260421195227.1425625-3-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|SA1PR11MB8351:EE_
x-ms-office365-filtering-correlation-id: cbc7318b-8c00-4d9c-2e71-08dea0480dde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: W+7gB+0HZofXBJsTJJUVGbBVqIRRb9uwr+djzd3f+b0TBYOQ2CXwUv15RZ3jucwUPSntL2GE7s7jHCtJzXToprgnQuTas+4DsLqP+/qmm0SzPCpsiFLC32BNj+RpHG7XVJX+eeOMn0+mM/9o1eXgzead9EvpAMD5vvF8bASO686guE2/nJ0vzWAdJT+8YRS1M2trRjir8sx7+W7SZY+lrO6HImkfaSSs+O6/6K3eCB/6E9mB3oY5+f2pmVEf7WFDEhG2+SC4tOIKji5fy7uyklfplGUoumY4+ioSdsWfEVkbo9vTIS6lyFviEp5oY8A4ZfmOTEz8uUTpuHGmp2fZoLQBEG529QBxZLDeTR0n84l6qNUDU+kJ8kg8kkwWqittYxCt/OUn0pB8NmFWMgAazbza6P5qSR90MowyxJavIZPn4KK2aYTywrpj8JCHUjQEKWEKh/L91bPHjyvmdyXgbLbYZ4ouoj8otiuMcl+x0RLN1+OezWlxpcra5GfDgwNZxg5OvEZ1ijh5ItnXrIobzXFux34bQu3QBxxPyyMKCAHXZY9jh0PdvnmzwvX5YOvX3qYgPlkpr8lqgsyPDSUmodAey6mB4bHnyCFrADTMfBAanjw127emcM+Q5LAyCbKtWFbKtRf3yF0gcofxXiNmM1rtJi5kDfNTVTDSiDbpvkHIFfbGnpxmPCIZsXSHmRi1ajqTaC6NMDGeLCvBrPO6o5TNCMLpTt6mVRRu/qTykM78HflWSzqRadynHUFMrL9+52s1VT+nVEZugOJplcck1douBPACUDHwiRmxkRl8KkM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(18002099003)(22082099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?enHDsZ0B/krpAw1rI/U0jDy6BOB0ZOPoUrHvvM8R4l8Ve/EW3sOugnJGnR?=
 =?iso-8859-1?Q?7m94OJosoBU0BTOc6KOFuLR0HYet5/LSlUah4J9TQl8Qges2dy6BQWhor4?=
 =?iso-8859-1?Q?UId4S9odWZUe8IZSzBq1J6oWso/1FvdmM/HC5O31callx/orkAhka8xOAv?=
 =?iso-8859-1?Q?7/ewNYDMkHK5sezXR5nqnSdfLySYbPXHWjQtT9jlFP4CEkkxf/ZLdNcUqP?=
 =?iso-8859-1?Q?G193FnfuLLm3yz+0YuSqi8u5LTIceRD0Jf1b8eIA4V3RiobtKI0VD3uzNU?=
 =?iso-8859-1?Q?G2WURwegjo0AnsrjYgE1xvmMDqZWwUMEZF3pjDucThMkSohH+FvEFxmeou?=
 =?iso-8859-1?Q?ww3Cgtdrm5K4kBA+BepAF/gtaAUsJt0H1Uzqlku0JLWujKnjFHRFNl5lOU?=
 =?iso-8859-1?Q?b/ooI0HtFd1/K2UCI+Wh0wjwzd6yGNX9kKGwT7xs8Rip9x6vPFIh/ogBD1?=
 =?iso-8859-1?Q?TB5Nm/wrmH12OG4bAunFpETr4GnJwQOejVuIalp3OdKufYOVdtWqgkYi2g?=
 =?iso-8859-1?Q?2xIhGC0QRLXm6HrgK2hNCcdXDM/yoAUwmxuBt9aqH3Dlek0kTD6IlSG4xr?=
 =?iso-8859-1?Q?GnLnXfoO+LOp9GBrmayY/uWgLnWZYE6RT4Q0tOg1LE02X/FXqhl9x18A/V?=
 =?iso-8859-1?Q?rvhjaZelzOTilYGq6YUwC7JFe6TEQtjuhIiP7mzTdj1K5URsZVBbly5yt4?=
 =?iso-8859-1?Q?wUYqzVAtR23Boy6r8gM12JeHrXg9DVvawksVVdwUqJJ81JMZg5MNNkCveH?=
 =?iso-8859-1?Q?obMN4qUF52ymcJ1QFyjrWQ0sppyMYqbbJmyt8PwoQoUZLuCYrzb1KEp7xT?=
 =?iso-8859-1?Q?f5XK9PJ3EVREqyHKC8vneI+t0NCD4kX/W+XW6MG0q62Zeyrtt0cETOoWnV?=
 =?iso-8859-1?Q?JKmgbgvZ6N5kCu6ysOGjYK0OH57yYtzm7QxOSj4KEoGTO4XAK2MRYm4Io1?=
 =?iso-8859-1?Q?eSM6nHYdo2Wgwsll1HnPhCBD7ko4K1znA+kR5DxjqdMM7h3JzpufbqHn8q?=
 =?iso-8859-1?Q?Q6xsBh1sjGMM9tC4PsrX8BQ2R4kVikbmJDRUlt5+WHPrw2c8vPM63+KMrb?=
 =?iso-8859-1?Q?OnqMl0N200CifvBCItnACC18j1BoQlf+u1kt4gHj1/r/3sbr1FhJQ6FbxQ?=
 =?iso-8859-1?Q?CiJ4E7JFzJBKry+3ndxyMW8662WRrTRTfp2OwjW49dpiBuMPrdrjzOZS/+?=
 =?iso-8859-1?Q?nvtt7li4TPKMAgegN8+O6lrJ2gfc2VXA2RVbEPDoK7veYaTfzHkiWWrq2R?=
 =?iso-8859-1?Q?lw846lPr029Lo1Ks3YiqNKCILgmUNQL0p89KmXBBLSJFgBTgkzJsOxOi2Y?=
 =?iso-8859-1?Q?npGAxOLJiVijXifRnBpPKnhA1onBtG1kZbmKqbQzCSbbaJXtAdPGEldzGN?=
 =?iso-8859-1?Q?E5E+/BLGGzT/X7ZKgpLSO7QmSYe66kEkh5zbI9o8N4bYH/nq+LEo9Nb4kb?=
 =?iso-8859-1?Q?QVsMjympZr9zl2qZt5ZcLD7OO5xxY/iv7sahXV9B/GpsLE6Z7B8kTzk7az?=
 =?iso-8859-1?Q?BcwmL7WLNukXCggTf248FtjixUdB9LSEhWvhs+Hrb65fnd5pU7x0Ws2e54?=
 =?iso-8859-1?Q?CRJARhtwuHu0Q0XIYiVO4pIwuxqFLQ1LjzrmHO4SFS52xi4C5Yf+aNoJMQ?=
 =?iso-8859-1?Q?z81jqwzNRRpK2KhG03J6Mb+VP+E4EJtH1SGT7jPrFiIhBVxwmdqKXewJIa?=
 =?iso-8859-1?Q?kF54vWgvTNrKxBrKUHDC7LJzAQ8zE8v+NpavI5GVEdts8OnD04I63/Clhb?=
 =?iso-8859-1?Q?BHK5fIU9mQj6qJjmk+aj0Wa+j9SpB/D78ZtS2pnr2T8aIwEvsaJ0S+pIAV?=
 =?iso-8859-1?Q?laiVoo8I5Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB63182C62F2FF56D2C74305C7FC2D2CY5PR11MB6318namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PODbYOXsZm6k5q+Jxc3XocJlDuo0eMjvf9TfPNPQDRb9FEScfTTDFPqRlhDVLNJymZhi393AagPGQOgvLrKNQtXp+bzVB7M9qmUsh1ppEI4nCOD5pfD54wWDvbr3kb6Gn9MH+JqApzppcljBx7cyloxS6fAdKgMtkttstxOKQXoWT0YO1r6DGqpGYoWMo21uqLmG8UwsWk2hJ0e1US46gsTW9D3K2ysJYN9jUK3OwIwyy1m5DpoU9dmcr660hxxBIZGeApvc9lUh2Wn0vI8FHqipsF0IPwldOwF/crNYdnSF+FtIzRQ1nWp9Zpk4x75ndNnH8ccOF48xb4FVrRLiaA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc7318b-8c00-4d9c-2e71-08dea0480dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 08:20:46.2810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SEIdWqmH2v3FL8TFGTnEGt6yKY+Cl1D1DUZ1URlYHu2VV7E9w6iO1+TRMCWIHNCN3k+N6XegeMSZXIzsgqYpjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8351
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

--_000_CY5PR11MB63182C62F2FF56D2C74305C7FC2D2CY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Bruce Richardson <bruce.richardson@intel.com>
Sent: Tuesday, April 21, 2026 8:52 PM
To: dev@dpdk.org <dev@dpdk.org>
Cc: Richardson, Bruce <bruce.richardson@intel.com>; Adam Hassick <ahassick@=
iol.unh.edu>
Subject: [PATCH v4 2/2] test: simplify spawning extra test processes

A number of tests require secondary processes or additional primary
process instances, so we have common code for managing that in the test
binary. Simplify that code a little, in the process removing dependency
on procfs on FreeBSD, by using argv[0] as the binary to run, rather than
querying procfs for /proc/self/exe (or /proc/curproc/file on FreeBSD).
The unit tests should never be running in a way that leads to argv[0]
not being the actual test binary.

Acked-by: John McNamara <john.mcnamara@intel.com>




--_000_CY5PR11MB63182C62F2FF56D2C74305C7FC2D2CY5PR11MB6318namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Bruce Richardson &lt;bruce.richardson@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, April 21, 2026 8:52 PM<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b>&nbsp;Richardson, Bruce &lt;bruce.richardson@intel.com&gt;; Adam =
Hassick &lt;ahassick@iol.unh.edu&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v4 2/2] test: simplify spawning extra test proc=
esses </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">A number of tests require secondary process=
es or additional primary<br>
process instances, so we have common code for managing that in the test<br>
binary. Simplify that code a little, in the process removing dependency<br>
on procfs on FreeBSD, by using argv[0] as the binary to run, rather than<br=
>
querying procfs for /proc/self/exe (or /proc/curproc/file on FreeBSD).<br>
The unit tests should never be running in a way that leads to argv[0]<br>
not being the actual test binary.</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Acked-by: John McNamara &lt;john.mcnamara@intel.com&gt;</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div style=3D"font-size: 11pt;"><br>
<br>
</div>
</body>
</html>

--_000_CY5PR11MB63182C62F2FF56D2C74305C7FC2D2CY5PR11MB6318namp_--
