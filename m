Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF87AC5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 15:25:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3660406B8;
	Tue, 11 Aug 2026 17:25:33 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id DC4454027F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 17:25:32 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso3195889a91.1
 for <dev@dpdk.org>; Tue, 11 Aug 2026 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786461932;
 x=1787066732; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mMLjd8YXaWpTh7PUHGkvt6tIq0dOvfcKP9/juEL11xE=;
 b=VWJtr0sGHqzjbdit/2ZSs19YMu1agPNK9twH5slI+0FkWE7o5Vp138A2gywYJmmcrT
 Vd8fF7mH/YF+Ity3QJfQrHxYybEd2eYp8dPIeMc/hF8IYbHW2Ic2xzCQr6EzaETkgP4D
 JjggcR0VsdB10OC035YOq/HY5IWssliz1F9cftpn0oiQjhCUBBFmz1wee6me/TnR9nGR
 saC7cLktbZl9Zh8Gd3RJdQSVQbGvfUQGCGSMV2VQOxaqu1zuhSJTXrygkrT6EzcTRyHW
 FtsBHz6kw25jqS8YvlABxfzMgMjRzH+Wvu4UPDZH4FT/kWvMtLcrHPQ30YoiY8pGC3KL
 hC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786461932; x=1787066732;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mMLjd8YXaWpTh7PUHGkvt6tIq0dOvfcKP9/juEL11xE=;
 b=Hu/gTN9kEwDXHVyhxcsNVLk+7asvSC15Fd99KZfS7LUiDngXyeeJLyFnuADD5ApiJ8
 yydB0GfL9naFNhoYloUKj8bfQ/fofB3w53TWuXvDA7PuNr4kxbQEqZoHfXv4BKXBlQu6
 L7FjOxIDoAOTIwAUu4B/R0kLUMDjK60GA1YKife6KKLosSCkH1dPcNv0sR7mdkO0OqbP
 7/SKoqXSX/jdfdQHoa0ZBUBeQrT+yAld6w99nA1fLLk0tNGZdJpLgcXYqEfX97pgd7A8
 Q798BrI6mrpTAkGVjeSJ8d0po+VUpAvbZ/zpG0a82PdUZ5k/N1gXWKJWiz8TUqQ4CYdh
 hedQ==
X-Gm-Message-State: AOJu0Yzd3Yx32VOCuxbyDH3mOfKqesHJV7OyRIicF8VRI09EsdNpyVPy
 V5vKY8cjoUmAG4GqsXg+80Enq3dnaKcHHzkEfCaujK7EXDgNCYzi1ysCLnLTDVDlj11lmdcze1C
 nkozE
X-Gm-Gg: AR+sD10safKxjmkG2yA+4qnuodV+o38eiRbPiCGwiwBPDiaBtifhpioLpVkdUu+5Oho
 3KBrSNzqJD3GlPmSzdp7ZF5yh2uVdwuovvBzo772AxSAIU8U41S4aHMHRllhH9QhHu2VkHIkzQB
 0PuBvQiwUwFQveuaPF9wvcAy0wUuxvZn5Osd2CH9JBvN7saG6PQ0ZMfgnsa6yt8xGafZkmjzxIb
 L3FUXmAdhasNenpqDY3GQMmEoU4FGJNMHx+biKZpSHUGjt6Za2T+fr01ResvSvzyevN6Wr3pogE
 3+IrL84rAWtYiwvAEiQIDVYj6/xh2hKgJUPAMIt0REJHSEz2Q/dtYumi/34tWgIAijnIAiewvCn
 BKxrW7PS0iQZaotcV7izxgDVoNje0avgIsafKASU9bazEE4v4KHWpcvIEiMBSs6EvT5m17rEysp
 L3Ds3IiM7EY9PlvQlQ99WGlFDNPBO50s+1NN/lvtYLGi3bNe2jkK1g4096z2ITIVa+RsDy2ZtAi
 9ZHNlH4UktZZE73uQaAShQ52oyPkw==
X-Received: by 2002:a17:90b:35d0:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-392ec54600emr4793567a91.9.1786461931593; 
 Tue, 11 Aug 2026 08:25:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14124542f10sm457356c88.11.2026.08.11.08.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:25:31 -0700 (PDT)
Date: Tue, 11 Aug 2026 08:25:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH v11] pile stack and mempool driver
Message-ID: <20260811082528.0d71179d@phoenix.local>
In-Reply-To: <20260811123542.1706761-1-mb@smartsharesystems.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F659AB@smartserver.smartshare.dk>
 <20260811123542.1706761-1-mb@smartsharesystems.com>
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

On Tue, 11 Aug 2026 12:35:41 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Early submission of:
> - A new "pile" stack-like implementation using the Stack API, and
> - an accompanying "pile" mempool driver.
>=20
> For CI test and community feedback.
>=20
> Needless to say, this must be separated into multiple independent
> series of patches.
> And release notes must be added.
> For now, I'm submitting a snapshot of work in progress.
>=20
> The "pile" somewhat resembles the lock-free stack, but operates on
> bulks (arrays) of objects, to significantly reduce linked list
> traversal.
> With the pile's default bulk size of 32 objects, a mempool cache
> flush/refill traverses a linked list of only 16 elements, whereas
> the lock-free stack would traverse a linked list of 512 elements.
>=20
> Some performance numbers from mempool_perf_autotest_2cores, all
> with cache=3D1024 cores=3D2 n_keep=3D32768:
>=20
> start performance test (using ring_mp_mc, with cache)
> n_get_bulk=3D 64 n_put_bulk=3D 64 constant_n=3D0 rate_persec=3D 753985338
> n_get_bulk=3D256 n_put_bulk=3D256 constant_n=3D0 rate_persec=3D 755805913
>=20
> start performance test for lf_stack (with cache)
> n_get_bulk=3D 64 n_put_bulk=3D 64 constant_n=3D0 rate_persec=3D  29132352
> n_get_bulk=3D256 n_put_bulk=3D256 constant_n=3D0 rate_persec=3D  29276708
>=20
> start performance test for pile (with cache)
> n_get_bulk=3D 64 n_put_bulk=3D 64 constant_n=3D0 rate_persec=3D 560159479
> n_get_bulk=3D256 n_put_bulk=3D256 constant_n=3D0 rate_persec=3D 557910933
>=20
> Hat tip to Bruce for bringing attention to the ring not being the
> optimal mempool driver!
>=20
> Note: The GitHub "mini" tests don't include the "pile" mempool driver,
> and are expected to fail.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Right but the 32 bit code fails at run time.

 MEMPOOL: Cache size 250 not divisible by 32, rounding down to 224.
STACK: rte_stack_create(): Pile is not supported on your platform

Should be possible to correct this at compile. Like if pile is not
available on this platform, something else should be the default.

The CI failures indicate places where it is likely to be a problem
for users.
