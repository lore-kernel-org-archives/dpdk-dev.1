Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46142F459EB
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 14:55:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DBC54026C;
	Fri, 10 Apr 2026 16:55:36 +0200 (CEST)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49]) by mails.dpdk.org (Postfix) with ESMTP id 8BB1F400D5
 for <dev@dpdk.org>; Fri, 10 Apr 2026 16:55:35 +0200 (CEST)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-650221149e2so2230612d50.0
 for <dev@dpdk.org>; Fri, 10 Apr 2026 07:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775832935; cv=none;
 d=google.com; s=arc-20240605;
 b=LfNNlAU3NY9CQrzkhIJViW+kE1NagUP51LWe1hPWJXsc6mSh2D7ol2n0V2h8ywSegb
 kSH9ko7aQ/I3I/DkCah7W9kDLXHLIJuFi1SJ04nq5mbBLrFi1mq5SkdRNZgsicZ9SVtb
 KutIcUG0ezNkM6Ae+eoTAEYvneZas0wzuMB53UeYew8uMEu9fk5titqRUijh+joY9MfZ
 4Lax8oVUKEcVihFuxkI/9P9LfYPFxto+FRkRnfyNohUKwSX0Wac1Tg+Mn6tLXbqu6L1p
 TvOz3TAcXxU5GKI0lU8kDHU5LrPUgS7/A7O7y4TLG7D6kRLSFz001IIcZjbdWffKtumX
 BH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=19LCFp5JW0H/20kNwLSKKRJkcOEjk/RhEoirc9H/m2w=;
 fh=rOLOQ0z87NBfn3B90t3HIPPssnN0ETGCE+0j51KSQIQ=;
 b=GSIPePf5xZ3pch/Iexc0qwtt1gjFpqNvMtFic4LsKll8Dwzw+rada5HZhzEOFqvHfZ
 ZolbGJBSUNChQe4kHoXBPFPGvlakfVlgYmJcgZ2bA7fPy/PMaWCvgyiyCjD78dZUpHLF
 PSQL4xHAx0SzrdiiTME2Lhebw0AnRGZCQcmfOJGu8+Kip0Y37FLwfQy/wOXwg69JKs5s
 E6VIWxLPxMPhTUQZIvbYP/wkFECxX+gED8U9GVOT2zMq2/1b0npSAPZhp+5QPMoYhuEw
 ijHIbBD0Dxxni7MxB5fEBgcyk10bPHNZJd7fHy7LAo/oaGlUdNs9X9K+fOAr5fJjJ6+u
 wVfw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775832935; x=1776437735; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=19LCFp5JW0H/20kNwLSKKRJkcOEjk/RhEoirc9H/m2w=;
 b=i99MERnjXT5L3B7U9iYDu5E+WbAwdXMNWmPGHI8mi0FAy3loWjash87+yJsXN+ZJQd
 lAgsT/ex6jrez94UxDXrTKadMSNDyRfQ17pKUK6wk6qkOnXqy7D5OuVf/usi7m0it9rh
 ZPe2w2UVNiv949TFlmfmbeYcjRggWkO3dgS5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775832935; x=1776437735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19LCFp5JW0H/20kNwLSKKRJkcOEjk/RhEoirc9H/m2w=;
 b=QLaUdmqGhVrUUNiABVB9vuLqo5eYr5cUuRBRZ2cEjFRrcH5K1ff78cj6KeIRM3lhtp
 t3e1nk7MyaA0XH7zGlYQUTaH0YMkGe5ZsVgSEDE+WZDWYV3WAfQIsg/hGWmVAvoVyu1D
 Gy6gHLhm/xTE/oJdfQpXgXGrwPZ7GSyaBEMZ9GESbpmR9WMBA5b5v13YXsBp/24t8/ju
 Y0+CjWj9N+NiyWb9SaMhNpR+FUyudIGs1c3XyQEYOEr5fAZw0PsSseCj0uFINr+8iUEA
 bRKIMoDUY0ZMLLr2R4uEaaterPt8sYn+G/rIQraoyhScKEZypekIwSjUOVOHixYenzxN
 M+ag==
X-Gm-Message-State: AOJu0YwvOrqkJJRz0YGyJj5X4v80mfWqviugZRSgR68U71+HLd/J4/J7
 1TlWO+dU2isHDENLeZDQKBouOhZWnQ0HxhPqwIllw7SVKnG1ijqpqaYdtgm9OKM6zTAwdtDlmos
 /Q2NYnaaACbihqRS5dr91zZAOnngmVGExn1wFjugIqw==
X-Gm-Gg: AeBDievxJyKSbJd0rfzfaGDe+9AS9sx+wgI/W2a0LWDyoVz2F286FRuCiECo6px2NKR
 VBf2ifU5IrqdivNIeWPOMThLiwZ9iHoZYh4Eqa5u1rGVeHrJrnUs1v3IRmNoMcJs1ZSRiPtZjDx
 is4RAEO0qqh21QpsQRpJmp1hgIcTJKdmwZ+xKl3hbANs3rWEMDWFdO2r87CH+/flw7ukhdrk4RB
 qT4UQpTUIdOTzmAD5Or/j7L79rs8t4mEJHbjeoPAjalwkdZtzsRRPNUDXgJQYkffheMI41jd6wf
 9Ag4AjULxA==
X-Received: by 2002:a05:690e:1303:b0:64f:edcf:6f1 with SMTP id
 956f58d0204a3-65198bedb28mr3242135d50.52.1775832934753; Fri, 10 Apr 2026
 07:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251217195155.32350-1-dmarx@iol.unh.edu>
In-Reply-To: <20251217195155.32350-1-dmarx@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 10 Apr 2026 10:55:24 -0400
X-Gm-Features: AQROBzCUS9Omm7Pwdr3tbvl6gMED-bKQcB-Aa0pxXSMQjnlwVOoWYfosIfXQN-c
Message-ID: <CABD7UXMFudwyWnBCv3CoZH=z0oGyEdz2S8PErQ18PRTVsC0VBA@mail.gmail.com>
Subject: Re: [RFC PATCH] dts: add PVVP case to virtio suite
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
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

Update on this patch:

This patch is functional and can be merged pending any extra reviews.
Patrick was trying to sync with the next-virtio maintainers to verify
this is testing a feasible real-world application, but left before any
communication.
