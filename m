Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7643CA5FDD
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 16:00:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B57654028D;
	Sat,  3 Oct 2026 18:00:27 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id E60C44028C
 for <dev@dpdk.org>; Sat,  3 Oct 2026 18:00:25 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2e30b9f1441so5810415ad.3
 for <dev@dpdk.org>; Sat, 03 Oct 2026 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791043224;
 x=1791648024; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2g7vx1EOfw2TEEkxbVrrdpJ/Pt1Hi6B0vZMLyrqCW/4=;
 b=S+IsBKJy0+6ZutQ9lXvnEkXposZl6i+Q4/MXoEjO31kdw1XNGtJFVf78BEmZN8C24W
 iFXch+k/EMKubF+uM9GQwFRErgMJdkWthpoph5dmNUH841+U68ijNX6IaEBvNbTlF6Wj
 b2KYMfGnJQGd9PCH7gDTZUooGup3tXeXXrk4g83TTP0yBC6tLX3/PRr24TsuOrWBtGsm
 xEy3zEsy1Md3mnkjUFDY41JoU01k59+OP2ovOprxw+57BVj7DJVE3J7ihMyZJZ2fk2p1
 6bGf49d2yfFbs2Q2cC73pLm3TXlKTBblBz4CxouGOzqw+NeDHPwSnRzNVoKQJ7HmNI9F
 leIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791043224; x=1791648024;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2g7vx1EOfw2TEEkxbVrrdpJ/Pt1Hi6B0vZMLyrqCW/4=;
 b=T6Kv/GrjQeO7clIZe60pFBdTuS9ru2P8Q85wP7w+Hvum7H8ZjxbchhpZVYmCNtsL8j
 +iTUIOaRGyLiOLU+yowV6mynDFuOMuAh04U/VJDHDtxe0FYYsvMS16drKR/HHHpjV++z
 Z0+fBDTv582+L25oF48SAkFwIfMfXrb96b/lXzRKr6j6aLGlcdM+GxsN/9xp+CRQa5pl
 EXBR2McIWSojXJRPs8TsK/u4v/oWLAqHvOBig/Isx1OYAhB2Ke0geH/5x0mhLlcqpk+d
 /U9ageMqfFn13x91m0b1/qIx5nTuN5VrSZWFKj8aUrtAgS3svYQy0OpjFOq6bQdZpJtq
 L61g==
X-Gm-Message-State: AFq9FYIy7dW/w2ppNVpVDf265Z2IcEBBqBBCnd4zXdacpmdJOJjS//as
 5VFuczK2j4HnwPDTN+OS77HPmP794O1TiTWhSx/WRi/zQ7V8rsK3nBU4wCieNwLGDZg=
X-Gm-Gg: AYBFou0d/fTqOoqSq1Zgns72L4k4ylLLjhZeYoX733ZYZIp3o7Fx/O5dhwmmL2V7g0a
 r13Hq29Au1bUlWLZXVcmN+UGFiK9aZybnnRWJ+x+0ORSpkGKcKSZ+Hkhdd4WX4XjcbhJY3+BjeY
 j4Q8bbXs4e8hng98oF4TMNEXEsV37OiMKjB40O05OjxqAymfrQJTmuLdmhroFi2z7rZPgEg5VGx
 n+UdRPf1Mwkk1jBZHi0jD+CS69NyVa4EgXEb4jhLKqhrJCnfJA6nm5GUbHbYqveb46LqWL3egRQ
 q88MXNyhzIAug4NlAbUBdK/A9Xx5HTXR6TZ81XOHqtjrtEQjzXp13IiXXbymhBGz+PJjd21c6St
 MZCehAit7J6JjlopcmCslcztAsmEuRctDbQqS0MVPFgnvj9ozr4bceWRtZ+fAZde8QSNGCO4nMj
 C7pZv8uAUPkwZzEgW030GR3PwJ8SnC2fktDuZFKLiLWvMEvoqv5nN7X/iugOstInztyoiUwkBLX
 dyYl6rhmAcJ+adQPp1bHppQSkKx6zCABtedkThKqDVJmysp//Q=
X-Received: by 2002:a17:903:388e:b0:2e3:ca8:7860 with SMTP id
 d9443c01a7336-2e510561d89mr29097385ad.22.1791043223417; 
 Sat, 03 Oct 2026 09:00:23 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6811cfsm17693825ad.24.2026.10.03.09.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 09:00:22 -0700 (PDT)
Date: Sat, 3 Oct 2026 09:00:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] test: remove unneeded null check before free
Message-ID: <20261003090020.457f2b1d@phoenix.local>
In-Reply-To: <0ac0e7cc-f75a-4f97-a333-070532da1969@gmail.com>
References: <20261002171707.928034-1-stephen@networkplumber.org>
 <0ac0e7cc-f75a-4f97-a333-070532da1969@gmail.com>
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

On Sat, 3 Oct 2026 08:25:40 +0100
Marat Khalili <qm2k21@gmail.com> wrote:

> On 02/10/2026 18:17, Stephen Hemminger wrote:
> > Found by devtools/null_free.cocci.  
> 
> nit: should the commit message quote specific coccinelle output being 
> fixed?


Coccinelle does edit in place on tree.
  ./devtools/cocci.sh ./devtools/cocci/null_free.cocci
