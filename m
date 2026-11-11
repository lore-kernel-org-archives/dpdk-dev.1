Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71625606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cuCyObxg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 905D9427B3;
	Wed, 11 Nov 2026 08:11:27 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
 by mails.dpdk.org (Postfix) with ESMTPS id 2D23D41143
 for <dev@dpdk.org>; Wed, 11 Nov 2026 08:11:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cX5y7Uu7/G7wUzkpsHgaUkiAU1MXqCEYvNezJhiARaOSKeUvER7h3kUezFBZK/q8Yg8To58RWw0L7Ct7YRkONFq0FCFyo+89Ri977XnQvvK6B1e8VXtWKjBCAqVBAgYcEWtAXSAzJWtKHIgdO2RX+M0cznEnHYpj1oLc+D6vArhnNi16kecwfysxQynV46udh5Xhi/+UPj5ktVRnQ7t5B7Ruhgjn6zkik+uQl1gZn+WmQkjQjCBYNHeX+de+hLT0ZzjJMEVFZvfyATG+A2Hi5ZZw+13A8bhdcDpdzNpnXFc2xTiamGmqHbElzZQ8mzRSErFgsofp212NWOrW8XRsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xApUnplQm338SMFoNNBQGlUO3YxFEXuGY/CJPAZzDl8=;
 b=YSKYaKsFK2+akpzvBBapCvYOMCED+tb+j7+vuMajpbh0avh/5sz9l0+z5DRmFnW4E9TYp4h6TJVXLaPREJY2etzVJpukQS0Eo5vG2sGMRKQCYGJxGEfGMOeXdTVsP4pxge5LQfk/eYcwYHDf6re8OHYXg4pLVWswpla8XnSuEfv8cozgGNvZmfkbS0INyNFmaaO/Gtk5Qra2wsC1ZQCeK8YTtdxZz/f7B+q+uahmWPNuVhv5Z4IisKFj6NlTX9zPdon+2gVSpeKEAQnad9vecdI7CV5xH1vE0sJyR529zeI2cQBb6BRaz29bkYlkO5eUw/4h9Kdkifj+8zb1/XyEYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=networkplumber.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xApUnplQm338SMFoNNBQGlUO3YxFEXuGY/CJPAZzDl8=;
 b=cuCyObxg5deTMUkIN2Kd55AAaWu4ZAc9UECnlRravDwVCbiL/zouvgxdGzxtpzAzTyExpegFyVHLXD8B3fcQFNL0hlZmu3tU19P8JPnMpOv60ZxCyP31sQecJrpsQyFJb46mplK1b6phUL2iH9Erku5gNxj1TZvRt5pM3BLEnJY=
Received: from BL1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:208:256::16)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:11:13 +0000
Received: from IA0PEPF00000046.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::43) by BL1PR13CA0011.outlook.office365.com
 (2603:10b6:208:256::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000046.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:05 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:09:27 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Selwin Sebastian <Selwin.Sebastian@amd.com>,
 Bhagyada Modali <bhagyada.modali@amd.com>, <bruce.richardson@intel.com>
Subject: Re: [PATCH v2 00/15] raw/ntb: post-merge fixes
Date: Wed, 11 Nov 2026 12:39:05 +0530
Message-ID: <20261111070905.822087-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106135050.650879bf@stephen-xps.local>
References: <20261106135050.650879bf@stephen-xps.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000046:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: d1dd1401-160c-4575-f904-08df3fc2f81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|18002099003|22082099003|56012099006|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: oldxiOrfI60hVeO+6xYwwzWqTK4Q2rF0NtOEakEYxNyrHQvLruSvLPxWnScVx/VxFRwzpphPre52gcigQ8gJipsBp6hASp63tyrXXVm2tFwfzRXE08XE4pSwu8tddbotaf7CUZwN+j9QumVDqwVWWAaweaJB1h/b/LuBzwYnKen0NG//cvz6I13WiheS4hwhCQpiRpeuI9t9PU9lVb6Oqc9unsh4sfJqhhK9sfryuwfCOh17n0stBQJMMeue/5JcaVviM0/T/PSGYESCcsyhhTgb9IMeZ0pXi+JekMq2LXom/GVbKCKkp7uC5K/gTRi0jcg0cuPFdn0hPw9P7s+yBskSjKJRVylYlMZ9aCRUxj3VaTgrUvZ7PU/60GM+jFud21e9gGK4+e9ueZD6O4HlXedDbpT3kEgLR1WZ2yFJSSoNPiI75YOwL4flreZHlbdQ6HORcI7GJooq2DCRXhD+a5uXvjtC0SSjovUG4Va3B+8sMtPYu5RREqkfBYrQ8qH50tpHgxNGE+dt0ax1cveBIdf2umZ/x45v/n8zNYImlQ13hPGLYSd83LYdKwTLuZI6AqrUEIdnB8rSdc+FGkw/f0w0jPY9y/5Y4hlOPTEmJET2iZIQGPhvZc/VHxw3NQ1qGIxS8J5YPbPk6LQiwQLFV+8/k8lmf1XhjV1wGJl95s1OP/fRMwDHVvG3splvvOWIO9z6IDTeLHERp/H9SutSyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gjjhe/culsB/Hey5F0qtIjSNIAvQM6X5O5GrvhZnfsE6HE6sBW+BKJavMfVeHg/6sqiEoyLfvOQUnolSJfN9ybIdn9VCNMqMvlUiuB8z4dRgyp+L1cyymYcLxS5mPo8r7+QruA734G41Q5CbdqrvHHdoyZNd+LQeq58L7WEL1LUCtX0Xll3e+e9NMs/uf+o7XtD6+7Ga2ZPzL+f6WJ23R5SM3H8mo523C+1gQGBLUZSVGTtwYb+KUuW040a5Lhh46TyxHE97WzoQewZIBWkot6mvQYE78zQzZqS7zgeD0dwvs2gr7cU3Y9mWxBQL3JLXOc9XGpT3XocPx5ZPFjc3LVhKPjrsD47QetoverxC6GOfKfLjoewZ4UQxNfXwhBgJk5casWsAzKq9zc6rywfQ87U+eMsK04dIG9G+yc9nYbll8D4dIsyVnoChCu8CJza2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:12.8535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dd1401-160c-4575-f904-08df3fc2f81f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000046.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
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

On Fri, 6 Nov 2026 13:50:50 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Info (pre-existing, not introduced by this patch): ntb_queue_setup()
> still leaks on two paths the commit message does not cover.
[...]
> (ntb_txq_release()/ntb_rxq_release() log an error on NULL, so a
> NULL check on each would be needed for the last release.) Fine as a
> follow-up.

Hi Stephen,

Thanks for the review. The follow-up is included in v3 as patch 16,
"raw/ntb: fix queue leaks on setup", as you suggested: the shared conf
is checked first, the previous queues are released before a new setup,
the Tx queue is released if the Rx setup fails, and the release helpers
ignore NULL queues. In addition, the setup returns -EBUSY when the
device is started, as releasing the queues under the data path would be
a use after free.

Hi David,

Sorry for the trouble with v2. The patches were generated without
threading, so each one replied to the v1 cover letter instead of the
v2 one. Patchwork then split the series and the CI could not apply it.

v3 is resent with proper threading, rebased on main. Patches 1-15 are
unchanged from v2, and patch 16 is the follow-up above. I will check
that the CI passes on v3. The v1 and v2 series in patchwork can be
marked as superseded.

Thanks,
Raghavendra
