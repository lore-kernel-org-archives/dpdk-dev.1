Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ED4CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 15:48:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 857B5410D3;
	Thu, 16 Oct 2025 17:48:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B84AD4026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 17:48:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760629730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YbFUFClhvtF1ki7mlJIDOuYYhPfS7267xxK2FGfrJU=;
 b=MhGINreZYtuI9LDFgCisjEBFIwE+YKSmvtLnExTk/oZ2mjk31UGEsQELW5gmFE5LvhTFPk
 gETElU2K1AAXHL599gO2IjxbBYa6ptOlco+rufvtIAkLPNJD5dVmWeJ/wKQfNxoy8q9bfi
 BX4v4abrhog5nelzOIoN76N0afCLP70=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-uJmqxBXDOc-nqsqFgdS-UA-1; Thu, 16 Oct 2025 11:48:48 -0400
X-MC-Unique: uJmqxBXDOc-nqsqFgdS-UA-1
X-Mimecast-MFC-AGG-ID: uJmqxBXDOc-nqsqFgdS-UA_1760629727
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-57bccf22e0bso829868e87.3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 08:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760629726; x=1761234526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YbFUFClhvtF1ki7mlJIDOuYYhPfS7267xxK2FGfrJU=;
 b=I6pU7wggDhIY+rTvitNy+eJmTfkGvdZ0ezziAv6pz/hLj0bly1darQQ+bTdELTjAzB
 nTofnkun2yfQ6rqWkPjbdqc465OcPPOWEgYDSSto+IkWhDd4MqexVB3uLfyTs0MHCDxA
 kyNsuUXKy8tpPt/YhvqJ7tiJun97qmpKwJjphWmOlGAxZqnhOGKLntJctO+Invpj/uzd
 GZ8JaQSwTBRctB3td1Bn0K4N7MI32oSRC9LJUtAf8uEI1K6gREpTaXGg4mVkxixtUf2c
 fuY8SIS17VUgl5sYHZ3/6oSZwZ6ePHq0lW4atnr4BCPupIRi0MaT6g7J/0GP7quqDyIW
 kegw==
X-Gm-Message-State: AOJu0YzChKiiLtwV5D/liN7OUBhynJ+Z4UOTFFInqqeCdo48Y9ZRuOMa
 1rsFWJ2pF4tv/ABxwnJ/l+mlsRvNcYGzVmu2KLNJwDdbrcEHch1REul91eWv9/AesoyX8HqdaIb
 3TDI++3IWwYahqZ/UjVXX2oScIqxax0RQ6/eXVNNnicFtalpfRzSnbF9VUr7dZYISu24lWowRyE
 h2Vim8a4iTW8T4pCgYVfo=
X-Gm-Gg: ASbGncubeJJE0+t5DWrj1ovWHI+1/X062EsQhRorGXSv+t34MDnw/MzZKjXFIAmUFTk
 ANVVWkw9v6T9+pCJ4r31t+VOonreHR3jNLn3R6QpgeShm5yhl8bEpbchXe1V1wE+QzvcsBe0sGH
 +/KM5elVhSYdx7h+gofXziLslkyX9kWzQoAfmEVGqOU7DJU4/wOIAUxQ==
X-Received: by 2002:a05:6512:3c9c:b0:58b:2b:ac7b with SMTP id
 2adb3069b0e04-591d85ad324mr181349e87.57.1760629726270; 
 Thu, 16 Oct 2025 08:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3wovfwjLs1JucJtJENL2qcslqgDBJ+yv5xN63OgTa20TjO13QtDJevIRZDFwAD8W6V6vsQjvfN0Iu/PRJk+c=
X-Received: by 2002:a05:6512:3c9c:b0:58b:2b:ac7b with SMTP id
 2adb3069b0e04-591d85ad324mr181303e87.57.1760629724253; Thu, 16 Oct 2025
 08:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250527223642.31577-1-nicolas.chautru@intel.com>
 <20250527223642.31577-2-nicolas.chautru@intel.com>
In-Reply-To: <20250527223642.31577-2-nicolas.chautru@intel.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Thu, 16 Oct 2025 17:48:33 +0200
X-Gm-Features: AS18NWATJonG-Y_oLErn01h9hBkgwe1VG5UtckhzJqsoU9vchPOciJJMmpqjrGU
Message-ID: <CAO55cswXSDNtm6Wng5x5p_D2QnWg_TLzw5Dv0j5p+ry9jovpVQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] bbdev: add trace points per operation
To: Nicolas Chautru <nicolas.chautru@intel.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, hemant.agrawal@nxp.com, 
 hernan.vargas@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AyM2CJWI1Iikwc-asi39v-ycdomewEVORX-BK50uScw_1760629727
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

On Wed, May 28, 2025 at 12:36=E2=80=AFAM Nicolas Chautru
<nicolas.chautru@intel.com> wrote:
>
> Adds trace points for rte_bbdev for each operation
> type set of input parameters.
> ---
>  lib/bbdev/bbdev_trace.h        | 113 +++++++++++++++++++++++++++++++++
>  lib/bbdev/bbdev_trace_points.c |  12 ++++
>  lib/bbdev/rte_bbdev.c          |  24 +++++++
>  lib/bbdev/rte_bbdev.h          |  14 ++++
>  4 files changed, 163 insertions(+)
>
> diff --git a/lib/bbdev/bbdev_trace.h b/lib/bbdev/bbdev_trace.h
> index 7256d6b703..dbef6efa3b 100644
> --- a/lib/bbdev/bbdev_trace.h
> +++ b/lib/bbdev/bbdev_trace.h
> @@ -62,6 +62,119 @@ RTE_TRACE_POINT(
>         rte_trace_point_emit_u16(queue_id);
>  )
>
> +
> +RTE_TRACE_POINT(
> +       rte_bbdev_trace_op_ldpc_dec,
> +       RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_ldpc_dec ldpc_dec)=
,
> +       rte_trace_point_emit_u8(ldpc_dec.code_block_mode);
> +       rte_trace_point_emit_u8(ldpc_dec.tb_params.c);
> +       rte_trace_point_emit_u8(ldpc_dec.tb_params.cab);
> +       rte_trace_point_emit_u32(ldpc_dec.tb_params.ea);
> +       rte_trace_point_emit_u32(ldpc_dec.tb_params.eb);
> +       rte_trace_point_emit_u8(ldpc_dec.tb_params.r);
> +       rte_trace_point_emit_u32(ldpc_dec.cb_params.e);
> +       rte_trace_point_emit_u32(ldpc_dec.op_flags);
> +       rte_trace_point_emit_u8(ldpc_dec.basegraph);
> +       rte_trace_point_emit_u16(ldpc_dec.z_c);
> +       rte_trace_point_emit_u16(ldpc_dec.n_cb);
> +       rte_trace_point_emit_u8(ldpc_dec.q_m);
> +       rte_trace_point_emit_u16(ldpc_dec.n_filler);
> +       rte_trace_point_emit_u8(ldpc_dec.rv_index);
> +       rte_trace_point_emit_u8(ldpc_dec.iter_max);
> +       rte_trace_point_emit_u8(ldpc_dec.iter_count);
> +       rte_trace_point_emit_u32(ldpc_dec.harq_combined_input.length);
> +)
> +
> +RTE_TRACE_POINT(
> +       rte_bbdev_trace_op_ldpc_enc,
> +       RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_ldpc_enc ldpc_enc)=
,
> +       rte_trace_point_emit_u8(ldpc_enc.code_block_mode);
> +       rte_trace_point_emit_u8(ldpc_enc.tb_params.c);
> +       rte_trace_point_emit_u8(ldpc_enc.tb_params.cab);
> +       rte_trace_point_emit_u32(ldpc_enc.tb_params.ea);
> +       rte_trace_point_emit_u32(ldpc_enc.tb_params.eb);
> +       rte_trace_point_emit_u8(ldpc_enc.tb_params.r);
> +       rte_trace_point_emit_u32(ldpc_enc.cb_params.e);
> +       rte_trace_point_emit_u32(ldpc_enc.op_flags);
> +       rte_trace_point_emit_u8(ldpc_enc.basegraph);
> +       rte_trace_point_emit_u16(ldpc_enc.z_c);
> +       rte_trace_point_emit_u16(ldpc_enc.n_cb);
> +       rte_trace_point_emit_u8(ldpc_enc.q_m);
> +       rte_trace_point_emit_u16(ldpc_enc.n_filler);
> +       rte_trace_point_emit_u8(ldpc_enc.rv_index);
> +)
> +
> +RTE_TRACE_POINT(
> +       rte_bbdev_trace_op_turbo_enc,
> +       RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_turbo_enc turbo_en=
c),
> +       rte_trace_point_emit_u8(turbo_enc.code_block_mode);
> +       rte_trace_point_emit_u32(turbo_enc.op_flags);
> +       rte_trace_point_emit_u8(turbo_enc.rv_index);
> +       rte_trace_point_emit_u16(turbo_enc.tb_params.k_neg);
> +       rte_trace_point_emit_u16(turbo_enc.tb_params.k_pos);
> +       rte_trace_point_emit_u8(turbo_enc.tb_params.c_neg);
> +       rte_trace_point_emit_u8(turbo_enc.tb_params.c);
> +       rte_trace_point_emit_u8(turbo_enc.tb_params.cab);
> +       rte_trace_point_emit_u32(turbo_enc.tb_params.ea);
> +       rte_trace_point_emit_u32(turbo_enc.tb_params.eb);
> +       rte_trace_point_emit_u8(turbo_enc.tb_params.r);
> +       rte_trace_point_emit_u32(turbo_enc.cb_params.e);
> +       rte_trace_point_emit_u16(turbo_enc.cb_params.k);
> +)
> +
> +RTE_TRACE_POINT(
> +       rte_bbdev_trace_op_turbo_dec,
> +       RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_turbo_dec turbo_de=
c),
> +       rte_trace_point_emit_u8(turbo_dec.code_block_mode);
> +       rte_trace_point_emit_u32(turbo_dec.op_flags);
> +       rte_trace_point_emit_u8(turbo_dec.rv_index);
> +       rte_trace_point_emit_u8(turbo_dec.iter_count);
> +       rte_trace_point_emit_u8(turbo_dec.ext_scale);
> +       rte_trace_point_emit_u8(turbo_dec.num_maps);
> +       rte_trace_point_emit_u16(turbo_dec.tb_params.k_neg);
> +       rte_trace_point_emit_u16(turbo_dec.tb_params.k_pos);
> +       rte_trace_point_emit_u8(turbo_dec.tb_params.c_neg);
> +       rte_trace_point_emit_u8(turbo_dec.tb_params.c);
> +       rte_trace_point_emit_u8(turbo_dec.tb_params.cab);
> +       rte_trace_point_emit_u32(turbo_dec.tb_params.ea);
> +       rte_trace_point_emit_u32(turbo_dec.tb_params.eb);
> +       rte_trace_point_emit_u8(turbo_dec.tb_params.r);
> +       rte_trace_point_emit_u32(turbo_dec.cb_params.e);
> +       rte_trace_point_emit_u16(turbo_dec.cb_params.k);
> +)
> +
> +RTE_TRACE_POINT(
> +       rte_bbdev_trace_op_fft,
> +       RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_fft fft),
> +       rte_trace_point_emit_u32(fft.op_flags);
> +       rte_trace_point_emit_u16(fft.input_sequence_size);
> +       rte_trace_point_emit_u16(fft.input_leading_padding);
> +       rte_trace_point_emit_u16(fft.output_sequence_size);
> +       rte_trace_point_emit_u16(fft.output_leading_depadding);
> +       rte_trace_point_emit_u16(fft.cs_bitmap);
> +       rte_trace_point_emit_u8(fft.num_antennas_log2);
> +       rte_trace_point_emit_u8(fft.idft_log2);
> +       rte_trace_point_emit_u8(fft.dft_log2);
> +       rte_trace_point_emit_u8(fft.cs_time_adjustment);
> +       rte_trace_point_emit_u8(fft.idft_shift);
> +       rte_trace_point_emit_u8(fft.dft_shift);
> +       rte_trace_point_emit_u16(fft.ncs_reciprocal);
> +       rte_trace_point_emit_u16(fft.power_shift);
> +       rte_trace_point_emit_u16(fft.fp16_exp_adjust);
> +       rte_trace_point_emit_u8(fft.freq_resample_mode);
> +       rte_trace_point_emit_u16(fft.output_depadded_size);
> +)
> +
> +RTE_TRACE_POINT(
> +       rte_bbdev_trace_op_mldts,
> +       RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_mldts mldts),
> +       rte_trace_point_emit_u32(mldts.op_flags);
> +       rte_trace_point_emit_u16(mldts.num_rbs);
> +       rte_trace_point_emit_u16(mldts.num_layers);
> +       rte_trace_point_emit_u8(mldts.r_rep);
> +       rte_trace_point_emit_u8(mldts.c_rep);
> +)
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/lib/bbdev/bbdev_trace_points.c b/lib/bbdev/bbdev_trace_point=
s.c
> index 942c7be819..23d1164e7d 100644
> --- a/lib/bbdev/bbdev_trace_points.c
> +++ b/lib/bbdev/bbdev_trace_points.c
> @@ -21,6 +21,18 @@ RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_queue_start,
>         lib.bbdev.queue.start)
>  RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_queue_stop,
>         lib.bbdev.queue.stop)
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_ldpc_dec,
> +       lib.bbdev.op.ldpc_dec);
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_ldpc_enc,
> +       lib.bbdev.op.ldpc_enc);
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_turbo_dec,
> +       lib.bbdev.op.turbo_dec);
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_turbo_enc,
> +       lib.bbdev.op.turbo_enc);
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_fft,
> +       lib.bbdev.op.fft);
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_mldts,
> +       lib.bbdev.op.mldts);
>
>  RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_bbdev_trace_enqueue, 25.03)
>  RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_enqueue,
> diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
> index e0f8c8eb0d..4958a87646 100644
> --- a/lib/bbdev/rte_bbdev.c
> +++ b/lib/bbdev/rte_bbdev.c
> @@ -1281,6 +1281,30 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t=
 queue_id, FILE *f)
>         return dev->dev_ops->queue_ops_dump(dev, queue_id, f);
>  }
>
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bbdev_ops_trace, 25.03)
> +void
> +rte_bbdev_ops_trace(void *op, enum rte_bbdev_op_type op_type)
> +{
> +       struct rte_bbdev_dec_op *op_dec =3D op;
> +       struct rte_bbdev_enc_op *op_enc =3D op;
> +       struct rte_bbdev_fft_op *op_fft =3D op;
> +       struct rte_bbdev_mldts_op *op_mldts =3D op;
> +
> +       if (op_type =3D=3D RTE_BBDEV_OP_LDPC_DEC) {
> +               rte_bbdev_trace_op_ldpc_dec(op_dec->ldpc_dec);
> +       } else if (op_type =3D=3D RTE_BBDEV_OP_LDPC_ENC) {
> +               rte_bbdev_trace_op_ldpc_enc(op_enc->ldpc_enc);
> +       } else if (op_type =3D=3D RTE_BBDEV_OP_FFT) {
> +               rte_bbdev_trace_op_fft(op_fft->fft);
> +       } else if (op_type =3D=3D RTE_BBDEV_OP_MLDTS) {
> +               rte_bbdev_trace_op_mldts(op_mldts->mldts);
> +       } else if (op_type =3D=3D RTE_BBDEV_OP_TURBO_DEC) {
> +               rte_bbdev_trace_op_turbo_dec(op_dec->turbo_dec);
> +       } else if (op_type =3D=3D RTE_BBDEV_OP_TURBO_ENC) {
> +               rte_bbdev_trace_op_turbo_enc(op_enc->turbo_enc);
> +       }
> +}
> +
>  RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bbdev_ops_param_string, 24.11)
>  char *
>  rte_bbdev_ops_param_string(void *op, enum rte_bbdev_op_type op_type, cha=
r *str, uint32_t len)
> diff --git a/lib/bbdev/rte_bbdev.h b/lib/bbdev/rte_bbdev.h
> index 710280f0df..4912bc7b6f 100644
> --- a/lib/bbdev/rte_bbdev.h
> +++ b/lib/bbdev/rte_bbdev.h
> @@ -1147,6 +1147,20 @@ __rte_experimental
>  char *
>  rte_bbdev_ops_param_string(void *op, enum rte_bbdev_op_type op_type, cha=
r *str, uint32_t len);
>
> +/**
> + * Add a trace with detail of operation.
> + *
> + *  @param op
> + *    Pointer to an operation.
> + *
> + *  @param op_type
> + *    Operation type enum.
> + *
> + */
> +__rte_experimental
> +void
> +rte_bbdev_ops_trace(void *op, enum rte_bbdev_op_type op_type);
> +
>  #ifdef __cplusplus
>  }
>  #endif

Looks good to me.
I'm wondering if it would make sense to have a rte_bbdev_ops_trace_fp
version that would be a a noop
if RTE_ENABLE_TRACE_FP is not set.
It could be called in the hot paths and enabled when debugging?

It could be done as an add-on patch.

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

> --
> 2.34.1
>

