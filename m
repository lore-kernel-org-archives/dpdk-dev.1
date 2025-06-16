Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9017C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4185E40615;
	Mon, 16 Jun 2025 09:30:07 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by mails.dpdk.org (Postfix) with ESMTP id A979340615
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:30:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0AotoCJCc2EvG1Zr3gUE631T6eRwjvxY1NMOwqU39X3T/79KWHjZMJW6UE3epOADS1gSQx3qhx3cvxLt6ifGCSlqSApnBfXWHcIRyzssuIKw/MjUsyABATrovwKWS9asFvFJ8V2JHFCPYNwx5c1SHlXCyPQ+omRhBJY6ySrC4ZAoL6XVf2N1Zw7EaW5OB22hA7P0L6qefvDgs0MIcpPVWvvxXVUxJ2ChzrtkFCkxrjnVXswB94Dvf0nU5FeAVxORCiXiJCrJQ3yzbY4BvvXUjcr35TsPmCNCHeXAFDeshvT/Kv8eyLvlsN57BJyv8CvhNnUYgXjOvc204WKkbp6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FF9FdEgx9fFOjLAJzFr3Yjf/mlP1goU/h2afqgZ4L0=;
 b=qZfwXn+hLCw4VuCY7+egysBdybHJl11jSOikzNuVcsoGSoq0jbVCRKSv0JP+lVmRehqJnYs09P2xNkC94obbvcN1xPsdzOo80Dz9dnp68RqAaUOHrJd8F5gZih479Gbgmgd0WtfKMH+Y8STYkvqXO9c2om1UXO0XIl6KliFZZeFFN6c6q+HT6e3XJHH2jaPeal2+mjpLtJZggMdzX0XqH1rSuS0oKjzQXORanK48RxIOKruQpfJIjB0K5rG+dgr5tWDqUP5j4+4X2tcBGA4GsXtsvq8GcRryJrUjb2qRILNfi94mlVOJEeSW23dthsUZAKLOZ346cL5wP/LL3Fp+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FF9FdEgx9fFOjLAJzFr3Yjf/mlP1goU/h2afqgZ4L0=;
 b=i97jT0kRIdCwN9lR7H1bFi+8ww2C+uKIPF3HUertTHcgzDFeImn/yBYThK+OaKKwUpgjM5aZ4Q9EjNmzd/9KsMrZu4/4IkyML2PkpAifE8ZN8pmeP1Eva4JBN1XOWHDhHUDdKTM74kCSsr5AynvT91ojg9lMxQpc/RnT3+vftw58Hlu7lscdOAcwRWTFxwbPvWH+yUUz6aS7Oy/Q3j2K0/mfe4nf6020qIwAoTAfXdVR7N8V+setTUoDBPBi1iovsbLSr8VF24E7uh/uHi/ejFCKkaeSXD/zQaGE6LPP4JyNTkWdpeLORikyavrK+lzmITyUCvaGlbriy6OgMwRLbg==
Received: from BN9PR03CA0876.namprd03.prod.outlook.com (2603:10b6:408:13c::11)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 07:29:57 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::14) by BN9PR03CA0876.outlook.office365.com
 (2603:10b6:408:13c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 07:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 07:29:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 00:29:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 00:29:40 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 00:29:21 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Bruce Richardson
 <bruce.richardson@intel.com>, "John W. Linville" <linville@tuxdriver.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Shepard Siegel <shepard.siegel@atomicrules.com>, Ed Czeck
 <ed.czeck@atomicrules.com>, John Miller <john.miller@atomicrules.com>, "Igor
 Russkikh" <irusskikh@marvell.com>, Steven Webster
 <steven.webster@windriver.com>, Matt Peters <matt.peters@windriver.com>,
 Selwin Sebastian <selwin.sebastian@amd.com>, Julien Aube
 <julien_dpdk@jaube.fr>, Ajit Khaparde <ajit.khaparde@broadcom.com>, "Somnath
 Kotur" <somnath.kotur@broadcom.com>, Chas Williams <chas3@att.com>, "Min Hu
 (Connor)" <humin29@huawei.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Hemant
 Agrawal" <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 "Shai Brandes" <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>, 
 "Ron Beider" <rbeider@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 "Wajeeh Atrash" <atrwajee@amazon.com>, Gagandeep Singh <g.singh@nxp.com>,
 "Apeksha Gupta" <apeksha.gupta@nxp.com>, John Daley <johndale@cisco.com>,
 "Hyong Youb Kim" <hyonkim@cisco.com>, Gaetan Rivet <grive@u256.net>, Jeroen
 de Borst <jeroendb@google.com>, Joshua Washington <joshwash@google.com>,
 Ziyang Xuan <xuanziyang2@huawei.com>, Xiaoyun Wang
 <cloud.wangxiaoyun@huawei.com>, Dengdui Huang <huangdengdui@huawei.com>,
 Praveen Shetty <praveen.shetty@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Andrew Boyer <andrew.boyer@amd.com>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Jakub Grajciar
 <jgrajcia@cisco.com>, Matan Azrad <matan@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Zyta Szpak <zr@semihalf.com>, Liron Himi
 <lironh@marvell.com>, Martin Spinler <spinler@cesnet.cz>, Chaoyong He
 <chaoyong.he@corigine.com>, Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang
 <zaiyuwang@trustnetic.com>, Christian Koue Muf <ckm@napatech.com>, "Serhii
 Iliushyk" <sil-plv@napatech.com>, Tetsuya Mukawa <mtetsuyah@gmail.com>,
 "Vamsi Attunuru" <vattunuru@marvell.com>, Devendra Singh Rawat
 <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>, Howard Wang
 <howard_wang@realsil.com.cn>, Chunhao Lin <hau@realtek.com>, Xing Wang
 <xing_wang@realsil.com.cn>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj
 <mczekaj@marvell.com>, Jian Wang <jianwang@trustnetic.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, Jochen Behrens
 <jochen.behrens@broadcom.com>, Renyong Wan <wanry@yunsilicon.com>, Na Na
 <nana@yunsilicon.com>, Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang
 <zhangxx@yunsilicon.com>, Dongwei Xu <xudw@yunsilicon.com>, Junlong Wang
 <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [RFC PATCH 2/5] drivers: add mempool history compilation flag
Date: Mon, 16 Jun 2025 10:29:07 +0300
Message-ID: <20250616072910.113042-3-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616072910.113042-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e71d621-e133-433a-eb72-08ddaca79876
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qz7fx/kZbbIbBCjDk/WKL3YkFXQAZP7k/ol/D8H+EPHn9Pd77OLQsRjlhBFZ?=
 =?us-ascii?Q?6okEhZXDN9xUoLaLe+yt0zna89LN3ZzNwCj7D1nTgpqL3jkSBdGwby4dOsZt?=
 =?us-ascii?Q?yPhJINgZBLhCrQUiyvzkdZW0E+kBhwuo/GRmnwcbYyyfCgLnVwXNOZGZz5DV?=
 =?us-ascii?Q?vP/AhSxAbt3Kh9Fv3xqpZuyV8LKwsOOn8h3knzg5HpyfzE/xFomg5FaC9F04?=
 =?us-ascii?Q?xSzrOYaBuyld76l9Q/HPhcNoNiLaXgXOeuvq2H0vWB/TScVDI/6PYkMDmYLJ?=
 =?us-ascii?Q?GUnWRrHAU298NgFTzeCsl+OGbAYM8GYvR7HuVYrXDPRqKlz9+U+exW0/iZMB?=
 =?us-ascii?Q?dHDvkNxbpfnXvYu8RTStdudbH9I/Quu0q6sEcJBASrBU9mjDx0oU+uGGbd2c?=
 =?us-ascii?Q?xk9mbbnSRwb+Biq78P2BJLBarj1sX6VwlTv/QLRt1RD+nJaVZHu0x+Uh9iuE?=
 =?us-ascii?Q?K3TIjRpFwKw9MWDZ6TCC+ZRwQWgITROSMnUdmgwtKMpe/1/aZDrYA6URvHzN?=
 =?us-ascii?Q?pXPkpxHWAlmosgxe6LefY1/ohvcnyw1xceRUzk+Tz8zeeFHfx8lOV0MLLYhX?=
 =?us-ascii?Q?hauuUW/iDiNqgwCtYGPfaeHT2q3RVq/R5JgTFtklPBoZG9Xybwt7QuQIdou3?=
 =?us-ascii?Q?+tDtbWJ9KoEetmIpO0QrWFowd1WGHxEXcnS50eGTKEbthUC/ErLFD18GCu7y?=
 =?us-ascii?Q?q8+ZlNLhyAck4pkdhDJK3bQEboFeqDh907k5DOwBCh08bbr2xtsXQeCsxjoV?=
 =?us-ascii?Q?QdqN8+qbtQzZFFPaeu9oSwYjJgVtjZvIqY+4vvbbduZ5g16zSDQtxH8iMLCT?=
 =?us-ascii?Q?Zp6ohEa+1zLf870UsL0c3FPS5tyjnoQucuMCxtN8MOL464dFFWAq/I06FO8t?=
 =?us-ascii?Q?7efwMk9MRyIwtsxw3CRqWoOZRniS9EdIZqeFJjxs7wY2GWfvVP15dYgWjCdb?=
 =?us-ascii?Q?5+IpmCppV3v9tA3YBwXvudj6UZzOwMn5akzE6fKUShLTHjBD8fFd2ii+4zPS?=
 =?us-ascii?Q?mOmJsllDD2lMRnWQoOV1tM05Yr8M57OxG52UexC2BrRJ/2EB3inDS3RAfYmd?=
 =?us-ascii?Q?Cor3/A2zz+RdPqOSi6kGLVBKfilXxsN8P5UTZtgGTqSaJcgcJcyKBXzO6GNX?=
 =?us-ascii?Q?HiaoDOrhLmWjG7QN5OkHGcb/qoafQEdUs9Ds5zeYLo1/q56QffExMCZWbJm5?=
 =?us-ascii?Q?+mlmIL8XqzOkaDt3JaM94KQwnlwrg4TBoF5y4wz8Eae67gQs47XSaP+g8lzt?=
 =?us-ascii?Q?6Jc2y3ckMs//nzMa+wvkLAyrCrCEPWns+vul18n5rKKfEuatXzEm6bgFsvHy?=
 =?us-ascii?Q?mPM6ae0pz9HIZbI5x43J8haKNL3lpIB/KJfsRxr7qxRcq+kg8sfh7qsOoxUL?=
 =?us-ascii?Q?lH/8Z6WTkKyTjRMtOxu03neV9uaIWic7mS/7t1vr+nSHLVBLLXo6cvyKqrWn?=
 =?us-ascii?Q?AjlqR7Oa0k6+jq3JLn7aQobJbo14iH6WyBMibQm/wu5BcGwkVjRXYfBB2kWp?=
 =?us-ascii?Q?vpuO4UG6rv9v/Q+0oTEzBZo6DSrIbKZU9gq8?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:29:57.2273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e71d621-e133-433a-eb72-08ddaca79876
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514
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

This commit adds a new compilation flag to enable
mempool history recording in DPDK drivers.

- Add support check for mempool history feature in each driver's meson
- Skip building drivers that don't support mempool history when enabled

Drivers must explicitly support this feature in their meson file
to be built when RTE_MEMPOOL_DEBUG_OBJECTS_HISTORY is enabled.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 config/meson.build                  | 1 +
 drivers/meson.build                 | 7 +++++++
 drivers/net/af_packet/meson.build   | 1 +
 drivers/net/af_xdp/meson.build      | 1 +
 drivers/net/ark/meson.build         | 2 ++
 drivers/net/atlantic/meson.build    | 2 ++
 drivers/net/avp/meson.build         | 2 ++
 drivers/net/axgbe/meson.build       | 2 ++
 drivers/net/bnx2x/meson.build       | 1 +
 drivers/net/bnxt/meson.build        | 2 ++
 drivers/net/bonding/meson.build     | 1 +
 drivers/net/cnxk/meson.build        | 1 +
 drivers/net/cxgbe/meson.build       | 2 ++
 drivers/net/dpaa/meson.build        | 2 ++
 drivers/net/dpaa2/meson.build       | 2 ++
 drivers/net/ena/meson.build         | 2 ++
 drivers/net/enetc/meson.build       | 2 ++
 drivers/net/enetfec/meson.build     | 2 ++
 drivers/net/enic/meson.build        | 2 ++
 drivers/net/failsafe/meson.build    | 1 +
 drivers/net/gve/meson.build         | 2 ++
 drivers/net/hinic/meson.build       | 2 ++
 drivers/net/hns3/meson.build        | 1 +
 drivers/net/intel/cpfl/meson.build  | 2 ++
 drivers/net/intel/e1000/meson.build | 2 ++
 drivers/net/intel/fm10k/meson.build | 2 ++
 drivers/net/intel/i40e/meson.build  | 2 ++
 drivers/net/intel/iavf/meson.build  | 2 ++
 drivers/net/intel/ice/meson.build   | 1 +
 drivers/net/intel/idpf/meson.build  | 2 ++
 drivers/net/intel/ixgbe/meson.build | 2 ++
 drivers/net/ionic/meson.build       | 2 ++
 drivers/net/mana/meson.build        | 2 ++
 drivers/net/memif/meson.build       | 1 +
 drivers/net/mlx4/meson.build        | 2 ++
 drivers/net/mlx5/meson.build        | 1 +
 drivers/net/mvneta/meson.build      | 2 ++
 drivers/net/mvpp2/meson.build       | 2 ++
 drivers/net/netvsc/meson.build      | 2 ++
 drivers/net/nfb/meson.build         | 2 ++
 drivers/net/nfp/meson.build         | 2 ++
 drivers/net/ngbe/meson.build        | 2 ++
 drivers/net/ntnic/meson.build       | 4 ++++
 drivers/net/null/meson.build        | 1 +
 drivers/net/octeon_ep/meson.build   | 2 ++
 drivers/net/octeontx/meson.build    | 2 ++
 drivers/net/pcap/meson.build        | 1 +
 drivers/net/pfe/meson.build         | 2 ++
 drivers/net/qede/meson.build        | 2 ++
 drivers/net/r8169/meson.build       | 4 +++-
 drivers/net/ring/meson.build        | 1 +
 drivers/net/sfc/meson.build         | 2 ++
 drivers/net/softnic/meson.build     | 2 ++
 drivers/net/tap/meson.build         | 1 +
 drivers/net/thunderx/meson.build    | 2 ++
 drivers/net/txgbe/meson.build       | 2 ++
 drivers/net/vdev_netvsc/meson.build | 2 ++
 drivers/net/vhost/meson.build       | 2 ++
 drivers/net/virtio/meson.build      | 2 ++
 drivers/net/vmxnet3/meson.build     | 2 ++
 drivers/net/xsc/meson.build         | 2 ++
 drivers/net/zxdh/meson.build        | 4 ++++
 meson_options.txt                   | 2 ++
 63 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/config/meson.build b/config/meson.build
index f31fef216c..78d3574eb2 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -379,6 +379,7 @@ if get_option('mbuf_refcnt_atomic')
     dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)
 endif
 dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))
+dpdk_conf.set10('RTE_MEMPOOL_DEBUG_OBJECTS_HISTORY', get_option('enable_mempool_history'))
 
 compile_time_cpuflags = []
 subdir(arch_subdir)
diff --git a/drivers/meson.build b/drivers/meson.build
index 7b7205dfac..253180bccd 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -143,6 +143,7 @@ foreach subpath:subdirs
         pkgconfig_extra_libs = []
         testpmd_sources = []
         require_iova_in_mbuf = true
+        support_mempool_history = true
         # for handling base code files which may need extra cflags
         base_sources = []
         base_cflags = []
@@ -174,6 +175,12 @@ foreach subpath:subdirs
                 build = false
                 reason = 'requires IOVA in mbuf (set enable_iova_as_pa option)'
             endif
+
+            if dpdk_conf.get('RTE_MEMPOOL_DEBUG_OBJECTS_HISTORY') == 1 and not support_mempool_history
+                build = false
+                reason = 'driver does not support mempool history tracing'
+            endif
+
             # error out if we can't build a driver and that driver was explicitly requested,
             # i.e. not via wildcard.
             if not build and require_drivers and get_option('enable_drivers').contains(drv_path)
diff --git a/drivers/net/af_packet/meson.build b/drivers/net/af_packet/meson.build
index f45e4491d4..476d10e132 100644
--- a/drivers/net/af_packet/meson.build
+++ b/drivers/net/af_packet/meson.build
@@ -7,3 +7,4 @@ if not is_linux
 endif
 sources = files('rte_eth_af_packet.c')
 require_iova_in_mbuf = false
+support_mempool_history = false
diff --git a/drivers/net/af_xdp/meson.build b/drivers/net/af_xdp/meson.build
index 2d37bcc869..09228d8e54 100644
--- a/drivers/net/af_xdp/meson.build
+++ b/drivers/net/af_xdp/meson.build
@@ -92,3 +92,4 @@ if build
 endif
 
 require_iova_in_mbuf = false
+support_mempool_history = false
diff --git a/drivers/net/ark/meson.build b/drivers/net/ark/meson.build
index 12b3935b85..c3126f570f 100644
--- a/drivers/net/ark/meson.build
+++ b/drivers/net/ark/meson.build
@@ -18,3 +18,5 @@ sources = files(
         'ark_pktgen.c',
         'ark_udm.c',
 )
+
+support_mempool_history = false
diff --git a/drivers/net/atlantic/meson.build b/drivers/net/atlantic/meson.build
index bf5e47eaaf..09085f853c 100644
--- a/drivers/net/atlantic/meson.build
+++ b/drivers/net/atlantic/meson.build
@@ -17,3 +17,5 @@ sources = files(
         'hw_atl/hw_atl_utils.c',
         'rte_pmd_atlantic.c',
 )
+
+support_mempool_history = false
diff --git a/drivers/net/avp/meson.build b/drivers/net/avp/meson.build
index ea9dd1f20e..ee46fca105 100644
--- a/drivers/net/avp/meson.build
+++ b/drivers/net/avp/meson.build
@@ -7,3 +7,5 @@ if not is_linux
 endif
 sources = files('avp_ethdev.c')
 headers = files('rte_avp_common.h', 'rte_avp_fifo.h')
+
+support_mempool_history = false
diff --git a/drivers/net/axgbe/meson.build b/drivers/net/axgbe/meson.build
index b1cbe3d810..426b470673 100644
--- a/drivers/net/axgbe/meson.build
+++ b/drivers/net/axgbe/meson.build
@@ -20,3 +20,5 @@ cflags += '-Wno-cast-qual'
 if arch_subdir == 'x86'
     sources += files('axgbe_rxtx_vec_sse.c')
 endif
+
+support_mempool_history = false
diff --git a/drivers/net/bnx2x/meson.build b/drivers/net/bnx2x/meson.build
index bc66ab8032..12a2f1a5e4 100644
--- a/drivers/net/bnx2x/meson.build
+++ b/drivers/net/bnx2x/meson.build
@@ -23,3 +23,4 @@ sources = files(
 )
 
 annotate_locks = false
+support_mempool_history = false
diff --git a/drivers/net/bnxt/meson.build b/drivers/net/bnxt/meson.build
index 79300eb6ac..4ef555a78c 100644
--- a/drivers/net/bnxt/meson.build
+++ b/drivers/net/bnxt/meson.build
@@ -64,3 +64,5 @@ elif arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
 endif
 
 annotate_locks = false
+support_mempool_history = false
+
diff --git a/drivers/net/bonding/meson.build b/drivers/net/bonding/meson.build
index d87e7a2522..d13ab392c6 100644
--- a/drivers/net/bonding/meson.build
+++ b/drivers/net/bonding/meson.build
@@ -24,5 +24,6 @@ deps += ['ip_frag']
 headers = files('rte_eth_bond.h', 'rte_eth_bond_8023ad.h')
 
 require_iova_in_mbuf = false
+support_mempool_history = false
 
 cflags += no_wvla_cflag
diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build
index d20a8601eb..ad5faa57f2 100644
--- a/drivers/net/cnxk/meson.build
+++ b/drivers/net/cnxk/meson.build
@@ -343,5 +343,6 @@ endforeach
 headers = files('rte_pmd_cnxk.h')
 
 require_iova_in_mbuf = false
+support_mempool_history = false
 
 annotate_locks = false
diff --git a/drivers/net/cxgbe/meson.build b/drivers/net/cxgbe/meson.build
index 95cb58ab44..a3dc7ff906 100644
--- a/drivers/net/cxgbe/meson.build
+++ b/drivers/net/cxgbe/meson.build
@@ -25,3 +25,5 @@ sources = files(
 includes += include_directories('base')
 
 cflags += no_wvla_cflag
+
+support_mempool_history = false
diff --git a/drivers/net/dpaa/meson.build b/drivers/net/dpaa/meson.build
index b1e4bbafb5..6d33f1a2b8 100644
--- a/drivers/net/dpaa/meson.build
+++ b/drivers/net/dpaa/meson.build
@@ -24,3 +24,5 @@ if cc.has_argument('-Wno-pointer-arith')
 endif
 
 headers = files('rte_pmd_dpaa.h')
+
+support_mempool_history = false
diff --git a/drivers/net/dpaa2/meson.build b/drivers/net/dpaa2/meson.build
index 89932b3037..e44e01ab95 100644
--- a/drivers/net/dpaa2/meson.build
+++ b/drivers/net/dpaa2/meson.build
@@ -29,3 +29,5 @@ includes += include_directories('base', 'mc')
 headers = files('rte_pmd_dpaa2.h')
 
 cflags += no_wvla_cflag
+
+support_mempool_history = false
diff --git a/drivers/net/ena/meson.build b/drivers/net/ena/meson.build
index d02ed3f64f..620bdeeb82 100644
--- a/drivers/net/ena/meson.build
+++ b/drivers/net/ena/meson.build
@@ -17,3 +17,5 @@ sources = files(
 deps += ['timer']
 
 includes += include_directories('base', 'base/ena_defs')
+
+support_mempool_history = false
diff --git a/drivers/net/enetc/meson.build b/drivers/net/enetc/meson.build
index 966dc694fc..36e3740042 100644
--- a/drivers/net/enetc/meson.build
+++ b/drivers/net/enetc/meson.build
@@ -13,3 +13,5 @@ sources = files(
 )
 
 includes += include_directories('base')
+
+support_mempool_history = false
diff --git a/drivers/net/enetfec/meson.build b/drivers/net/enetfec/meson.build
index 29a464424b..c213da7640 100644
--- a/drivers/net/enetfec/meson.build
+++ b/drivers/net/enetfec/meson.build
@@ -11,3 +11,5 @@ sources = files(
         'enet_uio.c',
         'enet_rxtx.c',
 )
+
+support_mempool_history = false
diff --git a/drivers/net/enic/meson.build b/drivers/net/enic/meson.build
index a48a497e46..1c160fdc62 100644
--- a/drivers/net/enic/meson.build
+++ b/drivers/net/enic/meson.build
@@ -35,3 +35,5 @@ if dpdk_conf.has('RTE_ARCH_X86_64')
 endif
 
 annotate_locks = false
+support_mempool_history = false
+
diff --git a/drivers/net/failsafe/meson.build b/drivers/net/failsafe/meson.build
index 90c965b705..889eb383bd 100644
--- a/drivers/net/failsafe/meson.build
+++ b/drivers/net/failsafe/meson.build
@@ -29,6 +29,7 @@ sources = files(
 )
 
 require_iova_in_mbuf = false
+support_mempool_history = false
 
 if is_freebsd
     annotate_locks = false
diff --git a/drivers/net/gve/meson.build b/drivers/net/gve/meson.build
index ed5ef0a1fc..c7155cc15d 100644
--- a/drivers/net/gve/meson.build
+++ b/drivers/net/gve/meson.build
@@ -20,3 +20,5 @@ sources = files(
 includes += include_directories('base')
 
 cflags += no_wvla_cflag
+
+support_mempool_history = false
diff --git a/drivers/net/hinic/meson.build b/drivers/net/hinic/meson.build
index 36cc9431a6..0cd5fe6f72 100644
--- a/drivers/net/hinic/meson.build
+++ b/drivers/net/hinic/meson.build
@@ -21,3 +21,5 @@ includes += include_directories('base')
 if is_freebsd
     annotate_locks = false
 endif
+
+support_mempool_history = false
diff --git a/drivers/net/hns3/meson.build b/drivers/net/hns3/meson.build
index 53a9dd6f39..ca9bbec971 100644
--- a/drivers/net/hns3/meson.build
+++ b/drivers/net/hns3/meson.build
@@ -34,6 +34,7 @@ sources = files(
 )
 
 require_iova_in_mbuf = false
+support_mempool_history = false
 
 annotate_locks = false
 
diff --git a/drivers/net/intel/cpfl/meson.build b/drivers/net/intel/cpfl/meson.build
index 1f0269d50b..a821e5e999 100644
--- a/drivers/net/intel/cpfl/meson.build
+++ b/drivers/net/intel/cpfl/meson.build
@@ -35,3 +35,5 @@ if dpdk_conf.has('RTE_HAS_JANSSON')
     )
     ext_deps += jansson_dep
 endif
+
+support_mempool_history = false
diff --git a/drivers/net/intel/e1000/meson.build b/drivers/net/intel/e1000/meson.build
index 924fe4ecae..a80de1964f 100644
--- a/drivers/net/intel/e1000/meson.build
+++ b/drivers/net/intel/e1000/meson.build
@@ -23,3 +23,5 @@ if not is_windows
                 'igc_txrx.c',
         )
 endif
+
+support_mempool_history = false
diff --git a/drivers/net/intel/fm10k/meson.build b/drivers/net/intel/fm10k/meson.build
index fac4750f8d..a7e68959e8 100644
--- a/drivers/net/intel/fm10k/meson.build
+++ b/drivers/net/intel/fm10k/meson.build
@@ -16,3 +16,5 @@ sources += files(
 if arch_subdir == 'x86'
     sources += files('fm10k_rxtx_vec.c')
 endif
+
+support_mempool_history = false
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index 49e7f899e6..c4840f9bef 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -47,3 +47,5 @@ elif arch_subdir == 'arm'
 endif
 
 headers = files('rte_pmd_i40e.h')
+
+support_mempool_history = false
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index 0db94d6fe6..1c94518b5f 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -35,3 +35,5 @@ elif arch_subdir == 'arm'
 endif
 
 headers = files('rte_pmd_iavf.h')
+
+support_mempool_history = false
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index 8a20d0f297..d2e570d79c 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -45,3 +45,4 @@ sources += files(
 )
 
 require_iova_in_mbuf = false
+support_mempool_history = false
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index a805d02ea2..e61df7a5f0 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -24,3 +24,5 @@ if arch_subdir == 'x86' and dpdk_conf.get('RTE_IOVA_IN_MBUF') == 1
     sources_avx2 += files('idpf_common_rxtx_avx2.c')
     sources_avx512 += files('idpf_common_rxtx_avx512.c')
 endif
+
+support_mempool_history = false
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index d1122bb9cd..d525ef3871 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -32,3 +32,5 @@ elif arch_subdir == 'arm'
 endif
 
 headers = files('rte_pmd_ixgbe.h')
+
+support_mempool_history = false
diff --git a/drivers/net/ionic/meson.build b/drivers/net/ionic/meson.build
index cc6d5ce4db..ed96a3074b 100644
--- a/drivers/net/ionic/meson.build
+++ b/drivers/net/ionic/meson.build
@@ -24,3 +24,5 @@ sources = files(
 )
 
 includes += include_directories('../../common/ionic')
+
+support_mempool_history = false
diff --git a/drivers/net/mana/meson.build b/drivers/net/mana/meson.build
index e320da7fc4..01655c2cd7 100644
--- a/drivers/net/mana/meson.build
+++ b/drivers/net/mana/meson.build
@@ -53,3 +53,5 @@ foreach arg:required_symbols
         subdir_done()
     endif
 endforeach
+
+support_mempool_history = false
diff --git a/drivers/net/memif/meson.build b/drivers/net/memif/meson.build
index 8b2aab1f39..07d106a3f9 100644
--- a/drivers/net/memif/meson.build
+++ b/drivers/net/memif/meson.build
@@ -14,3 +14,4 @@ sources = files(
 deps += ['hash']
 
 require_iova_in_mbuf = false
+support_mempool_history = false
diff --git a/drivers/net/mlx4/meson.build b/drivers/net/mlx4/meson.build
index 869d2895c8..7bd54ff6aa 100644
--- a/drivers/net/mlx4/meson.build
+++ b/drivers/net/mlx4/meson.build
@@ -136,3 +136,5 @@ if dlopen_ibverbs
         install_dir: dlopen_install_dir,
     )
 endif
+
+support_mempool_history = false
diff --git a/drivers/net/mlx5/meson.build b/drivers/net/mlx5/meson.build
index 6a91692759..a259de5b87 100644
--- a/drivers/net/mlx5/meson.build
+++ b/drivers/net/mlx5/meson.build
@@ -90,6 +90,7 @@ else
 endif
 
 require_iova_in_mbuf = false
+support_mempool_history = true
 
 testpmd_sources += files('mlx5_testpmd.c')
 
diff --git a/drivers/net/mvneta/meson.build b/drivers/net/mvneta/meson.build
index 2b0a94ddd0..41f68d0d60 100644
--- a/drivers/net/mvneta/meson.build
+++ b/drivers/net/mvneta/meson.build
@@ -26,3 +26,5 @@ sources = files(
 deps += ['cfgfile', 'common_mvep']
 
 cflags += no_wvla_cflag
+
+support_mempool_history = false
diff --git a/drivers/net/mvpp2/meson.build b/drivers/net/mvpp2/meson.build
index 396e382128..8853fbe809 100644
--- a/drivers/net/mvpp2/meson.build
+++ b/drivers/net/mvpp2/meson.build
@@ -29,3 +29,5 @@ sources = files(
 cflags += no_wvla_cflag
 
 deps += ['cfgfile', 'common_mvep']
+
+support_mempool_history = false
diff --git a/drivers/net/netvsc/meson.build b/drivers/net/netvsc/meson.build
index ca94d97989..463f05aeeb 100644
--- a/drivers/net/netvsc/meson.build
+++ b/drivers/net/netvsc/meson.build
@@ -17,3 +17,5 @@ sources = files(
 )
 
 cflags += no_wvla_cflag
+
+support_mempool_history = false
diff --git a/drivers/net/nfb/meson.build b/drivers/net/nfb/meson.build
index d7a255c928..e5f1f1f03c 100644
--- a/drivers/net/nfb/meson.build
+++ b/drivers/net/nfb/meson.build
@@ -23,3 +23,5 @@ sources = files(
 )
 
 cflags += no_wvla_cflag
+
+support_mempool_history = false
diff --git a/drivers/net/nfp/meson.build b/drivers/net/nfp/meson.build
index 4c34a73b70..a5d07ec813 100644
--- a/drivers/net/nfp/meson.build
+++ b/drivers/net/nfp/meson.build
@@ -65,3 +65,5 @@ else
 endif
 
 deps += ['hash', 'security', 'common_nfp']
+
+support_mempool_history = false
diff --git a/drivers/net/ngbe/meson.build b/drivers/net/ngbe/meson.build
index 319eb23c35..e4d90a290d 100644
--- a/drivers/net/ngbe/meson.build
+++ b/drivers/net/ngbe/meson.build
@@ -24,3 +24,5 @@ if arch_subdir == 'x86'
 elif arch_subdir == 'arm'
     sources += files('ngbe_rxtx_vec_neon.c')
 endif
+
+support_mempool_history = false
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index b4c6cfe7de..bd46794ec3 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -124,3 +124,7 @@ sources = files(
         'ntnic_vfio.c',
         'ntnic_ethdev.c',
 )
+
+cflags += no_wvla_cflag
+
+support_mempool_history = false
diff --git a/drivers/net/null/meson.build b/drivers/net/null/meson.build
index bad7dc1af7..4127a07959 100644
--- a/drivers/net/null/meson.build
+++ b/drivers/net/null/meson.build
@@ -3,3 +3,4 @@
 
 sources = files('rte_eth_null.c')
 require_iova_in_mbuf = false
+support_mempool_history = false
diff --git a/drivers/net/octeon_ep/meson.build b/drivers/net/octeon_ep/meson.build
index cbb729b689..f5ff3b8a9d 100644
--- a/drivers/net/octeon_ep/meson.build
+++ b/drivers/net/octeon_ep/meson.build
@@ -28,3 +28,5 @@ foreach flag: extra_flags
         cflags += flag
     endif
 endforeach
+
+support_mempool_history = false
diff --git a/drivers/net/octeontx/meson.build b/drivers/net/octeontx/meson.build
index fc8a5a73f2..82247a87a0 100644
--- a/drivers/net/octeontx/meson.build
+++ b/drivers/net/octeontx/meson.build
@@ -18,3 +18,5 @@ sources = files(
 deps += ['mempool_octeontx', 'eventdev']
 
 cflags += no_wvla_cflag
+
+support_mempool_history = false
diff --git a/drivers/net/pcap/meson.build b/drivers/net/pcap/meson.build
index 676c55018e..28c86267a8 100644
--- a/drivers/net/pcap/meson.build
+++ b/drivers/net/pcap/meson.build
@@ -17,3 +17,4 @@ if is_windows
 endif
 
 require_iova_in_mbuf = false
+support_mempool_history = false
diff --git a/drivers/net/pfe/meson.build b/drivers/net/pfe/meson.build
index 684b062090..2fb4ec4408 100644
--- a/drivers/net/pfe/meson.build
+++ b/drivers/net/pfe/meson.build
@@ -19,3 +19,5 @@ if cc.has_argument('-Wno-pointer-arith')
 endif
 
 includes += include_directories('base')
+
+support_mempool_history = false
diff --git a/drivers/net/qede/meson.build b/drivers/net/qede/meson.build
index e1b21d6ff5..a58811c9fe 100644
--- a/drivers/net/qede/meson.build
+++ b/drivers/net/qede/meson.build
@@ -22,3 +22,5 @@ sources = files(
 if cc.has_argument('-Wno-format-nonliteral')
     cflags += '-Wno-format-nonliteral'
 endif
+
+support_mempool_history = false
diff --git a/drivers/net/r8169/meson.build b/drivers/net/r8169/meson.build
index d1e65377a3..56eb726c84 100644
--- a/drivers/net/r8169/meson.build
+++ b/drivers/net/r8169/meson.build
@@ -18,4 +18,6 @@ sources = files(
         'base/rtl8126a.c',
         'base/rtl8126a_mcu.c',
         'base/rtl8168kb.c',
-)
\ No newline at end of file
+)
+
+support_mempool_history = false
diff --git a/drivers/net/ring/meson.build b/drivers/net/ring/meson.build
index 9b713c9370..a37c7294f6 100644
--- a/drivers/net/ring/meson.build
+++ b/drivers/net/ring/meson.build
@@ -4,3 +4,4 @@
 sources = files('rte_eth_ring.c')
 headers = files('rte_eth_ring.h')
 require_iova_in_mbuf = false
+support_mempool_history = false
diff --git a/drivers/net/sfc/meson.build b/drivers/net/sfc/meson.build
index 90c38231e1..924771c1ea 100644
--- a/drivers/net/sfc/meson.build
+++ b/drivers/net/sfc/meson.build
@@ -108,3 +108,5 @@ sources = files(
         'sfc_repr.c',
         'sfc_nic_dma.c',
 )
+
+support_mempool_history = false
diff --git a/drivers/net/softnic/meson.build b/drivers/net/softnic/meson.build
index e8d7290062..7f018f6a60 100644
--- a/drivers/net/softnic/meson.build
+++ b/drivers/net/softnic/meson.build
@@ -17,3 +17,5 @@ sources = files(
 )
 deps += ['pipeline', 'port', 'table']
 cflags += no_wvla_cflag
+
+support_mempool_history = false
diff --git a/drivers/net/tap/meson.build b/drivers/net/tap/meson.build
index 7160e9e98d..11c25589eb 100644
--- a/drivers/net/tap/meson.build
+++ b/drivers/net/tap/meson.build
@@ -19,6 +19,7 @@ cflags += max_queues
 cflags += no_wvla_cflag
 
 require_iova_in_mbuf = false
+support_mempool_history = false
 
 if cc.has_header_symbol('linux/pkt_cls.h', 'TCA_FLOWER_ACT')
     cflags += '-DHAVE_TCA_FLOWER'
diff --git a/drivers/net/thunderx/meson.build b/drivers/net/thunderx/meson.build
index 03262af8ca..a93e6c0403 100644
--- a/drivers/net/thunderx/meson.build
+++ b/drivers/net/thunderx/meson.build
@@ -22,3 +22,5 @@ endif
 if cc.has_argument('-Wno-maybe-uninitialized')
     cflags += '-Wno-maybe-uninitialized'
 endif
+
+support_mempool_history = false
diff --git a/drivers/net/txgbe/meson.build b/drivers/net/txgbe/meson.build
index 4dbbf597bb..baa6f549a9 100644
--- a/drivers/net/txgbe/meson.build
+++ b/drivers/net/txgbe/meson.build
@@ -32,3 +32,5 @@ elif arch_subdir == 'arm'
 endif
 
 install_headers('rte_pmd_txgbe.h')
+
+support_mempool_history = false
diff --git a/drivers/net/vdev_netvsc/meson.build b/drivers/net/vdev_netvsc/meson.build
index bd35a13f3d..cbbef57633 100644
--- a/drivers/net/vdev_netvsc/meson.build
+++ b/drivers/net/vdev_netvsc/meson.build
@@ -19,3 +19,5 @@ foreach option:cflags_options
                 cflags += option
         endif
 endforeach
+
+support_mempool_history = false
diff --git a/drivers/net/vhost/meson.build b/drivers/net/vhost/meson.build
index f481a3a4b8..9462f9db05 100644
--- a/drivers/net/vhost/meson.build
+++ b/drivers/net/vhost/meson.build
@@ -10,3 +10,5 @@ endif
 deps += 'vhost'
 sources = files('rte_eth_vhost.c')
 headers = files('rte_eth_vhost.h')
+
+support_mempool_history = false
diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
index d3caa3a3b4..1aa77bb7fa 100644
--- a/drivers/net/virtio/meson.build
+++ b/drivers/net/virtio/meson.build
@@ -56,3 +56,5 @@ if is_linux
         'virtio_user/virtio_user_dev.c')
     deps += ['bus_vdev']
 endif
+
+support_mempool_history = false
diff --git a/drivers/net/vmxnet3/meson.build b/drivers/net/vmxnet3/meson.build
index ed563386d5..63881d02ce 100644
--- a/drivers/net/vmxnet3/meson.build
+++ b/drivers/net/vmxnet3/meson.build
@@ -17,3 +17,5 @@ foreach flag: error_cflags
                 cflags += flag
         endif
 endforeach
+
+support_mempool_history = false
diff --git a/drivers/net/xsc/meson.build b/drivers/net/xsc/meson.build
index fe88bbee8c..e6410e92f1 100644
--- a/drivers/net/xsc/meson.build
+++ b/drivers/net/xsc/meson.build
@@ -17,3 +17,5 @@ sources = files(
 )
 
 cflags += no_wvla_cflag
+
+support_mempool_history = false
diff --git a/drivers/net/zxdh/meson.build b/drivers/net/zxdh/meson.build
index a48a0d43c2..28fa70f319 100644
--- a/drivers/net/zxdh/meson.build
+++ b/drivers/net/zxdh/meson.build
@@ -25,3 +25,7 @@ sources = files(
         'zxdh_ethdev_ops.c',
         'zxdh_mtr.c',
 )
+
+cflags += no_wvla_cflag
+
+support_mempool_history = false
diff --git a/meson_options.txt b/meson_options.txt
index e49b2fc089..8be20c7456 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -16,6 +16,8 @@ option('drivers_install_subdir', type: 'string', value: 'dpdk/pmds-<VERSION>', d
        'Subdirectory of libdir where to install PMDs. Defaults to using a versioned subdirectory.')
 option('enable_docs', type: 'boolean', value: false, description:
        'build documentation')
+option('enable_mempool_history', type: 'boolean', value: false, description:
+       'Enable mempool history tracking for debugging purposes. This will track mempool objects allocation and free operations. Default is false.')
 option('enable_apps', type: 'string', value: '', description:
        'Comma-separated list of apps to build. If unspecified, build all apps.')
 option('enable_deprecated_libs', type: 'string', value: '', description:
-- 
2.34.1

