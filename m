Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7735C0219D
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 21:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86977402EF;
	Tue, 11 Feb 2025 22:02:50 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 503684027C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 22:02:49 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-21f6022c2c3so2783735ad.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 13:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739307768; x=1739912568; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J65BkbFrcrpPk//lavehylFosbm7vHN/uZWr1GJmD2c=;
 b=Hi6y+gDO+3YrFFZP1kt6YSVuGKkHPCOzFdVRvyvK7Cv2fULPvEfkDJuRBYGFer+pVh
 GWrM7reBcCG1+NxnlwJDze5Jb3f+04uxbhaukbdZyxwpz/RqHaebDGSetzK4KZtZ4pJy
 z9HmndSOugoV0A7ww2RO9vLfsns77OnozFgNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739307768; x=1739912568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J65BkbFrcrpPk//lavehylFosbm7vHN/uZWr1GJmD2c=;
 b=Fo1LEO1GTfhXT6oggfbdXQA8gNs8MokZKN/AKb+0If3cRlevIOAy+Ro7OiAbtMcrEx
 XBesPDGTPgbHCb8zrqcIkfChh493ezoIYn0v+c+4icxcXlJsjvUWMrJiiAokgPNcyajd
 2wmAqWetsIDsvPs1y/9Q9qVIBXolRk5qok8yR+oKEWQkAM+MO/TcnIkB+in/DcaVkNQY
 mtyLSALTmmQGXFTt7JPCRxepaZV66dOVa3zJon9ZMXubbX3KqXfWOfqf8RRlGLks6Xh/
 mmjTFPPXW4oxLjwLge2wGrE12GLCK/wuvzCnqRgacimxhMrDtED8GbsauI9m4H2+4/lH
 updg==
X-Gm-Message-State: AOJu0YyXiPzbjzPDMwWSGrt1167tUm2J/WCTlNY6j8DWWYpG+fWZqjOU
 pzjVEwCeU1XLTNTy2lbveTqaPmLQGydX3aKhEBQnBDkPGYkTH+ihhu8ew0Oc9enYWzyCLVdR75z
 5OyDPVfUyUc+cwOyvhwJhkBUC+BcO+XRcH8hBqg==
X-Gm-Gg: ASbGncvvY8lFVezkEvrMgc2Y/ZRqMfTlg88SnaRgnve/VZ++ew15tZG9w2fItmOeOwC
 l6ZBEZcWLFwz8gOMuSGWmLs47XGcHmcAMOu/kUSHuV1rIZr4OM3ukMhccmUU5SVAlXW5Y4Bluq+
 H8uHZB61UGWVNa1XCFH5HjDxXcqwlSQw==
X-Google-Smtp-Source: AGHT+IGyqyT12yGYBxWa+RQg9+Jp5YolWKjyCQn9HY16qiNWPniwBhjfIE9HYPn0KZAsRsiVLyjczbNxxd2QVgMRdNs=
X-Received: by 2002:a17:90b:2f4b:b0:2f6:e47c:1750 with SMTP id
 98e67ed59e1d1-2fbf5c60374mr863889a91.13.1739307768363; Tue, 11 Feb 2025
 13:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
In-Reply-To: <20250211173720.1188517-1-stephen@networkplumber.org>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 11 Feb 2025 15:59:34 -0500
X-Gm-Features: AWEUYZl3XOrr_Ikr7Ln-f2ePWQK3TLdw1R9C6tTZYHCDTYT8VKHzlMvLt0LsZGU
Message-ID: <CAJvnSUCdb0iZFWRZcRpVkhiE+j5HXeWX02Msh-erNHMv_T8u0A@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] memset security fixes
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b05722062de425a0"
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

--000000000000b05722062de425a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is a performance failure for Intel E810 for this patch, but it is
coming from dpdk mainline, not this patchseries. I think something was
merged recently which bumped up the variance on forwarding because the
periodic runs on the E810 for DPDK 24.11 are stable, but all the current
runs on new patches which are applied on mainline have a significantly
higher variance. I am about to look into this - once we have it sorted and
stable I will request a retest on this patchseries, which will remove the
fail on Patchwork. I will pick up any ensuing conversation on the CI
mailing list as I don't want to flood your cover letter with discussion
about another patch.

On Tue, Feb 11, 2025 at 12:37=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> This series handles memset related bugs indentified by PVS Studio.
> The root cause is that Gcc and other compilers are free to
> optimize away memset called before free.
>
> Most of the places memset was being used like this were bogus;
> probably some developer debug habit, and can be safely removed.
>
> v6 - add stable to the ntnic bug fix
>    - drop elimination of void cast in ntnic - unrelated change
>    - rebase
>
> Stephen Hemminger (11):
>   eal: introduce new secure memory fill
>   eal: add new secure free function
>   crypto/qat: force zero of keys
>   crypto/qat: fix size calculation for memset
>   crypto/qat: use secure memset
>   bus/uacce: remove memset before free
>   compress/octeontx: remove unnecessary memset
>   test: remove unneeded memset
>   net/ntnic: check result of malloc
>   net/ntnic: remove unnecessary memset
>   devtools/cocci: add script to find problematic memset
>
>  app/test/test_cmdline_cirbuf.c                |  2 --
>  devtools/cocci/memset_free.cocci              | 20 +++++++++++++
>  drivers/bus/uacce/uacce.c                     |  1 -
>  drivers/compress/octeontx/otx_zip.c           |  1 -
>  drivers/compress/octeontx/otx_zip_pmd.c       |  2 --
>  drivers/crypto/qat/qat_asym.c                 |  5 +---
>  drivers/crypto/qat/qat_sym_session.c          | 27 +++++++++--------
>  drivers/net/ntnic/nthw/core/nthw_hif.c        |  5 +---
>  drivers/net/ntnic/nthw/core/nthw_iic.c        |  5 +---
>  drivers/net/ntnic/nthw/core/nthw_pcie3.c      |  5 +---
>  drivers/net/ntnic/nthw/core/nthw_rpf.c        |  5 +---
>  drivers/net/ntnic/nthw/core/nthw_sdc.c        |  5 +---
>  drivers/net/ntnic/nthw/core/nthw_si5340.c     |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_cat.c    |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_csu.c    |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_flm.c    |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_hfu.c    |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_hsh.c    |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_info.c   |  5 +---
>  .../net/ntnic/nthw/flow_filter/flow_nthw_km.c |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_pdb.c    |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_qsl.c    |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.c |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c |  1 -
>  .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.c |  5 +---
>  .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c |  5 +---
>  .../net/ntnic/nthw/model/nthw_fpga_model.c    |  1 -
>  drivers/net/ntnic/nthw/nthw_rac.c             |  4 ++-
>  lib/eal/common/rte_malloc.c                   | 30 +++++++++++++++----
>  lib/eal/include/rte_malloc.h                  | 18 +++++++++++
>  lib/eal/include/rte_string_fns.h              | 27 +++++++++++++++++
>  lib/eal/version.map                           |  3 ++
>  33 files changed, 129 insertions(+), 108 deletions(-)
>  create mode 100644 devtools/cocci/memset_free.cocci
>
> --
> 2.47.2
>
>

--000000000000b05722062de425a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">There is a performance=C2=A0failure for Intel E810 for thi=
s patch, but it is coming from dpdk mainline, not this patchseries. I think=
 something was merged recently which bumped up the variance on forwarding b=
ecause the periodic runs on the E810 for DPDK 24.11 are stable, but all the=
 current runs on new patches which are applied on mainline have a significa=
ntly higher variance. I am about to look into this - once we have it sorted=
 and stable I will request a retest on this patchseries, which will remove =
the fail on Patchwork. I will pick up any ensuing conversation on the CI ma=
iling list as I don&#39;t want to flood your cover letter with discussion a=
bout another patch.</div><br><div class=3D"gmail_quote gmail_quote_containe=
r"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 11, 2025 at 12:37=E2=
=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org=
">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">This series handles memset related bugs indenti=
fied by PVS Studio.<br>
The root cause is that Gcc and other compilers are free to<br>
optimize away memset called before free.<br>
<br>
Most of the places memset was being used like this were bogus;<br>
probably some developer debug habit, and can be safely removed.<br>
<br>
v6 - add stable to the ntnic bug fix<br>
=C2=A0 =C2=A0- drop elimination of void cast in ntnic - unrelated change<br=
>
=C2=A0 =C2=A0- rebase<br>
<br>
Stephen Hemminger (11):<br>
=C2=A0 eal: introduce new secure memory fill<br>
=C2=A0 eal: add new secure free function<br>
=C2=A0 crypto/qat: force zero of keys<br>
=C2=A0 crypto/qat: fix size calculation for memset<br>
=C2=A0 crypto/qat: use secure memset<br>
=C2=A0 bus/uacce: remove memset before free<br>
=C2=A0 compress/octeontx: remove unnecessary memset<br>
=C2=A0 test: remove unneeded memset<br>
=C2=A0 net/ntnic: check result of malloc<br>
=C2=A0 net/ntnic: remove unnecessary memset<br>
=C2=A0 devtools/cocci: add script to find problematic memset<br>
<br>
=C2=A0app/test/test_cmdline_cirbuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 2 --<br>
=C2=A0devtools/cocci/memset_free.cocci=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 20 +++++++++++++<br>
=C2=A0drivers/bus/uacce/uacce.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0drivers/compress/octeontx/otx_zip.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 1 -<br>
=C2=A0drivers/compress/octeontx/otx_zip_pmd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 --<br>
=C2=A0drivers/crypto/qat/qat_asym.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +---<br>
=C2=A0drivers/crypto/qat/qat_sym_session.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 27 +++++++++--------<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_hif.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 5 +---<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_iic.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 5 +---<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_pcie3.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
5 +---<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_rpf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 5 +---<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_sdc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 5 +---<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_si5340.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
5 +---<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_cat.c=C2=A0 =C2=A0 |=C2=A0 5 +--=
-<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_csu.c=C2=A0 =C2=A0 |=C2=A0 5 +--=
-<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_flm.c=C2=A0 =C2=A0 |=C2=A0 5 +--=
-<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_hfu.c=C2=A0 =C2=A0 |=C2=A0 5 +--=
-<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_hsh.c=C2=A0 =C2=A0 |=C2=A0 5 +--=
-<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_info.c=C2=A0 =C2=A0|=C2=A0 5 +--=
-<br>
=C2=A0.../net/ntnic/nthw/flow_filter/flow_nthw_km.c |=C2=A0 5 +---<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_pdb.c=C2=A0 =C2=A0 |=C2=A0 5 +--=
-<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_qsl.c=C2=A0 =C2=A0 |=C2=A0 5 +--=
-<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c |=C2=A0 5 +---<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_slc_lr.c |=C2=A0 5 +---<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c |=C2=A0 1 -<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_tx_ins.c |=C2=A0 5 +---<br>
=C2=A0.../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c |=C2=A0 5 +---<br>
=C2=A0.../net/ntnic/nthw/model/nthw_fpga_model.c=C2=A0 =C2=A0 |=C2=A0 1 -<b=
r>
=C2=A0drivers/net/ntnic/nthw/nthw_rac.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 4 ++-<br>
=C2=A0lib/eal/common/rte_malloc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 +++++++++++++++----<br>
=C2=A0lib/eal/include/rte_malloc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 18 +++++++++++<br>
=C2=A0lib/eal/include/rte_string_fns.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 27 +++++++++++++++++<br>
=C2=A0lib/eal/version.map=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++<br>
=C2=A033 files changed, 129 insertions(+), 108 deletions(-)<br>
=C2=A0create mode 100644 devtools/cocci/memset_free.cocci<br>
<br>
-- <br>
2.47.2<br>
<br>
</blockquote></div>

--000000000000b05722062de425a0--
