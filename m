Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2938C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 17:25:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 485D340267;
	Thu,  3 Jul 2025 19:25:44 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 6FE8040264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 19:25:43 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-23636167b30so2153935ad.1
 for <dev@dpdk.org>; Thu, 03 Jul 2025 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751563542;
 x=1752168342; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=gYl1iSEpg9BlYp2fZnOx4xgwBQTPAXWaxZu5wwBeDM8=;
 b=mPDpbOeqWiudwRX0lIQTooEZPdyjrludBDPMRPj/jgAEaN0OIQaVC+P3jsPBm2FNts
 Bb+kdA5EdYGhfadWrtg4NMYPqyUuoFzn3eVoCcaIxUyQxBSsgPU3tihQaqtK+VOaLtuv
 HZs7R3C7ZtreYW1hKmf3nAM9P22D6hwC7mLhB+K9+rPfGiE49/vVVwquVRG+kWJocLdN
 XqLbH1+e/acbY9qIss7Au/ujK/aOY8tKh2c+VpcacNTiyQGCai7TpNcWmpCwwSpLzo0C
 xrQFl+uVJb5KJZJd0Veb25XLzXlefDvWkQa/m1oNXicOZPh9ELBz1s//5qFra35a4VZ1
 y83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563542; x=1752168342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYl1iSEpg9BlYp2fZnOx4xgwBQTPAXWaxZu5wwBeDM8=;
 b=vTZYOyxxR7HJgoDAhQJ1cdolLAvOSkdlHTduJrAiBY20PJCOK2JmvWCJGzxVn7vFrj
 jgY0hTDumflIXAa9dtJhG0BlKXcZSb1UlYDlsn3g/2jvin/0mxSK1hKQOc57BWNYu6sC
 0txUJxf8chhUZeskO93mXtWzHNvpQwsbwP5gZVBBwha5YvcIEZe3gg6d9Y1c1NtStE0N
 ZtuQHAUEvKcDBfH5s20G3OQFXb3MDyCxCnA0AvzUYLVCUh4oXRgsJr9NUZ70UkqzGQRg
 s/Rw8sD2w0Vqbknfg/81bhpA1x+Ht/yHla1c4jWhQTLgTmALlSJkrvzOVigf/W8ogRSY
 9RJA==
X-Gm-Message-State: AOJu0YypyXby8E5T82uj/XrkLsQid9u6wT/8oWVQ0iAZ4YcaObgl8Pby
 y33Wmm7PmXkSLHgHok+dO7HEzczew7b6S8kErjpHk1D5896vwdwUOnP9kxrflb00WYEYOkmMXWc
 PgZ/F
X-Gm-Gg: ASbGncvkogCMo0tJriAW9wE1ojn3SXq3W+16Ve3AORbU5SVgw2gsAfP7vvDgPYapva1
 ssjWJ/CkpVHNQoMihZd8Li1WZJjYGJok28anJ/MI0zHnpGQIzo1NABtpl4yNRyXDYlWwVwvWzwJ
 jMboJZwLX+oknMFqvGpb/2x2WYdyM4voqBPnYcNIjG8b5hcgcKw7y0EQD4/pZXIeepKnInjnvtI
 o6fgRgLhzhIQThk/qHbM+mnJHniIIz2Afl/+x9SHuEK+5pW+f8WQ1mxgdbs1xGpjzDherQLEv7z
 uXh+9c0kkbhKEeKUWt63Ru4Ow4BgjnMsScRZOzLC56113l3gzyKYYwB8LDcEDmGdQZy8dGGkRfd
 W1/MM7+PfxDDZkkVOMVZlTNBIKIe3XlGkg1CkieA=
X-Google-Smtp-Source: AGHT+IGJ3Cma49ZtWAtTW/J1np8CNWsJb8HvvrRrf3mCRvyDsEgLRe5rB6YcTLB+cjPeVDRLv6JRTA==
X-Received: by 2002:a17:902:d552:b0:22f:b6d6:2737 with SMTP id
 d9443c01a7336-23c7964509bmr62125895ad.10.1751563542554; 
 Thu, 03 Jul 2025 10:25:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8434ea21sm947905ad.56.2025.07.03.10.25.42
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 10:25:42 -0700 (PDT)
Date: Thu, 3 Jul 2025 10:25:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH] ethdev: fix shadow variable definition
Message-ID: <20250703102540.196cea8f@hermes.local>
In-Reply-To: <20250703172407.116249-1-stephen@networkplumber.org>
References: <20250703172407.116249-1-stephen@networkplumber.org>
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

On Thu,  3 Jul 2025 10:24:07 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> diff --git a/config/meson.build b/config/meson.build
> index f31fef216c..3fc58c53b8 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -322,6 +322,7 @@ global_cflags = [
>          '-Wnested-externs',
>          '-Wold-style-definition',
>          '-Wpointer-arith',
> +        '-Wshadow',
>          '-Wsign-compare',
>          '-Wstrict-prototypes',
>          '-Wundef',

OOPS didn't mean for that bit, it triggers lots of warnings.
See other bugs
