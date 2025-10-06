Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D90DCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:04:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E58FE402E2;
	Mon,  6 Oct 2025 10:04:34 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013010.outbound.protection.outlook.com
 [40.107.162.10]) by mails.dpdk.org (Postfix) with ESMTP id D0EFD402AF
 for <dev@dpdk.org>; Mon,  6 Oct 2025 10:04:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNai4I6OByvxflhkgGQQSnN2H3C/kTzrrDdF9+NsMhjSgr7lE5NC5kT/6DZ2/thoKQ2mtxY3h/tNlVCHk3HCnpyU1TTojp51BMAPRCnpfz67Y+fuBEP2znCQIvNw19PVRU6a7DP0dtCebfsKDy1mOpnNijsL44zALqz/hj21fvtWZEpnLsxvWhg4IKIx0ojnYAtzS+i/OKpzt9WuuJvWZytACNFk+OuOm4Ihi2dIsZIN5ptQ4RERjBAuX/zH8ltTif6dLbhwScCiYI1JknziX7sos/e+YtPtxyX6emNTCuK/DvBucL/zPHuBwVM+g9WiiS+ew9sqnIIAVWMoMhSfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6XwAb7OdG2PQXzLkoLUCK3FHAeXOiElK6kU2JXP228=;
 b=n3KwPPgLusv4cafUcF9ZbfZPl36fIqlob/ICgnKYuHSNeRLykghDTXtso2A4mcFnbDFb77TGOs5BQsDO/AWgohV/J7ZMHYgDI69EeusX3NuHmO6RGcYYMq1eBDkTYkqDa/k7vhtwQPxofc34e9MY42btQz0lOPA197UiEIaBmJaJ/6Q+hM3ih2qyB5HwutSXChrOzZ5I2ZJYD9+RMcnObURwCknKui6Vn4Yezi5utlUVmdzF0nSq44bu03ec7fOjoA7DYbN5fiSUuxsLN9jtflamCig3Uazhc5RVTAc7zl39rAZ/3lVNBd62dSY7kEM8hPz+IS8mjwPZq8EAEt7wxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6XwAb7OdG2PQXzLkoLUCK3FHAeXOiElK6kU2JXP228=;
 b=crCK8oktgrknrmUAji06A2KEw2HcBo5vQAjqxIpXp6K3StDa/sH+3aDLchFs2yF9Vx3/5sE85V4jz/SgNY/1MwRj7gacw9v0A4AGglllqwTLbgRY7rFM5VVMJdEJxOo4IHtXLRV+XzSlZh0pydL7Ckl0H/l6JuKcgcZxN17e4EmP9biMNamR9j+TU+Ivrio49hbB7UZCUa+0iaBxtiTVnh4uvBw4/xbSq1rscVefJ9HLQkWmIcjZ/fKN+Hi+wL8joUbkU4yJW9BHnbWiQPhH39op+8PS/4WOQ+4pMHm5THBSCfxQ9OMl+b0gnFBtHg1v15Qz9MT7eltudaarl18MZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7842.eurprd04.prod.outlook.com (2603:10a6:20b:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:28 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:28 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Subject: [PATCH 00/11] net/enetc: various fixes and enhancements
Date: Mon,  6 Oct 2025 13:33:59 +0530
Message-Id: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM8PR04MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: f7703c4e-a7d0-4c49-5dad-08de04aef8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rhzi+I/JCLb/CgKQY8Ay+MI4tXguzm54vzMVqgOXloediRc49mbPWg5ZSGtS?=
 =?us-ascii?Q?Q779p+PIXTsUmFJk9/45gSXR8pt/99Tzhbn9gK7jq7WTAfDPK4pSiOX6TggO?=
 =?us-ascii?Q?U5buDbbzUPLjMCqOZLcuQ0ASUgC9MPtWwQxCaSiJ75+Al9W92mtZwL3vxgoe?=
 =?us-ascii?Q?RtfHm93jUmAyr9XgiouYs6ovc78+GEv36Aljrg+WafnbmEKvGKeHy7c+k1kM?=
 =?us-ascii?Q?m44fosnLy1gUY9gWNH7dIcNZT4ojXEqdFznqEWj9782IxVK649lvVz+ckFCt?=
 =?us-ascii?Q?0G6dcMh6pkO7hY5xMoSEM4/xxEOrX5AOVg68nyd0taTzwrozj7HCZDmpEWdG?=
 =?us-ascii?Q?3xc+12o/zjwPuPDkioXPz1/wQVWFGoxTLS8U/8T4LokSAOo4CRNL6ZYfD3wu?=
 =?us-ascii?Q?erQtH6tL22smkPu9umESPBPirIKkhARWcNW0oU+o46e7Wa8B4jRsS0YnkovV?=
 =?us-ascii?Q?Gj9yoLP70Z9/lMXi6CzgILtZzQ/mDethXFZ40yaVbKn6rzBZx9rZu7Zf+J4f?=
 =?us-ascii?Q?p8Sxomew8crRimJH+F5dPMXrVkv7gAVr67cRs4uIpXTGbtu2IXKPgnlpVCIU?=
 =?us-ascii?Q?OMnPQepCOrZhMChDXXiSax531me8Lpq038oiSVeQJf8ltc8Dok7RsOryFhSt?=
 =?us-ascii?Q?2b0YGzSbGn6HFyQZchEFL8n5Iq//pUppQddj1PCNUmppT9ZESkrknLmwu708?=
 =?us-ascii?Q?f6m9noX5od7ZIuqlUpxzHWSmK+li+gK9jZtw68ASuybSx/s8YRgGE9GLGKD2?=
 =?us-ascii?Q?kfBmchanAGJ9qN27ycoMvHEHtvtnUHvy/xC9ANcEJpeVyFLRM1d5qg3B0fGc?=
 =?us-ascii?Q?XLf133qlCs9d6y6t9U6IZc/iqF1kJ+Ta7bZn4hin1YKBJVNkV1F8Qo8hZm4k?=
 =?us-ascii?Q?fUMZgiIf1L+uv6pd+yO9i0iUE4IKjZ5ZbiaOUSZIl4JZf+TELnTSINLrk4LN?=
 =?us-ascii?Q?jlnFL4e1fMpbG5U5Df/+5tRr5bdfHw86vxh1A/YHlHPFLdITN8771+/I+Md4?=
 =?us-ascii?Q?jEDchohJGW65JVKxHA/6/XT6LkM2t67g/3ABLGqDrpVjifMqjrY6jVgE9Xmf?=
 =?us-ascii?Q?yQcAl87FTDHsuQCJtEaWPjapN0g/oxqcDuGzH78iHFEBu2XIOtMIS7/adOYf?=
 =?us-ascii?Q?+3NGTgzXlZV4wByKcp9dTqjAzIl3fSYzdfG5XBYpMKmDAIuyT4HVbMYQw6qF?=
 =?us-ascii?Q?36uN12Zrv7ICQCMKNk/BAstYg87S9D3NrilQY5RZ/u8MDleyCUzm/cIA9fLZ?=
 =?us-ascii?Q?dYyN55XKwv27E0zoSZToqfwMBhqEZ8G73h3GNIMvMMszjLA96uExXG1WuwAL?=
 =?us-ascii?Q?l9b+4nXB741qmPdUDuXYedLrqN8huskc3TUP8ZYFaKkndX/EDDY2obJ0VDEg?=
 =?us-ascii?Q?fnq3Gq/imgnStiv4AYze9DruKxiOTWtZXpvoURVSlYj1vMXJ1he/LFw4fS1G?=
 =?us-ascii?Q?uRN+0LucXsYUj5I31WPuEFZgr620PsIYg4ss9a7XuUAH36lP9M1mctjTyOiZ?=
 =?us-ascii?Q?IwpDLSCG0niISpET3yBpiwKtRys5xDQGmq3G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ApPe4ziBb4KQF6KHxkr+DS44rlfzBzV551v7r2F89Qk8oJaJlbe6+PPJQ8u4?=
 =?us-ascii?Q?sM7TULKxIWyc7XwpDMzzJf1/vZpn8BlR0MHjJtdJObEr6udQ1kk6rCNhgENH?=
 =?us-ascii?Q?4L5nSIfiENPCULzhE9WvEinyzHZbgC7Am+7yebbcOC/mWH6I7nlx7Gqc4UDW?=
 =?us-ascii?Q?29hyfQrzrfVNxcEZozvV+dNKrbVQKg4WXA1QdgGIfp9SKmsLHFPEDjNmP0Ww?=
 =?us-ascii?Q?AQvhTVOiL6hDhqtcAVKWwYrivUAx3hejGkutWk/ISipNwSirv5TJSHJ7ZIos?=
 =?us-ascii?Q?m+exINInMZyFfwR/s0/2s+dZ9spixic5mTyApk6TkgdjrLdao5zNndQPReGG?=
 =?us-ascii?Q?eK9tbPaOsN9aGyFRNbdNwPspBF9F+hkEgDjG9oPAXaJZgQlafgQWO7EdeYvk?=
 =?us-ascii?Q?LiZUQPYgK94j2s+0D3PBCBrAmhf22ETllI0CsBg+/WYoDByRc9CmRP2akCQ1?=
 =?us-ascii?Q?+QNB68imaW1OgEDMlP8AtjRZfpRrZMriqZc+Kk9y5Tuyf5lvD74zJUlghJi0?=
 =?us-ascii?Q?om8SOUi+wZkHoDIoV4mXtS+oNuCBY2wp15FaW0mjT4m8IldSOdRsZc7i5j8n?=
 =?us-ascii?Q?EDxyOOsRuFfj7QlAsh5bXjQYF2TaKJhm/ZHl5F0CGp7m+/cc6FS9ZmC56xiU?=
 =?us-ascii?Q?0M/YJCdyPJw3Y1vvcuojNJciAlBFSnH7mmY/xx3/O8uC9MVra+c8whtNDyZD?=
 =?us-ascii?Q?Mo8ZNSp8XOuR+bWH3+WLQ2w1J8Lx6fjNk3iYsdSUAM9MHG/j9PoS7lAErXSm?=
 =?us-ascii?Q?A3KQlqiTbQn6lP0172tSalKYeOi9Vvi5FKVdFGdvWG2vpZ2xiFd31MNe/ZMN?=
 =?us-ascii?Q?QeqUp6VKr9TmNDPJKyM3aJENgsZ7pn35lHtcDVH7WMRW5TUGcYlpq3XzQHIL?=
 =?us-ascii?Q?K8Z+PQTb7PDEf/KjRJifXToD9iN33chGmmRxOPOYhTlBBCAMIQtrpVLRT0IC?=
 =?us-ascii?Q?77+Go9x/pIjIhOBK/FaOW+w6y2TTAnqv6QksJj7XRbbZdJypUAVS7apibCwf?=
 =?us-ascii?Q?D8dXBKnUF1Egt42N4MOB0SfsxsyhCGjozIiedpayG2m+7888D6bIl1jS/kNV?=
 =?us-ascii?Q?vScXn5NWh5EVqND6AUCp/joYndjHWxYE+JgqONxXhf4ZKXuupg9Ibu6T6QnL?=
 =?us-ascii?Q?bT82OLYUklkdvDG332CEUqpcwJfEhjcu/s5/h0fUkQrHwtpmLt/gx6uTSg5y?=
 =?us-ascii?Q?3lKWXJQXaRv4FxmdrUoclQ/fEOM2oSOI6nx6R4kUjBiczyToQzCI832m/22l?=
 =?us-ascii?Q?xUKpDKFhSTxaiHhKkkF9WZ0uuaEVoQe6ZPvIFlXXiMjrk9gxiQT49wHXC3p2?=
 =?us-ascii?Q?LyVGzKx+EUwNBC6XMyBxP62RDdGTGsvpt/X1DZ5xVmEqitQiY9nn/tY0AMuY?=
 =?us-ascii?Q?BHgoBulDlrKDFGr5rNF7Kv9C2OOy6HkO5FsUnwHEb4NSGmkhUMW85bbKS/NO?=
 =?us-ascii?Q?0Qvk5mgJmbO+Gx1BbybCbPO1QS49yPDkIpYWW2y4nlre0CBECiB+ozpZoYnc?=
 =?us-ascii?Q?dogDFbdTZQHY0mLVLQXXKCePvID25v1xfuWUQrhiS+ztySpsg6VNBFWnQcKL?=
 =?us-ascii?Q?McpTPGtciMY/1pI4qhby7PkoneMpPpFfrOzVeYUm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7703c4e-a7d0-4c49-5dad-08de04aef8d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:28.3829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHCTWf1CXfVXY5qsXdcH8cJAD/jvs8367XdsKNaoqbo+FcaNgx3+rWWP1+OgzKfqabM50sJRi1gl1JrEN6mskQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7842
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

This patch includes:

1. Various fixes as identified by NXP internal coverity
2. packet parsing and MAC address support

Hemant Agrawal (10):
  net/enetfec: fix file descriptor leak on read error
  net/enetfec: fix buffer descriptor size configuration
  net/enetfec: fix incorrect Tx queue free logic
  net/enetfec: fix checksum flag handling and error return
  net/enetfec: fix to reject multi-queue configuration
  net/enetfec: fix memory leak in Rx buffer cleanup
  net/enetfec: fix to add check for Rx/Tx deferred queue
  net/enetfec: handle cache for forwarded packets
  net/enetfec: support to set MAC address
  net/enetfec: add software packet type parsing and cleanup

Vanshika Shukla (1):
  net/enetfec: fix out-of-bounds access in UIO mapping

 drivers/net/enetfec/enet_ethdev.c | 103 +++++++++++++++++-------------
 drivers/net/enetfec/enet_ethdev.h |  59 +++++++++++++++--
 drivers/net/enetfec/enet_rxtx.c   |  27 ++++++--
 drivers/net/enetfec/enet_uio.c    |  11 +++-
 4 files changed, 140 insertions(+), 60 deletions(-)

-- 
2.25.1

