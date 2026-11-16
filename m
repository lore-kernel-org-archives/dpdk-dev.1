Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F7606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G8TQpNYM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A031840609;
	Tue, 17 Nov 2026 08:58:26 +0100 (CET)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 58CD940150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 18:20:55 +0100 (CET)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-37628596783so6198932eec.1
 for <dev@dpdk.org>; Mon, 16 Nov 2026 09:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794849654; x=1795454454; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gNvXURt6JWkgeZt+x1n61jMMjJg7HEbU/VejWlj7FM0=;
 b=G8TQpNYMuXfENjVqHix/L50EXLCJhQv/yv7vclXw/0LD2i2n73qcq/EeSKRK2obkxh
 O7b5s/IkULkz2/Ukpjv/ki6V0DiXFURrQgPFwWzbgaRKrk+DPB+XvrINHIdsSJA3BWdF
 9KilVxdBbmsJF39uCfnAUnNlucG3T1y9d1kE8yiurrXsg/B3k8kbY17XkLoHjlzPEZZL
 /RQ1mEAQ0am0BvqQF2twtzo63EzCFWJ3ptbGVpP1lYEtmN8ElRMc5NrQKRRnU3cYQbkC
 eMe/zVd/+GE6cI0lgdhNIanB/QLQaUt9GsUtvsWGK0IxszdMTp87L14u6joGhObh1cIA
 w0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794849654; x=1795454454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gNvXURt6JWkgeZt+x1n61jMMjJg7HEbU/VejWlj7FM0=;
 b=NCIjm2s5B3M3fqGWKt2PxWIu4opTDXuJTxMMRSWIEc6s5+m4NxMyc3eB/5xjaSdts/
 q7SXZqSaMvXiVojwXmb9QES8dd7ytxOT/jNU58wH52nWRGmGKi0eByEKPkBduDgy5KS6
 YJxaT6gkcuUXNtffdhwmkY5yhielqLU7t4xcbP87xDRzHJ1Iqs3AP7vfNZcrjK34jgQQ
 erDz/38vhoWn+I46k8lGRV4ps+BUGMPgfxAllbxvbFI3xPQr3aLfoEMkal3BeI8ACPtf
 c2L4bTFU7OU6N1IBrGsQZMSXqgb7jS8FFMeGIDoh1HyOA7DhNmwHDvOA1bDy7xU+9DFk
 Asnw==
X-Gm-Message-State: APuU4Z9ZqRIaur9ddSs+XKh3SHgFX31aSGxgzspkd+l350N+a5hAKpoI
 C+FLgRv6LIZRCRe04SsyjSFveWhNoilJS/Awi1g1Flr18TbaQ1jYLzNb
X-Gm-Gg: AZFdTZc3DnjnWtPA/rrnZWGcmmyDM2Ax7ytWT37CAFbw/vhNo2UjAA2MHKip9B4nyPo
 uIgi72mtX+tiLWfj1I2hMRx0GQ12KRApE/Tu9/uM7beN2Z1aZBXIlQ/0iqPo+WlDCbil2KjgMng
 bvB0q381WvMGP57zGIl0Pp/vf0wgFlof2ICdw+8CCL6GM9aDdPu1eUdGRrj2FHjTwwf3wIVE2XP
 h1mpB+76s2pFpj+GW+jUITz/5dgWFqJjszAEGU4YBDYoOXPLT7R8QrSLcikvAcczalLZCxlq41j
 JCBdu2sUkPcnQCp8r73dSYw0rYmgOyS+2pWpEd3WKST8El+jDlvYsrS7AtN7vbdcipLV5OMy8y1
 Tx+bEKfw/3T3e2T4xAG43N9Ijt3zn67EVvBAJOujKSQ3MI2QVcX8Qh9W7iv2vlYR1tBtLxXAYTk
 hRCugwxobjlwjQeGG6hFgKaF8t7l0NNR+jEvYx7k8c69zxfACV6eXvsmyff8DPnASWRn1Gvn+TA
 XCSvlAmvgVfjn47kiPRp+Y4ICYYc391u/3FmUdI6gfZLieoFNH5dx8Y3E6uYRAQscjMTmQBTa+e
 cfe3lneArFu1Ej3jaEUpMR0n68JaWT44Bpmg2fN1gTcP3VLg
X-Received: by 2002:a05:7300:5356:b0:381:db2:9772 with SMTP id
 5a478bee46e88-3810db29d7bmr160288eec.29.1794849653362; 
 Mon, 16 Nov 2026 09:20:53 -0800 (PST)
Received: from localhost.localdomain ([85.172.76.155])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm65023254eec.21.2026.11.16.09.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:20:52 -0800 (PST)
From: Mark Bulatov <ms.bulatov7@gmail.com>
To: Chaoyong He <chaoyong.he@corigine.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Mark Bulatov <ms.bulatov7@gmail.com>
Subject: [PATCH v2] net/nfp: fix wrong argument order in nfp_encode_basic
Date: Mon, 16 Nov 2026 20:20:37 +0300
Message-Id: <20261116172037.5347-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:58:20 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The function nfp_encode_basic_qdr() takes cpp_tgt as its second argument
and dest_island as its third. However, the implementation of this function
implies the opposite: dest_island should be the second argument, and
cpp_tgt the third.

nfp_encode_basic_qdr() takes dest_island as its second argument and
cpp_tgt as its third, but all callers in nfp_encode_basic() pass them
in the opposite order. As a result nfp_decode_basic() gets the island
ID as the target, and the island check compares against NFP_CPP_TARGET_QDR
instead of the requested island.

Fix this by swapping the arguments.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e6858e7e7cd3 ("net/nfp: move shared target logic to own file")
Cc: stable@dpdk.org

Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
v2 changes: Correction of the 'Fixes' tag and description

v1 link:
https://patches.dpdk.org/project/dpdk/patch/20261113142823.5918-1-ms.bulatov7@gmail.com/

 drivers/net/nfp/nfpcore/nfp_target.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nfp/nfpcore/nfp_target.c b/drivers/net/nfp/nfpcore/nfp_target.c
index 0e7a5cbb05..239ffff869 100644
--- a/drivers/net/nfp/nfpcore/nfp_target.c
+++ b/drivers/net/nfp/nfpcore/nfp_target.c
@@ -728,7 +728,7 @@ nfp_encode_basic(uint64_t *addr,
 			 * address but we can verify if the existing contents
 			 * will point to a valid island.
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
@@ -741,7 +741,7 @@ nfp_encode_basic(uint64_t *addr,
 		return 0;
 	case 1:
 		if (cpp_tgt == NFP_CPP_TARGET_QDR && addr40 == 0) {
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
@@ -763,7 +763,7 @@ nfp_encode_basic(uint64_t *addr,
 		if (cpp_tgt == NFP_CPP_TARGET_QDR && addr40 == 0) {
 			/* iid<0> = addr<30> = channel<0> */
 			/* channel<1> = addr<31> = Index */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
@@ -786,7 +786,7 @@ nfp_encode_basic(uint64_t *addr,
 			 * iid<1> = addr<30> = channel<0>
 			 * channel<1> = addr<31> = Index
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
-- 
2.39.5

