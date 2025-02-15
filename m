Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F4EC021A4
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:07:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9265840E1B;
	Sat, 15 Feb 2025 20:06:14 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id AA9B040DCA
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:06:07 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-22100006bc8so19357555ad.0
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646367;
 x=1740251167; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTtX4AHkbt56cyz6ePjfJ2NXdYZ+Ear04KnwLkajDA0=;
 b=aUqdyKX/6c9xcUvl1mkXgTKIGX/FVv+hkm5oyBK1JlAwWghhstOXErcKyD5fYOutuQ
 cNFmVsBwLVzhJuVsKAH74VuIIwk26SQHEr+w9JUBnUMKi+U8UW5aGYf/xPAerJrQ390b
 6V01Z1P0CPUhSOzvHVOSWGs69ZBfvQDfRB0guQLUq/Hyqnr8ONZ6TSCaE7GywW3IBaX6
 W6kJD+rA1x05WxJw3VYmjddP983uBWJPajdaORiq0WW+CBgQB+nmfOwBPhugj4CbvXZ6
 E3HAbu6pw5UADCZSrcrnYKA63rzo2PQoT3oV7ra+zEUZ0Xd8YzN8s7piqRyAUGxOFA6P
 TzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646367; x=1740251167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTtX4AHkbt56cyz6ePjfJ2NXdYZ+Ear04KnwLkajDA0=;
 b=WG5z8lxw5vFRSIWr4uTudFd6rq4kfd9mUrV6CvJy79zUc0XGyTnVPMoUhU6YmA5y63
 DT7uvoLLnGAZXmDP4X1/ixwAqRgv9A09o0tkuhK9QvugeUTGWe577zm4LiMlQ6jXBd42
 +9uKiE9AOqibNi+f2E4Kau2KXt96Oi3yysm7E+Be1q5XAhEXNAFZdVe0hJ1W8dkIJgaZ
 F6VM4pr1ouWN90lBvB5R0mQVNW6vJBJjF6PIzmqk8Gti1/Z9aKRizUl+YIahFxtQrP06
 ySEyJFbM2eYjgaIwS0P9IG3o4ZU+n8RhAy/yo4/49CehjLMAxHsdFKcZZhEldqxqwzEt
 +bPA==
X-Gm-Message-State: AOJu0YxeXTrFxUZ+KxnqbkoBl5jQN72KBflZ07TkWvOmUDXncUIN2cHg
 wOXVmQQC65vzJJTEjSOkff9TNqzvLobL40KFiFBi6KtqgYDIRfiQb78D2wzE7cl8amJajFPwqzq
 N
X-Gm-Gg: ASbGncsRvB0yMMyHcRwALST0eKUMNGyzh4fAj8Rc/Y9y8U+WMScSMr+koBHzyfVeTtG
 xcaLMpg/bvDpZYLqS5f9y00DpkMFIGQxXH9/GBF+aGzKEKe/U3XIbvwfinrLWKTjCnoq+MIAQJP
 ZbkwWH05mrud4hgjpPD7CxTQ55Fj44xo0mzUgKRwfas5mTqNd0y02cBooTXNs+pXJ90nLgpO8xQ
 fPCkqTNLeggmt344qI3urUhGYOROvQi7RXlEIY5Oqx2wcK39dbjh8BRxAcKklQV7dQGmBAanhRg
 e0MxJnuTBmet8lBXBWv33HY2y2au9bitbbyLDLvL6h6//S79ifGSQajF6VcW4u5yX8An
X-Google-Smtp-Source: AGHT+IHsxMFCnLjt8WQ355q0WBHVV8FE3XM05so1pDe6WwREuDY1rQ6OjUSfdqnzPjtXTcKBspuDrA==
X-Received: by 2002:a05:6a21:9218:b0:1e1:af74:a235 with SMTP id
 adf61e73a8af0-1ee8cb4984dmr8463658637.24.1739646366914; 
 Sat, 15 Feb 2025 11:06:06 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:06:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 13/16] test: remove unneeded memset
Date: Sat, 15 Feb 2025 11:04:41 -0800
Message-ID: <20250215190544.988310-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
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
index 8ac326cb02..1be357abf6 100644
--- a/app/test/test_cmdline_cirbuf.c
+++ b/app/test/test_cmdline_cirbuf.c
@@ -281,8 +281,6 @@ test_cirbuf_string_add_del_reverse(void)
 		printf("Error: buffer should have been empty!\n");
 		return -1;
 	}
-	/* clear tmp buffer */
-	memset(tmp, 0, sizeof(tmp));
 
 	/*
 	 * reinitialize circular buffer
-- 
2.47.2

