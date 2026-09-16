Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDD8C982C3
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 14:55:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9608D4028B;
	Wed, 16 Sep 2026 16:55:19 +0200 (CEST)
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
 by mails.dpdk.org (Postfix) with ESMTP id 71F8340264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 16:55:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=906; q=dns/txt;
 s=iport01; t=1789570518; x=1790780118;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hzg8Z5AHYV3+CbxpEa25eg7xXs24OyIdbS/dkYdupWI=;
 b=HXC18jk7sSYGA3Ux6bkppGYBQ+Uw5VcsvctlnKjaKhXHcJ+gPlAnXET9
 R9hinXUFSZ06qzchB7Jov0vrsWJ/JlgoBC1kAwB6QIomfLKRHSXPuuZmB
 wKCGEBsJaZ0vHsAeuwFXqKzskd7f4nxOSs8FL4mgAVQYKSwKMqcujBJYs
 crMDxPYCbyCIFQlLy2rY8D7P80SIQQ+sG15UseF8PinfborNXUf5CufTq
 Kdh+lZchOd+09IyErO8Chgwrmk5xAbFelLYPBBQc2IVMyYY0fmGKgn+FB
 PsVu8D7QutIuX+pq53FKZ8gB6pjy8GsqLV3inN+uqVWASeYg4CVxItylz Q==;
X-CSE-ConnectionGUID: h+ije7JhQGOssWZuSHdnJw==
X-CSE-MsgGUID: mKuPqXTyRz6Zrz7eXbmGtw==
X-IPAS-Result: =?us-ascii?q?A0BjBABkrKpq/5P/Ja1aglmELUK1MYF+DwEBAQ9RBAEBh?=
 =?us-ascii?q?QUCjgcCJjYHDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBAQECAQcFgQ4ThlyQE?=
 =?us-ascii?q?wIBAzIBRhBRVoMbgnUDwimCLIEBhH7ZSoF0FYE4jWF2hHwnFQaBSUSBFYNph?=
 =?us-ascii?q?RCFeASCDYEPEoNXkG5IgR4DWSwBVRMNCgsHBYFmAzUSKhVuMh2BIz4XgQcbB?=
 =?us-ascii?q?gWBHYEngmIjGTZ6gQlegSspYAESF4EJgggCglSCAQIBSUMOB0VTCSdBChJMK?=
 =?us-ascii?q?SIIEgkBExoyCwkYDUgRLDcVGQQ+bgeSQz0mLELJGoQooVwaM6ptmQikWoRpg?=
 =?us-ascii?q?W8MKYFZTSMVgyNSGQ/eWSh0BwIHDwKTcQEB?=
IronPort-Data: A9a23:vUepN6MLV3ZTvyzvrR3qlsFynXyQoLVcMsEvi/4bfWQNrUp20WAPz
 WodXW+OaK7bMTSketl1bojno0tX6pPSztUwS3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeap1yFjmD9k/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVzlV
 e/a+ZWFZgf0gmIsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/UtDUM7Yq8Yw8lQGnpxx
 +EjCDwLTA/W0opawJrjIgVtrt4oIM+uOMYUvWttiGiBS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzM3wsYDUXUrsTIIgineylrnL+aDZf7lmSoMLb5kCOllcsgee3bIS9ltqiQOZIpl+om
 nP87TrLGANFOeyVzBWZ7Sf57gPItWahMG4IL5W0++BCjEWfxSoUEhJ+fUe7pvywkWa7XNRdI
 kgT/GwooLRayaCwZsP2Uxv9pDuPuQQRHoMIVeY78wqKjKHT5m51G1Q5c9KIU/R+3OdeeNDg/
 gbhcw/BbdC3jICodA==
IronPort-HdrOrdr: A9a23:3H4Uk603WieV/5kpQ5V9mwqjBJIkLtp133Aq2lEZdPWaSKClfq
 eV7ZAmPHDP5gr5NEtLpTnEAtjifZq+z+8R3WBuB9aftWDd0QPCEGgh1/qB/9SKIULDH4BmuJ
 uIC5IfNPTASX5nkM39/A60V/wkwNWB7eSUoN229QYLcemvAJsQljuQzW2gYytLeDU=
X-Talos-CUID: 9a23:ceHF8mH1IzIN4K9JqmJnt08WF58HckTy62zLHH2lMkZlTp+KHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AAFB2OQ6T31kXSwL40IEpScb/xoxtwLmWEXAxgK8?=
 =?us-ascii?q?U5fueJ3N9Cz2YoyioF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; d="scan'208";a="523597246"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
 by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Sep 2026 14:55:17 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 1AE9C18000267;
 Wed, 16 Sep 2026 14:55:17 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
	Randy L Tice <rtice@cisco.com>
Subject: [PATCH v3 0/1] eal: add CPU socket lookup API
Date: Wed, 16 Sep 2026 10:55:15 -0400
Message-Id: <20260916145516.3-1-rtice@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20260915150507.3-1-rtice@cisco.com>
References: <20260915150507.3-1-rtice@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: rcdn-l-core-10.cisco.com
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

Applications may need to build socket-specific EAL policy before they have
an EAL lcore ID for each relevant CPU. Existing public APIs expose the
current thread socket, socket IDs by EAL socket index, or sockets for EAL
lcore IDs, but do not directly map an OS logical CPU ID to its NUMA socket.

Add experimental rte_cpu_socket_id() for that lookup while keeping the
existing eal_cpu_socket_id() helper private to EAL.

v3:
- Return SOCKET_ID_ANY for invalid CPU IDs and document that behavior.

v2:
- Mark rte_cpu_socket_id() experimental in the declaration, export macro,
  release note and commit message.

Randy L Tice (1):
  eal: add API to get CPU socket ID

 .mailmap                               |  1 +
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 lib/eal/common/eal_common_lcore.c      | 11 +++++++++++
 lib/eal/include/rte_lcore.h            | 19 +++++++++++++++++++
 4 files changed, 34 insertions(+)

-- 
2.35.6
