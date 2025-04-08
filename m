Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2DFC369A4
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 14:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23A9440E3A;
	Tue,  8 Apr 2025 16:18:18 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 42F9440264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 16:18:17 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2279915e06eso53554425ad.1
 for <dev@dpdk.org>; Tue, 08 Apr 2025 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744121896;
 x=1744726696; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kr/Jf9dIMahWx9c5IqpZBTHbaNtK2XdGcFPEx6q4Q0o=;
 b=IXQ7TgrJ4ift/3kmm4sEI0wtw7Rds1p7atF3QT702aC+ghL0Z71DA6oDQwaGfhxRFU
 dotA6y7tvLv9HOf7wG77p6WLminXljHQ0xzZEH+x9ch+7NN41DTlUhnsxJ17+uF2SBvy
 c26J9IB3gzNAmrT7lzCh9wfTQTQR/ezth59i9biaUd2SS99pozBCRzmUHEVFCuBhVD7D
 z72ecxpX8wJytIc2+uw1gaV9QSfoL+pqrjyOkf8PmbINTN5hAXfuNIA6Zz2Rs694v5ti
 3KdxIE2UVyv4F5aATdVjiehldNauE66whfW2PouS4Pgw8V2rUzJzjuhV/0Ny7FDAEX2x
 ZB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744121896; x=1744726696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kr/Jf9dIMahWx9c5IqpZBTHbaNtK2XdGcFPEx6q4Q0o=;
 b=KGYenLlIMaL0JEqIPl3ovaf0+6VVmQubL0yPCLvjoGxmKMTf9ecABXYRuued0bPVU6
 35zwrWDvOz89NhAsEaVDNbymAYrt1nfy1TV6Yk2ehX9iMP27qpaegshqJmCTTnafxRQn
 k7TXTES25DM05TV81kKWv2OkaNIiu5pZWFw9HPu2J6pR43Fg1nasdIKvqD2QkBrqt3tv
 kgmGXzI/BSVPRjXsz+hS1EeDt1LReFfNW9c+Yj2dMLQm2YJZ4DHr6D3agf+wFu1cTmaX
 bKTNWZgcI1HHhAUmRgatESiCgolEpf0FZhRaLwAvBbNEV6elZiXJ79/LhKbw+O3zx4Bg
 PplQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdgP1mK1xA5+fx7iXHT5FHYKa5GoQIKonWBMTTAz8AN7Mb7QOghwFaWtN+l/Z9HF9k1CE=@dpdk.org
X-Gm-Message-State: AOJu0YxogOKqgMn1Jok40SqWNRsITehkvE4mzZY33QxhWK91MxjS3kZJ
 Qq2DeIBgQ4781ldBvYzplj+nnGuva8VAgj4hadYm1D4vyB+0xl9ApiGXH5LlA8Q=
X-Gm-Gg: ASbGncu2Sx+vDRfd+IqpNsUkxNEqitfwVGFc4Aejf8q3+ZubWJrKdPcG3QX+6P9QXYD
 GlwmSD0XRGIhyt5fF34C1RQnu+R8EHmL+5ajFKUYTZNfjN9KoNeeSRS9ugPnowFB9D1qWuk8Ao3
 lN12UzzXvBTAiV+f2p4QmCTEDBL8HsTFhx+pImO01Xhnbq6fQB0U1U5irO6AsrsHP7xASOEKPFl
 f+wDoPeYUSVrK2EBVD1rLY+9C/MGqEusOKr4Ed+gvYCbBfsChMVxV0b2Na8CFVTY+dhckWdZv0D
 LLytBd8T6dl3fLanZjJolhvKhsqwYBihMnLLU484l/nsyy12JhyupYZmtbmN+FdaqYKOBDsox+L
 ZQ0yWSncGiC8h+mdeUjP8
X-Google-Smtp-Source: AGHT+IFYVdACkb7SCsePqeZxtn9K7u26VG1G9S9MSJFPIphsS7D/Nt+YezQAkC3e/9ePEFH8eQ6cIQ==
X-Received: by 2002:a17:902:ecc4:b0:224:1eab:97b2 with SMTP id
 d9443c01a7336-22a8a2da123mr252571095ad.53.1744121896199; 
 Tue, 08 Apr 2025 07:18:16 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866e2absm100351255ad.179.2025.04.08.07.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 07:18:16 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:18:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@microsoft.com>
Subject: Re: [patch v4 6/6] bus/vmbus: set event for channel without
 monitoring support
Message-ID: <20250408071813.680880e7@hermes.local>
In-Reply-To: <1744065904-18455-7-git-send-email-longli@linuxonhyperv.com>
References: <1744065904-18455-1-git-send-email-longli@linuxonhyperv.com>
 <1744065904-18455-7-git-send-email-longli@linuxonhyperv.com>
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

On Mon,  7 Apr 2025 15:45:04 -0700
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
> 
> For vmbus channels without monitoring support, use kernel UIO interface
> to indicate packet through interrupt page and UIO file handle.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Something is wrong, no longer applies cleanly.
$ git am ~/Downloads/bundle-1421-vmbus.mbox
Applying: net/netvsc: introduce private data for storing vmbus device for secondary process
Applying: net/netvsc: introduce get_vmbus_device to get the vmbus device
Applying: bus/vmbus: store UIO fd for secondary process
Applying: bus/vmbus: support channels without monitoring enabled
Applying: bus/vmbus: add rte_vmbus_device to all functions accessing vmbus
error: patch failed: drivers/bus/vmbus/vmbus_channel.c:80
error: drivers/bus/vmbus/vmbus_channel.c: patch does not apply
Patch failed at 0005 bus/vmbus: add rte_vmbus_device to all functions accessing vmbus
