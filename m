Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6983CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:19:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C523740667;
	Mon, 18 Aug 2025 18:18:39 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 7DE4A40667
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:18:38 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3b9d41bea3cso4702983f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755533918;
 x=1756138718; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPaDuifzsFkB3UHbrzoIuWm8/YQRDpkI4y1Ngd46v1I=;
 b=insDuJfAHbNOylRLHpP1fvFoex8wCWAOyZ4EL6lOng5eWXsCLbEy+oTsAo5+k72ElK
 UFc1eqqPSLiyTfzrpZKRsqwOfgBsgLfRViDv9OC6NBbIjmfxW6tMNJ3/wjvqNIH2xieV
 0FZjDw9Jb+eAzb7mGK+HAG4ePVHcXA1hd8lEk7AwCY+Mwa6JvO5sZ8WCTkgLqsZ58lso
 iFeMDoLzdKbhF7K3ihAEr32XN4dxFeGuOZ6rPCuxrp4KrW147B/1d5e+bCVW3tDZaPEv
 Gfx1+dgkEkW2Sm4Hxk0pRJ5ZXkx9NUqy+/GkxMJIhSMcWXmZdQ8j/0mrMVNgASLwX3pf
 4InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755533918; x=1756138718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPaDuifzsFkB3UHbrzoIuWm8/YQRDpkI4y1Ngd46v1I=;
 b=YODLQWwYAVOVyc/yi2XKLH81b49KarQ8ZiqrFfgL2GOR8PN9qJyKSxAlvadnooV//U
 GxKlwi7gEXchvdCCznmDs5xomLst0xoAKqlZy5eHJE6yA4M/7XYvmCMsNs8hW/bnCWj0
 x4Dzn+orvkNkuGfKR3ahqoXiR8+nA+dWrEgBKk8RT/6trJ1QRWvoLwQSzcz+ZzBskgrI
 b+JkfZba22z9Sc0693ICQkRXtLS83eN+KSvwEcYm3GVDFfQzFZnUZj+aahrMM20jySTy
 0W3Fj22UW1ZLiInXsW1r17zeHre7kLBoRaRYUsfp7mRO+L8u7OWnIXrVtJXuZDXDtzWo
 hkbw==
X-Gm-Message-State: AOJu0YwLOUTQXXB+35XcfStooMr2NO8/159nYd2/Y0zKRl6missN382K
 IfpoSo/KcikO5m+dI1XJOdOFeJMSKw44lT+2qI8T5+stkk8UyBKorRA6B/8bx0QxP+w9XS91c5l
 vP9Cc
X-Gm-Gg: ASbGncuj2XrueYTdu2Wjm1R0cRi2b+xz8CeJIBHbRUlY9G4HsY8XYuIGsCF2/20K9aL
 Yj65wRXAOCqCmc1UEPft1CquJxparaEbjYYMpsn5E4kk/w7waN3ayNkzb5Cfd2Q0tce3Dc0W/YS
 J9qBFu0h+2Sud3gr4Ymiz7FyLKHCeFpFyS0S3ZIQSrRJ4/7Hdnk+XVA+wdeQOa4c+FBtjyMKjFV
 zs/blLzL4ag7Z1bVuiItEEBXlCIe/Nuhbl/9/WN0vVEj24hkT1A/UC8Bu1XjTINxWXZgMKi6y5z
 4TDvXnh5EOZGU1L7pMNMy+HmlaIT1Pozsw59skCOLpcZWI3GFukNDCbS8j3ryOMrQq/lAsa6MBC
 ABUeUQevN1dL7nkRIHmEdTamAnrBOByKLU/sZUgyKhJItTGmAtp8SxMHtHYBUpEaljYXY0c13
X-Google-Smtp-Source: AGHT+IHAoF1j1F7mcwrezPIwEJjFKvg5BxOyhgjyYOl8LZJaO7IdLzkOKroPF5xgzPLiDxWsu9zFZQ==
X-Received: by 2002:a5d:5f53:0:b0:3b8:d3ae:26e with SMTP id
 ffacd0b85a97d-3bb69b7d31emr8401532f8f.53.1755533918050; 
 Mon, 18 Aug 2025 09:18:38 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fcbsm147865f8f.9.2025.08.18.09.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:18:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v4 6/9] examples: remove unnecessary use of comma operator
Date: Mon, 18 Aug 2025 09:18:11 -0700
Message-ID: <20250818161815.23611-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818161815.23611-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-event/l2fwd_event_generic.c | 2 +-
 examples/l3fwd/l3fwd_event_generic.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/examples/l2fwd-event/l2fwd_event_generic.c b/examples/l2fwd-event/l2fwd_event_generic.c
index d805264744..73a264d8a3 100644
--- a/examples/l2fwd-event/l2fwd_event_generic.c
+++ b/examples/l2fwd-event/l2fwd_event_generic.c
@@ -207,7 +207,7 @@ l2fwd_event_queue_setup_generic(struct l2fwd_resources *rsrc,
 	}
 
 	event_q_conf.event_queue_cfg |= RTE_EVENT_QUEUE_CFG_SINGLE_LINK;
-	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST,
+	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST;
 	ret = rte_event_queue_setup(event_d_id, event_q_id, &event_q_conf);
 	if (ret < 0)
 		rte_panic("Error in configuring event queue for Tx adapter\n");
diff --git a/examples/l3fwd/l3fwd_event_generic.c b/examples/l3fwd/l3fwd_event_generic.c
index d86439df52..3a18001b74 100644
--- a/examples/l3fwd/l3fwd_event_generic.c
+++ b/examples/l3fwd/l3fwd_event_generic.c
@@ -190,7 +190,7 @@ l3fwd_event_queue_setup_generic(uint32_t event_queue_cfg)
 	}
 
 	event_q_conf.event_queue_cfg |= RTE_EVENT_QUEUE_CFG_SINGLE_LINK;
-	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST,
+	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST;
 	ret = rte_event_queue_setup(event_d_id, event_q_id, &event_q_conf);
 	if (ret < 0)
 		rte_panic("Error in configuring event queue for Tx adapter\n");
-- 
2.47.2

