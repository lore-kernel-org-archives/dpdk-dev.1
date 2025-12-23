Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428E7E6FE23
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:15:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D06CC40678;
	Tue, 23 Dec 2025 19:14:42 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id F012D4065A
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:39 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b79e7112398so879549766b.3
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513679;
 x=1767118479; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=AzIVYueYGav/5Da+zhru7LMQqq5r36HZm2H8iCbGLn1s8X8TUAYPDESX3vG193T2s0
 ujUIOjaIqH8EMLSLcT4rl7NamzwJ+DNxFEuo+djQAJg7V1AFpY3MUWcAxygJnnC6PsCQ
 1qGjbjlgATn4RkREY2Uhye5luj4hkqQ4Lj/Wk0IlVAL0hT+k3c6rLWMzsx22jxrK8xK5
 NUeuH4GS8TN3Mk76XhMC4mZnFJYJRIxmfmd6EWqsb363dJKdad4orJn845oGHmGCZ9Lb
 5woO0ekZC1/iHkKzkRLOZFJNqUg6NeEsTw/NvUt9jK4vUvyMuM44MDhA96RwoZ/va5MG
 0x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513679; x=1767118479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=MIQiJAxjGxoNTLi0UD5NlKr+uDwocuUCp5ODLc9ndk0LEWywtv6D6h1DR8OSVxSLab
 xLkx64xhJ/i5j20pxUh+sJ4kvhTWL2PnGCHFw6xUrePYM1ACKQCUs7N+lz0+dQryUA64
 W4onZHHddcswdQQa9Gk60moCisvjRQMNQFYmX4I/yxSi7/36mO39J6qxs7+UI1fCnyct
 /eL10eIJAd0KEfNxpyQ6FpoNE3EScqEgUZumCbRQQAsunduVDS3RwC0s5D6veZPuqL8C
 UzC8o8ZnAlzeUkTn4yyO1BialfNOx27U9HFY+JR8VATFFr2CelTV8UNLacJ3zivX7xTy
 gHNw==
X-Gm-Message-State: AOJu0YzRSqF6uUaHjnvHm86t9ON1VQ3CFHpUFaegpTL4Gh4l+KRMYzqh
 Vf52QQ97VrEeojpWCKpVVmMkv2spV9zqlHGCa5ma3IlMgjdyZLpfapweKCu0AtelaHev5Vd1dUM
 DxhmaQ/4=
X-Gm-Gg: AY/fxX7LE/mn+BwLAzZc/egLoSoymDlwgrE08gnJHly9ac+LiwkX/tvVUzWo0XVQLsf
 dPSgUFHPkxw/8qO7zQo1bCOm08vNsIjAhd2ZXpUWFnghxaC26LugjOWrUV5At43aF5VuSoN3kAb
 6Br/sk6cXsel7RZalHbSkZ7GOJsYri1Vmg90s/YQZ41Jw3waAeKVSu56IDVzLorFrPfWfPsW44P
 HI40Ow6kTx8ghbGBCe5mMpchYfQUM+bxjoiHx/oA9RoHrrteLMPcqeQrrnPWXmBhpGa1aXTk4zY
 CDvDFyf6aFkahvGuEIDBa7KcfO6KUZrNko4QT4kgxnEZBjmxfGgIYP6i7IRWzHOI+YtbOwFehAE
 SL4AwVCaroeCnrKDeEwp7gktHwV6ewQ356oz6fwR/GZhxyluSDucIqgd4T0HQxoX5fZ3QCIDRYn
 JC1YkZQfMRcpD5fS0PGOkfnX/JABsPvUwOpHdFX9Y0ZNPlEF26WQ==
X-Google-Smtp-Source: AGHT+IGjpnUbE8Sv2xDR+0K6HMX+8iNqWOPNLbCtSoEq9QlHucH9p/81E58S6VXrUS4k9ZtQhO3uGA==
X-Received: by 2002:a17:907:fdca:b0:b76:3bfd:8afe with SMTP id
 a640c23a62f3a-b8036ebdd5bmr1544992766b.5.1766513679497; 
 Tue, 23 Dec 2025 10:14:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 10/18] eal: add check for sysfs path overflow
Date: Tue, 23 Dec 2025 10:13:08 -0800
Message-ID: <20251223181418.40834-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

Shouldn't happen but in theory sysfs socket could overflow.
Add a check for it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_hugepage_info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 7161b1a2fb..fe3351259e 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -150,8 +150,12 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		return 0;
 	}
 
-	snprintf(path, sizeof(path), "%s/%s/%s",
+	if (snprintf(path, sizeof(path), "%s/%s/%s", socketpath, subdir, nr_hp_file) >= PATH_MAX) {
+		EAL_LOG(NOTICE, "Socket path %s/%s/%s is truncated",
 			socketpath, subdir, nr_hp_file);
+		return 0;
+	}
+
 	if (eal_parse_sysfs_value(path, &num_pages) < 0)
 		return 0;
 
-- 
2.51.0

