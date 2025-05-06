Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2ACC3ABBC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 17:50:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED4DC40659;
	Tue,  6 May 2025 19:50:20 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 5332B4025D
 for <dev@dpdk.org>; Tue,  6 May 2025 19:50:17 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4ZsQsP0Mckz3Y9w;
 Tue, 06 May 2025 17:50:17 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4ZsQsN6XZcz437W;
 Tue, 06 May 2025 17:50:16 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746553816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpaDuDMjlqpmCgqcrfjshKhXYBIQnnhDIOUWSVAWb5Y=;
 b=ajnftxOk/uy8PJlH7nJgsRUDHGAhAtfwYFMClAXZzQcIdq2lnZWJmRtF6Ws+uPeX0ixMnN
 /8ODnIYte5WjfGPidmE5o/ejAnodUoLzfo47Zq5heFYWvXHGCCpey6H7yUSpMgFj3a3YyX
 XH+yvOFE7PS7WofbSVRHcRFrx58wLgQHFxzSPgl1YAO+yMBlp7/jU/VLEU0I19tWAqVP4/
 4NfzlUFHpM0CgT6dvLN7+cSbDaA9+ZUV1LSqmsLFh9fQhK3ovEA+wcC4LZPFtXm96tBgKF
 lKNVNz4O/LhCM2qPrBU528qRaj9j79XjmuPKfdCsVUQpS66FK/wQ8fvWNIZqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746553816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpaDuDMjlqpmCgqcrfjshKhXYBIQnnhDIOUWSVAWb5Y=;
 b=YxUqqCWb9IfkVUDKQxSd8aWlh5LzLuMvk2Ejer8He3f+xBeMMWDOHOUuo/BElQVSKhhNqC
 l5eYwiRf/peMm54xY9cudPcN35aRvK/1zLVtvRYlRXVZji2If/8WTRaTzGst1pup2A9zvc
 S5Wy1yb/dGhjWjZud0TQxKm/R2pydrheA9lc3CQZpYi2vEXTqBudHMR1plWLNZHPCMnbS7
 L7aslKPElw5GxjU3ENKAMDyR8bGLWirJAqTFp9DIPEmXqGpuDlx17sQLVSx0OFsJiFT5zN
 f9RXJnE4HDT/Wj167cQzi+oc8IlV0C4tnSEXzRQhJUf2hDz2B/p2ZjLLUKeTlw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746553816; a=rsa-sha256; cv=none;
 b=Erg0QacXMsbTNosG/SXftpCVG7evDJ+5Vgvbo8co4ouh+SUKp8F/TJEBAw2QW8FAj4TgmD
 99gTgqf4sfALp8jw0gSSp1VgYnVwyym9x/jCsvGALm8Um+lindxuXskRw0Z4Xm1D/Q7ghG
 K0XaaWWk0r9zSKM+pbIyCnA7lgZjnUMJ+Atqi05XOZWKZ2emwrlpgT26JM0MoPbHYwvrnN
 V0x9PR3vh9XryI1BnjSAkHO4hMJxAZCFL7GaOfp1XJKz7nx92deZ+avoI8eUaXf65oLXsg
 mitAJ2XYymM694zGqb2R0ckWAgeBVz8kltZa3Fj3QhOxbNe8pg/1oSApkZGwtw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4ZsQsN4V00ztgL;
 Tue, 06 May 2025 17:50:16 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH 3/3] eal/linux: Check hugepage access permissions
Date: Tue,  6 May 2025 12:50:09 -0500
Message-ID: <20250506175010.1141585-4-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250506175010.1141585-1-jfree@FreeBSD.org>
References: <20250506175010.1141585-1-jfree@FreeBSD.org>
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
 lib/eal/linux/eal_hugepage_info.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index d47a19c56a..dbfa38b05c 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -260,6 +260,12 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 				continue;
 		}
 
+		if (access(splitstr[MOUNTPT], R_OK | W_OK) < 0) {
+			EAL_LOG(NOTICE, "Missing r/w permissions on huge dir: "
+			    "'%s'. Skipping it", splitstr[MOUNTPT]);
+			continue;
+		}
+
 		/*
 		 * If no --huge-dir option has been given, we're done.
 		 */
-- 
2.47.2

