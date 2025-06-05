Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31917C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 15:27:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEF9040270;
	Thu,  5 Jun 2025 17:27:00 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8852440150
 for <dev@dpdk.org>; Thu,  5 Jun 2025 17:27:00 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4a44b9b2af8so6728711cf.3
 for <dev@dpdk.org>; Thu, 05 Jun 2025 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749137220;
 x=1749742020; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sn0J+H6roz66+w0w9boeA9Ezr/wRX/IDAXV9nMN15XE=;
 b=OaO1sRNWwQJ30HVKnZnTFadbsK47LGBnWWttD2HNfLcv6uvdgWeEcpi1oi6D0lpAMJ
 XFqq7fWjwKOACQq3XeqRPBd9ptec9ufn6D08FO1JVF/warbwNgY2aXNRdGGRt8nsmzrs
 R17g9Fk+PAiTLXNMHNnyXC3gdB3O2gqdPBpg4BNH5GEhuX6LHjZRBBikSDMfen5kcL8t
 vCatn0KrtqL3efx8PML3yjSw2/6KhGaL2aU6Apo7A1cMm28bIq+8TsAN3AWJMzd8R9TB
 hUVRwZ4fcS1fWqyu+4Ri5n+Iqh6fica7e5QwsZQx5Mc3TlkQ33qFbY3+gG3KT5GKeOgV
 cniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749137220; x=1749742020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sn0J+H6roz66+w0w9boeA9Ezr/wRX/IDAXV9nMN15XE=;
 b=q2yb1w2eiu1vCEEXYoPLo4hCgy0AMt5mXZ3ymZDsSn4uSbkfWbYcoJ5c5YOT2mH4QY
 vyaDw7VyWi0AI9iqgB0ovk/kkec+s8p9Sf6JLlf3j3Vsc99qYXiInuBMJocu03ErTn25
 7/3CsbOwDAERsLhnisNXcBHQtFme8+TMj4C9fqQZ5/ldT6nUIrejwLz/GeTIxkSgnLNh
 LcI2HyIpYIBDyph/hUXURkHKyE6YMXNGOkc7adfZK6JtgaPRzfpLNwKARvDhXmFCHT8n
 qiYe21MxJSnRxQZbLDN0IqwE+AlGqzAE0J9GUhaDQVxJmVukkOdFh8W2MOmvIvOpvI+9
 nEyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxyTVCanbHXZNcV8ozTklgm8y5lSaa7IEX4DWOzp7GzoFvuGLi47cPvwoAsrUOXzbu6jM=@dpdk.org
X-Gm-Message-State: AOJu0YzqreyItVNNFT2l/ZnNPX9bynbIJH89UgM4YuYfOGuvl9os1HrR
 y+DxY2XxTL7Meh/QxKnKRv0ZPTxG5qbrqxYiA//q7TGWBM3rWlGHJI1fqbP8iTZ59Xs=
X-Gm-Gg: ASbGncu6OuZK/v4BI+CsbPSZ/mtOeLYuT4wGjSN2eX4RWW+Y6gXA/0mjwRjTqrTxMVM
 UGxPSubt7TpiwmvJCq7J3pP5PrfKk7/HdnLprW5CMHPLJomd9TYqXXvDFBAJT0DZOn/LH34OO9Y
 swPyi28LzkLSTPw/Cmu1Q0cSdfaDGPwZKtaIZH4UrMwcFTle7GhOEkCGWai+FHWx4qLAbjBttV5
 9XjyzSHRbIaiu588M6yB6OfRKekjr/9k1KkQbkWI1RmcgnnxVnpl8Ndeb5C/srcyEpaRZ5GxkU8
 K+TwgSujFZfv4q/r1eJhMwGKgbGsg1lxhBp9+X+rJl/9JQCYkbmUiW0yGi4bHk1vzyVr+tLlqZo
 hh2MOqyEzLPzfAdYQH7r74jTkjMUx
X-Google-Smtp-Source: AGHT+IGGtfk14bp3ZQ2fGP5It1RN+kpHV5Y0Zvb83F5o5Sn6+jxcXSFhrMBEutgHloUOhmGjDl/1tw==
X-Received: by 2002:a05:622a:5a8c:b0:4a4:3eed:419c with SMTP id
 d75a77b69052e-4a5b9a4653fmr2678711cf.21.1749137219586; 
 Thu, 05 Jun 2025 08:26:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a59fb656e5sm45404421cf.65.2025.06.05.08.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 08:26:59 -0700 (PDT)
Date: Thu, 5 Jun 2025 08:26:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>
Subject: Re: [PATCH] ethdev: add support to provide link type
Message-ID: <20250605082655.2151add3@hermes.local>
In-Reply-To: <20250605113159.3035480-1-skori@marvell.com>
References: <20250605113159.3035480-1-skori@marvell.com>
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

On Thu, 5 Jun 2025 17:01:51 +0530
<skori@marvell.com> wrote:

> From: Sunil Kumar Kori <skori@marvell.com>
> 
> As a port can be configured at one of the supported speed
> which can be part of specific link mode.
> 
> Port type helps to translate speed into the respective mode.
> 
> Hence add support to provide link type as part of link
> status if available from ethdev driver.
> 

This is hard to read English syntax.
Maybe try one of the AI grammar tools to make it more readable.

> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
