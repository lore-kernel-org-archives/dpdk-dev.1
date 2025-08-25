Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886DFCA0FE7
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 15:28:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 943D44021E;
	Mon, 25 Aug 2025 17:28:55 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id 88F7F40156
 for <dev@dpdk.org>; Mon, 25 Aug 2025 17:28:54 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-b475dfb4f42so3046302a12.0
 for <dev@dpdk.org>; Mon, 25 Aug 2025 08:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756135733; x=1756740533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aPTMpuFsSN+IsIqmO0S5ztKM7NdUM+5NXbqNMq5t3VE=;
 b=J+OICBl4BODydGSCeCM5bPWYWV/8ETvC3HcgsaL3O4I44ASRy2+GbhYpXgMjYJxPRa
 9avuYQxIYbFF9ilcIkqvIMzR99nGHUi7wHPIV0Gte0JXEYd+aR7WBqEYehM919Bh6EuW
 wyxL6PJ3/ZwTTQojrNcecpzK09gLyel2BCsy/8fldymM6I4WXA+BSpPQ9YgwBjASU90L
 bwGV2ldcceh0oIq8Z/t4HhddIH5NorMcIXT+mgHTTLM8EI26mv8sqUb5AMbdQu2/zkfv
 R41RgX0zav4DAfxNRkCMclLFdACGQk+BCZuF3SbrpYV+OoMGZqvM2U43Amk2NLjnALGj
 Xnvg==
X-Gm-Message-State: AOJu0YxeoZa+47hJp+7DKnLf2umYVEO9ER9hnDT9BAXVT2jT1l7gayl/
 V09LR6p7fz9IgyFmEbsjTkOw77fk0BbF3ZN6iCFBmvoUSi1Sig6XgHWnSDe+udBnnpw8O3JwmIs
 T2pkgw18/YP5M0bPfA5S5jWLnHpf0e/EGk488wtNa/M18+GBZhlA+BHsu5lljBl5ySLgHMQK74s
 dK7bhxYz7UpgziLBR01vKq1jDaUBqwRRpGjDGA6mHrg6hCA0ac1WntBeYBcqpbtFFWieEjOmo=
X-Gm-Gg: ASbGnctzlz6pfD8qoRX1NtO++IkqoGZ3vThxRHrCf16ejFlKkpwva02JP9hux624Usm
 3cT0nmZ5SAO0n4jMaNwkbFRSE+I2oLHi7lrxX+fh7Qx4m3k9XQW1ojdon2qIYDfQpbCQJqxHSdW
 eGTkhQsK0DdCK2iFN0NkZFAcX19hZT9d+CdJOI8qpA8/1m9361vbjKAUDyanHtbL3wH4QCbpFLq
 V/2Ngd6vQz3gLOJzWWn2pL5QKyqLxFxgDWZt8QwiHFAY15b7KNA+bst5pC+5wQzNhiM5gpawXGn
 YqppCkISU3xTe71h3v36imgr0JFTkbjk/dEGNNovqpjAjc4KIwfnkvgxWtj7sJr4KylxMIgD28O
 dwHGg3HD1l7zKS7tuLglrbMivLAbuLwHnf0jWRLRzA5tpidEDYWWf0E+mAqLNywnXu3AwoBjGNk
 xh
X-Google-Smtp-Source: AGHT+IFnzcwLIHMAHX0nMD7XDNRRdtYabDNAgkog81R197PHJLZ0g2MPBlUIwGFA2m6CEPUkpZ5eIS1WrnaV
X-Received: by 2002:a17:902:c405:b0:240:99e6:6bc3 with SMTP id
 d9443c01a7336-2462ee48b16mr169146655ad.20.1756135733242; 
 Mon, 25 Aug 2025 08:28:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-246688ae084sm6346175ad.76.2025.08.25.08.28.52
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Aug 2025 08:28:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70d903d04dbso87314786d6.0
 for <dev@dpdk.org>; Mon, 25 Aug 2025 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1756135732; x=1756740532; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aPTMpuFsSN+IsIqmO0S5ztKM7NdUM+5NXbqNMq5t3VE=;
 b=FzLWfl7Azcso+aHkMmHAwNT+aKEBuDAl7DQMD4176g2PiBUq79gv/jZry3VQBYH4ky
 QAkJ1Kq63O4HF50erK7fTvq78HnpkULV1JfMUohoUPRskx7Kl3WAjjhTWP82/TJbAoBk
 nvpzfj5PhuvBGXFZAhxO+EMsAUDLrpD0s5VoQ=
X-Received: by 2002:a05:6214:d0e:b0:70d:857c:a1c9 with SMTP id
 6a1803df08f44-70d97350721mr151533356d6.62.1756135731683; 
 Mon, 25 Aug 2025 08:28:51 -0700 (PDT)
X-Received: by 2002:a05:6214:d0e:b0:70d:857c:a1c9 with SMTP id
 6a1803df08f44-70d97350721mr151533076d6.62.1756135731139; Mon, 25 Aug 2025
 08:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250825092719.882769-1-david.marchand@redhat.com>
In-Reply-To: <20250825092719.882769-1-david.marchand@redhat.com>
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
Date: Mon, 25 Aug 2025 08:28:32 -0700
X-Gm-Features: Ac12FXwNpQULU5bFV4F6J1bXS-dSjKiT9dQJYBvX-Qfh112w8bO6v5aY7Jl9SBM
Message-ID: <CACZ4nhv6VvXfbuR-fKJgVXwkYoxi5j_R5hY3A-ujJn3CUTqu0g@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: remove dead code under DPDK version check
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Somnath Kotur <somnath.kotur@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000007ff367063d3236bb"
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

--0000000000007ff367063d3236bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 2:28=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> There is no good reason to keep code for older versions of DPDK in the
> main branch.
ACK.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>

> ---
>  drivers/net/bnxt/bnxt_cpr.h              |  2 --
>  drivers/net/bnxt/bnxt_ethdev.c           |  5 ----
>  drivers/net/bnxt/bnxt_reps.c             |  7 +-----
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c  |  2 --
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c    |  2 --
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c   |  2 --
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h | 31 ------------------------
>  7 files changed, 1 insertion(+), 50 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_cpr.h b/drivers/net/bnxt/bnxt_cpr.h
> index 489dab6b15..94f449e8b5 100644
> --- a/drivers/net/bnxt/bnxt_cpr.h
> +++ b/drivers/net/bnxt/bnxt_cpr.h
> @@ -119,9 +119,7 @@ bool bnxt_is_recovery_enabled(struct bnxt *bp);
>  bool bnxt_is_primary_func(struct bnxt *bp);
>
>  void bnxt_stop_rxtx(struct rte_eth_dev *eth_dev);
> -#if (RTE_VERSION_NUM(21, 8, 0, 0) < RTE_VERSION)
>  void bnxt_start_rxtx(struct rte_eth_dev *eth_dev);
> -#endif
>
>  /**
>   * Check validity of a completion ring entry. If the entry is valid, inc=
lude a
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethde=
v.c
> index 8213ff9e4b..cace6e8e17 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -4309,7 +4309,6 @@ static int bnxt_get_module_eeprom(struct rte_eth_de=
v *dev,
>         return length ? -EINVAL : 0;
>  }
>
> -#if (RTE_VERSION_NUM(22, 11, 0, 0) <=3D RTE_VERSION)
>  static int bnxt_speed_lanes_set(struct rte_eth_dev *dev, uint32_t speed_=
lanes)
>  {
>         struct bnxt *bp =3D dev->data->dev_private;
> @@ -4406,8 +4405,6 @@ static int bnxt_speed_lanes_get(struct rte_eth_dev =
*dev, uint32_t *lanes)
>         return 0;
>  }
>
> -#endif
> -
>  /*
>   * Initialization
>   */
> @@ -4479,11 +4476,9 @@ static const struct eth_dev_ops bnxt_dev_ops =3D {
>         .timesync_read_rx_timestamp =3D bnxt_timesync_read_rx_timestamp,
>         .timesync_read_tx_timestamp =3D bnxt_timesync_read_tx_timestamp,
>         .mtr_ops_get =3D bnxt_flow_meter_ops_get,
> -#if (RTE_VERSION_NUM(22, 11, 0, 0) <=3D RTE_VERSION)
>         .speed_lanes_get =3D bnxt_speed_lanes_get,
>         .speed_lanes_set =3D bnxt_speed_lanes_set,
>         .speed_lanes_get_capa =3D bnxt_speed_lanes_get_capa,
> -#endif
>  };
>
>  static uint32_t bnxt_map_reset_regs(struct bnxt *bp, uint32_t reg)
> diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
> index 6f5c3f80eb..43e4085434 100644
> --- a/drivers/net/bnxt/bnxt_reps.c
> +++ b/drivers/net/bnxt/bnxt_reps.c
> @@ -766,13 +766,8 @@ int bnxt_rep_rx_queue_setup_op(struct rte_eth_dev *e=
th_dev,
>         return 0;
>
>  out:
> -       if (rxq) {
> - #if (RTE_VERSION_NUM(21, 8, 0, 0) < RTE_VERSION)
> +       if (rxq)
>                 bnxt_rep_rx_queue_release_op(eth_dev, queue_idx);
> - #else
> -               bnxt_rx_queue_release_op(rxq);
> - #endif
> -       }
>
>         return rc;
>  }
> diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c b/drivers/net/bnxt/t=
f_ulp/bnxt_ulp_flow.c
> index 2c22582e1c..ab02b01b46 100644
> --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c
> +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c
> @@ -75,10 +75,8 @@ bnxt_ulp_set_dir_attributes(struct ulp_rte_parser_para=
ms *params,
>                 params->dir_attr |=3D BNXT_ULP_FLOW_ATTR_EGRESS;
>         if (attr->ingress)
>                 params->dir_attr |=3D BNXT_ULP_FLOW_ATTR_INGRESS;
> -#if RTE_VERSION_NUM(17, 11, 10, 16) < RTE_VERSION
>         if (attr->transfer)
>                 params->dir_attr |=3D BNXT_ULP_FLOW_ATTR_TRANSFER;
> -#endif
>         if (attr->group) {
>                 ULP_COMP_FLD_IDX_WR(params, BNXT_ULP_CF_IDX_GROUP_ID,
>                                     rte_cpu_to_le_32(attr->group));
> diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/tf_=
ulp/bnxt_ulp_tf.c
> index 4a1ccfa2a3..e3eb9107ab 100644
> --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
> +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
> @@ -1613,9 +1613,7 @@ ulp_tf_mtr_cap_get(struct bnxt *bp,
>                 return -EINVAL;
>         }
>
> -#if (RTE_VERSION_NUM(21, 05, 0, 0) <=3D RTE_VERSION)
>         cap->srtcm_rfc2697_byte_mode_supported =3D 1;
> -#endif
>         cap->n_shared_max =3D cap->n_max;
>         /* No meter is identical */
>         cap->identical =3D 1;
> diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf=
_ulp/bnxt_ulp_tfc.c
> index 508c194d04..c20aea1966 100644
> --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> @@ -1087,9 +1087,7 @@ static int
>  ulp_tfc_mtr_cap_get(struct bnxt *bp __rte_unused,
>                     struct rte_mtr_capabilities *cap)
>  {
> -#if (RTE_VERSION_NUM(21, 05, 0, 0) <=3D RTE_VERSION)
>         cap->srtcm_rfc2697_byte_mode_supported =3D 1;
> -#endif
>         cap->n_max =3D MAX_NUM_METER;
>         cap->n_shared_max =3D cap->n_max;
>         /* No meter is identical */
> diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/=
tf_ulp/bnxt_ulp_utils.h
> index e6f316539c..daa3be64a7 100644
> --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
> +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
> @@ -814,35 +814,6 @@ bnxt_ulp_cntxt_release_fdb_lock(struct bnxt_ulp_cont=
ext    *ulp_ctx)
>         pthread_mutex_unlock(&ulp_ctx->cfg_data->flow_db_lock);
>  }
>
> -#if (RTE_VERSION_NUM(21, 05, 0, 0) > RTE_VERSION)
> -
> -/* Function to extract the action type from the shared action handle. */
> -static inline uint32_t
> -bnxt_get_shared_action_type(const struct rte_flow_shared_action *handle)
> -{
> -       return (uint32_t)(((uint64_t)handle >> 32) & 0xffffffff);
> -}
> -
> -/* Function to extract the direction from the shared action handle. */
> -static inline uint32_t
> -bnxt_get_shared_action_direction(const struct rte_flow_shared_action *ha=
ndle)
> -{
> -       uint32_t shared_type;
> -
> -       shared_type =3D bnxt_get_shared_action_type(handle);
> -       return shared_type & 0x1 ? BNXT_ULP_FLOW_ATTR_EGRESS :
> -               BNXT_ULP_FLOW_ATTR_INGRESS;
> -}
> -
> -/* Function to extract the action index from the shared action handle. *=
/
> -static inline uint32_t
> -bnxt_get_shared_action_index(const struct rte_flow_shared_action *handle=
)
> -{
> -       return (uint32_t)((uint64_t)handle & 0xffffffff);
> -}
> -
> -#else /* (RTE_VERSION >=3D RTE_VERSION_NUM(21,05,0,0)) */
> -
>  /* Function to extract the action type from the shared action handle. */
>  static inline int32_t
>  bnxt_get_action_handle_type(const struct rte_flow_action_handle *handle,
> @@ -882,8 +853,6 @@ bnxt_get_action_handle_index(const struct rte_flow_ac=
tion_handle *handle)
>         return (uint32_t)((uint64_t)handle & 0xffffffff);
>  }
>
> -#endif /* RTE_VERSION < RTE_VERSION_NUM(21,05,0,0) */
> -
>  /* Function to set the ha info into the context */
>  static inline int32_t
>  bnxt_ulp_cntxt_ptr2_ha_info_set(struct bnxt_ulp_context *ulp_ctx,
> --
> 2.51.0
>

--0000000000007ff367063d3236bb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
pZEyqKnwS1lKCzjX7mV5W955rFsFxChdAKfw0HilwtqdY24mhy62+GeaEkD0gYIj1tCmw9gnQToc
K+0s7xEunfR9pBrzmOwS3OQbcP0nJ8SmQ8R+reroH6LYuFpaqK1rgQIDAQABo4IB2zCCAdcwDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAlBgNVHREEHjAcgRphaml0LmtoYXBhcmRlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUbrcTuh0mr2qP
xYdtyDgFeRIiE/gwDQYJKoZIhvcNAQELBQADggEBALrc1TljKrDhXicOaZlzIQyqOEkKAZ324i8X
OwzA0n2EcPGmMZvgARurvanSLD3mLeeuyq1feCcjfGM1CJFh4+EY7EkbFbpVPOIdstSBhbnAJnOl
aC/q0wTndKoC/xXBhXOZB8YL/Zq4ZclQLMUO6xi/fFRyHviI5/IrosdrpniXFJ9ukJoOXtvdrEF+
KlMYg/Deg9xo3wddCqQIsztHSkR4XaANdn+dbLRQpctZ13BY1lim4uz5bYn3M0IxyZWkQ1JuPHCK
aRJv0SfR88PoI4RB7NCEHqFwARTj1KvFPQi8pK/YISFydZYbZrxQdyWDidqm4wSuJfpE6i0cWvCd
u50xggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwM2Vrj
4nZK0WWosNswDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIE9+o1xyetr7AbqzgWPA
HGYd+g3UhoUhtktsg5599UakMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI1MDgyNTE1Mjg1MlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0G
CSqGSIb3DQEBAQUABIIBAGLg8O2PxRCsqmUzuPJPRXL63yETo9JosmcMuRJ5QQTj9PlHQIo+L6Yb
TU5bN94PTIlHnoaPNzC9Rw3HKmSlCMt5Wfi9wR2UYz9LwH4vZt9zS+L0fUGEhLjnhrlCM6tKcmqs
hw37VUh4652/GgFOFAyjYIBrtgKrMbYShVldyIl/QGBQr8h7Y6Xlyt6sgK4Sv1SXjaM0bV23f/Uk
kRikX0QNjqsXJQL53WI1Rf0qfH6prEhVUkPyqQs9fw7+nlEBcF30qz8xyW2PJZIW93kWSNplc0RT
V/iT/uR48V7gv+F9gO+miumnFkhv2uVSlDcQTCeUH60LYO7RRd39GmRssk8=
--0000000000007ff367063d3236bb--
