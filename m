Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF549606A329
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qNSUkyds
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 091D040616;
	Wed,  4 Nov 2026 12:26:39 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 5E6374060F
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:26:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgLcHmDn+l2zquf1zsrxtV2L7oYT9J0IdoRN2iYl/Gv+700hQOY8W897K4mpn6/txi5cUPbQpxlCmdvNz6zcRWxctcZhC5ClmCRWvTP8YhSc+1U3wi+/I/Iqi7pDXEaXgIgFB+KwrOKrVbZ8YSilbypsXqwTehJtFcVSxoArIK1JQfDQmY9hjzKzR3rksnuYDRKpIAYVXVJjacmDtx8MKZW/gwqwmzoeUISJIpPEpRgCyFQSwOFlfiGM53KkLCEvBlMcgAitsLaX6zhlSnB+u2ey1yeQKsfuhW5zDG16gZq2zyUjLJ3E8ivPhxxXoR7x8YKeTaoxSXl3w0agsHh/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4SpD91nBkmlZwEzwXwVUq232VxOsWIA9HK+0Tb78Bw=;
 b=axpi5rBOseYNSLRZgy0ffkW6WElZL5Yy0yV0qEIg24NSaE0i1jXlbd/e5mLsNRg/XYLRq2HtGsj+SDygxMiV0JuujRfHduMCw09V9JwGfsPX2/rYoHL+bzrfK3eTcC9DbBiKBN2jXFTKXB98qR3Dfn7W5ZQavq9QOUYi+XqNOLidLNt28wtXFtmtUpKmxznC5oqEcQK8LcHm4JomhuAEWCx3JPg353fR4YVIFh/zHSSEfRo52oO+iQG2Ihb2WDt3GXjyAK2N0iJdXU1VbOd3RWxGxbPfecAxIe+3PuHeSXXWqPFsjXczKnDLFRsNBtGuJ9zPv6OQBqlAgeZTjjNScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4SpD91nBkmlZwEzwXwVUq232VxOsWIA9HK+0Tb78Bw=;
 b=qNSUkyds7R5DuKEG34ZH3PuxxXjp+ttTCOF687Ellv6be8uQ7f85QxQUS+5Z5k00yAsZBGDDwnNFnjEiWWyPLCkcPtLi0s7RXxq73h5PpzetmvTY2OqA5LRgQJpX9AdCba3XFMRywKp5LTW/G1iqwUrwqvYej84+QMpsIcGAMk0=
Received: from BN9PR03CA0922.namprd03.prod.outlook.com (2603:10b6:408:107::27)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Wed, 4 Nov
 2026 11:26:33 +0000
Received: from BN7PEPF00000092.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::7) by BN9PR03CA0922.outlook.office365.com
 (2603:10b6:408:107::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Wed, 4
 Nov 2026 11:26:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000092.mail.protection.outlook.com (10.167.245.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:26:33 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:26:30 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: David Marchand <david.marchand@redhat.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Selwin Sebastian <Selwin.Sebastian@amd.com>,
 Bhagyada Modali <bhagyada.modali@amd.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [PATCH 0/4] raw/ntb: AMD NTB support
Date: Wed, 4 Nov 2026 16:56:12 +0530
Message-ID: <20261104112612.664234-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJFAV8w21JOt7c5p3XA6-nLNb1BcCAWM9DBP3mj2BfkyE6rx6g@mail.gmail.com>
References: <CAJFAV8w21JOt7c5p3XA6-nLNb1BcCAWM9DBP3mj2BfkyE6rx6g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000092:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d3ac04-c7d4-462b-aeb3-08df3a667ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|18002099003|22082099003|261102123227099003|261021123027099003|11063799006|56012099006|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: i3cB3FfroyAAi5y+sdthXZUnCNxQgwQnUqmn00+R51j7BGOu+7pkAr4HoMTMznaId19EOUnO1FkfJQ479a5V9CLa4emwW5VyN409+YuX3CYXHYsZGxAbgQ8VjnDL7AwlrZXjgxmm+nK/JpBOc2RB4qg72TkOPtP1XGDZRs/RCGXrfq3oHsKuiKCyKPPl24cN2OOUZU9szJId50Whed7ZFrjlPJ1dWYdwL5BHtHbWqg8K+EvbO2fCPjjSn6ZxkOaiy6ozUHbooXJu6zpsU5ZKXXiIFQME9UULmXZbLlcvdI8uLjRl+xbbA4wqe2WXV0Jg5Fk/hcnXMNVIpqkD26QFLzJot/Hu1LvKRz2o1O+elcijAWQtDRMIdO9WVhM5HEOPeaQbp220vauTiUBwvaZK+9icCld74V0KlHfGR+7PLNY8tVbSzb/2mjLFQ26JirgrTs0zhNsZHiEN0hS9HLdOSe3wWBnFNL+cyq+RGJ6wwQZiLnls202s5TFf5LyS1pDKfN/PjaNDPH28/WdjqKFSnUxK/CbSgCklCA72QKWB8W5FPjetXJxSOINOs0lzFODRtJx7XXklShXh5pqmpQxSDBl2P72NtL386dJQT+6aqdIud9kkcisu+cFTJZUyASoUi73a17y2M1R2T1yBg+NahmJdQnt45+y7GaZdIKB+9TuZ59ZQCFokgpjcLFgC7xq7QF92otkj1fmPiN/iYSZP+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(261102123227099003)(261021123027099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p/tKeUQziWJNRzcon3rYqHNaLy6VT8NSKYOgqpQIVjk0EZorhPxkgLxC/BbZmQIpJMxttjQEKlf2F8wbv/M8IDWWn6QNjZ6Dunr/D7NhqBaP7QhThm5qReehqTTPJ4Sz9Ci3iQQFZ9duauPohpFt6eUACKGBFGopfw3nHuz7o7TODQKTLI3GWgytk66yqcSZZs5ENfzA4HDY7K7xvzbG/6jRqcB1wt9NYNToB6UAkH2VJuAmYbIca1WmivBKhPXdYGT3K3lzmyTQAHSinWA/lC35afNJvkkXsb/wqI1LXIywP9mB0wKPa92iP93xUDgteZXim/PrnHqmPjJ1uLEV0B8jBnIPmqHXXSkZqBeIOAh9NFp5RI5Y5boXuCr0yoaYU27/2G5MeWPFO5Mf01Ml6tyJSrUh7rAP6JJl/0HXAhHX14rHbgohiaafB/h9FP0T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:26:33.1704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d3ac04-c7d4-462b-aeb3-08df3a667ada
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David, Stephen,

Thanks for the review. All the warnings were confirmed, except the
memory window size check, see below. The fixes are sent as a separate
series: "[PATCH 00/13] raw/ntb: post-merge fixes".

- rte_pmd_ntb_get_mem_align() trusting any rawdev id: fixed, the device
  must be valid and use the NTB ops, and an out of range mw_id now
  returns 0 (patch 1).

- peer_used_mws overflowing peer_mw_base[]: fixed for both AMD and
  Intel (the Intel scratchpad value was also truncated) (patch 2).

- ioremap range check off by one: fixed for both vendors (patch 3).

- mw_size never freed: fixed, together with peer_mw_base which was
  also leaked on each start/stop cycle (patch 4).

- Doorbell interrupts with vfio-pci: earlier verified with uio and going forward
  vfio-pci support added.The handler is now registered on each
  doorbell eventfd; with it, the DB1/DB2 exchange on stop completes
  (patch 5). This also affected Intel with vfio-pci.

- Hardware events never delivered, and the switch on a bitmask: the
  AMD hardware event handling is removed, together with the
  handle_hw_event op and the unused definitions, and ntb.rst now says
  hardware events are not handled (patch 7). It can be added back
  properly later, with the event vectors and INTMASK wired up.

- Rx EOP guard leaking the partial chain: fixed as a separate patch
  for stable. A packet is only taken once all its descriptors are
  published by the peer, and its refill mbufs are allocated before it
  is consumed, so the ring indexes only move for complete packets
  (patch 8). While there, I found that the Rx mbuf handed to the
  application stayed referenced in the software ring and was freed
  again on device stop (patch 9).

- ABI changes note, examples Makefile, unused defines and the IOVA
  as VA note for large windows: done (patches 10-13).

- Window size check in amd_ntb_peer_mw_validate(): not added. The AMD
  handshake already uses all the scratchpad registers of a side (the
  last two being reserved for applications), so passing the sizes would
  require changing the handshake layout. On the other hand,
  amd_ntb_mw_set_trans() programs the window limit register with the
  local memzone length, so the hardware already bounds what the peer
  can reach.

Thanks,
Raghavendra
