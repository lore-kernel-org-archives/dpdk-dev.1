Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C844C982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 10:06:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AAD14029B;
	Mon, 21 Sep 2026 12:06:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 980CD4021F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:06:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789985186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I84anEzrQPuTTLM+ZDBtwwIyp0UbQcuJr4NL70Jrgi8=;
 b=f2ljR6x0TT2QrzWPNfrI4f1z7PGg/OGOZXVS79wwgYVXUal48xfdl72DbiapjQngEf9DWY
 TJPQm/yIBu5268z9E0gwDAy46G7DikscG6Ds6TbmnjB6Jp5sgpIPZI1L9g9z6xiC72DSSU
 3gfqXVzIilbgPqOEhGamkThzQBTTNSw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-_afXp18aNuWNTc-ttIwUDQ-1; Mon, 21 Sep 2026 06:06:24 -0400
X-MC-Unique: _afXp18aNuWNTc-ttIwUDQ-1
X-Mimecast-MFC-AGG-ID: _afXp18aNuWNTc-ttIwUDQ_1789985183
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a1fa5bb969so12412151fa.0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 03:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789985183; x=1790589983;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I84anEzrQPuTTLM+ZDBtwwIyp0UbQcuJr4NL70Jrgi8=;
 b=tCgpu9JJYfxUP1bytJoeT+6BffH7lsRU/DUa2h9v1PLr96U9wr0ahqiq4hbU+xIp3f
 34YQIGr3DhSHVrrPMucxLw8k4mzTbJvqBrE27V0Zbe58wPPR52/+9m4v/qO8Jgi3DYO+
 sJEG6xjBcRiC8D1E5ZoPwvZ+8NsCMDX4gy56ABVYE8TFbLAU5SpKKcWIBHBvyJQWomZm
 mrJf7MtJuwaMvAyzPnhqrB/hG9XEtxPpI6Da/0Sq1e5yNU7PVs0ralIqkUF6LVRwU6ZD
 4ExS4SWeOrDCaptzy1Xmnxtq5m8Vpl2qqX9rRLTTsm2DDY3jZltOQWC7iVMsVdBz7iEn
 5Ycg==
X-Gm-Message-State: AFuF++lzaoMOy/s8rgf1U+b0jrw055vFr4neSef4bOQCwbTiEKaeQQol
 IoT8dCD9G6qBzgAmc94xWBpkqvED82uL6c4r1u03ck0XT+TafwE8Z3Kj45yWIgEmiewEzNoJYtj
 E6FlTmsFn42ks4uLdTb7FvXIFvVxocvAjFxdLbSXqq2Bkxg+k0C2GniaB7saeh60gV7BkYldw6s
 FFkAR/Tg3eGNnEBIVKmHs=
X-Gm-Gg: AYBFou30qKu0SkWLLFsEKpGYEADpX1C0DUN5Vzosl1E/kS8qUWyOiMI+lg6Wy6zuada
 sPC9e5R/JjrBmXtn5ENTyx0O8sR9aCQrcXTghbzzwwKml+h0av+lsbBOBX7CydS2fe2uR8r5let
 H71e/SD8sb8HBPbfc9z95ipPvCcJsH5eECcElQZzpQsUFr6qInmYw22zM9acZ5GUrY+dPPgigIH
 S4IrcthsqvCWFKzaMYhSVoCXt5l1Yl2AFkh0AUlqZI1K5la
X-Received: by 2002:a05:6512:39c7:b0:5b6:1a7c:aa22 with SMTP id
 2adb3069b0e04-5b8c19860f3mr4142333e87.58.1789985183009; 
 Mon, 21 Sep 2026 03:06:23 -0700 (PDT)
X-Received: by 2002:a05:6512:39c7:b0:5b6:1a7c:aa22 with SMTP id
 2adb3069b0e04-5b8c19860f3mr4142321e87.58.1789985182471; Mon, 21 Sep 2026
 03:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260914144234.1540150-1-david.marchand@redhat.com>
 <20260914144234.1540150-2-david.marchand@redhat.com>
 <20260921083125.40120-2-rasland@nvidia.com>
In-Reply-To: <20260921083125.40120-2-rasland@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 21 Sep 2026 12:06:10 +0200
X-Gm-Features: AcwNN1X4FXfNEH-8dm2xPYrTiqnC8M4lFXzcyXL81O2Rz06aF13F8I0pHzEr-eo
Message-ID: <CAJFAV8xJV5Q4pTEwCcS4ujzj1UmLGwjRVqw2iQ2pZTjWnx_-vQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] net/mlx5: remove redundant MAC address index checks
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8T16xd_9BUIj6FkkrTbki_WF1XL7nXXttYQAnvLgIyA_1789985183
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

Hello Raslan,

On Mon, 21 Sept 2026 at 10:32, Raslan Darawsheh <rasland@nvidia.com> wrote:
>
> Hi David,
>
> =F0=9F=A4=96 This review was drafted with assistance from Claude (Anthrop=
ic) and reviewed by me before posting.
>
> In mlx5_os_mac_addr_remove() (drivers/net/mlx5/linux/mlx5_os.c), this
> patch drops both the netlink `index` arg and the Linux bounds guard:
>
> -       if (index < MLX5_MAX_MAC_ADDRESSES)
> -               BITFIELD_RESET(priv->mac_own, index);
> +       BITFIELD_RESET(priv->mac_own, index);
>
> but the Windows counterpart (windows/mlx5_os.c) still has an equivalent
> check, so the two backends diverge in defensiveness after this patch.
> The check is indeed redundant given mlx5_mac.c's index validation before
> calling into the OS helper -- but for consistency the Windows-side check
> should be dropped too, rather than left as the odd one out. Could you
> remove it there as well in the next version?

Indeed, fixed.


--=20
David Marchand

