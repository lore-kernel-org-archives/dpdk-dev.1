Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67F9C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:37:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 035DE402F1;
	Tue,  7 Jul 2026 18:37:00 +0200 (CEST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44]) by mails.dpdk.org (Postfix) with ESMTP id 094FA4025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:36:58 +0200 (CEST)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5aebfa21c62so5330987e87.3
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783442217; cv=none;
 d=google.com; s=arc-20260327;
 b=TFsMqUA39JMtFeWxcrXuf4IBo3nEuqOU7Blk402V8ADjkR7dLV9iXl86w+CQdBy1lK
 0f5wmb7YKkWcrxfYYsFYumhc/rbx96bA2AiPYXMwTnLJ+gUAiqyeFRmlZr6nA4Cn5wmP
 +OJ1gpTukNFWJzEK76lwYXX48FWTSHzl3kbYRRyLyUuvrdRw2KaY9X/Mb/89J0juiAUi
 FS6D7eNJKn/e2qoCsHTtn9t1jneTYx8qoEpiW9UFNBCOK+AUPL2kXRTyqrc4WbNmy4U3
 dOg6B7TeSJFItWkb2sp3IZ8/kYmnCc1Q6ug75QJzHRT2VFmk/5wKSNc/9ALlETtoElg8
 KGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tO5zhVvPrAEEyyIw/Y/06pRRb6XE+CckBVUf5Okh+x4=;
 fh=xTZXzcrmFhPDGplvL0uW+8Rnx/Ix2Eln7dygf5cPCNs=;
 b=aLszW8cznu7lFwC/8aeIxGfiY5TZ88WOAsGnXu5KDQEGZg+7Uk1aVXpCzQOzbbH0+w
 fHuPMzbrl3aupLt2Fj34yxQDe5PdW0Aeu+7Uzc/aIxw6qwztbXhrZZrPF17JLiRqjPRW
 cuvlHaVlYSDlHij7r7uBoEPzXsp1cU1T2BKvg4uqgRhZvmgxx7y1VjezUQhCq9pMJ8iO
 6rOK+w2+xLZxPzCjT7EOAm5xN/UC//gyLjJOarg5JdukZ1cgLRr2GJHglDD1n4pGgjqR
 ww8IW0N7Hn+tg3KxhRv7EVwOZILD40Cnkj+9FsJBkbvW/+o/ecoiylqKyMIblOtM2mQG
 wGUQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783442217; x=1784047017; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tO5zhVvPrAEEyyIw/Y/06pRRb6XE+CckBVUf5Okh+x4=;
 b=AG6clwMbfnjPyM6TNcZ7tz669FIlxAUx7LTH8vsfqXHMf5erO7j8VdcCh/XZfsUUBy
 CP2NrTdOAXPW8fbKgkcelJ8f7orivwKIQcXtXaJVQzrOqUeifPsM+gRtZpecd1BcBLj3
 pXA2l4ZgmPvavdyVgrVjO89sUYkXAGhQQS1E/iuyNHPd0JSI9HnWnmCwOpbaaCT+JfLe
 2TV3MDQNfWI6sZdFtfgULnzhnl5hxkhu2tMZgPxp3xEAjc1ZjyevChq80aNDZH6Mk8hs
 t4ZN8ewvPgPBJAhd2FQMIw8ZiP+PQTkLJSpk5xeUJa1F7weKF4oVvck0vvAfLV320D9j
 piRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442217; x=1784047017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tO5zhVvPrAEEyyIw/Y/06pRRb6XE+CckBVUf5Okh+x4=;
 b=omEUreVAVNb7FR4MktSqCKU0/s/TXQzvmFApEAPgmWGZQpXAeVuAWISsIHiRqAJgbk
 IVQTnXmPimHYWG6l6N+t14tRtJFLWMFJ4dRlbKJoWTzovwv55eZkmTCrcVuWWgEpQswO
 uXg7RBBclLmu2+mLHudP5c+mHDQIpsJ7CC1lVH+tT0WDVqAtdh2fUWRhQo0nM8meFI2v
 nni3JlDFBW1T0EV7kCJhrUn5kMHYupGE74RD1++16Gqj8FFPaIBBwVDuVFTG88/Ve3qV
 VAAcPbl5vH7v+7Ck+ibkZEDEMO7LbhKNLO6ZzJ9YWglhpB1cI8G4yMBcb3bMo9nIPE/0
 pqyw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpc0EJ/KferrX0tYi4b4ku/CFAC5/PyXV6CyWg4WvGX8SaREYcSwUcT02beNVv7cEZnbC0=@dpdk.org
X-Gm-Message-State: AOJu0Yzbc82GIwM7rkDOQdjhjaIjgajP6xFO0dhEgysEMcE4lp3qV5nX
 zxY0MtWr6Wj9LFUTLbhQWoJ/NlFXkN5HOI6bqg8FymrSHlr7gLOAt8nLOEYqX1DVzb4o0bmN1SC
 PS2OLXV13R6CgYXtxZF8/6wsBngDA1qGwUC0P4jmFaufJrlhhjAIGWip/dfk=
X-Gm-Gg: AfdE7cnjBUtu7UhDSxa266OrqvdBTRkqtzLogiQ3Xp3+5skJ9LxANhNQMOQH6wO72ri
 soNH95GgJ4zXNoGl2lEnaUd1blpYAXKCQw82f1NMebODrvOCOFb/6qNTjR20ZVcJiJ7aVHqEN47
 82okMiwd89hhctm5ghNPajUbgyMgQhvZ0RQxxRaIg+Fy2IE+wLyFRirWx09oYXOOwDmSm9sMCbY
 e3Xv2HB7mYh6Msp3WitrCKcWqAj3tpgAYCIltsNtpdEM06R5I/TBk0Lu7bUxkvzWwN80O8hB41e
 5bPcCcz0X1jW2fVC0MQ8GPCPbA0=
X-Received: by 2002:ac2:53ae:0:b0:5ae:c34c:aefe with SMTP id
 2adb3069b0e04-5b007c77c1bmr1123510e87.62.1783442216919; Tue, 07 Jul 2026
 09:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260703072721.18c5987a@phoenix.local>
 <CALuQH+UE2kJdfbny0qLSxB+izFSPTQJXVCwDNbUotrcQL4LYhw@mail.gmail.com>
 <CAJFAV8wWC9VbkDT0tqk+EkZGfxJm1weiV5u=HwQhOk3sC2L4eg@mail.gmail.com>
In-Reply-To: <CAJFAV8wWC9VbkDT0tqk+EkZGfxJm1weiV5u=HwQhOk3sC2L4eg@mail.gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 7 Jul 2026 12:36:44 -0400
X-Gm-Features: AVVi8CdC7FK7-u0a-MUTZosh2-1YVLOtIxBOTkLFO2hE_FWUP-KuB0OnGlgYVEA
Message-ID: <CALuQH+Vz-aHY31ej5G0r3EfFH67hcULNu4d0_vNhnspGEPH0Gg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Stability fixes for GVE
To: David Marchand <david.marchand@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jul 7, 2026 at 12:10=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> On Tue, 7 Jul 2026 at 18:02, Joshua Washington <joshwash@google.com> wrot=
e:
> >
> > >
> > > Better but fails on 32 bit build during post-merge testing
> > > DPDK 26.07.0-rc2
> >
> > Will fix in v3. Is there a way I can test 32-bit compile using
> > test-meson-builds.sh? It doesn't seem to be covered there by default.
> >
>
> You'll need support in your toolchain, but this script does support
> 32-bit compilation.
>
> On debian for example, you'll need (at least):
> dpkg --add-architecture i386
> apt install -y gcc-multilib g++-multilib libnuma-dev:i386

Ah, thanks. I installed the required dependencies to build 32-bit
manually, and the script picked it up automatically as expected.

>
> If you have a personal github account, it is also possible to try your
> changes after enabling github actions in your dpdk fork.
>
>
> --
> David Marchand
>
