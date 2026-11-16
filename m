Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A59606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.a=rsa-sha256 header.s=mx header.b=jmesfpv8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87691402A4;
	Mon, 16 Nov 2026 08:38:32 +0100 (CET)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTPS id C7F2740150;
 Mon, 16 Nov 2026 08:38:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru B80B02C0BAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1794814710; bh=jq3R1BoPxzfHyLxVJ5t5OTm23Hjh5kLxgXl+MDtgNjQ=;
 h=From:To:CC:Subject:Date:From;
 b=jmesfpv8Dmhk+dfBWdL5YccVdTF/aS5cqycgDx1i785hAQty5DYp6aUi0ogpV/IKz
 WBAJRJDylzS6lm0IOdjYsWiNO5KEfcqqfc6JnPxev8DD8mRywXWUv2kFwCXWdAjxPa
 gpu4P05ke02bZXrFCMo8/eFbyOsmRIfO6W/JFbu0=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id B80B02C0BAA;
 Mon, 16 Nov 2026 10:38:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 7EE052C0B99
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 7EE052C0B99;
 Mon, 16 Nov 2026 10:38:29 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Marat Khalili
 <qm2k21@gmail.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] bpf: remove redundant self-assignment in eval_divmod
Date: Mon, 16 Nov 2026 07:38:27 +0000
Message-ID: <20261116073827.236699-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msk-exch-02.infotecs-nt (10.0.7.192) To
 msk-exch-02.infotecs-nt (10.0.7.192)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/11/16 06:45:00 #28892229
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
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

From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>

Remove the redundant self-assignment of rd->u.max in eval_divmod().

The assignment has no effect and can be safely removed.

Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 lib/bpf/bpf_validate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 8bd8c10177..000d218cb4 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -958,8 +958,6 @@ eval_divmod(uint32_t op, struct bpf_reg_val *rd, struct bpf_reg_val *rs, uint64_
 	} else {
 		if (op == BPF_MOD)
 			rd->u.max = RTE_MIN(rd->u.max, rs->u.max - 1);
-		else
-			rd->u.max = rd->u.max;
 		rd->u.min = 0;
 	}
 
-- 
2.30.2

