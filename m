Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E57606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=S+8coZLQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6E8B402BD;
	Thu, 26 Nov 2026 09:47:26 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 6A72A4027A
 for <dev@dpdk.org>; Thu, 26 Nov 2026 09:42:07 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ7E41q654980; Thu, 26 Nov 2026 00:42:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
 TJP9BfAUy8vBKtinXNf/6Zkp7KumIouuPMW4t0PmWU=; b=S+8coZLQqQJJNSB3L
 AUR7nzS2X7LKlivyTm+lCnm4N1ZX8rnWeHqE7Ji/v5fVmDYW+1jMzkXjDzZbcGHI
 w3+kGVEbasl0oTlUMPJcPoYNYTma8RKsVpH0pJ5jpF5Oe4aXoZqgBqolSVmQT6OU
 mFV/UHGAxZPe2GMF7iCPdrrZNnsSky5OLddjdvc4K5zXYezKzsY8DzxoVTuHhrSh
 p4j4eg2bfmc2+QUZIsBuRWxciRGjj/tbDmNvt1ga9fYRuprixb7ULrDerVTc+xRR
 XwJ8hBJ/lwX4nHMFMrZI0HdnT4RzUv6hzZPDupwANiMs5RhEMCegGPd1mShbXP6K
 7wD5A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4j5nhg6qb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 00:42:05 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Nov 2026 00:42:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Nov 2026 00:42:05 -0800
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id 136373F7072;
 Thu, 26 Nov 2026 00:42:02 -0800 (PST)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <kai.ji@intel.com>, <anoobj@marvell.com>,
 <gmuthukrishn@marvell.com>
Subject: [PATCH v2 0/2] crypto/openssl: fix DES capability reporting and
 provider load order
Date: Thu, 26 Nov 2026 14:11:59 +0530
Message-ID: <20261126084201.1173287-1-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009112543.1766727-1-psenapati@marvell.com>
References: <20261009112543.1766727-1-psenapati@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX//7IQd5wn/lg
 Hza4VNjZ59OGHTOUFdUUUJPKBnpfB84qB5COJEg1jYbqCPG/LHn4klRluIIyIWSnDw1kopZeonO
 HJO7lGCTu6Cyu1IblvaKSyAqxVjxX3nuI4LHI9OIzT0qoe4cx5nEdF47v4zIudrCs28gebvNv7s
 VlLXy+aWWSKlo1EgdI1zENQ4be+IKvpgTI73wiPxnlGwMjtaI4D3GqjybsTeuM5XzQCn4cQMmyv
 E6WFE8OXaoq/8T+CQn79q9YFPHWaPbsPweQs/NXYEMLM4/W/suSBxUYOx53UR5e5WG7W3WzBIZb
 X2z0FYQuxB37DB0oWI6JUjRQIFpK5E2tqJNAa8+1AMkmqxteFmch5G2huNGWBQUawHBBeBwxxZ0
 b4E/1pK1r5KPkyiK3ZJsbjoiOaY58eA2q7I51pDTw9MBNwS0f1G0aDIZu5rA7Fk5fVBueA3oGHo
 bCUWEJbL01fXbsUn16w==
X-Proofpoint-GUID: tBTvVfTca7KXXDarlnHuUXjIuglUJIro
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX8RfyCMwYy7P8
 CGiJdjv+Wt9I4PYbB+cn2Bjg9q1Mw6dLWr1Xf6gVbkXVlOWUGRzoRw/RwAudrTOAwugYNz60Wzt
 o7jTCqFRY+UPX1cXSK1Li/7XjWVF8F0=
X-Authority-Analysis: v=2.4 cv=WtC+otfv c=1 sm=1 tr=0 ts=6b07f0dd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=6wBx0SAgHNgGQR0PF8cA:9
X-Proofpoint-ORIG-GUID: tBTvVfTca7KXXDarlnHuUXjIuglUJIro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Mailman-Approved-At: Thu, 26 Nov 2026 09:47:25 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

OpenSSL 3.x moved DES algorithms to the legacy provider. When the legacy
provider is not installed, the OpenSSL PMD still reported DES-CBC and
DES-DOCSISBPI as supported, causing runtime failures.

Additionally, if any OSSL_PROVIDER_load() call fails, OpenSSL disables
its implicit default provider. The original code attempted legacy load
first; on failure, no providers were active, breaking AES, SHA, and MD5.

Patch 1 adds openssl_pmd_caps_init() to filter unsupported ciphers from
the capability list at device init based on legacy provider availability.
openssl_pmd_info_get() now always returns openssl_pmd_caps_active directly,
removing the fallback to openssl_pmd_capabilities. As noted by Kai Ji,
caps_active is always populated before the device is registered and
queryable, making the fallback unreachable dead code.

Patch 2 fixes the provider load order: load default first (required,
fatal on failure), then legacy (optional, warning only). Provider load
is moved to the top of cryptodev_openssl_create() so a missing default
provider fails early before allocating device resources.

v2:
 - Split into two patches for clearer separation of concerns
 - Remove unreachable fallback in openssl_pmd_info_get(): caps_active
   is always populated before the device is queryable (patch 1)
 - Fix provider load order: default must be loaded before legacy to
   avoid disabling OpenSSL's implicit default provider on legacy failure
 - Move provider load to start of cryptodev_openssl_create() before
   device allocation; add ossl_providers_unload() to init_error path
 - Rename ossl_legacy_provider_load/unload to ossl_providers_load/unload

Pratik Senapati (2):
  crypto/openssl: filter legacy ciphers from capability list
  crypto/openssl: load default provider first legacy optional

 drivers/crypto/openssl/openssl_pmd_private.h |  2 +
 drivers/crypto/openssl/rte_openssl_pmd.c     | 43 ++++++++++----------
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 27 +++++++++++-
 3 files changed, 50 insertions(+), 22 deletions(-)

-- 
2.43.0

