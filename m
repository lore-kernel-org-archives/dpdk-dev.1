Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0935CE9A058
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 18:04:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B4A0402D5;
	Thu, 19 Feb 2026 19:04:56 +0100 (CET)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by mails.dpdk.org (Postfix) with ESMTP id 22C47402CA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 19:04:55 +0100 (CET)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-45ee8823e2aso644290b6e.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771524294;
 x=1772129094; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EsAjMySlt1V9c8bGdjj955xr4zQMfiz/vIbH4pmTQGM=;
 b=Ka+jlCfqlqTIBsDqM7i8gjsWvgB6DaTo/hJ9HtqBZihIvTWgoMAKcMOWpqgXEbS7ET
 w98N74TnkAxGSlUwRU0FK9hFsmtwkjGoWuDaGLb0aRDc+gdu8XEXEncZwWN0VZF4f3hZ
 pc3tlvcHAhk/CtCHao2COh/wWlLFQgDhXFw7SPhgjsoZMos0NpjRhJVeX+swZ8+Bos9M
 KNkxwTRRvcWwSxApoSrk8aVjSpyl8ZrRNW1YsEqZQCdyWTcGqOnB/jFKu0AyL7vmI6WD
 qMY57ieoNUJz8IZCqPfWUTmNvW+ckZifSkPBvUlwkF2ZQiZ4ecuRxcP+ZY4BmAhow14r
 JXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771524294; x=1772129094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EsAjMySlt1V9c8bGdjj955xr4zQMfiz/vIbH4pmTQGM=;
 b=qx/ypW/W68gTRJALSmIa44kI6RtwqyONjsOlKpdXtko9m8/+ss65nP4DfDOx9S5vhq
 A49NXYxwJiq8a+BwPIvNSeSsucwAMJB28v0XRgBmCgwO9nW0E5e2ejzr93bCEmech/Jn
 owwBa6E44Gdyu2ybhGwS4ZdX9c9HjerkIANjbjd+sAaIcMDWAoYw4cG6m9QelKKx1wBy
 M9P5ertgbUojpGY0PoF3VQnqPsGxZPNbC/sOnqfTiFKqxzgBzAesIQk1H/hYL6jqzgfB
 rqjsFs1rpz9kGPgPPvdWXmbZDuGv7WXYMbKu7bNSvp3kDAGZiVoN4GVluCznH0z0Ytbs
 /BPw==
X-Gm-Message-State: AOJu0YwI+lzTduKINueHvMEMPv5aXpQm3IuoE07zTkU/OxsLU+RcwdZ+
 8yBMS7qNQljGNY90EkXa0SYdoxN5aAZhP/fLjah528Er4Ry/ytrpdJ2KL308j17N53M=
X-Gm-Gg: AZuq6aKyULAH7lrgl5cFl67SKAwRpnto9jFfFzC/VLJ9bUkjlrHYqYUIcbqw9/qYFqt
 AvkDK23oSnD82//GI0ZW+AJ47nUC6Bb9WH2dWc0e6neYODLoCFWiFl/a1SHw0poAM56fTMmo+lW
 fMiTgirvCygZBN9mJlZwJm/WFLbtsBYXTblfmNh8NRWiDzIk73KL1Kp+pM4mtLYp9KHl/y220KJ
 kYBoQ3HHql29/U6qt47QCVfzMHMHszFTMtki0h35nKXOyhvI2O8f0Wrvn3Turet4dPLgorI/1aT
 iwJrie43cgmXrXqOEOd/ugAhR/9Hkv7RgSxLikW4JqjxYzFFOHPxcQ9wRzgvVobykSi4Lm0QRlM
 vvUGm8IcpykDxKMzIoVnFfCxEUXvMRpCRPaJsBcSJHts4JWUQTiyH3e5905Q7aBO4axf1EIMWKG
 53ol360MGfJteLLOOm2pnyNe6cQMtnqWLL/RI4cV0gs35D+OxJbqJ+pvSZuBKqfEIJ
X-Received: by 2002:a05:6808:6604:b0:44f:e61d:1893 with SMTP id
 5614622812f47-4639aea7241mr11982000b6e.63.1771524294231; 
 Thu, 19 Feb 2026 10:04:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636b098dd9sm17275598b6e.15.2026.02.19.10.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 10:04:54 -0800 (PST)
Date: Thu, 19 Feb 2026 10:04:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 1/6] doc: add AGENTS.md for AI code review tools
Message-ID: <20260219100451.297be004@phoenix.local>
In-Reply-To: <f7t7bsanlme.fsf@redhat.com>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260213214107.234072-1-stephen@networkplumber.org>
 <20260213214107.234072-2-stephen@networkplumber.org>
 <f7t7bsanlme.fsf@redhat.com>
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

On Wed, 18 Feb 2026 09:59:21 -0500
Aaron Conole <aconole@redhat.com> wrote:

> Much of the following sections can be written as part of checkpatch,
> which means we don't need to spend compute resources with the AI on it.
> For example, telling the AI that source files need to begin with SPDX
> identifiers, line lenghts, tag format order, tag parsing, etc.  The
> downside is that if we ask the AI to *generate* code, then it won't
> follow these rules; but when we ask AI to *review* the code, it takes
> fewer tokens to submit and we can let the AI do the thing it really
> shines at - recognizing subtle patterns, rather than stuff we can write
> a python script to do.

Also, the script now has many checkpatch ish things that are not
in current script (and would bloat it). Examples are:
   * using const on function pointer tables
   * using rte_stdatomic
   * not using rte_smp_mb
   * using bool for flag values

