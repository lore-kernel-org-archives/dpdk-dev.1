Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B404ACEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:57:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 095B9402AF;
	Mon, 17 Nov 2025 18:57:04 +0100 (CET)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1E980402A0
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:57:03 +0100 (CET)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso3264212b3a.0
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763402222;
 x=1764007022; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4te3NFaOQf+HDwmT89LWBHtyJX/HHEHU8IXANAjVz4Y=;
 b=ZHbpdgYI6iS501W3wUZwvSf3R89iu8GmEAks4FIM1VhZd1nBRSK4doQ0dzJXtNr0JV
 wUqTgt/9rGOPeDKL6xWOAM8ZNgm+XCgfgMEIe/dtJcW1WvAMpfXChQE824JIYs23E2lE
 JnYa45JvHkO7qXb55QC49RIdPzz8JNgdWVcgVlQYPYYyZEqjPMbM/W/ihJAT8JOoALVr
 G6kWjbjC8kR2HZi89RhdTJKaNhp5wTXAiIlvwbE3S5ZaiOJdguN7sFZ8Ibq/FsBJNCsb
 AHiKrhjQeoBDGme67bt3ZCglk2vt+Q2Chz6Qli6O7h3Afb0Ng1Kt1tGDzkvIAzNb0xY9
 2kDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402222; x=1764007022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4te3NFaOQf+HDwmT89LWBHtyJX/HHEHU8IXANAjVz4Y=;
 b=AvCNC5ZJR7AjbCllZ4RRzoiF7xxli4rAM54Fb3fc00dTzJxFHJyuxDhq3WhETYBNsz
 VH9/2V0PhT3R9ijfLpMViDretjQpp9FvXKjLSXbRfr7NRzTyn3U/ZcrwlVtSsswlLUsV
 Hn7cJmJLx6KaOqyekeghCHktkn+2vqUxufUU/uAt0EnhxbUWQdwtQqypaj1GYrvU2a2D
 Y7sUZRmUT9/hdy2h67QvKSn/hpmohsqlSNOjH1xj6RnhBMCLPrOhIfUk/XD8H60aVxXu
 hUjsYyHcZW/U6FWYBLyE0XqO7vHgn0Wd7ncsJT14R94MYw73W+rwo7ce+TblNdG9tC9o
 1WXg==
X-Gm-Message-State: AOJu0Yyq/587ar81kl0WYsFKHW9gjKtVz028LXHy8lBZtxwzaChnOvXT
 cxKdXoSPeC07kI74xWwya9g2bTLvsvF1xc2K6v4lYvixqESeB4iXoCuejachM1vx04k=
X-Gm-Gg: ASbGncuwsf6sVoUna2Ip0Qf83vDeE9qJ0A1u756OM2VbC4K713+wejcSIeqyCjd4VTe
 wGunqlmRbISwdRE0cFnFpjQaZ14kiobB2hn2extQQERLHd9XrdrNVX75/FzKrwb7sE2Eydoq4Du
 ZEiw2HcwLv5l41JzKk/IsVZtaAFlXBQtoKwyTX/uEnr1/wmTyZuYM/5gihMgBHhXQGNOH0JmJGC
 HXbCc8W7+dsWxwZGonesH8WgyVLm/clZF0nCKziDVycYIsU3pKahYrcod+FfXnnI6NUOpKe1sOj
 BVkTqMrAtq1R4+4BpkGMM4eNn91VgqlybFldhBsaf1kAD95qNddwwREjaaNyz/8BWO+/EzESert
 34T+NOrCHEvniFWKhfRK/uQskhzU6/2OwmHGl/mTmpyinfT/NHkwRl07lkM5Sn6a5iT2fF1FSud
 yFlzYYIdiyossA5Lszz1LwGYcC99JnyC32loj6Ol1BAzw8MgXVl8Dy0h0=
X-Google-Smtp-Source: AGHT+IFfUjXJ2AIofzaQYgzDjwmsPTr11ACkayCiAhrekbb3Nj0l/rDFvqVqED+u8StqOjdKM4Ic5A==
X-Received: by 2002:a05:7022:ea46:10b0:11b:f056:a19b with SMTP id
 a92af1059eb24-11bf056a4afmr3126922c88.18.1763402221709; 
 Mon, 17 Nov 2025 09:57:01 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49db102f5sm38846781eec.4.2025.11.17.09.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 09:57:01 -0800 (PST)
Date: Mon, 17 Nov 2025 09:56:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yang Ming <mosesyyoung@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 2/2] net/mlx5: improve debug dump file path handling
Message-ID: <20251117095658.5e1a9580@phoenix>
In-Reply-To: <20250829144954.2576-2-mosesyyoung@gmail.com>
References: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250829144954.2576-1-mosesyyoung@gmail.com>
 <20250829144954.2576-2-mosesyyoung@gmail.com>
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

On Fri, 29 Aug 2025 22:49:53 +0800
Yang Ming <mosesyyoung@gmail.com> wrote:

> The current implementation always tries to open debug dump files
> under /var/log, which may not be writable in containerized or
> restricted environments (e.g. when the filesystem is mounted as
> read-only).
> 
> This patch introduces an OS-specific helper function
> mlx5_os_debug_dump_file_open() to unify the logic:
> 
> * On Linux:
>   1. Try /var/log if it is writable (kept for backward
>      compatibility).
>   2. Fallback to the DPDK runtime directory.
>   3. Finally, use the current working directory.
> 
> * On Windows:
>   1. Use the DPDK runtime directory.
>   2. Fallback to the current working directory.
> 
> This preserves the previous directory preference while ensuring
> debug dumps can still be written in restricted environments such
> as containers. The structure of the open logic is kept unchanged
> so that test cases and expected logs remain valid.
> 
> Signed-off-by: Yang Ming <mosesyyoung@gmail.com>

Mlx5 should follow current file system hierarchy standards.
Look at systemd documentation for information.
For example: /tmp should not be used for unix domain sockets
in a system service.
