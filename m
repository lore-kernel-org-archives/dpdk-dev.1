Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4F5CA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 05:58:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D249402D7;
	Tue,  9 Sep 2025 07:58:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A2EC04025A
 for <dev@dpdk.org>; Mon,  8 Sep 2025 23:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757366896; x=1788902896;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HaKM8em6cepVo7NWH5o8BS/bE9XYucai/k96zvsr20g=;
 b=Rv8IwB/UpPIHcU7DxjPQOhlC8vjHuc47NBTyyxWiD+i23605zAB8eGVa
 TdUif6ay1Pot+bURsBKG85KZU1X5etYYYNY0ZUrtV0KNnT2jgvZBReqxS
 SjZdRBLudOOP1zILYhvB4o3gmpD0Hxsr3Hfp3mfDsGpVjR80y43Xot62g
 oHHSY/odPRNsTHN3pICLarh/d9+mkIw5pNozQmbRQ+EGIbQ/UbWKWMsYI
 YD/fXmlhnGXsFV6kttrsEJ5NNcxNKofJm4ilo382zTOzaOQbVkT0E1tv8
 DuuY+mv8xr42QG35sqe1pphcFlsu684hfLv1Wa8lAwDOIbKxb3lTFX+JH g==;
X-CSE-ConnectionGUID: evxO8qtaRHeSUtFvpR40FA==
X-CSE-MsgGUID: Lh9KZoqyRh2bb/wf1a90Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70337335"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; d="scan'208";a="70337335"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 14:28:15 -0700
X-CSE-ConnectionGUID: qGPKqrvBS9GIWhkoDvq1JA==
X-CSE-MsgGUID: XTz1WLfjSOyKT9Hgodf10g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; d="scan'208";a="173704504"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 14:28:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 14:28:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 14:28:14 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.50)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 14:28:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQQYEPjCaBcjvWZJZqKL5cKWJNMOxqkM2WZrpRs84aCDrxbo9Pwd+xspILnm5szZ1QKr69pOAO2aZ6Ta4KDaH2p9JIjFRATWmyNgN3nGzxYaXocy0syKhdzenvbdd1Cc1sufcA516slJYsvC8rs667wTGKJ4s1nq7x5A/MklKi854GnpR1jwxfflN3mtasMBQwzT71615OYg/ZETDKG4+qijQpDr2n67HUyeCzGTzeQnwoxmGOzu6SkxDq6I8ULoP7pnKOIVWfz4KfvxGe7wlPp9YH9TpqqcOf4N0GyBL6ce/B7Z35MtexDnQsRdeDsPsMlxk9J35QRTAhNGuAGktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff1/iY1vmPlcqy4H3lGK54NtD1VEhMcAjNaSKY2MCrc=;
 b=EjJ45av02F7pr7AQuSQkKN+7oGpiMn1qmGuLoo/lytk6hvxhAnaaC6n3V/24wDDvFn1EQaCOfzWU9RzdZejxuVJCZaIJF4qBF2FqxRBd2L1KOS2nPebvgeOgwFB2HN002uLscude2fY91mYZM8PzFg0w+N5UgqoBAGEQcWYCk6jR6CUSzrJRQCN3G/Hv510belv5o1ZMvFPsOUnrR30nSkhg37hT5qc5AyyiGZouDK+HqHHPgI4rq6d5Nq5Eq2091MM5zTLC0009/KW3XhVa5fBl2XuvwQ8C74ZQW66fyVZGuiOTIXkh1XasIATQ96aCqZ6Xyr8Mgb0OJ0WAtbDasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 21:28:11 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 21:28:11 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v1 09/12] net/ice/base: improve global config lock behavior
Thread-Topic: [PATCH v1 09/12] net/ice/base: improve global config lock
 behavior
Thread-Index: AQHcHnpGjDsKwuCn7kSbPDM2r4R047SFO7uAgAPFWoCAANDBAA==
Date: Mon, 8 Sep 2025 21:28:11 +0000
Message-ID: <PH0PR11MB509518C9A3CC9F557B5F10DDD60CA@PH0PR11MB5095.namprd11.prod.outlook.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <890cfe97d9f716a7a65c028578bd1fc90ff04c4b.1756833701.git.anatoly.burakov@intel.com>
 <aLsCf6Of94EA3aP6@bricha3-mobl1.ger.corp.intel.com>
 <f2bd7403-b79f-4f7f-9979-d7cbe442c2fe@intel.com>
 <aL6bKzJd2sk05wlP@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aL6bKzJd2sk05wlP@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5095:EE_|PH0PR11MB7633:EE_
x-ms-office365-filtering-correlation-id: d8d51e1b-c319-485e-4226-08ddef1e9ce8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?80A7ZjKYTP9vVPdYcAzWBUvxZaWLVZU0ctTuItOve89cL+JU9TxVM9y9SfcK?=
 =?us-ascii?Q?E4rY3QO9zsKxQoX2zQTU1r7CIuZNs+Si2CDVhe0dogokMuLi3rEM/9O+Dewv?=
 =?us-ascii?Q?ycRDoY6t3ttielmfSG8jvfr/bEDxFnszcr+maBqdpuIXZj3kaAVZy1SdyUxG?=
 =?us-ascii?Q?yx3RDV3JQe4eafKsxA31ZrGvDTdjYkcUBCCE2X8sLejbkm8g1H0iO6pJ8FZB?=
 =?us-ascii?Q?rY2p8FiwwKkyDkWfVCrfALMWI4dzNTfL7uk5knfl5pdel881KsVqnDsEkiF5?=
 =?us-ascii?Q?8pVC5nKoI9HCU7FIaXTMP214Dvc3V3rP86f4VQPbVIDt/rQ8gJG3g/x+FRKS?=
 =?us-ascii?Q?h14rGqN9NngF8E+gdk5iioADWcmkGKg1nDXd63+h8tJUJi8O5edOU7pN5TAz?=
 =?us-ascii?Q?vaTzm9aKHVOBFtcphDkjmqv/ldCsAy3HdXRJQy4l8pHwI464+uuQteeP0fGN?=
 =?us-ascii?Q?fOvZqn7VAU0R3GjtyA8lZsCE5ivCbTwHPYG2JC81q/4IwUvAqQQKi2lNQHQQ?=
 =?us-ascii?Q?7dFdrpnT+K7XfKM4zMJzAs6UfJ57QNrK3GzYWRDADfWENITO0FMeIfT71xHw?=
 =?us-ascii?Q?nn4dZkImJtOzvMm2CvIHFOMWqZl1pZ9lnckdFAEMQ/VObHOkrxJ7ffODOX8g?=
 =?us-ascii?Q?nv92RzBdNLhAYP3pbU8ppZpDhhPObSxGhmS8mkAmbb9jWa4qe/jLLyUQlOu+?=
 =?us-ascii?Q?yWa7EkiucQYogExSupv9RrRrKtTpNJGPLffjSafVD60Ju58Q2WOk+NJP3Mik?=
 =?us-ascii?Q?357zzwYhU0ocf9I6Y4PTY3bCTUGyW+GwN5QGj3kdbFBC3+JsMGT4x45Y831B?=
 =?us-ascii?Q?O9oiTGKLIHq/DSSlRr+oOhZqmN0tkWkEX0C5m5M+d6l3bbP6ykuGRB4N76zn?=
 =?us-ascii?Q?S53y7u4pB1R/1JarGNxj6lFVeja78hlxSfOmAXjsy/Pi1t3KEz8RS7eB4fO0?=
 =?us-ascii?Q?q261Iqn2iyjzqHs8TRGQM34yvI0wh6TkBJ1gimnpxF+ez3GUMi+A9tuViyeU?=
 =?us-ascii?Q?gI9i4EkhlKJ9H9mDFGAY7DZhtEO5nbjWYdlJz+6BqsXysa/e/KQES7Bn546A?=
 =?us-ascii?Q?VaV+XqXLeUQHuXBn7oXxPk1xF1OVii9d6qDZk1R1wsccWo/gm9607/yC4Vr9?=
 =?us-ascii?Q?WNyerENHlwn7FEbKSES6mRH4SGaPf2VUzTNp+gFFPKthSPgiAiePgi7l4uds?=
 =?us-ascii?Q?0+jZmxIMtZMxywRUGIateirt4kYGw5pRXwkQMH31x9zm8qz3to9jScjlYZ8m?=
 =?us-ascii?Q?3ZLS51QM6wpUbS3XfGjTMXaC0rKqwPLfuHWtUgvocN9lXfHkqCiZwOOWVTrG?=
 =?us-ascii?Q?SQmWrxYqZS2z7+T2PyrcV5iN3gYZPR8SdGqWKTVGeXcasCYyGHOW2+TNJYx5?=
 =?us-ascii?Q?eBmfZ36MgCLQf5i4m9XtJSWz5RBI6XLY5tMJ6FUddiz5luVcXWOY0YiaZEv9?=
 =?us-ascii?Q?qHBeGY80wZXm2+I3GRLoc6u8zJR5PW13UPVDadc+yMicg2+VG1Tm0w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5095.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kt2ot/cW5mYJEds993kzKGwycJ57M7Ck5Ey3Bh+BG1xW65+Est36tz9EzhZh?=
 =?us-ascii?Q?vjBhfF2S5ekxkxIqZZolqhyc+TJLW6L3LCVJuz8YeEBzmBAvhwAhWPcKaw2K?=
 =?us-ascii?Q?zhvweZg9AyG1pedSFPe9es/R90QGW8vqkTCnPpOVaKU8YLjv2KW7g4+VNXgm?=
 =?us-ascii?Q?TauCsPMI2S2tcr1r07OpbIvCY88BP7F+hdB4vDZeJVORx8yQrM3eTd2w3B06?=
 =?us-ascii?Q?kksv6FQRL25R/4j+HemF8QY8duuk2zrqq1E6/55CQcdeko9SPlyovKWNnRLH?=
 =?us-ascii?Q?EQSmYQxBPTSjInmKsUd0ikQi3ZyVWxCClHqQMzlS0E2o+lEeTIIZUWTvbYS1?=
 =?us-ascii?Q?FeCcWDG/6B0psqOXwGNTG0KY6ceJjZkyV8Wj+KdXNiFP40u0mMuYC/rnaCRe?=
 =?us-ascii?Q?yAK1xjKAVJSUwLbiJmvdEzn2q8gPk/Nbp8S+8bHjLjU9OUqM7CVX1Wr2Xhuy?=
 =?us-ascii?Q?BPtUsyL90cDu25Rh9WdVrGq5fU5TXL2H/DD1SDLnJlOaBZSb+xoi5tnXUB0Q?=
 =?us-ascii?Q?B/nRJhepz6XZ2qnBL+FWzB8IXeVezseeCDUB+mp2UfSrkSgMYXlLZm/epEgs?=
 =?us-ascii?Q?GIbYhRnQNbqG1Uz5n485cf1rAkr9DquuyDqc2YO4DbeC1cstl7xapD6RxJQC?=
 =?us-ascii?Q?XZzaFIUD2nzaXFP3jrGtFyEP6wYlKd56GM2TDTBQdMl1+FmfhFnDqBqnIFxP?=
 =?us-ascii?Q?8FHoM1VPB9ZofsS9SUHQKUh2f3Qfi4fOjnml539bLo6NvTJdzJRkDJnF0mKF?=
 =?us-ascii?Q?0WvCGqtFbc/jfp63MOCq67HBkKaNcx0F6JfLP5vv67NeN8apWK5RTLeIBhoJ?=
 =?us-ascii?Q?/Y8nJAcCJ2nzTX5V2ienlbvkdf+2xih3jI7IkQuIicDd9RfQxGfILAXRwHWW?=
 =?us-ascii?Q?mqQBY1gXgvvNDrGD/s8gi11cbSfrHRuwptNTHBY2InntJ+oz5Zrrwg9wJc32?=
 =?us-ascii?Q?QZ6UvCUNZjiKGjfDajlAYyRDDLrzR88wNcdT4YIn2h6UZYcFnN3U3uYsfHtJ?=
 =?us-ascii?Q?hyzwJSBtTITiLKGmog8/qYwHmpWw6E1T2nk+omRJ/Anz8kpq6HAny8+TnYT3?=
 =?us-ascii?Q?3O1TJNv7X/26S9R6a77tt2Wa6SzygYZ2I2c6lPjfYhojAYpxkdYRanloeHbs?=
 =?us-ascii?Q?4j7FTWAa/txVslCdD4daneg+Xs7PLuzQkhc7p8fH7P7520nxNfTk6CgLTc3m?=
 =?us-ascii?Q?zuh5+Ua0sF1mMzmNPOzSN1CjuA2EC3dFnMmSjDdwo+sriCNkvNB7MNGrjG6F?=
 =?us-ascii?Q?gslhg/DMi+JdGWZsuEtsdcylZTXSQpQp2aUb6Uqad9sAWuvOAkg6tXK22rtD?=
 =?us-ascii?Q?mFZiv0Jke1DeGISLqT+/tf0zmSiXUjxgNsp/lwyUuTvswunwU4b6ffjRVP7Q?=
 =?us-ascii?Q?fd4KvDcK4lfTwnhv7M16zeuAtHZjoC86sGZ1TuLtlSyipzZRjLOtO+M0w2Fj?=
 =?us-ascii?Q?7JclJbZI29JN6ZHxib2Q+0wCubQnqu4MR4XNqSxqNvAK33tI15WWFCcEokO3?=
 =?us-ascii?Q?l/YlT12a3KTyvIb84iurKAmV6zlYiWFkzSvZxGvb/XqqEhenxg1tf/8FoiRi?=
 =?us-ascii?Q?dPfHvmEJoAzhkRqy3idxRZ6ZFJ01mDZ+a909unJm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d51e1b-c319-485e-4226-08ddef1e9ce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 21:28:11.6737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwEptGAHlX5oKxd6/N2TEULOH5A5nXAwGtbWGGRXPvOL+poBVK98uD48z4GivSNiWEXH8SWjphBK9BSq44m7T5PAvAABEfYbZyNS2QcACkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Tue, 09 Sep 2025 07:58:22 +0200
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
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: Monday, September 8, 2025 2:00 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Burakov, Anatoly <anatoly.burakov@intel.com>; dev@dpdk.org
> Subject: Re: [PATCH v1 09/12] net/ice/base: improve global config lock be=
havior
>=20
> On Fri, Sep 05, 2025 at 04:25:19PM -0700, Jacob Keller wrote:
> >
> >
> > On 9/5/2025 8:32 AM, Bruce Richardson wrote:
> > > On Tue, Sep 02, 2025 at 06:26:59PM +0100, Anatoly Burakov wrote:
> > >> From: Jacob Keller <jacob.e.keller@intel.com>
> > >>
> > >> The ice_cfg_tx_topo function attempts to apply Tx scheduler topology
> > >> configuration based on NVM parameters, selecting either a 5 or 9 lay=
er
> > >> topology.
> > >>
> > >> As part of this flow, the driver acquires the "Global Configuration
> > >> Lock", which is a hardware resource associated with programming the =
DDP
> > >> package to the device. This "lock" is implemented by firmware as a w=
ay to
> > >> guarantee that only one PF can program the DDP for a device. Unlike =
a
> > >> traditional lock, once a PF has acquired this lock, no other PF will=
 be
> > >> able to acquire it again (including that PF) until a core reset of t=
he
> > >> device. Future requests to acquire the lock report that global
> > >> configuration has already completed.
> > >>
> > >> The following flow is used to program the Tx topology:
> > >>
> > >>  * Read the DDP package for scheduler configuration data
> > >>  * Acquire the global configuration lock
> > >>  * Program Tx scheduler topology according to DDP package data
> > >>  * Trigger a core reset which clears the global configuration lock
> > >>
> > >> This is followed by the flow for programming the DDP package:
> > >>
> > >>  * Acquire the global configuration lock (again)
> > >>  * Download the DDP package to the device
> > >>  * Release the global configuration lock.
> > >>
> > >> However, if configuration of the Tx topology fails, (i.e.
> > >> ice_get_set_tx_topo() returns an error code), the driver exits
> > >> ice_cfg_tx_topo() immediately, and fails to trigger core reset.
> > >>
> > >> While the global configuration lock is held, the firmware rejects mo=
st
> > >> AdminQ commands, as it is waiting for the DDP package download (or T=
x
> > >> scheduler topology programming) to occur.
> > >>
> > >> The current driver flows assume that the global configuration lock h=
as
> > >> been reset after programming the Tx topology. Thus, the same PF atte=
mpts
> > >> to acquire the global lock again, and fails. This results in the dri=
ver
> > >> reporting "an unknown error occurred when loading the DDP package". =
It
> > >> then attempts to enter safe mode, but ultimately fails to finish
> > >> ice_probe() since nearly all AdminQ command report error codes, and =
the
> > >> driver stops loading the device at some point during its initializat=
ion.
> > >>
> > >> We cannot simply release the global lock after a failed call to
> > >> ice_get_set_tx_topo(). Releasing the lock indicates to firmware that
> > >> global configuration (downloading of the DDP) has completed. Future
> > >> attempts by this or other PFs to load the DDP will fail with a repor=
t
> > >> that the DDP package has already been downloaded. Then, PFs will ent=
er
> > >> safe mode as they realize that the package on the device does not me=
et
> > >> the minimum version requirement to load. The reported error messages=
 are
> > >> confusing, as they indicate the version of the default "safe mode"
> > >> package in the NVM, rather than the version of the DDP package loade=
d
> > >> from the filesystem.
> > >>
> > >> Instead, we need to trigger core reset to clear global configuration=
.
> > >> This is the lowest level of hardware reset which clears the global
> > >> configuration lock and related state. It also clears any already
> > >> downloaded DDP. Crucially, it does *not* clear the Tx scheduler topo=
logy
> > >> configuration.
> > >>
> > >> Refactor ice_cfg_tx_topo() to always trigger a core reset after acqu=
iring
> > >> the global lock, regardless of success or failure of the topology
> > >> configuration.
> > >>
> > >> We need to re-initialize the HW structure when we trigger the core r=
eset.
> > >> Previously, this was the responsibility of the core driver to cleanu=
p
> > >> after the core reset. Instead, make it the responsibility of this
> > >> function. This avoids needless re-initialization for the cases where=
 no
> > >> reset occurred.
> > >>
> > >> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > >> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > >> ---
> > >>  drivers/net/intel/ice/base/ice_ddp.c | 34 ++++++++++++++++++-------=
---
> > >>  1 file changed, 22 insertions(+), 12 deletions(-)
> > >>
> > >
> > > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > >
> > > See one comment inline below.
> > >
> > >
> > >> diff --git a/drivers/net/intel/ice/base/ice_ddp.c
> b/drivers/net/intel/ice/base/ice_ddp.c
> > >> index 850c722a3f..68e75be4d2 100644
> > >> --- a/drivers/net/intel/ice/base/ice_ddp.c
> > >> +++ b/drivers/net/intel/ice/base/ice_ddp.c
> > >> @@ -2370,7 +2370,7 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf=
, u32
> len)
> > >>  	struct ice_buf_hdr *section;
> > >>  	struct ice_pkg_hdr *pkg_hdr;
> > >>  	enum ice_ddp_state state;
> > >> -	u16 i, size =3D 0, offset;
> > >> +	u16 size =3D 0, offset;
> > >>  	u32 reg =3D 0;
> > >>  	int status;
> > >>  	u8 flags;
> > >> @@ -2457,25 +2457,35 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *b=
uf,
> u32 len)
> > >>  	/* check reset was triggered already or not */
> > >>  	reg =3D rd32(hw, GLGEN_RSTAT);
> > >>  	if (reg & GLGEN_RSTAT_DEVSTATE_M) {
> > >> -		/* Reset is in progress, re-init the hw again */
> > >>  		ice_debug(hw, ICE_DBG_INIT, "Reset is in progress. layer topology
> might be applied already\n");
> > >>  		ice_check_reset(hw);
> > >> -		return 0;
> > >> +		/* Reset is in progress, re-init the hw again */
> > >> +		goto reinit_hw;
> > >>  	}
> > >>
> > >>  	/* set new topology */
> > >>  	status =3D ice_get_set_tx_topo(hw, new_topo, size, NULL, NULL, tru=
e);
> > >>  	if (status) {
> > >> -		ice_debug(hw, ICE_DBG_INIT, "Set tx topology is failed\n");
> > >> -		return status;
> > >> +		ice_debug(hw, ICE_DBG_INIT, "Failed setting Tx topology, status
> %d\n",
> > >> +			  status);
> > >> +		status =3D ICE_ERR_CFG;
> > >>  	}
> > >>
> > >> -	/* new topology is updated, delay 1 second before issuing the CORR=
ER */
> > >> -	for (i =3D 0; i < 10; i++)
> > >> -		ice_msec_delay(100, true);
> > >> +	/* Even if Tx topology config failed, we need to CORE reset here t=
o
> > >> +	 * clear the global configuration lock. Delay 1 second to allow
> > >> +	 * hardware to settle then issue a CORER
> > >> +	 */
> > >> +	ice_msec_delay(1000, true);
> > >>  	ice_reset(hw, ICE_RESET_CORER);
> > >> -	/* CORER will clear the global lock, so no explicit call
> > >> -	 * required for release
> > >> -	 */
> > >> -	return 0;
> > >> +	ice_check_reset(hw);
> > >> +
> > >> +reinit_hw:
> > >> +	/* Since we triggered a CORER, re-initialize hardware */
> > >> +	ice_deinit_hw(hw);
> > >> +	if (ice_init_hw(hw)) {
> > >> +		ice_debug(hw, ICE_DBG_INIT, "Failed to re-init hardware after
> setting Tx topology\n");
> > >> +		return ICE_ERR_RESET_FAILED;
> > >> +	}
> > >> +
> > >> +	return status;
> > >>  }
> > >
> > > There is a similer deinit + init combo in ice_init_pkg in the same fi=
le,
> > > which is the only use of this function (in DPDK anyway). Therefore, I
> > > believe that that code can be removed now that the reinit is handled =
by the
> > > cfg_tx_topo() function.
> >
> > I am not sure we can do that. We program Tx topology by taking the
> > global configuration lock, then programming the topology, and then
> > performing a CORE reset. We can't simply release the global config lock=
,
> > because then DDP won't be able to download at all. We can't avoid this
> > re-init, because after a CORE reset, the drivers AQ setup will be hosed
> > and thus we need a re-init.
> >
> > ice_init_pkg should be called after Tx topology is executed. If another
> > reset occurs there, I think you may still need to do that re-init too.
> > There could possibly be a complete refactor that removed the need for a
> > double reset, but I am not certain.
>=20
> Ok, thanks for the analysis and explanation. Taking this patch as-is.
>=20
> /Bruce

No problem. The flow here is a mess because of the complexity of the global=
 config "lock" which does more than just serialize access.

Thanks,
Jake
