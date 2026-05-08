Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D81CD3436
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 12:41:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C90AA4025E;
	Fri,  8 May 2026 14:41:00 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
 by mails.dpdk.org (Postfix) with ESMTP id 5A4664013F
 for <dev@dpdk.org>; Fri,  8 May 2026 14:40:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcA09+Ogiqk6UtuwXqz/TcjADb8cQ052c46mXZtewJTXDde0QDVPhVQRDhCUsewPP16i8XtU/QDo7GT+Yn8temiMd4vlz8jKx0cYxEEMmtWVfRLQ5DITBLBQ1e9zFKl6346nW4jFiWgAgQA/SGQDg/QN8GgrgQ7Sqbzh8WixBUYH364sz5W8zeZq26ySg/gkQKhELkT2OZxn7sQns8toNTLmeKERXXYvEy3bKE5VtIwLGRy9eCSw5vgUHkwX6IQeCPGggxr1Ja9IVNku5qTnEvGf8F/PREOgzbqIso3J3CoyuOC4QH1NdWoz5UJ+sPUgzyfRyKCOWSCfIVMnB1vZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLKKxz+gIaVTIgAq/PFWr8cww1e7iviJbOllgOpWJpQ=;
 b=KsQS0vvfv3r/EXvpzoumF6+eO+4NNCrVMs6Vi2ceEWOy/gP6JypJIP4gsGyqokRO1vnc8X5nWMnX6WjeqT1TfUOFciwimoExIiuVQN6if/19qF7FAw2FoliugJTRFAkMBJWxEyA7af9pXnc3f3TRyo+wAmeB2mZw78B9dS8zxL43iC/hkmwhfujV+lcAqr4cPFvzguaKCOgOkQsdz4OW/zNZ5Nbf2OiETXoADk/CGvYGFNY0I2Q3CTM4lQGR/PnEsT/myGekJpHqf2hurU+jCwsStuBJ0o0DejX9KNqUG4IuvE7Z3cTi7oyeRjzmQXrKyg79s2+0/FqmziipwqpaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLKKxz+gIaVTIgAq/PFWr8cww1e7iviJbOllgOpWJpQ=;
 b=iFidy/X13wyTVy5WdxNZbO+4MiptYx9ogyCkoTLK94Y9hYZgJHfN2iBwj6UnBwthh96D//vIpZ7e5jvSPV3YJGuVFug/BpY++UY280AopVYHYdX5XmjT5Q8H2T4Y6zsq+rX3vi24w/4v/pa2nGNRgTBYebO5KBqSMB8TKGybC06KEHC0goN1ZMyHGKZcRHQSDvyVdHSW2eAfp10HJjNbBKwYnvV5psuOXJlL7j0PcwUQRT+Y+WnnOkq/4JTNQDQnxeTpFFwxD1uuaXWeDGHUC2h2PahrXbhGdL0Xt+jYdNkGfPZcbAHut45+3V0pRvxpkw/DN+RvRTNIOJ742h0P1g==
Received: from BL0PR0102CA0062.prod.exchangelabs.com (2603:10b6:208:25::39) by
 PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 12:40:52 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:25:cafe::ed) by BL0PR0102CA0062.outlook.office365.com
 (2603:10b6:208:25::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 12:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Fri, 8 May 2026 12:40:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 8 May
 2026 05:40:24 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 8 May
 2026 05:40:24 -0700
Date: Fri, 8 May 2026 14:40:06 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Maxime Peim <maxime.peim@gmail.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
Subject: Re: [PATCH v3] net/mlx5: prepend implicit items in sync flow
 creation path
Message-ID: <4mfe4gzzs6tqhbsu4tlnahwrvjufkan2jwfftlnpf36eicb5b7@6eucxrjdioxn>
References: <20260420085236.2356342-1-maxime.peim@gmail.com>
 <20260427123217.510662-1-maxime.peim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427123217.510662-1-maxime.peim@gmail.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 82beccfc-7c00-4852-4041-08deacff0a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XUDXuD0Fy26VyE5q5Frz9M0F+pzMZGER2Rlx6/Fdqx4ijXdi5DugF5b+MfEdMfjTAyKZjYdHT6ypGtqIkOQOIrgxq65buD9TRsB9Qwsobtdbu+yYqDdb1CWDjqfm4HTp+Ce8ThmX5fLX7WOt/Y27iYbN00mWnhWjd2KqQ/WYpS+64WQFgTD5BDDkjR0wi672SY1FF4+bp0biEKp48frwW9xWaZyo040eMHBnZl7D7FmZSi1zMJd4A+w93dpfPAZ0T0An8P2iV4StNyt6wSiYqtYYkJ9bQxEi2INPpYkvDic3zuY2vgeqMTp1pmejbvjNWv+jNWVZe70R5RI5lrRSjWtTCTo+x2kEwmpiWqf6ZonXQcwqFK/n6IggN6PrQMtZCEkD2x1rwXzIpNTPemEOQG28ihBasnFRJeCANlsV4Z544Dpd0c9/jBJyxCLDXsdcWHc26ecJbVnHiEuWNh7HjOUbKRt2oE6/83FCul/SCXxpUP3ixSMQNr0Y/HR6olaCeJeNJYzuXpiTblnGpcBy81+lTb5nbV8Mo/ZhfuImLkd0WvN76kpdTZBxlDQROz0yNPwOlnhGNLwINLoiTDmG0XSyumVlzfcYT+QHD5QB9TYgEoClQf4aShmepU8cpJU97uni7CRzDaGbcTHiikQWEpqGtSw4O/Huc05N6XJ8hqku8dPzhpNpPGMX4VVxMhNlxIb/fzww3uONPqzqmyKZ/sazNZiAHWx9eTD5LzFbM3A=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1deOaWFufShnJIWV0AJp0/lIAPCVwUGPn/TjNnXe/JtgQBAdDI2vvaKVkWOo/kvDd+UWWLatMYTUXqi4dARNZsfiPufG6nhvU6cFttMmCyRNKP+obJSByfEtoCjCxuIfy46+K9KoTn73cNRGYmP+BaZNvAJn2+8ucKO/NMeE738Hs01VoR/MYM9/hl2CC3utHg7QaKLl9osheRg6Ybd4HNnjzO7tA3JynENR+E2G19VqDblt9rQcfzWx71GDRNZ459Q3QmT4vz5dMJLHmmKI1f+lCCRst0Ijk1GkVlRxU+2cmBpBOAxHFRQo/YpF6sHyBLKYThTF4znG2+ra/lH0KkPCtfGIyUraqnhzGgpJzFjHP/qTSYugyHWGUDq5LDp+uB4gp6XZWKVJvMf/h2fEhyfvT4u19g3yD+kjrrk/vp2S0GqQVOiWeZGZZzxbDiUA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 12:40:51.5897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82beccfc-7c00-4852-4041-08deacff0a12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210
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

Hi,

Thank you for making the changes. Please see a comment below.

On Mon, Apr 27, 2026 at 02:32:17PM +0200, Maxime Peim wrote:
> +
> +	prepend_items = flow_hw_adjust_pattern(dev, &pattern_template_attr, true, items,
> +					       &orig_item_nb, &item_flags, &copied_items, error);

Adjusted items should also be stored in resource.suffix.items.
In case metadata split is not needed - when mlx5_flow_nta_split_metadata() returns 0 -
only single flow rule will be created, at line 14392 (after applying your patch).
In this case, items are taken from resource.suffix.items.
resource.suffix.items holds pointer to original pattern, so adjusted
pattern is not taken into account.

This case be reproduced as follows:

	# --flow-isolate-all disables default flow rules which can
	# obfuscate the issue
	dpdk-testpmd -a 08:00.0,dv_flow_en=2,representor=vf0-1 -- --flow-isolate-all -i

	testpmd> flow create 0 group 0 priority 0 ingress pattern end actions jump group 1 / end
	testpmd> flow create 0 group 1 priority 0 ingress pattern end actions queue index 0 / end

Packets sent from VF0 or VF1 will arrive at PF's queue 0.

Best regards,
Dariusz Sosnowski
