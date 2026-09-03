Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C178C624D7
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 20:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C93D142830;
	Thu,  3 Sep 2026 22:55:34 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id F3C594066C
 for <dev@dpdk.org>; Thu,  3 Sep 2026 22:55:32 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso394896a12.0
 for <dev@dpdk.org>; Thu, 03 Sep 2026 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788468932;
 x=1789073732; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NTGv8ZZR+k/rxwUknSoseQlzOA2oCMB9T+1BH6v0N9E=;
 b=k8en9PbrA1y9Cjc+u0/zcvZWbF1heTgC+njCFE+P2aD21S4Uy6xP9+ZT0KhQiLgg3j
 1arHTpzxasbvo+uEiz7YP3S1NeZcuuRrWv0enAKHVEP4mmF+tVu1lBSF6/KCjJzypMjA
 IDhpVZhqZDJk77F8yajEnu23HbxpMZ9sxQLqpG+dwj1DFHZbYchN95foDyf+B4Ee9aBQ
 AqYejZPE6Jbbqrp7uuYeRgJsGJfnqvSKp8tSgUsY84NBY0yvpxjOPBi/jIkIl8DRvvC/
 /FLWRQRrnyotWhDW2UHZszdYkIhXGZeDgAuG5u9IIDFsbn9PWimEuLlSCo9tdfTjpttO
 onbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788468932; x=1789073732;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NTGv8ZZR+k/rxwUknSoseQlzOA2oCMB9T+1BH6v0N9E=;
 b=oIVhbMEcxpbO5X6gH4LcXlxmLa3/NBI+K2JB0qxx5w3BA2sKjBeKqoaiB40puxFLFS
 gwO88ifpOU0YpHPz99nmJJQQ2ckD9gCCfrKzaeU7z8Y8wbGANfEG4/wDdj4XyQOqSWNi
 c/OvXSTJD7j6R3Tkt5TkZVWU00P3tFmeXB6yaOfCZl/m6IYk7Udt088dLuT014v84+gd
 h01rtBQXzZ2L/vlSdCVB+XbfOID9f/i+IpdVId4MY0LunHcmOPrujLqbng4HHRhp9U6J
 DL86jjFL5Bb93AThCzM2yaCAzyRmMpasiugKUMSbnBhkPpuTItADsl0lcZTSacPVGfSZ
 esUg==
X-Gm-Message-State: AFuF++kj0J3ZsNehb8u2x49b4Ij8qJCU94L2lpKMGT6A51SjnpJMG2E8
 oppM3a59H+dk5GiNj73MTCJi3TEDAKVw5iNyazGv9zLQwORqZZLfufZgwXoKXTXZVqc=
X-Gm-Gg: AYBFou0JPF0XZ2PJSfjSJjR0B2Y0eC5Rw3fgWsk0blgQFPljlznYDvpg31jeDQcp/pz
 zriNlbzg+UeCaGBdzj1HVFQZpYumGJ7oC1rPsoIItnKXVVVPKj1fizFOWEAdLT41Ugr+vrF9YhX
 8/i+26FBT2exOpDc1wWj51e+DvQ4wQNHy7rB6pA2tkX0DEWRYgDVFGf6eKepXl18y96saf6ul+7
 cn346LAbGQI23JUuKDh9PfUcnO36PKcqoU0vxEo719z5DIyoxoXCZ2Qljrs11F9kUrZ60M1QIWe
 7palcYMWdIA6wzOybWu7RrYNiEFNAbEMVo5H6kutXNuMNozuudCjJjnkx0iGev4NL5TdqfXzi4N
 GLiOiw9EznUuTOAwCHbaDVY2eD6vZaQKiFVMcMu4ZP5YL0JvsIeN0Gk5gzzvndf400A/TmPS+Ou
 CCywT81538yVoqA4RUfZKS/EHmwTfx/WC+37Jh9B2TmfHK5dXbwc91ps9GPE4wLXifQcfpUIuyi
 kF3sOxQw3hdmoQQ8NvbSivLOJ5FKQ==
X-Received: by 2002:a17:90b:394a:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-39b2613150amr1929421a91.6.1788468931910; 
 Thu, 03 Sep 2026 13:55:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae902354asm3210408a91.2.2026.09.03.13.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 13:55:31 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:55:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org, Jerin Jacob <jerinj@marvell.com>, Kiran
 Kumar K <kirankumark@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH] doc: fix API comments for Doxygen 1.18.0
Message-ID: <20260903135521.637818de@phoenix.local>
In-Reply-To: <20260903123817.1677020-1-thomas@monjalon.net>
References: <20260903123817.1677020-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu,  3 Sep 2026 14:38:17 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> After upgrading to Doxygen 1.18.0, there are 2 kinds of errors:
> 
> - @ref func() for static function is broken because of parens
> - @ref struct.member with anonymous struct/union is broken
> 
> Parentheses are removed from inline function references.
> The second issue is more difficult and requires to degrade the doc
> by providing a global link to the struct page for the fields.
> 
> The root causes of these issues can be found in these links:
> 	https://github.com/doxygen/doxygen/commit/e1bff01
> 	https://github.com/doxygen/doxygen/issues/12226
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
