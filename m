Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50143CA0EF8
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 12:24:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FF9E402BD;
	Thu, 21 Aug 2025 14:24:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 45E0B402B1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 14:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755779065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FoXZ/v9vUfJTjjiPfnoUyv5revS5Dy5hFfvbYYXEsSE=;
 b=KwNc3xRYNZvFl5/cWM5ZbwI4Z00d+UsJFm261Ne5bjDiiCJ14cT73Yfup7GEzJLSLxLM2N
 bO/djP1orjquIJrYfPUTGfXUuKJNOYmedrZ/szHPd1S60HZdTnW/pb02Jw/jHZK43jJnV8
 s2syi2NVd36we5BsSThqJl54PSJ53LM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-CKEztrWgPjeKo2UGN-NwlA-1; Thu, 21 Aug 2025 08:24:24 -0400
X-MC-Unique: CKEztrWgPjeKo2UGN-NwlA-1
X-Mimecast-MFC-AGG-ID: CKEztrWgPjeKo2UGN-NwlA_1755779063
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-55ce5110173so415794e87.1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 05:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755779062; x=1756383862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FoXZ/v9vUfJTjjiPfnoUyv5revS5Dy5hFfvbYYXEsSE=;
 b=trtDFF9xlYgxlx+/nmoPvcTAX5vY9sQ1SPydKTUnEeW0cafdu3Bfbh4yafANCDfirq
 JUvUvkjoDg5qnGu7PpJArC3+t+PqNNQI5Y3AGLeTm6/vTquYbNyJQJPCrie0EYFfTLLO
 eg4RQiKYic1WMH3LSqC7KFzJyEPOK6k9VhmjvVKm+oHdU877vCRVX/ifTvFcvd/8ZD1a
 5M6i3vgMdL5kjSOndD47DdM0eb0TDBpIXvpuzCRP+VHXQHHJyGjR73DDIIZFVxXs8e+j
 J1PM2ni85JKNhXa2KaUFUD/+UqX9sMh2qzS6rm/KNEqRW8IlDRJojljl5sqr+f0WUIGh
 4t7g==
X-Gm-Message-State: AOJu0YxbtfM49ZYF4CUBy+Ul7EBqaFWe5Y+fnHJms8XoWFg1qTnvWWll
 dVHQzPlTw91kSoGesFZdKtixRnzkyDAE/qiriK4Sh+uAsVJIuAlxRd7CuMWNZi/evaIWqQ2J+DG
 TH5hGbzPbBH3D6lQXlwETQ1PY0vkdyyyL/Pqnm+3StZsoDyBIUMGZZuVB4Ir+lFjYyhHgQjIyoU
 GcJXMwozEkvS9zuIu90b8=
X-Gm-Gg: ASbGncu47chcxI1gPegXDv5/3BUi64+nxKDiaJ84wKmbeHyKWj4e1XanLwpmYvxN8E4
 PNMGuo/vmXYqMU6EnJPOlVED+wI+ai4qhZmuEqreM973A989jCBAIp0P6qjej6jvuD3tPzfSeyF
 /hbQd9jD3bwXCWHPxDBWczlN4=
X-Received: by 2002:a05:6512:3096:b0:55e:a69:f4a2 with SMTP id
 2adb3069b0e04-55e0d5487camr817428e87.14.1755779062419; 
 Thu, 21 Aug 2025 05:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuTixig8THuUnQ38XLjldDnuJxqbxEeMnS3xFf+96Fj8cqL2mFPfDyhFRusXDLaJEBBJ5E9/VF3iHAZrjEqxE=
X-Received: by 2002:a05:6512:3096:b0:55e:a69:f4a2 with SMTP id
 2adb3069b0e04-55e0d5487camr817423e87.14.1755779061964; Thu, 21 Aug 2025
 05:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <20250813073317.1352274-2-huangdengdui@huawei.com>
In-Reply-To: <20250813073317.1352274-2-huangdengdui@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 21 Aug 2025 14:24:10 +0200
X-Gm-Features: Ac12FXz0nJt0mzcHPAxJXyoBQu1s_XFpATn1cNjsT-Tv-LinwLztiEmhdWccJfY
Message-ID: <CAJFAV8wKF6vyvTeyjVriOaPo40NrT_sVQ=PoQe+UBrGagVgC9Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] net/hns3: fix inconsistent lock
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, lihuisong@huawei.com, 
 fengchengwen@huawei.com, liuyonglong@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XNEEt2755f2P1cE7TPqhWzL4o745qOHXcrSF569Zhck_1755779063
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

On Wed, Aug 13, 2025 at 9:33=E2=80=AFAM Dengdui Huang <huangdengdui@huawei.=
com> wrote:
>
> The hns3 driver supports configuring RSS through both ops API and
> rte_flow API. The ops API uses spink lock, while the rte_flow API uses
> pthread mutex lock. When concurrent calls occur, issues may arise.
> This patch replaces the lock in the flow API with spink lock.
>
> Fixes: 1bdcca8006e4 ("net/hns3: fix flow director lock")
> Cc: stable@dpdk.org
>
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
>  drivers/net/hns3/hns3_ethdev.h |  1 -
>  drivers/net/hns3/hns3_fdir.c   | 13 --------
>  drivers/net/hns3/hns3_flow.c   | 57 +++++++++++++---------------------
>  3 files changed, 22 insertions(+), 49 deletions(-)

With this change, is it possible to enable the lock annotations check?

I mean:
$ git diff
diff --git a/drivers/net/hns3/meson.build b/drivers/net/hns3/meson.build
index 53a9dd6f39..36ce93ccde 100644
--- a/drivers/net/hns3/meson.build
+++ b/drivers/net/hns3/meson.build
@@ -35,8 +35,6 @@ sources =3D files(

 require_iova_in_mbuf =3D false

-annotate_locks =3D false
-
 deps +=3D ['hash']

 cflags +=3D no_wvla_cflag




--=20
David Marchand

