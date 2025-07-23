Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B8FC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 19:20:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC2C1402D4;
	Wed, 23 Jul 2025 21:20:18 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 24F6140267
 for <dev@dpdk.org>; Wed, 23 Jul 2025 21:20:16 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so307720b3a.2
 for <dev@dpdk.org>; Wed, 23 Jul 2025 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753298416;
 x=1753903216; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTVOcCDX+yh6LlKaRLJVOheApsAIeTPaI/cCJdOyULw=;
 b=Oh702ZbofpdK5DWZ6eRwXXTv0RWcb+a3B3lAjj/8jKh3y+jF/MGgs6I6V7MZs0oTR2
 XYueUeIXBLxPFG/Tz5LEaXE+4dpsFPV+YzAlX0EjrsSnNKud0F9snBoIOQh/bXmPBsPF
 PfCR/IZW7MSsE00IG2DAVWTtc5w/QCQkpvadMnOuj0p5Id6+DNtOM/dWfdKmY02snwD5
 1Q50EcmIXQGDAEHzvAA9Ott2+b5i8z6kFHZU130xczfMDgZS+ZXF57wK30/3tBN7ZzjU
 SlnQ0nkWTn674j+7h9EvKaZrWzaeiFZY5WeWSXAx5Pgzjn4Mdv5SPVZnh/Z4unoHqKvw
 xkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753298416; x=1753903216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTVOcCDX+yh6LlKaRLJVOheApsAIeTPaI/cCJdOyULw=;
 b=pDpMjqRev2M6PQbPILqgtgbVvB1nzgY0+UdR9b9+wH5x7MqU2hX3vm4h2FuB5a+QqS
 +hECcJ1BkEuqRlOtWvBkAPRyOBAIN2KrggLP6tI9zQIpNK54HhkXEy0o1oSwokktDkWw
 tMsVy14ly+EpjrSRQB0+jueZlB9XymVN7cldS6IrduQonnwfLmjxvvRP4dmiR7xvZuTG
 OocDebwY4lwHMIJPBHIwfZEDKWedVUD3rSFHRglBfB1nTklXhIFrhq7UVLxEssjLWANt
 R0Z21vmR5vCglTtiRwMMeX0VfBO7AxQpVYlsffQ1UKYlXyEQ/HW5vxVmikyp/OilfNkj
 M7GA==
X-Gm-Message-State: AOJu0YytMxoW4ucHSEGJEIEgTPUjs9w2H5Vn62YrP3+Dofxa/o/F/OtZ
 zzpkWeJyFPMpcAlyv/ES5GwXaH31Q1LaLJcpXbNYFa0BxkMRCZP3flFKrw1ndGkUi5E=
X-Gm-Gg: ASbGncsMfcFsS4+OuMq7vkF52wWIA5MV6TpoWcqLWNV6bObB+EMqt15LfyPqMUx4+2d
 7MtDJgUwsWnEOJSVeh3bt+Vjsci/PWYExJNAdt3CeMYLseDNfwmoWFj65iDGXwvekdvoTUBIjUQ
 RgsOUW4tfWU2hoVg7IsMXgiXGt0oxL8bB185PnsWZtb5DVL+Y8GQiJa8Fz3yRaGEVmlqC0tjmnq
 0ARei6XSQZL6LbGXxzGyYJlcF+xjwJBlZ1oqpvQ1SN1L4ptz1XLXWPsSR6gXay3GGOJYgqLXW7n
 t9wCEICTRQkm+XwndrnYI0kEFzjwqURN0JsihuM32iofdfZ2LIhDd5K2nqVyUiPj1II6WfHpnTD
 g9SOYfGEx0z8rhGfSRspNEzCa1gDHdhgB0/dFuMWRB9W2OXiRras3fKEQ9NbI+hT4s0csr/hEMg
 2atMBpTv6g7Q==
X-Google-Smtp-Source: AGHT+IEnpR7TUJh/ma8tMChK2QfSWeC3lwSzDHA63LL93Zc27Qa676Yk0o++0hJvNNdLyfceg+FAbQ==
X-Received: by 2002:a05:6a00:2345:b0:74c:f1d8:c42a with SMTP id
 d2e1a72fcca58-760353db5admr4737724b3a.13.1753298415865; 
 Wed, 23 Jul 2025 12:20:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-75f24cea21fsm3849382b3a.32.2025.07.23.12.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 12:20:15 -0700 (PDT)
Date: Wed, 23 Jul 2025 12:20:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v6 08/13] pcapng: split packet copy from header insertion
Message-ID: <20250723122013.3494427f@hermes.local>
In-Reply-To: <26484aa4-4065-04de-8327-263178b81ece@arknetworks.am>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
 <20250722173552.184141-9-stephen@networkplumber.org>
 <26484aa4-4065-04de-8327-263178b81ece@arknetworks.am>
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

On Wed, 23 Jul 2025 06:32:45 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Hi Stephen,
> 
> On Tue, 22 Jul 2025, Stephen Hemminger wrote:
> 
> > In new model, the packet was already copied, only need  
> 
> Copied? But what if it was "indirect attached" instead, as the model envisages?
> 
> Perhaps this is a silly question of mine, but it may not be clear what happens
> in case of 'RTE_ETH_MIRROR_INDIRECT_FLAG' - whether it is safe to modify the
> mbuf and whether the 'indirect' clone has to be "freed" in the sense of being
> detached/refcnt updated after successful pcapng write, to avoid memory leaks?

The indirect attached is for the direct (no pcap case). Code should
have checked for flag conflict.

I dropped the flag in next version, too may possible bugs and not useful
for the case of packet capture. The problem is that indirect method assumes
that transmit can handle reference counts (won't work with fast free), and
on receive that upper layers do not overwrite packet with refcount > 1.
The Linux and BSD kernel stack have these semantics, but DPDK does not
make the requirement explicit. I.e too many risks for something that
is experimental without current users.

