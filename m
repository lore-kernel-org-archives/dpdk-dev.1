Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3359FC87FD2
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 07:49:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65EAC40270;
	Fri,  8 Aug 2025 09:49:41 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by mails.dpdk.org (Postfix) with ESMTP id C0F6E40150;
 Fri,  8 Aug 2025 09:49:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqtIpq0hXpqHQR3sSzU5siurgDkKGhERPbIi9nFDMmPWsGDklzHMLKLZtJRi2oTSvLHBml1RKDRVhJAvOLh7ZWVP9GjZ3XROG9SE+GAeG7zrQK/RkGSPEZsiU9mYx8hHzTMCID4LBE80InP3P0BWxMJrbA5TGvo2al+ABeAUwZLkNCd04KQtgz6gPVwYMerfS5YNAw8CBTc3TvPnryxt2epPmnXwK32ckN9qqSNAFjUhqRV5JG9t4U4OGAR+uHAT5st4EiaHcKRcO1oAp4YIF37Pm8rZAxpbP7iJrHV5ZhXdEAf0LnEjqXw4tymVYVDwsCAr7TPxmSb+oC9mjLLjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5f0D9gUGb8dsDiGyo7h7N21LI38vApxEoqliLuX4q0=;
 b=XP6x1mA5rWnShKRNR6nI2vjmcVlNwNy1Hr4XXTspRUmsTuwIm8fQfyaCfoEX4z8MprJCZfGNuy3ths8CDw3KrR+f9CJxTw/0dpEti5TN44MhfbaBJ3BuVXqYby4p12eu9pctjXeuL+OUoRJ5n9ul4UaknI5ZcyisNywPATp69VXgOh9RC1Ld/hndq+AgwXDwvr4kKBpUDHl6bdckBlU6ukUfG5BE9zl88FlM8mtqNeqX+3qVqHq1W9bpXxiMiep1SoCdGTNWbzkSm7+ePCM6eYQA/HAYwuQQ5kzQRUrYSLu26zCYXwUlCHoCVapT2KMJG2Tn0lyAv2vuGxPnKzQOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5f0D9gUGb8dsDiGyo7h7N21LI38vApxEoqliLuX4q0=;
 b=GEn3BnrLw3Ey2tF5mIq56QWNJuWYMAvbKCWqQ/ZMito2i7mU93MlfngSqmAIPVVyj7oFA2KnlKdDLIhbE28Pn5XGc9ONcTvLu4FZmg5nrnLC5oLZ83XLs5cZxPqKeTftY4rn4n7c/uJyQS1BWhkvrHjJbSISrx/iSgaRvjMQGoVe2+GQ1I0uSIqN8BAPWJ/gnWZhUUkd2XSe5Q/M68nqubdUzAGeifyP/C/vjWEGgkmDP6pyh78NKPOejRIARQLBODjAGomZ/WhoM8/sk0C2IXNl8HCwlOd3aJk5enxT/cJExzB47Dcp8Rf68dMj+mTbANXoSJ7U3CFsQ6TD1jJtEw==
Received: from CH5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:1f1::10)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 07:49:34 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::6d) by CH5PR03CA0020.outlook.office365.com
 (2603:10b6:610:1f1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 07:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 07:49:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 8 Aug
 2025 00:49:15 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 8 Aug
 2025 00:49:14 -0700
Date: Fri, 8 Aug 2025 09:47:38 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <ivan.malov@arknetworks.am>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>, 
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix connection tracking state item validation
Message-ID: <20250808074738.2nqgorlqzzyf2jid@ds-vm-debian.local>
References: <4a26fe30-fb35-f306-d0df-e935ba3a0a89@arknetworks.am>
 <20250806085142.739366-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250806085142.739366-1-14pwcse1224@uetpeshawar.edu.pk>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d6fb52-66e8-4649-f399-08ddd6501d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5N303T5hiSn53Tex+jKxKYoRy6J3ecpnDZUvW9UkyvvIdL6gxt/dhloztCRS?=
 =?us-ascii?Q?p9Gb4nppeJU8P9sA/+rjY9If9sj5HVPZAtx7AnmqFNmCSwmzYmirZCJWuJHH?=
 =?us-ascii?Q?MH8EZRmbYUlMvDAr0GkQWQC7AVoe7UD1cF7Mq6ziPQArQSLNX9MsPhRZUj0M?=
 =?us-ascii?Q?s4yfNg0NyPmVYOemRKfdXt8D4wStvNrtwKU3V5y3lI9bt6k4BjJt4PqTQRVe?=
 =?us-ascii?Q?IQsVARE7aZU9kQmqA8eIXnqfhhi6bi17feZ9OjOHnSLAoz11h3ZAfu05GPNL?=
 =?us-ascii?Q?/BqmLL6s4EzWvq2x5J7AcoKVimgRi5ithBHAKMmKd6ie6NmzVTfIa4O5fpWO?=
 =?us-ascii?Q?DnddUkyV/Ll4j4EnBaOLrhyJWSSxUD00wT9+kFsMizvVgeobPu0GkFGrvRr6?=
 =?us-ascii?Q?wHALkBiB7T3SlBhbAIWbuiA1kww4HbRnZ43deJxBbWk0gQxxdpY1A10tEyLt?=
 =?us-ascii?Q?QfTlrEqYIR1lbBBAJiho5NadePM+dvm3ImucXNNpVQ/qHglpjng2ynvr4dY5?=
 =?us-ascii?Q?+m1Ngm8dn4vFwm3bBaiNEvzLgn62HxqnbsKI8s5aKbFPkecH98z/wI+NZjMa?=
 =?us-ascii?Q?t3jFYtMzyB1CRC/gnW+PhZbpb2blUNsBf7WE2mdTMlS+RCmmsPnQo5rlBd1H?=
 =?us-ascii?Q?ydQ+5g3RPuGdfe/EXX5LpzXrnId233ce10LFI2iVWgeIPGdyqRBeVJtosnAU?=
 =?us-ascii?Q?hCFfZuvGlu3xthw74R6Z3svpXHMr561cU8FAzToZrx4QO5tKd062FFLlDi1Y?=
 =?us-ascii?Q?xnc4kbTU8k1eOF6zHBvOpIWUoiQX+PXn4hXBOkxaAWjJPeGqpFvHmio+ccK2?=
 =?us-ascii?Q?IytHmGtd2g3Rz6g3hjGkvW8d4R+mHFva3UqiNlfIAm6IlyKUN0rRVXasUScA?=
 =?us-ascii?Q?OL7QsOY6hJtFS1Vfv2J4NcWSi+yMANd/hDPkaoW/ttwz5eoqdlAQ8L34trfb?=
 =?us-ascii?Q?DiNjzSQA5DDz7jblVFcNn4bXETwXb43EU7aSwl9brVIKbgQsQBYQcJ0XogaF?=
 =?us-ascii?Q?W6LiKDgMTVRWgt4eOP/cmKDf64f2LOpU4lFcny5/9uEDooWFS6NxJb9wOSR1?=
 =?us-ascii?Q?cVbsHcLx1gNVP9oD8dziaxsQCQpnsn+tmOqZQZfaDrAVQ+Z7kxiwRWlWb39k?=
 =?us-ascii?Q?HO1MpVjMfXCNe9oq7jZ3kXS9aCBHns8WhpkwlOp+cZQCAio5YdN7h4rxD9HW?=
 =?us-ascii?Q?RbGtG9t1VIITm6/FwXOy/ig7O8i9tL2DFNAWK6QDov3hfpOaRcsp4JGi+PS2?=
 =?us-ascii?Q?dmu2g6lgjPw2KCMsFpBYDVbOZP/NgQyknb33pmzIxPkdgVBD/uQ+TUKdT78E?=
 =?us-ascii?Q?uuZjbGfOU3W7JmGTgxFZNEkKeFhlVvAy6Vqp+wIAYBRZDiaN+s6Xgzq34rYp?=
 =?us-ascii?Q?tJ86VzcFN7r+YLRk1veZhU59pn+/el7ZcLt2SPpKOIVgYtpfXtSMtF1WRtAj?=
 =?us-ascii?Q?IfXo/vYkV4RBcyZlbco6RMAHLhy8cmcOlcCOuOmUmkQ4y4aHi8vqAxEHi8JC?=
 =?us-ascii?Q?DnBBDiMrAyxYeyPYZKeTLCkyGV/LSJ4cNwAX94AA+WZ3aHQpY7ZmoXS4cg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:49:32.6031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d6fb52-66e8-4649-f399-08ddd6501d70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
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

On Wed, Aug 06, 2025 at 04:51:42AM -0400, Khadem Ullah wrote:
> Hi Ivan, 
> 
> The multi-line block was not closed in brackets due to coding style.
> 
> Spec provides values to match (e.g. a given IPv4 address) in rte_flow rules. 
> Incase of the flowing rte_flow rule, spec provides in 
> mlx5_flow_dv_validate_item_aso_ct the conntrack state to be validated. 
> 
> The following is a valid rule and it should be offloaded. 
> 
> flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 1 / end actions queue index 5 / end
> 
> and the following is an invalid rule which should be rejected, as there is no conntract state corresponds to 10.
> flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 10 / end actions queue index 5 / end
> 
> Please check https://doc.dpdk.org/guides-24.07/prog_guide/rte_flow.html#pattern-item

I think there might have been a misunderstanding about states
relevant for conntrack flow items and actions.
What Ivan has mentioned regarding RTE_FLOW_CONNTRACK_PKT_STATE_* flags
is correct.

- rte_flow_conntrack_state enum denotes possible TCP connection states
  (SYN_RECV, ESTABLISHED, TIME_WAIT, etc.).
  These are used during creation/querying of the conntrack flow action object
  to initialize/inspect the TCP connection state machine in the HW.
  From flow API perspective, it is relevant only for the conntrack action:
  https://doc.dpdk.org/api/structrte__flow__action__conntrack.html

- rte_flow_item_conntrack flow item is used to match packets based on
  how they interact with HW TCP state machine.
  After conntrack action is executed in the HW on the packet,
  application can match that packet based on the result of connection
  tracking e.g., match correct TCP packets which are in current TCP
  window or match packets which change TCP connection state.

  As noted in API docs - https://doc.dpdk.org/api/structrte__flow__item__conntrack.html -
  this item takes a bitmap of RTE_FLOW_CONNTRACK_PKT_STATE_* bits.
  For example match can be on RTE_FLOW_CONNTRACK_PKT_STATE_VALID | RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED
  meaning, "match valid TCP packets which change TCP connection state".

Because of the above, the proposed change to validate item's flags
against variants of rte_flow_conntrack_state enum is incorrect.

Best regards,
Dariusz Sosnowski
