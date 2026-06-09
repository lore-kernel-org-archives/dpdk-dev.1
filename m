Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B502CD8CAD
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 04:52:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB97B402AD;
	Tue,  9 Jun 2026 06:52:42 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 45AA6400EF
 for <dev@dpdk.org>; Tue,  9 Jun 2026 06:52:41 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8cce77eb087so45316266d6.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 21:52:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780980760; cv=none;
 d=google.com; s=arc-20240605;
 b=XXnI6XEqJeXOo6b03wKrHpFuSwuL+vYoLWTtyVeZP1oDh8OmTuDB4+35VuZ+Af8LzT
 ZTcMqc/QGg2fvDeQBKP9FBy2sQCO0DxyQZ49lyfzi2X0DlYBjA64i/m9ji2Vnm+4hQP+
 TjkGdYiFPrEBeuIqnAs8yCIQfJmSzPNyEvv6ks4K9g/8mLLtozZLG6qyAo6h6JOoq0t+
 ZKWwdMHlpZ6D3fwWoogKNkhqNBfQSorLpMM5cf22yYHW3roPDQru2rHlnBilTIerl1Nx
 fHltTt40zcja6r4S42b/2Q39sgss1Pj2TaokxGIFjupri5hNKCuk9siTbKVUGM0kmldj
 0iYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XQZA/cQnTMUdQiMAZxKSNO1iL8bFjvy4PoLHjDJb2OU=;
 fh=qz2qhFpH5Yl3gdEz0IGRS9BR6GmrK2DjTbC1i8AMvYM=;
 b=VskDt+vMu3lvEZHBpFvQ+fCIOOHeAiEG2V48TtQsbFkH9Tq4D2dFpcisc8Iu4MF1ag
 QwDaEz54forLDfGzoGCDw2o0CBFeucAGJU5kGO2aUFHwW0so5LU5tAiP9L5Ksfj0VbRN
 BcVrEyyQAvmjCWENF0Hv2K/pSbgV7lNgNXP2dsOXGMAuUPD8tA+nXMZzp5josT5neO1G
 wRg0/DrmxgojVdSYqMZrVItmu7fgyfLglbWE2HoxvFDSYInTFO4+tq8bgS4AQwX5Og3B
 5VMdqqUflyPnbEyyQWZCcL/pRA9T/xw1ZZu9JAh8xnVRzeZmOqGXGQ4RCYoggKmvFV48
 7IKw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780980760; x=1781585560; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQZA/cQnTMUdQiMAZxKSNO1iL8bFjvy4PoLHjDJb2OU=;
 b=ShNc6Kmjq0crMfMAuxxhCP3u9PruDnh4dP7pDVpZG0MJyGmD8UxizbKTBfhKXJSvoY
 enEFzdcTjOr04024jBVuQTvdRkv9iGAnnzvJP6FswbBQ2vVmJxPxO3N9vpPsPWXVJBQ0
 wqjrx5umC7afxlY31SQ/RNe/PSAeDf/zz7QaiPHIP4uEkV3hXR96NRe3sreHFUHVhYpi
 0FBNGwo7Y1Ob4brdvlC8cj3UEE02H6BU1wz0Ao1+GV8QHEzsgA02kS4Uh1IjFYK4bwTX
 z4cJTNyNaTDxYkU1DyM0fouF1Ba1WyR0q8DzzisGgfTFk6aUDOM0u8qG4GzJ4gbalhX2
 IiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780980760; x=1781585560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XQZA/cQnTMUdQiMAZxKSNO1iL8bFjvy4PoLHjDJb2OU=;
 b=hfw76k7jMJuabFBv8Sg6jPsCN8v0i0DTavO3/dHBNM3sJ1Dw2IBByWRd8nrFn2wQzq
 QY5WnzkXkL/rqZRWmHUb4l/hNO2FKd9xqRUNL5rRRIOXC0zZvMhazOw5d9xetfEt3c6p
 QBMgQvhwM/C78QQquSmNFw6BYQpmvonlNYoDLYCetj5dLNJvb7a9qdJlKmb0xTTC5U2Y
 cADBXySUUN89A8IOfIpYV/RU5o2Rry3BT5NAMvdfUz6CFmnQwoi8JB9p3/IqLRWomZq/
 MZMfX7RdFdu3n2hBmKxhPNLfJEpLlBFUq8mvIS/aJQyOhqR8fw9+gL95/GYLl17plrZe
 ekRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bcHgIQEOtTZ+hmU+nXlENcfXDcw+YGnK/J1AxiS2ZEgd0WEiC3qL1hfD43bdF8tk/LSY=@dpdk.org
X-Gm-Message-State: AOJu0YxnhMVZbNqGXRzNa4AB7qq1aLreEWAPAYlzO4dkWPGO3GLQrTW/
 JP0AvuUrpAP9nC6iby+ZKyM8B22cOMKNJiZVm9WZZoYBx+mWnFWY+AGRQz6YzHk5d03S+ifJug4
 BP5j1vkBBkIOYFYx+qhKe3DM+dR303qA=
X-Gm-Gg: Acq92OEtlO4CX8VNWUgSBWXSmN9nIKP9Ef2z/saVGGEgEZadZGWKnX1teaf3WYS/Xbm
 fV/u/Ww9mKfspOLyRppFLmycJZDGRyG/0vsCXkatx205zZFiGUD6Q13kHLmw6BtMCivjZHVmDKp
 oJeZwBNDhc5WXicW8h/bcF1Aa0D0l8xAL3TfRISRV7+hfY/PK7I2qla51OjRLokTcIzz+piqYCn
 o4DHbb4ACkXYXAWYHm9L+Wm0Ubv9CzT+zPTGFVPtpB1vsNiAoIue4ocYM7pAl6079tj0vhrmikv
 S7tUe1Nu0ayITw==
X-Received: by 2002:a05:622a:8d04:b0:517:a02f:171e with SMTP id
 d75a77b69052e-517a02f1fb5mr224096031cf.30.1780980760527; Mon, 08 Jun 2026
 21:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260519101232.541102-2-rjarry@redhat.com>
 <PH7PR18MB507823DB7B8D54E605C4437CC8002@PH7PR18MB5078.namprd18.prod.outlook.com>
 <DIMZ41ANY5TQ.3SXX22QGRY92R@redhat.com>
In-Reply-To: <DIMZ41ANY5TQ.3SXX22QGRY92R@redhat.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 9 Jun 2026 10:22:14 +0530
X-Gm-Features: AVVi8CfZqcf6WIzYsgmwsmAUNxTUVWDr9dv3NOPPeplSPcGzYXFmzezScNlHVZU
Message-ID: <CALBAE1MxGQt0MdNDsJNp0H8XkRnvy6JW2oyCbpos9dcQQUB8=Q@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH dpdk] graph: replace circular buffer with
 priority-based bitmap scheduling
To: Robin Jarry <rjarry@redhat.com>
Cc: Jerin Jacob <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Christophe Fontaine <cfontain@redhat.com>,
 David Marchand <david.marchand@redhat.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Maxime Leroy <maxime@leroys.fr>
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

On Wed, May 20, 2026 at 3:20=E2=80=AFAM Robin Jarry <rjarry@redhat.com> wro=
te:
>
> Hi Jerin,
>
> Jerin Jacob, May 19, 2026 at 12:25:
> > Some high-level comments:
> >
> > 1)What will be the performance overhead for graph walk.  Try
> >   app/test/test_graph_perf.c and l3fwd_graph
>
> I have made some measurements. There was a regression caused by
> systematic access to a cache line. This will be fixed in v2.

Thanks. We will review the v2.



> > 2)If priorities are same, Does it have similar performance with
> >   existing code?
>
> Yes with v2. I have added a topo order as a fallback when all priorities
> are equal so that it behaves as previously.
>
> > 3)Does it have any effect on packet ordering on egress.i.e for a given
> >   flow ingress order !=3D egress order
>
> Some independent flows "may" be reordered but that depends on the
> topology, not the graph walk algorithm.
>
> For example, the following graph:
>
>         +--------+
>         | eth_in |
>         +--------+
>         /        \
>        v          v
>    +-------+     +---------+
>    | ip_in | <-- | mpls_in |
>    +-------+     +---------+
>        |
>        |  ,------------.
>        v  v            |
>    +--------+     +----------+
>    | ip_out | --> | ipip_out |
>    +--------+     +----------+
>        |
>        v
>    +---------+
>    | eth_out |
>    +---------+
>
> If you receive the following stream of packets in "eth_in":
>
>    1. Eth/IP
>    2. Eth/IP
>    3. Eth/MPLS/IP
>    4. Eth/MPLS/IP
>    5. Eth/MPLS/IP
>    6. Eth/IP (needs IPIP encap)
>    7. Eth/IP (needs IPIP encap)
>    8. Eth/IP
>
> The "eth_out" node will see:
>
>    1. Eth/IP
>    2. Eth/IP
>    3. Eth/IP
>    4. Eth/IP
>    5. Eth/IP
>  * 8. Eth/IP <----------- reordered before 6 and 7
>    6. Eth/IP/IP
>    7. Eth/IP/IP
>
> With the FIFO circular buffer and with the new bitmap priority scheduler.
>
> The only difference with the bitmap system is that If you set "mpls_in"
> and "ip_out" higher priorities, the "ip_in" and "eth_out" nodes will be
> visited only once.
>
> > If there is performance regression we may need to consider new
> > RTE_GRAPH_MODEL_XXXXX to enable this feature
>
>
> --
> Robin
>
> > Times approximate.
>
