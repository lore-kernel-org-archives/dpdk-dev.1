Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3970606A326
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FyZgxqIA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F40B402C4;
	Fri, 27 Nov 2026 10:45:02 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by mails.dpdk.org (Postfix) with ESMTPS id 4560A40263;
 Fri, 27 Nov 2026 10:45:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2tc1IgiZyvFMb6Inw/iI5x3DW3xhs36fk13qoXceNhNB/WJDRtNCd4lS8YDlHdmKSx8QKlXM6yIuvoB2RsV6k/EAsDV+u4WawJodQ3kkjqhUvFhm9yiCwHxBXp1ufbkjt6S5PoWri79ny2Zm69nN0tVFwaIGz+QPhY2ZGiI1jKXcxqmL0Yo4M8/8YZxdUAZber3yn2x4OPf7ZSPB9s7qLiPGDhMonIHSzb7YBjLICbxn8mf7a3MVrk2eMPkrQ9slC2MmleHQ+9DJJDNMGZpLawBofzM0ofFfPZAgtac+17RaimjAs54imVcFDXKvmLNXM3mNaJXAAkXMs7Nu2zuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4swFyzWtTujKuJqraI46zY4/cWSzuEhnFGkDK1dSWw=;
 b=odBM7qt917Zd9rQCPMUDz2CN6lEcddnTgFifXXgJvued0+KkLLGJLDWxmTO9IjOudWmkJZXruk2AJ9ft1KA9ABLbU+gDgjS89EBu+XeXF7Z4ZtVBSd8PjJk6+a1g4wlaR1h/QaZybtY2QU88IkILzABKaMHoAGYyV5hE6e0tIJuLk1rr8NJSqF4PRjkHabY/CBmkLcjn8TmFur+iSUerEhit3ifbzk+S24d5lv0cGFnPT6a93eYIFATGrZjlHkJ8fj+1zndEcYhf4aMqeR+Um5spzv384/ytlSENtiKAaTODL15BBUR4bEaAoAVdzQpuXg4f9ZzI/TQwK7N7+x/0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4swFyzWtTujKuJqraI46zY4/cWSzuEhnFGkDK1dSWw=;
 b=FyZgxqIATqiNGUbrLsJbQI1V5KROx4XjSJ4RRX6eGOBFS2upy8uezLy2J1O6w+fbuyAT8MyHRbk5Dn19Wc2CaiRy4vmIGhnfbqeF0aBMOpp4Hfj3lG8P6oVpaiH71jdmxtHZFCRvgxoEYlg4bmH5MMVE9Olih5TScgb0ZnH3RMQD3vpMzFwgQ2K10UCdrTzM8ez328mCJbPX83LSz2bf5YFpQej3OcCgWrO//SNxDBh3lzPWimIhJqp5h0VgZFMJxwjocWyteYxnCM5jBRfoojXXtErsZbszpvknHI8pn7Pzf4sUUUXnpGCfcxRH9kS9siw96BYRTUsITCHhfap3yQ==
Received: from PH7PR10CA0022.namprd10.prod.outlook.com (2603:10b6:510:23d::6)
 by DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 09:44:57 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::a3) by PH7PR10CA0022.outlook.office365.com
 (2603:10b6:510:23d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 09:44:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 09:44:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 01:44:41 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 01:44:40 -0800
Date: Fri, 27 Nov 2026 10:44:25 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>
CC: <dev@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Li Zhang <lizh@nvidia.com>, Shun Hao <shunh@nvidia.com>,
 Michael Baum <michaelba@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: destroy DR domains after ASO close
Message-ID: <ptpz4fq4ntbbnpobaxjdtpi4ohb72cip2ziisb446ywvmjovxx@cbatpyxoxa3x>
References: <20261111133456.49554-1-bingz@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261111133456.49554-1-bingz@nvidia.com>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|DSVPR12MB449095:EE_
X-MS-Office365-Filtering-Correlation-Id: d84093df-e4b1-4afc-635b-08df4c6b18d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261009223027099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: l2y9zcQZmjuWuAPOAUU1Wj7FlFEAay0dRghC4lbJiwInpjrwY5po3cBqWzBPOe/qoOLC4Uf1s++UgkRnkDwZldsLDS9PmoZwgxTl53cUtdF4Exl3GmYI1G7Ztl0ugquww3YIdXzUNiFpd7qZgGeZ6SCNZevTcLxU7RlkLKqRFU9bdfg5qrMM7lagrkqZnX8KquHu9i0oNz7C8DneQpcz2LZKk5mf8dEomopjI+poR9yf72pJ6WnUiHvi6t1mwc1eZHd0LQJO1gADjjRrEs7HHnC0CRtAmRD3+9yPEjguCyLGkEOkkWEfKkCb0FONx8sTqS1evhHPND8chA75N7lIVov+mfkHtKMiWwiDUTThOSTERvYgknlWho9PHlRVy6/kCPsURFtNV9keHI3FUJvXzB8jN/BWGteEdCrc4ZIef89aypt8x2Chl2G6Y4dHmXe53Boh/GqXnIgM3D3vMrCq/n9kAcwwqsunGeYIqJ4EjgniuWE6zkRXSELWutJr/2B1fKIS+qidxglkjGNxto+o6dIKwJaO0opet9rmHHgysIVGRDqpkh4Rmm69BHC8iBth8fmAnKQrIGtO+UhOJPtZ2iwNbL9u3KzlHEm7PjqjxwKpzS/BKA21I3YlBN02ClKmpborP+qR4Kpn7e2rAAiYM3MYK3TmZfelbj0JPGbeIG/3FhlAhFWYXpXZnm6iUnAm5ZIm2xp0vSPxTSAwkQU3Ww==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HBUJEFm+AHJm2ZZyVVH0rZqhfbhZdJcaT634fc5FO7mQ84xg2q3itN3y3hmPIDpoqnkq/1qaju0teES/wdu7OhlG2Vke4imWyXaHa3zDcFA6uz697K11h7BsssOShZnqJpGPzW0q8GmuCs8RAla3Nm4bdpuF+xKwbv5CWYvjDZJRpt3OUtVDZ+MjSPRF0UI9ETH1joCySGs1fbvfLtSpUEWOaBZgTKdsbDUnOKZMKKbkBc/WFIKnPZYmtmA1XqLJfyA7oM2Vt98U5baMfbKMFQbPO4uD6KVTa9hBJGfjISsmkvAzf8yENR7NoXEZSalydGnn0+XFRggn3u1dWMbWX1ihHFzsCQq+KU5g8HyV/f9oM3V8rsl54oWw7m68venuUFK4LoFMz/w14am+pc69V1MIoF3d7esrVJ6KkDB4v4uFqZqW3MviXne1YTlYg6jz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:44:57.0417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d84093df-e4b1-4afc-635b-08df4c6b18d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB449095
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 03:34:52PM +0200, Bing Zhao wrote:
> ASO age, meter and connection tracking actions are created in the
> shared DR domains and released only when the ASO management is
> closed. That close runs in mlx5_free_shared_dev_ctx(), while the
> domains are destroyed earlier in mlx5_os_free_shared_dr(). Freeing
> a domain-bound action after the domain is gone crashes on close.
> 
> The domains belong to the shared context, as the ASO managers do.
> Destroy them in mlx5_free_shared_dev_ctx() after the ASO managers.
> One port close then cannot drop them while another port still uses
> the shared context.
> 
> Fixes: f935ed4b645a ("net/mlx5: support flow hit action for aging")
> Fixes: c99b4f8bc2f1 ("net/mlx5: support ASO meter action")
> Fixes: ce12974cce72 ("net/mlx5: fix ASO CT object release")
> Cc: stable@dpdk.org
> 
> Suggested-by: Matan Azrad <matan@nvidia.com>
> Signed-off-by: Bing Zhao <bingz@nvidia.com>

[snip]

> diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
> index e2dbd2977b..4168d62039 100644
> --- a/drivers/net/mlx5/mlx5.c
> +++ b/drivers/net/mlx5/mlx5.c
> @@ -2130,6 +2130,12 @@ mlx5_free_shared_dev_ctx(struct mlx5_dev_ctx_shared *sh)
>  	}
>  	if (sh->mtrmng)
>  		mlx5_aso_flow_mtrs_mng_close(sh);
> +	/*
> +	 * DR domains belong to the shared context, as the ASO managers do.
> +	 * ASO steering actions are created in these domains, so destroy the
> +	 * domains only after those actions are released.
> +	 */
> +	mlx5_os_free_shared_domains(sh);

nit: In my opinion, this comment is redundant and can be removed
When this function must be called is already documented in
function declaration

[snip]

Other than that:

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
