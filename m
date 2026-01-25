Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1470FD7237B
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 22:24:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E51A40269;
	Sun, 25 Jan 2026 23:24:53 +0100 (CET)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52]) by mails.dpdk.org (Postfix) with ESMTP id C2C1F40262
 for <dev@dpdk.org>; Sun, 25 Jan 2026 23:24:51 +0100 (CET)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-9481cdd7665so1088671241.0
 for <dev@dpdk.org>; Sun, 25 Jan 2026 14:24:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769379891; cv=none;
 d=google.com; s=arc-20240605;
 b=Xao1+G7McwF6/nhKPYMHE2RDaAPs0eCnY33ZjtVkEOUIY8dHHqw0EDy0kb1cNb0Q5h
 0dGzvop4Cm8j1HhVGq2OJhPxjZRhwfMYV2DoFMo3kyI3cV2D8cixibSBHg3eDagoLZSQ
 yrNlA4BJnAWG8V7LlQMnmHZwKcmdRqNrcAI5rSvAQV2pD9NQ38X7xgLr5/fuDmIU/8/Y
 y7KrWR8IfT7gzfu4xxICs87VVcMu4RlS0rPbmx9488B6Dzfo4jLtREhpdkD911kW3s1L
 pirikDQrYApbui7h9DkBy/BAgT76oRiCuXbpiTE+cC/vkqJyi94BkXb2dPMhqFamPPeg
 RM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Nb3NFH41Z6orSMdPGjRRQhAS14caYT6qJPfmKMfhego=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=h1R8FD/F0EDNKa3Ao1FaySlAEAICxMtk3pSl0ryLbJIm32Kc0fe+2mLABdOGaWYGkM
 lW3PdshSHCZTHqRuOMQ2rHFUvj3Q63Ehnd6SanMHIcHY0ifEL5ZAMy+ZW0rEdjvyHc1Y
 tWhSGDj16XlhnrGmKbFOZpTeDCLQKpkk4aq/+pSWHWgiGkwGla88peMYixGT33bM+3Ul
 yNX2+4muaOxUVJXW0SX7q6Ze/St00w1loRD31J9m6q3C31qKNuImVPyzWCWtx/DmY6lw
 6Wg3/+E3BD+2DWU1n5NSZU8RDH9ct3t67i6Naqi8feFpjNQRnFHbSem/2XFL47JvRdk1
 HO6w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769379891; x=1769984691; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nb3NFH41Z6orSMdPGjRRQhAS14caYT6qJPfmKMfhego=;
 b=Eze3yJn5KF/EMzzH4TZoFxO5msIwxKsiBwUO0F2heEDr92T8DkgNyXWsrHdbt8crWN
 InnwzpVJYSBk18+eJGFUjXXvMIzMezHJAluXNU6gukg4MfNHKLjZPU+HuUrcealqE3tc
 bC9dz4qbVH+jA7CklYZoyzaykgcpPxTEDrKN1YdiYsxblKrO1RSnaikwQgfH3Paquubr
 DLu00Z9r5nEalWq2DsYWl/7iLmYVV/6Y2XHNenE7UBv8+6VZxfUziajyyh/GpdY2KLTV
 L1QEJf0svDhnajCJl7u0wFTiZUMb2oSh6nPV6/9mqTgGaWszez1ehdNy6mDKYwN6L2s9
 Fd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769379891; x=1769984691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nb3NFH41Z6orSMdPGjRRQhAS14caYT6qJPfmKMfhego=;
 b=WEoOC9EP/9j7mKHdM3BI9oVfPXad6yedOi80m+nqucyNZ94/h/uFDKfgNys5DONtX2
 nbC6NJ+sPgpsHhgUNUhhgVWiQzjTXNMmZnWyjHkt0iMn9LV6ZWOOF091vvOMTMJr28gs
 Bo3SYbKwxHnTfMThAOdRXT3yxYqRQDIylueaL+o821v1u4GUHIsRfVNXhbaNOYRRTuMM
 qURw4JIlqpHVM4EWtztyImgllHXgPNiCrGga2IVJHIE+ypb3T2n00Laj/SUdyRNb2lSa
 VGsf4ZZ31g2piFp6JA94vbOT1uBrPjOv+K9B75b31Fmxupgru0GnNKQY52Ro54cozLzI
 Sc8w==
X-Gm-Message-State: AOJu0Yxiv+1RPdMecAG/f2QIZwDMuF2HxvP4G7/pQJGnWcTPX5ZqbjIO
 vNWxtV9i07vWjlpjzwKrrXZcBL7gF2oNMq+2LHhyVk4mRbtgDXzX+Fo3EKtB8ybLo2h4L4i+rYa
 CGxdyVr1nhg4rVaA0H87WpQ75gGZOLjZ1IQ==
X-Gm-Gg: AZuq6aKfW4asECCtDx62oAoXK0mlgeopYpJA8H92vYaqOcDkDV6rDvhM6+HThEyWdi0
 77FMOHak6wdJ1qr5jcdmTqFpA+KCZ9qflu3ulKxLZHNmtonvYmGpcCM4saezU+VwKVz28s4vNDy
 5dxGonJq/1BgrAIyFm9FEEoAZtiWiuk+Yb1AZihjkjn3n+Fsk+2CLMLCtfgk0a2G7msM0v5UAiE
 19fFbVdofXMh3uOlC0J5xlvow9SIMEt9lSdSHVmXNarzvKtNYASXVXjqxBoE4aLnVpGg3E=
X-Received: by 2002:a05:6102:6494:20b0:5f5:8888:e9fb with SMTP id
 ada2fe7eead31-5f58888ea30mr96326137.25.1769379890876; Sun, 25 Jan 2026
 14:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20260125111211.34800-1-scott.k.mitch1@gmail.com>
 <20260125193618.499170-1-stephen@networkplumber.org>
In-Reply-To: <20260125193618.499170-1-stephen@networkplumber.org>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sun, 25 Jan 2026 14:24:40 -0800
X-Gm-Features: AZwV_Qgi_oC4sGVvJrlAb9eODQIZK5KZ_pUn9ZHV6u_gP7iZGOaVvn0N8W3uoBc
Message-ID: <CAFn2buDb7NmFDOs6x0zGT9EOmr=FU0JdXx5CaUuBrkups2EEdA@mail.gmail.com>
Subject: Re: [REVIEW] eal: RTE_PTR_ADD/SUB API improvements
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

v13 coming soon addressing the relevant comments and some compilation
warnings on newer compilers.
