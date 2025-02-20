Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE20C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:43:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 523484067C;
	Thu, 20 Feb 2025 17:42:19 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id F105D40615
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:13 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-220c92c857aso21365185ad.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069733;
 x=1740674533; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjAuUKXvjXSz7R4l617xCu44Y8nhJHSq6U+SYUOW77Q=;
 b=HNTFMIKFRRDAoQCMKEnFmq/DoEpbNCYalP4XbZGAsDbV07r0oOckHm2IVGQsPHEWNO
 A4ke+d76KvAG0dlsO261ALLxICly+Pvh5cZRV72N+n1/mf/JrsF2ydLoettCoPbLZNux
 nPMJhlgUkYvPzDAZJKy71/Sy8l/Pll8SeUGma4eu68USUz54wL8g3ez08hQRTtua6Uu1
 Erde0nQgNXTV6XwlZP5Qufi/rqdTIZcEmuSrmV7m1a4nFE1R5Oido99NCZM+XTs3t8O7
 aWslw7CdZSaSTT85YvlK2JiVhaadLKRtQh20jJYP9hNEVld8I8YY6CpWJ5t1FaNUQA+5
 +CkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069733; x=1740674533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjAuUKXvjXSz7R4l617xCu44Y8nhJHSq6U+SYUOW77Q=;
 b=IO4GDo/e8R2g4zFTNn0xMDodbW64UpspaIC18bH4szRAswffKM1O3U7oVXSSj8yUed
 0Jvnr22V/YNayOJhN3PXqXsn62QSKoxUij5TfTu2BjssGlOqzv0i/VNXxiQ2mHpFoSwm
 mJOQ6ttnauSvxPzgsTlBQYbOTNXnrK8RHS68felEf4vbSRN2JWW9YhqYPEFGm800jAWI
 N8blRogZNrIkL5UVLKcmeJ+6ji05rBqCBoD+nVq2UFlCXJvk5KiLcKdD2IpF8GP5nTAp
 UvQcHGXTjQxciQvQj4QJqhySi4yh1ui4K7yI3m6YMkWDU9SdlgSOV8KDHRFERgF+mYRI
 YF0w==
X-Gm-Message-State: AOJu0YxA58LXKLGInfTZ9kgAQyoWnv82Pc0ieOFHOxkZr7BERGxov73F
 vTui4q64DSxk4jE6lTLUlnp16BDDkWXaTfgemOydx6jWIu/+6ikN+kSFZyqhcNLSDY7GLosb7E/
 f
X-Gm-Gg: ASbGncu5B6ybjDGpvsRTdpHu1Gy2fiLIrYKivaURuaw/PLvcDaI+/t2cC6qqDtJJdTm
 zY+ScE8YruoGWL3O1X8ud1ZOitr81gv3SMvIUVJvN5uQm/X0PMi9/8ZqjjBLQoWOHwNGlzf67pq
 EN7Lj0VN5PULSmf2DUciA5JTD3WuyYljYrL7sN11kRQOFskv4nSyJc1co1XGmsvQ8dfTpLBoYkh
 dpVZMEXjZYYyKeOhLVrptpELlYrk5cIVdbJknLf8Wk8D2oryaTCoz/x7kkfgn2ntEATVvviwWbl
 Halruv4VpMr/1x4+BjkLezyxd5y9hJ6Tb3O5Y0buOx7rWWunUgq9l9Q0tB954RiaJoRA
X-Google-Smtp-Source: AGHT+IFYwjmH1krtaT5uz3HMEkR+bgS0kd+4LClwt8+ZTICBenYq95lj3prjz75+qYPoOaA/geLSWA==
X-Received: by 2002:a17:903:8cb:b0:220:e98e:4f1b with SMTP id
 d9443c01a7336-2218c356405mr79990515ad.0.1740069733102; 
 Thu, 20 Feb 2025 08:42:13 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 12/15] test: remove unneeded memset
Date: Thu, 20 Feb 2025 08:27:18 -0800
Message-ID: <20250220164151.9606-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
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

Since tmp is not used later in the function, this memset
is unnecessary. Even though this is harmless,
it causes tools that look for security issues
around memset to flag this a bug.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_cmdline_cirbuf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/app/test/test_cmdline_cirbuf.c b/app/test/test_cmdline_cirbuf.c
index f6361d49e9..37882b3779 100644
--- a/app/test/test_cmdline_cirbuf.c
+++ b/app/test/test_cmdline_cirbuf.c
@@ -279,8 +279,6 @@ test_cirbuf_string_add_del_reverse(void)
 		printf("Error: buffer should have been empty!\n");
 		return -1;
 	}
-	/* clear tmp buffer */
-	memset(tmp, 0, sizeof(tmp));
 
 	/*
 	 * reinitialize circular buffer
-- 
2.47.2

