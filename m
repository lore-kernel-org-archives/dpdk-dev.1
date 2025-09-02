Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68748CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 08:08:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61307402BD;
	Tue,  2 Sep 2025 10:08:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A6430402B2
 for <dev@dpdk.org>; Tue,  2 Sep 2025 10:08:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756800511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=INef1m/58wHnz9vNOtgKh6qxZY2RWvCqVU6ei+s40qc=;
 b=LHEUQZ0wWyxoGRj0qU4fWijPmKggBreN50lp5uPfMbXfpOTgdRYw0zclXBqvZwNA2fSZ+A
 SeXP31AyCFYi5OsXQW7r65k6r1gK/zP3KCegDHcn8dw9QsnuutMjNCxIXgy9wRd7e9byXW
 uAoc6/0DzeAU45PYYljcDaDHYP+O0Ek=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-EdIIbcNmNMeqNuKKZt3hYA-1; Tue, 02 Sep 2025 04:08:29 -0400
X-MC-Unique: EdIIbcNmNMeqNuKKZt3hYA-1
X-Mimecast-MFC-AGG-ID: EdIIbcNmNMeqNuKKZt3hYA_1756800508
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-55f5fc7d258so2801965e87.0
 for <dev@dpdk.org>; Tue, 02 Sep 2025 01:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756800508; x=1757405308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=INef1m/58wHnz9vNOtgKh6qxZY2RWvCqVU6ei+s40qc=;
 b=XEqxLCwnc9AJ+glZ6Llqc3s9uC1jBre+PkKuNqnXP6dLSt0dkNgvYXy03t3PE5iYj5
 yMnP7K6G0DYlu8bSeQ7ESqDsGbZ/WfdmqOMOt6CoOK6OmPdn3ZnW/uzvogr/XF5WY9dk
 1jTSJSSfHEXe0JkjKPUXLiBYg7lSQ16y+ADhmaaSrGOBfmJP41jC2fG42QaoYed0ikdC
 jfg0MFPNCnRYwsYUgBtWOC0Ihu0l5GduWjtp+ENENHzq1jOHOUyVZ3S7ErIsDvSnh9Ga
 wB0giSa2A/5LQicwvgCjTnKh5Cegw5YCKaRiFUsjg1XhuessZ3MFXMM8aGmX7TWSdcEL
 zvAA==
X-Gm-Message-State: AOJu0YzsLYe6aVFaeIpOQVB0lvlAHWE3vmcbqhYG13OfHpaFkxFhsELh
 sJs6DrsQC0O+4kNiZ9iu75ygs7j1KJTEeszX7OBpjWgrpy0HitVYtVfE2/IdjjVsjyT40hYQyvl
 NhdUKSdJ+4627GeOGhqpKZ7S4V+pG9EtM/z5mz1v+EYSTELUdCVcxV4eFpcU6DhOBMVHZoGQuoe
 ILNeZ6tvop46iTqepQ+bE=
X-Gm-Gg: ASbGnctMP5WcCVjWiuNKLvVnwNSyI87Pt+NOCdyWRhplpa8dAVNPLm6alNp7V35v/ly
 dyrYNKVvdaYmYoLT0/Pyv48KenU54oIgud0iHRp7+zshNmwN2hAJMHDEpmWF3xWlNsU/6DL6eqQ
 dvMsISzQIgYYWy3w+HAZeG6yU=
X-Received: by 2002:a05:6512:689:b0:55f:5685:b5ef with SMTP id
 2adb3069b0e04-55f708f1922mr3737003e87.29.1756800507830; 
 Tue, 02 Sep 2025 01:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ1Hh57B3fr0R5Ovo18WoeRrfVDoAPLAH4vqeYVJPuxdl2BxYaL3v4zJTmFq9LI1qeazBQ/G6MNLM7dMB7KWA=
X-Received: by 2002:a05:6512:689:b0:55f:5685:b5ef with SMTP id
 2adb3069b0e04-55f708f1922mr3736986e87.29.1756800507214; Tue, 02 Sep 2025
 01:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
In-Reply-To: <20250901095953.1858938-1-ciara.loftus@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 2 Sep 2025 10:08:14 +0200
X-Gm-Features: Ac12FXxHfwYAfKL2vyJOWXE0ArPNitrQ-OnK0t7c37Ev70G6vpf3GXYFbhiGPo8
Message-ID: <CAJFAV8woLUsk=B14RKG+cvOrbdXvGdKaTU59m_A-r_Wkb8KZ6g@mail.gmail.com>
Subject: Re: [PATCH] net/i40e: fix supported offloads for Rx vector path
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FY6u3o6UCB-bNqzDhel_v73IXyriL_7DDwsyD9J6J28_1756800508
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

Hello,

On Mon, 1 Sept 2025 at 12:00, Ciara Loftus <ciara.loftus@intel.com> wrote:
>
> The set of supported Rx offloads in the vector path had been defined as
> those supported by the scalar path. This was incorrect so define a new
> list of supported offloads for the vector path. The list is the same
> as the scalar path except it excludes vlan extend and qinq strip.
>
> Fixes: 052ae311091c ("net/i40e: use the common Rx path selection infrastructure")
>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_rxtx.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
> index 5d5d4e08b0..1f210dfdff 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.h
> +++ b/drivers/net/intel/i40e/i40e_rxtx.h
> @@ -80,7 +80,16 @@ enum i40e_header_split_mode {
>                 RTE_ETH_RX_OFFLOAD_VLAN_FILTER |        \
>                 RTE_ETH_RX_OFFLOAD_RSS_HASH)
>
> -#define I40E_RX_VECTOR_OFFLOADS I40E_RX_SCALAR_OFFLOADS
> +#define I40E_RX_VECTOR_OFFLOADS (                      \
> +               RTE_ETH_RX_OFFLOAD_VLAN_STRIP |         \
> +               RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |         \
> +               RTE_ETH_RX_OFFLOAD_UDP_CKSUM |          \
> +               RTE_ETH_RX_OFFLOAD_TCP_CKSUM |          \
> +               RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |   \
> +               RTE_ETH_RX_OFFLOAD_KEEP_CRC |           \
> +               RTE_ETH_RX_OFFLOAD_SCATTER |            \
> +               RTE_ETH_RX_OFFLOAD_VLAN_FILTER |        \
> +               RTE_ETH_RX_OFFLOAD_RSS_HASH)

I was curious about this fix so I have been trying to understand the
list of supported offloads, and I have a few interrogations.

How does this new code articulate with function
i40e_rx_vec_dev_conf_condition_check_default() (that seems to have a
build check on RTE_LIBRTE_IEEE1588).
This seems like redundant logic to me.

Should the dev_info->rx_offload_capa field be filled with the common
set of flags of the scalar handler?


-- 
David Marchand

