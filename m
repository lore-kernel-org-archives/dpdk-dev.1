Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178D7CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:51:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A2B427B5;
	Tue, 29 Sep 2026 14:51:55 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by mails.dpdk.org (Postfix) with ESMTP id 8A20A42793
 for <dev@dpdk.org>; Tue, 29 Sep 2026 14:51:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWh8T43SWBneHUdarhyCxm3Z9LGCHUmkQ4B6+OxQ6q4zhKRHckqL4Nq2EvSCQ9/nDgcT9joCqtUBg/s7SAVaiUk190UigqUKgK8BoB5MiaIR+gLZHh8qr5++EHolM+kjFLvBkbE/lTA0mleUqeYmWjlDYpV/XbjgQWBNi/auwH0Rl278qY7mVX3L4KRRCEfrxi/J1xx2mUIbOANqVdn5p/FkD1AyW9xyW9+0vJGcEuAKvJU1iA/z4gkLuOCibUoZ7kU3w94/+HD5/GGH4bbhPGdu/WCpM4JmOP7FHy7Ror8o0TkXR3mgdkpnSuucBvHLjFzieFZrQHf9ix2nn0Oo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42cXwQG3/LO9xFh/l7oK0D1qjNk3C+8o1fOood4YHGk=;
 b=Cy7cTyNWUBk8203pb+pkPHpU3fjnRaZpaFfK3lfPeE2Bsv06N7rsFOWBxlZ0Kwh+DuLYcRO8Z+bcEF8OmKckkbR9vuo/9l42LT9xCQdPfphyCAvBZJMfAy7jcXDo/BtWJdwjjF5lAm09ZDy36wZ+CAOe7WFIUHHIIdaIgAFW4l4GpSx3D/2MxSzu7KFlb+X0sZmS+dLYKbtDj+QGb/GfzxgX1G8o7NjobQHiTUZB9L3cDl0qKA20dI/kVUC+XLnLHFocXJDfIEiye3K3JYUHZ9YnapghRUODYF3F6CtSiCyLfOdo1nNrkDOYHEGdkSuLvJqQme4Io/5bf6YVyqGr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42cXwQG3/LO9xFh/l7oK0D1qjNk3C+8o1fOood4YHGk=;
 b=lghT1gbusovLBbzPWlH6HUPSJyBQA9D4yYpsgsamSq+R9jGVgpxo7EatjUwxcoyeaknw/2HQnN8F0YdqnJW/wXNb0hHMppW1UvO7c6eQ3tOWaigpioa3jgQA4VcH+sdksIxV54GTotzQbJlUBux7GMauIjOV5dqvzvVgensygaaEgLzT7RUfFr3mtmb2ZFf69B3L/KPCZl1f497Bpr+pkPz4bdjdghpx8OqC9M3WYi09eJseqwI74S92topWQI35UD1UcI2LLP17TTJTIRLimFIpevNscvGaBYbYUafzfK1HKJ6DWCGfHm43vNpohxjE2oZMasCViJrWjE97crWlPQ==
Received: from SJ0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:a03:3a0::21)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:51:44 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::7f) by SJ0PR03CA0256.outlook.office365.com
 (2603:10b6:a03:3a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 12:51:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 12:51:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 05:51:23 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 05:51:21 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: Re: [PATCH v9 1/5] net/mlx5: remove MAC addresses flush helper on
 Linux
Date: Tue, 29 Sep 2026 15:50:54 +0300
Message-ID: <20260929125054.85048-5-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924063836.355745-1-david.marchand@redhat.com>
References: <20260924063836.355745-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b264a86-890c-49de-9523-08df1e286a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Nsa1Hfk5rKZ0/QXSXlXfXciNzGSHP7U86ABEXiRuuEQ/PCyqM8kjkDolM8o+K1s7hdNCO23Z39dxDzmuejTkOBBoEYj6W8y9CXi6lvoYc4EuJHbrJuJvq4oe/nycXaD8JITOA4WePkVidsPunhM9QBAScvnqwVfhC7R27MZGs+Tw062KCeiU1sXs6D4jH9RryIkdgf7FCAPjUTlO56Y6ZyAoJ01kZYhZduMPfNjoI2paLkkceZMWMR4zyUY0TC0HBaIrrhVpCIWwN8b+fk/yV53v41t860bb+9eV7C7mNsQv46tpvuQnhoZjV3af9QPhIMaOLSpmu8gk1l/mqXwxkbOBVgEWaFjXNsTC9kiN60KnLeZlWGjH37TrNxhWuNHK/fwf7bUyiOQ6t3eV3RCMAIcuOkefk3NTjwJmGrCWJo6Ff+1GdqFtgobEXePZba1IcBrMW/sQvbavFhcqAszIUL2O+F91LJZ6hRvW0EII5Sfj/sjMfhDcQdH9NBdnNvF9zqRiOh1iCF0CroWL4mPiR4CJUoAguHXjBapgAd21v4Og5V9Ez3i5bQdlQ9DEA4/ICpHksbR7J7pfiBjHwcBo7+DRhOgQjP7AFZghYMpbrf95IHUBxVYlLIxBwBK0ccKZLW+2a3hGz12Wc02BnWvi6NYkXI7aIqsSWwOVe0OYY5CKYO/1zvPfXT3PNjcJnO14JaTtZkbk9HdAElPGaOvk6A==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QHFpfKym4RIZ9E+AE+CLYdAPEqZB1W9UbBep0V7i92dVjE+RrdmrgF7lroXEovbsNMnTqOGL2VWtwnlDfYYjQmuDozm7u6E5GWbb4vQUkRGQn0+BRKmBNWaG1pwi+10c3oayv+ovMA6ziUR3NG3iBDMdsPvZPStjwpPWXco6Jbv0slnikUPTj6ztpDm2nP12UZEbcKCZB+AfJAqV4kcCYsBCywvgulm7hNVDRvyPk3+5Hoz0unERPmnF8wRS1bzU9UPbJ8kxL+IOZhTwfP6V236VZrWlcaLsokQvsINWDSaxUf5XRccUNGLVXV7fy88fo2vZovqrpbUNWRa+NhDSBPQgV5jCepfa6CjzC8SEyjPZ9bCXEdWebUiFsszq89KZpmXcgWJOMhYXH/s8vVdGk8D9yQPo65zwgnfIF8Komvkck8qR/F12PsO8VhCCPea+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:51:44.2326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b264a86-890c-49de-9523-08df1e286a84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379
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

Acked-by: Raslan Darawsheh <rasland@nvidia.com>

Series applied to next-net-mlx.

Thanks,
Raslan
