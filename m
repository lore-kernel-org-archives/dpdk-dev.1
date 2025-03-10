Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFF0C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 15:36:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6263F40279;
	Mon, 10 Mar 2025 16:36:44 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id A3AD040270
 for <dev@dpdk.org>; Mon, 10 Mar 2025 16:36:43 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso73656295ad.1
 for <dev@dpdk.org>; Mon, 10 Mar 2025 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741621003;
 x=1742225803; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Moec8HaPfoMgeGpzJVC1raYcH5VQQlgrjfsITs5NT0=;
 b=zXKQN3n9hbffOxGegzcSeHaaz8H81xY4dE2J2v4ZWx0HDCKv4wr/KYiATLpz5Lr5et
 MOOd44G0lDZ1F9eRx+nPvuh7WuJVeGz3mCqqwwgm5/Rih4QSSXSWenWw5vP6XHIb+qiJ
 id+x86nB3TLtYyvGb8IaO96EeP0wOuEFwIvgnsyTJHtT9DRT8l7mV0XEpGqzhwep6pcz
 DvyTZCAqsWViz5KgS8oLMUzLN+W0QF30LD4+Mf/YRkWDI7fYCNPE6JTQxqquK/ZJCYji
 lXPBDvWM9wfBnlghrfboHZ5h8xi03bwOn2PN7epEWjckIWBY5UvIT0j8m7mYDbTa8wgm
 A7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741621003; x=1742225803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Moec8HaPfoMgeGpzJVC1raYcH5VQQlgrjfsITs5NT0=;
 b=D3jcZaot+0Mu76x3a5+BeA+xvf5Faf1lLo2GlqQtcLIE/iQPifpT/YqUesfPv5qgrN
 UKNR0r69ayQUHOyHRtqfp3dZnwivFxRJ6krUFLKvleldTEHxrN18Ng6u/JFBXlxm4hhs
 vcqN3vkdl0Cz8mFryyR9H5P8Z/iPM5/5L2ASlsMcs1BxZ/87e5xPh+UQ1GLzJPWi3sPU
 Nsu/xAAwjndVjuyKFOg6MeQBhuV7UYAj3j4m0TtzxQJAgowjTBeQGHOzEVfu8BYhCzU2
 NLpBjHGglh22DWGplsl9FpmCldMZDg58c+Vz2SWMEiK6XA07GZSxZifch/unAESXVo21
 Ni4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJfgxQ50zJLmxxgEDaZo/c4KAVq0a+uFmzeUNdsIqOwt1Ir7AQ0rTySy0Nq9ZbyLqs4JY=@dpdk.org
X-Gm-Message-State: AOJu0YyKBYWvKKiwyKWsLArtbizwQFrEH4CivFTkdPsYrItFBAIU+ADt
 uSb4yeKRJ+Wrngx9/5z+vmRV7E9GVH65nFg+vsHKREJw8Zjcu1iiNdV5HZ07soM=
X-Gm-Gg: ASbGncutKtUTCwavs5rCpI7nUWwGn4v1A3hUwqGiEXrqBDplJiXnXi9xFQpG1n2lNZW
 7wZEVkW6ayd24XqH16/JhrWPCMzdLTo4iuuPWyEenTAqI3koqV37lZEc3fT0KOqcZUCRmQOI7fA
 HVGtWBR2RWHaUCFqqu9EAhDgFY4Ppj7DYeAUcTZz0tdJTvFw/DX7SE7i0OLaT0UXQ6qq6Voj30t
 AmlZ+hXabuvB0VbNDMIeiJfJwAfEjXzuvJ3cL5yyQV4rdYUAOanKf/ci+ksOBslGguZakbOdav8
 9bNl6Y087qC3DRR4UHpWFZ21T+9hqz6HrBd+3uODNG6IW7yZici8lZ9jt3nx7Za4XtaJGrvrpin
 Z4XEoJMvxugGte81sV5i7hQ==
X-Google-Smtp-Source: AGHT+IHNMZVm3PRih9xF0JSWRTIDhuKKYMG22utp2f5g5hPURBbo63H8RXNey5KJ7GHFzDvmoHk2Ew==
X-Received: by 2002:a17:903:22cf:b0:215:742e:5cff with SMTP id
 d9443c01a7336-22464532dd1mr169436105ad.16.1741621002786; 
 Mon, 10 Mar 2025 08:36:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa5c58sm79451505ad.234.2025.03.10.08.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:36:42 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:36:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Andre Muezerie <andremue@linux.microsoft.com>, Yipeng Wang
 <yipeng1.wang@intel.com>, Sameh Gobriel <sameh.gobriel@intel.com>, Vladimir
 Medvedkin <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH] hash_readwrite_autotest: fix printf parameters
Message-ID: <20250310083640.46df23bb@hermes.local>
In-Reply-To: <Z87ER_iHAgTw1wuO@bricha3-mobl1.ger.corp.intel.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <Z8q16Ikzl4_flbpK@bricha3-mobl1.ger.corp.intel.com>
 <20250307223401.GA27687@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Z87ER_iHAgTw1wuO@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 10 Mar 2025 10:51:51 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Fri, Mar 07, 2025 at 02:34:01PM -0800, Andre Muezerie wrote:
> > On Fri, Mar 07, 2025 at 09:01:28AM +0000, Bruce Richardson wrote:  
> > > On Thu, Mar 06, 2025 at 12:03:28PM -0800, Andre Muezerie wrote:  
> > > > Compiling with MSVC logs the warnings below, which result in
> > > > build error:
> > > > 
> > > > ../app/test/test_hash_readwrite.c(73): warning C4476: 'printf' :
> > > >     unknown type field character ''' in format specifier
> > > > ../app/test/test_hash_readwrite.c(75): warning C4474: 'printf' :
> > > >     too many arguments passed for format string
> > > > ../app/test/test_hash_readwrite.c(75): note: placeholders and
> > > >     their parameters expect 2 variadic arguments, but 4 were provided
> > > > 
> > > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > > ---
> > > >  app/test/test_hash_readwrite.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >   
> > > IF the "'" character is not supported, is there some other method to do
> > > thousands grouping in MSVC?
> > > 
> > > /Bruce  
> > 
> > The problem exists with all compilers I tried on Windows:
> > 
> > 1) MSVC logs the error I mentioned above
> > 
> > 2) GCC and Clang don't complain at compile time, but don't honor the "'" as a special
> > character. As an example,
> > printf("%'d\n", 1024);
> > results in
> > 'd 
> > 
> > It seems that for this syntax to work as you would expect, support needs to exist in both the
> > compiler and the libraries used.
> > 
> > Back to your question: there's no equivalent syntax on Windows that provides the thousands grouping.
> > If really needed (and I understand it is useful for large numbers), we could get the same result
> > by calling a helper function that would convert the number in the formatted string and use that
> > in the printf statement.
> > 
> > There is a Win32 API that does that. It takes a string as input though: GetNumberFormatA.
> > (https://learn.microsoft.com/en-us/windows/win32/api/winnls/nf-winnls-getnumberformata)
> > 
> > We could use ifdefs to keep the old logic on Linux and use new logic on Windows (for all compilers).
> > 
> > Let me know if this is something that would need to be done, or if the current output
> > without thousands grouping is good enough.
> > --  
> The thousands grouping is incredibly helpful when working with large
> numbers, but given the lack of support for this on Windows, we'll just have
> to go without, I think.
> 
> /Bruce

Maybe some variation of the pretty printing code that iproute2 has
(see print_num) would be useful. Feel free to reuse it.
I wrote the initial version.
