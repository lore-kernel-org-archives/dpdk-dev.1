Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A977C021A6
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:07:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9828240E2B;
	Sat, 15 Feb 2025 20:06:18 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 755D240DD7
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:06:10 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-220c2a87378so44106065ad.1
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646369;
 x=1740251169; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4njUr5dkOHDc4bLiHbc9hRxitSjOZs14bwKzJu4y3NM=;
 b=FcEnR33BVHiOAn7SH8jDEYug083dRkGsY5NFW+ZyzTdFulRXdK2qCXm6WasJ2iWgwg
 MXly1D57Wm9BlHNxGCvKUzhMQGdY0GDqYBmGqO5nm6IgOwM0QnTrhtlhcZtqcIODosS2
 uOdFsYmc/dlu2ssPoNHqiUUZ4Akl7Ph65IqV7tBnkA3fxVjP7FkhSq91x+0bFarxB4n8
 2mDm11LPWgC0PFzKFbF4ekSy17JyteHMQkvBk2HKyVVQq3Mul6EzFaED/eQwKRrFS5sQ
 3kCvJi5ypCYnSq+4uZ+HsodFJeVygjLDOCSN2BwoyiLmquqDmRNBEc7A5OzIjth2FX7x
 8iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646369; x=1740251169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4njUr5dkOHDc4bLiHbc9hRxitSjOZs14bwKzJu4y3NM=;
 b=tqXiaBY3ZnwuKzum2DUiiktvY3WbxH+GPyGJyo4qD0vnLny/hY4c410DaIs58w4h9m
 uXEab/KDoHUhj0zduuSX2y6MCUKgO/SKIUts1QCzi5hdBrGuUFwi79ZiKa2IAJ+S2Z3P
 9sTplKNFJGcc0dEusMVp4oYZ0QeQOlcErKa25gR6lhBPFAVsvSD7FICKPFeLCjWPjSig
 /Ji816HZFf7V6RbW+GRAU4ertZeCHDOoxTSOcQQzOFjYc/nDyCJmqZUMDnMVzL2GB6WJ
 6yjJFy4kXRvHSsYO3BPukMOx/7E3x8jqFFFoJvrRGV3ydi/fJHYIDlhxKVCtGMoHtDpa
 S8qA==
X-Gm-Message-State: AOJu0Yxei5avvAovcywYt5TSfpjMTbeb4n7aIGGewPsz6KVa3P69fgNl
 If7I0xERHUk/Z4DxHJiiCX6ip9LwRilJxGxYYbRnLxvBTDFMDJ6bDUQ/Yt0Gx9BQJJ148ua6/zL
 A
X-Gm-Gg: ASbGncvAP51XEVOWka9EsrtuFBDbfTpcxl02LPipfsJf7h/VvFwO4+wMzkdhPXVsB4a
 I5oubxM2vlCoTbp1ILQ5qxOu8XpSPon9N5PVqtlq0QEhALA37o3q2HsebgNitX8mzor8C4OeZvD
 5qEvmYRCNRv1Z7YKbcQuSe7RuXadraTtL8lRtjW+tVT3V2pEfVYpRK0vw6LdR/fvxyG9gXhC4fN
 Nz40frHzVfTQmLqJOUSvDuQ0ZuIQlM2AfU0a5kp7sJ8QVSUtlviFB+PFb/N4ocCZp0fX2qMWMiD
 TbXf1AgMTGENUDl/lMO3x2xPA1V5cSBjPgH/v9Qi388Vgu9Q1dWzmBSVOR0eqBrut0sx
X-Google-Smtp-Source: AGHT+IF5zL6GLGC0INnv5tZeZUhBEAo7AyRKHJVIQqlUJArqzKrScJ076fP+HrPsDbKQJg5CO0vMCQ==
X-Received: by 2002:a05:6a21:e8d:b0:1ee:5dee:d22e with SMTP id
 adf61e73a8af0-1ee8c93969emr7565683637.0.1739646369684; 
 Sat, 15 Feb 2025 11:06:09 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:06:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 16/16] devtools/cocci: add script to find problematic memset
Date: Sat, 15 Feb 2025 11:04:44 -0800
Message-ID: <20250215190544.988310-17-stephen@networkplumber.org>
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

Script that converts memset before free into rte_memset_sensitive
and memset before rte_free into rte_free_sensitive

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/cocci/memset_free.cocci | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 devtools/cocci/memset_free.cocci

diff --git a/devtools/cocci/memset_free.cocci b/devtools/cocci/memset_free.cocci
new file mode 100644
index 0000000000..96334dc8c0
--- /dev/null
+++ b/devtools/cocci/memset_free.cocci
@@ -0,0 +1,9 @@
+// Replace calls to memset before free
+@@
+expression E, size;
+@@
+(
+- memset(E, 0, size);
+- rte_free(E);
++ rte_free_sensitive(E);
+)
-- 
2.47.2

