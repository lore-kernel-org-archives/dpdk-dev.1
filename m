Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D974AC88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:50:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 303C640B8F;
	Mon, 14 Sep 2026 07:49:56 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 8BDA54068A
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:49:54 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cebad4aeso1463814a12.2
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789364994;
 x=1789969794; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IhRq59k12zTMRFLNUpvq0zS183zGa3EeTpW/mN/RCwg=;
 b=eaZes4Axrj8wc15TVcRitH5KPwXFDiiqP970mUVOGfJbirjl3xoIF62e5yG4cFE46N
 D6B0NtOhD4jsdyz1PLbN9Koy9lzJsXgIVpauJdygPiD14iVIl3GKYHgySJaF/Ce3dR9b
 weoCs8wq913hj3NTXxMWZi1IiFaZi3BustTFHH5s+6qp/M+2YHXEupkXrOKAkNCyzRZZ
 XeO2Y8rErcxkFg0EpJuQ0tXgKBCNX3fitARVwaheJXp7FtajdIlrXW1TKmhx65I//cAj
 BEQr+HhQYBA+EMe6xLZSkP0r0MsE/bLUCwSjSqgkR5vDZriZAcS0KP2Hp+NSQhMwufAc
 bVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364994; x=1789969794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IhRq59k12zTMRFLNUpvq0zS183zGa3EeTpW/mN/RCwg=;
 b=W9HCPgP0BYFca2PCvWNRqTNI+lM7qV2Cf1QhFmAo8c3SqsOVsybYuZmTe6yZ32TiYs
 3/Gvw41N1OqBE3Dpki+cq+pWy0WUz9/LMXgeo+jU9nNidYCXOzMdXsdJC9vgm8moqSCb
 ZdJF6DsVl8Bgx1JwIKGUVg70Pj5DmB/B6YFwqyxqLcpfaSfIEcx6VXuIR61myronH1Ti
 yIE9Xq9uK4FN55KtVJnYZGkrGQs/R/r5bcO1VB13RJ6WV+fvSIDaqmC3+OQ4S7Acoaoj
 dcbIu5yjDCJL0ktfjsfEnsTx1oHujAMFfK+nnDNM6M1pZOYW6RnbJ9un1RQyW0h56I38
 VC3Q==
X-Gm-Message-State: AFuF++k+9bjd7q5tLHYoV63OCZZUCinI06yWpbV7nm9UvGy932nrOOjU
 OOebP03aAfu07LP1L/b694ZHayae4oN/fZtGPVMOdTf3FuDeZPZPE2hxM9Xz7YRxGCM0pNsC/Ch
 jeEAo
X-Gm-Gg: AYBFou1d+tphaZtrd4JO8OfIQP4X6iIKtOVe3V7fsgemIopiWHjnYWjfaqRGp4cfKB/
 0DQsFF5ld3oD2GepfcXqTnaa+3nR7SrhZ5ulrj16xSD5xy1nfVXlXo4SWDufFv7Jj/+nvUK6VF+
 OvMqX9qEKqT15Jz72JY02s6WBlP2gt/B+rlRHZSr4gUFT1dLN5jVE5B5Be9y+OZuo/iIesL9Kt7
 qF2pm5h3HhVRgDl3rMwyjTbgN9uuFZVqzJBAYaBfFG7ilfTJDqkpMBwt7uCxL6hlqpwBx0pespG
 8XvBxTfrb/iMXvfeNFTvybM9NDDJwQ+9UO0IJgyGSIiQARnp9IzmIW6SYrNRXWYuLutgcBuHUTp
 1HpxgXTCRK7RTkxkGUbdqAUW9eKLzvuNQzVnoOH6ls4z6yTsAkyZwJqUxrJd9hWjiLblhnIvryU
 eZwDwO12ig+sPSiM0Y3IrRGiSNRmqt6dNjSc/h2P3vITid8M+Co8/Pbq45OxGOQrmoVCQSQtivz
 bbI2LlM1Jvej+ERX9NIJqcNPfUw4+klLGb5tPcWQ6sapro8
X-Received: by 2002:a17:90b:3f4d:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-39dec06086amr2960714a91.14.1789364993744; 
 Sun, 13 Sep 2026 22:49:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:49:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 10/62] dma/skeleton: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:41 -0700
Message-ID: <20260914054912.755403-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

The lcore argument is converted with atoi(), which validates nothing:
a malformed value such as "abc" becomes zero, and the range check that
follows only catches a value which happens to land outside it.

Use rte_kvargs_to_int() with the lcore range, and log the key and the
range when it does not fit.

The parsing function returns void and probe does not fail on a bad
argument, which is left alone here: an unusable lcore still falls back
to the default. Only the "Parse lcore_id" message is now skipped when
the conversion failed, since it reported a value which had not been
parsed at all.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/dma/skeleton/skeleton_dmadev.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/skeleton/skeleton_dmadev.c b/drivers/dma/skeleton/skeleton_dmadev.c
index e287802eb9..44158d5a7f 100644
--- a/drivers/dma/skeleton/skeleton_dmadev.c
+++ b/drivers/dma/skeleton/skeleton_dmadev.c
@@ -638,19 +638,24 @@ skeldma_destroy(const char *name)
 }
 
 static int
-skeldma_parse_lcore(const char *key __rte_unused,
+skeldma_parse_lcore(const char *key,
 		    const char *value,
 		    void *opaque)
 {
-	int lcore_id;
+	int64_t lcore_id;
+	int ret;
 
-	if (value == NULL || opaque == NULL)
+	if (opaque == NULL)
 		return -EINVAL;
 
-	lcore_id = atoi(value);
-	if (lcore_id >= 0 && lcore_id < RTE_MAX_LCORE)
-		*(int *)opaque = lcore_id;
+	ret = rte_kvargs_to_int(value, 0, RTE_MAX_LCORE - 1, &lcore_id);
+	if (ret < 0) {
+		SKELDMA_LOG(ERR, "Invalid %s, must be 0..%u", key,
+			    RTE_MAX_LCORE - 1);
+		return ret;
+	}
 
+	*(int *)opaque = lcore_id;
 	return 0;
 }
 
@@ -673,9 +678,9 @@ skeldma_parse_vdev_args(struct rte_vdev_device *vdev, int *lcore_id)
 	if (!kvlist)
 		return;
 
-	(void)rte_kvargs_process(kvlist, SKELDMA_ARG_LCORE,
-				 skeldma_parse_lcore, lcore_id);
-	SKELDMA_LOG(INFO, "Parse lcore_id = %d", *lcore_id);
+	if (rte_kvargs_process(kvlist, SKELDMA_ARG_LCORE,
+			       skeldma_parse_lcore, lcore_id) == 0)
+		SKELDMA_LOG(INFO, "Parse lcore_id = %d", *lcore_id);
 
 	rte_kvargs_free(kvlist);
 }
-- 
2.53.0

