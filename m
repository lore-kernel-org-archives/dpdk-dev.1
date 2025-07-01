Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B4CC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 14:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6317F402A5;
	Tue,  1 Jul 2025 16:48:57 +0200 (CEST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41]) by mails.dpdk.org (Postfix) with ESMTP id E6CF140264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 16:48:55 +0200 (CEST)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-4e7eefcbf08so685245137.2
 for <dev@dpdk.org>; Tue, 01 Jul 2025 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751381335; x=1751986135; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mf1eVTOmQ3YkQh0An+DVMpwRn6Ehl/bQfORfeE20gLM=;
 b=IIBN3aZ1QVdQBhbIS1mOWf0Lj1QETWNnc1reHPfkFfWa55ptzM0+A6S45M9o5GFb5p
 B1vnMiAvYpDeoxOOU4YQ5GtSn37Rqu1HzrCA+cUbwAPKI87g0ZQDKvPnhrgC9QStPzLb
 T2MpnnUv9HM3F62rBleLaxbdfvvEN2pQQb2o+5zAQPd/qfINhi/SxF3HgVDkf4KQxwj4
 I3RbxN3u28VQq152fGoIofcbSo6Nm1NWTDQO+iSE51s8N99/3+cgRwUHMX6W0gaLr2oi
 Hfl6Nyn0qVAeSVu1n3hXgIBpKQKg52Ak28LDjEoPuhuB9df5cnJZh3COVp10riULbDnN
 uuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381335; x=1751986135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mf1eVTOmQ3YkQh0An+DVMpwRn6Ehl/bQfORfeE20gLM=;
 b=V+emncP+rMBSNReNJlGkCRCnwVMyHDIlrbGrgYmxiK4mSv0XdyKMefHcQBDlPeanGt
 ridoqD4Od0d/uR9OcTTuISqdrDaUFn0+GAurHYL0wjW4FusLjJCfkf+NVARsxBEOK1+g
 sF952hNOoVOEhWvVokuKBZg6i1qrsA80vLrCGgXAAxy3tMtnni+9sXV+jueEUSBhAA30
 UEvP70sjF+Znka5DFFidDuyiYMkuF2e4YPoM5rzKqnvBPpgtrJmeu50HBq+dNEYnnoFq
 KQKvDE0TFW3LYaRXFXo0/ybpVJZWGpgZ59oHrh1Fbm1pTm9qjsBBzpGw+IyO7gt/IicF
 3qqQ==
X-Gm-Message-State: AOJu0YxK6dvF1SESyso99tIfSqUONBOo7Tqoy1GJJrS41lsiPuldQwd1
 QevCtkC9oVxIXizatPFssSGJYWxCpdpeS3FVYNy90RvkxfiIc9UGfoS9Q9ndUIzgFGp0V17oOOb
 Llr9pT8b9vhflCCegJwK5j4+dN2rdUog=
X-Gm-Gg: ASbGncvZXDLLBkVXArE7x5e5GYzBx9sbjyYfy+Y5E/6JUSqjwRV614d1GjP6huCOnIE
 yLCCAn9qJoynf6j3x14EuFirAs5iCT1J7LNSSBIo0mf2xrwmgyQwjO56huflplRZeF0/sGhl2j5
 axH7U8hh6z58AifxOQKR/2QNMljxtbvdBRnmBJaIHsDA==
X-Google-Smtp-Source: AGHT+IFnZ5TpAPoI30JtvchieWGqQ3qU6P/ObBXbt235tKmFipb/skKGQWKuuNTBX7P4HYfJg5yIO9Fl4PVlrILsdkU=
X-Received: by 2002:a05:6102:3581:b0:4e9:9281:85ba with SMTP id
 ada2fe7eead31-4ee4f71e304mr10504055137.13.1751381335006; Tue, 01 Jul 2025
 07:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250630105025.2265901-1-bruce.richardson@intel.com>
In-Reply-To: <20250630105025.2265901-1-bruce.richardson@intel.com>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Tue, 1 Jul 2025 20:18:44 +0530
X-Gm-Features: Ac12FXyBYX5sAjB5Vg-OErh825ezSPbh63uvCvrVlSR9rtGTTfNf28MdT1GmMfk
Message-ID: <CAG6-93xWTK=mWb2Y2jjQgJAFjAE83vMUUexmP=GX1BN4s0NvFA@mail.gmail.com>
Subject: Re: [PATCH] node: fix C++ compatibility errors (option 2)
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
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

On Mon, Jun 30, 2025 at 4:27=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> C++ does not allow zero-sized unions - they end up being of size 1-byte,
> which leads to C/C++ compatibility issues, flagged by the compiler.
>
>   lib/node/rte_node_mbuf_dynfield.h:78:2: error: union has size 0 in C,
> size 1 in C++ [-Werror,-Wextern-c-compat]
>    78 |         union {
>                  |         ^
>                  1 error generated.
>
> Fix the error by omitting the persistent_data field when it is
> zero-sized, since it's unusable. Any app using the field must already
> specify a size for the persistent data.
>
> Fixes: 746e8736da70 ("node: add global mbuf dynfield")
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/node/rte_node_mbuf_dynfield.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/node/rte_node_mbuf_dynfield.h b/lib/node/rte_node_mbuf_d=
ynfield.h
> index b77fdbb94f..09254c585a 100644
> --- a/lib/node/rte_node_mbuf_dynfield.h
> +++ b/lib/node/rte_node_mbuf_dynfield.h
> @@ -69,6 +69,7 @@ typedef struct rte_node_mbuf_overload_fields {
>   * 2. Overloadable fields: Fields which can be repurposed by two adjacen=
t nodes.
>   */
>  typedef struct rte_node_mbuf_dynfield {
> +#if RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE > 0
>         /**
>          * Persistent mbuf region across nodes in graph walk
>          *
> @@ -78,6 +79,7 @@ typedef struct rte_node_mbuf_dynfield {
>         union {
>                 uint8_t persistent_data[RTE_NODE_MBUF_PERSISTENT_FIELDS_S=
IZE];
>         };
> +#endif
>         /**
>          * Overloadable mbuf fields across graph walk. Fields which can c=
hange.
>          *
> --
> 2.48.1
>

Acked-by: Nitin Saxena <nsaxena@marvell.com>
