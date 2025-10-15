Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB030CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:07:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2006341156;
	Wed, 15 Oct 2025 11:05:26 +0200 (CEST)
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com
 [209.85.219.99]) by mails.dpdk.org (Postfix) with ESMTP id DB9A14113D
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:23 +0200 (CEST)
Received: by mail-qv1-f99.google.com with SMTP id
 6a1803df08f44-87a092251eeso13201706d6.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519123; x=1761123923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6r7Qif1e6qR0S1W944y6YqfDW70xyXuCLOdv23P+g6w=;
 b=frwI4ZHHhAix7nbLCg6kbnoSM7wuyQh2dvvstIUkRcJV2jaQTYa1qRsA64mkX49qeW
 vHT7MrZevD0ugtugCLJejmeFXBi9jx4Twxhr3cAeR65yT+XnpAzeanOf+KOgxwdMzoTC
 zIbb+xjUyDyXR9CmEDh6ecZLD518x27Mbpxg6S08XnLVKKmPY+/mBqU9rOfitT/wKQZz
 9DD8jmycYGvD96jhfZG4zJqFwhOKfkx6Xf++btI4kk1NlYsIPFwEJT3qq8itt40S4Uvh
 uxPpPwpt4sGr/v76lU42EliUMDnvFHm3zecrFTKXMUBCxqAiqOzT+tT54XNRsA+Yzow+
 tJtg==
X-Gm-Message-State: AOJu0YxC2JNLrT8JcgfpHvbpBxaLmLgHuyMzqjqwQBZtuLKHVhiZBgdG
 yzJeVdxMv0G892LlpvLRW6fVYb887FTn3g9A7OWPqZ1Xigre+d3gvTmJCdnXDAsfyjh8ib5uWug
 hbGEy+GHFVZ1O3uaJ+tNgH99NUFRbRMG+h+kth2VmTB5kEQ904Gi4M3cKREbFJ1fT5ljG7TGAnc
 Gw5LZ4ajfLmLBT1AT7U0EWqWFwKSbsZi2ckfpzWGtBIxOihKZYTRelbGlScQLzMeQtwcVKsA==
X-Gm-Gg: ASbGncuzDXUWLlHa5MCqttKWp+DkZpJ2vYvoB73z/AKIMqxSGRSMw3Uup0ax4qg+jl7
 +FaQGBEbc0waIrjga5MWsCWXFckAJNO8sJjCb4NAmRvLjGBPipjkH4+jqIWoKwzRID+Pw7cny1R
 djXtXqhdUamWSbV3dSGOHYhxhcJqNhVPUtiDpBGZDYhBzWwh0Bb0FbB7itOFLinbv9ANj0Dk0wg
 K9JaU/4C6Q0PWtM3svIQjMZIe3Vekt0idHCgN9QD3SbEBUeOmF+zttMxeXQfNL4jQGseu2u0pBY
 qTtiJYEvDYnKwk7259j0aEYxUiWtlb4nGXkScyglOM8QyTTE9tPn2Vtrl6Vudew+cjsz6s9NiQn
 w6Pct6Qc9oBuFSSeWIou5nq+0OK0JmrI6AMyd96xotS2nqU53EVkMMdQ3EURxNB3UAiC66gmY
X-Google-Smtp-Source: AGHT+IHUaIt5YstFrMbb+FJey0aPpFbOJIVz06lPkX8lWrYTecwyE53W9gCjVlRChQAfwhvxrf8HUFdLq1ux
X-Received: by 2002:ad4:5ca7:0:b0:7a1:781d:855a with SMTP id
 6a1803df08f44-87b3a784434mr417808526d6.4.1760519123203; 
 Wed, 15 Oct 2025 02:05:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87c0122172esm1911056d6.10.2025.10.15.02.05.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b6325a95e44so722158a12.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519121; x=1761123921; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6r7Qif1e6qR0S1W944y6YqfDW70xyXuCLOdv23P+g6w=;
 b=GbaVT7waTWGlgneSge6W6R85p/LPpWlDTAdOMtCA6hsIt6oLIScVB3M84GST1ZmLqd
 4Zox/hjcWDzFB6+BcO4EZT4oTQkyfSDi/Wz9+k0EKMXa2cfA8ulhM3F82TavD7RJhNq+
 3YTcFZqx0xiON4+hlZbenzzOzhDz0C+HzSDJE=
X-Received: by 2002:a05:6a20:7291:b0:334:92ac:602e with SMTP id
 adf61e73a8af0-33492ac629dmr102083637.30.1760519121435; 
 Wed, 15 Oct 2025 02:05:21 -0700 (PDT)
X-Received: by 2002:a05:6a20:7291:b0:334:92ac:602e with SMTP id
 adf61e73a8af0-33492ac629dmr102023637.30.1760519120663; 
 Wed, 15 Oct 2025 02:05:20 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:20 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v3 45/54] net/bnxt: add meson build options for TruFlow
Date: Wed, 15 Oct 2025 05:00:15 -0400
Message-Id: <20251015090024.32250-46-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Add meson options for
1. TF template
2. TF feature bits

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 meson_options.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson_options.txt b/meson_options.txt
index e28d24054c..3354ef2b4f 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -58,3 +58,7 @@ option('tests', type: 'boolean', value: true, description:
        'build unit tests')
 option('use_hpet', type: 'boolean', value: false, description:
        'use HPET timer in EAL')
+option('bnxt_tf_template', type: 'string', value: 'default', description:
+       'Truflow template selection')
+option('bnxt_tf_feat_bits', type: 'integer', value: 0, description:
+       'Truflow feature bits')
-- 
2.39.5 (Apple Git-154)

