Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADE7C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 22:35:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78F0D40615;
	Thu,  2 Jul 2026 00:35:02 +0200 (CEST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by mails.dpdk.org (Postfix) with ESMTP id 35CC3402E5
 for <dev@dpdk.org>; Thu,  2 Jul 2026 00:35:00 +0200 (CEST)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-8000e21f014so17384027b3.2
 for <dev@dpdk.org>; Wed, 01 Jul 2026 15:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782945299;
 x=1783550099; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eN/FPsHNv1I/Dmg7fVrP0+8mUmbb8zbxaSMp3rro3M=;
 b=H2PTtawZ6GmPAig5S/f3O1ePKfLR15n5b9jItI5bTJg5Vfy/JXNIRr0EbAuj4zIkpe
 LY65raWnpCzMlL+8xGA2L1tL2aYT9K5UVqD/xqTE0Pb03dOQnC/jyLYNusVS6sNA3hzz
 fSbDoYUHCd3krsZc9qtoJcOcYXmAIKYo5ZHfW4TE33z5ZO0Nal0+HQVCj51vWI0MXiUh
 b/MG8kmNjJfVZcv3LI5ZJCywDllm7iPxb88IxfRCAdPIbfh1aFNaRXvpI3ArxgdysldD
 JArF/Sak6wVY5qEZX119Ol0+lujDXJ96k6N3tcbq09UX9PFP8YPicVAh4IOj8Fscg+/V
 a9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782945299; x=1783550099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3eN/FPsHNv1I/Dmg7fVrP0+8mUmbb8zbxaSMp3rro3M=;
 b=LS13JUDHlng9mD+z2G4h9YIlS5NVI+8fkvn6GCcuRRaU1kF7ZlrmcMN13USxlUNk9Z
 NBegBRy4jE39urN5CLsiHmRWfyP8cTlMjGVyMQTfJZc955TgV/3dhQTWNvVeGSXljD07
 gxUPEW0cb3HtLUX0Cnnm4IKKFrNmts1KCPLvDOldLNFXwwQG4v7QrtDFIYZEoh6X2JE/
 XDHWYxvoTpyHuefTLtVBhEWRw3u4e9WeY7A3/Lr6Jw7Q+hXUfoA4jlqQm6/habBoJAvz
 ECwKASY5PI9Hrrg9YHa0G9aarHMsay4+p6I0yLyS3hmjkeheM9bjIOcUxMAcgoaU+gUq
 hZ7Q==
X-Gm-Message-State: AOJu0YzjCrDmwXMIke/O+22aIinIJcyYJCakNutXuNioCm4wKQafqxd4
 a8xiAMat077w4S2S6vJSVD5sK8xA6ckZ2wLFVDkmu9270w5qbCBapn7eEPpYuZskLVfzbEnJK4r
 cJ1Jk
X-Gm-Gg: AfdE7cmXCf5obwYnqByxIgfvINDA70EEALBfrLCbsc0yBWNxDOOGzZWMwASRD6FZUDH
 ppBRHcSreL0A8s4A32H6saG4rcjBGlhPvTcvykyomX+EM3/ALQILVckqTpMpzHKkkseU9X9L2GX
 tUavXzTrjPm8Nv1zlrVGqIprEaambKPbL8c9YCU0GoS3HQf1slISC7Qm9HAjGys2s6jBEuEv630
 TCKEXSYoB6nPv615Nrr8eJNdsgE4bwmuQGpXZwMnTaW0n4i9j8KxRbzAMFqpT+i9l6fQLelttil
 p0JJhyS5RxCoYrjWb3bgxW7ikFeymH9yz7wSMDdemlNGl899w/ts/ijeH23hQEBlPdU4bwpG6FW
 fdW/bdFwXCZY72QInjX9O5oAalUFSJi+/TSrtkwTvVgxj+4wMJtiXdGCnSwcQRqMj0fUaOh02SJ
 dVu854amNwt8bmhJdZSCO+mUg40jHIni2CjsdaigP5ZxeQ/bkdTic=
X-Received: by 2002:a05:690c:4d47:b0:80c:85c6:8993 with SMTP id
 00721157ae682-812ebe614b6mr43197287b3.66.1782945299350; 
 Wed, 01 Jul 2026 15:34:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81448219f1csm5678887b3.20.2026.07.01.15.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 15:34:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH 2/2] bpf: silence noisy message
Date: Wed,  1 Jul 2026 15:34:52 -0700
Message-ID: <20260701223453.104660-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701223453.104660-1-stephen@networkplumber.org>
References: <20260701223453.104660-1-stephen@networkplumber.org>
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

The recent loader change causes a log message every time BPF
is used. For example, running dpdk-dumpcap cause:
 BPF: rte_bpf_load_ex(): successfully creates ...

This is a debug message and should not normally be needed.

Fixes: 55192fe168b9 ("bpf: introduce extensible load API")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_load.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
index 2fd0ee0720..36f6556fd5 100644
--- a/lib/bpf/bpf_load.c
+++ b/lib/bpf/bpf_load.c
@@ -286,7 +286,7 @@ rte_bpf_load_ex(const struct rte_bpf_prm_ex *prm)
 		return NULL;
 	}
 
-	RTE_BPF_LOG_FUNC_LINE(INFO, "successfully creates %p(jit={.func=%p,.sz=%zu});",
+	RTE_BPF_LOG_FUNC_LINE(DEBUG, "successfully creates %p(jit={.func=%p,.sz=%zu});",
 		load.bpf, load.bpf->jit.raw, load.bpf->jit.sz);
 	return load.bpf;
 }
-- 
2.53.0

