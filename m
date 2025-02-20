Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A441C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:42:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9C33402E8;
	Thu, 20 Feb 2025 17:42:06 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 96527402D6
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:03 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso21474175ad.1
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069723;
 x=1740674523; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKsHwBy4OeQM441PNFrvjPnAsOJIxD9G/WylTgJ1y/c=;
 b=lr+uY2zSLDYWd6V554FIPhypMuwYjlNVupICYJ5rWw6gUuRQA0llQjrr5636SGajsR
 /HmpfcWP0JFQicruxNDc7g60mI2xkRa6HH6ylJpwlLrfW12vVL+hFSdr1gbFma4EXWFX
 LE7YDgHZerJlDD0/03uG0cYzJh9aVe+maqE3sICcWTu1gyCRHpW7vn9JCpFyQhktCgdx
 8bdPDo+5abYOxEU4qjifZ1vqJ+qFb3GC3+gJwz7IRRupAaF8eSukmCzn8eUwK+Fe7Sz5
 ombyYztvxE6bWFg0MdBpzq779fO2TtyZRmFY2lbHydDzrtmh9XdksjSpnVmy2IYXW3ai
 t4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069723; x=1740674523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKsHwBy4OeQM441PNFrvjPnAsOJIxD9G/WylTgJ1y/c=;
 b=euIDoe/wAAcoRAfIQq5cT4fe7oeLQNC+Na/tz2FNNxd2xwiDHCD8ibJlQ4iBN8YRNS
 po/4dYPkZrhCKvul6pPVXHKB//50afIoDTtFj8GbpjGdg2OP2UchGPa16vzoHn4cZAC3
 GMb98FpWCUOEvl2SPFWTopXjth4JkeLD4iDH5/gYnThyHinowSg/WEE2Ono8YRkvLmWR
 Eo5nvDtG7zsDPCVWFaVdr3QI7D+QGkgwr0aTr3rtIddqFtiRTkV8cmFe3+JVPXFI9X7w
 B38NJGGMYdVroXe4YoWYCjl/v+8eoF73q/Yl9UYmeoNvwGidd0obnSJXW+skjWq6pim5
 l0Yg==
X-Gm-Message-State: AOJu0YwXJxauzpbFTzyXZF4oCsRyiEMpEdaLBOq+syD/2rJ1JPUW9RBO
 E9efDQ46CYcLSVi+jRKRBY+pDmhcDLyIRrSKjFXKIiecYFctzcS1sW3tZ/xZwGXLrPp0gWmE+c0
 w
X-Gm-Gg: ASbGnctaZFPk6p2yH6tVRsAPX1MVL4U4ElZr8Rm94I/A4AqUPxrTlM2DvCXlaN/xzYf
 2pITkdFIlNhhQhn1uguV/rivR5P67vzBR04YWvHQot0wc6O3iIgI620Vt1TqlnKvY/fYzPZLjV3
 Fxyx7xVFUhRTHMYONFRqlrHySEI/0JpKkqP/lt9egAS2N8XWWNxIkcXxodY3x6Z9J/5fP4DHlh/
 uQKL4u6BaW8cDQ93CyBM4jQHUWsdzcI+Svrhjzrt7ggXYG9HfWnvJKHWwyXOtTAkJhSBl7z1taG
 UHE1iK/eVFMcdS2mJttr4PHR9Ido1oDDq+1EL3anTzVJJjEi6/3N4QM5CuG+Srk3X0DB
X-Google-Smtp-Source: AGHT+IGlstJU2svWeotBfbV3qbFjoyIxRRzWzXQ6a9t4bh6aK/DZfcol9pWttOiB08S2wH9mtSY9fg==
X-Received: by 2002:a17:902:c94d:b0:220:fbde:5d70 with SMTP id
 d9443c01a7336-2218c7637a0mr64802575ad.21.1740069722708; 
 Thu, 20 Feb 2025 08:42:02 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 02/15] app/test: remove unused variable
Date: Thu, 20 Feb 2025 08:27:08 -0800
Message-ID: <20250220164151.9606-3-stephen@networkplumber.org>
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

The buffer tmp is set but never used. This leads to warning
since the memset could be eliminated by the compiler.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_cmdline_cirbuf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/app/test/test_cmdline_cirbuf.c b/app/test/test_cmdline_cirbuf.c
index 8ac326cb02..f6361d49e9 100644
--- a/app/test/test_cmdline_cirbuf.c
+++ b/app/test/test_cmdline_cirbuf.c
@@ -251,11 +251,9 @@ test_cirbuf_string_add_del_reverse(void)
 {
 	struct cirbuf cb;
 	char buf[CMDLINE_TEST_BUFSIZE];
-	char tmp[CMDLINE_TEST_BUFSIZE];
 
 	/* initialize buffers */
 	memset(buf, 0, sizeof(buf));
-	memset(tmp, 0, sizeof(tmp));
 
 	/*
 	 * initialize circular buffer
-- 
2.47.2

