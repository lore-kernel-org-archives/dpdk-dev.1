Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DB0C5DF94
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 11:33:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFC064028B;
	Mon, 24 Aug 2026 13:33:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F334440270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 13:33:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787571228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QOio/XAQRHtLL99HmY4QXswOEHEsJ98+fLgYeIK5ncY=;
 b=NaZw7nBhe7+5IO+E2R+ZIpFPf6ofMtnWBpLJsV+xbr6ZXrbV23a1eYLeLdpR9i3ssIE+8z
 5oEzH3BFmCBn+rIjIri8yOM4xs+XNFuFr+0xNueqv7sXgimIt2n3uQXmYK3jC2uBohf9Uo
 RZPrlh4ai2muAf20gt8RNBFbEER13dk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-YodoDjd_MgO9iQGqC8Ywzw-1; Mon, 24 Aug 2026 07:33:46 -0400
X-MC-Unique: YodoDjd_MgO9iQGqC8Ywzw-1
X-Mimecast-MFC-AGG-ID: YodoDjd_MgO9iQGqC8Ywzw_1787571225
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aec6240ddbso2030259e87.3
 for <dev@dpdk.org>; Mon, 24 Aug 2026 04:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787571225; x=1788176025;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QOio/XAQRHtLL99HmY4QXswOEHEsJ98+fLgYeIK5ncY=;
 b=J2XaueI0ztlb/BF2ywIaUGLaQGNJ36TaD8S9WMhXN+pUIX5J0vXsf0pVTk82B7b7SR
 /CSAYCFm0kCbDLXPYiQHcrpxJio9Xu+JC9o9A2vHL3EfUsX2ScEXM1KDhdIZ+ItEfN+r
 tgNCYdpBkAkvajcERzop/8G+Efubx9soN/ih7uay3ieWMXet8aYQv0pudE+XuvQILyOE
 uotV1vgV9F5/62T++P/vKLH0QUAq3W8xiKJvjbvdA5IwKlAh64i2vkP9qWzu1sO3JCHN
 pX8Q4OriG3JbOjAi4+5eI5My/njCWf1y1jVqNxuV2Y6pqevoUyLj4wFrSpQjuey6/8I7
 ljeg==
X-Gm-Message-State: AFuF++n/67n9J5a5pgyz/cBKz8Dzdq3KTDC3Jis2X+zgGgUZZPB/n/ta
 7JADPSxpriJo3i6IsKZjnG9CsFaZhuU4doKyzK9W4W59PvClfMrhsR0zPF2lGnaKOUXTsyYINqe
 8onYXHkjAvfscT/QG8d5gQiF9ddPV8FoBiq5+nUMFCd78S32z5XKtCIOawRszMcZaK3FbWSNdUU
 x8kemsyT2lPSdE9o8MbXc=
X-Gm-Gg: AR+sD12mMaWb2VDUkBMbUQq6k1TxS35kguxU4C6p/5OtFyk/POT40Xtm3i7SjuJusK3
 c278MHRdXpGCd6cMLF37VC4qvkU/YWbMVcK6BFAa9iDDmaE3d9tFGpYiPHZ317iAXGzvqFCNPxE
 k8C45IfPzzE62yQR5Ku5AJHx98qd3jN+54vb06ZYvntUBb5yr8Dm40dQ2tnYD1HIUYn09gSiijx
 l4Bbh491Qr7ej573FVaujZVpbZf5sI0a3HhMItccHToWrtk
X-Received: by 2002:a05:6512:3c8f:b0:5b0:1760:facb with SMTP id
 2adb3069b0e04-5b48b8ab8edmr4748074e87.21.1787571225037; 
 Mon, 24 Aug 2026 04:33:45 -0700 (PDT)
X-Received: by 2002:a05:6512:3c8f:b0:5b0:1760:facb with SMTP id
 2adb3069b0e04-5b48b8ab8edmr4748065e87.21.1787571224532; Mon, 24 Aug 2026
 04:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260731092332.3833632-1-david.marchand@redhat.com>
In-Reply-To: <20260731092332.3833632-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 24 Aug 2026 13:33:32 +0200
X-Gm-Features: AcwNN1X20e15B-UeycgX_H4xJY1KLUL-h37WeyXVv7ER8zT1uSM8HLnI3_KSzU4
Message-ID: <CAJFAV8xri+thHo6sBbFNBNxWMZ_yRB-RX5eaoros8aNTCecdCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/mlx5: fix promiscuous inconsistency on port start
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, Bing Zhao <bingz@nvidia.com>, 
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, 
 Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aknyX3tKI6X776btQ4WIJcwMwoCnoGH6WfchgwPl84w_1787571225
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

On Fri, 31 Jul 2026 at 11:24, David Marchand <david.marchand@redhat.com> wrote:
>
> The kernel netdev promiscuous or all multicast mode could be enabled
> before DPDK starts the port. This would cause an inconsistency between
> the kernel state and DPDK's expected state
> (dev->data->promiscuous / dev->data->all_multicast).
>
> Add mlx5_os_get_promisc() and mlx5_os_get_allmulti() to query the
> current kernel state via netlink. On port start, compare the kernel
> state with DPDK's state and sync if they differ.
>
> On Windows, these getters always return false as there seems to be no
> API for getting the states.
>
> Fixes: dd4bb90bc3cb ("net/mlx5: use Netlink to enable promisc/allmulti mode")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Review please?


-- 
David Marchand

