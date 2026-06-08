Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C62CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:50:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC2E0402DD;
	Mon,  8 Jun 2026 16:50:09 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by mails.dpdk.org (Postfix) with ESMTP id E436A40265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 16:50:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icvloDjxQ/f+s7cBJ9boh03/ipN5DVxmlC79DzGjTmLdj+G6y44gmAapzf3xcW5sFnFRKgjJVVKAs4cU5GVL42u10zbSR+sGYOQekCZNeu0PaXIJL4RvL/nJivbVVHsJKFtZo+1Hy7KYqiUzFQI/+T3jhyX5cM2xPuv5tzjsU3LqekGvwjA06qrgRiFIhIg0bZgqghmG2AO7WnPWO4Vw0BjTz9PzmHccIccjuD1hH7ZruNIm4ssbN9alyaG7eCo4QaP1CrgtLdhOWk8AQ6I6W7wLUFKLoA1eIjkF6ETYc5/hCyyx/KkxtL6HiAEP+o3B0EEEr7ApgzXpXghXt3xTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTZANgi1aCY1yAW/q9/1HA8cqaDAu0m/kB4XpjHYsjk=;
 b=j9KhuZQLJ2uLlK2ESTvmY3tYQFPq9WF9mMRHQKU0laYXOJmLxiAMH7acjNhOrjSeH/q6uml2Ql3bRQ2sm2yau5+ZaJoFecB/xgKiYdx2/Bed/KgxW3b7P81HFyEUiJ1x8DIU50pQ06Te93XEVkwTdkeYK+NNLGeTE8NeABHvWDKSaUXOIXiQJ0JbkpjJ3C6ygS6EaIaJEn6CJ78s2+T1MXfwbA9zoHwKqC+ZE1d75/Wz0dD3erPYUnF5wK5fZvzpM3e07eLOGf9isjuMUjEVnBoRY5TKtOhuh0fUUD3lgiDe/Rs7obLKW0i2BDtU+FP+a4ofSCllc/wHUU2y81SuYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTZANgi1aCY1yAW/q9/1HA8cqaDAu0m/kB4XpjHYsjk=;
 b=hzrci2Kzd0N3Fjyrr1J3auWMgCPlc9fjT8VkgkNZ3XFLCAMG8K6GKynZrxqbLLEgqOrD7PHSyyp0FC6PALTOdjUAMa7bWWn5miFJP/dFC3Jf7h1TIFwcgXvqK8wUs4HP9Cj/OcmirdLnAnIy1uAu73+Q4lwkWTlufbaT0akJaxe3Ym4aID+6cL8WLvbGIAxKIG4GH5RvzgLkBtE7V/J7wxknGuTwk8WORRsfmKWwbbfvu2SvJWHwHg3C/dq1/hvVnV20WdBC4Sh2piE8SEyaVEpWoHxunXQJRVdhLufCYOAnM2j871xgWKVOG5brVEyZOgwHRniFG5sW9EnautGLfQ==
Received: from BN9PR03CA0450.namprd03.prod.outlook.com (2603:10b6:408:113::35)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 14:50:01 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::8) by BN9PR03CA0450.outlook.office365.com
 (2603:10b6:408:113::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 14:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 14:50:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 07:49:40 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 07:49:39 -0700
Date: Mon, 8 Jun 2026 16:49:32 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, <orika@nvidia.com>
CC: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <stephen@networkplumber.org>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <thomas@monjalon.net>
Subject: Re: [PATCH v4] ethdev: support inline calculating masked item value
Message-ID: <7ilpuwv53x43kc6zxlghqavuw7lwlowu4wer3qd7satmtnwkvd@wsfzf6clz7hr>
References: <20260603081941.9049-1-bingz@nvidia.com>
 <20260603092805.9837-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603092805.9837-1-bingz@nvidia.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca5d7f8-a1e9-4af5-20f4-08dec56d3808
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|3023799007|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Oq1Au3iVUskCMSOmiJCf19gdT/Nyx2qlfiXF94YNsRcPG3C7LQLgPzl0s5bsr5qMa4Ie31BoSnB7gOI3EYkwaouziqkrU4mVM4+3dTYYwquNLufCnoT+9NnkGowwjQpnHLvP7TAYJYc3XaFXXXLKVoAMThA6JpTJ6gfXuWnvngPICtDwud0ivO/bJWYdb4ttBqd0Vf9xCC3oY/KESWq4CfM2rMJwPOQL/VnXzvwZvM2fJrZxq2Yy5LzKkIV7kIVHluaUtICZyvjUv5cbGZuZjnkji6BNFmHziuNWiRoL2Xr4qkMIf06NaqfR6/DZFEUlwenrX1KWAzju96CxNfvPpBwq32uERUJEganVqEPloUYA/E65GgnbNLdHMTjIoKPGx+8dsWzWwHqLG4kO6ZiTeHpstwS7VIOSpk7YRDMX5odQmPhf24/y1vJH0wZYblO3eX8vJGlwdUXekE9IC+fJnE7AUeIxdFR87mlN1PifXWeXLoS55DGJI4GqW7xvoQW7tUqAPcEYcUtNXbScd6D8KC1yFjcy0Knq/28Rdp5J+cwxqt8+aii1K68yy2RcWb9StAVOfbYxv8gCzn0dKgwbmpX7yDQeFJtlyxai6tK8bzAP9cT3pDyrUcLdwu4wEnfGl/terj58HBcjEZIY7XLE6+wBVKGffbec0oPnNLHHc9yoqBfl3pJxIFtvkvML5PzQzPxj/SWOSY+qHzIY6/xxwrpZBvx6eGfAl6lpqmR7Kz0=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(3023799007)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cLdJflhE+UL1o7ZMK32i3Cx3An6SmBlepMQhvlbRoZyaulW6Wy59tUxH85CKrl+wXhNSksbbQAeDgJy50rUX+XbbAT2u2CzVx7yKgQeDKrEPRa6W5q+fYiWZE4Xssg8o4igK4Q6fuuw2PmkYsXJmS+D7RmG7QzbsE6PD1yzo1gMkooW0qN6RQfgCj7NZ5C1ctfr/QEuf+S2eBSb5eLiW4CWxdbaLMXgPl9QATCTf0vJDPm18Mpkz4CEZizQZoGqOiA76mdHaBGasXIevuc1sZ/7G+//VNEv6JbmKM35UEpq/BQ7Dt7xBJIGHrRlaJw7GsSMG0SWyzRJl2u/hEE3gBzsnhbyFGaqPjSd47e12iyvKY/yqsDwXEsMBKhfVcHW0tD+X7e9l9Jslb+eTn58xDvzKFZJVz7ch7osVTSoq35htYlcycs+kZpa38dQ43OZV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 14:50:01.3422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca5d7f8-a1e9-4af5-20f4-08dec56d3808
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
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

On Wed, Jun 03, 2026 at 12:28:05PM +0300, Bing Zhao wrote:
> In the asynchronous API definition and some drivers, the
> rte_flow_item spec value may not be calculated by the driver due to the
> reason of speed of light rule insertion rate and sometimes the input
> parameters will be copied and changed internally.
> 
> After copying, the spec and last will be protected by the keyword
> const and cannot be changed in the code itself. And also the driver
> needs some extra memory to do the calculation and extra conditions
> to understand the length of each item spec. This is not efficient.
> 
> To solve the issue and support usage of the following fix, a new OP
> was introduced to calculate the spec and last values after applying
> the mask inline.
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>

Ori has some technical issues with plain text emails on his side.
On his behalf:

Acked-by: Ori Kam <orika@nvidia.com>

Best regards,
Dariusz Sosnowski
