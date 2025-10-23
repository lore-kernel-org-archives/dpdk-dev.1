Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2535CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 19:42:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 658A44060A;
	Thu, 23 Oct 2025 21:42:45 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id B8EE2402D8
 for <dev@dpdk.org>; Thu, 23 Oct 2025 21:42:41 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-33d28dbced5so1631275a91.2
 for <dev@dpdk.org>; Thu, 23 Oct 2025 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761248561;
 x=1761853361; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60TsemZeUH0wgbiQpawR4ldImOIf4QniqaVe6C0MBvI=;
 b=jqJiYShbWTwcNQbD3BMII5cMKtmYVnYSxX+/x9BHIM8sqomfXGpbXYRO9Ml0g5BuJJ
 atBW6CIM6e46t4pZX3zeyNF5l4t6dF+6UPz5wLWmf2jiKGONhePAX79tFaHyTdgkIwlI
 2bGPulj9teYzR46hT/WHX6t/4JWvZGhrYeWIEIZDRrP4ez7dAYVAFIyjuShFQFb0MSXu
 jRr4TKOdb8EY7y+mQTDFS8KtKIEq3IuIQKuS8ZhcnAw+HFt4VhjHS6Ty4K995EFGGRab
 qv32EhCiNNpMWw6ei3v8t12JngbgcfFk1JUWAG9UDxiwe80ecHN5+XEg4Ha/8amlqFie
 9qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761248561; x=1761853361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=60TsemZeUH0wgbiQpawR4ldImOIf4QniqaVe6C0MBvI=;
 b=InnXeg+NDnKrpux2iWE+Ijz/mDTXIjK624pPfSIqseABure0re19WDXEVFzJ+6rL8Q
 lllLzkdHi4gSOxDhDG57vmg7a5lSAH51GyHc5qDQtfVC+0os11QJ16JaeUIEk4LEVSm2
 oCaD3N+poMjBRtOSvwSVI/EjE9habRwoJ32UWglyLQlq7TSYUXELe6clJtH81anb3/Xl
 SFOVLl3LmeUMryZKsUMKYlFVgCCiQzKZJIGZV56ymXaxzsVuhtKcvDY+goH5joE1p+XH
 FZI4zbgI6EOba8+ILQs6ll4p426v4TajnVSC5kuKnn4EzCiF9ZFfCvjGKNuErRU5fdpQ
 gyng==
X-Gm-Message-State: AOJu0YwDjFMMyg0zBIyEENMBDGthiH4vQW3rZXMvCVaLaSuu2PlEa6wl
 T2OWdKSfFtTtuFD0gXCwWLCAWrgdv9IhVzPkKrFJ1rZ9nJ73i5t5Ep8w/njljKeddMtimO456Hj
 KUb2s
X-Gm-Gg: ASbGncsGY8MJM6Qxkd5aFOLImm+PKkW6yRO9SQ80rRPnKbU3g/JVtomgKdZ5lDqSayJ
 S1EdF7W0WCiaGByO5IxEk42r7NWRK0vVy1xmpZ+XW4w27VK0FU4qr0Ty6W8LqfwiXGM05UwOgvB
 UNl4VnqCoXph6zaOQ1CDXWoHyFGCp1FPnIDWmLovuagkDs/yk2fvbZM9T34xE7S1qKPN3MbyrFi
 UeZSXWCsD2zyOP9swZJSQAEPwjLWNh0lWmiVYuEzUUFs6Rw7niE9PFVjH+fUw+ZZTRCEaeF24I9
 2ESr94k6eG6AcR/DrvIpIiUt8SrqQ1owdFxuRXzj6dGKHeXSPN2S+bKgcxVhZDaoAn5KoIXcwE0
 PCUtfiORcBoGGIZ18d1Vb50MiBnxfeboThR9QWc3CKtCdhIZLh4tGPml47gf3LdgrukaQpFcxj5
 MPC4TEIiL3Fb/b25o/1f7xA895lFjc5Sz/g/m+N9M=
X-Google-Smtp-Source: AGHT+IE+HnR8Q65kTHmAKDSDojXDNiIwWOyWOxpP9cg9WZQhRTf92zJDPACw4OHBdDmtTxpu4GHOsQ==
X-Received: by 2002:a17:90a:d44c:b0:336:9dcf:ed14 with SMTP id
 98e67ed59e1d1-33bcf8e3b0emr35184402a91.23.1761248560822; 
 Thu, 23 Oct 2025 12:42:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6cf4e15a80sm2884768a12.22.2025.10.23.12.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 12:42:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC 2/3] common/cnxk: replace variable length array
Date: Thu, 23 Oct 2025 12:41:32 -0700
Message-ID: <20251023194237.197681-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023194237.197681-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This fixes errors when compiled with LTO about large VLA.
../drivers/common/cnxk/roc_platform.c: In function ‘irq_init’:
../drivers/common/cnxk/roc_platform.c:92:14: warning: argument to variable-length array is too large [-Wvla-larger-than=]
   92 |         char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
      |              ^

Since the number of IRQ is limited by EAL max interrupt vectors
use that define that already exists rather than a function call
hidden in a macro.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_platform.c b/drivers/common/cnxk/roc_platform.c
index e13cb42285..1fdbf8f051 100644
--- a/drivers/common/cnxk/roc_platform.c
+++ b/drivers/common/cnxk/roc_platform.c
@@ -17,8 +17,8 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 
-#define MSIX_IRQ_SET_BUF_LEN                                                                       \
-	(sizeof(struct vfio_irq_set) + sizeof(int) * (plt_intr_max_intr_get(intr_handle)))
+#define MSIX_IRQ_SET_BUF_LEN							\
+	(sizeof(struct vfio_irq_set) + sizeof(int) * PLT_MAX_RXTX_INTR_VEC_ID)
 
 static int
 irq_get_info(struct plt_intr_handle *intr_handle)
-- 
2.51.0

