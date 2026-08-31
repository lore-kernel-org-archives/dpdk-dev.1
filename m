Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69349C624A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E5A640689;
	Mon, 31 Aug 2026 18:11:51 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 96E7A40689
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:11:50 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d6f9e2f681so35059645ad.3
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788192710;
 x=1788797510; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L7HGPl/+DvTRV4kydVnbQUyXlb5kYLwQNLaQtgw6MAU=;
 b=zgI1I7LZhS8EnusN7FyLWRM7orptIcBizYhCdeR/aWeudcZ+YXqFZMA9vWvJTPN5xM
 KK3+ctXozMfUzx/qZOKKX+qfxVMHrit69zHE+XcmZ1tnTmKfLAsJYjRVgopSiILq8a4x
 3tQ1hqZYf6qvPx4gJnSdapJOyb2FrrAyJAWUiqar9yK4PYHjcFYsBXU3O0RBLHq+Km2o
 mF9t5+nzNZ9wuo1JUWnSLgqz2r6NaYVFXTRc3RbqPYV3Ey1UjI6s5v+ZYujYeS+p8pEb
 h9EaQxcnQsT11IGiZwD6CyB4XPw9sGBLoDzne+MlR7iGLz4bTQ2ScZ5YtRCGlBhNmmDP
 dpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192710; x=1788797510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L7HGPl/+DvTRV4kydVnbQUyXlb5kYLwQNLaQtgw6MAU=;
 b=J3JMh/QyankH5ATtiT9rlGPO3/eVpSBhRg44qo/pGoql3pXqSNMknuckOjTXItrVW4
 xQ3E1Uj/QKWHzRqET8US3yrMUxnoUcmqRRPxhS/uZ+spsjYjPV6v70tzD4nlLrpjmxN+
 tfrvw/linuOdLjFf5TYmM2ABKOMWUyQcJx7MHpbMB2SkXH1Bza2TFP3BB879bTXUpBeM
 ZYiYDJOd+f1637PquxWVenSSb4Q1I6oebSAFzUBEJy4kKtcoFGbyo5Re15rg8Dc/8ICE
 uzstSvgYDcs0BqYUCnXze/TkpKB+nLtujgynqnte4i00R7tJoGfnJ3Bubaben5MZ42j2
 sUbA==
X-Gm-Message-State: AFuF++niIW762XDfllJLbp0fzgJFMxAkkuPJYvUXYRrMOLPaPZ+C+0HU
 U4ZF8tNhNY3wxLgyCeejm0Y5wVbRFRL50w/NGtyPOkKjgnA5qNi2llczOaAPFisOcAEOl6UuRg9
 E/MyN
X-Gm-Gg: AYBFou2xqZifPVcR7HkVO73A3r8uR92kjR7W56hQUx/T+2tljMUZ3s2Nl9S4s2CTSvC
 P5Y6MvEsxy+MHSoa9RVllqGKKaHfpNxa42YZNxmqUu2cqpA5y/RndTyfZ0OabOR3XSlvU+7V/jF
 67kHKUA1ZHGpUpVNw4gpEE9WMN6BlBC3Cn2jWkvuwTKlAiGJrvCgUblZG8RnQlh9mPEadSYiwx2
 r0N0Ra74zXTbJxiGEB1johAUamCiq2kSZiBISCN7n5wb7jXnOeibGk4nQJQvaZCLQTpjdJEYGpl
 asTQL9+mU8ZGe/Id78YEqRRig05egsFPNr3PS1OywhTZcnC5QrDF6cAEZNThiTC5RBLc9LsoTSt
 avvKGwNV6dmpfrQfrQ4YRQe2TVegNy3oX1QuT1NxLzpRwKtrtZJKkHgbaecwJxQDfyoU45sEFQ+
 Om/hj+x9Jzw8X+TvnC0pwJ3u34a+1u+TtBW2u27NZLNjG+fZ84VG/i4UVEsDQ1s2AV5ruiioVUu
 wfZoPmnv5nUZq9HB6UzXwF6NRQ=
X-Received: by 2002:a17:903:3884:b0:2d6:3c22:993a with SMTP id
 d9443c01a7336-2d74dbe96fdmr418204555ad.3.1788192709721; 
 Mon, 31 Aug 2026 09:11:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f7be607sm31355741eec.10.2026.08.31.09.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:11:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 8/8] doc: add bonding features matrix
Date: Mon, 31 Aug 2026 09:06:48 -0700
Message-ID: <20260831161105.289670-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831161105.289670-1-stephen@networkplumber.org>
References: <20260708174204.72574-1-wpan3636@gmail.com>
 <20260831161105.289670-1-stephen@networkplumber.org>
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

Bonding was the only in-tree net PMD without an entry in
doc/guides/nics/features, so it did not appear in the driver
overview table.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/bonding.ini | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 doc/guides/nics/features/bonding.ini

diff --git a/doc/guides/nics/features/bonding.ini b/doc/guides/nics/features/bonding.ini
new file mode 100644
index 0000000000..27560f63c7
--- /dev/null
+++ b/doc/guides/nics/features/bonding.ini
@@ -0,0 +1,40 @@
+;
+; Supported features of the 'bonding' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Speed capabilities   = Y
+Link speed configuration = Y
+Link status          = Y
+Link status event    = Y
+Fast mbuf free       = Y
+MTU update           = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
+Unicast MAC filter   = Y
+RSS hash             = Y
+RSS key update       = Y
+RSS reta update      = Y
+VLAN filter          = Y
+Basic stats          = Y
+Extended stats       = Y
+FreeBSD              = Y
+Linux                = Y
+ARMv8                = Y
+Power8               = Y
+x86-32               = Y
+x86-64               = Y
+Usage doc            = Y
+
+; Flow rules are passed through to the members, so the usable items and
+; actions are those common to all of them. Only the types named by the
+; bonding driver itself are listed here: eth and queue are used for the
+; mode 4 dedicated LACP queue, and count is the one action that
+; bonding aggregates across members on query.
+[rte_flow items]
+eth                  = P
+
+[rte_flow actions]
+count                = P
+queue                = P
-- 
2.53.0

