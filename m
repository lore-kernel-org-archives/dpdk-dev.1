Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F117AC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:14:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C30B40E12;
	Sun, 18 Jan 2026 20:13:45 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id 249CD40A7A
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:44 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b7a38f07eso4855968a12.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763624;
 x=1769368424; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDdy21LvI+IjhLnrt57USPj1gtHei5RsDhaF6CTivFs=;
 b=PTJGjLVU2UfGV2cptnzPKjUOIVXZSxH2D4VzvjZEHSz1IfKHgroAYh+l4GT54ou0Qb
 5cj37APfLESFdfSUr/1+u3EVuTAX/nosIXXmTCtnXhJs2B8JiF1hZorrKO2eN41aE0IX
 JzZKNs2zMn1N8e9lAoR+ioSks1HJaRa001omFz1Yw8VLBhT4X9QneTjwR7xgxm0mnd26
 /+0ByeQEJUh1HE+aNHVHXdy4WP7xemsnkmMc8XWc0gC6iWnSEI/P3TH7IQQoypiRBIlE
 V78Wm54+4BsJMPe1+JimlaAqGqqVnZn8Mp650K2K9py1GzDGynTRpNaYPwmX1YpWc+fn
 /bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763624; x=1769368424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tDdy21LvI+IjhLnrt57USPj1gtHei5RsDhaF6CTivFs=;
 b=PJVAf/DdgAbdZ+tA9ClRQkmAi4e8TAsDU5hyf68CNoprvLtvQfntNTLxiG5atIn2I4
 s6TcUbEPaOgo46sWRSYaXcpdg3c9LXvtK0vBoJMHNVu0v4jxR9nPtXU/ZPKbDiy6hOnf
 weE7ofWQ2xITWrOwwmwJHUcE/3POX2LkUa8pet/gmzDM4azr/nU2uBptkUfI1MRLWyZz
 Hle5LKHObAtSel2dskg6yYqk2z4d+EhlZnvzIJk9s1FIilrTbqrghJL1YWYSd49Eda/h
 HqnGAk6x5oN16Oeq7Bcsgvbop5QFqAe5W+IsmUevHTTSOb8jAKv8OXZpkwHsNa0IA7ga
 v8jA==
X-Gm-Message-State: AOJu0YybLbbO63KXH9qRhhCrNYScidn0U1RjY2NlReG6gblynBZY5Cdu
 95WeG6etH2QXJW8S5wCkRjDkX1aYqkCzk1QujkcdJNSC/pUKBEanW3JmZ0kUM7TTGvfiWNnfkWZ
 eaa5J
X-Gm-Gg: AY/fxX7hkrkJOmZxcQ6cPXu8kth+S1JI+0e9k/+68pRgh70604MPQM/n3N2lJfYr6UC
 iSvW6bsfvthGbe6mJ5DQNPjZhzw5m98mnuvKXaLmZOHfrErU0f8kYQteyCTIN1wXxDAngHy5JHR
 f1AENw98rFicsswydPLQRqqA2NUe7GMv0oz4aU6ZgaPvDYxi41O6P22RDfV9SmlbmxubRq1ZJKi
 Dv25Ivb6+0XxIIeq4I9XMkQlfr5Ox4Wl2mivrZSFuMXTjUUka3TvztRTtq27BMU0FIr7kAUwxFF
 GxfiJdJw05jaAbtBAdxgVH1eM6iSpvyxXrDaeHG/4Njcze7MVb1ymFO8UfAm5fcCKOipsmdjqEw
 b2xqfjSQSACi8uSd2TzwOtSuAmGpr/JQHT87RiPnaw6pOQXUmHCvaWxd9Re9ImHycB9m5gqDzMZ
 wrMRoyd2eW3A8IKVVyfiHkBXkCt6dEe0iqyFip4DdIByTIZjJW/Q==
X-Received: by 2002:a17:907:94ce:b0:b87:1b2b:3312 with SMTP id
 a640c23a62f3a-b8792d65770mr703058166b.16.1768763623624; 
 Sun, 18 Jan 2026 11:13:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 09/54] doc: correct grammar and formatting in ASan guide
Date: Sun, 18 Jan 2026 11:10:12 -0800
Message-ID: <20260118191323.241013-10-stephen@networkplumber.org>
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
- Change "Add below unit test code" to "Add the following unit test code"
- Change grammar in error descriptions to use proper subject-verb agreement
- Correct RST directive syntax from "Note::" to ".. Note::"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/asan.rst | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/doc/guides/prog_guide/asan.rst b/doc/guides/prog_guide/asan.rst
index 9a6c5a7e4b..b770ac9029 100644
--- a/doc/guides/prog_guide/asan.rst
+++ b/doc/guides/prog_guide/asan.rst
@@ -39,7 +39,7 @@ to define ASAN_SHADOW_OFFSET.
 Example heap-buffer-overflow error
 ----------------------------------
 
-Add below unit test code in examples/helloworld/main.c::
+Add the following unit test code to examples/helloworld/main.c::
 
     Add code to helloworld:
     char *p = rte_zmalloc(NULL, 9, 0);
@@ -49,7 +49,9 @@ Add below unit test code in examples/helloworld/main.c::
     }
     p[9] = 'a';
 
-Above code will result in heap-buffer-overflow error if ASan is enabled, because apply 9 bytes of memory but access the tenth byte, detailed error log as below::
+This code will result in a heap-buffer-overflow error if ASan is enabled,
+because it allocates 9 bytes of memory but accesses the tenth byte.
+Detailed error log::
 
     ==369953==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7fb17f465809 at pc 0x5652e6707b84 bp 0x7ffea70eea20 sp 0x7ffea70eea10 WRITE of size 1 at 0x7fb17f465809 thread T0
     #0 0x5652e6707b83 in main ../examples/helloworld/main.c:47
@@ -59,7 +61,7 @@ Above code will result in heap-buffer-overflow error if ASan is enabled, because
     Address 0x7fb17f465809 is a wild pointer.
     SUMMARY: AddressSanitizer: heap-buffer-overflow ../examples/helloworld/main.c:47 in main
 
-Note::
+.. Note::
 
   - Some of the features of ASan (for example, 'Display memory application location, currently
     displayed as a wild pointer') are not currently supported with DPDK allocations.
@@ -67,7 +69,7 @@ Note::
 Example use-after-free error
 ----------------------------
 
-Add below unit test code in examples/helloworld/main.c::
+Add the following unit test code to examples/helloworld/main.c::
 
     Add code to helloworld:
     char *p = rte_zmalloc(NULL, 9, 0);
@@ -78,7 +80,9 @@ Add below unit test code in examples/helloworld/main.c::
     rte_free(p);
     *p = 'a';
 
-Above code will result in use-after-free error if ASan is enabled, because apply 9 bytes of memory but access the first byte after release, detailed error log as below::
+This code will result in a use-after-free error if ASan is enabled,
+because it accesses the first byte of memory after it has been freed.
+Detailed error log::
 
     ==417048==ERROR: AddressSanitizer: heap-use-after-free on address 0x7fc83f465800 at pc 0x564308a39b89 bp 0x7ffc8c85bf50 sp 0x7ffc8c85bf40 WRITE of size 1 at 0x7fc83f465800 thread T0
     #0 0x564308a39b88 in main ../examples/helloworld/main.c:48
-- 
2.51.0

