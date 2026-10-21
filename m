Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216EE606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pjVoimOk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBA34400D5;
	Wed, 21 Oct 2026 16:19:12 +0200 (CEST)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51]) by mails.dpdk.org (Postfix) with ESMTP id A039240041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 16:19:11 +0200 (CEST)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-6774639a8a4so665772d50.0
 for <dev@dpdk.org>; Wed, 21 Oct 2026 07:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592351; cv=none;
 d=google.com; s=arc-20260327;
 b=VGcQVYngdpdPAa+uzyo6GElYEwNcbej6YH4fwwcB+Xp0HGHn1l5KDu0jfO2+qMH05m
 UKMTynN7NrT/3naVzCHfDS7ExComY5bLyx/qYkVy25l+Vtr65H1Nem6xQyoakI9s80mz
 226ALt0JNWpX5s/6aE+L9oUoc4jb1rIN8LwUHJV7rfhZpLXA6HdemHxxEzvPX7s86ZS8
 Gz/WtPSkyqf2K3jKUUFwLDTUdLSvoe3UDqe77i9S74is/tllt5gbpa72rOPBD2mQrHwa
 oZYGp3rVWRKE9EXIGoO7OWY2KfqHBYV17Ho9XjPeb+QRNpEzijnHuCgGF+O/XHHp1r2v
 fXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sDTlrR8GX2j8zudCBOU8W/Egv9ZuXTypnsKNtLU+d7A=;
 fh=kTcoGTI/0YZ08okze5YVa2e/ryv+XjB3rT+qxFJUxkY=;
 b=EmXe0nv6g3HwZBs4Qk+qvw4TWowLCDsqPVK4O4L+GxITq+8l4peiNJ2waDwuCqvElB
 snFO3gMck6BecAA4DMUTYcRj3RPPv/NHe54P4VCjAQHnGiebnQApik2m1FCZHK28CtNy
 EVj3PmC8DacDMahV6k0peVGJqFfLJwG8eLVs/O1r3LbBzitQaLauauPZI4Ehi10dRCcO
 GOtyOe/Nm6IMGI1xgio16WSDtFwtcJCDFIJ4Pl72Jx5DYA85FENLB3H/Ep46zTsC5d71
 KHTPA8yYVN/ff2n2tFeotAV05FfkuexgusMEZ3oCwVeP/k/EZFR1aAkBNV9LT7emh6zD
 Xm2w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792592351; x=1793197151; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sDTlrR8GX2j8zudCBOU8W/Egv9ZuXTypnsKNtLU+d7A=;
 b=pjVoimOkjd8oWcUUqE2U6aDqNYGDlqyRddV7TwatiGxT6Zex6YLinpjr9HcXxlr0Q4
 IHmfd99WAWZg03E8Uy9Sjwt9jP0Nx8Cd20K5sUV9uwkqYN7Lt2YuSFvNEczSt5db7dKd
 l7JR11XJr9tuoHwmy/NZ8l3CAlXr9OJh5HxRvAWK1H02wnaKkCFJHbM14bKmx13P85zp
 +aIq8kdSGgXj9yFSNqDpNcasYzffcCjFTnDysI8JnPsh+dG9Pjj6UOl9tJxkUQa/n3cL
 LBj2dTO4qCNFxf5KgdqXvj44mff/fpclaekVLPnu7hIDlZURjtX0TDetzWVN4rOg2T2N
 p+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592351; x=1793197151;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sDTlrR8GX2j8zudCBOU8W/Egv9ZuXTypnsKNtLU+d7A=;
 b=hnEHcpd7JBe7o06oTIBOhcUiiq4eFYfpKm+DRe7qhlM0jAOX/FwGVM+LjIMF+Xu1Bs
 zpo1w7/tnBWTv45klTjpxK1Ryr1/YqPrtYZ43EjrKL26+TMsQwBfttCW8G7OJmEvdlb2
 qXqdtxsSiu+FDMR0zebTPa4flwzvfaBl39dFYbracD67G05nxMq5i9CB7X3brr8iJkEX
 y1PtS1/dEjtHcSMiQBu75xut1lrKrt3LKGN1fohxyH5ESNxSh4RlKN7+ruQI4xi6HVhP
 S8BwI3NfM6Oj54qX5Bkfg3O7ln8uwgMLOOjY0yzj90X+IkNl+PfKcDsrdrlTqiGpYaPK
 us5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSh/lIZidp1qOeAe4k/Xrp9d7LQtBWARmS6SuLlJ/oQPhFLH8HdfWijZR3RNJ2ptDSHSg=@dpdk.org
X-Gm-Message-State: AFq9FYLW+JlTpN3kEdxx2odMyaJ9hA0vNGm/7PA+mtcEgeKJOIQCjNlc
 P+O7q0uSi7pxJD/cNQZhmwRvilCLJgm/6yuqV3BPg+1HdofZjTYXRHoAEmsObTzPEwOpsZoUjRy
 qd81pd1DGYT1bUICWkBwa/xuGpwEGsv0=
X-Gm-Gg: AYBFou1rY9z8bbFgl1RhQwDCx8ya3GZFr1AJsYmzhH8414btKn2ca8Ra6LrgeeYcatf
 PwRYb4w7C+VQZ+PQi49pO00kSkG+Fnbm0UwbPz7r0BfGjdLVGr5LA9N89BHLtkK9nCmCvyRfzO1
 XnEqSd8zbEw4+bZX7ZK2wv7l60rXB3e/KL1FbvrUY4bH7emdcSCd/XNm4TE7OmWlW2fItZT/Rsm
 omnZIDJqDaeaSNnvcD0xmSSisGgAr9V9LCQbCrIISqwKwpPJl+gbsm6GZqchew+GXZqkR71wHde
 25fW3teSVFrXaxFgi1kJoOn4oKo99LWD7g69JtqEGO14S8+X38faSE+65xw1BDMkFaDxi4rFvwD
 rn4x3Bbwy2tXDnFsxViPrFpnPv9DEA36RnOeVHJzwfQIWnI73920eM3Ghu6A5AFu8V+q6DBzckb
 AekgbXTz/a4maGGcH/vrssbOqQD7Asah2Gg9MDMtzAn9b2gYtAqpSHQV9+EkqgQGzsRy0a0+UgB
 o8=
X-Received: by 2002:a53:d807:0:b0:679:a2c3:b2dc with SMTP id
 956f58d0204a3-67a0e5ab330mr565992d50.92.1792592350748; Wed, 21 Oct 2026
 07:19:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260830163133.1399749-1-vattunuru@marvell.com>
 <20261018095437.1531211-1-vattunuru@marvell.com>
 <20261018095437.1531211-3-vattunuru@marvell.com>
In-Reply-To: <20261018095437.1531211-3-vattunuru@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 21 Oct 2026 19:48:43 +0530
X-Gm-Features: AclHuK-zFAKC_ij07b3pgPU0SdwK2bqu_ZSLPLEsjhEEelRwxWHKdbVWfI4i0CQ
Message-ID: <CALBAE1OeBWbNbR4jtBHZ_D+4s=m_8UPDqxUycaiPhQxshBuJnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc: update 26.11 release notes for octeon_ep
 driver
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: jerinj@marvell.com, dev@dpdk.org, ndabilpuram@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 12:54=E2=80=AFAM Vamsi Krishna <vattunuru@marvell.c=
om> wrote:
>
> From: Vamsi Attunuru <vattunuru@marvell.com>
>
> Document CN20K SDP VF support in the Marvell octeon_ep
> PMD for DPDK 26.11.
>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  doc/guides/rel_notes/release_26_11.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_note=
s/release_26_11.rst
> index 235967d8c3..fd82e627d5 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -236,6 +236,14 @@ New Features
>    * Added support for CN20K DPI DMA hardware.
>    * Added support for inter-process domain DMA transfers using access pa=
ir group API.
>
> +* **Updated Marvell octeon_ep ethernet driver.**
> +
> +  * Added support for CN20K SDP VF endpoint devices (PCI device IDs ``0x=
C203`` and
> +    ``0xCA03``).
> +  * CN20K uses a mailbox to the SDP physical function for ring allocatio=
n and device
> +    control. The ``max_rings`` devarg (``1`` to ``8``) sets the number o=
f Tx/Rx queue
> +    pairs on CN20K SDP VFs.
> +


Trimmed and rearranged to ethdevPMD section squashed to 1//2 patch.


Applied to dpdk-next-net-mrvl/for-main. Thank


>  * **Added per-queue statistics API in bbdev.**
>
>    Added ``rte_bbdev_queue_stats_get()`` function to retrieve statistics
> --
> 2.34.1
>
