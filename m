Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F1CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 16:01:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FD7C42797;
	Thu, 16 Oct 2025 18:01:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 140EA41148
 for <dev@dpdk.org>; Thu, 16 Oct 2025 18:01:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760630503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LvHDvJozMzHMD+9Occ7DtXcuyX5yzVna0pZxqDJWcMg=;
 b=bUENLX1u4MN35Tpudb+AFfUlknc1dcFY9I/yd0R4A+G8VJkQYv8jQe7bofTSJ8wzDkfKPe
 9O0Gh7W5YM0i2+KdwE7XBjXDeu5rOzRV67pONaW8MVwtQ7LPLrDKXFnoVGQFDilxNz/9Gc
 FdIs8ubxkOdVljSMWVidDs+RZIVcG4U=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-a9Kcl7P8Oc2tcaKlFwscoQ-1; Thu, 16 Oct 2025 12:01:41 -0400
X-MC-Unique: a9Kcl7P8Oc2tcaKlFwscoQ-1
X-Mimecast-MFC-AGG-ID: a9Kcl7P8Oc2tcaKlFwscoQ_1760630500
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-35f62a3c170so4720551fa.0
 for <dev@dpdk.org>; Thu, 16 Oct 2025 09:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760630499; x=1761235299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvHDvJozMzHMD+9Occ7DtXcuyX5yzVna0pZxqDJWcMg=;
 b=e3FB2ty+bEn0+FlnItMfg8Hbz//739VKr75pPPlJP+1Ps6wn2+WiOmEz5McjWWgf2L
 4RfQIjvvjk52v8sB9so8EXgRhuyuQoSqikl0GpxaJolCNGcApaHhHnO/GsOGThe8uGDj
 e0mo80z4Vdi+FYtct3gGOpMSySgQMLZyrTdDdSfXHV1UGAwUg4R0WN+8uFbm+PACE9QO
 UXUIVv/qPzuCFgg85i3/2G1n9K6Qzl8eviniu9BrrSb7XSZ+wlaa654cDTeZXE63ecJo
 xwuvhAaU7aqQqpE6ag/yq576dDeKmU0045WtEh6KvcP881JZfpxeW6Sm0RcWFuNpna6c
 GrNw==
X-Gm-Message-State: AOJu0YxqQLRy8Y8sUi/VZ+2Hez/Phu4F4KzIsM+yrCoUAePIB7/L4UWQ
 mWq7XddEtn9aENTjxne9BjhAU1B4vS3L/t4qe3CydJgxQk8I5CxLPMRvwpEW4tprm1hSYXAKyDk
 odYvUeQnJUyPutXlhf2SbLnz1X6qT79ISCatnRtsMGGt52GETil8xGwhKZ1MFVCHX5TYbn80f9z
 5+15vBYYMIjX8PZgRWA+k=
X-Gm-Gg: ASbGncugMvApTIMBI3ORqqVNmTn9kk1L8hdJcudFZIkyjwSydJzrWqDxv591TQZR0OF
 WwyGO3i29T8x9JRIUtVE9wwLsHrp0eLxKtNZ5mlCWTrV1+Yq5fynjJCPy5byhbR4zDGkT+dW5Vl
 cDCaHLdm/iYYf04rFQjovxzebozAF3sY4QWG3sph6ZJaXwLAEGx4VvZQ==
X-Received: by 2002:a05:651c:908:b0:372:8c3e:2641 with SMTP id
 38308e7fff4ca-3779782d19bmr2384191fa.10.1760630497905; 
 Thu, 16 Oct 2025 09:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfS+PPVTs0kI5Oqx26paQEL84qEAFpM1P1fr3ih+8HeNIscJvKgDBrsfRJjmYn0caGJG38Dn6lFT+5mfFcjzI=
X-Received: by 2002:a05:651c:908:b0:372:8c3e:2641 with SMTP id
 38308e7fff4ca-3779782d19bmr2384001fa.10.1760630497374; Thu, 16 Oct 2025
 09:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250527223642.31577-1-nicolas.chautru@intel.com>
 <20250527223642.31577-3-nicolas.chautru@intel.com>
 <CAO55csz8z6FX3QWFxeLj6wxn38FD_ax9TsAJ_BSopLsbAiVgiA@mail.gmail.com>
In-Reply-To: <CAO55csz8z6FX3QWFxeLj6wxn38FD_ax9TsAJ_BSopLsbAiVgiA@mail.gmail.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Thu, 16 Oct 2025 18:01:25 +0200
X-Gm-Features: AS18NWCHSosMgkLdrnu_A1uBAYtBORRWtXuD4w3UifjdbJBmdQicmLS7T1sncUQ
Message-ID: <CAO55cszNS=L0J_7=TDJukDd0EapR9aOnTtdL1AgRU1DdNUuesQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] baseband/acc: add trace points per operation
To: Nicolas Chautru <nicolas.chautru@intel.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, hemant.agrawal@nxp.com, 
 hernan.vargas@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BymSAZYD8JNaWuK_-Q6lH6tSYEJdZH_PvAE5fp-UhEQ_1760630500
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

On Thu, Oct 16, 2025 at 5:44=E2=80=AFPM Maxime Coquelin <mcoqueli@redhat.co=
m> wrote:
>
> Hi Nicolas,
>
> On Wed, May 28, 2025 at 12:36=E2=80=AFAM Nicolas Chautru
> <nicolas.chautru@intel.com> wrote:
> >
> > Add the details of the operation parameters into
> > trace when that operation is rejected by the PMD.
> >
> > Signed-off-by: Nicolas Chautru <nicolas.chautru@intel.com>
> > ---
> >  drivers/baseband/acc/acc_common.h | 1 +
> >  drivers/baseband/acc/vrb_trace.h  | 4 ++--
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/baseband/acc/acc_common.h b/drivers/baseband/acc/a=
cc_common.h
> > index 4880444450..3d411cd25f 100644
> > --- a/drivers/baseband/acc/acc_common.h
> > +++ b/drivers/baseband/acc/acc_common.h
> > @@ -700,6 +700,7 @@ acc_error_log(struct acc_queue *q, void *op, uint8_=
t acc_error_idx, const char *
> >
> >         rte_bbdev_vrb_trace_error(0, rte_bbdev_op_type_str(q->op_type),
> >                         acc_error_string[acc_error_idx]);
> > +       rte_bbdev_ops_trace(op, q->op_type);
> >
> >         va_end(args);
> >  }
> > diff --git a/drivers/baseband/acc/vrb_trace.h b/drivers/baseband/acc/vr=
b_trace.h
> > index 0bbfdc47d1..c9ae239fec 100644
> > --- a/drivers/baseband/acc/vrb_trace.h
> > +++ b/drivers/baseband/acc/vrb_trace.h
> > @@ -11,7 +11,7 @@ extern "C" {
> >
> >  #include <rte_trace_point.h>
> >
> > -RTE_TRACE_POINT_FP(
> > +RTE_TRACE_POINT(
> >         rte_bbdev_vrb_trace_error,
> >         RTE_TRACE_POINT_ARGS(uint8_t dev_id, const char *op_string, con=
st char *err_string),
> >         rte_trace_point_emit_u8(dev_id);
> > @@ -19,7 +19,7 @@ RTE_TRACE_POINT_FP(
> >         rte_trace_point_emit_string(err_string);
> >  )
> >
> > -RTE_TRACE_POINT_FP(
> > +RTE_TRACE_POINT(
> >         rte_bbdev_vrb_trace_queue_error,
> >         RTE_TRACE_POINT_ARGS(uint8_t qg_id, uint8_t aq_id, const char *=
str),
> >         rte_trace_point_emit_u8(qg_id);
>
> Maybe worth expanding in the commit message that from now on, the
> trace will be emitted systematically,
> i.e. without having to build with RTE_ENABLE_TRACE_FP set?
>
> It can be done while applying.

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

> Thanks,
> Maxime
>
> > --
> > 2.34.1
> >

