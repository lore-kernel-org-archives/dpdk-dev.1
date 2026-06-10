Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11765CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 11:34:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28FF34066A;
	Wed, 10 Jun 2026 13:33:56 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 56E2740669
 for <dev@dpdk.org>; Wed, 10 Jun 2026 13:33:55 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-36bd175fdbaso4040336a91.0
 for <dev@dpdk.org>; Wed, 10 Jun 2026 04:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781091234; x=1781696034; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9lho02a5nYH5bsNKt+G8dqsRIUetl8PmUvzyNgYgtM=;
 b=hO+3RkmuL34+gwPTy4Shsf0oBlzrGZ8y+DeP8R5Z7V4S3e1I0YcKLqghAg2n9wYJTW
 ov43LOgCLMbaHtU+TeWcYgxmbqErd4pC7MkyfKcATl384ke92gVqKEN4+Gy6R9HljFpg
 agv+ZKpN5o2xdw6N/8NNCMHBiZvm+HMwpOmbOx5OF+t2h4ePset/J/6qu458IrRE0X6W
 tEmKvO+hVYqtlDV4hZMLbhuSBb0SnvntMZn2RNOkJpOBhj5x2s5lPQrpw56DWtukFoct
 dhsB0df8YWUSp7sHue6+0dbhYKbCjurAer55W5jGIpHyt1n6pefpPcHin0NeO9YEdRy5
 BCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781091234; x=1781696034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N9lho02a5nYH5bsNKt+G8dqsRIUetl8PmUvzyNgYgtM=;
 b=G1K/9NAWpFvpiEdA4WnaC61i/OJn/om6sQTJxKFh9clu2++WShj4mz4tI1KqdLXaAy
 dV+PgGLyahAuyPjXjcqat3lBrQtfsKc8byWu5DZwldIypyM7DH/DCCMlEe1+OEBnySDA
 aoGEcBpO9eIcGWve4g1rugdqCMEPvHLgIuqH0zJbxrTSAnIQrBXuPllSP4Og4CI+ZZRS
 8PDV0hxYYUxptxoj3F0hl8qRwsDE9LRAsnqoW+HOs6t4IGTVmRCyCBdgjHY+VoewsOI1
 yEgZF4TADwLFtzuYqPquLdZwxRdMKsy200jFw9mTDX1HrMqiVj+DknDsyjxQvddndE2t
 JGHA==
X-Gm-Message-State: AOJu0YzCT+v2OIPQDEAbuzdAFEvgmemioxyk9azGLi4xQiyhvTdHXlMw
 NjtrwKc2iEFutxmrYsanuA4EKO5gnE2tUx5wiwnYGds5/jIjPhs13GIeMw4Fca4l+QE=
X-Gm-Gg: Acq92OEjK4A5ov3+uJ/bB+3XNPnz+wWJ+mcB8GvQeybvWOLeYaFONtoDeRIer22qslM
 R5iIo43Jkbz4+h9G6IQpzi/B5PeruHyA2kw9J0LomEGfeIW8fRGHeD1vQSmvbfghKqyu1N1EcJ+
 UwHfmLzRNHHul60oaurTeZ6YvstfrCLysZg2qii1tCjwjqBewVLBHDeH1vcnwjvWRdhqaEvyn/v
 nIuZ0QEhmadC/W7I6bCUA3+jtrh1bOKMP+jeHCej8UkvSUkoJWYzkeaSwpOe5fUJ+xw8H152KSP
 z3UVgzy9aaxaW54ccSPJ6L4Up5VJMY/OWEA+pCwOjbZtqFIu4Xoz5oRcYbd5pqlHgGIiXKV7Zyy
 gTTRtwF1ABe9gVO2993GljIASSgz/sJBqFAxjTEQ8dCSA/FiyoyBNYqWX8NQqy9ewWstzEhXluG
 40l9ieH4YJooWp6uPbluhzkO7gzeV41T15uKA5H7Xpeucs2xzGO0pg0aAmPJE=
X-Received: by 2002:a17:90b:280c:b0:36d:8f51:fe29 with SMTP id
 98e67ed59e1d1-370f0284a6fmr27003012a91.17.1781091234298; 
 Wed, 10 Jun 2026 04:33:54 -0700 (PDT)
Received: from JRT-PC.. (bb116-15-8-251.singnet.com.sg. [116.15.8.251])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842828e228asm26885547b3a.47.2026.06.10.04.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 04:33:53 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: dev@dpdk.org
Cc: orika@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org, stable@dpdk.org,
 James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: [PATCH v2 1/2] ethdev: fix out-of-bounds write in GENEVE option
 conversion
Date: Wed, 10 Jun 2026 19:33:33 +0800
Message-ID: <20260610113334.277895-2-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610113334.277895-1-jamestiotio@gmail.com>
References: <20260610113334.277895-1-jamestiotio@gmail.com>
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

rte_flow_conv_item_spec() is documented to truncate output to the
caller-supplied buffer size. For RTE_FLOW_ITEM_TYPE_GENEVE_OPT, the
deep-copy of the variable-length option data was gated on `size > 0`
instead of `size >= off + tmp`, the form used by the sibling RAW
branch. A caller passing a buffer just large enough for the header
struct had adjacent memory clobbered by up to `option_len * 4` bytes of
option payload.

Align the GENEVE_OPT guard with the RAW one.

Fixes: 841a0445442d ("ethdev: fix GENEVE option item conversion")
Cc: stable@dpdk.org

Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
---
 lib/ethdev/rte_flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index ec0fe08355..e534f2295b 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -701,7 +701,7 @@ rte_flow_conv_item_spec(void *buf, const size_t size,
 		src.geneve_opt = data;
 		dst.geneve_opt = buf;
 		tmp = spec.geneve_opt ? (spec.geneve_opt->option_len << 2) : 0;
-		if (size > 0 && tmp > 0 && src.geneve_opt->data) {
+		if (size >= off + tmp && tmp > 0 && src.geneve_opt->data) {
 			deep_src = (void *)((uintptr_t)(dst.geneve_opt + 1));
 			dst.geneve_opt->data = rte_memcpy(deep_src,
 							  src.geneve_opt->data,
-- 
2.43.0

