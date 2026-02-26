Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A0EFCE068
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 12:43:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ABC84026F;
	Thu, 26 Feb 2026 13:43:50 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by mails.dpdk.org (Postfix) with ESMTP id B7D064021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 13:43:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6FdbfWD+zE/imnOmsVSgqht0w1+Ge8YxO1q0pvEu4DgSgRXrohkLy2tbgMyCdMuB7JHMH344Hy9EXQKGTUedIC/lBTrm9Eq7qxDNdZ7XrBjd1iCRzLthQpqXS0jP5DYhp6jS7QVouuOLZfDACHbW0aEE/rK2Ty+xVgX1SUVkRPpZcPeXHdIHWlAw8ke0pxUIFkGVm6cLik3wGWucuKXdfhB5ryV4BIXAK+8vDlDNcOOzKYtPNikavwWhHOhJy9i3mQcBiiOXThwLlaxRLpdVxD8lfH7kxKBR6J1iIjl3oEotDE2EqgPa+/GAKDeZhhtyYHofaU3OATGS9JGBeXKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLjx4vIUoHg06Pr3ux7KFIpyU1tSiooeXuWODRoBAyE=;
 b=qlme/RwhJMng7A/uVB4UYvqhnNN7s5TpY9OJr+ai0rP5h8rkFIEm+iR056rrn2btDWsO2OHUZdTDQoLr93YegCB+Tz8ATubntvMfhlOokFGNr4V7MdEPWE5kL5dPg6A+CJvUzh/2bVlhGxJbeh6hA07O5Gxv6PXvMsP793/flKMQbuj7HMlzkspj52VjzPzvF+K+OwUQZ1m6dgdPR36lZXtcGgkkY5tsKR8CGKVHR0T9dKQ+djzW8/pk4apeBxveJWv3XFQGv3oDir6T2KR4xSNoPvwNoGuq+52vqwjdO48g5hw6hlmgcRYFjprBDqRilAZrwczAMJqtC/iLZ8NARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLjx4vIUoHg06Pr3ux7KFIpyU1tSiooeXuWODRoBAyE=;
 b=jykFrzxmn3uZRPPlJvIJoji+586onUBtFH/JqQBwSof25TCuM/MEU9K0PLiktAyD6kkjh5cc1p+S9S3xqCsdULodeuEcxn8oRKtJjwlGw3QSb/3tGeiJPFk63UWQBIC7iDTCuUGF7p001FVN3fKf1YlDtaZ6VLTloJQuakK5NTs=
Received: from DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 12:43:46 +0000
Received: from DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::e77a:e2cd:57ba:f2f1]) by DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::e77a:e2cd:57ba:f2f1%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 12:43:46 +0000
From: "Sebastian, Selwin" <Selwin.Sebastian@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Natarajan, Ashok Kumar"
 <AshokKumar.Natarajan@amd.com>, "Ande, Venkat Kumar"
 <VenkatKumar.Ande@amd.com>
Subject: RE: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access
Thread-Topic: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access
Thread-Index: AQHcoPW7AVWyyTP5l0eT7Jr1E8wzyLWTrG+AgAFMNAA=
Date: Thu, 26 Feb 2026 12:43:46 +0000
Message-ID: <DM4PR12MB505508C3C0C4045416A258438D72A@DM4PR12MB5055.namprd12.prod.outlook.com>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260225085251.2bc82809@phoenix.local>
In-Reply-To: <20260225085251.2bc82809@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-26T12:41:50.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5055:EE_|DS7PR12MB8322:EE_
x-ms-office365-filtering-correlation-id: 85274f5d-5b78-47c2-f475-08de7534aeaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: XXANgHMMBvwdlnnivcLFkckek+7bq1GIeFYh5E9t3Tl1sE4wqof45JaxUDlRCNqxOdvm5o0/qWay4yvwVywzJv3rYcpmRWR8Hr+yI1tE/FfPRgcac7UEw1d4N2jH36r0azmWd8KQxb/ekkKZDeQU+i/qWHGw/yzQNy2Q0vJKidrEpmkjxXHKI8+t8rLE6Q2MhOjSgk2yvm7Q9fQeH5QKOkLTbK0xf3dGSSkkPNBZ83iMXDGk6ePTekmt6MjF8b0K2qHJVzfROPEcj/qHuOPAsSHITPo3ZAPSNojLtw9znFE+E0wWaXEONJ1BcwZUa9Wy2GSoCcsgzUs4EJTzTvb/cLi88HhRHspbUiSpL4iYbXG7YJV2o4WdpnZhCwjuOQmnYrxfU2ZjUUWsGKWjs8Ptvt7jrj6XQ91kB4moUoT8RXmXxxU9l65B6rOB57JbeTkUH5tspFTZb9gBHd2JoCCcE7QD0p0lg7URJ0QrtWs44g89kOp+2fD3yMtHN2E3b0CQzDkVEphszTcVJdEo6rTlPj6eDk6D6LvOmWBVsisrpG+tWvX4rzhfiZnOAicd68MjjHIm5m6OUsL4FzaQnZFNcBhzJqWjXvgDw5uihJmUTaD8K+QxXm11EkDQkMJ03S4wWLG8cxauyuv3uFn2DDHT/L0qSTTVtx36w/EnIajSEQsMTsFofiVDSsnREd9dckAdbRduDV7hqb2yfOG2ONOWg3IXAnOV3wBBfy8k6IA/GL5o878K59WkoZp6fNUvwlGufP4lG1ki08+ZyfLG/iDohhn7sLWcaSuzeLesyAivNKU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YzBmv2XuDI1AOTVN4xvBA/1D4KI1izvN8fIMHeQdBkSJsXWuxe43+NRgE0OW?=
 =?us-ascii?Q?bB6qrcqW9/BUPPKs/spjDv5H2aHtT9emHdP1JvreU6ZDyjdL4LresILaa40N?=
 =?us-ascii?Q?LYupVKlWsbP20z9e7aVOLF7565lJ5CCkU7JBb3E8PkgqTm4YqFGX9ym9Loz3?=
 =?us-ascii?Q?9AfIb88xvpi1d8oTWgNQ88Mf0G7u/dH421/xGGk3ZbDaD8O6B2+IcDiOHjp1?=
 =?us-ascii?Q?P4zIZJlH1CI2PrbC0xsmP+uukEM6CEQdYyManDXqmYDL8lx9v4mvhryxXfhp?=
 =?us-ascii?Q?NIh+mT6/6CvbzxgfOxDA9XsXVTKXPsvg+Kxy9RXNFy61tW3PNqzT+EFpRMeC?=
 =?us-ascii?Q?NNNl0nJ+YiJ5Qdy6dKhrY8+PDgAuAgzPFP1YFXBaZdn4DDY895C89AC0bZeV?=
 =?us-ascii?Q?RneMFDmQ2Gw+MYCRKwAqEiqaDtja3hW8UE6t5HW82YzHpsbmc0AB0drPMh+V?=
 =?us-ascii?Q?HnV+jVGBvNTRoLAWoVxKSghJdMecYysQ2KuAeS+WktqTdCtyjfJUwxUr+z5s?=
 =?us-ascii?Q?msbHkDYjvnhHmYXIC94WQqlLf8zEGC+AMjyj7jOC0a1uWrCiXMlEJAbkowl2?=
 =?us-ascii?Q?iGY5e7OYkLVPp9z3qV2cy2mNw2O7tjyDVaV8HmYDcslc+rKcblowAFW1wthq?=
 =?us-ascii?Q?mtU8TfZQBsURLVoSfBTxoaxKVDNnYPyuQZ5X520Zfdg7i3G3MTxzqtMbj9Zv?=
 =?us-ascii?Q?XUScTlJo1R+K1GfsrylPZl15sqOtMVrPHKjTseqhTsYhcwUembcoyoBfsJAw?=
 =?us-ascii?Q?JOYmPMbtT/smCsfAjRiNXCsKIfDZNPfIW8jhg9aBF1XFes3COyMfd8ibKcEB?=
 =?us-ascii?Q?nPX0cl+crLjHMdHyVLisQVCEHI2Q3biZQz0OQ7rOVReye8wlTERvdaYHC4Kb?=
 =?us-ascii?Q?0kzGvaWXCt2KIZgbFGx4LHqV5En4SSxJTIccqkuHWbWllUlEluCKfS/KTz3n?=
 =?us-ascii?Q?MY71jg/frBReuePsc/wLIa9WxMICf9Fk4BNQX+uDP3fxA/0SShP7mJXoDKpH?=
 =?us-ascii?Q?uv9HWoIx4eEpYgg1Nu94eTI7Q4aVUPWZTt9RSkh8fD35BOXqeHhRHlSYfysw?=
 =?us-ascii?Q?64crZp6iCarTMPwk5Gyc779XTSyMQ+LOOwmetVBfRmCnf8G3NiOUGntdJjye?=
 =?us-ascii?Q?H+SnkcsPtFxXd5I7aLG1G2UfK4YcJIBu9UAns+odCc1R0+RhV82sjAOYymLW?=
 =?us-ascii?Q?9GCKX2GTafVHvUBODx82ObMYSF9akN7GzMmrRKPlSR5Oc96F6pwxqR/kypCx?=
 =?us-ascii?Q?Gn+hzuDhNTtP0ctGJLD4D6qgvx1j10OTOM+vGbd6/6xi7oPPJwqRC1S51cRL?=
 =?us-ascii?Q?n9l0HBACPAVYTHwXaqIXdO9tD1u5+t7kC0sVeD+izn7CaBJLf6OOno0Q3kDm?=
 =?us-ascii?Q?kzzFgFH7zQF6Ue7ipF5weOy5P6rFinqyAfBp5BNV0iWEbxsxpXNyfoNkOTJv?=
 =?us-ascii?Q?MfPxw7H5bapE9Qn8mWN1iDmLCK5iVz7aB+RIyE7QHOX2+jgxxkg0rwAnzr79?=
 =?us-ascii?Q?6cBlfj/MDvxdzsPreRK0FjjdUsnMG6AY9QLgc31hBfIv2oHZhgOpCWNWJO2O?=
 =?us-ascii?Q?u/fu1OHJtzkwVt8YdLmWNtiGZMNGKnfWOjrPnuoijNF1uFgoM45z/qpA4pNG?=
 =?us-ascii?Q?hWtkRspOzpp1W8oOhrJ3yQkM27NvIMzlJLVnifTZhL6JGiOTd7nViT0f2fgd?=
 =?us-ascii?Q?5yngQHi9X+kbE1g3fx3aD04kraCshiYbP0zJtKkbBGjR90/N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85274f5d-5b78-47c2-f475-08de7534aeaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 12:43:46.1837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLz+FHwNuPb1WPI4B/AYCHgb3PwxeplW3DKSmAgjcaRCX9kmOUVhncro15fbLvOmAU6Lx5IPV2SEnv6B21osJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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

These patches are currently under review and testing. I will get back to yo=
u shortly.

Regards,
Selwin

-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Wednesday, February 25, 2026 10:23 PM
To: Sebastian, Selwin <Selwin.Sebastian@amd.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Wed, 18 Feb 2026 08:40:58 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Code review of the axgbe PMD identified several correctness bugs,
> primarily around resource management on error paths in device
> initialization and an out-of-bounds descriptor ring access.
>
> Patch 1 fixes multiple resource leak paths in eth_axgbe_dev_init():
>   - mac_addrs leaked when hash_mac_addrs allocation fails
>   - hash_mac_addrs leaked when phy_init() fails
>   - rte_intr_callback_register() return value unchecked
>   - DMA reset failure via hw_if.exit() logged but not propagated
>
> Patch 2 fixes wrapper_rx_desc_init() which only releases the current
> queue on mbuf allocation failure, leaking all mbufs from previously
> initialized queues.
>
> Patch 3 adds pthread_mutex_destroy() calls in axgbe_dev_close() for
> the four mutexes created during init.
>
> Patch 4 fixes an out-of-bounds read in both Rx and Tx descriptor
> status functions where desc[idx + offset] can exceed the ring size.
> The offset is now folded into the index before masking.
>
>
> Stephen Hemminger (4):
>   net/axgbe: fix resource leaks in device init error paths
>   net/axgbe: fix Rx queue leak on descriptor init failure
>   net/axgbe: destroy mutexes on device close
>   net/axgbe: fix descriptor status out-of-bounds access
>
>  drivers/net/axgbe/axgbe_dev.c    |  5 ++++-
>  drivers/net/axgbe/axgbe_ethdev.c | 26 ++++++++++++++++++++++++--
>  drivers/net/axgbe/axgbe_rxtx.c   |  8 ++++----
>  3 files changed, 32 insertions(+), 7 deletions(-)
>

Could I get a review of this, and test on real hardware please.
