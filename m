Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC7CE63F08
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 19:54:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E688D40673;
	Sun, 15 Feb 2026 20:54:10 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 97AC84066B
 for <dev@dpdk.org>; Sun, 15 Feb 2026 20:54:08 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso42312105e9.0
 for <dev@dpdk.org>; Sun, 15 Feb 2026 11:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771185248;
 x=1771790048; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQhpnNuxAvt+nBkxDxh9lICqOMSxbTmCNWLKD4I9tV0=;
 b=VC7f5JMYZeuqJyGE7DP5rbO+CCtlR3nQzn8BoCZYun49CLNhGh6Z4nFFPgAVH3rwTV
 F8fPRkrvcOsjXtUSv0rdaFb8skUAS3oLYKvGNccfbQGPB+T1i8mMbHR4oX2GZ7TEEXuS
 rSWqcOjFsHzSPFjY8GfJ749r3hLRzQJ++jf/VZU/1je5N/9j7zOfz8lf3VELXBsH4Y+e
 ytCMVcsu/2UMBroSPH1XIBMibrae8Vc1TSLMFurMhkqNJZTqRt2f0GrVfi8dciZvISfD
 ACjWVzXYcN0SJUR3oiOMtu/++qvw+95L3d9bq2mK5fu+vfu5fpndBKXEXqrPQlsOdPPy
 pXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771185248; x=1771790048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FQhpnNuxAvt+nBkxDxh9lICqOMSxbTmCNWLKD4I9tV0=;
 b=FXO/uHpfGs9rqhBEPaLmm5mMdWyajKXNwivtfqTX4ZEOKsvJ82mjunU37VfNOmuvwD
 pnoWtBnoQsM2YShxgB1SZAzUJn8yEEL915UGfyR+mXFzk3nQcZpIzJ1OBkGKGUn624Zc
 5kJKBE4vMAvslEfaLqIfUL5N19s5rzBQazMjZCoqA4a+MhSGLm6ciwcSDSjqlXqTSrcu
 ZWhaAhXBvC4fbU3xW1R7dyr0RZLVTsX1iEsCx0SaFbZBO8l9vsDaztgRpeXE8jToHo9o
 YqAs/FbyLrgwja3dxPRY2Scg93ySHujuAT3sv/j5bZLsxuigoN6MmH6KfoV94KP1WvnP
 sucQ==
X-Gm-Message-State: AOJu0Yxs/pg0zh7uVn4QuLGpY8OjAI1U86xfy16q9zjLIRhuefgrcDyC
 1lisV4A5o6uarqbk9pLNk7zpE5FPgqEwZi4gT1Hu7ZVcuX/NurBefcypQd0LVX+xAQGQPHgR/1Z
 Q2wwQlaA=
X-Gm-Gg: AZuq6aKMAPM1rQ2ltl4dX0fiAygSHHloWysympVgrBcvKMj8RIrxF2Vz06DoxoX2IKd
 n2rjBDf9JVqZSBmOPuLesVJAbkw1+9OAgGHi+0YcT6XzWmPn6zUip3Lp8CX2M6123uDC8DoXdMH
 wI81e/StgxwthWrjIAnKlCDXPqkBUxOsT+asPTlBnn8xBZ9k+D1aPFpfQ/QULb8Y+wqGnJu4Wpi
 bTb9NIuG4Yn2HAoXCpxJW/k4vB6c3RXVIxktcmE/597Upah56pYKd10ajhuF7vu8b8T1qzljMXh
 RlTAdOBbZ0bg1GBO176Nbo094W/yA+0tqIv8U5dEypxWBlKjOfyzqe3qOe+XGfZC2V73Cnb6eyp
 IG79HLbblOCamjEed2ujo7irR9fL7+T49WPN3VVMK0VgLwxaGhNxobOV9R5HyUGI08pyr8o9lch
 mZMGvlDn6advAHyS23C66KQdi335/1m0XtkuhNk8AAcSNfumGfLUQoFcvAo6nFtQ==
X-Received: by 2002:a05:600c:4e8e:b0:477:991c:a17c with SMTP id
 5b1f17b1804b1-48378d62cbdmr117532435e9.6.1771185248153; 
 Sun, 15 Feb 2026 11:54:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm526490415e9.6.2026.02.15.11.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 11:54:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Herakliusz Lipiec <herakliusz.lipiec@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH 08/10] net/tap: free IPC reply buffer on queue count mismatch
Date: Sun, 15 Feb 2026 11:52:26 -0800
Message-ID: <20260215195348.557945-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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

In tap_mp_attach_queues(), if the reply queue count does not match
the number of received file descriptors, the function returns -1
without freeing the reply buffer allocated by rte_mp_request_sync().
Add the missing free().

Bugzilla ID: 1881
Fixes: 9ad43ad8fbee ("net/tap: fix potential IPC buffer overrun")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 251b05b27b..6676a40d69 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2407,6 +2407,7 @@ tap_mp_attach_queues(const char *port_name, struct rte_eth_dev *dev)
 	/* Attach the queues from received file descriptors */
 	if (reply_param->q_count != reply->num_fds) {
 		TAP_LOG(ERR, "Unexpected number of fds received");
+		free(reply);
 		return -1;
 	}
 
-- 
2.51.0

