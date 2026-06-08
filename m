Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22D4CD8C9F
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 12:46:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C761C402AD;
	Mon,  8 Jun 2026 14:46:47 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
 by mails.dpdk.org (Postfix) with ESMTP id AAED640265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 14:46:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+e+ItUeg4h2GYzPkAbTAdutqdxR1/+tfvo24P/wduwkCg25k9qb+X+i7kyF1wf9/K+7Pb1wW/c/bLX0M0O8jO74NaPLgYwRYf21SbMR3N6z8U0m/na1QaVrOVmQJjgXn53H93CDPm1pQecC2FHIiR0p5VbpAENPgghv5p4DO+ru06nbMQk8kdiHrfcLN6j0KFlZX/4eTUvuFfQ4ORHoSDYK5ZkPiHauX7V/gHVERTGbHeMUXhAQ12CHPgjXtRzZBeRpVSg8zSEfgz09XMynh5Y4VteJX7O9Wb7kKWDhfGoURdJfInvZkzGHQTiobOsFLurfHDPHxcw1ats/51ibog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TS0sN69i1uj3IovciwxGR+nnXsuOaUd93dpTB13MBhk=;
 b=U832+otoyb5F6FTQJQ8U1yOqJCixFXyAtw+vLiJSs6nCObnPlVnU2zRYmkZkSasCXyvac7OHQNTcsXvksWemW2NG40ABkBoc1D2wOYJeaZhCX9MtfRTosDY7Cqkfy8R+2xyI4g9b6clJqhp5KZrRnnfeIBGSBHtWxSySZsv9J5jDCey0Hbf+nyRK61hcssYFRzYr/hHDyz0Nemq++Cv0O97Opomjw6k2V3VJUyeUlpKkMBC0x/FuDhT52TzQ7vymNg/VnhqF0HoFvQBAmQYKDoPWxW80u7zHsLu2jkPoEWiX4fTs1a1JGScGtOc4NKw6xPzAXptpd2NufuybCw5eDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TS0sN69i1uj3IovciwxGR+nnXsuOaUd93dpTB13MBhk=;
 b=O37xt1mZdc10MrWS4xOTaF778cT/NZRm4gaMCd2M7H1cFWBx0LafR3mseOQqMI1vtQ5Au3oel88vc4RzJ/UJIhhrttAIY8d066h1zvfZNs3EY41KCK9pCZcHUm8sVAx3RsPXNQFSgqN2EwtFPC2RJEm43gzkIvVApy+F7jdI1tZAOQHhC1aNAzhdW3ZpZWPBOxtI6g6iKd/PeXs5TYBDt/ANJfIWM9WNSaVIFjHnqo6+Ha2vNUowAoVXFIhTmJBB8e+gUqTHxreKb5xJJyCxLf6P8Z1pewiBrtqWFdN/u/YpsTS+ilSRXi548da2VkCzJOcZrUGtRBcM9xMw2SqQtg==
Received: from PH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::15)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 12:46:43 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:34b:cafe::65) by PH5P222CA0011.outlook.office365.com
 (2603:10b6:510:34b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 12:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Mon, 8 Jun 2026 12:46:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 05:46:19 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 05:46:19 -0700
Date: Mon, 8 Jun 2026 14:46:16 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] doc: move firmware instructions in mlx5 guide
Message-ID: <wxwldilqlrj6b4qujzmkoylsth2yvudxxxbbn3wm4skollmkpb@iwkur5ythv7p>
References: <20260608120531.1037367-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260608120531.1037367-1-thomas@monjalon.net>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c20462-4a6e-4ab2-8b9e-08dec55bfdd5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: OQmZyiVSrDtJfe0ym5FrXF5+6tq39fqQwu/xUWOn7ec4KHkBNU7zBwXTTMPuhV7lPCkIQZO9pRHym74CAs1ShaWjudWRi3J95bhP+cS+mI6Mdu3TQbx9UW2TRzRobh2UzgAI1wIRpTF/nufUQZqJG3sOFVt9uX2N6wBNsPE/wxumY9p5JAOAhRQ7nrJc9L7ZmjMm9Ql5ekQ5bIcvyZ8jaeIbLK7xj3d1XLVhFr8KNM9eAwin1IPWuCexTjXvY0wUrmFOW3k6ZLRlm0UpjJfVU93u6cgl6/fLdBoP4NfmTvwTREZOsFq1m0ABllGtEy7ZnX4AGjRajbVntQhiYZGizBEf7t9eBUufMNu/gDGZZGnhHjYy9Qqr3oT98WVHdjYnz0Ys1ezUWSJ0wBeR78ZIhXQCiZg4sSPQNrr97vsspUhT2Njo5x7MUQgrX7qsu8w9Qt7EEj+oEHDvqHQzO6UDN1AaPN4YxVl2JHfIyaJMwdk2qSGv3EjQqap0cjHXlZo4Ik0eydVVUt4IUHgao8pChphUlKQpCOj0TcDi+sEVrZaClZ84N7jBsKdtU38CHnPsJEehflx1otJrmqiXIxceqN6EiCyExZ3zX2GDBQLBdI/gXg/XEC9ngNxaxE+YQAiyn6wlnwpLNKq+EfkaDoVS4zwN2SjO0RZHszWutkwoATX/F41CQ6Mn7wMlB+RII86JvqAeiVhtEovmweWWID9ah8cnsnYN/MBkekqhP6g8sc4=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iDgSxtyCHW7EpUWR1FX4BHsl4e+GF5p+T/Hwz+J/AJn74poxDfsYCETSr1P36WiTghIUT7wBT8PgRU1aLV8LgU3+u4UTEeMgrOL01UyIvbgkySeOImZDwzSBxt+6Xe9oUscuNym6X+SvNcsmbFGN6SJ7SID/dsrEzQyDRt//TaZTKLwCVmUbjKTSUe52evN+wYN6Bi5mu+pGtef4WS32tqykW1vd5IBgvcQTor6OxpMYYKbTH6GVBjBK4LXuwntIdFBv103eXslHcq5go/SOmyQy5dABGrPIiVxVbldZIjlrmFwJC/qoYm6XDcF7LVeOfvod9+To3HHTdtZWoxbFHzcYwcCLxjnBtIjVStniwLo0ODjswFUp5H99mr3T37wbFnoV9gPMEjbxTgrEoWKj/Ik66I+7JZH+W6IRbabfzXAm+LcLNglIF6HphDHjB4HI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 12:46:42.3062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c20462-4a6e-4ab2-8b9e-08dec55bfdd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
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

On Mon, Jun 08, 2026 at 02:05:31PM +0200, Thomas Monjalon wrote:
> Having firmware update instructions before firmware config
> looks simpler to find than in compilation prerequisites.
> 
> A link is also added after listing minimum firmware versions.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
