Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB6D103E197
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 15:17:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67DA84042C;
	Wed, 18 Mar 2026 16:17:24 +0100 (CET)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id BAAF940150
 for <dev@dpdk.org>; Wed, 18 Mar 2026 16:17:22 +0100 (CET)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-89a14be4733so376126d6.2
 for <dev@dpdk.org>; Wed, 18 Mar 2026 08:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773847042; cv=none;
 d=google.com; s=arc-20240605;
 b=daVFPI36lceud79TZiSuYUdAtdbgPZEYECaKsButj/8ZXBhjYCORZln8ZgGGO518Bb
 4xQ2slyvrrpZhITE0Byx55IUz32ecprgosv6S1ZXw/cFtrn5mklF7BK18hO2wehn0L5A
 ioP2zue2IzsC+W9TlM82Qc7tt87L8MYMgFeh3F/lg9ZV7aKgqGtlo+9uvhd+Q8C6oIYT
 v/zuYBg6PrF2QoPZg4wf0oBw+SO2Mq3i91m9WX0eLS9zeDVfN50zIk8vTs7uD/iSZyoL
 S0Wgb3mdFR/eXqvwqlogRH1HVwpQ78ZrD7hzi9wZsleujhgTaOp6+JGv5CbO4KSeBfW+
 XFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=bD+rSVQkSvFEBUg/C7QLo45vEMIZjvJaZlBz5nZKeRo=;
 fh=bOUnDOfgxj/UMpsYDvCJwcBlcJd0Ze/+q3V+lbnARnE=;
 b=eEmJtACzX5ZRMIioX4pN+c0uWjEyPTc7W8Qgyvw92oaCLdM0GcQw6FoSpC6a7P8yqe
 sGCFay9UdTFODuVlrFAa8j532wR54XgI+X3mqGOdJczbxThtheYuS3rLhI/J2q8kTqO9
 EdcqEBC6I6SPKK7Q5ImtWZVG8ItKxG8lG2BW2z9n3NzdhRnUYVIeMWPCkBFkmxzD2N+c
 6DyP3Hp0+sE0IO1e8DQhqBcIFeu3Ovo0bkydF0Kz6Xasxqpp0QvyQCesukkwwGivBrL0
 v3mldsHcYbr8iG/R7ago8UUuKtq9a5cGShcWFmaV0QwOFCPnJzUfIZs9FXL363PHr4Q6
 7IAg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773847042; x=1774451842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bD+rSVQkSvFEBUg/C7QLo45vEMIZjvJaZlBz5nZKeRo=;
 b=CjHiGhUZTunU4zaTDd3RHhLYkKBQ3ilgC+f/T9s7AaLnmrbwA1dirwT0PdMptdilkZ
 Fh2yXvs2w6bf4M0H6kbWWjQPc7xr8zYE3xtu3qS3KNAUe+GjPqhyt2gFVyT7rbnbbgaD
 JOsObXalO2+sNgmQULlpFf7G3MFCdtcbRTIhFpCwX4ptZ26L/3TIqC6GBbRokJNKD2Uw
 UbnPh52MSVyBgy0AWIMrqJkURVlEYye2/MSZ2CO/bo5Lw+G0MTtUaBrLVJ416Ub3S5Q3
 lD4G2YVNmeRyk1Yq79/Ew5PJSmdKDjcB+qJhKMIGgojL8gkFO4Nmol0lQGN5eY5OEi4T
 ty1w==
X-Gm-Message-State: AOJu0YwsNWilJ4qQislAiTfZzWC0N3SJhxQ3WJCxegLWhWI3GU9TaE1T
 zcc0j2+7HO5kCw7wVA0mj58/6LY73b6qc9bj+bBjJt01t4EfifB6dFLlj4W6EBwQgm6ofuQ+LCY
 W42Kfb1IKxepkjtji6Dk2pkmBfZbFVkM=
X-Gm-Gg: ATEYQzwGQsvGA0k3N2va139PxolktZoWYRCClf32Xqk8ERjv8NGVnq1L049pBVO16A2
 q3wHH3XcGcvS2CbNy/ViT0QWA6uGndkswI99jZA40eiP0O7/X4RyNIXfA1XHeiipbqCsARu9A2H
 ODAwGk3TCdcrgLOEntcNqszM7yTWR9iND8L2URFvXA7KMtRLQ64mzrFVBooez/UWWOzn3WwasIz
 mIQD4rLpCZY0UCsNRJiC2zap81MHFJ0TlIVhb+203FmsyPT8OdVz2hJoIBgsN2HRtSVrrOOcSz2
 qFTj
X-Received: by 2002:a0c:f10a:0:b0:89c:6b92:1c18 with SMTP id
 6a1803df08f44-89c6b921f78mr40078866d6.46.1773847041425; Wed, 18 Mar 2026
 08:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260226143341.282188-1-maxime@leroys.fr>
 <20260306133035.179709-4-maxime@leroys.fr>
 <addc71bf-e63b-4d40-8bab-02c5b55eec0e@oss.nxp.com>
In-Reply-To: <addc71bf-e63b-4d40-8bab-02c5b55eec0e@oss.nxp.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Wed, 18 Mar 2026 16:17:10 +0100
X-Gm-Features: AaiRm506yE6ZEmNv4NX1XITvcfsMEuvp1iEhtbHN7MELuQd0IjvOENlOrGIbkL8
Message-ID: <CAHHRULW+EC178o4HSo9Us2yn16xRN0pStvWuyohmmQKKA3oaaA@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] net/dpaa2: warn on Rx descriptor limit in high
 perf mode
To: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, stephen@networkplumber.org, 
 david.marchand@redhat.com, stable@dpdk.org
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

On Thu, Mar 12, 2026 at 10:27=E2=80=AFAM Hemant Agrawal
<hemant.agrawal@oss.nxp.com> wrote:
>
>
> On 06-03-2026 19:00, Maxime Leroy wrote:
> > The Rx descriptor count warning fires unconditionally when the total
> > exceeds 11264, but this limit only applies when the DPNI is created
> > with the high performance buffer option (0x80000000). When using normal
> > buffers, there is no such limit and the warning is
> > misleading noise.
> >
> > Check the DPNI options to only warn when the high performance buffer
> > mode is active.
> >
> > Fixes: 35dc25d12792 ("net/dpaa2: warn on high Rx descriptor number")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> > Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> > ---
> >   drivers/net/dpaa2/dpaa2_ethdev.c | 18 +++++++++++-------
> >   drivers/net/dpaa2/mc/fsl_dpni.h  |  6 ++++++
> >   2 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2=
_ethdev.c
> > index eb8333458e..61dcfafff6 100644
> > --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> > +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> > @@ -74,8 +74,9 @@ int dpaa2_timestamp_dynfield_offset =3D -1;
> >
> >   bool dpaa2_print_parser_result;
> >
> > +/* Rx descriptor limit when DPNI uses high performance buffers */
> >   #define MAX_NB_RX_DESC              11264
> > -int total_nb_rx_desc;
> > +static int total_nb_rx_desc;
> >
> >   int dpaa2_valid_dev;
> >   struct rte_mempool *dpaa2_tx_sg_pool;
> > @@ -904,11 +905,13 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
> >       DPAA2_PMD_DEBUG("dev =3D%p, queue =3D%d, pool =3D %p, conf =3D%p"=
,
> >                       dev, rx_queue_id, mb_pool, rx_conf);
> >
> > -     total_nb_rx_desc +=3D nb_rx_desc;
> > -     if (total_nb_rx_desc > MAX_NB_RX_DESC) {
> > -             DPAA2_PMD_WARN("Total nb_rx_desc exceeds %d limit. Please=
 use Normal buffers",
> > -                            MAX_NB_RX_DESC);
> > -             DPAA2_PMD_WARN("To use Normal buffers, run 'export DPNI_N=
ORMAL_BUF=3D1' before running dynamic_dpl.sh script");
> > +     if (priv->options & DPNI_OPT_HIGH_PERF_BUFFER) {
> > +             total_nb_rx_desc +=3D nb_rx_desc;
> > +             if (total_nb_rx_desc > MAX_NB_RX_DESC) {
> > +                     DPAA2_PMD_WARN("Total nb_rx_desc exceeds %d limit=
. Please use Normal buffers",
> > +                                    MAX_NB_RX_DESC);
> > +                     DPAA2_PMD_WARN("To use Normal buffers, run 'expor=
t DPNI_NORMAL_BUF=3D1' before running dynamic_dpl.sh script");
> > +             }
> >       }
> >
>
> how about not changing the calculation, but only the warning.
yes, indeed.

>
>      total_nb_rx_desc +=3D nb_rx_desc;
>      if (total_nb_rx_desc > MAX_NB_RX_DESC_IN_PEB &&
>          (priv->options & DPNI_OPT_V1_PFDR_IN_PEB)) {
>          DPAA2_PMD_WARN("RX descriptor exceeds limit(%d) to load PFDR in
> PEB",
>              MAX_NB_RX_DESC_IN_PEB);
>          DPAA2_PMD_WARN("Suggest removing 0x%08x from DPNI creating
> options(0x%08x)",
>              DPNI_OPT_V1_PFDR_IN_PEB, priv->options);
>          DPAA2_PMD_WARN("Or reduce RX descriptor number(%d) per queue",
> nb_rx_desc);
>      }
>
>
> >       if (!priv->bp_list || priv->bp_list->mp !=3D mb_pool) {
> > @@ -1213,7 +1216,8 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *de=
v, uint16_t rx_queue_id)
> >       memset(&cfg, 0, sizeof(struct dpni_queue));
> >       PMD_INIT_FUNC_TRACE();
> >
> > -     total_nb_rx_desc -=3D dpaa2_q->nb_desc;
> > +     if (priv->options & DPNI_OPT_HIGH_PERF_BUFFER)
> > +             total_nb_rx_desc -=3D dpaa2_q->nb_desc;
> >
> >       if (dpaa2_q->cgid !=3D DPAA2_INVALID_CGID) {
> >               options =3D DPNI_QUEUE_OPT_CLEAR_CGID;
> > diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl=
_dpni.h
> > index fcc6d4726e..82d6830acc 100644
> > --- a/drivers/net/dpaa2/mc/fsl_dpni.h
> > +++ b/drivers/net/dpaa2/mc/fsl_dpni.h
> > @@ -121,6 +121,12 @@ struct fsl_mc_io;
> >    * The stashing is enabled by default.
> >    */
> >   #define DPNI_OPT_STASHING_DIS                       0x002000
> > +/*
> > + * High performance buffer mode.
> > + * The total number of Rx descriptors is limited to 11264 in this mode=
.
> > + * When not set, the DPNI uses normal buffers and has no such limit.
> > + */
> > +#define DPNI_OPT_HIGH_PERF_BUFFER            0x80000000
> Or use: #define DPNI_OPT_V1_PFDR_IN_PEB
yes, indeed.

I will apply your suggestions and wait for your comments on the
remaining 16 patches before sending v4.

Thanks,

Maxime
