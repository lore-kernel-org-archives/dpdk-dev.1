Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3A2CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 16:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F77D4026A;
	Fri, 15 Aug 2025 18:03:23 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 3EE5E400EF
 for <dev@dpdk.org>; Fri, 15 Aug 2025 18:03:22 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3b9edf36838so1345513f8f.3
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755273802;
 x=1755878602; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfvnrCTql+St66LgOOS87i96WkIQsvv3FJbulFywIEM=;
 b=11tOkL1HgeqcHBedZT4U/Er8pFwCC7qr6K7li9mn58gwWLvOOYTrvlwxh4j2t5pdKv
 RRct/4vr2E/7kLM/Hi4MIULL2APjE9A/XFq+jezr4zTwBBNhdjpJaQ4uSDmkbrvR2/VE
 zzOJfYG6XEHWCWIIa2XH3t1UoI7imWvAkRBoAG7v0v57qiga08GcDjMOw9ym48Ldp5Np
 ZX3Oz5heNi6bh8Fch08drSjxxFLNd6qcQjW5548JpQlBW+s8nf2u4rbC4BWVTtCZ8YYt
 b+cutR+uf4NhoJNUu7qR7gmDngVS3L/JmZ9e5Sj9HM3JlLcg43UkCVgqqCIwcyI6caYM
 657A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755273802; x=1755878602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfvnrCTql+St66LgOOS87i96WkIQsvv3FJbulFywIEM=;
 b=Vn/DMoPCpnRQy4DuC7E4ayevypkmiwpBUp8Q/Zc2gm/3Rgm1PJSRfuSExOoRpUi15j
 +/xIf9deas6ImPAQX1ZibNBZSTSfOloFFv8uGZS1FBOSYmfkUv9fzdhF5O5T44cKPv2j
 +eDJHgfk2c8fjglbkd+MFV/kkevl/vxO9YuacYMK+IRtUgMna3NL0OctwUDFF7mBmqjw
 TNznTNa2z2qv1ZK46ipA4L9L5cOp55TdKLGWlGCXYIcRG/bX7Q30GymghK+56PzdguCb
 NDN0Ht+54qRdLifbLdslDfG1lPasWK9R9NLoTtMgTSJIdne3FHE3/ora1xap1p5qjAIH
 Jcyg==
X-Gm-Message-State: AOJu0YyYwmpzEtS4YSVYd+Xetioa2ReJ81QUr7qsTBPFwnZGZ2AKq4KQ
 HnjlMGquTQbSdZYt3isVF4G4GS5o7CT6Kl8rigl80q7uoLD+UBWKV4BBypGpBAOcstI=
X-Gm-Gg: ASbGncsj9aqmXcisLhgDNW7Il+QJHLukxk68/VEDZvuNiEsWW8XU2M2qgO0O2lH0ubm
 liCQu80p08vhdRjaiv3tRC6e2v5hIgIayk12K6K7GF1FTtke+mLqFT8Wx5RKefKXdbhpNdb8V3B
 coADrPpUcjnEfmcgLO9IlVMyKvF2G5zFqRgBXA+XDvc0xWPH/j9E5tBPaK29pMXitVX/ktt4F36
 Ik5gqg7X0LraFRstzVnrUZ4iNAGKg7LNheahOUMzmDAEh8oTYXgw0CiLmwt/2RvxIEsBO142Gto
 icK/Po9jvxHBpOBJ91bAPI6t28RBoeNH9VeixFTj4E1KBbSBJAgpTyN3k6zlireVTgfo+YP7Kio
 J+d7KNhy8GrhlhTdRTVHooAGxPDvHvL52xoF6Qtpj854YaLcvgeWcnCmXPKsXYlIycj+PNQrdV4
 Q=
X-Google-Smtp-Source: AGHT+IF3QC5s0NBkiq9Pf9cd5+55nZDkpEAMRo6zrxud5ZcDQgOIBipRh0cARMUy6sqpDaprGMONeA==
X-Received: by 2002:a05:6000:1acf:b0:3b8:d15d:933e with SMTP id
 ffacd0b85a97d-3bb69699c4emr2399366f8f.56.1755273801671; 
 Fri, 15 Aug 2025 09:03:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb68079d3fsm2515120f8f.55.2025.08.15.09.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:03:21 -0700 (PDT)
Date: Fri, 15 Aug 2025 09:03:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] bpf: remove dependency on vla
Message-ID: <20250815090316.63b15b46@hermes.local>
In-Reply-To: <7c942773fe30436b888ff37db75880ee@huawei.com>
References: <20250803161617.36653-1-stephen@networkplumber.org>
 <7c942773fe30436b888ff37db75880ee@huawei.com>
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

On Fri, 15 Aug 2025 14:26:07 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > The code for ethdev callbacks was using variable length arrays
> > which is a feature not supported on MSVC and later C standards.
> > Replace with alloca().  
> 
> I am not a big fun of such mechanical replacement of vla with alloca()
> Specially in that particular case, we can have internal function that uses
> fixed size array and in public one just call it several times in a loop.
> Again, using VLA here is probably a real security breach,
> as we put some assumptions on size of input arrays provided by user,
> which we probably shouldn't.    
> 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

The other way to handle this is to break the loop into chunks.
But it ends up being more awkward to read, and more complex.
