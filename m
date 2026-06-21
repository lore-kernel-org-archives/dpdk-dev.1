Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EA5CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 16:25:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54E034060F;
	Sun, 21 Jun 2026 18:25:38 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id B028340270
 for <dev@dpdk.org>; Sun, 21 Jun 2026 18:25:33 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-139aaba3522so895137c88.0
 for <dev@dpdk.org>; Sun, 21 Jun 2026 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782059133;
 x=1782663933; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KOgxyli6O9JO8XdG8BI2XIhKsOnRnrPhud3ul5XgO4=;
 b=KFNiKuEvIOuFOXsdXfUh9wobKUmBWNOHTKqlQZsyh3Xvos1roNXVf/lFwxvTEiRo82
 jgK9EvArvlPRA9GNOEI8thQjwD2GWTqSlgsXQ8fFyikBd86f5mujfDCMLvqN5QESFJ1x
 htAu8ePrAupIFQtBUnUU/BBNkJyeelpx8LLy7QulCDqJX57KjREzVtY0zsB4zbHrPcOY
 CTQhMfhS2osy2HSLFans4G2KJKcrgd0LsStu7Aek/AEXEOBDza1lligiqbr9NQ09i85i
 6w4oWBEjewAPXVbVhPQucatigzUCly4Ula8L2IkTWgVgggtBa8FZcYQu36NlHk5wCs0U
 Z3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782059133; x=1782663933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+KOgxyli6O9JO8XdG8BI2XIhKsOnRnrPhud3ul5XgO4=;
 b=IzZ5AZP8e43ucLON01LiZvVQcidwtbEnuh0pblxXr+khmGLK9nNfm6sW2Nyjyq5N5p
 Nx5qvc98eawwgYPqOB7Z3CFlAZ3wt9AYmqFS/J1MtTOb/AaYRHSlyUEVutHUpO6toDXS
 uQgww5iRHrVvEp2aKtAn/1Al6r2vp/8CILvkKXQD46TTCcgNxbymVF01t5rKjKUwShM2
 JPLJQAYGu5mN2jTdcp4CaXieVnMQMPffkYu7Mv1OegvlTkoch1mUGSq+hKfW1HuhCB27
 +sxZcMaKyC6hImBfvqJjrkN5RRNik3meUhrMmJ+yZbItrEpGgzaL81GftyhivwPtX7lw
 Q48g==
X-Gm-Message-State: AOJu0YwB5cST5we0fHda/nHX/CX5PtUBzZ2yomS6LqkBnBpsRab/nzIy
 NIm8MZqaKYwZtOIwpWIVQ73Uvj2Xyj9XjPwV6T+HHdq/eNHKNtVzTEYonogQVhQXpX+LSn3Nv+v
 WbROpCtU=
X-Gm-Gg: AfdE7cnOioFECOcNIUbvvHr4wk/Ljh+9q5tl+qPyPcEcO+qLqNn/9h3PMqHo0Wpp9WO
 Om/CLST+lrzun2X0C4VZhmT6ONDQNfo/Dp/X4y44YyOIdksiwRXbu8saNfdP5HZv+J0NjCgKDJQ
 cYQNnY2Johbym4QON0dIcQgac2YYmqQPibgs+BO4yJbMnaYaZ2rAqZryTTiHT4MSq5+RihukEwL
 TPEaKhWDGWwN0Sao2q4zdn2fyYzK9rBLlX++KO1qo7p83D7CiFXxUjUVtlDV0nEe4CCW4FsupCY
 kQtCROUgKxAhYHrZnDC0B7mc9AhTE5rpZ0vXiglFAMhQkoq2vpusmkF4pWjxpvwtaK6Inkw/+Hj
 j2xXQifig5iIfET35Zp29GD7pK7Si6SdbQMQ3j99FT/0WFWCyK2Rg9RYfG7hJVOXGH7aM3UyX3A
 TGzkdsHaeZ3B/qiNJP/HbTPb2Nzzqzn8it8lpvaw6E5RPUBNee6lgVRvSu5AEjSg==
X-Received: by 2002:a05:7023:b09:b0:138:501f:46b2 with SMTP id
 a92af1059eb24-139a3021004mr5798039c88.1.1782059132682; 
 Sun, 21 Jun 2026 09:25:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm5141593c88.13.2026.06.21.09.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:25:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 4/6] test/bpf: check that JIT was generated
Date: Sun, 21 Jun 2026 09:23:57 -0700
Message-ID: <20260621162524.82690-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621162524.82690-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260621162524.82690-1-stephen@networkplumber.org>
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

Avoid silently ignoring JIT failures. The test cases should
all succeed JIT compilation; if not it is a bug in the JIT
implementation and should be reported.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index e70dea736f..3a88434c3c 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3590,6 +3590,14 @@ run_test(const struct bpf_test *tst)
 				rv, strerror(rv));
 		}
 	}
+#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)
+	else {
+		/* a JIT backend exists for this arch, so it must compile */
+		printf("%s@%d: %s: no JIT code generated;\n",
+			__func__, __LINE__, tst->name);
+		ret = -1;
+	}
+#endif
 
 	rte_bpf_destroy(bpf);
 	return ret;
-- 
2.53.0

