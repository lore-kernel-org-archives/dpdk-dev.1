Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4E3CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 17:05:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E172D40DFD;
	Thu,  2 Oct 2025 19:05:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5B3DD40DFD
 for <dev@dpdk.org>; Thu,  2 Oct 2025 19:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759424724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cDDmlMVJjJxcp43v8td07ItvQ2cVvElNmIP8g1lARAc=;
 b=Zn7uXiQ6fgFy5WG+f8JwTLjoJ3eQpZO0NEBEsVplOZseV7eg7A8smaRqBtufDZD/oNrE5c
 JOpsAboiVxDWFkmXxABScyw9slgHt3QZBvo0Xe01HW5iP+Mf49o2EsoV87h6f3WEAoFdsi
 JwkWKKSqL4Fa87Yob4sKuzJF+HmVy3I=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-GHmGy9_oP0WZRQ71zJoicg-1; Thu, 02 Oct 2025 13:05:23 -0400
X-MC-Unique: GHmGy9_oP0WZRQ71zJoicg-1
X-Mimecast-MFC-AGG-ID: GHmGy9_oP0WZRQ71zJoicg_1759424721
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-333f92d6612so5947411fa.2
 for <dev@dpdk.org>; Thu, 02 Oct 2025 10:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759424720; x=1760029520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDDmlMVJjJxcp43v8td07ItvQ2cVvElNmIP8g1lARAc=;
 b=jc3n7PZMCMBijJdaUtFPdrfWCYnpLAhWVhbTG+3TroUYuKCWxvYK996WlliI8fS875
 UIk3ptWj5yVCXQHmWJkl5AQXQ2c68dgBkczJ92EdCuVD3okToPWxgMqJJ2cyrrW7H7St
 rqAhKyM3FmoE7sTvoH8Keaue9Vd7fliQchkBbjfyHbShdRJI1pD/EiK2JweMeF7dR/g1
 EZ+Wb641wMfAFhiF1C4WMQnKbcMys7NQx39oNCvDEh4Gm3VIInL3mBXp5O0LIUfKWdfH
 VwQvPBOyewHANkxOBZmfx2FsVOldDg/QuW7ebjY6upXBkss/UusNIMvbNJ7+NMnnlS2/
 5icA==
X-Gm-Message-State: AOJu0YwNvkN/YkkHmmRW4ce2H5NPxY0lRGlJdM7kjGfSQgXdlnyGwzxp
 nI6/L1DJNWW2337MGTzHYMaZwYrLd2Va1078hP7zQjloB4w452N5oYexGuEFC+/Jf1xpA2Dpbv+
 zd8QvGWQghzhhbgqmWdwKSHZxWdaLT6/qXbT6V1qqSCIWnXh/8RknJJQvK1HCrhOKTPcjK65Ehp
 gWEHwA8onHSdqp6yBJnwFA8QcB7Bk=
X-Gm-Gg: ASbGncvjKRrJ83Z7ngn9w+9WYypYYd78TXeMWI+jM+CdK4Jn8rePgamjDXejRUYDA4J
 UCKogsRGB632eNRNooIG62pAgiJgZ+KsEAfi6WvDIssDvHI7DYwNRBjRkIBtBKmDhkJf7uMAURP
 ZonIUGN5wimOWsXVc7H4lyMefnNju0
X-Received: by 2002:a05:651c:12c1:b0:36d:6ae3:8158 with SMTP id
 38308e7fff4ca-373a73cdb64mr24701701fa.25.1759424720527; 
 Thu, 02 Oct 2025 10:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpLCf7lNCyA+Tn45/gU0dgc8b86Ix/LodciT7Bue6BjUyr2VM3x0YXCWA1BZkGPb3LyaPjLN/nhxZB4RCsnpU=
X-Received: by 2002:a05:651c:12c1:b0:36d:6ae3:8158 with SMTP id
 38308e7fff4ca-373a73cdb64mr24701651fa.25.1759424720118; Thu, 02 Oct 2025
 10:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251002165546.523435-1-david.marchand@redhat.com>
In-Reply-To: <20251002165546.523435-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 2 Oct 2025 19:05:08 +0200
X-Gm-Features: AS18NWB262yZT6ral8pNLDoPN2YxxDrbHUbuX7vaSxaeFil88TdkrJHLlHiZe50
Message-ID: <CAJFAV8x2xSmaPwUmrFMY=NN53JbG4WgEqJv3C7EJqhf5J-ugug@mail.gmail.com>
Subject: Re: [PATCH] test/debug: fix crash with mlx5 devices
To: dev@dpdk.org
Cc: dsosnowski@nvidia.com, stable@dpdk.org, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RojYKEHhV_ZMlZs5_8CA9w-4OgWpNi-a5mcIbTwhgHU_1759424721
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

On Thu, 2 Oct 2025 at 18:56, David Marchand <david.marchand@redhat.com> wrote:
>
> Running rte_exit() in a forked process means that shared memory will be
> released by the child process before the parent process does the same.

Another way of describing the issue is that the unit test code by
forking at rte_eal_init made it so two primary processes were
accessing the DPDK shared memory.
Nothing good can come from this...


-- 
David Marchand

