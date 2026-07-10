Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BDBC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4209340274;
	Fri, 10 Jul 2026 09:48:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 84A4D4026A
 for <dev@dpdk.org>; Fri, 10 Jul 2026 09:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783669711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iZ2nTZ8crHQJzqa6cX8GCL5vsJr0xxlR0/8QYEKu3Uo=;
 b=E0VUw2BsiuhroOJZhukCEZXSVwBtDS2uWr22tfc1x1Hkhq5ZQKKBZ97oZtbZFUt9peYUCa
 w1PTPURx4QtuD6RkH8La35Q5mlrjPTT8zjtSkX9qMMtB5qDHzNsChP3Yb2BbbQdJ3JaeyP
 IyWbou4FUVMe8mEklQ+2R24sCI8PkE8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-UAblf1TiNAyvrDbw47kLJg-1; Fri, 10 Jul 2026 03:48:29 -0400
X-MC-Unique: UAblf1TiNAyvrDbw47kLJg-1
X-Mimecast-MFC-AGG-ID: UAblf1TiNAyvrDbw47kLJg_1783669708
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39abd6b0c78so3385341fa.1
 for <dev@dpdk.org>; Fri, 10 Jul 2026 00:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783669708; x=1784274508;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iZ2nTZ8crHQJzqa6cX8GCL5vsJr0xxlR0/8QYEKu3Uo=;
 b=ACLLwxMjlVVKnnTAxUE5z1hw/kiMrj9hwC1juzhuE8S+UsUFm9P56YbLPI4S8F8kpA
 XmoI/M/CdFW5KQxe2oUgoOodB2/XyVK6JjL61LT0f/BGh8UaSZh47/6PZ9311cLdKv7R
 Ic34E6kGYOuejRP70AFblT+sxYl1cyKkLYTmuHcT5BZtdXL+FwWTKQqAKJ/CTugmcquL
 +71BZDtYmulT2PcFfay5VXtHPwZB27t3X7Qc37WA37DQh1bPqMNOoT3ZlqNqJt9uK1pG
 t7sXSsroEAJzpr2XZEbuPFX/lrGHwY78yP+MY3aliwliNAM8sjPoBUophl8HPZZFBVbI
 WFWg==
X-Gm-Message-State: AOJu0YxtpHe84YQVALPHWJk2sGDcYmXXMDAD2Al7XAQVf6wEupEvaLKP
 Yk3eVhJzXrLpQov65b1/hph/+ck3e9W4fpq6X0pVSLkPJ7oRJC8d96Xtk60T7IQyn0BSEg6um1S
 +lJCpsf+Rc5ksf45h+tfsUL14DiSuyeemjzz7xHAJMknUaAUTZq0KIyhqavu6zpDRSJYlRPwe8v
 iVel+LpV8pxt9MfkKa/CLzxsC8yRJysQ==
X-Gm-Gg: AfdE7clK2SZFb9jZ/w4NEa64azzceE/jQAI8W48LuvvQs8b1RDSTDilzfzLSd8X8Y56
 WVYU9tPwSzoMUidpVBc9MPyqJAwE+AMqhM0Qdnr4hB9kmXTXKzKfwnuEOcMo4jWc6ZwrXem/O1P
 MD5tRNIWi2Rv06zG3A6fgLhBE+fWTeLrRtLOnn47p8UD5bUPDJdRb9EWYdK9tmntKRCxHHkB6ib
 iDO77EjlbqbQvFmScL/TnhSAYhzAcwhgTYCK7Zz27T42UH0mOreBlN7f+s=
X-Received: by 2002:a05:651c:1583:b0:39c:9086:9065 with SMTP id
 38308e7fff4ca-39c94f4a528mr4690671fa.20.1783669707671; 
 Fri, 10 Jul 2026 00:48:27 -0700 (PDT)
X-Received: by 2002:a05:651c:1583:b0:39c:9086:9065 with SMTP id
 38308e7fff4ca-39c94f4a528mr4690501fa.20.1783669707196; Fri, 10 Jul 2026
 00:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260709160247.1798575-1-david.marchand@redhat.com>
 <20260709160247.1798575-11-david.marchand@redhat.com>
In-Reply-To: <20260709160247.1798575-11-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 10 Jul 2026 09:48:15 +0200
X-Gm-Features: AVVi8Cdkm16qvjJ0-rNozAqm6h1CrPp8MSPmJphCMiK9Glgz3Rsy9I8PxKLveWM
Message-ID: <CAJFAV8zPVk4k8pN+_S9NiocghEx0sxvDngNFP39imETn8z5vnQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] net/mlx5: accept more unicast MAC addresses
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8IFYTyDj674NH3xyxsMKx9b7zy2JK9FfGLsT_JRoiGg_1783669708
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

On Thu, 9 Jul 2026 at 18:04, David Marchand <david.marchand@redhat.com> wrote:
> diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
> index 90beb2e9e6..7fe89bc6a4 100644
> --- a/drivers/common/mlx5/mlx5_devx_cmds.h
> +++ b/drivers/common/mlx5/mlx5_devx_cmds.h
> @@ -356,6 +356,8 @@ struct mlx5_hca_attr {
>         uint8_t tx_sw_owner_v2:1;
>         uint8_t esw_sw_owner:1;
>         uint8_t esw_sw_owner_v2:1;
> +       uint32_t log_max_current_uc_list:5;
> +       uint32_t log_max_current_mc_list:5;

uint8_t is enough.


>  };
>
>  /* LAG Context. */

[...]

> diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
> index f7ba8df108..1fcc40fade 100644
> --- a/drivers/net/mlx5/mlx5.h
> +++ b/drivers/net/mlx5/mlx5.h
> @@ -217,6 +217,9 @@ struct mlx5_dev_cap {
>         } mprq; /* Capability for Multi-Packet RQ. */
>         char fw_ver[64]; /* Firmware version of this device. */
>         struct flow_hw_port_info esw_info; /* E-switch manager reg_c0. */
> +       uint16_t max_uc_mac_addrs; /* Maximum unicast MAC addresses. */
> +       uint16_t max_mc_mac_addrs; /* Maximum multicast MAC addresses. */
> +       uint16_t max_mac_addrs; /* Total maximum MAC addresses. */
>  };
>
>  #define MLX5_MPESW_PORT_INVALID (-1)

The firmware provides a log value on 5 bits, so max value for uc and
mc would be 1 << 31, and the sum would be up to 1 << 32.
In theory, ethdev caps max_mac_addrs to 1 << 32 - 1, but the firmware
only allows up to 4k uc macs and extending this limit has been said
not possible easily.
So reaching 1 << 32 as a total is not going to happen soon and
uint32_t is enough for those 3 fields.

In next revision.


-- 
David Marchand

