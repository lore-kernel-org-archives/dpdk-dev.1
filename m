Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98648606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QM61gF4+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E13F40E1D;
	Wed, 11 Nov 2026 14:11:05 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 4444B4029E
 for <dev@dpdk.org>; Wed, 11 Nov 2026 14:11:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlybpsYF0U0sDwCDwXzx3pnKvvzEhiNd33R+N61UDmSYzKRdN2J2USd2xDhDAG05eml2Cob6r3v8FI5IPlxPCrAw2oJT4WVG8MwnN5oK5cRYCbrG5AZxxcNGPy943xq9yz6CNHt2XY9jsgxrJ9Ypr/GY4KjulQnHB8kOQRoBq0Ylphz+6SsBGuOz51PQFADv5v3VdDVkBTuFesQ/Rw3g4kaUJue3yexeisbYidcUDB8rjMsbEU7wKsXM25JawS9szRzCxumQlB32P1B5zxyjvmFDQh5yxlbcb6SKP4UxtEW1tv+vVYOJeWyKayFSToyIOat0YH5iRTQRU9AYKXPD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=Kjgd1/saGaJqiLsNeCoI5p4Vc1WC+EwPa11u45kx2poMnQ/nwdRP1CCfcm+xHYNobQxG7y63tWp0sdHo2zy9HmROdS3uFEJniNOJxMdRwaTH5A/acuEapWAgReKs4Fe2VBU3n3AB4ITuYB1VKOBb5KlY9b6p8b7knQL++PYC7BLkjFFXs4rc9uOo3ozJ+jZd6AjffvXSbYyAvVgfsoTRALh9W0V6I1pH5T6tRmSDubuVaeD0HTm1shqY7YpmKKviUrFrwIh0EJTi7a4w0ORDIV9cdSSXxtcv59Fg3vuYXsRou0/n8fL452//0/0yWAGd7rVFNnkBCrjbNiJtpwiSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=QM61gF4+akq3ePCVGG8Mt8DF1ZJVwBx7MhF96RS6Tt/1pFghHgrAXVLGyjaY4XckoefjZfbFsX3HaBtZyyN4z7/18hL86JfxCaQrVtjbaiSKC3EL763HfRv4VQTzVbmNaIITIXpW63MBbsoTbF900TF8ggUNXm7OD5nxOiOji1OWkQDtu66umePJt4tBaE93FRTwbNvpRP9ovcJsCg4it0lQwjp6v4Hwost5q26Y0opXmf+HIF5rVK48etzkrs9GJScI8jfaIBC9GcAH5GWqVmwei9pYPUX3Ufo/OACGkYtSMGaf5mMkv8Ru5sPd2oklJwqw04yh53x96HSsJ8Syug==
Received: from CH0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:610:cd::32)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:10:55 +0000
Received: from CH3PEPF0002457C.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::ae) by CH0PR03CA0117.outlook.office365.com
 (2603:10b6:610:cd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 13:10:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0002457C.mail.protection.outlook.com (10.167.252.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 13:10:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:10:37 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:10:36 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Itai Sharoni <isharoni@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: reject unsupported layers before GRE and NVGRE
Date: Wed, 11 Nov 2026 15:10:21 +0200
Message-ID: <20261111131022.14086-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261108083721.3390082-1-isharoni@nvidia.com>
References: <20261108083721.3390082-1-isharoni@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457C:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: f100938b-e44f-49db-1dee-08df3ff53834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oGBXhahnixhjHEY404FqzOlA1o1Cz+Tp2QchqEUWBZZPkGbzvcLpU64yaYCSjsHpquvijc+Eaf/3Zh4fldZg6fpu/+Li5yuUTHUNB9+LVuDgMyWSRUhyl2PkFbGvb2WdsQLZp+OoNzhNE7kTZg0nFMaARk4m5wxJXCw5RxD0e56IXUyUQWZkVCVX9cmEC9+7OAjIIRVoHegSSXmPszXbwbifpABb3Wt/FRGl/lLku5+mm2EMzRZJArBix6E2C9ldin8hWlqf4zbjFTs4ZBqzOQhryvukLxVhBWZ8B2yHummvVAC25IcK0aQznx1/xKEekdJx+TPmO4vL4ezV5gLvv6Jta3Pjexn3q4ZmhXqPkR2MlBxIRD4uHw4YSvq+ofUrVCeNOwXoNOGJ3MSuEiQNbRMLxnt281O++wqn06/6s6/LTqElLSY5I/1EowNjNoaTDh3/uIttoef/nV70xsZ6pCFJvzXhANe4qENb+HJ3ryy46lk9WkoFWhGQ8Lc9hP7LsXSCxveaAi+hxAyozxeABKCj7eDULgR/kjwhjSuRrHS3FsS/XUo3BSBDwqY0XGkz8GomYqQLFP6CgqzIyvRA8uJR88IPk7ck0Stt12ONe2yMpy/VSGYvrqg3iqMgw/iNc6USd/IpWBKHmGz0Y9F8YH/or8nKLGUXHR4lZBiy6a+j35rcs3yN+/2S8k1r8re3gu11K4yRWaUT16KyYtxBpQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: akM4HobXIHV7az3SWBSOzSRg4dTLQwF+Qe4vSZU+AII+wxgqQmmlDW1l/t4yDox/OoCvG1JpHKwVWq75XMTJpRehOcBMwCIIIEVYhpT7x+zeMHBulGnXyW36KGJtOf8GVSJ+/10gPVC7ZUj/Yun/PWEkjrYCkbTC0bpRg/4DHui/UZuNSfL/eA5mav/VRKHkRa9Km37YOkwAD4XP7DjRQXTc0Ii6UF393n1qU2qRqFIqXpv98OC6bB60ipFSHMfcFhr9OxCq0YQEy8ZjWkbw6mGci2HArwKv4c5JoRM3oiReDa7OO9on9k36AjipV/bXO25bMFGO0u/G0QAmJVaYlOsldES9XfgOvywSrPUgR1ZwTs3pAKbSxyHd6gP1GzJa/9JDtdLg3VtJ5K4ig3FjQIQhzKQ875bsT8jLQzr03BPdpAKfr4KlwVdOl8qYHi7c
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:10:54.9882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f100938b-e44f-49db-1dee-08df3ff53834
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141
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

Patch applied to next-net-mlx.

Thanks,
Raslan Darawsheh
