Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F473CD5BB4
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 07:31:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58CC340280;
	Tue, 26 May 2026 09:31:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 374A940279
 for <dev@dpdk.org>; Tue, 26 May 2026 09:31:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779780691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=plU8BSCrKS1Gmya7S5xgNtQUzlqB54/rK74wS+zSBiM=;
 b=azod1n01dp90RAlvCoiUMX0NTVb5g3/a6+eUiNI4zVHDmnDOplPomKVejluZORlPvXqKqQ
 baGk3EnQ4rwohQxpCRvUSqok3dN4sZ1+uMcLeJy7DeUZh02V+i0wBD1BBY6N/O0huX0FZk
 9LcKwANOsKMY0wpFe1/JvT3XQNan2/0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-AzjZC67KPaa7zJ5V0OQGuQ-1; Tue, 26 May 2026 03:31:29 -0400
X-MC-Unique: AzjZC67KPaa7zJ5V0OQGuQ-1
X-Mimecast-MFC-AGG-ID: AzjZC67KPaa7zJ5V0OQGuQ_1779780688
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-395246cabc4so42498311fa.3
 for <dev@dpdk.org>; Tue, 26 May 2026 00:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779780688; x=1780385488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plU8BSCrKS1Gmya7S5xgNtQUzlqB54/rK74wS+zSBiM=;
 b=bTG0onO5UXvumbcgWIj86qfcxt/Ri4YXTy8NOVDeI+e3e9qL1jhy98MxGh5+/6KBrJ
 luClDmmO7J4ZgAXK4cdUE8w0yaRXNZ0BWHXR9DQHhSsrBPa9zJnUjqskiVvrWJ4CFB3U
 aDDMHLtyWdJq15g3j/ZRil7OijESsreaaAtohc1fXwF5gxoozjBKrmUz6MTuKujKMTiD
 +kVg9MV2Whd3S7HqdZ4j1b/PynmtgXlaqGXrJix950nkgcIy/K1wVPF+OFRbKB/a0Hfc
 6sa8DCR+4LRph9z6QTaiaRXi9Ndt2Kxg3O6Pr60Ai3LMH22qwJEUKGdFv2UeCiOwnEs2
 dfjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/y9FGXunr1yQw548LEUU8+C9YPJyfJ8xYqen3F9Ya5C/A8wcYlfjIK0Fk/VRJycVLPLjQ=@dpdk.org
X-Gm-Message-State: AOJu0Yyd3pSGavFU6WCj/9lc8ThC1EuGTAkgjUiyM+v4TjO3Tepoo5PZ
 l4Sc++a73C2MUU41iz3NXl7dfBVGV3cmOWBvjt/afOsp3NqPF6FgZH5XiqCWsa0fb5wsS8y9E3V
 V0pMz7VQtHKXwX2W23973BbURLASmaJFDLCnt9nEOmJ40AJ7US7iB0H1bFo5IQ3Dh64DN2xJw4Y
 LLe+J8dJ2B7NcFXgxMaRg=
X-Gm-Gg: Acq92OG6oqj0uEk+5koMucpQWLEYY23nm/Eti+8iZKDUfq0MWeva4HVo2aAW5A/JqLf
 ITdvUyjbhC01xZY7Cxi8OBP2Lg1Rty/3LxqJKCd0qRHIAhHl1Yin2dN+S5kEm2ozQFpLyMo/eAH
 ZRmT2meuOn6nMlpNROFf9hCZL4u413Fkqo0fUTzzikI7Y2U7a5vhmn+4DgQeedBE4txdWmiCpyo
 VgJdLWOcSo7YMohOxgHtD7uvccQJUbTp0rMlWwldEIyvgz/rq0KP4pLfcSDzXUH6k1gkQ==
X-Received: by 2002:a2e:8e95:0:b0:38c:63df:82a6 with SMTP id
 38308e7fff4ca-395d8d64e6cmr40136461fa.29.1779780687927; 
 Tue, 26 May 2026 00:31:27 -0700 (PDT)
X-Received: by 2002:a2e:8e95:0:b0:38c:63df:82a6 with SMTP id
 38308e7fff4ca-395d8d64e6cmr40136341fa.29.1779780687403; Tue, 26 May 2026
 00:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260302110206.49670-1-fengchengwen@huawei.com>
 <20260302110206.49670-2-fengchengwen@huawei.com>
 <CAJFAV8wbj3oKRoF-0+jr1ceWMgVDZT-a9Rd5Ptdx9=N+1_WA7w@mail.gmail.com>
 <c0f24426-19b2-42bf-9432-a1c58ac19c66@huawei.com>
In-Reply-To: <c0f24426-19b2-42bf-9432-a1c58ac19c66@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 26 May 2026 09:31:15 +0200
X-Gm-Features: AVHnY4L0bU9g-bv-Z8kXoZt5trnrGg5jv7ZTHvD7pTuSTciqeQVDbNFJ-GWxRDo
Message-ID: <CAJFAV8x6Akk1N8jsvcyBVvHKkQ_dDP=Ky6JoM-tab=awwkbohg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bus/uacce: support driver forward compatibility
To: fengchengwen <fengchengwen@huawei.com>
Cc: thomas@monjalon.net, dev@dpdk.org, qianweili@huawei.com, 
 liuyonglong@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qtSPp0XLVWZNtkSApcBEcwQapbUWZvX0vrMKea_aVyY_1779780688
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

Hello,

On Fri, 22 May 2026 at 03:05, fengchengwen <fengchengwen@huawei.com> wrote:
> >>  {
> >> +       bool forward_compat = !!(dr->drv_flags & RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV);
> >> +       uint32_t api_ver = uacce_calc_api_ver(dev->api, NULL);
> >
> > This conversion from a string to integer could be placed in the scanning step.
> > Why place it here?
>
> I think it's OK to place in the scanning step.
> Should I submit a commit to fix this?

Let me handle it.
I'll post a new revision of the series with a fix soon.


> > The dev->api_ver has no in-tree user.
> > This field was (silently?) dropped by my best AI friend in the bus
> > refactoring series I posted.
> > https://patchwork.dpdk.org/project/dpdk/patch/20260506155201.2709810-12-david.marchand@redhat.com/
> >
> > Please advise if I can drop this field (it is just the integer value
> > extracted from dev->api afaiu), or if it should be moved to the
> > scanning step.
>
> Please keep this field.
> This field mainly used for driver to know which api-version the device support, so driver could do
> bug-fix for specific device by judging this field.

I am not a fan of leaving unused stuff, for a potential future case
where it could (maybe) be needed.
This is your bus and drivers, and the change is simple enough, so ok,
no strong objection from me.

Thanks for the reply (and sorry for not replying sooner, I was out for
some days).


-- 
David Marchand

