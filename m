Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0DFFF8860
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 15:23:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0314040649;
	Mon, 27 Apr 2026 17:23:56 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id EA728402BC
 for <dev@dpdk.org>; Mon, 27 Apr 2026 17:23:54 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2d832f2f44cso8687508eec.0
 for <dev@dpdk.org>; Mon, 27 Apr 2026 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777303434;
 x=1777908234; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/ZbO/G1P61FL4zPS9fj7K2yW23k0OddMljqEHn5JjY=;
 b=VIDUOeVU9XKBZ+b8lLlYATJEmfGVFuIL41YgBL3n8zOeRVik4vhogB8uD1Bg3JTt8n
 7a/CKXuVuGut3nIo8vkOR+BiZjiCSwcw8OrojWmnBSs9WcX2pfAa6E3T0Tbzp2IfmhfV
 JXYMl+BoyFyqn/e9tf709ox9/LFzPtDyqBrIomUR1XFS35THLbL1CmMTLggojk/+ogLB
 UkK37aEYHK+ZzdDlWznEstQt1tyB/gxUljk6RHZ8tTBz+DIPVWn0XmEjPegdSF31UMt+
 zzaHPZUAwaE3HQH3zPd0nWi7OQ3lCwan4OQApLyLXciI+iEO7dLWCzh1tHaqoJUHm3LT
 VKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777303434; x=1777908234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L/ZbO/G1P61FL4zPS9fj7K2yW23k0OddMljqEHn5JjY=;
 b=TjRnWoYXTWeJW5VGM9Bfxx9r8Tgy/WGzaYAItUk4DJJhvSPj5oI/ZZ7+zO+gJaPF1z
 RnlBUjsyIHClFpEgAfwF9SAA7GmQbYGWET8L3K2WHn/Y19JKj5v4Qvv49UxwEg3gAFzE
 UB54yQhFAJrjyNc/jLftq/xT3tKR4OQYEN3swO13TD+GMXM1cYzg5HTY/rszE5ol88HE
 ApLC4pepgYVCDlcY6+NZYSZHBioLh7u7kLVItjbgLb42Bf3N+Ge+oiMz/CMp1Z/DiSDk
 NiUtE/NfWiEGoNOzUxH93Md8BtzjzFa3khnYG6BNPZpX0lUeSRwZHUJBbpbBjJ19pztZ
 cYeA==
X-Gm-Message-State: AOJu0YzJOq8/lxpaourUQ/Z90fFSEO3nR9NU1ljWmI1Adv7jHpaxPR7G
 eea/Uwkf+0DcfzpjGiM1zQI5c5DC2n/KNGY9HSbyLMifdYJHQxMcA+5CJPilHnJlQSw=
X-Gm-Gg: AeBDietocQS2dLMzqE3LYRSiX6QAKp//AnHFRGwPe56eSidGGFCjNqgqodd8R0DhWrY
 oyjHXhsSY2RoblRk96hpwTC9N7MEhf8WRNghMBGBmXNQMuH5SbAShpZRProUbm7d3u4WsOQ2g92
 CRjbLEv21xc/q0/UXCwcMUJssm+BOSNzkXiabykmmusD2Km3pYMWsH0/gQGh65640MYIjn2oo/K
 iJDB911dWFRsbyD5SoTD+ZMXqiIP5XYLN/jtvVuJJ3pXUo0AzdbmKZIPdTfo64UkS002CTN4zWs
 i7hu7gnNrW7KkqExwGe37Ejz8mSNScg4fXLZOtwGMdILg65z4+mMpxFH/0fAcPZBY2bKckEru++
 ppoZFpvjEh7W788wMsSnuelbpoAvnXr4u3WDyoSjl+5CAA90LJz5JBqpqrouFq0aOnL/fklu6L6
 6H9Bxa5jvh6n43vypHIILzl1aFRcrg7ccRJMJeKxZh9TgGTg==
X-Received: by 2002:a05:7300:2392:b0:2e2:4979:ec7 with SMTP id
 5a478bee46e88-2e46538fb23mr22879897eec.10.1777303433789; 
 Mon, 27 Apr 2026 08:23:53 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53ccce440sm42310598eec.14.2026.04.27.08.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:23:53 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:23:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: dev@dpdk.org, aman.deep.singh@intel.com, bruce.richardson@intel.com,
 stable@dpdk.org
Subject: Re: [PATCH v3] app/testpmd: avoid cmdline use-after-free on SIGINT
Message-ID: <20260427082350.0600e2b0@phoenix.local>
In-Reply-To: <20260427111347.40520-1-sunyang.wu@jaguarmicro.com>
References: <20260427105741.14348-1-sunyang.wu@jaguarmicro.com>
 <20260427111347.40520-1-sunyang.wu@jaguarmicro.com>
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

On Mon, 27 Apr 2026 19:13:47 +0800
Sunyang Wu <sunyang.wu@jaguarmicro.com> wrote:

> When testpmd runs in interactive mode, SIGINT is handled by setting
> the quit flag and calling prompt_exit() so the cmdline input path can
> be interrupted.
> 
> However, prompt() frees the cmdline object with cmdline_stdin_exit()
> after cmdline_interact() returns, while the global testpmd_cl pointer
> may still be observed by a later signal during shutdown. If SIGINT
> arrives after the cmdline object is freed, prompt_exit() may call
> cmdline_quit() on stale state and trigger a use-after-free.
> 
> Keep the existing prompt_exit() behavior so interactive input can
> still be cancelled, but move the cmdline object lifetime under a
> local pointer and use atomic load/store for testpmd_cl so the signal
> path cannot observe freed state.
> 
> This preserves the interactive-mode fix introduced for Windows while
> avoiding a shutdown-time use-after-free.
> 
> Fixes: f1d0993e034e ("app/testpmd: fix interactive mode on Windows")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> ---

You don't need stdatomic here, it is over kill.
The signal and command line will run on thread.

It would be better to disarm the signal and make it a one shot
situation.
