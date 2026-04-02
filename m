Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB46D6AAFE
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 19:47:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8974140E4B;
	Thu,  2 Apr 2026 21:46:32 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 754AB40E1F
 for <dev@dpdk.org>; Thu,  2 Apr 2026 21:46:28 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2cb3cb2fc7bso460751eec.1
 for <dev@dpdk.org>; Thu, 02 Apr 2026 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775159187;
 x=1775763987; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fww4LBxns+BpH+w9JCIiq0pq4i29qCA1DBuyFjDxBe4=;
 b=o03pa4A4bFGTngpgMTywC3v4P0y4A2YOwJWlgUsZskTgxPLcTyjRO5RXoN3ScNhCxA
 f42moTlPXP8jqXlovpfCfcjRSWxWZJlPZwil+m8VhZDNEypwknKDVsjEXTukYuLKw4Xn
 1JhSw7vAcYYlSt1YgFJ84EO5OBikuhi0QiG8gTugfqPdACjO3QZUhWGWOiIt9oafZ9ed
 85FAdkOpfR0XRKLk/qf0zsnIHuSIbqYhBtck1v9Ftycv9pZWYgf1M28jx8lnc9rzDaJF
 79zQptNp+yop/hWFyjAW/j68+COIGz0CZeKzyS8t1wnXLhk4iLBYtL560jE2JweIskGL
 UmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775159187; x=1775763987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fww4LBxns+BpH+w9JCIiq0pq4i29qCA1DBuyFjDxBe4=;
 b=OzUy3ffwu+jPH5NuSNf3Ih+rj+QV0Crab7qOPqoObH96g6F1AhYst7XCJ+r3Z51HdR
 n/hadcjoFjFqYgR2RQlFG9wvJPnNJygD7p36y8/7I8mCqQvIlzspruF/AOTE/FJz5h79
 PJhhMTsQPl628Qf9V4w8+XDl3YEXz5DiR0vvqiLZZ3UW2O2PrrytRpRi/lbVdHUNCY5o
 450bL53HcckquJPHGOFtvzD3Ha/bQXDP7uUyVL3+5CTJqUjbHIwafEMh82Z8ISTAAOyK
 OrINeiZh9y//Y76lns0ps19DZPPoHQGRjs1LmYz2I5uB7/FuK37jzAYEIqJQsLACtHnO
 r4aw==
X-Gm-Message-State: AOJu0YzHFZzBObx5jZtpBuCPWWEKaHRtqH7jsniFVhP6sd1uPquo49ZF
 czXYMg9W2yrxRPhtrMJCZ9rEl4uXJ4Ajtduz20bjsondNLJY2PWoyRvaju0E/+oCODje/eJxhFT
 kQOBN
X-Gm-Gg: AeBDiesLEWmyGzMC5z8vmQs7NyZJQ+fFKCUoyJhX7RDVyjW/HlKlK/2SyQPndQJlwAa
 CrBX3yD6vJ1zbyePr+6/jS/6cJLgq9+DjjnubEqU0vpJVd6BBgWvUq698XXk7kFZxIli9uch0DF
 VHo1wOkPDeKrYnfJwvh6wjUv6AiucD9Ahjp+sn9G6rr7imlc2xv8wFyxt1PJVrd+oKRUXPCHtUe
 OYNaCxOxlpZKRF5QFgDKPB9uYQaAeEk1mt0nbPf3hDDmPvU8kRtPznDR1tWxZze6fEROzSVuIyt
 XZ5hmWDo0wFRruD9yjiobs6edHBx4i/fZp0rkKcG+cgBhOAEdYaHOr7/rfqMSzlIU1yKoWafSBL
 DI47NTSkEVssxYuearZLLVIXWwyTxeQlgYjl0Pj4Wz8smuWtPIeBG9NsLA5y+xobFStbIfFP+O2
 ryN3/djqA95UjFO4WuPTSsuysicL3FEgRf/ejxyBCLmXw=
X-Received: by 2002:a05:7300:434a:b0:2c9:7a87:e84d with SMTP id
 5a478bee46e88-2cbfb4a0eddmr169133eec.10.1775159187535; 
 Thu, 02 Apr 2026 12:46:27 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df5ec7sm3164279eec.3.2026.04.02.12.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 12:46:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v13 6/6] MAINTAINERS: add section for AI review tools
Date: Thu,  2 Apr 2026 12:44:36 -0700
Message-ID: <20260402194618.134002-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402194618.134002-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260402194618.134002-1-stephen@networkplumber.org>
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

Add maintainer entries for the AI-assisted code review tooling:
AGENTS.md, analyze-patch.py, compare-reviews.sh, and
review-doc.py.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                            | 8 ++++++++
 doc/guides/rel_notes/release_26_07.rst | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..c052b6c203 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -109,6 +109,14 @@ F: license/
 F: .editorconfig
 F: .mailmap
 
+AI review tools
+M: Stephen Hemminger <stephen@networkplumber.org>
+M: Aaron Conole <aconole@redhat.com>
+F: AGENTS.md
+F: devtools/analyze-patch.py
+F: devtools/compare-reviews.sh
+F: devtools/review-doc.py
+
 Linux kernel uAPI headers
 M: Maxime Coquelin <maxime.coquelin@redhat.com>
 F: devtools/linux-uapi.sh
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 060b26ff61..aa9e1e962c 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added scripts and prompts for AI review.**
+
+  Added AGENTS.md file for AI review and supporting scripts to analyze
+  patches and review documentation.
+
 
 Removed Items
 -------------
-- 
2.53.0

