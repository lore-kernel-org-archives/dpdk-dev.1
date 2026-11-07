Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F0606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wm3F4gLr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 959A340264;
	Sun,  8 Nov 2026 00:14:21 +0100 (CET)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by mails.dpdk.org (Postfix) with ESMTPS id C475940264
 for <dev@dpdk.org>; Sun,  8 Nov 2026 00:14:20 +0100 (CET)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-53c156ba662so29867b6e.1
 for <dev@dpdk.org>; Sat, 07 Nov 2026 15:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794093259; cv=none;
 d=google.com; s=arc-20260327;
 b=bCh0V/ORvlMSaWvV7hSVJ1hJotm4Mvgqn00ctxV6YSuJz4/t9RMR+SyStFSmgcBLF7
 O5wpUL6wLURQ50YyE1hceaw5kK/ErnN8idh/CQRxOe2ozGT0YHhPZpwg40sxO5A4v4LR
 PF+nI1ArfZpFYqdCMaCxyLaqOc8gDUwzXFqIGxiI5emMVWoVR3UJcV28MBs6aADUSaU2
 NErg4U0ocY8dUAMQb/VDyzVQ8tJXNzzUiTj5QshIcI9ccUWguTkwbKsoXbR6X0Oi4sjI
 9FWish+ANVk8tY8mmdcrq/JhP9lW7hvLtIumlPxU1xd/YkTWD8X9JrIorR2BO4f5Lqv/
 27tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Nic9zburoFE64P1fv+gABc1NvxcoB1MwCC2R1Eyj55U=;
 fh=dzvl2T+HpsPJIPL4vrJcSXkWj+SVEfihkBzHhwADOS0=;
 b=e6Ha1JKEZkjbRXOPft0cKwJIyMT/g5/J4/4WKpNEyKMPF1N6I8c+cgWly/tOfFqWTT
 uXxA0aFKOk3AHkjxqqrcif01SFlMPAembnGrfT+zu4rvFX91H7GML92DPt9J96rxy927
 5XwVHkKuQKjjLxPgc4xv5RBzjI4c6Po091ZoLmqB7vF2NNHhs0dmcP1TCkPkzT/jBgco
 M01tIBcuZOzYetC4JjK7qkZLq0FsNsfNMCGKqJ7ovQhkqnGg/OAx2fclF124421T2c5U
 4uxfcRponAhxhGz/YXrORSASjzxfwtwTGiYRBNcph3V1itzyDKit7rQCNNuConpO9ZQf
 kGFA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794093259; x=1794698059; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Nic9zburoFE64P1fv+gABc1NvxcoB1MwCC2R1Eyj55U=;
 b=Wm3F4gLriQAL5D1vWWWPAt44BkQ+kbEXHnGvlgtt5bk4uIHkLp1eaxaHSiQCxgui+N
 etMeVSInbjvZOn94P3aeUYv4Eqo2wml9lh1HVeVk4OPiuGDWvSAOPegQDVOW3O7F1Wu4
 SA9xY+JAa190YRF48duJK2ai7/JcXd3gyfpterqKqIbAk64gmoecSQkOlum0pSlfUA5G
 Rp0V3UGZdR+Yg18E/e2ytcDCDKuqSL5u6CGe7b88TJIS4PwD2MojQe5WzhoGwGIQtfdE
 m3uYmS1Woluh/Wo3EAMnMzIu52oJmthdtKSzBatYEuw0Oqgx/9pzRyheyNwYtJ8PrHhM
 mYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794093259; x=1794698059;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nic9zburoFE64P1fv+gABc1NvxcoB1MwCC2R1Eyj55U=;
 b=h7SrHNK2ctZjqfOi7LLzj4yQVtAEyqQyseWr+ofzdPYM+dpEmsmTjtZ/LShxEhE4kc
 5UJ2t4BfszVS5ibV8t/2GaUvT44AnkJBXOpNlvmgyYljHjCDAx3vbteLwUV54nBiUb8C
 slETf1oi3q15XZJRnZpXBDJGy3oyYB6DPXKDrvLJ1PBVLM19scZbmyMNJQUb7k1X9P6Y
 I6+WktMH6/RC7l1s1+XLpr3yaAYIWT3tdJ6gJ8b81y1Bu3gAZ+uyTHtsMobFMh7Jpsub
 2+KSe6dK6GoVf/JSkhDex2WajYoeIPf4bYD7HBG4LeWmq2hl7GjiqUCi8KqlkloNKgP7
 H2ow==
X-Gm-Message-State: APuU4Z9IezRQBbin8fyfBVxThRZF0lI8/kEjEFm+vR6CW5HPyBsY4RSP
 NkT7XZXp+sgpC2+AfZqL2cEw0WK3YCRwFDbq4IlplgxYPyPIbUPJ5dfmnYvQgdTZ6IwtTlldm2B
 aBFV427uD38vj3k3Y9Cpo6c3pPkxcmWQ=
X-Gm-Gg: AYBFou28MQsR0TAe8HrgY3v7WNry7BozircCyUbbU/79a4PszVRWCXrt5eERwHxijET
 VW3yX+JPctV2Jirybr6Te3TZwRctiKqhryviXeHVgjyei5kM4IDd5Lj4mqN2PKRETQ8gEDBKAwl
 RHgLJjBQFnEkfelMtSkVlzJLZAwFyU60Wk5NoXRfeQlxw/LXgsaMML7zpovUKUEya9n9y0yEHPP
 cUIysFu3EXzAYNmdrDoQndxEadLAXq3q64ZpBohRDgNIa0A5A1GmdYdrx0VJOgA7+1ibny6/It3
 hRu6C8nUqqyTgPSHgqEwROpNVuvu2STooxR16zPVVD2259MY+bzeRgfluWxS5WNLkzlIX0oLO6v
 Sj6YAYBr5L+/xY3Kfq98WpLWsGKkcHJBHdtiNcETViMKX3in1u3sZfHTnPm3cVaRXEZqzhg==
X-Received: by 2002:a05:6808:23c7:b0:4fb:bfc2:1a64 with SMTP id
 5614622812f47-5681472ecabmr89375b6e.31.1794093259364; Sat, 07 Nov 2026
 15:14:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105071710.3640765-1-mkashani@nvidia.com>
In-Reply-To: <20261105071710.3640765-1-mkashani@nvidia.com>
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Date: Sun, 8 Nov 2026 02:14:08 +0300
X-Gm-Features: AclHuK9rdcgKeF1wGK8UeqkyZLpO-C3IukvDYf58vHc9rAlEgDVfpUZdvo5BDXs
Message-ID: <CAEYuUWCMbJU-N5CJRycsjKPYDf+n_chKy-6AH3J+irPJBjtS4w@mail.gmail.com>
Subject: Re: [PATCH] eal/linux: fix dirty flag for reused hugepages in legacy
 mem
To: Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, stable@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acked-by: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>

> Why a reused page is dirty is documented on unlink_existing.
The mechanism is also described in
doc/guides/prog_guide/env_abstraction_layer.rst.
I'm a bit worried that the comment and the guide will run out of sync
eventually.
