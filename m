Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C2C7115B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2AD740E19;
	Tue, 17 Jun 2025 17:22:45 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id DB94D402C5
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:22:43 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4a4bb155edeso70467071cf.2
 for <dev@dpdk.org>; Tue, 17 Jun 2025 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750173763;
 x=1750778563; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQjCatVikXoE/PpDu/gGcOq/OvcnLnFtDj6yaHpIeMk=;
 b=bJmTIx0nxv9HClZKdlva2NcbIqMzbiM2xzJKkkPn7e2ZneUhY/Kue2EKlRzoHZ4gOj
 BsanzieVbBMIQScMYk54MoyNLpQVEpsM6iftb1NdNOSTDVcX+WpyalSkmLtMD9itqm7G
 5dR/EFi2TKmHJDBJ0oAtHZSV0JyiV+KhGDdGTi+ozEkTiYPHfszJgrZpXF4vktVNMXEn
 +Vb7rHQ6pA5tACvoF0Reu88MDm5FD4CctGUQ86FCmGycX++4DFxaCL5A+VFN03zmKmZN
 fsA8wwrSJUz3uek5Mfs15fjJluXvtH3nztGargxhGFIEtSsX7YP+JegYvNJE2ocRdnw1
 /mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750173763; x=1750778563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQjCatVikXoE/PpDu/gGcOq/OvcnLnFtDj6yaHpIeMk=;
 b=TRAhY3k31cMNf0hA68riSdEXkSFHvkIFx+C7thn6l7Cls8Yi4VGo0Ho3XLJQCGWJyF
 q3872sMCxt/17EnlRDHKwOTqv4//4FFT3ut0V7DG0r1WLDxZ4yA0JZ7BK3jMtxe/DqZE
 IfWtwLrVdf/tJK1d3L16tJJO+Cdzt3Mr3ePj1tXNbWb22TKCj3Ct+sd5l9zkqSLrIQsx
 QP90H0j9GgQb2SXiKhBEsGvsU2zl6+QjxArK4FpXsRzcxKCftcY7pnvKXcBGPVncmsKF
 q/kb5STc14ZINXBsCZ0F3hZHEaYZ3Yw0eBoHkhQW//7ZAluGUj3qKWE5RcqCG2FXno02
 nqnA==
X-Gm-Message-State: AOJu0YwOCUkTVHqzlbynQEYxCntMQL7md7BzOv8x2znPkXnRjhPk/rJ0
 /84x7UFoqnVrCDlvV2kpWIRBe08nJ8wV1IA/RV4Kp89v0uNXfnFnDiXXb8i2uzpnCaRxIJ045zw
 dx1df
X-Gm-Gg: ASbGncvbA989bi4sJYjDbg1uBCpMomJNBGCvxWgM9KxybOQwctrtTnxgn+Icd3W2IQi
 po4/AH/B6lyNw8IHmjxUgQ6ENwgEpYKc65sto6RNj8WWlyRaZxQ1Q8s2bPQpM1LcSq8YE+Gk+FD
 zpQ+3g2AJQ0tzmhxA0ArCKhuacgNXH/39ext4Ok9BMtmqlSGqngIOimlguERPP4Oxb36a9gQBFU
 TXe3dF1enRIXbTIeNNy5Mm3leSQCrwzFPNrhVusFl/EkeDAEHoTruGxgvwN9wlV0jtIEvI5v8BU
 v71KPgOul04T+F8Qk2NQs411fG27jbV00bkZb+vk/33W86EA1keWeMSOoWv0Vh8j6oK9B2JM4BP
 kvWQdbqZpktmjbydzCD/UuDrqC9PFK+7R0m/3tvo=
X-Google-Smtp-Source: AGHT+IHSCMcIrEIcgqqLA9zj59iCyYyLf0T6EzVnhvg3QmwIRloW14RDdBwJtaAeIE5cU7SLC4LxRg==
X-Received: by 2002:ac8:5ace:0:b0:494:78d5:baea with SMTP id
 d75a77b69052e-4a73c662a0amr190345341cf.51.1750173763016; 
 Tue, 17 Jun 2025 08:22:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a2f4fc5sm62594191cf.26.2025.06.17.08.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 08:22:42 -0700 (PDT)
Date: Tue, 17 Jun 2025 08:22:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH v3 00/17] Fixes and supports for Wangxun NICs
Message-ID: <20250617082239.64d9f884@hermes.local>
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 13 Jun 2025 16:41:42 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> Fix some bugs and improve flow filters.
> 
> v2 -> v3:
> - Split the patch 2/12 for various changes
> 
> v1 -> v2:
> - Add new flow feature geneve and gre into txgbe.ini
> 
> Jiawen Wu (17):
>   net/txgbe: support flow filter for VF
>   net/txgbe: fix incorrect parsing to ntuple filter
>   net/txgbe: fix raw pattern match for FDIR rules
>   net/txgbe: fix packet type for FDIR filters
>   net/txgbe: fix to create FDIR filters for SCTP packets
>   net/txgbe: fix FDIR perfect mode for IPv6 packets
>   net/txgbe: fix to create FDIR filters for tunnel packets
>   net/txgbe: fix reserved extra FDIR headroom
>   net/txgbe: support RSS offload for SCTP port
>   net/ngbe: support RSS offload for SCTP port
>   net/txgbe: fix MAC control frame forwarding
>   net/ngbe: fix MAC control frame forwarding
>   net/txgbe: fix incorrect device statistics
>   net/ngbe: fix incorrect device statistics
>   net/txgbe: restrict VLAN strip configuration on VF
>   net/ngbe: restrict VLAN strip configuration on VF
>   net/txgbe: add missing LRO flag in mbuf when LRO enabled
> 
>  doc/guides/nics/features/txgbe.ini  |   2 +
>  drivers/net/ngbe/base/ngbe_hw.c     |   9 +
>  drivers/net/ngbe/base/ngbe_regs.h   |   2 +
>  drivers/net/ngbe/base/ngbe_type.h   |   1 +
>  drivers/net/ngbe/ngbe_ethdev.c      |   6 +-
>  drivers/net/ngbe/ngbe_ethdev.h      |   2 +
>  drivers/net/ngbe/ngbe_ethdev_vf.c   |  24 +-
>  drivers/net/ngbe/ngbe_rxtx.c        |   8 +
>  drivers/net/txgbe/base/txgbe_hw.c   |  23 +-
>  drivers/net/txgbe/base/txgbe_hw.h   |   1 +
>  drivers/net/txgbe/base/txgbe_mbx.h  |  17 +
>  drivers/net/txgbe/base/txgbe_regs.h |   4 +
>  drivers/net/txgbe/base/txgbe_type.h |  21 +-
>  drivers/net/txgbe/base/txgbe_vf.c   |  29 +
>  drivers/net/txgbe/base/txgbe_vf.h   |   2 +
>  drivers/net/txgbe/txgbe_ethdev.c    |  18 +-
>  drivers/net/txgbe/txgbe_ethdev.h    |  16 +-
>  drivers/net/txgbe/txgbe_ethdev_vf.c | 111 +++-
>  drivers/net/txgbe/txgbe_fdir.c      |  62 +-
>  drivers/net/txgbe/txgbe_flow.c      | 857 ++++++++++++++++++++--------
>  drivers/net/txgbe/txgbe_rxtx.c      |  18 +
>  21 files changed, 945 insertions(+), 288 deletions(-)
> 

Please don't mix new features and bug fixed into the same patchset.
Will continue review of the patchset as is, but avoid this in future.
