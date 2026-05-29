Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2F7CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 22:59:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B38440264;
	Sat, 30 May 2026 00:59:01 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 4697540262
 for <dev@dpdk.org>; Sat, 30 May 2026 00:58:59 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1353c2f35cfso8424484c88.1
 for <dev@dpdk.org>; Fri, 29 May 2026 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780095538;
 x=1780700338; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9n52B8eTsD9FeOqM+lvMJ2qWQFomvToFwIdg3iHoqo=;
 b=d13da0xtfeIldnGweDDaURig8oYqbUcGFqwMQGl3gFeCuSElASkZfh4Wg/OwoSJGM2
 wdnUkvezG+XWyOvWp7BIV4Pps+BQmpzHo+PP9KWKB3mm96bem+JNwAGexpOB1MR073rn
 IOa9ng98yRiIaNYx2v7m+hgLAfZ3zQSPAv5ukd4St8Qc98Ymuw1tisKtu2Do9dIghW1t
 bhaa0Hnjj63noQSLQ3o6KR0KpnFVddbApVNtKh4E/nrDeQ54nsC7Ns34SIBD1R7HylSf
 RD+/ZTNBOLEHU9e3Jyj3e8CHtl51qIe2NOrcnUaowtIISYo6yCmDOiXSAKJy7jQdx2Ug
 87Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780095538; x=1780700338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o9n52B8eTsD9FeOqM+lvMJ2qWQFomvToFwIdg3iHoqo=;
 b=Zvuyd3hxML0u20VE7eam0JwbjtCjHIHi23ea9c/OVp247jVxYNDSlDlHGKTV6OQBdh
 vKdvIgXAtKQF0ijUelrWlMh0esWZkqJjL/pzrDnzUCj+IWixx+uve3671xyzOpnI6fvY
 8QeEl3o/qXii9eJv/mTZtrfLBmhhgbZL+2p3az+w+Mcq6vO9P3eZKD+aLB9vKGG+yzfn
 QydKw6YlwK5WmFpDi08FpSy70mgljFratL0O9pjBMdJEAb7ORZEc8YHEFsFNJnNnQiBX
 EWV7UExEd+MYI99OJ74FYxkjHhjXGZ+wREhdJStUi5tocH2r+dmBYq0UcfMBm5CkVF6U
 ctlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VEeOsFF3I35pwnGRVbeo9KrSNEQ/voVmLejXfok32iiA7JVhdGc40r/yKMs+MO5y3VK8=@dpdk.org
X-Gm-Message-State: AOJu0Yzm5EYu9nTH2rcY8DnCKyA1U/vlAdmQOrdKsCBsVNOT1zZl4wk6
 G4zIfmf092OZaOOFS36xfjAa/wPuBavWVKPyrnth89SsDuFlzbVyEUkRIMwZAvw0ocM=
X-Gm-Gg: Acq92OHfB1WodEajV4Gx9g8Mci/tt2UXEKQUi+l2C4rTNnMGazkbSYkvVQFQ+47xwyl
 K2g6fFpxZC5oKkigEiE8Xtx+Iz8eDy3lOx1l5aISs3a5zJObcVNI6rbzaraGWPtlC9oyCUHu/iq
 4h6k/uWnlBH0GfbjVCoFr8Ct+7jYzubPpKOAlhUoDjPyirmeS5OnSkCTBOH6/Sa8Yjq/IGooUim
 OOr/Dz1/EfPydnwjnWKgL79gqNnXrJkUZuRWSDOqoq13pJ4EMVtB0gVPn79d+2jYi9ZTBz8sLZS
 kn47VpKhQeGDL0z4ELwxwQmcHywRge7P9bPWN0PVMpJ+wNAEQlc0Qyz21+F+IeRPZvxXLny7dBl
 1r307qHmH6umN757gy0mZTXo1QMspEsQU9T3rzsZMWMWQaC9dyRzqPk7LS0lN7te0PAT3pXGgGH
 BDBFOXorPxZ+q8M0hs7gracX4h0TzxJK7rpfjFbq6BOB2y086fKSuHx1h8taOaIh4Q1pA3GjyFp
 WU=
X-Received: by 2002:a05:7022:126:b0:12d:cbce:5fb7 with SMTP id
 a92af1059eb24-137d3c10aedmr722786c88.6.1780095538122; 
 Fri, 29 May 2026 15:58:58 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b35a5f44sm1962609c88.1.2026.05.29.15.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:58:57 -0700 (PDT)
Date: Fri, 29 May 2026 15:58:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] app/test: use memcpy in ipsec test
Message-ID: <20260529155855.66c0f3dc@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F658B7@smartserver.smartshare.dk>
References: <20260529154651.128372-1-stephen@networkplumber.org>
 <cd2886ccd3134ab0a712e739bad4da5e@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F658B7@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 29 May 2026 22:45:00 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> If you are curious too...
> Does the compiler still get confused about AVX rte_memcpy (without this p=
atch), if applying the rte_memcpy patch?
> https://patchwork.dpdk.org/project/dpdk/patch/20260521185631.116046-1-mb@=
smartsharesystems.com/

No still fails.

This is if __rte_always_inline is defined as just inline as an experiment.
Compiler gets confused in virtio_net because of matching conditions doing
initialization in virtio_net.

Also, has issue with rte_memcpy.

ninja: Entering directory `build'
[2352/3763] Compiling C object lib/librte_vhost.a.p/vhost_virtio_net.c.o
../lib/vhost/virtio_net.c: In function =E2=80=98desc_to_mbuf=E2=80=99:
../lib/vhost/virtio_net.c:3025:34: warning: =E2=80=98pkts_info=E2=80=99 may=
 be used uninitialized [-Wmaybe-uninitialized]
 3025 |                         pkts_info[slot_idx].nethdr =3D *hdr;
      |                                  ^
../lib/vhost/virtio_net.c:2915:37: note: =E2=80=98pkts_info=E2=80=99 was de=
clared here
 2915 |         struct async_inflight_info *pkts_info;
      |                                     ^~~~~~~~~
[3487/3763] Compiling C object app/dpdk-test.p/test_test_ipsec.c.o
In file included from /usr/lib/gcc/x86_64-linux-gnu/15/include/immintrin.h:=
43,
                 from ../lib/eal/x86/include/rte_rtm.h:8,
                 from ../lib/eal/x86/include/rte_spinlock.h:9,
                 from ../lib/mempool/rte_mempool.h:44,
                 from ../lib/mbuf/rte_mbuf.h:39,
                 from ../app/test/test_ipsec.c:11:
In function =E2=80=98_mm256_loadu_si256=E2=80=99,
    inlined from =E2=80=98rte_mov32=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:119:9,
    inlined from =E2=80=98rte_mov64=E2=80=99 at ../lib/eal/x86/include/rte_=
memcpy.h:158:2,
    inlined from =E2=80=98rte_mov128=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:170:2,
    inlined from =E2=80=98rte_memcpy_generic_more_than_64=E2=80=99 at ../li=
b/eal/x86/include/rte_memcpy.h:389:4,
    inlined from =E2=80=98rte_memcpy=E2=80=99 at ../lib/eal/x86/include/rte=
_memcpy.h:715:10,
    inlined from =E2=80=98setup_test_string_tunneled.constprop=E2=80=99 at =
../app/test/test_ipsec.c:615:3:
/usr/lib/gcc/x86_64-linux-gnu/15/include/avxintrin.h:873:10: warning: array=
 subscript =E2=80=98__m256i_u[3]=E2=80=99 is partly outside array bounds of=
 =E2=80=98const char[108]=E2=80=99 [-Warray-bounds=3D]
  873 |   return *__P;
      |          ^~~~
../app/test/test_ipsec.c: In function =E2=80=98setup_test_string_tunneled.c=
onstprop=E2=80=99:
../app/test/test_ipsec.c:527:12: note: at offset 96 into object =E2=80=98nu=
ll_plain_data=E2=80=99 of size 108
  527 | const char null_plain_data[] =3D
      |            ^~~~~~~~~~~~~~~
[3763/3763] Linking target app/dpdk-test
