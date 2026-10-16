Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA1CCCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 06:13:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C530C40297;
	Fri, 16 Oct 2026 08:13:10 +0200 (CEST)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51]) by mails.dpdk.org (Postfix) with ESMTP id 6B99A40291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:13:09 +0200 (CEST)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-6798c4b882eso2073057d50.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792131189; cv=none;
 d=google.com; s=arc-20260327;
 b=Ao620k+z0k5hbdxSz6poiq5s9uzbY4+cWIS7G9MLakkDxqhkyWvoUZ6bkt2nrs8hhO
 Y2XkCsoVhUK+9V8V0g7r/NXz7B3enwEtXnjm/asU1paANq+/FsKF7wvtoTH4rzWI2icI
 mgFInRUbj5mOBX4IYlO9mLyWnCFKPvUS1mn+O57pFIxKgIi09vq7jypTmaWD5eIMDkg3
 SqiJqACvKbqg3AyZqkzZgYGyH432oAS3d2K+k6VQBs43QNOwpvJtuLbjJQCpd50dkTx1
 Fs6euliAH5Qf5UA6Pb9ONBZYgu8zldq42AY4L2097R1ZQKs4aRpZtj5E09sgcj8k2NnY
 SCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zy9bSlZB+RmgCFH14Q3tHGdDkKB95X5mOme2ZA24OKc=;
 fh=NiQU0xMfAPuSNQisWZgSIGj+Cte984mejIYKEHQfdhs=;
 b=YqJp/H+nVeOuuKl53ddfWypioMW4vOWtUJ8kJCyuqSzZyJ9C9OzhI6V27CcV9+IRhK
 GjFE7eB7tAeA/mNRnwM8OO9h1GVKYInXdbOBZndhW0H05RYQqk91BN8GSG6PeElBe5D4
 ju07OLHqwDnH6SBF9ZTtntJ4niZUjsMEJa9cjPzR78wuZUT6QyGkIKmoMzuLfIX0axp/
 V9q0uuJK9dFSqlvqm+AyapflSYNXt/1GURKUjjAs8593WvdmhO9xJLb/gqntuYBjrUgl
 I77ESz6t4hYX78KjPr84jW0g6OSqya56uEZsIIA9ZRT/PjBbLmBUiEv9FGalg8fylwGr
 2a0w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792131189; x=1792735989; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zy9bSlZB+RmgCFH14Q3tHGdDkKB95X5mOme2ZA24OKc=;
 b=l/pN2/yk7wubaEfNau78EVRJrvsopgy8Dsik6gY/Gg1capxQtD5fLOjKHT89LPKZjf
 HAq56RjqcUjSfeHKgT0D/UJ/WO6sAb8S1/YNC4B+m8/lYwReQbLIg2DqKw7nKwAehQn9
 +Wj1miA3Zjod6T+W/g+vBG1vmzIEFgwZ7THbI1LU0tmh+afC6K58uwN+JZMpE5C0gsYn
 8Ye/uTxt0wqiU2Wzqa4nT1gBM5HOJo6fbHblLV+imXKMxNJGzAwnmFwKg7b6tmUUXQMQ
 K5wm+pAWx3iBF0IAdMENETcCtsTge+VkabqDjI4Ef66hUZ9iIAVgW/E7RqYgwPy+8h1O
 Iq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792131189; x=1792735989;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zy9bSlZB+RmgCFH14Q3tHGdDkKB95X5mOme2ZA24OKc=;
 b=BA5eb2hU5neA/x29qLusv7kWMdGA53PbzycM8wgH/bDznK6mAxgg8geT8D5r6ALRki
 kjR8lz4pAP7TgtQplsLzu8gYuwNH7T0E2XAsiDeo+XQ2Q+FRYiHdrlzdXCOiAHjyJ+Kd
 /qEv15VD1hBG87kEzRxB//0zzPKLkDQ5z7jw8YSTVkoPAUNVvmoGq4/I87Gy17Bi9YQ8
 yLQmC/zg3w2A2ECzn0arK64XV1esI/OziBFM1YUjScAsbKKjtiZuD+6uTgjGdzV0mLDw
 k8tUEAoiu20A1XqYa6tGqpKfRzmjCS8d8zYynC8b5a7bpCF0mXqgGJynrAJSRkO+iWRC
 SD6A==
X-Gm-Message-State: AFq9FYIQXPnrte3Rz2Mca4KhaJWNA5tfTfDZgNSUnQQTPRgLWdyCXlMH
 Ta6FEdkKlFhIMdeGgfXZIdx1F8HIVmTgm4wHHvKJhCrN/PpgCqnZzoGlvNuVIw+3fXI5ajLIyU/
 sJQsJ+uFSOw0oxHATLOyEJxCkRC2mkVg=
X-Gm-Gg: AYBFou3/LU4huX5RP59/52prEu0wA3AYsBI6IOplIy+5rbfBKXsdt8PsVb/0yh6a+27
 Nl8rKobILlKLxO+kX04i3qXsxVic3LH1Xc5Wex9sS7sMJXElgIcrKlWclFCU7XfS9EBETKIP3He
 XLnT2raQXiuO9lGBj72R0lScbkDY1SE6N+olyPJ86B1HKmFtpjB+W2vJRzCIVQ6UKpq7eMBvtpZ
 IVBbvQUtEzqUxhT0vMpFPQ6kZkmHCnePLjhaQ79sb4xrq17mC2MUYzGoV7j9/3Mg+8odkySSK56
 LhushpIhC3panwCS/97uvoVahX7X/C45o+a5Q4mA+5xlJ2H/V9kmyTf90yf64qXWB83s4fT6c99
 DmVWF25fS5j7JXzAHzCKT+gFC3UAIRxzui1ah2rMWDTgmfNZU85AvnoVkGq0bGQkR5DcrtPRXRG
 CBqZ606Wx2QVynD1mY
X-Received: by 2002:a05:690e:1348:b0:674:175f:3629 with SMTP id
 956f58d0204a3-679360379c0mr8809324d50.50.1792131188652; Thu, 15 Oct 2026
 23:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <CALBAE1OdN_HxA4cRZKtsc8AJkCzQQtVV27sGhqjqXE8aSntZ6w@mail.gmail.com>
 <20260920144132.762575-1-vattunuru@marvell.com>
 <20260920144132.762575-5-vattunuru@marvell.com>
In-Reply-To: <20260920144132.762575-5-vattunuru@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 16 Oct 2026 11:42:42 +0530
X-Gm-Features: AclHuK9p44A4u2GU1IcrugQ0EqugfTNLag7tTsu2X7yQn5r47wiSurN3_TPJ4wM
Message-ID: <CALBAE1PtxM3CTCr2a_W5FvY_ziTNi6Q6LFb1OoanJLhzbWaKRA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: update 26.11 release notes for cnxk dmadev
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: dev@dpdk.org, jerinj@marvell.com, fengchengwen@huawei.com, 
 ndabilpuram@marvell.com
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

On Tue, Sep 22, 2026 at 12:59=E2=80=AFAM Vamsi Krishna <vattunuru@marvell.c=
om> wrote:
>
> From: Vamsi Attunuru <vattunuru@marvell.com>
>
> Document CN20K DPI DMA PF/VF support and inter-process domain DMA
> transfers in the Marvell cnxk dmadev PMD for DPDK 26.11.
>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  doc/guides/rel_notes/release_26_11.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_note=
s/release_26_11.rst
> index 4b3e5d995c..f9da09ab45 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -55,6 +55,23 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> +* **Updated Marvell cnxk dmadev driver.**
> +
> +  Added support for CN20K DPI DMA hardware in the ``cnxk`` dmadev PMD.
> +
> +  * Added support for CN20K DPI PF (PCI device ID ``0xA0E8``) and VF
> +    (PCI device ID ``0xA0E9``) devices.
> +  * CN20K DPI PF and VF devices can be bound directly to ``vfio-pci`` an=
d
> +    used without the ``octeontx2_dpi.ko`` kernel driver.
> +  * Added support for multiple virtual channels per device on CN20K.
> +  * Added support for ``copy``, ``copy-sg``, ``fill`` and enqueue/dequeu=
e
> +    operations on CN20K.
> +  * Added support for inter-process domain DMA transfers on CN20K using =
the
> +    access pair group API
> +    (``rte_dma_access_pair_group_create``,
> +    ``rte_dma_access_pair_group_join``,
> +    ``rte_dma_access_pair_group_handler_get`` and related functions).


# Moved this change to 3/4 patch.
# Updated as follows
+* **Updated Marvell cnxk dmadev driver.**
+
+  * Added support for CN20K DPI DMA hardware.
+  * Added support for inter-process domain DMA transfers using access
pair group API.
+

Series applied to dpdk-next-net-mrvl/for-main. Thanks
