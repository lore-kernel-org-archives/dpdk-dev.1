Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C2CC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 18:11:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ADFF409FA;
	Tue, 11 Feb 2025 19:11:16 +0100 (CET)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by mails.dpdk.org (Postfix) with ESMTP id 178FD4067A
 for <dev@dpdk.org>; Tue, 11 Feb 2025 19:11:14 +0100 (CET)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-308e92c3779so285541fa.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 10:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739297473; x=1739902273; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U00TzYeh5W6+5zWDBbPJvj06FbcgL0GA+Qjrye4dg2s=;
 b=UYBB0WTTXUItUkCLk+haJmNPkb2eZDxvIY7K2IPggCH1CCbbdTsjg5Gc91b1QNFgmH
 mUQup7ur41pt8U2LkVAOVqD5jQowkoCTxJKI3xrohusZLzTEybpBPNLDSS21bmiqwgCi
 SjlaFZ1UmgdsTGqrUBjGTTsVbBUeGoEgXtfKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739297473; x=1739902273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U00TzYeh5W6+5zWDBbPJvj06FbcgL0GA+Qjrye4dg2s=;
 b=atBKaPAeR2Il4VNwN3c2MHOi7LTLWcPOwh9MYsAT8PS06ifSYwvHocmem87Xeo+7qw
 Bz9JoNhgNLi6Gczt3YriGBd4yG8k2apo/TflsZe0FHZQyt4bse8jZeneMmO+tzFzlksN
 J9kFU0tPrXfzAILwYqhPAjF4vE0cNc+uenWdZxGhG5QTCiXFH54RnG0RhstcOFTxOQSe
 RnnSTAZQJlogGLepAaiQltaIhHVkefvvRFAHEIl6dYlOCkbhd5jRJk73cCL5DfQh9kJt
 415krzhE8/d5sFQUrs/EGeiKDi+WBkyw59R5F5xNfMNmLYXYi7HdrgPD2/cnVEDt+XWp
 p1IA==
X-Gm-Message-State: AOJu0Yyln0EV2D2/IIxE42N8b5fY3tjCV3DoYYeJimK8WelTsLfHdo+x
 iToE92PycuA4yzfAfEAsMe2WqPXEl/unaNfPxXYoAOrEUIuCYWPiwL4Os5gIPKOIcgjRHMydXoh
 7cR0/nEFI11UXFmqXzs3hogmyn43FHSlwT7i26Q==
X-Gm-Gg: ASbGnctUG94wTtYNoYmTW1Sl9aTrh3He+d8Jb3Oy9X6Oxj4DZ0RaVcOwPCaDaE9LW0s
 IIaiTrAvzDVchrKWZyRUEFVvDci4jvgTReCjy4rBgan7mtwXbMyjS1Rf2Ah8PKI/3LNqxrSa5EU
 rFejzn+TeGH73Or48MKJAhNxTEiFS8cws=
X-Google-Smtp-Source: AGHT+IEFOyBhlAu3bJPhwzKhdAfkIYzUGA6WUL2wAd8nhqjHoR73SjwOPZbMkLScs8RTQNM8G5FKGQS1BqR6zdFv6fw=
X-Received: by 2002:a05:6512:224e:b0:545:93a:11c7 with SMTP id
 2adb3069b0e04-54511c814d4mr1623863e87.22.1739297473260; Tue, 11 Feb 2025
 10:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-3-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-3-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 11 Feb 2025 13:11:01 -0500
X-Gm-Features: AWEUYZnKKSHtHsczI1GkXeOCedoV5iuk1aBcXWzIFCeG55qImURcnDUZupiUlHs
Message-ID: <CABD7UXMA8eM5ZJhkkHrUfYPS8pEt4W6+K_ApXoqVaMneP1kOiw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] dts: isolate test specification to config
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 3, 2025 at 10:17=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> In an effort to improve separation of concerns, make the TestRunConfig
> class responsible for processing the configured test suites. Moreover,
> give TestSuiteConfig a facility to yield references to the selected test
> cases.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
