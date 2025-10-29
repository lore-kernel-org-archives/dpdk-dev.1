Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF0CCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 20:32:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77924402AE;
	Wed, 29 Oct 2025 21:32:11 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 89E894025E
 for <dev@dpdk.org>; Wed, 29 Oct 2025 21:32:09 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-33ff5149ae8so292669a91.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761769928;
 x=1762374728; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2NidpLVknbTF4NN+wOlz/MYNHahkxnuA1q/oi1QnZI=;
 b=oBhI1k70mKQ3RLM+eEBeV/ILyabchEovzu+YUhi1bGeIotFv9f6DUC62U6byZNUNZe
 iFdEJeVIZm7mDWMY/OBfhNVcmoSqgOz26B2BIqXob0QbmXybj81xSvefWGqkjldAa7cD
 /czSRERrOdgCjd1XzSHfT+N3M9j92+0EvOjBxe7v7bX3F9NZ3j20QT6g8Vgd3hbXH200
 kl3MB0C/27NI3HNmI4KnLq7HpVZ5ZTXWC/AXnO06yWXtD/JLZdkDFPEm8vRTqQ3Sos5b
 sxeaK9opegBEko5AxW44/lFlgdi07cZ22e2OfYoOpUWL4I3/zlr/7fLPfFPZDTtlDKgh
 sOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761769928; x=1762374728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2NidpLVknbTF4NN+wOlz/MYNHahkxnuA1q/oi1QnZI=;
 b=WsyRQae6OIj19L8H1ypce5GQLb6TzOvMhRzxWGAtSzdRxr7Mz4/MIU+rthkrDdrQEH
 s3DNFakUpoCNt61AG4VxtwOkrXWBsExIXdetGMBYXSITJ1Abq5X+3agbf97hqwvLaUg6
 5OumnwkFAyKgA9hGGLGWdeX9n/viokdXP4ZRDvW5VpRpVNht453EQTfd/G6Xgfnw/1u5
 s1dlwuUeJZVMt7pMa55zlAxWyzidgLUerDzJ6FYsojaTBbTdIcbDw9RFcEz+gmKg+bpI
 Ucm1u2MbLpaSsItPaT0IEj6bEsi+dHagIMd7h1W60yfEFxUni9FewKL/VY8nivslO9if
 FAWQ==
X-Gm-Message-State: AOJu0YzOY21us33Gg2Y+QoNq0oGeKEMAK3M+pmZf5yvVHbKo4qEMGFBi
 I0Ow4NNefEL2xxo1TfwESUdx6xT3RmbO1QF0Pwswim8V1jxYJXm7lKxl6OYows+AibA=
X-Gm-Gg: ASbGncvHS3FQXA7T5BYGnQzmDQa1CvizQOLZFg4DxnFaqbKT7fjlWdRsGQCPom3qi5C
 mg70felGMDDTvt9DiDozGoQXop6mIe8/RGWB/L8ZW+XwiGEO7pUb791hWyMW7bJbusL3ZXe2mx6
 /FMrfKufnxTmFspbL4FyH3tNBp7MntpAJYFbiUOVeHurDDwxAR+4CKBRGiJC7h/4Ho04tdx3H3I
 9sRwPR1HR4CbfZmXRAtnKvUX2YGimt8nHZ1RNIEl+t4YBLhbSFeTj4QS5Kpl1I7CSOBfrRrXblo
 yLkncDRgJXpnvnWmCbM3NpAm96lCEG21BkS8BAZymzaMlLtMW+NZPPjqfW4mccQo4ay1DIvzap8
 Fm0E0Cur49NIGICTU0XOcRyMehdYvPpi4zd+5T2+WWQLHjGZtDvZpDgFZxMSV7gQlrf8nWnFv1S
 NvWXBsWInDLc0qgjD4/EeWdl6BJdmg3ACtJA==
X-Google-Smtp-Source: AGHT+IFgKf0S3BFcYgCud1Qmbq2K9wbeXdWF1oq7SiFJ10IqVbFzyx8CKM4sV3kSqUoZ6Sx0aEwDbQ==
X-Received: by 2002:a17:90b:164f:b0:32e:d599:1f66 with SMTP id
 98e67ed59e1d1-3404c46747bmr722621a91.30.1761769928195; 
 Wed, 29 Oct 2025 13:32:08 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3404df3ec94sm132459a91.1.2025.10.29.13.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 13:32:07 -0700 (PDT)
Date: Wed, 29 Oct 2025 13:32:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, <techboard@dpdk.org>, "Thomas Monjalon"
 <thomas@monjalon.net>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Patrick Robb" <probb@iol.unh.edu>
Subject: Re: Use of TX offload flags MBUF_FAST_FREE and MULTI_SEGS
Message-ID: <20251029133206.254d61ef@phoenix>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654A3@smartserver.smartshare.dk>
References: <aN-Use5rigF3tQc9@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654A3@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 6 Oct 2025 16:51:38 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Friday, 3 October 2025 11.18
> > Subject: Minutes of techboard meeting, 2025-10-01 =20
>=20
> > * Use of FAST_FREE and multi-buffer/scattered mbuf flags
> >   - The flags for enabling fast-free and supporting multi-mbuf packets
> > are
> >     now documented incompatible
> >   - Previously they were not defined as incompatible, but that seems to
> >     have been assumed for some usages.
> >   - Techboard discussed how best to resolve this incompatibility with
> >     regards to:
> >     - ensuring correctness
> >     - avoiding major churn to DPDK code
> >     - avoiding churn to end-user code
> >   - Options discussed:
> >     1 change definition back to not have the settings incompatible:
> > this
> >       necessitates checking drivers for correctness
> >     2 keep as explicitly incompatible and report error if both
> > specified:
> >       this could break end-user apps, and requires changes to example
> > apps
> >     3 drop the fast-free flag if multi-segment mbufs are also
> > specified:
> >       "hides" the issue, but probably minimises changes. Would need to
> >       decide whether the dropping of flag done in drivers vs ethdev
> > level.
> >       Pros and cons to both options. Needs clear documenting.
> >   - No firm decision reached, will discuss more over email. =20
>=20
> IMO, the patch [1] making MBUF_FAST_FREE and MULTI_SEGS explicitly incomp=
atible should be reverted, at least for RC1.
> That will take the project back to the state it was in before we started =
this discussion.
> And all the examples broken by the patch (because they use both TX offloa=
ds) will not need fixing.
>=20
> [1]: https://patchwork.dpdk.org/project/dpdk/patch/20250803194218.683318-=
3-mb@smartsharesystems.com/
>=20

There is still code NULL PMD which checks for FAST_FREE with MULTI_SEGS.
I think this commit needs to be reverted as well.

commit 675ddc233d68d90b3858cdb6267dd407c4e85984
Author: Morten Br=C3=B8rup <mb@smartsharesystems.com>
Date:   Wed Jul 30 14:04:51 2025 +0000

    net/null: add fast mbuf release Tx offload
   =20
    Added fast mbuf release, reusing the existing mbuf pool pointer
    in the queue structure.
   =20
    Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
