Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E9BC54FB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 14:48:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C62D140697;
	Fri, 23 May 2025 16:48:03 +0200 (CEST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id EAF1940611
 for <dev@dpdk.org>; Fri, 23 May 2025 16:48:02 +0200 (CEST)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-60179d8e65fso12463a12.0
 for <dev@dpdk.org>; Fri, 23 May 2025 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748011682;
 x=1748616482; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qds6uX72jZ/ZPpsU91fvdIcSg2+ZpiGNy/FD+AsTnPY=;
 b=pjM7vBlJNhf5oyRwXlwBQljC4NS8yBsmYCJb4wRC5D5iuEhgFggm2eHG1saE8l6WXE
 5os+VllbF4t1krNiAAbHa6Jw3Dg1pH/47BAFrpto2St45qeEtIcmVcTlXfhcAn+e40aG
 h5d8jvXeF0LzZSHd6mWN6ERi5nlWXHLK2xbAicHmuScWWugz0n5ssxJnJ8Ppfhou0atN
 V1CfKbuZaWKGfe2R7OjYxOvQhHCnrMQkR8bTgTtk4FZcp976cCEAqVxsPH+MYPpP6Ddg
 KCgtbHHBIE+vmpF6e2uvw5NJr6IrRC9/If8VBHlO2WzXwO62kxkpmVi6v+vbhneV887b
 p1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748011682; x=1748616482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qds6uX72jZ/ZPpsU91fvdIcSg2+ZpiGNy/FD+AsTnPY=;
 b=MdDpPhVQVi0kegZd3cO7Pcdk4zIz4azsWwbEC7EwDuK3hQhGjBq/h8RXlcStKyZvHh
 /8e1zLCiXq9m1EIWorq/k3g09KsbV/uioWrabUwi1k56bWnCjnl4GJphtPVWPQ4ia19n
 OPtySbraU87q0QOU3yJrmCGUaiEtj4IW3NyTUAsnq25gFZyPDbIrKPna1NHFu7JNpdya
 G5DlM2SIu0xEEu7w/ZOzTsE33hTnNaHZ8AdVSQFHoMSDWCYC4XNXt/ZF7weKfPZ40AAd
 a/GxctdW/VjfI+8ePabHQRc2MnsTHss6FsKLU5UXZ3iy11EgTohDv9CkPgMdHb1pEXBs
 dwfA==
X-Gm-Message-State: AOJu0YyJ0krZ07kUi+kTP7Adgxb0BS3Q8je3n2yD+Dr8j7p4IcyHwA8b
 30CjDznsfAIvzrCex6+QkeSrcW48fTF5hbEDTJvuUEJUYSJdYotEvtwLprRt3xWj2m8=
X-Gm-Gg: ASbGncuNZ4GVIuI/oaMJZhE+HhlYfZ4JH8P8DKZTwd/TWjpNIBGyQl9Xr9zAIMBtVQX
 92QUpJNtD9DgXczMPJuGM7uPnyGC6tp40Ohl4WE51OrWWRnDW/niLsk8Uow23FjDnhutxfiTh+G
 T0jT6uirTXY5x0uZlW1ob+I7VavLbWz+wThegrWX50BDA46wIFuy36b2OOvbWZVZYZ24kl2M3nx
 mqkLmyH0cbUlwvCfZjKCaM6REYFoG6mf1hTWJKK/9nXBjZxik7LINS1riC0MfqmpiZqWvbzrqyg
 xu2/WOFqHYAAEyu6iOmYM/v2dY80SQhpD0xc+9z0twn0h/cH1Q4o2dDQ8RKQgihX013foF2VEin
 FilrWxzYq+1E2k3G6xa8gBV69OSjp
X-Google-Smtp-Source: AGHT+IEOyEgNBkAqZNWiUvVuY7S6nXrl9R0iIJVEPBAZ009EBrid+eyAREKXhUbjq5Ce4M4643eVnQ==
X-Received: by 2002:a17:907:8e97:b0:ad4:d335:d35d with SMTP id
 a640c23a62f3a-ad52d45ae47mr2807024566b.4.1748011682318; 
 Fri, 23 May 2025 07:48:02 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d04b096sm1243816666b.33.2025.05.23.07.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 07:48:02 -0700 (PDT)
Date: Fri, 23 May 2025 07:47:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v5 2/3] cmdline: add floating point support
Message-ID: <20250523074756.427bd102@hermes.local>
In-Reply-To: <762c8bb2-f0b3-4cf5-837c-8297851aa417@intel.com>
References: <ec8528874aad76348f27c551289e1729b2fdcd25.1746631324.git.anatoly.burakov@intel.com>
 <b9f8ac77e4eeecd67a83d72cdf52ef3e08539bab.1746631324.git.anatoly.burakov@intel.com>
 <20250521070538.29f64bc2@hermes.local>
 <762c8bb2-f0b3-4cf5-837c-8297851aa417@intel.com>
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

On Fri, 23 May 2025 12:21:15 +0200
"Burakov, Anatoly" <anatoly.burakov@intel.com> wrote:

> On 5/21/2025 4:05 PM, Stephen Hemminger wrote:
> > On Wed,  7 May 2025 16:22:11 +0100
> > Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> >   
> >> +NUMERIC_TYPES = {
> >> +    "UINT8": "uint8_t",
> >> +    "UINT16": "uint16_t",
> >> +    "UINT32": "uint32_t",
> >> +    "UINT64": "uint64_t",
> >> +    "INT8": "int8_t",
> >> +    "INT16": "int16_t",
> >> +    "INT32": "int32_t",
> >> +    "INT64": "int64_t",
> >> +    "FLOAT_SINGLE": "float",
> >> +    "FLOAT_DOUBLE": "double",
> >> +}
> >>     
> > 
> > Is it really worth having both single and double versions.
> > Seems like unnecessary complexity at this point.  
> 
> I'd argue the same about the various int types. I was just being 
> consistent. I can remove the single (or double) if that's desired.


The int types have different ranges, but all float values have same
range, just different number of bits. For now choose one version
for floating point.
