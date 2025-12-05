Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97D8D33990
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 17:00:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A538B40268;
	Fri,  5 Dec 2025 18:00:12 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id AC15440156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 18:00:10 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so32112865e9.3
 for <dev@dpdk.org>; Fri, 05 Dec 2025 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764954010;
 x=1765558810; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcgI2xWFfgO4YFo31UHaJDodyuP6Rws+OWHlL5TEFV4=;
 b=iyvV3ZFHGwjlCUPQGAvqwQ/BeMJ28VEzenP3Awe03IuG5RTUpTZFMYpDYSFm7QAMD3
 LCA/CBr5OhCYyA9wcyWAuYQZHT4bkN/5VNLwi9GxhVM/FZJ+M+y1+CcUaLX5zcx1p+NH
 xphXCVpQHnamtAqgLywF9o74fwmAHDmGhl6oZpjh6kVhmKlBxtD+aeQJZM2DojWuWTQ+
 PRIzRQz6VScXCq5g2wgD2Qb1eoqvGGf4KzMG4hkm8As8+HIneJtUfJQeaF3RKzheBYgB
 XWxtVEucLxnWzlS/NZW7KQJlDeIT5d4vBZWboUNt08y98tZdyqtMhbzd7CsbZ0MzECEm
 fvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764954010; x=1765558810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hcgI2xWFfgO4YFo31UHaJDodyuP6Rws+OWHlL5TEFV4=;
 b=UMhDBrh/7J6joJE8nwM3x+6dAn/CWcdZWfb9MDMk0mZEbJ6VPNn6CSwN8cd4xoex4m
 DZYoNTMW8EbTXOgSWgPm2gTX/3quQ/QL/rjiCIhRKU9pxZKPZgZeUgk80ghuUl36mVMo
 b4WPYK9tu8xcystOWWPTuTdfDYnyAL/zs1v4IQ7OITnruVEthQ45lAPP/ddDyZlU0X3B
 ZtQay2cptzWhl5O/zb6lCfr5u/QKi3D0gjSRe6CXjTXwwk5bcB+xRjEPbVKG+Cm6I8nl
 c/ol8N6E6SzLBSSEnzTqHAX2sEr4Y7sGngNZF9zovtz/H1o5q9wLWd4Gb77fh6K9Pih/
 p1NA==
X-Gm-Message-State: AOJu0Yyz3wz8x1/8ClcFINke+7+lDpMlKq4wT1qX6hiCv0p6VGS8wrIg
 88dhFTgcTnz0873DJbQDy0VwhfMTcGE2JhVnFl1DQaLVXv3b2FbgqruiKPgs1sVCvrI=
X-Gm-Gg: ASbGncs5Jkhdn1821xH7RRfoqRDemQ8KrKJzMJFQ+T6enUU6aAHU/p66PN9w7cUUjPC
 +MMhety1v6bKt1/IfS1kfrSRTQUZGH9mj65LhO1i+QTZmmMCOCf3G6yPPDqqcw2/T2T6xQFP2CM
 5aVf9smkWg5HX023VJWFt4V5aGeB49r0xFFDcTutlvonwCvxwkDNg36EP4D8UKl/Enog4EepwRJ
 z19kLFqPPFytSWVmYtarqovGRUShjAFI5QtiaO/ZqTo2Jg3AyBZtFEQjFsU8w5LwqMqwqpgVM1E
 Q8+JWnDmVOYHdhN26WA6CAPGHx6uAY1e+atlsKm/rTGykkn+CANUSHIVtwN4bGmeY40MTUkRj8v
 u1V6AwSe8poUjVzfgSZwRkuVDdCivawgkRzBpjT8YDznWdBR1BMCMJOb/1n77Hdw2gcKwddhbiO
 /3HnoVP6+R97pi2NBKzeYDZjuxm+ipZADwIb4K9wDtn5qt0Twj/fF9
X-Google-Smtp-Source: AGHT+IHc057sc4qZTJWZEFNrt6wOdfwNnATEsRgiWqvVVLtA3m8eF1Qx3I63nwzyxQVE8Gya4jDAnQ==
X-Received: by 2002:a05:600c:46d0:b0:477:5c45:8100 with SMTP id
 5b1f17b1804b1-4792f39510fmr79908265e9.24.1764954009860; 
 Fri, 05 Dec 2025 09:00:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792afae44dsm74914105e9.0.2025.12.05.09.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 09:00:09 -0800 (PST)
Date: Fri, 5 Dec 2025 09:00:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [RFC v2 02/14] test: avoid long hash names
Message-ID: <20251205090003.5101a52b@phoenix.local>
In-Reply-To: <aTKX8x0W3mU6BsC-@bricha3-mobl1.ger.corp.intel.com>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205022948.327743-3-stephen@networkplumber.org>
 <aTKX8x0W3mU6BsC-@bricha3-mobl1.ger.corp.intel.com>
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

On Fri, 5 Dec 2025 08:29:39 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Thu, Dec 04, 2025 at 06:28:11PM -0800, Stephen Hemminger wrote:
> > The test was using hash table names which were too long and
> > would break if the hash library was checking the parameters.
> > 
> > Fixes: af75078fece3 ("first public release")
> > Fixes: 9c7d8eed1a45 ("test/hash: add RCU tests")
> > Fixes: 567bb951716f ("hash: reclaim RCU defer queue")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  app/test/test_hash.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> > 
> > diff --git a/app/test/test_hash.c b/app/test/test_hash.c
> > index 5791fd7f4c..8cecc28d11 100644
> > --- a/app/test/test_hash.c
> > +++ b/app/test/test_hash.c
> > @@ -1399,8 +1399,16 @@ static int test_hash_creation_with_bad_parameters(void)
> >  		return -1;
> >  	}
> >  
> > -	memcpy(&params, &ut_params, sizeof(params));
> > -	params.name = "creation_with_bad_parameters_0";
> > +	params = ut_params;
> > +	params.name = "really_long_name_of_22";
> > +	handle = rte_hash_create(&params);
> > +	if (handle != NULL) {
> > +		rte_hash_free(handle);
> > +		printf("Impossible creating hash successfully with excessively long name\n");
> > +		return -1;
> > +	}
> > +  
> 
> I'm not sure about this behaviour, for something like the hash name. I'd
> tend more towards having the hash library just truncate the name rather
> than returning an error if it was too long.
> 
> Also, I worry that this could break end-applications which were relying on
> previous behaviour of ignoring long names.
> 
> What do you/others think?

Truncating the name could create issues where two hashes end up sharing a ring
underneath.

