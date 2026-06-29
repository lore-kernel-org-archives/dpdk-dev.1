Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8671FC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:01:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B5F940677;
	Mon, 29 Jun 2026 21:00:44 +0200 (CEST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id EE44C40669
 for <dev@dpdk.org>; Mon, 29 Jun 2026 21:00:39 +0200 (CEST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-804239c418bso36184537b3.0
 for <dev@dpdk.org>; Mon, 29 Jun 2026 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782759639;
 x=1783364439; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSYK64bIQcItSEuRTKDJO21majhyBZY9162ihL8mVVs=;
 b=YEQ5kSbG+HvslluWQNb7ufRiRHQPZOLx156IxPVti2O8vsexSe8uwjQln+D2aiM/N9
 t8oLv/aYF7J4KkcsbW4ypdlUH3u0OV+uy41P4Jf6OW7cbia8ut6M4f+0NoaxTdWMHrFK
 FHlfn53ZHyrBvyBxP8cxFZnUAYmI2Sa9pAZu9sWq6cdQme5V0FS0lPEyPcg8V0RAyLly
 hA9tQTQHApnkOK/4Kw2VScJm2qk1AbeXILzG9KnNFeL9w4hEIjjG5syo28eWydlL2GWW
 lJ0dFb/9JkOHUi6voYsN60wakV6yRbRVXVUHNlxMu2pW+hAPU2YcASn/o3UsquUKOd8P
 wxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782759639; x=1783364439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uSYK64bIQcItSEuRTKDJO21majhyBZY9162ihL8mVVs=;
 b=O/LGrMTKMhUPJFcq/jHPTVTnhbYj25CwQAlExPJ4nCkahlHNPnpy0PJXsFmvHVUldL
 Z4D4Na3cU3FH1XHIHWFLwPTjAnueHEE5to/hvHSauK0VvBEMOJR+BUGVfSsDbcIJFzFc
 kyGmYBjtvNsSAq5nY/Ky6/oDBCmpLnmf/d+Nxsv+fTzxV01sfdTUyWtkALSfDJIgHxJq
 8I0JmBAhL1gVwdvSheBPermyaMxDpNNqqwgMFYJQWju8k+4womjf/UtmOZW6NBzLutLN
 qGKMpnGjxKUAx3q/DfGlExiPaF6A+9rL89ehoQ6l2vbErpqbRir53tmf+Zd68vTUIysr
 vqAQ==
X-Gm-Message-State: AOJu0YyV+w1UrW5gws1TXi8A0oCe9xBh2hrJU2motyx7yI2S9Konwbfo
 Zn6+LLFT23vKI769AhO9yE6R3ktAOUSmyoi7lud7WIaSlVsImV+PKS5CLGF17agOVmmYoFIRVce
 1PA+3
X-Gm-Gg: AfdE7clJQ6mwCNC3ZSmmjHXEw7Wly/6DWiQaEtotL7Gsj2uWauIFwnmHmkQjcXEFN80
 iFBgng2JM5kzWMEZc/vxUWi96Q05jdKWfdKX386CZ/xqp9WSgA2CeIA0ZUkRxhTnWJgBYvY3G3T
 2JqrqIe/Bn5fGVKyrW1GYfnuYbTszexiWA011vU/7ConKWU5UDErr/n0U6iBVzh+VDbgVSFVCnK
 bQNsPUI8ZVCiQJrtX02qSXkJu+4JYUTZHEAhj7bynQBUdj48bYK4V04LXNNzmOYng61uXnYftLd
 fXD2WjPNh6YpcOdqxtUVoSGD8BImNhDUXEF/YUYWO02JvDZ0uMNaQB/B6lNU0QENvXI6Ttb9BBE
 WcUbbu5c1uSd6hVSewRhSwRY1lbRscS3uiq6ISxmPueQC/YGcmdezfmjZ5F6ovkFdBFW3PvPGFY
 eZOFf0CVXnUxjXNybw1aECZcPs+5/aGzc/Lc4KhvO2agnLeVwBXaI=
X-Received: by 2002:a05:690c:b03:b0:7fd:4ef9:e5a4 with SMTP id
 00721157ae682-810d83e06ecmr8682637b3.29.1782759639285; 
 Mon, 29 Jun 2026 12:00:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-810e728a009sm1747287b3.5.2026.06.29.12.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:00:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tejasree Kondoj <ktejasree@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Akhil Goyal <gakhil@marvell.com>, Archana Muniganti <marchana@marvell.com>
Subject: [PATCH v2 5/6] crypto/cnxk: use timing-safe digest comparison
Date: Mon, 29 Jun 2026 11:59:28 -0700
Message-ID: <20260629190027.2071745-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629190027.2071745-1-stephen@networkplumber.org>
References: <20260625160200.24170-1-stephen@networkplumber.org>
 <20260629190027.2071745-1-stephen@networkplumber.org>
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

compl_auth_verify() compared the generated and received MAC with
memcmp(), which returns early on the first differing byte and leaks
the number of matching leading bytes through timing.

Use rte_memeq_timingsafe() for the verify comparison.

Bugzilla ID: 1773
Fixes: 786963fdcf3e ("crypto/cnxk: add digest support")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cnxk_ae.h | 4 +++-
 drivers/crypto/cnxk/cnxk_se.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_ae.h b/drivers/crypto/cnxk/cnxk_ae.h
index 691f9bfce5..f2aa5d5a2e 100644
--- a/drivers/crypto/cnxk/cnxk_ae.h
+++ b/drivers/crypto/cnxk/cnxk_ae.h
@@ -8,6 +8,7 @@
 #include <rte_common.h>
 #include <rte_crypto_asym.h>
 #include <rte_malloc.h>
+#include <rte_memory.h>
 
 #include "roc_ae.h"
 #include "roc_re.h"
@@ -1921,7 +1922,8 @@ cnxk_ae_dequeue_rsa_op(struct rte_crypto_op *cop, uint8_t *rptr,
 			 * Offset output data pointer by length field
 			 * (2 bytes) and compare signed data.
 			 */
-			if (memcmp(rptr + 2, rsa->message.data, rsa->message.length))
+			if (!rte_memeq_timingsafe(rptr + 2,
+						  rsa->message.data, rsa->message.length))
 				cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
 		}
 		break;
diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index 09d9d1e0e3..3ed32f7ddd 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -3362,7 +3362,7 @@ compl_auth_verify(struct rte_crypto_op *op, uint8_t *gen_mac, uint64_t mac_len)
 		return;
 	}
 
-	if (memcmp(mac, gen_mac, mac_len))
+	if (!rte_memeq_timingsafe(mac, gen_mac, mac_len))
 		op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 	else
 		op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
-- 
2.53.0

