Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99218D31A3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 10:06:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48EF24064F;
	Wed, 14 Jan 2026 11:06:17 +0100 (CET)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id B0C084060A
 for <dev@dpdk.org>; Wed, 14 Jan 2026 11:06:16 +0100 (CET)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R12" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4drhbC3Qy6z3vgn;
 Wed, 14 Jan 2026 10:06:15 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R12" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4drhbC2DNWz3cV7;
 Wed, 14 Jan 2026 10:06:15 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1768385175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwluiRb9yYhu2C9mxOcVjz8jU1OtwF/kXMbP1XZeIJQ=;
 b=W2S7S0O1XL7vg3g15o462fp6m9Tjgh/DwOQ4mJqJoWLAp/eV2FhOlxQNnCOWEn2Tqv8bGm
 wnbJbM3RTMMJlmuHek2PKqemfLF2Y45rmLvCqHFOWocl3zmQBXryJyvFlaBrICgMYTSXQW
 mjsOm2QLy1/uMtp/QDqcm9JskBdzDEfq2rRUUsjaaa5QGST2XRboWLGQWakTiYm5s8ANEy
 uGBAxbYL/ZbmaRxEFmZiMfe3thiG5Vyl7MrvEpStND89tnosoRuFO6C8l/qQPGlfg+IA6U
 eA6e5JFg5Qaj1tpODfiHdDy3X8UeQlfD5viTliS2s/nIbfYhf/ZYGXT+Ulu+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1768385175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwluiRb9yYhu2C9mxOcVjz8jU1OtwF/kXMbP1XZeIJQ=;
 b=C2MF4Uo/EOupJ+75KyrjZaa+krm74DfAtcdADKPhlaRyFR7OZj+N1d3PobVtDAmWPFFYNs
 +HhcPTxwqnpRW7lHdLcav38YU8m2l23kOpuN0crvgdsUVRiZxrGQgZ2A1d7uI2+6t1kiQC
 MZRmgdlEYBnG6IKcts6a0iI3PdxA5kgcihgpbL4HwciTGazcPqdOYuvA6fyuyogO+/aRFf
 rmPQRWqvtX3GYElrAafppLjX5trFKdcR3tgfTriaBtbxewQzG1rgnimV3esqj0vf2izHKJ
 9mssuwS4OmzutP+6/SUfG2AqKAaTGcoX3fq1QGqVDnfuk1yCfJoLuKWvESXmTg==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1768385175; a=rsa-sha256; cv=none;
 b=YoAH0GTnAqQGGcycyLZj6+2LNGrsLyY/K2ErXBUjnZtMgjmETZDbB9YDlIEbYOeycijVSp
 B5/IkQb7C46T1J6nha32Ql1yU65JdVWqB6KJdO73ym7Smo+J5cBSUKZww+sXLWkUlwQzcH
 pnyxlPVqJZ78vcvUbm6ntjcCbVcYKBIijpTjCDciKuHBia8QHrtzFn8iWkSeze8OIRoqor
 /CN56xtb3/iG2bVY5PAdvlMZZ3DAdt6WGzE0wrjDWxzNzvNTNLOp62aWaMwOYput+fAeAc
 hBoRvs8vPLHOIjBdIjiXIYIpMG3nia7P6Cmiq/UG3CvpA0p7qMdLGJX155sXrg==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from x1c.netflix.com (unknown [IPv6:2607:fb10:2023::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4drhb91KKHzs2K;
 Wed, 14 Jan 2026 10:06:12 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH v4] eal/linux: check hugepage access permissions
Date: Wed, 14 Jan 2026 19:04:37 +0900
Message-ID: <20260114100547.3265822-1-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114093140.3256584-4-jfree@FreeBSD.org>
References: <20260114093140.3256584-4-jfree@FreeBSD.org>
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

Added comma missing in the v3 patch.

Thanks,
Jake

Currently, hugepage mountpoints will be used irrespective of permissions,
leading to potential EACCES errors during memory allocation. Fix this by
not using a mountpoint if we do not have read/write permissions on it.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 lib/eal/linux/eal_hugepage_info.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index d47a19c56a..219a95dd9f 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -260,6 +260,13 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 				continue;
 		}
 
+		if (access(splitstr[MOUNTPT], R_OK | W_OK) < 0) {
+			EAL_LOG(NOTICE,
+				"Skipping hugepage directory '%s': missing R/W permissions",
+				splitstr[MOUNTPT]);
+			continue;
+		}
+
 		/*
 		 * If no --huge-dir option has been given, we're done.
 		 */
-- 
2.51.0

