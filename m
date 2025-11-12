Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB96DCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 07:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AF474027D;
	Wed, 12 Nov 2025 08:35:38 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
 by mails.dpdk.org (Postfix) with ESMTP id 66C494026A
 for <dev@dpdk.org>; Wed, 12 Nov 2025 08:35:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jViVOaNpmLYKLWpR+VIYw40M6kn+nD/AeOWVgk+dLe9lbQrmn0ANTAgSDt+KVpMLYSLFZDVfb6zAND4s1X6dkL3iHfjCybuZLHmTJilpGGCzjJEf6kgpXzI07SUrQNdCxt3+FJfxLV5+luQZkOVV7L6fk8aEFO24S6dbxGJUa6cxzUcLhhwErDJ7KUWIJODxL7Nc5ogr38yUNT4HP3O1wkGfpVXees+OAvXKKwhPlK6pwfQLZRXW+NjnRFOXWwLkuNbVUgggDSuk0fjjv+36qG71BoEAAcq3idjQl0boJMuIeuwwJFrNS0Kn8XFbVTGWwNb2qCxRWL9TGkPiXta7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ALzWSEFqh3jLzQp5O2xxwCwX4JMAj0L/L9KeaQKB9A=;
 b=ZyDCvSrpKaMaFRBJJLTSs90hWCupUaHx9Jjm50/6GGodcI/6s6J64OsQ7bdrRESVfJsDS5RtJjaiXW5cmp516qZuxJwn4N4dpcdAGWmdh2L1OG7+Oq+wfVlIZ2TQSZWbJ1B5cq9qAh+IlHxR8PNuEEJR6ygBnlAppLUY9tsQLdh+OoV6OcZVcGACFQSgmjh4g1a3DX/z029I7HFaIpluU+yD5SJ0xtQZb7Jn5OGXgzCd0nExt0IpXeLOcGcO3ixrd67xG58bKbas4fYr/ZLNqgYTUD4maYBzOqEmZrN8E4OREgPQhFb0YvgjWrBwywrXzAlWyuW5nP2k+fy03E5gKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ALzWSEFqh3jLzQp5O2xxwCwX4JMAj0L/L9KeaQKB9A=;
 b=MTA0eNItNa7u5XbIBiGtbxkG/z60+tgjdE7OLmRPLY2jtglaxvkpdEJ7y8GlfY+m7o+OVVFuqhs1Sm+UEr3673Wx5IdVmdqBoeVp0sPoscta2scwXPggBxY83MB8UUg9EjiSd2iyf+3EbH/B+iIJ82MNo5NQU3LciobHod3inpCBm4cOC7G79o9BUOjT/IUsO3U5L4Sc+40B0Bpp0jd0fay48t9QzcS4hDMSd5Fe07p0VgFNs6RuEb1mwhKZTqgglR8rrsq9EFxB3JomkEJ/sz4/OTdJinNtCzU7F6PfqkpbOPCDgqHyrxT16Nzqhknm5kP5FHktCPmXyONLbyL2VQ==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by GV1PR04MB10249.eurprd04.prod.outlook.com (2603:10a6:150:1a4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:35:35 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 07:35:35 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "maxime@leroys.fr" <maxime@leroys.fr>
Subject: RE: [PATCH 0/5] Cleanup rte_dpaa2_device
Thread-Topic: [PATCH 0/5] Cleanup rte_dpaa2_device
Thread-Index: AQHcUMTePyGCJBDIrkmVHFtUbfbd27TurC4w
Date: Wed, 12 Nov 2025 07:35:35 +0000
Message-ID: <PAXPR04MB932810E05D7F91A4C3BD8E4C89CCA@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20251108153207.1512863-1-david.marchand@redhat.com>
In-Reply-To: <20251108153207.1512863-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|GV1PR04MB10249:EE_
x-ms-office365-filtering-correlation-id: 5095edd4-87f0-4bed-3daf-08de21be1174
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gnUfr3erU19hRVkgFZzXjPDFoiud9qq4alekHarERiO0ewBKu6PrWCqj8cR5?=
 =?us-ascii?Q?XuEhqBH5AxE3YzvPRKHePd/49uO0KIth1/QmJZi2TmZOEXAdPlqqh2jGlQb0?=
 =?us-ascii?Q?SG9pLMF+9AArCfGaKs08GpzBb9THLSRgE5igCMzu/JxbMPNcmK1x1p0+49En?=
 =?us-ascii?Q?v2199HJOKKpypCVyg7Oja37SO71e1qlcUtDFEX+D6z9Yb1WNTw3Xn757NR1S?=
 =?us-ascii?Q?weFYxrjCvNhATbOsQLxwiPqkgdEudRfaP5CZrAm3u0YJz2xbC5fYLPYFGwua?=
 =?us-ascii?Q?ZHhiuzEJsM7WPEHS1G2DKoZDkv4vk44MZeGG1IIcUIhSF3eTnD7tGb3EUmqa?=
 =?us-ascii?Q?9uOYn8PJtYlcgOefc5ytVMT+/Q98uXkdahq1oMkeKoci/qhZ5RUHqdlbERKs?=
 =?us-ascii?Q?YX93vWkoS2yBqPkvqaey6agrTC+8Lf8Mfrd6xY34ahcPOgiQa42gTo67w5Ob?=
 =?us-ascii?Q?dTsPWRxBHvnO3d++gLFp+x9J2Jrrtj+HRFMFIdC4tde3VFtKmpdDyODeeDcL?=
 =?us-ascii?Q?sNGHUenhn7TkMCUnmtF2ZYYRLnUE7LacNVkQ9kLdn1mriV8cVzypyK9rmkG7?=
 =?us-ascii?Q?mu4Odb0m9Y8rGmV7kVCIrPDBGA4D4K+pcpf9j6KBut11TWrFeeR5UyJAY16V?=
 =?us-ascii?Q?PDu35W/YGlIZ58+nSP95UWEqSOOZgu83Z6XcRYVusdyQgkn/25P+h+Kdh4ho?=
 =?us-ascii?Q?M9/S83zsuPVy+HTg3lJ5a+IEvdGJZPVdnzUONgOAT2olHo302yjxups4PzLA?=
 =?us-ascii?Q?TXiXLI1+7p9iruuNFpP2Cl0R7+M2GLD0psBckjQqogDkRcDZ7Z9Vx8wLlqkE?=
 =?us-ascii?Q?kwkPJhQIxk26Hv4ff7o8TEXOUoY26+Lui330ZnxcCp2Ifdtx+WYIqyhVP/ro?=
 =?us-ascii?Q?nimr7paY64AZq9Jyx+W4i4AqRskK0JXQFxgvU9LyHlcTL7cUPssNMKTWAUm8?=
 =?us-ascii?Q?B+gJBAo+lq83hVaPcqFy/BXThZYrv39FIXogKHA8kYY3LDLiBgi2wyBnYPaY?=
 =?us-ascii?Q?3MlagwcM5+EPBHR6nfMicqBS8Z9/F7M392l7GDwVrN6iu+ZpynljXT4XMOqH?=
 =?us-ascii?Q?IBQr8AZxVlLUH6OCejM4z33niLcv142B6w4avDCSwTfdmbNCMZWCXdLqu4cI?=
 =?us-ascii?Q?I6QX06NUIw8s8lYIxSN8AUCd4fseQxRic7ty0wlcp1myJnBusGp415ZOtI+O?=
 =?us-ascii?Q?KYCpaa2muF0oR4aXIZoD9jeElX2N/dJOGPzymxm1ues3ki961jXVl5wYYkWu?=
 =?us-ascii?Q?DjOq8wrIecw0X5H/pqXOXTFymaV9ZIsck674RvVajhtQqykRizan6ir1Gb9K?=
 =?us-ascii?Q?KnIKcV1UHqVqWJievSjYfGjaGdbrdEUIRUGWiW2w1X+ZAuXGCXBnjQM+9fWr?=
 =?us-ascii?Q?fncgij/V+sE7/24ZlOSzswHhyKgKG474MGPHQ4jrT13rziHswBko7xwQ62SN?=
 =?us-ascii?Q?1kVByzQg3UHE0nF9fMWkg4ywg+77D16XeudOko9Vl9RcmNgbLVOt1GJ30s38?=
 =?us-ascii?Q?pyvPCaHK+c7tyiUfyPfKBQs6nTg+o4j86PTb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P9mFoWnnWkjgjWTIz5IBRpXFKAIV7SE9Z3G1dHiqT4QK0Vq0Z7hUpv2LJt/7?=
 =?us-ascii?Q?5b1Ogv6uuAElhloHsxQiexA8aXZ4B37LlyDCO+/Q8o7W8Txa/r4l3b8KKSiU?=
 =?us-ascii?Q?m+8Wm5vUIZPJwhMxxjs1QrpmeoaNTS4jsH7zAefYSCL007ItDFo5uedhNZ6n?=
 =?us-ascii?Q?S9gjk3xXK5AEgXK2m0QHLP0B1GHpgU0OlFnpPuhKu46KA0/Ns6yr5OPZqKHr?=
 =?us-ascii?Q?N7RqLZ/x2h0N2v43joiDxiFrXyiupEVbBzt/Ib7ZNCdDq1hkBR2kwp514Uf8?=
 =?us-ascii?Q?c1wVdK5Msvktj31ILoHblaxUSwdmRm8OggvMTJIxKcc0lsbKKWCOh72geu/8?=
 =?us-ascii?Q?fh+LdVjCd0vBoZNhXz2cDuC+4lbwsiebPUYgPjuuRArGhiOfBPg4JVfgWAbn?=
 =?us-ascii?Q?WpAiKl3yCM4UrI5tgejeJre7uJxV6lEF69tmrU2XFn6MbklVPzvEljTy251A?=
 =?us-ascii?Q?KQtQf0Kra3d1vcvBJKDtq90r69X1M5l4MdPC1XKAyMy4T8OnNI8nYsjt5P+K?=
 =?us-ascii?Q?HgM3/Iyr97zQGj0jWqM4F6+l/UhYGE/XVZFuWbbGpW6p7FiWaZkdKeUYfB6+?=
 =?us-ascii?Q?+hPr8xf9oDAwzEH3ZUwmVgJJzCBsNGQnCs1F+HtxITy/PiqNR1h0Js3GwoY9?=
 =?us-ascii?Q?I893Pe4KliUPKi+j4C2m1jg07qVX+q0mbVFU6X1D668dJ7PMm78A8sqo1Wk0?=
 =?us-ascii?Q?VzCeg4N/9rcY7f9zI/DeGjbWg/R3jMxy4SuzYZNoUc97OwHi+zg3+K83+DsJ?=
 =?us-ascii?Q?Yhj5n7Syuulgs25W3sJI0fhJ49tiHpE9+fhQfAaQ2BoSKElLvFIkx/UYs6cL?=
 =?us-ascii?Q?mhHL5hpCiDO4SC7QJi8fBeIvTpqt1w78k+hAjAQGORTjDf6sBlMDJT348cIV?=
 =?us-ascii?Q?qG0WfdqgWv0FfYkioO3JKtAy/1jqAdc3RIVkjBqmOjQAc5df3bq41itZTUq9?=
 =?us-ascii?Q?mOaOMrtkL+8+qRrpge3znuQ8pMwb8p8rWnyKcVxaCqXi18r4ehrUgyOayZsr?=
 =?us-ascii?Q?HMSWPJz0wKfkmNoSNbivu0p0ykuNQIY2WLsgkqu7m3hgv4wB9K8uhj4hXGQc?=
 =?us-ascii?Q?PXKoSLT/tgDoZr2vrp3S2sw5m50z6bznwMJ1g22B38K5xLGMpy0sD8PWA04n?=
 =?us-ascii?Q?9iTVw8y3xEN9PCuo3i+k7Eu51Mba68L8CeGAPg2aQ9Sa2zG6zyeB5IsghI6b?=
 =?us-ascii?Q?6dJxN680BX33m+M25GknsZa186ZZ/lH3EIvMyZFxR52DE9ol75/Vh8UXPkfR?=
 =?us-ascii?Q?u9MJSF0oShIKGbIGycTNDg1n9ejyHV4SVqOS7ImfZ4v10hyH1Cs3VAwAHhhD?=
 =?us-ascii?Q?3lxkbb7+b05wy5IhummjoKnKVXCXgA8FTXEnHASKfoxFdqSCrDuN7XWlitD2?=
 =?us-ascii?Q?PYWMfQhRr9T33QiW9ffLfnIvW+cvv0auZjuNcpjMmVklTA3QGZzaQQNi3JT6?=
 =?us-ascii?Q?8jwUckoOIkeMEz7Ove0tcsn3qPAfGfVrwlkQyrI8/Ylk4+wi05VawZ0eaVK+?=
 =?us-ascii?Q?NShaJHUCw6tVdy8Yo17Scs7/pRTvk6impU1roU6HwCn803jC9/EYOehzkSOf?=
 =?us-ascii?Q?dtwhP605Fcnq/vM7M/cwcddZjoz95+hwjcHN83U8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5095edd4-87f0-4bed-3daf-08de21be1174
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 07:35:35.3161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z183pFVei0e0gK7haLsJpJo1DMUB+XrIG8n3D52hG82h3mACyLLzgFvq7/SZI5w4N22b21p7BWg7BQesPFCGjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10249
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
> Sent: 08 November 2025 21:02
> To: dev@dpdk.org
> Cc: Hemant Agrawal <hemant.agrawal@nxp.com>; maxime@leroys.fr
> Subject: [PATCH 0/5] Cleanup rte_dpaa2_device
> Importance: High
>=20
> The rte_dpaa2_device object keeps track of a device class object (cryptod=
ev,
> dmadev, ethdev, rawdev) which is a layer violation.
>=20
> Make use of the device class respective infrastructure and remove those b=
ack
> references.
>=20
> Disclaimer: this series is untested as I don't have the hardware.
> I only based those changes on look at the code and other drivers.
>=20
Thanks for the patchset, we will revert with the test results shortly.
