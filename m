Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FB7CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 10:07:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62770402E8;
	Tue,  4 Nov 2025 11:07:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CB76140285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 11:07:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762250851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iaJtapz/w9WsLvMXQBBnxaliBANO4UULlrF/0KdFnmA=;
 b=EP1Ndl5xKyU7Xhs7KVJo8NiJfO8XYqf2V/nBAvH0aI0oTi6D1Lc8ZDtlmsV6Q5nGrlTSm9
 4bf/kM53Tzy1ZTuV9C8dDpt8tWjDc3UA77w1s2AgPWsgPMLeV86ENKKw0CSw6DHp7eiVuH
 cIWfBrkIEQvpVHKJWu8uK1/TNIr+BPI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-0gbfs5HPPfK4qCgioSY5PQ-1; Tue, 04 Nov 2025 05:07:30 -0500
X-MC-Unique: 0gbfs5HPPfK4qCgioSY5PQ-1
X-Mimecast-MFC-AGG-ID: 0gbfs5HPPfK4qCgioSY5PQ_1762250849
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5942c1f786aso1130907e87.0
 for <dev@dpdk.org>; Tue, 04 Nov 2025 02:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762250849; x=1762855649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iaJtapz/w9WsLvMXQBBnxaliBANO4UULlrF/0KdFnmA=;
 b=sTjYHM3WRwcNuyAcrKQuNGupXSzjcH7BXqvG7O7TWWdKeCkfS8Ix7n7K1GQ/5cnAKb
 V4Xwcu/jtTpKTSpUIq/3cCZIMh8rvy+D0ZlWPInqm4UObZHlgPvQKFUUwVM/11aMb0DQ
 McFmOzSuX0hKXS3olpVE6w8+uYVnw32qfPPzeZgOm0KqnJyexv367HjYfQ/LNYhtiOTs
 sEyhgyQYfW2ywhD6pUJ9UFXbShFevsGSM4RYN3brzonFArJzFlBtaTIYQCLPNkl3HP7g
 u0ol8m3+ubEAXwobL9voTJDZmL29mDNAW1C8D+5AFXGiWaYRWwWXN+04RSTkA5SSsEYH
 JhMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeBTb4qipVfI+uy8US0UG939MTj+5Nrr0FOufozU3E4nEi1CzVzzDOk14hYc7ERRGoOSk=@dpdk.org
X-Gm-Message-State: AOJu0Yx6Pz/XE8foCQcgAkkLvXUnA0Je5OcRpA7UBunlAzIsJxucWb8Y
 cYO8J4NIZstavX9EXGlcB0guy5XwlHsABr0kzfIZVAfy71FOKqG0deFmN68RttPSawz+jTh9TbZ
 uVT3KYm6ny6lPagrY/vZUaKNp04OkHlOIJgrn9D+Zoqii6nAGPGN2beiCZC5YoM0fS6sUiMMt23
 55XWY2JmDhO39ssoa2DRc=
X-Gm-Gg: ASbGnctHxmdFa119OTXX7/azYZaxRoCAx0uI1NgZsCdnanFV3tQyolc0fcmVBUvzspk
 LyG/Mlm11kfqBZYn+dAnvMahPafEwgzlpkcVbCSBqG51LfSBmKv4QLbMwtGFkOVZpXbm+m02b/l
 rmH8vbsf7gUjAn2VFT2/fXnO5hdsfURpDGbMzsLLHVj13vcSgzhCXEdIhCrw==
X-Received: by 2002:a05:6512:3d07:b0:592:fc68:5b9d with SMTP id
 2adb3069b0e04-5941d50d137mr4861134e87.10.1762250848146; 
 Tue, 04 Nov 2025 02:07:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPwhdgemUbe4zPIkZdB3b1qiHIXGl9BMzyJYD8jPYXqQlWQJm8Dw9CECxcZ4ZICs/lDqtmlI2LINQxwPwVm7k=
X-Received: by 2002:a05:6512:3d07:b0:592:fc68:5b9d with SMTP id
 2adb3069b0e04-5941d50d137mr4861116e87.10.1762250847556; Tue, 04 Nov 2025
 02:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20251028081733.38583-1-fengchengwen@huawei.com>
In-Reply-To: <20251028081733.38583-1-fengchengwen@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Nov 2025 11:07:15 +0100
X-Gm-Features: AWmQ_blDkKHX-R76jJAhM73G1CRMiHyaYNFioZmhywGhe1nBb61odLtc-yh8TBE
Message-ID: <CAJFAV8xR6emv4N6W6Ng1ZxE1FkzCTGGj9PRbBQHxF5BWn4yH4w@mail.gmail.com>
Subject: Re: [PATCH] app/procinfo: fix warning of deprecated coremask
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: thomas@monjalon.net, stephen@networkplumber.org, dev@dpdk.org, 
 reshma.pattan@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TXoTIO3tOQS8rDuY6P43nePIJzfuzB9Smit3YFRbI4s_1762250849
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

On Tue, 28 Oct 2025 at 09:17, Chengwen Feng <fengchengwen@huawei.com> wrote:
>
> When launch proc-info:
>   EAL: '-c <coremask>' option is deprecated, and will be removed in a future release
>   EAL:  Use '-l <corelist>' or '--lcores=<corelist>' option instead
>
> This commit fix it by use -l0 other than -c1.
>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.


-- 
David Marchand

