Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E440CDE009
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 18:43:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59C89402C6;
	Thu, 25 Jun 2026 20:43:44 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52]) by mails.dpdk.org (Postfix) with ESMTP id 9043D402BC
 for <dev@dpdk.org>; Thu, 25 Jun 2026 20:43:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwf7Zw3oAxHG45cbUP3OW8na1YNvZY2dEN5IC25TXoZXsnBOQdG6Xv8tUxBTNpKls/A2cyjM3MS8BeJ9CwUSKlPEtHJfL8zAz/X0zVXt1pUzSjMjmqB2h6yKomPiKki7BxAhr02lxJSIWwlk7ePr1NKIrsdJ9QPXPdIq1QGSdoN6jQFs81Q8DRPskSEt97A/8Ea7/kmac2J0cxXxKuZHbQYxEQdYB2F0xP8c4GegP1qN3dzJB2jyQKKWRq4ZyQPKzjXLlhj5eVuRa0SSUV6qDZczEBGK64vLw63wCW4bD3+bBJtBJVUUrtfgOx+D0I9kvmtdABL4AjKYnufLLsJUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqA/G7CdzuJrENA7x2vXjZtSPMJe3F2xHqnCFQXp7dM=;
 b=lFfEiU2ceLQsCSm3sPasR7Q+48dVsDW7AYhikYNl8fhJoGOC7MmfReSiX8QyaEH5+KUFPG6xd1yA6XmwrCTqjm43h+X8mhPieucf6IVmNCAPxmV//3I7CrLQdbD2at+Fg7eJx5bVQQo7MpLXJb7TCxE5YM6rt84tUUx70Jx3G32I/fV8Posy+xAl6JVa6SDUCdbarXZWT5G3cf1dS0G2wkLU+pqxqg6bx59/OPSSL5gPkjT0+By0LcYQkj1wlENDWYEndNZISwVFjAnrT860vH3RCuidaHyJGWFt7r+OuOvYxtlINq5KbcR05YfHTxL0xwVbezF4hpOIxjmzxgi0Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqA/G7CdzuJrENA7x2vXjZtSPMJe3F2xHqnCFQXp7dM=;
 b=HzL/bMoZGwSVxQtEk7uCNyPmiB6BTpSOu9/RpAHO+nROMoj/c6Dr9KikxtDofrKgnN/K+F+5JdvTxFdkTAy7kSLQ8oC/1CXYD1OYd5S3nzGf16XrRJp3a8WuJ1EVgHmdyUHldgGk4Mdsd4QFHmxFDIBgnnntrHjNw1vYfmAZIbk=
Received: from CH0PR03CA0295.namprd03.prod.outlook.com (2603:10b6:610:e6::30)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 18:43:39 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::8c) by CH0PR03CA0295.outlook.office365.com
 (2603:10b6:610:e6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 18:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 18:43:38 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 13:43:36 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Bhagyada Modali
 <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 <Selwin.Sebastian@amd.com>, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v2 1/3] dma/ae4dma: introduce AMD AE4DMA DMA PMD
Date: Fri, 26 Jun 2026 00:13:20 +0530
Message-ID: <20260625184320.1677933-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJFAV8xPs4KiHJ5koucQyfEUk0S77zGQ1jM3LxtQvT2qxyX=nw@mail.gmail.com>
References: <CAJFAV8xPs4KiHJ5koucQyfEUk0S77zGQ1jM3LxtQvT2qxyX=nw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 538161c0-6b93-4330-55a4-08ded2e9ac1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: icmFpMxhpaIv7h5cVIuDrGkcDGxrbiUvZLHjJ+zXdU9cXIIxVlT49wCrGwA0JbzJ7HVvgu1aTM5L9d9POJ+8a43HtjWfwJmIZQPo4Kwl74OhEw2hOuLV5krpZ6S4cdX008Uy2g9ETJ/BSzXekfVVdRKQWCJUqzQsLJfn2q8O/cE2CGZpvxJk5IjEBE/0TKxllq6cfYvI/51Cb5byNSGdFq0CFbu/MSLdCKHjt43D7njG+zGFEqfcB1+tS1Hjz0KfYL3Tpqkc2DL8pt/9PXI3m2vEiUOvWkUNYX/9ViUpVU/PQUykmzTPjsf5SLVjFD5RXrEkv7YZGKJ+z+TgGFlD7WfjoU9UnEmTXTsz58WIPthD8SZjZt7DsQAG/6ubkUShHFnvbuAIFgAypJY9QlGwefewvfBYgZTXbVK9KtcDukC4yp1KqelQDVy+Hanh7ej/3XFA4O31rYejrZALmp3RihUDhdMujtIOuahRRiGDzFFOwkfVXFIPi4Vc6oIIa4v2wbzCA7tOUn2Yvh58fzurc+zCd54g5+WjAFrprpPMRK/aH4lVIhNSXRX4vl8gqrfp50gZ0Fq+GkVfNdaGpDBNrWquiy8hvU0BeeX+6cAuL1K0s6Mw/a0FLjONk8di0Ku+WWKQntjdPwRWPBY/fJDE0UOnV8Tg7C6t5SnV/4IhA7vtYPsP3uXPMBeJCwOzCHsx0+nIiJkNcwV4Z4hmm24xDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: odjmpt99CPUnuDrkxOjqaSnJ2zRh6z399epNyj2ERMKAljIe20mvYe1iW6OzsgLFa48tpjZW2FufQYkoNNOKChzHASb8t/2MqbKPiNUiNzOu2PpE7QO2FxiflVtRrKfMwDT/avKrAZpNSS6pyJWZ9XEZK3ZEpmfDA69QpJCHWJLGaTn1RXAXdrtGmvbdfTLn/IfnCiQt3AIoqP+OhRb2WW7N8X+vpkQSpie47Yiw2Iyf5HoqGMVFSKGTNjLyl7x75/T3pBQl2RgV4g7r2Lmto2sguJcoddIc29X3JkscTT9sQziMGXfeC34zrmhM7EbfRMZnM5nBXkw3X7+l/llJilG2B+vP1Q8sNspssbfcQIIQrCxaOfL7GuI2j5rjArxBm+/GSqfNb1r3pZu//U+dn8yBzilmZDtAttQibUYKQrKPU+Nrl8wj+BlGwB32gyTy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 18:43:38.9647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538161c0-6b93-4330-55a4-08ded2e9ac1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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

On Mon, 22 Jun 2026 at 14:26, David Marchand <david.marchand@redhat.com> wrote:
>
> > +Raghavendra Ningoji <raghavendra.ningoji@amd.com>
>
> Almost missed this.
> Alphabetical order please.

Fixed in v3 using devtools/mailmap-ctl.py (thanks Bruce for the
pointer); the entry now sits between "Rafal Kozik" and "Ragothaman
Jayaraman".

Thanks,
Raghavendra
