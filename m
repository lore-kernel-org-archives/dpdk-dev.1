Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDB6D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:56:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98A54427AF;
	Wed, 14 Jan 2026 23:56:13 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 991FA427BB
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:56:11 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so2863305e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768431371;
 x=1769036171; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPu+nT4GvpteYVxvx7M/IGbRLXo2boyffp123qBFOLc=;
 b=IPn9+MXFSZWNhG41zQJC0kK6O9TGRL8LD8H/Mrfy/MAvE5DKzQcEL9mZ5lzaGquBZD
 PkLzuaPKVltmeG4styI6GX9ahHnn6FC3Y3+T7DdQr8IVms5iZnMKZlLOHblt7E6PDJUQ
 8XKkJst93rCJ7/kavVo312dhPsGhVCkvzYU5DRg9e111lK83sc2rfOS+L9dLklurseX3
 1mKsu9kbqdhefttD5gQquuYpTo1em/rvN/tqhapuFoqOmZtjdCrpMoZEcWYL97jSqXqh
 F1puFAu/xCevQb9QtbLmnkUc0sLtmcyNKk17Gt6GaLOr+kk+zIN8ajEREwLy1yo1qOcm
 nSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431371; x=1769036171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vPu+nT4GvpteYVxvx7M/IGbRLXo2boyffp123qBFOLc=;
 b=to1o1cLFxBDBebULbl4bN7BMqujvnXMceLGx9zE+CRXJlfKApbyVXE7neVt2qwFrTp
 C7GW9eT4iEh94TW7ibGQ0T/CWT1iL4r/Ufj6NLh4zBouXYVnTwgv9UEatL67mOx1pLVV
 69oWIvE73faRR+UEXdlYAgI8z5DphKLqHxNaQzbIjQyIM1ToEY4uCqIfplJcgeLqcTq9
 wnboOLVtElvhZK6pdObxkS0iLtW9II9GeUYn9aUZjQICQ4zXZdNN5ZriIgOlSwflCfdN
 BxzkbQMN012waW1zmf0zgaoCnF7j565NmWgag1hJi6jhn1DPnu+jOeWBYd7GKWbwIdrK
 VDeA==
X-Gm-Message-State: AOJu0Yw0AvrPNL6bfGvArnKuvtGwTNhRL15SZvxXKNJGF69tQ0B/YL8D
 /vUM1WQuF+9bqv9ENuoNzec0uvcn9BKuICzzydJ3Znowq4uZ4Wbu9HdOtmC7J0jrPCKcmKlSKed
 ktTa7
X-Gm-Gg: AY/fxX4WoPKVoYu1562864qgDrQwxcXkY5AdCyIfzano74d0z045Ct4Nvrfi4zkzqMC
 7EvJ5v/A5hRSqhlz2nQVGxBKI0UKTyEnTbc0uIGxwvq/uc89oSWbBW3XSe+IGfNBAyIKxZi0ZSC
 1iuJl3kmd3pKxQtWriEUSIyF4PLtJtO1Rmr03yux4Tms9MLTsv2jU6fiHYEHA0WQBqssylKbE+6
 MPZYEbl5te3BRD55HfV9j7HUjxwxbIAT8c7xeaNTKpJ4YlXtw4SDwTo/i4kGigDDRCSDzIDoFNT
 rAJLjRYKBeS2UvhLO2yZKhPlRyTIzbqFPIc7jw/NET4cPgr5ekwPax8uirwPP9SD/UA8fi7BZ8i
 TMC2mv5TAcIs0cSOTl+NmSLDVV2JWgXJucu55PUMSDoU8yaFgCWLhgOc5tjZcV7su7JS85qF43a
 /IF+le7QowNysUlJgCafey+z+UE36oJoTfO0thVlCXbqpQqpvg1A==
X-Received: by 2002:a05:600c:83c3:b0:479:2651:3f9c with SMTP id
 5b1f17b1804b1-47ee32fd063mr47538705e9.14.1768431371129; 
 Wed, 14 Jan 2026 14:56:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428af0c7sm12999125e9.4.2026.01.14.14.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:56:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 07/11] doc: improve new library guide style
Date: Wed, 14 Jan 2026 14:54:11 -0800
Message-ID: <20260114225555.127448-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114225555.127448-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
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

Improve the new library contribution guide
- Converting passive voice to active voice
- Simplifying sentence structure
- Using more direct language

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/new_library.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/guides/contributing/new_library.rst b/doc/guides/contributing/new_library.rst
index 99890beb29..25237b349f 100644
--- a/doc/guides/contributing/new_library.rst
+++ b/doc/guides/contributing/new_library.rst
@@ -10,15 +10,15 @@ Process for approval in principle
 Rationale
 ~~~~~~~~~
 
-Adding a new library to DPDK with proper RFC and then full patch-sets is a significant work.
-In order to save effort, developers should get an early approval in principle,
-or an early feedback in case the library is not suitable for various reasons.
+Adding a new library to DPDK with proper RFC and then full patch-sets requires significant effort.
+To save effort, developers should seek early approval in principle,
+or early feedback if the library is unsuitable for various reasons.
 
 Process
 ~~~~~~~
 
-#. When a contributor would like to add a new library to DPDK code base,
-   the contributor must send the following items to DPDK mailing list
+#. When a contributor would like to add a new library to the DPDK code base,
+   the contributor must send the following items to the DPDK mailing list
    for Technical Board approval-in-principle.
 
    * Purpose of the library.
@@ -38,13 +38,13 @@ Process
 
    * Any new library dependencies to DPDK.
 
-#. Technical Board to schedule discussion on this in upcoming Technical Board meeting
-   along with author.
+#. Technical Board schedules discussion on this in an upcoming Technical Board meeting
+   along with the author.
    Based on the Technical Board schedule and/or author availability,
    Technical Board may need a maximum of **five** Technical Board meeting slots.
 
 #. Based on mailing list and Technical Board meeting discussions,
-   Technical Board to vote and share the decision in the mailing list.
+   Technical Board votes and shares the decision on the mailing list.
    The decision outcome can be any of the following:
 
    * Approved in principle
@@ -53,5 +53,5 @@ Process
 
 #. Once the Technical Board approves the library in principle,
    it is safe to start working on the implementation.
-   However, the patches will need to meet the usual quality criteria
-   in order to be effectively accepted.
+   However, the patches must meet the usual quality criteria
+   to be effectively accepted.
-- 
2.51.0

