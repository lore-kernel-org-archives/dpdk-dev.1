Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0ACD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:51:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7F2D40665;
	Wed,  3 Jun 2026 17:51:34 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id E23BE40667
 for <dev@dpdk.org>; Wed,  3 Jun 2026 17:51:32 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304545f5206so17497447eec.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780501892;
 x=1781106692; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/UPKiejbo/ja1LlLBSIrrwTgUXHsZvksrpe30ByB/g=;
 b=kVLA8s52W084BXV4JPzgDtJpLf7iQyndS0Ve3/SzImCGHbMakoK4YbbCKHOgRo8Gfi
 SVcTfQZmSd0BNWz2rr6OjA3z+4c1Y6qPFXPdOsJ8/rwDv67lrBTncTCRfBAcKO/oj9Rz
 73hBB1IRgib4GYScHo8lYy1hDaMKHDiHSEixO6ycq29Y2oTfp/p0wWmNlyAYD3Xa+Km7
 ACOpi7ohw+wW2AMyp81Oma05WsK2S6VlbGfPpl6aZhiOH5mckndobGQyy0DmJ8ZyrHtG
 2UFDeyn0rZzrMHiluuYpVZDWo5bcdJFWMqynu5RIr2xB/7F9e1HSXok/2IvWMpcAD2G+
 6T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780501892; x=1781106692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g/UPKiejbo/ja1LlLBSIrrwTgUXHsZvksrpe30ByB/g=;
 b=mVoARusj2x9DdVvhtq+lumvrW+Bx0+ycg1ze9zEopWc/E16B0mFAiiZaIduhQbKE+I
 K8H+5npxIDnaoh+WpwlofjqU4Jz0bi+uWefdMh1gGgBdzrDABTAZ6s0SmhfoMdppvmN1
 6nBdTH1U3pawwtTwjTpyj16UnTQJTLJGxVF7TSjjIBiuyyvOhEBUhweW0uY+HM2KeV4H
 HNlykX7XueJl4c+Uo3GK1CZgYg7ay/mQa5lbYv1RDo7ztlQV+tpu/hwE+HgpJfGKYCba
 JMdanY93e9+WrWT3zYszqbJr0L+wAB+BAZJiF+hKkoAvdm86SF9QdFh5+BOjrlRObQRh
 XvmQ==
X-Gm-Message-State: AOJu0Ywf7B2V5iTBKkF6BEV20T48Qs85tKSq/P5ikXATMHJyLd0UftLt
 SaV4QWLBMOA69tJvvYeo5xQaD9p/TsRRRi8owwxMrtKOFmB44FJradHcSmYgYo9mrXg=
X-Gm-Gg: Acq92OGNQzRo90536v7GO31Fjfqbdu9qWtFq6Ee//S0/5sZCmJs5NJW2DoT4pn9CtFW
 cbI6Yclwlu+9BfvUz2dtLQDdOPTQHn9MmBjncn6ZbAIlzbMHDGS/fNIfQKvAIX9uyZtWFxdFdl3
 hhMFrM8/x3zIwpltafc3lI1Rtn1XaOleyzrtcWse6Lw9BH7ndhai1d9sVZYRwGhDx4AUtuTJvyE
 AWm/9ZVBOyr1FkyTQc6fQkvfE5fOGmxoQoSpE5W028W4FplTp1V3L1NM/9EkSnwVJFJwSf7/8jp
 SVyAhOYpCz4HQPIJKEmcXEhHXFm8odURcc4fnXdAJH/P8vOzqHTDxBzuOk/OOfXWx6PCEUYP4LK
 5iMgTqutLhMlcPIYOdUOXyw0PS8tTb+6sPnNkVZQh5PFk6pmJOqcyGxR1pqDkrBHPq75ImL3hOo
 RSSt2AwiGI8eaEvTkZhtaJjD2Zkw+cVLOozQNFPHLXidvX2+Ev5ZwTbn+vVeW3cExDaJfzkQTON
 PMO6882yADdZA==
X-Received: by 2002:a05:693c:25c4:b0:304:cc9c:35ae with SMTP id
 5a478bee46e88-3074fa3b7abmr1794295eec.4.1780501891862; 
 Wed, 03 Jun 2026 08:51:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm3712407eec.11.2026.06.03.08.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:51:31 -0700 (PDT)
Date: Wed, 3 Jun 2026 08:30:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Sergeev <denserg.edu@gmail.com>
Cc: dev@dpdk.org, shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, stable@dpdk.org, sdl.dpdk@linuxtesting.org
Subject: Re: [PATCH] net/ark: fix unsafe env variable in extension loading
Message-ID: <20260603083056.26d009f1@phoenix.local>
In-Reply-To: <20260603052604.118850-1-denserg.edu@gmail.com>
References: <20260603052604.118850-1-denserg.edu@gmail.com>
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

On Wed,  3 Jun 2026 08:26:00 +0300
Denis Sergeev <denserg.edu@gmail.com> wrote:

> diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
> index 8b25ed948f..e25478103b 100644
> --- a/drivers/net/ark/ark_ethdev.c
> +++ b/drivers/net/ark/ark_ethdev.c
> @@ -211,9 +211,19 @@ static int
>  check_for_ext(struct ark_adapter *ark)
>  {
>  	int found = 0;
> +	const char *dllpath;
> +
> +	/*
> +	 * A basic security check is necessary before trusting
> +	 * ARK_EXT_PATH environment variable.
> +	 */
> +	if (geteuid() != getuid() || getegid() != getgid()) {
> +		ARK_PMD_LOG(DEBUG, "EXT ignoring ARK_EXT_PATH under setuid/setgid\n");
> +		return 0;
> +	}
>  

DPDK may be run in containers. This would break that.

The whole dlopen extension stuff in this driver is rubbish and should not have been allowed in.
It creates testing and security nightmares.
