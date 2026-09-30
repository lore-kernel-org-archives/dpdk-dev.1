Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A56CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D88E542EB5;
	Thu,  1 Oct 2026 00:44:05 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 2C85842E98
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:03 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so3309784a91.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808242;
 x=1791413042; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKvyOzFTCnK5BpQp3U6iWp7DPcr5YGlrqACcXd1UO0U=;
 b=tTuF8If45imMBLxVdIXSyuqpNqadCVgx8cywA8lqvLhBgzYYMYYR5Eeref/ov2XLE1
 PFJd8Jq2tmpjoUjVdREVTU4hRrpP4BfjQcE2ApUZreEe5qh/C9uMdD+h1l1A8rs4VvtP
 yquX628g8vcowaKeXDDjuoZK1e9G/6k+/xKmdOqsdNe6KADhUMV27ydY9l2/NDp+2CZZ
 i4f1Qt9V5xvsrUBF9HsJUNiXCRiR/vEEHuHcfAa8qPkAaWFPbJJp1ES1uNFEH3bcIlFN
 vLUCFVdJKay2nPEz7M9ohi5UjHNJrcQG0t3E9GO/GNb/6VCWtMqUcd6YYp07H+/Nzlgq
 xExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808242; x=1791413042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sKvyOzFTCnK5BpQp3U6iWp7DPcr5YGlrqACcXd1UO0U=;
 b=SQ6fTC629dtSWX59ZzjHmBVq2LLYwKBbDC9B2eT7xZJJBXYSHNs7Vl0VKuYb/+4h6T
 5T+a00xOnyxAuXWaw9dUYTueJhmDHrij84FB0ZL7MaX7MSdYNbhSs5N+qcTbgmrq1Ujr
 SE7VhBUOLmOCw9B7oOVEpAuDEiiJ8Wcp3u6+PvAuwkZGb5ERMQ3+m8iMRBAo+XT+Znw/
 dXZT8bj0Rza4ByUjcGx4KuhjYY9V0hIjorWrvFk05IYY1keAwZheYI6iQcIfvwgqBRpk
 m5iQMixMfM2RhhX1y8yVbfOlrGF8m72ZdagenSdcj/Wp8WdudN9t3GBXqvwPh8WMCXR7
 48mg==
X-Gm-Message-State: AFq9FYJ6N9fgBD8UmKchqEzHkqich3HJsV2OxXnTrpGDStPyfxi28OQN
 7Sf72bfLCHYozYNZac5Boh/W3UskrfD1HooJ9NBb93dW2j5yR3qeFo4YAbXYBeXYPyvZvMYSLIy
 ScRVE6QU=
X-Gm-Gg: AYBFou1RInF164sWsdKpx3XB1f/se92HwRzR28JX5yAAnF3wW1L/SQIFat1oSf5gr+k
 RJ6O7ebqmQlatqEvVorfegTkBjs9zVq/BW2iUn8RWY1RyRNhoCZtCo8byI2+U4DGwBlgIHOS/LF
 pFPuGlztnAjNfCrtveFMwWJE+6r1NRQORAZR+IUSp5Wg9+CCymkFzKoMtv7CajyDwbjzlI5oALa
 97+RtFsNlALBsq2ZoQX6OylvgMnTrf1FH5xTngzpg/9CLTxgN7fcq8/1bC3Z27dGRA5URwtjOtV
 T613pZWrknoN8SjnOnMPo6yoYzlkVO2KNdSlziDHvXfFJTRd8unfPQrKtSxeDUI1H8HlNRsKSIi
 uZ0iMxbdW7U7Ns3sG671SfZokUA6kHsdV/EIhi/miVXbd8GHlY/bbRn2uRd4GznxDlcbYv0UInf
 hTev8p+7sxzIgOBbioJbwolr5vbHqOBAXniODU1cuxnKPWBjmqGZsVFkwlkkDSEkMeHsYxfvU8f
 AcH4DFzgBvS/8II5ZJ3HoGTtC48aRdI5xLV8Q==
X-Received: by 2002:a17:90b:35c2:b0:3a0:abe7:f0f3 with SMTP id
 98e67ed59e1d1-3a4f9ce97b1mr257838a91.0.1790808241840; 
 Wed, 30 Sep 2026 15:44:01 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v3 18/65] net/ark: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:36 -0700
Message-ID: <20260930224340.58580-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

The packet director argument is stored in a uint32_t but converted with
strtol() with no validation, so a malformed value is silently taken as
zero and a negative one wraps around. It is also converted through a
signed long, so on a 32-bit build a value above INT32_MAX saturates at
LONG_MAX rather than being stored.

It is documented as "Pkt_dir=0x00110F10" and read as base 16, so use
rte_kvargs_handle_hex32(), which keeps hexadecimal with or without the
0x prefix and validates the whole string. Both the documented form and a
bare "00110F10" are unchanged.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ark/ark_ethdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index d6b1abf383..c6784b64a3 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -896,7 +896,9 @@ process_pktdir_arg(const char *key, const char *value,
 	struct ark_adapter *ark =
 		(struct ark_adapter *)extra_args;
 
-	ark->pkt_dir_v = strtol(value, NULL, 16);
+	if (rte_kvargs_handle_hex32(key, value, &ark->pkt_dir_v) < 0)
+		return -EINVAL;
+
 	ARK_PMD_LOG(DEBUG, "pkt_dir_v = 0x%x\n", ark->pkt_dir_v);
 	return 0;
 }
-- 
2.53.0

