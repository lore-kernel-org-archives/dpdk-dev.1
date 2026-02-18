Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44318E9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 17:07:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3207140269;
	Wed, 18 Feb 2026 18:07:14 +0100 (CET)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 4177E4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 18:07:13 +0100 (CET)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-506aa68065eso48271181cf.1
 for <dev@dpdk.org>; Wed, 18 Feb 2026 09:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771434432;
 x=1772039232; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oql+FLOz0FhNRXwDOvq5K1bTNWPh0bJ1/xLWBaPvES0=;
 b=sFRSo+yQCuSL0aFYPfkbfYcK/3mp7oFPg9wCqlwq0tF5hc+6jvIJCy6YrNZ1D+Bp1S
 WCLQfTsB3HQ69JWsIp5rtRcN7iw5T1ioSiSg5PBw7uwfGsoUr3i6/nfyO9d7NyA95V+9
 wfpC22UvgfxCFrmaAD9qdqyZodN2nGsxpxvRUAuO9W72G8Si7PhxpHG8fVXd4SholkIT
 ReJh06OWg3ng0R1Xs1cACYww2wsDMuvkrAfHNz5fruItelTP5NE/xpF0nWDrSlG4TPA0
 xgPr9+MBOMUmwRi9pjk7264GCqYNrvXobnO1bMSjWlSdn9GlLbMu6RDA8u7+Z5d5W7G/
 ssUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771434432; x=1772039232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oql+FLOz0FhNRXwDOvq5K1bTNWPh0bJ1/xLWBaPvES0=;
 b=MmaFaC4r0NMn5q9t1K7mQYcSpOg+554slSfNes2b7SJd1tdNcuV+1w5cpTnqGoj42y
 V/LrMx7NELBwUbhyL2/Cc+QbPbG1v0pHHh7bdRxzCE437ZTcz3mMkTZ2in+eSrtZbd4v
 np0Uh5eB/hxdr7tdN5+1p6DuRhe0QOLf14XPnJhd7IMphgqWoDppSxNZntdovavNugDf
 8J+jL5mZfrAYgJPsesgai8WCfhBZIOHk0V8PMt3S2jUfDLAsQ6WNh0JRaky2DGRBN7h9
 t74vZFku7DIEeRtPzysW2vhgm51knt8VCPQCjBJmxPx1+tZ11wDeTU0PlCLKEYt4LDMc
 1tew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEa4WBu6i9hO+rS2zy6hgnORTuJYVaGH1KRAWz1Y7jinT8svBye8TxCNNDVQtku1SYbZ0=@dpdk.org
X-Gm-Message-State: AOJu0Yyg/lzUY3wusM19qFQrqItAX7H1jt17NOoImZ5qPqc7UMwWHYjE
 mOVY9UTIJLnkfuFRFkqbpRiQkPI1eOn6xu3wFZ0FKU7eSR0WYspw0Lq90g0eDyf63A0CofsF9eA
 E/dB5
X-Gm-Gg: AZuq6aJMfW4XDeubW9d/GaYgxMfOaccC6eOxT+HYG+NFynHUe01dVphYjRNCOsgE/Tw
 v9GjgI8pbDX9lgjEID9yTzzZ6sI9GmFd/9tHUqWZtJOC78o5yVruFne5JdGCrwNcN9O7OMCrbCd
 mgFVR1wmEgRlbbmoZ+ArDgBOd8/lm7A8AS3Y9TF26/ULyQLlAMOJvKQpVV3EeDH6jjtWTJvW4Oo
 g+4Z1nl4qEuLxRRckVZMiLiRFDciqLjxQgOirqE68j92ZfMAJVZ1O/4zy/71SMWTuZNyRaevX/S
 yYmwwnH8GfZEnfVUGmbomvWaH7I8vsxmd+Z5c6fSh7EAyDR0uATzzlLWbYiaMCdnsCghvxqHgn0
 +FoWCSzGgvorodjdyixmxQwEklP8WP1VvEY2Mc0FmY6GHgP2SiGpfNfx24B0n3Hp+eakwGREBnC
 cb5uVuuynFKAdmnpLJQrDlg0d/f4OVT3VoeXHsm0EXCT3yuTYK8aUo0fqOzkHTm7/W
X-Received: by 2002:a05:622a:3cc:b0:4ed:680e:29d2 with SMTP id
 d75a77b69052e-506e921684fmr28165841cf.44.1771434432230; 
 Wed, 18 Feb 2026 09:07:12 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-506a9bfab83sm129534731cf.10.2026.02.18.09.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 09:07:11 -0800 (PST)
Date: Wed, 18 Feb 2026 09:07:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: hemant.agrawal@nxp.com, dev@dpdk.org
Subject: Re: [PATCH 00/11] net/dpaa2: fixes and improvements
Message-ID: <20260218090708.2168dd07@phoenix.local>
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

On Wed, 18 Feb 2026 17:04:42 +0100
Maxime Leroy <maxime@leroys.fr> wrote:

> Various fixes and improvements for the dpaa2 net driver and fslmc bus.
> 
> Patches 1-2, 4-5 fix resource leaks on port close and in error paths.
> 
> Patch 3 fixes a misleading Rx descriptor limit warning.
> 
> Patches 6-7 replace getenv-based configuration with proper devargs
> for taildrop and data stashing options. There are still 8 remaining getenv
> calls in the driver that should be converted to devargs.
> Note: the taildrop disable path has never been reachable until now
> and is untested. NXP maintainers should validate this feature.
> 
> Patch 8 fixes link status not updating after port stop/start when
> link state change interrupts are enabled.
> Patch 9 is a minor cleanup in the same area.
> 
> Patches 10-11 fix devargs propagation on DPNI hotplug.

Looks good, shouldn't the patches with Fixes: tag be marked
as Cc: stable@dpdk.org for backport?
