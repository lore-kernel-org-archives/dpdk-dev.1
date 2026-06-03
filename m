Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A117CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 17:08:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 725DA402C4;
	Wed,  3 Jun 2026 19:08:25 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 5FE8F402BC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 19:08:24 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so119527705e9.2
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780506504; x=1781111304; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uxkh69Yt53Cfz4XOpn6gnQFzv6+2THPU2Ve63/4nUn4=;
 b=bh2/rWmN2lNPHoscWPajvZwB+CERRRaYTxSmqHwes3Va62TFayiJQK/VGifkO3VxXb
 C2mJQDeXvhB8llhsWlMwvV5fMF1Osqr7ypP/u4geV5LuzgPLfDp7jyUlNIVl+dFwuNdj
 hFDQBURSF3fEEVz5NIiVSG+yuIkEOl9SASCL2smrHMd0T5yOMQ1eht2IJgIxMj45t+Ol
 ono72Idlf9zG7V/maDBZ1N+kvJT4fT8ANay0Y8L+H5PQEveoNcAccmW8Cya7IZ92d0cc
 2Cat2q9LM52+OUpQMF6Jfj/dW2N6zNS3CNTX26FumBGyuJaJGPPgEJL7ceethoZnuxWc
 Mt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506504; x=1781111304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uxkh69Yt53Cfz4XOpn6gnQFzv6+2THPU2Ve63/4nUn4=;
 b=cKHzgnojbY96H0J/OenTTRWORSX23tpxf0Z72OrgBQvymA/UiU+kSRmWKEDIYUDFIE
 laSa4a+wIAg6rVjop/riVCru1qih//PISXUO6rw7CvBc3YMLbxm0P7GsuE4DP9qTojMB
 bTmQ8O+cpaaGjiHowmdpG3TSsxtdvA5PzliMACqrTE6A2CYAIxqB4RRyKzxQSEEIYcgh
 zXGyWvWl1XUS6LbANXksN7GUJAtz3y3NNQcef2uYi0lLPaYPpWNxRchIjo3tvqXw7fYQ
 K1f7dlnHKlNHBab8XtXZXJvG6n5d9G0MB5LFyW+BD86jSD47lp5p0IOZ3FelzIcb/DfM
 va2g==
X-Gm-Message-State: AOJu0Yz711MH7aoi890bqW8BpP3aOPupk+rJgWTVstDWAm7Xt2W2pmEk
 mnJbOM7k6WEHv+vOLRMyCB+4PJFRuNNPh/h2ztu77mjLLSH4VKR20MslS+W8oQGT
X-Gm-Gg: Acq92OFfWUhvRgDZOquKMyXJxLfRVNjipFu8ndIQuTVTe0vQAaG7JKol/7jTyHzDl9H
 9inDXs5JBAsHLWC8M2P6i6omYz6ekIDf7Tv3ffxtw58EOr+UjLvpLFlD0qJnJ2s5nO02PctVOvx
 clvAt1kzNDtwzGzhnW6+g5QmhTHdfU947rQFAEEsYc/vJoDJ+OCOvoyoqBbbLsgjhkTurwR8BSR
 ncAajOP4V7HkKQ8HSOCcayiImdHj17tVMj4kN56ZGgJK2cqhdKAN/z9STFYC0+cQnvg+1eu6fYr
 w7+4gTyRgyCT1plfB7rD3pITDLOKsy1/iLDEmeNOHvMAw4qrj/SII1RWomR9vZL7wj+aheZoRJQ
 GkZ4KJpIy0Ctp8AgXRWJjdiqbV2q47teMaoIrXYzolkTh6B46LeFj34ceyp7XOL/i/iK8xyo5ok
 F8Xjipx3n+3s55N7+e3r0ChKToejxPl4geXQiN1p77Ts0CWfkJf4P6iwml
X-Received: by 2002:a05:600c:4750:b0:490:adb6:7957 with SMTP id
 5b1f17b1804b1-490b6105874mr70915055e9.33.1780506503880; 
 Wed, 03 Jun 2026 10:08:23 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7c6b966sm59331615e9.2.2026.06.03.10.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:08:23 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH v2] net/af_packet: fix qpairs argument upper bound check
Date: Wed,  3 Jun 2026 20:08:11 +0300
Message-ID: <20260603170812.212262-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260603044228.117357-1-denserg.edu@gmail.com>
References: <20260603044228.117357-1-denserg.edu@gmail.com>
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

The qpairs vdev argument was parsed with atoi(), which does no
validation: trailing garbage is ignored and a negative input such
as "-1" wraps to UINT_MAX when stored in the unsigned qpairs field,
passing the existing "< 1" check and reaching rte_pmd_init_internals()
as nb_queues. This causes excessive socket and memory allocation in
the per-queue loop.

Parse the value with strtoul() and reject non-numeric input, trailing
characters, negative values and values outside the
[1, RTE_MAX_QUEUES_PER_PORT] range.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ccd37d341e8d ("net/af_packet: remove queue number limitation")

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
v2:
  * Replace atoi() with strtoul() and validate the parsed value

 drivers/net/af_packet/rte_eth_af_packet.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 8303ff5ca9..b7758a5c75 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -1168,13 +1168,20 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	for (k_idx = 0; k_idx < kvlist->count; k_idx++) {
 		pair = &kvlist->pairs[k_idx];
 		if (strstr(pair->key, ETH_AF_PACKET_NUM_Q_ARG) != NULL) {
-			qpairs = atoi(pair->value);
-			if (qpairs < 1) {
+			char *endptr;
+			unsigned long num;
+
+			errno = 0;
+			num = strtoul(pair->value, &endptr, 10);
+			if (errno != 0 || endptr == pair->value ||
+					*endptr != '\0' || pair->value[0] == '-' ||
+					num < 1 || num > RTE_MAX_QUEUES_PER_PORT) {
 				PMD_LOG(ERR,
 					"%s: invalid qpairs value",
 					name);
 				return -1;
 			}
+			qpairs = num;
 			continue;
 		}
 		if (strstr(pair->key, ETH_AF_PACKET_BLOCKSIZE_ARG) != NULL) {
-- 
2.50.1
