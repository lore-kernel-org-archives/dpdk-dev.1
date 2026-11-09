Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C6606A323
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ci9Q86oc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBD404027B;
	Mon,  9 Nov 2026 15:42:05 +0100 (CET)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by mails.dpdk.org (Postfix) with ESMTPS id 7E6E64026E
 for <dev@dpdk.org>; Mon,  9 Nov 2026 15:42:04 +0100 (CET)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-8b335ef6441so6931697b3.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 06:42:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794235323; cv=none;
 d=google.com; s=arc-20260327;
 b=YfPJ7lSX7fK7AKgdHF7x+aCRLroF7PkyEKkPxm18/Twjlm4aGzmB9GS+LbSmQjNOC+
 nvx/evOvKYqWLpQ7xlr+q2Wkk8gJC1z+7v/AOKYzB1VbLaOfvjyaxgI+hscd3KINyHpE
 Pm1OKncCLNIdQOOWR+xKWbcbXkSEhJsvaPs+t6kuvylny/m508L9AJWikvkNZfKOw9WU
 NLb97CHVCxUp92YDLSSD170tuZkjcPZUa152JdL1xCXNZ8r3s0ONp+pujPkPPrPNyNXs
 L4spqU1xX4y1wdmCro4uLU8l7FbgBOrlpbh5zeP8fBiYXTiS0Hpfx0JMaUXzc7JPXItX
 16Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lex3EOtzofQ7NZ834gwvgzP/Qh0/pnglOPrG27yRFEQ=;
 fh=5Zv1g1HlBzy5S1rrP1xcRRdvtz+qWG84K0zX8nLc5ag=;
 b=kRrUFaGagv0mt8XtI2+adUNeWM7cnB29htQUcwDdVK343KshO8UZSc7g8bRFHBbV8O
 zSWLHWjoX5jXNq0jn0kb3fEVnr2BgrKBxqx35JdKgtBbXudEy6w3j2qGIARfoJOu9roq
 /IGb0yhn3H2x6loh0fa03UmgkT5LCCOSM+Qn+jZTCwowzXAmc+lyAeB/K0SHctae1Zwv
 +Cqw5s5Bz0LmXoMpZ8nEY+qM9K6bN96MEGAAx9+wJpd4hnBzfuW2UKmeg4mucXOiojKg
 Zwm93ytTcug0/DtkCcQGfr2TCDoLvF4KB9iAyhYvbyqSL3Appgjmbv4zGScBLGqDmblO
 +S5Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794235323; x=1794840123; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lex3EOtzofQ7NZ834gwvgzP/Qh0/pnglOPrG27yRFEQ=;
 b=ci9Q86ocIjMSRPBvZRhK8AT2vMRkYo0PRqR5ARFOEZWYhVUQwJnJWjIsuVxVH8hd5h
 WsMGQOuIwxd3Lo3/dLHEGJjA6Bk7sTtjEpEGS6UVv9mlu27lGGe6NEu+JTCI4mveecAD
 cdX0TLzRlMvmpp7yF7B3gO/mxwWMwKzzMuhv/z6RDgLh/5OUTmpcu8VgltqkuQrGQns+
 7uqy3+kAFQLOlA7O6t1V0hrduntXy9wysxNEzY0yth2B1CWQzwT+A8/ft2R5Pys6saby
 WJqmucXDA/mIWrGcST4v+jNgGSKikPrKtVNHmfKydl10MOd5aOYHjyD32jbXc9JEcPwV
 4M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794235323; x=1794840123;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lex3EOtzofQ7NZ834gwvgzP/Qh0/pnglOPrG27yRFEQ=;
 b=OskCCB3x+8lsSAxxYTtGXmzOlkWKLwBFh4mEe0lkaqy9BDyWRLQAdUFfylclaRG8se
 2aJAweXqQE20x5Jf8Ma5if3RAygfvvgQ/XFJXbp0CYtkAwWgq43+yy5lotfCNWZlD6bL
 6AVmpIuyjE7FXV1S+x+SOZuZLRrDBDgG96ZqFXUW0vcXlwnSPtwlk5xY9n6zJz/TJSia
 eQcA6alyD5npDakGdPOaDNos0LxhmY4vfYh6SP/OzPJqXVnZfDDAfnR7RAqiScmxiBdj
 9TWhaaPgN+BaQEmH3+k8oHD0oosb1l364HqMWuAKt0U1lus6HTIp0UD4b7zna7Q3RPQN
 kMew==
X-Forwarded-Encrypted: i=1;
 AL+hErGZfebtsi476GQtmL43pG6Xdus7YEGVTUZTd29RQvoTjk6Hy2eMNKHeI08EnYpn1eI7XhY=@dpdk.org
X-Gm-Message-State: APuU4Z8GE9ZzOwnml5RJtYovzHpFjEU+3XCAkaS5wuilJxuq2gecbJqU
 L7lWcUnLhuUewcIhfT8m+IdfwLB0E77WOjIjgAY6md7JZh/hcyMcBIeJxzCQvJ6jXyJG25ChEUA
 PbSfrtmDVo6OWi8MhqQTvhKY8bo3Q4is=
X-Gm-Gg: AYBFou0dWDmM2xx2CWHbDLv0x1sbYZGfhVfSCneOlLx75/8yGRnfafGFPBartRbIF27
 or7tLuSlZ4KkRPOQA4mSS0q/n125tPThyyMOx1Rzu2yFtPLY5R8CwiSkadK2X1nH+CB/Y2bUG4+
 ks0sJ00mpe4d2ViWj9rodXXt6eisDsVpVHXJCwrpqBX/8uQ213vi+uTRClRDNxfQ2PFN0z8yKzF
 pvHpg6TWug9sjC4Wpll5voQ2fJnY4plLx1Vg3bj2jQpQA1PzI3ti+KjEPXXBoI+rgZWqO3jZfWC
 QeCkcTtvzf4Y0jX7HGzY3WcxwgXsLwUCz5Nsh8nI+kyB8T4oDrPKNIcl2jW5DS+sPMrbfwsNyYA
 G5necqiuqPFUkcAU7Dw9RVqJHuNEbC7aWlqsYG1Essv3ghUS4PqtLKkC705rpjlI7wZrnWKQduy
 PTgrC+V+SG/Y9HPDpcf2SC5AmfDQ4YJxVFMBK0AP0bDn29UZBfyYwZM5De/cucDVgW+XWyzmmro
 pAmi66q9SMHkPIyG+XhyJc=
X-Received: by 2002:a05:690c:83:b0:8b1:85ca:9a4 with SMTP id
 00721157ae682-8b36caeb106mr22546667b3.35.1794235323360; Mon, 09 Nov 2026
 06:42:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030051726.898902-1-nkishor@marvell.com>
 <CAOaVG17Zkb+0Tn7VxF8SuGpoULYU_W64vC=KnLM7YCXGGq3+Pg@mail.gmail.com>
 <CALBAE1MQFnyqc5oo+4qM330pFtUVnKVQLZgNdP-_AhTuuYSFXA@mail.gmail.com>
 <20261106092339.064ce3eb@stephen-xps.local>
In-Reply-To: <20261106092339.064ce3eb@stephen-xps.local>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 9 Nov 2026 20:11:36 +0530
X-Gm-Features: AclHuK8WWg-sP_bofB6HLZuSIfpDE24On-KYH9RN_tVy-i_SnqunYhfE3QhbAo4
Message-ID: <CALBAE1MoghyOHinHymtfPRjVkdODNFCgWcHR9gnTd8Lo8yOYuA@mail.gmail.com>
Subject: Re: [PATCH] mempool/cnxk: fix halo enable devarg parsing
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nawal Kishor <nkishor@marvell.com>, dev <dev@dpdk.org>, 
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Thomas Monjalon <thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 1:53=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 5 Nov 2026 22:25:26 +0530
> Jerin Jacob <jerinjacobk@gmail.com> wrote:
>
> > On Fri, Oct 30, 2026 at 10:13=E2=80=AFPM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > one more reason to have common code for boolean flags. there is a big=
ish series to do that
> >
> > Is your series merged? Stephen, Can I make this patch as Superseded?
>
> Not merged, because series was so large and 26.11 was so big.
>
> https://inbox.dpdk.org/dev/20260914054912.755403-1-stephen@networkplumber=
.org/

Since it won't be merged for 26.11. I  am taking this FIX for now.
