Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7002C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:01:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD72740B8F;
	Mon, 14 Sep 2026 13:01:22 +0200 (CEST)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51]) by mails.dpdk.org (Postfix) with ESMTP id C8BA740272
 for <dev@dpdk.org>; Mon, 14 Sep 2026 13:01:21 +0200 (CEST)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-6714af30a2cso635397d50.3
 for <dev@dpdk.org>; Mon, 14 Sep 2026 04:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789383681; cv=none;
 d=google.com; s=arc-20260327;
 b=RvyZ9+ZvkbXG9ST2Pabqh/6RXbiQAJzFmUFvEZ301n9RYB8TvR7C0IiwQV4InbaHTq
 uNDptpqqL9g3zm9kum13Iml9bO0V+XjVVxyrshg/GbjRwGEuf7wpiwY1oFUOqEzytEwA
 LbKZno8yNnS3DURKuVTnk60lLqfkUPTGkSR9aBLd/wqL9Bfm8fFNF2w1ITPY/42oi4m7
 jqHE5hvdY+oCv08qbBgjGjxfUMBVKI7sGkDIfZnQ6FXYRMHpsn3x+PDCE8s778REX5D1
 2VIeqjVp8DpGYwPCNoudDSEhtwpRzFp+tCm6SkAik0Yz5dmjhBmOUyI0mpUZvzRZfB/w
 QIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1GWV8/njlWYxFqhivX5mXWx1kG/3o4yJnD5x3mzO7N4=;
 fh=AInxUnotHkevZOpkFtbYoW+CevgvxPJ5jQsAJYDF39o=;
 b=eP7U6lAdVvq9aKp4wSZFTycMqLZdXs3MHLnTppBnlmPhdiDci3X41Drc/LoP7pbqmO
 ImSgjG82vHbe1/P9CWhQfyhxIMqR582Di6tudNvKKgvolC9QHG5ZVxCUfsP+fY8Xdcz6
 +jiT2cjEH0lyOhJGv/RlvqbAohL6VYqpAb5oz6f36Zc49hVScxT/LOPcdfjkAfGlk2H+
 kLoiKXA1jDPAZWtDGn2mSYU2WZfkTX42tjmI/kgJ9wSOMRxgSv2N8MlCxE0ja9CWjctX
 IyEgfx3uB/+mH8DMcKbm12a+tocdyI9dGy6cfn2fJ2e3YiG1j6dtjAsXJgpwBNcP452p
 4OJA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789383681; x=1789988481; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1GWV8/njlWYxFqhivX5mXWx1kG/3o4yJnD5x3mzO7N4=;
 b=WsrFrD76HwgEjpDxXONMyvS2nlt5zpXwedw+Yvzf2mfXDuGLoULrOjBeefcWmQ+nvv
 ZubYY2B3A9y0UguaIIKj19+xw65nrjxmmWbpGf9E35z1ffNFEN5Ayl7j1Fwi05yXmRRS
 2+RvimylDu/E3pVh3LftKs/pJQ95Nqme7Ha2nO/Mvr3LjToX182XNOjIB3gj6jYxLbNs
 M9m4zwQ3lP48oiXSVzdfQomVLFn/vUYiHlZxAr31WeHa8IOfY8yItXEbUJ8kGPqMA2QG
 VspaW1OccPGKm86wEOMfE/IyWNQZvuYxb7HeesLb0zNqqBsjsShOiKabgtXA8mPsRz3e
 sW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789383681; x=1789988481;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1GWV8/njlWYxFqhivX5mXWx1kG/3o4yJnD5x3mzO7N4=;
 b=AVy194O/FjYR6B4pb9JNBsGQGOt3cBdQJRy68jVYkszaZNMULfcruSi1PUYKjRmnGA
 HkbF93wH8qy6K99hMVeIIikxyJd/9Ahco4691Nd+djAW2s/fneQU81rFfiSkS5xPpu8u
 fn9x6mEPJvDoRzfbHpEgr/Q3nH21IapomPLSvvnlmIFf+KJ/wRJcCM+1d9eh0axlmLiY
 qr/mqY9l6mfGxt/5t/GZVfaPqaL1iiVRHrQHA7lCo+dTnS14YGuJAvj2jMMTc8pPPzZY
 rx05tWpJ0E0iSNe7yNUItua7M2L7UzLIj+lMDyOx8OaU7ukt8JP6SD9XJVBQl1DcEw7d
 NN5A==
X-Gm-Message-State: AFuF++m8C9OoSqYbeW6p8t1CFXGcEpRjh/rhl+nD0AQhjE+A+7JslkyL
 DUIy/IX7L1cwaiRebv5MbJU6LHvtJo8jvkU6eZbZdb5U9u1/R/+Sg5/tarvtaGrao96M3P4NLTf
 ibkZeIGKtMm35c/dlH2jbVaoLhl7/BrM=
X-Gm-Gg: AYBFou0noh15rt0W1ycboOyb9ZrBi9xfBvCpj+HYtgFn/5pFUTi62qfHQ7h8Je20v98
 QBpNijw4EtYHiMNsBkFZxIGra7eQE7tQCLuCHxk5b42sc9xyv+XOrU+KFcypVWl/rxIFwPqWRjl
 q02ThVOgMuFFSg3De5XzfHI6kdXJBx6Eh49+CQGROrkdclMjovs3JG/G7qV17mk9Gm5sH+pHt63
 r+ED+f4sfD4HW0oAeMPaXrM1j20CNM6WO1XbQ4/TTpNzSfIogTvap3KIoEcXmECsJUOCbFYWE4Q
 UnKkcY5pP/HQOmKqhtxTWreySJ9IVcsbXdkzijXDBdeTaxuOJVACZEm62ngBqa6N0gaTT/mIc2O
 46FT7yXZxjWy7FHy2bHYKKnPjbZBWBPNvLxyh1FXGb43aZDCOeiGdjYdgN+TATu+EHEkTcHMuJZ
 8LVxY7uRcsdgjKlw/0vnXRDB1UyCA=
X-Received: by 2002:a05:690e:43db:b0:66f:ca4f:b6d1 with SMTP id
 956f58d0204a3-6714dff3fcbmr288518d50.22.1789383680834; Mon, 14 Sep 2026
 04:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260723121510.3781858-1-ajp@marvell.com>
In-Reply-To: <20260723121510.3781858-1-ajp@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 14 Sep 2026 16:30:54 +0530
X-Gm-Features: AcwNN1X_q-Hh5ROfH70FykAYYbATZia7m71REvs2LQ9rXu0SZ9jprSAXtkInsyA
Message-ID: <CALBAE1NVFf2QOtH5ZfC85APRzJkhs2VBQoF8dbyXBq8ve5NA4Q@mail.gmail.com>
Subject: Re: [PATCH] common/cnxk: validate xform in inline IPsec session create
To: Aarnav JP <ajp@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Tejasree Kondoj <ktejasree@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 rbhansali@marvell.com, stable@dpdk.org
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

On Thu, Jul 23, 2026 at 8:17=E2=80=AFPM Aarnav JP <ajp@marvell.com> wrote:
>
> Add cnxk_ipsec_xform_verify() call in cn10k, cn20k and cn9k
> inline IPsec session create paths to reject invalid crypto
> transforms early, before any SA memory is written. Previously
> this validation was only performed in the lookaside crypto
> paths, allowing the inline paths to reach SA fill helpers
> with unchecked key lengths and algorithm combinations.
>
> Move the xform verification helpers from the crypto driver
> private header to the shared cnxk_security.h so they are
> accessible to both the net and crypto drivers.
>
> Drop the aead.op vs direction consistency check from the
> shared verifier since the cnxk driver derives SA direction
> from ipsec_xform.direction and does not use aead.op.
>
> Fixes: 69daa9e5022b ("net/cnxk: support inline security setup for cn10k")
> Fixes: 7eabd6c63773 ("net/cnxk: support inline security setup for cn9k")
> Fixes: 7eaa499dd0c2 ("net/cnxk: support CN20K inline IPsec session")
> Cc: stable@dpdk.org
>
> Signed-off-by: Aarnav JP <ajp@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks


> ---
>  drivers/common/cnxk/cnxk_security.h | 175 ++++++++++++++++++++++++++
>  drivers/crypto/cnxk/cnxk_ipsec.h    | 183 +---------------------------
>  drivers/net/cnxk/cn10k_ethdev_sec.c |   7 ++
>  drivers/net/cnxk/cn20k_ethdev_sec.c |   7 ++
>  drivers/net/cnxk/cn9k_ethdev_sec.c  |   7 ++
>  5 files changed, 197 insertions(+), 182 deletions(-)
>
> diff --git a/drivers/common/cnxk/cnxk_security.h b/drivers/common/cnxk/cn=
xk_security.h
> index 3912c8d376..10e7d5b520 100644
> --- a/drivers/common/cnxk/cnxk_security.h
> +++ b/drivers/common/cnxk/cnxk_security.h
> @@ -4,6 +4,8 @@
>  #ifndef _CNXK_SECURITY_H__
>  #define _CNXK_SECURITY_H__
>
> +#include <errno.h>
> +
>  #include <rte_crypto.h>
>  #include <rte_security.h>
>
> @@ -65,4 +67,177 @@ int __roc_api cnxk_ow_ipsec_outb_sa_fill(struct roc_o=
w_ipsec_outb_sa *sa,
>                                          uint8_t ctx_ilen);
>  bool __roc_api cnxk_ow_ipsec_inb_sa_valid(struct roc_ow_ipsec_inb_sa *sa=
);
>  bool __roc_api cnxk_ow_ipsec_outb_sa_valid(struct roc_ow_ipsec_outb_sa *=
sa);
> +
> +static inline int
> +ipsec_xform_cipher_verify(struct rte_crypto_sym_xform *crypto_xform)
> +{
> +       if (crypto_xform->cipher.algo =3D=3D RTE_CRYPTO_CIPHER_NULL)
> +               return 0;
> +
> +       if (crypto_xform->cipher.algo =3D=3D RTE_CRYPTO_CIPHER_DES_CBC &&
> +           crypto_xform->cipher.key.length =3D=3D 8)
> +               return 0;
> +
> +       if (crypto_xform->cipher.algo =3D=3D RTE_CRYPTO_CIPHER_AES_CBC ||
> +           crypto_xform->cipher.algo =3D=3D RTE_CRYPTO_CIPHER_AES_CTR) {
> +               switch (crypto_xform->cipher.key.length) {
> +               case 16:
> +               case 24:
> +               case 32:
> +                       break;
> +               default:
> +                       return -ENOTSUP;
> +               }
> +               return 0;
> +       }
> +
> +       if (crypto_xform->cipher.algo =3D=3D RTE_CRYPTO_CIPHER_3DES_CBC &=
&
> +           crypto_xform->cipher.key.length =3D=3D 24)
> +               return 0;
> +
> +       return -ENOTSUP;
> +}
> +
> +static inline int
> +ipsec_xform_auth_verify(struct rte_crypto_sym_xform *crypto_xform)
> +{
> +       uint16_t keylen =3D crypto_xform->auth.key.length;
> +
> +       if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_NULL)
> +               return 0;
> +
> +       if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_MD5_HMAC) {
> +               if (keylen =3D=3D 16)
> +                       return 0;
> +       }
> +
> +       if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_SHA1_HMAC) {
> +               if (keylen >=3D 20 && keylen <=3D 64)
> +                       return 0;
> +       } else if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_SHA256_=
HMAC) {
> +               if (keylen >=3D 32 && keylen <=3D 64)
> +                       return 0;
> +       } else if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_SHA384_=
HMAC) {
> +               if (keylen =3D=3D 48)
> +                       return 0;
> +       } else if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_SHA512_=
HMAC) {
> +               if (keylen =3D=3D 64)
> +                       return 0;
> +       } else if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_AES_GMA=
C) {
> +               if (keylen >=3D 16 && keylen <=3D 32)
> +                       return 0;
> +       }
> +
> +       if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_AES_XCBC_MAC &=
&
> +           keylen =3D=3D ROC_CPT_AES_XCBC_KEY_LENGTH)
> +               return 0;
> +
> +       return -ENOTSUP;
> +}
> +
> +static inline int
> +ipsec_xform_aead_verify(struct rte_security_ipsec_xform *ipsec_xform __r=
te_unused,
> +                       struct rte_crypto_sym_xform *crypto_xform)
> +{
> +       if (crypto_xform->aead.algo =3D=3D RTE_CRYPTO_AEAD_AES_GCM ||
> +           crypto_xform->aead.algo =3D=3D RTE_CRYPTO_AEAD_AES_CCM) {
> +               switch (crypto_xform->aead.key.length) {
> +               case 16:
> +               case 24:
> +               case 32:
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +               return 0;
> +       }
> +
> +       return -ENOTSUP;
> +}
> +
> +static inline int
> +cnxk_ipsec_xform_verify(struct rte_security_ipsec_xform *ipsec_xform,
> +                       struct rte_crypto_sym_xform *crypto_xform)
> +{
> +       struct rte_crypto_sym_xform *auth_xform, *cipher_xform;
> +       int ret;
> +
> +       if ((ipsec_xform->direction !=3D RTE_SECURITY_IPSEC_SA_DIR_INGRES=
S) &&
> +           (ipsec_xform->direction !=3D RTE_SECURITY_IPSEC_SA_DIR_EGRESS=
))
> +               return -EINVAL;
> +
> +       if ((ipsec_xform->proto !=3D RTE_SECURITY_IPSEC_SA_PROTO_ESP) &&
> +           (ipsec_xform->proto !=3D RTE_SECURITY_IPSEC_SA_PROTO_AH))
> +               return -EINVAL;
> +
> +       if ((ipsec_xform->mode !=3D RTE_SECURITY_IPSEC_SA_MODE_TRANSPORT)=
 &&
> +           (ipsec_xform->mode !=3D RTE_SECURITY_IPSEC_SA_MODE_TUNNEL))
> +               return -EINVAL;
> +
> +       if ((ipsec_xform->mode =3D=3D RTE_SECURITY_IPSEC_SA_MODE_TUNNEL) =
&&
> +           (ipsec_xform->tunnel.type !=3D RTE_SECURITY_IPSEC_TUNNEL_IPV4=
) &&
> +           (ipsec_xform->tunnel.type !=3D RTE_SECURITY_IPSEC_TUNNEL_IPV6=
))
> +               return -EINVAL;
> +
> +       if (crypto_xform->type =3D=3D RTE_CRYPTO_SYM_XFORM_AEAD) {
> +               if (ipsec_xform->proto !=3D RTE_SECURITY_IPSEC_SA_PROTO_E=
SP)
> +                       return -EINVAL;
> +               return ipsec_xform_aead_verify(ipsec_xform, crypto_xform)=
;
> +       }
> +
> +       if (ipsec_xform->proto =3D=3D RTE_SECURITY_IPSEC_SA_PROTO_AH) {
> +               if (ipsec_xform->direction =3D=3D RTE_SECURITY_IPSEC_SA_D=
IR_INGRESS) {
> +                       /* Ingress */
> +                       auth_xform =3D crypto_xform;
> +                       cipher_xform =3D crypto_xform->next;
> +
> +                       if (crypto_xform->type !=3D RTE_CRYPTO_SYM_XFORM_=
AUTH)
> +                               return -EINVAL;
> +
> +                       if ((cipher_xform !=3D NULL) &&
> +                           ((cipher_xform->type !=3D RTE_CRYPTO_SYM_XFOR=
M_CIPHER) ||
> +                            (cipher_xform->cipher.algo !=3D RTE_CRYPTO_C=
IPHER_NULL)))
> +                               return -EINVAL;
> +               } else {
> +                       /* Egress */
> +                       if (crypto_xform->type =3D=3D RTE_CRYPTO_SYM_XFOR=
M_CIPHER) {
> +                               cipher_xform =3D crypto_xform;
> +                               auth_xform =3D crypto_xform->next;
> +
> +                               if (auth_xform =3D=3D NULL ||
> +                                   cipher_xform->cipher.algo !=3D RTE_CR=
YPTO_CIPHER_NULL)
> +                                       return -EINVAL;
> +                       } else if (crypto_xform->type =3D=3D RTE_CRYPTO_S=
YM_XFORM_AUTH)
> +                               auth_xform =3D crypto_xform;
> +                       else
> +                               return -EINVAL;
> +               }
> +       } else {
> +               if (crypto_xform->next =3D=3D NULL)
> +                       return -EINVAL;
> +
> +               if (ipsec_xform->direction =3D=3D RTE_SECURITY_IPSEC_SA_D=
IR_INGRESS) {
> +                       /* Ingress */
> +                       if (crypto_xform->type !=3D RTE_CRYPTO_SYM_XFORM_=
AUTH ||
> +                           crypto_xform->next->type !=3D RTE_CRYPTO_SYM_=
XFORM_CIPHER)
> +                               return -EINVAL;
> +                       auth_xform =3D crypto_xform;
> +                       cipher_xform =3D crypto_xform->next;
> +               } else {
> +                       /* Egress */
> +                       if (crypto_xform->type !=3D RTE_CRYPTO_SYM_XFORM_=
CIPHER ||
> +                           crypto_xform->next->type !=3D RTE_CRYPTO_SYM_=
XFORM_AUTH)
> +                               return -EINVAL;
> +                       cipher_xform =3D crypto_xform;
> +                       auth_xform =3D crypto_xform->next;
> +               }
> +
> +               ret =3D ipsec_xform_cipher_verify(cipher_xform);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return ipsec_xform_auth_verify(auth_xform);
> +}
> +
>  #endif /* _CNXK_SECURITY_H__ */
> diff --git a/drivers/crypto/cnxk/cnxk_ipsec.h b/drivers/crypto/cnxk/cnxk_=
ipsec.h
> index 5f65c34380..2ca3c2525c 100644
> --- a/drivers/crypto/cnxk/cnxk_ipsec.h
> +++ b/drivers/crypto/cnxk/cnxk_ipsec.h
> @@ -7,6 +7,7 @@
>  #include <rte_security.h>
>  #include <rte_security_driver.h>
>
> +#include "cnxk_security.h"
>  #include "roc_cpt.h"
>  #include "roc_ie_on.h"
>  #include "roc_ie_ot.h"
> @@ -21,186 +22,4 @@ struct cnxk_cpt_inst_tmpl {
>         uint64_t w7;
>  };
>
> -static inline int
> -ipsec_xform_cipher_verify(struct rte_crypto_sym_xform *crypto_xform)
> -{
> -       if (crypto_xform->cipher.algo =3D=3D RTE_CRYPTO_CIPHER_NULL)
> -               return 0;
> -
> -       if (crypto_xform->cipher.algo =3D=3D RTE_CRYPTO_CIPHER_DES_CBC &&
> -           crypto_xform->cipher.key.length =3D=3D 8)
> -               return 0;
> -
> -       if (crypto_xform->cipher.algo =3D=3D RTE_CRYPTO_CIPHER_AES_CBC ||
> -           crypto_xform->cipher.algo =3D=3D RTE_CRYPTO_CIPHER_AES_CTR) {
> -               switch (crypto_xform->cipher.key.length) {
> -               case 16:
> -               case 24:
> -               case 32:
> -                       break;
> -               default:
> -                       return -ENOTSUP;
> -               }
> -               return 0;
> -       }
> -
> -       if (crypto_xform->cipher.algo =3D=3D RTE_CRYPTO_CIPHER_3DES_CBC &=
&
> -           crypto_xform->cipher.key.length =3D=3D 24)
> -               return 0;
> -
> -       return -ENOTSUP;
> -}
> -
> -static inline int
> -ipsec_xform_auth_verify(struct rte_crypto_sym_xform *crypto_xform)
> -{
> -       uint16_t keylen =3D crypto_xform->auth.key.length;
> -
> -       if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_NULL)
> -               return 0;
> -
> -       if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_MD5_HMAC) {
> -               if (keylen =3D=3D 16)
> -                       return 0;
> -       }
> -
> -       if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_SHA1_HMAC) {
> -               if (keylen >=3D 20 && keylen <=3D 64)
> -                       return 0;
> -       } else if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_SHA256_=
HMAC) {
> -               if (keylen >=3D 32 && keylen <=3D 64)
> -                       return 0;
> -       } else if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_SHA384_=
HMAC) {
> -               if (keylen =3D=3D 48)
> -                       return 0;
> -       } else if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_SHA512_=
HMAC) {
> -               if (keylen =3D=3D 64)
> -                       return 0;
> -       } else if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_AES_GMA=
C) {
> -               if (keylen >=3D 16 && keylen <=3D 32)
> -                       return 0;
> -       }
> -
> -       if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_AES_XCBC_MAC &=
&
> -           keylen =3D=3D ROC_CPT_AES_XCBC_KEY_LENGTH)
> -               return 0;
> -
> -       return -ENOTSUP;
> -}
> -
> -static inline int
> -ipsec_xform_aead_verify(struct rte_security_ipsec_xform *ipsec_xform,
> -                       struct rte_crypto_sym_xform *crypto_xform)
> -{
> -       if (ipsec_xform->direction =3D=3D RTE_SECURITY_IPSEC_SA_DIR_EGRES=
S &&
> -           crypto_xform->aead.op !=3D RTE_CRYPTO_AEAD_OP_ENCRYPT)
> -               return -EINVAL;
> -
> -       if (ipsec_xform->direction =3D=3D RTE_SECURITY_IPSEC_SA_DIR_INGRE=
SS &&
> -           crypto_xform->aead.op !=3D RTE_CRYPTO_AEAD_OP_DECRYPT)
> -               return -EINVAL;
> -
> -       if (crypto_xform->aead.algo =3D=3D RTE_CRYPTO_AEAD_AES_GCM ||
> -           crypto_xform->aead.algo =3D=3D RTE_CRYPTO_AEAD_AES_CCM) {
> -               switch (crypto_xform->aead.key.length) {
> -               case 16:
> -               case 24:
> -               case 32:
> -                       break;
> -               default:
> -                       return -EINVAL;
> -               }
> -               return 0;
> -       }
> -
> -       return -ENOTSUP;
> -}
> -
> -static inline int
> -cnxk_ipsec_xform_verify(struct rte_security_ipsec_xform *ipsec_xform,
> -                       struct rte_crypto_sym_xform *crypto_xform)
> -{
> -       struct rte_crypto_sym_xform *auth_xform, *cipher_xform;
> -       int ret;
> -
> -       if ((ipsec_xform->direction !=3D RTE_SECURITY_IPSEC_SA_DIR_INGRES=
S) &&
> -           (ipsec_xform->direction !=3D RTE_SECURITY_IPSEC_SA_DIR_EGRESS=
))
> -               return -EINVAL;
> -
> -       if ((ipsec_xform->proto !=3D RTE_SECURITY_IPSEC_SA_PROTO_ESP) &&
> -           (ipsec_xform->proto !=3D RTE_SECURITY_IPSEC_SA_PROTO_AH))
> -               return -EINVAL;
> -
> -       if ((ipsec_xform->mode !=3D RTE_SECURITY_IPSEC_SA_MODE_TRANSPORT)=
 &&
> -           (ipsec_xform->mode !=3D RTE_SECURITY_IPSEC_SA_MODE_TUNNEL))
> -               return -EINVAL;
> -
> -       if ((ipsec_xform->mode =3D=3D RTE_SECURITY_IPSEC_SA_MODE_TUNNEL) =
&&
> -           (ipsec_xform->tunnel.type !=3D RTE_SECURITY_IPSEC_TUNNEL_IPV4=
) &&
> -           (ipsec_xform->tunnel.type !=3D RTE_SECURITY_IPSEC_TUNNEL_IPV6=
))
> -               return -EINVAL;
> -
> -       if (crypto_xform->type =3D=3D RTE_CRYPTO_SYM_XFORM_AEAD)
> -               return ipsec_xform_aead_verify(ipsec_xform, crypto_xform)=
;
> -
> -       if (ipsec_xform->proto =3D=3D RTE_SECURITY_IPSEC_SA_PROTO_AH) {
> -               if (ipsec_xform->direction =3D=3D RTE_SECURITY_IPSEC_SA_D=
IR_INGRESS) {
> -                       /* Ingress */
> -                       auth_xform =3D crypto_xform;
> -                       cipher_xform =3D crypto_xform->next;
> -
> -                       if (crypto_xform->type !=3D RTE_CRYPTO_SYM_XFORM_=
AUTH)
> -                               return -EINVAL;
> -
> -                       if ((cipher_xform !=3D NULL) && ((cipher_xform->t=
ype !=3D
> -                           RTE_CRYPTO_SYM_XFORM_CIPHER) ||
> -                           (cipher_xform->cipher.algo !=3D
> -                           RTE_CRYPTO_CIPHER_NULL)))
> -                               return -EINVAL;
> -               } else {
> -                               /* Egress */
> -                       if (crypto_xform->type =3D=3D RTE_CRYPTO_SYM_XFOR=
M_CIPHER) {
> -                               cipher_xform =3D crypto_xform;
> -                               auth_xform =3D crypto_xform->next;
> -
> -                               if (auth_xform =3D=3D NULL ||
> -                                   cipher_xform->cipher.algo !=3D
> -                                   RTE_CRYPTO_CIPHER_NULL)
> -                                       return -EINVAL;
> -                       } else if (crypto_xform->type =3D=3D
> -                                  RTE_CRYPTO_SYM_XFORM_AUTH)
> -                               auth_xform =3D crypto_xform;
> -                       else
> -                               return -EINVAL;
> -               }
> -       } else {
> -               if (crypto_xform->next =3D=3D NULL)
> -                       return -EINVAL;
> -
> -               if (ipsec_xform->direction =3D=3D
> -                   RTE_SECURITY_IPSEC_SA_DIR_INGRESS) {
> -                       /* Ingress */
> -                       if (crypto_xform->type !=3D RTE_CRYPTO_SYM_XFORM_=
AUTH ||
> -                           crypto_xform->next->type !=3D
> -                                   RTE_CRYPTO_SYM_XFORM_CIPHER)
> -                               return -EINVAL;
> -                       auth_xform =3D crypto_xform;
> -                       cipher_xform =3D crypto_xform->next;
> -               } else {
> -                       /* Egress */
> -                       if (crypto_xform->type !=3D RTE_CRYPTO_SYM_XFORM_=
CIPHER ||
> -                           crypto_xform->next->type !=3D
> -                                   RTE_CRYPTO_SYM_XFORM_AUTH)
> -                               return -EINVAL;
> -                       cipher_xform =3D crypto_xform;
> -                       auth_xform =3D crypto_xform->next;
> -               }
> -
> -               ret =3D ipsec_xform_cipher_verify(cipher_xform);
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       return ipsec_xform_auth_verify(auth_xform);
> -}
>  #endif /* __CNXK_IPSEC_H__ */
> diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k=
_ethdev_sec.c
> index 2f1fdf34fc..0682294099 100644
> --- a/drivers/net/cnxk/cn10k_ethdev_sec.c
> +++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
> @@ -785,6 +785,13 @@ cn10k_eth_sec_session_create(void *device,
>
>         ipsec =3D &conf->ipsec;
>         crypto =3D conf->crypto_xform;
> +
> +       rc =3D cnxk_ipsec_xform_verify(ipsec, crypto);
> +       if (rc) {
> +               plt_err("Crypto xform verify failed, rc=3D%d", rc);
> +               return rc;
> +       }
> +
>         inbound =3D !!(ipsec->direction =3D=3D RTE_SECURITY_IPSEC_SA_DIR_=
INGRESS);
>         inl_dev =3D !!dev->inb.inl_dev;
>
> diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k=
_ethdev_sec.c
> index a5be85901f..65f0235a46 100644
> --- a/drivers/net/cnxk/cn20k_ethdev_sec.c
> +++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
> @@ -817,6 +817,13 @@ cn20k_eth_sec_session_create(void *device, struct rt=
e_security_session_conf *con
>
>         ipsec =3D &conf->ipsec;
>         crypto =3D conf->crypto_xform;
> +
> +       rc =3D cnxk_ipsec_xform_verify(ipsec, crypto);
> +       if (rc) {
> +               plt_err("Crypto xform verify failed, rc=3D%d", rc);
> +               return rc;
> +       }
> +
>         inbound =3D !!(ipsec->direction =3D=3D RTE_SECURITY_IPSEC_SA_DIR_=
INGRESS);
>         inl_dev =3D !!dev->inb.inl_dev;
>
> diff --git a/drivers/net/cnxk/cn9k_ethdev_sec.c b/drivers/net/cnxk/cn9k_e=
thdev_sec.c
> index 5e13dc862e..4024b243d7 100644
> --- a/drivers/net/cnxk/cn9k_ethdev_sec.c
> +++ b/drivers/net/cnxk/cn9k_ethdev_sec.c
> @@ -602,6 +602,13 @@ cn9k_eth_sec_session_create(void *device,
>
>         ipsec =3D &conf->ipsec;
>         crypto =3D conf->crypto_xform;
> +
> +       rc =3D cnxk_ipsec_xform_verify(ipsec, crypto);
> +       if (rc) {
> +               plt_err("Crypto xform verify failed, rc=3D%d", rc);
> +               return rc;
> +       }
> +
>         inbound =3D !!(ipsec->direction =3D=3D RTE_SECURITY_IPSEC_SA_DIR_=
INGRESS);
>
>         lock =3D inbound ? &dev->inb.lock : &dev->outb.lock;
> --
> 2.43.0
>
