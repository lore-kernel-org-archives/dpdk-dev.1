Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4F2C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 17:50:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C0C14025D;
	Tue,  6 May 2025 19:50:17 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 83FE04025D
 for <dev@dpdk.org>; Tue,  6 May 2025 19:50:16 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4ZsQsN13Mbz3Y9v;
 Tue, 06 May 2025 17:50:16 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4ZsQsN05rsz4354;
 Tue, 06 May 2025 17:50:16 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746553816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zHKoC1p7qVLtDQ8qrseKgg8fgj+mM8tbpQcVHsxWQSo=;
 b=XJs4QvG9fKOUZkOlAU/LrlrygOdmiPn1QSxDqlwIWSvSoyu4UkefVwSmhD9Xhp07MycUFP
 JeRB3YQtGutxKJ4DVke9Qoc/pU4bH41SginUTjO8DzAp980GbryBfQgNsRo3wNHX/sTszd
 Lh1RQgqAhugYjnVtxk2DBAziat6V/ktgF4xz2HjJNKvx+5vpEC2zv7Rho15LwMwhvhieHn
 raqUvR6EA62POOVJV4wy+WnbDLbS4GndyufY2jrGHkvQ1DCisjmtRb4oCic40c4Vfq2+ld
 Cm8HOcq7Fs5gxm0YtHudOe8X47+s+jDdLhrgWXVMedVFW8THNE84Iflk4xSbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746553816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zHKoC1p7qVLtDQ8qrseKgg8fgj+mM8tbpQcVHsxWQSo=;
 b=NwMXBGFHPxzE0wwCRi+p18RwMhN7Pm/JwbP2nhbK3u9ZG6zpxG/Mt4RreF16cf+vAYW2aU
 cCvdA2WI1CeMf+cz+tssAMCyaNQre1XG5w0wRoPiyrcd1JTCHnsNiEDNw4u+kUEkeUIzR4
 +s7og8WP454mEN1n+vMaDmCSA8aI4QKoiHGjP2jY+jJssDrj+tTIC1tvsKJgULYK1WvuoF
 WwuOHzk+GINGPDV/gXYGsrnOq2r7SazQZSBAxT1c7pxkqgXzH4MvOv4iGykl4yH31cw84U
 jaqGGtFhaKWY04QC4q5I0gBi7ezob7IbQmfqwpGoU6zRK+Ug8JNem3GBpnEK8A==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746553816; a=rsa-sha256; cv=none;
 b=rJBZ2g3aWvqOcHGMpJ1oerwaEtD2Fp/oUq20LlK7spU78S4bq0K3LYBgz9ah+h4GhA7gzC
 yDchSf/p8KWfIaXwd87mu+oM/1dL118NVDKg3rn66a0Svc1yj/zPE+4X3QdxUSK7YLEUVb
 ce02fdtCw4qdwju2tHpTOydkcmjTzO3RZD5C0LtgimkWZZhiUiGtrB365jYf2ocCkHv5DQ
 Ci9Yjzg6G0R+/a3SUISBn1INgZu+/ZV4B5BypiIoaSasILkIq23j42Pvxk4cBeu9vvKMYR
 FNkGlCayxdQtcFInXQx3OFNZiGWLHwDPaUHXR8iHQVL8OHVIuDrUKV7OLxRJbA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4ZsQsM4Fd9zw1Z;
 Tue, 06 May 2025 17:50:15 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH 0/3] EAL memory fixes
Date: Tue,  6 May 2025 12:50:06 -0500
Message-ID: <20250506175010.1141585-1-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
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

Hi there,

This patchset contains a number of EAL-specific memory fixes that I've
made over the last year. Two pertain to FreeBSD, one pertains to Linux.

Let me know if you have any feedback. Thanks.

Jake Freeland (3):
  eal/freebsd: Do not use prev_ms_idx for hole detection
  eal/freebsd: Do not index out of bounds in memseg list
  eal/linux: Check hugepage access permissions

 lib/eal/freebsd/eal_memory.c      | 8 +++++---
 lib/eal/linux/eal_hugepage_info.c | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

--
2.47.2

