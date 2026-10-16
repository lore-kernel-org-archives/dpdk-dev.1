Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5E1CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 13:25:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15CB940291;
	Fri, 16 Oct 2026 15:25:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F0764400D7
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792157147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TRo8yt6jwp6iexmYRC5Wttw6TpKYP9fJr7tnnNgIcMc=;
 b=gdnWOHvVOh1x5FDWtKQW4d6Wl7vAa9RFkJeRdO9uusekoB7fLtkQ5hnv6ykrxUPhlDZmxk
 GoaS46L9ukwoRP2WwEaT5Clzx9vCF8zsSviu3gEfh1H1qEMXYP/QajKrWBFKW0gQ+r3OdC
 4r8zXyRGqcKVfeNeivBlxGqrGQbGBXU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-jc34s65uNh2NeZU-DS-DJw-1; Fri, 16 Oct 2026 13:25:44 +0000
X-MC-Unique: jc34s65uNh2NeZU-DS-DJw-1
X-Mimecast-MFC-AGG-ID: jc34s65uNh2NeZU-DS-DJw_1792157143
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a59ac42cd8so31206061fa.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 06:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792157143; x=1792761943;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TRo8yt6jwp6iexmYRC5Wttw6TpKYP9fJr7tnnNgIcMc=;
 b=YtRJ4BRevOgfpTm+/Jhw2tLMNxgpZJvTnHLD/9efrjlrsiT1oS4ZjXOoityLF3CUN6
 mhgNgVPVnbc5yuPtM1QCpQ6YhyZXTZ3mTG2AwMa/BIbioG5GNYQ30C0M8bN5XpZUe7oG
 t+yiQbKITFO+R4aDUA0c9UjswiK8q5DWlXfNXSyrh02FKXpKCjkd9iK9GLiOnnHJAeBb
 9fRU0YUhuFJvmNNunSkje+qLlctYQ+JikZDgmm3B1gtFZiUdcQteNxwI67cuaLGxGyzb
 zy6TnkejvQXAtAasXLAFygVzUfKrWX8Lw1eKj2fidxnZ1DhZV/FRETOjJI1x3d9ClORu
 nrxw==
X-Gm-Message-State: AFq9FYK/32xX1+Owx6L9hKRmCVnI52a+EPrx7BN/PvnJKcWIGgRK+gVf
 paWvDWWRW3M3Y0a00zIgX1pjGyZGnaolbtVWyUw7O1sfon+a5YFdKvybOcnTFZirq6OmcyABWFT
 0FDt1/BEEtKDlN5eFjJmJzWtI8vWPkNIibhrsTZTCYv2yGheVZBApiEIy9pTsmVcBa/uXljAuDB
 i+8mkTLlXDoL/hdtq8SV8=
X-Gm-Gg: AYBFou18eF+qmBbcmHTCWs4GC1V2Xc1gqtfyLo8ggYuG3CR/gbydDHlwPJ3SwSdUm3a
 r3TZZEaj1SBdmVrwpGJUJ7UAPuWjqA9RM8NeffmtKe35odw+jqRnaOKr4FtW7wQn/swrC5671KS
 aaNvyehONL3GEYFKC5do4zj22qYN7MRwxQeyruErvLKzoncmC7q1BWZtfch0yM5M7mCic6+3noP
 tD2wWVWWUoS1vXsenNFnloBh8FuIb9Zqeuiae5yvLt9F2jt
X-Received: by 2002:a2e:be88:0:b0:3ab:1639:9a49 with SMTP id
 38308e7fff4ca-3ab16399cfdmr5956871fa.18.1792157143253; 
 Fri, 16 Oct 2026 06:25:43 -0700 (PDT)
X-Received: by 2002:a2e:be88:0:b0:3ab:1639:9a49 with SMTP id
 38308e7fff4ca-3ab16399cfdmr5956781fa.18.1792157142805; Fri, 16 Oct 2026
 06:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <CALUB8OP7m2zbN7YFV+_+BNHxJwrv+meCqaJPZSzynHnqcrpKCg@mail.gmail.com>
In-Reply-To: <CALUB8OP7m2zbN7YFV+_+BNHxJwrv+meCqaJPZSzynHnqcrpKCg@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 Oct 2026 15:25:30 +0200
X-Gm-Features: AclHuK-MEii393lwt5fV141-mChfkBLVNPG1pkf53_6cKW0feN5XTYgZSB3ogao
Message-ID: <CAJFAV8zGVhiP3z1Y1c+ZexbzX4fvbNHd+_yKiMp9hNbTFu0PSg@mail.gmail.com>
Subject: Re: [DPDK/core Bug 1970] fib: trie leaks a tbl8 group on failed insert
To: Nitin Upadhyay <unitin438@gmail.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, maxime@leroys.fr
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oAOLmBotUSOoTtEBPG8caihcy231nHTR3UGXV409mMQ_1792157143
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

On Fri, 16 Oct 2026 at 13:31, Nitin Upadhyay <unitin438@gmail.com> wrote:
> I reproduced both cases from your Bug 1970 reproducer on DPDK main at commit b618d731ab. Both tests fail as described.
>
> Have you had a chance to investigate a fix for this, or if you'd be open to some help investigating it? I'd be interested in contributing a fix upstream.

Maxime mentionned during a grout meeting that he will be offline for some weeks.
For now, it is probably best to discuss this topic with the fib
library maintainer.


-- 
David Marchand

