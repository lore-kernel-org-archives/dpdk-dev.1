Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD5606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Jw3QaLqs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EE2D40DD7;
	Thu,  5 Nov 2026 08:40:47 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
 by mails.dpdk.org (Postfix) with ESMTPS id 5A37E40296
 for <dev@dpdk.org>; Thu,  5 Nov 2026 08:40:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlRPIfSfXHyLxf4j2JCRH9c4J7DFkCC9qD4i8LtnVafNgvlsZllopbaG6kzzY57a7md09OxNcwPOeFPlDSRvc4BbHcFxyCe9cIxNIA6l1YWRg/W2OcXSSNp3aqN9FHtwKh84ufIaj/hciSmvB55fzL4C0PBUvQJT8qTdSs5mce6uC/xt8EiC4HiyyTXotY+ZRgcTtMqcJ9A9I7OQ4L97qxt3+JkP9z5DYBqB1aBKwsMQZ4CRkCRBHTeWoDrqBI+1O24oR9JeW0e8n4aXJB4HwroWeiR3AuTPB/sw56X8xhC519VSBfReTyOHz1UJcHuyUZR6OX82Vl0+Ihmk9MJoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=FB529RMbjGirisE77Lqk+bs9oCDT7kFSUOssf4hB1UspP6AKqFfq8yKFpIlU3zSSdCC5ZXdySb2MNSbzGMsApPb5fnR63Ni0uDTJfOwoawWiuMIbdXaWUXHRJ3sMPVQY98PPvLay3hKoOzNnvwU3iyGczbz0w47g5rEXWFVWO/ZuJ6S9Qdbg74T1upAq9BWIbva9o6ew4d7ltUJisrfXMzboapu0intiwZ5d6EUK0V1lMz2zuAcX2/QTdAU4d3Uv9hl0kGJ8Ep+WP2uQikloMbmmpzhpiDOkB9IFVtzMw+dR/3Fvu6d9rNb3fkasJwQ9hRar/FIcVgmNmSylDxqb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=Jw3QaLqs6NtluNZzCwmXz5orFjn8dr0Xa5RYcGfa7StopmDx8hdr+sPqYSxshYtXmCHbOMQYNkARwZLX5RHro+l1ofzG27DYOTsZeLUs3u3APcY7zqo/zINn8jAoSj9MgxuR2jozZWAv0eErVqh0hGzNWt+EtTeIIDMvan3Eqp/KvdbOljXVnJLHRfCU/WruAkhL3LgFr2sICysGIrl7doRdxPazifZS6nJ0RgnqUh9pJ/SANaQuJwrk3kPoR0c8qSOzIjlvX8JunLtdUhtCuH6geUnYWcWDWron9/houpnwhrXMbu8XqQSDVHyHl//BxDRdYT1qTeEUpIaXisOuiA==
Received: from MN0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::18)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9ab) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:38:40 +0000
Received: from MN7PEPF0000014A.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::34) by MN0P220CA0024.outlook.office365.com
 (2603:10b6:208:52e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 07:38:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN7PEPF0000014A.mail.protection.outlook.com (10.167.254.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 07:38:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:38:23 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:38:21 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] drivers: fix ASan ODR violation on glue symbols
Date: Thu, 5 Nov 2026 09:38:04 +0200
Message-ID: <20261105073807.20511-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103112525.3432332-1-mkashani@nvidia.com>
References: <20261103112525.3432332-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014A:EE_|SJ5PPFFA661D690:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a528d0-16f0-4834-5c32-08df3b0fcf91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ozvREGSy4jyzsFflSIs1EYF8vuu82FvwbNm+rQ3Qhlg7n9XDYXjLqeFppYhI4xXjVGnWfQn6M9tGobYzAi6BVka1e+zLt7QDEZfVmgAzF11XBvCUwjcPM85BtO9aVEdgK/rTUb4et/xeilKRvR+74AkJMrsojqpF7WcKi/ym/EPKeu1DTGZcO0obcA7XOWjn4eZVrgHOaADyeZwYULLd32PVUyWSe2ZI254JC1wH3krelr1OExgRwYnPGi0mRb41SgcSzy+Sea4ehCvbPc+QuKUPh1siclCRlCD3IsN8dFcw4OJMmMg2uj07CALrEeZNLaGGWmprYNN/ftsg8FaLJrzOjM8Rcj+ZaWcUUop5npaBaD76ARiVu+7/LnsnVJj1uMBQJHVCbQ32WnEaO/swZKvLO2GrP91wtvffxBxDiv/yHLnhCQYMRj2yBUjZOjZsDdqV16GsQ1HwQXqkZPf1aANkfsXwkJ6lhi5kfB4erArLGL/3QFlhCG9zAqtLJz1UylGJJ8NOVON63tvBxE5ZBkw3ccx1DbRU0t0bOFjdBqR6UMiNClBuCnLpLxi8Dh1+NlFZUWyIrjdBUylRSPRytNttgIcz373MCRUYinwfbXPgJ6L37h/y16DUVuDIJrdLIOPolqlnuwEbTF62KDDuIt1dM26+xChjvWb/Z2reVxiepbHnAVcHmJWX+/c9Z/+FDUOFS/hFIZ/ue9znCLK9LQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7Awbr+qd6o6+q8rHsaSTCQEF/wgRrdu6Sy3hY6BISAjmwOL0nMDbMP6qOMxMmYJW7vEbF/41i5sADsz1ttJTCU9+rv9gWyceEW0kfYsgTomAKvzq1T6m95srRIG160SKHH0dydu7eEAVdm4YbQ7m6aUa58ho5w5R3fMDd41GUal9/imYrHkUuNmskCMkLm5x8EF2T45VAWHnwAugbUPqy+bWjtAuoU4rTh/sLZgVPBvg8yPZIt7720jbNH26TsLeVRCMfP+DXEZIgdz8CJqwmk/x1MQOvD6Xlj6BrPwdnTd6TUUO2+7cC9PBKIMtIa6oobxYD1UIhuOG43RnrlZwRN9wAoKxnZ1P3WLxB0twClBZ+J4e3NuLEhsGy6jZHFPdmvW0o5rgkf1FXV909P/HoK7yoYEGvMQtkUCQsMmd2+HBR9upLi7p85EirSbtH5Em
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:38:39.9872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a528d0-16f0-4834-5c32-08df3b0fcf91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN7PEPF0000014A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690
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
