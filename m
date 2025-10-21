Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21834CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 14:21:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C67E402D6;
	Tue, 21 Oct 2025 16:21:07 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id DCCA6400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 16:21:05 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso5060623b3a.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761056465;
 x=1761661265; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dydK+PbJfNAWO9utqp1p376lhJlvO5guD7NLZYW4RoM=;
 b=aH+zjfudw8LfiqbweF/pfkh7yaNEENHegMQ8/sfkxghnmPSokkWHwPC6IeEtStJrH7
 w+8rEYm0Ass4PTuA2aeqox61fZmlBNBdmcKQJwsg//y/XaQ4x6gQQv4W5KSZG0IDCgI4
 tEyDcAOA4Hh29/C2O9nIVEftzf/EH/kEkw872CAKOS54nZ2cdd6dvdXUbR+gfDyxhwnZ
 IkUmFxZhDmltC7uhNXhQ7PA6ADgobe24l03/DQ8KsY9GezFfrtOqkcpZfJ5Qlv4Q8O10
 sPFr+LFEh4vvsB3TgVeo7z3pNZjX8nn+A6QsuTL/zcDievZpjDEaEOdpVRzaUxwSdjNT
 JcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761056465; x=1761661265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dydK+PbJfNAWO9utqp1p376lhJlvO5guD7NLZYW4RoM=;
 b=pxkZtNLu0c204D6p6ZheFAQxmh/YCbIMwvFKoV8kHlZLQS2DTMvMkPAukcPvn8GMpT
 riX9D4wgW8vlZp3xS8GgpOhvrL28IW25LNnh2iCWyru6Vqet3t49Vq+RQt9o1LvagflM
 nUBygQ5NohS/tsyTRhjRxbfhXCP5dH5sEySiyHv7GLsX60zttZdDRKJ2LkCuNtxGMC6s
 u3qZ/jTWRCPiQHNDw2900AvnINhSZ6h4WqeERe6a5VNKQx9OOMThZCkJUJz8s+jMRTtH
 vyTyq0K71k03W6hEoT/vjfveXv/bpDpM4DEXkVpSsN5gXHWKgVYepSm1eiWgu+Ak6cyg
 AJ1Q==
X-Gm-Message-State: AOJu0Ywbtl6NBU6BZGyzpwveuXcTVXeEEbgfvAA3g53MRPPDObTzB+yn
 5BNFGK2545EZudJAMSIv3LN2dGSw8yaZTrEV6etwD0KELRWmN5N72FpokM/Faufxz9+OpIQEu2g
 swSOzRM4=
X-Gm-Gg: ASbGnctQIQvBHR/3W8wEJ/TWP2JPKwN6/YvRiCNhRkZYn3hCYWdqRrWVhYF1ZYa3RMJ
 4+0b8wsiVfNqKhRYSWKBq0YCU2Bms9ykVijv/bWb2mF7Itn7DKAbYkyZ8I5GFfBh4Tav9oSiMRS
 hdDj3VPnIHWFt4VzaNefOJIPKRpX+xGzpKU0lGTZkZjCVD7ENtqk3gUaLlcSq8O9wh0bX0//euA
 8NHpbnDEpPq6zkM8UOhlloxPWoyegzyMTlwMD9056BlXUBheGw+GrP6EG5+aNs7uIhe97yyBWSC
 v38uIE3oxIYFtd6tCFTLcdAiw5eCgBZNbMuX91EbK1SlN/rCvICfWGSyTV98JSpsR0BT4AGqKil
 PrrpK3XqSYjx60GTJypTl9bKpNXge/xQhnmdt2TGjxYMaj1kkXG/7wVhYVgDtdRC0FBWDXjAKhq
 UDRgZC6zViFbACGLB8w/mpZWtXuI3qOHhPxlQTDg6Zdvncahm1EunchhtpKZJ1
X-Google-Smtp-Source: AGHT+IHDMnTGVp1NmkAlzxtCg0BF7PbqO3mdr1Bulp2qfVw0ZEhHDy0JeGnwPsoeAIicaa8m2E73SA==
X-Received: by 2002:a05:6a20:42a3:b0:2f6:cabe:a7a8 with SMTP id
 adf61e73a8af0-334a85fd39emr21359633637.32.1761056464878; 
 Tue, 21 Oct 2025 07:21:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a22ff158f8sm11730800b3a.8.2025.10.21.07.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 07:21:04 -0700 (PDT)
Date: Tue, 21 Oct 2025 07:21:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Kyo Liu
 <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen
 <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v13 01/17] net/nbl: add doc and minimum nbl build framework
Message-ID: <20251021072102.2308eb46@phoenix.lan>
In-Reply-To: <20251016080128.3133579-2-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251016080128.3133579-1-dimon.zhao@nebula-matrix.com>
 <20251016080128.3133579-2-dimon.zhao@nebula-matrix.com>
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

As part of driver review I audit the documentation in features
against what is actually implemented. Many new drivers seem to cut and paste
from existing drivers and not implement features.

> diff --git a/doc/guides/nics/features/nbl.ini b/doc/guides/nics/features/nbl.ini
> new file mode 100644
> index 0000000000..90ec593759
> --- /dev/null
> +++ b/doc/guides/nics/features/nbl.ini
> @@ -0,0 +1,31 @@
> +;
> +; Supported features of the 'nbl' network poll mode driver.
> +;
> +; Refer to default.ini for the full list of available PMD features.
> +;
> +[Features]
> +Speed capabilities   = Y
> +Link speed configuration = Y
> +Link status          = Y
> +FEC                  = Y

There is no ethdev ops for fec_get in this driver.
It doesn't support FEC

> +Queue start/stop     = Y

There is no operation for tx_queue_start or rx_queue_start

> +Burst mode info      = Y

Driver has prototype for txrx_burst_mode_get but no implementation
or ethdev_ops.

> +MTU update           = Y
> +Scattered Rx         = Y
> +TSO                  = Y
> +Promiscuous mode     = Y
> +Allmulticast mode    = Y
> +Unicast MAC filter   = Y
> +RSS reta update      = Y
> +VLAN filter          = Y

No ethdev_ops for vlan_filter_set

> +VLAN offload         = P

Driver does not report RTE_ETH_VLAN_STRIP_OFFLOAS

> +L3 checksum offload  = P
> +L4 checksum offload  = P

Driver does not report RTE_ETH_RX_OFFLOAD_TCP_CKSUM etc.

> +Basic stats          = Y
> +Extended stats       = Y
> +Stats per queue      = Y
> +FW version           = Y

Not implemented.

> +Module EEPROM dump   = Y

Not implemented.

> +Linux                = Y
> +ARMv8                = Y
> +x86-64               = Y

Please fix the documentation and/or code to match features
and resubmit
