Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B4EEA3C22
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 10:30:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3514F402D3;
	Thu,  9 Apr 2026 12:30:54 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
 by mails.dpdk.org (Postfix) with ESMTP id 1117C4028F
 for <dev@dpdk.org>; Thu,  9 Apr 2026 12:30:52 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=J/+UBIpMJEVCKiVCBzmzzQxhnstQ/M6A7Z9eLYUcmWvfk7x98mls9eMeQUHyCOoKten8Jh/T1reGOZz0wVJjf6QAItMm0A1gzzw8gOR/q/pFxB5Msz9uHDZwGNDeuaJT7H4rXPEwiYs2T/V+UnWRJRT7x43X8a5DzJdiZgKOdTFdn6k6bvfwn7EWVGp6f6Np6z7C/Jj1HaJs1FE7qXAIibRTjHSGygfB4DiQ/qQPk2kV39Yf45YTFLwf+5WUxgWM8CtYlr7hRrmMOpVk9YMmXbhLcNCCGq0J1IlnZ3XCVyfKuAHmcxhKjj+ShBhKdxtiuohUPyya5wukgcmBNU/iGQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tehxa2HGFlhgdsx5B5CALgMrl5Eg3/c8fAZ0J7rbzj8=;
 b=iLdHqOWGUYhUiH8hvFf73+B1wVMMlSDPSqGTtWTFx0txiQwQLYhmWJLPIUlbgafAWJfpb+M/Fk/uV2zdmRdYZZrjwBh4SrefT4lzy6WHTmFjO7leVle/gb+YPLY6YP9dxZwxbwJqlx/wB6VCc2co8LMXloSf3psTXVr7FynQlouSRe4B3lK9ZQXr83DN5HO+vLZBvV/OOYv9OdOZHWG2XnsbopTCqlpgid2Bk3nmf3maDQThDqMOa3GCpFGZQ0v3/v48YT6l8oZbpYWTPUuwwx1riRxOt/sfWp5RZPmdCe2VtQQ5+8r25X036EQzJAWD/eSfWp4Mdc9D4TQI3iRU9w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tehxa2HGFlhgdsx5B5CALgMrl5Eg3/c8fAZ0J7rbzj8=;
 b=RmzNviKFCY49/VnOZpQqtdsM3w1lNYoE2cxZPk31H5GOyCsOaM86gRqnOir+V9o9pEjF542VhcZaEQIeUZm/A48YAmPPxeaBMRMvhjp61wtv9BcSWjq1PXUV3blpcjtnyNqH5y8+7ahPtQSKe8t1FX6qaqQF1ilu9xGalDZuoCs=
Received: from AS4PR10CA0028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::13)
 by DU5PR08MB10437.eurprd08.prod.outlook.com (2603:10a6:10:524::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 10:30:50 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::c7) by AS4PR10CA0028.outlook.office365.com
 (2603:10a6:20b:5d8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 10:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Thu, 9 Apr 2026 10:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqiNv6IDqOWA+2pXL9mpmDLd2g+1UJ6w/n885jGMFd5I/a8O3NonWEYZAImciZSYpDr/qiP7ynZhPGFAYdDlKD6EcQlhe3N/TdBdVIewUCg2JpaSqXX2MMhGVeWY3WLR8w+I+AR89prSpEQkqthepP3VPd04Fhwxeo7Z/tH2A5ZQgRWt/CToaryklyeUfMeO9SbdrY2oL89jaZxX6O8tHvsns3hABfOajCqef0iSuJsoW9TPpHWV0KBDxDEsH+SUO/6gFkOQZtSpk76mZ1PvPmkyW0aVLunozsYUgx0/nimc8Olpdxk05vcPapSwMKvq3DSn9HcuEcfXuvBI4Jjovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tehxa2HGFlhgdsx5B5CALgMrl5Eg3/c8fAZ0J7rbzj8=;
 b=KcnN4g4bG0L8P6c+8eA/1m3BbeqAkcC8eOQ29KXbirs8rjjJyuNvA1VJSSysZPPCT/v8p8xbtoFmgI/Ckg0raKdRHwXZDV+n5yFzVv6KG7mO2LhtUOmoiE9vPByVdirB+tOpe1I/U2wxDDCqR3ZIAiHN3+Tgf0kGmYMRQWvpK5zRaHnYwIz8Uv1c2kZls7Vo6tC6iuqsCQeNUld4PiuCom2htUtxUfrqioH8GUwRqZOG3eNcAIYNUslE+jM4MvFtOuWqXjBDDNjvVUltKzfGnoSAD6oDKnC8dmhXMhSk4UW3hZ1rACDYtlokdeI/DFKpkgbkEWoJICxRZ3mr7PRnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tehxa2HGFlhgdsx5B5CALgMrl5Eg3/c8fAZ0J7rbzj8=;
 b=RmzNviKFCY49/VnOZpQqtdsM3w1lNYoE2cxZPk31H5GOyCsOaM86gRqnOir+V9o9pEjF542VhcZaEQIeUZm/A48YAmPPxeaBMRMvhjp61wtv9BcSWjq1PXUV3blpcjtnyNqH5y8+7ahPtQSKe8t1FX6qaqQF1ilu9xGalDZuoCs=
Received: from PAWPR08MB9446.eurprd08.prod.outlook.com (2603:10a6:102:2f3::7)
 by DB4PR08MB9141.eurprd08.prod.outlook.com (2603:10a6:10:3ff::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 10:29:43 +0000
Received: from PAWPR08MB9446.eurprd08.prod.outlook.com
 ([fe80::c095:9483:83f:66e6]) by PAWPR08MB9446.eurprd08.prod.outlook.com
 ([fe80::c095:9483:83f:66e6%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 10:29:43 +0000
From: Jay Wang <Jay.Wang2@arm.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, Paul Szczepanek
 <Paul.Szczepanek@arm.com>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>
Subject: RE: [PATCH v3] net/ice: add NEON-optimised Rx/Tx vector paths
Thread-Topic: [PATCH v3] net/ice: add NEON-optimised Rx/Tx vector paths
Thread-Index: AQHcxqEEGY1CHqkbuECHRHenL0iD7rXTuKzQgAAMzQCAAsHwgA==
Date: Thu, 9 Apr 2026 10:29:43 +0000
Message-ID: <PAWPR08MB94468A2F5CCC2F889EB8B5CFBA582@PAWPR08MB9446.eurprd08.prod.outlook.com>
References: <20260324162525.4083381-3-jay.wang2@arm.com>
 <20260407151225.1416270-1-jay.wang2@arm.com>
 <20260407151225.1416270-4-jay.wang2@arm.com>
 <PAWPR08MB94460AB72013149B1E1CFB66BA5AA@PAWPR08MB9446.eurprd08.prod.outlook.com>
 <adUs_MMCPqx5HpVD@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <adUs_MMCPqx5HpVD@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB9446:EE_|DB4PR08MB9141:EE_|AM1PEPF000252DF:EE_|DU5PR08MB10437:EE_
X-MS-Office365-Filtering-Correlation-Id: 1659858c-6279-4356-690c-08de96231024
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original: VU4oJsZgOwss9ftPoMrxrT4/PtkClaBsrx8G31S69XlPoxjqwMs2AcprR6XNG1DepT3fZvbz4F1ey2cNo3KI5XxFRidRk+pjgv0Tgr4qtENNF4/7ep2id6d4rhqTd6sI+hTc/9CwpfXoq/0RLMArtmokM7y3LjiqVR+xvIXbxlKdblAAVsO4xe4WyQh3r3CaCqQ2ksyetc4QGPIxLSdl6oqKzhdibMMusPeos2Qhk1w6JHm65bASVwhvrfOHS0ysHEcGIzGz1F4HGW7kGJeaOKvc3z7tbB3HTBBCsXV/UF6YKfkpbp+QKEhDQe/0+qE9lXZbQkuRVQZf8Cj9HWunFmYmfVBR9QHgdkr+gbb12Zbff8af7MrL+qmzm67bShd6JKK2i4ay1YNBHDjUEG9JolF0jN02qo54sNZsjCP9yzkcYRzqjjvwKkLo+cWMAN0L0WmaCMkdfT99XXIwABry+0TxTfLYe2ByNvkgB5Wmzx7cG+EGCeqbR1vNtXyzyP2zhj84V5rV5p+d+jGK1/lqIWgkEdyWwFP1n99iiLk1dhFr8oAHZHQyZq4WnA51Jmpj68QNZslaeA6xoWVj4HTdOG3BTIeDIN48KBIwfSd7+sMuFSmaVozqoUj1rmxbsgrsSrEN0VLE3DN3IGLeny8ilccTg6/Bptl1mbrCpLFN5YIJwMLLK909egrrU2GuNbljOYE2B1ydnUt/l555EogfYvb3XuuSQ0E1XjS1yENVWqj2aC+JrK0MylFD36HwkmPeYyopyUYKtsOzrFoi8VQ0QU21w+W2JhRorKwSABxnchc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9446.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RwgkDYTMZBJZEqRWtY029uqpFH5bK51bShE8xjIpoAxda9Drp1ZZ1lYyOohao0VXcEw4Et5dEyK31drd/Iu5g7XWhTMznGhbONjB9O4hdX1XsHsiWB2spwooVaYdbVOt/+8E4njr1D8Agry3UarA0MhFmexSgrxor7OUFy2JZ91idzrzLH0331PxqzmQsgYqV+rIhCmX2gDK2pzl/9kqIN+L1KP83oTI4yzDWrNR9wi74MhHpuesQYLfYmMmcP3oNVV+AWaa9XveYBAV/tJzIZMVsJnWoiUYjug2d86l7FLCi/eZ/IpEDPW8zFJnMZicDT5bZjKzp4F4a1i63mSptg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9141
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 62c90fcd-1897-4bff-a286-08de9622e9f6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|14060799003|376014|35042699022|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: NyfnQHVdlmLqSzxj7OtMY2FLnWPAKufwbNmDSFVjwi/tYEOqqQFD7NXmeV52osZdMjnAm5BpIscOs29IWGxjsi+GM9RRVCRK7VBubG7ZQdCbPX4jPqYbo0ucIaA3vD7yMVox4Fp/Y5d4F2MaVrZ1gcoD9oFivWv1yuL8rGD7WVZirtFJDEcoUo+dXsnmYcFSpiejin5G67YHy31K0SAsppSys3BEvRDC5WawSYAVBGoqwyhPa5odsgrTpLlHuFKgbCZzyz1lNx6TW8kPsmuksgnjpC0Ovc3amMJRKj9f8uva9/yvhSxdymSgzNiZj7PHbgGlFBs1eKKwSzXAZE3PFvhXmqK3XSIUTQX6Wg+iMGiLTzEf91cRpvqmTIuBhnv6d5lp+4I67hneCfoCEMmcGF8JNU4zaKybdw7m28PmMknJr+sdluZBn7+/VWYI8nKdxuaTPvkqW7ctycPIcdPhbvY7UwR/x9VylQZPJAgflLHfWMNR9SERl6HWiMolVqaEbC7t6q6cUO1Hi5WCpjNcO2usIEX+0jswkKKGX+FK0xMwpYoZtg98JwGwOwVzfuwjRUa5tDckVqK5Z6IxZSqP33Z+p5UtgqVpMUHVQfM+1ys+mnvbQj6Z/9xcennFU/PWcqY5VW7wdselQSeVuYCWjqPXGlr8n9innUQmupWuxEI3qfAs8aeASKeBpuaz5jNsQtzxQXeYmDO2+1JZZYXsPm6nsmrJNkSiippBSnvs5l4L6eQoFk0++Qg+/d8SjM69btEpilvp67cx2dbe4fcnNw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(14060799003)(376014)(35042699022)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4ZRPZaX4fmy9gpht4k6/EoG4PX4HStyCLK1xCiW0n93aLCijm9NvR10Cr7fUYn/RfaaaNYPq2CpTtAZFdP3qvtG1NpAIlmfeUpSpnKQ2fTvdqvhSDfQZo13x5OAjP5i61USTdOObCQS37fydQKA3bLfGmeFJITtrZTiQxO0u72W/XJ7C8yhlrpiHMvpjXv0cZr4vE6hoxFqpPhoj8lzYcfLiGybwBKk/ee2GTHp7fGvpG3I56FkgSM8CLtJ8ZVBPLurZsFtX05t3BCjiZjZ9sa6lVbauGX9ZNkfk9OBfVPUwIDUdJtGYyA9AlGRjQyFeEi87LBHBbLgNEjNhpftYbeQk7bMrKN3MPPft3uj5PhlaQnZwzgcom45kDIxfAOH4YVGCWRwROBHKQp9NnCH3S4sz18lagP4kAVbKGRtIdFYrt+X8hfczfhezoBZaN67Y
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:30:47.1615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1659858c-6279-4356-690c-08de96231024
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10437
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

> The CI should run this patch through the various builds and report the ou=
tput in patchwork. Once that goes clean I can consider merging the patch, a=
nd if not, you can submit a v4.
I just wanted to let you know that I've been able to reproduce the failing =
test cases(pmd_buffer_scatter, port_control, port_stats, dynamic_config) on=
 the Arm Grace + Intel E810 testbed in my local environment with my patch a=
pplied.

I'm currently root-causing the issue locally and will submit a v4 once I ha=
ve identified and fixed the problem.

Thanks very much for your patience and support!

Cheers,
Jay
