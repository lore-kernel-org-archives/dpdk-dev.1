Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78CAC369D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 15:49:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78204402A9;
	Mon, 28 Apr 2025 17:49:04 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 166014021F
 for <dev@dpdk.org>; Mon, 28 Apr 2025 17:49:04 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-227cf12df27so47482905ad.0
 for <dev@dpdk.org>; Mon, 28 Apr 2025 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745855343;
 x=1746460143; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3wqSUDpXcXnmxxTu+hr9nomZYFBKpRv0vV/I3AjiVM=;
 b=yQ7iMp6RJlc5CpCeb5KcaOTRASqlvsZO5dj3x3qz/jcPjUUCVVkUYpwlBTSUjRV3+l
 bqZ/Tp5WspVfoJe7iC1Yph2lzmvBI0Usi80B9tfbGS31UuEFdd3Zsdw2Ft+PyyjuSopR
 JeqhPIS6xQTnu8IBKgTjtYzOvi8L2stSmkimVLUlOJTe8cHWwNcUplKR6ome8sbXRHr6
 m5GYDkLxDlNu2Scoes3uRxaUmSRJo5/yh7nw18jZyva4vBtMWODorYtX73mouK8BdPmt
 LcRwfJ7QrT5fpM2LbIAzRV7lDV3AYlagpjP46mgM7lPx00yHRQblqoVQcieYrECEE1+7
 37Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745855343; x=1746460143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3wqSUDpXcXnmxxTu+hr9nomZYFBKpRv0vV/I3AjiVM=;
 b=tY0nEnCQWZjh9TJ15qEB2dO3CUK7FeQ8jwPFdIvb3rGb7GLjGw7mCI4zWHPzc71Pc/
 vOV0jFoDJsRrzpgQoUlfnQ3JapnohSLNZfCtqPGS48fHuxsrVyINXNsXuW4B1zghYuYr
 8Pps69iS6G0UynQR1v/TJ7+6RZhpcX/hfn2yXtoUDLnjFZIhka4xG8KeLpAJ6SnjCQGA
 FZSOGFFXaAlXF2f0U20+WsyF8FyzWZ1W4Z6ulXOS+KLO9shLw2BG8UwhMjJJMOPjtPo0
 jbe05fNHZQ1fKgxDyPN85LeEqtE24NCUjxIY5UpRWJSG8PbixghvX0JpUctI5DeYKoOx
 mRfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbS1k1cT8J3BE6beQJKaY9TXbh6+l7zQoHGBgooLwTDzNHwCde6d1YLWaFKf1Bn7QHPJo=@dpdk.org
X-Gm-Message-State: AOJu0YwmoTHRqLvjtbFRp5GvcZbWDI2+TaaXEV9qwojHjj/NPuRU4vTz
 a/n2zDT4aTdnqjmiCNUaeI6TSlG2u6QhRlNlc3WNGd1rbAU+k1DlW0oiqqruNuY=
X-Gm-Gg: ASbGncsnCia6jC3PeNnSOPoUBgrTMvJ64t0xLeCDoBv06j7WPuFvr3CSOACW2jWs5WS
 DS2tPgWGq+407/kkiUZqA08UygGLGd2Fy17Ag39NpxBM46ZlYcYBt/iHbE7Qx6kRonRbWFG+V86
 BDrYtJecOjYekzOkkWDWFIsGT+mXgSf6DZ31yZWHCIQ5MN4KUH8h6J0n3+VXHnuBGEma6fYorv/
 Q1p2dFEpnkjyuDBMcafj/uhGXSKlAf38AbOGiXXs1z4Q2hskBMOM7/HyG8U3b6zzR36vlpCtyyY
 5hojax7SiLAEU/wzbBg95WLXjm9fZspT16IOTDYVTDGKB4nFsMz7WatkXqiS9VAnpxHMPodfGyl
 J2a+4EUpjjLNw6kBX
X-Google-Smtp-Source: AGHT+IGc+QEc32VUYONDS/rPuV3ny8O612nTcrmeV6jC0/7WVX7SeTh8oRiYNfgzB4p0GSy/hOgcjg==
X-Received: by 2002:a17:902:f70f:b0:224:24d3:60fb with SMTP id
 d9443c01a7336-22db47f56damr239851615ad.10.1745855343073; 
 Mon, 28 Apr 2025 08:49:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e75d4sm84079115ad.148.2025.04.28.08.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 08:49:02 -0700 (PDT)
Date: Mon, 28 Apr 2025 08:49:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: add one example of DPI ?
Message-ID: <20250428084901.0aeeee04@hermes.local>
In-Reply-To: <2c503191-c235-4fbc-ae7a-d21dbe83d2a7@huawei.com>
References: <2c503191-c235-4fbc-ae7a-d21dbe83d2a7@huawei.com>
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

On Mon, 28 Apr 2025 16:20:22 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> Hi all,
> 
> Currently, we supported several DPI application scenarios performance tuning,
> in these scenarios, the DPDK library ethdev, ring, mbuf and hash APIs are used.
> 
> One of the scenarios is:
> 
>     ------------------------                           -------------------------
>     |                      |       rte_ring-0          |                       |
>     |  packet-recv-process | ===>  rte_ring-1  ===>    | packet-detect-process |
>     |                      |         ...               |                       |
>     |                      |       rte_ring-n          |                       |
>     ------------------------                           -------------------------
> 
>     packet-recv-process dispatch flow to different rings by such 'rte_hash_crc' function.
>     packet-detect-process build flow context based on rte_hash library.
> 
> I think it is necessary to add a DPI example to show that DPDK has the basic
> capability of building DPI applications and provides best performance practices.
> 
> Hope to listen to the community's opinions.
> 
> Thanks
> 

Did you consider the impact of CPU cache on this scenario.
When you process the packet in two different threads, it ends up adding
an additional data cache miss which can cut performance in half.
