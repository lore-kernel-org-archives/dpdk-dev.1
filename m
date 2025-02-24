Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E201FC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 15:42:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 775604270A;
	Mon, 24 Feb 2025 16:42:58 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id BF17741104
 for <dev@dpdk.org>; Mon, 24 Feb 2025 16:42:56 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-220c92c857aso78151525ad.0
 for <dev@dpdk.org>; Mon, 24 Feb 2025 07:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740411776;
 x=1741016576; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWcBPrYEWLZrD8gj0aiCzHYKr55miImNOIz8cPwqC+0=;
 b=yZjFjAiHIvRVoov2zDPD+jhfiCJVI8VbZawzhxj8Umf9Ji2/0n/ki+7sFCp4B50Xrs
 jrsEC4FNvAAlWLw4cQ09kY83Khh/V31pZdmlhPxOQtBInhWQ1EcLQZTNflZVCEDZIYRm
 8xJdWCzOg7UWyvqsLeJwUreZaZUeIlH6R8DMumlRaK/vFreZvzeJINxiLCHdzJ+r7WAD
 mGLX3gHaPbsShNABbzraLcytiyv4acHQMS2I7FIe0IbF4rm3QI6bx7wXtEhuIozJ2azq
 kedPgLJJAaf8M7hOuUO/cwZQZpc2M8FJUUuUnTKpMkiar8mFMywD7aEnIRvQ23y+E8cg
 77Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740411776; x=1741016576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWcBPrYEWLZrD8gj0aiCzHYKr55miImNOIz8cPwqC+0=;
 b=GhGpuiVS/woOCIHpVLrsatA08f02QvSeqYLznFtvFh7Fj4ZXyMRpfzwPB6aBfxS9Yo
 zJUgI4/y/opQyiaY3g/J46Kl/ubJ8MjgyVxpER8H4Y1OuZVETQ5gXQ1QW/p6Uhp0/hhr
 zXD2keomwGGDHAq7Mqxc8XB2LDthGRnlxAA9xIFn9Kh7wsb4b+t5DFskFnSbskFUVRdl
 RnSre878EV9BSGCLJDB8KBlrKQHM5QAF513d0P9O8hjbc0aE5gxY0UWGprR9fpsmPZlW
 +YpqCLk239pWqcUWawBIhIn7I6K53Q49ic3BrdOx7OF4RG6HRjFVUlCKGD2WSJE5zgTR
 Mt7g==
X-Gm-Message-State: AOJu0Yw11wx/NrftpUzvPJERL5+fdX4rWellJ9iDlv2NLsF0n48cDKuh
 SOomwckXcC+v29czHKxnY5xykvGVQzbAMgJQ0oOf7ZQ7IpCGGjcO9YNeIoS+kGs=
X-Gm-Gg: ASbGncsUaZzKHHbZNyMlYGCVmm6JStsxxjyJ3z4u6ORaE5rpA91uQMPhJaDoSXYvwMS
 1LGtiJvLEAyfINAffSc6NA4Bg09hAhFSnX1N3sDKzjfpN7QY8FF8gSzq/V+BSd0fztQb7LPIawV
 uKcBsektgCpv5e/V4m93BjvM23dR0j+iJK/CFjB86qvjoUPu2UKhRexkoPI7n9PAwoQ/YL10F8b
 QNDHI+gpxPdMrmA22mO7As+zgPXFzefQWTjCFS1YxmMg2le0/2y0Ln+YpStArwfdK6qOUoR3FJ9
 QJ3yYsx8RXEvUwCvfD4KfbbLQi5wyRTHpPHSim/WEB6ruhs/4lCyUg6kJNrJ7LlkBA+F77sV4FV
 W/ug=
X-Google-Smtp-Source: AGHT+IGXPHjeGEkJGzUHw5GppxkVH9eHuBAW8tzwq0UXtjoyIqMbrA4u4xMTpwmPM5RDa+cJps0/gQ==
X-Received: by 2002:a17:902:e551:b0:215:a56f:1e50 with SMTP id
 d9443c01a7336-2219ff862e9mr249419535ad.8.1740411775720; 
 Mon, 24 Feb 2025 07:42:55 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491f7sm180368905ad.38.2025.02.24.07.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 07:42:55 -0800 (PST)
Date: Mon, 24 Feb 2025 07:42:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Reshma Pattan <reshma.pattan@intel.com>,
 stable@dpdk.org
Subject: Re: [PATCH v2 1/1] pcapng: warn if NULL is passed to rte_pcapng_close
Message-ID: <20250224074253.3df64dff@hermes.local>
In-Reply-To: <20250223214123.447579-2-ariel.otilibili@6wind.com>
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-2-ariel.otilibili@6wind.com>
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

On Sun, 23 Feb 2025 22:41:23 +0100
Ariel Otilibili <ariel.otilibili@6wind.com> wrote:

> rte_pcapng_close() might dereference a null pointer; as example,
> PVS-Studio gives its usage in test_pcapng.c: indeed, that call to
> rte_pcapng_close() might receive a null pointer.
> 
> In that case, rte_errno is set to EINVAL. The API is updated accordingly.
> 
> Link: https://pvs-studio.com/en/docs/warnings/v522/
> Link: https://github.com/DPDK/dpdk/blob/e5176f23ae8b31437c3e5eb875c81f95bf3a9942/app/test/test_pcapng.c#L438
> Fixes: 8d23ce8f5ee9 ("pcapng: add new library for writing pcapng files")
> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>

The convention (back from Unix) is that errno is only set on failure.
Simpler fix would just to silently ignore NULL case.



diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 16485b27cb..4a0aa6afe5 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -716,6 +716,7 @@ rte_pcapng_fdopen(int fd,
 void
 rte_pcapng_close(rte_pcapng_t *self)
 {
-       close(self->outfd);
+       if (self)
+               close(self->outfd);
     
