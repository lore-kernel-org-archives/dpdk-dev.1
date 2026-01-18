Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0DFC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:16:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C866E42793;
	Sun, 18 Jan 2026 20:14:12 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 47E1B40E1B
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:11 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b87003e998bso790413466b.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763651;
 x=1769368451; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2jaVMF/Lfw9WfCTjCX/ivdZVpVvh3YwisLh0JDNGL4=;
 b=qKmFgoDjgR+6c/GLA56cf8bfoNgS/VX/OBNnCdQFFaBOUEIsz9o51oj8T3he7nBgQo
 kglr+FqWeDA3g7kW0CBYAwzpgMzd36jL2PU3+cfIeq4YUAuB3fyAH/oyfOGkTSQCQlpS
 aa6gND8xkEF35eJhmt6duwbH+K5R9UZvnxImqFF9Y1C47Tqhdv+LhPOiN+4C0le/AA4W
 YU0UbpPXyIg4K14hqWHO3AwNk87NfI8a/oQt1JBUzn4bwc5kO7f/ELjrntABiZ9lFVSm
 YDCAbhL9AL8yEBoqP0XUyVrrjr//5D3w/0tO8k3g+QyoktzyqdXWm5DqLo+d2hImNebc
 2CdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763651; x=1769368451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z2jaVMF/Lfw9WfCTjCX/ivdZVpVvh3YwisLh0JDNGL4=;
 b=hxcYZxOSLHP9OHjdyImiIi1wG7Vnwc8rD1lQ821l2ZlBJOF9Q7eOz/xLPgqyhRcAlw
 f9qVnDP2Di2cAgfANURLNJU3bAsHb15BHrd/xy64qEb8GgBjKbNyUAQ7b7eWKd8Vqxf4
 FOnt8q4Ik2TGM7qsTmuBMhX4Q+SnsUlqVbZWSp2OJw5ZKLrPMjQzGL4zKzHTa8mwLShk
 WCPQpgoa0pPbMnFKDvTIJiM5DHKUZTiS83Snx7qOFnTW+XoBFeyfOorHhhHjNH2B+MaQ
 mqRNcNDtrPsKvignug/tGF7MUtNlF4fsH+1JgUnWoRfuFqbLBzosXZ9ZPh2FnkBvoTYc
 uhzw==
X-Gm-Message-State: AOJu0YyapsIMNy8nbho6NaG94A6s2ukRejXXxBEtCKpwsAmsxjQzMjqf
 WAKfbLgHzlmdScxzkWkSq/YWaYg+LvUTA1N54K/AYbg7Tf4G9K8O9GVJh6LCJHnYBhY1sk5iOBS
 oa43L
X-Gm-Gg: AY/fxX6kDJtDwLpgHSq5LwE0y4Q/D1nrIT4KtsiaioTBAzjL5HlsnjF3zz+xeefdz4E
 SmE+8/bflWrtsq/GQ44U9pfUPJaGAyVjTPsJW4qFPhq6xOa1WKRyVF1/jx+3gSWxJiPfB9NG7p9
 7mwI8zFQxmjiGq97bN6obUw/BpMjMYh802XgZ8R7W5phc0AF9pgNBjZBc0xUtGJt+b4yB3Yb5W/
 nr3XZ2UHhW/fFLgUu2kvEEbuy62L/OYha1vplHp5bS1q6cSLkPZgNuek+sxfD7mEvVOHesbTHef
 tPPCauX8blf+LEK8MKHWI0JzIFUyAYg0mHODve5SmPi2irLSObBfDZrzjNrbXuLSFE/AqeVYM2f
 C9EED8H4w1YAcbTyuHEzYsaPGpGvKbR0wlffmPBv+rAYkvkXHJi25zNjJmXQ6viiDo3VIviUH+O
 XgOY9ypLZL5pDa9DTvMHxklLXO444XVEs2wXoADZGgPsTdi0oE9A==
X-Received: by 2002:a17:907:c22:b0:b72:d577:11cc with SMTP id
 a640c23a62f3a-b879388dabfmr894912766b.12.1768763650809; 
 Sun, 18 Jan 2026 11:14:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 27/54] doc: correct grammar in LTO guide
Date: Sun, 18 Jan 2026 11:10:30 -0800
Message-ID: <20260118191323.241013-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct "compiler have to support" to "compiler has to support".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/lto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/lto.rst b/doc/guides/prog_guide/lto.rst
index 5791e35494..e6628b11a8 100644
--- a/doc/guides/prog_guide/lto.rst
+++ b/doc/guides/prog_guide/lto.rst
@@ -8,7 +8,7 @@ The DPDK supports compilation with link time optimization turned on.
 This depends obviously on the ability of the compiler to do "whole
 program" optimization at link time and is available only for compilers
 that support that feature.
-To be more specific, compiler (in addition to performing LTO) have to
+To be more specific, compiler (in addition to performing LTO) has to
 support creation of ELF objects containing both normal code and internal
 representation (called fat-lto-objects in gcc).
 This is required since during build some code is generated by parsing
-- 
2.51.0

