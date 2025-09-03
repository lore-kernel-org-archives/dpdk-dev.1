Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DAFCA1013
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 09:39:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE14C40B9E;
	Wed,  3 Sep 2025 11:39:01 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by mails.dpdk.org (Postfix) with ESMTP id 0FDE9402BC
 for <dev@dpdk.org>; Wed,  3 Sep 2025 11:39:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElMbwVa/p+v2b/aEQVaZceyeWCaDfGQhpff98qs6n3tJLz0Tf83MtRvOqMCJLaFqOcLA0XrHDGR3EbTMrG/ultnipRfAy6VpZUvUJhsyKYR1zUrmmaBADqrMBhCwl3Q0UccrdXevvqpR20Ph6ReH2YxVwZwRCFVrtmb3VNkHD4hwm+6eOelcH7jKhMdiWoNq3EaC+4rydnZ1qOWrruWsE0dw0sdiuXKj4QIh1QDuWLdi/kY86qMpvJIip0qeb7/QAb67i8O52VJS2dfMzWxMGWQ/2rjeCH+S1t8by57UChfwNdrZsNQJ0B84tkT9KffcIwpZUn97cX4kX1MUg42uXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6AjKpaEmvR2uYEgHnXhc+rBoAnshldIpproEOtkEDY=;
 b=AxM9ibC5b2tzuAfvr64/4SYtI9mEjsAo/pvNAR+jsUdpE+SZ8gyNCdyi6hkvPqT8kzvk6g7QxtLAg1rMdxTtbLVl2YhFWw8z3g5Whg2n7vPI69xNJD8gXi2mADYPuhzpW6vPLVOFxWzwn4qOXoWFLUrV8oThWB2vJvT+LQ1R6z1jVONslJQqF2ZuS6bbRoQQB60oQzws7etnKjzTU8r/si4QOSacqnTg5u6AZ/OuKTse3uDfqkXhk0jF+pHnBnnzPkoTKqu43ORFiC78nnuFxfa4kaNHNu29b6lVb8ZuHtz07icPhOxAz0oGa9L3yum8LO07BRZMhAD/wWOhNtBqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6AjKpaEmvR2uYEgHnXhc+rBoAnshldIpproEOtkEDY=;
 b=cv06HSWa0dmGFXAS9GyZtVI2Zsugno8atIpqEI5bh32emUd0tPtiKpJg1+IU8hODrJEB8LTOT9mZ5SmyVZLE07I8DO926/2gGrjYkq6/E+r4vaJ4Eo7gFmV8MQa9zoCDlxblZH5nu0FIhkTXZMXwcHnRT3BLHjfTskd9zJjBpPKdjIYQ8pXl79nbceEt29jZtL3MXT7lVO4HcXDIbfQR2gkMmJ9wuERB0qqVBSEMKy2EnJRT1hlYkuWG7j07hwU68kY5686SkzbkLQUT3FKPGB5SF6SK5pQX2ZDArHIt59xeZBwOmfKt1jDfiYTAB5mncN1uuDmpq2UtdCroI4o2jA==
Received: from BY5PR03MB5234.namprd03.prod.outlook.com (2603:10b6:a03:219::14)
 by SA3PR03MB7345.namprd03.prod.outlook.com (2603:10b6:806:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 09:38:58 +0000
Received: from BY5PR03MB5234.namprd03.prod.outlook.com
 ([fe80::5116:191e:bbfe:5859]) by BY5PR03MB5234.namprd03.prod.outlook.com
 ([fe80::5116:191e:bbfe:5859%6]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 09:38:56 +0000
From: "Xu, Rosen" <rosen.xu@altera.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "maxime.coquelin@redhat.com"
 <maxime.coquelin@redhat.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Vikas Gupta <vikas.gupta@broadcom.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia
 <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Tomasz Duszynski <tduszynski@marvell.com>, Tyler
 Retzlaff <roretzla@linux.microsoft.com>, Harman Kalra <hkalra@marvell.com>
Subject: RE: [RFC 1/8] vfio: remove confusing check on VFIO presence
Thread-Topic: [RFC 1/8] vfio: remove confusing check on VFIO presence
Thread-Index: AQHcHKRoibIQLCxbnUa6qkOD5o2JnLSBM8aA
Date: Wed, 3 Sep 2025 09:38:56 +0000
Message-ID: <BY5PR03MB5234BE21D4E386E23A319B1DFC01A@BY5PR03MB5234.namprd03.prod.outlook.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903072826.1727004-2-david.marchand@redhat.com>
In-Reply-To: <20250903072826.1727004-2-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR03MB5234:EE_|SA3PR03MB7345:EE_
x-ms-office365-filtering-correlation-id: 43ae2b96-d212-4ebe-a393-08ddeacdb3db
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BO2vrtcrLOXzLWLLnHSUi+mRquahbo7gL2CMc/yYBoZvj5dbxlJ89zdrhtDR?=
 =?us-ascii?Q?tKWyzKv5yV1EuebUQTjXI1hdmX6a6/9R6Y9IaCZO6qeoeIgeeDwqN9GmP59G?=
 =?us-ascii?Q?DllmwmW9U7IhU+PhEUZUrQ1geJhRKo6hJh49tuQsr0vIMakAMJGBivFoYmDh?=
 =?us-ascii?Q?VRG1rwKhe+GL6rvPI4g6jkYUvyHY42vyDVDwq4l+XAnu8oo7gMGJtM+ENuax?=
 =?us-ascii?Q?o0DbjMb15GLNftDTS3IreKCHt0Lj34isW786OfFudhGFY3+W85bLO7lh66w3?=
 =?us-ascii?Q?kBkXZY8EVCwnH9chtTMl/c1JkQrQcAXZyqv3j56A+0yE2Qdgd83VJfsjd2aY?=
 =?us-ascii?Q?Cs++fwkU6P1RlJOWrV4lgzA4OFrIv6K3+Qz55aSKKW5ng10h3RKlc/fsMSs9?=
 =?us-ascii?Q?lXbV9PqPbB5giqTVIOPIuMXVGuTsaQ8Zof9yx+YLaZH9+Ha0eloMvT3UgtS3?=
 =?us-ascii?Q?NV+otRQkzaLLKuQXF8AQqU0LrByK/gH+c9gniosFDiGz7ODHO5sHjUWZ2Xjd?=
 =?us-ascii?Q?Bz7U79aXKfQ0aco8eMyz/6MhMzyveqFTzkeTMrVj/jr7nkPknF+bKP9O1V0x?=
 =?us-ascii?Q?3EJNwbS3CQsCMUD/OeucgZcGef4IbS70Rdc9BbPiYslm0B3gsT26rXx+KXk3?=
 =?us-ascii?Q?XulXRzs2puz+tZKkI4wfMIs3hw/h7YGAEIQDsEfpArtCz2NaB7G7u3ToRBxh?=
 =?us-ascii?Q?BBromDVMPkyNbs+alb8002TQEOFHLRQPDNjZphqT6iZyitFbzvzIw/PvR1be?=
 =?us-ascii?Q?f9Ye0MICkuJoFiN4yVMsQDoFvLyFMIC8VqEPG/kCi4Eh1BcsTdg18hKime3V?=
 =?us-ascii?Q?zp0WyRacO0O8FAyo9AUoay1ucSnSKtrE+BClpMxARnm/ovS+8VlIip/v824R?=
 =?us-ascii?Q?92myO5Hk5/TQEqAt6KJ7l9xDgF6Z20aqtk7O3WhJDAPe4RvuhcgYulb5A+Yf?=
 =?us-ascii?Q?Mnpa27ElYJXPHxB3zQlKt5g5Owdac+WcgE0eajkUhXZDPA/xIf4bBtDGzV25?=
 =?us-ascii?Q?TX8keFOoxS2acptYxoPhqggVlREf9idP/aq6dLqwK4WkIOKbsQJwg1HuvnCz?=
 =?us-ascii?Q?t72dq140JV96/ooI5o48GvZJuyyyHoHWTy0mxAJV0EYT5aN4OFpZiTnSDand?=
 =?us-ascii?Q?gglPbdIaOFK6KVnvs5D64rHb87qriqyDUZ0HyHNa+dG82ZmGqIak/SJXnoWC?=
 =?us-ascii?Q?Lftll2gdGjkUD//cO6+76Qfhv9nony0VVggDAPYnmeEBLY4NimX6CSnE/7Bi?=
 =?us-ascii?Q?SvfVx+D+n116cb+UN0SmjvRHlOXS4Npttehc6/peNOO+/g9XB2Al9wMMiKcy?=
 =?us-ascii?Q?eFeSagkd5bbfzwxRSHanUWJC7dbUEqD71UdTI/fJc5ApxXZgchOdLarlNcL+?=
 =?us-ascii?Q?qwrMkkXnHh00PEY10iVY3/GdtJKepOhn09sPIB+bpawKKY9aOi8pjyXL9M4h?=
 =?us-ascii?Q?mwND/X1yme0onslxzP2o5hEDexlG+mnLU7bPXVVsWsWy0znjLLAXeQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR03MB5234.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JLskr5RtI5MU3lu17NzMgwjBxFL71BrYnfu3vQBJ7eXBQlpiTKRsrcZf7azJ?=
 =?us-ascii?Q?Cvvt1R0kbnaU5WRTTjwN5FRB6SmlZbE1mqcwKbQZ0o2RGHpUCXLOImutpKHt?=
 =?us-ascii?Q?wu6uKEMaaih+PHJSwDmWCZfRfXnUOOffUVlDRHQ4U60hoEa523P14sIALJt5?=
 =?us-ascii?Q?/jev4jmZXam3qEnJHfCLHokCd4wF3YgV7h9vi49j0HF12xQEWbwcaxvoy+z9?=
 =?us-ascii?Q?1Pg+a+I0qbTviZyiiSniERLrDAZ6/HEX/NChlv8viUweQ4lr0r6Ex0Q5xsDe?=
 =?us-ascii?Q?kTK6ZEiP6+YcAaiXInyvh0dng40PlBNv5JSV95E36alrq3655AKUGMYsD13F?=
 =?us-ascii?Q?Jw6TPMXhTDUtxReX8j12dig1AKn81+60T4PVYVmoVb9DH9N4zf6GlgPko9bT?=
 =?us-ascii?Q?G/k5qYEVVapvz2LPlLJVqymkIKd9eM0x17g4i2bSaUPTte2AFudRO8ySnOd1?=
 =?us-ascii?Q?IbP2Xgfr0UN+6typHTW32paS35BGgAigzxE5+ACWWdlhB5jvrRRjm90tJnKC?=
 =?us-ascii?Q?4j4WOvn5470FFqtIzR+f9qGqVmvdqDVYZD042lLZFdwlv4uQf0pEoILmQSj/?=
 =?us-ascii?Q?mttDM7F8397GIk5DsBtZjYwa5ZJ7i6/mDHsabF+ljOsfIb/qatXqEouqB5dS?=
 =?us-ascii?Q?nNSCgRNJYVQckPKeDwfVRqLDhNzGwbb4NQ2Sq7rHfbdJewWgZ33Iv6kQwoi6?=
 =?us-ascii?Q?nr3gIiMqpNiAI/4OW/9yBooCVBxLXoaZ3MWAaNZkHi2h9ZW6tG+xv3guujFi?=
 =?us-ascii?Q?34qCKly27ioPANAMcM27Q1CnmnD5dgqrNDO6fqcY4TYjRsH4qDD1atZNnNis?=
 =?us-ascii?Q?yZGBcdFyEHPlBXRfDAgS0tWwJNPpJ8AhBq873aRlwNJ+k1azeY7zZStr+B1P?=
 =?us-ascii?Q?C2f4TRAt8N64WWPRYqqQVntIXJpwx/V0DL9j/FrnLl9o7GQzs/6fiZwFDH0x?=
 =?us-ascii?Q?KBnVsPB7qJEw5cchlXSYMIBLuN8R2Hz3XzFpObQMmzpnF3cmOXucQPSuGvwO?=
 =?us-ascii?Q?ZxXzBKyYtoOvVq08LmGrQzF1qNas64xP46ItLZ+uuCGkKYHVZB94mO+MCnK2?=
 =?us-ascii?Q?/iejXBsbso0yMs/lQuv40nN+yLJnAZw6rAEd+CMyxQv3s8mRy6dBYcvTOmhI?=
 =?us-ascii?Q?t5R2ABiZDOXDJP4JRcvsArlP+nO6i5Xtxrd7ppPj2+cCnwQyueQpU5ojjvcD?=
 =?us-ascii?Q?LWp32Mb2Mm0hL5Dp+K6/U1uCn0jeu9NIgwaxQn7sTNG+d3m4K71C7Lckfnv1?=
 =?us-ascii?Q?eZXI+SD7GThRBAETd8t1W2CAwy/QuBTax2BCeWYU1KMT+Yni2FcJwwEy5Dgs?=
 =?us-ascii?Q?Sm1GdcWiwv2GmQAdgOJdf+lp0U7Yv3rSR8jtV6Mw9dHSdg1abIO4DDQEGniF?=
 =?us-ascii?Q?XZqGrG/DmWId0cycyzvrjb5Y/ymbkMUTDmXyi6OsxGXe0ZMX/xOXUn6oQ39H?=
 =?us-ascii?Q?DLO1/tsoXRszn04eoX1qdf3qzjQ6mhCwANFssljf4s2L8UAjbzYO2bPbnr8u?=
 =?us-ascii?Q?DPabB+SrzzIvK9mOf4NOe4rpZTk7WweEf9L+VOB37Dc2S7hwl8lhKz0AoV7T?=
 =?us-ascii?Q?gFluI/hCKPNQcaGrprkgIOlq87jJ7dr3hS13ecj7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5234.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ae2b96-d212-4ebe-a393-08ddeacdb3db
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 09:38:56.3012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pUchI8CNE6azZMA4PAVA6fCr3RDYohw78e53M6GD2tNw8pHGd1RIJrD4L35IwzBK1kPDyrdlEoe5GPasDIj7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7345
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

Hi,

> -----Original Message-----
> From: David Marchand <david.marchand@redhat.com>
> Sent: Wednesday, September 3, 2025 3:28 PM
> To: dev@dpdk.org
> Cc: thomas@monjalon.net; maxime.coquelin@redhat.com; Ajit Khaparde
> <ajit.khaparde@broadcom.com>; Vikas Gupta
> <vikas.gupta@broadcom.com>; Hemant Agrawal
> <hemant.agrawal@nxp.com>; Sachin Saxena <sachin.saxena@nxp.com>;
> Chenbo Xia <chenbox@nvidia.com>; Nipun Gupta <nipun.gupta@amd.com>;
> Anatoly Burakov <anatoly.burakov@intel.com>; Tomasz Duszynski
> <tduszynski@marvell.com>; Xu, Rosen <rosen.xu@altera.com>; Tyler
> Retzlaff <roretzla@linux.microsoft.com>; Harman Kalra
> <hkalra@marvell.com>
> Subject: [RFC 1/8] vfio: remove confusing check on VFIO presence
>=20
> [CAUTION: This email is from outside your organization. Unless you trust =
the
> sender, do not click on links or open attachments as it may be a fraudule=
nt
> email attempting to steal your information and/or compromise your
> computer.]
>=20
> Contrary to what the VFIO_PRESENT macro may suggest, there is no check
> on whether VFIO is enabled in the (build system) Linux kernel configurati=
on.
>=20
> Replace check on VFIO_PRESENT with RTE_EAL_VFIO (for components built
> on FreeBSD or Windows), or simply remove it otherwise.
>=20
> Then remove inclusion of rte_vfio.h when the only purpose was checking
> VFIO_PRESENT.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  doc/api/doxy-api.conf.in                   |  1 -
>  doc/guides/cryptodevs/bcmfs.rst            |  4 ----
>  drivers/bus/fslmc/fslmc_bus.c              | 12 +----------
>  drivers/bus/pci/linux/pci.c                | 22 --------------------
>  drivers/bus/pci/linux/pci_init.h           |  6 ------
>  drivers/bus/pci/linux/pci_vfio.c           | 12 -----------
>  drivers/bus/platform/bus_platform_driver.h | 20 +-----------------
>  drivers/bus/platform/platform.c            |  4 ----
>  drivers/bus/platform/platform_params.c     |  5 -----
>  drivers/crypto/bcmfs/bcmfs_vfio.c          | 11 +++++-----
>  drivers/raw/ifpga/afu_pmd_n3000.c          |  4 ----
>  lib/eal/include/rte_vfio.h                 | 24 ++++++++--------------
>  lib/eal/linux/eal.c                        |  4 ----
>  lib/eal/linux/eal_interrupts.c             | 15 --------------
>  lib/eal/linux/eal_vfio.h                   | 16 ---------------
>  lib/eal/linux/eal_vfio_mp_sync.c           | 10 ---------
>  16 files changed, 16 insertions(+), 154 deletions(-)
>=20
> diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in index
> 28cec3232f..bedd944681 100644
> --- a/doc/api/doxy-api.conf.in
> +++ b/doc/api/doxy-api.conf.in
> @@ -92,7 +92,6 @@ FILE_PATTERNS           =3D rte_*.h \
>  PREDEFINED              =3D __DOXYGEN__ \
>                            RTE_ATOMIC \
>                            RTE_HAS_CPUSET \
> -                          VFIO_PRESENT \
>                            __rte_lockable=3D \
>                            __rte_guarded_by(x)=3D \
>                            __rte_exclusive_locks_required(x)=3D \ diff --=
git
> a/doc/guides/cryptodevs/bcmfs.rst b/doc/guides/cryptodevs/bcmfs.rst
> index d18a253913..049808a49c 100644
> --- a/doc/guides/cryptodevs/bcmfs.rst
> +++ b/doc/guides/cryptodevs/bcmfs.rst
> @@ -59,10 +59,6 @@ Information about kernel, rootfs and toolchain can be
> found at  `Broadcom Official Website
> <https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw
> ww.broadcom.com%2Fproducts%2Fethernet-
> connectivity&data=3D05%7C02%7Crosen.xu%40altera.com%7C038088ded0da4
> 442083008ddeabb86b0%7Cfbd72e03d4a54110adce614d51f2077a%7C0%7C0%
> 7C638924813366144785%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGki
> OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjo
> yfQ%3D%3D%7C0%7C%7C%7C&sdata=3D3YpCIi%2BJEuMnf4j%2B6pmg0k6frao
> XiQu2J%2BftRefGL2Q%3D&reserved=3D0
>  /network-adapters/smartnic/stingray-software>`__.
>=20
> -    .. Note::
> -        To execute BCMFS PMD, it must be compiled with VFIO_PRESENT flag
> on the
> -        compiling platform and same gets enabled in rte_vfio.h.
> -
>  The BCMFS PMD may be compiled natively on a Stingray platform or  cross-
> compiled on an x86 platform. For example, below commands can be
> executed  for cross compiling on x86 platform.
> diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.=
c
> index ebc0c1fb4f..20458d5030 100644
> --- a/drivers/bus/fslmc/fslmc_bus.c
> +++ b/drivers/bus/fslmc/fslmc_bus.c
> @@ -574,9 +574,6 @@ fslmc_all_device_support_iova(void)
>  static enum rte_iova_mode
>  rte_dpaa2_get_iommu_class(void)
>  {
> -       bool is_vfio_noiommu_enabled =3D 1;
> -       bool has_iova_va;
> -
>         if (rte_eal_iova_mode() =3D=3D RTE_IOVA_PA)
>                 return RTE_IOVA_PA;
>=20
> @@ -584,14 +581,7 @@ rte_dpaa2_get_iommu_class(void)
>                 return RTE_IOVA_DC;
>=20
>         /* check if all devices on the bus support Virtual addressing or =
not */
> -       has_iova_va =3D fslmc_all_device_support_iova();
> -
> -#ifdef VFIO_PRESENT
> -       is_vfio_noiommu_enabled =3D rte_vfio_noiommu_is_enabled() =3D=3D =
true ?
> -                                               true : false;
> -#endif
> -
> -       if (has_iova_va && !is_vfio_noiommu_enabled)
> +       if (fslmc_all_device_support_iova() !=3D 0 &&
> + rte_vfio_noiommu_is_enabled() =3D=3D 0)
>                 return RTE_IOVA_VA;
>=20
>         return RTE_IOVA_PA;
> diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c in=
dex
> c20d159218..66d7e09a6e 100644
> --- a/drivers/bus/pci/linux/pci.c
> +++ b/drivers/bus/pci/linux/pci.c
> @@ -64,10 +64,8 @@ rte_pci_map_device(struct rte_pci_device *dev)
>         /* try mapping the NIC resources using VFIO if it exists */
>         switch (dev->kdrv) {
>         case RTE_PCI_KDRV_VFIO:
> -#ifdef VFIO_PRESENT
>                 if (pci_vfio_is_enabled())
>                         ret =3D pci_vfio_map_resource(dev); -#endif
>                 break;
>         case RTE_PCI_KDRV_IGB_UIO:
>         case RTE_PCI_KDRV_UIO_GENERIC:
> @@ -93,10 +91,8 @@ rte_pci_unmap_device(struct rte_pci_device *dev)
>         /* try unmapping the NIC resources using VFIO if it exists */
>         switch (dev->kdrv) {
>         case RTE_PCI_KDRV_VFIO:
> -#ifdef VFIO_PRESENT
>                 if (pci_vfio_is_enabled())
>                         pci_vfio_unmap_resource(dev); -#endif
>                 break;
>         case RTE_PCI_KDRV_IGB_UIO:
>         case RTE_PCI_KDRV_UIO_GENERIC:
> @@ -599,7 +595,6 @@ pci_device_iova_mode(const struct rte_pci_driver
> *pdrv,
>=20
>         switch (pdev->kdrv) {
>         case RTE_PCI_KDRV_VFIO: {
> -#ifdef VFIO_PRESENT
>                 static int is_vfio_noiommu_enabled =3D -1;
>=20
>                 if (is_vfio_noiommu_enabled =3D=3D -1) { @@ -612,7 +607,6=
 @@
> pci_device_iova_mode(const struct rte_pci_driver *pdrv,
>                         iova_mode =3D RTE_IOVA_PA;
>                 else if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_VA) =
!=3D 0)
>                         iova_mode =3D RTE_IOVA_VA; -#endif
>                 break;
>         }
>=20
> @@ -641,10 +635,8 @@ int rte_pci_read_config(const struct rte_pci_device
> *device,
>         case RTE_PCI_KDRV_IGB_UIO:
>         case RTE_PCI_KDRV_UIO_GENERIC:
>                 return pci_uio_read_config(intr_handle, buf, len, offset)=
; -#ifdef
> VFIO_PRESENT
>         case RTE_PCI_KDRV_VFIO:
>                 return pci_vfio_read_config(device, buf, len, offset); -#=
endif
>         default:
>                 rte_pci_device_name(&device->addr, devname,
>                                     RTE_DEV_NAME_MAX_LEN); @@ -665,10 +65=
7,8 @@ int
> rte_pci_write_config(const struct rte_pci_device *device,
>         case RTE_PCI_KDRV_IGB_UIO:
>         case RTE_PCI_KDRV_UIO_GENERIC:
>                 return pci_uio_write_config(intr_handle, buf, len, offset=
); -#ifdef
> VFIO_PRESENT
>         case RTE_PCI_KDRV_VFIO:
>                 return pci_vfio_write_config(device, buf, len, offset); -=
#endif
>         default:
>                 rte_pci_device_name(&device->addr, devname,
>                                     RTE_DEV_NAME_MAX_LEN); @@ -688,10 +67=
8,8 @@ int
> rte_pci_mmio_read(const struct rte_pci_device *device, int bar,
>         case RTE_PCI_KDRV_IGB_UIO:
>         case RTE_PCI_KDRV_UIO_GENERIC:
>                 return pci_uio_mmio_read(device, bar, buf, len, offset); =
-#ifdef
> VFIO_PRESENT
>         case RTE_PCI_KDRV_VFIO:
>                 return pci_vfio_mmio_read(device, bar, buf, len, offset);=
 -#endif
>         default:
>                 rte_pci_device_name(&device->addr, devname,
>                                     RTE_DEV_NAME_MAX_LEN); @@ -711,10 +69=
9,8 @@ int
> rte_pci_mmio_write(const struct rte_pci_device *device, int bar,
>         case RTE_PCI_KDRV_IGB_UIO:
>         case RTE_PCI_KDRV_UIO_GENERIC:
>                 return pci_uio_mmio_write(device, bar, buf, len, offset);=
 -#ifdef
> VFIO_PRESENT
>         case RTE_PCI_KDRV_VFIO:
>                 return pci_vfio_mmio_write(device, bar, buf, len, offset)=
; -#endif
>         default:
>                 rte_pci_device_name(&device->addr, devname,
>                                     RTE_DEV_NAME_MAX_LEN); @@ -731,12 +71=
7,10 @@
> rte_pci_ioport_map(struct rte_pci_device *dev, int bar,
>         int ret =3D -1;
>=20
>         switch (dev->kdrv) {
> -#ifdef VFIO_PRESENT
>         case RTE_PCI_KDRV_VFIO:
>                 if (pci_vfio_is_enabled())
>                         ret =3D pci_vfio_ioport_map(dev, bar, p);
>                 break;
> -#endif
>         case RTE_PCI_KDRV_IGB_UIO:
>         case RTE_PCI_KDRV_UIO_GENERIC:
>                 ret =3D pci_uio_ioport_map(dev, bar, p); @@ -757,11 +741,=
9 @@
> rte_pci_ioport_read(struct rte_pci_ioport *p,
>                 void *data, size_t len, off_t offset)  {
>         switch (p->dev->kdrv) {
> -#ifdef VFIO_PRESENT
>         case RTE_PCI_KDRV_VFIO:
>                 pci_vfio_ioport_read(p, data, len, offset);
>                 break;
> -#endif
>         case RTE_PCI_KDRV_IGB_UIO:
>         case RTE_PCI_KDRV_UIO_GENERIC:
>                 pci_uio_ioport_read(p, data, len, offset); @@ -777,11 +75=
9,9 @@
> rte_pci_ioport_write(struct rte_pci_ioport *p,
>                 const void *data, size_t len, off_t offset)  {
>         switch (p->dev->kdrv) {
> -#ifdef VFIO_PRESENT
>         case RTE_PCI_KDRV_VFIO:
>                 pci_vfio_ioport_write(p, data, len, offset);
>                 break;
> -#endif
>         case RTE_PCI_KDRV_IGB_UIO:
>         case RTE_PCI_KDRV_UIO_GENERIC:
>                 pci_uio_ioport_write(p, data, len, offset); @@ -798,12 +7=
78,10 @@
> rte_pci_ioport_unmap(struct rte_pci_ioport *p)
>         int ret =3D -1;
>=20
>         switch (p->dev->kdrv) {
> -#ifdef VFIO_PRESENT
>         case RTE_PCI_KDRV_VFIO:
>                 if (pci_vfio_is_enabled())
>                         ret =3D pci_vfio_ioport_unmap(p);
>                 break;
> -#endif
>         case RTE_PCI_KDRV_IGB_UIO:
>         case RTE_PCI_KDRV_UIO_GENERIC:
>                 ret =3D pci_uio_ioport_unmap(p); diff --git
> a/drivers/bus/pci/linux/pci_init.h b/drivers/bus/pci/linux/pci_init.h
> index a4d37c0d0a..6949dd57d9 100644
> --- a/drivers/bus/pci/linux/pci_init.h
> +++ b/drivers/bus/pci/linux/pci_init.h
> @@ -5,8 +5,6 @@
>  #ifndef EAL_PCI_INIT_H_
>  #define EAL_PCI_INIT_H_
>=20
> -#include <rte_vfio.h>
> -
>  #include "private.h"
>=20
>  /** IO resource type: */
> @@ -50,8 +48,6 @@ void pci_uio_ioport_write(struct rte_pci_ioport *p,
>                           const void *data, size_t len, off_t offset);  i=
nt
> pci_uio_ioport_unmap(struct rte_pci_ioport *p);
>=20
> -#ifdef VFIO_PRESENT
> -
>  /* access config space */
>  int pci_vfio_read_config(const struct rte_pci_device *dev,
>                          void *buf, size_t len, off_t offs); @@ -77,6 +73=
,4 @@ int
> pci_vfio_unmap_resource(struct rte_pci_device *dev);
>=20
>  int pci_vfio_is_enabled(void);
>=20
> -#endif
> -
>  #endif /* EAL_PCI_INIT_H_ */
> diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci=
_vfio.c
> index 5317170231..d0844585fe 100644
> --- a/drivers/bus/pci/linux/pci_vfio.c
> +++ b/drivers/bus/pci/linux/pci_vfio.c
> @@ -27,17 +27,6 @@
>  #include "pci_init.h"
>  #include "private.h"
>=20
> -/**
> - * @file
> - * PCI probing using Linux VFIO.
> - *
> - * This code tries to determine if the PCI device is bound to VFIO drive=
r,
> - * and initialize it (map BARs, set up interrupts) if that's the case.
> - *
> - */
> -
> -#ifdef VFIO_PRESENT
> -
>  static struct rte_tailq_elem rte_vfio_tailq =3D {
>         .name =3D "VFIO_RESOURCE_LIST",
>  };
> @@ -1327,4 +1316,3 @@ pci_vfio_is_enabled(void)
>         }
>         return status;
>  }
> -#endif
> diff --git a/drivers/bus/platform/bus_platform_driver.h
> b/drivers/bus/platform/bus_platform_driver.h
> index ef4b27c0c0..76403043c1 100644
> --- a/drivers/bus/platform/bus_platform_driver.h
> +++ b/drivers/bus/platform/bus_platform_driver.h
> @@ -15,9 +15,9 @@
>=20
>  #include <dev_driver.h>
>  #include <rte_common.h>
> +#include <rte_compat.h>
>  #include <rte_dev.h>
>  #include <rte_os.h>
> -#include <rte_vfio.h>
>=20
>  #ifdef __cplusplus
>  extern "C" {
> @@ -144,8 +144,6 @@ RTE_PMD_EXPORT_NAME(nm)  #define
> RTE_PMD_REGISTER_ALIAS(nm, alias) \  static const char *pdrvinit_ ## nm
> ## _alias =3D RTE_STR(alias)
>=20
> -#ifdef VFIO_PRESENT
> -
>  /**
>   * Register a platform device driver.
>   *
> @@ -170,22 +168,6 @@ void rte_platform_register(struct
> rte_platform_driver *pdrv);  __rte_internal  void
> rte_platform_unregister(struct rte_platform_driver *pdrv);
>=20
> -#else
> -
> -__rte_internal
> -static inline void
> -rte_platform_register(struct rte_platform_driver *pdrv __rte_unused) -{ =
-}
> -
> -__rte_internal
> -static inline void
> -rte_platform_unregister(struct rte_platform_driver *pdrv __rte_unused) -
> { -}
> -
> -#endif /* VFIO_PRESENT */
> -
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/drivers/bus/platform/platform.c
> b/drivers/bus/platform/platform.c index 0f50027236..90524fd961 100644
> --- a/drivers/bus/platform/platform.c
> +++ b/drivers/bus/platform/platform.c
> @@ -25,8 +25,6 @@
>=20
>  #include "private.h"
>=20
> -#ifdef VFIO_PRESENT
> -
>  #define PLATFORM_BUS_DEVICES_PATH "/sys/bus/platform/devices"
>=20
>  RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_register)
> @@ -647,5 +645,3 @@ struct rte_platform_bus platform_bus =3D {
>=20
>  RTE_REGISTER_BUS(platform, platform_bus.bus);
> RTE_LOG_REGISTER_DEFAULT(platform_bus_logtype, NOTICE);
> -
> -#endif /* VFIO_PRESENT */
> diff --git a/drivers/bus/platform/platform_params.c
> b/drivers/bus/platform/platform_params.c
> index 8a6214b97c..65b20d121f 100644
> --- a/drivers/bus/platform/platform_params.c
> +++ b/drivers/bus/platform/platform_params.c
> @@ -10,13 +10,10 @@
>  #include <rte_dev.h>
>  #include <rte_errno.h>
>  #include <rte_kvargs.h>
> -#include <rte_vfio.h>
>=20
>  #include "bus_platform_driver.h"
>  #include "private.h"
>=20
> -#ifdef VFIO_PRESENT
> -
>  enum platform_params {
>         RTE_PLATFORM_PARAM_NAME,
>  };
> @@ -73,5 +70,3 @@ platform_bus_dev_iterate(const void *start, const char
> *str,
>=20
>         return dev;
>  }
> -
> -#endif /* VFIO_PRESENT */
> diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c
> b/drivers/crypto/bcmfs/bcmfs_vfio.c
> index dc2def580f..8d6ea16544 100644
> --- a/drivers/crypto/bcmfs/bcmfs_vfio.c
> +++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
> @@ -7,13 +7,14 @@
>  #include <sys/mman.h>
>  #include <sys/ioctl.h>
>=20
> -#include <rte_vfio.h>
> -
>  #include "bcmfs_device.h"
>  #include "bcmfs_logs.h"
>  #include "bcmfs_vfio.h"
>=20
> -#ifdef VFIO_PRESENT
> +#ifdef RTE_EAL_VFIO
> +
> +#include <rte_vfio.h>
> +
>  static int
>  vfio_map_dev_obj(const char *path, const char *dev_obj,
>                  uint32_t *size, void **addr, int *dev_fd) @@ -93,7 +94,7=
 @@
> bcmfs_release_vfio(struct bcmfs_device *dev)
>                 return;
>         }
>  }
> -#else
> +#else /* ! RTE_EAL_VFIO */
>  int
>  bcmfs_attach_vfio(struct bcmfs_device *dev __rte_unused)  { @@ -104,4
> +105,4 @@ void  bcmfs_release_vfio(struct bcmfs_device *dev
> __rte_unused)  {  } -#endif
> +#endif /* RTE_EAL_VFIO */
> diff --git a/drivers/raw/ifpga/afu_pmd_n3000.c
> b/drivers/raw/ifpga/afu_pmd_n3000.c
> index 6aae1b224e..0882a27701 100644
> --- a/drivers/raw/ifpga/afu_pmd_n3000.c
> +++ b/drivers/raw/ifpga/afu_pmd_n3000.c
> @@ -1473,7 +1473,6 @@ static struct rte_pci_device
> *n3000_afu_get_pci_dev(struct afu_rawdev *dev)
>         return RTE_DEV_TO_PCI(afudev->rawdev->device);
>  }
>=20
> -#ifdef VFIO_PRESENT
>  static int dma_afu_set_irqs(struct afu_rawdev *dev, uint32_t vec_start,
>         uint32_t count, int *efds)
>  {
> @@ -1511,7 +1510,6 @@ static int dma_afu_set_irqs(struct afu_rawdev
> *dev, uint32_t vec_start,
>         rte_free(irq_set);
>         return ret;
>  }
> -#endif
>=20
>  static void *n3000_afu_get_port_addr(struct afu_rawdev *dev)  { @@ -
> 1724,10 +1722,8 @@ static int dma_afu_ctx_init(struct afu_rawdev *dev, in=
t
> index, uint8_t *addr)
>                         IFPGA_RAWDEV_PMD_ERR("eventfd create failed");
>                         return -EBADF;
>                 }
> -#ifdef VFIO_PRESENT
>                 if (dma_afu_set_irqs(dev, vec_start, 1, efds))
>                         IFPGA_RAWDEV_PMD_ERR("DMA interrupt setup failed"=
); -
> #endif
>         }
>         ctx->event_fd =3D efds[0];
>=20
> diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h inde=
x
> 923293040b..594d504c56 100644
> --- a/lib/eal/include/rte_vfio.h
> +++ b/lib/eal/include/rte_vfio.h
> @@ -15,24 +15,16 @@
>=20
>  #include <rte_compat.h>
>=20
> -/*
> - * determine if VFIO is present on the system
> - */
> -#if !defined(VFIO_PRESENT) && defined(RTE_EAL_VFIO) -#include
> <linux/version.h> -#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(3, 6, 0) -
> #define VFIO_PRESENT -#endif /* kernel version >=3D 3.6.0 */ -#if
> LINUX_VERSION_CODE >=3D KERNEL_VERSION(4, 0, 0) -#define
> HAVE_VFIO_DEV_REQ_INTERFACE -#endif /* kernel version >=3D 4.0.0 */ -
> #endif /* RTE_EAL_VFIO */
> -
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
>=20
> -#ifdef VFIO_PRESENT
> +#ifdef RTE_EAL_VFIO
> +
> +#include <linux/version.h>
> +#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(4, 0, 0) #define
> +HAVE_VFIO_DEV_REQ_INTERFACE #endif /* kernel version >=3D 4.0.0 */
>=20
>  #include <linux/vfio.h>
>=20
> @@ -102,12 +94,12 @@ struct vfio_device_feature_bus_master {  };  #endif
>=20
> -#else /* not VFIO_PRESENT */
> +#else /* ! RTE_EAL_VFIO */
>=20
>  /* we don't need an actual definition, only pointer is used */  struct
> vfio_device_info;
>=20
> -#endif /* VFIO_PRESENT */
> +#endif /* RTE_EAL_VFIO */
>=20
>  #define RTE_VFIO_DEFAULT_CONTAINER_FD (-1)
>=20
> diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c index
> 52efb8626b..708a387265 100644
> --- a/lib/eal/linux/eal.c
> +++ b/lib/eal/linux/eal.c
> @@ -1121,14 +1121,12 @@ rte_eal_init(int argc, char **argv)  #endif
>         }
>=20
> -#ifdef VFIO_PRESENT
>         if (rte_vfio_enable("vfio")) {
>                 rte_eal_init_alert("Cannot init VFIO");
>                 rte_errno =3D EAGAIN;
>                 rte_atomic_store_explicit(&run_once, 0,
> rte_memory_order_relaxed);
>                 return -1;
>         }
> -#endif
>         /* in secondary processes, memory init may allocate additional fb=
arrays
>          * not present in primary processes, so to avoid any potential is=
sues,
>          * initialize memzones first.
> @@ -1330,9 +1328,7 @@ rte_eal_cleanup(void)
>                 rte_memseg_walk(mark_freeable, NULL);
>=20
>         rte_service_finalize();
> -#ifdef VFIO_PRESENT
>         vfio_mp_sync_cleanup();
> -#endif
>         rte_mp_channel_cleanup();
>         eal_bus_cleanup();
>         rte_eal_alarm_cleanup();
> diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupt=
s.c
> index 4ec78de82c..d420ecf947 100644
> --- a/lib/eal/linux/eal_interrupts.c
> +++ b/lib/eal/linux/eal_interrupts.c
> @@ -57,9 +57,7 @@ union intr_pipefds{
>   */
>  union rte_intr_read_buffer {
>         int uio_intr_count;              /* for uio device */
> -#ifdef VFIO_PRESENT
>         uint64_t vfio_intr_count;        /* for vfio device */
> -#endif
>         uint64_t timerfd_num;            /* for timerfd */
>         char charbuf[16];                /* for others */
>  };
> @@ -95,8 +93,6 @@ static struct rte_intr_source_list intr_sources;  stati=
c
> rte_thread_t intr_thread;
>=20
>  /* VFIO interrupts */
> -#ifdef VFIO_PRESENT
> -
>  #define IRQ_SET_BUF_LEN  (sizeof(struct vfio_irq_set) + sizeof(int))
>  /* irq set buffer length for queue interrupts and LSC interrupt */  #def=
ine
> MSIX_IRQ_SET_BUF_LEN (sizeof(struct vfio_irq_set) + \ @@ -401,7 +397,6
> @@ vfio_disable_req(const struct rte_intr_handle *intr_handle)
>         return ret;
>  }
>  #endif
> -#endif
>=20
>  static int
>  uio_intx_intr_disable(const struct rte_intr_handle *intr_handle) @@ -734=
,7
> +729,6 @@ rte_intr_enable(const struct rte_intr_handle *intr_handle)
>         case RTE_INTR_HANDLE_ALARM:
>                 rc =3D -1;
>                 break;
> -#ifdef VFIO_PRESENT
>         case RTE_INTR_HANDLE_VFIO_MSIX:
>                 if (vfio_enable_msix(intr_handle))
>                         rc =3D -1;
> @@ -752,7 +746,6 @@ rte_intr_enable(const struct rte_intr_handle
> *intr_handle)
>                 if (vfio_enable_req(intr_handle))
>                         rc =3D -1;
>                 break;
> -#endif
>  #endif
>         /* not used at this moment */
>         case RTE_INTR_HANDLE_DEV_EVENT:
> @@ -807,7 +800,6 @@ rte_intr_ack(const struct rte_intr_handle
> *intr_handle)
>         /* not used at this moment */
>         case RTE_INTR_HANDLE_ALARM:
>                 return -1;
> -#ifdef VFIO_PRESENT
>         /* VFIO MSI* is implicitly acked unlike INTx, nothing to do */
>         case RTE_INTR_HANDLE_VFIO_MSIX:
>         case RTE_INTR_HANDLE_VFIO_MSI:
> @@ -819,7 +811,6 @@ rte_intr_ack(const struct rte_intr_handle
> *intr_handle)  #ifdef HAVE_VFIO_DEV_REQ_INTERFACE
>         case RTE_INTR_HANDLE_VFIO_REQ:
>                 return -1;
> -#endif
>  #endif
>         /* not used at this moment */
>         case RTE_INTR_HANDLE_DEV_EVENT:
> @@ -868,7 +859,6 @@ rte_intr_disable(const struct rte_intr_handle
> *intr_handle)
>         case RTE_INTR_HANDLE_ALARM:
>                 rc =3D -1;
>                 break;
> -#ifdef VFIO_PRESENT
>         case RTE_INTR_HANDLE_VFIO_MSIX:
>                 if (vfio_disable_msix(intr_handle))
>                         rc =3D -1;
> @@ -886,7 +876,6 @@ rte_intr_disable(const struct rte_intr_handle
> *intr_handle)
>                 if (vfio_disable_req(intr_handle))
>                         rc =3D -1;
>                 break;
> -#endif
>  #endif
>         /* not used at this moment */
>         case RTE_INTR_HANDLE_DEV_EVENT:
> @@ -948,7 +937,6 @@ eal_intr_process_interrupts(struct epoll_event
> *events, int nfds)
>                 case RTE_INTR_HANDLE_ALARM:
>                         bytes_read =3D sizeof(buf.timerfd_num);
>                         break;
> -#ifdef VFIO_PRESENT
>  #ifdef HAVE_VFIO_DEV_REQ_INTERFACE
>                 case RTE_INTR_HANDLE_VFIO_REQ:
>  #endif
> @@ -957,7 +945,6 @@ eal_intr_process_interrupts(struct epoll_event
> *events, int nfds)
>                 case RTE_INTR_HANDLE_VFIO_LEGACY:
>                         bytes_read =3D sizeof(buf.vfio_intr_count);
>                         break;
> -#endif
>                 case RTE_INTR_HANDLE_VDEV:
>                 case RTE_INTR_HANDLE_EXT:
>                         bytes_read =3D 0;
> @@ -1221,13 +1208,11 @@ eal_intr_proc_rxtx_intr(int fd, const struct
> rte_intr_handle *intr_handle)
>         case RTE_INTR_HANDLE_UIO_INTX:
>                 bytes_read =3D sizeof(buf.uio_intr_count);
>                 break;
> -#ifdef VFIO_PRESENT
>         case RTE_INTR_HANDLE_VFIO_MSIX:
>         case RTE_INTR_HANDLE_VFIO_MSI:
>         case RTE_INTR_HANDLE_VFIO_LEGACY:
>                 bytes_read =3D sizeof(buf.vfio_intr_count);
>                 break;
> -#endif
>         case RTE_INTR_HANDLE_VDEV:
>                 bytes_read =3D rte_intr_efd_counter_size_get(intr_handle)=
;
>                 /* For vdev, number of bytes to read is set by driver */ =
diff --git
> a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h index
> 23a787ad20..e7d855c032 100644
> --- a/lib/eal/linux/eal_vfio.h
> +++ b/lib/eal/linux/eal_vfio.h
> @@ -7,20 +7,6 @@
>=20
>  #include <rte_common.h>
>=20
> -/*
> - * determine if VFIO is present on the system
> - */
> -#if !defined(VFIO_PRESENT) && defined(RTE_EAL_VFIO) -#include
> <linux/version.h> -#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(3, 6, 0) -
> #define VFIO_PRESENT -#else -#pragma message("VFIO configured but not
> supported by this kernel, disabling.") -#endif /* kernel version >=3D 3.6=
.0 */ -
> #endif /* RTE_EAL_VFIO */
> -
> -#ifdef VFIO_PRESENT
> -
>  #include <stdint.h>
>  #include <linux/vfio.h>
>=20
> @@ -154,6 +140,4 @@ struct vfio_mp_param {
>         };
>  };
>=20
> -#endif /* VFIO_PRESENT */
> -
>  #endif /* EAL_VFIO_H_ */
> diff --git a/lib/eal/linux/eal_vfio_mp_sync.c
> b/lib/eal/linux/eal_vfio_mp_sync.c
> index ce14e260fe..8230f3d24d 100644
> --- a/lib/eal/linux/eal_vfio_mp_sync.c
> +++ b/lib/eal/linux/eal_vfio_mp_sync.c
> @@ -14,15 +14,6 @@
>  #include "eal_private.h"
>  #include "eal_vfio.h"
>=20
> -/**
> - * @file
> - * VFIO socket for communication between primary and secondary
> processes.
> - *
> - * This file is only compiled if RTE_EAL_VFIO is set.
> - */
> -
> -#ifdef VFIO_PRESENT
> -
>  static int
>  vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)  { @@ -
> 129,4 +120,3 @@ vfio_mp_sync_cleanup(void)
>=20
>         rte_mp_action_unregister(EAL_VFIO_MP);
>  }
> -#endif
> --
> 2.51.0

Reviewed-by: Rosen Xu <rosen.xu@altera.com>
