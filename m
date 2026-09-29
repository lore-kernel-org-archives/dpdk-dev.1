Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F43CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:45:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D93C742FD5;
	Tue, 29 Sep 2026 18:40:40 +0200 (CEST)
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37]) by mails.dpdk.org (Postfix) with ESMTP id 78DC742E15
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:39:02 +0200 (CEST)
Received: by mail-pz2-f37.google.com with SMTP id
 d2e1a72fcca58-885f0eca6c4so340021b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699941;
 x=1791304741; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UX3W2cf8cX0vvTnrlrvLglpMZcL0XRXN+DzhCfzV/kM=;
 b=P0tMzTv/92sXE1VtgltQAU+UKz5H7jeZ+Jpr5qZLvE7zk65UBG7JNmQ4oWlpabVNfF
 0u4VITVOR5v12FDPoi4e1IICTyM5JGLaXQ5uNwxvRExeCEAo5kZpQpMlzBPb1ygFQMzq
 4lqb3MFPa43HGH1F/m7/zpqooAELe08BIHEg2fPqnQ1rpq23U61T7SQbEZOonfTEIQfy
 j9pBz7c6MY/GI4rflLMYmKWaArx7yMQyjlJCSsJoHyWSMlT/eDCvzwQomCTSPT8l0mmy
 T4UVVx9cSHZ2R0Z4FCWS67hANcvS1UGSobO73asLeEVVDbJc9TWWvV3SlRuek3LUd5+l
 Pi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699941; x=1791304741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UX3W2cf8cX0vvTnrlrvLglpMZcL0XRXN+DzhCfzV/kM=;
 b=bG9IC/MBTa6jfNBmVBjLDq4rJw/upHZo4YLAb5Vt+p9gv5MqpJT6DpAfIJ0WpVN27P
 IT606XpG5rikmY4QCdhtNpSPxmskuK1BRrvu4rS7ZEYbFuNar/Xzueo19pRVWJPYgaWe
 U3WIVzL9FZepjT6fwy/TmPqzt+0y32qYhxiUPBzyWegt8vSKGItM89ebDGjyV9UdEUnO
 fUcpVbGu140zUYkx81/73TGuI8wHvKySMVJsrzp+qVBhW9eCH40j7jeBD8AdZfktQqs0
 i0OxcdFqaZ9OQ5Ctqa9qPhQN367YnE3wa9c2M5y2HSSqbQ8indMWH1908aPTkdGYlzn8
 U6iQ==
X-Gm-Message-State: AFuF++kWkkal9D6RYelLS3YJiv2VUcl+scRu8IutUpfSXkCgbnOxHt9j
 iadCE1kfq11Pvfng4hAkgYbBRuXQ9MvVgV+TTKnRqQMkYxLSGxMm4+IySAJyJw7HQ45lkZnMQw7
 5xGOmdgnT5w==
X-Gm-Gg: AYBFou0jrS4YzXafbFbL65yhfr/VPb55HySom9ORg1E1OLfBVKB0MFZoM509E9BVm9p
 wzZDRICRTtQoTjlPrmhovIbQX8u9vKbDcBGKcdNjJxisPiSo7zC7EZzI32n6hMoAZO/mnipy0ZC
 cYpWFUTYV8GEbJHQspeoEHgARaNU9SF2eszFK99rkvNrV1tK7xmfsaV1W7K/VNdmQb2GZ0vWGg6
 2TWUvS+HAzJWGsS58JdPn2hO6YZIXEdOTsxuFv5sssJcOcafpJhPKm/0uxvOXWgIxeylewqH9bO
 T9s82bYRpmZ+7oTF/gDOi2iM68k0F/Y/zJeizaiy9tXpyqhIAo3q+Ceo5KahEm3VkkBnX5chXtz
 LIQgjUC21Y/TYleXnCi7t1dw2PWrOgaetU19PLUBa6na/cYqI9Ov5YnjR82MeKuCV8mf2NNdBZa
 ubkMp0yLaHytFSTHjVN1LX7rYM6saNdp9qFwvBhn4APK9XIuIcBBEp3lemQ5QDACBI7rzXze7XV
 7RYySuh7kIh+zJr/sMfMek0EHogEaXoWPjERw==
X-Received: by 2002:a05:6a00:3cd5:b0:878:3507:8d65 with SMTP id
 d2e1a72fcca58-87e9dfafacdmr13933707b3a.44.1790699941566; 
 Tue, 29 Sep 2026 09:39:01 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:39:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 61/61] doc: note kvargs devargs conversion in release notes
Date: Tue, 29 Sep 2026 09:37:04 -0700
Message-ID: <20260929163800.1108305-62-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

Record that the drivers were converted to the new kvargs helpers, and
what a user should expect to change: a device argument which is
malformed or out of range is now reported and rejected, where before it
was commonly truncated, wrapped around, or taken as zero.

This is kept as a separate patch at the end of the series rather than
folded into the last driver, so that the note does not depend on any one
driver patch surviving review.

The individual drivers are not listed. At 52 entries the list was too
long to be useful, and it meant a third of the driver patches touched
the release notes only to append a bullet.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index af19196ba3..e2aa2fd48e 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -164,6 +164,24 @@ New Features
   ``rte_kvargs_to_hex`` for the cases where a driver needs a narrower range
   than the target type allows.
 
+  52 drivers were converted to use these helpers. A device argument which
+  is malformed or out of range is now reported and rejected, where before
+  it was commonly truncated, wrapped around, or taken as zero.
+
+  The device arguments which are booleans were converted along with them.
+  Those now take any of the spellings above rather than only ``0`` and
+  ``1``, and ``key`` on its own means true. A value which is not a
+  boolean is rejected, where several drivers previously read it as false.
+  That includes an empty ``key=``, which ``net/pcap`` used to take as
+  true for ``infinite_rx``.
+
+  Two of these change what an existing argument means. ``event/dlb2``
+  only looked for a leading ``y`` in ``vector_opts_enable``,
+  ``default_ldb_port_allocation`` and ``enable_cq_weight``, so ``=1``
+  used to mean false and now means true. ``net/virtio`` compared
+  ``vectorized`` against ``"1"``, so ``vectorized=y`` used to mean false
+  and now means true.
+
 
 Removed Items
 -------------
-- 
2.53.0

