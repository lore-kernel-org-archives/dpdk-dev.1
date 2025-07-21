Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A80C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 14:02:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 830F240667;
	Mon, 21 Jul 2025 16:02:07 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
 by mails.dpdk.org (Postfix) with ESMTP id B0949402E2;
 Mon, 21 Jul 2025 16:02:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PneD8r9J9pXF5WhlU36Cn6VwIEnjt0N6bI7PJGLYpAZvcrMiin8CAieogTGgZ6FGrXNsq8MGYEzTP+2M5H44SUZNsrZIP2LM/YYKeMIOmfb4WNd1c/fEIzKCKSa/GABWRRxP0m7nS7paOMnifzRp5YJt/+f4+q0PBbXK/ben3t6KMfBgqocwgxkxqKHAi/kgCnZhgZBE4OzkT/iR2hTZmhIQ7TLTr1+zahiGsiZ16Vhm3f+JrFgxsQ+6c0q09ZFvmkcKIAUZiA/HezAM1g3qY446Ot0+rHdmAmjOio1wOtDKZS+tni5XXZtaYoh4lfpXSZPGRdxu7rVemKYmm6eEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8VmQtHLjf3kaigIILe9JatHZ63MIoe23DPyXf3pCtk=;
 b=esIfWtVg3D0SzfZLKaagyoafn6V2rqMfBq4Tg0IjurX6rlHsbMYV1exkspt0IRBAb3wg0DojgZEv6ukSJ9/ZTvHW/ywtzY9N90AFJ4yLLa0y71G3Y+VxyG6iPPnv3+1p0J5sIdMuSf0jQr9p3G1bm9sBPZt2JFhFO5cxg1bpNDB2a+YoLJ/v1Kgo8AC2cEhBjibD7MGMFtsZ9PoKLDwMfHz6kOxlbcgUEWmHfpVnetx61mWZulDRv3+E+ZgFXpRLfAd9V5u2gv6GV1sR/O5I2eNpipOVLyQuPR/QbvwrVhemX1JVa4TMN4C4/aCfOwPrvRYwVLGiXH/1qS9WrPx5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8VmQtHLjf3kaigIILe9JatHZ63MIoe23DPyXf3pCtk=;
 b=IF+9WXx9xu9OpJYKZsZOnZwbFS/1mjVBbmHeWq/hZ+RGThjssDXn0TNVtCfbuxM86Z3TVI1k9jAQJombkjf31DrVG1fPAvgkK28PAWqF86T1qYH/fgPkoEgmT/8GCN4Zcf9mf6GHfVCKJbXe42rEJzVTISBpazaDtDiRubsAuxMC6e8cRLRitDGpdl7R+JjdrttR0qyfvmsuPc3vO9xgrkM6nR/TgtKYS3d06O+Btfy1Mw3Iai7tWo4Tg5jFozsUjHytgx+FytcQUuPeAvuAvUKCCHOqY4mZZAsKsH9+C83dWmVHXbfp7a3tDjT8NHnf2TAUKavrd1PKDJ02coTKng==
Received: from SN4PR0501CA0101.namprd05.prod.outlook.com
 (2603:10b6:803:42::18) by DM6PR12MB4170.namprd12.prod.outlook.com
 (2603:10b6:5:219::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 14:02:01 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::7f) by SN4PR0501CA0101.outlook.office365.com
 (2603:10b6:803:42::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20 via Frontend Transport; Mon,
 21 Jul 2025 14:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 14:02:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 07:01:30 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 21 Jul
 2025 07:01:29 -0700
Date: Mon, 21 Jul 2025 16:01:27 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Ivan Malov <ivan.malov@arknetworks.am>, Khadem Ullah
 <14pwcse1224@uetpeshawar.edu.pk>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix crash when secondary queries dev info
 after primary exits
Message-ID: <20250721140127.r6orvsqsox7ytlhb@ds-vm-debian.local>
References: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
 <b0c702cc-1213-d773-0ee0-804542a07e28@arknetworks.am>
 <3358342.oiGErgHkdL@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3358342.oiGErgHkdL@thomas>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 892d93ac-19f9-4f63-af39-08ddc85f2a5f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OrEec1svtWd2Jlbbro1rWM1v5Pv66I5n7Q562NDunxEirP2EkwTrksn2TofN?=
 =?us-ascii?Q?pO/+9L4g+m+O2TS6tisGV/yXiIoqBmw7rkAascb6juY+FxPPVirwl39V2Zx/?=
 =?us-ascii?Q?ao1+agA7Dg//e77ASZK//xJWoaSKDV3UJKBzDIarIt7gvL1kdT9uqRys1Fhe?=
 =?us-ascii?Q?bK5wCAda9tgh+C/2x8I4Ny3UzEBjwe7KNADP236g1JHy6Sosm8cfLtRt8t3W?=
 =?us-ascii?Q?9hinizTpcNq9IEMzMgTwpZ29NYfuF8AzWUaiw+XDkebB22PbTzMcJQEKT5ub?=
 =?us-ascii?Q?SO/DB8xp7AHYlluEvVbSRh7uTOet/QXiwnJrBrBqLvBfLX8s+WTQgn9j4Xva?=
 =?us-ascii?Q?IEvrWz9wN4E0BbGaJRYoz4t9WBl9xe0u1jqGb/jjRmdosX+5xsGfXHoRdXM1?=
 =?us-ascii?Q?dNdQtjquO7RisSSemJKFYDPHgNyYEEd/AVi0/IpCek9EKBradGsg+hdsR0nb?=
 =?us-ascii?Q?Lmd9h0quaBY+N2U/gdBVstm6LJO1rhh9FQViBzj0HVERuxYogT1ZMLOPO75r?=
 =?us-ascii?Q?/5UdMajkIqtTQXtq5VuWPxOye87KeG+aNewmPki9Ut6EnJoxe9uM8eg7jcYj?=
 =?us-ascii?Q?0QnJAW1RLJ2CQXEELVEuLGEuNkv3ozAHULjvNG9aG/z12cz86wlgLDDBC/9Z?=
 =?us-ascii?Q?NSpB+vXYxHHb831wKiMHEHVd2WwfFHBwHCgR4w1KbXEWCduw/r4HuFNj/VTz?=
 =?us-ascii?Q?z2C2/BIIqK+hOC6pPV3LCly5qem6l39p6YoBeFPvz9Hn1bL3ary7ZpvXIszz?=
 =?us-ascii?Q?xXk3TaU9SCRgVM1am4AjySIW/HQqUctOlMYC4nG1/lihatkoXRB+ZrWV2Pcu?=
 =?us-ascii?Q?aIsRKdspcVZHpe7Pz5TkcilHg1LxqmCX6lB2TMnX3Pcl52Xc1PXnzwUhouts?=
 =?us-ascii?Q?Im3yuGJmQR/Gfbgd4EFHNMydOaTDHhNq2Ime0zGYmoyBx574Y/lO66pX8qJc?=
 =?us-ascii?Q?b6LoT0OSUJ663QN+2TCc77aON7qfuo+hKQuPfg9sJw8l8BQynQrY7sMmWuQf?=
 =?us-ascii?Q?ypPB1bxYeMZ7lrV4ALINM2RssQll2MgOCoNfGN1hK/0sIyyHQ3m6P/nq41rq?=
 =?us-ascii?Q?TX8lgRkI+l3UZWQdDmGY+ETYOtwRCWDux47YIx0mLg3LtiJA/Cax6f2JklgN?=
 =?us-ascii?Q?weo3IS4umvmSMG9rf8sDPDADyYg044YnlifIF+wvtVgMHcJACnPXBu6cQcDZ?=
 =?us-ascii?Q?u0IwJ2CX6ND1z801rwSx//yARe0WG9KZzdn8Wic8xFUS3vKHxCn3wqzRdP6G?=
 =?us-ascii?Q?QX+mEql7IfPtTYuVJqLpdcZOejCs5ivPRU1FLntP49fWz+xGgdEBgMrsxYlF?=
 =?us-ascii?Q?upSvGK/Gfo3iKA3V7DWtFm64bce9D9JS+TpfA9p5TEztnFF/km22jD7TchNG?=
 =?us-ascii?Q?ZM6YrVwqwsWC5jF83kFCOFvAx6bfETIos35ecdas1gcuioSOroh0VcCN2QfI?=
 =?us-ascii?Q?DTLkbnUz5Q8q9rj09A6EeFXI5qR8vnUTpzPzTdp6MsG/ZGdeIxiJ6/wRPvGN?=
 =?us-ascii?Q?PWzIG0LTYCBj2Q4I++hIJwWw13yM6mFAc1pKeXIeuLbyW/8sTv3MMcDwzg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 14:02:01.3146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892d93ac-19f9-4f63-af39-08ddc85f2a5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
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

On Mon, Jul 21, 2025 at 01:59:59PM +0200, Thomas Monjalon wrote:
> 21/07/2025 13:46, Ivan Malov:
> > On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:
> > 
> > > + mlx5 maintainers
> > >
> > > Thank you for the patch.
> > >
> > > Could you please include other PMD maintainers (or other maintainers, depending on changed code)
> > > in the future patches?
> > > There is a script which automatically adds maintainers while sending a patch.
> > > It is described in: https://doc.dpdk.org/guides/contributing/patches.html#sending-patches
> > >
> > > On Mon, Jul 21, 2025 at 03:38:51AM -0400, Khadem Ullah wrote:
> > >> When the primary process exits, the shared mlx5 state becomes
> > >> unavailable to secondary processes. If a secondary process attempts
> > >> to query device information (e.g., via testpmd), a NULL dereference
> > >> may occur due to missing shared data.
> > >>
> > >> This patch adds a check for shared context availability and fails
> > >> gracefully while preventing a crash.
> > >>
> > >> Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
> > >> Cc: stable@dpdk.org
> > >>
> > >> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> > >> ---
> > >>  drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++
> > >>  1 file changed, 6 insertions(+)
> > >>
> > >> diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
> > >> index 68d1c1bfa7..1848f6536a 100644
> > >> --- a/drivers/net/mlx5/mlx5_ethdev.c
> > >> +++ b/drivers/net/mlx5/mlx5_ethdev.c
> > >> @@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
> > >>  	 * Since we need one CQ per QP, the limit is the minimum number
> > >>  	 * between the two values.
> > >>  	 */
> > >> +	if (priv == NULL || priv->sh == NULL) {
> > >> +		DRV_LOG(ERR,
> > >> +		"mlx5 shared data unavailable (primary process likely exited)");
> > >> +		rte_errno = ENODEV;
> > >> +		return -rte_errno;
> > >> +	}
> > >
> > > I don't think it's an issue on PMD level, but rather on
> > > ethdev/multi-process handling level.
> > 
> > I may be very wrong here, but can't the PMD use its internal 'shared' state to
> > somehow memorise the fact that a secondary process has attached, in order to not
> > let the primary process close in the first place (before the secondary process
> > detaches)? Or is this going to violate some established convention?
> 
> It looks to be a good idea.

I agree with idea of adding these checks, but not entirely agree with
it being at driver level, since all drivers would have to duplicate this logic.

Drivers already have to go through ethdev library when port is probed
on secondary process - rte_eth_dev_attach_secondary() must be
called to retrieve port data local to the process and device data shared
between processes.
Memorizing whether a secondary process is using given port can be added
to rte_eth_dev_attach_secondary(), and relevant check for primary
process can then be added to rte_eth_dev_close(), so that all drivers
benefit.

What do you think?

> 
> > > When primary process closes the port, ethdev library zeroes and frees
> > > device data shared between processes.
> > > ethdev port data (rte_eth_dev) on secondary is not updated so it now points to
> > > invalid data. rte_eth_dev_info_get() is not the only API call affected.
> > >
> > > If the primary process closes the port before exiting
> > > (like testpmd does) and it exits before the secondary,
> > > the any driver call seems invalid because of that use-after-free behavior.
> > >
> > > @Thomas, @Andrew - Do you happen to know if doing anything on ethdev ports
> > > in secondary process after primary has gracefully exited is supported?
> 
> No there is no statement about whether it is supported or not.
> I think we should at least return an error instead of crashing.
> 
> 
