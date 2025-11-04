Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D159CCCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 14:23:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5D7D40430;
	Tue,  4 Nov 2025 15:23:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B350D40269;
 Tue,  4 Nov 2025 15:23:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762266218; x=1793802218;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wQ9dcph3O8ua7BO2Pl6giQerpRIQ+CVf0kPXGB8ugIw=;
 b=QN1BIm5dIbs9g/NNLZ7jJ33NK5NUDQoGlEUbHewMJx+ra4Fs9WwMas42
 /bu5pCYo9CrRphSPnZXs4YCW/ku9WGCrbwe0QLb4C53rSAA1Wl24B46Zy
 NNvonZUrRodnC07VoNzZ3nKS3hvmI52qEWKX6syfWEut06kIgTrzQ1HZ0
 7EXeSEoH9mwXYWxN3PaRU9gpx98dZGjyZ50yuIJI+o6fBP5FauPxSNlhv
 smr7PuTo6Tm1gMPT76SUR48xK/6ylYAp+ui9VkGHvC8h2y3vH+4TjS8We
 BCZPzXB0nDFDu+RPuziyzkMyZrKlqrtzRfrC83RtODp6xid6HNGWuoFU+ g==;
X-CSE-ConnectionGUID: PCTFIiPkQZ2kJ1xFadl4Uw==
X-CSE-MsgGUID: rACrqLpPRJKpkwqiOf568g==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="74653609"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="74653609"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 06:23:37 -0800
X-CSE-ConnectionGUID: Zlf9Yj6CSUKhD96y6hwMRw==
X-CSE-MsgGUID: jP3TB4eLQAeLQ8ljNGgKdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="187320890"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 06:23:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 06:23:36 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 06:23:36 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.53)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 06:23:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WX7PTMvDqFw5Ej6CCSIc0QpuZwkqkUFnMpkV5k/9il4xbYjDFw5j4iPHYVWkKxh4PsNMKBgczAAqCTGlUEzMRpbc2WssCneO4CBydxSdh9wbNgwU7ILohNPztkGA+ScgYpR/TfcGSoXpqQLdCT0jAxAktESnICPz/tZFKr7Y8qsvby1/iSQVi9wjE02GJ31aOt/LdSXhdCsNaMBMUctCqmAFjPy0GR5yvE+60bwIJE9Hd/eiPuIyixkpDMpN5SUawIf4Bb58iylgIrvJtBg6GJOAG0f2KpePd+N5tcrsFBe6fsKvCKSnYgD0AlnJ0Wqgy4LkT9JECzJNj9Vv35Th2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7F7bJWlFyUZfjzn97M0F2x2AkpoAVR2BsTRmc2J7h0=;
 b=JN6gPf9gMfLArEEGHpySFwZPt9D9G2g6re2uY8mXGgfuQjehTjZ0EqyE5CzF1J39zu0KYXZmJELTkSgJWGsdUtuZuUX2L/8BVisOzk5XiGtZUd6qWKz3dg+PMbUTJJlgOXu0ScUtrwd99NRCM+LHA2/dxRhAR7EpNMq+6BfgTvCgPriZIWLZsvjV8DQF0UbKpB0FxoNOzOEG1VA4ZdT9bber5s57lmxEJxLxNii1YMbH7i+3X1PjChUzGkbXmCgqHjvicjG0mxCsKUPagsZcqLckiL37957ZtHy3y/Om/kXznYtcu29e3CCvh0afbBP+FGzfVF7udQ+SVyFq7EUM+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB9456.namprd11.prod.outlook.com (2603:10b6:8:290::17)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 14:23:33 +0000
Received: from DS0PR11MB9456.namprd11.prod.outlook.com
 ([fe80::a00:2722:bdc4:d144]) by DS0PR11MB9456.namprd11.prod.outlook.com
 ([fe80::a00:2722:bdc4:d144%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 14:23:33 +0000
From: "Gujjar, Abhinandan S" <abhinandan.gujjar@intel.com>
To: "Marchand, David" <david.marchand@redhat.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Jerin Jacob <jerinj@marvell.com>,
 Akhil Goyal <gakhil@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>,
 "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
Subject: RE: [PATCH] eventdev: fix build with clang 21
Thread-Topic: [PATCH] eventdev: fix build with clang 21
Thread-Index: AQHcTYwvtmaLWAexI0Kef17p/lLWobTikfmQ
Date: Tue, 4 Nov 2025 14:23:33 +0000
Message-ID: <DS0PR11MB9456C66582DF2E7AB1D5A671E8C4A@DS0PR11MB9456.namprd11.prod.outlook.com>
References: <20251104130820.2692144-1-david.marchand@redhat.com>
In-Reply-To: <20251104130820.2692144-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB9456:EE_|PH8PR11MB7070:EE_
x-ms-office365-filtering-correlation-id: 2f665226-86de-488f-ae54-08de1badbc4f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?tCazOlFgFK+x7IhDdkQb0iR9xBLmTcg79Ft+nKdnA4qLqQ2ogsJ1+Ej/Rw2f?=
 =?us-ascii?Q?G2mTeZaXFaq2xO1F+7fxK8SZFkBhK1VNRNg5rNAe4RzuQOsOETFOO8zsWlXf?=
 =?us-ascii?Q?WosaLxVB2pcAQUvVyzBeKf6jih4mPJdzI6ZR0Pz5AnMw7EYLZmAahOeKxlZm?=
 =?us-ascii?Q?gOssIeYH8uDi9WLQO5l9ugxdGGg9QH2Kd+403M7m3HzoojiQy8rdr0XZxvhH?=
 =?us-ascii?Q?pFesMeL5TYKxfWqKi3VRgY6LJhPABPT7iDa4x8DXlo4/ntOyNgL0Ly1XlZ/z?=
 =?us-ascii?Q?SqC6cYd/T+E69fjaPwbbF7vfmFuu45ywx0DwUcKUKZL/SAWsCchQCHD1yY+e?=
 =?us-ascii?Q?FtL/jLQFzAkV+Z0M/oTKGqerjJm/WDn6HxcxjctDpcGSMUkG0q48sQ4cUhaG?=
 =?us-ascii?Q?266bLeDF54LANA/pbcHEmrmfMFn8Mnc8Mz/HvL8VCYNlv11xwqL5ge1RGN70?=
 =?us-ascii?Q?CS4eifHQMu7iNxH7n3avUrIL7nKA4RqGvFCIj2WpOqcW1qPC0E/QYMMbg9gR?=
 =?us-ascii?Q?OSmYxAbQLu+V3fVdFlanGHrFC6FBJ1cGCTnV4MIhd2dOrXHOo+3KTuNw1uCA?=
 =?us-ascii?Q?wZlk8LHRCs1d15K2wDcyJR19637iKhDwpzHSdni77MZbzZqzNezDMHFCQI2w?=
 =?us-ascii?Q?vyx1VlG1CiOKR/MfgQBjSbpJXFlrX4pwuS3apC7/QatG9Hc3g6IuDbZzk7HB?=
 =?us-ascii?Q?CqZswjz6dnMnYrmFt6it6t9/I9pHlDgM9mZUjiR+USAeCo4YEMUmwnW2LWez?=
 =?us-ascii?Q?jHEYes8H1c3qREJoFMax00MjtKyzEdJ6iJlqVTrpGgYCQMyhZbY95Qm/mmvV?=
 =?us-ascii?Q?PwzBImF1pB8sD4dPBMkZ3W+ApFifwnZnERNRq6pK19MtC63GWt3DnHeWxvFI?=
 =?us-ascii?Q?1qpfs0zXLNQ13GI6+fHp2xCenjyIyEaJFri98POv0HZqhMS6FSm7fCIj0DNz?=
 =?us-ascii?Q?NuFyEcPFtXd7V2DSP18H6lNnQWlgOg2p+tsP3bYfnWrgbXg4QoywW4VOlW45?=
 =?us-ascii?Q?Q3A6sfGI1ss3bxKXz/32AvvpyJv/qxR7U9ikNBiyxyLXqzleTrBJYQI9m27L?=
 =?us-ascii?Q?tLoLRG8FNn7eVjGEhPGgHPSRtir4ngQWpqOCW2WPU7xi0s8pHFMiFRVaNCe6?=
 =?us-ascii?Q?RTyLk1qO7c5Wm4ok71cIbv5JQqQnDIqR/sEcRuUa/Jdx/GXhR8BYKEOFd0xp?=
 =?us-ascii?Q?pccieWav38vFsGFGxw12E3FdMIfuH0Unw3zRq1qRoaej4XJa10ho6XQZnuMs?=
 =?us-ascii?Q?laAyfgOUQO9OPYyzJC0F45p9pq8R4xcH4m5uqmRULT1mrcHnV5lo4Pn0i9nf?=
 =?us-ascii?Q?SOCiH1z4iBIvBwUMDhAIKpgWJu5kUSP5IX6G5zBOxkMZBIw+GAAMwhtMYyQ4?=
 =?us-ascii?Q?2fQHD4Vbs7QC2l6457Y1OigtEiyF459wcZQjQSfEzaFE8Oj+hWEPyC4oGpMl?=
 =?us-ascii?Q?fzZ2+X//siDdgppbDj8OWN4u9orlEy00xztS2R/v/x12Z+DcHlgFAb/AWuoN?=
 =?us-ascii?Q?9oDdX6xAmPhkxH6/80LZ3maXXIlsz84aArRM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB9456.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B2T01YwaRMaNMJiTX/BeIKlk2G0wuRiRacq9FqtdUigBp19oYrrgkJfrV4ZD?=
 =?us-ascii?Q?gLBPgvIxbXr94ZS/jqJc4kwjtoJ6cJGX6SorKmDXgCPHMatoiRrSCWB0XLtA?=
 =?us-ascii?Q?qrw5RyMhTkN5YxWxQcEnak814CutCnYFkKMgqyKEKQ5aMDgXrHdgupHYgl9z?=
 =?us-ascii?Q?/PeI7siTLKHwH8oIjqY0QYnde/Qfoz8qQI+6C+DhMKl1W2tmOHJ4g000cadP?=
 =?us-ascii?Q?WTX0oBFH0mfZjL5O+hOFiydrJkBhMlHQJdzynizM6rNNmOKl2myvX2NAAXje?=
 =?us-ascii?Q?OCeuZoeWi/qR6HegPyM/f00sQoXVlYChvuRhj+eLPUtUMD3KDS74UxNF4zEg?=
 =?us-ascii?Q?go3rav/mNSlg+J1ohbmCioT+i/Lh7z+T5WhE3S0LRVvLRAtD4TCAPKOiKjKe?=
 =?us-ascii?Q?mdYr4S3pS3kRzlo3yCMx3a7JDUs83J5AmvQRclVUqDruKcLW8K4U4yK8oruh?=
 =?us-ascii?Q?iBXKMMtsecyyIbN+LlWP8ATZA0LDCf18q0GDI6xI+Ic+Imi+PD5/jteCVhMX?=
 =?us-ascii?Q?dZ4qn/UGIkFYJ9Gtv1umn+c5ADUCTcLeKpSgg9eOLub/rrgPjneUzdsW4Za9?=
 =?us-ascii?Q?ZcmEthelMdb/S+oTWuNwqO/FkaDClgfHz9FosOkcQaLSC6a2Qb9+bo6JBnXi?=
 =?us-ascii?Q?PfiXNjTdaeIiJF0uiJ01A3Z+HJTzMSVmoqLL1aK89ljRn/C/peUo/kmcj1tJ?=
 =?us-ascii?Q?FswGf/qZFkIGKgrnGgP34/LtjmFo+wH8HbeC8bMmBOeGtsOPQnquTDsmiXK+?=
 =?us-ascii?Q?8UyHC1xCw93/mawnsqUaF6bDTRQ21Uo5UcVfu8BRw7/Fk+PkfEWgR9aQdhQq?=
 =?us-ascii?Q?mwnnTtRLPHttDNIXM/j2BSiheeG04F/VO8wy6bX5MpZD0s7+4yTj9rp0E6fq?=
 =?us-ascii?Q?X3DOLE5Ymc0GFZBlQMvxCpaCxQP/Kvj6qoX+IYaBO3sbQjj1felXs7Zy5Rnm?=
 =?us-ascii?Q?YhNaypyZ90HkeCT+yBSbVWynrmrJbI7aI4A6q2cYvJxTRMNws7gra51sid9o?=
 =?us-ascii?Q?M5vkEwWnEUf0yzrvHFhtoE/98ihu6TqQXcjsI70pR+lD7przNlaoNyPDWGgM?=
 =?us-ascii?Q?k381ctuMNCBz//TjLrpRbgVL/q/j3nw1327RHqh++SYtKSd6WWIUSRIhuUe7?=
 =?us-ascii?Q?K+RWzTcEurVDr7q4iesOfWTB02eIiTXFrbjGZ6CTkF+PEf5XfZRJ9p1LBiwr?=
 =?us-ascii?Q?BOkURPGdPJCek7UIyOt6gZ0mLLTOddcxOwz39NbZY8oA5PNwHu02TGMZC00F?=
 =?us-ascii?Q?MNOPoTkucDcAWdA5QEIzLSSjPp0rIfdYWZCVy9XtwhB9ensRoOebMXb8f0qQ?=
 =?us-ascii?Q?UDcJBbvBjb7Z4/8/3/N7Cq1BzhoEUCAwn3ns1J76dv3DaKt2ZXAFreO1K3+Z?=
 =?us-ascii?Q?pG0Lsg5YG+CeCxENP5QMD1zc9RZyb3GZR/2Qx+6M03/7BiDkmtI/QdLoRTUr?=
 =?us-ascii?Q?MtcnUjfOi/aAUzzR5joDcX3Nfodv6GS99kxHjWxSmVOqnqVix50NT1pnEF0H?=
 =?us-ascii?Q?KA+2RFb+0AmcoXIxhGhbbsTo1ZmIhfumPn7wtNWh3W+50M/Z+MSvHN+Zjich?=
 =?us-ascii?Q?SbhPrsAwONiIVwKEvM7VBfyOsseglAhVL1PeeFJd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB9456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f665226-86de-488f-ae54-08de1badbc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 14:23:33.5500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5Rn86BY4lKW/UGSE7zVEjw0JWT2b+r5Cx3L9fod/+g836qOCicmXxqQoh+AN0PvoX/I3vtAj9IZJRZSPBdLr563Y82UrRKfsWMo5b2k4Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
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
> From: David Marchand <david.marchand@redhat.com>
> Sent: Tuesday, November 4, 2025 6:38 PM
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Gujjar, Abhinandan S <abhinandan.gujjar@intel.com>;
> Jerin Jacob <jerinj@marvell.com>; Akhil Goyal <gakhil@marvell.com>;
> Volodymyr Fialko <vfialko@marvell.com>; Naga Harish K, S V
> <s.v.naga.harish.k@intel.com>
> Subject: [PATCH] eventdev: fix build with clang 21
>=20
> Fix 16-bits formatting issues reported by clang 21 on Fedora 43:
>=20
> ../lib/eventdev/rte_event_crypto_adapter.c:1461:4: error:
> 	format specifies type 'unsigned char' but the argument has type
> 	'uint16_t' (aka 'unsigned short') [-Werror,-Wformat]
>  1459 |     RTE_EDEV_LOG_ERR("Failed to get adapter caps dev %" PRIu8
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1460 |             " cdev %" PRIu8, adapter->eventdev_id,
>       |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1461 |             adapter->next_cdev_id);
>       |             ^~~~~~~~~~~~~~~~~~~~~~
>=20
> ../lib/eventdev/rte_event_crypto_adapter.c:1592:46: error:
> 	format specifies type 'unsigned char' but the argument has type
> 	'uint16_t' (aka 'unsigned short') [-Werror,-Wformat]
>  1592 |     RTE_EDEV_LOG_ERR("Invalid dev_id=3D%" PRIu8, cdev_id);
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
>=20
> ../lib/eventdev/rte_event_crypto_adapter.c:1613:45: error:
> 	format specifies type 'unsigned char' but the argument has type
> 	'uint16_t' (aka 'unsigned short') [-Werror,-Wformat]
>  1612 |     RTE_EDEV_LOG_ERR("Event vectorization is not supported,"
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1613 |                      "dev %" PRIu8 " cdev %" PRIu8, dev_id, cdev_=
id);
>       |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~=
~~~
>=20
> Fixes: c1749bc5ee10 ("eventdev: introduce event cryptodev vector type")
> Fixes: 04ed18cd41f1 ("eventdev/crypto: support runtime set/get parameters=
")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: abhinandan.gujjar@intel.com

> ---
>  lib/eventdev/rte_event_crypto_adapter.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/eventdev/rte_event_crypto_adapter.c
> b/lib/eventdev/rte_event_crypto_adapter.c
> index b827a0ffd6..3f9cc7379a 100644
> --- a/lib/eventdev/rte_event_crypto_adapter.c
> +++ b/lib/eventdev/rte_event_crypto_adapter.c
> @@ -1457,7 +1457,7 @@ crypto_adapter_cap_check(struct
> event_crypto_adapter *adapter)
>  						&caps);
>  	if (ret) {
>  		RTE_EDEV_LOG_ERR("Failed to get adapter caps dev %" PRIu8
> -			" cdev %" PRIu8, adapter->eventdev_id,
> +			" cdev %" PRIu16, adapter->eventdev_id,
>  			adapter->next_cdev_id);
>  		return ret;
>  	}
> @@ -1589,7 +1589,7 @@ rte_event_crypto_adapter_vector_limits_get(
>  	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
>=20
>  	if (!rte_cryptodev_is_valid_dev(cdev_id)) {
> -		RTE_EDEV_LOG_ERR("Invalid dev_id=3D%" PRIu8, cdev_id);
> +		RTE_EDEV_LOG_ERR("Invalid dev_id=3D%" PRIu16, cdev_id);
>  		return -EINVAL;
>  	}
>=20
> @@ -1610,7 +1610,7 @@ rte_event_crypto_adapter_vector_limits_get(
>=20
>  	if (!(cap & RTE_EVENT_CRYPTO_ADAPTER_CAP_EVENT_VECTOR)) {
>  		RTE_EDEV_LOG_ERR("Event vectorization is not supported,"
> -				 "dev %" PRIu8 " cdev %" PRIu8, dev_id,
> cdev_id);
> +				 "dev %" PRIu8 " cdev %" PRIu16, dev_id,
> cdev_id);
>  		return -ENOTSUP;
>  	}
>=20
> --
> 2.51.0

