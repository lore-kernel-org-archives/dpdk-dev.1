Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38045CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Oct 2025 18:07:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51DAF40151;
	Sat, 25 Oct 2025 20:07:57 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1577A4003C
 for <dev@dpdk.org>; Sat, 25 Oct 2025 20:07:55 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so47345865ad.2
 for <dev@dpdk.org>; Sat, 25 Oct 2025 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761415674;
 x=1762020474; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azwaM6KHoZOeDwwYPZYt4RlxoZ4gnHbtoWwFAasxkYs=;
 b=di8EIWWdKmQqLXFhH8x+nMui2AnMdVKvrQjavo5eryTDgsBB59mxSd9S1jMun4yTMj
 n8dkGJ50f4+R7OHmzYSiJ419dH0nmgZfGBmw1yGqY0cLVA3bedvVJ2aPmjMnKpIx36ZI
 m/Q8kbGYfC9D2bTZaRaxlSLV7iUhQ8msXM6T6oyeYF7yGHtvt6+I1u9YX0S49X7AfFSk
 6PmXtwHKg/NG9hmEJ1tfDVl9KcCwJ7sndpR+b6IuA+iYs0gHxpWNY8HwoxbOy83Inaiy
 ERkGUmhyR909cguQ3Gct4uBdwV2YGOktWawz0UoJwJZW9dWc3WvhIYRccAmbbKX4msLo
 kr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761415674; x=1762020474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=azwaM6KHoZOeDwwYPZYt4RlxoZ4gnHbtoWwFAasxkYs=;
 b=OJkDwQMXlyqsgHShLRaqQlq7IDB/1lVBcqCiwGYCMoNJRjsoquqQoqrnb2fuDmJyg6
 jfZXw7yDw3dEsUHMO15t813WC1u2a1K/R4pxkwbYpcRA4SvACp9peMurRksLUR0Zy+0V
 j5JEA2bEuMiEKHxf+n9OwoaVGsuq3zsK4iipRaRv1ikn/BHE2eQhS/rzxpHT6uKzU5w+
 5Vx4hNi+CaPdciIk7dw1qG8hWS+s774HrpFR/ZtiBvtrSqZUcCPfgYZe905vBovTmLOj
 X038eLronprfbfYkxqXnbaUWX3zOHDm897KQOEIUjOmXNYzUTx5M4cp3nYw1uZyEomOR
 kuig==
X-Gm-Message-State: AOJu0Yx7CNfcpw+eC890Zwo8+JcLqb29qZwJ6FUzKAGJM8uzt8eAJX7H
 E5LLdLEVYEO2H5Gr94BPS2Jstr4JhO4L3ypZvgUlSSIns5oGRWlJlBwQwcvJKgXrGlnfWPqMDV/
 JnnSR
X-Gm-Gg: ASbGnct62Kc9IeHJuY4++Eb7sNK7Ercd36lGqyzMyBGpIqdjYvT76vPT+2opGB9iP1d
 ukWDVREmIP5DiL8LrPqeT7foy4Tc8CXZXVFBzFFu8He/6MjFwRlf6Gntab0+YRoAmX9sSsoNWX5
 WVbtyeXEXHl0uh3ltqgiroJdXDcHSMYZTyElaOqApuUYOogMdSxO8Cv6W1tHMDYBqdq4CxY4zIY
 7RR60HAzVIJqlWlhHCTek2dbrZwIja+xLO5nO7Vju52jSidUTdTfrKetHTQEYpaed2Vmk3lBiGF
 ZsK1FfJ1eR7SLL4KImp/SCOLu6i4OgiEx1b9XPVG0x5yZXtDDMYY7y/na6+7l/Imc+PVk5YSv9J
 sPmA5WFjh+GVkuQl0vz26ETcQImIDjNfFpLL+1+cVZ7BSv/7AAoHW1xoCf2REG2vkhFfojvVpnk
 u//GDkMHXB4bxp68oNX9OYxPgn+VMlyinnXI22ec6kEdByBExwPnSTVog=
X-Google-Smtp-Source: AGHT+IHSNDybxCFlFvSNe3pc3FZrRhjCCk9etM6QS4MWRexbqMiZOfyeg5a2/CY2hAwGWe3BPw/SQA==
X-Received: by 2002:a17:902:e5c9:b0:27e:d4a8:56ad with SMTP id
 d9443c01a7336-290cba426d9mr397149655ad.61.1761415674031; 
 Sat, 25 Oct 2025 11:07:54 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d0ac07sm29416655ad.43.2025.10.25.11.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 11:07:53 -0700 (PDT)
Date: Sat, 25 Oct 2025 11:07:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v6 0/6] DPAA specific changes
Message-ID: <20251025110750.4a6f68ce@phoenix>
In-Reply-To: <20251024061906.3535470-1-g.singh@nxp.com>
References: <20251017044848.3269627-1-g.singh@nxp.com>
 <20251024061906.3535470-1-g.singh@nxp.com>
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

On Fri, 24 Oct 2025 11:49:00 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> This series support timesync APIs, improves
> queue reset logic and include minor fixes.
> 
> v2 change log:
>  - fix 32 bit compilation
> 
> v3 change log:
>  - update commit message of coverity fix patch
> 
> v4 change log:
>  - separated queue shutdown and logging patch into two.
> 
> v5 change log:
>  - update commit message for FQ shutdown patch
> 
> v6 change log:
>  - Removed capitalization for support, disable and set.
>  - fix typo mistake in a commit message.
>  - add standard tag for coverity issue in commit.
>  - update commit message for FQ shutdown fix patch.
> 
> Gagandeep Singh (2):
>   bus/dpaa: fix FQ shutdown to do proper cleanup of frame queues
>   bus/dpaa: improve DPAA bus qman logging
> 
> Jun Yang (3):
>   net/dpaa: support IEEE1588 by timesync API
>   bus/dpaa: disable qman Invalid Enqueue State interrupt
>   bus/dpaa: set max push RXQ number
> 
> Vanshika Shukla (1):
>   net/dpaa: fix resource leak coverity issue
> 
>  doc/guides/nics/dpaa.rst                  |   3 -
>  drivers/bus/dpaa/base/qbman/qman.c        | 459 +++++++++++++---------
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  27 +-
>  drivers/bus/dpaa/bus_dpaa_driver.h        |   6 +
>  drivers/bus/dpaa/dpaa_bus.c               |  51 +++
>  drivers/bus/dpaa/include/fsl_qman.h       |   6 +-
>  drivers/common/dpaax/dpaax_ptp.h          |  95 +++++
>  drivers/net/dpaa/dpaa_ethdev.c            |  69 +---
>  drivers/net/dpaa/dpaa_ethdev.h            |  13 +-
>  drivers/net/dpaa/dpaa_flow.c              |   6 +-
>  drivers/net/dpaa/dpaa_ptp.c               |  50 ++-
>  drivers/net/dpaa/dpaa_rxtx.c              |  93 ++---
>  drivers/net/dpaa/dpaa_rxtx.h              |   2 +-
>  13 files changed, 580 insertions(+), 300 deletions(-)
>  create mode 100644 drivers/common/dpaax/dpaax_ptp.h
> 

Fixed the commit log to be ok with check-git-logs and checkpatch
and queued to next-net
