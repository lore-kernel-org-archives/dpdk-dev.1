Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1F7CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 486EE402EE;
	Mon, 17 Nov 2025 18:53:45 +0100 (CET)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1B8E8402C9
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:53:42 +0100 (CET)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso3136342a12.3
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763402021;
 x=1764006821; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXZCR3XunXP4p5rpPhXduq6BNn5K6SADN6bWzRaKasU=;
 b=UEEKmBNAOk/8xktdQ1ePT8gSablDo13JhJ/NBIfamrQIBE1UIA3bPJAB6HFKqfBeSC
 GUYeJWEyjH9JUYWFd/w0qgWqCipS+PDK/5rgNQIjpK2mBQL7MQ1yHSA1K1IPCIGJyYm6
 KhnicVNvJH7lTmn6LBRfXP8HGjPG4wxnoeATdyTDMp06BO6e80NPsW/B/Oi3OI13rk8U
 vSNyyORVHR0nv7qLWzOANYAAjD72JmlSLTrmLdBdZ9JIDxXyxHwAJi2FI6fbJ6hWjjEB
 QoiUQ4Up9/ZP4SZwhDJCgYEkwjJa/BA3ROv0ezd7pELii+0U8xaMvVW1EzvLnbjdoAiB
 pQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402021; x=1764006821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mXZCR3XunXP4p5rpPhXduq6BNn5K6SADN6bWzRaKasU=;
 b=DaCenKYG5nSasqGYuSbuIEKZjkD4wQ2tDrnE0QfnaYgrSVLikZZEeoSnS8+LPFjrhL
 FjEjmw3tUsr4NUveWytxKTt/ZOMwhvX6lf8xqCmVrWhAx8+imeq3Y2Q2M4ZBcQEn+fBI
 /zzY99sTfYmS1JThRtL7R1h+5C161x5rh7zQvAqEdZ0Z/iHQcExYiB/1LZOC547wTawv
 m0FZjgZlRsgC2gTTYCcz51fgJxdYy7yULW3yCM8Wdbk55CByx9zZd0WvBtlTPGw9Hyli
 6RPzoHlGwrCYEKJ3s9NONy8gVfyx6QvIj8mhyZrmKAabNWwjdnej+bGrW0JFPfAdxNxZ
 qL/A==
X-Gm-Message-State: AOJu0YxWs0+O4y2h1VxDOgbzCM9MayAECIMuC/PICpComUjhNv7mJh2f
 SUF/gYfWvarcXrczVXIODCifrpGFz+KC64bM0kQHqu40MhzZJMZqJ62qwLaJDMhze3bZQfryqsN
 qse3J
X-Gm-Gg: ASbGnctlb/iJuj8+Et5c8bKU9YM4HS9BWDrCAt8WhHd8uUeg6okHlyHYgIlk6IUsyXm
 TcLs6XXfpM2iwB94k242vKSQOBhrdMzWD2kUK/QWBMVbvzT53t34z2gqvg4LCqvkDq5AV2iVO8M
 gDN5AYkVKWrFl5eBxVXm6gbxPk8+pM2IJq+yyuR96m0WbVU07bHIN3MEJakcpDF9lHELKxP+NmB
 soZ4mDnc/PkcsllqEWYDeJKjBwqidpkK9VqsUUT+j0wjLKMnHsYJlo8+6m1zaX5XsT1hqLdQVO9
 AiiUlCJCrzcamjDVeIKI7A5lK9lCNJpnePzJgLa1reVNPFmfqeKoc2gYyNOY5l1Z3G/LFuCe/OK
 gB9o6VbebQ4rhNZ3FfzRQVRGz3O+gd+Bxyo06AZKiwv0+eg1J4DeNCqGMxzsm30c3w/sKXUpxnW
 yt40BgBjfIPuM3sUOVMcT2/Z9TXQwChLfvEiMBKU2vWMREKdMBvcUHcSpHYZwb
X-Google-Smtp-Source: AGHT+IHxgiotvqmIoNqipm/rlfAc0o7mNwp8xFMc4gUc554mf83KwS0RloPD/39d9Z/Ea/xXnNxGKQ==
X-Received: by 2002:a05:693c:630e:b0:2a4:3593:c7e0 with SMTP id
 5a478bee46e88-2a4abd4b7fcmr5785096eec.32.1763402021133; 
 Mon, 17 Nov 2025 09:53:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d9ead79sm63457494eec.1.2025.11.17.09.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 09:53:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 5/6] test: fix impossible format-truncation in cfgfiles
Date: Mon, 17 Nov 2025 09:52:12 -0800
Message-ID: <20251117175332.14014-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117175332.14014-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251117175332.14014-1-stephen@networkplumber.org>
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

Although, it is not possible on Linux (which always uses /tmp)
the compiler complains about possible snprintf() truncation.
Simplest fix is to just increase the size of the filename variable.

Fixes: be22019a58c4 ("test: restore cfgfile tests")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_cfgfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_cfgfile.c b/app/test/test_cfgfile.c
index b189d9d7a5..823b48e1fa 100644
--- a/app/test/test_cfgfile.c
+++ b/app/test/test_cfgfile.c
@@ -148,7 +148,7 @@ static int
 test_cfgfile_realloc_sections(void)
 {
 	struct rte_cfgfile *cfgfile;
-	char filename[PATH_MAX];
+	char filename[PATH_MAX + NAME_MAX];
 	int ret;
 	const char *value;
 
-- 
2.51.0

