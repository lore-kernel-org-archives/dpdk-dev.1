Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B7ED715F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 22:59:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41281402B0;
	Sat, 24 Jan 2026 23:59:58 +0100 (CET)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46]) by mails.dpdk.org (Postfix) with ESMTP id 7B78E40278
 for <dev@dpdk.org>; Sat, 24 Jan 2026 23:59:57 +0100 (CET)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-5f5418ec110so3569896137.3
 for <dev@dpdk.org>; Sat, 24 Jan 2026 14:59:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769295596; cv=none;
 d=google.com; s=arc-20240605;
 b=aEw20GMeNGdfiqG5dclzMERgt1UzJTTtLZsyI8OzMMBkzZjyolG6qZfA6QwcdhxXLJ
 0NBNTxxzzNrHNFAyxo4aexnsjRY3M3/Jq2Y1DVoNtr7VQ4HwiJNmqFNWIqG2d378v4Cp
 RNJCpkV0zVWnLDtzZ4pW1x6DKPZUxQ9QeWEaIv6oEEF8MmTzg31fms3DcrZmTVp+n7Df
 V8/+odQRyJe8ljjx58YwRQWhmv6s7NOMgGwYKfXY2TwTS6qcLyVs4x+EFDiPahQiLYjS
 0A2OdtTvkl5T8gHy/ZPBxW04PvQin88rBP2w6oaFDxS+egJJgaR/LyLqyVoOrq3tiFKD
 obFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YVYK/OBgvJLGKOqrOCIlUac2/fBVjkkt39oZOWHhtfs=;
 fh=9GDrS3tifzgfNr1eIYplN6H+e66iZWb9rV8dlwI9lvA=;
 b=QVXFqujqa3KqvCLB4SjvXSsHPcxYEKHuFBGCvJVOS5y3GYpMSJUQtkPCNFzBGN3d+U
 9xqrwG/UMzx30x5u6V+7EvnOxrBA6YvFJveXbrYsOu6vNHj3fMYxrjPFhAWsZ4Xgg1xC
 AK7adFGAg4ni6r2BqP79cG25ZKFilHd53EZA34ZcrlxxSCtG/p4qDlBQPEZ0isLJD9vR
 CFg7Hb6cEE8AHPCkvE9T6ag7yVXxdoqHPuNvDci5tcnQuDAkFrCucRWRs4u9EcQMiKqb
 Kg4dkTjsUckz15aagtL5LStL3vSB8lmN0uc4ASlNWgZYf7Fvklyt1hrkUGzLCgTxc0xQ
 /QQw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769295596; x=1769900396; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YVYK/OBgvJLGKOqrOCIlUac2/fBVjkkt39oZOWHhtfs=;
 b=LPPtSTrAB4THKHfVR+OOR0NzHgBUYhioTQ0+SF1L0d+nS2TIv9X9imv4HunP2yCeQq
 ETP+Z1fV7+izS5E1X+zZPFRaLpNOgvzRwv5aA0z/ibh7HouWGFhhkPo3DceBDYCkhmuZ
 lMFmWXRflp4sfWZ7lvU3+08qbgPX+N2kELTcKnHcNk+u6pDk/fzsoBtmuz3Aov8FdEWH
 du3IMUxjtx3rPhZm3LV+9bQldHFDEaJAiggyDpBgihFsSbOntswF2Z1WXMhkjpdIa2tm
 knae2diyIDvJxCm1bt6fSiisOA9NIQYDw06PEV2EjJoA3dO7vHY05sx469ehLAHNq/qT
 eXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769295596; x=1769900396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YVYK/OBgvJLGKOqrOCIlUac2/fBVjkkt39oZOWHhtfs=;
 b=cnoK1VTnYwrHOHMTtcn6d7frKKjB1nKJjqA6IosxTYJ00leh22hDHIQ+GTr8orKVQD
 nP+fJnsk4Yz0Azh4KEwzIHElA8i/NXDoq050JGFWbrPg7lu75XM43Nw/TiymIhKS1GzL
 BmZCB/f9tEaNIgF/OLnMmPGlEuBD7+VQxwIz9n1uX+nrFXFQg2XAbRBSq3/Ot+yE/MWU
 nLgGuAOv2Zy5qRSN32DqsuD09PhKORX8R1MaJn9xgPGduSDtT49isqq79IdfMEQBcmCI
 rw8smdt0MRu8R32d1FhoJMrTtLrJFqD804sbKgSWufuSlg8Pjt3pGDPDdCJyI3serdur
 1Tww==
X-Gm-Message-State: AOJu0YwR61bCK3G9wcHqcpGY0aphGqJ43P3ysONf7/O8d7E+0GZA2tZx
 3TJtXis5Ks5QA6wcLj+4LSJDC4pI9qCNJq7tFC5gVzTYUfGgMsWeWkagBzvxiEMnrhtK0m+PVC1
 SCpcVpnCbFdrJZ9NrWm/+I+PWQN4EOGLSDQ==
X-Gm-Gg: AZuq6aLdKH9YnjQl6YBwE0u6v1rrvpDeZkYyQnaGsLTg0bfWRjLydI6nRkeKcVAxrIo
 uZlM7m1cZj4rhPT9Ox/NEpgvI+gk+8YfQdqscb5zB+x90Yi+IfLeLc4XInTfpJH/zKY731ODoRz
 b2xC2S2528m48/IZDu6924Xib0IzCLnh+JeJJ8SqCMhqfW2vgUFnShr3VPYAcwLFxD17JqHbOAA
 uhHBEGLIRy0a3mYf2i4/bSUnzCvHnu4BGwEozDOjHRMH4jDO6dIpLGJa9HS70JEcW26BJU=
X-Received: by 2002:a05:6102:4429:b0:5df:3b19:4119 with SMTP id
 ada2fe7eead31-5f576486e37mr75946137.26.1769295596466; Sat, 24 Jan 2026
 14:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20260117210322.5419-1-scott.k.mitch1@gmail.com>
 <20260123162742.69675-1-scott.k.mitch1@gmail.com>
 <CAFn2buDQBAxnZBYyqhzZMN+DW9XRp9ZN1Wb6+976kQ_S4ByhiA@mail.gmail.com>
In-Reply-To: <CAFn2buDQBAxnZBYyqhzZMN+DW9XRp9ZN1Wb6+976kQ_S4ByhiA@mail.gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sat, 24 Jan 2026 14:59:45 -0800
X-Gm-Features: AZwV_QhOPAqoPuPBSNC9n1bqfch4VXGvDWn0tCg2JCOqh8Kucwgv0bUmx-6jXDA
Message-ID: <CAFn2buDWa9nkyHH1PXrkoWxjYiubnHi9mUmX8g-4-AKixVug2A@mail.gmail.com>
Subject: Re: [PATCH v10] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org, 
 bruce.richardson@intel.com
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

> I will submit a draft for v11 that implements option 3.2. If people
> like this approach we can discuss if/how breaking into multiple
> patches makes sense.

Compilers assume memory is aligned when casting to a specific type
which isn't guaranteed when using these APIs. Returning void* prevents
compilers from making these optimizations and is a safer choice. I
will submit a v12 with APIs returning void* (I think I can still
preserve qualifiers).
