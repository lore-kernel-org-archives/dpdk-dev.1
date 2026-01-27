Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF38D2F033
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 14:13:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84BB840E0C;
	Tue, 27 Jan 2026 15:13:25 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 3AF5740297
 for <dev@dpdk.org>; Tue, 27 Jan 2026 15:09:54 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48069a48629so7053825e9.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 06:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769522994;
 x=1770127794; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koPh2GOX7m0UWgetMo/CTBAkC48tieE+WLiR+wsRRiA=;
 b=q3/K+cFJFtjFR5zWT5ZR0Ap8zLFXxDyFo+FdnsLqBFSZn7isNHRHRdVyavLH9qnOFB
 EaYaVPUQ0zOrh9wQpl085m4wi0GUkvZ7ATr0WKxN0gARfx+v0FaOaFjdQzr2oKswabjr
 kDGzeXHfeZc6sQ+/JEoU7NY5081Sri2S6qEP8M3av06hCslaKnNLcm+c9dZ8QmNrHnsR
 OQJhI/Jjamrw9uRa2ZpFmsgE+bkeP6G4QtJHbSzjYdQCnkzDJHZf6tFvcmVcTvFTOM2n
 TwKsGn+BAphBKB+rVMGuFXqD8Q1znQwJcWxQQl5sIZWBGTvUbMx3hnuqLRPu7Yr86rhj
 FYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769522994; x=1770127794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=koPh2GOX7m0UWgetMo/CTBAkC48tieE+WLiR+wsRRiA=;
 b=CvTeE9TnUZhIXScBnOSGPtaIGSnZYWoe4Z/NVcbHis67AMOgyYjqchoKoZRRQI2Mnh
 YJDRULpMqjKVsbArwkqmBrCwNznPswNox7nLSMo60J3e9Dh5UywQex8ZKJjdVE9M7xUd
 Jr5ZvTy4XLuxUiUZe6sqm+Jykx42YXjB36IFMYyMSFKL1G+j3nrqWgRU8bX4lJWwT1fx
 ZVi2AYIz2F4DfWTFCkH4eolXOvcZ83lkOCzMnAyA4HmbrDma8XCUKvjkNdeoa0Gyb+90
 fYNpM8/ydhQ9rm5HSVXa66pyWLn5daCy0idG9V0Quh17X4cKPiW8SO1zQoUSYQkWfVt6
 3GVw==
X-Gm-Message-State: AOJu0Yzdva3KicbB+a4dVg2lyjzl+S2EwGsvab9XzOC4cmSMW4mpwkQu
 rWh0mvbRT3fjvMy+zzSxWtFxje7ZKQs0fEU7LpLz3BWvu7qJPthJ8qquA+tXi8E+AgvlKP2xOo1
 GoncS
X-Gm-Gg: AZuq6aLJBte+Lw3x3luds5967wjhrfUztYLEdEh69agyIa0MQKHPG5n181jt6JhmeUQ
 FuiTEsT71NNzdooI9wCn+hUwMY7eD92kG1nj2ORJHeIA6PPRqAaVMvrrsd4TR/L19JZef7K/Kmd
 OjmDFcf/a+Zv6s0hbqTsMF+L5dnR1mmCtLtS7PSpLtFNjfe6B5u38m/HZ41gRhvjgGBXhNhnN+D
 ojOUExIn0GhuJlvF24M+T0+a8O+Y+XYsU4XCKwiSa7+Mq+qWaG3B4P03WDz7r7njDp91zp1vKWz
 qhMcS9lqSxogjqjhQKzM4TGX1kZYaqGraC4Gcduw+tcuptVNNZlJCVDtXUdd2HLEmwmqCoQRA9N
 /rYLL7DvCwqaGL+NJixPbXMe3U6CD8djHCxcemaTBds/iW0yVAgWrYGTs33rzNOqSW6IPhIuhx9
 71+8JJPV/K2Rjl0y/CkKaCt3X6MHJcqGxwwTnK4aB1S3glRbTy/nlx
X-Received: by 2002:a05:600c:3105:b0:480:3a72:5238 with SMTP id
 5b1f17b1804b1-48069c6098bmr26616275e9.30.1769522993708; 
 Tue, 27 Jan 2026 06:09:53 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb59asm58757545e9.7.2026.01.27.06.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 06:09:53 -0800 (PST)
Date: Tue, 27 Jan 2026 06:09:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Martin Spinler <spinler@cesnet.cz>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 2/8] net/nfb: create one ethdev per ethernet port
Message-ID: <20260127060946.24479835@phoenix.local>
In-Reply-To: <c290d24b4985d46730bc4f45919128193bb91bc2.camel@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260123172224.1567362-1-spinler@cesnet.cz>
 <20260123172224.1567362-3-spinler@cesnet.cz>
 <20260126163710.5bf8a275@phoenix.local>
 <c290d24b4985d46730bc4f45919128193bb91bc2.camel@cesnet.cz>
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

On Tue, 27 Jan 2026 09:12:21 +0100
Martin Spinler <spinler@cesnet.cz> wrote:

> On Mon, 2026-01-26 at 16:37 -0800, Stephen Hemminger wrote:
> > > +TAILQ_HEAD(nfb_pmd_internals_head, pmd_internals);  
> > 
> > You should put static in front of TAILQ_HEAD so that the head is not
> > global if you don't need it to be.
> >   
> > > +static struct nfb_pmd_internals_head nfb_eth_dev_list =
> > > +	TAILQ_HEAD_INITIALIZER(nfb_eth_dev_list);
> > > +  
> 
> I don't understand this. The static is already in front of the
> nfb_eth_dev_list global variable.
> 
> 
> The TAILQ_HEAD() just defines a struct (not a variable), which is
> visible just in the one .c file.
> 
> When I use static, as you suggest (or as I think you suggest):
> static TAILQ_HEAD(nfb_pmd_internals_head, pmd_internals);
> $ ninja
> [2/30] Compiling C object ... net_nfb_nfb_ethdev.c.o
> ...nfb_ethdev.c:49:1: warning: useless storage class specifier in empty
> declaration

Your right, I just saw that in other drivers.
