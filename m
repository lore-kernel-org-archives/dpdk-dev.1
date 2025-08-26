Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADEDC8303F
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 01:58:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C3BB4021E;
	Tue, 26 Aug 2025 03:58:52 +0200 (CEST)
Received: from mail-oi1-f228.google.com (mail-oi1-f228.google.com
 [209.85.167.228])
 by mails.dpdk.org (Postfix) with ESMTP id 30DE840156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 03:58:51 +0200 (CEST)
Received: by mail-oi1-f228.google.com with SMTP id
 5614622812f47-437b6a8d766so619938b6e.0
 for <dev@dpdk.org>; Mon, 25 Aug 2025 18:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756173530; x=1756778330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fpmJ7c8vZK+otYKxkQ14GK+V+ZPkDzgoLy1iI3GGr1o=;
 b=btzfoHEzrEmjz1872VXbJbGEq6cexqrB6u7hmd6I9eTXBdgrGX2qHaRQGT633DPAt1
 Skbqtru4OxAPrTjdOJ8PPm3WMPrcPUO32ZwqnZ903kHVLHJZe5C3g1OywkRX+hnREdif
 tcYtARkdLhNe/divFDpQBhIgXOA7mwnLJETDj65pbExt/dD6SIClBwM4hmYUN6t52Anl
 plwDtkjNDdWY1/gQfKOcVk0f8bLJWQrDHrPi1m+XSAtN4T5aSMUz/yRODojcAt3vDN8D
 iY9lAa9neblPXVsFP5KC9aUtsPY6x6eNgMQvyscF4L2YoltN2//AnDOiQsrgfezDTXkj
 STqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFfLN8ZuOBwha2TlHIYzM2TPFHH2vdY8YqPyTzjhN+ufCtY50S97SfFlApI4NjrOSxnFc=@dpdk.org
X-Gm-Message-State: AOJu0YyJ5PJdcuqwdiOvWQ5c6QPZAkH58GXnBhmGMTOxC/xelZvJXmxo
 xxqHkdeeYhriCAY1bKPfzFlEJI5TghWp8pRG63NYWgCtS55yDXEA8kubyveSk1r+IxBsrI/ICFt
 61RxYt5AB2iAMOs4jQXZwXcAiU43odEH8t28Az85bsguRqClvY5X2z03fEJb6LmaC7na3tb64L4
 l8LCJyk1yORDtljfE7sruCQ/zQXgPGjwDqhbtxg/yTLHCESMMVBmvWFwpyorLu+odAwAfz6Go=
X-Gm-Gg: ASbGnctlxv6Lt71RXqC6yy6wLPz10L+lL2aDgpSxHgEerAl8m9rbxSUtDnXc9toZmmd
 qzREKNIBkjeEHQKpF26RduA4xXp5ORDXy5qDf4HIMjwN+4DmeieF8ZwQ7yUAVMPAube7ISahwsf
 qJC08/DtZ9IBdR7K8Zq2xGBabBsKgqKf2dlms6rF6loVmlay7YWiDeF1nF6lgOoF0zmQk2yw2mg
 59SLBvVfXBQrqTN4c3PjX+2JIF0g/dhx9gsQBOPglKIi5C86sdzUoEXnfNn3O+sok6QEUWcU+rp
 rLkjHb2v08jUjRby1S5xzLUUC7YkTFbk0Rep8hBtWI53l7F4/XlgAq/hgVxSh7OB6nZkAYv6XV6
 sUtFhE8ACeO1Lp2P9+ytP5yh9gm0AUDOjuyX3PuPOblNwiYwxiUnOx6ceOMuhIYjrgdIuy7vA/Y
 xA
X-Google-Smtp-Source: AGHT+IEHNZ/QLLPswXfOVBcvtJz8Z6EBfvECrOEww7qp6OXIzMqvcNfoVvC+h6sZQq6Hy0HWVOA60uoh2+iQ
X-Received: by 2002:a05:6808:4fe5:b0:435:73cc:5b6c with SMTP id
 5614622812f47-43785196ffcmr6147079b6e.3.1756173530208; 
 Mon, 25 Aug 2025 18:58:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-314f88448d6sm896951fac.26.2025.08.25.18.58.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Aug 2025 18:58:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-50f8ba4f57aso4335733137.3
 for <dev@dpdk.org>; Mon, 25 Aug 2025 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1756173529; x=1756778329; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fpmJ7c8vZK+otYKxkQ14GK+V+ZPkDzgoLy1iI3GGr1o=;
 b=XKVb0ZDoQ0klTumueGc5tpZ1RrOkfwXjq82ld7d5+9PLetZlwa0AxBk8YWG7ACSm9i
 UiG5qFeuJsc2Kf8P9PyY2V29QyNjXycJdP3+M7DB8T//iMf+cMrRcPgx7YN68A7TQij2
 cI0YEwdwl/trsf32ntEpLp21bi7VI+pnnc7fI=
X-Forwarded-Encrypted: i=1;
 AJvYcCX5QVtC3OSg4AFZfCd25yE8theDSTaXQZ5fUi1UiUJeojpffgeRukY5Xjl9+1XBXterzOA=@dpdk.org
X-Received: by 2002:a05:6102:2c0d:b0:4f9:6a91:cc97 with SMTP id
 ada2fe7eead31-51d0f2f98b9mr4721222137.27.1756173529042; 
 Mon, 25 Aug 2025 18:58:49 -0700 (PDT)
X-Received: by 2002:a05:6102:2c0d:b0:4f9:6a91:cc97 with SMTP id
 ada2fe7eead31-51d0f2f98b9mr4721215137.27.1756173528601; Mon, 25 Aug 2025
 18:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250825092719.882769-1-david.marchand@redhat.com>
 <CACZ4nhv6VvXfbuR-fKJgVXwkYoxi5j_R5hY3A-ujJn3CUTqu0g@mail.gmail.com>
In-Reply-To: <CACZ4nhv6VvXfbuR-fKJgVXwkYoxi5j_R5hY3A-ujJn3CUTqu0g@mail.gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Tue, 26 Aug 2025 07:28:36 +0530
X-Gm-Features: Ac12FXyfR6RKPj3xTuVzkIBMWlrKYabfCdfyhgdjtPi8Kti1SYnvhnTZgp942WY
Message-ID: <CAOBf=mvx-bsM49iBUZdA9vPAtTEmH1y9qLc6pXTVdGOQGHYsYA@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: remove dead code under DPDK version check
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000063147a063d3b0373"
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

--00000000000063147a063d3b0373
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM Ajit Khaparde
<ajit.khaparde@broadcom.com> wrote:
>
> On Mon, Aug 25, 2025 at 2:28=E2=80=AFAM David Marchand
> <david.marchand@redhat.com> wrote:
> >
> > There is no good reason to keep code for older versions of DPDK in the
> > main branch.
> ACK.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
>
> > ---
> >  drivers/net/bnxt/bnxt_cpr.h              |  2 --
> >  drivers/net/bnxt/bnxt_ethdev.c           |  5 ----
> >  drivers/net/bnxt/bnxt_reps.c             |  7 +-----
> >  drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c  |  2 --
> >  drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c    |  2 --
> >  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c   |  2 --
> >  drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h | 31 ------------------------
> >  7 files changed, 1 insertion(+), 50 deletions(-)
> >
> > diff --git a/drivers/net/bnxt/bnxt_cpr.h b/drivers/net/bnxt/bnxt_cpr.h
> > index 489dab6b15..94f449e8b5 100644
> > --- a/drivers/net/bnxt/bnxt_cpr.h
> > +++ b/drivers/net/bnxt/bnxt_cpr.h
> > @@ -119,9 +119,7 @@ bool bnxt_is_recovery_enabled(struct bnxt *bp);
> >  bool bnxt_is_primary_func(struct bnxt *bp);
> >
> >  void bnxt_stop_rxtx(struct rte_eth_dev *eth_dev);
> > -#if (RTE_VERSION_NUM(21, 8, 0, 0) < RTE_VERSION)
> >  void bnxt_start_rxtx(struct rte_eth_dev *eth_dev);
> > -#endif
> >
> >  /**
> >   * Check validity of a completion ring entry. If the entry is valid, i=
nclude a
> > diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_eth=
dev.c
> > index 8213ff9e4b..cace6e8e17 100644
> > --- a/drivers/net/bnxt/bnxt_ethdev.c
> > +++ b/drivers/net/bnxt/bnxt_ethdev.c
> > @@ -4309,7 +4309,6 @@ static int bnxt_get_module_eeprom(struct rte_eth_=
dev *dev,
> >         return length ? -EINVAL : 0;
> >  }
> >
> > -#if (RTE_VERSION_NUM(22, 11, 0, 0) <=3D RTE_VERSION)
> >  static int bnxt_speed_lanes_set(struct rte_eth_dev *dev, uint32_t spee=
d_lanes)
> >  {
> >         struct bnxt *bp =3D dev->data->dev_private;
> > @@ -4406,8 +4405,6 @@ static int bnxt_speed_lanes_get(struct rte_eth_de=
v *dev, uint32_t *lanes)
> >         return 0;
> >  }
> >
> > -#endif
> > -
> >  /*
> >   * Initialization
> >   */
> > @@ -4479,11 +4476,9 @@ static const struct eth_dev_ops bnxt_dev_ops =3D=
 {
> >         .timesync_read_rx_timestamp =3D bnxt_timesync_read_rx_timestamp=
,
> >         .timesync_read_tx_timestamp =3D bnxt_timesync_read_tx_timestamp=
,
> >         .mtr_ops_get =3D bnxt_flow_meter_ops_get,
> > -#if (RTE_VERSION_NUM(22, 11, 0, 0) <=3D RTE_VERSION)
> >         .speed_lanes_get =3D bnxt_speed_lanes_get,
> >         .speed_lanes_set =3D bnxt_speed_lanes_set,
> >         .speed_lanes_get_capa =3D bnxt_speed_lanes_get_capa,
> > -#endif
> >  };
> >
> >  static uint32_t bnxt_map_reset_regs(struct bnxt *bp, uint32_t reg)
> > diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.=
c
> > index 6f5c3f80eb..43e4085434 100644
> > --- a/drivers/net/bnxt/bnxt_reps.c
> > +++ b/drivers/net/bnxt/bnxt_reps.c
> > @@ -766,13 +766,8 @@ int bnxt_rep_rx_queue_setup_op(struct rte_eth_dev =
*eth_dev,
> >         return 0;
> >
> >  out:
> > -       if (rxq) {
> > - #if (RTE_VERSION_NUM(21, 8, 0, 0) < RTE_VERSION)
> > +       if (rxq)
> >                 bnxt_rep_rx_queue_release_op(eth_dev, queue_idx);
> > - #else
> > -               bnxt_rx_queue_release_op(rxq);
> > - #endif
> > -       }
> >
> >         return rc;
> >  }
> > diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c b/drivers/net/bnxt=
/tf_ulp/bnxt_ulp_flow.c
> > index 2c22582e1c..ab02b01b46 100644
> > --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c
> > +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c
> > @@ -75,10 +75,8 @@ bnxt_ulp_set_dir_attributes(struct ulp_rte_parser_pa=
rams *params,
> >                 params->dir_attr |=3D BNXT_ULP_FLOW_ATTR_EGRESS;
> >         if (attr->ingress)
> >                 params->dir_attr |=3D BNXT_ULP_FLOW_ATTR_INGRESS;
> > -#if RTE_VERSION_NUM(17, 11, 10, 16) < RTE_VERSION
> >         if (attr->transfer)
> >                 params->dir_attr |=3D BNXT_ULP_FLOW_ATTR_TRANSFER;
> > -#endif
> >         if (attr->group) {
> >                 ULP_COMP_FLD_IDX_WR(params, BNXT_ULP_CF_IDX_GROUP_ID,
> >                                     rte_cpu_to_le_32(attr->group));
> > diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/t=
f_ulp/bnxt_ulp_tf.c
> > index 4a1ccfa2a3..e3eb9107ab 100644
> > --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
> > +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
> > @@ -1613,9 +1613,7 @@ ulp_tf_mtr_cap_get(struct bnxt *bp,
> >                 return -EINVAL;
> >         }
> >
> > -#if (RTE_VERSION_NUM(21, 05, 0, 0) <=3D RTE_VERSION)
> >         cap->srtcm_rfc2697_byte_mode_supported =3D 1;
> > -#endif
> >         cap->n_shared_max =3D cap->n_max;
> >         /* No meter is identical */
> >         cap->identical =3D 1;
> > diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/=
tf_ulp/bnxt_ulp_tfc.c
> > index 508c194d04..c20aea1966 100644
> > --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> > +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> > @@ -1087,9 +1087,7 @@ static int
> >  ulp_tfc_mtr_cap_get(struct bnxt *bp __rte_unused,
> >                     struct rte_mtr_capabilities *cap)
> >  {
> > -#if (RTE_VERSION_NUM(21, 05, 0, 0) <=3D RTE_VERSION)
> >         cap->srtcm_rfc2697_byte_mode_supported =3D 1;
> > -#endif
> >         cap->n_max =3D MAX_NUM_METER;
> >         cap->n_shared_max =3D cap->n_max;
> >         /* No meter is identical */
> > diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnx=
t/tf_ulp/bnxt_ulp_utils.h
> > index e6f316539c..daa3be64a7 100644
> > --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
> > +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
> > @@ -814,35 +814,6 @@ bnxt_ulp_cntxt_release_fdb_lock(struct bnxt_ulp_co=
ntext    *ulp_ctx)
> >         pthread_mutex_unlock(&ulp_ctx->cfg_data->flow_db_lock);
> >  }
> >
> > -#if (RTE_VERSION_NUM(21, 05, 0, 0) > RTE_VERSION)
> > -
> > -/* Function to extract the action type from the shared action handle. =
*/
> > -static inline uint32_t
> > -bnxt_get_shared_action_type(const struct rte_flow_shared_action *handl=
e)
> > -{
> > -       return (uint32_t)(((uint64_t)handle >> 32) & 0xffffffff);
> > -}
> > -
> > -/* Function to extract the direction from the shared action handle. */
> > -static inline uint32_t
> > -bnxt_get_shared_action_direction(const struct rte_flow_shared_action *=
handle)
> > -{
> > -       uint32_t shared_type;
> > -
> > -       shared_type =3D bnxt_get_shared_action_type(handle);
> > -       return shared_type & 0x1 ? BNXT_ULP_FLOW_ATTR_EGRESS :
> > -               BNXT_ULP_FLOW_ATTR_INGRESS;
> > -}
> > -
> > -/* Function to extract the action index from the shared action handle.=
 */
> > -static inline uint32_t
> > -bnxt_get_shared_action_index(const struct rte_flow_shared_action *hand=
le)
> > -{
> > -       return (uint32_t)((uint64_t)handle & 0xffffffff);
> > -}
> > -
> > -#else /* (RTE_VERSION >=3D RTE_VERSION_NUM(21,05,0,0)) */
> > -
> >  /* Function to extract the action type from the shared action handle. =
*/
> >  static inline int32_t
> >  bnxt_get_action_handle_type(const struct rte_flow_action_handle *handl=
e,
> > @@ -882,8 +853,6 @@ bnxt_get_action_handle_index(const struct rte_flow_=
action_handle *handle)
> >         return (uint32_t)((uint64_t)handle & 0xffffffff);
> >  }
> >
> > -#endif /* RTE_VERSION < RTE_VERSION_NUM(21,05,0,0) */
> > -
> >  /* Function to set the ha info into the context */
> >  static inline int32_t
> >  bnxt_ulp_cntxt_ptr2_ha_info_set(struct bnxt_ulp_context *ulp_ctx,
> > --
> > 2.51.0
> >
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--00000000000063147a063d3b0373
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJg
MIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEkdVx+dLy9rz6sz1o7vUeEsqKGp
1+J3CYjXJ6A516IKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDgyNjAxNTg0OVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBALWSRDynICT+DMedo5EOwNPUlFr9ScfEd5SLbDlinn9Vn+5RttYg2nwXQ/RSsJDK
kRG5eIIvMH6UviIGo/Te0NxFmNpTsvybVKJZUBZXaGk7fSSaJDzx/lAARUrBcE9FrRR7bF6+3uaQ
s2r1Z6e5zA6s6c2pD6p1oqkWIB5V7LRJ/KaWGx3MepTZu7PqEOoqKoAPJdHHJjG9digV2q1Kqilv
y6Ii0W1m9ZgSIocUIuf5cKGL6QQIyIKBfYoLX3UNlQ263g9563iRv7UN7zImdIiAfhqaCo7sxT0w
gsgsRiCN9ZU5fjXtuNlUzCCP2q2AdodIw1bqik539FjreI4aQQ0=
--00000000000063147a063d3b0373--
