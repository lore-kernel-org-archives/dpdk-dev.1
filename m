Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FE7CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 09:37:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 503374042C;
	Tue, 13 Oct 2026 11:37:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B307E400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 11:37:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791884265; x=1823420265;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/dd5goPcQdjSnv87WX+hzW3Mn3QWhui2F/RA9TkOCOQ=;
 b=TH/L0kOl86eUnHm5uKpn8JMfiJbywjW5cThAbsd1zhlPwOqup7NsDTUN
 ZDZ6epCoq0lIYhDl+v1lP/jHLFfg9gtAXA2g/W/Ikij2CVwkiAnlN38F1
 k463q1EG84dkbHy38eUOzj8NStxPqK7OLzMMlnXeh2UiNGJhKgEdz3Hbo
 M3FMXTKyMVVwS8aJ4x3PLSsIDr+QWQ7lbhTCzx0xa2WYN7uTutNyyGFGo
 k17626VxMSCHwxtDKlvvq+E37iLnU59mGvtJX4LV0Rx2lM3/o7Tnh+o7F
 hJ4NM6GZM7EAQpluaEMid/XQrWeySVZ8QCKq2kn2wfYMFIMftnHYRpVJ2 w==;
X-CSE-ConnectionGUID: 2CsENLLFRz6iM+TeAC6PVA==
X-CSE-MsgGUID: 6euuNi+jRRi4ihJr+VS9Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="607886"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="607886"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:37:06 -0700
X-CSE-ConnectionGUID: nE3nvJJ9RViWF8wV8UU1PQ==
X-CSE-MsgGUID: 7GrHLQRaQz+y/fmwwfO4Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2895536"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:37:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 02:37:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 02:37:04 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 02:37:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uxuv7Bw2y9odTiTFcJbzHMrPnRq/d8thKOdYfQLSkEbYxUmKxswadO8OUXTGXc9sR9v2LIC4Nuy/kvN0pL2fDifSTCpHdcofwGE1GWW+qJ050NZvV2Q0CuZNeDeOEPIFd+UtpRoq5tXcDSRfj/uMMumValvdGLMOnM/xKxAcZti2Q/a67kxlwzHmv0qrCpEmwI+ehkuth4+wPNpiDgIdYkbalIDr0pZamnTY02aYMe9aChs9mKdJP9bul32kcsX+hs2m4egjiM20PbDXKZcHoRPMo/w2ZlYXmMxQyub5KVsz0mLsamaxWbndOCmujoIyneEf2mAvMGcqd0JOSUPASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0mRDVPPaHonK0GUuxmkAT1NxMMg5tt5fef/K7wdB0Y=;
 b=BSMdDAhY9AOaOml8Y3bjFSMg/U+kngGkl2Ui0DVL9XTR2FWTpZ6WPksrdllx2qoMJrS26U6Kj1KwkmqWL6OW6bNuOWLj+9I1aYngHYtq3B/Y9RmHvdwXJkAH+3foR/593bPhA0mejn9Ot4lXBrPTNtk3eBzI3rfc/QYtsAdzp13S811+8HaoHJocJ0WYRK6/7beasfc8Ol7T+Ml1v4xd23MC4avr8dt0YSDWKp3zLjhS1RHo8bgg23eG5i9r//iZehxdjc2jCplz/ZwXvNYyd6vTcnGnsG2ZmEr3OuVObewTUWF4ON9gonzHH9MKJURWxAZ7j2ds04Jfj2aFgVpg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Tue, 13 Oct
 2026 09:36:57 +0000
Received: from MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::45ad:ed1:a048:ac11]) by MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::45ad:ed1:a048:ac11%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 09:36:56 +0000
From: "Cornu, Marcel D" <marcel.d.cornu@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Nicolau, Radu" <radu.nicolau@intel.com>, "Ji, Kai" <kai.ji@intel.com>,
 "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
Subject: RE: [PATCH v3 1/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Thread-Topic: [PATCH v3 1/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Thread-Index: AQHdWlI3LpN+Ff3FakqqQ5uCA5FI6Lb7MO9A
Date: Tue, 13 Oct 2026 09:36:56 +0000
Message-ID: <MN0PR11MB6280C9A3E7E2690206ADCE55DA9E2@MN0PR11MB6280.namprd11.prod.outlook.com>
References: <20261012135947.1895429-1-radu.nicolau@intel.com>
 <20261012135947.1895429-2-radu.nicolau@intel.com>
In-Reply-To: <20261012135947.1895429-2-radu.nicolau@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6280:EE_|SJ1PR11MB6132:EE_
x-ms-office365-filtering-correlation-id: 9eea75d6-8fa5-4a9f-c012-08df290d85ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|6133799003|22082099003|10067099003|18002099003|38070700021|11063799006|4143699003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: 2D1AXVNTOyUtYboW5Ef7tmiZDf4JFiGR/5gK/K7tj0QaK8/0BPlwoRGZtlrrJLUAj8TWmFuKRFhmIdIFaNX/Gk9WwUpFdVbXYmoISGh2dWVcGrySWoDlrcySYD4v6L/WoXnvRg3+3ft/94EMYjrI8xTCirzOFlaI8f60INh1PxFSPrGGRAes00tYlPQym6e/otdPy56fOGdV7G8fegEFbOC7iSr+kHTeHLVronAQuTmOigBxDcYpvNKEtaft383dVFmo+0by/QUSqyDy1W3Avvh0tEKz1I6XrmS41xbf4dUYFHohdahYbVROdT7BUDYzTIgYOsQNOlE+vrsIQdqqLPHXapXdPlB2QJusluW8RV+SaChunvBwfy19pAzorxIYocfjQon4quUIOcTwMdYeYDQKnbVgvuKvd9pQgNpRpjMvNkjvE2y4TSs6rGSHEnxbaF6HH0kiSlv0X17A8v4Lqpg4FzTc7GJCZzPiu3vhCSGixyPds0oTKeuYORyoCgWzMV2Q0EPVycvT/aVPsQ9mHK0Mgw69/OzyRP47RXGCcI3SRxJhuGS7stOOnfHMmj2Er2FIQASWPIbHp0lqZGHKgyOnyQvWQerTXvwHns1PGxF/3RfXSC6K7swcVIAVadSqfDtY0lCoIZwpuR+rAiB1EDSLiRSPkdtkt0YjRIR5H4HQZiufRVawXEqFN4RUu0yGxSeuYhJLg3edeUK0JgiAYawFD8o6zTgNCNlF6ELXQY4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6280.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(22082099003)(10067099003)(18002099003)(38070700021)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dCGbBDUdm/WwFeAV6I0rpQPfA07RaGqvA1CzDc2xudsv99dQ7+vGM+Lln0S6?=
 =?us-ascii?Q?jCC/g3+/GbnufiDO3a0uJ8vwWiZMeG+xVu0T8Su+ZghVh7Pd1rtP6ETEcwkE?=
 =?us-ascii?Q?tvo6oHLCwkj0qd8lzwpUYEvtnk8FgRzWaycqEtSBQgfGRJb/zJ/aoN8zopq0?=
 =?us-ascii?Q?rQqBzrsDJJrH5tie/VsZ8czGT29iKIvqBEPcN7JGPAcPkxx3RY2fLhxSOR0h?=
 =?us-ascii?Q?8axwuaCIol+m5nSHD428m2q9FsWOtYgEm/rIsq94EnLSIlidUf9n7heTQYRB?=
 =?us-ascii?Q?a2lDsdCaZ6UTMCHSYbxgdkeSNCwgYKesbpDFT4LKgVwl3YHP/nHNr66w54f7?=
 =?us-ascii?Q?47WDFlvJorRvA7qMd2SHwaqoUzH1v1npQQ4Zyp1GImhOybfUXtNljLBElkhF?=
 =?us-ascii?Q?inHAoBfaw1uzmbEGCno0ZKMOzY95HVzZoTDOBDHwvf/kd97GVas1xc4/lpuj?=
 =?us-ascii?Q?G0P8lEo+qBXFDBbwKeauJtcjiTEUMr+vyO0s1VoAVeBG+AtaYFi5CBbTXt+B?=
 =?us-ascii?Q?s3J7Hb97Tpf/NPJqttPn1+uEownDAPVC0kqwG5sMqUomLdtqnzijYvsm8Vtl?=
 =?us-ascii?Q?NVBHIADqIwX2IujjJ4l7hopS6Vj/Soq9OCOy98gbnn+oy9o4Ba4VG+AWA38O?=
 =?us-ascii?Q?WfZ7xVR2tdhvHf1xYtJILirfW3my15fkam+ubex2YgUj6+z2i+3Hktzy4P2B?=
 =?us-ascii?Q?gr89h4gwF936QkzgR1UvOQ2b/1jbSzsKVLEMsMFASXoGk/6pbXgc7J0i79Xx?=
 =?us-ascii?Q?kQ/uRSNy29oN+xtd6wutXCZHz5j/nej4y7jXJHLnFOtWBD6P3oMPoXUucgE0?=
 =?us-ascii?Q?cp9OPRSj63nPvuJtMUWg7K7oDtykHKRDOeW1Yi8NpDQT0jI8XqB0/YDTvZJk?=
 =?us-ascii?Q?cUTW/AFwI+Szb2uTRcc++kZiMirqzx3P8jp1PtSYKaEECAZY6pd3iCcX9/VY?=
 =?us-ascii?Q?PT7X/Qbtt/uEuXEFk/xDMdbcTuiglyeN4cpGrxIRrBE5XI/B/78owWmFGgCX?=
 =?us-ascii?Q?2A6ARqIKb7Jwk7d0h/W3HYGvCtx6S4tJKhAOEQHll0jHXU5EYwa9fgndAPXA?=
 =?us-ascii?Q?hxPU+MYsTAu8oqy9t4Vx5xfIEaABkC1Lb6k59I1CMP9qz5r2mXeNC3zfNkwL?=
 =?us-ascii?Q?K31HnqYPrEgLJeBCLLzTCn6Y7qTgpzY9swbYfPqCjB/rPHaYiXh22oWbaIJL?=
 =?us-ascii?Q?AqR3SjBjbktecAWf4ui9DFLl0Qi9MYhacbZ6wug771munwXn2crMGyzMt/jy?=
 =?us-ascii?Q?uFkvaPTbInAPEw5X59u1m15+gFiim2Yomu/R0vtwQPC1d6cjbTBfTlzEOUvZ?=
 =?us-ascii?Q?0FSPrL3jqWz/DkgFkYnlAf6QUuu1it4APS3bqUgZz3H3U1971Xd9ZslB0xju?=
 =?us-ascii?Q?ilTzgVtw0zU7YcajivfDxs0oxIX4MRhgY72MfEfDMrnBX8oKxv4Yod2fy0S/?=
 =?us-ascii?Q?/GOi6ERp2oLOUKZhcnWzzUWA+D02DdrOdjqmT9R0fijkLLNuCRTqiNw4ik3e?=
 =?us-ascii?Q?zKrX6ZORWTl5/xP5EA/5zyuZpxhAjY60Xqk5fhM1D7aiAzo19tRR2rU61EkX?=
 =?us-ascii?Q?SBrYa+NPVZJ0L4d2niQtQ6GBBbhlZdNmNgH8bqn1VZHoLk1wAWbyz51LNPYk?=
 =?us-ascii?Q?V0BxdytnB3pWTiXxICcHgQlgivzEl+MIAFjI5KqI/L6Qn2A4hde4KbJmY8SE?=
 =?us-ascii?Q?n+eALEPuPqoLer2+MtAWbiQ6m/JjG7Sek7slrAiR2L4PzEpWvgX87GbhJeJW?=
 =?us-ascii?Q?YzX+DEX2VI7/SAxl4uC/0eAIVQN7iiG/KKGgeAQsFNr12Yoh/NMrFfRobzsj?=
x-ms-exchange-antispam-messagedata-1: soPoviQeu1H12Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tZQ3d/meLvpA182JjpwG2bzfPqDzHjgyoLvxS//nvIakljqapqh6CMfU6jnhEFhi7zC7FS9ypHu8zGBxpy8dvg6C2mr2oK83zMScig7KC28gPHzjBKH9kgRAoR9eYvgU3zc5D99rs3oBSxSErmZbYPdmX3DdEuoEAOtYw9lAq98EMPEjxniIp91LVlJEeiA0blMFR8XQYtRMYlbtnF2YsrdgGHx3Y8XyU2zxT+ialXjkCJGxR3UC+j+0nPzLRwzst7i0zSknDduU4x/rk+Sw9vPP/HlA9ozYkitTN0gQJsvybfJ+FOacXSXMxnuNis5g/2dsmcQa0ZUKF6fVckNw2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6280.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eea75d6-8fa5-4a9f-c012-08df290d85ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 09:36:56.8490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doBiXBw03P+4T+Bf003l01h4eQhO4MC4qreqFgzPMvD2Hsz7r4K638WDjP1evx486EuD9IQxQx9T9oSSVjYqn9eeyLwmfS4rqXqk+OKg2vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
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

>  int
>  aesni_mb_session_configure(IMB_MGR * m __rte_unused, void *priv_sess,
>  		const struct rte_crypto_sym_xform *xform); @@ -573,8
> +582,13 @@ static const struct rte_cryptodev_capabilities
> aesni_mb_capabilities[] =3D {
>  				.block_size =3D 16,
>  				.key_size =3D {
>  					.min =3D 16,
> +#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
>  					.max =3D 32,
>  					.increment =3D 16
> +#else
> +					.max =3D 16,
> +					.increment =3D 0
> +#endif
>  				},
>  				.digest_size =3D {
>  					.min =3D 4,

In v3.0, ZUC-EIA3 only supports 4 byte digest size. Should this be updated =
accordingly?

