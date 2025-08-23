Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7E0CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 Aug 2025 19:25:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0935C402A2;
	Sat, 23 Aug 2025 21:25:06 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by mails.dpdk.org (Postfix) with ESMTP id BF8BB4025E;
 Sat, 23 Aug 2025 21:25:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZW49Aba9Cu4jMgXgrhH4nScWkMy80928DPIp09oq8JoguhA/WDsmSlxyUsQUDmvk1LPO1jOek8guk/1L4da6cEoypfwgIH+ZVoEYpkQCVHfc9qWs6p1PnSmC3ntEp+bWQarOchr7auPuzO7xeawG7c7Qs2kX0oHNDUxV4vbc4sDGhMYEn9Dv7nUpHjfQoVs0tTZs+gslScgs+e67cG2i3i+IXHyb03b4B+vtf/9TDqcoxs6E5jy1N7bCcwcXTxyM8cpOgcC920/ZiJ0s3pFphp282ET0QhA69/oqCn1Lmvdh18BYqIeHa8PfDNU+GeBxU8UIBpb8xA+PwJHg+Y2NPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MDgfCDdWGQiTnqqWw2km9ZNqlf18Flhs65bBePk7Mc=;
 b=pHWVTu1j6TFLOJlCHx99tVSe1BNBRVqxGlVlis7yauR+A/EENvEB0KIMMbkfTL4Ht/O39OmIK93XXlCMzhxMXt0zmYqUQW9OhX8cBWa7NG+MGZQoH6i92shlffmBQcgSQcdiaGPaXtE6h12Mv8laKEAMJmmDdn3QMZj2SxIt6TlgXtnPYBgPhrd/SiyB/26NbUR1XJafnz98mFRRzIf8ul3U2DuUncn0baCaprFZpet0GaQq4Y/2VkBM4yP1EceF3qBbSdbgaXSm1XhwdtnAqQH2zv4V3ll7a5sW06yFrj48jKMHkWGuqyv3XOtjdy46jEZOYNJ7jAQJqBJ7iselhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MDgfCDdWGQiTnqqWw2km9ZNqlf18Flhs65bBePk7Mc=;
 b=LEYmQckVue1K3/r/mXrXk1t7aVjRzi7hlAfX/qz9MLhlKJqzyjlZXfVokfMYLe/udjVohv1zGZcdYhEP4fbG8mjLC79OnvvcHZPdMTHCUOPeVpfVNNlqLL0vW7ai77nqg3pVTxgifBhO20GMRPWoylJwhXDMBKkLmHB8QpJGRcmen/F5+R3spG4PM+s0IeCu34gPE5PW6JypP7XlQ1qRcvnvspDZIOux3naFyaLNO2BmIw/rCr4MKjNstROEtMfZHmzKczxkmAvjha3dwMlMnlJs0d5CemB5CKYVsNeBmz5lO0jWlzCW7OoflGI1Wc/XHaVMP3M3zpdlKvdF8vYDkw==
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 19:25:02 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%4]) with mapi id 15.20.9052.014; Sat, 23 Aug 2025
 19:25:01 +0000
From: Xueming Li <xuemingl@nvidia.com>
To: Ali Alnubani <alialnu@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, David Christensen <drc@linux.vnet.ibm.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, Raslan
 Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 "qian.q.xu@intel.com" <qian.q.xu@intel.com>, "yuan.peng@intel.com"
 <yuan.peng@intel.com>, "zhaoyan.chen@intel.com" <zhaoyan.chen@intel.com>
Subject: Re: 23.11.5 patches review and test
Thread-Topic: 23.11.5 patches review and test
Thread-Index: AQHcCsXBAV2qxzmDY0WUtvSeMh56KLRqJdIAgAaLtk4=
Date: Sat, 23 Aug 2025 19:25:01 +0000
Message-ID: <CH3PR12MB865848892AA41B5EA3E4228EA13CA@CH3PR12MB8658.namprd12.prod.outlook.com>
References: <20250811134220.45579-1-xuemingl@nvidia.com>
 <8a89c883-e287-4640-80f2-576f6e8a1e71@nvidia.com>
In-Reply-To: <8a89c883-e287-4640-80f2-576f6e8a1e71@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8658:EE_|PH7PR12MB5830:EE_
x-ms-office365-filtering-correlation-id: 57e72af2-eb56-41b6-e415-08dde27ac19e
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018|7053199007|8096899003|13003099007;
x-microsoft-antispam-message-info: =?us-ascii?Q?zO3ohtneiJoylrN1P3l+2QBZdAlyeJpN0DVO5t3dNH7fC3h+T9CPlQiuwdg7?=
 =?us-ascii?Q?vtmLCJTyGxvCA20/r+6qCN9qLS34N1hwQwZGPSG8is1anTthjL1EMmw7EiWp?=
 =?us-ascii?Q?8yWPcCEauvpNNf20ndF2NijStWezYRqx570RfvK1is3DRPVxbZGF1sLh2oLG?=
 =?us-ascii?Q?UeMe9zZ8hB+d7fvUh7RxmmMzNqFCET24og93pP1ou2aJiz8CUAU81HNrNkrA?=
 =?us-ascii?Q?pxRgxKSrAp1ygeUahMci1qcvDskd+v8pf2APvl0xLxUi2PXNk3yRfwBdCZkO?=
 =?us-ascii?Q?U2oWjYutlhN4kWr4AzH+ayiOMoJqWGHgua7hIvmWtoB6EEItC+NKYtKnhTkH?=
 =?us-ascii?Q?RRU6z843An11NfiZClompZtvYYd19CiYAzFq+3UsKT4Qa7EvzGvhxAJ0+rCy?=
 =?us-ascii?Q?XaM6G0zHHUJjCrYdl63O+PEFNituKTChv+Z6QpsBdqKodseA74LOkbPWrsnN?=
 =?us-ascii?Q?FpiPRtq37e5NvGRXarfkdWUO0eWMrCOiQIpXhBFqJLdDH9w8tsuk8zgCCUKQ?=
 =?us-ascii?Q?is0EzitcWV4XpZBNNtYpY0UrsPAc6krRnkVl0+I2QR02slgwLEeGhf7m481G?=
 =?us-ascii?Q?vLY3YXz7kdfIKSdDzNouH98caSu7xlhuskx7VWMXgGiRzkp/1IrbDptFBZp7?=
 =?us-ascii?Q?Srfkaa5YIXZLnO+sqiQWkI7IIzP0UfQ2ubtQ8pJahS77mFewbFEyJt9Xf5/Q?=
 =?us-ascii?Q?UvJfmSmpo/EtvlwLwrX8DTxaRigzneJhXpK7cCTyLrpoaDWP8CBI2nbkkTah?=
 =?us-ascii?Q?h0IDpPvmx1m+QlMT15Mv5Z7El4D8V7X0eB7jB0xOiJfRibB42ouJvioMsdgU?=
 =?us-ascii?Q?A244mmPyVCePv+8tNroV4otX/qgaMBMIoB1QesvDdSnNLkyC0n2S1YiOFFqI?=
 =?us-ascii?Q?2A0zIO5kWCQaL+q/ybt62YJJPq/yYyTURWbYcBH9FeFUJ5KiddSsB3epPqp2?=
 =?us-ascii?Q?BbSVQhF5ctPLTBLmL1U3nBGs5fxpdQvW0aMWunL0lY6ng6y9kw8C0smuGH1w?=
 =?us-ascii?Q?//47Zi8eSc0i3i6PmmvofYUe3t9eYiRPIczo7+h5aTBHXwZsq6Tg2wiha8b1?=
 =?us-ascii?Q?MgPrFRmQdUBsuZl1eD+JdjQCKwkkUds2sSgACvFufKrpcyeeIgIRVC7hq1Rx?=
 =?us-ascii?Q?Exl1Of2eAAyYRqSwCuaXi89MlMKKCUpDe5+uAL86E9x2TpWu8yGGARb5MN9a?=
 =?us-ascii?Q?EvNk6mJ0CO0mEhhAT14woA9VBPoGcAudI7UxlSEFcIzHLgPjWUDi1Y0bqokX?=
 =?us-ascii?Q?tldjqRVJEcJV8SWYERvNXyhpMXzwUUNDwQ3DWRBBlaaRwAi0jwZQIfApHxxK?=
 =?us-ascii?Q?8NPt4ki/aohxOOKBwZGCOIR9eiM9b6wXhDSOiv3o45gyGIS2fQes5F4sB4rv?=
 =?us-ascii?Q?EYTgtpW5tgECr5dz8KfvFcd0VveVJ3x0Qj9zYoMuv7tKxmzQ000mtPxuknJu?=
 =?us-ascii?Q?peUVxlVuuWSYY8Kc8Ecu9/7ITsdh8FKwbrnUqy0dvJOOusFwlFN/sxTYVuu6?=
 =?us-ascii?Q?fIUhaeGctoeN5mc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8658.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(7053199007)(8096899003)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u1zMyuIDKxmlQtVKJd06CGYBtr9GxEUtA3GYno/LZfEJ3BjdQY6WHUMxnhxR?=
 =?us-ascii?Q?l67l62v9DYSds0KMy3ywutzJzU59sTgseuGLqQBhCdcGUBrqp3vP4SE6NSwg?=
 =?us-ascii?Q?TbzJ5toTI2C4G4+aE5c91pWpz0ALtv+0wD5pIrIP2/lKY2CZtOFSuixe92ZQ?=
 =?us-ascii?Q?9ugrZXi+4OgscTADqNVWCqfh9Rjo8LOgs1wGX8w+1de5m40FloW+qbtkqcV+?=
 =?us-ascii?Q?Jc2TowN3dV0HiNfbiAhkxfyzFm0FvOBZ7SI2PQHCtJbqJ+YNCVLolSECYie0?=
 =?us-ascii?Q?YOOz2wjil9+oVX4M74xIfsfvmm4IvEwoSnT25oOUBqN1g0LRZd8R7UJHjDaM?=
 =?us-ascii?Q?xOi8xD4UV4WuOD4G160WBWhzqSOGNzHSiaKeUJECiDVWZomOXSBDyjtEqDQU?=
 =?us-ascii?Q?BuJKFLZdKI3Tyrs1O0vr75u5roCfmBG9xFz7tpLAjSvgGz4VwEDZ1EJr0gKw?=
 =?us-ascii?Q?K6olJi15BACHp+rVsAV59iZzPA/5XqH8IrJ/gErj4EhVE/L5H+wHjTm7CFY6?=
 =?us-ascii?Q?UW2LGtxD8VGXMkaReXcLcUhVwEzu9T5p9K6Z2NC2GhAWUIESIsGxRjrkQ12k?=
 =?us-ascii?Q?Pc2ZHD7fjAUjiyfmBX/sL60/0sWvZJNasKP0Y/TvMrxSpv9C+U+tU9Qk3IeX?=
 =?us-ascii?Q?TdTZuWvRcKk8Wv4XAXylDuL4w4olnPXRB2BDTAZfa9b1y8TPhMwH3l0fe2GC?=
 =?us-ascii?Q?VewHRcFdBJLCa7yx7q/DLhR+CtGCLAx9zNDs69nqLB2Usrs9lf8xSHEaOyE8?=
 =?us-ascii?Q?Vpr0UWMbwGLghi6gqkmyC3I+SuMHetfUOo7uCmWP1sSXR4EF/tRalEBOTrtX?=
 =?us-ascii?Q?3w6VcP7bp1wRhlsNkPRHFtUCKa6k0tD/KDnU450jLkEh3AUKPrAZaRtK+6vT?=
 =?us-ascii?Q?NHPPdOYCoGDFAbSmB+25qiWWuVKTUByUlPBMLAhHU47R0pSnUmeokUZLkyWe?=
 =?us-ascii?Q?jsKuHf18b/7YzTwZL5+jE/WrZb74k2giTfKJkql++Bp4TSiWye7hXmAc8Rsi?=
 =?us-ascii?Q?Qp3icZDaMqijBXKqCY9Ggs2eu6bYZckc5QL/wYwgVNgtsTW5qgAvGhzVzZlQ?=
 =?us-ascii?Q?MJ6qLPAEiirjMJAmvrh8QNcAo/qHz3BL9c9GIttDd7sbhsMLNY2Lpx5taO8D?=
 =?us-ascii?Q?jr0bvRW+J8AsYso4YnxCZuKvG9oD7gckp0tYvsxZT3NSYOi10mNEmvjE0qIr?=
 =?us-ascii?Q?HBaLhBRqjme+ftsIfHnfLXCqt4V2qiTy0qGJ6ijZ79S1qWjmWYBqwifyDRrk?=
 =?us-ascii?Q?IrjDwxVIZcbEqMRA4W86EQdoR5W3zcLsG/kdwuPCEAVfrNSMxLpd4XU2oTmH?=
 =?us-ascii?Q?V8zcNSGR/vemaQVLo4PnvJTAzpW3s5yUUGGRvvyvW/kGUno0MvqkqDOfQqe2?=
 =?us-ascii?Q?W/vKKPCwkSBAJZfYISBUFP148gu7lgU/5QWCJOWIcLg2vGrB5sqIuJx9qrbh?=
 =?us-ascii?Q?Xq/jGOxs6heCjSd9JRBWU/0gbXDH8n9laNzsZU0uqxXXWzYFQVRvxu/5Ugrx?=
 =?us-ascii?Q?ba8tT+zRKE/VxaIO6CcyL2xszmVHGAQczno6oOcpkfrIKGY4b9ZuKBhJgA1i?=
 =?us-ascii?Q?Z3NrtB/4sFwgmaaC9ckvk0EyfGTD/vro05f6Qoby?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB865848892AA41B5EA3E4228EA13CACH3PR12MB8658namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e72af2-eb56-41b6-e415-08dde27ac19e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 19:25:01.8292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31swZ5GWXAG2zmVbdWRwZfvZ4H4CToQbSuPCi6MpX5xFLx+DV8rNkxSlghT4bUUtR+z0BiPr7Myozfze35JD8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
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

--_000_CH3PR12MB865848892AA41B5EA3E4228EA13CACH3PR12MB8658namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Ali,

Thanks very much for your help!

________________________________
From: Ali Alnubani <alialnu@nvidia.com>
Sent: Tuesday, August 19, 2025 11:26 PM
To: Xueming Li <xuemingl@nvidia.com>; stable@dpdk.org <stable@dpdk.org>
Cc: dev@dpdk.org <dev@dpdk.org>; Abhishek Marathe <Abhishek.Marathe@microso=
ft.com>; David Christensen <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant=
.agrawal@nxp.com>; Ian Stokes <ian.stokes@intel.com>; Jerin Jacob <jerinj@m=
arvell.com>; John McNamara <john.mcnamara@intel.com>; Ju-Hyoung Lee <juhlee=
@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>; Luca Boccassi <bluca@=
debian.org>; Pei Zhang <pezhang@redhat.com>; Raslan Darawsheh <rasland@nvid=
ia.com>; NBU-Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; Yang=
hang Liu <yanghliu@redhat.com>; benjamin.walker@intel.com <benjamin.walker@=
intel.com>; qian.q.xu@intel.com <qian.q.xu@intel.com>; yuan.peng@intel.com =
<yuan.peng@intel.com>; zhaoyan.chen@intel.com <zhaoyan.chen@intel.com>
Subject: Re: 23.11.5 patches review and test

On 8/11/25 4:42 PM, Xueming Li wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.5.
>
> The planned date for the final release is 15th August.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.11.5-rc1
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Xueming Li <xuemingl@nvidia.com>
>
> ---

Hello,

We ran the following functional tests with Nvidia hardware on v23.11.5-rc1:
- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- rte_flow tests
(https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
- RSS tests.
- VLAN filtering, stripping, and insertion tests.
- Checksum and TSO tests.
- ptype tests.
- link_status_interrupt example application tests.
- l3fwd-power example application tests.
- Multi-process example applications tests.
- Hardware LRO tests.
- Buffer Split tests.
- Tx scheduling tests.

Functional tests ran on:
- NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver:
MLNX_OFED_LINUX-23.10-5.1.4.0 / Firmware: 22.39.5050
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver:
MLNX_OFED_LINUX-23.10-5.1.4.0 / Firmware: 28.39.5050
- DPU: BlueField-2 / DOCA SW version: 2.5.4 / Firmware: 24.39.5050

Additionally, we ran build tests with multiple configurations on the
following OS/driver combinations (all passed):
- Debian 12 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 22.04 with rdma-core master (091ddb5).
- Ubuntu 24.04 with rdma-core v50.0.
- Fedora 42 with rdma-core v55.0.
- Fedora 43 (Rawhide) with rdma-core v58.0.
- OpenSUSE Leap 15.6 with rdma-core v49.1.
- Windows Server 2022 with Clang 18.1.8.

We don't see new issues caused by the changes in this release.

Thanks,
Ali


--_000_CH3PR12MB865848892AA41B5EA3E4228EA13CACH3PR12MB8658namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Ali,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks very much for your help!</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ali Alnubani &lt;alia=
lnu@nvidia.com&gt;<br>
<b>Sent:</b> Tuesday, August 19, 2025 11:26 PM<br>
<b>To:</b> Xueming Li &lt;xuemingl@nvidia.com&gt;; stable@dpdk.org &lt;stab=
le@dpdk.org&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Abhishek Marathe &lt;Abhishek=
.Marathe@microsoft.com&gt;; David Christensen &lt;drc@linux.vnet.ibm.com&gt=
;; Hemant Agrawal &lt;hemant.agrawal@nxp.com&gt;; Ian Stokes &lt;ian.stokes=
@intel.com&gt;; Jerin Jacob &lt;jerinj@marvell.com&gt;; John McNamara
 &lt;john.mcnamara@intel.com&gt;; Ju-Hyoung Lee &lt;juhlee@microsoft.com&gt=
;; Kevin Traynor &lt;ktraynor@redhat.com&gt;; Luca Boccassi &lt;bluca@debia=
n.org&gt;; Pei Zhang &lt;pezhang@redhat.com&gt;; Raslan Darawsheh &lt;rasla=
nd@nvidia.com&gt;; NBU-Contact-Thomas Monjalon (EXTERNAL) &lt;thomas@monjal=
on.net&gt;;
 Yanghang Liu &lt;yanghliu@redhat.com&gt;; benjamin.walker@intel.com &lt;be=
njamin.walker@intel.com&gt;; qian.q.xu@intel.com &lt;qian.q.xu@intel.com&gt=
;; yuan.peng@intel.com &lt;yuan.peng@intel.com&gt;; zhaoyan.chen@intel.com =
&lt;zhaoyan.chen@intel.com&gt;<br>
<b>Subject:</b> Re: 23.11.5 patches review and test</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 8/11/25 4:42 PM, Xueming Li wrote:<br>
<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Here is a list of patches targeted for stable release 23.11.5.<br>
&gt;<br>
&gt; The planned date for the final release is 15th August.<br>
&gt;<br>
&gt; Please help with testing and validation of your use cases and report<b=
r>
&gt; any issues/results with reply-all to this mail. For the final release<=
br>
&gt; the fixes and reported validations will be added to the release notes.=
<br>
&gt;<br>
&gt; A release candidate tarball can be found at:<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://dpdk.org/browse/dpdk-=
stable/tag/?id=3Dv23.11.5-rc1">https://dpdk.org/browse/dpdk-stable/tag/?id=
=3Dv23.11.5-rc1</a><br>
&gt;<br>
&gt; These patches are located at branch 23.11 of dpdk-stable repo:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://dpdk.org/browse/dpdk-=
stable/">https://dpdk.org/browse/dpdk-stable/</a><br>
&gt;<br>
&gt; Thanks.<br>
&gt;<br>
&gt; Xueming Li &lt;xuemingl@nvidia.com&gt;<br>
&gt;<br>
&gt; ---<br>
<br>
Hello,<br>
<br>
We ran the following functional tests with Nvidia hardware on v23.11.5-rc1:=
<br>
- Basic functionality:<br>
&nbsp;&nbsp; Send and receive multiple types of traffic.<br>
- testpmd xstats counter test.<br>
- testpmd timestamp test.<br>
- Changing/checking link status through testpmd.<br>
- rte_flow tests <br>
(<a href=3D"https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-o=
ffloads">https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offl=
oads</a>)<br>
- RSS tests.<br>
- VLAN filtering, stripping, and insertion tests.<br>
- Checksum and TSO tests.<br>
- ptype tests.<br>
- link_status_interrupt example application tests.<br>
- l3fwd-power example application tests.<br>
- Multi-process example applications tests.<br>
- Hardware LRO tests.<br>
- Buffer Split tests.<br>
- Tx scheduling tests.<br>
<br>
Functional tests ran on:<br>
- NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: <br>
MLNX_OFED_LINUX-23.10-5.1.4.0 / Firmware: 22.39.5050<br>
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: <br>
MLNX_OFED_LINUX-23.10-5.1.4.0 / Firmware: 28.39.5050<br>
- DPU: BlueField-2 / DOCA SW version: 2.5.4 / Firmware: 24.39.5050<br>
<br>
Additionally, we ran build tests with multiple configurations on the <br>
following OS/driver combinations (all passed):<br>
- Debian 12 with MLNX_OFED_LINUX-24.10-3.2.5.0.<br>
- Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.<br>
- Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.<br>
- Ubuntu 22.04 with rdma-core master (091ddb5).<br>
- Ubuntu 24.04 with rdma-core v50.0.<br>
- Fedora 42 with rdma-core v55.0.<br>
- Fedora 43 (Rawhide) with rdma-core v58.0.<br>
- OpenSUSE Leap 15.6 with rdma-core v49.1.<br>
- Windows Server 2022 with Clang 18.1.8.<br>
<br>
We don't see new issues caused by the changes in this release.<br>
<br>
Thanks,<br>
Ali<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH3PR12MB865848892AA41B5EA3E4228EA13CACH3PR12MB8658namp_--
