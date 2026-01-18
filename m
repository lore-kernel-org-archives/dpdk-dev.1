Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2008C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A902140EAB;
	Sun, 18 Jan 2026 20:14:23 +0100 (CET)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) by mails.dpdk.org (Postfix) with ESMTP id 6563A427E0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:20 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b872cf905d3so600104366b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763660;
 x=1769368460; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKNGuzb/D3yGLjZo/XdfGBhWOy8fTIjrT3VY62eBssI=;
 b=iVH4zjTW+7ARqbeKRjPcGjqAQpyxrgzQOCR7Y6ZMaJQw1sE9S5kXtmMVFut6wxfjs3
 gxE4IKMfOU5Yc9UL5Cfhe3RAFnZbFyPFwXELWgfBvToGQVLntXj0u1YXMw9pNRTaEpCO
 iGb7hKK8VYyqCeTPe/mvgfh4T/ohNRTs8ZENWPJoDgpNtC1YJwaU1J14+r3TmfsIZCTN
 yb1kAagIs0Lq8R2RAlRQ/XvqqH+ZCEALZ7o003GLqu+GJpvSAi6ipNTs5hxwqqIQ8O4P
 mh+iGrwhKJBY5KBtHzVfTfOBqhsKZs76jZLehOCDJwY5DVjBDApQuiXMP1YXVk4mxw1q
 0O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763660; x=1769368460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eKNGuzb/D3yGLjZo/XdfGBhWOy8fTIjrT3VY62eBssI=;
 b=le0itlX0Y/vxnBiBc/UGas+/mqAULaff8hxJLt5VqeNjXmbgkom/Z9MWNML6uw4Y9o
 SMTPHz31Jm39K51PJirlTBZ25flpLTxnzR0pDlvcqPMMeIxqT5gjtdFqm+EWHVYKlHDl
 u53qIAPDKYNkWAk0dKwdL/pcbIc+LUXXDVd89SbQ35zRGdxeXk2SGcYjuJb6/Ad1lfE+
 7G4dwr4AAc+MZl1BuErFNDW9coMFD7gyFU7pLP0/PFwzPG2nZxCsW9rT44Nw/fCEgM+G
 r7lVDC+KQ3+Bpy8AsXTirfEMZijAJLzh8E1BUcaa3ifNRE24u2+JZmLzy1jQQLcymjkZ
 SYgw==
X-Gm-Message-State: AOJu0YzAjEY5eAwtArG1H7W5kIC8CX0JCmwYTyEgEc+gKM1BHmNNrzwz
 2xpItAt10+JPZFmMUR6tm58EYVavhaLE9WZxdjBkYeMgkWKvujYk9azC3Guoaa994J9CzT5ENVl
 bL7SQ
X-Gm-Gg: AY/fxX6Srqehuc9S320eeV6vxTFMbRDa2bBjoiRe8TfmmgvD5nlgrJN4YNfCZwLtUrr
 PlxblXv8XXVC+iaN49Ncrtc9g8TDzLoElqkvjaGtlv0rbIY/O9cJoZQP5s86wv+oOr80TCtdciZ
 i0x1jhz/y7gWPilhHll33UTwiaxj+yJUQyB6lP838Fi7qA/nXHQydjqoITUwnftMdJs6XVRDGt2
 cwNYW2AywAWqr/gSoOsAKommXEQupftDK4A6HlcwoQrYMAy4QLPfJ0WLSSOhZanAHOXZs6IttfV
 AuoEWplQYx3MoEjhVAJ7S1i0QcT7JAy3ad2ImzSoM0PMr0W4kjFqNkEJBSpnBT9cplxe9/naqy+
 TgWj+e0C8V0N2tR9MIUuz7RlfRFgsF1+yhjhEzpjR1AVMa9hFpC0woWxOcqCOfO1vBw2TM4IKpZ
 J8wlTmOnhdbHB4pyi6Jkx6HOBKXWGgo326ZSTJ0ELIoTCdKmnKpQ==
X-Received: by 2002:a17:906:f5a3:b0:b87:1ffc:bf9b with SMTP id
 a640c23a62f3a-b87968aa44bmr771253466b.3.1768763659855; 
 Sun, 18 Jan 2026 11:14:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 33/54] doc: correct errors in mempool library guide
Date: Sun, 18 Jan 2026 11:10:36 -0800
Message-ID: <20260118191323.241013-34-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Correct various issues in the mempool library documentation:

- use consistent lowercase "x86" architecture naming
- fix subject-verb agreement for "size is" not "size are"
- correct "(with locks)" to "(without locks)" since the benefit of
  per-core caches is avoiding locks on the shared ring
- fix function name rte_pktmbuf_create to rte_pktmbuf_pool_create

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/mempool_lib.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/guides/prog_guide/mempool_lib.rst b/doc/guides/prog_guide/mempool_lib.rst
index 8b4793afff..c10bc7bb43 100644
--- a/doc/guides/prog_guide/mempool_lib.rst
+++ b/doc/guides/prog_guide/mempool_lib.rst
@@ -33,7 +33,7 @@ but can be enabled by setting ``RTE_LIBRTE_MEMPOOL_STATS`` in ``config/rte_confi
 Memory Alignment Constraints on x86 architecture
 ------------------------------------------------
 
-Depending on hardware memory configuration on X86 architecture, performance can be greatly improved by adding a specific padding between objects.
+Depending on hardware memory configuration on x86 architecture, performance can be greatly improved by adding a specific padding between objects.
 The objective is to ensure that the beginning of each object starts on a different channel and rank in memory so that all channels are equally loaded.
 
 This is particularly true for packet buffers when doing L3 forwarding or flow classification.
@@ -59,7 +59,7 @@ Examples of alignment for different DIMM architectures are shown in
 In this case, the assumption is that a packet is 16 blocks of 64 bytes, which is not true.
 
 The Intel® 5520 chipset has three channels, so in most cases,
-no padding is required between objects (except for objects whose size are n x 3 x 64 bytes blocks).
+no padding is required between objects (except for objects whose size is n x 3 x 64 bytes blocks).
 
 .. _figure_memory-management2:
 
@@ -89,7 +89,7 @@ since each access requires a compare-and-set (CAS) operation.
 To avoid having too many access requests to the memory pool's ring,
 the memory pool allocator can maintain a per-core cache and do bulk requests to the memory pool's ring,
 via the cache with many fewer locks on the actual memory pool structure.
-In this way, each core has full access to its own cache (with locks) of free objects and
+In this way, each core has full access to its own cache (without locks) of free objects and
 only when the cache fills does the core need to shuffle some of the free objects back to the pools ring or
 obtain more objects when the cache is empty.
 
@@ -140,7 +140,7 @@ Legacy applications may continue to use the old ``rte_mempool_create()`` API
 call, which uses a ring based mempool handler by default. These applications
 will need to be modified to use a new mempool handler.
 
-For applications that use ``rte_pktmbuf_create()``, there is a config setting
+For applications that use ``rte_pktmbuf_pool_create()``, there is a config setting
 (``RTE_MBUF_DEFAULT_MEMPOOL_OPS``) that allows the application to make use of
 an alternative mempool handler.
 
-- 
2.51.0

