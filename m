Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D7CDB470
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 20:58:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9B2C402A2;
	Tue, 23 Jun 2026 22:58:21 +0200 (CEST)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51]) by mails.dpdk.org (Postfix) with ESMTP id 1389540293
 for <dev@dpdk.org>; Tue, 23 Jun 2026 22:58:20 +0200 (CEST)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-662dc387b7aso320646d50.3
 for <dev@dpdk.org>; Tue, 23 Jun 2026 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782248300;
 x=1782853100; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtjzWNFJnq740xc+dmvS28PrT6iJAq8dUIxS6pgzpkA=;
 b=MgxiIDQsd7b2qn2urAYuqknGEM0FA00pGuEjs01wNVVLo/qs/9nWWLVSYfeFKbA/zU
 b9KxItmw0rzis6sAkbKmexAt2WH3bLeFk7sD5AvbOXSYGfyRQ5aDjBaCicM5Yt6bs3wL
 4iV6cHmQDyVZE0YtAbSml3jgClpDI9mPnf3bwfhkfms9sMPb7V0HefcNp0To6HtbyLse
 HtZ5e2OfJgI9TkDTVrzsyphW7QWj91W+1BHn+vxtT4sfN95ReU6GkYQRvIRZDv5vKr4z
 SaSH+ytJL1WX4r32iEOKG/MKMtofS5ViTeO/TGkHdTwq1t0m7TLjI+s4TcjDFuO3bgBF
 kUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782248300; x=1782853100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DtjzWNFJnq740xc+dmvS28PrT6iJAq8dUIxS6pgzpkA=;
 b=JGYgN56ircr4uYSmwrTAxvVS2Ys0rN3IMN8tHikLmFyGdhHGklDeCQKGuxDsUUmB+q
 ljLSzNLaBi3VxJsli1hi/lVzi4rX5/fycgGtHgLFGymkFNRP776kE1cjNzxodBFOA4xS
 pWtnMmiZGB3DK0dYs8ln809zQtqdLIvT1KlhYMDtprizrkkfnKwhjroSviU4oR1Eb/GG
 KGFSqrx+OhhA8S5mgkcKy4wumpusiOhAt1Z8v9aAnScVG2rd5xBDZ1r5gZ5BbF+4Bbd9
 jeDsPDtu+j3OdG1IqYuQ0gKVeVFRc+/Q4qn7j7all5iITkbmvL2eecbKQEsHKJAwUrNU
 yv0Q==
X-Gm-Message-State: AOJu0YwkM8Zky4IqPzXzN2waL+QLsf07XzVw3bNCg1ouX9Yf2vPLukK9
 CX3Vs9P16P7ShCuUjefkOadJ2jEur+E+qevuJEOyE7GeO0Qoois9fJNBe/zrtp0Cmxg=
X-Gm-Gg: AfdE7cnk5Vyore1fr07m4bnAod+q7As32PXfJFUVrSPdOWaCR2CLGMuElsNnb/buCej
 Ogo+e1O1IozwXRh1BY0xoUAfUZiQvG6Vkv6jQihuRtwiuFxzywK5yhuQT/Mm4MnrYoay6ablmym
 pTr4Kvwb5wc/pjkLXfTOdcQV7N1bO68+LsUziCQ4FE/oZz9u9EV4jFLQrlKt7SLLlnYcRqrQwmg
 LbIhO6uYv18qfa006lCpsOxUQyTzE0gd3ENcY8ttmN2g005YwNQxfzYxJ4Vd+9QyUgegAQ0K6Ve
 AfgasbOhI+ANIU+EPLk/v5YD715cYzgo6HbqxB54R9xEWvDat8oKoR1XyXRRml2L2o8JIvKNN4G
 6rGQZTViWXCTmIGf3KuRPwea5Lh5KdLp6ydI8MFY37eYXeCKO1zSXbCldpY5qkuhFNdhKFQgCAc
 YAfcuRKL3N7PdtG3lANzNNMimpOnd/JTL+PqEtv3Xy6iaGnw9VEqMQvA==
X-Received: by 2002:a05:690e:169a:b0:662:e0b5:340 with SMTP id
 956f58d0204a3-6636e46e619mr527170d50.19.1782248300261; 
 Tue, 23 Jun 2026 13:58:20 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66314d444c7sm5731192d50.13.2026.06.23.13.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 13:58:20 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:58:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3 6/6] test/bpf: check that bpf_convert can be JIT'd
Message-ID: <20260623135817.2246dfed@phoenix.local>
In-Reply-To: <c510bf24a3cd492693fc54f0b558656f@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260621162524.82690-1-stephen@networkplumber.org>
 <20260621162524.82690-7-stephen@networkplumber.org>
 <c510bf24a3cd492693fc54f0b558656f@huawei.com>
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

On Tue, 23 Jun 2026 13:57:35 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > +	{
> > +		struct rte_bpf_jit jit;
> > +
> > +		rte_bpf_get_jit(bpf, &jit);  
> 
> Out of abundance of caution I would also prefill jit with zeroes and check the
> return code here.

Makes sense, but the test already was just doing same thing elsewhere:

static int
run_test(const struct bpf_test *tst)
{
	int32_t ret, rv;
...
	bpf = rte_bpf_load(&tst->prm);
...
	/* repeat the same test with jit, when possible */
	rte_bpf_get_jit(bpf, &jit);
	if (jit.func != NULL) {
