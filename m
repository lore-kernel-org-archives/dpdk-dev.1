Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8200C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 16:53:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3553F40275;
	Wed,  5 Mar 2025 17:53:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F01954025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 17:53:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741193586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oF6eVUHozJ4SvAipZWXUOMBEFIyu/HjxE8864zD/ILQ=;
 b=Zc0ABzqVTsT67yUrgJjuGmMnjckegq2CdGoooT/54aXYUBVMIiYL/6fc1XZXm/oI3+t7gD
 OCjcG1Iss9321mPfbO7sFxjp5Z9zAWBbHK3gQuy0WQL3P5dv787Fxd0WfDzJ06/lpo20IT
 QOXtfAROLirbFNvdW7FaMFTO99tYA+g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-kDyCK_ugPMGE2ucvLuj0-A-1; Wed, 05 Mar 2025 11:53:05 -0500
X-MC-Unique: kDyCK_ugPMGE2ucvLuj0-A-1
X-Mimecast-MFC-AGG-ID: kDyCK_ugPMGE2ucvLuj0-A_1741193583
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30ba3ad7cbbso5917531fa.0
 for <dev@dpdk.org>; Wed, 05 Mar 2025 08:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193583; x=1741798383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oF6eVUHozJ4SvAipZWXUOMBEFIyu/HjxE8864zD/ILQ=;
 b=oCBSHwUoScf7r7vYywBEAwlIEoQ85/g+81zqqvU7ZrHS0OV0FpfOdfJhyPJwVumXXq
 bgGj3L278CEZAzG9ZW6qRDT1LMVbEUqC5IvKyhjWNYpL/BtVBbrJaiBbbv8v2x/ZeyKE
 uJLUnW38dbqIhFGCqTRvjJZq/EoCnLDtdnDnUSH+mkcN3Ite8J56CmPZ56IhgYDefHGn
 fddKM03zHw8AO+mbSzyvKIbba+LPTPWMpohGZOyoJKIg9I6ymJXuA9TfhPY0csfDRUvv
 krUxl9Ncaum4DcpGfOoZ7z3GJLhje4c5TTCUkNsDULw8pu5cCcDwcjeg54VpZp/Ai1KZ
 yDBQ==
X-Gm-Message-State: AOJu0YybyRoa7sTKUM4wFX6EFjkEhh7WqlchOQA9xqS5ikbveBZ2/d1L
 Dr06gzfv/6BF2a385cPEq9PXJTx4ChEeojObqLsFBPLj/0ZKsMxPYQX3t5XVKLPgSUX16vdD1qA
 W6k9v1YJXT+eEg9d0iUzvbKTfoLYOmccwn2htyPZY3iNyt78GuqVEFxy7/JECnvXZlHaV9q7eLG
 FEV4Xbu/DDsk9ZEY4=
X-Gm-Gg: ASbGncuTSBNPYNcLdBfynu4loQdW0Ki9rnUNcrWY3exIVQDJZbkIDvUubs01QW7pt2U
 92nE2hFCO5zqLvn363KcSRxJT7RyjOwusn1QyOrPrpDzNoPx75QC/491mzCHo2eC2f5Q9qb+9CR
 M=
X-Received: by 2002:a05:651c:4ca:b0:30b:b852:2f87 with SMTP id
 38308e7fff4ca-30be33fc7a9mr70691fa.5.1741193582829; 
 Wed, 05 Mar 2025 08:53:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzm6rznKlfvxnv12jEltSI+uQ2zUChNVOnGU6fDUBoncnfxbd9z8zkKTj0H/TOWhYDvjc+1dgCytb7pmfYtXw=
X-Received: by 2002:a05:651c:4ca:b0:30b:b852:2f87 with SMTP id
 38308e7fff4ca-30be33fc7a9mr70621fa.5.1741193582425; Wed, 05 Mar 2025 08:53:02
 -0800 (PST)
MIME-Version: 1.0
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
In-Reply-To: <20250220165644.16421-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Mar 2025 17:52:50 +0100
X-Gm-Features: AQ5f1JqKY3hfM60f_zeGNPNBbfR80i4uooY2W3iqHAid2JI4oyKaNkr_bJsPKxY
Message-ID: <CAJFAV8y+2C7o8YiFgcWwuBpz0QPu-vNDtKqu+WPMxYRxd0dy4Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Remove unnecessary function pointer deref
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CPQ3mQQZ1zGlubU1KbipWdqu8AJrHe799_rfEFyIA04_1741193583
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

On Thu, Feb 20, 2025 at 5:57=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> A common pattern in DPDK internals is to have an array of function
> pointers. When using these pointers an unnecessary derefence is done;
> this is allowed in C because of a historical quirk but unnecessary.
>
> This fixes all instances of PVS Studio checker warning:
>  https://pvs-studio.com/en/docs/warnings/v516/
>
> This leads to a large number of warnings marked as High severity.
> This patchset simplifies the source and gets rid of these warnings.
>
> v3 - remove unnecessary paren in ethdev ip_reassembly capability
>
> Stephen Hemminger (14):
>   ethdev: remove unnecessary deref on function pointers
>   eventdev: remover unnecessary deref on function pointers
>   net/bonding: remove unnecessary deref of function pointers
>   net/ixgbe: remove unnecessary dereference
>   net/ipn3ke: remove unnecessary dereference
>   net/memif: remove unnecessary deref of function pointers
>   cryptodev: remove unnecessary deref of function pointers
>   crypto/scheduler: remove unnecessary dereference
>   compressdev: remove unnecessary deref of function pointers
>   dmadev: remove unnecessary deref of function pointers
>   rawdev: remove unnecessary deref of function pointers
>   mldev: remove unnecessary deref of function pointers
>   regexdev: remove unnecessary deref of function pointers
>   security: remove unnecessary dereference

I fixed a few missed occurences in touched libraries.
Series applied, thanks.


I noticed there are some occurences in lib/jobstats, lib/port and lib/vhost=
.
Would it be possible to have a coccinelle script for this?


--=20
David Marchand

