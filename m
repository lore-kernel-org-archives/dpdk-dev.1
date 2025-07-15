Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38382C83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 21:57:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3264B4060F;
	Tue, 15 Jul 2025 23:57:24 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 4AD454013F
 for <dev@dpdk.org>; Tue, 15 Jul 2025 23:57:22 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-235f9e87f78so54272355ad.2
 for <dev@dpdk.org>; Tue, 15 Jul 2025 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752616641;
 x=1753221441; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeVkM7mUK3SQbH4YlvR+5Z0uv8xJpwT+OGUGVol5poU=;
 b=Gt1oSyMO9GpPnZx1TzyZw1xL16T7fIEf88+FioQTx+cDIzr7lVM9+6NcFoKdSBLeyO
 A9pk/UQJ3/z2oMkk45tDo/708edfhgMfv6eCYqFY1VrQEtiVcAYRkgRn8cjOKxFPQ8mY
 0yEwNJ68dV/GFot7A+BpY1dA2osc2uCDQMHAhoZ9xOINfuQ/vQER6nynAlEBWJ0iAW/C
 jQIG1AZKr0gWX000VkvXRWpVRYzBd+sNkKqbIBQBJMT9ZlKWLm7NmviO2adylvVgaUf3
 iHYy1xh8XdOq1H3XPjEVu6PC1611lmBzcSXvnplVy+s2UqjBxHtMEjYf2qzT5EmawZ0m
 vo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752616641; x=1753221441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeVkM7mUK3SQbH4YlvR+5Z0uv8xJpwT+OGUGVol5poU=;
 b=egni9guZbl3tYlcLwWe7Z6qMrZWI8ivBwpFykv0pLJOvQ7UxmM64lt2BoWYbdbW+9d
 yFSyGR5ueulQoL83LwnqrCbqA/OS/nNadH49QrPABOXx+QKapDL3aA8CxoHU/ACP3HeY
 5oLfxXngd5261hSi3AjIXsdWCnKGkiMf51Z938d4Eutjm2isagiCjrTt5rDowle3ioFM
 k6eKQzpbsnFp99/63unyrQ18DK9j6FoltHoLZL9NxKvN/kqxuoJvuuCcrRVoc1VNkXDz
 sLTE0yruLFI3tpq/+iU2AyAlzwJCmbnRm9lLM/VXV2ie0AZVpUXACnJNpJX0FH1E8bm3
 4dWg==
X-Gm-Message-State: AOJu0YyIsnH2ZbNkmn8a8VM31mKfHUpHEQpqGnEp+0sgLLP8i84Sh4GD
 HuJHP2l7sVcRCmlpnw5M9YkV48sUmVqJvRzEhlP37tkNFtR+m1wO3PKvR3cU5+v76Ktsmil06+v
 ymw07
X-Gm-Gg: ASbGncs5diEIH7cG/LJxn1cvZPAatntSz3X7BqvyY1h/pGsjjsP+Rh9H/mHFAUt/5uo
 US6DeihmePRS5GhndKWYGKfd8liMUwLEB5b1dyZWy9Ig7zBC/kys+lRdUehspX8IhQxgSvX3gLq
 qje/lBW9iw8TfvhLQ0evqUYGvruZxemsrUUrC4PEnm8OYJ2aQRX5A7nDCXQnJH2m6G7SQo+XaGU
 tzJ4xNl6o0QaDhb06wayz7xr0i8rntBV8Hgb6trev2xUAfhycNYQfaCovkpDE4OgBH5fRc7qK7B
 4qnO4FeNX9J1rcTNlAtZShkTd7nEKgkWJq7VBNaMF5KWhtbA58AVrI2HMcig4YJ3hIqZ1vTKwKH
 c3F1UjaudYpyezZ0hOLS9h+zz65aXk1Yzn4JZ6iA1TRlQ91fKOzKTqQw+86oGOxw177/wSG+7
X-Google-Smtp-Source: AGHT+IEDYMME0zYCmCXjIq3E/8rtScFWvKHUyP+EwuxFsMHlP0Ttu11R0OuzWNvN6Ut5TV7ofJzryQ==
X-Received: by 2002:a17:902:ef08:b0:23d:d9ae:3b56 with SMTP id
 d9443c01a7336-23e256b7467mr5394925ad.22.1752616641397; 
 Tue, 15 Jul 2025 14:57:21 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de43228a6sm111538185ad.91.2025.07.15.14.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 14:57:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 1/2] doc: add note about CPU 0
Date: Tue, 15 Jul 2025 14:56:28 -0700
Message-ID: <20250715215718.7388-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715215718.7388-1-stephen@networkplumber.org>
References: <20240718184326.21375-1-stephen@networkplumber.org>
 <20250715215718.7388-1-stephen@networkplumber.org>
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

On Linux (and probably BSD), CPU 0 can not be fully isolated
because it receives timer interrupts and is used for other
kernel related functions. The DPDK documentation should
be updated to tell users to avoid polling on that CPU.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/enable_func.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/linux_gsg/enable_func.rst b/doc/guides/linux_gsg/enable_func.rst
index 5511640cb8..a551ddebec 100644
--- a/doc/guides/linux_gsg/enable_func.rst
+++ b/doc/guides/linux_gsg/enable_func.rst
@@ -131,6 +131,11 @@ from running on those cores, it is possible to use
 the Linux kernel parameters ``isolcpus``, ``nohz_full``, ``irqaffinity``
 to isolate them from the general Linux scheduler tasks.
 
+.. note::
+
+   It is not recommended to use CPU core 0 for DPDK polling applications
+   because it can not be truly isolated from other system and kernel activity.
+
 For example, if a given CPU has 0-7 cores
 and DPDK applications are to run on logical cores 2, 4 and 6,
 the following should be added to the kernel parameter list:
-- 
2.47.2

