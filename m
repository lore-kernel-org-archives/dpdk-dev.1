Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37944606A323
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=J6RijOQ9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5F1240151;
	Wed, 28 Oct 2026 16:32:44 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTPS id CF6FD400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 16:32:43 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2e608cd460eso6874815ad.3
 for <dev@dpdk.org>; Wed, 28 Oct 2026 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793201562;
 x=1793806362; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fo7qSTLZKzpbH4OKb3TSusktP4dZqpXeZxd8/cMPbFA=;
 b=J6RijOQ98NxjMxSPdpvPz9qah8l0Ae1ZuLaESvNMe7UyGYTQ7veJdwNs6eN6qU3Jcz
 oujTp12W8yH7ijTlsQ7nUyr/fgv5XR9nJ8mTc8ArIjSyeU09t0nQzTPFHvTZqvwJ63Uy
 fowED3BUMm/ngAXHuQgLYtHA/h6C1yg20gTOzT/94CJx8qWU76c/niDEM/XuynwukoIt
 UUF+NPcLmzy/91XJlMcmOK6ybqImcQqS8yZUdPawU6pNMn1IHm3TkrVuYNPAr3xnAxWj
 X11m0I2h4POP/4S/9eHy/nhk13DwRyN/5fL5wzoxErClynQyNS2zJ2xpSRdTeQTBFiYT
 Q4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793201562; x=1793806362;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fo7qSTLZKzpbH4OKb3TSusktP4dZqpXeZxd8/cMPbFA=;
 b=1cORQwaWuyj4DEr4zzfxzFmuFoiKXRmvxlxV6A2vLkOtP5RDA6ufv3IEcWeerVQU9K
 0/ECkFY52YFTXZooroepx9nhGwT5kpjElldtH6jSMOnMJGY0cmI8iLLTRDQ5qMn+4oIc
 7j0JNUfvFjxh6THFJqJ31VXvSY6zgXbgFNHcGjBWCCtENnmN9kEZF6iBTIdH5M+A6+PI
 BakEC44kuqraDh+KKZH/8dMyTpWtISaY7TjdLN3dvAmAHinIVr/qseYE1RWenMwtDTWD
 KqMuoYQ3OPEV/3Y2YrrQSv7tuLtnHjGFGzLsngCUpTVZhedQmekJHnTeXVjmhnMZJqvQ
 XPMw==
X-Gm-Message-State: AFq9FYL3Hn/PSkpt2rtZGulFJI9T1cawZiEAzfQ+38yRN94VfbQuwduW
 FJVQSOBPVGOk6n1+XLRhhDpoTREYIGg/tzwU+RjCBjNnAbpTloHfsOsLLy5zDLbdzpUxQGs/AWM
 xqlmdrhY=
X-Gm-Gg: AYBFou2HBd7lB/HQCT8rjN4xXWgnLLO0RSXPABlE1VjSEAwjbH+G4hNKWS2ikTgQn01
 SuCsZxN5UeRzPOipOtd8vip8h2Ku2tf/jc7t2LVHZJPcUolyXzkjAfggXtm+bgYp5wnARxraM3g
 MNJ5fbCVLT1wqscbHXcIPDg11bjsV8/YSXEkjfAOiBEKZyIvX9hmdTJRKiPH5MA5ecJAueq5tcP
 llu2R2M8IeWpaeaFQB+zPpAv7/1rBoWFC5DKoG5IeTE+/054pHpdGePOymFmABu0k9e4QHavgla
 o/EBup4hNN+LTaEbSKpaCDjVJ1SI/0pOiNbjLRaEtS5kpLvAAtt5obt072Ij+whp56hcmyd2a38
 oaKhaLeX6aaJObg1e87zEpJzyPRjEpfiVWN4TM1kcRg6+XNp58xQSU0TQEuYZzrmQWJwaEvvyGN
 QrujcJfk34x17KZN+FV1ij9HPdsW79+i8NZGLIc1fCp2bgdg3xZVLtXNiyBS5CPiSnUdBkcfW1x
 VzZ3TAxHNMp1NtVmyHecuHzOvpDjeoaukN0fuyL4w8Hka0EwIMQnCQRy7lnvJa06SmRyX/ZgtDh
 S4uEVvEXPiRT20A17kU6iby8c8NDK7aarq5ztyH3S7uCbAzdcSyD9r91hnpRhtnmRibZdiU=
X-Received: by 2002:a17:903:acf:b0:2ea:778e:8652 with SMTP id
 d9443c01a7336-2eb003e1bbcmr25499585ad.14.1793201562202; 
 Wed, 28 Oct 2026 08:32:42 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b774acsm23747705ad.22.2026.10.28.08.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:32:41 -0700 (PDT)
Date: Wed, 28 Oct 2026 08:32:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v13 00/17] Wangxun fixes and new features
Message-ID: <20261028083238.74382667@phoenix.local>
In-Reply-To: <7BA93C5EF438D3BF+20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <7BA93C5EF438D3BF+20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 18:33:49 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs (CR/KR training, hot-plug, 10G link state).
> 
> ---
> v13:
>  - P16: gate the module poll on dev_start as well, so a module inserted
>         while the port is administratively down is identified but not
>         configured;
>         run the link setup on link-up for both Amber-Lite MACs, which
>         the 25G path did not do before.
> ---

Looks good, applied to next-net
