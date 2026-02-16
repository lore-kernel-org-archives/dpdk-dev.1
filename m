Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2745E81A40
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 16:29:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F05CC4042C;
	Mon, 16 Feb 2026 17:29:20 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 1D164402DF
 for <dev@dpdk.org>; Mon, 16 Feb 2026 17:29:20 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so26960285e9.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771259360;
 x=1771864160; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQioakF4ob2FgWg4Dt2KRT1ujEcRnabI+NQLfGCxcDE=;
 b=JdP6vmoA2NRUFC7tydokwMeULEQIIDIvOloCVAj5NI9aegUnntplDULtavYYqavfr4
 35VQjSDj1TOIlad56RmedeKSq9St9LWcfNPD8elU5U2C+vNQY2ISavJdrGA9J+DkMqKj
 ZjrdPCd+7dxWQa9cl4xsGe6xPz1+nFhE6zVqPNs2i+no6myJ5xhfnjJpIycy2H3/kHDR
 ET5fFLm9lF3UUZFYZ5e4K4sOfH7JTqkRVVm0innPR/ze3MJGjFX6BnooY/0f9FBSb039
 ceUjJtdB4LI31gEwHNswuwk8nGBmzYC3cwp/TT6szc8KOTXMm0Jntw/Pw176uhTWNGl9
 uYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771259360; x=1771864160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dQioakF4ob2FgWg4Dt2KRT1ujEcRnabI+NQLfGCxcDE=;
 b=h4UDC0+6uNl6vlp8Qd28lqVts4RoIj6f35/HaT7XPqJLPKqLLqLpYOmKk10QVNHdiv
 LOE7qmkMQz3U4jO1y4ANGzeqhJOzUZjvDOIHMR/UBSk9JVLKPgioDP0ZYrv+2cgPVDq5
 H3s4LzgD0RyIXccHNGh3asmd/boVBVMseYRjk+wjNU2RB8kuw+mg4OpXWCzuT+R/LjYz
 XN/mQsYbADTkm1OaMFoKsuektUp+RSt0LFBw898TENQISdFTu8+Z7SJi8dAobmab3KbT
 q5JhSxKFNpcOumPZCC6qwGmoF5v5EIlpG2nd8gRzZN/nPgucaYDdJqUtMDQAPZf/ZMwE
 x+lQ==
X-Gm-Message-State: AOJu0Yw8si/Y4U5GcbKjNyL/zrB2GTdAr2vaZ1q1cZ4WKHniuNAFY+Si
 mp27e2oCBRmM4YqjsbmYhFtdWiGtSmJ59BIVv6zVX6LrWNuSPpvcj+6T2txk/AmbsZs=
X-Gm-Gg: AZuq6aKYrEvluClGS0DQsWRCoKZPGW1k+VrN+3YulwSm2+c1LkN1jVSM99itzgq2kp8
 RhPRaB6CAtv7AxTWRD5UB1br6YIu34glKXuYeqIxtA2wmqiAqrC87LHKxhqGfih2UjT3KDcU04j
 6bf2pSSzeL10V6fYebmrPfuccNwFTCARd5yTC+JVQUVONmOz+Uw3rlrPxuqGT0DwuWN2hPu1uMM
 a6USPdBR2BRJiZwyXLbSe+b4TtrmH78axDLDvGwzLdMrmg1pziG3Ll5FKCp7IaKb/EwPky6VEdj
 BeJD3cZMDu0e08fukelVcMI1bW7ECmir7ioJT0FwetmqhkJqhg7OUx4JkwRZwUVMvqac7V+dN4j
 zRBc3ntEcCY14qQ86WFS+YOCOlJ+2BbPLl2EaE45cFAI9V1odJGqF4+W+Dm362giH894hILGUhg
 pLoohlY3wlesBihQLS9Xn+V1aH4Zsk7p0p+0yABFRb7LI0P2UM2nqCZm1WgXukddr2INij3bXAU
 Ls=
X-Received: by 2002:a05:600c:3b07:b0:47d:6c36:a125 with SMTP id
 5b1f17b1804b1-48378dada5fmr161015995e9.17.1771259359257; 
 Mon, 16 Feb 2026 08:29:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a2392bsm164252425e9.6.2026.02.16.08.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:29:19 -0800 (PST)
Date: Mon, 16 Feb 2026 08:29:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>
Subject: Re: [PATCH 2/3] net/axgbe: Add support for Marvell M88E1512 PHY
Message-ID: <20260216082914.636d002e@phoenix.local>
In-Reply-To: <20260216125205.1032-2-ashokkumar.natarajan@amd.com>
References: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
 <20260216125205.1032-2-ashokkumar.natarajan@amd.com>
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

On Mon, 16 Feb 2026 18:22:04 +0530
Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com> wrote:

> diff --git a/drivers/net/axgbe/axgbe_ethdev.h b/drivers/net/axgbe/axgbe_ethdev.h
> index 12d77cd520..3a9dc81691 100644
> --- a/drivers/net/axgbe/axgbe_ethdev.h
> +++ b/drivers/net/axgbe/axgbe_ethdev.h
> @@ -276,6 +276,7 @@ struct axgbe_phy {
>  	int pause_autoneg;
>  	int tx_pause;
>  	int rx_pause;
> +	int id;
>  };
>  

These really shouldn't be "int".
This looks like legacy era K&R code style.

The driver has this in lots of places.


The flags should be bool, but that is another issue.
