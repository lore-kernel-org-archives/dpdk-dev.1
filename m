Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25F1CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 16:42:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0858E402D1;
	Thu, 18 Sep 2025 18:42:07 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id C51BA40288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 18:42:04 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4b34a3a6f64so11765791cf.3
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758213724;
 x=1758818524; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvQ9XO0NYn8rftSO0IS5LRTY4i0Jp0b+gf+xMpfQR4w=;
 b=SQl4tUL308p64iuy1Eo7Y/dHt7oIT79Qnr0cgbRkaubIDf+ehzHMoRMpRFGirnHn2r
 6e8gv01Tg0dkzWEF0IezvYIm8EzjNduI10kdcFIa8xliX/XGrAFJcpI+lX6fSnjSEpj2
 UwKlvNyuHpeYHxkg83veBAO7QUwRXr4CUQoblPy/BIEJg9S2rf3XTz3mOy93A1z1h9fd
 4ECFvv0pHGduhxoHlu143lSNbQ+LrH3villJl8Jp9CADMWfrLB2jjNmEU5VTFtbrjzuv
 Ef6LrEwE3gfP5hGDGj3diBouV2BMkGR8mIewoiopYCzY7JTqllwS7r7uXFM3Uq3VIywS
 4v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758213724; x=1758818524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvQ9XO0NYn8rftSO0IS5LRTY4i0Jp0b+gf+xMpfQR4w=;
 b=Cct4tAwNGM6QvQjs+LIAzcd91dpmhc/xb0RwJAirRlQdL+BQPd0zlHhmjtmA3UeBde
 hu2N4rTqvVFOY0pTukOQdto3alt1RvGy+9rBxIeE4wtWZjU+NVH9C7RSuIIUmFuuzuDE
 GnbetHiou+FnqpUG0+pSZVfROVraWumhnUBR49aHEAZTc7yJh4OCjETzfWYBzjOHwzAm
 bJEoKIYODXX3DczMuuUnML/plRlZI2TuABYkH2Z7TRrkYtGTSxcnqOmaP57hMlpI3Ksy
 nzcEzp2YSdiu0snSpEryqP7jYR02BbyT1TbZQ4rrVZ9NV5G6uJwysTVxim8YMMxbTV07
 tMfw==
X-Gm-Message-State: AOJu0YyLGwtXpIzGBPrUhdd775DQbcQZUx27QQH/ViNoweGXAgRbNHE/
 3rDwb2OdRdCLSBKZ2lh/glavG4+XNr9C3+d1mxEmsWwL/AoKxe65fLq08kaWoPwzQRA=
X-Gm-Gg: ASbGnctaJtEz/136c5l2YbZMjxFpdjOx3s85HS3M2BpbajS7ID+rwCE+CrPfD6XJohS
 p6uIyck7OviYM1OZhLcKr5VAcDohyVQn4OA82WP2R6/fvgxMu8UNWSYZVwf/NDi7dKXBDcOqhKn
 oyiL8XqIPjtVame0EfDObJQE5NNAFb6yoj4ZXhVXWcAnSLmjDcuIU4HjDvdNGi1Uf2h+aJTe/dj
 4MUcLd5oLHVrVyXBXT8Mx6Ff4dSNLPW6nScsP6MqXZHzPvjqNlBgL9jrfnCRURxvT4XWNvFvg0M
 rpmRJPD1Uh8dNc7tuoPZxdyABbMZDSuFOjDQmzzFDqnxGfGBKwOi92g33qF8f+MUUTSXBdSH2DK
 mEBE365sbQCtutClQD1kJJJhp9caV/8Wj3V3yMMmcCu1J8acBYs9Y7+wxAA9BtKurj+mP/MC98S
 2JeczQdIZcij0AFWLtFQ==
X-Google-Smtp-Source: AGHT+IGp35eCHwGx/nCpykoCPa0BlQQR88QGIVcsY0WTnNTEcSTJYGBFci0Pc0rAR5u6xPl59Efu/g==
X-Received: by 2002:a05:6214:2528:b0:793:1cd0:2568 with SMTP id
 6a1803df08f44-7992046df2bmr645146d6.65.1758213723940; 
 Thu, 18 Sep 2025 09:42:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-793472c35c4sm15517826d6.24.2025.09.18.09.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 09:42:03 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:41:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] app/testpmd: fix L4 protocol retrieval from L3 header
Message-ID: <20250918094159.39735f71@hermes.local>
In-Reply-To: <20250830012913.1117632-1-huangdengdui@huawei.com>
References: <20250830012913.1117632-1-huangdengdui@huawei.com>
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

On Sat, 30 Aug 2025 09:29:13 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> Currently, when retrieving the L4 protocol from the L3 header,
> the case of IPv6 with extension headers is not handled correctly.
> This patch fixes it.
> 
> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---

Queued to next-net
