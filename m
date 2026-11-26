Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD7606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=SJB62Erh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xh53ihcg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD401402B2;
	Thu, 26 Nov 2026 22:50:21 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTPS id 25567402B2
 for <dev@dpdk.org>; Thu, 26 Nov 2026 22:50:20 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1B50D7A0526
 for <dev@dpdk.org>; Thu, 26 Nov 2026 16:50:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 26 Nov 2026 16:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1795729818; x=1795816218; bh=h4GSj/2Xjy/vLGQMNC/dX
 YJN7LFsmshTjsHG6BB9tg0=; b=SJB62Erh8Z7fgKRnf0d2hZRXb3Vx3DV6WdXQP
 RsOO2y2bR/ZO/FBAc+Xo4Kbw3WR4wb5A+BsmVGzw6Ulb413tvXVSFpuk9GHU3ue+
 iLefqYBU2tzPWbbZPBR3ITQKGb2vfuKw73PMRy9UWZezOjVWbLXY4AdhEEb2TTF8
 o7ioc2pDaLwC8kzCuv9rMET8aZDPuzhZd8fbXsWHFQIvbfdAN9cc6zMLEe7ZjSJz
 +EM6YLiUDRe9a88pJVVw5tdzymdhIzHurUI5JTaW9Pa4uvVwFHN631Ce/GMLyAf8
 DWokcYMl7zv20oa2GLRbA1Txd1pzUHz6JA5ScevUwE1c5522A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795729818; x=1795816218; bh=h4GSj/2Xjy/vLGQMNC/dXYJN7LFsmshTjsH
 G6BB9tg0=; b=xh53ihcgWbB80BMIMIAG5RfSFBmn3Q62LpfRUj2uwWhkODx1nbI
 UUV79Xql90rSkkdWgZa5g1Pe4O8MykV72m19Wh41Mjf0xzd4I9bixK/1F9u7hu4R
 wv3n1dECct3ApUMwTmtDVjSTG1xiBVvDKc+hQWhofauaiPtST6e41GlX8FTFdBlw
 xXN/l3Hs43iDutTtr2hzEUuarp7TkyLMzOdYEyFGTrvJEC9Xk1iMma33/K8I8kV5
 6kuE7T8+CgfgWtyRgjCwYSkLdwFz6aEFxrF0aMvI7XVZeJXzWKslCaf3xghZzlnZ
 BWzklwHYNimFpzvJzBYDXhUXdUGbbG016eg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795729818; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:mDbjP90jYNOHPAEiZ/EOpfr7ICMiMnc5W2PYEQaRrWKsayH
 3mBvnQixpAqo11m2WtfDEv9b6JIV4P2s2QXY2UIgOUWn4JZcJfR0SA8suTVcOLl1
 iZkwzFxQ/4Mt0/0wz8/dCtCq5qCDM/lB+X4qSVTIkc2QtHONc4MvNel+ti5yLtfz
 YnJ9iAnUS0VmVIrWy3drG2hnMtGnP+cDXo1C1Pox0ZFfVV0EQwRRNmrlh/BW5hio
 7oUdEclDEwYB0hqrW0ydvJ6YWoEjl0JDHMZb17Vp1ebtyGrGo7XkcRrpzjDC1v6f
 VqejuPKYIvogRbGs9ByyQVjuYSnIk+VkXcK83oQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:GuIYHgSulwqgNnoAknqOGfHqKZHM3Ueqy0stBEwJ3DQ=:stCZeHU1AgcgxNiA9xLmy8/zBz2gAruz1yKJfzxOa+8=;
X-ME-Sender: <xms:mqkIawEKtcFjNSI9a3tqSA_AaM5B7WCmbVugX3FnA-POB8rg9B8MFw>
 <xme:mqkIaySC-jvWFjpwBF1Y9PQHMr1Xx-xMMdsSfZ0p5k_KsrunfrpfYBkXAXHHiuOsn
 RcnuVpL_bl4NGT5ptdlioKdX_W3Q1lBTjPbJnbocwNww4CA1-BWGA>
X-ME-Received: <xmr:mqkIa1sJ_yGumE76jihoOp3lPHznIlW26mVnX4hP7YudXZeRj1nQ7RDnbQ3h9cuo39V091EjdZFXujuXdGf6VtsCeKHN>
X-ME-Proxy-Cause: dmFkZTEiHguYztBWkzrphZiTNPz81kvk5U3gjC05pMHuShns2XQUqsXn4Ghnf9+pxJcg+P
 fPbbSDIcJy59Qd0g2l+LOdF3nGr70m4eMyzCQTUkISRwj5ww5RsbMrr5nPGNUG8ZwJ5Vex
 ACmG5lb41isW1Pcpouhfgh3rQ2cYiADEFNAnj7rAg1iwPW6pmqvSYm181zsdnZeFHfjEeo
 OVp4fVaBWLsnhfNapAsqA3K1jZbeoXB4bcWV0RhUpE6yiYSojFXUxpWs7TspS7CKcZvwWT
 XzSQZA6P/3UmN0vZKnghUPsNrzvLczPEdAAp/4zGWFsdZesObbc5wM/TFv2bAHACFxcSjC
 DsdIRWlypQPKwbWZ8oiLWLsMqnZE9IFDEbHKwj1DvGqud+V286sAafsTLEzmFJp65f1KJv
 BemQDgf2pgc9I6tlFL8kEjfZX1dPPTaXpjTm5b+kLFqH0qK3iHTX+RNeGgX5CWQtCgCDUR
 Z8RMNWXUii863Z5eOgk8p6CEACExtX9/DT+T3LaenE2Iq1c/F02s2IxGyTDVyaMHFVrCAA
 5A05/dfFdUxyKki+6tMj4U/MtIihtMGfjbusuuWqLLN1QMuEeILbX8EQs5hfmqb+sHwweG
 Y+UMo5NzBJb+0OqMTiFACHq4HO5kxsbW0I2SmAed5woUIDhtNuEfI+70BgoA
X-ME-Proxy: <xmx:mqkIayL_Ux1mcbdrVrDuaO2kt3u61-4RhHmaKzZiKc72HwfZXgyWbw>
 <xmx:mqkIaymIF-yXDrjF_9OJM-NN2uXDbhzzhPC1YPMnE1xihCenh2Aqng>
 <xmx:mqkIazI_E6JbyYeo9AFC7KCR9v8XXzHwIkQXqC1tAUs3_L6ELNosyg>
 <xmx:mqkIa36jhlFXeDROoWI013qbl6TdnA9iwjrRhfABoQjxw-VjKDeLLg>
 <xmx:mqkIa1cYuI1Yx5PzG9ykMkeiHJHFTEaqVIh7MLFTKHC1LH90MASISEZb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 16:50:17 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 David Hunt <david.hunt@intel.com>, Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH] examples/vm_power_manager: fix build with Clang 23
Date: Thu, 26 Nov 2026 22:50:08 +0100
Message-ID: <20261126215014.3621593-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

A global variable was not used, raising a warning with Clang 23:

examples/vm_power_manager/oob_monitor_x86.c:14:29: error:
	variable 'g_branch_misses' set but not used

Fixes: 4b1a631b8a8a ("examples/vm_power: add oob monitoring functions")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 examples/vm_power_manager/oob_monitor_x86.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/examples/vm_power_manager/oob_monitor_x86.c b/examples/vm_power_manager/oob_monitor_x86.c
index a5b1c168c3..1bc7032a1c 100644
--- a/examples/vm_power_manager/oob_monitor_x86.c
+++ b/examples/vm_power_manager/oob_monitor_x86.c
@@ -11,7 +11,7 @@
 #include "channel_manager.h"
 
 static volatile unsigned run_loop = 1;
-static uint64_t g_branches, g_branch_misses;
+static uint64_t g_branches;
 static int g_active;
 
 void branch_monitor_exit(void)
@@ -93,7 +93,6 @@ apply_policy(int core)
 	}
 
 	g_branches = hits_diff;
-	g_branch_misses = miss_diff;
 
 	if (hits_diff < (INTERVAL*100)) {
 		/* Likely no workload running on this core. */
-- 
2.55.0

