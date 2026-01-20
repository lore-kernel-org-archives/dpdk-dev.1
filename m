Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD8D2629F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 23:25:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 781B0427A2;
	Wed, 21 Jan 2026 00:24:44 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id A9B9942796
 for <dev@dpdk.org>; Wed, 21 Jan 2026 00:24:40 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so34824485e9.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768951480; x=1769556280; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlkMe4GQSZvV/j50f7vAHrolijhHf9ToApooqRUeMkk=;
 b=a4Du+BU/3vP16qBYJQeeDs3k3LktfTDxFNh9DH7Nb4LZmm8ggAAWTHYZ01/7Kthbep
 3K75y7gB8XeaTl3+gda8sYSLkfhDhuvHgtZm1OuIJApgWJuzqb4Crv2stHc8cp9s7/pG
 kCHBeWQdTuOWT4v3hVTTQQsLBz8lAe/isTN/073vIAzah1RfN+AyjlevPLaceMRlG/vP
 vC+OjAKei5wl8ayycJRDguzIUyspZcV0wWY3tFkdU97t0qwhf6rbt5EygvFfA2BNicjO
 g9haLi1vQ6vw38uklTXOQTClPx4R5qhkJMgXsnfIdhhP0cWFXnHBb2hX/ldXR8pk3an8
 VPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768951480; x=1769556280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DlkMe4GQSZvV/j50f7vAHrolijhHf9ToApooqRUeMkk=;
 b=bkM5qNYGcrkY+yF009jAXj4SuYmAXPKmuKrm7Lfrf2fJxATyFVQLvFfGnWC3bLNyfN
 NCvHT/nVd8DMqR0NU8t5kaUryHlajYajOg0y9rnnY25XdliHz0Yb4pOyR6D3R9AopkKd
 9IOo+7/lYYQu6lJ0gWqT8z+F0Y+aYNbZKCGPgsnUdRGkvQVvcN1CeDxHRgWP5OXZ0LAo
 CIljtWwcB/lJsg7U00FB0A4UnuqWG2HmYOMCdBuJgiEsb8jyU5fCcTfm2o3WffrACraO
 uShU+ksXnw+7pwqo1hFsuU07fk0oRompj8UVQjfowDFUhsLLhELqdrmLUrMDTQ3pmLiA
 Fceg==
X-Gm-Message-State: AOJu0YxBitVy3OrV55nI9oJ+ZkNxBihjGDy16CvIgEQ54E0iggyPD/0j
 Ei3czARL7JVgCLLzv4ZLHa4HG/j/gw3g7q6Hd+0UvDYfi+H6RbfmyCZhPQT5OyiOS1N6dWc2V00
 t1r4H
X-Gm-Gg: AY/fxX7BXAFk/7EKjfE6uCDhu7nwU44hSSHLNIm/n2xr3b36EapeAAkKR4Hl6FU6nh1
 9FUJ7zM0uGxSlEt3JP6wTrLBUlmL/t5dG78K7Wb42zxKhpVbPd0M2kKpzoJkAn1GNUDWo6yKqwQ
 S2YaBGuoxOt1q+Qgv/mnP6NPdyIzDtCQ6kPntklK0DvdXmvxhDAxoW5rHodcG+fPfipTvp7GzeH
 RB42f4Mwxne/SWdxnGIE+cjgXWriDPTjDUgQBJvxiAtxfe8M3RpVKwmSzuJXEa7/S7h4EXYuzIU
 9M8MhducpAfJu+f/k2yDPf59+KufIEHG/EY86QHUcbR0kIh8aCq8qJqUuU2+DQqq1eS9X2a3rKd
 7JmD0RM+ZU95VVsi/mlxQbW56MC9WE3+ZipdAiL8hjaVQJEEtL79rEFYeHKImITXGkKmNhriKEQ
 MtNXZDDqE34Mwu3JwzL1Vh+J4uVAtSdwZ7Ic/a7pCTLnzeSZbqKV2CQmbL
X-Received: by 2002:a05:600c:638e:b0:47e:e946:3a59 with SMTP id
 5b1f17b1804b1-4803e802282mr49599235e9.34.1768951480130; 
 Tue, 20 Jan 2026 15:24:40 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804249c5e9sm5865505e9.1.2026.01.20.15.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 15:24:39 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v4 7/7] mailmap: update a new contributor email
Date: Wed, 21 Jan 2026 00:24:24 +0100
Message-ID: <20260120232424.195059-8-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260120232424.195059-1-sismis@dyna-nic.com>
References: <20260120232424.195059-1-sismis@dyna-nic.com>
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

Add a second email address for Lukas Sismis.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..d838ffb4db 100644
--- a/.mailmap
+++ b/.mailmap
@@ -933,7 +933,7 @@ Luca Boccassi <luca.boccassi@microsoft.com> <lboccass@brocade.com>
 Luca Boccassi <luca.boccassi@microsoft.com> <luca.boccassi@intl.att.com>
 Luca Vizzarro <luca.vizzarro@arm.com>
 Luka Jankovic <luka.jankovic@ericsson.com>
-Lukas Sismis <sismis@cesnet.cz>
+Lukas Sismis <sismis@dyna-nic.com> <sismis@cesnet.cz>
 Lukasz Bartosik <lbartosik@marvell.com>
 Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
 Lukasz Czapnik <lukasz.czapnik@intel.com>
-- 
2.43.7

