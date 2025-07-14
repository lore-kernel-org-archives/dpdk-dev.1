Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAEDC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 14:47:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15E854021F;
	Mon, 14 Jul 2025 16:47:34 +0200 (CEST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id AD847400D5
 for <dev@dpdk.org>; Mon, 14 Jul 2025 16:47:32 +0200 (CEST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-70f862dbeaeso41641667b3.1
 for <dev@dpdk.org>; Mon, 14 Jul 2025 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752504452; x=1753109252; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcNOsijsarC6+pAYFnfrRmvotgzhWN6UwqTdLrL+dfI=;
 b=OCR2PoM5zB+r1VDaIigR/CXw9h8ceGJFrb58qJA2HBddC3aplS+p81qWfd3iIo15+V
 6LsmzZYUugTadt9vPYgIHiIluuL5WOweruumPq/vPsrQJ62hpK0AZq142VwvPTQP6Gqs
 L0rai4nrKJ5TSkY9MYxdGZF5tc4XW76dkrq6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752504452; x=1753109252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcNOsijsarC6+pAYFnfrRmvotgzhWN6UwqTdLrL+dfI=;
 b=q7gJZA7lzvmRXrdUIo2A8OI3eQZ6vLYlUN/Yjs3Q5HueMJkpsPnw/Cywp70PMmKaT9
 +UzrVtV2ncBovPZSW08azmwSXqNdSJqJKeLmDiWmW9+Wbd1IkpcjCjAIWoG24V40ocDr
 FXjbd6okXIXu7sObFYlxNO/Z+Ekldq+HO7s6gMSEp2WuIJ+ew886bCdTBUaCGypOjmie
 scxP5BZPEszfMX8vyTWWBw74f6AavCTgbzfAsu5T+XHI2KtcDldLfOm16VWNH78r3fgM
 OHj3Wr5mTYWrDQGb9JXG4DPAQ44MkNR0AwwywFfZDrXY12vi2sfhVdZ9ajPmDrBikrvN
 5cMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhWgZs/W7mc8b5bM1VJ8eDoI4owMUjeecCxgCzKHqVIkz9kkjbsNOYdEXarCku6DzR8pM=@dpdk.org
X-Gm-Message-State: AOJu0YyWBX6c65OGTWrZYs+TeAN4Dtn6k6NZfTOygvOlEosrluP7F9+F
 9/w8xBXeaVEu32lZy/uTpnQvOkIovX+DRrQZd1eLak2+lZQbKfv83U+c1WFm+6FHLT+kW3KcD7E
 Qc3fP44HaREZGdsgk3XEBt431+g2f7QCRoKXXDMu3yg==
X-Gm-Gg: ASbGncud1xLl6xVCm4/njp2m2cjRvtYpCmqNoeoHghxyPUIXCy6rjHeWRh4uzyfpACj
 0rRwULRtNU7wK5BMR96PgKoGlHv9Fl2ALCqUvfhZk6Oploe5y3PK2zwspp9rLfI9hyDu7WuN3cT
 Icu98lhlAUOVa7x2jYeJz+I+eUrtfc6dm2hARTwZ6k033IZQtKOMdU9cD2bAqTWgT6CpxpoNkBF
 xNfJBVrVmA4daJap6IZgRo=
X-Google-Smtp-Source: AGHT+IGAS7S/diQcGO9tkAWokCmdYSUGfaP0dzL/JTEF9R4JyOJffjDGTI3DAm9ayNPQQ+87WioatQgdlZ8zKjArz/E=
X-Received: by 2002:a05:690c:6e06:b0:70c:90af:154 with SMTP id
 00721157ae682-717d5dac9d1mr231574337b3.20.1752504451937; Mon, 14 Jul 2025
 07:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250603172827.458725-1-dmarx@iol.unh.edu>
 <20250711172534.540416-1-dmarx@iol.unh.edu>
 <CAJvnSUC_R_Yeoqis1cLaQJbwxyuTANYrNVpe9F=3dt29d+Wi-Q@mail.gmail.com>
In-Reply-To: <CAJvnSUC_R_Yeoqis1cLaQJbwxyuTANYrNVpe9F=3dt29d+Wi-Q@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Mon, 14 Jul 2025 10:47:21 -0400
X-Gm-Features: Ac12FXynTB4rv0GXYFrqJdA0XEC69sMDy3Gv4MZwascG1b0WNHk5Xc7OzQQAwvw
Message-ID: <CABD7UXNK26L07EMUdrR-CH6ndh5kraVYRVfFqPGqrJaVOMCptg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dts: rewrite README
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
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

> Also, I never did get a response from you about whether it would be good =
to include some ascii art to depict these topologies :)
>
> You don't have to be a fan, but it would be good to get your opinion. If =
you think it's a good idea, can you add a bugzilla ticket so we can do this=
 during 25.11? If you're opposed I'm okay with it - ultimately the wording =
should make the valid topologies clear enough to people. It's not something=
 we can add during RC4 in any case.

I like the idea of some ASCII art to illustrate the documentation
better, I'll make that Bugzilla ticket so we can add it in the next
release.
