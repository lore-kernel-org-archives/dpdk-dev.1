Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC959CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 15:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14C2F40F35;
	Thu, 16 Oct 2025 17:45:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 92BA84026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 17:45:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760629508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cOVvn+RK0sl1r0ELVwBHVfAIWf+tjTDet35PAABboyo=;
 b=bbshwst1dU/D5Pcsagn5fAgm75UnOwmwx/E/wSwjYo9E6Im5j7Hn56lPH+ZGcNxm7lddA8
 NWzrUDyLpheiz8I5EZLMrJLks6NeP3uiiki+QrKEh7XLOAfAJDmB7lu0pvf0mf79k/DwRc
 whaTcPlkhjYxPZla/ntb8eGjpXho7sg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-_HUK3WZvNWmt25Ob2aNuXg-1; Thu, 16 Oct 2025 11:45:06 -0400
X-MC-Unique: _HUK3WZvNWmt25Ob2aNuXg-1
X-Mimecast-MFC-AGG-ID: _HUK3WZvNWmt25Ob2aNuXg_1760629505
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-57b9c463726so967579e87.1
 for <dev@dpdk.org>; Thu, 16 Oct 2025 08:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760629505; x=1761234305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOVvn+RK0sl1r0ELVwBHVfAIWf+tjTDet35PAABboyo=;
 b=Nrz9qsMyJqYcJLeKfiCVA6B+itYcjsAbq+In+cd6HmKZpe5lAgye9TMrXK8sdcZSVW
 yPTQQHk+YL+Ww96nfjLlYO86Y03cx3tOOM02HFoITkDLxiKGs4ms2rI0+v5dh+Vw+kEX
 HKTlTIC6ujzeIhUjqREznt+J/wdnEtoi+7NGRNdueo3trbF1fvXm5juHPBEulyICVB2i
 w0tq8/HLo7f36KX44B7XWk/j1+nRo1HqMeICMXm7Qqy1UafF1puIseBohKwRsVuJSoFU
 s8JHu0TNzxmlz+bjeYZkIpsiOpmZjvNx52pQGcmVAUYS46aRpoNItGvy/iQrvoPtXFqh
 pDow==
X-Gm-Message-State: AOJu0Ywetr7CJ3BMF6apUCNyNjN7+nppFDF1bPC0Cg7292zZAaBrEB7N
 KmjO34EyyX5TsUPxRUSXHhOUBQPOHdb7Ouvw/PPy1jwZmriqfsMD7s/vn4vj89Eegt7eOQIEJF7
 DLE//MtIosWpt7lM4I/zLEOCk1LY0yzzKg1xCvhkFx4HSfAloFeNg2bfDiVJ4lUJFLnSS6jn5lx
 PlB974G62OYB7eeXVTxOI=
X-Gm-Gg: ASbGncvBe6QehjvlCjqubKTncTxGifVZ7JpdMkyhfvD8w9wIASVodTWBfHGRDOwXVQ1
 sREbdVuYS4Wtff6SOHtu4nZx3EOH84abYYHn78xt0BAanv8BJUIIYzFVd+ML2anGYyjYcmpc/Xi
 9BpflBh06lc8aF+tXrrLezY7/S9Be+FWx+Cdx8IPCnkjYFefCp1KVIRg==
X-Received: by 2002:a05:6512:1325:b0:590:60c7:f9f7 with SMTP id
 2adb3069b0e04-591d855858amr176003e87.48.1760629503890; 
 Thu, 16 Oct 2025 08:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhzOexr1qsfIhC6tiwyW3oTV1YCvPBlh+Lco+pffT/zWeOroMzptU2mcD9yieF32ZEEObUc3szUr/yLmlNbSw=
X-Received: by 2002:a05:6512:1325:b0:590:60c7:f9f7 with SMTP id
 2adb3069b0e04-591d855858amr175971e87.48.1760629503118; Thu, 16 Oct 2025
 08:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250527223642.31577-1-nicolas.chautru@intel.com>
 <20250527223642.31577-3-nicolas.chautru@intel.com>
In-Reply-To: <20250527223642.31577-3-nicolas.chautru@intel.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Thu, 16 Oct 2025 17:44:52 +0200
X-Gm-Features: AS18NWBATuQqNr6o6QoT01Vqnx8QQNTDY1fBF4X2Uuw8haSAuBTKUVKOfE81FjE
Message-ID: <CAO55csz8z6FX3QWFxeLj6wxn38FD_ax9TsAJ_BSopLsbAiVgiA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] baseband/acc: add trace points per operation
To: Nicolas Chautru <nicolas.chautru@intel.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, hemant.agrawal@nxp.com, 
 hernan.vargas@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wIddMXh5uJqvcHEDSxf-C074znDRwZEUGyXzNcxo6eY_1760629505
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

Hi Nicolas,

On Wed, May 28, 2025 at 12:36=E2=80=AFAM Nicolas Chautru
<nicolas.chautru@intel.com> wrote:
>
> Add the details of the operation parameters into
> trace when that operation is rejected by the PMD.
>
> Signed-off-by: Nicolas Chautru <nicolas.chautru@intel.com>
> ---
>  drivers/baseband/acc/acc_common.h | 1 +
>  drivers/baseband/acc/vrb_trace.h  | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/baseband/acc/acc_common.h b/drivers/baseband/acc/acc=
_common.h
> index 4880444450..3d411cd25f 100644
> --- a/drivers/baseband/acc/acc_common.h
> +++ b/drivers/baseband/acc/acc_common.h
> @@ -700,6 +700,7 @@ acc_error_log(struct acc_queue *q, void *op, uint8_t =
acc_error_idx, const char *
>
>         rte_bbdev_vrb_trace_error(0, rte_bbdev_op_type_str(q->op_type),
>                         acc_error_string[acc_error_idx]);
> +       rte_bbdev_ops_trace(op, q->op_type);
>
>         va_end(args);
>  }
> diff --git a/drivers/baseband/acc/vrb_trace.h b/drivers/baseband/acc/vrb_=
trace.h
> index 0bbfdc47d1..c9ae239fec 100644
> --- a/drivers/baseband/acc/vrb_trace.h
> +++ b/drivers/baseband/acc/vrb_trace.h
> @@ -11,7 +11,7 @@ extern "C" {
>
>  #include <rte_trace_point.h>
>
> -RTE_TRACE_POINT_FP(
> +RTE_TRACE_POINT(
>         rte_bbdev_vrb_trace_error,
>         RTE_TRACE_POINT_ARGS(uint8_t dev_id, const char *op_string, const=
 char *err_string),
>         rte_trace_point_emit_u8(dev_id);
> @@ -19,7 +19,7 @@ RTE_TRACE_POINT_FP(
>         rte_trace_point_emit_string(err_string);
>  )
>
> -RTE_TRACE_POINT_FP(
> +RTE_TRACE_POINT(
>         rte_bbdev_vrb_trace_queue_error,
>         RTE_TRACE_POINT_ARGS(uint8_t qg_id, uint8_t aq_id, const char *st=
r),
>         rte_trace_point_emit_u8(qg_id);

Maybe worth expanding in the commit message that from now on, the
trace will be emitted systematically,
i.e. without having to build with RTE_ENABLE_TRACE_FP set?

It can be done while applying.

Thanks,
Maxime

> --
> 2.34.1
>

