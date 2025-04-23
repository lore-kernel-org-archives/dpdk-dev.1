Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD38CC369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 17:30:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A708F40156;
	Wed, 23 Apr 2025 19:30:54 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 4FCA7400D5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 19:30:53 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-6f0ad744811so1170936d6.1
 for <dev@dpdk.org>; Wed, 23 Apr 2025 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745429452;
 x=1746034252; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHfrf/ZF0LEQhdz+/aT3DVOpJIUtCbH1IHN430yHBTI=;
 b=1fJ0bDF1xoffG832CW9NlWQfECole5VS86XzRUBi8jnczGYRnxFAvHLKWatljT+FyA
 YJQNEbj2CXCmtnFiwYJz2A4sJZNAl2sk1NE3rL5BEE0eb+PsHCxUrFP1gcyjXTM7fHIe
 HXejlWN1Yd2bQbFlsFPLMvZZ+I3UqUH7yakHIKKick0gHv+1SV2yaDzwRg4Kf7VICE3/
 TRvhtATirun7ChDHGvA8u0iH4F7RnFgjf+Wac6iXS/f2dsD7ofxqnMVeaefJH8n42lWP
 vVhor9KSnB/OLc2rrItZRpqJkEO9Dl1Oo3V1yR13t2Mhu7G78KuRSbgCu/Z6aaNrK72X
 aRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745429452; x=1746034252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHfrf/ZF0LEQhdz+/aT3DVOpJIUtCbH1IHN430yHBTI=;
 b=JFawb3jAmcerhK76HcdoAwVf0CYf1w9Rtre4ijzEOWKifRSmY2BhN8p2jYXsmbbY9r
 2PXFqn7KkqP4lQXPYsju6kQ6jYRys0DRPV1iJcOCn2n27ahU+NyyjNhhKAO39p9V02u+
 TBx+DzTLIU1yLDHGtR4EkktgWruYdDnxxfQ/TsKEF1+ZC90ENg7shd1sIeMn3e3lTb/Q
 dxXgpP8+ALSUewSldK6ghSMoKd1sB5Gm0nKMqk65a4VuVL/QOMnTYwfk3aWYk4QoO+py
 SNLNsWPP0T6p/7Y55vp7Du6QHF/aDxISPEX9pQ9lBqZwAnDRJhZspCmF0JtrGRNZ+wKU
 9o7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXloSc1GUTOMIGzJFSpVFUYjkvXv//lcF/k1uvbGtA6KJpRhVrWZA+sh9qGY9V/xq4qMgo=@dpdk.org
X-Gm-Message-State: AOJu0Yy/bHc0X3DKsZsJirHf/H0DNeNSO9uuZ8cH4PKDYzz/iKCbTqiv
 zcudGmTSCj9jlHgMIFPu/nsDLyfl9dTJ/UhvU96TrQj00siQFZp0ZWIUZNGlnMA=
X-Gm-Gg: ASbGncvlY3l6Dg7DiZEsICEbCQf4TgCU2hmDw6QCLbzkINcwQ2/jOQuP0TZloRA0HN9
 TUm3NstBp0/ELIoyZ/rbvt+TBsOwac4R9zhwc0qXkIM1ubLbJcT25tssmJ2K6Fm0uUPqTupaKTA
 l/N7dsT0xqSZPS3Y/U2Y4ibemAHhRP795Yq4dJiOqpMzJQT8ep+QeonJnk5d43y0xiSHFs2p7qp
 vjOeT7F4GOB9ZQa0KKBh2J6h4rPB2IDn66Qk5zkEGNHz1UXu+Fc+B1maO7iWkMrsaxoL5qjhP8H
 zk7oguc/szHB14j6+aE9i39Jdkv5kuQi3U05lrUhr9CnQe8sxDIIprA3mtiDUTag4DAx2nCq
X-Google-Smtp-Source: AGHT+IGqDqRkWrRIhbYhwzcokTRfZUSoSl0k9zPzZ49GEi7o83y103iwRYS3P+8BHEQGog00n/MIjQ==
X-Received: by 2002:a05:6214:2524:b0:6e8:98c0:e546 with SMTP id
 6a1803df08f44-6f2c4645125mr297781966d6.29.1745429452326; 
 Wed, 23 Apr 2025 10:30:52 -0700 (PDT)
Received: from fedora (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f2c2bfcfe9sm72809566d6.76.2025.04.23.10.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 10:30:52 -0700 (PDT)
Date: Wed, 23 Apr 2025 10:30:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <kirankumark@marvell.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>
Subject: Re: [PATCH] ethdev: support RSS based on RoCEv2 header
Message-ID: <20250423103042.09d0bd78@fedora>
In-Reply-To: <20250422051459.661395-1-kirankumark@marvell.com>
References: <20250422051459.661395-1-kirankumark@marvell.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
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

On Tue, 22 Apr 2025 10:44:59 +0530
<kirankumark@marvell.com> wrote:

> From: <kirankumark@marvell.com>
> To: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> CC: <dev@dpdk.org>, Kiran Kumar K <kirankumark@marvell.com>
> Subject: [PATCH] ethdev: support RSS based on RoCEv2 header
> Date: Tue, 22 Apr 2025 10:44:59 +0530
> X-Mailer: git-send-email 2.48.1
> 
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> On supporting hardware, RoCEv2 header can be used to
> perform RSS in the ingress path.
> 
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
> ---

Please make this patch part of a series with hardware support on some device.
Not going to add it unless at least one in tree PMD supports it.
Also, you need to add a release note for this, and include documentation for the 
device in question.
