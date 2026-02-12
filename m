Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41696EB48EA
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 09:02:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AEAB4027A;
	Thu, 12 Feb 2026 10:02:43 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
 by mails.dpdk.org (Postfix) with ESMTP id 3A79640268;
 Thu, 12 Feb 2026 10:02:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzgn1et+AmQfbn3oOZR6Ojn6NDj9GWm8SbnxlbE0usORa2s+NIzUgHPZkTL/jZYao3r0D6BmrejFaqAiVCFyN7BdavqaTPX7OlYGLS+hLbAmHFfDWkb0rcKoLDaDz8q8r61aEqWG3dh+/q+TfYsuHnw3OP38qNqULxi7rrHPI67Wzfe4L43x3aAg12EyZTfUGDBKrjFUZOXXcZNkCkIyU2DrLCIOqLRpnxqGif6+wsLLCj/014OH28ThYD2R6RenFHq9Qi5141BHdllTBiTFZ1x4Fo2rJQy6XGatSCsHb3a9Vj9pKzNZyfX4+C0oaBZKSnaYmUYT98SaxB44dm5R0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6X0OnJZUl13y99qLwSGAz3/A0TOzVtvpIo34UF9gbs=;
 b=RGaTK8LY8IedvHIMmQ37a9bSJ7RUjB+3cfccDWM1PV6AJVHmqDWCZTlQiCU7I4jBv4dDXWhqGwmsn1tHzCu9k9oYVgU+lrBghwGTEa19rhu94rXJPr07h+PS7TWn9evNfkY1H1VcbpiWwxC64RB50G7zklfSnTczggtUcwU38tPnYDdTWxN/zWF72I4vTFx+tok4FgCSkGceG6+QkNqUr+d7LFRE8X8/cQ/OFZY74adWDhGgIIeu9cpLpc5xSb3NXPCwwEb25kKkNNQdtMXLv5LJs00Ma456aX64JvQ+phaMeVNuNRye30I+fKwtcAn2H5ioOgomO3ojq4fsOL1zLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6X0OnJZUl13y99qLwSGAz3/A0TOzVtvpIo34UF9gbs=;
 b=EcULWGwVKk1dEOYefHRLveFAtKXbd3IeYTlCz6n0RZdtnT0FhVSQhniuR6QhWjY4WVmsFCV1WUiYCwAhHg5iLyvWgMJU83CtpmipU3KP8eZQEIXrya87wpd2TVRuZq38y/ELjbfn3KaVR8oywnqLgAywWsys4GHeaALl28Hhg33QBh3Ht2P5LC5hNkPQ6YkqaTjJfYDQxu9Jtdp2oHfY/ghNopfjZUBwRG7VZdch3vxa8B4nASpdcWpQ3iUMwbBYI5EQjR3EsOykD7Hgv+RuzkLj9ghq4SKAd0UmIPZyuDwq7zTNqVzhbyi3TADwMKNKglcdLrJDphwLQrcKakDpmg==
Received: from CH5P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::12)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 09:02:35 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::3a) by CH5P223CA0022.outlook.office365.com
 (2603:10b6:610:1f3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 09:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 09:02:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 01:02:18 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 01:02:17 -0800
Date: Thu, 12 Feb 2026 10:02:12 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>
CC: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Raslan Darawsheh <rasland@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH 2/4] net/mlx5: fix default memzone requirements in HWS
Message-ID: <icrksob6o5qhrrkz743y4fvnp7x3zsemjp5cuf6c6lu5strmfw@bdznsi6dcy23>
References: <20260112092439.14843-1-mkashani@nvidia.com>
 <20260112092439.14843-3-mkashani@nvidia.com>
 <IA4PR12MB9763A759C90A785344346BC0D063A@IA4PR12MB9763.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR12MB9763A759C90A785344346BC0D063A@IA4PR12MB9763.namprd12.prod.outlook.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: f860ac03-143f-4505-f31b-08de6a157636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1DnzlzauduHSW7g+KLRy/mlVtCzZfXNGHZRk5SKRcWZ8rF9m+VMf1Je/pH05?=
 =?us-ascii?Q?g+jcu9gjcEIRMeGkOK+d6nm7bxEhTgs3U2dOK+Siv+2bW5F8oCzrGvSP44O9?=
 =?us-ascii?Q?Qfui/iHxAWGL6GXiq5lO4w6WTNSisa4ih1V0Xd33dxnlmXmzrG6ta7T64iNy?=
 =?us-ascii?Q?+0/22mSCdtqeBfNZuKpXb7PjKtBEk3bfBRqZIiDXGd7DHXg9K+4OoAihZ0Zy?=
 =?us-ascii?Q?9BIZ4vruQV4MqnHxtgiKbkq+Mz4IHtAj1jbQZF87R11dw62W+ze43DoJlqcM?=
 =?us-ascii?Q?fkdTqozqev0VG4UaHd/exLHdt8HoUC/Ehp3RDoEV6Bf/ql+BGcLePy8mx1n7?=
 =?us-ascii?Q?igea82Ei0a0Nz8h3Wf2kgNVWu3Ay0M4taRE/xLfQWnrGEtEh1QX9lBHCvTyt?=
 =?us-ascii?Q?4bSpW7Ek574llnGwHYz57fecexc13E0eP2cD9vQH+y1nFNPwwzPS2mRxVYjv?=
 =?us-ascii?Q?M9juuHBOb+uYRkHM2AiYS/S97sG5uubTprW/cjhyk5/n8tKAB+w7CCba7p7/?=
 =?us-ascii?Q?LmWZIEIxs7b9lL3fQua6wZ7CyL0JzXlWXtN8ockPTF2B64lvEiRwbVrBwxG5?=
 =?us-ascii?Q?60ibDn9/mAOjbGA8pK9YVZLsKNCb+tc8gaKU6RQYYNCZzM6JEkMXAMJWE71j?=
 =?us-ascii?Q?ksU+gbOFt7CDnLaft73GQjcmq13FxOpAhmPCgRStLeskg5OWbt4GljpTsYuS?=
 =?us-ascii?Q?wIL/TyE6bOdhfmonLC0GTJH0df6AzaXic0R36b8Eh1EBmhPtho5HNsz1dNxD?=
 =?us-ascii?Q?iANgZmDqYJxBHFrPtYTxzzZ+zUA7XMQSRXt0Vl4Fad1B3eS/C3k7x7jazx6l?=
 =?us-ascii?Q?QT9tk0OyhLilSPRJ5cud1mIEdFwZY+8VBGfYI6MjRTB3EM3Ej6dQL9dVIQYt?=
 =?us-ascii?Q?cC9/jbaNQeA6xdKihXtrvQgC1x2e1ZpWFdf7sqzo0fVB8zVe0uEh+dRGDU5y?=
 =?us-ascii?Q?W//hV/2MDsuIYDLfpVB31Iiy/4O8bNCjkio3q+gdQPPq2tvu+EAoZWfL5+ff?=
 =?us-ascii?Q?DBSijsCz6zkYuqHWznIr1lv02XqGEld4fjJELDVGAZoR5Borrsu+XFPqadYm?=
 =?us-ascii?Q?Irp9DETKyRVObBveroCw8sVOc7jRoubUxJJO/xui6lmuoezh0QIxfH1CR5zs?=
 =?us-ascii?Q?PhzV8CUQ38VMmaZemzIHxE4m0vq1hR2X+fBmD6gvJMe4ZftqBr3s3jQldkdw?=
 =?us-ascii?Q?YD/HJijifrEF/0XGxcpSGOF1qkrUd0/FJXXQfQ2N0a59NWN2Z2GnHqoF4Rlr?=
 =?us-ascii?Q?SCvUVtGgWY/CgGnfgkAPZKdyaiMIYq/Z9JGgkRLNALwKGkvOiu/va3cCiIVl?=
 =?us-ascii?Q?IzkAs1uyWNCgRN5YnBOyneiGk/3O7fCFQ3TFGvttCwtRs0I1vN/UU7k0PT+K?=
 =?us-ascii?Q?XuYczGKrQXTsqzoyHvjkJdgoNUtwpWc1ZU9+98Ckze/mgYyMUBpmk54N1YnO?=
 =?us-ascii?Q?nROiZUu+xn3TlbS2G7xXjkdff5x6IPkrdHxbvmIcgqX0Minmt0EXLoHfA/Kx?=
 =?us-ascii?Q?5J+B+ER/MPhjgXPgkk4OqEfW2NvrANlwgIE7UOqAffAqJQmEcCPq/ptiR+i4?=
 =?us-ascii?Q?cUdGM+B2VACLCVvrpNFWlrA4eRYy1F9U6XIIkGSMI0VSAPLphH+O2C/c6qZ4?=
 =?us-ascii?Q?eJ8BjhHIK0UYoGHowVAP/qAfpWiMb5gwyUKAfhJwnBMTzmATuXKgEyGUrSO0?=
 =?us-ascii?Q?9KFwhg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GLZE9oJABVUi99FmuMrVv06NEKvi18U4Sej1e+K/pSzyT3ubz9ovTyPWRVNJqgRITKmVaVm27Lo0dCG0bu4xlIhmYjsLSevgHeDkmpNRsWsiTLYziKntjeAgdoSlPpwvMwSB4lVkCG23ihhKMJqpgpl+UC3WLx0ttrLfXC7n7ctAW1VyD3rjgWxZIyQgmY4T9kFmCfUSid9OQjOdZyLq7wBXzMfojri3LdJlWxNgUkaIKfBafudRq7ujmpL/5qnHJdcBN8AY69y139YebC+d6i+vthoGfmMno57UrdfeuP3PE4YgNYfKpp6Y36qOHi30cb0+S/LP9hW7/CaeQdjptYPd6XLakzMGyStH17zLnmW7uSJV2CUeKUEiURBxTMRcAXKAV5avN6zFzsfbWrRxkSURGGYuY18SA9S8uSqYRCU5a3DgV0RzHVgn6nPyYqhH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 09:02:34.1511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f860ac03-143f-4505-f31b-08de6a157636
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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

On Wed, Feb 11, 2026 at 02:38:48PM +0000, Bing Zhao wrote:
> Hi,
> 
> The code LGTM.
> I am thinking that if the user wants to use HWS for up-to 1K SFs, we will still reach such limitations or if the application try to create some rings per device.
> Maybe in the log we can tell the user try to use some API to re-configure the maximal memzones as a hint. WDYT?

If such a situation occurs, I think the existing error log from EAL
sufficiently describes the root cause and possible workaround.
I attach the error log below:

    EAL: memzone_reserve_aligned_thread_unsafe():
        Number of requested memzone segments exceeds maximum 2560
    RING: Cannot reserve memory
    mlx5_net: Failed to start port 998 mlx5_core.sf.998:
        fail to configure port

> 
> > -----Original Message-----
> > From: Maayan Kashani <mkashani@nvidia.com>
> > Sent: Monday, January 12, 2026 5:25 PM
> > To: dev@dpdk.org
> > Cc: Maayan Kashani <mkashani@nvidia.com>; Raslan Darawsheh
> > <rasland@nvidia.com>; Dariusz Sosnowski <dsosnowski@nvidia.com>;
> > stable@dpdk.org; Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> > <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> > <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> > Subject: [PATCH 2/4] net/mlx5: fix default memzone requirements in HWS
> > 
> > From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > 
> > Commit [1] has changed the default behavior of flow engine selection in
> > mlx5 PMD to accommodate for new NIC generations.
> > Whenever underlying device does not support SWS (e.g., ConnectX-9 or
> > untrusted VFs/SFs) and device does support HWS, default flow engine would
> > be HWS (dv_flow_en=2) which also supports sync flow API.
> > 
> > This behavior change had consequence in memory usage whenever SFs are
> > probed by DPDK. In default HWS configuration supporting sync flow API
> > (i.e. without calling rte_flow_configure())
> > mlx5 PMD allocated 4 rte_ring objects per port:
> > 
> > - indir_iq and indir_cq - For handling indirect action completions.
> > - flow_transfer_pending and flow_transfer_completed - For handling
> >   template table resizing.
> > 
> > This has not happened previously with SWS as default flow engine.
> > 
> > Since a dedicated memzone is allocated for each rte_ring object, this lead
> > to exhaustion of default memzone limit on setups with ~1K SFs to probe.
> > It resulted in the following error on port start:
> > 
> >     EAL: memzone_reserve_aligned_thread_unsafe():
> >         Number of requested memzone segments exceeds maximum 2560
> >     RING: Cannot reserve memory
> >     mlx5_net: Failed to start port 998 mlx5_core.sf.998:
> >         fail to configure port
> > 
> > Since template table resizing is allowed if and only if async flow API was
> > configured, 2 of the aforementioned rings are never used in the default
> > sync flow API configuration.
> > 
> > This patch removes allocation of flow_transfer_pending and
> > flow_transfer_completed rings in default sync flow API configuration of
> > mlx5 PMD to reduce memzone usage and allow DPDK probing to succeed on
> > setups with ~1K SFs to probe.
> > 
> > [1] commit d1ac7b6c64d9
> >     ("net/mlx5: update flow devargs handling for future HW")
> > 
> > Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable
> > reconfigure")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > ---
> >  drivers/net/mlx5/mlx5_flow_hw.c | 86 ++++++++++++++++++++++++++-------
> >  1 file changed, 68 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/net/mlx5/mlx5_flow_hw.c
> > b/drivers/net/mlx5/mlx5_flow_hw.c index 98483abc7fc..1dada2e7cef 100644
> > --- a/drivers/net/mlx5/mlx5_flow_hw.c
> > +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> > @@ -4483,6 +4483,9 @@ mlx5_hw_pull_flow_transfer_comp(struct rte_eth_dev
> > *dev,
> >  	struct mlx5_priv *priv = dev->data->dev_private;
> >  	struct rte_ring *ring = priv->hw_q[queue].flow_transfer_completed;
> > 
> > +	if (ring == NULL)
> > +		return 0;
> > +
> >  	size = RTE_MIN(rte_ring_count(ring), n_res);
> >  	for (i = 0; i < size; i++) {
> >  		res[i].status = RTE_FLOW_OP_SUCCESS;
> > @@ -4714,8 +4717,9 @@ __flow_hw_push_action(struct rte_eth_dev *dev,
> >  	struct mlx5_hw_q *hw_q = &priv->hw_q[queue];
> > 
> >  	mlx5_hw_push_queue(hw_q->indir_iq, hw_q->indir_cq);
> > -	mlx5_hw_push_queue(hw_q->flow_transfer_pending,
> > -			   hw_q->flow_transfer_completed);
> > +	if (hw_q->flow_transfer_pending != NULL && hw_q-
> > >flow_transfer_completed != NULL)
> > +		mlx5_hw_push_queue(hw_q->flow_transfer_pending,
> > +				   hw_q->flow_transfer_completed);
> >  	if (!priv->shared_host) {
> >  		if (priv->hws_ctpool)
> >  			mlx5_aso_push_wqe(priv->sh,
> > @@ -11889,6 +11893,60 @@ mlx5_hwq_ring_create(uint16_t port_id, uint32_t
> > queue, uint32_t size, const char
> >  			       RING_F_SP_ENQ | RING_F_SC_DEQ |
> > RING_F_EXACT_SZ);  }
> > 
> > +static int
> > +flow_hw_queue_setup_rings(struct rte_eth_dev *dev,
> > +			  uint16_t queue,
> > +			  uint32_t queue_size,
> > +			  bool nt_mode)
> > +{
> > +	struct mlx5_priv *priv = dev->data->dev_private;
> > +
> > +	/* HWS queue info container must be already allocated. */
> > +	MLX5_ASSERT(priv->hw_q != NULL);
> > +
> > +	/* Notice ring name length is limited. */
> > +	priv->hw_q[queue].indir_cq = mlx5_hwq_ring_create
> > +		(dev->data->port_id, queue, queue_size, "indir_act_cq");
> > +	if (!priv->hw_q[queue].indir_cq) {
> > +		DRV_LOG(ERR, "port %u failed to allocate indir_act_cq ring for
> > HWS",
> > +			dev->data->port_id);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	priv->hw_q[queue].indir_iq = mlx5_hwq_ring_create
> > +		(dev->data->port_id, queue, queue_size, "indir_act_iq");
> > +	if (!priv->hw_q[queue].indir_iq) {
> > +		DRV_LOG(ERR, "port %u failed to allocate indir_act_iq ring for
> > HWS",
> > +			dev->data->port_id);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/*
> > +	 * Sync flow API does not require rings used for table resize
> > handling,
> > +	 * because these rings are only used through async flow APIs.
> > +	 */
> > +	if (nt_mode)
> > +		return 0;
> > +
> > +	priv->hw_q[queue].flow_transfer_pending = mlx5_hwq_ring_create
> > +		(dev->data->port_id, queue, queue_size, "tx_pending");
> > +	if (!priv->hw_q[queue].flow_transfer_pending) {
> > +		DRV_LOG(ERR, "port %u failed to allocate tx_pending ring for
> > HWS",
> > +			dev->data->port_id);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	priv->hw_q[queue].flow_transfer_completed = mlx5_hwq_ring_create
> > +		(dev->data->port_id, queue, queue_size, "tx_done");
> > +	if (!priv->hw_q[queue].flow_transfer_completed) {
> > +		DRV_LOG(ERR, "port %u failed to allocate tx_done ring for
> > HWS",
> > +			dev->data->port_id);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int
> >  flow_hw_validate_attributes(const struct rte_flow_port_attr *port_attr,
> >  			    uint16_t nb_queue,
> > @@ -12057,22 +12115,8 @@ __flow_hw_configure(struct rte_eth_dev *dev,
> >  		      &priv->hw_q[i].job[_queue_attr[i]->size];
> >  		for (j = 0; j < _queue_attr[i]->size; j++)
> >  			priv->hw_q[i].job[j] = &job[j];
> > -		/* Notice ring name length is limited. */
> > -		priv->hw_q[i].indir_cq = mlx5_hwq_ring_create
> > -			(dev->data->port_id, i, _queue_attr[i]->size,
> > "indir_act_cq");
> > -		if (!priv->hw_q[i].indir_cq)
> > -			goto err;
> > -		priv->hw_q[i].indir_iq = mlx5_hwq_ring_create
> > -			(dev->data->port_id, i, _queue_attr[i]->size,
> > "indir_act_iq");
> > -		if (!priv->hw_q[i].indir_iq)
> > -			goto err;
> > -		priv->hw_q[i].flow_transfer_pending = mlx5_hwq_ring_create
> > -			(dev->data->port_id, i, _queue_attr[i]->size,
> > "tx_pending");
> > -		if (!priv->hw_q[i].flow_transfer_pending)
> > -			goto err;
> > -		priv->hw_q[i].flow_transfer_completed = mlx5_hwq_ring_create
> > -			(dev->data->port_id, i, _queue_attr[i]->size,
> > "tx_done");
> > -		if (!priv->hw_q[i].flow_transfer_completed)
> > +
> > +		if (flow_hw_queue_setup_rings(dev, i, _queue_attr[i]->size,
> > nt_mode)
> > +< 0)
> >  			goto err;
> >  	}
> >  	dr_ctx_attr.pd = priv->sh->cdev->pd;
> > @@ -15440,6 +15484,12 @@ flow_hw_update_resized(struct rte_eth_dev *dev,
> > uint32_t queue,
> >  	};
> > 
> >  	MLX5_ASSERT(hw_flow->flags &
> > MLX5_FLOW_HW_FLOW_FLAG_MATCHER_SELECTOR);
> > +	/*
> > +	 * Update resized can be called only through async flow API.
> > +	 * These rings are allocated if and only if async flow API was
> > configured.
> > +	 */
> > +	MLX5_ASSERT(priv->hw_q[queue].flow_transfer_completed != NULL);
> > +	MLX5_ASSERT(priv->hw_q[queue].flow_transfer_pending != NULL);
> >  	/**
> >  	 * mlx5dr_matcher_resize_rule_move() accepts original table matcher
> > -
> >  	 * the one that was used BEFORE table resize.
> > --
> > 2.21.0
> 
> Acked-by: Bing Zhao <bingz@nvidia.com>
> 
