Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09594CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 17:44:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E733A402E4;
	Tue, 19 Aug 2025 19:44:52 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 1B6B5402C9
 for <dev@dpdk.org>; Tue, 19 Aug 2025 19:44:51 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45a1b0d231eso31271625e9.3
 for <dev@dpdk.org>; Tue, 19 Aug 2025 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755625490;
 x=1756230290; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fh7Qjo/3jVkQ2s3IgByYiK4AeoBGjN50G3okEydLoYI=;
 b=ZdbVZ28eu5XcbfpBtjFEj0UAexVCqzbItdDmBUKytPKuvEm1ps56XH66xuYSA/AHh0
 uFMSYpRLI9DDePTSnlLTL8KALAPLQaRriCNvve5+bhsnYX6LCAOAw/bWh30O7EodfEA7
 ofxw+16lNlDY7WlhJZsPmUl9wvC6Kqrms7ha6vHJhyzzh5QXg/3aJTOMEia5bNmIu+Xa
 /iXcRCCBHNhPb19K54mLMatQwlj+/Q3g4VAxZFLUhrs4SW0MeX37vu59dk6o+8ekDnNW
 1Hz6jtNOBgBdJx7O8NJJ1TZ+0NyJUlze9Ir10kB+D6Uyy2JXNzC6Q4Ma5BQjykzT7u7n
 R3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755625490; x=1756230290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fh7Qjo/3jVkQ2s3IgByYiK4AeoBGjN50G3okEydLoYI=;
 b=CzGdy6wj8rEabClAfIIjYEhrNJePCIer2EWwTvLsTC6pL6GvPYqJs8npGfZDgLJdhZ
 7w7TItxrDvfXSyx+3Mfj5PvCAenbRAlOHv07C+ywVnLfd3gqyMRiWEk9yXLxyvim+b8E
 1ZfqOto0WAW5AJn1YutprnXRORcwXZ/HyJyANYOzUfWbisCloenYL43ZGQGSpOg3Hrld
 fLTnOIFlFsTa9F6TMMv+53fl4u5Ufi80Y3fsAbf+EV3cGEdH95n1JzefSjzLHdkSOdQt
 aRnXvRUTTtkHL8bIVzd2DZB2ZSv5nmeZxAEH9rBGz8//gyclyCZoyaq0jAZtV86bnOrz
 TpIQ==
X-Gm-Message-State: AOJu0Yzxp0mNUjw07qg10SfYA+sp4sjTem+4tf8fE6OpA5Vcr6lv7BYq
 Z99BGLgJGt02aAGGmdBRqGRDNusiDDJHO9bU45oDKzqXkJUx0mjrpRTGnpJFuqCLLiU=
X-Gm-Gg: ASbGnctL8I6JtIjQSSNPCM2bU8GYNlkXJ1h1leBqXaj2FCKBpy11LejZKpY+cA/V8nQ
 iwZ+htSk9Sfy9eFFZiecqzNe2Jn1iIYLm0BGxDo8TG+7N5N4XAsux2SOa/toYftST+Y0i2XzOcJ
 YWhisokS+z+O4SutRfCEMvMNIzlQ5dT+OIidxJvhfU/PekwUPY0qCHtwKU5t6Ig1F0ns+cp0CUX
 b5m1BbZvVqvl6PqHmVSbtMpnLyuO0ODIyloYHF2fGWiczDsiz1hjp0NnzW8tHcfa9IhaayiPETI
 Wf95XmpNVmZZqyOFLUDATxDjtB5/kmuIXq3y14efHb+GOSUo9eSWMHFxHB5k9Hbd24ga4opJTho
 tANJMU5QaQkoIONkbcJg+Cn+wX0kXLWDJLSNmQ3yY0SeVvU+0HF7TBZkKHP6Q3d4K/hKHqB911M
 E=
X-Google-Smtp-Source: AGHT+IHMTC/j7moVFHaViOFylyCaMrCGy39NCA32/CSNmzg3Pe5029uNW9oTBjNUsZNrPoyDbRoKfA==
X-Received: by 2002:a05:6000:18a2:b0:3b6:17b5:413c with SMTP id
 ffacd0b85a97d-3c0ecc32383mr2905387f8f.39.1755625490415; 
 Tue, 19 Aug 2025 10:44:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0777892f8sm4420054f8f.53.2025.08.19.10.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 10:44:50 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:44:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>, Bruce
 Richardson <bruce.richardson@intel.com>
Subject: Re: [RFC 01/47] eal: add BSD version of queue.h
Message-ID: <20250819104445.2bc2af51@hermes.local>
In-Reply-To: <2710899.tIAgqjz4sF@thomas>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <2598643.Sgy9Pd6rRy@thomas> <20250819082444.66718343@hermes.local>
 <2710899.tIAgqjz4sF@thomas>
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

On Tue, 19 Aug 2025 17:29:28 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 19/08/2025 17:24, Stephen Hemminger:
> > On Tue, 19 Aug 2025 10:37:27 +0200
> > Thomas Monjalon <thomas@monjalon.net> wrote:
> >   
> > > 19/08/2025 01:27, Stephen Hemminger:  
> > > > +++ b/lib/eal/include/bsd_queue.h
> > > > @@ -0,0 +1,1075 @@
> > > > +/*-
> > > > + * SPDX-License-Identifier: BSD-3-Clause
> > > > + *
> > > > + * Copyright (c) 1991, 1993
> > > > + *     The Regents of the University of California.  All rights reserved.
> > > > + *
> > > > + * This is a copy of sys/queue.h which is used to overcome
> > > > + * missing parts in the glibc version (and Windows).
> > > > + */
> > > > +
> > > > +#ifndef _SYS_QUEUE_H_
> > > > +#define _SYS_QUEUE_H_    
> > > 
> > > Shouldn't we rename this include flag? with RTE_ prefix?  
> > 
> > 
> > No, by keeping the same prefix if the user includes both sys/queue.h and bsd_queue.h
> > there will be no confilcts.  
> 
> You mean by checking _SYS_QUEUE_H_ which is the same as sys/queue.h?
> So if I include sys/queue.h first, I will have a limited version.
> It means we should not include it before any DPDK include.
> It looks like a limitation for DPDK users.

Yes, but that existed before, no change.
Should be documented in new code though.
