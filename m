Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2840C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:15:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8289410FD;
	Sun, 18 Jan 2026 20:14:04 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 8DC9C40E4B
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:03 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b8719aeebc8so645316666b.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763643;
 x=1769368443; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EcnDLw0bSLeZa2qDEm1oBx7c05vuFm/357sI6gsfRcY=;
 b=oESBZLH6+jYBdZ8uQy6Y673rD54FCfyMp1iZI5m4FQYmcVEWfLUNVzm9JWMCpIKM+K
 uL8N8pom34NuCyA2HLDSXKh9XBRbjXbIYiZuJxJ3GpoHhnILJQcMRQICqnlOA3xJCeQQ
 1/cQ28/SaQIIaMeKI1jCVtvAL1rDJCgjziT0FyxJd9Xi+Qo8ZvtRytTjUP7K/URR7gVa
 V+ifcOLNGP0zEygzN0GthO04Q8WQylBR5wQ4j2FLymEjzEoFFVD7nekWX73ppIKhHLyY
 ETSeOttmxAU9qm3Q2dPGxB67ZGYDg4U1otYauj1Ki6LDM/DPWyGoSo/Q1ZODasfsKcAB
 ZFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763643; x=1769368443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EcnDLw0bSLeZa2qDEm1oBx7c05vuFm/357sI6gsfRcY=;
 b=Z8rfT/t0XrEOo2TsUcSK4CiOooYY9T0TciOeHmZLbPqEnQfOorVWE7OLgEYtcJnBlk
 sGTbKpqGvOmX9JgpbQ03tqk0u3mVPPjQJ89WZ+3jNeZmmSwnhV8pTadKApawgf0yLggb
 j91Eyg5ibYaQPpjnI+ENg8ri2hT6f2CiMtqq+b595sqaQVc0gQ9YbobgVZrFbQknRHk3
 sNEw4a85nllUsvmODJB6ZwTY0s7UrN8bfQYfpUtOqkfOQ636UsOF1RK/dEhnvgsVFmYA
 Dhq3QNWPyhyy5vKEUBGf5q28HLNMWJ4/6HOI0AoqcHdPQPjYX3x/KodxPto6WWVDNMfh
 CYZQ==
X-Gm-Message-State: AOJu0YzzeCMQyYIaULQQCyLxBD2OqtUtdVMT4VkcaG7R3BUa3f/ce0Oq
 9qQTkW1hN/4sJX+6KsNZg2PnYuxiP8JSX4sAy7kNJuioUaWzzHghCbfIDpRSKRr5T/KlkWuMdos
 oGVvL
X-Gm-Gg: AY/fxX53pC+cTGE6trqVNWmffFJJQQpvZZfGy7MAqcsiA5tgn9sPPnzN2qwZsX9CT/r
 j2MsARrOnFwrgnPZOn1voHqCszy+/+aNKX6UK0GZTBVWc4LB72W1iT3wnbnjhDIozIiZIE9DbX+
 r9p61wBwfZDz/wFAkrUkhq6Ktfoduoy7bJrGgKvOdrsd7e+ovG5LyoaXLymcwqAn4U4AHeqrVNP
 3BzHB/JPTTyV09hn/hr8+hh926FkPWUOSosuRH8iqlx/JZwWBEGBQXOPCe5udJT+0Ltr1LG8coi
 cT/CmbkHA8Gu+ZN2dqSRQWRImOCCNp1yXI3k4m1uHQSgM2zYwQnk0FMQo5Y5z3pPVg5UdfwH1RG
 DYOa/xS8EQm/MjW60n7nLVL3+qDj2Gs/Bgct1AVTB8v3KoAvrZ+kpc7xkq1Yw8/QxYpmes2AZxV
 Moslgk4uJYqBxjk+SN1nGAW8vl0V/VS8Py2R8sKzqMHFNRVX+IyA==
X-Received: by 2002:a17:907:2d8c:b0:b87:365d:26b8 with SMTP id
 a640c23a62f3a-b8792f783e1mr724115766b.35.1768763643039; 
 Sun, 18 Jan 2026 11:14:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 22/54] doc: correct grammar in hash guide
Date: Sun, 18 Jan 2026 11:10:25 -0800
Message-ID: <20260118191323.241013-23-stephen@networkplumber.org>
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

Correct several documentation issues:
- Change "a 8-byte integer" to "an 8-byte integer"
- Change "the later will increase" to "the latter will increase"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/hash_lib.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/hash_lib.rst b/doc/guides/prog_guide/hash_lib.rst
index fdbb99fd5e..bc257b4ffb 100644
--- a/doc/guides/prog_guide/hash_lib.rst
+++ b/doc/guides/prog_guide/hash_lib.rst
@@ -43,7 +43,7 @@ Apart from the basic methods explained above, the Hash Library API provides a fe
     the user to perform these operations faster, as the hash value is already computed.
 
 *   Add / lookup entry with key and data: A data is provided as input for add. Add allows the user to store
-    not only the key, but also the data which may be either a 8-byte integer or a pointer to external data (if data size is more than 8 bytes).
+    not only the key, but also the data which may be either an 8-byte integer or a pointer to external data (if data size is more than 8 bytes).
 
 *   Combination of the two options above: User can provide key, precomputed hash, and data.
 
@@ -201,7 +201,7 @@ if there is a new entry to be added which primary location coincides with their
 being pushed to their alternative location.
 Therefore, as user adds more entries to the hash table, distribution of the hash values
 in the buckets will change, being most of them in their primary location and a few in
-their secondary location, which the later will increase, as table gets busier.
+their secondary location, which the latter will increase, as table gets busier.
 This information is quite useful, as performance may be lower as more entries
 are evicted to their secondary location.
 
-- 
2.51.0

