Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F7EF41995
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 17:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 319C9402D7;
	Wed, 15 Apr 2026 19:52:19 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by mails.dpdk.org (Postfix) with ESMTP id 68F6B402D5
 for <dev@dpdk.org>; Wed, 15 Apr 2026 19:52:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QReyqf/M2CHc3xCkpX26OpZkAbbQrkIErY4L33ZhyraRGRvQkT65zxcUnrGFwdtckDEHjrYc4IpzbKp43zDZRIVBLuux+hd1+LVhtfVgJMSnX/cLQM9Y2WNKHBYQuxTlEGZCgZNdVPNTXiBQ4XiKVhzyNIWtUz+PzbsZQjMlUbXgjYOzh6VTIbs9NNmbZbW8Ebi8dhrZqoUc4slFemNWEyD3gufRKJDb1lYh2CpPf0plB7Fn8XYaZvi4EliQ7nJEHqc3FUwfmSEkrEBqd+hS08WOuSY0kQXGB4pfBAn1HZ4dLVsRPEgaj3s6YzUHLvCmeu4JrgpxoIcsRAIGIKjDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoIDp+ABLDmCXGndh7/XquxvNKgFLF3T/qpi73q9BNk=;
 b=TXV2wCKiqHLiSxw5aRkkjRRVjX90DHkAj7ifAfnlkRA6aUuBK12ycSkuQpIf0vZMyzMw639WbJMcgHGa54OKd33WZ0wrFEanvKDYtTy95NKJTmueCAJDZT3jJSD86Pl4lBDloT663oWULkvYsewt4sj9vhtRfrkO90JfrD1s7jloBWApjqpTWxg/4dfXJ/sgM0lqJ0IUs6Wh8qBKHGaSGRW8GPZC9GQxnYTNMlNUwEx87EsfdR5aETLnqU5aL5RgTp8mcL95TLiOzCaQh0CwViGPI1McpJLdI9U2lLbiRIVhUWZ8yr+Wlk9nOrk7LEkQN7DVZoOJIPWiDzwRSfbZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoIDp+ABLDmCXGndh7/XquxvNKgFLF3T/qpi73q9BNk=;
 b=qFIj1Eo6dC1mwj57Kxb6oxZzKgTi/Ch/SSu56m4sVgIe+GB2jG6iTZzvXTCSawCj4Zz8hQPsxTSuOFDUmsCqZqIufehp7HHBXLimA51JosWI4WIvzP4oCBcENOhi+DaXkQO9Inq7wGcTPK2dMCXm8q/1zVCc/00G5VXjW65QU8I=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 17:52:15 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%4]) with mapi id 15.20.9769.014; Wed, 15 Apr 2026
 17:52:15 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "Tummala, Sivaprasad"
 <Sivaprasad.Tummala@amd.com>
CC: "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "wathsala.vithanage@arm.com" <wathsala.vithanage@arm.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "viktorin@cesnet.cz" <viktorin@cesnet.cz>
Subject: RE: [PATCH v5 v5 1/3] eal/topology: add Topology grouping for lcores
Thread-Topic: [PATCH v5 v5 1/3] eal/topology: add Topology grouping for lcores
Thread-Index: AQHczEZ+K4UGjNswFkeVyJC9t8VgQrXgKamAgAA66cA=
Date: Wed, 15 Apr 2026 17:52:15 +0000
Message-ID: <PH7PR12MB8596A6F86F3F200F2D74448A82222@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20260414193850.1696-1-vipin.varghese@amd.com>
 <20260414193850.1696-2-vipin.varghese@amd.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657EE@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657EE@smartserver.smartshare.dk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: mb@smartsharesystems.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-15T17:37:41.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|SJ1PR12MB6314:EE_
x-ms-office365-filtering-correlation-id: 2e5d0c5f-efbe-4815-b191-08de9b17baa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: q3Tux2egyhxD8JWQJRYMm+Oji99LE89ojNSsNb4XQe/MQuwwyafOElE4b3iDC7ohP5cPx1ziuAy5D8hkm8yp57IXdJ16RiqIsxLmxtSNrIEfVvzdJbNoirhIhhqB/pUbelco12eOGGiNd+Ng3aRtFsCsQAyhCQpyIlbhBc4x4SZu9PZnSLuKTpwnt5gmVSI1Xs1BwCllvbbQtjddfagjsH7rpVXRsNQQMeBxKWgcxeCYfrlAU/aekTqqo1/TII3ZmgfpQV5qvFrUkxyh1632JZZnMyY9WDNb6lF8HfdI3ClL9Ddw3mSeQYt9qjBe6djTj/8RiaxlJB9ArtZpmvLshitKxOl9AANF9V53S5YvDgEOoRgQQko9uZGtV4cuppuVMX06GLx5NgLHzixA+5Xnay6IcnKs4eOCfzaBXlMuuhS0gUXXheEhCBpgkgWRrv9WUPus8bG2mBCEca7Lg32PQ7qWgEwyTPDfO4CYT1wB6E6XcOui6OZVNAz1FQRPGoC1iLmiH+yFbDjeTTXfThMauyzl88jduSWeqlpMOn8p1q0gjP3xEqqxFGFpWSujA0TWtUAee4m2sOXCyOpmg6y6j/sb3DBP2hdHtJ+Qwgaj0on//itfQ/s9DIdnkQ0IIAkJo5DCqd29JBXSeIl2iZoeDHddLntbx1btbF3iSm4L5xo76EAz1kxLGTB/xz0qtu84/5I3PQYMj55TDi3LlEmuT8GaN/kr+J3VYy/4WwmFq5tjS+9FlHLywG6LcfSmwLar
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N7x36jVJ+HwaKaMuJ3ZmNA9xqEn2qbXzu1igVBvsxA+Z4DUGXjZdEA5gnq?=
 =?iso-8859-1?Q?APXfTR5mzv01MQgdlS6XBeGvhrQiszRg8/SZakCSxEfXpGVFj2Jmy7YZnd?=
 =?iso-8859-1?Q?/9QVAwP1eQFqGbyoAjrlvo1/QbjAcpXQwuC36REXU0vtX8rlIub+PdinzH?=
 =?iso-8859-1?Q?xPxI6upyy8KSVYG9nxC2uV8Zf58FWAyo/uYWFHd766ee27YgKyrGISqh3y?=
 =?iso-8859-1?Q?d6dQrjBrn+OHAzizsWoAFpJwDKPvNsph6PmltNr3+lHG9zDIShdPN5ZiGv?=
 =?iso-8859-1?Q?8X3vTtuV3Y4eJcU8M8t0rJzvczvtXzOnpAyQP/OwDBFNH2+unG/L4b/pGo?=
 =?iso-8859-1?Q?RjiXV+2UgTAuZCRRrWOQXwwOKHOJKhu2mvAkrz1+p1w+lKgsW443VFezPI?=
 =?iso-8859-1?Q?X5Rm76rONgQzQ8FNa4lNE2ID/MtcJ9nMxSuaPujbamGDbVKgRzWG4dSLVP?=
 =?iso-8859-1?Q?UJ9W4gXDbyta3NI6Haj3PxhQ8Kefdn3pKaUc/BhMhcvCqHIDsBKUgJKf24?=
 =?iso-8859-1?Q?yPqIqUbplC+DDwMHpFVdigv8ap7a4GS1yqcCC4nRkTq+BWMcwusIVgE8Kk?=
 =?iso-8859-1?Q?hYXShi0SRPCXUTU8Q4Sn4iFgUhH46cfs7dDcpVSRqwAMYaH8V6BjHa9yCV?=
 =?iso-8859-1?Q?9xzHiMz07dZ+8qrETQsjs3MIuug82XkRKccNf0vmXFWoams0AjrzTF5Asd?=
 =?iso-8859-1?Q?KibiQ1Rc83Hf+sojcxKHKzpyuaie3Z1uh9S/PBEkLwRKBJzBuCAUXMkvi3?=
 =?iso-8859-1?Q?6leEKwMPl7/TkJ8sowVETebaMHaV5wkARR8lDYWUQd/LQ1BM05mhH8wIQN?=
 =?iso-8859-1?Q?YLAfry/dGTVkyD1HkL9uOvRRES6IcNiiJ/d7SG7yX7kDXGzZR73wqdluYZ?=
 =?iso-8859-1?Q?ZF7MpvlOCEzE2GlQbgc1witEJ7W1Clxj7b7BzRkJs42w7c6mtvEcU09d4w?=
 =?iso-8859-1?Q?lL4m36XH4Vzwfsl1zzNlXJ4B0HRfD28fWWWEpNT3oXohZCRNkfYfqqkxdJ?=
 =?iso-8859-1?Q?/JwkOksk1CWQNxB/Z/7JmuetTK+6YWkifoB7HCsb2v5V7GePJRun1n9qaZ?=
 =?iso-8859-1?Q?8FPBizUn1RHMxoGgecASFtBlh0n5j7TglXXfPHUjY52zs/AUS3wMwNSlQ5?=
 =?iso-8859-1?Q?Vl04nRDptn28x6ABrexAWGl0d9KTqaax2YGhlPAneMKd7nxy1Nb+9Dp7b2?=
 =?iso-8859-1?Q?kidc9+BVlqg2zPUD82amx/RdECcUggaJ9fsjYTcanQAAje+5uZ530DwfYG?=
 =?iso-8859-1?Q?a707r9KW692rXC56t4OWAcpslBEw2ngZbf2xhlmE4VX2CqdBelGBomYsSF?=
 =?iso-8859-1?Q?EQ9T+rGRDkpcyOUoDDAmv9FM2cXjDu8b8OQA6hsjIU/sHH7SZBz866Gu8j?=
 =?iso-8859-1?Q?za9rya7M4UaAnAJxNjVq0qO1UW9W0ZjS8xu9pYlDfitb5LIbtoEBLpggiV?=
 =?iso-8859-1?Q?z8I2FRbQBuWA35t2eKRQI2zp4vXBT5CzY91X3YpohCc0pGXgA4eZ11rPeR?=
 =?iso-8859-1?Q?lCDOvsVFlfZWCs31fnwOOeyK4kuysiaiClfV5LJZRaPLbEnk4Fsy3cPViu?=
 =?iso-8859-1?Q?LKoQg/s8r2smZ9Y4IanIya/Ljnd79DwxhFmzK8SvaHtymawDJc34F27jKK?=
 =?iso-8859-1?Q?v3wRq2KRfEJXwRnyr36jX0XVTkp6VG7KYvBTKPsPImwtCsoop2yLVa4msi?=
 =?iso-8859-1?Q?/Ln5HyIqawipw+bvSVDNpYQBuPuhj3hRd9UlPwugFsR7in/xStS8BMr891?=
 =?iso-8859-1?Q?YtHuVWAcRqcK7JeN6oXoqNfiLa6v81E8Mayv1zsAB8WLrK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5d0c5f-efbe-4815-b191-08de9b17baa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 17:52:15.0469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJLZzbgoW38BHsJAIP3ok5IbsXq/6mtLlTzKWj79DIUS2CypwCbJq0p23HPmCMGlkETun2XwT1or3JhhbVg/hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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

[AMD Official Use Only - AMD Internal Distribution Only]

Thank you @Morten Br=F8rup

<snipped>

> >
> > +struct core_domain_mapping {
> > +     rte_cpuset_t core_set;  /**< cpu_set representing lcores within
> > domain */
> > +     uint16_t core_count;    /**< dpdk enabled lcores within domain */
> > +     uint16_t *cores;        /**< list of cores */
> > +};
>
> In Linux, rte_cpu_set_t is the same as cpu_set_t, which is limited to CPU=
_SETSIZE
> (1024) cores.
>
> We should stop using that (fixed size) type, and use dynamically sized CP=
U sets
> instead.
> Ref: https://man7.org/linux/man-pages/man3/CPU_SET.3.html
>
> IMHO, both the fd_set type, limited to FDSET_SIZE (1024) file descriptors=
, and the
> cpu_set_t type, limited to CPU_SETSIZE (1024) cores, should be considered
> obsolete, and not used in new DPDK code.
>
> It's hard to change old DPDK APIs relying on the fixed size rte_cpu_set_t=
 type, but
> let's avoid adding new APIs using that (obsolete) type.
>
> Also refer to: https://bugs.dpdk.org/show_bug.cgi?id=3D1704
>
> PS: I guess a larger CPU_SETSIZE is available for systems built entirely =
from
> scratch, including libc and all libraries and applications. Not a generic=
 solution.
>
> -Morten

Thanks for the pointer, If I understand this correctly for given DPDK proce=
ssing for `rte_lcore_count` is valid representation While hwloc_init can sh=
ow upto 1024 or more. Hence step-1 identify the number of cores (or executi=
on engines) per domain. Alloc for cpuset and use set for valid lcores.

I will make this change in v6 and omit rte_cpuset_t

