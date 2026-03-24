Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA0BF54ADC
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:57:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE7F9406BA;
	Tue, 24 Mar 2026 17:57:35 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40]) by mails.dpdk.org (Postfix) with ESMTP id 137A64021F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:57:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEUkkQx3N8idHWpsGnWYM1GVH1Q0hFl8NbpaRG9X+Fpv7Sh921TSSrLFSRYql/SwSyU5t7JkLz4RDQVGvRdMpWXBqTd7WjpuyyM9a2kXpj0FGtwud+HfPsexH3sZkWtF0uviVVUUMdZaAmMAQgX/03zjbJnq9OrB/m8xUDeFtv2RpkD3nndWJx8KbIzlug8ligXhkqRwKVzYm9DBh0R2txDnxboFNsHwzbqo3VLB6rPp6G9jNTiG382rQdrrLP1AxOPwsGDaFmymAZ7SPxBRckCMpgxYKCdSxs4fWT5Ao8Q5g2y1pdJiPVvsnxbFW2IcTra9sIeJJjGcWP+T3TJeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm/iVszHKx8p63V1Sj5ZUoSIHhIB0cXd/1Gf1kvPYCw=;
 b=Q2SpT3qBULlVOyBYWz54affcvi2TEUwCYYsRN2Fz5faOByPyh/qsEay5biI/DjGr6ThqxKToCHFRXaDt4/6gsMMSUdvRH3EoACE3KsmJ7kt50HEsFyvyFXgP3R+rAAeKN7VvYIF221OvMUazIuWS8g60Vidk+M0I/WhzsdNy7+TJIcJ70FyvvxkMdGbh3S83wV1ZHhfEZAobUlLH6YDKqMQZGz1qgBHpy4HL+O9ukmwyyK2f3HNS8ocnZHyf9FELqY2X5PX563Y0pOwo0NhZr+DQAJZmnE9gYigmhwJcDZyYvDkvakiCPg58TdBrtGjYkdZwjd+C6p92Mg3UtYhXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm/iVszHKx8p63V1Sj5ZUoSIHhIB0cXd/1Gf1kvPYCw=;
 b=RpvBrSG3cgqJlngd7ARrhs7UxBiJ81xAMHe0mJh8nwMV4je0RCY17Fo+1i4mv9+fl5uFg7tPe8iY3+qU+C4iHcqjBj/HOs7dmtRyDP3mlMVKCwwX22LzGs5YMaPQtJsOHItY/OD09M7nt13w5gXI+GWK/Ip6YoRBxExVZE/x0rOsqoEb/BCty32nMiAldRB72IbxOvlw844jb9PDHcr/YWy32paJPoKPrYibraGtvtiT0OpDhl8+rCQWCfIWB8eS4BStCnbl/GNqZoRkOp7VX2qIyuNjBqAFeFzOVwUhr9sDsWkE93LHGH6NYHpXgbFAneLg+1eS64Ku7D4LqVLDQA==
Received: from DM6PR10CA0019.namprd10.prod.outlook.com (2603:10b6:5:60::32) by
 IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 16:57:29 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::96) by DM6PR10CA0019.outlook.office365.com
 (2603:10b6:5:60::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 16:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 16:57:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:57:10 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:57:08 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH v2 0/2] app/testpmd: assign share group dynamically
Date: Tue, 24 Mar 2026 17:56:55 +0100
Message-ID: <20260324165657.23945-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324123709.3471-1-dsosnowski@nvidia.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 2480f7ee-d67f-4a75-678d-08de89c66f07
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info: gElFPP8Jr/9q3Fzc2XmqfA5Fkfxoe+Op76d1TSRQVr0mU+0+2ihU4CPfb5bF76/iKgCalA6ICZeKFBtN5H48ejEDTI6Zc2GN/cId7Il9Yq0BGbTJzlQUFCWJoOnb8jWcP7PdIDbVNjzVpg/XI4vvlqALG8CscurJFRY/h/XOEVYCytH12HdzbEtnix7CMmb8/JcqnJSiX8MPT3JsX9+bACd8I1GSvkWw8c8C5bCky37iSQBxxbuvbp3pJEQb9rtjLI+RIRf6+IlSqa4UUfpV+F2j0eqklG2AB/YXpCvupwvwYL+faURGkbTCG+wHCS/hc4PUsdmOZYlShrpccnHt1NSJOQ+T+EenUtB+279yJxV/VYUk3jj5uLm1KdhJGFqhn2KS95m6moGUEudog/FtspJ5rggZvrCFbgLp1zt0ftTMr5zMxb8datxMxEgE0ijlyq0trFvehXxe1X2ZOWzMNsQ77ylO/sSlh4hE9iyw5O2Oc+K7MhIFJu8QF4SSMtt3nRFokvne7Y8SAQx0JoZzMFNFtZtehdhrprK9nYfcsbkZbrtVYe69OuQtgGDYoHnVYfmoBP/WYEl7rnmNP2ZXYixWwVr1o6wr38MB2lj6Gv0xUoar1/asJUtVcgLFR8mxQANwSdI2Xo1djzxYnCV5uRQr1WEQzzkxzn2IPxa7yLFWtyGiz90IB+dCgStsOkyJpLr6ftWDeiUyZRE35xLfzWllwzn+DpHOJei1k37DohNdXn20njnZIwm+E7wNiuculutnCDN9AzGlBRoG4L57og==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dD2YpCZbzWcDv+a2iZPm97F56LwixZdrJCsvIk3naF+3H9Um+X0NAB5w5QNbGbjwFiGXf0UkCsVg0+hoD2UsLndqENkZbSnmA1Ek6b/6O/rpbYzbs6ecMS5rA2U4NRnGuVzSTEP32xJ2dWxs5ojSPdSmW0vsY6//24ADqECaCm82Nba/XTXEz7WXtgKyQpTu4CzNEuq2Anu3RyoPL5luGitQZ5LFcxw0hIeu2MLPXUsyXWKjUQQ/Hd+p0OZo19ZnuMArFHSgQ+1dg/5sNvLws2DY1mG9w4OIETUz3fIQVFjy2JkkoXVvlyq7uCBSdkgEjGRUqDsWWdx2/BBfrgmZ6POR3NrTyBZyubxGBCJ3ms8jt8Y8pVpapybHKWljt3OugJAMPAhCV4xx9pmtLbrmCCbdXqZhC69U4NV52U5mdLaBkjoJ+LYygF7vJnk7zCNS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:57:29.1101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2480f7ee-d67f-4a75-678d-08de89c66f07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
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

Our internal regression tests have flagged issues with shared Rx queues.
Specifically, issues with domain mismatches:

	Invalid shared rxq config: switch domain mismatch ports 0 and 3

These started appearing after commit [1] which added checks
for globally unique share group indexes.
This could be worked around with --rxq-share=N option,
but it does not allow proper testing of all use cases [2].

This patchset addresses that by changing behavior of --rxq-share parameter.
Instead of relying on user to select proper parameter value,
testpmd will dynamically assign globally unique share group index
to each unique switch and Rx domain.

[1]: 8ebba91086f4 ("app/testpmd: fail on shared Rx queue switch mismatch")
[2]: https://inbox.dpdk.org/dev/yotjxacqrodttraqrr3r6ftut4cty66g6cjnr5ughswtatapgh@gqqkftskp3qq/

v2:
- Add releasing share groups when ports are closed.
- Add static to share_group_slots array definition.
- Remove double empty line in revert commit.

Dariusz Sosnowski (2):
  app/testpmd: assign share group dynamically
  app/testpmd: revert switch domain mismatch check

 app/test-pmd/parameters.c             |  12 +--
 app/test-pmd/testpmd.c                | 122 +++++++++++++++++---------
 app/test-pmd/testpmd.h                |   2 +-
 doc/guides/testpmd_app_ug/run_app.rst |  10 +--
 4 files changed, 87 insertions(+), 59 deletions(-)

--
2.47.3

