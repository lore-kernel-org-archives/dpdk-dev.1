Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69103CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 21:37:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F4554064F;
	Mon, 11 Aug 2025 23:36:49 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 994F24028B
 for <dev@dpdk.org>; Mon, 11 Aug 2025 23:36:46 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-459ddf83023so29526985e9.0
 for <dev@dpdk.org>; Mon, 11 Aug 2025 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754948206;
 x=1755553006; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOXgNgYjowDSirKcLph07+FECQ4lcDSBMGLHnhZoaT4=;
 b=KF/4QX+f4huI/kjZ9WewtMPXVFrF9gepdrRPFo1kN38/IEBv4ATEeBFffRExpKYTcx
 A+xPgIn1RGr4kz9KZSW7MEpUf3sd1Q+zgcsKhYWvr0GlDbn0gCh9UWd4Qj3b2ARYedfc
 QwmqT9gpZV/H6Syrb6NPfNUgaJiP1sL6NiHWRbm4r+DrQ9ZEyQ5oDNilakTf0E0qS5PW
 xZ6HGV+YZOcRKcyGL/2/T0Iybu1oAPzwW9cqp7RjqtS5bzrjDl29g91HpHatuplg1dKc
 /m/tQfQH08IafGJL8a6mxL/BCee420vYvJ1GGmWqmX/yYcg02ZrYjbxnmVAZhM+9MaAg
 nEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754948206; x=1755553006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SOXgNgYjowDSirKcLph07+FECQ4lcDSBMGLHnhZoaT4=;
 b=j6f04qBJiL84x/OD1rI397T/Cyg1jZJmI9Qk1N1lL2KANUizE82uO7P9NST7s8Hw0K
 0MRU0AOvGyc+AtiHwopqYzUCJ4IOI3uRAQVVOsMr9wPzF7wuSpbuhGOBvGqapPT1HMcB
 ZeaYbhBcc+lTNvYRYiaCiJ4U0VzWSgjp3XqAJ9bOJuf6+ioiu/1cqWoxTG4FwDi6g9lo
 iCjyWSzEtDvWd7DVOUau2IanhZpwl4gZyJR4TAfyRjqxVoaEgGl8czt4LXkh3aPexPqk
 e7yLLLi5Ok7gpyjJ3fCGxFvc3opEYD9mxkL4wx3SySBbNrg0UxTT6Vx2yMYohE9/rEHV
 QutQ==
X-Gm-Message-State: AOJu0YwtVY45bGdKEWcpGsqPw//CUyo9GYzovb/ngaDgBl7bVPEaupC0
 4P6IVovLAsgvAJy0fpi52Q/uCeRQDYzU4ywySI1ni+33zKncaVhrRFMWQDnuCoDK1IWVRyQXl4r
 OneLN
X-Gm-Gg: ASbGncvfwQK3yMQtujQYSEMkxI9gbVTZlTyZn9txa4I+TRw4SHvQNtHPSx3kbQfhdUq
 vrmFDs1K/fYweclrRttmFmrnArDWMPdKR6bS/Yqc8ukyeVdEI/3wh5MaGSwcN4XrhFjQrF0BROL
 kfC9TN0Zko/ltNy2frzYeuZm0XGec9tx5YML0F+99k9BCDerhP+wBDixz1boFbiwIAqbNgag5nD
 L2sDI+fZzg0b2HK+z86xWAPxIcYu9m4H6hybMJIV+y4A+GFeAfedp6UKVLF8vaj9sFxJHAUhBQv
 zgSoeaKyg2R9iOVWlagvIPXxeIVHKRjU5UgA530cRfxLIx+/OBYheiHMwWH7Kf/m+ECRLovIFmg
 px3LRbWvA+NtQ6kFdMgPnKqX4wpu0t6fjSiGMHxtpqiHBi/TSzslLd1kncR1p1b50xsy7Ovl7
X-Google-Smtp-Source: AGHT+IHqmZMt3XUUgM93nMTy2EvXeR5p1zZ+5udEDC3ADDdyf6xenqGdz637JKn7v7ziJId90wDL/A==
X-Received: by 2002:a05:600c:3b02:b0:459:94a7:220f with SMTP id
 5b1f17b1804b1-459f4f2b0afmr121921995e9.26.1754948206206; 
 Mon, 11 Aug 2025 14:36:46 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a053a9019sm84661445e9.21.2025.08.11.14.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 14:36:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 5/6] pdump: handle pdump requests from primary
Date: Mon, 11 Aug 2025 14:35:03 -0700
Message-ID: <20250811213632.16023-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811213632.16023-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
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

The primary process will start to notify all secondary processes
about pdump changes. The pdump secondary process can just call
rte_pdump_init() and it take care of that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/pdump/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index 1741d7e709..626ba0ce93 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -552,6 +552,7 @@ cleanup_pdump_resources(void)
 		}
 
 	}
+	rte_pdump_uninit();
 	cleanup_rings();
 }
 
@@ -822,6 +823,9 @@ enable_pdump(void)
 	struct pdump_tuples *pt;
 	int ret = 0, ret1 = 0;
 
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "pdump init failed\n");
+
 	for (i = 0; i < num_tuples; i++) {
 		pt = &pdump_t[i];
 		if (pt->dir == RTE_PDUMP_FLAG_RXTX) {
-- 
2.47.2

