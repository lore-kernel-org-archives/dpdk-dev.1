Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD226C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 12:06:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76EA240269;
	Mon, 17 Aug 2026 14:06:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6AB674021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 14:06:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786968404; x=1818504404;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YvI4EoBs513jnm5pKhFfTFeK8Ud1T4D9CXWdo1Okznc=;
 b=j/pBCXDinXcPRiN8QWYkV0N723SCFPo2LUnheWJDe2h4uTrpsEwiIJZG
 GcvvOFbVPibjcHfVEXps84EyB3ZoG/JM2VA5pUAjfgLLuDl4DO4pOigNd
 t9buRk5LTq5Hz7DXS37H8OpWL8etIoIQB+D1BF1m3pbS/D5A7+1EcvOYn
 OGqzLa+6H7EtV46nhggrxuXepBmR0rmrXd/9ak3RHhVq4TWY5dGhFI1CX
 J5gVCJlMpoEkeWVmRYItrXjuYKMpopTaFLlGiaJn7uKTe4afg2nVCunH8
 AFavRh7xiLnUEfyiHd80yRSU7H3F1r9oXqrDkZuHCT3P2rULmNYcDu+6D g==;
X-CSE-ConnectionGUID: NxolTlyETKWB+79SPMJ5nA==
X-CSE-MsgGUID: PJIs5Bd5QPmVWtz+FCaNBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87359465"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="87359465"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 05:06:43 -0700
X-CSE-ConnectionGUID: 4BFYz7kLTfmJGVtQGCb5jg==
X-CSE-MsgGUID: S6qfabczRnCd3uGXNvg7lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="303133844"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 05:06:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 05:06:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 05:06:41 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 05:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzb167QT6psXe8pp9AtitbaWyXHGecZJ4zguFX/68kXoFxhPZhzZoF2IaLupX6NBHIUdkanr/sIjbtFgOpG+Kuj+DBxX2+jShVrImX5DWgsRU1pBDoQDc2IxzLx+T6vzoZYYuX1H+uyxLE8uBt8Qe5Hv/Y8sJPThegjMVSdnvhkuDRzC8HAecW8vYaMO57uwfEDSOjVe+5/Zh9IXeaaOgz+/DKdGiQ8/f/TI3s699/WRXHEyTkexOZ/M4GIugu6KIk8SqvzfvZ06hDMoXCaYSnNXJQWHW+jd9LF4toHLCEIMsCPwMZ93cG705Sox1C6I6JFHbMPVZarnipV6Xsqc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvI4EoBs513jnm5pKhFfTFeK8Ud1T4D9CXWdo1Okznc=;
 b=Qq5832PCiKlu67wNKUSZJF+g7oplfnKHBYZfPVa3bQAK4OuGVZwne2/YXQqMlPFe+n8FDUhotgpRW0X4534s9sjsGl1jZissQfb0edDSMGMtn5svBkDoNJj5NyRF3BVdCOKzyynVAzEDip+nCTjYY1nGbX8z8yUtPFNST4IWyPO9ycbCd5qXd8VwYzRGl/NFeyIVBybye1omac+vVZVu32ZnA+3pnyvvfMRCQkJPkB15BjNGv2UhimlEckcqvvmr1iFBLSi7lu9lBDirTHPxwJfZm07Ji9lUVJ/HSwtt43wqcV86TKHrAbANUgwSe51p97in0Nve4XrF2pu2kUIfng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SAWPR11MB9921.namprd11.prod.outlook.com (2603:10b6:806:54a::6)
 by SABPR11MB9964.namprd11.prod.outlook.com (2603:10b6:806:50c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 12:06:21 +0000
Received: from SAWPR11MB9921.namprd11.prod.outlook.com
 ([fe80::b0a7:e363:c80e:7ed8]) by SAWPR11MB9921.namprd11.prod.outlook.com
 ([fe80::b0a7:e363:c80e:7ed8%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:06:21 +0000
From: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [PATCH v2] crypto/ipsec_mb: require minimum version 2.0 for IPsec
 MB
Thread-Topic: [PATCH v2] crypto/ipsec_mb: require minimum version 2.0 for
 IPsec MB
Thread-Index: AQHdLixoYXrPs2xyrkyYrG7Ih6x7L7aiJSgQ
Date: Mon, 17 Aug 2026 12:06:21 +0000
Message-ID: <SAWPR11MB992100DA82CA3158F0D374C184A72@SAWPR11MB9921.namprd11.prod.outlook.com>
References: <20260811112636.4106950-1-radu.nicolau@intel.com>
 <20260817093934.139988-1-radu.nicolau@intel.com>
In-Reply-To: <20260817093934.139988-1-radu.nicolau@intel.com>
Accept-Language: en-US, en-IE, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR11MB9921:EE_|SABPR11MB9964:EE_
x-ms-office365-filtering-correlation-id: da516f33-1a32-41f9-cd71-08defc57f3ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: muAKpj3Huk6Pg+XvKhAwcYTR5BbUHQHr1O2Bp4YHdTBdD9yiNC27b+oJwBMXqaKMnxbH+8EKbJzjiV2qh0OjEYVTwepRkfLgMj4W4x71bZjQLUnOP1sdMf4nXgZL7sNAyJ/wH3BHb0tnwWwvXiCzdCXA+3FggzXCDHMqhtFVTpi9X0StSNLwWQWxRSvhAKNnMPaq5AxcZTNXEPLBLlutLTVQ+2cKP3Nndzkv+/NkVN8zOMMQqw+corF1I3KSavOAV72GLv0JOacVOuuslYdvr481vmXvqUzTwZchrHW0XKBS/M0epfkVz8VzrsQxpKOjmZ6PGvDs0zmTRULmj9mFFhXy7ery5sUSAFbxO5USd3165ozHinyRW2j4kwj7TUpvd8A3CtcuPawmJK8CRsj5VogLha6HRj06hS78fkKwBPxeu9Fh5GesCwH8qae81KdvDM44h9LzFumCfK4WJU6SLIttsfIFvi6qgSfKZbVeMpWrHvfJY8VLJwTuRU10X5IXCy/QNO3iOTM7g6tnytqv7SNYW4MZ8SahnXEDcw3g9DQT+CP9wP0c+edJSbjrgnTwuwjNiWYqL//EFIt3ZsspaSb+LqSWax+Rqp7cVS3z3Ka85ZPoL6HQNVRA/62xjxR+ztpJtIl5yIMQoVYEDTVVHuK0nkGlw6ztaAyUH5fLzpNIOfBoM/acGU6QsTJce+wYqLRdXhSw8Ryr8ccajFrzdIfy+lGYp6Ao2jcBEEctzyI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SAWPR11MB9921.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ifKPIFrMg3tRkhTc1DOh45GtxXOTOqiYaaxqOKr2lwj77/nCW8rwSlgFv5WK?=
 =?us-ascii?Q?P8YEbrLmdq4dotT7PuN6rkq6iZtAu9kFvCgjrE5b0Q9POhXiLrrPBJxjWXNz?=
 =?us-ascii?Q?u6BfEYxx5hDTqYCEy2ehbOFhGo/ihospx50K5rK67hDxaYZSX5AVsN1rQw2o?=
 =?us-ascii?Q?lUGMMr7FxmFNnbDwDxZqzfkulprgEOl+M0gGSbjVsilzPeuq8PiEOCG02akp?=
 =?us-ascii?Q?D8a6XhjymdD4wvtC8cCtwAkPOIdeEZ2r4KY+5o8X0M27UHiIS8BVlgLdc6fd?=
 =?us-ascii?Q?/u8qKpMTjZK2Om9J1dAecYmNpWfwIld0v9wSzoIl3JVENdLjWd9pPP9zisxH?=
 =?us-ascii?Q?ctbJjCErlauIUoEeUt1Kt0NP9mXkWu1EroWNFTVvLbSWvnPC7gpwgsXO6qsZ?=
 =?us-ascii?Q?9nPLqySUr2dH58wVr0z6pA+km5oiObNnmNglA6vWDWdnBBLXwZDyFLEaI2VW?=
 =?us-ascii?Q?NyjRcN6MADS5hZ+44tslCKL96oRBVzqIdvh+pIfaEW1T8gJyTLpOGQsLiVlc?=
 =?us-ascii?Q?LQjnlc/e4O+8RPDFsJemcuTPl4elFetRP3RsBCP7ETuIwPaxG+jmafJsMpLT?=
 =?us-ascii?Q?iK3iODpQG2hHzjl/m/jMR1KZR7aMftxdP/m8dXhFQvms5eK5U1nFd9fkY2a1?=
 =?us-ascii?Q?RIYOdcbX22F+AkstRPhWTB385+bkApI9fse9Ruk/5nLyTco8sNgZYAR/ZBW2?=
 =?us-ascii?Q?qyxq0uoi7ptIes9WlxDzeBCOtuzbRM/CKtuWNT0y8tE3WM/vypY374LrxvkJ?=
 =?us-ascii?Q?ZIFz+GrC+pknB6NTOVbDIiZRL993zbOlDuGLh9QfWFmUUTXcoMr9h7O98r9E?=
 =?us-ascii?Q?06aIZo50pQQv071RPwPWjGmD5BFzplFx4vQUeplX/yBMegCsy69CQ67KnE33?=
 =?us-ascii?Q?iYnvUMq8vC+JRlV+PDlKq5HQu2USeFaiZ/3w7XcUbCQfrf3zkJVOSYUh2hKJ?=
 =?us-ascii?Q?qPMoDmepu3m62x9QZ2ZyETQ452ZwgMbCsKEUh9XodYpgGJrREHzgdVjy0Cro?=
 =?us-ascii?Q?bAu4E2Mra7q4gq5XEIInVYDRqGRIcZy8YTFa2AzGGwTjXH4opsJL+mSxSvNC?=
 =?us-ascii?Q?PTGbpMupmQlGSC/uFtTBqsDJu0TjA9IaRItNNgRlbmVRBP70W4G8Rnwj1gOe?=
 =?us-ascii?Q?NaktU8rYOm9R5vttoPjvnfvCQCAwHYuzYG2IC9A8poamxMY0M2K3iAAIOl3g?=
 =?us-ascii?Q?h4Na6azaRY1C4Uey5Fq6KFTfk3dSdRqjaLu2CS27TWORFBmMlmGCK0xhiUbp?=
 =?us-ascii?Q?yV17FPHEU8+LVag9Y4GqTwv3LizSzNe8jw6n9Mc98zh0MRSdo8kRMB+BLmL6?=
 =?us-ascii?Q?IHBtoP/Hk+YYXBYjDGrnOInBLAsds3o/1YV7fFJtMWmVarYWnAYJ3h/x1nE8?=
 =?us-ascii?Q?9DYOVLdQcDsghLQ487mkpz+xzKnQPCQsGQayybjCU2aFoKhQhtZ21CFfQc9+?=
 =?us-ascii?Q?MPqf7iJgt8lAG7JuPWwm08t6xrpl81Tv8h4J5d2muNzSJ/J78aallIcoozhR?=
 =?us-ascii?Q?rj/h8jlCBWBt5WDoL9PAeb5NAdlX1pFXHpac9MADXXeCN8VDuf6B3XsRcnRg?=
 =?us-ascii?Q?w2VHG0WKXrmz938/K061zTGjW5wgkzMAeAhy+LcStWKySo2Co2anWBsWgkSx?=
 =?us-ascii?Q?GuofUX/cCSPfXk/pyYsva2zOEXzZvy839FrqCV09LecgSE0aBZdWQbitQzrb?=
 =?us-ascii?Q?9gvWG/EiTJzI7HI/qCcixk2IQOXjU3ZVj0CSNqfoI2mlFFpzLC596hplGi29?=
 =?us-ascii?Q?H9Qg71TAL/1RLuis5xafQgLTUuuDfTI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: shgi6O/4qJLr11OeSgZoOm2q/IhZ/SE+KXZOem6Dlv1uziy80c1ZpoLppsk6SlH+tcEcA9mUuhLNoR/ljEcJO1i24OGEoZOXr70m8X71V+Z5KRMuRB2CsXYwfUOdtl5d8capUSYhqvWQ3aMofjj4KOeirOiKzNgNcM0MGO+CkIo+/fH6Lk+k58M3LlBdyhKHy739ic5MdHouHZoZp4+cYubsf7xKjpC8ArLrXQJn7m8f10BMzUicTH9nzLDBdV9SmvVCAnD3RkgElBk3gMes6kXIoA465f80iKqPMLkm/gT0MeDPwk0Boa/M+NSNIVOLrH7DQR3nMlMSEzw9YHglYA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR11MB9921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da516f33-1a32-41f9-cd71-08defc57f3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 12:06:21.3539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvuW0ncEH5X6YhGER0LP+ti3x4BBQumYJfGY/LKyJ/BumvEzxCEQ44GX1GWGlJBG6SER9+ahUesMlJuQ79xe9qqM7yphtnnOshlJzvwtB9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9964
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

> -----Original Message-----
> From: Nicolau, Radu <radu.nicolau@intel.com>
> Sent: Monday, August 17, 2026 10:39 AM
> To: dev@dpdk.org
> Cc: Nicolau, Radu <radu.nicolau@intel.com>; Ji, Kai <kai.ji@intel.com>; D=
e
> Lara Guarch, Pablo <pablo.de.lara.guarch@intel.com>
> Subject: [PATCH v2] crypto/ipsec_mb: require minimum version 2.0 for IPse=
c
> MB
>=20
> Increase the minimum required IPsec MB library version to 2.0 As a
> consequence, clean up the aesni_mb PMD code.
>=20
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>

Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
