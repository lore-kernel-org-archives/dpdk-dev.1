Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D055E6529E
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 22:24:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3455A4025A;
	Sun,  1 Feb 2026 23:24:02 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 6279D40150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 23:24:01 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso27962455e9.1
 for <dev@dpdk.org>; Sun, 01 Feb 2026 14:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769984641;
 x=1770589441; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oL4qyqc3+aXxwEyvLw5nSJC6lu1bzU1T30txMhuG1bQ=;
 b=0+F2p7KTzpJWs7Nm1RdiG29BCreefebbRXODebDvDu1szTT3QF3PYSFSbj9vkiNk1p
 5r6EmX+ldop5Fd/axcPIZa4wgjNZnr0udUDC4FPd8i0O7KGiOF9BA9HjHAR3n/mzyyjR
 8OWf5zwjoQ4iAb/ieydSZuq7YP8XmX7pPJJQf1uhJB6FTDx69pQxiOVRru6VBVEz0hJ8
 OBOHa/DF+dZwsWX3hY1wUGEERbnWnY5ceLqBDkVlfAGh88g2m9MIq4Gt08+Zk3PJZabA
 XEmSyhX5Vd0B8mkA5ZPVM5PX3LusVGHyHaHcqPyebH/qwhW3JHTKgUkQrp1toj/umWRJ
 1eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769984641; x=1770589441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oL4qyqc3+aXxwEyvLw5nSJC6lu1bzU1T30txMhuG1bQ=;
 b=bHcbvbu0w9JIYn2+HcY4DS1GZJWIc+GcpC2tR6VIQhTiAxT+h25Ky0DX3eegJ2dN4P
 1pbvGlrAV3ovE6e5WMbZzADmdVElzqWgRJinNlFq8jtg/jLxs/B4Salm+rKQdf3QKzhH
 JENmq8JN4YUq5H8NK9U2UPhaDZbUAQKB20wr/ONK4x2sdfp8BHuL1XHjxHoJd0WvkUq4
 1yhmL9pJg/GkLnnuBt42rfo8JoAs01H+jaIeE89EacCAEHWoY9RuCw6IgYCEm0EUkw94
 SK55hupkjsUC+H41hz+aSIloigzYaKga2KnDmfDIAoszmPZ6mRMv6ghaCKkdITg0RFpS
 oG+g==
X-Gm-Message-State: AOJu0YxjLsX0vmFtHCYlJ+x51XtH5UrJ606rA9sYmlpKm0JleJNKrYt2
 otPqs1+8kgjO6/CSFqSUDbdZIfcpukrgpEXj1jrkFWipsfQEBMhLVQzOfUhOACdXXaQ=
X-Gm-Gg: AZuq6aJYoj6o5JOoe9lEUQxSjC7PfTYBMFdOoHwZeh2YomQbni5xOWr39LMZRiK5fdz
 u8FeOb5MgxVkszK6tNRI8OyTbLzjiEVKHdfKYaNesyc81HbOH72EdlxhIViSiDFY64Actc3Jl6p
 FpRFCXykAxvHIcPBbdgs/ENZfSJrTgXmiLybPaVKnJQ+niyiQVd4h96+VLHUWs+a0M/MZVhp546
 DbQU5EPGptUrFUyAYXBYZvnX6PjRaQwj4oD02YStZEB9vewwOGnnoC5FCoi9dpjdWVgx5Vbg/on
 QrltGsV1h6sKa1wTyNDs8PFjUD9bwUjQbE8JAiy20cni9kiCoaDQD2nRolNHxUzsKEvJCg9D3QJ
 Y+s62dtHtoNGPlq3TFNKOu6B/hDs1dYLfe9pv9RdeLqW/mHB74R+4PQwxHmxIr4LeY2yZlKp7UV
 OGYt4XbQ6y+zjU4RU5IrfETVg3peEKD34HzA+2DXqOSu9e8zFPCGLDke8B7VMdjlM=
X-Received: by 2002:a05:600c:a087:b0:47d:3ffb:16c9 with SMTP id
 5b1f17b1804b1-482db491e3fmr117620195e9.23.1769984640667; 
 Sun, 01 Feb 2026 14:24:00 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce93sm38152334f8f.24.2026.02.01.14.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 14:24:00 -0800 (PST)
Date: Sun, 1 Feb 2026 14:23:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Aaron
 Conole <aconole@redhat.com>, David Marchand <david.marchand@redhat.com>
Subject: Re: [RFC] devtools: replace get-maintainer shell wrapper with
 Python script
Message-ID: <20260201142355.32b3e073@phoenix.local>
In-Reply-To: <5531059.31r3eYUQgx@thomas>
References: <20260131204823.29363-1-stephen@networkplumber.org>
 <3273409.mvXUDI8C0e@thomas> <20260201110108.5d80c3be@phoenix.local>
 <5531059.31r3eYUQgx@thomas>
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

On Sun, 01 Feb 2026 21:16:52 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> 01/02/2026 20:01, Stephen Hemminger:
> > On Sun, 01 Feb 2026 14:51:01 +0100
> > Thomas Monjalon <thomas@monjalon.net> wrote:
> >   
> > > 31/01/2026 21:48, Stephen Hemminger:  
> > > > DPDK has been reusing the Linux kernel get_maintainer perl script
> > > > but that creates an unwanted dependency on kernel source.
> > > > 
> > > > This new script replaces that with a standalone Python implementation
> > > > created in a few minutes with AI. The command line arguments are
> > > > a subset of the features that make sense in DPDK.    
> > > 
> > > Almost thousand lines for this new script.
> > > Are you sure that's something we want to maintain ourself?  
> > 
> > It really is less bad than the awk mess.
> > And the kernel often changes the rules.
> > 
> > The bigger issue is that the python version is not detecting everything yet.  
> 
> Our wrapper is very simple.
> How much an issue is this dependency? What others think?

I started looking because of the patch suggestion to auto download
from kernel repo which seemed like an awkward way to solve the problem.

Of the two patches, get-maintainer and checkpatches my feelings are different for
each.

Get-maintainer is just a light wrapper, so probably ok to keep the original
shell script; but DPDK should consider adding other fields about support status
etc. The shell version is 34 line wrapper that calls 2655 line perl script.
There are some policy questions like does DPDK subsystem work like kernel
subsystem, but so far DPDK is fine. Evolution of the kernel version has
been slow; so developers are unlikely to get broken by having old or newer
version of kernel script.

Checkpatches has grown into a slow beast. With multiple awk calls and lots
of copy/paste repetition. The pure Python version is actually easier to read
and support. The shell part of checkpatches is 559 lines and the kernel
part is 7882; in total pretty big. The problem is that kernel version of checkpatches
changes often, and in fact the current DPDK shell script has ignores for
things that are no longer present or have changed. It is not uncommon for
CI to give different answers than running locally with current upstream.
Diverging for this script is overdue.

At this point, the patches are more a "what would it look like if"
to start the discussion.
