Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E9FCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:24:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93DFA40ED1;
	Tue, 29 Sep 2026 15:24:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7038C40E36
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:24:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790688292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jA3+OeZZMaEMnixza9E83CW7cqsHV9mv9dazaoF04U0=;
 b=aq7SWTpz5q9XONVF6sb7uPPUiNjOvoQKTlKRjuF4hDsW5SWmqlHC8MK7dx9+ihFJxEOB0D
 iEBPyxOe2fzXke4H/UfpcERIcZ/q4VdioPcAiyKxLiydjxT2xsItmEb0+3WQuZUg7FZq9t
 aI9SS5iHHQ0FHZBYRjjBBhWNTAXucjg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ufT6H31BNlC1-K-7MyAgyw-1; Tue, 29 Sep 2026 09:24:50 -0400
X-MC-Unique: ufT6H31BNlC1-K-7MyAgyw-1
X-Mimecast-MFC-AGG-ID: ufT6H31BNlC1-K-7MyAgyw_1790688290
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so4136389a91.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 06:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790688290; x=1791293090;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jA3+OeZZMaEMnixza9E83CW7cqsHV9mv9dazaoF04U0=;
 b=XL/5JTw0mhahnNxarlaSy30/B/pPVmN8aCjP2cfr9HCkVpZuBgmIsQzJdUBRB4waQT
 WXVbL1wUFhKfp7zzwoG7LYWYSgYn9R3WlmKFz/HDyOHz2qdoN2EZNJ637pNjzFy68xeN
 vFXytGrVJahUU2WstsQDZG+X04wIjs0vMl1u5t202I8Ghc7/oiV+9azGGi+MMVLvIk2N
 futKT8q0HO9Jj4WLx45bXfVVGI6kRLOjDRcbecL8iB1+uTHOxE5530Dw5fiOVNMpL48Y
 6zBXOeD592ELic0X1KtMbFq/0HmHBALy7rITw6TgtlmELPcAcoJJvhXxM5KAb33C/uSf
 GZNQ==
X-Gm-Message-State: AFq9FYJ47X6pV4/l2wAcsWjydt5F7MalTzxoT6Ax8RRgf7KJd0kky/y7
 hv0CDHQEUXk/zbK4Ql6wUoFtyi2pFAq75tWC71XTtxWteu8ZDpRezqv4XimuB+qW2cec5Pf/cYF
 4DYPaulMsGyz1Ax6LYGxK+hprm/vJxf/O4tVbRKVRyhsOOXVzecFx34ykUsiY3PhJp5/EFcDgYu
 vYI65LMcMriP4xyIq99OI=
X-Gm-Gg: AYBFou3MMdwe4J4gdluB+v4Lpv6AEYvP0kiKvs62bJqmEQ0bcd1tH9hdWu1Off6doq9
 9jxXSMKoAR2CzSD/82JX+ctCdx1RVNYdQ3B16fldfCeq3xfex4AI+sFemfEQAMWQ5rN2+qajGb4
 /xHafZ8g192VXNjZaUM+kUJTcmosGBo86jC1Sy5lDqBBLykL7c0YMsLKQWLVfTynFpWUq7BG4bY
 m1AC5pAydtKgPA/DYj7oUstCFUdR/D2m/lKBu9Dc8elKkrc
X-Received: by 2002:a17:90b:2785:b0:39e:6795:f7da with SMTP id
 98e67ed59e1d1-3a09875ee61mr13829219a91.19.1790688289622; 
 Tue, 29 Sep 2026 06:24:49 -0700 (PDT)
X-Received: by 2002:a17:90b:2785:b0:39e:6795:f7da with SMTP id
 98e67ed59e1d1-3a09875ee61mr13829202a91.19.1790688289190; Tue, 29 Sep 2026
 06:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260924063836.355745-5-david.marchand@redhat.com>
 <20260929125054.85048-4-rasland@nvidia.com>
In-Reply-To: <20260929125054.85048-4-rasland@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 29 Sep 2026 15:24:32 +0200
X-Gm-Features: AclHuK-zKiV68uJoes7TR1QSKgvTWkkyOz40Tlmxg5eDCmCbHvTHImBDmDbmT_w
Message-ID: <CAJFAV8x5eGvqxBJEf9B3=Lx-cnehno_Ayi4r0VQBGJFqHHF=ug@mail.gmail.com>
Subject: Re: [PATCH v9 5/5] net/mlx5: accept more unicast MAC addresses
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: coDb4A4Nd9L-LFsz09Dx9aM_m07uKqGp3bsmoh_rGg8_1790688290
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 29 Sept 2026 at 14:52, Raslan Darawsheh <rasland@nvidia.com> wrote:
>
> Acked-by: Raslan Darawsheh <rasland@nvidia.com>
>
> I'll squash the following fixup into this patch during merge, to handle
> non-DevX devices (where mlx5_os_capabilities_prepare() would otherwise
> return before max_uc_mac_addrs/max_mc_mac_addrs/max_mac_addrs get set,
> leaving them at 0):
>
> diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
> index 9180e9aa20..7c2c35c945 100644
> --- a/drivers/net/mlx5/linux/mlx5_os.c
> +++ b/drivers/net/mlx5/linux/mlx5_os.c
> @@ -325,6 +325,16 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
>         DRV_LOG(WARNING,
>                 "Tunnel offloading disabled due to old OFED/rdma-core version");
>  #endif
> +       if (hca_attr->log_max_current_uc_list > 0)
> +               sh->dev_cap.max_uc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_uc_list);
> +       else
> +               sh->dev_cap.max_uc_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
> +       if (hca_attr->log_max_current_mc_list > 0)
> +               sh->dev_cap.max_mc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_mc_list);
> +       else
> +               sh->dev_cap.max_mc_mac_addrs = MLX5_MAX_MC_MAC_ADDRESSES;
> +       sh->dev_cap.max_mac_addrs =
> +               sh->dev_cap.max_uc_mac_addrs + sh->dev_cap.max_mc_mac_addrs;
>         if (!sh->cdev->config.devx)
>                 return 0;
>         /* Check capabilities for Packet Pacing. */
> @@ -389,16 +399,6 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
>         sh->dev_cap.esw_info.regc_mask = 0;
>  #endif
>         sh->dev_cap.esw_info.is_set = 1;
> -       if (hca_attr->log_max_current_uc_list > 0)
> -               sh->dev_cap.max_uc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_uc_list);
> -       else
> -               sh->dev_cap.max_uc_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
> -       if (hca_attr->log_max_current_mc_list > 0)
> -               sh->dev_cap.max_mc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_mc_list);
> -       else
> -               sh->dev_cap.max_mc_mac_addrs = MLX5_MAX_MC_MAC_ADDRESSES;
> -       sh->dev_cap.max_mac_addrs =
> -               sh->dev_cap.max_uc_mac_addrs + sh->dev_cap.max_mc_mac_addrs;
>         return 0;
>  }

This lgtm.
Thank you.


-- 
David Marchand

