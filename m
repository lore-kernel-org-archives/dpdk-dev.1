Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9FDC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 18:05:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3621B409FA;
	Tue, 11 Feb 2025 19:05:00 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 459D54067A
 for <dev@dpdk.org>; Tue, 11 Feb 2025 19:04:59 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-21f5a224544so51794465ad.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739297098;
 x=1739901898; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ssXKssOmMRLh2zApYAwVtZ20i0MpS6QYMq0d/cNEg0=;
 b=Kk+6QDWqL/BTdhebwuuMa2aIRvOXBo5mcUKiFd2GnguVWQQFJDUOyvVIJuvQM2sPPi
 wjdBcgQJpbIydN0mESz7PJ48DA8JYbFFyuRebRm0Vu0spbL1+NMtHuivTtrxGpLvE1OY
 4FZleRqrWEPn35gfTIzYjSu9Un56Tl+DgOzauRGSF3I6GmXgqcBMZc14WBgpxwXn2yta
 fvFALHDEhpNv37Ra9qGLZx0hwWED8IMOGxMA/HLm92JQvbU//K26nDiDw9jabQcWDSKU
 PqlhXU3NlUzZDEZK8zOkExBY+iWGSO7UelxYB8/MisvCgBoA70gtLqyrRCDOWNVZcpND
 a32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739297098; x=1739901898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ssXKssOmMRLh2zApYAwVtZ20i0MpS6QYMq0d/cNEg0=;
 b=iG1iupJS8ajIpPnBEE4Hw9dpDxKZyEXaH6pbLT7wRVQnH4OCvCxJWFq2tsASe0ogLT
 UI7IAOxD33wk4Zlq3uoCS50OzzrAw9fzcmpy+nS+HLyPi98s1Pk+E2O1P8bB3bfrUxdw
 iRyfpjMUjs2uiRobRrvlRA2Q+LWpzmBckiVy8z4wKBfwyvGhbw4ZfmOqg8Zn2SnthLpK
 4riCzAPshtcAJbFz9k/vkMHgXqTtQrS70e8oU8FaDirJ+Sb/RtI+tDKwVuxVZmqmtFiN
 5G0N6tL9mZRnod8mMe2NTEGR91Dnlx7TTc/+JBCf4EEN9Q+9jb03dJZBnoj2RgB6R8sU
 jELQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW29pcwwHuktFeOHQKAr2ZTcVHkqUl+e2CopI4v4XBJjsh/Sn9EIEBwP4+I3jczZmZbgpM=@dpdk.org
X-Gm-Message-State: AOJu0YwxWfstBtaNs7y44u8E7Wv6sEyRDYjxBw57ONC0Bt/rrZerkNXp
 FqTCzrkakB/M1+q+vGYmsNHLMXb1bCJXMXLvNgO0tg84KHn/vh1P6r73gcBK/w0=
X-Gm-Gg: ASbGncuGtgNnpxzwLhgGrU80TJXH9IP5XlZ7tS/odL62Rl7cKpXjfeeqFdpS8uRNQ0A
 h+4V3J8TpByzk60JwUlh2Ld/isTVA3oj2Ie25AOt+VQAS5Z6+yWlM3aERVQBJcUCQN2fd6nU3d1
 zKAglJSznFc48hGctTEJ4L0CBeCchTVjUsgp+vH4v5+YmZcKhyKtkVXG2zv4BrO7PDpIj41Artr
 BADFn4ANT1SoSty1hRWWLXsv7gTlFioLD2LxoxagQ4/ySrz+YOw5RyJETWv2yXW5WUFIRARqTG6
 1S8WkJExilJYRsopl6MbpRY9bjXF0R9k0s+4QhZVUWLXtEsN088KtPpGHdlkawJAkgUP
X-Google-Smtp-Source: AGHT+IGplpY8YhJZDdhz5vTr7CtnrYEWBkag05JN9aG96i/nqETcECjMfFM4GBCcJYcy+B3922eOlA==
X-Received: by 2002:a17:903:2302:b0:21f:6005:503d with SMTP id
 d9443c01a7336-220bbc6475cmr2854045ad.42.1739297098390; 
 Tue, 11 Feb 2025 10:04:58 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa0cceff11sm11028278a91.10.2025.02.11.10.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 10:04:58 -0800 (PST)
Date: Tue, 11 Feb 2025 10:04:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Shani Peretz <shperetz@nvidia.com>, <dev@dpdk.org>, Parav Pandit
 <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, "Hemant
 Agrawal" <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@intel.com>, Chenbo Xia <chenbox@nvidia.com>, "Tomasz
 Duszynski" <tduszynski@marvell.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, "Jan Blunck" <jblunck@infradead.org>
Subject: Re: [PATCH v5 2/4] lib: fix comparison between devices
Message-ID: <20250211100456.084338aa@hermes.local>
In-Reply-To: <Z6uO0mlaIYFekKGZ@bricha3-mobl1.ger.corp.intel.com>
References: <20250129085416.226718-1-shperetz@nvidia.com>
 <20250206000838.23428-1-shperetz@nvidia.com>
 <20250206000838.23428-3-shperetz@nvidia.com>
 <20250211094832.0b164537@hermes.local>
 <Z6uO0mlaIYFekKGZ@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, 11 Feb 2025 17:54:26 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Tue, Feb 11, 2025 at 09:48:32AM -0800, Stephen Hemminger wrote:
> > On Thu, 6 Feb 2025 02:08:36 +0200
> > Shani Peretz <shperetz@nvidia.com> wrote:
> >   
> > >  static int
> > > -cdx_parse(const char *name, void *addr)
> > > +cdx_parse(const char *name, void *addr, int *size)
> > >  {
> > > -	const char **out = addr;
> > >  	int ret;
> > >  
> > >  	ret = strncmp(name, CDX_DEV_PREFIX, strlen(CDX_DEV_PREFIX));
> > >  
> > > -	if (ret == 0 && addr)
> > > -		*out = name;
> > > +	if (ret != 0)
> > > +		return ret;
> > > +
> > > +	if (size != NULL)
> > > +		*size = strlen(name) + 1;
> > > +
> > > +	if (addr != NULL)
> > > +		rte_strscpy(addr, name, strlen(name) + 1);  
> > 
> > Why use rte_strscpy() here?
> > 
> > The intention of strscpy() is to handle case where the resulting
> > buffer is limited in size. By using the input string length you aren't really
> > doing anything different than strcpy(). Still unsafe if output (addr) is not big enough.  
> 
> And using strlcpy is probably fine too, without having to use dpdk-specific
> string functions.
> 
> /Bruce

The issue is that any length argument needs to come from caller based on the
size of the target buffer. Not from length of source string.

If you want to make parse code string safe, then either size needs to be always
present and in/out parameter or need to have a src_size and resulting size as separate params.

