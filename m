Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47992C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 09:21:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4669640291;
	Wed,  8 Jul 2026 11:21:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AE46E40291
 for <dev@dpdk.org>; Wed,  8 Jul 2026 11:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783502508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIsOumzJXeCWdY+zvP0C2Av05JD988o8CGrTol0DfiM=;
 b=BqMxjYQpdtWv7qSHHNP3ggCKYOLykTYesIqe4MPebV9EMORQu4UV/TtpkBOM5ARxm0UFRI
 C/abrj6sQq73mfqBbq3kyBVrYsuv5GfsS+tM2uIWdl7MF7BYXHeGrvAOAdRMa0lEzEDI+g
 siafCfxm69a9NFeH+Cu6XkS95MB83G4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-HPqw1AxTNw2kl8P3zbRoWg-1; Wed, 08 Jul 2026 05:21:44 -0400
X-MC-Unique: HPqw1AxTNw2kl8P3zbRoWg-1
X-Mimecast-MFC-AGG-ID: HPqw1AxTNw2kl8P3zbRoWg_1783502503
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4740be00302so396946f8f.2
 for <dev@dpdk.org>; Wed, 08 Jul 2026 02:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783502503; x=1784107303;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=14nksFP/tBeWZikQanZ1RiSsTa7BOsLb4T3oQlNb6eY=;
 b=D2KfoNvDdPVoxRK+qNbEJafYg3LBpim8Y82+PnlGvF0VLvyp1ePgoBxPgUiHX0S+Yn
 ZQMufH5QSPfJKocsM1f0mxEwV/0aYrt3bN8yb7jorJOjLuD0j97b4UwtDrPubdBBPiuL
 4VqGux1M9Ck4gddG6sjjgRNzEvkTtaGef+hkbugWQJ8FdbvLrKbv8hG1ukLY2DFvwKHI
 tgHL4O0vft7Zcrjbz8tMOSsddp3c0Tzpp/e4FgAsiuvbYoAY0CQzz4GOMNMI6S/DBYSX
 ZawhdGFl29Qa3yTnYsajP88Okw7sZePWx6X4hxQFZgyjP1Qlnejr61rUejk5BvdrGSFK
 YTng==
X-Gm-Message-State: AOJu0YyQXZvWJ1JY3gF8lRtdgoXvOAuEeJQwnFJLOxzMa2wpgobgZsT+
 m5MKzZOIDqHx1pDXD6sWy2ydwH3KEc7YfQlLY/6jW37rAShCjsshiUILCd9TCJ/iP2fiKE/WAh3
 td8P+ftpzVa2/5dGv5AlZkDy58yQ/ta5W1YHEUHhMokb0
X-Gm-Gg: AfdE7ckDUiVdmSi9WryduCjcwLlYG2rjSTUijW0ezlUm7ZFj4ftNR4ZX/ZkK/8Tg0iC
 JtxbPKtKNnkOPedl9IZUwsS1fcTP/C68OlLJB9Zkt5uop1ldljAgE8cEs5pALI7qVfrYfVO3lMR
 9+4TFUJSVwKH69lv1Qd5QNPdATyN3Qc246wSzr9Zmxdf3PXY2lDk5S1mXs9sx0+x4n7gAPvvl+L
 fz43+X3bqXX7Cv4B5DZmLJCaewIgMJnHXCQIQgd5L4YUs4OLtKoW0Uy/Iq21tO9FP/2n2reWoEd
 6q8fs5Ii0OD8Lt/1XnqJoZMZs5v2nuuKRrGYD5VYfxsvcXBlDXdytxNpSwe6sXV5tbO7IDMDgu0
 gLsO6SzfsZUiJYD2N8IFX9shWb40PS4ABoDDs293sA8dsXllP0KzzZ6W//R/syNqyKxJJpA==
X-Received: by 2002:a05:600c:3f0a:b0:492:3773:a230 with SMTP id
 5b1f17b1804b1-493e68e7582mr17009525e9.27.1783502503440; 
 Wed, 08 Jul 2026 02:21:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0a:b0:492:3773:a230 with SMTP id
 5b1f17b1804b1-493e68e7582mr17009235e9.27.1783502502994; 
 Wed, 08 Jul 2026 02:21:42 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f36786sm113888245e9.6.2026.07.08.02.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 02:21:42 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 08 Jul 2026 11:21:42 +0200
Message-Id: <DJT2VEID22MV.563K8JCQL152@redhat.com>
Subject: Re: [PATCH] graph: fix xstats of cloned nodes
Cc: <dev@dpdk.org>, <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Andrey Yudin" <Andrey.Yudin@infotecs.ru>, "Jerin Jacob"
 <jerinj@marvell.com>, "Kiran Kumar K" <kirankumark@marvell.com>, "Nithin
 Dabilpuram" <ndabilpuram@marvell.com>, "Zhirun Yan"
 <yanzhirun_163@163.com>, "Pavan Nikhilesh" <pbhagavatula@marvell.com>
User-Agent: aerc/0.21.0-148-g9a9a82d84ac2
References: <20260708081420.1100574-1-Andrey.Yudin@infotecs.ru>
In-Reply-To: <20260708081420.1100574-1-Andrey.Yudin@infotecs.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PzkMxVylViVBgvASQ34BjaGBGbyhlKMKr_Ts2GlVbgE_1783502503
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Andrey Yudin, Jul 08, 2026 at 10:14:
> When cloning a node with xstats enabled, xstat_desc entries are copied
> into the rte_node_register structure, but the nb_xstats field is not.
>
> As a result, the cloned node reports zero available xstats,
> making xstats unusable.
>
> Copy the nb_xstats field when cloning the node so that cloned nodes
> preserve the xstats configuration of the original node.
>
> Fixes: 070db97e017b ("graph: support node xstats")
> Cc: stable@dpdk.org
> Signed-off-by: Andrey Yudin <Andrey.Yudin@infotecs.ru>
> ---
>  lib/graph/node.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/graph/node.c b/lib/graph/node.c
> index 1fce3e6632..bb39c616de 100644
> --- a/lib/graph/node.c
> +++ b/lib/graph/node.c
> @@ -208,6 +208,7 @@ node_clone(struct node *node, const char *name)
>  =09=09=09goto free;
>  =09=09}
> =20
> +=09=09reg->xstats->nb_xstats =3D node->xstats->nb_xstats;
>  =09=09for (i =3D 0; i < node->xstats->nb_xstats; i++)
>  =09=09=09if (rte_strscpy(reg->xstats->xstat_desc[i], node->xstats->xstat=
_desc[i],
>  =09=09=09=09=09RTE_NODE_XSTAT_DESC_SIZE) < 0)

Reviewed-by: Robin Jarry <rjarry@redhat.com>

