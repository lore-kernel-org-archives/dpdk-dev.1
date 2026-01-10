Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614CAD277F3
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 17:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65AFD40E22;
	Sat, 10 Jan 2026 18:23:44 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id BD61340E19
 for <dev@dpdk.org>; Sat, 10 Jan 2026 18:23:42 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4327778df7fso3191954f8f.3
 for <dev@dpdk.org>; Sat, 10 Jan 2026 09:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768065822;
 x=1768670622; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELSiMa4VL1RSiHHKkfMVLmuXDjT+dqenjHsnemPlp2M=;
 b=UA0m7bWOAAAzhmneLQyv2qqv91Qe5GkiELE2mqqSj/ntALHjUfVU+H1WUKpWwgP88t
 FHxqj3xFJrykdTgDJkey1YePM3wpI3XldIzavbeWie4EapFS0B77RFlz0QIVMTo6rdS2
 EGRca1J0MGLhlqTB7fWLtl48c82QY8+UlGiK+80zSXwmiVTP///8PQJ9T8Q/eeU7qnCI
 M5UfvtwYg6zMbgrVKPUE9iA/Q4TOAosCN0p19KBPmakff6AdviL7m1XfiG4VWmMAXEHd
 UoCpeAOM+p60FE1l0Am7O/gcqIruq044+OrzdaPMcucCsno5GHIXIL/BbV72GPxXTcX2
 nx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768065822; x=1768670622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ELSiMa4VL1RSiHHKkfMVLmuXDjT+dqenjHsnemPlp2M=;
 b=MKO+cq19xx+VoxvjuJYGvummqrZpFxvPowGA1PunG9wSk3lqk0yeBhl/gUFUqHlsiN
 J8wxLabtVmPJoJZFJaVMqp8pKdnB8LnTWpQFMckXqvuNSCsARUV6SuKtO1t+TMv/BU+9
 z+zqrQ7ZkWGaoPSAdr3XSp+WVBGQc6kCQL016dv31XSnth7cYsaHE3HSkIJSpEQnke/U
 G69adTIQ6EGDK+C/9T85SfHma3g6O2QQSUslO64HAoGHV3DImEPjABW6YpzIadHDqwtA
 9te64bt9rVMmGM3Io6oT1XRf1me9ov3zcbrLWgAdOUw9rEdsnkuWUWaxTPdhRG2ThW4y
 HSlw==
X-Gm-Message-State: AOJu0YyxYbK+x+Px7GToQmQG0MRNTHodJF5yZfX2RXNefPZio93jFedY
 o1O8XN43p5nk2UFbru0syfmIgLqqdNR4s/Ic7tfXTZQOtBRhxzbF77sUeU9c/FPalen0WIBLQu0
 5i8uO
X-Gm-Gg: AY/fxX4iHnixbk/341bPttOYytT46TE29U7GqywH9419EHz9H7Wz1HX8k00P2zzeTOf
 L+qtoYN40Clv0o77ESyL7PeiUuM6iCd8NEYk8ThjfuoZylsr1NZ65uzJuPbaxG9XyaC69Lx6th/
 DU4qX8qIeGJc0hZdAGX3pX+mfFwuqCkMFKYgvuhP2lHwZCLyhWi4MFnphTYN0zhT25Vbc3ZJgxO
 pzWvlWRfWEASpJakkbXyGwMKwpSfJtu9OlhvO0rOqP8DwuGHqv4loOMAh7i1skAG0fjGLKgJe83
 yH4/6sg9qC2WE9l632MbEszACwpSh4trJbECb9s3L1QOowhK8+NDK4hTxhCaqnDOCJI4N6r1KiT
 sL7+Ti5t/MLJyRp+dB9FIBB4dwIo84TM6AdX4ZY+JrS7b/ZjLp8scj41/o3X2UXYlRhVuwxilXz
 iWwr1Nw3FqP+tkylJaewPkXuzJ33w57H0KJLR9jTJkogWixfSmNA==
X-Google-Smtp-Source: AGHT+IEcsvbnypWs+tnWo9NXgKvAhaWTWdfVFK/QbnPF6pTlCwYAYdR6W9zUTFH/Mmhqp3l8PB/LjA==
X-Received: by 2002:a05:6000:1842:b0:42f:b65c:1e4f with SMTP id
 ffacd0b85a97d-432c3633fb7mr15522080f8f.17.1768065822284; 
 Sat, 10 Jan 2026 09:23:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16f4sm29558206f8f.11.2026.01.10.09.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 09:23:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v4 1/3] net/null: cleanup info_get
Date: Sat, 10 Jan 2026 09:22:36 -0800
Message-ID: <20260110172336.9859-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260110172336.9859-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260110172336.9859-1-stephen@networkplumber.org>
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

The info_get callback doesn't need to check its args
since already done by ethdev.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..3e743a23a9 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -298,17 +298,12 @@ static int
 eth_dev_info(struct rte_eth_dev *dev,
 		struct rte_eth_dev_info *dev_info)
 {
-	struct pmd_internals *internals;
-
-	if ((dev == NULL) || (dev_info == NULL))
-		return -EINVAL;
+	struct pmd_internals *internals = dev->data->dev_private;
 
-	internals = dev->data->dev_private;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = (uint32_t)-1;
+	dev_info->max_rx_pktlen = UINT32_MAX;
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
-	dev_info->min_rx_bufsize = 0;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
 
 	dev_info->reta_size = internals->reta_size;
-- 
2.51.0

