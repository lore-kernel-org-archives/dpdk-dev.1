Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26E1D31A29
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 09:33:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 594B340672;
	Wed, 14 Jan 2026 10:32:51 +0100 (CET)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 23B8E40289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 10:32:49 +0100 (CET)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R12" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4drgrc69pNz3pNX;
 Wed, 14 Jan 2026 09:32:48 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R12" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4drgrc598tz3Yr8;
 Wed, 14 Jan 2026 09:32:48 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1768383168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRVvNHaXzTuoq/XCy9kQA5Q0TJyQEqvI9CT4ebtjKaE=;
 b=Z3lHbFWW0bv4cYCjMcTA+uCuQrrb0ygHMrN93db/BAk0uONx9GlSrup5rETONiJKbAUekW
 tLkDeuNRq9KnImJ1Qx4dnuFJk4Wm+D4+tXNyU0tZSr8dqfz9tqIiNRxSNuxMoog13dou6C
 2zHf6UT022Y+qTkJ66P0B9U5X8c4AintxETXHhjF3xz5w5uDy0UYno7NNCyNR2hFDI2pgx
 50QkFvmepUc90p2lmQzKHl9x4lZMX1xkjPBTU4h0NGyisOpI+dQJAmAgGDGSa6e8k63w/b
 cYyaNXnTXgZgFPEItvHObKM9luna/8BDCHnJhujptCjYIf2TJbnBYuy3cmL+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1768383168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRVvNHaXzTuoq/XCy9kQA5Q0TJyQEqvI9CT4ebtjKaE=;
 b=Qx1xljHZI9s/a+/5qQwBhWj3tCz5OYRx8xaRF2ggPCHIDvBIvZYpAcPJP6oBu5EatiYaey
 2qSrraTv8Lg/NILhd3zMhxxMJRrHWnB7dVMqD6tgIeBCPkzpaZnbvWW6kc0EPgucndHN+Q
 EukUOJY+0TQ4SbyWPOhi/Zbf9CqkBxdKYKh4ZVCryCq3Pt0L9Yz5IHci8Jrl+qH7BkgorP
 0LE5nSGKneGc8ChojgMs4zF9USLCNxpZsk25Yl2j+2zSGhvD9yF0eUJRkXucdznFo/DhDX
 TSNzdqnO8RtGmbtc90vPEH/80LuOBT7xMKEGDkfSTkG48NyyyX0LoGal+wx7Jw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1768383168; a=rsa-sha256; cv=none;
 b=BZHgJapXfo/EVQ/Vu+4BwWUVOkmmxlC8EN9eAyqLE2AnbatBjwwkF9czk591d26QzvdiyM
 TuIWvKHuOSPjKjGk/HR7zZgIS561RbltqIJffiFRx9TPzHVZKHkJyQWL1R/+EOMUjj56Ny
 d9EXP+FB0/XxbkBN0NFK43IpN3stCmmGZP6CL5MFxzwYCuRoknix83dfI0hLuBvwQU2UAG
 GB+HGOfAa25IbYjzrNW8czIbdBmVzUXcrB5KP0sYJP2mQa/MB27legUWB3nco7/KkYJXJy
 SmqYhZTAs1x/gBUkKgeS04R/JJ7+rWzdProQ1Ga73CHgBMZKsRnsH+YRWQHC7Q==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from x1c.netflix.com (unknown [IPv6:2607:fb10:2023::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4drgrZ4twgzs4m;
 Wed, 14 Jan 2026 09:32:46 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH v3 3/3] eal/linux: check hugepage access permissions
Date: Wed, 14 Jan 2026 18:31:29 +0900
Message-ID: <20260114093140.3256584-4-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114093140.3256584-1-jfree@FreeBSD.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
 <20260114093140.3256584-1-jfree@FreeBSD.org>
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

Currently, hugepage mountpoints will be used irrespective of permissions,
leading to potential EACCES errors during memory allocation. Fix this by
not using a mountpoint if we do not have read/write permissions on it.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 lib/eal/linux/eal_hugepage_info.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index d47a19c56a..350c7d8cf6 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -260,6 +260,13 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 				continue;
 		}
 
+		if (access(splitstr[MOUNTPT], R_OK | W_OK) < 0) {
+			EAL_LOG(NOTICE,
+				"Skipping hugepage directory '%s': missing R/W permissions"
+				splitstr[MOUNTPT]);
+			continue;
+		}
+
 		/*
 		 * If no --huge-dir option has been given, we're done.
 		 */
-- 
2.51.0

