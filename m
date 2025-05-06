Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B37C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 17:41:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 372B8402E1;
	Tue,  6 May 2025 19:41:00 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 9AEBF402A0
 for <dev@dpdk.org>; Tue,  6 May 2025 19:40:58 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4ZsQff1f1jz3QNx;
 Tue, 06 May 2025 17:40:58 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4ZsQff0jzdz3x1M;
 Tue, 06 May 2025 17:40:58 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746553258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pUUbDC+5jG4/XCy9amJ98INSZUR7rPiYLuitRWXOcyU=;
 b=DcCQUC3cbN7sN5H3i/YGUQdLTazAUR+zBm/KVr/S+LrnDVIWI44VvuP43tvBHUVPCS6F6W
 lMSzNzNAJ1xZX5ApJa2rVPaez0CLcBHp1K/KXLqYisn3FBlolUSgr26W7wUhk45kh+jV0A
 9Ez29t8c9NVMnUyqLtC+PjGKJKTKH/AfPUPt7tdezR3MGaHzdObav7waSC9Mq2U7hP0AuZ
 LUFm37lh+czPmbflyFmH9NKIVRyjS4xU7tmpQ6CIAhW79sDwYHbE0v6sOmq1sWXvW50szR
 bNP/yjSdZwCtuUH5l3kxLWv47JxGT1N+/VbioBaCVS9h7nhmRpAiXxnv3deH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746553258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pUUbDC+5jG4/XCy9amJ98INSZUR7rPiYLuitRWXOcyU=;
 b=U8Z5kjjDD8kERKAwqE+Fj7lEKqFz800p8Ve2pjO/eyizWh4rqBOL+t/kZW8yh34Xr8oZvh
 au7TIGyRoJUZUOZhBwP8tG4/Y80/rt2YWbjvU0xsxnjWhHysz/M93qTyD3Hkpx6f59EQdP
 AndRjuP2YdtUs4nYc9N3lyUK6zeZUjQoZBL3354pq6Ol1B7rfYPwilvKHhk9k6210YG6Na
 fpdIG9pt2iyIFD6ueOpNcO5hUhewS7F+n9/gVoEwtCxGopNvUvlGhWEJH/MJDbvVLopeXz
 M/kNKHHB9xBw708m4d0qmFl0MDcj8gYvrxlkqFnBzqDMMFRrFmBalfqMa7PBrA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746553258; a=rsa-sha256; cv=none;
 b=mgHv7H4E3C354C8Du8irWpgw/0ULx2UUd2SEoVmGJh+V0BvhgVjSpdZ8eTRMA7Z8pFhsh6
 qEXl++jbgc0VuHJdAlZ8H/6h5bOZqbSxo5TcvtKrLUSR9IqmNt9SoPSmkYnzcdazc7hNG2
 Z/+vvx20XRES1oTp08J6nJOVpZv3AvGEVCl88CmkXfpcSs7EIftF3e5E+0zWB/XmFRrLz7
 vX6nnXKIn0Qo4H94b2ysucTbGJbaKfcAsa3p0wgYu/r/HT+BK+CcVVgBEQBHWQ4DfTdOdd
 /kFnVrfUHjD/zJfbls5rhLa0xSwRGJNE5YvaNnuDrnO9K/+NwAwV25NQB6AyFQ==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4ZsQfd5Czwzvmp;
 Tue, 06 May 2025 17:40:57 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH 2/4] bus/pci/bsd: Map resources at EAL baseaddr
Date: Tue,  6 May 2025 12:40:42 -0500
Message-ID: <20250506174046.1136711-3-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250506174046.1136711-1-jfree@FreeBSD.org>
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Provide the EAL base address as a hint to mmap(2), so device resources
are not mapped where malloc(3) et al. make allocations.

This makes mapping conflicts less likely for secondary processes that
make memory allocations before initializing EAL.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 drivers/bus/pci/bsd/pci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index 5e2e09d5a4..0581daf130 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -182,7 +182,15 @@ pci_uio_map_resource_by_index(struct rte_pci_device *dev, int res_idx,
 
 	/* if matching map is found, then use it */
 	offset = res_idx * pagesz;
-	mapaddr = pci_map_resource(NULL, fd, (off_t)offset,
+
+	/*
+	 * Use baseaddr as a hint to avoid mapping resources where
+	 * malloc(3) et al. usually make allocations. This reduces
+	 * mapping conflicts in secondary processes that make
+	 * memory allocations before initializing EAL.
+	 */
+	mapaddr = pci_map_resource((void *)rte_eal_get_baseaddr(),
+			fd, (off_t)offset,
 			(size_t)dev->mem_resource[res_idx].len, 0);
 	close(fd);
 	if (mapaddr == NULL)
-- 
2.47.2

