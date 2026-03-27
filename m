Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B2410BA439
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 08:23:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE90D40DD1;
	Fri, 27 Mar 2026 09:23:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 265A740DD1
 for <dev@dpdk.org>; Fri, 27 Mar 2026 09:23:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774599833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8xDI9UqN8LjQPTFoKu8r/SMaKDCfQOopXuyOH0bYMIE=;
 b=WPmd0VNoReVhaDzvBsgd+43Yyd4eWwHL+18Ub/TxaJdN09HhGuH3uX/P9V66ig6rd99xeO
 wIGtsDNVYV+iT5+9W2IebBBOA9uzHBgxTBONLZnSkWx+7fL2BVZjPn1KtkGKQUfbPQIhWH
 R9PLb2YiysR2upCvYoU7z+XkfxOgVNU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-YsTPp4gLMQ2I2jDfgQ072Q-1; Fri, 27 Mar 2026 04:23:50 -0400
X-MC-Unique: YsTPp4gLMQ2I2jDfgQ072Q-1
X-Mimecast-MFC-AGG-ID: YsTPp4gLMQ2I2jDfgQ072Q_1774599829
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38a2ad13c07so9544251fa.3
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774599828; x=1775204628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xDI9UqN8LjQPTFoKu8r/SMaKDCfQOopXuyOH0bYMIE=;
 b=NhmzebNtu0ZEPG7MPO3xdq1xhWunEdE7OIoF47/2Cf995m62LoCZovPHNnAH647/lb
 2Cz5bRYsmxpBeTR8FNwyau2DHciHe+1Cn4dk5Zg7Ggwo7wUXL1C9Nv9ygAI/WKNwpJH0
 PJvetE3we9dsl+kDnuLX6M//5IKCVmPpyeT3KYjn0/GAfxhXR3/CDq4TdKhnpNBkniiX
 udSjC8NTc2zrn1Y2Wva6QXFqLQyyf089dqZyHIMgPnzU1/iL0ZVkxs/M925Mlz7LTxmn
 N+EO6NEUJjZHmXTeVOewuhFM7lzg9X7zBTkKeIW8/6mQni+zazxtlqPfZT0SULt4vJfB
 LZLg==
X-Gm-Message-State: AOJu0YzK32mAo6y2CSQc9tIB6HGD98o4/nEbRkTnyCz010GmliAKE0BS
 aVxE3EYBntGp6M1btde2oMIGrTyCSHCpeI/e/0LPfFrVE9jA/J42mGLyrZYMnuVPlUhWPBD5wZX
 P8Mw7Yce7VKPoqRnfpt7xkb4nUti1NZ7oyXaOP+zdAB9PPRvw6nnA4I5B2ftTvMxD5N2l7EvyHv
 qHBitX5BJT6kNKGipcmVA=
X-Gm-Gg: ATEYQzxI+PE/nhRQLcaTiP1wOZCYwrq2U6D+VK/hXAeFVp72iLjWI+kmfnb95/Wv9qh
 ldLCHFRkh85+L5iZtVkyxLDGE5szwB3HLjV34aomMmh28+J27CS8UBmhYORHJ64f82njolzUzzz
 dwiiFRmzOltlykpxkiB+vnyqMD53VFtTtNOU/fmXA/VNvInYYpMCqmlV9Q4ioDMB49cKXoDcGrz
 8zxkgjos2SkML13xfjxR4174i+tZL0UUKBhTd23LshIxVLt2WAs18tliNwO7fuo9YEzow==
X-Received: by 2002:a05:651c:41cc:b0:383:31cb:e3ae with SMTP id
 38308e7fff4ca-38c730b9edcmr5095051fa.9.1774599828516; 
 Fri, 27 Mar 2026 01:23:48 -0700 (PDT)
X-Received: by 2002:a05:651c:41cc:b0:383:31cb:e3ae with SMTP id
 38308e7fff4ca-38c730b9edcmr5094891fa.9.1774599828003; Fri, 27 Mar 2026
 01:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260327080659.3250395-1-david.marchand@redhat.com>
In-Reply-To: <20260327080659.3250395-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 27 Mar 2026 09:23:36 +0100
X-Gm-Features: AQROBzCjigd8h1L6_auiN1xi7vh2cxYw9ySBO0SpUjaSAEQgizSWz2-1NSZtpEA
Message-ID: <CAJFAV8zbwjVrZaaeD=h1Dyfz4KEzhZ8Eeyr5W3TEJhFFo7mP9Q@mail.gmail.com>
Subject: Re: [PATCH] examples/vm_power_manager: fix format specifier for port
 ID
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, ajp@marvell.com, stable@dpdk.org, 
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Santosh Shukla <santosh.shukla@caviumnetworks.com>, 
 Nemanja Marjanovic <nemanja.marjanovic@intel.com>,
 David Hunt <david.hunt@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DKphcw1LvACeSQQvl4lPbNUJ05NoR1IZ5nGO5dymhy4_1774599829
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

On Fri, 27 Mar 2026 at 09:07, David Marchand <david.marchand@redhat.com> wrote:
>
> Caught by code review, port_id is a uint16_t.
>
> Fixes: 20c78ac9ee23 ("examples/vm_power_mgr: add port initialisation")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied.


-- 
David Marchand

