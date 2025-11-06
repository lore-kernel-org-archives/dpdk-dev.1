Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC30CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 07:30:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2214B40E11;
	Thu,  6 Nov 2025 08:30:17 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
 by mails.dpdk.org (Postfix) with ESMTP id 7285A4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 08:30:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtTMa7X0QwyFcq2a49W80V8saH+Ku6pFkkGamA6n41CyhF3e4yyrSWDjQDBBc6D4x/eUrFJqUuonI5w399Td0M+tMP2/266oRYdy7qqwzeop9Tt0WfqecGv6K6CZfdgqtUujqbUh3eUjnC8eBkZu1S/15b09+B2TIXcvFkBMjqBH+p+j/qaD0M2pIk5aPxv73I3FXOqfkO88f9KzymXozLBp2vl0ojf6cq12o5/5uBMImB8CRukNQPSB9PI1B88jBbeHMAJ227sVWTxagJxkg7AbEsvGZJ60S6cWOoKFkZVp6AIpOE5HKgpTSLOgkeL+lJeHus8HuBafxunvlG+ZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2aMBf3xr5ZvXL7OpHd2phj3/M2GXepsXpUMU3NjkmM=;
 b=ipXInrGWhYUYKCWy/LCRL6VVj+m4Gkm+5jHvstb1RlDlnL1uuqwz+Chmt14hGT+A4MbTBdvLVkkX3UNf3BS0BUvHlSIiQMfFY0nLtk7iCrQrFR4bz33qLjR9YGVceA51x3IpZU+W0b9EhmiI8SZFmHLYigGYG2jurbOVJ3igD/LGyYhnIxXquyZn1phu7tOC20gdefdpW6h/uK5/XLxP5faKNn1IhgLt4HZzGWuNXumVXtcSkJHinvWX6qpBYvjWq3PfVbf+QjW552XyLnRhpmaytjGR9PgdKGvDfG5maLG9eyDXPy3oPv7T9GBINuKQwlIaaUk5jgICTvyovKkp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2aMBf3xr5ZvXL7OpHd2phj3/M2GXepsXpUMU3NjkmM=;
 b=AM29vxlfjEwK9CrKCj+tEP9PpFZDppIRF/OdTGax30APbv2H3KpWJvP5DwbueXU488fV+xBRdsfTGo5/n8LhiVd+mOvhn1Xj7vNWLdPl/psdU9sfXUFTplwrXceFRDuH7o+Y1uoPJvO1nKwobfewuO8bvnOTi4ztBD/bWdHLREoWqGk/+HnmvArjIpAqbvxwv7X16F2B3osWatP+HlAs5COucbFIEjp9VbuDiGAiAGSu/GGmxdLWMpCDGsf/o/abOXYu8yQpoezy5J3F3PvIniBDZJqd2Usf5hLyrcqYaN+rb95v3Ttbd1xBw+G46GK68Yyqy2yxvTHy9WGug7lYzw==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 07:30:12 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7%2]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 07:30:12 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH v2 0/5] net/mlx5: support count and age actions on root
 group
Thread-Topic: [PATCH v2 0/5] net/mlx5: support count and age actions on root
 group
Thread-Index: AQHcTnTfJo8Qj0yF5kO0G4ijAGFjRbTlQSYw
Date: Thu, 6 Nov 2025 07:30:12 +0000
Message-ID: <IA4PR12MB9763D8728C5783B311A0EC70D0C2A@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20251104174612.1341962-1-dsosnowski@nvidia.com>
 <20251105165258.1396352-1-dsosnowski@nvidia.com>
In-Reply-To: <20251105165258.1396352-1-dsosnowski@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|CH3PR12MB8536:EE_
x-ms-office365-filtering-correlation-id: 1e12ebcf-9fd3-4c87-47cd-08de1d065243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Xga7ZuD+PsZGjEps+XWwu09kvntqLaKLskcghNBmXgKcAl+g6v66pzSe1sMh?=
 =?us-ascii?Q?bmhX210pSDFLW/RkNhGL3yEYar9XBeniRBCz1YU24+GcXx8hNYND6LtdZHCF?=
 =?us-ascii?Q?pyyD/8r/lg+a0I8gqADl2ybN+kzhjea7bgo+dNbQXNKTMTJixpJXzZWBOBhX?=
 =?us-ascii?Q?H/fUaueKgmnxmoyp6nICVzyMh/oIa3MycLRYckDF9EqDwCNQheuXa04n5oTC?=
 =?us-ascii?Q?JRLUQjz6jpabrVI3S+ovhPPoELs7P7uAt1uov2fQFTKM98FIIiNLS6zvVykh?=
 =?us-ascii?Q?r3LGE+VGWn1j3yliMSokCwn+EnGV5l7dYvOVYi5Nc7Wysb2RPx0dwnu8E0AI?=
 =?us-ascii?Q?sshyCHl8tcslGy1MIx8OlIdDVrYlMgDXgHPVow3XZ2yR/V6zD1qyRDxRBxeS?=
 =?us-ascii?Q?oLD1rDKh6Gvmosijoqn6YfxPMieZ3e5kMz9AoqNHNj8SJFtsecZj34/7TzBH?=
 =?us-ascii?Q?Oc1f1CSjxD/qfrkuTEYZ2JhkiEQtcEITf5jeXIYPMBRSQbz8sUo/Hmo2DxcB?=
 =?us-ascii?Q?xTe/MbviGQNlHiO85d3px5GtRFjeKB19DY806LDypKgdPBS/e+N7DvuKtnzx?=
 =?us-ascii?Q?5J/zKYrMWEfJEW3JRI18ZQJJ9oKHv5jSuYPdhaZljxNgi11P2mQb5k261oNZ?=
 =?us-ascii?Q?Ak43kug0Vj7Eq9L/qr5sP/p5nVveLFGlMvF39fGbsOyxWfIOY3Z6eyzuYhBR?=
 =?us-ascii?Q?L8tgWaJ2VpI174bOHL+Mldb55eqUpk5krNC28C/OTiVVdDufyFxxUdM4R66F?=
 =?us-ascii?Q?I1IY27cRt9Z7XRYXgCdVcnH41MnhVcoSMlGeHlDQzSu+yUVW1cCipqzCYm2l?=
 =?us-ascii?Q?WJHtgHDxpBHhCoBAaNv3SJpduMlfjS53lCVv1XoyqUNPXGENFnXb9L31q70a?=
 =?us-ascii?Q?kCSBLBLzRebuZjPce+y2ZdiRzp0DSyfUygIDNIAatVzk/Al2ogyooxPQSeCY?=
 =?us-ascii?Q?mAkM5PYfweQOOiQQvPKiXgpmC8fjpLcwkmtheL5s9NLkjA5RvNpG+7W84c0A?=
 =?us-ascii?Q?UwdFyYu9OF2uneNioTTpr+RPDdVH9QtbQR8UXw+2U4Qf0lffauHOs2WWJv5j?=
 =?us-ascii?Q?Q+TKkTOVbrnodCNuN1jpg1Pp6Nd6pT3KwUcBTzh5k+rWCE75NZyYe6swRnlh?=
 =?us-ascii?Q?zut52ZcuRzrpnCp7QC/GERKGshQlTM/9Z+Aqpk7MZYTMBCi6obtUo5gmGetv?=
 =?us-ascii?Q?B0oG2nLUmCzs+tHYR12RSjLi0uVLihM+kT8hdb11frf6GcbA0BY792seuPDg?=
 =?us-ascii?Q?cmgiNZr9fi+OOp95G8ixV3DdeUF/4gNJ09VHx4Yz4yS7zUzfA//oN93KzQ1z?=
 =?us-ascii?Q?dUJ35lPNU78uWcZhSaDNH3oqaE5m4HcLlsYiVz4/buz51SQH2WxLSzsIjOGw?=
 =?us-ascii?Q?F/UIt2fkZX8uDi3vTAhtsNw8NFlynGlzpWMLPpi0AAwd7MxY/SGTzInNlHKv?=
 =?us-ascii?Q?+Rz2S8XxNeQf2B6jWaaC2Nr1WevoCD/B8qLortCa0pqoLxb6XOXjys/1Hz+y?=
 =?us-ascii?Q?ORqrNVBOWbthGFx2CiKAfRey9mm9m7/A/U4R?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ddEHmm8k6JJNkxQBo7az00J5/dkGAmu4G8LMpycwATE2gPSz4PQOGHZO/pDS?=
 =?us-ascii?Q?Txw3i1/gcEexwYvKUZFo0I+Jmrvw4tox57upVDSvdu57fD1Ghaz5sVsXd7fJ?=
 =?us-ascii?Q?aE7hWLwYc/zS2SUWmxW59iB6pC0WtwUjp1YOm3pgZAFHc5svRZdKr566VNLv?=
 =?us-ascii?Q?77jnKNI2SBJfs5PDBtRftCaAh6s/kwNkSQiI+ytirEWEzvT9nty8ibCi8+aE?=
 =?us-ascii?Q?yrTBLx8mk49Kn31KWRy/U/JOlYcZo6np5+tAqEGU2XkZD5oVk+WvZ4NUat2E?=
 =?us-ascii?Q?TAHOpJL1bryaZY28y28UzjvdUOqCPKd1dYqPzH+sFCJQs3Spx7162DR6M5jr?=
 =?us-ascii?Q?rWdDWYx/6KRtImUpGo0ghRhDXGyf0BfPWCiFkQgtsAxNimmMQXAZIRfuzyZv?=
 =?us-ascii?Q?MxRM6qUc7VamO4P74MkPqf+BEK5kg8+1bTbCsx8iIufTvZUyMDXZZGcFMH6A?=
 =?us-ascii?Q?8DAdpwS4tj2fF+HsfUe3tKQVPk+rVu78+G7/BdVS3YTAimdzmTOcYkGhZ5ME?=
 =?us-ascii?Q?AXb2mN+O94nP1B1g158Spk52QyH1sdTV5DH8dpw/IuZymifWLFH5u4ymVQ3q?=
 =?us-ascii?Q?nU8tSWwtVWltMTmv4Pp3nJ/Xp95K+w0IKr0RXO9cI4cL0m6BLmHdvVO0H7sg?=
 =?us-ascii?Q?baHnKDQ+DOPq6SmI2ltcAlcE9xCcgOUD1obYkXd/VKOFo7KW6f78h8u36V4p?=
 =?us-ascii?Q?TsXk4/bnbXacyMGPwOf0RLxsafqHgwamRGFJHPB+eiCfV0+7ob27PLT0LjEs?=
 =?us-ascii?Q?TUiYH/qXSNrRUBap3x2oYv6Qv5owLGpxhucBbl30aD7AlqJFptI9+gzCjs1g?=
 =?us-ascii?Q?GM6Vn8P0dGnAW7RowONwXWAXGZcNil+YAR5PPaLm7OrZH+RwsbxjU1eTRhDo?=
 =?us-ascii?Q?Jm4dHkkD9+VrAJvyfKOnwvqnTPGqty4fWjOiHreyC7F29xu5DtRopfQaigNP?=
 =?us-ascii?Q?gZc1e+2x7TZTFwtT+TRPbxb+vzTNhMk29xA/9IPIInNv9hkH9iwqPX3vCyZZ?=
 =?us-ascii?Q?ZnOCdyXnnHXMn0oBSdCHU4guGj3DQCcCXHeRVdVcdom43BVONJ7YPAWMAOuQ?=
 =?us-ascii?Q?5dI8EVjtqkil3yskDGHEdZPefGz/Kva7WcZObeTgRJGS72OWpJNdSquXxn2i?=
 =?us-ascii?Q?ObeFfVv0w70+zNAPUmXksPMS+VgkU7/JbIaHBj95iMNJrZsq6aQoc/Udm6vZ?=
 =?us-ascii?Q?8+qH6FkDokuUdAa9dZglk8TO+9AtAQS5YaLviL760XCdUR0fjeT6ORBy0Ock?=
 =?us-ascii?Q?aC/SGaMISiZApfGeLV4akp0EqRIEX1qM/2AkULz5HnM4pYz7M27zGosPxdgY?=
 =?us-ascii?Q?UVppKT0Pm8O+EnIeYmrpxYWUoDEJsk4WImcG/CuGVuRsL99I7a/gsRI7f2/j?=
 =?us-ascii?Q?PNX3FIqUb4ry6D0rqjHCXqG/Pfnb1rowcrF1PzBks5UFYXVNyM5ymobFpO42?=
 =?us-ascii?Q?DLPQRxOOumxP0VUBOKdoeOIRdX2Xy+Uqu01/Pq8j06zm+6qhw/NgTnUWor6M?=
 =?us-ascii?Q?wlrE5ZcH71x5tZV6Y99esL2Vyyl6JYiCZlSNci24Y/vf0FZ1atik/PK2y/Rb?=
 =?us-ascii?Q?GDwqjmAHDJcJH92UyoM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e12ebcf-9fd3-4c87-47cd-08de1d065243
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 07:30:12.0294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8iorekOoRPCzfOjo0iXi64iARJKqQsrdVNJQSeWRFOKCDLUYR1Hw7WWgJd+ZfXVaCRMxSRc0LR0IPLYK3I2Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Thursday, November 6, 2025 12:53 AM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH v2 0/5] net/mlx5: support count and age actions on root
> group
>=20
> When working with HW Steering flow engine (HWS, dv_flow_en=3D2),
> mlx5 PMD does not support using count and age flow actions on flow group =
0
> i.e., root table.
> Flow rules on root table are special in a sense that they are created
> through mlx5 kernel driver using rdma-core mlx5dv_create_flow() API.
> This API however does not support using counters from FW-allocated counte=
r
> bulks which contain more than 1 counter (extensively used with HWS to
> optimize allocations).
> This affects age flow action as well, because it's implementation in mlx5
> PMD relies on counters.
>=20
> rdma-core version v60.0 added a new flow action type to
> mlx5dv_create_flow() API - MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET -
> which allows the use of counters from bigger FW-allocated counter bulks.
> This in turn allows mlx5 PMD to extend count and age flow action support
> to group 0.
>=20
> This patchset implements that support. Patchset contains:
>=20
> - Patch 1 - Fixes for indirect flow action error reporting.
> - Patch 2 - Adds detection of MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSE=
T
> in rdma-core at build time.
> - Patch 3 - Adds support for counter action in HWS layer whenever
> MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET is available.
> - Patch 4 - Reworks for group 0/root table checks to allow easier
> implementaiton
> - Patch 5 - Enables support of count and age flow action in group 0, in
> flow API implementation with HWS.
>=20
> v2:
> - Added logging in mlx5dr action creation whenever count is not supported
> on root.
> - Removed redundant is_root_supported field from mlx5_hws_cnt_pool struct
>   and replaced it with compile time checks, since feature depends on
> version of
>   rdma-core available at compilation.
> - Unify error messages for unsupported count/age action, so all refer to
> root table.
> - Added Fixes tags to patch 4 from v1 and moved it as patch no. 1.
>=20
> Dariusz Sosnowski (5):
>   net/mlx5: fix error reporting on masked indirect actions
>   common/mlx5: detect DevX counters support in rdma-core
>   net/mlx5/hws: support counter from DevX bulk on root
>   net/mlx5: rework root group checks in table create
>   net/mlx5: support count and age on root group
>=20
>  doc/guides/nics/mlx5.rst               |  34 ++++---
>  doc/guides/rel_notes/release_25_11.rst |   4 +
>  drivers/common/mlx5/linux/meson.build  |   2 +
>  drivers/net/mlx5/hws/mlx5dr.h          |  14 +++
>  drivers/net/mlx5/hws/mlx5dr_action.c   |  20 ++--
>  drivers/net/mlx5/mlx5_flow.h           |  17 ++++
>  drivers/net/mlx5/mlx5_flow_hw.c        | 123 ++++++++++++++-----------
>  drivers/net/mlx5/mlx5_hws_cnt.c        |  42 +++++++--
>  drivers/net/mlx5/mlx5_hws_cnt.h        |  16 +++-
>  9 files changed, 185 insertions(+), 87 deletions(-)
>=20
> --
> 2.39.5

Series=20
Acked-by: Bing Zhao <bingz@nvidia.com>

