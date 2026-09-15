Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F5C88E7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 16:26:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8171A40A7A;
	Tue, 15 Sep 2026 18:26:24 +0200 (CEST)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by mails.dpdk.org (Postfix) with ESMTP id 3658140265
 for <dev@dpdk.org>; Tue, 15 Sep 2026 18:26:23 +0200 (CEST)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4aae3149so2817079d50.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 09:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789489582; cv=none;
 d=google.com; s=arc-20260327;
 b=izXakn4CAgF8bcqz2je8E70qs+HtEg0rMeY+Vge/Qr9ci+VOt+71/eWDW4BFFk+GDx
 k04Lr0R4JmmOskReKEb5k3mdxcGyLTBxE14DvJYuTAgOQxAEkPiEebFIuEgLZ8QQeBEY
 Mn2PfKjGAbHyIUSYh1OI9XRvlYrOyeLOGJcx4CGcd3SL/uGia8R3cYr3FXKBAYf5Pymw
 Y5F4o6DdygTZb8DPToJxkR75cC+nc8Ml7k+KJ7SXRmdgZH1ou0vdhyL4UWrT7bzJYmEr
 5T6oR7tR9iC/LLERX5drfi6fwdcn8AaNaCuSkgnoLtfulDoz+eefxxK8yvKMJtwCyNe8
 sRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y5HZc2G3H/xSVFPmlEzWkRuprl1D18iNY+qsCifWq5w=;
 fh=Ycc9ExfDtMbXQ+3R+bp7iKHo7sEk8ZNnQ2YJKamiGsA=;
 b=AB1jB5EpmYZlwuaGz1UxAsSwiwG//7k2+GhTazF4HOEWNqDI0zQgoHLBYuyVWW3Tvh
 o44hH4tW55+MOHEYOLbnqzLzQDf4UUscPfJcIr3aKhBIoK+HgTOuccSkdtkLt1qIYsLD
 eDTXHKt4xTGzy7NuZGhMLuZgHhx2cpU4rkXlaOaP7AR/DZc2LdC9tyl4GEbax3bAWLfb
 ZR/rpqbKDPIz+oqQbR+YpXUe/bz+4bPlCjeyLCL9qGhSqEPw4sWHMuh+ubzEIdbEXzNo
 ZVEYspEvEibBq0Mh8QS09xJMFPVinvT6X0KjO8jo+bQtkLhHj4pPGhDD7uiBPC8AmBf+
 +DHw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789489582; x=1790094382; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y5HZc2G3H/xSVFPmlEzWkRuprl1D18iNY+qsCifWq5w=;
 b=mfNuorQ6R/F8e9hIfoKP7HRnwqTuvzGG5vX3UCmaxhs+yx6/OjlXd6dvWeZ8yzUSos
 Dw01PMLSzRTJPRSMtvuAq9DgRFq54J/27VxCKKJKAo26m7MSquu2i+ZMKInXgs1zcT5A
 CXkuum7i89dWJdaonBM7Lk+awnIoE+H/glODqq6FtMG/kDv3j6mtHaYnlSgFpVDU3+KP
 wRjb7NintuAP9ZtYFkMZEua+HD/FqBjE0TQdB26AmIE29E2ba9uEA/x3fd9X/dD5qify
 G0eIod90NApjBjkf6XM4XdHQh5ZR8y1tp0MLfn3y+LmuL3R61oyTiQ4Dsvj//PDz7NYF
 PwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489582; x=1790094382;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y5HZc2G3H/xSVFPmlEzWkRuprl1D18iNY+qsCifWq5w=;
 b=RAXBEiRho6i5zDvmciWqfxqp0zuX4Yn8arwdiZuvte1KmEAGVgkIS3KmtxxsjvcK8Y
 IG1EZ/TfTSkp78f1RF5k+rrJEi1UsAfZIhFnU8ALe6QyBBcwzBN5Uhp4XI+YBR0eB0bk
 Fs0KALkb8KvXCizojD5xdlAq66IeiTtis90rPjjx2/nD6w76VvHkEPiEHcE8pmfyWV1E
 dncmhi0A/zNYWu1RqHP4BsVLP54MEwBicjKNwpGBzvJjMwueShS4X89FU+H0onIOjr/A
 HsCs68tcwNm453Db7/X38nyvXkU2MSqKYC96aKsv5zaURFHB5YgWtWCMhSc/7r6NsQGt
 sFxw==
X-Gm-Message-State: AFuF++lgxVDw1+UU4WvoXcTCBpV43npLU6Z6iE5nNxzqp18yEtvwi1DM
 aMDHcwguP5fOBotq3emEEK6pNTzOXaX7LyFxwDEwCjdkc/5j1HGu1q+nlUTHjIaqVfx0gr9Rv9U
 ZTFpJQeC86YK+Dot0ksIDOtcsltm7nsU=
X-Gm-Gg: AYBFou34YF7uJse4842abxmV9uPMVXTqMODGzBA3s9bZFQGjTTwFCd8frcJXC9FmHgQ
 +szAKyZkiSJges+DZhTvE/g1D26GiLuXdtN3Otmct3t0uHtkdeqGjXjVH5U67UpeRJjmkPAiLWG
 ur7HgjnpyL9MeSaAkm26LVCmgfAw7Ns48647V4MOq7lCGAKtyJr+YhZ5PYzCSPYbaddYLBNmUsR
 1SyaHbGvDMvFznOXqUEHgaBjrahVcPKsZ51Q/VRwJp0oSdvvcG+lGh9MytqcM7ey59uTQ04XSJJ
 2vnb/rMBz+LnZyurCa0QBo0fFdRsQy+5gzDjkfs1wqYIugN7YUNaHNiQclipVAw/eSGEACQrIcA
 ZlvWwGumccvI9W8XefJoOiNBl8KFZRRPrKwvUFy303pooC5u4pX+rvcvitS4gN1ZId3kFxj5wKV
 R1fxu1KpQVyoSZSzMf
X-Received: by 2002:a05:690e:d0f:b0:671:203c:2fce with SMTP id
 956f58d0204a3-6714dfeab5emr3192288d50.17.1789489582428; Tue, 15 Sep 2026
 09:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260902155722.577747-1-stephen@networkplumber.org>
 <20260902155722.577747-7-stephen@networkplumber.org>
In-Reply-To: <20260902155722.577747-7-stephen@networkplumber.org>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 15 Sep 2026 21:55:55 +0530
X-Gm-Features: AcwNN1VxdP5yW78AcYcguHHsUStFDZamQdjtcLwX3Or7Bs4VZk3OotXHNWwc68M
Message-ID: <CALBAE1NWjPFq7GHdNWF6BFcjgmJTjUCPHGHorO-G+56k_Qo9dA@mail.gmail.com>
Subject: Re: [PATCH 6/6] eventdev/dma: promote adapter API to stable
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Amit Prakash Shukla <amitprakashs@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>
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

On Thu, Sep 3, 2026 at 2:33=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The event DMA adapter was introduced in v23.11 and its interface has not
> changed since.  Promote all of its functions, together with
> rte_event_dma_adapter_caps_get(), and drop the experimental warning from
> the file level documentation block.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_11.rst |  2 ++
>  lib/eventdev/rte_event_dma_adapter.c   | 30 +++++++++++++-------------
>  lib/eventdev/rte_event_dma_adapter.h   | 19 ----------------
>  lib/eventdev/rte_eventdev.c            |  2 +-
>  lib/eventdev/rte_eventdev.h            |  1 -
>  5 files changed, 18 insertions(+), 36 deletions(-)
>
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_note=
s/release_26_11.rst
> index 5db51c4f6a..4004f36398 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -111,6 +111,8 @@ API Changes
>    * link profiles: ``rte_event_port_profile_links_set``,
>      ``rte_event_port_profile_unlink`` and
>      ``rte_event_port_profile_links_get``
> +  * DMA adapter: ``rte_event_dma_adapter_*`` and
> +    ``rte_event_dma_adapter_caps_get``

rte_event_dma_adapter_* account rte_event_dma_adapter_caps_get`. so
remove this API.


Series-Acked-by: Jerin Jacob <jerinj@marvell.com>


Series applied to dpdk-next-eventdev/for-main. Thanks.
