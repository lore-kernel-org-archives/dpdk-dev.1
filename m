Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7CFCCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 15:18:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81F1340653;
	Tue, 14 Oct 2025 17:18:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0FB50402CE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 17:18:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760455117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1sAPFZTu2nJZrkiU9POOLPcluNYyhKSyeGQ7vjUM9c=;
 b=JGMMTuw/RSFZy4irXxYTU+NllygZA8HaY2JkGtBnX0fYDj1AyTtCwFKh26C2HdtezLo5Wr
 fVln3AWV67nwSqpaDPL9xUiDlY38qGGxm2LKRW7Ntlovzh24q/U7hXuePg0EyneQ6q+Fll
 FlN83Il4SdNqAljfGB3Gy3YDPyJOWD8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-uYqzeQFpM0iYrNX3hJAUTQ-1; Tue, 14 Oct 2025 11:18:33 -0400
X-MC-Unique: uYqzeQFpM0iYrNX3hJAUTQ-1
X-Mimecast-MFC-AGG-ID: uYqzeQFpM0iYrNX3hJAUTQ_1760455112
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-58affa258fcso3434717e87.1
 for <dev@dpdk.org>; Tue, 14 Oct 2025 08:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760455111; x=1761059911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1sAPFZTu2nJZrkiU9POOLPcluNYyhKSyeGQ7vjUM9c=;
 b=MKyZwwnJhTGvawD7bxPCil4kHbskud32uz8OPE34cO5TkBiPtZBaD/uJZ4yDU9y1Or
 yXcgHe5sznwNhBjqxm9dLWHrKHX3ebbTIbDCVL7W/EoVGzNzbHZG++GBlGIufg1cKp+Q
 IlCR8m3eXasHYbg3akXm0IWgZMaSunNmxMsrhd0BCf/e7pizwAaLsWw0L1h2zlOmWTdv
 Q8mD4SV0D0CeP7nBnTag5CH/tQjo2PdgWHFhby0LpMwJB3Qph19EtsfmaBYWx5KKU6ax
 lANBKQHppQoU3uBmk4pWdFq4em2toS9NnzgVXBu7/byunu2rJjQ7i9HUO6FZ0b8eQLU+
 TkXw==
X-Gm-Message-State: AOJu0Yxu9Bi7dR48q442Eie9Hs5tAE1OCT2bFUuFRwoqNLsAosSmYDCn
 GZiB6+hMoEY2gTMazr4VGgBonWim6IIibE1vwX9+jL+p+5YfKUC+voN2h+CeTNiIaczhJSpzzu7
 BXedGP8XRVJ0lYEvGmNtkZqhiU3y30R+fGjZscKukNXOIwso6IdoYSWPJUeGa+RXfsnKIi8Svcy
 gv/PQFmTBdSYv+OcQ+vqU=
X-Gm-Gg: ASbGncsZPMyzatT6F1aeXVkS/SH37U1FUpTPYTzXrRR/8RSzkm+M5xziVXXxMhldwYj
 1MtBrMVZIft9fcl7wSTfEVdl702sa8R+qFe3WHFjrPkoTxdvZYmzFQ1u1XxJkpQcYHObd/MB5lW
 fATO47NFhQsg1twtfviGE=
X-Received: by 2002:a05:6512:3044:b0:591:c542:3841 with SMTP id
 2adb3069b0e04-591c5423a24mr482575e87.2.1760455111492; 
 Tue, 14 Oct 2025 08:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLoAVDbucUMFXkicnd3gHJi4H+zLUgzhghAkWMzNkyHDk0LLyAhDOVH2NK9OaSGd3izM76LSKrwxvwNutblCQ=
X-Received: by 2002:a05:6512:3044:b0:591:c542:3841 with SMTP id
 2adb3069b0e04-591c5423a24mr482556e87.2.1760455110947; Tue, 14 Oct 2025
 08:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <09058cfb25d7583f67d74f09cd36673f1b10f5ec.1734661755.git.wangyunjian@huawei.com>
 <1760085696-35028-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1760085696-35028-1-git-send-email-wangyunjian@huawei.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Tue, 14 Oct 2025 17:18:19 +0200
X-Gm-Features: AS18NWD22QTB86BZPLe4IIVQvBxTuiCIW-rR3tpPTEo4TdeQC1UlQ97cv3slAXI
Message-ID: <CAO55cswe4wBEXViTqnSOb9P0EpXKtbEaRwhj9wEEb42XVcJBaA@mail.gmail.com>
Subject: Re: [PATCH v3] vhost: fix a double fetch when dequeue offloading
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, jerry.lilijun@huawei.com, 
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5DsJxvIQWNdkg9hqkA2_sb7wsNcrMAcZj9Iz3wOc-ZE_1760455112
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

Hi Yunijan,


On Fri, Oct 10, 2025 at 10:41=E2=80=AFAM Yunjian Wang <wangyunjian@huawei.c=
om> wrote:
>
> The hdr->csum_start does two successive reads from user space to read a
> variable length data structure. The result overflow if the data structure
> changes between the two reads.
>
> To fix this, we can prevent double fetch issue by copying virtio_hdr to
> the temporary variable.
>
> Fixes: 4dc4e33ffa10 ("net/virtio: fix Rx checksum calculation")
> Cc: stable@dpdk.org
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
> v3: update code styles suggested by Stephen Hemminger
> ---
>  lib/vhost/virtio_net.c | 50 ++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>

Thanks for spotting this.

The patch looks good to me:
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Maxime

