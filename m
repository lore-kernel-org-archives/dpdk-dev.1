Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E70C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:02:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CAA040EE5;
	Sun, 16 Feb 2025 18:01:41 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 4BAF340E41
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:33 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-22113560c57so15296015ad.2
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725292;
 x=1740330092; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjAuUKXvjXSz7R4l617xCu44Y8nhJHSq6U+SYUOW77Q=;
 b=e1D4if1awRQKBa1rGWO81BD7iJE/VaNaNdaDvj1v2HwQKbYmYSobgN6zLTehBPl/Ru
 +QCxkZGLlgjUx+C8wD7UxH8b1Hu/vhHmjOd0u4IQMLO8vSC4kFj85kHO9vOaCXCGNYmT
 oX6Yn0b2O24Rdb8FwaC2QjVSx3+xPRQNLiHmY1Ba2dOUOCeykzdMnr89i6jtL8PbtpDZ
 Cg+Wiih7XXdO4w9TbPeJ0p3zsM3TXcbdKJDgtnN9lEYaZ0RBaRj0+znWLvfKcAf0fHO8
 Oj7LKz60WTG9y88ZT6PavuyCvq3ao0WerbGmIK4aaSPOK/s2xY1iHJyx6HElYfZ0Ly+l
 161Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725292; x=1740330092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjAuUKXvjXSz7R4l617xCu44Y8nhJHSq6U+SYUOW77Q=;
 b=cpTDbSd76pEtOCTSu/PfDlyp2pqV9DT6ol0HJC99pxUkXyh3pRrX9hbbb7Jcay3O/z
 7D42/Ft/MGQKAjMDPb2oIvVu5X29B31PkPGgZaVD0FZBJgnuPFjeMEIX6UowHnRwYyCG
 6VBRf9umUQHlmlMHF4C29ehVkbM8tTC8Xd+Xx0hGyAvTLYZxl9fqieJgYEWapHogC316
 B9QyQi/MjbbpAsjdOkB/5ehtqVy9KM9+UVE9lDtGbid19Cn7iOa3EfUa/Xkl7KSDztdq
 ZgrWwMXykewF0WHTE8hCkZF9Z93sBMkpX0UEBRCEU7JvlxoUqKOSjhnzUxbwcKdgR907
 qsmQ==
X-Gm-Message-State: AOJu0YxoClh/HJS2l1pVIcPs1mHBmhvnxBsl29As3RLcBErKKCt9K4o0
 1WYohIzWIp8T4HuFlq1c2DZbzeWUBKGgJDyzfe9OzsA1sl+elE/zgx6gzYGz/T+tOjw+e9pwpVN
 H
X-Gm-Gg: ASbGncuO0f8jooMjjuV+gV5sQgHRBzJekqaRjwkVQbZZ65OUD8MxRYgIG/JuGs//CPg
 lGe1/cBGjMrwDiiFRbS6IuHCkZ+xmyUcqae/N7GrkGQmdYeMVF6t6C+zEjxYIVBgQ6vY1d38Oc1
 B2emtrcRn0abOWMI/GDg30uWP8ck++ppbTQCkY2Ij2897zg0/5Hk5izMhMvWbOAPXFTLaA5aiWW
 BgXXPbCkVvxjQv/HQvt4E74alx6P9OOkapxOPQ7UYrO2uz20VZpn77Y+OFuuTTZeQyXEwe6b7va
 Wyq/b3MJU2dOLKmffxHI3zU35REywVdi8G2nY32PsyyPXcSPQgkBPXdVPJZBU5FqTg8z
X-Google-Smtp-Source: AGHT+IHx2DUcL1fiJekRZ6IG/S6IF8UONVh/SguZCPnhO5oCAaRuEFOi+Q+XMUQlKOUEsLk7rdUA8Q==
X-Received: by 2002:a17:903:27ce:b0:21f:89e5:2712 with SMTP id
 d9443c01a7336-221040ab970mr77862665ad.39.1739725292535; 
 Sun, 16 Feb 2025 09:01:32 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 14/17] test: remove unneeded memset
Date: Sun, 16 Feb 2025 08:53:13 -0800
Message-ID: <20250216170110.7230-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

