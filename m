Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193C1CAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 15:46:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DC1140684;
	Mon, 15 Sep 2025 17:46:13 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id D3CAF402E3
 for <dev@dpdk.org>; Mon, 15 Sep 2025 17:46:11 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-7240eb21ccaso50758006d6.0
 for <dev@dpdk.org>; Mon, 15 Sep 2025 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757951171;
 x=1758555971; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glYbjCI6WfVKkkx9fYu01GDEuj0OIgVsV9y6QHfh8yI=;
 b=K6jwDmeapwQxEbPFMyi5fjkasVmlcQlNdP7M1LW95xkQcTeJJatIA/6OuEPWd2Zfqk
 G8qNJkG+dy1FDFs4L55TKqqsFYlMCAWmOFBUGxDZQY3LyQmso1Va7tChIKfot6fJnhP/
 MSw0zcK21kVSOM/fSlJjsQh+8qG6e6fkpgqvm6aLtM3L++zb/hKT/GExkZnXzCZTwvMT
 wOCStD9gsp9fp0YXtHf8thxBdFqI2eUPwVypncpSHbnQrTMPRD3Ot3mhrTnOpFxaoY3O
 OhavSG6OKxosCLhSp1mqa2dGYf04u/MBZFR/erK4eloTcp8B2t9/5z0Y90nqh1bMJUFj
 gISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757951171; x=1758555971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glYbjCI6WfVKkkx9fYu01GDEuj0OIgVsV9y6QHfh8yI=;
 b=pzguBf0sKFGfcxnYUNDk6ddW2oqjBMaYTElRHuatRfGjS4ULxpKjgW0Mu0HAKRWOjb
 6JqWhPlONcsgUI46m2GuYguDt97etJBQaH2QKo1mpI0+V5WWzloCFzEey5kd45ALUxel
 ddYUnn4vM4qwNg7vh6mz4sSRuD9AUlDVmKaDVWh9X78WfAjKylWNDIxJla9Is+FM1han
 mhE2AwoC8IsVCGta3+oAwJAsdv5XOHv0BbdIB66D4jA4IzKnp9qW/qAhWvq93ZUbf1Dw
 UHoDDZ04wVLe/icpg5wp7gQ/F8H9Ki5rmk68PKAWzOVhBjjmwlgucjI+cFd+/M3b0SBu
 t0lQ==
X-Gm-Message-State: AOJu0YxDVDw8V/EnLJiaYzL1+qYIoJkjcpp+qZqpNKop9XKzcfcw16PY
 JNG7gcGsYDiK9wMCHvjYtTgF14SOOsnR5KZGL4ytzOCgU4VzMc/TaMFv7ycCBOd4yQc=
X-Gm-Gg: ASbGncu4pMwovlagaaRt7DVa5ijKttjzVw32lkeI4kn5YQDszBCAl3HQbahaGI2l8BE
 QdEpFS9pkBph5jacRv0EKOs1QsJ85Awri9pnK6zAP3fZ4lZyFof5OFy8dQDrMxQAoqTCVT15cLR
 ETIad52ICm4OJQNEkoI963RHpTi8c4ZspDk0pUnzM2tKnZ6TLBH/I9ov8w+j1Ls4wETf8dKtIhX
 lHeIfBDpvVtsPYNt5OWcvFegKsP8rY60/Sd0eb/shw7wc8mLhxSwNdAujpApxr2QBRhQalu6Snf
 tvY6zZWO6u2kkXpdLkH2O4OG/+VndUd1Runyiq4CVnOxhgERmnTqR1uJkorfGIMyG50/uo71vr/
 cYVsoyEXkTHDv6D7TV9OQgfSaCc+Rf9okCZ4V+kZK4GUcC2DrtlloVpN8mwkKkF16SRf75C+aVh
 0=
X-Google-Smtp-Source: AGHT+IEZ89t8ujWoa7DfyjWBYt3F+dElVp/D5lLRsTCFRt7bsDZ1zXnsHrIpD1lPK7xygmaadnn6Pg==
X-Received: by 2002:a05:622a:5b89:b0:4b6:622:25f with SMTP id
 d75a77b69052e-4b77cca73a9mr201120051cf.29.1757951171034; 
 Mon, 15 Sep 2025 08:46:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b639def83csm70269241cf.53.2025.09.15.08.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 08:46:10 -0700 (PDT)
Date: Mon, 15 Sep 2025 08:46:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v2 1/7] net/ntnic: introduce service API for NTNIC PMD
Message-ID: <20250915084607.748f391f@hermes.local>
In-Reply-To: <20250908141740.1312268-2-sil-plv@napatech.com>
References: <20250908110446.1071964-8-sil-plv@napatech.com>
 <20250908141740.1312268-1-sil-plv@napatech.com>
 <20250908141740.1312268-2-sil-plv@napatech.com>
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

On Mon,  8 Sep 2025 16:17:33 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This commit adds a common service API for the NTNIC PMD,
> which includes functions for service management: add or delete a service
> and retrieve information about a service.
> The API is designed to facilitate the interaction with services within
> the NTNIC driver, allowing for better control
> and monitoring of service states.
> 
> Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>

Queued to next-net
