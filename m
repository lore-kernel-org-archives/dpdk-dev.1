Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310AECA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 15:24:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CFCE40653;
	Tue, 19 Aug 2025 17:24:52 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 87CBA402E4
 for <dev@dpdk.org>; Tue, 19 Aug 2025 17:24:50 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3b9d41d2a5cso3985693f8f.0
 for <dev@dpdk.org>; Tue, 19 Aug 2025 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755617090;
 x=1756221890; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i71ZaOEiHDqMcC32idBu83QGEbkF+LNaeMfoMCca+RA=;
 b=3Up4+05pqjzHXDOgzGwsG2/6nORofZ9H2HwPMOAU29oQd2GTTfmqBJpZQuxEO39OOr
 xkLbX/Gu7MrSVv5XH6sj7BUU6Ggl5CLrlqA+f8Hjq4vuZcr6mLP8hZ1teqEVnJr2t0l/
 DH47M/8HrKIjOii4YPQYR4e8IWEIc5eUdT88fuFF2h1K34+9uNLevhWr/pbAG67SMHbz
 F5SyZ8P56NFv4AZ+AU4t8xS1ukGZ9Tv75NITj6vVcMapLd0FHhp+hdHXpTj4Ip4CsKzZ
 RGmjSTOSoojiZK2q5duxBxY3U+42lhA8jksny896n5g2bQowl8XYh4U4/B4uUD/hNB0q
 Muig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755617090; x=1756221890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i71ZaOEiHDqMcC32idBu83QGEbkF+LNaeMfoMCca+RA=;
 b=YV28M7MwKUt7utp4KwlIHknwWCrGoTZv5CKO7PbQe2ph7QBVGUeENn3fji5hB61TTJ
 nVqCirLXTj7pOxIXo1epMgZKYflSk1Mkc/WiAj0+RnN+YWXooiVkXReCLJvEMCwK2Gof
 dsxjyLVeFo8QWMR9UibBUnbMh9HeaPNS0iGMYdD1uKpMMswn+U+jSRks+F7sRebuhIo1
 sGRhlCHkBdQyOljUXB6VCLIxVxwkQyR+UQVqKkYX9IrEgyEG0Th5SzDyn5GUzIeOpX7i
 HSOuoEPZWwuRj539AeXJmTg5S9UDYtg5OVHYJuDyhm7V3KVv/UIZJWEf8QvBNxJH3hng
 e+BQ==
X-Gm-Message-State: AOJu0YzHfExGMrIdyknorwJvWLY3zRytclU25xrM8pKPNR8q5LzUTZYT
 BV8Nf8SMhdq+Y+maQMeDWfHB3soEzl7GW4mUoTVERQwsfmqcQPs37Xl5pUloehXXoPA=
X-Gm-Gg: ASbGncs5I+b7USZGCh10xDH9Q2xqoX3SEAOJPlHCrEq50K2CwrW2WPvdo1+kSla2SPr
 qbAjssIZkWC+lnsEUYOCF/sFGHDhO5TCuukk+Y/YPzya1N++q1IBDB86UcHzgewiINpYVdTFjs2
 /Bd74IIyNY5UQAzq77d5OZWyag5MMzRFFOjC7wi/Ti1yTlyJCXb8aZ9wh9DAKdpvPDrEkDXa2sN
 xzMhJzWj4S3LJA2BD9hdcPBul0XC36LnOCBlPptoj+7LDUHyxAsC21mpoymW5BcDLXhJg/iAlj1
 I0N6+ilMP3w6+9PzlIKr+Edwo5br2qgw9m/x8Kr2T4X5juUgBhpADB3WEOq95FYs0U3HvqoOiQt
 QxHLp9nMdsp+fQLQNfSU7pEUYzp+FjcyPM3X74a9ukl9E68vFHXOPOvzAolr4AGKnMY5bPM0ikP
 8=
X-Google-Smtp-Source: AGHT+IF0M3vVKiDUbmtnoGlPpcDGKCwlM6d2pusAV809wiQMy66CobbgRvBNp7yFXxDY7+R7bFDfug==
X-Received: by 2002:a05:6000:178d:b0:3b8:d0bb:7541 with SMTP id
 ffacd0b85a97d-3c0ec09e2damr2469157f8f.40.1755617089660; 
 Tue, 19 Aug 2025 08:24:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c077c5731dsm4087688f8f.59.2025.08.19.08.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:24:49 -0700 (PDT)
Date: Tue, 19 Aug 2025 08:24:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>, Bruce
 Richardson <bruce.richardson@intel.com>
Subject: Re: [RFC 01/47] eal: add BSD version of queue.h
Message-ID: <20250819082444.66718343@hermes.local>
In-Reply-To: <2598643.Sgy9Pd6rRy@thomas>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250818233102.180207-2-stephen@networkplumber.org>
 <2598643.Sgy9Pd6rRy@thomas>
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

On Tue, 19 Aug 2025 10:37:27 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 19/08/2025 01:27, Stephen Hemminger:
> > +++ b/lib/eal/include/bsd_queue.h
> > @@ -0,0 +1,1075 @@
> > +/*-
> > + * SPDX-License-Identifier: BSD-3-Clause
> > + *
> > + * Copyright (c) 1991, 1993
> > + *     The Regents of the University of California.  All rights reserved.
> > + *
> > + * This is a copy of sys/queue.h which is used to overcome
> > + * missing parts in the glibc version (and Windows).
> > + */
> > +
> > +#ifndef _SYS_QUEUE_H_
> > +#define _SYS_QUEUE_H_  
> 
> Shouldn't we rename this include flag? with RTE_ prefix?


No, by keeping the same prefix if the user includes both sys/queue.h and bsd_queue.h
there will be no confilcts.
