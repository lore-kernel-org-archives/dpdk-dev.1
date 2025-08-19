Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923D8CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 16:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA285402ED;
	Tue, 19 Aug 2025 18:03:49 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id B4455402E4
 for <dev@dpdk.org>; Tue, 19 Aug 2025 18:03:47 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45a1b0cbbbaso39713515e9.3
 for <dev@dpdk.org>; Tue, 19 Aug 2025 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755619427;
 x=1756224227; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BL1+033OzqhihCRTAOSxoZLxjEH2o27sTeEJQXKEO2Y=;
 b=nVgwJKKaz9YIKc4M0MWp6T7F8jQHu+BJRQ60EMo/vUv5X279pkqmHQSRqqKSNKh7nX
 VadXRdn1eefIShACbXdJ93D4w5bnIeuPxoIQHXazpGuJkafdxV8vypq7MNA3RZUQBptT
 8PiUioQxPKDZ6mHKZDOY0mqqH6Flb7VVNhqAWxO8fSwEnVQsX9/Fye+Rhpe0WrrlPlOz
 2r1qlvcJOCavnjbUc1n5nlsWSQSuER8AO/GHpUIHL8Ll+mM6mjEn3s40bEMsT2Qszl07
 BZ4yK+lJUPzR8x0P4AJzjEJJjomyltr+PROvjsUo0id0aY75XfPd1iqwYugqH+MeSYoS
 noaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755619427; x=1756224227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BL1+033OzqhihCRTAOSxoZLxjEH2o27sTeEJQXKEO2Y=;
 b=mKCTsqPFVYucVjNL28GlPrnxAG05NezmqAjFOm5r+X8R5r5Gnz/cGt3p7MrHAC5VgX
 iD+y6Hw/86DAKTJVHzuT9fhwEhHiqLOsQGAcWbbfbvvnXlPZwXrFak7w3eygGqAiChFp
 pI+DfUR1RCiQNUsaa5YoEJGAC+BtB73o/GXRiF84O8j0pvsCg/50rvthjOuc5plKVuBo
 mg1MuOSx9+DHob2tA4RagyIYglLRd+Dw6QpSQyolqhIkcaJttqENeJulFexi68b86MOI
 QkALe5HMbl7SLhspmmkLi7iLqlejBnFmXxLW26JdPTpRiyuLLpr7RQKuZ4Ji74fK9jlj
 4j3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgfjsYIi6Oym/lTVw3bdNNAua8aJ/ZNXbMIPHVtxT6+p2q7fYEYFmt1/ddBGJwKvuAtew=@dpdk.org
X-Gm-Message-State: AOJu0YyOq93WILiD7QnoNlkshBnQqVZpw6Gp9uFEyqgjHT3/xBnk1dSg
 AH7fYYf6Kw5/WX41tnkCGzJF2+pliQMbNv8Q3qiYP/eiT8MxMiJ9i+tuNrQQntssCts=
X-Gm-Gg: ASbGncsIl0QqFW/bRKYSuwen71eDjF/8DgaKR0gz8GHKn5puzCsoceNRwkUeemydjwh
 HJ7VbgcbwZ8pIK6j2pbyN31kAsgbB/rTxD1LPfaVw+1VK6ccvfFmXolzkSj7J0NrfRXIYaJyuh2
 YoNv8eFgaHjKSS+TJjl2EIW1q8NTv07qToEZkMpi6ox+cJjedhrnvHlXFF1nUg2ErebhJz1J0L0
 MK1DtLP/tZTlGjrm5XhKakYYyuSvP+j3M31hvW6IlNPFLYo7mK5RqgXXIZ/nYGLOGby4PhYZ83x
 D4a963GPud701V59kd2J+1QCUGXNHGf8+jToc1uSxURKOaLLsWCmE5p5nnZsfozrmUwvs9RonL9
 qY/ccdMVuEkU/UC+2xsh+slDuHl6t7h5ke+cdTCSoGrbzxpg4YH8tPCqTGdvjApCMY0KsAnADDT
 A=
X-Google-Smtp-Source: AGHT+IGQAq3yelzdhwSVUGECZtbPJuMWVqtOvKjf8Fv+U1LspCAhEYJaPd8gfMMC//ZpnBQKSR8rRA==
X-Received: by 2002:a05:6000:290d:b0:3b8:ffd3:7a7a with SMTP id
 ffacd0b85a97d-3c0e29accf6mr2502623f8f.16.1755619427094; 
 Tue, 19 Aug 2025 09:03:47 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0754f3b7esm4005339f8f.30.2025.08.19.09.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 09:03:46 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:03:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>, "Tyler Retzlaff"
 <roretzla@linux.microsoft.com>
Subject: Re: [RFC 01/47] eal: add BSD version of queue.h
Message-ID: <20250819090341.0ce15d26@hermes.local>
In-Reply-To: <aKSa7Hjb-UIh-4Ak@bricha3-mobl1.ger.corp.intel.com>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <2598643.Sgy9Pd6rRy@thomas> <20250819082444.66718343@hermes.local>
 <2710899.tIAgqjz4sF@thomas>
 <aKSa7Hjb-UIh-4Ak@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, 19 Aug 2025 16:40:28 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Tue, Aug 19, 2025 at 05:29:28PM +0200, Thomas Monjalon wrote:
> > 19/08/2025 17:24, Stephen Hemminger:  
> > > On Tue, 19 Aug 2025 10:37:27 +0200
> > > Thomas Monjalon <thomas@monjalon.net> wrote:
> > >   
> > > > 19/08/2025 01:27, Stephen Hemminger:  
> > > > > +++ b/lib/eal/include/bsd_queue.h
> > > > > @@ -0,0 +1,1075 @@
> > > > > +/*-
> > > > > + * SPDX-License-Identifier: BSD-3-Clause
> > > > > + *
> > > > > + * Copyright (c) 1991, 1993
> > > > > + *     The Regents of the University of California.  All rights reserved.
> > > > > + *
> > > > > + * This is a copy of sys/queue.h which is used to overcome
> > > > > + * missing parts in the glibc version (and Windows).
> > > > > + */
> > > > > +
> > > > > +#ifndef _SYS_QUEUE_H_
> > > > > +#define _SYS_QUEUE_H_    
> > > > 
> > > > Shouldn't we rename this include flag? with RTE_ prefix?  
> > > 
> > > 
> > > No, by keeping the same prefix if the user includes both sys/queue.h and bsd_queue.h
> > > there will be no confilcts.  
> > 
> > You mean by checking _SYS_QUEUE_H_ which is the same as sys/queue.h?
> > So if I include sys/queue.h first, I will have a limited version.
> > It means we should not include it before any DPDK include.
> > It looks like a limitation for DPDK users.
> >   
> I think we should define two defines for our header, and warn if
> sys/queue.h is included first.
> 
> #ifndef _RTE_BSD_QUEUE_H_
> #ifdef _SYS_QUEUE_H_
> #warning ...
> #endif
> 
> #define _RTE_BSD_QUEUE_H_
> #define _SYS_QUEUE_H_
> 
> ...
> 
> #endif
> 
> This way, sys/queue.h contents will be skipped after our header, but if
> it's included first, the user gets a warning about incomplete
> implementation.
> 
> /Bruce

There is a similar issue with kernel headers already. And it lead
to lots if #ifdef __UAPI_DEF_XXX which I want to avoid.

Rather just do wholesale replacement and if application includes
the other header, it will work since the BSD stuff is only used
as add on.

