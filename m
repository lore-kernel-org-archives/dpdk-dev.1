Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA5FC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 15:13:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 847C140276;
	Tue,  1 Jul 2025 17:13:18 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0FD9840264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 17:13:17 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-749068b9b63so4268933b3a.0
 for <dev@dpdk.org>; Tue, 01 Jul 2025 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751382796;
 x=1751987596; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFKjBpA7TGmkPZNMi6cTmaYThr9JvjOF5pWIOthXqVc=;
 b=0lb+SlNCybJEi8Hyi9P365u145E6jzoT8vlM05sW9qptFB9+CHJmHLDeMjNtORNnJK
 sG6CLJKN5U9i7hzhXzg6RJf5Kq0KAvg6y3/DqwDeyzZltxMk2h7hYVdzQi2QNzgfq1gf
 iWxnK/LD354mwb9gefXEmiLaHKmh1d9bf6XWYVav5ipudXC8EVKrWnrtYUGXwO1oJGPe
 DXlWY1COVgukLpCVHuS4qJ7Nz4/leApqXcIiMu6qrs7GcCgtXEwu/MZuECDrxvftu6kU
 oEEyL96lDFdUYBWqa9HH+j1ojy4iJ3sbNM8HcEyIAYzAtegF7Tuj2nS85chgkWWRk/AX
 A9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751382796; x=1751987596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFKjBpA7TGmkPZNMi6cTmaYThr9JvjOF5pWIOthXqVc=;
 b=MK6b/04Jrd+H/F/ggTwcOtcJz3hqXbfTZOpQh1+Z9BJJxC9j50ewCVD3dDjZ2HWgx3
 A9PmZk9wo9cSXBRglHNb8CWI6J+miaOxtOrjB9NijNkqFGg2qTDUE+e/2sj0j5kI9umV
 as5RyP5YbSBGU6mMw27TDGJZDdskjBOUt3yogDAclAZNpTbal7az+AV1J2O4Qsc4Me81
 cCq7KVJrjW1f/PdTpDG211ozjqu9Csz5O4D8Z7heLj8Hm/85yOa7V+vCi0BYUwqIH2F7
 n/rUJfs0bN/vsZaPTwF9N0mcQkx+9VRJ+SQArYv0oU5ZUVjEhJq5h2hpfQSCbUf00bFl
 Q+zw==
X-Gm-Message-State: AOJu0Yz0Mn5c1FXdGPIY/wJgIJFSisgqR11dyaebXoqBPX/0FPUacNEc
 gmqHtsCXhh0r7QhgtgHAnSyHXm3E1Kg22CTpSLaMz5A8bVOhWVwF5qze1y7Fl+BhelqR2+0mrMq
 w4y9GodE=
X-Gm-Gg: ASbGncutYZEOoyWfqFRYkRch7JaLBm8Oa3myaIDWDMuzQuvlAZtbjbAT6EataZcFr7K
 Ld2jMJSeNVUtK57CtgoEUJC9DWmKbcTcRcxlUw66YOjxXYBj/VUutUBQcbtsl1IJTog/QK4fxaI
 Snvnv/bRUhl4HrFVPIIuGiFE3jGQg4k48fmAn+mfa815VJ1FzzU72Ose1OnIDglD6BCM6L2XXMu
 SI7Qs8ZMU0pR8Mx5t98EJYxZPqijGCrkLhWDQITlKMfPdi7D+x+4PFKSD+tTt6Sg7kkKXhHV0AU
 IpaL6N7IkVmYYCViLxJsl0OQAzMN9ttdKam5FdVWNcKrSYHTghmekxnhAJmYP3pPSW+X19orzjs
 g1k80ivaqXm0JApmjtS/lmy7JsUyc9SOjvUwajAI=
X-Google-Smtp-Source: AGHT+IEeja72S+1WHikNAV75WY1NwpQHYcF3LA4qOGZo4Or4PMsHE/ZIJGsSojoZESDG7/M51u+vtg==
X-Received: by 2002:a05:6a20:1586:b0:215:e43a:29b9 with SMTP id
 adf61e73a8af0-220a16db22amr26059281637.33.1751382796011; 
 Tue, 01 Jul 2025 08:13:16 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af540a89esm11929761b3a.17.2025.07.01.08.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 08:13:15 -0700 (PDT)
Date: Tue, 1 Jul 2025 08:13:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH v3 00/17] Fixes and supports for Wangxun NICs
Message-ID: <20250701081313.0a3a6dbe@hermes.local>
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

Looks good, applied to next-net
