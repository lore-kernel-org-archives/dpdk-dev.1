Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A5606A31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eVbde8Gv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41D6E4025A;
	Thu, 29 Oct 2026 18:20:16 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 7EE5740151;
 Thu, 29 Oct 2026 18:20:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJr1HWAGFnn/H4LGY7XI3umKLCJ3Yn948hA6GMP8KXWp4SJkLmQ+qieIyj2e/+U0Zv9FEJlv8Fe83r6Tut+xVJhfTZeWcpXgmCtxHR+7SXzBZOnQypiTzcpMRPuiKTuw40HiHZ5zNErvAhBpusYY6pKWa4i68/bLCuEnzZoBe4Bj4L/faqTjyu2kRJ8GDtrfe8R6UqL0YS5mX+w/hXIblS5xEvS+NMCLLBVtjjmQdxpWsjs8/SSZfDqcGbimHHh3P+X9LnZlAprrvXPBpUg9UfaC++1/LH4d69s0FmX/6XeCWj12Di5VhC6euoOJ7Ul95zsCDMLye2w9pBuYgyCYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53aW6zmaA0sDWcD2C03huXV9jS05vl53ZbSaj1tFp6I=;
 b=P69vxOb0ufbNBlQq+1ZFYjsN44HhOx8mF+QNYv6FW2mPtvSFb5GhV79wt8P/BG/gmnh6sjCWC1Cr86K+xgtYweHJuis7LOh/45K8h+AaBCw8o7WmKP63YaZoMhZy+McDasBvkWWoxOSHDqaqoyehE0pOapLqO+bjhsAyFQ82NUZ/CTsrOkbkSofuu86F6YK3zv73WV4J6Pof8Kpcbw4dJH87j9JDOAaDU3y4IsmOBzZTWYs6RHvrizyQRkeyIw6zRTXejLQRYGM8K7i+512fPkjRmTAXkqBwsM94eHETxGOG0oPYP0avwg5yJega5nHnXsJUN7GyuriTk3o1ilSXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53aW6zmaA0sDWcD2C03huXV9jS05vl53ZbSaj1tFp6I=;
 b=eVbde8Gvy2NO7jH1MbyEC87844i6oS3LnyojowJR5w0gn3bdm2uXTobQ/2uQRfZzbG4l7UNwfEz4lCivir7iYJfHvsb9eyI1zWdiZfcyBVRBMFhxJ0m08GCT0tX6sB78XM6Xvx6B4YhMUQfgq5S+2GhaaFUHWJBEM0XanhsOK81HQMiKN68L8n3gtmNziMtM0xTLt23l70/7+vLdRa39U0yKN9DF8LIvqfwjFh7BzuNa9/7ahweXwtWWN12wO+JkCtHOU7WNaO69cS3xH+vl6biXr7d2A0mutjsw7w6DRocwYZ+vhnGNTslPto1cjlx1RYxrUrW6x5UaquuasW9gXQ==
Received: from MN2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:208:234::12)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 17:20:07 +0000
Received: from BN1PEPF0001806E.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::75) by MN2PR16CA0043.outlook.office365.com
 (2603:10b6:208:234::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Thu, 29
 Oct 2026 17:20:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0001806E.mail.protection.outlook.com (10.167.245.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 17:20:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 10:19:38 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 10:19:37 -0700
Date: Thu, 29 Oct 2026 18:19:13 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 <dev@dpdk.org>, <stable@dpdk.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH] net/mlx5: move to polling for LSC interrupts
Message-ID: <6qjbq36rm3t5kbqnh4lv24r6wvls364xdjqw2wte2tmkkffsbc@gy2ml3vjep64>
References: <20261026160400.1290443-1-dsosnowski@nvidia.com>
 <20261026101348.497e2caa@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261026101348.497e2caa@phoenix.local>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806E:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cede38c-72c2-4a84-cdcd-08df35e0e071
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|261026121527099003|11063799006|4143699003|261021123027099003|261009223027099003|261021135927099003|261022105027099003|261022075727099003|56012099006|10067099003|22082099003|18002099003|261028144727099003|261026140227099003|13003099007;
X-Microsoft-Antispam-Message-Info: cMWinvdW0KTelQ+ALNcVWYaaDHTjeHozvRuTg4SZJSwZgGdmQV6qA8IVYS9CQLxb1r9qfljgOYHIbjlXtTcY1nMfpWca8WFgyKj+5ItakS7Z0oxLAFtaFtrRQLpbiUc+6Ji3M6sbCTszyx5ZDWGJ6NtxhglTimsxNHaWeuyk9UMQhOUYk4VyNYAekO2dEmadVslJT7huJE9qapB9bRDGlrg7r2qic3ukvyOPQItSJ7YqT++XJXeg81ISKzPYX2d0thuzWdY6sxA00+Pil5bSlYN4z8sxfzDepbCoAeq2NU7viSJV/wPx/ti+MiysDkWu4bShnILKczl12Rapro03VphMQGfEhy3gSer85frq3cNyp+MaQ5oIz6YnI86g3OSqVOrMuxjnLeETzgjarjrrRd7kJVe8gHI2notAgLL98NcAMl1/qFAPSJNBbnBxmKGQz+Gj2IA2N3nKGvCu7VA3CCVHWmgzjehR7EQu3jzPVjWkF7rOKAjcJSstsAIO3JSIC0sin7n8CrBa4w49TQFdJ+HRzz7jEPV1uIOHH7v3cTjOIIvW3s0Jy9sLmyiozNb2jFnKXrrXjm8tXwe8uZBjaIJdysWGtNDa8mJxjIz0YonuaSk48caaJm1eh4AKwIe3vOjPpz67tJdkuL1rhcDdpVloOX5XN+cNshx3Cy0SYqXp34sCloe1qQGN8rfY4W6AUyW8XC3Gv6EJHjeNk+RsVA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(261026121527099003)(11063799006)(4143699003)(261021123027099003)(261009223027099003)(261021135927099003)(261022105027099003)(261022075727099003)(56012099006)(10067099003)(22082099003)(18002099003)(261028144727099003)(261026140227099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zui3NLYqsBIrqrUAtwRgVrEerq6yKUEdb/bHYU718GshXooYfkjOJYpoo+PvviE6W3bUP+ERC1cKufLLDqM7IfFyHzb/0AxH5YMniHOez7r3u8uhY/wDkCjgF609sQ+XBHJI+f2UqaPSF6l74tDFSFfWmwME4THT94WIEgP9NQan3TnR+Rm/qwNn+OpaetyFvg7yqsG7CgUJuI+91SHyEhpJL4uHb9Yyu5NzcxeyPz7pe5K4y+0PDxrovIJIsPznyy59JvxbEXq+F2i9Bm8b9uvQglw3FSQeUEdx6PFTytj2UtBG7cXaK4PgD5I0avZyUV2Mdk9Dv0LiSgtgSbgSFdmjTh/iM3D4GaISa9A36rSFfguwlYdeTplRdmW0OEKT1acn4vTToyxVtxutcprMMjpfVqAaOQSeKXacKn/FiX2LrcvWC0AYmtcSKgl3qfzw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 17:20:06.2737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cede38c-72c2-4a84-cdcd-08df35e0e071
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 10:13:48AM -0700, Stephen Hemminger wrote:
> On Mon, 26 Oct 2026 17:04:00 +0100
> Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> 
> > mlx5 networking driver on Linux implemented LSC interrupts
> > by listening on netlink events.
> > This method is unfortunately not reliable enough,
> > because of linkwatch mechanism. It can delay link up/down events
> > for up to ~1 second. This introduces unnecessary delay
> > when mlx5 ports are used with DPDK bonding driver for examples.
> > 
> > This patch addresses that by migrating LSC checks
> > to polling on link status using ETHTOOL_GLINK command.
> > This ethtool command, implemented by mlx5 since kernel 4.14,
> > will always get the current link status.
> > As a side effect it is also flushes the pending link watch events.
> > 
> > Fixes: 17f95513adca ("net/mlx5: fix link status change detection")
> > Cc: dmitry.kozliuk@gmail.com
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > ---
> 
> Agree that 1s delay is bad for bonding, there are historical reasons for
> link watch. With some old NIC's the PHY would stream up/down on loose
> cables causing DoS on the machine. If you are using LSC for bonding
> and implementing LSC in driver, you might want to consider some rate
> limiting.
> 
> AI review showed some issues.
> 
> [PATCH] net/mlx5: move to polling for LSC interrupts
> 
> Applies cleanly to main (a635140). Moves Linux LSC detection from
> netlink RTM_NEWLINK to a 100ms EAL alarm polling ETHTOOL_GLINK.
> 
> Warning
> 
> 1. Poller stores a partial, non-atomic dev_link.
> 
> lsc_intr_check_links() copies dev->data->dev_link, flips only
> link_status, and writes the struct back with a plain assignment.
> mlx5_link_update() (now using rte_eth_linkstatus_set(), an atomic
> exchange on val64) can run concurrently from an application thread,
> so the read-modify-write can lose that update. On link up, speed and
> duplex are left at whatever the last link-down stored. The poller
> also ignores IFF_UP while mlx5_link_update() reports
> IFF_UP && carrier, so the two paths can disagree.
> 
> Keep the cheap carrier probe, and on change refresh the full record
> through the existing path:
> 
> 	ret = mlx5_link_carrier_get(dev);
> 	if (ret < 0 || ret == dev->data->dev_link.link_status ||
> 	    mlx5_link_update(dev, 0) <= 0) {
> 		devs[i] = NULL;
> 		continue;
> 	}

I'll address in v2

> 
> 2. Polling cost on the host.
> 
> ETHTOOL_GLINK runs under rtnl_lock in the kernel. This is 10 Hz per
> started port with lsc=1, including representors in switchdev setups,
> per DPDK process. The adaptive period only reacts to latency seen by
> the DPDK interrupt thread, not to rtnl contention imposed on the rest
> of the system. Was this measured with a large number of representors?

I ran some tests on a following environment:

- Ubuntu 24.04
- Intel(R) Xeon(R) Platinum 8380 CPU
- NVIDIA ConnectX-7
- 1 PF, 127 VFs

Polling time of all 128 ports (time spent in mlx5_lsc_intr_cb()):

- only ETHTOOL_GLINK on each port:
    - total: ~0.71 ms
    - per port: ~5.5 us
- ETHTOOL_GLINK, followed by mlx5_link_update() on each port:
    - total: ~19.72 ms
    - per port: ~154 us

> 
> The delay 17f95513adca worked around was IFF_RUNNING lagging the IB
> port event. With the query now done via ETHTOOL_GLINK (reads carrier
> and syncs linkwatch), going back to IBV_EVENT_PORT_ACTIVE/ERR on the
> existing shared async handler and querying carrier there would give
> immediate events without polling. Please explain why that was not
> chosen, or use it.

On mlx5 ethernet devices, IBV_EVENT_PORT_ACTIVE/ERR events are generated
based on netdev carrier status [1].
As a result, these are subject to the same delay as netlink notifications.

There is also IBV_EVENT_DEVICE_SPEED_CHANGE, which is generated on port up/down events
and is generated immediately, but:

- it is only available from Linux v7.0;
- it is a device-wide event; it would require a scan of all related ports
  to know which one is affected;

[1]: https://github.com/torvalds/linux/blob/v7.3/drivers/infiniband/hw/mlx5/main.c#L3082

> 
> 3. Not stable material as is.
> 
> A new 300 line polling framework using rte_bitset (24.11 only) is
> not a backport candidate for 23.11, and reducing a ~1s notification
> delay is not a regression fix. Suggest splitting:
>   - small fix: use ETHTOOL_GLINK in mlx5_link_update_unlocked_gs/gset
>     (Fixes: 17f95513adca, Cc: stable)
>   - the LSC mechanism change, without Fixes/Cc stable
> 
> Info
> 
> 4. Windows stub logs ERR on every dev_start with lsc=1, while the PCI
> driver still advertises RTE_PCI_DRV_INTR_LSC. The old path logged
> INFO. Make the stub silent; mlx5_dev_start() already logs. Also
> "failed configure" -> "failed to configure" in that message.
> 
> 5. Leftovers: the rte_io_wmb() in the mlx5_dev_spawn() error path
> ordered the removed nl_ih_port_id store and can go; <stdbool.h> in
> mlx5_lsc_intr.h is unused.
> 
> 6. mlx5_link_update() now reports only link_status changes instead
> of a memcmp of the whole struct. Fine, but mention it in the commit
> message.
> 
> 7. Commit message: "for examples" -> "for example",
> "it is also flushes" -> "it also flushes".

Points 3-7: I'll address in v2

