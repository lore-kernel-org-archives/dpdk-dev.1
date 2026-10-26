Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930F9606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DAhCeUNY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11E364025A;
	Mon, 26 Oct 2026 10:00:30 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3]) by mails.dpdk.org (Postfix) with ESMTPS id 797AA40150
 for <dev@dpdk.org>; Mon, 26 Oct 2026 10:00:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3jIYrKhU5hr328+HkTyJCscig4tYPlGZf1J6cmlGTA/agnALluH/WTD9CBZ0DynuYV0vTCKMaKsVjUeTqbz3iCz3OfheJiF+opnQE9SgBlI2TAN3dL3slQPB52XPjsVVkzqxux8pJpe3+QtUN/U/bFqonTZYy+pf6g6Snjp1mcmYIJnZNTRCbQQ5GNH0BZJH2W7iF09Ububvb0A4c19L7DCXL8k0GODZfc855xbLwboLUMWPFyYOsYV+sDv/aQ1BQyQ1Yc8J2yMQbi6FpboW3lyApDA0566zfTvMo6Sk9IzbAepvYfhRHO+Y0pqj+OaJBQXwfqHmHutJe5Eu4VuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa+NOjReQ2x8/544KsL6wDs/RAAGnlL90qBvcPIivCQ=;
 b=sXmxKb5JwAYT9/znHHUD+EAjrZeMhImmQ2kM9CyzI9njLyWsWUNLv3Wt1Wbs0C5giO+x6K3S7zXl8Z5JOfyB3dc69x7CQGbojKRYTC8xeqgODn+7jmJhPnP4exRMFQaG4JWWKpWvmQ4JJJa4dhsuVRTOnO+m8Xnpna65P8JfDEifnu4cwderioW5nhvraiO2aOoJWBAFXvvxSP0mOFnMWpPM+rtMLL+GrFvR3HhYCRQdKhqNXIFjmBZF9aL5LaxtyuBoBi7uuibSBXehs+BnWMtw0Xvh8MN+C34eUs3JBo2j7O4cLlq0uTf39YLAawmqnC12YePE2x2v99oi2Z6V4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa+NOjReQ2x8/544KsL6wDs/RAAGnlL90qBvcPIivCQ=;
 b=DAhCeUNY1e+X8T7wSJ526Beu/C7WKUGgkc9uViJU+Pqn0mHlRduBdUJ0fGANTxY5JzSJT4F8U7JWeUOt64oNDIT2GYaOoJjdSnYsR8DoBs1MqM+52/iWkatli+SQBwNYxty17DmCXYpGhh0k5czn+tR68JO3qud+rRovOByz9QY=
Received: from SJ0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:a03:2ef::16)
 by MW9PR12MB999208.namprd12.prod.outlook.com (2603:10b6:303:301::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:00:24 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::59) by SJ0PR03CA0191.outlook.office365.com
 (2603:10b6:a03:2ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 26 Oct 2026 09:00:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 09:00:23 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 04:00:20 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Selwin Sebastian <Selwin.Sebastian@amd.com>,
 Bhagyada Modali <bhagyada.modali@amd.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [PATCH v3 0/3] raw/ntb: add AMD NTB support
Date: Mon, 26 Oct 2026 14:29:58 +0530
Message-ID: <20261026085958.3240694-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJFAV8xLAv6qUT9Wvt2WkucoU53=GqWK_YnrLPmFPAOSkRFa_g@mail.gmail.com>
References: <CAJFAV8xLAv6qUT9Wvt2WkucoU53=GqWK_YnrLPmFPAOSkRFa_g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|MW9PR12MB999208:EE_
X-MS-Office365-Filtering-Correlation-Id: b711c5fc-dffb-4c74-60e6-08df333f922a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|5023799004|11063799006|56012099006|261009223027099003|261022105027099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: faB4QNYsWN+hpsL11+KN5RaPFyICpJMlTvjbv94rCGE6XLB2abPN56xj2bDZW1BUc15h1RO0KsN0JZ3kSMazCbYyeL3f9xYN/osS6cqU8o5ufUE8HfDRWAz6br8kVkAu6FK/PfdFT+z5MkSL7I3W4HLtV3yzch7sHT64WyGmJqv+TfESR5dlv2HtgAqRmOJbQEsCrbQdziSuQBnzQFUaFeXKLmkivzc9u6m/Ktpu4/W+DMoj8Ei2n8hqQD+iNSjXqdINe+6UR4QoYRvy85zrDDaDOZrw8cr3Pff7Jp1YNff+M1fN/XjEsnvDLFT8dIBwv+lChyjJMJWl+Z4JWQZLMPi5arsCohpEeSaJQoYc1Q4w6FZp+XBD6/l3U1GcjKL6QmMbQKctkfqEF2Snje9NuRjXCnBVKAJYIKbfztDllLY0bURMHtlcUW1HACRho652FY4INqDORoTDnXPvqzLv2d/QTNoTzKEptptfPYwl1RbPsYNjSmyx6RhJH/QusV7XPdR+zsyZAjG0IQ5GzKbIHY07QfljGCzIfCFaQ4nb5FIJZIeczQwl8YRZJcrhIXlL7DkU1CE9n3c3yyKKiLD4fSuds5IPQAoPxjexMi8vrCNDj5jfVanhjAzSEeuLWb61s4wqX7sq+lQD+8OuYFqEtfBkfMILOdjAiIsGGpFSn4hKgWNXoWVhwwOZaX3z9Ye9jVoo8N3KowMgAD4eyrmpyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: glQcr6JaBpuKQwm9v103tcsT3EkxiUgn8YHwH+XYpspGfdLBxqDU/MLbi694fWl55z1W34dk3N3lwHEnPpemnjAoLUCNWeR7pFZs/sIhFGXGZS5Jo33yNje5iKiWYsrZlWtH9BP9sqS3XoFWS6lN7KxrbyNz6c67ShY+9MZdSveodNwoCD91zN2+lT8alXbMtbK3DeGbmVS6/vFxVNq+gPJdPdEc9+08deghXJJygq/Y8FJm+wwJ8plTWQk2+OkZ/nDOPRR1XjQN469vRjHbZ+SZh58q/GQlNi4dMjeObKuULawxbpnFsKnYpCD7Goxxs+iDBK+GNLJWIZOg4VWT+HyelJrYwjA/d12dXowrEzUtnn35zs5Fw/QNdJkIQ5It7KQlCT0zY6rihd54T6mWYFP5J+0CzQHSECEoCyhj0V9YHkS2F9dXUQtU3WPGymm6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:00:23.6850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b711c5fc-dffb-4c74-60e6-08df333f922a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999208
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

Thanks again for the review. All the points are addressed in v4; details
inline below.

> - On patch 1, prefer a simple check like:
>   #define NTB_OPS_REQ(member) \
>   if (hw->ntb_ops->member == NULL) { \
>     NTB_LOG(ERR, "Vendor ops lacks mandatory ." # member); \
>     return -EINVAL; \
>   }

Done. The offsetof() table is gone; ntb_vendor_ops_check() is now just a
sequence of NTB_OPS_REQ(member) checks using your macro. 

> - The change on alignment is not listed in the API changes section of
> the release notes.
>   An update in the RN should highlight that an application must now
> rely on rte_pmd_ntb_get_mem_align() and not the mw_size_align field.
>   Btw, why keep this field? It would be easier for a developer to
> notice a broken compilation. No strong opinion on this point.

Done, and I agree it is cleaner to drop it. The mw_size_align field is
removed from struct ntb_dev_info entirely, so stale code fails to compile
and is pointed at the new API. The API changes section of the release
notes now has an entry saying applications must use
rte_pmd_ntb_get_mem_align() instead of the removed field.

> - Even though the AMD implementation is added now, I see no reason to
> always list it after the Intel code.
>   By this, I mean that you must alphabetically sort:
>   - the files in meson.build,
>   - when including the ntb_hw_amd.h header,
>   - when adding the AMD PCI id in the driver mapping table,
>   - when adding the PCI id in usertools/dpdk-devbind.py [...]
>   - etc...

Done. AMD is now sorted before Intel in meson.build, the ntb_hw_*.h
includes, the pci_id_ntb_map table, the device_id switch in the probe
path, and the usertools/dpdk-devbind.py misc list.

> - The AMD topology definitions do not belong to patch 2, but patch 3.

Done. NTB_TOPO_PRI/NTB_TOPO_SEC are now added in patch 3 where they are
first used, not in the generalization patch.

> - The pmd_private field is unneeded, please remove:
>   - amd_hw->self_mmio is just a copy of ntb->hw_addr,
>   - all uses of amd_hw->peer_mmio involve an addition with an offset [...]
>   - all uses of self_spad / peer_spad involve a check on the peer [...]
>   - int_mask is an *unused* constant [...]
>   - peer_status is unused,
>   - ctl_status is unused,

Done. Both pmd_private (in struct ntb_hw) and the whole struct amd_ntb_hw
are removed:
  - self_mmio -> ntb->hw_addr,
  - peer_mmio -> AMD_PEER_MMIO(ntb) (RTE_PTR_ADD(hw_addr, AMD_PEER_OFFSET)),
  - self_spad / peer_spad -> AMD_SPAD_BASE(ntb, peer), exactly as you
    suggested,
  - int_mask, peer_status and ctl_status were unused and are dropped.
The AMD driver no longer allocates any private data.

> - As I was reading the documentation, I noticed that you missed to
> update doc/guides/rawdevs/ntb.rst [...] Limitation [...]
> -This PMD is only supported on Intel Xeon Platforms:
> +This PMD is supported on:
> +- AMD EPYC Embedded "Turin", "Genoa" and "Siena" processors.

Done. The Limitation section now lists the supported AMD processors
alongside the Intel ones.

> - I also noticed strange indentation, so please double check the
> coding style guidelines.
>   And, DPDK allows lines up to 100 characters.

Rechecked; checkpatches is now clean apart from the single
MACRO_WITH_FLOW_CONTROL warning - NTB_OPS_REQ macro body in a do { } while (0). The series is freshly
rebased on main, each of the three commits builds on its own, and
check-git-log is clean.

Thanks,
Raghavendra
