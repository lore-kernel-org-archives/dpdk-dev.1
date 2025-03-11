Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BC0C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 13:05:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3C014027F;
	Tue, 11 Mar 2025 14:05:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9E5BD40263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 14:05:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741698328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BdHj0OU1NDCpv6ZXSVadMBxER/nkpwOXKW4mhjnA0w=;
 b=Z5kGcRU4HHmun/Xfz/U4s2eehADj8GiPk7qfMc7AwVoKbDNBl8/Jjmt07JX2QSyTlFYBey
 V5USDN2CePQgLwiE43aA7BO5xX3+x5xaoDGCHT0dB+GeZGX5lyNzWenj8qElzohYFRDhwz
 wm1NgzedEvIVS87OCUtJ093JMnbOcvM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-LQsDEd9sOcCnMLcYSnwTRw-1; Tue, 11 Mar 2025 09:05:26 -0400
X-MC-Unique: LQsDEd9sOcCnMLcYSnwTRw-1
X-Mimecast-MFC-AGG-ID: LQsDEd9sOcCnMLcYSnwTRw_1741698325
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-549adfc38daso334998e87.0
 for <dev@dpdk.org>; Tue, 11 Mar 2025 06:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698325; x=1742303125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BdHj0OU1NDCpv6ZXSVadMBxER/nkpwOXKW4mhjnA0w=;
 b=HIBrYiceHn7A4qsKwzwdWwcNzVDAH3QgdVsZUsSdggCe46J8uQcvz3AhWZuGpKnrlF
 GYs2/8iZ3r0ceQyliE0BwVK7TjHed7I9jXuWFyNeio6DiJTuB8cz2fArYvQSV+PwkVM5
 IvR7m8AXh8Cxwh/KLMK4aA8pwlIp8nwez12qz/CnzJbj763cBbDtDmZhFlj22ofs8uKb
 FX0WLDJjHsuyxHsa5klNiP09EZkjSaJXEcJnVFBczgv89HAfIWJyIQEbUTcA4+9+1k8k
 zYsX4xVP0DjJyF/byYahYJDvjr0ELu2/jIoqliAb3KZSSOsWzvZX6ntzf6zoqu2xduUm
 RQ9Q==
X-Gm-Message-State: AOJu0YwPkMGo2dNRpbS8RrI+kHH49fMZYR61yelYG8qf2mbM2xNVQtPC
 gEp5hbYsyklZPIgcmvgjrYZqqdI8TDJgVv6og+cvRbvZjiZrKaCJ8oPRnPl8kCPFIJUIPWfxnPW
 38vFDh5Tz2VfkNe/0M2E6oHWSyxeXXOHdbX2iJ55djyGM3+uVEzHUBVBGjzA5fV6Zg57FzwbqC5
 ppD00k43DeAaSOI7I=
X-Gm-Gg: ASbGncvjC+ooNAZz7Hn830KdhT/a2rGZnSBKNcZnQnL3fQW1FdZ68GtnTNQt+2IcMaj
 zNK8kMlc3+Und9J0n5M90fZ4jWB870DQPugfPd4ArByq0UDS+WEaOE9IHQzp1Qxy6fYrx+KVnfl
 c=
X-Received: by 2002:a05:6512:2249:b0:549:7d22:8325 with SMTP id
 2adb3069b0e04-549abd08771mr1133387e87.2.1741698325294; 
 Tue, 11 Mar 2025 06:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZRpQ54RrImvijPk72ye8+35Vte+f71u2GuCXx1gJRdo1YFrITVctR/EdbVTchWNNIG0iRNpdXgR2jpkZ9gPM=
X-Received: by 2002:a05:6512:2249:b0:549:7d22:8325 with SMTP id
 2adb3069b0e04-549abd08771mr1133354e87.2.1741698324878; Tue, 11 Mar 2025
 06:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250221004528.6999-1-rosen.xu@intel.com>
In-Reply-To: <20250221004528.6999-1-rosen.xu@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 11 Mar 2025 14:05:13 +0100
X-Gm-Features: AQ5f1JpWX0ug-0aGiyxA8HOk3K-YeMJgby27x6w0Usrpz5tI-uYbEySwD3b6qwA
Message-ID: <CAJFAV8yMjCskAN9CQusvDr9aGXy44qMVX8WG2UKEGL7j2D+nPg@mail.gmail.com>
Subject: Re: [PATCH 1/3] maintainers: update for Intel ipn3ke drivers
To: rosen.xu@altera.com
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com, 
 ferruh.yigit@amd.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7I2D2x9ktcvc9GdpRDFF3pJKPLNEvgx6YIomlW7ujM4_1741698325
X-Mimecast-Originator: redhat.com
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

Hello,

On Fri, Feb 21, 2025 at 2:11=E2=80=AFAM Rosen Xu <rosen.xu@intel.com> wrote=
:
>
> Change of maintainers' email for Intel ipn3ke drivers.
>
> Signed-off-by: Rosen Xu <rosen.xu@intel.com>

Series applied, thanks Rosen.


--=20
David Marchand

