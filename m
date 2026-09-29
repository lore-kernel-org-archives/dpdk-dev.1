Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F832C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:04:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15EC042DD6;
	Tue, 29 Sep 2026 16:04:18 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id DE30642D27
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:15 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-8805988a200so2715343b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690655;
 x=1791295455; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=EvoSjtDjAjCWUg1PaFGNupKYPCijGrMjcHRbHBo+9Ptmxtt5N3d7Y8/7Uxn8hu2aJ0
 Ga6z8Um9ZWqzVF46neIs02Dys0SjIdRzqBoFCoUh4AOAXoMOxLKq/lKJE6aXN5EHWYMi
 SSD5Jer3ITrf9ImSzBZ0izZ7ObMT6u4g8Mu7+QalQapTPW8KzPmXf1k8NBB7s0AK96Vq
 9OoYvVBKLuq/4xDjtVnzbOhz2030I79bZxXXf6pGPlHevruxx21EG86OlhAkiIX0Rq4J
 7TG0ER0x/qoeKBTBbHY8iKMpQZAJenc7YMO9j3h8B0nOjP7AVYb6o+6CIHKqR3dPinkh
 F/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690655; x=1791295455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=QuoKCIWLuCUEllI0c1ggzlL5aduwQzdraxFlTZaP9mbnonJN5870f2j/WuSFbK4Stt
 zE6O83SgmMkP2rGz/cwI8/K5Fch4qGoI1XvH8i/P8C4OdBRDHdipUHtVhFvo257Mf86k
 jwz/R64a9G1vYSFFEkeKnqAjqX2qmLGl21Jyh7x3ekr0WPlU/tCrrgcZ2Rm3WqjmLJ/j
 p9SjYqhO21rQYe0yjM/DMQE4E0lVtuJZjL5pWo11fSarBBV4L2mKNvIuhXn9Nl2uQ0Ha
 lkNZrztzvXyZutLo4MuX7wWKByRNc1o5XmmjkAYGr7vZHRdeRXHkgFh5oXvfIQFlJU6b
 30Kg==
X-Gm-Message-State: AFuF++kUG3PPjpMQf06RGz/xr38ll91yj3mhWXW2Z3dbKM3IndUDq8Ot
 SkF2ucEOsezqw8CnLyeAE9LBD0lOGk3AKIBi6CkQO51WDCMuIE5eb6i24UL7z9WhJqZgA3f260E
 rRsF1EMI=
X-Gm-Gg: AYBFou0xBpuNEthQiusdfok07ctuBX6NTAU847Fquxz5e1RTA7TU6JysatqEr6tdJYU
 Q2cfiu69OLHMBhxxVBSyzNSJDq10iVK3aujsJlpwT37kxyHYMgeYV/ZoMy1HQaKqDHyRbsOzN/M
 5UawtGSbMfe+qTmqeJ58rZgf97Rphe4qT84AWrBMihPRX2fmBQ3aO9qmNhcHiKsG2hv6S1EW2wi
 ARXiCJnQnTHRdhoA6SveWhejCyOTsOLGynojxGkjutLxW83d9XG6YmNN89XyNd+nMsFjeAlrj6B
 yB2z0sxorF87ljJ6x4UjQ00AsjaMohYOwVQtR4iSD2zyDhJokR4ytCZWjR8k16EFXVzsDlTbaUZ
 1f9KsXYs0a86Rr6MbsVGAptMcZ4MyNtgrkgnLPAxP07XiU9HZ0AWc+5SscCozE4fxwYvKPTwDf+
 AjHA155YUCcqBvF9i1xxmzHFArHeGOCubIuiQ3jX3eE3TRYWAQfqJrzaNlK1UWkzQDwHZbleMUi
 HPBozb2rn28J4tQzcHxGMqgQe0k6PckV0CWvk/UFAmhjaoV
X-Received: by 2002:a05:6a00:bd10:b0:85f:3d78:79cc with SMTP id
 d2e1a72fcca58-87e9c543e95mr12080915b3a.9.1790690655034; 
 Tue, 29 Sep 2026 07:04:15 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v9 03/25] net/nbl: remove unused rte_atomic16 field
Date: Tue, 29 Sep 2026 07:01:49 -0700
Message-ID: <20260929140409.234453-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

The tx_current_queue was defined as rte_atomic16_t which
is deprecated. Remove it since it was never used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nbl/nbl_hw/nbl_resource.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index bf5a9461f5..f2182ba6bc 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -225,7 +225,6 @@ struct nbl_res_info {
 	u16 base_qid;
 	u16 lcore_max;
 	u16 *pf_qid_to_lcore_id;
-	rte_atomic16_t tx_current_queue;
 };
 
 struct nbl_resource_mgt {
-- 
2.53.0

