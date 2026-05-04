Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4568CD3427
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 17:03:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CC7940656;
	Mon,  4 May 2026 19:03:36 +0200 (CEST)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43]) by mails.dpdk.org (Postfix) with ESMTP id 7B10C402B2
 for <dev@dpdk.org>; Mon,  4 May 2026 19:03:34 +0200 (CEST)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-42fbf95cca8so3018309fac.0
 for <dev@dpdk.org>; Mon, 04 May 2026 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777914214;
 x=1778519014; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IXXMSbgDJrJhDC/+zNLhEMw3tPFHK6RS9Z3/3SUino=;
 b=mquuEzVvsLOYnNIXtjZ3SaQvvA9ZnHHhVCZ+mi+6GUNglXHRRm/UfekySJ6n3ompP8
 D8ylih076Kc6TQkMkAUWUImtiT+YDKusIuTjinQnGVU0TO94Glt8tmxbmku4OzWDp/d0
 fTcNtpqC4G4yvmFbFNJ59BbsqkcvSOuT34f5NzlULvPeSwAI8uvtvExipk7lNmyCZNgc
 m6tPhzZIZcB0vzvNW3RnW22LDczbbDQT+8354qI7w13DXH1PYOtRhP+gCOubykAMzK23
 M4ayYVd8UU1nHYLiQSAYiS8I+LnwVEK2T06dhQFchBAdvFJYo2EQr4VdXD3gkkVOPAQM
 oykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777914214; x=1778519014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0IXXMSbgDJrJhDC/+zNLhEMw3tPFHK6RS9Z3/3SUino=;
 b=JjjjlvVd0KgAxn7SWA9znvOWvcUKb7luS4AC27u5N/Y4e9ADUlhStbzV091wgaCHwq
 resBgpe7z5m/JOtoKw6Jm3NQEXYLGOdP1zzdwuico4e0ACeLZlqoouNB+GrCYd5KOEVI
 YRbhVXXh3iTsPfKgQd1SFArtZ0Iyzr86glT4+n/stM0B4z95OTBwyzTKELExeXhTwcdS
 Q4OYpwP4cLKpfy41arNmq2HRWAkpBi8bcka3V2XlaTHb7ePZ2HSuaOpmL/4WfTRhnW2a
 vzKGTeZcWsVmFNB1UHfVeRNYHpTk802l5rpSvwxJOsnLcXDWhiWule07AF0HQUcRF4X6
 +vWw==
X-Gm-Message-State: AOJu0YyhfEBiW8Z82Yehm5QKAuWEH56UEv5a4mK0RvM2T9iGWa4ODq3/
 4k+Bx686jeqDeO4MxsoFxoAVB4fk6cqyiMa48XJ0Du+aj+WzRndRT38axunGJOWW50ixQ/iDPF4
 x4krB
X-Gm-Gg: AeBDieudtHznuV+8OlMr/99HeE1NbSUHCYtQYmzYzoaewQJ0bGryIHSRmHfjpMib95h
 S9DlpdVP1trzgB7y81ox+adcJR8ccv5rJxq5YacgPIoo07/Op8w1EXPRTg842yDVNFNbz1wlz84
 LPlY+ellmKV/FJ/BkSPbm6i6ZcybiLdzv9vswvJ9RqPC59GEj+TIaLKdTRG/H0ah6HeC9rLu9Eq
 EnpajMfJRK4fnvKuPHnT+JmlTEXYKVmBF6XNjjzvdvTLUK/V3Lwa8uwaSeL3gsdZQDP1dqj5DVt
 Tjo/bUicqDgTG29+o3xzVuK/ApHqlBlFe7+GlFUJO75gbEpMWDVvJK+tAaD9Vk/0TRydM0KbobX
 un2ctkYD2+p2am9J8vKYMQe97F3YgrYs1CsunuODjBh12+D4pujnuiypWGqQkp4WxDJpeAgZoGk
 t2+0xLBa2wlSVtI1VoOTVnpHCV8AcI/iH2RQZ5Ly7ZV7G9vADqJo/AXNDC
X-Received: by 2002:a05:693c:3111:b0:2db:2089:460f with SMTP id
 5a478bee46e88-2efb999ac57mr4606671eec.19.1777914163894; 
 Mon, 04 May 2026 10:02:43 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3b29b1a4sm16733396eec.18.2026.05.04.10.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:02:43 -0700 (PDT)
Date: Mon, 4 May 2026 10:02:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] spinlock: remove volatile qualifier
Message-ID: <20260504100239.07d48122@phoenix.local>
In-Reply-To: <20260504083714.2904729-1-thomas@monjalon.net>
References: <20260504083714.2904729-1-thomas@monjalon.net>
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

On Mon,  4 May 2026 10:37:14 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
> index c907d4e45c..19c0e34f0a 100644
> --- a/lib/eal/include/generic/rte_spinlock.h
> +++ b/lib/eal/include/generic/rte_spinlock.h
> @@ -197,8 +197,8 @@ rte_spinlock_trylock_tm(rte_spinlock_t *sl)
>   */
>  typedef struct {
>  	rte_spinlock_t sl; /**< the actual spinlock */
> -	volatile int user; /**< core id using lock, -1 for unused */
> -	volatile int count; /**< count of time this lock has been called */
> +	int user; /**< core id using lock, -1 for unused */
> +	int count; /**< count of time this lock has been called */

It might make sense to use unsigned for count, and sized types.
I.e do you really need 32 bit values?

Only in tree use of recursive spinlock in vdev code.

PS: I wonder if we really need to keep the transactional memory versions of stuff.
I 
