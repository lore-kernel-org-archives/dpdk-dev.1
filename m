Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3BEC79FB6
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 16:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2736B41101;
	Wed,  9 Sep 2026 18:06:44 +0200 (CEST)
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
 by mails.dpdk.org (Postfix) with ESMTP id 564354067D;
 Wed,  9 Sep 2026 18:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=3464; q=dns/txt;
 s=iport01; t=1788970001; x=1790179601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3hs5FVUT5boVHFbpOVLCap6lH8zJr8qg8PkrS40/NaE=;
 b=kOVsXMt7yFkzZ+nmutY2D3L5qSzmKRJhbU+8e5IkykOwFN4nf1ftY/b2
 EbRo7MUqHYvXZ9JpbAr+emybDhuUMshS/aNsf36QgzUq4RDAy7XaAr3Fc
 scKxrL9vPKRMACmS762/qn0CpxKAGa+k2eMSEpROtHAZ9otkZ9DOPHbVL
 x1Zbr7KIe6a/xkvYAv7veQOYA9EghAyJgvJf+pTl99vKiMrb+zLXOSUPy
 R8JNK+CAFZb68jOaXVxCTLUCZ15OiwqmyndHPHIKNzXKiIRClv8TOu3c1
 MH57LylYIVfbsZk/J1OJ1BV03VMrYoddw82wGwYZjRRBKTSu3WVKWsxfu Q==;
X-CSE-ConnectionGUID: 12jHyifSTOuIO3FgZ3myeA==
X-CSE-MsgGUID: giI2r25kSPqoLBop04SLOA==
X-IPAS-Result: =?us-ascii?q?A0AmAABUg6Fq/5EQJK1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?hc/gVVCSYxylT+SN4F+DwEBAQ9RBAEBhQUCjgQCJjQJDgECBAMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQoBAQUBAQECAQcFgQ4ThlyQHQIBAycLAUYQUSA2GYIqWII7AzcDw?=
 =?us-ascii?q?X+BeTOBAd1HDXKBZwELFAGBOAGIPYUjdoR8JxUGgUlEhH6CH4hpBIMulCpIg?=
 =?us-ascii?q?R4DWSwBVRMNCgsHBYFmAzUSKhVuMh2BIz4XgQcbBgWBHYEngz8jGTZ6gQleg?=
 =?us-ascii?q?SspYAESF4EHgggCglSCAQIBSUMOB0VTCSdBChJTJgsYDUgRLDcVGQQ+bgePI?=
 =?us-ascii?q?B+BZnKBD4ITRBGTJQGyXXGEKJtghXwaM6ptmQiSE5JHhGmBaDyBWU0jFYMiU?=
 =?us-ascii?q?xkPjisDFtAVKDU9AQEHAgcOAwuBaJF+AQE?=
IronPort-Data: A9a23:Ys55eKxt6gA6989sZw56t+egxyrEfRIJ4+MujC+fZmUNrF6WrkUBy
 GYWCDqAa/iCZWb1L4ojb9u2/ExQ78KBztJgTApt/1hgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCKa/lHyYuCJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 46aT/H3Ygf/hWYlajNMsMpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJBhsP60J++hMPUZT1
 NtDBj8/NRWSisvjldpXSsE07igiBMDvOIVavjRryivUSK52B5vCWK7No9Rf2V/chOgXQq2YP
 JRfMGQpNUidC/FMEg9/5JYWhvupjXTXeDxDo1XTrq0yi4TW5FwtieSyboSNJbRmQ+1an2fCv
 Dib/F/BGxY+HtuHkWa+1lWF07qncSTTHdh6+KeD3vJnnnWf3mAQThoMWjOTuuWwgEqzc95HJ
 09S/TAhxYAy90WvVNDVWhSivnOAulgXXN84O+478giLybfR6hyaLm0NVCBMbNhgv8gzLRQs2
 laDntfxGCZmtZWQQGiD+7OQ6zi1PEA9NWUCbCANUwIZ/t3qiIQ6lAzCStIlG6mw5vXvEzH5x
 SuDqCkWgrwJk8MP0+Ow+lWvqymvoYLIZgs8/BvaWmbj5QR8DKa+ZIu05EPb8v9aBIOQVEeMu
 HxCkM+bhMgVEZGKiDCKRs0IFau36vKBdjbbhDZHA5km8j2203uke4JZ5DZ4YkFkLq45lSTBa
 UvXv0ZVoZRUJnbvNf8xaIOqAMNsxq/lfTj4as3pghN1SsAZXGe6EOtGPiZ8A0iFfJAQrJwC
IronPort-HdrOrdr: A9a23:RPsOSKhEKvqI4uR8Kj6z7z6aS3BQXvoji2hC6mlwRA09TyVXra
 yTdZMgpHvJYVkqNk3I9errBEDEewK+yXcX2/h1AV7dZmjbUQKTRekI0WKh+UyDJ8SUzIFgPM
 lbHpSWcOeRMXFKyeDn/QK/D9EshPOD8KyumKPi6k0Fd3AMV0mlhD0Jczpy1SZNNW97OaY=
X-Talos-CUID: 9a23:UMjC7W3pwcHKBZ6Xck8TArxfQ5onUmzcwkzsBFKZLj1HR4/OTE6d0fYx
X-Talos-MUID: 9a23:mLBDNQkeXvOe4oZqOihgdnptNeYy+f7zC3s1iJIikc6cbXBLHxC02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,270,1779148800"; d="scan'208";a="841476607"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
 by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Sep 2026 16:06:40 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-08.cisco.com (Postfix) with ESMTPS id 76F4918000206;
 Wed,  9 Sep 2026 16:06:39 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, thomas@monjalon.net, pbhagavatula@marvell.com,
 sthotton@marvell.com, ndabilpuram@marvell.com, kirankumark@marvell.com,
 skori@marvell.com, skoteshwar@marvell.com, hkalra@marvell.com,
 rbhansali@marvell.com, Randy L Tice <rtice@cisco.com>
Subject: [PATCH 1/1] drivers: fix CN20K mbuf size truncation
Date: Wed,  9 Sep 2026 12:06:37 -0400
Message-Id: <20260909160637.3607104-2-rtice@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20260909160637.3607104-1-rtice@cisco.com>
References: <20260909160637.3607104-1-rtice@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: alln-l-core-08.cisco.com
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

CN20K inline security receive paths recover the packet mbuf by
subtracting sizeof(struct rte_mbuf) from a pointer stored in
completion metadata.

The size is currently kept in a uint8_t local variable before
that subtraction. This truncates the value when the mbuf structure
grows beyond 255 bytes, and can recover the wrong mbuf address.

Use a uint32_t local value for the mbuf byte size so larger mbuf
layouts are handled correctly.

Fixes: 5856f23129bb ("net/cnxk: support CN20K inline IPsec Rx")
Fixes: edd0d5f3c299 ("event/cnxk: support CN20K inline IPsec Rx")
Cc: stable@dpdk.org

Signed-off-by: Randy L Tice <rtice@cisco.com>
---
 .mailmap                          | 1 +
 drivers/event/cnxk/cn20k_worker.h | 4 ++--
 drivers/net/cnxk/cn20k_rx.h       | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..2a8b54ea23 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1379,6 +1379,7 @@ Rakesh Kudurumalla <rkudurumalla@marvell.com> <rkudurumalla@caviumnetworks.com>
 Ralf Hoffmann <ralf.hoffmann@allegro-packets.com>
 Rami Rosen <ramirose@gmail.com> <rami.rosen@intel.com>
 Rami Rosen <ramirose@gmail.com> <roszenrami@gmail.com>
+Randy L Tice <rtice@cisco.com>
 Randy Schacher <stuart.schacher@broadcom.com>
 Rani Sharoni <ranish@nvidia.com>
 Ranjit Menon <ranjit.menon@intel.com>
diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn20k_worker.h
index 6442113e09..5723a6eabb 100644
--- a/drivers/event/cnxk/cn20k_worker.h
+++ b/drivers/event/cnxk/cn20k_worker.h
@@ -48,7 +48,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 {
 	uint64_t mbuf_init = 0x100010000ULL | RTE_PKTMBUF_HEADROOM;
 	struct cnxk_timesync_info *tstamp = ws->tstamp[port_id];
-	uint8_t m_sz = sizeof(struct rte_mbuf);
+	const uint32_t m_sz = sizeof(struct rte_mbuf);
 	void *lookup_mem = ws->lookup_mem;
 	uint64_t meta_aura = 0, laddr = 0;
 	uintptr_t lbase = ws->lmt_base;
@@ -165,7 +165,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 static __rte_always_inline void
 cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const uint32_t flags)
 {
-	uint8_t m_sz = sizeof(struct rte_mbuf);
+	const uint32_t m_sz = sizeof(struct rte_mbuf);
 	uintptr_t sa_base = 0;
 
 	u64[0] = (u64[0] & (0x3ull << 32)) << 6 | (u64[0] & (0x3FFull << 36)) << 4 |
diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index f8fa6de2b9..b544868c03 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -702,7 +702,7 @@ cn20k_nix_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pkts, co
 	uint64_t mbuf_init = rxq->mbuf_initializer;
 	const void *lookup_mem = rxq->lookup_mem;
 	const uint64_t data_off = rxq->data_off;
-	uint8_t m_sz = sizeof(struct rte_mbuf);
+	const uint32_t m_sz = sizeof(struct rte_mbuf);
 	const uint64_t wdata = rxq->wdata;
 	const uint32_t qmask = rxq->qmask;
 	const uintptr_t desc = rxq->desc;
@@ -815,7 +815,7 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pk
 	uint64_t mbuf_init = rxq->mbuf_initializer;
 	const void *lookup_mem = rxq->lookup_mem;
 	const uint64_t data_off = rxq->data_off;
-	uint8_t m_sz = sizeof(struct rte_mbuf);
+	const uint32_t m_sz = sizeof(struct rte_mbuf);
 	const uint64_t wdata = rxq->wdata;
 	const uint32_t qmask = rxq->qmask;
 	const uintptr_t desc = rxq->desc;
-- 
2.35.6

