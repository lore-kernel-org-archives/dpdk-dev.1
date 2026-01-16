Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F8AD4A603
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 06:47:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6C7D42DC5;
	Fri, 16 Jan 2026 07:47:00 +0100 (CET)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id 3241642DBD
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:46:59 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b87003e998bso462619166b.1
 for <dev@dpdk.org>; Thu, 15 Jan 2026 22:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768546019;
 x=1769150819; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60TsemZeUH0wgbiQpawR4ldImOIf4QniqaVe6C0MBvI=;
 b=bOgKeNw6tWg8rdea38nry5o6tPYUaHUyXe+U/Bu/ZVwF8Vp+H/HEoLyAiz2rnHTPHg
 ULqPKocIisATOlb4olm2brEdbgoMOHkQvhuK4MWpF4D1WTNywqC8GxABoF1ftKiEZ9f6
 MSyfWGhcsQxpUUvWGC/DqA0asRZpOx94IPPBFY4sg844MpnumZapnYQGIe56ay08PgTy
 szgEjwAgHlqxxVjzUlZODeibOfg8n4OQc4JG3oiRQ3im4mijnRGO3XbdHNAVbNHalLC3
 WSdiBWqYSSCFQAqs+00tOx45yA1cw9mgfvupx22IDY8lZVExCHLkP3WIjjzxeBuA5ieP
 iIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768546019; x=1769150819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=60TsemZeUH0wgbiQpawR4ldImOIf4QniqaVe6C0MBvI=;
 b=syK0ZEh0FSSk3tIZZgO163G+U9Eh3beS3WM3p19E2pW0+Gmqt7HjSboQKH5vH3P5rd
 fmdeGs5F8rVVjcm1jlHrPGQs+NIQOJrbNzJhul76iKLYaKUn3kcI0HOotkhEaH4egv+4
 OmrR94H5Cr8wbYOZaQaN5Z5Lu+awKDDQEpFHiynoWu7P19rmjXXvjNmAem8Zp8H01Wi/
 2Emlxo/kB5FQFaX5br3970r3jUI9NrVQZiDkEM2tvjA+GcQlhLV5sYL71F2A6Y/Jo2br
 5HfcLsW8VHsBdEIKiR53VLjWsBM8+ENb38tMJV0qyRtqapQtF3abzOn93mzIDDL+AnqL
 MOig==
X-Gm-Message-State: AOJu0YwyJCdJVaUT7QJnrp03rUZDeasTP2d17yKL14VpULBrb/wyAOKD
 Wp1fEpIbU6fdQsAzhI3S2GOM/yR45aMErkerJO669E+xfjGT+YYGRza//ic7fWdIEMi5HxvM1r6
 nncAG
X-Gm-Gg: AY/fxX6HD3VcmWFveo2u/88PgIODmFcyzzNSy/pKpkTyB4TvYHzmLzQ2+VuQv9xheH4
 LyI8FZBt86XgmUiReP4FBeZ/BxlqrFE9S/dMWaSQZCLQnqNh/BkgWTxVJgwUeSN6f5LBFFZn0bY
 SxLBX+TuVVno8XySCx0/nmMx379DqZi8AylSAM6I9imAd2vt05rb4NPBjPoXSjuFtuLdQHR8A1O
 0J4zgfroIXWGdJtKq4RCiSRHTRGuCMU9SCWkTjK13f2kKWhaYFAfJv+BBeGCcHcP7rt7ysOeSja
 daxHYDZAzl82KN3lJZS8L18ytchY7h8BBRkUtfYBqExQpcZbpnj5U7QJJRfXYS0b02v+rRKewiJ
 HeuWxdD/5zAUodfGkfepwYcWziY+4hmzX6oOdkUTIzuP8CIaKn1Nm1Gqs5UH8noL2E7Qfy/Fk3V
 77Vxsw+nCLhZe7hvErtm1S1FlDlc0anaDSU5s7Hi8Nfdj6kjzHWSn13jli4Bs7
X-Received: by 2002:a17:907:7fa5:b0:b73:37aa:87c0 with SMTP id
 a640c23a62f3a-b8777c12114mr435824166b.23.1768546018467; 
 Thu, 15 Jan 2026 22:46:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879ae74639sm97172866b.9.2026.01.15.22.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 22:46:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v3 3/6] common/cnxk: replace variable length array
Date: Thu, 15 Jan 2026 22:46:24 -0800
Message-ID: <20260116064646.224254-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116064646.224254-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
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

