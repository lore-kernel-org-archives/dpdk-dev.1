Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD879C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:38:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDEFA40E24;
	Tue, 11 Feb 2025 18:37:44 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 9762140B9C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:37:40 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2fa48404207so6467388a91.1
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739295460;
 x=1739900260; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTtX4AHkbt56cyz6ePjfJ2NXdYZ+Ear04KnwLkajDA0=;
 b=YK6EZW+n2Xzz1wiKv9FrFtLZ+F7Jwa5t7OnYIX2LtPpWriFXqLzrLDwrpd3dOfxhY9
 YXwiuXd0/cOBGIF7epoDyXBJuRCHjzoeM1GLo/8pK7TeMGXMSst9e3VBPBWGslI+fSJK
 GYcyZtzlaWz8s3y1Y+IB6faok6ooeNa1l9lJIvQIHJt3rv5git2aJBr5NscP8/ZeHQwp
 QB2xFWWqTxZ4kpL+S3lDdTd3GTM5r+PfQiCg4vNAaibLD1jmmft/sMwL7YtNBN/I4lPF
 KJ+kXlAr9vPos64cF0pfgn/VspemCC5E5tSp9lPWiEHj0JOGbE2zb+XGYwT53E2s7c4R
 TZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295460; x=1739900260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTtX4AHkbt56cyz6ePjfJ2NXdYZ+Ear04KnwLkajDA0=;
 b=tuYuAmy9/gMv8LIVC9tN2LYc7GYNp2MLKZiurdVEKHGcG4FOWL+QmILOlVjpVx46Do
 cY7gAPKyGDey7uQKAj/ZCUBxIO0UPS3oRi/CmJ+wOVL/GpllXN/Tlm8o2wgMclxUtwLP
 5x+LQj+6Lz/PooQNVa9jghMzdZRk9r1kTASLKqUHPdEErCaLzFENNUFQQte9XVnz9x3H
 JouZrGbQBZH1Rhky3PYXValrn5gn8BLTLagUbQEkMQT/YULmENf5PECLzw4H6JG3dov+
 8MFOUgwuZB0wWseXl+WoX5wUIMd0XG8ES6SNX9uT7aMUNVoBzGloV/avezn2YLwJBsLQ
 k5eg==
X-Gm-Message-State: AOJu0Yz99AwSjWCx6X3LkJrqKS7nhlAKUZs1D1pjIKJTSlE09yi9wseE
 el+yET12uNZD6jhyV8D50s/Saac6h863QFfV39aclUHrys6WBIglV1oYFycBcsOzdIWeRNZsP9x
 Q
X-Gm-Gg: ASbGncvNNTBeGPqAZ4nP+OgXh8TYjaYxRtxydEjsXKS4/qfejh2QJhaKicaNKEVBF2L
 tLI6XeeY5CtqNsN8rVZKQSdZVOC/E4d1+u1ClhYDVtNYctwt4PlPNswlM4+qEJ+y45z5lzxqlL3
 PUZlDSZ9Mtk6efoOHfbGBiqb3gxrKlzSyYv+/rl0QUzke5roCAEls/TxebUWRXydmWCYP7On50S
 LF/ucQ1sMUq1DC9/JQV9jBNmYGeZC3YsoCWxpeLXDH0/omw6hQHWXqVB5+WI8oafyJFN+6aGXer
 DFFKTSLxNIGjwMgN98W6t+rFDWiLj40f39C5QzIB6DHsTk6aV016lRiCoVVlhgukbKAt
X-Google-Smtp-Source: AGHT+IEPW5ZNFswo8NtFAj8noVr28cOLat8ILH2aVrK3dQI73XXvBVIfJ/Mp50RytlJ1ZrMPul+HvQ==
X-Received: by 2002:a17:90b:3647:b0:2ee:74a1:fba2 with SMTP id
 98e67ed59e1d1-2fa241776aemr28095033a91.20.1739295459682; 
 Tue, 11 Feb 2025 09:37:39 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa4656bd27sm7131811a91.42.2025.02.11.09.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:37:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 08/11] test: remove unneeded memset
Date: Tue, 11 Feb 2025 09:35:28 -0800
Message-ID: <20250211173720.1188517-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211173720.1188517-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
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

