Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D3CD5BAA
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 16:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB52A4042F;
	Wed, 20 May 2026 18:45:36 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 9E8F6400EF
 for <dev@dpdk.org>; Wed, 20 May 2026 18:45:35 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2f03d6cf77bso5148947eec.0
 for <dev@dpdk.org>; Wed, 20 May 2026 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779295534;
 x=1779900334; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKlaGBq8ePXWbWq4Xebm01zavj5iYf0bldCFAOvmPqs=;
 b=WGdhVMkSfZwwJAjZB5+zwsyXL+rJaKYgSr7Eh+Cb/voybxNI6sRa7z2bxiUivHE6oe
 rlF+hRnU0pqftbeZgTYZ79QJnfQwJPZQ5UiAVtKoUr0uropH2a3kn3XkxWKKggDFdKlq
 gjdGLH5v7fjso/ZXxhZc75zYK25oHaL15r+vY6Uw7OrM3J2GgNtxNyAj09JyQFDx741O
 jZr3517rAb+joGMg7r6xlq8iXWqKu+EnYrNadKCgzE4/R/A+PrLId1T78De2sFytWADK
 ETf+F9y5yg/cPqPlLhHyjpkubEH339zp6FkaUygSHYuz8ydMJ/82qWsISiun5hepkiU/
 uYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779295534; x=1779900334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oKlaGBq8ePXWbWq4Xebm01zavj5iYf0bldCFAOvmPqs=;
 b=dlJ10hPyHIFh1VLLQ3sEsuxhuuQHCIBkV4VfbkCtzaXwmZCNqqn/R4zxCPTQQcJNX2
 lpvOMMlyvNPdQCCMdBwRSBhLPjwrk4dc6JQ4jf4y8HfQpCxWC47a1rFA/mAF/KsIxnwA
 D2G/8ITOT1CRFcguJNwY7vQtPCAtx/DANBoPSWEacap8QtXibTaJt/0ccLEt7h3XAB5/
 e4tCtwdGPbGY42FFRPS3Ysu8HkJIxlboIJZKnzQWGHc3KNthHfaY87gnFX1a6oMvCeD4
 i/1NY3lWOLSZXduKYAO1W92D/A2SNp/s0EIJF1yDzZqe1V7n+WIQmI/m+Te5+iM1HejY
 5OTQ==
X-Gm-Message-State: AOJu0Yx4/N6Q6tcFzqv+M1G7Pxu3guZ5S3haNIPPNlATgCAW+JKD/c4H
 Z47wSdtEzTZ3Le/10Hfdzog0wtq0xp47U522mzpIHLT3yNeXjwS8SDs9TsBzT3UPRO0=
X-Gm-Gg: Acq92OEuP6tMFJi16iOY18k9T7fj/g+Yk+JoWb0m8al7VL0b2JUhsZa8hwL0oBQ2Vdv
 C015VNylkJ81Y8yscnbGUIxG6hguj5KJfFnCjEYI3IvGAQyR5+l4O3tMjzsfRd1FpNqcKrgbBmV
 3TRctsRl8FCIkdX5Wt9dy70M1GrrkUYKdSKjjZj4zeIRqMmYFOAbIwtFVlmzRtgTfYpFECQOTid
 zSAntkAydAb+jUE95wA+88ZHL3fdU9JLuvHonpl2svcq8WsrUZFtdLYu2QfB92wcCRniUosbuoh
 7Po4npVfQgXMblVYlyxlfcdnhARGIhcAWr2+sJS9Gg1TYVhQAHgxejJsf2n4/UoR6zwXXoqrbHI
 xS9Ee6R7oDTxKj5yrVMGsj7vTRqQnW3TW+DY69me8GcM6jdD2WBkeFXzZYopqsetnAWmPRe5q4g
 2rQcEfh+c+z1yElv6lhVEzybOWtyjSX2JoXODOU12r18GN5iyf2aIyy4OsTieY1J/e
X-Received: by 2002:a05:7300:fd15:b0:2de:aafb:feff with SMTP id
 5a478bee46e88-3039818b0b2mr11062107eec.2.1779295534399; 
 Wed, 20 May 2026 09:45:34 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302977a9474sm19232567eec.25.2026.05.20.09.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:45:34 -0700 (PDT)
Date: Wed, 20 May 2026 09:45:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC PATCH 0/8] remove use of rte_memcpy from net/intel
Message-ID: <20260520094530.5e444422@phoenix.local>
In-Reply-To: <ag1me_1XSByq3p9V@bricha3-mobl1.ger.corp.intel.com>
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
 <20260519124332.5e68fd8f@phoenix.local>
 <ag1me_1XSByq3p9V@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, 20 May 2026 08:44:59 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Tue, May 19, 2026 at 12:43:32PM -0700, Stephen Hemminger wrote:
> > On Tue, 19 May 2026 16:05:57 +0000
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> >   
> > > This RFC proposed to replace all instances of rte_memcpy in Intel
> > > (and former-Intel) net drivers with just regular memcpy. This is
> > > done on the basis that the memcpy use is not datapath, but is used
> > > for flow configuration, virt-channel (to firmware or PF) messaging
> > > and other control path functions.  
> > 
> > Makes sense. You might also want to look for where structure
> > assignment can be used instead of memcpy. Keeping data types
> > is a good thing.  
> 
> Yes, it would be nice to use in places. However, it's not a mechanical
> change so I've not taken the time to do the analysis. Just a quick set of
> sed replacements for this RFC.
> 
> /Bruce

There is a coccinelle script already to do this.
It is slow but does find things.
There doesn't seem to find any matches even after this patchset


