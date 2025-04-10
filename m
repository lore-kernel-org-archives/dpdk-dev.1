Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A098CC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 17:06:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 800124069F;
	Thu, 10 Apr 2025 19:06:14 +0200 (CEST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com
 [209.85.219.180])
 by mails.dpdk.org (Postfix) with ESMTP id 981F6402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 19:06:12 +0200 (CEST)
Received: by mail-yb1-f180.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso869118276.1
 for <dev@dpdk.org>; Thu, 10 Apr 2025 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744304772; x=1744909572; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tjjlZNW8vwi3eIKe/NFI2pL00nAbxs6RNDNObP0CiE=;
 b=DDOC9k+vbL3z8CYnY/iNAwXqpyCEcOFo65NKfEM0rWoLiVeYCgPS9zMjNvWsZrfT2O
 ZanMuBoTC7pYVS0ftUogvPfgDuz6XHXBg77Tls7EuRMTfroTattedrpNZGhQYJAOsvpY
 FOPFA7yjrjTZGwlPSbcOH6xkYEufDvuraJLLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744304772; x=1744909572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tjjlZNW8vwi3eIKe/NFI2pL00nAbxs6RNDNObP0CiE=;
 b=cLInkpjK+pc912eALcF9qSaydUs7yhkifJUyytW8zFMz/uqqOqmiel+IOQ7HGEjbcR
 KK44T4yzJHQomZicgLZu+ZgW58stexb7x2NW7Lbp5qdmyVseoq1Frvjm1YvffwLL+/sa
 wht23ujDIiDTfnS8ZdFiubnpYbpAIgkh7rSEH6P9Pd7+HLj7ygXZ6pnvghNfTPW+KVHA
 hzmur2s2i+N9VcyCaefypm+JppVKcJ/WS6Qhucz7FYDkQpX/vnkJohtv98KGpVHfQFIO
 3gmIXt0nujIZAzxWbGdF3BL6Ob6F1nI3CsEPdt2zgBDQILV9gmDYUCx/2m8usf81zbIE
 hGbQ==
X-Gm-Message-State: AOJu0YyCl3v7p5AgsuLooogOsak/nQ8NUdd+q6S6UhOUm6dcvytT9U98
 f2MWjfxd/Aye5Gs8jor9PzYr4ZTLduVZ9dsHzUZiWoh7UfWCcHSVtxveavFX18KvHzHf6dNznKZ
 zCbhxVefEafCD9dClpNlUPcnWQFgY1tRno3UnwA==
X-Gm-Gg: ASbGncsskJyQwm+C58efYFvecCcfW9Xl65kPDSmkpZndtUENPb8JaKk/0TYHTvTVega
 Bw0jMgWJN/My3it8WFcsLo6xHeakdgAezD4H6fyyFBxrD3H691Gsq7IvPwya5ouOoHg2R9GKP/d
 24GUDE0G5IR5NIdXziVXTz2B4ZN61SPQPOwO3NximlEhaAKrO3O8PPiumW
X-Google-Smtp-Source: AGHT+IEoZL5J+MuIL2MI/jAsSzYz6IBM1Xbu2UTQuXgAUyx/k9wxtQnf89b/rGTgRHbHj6zYX/b6w2vwkBq+sgOwIwE=
X-Received: by 2002:a25:c807:0:b0:e6d:f47e:6a40 with SMTP id
 3f1490d57ef6-e703e0ddb95mr4519310276.6.1744304772023; Thu, 10 Apr 2025
 10:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250331155800.449823-1-thomas.wilks@arm.com>
 <20250331155800.449823-3-thomas.wilks@arm.com>
In-Reply-To: <20250331155800.449823-3-thomas.wilks@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 10 Apr 2025 13:06:01 -0400
X-Gm-Features: ATxdqUFWzS9fEVPuJxEI-iGVpUf6qjjDzXDYWTuOFqRxX92BIQtPXim18-WEe3I
Message-ID: <CABD7UXOaLyD5cObWz=d6EbFQ_9pW2ztaBgiCqXDMLvuZ92KZ+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dts: import lldp package in scapy
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>
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

On Mon, Mar 31, 2025 at 11:58=E2=80=AFAM Thomas Wilks <thomas.wilks@arm.com=
> wrote:
>
> Add import for lldp scapy package to enable lldp packet
> creation and handling.
>
> Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
> Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
