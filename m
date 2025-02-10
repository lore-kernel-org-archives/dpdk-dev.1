Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6136C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 08:20:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBC4940268;
	Mon, 10 Feb 2025 09:20:44 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id EAC8940150
 for <dev@dpdk.org>; Mon, 10 Feb 2025 09:20:43 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2fa44590eebso3338430a91.3
 for <dev@dpdk.org>; Mon, 10 Feb 2025 00:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739175643; x=1739780443; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=leMiLsRugpMba22Vs6mXWp8RBWOJIUaa0UbZVayZmIQ=;
 b=kKBsHbcMDi1cbfErYXhZMxk7u4nq0y5iIWyKIyTyPVkF5wKlcxszww44/HOS35Dd+t
 3eWunsDRZ0fxS+s+qRVF4h+2epZEkuUPUuCUIPGvCGBzcQytGc+1w743U1pLN8Je0aBP
 d2kTMVVkBBid5cr0m4L1PSJNEie5QdvixwduuleGH2ELmAXiBxJdVQ1XXb8rFMqlCPlD
 bM2TxACT2fHm3N1k+gGTuluEBDFl/2M21REwKkOS9H/XQG17IMGNYEeDrRiTZNm61nCD
 gTefxKyqad8Y5pazRzSIVRCtMypAkODij6YMGv6g8wGUittDbkha1jypWCvF+KN3mGPT
 jrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739175643; x=1739780443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=leMiLsRugpMba22Vs6mXWp8RBWOJIUaa0UbZVayZmIQ=;
 b=wRbw9ZjpAfPsyPf2VhgkufoC2H0qBWG0lVXaLQcCaR779xBEu7SLhZdBvYKqjnIMbs
 0bBESEKbQEgTs9fgzNZw63u3Q97KQbpOdZZeM1sb7HDdgiSc8MCISpTKnIVq58JGUmhl
 0OZMM4d+E/4rrbdELCr8S9F8p+A33kIwVe0kp0muMEnpwwzc1dCYDOCj7nrwutURdAuZ
 qY3Dk1bCASL6dDiBbJSrzw8kCUw/Qd7m98qdYTt+CUXuL1puLnm8ILUtbRaihnsPMZ1w
 mA1esNGDyquFLZK9bLwEnMEi1dGmRSFENQCjMUFW32wIofPqS3AL7+5P+lciPc++PJbm
 CZCQ==
X-Gm-Message-State: AOJu0YxYWk/B8iW2PqCFP8Wkk+iekbflrhbCS6orEJDpBQoM5qDh3ehX
 5oSc/0G0ThN61MOChrwwjJIOIBL0hopQlYWzM/rWkDwC9hphKtlnU3W2VStf+6b9K+f/XhOycyc
 +c69Buu6GHkXqo7MPcRxDkoIAGt4=
X-Gm-Gg: ASbGncv+zQiIKGTS08B1yOir5U3ZZAm4owWRdvPodiVXfmYVlQl/SIy6+FCuKQpVpIx
 0Okjiy5YCsK54SNC1X6/GYhyP69HKwgXFISRaaBzvLj3DCL0d/8xEUgHIWIOC8eQw0ukMRsIyQy
 4=
X-Google-Smtp-Source: AGHT+IEekN0cO2FBsvpolOUfotEex0uTCykkSkj+IOZIih90AI2XOxvKGwQ87LUSmwH6pro/+iiaDAXk+DfQnt/yB+I=
X-Received: by 2002:a17:90b:3584:b0:2ee:cddd:2454 with SMTP id
 98e67ed59e1d1-2fa241770e4mr20861863a91.15.1739175642825; Mon, 10 Feb 2025
 00:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20250204164508.864080-1-tudor.cornea@gmail.com>
 <20250207095719.2c7a75f9@hermes.local>
In-Reply-To: <20250207095719.2c7a75f9@hermes.local>
From: Tudor Cornea <tudor.cornea@gmail.com>
Date: Mon, 10 Feb 2025 10:20:31 +0200
X-Gm-Features: AWEUYZmSmix6J55yws-sOWdelX1g0RMO-Jb1sXPqhvd0q_zJBgQvPXpWGZ1n8KU
Message-ID: <CAOuQ8vUbzb_H1mBz7EpgpvYj4YuYbdEjiYyui4X8Pos+wfyS8w@mail.gmail.com>
Subject: Re: [PATCH] net/af_packet: fix socket close on device stop
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

> Applied to next-net
> Should this go to stable as well

I think it would probably make sense to have it in stable.
