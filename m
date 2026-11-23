Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A31606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=McbecqKj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9788940262;
	Mon, 23 Nov 2026 07:13:10 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by mails.dpdk.org (Postfix) with ESMTPS id C5006400D5;
 Mon, 23 Nov 2026 07:13:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ9TiC4f4S0sydIuHp+5Yma0Sq2kchx8Uq+95g/lxGAY9F78/SA4wqwG6q7GmayD3gFhE+VCy20fEBCnz2cOqAZMnoENQKLVbcUAudRgLohGgvZT5VJk+WktYHx/7qIW8Pw6K5a0yzmKrjZYvntxb3A2iDHdhol07X/lPBJQhCEnGAVhnQKe6i4fTsAehXAK60Y6Razd5JuUPX/8WacTpdlKdFQyxyu89+wcd/xT6Z2d06HvUtXCYK5eTrHMuC0sw5ZQ1LrivUNOuRezQAaKyXIP2qX7xW5MSiza3sogrunZIn9f5yiSx6qGpaNnC5o3bDFkG7cC6NuI4EbAMNMZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRa9e7EIf+UcbHDu2mlu4RAPXexe+wGSNNRLGSxZlwA=;
 b=DVVrRa5Dhy7Yuu1sXAAwNt9GZiCNqF/cIZis/xN5AUOO7Ci0QTs5GUt+xAqM+RgdT7J6L4wY0enq22SfAqSYQZFgRGuOzvdx5F24W9Eo1imh6NDmNnm+GOj6VMWop1cl+NbFYzqg4k7YOtzHEJfH7bEraStJrWQSlJ5GBzIE0taOYGcQHz40UvOh3ze4rQ/dK0FQyqS31fJExQGAfzQ+fFY51MCUv5+wm93UrPIky1xLV4p9E1HBpqG0UJAjkZK21NgUJEPzzasHmWPdo+U8X4rDGEBwTw+aC6jHCyPcM3uVCXxED4a06sTjNMzqdQY6tDz9jJcqbyPLwXm7N36zMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRa9e7EIf+UcbHDu2mlu4RAPXexe+wGSNNRLGSxZlwA=;
 b=McbecqKjkZ/AEoA0aJBCXCoVpiWmo0Njfh53iRlw9ZZRQ3qDvCxJXwp57XuJq/l2/cMdy4emEacqwmfnF4DzksSqvB9lMP1JAb7rxkvXIzCscvB8hdlNk1wA3FMt//cVw3CYNMXXizV3p7V3rE+/VYW9O1Eno+bEOlXKB4BmLiOz5xP/F435HctvZIl0xIdqb6z1IEe7SZIJZYEKZ8xRhc07RJA95GLl4yvrdR93ud8hrcPB25LiaGfXhXHnk4EE+MbmDBDt/FSiG0MCkN+vrzFz/IUHPSOFmvIsvkmOd4v2cgCSYTmiauqmM+ZwnTtfxO11EnJk/Ru4ZIv8xHR4mA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8131.namprd03.prod.outlook.com (2603:10b6:8:280::9) by
 SA2PR03MB5929.namprd03.prod.outlook.com (2603:10b6:806:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 06:13:04 +0000
Received: from DS4PR03MB8131.namprd03.prod.outlook.com
 ([fe80::5759:ab24:f49c:ac71]) by DS4PR03MB8131.namprd03.prod.outlook.com
 ([fe80::5759:ab24:f49c:ac71%7]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 06:13:04 +0000
From: Cheryl Bansal <cheryl.bansal@altera.com>
To: Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Cheryl Bansal <cheryl.bansal@altera.com>
Subject: [PATCH 1/2] hash: fix maybe-uninitialized warning on minsize build
Date: Mon, 23 Nov 2026 11:43:18 +0530
Message-Id: <20261123061319.163645-1-cheryl.bansal@altera.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DS4PR03MB8131.namprd03.prod.outlook.com
 (2603:10b6:8:280::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8131:EE_|SA2PR03MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: db09e1a9-be3f-4b6c-2fa6-08df4928d588
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|55112099003|18002099003|260925022911599003|260925021911599003|260925021311599003|261009223027099003|261021121427099003|261021123027099003|261026140227099003|261102123227099003|261022075727099003|261022105027099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: eyRdbIEdDG5k8GcR3C01HP+8wn7OirHZ435l031PctBiHiZularBDsZwD59fV9pcES37tI689FQIGywBJD+48HMh7Tz2NXhPgj+KlTnmBjda9M/gwgsIYgVOo3AhCWO9JWAgsAgcDM/NTyrkc+yAlqW82X9XvJRIUZEV+GZK8e2v+oXHgcbM77m6YFjoybqQBxTpqYS5/DtFwKF4elVfv5s/SeP4ZdqxY341VB+Gdnu+ueSwHyQ3LnAID8ItnS6Z3r9UP2rkaBsf21owuqQGGviHH+HGzRu0V1+VCd+mdNBJBosIuH5lnSu5/bYZFeFOJCJTb6mZkwHrpgiUbe4EcSs68N/vo1KPTz3Vwz/hZoYgnqux43UkithXxJdKafTARMXbwYsWDWlaYr4zkS057Vs6nCGLzCpCdjtK5569kMDXC1t0IyD3NZcv5So2rXnpyfusBO9zWWewgD4LYxdVde5pMrlXd9i0TcD7Cc7DXozsiAaMmpTGQ1DM+bhUN98bXGRuw+88StidEg3Y2u3Y2b9i0M7In7ZLvQYf9f7B0qJ604GhfE8t8B3szagRmzW6d9a219NkTMbjuAQkKLeZZaalptqM2tKmJ8faZDfUXIH7T57meiz65make94/XLcLnVf68gXIDgv6XC97fACz0EeudsU+6ClET8ZVPstQ0X4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR03MB8131.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(55112099003)(18002099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261102123227099003)(261022075727099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pzXlr5QfJI7a5zULl6vLf/0h/SYoYUHX1mSpUQsfs8MAkAq/owLoyUL//V//?=
 =?us-ascii?Q?bImg8liqQ48/F3TCZydJDBwRD9TRJzYjMvjdJTeNQVbgks4Opc/GjgvPoWWt?=
 =?us-ascii?Q?PSg+lNwtk4BBWP6q7d1sH2SiakT9cHt8iu2D/8l8OnDGyDj5UdYcUdXzrXcm?=
 =?us-ascii?Q?0bcEnRklzgs0j+U02e5nQkFxs4r4NoOqzSk47s4fuAXnB8Qkfw58vx9UtVA9?=
 =?us-ascii?Q?rDzEtwSWecVayWu4rjaLv+XE9OcosVuImKw3aJEGDzcMtcssP35NOJ4vGqA2?=
 =?us-ascii?Q?8fyCUxlragBIdnR0lrhX0Ua02sSqnmVjHx6Fx8BgYcxmKg5IlHt1yU1robS4?=
 =?us-ascii?Q?6RbM+yvsMf5h2bExOL/LqHz9X5hDSdnRxmxr2x3lBel83RBYR49AdyztXc/D?=
 =?us-ascii?Q?AyObHg063aNvtaFweBByKFUunHDb23ENXgn9IY99EE7Hz+CWJEUR0iKhlUvP?=
 =?us-ascii?Q?RT7K7xRyt0roE/dZRLBfBV8BP8IzZ/ef5OwKZjy7zO91aaju8IxQ1ANlgRDe?=
 =?us-ascii?Q?JMeuPCFQH5+mUp4zVs3hT/OHpBJVDXYucgEwqntxm2IDdMsxFNxsUV2v8its?=
 =?us-ascii?Q?OFJwmIlixpC1t2mYU7cNI6jNmE4iD+BK5uepr1NeYJvSbDAdYUElu+jTz3rQ?=
 =?us-ascii?Q?7SC9p3H7tFPtWxeREDPTM4Z1LxkBHZaWHLRsGee2WqYnc6BvcYkzw+FRYiEw?=
 =?us-ascii?Q?LNWzVaV+tgSYAKPN3WUEV3Hf73d6uEwsYmSQbxIXQ0F57iCpgIJwamcuaIbG?=
 =?us-ascii?Q?0adTCKqjyhLjuRV/NrcW+LFQv2rHryy9BPWwte5USbUAfSEz2pzT5dcvg0gH?=
 =?us-ascii?Q?5Jvvjhms9ufph1XYcRcv38ouPTgGDri9vd4mJPDEqMur99DD7xekKM2m2dzH?=
 =?us-ascii?Q?Ja1hTPcVDfjlxMfZJv8ilCJJzBahsXUdJ8ApadVvTjsU67jGKmLEdHiIogq7?=
 =?us-ascii?Q?rtpGFasZBEQNbqGubx6DPWpr+VOsjiidpQ8XVrWk/RZkMf/CCJ45GvdsrQ/v?=
 =?us-ascii?Q?tQJ/+rmg0iSTAeddXdnV+tx5RQXoWE7qEC7kNLqlsAY6E16JAAFN7Pp1Ad/o?=
 =?us-ascii?Q?HExcLUFdV/moy5Kek8AphcG6N3ymlp2tbY/tKX9QLK1Wn9kYKh+wCYBckwCk?=
 =?us-ascii?Q?BH1+v5zspjiQdCk0MFOpwMJ/hhBWajJlU4uhgWLE7S6DKuiS68LFNP5EjKOC?=
 =?us-ascii?Q?5dd+PFkHP8J9NHUixFa35TFNky0P7ezChcLhdp279lCoBdJgr1ll0t3zp0g+?=
 =?us-ascii?Q?ULPtyOXMhQudoYJKCOnq03QqmE8lhsW/GbpmyVQf9ApmrUNdZqYyMNz+CJar?=
 =?us-ascii?Q?XLrHEGmb249yIsCfRq90wStgRcdcpfOcUWK3Ro0ztTAaeN39xvo8rWfp2cZN?=
 =?us-ascii?Q?yJSrqrDX3Vrik5w9Kx947W0Dh7/hRPqEkjgHFd8b88OUaSuhEi+dMgMyrFXM?=
 =?us-ascii?Q?qeR+LFI93RI2fQRf7ZUHkUrnyxw37A7eZU0Uwb5qU17yn6M3NkyV9BFkH3Rv?=
 =?us-ascii?Q?OQguslqjkjrHcKXqPe1jjHGgfu+tvvHORlDLRKgEhynoWclhSORLdjNmOhEV?=
 =?us-ascii?Q?EozrAVjDy4Mje+lbSVOYENRsyyY9B9lm7Om2MsQ9VwKuXhfhjbrOopjAwaIQ?=
 =?us-ascii?Q?blZWLi8qDuLA1ss14nFW7bEh/YZYAuokaPNlZskvuiYeVHD+Tu95s80mtSSC?=
 =?us-ascii?Q?lcUlLBjkfkQllIP15WA6Mav1yCC5EjzLoQlJjJhzI0XUw7weRl3Ts3zH37MY?=
 =?us-ascii?Q?t4SmPoppQw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db09e1a9-be3f-4b6c-2fa6-08df4928d588
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8131.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 06:13:04.2453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ij81WgOFEUPbR1aakwV6wmNrYkuNN4dn9s8GFZP/5d0eeClLLcCBdmMubvVYvJuR724hAFjGGTToYAIm2bWOOTwLl3pQ++oxqN1xv6u4900=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5929
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With --buildtype=minsize and -Werror, gcc reports that slot_id may be
used uninitialized in alloc_slot(). This is a false positive: every
path either returns EMPTY_SLOT or assigns slot_id before use.

Initialize slot_id to EMPTY_SLOT to silence the warning.

Fixes: 5915699153d7 ("hash: fix scaling by reducing contention")
Cc: stable@dpdk.org

Signed-off-by: Cheryl Bansal <cheryl.bansal@altera.com>
---
 .mailmap                   | 1 +
 lib/hash/rte_cuckoo_hash.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a0096fb97a..5146a4fa2b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -288,6 +288,7 @@ Chenna Arnoori <chenna.arnoori@broadcom.com>
 Chenxingyu Wang <wangchenxingyu@huawei.com>
 Chenxu Di <chenxux.di@intel.com>
 Chenyu Huang <chenyux.huang@intel.com>
+Cheryl Bansal <cheryl.bansal@altera.com>
 Cheryl Houser <chouser@vmware.com>
 Chinh Cao <chinh.t.cao@intel.com>
 Chintu Hetam <rometoroam@gmail.com>
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 5d495ae973..47ea909d38 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -1298,7 +1298,7 @@ static inline uint32_t
 alloc_slot(const struct rte_hash *h, struct lcore_cache *cached_free_slots)
 {
 	unsigned int n_slots;
-	uint32_t slot_id;
+	uint32_t slot_id = EMPTY_SLOT;
 
 	if (h->use_local_cache) {
 		/* Try to get a free slot from the local cache */
-- 
2.43.0

