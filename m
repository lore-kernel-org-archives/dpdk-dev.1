Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C0AC61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:31:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9B5440EF1;
	Thu,  3 Sep 2026 15:31:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D1F07402D8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:31:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788442262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mbG1EZSlXCRfmfVPJJYIjPHjLR2s2DiXCWXKeSfKltg=;
 b=Zp5Aro4CzuYdu9rDkV8FTL+A87MusOIszLBL1MW28B5ogdNZb1RbVHdf0QftpbzqZYOFPO
 zkL6hYL7919aRbZnR9LqQGI2gY3jpCvpE5Wl6gXoDAnHynuymDpIR2v3BpG0t3UsUlloNN
 Pjxa0SSAy/jkIbk3KBBUrj/75FVctCY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-PwUEraEqMXGjmQGYRnd5VA-1; Thu, 03 Sep 2026 09:31:01 -0400
X-MC-Unique: PwUEraEqMXGjmQGYRnd5VA-1
X-Mimecast-MFC-AGG-ID: PwUEraEqMXGjmQGYRnd5VA_1788442259
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b4fe10d092so1465495e87.0
 for <dev@dpdk.org>; Thu, 03 Sep 2026 06:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788442259; x=1789047059;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mbG1EZSlXCRfmfVPJJYIjPHjLR2s2DiXCWXKeSfKltg=;
 b=a/hWG+yUuhDvGDurb3ntrICDfaIB+n6JI7ajnp4fuYSwL18PQ5Rto4y3npX1uxfjX7
 axhzGNC+d0oUMos9+QvvVD0LzqP4y7k7GzJbNoBPwXrPyp6h+BC5VtlhenAMh+c7b7vX
 3qhSGwvTfPkTax7RXNIOaeRNu1yLxoRvdrjUYM1gtbZwNW14KRx1ndQB0ThhN/LlGyp0
 djIH1o/FqYf7HLFznT8wk0mkkC9yPHZcI06+CmvnAOKQIk+iULmuBhroORbKF1kPAdHB
 ey2BQdMyxkLboICrPlLBLGYN0B6QdE4jj5LEuDU9E6vu6T4IN8WpMENs7wCVqDw3+Ygm
 Ln7w==
X-Gm-Message-State: AFuF++mxt47ltL0CP1RizvXqnkIyZg6z84Jb7VVc1iZbrqQU3ikTd01o
 eQKM1q7hqLO+1Ufv2RsUO2aanfkuc4RpwnMs7hgcnEU2V9wdPyJ9lmOwNPbBR4rU75sF9nBcXU0
 SOBNPcmV/qJ2JNxjnLmeK79R6OwMQQJDnhSsM2tJZc6NlcSbAohEv1rKJuzi6tjzKvdwlefj1kU
 u4cl+8jJlTiLMPwRjuWyQ=
X-Gm-Gg: AYBFou3WlPzKcWEAaX0Sh3oLRJ3kyXKxfxtvPLin2E9ZMslNUUx2T4bbIjxGIXZN1t+
 /qke2oAR5ZFa1A1szCvu5G+g/8douK6WSMuuXjwRES4Vc1iJ0u9/PKh2Bo6xDZl66k2mq9Qh72w
 bB+L7tE/zrfOtg6JKHV48YdZe8j7f9F4ztEnSmRIuISZpNhdSYUB57uKtLxSySu0glkDuTYaDHj
 0DRTPUa+PBf5pRMVVrdKkdf2cpwG+eCDBDULooI2gZZAeXT
X-Received: by 2002:a05:6512:3d20:b0:5b5:e53e:5710 with SMTP id
 2adb3069b0e04-5b60831e808mr3677900e87.2.1788442259303; 
 Thu, 03 Sep 2026 06:30:59 -0700 (PDT)
X-Received: by 2002:a05:6512:3d20:b0:5b5:e53e:5710 with SMTP id
 2adb3069b0e04-5b60831e808mr3677881e87.2.1788442258762; Thu, 03 Sep 2026
 06:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <GV1PR04MB10750F000EEB3E024D8BB456C89C02@GV1PR04MB10750.eurprd04.prod.outlook.com>
In-Reply-To: <GV1PR04MB10750F000EEB3E024D8BB456C89C02@GV1PR04MB10750.eurprd04.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 3 Sep 2026 15:30:45 +0200
X-Gm-Features: AcwNN1XHSYnB2GUA6vZ8d_cK5EIvm-CSeGhaMSkkXBSDbAKGeICYqTXBt7GizTg
Message-ID: <CAJFAV8x3r8diykpB1wAGO06C6Q=nyz46PpxYVF4DOrqD82ysEQ@mail.gmail.com>
Subject: Re: [RFC 00/11] Device unplug and bus cleanup refactoring for NXP
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g4feqL6-qF47qPCg9Y_5fC41yRkLG1cAVVUZv0LSvgg_1788442259
X-Mimecast-Originator: redhat.com
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

On Thu, 23 Jul 2026 at 16:11, Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
>
> HI David,
>         Thanks for the work. We will test it soon.

Any update?


-- 
David Marchand

