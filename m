Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB0CC43327
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:22:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 485FD40B92;
	Wed,  1 Jul 2026 18:21:42 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id DC34740A6E
 for <dev@dpdk.org>; Wed,  1 Jul 2026 18:21:38 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-380cda7f00cso126259a91.0
 for <dev@dpdk.org>; Wed, 01 Jul 2026 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782922898;
 x=1783527698; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqLNxSzV5lOiyNJqZ3u2GTh2HDlPuHygR6PnC2klQZ8=;
 b=bUsOCnZOIY9rPSBgIjS6CtziHyKeEc1oEOA9BY/N+I+cZWN2VJiKwrF8j+QV6tFtW4
 Lj7u4cZcB/ORm7eC94Z0U9LPKqURg9lAYmPLLzeJcurCpJrbnki593QJ8N8NUTDGvhR7
 oAnrKxy0jqh8ClW1qAeWXChAwHrbie5/PsnRcSPOxW/j/07XKCU+6b3l6POIO4zNl84I
 8r9GIRx+0pFs2Kit8hv6I49VilJqJpGSyiV1Nfa8W0lYhPm+e+NbXw/Zeu5jZnglsSEg
 +VOHCm0EX76exj4BzbKzfiVhRO6kOkGNEWNxRcr+jqGzyNcnJOXBd5Z69aZl8ASod2fq
 A3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922898; x=1783527698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mqLNxSzV5lOiyNJqZ3u2GTh2HDlPuHygR6PnC2klQZ8=;
 b=o3YBYOzeyoHRE4f6JtZ/JBBWwUhV9bBECrVznIAq8S/jN40Je0v8i7pcF0bx30CDSy
 7W2VjD0mRG53vYvCNYDm+KntuS1C6NVOTlzB36fFhYg0ihdK7utVLm0YQVwQV/HSA7ML
 f11TzGs7AXrfu4rFlONWW5oRD8ZQu25unoL/7zcHTf520LzkqE9H6a1O/f3i9ZNBuhiI
 7FRaK/vFXjH86k0XvM0TgUr0jx8WWtUjDafEFFVDM1ORywpga3eY9hfVxg81Ev2Ghvoe
 zywj9DMnfNuhzUo5GhXFVvBCGo1zTQ0MSA45APbtXZdPB5YGmf4ZDIb1LYXo8bVoIcCw
 rqog==
X-Gm-Message-State: AOJu0YxddxpItgibN41xQi5cIcOiS4jtQV22fiR7nBmpD+Gx5IbuPI9G
 aguT5PxXQkvvTayJhSIThq3kuTvigcPf2/kxAbxMLBRw8u3M+jNPefo/oCHYQ2ygeo5XYXf3Y/s
 vy1k0
X-Gm-Gg: AfdE7cmp3EBdF6E3KhwBWhA7Mc3eM/lwhc18hP+dGLmARQAQL1Ea6RkKcNRD57T0I1+
 yBxc7gHDYRUirIvxlxWQO5e3PNkEXe7srLUnrFh1L/FwW3Fh10dFtXM/GZqQ1lJl86DgBc4Crst
 cl9cN2ySyyWvzb0mea8vn6HEUJ8KbfhfNOCOhoCxV8eo3J7B4vPSZCD8zDbA66dV7dxB12lNZdD
 tCVEgMRp2Gv/bbBwnRqYAXWmlhjbFZSjpwg2lGXV0Haphuyv6+LZcR+h+9yxfrMhcxIBiAtFBCg
 0aQn3I4kExcKOxox3m6qd/m/lZBFrz7zQ+fHSGajFLsWCuz7tbQrUnhJYYAdLi84ro/eP3bEKVg
 QvM5EVXKMjQ+xH+mGlmnniRGhTIIhSfTFoHIclYLdoO4qP4iK89GChuL9yTaOl79EVuGd3nl9f6
 7funTTSAmzGR/2j00+R0QxCezgCWAe5IUK/ZYBuaTErGncA3K6YAM=
X-Received: by 2002:a17:90a:d005:b0:380:8b14:d8e1 with SMTP id
 98e67ed59e1d1-380baa8dc8dmr1454566a91.24.1782922898069; 
 Wed, 01 Jul 2026 09:21:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee32519aesm22039877eec.27.2026.07.01.09.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:21:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 8/8] doc: add release note about ip_frag changes
Date: Wed,  1 Jul 2026 09:20:33 -0700
Message-ID: <20260701162127.207318-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701162127.207318-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260701162127.207318-1-stephen@networkplumber.org>
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

These changes maybe surprising and need some documentation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_07.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 4ca0a9ac77..4918cb59ed 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -241,6 +241,16 @@ API Changes
   - ``rte_pmd_mlx5_enable_steering``
   - ``rte_pmd_mlx5_disable_steering``
 
+* **ip_frag: changed handling of malformed fragments.**
+
+  - Duplicate fragments are tolerated instead of failing reassembly.
+  - Overlapping fragments are rejected on arrival rather than during reassembly.
+  - Oversized fragments (reassembled length over 65535) are rejected.
+  - For IPv6, fragments with per-fragment extension headers are rejected.
+
+  Overlap and oversize are now detected on arrival, which adds a scan of the
+  already received fragments per fragment and may affect throughput.
+
 
 ABI Changes
 -----------
-- 
2.53.0

