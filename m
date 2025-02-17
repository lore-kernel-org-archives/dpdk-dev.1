Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEDDC021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 16:15:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D88E7400EF;
	Mon, 17 Feb 2025 17:15:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 03874400D6
 for <dev@dpdk.org>; Mon, 17 Feb 2025 17:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739808944; x=1771344944;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=BqPvd8hmyO5yn8cP+OyaHfJ48ID9aymuJ2QbVM1Ymh8=;
 b=UC07C+npnEmoqrm8SENDmcreOT4GEwEZd1bSQlVxhnx3q//di6lo16bY
 eKeTgWCiupwFqKLtWpyKnRHU3UtjJljUR2vOHsdo4xnGFHw6/wm/IWQ37
 ZwyAMUj3On/0JqKeW5AfmgxpnqcfvvpKGAK8+9TX7dUIhxwQ+VJpcxUUK
 7mNuiFz7nGsM7nUw3urn0O1XlJ9h5fRYNoL/CR6o/DYpcJKAxaOcqVon/
 t9mhL1Sql0VAdAbxWirEfcUNzgxMuVoD1CzOQ3NKT7hIINoFmZ2G8npOT
 dLk1EtMfpLFJpWGNmAsWSCvyS3BVhyyNVoBRUZPrWFu462kaNfjb0vMaU g==;
X-CSE-ConnectionGUID: Hp2pbT9nQ1KMarKjNPazKw==
X-CSE-MsgGUID: AXrRmPLhTgi//UtfYZ4mFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40620988"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208,217";a="40620988"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 08:15:42 -0800
X-CSE-ConnectionGUID: hWnfd786RRaNZ2UTUbfSJg==
X-CSE-MsgGUID: sUfTvalQRuKzoH8XzyTEWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
 d="scan'208,217";a="114632263"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Feb 2025 08:15:42 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 08:15:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 08:15:41 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 08:15:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o77wrjRqJkNhYY9cg2S/PgIfQlt9p9AEoX4RidSZwpy9frGoJy/1jU2ktAIJv2men27jiFUDx0bBHE2JMF7f2GDAFvoP6FJwhgiTfMP3pMQ72cirKvxja1b/39a46OGiEylkGamXJAB4JpqG0KV2VIgGmiK2E51wKRUy50Tb4AQYWsGc58m8iyZTRD2VPuSq0MwN1vicDmu25VQRV46+2Tx3ogs4gCgjtpebvEHCC0AkkSdX07iqRtrSVjydd0qG2OsOwBqmdlf8LNiDqj19HB+1N85WdKNXWp17aaJwtQ01Rc74eXVHydBY+0ZJUfIcqBkw5GX+dX6d7hCZSnjNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWJ1ya4/F4zA1RCd/5uOlAJP/2jY+e0xADqLu/AKzpQ=;
 b=ndKazthLce2EANwstm7kIXenTt0jzB6bwQsgi7PRafX1fF0WKTLk9W0b+a1ry6TB6m3cDQyvYJnM4UtJNGx4IY+vjxe4GSbHj6kCa02PA9wge1IUygMByk5AOsI1+UaLX9Y4UnYr7Ijab6Hz/xZkeu2n86K8qwXHnRKTwfDtKQhrk/Iwg6LuD0AnwIwWd/+HENQBeWoD/m3c1l4+0Am2XaiVwN1KbETLPrx8AMVNHeH9rK/ZD7W7WFm76iOWTdPRcs3592siXHRRMlH22mUIKkPdjghkqnplLXw+RoV8P7GKVOZyC+oEnlsC7uJwUd0AgZheURBy7bDAkp2BCZt+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 16:15:38 +0000
Received: from SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e]) by SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 16:15:38 +0000
From: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
To: Shijith Thotton <sthotton@marvell.com>, "jerinj@marvell.com"
 <jerinj@marvell.com>
CC: "pbhagavatula@marvell.com" <pbhagavatula@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Pathak, Pravin" <pravin.pathak@intel.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, "Mattias
 R_nnblom" <mattias.ronnblom@ericsson.com>, Liang Ma <liangma@liangbit.com>,
 "Mccarthy, Peter" <peter.mccarthy@intel.com>, "Van Haaren, Harry"
 <harry.van.haaren@intel.com>, "Carrillo, Erik G" <erik.g.carrillo@intel.com>, 
 "Gujjar, Abhinandan S" <abhinandan.gujjar@intel.com>, Amit Prakash Shukla
 <amitprakashs@marvell.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: Re: [PATCH 1/3] eventdev/eth_rx: add API to burst add queues to Rx
 adapter
Thread-Topic: [PATCH 1/3] eventdev/eth_rx: add API to burst add queues to Rx
 adapter
Thread-Index: AQHbeWoMB+ePS4d2NESAWuOpKtIhxrNLulAf
Date: Mon, 17 Feb 2025 16:15:38 +0000
Message-ID: <SN7PR11MB7044CD7EEC9FCD8B2993561FA1FB2@SN7PR11MB7044.namprd11.prod.outlook.com>
References: <20250207140910.721374-1-sthotton@marvell.com>
 <20250207140910.721374-2-sthotton@marvell.com>
In-Reply-To: <20250207140910.721374-2-sthotton@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7044:EE_|SJ2PR11MB8500:EE_
x-ms-office365-filtering-correlation-id: 6598d2f2-47b8-4103-a761-08dd4f6e5108
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?InC5hWKBXnva6/n953Q90mwniznNySSV6QCtQkR+SonyB2eA4vSJIB5oKv?=
 =?iso-8859-1?Q?UPEXREGES3hdfs0sSw54FBHiIK/+6zIK/dCxouWTYhF60SCS9+dkDApsZ2?=
 =?iso-8859-1?Q?+mAqZC8OcgVnLgfLV/e8Q8OYLJWfrgK8FBngcsqm7pjVwKltPalVHy6O1J?=
 =?iso-8859-1?Q?kYhwNMRzL1sytWqURQcMQ04ISo82zJpsHf22YJyCNFqyTefN7bijGNm+1V?=
 =?iso-8859-1?Q?dLv0AWAuQWohQxvPLF0R+u8yx+KpzA9guRvGpuqOea/CJs3i9j+A1aBhU3?=
 =?iso-8859-1?Q?C8LxatIvRC03mg4GM0llA8U0DrjvPwMhFEZfynuYHzUd0lnbERyU6DLPVx?=
 =?iso-8859-1?Q?bjJi0jEfobsOySmr9oIFTUQ+aHD0hE1Jl09o87t5ch8oqKL1Oq9Ejgd/fj?=
 =?iso-8859-1?Q?/g4neimxGG3w/6m/YwbMBoS57CORXHUgDMU8Wd/gXVZCXf79vM2VdJ3OSR?=
 =?iso-8859-1?Q?sfY3UnzT5aw+2IHPhx1H3Ah0GZ2CCV7gr9KVxt7rPEQlIG8E5E68Z0bses?=
 =?iso-8859-1?Q?tb/nmeRIkjObD8MJoIVn7T6BU4ThyC3LEaA62lw/WxLPoapWOpG8z72bH1?=
 =?iso-8859-1?Q?j4A7uTE5+g2FJ69l66FyE2t3Rb4/dUc5WikvlN+gX2vVr/DZJ+HADErXos?=
 =?iso-8859-1?Q?OzgJo/lvvf9bLHiB4cR5wWiX7jVCNDJ760MF9KmgrI3PaUMLYk1IbDizs0?=
 =?iso-8859-1?Q?xbVnhM8PUsOQPm2AjTmNCnX8VE7mSkMGdvYdlT3KMZ1FtnjFmP8Z3Oe/Zr?=
 =?iso-8859-1?Q?+wEzVD5C8jTSZkhI9YuKX4oaXXkeAtOdQV54QqKBx0+QrEfwmlgwVIdwLo?=
 =?iso-8859-1?Q?LS6FzJTZLp/abXqUVDeQhacyw+rDuAp4XCsPK2/33AdNUtDUzZpW6iwVfZ?=
 =?iso-8859-1?Q?1tcM3GebEtv3fVXOaor8f9qTsXyVbjceS6skbuUsOmf3cR32nfC57A8FZL?=
 =?iso-8859-1?Q?cb22p0CHapGCf45GHjb+S0R9VzIJuje9b+tQQV7gjnXd90g2ByKZ6GK+Jb?=
 =?iso-8859-1?Q?tlRLbVeZoRtxg5sd6OIonKXLVI9PeFzxT3KDxD3DpugSBD2nIoQQ2J9j80?=
 =?iso-8859-1?Q?I+QjhzRtHsRWtG4cNRiRYjoIGuM5Vv+vu1F8adtyYC3YrAgUueTZxS7TJE?=
 =?iso-8859-1?Q?pb4W7KovyI3I7CFJCh66WUNsm7lgEyUpicEzT5bdtIwGtGXD6aflnm+0Wm?=
 =?iso-8859-1?Q?4NwgJU+6+qB1VW1bT0v3cc/5DdvHnbx6/N39+B2HX9Rk4vpO2XyYFeeHeb?=
 =?iso-8859-1?Q?jqtDsJqXnsnlBmF3i2S4jSlNvKv2O8gv0Oyz0/6+BfDQYq/dlT7FBAz7NW?=
 =?iso-8859-1?Q?mzmd9TG1JL6PY351Rvh+x+nUKq+aAOBxBCwlp/M2sZqOeGZWV6Sp0fiMv1?=
 =?iso-8859-1?Q?aDziaoWipqYGqkIQcCuolj9HHHCJgEBLHz5Gq58Mwo3uuDCr3VjQyJlrHs?=
 =?iso-8859-1?Q?nJzOMd5G2OJyO66Pytl8XFNj99hwW6m2XBQlrnsS0xSquyB3da/CVXPwr0?=
 =?iso-8859-1?Q?j2dszsSwSkYKAjZGVJm92F?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB7044.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6o6uopEXlt99cXqSBbvkelvmguyzByOIbHG+6pJJ05JntLrJWenooo57YH?=
 =?iso-8859-1?Q?yAm6ZcDp0OALF+it2T/JaB61dLdeEjCb7chvRvIHcIip4YhVTGc6jAzZau?=
 =?iso-8859-1?Q?STI1V2D0VNE91/7lg391MyGRgNuyQlcXonZFLdQYskqxPOUZC5W5W+94T4?=
 =?iso-8859-1?Q?FvYo2Pcaf6ZA1E5lGnXlPbipgkgOpXO8yECKWFWsI17naHXgjBRiFMXwSq?=
 =?iso-8859-1?Q?Ae0JLUGQwZNZ5KdDyD3ctRZoS1/YxCqWFGwVhvBpbCaGXpLPK/bvgcI71h?=
 =?iso-8859-1?Q?c7nP7xREi004q9NUSH4pQOlZyEU74J5ohDVD4nPNX66aqh0iH99ZmfObX/?=
 =?iso-8859-1?Q?RuHNciVtIvlE2BQSHRNC9Z/X9pMEB7pw4sh+xHgoFCecUbJFB9LTbjL86N?=
 =?iso-8859-1?Q?5G6wvYxcLlMjo//+cTJVL27CSxPkYLA+jJDoDpXMSyOXNTND74CL1uuFXO?=
 =?iso-8859-1?Q?lkpKkDth5PLuvgREuE0qd3E+jMwOEfPzQi148s7P1SOyT5WcoZg4zRadfU?=
 =?iso-8859-1?Q?IlqiEjVMEWuHhiRqgPDimwlV8XzREbhXSA+J0MpndwmPBKmumtWhT4EBi5?=
 =?iso-8859-1?Q?5TDzvI4gr4ue6uUm1zIgEhSXOw6vsAgdyeUMIIqjk/20XcPh37J5zwvWlv?=
 =?iso-8859-1?Q?5VKev9zZhV6lOvWCej8rmBRxUBx0kF20SFB/eSxY+gLinw0UZ0JC55A8qs?=
 =?iso-8859-1?Q?hmBj5QQtUqsDS0mS5Qxy0gimAK+lYgvVFmZuirxAKKwa7YstWL8nO6z6VC?=
 =?iso-8859-1?Q?ia9xvf2tUvW2+jyF6a+yvr9y8W8GGqRsec4HgL0LIBJBbylBiS7NOMpmmN?=
 =?iso-8859-1?Q?at9ynuhbkyU9XBvlQWvT3rcvpiuJDjNO9TCiEP5nj5YI4H36aoU/XDNlbU?=
 =?iso-8859-1?Q?f+65Yj4CeBypf96d1/QxLEsvfUgQZzVY2Eg931KYaJJGyAF6X8w6IJDA5a?=
 =?iso-8859-1?Q?AhTpU3WouyMR5SpYKSHSmfUILOyk7scCvsld5NwhhtVboMOL4Tznbila3C?=
 =?iso-8859-1?Q?npCGhtFUFVMRWYSKEgwsj8EwwOfrreUtvXNXg6MvGonLkfbMfs1UVSAUXb?=
 =?iso-8859-1?Q?Mj0OABgLZepUX16whD2O8HK/UE/16+E5q3O+TPTMbO6QDFECiFrHTqXwst?=
 =?iso-8859-1?Q?QR99AhGkl8C6NzGNQixziJwxSsdui+tqNMWMYKzy1EfkgGHzlDLQ9yy+ij?=
 =?iso-8859-1?Q?pLpATOtPyz7yv7FCezfxeGi7f08myVQaJRFhv+3LYnSPMvkcLrJ9Gi/F4W?=
 =?iso-8859-1?Q?C/wZpgmUg7i7EQQU4qJwOmR/l2HE1R1Yx+f+DKBbwgIioe4wKcxsh051gc?=
 =?iso-8859-1?Q?n2UFD5iBmSpqzB7TQEZrQ4uQSsn1wiWq2BIGBQwGkV385Ex8HL00kWL7Er?=
 =?iso-8859-1?Q?2gbII8KCP6ET8+O09LPx+O82BM+fRBzgqqgC5iiWD+Qw/N95cAVRjW9dy7?=
 =?iso-8859-1?Q?Y6fsC2cHcJFEO3HNWE0NoUaiW7TSqNhSL1pIED1l9IaXxUTuqnSyoTWN2F?=
 =?iso-8859-1?Q?tMV6iuOtZbVtLFbHBXXeJv/46DXG4DuijxfYGdKzhzjo88nT8dLozPNO/e?=
 =?iso-8859-1?Q?mcYHLkB2qClUSOLbi1aPmvn7F+liiOo/lc7Xq1VUwVyCMyTh15zaS4Lufs?=
 =?iso-8859-1?Q?vzzBwiMMEVFxdSY86a/MFggS97TuVZTQPk?=
Content-Type: multipart/alternative;
 boundary="_000_SN7PR11MB7044CD7EEC9FCD8B2993561FA1FB2SN7PR11MB7044namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7044.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6598d2f2-47b8-4103-a761-08dd4f6e5108
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 16:15:38.0554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUFMGznAZbNP8jEThETJvny1NkL3jXKRKcniMaC0LLMvspGwclmsmz4YPlpXKuFpHcm8QxmW0skdqFTBn59lSreIQfV/8NaOxF0DvE68oek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
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

--_000_SN7PR11MB7044CD7EEC9FCD8B2993561FA1FB2SN7PR11MB7044namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



________________________________
From: Shijith Thotton <sthotton@marvell.com>
Sent: Friday, February 7, 2025 7:39 PM
To: jerinj@marvell.com <jerinj@marvell.com>
Cc: pbhagavatula@marvell.com <pbhagavatula@marvell.com>; Shijith Thotton <s=
thotton@marvell.com>; dev@dpdk.org <dev@dpdk.org>; Pathak, Pravin <pravin.p=
athak@intel.com>; Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena <s=
achin.saxena@nxp.com>; Mattias R_nnblom <mattias.ronnblom@ericsson.com>; Li=
ang Ma <liangma@liangbit.com>; Mccarthy, Peter <Peter.Mccarthy@intel.com>; =
Van Haaren, Harry <harry.van.haaren@intel.com>; Carrillo, Erik G <Erik.G.Ca=
rrillo@intel.com>; Gujjar, Abhinandan S <abhinandan.gujjar@intel.com>; Amit=
 Prakash Shukla <amitprakashs@marvell.com>; Naga Harish K, S V <s.v.naga.ha=
rish.k@intel.com>; Burakov, Anatoly <anatoly.burakov@intel.com>
Subject: [PATCH 1/3] eventdev/eth_rx: add API to burst add queues to Rx ada=
pter

This patch introduces a new API, rte_event_eth_rx_adapter_queues_add(),
to allow bulk addition of multiple Rx queues in the eventdev Rx adapter.

The existing rte_event_eth_rx_adapter_queue_add() API supports adding
multiple queues by specifying rx_queue_id =3D -1, but it lacks the ability
to apply specific configurations to each of the added queues.

A new internal PMD operation, eventdev_eth_rx_adapter_queues_add_t, has
been introduced to enable this functionality. It takes an array of
receive queue IDs along with their corresponding queue configurations.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 lib/eventdev/eventdev_pmd.h             |  34 ++++++
 lib/eventdev/eventdev_trace.h           |  14 +++
 lib/eventdev/eventdev_trace_points.c    |   3 +
 lib/eventdev/rte_event_eth_rx_adapter.c | 146 ++++++++++++++++++++++++
 lib/eventdev/rte_event_eth_rx_adapter.h |  33 ++++++
 lib/eventdev/version.map                |   3 +
 6 files changed, 233 insertions(+)

diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
index 36148f8d86..ad13ba5b03 100644
--- a/lib/eventdev/eventdev_pmd.h
+++ b/lib/eventdev/eventdev_pmd.h
@@ -25,6 +25,7 @@
 #include <rte_mbuf_dyn.h>

 #include "event_timer_adapter_pmd.h"
+#include "rte_event_eth_rx_adapter.h"
 #include "rte_eventdev.h"

 #ifdef __cplusplus
@@ -708,6 +709,37 @@ typedef int (*eventdev_eth_rx_adapter_queue_add_t)(
                 int32_t rx_queue_id,
                 const struct rte_event_eth_rx_adapter_queue_conf *queue_co=
nf);

+/**
+ * Add ethernet Rx queues to event device in burst. This callback is invok=
ed if
+ * the caps returned from rte_eventdev_eth_rx_adapter_caps_get(, eth_port_=
id)
+ * has RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT set.
+ *
+ * @param dev
+ *   Event device pointer
+ *
+ * @param eth_dev
+ *   Ethernet device pointer
+ *
+ * @param rx_queue_id
+ *   Ethernet device receive queue index array
+ *
+ * @param queue_conf
+ *   Additional configuration structure array
+ *
+ * @param nb_rx_queues
+ *   Number of ethernet device receive queues
+ *
+ * @return
+ *   - 0: Success, ethernet receive queues added successfully.
+ *   - <0: Error code returned by the driver function.
+ */
+typedef int (*eventdev_eth_rx_adapter_queues_add_t)(
+               const struct rte_eventdev *dev,
+               const struct rte_eth_dev *eth_dev,
+               int32_t rx_queue_id[],
+               const struct rte_event_eth_rx_adapter_queue_conf queue_conf=
[],
+               uint16_t nb_rx_queues);
+
 /**
  * Delete ethernet Rx queues from event device. This callback is invoked i=
f
  * the caps returned from eventdev_eth_rx_adapter_caps_get(, eth_port_id)
@@ -1578,6 +1610,8 @@ struct eventdev_ops {
         /**< Get ethernet Rx adapter capabilities */
         eventdev_eth_rx_adapter_queue_add_t eth_rx_adapter_queue_add;
         /**< Add Rx queues to ethernet Rx adapter */
+       eventdev_eth_rx_adapter_queues_add_t eth_rx_adapter_queues_add;
+       /**< Add Rx queues to ethernet Rx adapter in burst */
         eventdev_eth_rx_adapter_queue_del_t eth_rx_adapter_queue_del;
         /**< Delete Rx queues from ethernet Rx adapter */
         eventdev_eth_rx_adapter_queue_conf_get_t eth_rx_adapter_queue_conf=
_get;
diff --git a/lib/eventdev/eventdev_trace.h b/lib/eventdev/eventdev_trace.h
index 8ff8841729..6b334d8bd1 100644
--- a/lib/eventdev/eventdev_trace.h
+++ b/lib/eventdev/eventdev_trace.h
@@ -159,6 +159,20 @@ RTE_TRACE_POINT(
         rte_trace_point_emit_int(rc);
 )

+RTE_TRACE_POINT(
+       rte_eventdev_trace_eth_rx_adapter_queues_add,
+       RTE_TRACE_POINT_ARGS(uint8_t adptr_id, uint16_t eth_dev_id,
+               uint16_t nb_rx_queues, void *rx_queue_id,
+               const void *queue_conf,
+               int rc),
+       rte_trace_point_emit_u8(adptr_id);
+       rte_trace_point_emit_u16(eth_dev_id);
+       rte_trace_point_emit_u16(nb_rx_queues);
+       rte_trace_point_emit_ptr(rx_queue_id);
+       rte_trace_point_emit_ptr(queue_conf);
+       rte_trace_point_emit_int(rc);
+)
+
 RTE_TRACE_POINT(
         rte_eventdev_trace_eth_rx_adapter_queue_del,
         RTE_TRACE_POINT_ARGS(uint8_t adptr_id, uint16_t eth_dev_id,
diff --git a/lib/eventdev/eventdev_trace_points.c b/lib/eventdev/eventdev_t=
race_points.c
index e7af1591f7..8caf6353a1 100644
--- a/lib/eventdev/eventdev_trace_points.c
+++ b/lib/eventdev/eventdev_trace_points.c
@@ -65,6 +65,9 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapte=
r_free,
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queue_add,
         lib.eventdev.rx.adapter.queue.add)

+RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queues_add,
+       lib.eventdev.rx.adapter.queues.add)
+
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queue_del,
         lib.eventdev.rx.adapter.queue.del)

diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_eve=
nt_eth_rx_adapter.c
index 39674c4604..c5a357aa85 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -2793,6 +2793,152 @@ rte_event_eth_rx_adapter_queue_add(uint8_t id,
         return 0;
 }

+int
+rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id, int32=
_t rx_queue_id[],
+                                   const struct rte_event_eth_rx_adapter_q=
ueue_conf queue_conf[],
+                                   uint16_t nb_rx_queues)
+{
+       struct rte_event_eth_rx_adapter_vector_limits limits;
+       struct event_eth_rx_adapter *rx_adapter;
+       struct eth_device_info *dev_info;
+       struct rte_eventdev *dev;
+       uint32_t cap;
+       int32_t i;
+       int ret;
+
+       if (rxa_memzone_lookup())
+               return -ENOMEM;
+
+       RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_ERR_RET(id, -EINVAL);
+       RTE_ETH_VALID_PORTID_OR_ERR_RET(eth_dev_id, -EINVAL);
+
+       rx_adapter =3D rxa_id_to_adapter(id);
+       if ((rx_adapter =3D=3D NULL) || (queue_conf =3D=3D NULL))
+               return -EINVAL;
+
+       if (nb_rx_queues && rx_queue_id =3D=3D NULL)
+               return -EINVAL;
+
+       if (nb_rx_queues > rte_eth_devices[eth_dev_id].data->nb_rx_queues) =
{
+               RTE_EDEV_LOG_ERR("Invalid number of rx queues %" PRIu16, nb=
_rx_queues);
+               return -EINVAL;
+       }
+
+       ret =3D rte_event_eth_rx_adapter_caps_get(rx_adapter->eventdev_id, =
eth_dev_id, &cap);
+       if (ret) {
+               RTE_EDEV_LOG_ERR("Failed to get adapter caps edev %" PRIu8 =
"eth port %" PRIu16, id,
+                                eth_dev_id);
+               return ret;
+       }
+
+       for (i =3D 0; i < (nb_rx_queues ? nb_rx_queues : 1); i++) {
+               const struct rte_event_eth_rx_adapter_queue_conf *conf;
+
+               conf =3D &queue_conf[i];
+               if ((cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_OVERRIDE_FLOW_ID) =
=3D=3D 0 &&
+                   (conf->rx_queue_flags & RTE_EVENT_ETH_RX_ADAPTER_QUEUE_=
FLOW_ID_VALID)) {
+                       RTE_EDEV_LOG_ERR("Flow ID override is not supported=
,"
+                                        " eth port: %" PRIu16 " adapter id=
: %" PRIu8,
+                                        eth_dev_id, id);

"rx_queue_id" can also be included in the error debug logs.
Same is applicable to the following debug logs.

+                       return -EINVAL;
+               }
+

RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ validation is missing.

+               if (conf->rx_queue_flags & RTE_EVENT_ETH_RX_ADAPTER_QUEUE_E=
VENT_VECTOR) {
+                       if ((cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_EVENT_VECTO=
R) =3D=3D 0) {
+                               RTE_EDEV_LOG_ERR("Event vectorization is no=
t supported,"
+                                                " eth port: %" PRIu16 " ad=
apter id: %" PRIu8,
+                                                eth_dev_id, id);
+                               return -EINVAL;
+                       }
+
+                       ret =3D rte_event_eth_rx_adapter_vector_limits_get(=
rx_adapter->eventdev_id,
+                                                                        et=
h_dev_id, &limits);
+                       if (ret < 0) {
+                               RTE_EDEV_LOG_ERR("Failed to get event devic=
e vector limits,"
+                                                " eth port: %" PRIu16 " ad=
apter id: %" PRIu8,
+                                                eth_dev_id, id);
+                               return -EINVAL;
+                       }
+
+                       if (conf->vector_sz < limits.min_sz || conf->vector=
_sz > limits.max_sz ||
+                           conf->vector_timeout_ns < limits.min_timeout_ns=
 ||
+                           conf->vector_timeout_ns > limits.max_timeout_ns=
 ||
+                           conf->vector_mp =3D=3D NULL) {
+                               RTE_EDEV_LOG_ERR("Invalid event vector conf=
iguration,"
+                                                " eth port: %" PRIu16 " ad=
apter id: %" PRIu8,
+                                                eth_dev_id, id);
+                               return -EINVAL;
+                       }
+
+                       if (conf->vector_mp->elt_size < (sizeof(struct rte_=
event_vector) +
+                                                        (sizeof(uintptr_t)=
 * conf->vector_sz))) {
+                               RTE_EDEV_LOG_ERR("Invalid event vector conf=
iguration,"
+                                                " eth port: %" PRIu16 " ad=
apter id: %" PRIu8,
+                                                eth_dev_id, id);
+                               return -EINVAL;
+                       }
+               }
+
+               if ((rx_adapter->use_queue_event_buf && conf->event_buf_siz=
e =3D=3D 0) ||
+                   (!rx_adapter->use_queue_event_buf && conf->event_buf_si=
ze !=3D 0)) {
+                       RTE_EDEV_LOG_ERR("Invalid Event buffer size for the=
 queue");
+                       return -EINVAL;
+               }
+       }
+
+       dev =3D &rte_eventdevs[rx_adapter->eventdev_id];
+       dev_info =3D &rx_adapter->eth_devices[eth_dev_id];
+
+       if (cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT) {
+               if (*dev->dev_ops->eth_rx_adapter_queues_add =3D=3D NULL)
+                       return -ENOTSUP;
+
+               if (dev_info->rx_queue =3D=3D NULL) {
+                       dev_info->rx_queue =3D
+                               rte_zmalloc_socket(rx_adapter->mem_name,
+                                                  dev_info->dev->data->nb_=
rx_queues *
+                                                          sizeof(struct et=
h_rx_queue_info),
+                                                  0, rx_adapter->socket_id=
);
+                       if (dev_info->rx_queue =3D=3D NULL)
+                               return -ENOMEM;
+               }
+
+               ret =3D (*dev->dev_ops->eth_rx_adapter_queues_add)(
+                       dev, &rte_eth_devices[eth_dev_id], rx_queue_id, que=
ue_conf, nb_rx_queues);
+               if (ret =3D=3D 0) {
+                       dev_info->internal_event_port =3D 1;
+
+                       if (nb_rx_queues =3D=3D 0)
+                               rxa_update_queue(rx_adapter, dev_info, -1, =
1);
+
+                       for (i =3D 0; i < nb_rx_queues; i++)
+                               rxa_update_queue(rx_adapter, dev_info, rx_q=
ueue_id[i], 1);
+               }
+       } else {
+               rte_spinlock_lock(&rx_adapter->rx_lock);
+               dev_info->internal_event_port =3D 0;
+               ret =3D rxa_init_service(rx_adapter, id);
+               if (ret =3D=3D 0) {
+                       uint32_t service_id =3D rx_adapter->service_id;
+
+                       if (nb_rx_queues =3D=3D 0)
+                               ret =3D rxa_sw_add(rx_adapter, eth_dev_id, =
-1, &queue_conf[0]);
+
+                       for (i =3D 0; i < nb_rx_queues; i++)
+                               ret =3D rxa_sw_add(rx_adapter, eth_dev_id, =
rx_queue_id[i],
+                                                &queue_conf[i]);
+
+                       rte_service_component_runstate_set(service_id,
+                                                          rxa_sw_adapter_q=
ueue_count(rx_adapter));
+               }
+               rte_spinlock_unlock(&rx_adapter->rx_lock);
+       }
+
+       rte_eventdev_trace_eth_rx_adapter_queues_add(id, eth_dev_id, nb_rx_=
queues, rx_queue_id,
+                                                    queue_conf, ret);
+       return ret;
+}
+
 static int
 rxa_sw_vector_limits(struct rte_event_eth_rx_adapter_vector_limits *limits=
)
 {
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.h b/lib/eventdev/rte_eve=
nt_eth_rx_adapter.h
index 9237e198a7..758e1c5f56 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.h
+++ b/lib/eventdev/rte_event_eth_rx_adapter.h
@@ -553,6 +553,39 @@ int rte_event_eth_rx_adapter_queue_add(uint8_t id,
                         int32_t rx_queue_id,
                         const struct rte_event_eth_rx_adapter_queue_conf *=
conf);

+/**
+ * Add multiple receive queues to an event adapter.
+ *
+ * @param id
+ *  Adapter identifier.
+ *
+ * @param eth_dev_id
+ *  Port identifier of Ethernet device.
+ *
+ * @param rx_queue_id
+ *  Array of Ethernet device receive queue indices.
+ *  If nb_rx_queues is 0, then rx_queue_id is ignored.
+ *
+ * @param conf
+ *  Array of additional configuration structures of type
+ *  *rte_event_eth_rx_adapter_queue_conf*. conf[i] is used for rx_queue_id=
[i].
+ *  If nb_rx_queues is 0, then conf[0] is used for all Rx queues.
+ *
+ * @param nb_rx_queues
+ *  Number of receive queues to add.
+ *  If nb_rx_queues is 0, then all Rx queues configured for
+ *  the device are added with the same configuration in conf[0].
+ * @see RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ
+ *
+ * @return
+ *  - 0: Success, Receive queues added correctly.
+ *  - <0: Error code on failure.
+ */
+__rte_experimental
+int rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id, i=
nt32_t rx_queue_id[],
+                                       const struct rte_event_eth_rx_adapt=
er_queue_conf conf[],
+                                       uint16_t nb_rx_queues);
+
 /**
  * Delete receive queue from an event adapter.
  *
diff --git a/lib/eventdev/version.map b/lib/eventdev/version.map
index 42a5867aba..44687255cb 100644
--- a/lib/eventdev/version.map
+++ b/lib/eventdev/version.map
@@ -153,6 +153,9 @@ EXPERIMENTAL {
         __rte_eventdev_trace_port_preschedule_modify;
         rte_event_port_preschedule;
         __rte_eventdev_trace_port_preschedule;
+
+       # added in 25.03
+       rte_event_eth_rx_adapter_queues_add;
 };

 INTERNAL {
--
2.25.1


--_000_SN7PR11MB7044CD7EEC9FCD8B2993561FA1FB2SN7PR11MB7044namp_
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
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Shijit=
h Thotton &lt;sthotton@marvell.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, February 7, 2025 7:39 PM<br>
<b>To:</b>&nbsp;jerinj@marvell.com &lt;jerinj@marvell.com&gt;<br>
<b>Cc:</b>&nbsp;pbhagavatula@marvell.com &lt;pbhagavatula@marvell.com&gt;; =
Shijith Thotton &lt;sthotton@marvell.com&gt;; dev@dpdk.org &lt;dev@dpdk.org=
&gt;; Pathak, Pravin &lt;pravin.pathak@intel.com&gt;; Hemant Agrawal &lt;he=
mant.agrawal@nxp.com&gt;; Sachin Saxena &lt;sachin.saxena@nxp.com&gt;; Matt=
ias
 R_nnblom &lt;mattias.ronnblom@ericsson.com&gt;; Liang Ma &lt;liangma@liang=
bit.com&gt;; Mccarthy, Peter &lt;Peter.Mccarthy@intel.com&gt;; Van Haaren, =
Harry &lt;harry.van.haaren@intel.com&gt;; Carrillo, Erik G &lt;Erik.G.Carri=
llo@intel.com&gt;; Gujjar, Abhinandan S &lt;abhinandan.gujjar@intel.com&gt;=
;
 Amit Prakash Shukla &lt;amitprakashs@marvell.com&gt;; Naga Harish K, S V &=
lt;s.v.naga.harish.k@intel.com&gt;; Burakov, Anatoly &lt;anatoly.burakov@in=
tel.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH 1/3] eventdev/eth_rx: add API to burst add queu=
es to Rx adapter</span>
<div>&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">This patch introdu=
ces a new API, rte_event_eth_rx_adapter_queues_add(),<br>
to allow bulk addition of multiple Rx queues in the eventdev Rx adapter.<br=
>
<br>
The existing rte_event_eth_rx_adapter_queue_add() API supports adding<br>
multiple queues by specifying rx_queue_id =3D -1, but it lacks the ability<=
br>
to apply specific configurations to each of the added queues.<br>
<br>
A new internal PMD operation, eventdev_eth_rx_adapter_queues_add_t, has<br>
been introduced to enable this functionality. It takes an array of<br>
receive queue IDs along with their corresponding queue configurations.<br>
<br>
Signed-off-by: Shijith Thotton &lt;sthotton@marvell.com&gt;<br>
---<br>
&nbsp;lib/eventdev/eventdev_pmd.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 34 ++++++<br>
&nbsp;lib/eventdev/eventdev_trace.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; |&nbsp; 14 +++<br>
&nbsp;lib/eventdev/eventdev_trace_points.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; =
3 +<br>
&nbsp;lib/eventdev/rte_event_eth_rx_adapter.c | 146 +++++++++++++++++++++++=
+<br>
&nbsp;lib/eventdev/rte_event_eth_rx_adapter.h |&nbsp; 33 ++++++<br>
&nbsp;lib/eventdev/version.map&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&nbsp;6 files changed, 233 insertions(+)<br>
<br>
diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h<br>
index 36148f8d86..ad13ba5b03 100644<br>
--- a/lib/eventdev/eventdev_pmd.h<br>
+++ b/lib/eventdev/eventdev_pmd.h<br>
@@ -25,6 +25,7 @@<br>
&nbsp;#include &lt;rte_mbuf_dyn.h&gt;<br>
&nbsp;<br>
&nbsp;#include &quot;event_timer_adapter_pmd.h&quot;<br>
+#include &quot;rte_event_eth_rx_adapter.h&quot;<br>
&nbsp;#include &quot;rte_eventdev.h&quot;<br>
&nbsp;<br>
&nbsp;#ifdef __cplusplus<br>
@@ -708,6 +709,37 @@ typedef int (*eventdev_eth_rx_adapter_queue_add_t)(<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int32_t rx_queue_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const struct rte_event_eth_rx_adapter_queue_conf *que=
ue_conf);<br>
&nbsp;<br>
+/**<br>
+ * Add ethernet Rx queues to event device in burst. This callback is invok=
ed if<br>
+ * the caps returned from rte_eventdev_eth_rx_adapter_caps_get(, eth_port_=
id)<br>
+ * has RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT set.<br>
+ *<br>
+ * @param dev<br>
+ *&nbsp;&nbsp; Event device pointer<br>
+ *<br>
+ * @param eth_dev<br>
+ *&nbsp;&nbsp; Ethernet device pointer<br>
+ *<br>
+ * @param rx_queue_id<br>
+ *&nbsp;&nbsp; Ethernet device receive queue index array<br>
+ *<br>
+ * @param queue_conf<br>
+ *&nbsp;&nbsp; Additional configuration structure array<br>
+ *<br>
+ * @param nb_rx_queues<br>
+ *&nbsp;&nbsp; Number of ethernet device receive queues<br>
+ *<br>
+ * @return<br>
+ *&nbsp;&nbsp; - 0: Success, ethernet receive queues added successfully.<b=
r>
+ *&nbsp;&nbsp; - &lt;0: Error code returned by the driver function.<br>
+ */<br>
+typedef int (*eventdev_eth_rx_adapter_queues_add_t)(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct rte_eventdev *dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct rte_eth_dev *eth_dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int32_t rx_queue_id[],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct rte_event_eth_rx_adapter_queue_conf queue_conf[],<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint16_t nb_rx_queues);<br>
+<br>
&nbsp;/**<br>
&nbsp; * Delete ethernet Rx queues from event device. This callback is invo=
ked if<br>
&nbsp; * the caps returned from eventdev_eth_rx_adapter_caps_get(, eth_port=
_id)<br>
@@ -1578,6 +1610,8 @@ struct eventdev_ops {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Get ethernet Rx ad=
apter capabilities */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eventdev_eth_rx_adapter_qu=
eue_add_t eth_rx_adapter_queue_add;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Add Rx queues to e=
thernet Rx adapter */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eventdev_eth_rx_adapter_queues_add_t =
eth_rx_adapter_queues_add;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Add Rx queues to ethernet Rx =
adapter in burst */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eventdev_eth_rx_adapter_qu=
eue_del_t eth_rx_adapter_queue_del;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Delete Rx queues f=
rom ethernet Rx adapter */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eventdev_eth_rx_adapter_qu=
eue_conf_get_t eth_rx_adapter_queue_conf_get;<br>
diff --git a/lib/eventdev/eventdev_trace.h b/lib/eventdev/eventdev_trace.h<=
br>
index 8ff8841729..6b334d8bd1 100644<br>
--- a/lib/eventdev/eventdev_trace.h<br>
+++ b/lib/eventdev/eventdev_trace.h<br>
@@ -159,6 +159,20 @@ RTE_TRACE_POINT(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_trace_point_emit_int(r=
c);<br>
&nbsp;)<br>
&nbsp;<br>
+RTE_TRACE_POINT(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_eventdev_trace_eth_rx_adapter_que=
ues_add,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_TRACE_POINT_ARGS(uint8_t adptr_id=
, uint16_t eth_dev_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint16_t nb_rx_queues, void *rx_queue_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const void *queue_conf,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int rc),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_trace_point_emit_u8(adptr_id);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_trace_point_emit_u16(eth_dev_id);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_trace_point_emit_u16(nb_rx_queues=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_trace_point_emit_ptr(rx_queue_id)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_trace_point_emit_ptr(queue_conf);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_trace_point_emit_int(rc);<br>
+)<br>
+<br>
&nbsp;RTE_TRACE_POINT(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_eventdev_trace_eth_rx_=
adapter_queue_del,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_TRACE_POINT_ARGS(uint8=
_t adptr_id, uint16_t eth_dev_id,<br>
diff --git a/lib/eventdev/eventdev_trace_points.c b/lib/eventdev/eventdev_t=
race_points.c<br>
index e7af1591f7..8caf6353a1 100644<br>
--- a/lib/eventdev/eventdev_trace_points.c<br>
+++ b/lib/eventdev/eventdev_trace_points.c<br>
@@ -65,6 +65,9 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapte=
r_free,<br>
&nbsp;RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queue_add,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lib.eventdev.rx.adapter.qu=
eue.add)<br>
&nbsp;<br>
+RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queues_add,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lib.eventdev.rx.adapter.queues.add)<b=
r>
+<br>
&nbsp;RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queue_del,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lib.eventdev.rx.adapter.qu=
eue.del)<br>
&nbsp;<br>
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_eve=
nt_eth_rx_adapter.c<br>
index 39674c4604..c5a357aa85 100644<br>
--- a/lib/eventdev/rte_event_eth_rx_adapter.c<br>
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c<br>
@@ -2793,6 +2793,152 @@ rte_event_eth_rx_adapter_queue_add(uint8_t id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+int<br>
+rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id, int32=
_t rx_queue_id[],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rte_ev=
ent_eth_rx_adapter_queue_conf queue_conf[],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t nb_rx_queu=
es)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_event_eth_rx_adapter_vecto=
r_limits limits;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct event_eth_rx_adapter *rx_adapt=
er;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_device_info *dev_info;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eventdev *dev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cap;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rxa_memzone_lookup())<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_=
ERR_RET(id, -EINVAL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETH_VALID_PORTID_OR_ERR_RET(eth_d=
ev_id, -EINVAL);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_adapter =3D rxa_id_to_adapter(id);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((rx_adapter =3D=3D NULL) || (queu=
e_conf =3D=3D NULL))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nb_rx_queues &amp;&amp; rx_queue_=
id =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nb_rx_queues &gt; rte_eth_devices=
[eth_dev_id].data-&gt;nb_rx_queues) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_EDEV_LOG_ERR(&quot;Invalid number of rx queues %&quot; PRIu1=
6, nb_rx_queues);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_event_eth_rx_adapter_caps=
_get(rx_adapter-&gt;eventdev_id, eth_dev_id, &amp;cap);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_EDEV_LOG_ERR(&quot;Failed to get adapter caps edev %&quot; P=
RIu8 &quot;eth port %&quot; PRIu16, id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_dev_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; (nb_rx_queues ? =
nb_rx_queues : 1); i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct rte_event_eth_rx_adapter_queue_conf *conf;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; conf =3D &amp;queue_conf[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((cap &amp; RTE_EVENT_ETH_RX_ADAPTER_CAP_OVERRIDE_FLOW_ID) =
=3D=3D 0 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (conf-&gt;rx_queue_flags &amp; RTE_EVENT=
_ETH_RX_ADAPTER_QUEUE_FLOW_ID_VALID)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_EDEV_LOG_ERR=
(&quot;Flow ID override is not supported,&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &quot; eth port: %&quot; PRIu16 &quot; adapter id: %&quot; PRIu8=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; eth_dev_id, id);</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&quot;rx_queue_id&=
quot; can also be included in the error debug logs.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt; color: rgb(0, 0, 0)=
;">Same is applicable&nbsp;to the following debug logs.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt; color: rgb(0, 0, 0)=
;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt; color: rgb(0, 0, 0)=
;">RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ validation is missing.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt; color: rgb(0, 0, 0)=
;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (con=
f-&gt;rx_queue_flags &amp; RTE_EVENT_ETH_RX_ADAPTER_QUEUE_EVENT_VECTOR) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((cap &amp; R=
TE_EVENT_ETH_RX_ADAPTER_CAP_EVENT_VECTOR) =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_EDEV_LOG_ERR(&quot;Event vectorization =
is not supported,&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; eth port:=
 %&quot; PRIu16 &quot; adapter id: %&quot; PRIu8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_dev_id, id);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_even=
t_eth_rx_adapter_vector_limits_get(rx_adapter-&gt;eventdev_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_dev_id, &amp;limit=
s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_EDEV_LOG_ERR(&quot;Failed to get event =
device vector limits,&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; eth port:=
 %&quot; PRIu16 &quot; adapter id: %&quot; PRIu8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_dev_id, id);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (conf-&gt;vec=
tor_sz &lt; limits.min_sz || conf-&gt;vector_sz &gt; limits.max_sz ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; conf-&gt;vector_timeout_ns &lt; limits.min_timeout_ns ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; conf-&gt;vector_timeout_ns &gt; limits.max_timeout_ns ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; conf-&gt;vector_mp =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_EDEV_LOG_ERR(&quot;Invalid event vector=
 configuration,&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; eth port:=
 %&quot; PRIu16 &quot; adapter id: %&quot; PRIu8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_dev_id, id);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (conf-&gt;vec=
tor_mp-&gt;elt_size &lt; (sizeof(struct rte_event_vector) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (sizeof(uintptr_t) * conf-&gt;vector_sz))) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_EDEV_LOG_ERR(&quot;Invalid event vector=
 configuration,&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; eth port:=
 %&quot; PRIu16 &quot; adapter id: %&quot; PRIu8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_dev_id, id);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((rx_adapter-&gt;use_queue_event_buf &amp;&amp; conf-&gt;even=
t_buf_size =3D=3D 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!rx_adapter-&gt;use_queue_event_buf &am=
p;&amp; conf-&gt;event_buf_size !=3D 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_EDEV_LOG_ERR=
(&quot;Invalid Event buffer size for the queue&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev =3D &amp;rte_eventdevs[rx_adapter=
-&gt;eventdev_id];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info =3D &amp;rx_adapter-&gt;eth_=
devices[eth_dev_id];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cap &amp; RTE_EVENT_ETH_RX_ADAPTE=
R_CAP_INTERNAL_PORT) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (*dev-&gt;dev_ops-&gt;eth_rx_adapter_queues_add =3D=3D NULL)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOTSUP;=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dev_info-&gt;rx_queue =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info-&gt;rx_=
queue =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_zmalloc_socket(rx_adapter-&gt;mem_name,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_=
info-&gt;dev-&gt;data-&gt;nb_rx_queues *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct eth_rx_queue_info=
),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, r=
x_adapter-&gt;socket_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev_info-&gt=
;rx_queue =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D (*dev-&gt;dev_ops-&gt;eth_rx_adapter_queues_add)(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev, &amp;rte_et=
h_devices[eth_dev_id], rx_queue_id, queue_conf, nb_rx_queues);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info-&gt;int=
ernal_event_port =3D 1;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nb_rx_queues=
 =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxa_update_queue(rx_adapter, dev_info, -1, =
1);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; nb_rx_queues; i++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxa_update_queue(rx_adapter, dev_info, rx_q=
ueue_id[i], 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rte_spinlock_lock(&amp;rx_adapter-&gt;rx_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info-&gt;internal_event_port =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D rxa_init_service(rx_adapter, id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t service=
_id =3D rx_adapter-&gt;service_id;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nb_rx_queues=
 =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rxa_sw_add(rx_adapter, eth_dev_id, =
-1, &amp;queue_conf[0]);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; nb_rx_queues; i++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rxa_sw_add(rx_adapter, eth_dev_id, =
rx_queue_id[i],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;queue_conf[=
i]);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_service_comp=
onent_runstate_set(service_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxa_sw_adapter_queue_count(rx_a=
dapter));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rte_spinlock_unlock(&amp;rx_adapter-&gt;rx_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_eventdev_trace_eth_rx_adapter_que=
ues_add(id, eth_dev_id, nb_rx_queues, rx_queue_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; queue_conf, ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;static int<br>
&nbsp;rxa_sw_vector_limits(struct rte_event_eth_rx_adapter_vector_limits *l=
imits)<br>
&nbsp;{<br>
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.h b/lib/eventdev/rte_eve=
nt_eth_rx_adapter.h<br>
index 9237e198a7..758e1c5f56 100644<br>
--- a/lib/eventdev/rte_event_eth_rx_adapter.h<br>
+++ b/lib/eventdev/rte_event_eth_rx_adapter.h<br>
@@ -553,6 +553,39 @@ int rte_event_eth_rx_adapter_queue_add(uint8_t id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32=
_t rx_queue_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const=
 struct rte_event_eth_rx_adapter_queue_conf *conf);<br>
&nbsp;<br>
+/**<br>
+ * Add multiple receive queues to an event adapter.<br>
+ *<br>
+ * @param id<br>
+ *&nbsp; Adapter identifier.<br>
+ *<br>
+ * @param eth_dev_id<br>
+ *&nbsp; Port identifier of Ethernet device.<br>
+ *<br>
+ * @param rx_queue_id<br>
+ *&nbsp; Array of Ethernet device receive queue indices.<br>
+ *&nbsp; If nb_rx_queues is 0, then rx_queue_id is ignored.<br>
+ *<br>
+ * @param conf<br>
+ *&nbsp; Array of additional configuration structures of type<br>
+ *&nbsp; *rte_event_eth_rx_adapter_queue_conf*. conf[i] is used for rx_que=
ue_id[i].<br>
+ *&nbsp; If nb_rx_queues is 0, then conf[0] is used for all Rx queues.<br>
+ *<br>
+ * @param nb_rx_queues<br>
+ *&nbsp; Number of receive queues to add.<br>
+ *&nbsp; If nb_rx_queues is 0, then all Rx queues configured for<br>
+ *&nbsp; the device are added with the same configuration in conf[0].<br>
+ * @see RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ<br>
+ *<br>
+ * @return<br>
+ *&nbsp; - 0: Success, Receive queues added correctly.<br>
+ *&nbsp; - &lt;0: Error code on failure.<br>
+ */<br>
+__rte_experimental<br>
+int rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id, i=
nt32_t rx_queue_id[],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; const struct rte_event_eth_rx_adapter_queue_conf conf[],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint16_t nb_rx_queues);<br>
+<br>
&nbsp;/**<br>
&nbsp; * Delete receive queue from an event adapter.<br>
&nbsp; *<br>
diff --git a/lib/eventdev/version.map b/lib/eventdev/version.map<br>
index 42a5867aba..44687255cb 100644<br>
--- a/lib/eventdev/version.map<br>
+++ b/lib/eventdev/version.map<br>
@@ -153,6 +153,9 @@ EXPERIMENTAL {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __rte_eventdev_trace_port_=
preschedule_modify;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_event_port_preschedule=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __rte_eventdev_trace_port_=
preschedule;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # added in 25.03<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_event_eth_rx_adapter_queues_add;<=
br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;INTERNAL {<br>
--<br>
2.25.1<br>
<br>
</div>
</body>
</html>

--_000_SN7PR11MB7044CD7EEC9FCD8B2993561FA1FB2SN7PR11MB7044namp_--
