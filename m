Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CCCEDDA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 14:48:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F24540265;
	Tue, 18 Nov 2025 15:48:19 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 96E0E40150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 15:48:18 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47755de027eso38745685e9.0
 for <dev@dpdk.org>; Tue, 18 Nov 2025 06:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763477298;
 x=1764082098; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vahx2dbe9IL7hh0XBKleIPl4gb+Ct56cgeSZ59B8XD4=;
 b=GMXdKvY6hmJMMyToTF7QWrk9rtJzXMyYrkM6ub1ZxxENM4mcQLitN/MvAHBosvdmdz
 nqlvj1Qv3jC+UL9Xr3Gxh2tY/sWBknCPU2khwOjO5wJcyvjGx+DTrcNtD7WjLPRf/tDn
 nchrVMIGscarYGIMfotMTvjKZn3w8XIRQ0NgIr/DhdifdnXrr5IXkqUwzfsyF9xxH+Wl
 YSXXv0CkakaJN7nRj/XgqBQ2QFr3pNn+BrL5GOOhvkyK7vPjEFtGxEgsWY2XPZOa2Iu+
 iA6pADoNOQFk+bfu82ewZwkuTKNaZz3pTYGpV/txn0g4Q7RRBldW0RFlzSf1ToXlDNjz
 tpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763477298; x=1764082098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vahx2dbe9IL7hh0XBKleIPl4gb+Ct56cgeSZ59B8XD4=;
 b=cpoEaUfSaImmrqbpvOwOnND5YwMCSvNW1o8YeaRl+Rik8D0z35pq346+Q1bQnQjtEm
 CrHsztcNV/oR4o4cT0SVocCYJzfK/JKzXkAhbBRcXEIFJ3546+Ph7BNKuvx6quqKMA4F
 eNWKQPVV1DyrccbdgX1f93Ix/n+J5NMerpvFYosrTy1PlzCLf/9IZVUr8HEZSkGLuqMk
 /V55y1LgOT/ryjYMdYRYu0wa5OW574TgB1DtugIgFguevTnzaB84ou7Jo3ty7Vfp/0e7
 hs5SVp4Guc2PUmBAQVkXcp8cd7IQGzzEwZrvXZQBpbbiXKFNEQ38pq/R13dJjHEjgVLz
 zxqg==
X-Gm-Message-State: AOJu0Yw6kDP8dCiWYSkNH24TySWHjyP5Ncvf7KEC5niPbec6VipLYyyy
 qTffYjpeVzYp2DHsUll9lxxzz33zp3KKL9fMpJIlYZ2lxfFzLo76i5+6VpaLkQkmM/E=
X-Gm-Gg: ASbGnctrYHwJ8HnFuwlYqt8SmSjAJlfLckt41qhAizE7fU2YyCR2lHJ3LC5yGizZEkx
 AlWN1VwwrsrKPTAu07vzUr2cBlO5W9zYM6MZSaUoRCYbhBdd7dwXEkLN29+leaBm2Wt5yrgGsyR
 mk86qRawfhkKBQkUizefewH6poFZRcNxWBM7/WeJVVaVARKcGziH258edGfThte6rnVAwyCO9Xx
 fLOrqizYcPMXTWQzLsvftYlG+Hv4TVCgaXt4witakHIZBpnOnbp1XMvFh9P8ei0BdBNDnKV9g/U
 wnNSQd89znUsG7XjTiAYNtNHZgjnpLvZXCg4S2jFzIr8V6/crA6BDi/0fEhWbpz64m9jJLBHCOe
 uZBqh3NMEzapqJp0UoWuppi6yzo2HKRrgq+mRwOshREoEZOindXzqdBzPm2YmCtMRZeMvtmKsO3
 uAttNR+5aLfDwypkODHIKEYngOpcPBCIzLwg88xJB8P6k1XLyJqsNGZapUPOTzasI=
X-Google-Smtp-Source: AGHT+IF85X4nZnQt8Wo7Tv8T86jJLu9L9e2ezfkfPLd/X5bwU2XWGMHEB2lyvJ6+cxcLy9XRUwUELQ==
X-Received: by 2002:a05:600c:470d:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-4778fe41af3mr148253985e9.1.1763477298039; 
 Tue, 18 Nov 2025 06:48:18 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9deeb96sm18515555e9.4.2025.11.18.06.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:48:17 -0800 (PST)
Date: Tue, 18 Nov 2025 06:48:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 5/6] test: fix impossible format-truncation in cfgfiles
Message-ID: <20251118064812.19a5dffb@phoenix.local>
In-Reply-To: <79049dc3-8c0b-41f2-bb02-73c18766377c@huawei.com>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251117175332.14014-1-stephen@networkplumber.org>
 <20251117175332.14014-6-stephen@networkplumber.org>
 <79049dc3-8c0b-41f2-bb02-73c18766377c@huawei.com>
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

On Tue, 18 Nov 2025 10:22:35 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> On 11/18/2025 1:52 AM, Stephen Hemminger wrote:
> > Although, it is not possible on Linux (which always uses /tmp)
> > the compiler complains about possible snprintf() truncation.
> > Simplest fix is to just increase the size of the filename variable.
> > 
> > Fixes: be22019a58c4 ("test: restore cfgfile tests")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  app/test/test_cfgfile.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/app/test/test_cfgfile.c b/app/test/test_cfgfile.c
> > index b189d9d7a5..823b48e1fa 100644
> > --- a/app/test/test_cfgfile.c
> > +++ b/app/test/test_cfgfile.c
> > @@ -148,7 +148,7 @@ static int
> >  test_cfgfile_realloc_sections(void)
> >  {
> >  	struct rte_cfgfile *cfgfile;
> > -	char filename[PATH_MAX];
> > +	char filename[PATH_MAX + NAME_MAX];  
> 
> there are many other function invoke make_tmp_file(), such as test_cfgfile_invalid_section_header.
> 
> I think we could modify make_tmp_file(): snprintf(filename, PATH_MAX - NAME_MAX, ...).
> 
> >  	int ret;
> >  	const char *value;
> >    
> 

I think code can use existing make_tmp_file() function and avoid the problem
of conflict on filename in /tmp.
