Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CE4CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:15:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 103E4402DD;
	Mon,  8 Jun 2026 17:15:10 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 07D7040265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 17:15:08 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-5174a3a025aso45604651cf.3
 for <dev@dpdk.org>; Mon, 08 Jun 2026 08:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931707; cv=none;
 d=google.com; s=arc-20240605;
 b=Tw6xokLmZEJgJ3qCoVM2fCruIfTVkm7o4+SDu02easAEP6e5hHsqrf7qTbKuPJJ23Z
 a35P0YWAL77h2HPxAki1I7qzgaT62tZiZ2X6d9wAX0K1weFfdx8ywIo/brcdwjZlz051
 XI1CJG+HxvEgYcz/6X3qu/G2O0dNzwLdpgs2n8tP1pKRYo+bFuXYKPTl7imvBHVIy2XU
 NEOaWfv30GOamJ9De+zkgZKumWHBprxiYE5gwegAg5m1vv+FSm1QTW/L/ZLRmYdLK+qJ
 5lJi4+Te/FNfTdpQGIin1Uv2qtUVUOXBewdBjg/yEeKIAnx2Rentuqwvr/+Wz2j3ZCWB
 f4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+T8NT3pjT8r0cJTl4zIWjMyj9UmmYCo9sRMXY67yXYM=;
 fh=jbdx/Wceb3VPJjUp74ta5d4SFbwKBSOvSND22D5uqu4=;
 b=T4BCa5PUD1GTp+DPXe+AynCSvwqzEZH0oT3h/c3LtbogGMxrtbNJuEjVg2/AQg1x34
 hNrxLhnx87ZGgZtaIQyzkTxqjSdGTx/IczZpDqc441GjWZowMGEtuh+qA+2HFa9C3p9s
 fYOfEygAl9eCsrOPHI8ldkjaOVn/qVMeyxous9rErqLpCfRqZyas0e5eFQshOD9hXEIM
 tXZ1ARoZzCm2ZvpTYz37MlFCEQCJrkCVlB0yRafyZpZKlevjjMhtuW2gDaP0AlL4lFe5
 g8p/ZDQ/z0npJnOZ1Qdepw4KItUEoFfon06x6GQk7JQjL9Yj72pMPkyGVwzfwdk8Vf/c
 wxUw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780931707; x=1781536507; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+T8NT3pjT8r0cJTl4zIWjMyj9UmmYCo9sRMXY67yXYM=;
 b=Jq74AWD8BtCZW/A+9ibEmofkt5C3XofkphNAKIOJrFmO5ZviRq3JkvFJ7lIGsi2nOZ
 bjtyFiWM35/ZJKmIKrlz/LwdGspXSpwDC2Q5hl/PTLMBMa2A4R+8Ta6pDgQKtzPMH2uF
 fZ+f+UypeQ1cjA22ZD3BEIsf5SK+idKrAZ6UQedKyQwlsFkgU2+JSAV3D91mbCCTdpSO
 nfO/Urx5pS1Q7b7ux/1QGgsf4L7gL8EBffJsVlfQ5zBuuHQtG2LL4x3D4jvWYKJGYpI6
 Xn/Ik+qh5Kbg1QNDUrUJugFt6qOplQ/Y9FNQeLdV7x4VAivlL8izNnfHVLcE2BI9BGsF
 JMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780931707; x=1781536507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+T8NT3pjT8r0cJTl4zIWjMyj9UmmYCo9sRMXY67yXYM=;
 b=KfzlB5cjOLWZ4170aSBj4sef8OEu2hJrKzbNqc6doGL5dDMTJgUfUSl6KaBw8dKr5H
 Qwbz7ZHzMRsSRp81s5BebBTFPQJ8SVcYmOslL/5WJF342st9rnG92dNlsVd8iIxGUNOH
 +djhbLG6mw1AqOyXW1s82ChZrrbMvJhzVFz5gi+To+5XTP0jb3xQQtwfxj6WVrorp+qn
 Q+7/fGUOz9TtTmhPi349bBTZauCNSR0AUe6j+TylYe7joJWAE4CEPtl1guGpYion2k6g
 NT8HOU3vH+O99v+v8EbF8L41oU7fNetKJF/SfeXUu5X+2p392bs0ZYFT4gm+CtTyNpNA
 qsQg==
X-Gm-Message-State: AOJu0YynuwuCxCCMMCBQyHotZO5osQNRi0qy+fVFJt/UDhJayzGtRk4Q
 agY9rar2eRE5Ay136EP+Dw9uNjzu9hzMegqbxpmgNT6huZk7C6RMueqP6WT4e9yeOmjhEITs4jo
 tu3dRa0owcyBxlbLh81VJty/6CN9Eaqs=
X-Gm-Gg: Acq92OEKb3K7l+owflNzKEQffQJKn2HcHzS5Cvi/bFSUBsDd0FJ/iQV3mUHQJoFQVtc
 NYoxiLNHR9rj6wIC7zsUm5/rhdxC8CmCN4TZDxPO680OiAFAUx/wSy4iyLxBIeyVp+mkGBCiZCx
 bT5Ej7hZXQ6S+TfAyVpyl8MRZ9acq/JRtVv3aAU/8plX2A8/EjvOcxojS+sLVHbTD/7ds9hQ7a0
 5INCvLmSsGVRNmggMhsC4gbdhpC1TM1nkMAWJz9E8rsU7Tses9sLHIT6GieEOf4GWC1BEgLgDIa
 k6gTh1K6tK92Q787FY1F/Lnu
X-Received: by 2002:a05:622a:1a92:b0:517:7303:df84 with SMTP id
 d75a77b69052e-51795c640e0mr236194371cf.56.1780931706999; Mon, 08 Jun 2026
 08:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260331085445.1105590-1-syalavarthi@marvell.com>
In-Reply-To: <20260331085445.1105590-1-syalavarthi@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 8 Jun 2026 20:44:40 +0530
X-Gm-Features: AVVi8CdU3fv6KzdShUvdR-XwqhLN0oY2S1aLkwQPiwGtsjKxfa7BHBBUZ9KqQiQ
Message-ID: <CALBAE1P2_FqDTkvREXHinqvX6ROe=TSzghGAcd_QuErxUYN53g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ml/cnxk: avoid overwriting layer name during load
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
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

On Tue, Mar 31, 2026 at 7:10=E2=80=AFPM Srikanth Yalavarthi
<syalavarthi@marvell.com> wrote:
>
> Layer name is initialized during metadata fetch and
> parsing stage. Avoid overwriting the layer name during
> layer load.
>
> Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>


Change as ml/cnxk: fix ...

and add Fixes: tag

> ---
>  drivers/ml/cnxk/cn10k_ml_ops.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/ml/cnxk/cn10k_ml_ops.c b/drivers/ml/cnxk/cn10k_ml_op=
s.c
> index 628ff963c3c..77947120f25 100644
> --- a/drivers/ml/cnxk/cn10k_ml_ops.c
> +++ b/drivers/ml/cnxk/cn10k_ml_ops.c
> @@ -671,9 +671,6 @@ cn10k_ml_layer_load(void *device, uint16_t model_id, =
const char *layer_name, uin
>         rte_memcpy(&layer->glow.metadata, buffer, sizeof(struct cn10k_ml_=
model_metadata));
>         cn10k_ml_model_metadata_update(&layer->glow.metadata);
>
> -       /* Set layer name */
> -       rte_memcpy(layer->name, layer->glow.metadata.model.name, MRVL_ML_=
MODEL_NAME_LEN);
> -
>         /* Enable support for batch_size of 256 */
>         if (layer->glow.metadata.model.batch_size =3D=3D 0)
>                 layer->batch_size =3D 256;
> --
> 2.34.1
>
