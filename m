Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A8D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 18:38:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0839F4021F;
	Mon,  1 Dec 2025 19:38:05 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id D4A624013F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 19:38:02 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso41101665e9.3
 for <dev@dpdk.org>; Mon, 01 Dec 2025 10:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764614282;
 x=1765219082; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUBiik9LiQzESNW/1S4nxD9P0ZeHFSeF/gGDcoUi2nE=;
 b=jtTyGa4TgvZuDNBc0KpUShGAGrzOWaU5ZEtabjhGRIJ2tAf3XI3nwM+WEJvjOYDxxF
 q2m1rShSnAW5HvWdbxV/OCvaMOprdaCnvu82pnPPjmG7rr8Vgy4DyR9K64R5pVlK/9Cn
 I8VeSsuuvCok3sT7GQFpYBxraWpcvaIrAkrwLwwEDIJ8xslkEpW4oJfKDSwCtiBZF9rj
 wW3vskP4cm1E5Rs7ex6Uhaf3ITWfw8batEX0/hRgNu6cj++9BRzQGRc+6bxQerERuGyZ
 2YNwWJCyhQtqb/ZHpovjwntYeYK530hfuqg56+LBF1/0T/sx5v8TfD4N5KAcZdElJjU2
 O7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764614282; x=1765219082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nUBiik9LiQzESNW/1S4nxD9P0ZeHFSeF/gGDcoUi2nE=;
 b=NaCtyke0RmlXZSwzKfHODFyP8svwzLGQWou+KJC45IY9xdP8Xi+5Kwly51wE0rBPd0
 K0S5GaqLerDoSypdnjjEDZz1j92UmCkgyk+2JtYj9UXlnBK7CsiSSI3Xut+NRoCywqv4
 wC7Cck/WfNkclUNHXbIYL8IdWqy2m3BXIyduRC21JSqEBbssISPUJPoOWX/94pdtKcxX
 f1nc5WvsZ4J8XlzVz9viJBNy7jWUwYvpiuUWsEfeSN5ZV8EYPJpC6l5TANsdWc2gvt5v
 alRHcMCnWgBMPP3+ppmhm33+TpHNIROXaoN77GsUJ5Yg9HWjCAV1rXn+pTAm6EGaOcMG
 sY4A==
X-Gm-Message-State: AOJu0YxvpeZ3B7UHoE3axjLKk14jJTRTrWRfj3Xuqf2yVZOmEkn5mSPv
 r/jb198PK2F2S3KLS+VRuFzjfbPM18N3fZnNHRG+/LLRRR3Ode+ECFBnIl+AHzz78yA=
X-Gm-Gg: ASbGncsYLTghOjORbJ5YMVbBA8nZnUAO4cvwdQ1xrOgzoUCeaEGDvnJZ+jBwqBsnEO4
 gP5nkbtWOZTpjgRTGLKbEkTv6ue6Z5YXT6jTb9rmQKz43X7RT5dl/5gzOiplPMoPx2yI5TGyA+0
 LavXjY7ll8tcoQs9mUtK6lGqRmfV6/h+8pukawrKYVo8CWzCH86kLMkBZJ8fXJBm+EcvoTTi3Do
 tjV4xNtepClfjdewO3g92Qqfm966l8Fuub1XpWvxgygwq0uBCsDqyr5t3CqMnJ04n/fbUGTOEyn
 YJx3RihWyJQPeCr+glMrVs1qpSD5lpKinrxhlIs8ifiuV0pFKjiXTscZldi/RwgQOxBrj1KxslH
 jW0A3bLBu7PeTTIDgg8h7DXl1C9yN/GCeZCRN5nxhCYk+nOSFlL+pxHhe92ucyDQ2xm76iBuOk7
 ZEPtgiZ//+f82+a8ESUk44EFE7rEddcwRq7cdB0lbQOdsToT/82eXp
X-Google-Smtp-Source: AGHT+IHs7OFYQwvUF5uacFkzAq6tuNv3lOG4iYA0qz1nvc6XfLzRImCLifZyKePZy9VGihvHePrZrQ==
X-Received: by 2002:a05:600c:314d:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-477c0175164mr393702935e9.3.1764614282266; 
 Mon, 01 Dec 2025 10:38:02 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0cc1d6sm310113175e9.12.2025.12.01.10.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 10:38:01 -0800 (PST)
Date: Mon, 1 Dec 2025 10:37:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] app/test: remove use of coremasks
Message-ID: <20251201103755.1e99be87@phoenix.local>
In-Reply-To: <20251201181024.1583767-1-bruce.richardson@intel.com>
References: <20251201181024.1583767-1-bruce.richardson@intel.com>
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

On Mon,  1 Dec 2025 18:10:24 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> A number of test cases spawned off secondary processes and used the
> "-c", or coremask, EAL option to do so. This option is deprecated, so
> replace it with "-l" in tests.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
