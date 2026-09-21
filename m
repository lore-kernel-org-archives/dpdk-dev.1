Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D52C982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 10:32:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72D254029B;
	Mon, 21 Sep 2026 12:32:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 29BB64021F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:31:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789986718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbSSsSk+HoXjFa71kti4meuVnCBEXWXXwFPKxN9sIwo=;
 b=S2supcL7Nr3hbyKF/VcDf1ZKJN+X3yN89Frmus9CgQB2AcGekxVUOgdOJEqwFzoPaBRKpP
 YsbZJEbN7FQpALGdlLgO3WIJyEnf5JRtMCOsQuVetK3PJIN3SkXc8YYZJVZoQsesxtUjwO
 iUwRk4JSpD1p0YdRpSxU0hDC+LmsScs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-zGx32dwTOFOY1IgxmyCU8g-1; Mon, 21 Sep 2026 06:31:57 -0400
X-MC-Unique: zGx32dwTOFOY1IgxmyCU8g-1
X-Mimecast-MFC-AGG-ID: zGx32dwTOFOY1IgxmyCU8g_1789986716
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b617595b4fso1981117e87.0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 03:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986715; x=1790591515;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fbSSsSk+HoXjFa71kti4meuVnCBEXWXXwFPKxN9sIwo=;
 b=qBzYXxn2FiP0D9cl9vCMfi/6D/Jd4FkcrlL5U/PSaFwZNUwLU7WFcGX7fKBFjuFbdB
 b42WRTrAfCi5VN885yXYI2ywzR9SfacjHl/xRuH3nnQhcloSLW0MLo6P98Fz0j4TPF9K
 XBgUa/agp2Noe54McWX/H+ftVrcMee8W+q0+9+/cwd3iBGbmggz8ckln+0rsmT4jurYb
 nkdQyiQcBkPwIF+gPMnisr+n89M6Xfs93kFUG4aowM1c9ELO4m3GaQWQx8WdCfIFnjXF
 riSJgf0zr+LDZGK7SFOk4P5gSyC6ZmLNcx1ZMDP0BUog2abAMaaQ9urfC/sua7c4E8jF
 ic+Q==
X-Gm-Message-State: AFuF++nb8qgZJf5zT7Ci/ZTUl+abaGA8NRffnTOBEzgI1frmqRUQ/DXp
 Gg7AD02FoLRTmHCJOHHRMsUPFx3/c0+es1a9o14TFatBwzyYtUOAY/ag0BDg8xWynZzP4QcJofG
 w1N4T2STo6Pw8dcIwkPJpsBTTrLbwkvkCQw21iAtOrNF3bpABrnYCQnO65p5M6Ddt5+10zd7QGx
 ESswSNShzcJQfVtaztIqI=
X-Gm-Gg: AYBFou0EPKH8+G22xorQiWUrFjnUwG9Dxe6zXVmTy5sXW1ajvhCaLHE8Yrqbo8HEy/I
 Do3JViidSsMFJnWuR2oesZuqYhMp87ugwcjHKfUlTkmZmX+teonyXidnaK8sMZWvV10khjVO3b3
 aPwPKmtWivUA2cCxJaNrb7oWHRR/EizcFE71BFhPs1uge7Uv4QtDw3xB1eVzNaHE8KoT4ZucRQ7
 kDKF87GLROID7EM2hvPNtIMjkWpWZOv+Kb0yW9kawUubYXc
X-Received: by 2002:a05:6512:3ba2:b0:5b4:ef51:8cfa with SMTP id
 2adb3069b0e04-5b8c17efde1mr2912642e87.8.1789986715582; 
 Mon, 21 Sep 2026 03:31:55 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba2:b0:5b4:ef51:8cfa with SMTP id
 2adb3069b0e04-5b8c17efde1mr2912636e87.8.1789986715129; Mon, 21 Sep 2026
 03:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260914144234.1540150-1-david.marchand@redhat.com>
 <20260921083125.40120-1-rasland@nvidia.com>
In-Reply-To: <20260921083125.40120-1-rasland@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 21 Sep 2026 12:31:42 +0200
X-Gm-Features: AcwNN1VRqqzx3MCJG-6FN5OOLrCiExEpICLCZOcljSgjwZ9OlnCrnalaz-eM8hA
Message-ID: <CAJFAV8yVRB5B1WfZV1AcovESefM9pL8cHRkEsML9bWPZfY8dhA@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: remove MAC addresses flush helper on
 Linux
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FnYyYY7ZwZkWH1URo5Bx4cRvj5ef18dn-k_zJ9ulmVA_1789986716
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

On Mon, 21 Sept 2026 at 10:32, Raslan Darawsheh <rasland@nvidia.com> wrote:
>
> Hi David,
>
> =F0=9F=A4=96 This review was drafted with assistance from Claude (Anthrop=
ic) and reviewed by me before posting.
>
> No functional concerns with this patch in isolation. Flagging for context
> going into the rest of the series: by the end of it, the fixed
> MLX5_MAX_MAC_ADDRESSES / MLX5_MAX_UC_MAC_ADDRESSES bound is replaced by a
> device-reported dynamic limit, but mlx5_flow_hw.c's HWS control-flow path=
s
> are never updated to match it (see my reply on patch 5/5,
> "net/mlx5: accept more unicast MAC addresses").

While I understand the comment on the last patch, this comment here
seems gratuitous.. ?
I don't get what I should change at this point of the series.


--=20
David Marchand

