Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790C3C28B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 07:46:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CE7F402CE;
	Thu, 20 Mar 2025 08:46:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1B2E0402C4
 for <dev@dpdk.org>; Thu, 20 Mar 2025 08:46:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742456808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMX4/owHfAij2XL/D7wuQ61Ox02Ml9za+Fd78XWd6bE=;
 b=GlYP3/zOhqpURoyoPTjglviPcAibmopJhMl71g7hQ2aLzd8MnIKZ5jX6kx8izcAYWdGroW
 gaDOAXVIhvW0CDlX83ogBj8fNyQkIn570v3WsumQWxGj5vnWIFHSZTRa/MA8nEmN9H8qGx
 PylN3YCjMmPfgB6MSAy6Xk4wGlfJvXc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-2PckJtAvMDGVzvaiNfcpMw-1; Thu, 20 Mar 2025 03:46:47 -0400
X-MC-Unique: 2PckJtAvMDGVzvaiNfcpMw-1
X-Mimecast-MFC-AGG-ID: 2PckJtAvMDGVzvaiNfcpMw_1742456806
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-30c165885fdso2095441fa.2
 for <dev@dpdk.org>; Thu, 20 Mar 2025 00:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742456805; x=1743061605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMX4/owHfAij2XL/D7wuQ61Ox02Ml9za+Fd78XWd6bE=;
 b=Cx6f1s/+P4Qco8ciSn7qi8PmzGEkIIgG+JQC7Ht0bd1a/X3clrMRLdTCn64RBjDXeD
 bAmyvKfcdPRy157kye9SNdg39s3QM4bHyN54SG1kHR6kIxVKzrTo8poJ59bJEN+FrkfC
 anMIIdsRSSKnizomwQEnyNRtG6KU1nmpkpZgJbJDO6/ZcrUGSFVcSUAm3C1wz10243Rx
 2V0zxOzYD/ZP5pH6ZYZygQM/o3BtOl1j+3C9WqM0aZxdbeZdAMtT3j9BLgLbZCK6Hrpi
 CN2E2O+9GHAxv6R18kbfDaXWwHPhgiYn2K3LIoyS2xTO82fXShNNc+GaJeLgxuOFW9qj
 zMRg==
X-Gm-Message-State: AOJu0YxeAxOL0qSyx4AeFhA5CmNzXBxklOb0rnXAOPZKamRoo2kj50tO
 8suYSe5U3UNIP0DuzVGq0/AKtjeZHCBmsjfLc5QUOjCoxHtRxMgF3xXR2oFAE+RYZ+k4nqVYKid
 m4QqbZ7JLU9t0I7/cp74yrRKnyi/UGySq6NprUa2vdtcYUJTIV/pCd3sBRI7j4v1zfrhD8DC2dC
 cND4ijpgfjRTQuJGVI2scUpZTkaQ==
X-Gm-Gg: ASbGnctklMn4YPZBh3m1C58LaYYEktWOGB7iJe4L4/nnoIqRdAkQ+Bf6UrSacM28H4l
 u8SBoenKawv7vzTJIXfIdWxQlg8P83Tids4y7slE4SHtyMU3mJNP/4t6wISG3sryqFGPhHAzatO
 I=
X-Received: by 2002:a05:6512:318e:b0:549:4e78:9ed7 with SMTP id
 2adb3069b0e04-54ad068743fmr746163e87.49.1742456805503; 
 Thu, 20 Mar 2025 00:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9gsm+InEsiI6M4G0OdKBOOZh6wyJmj2qTAmAAGbu/aSncRfWXtYo0w/j2yTVywWDW52jpQa8McjV8xtqK/uY=
X-Received: by 2002:a05:6512:318e:b0:549:4e78:9ed7 with SMTP id
 2adb3069b0e04-54ad068743fmr746153e87.49.1742456804997; Thu, 20 Mar 2025
 00:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250319172942.2992053-1-bruce.richardson@intel.com>
 <20250319172942.2992053-10-bruce.richardson@intel.com>
In-Reply-To: <20250319172942.2992053-10-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 20 Mar 2025 08:46:33 +0100
X-Gm-Features: AQ5f1JoffNlPYHwmNCcfZkT3FO_JVYEZZ8XYwDu9fWYET6LP7d9Kmme6EC3arSM
Message-ID: <CAJFAV8w9wYPN+30Hv=batMvP=0M4momKZgmNDFixXbd-9u8t6w@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] net: simplify build-time logic for x86
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Jasvinder Singh <jasvinder.singh@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -IFD-fRQsCAJQ4dLc5RN_mM06lSt7gkaOYGouqc6FSg_1742456806
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

Hello Bruce,

On Wed, Mar 19, 2025 at 6:30=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> @@ -211,7 +211,7 @@ avx512_vpclmulqdq_init(void)
>  static const rte_net_crc_handler *
>  sse42_pclmulqdq_get_handlers(void)
>  {
> -#ifdef CC_X86_64_SSE42_PCLMULQDQ_SUPPORT
> +#ifdef RTE_ARCH_X86_64
>         if (SSE42_PCLMULQDQ_CPU_SUPPORTED &&
>                         max_simd_bitwidth >=3D RTE_VECT_SIMD_128)
>                 return handlers_sse42;
> @@ -223,7 +223,7 @@ sse42_pclmulqdq_get_handlers(void)
>  static void
>  sse42_pclmulqdq_init(void)
>  {
> -#ifdef CC_X86_64_SSE42_PCLMULQDQ_SUPPORT
> +#ifdef RTE_ARCH_x86_64

RTE_ARCH_X86_64

>         if (SSE42_PCLMULQDQ_CPU_SUPPORTED)
>                 rte_net_crc_sse42_init();
>  #endif


--=20
David Marchand

