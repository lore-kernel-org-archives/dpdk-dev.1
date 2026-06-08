Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6857CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:16:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 090B940666;
	Mon,  8 Jun 2026 17:16:06 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 8F5B040265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 17:16:04 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-517760dc3c2so26726791cf.3
 for <dev@dpdk.org>; Mon, 08 Jun 2026 08:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931764; cv=none;
 d=google.com; s=arc-20240605;
 b=bNUhth23ytgAX708hr6MpHMblu4Owzovq/0PhCPz8b9a0wZ7iV1+qeq1EyQh+CXPQx
 ObwJ8emWX8UfZ8POFGteYXYnMaYy0aOda+iuuocolJ9Ku/qq6p6hQJUGxfq+37XaGwIF
 KtNwrpzQfKWXY/DT6lvGJuA+PZnX1e7Gi19GBcylDotfVj8vYc7fZuLjTbCtZdWQBqVO
 AB8KLVDnpQuFE0WcwaYjx0qdUXxyzC3/1olGqGc/gKQNpQVjwB0t4ioOz7wdBDLje4H9
 GeDAIcQPY9/5se0Xi0E+ugNpQnsGJLR6+IuOqukqq3ql/raFHvpSsxgapCE8iO+HSWTA
 0Ymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bt5GK/4oH/TqgKJ75OQj14QFLZ8dz1pvphgpVnAwWew=;
 fh=1JksPKFBZ/TVT7bS25FQgN7X3H4HEkKOvtUe0/7AZUc=;
 b=DO6V8kMjglAaSkCDlopnNZ4HuzzRwXAZtlI5aUp3pB7gt8c12gCqjZ0zTQs+ly/SOM
 TmMa+aeBtXfvH0es5S6itDrWJYcggZcU+JJ/8C1AP5eVzasNhx0s9iXKPAZldJpbWywz
 3ApmNUbTDB8aElveC138rZHvlsR9v6UQxhNpqNraHem34q8zUULEdnow25wWcnnGln0L
 OFwWL2qEsnSc59flIirfvYtYATzqCSON55q5TzV+fidh/VR2b9t0nVT98GX15Blthsbk
 UoGBPTTDXJ2ufrrF52rcnklthqhP1mWnbrmdF1fFgOEDT4OAdpwWSc/7Pyh6u/Lb3nTJ
 khdg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780931764; x=1781536564; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bt5GK/4oH/TqgKJ75OQj14QFLZ8dz1pvphgpVnAwWew=;
 b=je4af9tHuzBF4MWMFvXd9QAdOYNyIXVxfaAzOaecDcNTqVf2S5AiR/PoDMwBq55onc
 rHSpo3XWHly9PaktXc/j1BDsiJkq4uqG8urAmpx2h0t+Haoo7D6d4SHcXGSE7d1D2IMB
 XBTDsaPTQJ6NEFvaK9JFpq2m2Eg1NkmHRdKTMQoiMui8iWrjKvrOKQDU0xHX0yx0GuUl
 7SdFCvxhSv43OCpBAfLxaWsHfnvZBTKkJYq8iRwYGtASZyeSmizS8BmhJHcnE5lPPLsn
 nhiUvcGUUigmbvQGVwm+EwUzhwEMXVNSC1QGzfxlhSaSwLeCTeb44lvdB0ixEclT/gO2
 sMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780931764; x=1781536564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bt5GK/4oH/TqgKJ75OQj14QFLZ8dz1pvphgpVnAwWew=;
 b=RQX9ZY79cjAny7NcdW8Cv+bxcJRfLRQiVkAIo6EmySjlPadO+ZJPfKFO6wWCxLCvRB
 s5PnAduO8Yh2NSpL7PkYlCZr0Gd/et4z0DT3ZNDwNK0+VH21bhJJLt0oJG23l9do2BNl
 yuVOiPSCFbcuKcNmRxw6KqwxBl8fbM+pgFmffdPkbZt07dUfNo1Nayk85SOheDP3pevC
 GtNCuJ9dyKmGFYcl0jLN8gKUyJpDEnmSYkRAaFG2wIXRNotYemFTW3Lby1r/y0cAxDxa
 rpwckQgeCSUbw45b0BEHpoeZGRthz6HTB6N/yRfcD4IngUE3vZN+InnjeZXsrz3AKPa9
 3A4A==
X-Gm-Message-State: AOJu0Yxm4Jes3TM3BGFBME+zQAH4Widi/bGIfkQMFL2ELANi1hNqv7Pl
 ObA04XpPFfLO9THImZCXosb/4ZKzOUKsfaf9vyWCx1uPaw+ynR/hD2E7KOCC4px4Gtr7BExu2kL
 zD0xWPKlSO8iUdZ07DGuTWhH9TbYVwUo=
X-Gm-Gg: Acq92OECH/vGj0kS9bnjFMhlmJ4KWIUJ1l76sIl9C2lphAWap99At8kTfze+XwQ7EwV
 HGbAl9MbfnKVCkDrRgag5TfQXH12Idaw9+A2MNCnHCwrYiHk7j4vsuiZa5sp3OlaCvk5AsAmqeC
 mmsFBpj7mTMeqVGQHEHIHWCL2iHqfo68xc8/kxZBNVeEXkFA1XhFZ0E0Xvrd+sEaCGjT/ywK1xq
 1FXsOkMjUFQRlPTkjecw5uOOcUPobJepBa03cE2DLFhyCdJvUFUuQNmygkNJqWwOqgjYFGFvvWj
 aRdzS+cORKYO7w==
X-Received: by 2002:a05:622a:4108:b0:50d:83a4:2995 with SMTP id
 d75a77b69052e-51795b1d1c5mr234618861cf.21.1780931763372; Mon, 08 Jun 2026
 08:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260331085350.1105103-1-syalavarthi@marvell.com>
In-Reply-To: <20260331085350.1105103-1-syalavarthi@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 8 Jun 2026 20:45:35 +0530
X-Gm-Features: AVVi8CcjpsvdOcCDmCJLumVHlQ_qvvp99aaPdL9b5OITRoUY0DC-7mzPfE0AWRk
Message-ID: <CALBAE1M=zmJzq=mmNQgKSvO3VwtanBjjSBjVYARH_=EXXQ3SGw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ml/cnxk: enable data caching for all MRVL layers
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
Cc: dev@dpdk.org, Anup Prabhu <aprabhu@marvell.com>
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

On Tue, Mar 31, 2026 at 2:30=E2=80=AFPM Srikanth Yalavarthi
<syalavarthi@marvell.com> wrote:
>
> From: Anup Prabhu <aprabhu@marvell.com>
>
> Enabled data caching for all MRVL layers in TVM models.
>
> Signed-off-by: Anup Prabhu <aprabhu@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks

> ---
>  drivers/ml/cnxk/cn10k_ml_ops.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/ml/cnxk/cn10k_ml_ops.c b/drivers/ml/cnxk/cn10k_ml_op=
s.c
> index b30af7c7a44..628ff963c3c 100644
> --- a/drivers/ml/cnxk/cn10k_ml_ops.c
> +++ b/drivers/ml/cnxk/cn10k_ml_ops.c
> @@ -997,13 +997,8 @@ cn10k_ml_layer_start(void *device, uint16_t model_id=
, const char *layer_name)
>         if (ret < 0) {
>                 cn10k_ml_layer_stop(device, model_id, layer_name);
>         } else {
> -               if (cn10k_mldev->cache_model_data) {
> -                       if ((model->type =3D=3D ML_CNXK_MODEL_TYPE_GLOW &=
&
> -                            model->subtype =3D=3D ML_CNXK_MODEL_SUBTYPE_=
GLOW_MRVL) ||
> -                           (model->type =3D=3D ML_CNXK_MODEL_TYPE_TVM &&
> -                            model->subtype =3D=3D ML_CNXK_MODEL_SUBTYPE_=
TVM_MRVL))
> -                               ret =3D cn10k_ml_cache_model_data(cnxk_ml=
dev, layer);
> -               }
> +               if (cn10k_mldev->cache_model_data)
> +                       ret =3D cn10k_ml_cache_model_data(cnxk_mldev, lay=
er);
>         }
>
>         return ret;
> --
> 2.47.0
>
