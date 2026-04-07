Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B70FF5104
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:43:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1313840296;
	Tue,  7 Apr 2026 17:43:40 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
 by mails.dpdk.org (Postfix) with ESMTP id E299540293
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:43:38 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PPuvq1G+2g6YIvwRI3lTI7OYTZ2kLqs5CU5nseVK95m2Da9C68B7xPGdrR9tFEO+o9E3W9wQtu37N8sjrmlGZcs08ZLqR3zPrNqA3ifT6SrG4ejnBYFUXG70Wk//rsVmMMLzq1ddE1JsP0gaP4JN4zIhkmOtM7CoaE7OkFxJ7g3GYAUOXr2yMW7WjHz0JysljpcV9M5dXOaRcKJCUynATwM73XLUbESulRsEw872Cd9+4Pbmgnxt8z6QfXt7HyOi3UzIJgD382V6Cd2H5AYgM6bX1yDEmCrHqa8ncRnh8F0HyXan5o76PF/5/ou7AupC0WP3htAQW3N1rLn86ZuO7w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZLl+BBQwSNuC1vjsXwrY/ApeFTNiePwnYS8OXBM8xg=;
 b=TFxnMMvXEGORqSFuwABBF+RZ/cjAZKFrA2NV2VWAGFFB1D/WRmbnHmjc+xx6GGPrN6PwK7+8beBDO4Aq6P+vAick9EYASwbseAiF6TooqRg+uyvrtoCDESmK9ZeNIWSCNV2QS7DWjBVPxqTuZ6NP7d+8e1i1s5zz8smjc/7Hl+vWl03x4xfh9Hy2MCMxewpksPCRnEXvgAOJ5Su/L7w8ilrpNGTQ+Rj+HEQ2Xk9MdHmowYUiNZ1RIJEJ2B4gPySwyaVn2+Ae+RrTeGxWtiDIq+YBZ7ssbl1XYlEceU93FeJW5Fuv5WVP5S4aDq7B9JoGgJJ6ZqIjCCAooQyLMMuA7g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZLl+BBQwSNuC1vjsXwrY/ApeFTNiePwnYS8OXBM8xg=;
 b=keQn1jg5KYdqdc/kBI+WCxYb6TR6Ce0Jg6Ei4frEmKhikie2pdebGfgp656uIny0A+rtBB7hOeWVHNJry3TWUDGhZjSygtuJEvDpfx7LGEgrZlzfhx/heN+YAsTYeZVXgcTkTXYQBCeRVmjSDhaXDRG0yY7DlQItDaxC23PBU5M=
Received: from DB3PR08CA0020.eurprd08.prod.outlook.com (2603:10a6:8::33) by
 PAXPR08MB7671.eurprd08.prod.outlook.com (2603:10a6:102:245::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 15:43:32 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:8:0:cafe::42) by DB3PR08CA0020.outlook.office365.com
 (2603:10a6:8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 15:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 7 Apr 2026 15:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5XwhRPf8QzhtGEXfyb7NGt4aimg5cRUs1vKa4UjZR7pQqSTdnHriki1DUHpMMA0+CA0XmSRw7FVZiJ8pBYsM1YVlCPDUPPlRA13Jv9q2Z7qJez8ZN5fXmX9X1FGXVtp9CbfLfvhVy9OAjRnT25JLqlDFYmazgic3Rhj73UjgKxQFO55ZN5MSmWhyPG6P7K4ANCq57dRF7kJ7cU89hWme/O1Xvl/zO6ugphGYmhyHm9nONkJetsIOJW/yPUMI8ogaUaJYSYZ4GhqmPX4mpkAko1hA071v076rkzP+eCYjXl4N7wgX41QEPKZga/7N4QsvkovU7v1KzN0Ie2eFimsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZLl+BBQwSNuC1vjsXwrY/ApeFTNiePwnYS8OXBM8xg=;
 b=gxyjNxYvb4FZbTA+pG9atWSIfeQ8dnlUA0DQeiSOQGgTICBCLBQVdzFUZ/b2JOoX1HuFmKIIhaMaG2kWoJ3iQbDy4CfXrIVDvTBO1f5ycQ02PLLLi8DtCwTFUZgNAnlm5l1mC/W0y3t8dw7nX1E/BlUIIY+B8oUNxqEceGCYMD0CMJLmwlkUqaaEiyqvSpjhGTEmxiU6+wnacSYKUK/anwCU9nv1gigSz2BB08zF5/PgrHr1NDtz5bjPT+k1ZnDThTJGNpkU+ta4vg2FHjGxMqmmeJIQg0/wXUZJqAqIglL9U5+kkdGnqqi3DWdvS6MdeZ0I8OlS4ZD+Ta4RuTzx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZLl+BBQwSNuC1vjsXwrY/ApeFTNiePwnYS8OXBM8xg=;
 b=keQn1jg5KYdqdc/kBI+WCxYb6TR6Ce0Jg6Ei4frEmKhikie2pdebGfgp656uIny0A+rtBB7hOeWVHNJry3TWUDGhZjSygtuJEvDpfx7LGEgrZlzfhx/heN+YAsTYeZVXgcTkTXYQBCeRVmjSDhaXDRG0yY7DlQItDaxC23PBU5M=
Received: from PAWPR08MB9446.eurprd08.prod.outlook.com (2603:10a6:102:2f3::7)
 by AM0PR08MB5428.eurprd08.prod.outlook.com (2603:10a6:208:182::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 15:42:29 +0000
Received: from PAWPR08MB9446.eurprd08.prod.outlook.com
 ([fe80::c095:9483:83f:66e6]) by PAWPR08MB9446.eurprd08.prod.outlook.com
 ([fe80::c095:9483:83f:66e6%5]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 15:42:29 +0000
From: Jay Wang <Jay.Wang2@arm.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, Paul Szczepanek
 <Paul.Szczepanek@arm.com>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>
Subject: RE: [PATCH v3] net/ice: add NEON-optimised Rx/Tx vector paths
Thread-Topic: [PATCH v3] net/ice: add NEON-optimised Rx/Tx vector paths
Thread-Index: AQHcxqEEGY1CHqkbuECHRHenL0iD7rXTuKzQ
Date: Tue, 7 Apr 2026 15:42:29 +0000
Message-ID: <PAWPR08MB94460AB72013149B1E1CFB66BA5AA@PAWPR08MB9446.eurprd08.prod.outlook.com>
References: <20260324162525.4083381-3-jay.wang2@arm.com>
 <20260407151225.1416270-1-jay.wang2@arm.com>
 <20260407151225.1416270-4-jay.wang2@arm.com>
In-Reply-To: <20260407151225.1416270-4-jay.wang2@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB9446:EE_|AM0PR08MB5428:EE_|DB1PEPF00050A01:EE_|PAXPR08MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: ed33bbe3-c0cb-4c8b-8108-08de94bc6bfb
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: 4UqOhBp/+QxXPO28qhCrckSRqQQreTtb7HEjp04DlLElmVdstUdVak7q9qshFYNYYDMb5ULmdZFk19z1rRg5MORy6DLLXB1eYJIOrWlsThoMPHkgvaiXgUjeTJltYR6m1w2PaW/ma/8KTQgbKt+pXAVrCFPIZyoncDV56QZIktLAmFR+FqIIiFCo4OOaFy4YTWg9zNtxBP6W8TeQkc4OMBBqphFvzJc+e53+mHTNocb7TJ4L3RgImHgMRtjZlEnnGKxzzVCu47QlUzqCzTEf/E6LQZprP4wbR8IIvPdVMSEpNT6bGia/enkGiN9moy7wUtTWXGftPk8eMvRpAWjKHmUEIfarFRqwEAIr37PALNiHz22QP2KyOuqRtGz5gBdQDiFhkb+7hXZ3V93rtjzYHcZZFms6JpzVP9UxfySVUgPN4KoXUCZd+DxeKj9lPbFinc4jnY5l18RM7mp0llHbRnwl5reLQeWtMRs2mLhJJ+xMCaWb+wrinKAUS6allL2KQqIneo/C8L8fQAtQBJCyHgtX5skEpxtYDYIhfCniMtmaXNl4tZtAlsbwvu6DmPgvfULa4nqEovkxyvC1AmADxFiBIG8AIRL7iq0MDYnOOTYDXJQN9tizN77c9mHUK+qc+qPM2he3Ejnqk7B8ZrdjHuXSLFPBiMGpCZbpAPWhCwZe9wZ/BLfQiwW/FyHUZhwOecfYKzrSqMwfXnlGt4M5GOatcDW3nT8oewECCwDo9I3jd8s2GgikWD34HnYhlSPs4M4lyeDigHvMI31RRO6jPsWrT0Z9VKf3XI0Kv09T5hM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9446.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wFUdGml5w1W1OeLrXC+6Pe1FdZy3LhoMIR7H6eS+X0bjZnxtozNilsfeNZcRrDOtYqNfXVBO9fdQQISgFB1zYEpRfRNZk3IFhmbZIbEq/C8Oky6aKbtRHWZ+d0IOrcybSFRk/7LT1UDmql2ccapq0RcIrnsY9CmODeCjRByL3NUn+d6wMNrZ9WICGITmpIiKvR8D6EiIMPDskHpe4zm4/fq7ldh8IIB1qLqed7wYPUCvEHVFLCsknw3h5YtPirULOuiYyfBJRrWy8alsZdktGwshdkNh+++Vyp0UWa8AKSV4HtSzmCSJVkJ9DXoeWK5QxyyQZt+YMJFrx7QP0ewkig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5428
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3f8eba53-3b13-450e-c760-08de94bc46d4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|36860700016|14060799003|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qJS6jFJMtdu+T0CcMzvqDlV3hElGHz2MLZuYZO9XHPD2Ww3D6attfCnyy1M1r45gwVamedn3dagAbIr6I4C0btxkkh4OW/sbq6o/y679Nwba9Ely/ubtDb+ScTxKvqNPMsIbdDJJDkdWu+skT4/DpnrSdXDCBiGNMM3oq6CA9oBHm2n1qUjkxBRtsP0+TXv5tsezvv3gQmYaARxBVqeoGPI6Faf1DCeafjl0uN3SjZaxJbJ/egwSrMhlNGYc1DcdckDcrI5tdE820PJTcs2wIKDhuJVaI4GcXmmNwX+oWAVeAr2418qqb4orGnCsaX+6pYwC1eKEZjxQqAvMJlfxnyDW+wkgMfQw/WJ0k3NKAkZc8j053iQ9c6EEucoer2SGR4tugFCm8OWxZudM6w2AjPdrSO85Xp878+l7Dw7Wsw+gPh+Y1bkggBevzOiesEZ14f4xtIkOZQ/dlDmFgYifeALzBQTymG9nWNZRJsMYMTqmqNawEc+2YRK5mdajncWhrJKxopggP9ugGDjSZ1DGIUWgV2rD1wwLPq8zXAvCCN8BrSBlPSb4gQ4IdqHHn+0mpbGyi10h2h0azcBRmlW2Ff+p/VC8X0o9txyfmtknPLfCEjCZPamG6zqZSWfehlK+HGrxB9A26/Fn8KekQEZU2UG3Qsgc3Y8Q0rvFeLXZCY7Vlvk6maOhH+4yj4w+4G/sMGWGsZcI+MQrIUD8mNXn/OLHMpREcuNbPqZkOD7UtRSfEAESHHu4RrdRmhVgA03C+0+hjzxyVZ5rHcSD6YHJMw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(36860700016)(14060799003)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LTg93zH8MMBlAt1pxds494ESXpl6j1/0/NM1KbGX/dYADNThxC0DvF2z2iwrMEGGfkubekYzoeM1N+KCOc6EG7j2ezL73qunmITpJbd+8+0utyrgruhn9XteU0mUgxz+vwYm4sNK/oBxNGjNBmdJ+dKDcgVZTwwbd995fmdBFsOgM6N1/Q/s3KLXzq4LdtOpoH10t78/Bk7u7xjTC3aN80dCocNoYXHfOnWr+g4UFkh38eq0dmifDGRF8zTkSxkOKAUzZiZGSehQJbpgc2+2JwcVgzKWFcHyW/FqzfcGCyXfgLFhAP0SGGjHgpYeFCSwp61hk3DZrjHKEgcBsuNtRqEB8RegrfmdNJvk13XYhvAknSAo1V4m8SXtyfAM/ETFoVuJuabi3SqkXzCkl1VRHcI5ovr3YLWA4DKeYa0yhoUdWYOE00P2FFuUasAtsRZG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 15:43:31.9045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed33bbe3-c0cb-4c8b-8108-08de94bc6bfb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7671
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

Hi Bruce,

I think it would be better to restrict compilation of the vectorised paths =
to AArch64 only.=20
So, rather than modifying the intrinsics as I proposed earlier, I added an =
extra check in the meson build configuration file, as shown in the followin=
g code snippet.
Could you please help verify the patch again? I also did a sanity check by =
cross building DPDK for AArch32 on my local AArch64 machine, and the file w=
as not compiled, so no build errors were reported.

Sorry for duplicating the previous patches on the website. I've marked them=
 as superseded.

Thanks,
Jay Wang

> diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/me=
son.build
> index 293577676f..a205304c89 100644
> --- a/drivers/net/intel/ice/meson.build
> +++ b/drivers/net/intel/ice/meson.build
> @@ -33,6 +33,8 @@  endif
>  if arch_subdir =3D=3D 'x86'
>   sources_avx2 +=3D files('ice_rxtx_vec_avx2.c')
>   sources_avx512 +=3D files('ice_rxtx_vec_avx512.c')
> +elif arch_subdir =3D=3D 'arm' and dpdk_conf.get('RTE_ARCH_64')
> +    sources +=3D files('ice_rxtx_vec_neon.c')
>  endif
