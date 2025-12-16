Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B6FD5C0F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 09:06:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38963402AC;
	Tue, 16 Dec 2025 10:06:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id F08D74026C
 for <dev@dpdk.org>; Tue, 16 Dec 2025 10:06:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765875988; x=1797411988;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rQ4w2QCbACp7nqGGWMMkC7eDGWcQmpBYe4CKsUwbbbQ=;
 b=Jsxk0gFtWvYEDbYw7FpYdpjgbMxu2R/2/Y7KiPe8IGRuqCwveiA480mZ
 LTKAXaED+8zbXlou7rORTQ0XRdvwhw8ubkToYTKiKM80U9VX4J7kvK46u
 +Ucb6NUMxftHsqIIJH9zXgvl5j/TtcuuExWhYaZlxgE0OhjUCZa/+k8b6
 4WunKvbZwNSETujaQ/emHyUCVbYzrKPbgllLcodros6MstP0SmFi1XFGJ
 a4/NgEnytANRS6x+/t6bFna9uXpSZu1fTxjcsfYtjx0hbe76QhUSi8jmN
 2RQc80UiL6ur9HN+8sieBVM8A2xVnJcVqU4tqB7XNjE1fbOE41UMjGj9o A==;
X-CSE-ConnectionGUID: lFgpJjBARRaDX6VIosPByg==
X-CSE-MsgGUID: m91nGiUtTzmm59Y5f0rsPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="66776869"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="66776869"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 01:06:27 -0800
X-CSE-ConnectionGUID: wHEdqcC0RMKvpFSccdM4pA==
X-CSE-MsgGUID: +h3WDxtBQbifQHD7LD+3RQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 01:06:26 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 01:06:26 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 01:06:26 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 01:06:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAoGZKnn2pJhOpYu+7Zg91VYIPRdvZpHsqh51sWXiNcTi8A+RiuzJiDQrzVME7Me5I6rUQtDH2LPc1aNCHKkPdLQxk9pVbevhuUXB0Nrd/vPyngJb3UVbKdo/SUKX+PDPf5/KnzNH0OFrCD8fbFj8vftN0BAvBQvAwhDVyXCPUlLc3t9abJr/7oec0mPHVDN6SAco3N72bdrCVYpYl7JO/EjBVvRCjhvaf3KOCqU3aJRCBpMlFSrVJgxSbMpuJUGOUkJt012lMeHyXXmb7wW0RSW9LG4IO8P8aDO6ZQkLkYfyguOG6lg6UnNj7HRTEGqz8A+/tPjnvU5jRsJQt4EHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQ4w2QCbACp7nqGGWMMkC7eDGWcQmpBYe4CKsUwbbbQ=;
 b=mnfmseb/Xvw+8IN5Zaq+Xz6Qm6lH1eYu8CDhlBJb9x43+FIoOKyw0LyETkdRGMjFVqaNYoa2KprMGfqU50vIS3NDBos4Eq1M09r7jiQJYNr2lJ9U1RtiTrzz0QJOROteAjAWgNlSUosxlQ/vRFYfmeFlEZHi6eQSMCO4gkhGnazTaKOCfkSBbU2xc7YWkX9HZd1jqOodxxamCyZbXHcqV5p1kPh3tysmkKxCG8KMH3J/z8CM13tPMu1uQUl5nD0LJuTFsMB/gCaFPS51UokRC3+wnkolcXY/UjZxQnw3hDV8MQr17RW9QMOOcN5CLcC9kkUfRzddttAy82F6xA7Ncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by BN9PR11MB5243.namprd11.prod.outlook.com
 (2603:10b6:408:134::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:06:24 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 09:06:24 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 0/8] Fixes for Intel common rx/tx path selection
Thread-Topic: [PATCH 0/8] Fixes for Intel common rx/tx path selection
Thread-Index: AQHcbcw4xVK5IuBpekG4nULse2jFObUiyumAgAEvn0A=
Date: Tue, 16 Dec 2025 09:06:24 +0000
Message-ID: <DM3PPF7D18F34A1CD0FF9DDDB3CAB6147D38EAAA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
 <aUAiDdY6K5_ugFHb@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aUAiDdY6K5_ugFHb@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|BN9PR11MB5243:EE_
x-ms-office365-filtering-correlation-id: 302bed09-0577-4c25-7562-08de3c826361
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?UxP+dz8hlzgp/XlnIZDDu7ldaFyptM41qTB4tbgwY+fl6xE0DlIQPXBPGhsq?=
 =?us-ascii?Q?vKHn2REnH4mtW3joDb6n9z9GiuXqq23qUlPSPArezNZ3bxf3CyqSn30HkLhG?=
 =?us-ascii?Q?tEo18imnZ6+9gUqd+GORGgRGlHfZsp6yfzG1Xb3wgDskWjg7Capd8/Flewr2?=
 =?us-ascii?Q?I2n3MeLR4VJ9UQRqcu5pIf2A9+Ymkdc9qE2YzPfcD3tH0rIS10YQM7oFOQkZ?=
 =?us-ascii?Q?m5kmjbYf3ynqufh4xgFrJe5rOdXfNfdpYaJsdSUGxLff+JiPtzwPMg/+XgyM?=
 =?us-ascii?Q?TsRMPbao35UNJsxC0Gm+XZ9SX1DxT1JpucFczjNNgESWroZKFJFyA1mZU4RU?=
 =?us-ascii?Q?qMLrbl6sshW+B8fjNTOAbG3L1/9WJ4T2SB+EqF0KOydH+UOyxkg5gmzCZnyi?=
 =?us-ascii?Q?3Hi78ZZWIZjiw7yiLmySNwE5COG+woSR5Qzh9n9KqOY7lkUfD/9jeyyvMcnf?=
 =?us-ascii?Q?SvtU6vS/3/dV1tTy/AM7O/0SnjTb2vi/+idiZXRFqg23VT82plK+B3O8eZeD?=
 =?us-ascii?Q?KxjPsknMF/3hHept3VJnxzju4n4XfG81LQBTjr9f1L4y5GAXQY+3eI1y0Mcy?=
 =?us-ascii?Q?S4HUb+J6X1xQGwqWUA7LXS4NpW6h1PsUkDRWtUVh77VeP4WlKj8z8/JldALX?=
 =?us-ascii?Q?RG+wKdK7Wv/D6vMw/JofHf5Ew9Xu6W3RwmubzX8MxhktCUhXrbN/AHFdro5+?=
 =?us-ascii?Q?4VFwyId1CqpC5r2Y9inJE7ArDSBL1GwOBZ6MCiT+A5uW4+9cWXNLgYl67CEQ?=
 =?us-ascii?Q?pRKBxcUCcaFT9L9yy2U+sL3Z6pCvKPdf0vvXqgTeyGteRLKQF9nY5yPs4p3U?=
 =?us-ascii?Q?S7cbBVLxdOR0LH1TNZUb5pGzQ3u1PertIhkod8l0k0SwzkIi4LQCKqLyAbzL?=
 =?us-ascii?Q?aM5GXN4hH/LsKsB253udzRAoQT1FjOdrQxyHVeLmQRnAE6k74LQTpcdTMqjw?=
 =?us-ascii?Q?r+J1wNRTIz+I7z0998PzDHo/P1xiRkhaUEheaXzXPq4+QMJr0Jt2cnbc0z9E?=
 =?us-ascii?Q?l/5aEG0n8uES0pIcpeUFG7EtyLwFXu9p2L/SvMj6vBs8fwDPexs1UAu1Ofga?=
 =?us-ascii?Q?5PApRu114csQzbVJoociH5xTW9r3hhEArJE44RhmqWtEJz/SWvm8tsyvyGsV?=
 =?us-ascii?Q?zXDncH+10bkyRlbCc0TubMluSwIgj7HRaU6ojnyTTSWpyz0pFIWHtZtAw3Ht?=
 =?us-ascii?Q?XeboXp7oJIlaAn+cV3dImM7aDjgvz6QXHd0FkJ0iMQ5C5OqMk1Rqm0EsxE8S?=
 =?us-ascii?Q?wesbTfVQqxJKNjmN7K8Ey9O0/D/53IATF1K4w1/i7MhtFYdhTY1NvFzYNUTD?=
 =?us-ascii?Q?V45oVug1mA7KFJOlUUfn/KRffDSEIlf8aaB1g/U3DKCECZaVn2g2zjGsNLw6?=
 =?us-ascii?Q?58ZQ+soElhDk9rwfP7j3eQyAHLMZXTLCVJURP2Tk8NrsmuLP73iNa+Mmhsip?=
 =?us-ascii?Q?JlSBnnJk/6rWuzqPr2L9vKYh9szoSZRmrWnwBrQtBsHcQPaGnjBbsDenGXE/?=
 =?us-ascii?Q?WkPDAvql8A8xE4ax3lKEsHhrQfkTZ2gmzy34?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5J0KXagLf9EN6XoqKsMXo2zvMIpDuevJjt8eTB4zFEIJCqxYztYWLhPx3qlY?=
 =?us-ascii?Q?UwfClKLOShfZl4ahxKp7L2Re1VNPYA0/EvuxUBbmsl2ubPxw0M8ollzx7XiU?=
 =?us-ascii?Q?XqgLUiFaozPm72EyJnhDsdcyMOQR/ShDI3u/zK8I8+5q0QHdVHRMPQyFv80H?=
 =?us-ascii?Q?2Wo/qKRueWTNJ/yLrMDF0ASSQkiKpb+2dVb2sYS3Q7p0guD4DZXHInXmr0RD?=
 =?us-ascii?Q?puX/ejeea8Y+N5vuPkO3S41+WqS2R5k9YAm29xmCNPDEc5Q3tTn/Wj8I7/V3?=
 =?us-ascii?Q?tO1V8EZgMGmRdgm5mI9vD0afYfPF+1s+H9ertCPDbHkHX00PHsdzZ+nxP75Z?=
 =?us-ascii?Q?zjJ80C25ZYeOYtVHtIYEp8EDiUQx4AVLIV8KdlY5wmfcK8WyfY9zMdmc2ejC?=
 =?us-ascii?Q?iROTMrqN4ViRo5WO4kU0fBKq9y9mVLXgcndHSuoq3Xg4yO4EI88fPQnHqTsH?=
 =?us-ascii?Q?rvkBa348ROQhrCFWZh5E8YbjsMhADTV29MRMDpiYUD4CoCECCVe1/2+lrGP9?=
 =?us-ascii?Q?ZQmlVQFGdZ0U7iTjVULKhZegZSGkrxf8cCQE51/+QVR+OnqLUX/Jd8GNp1bi?=
 =?us-ascii?Q?e3PqbgfAJ1EvyV33KKrEMMl5NxW1AYGYbYhwmb1p2c0hMh7yTO954fUlR8ME?=
 =?us-ascii?Q?sBigL56WCvaV0HFLso0MoV8+/bsv5JP1236sfELldrD0GIXw2WaljlCCPaos?=
 =?us-ascii?Q?0Pb9fkvnjIZ3eTgHRcWqoeastWFed4eYcjrtgQDCKOOP7rHafvegD49YW2VJ?=
 =?us-ascii?Q?rXKrcf7UBgvmu4W8vXAUlaOCcn96qCrDXPdElNKHE9RGocMjOqfR+R7C4gyO?=
 =?us-ascii?Q?1tdeG4cIIsstCpfqKl4F+zMdH4or2zwlOnVeOtSrdmI9F4m13Igm1NxwhKlq?=
 =?us-ascii?Q?gef+mnTkEijSGvGSZkXB0tiKhQtIAacriaAQNNazOikepF/9OYQUqR3Vlj5T?=
 =?us-ascii?Q?gJwPJzRikNdRksdt6LSoBLwkN+FJ6yWPQemC+KCTdn6/YvExO50UrtLoY+GT?=
 =?us-ascii?Q?TMBaejtY+PRTHBN3iS8lnz/XCJLc2PPCVFoessgPLUxroegGcHnIp/aS6C2q?=
 =?us-ascii?Q?2Ytmgm84tPJS+yL9Kh1C51IcYxjeqmK6A80vVtCISRBd311fTWEDHBzRbL+1?=
 =?us-ascii?Q?MROWAQfXNuxAEqsbioVXp/8gWZ/xcM2RZ8HYoW7w239AJIDODUSmjMVn0DUG?=
 =?us-ascii?Q?GGooDM7bS8Ol64MCpXJ1UBOEf1TBmN4kYsQyIxedXPisdxzJfuYTSClLI2W0?=
 =?us-ascii?Q?8qM3/0ta0aqhBf9VdRJnQ3tBbVMl6AcUrFEvVqaQ7CpGiupsxn4hDJ80AU7R?=
 =?us-ascii?Q?UNBHipkvWSjgpSRrmE7lNgjslheZ6PV69lk572vKpg5by6Jv44sXRt93YZNa?=
 =?us-ascii?Q?9lA3j9yTXEvoToqQwmoiR5/EeJxc6Szt8T6W76VGPlFxr0RN/aBcMTZLzqLE?=
 =?us-ascii?Q?IYUUBEPwh2tfeNnQ4a+iNmVJnB3ppYL7ezXa4QAr5+iTjkN1mSjm/+LJkiqK?=
 =?us-ascii?Q?86Md2nrTrVoyrZS8n7oxbETrME5i/9XTc20OEWoYaAbYv69BZT3541k10Pdr?=
 =?us-ascii?Q?5p9Cc0fTnnrM5LmY7j41Pld9qY9D0g6jSsA6U9RG/IHz+iYXVTMAfduNiQxM?=
 =?us-ascii?Q?ih/QpplGpkCau2TheI/R/T0bqWG1XJoUaC0Gs7qafdwb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302bed09-0577-4c25-7562-08de3c826361
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 09:06:24.3503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 716sbuIzRALHpy6Y1KrWDX8elK80A9/qtyu9Z4lk0N800zSRePlXGMeF1SsflDZGqzisTgbKVbWgcsOqFP4jEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
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

> Subject: Re: [PATCH 0/8] Fixes for Intel common rx/tx path selection
>=20
> On Mon, Dec 15, 2025 at 02:05:45PM +0000, Ciara Loftus wrote:
> > An issue exists with the way Rx and Tx paths are defined and then used
> > by the common selection infrastructure, which in some cases means not
> > all paths are available for selection. The issue affects four drivers o=
n
> > both Rx and Tx paths resulting in eight fix patches.
> >
> > Depending on the underlying architecture and CPU flags available, a
> > different set of paths are defined for each driver. The path selection
> > function iterates sequentially from zero to num_paths where num_paths i=
s
> > the size of the array as determined by the RTE_DIM macro. However,
> > depending on the platform, some of these entries may be empty, and vali=
d
> > entries at the end of the array may never be considered in the selectio=
n
> > function. Fix this by editing each driver's rx/tx "func_type" enum and
> > only defining a value for the path if it is implemented in the driver's
> > rx/tx "path_infos" array.
> >
> I wonder if there is an alternative/better approach that can work here. F=
or
> each array, RTE_DIM will correctly give its size, and the indexes are set
> according to the enum values which are common across each platform.
> Therefore, the remaining entries in each array are going to be all zeroed=
,
> since they are not explicitly initialized, e.g. the AXV entries on ARM
> platforms. Would it not then work to just check during selection for a
> non-NULL pkt_burst pointer in each entry we are comparing and skip those
> which are NULL?

That would indeed be much simpler - I'll submit a v2 shortly. Thanks!

>=20
> /Bruce
