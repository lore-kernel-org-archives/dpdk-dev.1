Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13F8CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1FA740272;
	Wed, 14 Oct 2026 00:05:16 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4398940269
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:05:15 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cd5e2d696e0so215246a12.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791929114;
 x=1792533914; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q6qny09YPBA/fR/YCr0DM30HAPrhQYDPpmn++54lxOk=;
 b=A4DQRFVCIHHM496MkPBKOsi6TUDKl8DauMyHan+IwPjwwzLRqd8ma7ayDuE6BsHTPE
 JKeJVgTDTLxyPFW6LzN6sF7O+7PaglYmNrftHeFQsc5g0xXfeiffiDZ4XQCkje1dvSLr
 BhyMeP1Dv97G5bwtMtd53PLZDLQ82aabdv+3IU0uMVpB+GXuqr8z5V2SOs0YvmDnYMNp
 dZhpLTE4nj1SvzTRbDSPuY7xxObhwFw58SF/VUq06QTwI6wUzLUjS2lGP8Av/1qhoAWY
 BZC0+1GX7CpQDJ/qwoH45YxvM3zROlAS0ATqyRz7Ib2PlMgzyKfGUSmfq/n9hb8jBV+J
 Hi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791929114; x=1792533914;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q6qny09YPBA/fR/YCr0DM30HAPrhQYDPpmn++54lxOk=;
 b=ugSGaBIHAptnZo9NxjQkZBOKS1Ye/IxOcbzwCtnSbXf4n87eNFE1fczpezhnDjRw7f
 jOlc8BO6zwsdz5AfxERQWNhmBxdKt3ExlxRlDyfNWGwcH0GykNKYIyQw4JvEp3hWc+rh
 utSDPxQ84WWH47eU3rwA6etMycQidHdZKBXh6Oe0BA6SLKvttA0fgFambViz9kSQz3jL
 aPwx5nOApDMnmDChhgyyFv6+YMGslnGGk4/7FrrNjwjb7MihGcofQabET6ZYUi97p7f4
 KLhJwdrxV8r0F9QfFByhwYHzZqw5BHYYjx+kk0sUWMPzWtHpO8ZJOi1Ajx6xdbODg4Pm
 RM8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBztJ2YZ3TSWUk4iCgCbiwMDFzgdMXGgLP3hRY27XUKbjAlkplXcegPEZz1OUIjLCihtLbU=@dpdk.org
X-Gm-Message-State: AFq9FYI/MLOnuQUhhYxtwRVUcsiZZxuMcWvsuK65tramt89UlBiXmYFc
 k9akpacpT+TjJRJIA0WqSR6D041yIMKon4JAxza5/DR1fHWiA4NpvRttMw3bCwVTlZw=
X-Gm-Gg: AYBFou0Mv32tQ8HjcKD5phdZ+nXQZLi+ew9HxovHKpJepTzE1KOZbk0AyHk7kBbIJiY
 MkL9DghG3RQFq5s128PMFY4knIgLgg3Dq9mKLMUnmsoxYjK3jzVVKHEG7XizMZTJn0ueG4kTMwi
 dsEvZt01wOaqQxh5leVCbwbavLBTl8TTazWc23XplFg6KeUxnnS0Oqz3Yk8kHrKsMDJOCQOdIQA
 p3wLOJKwaecoXGKh3tOe+qU1Ie5TOM0iq25VsvyjzNWPTUUrKNUoCyBePrbAS95EY/CfBCj+3VX
 Iv7uRgrfabVeOBbcTPcvJbVcqZWo2YmjyQFrL2dugXG99CHGW0dFBqFseciCK1Wi60w8ps8Wmdn
 O5LoE9Q2/WvA1GnQ3EoYBakR0f2Md8SUnESp+maluca3Z8RzykSt4S2VUhK5Z6lKm3Wf7BdGBj6
 QoJTKcqKrcva1kN6ZYDV/YwtMP7hg8n0lrvpZuedH09qPUwNqhcX+SKWjwFFis8Yq8iHOyqLP2X
 SAADxJE7ylk0ziPpc48qeR7nW7E0wdyeKvcfLRz
X-Received: by 2002:a17:90b:2d08:b0:3a4:7730:33dd with SMTP id
 98e67ed59e1d1-3ab3ae36b1emr12376620a91.58.1791929114216; 
 Tue, 13 Oct 2026 15:05:14 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac63279277sm420776a91.1.2026.10.13.15.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:05:13 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:05:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: David Marchand <david.marchand@redhat.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, dev@dpdk.org, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3 01/29] bpf: replace deprecated SMP barriers with C11
 fences
Message-ID: <20261013150511.77743049@phoenix.local>
In-Reply-To: <55863f64-e5c6-4661-a6af-4f06c484e9aa@gmail.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-2-stephen@networkplumber.org>
 <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
 <6888e84c-e250-4ed9-ad70-46178014eb15@gmail.com>
 <CAJFAV8zWR0PPrSNzwMyP=2wFFTpjCq4dWFs9X0HSjkCNXVF2mg@mail.gmail.com>
 <31fc3286-242e-4104-9247-330a3d1ce217@gmail.com>
 <20261013093140.6b763438@phoenix.local>
 <55863f64-e5c6-4661-a6af-4f06c484e9aa@gmail.com>
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

On Tue, 13 Oct 2026 22:11:21 +0100
Marat Khalili <qm2k21@gmail.com> wrote:

> > I am not a language lawyer, but what I read is that C11 atomic fence
> > is defined to only guarantee ordering of atomic objects. Since the use
> > counter is not atomic in the original code, the replacement with
> > rte_atomic_thread_fence() is not the same as original asm.
> >
> > My patch made these atomic and that is why.
> >
> > Should have no impact in datapath.
> >
> > I will respin with better human oriented comments, I have developed
> > a distaste for AI prose. Reads like a lawyer wrote it.  
> Just a small clarification: `use` is currently declared as atomic in 
> main, so all simple reads and writes to it are seq_cst atomic (and 
> simple increment is a pair of two seq_cst atomic operations).

Right and non-atomic access to a variable declared as type _Atomic
is not allowed by standard and several compilers complain about it.

