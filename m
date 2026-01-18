Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7EEC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:15:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8B3E40F35;
	Sun, 18 Jan 2026 20:13:55 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id 8D6DC40ED9
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:54 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-64b5ed53d0aso5056019a12.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763634;
 x=1769368434; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIepW19+nTKrdNIQaGFMgkyMRXqNM6GUWr+RcCM6zPU=;
 b=a0wBTuHlxctD/vRSzNllKfJqjNG43DYEaH+F4xH+kUkaz1J/aIlZxGRizlUIgxih/p
 kXRBX/EDT+tD++n97UycqLQOha1PowXI4ku/Np9dXAQoOlwqVApZmyvDew17lHn2V058
 QhtKZeV+Jpv/jGdPkgdW15PnTdOIheEj3KRnltCpel9qjywIK7T88Yk4630dxDxSFfR9
 OIuCXga1Bt+tvEqrTJb7FtdQVhxSjxdW8lYzNagudumOh0yYP4HbCYwbXuvF/vUMyKMF
 WoXygtO/DhnlTPOFjbqI3SV8cH8maB7YDNtm3j+xTp1AmQIvBeQL30pFX5UTTFPaFe/Z
 Y9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763634; x=1769368434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nIepW19+nTKrdNIQaGFMgkyMRXqNM6GUWr+RcCM6zPU=;
 b=uaF0IJY6P6OEIY719hPvgqyaLfyHwSZqUdqYgMSH/N/61poJVJtErVHSEo81TDuzSQ
 HyB0J988Ljx3Z4Yb4l6p6IZCmvvvK8a3exyQUXhFuM41vsB7kdswyEMoG9Gy9EE1W+UW
 w0+ocpclcUGlIr7PytGH62sTY+Z5h3s70Fd9CF9/i0C2lk5wn8Synfhfr1CV1KnkrBbx
 NLDNjlLyYb/x9WxUrQiFt0qHLqQ6KP9CaZ0TdRbLgfIu9ElxSY7aqDss3UkjKQhf0GNh
 BZj6rz76t5n1/LXNFh/Vb8eH+ZX0nw2XC24i188MGa6ZjKHSykgVNdGqngoWf03vJcvw
 XcvQ==
X-Gm-Message-State: AOJu0YwY/XKQ+SIBaH2P5jVwzsJhoYxFnoUtj68ldc/J7/JpjCZLuv9w
 Okfj6BnYV2ueywp6nXaKfCGxiyFarrV0dBskvP2bXxWS9lQEH6rk+F5tpSVzv5FZwJY8xlBxI5Y
 gu/3E
X-Gm-Gg: AY/fxX4yUq/lHEXmth5mEjxh+GIjZoEPFZh+I7K3f6qyKwORj0q0vPvy6zGl9UoQBsF
 bm1fQJQYjrTJVV+G6HpoSC53iJQTytqEEVfc5buj+tstC2QNPrIQi7dphhdPI/1WKyY6XXSAw2+
 s8Dl2psVB1Jy0Ug1a86qs6ceGVLsGemEhtXlDEDN2tV2fGmOlHSOLgSSmTpjypvOvYr+aZ+mvA3
 55czeQQK2hq6CDUwjZLI3JDlOR6qya7zNOnpjS7zwkji3CCBtHQgcpZFD4SnR0EE3vDELkK7uk4
 JYBn2K4TDySBl2UzW9hyhZ0lJquK+bBShuV3GKxMvA3ib/zT74r88Hv9of9fmIL/kTIIqzExAaa
 gzTswvp08pBRPb8uzPQgYxJwawok6jq6bPSapY+RApeoqJ3PlEYRn1r/rsweN4wzR5P3GPrkepE
 tIlGNYb7r1ph0mkAPmkPLsT6HNWfl8NCI4k3kk6S+ob1cRJUr8gg==
X-Received: by 2002:a17:907:3d87:b0:b87:3087:5501 with SMTP id
 a640c23a62f3a-b8792d36047mr704456766b.7.1768763634040; 
 Sun, 18 Jan 2026 11:13:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 16/54] doc: correct grammar in efd guide
Date: Sun, 18 Jan 2026 11:10:19 -0800
Message-ID: <20260118191323.241013-17-stephen@networkplumber.org>
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
- Change "flow table need to store" to "flow table needs to store"
- Add missing verb "is performed" in brute force search sentence
- Change "it can used as" to "it can be used as"
- Change "keys for each group is stored" to "keys for each group are
  stored"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/efd_lib.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/guides/prog_guide/efd_lib.rst b/doc/guides/prog_guide/efd_lib.rst
index 68404d5f33..71f58b00e0 100644
--- a/doc/guides/prog_guide/efd_lib.rst
+++ b/doc/guides/prog_guide/efd_lib.rst
@@ -100,7 +100,7 @@ are retrieved. The retrieved key(s) is matched with the input flow key
 and if there is a match the value (target id) is returned.
 
 The drawback of using a hash table for flow distribution/load balancing
-is the storage requirement, since the flow table need to store keys,
+is the storage requirement, since the flow table needs to store keys,
 signatures and target values. This doesn't allow this scheme to scale to
 millions of flow keys. Large tables will usually not fit in
 the CPU cache, and hence, the lookup performance is degraded because of
@@ -142,7 +142,7 @@ impossible, as a result EFD, as shown in :numref:`figure_efd5`,
 breaks the problem into smaller pieces (divide and conquer).
 EFD divides the entire input key set into many small groups.
 Each group consists of approximately 20-28 keys (a configurable parameter
-for the library), then, for each small group, a brute force search to find
+for the library), then, for each small group, a brute force search is performed to find
 a hash function that produces the correct outputs for each key in the group.
 
 It should be mentioned that, since the online lookup table for EFD
@@ -161,7 +161,7 @@ Example of EFD Library Usage
 ----------------------------
 
 EFD can be used along the data path of many network functions and middleboxes.
-As previously mentioned, it can used as an index table for
+As previously mentioned, it can be used as an index table for
 <key,value> pairs, meta-data for objects, a flow-level load balancer, etc.
 :numref:`figure_efd6` shows an example of using EFD as a flow-level load
 balancer, where flows are received at a front end server before being forwarded
@@ -301,7 +301,7 @@ stores two version of the <key,value> table:
 
 -  Offline Version (in memory): Only used for the insertion/update
    operation, which is less frequent than the lookup operation. In the
-   offline version the exact keys for each group is stored. When a new
+   offline version the exact keys for each group are stored. When a new
    key is added, the hash function is updated that will satisfy the
    value for the new key together with the all old keys already inserted
    in this group.
-- 
2.51.0

