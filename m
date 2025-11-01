Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC09CCFA00
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Nov 2025 18:07:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CB05402AE;
	Sat,  1 Nov 2025 19:07:07 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 44AEF4029A
 for <dev@dpdk.org>; Sat,  1 Nov 2025 19:07:05 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7a74b13f4f8so2228026b3a.1
 for <dev@dpdk.org>; Sat, 01 Nov 2025 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762020424;
 x=1762625224; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rA8EiWVnhpMp6cbDfPELHixzWAeKYEMozJfdgptVuIU=;
 b=WkC3yDtNIxU9yViWlUIiqmPATNYkyywU6OI8qcqqsuSmjpDuAV4BGHYb+bfZVYWyeA
 U0DW/W/BGUIi7daemJ4S6pZPNiekKY8Ktd7B7T7VqutiXQ77RkTMCGaF9QZeNsGymXlv
 kbnbD8a/w0p1GqVX0H8/Gfl/FphLiIKs/R8Zcfy1QVDDeNXx8GzdmXU1ZJbmveRthygs
 A2N+xlE1M8NIcitL3Ab68Cxi+qsDm+XeFGnaTH1o2oLoH0k0HbuIzZowlTbU5Kv3DSRw
 Fh7jV6I3f+OASTHnHqYiPPeqYgyEPQAZYj/ERA9Y31xRiNGytL3I8OajOreO3unSj8Bn
 pWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762020424; x=1762625224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rA8EiWVnhpMp6cbDfPELHixzWAeKYEMozJfdgptVuIU=;
 b=orwbgVFu6wDJxsyk23IVKrlqJrzUDdq0s77F/r66Fwtk69uLxhqp+aZebWkhd4y4SQ
 okFvmfLjGKbeSujaJlvwx0qT/+ipVpIzJIbj5Gl/82kkS69W9EcZMutN71wPsxUtSJPF
 JGPW55SeZAps6/TbMFsoJqncCb/s64nzOt3OVoF1usHDU/tMkG+ma5qM8iV/HonjJfWV
 NQgztUAFVrV2TrJhveCdATetXsX4j/+BG0zHGC5L3bscG/x7PctgM3xowfA9wfeRF7dl
 egoh7tVy7umj2bWVDDwS17k8409YpKi8kILejdXQXJyIRgCprwQoa1cCFixTyAbaJSM0
 Nfyg==
X-Gm-Message-State: AOJu0Yxn/JSAlZq25mvtVNgKkAOm2D6NA1EfmKB1bR2UPlIfn4Kj/gQu
 o+At4Som53CFCFcKwrCjWNMJptd8+AJjDfMhs4+/Meue9AQv3GlSl8Lcj8scRr8bn4sqgnPk5AH
 e0S+w
X-Gm-Gg: ASbGncskfLMeXY09/cAM2ahAowhmgeQPNeE7ItNWq3+mFp16HFdQvQaw1YfqHlTE/E+
 wNpfNWvTTbK7CJjp8h6bXUIEFK7dfgfCABcw7xqQPVQPHZJXBBmfX2cvLNqk2ycMQ6StHulAapE
 cFBwvWY7T5HX6XI9yqNmGzyVcK1iGOla4KQDSFGQwi6afskTmpwsq7Y/dWWKIabw314eZ4Y2meM
 v2bu52f95lhQCc+xHPyelK0XRDm5OkvLOdg4Ryd/URuUdZmPt6xJt74wJiXKZ5PdeoS+CIbGkJ/
 rg1MYJpmn+RyOLBLWSn3TX79IDv8ln8iadHucq0gqaZuCsglKPmFlBFl0BzTnj9Jv03Sctr8PK5
 wxm8B8MSXldtuULHRgWqDaNGxmWFtQEai0klkO3IxRIZccibDgPc4pl1PYdmfNfMSJFOxxWkeAn
 AzKfl9U150BK97rxjbhqEXFn5adQateSezAf/1h+Y=
X-Google-Smtp-Source: AGHT+IHZsufNgi5KX9pFxgRnGlR1v3D2pIEDScOx6BUzwoW/X0Fu+YLL9B6MnRoko9GpC7PKlwyZFg==
X-Received: by 2002:a05:6a20:394a:b0:344:b905:a218 with SMTP id
 adf61e73a8af0-348cb68c663mr9929297637.27.1762020424342; 
 Sat, 01 Nov 2025 11:07:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db0a019csm5861606b3a.42.2025.11.01.11.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 11:07:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 2/5] bpf: use bulk free on filtered packets
Date: Sat,  1 Nov 2025 11:04:44 -0700
Message-ID: <20251101180659.43883-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101180659.43883-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251101180659.43883-1-stephen@networkplumber.org>
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

When rte_pktmbuf_free_bulk is faster because it does single
mempool operation rather than per-packet.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_pkt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 01f813c56b..087ac0f244 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -177,8 +177,7 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t rc[], uint32_t num,
 
 	if (drop != 0) {
 		/* free filtered out mbufs */
-		for (i = 0; i != k; i++)
-			rte_pktmbuf_free(dr[i]);
+		rte_pktmbuf_free_bulk(dr, k);
 	} else {
 		/* copy filtered out mbufs beyond good ones */
 		for (i = 0; i != k; i++)
-- 
2.51.0

