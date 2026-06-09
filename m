Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67352CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 15:54:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0CC440665;
	Tue,  9 Jun 2026 17:54:25 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 27FF5400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 17:54:24 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304ec41197bso5518146eec.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781020463;
 x=1781625263; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRDCCIwR/GIer7MyAvnhXFjWI07J7+FBgGg+j8IW1c0=;
 b=dUD6dSG8YA/Ydha1EEvS6sEFJJ+nnD3UIusCeVngtAA8AsRwOcQ9iJgRLu8iF7hKit
 MCzcPpcbcFJnehP+aVF8vFJKC9T347pUMae5eIyYOHlFomxFX58j8nnmjgYgBm9s70hO
 L+qee1aRmzWrJjKfrbMoizAISb0GXOQbZmeCVKCEtLS9UpO9ShpM5EWmpuxx4ZFnO1Rb
 FSQ61ZJ7sBzu7e7IKuJcT0rsO/Q4zXAY3SFQYcLV8ZxemYLdKvvqD50WPm6pal71Y2yj
 nWdnGrtERKmVhkC0Kba1pQyHYcwaXiJq+BjaPRFHg2izdp7X7Og6XZpLsOACTrmI03S8
 Ko0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020463; x=1781625263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IRDCCIwR/GIer7MyAvnhXFjWI07J7+FBgGg+j8IW1c0=;
 b=ZQ0LaknRxxXD5HBSTikKK//O4nl/awkThJe0IYIDqNNoYH/lHj8yZchtHTSVMWJGqS
 A+Vtgi/Kmrmz//qCAQXwnK5hK3xaSbIklzJQS4J94ij9NlA0xbuFXzNk8Nbql/urYRc1
 zPxWvnO3j71uvyE0cakfx5X7Qc2mcQPz6dGyb8TTaQzcOMy65r89XrnswXVcF+Ksl9Vt
 TLvxq3odYTskWxS+KjBYZ0IAdPANUYIOiYg2WT/T4QvWVyKweFMS8Phv9LZxrKl0E3kL
 3iiBXy76Cvn+JPAMrAD56csuXlLpRcSAMJXqxL1Hu8KvVWCNreDq1tHI3jMGxcQFuhUg
 bHFQ==
X-Gm-Message-State: AOJu0YxqpzbNuFb5wG5gFzFB7IR9QhApG9qyXd4V76qyQ1ry3n1lKZxD
 tZuXXpF4szBr14ZFk5DF4Ydvh6exPTX/Vrg+RhzvwSMGM54Vt+Bixtnw38xBG2vWZgIPkzm24SC
 vnxVz
X-Gm-Gg: Acq92OGFsICBnZ/xdFCMPlmHy3WMQb01PJl7hW2meX8LXp+blLlUxxPYloMLDUgpglv
 jMNHN+LJ4WtN4iMXwVUh8TFxSMsZuB9pWh1P4X3p67+33MTq/EUIa6axm4OXjbWEUJgheTDAXXB
 pUPdgYR6mbxwnoFzVns0QVuby0ich1mJEU8UixAG2wCRNNcgL15jILyzBbsIaozwvdOaMFsTG/p
 i00sPKSc5etXNO0r01+LydJH6mkYlGVm009XY6+cZ5+2c7fblb4KKWaN9N5970qdAlVpknMlwR7
 khSjGZOuLs25NxfV13UeYJWcf3YNBYFE1CUMEh+pRpeYIMRbiA8/Xdu3IwvUxKuAlqxKJeIaayT
 fYKRp8hnnlAeyPfbpRQFZ43jtsEjM3iV1/uctPzq1IFCm+k/mITz0kYsxTJl+wt9WQn3IcA2dda
 DvA740uGzTstnazPbsKGnxdrwAfHSQLUpQQ1o3ctmBF3wQt4cUrE7uG+gtcFbOCqwGWIz96dQgi
 S4+lQ2P7z0=
X-Received: by 2002:a05:7300:230c:b0:304:bf07:f19e with SMTP id
 5a478bee46e88-3077b7ea1acmr12799999eec.28.1781020463055; 
 Tue, 09 Jun 2026 08:54:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm31015551eec.11.2026.06.09.08.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:54:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 1/2] eal: fix off by one in in tailq name init
Date: Tue,  9 Jun 2026 08:53:30 -0700
Message-ID: <20260609155419.263787-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609155419.263787-1-stephen@networkplumber.org>
References: <20260607150418.30885-1-stephen@networkplumber.org>
 <20260609155419.263787-1-stephen@networkplumber.org>
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

The tailq name is defined as 32 bytes, but name would be
silently truncated at 31 bytes. The function strlcpy() size
already accounts for the nul character at the end.


Fixes: f9acaf84e923 ("replace snprintf with strlcpy without adding extra include")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
Exposed by automated review of next patch.

 lib/eal/common/eal_common_tailqs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index c581f43b6f..fe3ced21c7 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -83,7 +83,7 @@ rte_eal_tailq_create(const char *name)
 
 		mcfg = rte_eal_get_configuration()->mem_config;
 		head = &mcfg->tailq_head[rte_tailqs_count];
-		strlcpy(head->name, name, sizeof(head->name) - 1);
+		strlcpy(head->name, name, sizeof(head->name));
 		TAILQ_INIT(&head->tailq_head);
 		rte_tailqs_count++;
 	}
-- 
2.53.0

