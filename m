Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEAAC43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:11:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B93B40264;
	Tue,  7 Jul 2026 18:11:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 595D54025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:11:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783440659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=re6VS5wItWQeHdUUPElnH/XXeyqTBc1zT33wMvhWCo4=;
 b=MjUHPE2DcDiP4MMdTiIjnr12RxwpMulEIwvNBI3RqgWLwU1sJJqIpiQiwg6tkd7IbBd/k9
 LO2f4iuUJ+6vmJ+DLMBGyTAzcAy8El2Wkn9dpQ82RKsfQZV3mzuN6+64anRxkVJ+7cfU6C
 M7+j17bzUPe0FhPgLeIIImvUMPtcTUY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-WNlaleICPQ2Jud87jGEyYQ-1; Tue, 07 Jul 2026 12:10:58 -0400
X-MC-Unique: WNlaleICPQ2Jud87jGEyYQ-1
X-Mimecast-MFC-AGG-ID: WNlaleICPQ2Jud87jGEyYQ_1783440657
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39987ae63b5so19149361fa.3
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783440657; x=1784045457;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=re6VS5wItWQeHdUUPElnH/XXeyqTBc1zT33wMvhWCo4=;
 b=Phu2xXXvhDlo5O/OSqtj+qNY3whFXB6W6yiD43R/KzjdfgggHTxI57YSS1deSob7HR
 Hf/yIf++Nu/lYUBhe1oGerIbZMX4OU9PzoIg9U02NZMWBfMQO9mxiPQdDZVtSFInILI5
 cmtjKMTMaqheTkORFtQEDVpIB484x9IZC+UeLKTtJnhFV6hVPwSQy+pQLKwZTeAI8kmM
 Sr9uraNJJZ3DbcGySYJZ2RiI98neDqXwj5sdMr+fPFWaKA3SD7gwY5++K0XHgP2v51xI
 +CsvdRI5p7sKnEYTDqcaTo1Q04MY6Rb2Mqp3jdqXdZd24OynfkXJbb+G66B2HtgOuu26
 mpSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeMCg1BSEwx+aNdoox3Ak0hp56KQT+wD9b/0oLpJ8GnMhQETGJok6QUVb9b5bxxlJ+2dM=@dpdk.org
X-Gm-Message-State: AOJu0Yzb5SAOBuJ6s0haDw6WbtPc8zrPqDav0a0JOrNyW/fM2RihPsge
 fbvOQslR1osAL5ogx8+Ib5gjLt7RriOfXbxMJm57N1Bji+XIW6pMRSa7ye1EwC0ISlsVSgZf5me
 iOmQadrIzI5g174zwaGoxrWdThw83YdExxPU9Z84qCrnyOV/404zyNOpoSeNO1O86KX9/OWIxDL
 gTvRHhiLEy9vlL9rSuRoI=
X-Gm-Gg: AfdE7ckHPIJ6RMskqVVyjiagBUuAWBj3UeCu0Bs5mnOMxXtGrMEsyvJfNEM9Fruk+1q
 4jqQG5SKKaRBNF8DDYJ6E47VrmmRZ45DhEMrwvGusgJqHZeKilkReYvDdmYNfPOR9e6kBEum2qG
 /sSRLY5txFsbmAPGXvbeFnbGovkCHzV3FeHJc0TE1NoeChGt4AgnUilNDEOs7FQgeH51dNijEvV
 QIyvS5Dqj826VLtxm6/qRvR5+NnSHj3+xkmcie0A3W882wqOVYkcWwFVTc=
X-Received: by 2002:a2e:a99d:0:b0:39a:fec6:efd0 with SMTP id
 38308e7fff4ca-39c5ffae1cfmr14096021fa.23.1783440657018; 
 Tue, 07 Jul 2026 09:10:57 -0700 (PDT)
X-Received: by 2002:a2e:a99d:0:b0:39a:fec6:efd0 with SMTP id
 38308e7fff4ca-39c5ffae1cfmr14095291fa.23.1783440652518; Tue, 07 Jul 2026
 09:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260703072721.18c5987a@phoenix.local>
 <CALuQH+UE2kJdfbny0qLSxB+izFSPTQJXVCwDNbUotrcQL4LYhw@mail.gmail.com>
In-Reply-To: <CALuQH+UE2kJdfbny0qLSxB+izFSPTQJXVCwDNbUotrcQL4LYhw@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 7 Jul 2026 18:10:38 +0200
X-Gm-Features: AVVi8CdRPmG_ks1bA2SYyyE6NDtXkCTNxCb3gMTzZBELHTvYacori-xfosyVAWw
Message-ID: <CAJFAV8wWC9VbkDT0tqk+EkZGfxJm1weiV5u=HwQhOk3sC2L4eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Stability fixes for GVE
To: Joshua Washington <joshwash@google.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s-2ktsIp5VkBHwA16uMkTQ2u5LjRI9uHM4pkZJRP_Nk_1783440657
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 7 Jul 2026 at 18:02, Joshua Washington <joshwash@google.com> wrote:
>
> >
> > Better but fails on 32 bit build during post-merge testing
> > DPDK 26.07.0-rc2
>
> Will fix in v3. Is there a way I can test 32-bit compile using
> test-meson-builds.sh? It doesn't seem to be covered there by default.
>

You'll need support in your toolchain, but this script does support
32-bit compilation.

On debian for example, you'll need (at least):
dpkg --add-architecture i386
apt install -y gcc-multilib g++-multilib libnuma-dev:i386

If you have a personal github account, it is also possible to try your
changes after enabling github actions in your dpdk fork.


-- 
David Marchand

