Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4DAE9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 18:16:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F55540269;
	Wed, 18 Feb 2026 19:16:27 +0100 (CET)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53]) by mails.dpdk.org (Postfix) with ESMTP id 7251D4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 19:16:26 +0100 (CET)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-4042905015cso57767fac.0
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771438585;
 x=1772043385; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=10U0l4zcp0yPsJWfPUAGk2LeHWrMS/JxoDRQdODu8Bg=;
 b=REhilE9pvGhe6xTBVJDqDxuO9wEVRuBY69+dw4c/3qmyPzW3ylsVmGgcOT5zn7vtDf
 u1r3xwmAKAiAzn7zUH86zGGOuX2xQ+yC9ffpL70tQtAghtVOR3AQuIhM/q6Hb1f+ZttI
 PRqnq5ORHbrf8dpV4FR6UgFDDTAjetmXyLY1mpPOZV9A46kE6PssGLEsic2EkrjxjKKU
 qmofkV1yoS3GukcGSOh1eW7JeJoqnLyUxTtyv/LLAcsqqSXoJ8rcLgsLFTrIcwpEaPpF
 TvBLuPGu7VYcWgCH/Dk6vtYdnVEB33I9UOglmRKlAGgCfLTOnoQ6Iyex15NtZ3GwhhvJ
 QYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771438585; x=1772043385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10U0l4zcp0yPsJWfPUAGk2LeHWrMS/JxoDRQdODu8Bg=;
 b=HOrg+ny14p3EZVptHKSjKFbpHOVpSynSvcKk8sptW+R7VEIxUo67jiGVG+SFm+O4WH
 gFQ8kvCvAlOBKKBpp6AD4R0J4zKbbqI5MyCBmGIJABGK+7MD5tUgiLthZhM3MRHWEz4C
 t8w9hu8eMSMcjwPBPqaGiij2ImG1Y/Sfd84DjwTqzxsmT3ww1f3v8dANsXCDcL5GabW0
 KNXflWzvjRlIYJXad1Dpb2PPZjq/xbqUBQGFnoH6u2Stub8sk89O2wDjux3vHYfcdLXs
 zuVJisuhGgKdN2Nc/3ZZa4MaWof8ODQYn9XukRsck0CWhIYYEjpslX7VvLOOd6dXOf2h
 Q6Nw==
X-Gm-Message-State: AOJu0YzhaWmJaslQiFnFwXU68+fKlXxd5tiFAULXEBlhFzXUF6x4V/0O
 cBLde9QGHHJ43DSdVTCkkqckOQ7hgXBvbBQ/IHfvrVWfMBIwgG5Mq4zji9qLKsCv3bI0Pheigbi
 YtNUh
X-Gm-Gg: AZuq6aJNg2g7ubDgTnutTl0K/cVB1nrW0Z3R6ogw1ajm26zafk3F/D2l57TgNddNKqP
 c7KE8DOpDEt8oXRS4HFBayyNtmwzu7FVMgw5pfa1TcNuhMJsO6YEcRI7Ih2IodTsEniR547kD5g
 hNixbHBthSTBh1AycFH2PfvJFC6x+Ry3lg6s3C7y+uFD4V0jn/dFQhLOUncv6B4+Ij9sHXJtGR+
 PI2r6j3fJU3Ur67uU2GAStgrlpFqLkvY85GKUlvB+dUhL1SDr9RUi1bx8420RUf/IIv4khxCMsy
 TzWnLLVwFfFQgDZsyyOacYXQeqldNkm12hvJ9HXOO/XfYDmE99r6EgJx8R/jPwQJrJ3cvGjO2+N
 32hMqHeSDKsvfu/7sSKeYjPWdXjA7P629I3knRz1eCT/ulhWlDurOeEScwilfn9sB6gL9l4uGKf
 KYJs8v+HO7odk8kJBBZ44rlLDHzrcEj92pK3v1SvIgw6Wb1EUhdo5FDe+t5bV8lQ==
X-Received: by 2002:a05:6871:8a0:b0:408:4744:ce28 with SMTP id
 586e51a60fabf-40f0d9f4321mr8646289fac.57.1771438585278; 
 Wed, 18 Feb 2026 10:16:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf1e854fsm19138069fac.20.2026.02.18.10.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 10:16:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH] net/nfb: fix eth_node memory leak in deinit
Date: Wed, 18 Feb 2026 10:16:21 -0800
Message-ID: <20260218181621.1066237-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The eth_node array allocated with calloc() in nfb_nc_eth_init() is
freed on the error path but not in the normal teardown path via
nfb_nc_eth_deinit(). Add the missing free().

Fixes: 9b173c0f89 ("net/nfb: get correct link speed")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfb/nfb_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index e267dca9af..ba7c849a4b 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -186,6 +186,7 @@ nfb_nc_eth_deinit(struct pmd_internals *intl)
 	for (i = 0; i < intl->max_rxmac; i++)
 		nc_rxmac_close(intl->rxmac[i]);
 
+	free(intl->eth_node);
 	free(intl->txmac);
 	free(intl->rxmac);
 }
-- 
2.51.0

