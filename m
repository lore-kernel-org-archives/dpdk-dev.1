Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FFEC021AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:36:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 432AD40691;
	Thu, 20 Feb 2025 03:35:46 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id E63394064A
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:34 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2210d92292eso10898755ad.1
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018934;
 x=1740623734; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31yToaCpK6Sdvmmn4PoJcShB+G3R40+OVPN52kNyd34=;
 b=XajGxlmwSbcn9C7diHe6DxAo6mh87Ts22zGYOJlcrVByJBY6nFVNdlF4qCaMgYw3bq
 fGYec/Sp8KrORQgkEunGlhGeEysGNgADrIKqcc8ZhEwh3khXZhVxSSGYeXc2x4TFr8Ap
 9c29RJYY1YpTgf+OZ3pgkln2OxocpbBC+jEezOfmIrsZ/cTs5RZa9YmXn8dVclPCMsCU
 i16AEx3QGoAmz3PyRpcKO2ZvIFfWEe3CjRRjfNtyj0FptorHUASWD4LxBG4fBrG4Oz8T
 EaQkg2zXWx/8pUuaeSvKY16Q7NdE01KuhWcCTE78JI6to2kUBDSV69N6Z+UAhI5+DLmU
 eETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018934; x=1740623734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31yToaCpK6Sdvmmn4PoJcShB+G3R40+OVPN52kNyd34=;
 b=fFgW0HrIWSFHizMOQ84csBkRaHUp3MFp/OkJlVtoj/o1YEto0uFiVp45OzybhBoaLb
 4yoEtD75wXAua5AfUyBBN74Y0msqUUBUf4IaEBDIcXExCp2cWWtsyso57fd7eFQ5KzGI
 jSwHt4Erzwoacb7YM03c/MXXAqgtcQCvxfpGjcWiBU+smfOxGNlnPeP7ahtrQO4ffwLD
 H4UGdoHLfEXsEwsOunYBJCIPTwRUb9qxbLQQX/k7mNHQtOGSnXGN9mEUizKBsrfIXFfV
 o2hh8TBpf0Yg/qEsOMbk/dH0hvF52JyZCuj7ypYgccf5oPDEohRIHlVNuprP8Rxn6TZZ
 LMMg==
X-Gm-Message-State: AOJu0YzMa6rokZKZp4PELzeifERYoUi7zAjtCkLufgd8ijeSMH54cCRU
 louwnl8VlOa09T/KyMe/DOzm4Oi+pp1eqnzjc5AKP5GAeaRqt6v3+2Fv9OV5Anrm2MtkW7oUje1
 6iMg=
X-Gm-Gg: ASbGnct79RF/oM2IG0oVzzf2KVxAVWJQG4eHfkh0n6A8uZbX5/WG8sMCSscDoczZGqx
 AMgTvoVRVQdPV+eVVR7zvGeiUjCSIwIMH4BL1GFyLBAunJ3HVcBJven8qFwLGQT73BI7gXNMoNl
 3yko59KCG34TSlM8yJb9A+uYbR02AbIxs9UPPP3+BEWQ0XEN040MxWP66CGygRBfgHTnJlk7LoS
 /IKLl8l1BZwqQtK2NHXKOYmcF7oEg7qXto0zhn+aJlXA+eKPy3IGZgw8UxTdXe8O0B+rndu9prP
 Y8osUmK4FJ/LW9hDJ0lPCH9Vce5dEfVgOjfJrGfCk31r0+QY7FZmpe6GOHRqNNZdKJwb
X-Google-Smtp-Source: AGHT+IErQnj/fUcFDPqkjF1ms5zZ1nI05bzcnGA/LSh1HqsmwE3PysguY+UXcegfxbPUmPxU2OOAZQ==
X-Received: by 2002:a17:902:ecca:b0:220:e9ef:ec98 with SMTP id
 d9443c01a7336-221709622b7mr105778165ad.19.1740018934170; 
 Wed, 19 Feb 2025 18:35:34 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v2 14/14] security: remove unnecessary dereference
Date: Wed, 19 Feb 2025 18:32:18 -0800
Message-ID: <20250220023509.630569-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220023509.630569-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
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

The expressions *instance->ops->set_pkt_metadata and
instance->ops->set_pkt_metadata are equivalent in C.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/security/rte_security.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/security/rte_security.c b/lib/security/rte_security.c
index e5c862f5f5..1e980343fe 100644
--- a/lib/security/rte_security.c
+++ b/lib/security/rte_security.c
@@ -258,10 +258,9 @@ __rte_security_set_pkt_metadata(void *ctx, void *sess, struct rte_mbuf *m, void
 	RTE_PTR_OR_ERR_RET(instance, -EINVAL);
 	RTE_PTR_OR_ERR_RET(instance->ops, -EINVAL);
 #endif
-	if (*instance->ops->set_pkt_metadata == NULL)
+	if (instance->ops->set_pkt_metadata == NULL)
 		return -ENOTSUP;
-	return instance->ops->set_pkt_metadata(instance->device,
-					       sess, m, params);
+	return instance->ops->set_pkt_metadata(instance->device, sess, m, params);
 }
 
 const struct rte_security_capability *
-- 
2.47.2

