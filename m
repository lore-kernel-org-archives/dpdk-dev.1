Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A7CA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 14:45:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A778040281;
	Tue,  9 Sep 2025 16:45:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B520B4026D
 for <dev@dpdk.org>; Tue,  9 Sep 2025 16:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757429132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48o5YFPIr7JICnaYceW6Of3eUsUKmja4BBebtQTta+s=;
 b=VxygaDYd779gwwOv4IC/O5W1MU7Ujiy1xANP6Eu9v464TpxugGqh5OqSk6o/fZfYj0yFOv
 bDpmWIBnAUKHBC7Kibuh9v/S7t59dbxdaF82aJUcSlh2uwWF2FFTWp3ahlvD1E3kajNxKN
 SP9Fjac/w4PmSzJ3aeZ0B55t7oNGCYE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-FPHIIILkONW10l0REFDDiA-1; Tue, 09 Sep 2025 10:45:30 -0400
X-MC-Unique: FPHIIILkONW10l0REFDDiA-1
X-Mimecast-MFC-AGG-ID: FPHIIILkONW10l0REFDDiA_1757429129
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-55f70a5c9d1so3339915e87.2
 for <dev@dpdk.org>; Tue, 09 Sep 2025 07:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757429129; x=1758033929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=48o5YFPIr7JICnaYceW6Of3eUsUKmja4BBebtQTta+s=;
 b=OIjnmxwKAbjEEoS5+7IynuLhAzP/tNcfpLnrzF61GYKBK9riXk26KnOz5bnYdL61KN
 05emoTBANTFAFE8JeVTfg2J4aCO/EQzFuvY4koTUVkJf7dKRKtw0M7Mv+2b72ZX8RMf3
 zDeIsPQ+9Xa7Q9GuGCFT6HtXtWXypspbpqQ/bvKcygcGv2nuoPLgFra0yd3RTu/YngXJ
 3ZRpJp0QGWyyUuZSws6r4DCoc3extfhDwffDlz8SQm89/VxbVqHgE15HcF8t46OdLuEJ
 8CrkWaupVxB4MA6NTK1xk2aG/mIR+FkBkdqb9HSy/1Vr3+QfldEOV8dk1yY6vjTHsGuf
 C3BA==
X-Gm-Message-State: AOJu0YyPVT4Dm35GdCpzCTCpaWHqWqUlFewUb7znG6tGkYPG+6mjajhS
 Hyqx8rZiAdtDaby1N7C2YXBz3Js0+bI9aHFoP9dMZWG1mDaIgqNVbO/l7L7lBv3PpCF5dNCqLdS
 5nZSuE6ohvT+cEM/bRqoWqEe9NxYtAeYPUbUU3U1MUEgn/8LCYR8rpVXkaJeRhkLaQuX89Q42tz
 ULvLZhV2Yef6TbpZR0V9U=
X-Gm-Gg: ASbGnctsQnmT9tRdm+4BKJ/iK/NL+gl2r5iqSBbu6cdG+IcDDJaEi4eNun8m4HR92RB
 HaMTdtEcxHK6NweYVRhb3sOkOPaW+qBgvRfLJ0yIzkfhJp9XksbYX0s6Vn5aYpUei5wlPprScbS
 8Tdf4y1Fx5/Lzp79An79bbQtk=
X-Received: by 2002:a05:6512:3d0e:b0:55f:67db:5a1b with SMTP id
 2adb3069b0e04-56260e3b729mr3830987e87.19.1757429128749; 
 Tue, 09 Sep 2025 07:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC6h0zhArOkdK7HTcTiYT4JEGhdrEOD6UD7pPLUhPtSmwwrWj/Xs6jfWJOVL7L5aYIeOtgI+88ybcg7I8mbVo=
X-Received: by 2002:a05:6512:3d0e:b0:55f:67db:5a1b with SMTP id
 2adb3069b0e04-56260e3b729mr3830975e87.19.1757429128283; Tue, 09 Sep 2025
 07:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250909070427.2711048-1-david.marchand@redhat.com>
In-Reply-To: <20250909070427.2711048-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 9 Sep 2025 16:45:17 +0200
X-Gm-Features: Ac12FXw0WbEDPUfkEMaP9OBrQ0fKCIHshhiaIUmfJOhcaVJq5PNRtipAKT1509E
Message-ID: <CAJFAV8yLSJAEsKCfkvUJZKUskQ0jQiB-S-9ymHRDHPKsXf07yA@mail.gmail.com>
Subject: Re: [PATCH] net/xsc: fix use after free in some RXQ cleanup
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, Renyong Wan <wanry@yunsilicon.com>, 
 Na Na <nana@yunsilicon.com>, Rong Qian <qianr@yunsilicon.com>, 
 Xiaoxiong Zhang <zhangxx@yunsilicon.com>, Dongwei Xu <xudw@yunsilicon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YGWb_i8uCDyQAtWk9XNOTJbhqPPLt3YwjxIWLzdnlBs_1757429129
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

On Tue, 9 Sept 2025 at 09:05, David Marchand <david.marchand@redhat.com> wrote:
>
> Debian 12 gcc complains about a use after free in this cleanup section.
>
> [7/11] Compiling C object drivers/libtmp_rte_net_xsc.a.p/net_xsc_xsc_rx.c.o
> In function 'xsc_rss_qp_create',
>     inlined from 'xsc_rxq_rss_obj_new' at ../drivers/net/xsc/xsc_rx.c:565:8:
> ../drivers/net/xsc/xsc_rx.c:501:9: warning: pointer 'req' may be used after
>         'free' [-Wuse-after-free]
>   501 |         free(req);
>       |         ^~~~~~~~~
> ../drivers/net/xsc/xsc_rx.c:501:9: note: call to 'free' here
>
> Indeed, req may be free'd twice, as an error in the cleanup loop may
> jump back to the set_qp_fail label.
>
> Instead, skip the erroneous rxq and don't touch errno since all the code
> jumping to set_qp_fail already sets it.
>
> Fixes: 3991c890fb4c ("net/xsc: optimize RSS queue creation")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Renyong Wan <wanry@yunsilicon.com>

Applied, thanks.


-- 
David Marchand

